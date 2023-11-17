Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0185C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B22874A1;
	Fri, 17 Nov 2023 22:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O8bn3sTn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE543874EB; Fri, 17 Nov 2023 22:49:38 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 1639787252
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 26CDF20B74C1;
 Fri, 17 Nov 2023 13:49:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26CDF20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700257767;
 bh=yIkVSfhFsDeY+ewGXuyT5ZQORuBakNRvi+zq3nMS4X8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O8bn3sTncx2QT1wljI2WDkPLI92aA7N655/OV/zt7ypMiA5P5HYzbpauVJy4SJjjv
 1r/YsC7LoGByuD2I0RP0vyZK4VtyiMktNKQjBfH29XC2LQH4H9zRbhA4hkSJb1HrgS
 E0L/nLF1ThcJa7tfHNwcy3Q+qC/jNWGasIz+NurQ=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de,
	pbrobinson@gmail.com,
	trini@konsulko.com
Subject: [PATCH v4 1/3] net: Additional fixes for dhcp option 209
Date: Fri, 17 Nov 2023 13:49:23 -0800
Message-ID: <20231117214925.138486-2-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
References: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
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

Addresses feedback from latest review:
- Enable option 209 by default
- Set pxelinux_configfile to NULL to avoid potential double free
- change hardcoced 209 to a define

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 cmd/Kconfig | 1 +
 cmd/pxe.c   | 2 ++
 net/bootp.c | 4 ++--
 net/bootp.h | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index df6d71c103f..ae846b204dc 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1842,6 +1842,7 @@ config BOOTP_PXE_CLIENTARCH
 
 config BOOTP_PXE_DHCP_OPTION
 	bool "Request & store 'pxe_configfile' from BOOTP/DHCP server"
+	default y
 	depends on BOOTP_PXE
 
 config BOOTP_VCI_STRING
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 21134eb7a30..9404f445187 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -65,6 +65,8 @@ static int pxe_dhcp_option_path(struct pxe_context *ctx, unsigned long pxefile_a
 	int ret = get_pxe_file(ctx, pxelinux_configfile, pxefile_addr_r);
 
 	free(pxelinux_configfile);
+	/* set to NULL to avoid double-free if DHCP is tried again */
+	pxelinux_configfile = NULL;
 
 	return ret;
 }
diff --git a/net/bootp.c b/net/bootp.c
index 68002909634..24547cf7bfd 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -603,7 +603,7 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
 	*cnt += 1;
 #endif
 	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
-		*e++ = 209;	/* PXELINUX Config File */
+		*e++ = DHCP_OPTION_PXE_CONFIG_FILE;	/* PXELINUX Config File */
 		*cnt += 1;
 	}
 	/* no options, so back up to avoid sending an empty request list */
@@ -914,7 +914,7 @@ static void dhcp_process_options(uchar *popt, uchar *end)
 				net_boot_file_name[size] = 0;
 			}
 			break;
-		case 209:	/* PXELINUX Config File */
+		case DHCP_OPTION_PXE_CONFIG_FILE:	/* PXELINUX Config File */
 			if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION)) {
 				/* In case it has already been allocated when get DHCP Offer packet,
 				 * free first to avoid memory leak.
diff --git a/net/bootp.h b/net/bootp.h
index 4e32b19d424..24b32c73f62 100644
--- a/net/bootp.h
+++ b/net/bootp.h
@@ -91,6 +91,8 @@ typedef enum { INIT,
 #define DHCP_NAK      6
 #define DHCP_RELEASE  7
 
+#define DHCP_OPTION_PXE_CONFIG_FILE	209	/* "ConfigFile" option according to rfc5071 */
+
 /**********************************************************************/
 
 #endif /* __BOOTP_H__ */
-- 
2.42.0

