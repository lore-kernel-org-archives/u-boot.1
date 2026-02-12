Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BF9EB491C
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 12:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCD283CE3;
	Thu, 12 Feb 2026 13:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=muxen.fr header.i=@muxen.fr header.b="ZN6iT34f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D9AF83CEE; Thu, 12 Feb 2026 09:21:57 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1CC83CBD
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 09:21:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=muxen.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=william.martin@muxen.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F52443B18;
 Thu, 12 Feb 2026 08:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=muxen.fr; s=gm1;
 t=1770884509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=aUBFnEWPooHjlom77ZhsgKAd4E6qI2GXJwaTwe174K8=;
 b=ZN6iT34fWcGpE2uh/76N1EYjDDsriUDKnZylSJTW+fcsKioQlT290CPoOGvwKBeq+xVNW1
 JXnpurqtb805C067QZ4SsoB/6GNZgmqMvjFgbvw1cAxsk+HjqN0o98+pnyobyHwqtO5CQX
 JUgUnMn8X06qi3hWurRRjbmv+PohqdBZXQr9B+TjWbbn2E1C4h+EWqAtsLeLdfkUUxDKmO
 wWkfRQ2C35PAKvEuixEGetuvpBJFUI6AakoiSS7SsbdlhRDZi/nUKLd4RvRdEbKlD8qMDM
 XGb0wIn1yNvGFiwSJhaONBNgwMGS8wprUps36e9M8gGuY5w5yq8UIrsuFfo5Sw==
From: William MARTIN <william.martin@muxen.fr>
To: herve codina <herve.codina@bootlin.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@oss.nxp.com>
Cc: u-boot@lists.denx.de,
	William MARTIN <william.martin@muxen.fr>
Subject: [PATCH v4] arm: imx8m: add boot_device and boot_instance env variables
Date: Thu, 12 Feb 2026 09:21:41 +0100
Message-ID: <20260212082141.15539-1-william.martin@muxen.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: william.martin@muxen.fr
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeghihhllhhirghmucfoteftvffkpfcuoeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrqeenucggtffrrghtthgvrhhnpeethfegiedvieffledutdfggfegvddttdduueelffeitddvhfevgfelkeeikedvvdenucfkphepkedtrdduuddriedvrddufeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkedtrdduuddriedvrddufeehpdhhvghlohepsggrlhhiqdehvddqvddvuddrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpeifihhllhhirghmrdhmrghrthhinhesmhhugigvnhdrfhhrpdhqihgupeelhfehvdeggeefuedukedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepshgsrggsihgtsehnrggslhgruggvvhdrtghomhdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehusghoohhtqdhimhigsehngihprdgtohhmpdhrtghpthhto
 hepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohephigvrdhlihesohhsshdrnhigphdrtghomh
X-GND-State: clean
X-GND-Score: -100
X-Mailman-Approved-At: Thu, 12 Feb 2026 13:44:52 +0100
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

Some SoCs support 'boot_device' and 'boot_instance' environment
variables to select the right boot media during boot command execution.

The i.MX8M SoC doesn't set these variables but provides internally
all the needed information to create them.

Add setup_boot_mode() to arch_misc_init() to populate boot_device
and boot_instance from the boot device reported by the ROM.

Signed-off-by: William MARTIN <william.martin@muxen.fr>
---
v2: rebase

v3: fix boot_instance for mmc
    add second usb

v4: fix flexspi/qspi for IMX8MQ
---
---
 arch/arm/mach-imx/imx8m/soc.c | 76 +++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/soc.c b/arch/arm/mach-imx/imx8m/soc.c
index 1fe083ae94f..87b2d579d01 100644
--- a/arch/arm/mach-imx/imx8m/soc.c
+++ b/arch/arm/mach-imx/imx8m/soc.c
@@ -1472,6 +1472,80 @@ void reset_cpu(void)
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
+		if (IS_ENABLED(CONFIG_IMX8MQ)) {
+			env_set("boot_device", "qspi");
+		} else {
+			env_set("boot_device", "flexspi");
+		}
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
@@ -1483,6 +1557,8 @@ int arch_misc_init(void)
 			printf("Failed to initialize caam_jr: %d\n", ret);
 	}
 
+	setup_boot_mode();
+
 	return 0;
 }
 #endif
-- 
2.47.3

