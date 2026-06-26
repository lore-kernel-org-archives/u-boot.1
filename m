Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB442CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 07:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0604C84894;
	Fri, 26 Jun 2026 09:12:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l0ViVMLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E36B8495B; Fri, 26 Jun 2026 09:12:10 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8088460E
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 09:12:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c818fe1f24so1865925ad.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 00:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782457926; x=1783062726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6NY7CpkeHBX6uGmODvmMFSEBst4ouCVZHp3810tlDH8=;
 b=l0ViVMLU1vS4ppZ377qn4d6b0KKIzbN8Y7v+7seCimtEj+ugoq3ll4l56hCMEEbhvN
 fpDhyiRuCZMa1V/9MHFpntJlkUsnIlhP0OIb5ScDBOuQ3MuU5uXbQbMDdyMsRXfqKzPm
 BwW2pBrcMIiWUbXe8o6EoFiZdD3si1UQCYG4PiUJUcxEJVf2qRfmcXCbT3PCRCk7Hmnm
 60BNA/FZX4c4NqPandq7b+xJZft2wteAudF/OeQ8VLfw34MizQU9iUVV1uVfC5yNrTaF
 X1vuI1ZfRTMrunkNimGsAdvO6C/TL9PJEBGXStk5OtT93FpfI2WZQWS2TE/lvq/fGZwg
 6XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782457926; x=1783062726;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NY7CpkeHBX6uGmODvmMFSEBst4ouCVZHp3810tlDH8=;
 b=HC+sQlQTTfWzZujVDVFmLpu6AHxb4zQyfmis3QnjVdbDj91BfDdvmkrAlC8eE0Tntx
 NanNgVqWplrGSSmcIeBY4KfXBPMfj/ObgpsRtLnRmZ9VkZbtEOhpRXLvj5kIH+Qt7DWu
 OuiWzM2rQzQHMathwFrK4WuBlp3ZBiCKW+AwvAzkMh26zkoeMo6L6BSkeT5eBvOLrun1
 ww6CMAbP5MVZ8HCmVufBYxV6J0Q4TRJco3P0Uy0H2wO8g2hHFgkk3h6t+9n+WsYs1Ubm
 rwSOSkgpDQ0apE98fMKQ2UYZqHuFj3RkfXJWWuQCS+16AlGJZCCdDX7Ctl+afQ0QH3KX
 YdDw==
X-Gm-Message-State: AOJu0Ywoo6dMT+Nga/zsk3k9QV+3btFJ0KXH7uGGMmIMxcFPm2A/gYeB
 s+6TtXy85n40HL41DetY8rR8BEewcyT+07fNZ4DwtlozGtsnZSRxNjFr
X-Gm-Gg: AfdE7ckSZHuibtq1aFgaBbc3JCZyJd2RUUiVBzOtJCei9yZuBhldbeVpg4ZlnW92YzM
 nuDcCJqoojUXtTqarLDXsFWFy8FrpGtWV3/4y8HaKOiXNuNNwwyR7wr8gnr+Cu88CSBqF9ReHAh
 6+hMsgdggvPtaPUUds7GeFFir0oHkKcw2JFWvYJ8+zi85r1O+QzQUtvroivhdX6aspOBTNQhoS+
 U4ndLMrQy0DjgXKUI+XxpEYGCN8USYwXLKp7NHkCgf9LDUfsyhsehJd2xP000Ogn4s9tnuJLwRA
 jp9IHj5w/iLNfFow7FAMjHttrVX3CrjAc2+oGH/o+UeTn8ZEkUp+77dg26xbTEr86BxpJJxmgvU
 yqbyYCsoFoRCX8DHlyJvTooY/Skz2UqgCk3NrbDGbtsXdanwztTT/1CjJYxuGEYhQtqRLyYhtkf
 yThv+syAr87kZK5EkCsW5s6cCpwEtnhwZyaT2IkjSEVBfpB8y/ZOl42nTjg9o=
X-Received: by 2002:a17:902:db04:b0:2c6:6425:b343 with SMTP id
 d9443c01a7336-2c7fcea7db4mr40033415ad.6.1782457926439; 
 Fri, 26 Jun 2026 00:12:06 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:9fca:1cb8:c40a:c2e1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac88cfsm35015145ad.2.2026.06.26.00.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 00:12:06 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: stefan.roese@mailbox.org,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] arm: mach-mvebu: Add more AC3 & PC3 variants
Date: Fri, 26 Jun 2026 19:11:56 +1200
Message-ID: <20260626071156.3129812-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add IDs for more of the Alleycat3 and Poncat3 variants. This makes the
SoC information at boot say something other than "Unknown-??".

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 arch/arm/mach-mvebu/cpu.c              | 24 ++++++++++++++++++++++++
 arch/arm/mach-mvebu/include/mach/soc.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index da44727cf4f5..a1eb6927c3e0 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -276,9 +276,27 @@ int print_cpuinfo(void)
 	case SOC_88F6828_ID:
 		puts("MV88F6828-");
 		break;
+	case SOC_98DX3233_ID:
+		puts("98DX3233-");
+		break;
+	case SOC_98DX3234_ID:
+		puts("98DX3234-");
+		break;
+	case SOC_98DX3235_ID:
+		puts("98DX3235-");
+		break;
 	case SOC_98DX3236_ID:
 		puts("98DX3236-");
 		break;
+	case SOC_98DX3333_ID:
+		puts("98DX3333-");
+		break;
+	case SOC_98DX3334_ID:
+		puts("98DX3334-");
+		break;
+	case SOC_98DX3335_ID:
+		puts("98DX3335-");
+		break;
 	case SOC_98DX3336_ID:
 		puts("98DX3336-");
 		break;
@@ -337,7 +355,13 @@ int print_cpuinfo(void)
 		}
 		break;
 
+	case SOC_98DX3233_ID:
+	case SOC_98DX3234_ID:
+	case SOC_98DX3235_ID:
 	case SOC_98DX3236_ID:
+	case SOC_98DX3333_ID:
+	case SOC_98DX3334_ID:
+	case SOC_98DX3335_ID:
 	case SOC_98DX3336_ID:
 	case SOC_98DX4251_ID:
 		switch (revid) {
diff --git a/arch/arm/mach-mvebu/include/mach/soc.h b/arch/arm/mach-mvebu/include/mach/soc.h
index 495530d84522..33fdfd6d6c1b 100644
--- a/arch/arm/mach-mvebu/include/mach/soc.h
+++ b/arch/arm/mach-mvebu/include/mach/soc.h
@@ -21,7 +21,13 @@
 #define SOC_88F6810_ID		0x6810
 #define SOC_88F6820_ID		0x6820
 #define SOC_88F6828_ID		0x6828
+#define SOC_98DX3233_ID		0xf413
+#define SOC_98DX3234_ID		0xf412
+#define SOC_98DX3235_ID		0xf411
 #define SOC_98DX3236_ID		0xf410
+#define SOC_98DX3333_ID		0xf403
+#define SOC_98DX3334_ID		0xf402
+#define SOC_98DX3335_ID		0xf401
 #define SOC_98DX3336_ID		0xf400
 #define SOC_98DX4251_ID		0xfc00
 
-- 
2.54.0

