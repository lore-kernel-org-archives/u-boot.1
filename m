Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCB3C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A347820F6;
	Wed, 19 Mar 2025 16:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nkxYwjfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B8B82063; Wed, 19 Mar 2025 16:04:56 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A631A80FF0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso6332795a91.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396692; x=1743001492; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H72TjV+1wx9IFqWRBdxU34PR5T2Nq+oV5S30MOO3XZs=;
 b=nkxYwjfKDIABxVKxTlCulM1Qj0rAHIb++cKGkdhjouC8pqzbLxHVH21ZvTl7zEAYKc
 EWOLrogSDom3gW5FbSJjOtRaaf8jAOFACpnuDtlJ3dMFQrThILDSw4eosXt8Ii4Wg/ZZ
 ZUU0Ieb1+kvlnHtLEwgMM74mK08UY6pkHL+w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396692; x=1743001492;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H72TjV+1wx9IFqWRBdxU34PR5T2Nq+oV5S30MOO3XZs=;
 b=VflyLzFABxJ/SL445Loo6iqE3UhHrATImzdpDuOGmjajwAqOdm5snRi2UwAlFI+mpJ
 b7b4yJresVYVCcOjzUrNgbDkV4aBI9gDFHWqpsHE+jIKkhB1QlIpCPgG63IYWcbitEya
 WtRxdOG5CryF4nRQHlWwbDIfQzm6i/DWxAJw2mqed1LCQ4A899/qhVVppXJgvbNd4x3Z
 5Ov2DYbctDQtX/IJkpYq+onXEzHfiP8RqS+yxM2aF82Ci3ktW+pADW3KmO5ppCeoy4wg
 rt711HjiNmX0flfZYzVjTDnRjosnP/phItg0c6/nBGJwPDC8ZVOmzmEpSMfgCuSrB/Lu
 /Fbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsmoNHm2ak9UMqrHpAx9OzWe7TWh52NnBh9mf8ezjG+YxoIGCLhdEqKRK0v8bl0NtX2QCBg2s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/nkC2xLPeUBO6PIFwWIIz+7VAfzjhghg/HoUyA+gQU5l7ZAfv
 ia45Zdj0x+gknYyOtqpbt2R4wBEPXeTGkazCibJC8fRA4T/Da8FraU5TiZM76gH8op33KuTMG1r
 cjhhjDnXCbvqqeWdKK0KBonTJm7F/fxIO1dil9lCnYvMmPbc=
X-Gm-Gg: ASbGnct9hgdAvXCkKyB62E/pVZOJlNHWXztLIzXb3fsvGIewLOGgVrxZ332F2nsWjM3
 FKkC4Ih7QwJHoaFmWOmduV94iU8luC5i/Q8Y3VmKcMISk03fa+N6aYPX+3chCxGSSGAgSNlQEch
 GPaT93wFUldoAhjS7h5RywHziRrOA=
X-Google-Smtp-Source: AGHT+IH4WMDQYVNLe9okAcnTlOz+kUxzz9UbgM7krxSDPpuISpSNv9e/lD0cIEgAU8e7G55EAV4ghxNgAMv2B65pOqA=
X-Received: by 2002:a17:90b:1d4f:b0:2f4:432d:250d with SMTP id
 98e67ed59e1d1-301bdf852f0mr4301639a91.21.1742396692232; Wed, 19 Mar 2025
 08:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250319072203.327431-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250319072203.327431-1-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:04:20 +0000
X-Gm-Features: AQ5f1Jr8ZcW2f8Ijg0T_tWz3S8_aYdrxpCnbtxA9FaXZoSdJT4HmQ_F9s0WGL5g
Message-ID: <CAFLszTi8gTWr_BYv9nAJ1d_kN0FJQ+tbVGL81EsOFuALtWR96w@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix page permissions for platforms running at EL2
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Ilias,

On Wed, 19 Mar 2025 at 08:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> We currently set both and print both PXN and UXN bits when removing
> execution for pages. This happens even in the existing per platform
> definitions of 'struct mm_region'.
>
> That's not entirely correct though. For stage-1 translations, if a
> platform runs on a translation regime with a single privilege level or the
> the translation regime supports two privilege levels and we are not
> in EL1&0 with HCR_EL2.{NV, NV1} = {1, 1} only BIT54 (XN) is needed
> and BIT53(PXN) is reserved 0.
>
> Currently we support Non-Secure EL2, Non-secure EL2&0 and Non-secure
> EL1&0.
>
> We already have get_effective_el() which returns 1 if we are
> - Running in EL1 so we assume an EL1 translation regime but without
>   checking HCR_EL2.{NV, NV1} != {1,1}
> - Running in EL2 with HCR_EL2.E2H = 1
>
> The only problem with the above is that if we are in EL1&0 and
> HCR_EL2.{NV1, NV} == {1, 1}, then
> - Bit[54] holds the PXN instead of the UXN
> - The Effective value of UXN is 0
> - Bit[53] is RES0
>
> So let's re-use that function and set PXN only when we are in
> and EL[2|1]&0 translation regime.
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>

Perhaps add a test?

Regards,
Simon
