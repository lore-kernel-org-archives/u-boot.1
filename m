Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F30ACA0EE4
	for <u-boot@archiver.kernel.org>; Sun, 17 Aug 2025 15:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAD283A6A;
	Sun, 17 Aug 2025 17:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ykq/q+Qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D75983A84; Sun, 17 Aug 2025 17:24:50 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FDA8349B
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 17:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-30cce90227aso1198272fac.1
 for <u-boot@lists.denx.de>; Sun, 17 Aug 2025 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755444287; x=1756049087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLMC5wZQH+Mvl3xBRYl4s1Zs0ER4NSPMfOkHOit39UI=;
 b=Ykq/q+QePZG+RxHyVO+5qBM7kNn7cULTJrqNgDeeJfvz7huecnPt0DsyiwXYcN6/Cb
 zImtKchjDGwrsQCSSrB+F491k5Ad2HMhewBpiZV2LR6faNXslfcr1bU3R8tf2SumwVgU
 mVa2UvCMJDiZFMpUsqsb2cF9NeFld7eN7dkw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755444287; x=1756049087;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLMC5wZQH+Mvl3xBRYl4s1Zs0ER4NSPMfOkHOit39UI=;
 b=t3Zuq53mowzpQEoCs25Ad6dxVt/I3q9Q5dbcqb7i8Ug+jklWB1MOYYUVc6imDCk9RD
 V0wRFm5e+mFkicsVAnyQmIZ6j3I12lWavk+PF71QE9m0FrAaefb1Hy8RzsLoR6f7FcYS
 JcIDHTa+wR//w6l8WeQetmoTDXvcPy4+Af0FK/kHesEdqWYiJtufQ9B94n//DBay+jvN
 5X0ljSMVHeEegSCelP3Mx11n4V792SIEHdA6yn5Achb3OSiAhRSnk/BXwbN85gZZBv8L
 eHjarsb+QtknvGAxRyJwMfXZ6fuQwlDGqO9/9qcALASclDWFdUndjmtzCdMRxQvkS7Pz
 xayA==
X-Gm-Message-State: AOJu0Yy58xrvPe0FVQnYDz/TKY+3SCcDQSb7aDIR1qWbkNW2lg4gNZ2z
 2TVvEN3oZ/DVCfD3oWjccc42HtWf0yb9TIt3ewyvT6J69DSfaAIMw7af+CJBgxtSsMFugvekiSy
 N6OalA7s=
X-Gm-Gg: ASbGnctdsl8vb//9oeRhbQ4+EEHILhbQkfEsfwxxnu8KIiwxlxc2DZ3XQBS/SHtNKpq
 lBbJuwHe7X8Hup13sirLADsrSAD+7u0gBUH1XfvJA/IuRRlJtMjJaitwv2z4bYIq/BP6/4cGbJ3
 xcCL5P8pl35K7QCpJQyZtI8QqDRiNigIcP7JFVxnuTFUtXXVwsEb73oXjjecO3oz3QCdBgu45vN
 cBoezkddSBIaBayynU2a6OWTY5cxi01qNzvE0uSKq5EdyHqqA5J84hucR/LqRjKMLCHEj+H42Ub
 hyDWroYVm/j1yoia9A2LBGUjJbkjaCTv1NQZ1nap8zV+KVQXtRJ3DivPmV9DwnPaWZzJb4jC6ZW
 QPwQf1FEJKCWf4YPjcpNgNg3XcpoHzrO+jBmKHSVAz2FJCPD4gjeBJKBA+tt05N8xGQ==
X-Google-Smtp-Source: AGHT+IFJlsk1kWhigJHW/MkegjKfxSDrBSB+n0KYpoyU2kjcoMYo1sBOvPqu31IUyCbgi/sRDgaSOw==
X-Received: by 2002:a05:6870:b88:b0:308:155d:47e8 with SMTP id
 586e51a60fabf-310be4c89cemr3380492fac.16.1755444286776; 
 Sun, 17 Aug 2025 08:24:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-310ab878a4esm1998472fac.3.2025.08.17.08.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 08:24:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250806-net_ti_am65-v1-1-aa819f488ab6@linaro.org>
References: <20250806-net_ti_am65-v1-1-aa819f488ab6@linaro.org>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: Initialise ret
Message-Id: <175544428515.372553.4001433311055695200.b4-ty@konsulko.com>
Date: Sun, 17 Aug 2025 09:24:45 -0600
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

On Wed, 06 Aug 2025 11:43:47 +0100, Andrew Goodbody wrote:

> In am65_cpsw_phy_init it is not certain that ret will be assigned to
> before it reaches the 'return ret' statement. Initialise ret to ensure
> that ret is valid.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] net: ti: am65-cpsw-nuss: Initialise ret
      commit: 1edd1fd539f52cadcb57c0c79c504f46f9540045
-- 
Tom


