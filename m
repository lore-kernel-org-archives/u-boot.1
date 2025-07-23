Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D088C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 14:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BAC483526;
	Wed, 23 Jul 2025 16:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wme/JotO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77A2A83559; Wed, 23 Jul 2025 16:13:54 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C013B83523
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 16:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-454f428038eso58529315e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 07:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753280031; x=1753884831; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pn2nXmDM8CxfPs3XzoHX6RBS/WmVK5xweFYxirkEMlA=;
 b=Wme/JotONHHSYtxTum4cyKahE/6wccI8VMLROfhmGnEKddQwf6w8UHfQzmxPVVmL7+
 8COlKcUotjXVHYM7pcfuCO8VmcQZfw/eUWT8QzRzJRfkgzx7hSMGTmMYVUcIWTdf2kiy
 /wLOC2Wz/g3/ioNhHJ3RreLb2w5YDZNOMeTHq3RH0zFaZrdIFtWeEphoOk9qcmn3OQGR
 hN0jtNtXut6TiLKjfpw7otvyuP/1770xLoQbEosSA4RS7VW+qQ9ujrBz7qQK2yGAGSeb
 TWJiADBfCL43w50zocF7IfcGQ16iE03/DE3FXT3HnBC5UyIZGS4bAsF0CFooEz9d6YZp
 JF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753280031; x=1753884831;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pn2nXmDM8CxfPs3XzoHX6RBS/WmVK5xweFYxirkEMlA=;
 b=lGbVTEEC4Kyf8HI3SbXq4reu0F5bKWmLiEfm9uF6lANlDEvhP8FWCI61/c/VYPqvxa
 VfXLh5IO4UHV729skUUo3V4yiL3JXY0jwHzb8vS5yxBneYfHWPqp3Nsg6GAgO6yo68FF
 6IANRjF+h5/0OPz8NxTCPCiTuem6/bDCYv++3D8jko2SbrTjxqATMDeGV3Cxf3Uhw6bc
 r4d1nfpxKAjsEwiZyJ9LEcBqoBsuALaTuDJa4RfZaWe1ibaLGzfVuqwl6Hb1VMxOjkZW
 fvmx+93QIiLYvMsiq//VFGel2w2k9b0YOaAQ8x0HNsViyzTbJih6CToMs2kS2x2aluJU
 wdNw==
X-Gm-Message-State: AOJu0YzWrFba4lqSeca+nTK7cLwOeNGur9J3WVGM7yYpg5CFUl7DjqeP
 xcdcfg7z6rD8nq7X9AMXwdJI7UP1Kyebxs9vhUwzDAN3nHk/p33GrGoH604cbjGXsek=
X-Gm-Gg: ASbGncuaPjVKlvvF1lwKZqaUxbomQxZ26OFfHFk607SqewsaHTu5dnrWxDtum0htgKZ
 JhCEhaclxzx9QdT97NFys4pWeu58Mx52rOhiYQs3h4bdSISL2kK/uk6k4dADcot6ya0yAVY8/mK
 kcXycC5laZB810iQluedXwkua4oM/Jdpf7z0ifznREBGAKJdIWKBvtGe0LRDnIedJOj+ZjBfS+5
 EYAW1TrMrUVMmK+TuRiK7hb6BWKN2O2XTAAhCn+lld4cpRqO6a6zfsDEVK5jLzlwPSfJB0hd5zg
 RrdT1T4ZZ0Kl0jtE8bYm/Tl0flPjB8Hk0itVP7YsoSl2IrxbunGeAHJLbEcBa1XkOP7Z+82noCA
 B6wMHMUXuw4kv/UclAdzdzF9+a8ceV9JlFRHCkUsN18ye2/+4HYw=
X-Google-Smtp-Source: AGHT+IE7/onmy/Nu3vkHiJ1Ettaq8WRpV5RqvybDvAczDj+L807Bb03aOEwC5Oj96j+vLE/+oE0mxQ==
X-Received: by 2002:a05:600c:6749:b0:450:d01f:de6f with SMTP id
 5b1f17b1804b1-45868c91faemr29863205e9.15.1753280031076; 
 Wed, 23 Jul 2025 07:13:51 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:cdd8:a59a:1949:12ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b75baa7072sm9416857f8f.2.2025.07.23.07.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 07:13:50 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 15:13:49 +0100
Subject: [PATCH 2/2] clk: at91: Fix use of unsigned loop index
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-at91_clk-v1-2-3b28da9bf12d@linaro.org>
References: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
In-Reply-To: <20250723-at91_clk-v1-0-3b28da9bf12d@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The use of the unsigned variable 'i' as a loop index leads to the test
for i being non-negative always being true. Instead declare 'i' as an
int so that the for loop will terminate as expected.
If the original for loop completes 'i' will be 1 past the end of the
array so decrement it in the subsequent error path to prevent an out of
bounds access occurring.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/at91/sckc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
index 6d6f12578db..3fde8ea7138 100644
--- a/drivers/clk/at91/sckc.c
+++ b/drivers/clk/at91/sckc.c
@@ -74,8 +74,8 @@ static struct clk *at91_sam9x60_clk_register_td_slck(struct sam9x60_sckc *sckc,
 		int num_parents)
 {
 	struct clk *clk;
-	int ret = -ENOMEM;
-	u32 val, i;
+	int ret = -ENOMEM, i;
+	u32 val;
 
 	if (!sckc || !name || !parent_names || num_parents != 2)
 		return ERR_PTR(-EINVAL);
@@ -99,8 +99,10 @@ static struct clk *at91_sam9x60_clk_register_td_slck(struct sam9x60_sckc *sckc,
 	clk = &sckc->clk;
 	ret = clk_register(clk, UBOOT_DM_CLK_AT91_SAM9X60_TD_SLCK, name,
 			   parent_names[val]);
-	if (ret)
+	if (ret) {
+		i--;
 		goto free;
+	}
 
 	return clk;
 

-- 
2.39.5

