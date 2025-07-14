Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1D6C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C3F82FAB;
	Mon, 14 Jul 2025 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f+E8Izzv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99FE18300B; Mon, 14 Jul 2025 15:20:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9461582F8E
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4560add6cd2so12712665e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752499256; x=1753104056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7v1/h0DJonUa7aYocVIg+oCrv5xvF7qxIJ4ktOQR1BU=;
 b=f+E8IzzvikXXZLJ0N11GHeipjp1oiKsGJRJpX8twDAKawAUT35GWk4tH/+cWX5Z+3e
 I7HZbX+3WNzYkHw/1nSZJ41Rds5QBWH0QqydguMq3kCS6bKywFcVVgqPdJlek8PKRflj
 sHviAElKnqEYSJx1kOn+TXYNycBr+4x5twi9nczTw9mCkI6LWuOLroG3tiWipVVoJPpC
 lq+cEmV5/VwS0IIRIf6E39h1jYLcP4gczzbCOB0gZKmv+SvBM1M5JuUPYyQrpdF5xQ7a
 O9Xhr+UyLweMZp/ZxGBJCAHpqP4Q7Z9dEXo+9pL72p+U394s7O1HThFSbZZ1NZAgedbL
 1Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752499256; x=1753104056;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7v1/h0DJonUa7aYocVIg+oCrv5xvF7qxIJ4ktOQR1BU=;
 b=r4NELpcmneyTy2kBEBmNyfgCPR1428ZmhTHs5lxGzwLnxo/azCpHXyxe+YNL9mJkYO
 SwFSIzm1yCxJXFVFxt4DadmHBPl8QxlI9y0Yctk/p7je1L3K+zYGYJaXEpqRG/iCIGzY
 Xs1h6z/KyuMXGj58ORKoXiBelwChg/qoRKFP39jnro0Y0Ycv6Oa+hvcxkLtpixbaemNU
 Z04jdQf8VyCd3t28rWlVhOaKTD3FcP3JxbCCZbG8WjN3kj2nZUpqifWGAWn2c6VC8UG1
 YEQBhO7Mun5lELbTcoEl/wuiHyaH5rihaa9amuu35NNV0np41/NghS7E331N1o4Rfszf
 lEJA==
X-Gm-Message-State: AOJu0Yz/zIcOD+qyhNpnvTmHY6kOfr4Tnzn0TvLeGZpmcSQeI43pg1p/
 aiBniOf1hKkvuMVsIWf39H5WDzx/Pu7+zssLzwjgUmjjD/KDUydjf433PFVXAUSkoxE=
X-Gm-Gg: ASbGnctOSnBgW0rF8BKUT7mPUK6ul8CvYqQvRgCMhzlohobS+oxvUBswPMnIWOSSF/k
 P3/V1YmcuGeGePyRkqJSuiQNFMxV41AQaEHayYXvZFInApLAwgt8Wi+Jl8JFwHsHuHC1Pab940b
 emP9UJ+v606r+eES1DacJAluZ8rBk3lkHA9MCzjxfY2EM8Pszv47Wll72nGIQU3CImXaNhoppuR
 Io7hzeKOpEPSabN3prnLNdd6epNPWaZrqToN97uD0deJx6wQHdo8XpiCea+18wNTQlgdh5n7Oa8
 IVWuqzb9DkB8Om+tjraskf4KTYZ3XC3RxAzSFdAKK7kos2fHIumuX9QhXX5UeiWUlxbCcDh0qnX
 O7pFwEB+GTEx7+JxHfgFrVGs64WzgrjC+/lSb7BVBle/EBfUX7ahBa0KVI0eMrDiA7+Va0Q==
X-Google-Smtp-Source: AGHT+IEbKQFurzzPkf4mlsDX3nn2RLkX8yMDREOph7Z/bKS0s7bnjK6sxZwwkhYPHGIKSD/krMITHg==
X-Received: by 2002:a05:600c:6748:b0:456:12ad:ec3d with SMTP id
 5b1f17b1804b1-45612adeffbmr50217775e9.14.1752499255932; 
 Mon, 14 Jul 2025 06:20:55 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561323a488sm50411585e9.1.2025.07.14.06.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:20:55 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
References: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
Subject: Re: [PATCH v2 0/2] gpio: qcom: rewritte SPMI gpio driver from
 Linux driver
Message-Id: <175249925480.3236715.8884454376677211774.b4-ty@linaro.org>
Date: Mon, 14 Jul 2025 15:20:54 +0200
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


On Mon, 30 Jun 2025 18:04:43 +0200, Neil Armstrong wrote:
> The current SPMI gpio driver is very old and doesn't support
> pin state tracking to fully support the whole pinconf calls.
> 
> The simplest is to rewritte the driver using the v6.14 Linux
> driver and fully implement pinctrl, pinmux, pinconf and gpio
> support using all the newer interfaces.
> 
> [...]

Applied, thanks!

[1/2] gpio: qcom: add new driver for SPMI gpios
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/37bb973b6532
[2/2] gpio: qcom: move pm8550 gpio to new driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/959bff0584f6

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

