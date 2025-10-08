Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93526CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 09:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E88383D46;
	Wed,  8 Oct 2025 11:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xgyZDIQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45A1B83D46; Wed,  8 Oct 2025 11:23:42 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 247F483C6C
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 11:23:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e3af7889fso43967725e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 02:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759915419; x=1760520219; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tc8JaS7h/mGEbGjj5RoUu70mJSQH1VGb4LNXKXULn3I=;
 b=xgyZDIQ2VvdYorRu5Ej9Kqv/RoQGczPhJnuQG/6ZL57DIS3SYEPyGNFjsEHUFQma0A
 Qe9v4gLyr3a7u5bRbJnu2T3SHwK3MorNOWgUmIDlxFxv0X5VCf7Pzy7/nHVLPmKaTZX9
 XYTFE6B8nK7y5MH40BvB/TH81N3fBAGulHlam6c+FLDPt4Mf9XLp3cqroqZHwdbsp4Lb
 COLU/7iRPFUtxUhCJmY80yARDQiNb+kZ64pa7IYW9Yfn6taGhJSZRIrKCvpkN2xwnTKx
 TS+/b63Xk/AFG7Q/Rfk+QtBGaB2bkIdc+UXiEu0QFYTiaf6ypAQHC51w/hWwFhe0nDom
 qJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759915419; x=1760520219;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tc8JaS7h/mGEbGjj5RoUu70mJSQH1VGb4LNXKXULn3I=;
 b=MUj4cYox5rhl9pxHBpwdogRcoRkjqkfviSN5epVscnqkH4PjivzRkGJ99jq2pA5IPh
 mMt6BmEY97is2+GMkBcSczaP+50sDe+ZNyhdaxFcE2vHC2AL9F9tFSyyCLTnmGqChBIS
 2drh/et2oBaJ1BlMG7y+6MB12SXRZ7i4pB46ZWf1OAzU6UGiC8GDw0Oe80IKyQrCbXox
 cF1o7iuGziKNucD0kVQbmQhJ2GqIJVYnzdpJVgbeMejqr4J09mTp5DrimSYFD5PTzIXX
 S49mNnNoFHed8pdxg60unFoRW3gw6US1DpU4ow4BWZikMlVQw1eD11yZifCDxwKXFk7G
 4Yww==
X-Gm-Message-State: AOJu0YxZuWffh+LcqAGr6Wqj6WNZp9caxeOjfJYfr6D1V0BFs3tB6vDx
 KyGpCcH8yRVyBTyL9VH5MLOEcvFaZ6uHKlzPDbfIzOzXpLyriDYFIQJjpUtoUhnALII=
X-Gm-Gg: ASbGncvFydqFHZ+Mby6k18zpkrB1PzcA5B7CGd4MxdWIrUfoofar5E7hJoA0LcMFRtH
 oGPAEKIUa1+sHyz1Nt4y6bjIbfTlaXkxC4QslwFJtvmrhsM5Ej2i7GLZuN5MvlQBGueVGwYwzYy
 KYyS5tCk4GmS3vmdA0S/HXfUnsymy82DOEKk5YBwcDxSr5zOwjMyIg8xeTijASWIe6T0JYfVFw4
 urX6M2XHmbtUt7FqiPru8lkk7AH27SYi8o+5l0HvfMixUtNBMS9tYdQp2ODyGSLXFPSgZN8hWPY
 GYi4xT6uJAzPpvfpjHcHWpJ0JhONYxnTrHG3G0oaFV2WKz/cueRRzba3W8xg5/Dxe/Rl4Jj/u+2
 CpDGs624ULC9UCcjvIpDKXi3nCTmem8AFRmcQzAlkv9BwTzNEyJqIBlRVk/7p+fZAvkT+EWpnQ+
 Gn9/A=
X-Google-Smtp-Source: AGHT+IHhcD7u74Iy3boif6wVPLSZQzSH4ts8rJr4jFiJfCsIk7PPRRqwStdUzam8byBWBxbi2hppxQ==
X-Received: by 2002:a05:6000:40c7:b0:3e7:68b2:c556 with SMTP id
 ffacd0b85a97d-4266726c44fmr1432577f8f.26.1759915419533; 
 Wed, 08 Oct 2025 02:23:39 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:5f9f:be0f:fb04:8dc4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm28864715f8f.34.2025.10.08.02.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 02:23:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 08 Oct 2025 10:23:36 +0100
Subject: [PATCH v3 2/3] ti_sci: Provide error code on error exit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ti_sci-v3-2-5866bf84adc6@linaro.org>
References: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
In-Reply-To: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
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

In ti_sci_get_response the check for message sequence will return ret
on a fail but ret will be 0 at that point. Instead return -EINVAL.
Also change dev_dbg call to dev_err to be consistent with other error
detection code in the same function.

This issue was found by Smatch.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/firmware/ti_sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 2042d88583766213e9d74dd17289cfd3562f0acb..534326be5ecedba1bf221d04d708b6db15f09706 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -191,9 +191,9 @@ static int ti_sci_get_response(struct ti_sci_info *info,
 
 	/* Sanity check for message response */
 	if (hdr->seq != info->seq) {
-		dev_dbg(info->dev, "%s: Message for %d is not expected\n",
+		dev_err(info->dev, "%s: Message for %d is not expected\n",
 			__func__, hdr->seq);
-		return ret;
+		return -EINVAL;
 	}
 
 	if (msg->len > info->desc->max_msg_size) {

-- 
2.47.3

