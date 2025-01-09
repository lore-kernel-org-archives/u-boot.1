Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7A8E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 13:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4568A801F5;
	Thu,  9 Jan 2025 14:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pz+ZebHF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92901801FD; Thu,  9 Jan 2025 14:08:30 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF29980017
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 14:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso799208f8f.1
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 05:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736428106; x=1737032906;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ok0D0kQIcp4fulnM2hyBAfp5SqBMPhWV/MkfhnuRrRM=;
 b=pz+ZebHFQoZ4ZSrq4V3WT2bH5G8XzIG25nDOGlNqyYvsMYTaQeUMVMjPhx6S0dV437
 KZ4pZwVYATs90el3lugX+O8kmtyZrZLy0q8u2QIJI6nRkvj2VoPwreRkXjZgV/PrgpFA
 3Ys2za0EKB+cTBJQZenPwOuHgWMA0aQ/GmsawLn31SMmH0H04Rxky6Z4NWGIwZHOqWR4
 5NxHFbMJqlplGLiBH+xSBZoymN85KEqFmBRg+rnjbamS0cr2L9TzPTkkJAlmFWM/uTHn
 PchxKxcPGbDcxBzh370rOGYs7npCKhNd6BTd84+evWw0H+wZH70WDXEhANxaxNU3jusO
 H9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736428106; x=1737032906;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ok0D0kQIcp4fulnM2hyBAfp5SqBMPhWV/MkfhnuRrRM=;
 b=HV2BJdFWT4QDjtD/oWiRJik8DcvKQOmNvF2ZCSNknysQXIv60HK0j2Wtw9TLJEDS+w
 7MkzPh9VMMCRbHgWujEooQe06HDb1odq4tuyp7I6a0xbewaKr3jFrgdb3vltd23V6vAM
 bD7AJbbsKzeKwcCB3piUGc1LpNwYfrchuW3aTGQ+7BdWorFvKL/ei6lI45kYG5gTkYdw
 A4+9c2R1yKp+itz3yQV27+INsWwggE0tarjbgnBrIs6yc0OklNBqSU4UigDeBpLPPicZ
 BQOELsHTkG7HLz57XvjEE1JbQY+Fj91p4feRX+Zzo/FKcbMc0O7ciTjcHXV6PmuKbyWM
 iXLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHPvCRUEyKJKi11oINpqmk1NrEyiNDLOWIfUSCfq9fhD1qW1EB0yjFKfoj5h66brCoX9if/CE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2/Kxka2483+CFqD6ItdYLDQRrmf/Q+Imlk85yZNzpHCmjDcBn
 E0wXmgBQZi5SsJ8K4fzERCY8vOrRyIw9uGnVLVxvKi2K8+cWDPB2l8L2FLd52UQ=
X-Gm-Gg: ASbGncsAjasQdEffkrn5Wtk84W6e4A5H32frW7RKWNxXmpLFMSpmCl2fuws70pFOVUP
 iqt2wTFj350Chmt+BuTqcirBi1iwSj53BWq4ttgxJnUtTDsOYRB4tKH1p8Cxz5H0ZCeLCiTWe1p
 MgIl+Vd1fSXrt/ZgSJ6TL9c162t+OCnx1Nwz1xJJG37s6s9iCWiT+SZF3CVCPGfHBYzRpzzcs6c
 XzlvJoySg0o+ELDFe21mc1faXrkpkCsn5eRA4mDdC1eAI6kdjrGDpOi00zu
X-Google-Smtp-Source: AGHT+IH41IePjPYA0rdb1jYZoLsxeINh/Gls3IX/6eK5nPebGusS2uVBBrU6Ud6bzKaTPJrlPnqfJg==
X-Received: by 2002:a05:6000:1f81:b0:385:fb56:5596 with SMTP id
 ffacd0b85a97d-38a872de1e4mr5266216f8f.19.1736428105907; 
 Thu, 09 Jan 2025 05:08:25 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d0fasm1826762f8f.19.2025.01.09.05.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 05:08:25 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] MAINTAINERS: move myself to reviewers for avb/ab
In-Reply-To: <20250109112854.825204-1-igor.opaniuk@gmail.com>
References: <20250109112854.825204-1-igor.opaniuk@gmail.com>
Date: Thu, 09 Jan 2025 14:08:22 +0100
Message-ID: <87r05cxhh5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Igor,

Thank you for the patch.

On jeu., janv. 09, 2025 at 12:28, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:

> As Mattijs Korpershoek is in fact doing overall
> maintenance of AVB/AB code, move myself to reviewers.
>
> CC: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>

Thanks for staying reviewer. Your insights have been very helpful in the
past so I'm glad you are staying as R: in MAINTAINERS.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba31f86feb..72a446acf9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -66,8 +66,8 @@ F:	lib/alist.c
>  F:	test/lib/alist.c
>  
>  ANDROID AB
> -M:	Igor Opaniuk <igor.opaniuk@gmail.com>
>  M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
> +R:	Igor Opaniuk <igor.opaniuk@gmail.com>
>  R:	Sam Protsenko <semen.protsenko@linaro.org>
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
> @@ -77,8 +77,8 @@ F:	include/android_ab.h
>  F:	test/py/tests/test_android/test_ab.py
>  
>  ANDROID AVB
> -M:	Igor Opaniuk <igor.opaniuk@gmail.com>
>  M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
> +R:	Igor Opaniuk <igor.opaniuk@gmail.com>
>  S:	Maintained
>  T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
>  F:	cmd/avb.c
> -- 
> 2.43.0
