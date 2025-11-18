Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDB6CF2562
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA22483A9F;
	Wed, 19 Nov 2025 00:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GBEHuoDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4822B839AC; Wed, 19 Nov 2025 00:33:16 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291A6839AC
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3d18422565eso4160986fac.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763508793; x=1764113593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVuds5llB9CkDKI6id1rmzcOa1JzR1AqMjyCsRepBUQ=;
 b=GBEHuoDgFUsIfw/kKNh0Ln8mgk7xggp31GNMIJZMDLEwWghD2oN+WoGwlTY/PMHAG0
 yvD6tt5z6+S1WCz32mLhae+JHQFKD0feEOfNKsep0yZQANeCIIb6eTwlZJ6M/egvDSYP
 BYTOFU+OYodrnxuZCqLBok8ab6MGMHkv9Dyd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508793; x=1764113593;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fVuds5llB9CkDKI6id1rmzcOa1JzR1AqMjyCsRepBUQ=;
 b=B0Otc0LNklmF70+WqaFUhgSPmodnHfYq6SGsi9hQwPwSmGoQU/iBrMlWIeEFYP+/4Y
 iaJj9v+SW2FHvq7v3qxukL6v4zzuZbMa9R0+mNQZnb1w/aZwfvD13wZ0AL9kPCRkYV45
 L5yaSOmOQ3hLw6bdsAndZTLvmf42x/+7+6zEmC9Y0SIwqTzGO9AwjUAmu59Oxt5hfeNu
 R/faKSkk5vD81DqA0BJ9vZC+3nzIcDi0nlt5wJfrWAJSMMaxryQUN6yGnxh3NovY0aQN
 EGYlcmy418vgBvNaIvC9EcYyUotbLfFLS/x/dDy2kotP8kg1FZUEboa6zq3XKfH0fdWO
 hN4Q==
X-Gm-Message-State: AOJu0Yydn3/cCVOYRmU593QiIPVN5iDFGgC41z2WaiRGpTg9qTHmhN0u
 p9F869ulVCWcFjmR6FbriA3k8WKMh53PhsR0Z613wWi4ISqTyfO01NCXBAZjFopqbv0=
X-Gm-Gg: ASbGncuodq/hnBvd9l3JI7q1ounR3EjYHPstwMGNaXY5XNfjmlDfeGX+L1PVzSWSP+d
 UqVw9qYIkyByZ7bTnpY47YArPlADy/3adSgSaUcZJYF5UmTvwpWT9kDPP1pCUd/tqqsd23yHjOW
 STftZxrK6vTRA7e4dylMHLsFaONho0FJI1U9Tyl23zqX8ogQDCZQIrTCpMAn77fg6VDCDYrMLUi
 15BwEfixZ0IyLamGj3kF3VHcAhavgZr3zVYNrSb6duWA/WC8O0NfeIdIDCcCMF3kSHgwEUun22H
 yMd4u5bgq/KqmTqjQaG3ZqPlN+a4RUAL2AZGkMLJ+0UHAZYsMvzRHv0UzCcvdIEoNV6CC0NgpRe
 sa7CUdnHpzcPq+PIYrbRL1ejMZKXyXhzSXZ7NbNIdQEwMqWJcqtLWBumOAniKBJAZaIPqcaiGF2
 DiauqwioVQgujBv1CEGCzIkONkHZV48RcT6s5TbVM7uSwDLuW5AlSrqALADHtWmYjHjMp9/g==
X-Google-Smtp-Source: AGHT+IGpzZuo6JyUrHS9pj7LqMnYLbXS8I5oDAwNUj9qWGup0tg/lN65Mrz+3Bhr7zNPpxBOhT08DQ==
X-Received: by 2002:a05:6871:4b10:b0:3ec:565a:13a4 with SMTP id
 586e51a60fabf-3ec565a14dfmr3467061fac.34.1763508792854; 
 Tue, 18 Nov 2025 15:33:12 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e89697fedcsm4075794fac.1.2025.11.18.15.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:33:12 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251108-clang-cross-fixes-v1-0-ea6c4282844a@gmail.com>
References: <20251108-clang-cross-fixes-v1-0-ea6c4282844a@gmail.com>
Subject: Re: [PATCH 0/2] Fixes for Clang builds for AArch64, improve
 CROSS_COMPILE handling
Message-Id: <176350879176.654721.1161316747557822939.b4-ty@konsulko.com>
Date: Tue, 18 Nov 2025 17:33:11 -0600
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

On Sat, 08 Nov 2025 21:48:45 +0100, Dmitrii Sharshakov wrote:

> Initially fix the inconsistency reported in reply to the previous
> series[1] and also make sure AArch64 images can be built with latest
> Clang versions by guarding AArch32-specific options behind extra
> config checks.
> 
> Tested qemu_arm_defconfig and qemu_arm64_defconfig with Clang 21,
> mainline (to be 22) ce7f9f9c and also Clang 18 (for AArch64 only, as I
> have not managed to build an AArch32 image with clang-18).
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] build: fix prefix for Clang when CROSS_COMPILE is an absolute path
      commit: 91bb236194162472d1e19b0cbc215e25eddc11d0
[2/2] arch: arm: fix AArch64 builds with Clang 21+
      commit: 2ed758fa7ef9e434c586ff5e12eeca7dfae7efb2
-- 
Tom


