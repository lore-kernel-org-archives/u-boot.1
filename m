Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425D3C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9622583893;
	Tue,  5 Aug 2025 16:53:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TU1lN/A/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD368386F; Tue,  5 Aug 2025 16:53:39 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1DA83885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 16:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459d7726ee6so16523355e9.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 07:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754405617; x=1755010417; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t8I5Sdb1P2+z88zDD2MUOf5551LOVIXPJzpkRYZG8Ss=;
 b=TU1lN/A/lJtgX9jcIWO+lGUM3CptFwbjET5ll1p4D2+0XG0vS8VCpkX3wROs+ZeygK
 f8PbXTkWjNEnIGtYUxRi7rOefDdDsviXTcbw8CTNSlxEn36tLARnCUVVuERgdk+Mexgv
 /uGnPE+k6t5obsHqhRiPPhbdH3yripxSRPFT3lCtZHkhQ0Pr4FH+AyUAHPvs98s5i0O4
 UJY42jU7+WycLeZyghnJUw+kBeQjF2dglJlt6b1BXwLOtWiM9uLNuNNvRy2UK4NXVUeF
 o6krlSI8P4al9PJkue4D06ou55p+XbgPzy4yvI4769b82B1oDtBRwb4mOVErIWhIxxRC
 eI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754405617; x=1755010417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8I5Sdb1P2+z88zDD2MUOf5551LOVIXPJzpkRYZG8Ss=;
 b=kIYbUFEu0pDSvF03AqGGwwK+Uwc1ZRrc5tOB6bvDLrzrh9HpPpsYCAP0FzL4Yd4Hdh
 nHMC31uNJiotiGpUJfLW+fE8wa3zjX0WCqGtExT7QhYrrtvK23e23zo4E/OXDcjIFQ7w
 PvRtFDQqwod2XM8ib9gcdtM9a6L9R7s3n997p07nGiPZ3058kQy841/GnPhqsQ0mexsW
 ccICxjR4gpDHsrT7Gjs9XtpIXZ7tOuTHgZrmaBLPgbveoAQMZCZQvUWtRA1EV4Q9p1e3
 zBE/FIoGrpKW+v7uLVHwHt48whrSthbzPqZxs9Q8kfAM/PnfrwstbX2u8TjnMhnnIpmK
 UwpA==
X-Gm-Message-State: AOJu0Yy2fwirVaBW/Ub4BLMB0g6yK5p3jttKNlHXDks8WGygiEzhR38K
 YGBCLcjMlQWtls9vb8pryMN3PI25HzUVDFrJOntBhKTS0vgKHawnKHeRdoYp/W6Z2eo=
X-Gm-Gg: ASbGncsJZXsA/dj7ghmUkQ/lvoiYn9ahzgbpYQW0lBGlSD3KYJXcGvOC4Suz1GhSIP6
 ncu8orKYxv2RKIHDvPL5FajlXaZU02gvnYLVE8ek+3kk568QQj1P+yP+LcY1WudgewkBFcLZzgr
 S5+JjfsADbdNFlNfuVRymkC0z60Zzt0+7cBs6imQ75jHL4tlWWSbKPPBdxMr+iPl7OitLwLamVf
 4z5c/ke3MvP/uy+KR99iir0MKy8CjCPLa3/BJ/P5jseQvsn79nxucCHZ1aqXAe+9hXkakKkU4Ed
 1RbuOrhlYhLVOJWOwHqxpP/yTOht+h7lc6J5x1BZoZeT4wq2dTzN76vv7buzoDCbSlriXbagN5n
 SxwwtNWE6et6uHl7yH6p+8jLAFjf5hYcfawX8qyk8X+olPNR3GNk=
X-Google-Smtp-Source: AGHT+IGos7fo7iUaXXqBYv4UBfn/2E1tec437Szq6Sg8xAMIY7nxUbpbMg6C5UZrgct3KBuUD3NkgA==
X-Received: by 2002:a05:600c:3b08:b0:459:dde3:1a37 with SMTP id
 5b1f17b1804b1-459dde31e84mr47273455e9.25.1754405617076; 
 Tue, 05 Aug 2025 07:53:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:60bc:24e3:6dcd:9f35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459de0d4cf1sm66075875e9.13.2025.08.05.07.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 07:53:36 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 05 Aug 2025 15:53:34 +0100
Subject: [PATCH 1/2] net: octeontx2: Restore default value for err
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-octeontx2-v1-1-8b804a3760fb@linaro.org>
References: <20250805-octeontx2-v1-0-8b804a3760fb@linaro.org>
In-Reply-To: <20250805-octeontx2-v1-0-8b804a3760fb@linaro.org>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

In nix_lf_setup there is a default value assigned to err in case an
error is detected. However this default value will be overwritten in the
for loop so that later code does not return an error code from the
function. Add a new assignment to restore err to the default error code.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/net/octeontx2/nix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/octeontx2/nix.c b/drivers/net/octeontx2/nix.c
index f596b6bca87..87d1f7a5dbf 100644
--- a/drivers/net/octeontx2/nix.c
+++ b/drivers/net/octeontx2/nix.c
@@ -298,6 +298,8 @@ int nix_lf_setup(struct nix *nix)
 			goto error;
 	}
 
+	err = -1;
+
 	/* Alloc memory for Qints HW contexts */
 	nix->qint_base = nix_memalloc(nix_af->qints, nix_af->qint_ctx_sz,
 				      "Qint CTX");

-- 
2.39.5

