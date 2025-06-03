Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4752FC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F2580F9C;
	Tue,  3 Jun 2025 17:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wDDCJjnq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51A0A82A8B; Tue,  3 Jun 2025 17:00:49 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1614E82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a5123c1533so845009f8f.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748962846; x=1749567646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqlD5asc+Ldi1WeA4I+E1YyvT/lZwqFVGFKtiX7LU2I=;
 b=wDDCJjnqsKK/QYy8j5XXiIN/sNVmfKsxIdQMgDFDOkjYOpeCR3G0CKkBLTg3VS+JBW
 JWxTr+nELBhCasolWvXnIn/PjZVrIbDyYKxtdA7IoRKAqGCFO1c5+GbQMB7VKi81/Mz+
 87pUZdQmmoSKeHjVnKnaCqXSkHXXKAMyb+k50za0we5qoLjzKQDzs/zTvMKa39y1v1dr
 PhgP5K39ftibigs4/227Tq6/17GsY4Qs5/IpDNC2hbb+VsxD5PEQEcFGvBSAxWRNYTu7
 d0jUJf7NH9qDK8t/pWa4RUqwmm6+DGRg7yL9TUTAG15di46E6AvqatkzsjJsQgacuKzZ
 tl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748962846; x=1749567646;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqlD5asc+Ldi1WeA4I+E1YyvT/lZwqFVGFKtiX7LU2I=;
 b=xHuzfhH1RJux4MjoQvjBDl/coJ1q9qYlmon6Hdd9jcl9/rYA6Vch/+3DH4sEFvGly+
 aGTPfgWFU400l6fav/cEPD3uBkv1qQ9C03lxJnXlsH8ifnohwUW5kjAnOjfoWRe7DVja
 a0q2AXmFT6hWy+t2VJwonP6GN2n/tVz/DbM4W6ODmvI9JIwQvpKM9VuJ/5u9fPvlHatM
 MDXzpYk5G6sqi3gEmdAls9UxIU933Khcit2g22C1GhsytsfUvMTGBkWpTqzZBFX7mxq2
 up2+D4Wv1gADAUQoTFziUAYnSvkN1N2wK/5AIaQcjMHgryCZaB88lWCly5/QTvrsSy2O
 uczA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0tnjnLf2aJqhIwPhl20zV5pHHYAGwpDSQPHUsJPoq7e9X2V/qbgU8aZYMl/DfBUlvQ9woNvc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0jNUs75/DIt/aXMNAIowaw3kForQf01wOaQZe8izr8yuL8qzh
 75Xeql24Hn8Iiu6IkPFV0SxFPLRf7zWkzZ3PmdXztWyHhPbqbr8DqXeiLiZLX7cUJbc=
X-Gm-Gg: ASbGncs9D4l7bnsgFnrE0NZ2ejV3aitIy3bBIR66EKwS4QM6EByNUU9Pt1KnGf7SAup
 Yvb+n+D3MnPx5VLU16xOy1yFb0QEqQU0CrAZ7uad1x/yaZ2Ksf3V775q7u7SHE95+MX54zqqRpx
 XX4B6GCK2AmSfD5OAj+258xupEaLR/bcLBj8OffEB4c1Xace4WTwm19gQ/CI0W205hH714w2mpP
 l8IyMkImtoNMKbwuQIOf+g9pn+ovqnXbKzF/cm5Z293DtS9qV7KQl96Ead23FXq39/JD8RW83Cr
 i6rkBtmkYq0qzwlSaByUwFOcfzB2LpomPB7e2IEmiV+Am+JULGl295MxnS38zFuGm/VazWfXhki
 Z
X-Google-Smtp-Source: AGHT+IHEv80YPTP9UlMDNfKP73ghw6sa/KLr71ujmW7GNJVgxWkAs6FmQsP/EOXX4nS+FAHTfmcAKQ==
X-Received: by 2002:a05:6000:2c10:b0:3a4:d6ed:8df7 with SMTP id
 ffacd0b85a97d-3a4f89e2536mr11438795f8f.59.1748962846050; 
 Tue, 03 Jun 2025 08:00:46 -0700 (PDT)
Received: from toyger.tail248178.ts.net
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e5496282sm19845165e9.1.2025.06.03.08.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 08:00:45 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>
Cc: Tom Rini <trini@konsulko.com>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20250424014811.3809818-1-alexeymin@minlexx.ru>
References: <20250424014811.3809818-1-alexeymin@minlexx.ru>
Subject: Re: [PATCH] button: qcom-pmic: allow to specify code in devicetree
Message-Id: <174896284487.1020546.3989003067631934343.b4-ty@linaro.org>
Date: Tue, 03 Jun 2025 17:00:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


On Thu, 24 Apr 2025 04:48:11 +0300, Alexey Minnekhanov wrote:
> Most device vendors put "Volume Down" button onto PMIC RESIN.
> But Sony is special: see
> dts/upstream/src/arm64/qcom/sdm630-sony-xperia-nile.dtsi or [1].
> They put "Volume Down" on PMIC GPIO 7 where others usually put
> "Volume Up", and KEY_VOLUMEUP is inside &pon_resin.
> 
> Currently if you boot U-Boot on such Sony device, you end up
> with 2 "Volume Down" buttons, and no "Volume Up", which makes
> navigating menu problematic.
> 
> [...]

Applied, thanks!

[1/1] button: qcom-pmic: allow to specify code in devicetree
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/c92bf21e731a

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

