Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446E8CD8CA4
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 12:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B793384704;
	Tue,  9 Jun 2026 14:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcAVneQG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B1984894; Tue,  9 Jun 2026 14:22:25 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D7584874
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 14:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jakobunt@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ee6d32402so3067639f8f.1
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 05:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781007742; x=1781612542; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0usCHZo6UswHDYJhHJvXBDVHuYyFzzvmH03UbjxfBwA=;
 b=YcAVneQGn91Y8bebSftqvqF6H2lLYn1m4ywzHSMX1ZJz+pUoanYhA1cAKs2gy6GbSW
 e9hT0YZf1rSGUuw7wYkOHyXZpUbZ34L52Hkb4kS28W2ejG5gInzEVUmgJFXY7gg8fTN5
 cDPofaIICmJaJI3fKHGh4g5FlGRk+z8bqbS7VvRO4W6xFs2NAzDj3R1EVU22fsdUurwu
 sN0czMCYz6Pc2EC0kkzuNcqjE+yfO8+W/y5bq7uAMyNwLpcxI974+9p+Wmqrrx6WEBEY
 cP4hwX3gr7ljjmMgp7MUS7FXs8PIaZXxFht2ecGmEgQiT2t88YazTtfywraCaoUxMAZn
 XMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781007742; x=1781612542;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0usCHZo6UswHDYJhHJvXBDVHuYyFzzvmH03UbjxfBwA=;
 b=OczcKRN+u6lB/xdQi5pFDXgAWKLQHxnE2ehavAB+w92tQ70QoNyZ4gKIYAYRx2JbMN
 9eHbPmJtqvuMDaqRUjnBJEeidctzYSZT1C907XSdVCDHVutVyidB+GCSOt7nzcUMYhiD
 2iV9s46WtHYJvzh7E5ce6+KzoC8Zr+xnohDm5ImVBNaX6/rhkEArMmLPQS6c+WTyZfKq
 FdR+5vGrRMUFQMiks6TAuJEhQmMpWeIRXiUxGOOCoT6K56zVpm5/r+K216gjGHTXKMgN
 DnZQFI1WqNyBgwan8wkZqJD5/KP7/YH+QI8Q4QRtcugY+L/OVhXuteeqhmXe+J0rjn3F
 wmqQ==
X-Gm-Message-State: AOJu0YyXwp5Ycm5iE2GLBp5hyLOGCuP6kTjl4MDKVT1zbElXKumlMW7I
 3Pyu9mJOg+N5VnRhX1srvz7RPQBqlxILSzK04W8o9w9kxRhfn8GLN/2GlPCkpBXb
X-Gm-Gg: Acq92OHCdZlrnZiEhnCUgHgB4putZ0/MwXq2HTsJOzmt24V7+ChbsST57O9bTic0UCg
 b0x3SJZJ2CjbeGt0UaU8/FXaubOdxT/9CQ4GGnXe1XwWK93est+Mj0rgkfb9SfkhtDBz+oCXil2
 v+2fh0pihGF0dHYK/a1jVVWiG35zCaQfjwtr5IpAWmHImtFrs7TA3DYxIna/Bx4TPPDb9/mGOnh
 xaddGUHOdI4XeNxRU7FJI1Ci28LlWjIiEcHCTdiMDl7dl1X7iNUBywq+zBcRHMS9aLmnxc8hwJg
 dTFZ5E3AC4iu2srghXtKRnt2sNcz84rkYiL3E0/7q9wcQomsBzRPOUinXWO0Px1EnECdJtshi6o
 TVpHpQ/Sihpo+h7TCJUnyv6P4yJcXeBjipkH+gjEmplcAyWeypSfMbrig19Zok2N4e5gLF7CKoN
 dbnUEFjYfgZ7oEMvm+DsZhdxlDlQrlRmGCnZptJXHB6fFsOVSz8duU1ltsWjJ2cB/+z79izTquu
 wVZ/ZxBwmunceW0cw==
X-Received: by 2002:a05:6000:2081:b0:43b:4f86:e985 with SMTP id
 ffacd0b85a97d-4603075ded1mr35670224f8f.33.1781007742010; 
 Tue, 09 Jun 2026 05:22:22 -0700 (PDT)
Received: from [127.0.1.1] (ip092042140082.rev.nessus.at. [92.42.140.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4004sm62352411f8f.9.2026.06.09.05.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:22:21 -0700 (PDT)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
Date: Tue, 09 Jun 2026 14:21:51 +0200
Subject: [PATCH] board: rockchip: set M.2 NVMe PERSTN low in spl_board_init
 on Jaguar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-b4-master_nvme-v1-1-36cb53f74651@cherry.de>
X-B4-Tracking: v=1; b=H4sIAF4FKGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNL3SQT3dzE4pLUovi8stxUXQOLFKNk0xSzRNM0cyWgpoKi1LTMCrC
 B0bEQfnFpUlZqcgnIFKXaWgBUF2vKcgAAAA==
X-Change-ID: 20260609-b4-master_nvme-08d2c5d6a5f7
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 09 Jun 2026 14:38:41 +0200
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

From: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

As it is, an NVMe's built-in PERSTN pull-up fights against the
SoC's built-in pull-down which results in an undefined logic state
on the Samsung SSD 980 and likely others.

Fix that by forcing PERSTN low as early as possible, which is SPL.

Both Linux and U-Boot (via "pci enum") set the pin high later
as needed and the NVMe is detected fine.

Oscillocope shots ("x" means undefined logic state at around 1.5V):

Before:

	3V3     ____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
	PERSTN  ____xxxxxxxxxxxxxxx_|‾‾‾‾‾
	PCICLK  ____∿∿∿∿∿∿∿∿∿∿∿∿___∿∿∿∿∿∿∿
                    ^U-Boot     ^ Linux

After:

	3V3     ____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
	PERSTN  ____x_______________|‾‾‾‾‾
	PCICLK  ____∿∿∿∿∿∿∿∿∿∿∿∿___∿∿∿∿∿∿∿
                    ^U-Boot     ^ Linux

With this change, the power-up sequence conforms to PCIe specs,
except a remaining short PERSTN glitch. The glitch is about 400ms
long. It could be shortened by moving the logic to TPL, but
completely fixing it is only possible in hardware.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
---
 arch/arm/dts/rk3588-jaguar-u-boot.dtsi                |  6 ++++++
 board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/dts/rk3588-jaguar-u-boot.dtsi b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
index dcda4f99d6e..0fbbb50fc5a 100644
--- a/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-jaguar-u-boot.dtsi
@@ -21,6 +21,12 @@
 	bootph-some-ram;
 };
 
+&gpio0 {
+	/* Need gpio0 in SPL for spl_board_init() to control GPIO0_D0 */
+	/* TODO: once we have a U-Boot TPL, use bootph-pre-sram; */
+	bootph-pre-ram;
+};
+
 &gpio2 {
 	bootph-pre-ram;
 	bootph-some-ram;
diff --git a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
index 3f484646701..45fa5d9fae1 100644
--- a/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
+++ b/board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c
@@ -54,6 +54,9 @@ int rockchip_early_misc_init_r(void)
 
 #define GPIO0B7_PU_EN BIT(15)
 
+#define M2_NVME_PERSTN	24 /* GPIO0_D0, PERSTN signal to the M.2 NVMe slot */
+
+/* TODO: once we have a U-Boot TPL, move this to tpl_board_init() */
 void spl_board_init(void)
 {
 	/*
@@ -67,6 +70,22 @@ void spl_board_init(void)
 	 * pull-up.
 	 */
 	struct rk3588_pmu2_ioc * const ioc = (void *)PMU2_IOC_BASE;
+	int ret;
 
 	rk_setreg(&ioc->gpio0b_p, GPIO0B7_PU_EN);
+
+	/*
+	 * Set the M.2 NVMe slot PERSTN to a defined low
+	 * state as early as possible
+	 */
+	ret = gpio_request(M2_NVME_PERSTN, "M2_NVME_PERSTN");
+	if (ret) {
+		log_err("M2_NVME_PERSTN: gpio request failed: %d\n", ret);
+		return;
+	}
+	ret = gpio_direction_output(M2_NVME_PERSTN, 0);
+	if (ret) {
+		log_err("M2_NVME_PERSTN: gpio direction set failed: %d\n", ret);
+		return;
+	}
 }

---
base-commit: 1a8b7ad50aed5f5f0a4ccbfd455233919c097293
change-id: 20260609-b4-master_nvme-08d2c5d6a5f7

Best regards,
--  
Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>

