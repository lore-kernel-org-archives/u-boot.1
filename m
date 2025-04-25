Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F61C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 14:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CBFF82161;
	Fri, 25 Apr 2025 16:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZG7p6e20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C348059A; Fri, 25 Apr 2025 08:49:55 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B910981F0D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 08:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9830B43971;
 Fri, 25 Apr 2025 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1745563791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOYCDnxufSt3TJlH2hOyNVdUdFbqr0JCJ9/aEHLEcX4=;
 b=ZG7p6e20btRBsdA+54lUroXDmS9O9v8G6ry8eQ65Anu8fL8FEQRIYNYre5x2vWKlcSchIl
 CVe/Gu06uv5sxbdga1kaoy7+ZfSS6iAsyYTDE9coDrOi7sLeR1Wm6xjsfQsJ84EcGsAf6J
 bKjiw7wvCHHhMVWfFkqYKQcsjV+lkv9ETQBc1DDevhVULEk8JJf5ASIi2Z+4m0VstOe8XR
 D9E5V8V9c7BhlDMCu7tqPudwXcRcd8ZuUwAgPG8a877yb/LxslqwFYGJtu9+bt1Pgx/yKz
 hnkOIEM+Mye4jqzSQ6pUwQmIkKtAVSlMBxy3+zwGYi24umUOfVdjizaXz6W9xQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 25 Apr 2025 08:49:33 +0200
Subject: [PATCH 2/2] imx: power-domain: Enable refcounting on imx8mp
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-ge-ian-display-support-v1-2-8a7a0fe75023@bootlin.com>
References: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
In-Reply-To: <20250425-ge-ian-display-support-v1-0-8a7a0fe75023@bootlin.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Heiko Schocher <hs@denx.de>, Fabio Estevam <festevam@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.15-dev
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheduieeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelgfehvdduieefieeikeffgffggfdttdeugeffieetheeuleelfeehffdtffetveenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrdegvddrgeeingdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopehnqdhfrhgrnhgtihhssehtihdrtghomhdprhgtphhtthhopeifrdgvghhorhhovhesphhhhihtvggtrdguvgdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesuggvnhigrdguvgdprhgtphhtthhopehmihhquhgvlhdrr
 hgrhihnrghlsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepjhhhkedtrdgthhhunhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepshgrmhhuvghlrdhhohhllhgrnhgusehsihhfihhvvgdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Fri, 25 Apr 2025 16:09:21 +0200
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

Prevent enabling/disabling multiple times the same power domain to avoid
breakages due to the same power domains being referenced several times
by different device nodes.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/domain/imx8m-power-domain.c | 4 ++++
 drivers/power/domain/imx8mp-hsiomix.c     | 4 ++++
 drivers/power/domain/imx8mp-mediamix.c    | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index e54ba5d9a5476f678fb48fb16e7217b031acd78a..b44aae78e6de9733e1e53bbec80f54562487a76b 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -506,8 +506,12 @@ static int imx8m_power_domain_bind(struct udevice *dev)
 static int imx8m_power_domain_probe(struct udevice *dev)
 {
 	struct imx8m_power_domain_plat *pdata = dev_get_plat(dev);
+	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
 	int ret;
 
+	/* Every subdomain has its own device node */
+	plat->subdomains = 1;
+
 	/* Nothing to do for non-"power-domain" driver instances. */
 	if (!strstr(dev->name, "power-domain"))
 		return 0;
diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index 455ad53ef525e18ae45068fa5d8c2be8a1b79335..1ca43880ef56a03ae10e70f7e260022acc447dbb 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -201,8 +201,12 @@ int imx8mp_hsiomix_bind(struct udevice *dev)
 static int imx8mp_hsiomix_probe(struct udevice *dev)
 {
 	struct imx8mp_hsiomix_priv *priv = dev_get_priv(dev);
+	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
 	int ret;
 
+	/* Definitions are in imx8mp-power.h */
+	plat->subdomains = 5;
+
 	priv->base = dev_read_addr_ptr(dev);
 
 	ret = clk_get_by_name(dev, "usb", &priv->clk_usb);
diff --git a/drivers/power/domain/imx8mp-mediamix.c b/drivers/power/domain/imx8mp-mediamix.c
index 78c32ca3d3a87febdefd5d128d39d817674b8d32..504c22f7d3631363d76eb21e43afd854258d4ea5 100644
--- a/drivers/power/domain/imx8mp-mediamix.c
+++ b/drivers/power/domain/imx8mp-mediamix.c
@@ -143,9 +143,13 @@ static int imx8mp_mediamix_bind(struct udevice *dev)
 
 static int imx8mp_mediamix_probe(struct udevice *dev)
 {
+	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
 	struct imx8mp_mediamix_priv *priv = dev_get_priv(dev);
 	int ret;
 
+	/* Definitions are in imx8mp-power.h */
+	plat->subdomains = 9;
+
 	priv->base = dev_read_addr_ptr(dev);
 
 	ret = clk_get_by_name(dev, "apb", &priv->clk_apb);

-- 
2.48.1

