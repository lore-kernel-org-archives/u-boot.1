Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E6EC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 16:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC17083FD3;
	Fri, 11 Apr 2025 18:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RkQnJQUO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7FD1840D5; Fri, 11 Apr 2025 18:15:27 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5B3D83E96
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 18:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso4010823a12.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744388125; x=1744992925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plFavMblBUPZMwgoP8wOxSFygVXsbi6ncRkK/LjY2cI=;
 b=RkQnJQUOMWfa3MmRMnEatYNkJElwYrfH52oifqP3jboMFRwwxIKg7Tw3iVS95rYILV
 CqBa10+HO6MQ4gmIHmp/PXeo7chtDMtXftkyqALXeUfCGoGed2XW5c35u8sVBUy9TBv3
 HBJGA4DVacQfh37wXi1zLM5sEugp5JXvJYmHcW+1NN1LWu+JDyV0kPT47pdCkhTn8GsM
 UFSOJ3XDWvNGWeUVdJbRvFXcIZW6dVSUoCKBvArXZ0Rv/NSrV/ewusl0QnrjyGG1vJsp
 EKgBfEd18IRHov632Ot//L8eN7JIVGzZfWqC4o9Ppr+YuRcu5G96PfHfVTa9Xt8cmvRK
 abVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744388125; x=1744992925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=plFavMblBUPZMwgoP8wOxSFygVXsbi6ncRkK/LjY2cI=;
 b=YvXhPla9Ji+8Gnx9o7RVQLxmPwpYvxWJeI74uB/FRuHS2HMynps1P3NYEt47Y1w+RC
 Vzi1s6JFIAukNrLUMbN0zPGUUXAseGK8pqqKg1uoUviN3ef6lZahLZT21sM372VlWMn6
 SvKeXbaQfcTgd27K6eoUc7MMSrwfx36RTtKfnR1ekv0pVsuahdiDIeRivMuo6H3vv6dA
 jTK4xdUKvd7q8LFmiabHY+bcY9Sfbn7BXuLRlefr/RXkIIoV8zqQR6Q4DlN3CdTo8yby
 afBglB6YHXaaKrmytyC0li1epO+MHe5MB6CYXXWhd8mERbIyw4jg+70Ff/ZhXR+44wUX
 zOVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE8HmWDvx6risflU/7n7YYYQvBztZROzaoi46IN4caVcZn0i6yBuMJbI1NACbloTr5O5rSSpc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2Xqlesqt7L4QPubdU2SIhenr3TcX4ujskOZGYh8kSFTGkKSaC
 XbRty8DK1MnUeIYPTx8OYfXZwtoBnjkUQ3o75AGZlvqJKyXvvAmR
X-Gm-Gg: ASbGncsSbsrtKck3zLz3oM1A2hn2uDmib39VYS//61wghBshBKPAY0elDEiLWNldcza
 piZZA0393Sq/7lmxq42jjTLjqDuRlYq249f+FNotS4SQvC4973bsbE/zF/RZVJ9r5KhilDQLc3t
 Jh9j3BJk4iMweuaaw8t7lqovPxsGs2ZfgfLSEvxHK1E4oTx+Kt/vLj9/K5X/zmhtT3BNX4bg5O4
 IwMcu+cNRZu+Wcl+c84MnTU5qRjbM+p1CmzqzFakkPN3YStwN+U+oGtLm07D9vEq8+RS6sBJf/u
 pL9Pqcx98o4KzKDqKvHjzWCEil+KhfAjKDl2iXb69nngPEQnbAULEQeq7A==
X-Google-Smtp-Source: AGHT+IG3z5ipT/8ygt9z8Ao/4hNyMj1+30brbGgn4tag3FWFzn/e9+tfPxzPBNJdAEnuTLQo+tfgqg==
X-Received: by 2002:a05:6402:1ec4:b0:5de:dfd0:9d22 with SMTP id
 4fb4d7f45d1cf-5f36ff075d2mr3093629a12.22.1744388125097; 
 Fri, 11 Apr 2025 09:15:25 -0700 (PDT)
Received: from localhost.localdomain ([80.90.89.143])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f36f526da3sm1136246a12.67.2025.04.11.09.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 09:15:24 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com
Cc: trini@konsulko.com, macromorgan@hotmail.com, uwu@icenowy.me,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/5] sunxi: H6: Remove useless DRAM timings parameter
Date: Fri, 11 Apr 2025 18:14:36 +0200
Message-ID: <20250411161439.4743-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411161439.4743-1-jernej.skrabec@gmail.com>
References: <20250411161439.4743-1-jernej.skrabec@gmail.com>
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

This is just cosmetic fix for later easier rework.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h | 2 +-
 arch/arm/mach-sunxi/dram_sun50i_h6.c             | 2 +-
 arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c  | 2 +-
 arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
index f0caecc807dd..f05a1845b32b 100644
--- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
+++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
@@ -330,6 +330,6 @@ static inline int ns_to_t(int nanoseconds)
 	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
 }
 
-void mctl_set_timing_params(struct dram_para *para);
+void mctl_set_timing_params(void);
 
 #endif /* _SUNXI_DRAM_SUN50I_H6_H */
diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index e7862bd06ea3..0adbda756639 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -45,7 +45,7 @@ static bool mctl_core_init(struct dram_para *para)
 	switch (para->type) {
 	case SUNXI_DRAM_TYPE_LPDDR3:
 	case SUNXI_DRAM_TYPE_DDR3:
-		mctl_set_timing_params(para);
+		mctl_set_timing_params();
 		break;
 	default:
 		panic("Unsupported DRAM type!");
diff --git a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
index afe8e25c7f58..1ed46fed411f 100644
--- a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
+++ b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
@@ -37,7 +37,7 @@ static u32 mr_ddr3[7] = {
 };
 
 /* TODO: flexible timing */
-void mctl_set_timing_params(struct dram_para *para)
+void mctl_set_timing_params(void)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
diff --git a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
index c243b574406d..c02f542c989f 100644
--- a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
+++ b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
@@ -16,7 +16,7 @@ static u32 mr_lpddr3[12] = {
 };
 
 /* TODO: flexible timing */
-void mctl_set_timing_params(struct dram_para *para)
+void mctl_set_timing_params(void)
 {
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
-- 
2.49.0

