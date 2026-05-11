Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34545CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 261B384661;
	Mon, 11 May 2026 22:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Vew3z6u/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3689783FEC; Mon, 11 May 2026 22:13:19 +0200 (CEST)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F054584659
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202605112013162fa95ced69000207fe for <u-boot@lists.denx.de>;
 Mon, 11 May 2026 22:13:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=S3blAinGuKXlX0MLVjRlxpH1CnMw7uRlzUOvByB0bRQ=;
 b=Vew3z6u/OZdrv38pJwBtheS0VGe6YavfR2sg94UnCqPjMUrS7dVCKCn877LfCyOaZuFj5y
 Sth8qEbkrlvkkvb2Owj3bSHPk9Sj+RGN95p2M+eOYr0FqIfaswyVgs9oO5NoHfLX/vNnfbJi
 xkTSlsjixNDVA4YrBBYYDPOVM4Vw494KScQOpcLKtew1FAegTLhellZFVThkAz8uuuVgS2ni
 Schf19jireysSBQQkBlqE7Iq3A5POiEJNVpTfSVsRoFXbHuY8fjscq77GLt1Rn+CLKymYvZr
 9LWbPOnw6togzite31+finASgKYimTXolhWySAqKC2DTRgRKkEBBIjbw==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li <ye.li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Moteen Shah <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Ji Luo <ji.luo@nxp.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/4] fdt: Optionally populate /chosen/reset-reason
Date: Mon, 11 May 2026 22:12:33 +0200
Message-ID: <20260511201235.1066697-5-alexander.sverdlin@siemens.com>
In-Reply-To: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Optionally populate /chosen/reset-reason using get_reset_reason() depending
on CONFIG_RESET_REASON_FDT option. Currently only TI K3 AM62x and AM64x
platforms provide a functional implementation.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 boot/fdt_support.c | 14 ++++++++++++++
 include/init.h     |  3 ++-
 lib/Kconfig        |  9 +++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 1c215e548db..d6745a73d01 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <abuf.h>
 #include <env.h>
+#include <init.h>
 #include <log.h>
 #include <mapmem.h>
 #include <net.h>
@@ -389,6 +390,19 @@ int fdt_chosen(void *fdt)
 		return err;
 	}
 
+	if (IS_ENABLED(CONFIG_RESET_REASON_FDT)) {
+		const char *reset_reason = get_reset_reason();
+
+		if (reset_reason) {
+			err = fdt_setprop_string(fdt, nodeoffset,
+						 "reset-reason",
+						 reset_reason);
+			if (err < 0)
+				printf("WARNING: could not set reset-reason %s.\n",
+				       fdt_strerror(err));
+		}
+	}
+
 	if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
 		/* Inject SMBIOS address when we have a valid address.
 		* This is useful for systems using booti/bootm instead of bootefi.
diff --git a/include/init.h b/include/init.h
index 3ee35130268..62c32ff6a65 100644
--- a/include/init.h
+++ b/include/init.h
@@ -243,7 +243,8 @@ int print_cpuinfo(void);
  * get_reset_reason() - return a string describing the reset cause
  *
  * Platforms can override this weak function to provide the actual
- * reset reason.
+ * reset reason. The returned string may be used to populate
+ * /chosen/reset-reason when CONFIG_RESET_REASON_FDT is enabled.
  *
  * Return: reason string, or NULL if unknown/unsupported
  */
diff --git a/lib/Kconfig b/lib/Kconfig
index 77ebc79e1db..4178e95b94b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1130,6 +1130,15 @@ config VPL_OF_LIBFDT_ASSUME_MASK
 	  0xff means all assumptions are made and any invalid data may cause
 	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
 
+config RESET_REASON_FDT
+	bool "Pass reset reason to OS via device tree"
+	depends on OF_LIBFDT
+	help
+	  When enabled, U-Boot will call get_reset_reason() and store the
+	  result as a string property "reset-reason" in the /chosen node
+	  of the device tree passed to the OS. Platforms must override the
+	  weak get_reset_reason() to provide the actual reason.
+
 menu "System tables"
 	depends on (!EFI_CLIENT && !SYS_COREBOOT) || (ARM && EFI_LOADER)
 
-- 
2.52.0

