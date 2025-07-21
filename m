Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7848BC83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 12:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A978A8315B;
	Mon, 21 Jul 2025 14:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="lxqy1BSx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAA0830F6; Mon, 21 Jul 2025 14:52:22 +0200 (CEST)
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 227AD83121
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 14:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 52445C75FC; Mon, 21 Jul 2025 14:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1753102340; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=DLYw8uhzM0I32nGziohXuxzNUI5YbIUJUcbaJ26qrTs=;
 b=lxqy1BSxZfpdm5BNHBfm815A4voDd9YmTiduwJAemC0Pq8YA4VAOYoqup8Tj6194TJg2jJ
 iOTcSWed6PcjkwGG7E66x3zpQJ0r3urig/cUSbU6z829AqebBiESGqDsnjeSkJYL+Q8eU/
 6Ys7WxNECT5LysVgcHdGssp7235T4/M/2bo/fQxsPeI5/soQjT+8UNjoWhnHTjKKcB8JO7
 oS5GxE18l0QRyhpfKlAd8PEmE+9p36y1gewDtq2LdG2iAa6JXd3vgsdQFUOiGK6P281+li
 BmJ3bvRdsjVN8JODAaezDTK749qSDxjtZfJY0dI5blcNT8vG82KrDJAY61/V6g==
From: Frieder Schrempf <frieder@fris.de>
To: u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] configs: imx6dl_sielaff: Set CONFIG_SDP_LOADADDR to fix
 SDP boot
Date: Mon, 21 Jul 2025 14:51:44 +0200
Message-ID: <20250721125148.167020-2-frieder@fris.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721125148.167020-1-frieder@fris.de>
References: <20250721125148.167020-1-frieder@fris.de>
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
 configs/imx6dl_sielaff_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx6dl_sielaff_defconfig b/configs/imx6dl_sielaff_defconfig
index ccd0dcf962c..e8e8a07665a 100644
--- a/configs/imx6dl_sielaff_defconfig
+++ b/configs/imx6dl_sielaff_defconfig
@@ -114,5 +114,6 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x17ffffc0
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
-- 
2.50.1

