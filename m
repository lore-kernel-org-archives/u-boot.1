Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A3EC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 18:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44BCB8883A;
	Mon, 29 Apr 2024 20:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF8F87617; Mon, 29 Apr 2024 20:35:14 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 6E4DE875B9
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 20:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 814BA210FBA4;
 Mon, 29 Apr 2024 11:35:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 814BA210FBA4
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Sean Edmond <seanedmond@microsoft.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Charles Hardin <ckhardin@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 1/3] net: Enhancements for dhcp option 209
Date: Mon, 29 Apr 2024 11:33:56 -0700
Message-ID: <20240429183449.2284935-2-seanedmond@microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240429183449.2284935-1-seanedmond@microsoft.com>
References: <20240429183449.2284935-1-seanedmond@microsoft.com>
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

- Enable option 209 by default
- Set pxelinux_configfile to NULL to avoid potential double free
- change hardcoded 209 to a define

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>

---

Changes in v7:
- Reword this commit

Changes in v6:
- Reword this commit

Changes in v4:
- rebase master and resolve conflicts
- default y for BOOTP_PXE_DHCP_OPTION (feedback from review)
- change commit description for this patch (this is now
  an enhancement patch)

Changes in v3:
- add define for option 209 and rfc5071 reference

 cmd/Kconfig | 1 +
 cmd/pxe.c   | 2 ++
 net/bootp.c | 4 ++--
 net/bootp.h | 2 ++
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c182d73ddbd..54c4ab8570c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1898,6 +1898,7 @@ config BOOTP_PXE_CLIENTARCH
 
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
index c15472f5d37..b9e3cccb4f9 100644
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
@@ -922,7 +922,7 @@ static void dhcp_process_options(uchar *popt, uchar *end)
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

