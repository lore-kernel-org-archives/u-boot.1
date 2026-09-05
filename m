Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAC4C624D6
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B5CE40BD5;
	Sat,  5 Sep 2026 09:13:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UBcd84kBcsPg; Sat,  5 Sep 2026 09:13:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CBB4C40B9E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599630;
	b=SKyD9vSZ4ZacbMrOgRSsNVIJ/IXZ9uWhDKzs+KIrpX2yjxVzFX2nLPMniC8HE5m35e8j
	 3TM8FxvfcBe6Sha5yo5W+jtUzH+0HooL8Jnb/IjNgWd7l+GueAW48tAUHuP3hkizDv/wo
	 qrAY09RLT9qPC0dJtSazGthIUq8+NvjEYIlFiQmPZOL8MSV8JvAo6bod+PKFtRdbuJrO3
	 Lg+PVhwsnIOUUclsgbjwwVk2IktNsVEqWmKJRDg/pDA8kCUUrheNlN07XM520NPLdnqxz
	 4HpUo/Ax/RSk3gmryDYV/0zX6l/+0uMLO5AbAApfgcMdD8ZoKEqNDd2koGmv0BkOhNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
	b=WrafFWlo5LwYwKUm7Bt+YKuUKXEWBOYzQn16IhKuWTR1ARN4KIt1VydUMeT06X/39p2m
	 vHPS0uqUqRD7N1k3DWaS0mb1oVFpmlYDtsij9TfiQ2gGN2+gDrnlhwgHzYT6dIjgqb8vn
	 zrswEYIJqybBj++I3RDKggTzPpbn79OLO1+gi5eoAsHgPVN1dsRQviRg3juJ3PAFFRn70
	 nAdjo9+s6L8KdNMnKTZ6gt6cQp4CrqqtkeMXncmjdgoxit8YsELVJJW/juilnjtmbWjs/
	 aXgRSQaq1lSPMJ2ZiqT6IRUP0306QN5iXWjI9jshJEBeOEDPPCPJdXPcxHKnahASb0Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599629;
	bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ck0mOGZtfoeR1D8r7D4C/WaH5uEsqxOiw/VeY0nK/YEEx1/0sHbZ7CUEHbZaRsUy2
	 xO3wVR5hG54NBBM/KH8ynKw2krEFL4z6C59nO1GmnuQKZUbq+IDqjUQ+S0ZsGcmVwp
	 rTkVT7ACZ591WrEjvj53mrs02birZ9wU8XsB4Wo5oMyPh3A4phDAEPs6P+ZNcwmEAy
	 hdlm1UyS/xTbig7aw7POOkPYSfAgcwuydtyLXeYX8WJepZNsISypmFeQvsCedhH51w
	 61oIORMhDnPIwDtzsfXQD0fUdWGAM9jvEeUGcXt6AqqauspMeIGn8EDaXs7QZjEpIF
	 PTZ0chJEqgxKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CBB4C40B9E;
	Sat,  5 Sep 2026 09:13:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B8315B88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A997680F85
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0l40PhWytxrH for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:13:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BF30280F83
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599627;
 b=YeJrU8ptNOc8YQmdbTbJRBdlZ/1T9TOXN14zr8hlDqyq/pUVqkpwLSy2p2rnRVb9qMbZ
 bm9+7KBI1r+6wJEWT+kAc3ncNm5C5hCAeLx0YCTJneh2aIw7cJVPFCE2lulhJ280kSeoR
 M8hAWT6MxcVbPbMPDce8AerqzC1IvUTL9yxeleoLWz9zfacLswwf4wXV3EpOGvfnMJS75
 7L5vpYR//0r5EwEBMsv8xAZB06rXBo9LCM8zWAKkAMFkd5E+IIMCoPDTvUti9tHNSxPik
 4fcGmG5ZVSccp+GRXE5/5aIi1dhtdGdeWJWdR2+kGev0z0nQDW4kND3JJ9HWF65l45A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599627;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=hST6CDKbXCbVi1scjS7aI1hhyIyOYL3a9cN7ewyWe+9TyswwGVvtRESBtv4oEMse4g4H
 7n7+h9XJwZ6+0QLQSmkxbxLvnriyeMkWlME3Y6vKHBXMM3GbsTjw+UgAPOPMjqChSiNii
 1eXcXmmQ7K6A2/q5wGk9LG5bAxYYTEN3xgdwdNXIzq0E6DGp3pOSJjwFkW+z+QXQfrY2x
 I9KCT7qNdIH8YzorhC5PqnJsokvW2QELMUUFL0XiWYaFAB9Fkkqw108S78faob92sx1Gd
 jk470zVTXIMwO5EGCgvOmZqO0LEaNBvi5g51J/uWZ71QL7asWkG80i8DYrTdB7x4ryA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=P5BkNAXg; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=P5BkNAXg
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BF30280F83
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:13:46 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84e04df8c46so2070151b3a.2
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599626; x=1789204426;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=P5BkNAXg3v3i2oIP7d2iqrZARvhxQbPL6BATNBVvfdzuCWMJ5Hp5T5hdrakBh4kVTm
 BHh4IKIhLTsKKeUq84iavtXURNjnf5U2GulWgJpiF6soG4F4QbgYJkWENHUwW+yrvvWS
 gNdkCdMTHMzDmRtImpWnERqc5w/NJCm7AL+dO+AQebqSiGXChFJxGos/vKQivhCqjurz
 Jg/ouCx/Qm5I6aF1mngmWoO2gm6Z0Bmt0JdZRvBf2vyxXgBTszreDuyEOhYWpZyFMTFD
 TRHGOe8v3phDAgyf75emdRmMI0Zi0xv5eE5dEPnqhbwuE9IbDNgez1D+DpjcZcFTYF58
 yreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599626; x=1789204426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uOIRR29wLBbzJ2IWnn7GMltFLUNHQ6EeJn+JoRUmRgY=;
 b=Ys3tKR6+dENTFQgku5QXls+NXn/+p4zlvg+rW1B6C8aNunEwczkCKcJ/LZA6tHqyJ4
 IGXvZUNcGscIhW/VsUSGAdrG4yB0Pq5Z09EUPnZZN3rdYwY4xRgqj2J78bt31tmM/PGs
 L58MZwTFc+3JsbAd+F3Zc1SSmMx32m3nZ3KfMgSkh8utazB2zFYPQr+h/yd8nQgtmva/
 J3lkvjYdfStIvw2ZJcKDknRWWKK0l+UxDDvHmY8VWFye8H/hnSXcrqeFC3gkIzjpMsAN
 xEc1J5CIA+AGRCwiF4sf7kxlAAbZncbSjAmPoLRuga9Bx4Fj7wvpYKIw+0zg3rYyGv3t
 vUhA==
X-Forwarded-Encrypted: i=1;
 AKwUvByBQduLt5PxJ8CIsJvuI5uIovH0Smv+Ka0bjJ0nOecAn3cDZeRBcYrA9YhMu9bfWidHua17VkI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l0ME5MWYVVKiMyX9QV8YHgrT4GG5syun1t5jkHItnT9ziD2UjA
 GDLUKdX8TV6DZc93P3ixKP/d5EQnfWKkEksmZsEzbvw3o7TdNksXUDmiFZxQJ+znqks=
X-Gm-Gg: AYBFou1/qzsNJPCt7BXR+LqmTAIaoR/ckrKS8BEmwi5+rlKEnnq3jYaXZdEpS/RgEBj
 NBg0dewKlyUAGiFEfzvM/q2qe2PPwsQv5pBkoaBnF2WUa1k+MPsAS/3RX1ycF4816Hiwmhy9K/i
 PfiS50U6Y3fYB1I25kcV2OPjLiHGQpiBg39l1ToL9PPSc4uHygtF0fypgDSG8NAXXrzQNqFmugS
 Mnc9A4Yy3w+/JBW6rf7O+Bcbtxn+ab9ksZsIYfp5eLNtsAsB4YgoReHJGWvye3ZN7GEAXXwayFs
 LYWVestRbp0wTGf+EZ+GWEtC9RVCuYfOoVKLTSYENEOu6plOMftMQkCR6XEB+btVDytvBRN5llz
 kF1inPB3KAaTV80QGZ9CG9feIkDMcYfxE+shTAQBe4Za7FNYdNVYbU/31k5FtxAfm8hdUbEC03n
 rOo7nxJNa+SqAKGWl8SWDJFD2neuvptW2dGtFYvyEqzQ8ddLIZ15oN7YOnJUP9jb8maJv6VTR39
 eoH59bEWZfwPm1aRWId02l6FRGu8Mc5muJvOtkhNbWKnLIxIcnvwqLafSgrmPdJO7PTcoVPr9Zn
 VmZREgY/X48E5tY7sGSHv9bjwRc6O5F7/ia+
X-Received: by 2002:a05:6a20:7343:b0:3c3:88a5:83e4 with SMTP id
 adf61e73a8af0-3da39ee2718mr15965618637.10.1788599625741; 
 Sat, 05 Sep 2026 02:13:45 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:13:45 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:14 +0800
Subject: [PATCH v11 01/17] spacemit: k1: select boot device via config
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-1-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
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
v11:
- Fix read_boot_mode() on returning both boot mode and boot device.
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
 board/spacemit/k1/spl.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index d749e21a2d57..374922573c98 100644
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
@@ -58,6 +84,47 @@ binman_sym_declare(ulong, ddr_fw, size);
 
 char product_name[I2C_BUF_SIZE] = "k1";
 
+static u32 read_boot_mode(void)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
+	void __iomem *storage_api = (void __iomem *)STORAGE_API_P_ADDR;
+	u32 mode, sel;
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
+	return mode;
+}
+
+static void write_boot_mode(u32 mode)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+
+	writel(mode, boot_dev);
+}
+
 static void i2c_early_init(void)
 {
 	struct udevice *bus;
@@ -327,8 +394,12 @@ void nor_early_init(void)
 
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
@@ -354,7 +425,32 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_SPI;
+	u32 mode;
+	int ret;
+
+	mode = read_boot_mode();
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
 }
 
 void spl_board_init(void)

-- 
2.51.0

