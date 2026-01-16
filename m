Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF771C982E4
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 18:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2610C8389A;
	Fri, 16 Jan 2026 19:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CnONhSJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A8783935; Fri, 16 Jan 2026 19:03:08 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7FE82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 19:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8765b80a52so369176266b.2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768586584; x=1769191384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S+v6aPYdoUNQvRlBSQIE1vle1jNijiUxOj7EqownQ0E=;
 b=CnONhSJCzhvzzXoYwvt9jmU5jSLOqb7vc/JMAtOSfAk4UpneS5vv3fMcD/P45+vcqy
 GFTdahXTx4LIl1PZU9qPqeZysElLBudE9Gt6IP/IutgdW6v1hPTq1Dk3PgkX5+3X2bqv
 02I5rSnfPVg5Em4G4SXVyLYmrM08k/ztlgL9sVInSGu/MeoczMC3iJhiPtjtP2FBpdk2
 GoQEorjNlhCJc9JpUywjLz2pS0g7tuEg9pgj7C9fk3+5B2B5l+0bsoVss88TqSWVbkFQ
 VszZBxahWC+BZ+lCTbl05lWXXeKoL3bznoxle9ZUvTIcRoPlVWazpubCUYT9ODm6hgrV
 lZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768586584; x=1769191384;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S+v6aPYdoUNQvRlBSQIE1vle1jNijiUxOj7EqownQ0E=;
 b=ayy3LT5wc3Pyad6Dpt34PhqtwK9uXRtGo8lYnVBSKCQhIK2rECxeIQsL+faTctXfyP
 EGHT22fKU2phJ8SnpfjhF36w6MgF/R1HNO3Uzw35ekX8GRi/Zm+g/VJStnl8BWiG8EtV
 8WuMo6O8G3rCu9omciILyjVLnCCY/h82w/guRr6e00bsNtwS1h+psvJbIDHzYYFghsfx
 EXi1dnGJ8Y1U6Zqhq/49HaO09a2QIa6b+RLTy/uRM/Uoj7+abLPf5lMRZqcslHm+3IPi
 3VqWFkHImyDVoGVxr9EdC934YomKL8SEW/THYJLLqETQ6sQfvGGDuMbTTNqfuXzo1Dxa
 IxlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrsZS24keI8vjGmLFSW8qXVc4sX8FPTmmFwRccLFo2yc8FNv0echN88drygMdvWCXti8bMsyk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7np2T+xFqg8qd+EgrbPEDrCun5dagstxqiG2oiAPYhOvNAsQe
 VOTUvX9tiMldRrHaGent+rzGcRsML/FKwh16b6JioSsb+fitgLkcShv55yoTE/A/w40=
X-Gm-Gg: AY/fxX4FK4AHQ0LwY1rdpTOY8tEtbJjLiIuFlO8upldmHIMAu8cjqMRpMrkJE3c9mdH
 cGvgnRrBM5hJhjs/WBIK35PCEuuDbyWKNbQUZmXPyS9ygadu4Ml+4/Pfly9mLBpDgJrwF32F5+g
 O4m29cT3zgZ4rHbbQvILbhNjnnS3QJbJcPPu0DrcuQerDCLg4zuGgeZ0fGVs5OViu8z22jqMaVy
 6Gemtt7nAV2ydM/5/FNROY1hjJu+0HhmoqYSEQigIwcBz47xg3lQqouNdsdoZj7Tygzq9PUeNGA
 5R/NHVmuR4K47XTz/UNnvqD7B5RYDEe79Bm0zFc+Lp3iL/fMcI80QPFc5FCWjSEcZN6Vs7kvjfx
 9kUrOQ+2mIyyu+C5K2RXIlRpa7t2YmCQSoiKbIsJUcFcZn5xv2KnWd8tarGr2D6djry70VSSkzK
 yQL4FERdMjd/zSJ2mE3CF50R+9JJkkvJ1UXU7gCZZ08xcUN3hd91XfKQ==
X-Received: by 2002:a17:907:1ca5:b0:b80:3fff:32ea with SMTP id
 a640c23a62f3a-b8792fede57mr355933866b.57.1768586583944; 
 Fri, 16 Jan 2026 10:03:03 -0800 (PST)
Received: from lion.localdomain (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc5e1sm2932712a12.19.2026.01.16.10.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 10:03:03 -0800 (PST)
From: Casey Connolly <casey.connolly@linaro.org>
To: sr@denx.de, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 trini@konsulko.com, hello@paulsajna.com, 
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de, Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>
In-Reply-To: <20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com>
References: <20250625094607.1348494-1-gopinath.sekar@oss.qualcomm.com>
Subject: Re: [PATCH v2] watchdog: qcom: Add max timeout check to prevent
 overflow
Message-Id: <176858658267.3399278.13079756794774770565.b4-ty@linaro.org>
Date: Fri, 16 Jan 2026 19:03:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
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


On Wed, 25 Jun 2025 15:16:07 +0530, Gopinath Sekar wrote:
> Added a check to ensure the requested timeout does not exceed the
> hardware's maximum supported value. This prevents register overflow
> and ensures watchdog reliability.
> 
> So, added a check in qcom_wdt_start() to ensure the requested timeout
> does not exceed the hardware-supported maximum value. If the requested
> value exceeds the maximum value, then the timeout is clamped
> at maximum value.
> 
> [...]

Applied, thanks!

[1/1] watchdog: qcom: Add max timeout check to prevent overflow
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b2446a231431

Best regards,
-- 
// Casey (she/they)


