Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E80C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99CDE81F0D;
	Tue, 22 Apr 2025 12:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VxY5MW2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8A5812BC; Tue, 22 Apr 2025 12:54:44 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8196781F30
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so7400559a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 03:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745319282; x=1745924082; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mX2wP2lYOBoIYnWVBgbGFW7fPgyNEmvM+yolX1FkaSA=;
 b=VxY5MW2+TYU9QG6RZ74KiUImprZjS55g8WjI1C11ymcg94ISH4DjjspvTZgOprUx96
 R+/nWXWyOlw+ACDv/5K9MhMigvieBdrONiO66oVCHObSKZwulBNJWlREQ8EJlblUllvI
 vnW0uL8/Sb97gLqgot/p70ujTL5h5VsD+xe/5CwlSYTddWtFtJWvCq8Vsk8Jb6EZtsVJ
 aPhhX10fzMWo4s5fnloPmqYsxM3+izQhY/3XK5RiszZEmCYp8x1AyCLeS+BcpWMqCmxl
 LIIscNoXuu9RGOuTIOOn2YJS9GooDr4iZ+KAs/DrqBR0I5M9+mx4VjkipR/woeBChk23
 2rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745319282; x=1745924082;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mX2wP2lYOBoIYnWVBgbGFW7fPgyNEmvM+yolX1FkaSA=;
 b=OJOUmf4l3GGjMCj/H7lTWe7f7RtQ90weGTqXpMLtum9OAE6SAbnoeq1I5XOkMzN/0c
 SkqENASNYzCioBnOmqMGYPrcy1rhJho6WiE0eJlb+CUEynh6+Bk3b8x50X5l3pgtPXFQ
 WXqzp7QO0s5dw1S+NQKcA9hNl206aoUm353tTqU37ElVqHx5TtYeTviRSY3THTsOr+rG
 W8TVgYjfIs8iRsmbtEcOyQ73886NaxNvQSLVXYyZy+o2JWvmFFbphlWcu4BmgsJ19+px
 sWZnO6fMhdh2rX27pf0qA5v7o9egR+QT/ikSNdf5/VylONaXagl/PBqvmnDT6c5Gr60l
 Tnsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0HKwsQcJ9JRtVvaRbwIajfNQxjJ2BnPNUH7XzrBb+8gagqmloxleTa4RzYoRZlyOdwcu+DgM=@lists.denx.de
X-Gm-Message-State: AOJu0YwvCUl93KWcRwq/5sJE/09kKPjo5UDH83aVYj3geLXLI+zjZtfV
 lCBlLmBXaGbtqE35ldfKfiO+h14hQpjeHLdusEUVhMQPQAzG/C61/rN3jM9Qw0I=
X-Gm-Gg: ASbGncsZH/gtZ4ah/+bUkgeg/zJgdMBCN76o2qMqnVgMOoaUQnDvk9Sg3RmnhaIsyVt
 a+pkKmA+BVTUHtM5Elh2+bCJkA4ahgNrmW1BDquT/p/D22vJdLWLx+VBDZK9JQBR8ar9ZflUys9
 9hn0DD8cXt4PRCABv7FSueN1H51C2IZSEdF2ATnxZ2kQy0/WNuCotDeSpvlRtTOwNPL/NiuSKoh
 YAcy0FtI+P6xIMj7vLMp097FNUUCGnkbH522ISHH5RzMAbLwjNTiHK2QvJvqnq6mbnV8lIFOK0e
 K5fB84Hipzn7qJAlIxH5dYXm6E9+x9VceWR9h1FDYR6wr0AGxmk76A==
X-Google-Smtp-Source: AGHT+IFIn8Vbhu5uNvAO03Nc8fzhLZnF7TYYogTzNVndSbuqtNEgGLFiYUBC9za7PkuTzfwDTe0Z2w==
X-Received: by 2002:a05:6402:5193:b0:5f4:d4e7:3c37 with SMTP id
 4fb4d7f45d1cf-5f62850215emr13043042a12.6.1745319281984; 
 Tue, 22 Apr 2025 03:54:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:d722:61ae:90dc:b4e7])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62554a1desm5709635a12.8.2025.04.22.03.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 03:54:41 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 22 Apr 2025 12:54:10 +0200
Subject: [PATCH 5/6] clk: qcom: apq8016: Convert GATE_CLK() to BRANCH_CLK()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-apq8016-clock-fixes2-v1-5-bfc9dd933da6@linaro.org>
References: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
In-Reply-To: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

Convert the usages of GATE_CLK() in clock-apq8016 to BRANCH_CLK() to make
sure that we poll the status when enabling clocks:

 - PRNG_AHB_CLK is a vote clock, so we poll a different register address.
 - The USB clocks are simple branches, so enable/poll is the same register.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/clk/qcom/clock-apq8016.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
index 274c71c53ff76c9a7ea18e3698c12b20a9b1f418..4eb2ba52be0c6f59a987acd0eacea4c7490345a7 100644
--- a/drivers/clk/qcom/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -54,9 +54,9 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
 };
 
 static const struct gate_clk apq8016_clks[] = {
-	GATE_CLK(GCC_PRNG_AHB_CLK,	0x45004, BIT(8)),
-	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, BIT(0)),
-	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0)),
+	BRANCH_CLK(GCC_PRNG_AHB_CLK,		0x45004, BIT(8), 0x13004),
+	BRANCH_CLK(GCC_USB_HS_AHB_CLK,		0x41008, BIT(0), 0x41008),
+	BRANCH_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, BIT(0), 0x41004),
 };
 
 /* SDHCI */

-- 
2.47.2

