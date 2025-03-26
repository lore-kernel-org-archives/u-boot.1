Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E67C3600E
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849C881F0D;
	Thu, 27 Mar 2025 05:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EqL08CpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F706803CC; Wed, 26 Mar 2025 16:01:43 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DDB881951
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFDB9442B8;
 Wed, 26 Mar 2025 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743001297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKQo5J/L2BuaNnCJP+anpJSykkpEvPmjCVJ2YyNDsWg=;
 b=EqL08CpFohxlmzhwN+htzABftwN1Oyb9QUVhBxa32QMH6hgu5ShEd6cfiUtvle0VhvFMHQ
 ZUeWgxCsvMBIvIChlaqtCgWIXT8YH71axy4WBTw5NomcHOEesgAnOL74h5t0r3k+OXSl+e
 DL7UNF9sQvbIQ6J0/cpLPLUktETB3IVyabxRIZmh8jkQTAtnbaUYnQ6mPr6e2640xJ4hCZ
 zdOBEAVDEVgwoLwHEzUOhHdoMnjbl7HjRPPktRaLGJOlofVSHWkKoRrlggWh9cliS51TNW
 LPiRueLle684nUsXZUu+UNlTzBd6B6rRh0vdlueVinzPCDv79qaF6DIMbUUaNw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Wed, 26 Mar 2025 16:00:52 +0100
Subject: [PATCH v5 08/12] imx: power-domain: Describe the i.MX8 MEDIAMIX domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-ge-mainline-display-support-v5-8-ea4bc3fc9bca@bootlin.com>
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
In-Reply-To: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Anatolij Gustschin <agust@denx.de>, 
 Fabio Estevm <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Mario Six <mario.six@gdsys.cc>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Ian Ray <ian.ray@gehealthcare.com>, 
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedukedprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepmhgrrhhiohdrshhigiesghgushihshdrtggtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuggrrhhiohdrsghinhgrtggthhhisegrmhgrrhhulhgrshholhhuthhiohhnshdrtghomhdprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhto
 hepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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
2.48.1

