Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C46D3CCAF
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 04:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1B4836A3;
	Thu, 15 Jan 2026 05:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kn87PW7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4896F80077; Thu, 15 Jan 2026 04:12:59 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B8E80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 04:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiffathefoxx@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b876bf5277dso193532166b.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 19:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768446777; x=1769051577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LoD1DI2IcgZjWeM55Pb3ypCYvCG4gTxznxO4SYySojE=;
 b=Kn87PW7uhMUve47b0UYoS2Nooq87u6v7PAY/Z/kKYVC4zO98Ymw8u49JcxnXHkTGWk
 0gFFu23RGq3oxxBP4ZgRVNEzN4dlprQ4/EEmKmwljolW4Vaxue3+92w4IW8UhBb56afl
 9COH3rqmpeBflSeobYA25y0H7sxbHdSJ8MmdamYvaFAHYEFQtzJepZbrkTOI1tQHkU0Z
 16BrQfQgxEDZUizRZM59PLh7V8GnTyTKkC/1ZRjSAvMmM5LMSxo2OrpcpI23yZ9yRwZ4
 sw2A+/PkV9UJ60Hn1fanbTU06nKEn4X8wtvqqzwLd93wvuPNFUTih+VmK5gm9x8acRSk
 eMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768446777; x=1769051577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LoD1DI2IcgZjWeM55Pb3ypCYvCG4gTxznxO4SYySojE=;
 b=Z2bZUIrlCIefZwIVYf0kMaGSRNZkZr2IZ0y6MAjqyGMd5gyXkcnUZu5E5GV0YdL7Vf
 cgbI2STsDyGzWVLOTdUQzxLZbQANUD7kiKrNxAwUde2CxaWMbuS1FW6YH/EOlcLt6mxH
 tHTy9j5uyCkIAC9jKPSoC832kGojXnizJeOCkOZJJfvKaZIBJ8JztZvUsOHvDYXJ2rP9
 RyTebNTRZzsE5KUXauIb6bXUr2zasV5NnPaiDvY7rJvc39a2FrkqT9DwI27CJT5CClsx
 EXz5iPqxaUnK/l1DTBxNTVomu83mDDvqFnEf2Eg9cWg1gIp+yufsQfs8hGLqamT4lU+u
 +qAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+keo6ilUcRl5IFIhezEwB6i4DQ2AReBg10rnGFscVIO3HdVJPEMMDI82VACWBQVXFXqLY9EI=@lists.denx.de
X-Gm-Message-State: AOJu0YzCYiN0HaBOb285FdVlWf6DUwl6oH2VEHGNS1E07kyQ8wrUJKyL
 7XQmimVoEFCUoepTprkYlr04/Yk0tDSI51lUE15dL2AYCClfAaPUrXrQ
X-Gm-Gg: AY/fxX5cK33fEQIbJpDfnB+iyNKOCbXyf21d8/vu8HE2peVPl7AhyQyR+jkq6vgowck
 Yqv1iSZov6bVkdgb4kjNUZHpWky1Uqg1f0Yz/1SUCPKJvRSKsn/bEgoGLvWl5sk767CDI1I8S0g
 bvVSdrtNAqSIDNCd+OHLyYamd4F0ePEZlpNHZHLTu1wlaqg+SDEVHk40+aVAk+zUk1v43/JhILF
 jhLLhS1JIoCL5YrTS+K5LtiH3AA9AlX+HFGxoKBPTBZIVwZzcZdJJmQAjCLLB1ssr9D4EteWKtl
 bpyQXTGlbxLg+9Vp5QguGISRHsp7r2qfMCcKNNmQiB2cUpW+c3Dv8A/kPyz3qAM7BACyd/29EHv
 5KLqjeeX3UCleHhBtcWBoILwvsCy6RG9Uklf0Ls61Ja3Cj43Fh4D+vOWs/ci/vpSMnZI0HNPu5W
 Q=
X-Received: by 2002:a17:907:d15:b0:b80:48f6:9cc6 with SMTP id
 a640c23a62f3a-b8777c8e6cemr133752366b.32.1768446776791; 
 Wed, 14 Jan 2026 19:12:56 -0800 (PST)
Received: from desktop.. ([176.100.0.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f9a9103bsm1341263266b.30.2026.01.14.19.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 19:12:56 -0800 (PST)
From: chiffathefox <chiffathefoxx@gmail.com>
To: Marek Vasut <marex@denx.de>
Cc: chiffathefox <chiffathefoxx@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] clk: exynos: do not reparent requested clock
Date: Thu, 15 Jan 2026 05:11:14 +0200
Message-Id: <20260115031114.220888-3-chiffathefoxx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115031114.220888-1-chiffathefoxx@gmail.com>
References: <20260115031114.220888-1-chiffathefoxx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 15 Jan 2026 05:47:38 +0100
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

It would appear the original developer of this driver
reparented child clock devices to fix the issue described in
`clk: clk_resolve_parent_clk(): resolve external clocks by id`.
This hacky fix was the cause of invalid memory access when calling
clk_get_rate() on a clock retrieved via clk_get_by_index().
clk_get_by_index() returns a copy of the `struct clk` and
when passed to clk_get_rate() it may be forwarded to
clk_divider_recalc_rate(), which will cause the latter to
run container_of() on a pointer from caller's stack instead
of the pointer that was kzalloc()'d by the clk-divider driver.

Signed-off-by: chiffathefox <chiffathefoxx@gmail.com>
---

 drivers/clk/exynos/clk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/exynos/clk.c b/drivers/clk/exynos/clk.c
index a2c9f4851da..aa4d4112db7 100644
--- a/drivers/clk/exynos/clk.c
+++ b/drivers/clk/exynos/clk.c
@@ -19,7 +19,6 @@ int samsung_clk_request(struct clk *clk)
 	if (ret)
 		return ret;
 
-	clk->dev = c->dev;
 	return 0;
 }
 
-- 
2.34.1

