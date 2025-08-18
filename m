Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FC9CA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:32:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425D683253;
	Mon, 18 Aug 2025 12:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HAc6hoAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2753A8323A; Mon, 18 Aug 2025 12:31:35 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09064829E7
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45a1b0bde14so20186315e9.2
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755513092; x=1756117892; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2g5b9RuTaBSMroLQ6bhB9kHG1F23bmhABRbfLKCpLs=;
 b=HAc6hoAjAqggsQ22xGdwJWhKRJbN5FW6thjdzW2bSE8pvykFjNx8yBbwhzWPOJJEcL
 b96vjaBlKJsSyw9U8wBSTmgv8+uE4LTTtTpwV8XJ5STOV5pSQe8scAtGINTcwPZtAi3w
 4+fMr1ba0h6vS6g9NszuQIqC6QUTlzH1haXWQ/vyNQDaJpsyz1jjCJlwrTy4bb4PY5yH
 QZk4oVljOk5L1pmpTtZrNeb5+ip+C8PWBJIODByRtFO9jAxc6Yc0lGeXjK76e05kP0hy
 kLtw71uL/yKouDVOYf2ai35O0dPoksHiwcittqY7Y4hsnggD0PRXSdTJSpnxWj4ZwPmD
 Znow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755513092; x=1756117892;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2g5b9RuTaBSMroLQ6bhB9kHG1F23bmhABRbfLKCpLs=;
 b=h0lMuptE/rgFabJC7TOIMfuJP18Yr0xp6e+4Lg07cnQotoYvGxppKOuca/YhPZ07RC
 P6iumUYnSNaaHspYahBZaxGO3A75Jo/kHpM3kqrhOxwm8jPSiRpIzrSVLULMAorqlS6J
 4p5G/5sGQedtxh7Ch628pdklwTJVMpEeKUpZz1KqRWGb8MNCHWfdj7mKTybM8hMHproj
 tQBRoaEYRxeZzxdOiSpI+jt5enGwRm864UDspcYmOKVKtWLO5BIaCaRCTr8Pxe3z/8t7
 as+/XG25iuYrGG0P2hTMviqHPizgjZkZnaFXK9aoHeuR8ysU+nt6pYvyJCqJ36C3zlXv
 eA4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5K8Y7OEx/si4C5yJd7LIMFjZ+FyH5/nGmzNos/smRxkv66M9p0XqbnSMHst6Mp5FbtNWjr3A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3xjcMFVcx4+5bm8Wx1vkGK0DtmEz00l04fvUzXh7iw8Ii0fcD
 HbQ85UMRkYc7cOJhwT8y5Psnw0zPL7030X0TSmTOFd5T6c+O35eZAXK77rU/p14jwh8=
X-Gm-Gg: ASbGncttlqNFL4jAeLvVzFbUonfIL1vxBXjG9hV7djpTDr87tzHWK1/4HVXpWafy7La
 JcQDkrPRJ65xcPhMiRuwsBGl/1cLozJerjkUnVs5mkBQVKArzUsbZga4F4bWeJINwLD/VtZs/Ms
 mjuNLj0p4P/fN9h2VZMO7JGCjppxSRbnw4i5/+TJ8T3js2JNgsTRV4XylheByJ8kgdvQAu12OKA
 L1HjHs1Ahxf1D/mutdPGyVDw9kLiB9g7rYq38PMtefh6rnmQtxF5ppNERZlr4768hlqBgmqvzO1
 3Hwp8D4PHFn/hiyp/WcBKDif7l94k9E0NurYSNYC/wgJsmf5A+viXudxLOV88iWOAoVEDmtliOR
 rJh2A3i/rechiHCHUQGtkF9mfCCuFCYD100czOUNPprzhdbhbw34eL/SEP85CNuHIbjDVlwSf+q
 u4wg==
X-Google-Smtp-Source: AGHT+IHGusUTEi8jNiRDH1WNK2ekwDVGq53aDpVCZxJvli77YmvVyoww6vr/Rk5JmF5cSs5OTrAnAA==
X-Received: by 2002:a05:600c:1f8e:b0:459:e35e:a90d with SMTP id
 5b1f17b1804b1-45a218581dfmr82667975e9.27.1755513092392; 
 Mon, 18 Aug 2025 03:31:32 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd6f.dip0.t-ipconnect.de.
 [79.195.221.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c76e9basm172438035e9.21.2025.08.18.03.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 03:31:31 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250723-button-qcom-pmic-v1-1-9c317ac71167@linaro.org>
References: <20250723-button-qcom-pmic-v1-1-9c317ac71167@linaro.org>
Subject: Re: [PATCH] button: qcom-pmic: Fix dereference of uninitialised
 pointer
Message-Id: <175551309125.842888.3670689188548983830.b4-ty@linaro.org>
Date: Mon, 18 Aug 2025 12:31:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Wed, 23 Jul 2025 11:58:04 +0100, Andrew Goodbody wrote:
> The pointer 'label' is declared and later dereferenced without ever
> having a value assigned to it. Add an assignment to this pointer so it
> will be valid later when dereferenced.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied, thanks!

[1/1] button: qcom-pmic: Fix dereference of uninitialised pointer
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8a0bb0b17606

Best regards,
-- 
// Caleb (they/them)


