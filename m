Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A85C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 10:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B16688382E;
	Tue, 22 Jul 2025 12:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="pwHP3BKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC6483253; Tue, 22 Jul 2025 12:40:20 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEDA7837E4
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:40:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2D4F5C7604; Tue, 22 Jul 2025 12:40:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1753180818; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=K//nj+1xTTD6Zt5AENWrll/3gwM5dEGEFmDfXmdhzEQ=;
 b=pwHP3BKZOWUIZVcVBshPPFFvKhUOol+59oqPXeU6J4gozO5ecu9hVw6+DsZg0g/l4OGkhP
 J9aDi6Yd/1XxOdLK5wM7JqA819VRXtC5G6mFUOfYQ+C4F3VXcYYbY9Jci4JvddEackrUip
 5OsUuN3S8in1cppZIaU6iqWKvq9AFvYWYzGg0XG622qtDm9BnqeDxO8IB/lbC2JE9n/PK7
 mQui4KInJiSkyxeqhh0KOmNX7OoDMT0+7DfXlG2TRM9RlHTryohQ9vZ2QybAmYiwRcLCgB
 m86m3iqpM5PGBe7fwkQeaMRNsGMDGYNtr8PA2pye+xdll/UG9tWcheKoh4la9g==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 2/2] configs: imx6dl_sielaff: Set CONFIG_SDP_LOADADDR to
 fix SDP boot
Date: Tue, 22 Jul 2025 12:39:11 +0200
Message-ID: <20250722103915.105561-2-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722103915.105561-1-frieder@fris.de>
References: <20250722103915.105561-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

We need to set CONFIG_SDP_LOADADDR to a reasonable value in order
to successfully load the U-Boot proper image in SPL via SDP.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes for v2:
* none
---
 configs/imx6dl_sielaff_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx6dl_sielaff_defconfig b/configs/imx6dl_sielaff_defconfig
index aa4f01f0e5a..a4271ea071a 100644
--- a/configs/imx6dl_sielaff_defconfig
+++ b/configs/imx6dl_sielaff_defconfig
@@ -115,5 +115,6 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x17ffffc0
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
-- 
2.50.1

