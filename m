Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05439CE8D69
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 17:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EEF8842ED;
	Fri, 14 Nov 2025 18:51:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=muxen.fr header.i=@muxen.fr header.b="Zds4yF95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE0884118; Fri, 14 Nov 2025 15:30:27 +0100 (CET)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58FBB83F54
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.martin@muxen.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id ECF58441AA;
 Fri, 14 Nov 2025 14:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muxen.fr; s=gm1;
 t=1763130623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5t4x9aoaNkIJOOlNXj0vkcGL+nG0ktltEdvf0ihdV1w=;
 b=Zds4yF95jsnrCnf9t3UDgHRHld6zeU3BF9mnUA6+fQLwYkNuMIbAd2GnH0Oz9FLbENphZu
 v1qxlUMmxaEs6r8/bkWxRKk2w6ipXk8gPWINi0H36Ye3RWcpo+g1Vrsg9CDGEbWGDWBpJO
 7jCyzN4xiCAu+GdXMqFkJWd5DrNPtqSSoDrxadaJkAz6DlpIOAr44YyOh1ECUXRNI60AnM
 Zw7ZKwqWG1jQG/63rLUviaulMgIfSXPrK2KWnwZ67Guf4FoKndpcOH1FtBwVIOBxTmRXzu
 cXN+aUWdI98sd5m5+ONrdVuU0kg6mPwDXU3YDGXGiNQo6VrOxlXGVGpGVIReCA==
From: William MARTIN <william.martin@muxen.fr>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Herve CODINA <herve.codina@bootlin.com>, u-boot@lists.denx.de,
 William MARTIN <william.martin@muxen.fr>
Subject: [PATCH] arm: imx: imx8m: soc: Add support for 'boot_device' and
 'boot_instance' environment variables
Date: Fri, 14 Nov 2025 15:29:59 +0100
Message-ID: <20251114142959.88459-1-william.martin@muxen.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddttdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhirghmucfoteftvffkpfcuoeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrqeenucggtffrrghtthgvrhhnpeethfegiedvieffledutdfggfegvddttdduueelffeitddvhfevgfelkeeikedvvdenucfkphepkedtrdduuddriedvrddufeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkedtrdduuddriedvrddufeehpdhhvghlohepsggrlhhiqdehvddqvddvuddrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepshgsrggsihgtseguvghngidruggvpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhgsohhothdqihhmgiesnhigphdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehuqdgsohhot
 heslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhr
X-GND-Sasl: william.martin@muxen.fr
X-Mailman-Approved-At: Fri, 14 Nov 2025 18:51:51 +0100
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

Some SoCs have supports for 'boot_device' and 'boot_instance' environment
variable. Those variables help to choose the right boot media during the
execution of the boot command.

The i.MX8M SoC doesn't have support for those variables but provides
internally all the needed information to create those variables.

Fill this lack adding support for those variables in the i.MX8M SoC.

Signed-off-by: William MARTIN <william.martin@muxen.fr>
---
 arch/arm/mach-imx/imx8m/soc.c | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 85dc8b51a14..66c2cddf3bc 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1471,6 +1471,71 @@ void reset_cpu(void)
 #endif
 
 #if defined(CONFIG_ARCH_MISC_INIT)
+static void setup_boot_mode(void)
+{
+	enum boot_device dev = get_boot_device();
+
+	log_debug("setup_boot_mode = %u\n", dev);
+
+	switch (dev) {
+	case USB_BOOT:
+		env_set("boot_device", "usb");
+		env_set("boot_instance", "0");
+		break;
+
+	case QSPI_BOOT:
+		env_set("boot_device", "spi-nand");
+		env_set("boot_instance", "0");
+		break;
+
+	case SPI_NOR_BOOT:
+		env_set("boot_device", "nor");
+		env_set("boot_instance", "0");
+		break;
+
+	case NAND_BOOT:
+		env_set("boot_device", "nand");
+		env_set("boot_instance", "0");
+		break;
+
+	case SD1_BOOT:
+		env_set("boot_device", "sdcard");
+		env_set("boot_instance", "1");
+		break;
+
+	case SD2_BOOT:
+		env_set("boot_device", "sdcard");
+		env_set("boot_instance", "2");
+		break;
+
+	case SD3_BOOT:
+		env_set("boot_device", "sdcard");
+		env_set("boot_instance", "3");
+		break;
+
+	case MMC1_BOOT:
+		env_set("boot_device", "mmc");
+		env_set("boot_instance", "1");
+		break;
+
+	case MMC2_BOOT:
+		env_set("boot_device", "mmc");
+		env_set("boot_instance", "2");
+		break;
+
+	case MMC3_BOOT:
+		env_set("boot_device", "mmc");
+		env_set("boot_instance", "3");
+		break;
+
+	default:
+		env_set("boot_device", "invalid");
+		env_set("boot_instance", "");
+		log_err("unexpected boot mode = %x\n", dev);
+		break;
+	}
+}
+
 int arch_misc_init(void)
 {
 	if (IS_ENABLED(CONFIG_FSL_CAAM)) {
@@ -1482,6 +1547,8 @@ int arch_misc_init(void)
 			printf("Failed to initialize caam_jr: %d\n", ret);
 	}
 
+	setup_boot_mode();
+
 	return 0;
 }
 #endif
-- 
2.47.3

