Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1550EC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7553281F28;
	Wed, 19 Mar 2025 16:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Llw0NS8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387EF81F44; Wed, 19 Mar 2025 16:22:51 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D95D681F0B
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6f74b78df93so71477637b3.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742397766; x=1743002566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EnGn50r87osbhCtHv/9g7/v/yII5/4JRgzjHwqg3LIE=;
 b=Llw0NS8WJQw0cXre1yeQuEJFavVuplaActJFfphOb/aT9Z65fAu7l1ML5U8/oOospK
 4M/3VTHh8zu7smiFW82cvC2IXvMaF4927StnkL4DMR6tcrN68lVhuBV0PiSEs6lgrKxC
 J2gMekwvCSkngajZQaF79s0B9IlFt2Cw+EAMJCd5XANahcVTu2JtjjVdL/JeF4jzFe3x
 TppQ86WD6e8SeFZ+uH7MGJcyJGPFGr1XhHDIVQutl5ZuZQP1Og0piDqvcUoSfpxV5BSC
 G536LgM0K3ScvbZfjXPF0Dtk6AkfoC2AVUHxasknZfDl7Gu+gsvTmLOqQN18HV3Hgoyi
 dLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742397766; x=1743002566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EnGn50r87osbhCtHv/9g7/v/yII5/4JRgzjHwqg3LIE=;
 b=ctwnyZpMR/Ulb1v61UgAz88zGWfn9RbVcTKjODG7cIvGcbuUalmYWckjerxcQydJPn
 ec/S8S/L3IJPXlPdBLAegWjms3Iw7Wvd1F8wnNEIN1FxauLR+1qTUagZLlEsEfTEYT2V
 r+RA7ooExMb1qFFte+8ti2jgpY8KiMB5nlRbDCusEN+WqILw/LQGliDldB4nBDE9aVnS
 zaqItto3r9ETlwt+YMUienQdyqqLoR6g2s7ScB7QDbCOW4Nf+f8ylR/lLJxhT3zl84Wf
 pPQFCchH+k7/z5htG0DVnPcsAa9B3xfNkg15QNlQlHZX0OJX8mZ5nb4zkXFLjwwYv3EI
 Re/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuyWar4IZo6Jw6geTAN0cpMsap1bIUMiFmxKUncL+Ua4QBSzWhUl8Jpjrin9IYhaR71Cvcebw=@lists.denx.de
X-Gm-Message-State: AOJu0YwLeDJGu8EPrvVhP222jTu7SXAx7wQEPlmuQBKNyRAoslET0Fh6
 +JymS4VIw70/9lVBF2VhEc0vNsPLCI/5HcxH1xEe4dImXb4XfcsE6k1Fk+2j3Qxi77ktYcJDUIA
 NWkPzmJtn8uP/Mo/o7iZz0foLA7+mcPHW7PGFNQ==
X-Gm-Gg: ASbGncsgces8uxOf5FL7z9vsHzVc9kN26IBb5BhYvB57muT4atvv6W/wgMuNwqOKRDi
 +M+UDEXttxGGKXpsiF1BcQvwHfQMDOb5D16pyaKel/O1R3/EzSKeBcpwGVKbDWHVxfMXbHXtg02
 UL1wnDC0xVtsxENH3vvICZmmYWf/g=
X-Google-Smtp-Source: AGHT+IFLbT11Wkgdev2PdOj+MOE1zONbVIcbj5yXH9Wmo/qH2N0M+JA4QSdqahF/WK43LPQq/CfQJMTinVjtQY2sG60=
X-Received: by 2002:a05:690c:680d:b0:6fe:c007:3b20 with SMTP id
 00721157ae682-7009bf4999cmr47482157b3.2.1742397766326; Wed, 19 Mar 2025
 08:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250319072203.327431-1-ilias.apalodimas@linaro.org>
 <CAFLszTi8gTWr_BYv9nAJ1d_kN0FJQ+tbVGL81EsOFuALtWR96w@mail.gmail.com>
In-Reply-To: <CAFLszTi8gTWr_BYv9nAJ1d_kN0FJQ+tbVGL81EsOFuALtWR96w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Mar 2025 17:22:10 +0200
X-Gm-Features: AQ5f1JoFi2ISBCF5EERinfL83GpK_st1TYy0JuPUuLnesmWtUt9SHsJpaFdu8VI
Message-ID: <CAC_iWjJ+CQt9VR7s2kUKaWsNoP3uMCQAMMn_cAW3HKHyR=avQQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix page permissions for platforms running at EL2
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Wed, 19 Mar 2025 at 17:04, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Wed, 19 Mar 2025 at 08:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > We currently set both and print both PXN and UXN bits when removing
> > execution for pages. This happens even in the existing per platform
> > definitions of 'struct mm_region'.
> >
> > That's not entirely correct though. For stage-1 translations, if a
> > platform runs on a translation regime with a single privilege level or the
> > the translation regime supports two privilege levels and we are not
> > in EL1&0 with HCR_EL2.{NV, NV1} = {1, 1} only BIT54 (XN) is needed
> > and BIT53(PXN) is reserved 0.
> >
> > Currently we support Non-Secure EL2, Non-secure EL2&0 and Non-secure
> > EL1&0.
> >
> > We already have get_effective_el() which returns 1 if we are
> > - Running in EL1 so we assume an EL1 translation regime but without
> >   checking HCR_EL2.{NV, NV1} != {1,1}
> > - Running in EL2 with HCR_EL2.E2H = 1
> >
> > The only problem with the above is that if we are in EL1&0 and
> > HCR_EL2.{NV1, NV} == {1, 1}, then
> > - Bit[54] holds the PXN instead of the UXN
> > - The Effective value of UXN is 0
> > - Bit[53] is RES0
> >
> > So let's re-use that function and set PXN only when we are in
> > and EL[2|1]&0 translation regime.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  arch/arm/cpu/armv8/cache_v8.c | 28 ++++++++++++++++++++++++----
> >  1 file changed, 24 insertions(+), 4 deletions(-)
> >
>
> Perhaps add a test?

Sure, I'll send one, but it obviously can't run on sandbox.
We can run in QEMU with an without virt, but we also care for real
hardware (which is all problematic AFAICT -- at least the ones that
have an EL2 translation regime).

Any pointers on where I should add the test? A new file under test?

Thanks
/Ilias

>
> Regards,
> Simon
