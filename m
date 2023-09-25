Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB13CE79A1
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 20:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB90686D57;
	Mon, 25 Sep 2023 22:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gk7+ANWa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C544886BC2; Mon, 25 Sep 2023 22:29:41 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 1B4E086BA6
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 22:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id C3AAC212C81A;
 Mon, 25 Sep 2023 13:29:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C3AAC212C81A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1695673776;
 bh=GrypaYVxIjd+WQNJfz8ysKBooNK1rThpQEbKvQ1IEiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gk7+ANWaaGhKZrtbXNcXvsNsZy/2vL0HtdAdarrQMzQo3etjVnmZoRDBKTEBKFu+2
 wkEytFgBen2cM3kFS+S+09RsfZs2+5kSHr8yqupo1K0PERfLM82i2cz9ohu3EQQrYH
 tQFKKwN3fgBdES6RjTCKlspx+UdWRqeErvUG3oUA=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com,
	rfried.dev@gmail.com
Subject: [PATCH 1/3] net: Get pxe config file from dhcp option 209
Date: Mon, 25 Sep 2023 13:29:33 -0700
Message-Id: <20230925202935.118652-2-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230925202935.118652-1-seanedmond@linux.microsoft.com>
References: <20230925202935.118652-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sean Edmond <seanedmond@microsoft.com>

Allow dhcp server pass pxe config file full path by using option 209

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 cmd/Kconfig |  4 ++++
 cmd/pxe.c   | 10 ++++++++++
 net/bootp.c | 21 +++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43ca10f69c..25c1efc41e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1817,6 +1817,10 @@ config BOOTP_PXE_CLIENTARCH
 	default 0x15 if ARM
 	default 0 if X86
 
+config BOOTP_PXE_DHCP_OPTION
+	bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
+	depends on BOOTP_PXE
+
 config BOOTP_VCI_STRING
 	string
 	depends on CMD_BOOTP
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 677142520b..83c4ed5411 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -65,6 +65,8 @@ static int pxe_dhcp_option_path(struct pxe_context *ctx, unsigned long pxefile_a
 	int ret = get_pxe_file(ctx, pxelinux_configfile, pxefile_addr_r);
 
 	free(pxelinux_configfile);
+	/* set to NULL to avoid double-free if DHCP is tried again */
+	pxelinux_configfile = NULL;
 
 	return ret;
 }
@@ -141,6 +143,14 @@ int pxe_get(ulong pxefile_addr_r, char **bootdirp, ulong *sizep, bool use_ipv6)
 			  env_get("bootfile"), use_ipv6))
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
+	    pxelinux_configfile && !use_ipv6) {
+		if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
+			goto done;
+
+		goto error_exit;
+	}
+
 	if (IS_ENABLED(CONFIG_DHCP6_PXE_DHCP_OPTION) &&
 	    pxelinux_configfile && use_ipv6) {
 		if (pxe_dhcp_option_path(&ctx, pxefile_addr_r) > 0)
diff --git a/net/bootp.c b/net/bootp.c
index 8b1a4ae2ef..013d54c7ed 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -26,6 +26,7 @@
 #ifdef CONFIG_BOOTP_RANDOM_DELAY
 #include "net_rand.h"
 #endif
+#include <malloc.h>
 
 #define BOOTP_VENDOR_MAGIC	0x63825363	/* RFC1048 Magic Cookie */
 
@@ -604,6 +605,10 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
 	*e++  = 42;
 	*cnt += 1;
 #endif
+	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
+		*e++ = 209;	/* PXELINUX Config File */
+		*cnt += 1;
+	}
 	/* no options, so back up to avoid sending an empty request list */
 	if (*cnt == 0)
 		e -= 2;
@@ -912,6 +917,22 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 				net_boot_file_name[size] = 0;
 			}
 			break;
+		case 209:	/* PXELINUX Config File */
+			if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
+				/* In case it has already been allocated when get DHCP Offer packet,
+				 * free first to avoid memory leak.
+				 */
+				if (pxelinux_configfile)
+					free(pxelinux_configfile);
+
+				pxelinux_configfile = (char *)malloc((oplen + 1) * sizeof(char));
+
+				if (pxelinux_configfile)
+					strlcpy(pxelinux_configfile, popt + 2, oplen + 1);
+				else
+					printf("Error: Failed to allocate pxelinux_configfile\n");
+			}
+			break;
 		default:
 #if defined(CONFIG_BOOTP_VENDOREX)
 			if (dhcp_vendorex_proc(popt))
-- 
2.40.0

