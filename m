Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4BEC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 11:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE42082B20;
	Wed, 18 Jun 2025 13:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zey7Xw95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B84982BCD; Wed, 18 Jun 2025 13:03:44 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13EE480E9A
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 13:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so422885f8f.1
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 04:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750244621; x=1750849421; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q88+QZ7zr6CSICTa9sdAijvCXCU+TzhBTcVfeeE+048=;
 b=zey7Xw95l6Xm5mmYBOWOZAfQ3/8lrbcmIOYHtXkSXPZJOZKy5c6YCSXVwKqiU0D7Qe
 LLMR3xRg0WIlsEwqPPpfJ4aZRM0s2SjBi3knWxKBMPetDtTy5BkTElVmci/M+jGqUMuY
 HUTKJ4hXLH2sSz15tas97R+2uxXQIVELZNsDlef+P/w6RR3xSu0mjOwqWzkQLSRy5UHw
 GHU47hNpmRmpkkCdymYf5H6bjBVUgkdpM5V7UlPcMC1fvbHrYjcCcLalPdPm9zDXjWPC
 mQN2E/FEFAOJ4MAccPAf9F4NyOeHzMUw1mZ3pRqMxDo2blUsCu4fJxmofgp58BvVSiE/
 aRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750244621; x=1750849421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q88+QZ7zr6CSICTa9sdAijvCXCU+TzhBTcVfeeE+048=;
 b=jdoz1qNmz5pJ9ds9Vv74cbI4tfH/ag3p6sZlvcdI/YztZqIAbHvzYC3pTlXonAYCLn
 ncnagnI31Tz4yzncFI7vuKtWgWFv0RswLPKey0sJeZLs0KKf3DXwfGJggSzgIvm8B9qY
 3CCyCsNn288bl0mQVvfoEtaypx4gyVpOgoDvIslTGBanBNxJ0SQtSgtmlSkO/KXp0Wu8
 wOGSvLjbOIkpReyZW2uZtjepF5HqTGp2lYl3qvTsRRceqgldjLseE+RUjsOMPH2Y93U+
 7dx2rrSi0l65Rn9s7+W3AQl+B78uH1HhxL414PQPvfvsNZg60fC9lY2pR2E1lNde1t5G
 6+JQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCVKOZeL+sl1JI3LKBz8kPpRB/gzPS148MWs2rk0nRJSqn+szewPFD9b25WJGBs+JobpdXQ5A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1OQBk4CuDtA4u+Mz+KoVsiZM1CYtvtvv/2MCq6rutYGNIkOiV
 W775dQpkjTx/ppfFUFKtLnx7dU385moht4qSfZ9CHpxCgVgXgX6BTchgAoRgy71xZPM=
X-Gm-Gg: ASbGncsCEIFcLirJJA4Q7+CP3G2TWySgOZdc0T37lgELula64h1extQSOEWww6KPEOo
 nD15IQbV0UI8FPZTFG01RCUS57EM86GQMIfntfvVlLF9NGJfwrC/jdm/QVUcIa+6LpmCU3WOSS6
 YiHRs4MgaXtbRhUSrvpRhZYzqVA8uLrUD7hj5+5p0hBqyFlJi8DrSA4LGwMwl9b8E7fWukl+U6Q
 /dwaW8An+YD2Bo5/EnOX0sp/e1X6VvGZHZZf3GvNvDHposkN+pWAq6PCvDwV/0vyiD4eIeqag8u
 wqWDoFAQiHk09WKkoM7t/StNnZs9MGZf0vVe2UpwFXtUSXTFzhZFvNCXEpo8ejicdP5nAllTnU6
 3iSdggCIOs6VHjh5JJDQ6QxZGvOtpVhNHlJADSFZLgg==
X-Google-Smtp-Source: AGHT+IFthRc7b1HloFZS+iVWyCiVwBHHJcL3JI5l6kUvcFFZ62Z47X6FVeKmF5WYpYxG0nG7vTEg4w==
X-Received: by 2002:a05:6000:2f82:b0:3a4:edf5:8a41 with SMTP id
 ffacd0b85a97d-3a58e13fd19mr1668361f8f.4.1750244621259; 
 Wed, 18 Jun 2025 04:03:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c389:6814:1493:2ed5?
 ([2a01:e0a:3cb:7bb0:c389:6814:1493:2ed5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b6debasm16937834f8f.93.2025.06.18.04.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Jun 2025 04:03:40 -0700 (PDT)
Message-ID: <c61e6238-82ce-4b51-9314-231f613a1430@linaro.org>
Date: Wed, 18 Jun 2025 13:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fix io accessors for KVM
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: mikko.rapeli@linaro.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Liya Huang <1425075683@qq.com>, Boyan Karatotev <boyan.karatotev@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@intel.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250618065828.1312146-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/18/25 08:58, Ilias Apalodimas wrote:
> Instructions that lead ito an exception in the hypervisor can't modify two
> CPU registers at once for the ARM ISA.
> 
> These instructions cannot be emulated by KVM as they do not produce
> syndrome information data that KVM can use to infer the destination
> register, the faulting address, whether it was a load or store, or
> if it's a 32 or 64 bit general-purpose register.
> As a result an external abort is injected from QEMU, via ext_dabt_pending.
> 
> Patch #1 prepares some function for the modified macros
> Patch #2 modifies the macros
> Patch #3 enables the functionality for armv7/8 QEMU

Again, IMHO this is more complex than necessary because you're combining
the KVM fix with some code refactoring. Patch #1 can be dropped altogether
and patch #2 can be simplified (from "2 files changed, 123 insertions(+),
39 deletions(-)" to "2 files changed, 97 insertions(+)". Unless I missed
something? Please see [1]. Of course it also passes the LVM test ;)

[1] https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/26751.

-- 
Jerome

> 
> Changes since v1:
> - Split the function modification in its own patch
> - Don't limit the changes to v8 only
> 
> Ilias Apalodimas (3):
>   nxp: Prepare macros for KVM changes
>   arm: io.h: Fix io accessors for KVM
>   qemu: arm: Enable virtualizable IO accesors
> 
>  arch/arm/Kconfig             |  12 +++
>  arch/arm/include/asm/io.h    | 152 ++++++++++++++++++++++++++---------
>  configs/qemu_arm64_defconfig |   1 +
>  configs/qemu_arm_defconfig   |   1 +
>  drivers/spi/fsl_dspi.c       |   6 +-
>  include/fsl_ifc.h            |  24 +++---
>  6 files changed, 142 insertions(+), 54 deletions(-)
> 
> --
> 2.43.0
> 
