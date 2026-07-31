Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EC4C5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 13:22:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BBD3660816;
	Fri, 31 Jul 2026 13:22:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WH-T-JC2_-gS; Fri, 31 Jul 2026 13:22:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1DFC260AAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785504133;
	bh=wTzukte/oFeQUg11ChDqiwxzS5bnjmRDi5FAu11/G8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RSCBoLoEiWJC3n56vDBGu05+o/zkShc0yyRN11notpFZm/dQNxH+3/XdUAsCWhRBq
	 epSe4v7QRzTEySUrpqxyE0H9YheExImGSER5uF/2ecvQ693qAcRi4IxGBE/M0m3Cpg
	 HELe9d3VvjAOAR4eHAnbsMFtyYWbXqEnniSOeoUYyPY314tHS0kcqGLgrqbxNAZUZD
	 cl2um/xuioud18Iztmrt1sGhXZM5jacrXBKF/hSLv3a+XaOIR1LGpzxBotUe+DRuu3
	 YOXg47SXMQaavUa8E2uKMAVRKwZtlV4wXsD6x6kXq3Ll5NhaH1qi6Lj6LqNtewdU7p
	 pvhm5c1VB9hMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DFC260AAC;
	Fri, 31 Jul 2026 13:22:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EBFDA2E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D170980F75
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrDr5fMbT9k5 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 12:51:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=bhimesh.matsa@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4306080F6B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4306080F6B
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4306080F6B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 12:51:47 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-c9ef3e1337fso651241a12.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 05:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785502306; x=1786107106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wTzukte/oFeQUg11ChDqiwxzS5bnjmRDi5FAu11/G8E=;
 b=r3yhtNvIDStQkcx/DooYqmmnpF+mOOOEOpiait5QLegXIEOUljemNqET/pcGiVwqXX
 Hayd26emHi5rpE8NfqTxIphxzOjsOqLnckUXfED8ufgf5CpYiHSksA6ylzTTTiYIRV7b
 e+/omVkedzCag/o4cYmESWABX8Tjl7Br4W0xhMD22YTVTqawJPh46/QcfEBmPHsC+0f1
 dO1+cOIue2cVGusIzZBwLnKLxYKylEWwo0CJfwrrJNCd87GXgKVLy1PeonQHC8LWS0xy
 0att9+tGUz418eJ16t0ZhSnGIc1HTjKeTMv0xfg2+uGW0i9+Ob2IqXuSRmhvXTb9Bk17
 GYvw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqv8Y2tNiOuSDpwBc5Usx6ergOMvgzJjySwXo+vSXEh9LKCqSV8zq1r9gdMfNjVTlz+g1TPS6U=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyF6lX56uh6ppuQAVwvUpKxuL5NJUArF8yKrVNQFPAZl4docDsJ
 vflMd4oegu9RXBaw0uUt+NZjCBXctie660lqk4LLRAvGgWL89VAYIPQ4r1YKDbSW
X-Gm-Gg: AR+sD10i6KGQLpAeyT2NVRW6t3AdNnBWURmkrf1XOrvrCIy8oCXjQomVoardCzX0elc
 AOQyzBdDWbyOR52Ax/W3nH13/br8QmqQ7xuDcHb+4pDZnlFgDjvrvi1isVtcjZZ5juFthIwpbBO
 NnYELZvs1G38L1JLChwV8qMJ23ybDbK4jowYnws2WYmz1D3rf0Xh8rT78/bm+uVyy20KNaRKman
 3607sqpt2CXplrsgmlUKuVvfGve9P9Egn579ki0svGeA1rZ1c6pqFWIFxZKRr266A3LdPfCDdCD
 mdYy9xPz/AvUnaQTmL5mRUDM4tT24YsBXflDvxsQSPyqlE48ZSoi36hXhO1o/7Dm8G4K5GRDUZp
 vJboRL7Em9C5+0I8IAf6sAaBvpE29EayY8PFDu2eGNwTwOENM0k9u8Pxug6vxyLvDBVDF1f80Tl
 7yUgWTAMtbW+xoxrFt6gbTX/83g3JSt2p3AWjfER6UQZLKED7TVxu9phvFQxpVWI4xwvgUGA==
X-Received: by 2002:a05:6a21:7303:b0:3c4:397a:69aa with SMTP id
 adf61e73a8af0-3c91b1aa68bmr1829847637.31.1785502306389; 
 Fri, 31 Jul 2026 05:51:46 -0700 (PDT)
Received: from kumara-Inspiron-15-3530..
 ([2406:7400:63:b1e4:68cb:1792:7028:16db])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e666sm9304967eec.4.2026.07.31.05.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 05:51:45 -0700 (PDT)
From: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
Subject: [PATCH v2] power: regulator: tps65219: Fix LDO selector boundaries
Date: Fri, 31 Jul 2026 18:21:33 +0530
Message-ID: <20260731125133.10998-1-bhimesh.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
References: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 13:22:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785502306; x=1786107106;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wTzukte/oFeQUg11ChDqiwxzS5bnjmRDi5FAu11/G8E=;
 b=Fog4ycijuy47dSaVJsU5IomFLBWnTu39gQO9mlBHjGEbFBr8Z+tcko4AarCbEaO8ja
 LPWQs3qr8bzYz4yhJvBVUuep36CoEwR3j80cPvZzPOFaE8T7pQ6HyJKo/Kum2etOsSjt
 rgB9yiBF5E2bc75DmcZPSMTUuT6akIIABB/MubX+I7sJ9+3Bbx3LVBVyUo2doG+Q00nV
 YUrY9z7+FtkBiTjidM70aVNxOHMcrgb40j7eeHqPKih6VBVZ8oojo8L4VOSiPoh2+srN
 vfVLZQj68qZ9DuG08eUzHVmlNIlTJxOF7aMUOnFAlJvfe3M8zHB9wpOAttJr8/8zAsk9
 zMvg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Fog4ycij
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

According to the TPS65219 datasheet, selectors 0x38 through 0x3f
map to 3.4 V for LDO1 and LDO2.

For LDO3 and LDO4, selectors 0x00 through 0x0c map to 1.2 V,
while selectors 0x36 through 0x3f map to 3.3 V.

The driver currently uses 0x56, 0x12, and 0x54 as selector boundary
values. These values do not match the selector boundaries defined by
the datasheet.

Use the correct selector boundary values of 0x38, 0x0c, and 0x36.

Fixes: b5cfa0c7ca4f ("power: add driver for the TPS65219 PMIC")
Signed-off-by: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
---
Changes in v2:
- Fix the LDO1/LDO2 selector boundary in addition to LDO3/LDO4.
- Update the subject and commit message to cover all LDO selector boundaries.

 include/power/tps65219.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/power/tps65219.h b/include/power/tps65219.h
index e8780af2d81..c3114f26e1d 100644
--- a/include/power/tps65219.h
+++ b/include/power/tps65219.h
@@ -47,10 +47,10 @@
 #define TPS65219_LDO12_VOLT_MIN		 600000
 #define TPS65219_LDO12_VOLT_MAX		3400000
 #define TPS65219_LDO12_VOLT_REG_MIN	0
-#define TPS65219_LDO12_VOLT_REG_MAX	0x56
+#define TPS65219_LDO12_VOLT_REG_MAX	0x38
 #define TPS65219_LDO34_VOLT_MIN		1200000
 #define TPS65219_LDO34_VOLT_MAX		3300000
-#define TPS65219_LDO34_VOLT_REG_MIN	0x12
-#define TPS65219_LDO34_VOLT_REG_MAX	0x54
+#define TPS65219_LDO34_VOLT_REG_MIN	0x0c
+#define TPS65219_LDO34_VOLT_REG_MAX	0x36
 
 #endif /* TPS65219_H */

base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
-- 
2.43.0

