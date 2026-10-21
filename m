Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C15606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tBFaljHg;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EPc9hrbX
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECA70608CE;
	Wed, 21 Oct 2026 12:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vsSWzhF7qP0C; Wed, 21 Oct 2026 12:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6084E6085B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587325;
	b=KjFZyPtTR9deKfkNOqZloJ3nh2AdMsCfW2U8gnXtK/k8gF2YR03w8+6+mcDqGZrZ8AZL
	 jBi4LcaSGS8ZO92xBzpEMvdHSUIkbZg4QNYU1ad9hsaraJC5tfd7A5v9LCrB44qHdz9MX
	 idLWe9HFwLa0YrZrIb8Oba3matVUzIwv9iFmsj4v7Vvybdo1QbP4vYT4y0ySM/439XAO0
	 019cK8U/yeNC0ovjtgic/Kd0NuxJVfIvS9HEhKuo5rZMfvm9evkwd9X/MwIYnnvtsKUpX
	 Por1FMyWyjNQAVXPdZeatFPhuvNjCfaMPU8b5WuSIIyn9z66UkRAILW/DSZy9wtn7Pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=O0iGoD7zYCL1UXlu91Te7duGyunZ/U/synolaap0hGM=;
	b=CoPOVVZ2pYYNPMwJo8UbY16YG1EOaPZ0vn0vRVsb6ffMk8ViMNTXZ7ggPKfDaVijGQrp
	 Qx+bJ+s+0bOj56COzzsuDmlqjO8m9PRxyFxYFHXYlofY6ZI/pJrwaE4ERFINQaUBbQ1Ra
	 jfl7o49R9y4QthXU1MamU5j7JdhnSDRDZGGX2UTm2KzdykLCJnTu8dlsgvaqMKpq3mNHY
	 3W36OdwcbH578DjDtvQeNE4FEYGvWDevgZIDNvGJLW9PEVl3Sq17+83IcgEYCAzg6HaNZ
	 28Zi92BvUTd6f9cYyv6sK0lbgX9u7dPAVTT1b065a46Z4VENzr/8zIAnR9x2BDtqCkw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587325;
	bh=O0iGoD7zYCL1UXlu91Te7duGyunZ/U/synolaap0hGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tBFaljHgALKCX3ULmCRVN2I3eX3vUnsGanDD88+bt7k5dlsJ1b756sem/H1WIS6Nl
	 /ZLnrsJzjCAAyBnL8uNTertYYwpqSFYKvNGR0QfKzgx32v0iW04oqSUGbQI3zAmSBG
	 0LZJvciDh6XlPxw3+zaQd5uCup93+/1V0gdBYtKKXzKGFGzHojySI3ZtlxNbuhxOpW
	 GDIUTKoBuUkGeBGhSZ6m2F3eIj7xwpN2GReQPU5QBxp6StK96gaT3Y53jMsnSBGp3e
	 IOD2c6xWdCB2NhR7IUHcef2O4CiotaY7Y7AYh59GKVCHK+Ny+In085CGipxCz8D0rP
	 s5hYsyVSM54VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6084E6085B;
	Wed, 21 Oct 2026 12:55:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 59DEE23A
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4BF8C810A2
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y_YlCjzkxjxP for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 12:55:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BC8680E0F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792587323;
 b=qW/vSnvyL+am4ACCcbeGCXkr+KeZET66RSjHZ/0rWvLreE9swEH+0ERX36iMFp0gCNXl
 avrIKF4WLfmfVHVmb4AgW7g42EMB1rLITX9c++CQKtlHdc7ncixpN9OgioeqTy2FODXU8
 j1wc7Nx6Is5SEUEGqh+KafmY6V4bUb1FxvAf8HMqJJjgmwGaw8ZRkaQvdSXsPY3cEocGJ
 cFGVB91Sv8KeREWwG+654Jiwz+Oyekxi9GPVT+c/qKLBnNAvY1mflLkezDW5tGzkc0wtI
 LdTaPy6uQFicas4y5bVwkw9KT9PGmSepBqK7oP90I9Bfs9iPj3r5diqkPBYHw7ycwjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=O0iGoD7zYCL1UXlu91Te7duGyunZ/U/synolaap0hGM=;
 b=k3XEfw89iARyPg7jnLthRX/TSImqctXF3PzJ19G4nUdEy239rkG08jPyvk0J9whlMLz3
 vL5ahTNfwSZAHX1EsGpoUFPm7FQtBhwJq1EcpxIn3FDhMRMkdrVXj5Cw0RJTmsVQYP4mF
 BSJeQrC1DhbcnfDv8bMHXyMoh4hSBSlP3xCKxMxKDW8gDRKyBzR8o2jaCTEcX0Jx0SqLJ
 mBneFkb/xEfXiyDhjW0HURe8VrhMKCDAhbund1ozGlZw578E0a/Yp5y44i3o2jH5jKD5B
 Q0vqoVA1/zc3yxPgWp2TuDqHuJRLtjA7tLDFPwYmeH0DuS47vZDYjqwJK7LsQ6VvJnw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EPc9hrbX; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e36; helo=mail-vs1-xe36.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EPc9hrbX
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com
 [IPv6:2607:f8b0:4864:20::e36])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BC8680E0F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 12:55:22 +0000 (UTC)
Received: by mail-vs1-xe36.google.com with SMTP id
 ada2fe7eead31-7c4818e4165so578002137.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 05:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792587321; x=1793192121;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O0iGoD7zYCL1UXlu91Te7duGyunZ/U/synolaap0hGM=;
 b=EPc9hrbXhZUy0yaBu7Mh2mZdE/Xcp5OaxZKc7lQaDZaDIYOJYBchsyq8O9BqKetzAM
 Yi0KR4lfE5zVSEYFywXYjSRrH3qk91/oAZd/IX0/BH5tGb+tZYbIPtloZqovuIgVOULa
 ukXwfKZwx4En7Jxb3IuwpsJUroi+KEtmKbDXSueqo1zmxr4SXLd1ND5rHqQv7W4s3xJK
 FOZ+xt9KYDj8Jfg/JCbwXnRa2Hh65vJ3Z8Hr4ENOumOl72Jihnlf5h4TJOMH7zyfHlqS
 MK5T1Qjo+d/vHNgdg+2FzFSWp8UmLOPOtWYPFNPi/usUqMBaiIIWm5Ii+V4kjmxhlInx
 X9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792587321; x=1793192121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O0iGoD7zYCL1UXlu91Te7duGyunZ/U/synolaap0hGM=;
 b=0kmsqZF6sjaxJ0nl91SuPTlPAPPWGNwe4odqJ+0FZaLeT86bG/r0KDEjbIpZLrIcuj
 fyttkx+YZwdFlVPY8HQ3Bwb+ckOuHMxWeLTz52aSaj6U6/Y8efwcw4qIfv0U1QGNE+S6
 dsU5Leu3YigYsNacTkasPYsu2UT0AtzlZNqHx5L3FIbALGzJRho/vgDDxACDD0hUj/QH
 QwEhGpEAVzFxuFYsL0nGlUB3hcc/dfWlcvpu1ruvuFcedwIkESAW1DXywYnJHYLYStFz
 LmJCKbZRmTRCkhfOJhaZSUiX3vpnQty6Ul2EmLzgd8RWdJDshtqd9xLVjPmtiKEpU5qJ
 SrKg==
X-Gm-Message-State: AFq9FYKpcZjjjNFkxzyVgVqbJlV9S8azhRMicqoHgD/MZDfG3BJf5Qo1
 YN5oEIHupWeQcEfgjAZkdSnf/LPv45y45llbkWiy8ZjB0VUD+N6s0zGO9RJ78UnwwG0=
X-Gm-Gg: AYBFou1pVadyuYMmkU8HOuSf8SPS6qD2K1BmUZHb0QtzAbelGJMAxYvdqeBJ41gZEzN
 td50FsBFbXFk5JKAGXJa3jIWXD8iKT8Nq3aUaffx/EHSHxSfo0vae7YveCUR6D22cth5LFi4jqn
 peDZ0XpLJs+DRvm/m0Q2nF6zu3ITgdFkZcybgOshJfQyP8pJ7nT3QHrb3GR2hHcbpQvVZ1gk/vX
 Mxcv/HZt7juuIaxEW/VHUH33WkibciqFamDJsf0tXSAPZ5XpR7VcQ3lLaWmuPeNHhG9YkKLKjnS
 U+yCRyGLN9L0t+4knqDY5qJeGxJ4WsnidsrNbZS3zDpQoQsYn2hMSn3xqrKmWkgR63T3RtvpVZx
 edc0xDMqlQauvKxuNvqPp2B2kMSf1c7qH0V4iGwYTFjHRyuh6rv22sxg6/Ap/JMQ7Ad3VSBeJGw
 AZ5xxOUtcC3/u7G63XM93YoQzrZonUTYZA6aReWp1LH/jaR0GNfAiqzi7/+dvA0IvmAtBWBQtO1
 N0nC4mQOrSwNjRKWyM3EFSGntvjkh8GlHM9J59L6kSDHeK7+5kXGH8XN9fOXXGfdGCNs2iHHQcr
 ZErCqtQboKsr4XzZ9bY=
X-Received: by 2002:a05:6102:a1da:10b0:7cc:38aa:63a with SMTP id
 ada2fe7eead31-7cc7bbe310amr864133137.17.1792587321465; 
 Wed, 21 Oct 2026 05:55:21 -0700 (PDT)
Received: from [127.0.1.1] ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-990d0e0ba56sm3013863241.1.2026.10.21.05.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 05:55:21 -0700 (PDT)
From: Hiago De Franco <hfranco@baylibre.com>
Date: Wed, 21 Oct 2026 09:54:22 -0300
Subject: [PATCH 6/8] board: sophgo: milkv_duo: enable RTC power and reset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-milkv-duo-spl-v1-6-ee7618860237@baylibre.com>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
In-Reply-To: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Kongyang Liu <seashell11234455@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, Zhuxu Ran <zhuxu_ran@zohomail.com>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let the RTC power domain handle shutdown, warm reset, power-cycle and
watchdog reset requests, and stop the board from powering back on by
itself after a power off.

Without this, the reset and poweroff paths are left in their BootROM
defaults, which do not match what the vendor FSBL configures.

Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
---
 board/sophgo/milkv_duo/spl.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/board/sophgo/milkv_duo/spl.c b/board/sophgo/milkv_duo/spl.c
index 8b2dc2756ae..97681e5a61b 100644
--- a/board/sophgo/milkv_duo/spl.c
+++ b/board/sophgo/milkv_duo/spl.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
  *
- * PLL setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
+ * PLL and RTC setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
  * plat/cv180x/platform.c.
  */
 
@@ -13,7 +13,9 @@
 #include <hang.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <log.h>
 #include <spl.h>
 #include <spl_load.h>
 
@@ -52,6 +54,25 @@
 #define CLK_DIV(div, src)		(((div) << 16) | ((src) << 8) | BIT(3) | BIT(0))
 #define clkgen_reg(off)			((void __iomem *)(CLKGEN_BASE + (off)))
 
+#define RTC_BASE			0x05026000UL
+#define RTC_EN_SHDN_REQ			0x0c0
+#define RTC_EN_PWR_CYC_REQ		0x0c8
+#define RTC_EN_WARM_RST_REQ		0x0cc
+#define RTC_EN_PWR_VBAT_DET		0x0d0
+#define  RTC_EN_PWR_VBAT_DET_PWR_UP	BIT(2)
+#define RTC_EN_WDT_RST_REQ		0x0e0
+#define RTC_CTRL_BASE			0x05025000UL
+#define RTC_CTRL0_UNLOCKKEY		0x004
+#define  RTC_CTRL0_UNLOCKKEY_VAL	0xab18
+#define RTC_CTRL0			0x008
+#define  RTC_CTRL0_WRITE_MASK		GENMASK(31, 16)
+#define  RTC_CTRL0_HW_WDG_RST_EN	BIT(11)
+#define RTC_POR_RST_CTRL		0x0ac
+#define RTC_EN_REQ_TIMEOUT_US		100000
+
+#define rtc_reg(off)			((void __iomem *)(RTC_BASE + (off)))
+#define rtc_ctrl_reg(off)		((void __iomem *)(RTC_CTRL_BASE + (off)))
+
 struct cv18xx_clk_div {
 	u16 off;
 	u32 val;
@@ -173,6 +194,35 @@ static void cv18xx_pll_init(void)
 	writel(0, clkgen_reg(CLK_BYP_1));
 }
 
+static void cv18xx_rtc_init(void)
+{
+	static const u16 en_reqs[] = {
+		RTC_EN_SHDN_REQ, RTC_EN_WARM_RST_REQ,
+		RTC_EN_PWR_CYC_REQ, RTC_EN_WDT_RST_REQ,
+	};
+	u32 val;
+	int i;
+
+	/* Let the RTC domain handle power off, reset and watchdog requests */
+	for (i = 0; i < ARRAY_SIZE(en_reqs); i++) {
+		writel(1, rtc_reg(en_reqs[i]));
+		if (readl_poll_timeout(rtc_reg(en_reqs[i]), val, val == 1,
+				       RTC_EN_REQ_TIMEOUT_US))
+			log_warning("RTC: failed to set register 0x%lx\n",
+				    RTC_BASE + en_reqs[i]);
+	}
+
+	writel(1, rtc_ctrl_reg(RTC_POR_RST_CTRL));
+
+	writel(RTC_CTRL0_UNLOCKKEY_VAL, rtc_ctrl_reg(RTC_CTRL0_UNLOCKKEY));
+	/* BIT(6) is set as in the vendor FSBL */
+	setbits_le32(rtc_ctrl_reg(RTC_CTRL0), RTC_CTRL0_WRITE_MASK |
+		     RTC_CTRL0_HW_WDG_RST_EN | BIT(6));
+
+	/* Do not power up again after a power off */
+	clrbits_le32(rtc_reg(RTC_EN_PWR_VBAT_DET), RTC_EN_PWR_VBAT_DET_PWR_UP);
+}
+
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -190,6 +240,7 @@ void board_init_f(ulong dummy)
 		panic("Failed to probe the CPU: %d\n", ret);
 
 	riscv_cpu_setup();
+	cv18xx_rtc_init();
 
 	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 	if (ret)

-- 
2.53.0

