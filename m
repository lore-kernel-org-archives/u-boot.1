Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1687ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 10:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FE188FFE;
	Tue, 10 Sep 2024 12:13:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MGUwqBYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 872FE88FF9; Tue, 10 Sep 2024 12:13:50 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A261788F47
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 12:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2912D24000D;
 Tue, 10 Sep 2024 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1725963227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PL2HacEmJb0jY7cAlYq3Kmhv3XcDkmdxb2fFmmw5yc0=;
 b=MGUwqBYGJH0jVhcUUgZKXHkr43YC4PjrtniWhTtL+TT4eSNLbPpao+WqtAAs/coYXbFbMR
 qRB57Tc2BJcy0QE4Trt76nPANqaVq5wDMvKKbA7v6lrvkbhnqU7Ec2pV9A80DbxZ14//Qw
 Ov0FJCyoZa0ygTCuk3nBuxkqOvr6CyqsOTw0ZnGIraNxmaT9oMagsBBdHN2a2kue3+Mnsr
 u4QEnNpFXZ/gSV2OizTYT+GQ0YOuW91qww/fhft/G+g++Hv6UH2d2aKIo1JbmcImNjsBkn
 S0Oec1rxHbPa3WtcHysAvJ3O8NOWjrfQxR6GsQsyJZulMweXh/nJeXUGhIbXjg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>
Cc: <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ian Ray <ian.ray@gehealthcare.com>, Marek Vasut <marek.vasut@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/8] imx: power-domain: Describe the i.MX8 MEDIAMIX domain
Date: Tue, 10 Sep 2024 12:13:40 +0200
Message-ID: <20240910101344.110633-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910101344.110633-1-miquel.raynal@bootlin.com>
References: <20240910101344.110633-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
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

Add support for the i.MX8 MEDIAMIX domain which is driving the power
over the whole display/rendering pipeline.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/domain/imx8m-power-domain.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index df5d7d69562..18ed3c93835 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -41,6 +41,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MN_MIPI_A53_DOMAIN			BIT(2)
 
 #define IMX8MP_HSIOMIX_A53_DOMAIN		BIT(19)
+#define IMX8MP_MEDIAMIX_A53_DOMAIN		BIT(12)
 #define IMX8MP_USB2_PHY_A53_DOMAIN		BIT(5)
 #define IMX8MP_USB1_PHY_A53_DOMAIN		BIT(4)
 #define IMX8MP_PCIE_PHY_A53_DOMAIN		BIT(3)
@@ -64,6 +65,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MN_MIPI_SW_Pxx_REQ			BIT(0)
 
 #define IMX8MP_HSIOMIX_Pxx_REQ			BIT(17)
+#define IMX8MP_MEDIAMIX_Pxx_REQ                 BIT(10)
 #define IMX8MP_USB2_PHY_Pxx_REQ			BIT(3)
 #define IMX8MP_USB1_PHY_Pxx_REQ			BIT(2)
 #define IMX8MP_PCIE_PHY_SW_Pxx_REQ		BIT(1)
@@ -82,6 +84,9 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MP_HSIOMIX_PWRDNACKN		BIT(28)
 #define IMX8MP_HSIOMIX_PWRDNREQN		BIT(12)
 
+#define IMX8MP_MEDIAMIX_PWRDNACKN		BIT(30)
+#define IMX8MP_MEDIAMIX_PWRDNREQN		BIT(14)
+
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -102,6 +107,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MP_PGC_PCIE			13
 #define IMX8MP_PGC_USB1			14
 #define IMX8MP_PGC_USB2			15
+#define IMX8MP_PGC_MEDIAMIX		22
 #define IMX8MP_PGC_HSIOMIX		29
 
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
@@ -304,6 +310,17 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 		.pgc = BIT(IMX8MP_PGC_HSIOMIX),
 		.keep_clocks = true,
 	},
+
+	[IMX8MP_POWER_DOMAIN_MEDIAMIX] = {
+		.bits = {
+			.pxx = IMX8MP_MEDIAMIX_Pxx_REQ,
+			.map = IMX8MP_MEDIAMIX_A53_DOMAIN,
+			.hskreq = IMX8MP_MEDIAMIX_PWRDNREQN,
+			.hskack = IMX8MP_MEDIAMIX_PWRDNACKN,
+		},
+		.pgc = BIT(IMX8MP_PGC_MEDIAMIX),
+		.keep_clocks = true,
+	},
 };
 
 static const struct imx_pgc_regs imx8mp_pgc_regs = {
-- 
2.43.0

