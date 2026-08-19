Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B763CC5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40C1F808C9;
	Wed, 19 Aug 2026 03:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5BeNwh7K1EUA; Wed, 19 Aug 2026 03:55:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111742;
	bh=ZFutmG7XSG5sRixMuMTht3qRA9qAOunxam0ba5/gBXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SVUYalHvn50qYXzjFydYAAqspdR3tG7Acy9pdeG8y8oMx5qaLRSjBum0xjFscoco2
	 nZ2QCvzyoS/HE7CaqqYqZtlmVPLZHKjL+aK+4EcFpuAifTdbKurkU8ItGwK5C7qOU8
	 ErZcoYIhaXCdqfvnGV9FHuijQCDAD7Dpib0c7AvPnKRhBVWLrGqrD9mc2FoQGS5MB0
	 v0TSIpekbRDr+xA/3XEizrGpoXJ8KlLS4xCj3vJijcRPpC9Y+MONQfddE1WxyUOsqD
	 k2sEoxF0bdOpcROYoC9ihMV0V0w1cZWHOss2XnXwNrAymp0X2OYm0gBPyWlqXRKd6B
	 Jjn4pzgvpy46Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9871980B0A;
	Wed, 19 Aug 2026 03:55:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D80E839E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9C60808C9
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Es2otVFBMZZF for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:55:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=TPaCHT/5
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DA578087B
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:55:39 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so550947b3a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111739; x=1787716539;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZFutmG7XSG5sRixMuMTht3qRA9qAOunxam0ba5/gBXM=;
 b=TPaCHT/5Bf52LsdvPbsFZOIdNBvuUk2g0BbRO2FId+atv06svsb0QTTVKSLR2XgJxR
 vqZxTs4tL9p8n8wdabSXfLxEvjPPlcGXcMVTJdhgbtMfuYd9S3BFPo5H17Egb/I6n+hB
 Gro0r3dO6QeWqNTk/BuBqipjC5TFuz0jm/zD1KvaqtpeUzSgbWCj5RB27u7bbUlkBeGM
 kNBK8NXV0dlUIrqMwM855Lm2STaJWsG3Vw9w1mYqqVxmSbu9Ccf9LcVhKrSfEur0Nn8a
 KBVt4JVX/kITAgQ9oqL2+2TUPKyqWJ8BCDFZeVkQkxngMdkw72SeQui1UcCehRuNBsms
 FzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111739; x=1787716539;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZFutmG7XSG5sRixMuMTht3qRA9qAOunxam0ba5/gBXM=;
 b=HZrjcvxpuKtFIoH8+lj8saYCMusFZJRs69q3eVgjzRldTyeiuOc3Gcd1dSez9IyWzk
 Uik2qtESnCkWMy3CC4ycWGH1At/79OXXKY8yPvzf9zVa9mYEyVzKstIG7fyIuYprr/7l
 tOd4RNbpVmZfJ8L9aB8i9hSoGugoO3s1IMW/i093mVFIqW0UjJ0GK+JQrauqPhNzLitI
 +fHkTQ6xi2p4T9jCFMV878x8o8vE+ZYnDjBetSktE/76Z7RyPe+mweaVBO5hrMJz1EEG
 l6l96f0zyCDyXpX9J9G21yMCJRJxXg9XzSk2dwbSPtxshB1pdxWhAWYBoFfuSOnAptVg
 yZ9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwpBtIHQpEROFtv/0q5VAsvna6ohf6NqeIXIqV1o0H9T7J9IxUXRDM6hkl3C1yMt98y/sD50A=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyFB357SOaNEPQXblEyjg9c4dY1hwGFoKgUtnkU/T9dI8PbzZjW
 bTkh1sl3nKSLt9KQa8GOUeh+WczZRuvxJrvAqb+kB74i+ZjuH+sgGxxrqjJxWV/JT9c=
X-Gm-Gg: AR+sD11SFH94vNGV38+8RKvVtelDmvNJ8SIkGnfW0UxldgwZnuiHdQl5clcTPEQ9XJ7
 isipwPMsskl2CAR9zZ8Iw3/vKhIpHU/F5uYVKc56m2gXZznprrxwMzi3GhmsNqtvshfcb2WGRT+
 CWJ5BWs92GHApNUgnQjmute9TCecBVAnzGpYKBIPJbt1sNw3gEw8b7/YU67CNkWOOBbJlKwi7rs
 SjYUovYQN6F3Rl31nDlD/pdTJumGFYpLMbjvam5WGkF1bvfVJyHWqdW95ovBWoTctRt8KilqeRX
 P/AG62YDzSFdpalweCvqHvlmTYu9ayUiKF/Bw4kC+Ct8o6JrHiumkHRIZXNIPWEFkbdbjXKN3W0
 zodLWH8KgbWFSnNj+GdHYzABlcA0TK3Y0TSu+l3sn7FWMK1DID7y2LOlGijnVOrHYIruAXp2AI3
 3fs5BEqcIw3Om1EPyhrFSY6JKS7YbLnPkgRWhnIgjfdTdxSXQicjfiaxY4LaHmSYmkQroz7WwWD
 dp4wi2arQkkh9xRlRgrNgA1zN17jmTk8pn0/lMv2aFWIXChv+nalPGl8woZPaW6+ma2gBv5USLd
 aVhaJR8cOPFP4U+Ujab1dQ5PvQ==
X-Received: by 2002:a05:6a20:3d06:b0:3c3:9c4e:de3a with SMTP id
 adf61e73a8af0-3cd0107c6bamr3704537637.6.1787111739058; 
 Tue, 18 Aug 2026 20:55:39 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:55:38 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:43 +0800
Subject: [PATCH v9 01/19] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-1-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add logic to determine the current boot device by reading the
SoC's configuration registers, rather than using a hardcoded
default.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
---
v9:
- Enhance detection on booting from SD card.
v5:
- Add blank lines around the switch statement.
v2:
- Use FIELD_GET() to parse boot strap mode.
- Remove comments on hacking. Since the sequence between eMMC
  and SD device is exchanged in the upstream DTS. So it isn't
  a hacking any more.
---
 board/spacemit/k1/spl.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index d749e21a2d57..b70eed14e6ed 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
@@ -22,6 +23,20 @@
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
 
+/* boot mode configs */
+#define BOOT_DEV_FLAG_REG	0xd4282d10
+#define BOOT_PIN_SEL_REG	0xd4282c20
+
+#define BOOT_STRAP_MODE_OFFSET	9
+#define BOOT_STRAP_MODE_MASK	3
+#define BOOT_STRAP_MODE_EMMC	0
+#define BOOT_STRAP_MODE_SPI	1
+#define BOOT_STRAP_MODE_NAND	2
+#define BOOT_STRAP_MODE_SD	3
+
+#define STORAGE_API_P_ADDR	0xc0838498
+#define SDCARD_API_ENTRY	0xffe0a548
+
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
 #define PULL_UP			(6 << 13)       /* bit[15:13] 110 */
@@ -46,6 +61,17 @@ typedef void (*puts_func_t)(const char *s);
 typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
 			       puts_func_t puts);
 
+enum board_boot_mode {
+	BOOT_MODE_NONE = 0,
+	BOOT_MODE_USB = 0x55a,
+	BOOT_MODE_EMMC,
+	BOOT_MODE_NAND,
+	BOOT_MODE_SPI,
+	BOOT_MODE_SD,
+	BOOT_MODE_SHELL = 0x55f,
+	BOOT_MODE_BOOTSTRAP,
+};
+
 struct ddr_cfg {
 	u32     data_rate;
 	u32     cs_num;
@@ -58,6 +84,69 @@ binman_sym_declare(ulong, ddr_fw, size);
 
 char product_name[I2C_BUF_SIZE] = "k1";
 
+u32 read_boot_mode(void)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
+	void __iomem *storage_api = (void __iomem *)STORAGE_API_P_ADDR;
+	u32 mode, sel, ret = 0;
+
+	mode = readl(storage_api);
+	if (mode == SDCARD_API_ENTRY)
+		return BOOT_MODE_SD;
+
+	mode = readl(boot_dev);
+	if (mode == BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
+		sel = FIELD_GET(BOOT_STRAP_MODE_MASK << BOOT_STRAP_MODE_OFFSET,
+				readl(boot_strap));
+		switch (sel) {
+		case BOOT_STRAP_MODE_EMMC:
+			mode = BOOT_MODE_EMMC;
+			break;
+		case BOOT_STRAP_MODE_NAND:
+			mode = BOOT_MODE_NAND;
+			break;
+		case BOOT_STRAP_MODE_SPI:
+			mode = BOOT_MODE_SPI;
+			break;
+		case BOOT_STRAP_MODE_SD:
+		default:
+			mode = BOOT_MODE_SD;
+			break;
+		}
+	}
+
+	switch (mode) {
+	case BOOT_MODE_EMMC:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	case BOOT_MODE_NAND:
+		ret = BOOT_DEVICE_NAND;
+		break;
+	case BOOT_MODE_SPI:
+		ret = BOOT_DEVICE_SPI;
+		break;
+	case BOOT_MODE_USB:
+		ret = BOOT_DEVICE_USB;
+		break;
+	case BOOT_MODE_SD:
+		ret = BOOT_DEVICE_MMC2;
+		break;
+	default:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	}
+
+	return ret;
+}
+
+void write_boot_mode(u32 mode)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+
+	writel(mode, boot_dev);
+}
+
 static void i2c_early_init(void)
 {
 	struct udevice *bus;
@@ -327,8 +416,12 @@ void nor_early_init(void)
 
 void board_init_f(ulong dummy)
 {
+	u32 mode;
 	int ret;
 
+	mode = read_boot_mode();
+	write_boot_mode(mode);
+
 	ret = spl_early_init();
 	if (ret)
 		panic("spl_early_init() failed:%d\n", ret);
@@ -354,7 +447,7 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_SPI;
+	return read_boot_mode();
 }
 
 void spl_board_init(void)

-- 
2.51.0

