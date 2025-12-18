Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD731D6E2DC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 19:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBDB483106;
	Thu, 18 Dec 2025 20:52:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rJ8JZy4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD2983710; Thu, 18 Dec 2025 20:52:06 +0100 (CET)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9974A80325
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 20:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-3e37ad3d95aso765324fac.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766087518; x=1766692318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1uqRlPjXSGmybqm2RODYxzfWsmo/UHNBfQ8sBZ8Z1w=;
 b=rJ8JZy4K2mRYD4pcJDa2FiyWVD1leFQzj5g5jo96Z+ufPkPulqbBDUK0Jw/0HrckpQ
 fT52u40xwVDH1UFXfK7qwuaAcAKTVoM5L3N2fT/+jQZO18Zf4CwmSJTVIINtalRMGWC0
 R2r1C5xJdrh79+bKqM5Pw/Mr+FCPTrZ3M4KZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766087518; x=1766692318;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1uqRlPjXSGmybqm2RODYxzfWsmo/UHNBfQ8sBZ8Z1w=;
 b=JbG6jaJhtLLA393iF2ClEOvoTDnTx1L7/fSXeYIrpR/TQZIBeLF76P+Bt1xBerbN9C
 108kafKoH9oJhZjuvzKIHyB8yVQvE0Rv1BZc+/XnFOGYCfx71NhVvozpKxxU9jUi59Vl
 mtphxBTRs6T+MxMra2ccK+DyIws6SigdQh/4zsz9mUv42FkG6LRoPFxzEPh9all8OXDX
 /Y2Vfsi7yDNTofRpgjkepyas51QDN2TS4bYaekF5DvFa029dOnS9SI1oZMiOWXoqvJqJ
 hKgk/sFpPnpgbr142JhBNHi+7NfvSkVLdc2fdbL1b9F42j9UHaaIdM2xWNfcHHJ7KP26
 /6sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCsponIh0RWjBQuhL4c8SJHH9q2Fht1/Bm716ge9QgI5TKfTSOPYINHp74Ocv36cPBYhFgTK8=@lists.denx.de
X-Gm-Message-State: AOJu0YxSTzSxZ6o55a4PHpmFXC6Wk0L335rPPvoQ4sVlomTC3Cf97GE+
 Ywv4iH0DPG2U4sEuiCYp9Gu7QH6CB8V0cCTpCZrL4Wagutpsj3/G+N5PYCmUdWF5M3zkZGM3wmg
 mH3UWVm+nVQ==
X-Gm-Gg: AY/fxX6v8yyP4UKrpf+fl3p9Mpm3Z7aMxBLyCY6JIWWEJBBHX3uasTteKKy+5wuswiF
 +ltdrHFD4IzF4LQ4xMGcJHZnWLDOpMP/p8pEE5MP/hAKW2zs6kBw3tykZsl2UQL4LIwo2socVjz
 UPIYpDh5ZS4f5z5lFpZIf73bUYgbu613gBNzegCo02A7JxGg65QYbYjqGzyNvqieMyREPffM6qg
 jWAUY9b7vYPlbiu7zV/gl+PHLjiVeHShJZxL9RQYU6ho5K78sDr9DaHUSmj9Ny9dIqqiXNuZ6ox
 PdF+8Psf4EIezilNcOLfRCNY0YzU173LmipbH/++nyhU75adNZ6u5OcfniytTqhWqhzO/UIR5y7
 ntwuiKcZ7ZkIGaNoew98reZdMXDIgh6soUQar7oUaRKHorj5iLJrUh9+TmTlUwALPmFeRQAkMHM
 xWgFWDrSkVH0KJjLVdRDnFWtsZ5kdzyIMSeb1dDRFrtF/Ly3Px2XoTMNgXua4=
X-Google-Smtp-Source: AGHT+IGwJmQ31vNtIg2i0QowJvmfFYNZOjPat/EKJ0OWf/qYoerRpyJj7kV3qaaqmazOdW5ghjtE9A==
X-Received: by 2002:a4a:b991:0:b0:659:9a49:8ecf with SMTP id
 006d021491bc7-65d0ec26661mr230857eaf.83.1766087518345; 
 Thu, 18 Dec 2025 11:51:58 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f710763sm181837eaf.16.2025.12.18.11.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 11:51:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251217-doc-pytest-lwip-v1-1-bdcaa59d4154@cherry.de>
References: <20251217-doc-pytest-lwip-v1-1-bdcaa59d4154@cherry.de>
Subject: Re: [PATCH] doc: pytest: fix typo in multiple config options
 example for buildconfigspec
Message-Id: <176608751762.3734627.16407416652230465140.b4-ty@konsulko.com>
Date: Thu, 18 Dec 2025 13:51:57 -0600
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

On Wed, 17 Dec 2025 15:02:27 +0100, Quentin Schulz wrote:

> The option should be 'net_lwip' and not 'net lwip' (see all usage of it
> in the test code base).
> 
> 

Applied to u-boot/master, thanks!

[1/1] doc: pytest: fix typo in multiple config options example for buildconfigspec
      commit: 24ab2b9684d72af960a7145a88c34ab0ec801c84
-- 
Tom


