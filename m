Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3789CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 14:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DDCF83E81;
	Tue, 12 May 2026 16:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bEnfZ9ZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F350683E81; Tue, 12 May 2026 16:45:02 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F08803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-837dfccd950so2717674b3a.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778597099; x=1779201899; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xi3+RQq/wU6qkH0yXXleN35lZ4KaLGsNf4wPwNYcs70=;
 b=bEnfZ9ZRvvbuMxAIWlQsnNAN0kxE3Fc5jLP4LwLh6gk95GE+V3y/IT5zHJKkku5VQO
 FxBwF/oRmcsPiAeP3g0eH/5X/S6c7yqdDqVfnInre6uE2pGSKC/CBOal2d9B1kKJaOoA
 w18KYDk5/BK+EO9mtL5qIP0Enf3hKu4B3A3h2pW9qywgIhlx9tU2DIO5y7TDu4oN28Cu
 HR3vfz93bF20aY5WXhTE0ih11CR593mxRERD0U5Ntw0uy5QSGDWUmnmubbz3TYG3AQYx
 BXtcikZX/8hx3g9y4kkdyQr7xWM992UO//5NXiIEEW7MzEjMCmtFvMuartbPHJo18w7n
 WMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597099; x=1779201899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xi3+RQq/wU6qkH0yXXleN35lZ4KaLGsNf4wPwNYcs70=;
 b=o6HAiFX2ba41v9S5zeQl7rwcTQWImKRhCBMYpxVxLAOfcFtoD5JJ6xK27PaJBJvqy/
 LicFStM/HzoUbX3GClLPDWaW2fGZ9xPB/aQ2pCy7N3I1sN5s7b+jUJY7IZKrW/voFAKd
 rtdFSUPnYByJ3f7j1WilmI6BI6QgwPyVzyiGcNBjoH+9rOdAQ29XrIFRpXoHqy9xGucK
 NpE8ulCo42LncY9PPBWFCv8UZzrsuUzucjrwUTjCJQPZEuS9ZaLUUjQbQYecZQHG39OT
 NPNBJDpjkxSX92+KW/hJ2bgP7TZSqcJoYjQs6da083pedpWPCkmkc8SHfK0H8bgiRjfV
 x5jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DT5D09bHO587Ko9dfwi9v4FOky1qfwE/wIcQoaze5vBVIPog8j9EKTdTrTTlQEyjO9x76Fhw=@lists.denx.de
X-Gm-Message-State: AOJu0YyHJDZ3QLbtD8cQvOTIXbcxVn2VH3yxIBRP5MAeS9w+axuvMFO8
 HqAIETmRFNTfz5wgENR7GuGfWUZ/fC+tDY3Pt0RKg5iOf/GqaEeuJb5D
X-Gm-Gg: Acq92OE8mBVpE0srwzeJwrwIuSKO+Dwu6MCcLR5H2t3RmWS0L/eWO9NgcDFnzjtbAIJ
 d+dGiw6wQhHJ1rl6rPrqQU5iCVaB2fQ8ITUapWtbJGqQD6WImVClDFgYr/e8YlBNVVRz42rsHSI
 ocThMIkQPHGtSu/SZCTXoE5Ukm0HmOW3+pWK88wqBu4mUbDQC9EjAC3dIyQBboDL2JR5oeDI/Lm
 HVrXu5K5d0cpqoPFdQ5dSvjG6xbZ3zNacwLWz9181BTF5V5ld0fpvXd7/gLUyv7QKpNpiHbEnoz
 FmjkSQg/FmExMvCgm+3MBacwXa9SmNw/Oe2nVcNaHl0bZM1pvxNw3BDYIkcjLN5H9/GO4UNL6Gp
 e2MXY3rvlk08naTXPfEgyVQowzLbNlopFPZVxGeEXzvBbwQeT7siF7QfZjIaQp3dv6squUXeLnO
 gqDpFesP+UCB0WR4H0eXeFnKNvF3Ei
X-Received: by 2002:a05:6a00:4616:b0:824:3bd9:aac6 with SMTP id
 d2e1a72fcca58-83a5b9d824bmr27841133b3a.16.1778597098895; 
 Tue, 12 May 2026 07:44:58 -0700 (PDT)
Received: from [192.168.0.102] ([43.251.89.154])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8396594645csm24703145b3a.14.2026.05.12.07.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:44:58 -0700 (PDT)
From: Biswapriyo Nath <nathbappai@gmail.com>
Date: Tue, 12 May 2026 14:44:40 +0000
Subject: [PATCH 2/3] clk/qcom: qcm2290: Fix vote_bit of gpll6 clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-ufs-sm61x5-v1-2-c022cf988e89@gmail.com>
References: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
In-Reply-To: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Biswapriyo Nath <nathbappai@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778597082; l=692;
 i=nathbappai@gmail.com; s=20260118; h=from:subject:message-id;
 bh=gYgCdzmoqaafeXfhkqLmTq7ip4E/oWm5MRLIQIu/TMU=;
 b=/MCd2ieTXQzczW7Fp5DULPZqbZFeuHx4Yog7tMmHl0kc0nSY1+lf8ucc9sEbEYEtZJjpBZUwa
 ZO3nEVwCIDiDpQUL57QZyisnEO0CTE/mQy85hh0ptANpramNPe9i9la
X-Developer-Key: i=nathbappai@gmail.com; a=ed25519;
 pk=slmb/9yXbet+KTiT3EYLCp0p0MEOYa3EdjUXP+HXfjg=
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

Fixes: 3ddc67573fab ("clk/qcom: qcm2290: Add SDCC1 apps clock frequency table")
Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
---
 drivers/clk/qcom/clock-qcm2290.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
index 5a599085b500..c38ff1a1e4a5 100644
--- a/drivers/clk/qcom/clock-qcm2290.c
+++ b/drivers/clk/qcom/clock-qcm2290.c
@@ -73,7 +73,7 @@ static const struct pll_vote_clk gpll6_clk = {
 	.status = 0x6000,
 	.status_bit = BIT(31),
 	.ena_vote = 0x79000,
-	.vote_bit = BIT(7),
+	.vote_bit = BIT(6),
 };
 
 static const struct gate_clk qcm2290_clks[] = {

-- 
2.54.0

