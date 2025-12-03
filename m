Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A143D12D6F
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:46:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02F4783FED;
	Wed,  3 Dec 2025 15:46:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=muxen.fr header.i=@muxen.fr header.b="XjjeRV3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FE5483F72; Wed,  3 Dec 2025 11:02:26 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E506783AB8
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 11:02:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.martin@muxen.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9664641BC9;
 Wed,  3 Dec 2025 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muxen.fr; s=gm1;
 t=1764756142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RMiElooD5Wh3Xr0f79Iuxt58phfo7slPbtROoTMh/J4=;
 b=XjjeRV3arweuZ8ik1MNTH3oPVSkd+LZU3OQYDEN4vla616sKG/GDKzw2j8MA7ka3m40YYF
 gUMniZvAkwCXgM6HRXx+egyOF2Teg4iFxidtyWrDAQ/0KrK73gKlseTW0brhhRnP9usE+0
 bzNoQUNpXu0hjk56A08xDBMZsopXpsc2QJec+hq0MdYGz3VcE0X/MAZtI7Q0QpedAAdSMG
 AOM3lSZZ+/Jk4fqrqLUr2l5tZhKt5WQC2SAdoMlkEKLTxMT1mv/U58ClMsI19UPNXBU+Mt
 h8LblpXUB8i+Bt7xvI7ENhfed9n+iSE8DojCIWu3HlSOqo5l0HpAQHIpXa/Txw==
From: William MARTIN <william.martin@muxen.fr>
To: herve codina <herve.codina@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	William MARTIN <william.martin@muxen.fr>
Subject: [PATCH v2] arm: imx: imx8m: soc: Add support for 'boot_device' and
 'boot_instance' environment variablesAdd setup_boot_mode for imx8m
Date: Wed,  3 Dec 2025 11:02:12 +0100
Message-ID: <20251203100212.78546-1-william.martin@muxen.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhirghmucfoteftvffkpfcuoeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrqeenucggtffrrghtthgvrhhnpeethfegiedvieffledutdfggfegvddttdduueelffeitddvhfevgfelkeeikedvvdenucfkphepkedtrdduuddriedvrddufeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkedtrdduuddriedvrddufeehpdhhvghlohepsggrlhhiqdehvddqvddvuddrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrpdhnsggprhgtphhtthhopeejpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgsrggsihgtsehnrggslhgruggvvhdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehusghoohhtqdhimhigsehngihprdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqs
 ghoohhtsehlihhsthhsrdguvghngidruggvpdhrtghpthhtohepfihilhhlihgrmhdrmhgrrhhtihhnsehmuhigvghnrdhfrh
X-GND-Sasl: william.martin@muxen.fr
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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
index 1fe083ae94f..f39f2e90e55 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1472,6 +1472,71 @@ void reset_cpu(void)
 #endif
 
 #if IS_ENABLED(CONFIG_ARCH_MISC_INIT)
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
@@ -1483,6 +1548,8 @@ int arch_misc_init(void)
 			printf("Failed to initialize caam_jr: %d\n", ret);
 	}
 
+	setup_boot_mode();
+
 	return 0;
 }
 #endif
-- 
2.47.3

