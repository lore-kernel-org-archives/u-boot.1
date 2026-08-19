Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14530C5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFF8F80E56;
	Wed, 19 Aug 2026 03:57:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mxsyhk1BGDR9; Wed, 19 Aug 2026 03:57:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111872;
	bh=YrzvRp4xOxKY7DYrKuD6rIRUGDbxHz/i0wcYuPuS8g4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CbouYOtJm0YULCNEry35iMNfffDmS9oLXV+mArXDGK5WRR8qfy6esa+mjucMjS8LU
	 C4mgNLkkWakSSha4gvL18iGcEdr0mSZ/I4VV+9JfynTYsVJEjuL4A16BzqnC1PTUEq
	 QgmTUZrQzFNSh8H3lqxhFYVBHa9XiTsVoEn+U/RfSpyzK3Kpbu7/dRTMPiUwj3rCMK
	 JnWs1REFZpuDVRzIOH4L2l4LRM6JxNE2cFJeqSxjVkM32AEav1mYPCxUI9mgEx4TT3
	 DNRm0+okGaMl+4EnQwC4bEufrb6hbolzRMflck89Ay/cVFjIIPaeAwHVOfkfw1Zh9f
	 OPTdwMJIS3Yuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3BB9080E7E;
	Wed, 19 Aug 2026 03:57:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3360039E
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19B8C80E56
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpE6ALvy_JWp for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=PN8FSFSy
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 248A880E9C
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:49 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so949882a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111869; x=1787716669;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YrzvRp4xOxKY7DYrKuD6rIRUGDbxHz/i0wcYuPuS8g4=;
 b=PN8FSFSyPMPgYRaFFparHNNRK/ixNCPDCRixBMmYKjkoph2difJQ1B0Iorp864Yq0L
 UHlMf3oKi1U2a2Ap8k4KPtiOSJ6uO0jQz3hBh7Uu93M/LVffmkMm8yhvHd6s2qNFRSwZ
 q6HeOxD2LqY1K+DegwlwKV6kSk8e+bvYZ9IfssymWDVQdYABZcWBInewy12yhfqqrQkP
 wSqP4kyg/wxGjsuxZZJKjuFXl1QNXpNomaAIM3Etw+0NRPOZv5ZPLMQh1vCNaVqLcCUG
 ndkEufqqiorHVXydg43SaLz5a7lp20L0lBkeT/NTA8Bgfjvd+eoktIrOXstWOQtoPLBB
 Bvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111869; x=1787716669;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YrzvRp4xOxKY7DYrKuD6rIRUGDbxHz/i0wcYuPuS8g4=;
 b=OhBaUrcxMHPqsQ092tssZ9VspdIbDSc9uXdexGxjEQ0YeL3RA3iXib+BnPBSqQGAU2
 eEATJEhrfFZkjk2q81kEdzSKJT3MxfzZ2HUXuNQfR2XHRF0q3hkiu846wSH188yUMUWP
 PQ8xQZxQojh6zHPfd6q42hjHyaiyTu7KeWNe2MfoAeOeY80u4fp9xK31S+l/6BWqy4fQ
 rYTgylQjjWsBDnANjHUGHZFMaC1oDuldDHWqNQyuSNc+ZilSewQjPHj4LaNOy1U4MiB9
 FmvtLAldxVB5auGbiaJz1FKrt9lJ3wOzajHIRMaNk7IrTt3J5iWGLCUh5roh0Es1swmh
 ik7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQp/jS6tzdJsrExftTU91jN7iByKV+zkE1d5IbBauOnAFyRrZxPMYl1dE1foiwD64HLM+hOlA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzIG9+Cuw8Vat3OMImtmYeBJ93wT1Mwlf1PbULbanOMiBfd3kWW
 FxtCFAs+bMYpBlJQHxLU22195iIlOnr7ObTUPZgYYWXFTNNZVaAOA7jFHal1p3betTc=
X-Gm-Gg: AR+sD12LHnmKCaGwMOflytlmfsLrsgPAVyqzZrlFiuLvE3fsdA5f8CsrQekCZbFIxLA
 i4lknSw4USM7f3ANeK+F4dIg0DQZ6bYQ8tWTQB/SeFtIWqDzXSdUD3TQpK5f9vRdygH3PeXqIhh
 ybvaL3rm78eJmbY50A5XU1X4IP+5lzwzorLV/kXmDge1qyhEL+6fsyVDsCvPdWyzuA58WuKK4dg
 mAzqboPVZtYJmkZzjLRMHGCRt3WHcYTgQnoigpG41N/GJZjjP9z9gmP2Cif0CJ3DAziXzjLQT7S
 8JwIw8lmn1pOvUUeZlbLJPuvJYP/XVgSB/SwL8bo4CLniCWeGjMucbiwONavSpsFqktj3t3281d
 8/1QFc6fpKgQq42zFLb8WIMm0VESruxRmQ5CHCmRWIW5qiHyeGcL4LOvgdi72JGpdW2EGC5trk+
 REhd3LMWGQYMBTsULW0fPiUwRtGOcV/4d2v05hHUX/1ypgHXrWnACB9ig1sSuAvxSiJAPilg36l
 aXODFhA0JLQ6DrqL4eav8JMXlgd3crP8eho3zoGukjr1Ci2nGsJbRJRIPAqDOQ/YZ8FnVHqn+/b
 HVHhnfLZQNJjxD2EI9XtspVrUg==
X-Received: by 2002:a17:90b:1e4a:b0:37f:c97a:939f with SMTP id
 98e67ed59e1d1-39580ace5fcmr3170128a91.7.1787111869372; 
 Tue, 18 Aug 2026 20:57:49 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:57:48 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:55:01 +0800
Subject: [PATCH v9 19/19] spacemit: k1: fix product name detection and DTB
 matching in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-19-6e66016392b9@riscstar.com>
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

Use a table to handle DTB matching.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Abandon to load product name from ENV.
v6:
- Rebased onto latest upstream. Cleaned up board_fit_config_name_match()
  to maintain consistentcy with v5.
---
 board/spacemit/k1/spl.c | 50 +++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index b70eed14e6ed..93b0b6518c93 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -163,6 +163,15 @@ static void i2c_early_init(void)
 	}
 }
 
+static const struct {
+	const char *eeprom_name;
+	const char *fit_name;
+} k1_board_map[] = {
+	{ "k1-x_MUSE-Pi-Pro",   "spacemit/k1-musepi-pro"    },
+	{ "k1-x_deb1",          "spacemit/k1-bananapi-f3"   },
+	{ "k1-x_milkv-jupiter", "spacemit/k1-milkv-jupiter" },
+};
+
 int read_product_name(char *name, int size)
 {
 	u8 eeprom_data[TLV_TOTAL_LEN_MAX], *p;
@@ -196,6 +205,27 @@ int read_product_name(char *name, int size)
 	return -ENOENT;
 }
 
+static void fixup_product_name(void)
+{
+	char fdt_name[I2C_BUF_SIZE];
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(k1_board_map); i++) {
+		memset(fdt_name, 0, I2C_BUF_SIZE);
+		if (!strncmp(product_name, k1_board_map[i].eeprom_name,
+			     strlen(k1_board_map[i].eeprom_name))) {
+			snprintf(fdt_name, I2C_BUF_SIZE, "%s",
+				 k1_board_map[i].fit_name);
+			break;
+		}
+	}
+	if (fdt_name[0] == '\0') {
+		/* set default board name */
+		sprintf(fdt_name, CONFIG_DEFAULT_DEVICE_TREE);
+	}
+	memcpy(product_name, fdt_name, I2C_BUF_SIZE);
+}
+
 static void clk_early_init(void)
 {
 	struct udevice *dev;
@@ -439,6 +469,7 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", product_name);
+	fixup_product_name();
 	pmic_init();
 
 	ddr_early_init();
@@ -456,24 +487,7 @@ void spl_board_init(void)
 
 int board_fit_config_name_match(const char *name)
 {
-	char fdt_name[I2C_BUF_SIZE];
-	int i;
-
-	memset(fdt_name, 0, I2C_BUF_SIZE);
-	if (!strncmp(product_name, "k1-x_", 5)) {
-		snprintf(fdt_name, I2C_BUF_SIZE, "%s-%s", "k1",
-			 &product_name[5]);
-	}
-	if (fdt_name[0] == '\0') {
-		/* set default board name */
-		sprintf(fdt_name, "k1-musepi-pro");
-	}
-	for (i = 0; i < I2C_BUF_SIZE; i++) {
-		if (fdt_name[i] == '\0')
-			break;
-		fdt_name[i] = tolower(fdt_name[i]);
-	}
-	if (!strcmp(name, fdt_name))
+	if (!strcmp(name, product_name))
 		return 0;
 	return -ENOENT;
 }

-- 
2.51.0

