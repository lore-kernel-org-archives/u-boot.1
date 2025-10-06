Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEE2CCA471
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 15:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC8083DD8;
	Mon,  6 Oct 2025 17:20:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GB9t70hd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5D183C98; Mon,  6 Oct 2025 17:20:09 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9DD383D9C
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 17:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso45386235e9.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 08:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759764001; x=1760368801; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L431b6zwEwf1Opuo3VZZItqIAmCGs32TJtb47HV1fpU=;
 b=GB9t70hd6+gz2a5X5KVuxjoNedKZKfR+bvYxZs68RQC7IwNnbYHH3DHpJuR9OAwHJm
 pNG4/JAIrkaS5ZwpamIT9Z+cri8XK7E50BGWWSrh2K6rD3hFco4ks3vYjVYwife3i9Js
 vFlNTHz9wc+KM1H2oiVO+gzbWX2KVctLUGOJqXIeQYsqzWMVjG7IpwvW13EnxKC6ILbs
 SpIzVP0NZX+9lQpLH0Xdi7kABDYKCKt3UGbRwzfJQkeY/ikdpqRuvLQyu0PpguxUCOj9
 zf3jHgClCvumGtN0VsN7T8gd44OLLULrzVFb4GmM97lqzg/aEkCk13sTWKKoG5uy+baC
 DhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759764001; x=1760368801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L431b6zwEwf1Opuo3VZZItqIAmCGs32TJtb47HV1fpU=;
 b=psgHYBsV7V41wHvn0WuQK4HJqLuzYv3g8MVWVYzOB8eSOMrQ7huAP0tA4Xne1T+1eA
 0S9iTL0h0thN7hQlf/Aoj0Owm1WMIy1G5TMFYns+hBwuKmQ8MOnUaaTqL2bWO4ISSF2f
 1ZOp/LALBp2quPBSf8CUAzvmrNsW2k3LTSZm91BjH/u+cRpc1f6FrMsmYIElMEqxkt1k
 GPCzkJgdF8wZaLmIFSm4aBCL10Q1rkLEFNacKuqf+ZP8zivFouTsE9sqb3VnMQysbjjF
 TkBnJ5zny0icMDjANVtl0RXKXgVuCJHkySPYF4NEYm+HbTsvxWSLeoCA8fKrbjv4L71J
 11MQ==
X-Gm-Message-State: AOJu0YzUoIgjZs+Ulsxtvlt4pR85pUG6D0flWPwR6IQNurWsUqYuRjzV
 wJ4Lg28cHeDAdmF9XFFurlXYX6HUiFRbnMKiYUvBvcHeu1DOX20GrmkVd77jZia1yo4=
X-Gm-Gg: ASbGncubX2mjyVAe6A86DbSoIHlpXDnNJ2Sh/zmxj9gzGB4eTvFMKigCtf+KwmML2sx
 CCbfrdj5TgX759Z3a6cxSxe39sxQ0i6c8k7RFAgKYHXG4cVz2Co6no4eXCZwz43MbjqRc4u9iqf
 o9Zy9gyh//vPrQHXtIUjnuVsQBXkoFbe+CZgYwbV9jrq1RW0u1FNCqkyYwB2xamyDHjZN8QJzLQ
 AvXBdrdT83ahCYMsIpAZqbl6EE1a07DcYn7V4TA8rWEys2uIKWtWvQOEjPRZny2ggodsLlx4i0d
 zbXgDfX7F3MASRFlFtNKEmdrlAyU7pcMzliEystzMZ1L8cB09ektxBRxRZFkabKn0Ln7oGuVjLF
 G/JtomQ/oESCgEDg6Kx8uPGLgocMH1taXQPTnbNiKNGggZJAW/MB2sIZB15yS636qp5CRc3GZAH
 DFRkUcnRmcTtPA
X-Google-Smtp-Source: AGHT+IHCc6XSCwHlEPkGnagwJmBfc+hhnN+xK5yI0y5hNE4MtIa1kjOLao6pA5S5HM5ZBAHPy/5Q8w==
X-Received: by 2002:a05:600c:4510:b0:46d:cfc9:1d0f with SMTP id
 5b1f17b1804b1-46e71142f48mr84081525e9.19.1759764000985; 
 Mon, 06 Oct 2025 08:20:00 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:d8c:ebdc:373e:b4a0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8b0068sm21304971f8f.26.2025.10.06.08.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 08:20:00 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 06 Oct 2025 16:19:59 +0100
Subject: [PATCH 1/3] ti_sci: Prevent memory leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-ti_sci-v1-1-9cef92e1022d@linaro.org>
References: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
In-Reply-To: <20251006-ti_sci-v1-0-9cef92e1022d@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
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

temp is assigned the pointer returned by malloc which is used without a
NULL check and then never freed. Add a NULL check and ensure temp is
freed on all return paths.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8013afef304dfb70ab14150ddc49d43ebebb5902..f262da188f675b95ae217df418dc6df0364b4425 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3084,17 +3084,24 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 		return ERR_PTR(sets);
 	}
 	temp = malloc(sets);
+	if (!temp)
+		return ERR_PTR(-ENOMEM);
+
 	sets /= sizeof(u32);
 	res->sets = sets;
 
 	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
 				 GFP_KERNEL);
-	if (!res->desc)
+	if (!res->desc) {
+		free(temp);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = dev_read_u32_array(dev, of_prop, temp, res->sets);
-	if (ret)
+	if (ret) {
+		free(temp);
 		return ERR_PTR(-EINVAL);
+	}
 
 	for (i = 0; i < res->sets; i++) {
 		resource_subtype = temp[i];
@@ -3119,10 +3126,13 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 		res->desc[i].res_map =
 			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
 				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
-		if (!res->desc[i].res_map)
+		if (!res->desc[i].res_map) {
+			free(temp);
 			return ERR_PTR(-ENOMEM);
+		}
 	}
 
+	free(temp);
 	if (valid_set)
 		return res;
 

-- 
2.47.3

