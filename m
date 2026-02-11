Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94B4E9E30C
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E7E82BF2;
	Wed, 11 Feb 2026 14:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=muxen.fr header.i=@muxen.fr header.b="VDSAvaQx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C749A83CE3; Wed, 11 Feb 2026 11:31:21 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C23D82BF2
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 11:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.martin@muxen.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 176C643384;
 Wed, 11 Feb 2026 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muxen.fr; s=gm1;
 t=1770805879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tPiJVSHd7nNSlX968SRnU5sK34q3Npnh/QLMsdtByHE=;
 b=VDSAvaQxdsUkm9GSAXpkXwjpmRdyPs5vdSaOTB0peuMwhBAFGVAxvGNDXfMhEJNlSbKpgw
 JQlmY9JEbLQgsgIAuPtiGnvb/7+zN88vvUYjBoklhYNZHYcIMjzeuTxCvmAXOF6pkzTwV6
 iFUiYL4rl8cilvibQS4rtPqznmcM8D8DMSVlmUut4zeFtMg+LXyUMDqz7XaDppJg9IPlpQ
 Tdveiu7hRFHHnn8n+DHLAuXC45jmwA2z5nfZIcmGOjaQgwsLwiCDS3B0LrrYa1NQ4ktT9h
 HYy9VwKINarNN8oV9KpvreJC3J4ZNd9dcCYKIMBkqcz30nCkYkuWkIRyGJkfUQ==
From: William MARTIN <william.martin@muxen.fr>
To: herve codina <herve.codina@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@oss.nxp.com>
Cc: u-boot@lists.denx.de,
	William MARTIN <william.martin@muxen.fr>
Subject: [PATCH v3] arm: imx8m: add boot_device and boot_instance env variables
Date: Wed, 11 Feb 2026 11:31:09 +0100
Message-ID: <20260211103109.92178-1-william.martin@muxen.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: william.martin@muxen.fr
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhirghmucfoteftvffkpfcuoeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrqeenucggtffrrghtthgvrhhnpeethfegiedvieffledutdfggfegvddttdduueelffeitddvhfevgfelkeeikedvvdenucfkphepkedtrdduuddriedvrddufeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkedtrdduuddriedvrddufeehpdhhvghlohepsggrlhhiqdehvddqvddvuddrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrpdhqihgupedujeeiveeigeeffeekgedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgsrggsihgtsehnrggslhgruggvvhdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehusghoohhtqdhimhigsehngihprdgtohhmpdhrtghpthhto
 hepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohephigvrdhlihesohhsshdrnhigphdrtghomh
X-GND-State: clean
X-GND-Score: -100
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:54:02 +0100
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
 arch/arm/mach-imx/imx8m/soc.c | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 1fe083ae94f..498b565183b 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1472,6 +1472,76 @@ void reset_cpu(void)
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
+	case USB2_BOOT:
+		env_set("boot_device", "usb");
+		env_set("boot_instance", "1");
+		break;
+
+	case QSPI_BOOT:
+		env_set("boot_device", "flexspi");
+		env_set("boot_instance", "0");
+		break;
+
+	case SPI_NOR_BOOT:
+		env_set("boot_device", "spi");
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
+		env_set("boot_instance", "0");
+		break;
+
+	case SD2_BOOT:
+		env_set("boot_device", "sdcard");
+		env_set("boot_instance", "1");
+		break;
+
+	case SD3_BOOT:
+		env_set("boot_device", "sdcard");
+		env_set("boot_instance", "2");
+		break;
+
+	case MMC1_BOOT:
+		env_set("boot_device", "mmc");
+		env_set("boot_instance", "0");
+		break;
+
+	case MMC2_BOOT:
+		env_set("boot_device", "mmc");
+		env_set("boot_instance", "1");
+		break;
+
+	case MMC3_BOOT:
+		env_set("boot_device", "mmc");
+		env_set("boot_instance", "2");
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
@@ -1483,6 +1553,8 @@ int arch_misc_init(void)
 			printf("Failed to initialize caam_jr: %d\n", ret);
 	}
 
+	setup_boot_mode();
+
 	return 0;
 }
 #endif
-- 
2.47.3

