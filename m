Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421ECCE834D
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 14:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC33C88915;
	Mon, 30 Sep 2024 16:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M0UoaiS9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75F288DD9; Mon, 30 Sep 2024 16:27:20 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E51881C1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 16:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cb7a2e4d6so39465655e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727706438; x=1728311238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTy4NWgRgDq+j6izR3kA2Sx29gvr/380M3CE+fbX1a0=;
 b=M0UoaiS9YattBG2FG6Wf2Un7gLAWdlFi50jboJBhqXJGRRkz4NH5qQ8vN/5eAPDiTZ
 nQsluLU9hh+bqOvDxHMBr8NtrS/opjcAnenuFPdjA1YBc6GLd7l1A+qr/NTYVVfDaziw
 p2nTwm6qa+yFKuw8FbU6h5EZ3/7c6A2bLpYEpmXahsKOYZng57/OjwZB+RMYr4uR2WN5
 A+8AoN+QZfx9B7gBpVquYODx1827p4G4cKRn90+ORWjVe7d5ayJ5IP+5OpFCUIfVlyvx
 pStgFiix12ijwIdtlSawHJT+nKIY4jB4ZSJ0Cw1cbQUJcKdNm7zAc0JZzoT0kik2rO5b
 BrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727706438; x=1728311238;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTy4NWgRgDq+j6izR3kA2Sx29gvr/380M3CE+fbX1a0=;
 b=X6PMyaWYFEO9lccEGS1gksyVFJShhMLzEFlAarlXINOoS8ZeTfq/b89/XhJjhxA4MS
 UrC7/FmuUnVi1KTmWy8m9+x3/a669tIrzMneLdLsSCPsmHsk1dlF9I603RgvFhAr7dSC
 v6wUO/4zmKdwlC0Ov+jHcUA+x4TLJP48AdaEepTgjUQqswYla6zf2CcyL/vqSRARZRSZ
 Vc85qOWD+dr7L81oBPd9L+qU18b7zJq6Duu041I8NTobytR0w8vCE11SwlGVPNLMJPGH
 XKab6+miC0aMAEuvOsuVD7mSJ1cse4WWlHRf7N/Y3CJROsOIwJieKW0Wdg9tn9APnIxP
 DUzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVStfhy3rH5umHl5udLGrqnBHDUGH40x9URemwoZRmcqoXVAiuS0+PpY7zhl6YbvCMheJtdBtE=@lists.denx.de
X-Gm-Message-State: AOJu0YxftSCx7YjV3zDYaAprcAXGfj3EpMNumjpDlIL7K6tJIBgY8ndr
 KaAnn4Yi+8hBV9UgRVA46rgXxq9Vt2DXSDhw5+ZZNxsKAgOcwteLcLyqsE1ytts=
X-Google-Smtp-Source: AGHT+IGkVkRLAnFMNBhq2ckUOemFjVtte20pPdMd8MyjD2M8rkjLNilgJw3+H78iaM35SB0WEslugA==
X-Received: by 2002:a5d:6585:0:b0:368:117c:84fd with SMTP id
 ffacd0b85a97d-37cd5a6b529mr7989547f8f.3.1727706437918; 
 Mon, 30 Sep 2024 07:27:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d2e8sm9303200f8f.18.2024.09.30.07.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 07:27:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>
In-Reply-To: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
References: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
Subject: Re: [PATCH v2 0/2] ARM: meson: libretech-ac: add support for EFI
 Capsules Update
Message-Id: <172770643662.753773.10601289383991053323.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 16:27:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1
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

Hi,

On Tue, 17 Sep 2024 14:34:44 +0200, Neil Armstrong wrote:
> The necessary changes were made in U-Boot to easily support
> EFI Capsules Update and be compliant with Arm SystemReady IR.
> 
> Let's add support for the libretech-ac/AML-S805X-CC since
> it's an easy well-supported target having a dedicated SPI
> Flash to store U-Boot.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/2] board: libretech-ac: move board support into dedicated directory
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8297f25e99f54b9ba8dcbf68a9299ca1b0022f14
[2/2] board: libre-computer: aml-s805x-cc: Enable capsule updates
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/0c4ad96cb7f7a6a771830f934ef333d2da0f2b90

-- 
Neil

