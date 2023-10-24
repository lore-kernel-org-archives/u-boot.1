Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EBAC25B67
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 00:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1063D874BD;
	Tue, 24 Oct 2023 02:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FiDbjcCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299EF87951; Tue, 24 Oct 2023 02:22:05 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 5F10587046
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 02:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 22A3220B74C1;
 Mon, 23 Oct 2023 17:22:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22A3220B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1698106920;
 bh=oJ39v1+C+Dm4CDqikNKOeUtrYWPkB2dAkblsStSEzi4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FiDbjcCejyFR6yjxD7jLCyuDxG+SdZQXrhLd0RLdpdojozJ75gdlqhbTM4PSRvMHa
 mz9JE+fnho1fzEz5+jxwh62s9lOxj95vbcF0bfb4M1dSvA7ejlu5hEX3sqiD2UJUPb
 063xy4BAk5bFX1vdb1WmcVg6XmcVmacH3pyOCTYM=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org
Subject: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
Date: Mon, 23 Oct 2023 17:21:57 -0700
Message-Id: <20231024002159.74477-2-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
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
index 5bc0a92d57..adbb1a6187 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
 	default 0x15 if ARM
 	default 0x0 if X86
 
+config BOOTP_PXE_DHCP_OPTION
+	bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
+	depends on BOOTP_PXE
+
 config BOOTP_VCI_STRING
 	string
 	depends on CMD_BOOTP
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 704589702f..9404f44518 100644
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
index 7b0f45e18a..6800290963 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -26,6 +26,7 @@
 #ifdef CONFIG_BOOTP_RANDOM_DELAY
 #include "net_rand.h"
 #endif
+#include <malloc.h>
 
 #define BOOTP_VENDOR_MAGIC	0x63825363	/* RFC1048 Magic Cookie */
 
@@ -601,6 +602,10 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
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
@@ -909,6 +914,22 @@ static void dhcp_process_options(uchar *popt, uchar *end)
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

