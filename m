Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0554E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 18:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424B680708;
	Fri, 10 Jan 2025 19:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="eFL9hgtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C284B80710; Fri, 10 Jan 2025 19:43:11 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::223])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C8980657
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 19:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC0106000A;
 Fri, 10 Jan 2025 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1736534589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmii0KrFJCd7/kp0IPPNfgTNj7dsjuMMgWBgsT1+yZE=;
 b=eFL9hgttWKbvJD8m3PnvacNar48ZIfXfW4OFZ1RkgWSa/KlF3QJlzJjCiV2t8lw/21LNK+
 eoZQxLH7l1urXkr28q5lJ3voxhRd6PPoug7F9/A4UcHTlObTEKbqXcHe01SUaKK10LUhc0
 +Zc7dlBIg9jJi+OZ5j7r4yZnglW02rYiUZRwGOVqCcn8KPwezDkPAEsLy+/WcW6nxKPOcV
 fzVv/blaSew6lw7URp43DldMkmNG4eaZyAFBOhrH3NIttxTYsQLp4YvVfX895ctBGsNasp
 RSqE1hk6C+kNp+120GbgFoo9J734GbrvX1P6/m+1qu+L0BVDO4SbnDtfcxM+rQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Jan 2025 19:43:05 +0100
Subject: [PATCH v3 08/13] imx: power-domain: Describe the i.MX8 MEDIAMIX domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-ge-mainline-display-support-v3-8-d2c0acea6feb@bootlin.com>
References: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
In-Reply-To: <20250110-ge-mainline-display-support-v3-0-d2c0acea6feb@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
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
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/power/domain/imx8m-power-domain.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index c22fbe60675e96a628f205d10a71b66c7b33ef00..e54ba5d9a5476f678fb48fb16e7217b031acd78a 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -40,6 +40,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MN_MIPI_A53_DOMAIN			BIT(2)
 
 #define IMX8MP_HSIOMIX_A53_DOMAIN		BIT(19)
+#define IMX8MP_MEDIAMIX_A53_DOMAIN		BIT(12)
 #define IMX8MP_USB2_PHY_A53_DOMAIN		BIT(5)
 #define IMX8MP_USB1_PHY_A53_DOMAIN		BIT(4)
 #define IMX8MP_PCIE_PHY_A53_DOMAIN		BIT(3)
@@ -63,6 +64,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MN_MIPI_SW_Pxx_REQ			BIT(0)
 
 #define IMX8MP_HSIOMIX_Pxx_REQ			BIT(17)
+#define IMX8MP_MEDIAMIX_Pxx_REQ                 BIT(10)
 #define IMX8MP_USB2_PHY_Pxx_REQ			BIT(3)
 #define IMX8MP_USB1_PHY_Pxx_REQ			BIT(2)
 #define IMX8MP_PCIE_PHY_SW_Pxx_REQ		BIT(1)
@@ -81,6 +83,9 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MP_HSIOMIX_PWRDNACKN		BIT(28)
 #define IMX8MP_HSIOMIX_PWRDNREQN		BIT(12)
 
+#define IMX8MP_MEDIAMIX_PWRDNACKN		BIT(30)
+#define IMX8MP_MEDIAMIX_PWRDNREQN		BIT(14)
+
 /*
  * The PGC offset values in Reference Manual
  * (Rev. 1, 01/2018 and the older ones) GPC chapter's
@@ -101,6 +106,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define IMX8MP_PGC_PCIE			13
 #define IMX8MP_PGC_USB1			14
 #define IMX8MP_PGC_USB2			15
+#define IMX8MP_PGC_MEDIAMIX		22
 #define IMX8MP_PGC_HSIOMIX		29
 
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
@@ -303,6 +309,17 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
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
2.47.0

