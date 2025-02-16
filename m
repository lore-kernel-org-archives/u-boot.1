Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6E5C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 14:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A0F801B0;
	Sun, 16 Feb 2025 15:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gl2dEmA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B629A8056A; Sun, 16 Feb 2025 15:51:02 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94FCF80104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 15:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-abb90f68f8cso77651766b.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 06:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739717460; x=1740322260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9oMlpTqC1JfjvUxx2mb8v24yG0fZU4MTk4ZM0OSyFl0=;
 b=Gl2dEmA7/Q+gcxFzSHZMEzN2K0IeY9qJTCr9uGBiXqDY1uWHh+ElLpfpluHb2AKue7
 98VJdhq4o+z7htWblRUNw+nBt0e2vz1BScTFdkJgw6RC9B9mObaTzbAvFBJEd9HkRm/S
 KyZOKYrfrTUxCcuWDE9sn+DOzsac//ExYrwOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739717460; x=1740322260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9oMlpTqC1JfjvUxx2mb8v24yG0fZU4MTk4ZM0OSyFl0=;
 b=sgCjdr6UwzJlozPDp4wBvHo28CHCP4JCOf6udYHD+tcCqrF6fpm/eamTdVJfkUVAwR
 naJWdhnKXQxOj+qeBl5JLOCONFfdWp3yAcA8TuXi+4D3SFDsLI6T7dv0+DbKq72PYrv1
 BQVkQZSCBSrLwvpRGu77MjCCBiZVZ42pKFJjmaIoDGxKbjh0EIr2SxvizpdUp5clQKgi
 TVGVWEaACzPT6sULcr/2cJnBar9UII2XOClTEgvcOdkWEkud68RwnebsoEst4YP/6akD
 dWeGtm9/zxXyiifYEYC+P1wh++9A60/W6Hxymaygr+PndMgxWPks/74k0g/u9+zgc3j2
 5xig==
X-Gm-Message-State: AOJu0YyURr46kGY5AekpMEn9PcHDC2vTfQAVBS2kbWm+e3GywSRJYpdz
 JV+cJPu9GdPJscozGrGGL/0894/jkKtweQ0aRigZAxxzBS+EtPP9UEObh3ORedkOUnjo9vexIy+
 XuqgLJHe3d7Gh7hnFNzB4JxbzZDcT4fq1qqCvGOvZ0CuiPv8=
X-Gm-Gg: ASbGncuGR4AACVyarZgiu5v1PjG0b/YlyOg8ux3SKmyWF+Mdmhc9osVONDPpFAENaiS
 2cc4MerQEri9wOLQ9e+CxD3/V6G7C2++Ls/q5FlYmaphXHt0q/aqkR1904Evecs+Njton7IpMuA
 ==
X-Google-Smtp-Source: AGHT+IEdV93+SDuyBf12pC5blcTxxtcT27fhCOjEaOwuSLA0BtsB/5CkTMT8TFGZDBenz3kP67RpyFVs3U9DTbrcnQU=
X-Received: by 2002:a17:906:7312:b0:ab7:bcf1:264 with SMTP id
 a640c23a62f3a-abb70a7a559mr725317166b.5.1739717459955; Sun, 16 Feb 2025
 06:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20241112131830.576864-1-sjg@chromium.org>
 <CADg8p96cKqSEmZWLaOV1-onUwT4uwBp11=t4K7tmmPwZ-6UvXw@mail.gmail.com>
 <CAFLszTjw8ihHESoDk0RE6+00idN4Y-7=72NbUp+yOqpyCYqexQ@mail.gmail.com>
 <CADg8p97KQskghmGR+mv-AUVSAyCJ02DRzCbfHsZjGfEYbb+skQ@mail.gmail.com>
In-Reply-To: <CADg8p97KQskghmGR+mv-AUVSAyCJ02DRzCbfHsZjGfEYbb+skQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 07:50:48 -0700
X-Gm-Features: AWEUYZmYEE-Mu1iOArfnD1SaoqHLaE8G5XBwFmDac-XJEtAmUtJ_59DElUfbius
Message-ID: <CAFLszTj+sxM+RrCvqq5i9_pOqjajm1V2U=egEfGS9nAfo76BSA@mail.gmail.com>
Subject: Re: [PATCH] Revert "efi_memory: do not add U-Boot memory to the
 memory map"
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Sughosh,

On Wed, 27 Nov 2024 at 04:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 26 Nov 2024 at 21:09, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 21 Nov 2024 at 00:53, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Tue, 12 Nov 2024 at 18:48, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > A bisect of Ubuntu 2022.04 boot-failure on qemu-x86_64 resulted in this
> > > > patch. I am not sure how to investigate it.
> > > >
> > > > The boot hangs at some point during booting of the install image, before
> > > > the Ubuntu logo appears.
> > > >
> > > > I will sent a series with a script showing how it is run.
> > > >
> > > > This reverts commit a68c9ac5d8afc51c619c5d3e865fcf147bea90cb.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > >
> > > I did some digging into this issue, and it turns out that the revert
> > > is only masking the real issue. What this revert does is mark the
> > > memory region occupied by U-Boot as EFI_BOOT_SERVICES_CODE. The x86
> > > kernel seems to mark memory regions other than
> > > EFI_{BOOT,RUNTIME}_SERVICES_CODE as not executable -- and this is
> > > precisely why this crash shows up only on x86. The actual cause of
> > > this issue is in the efi runtime functionality of U-Boot. The kernel
> > > is calling the SetVirtualAddressMap() runtime service function, and
> > > that seems to be calling some of the boot service code of U-Boot,
> > > which it shouldn't. We do not get the crash after disabling the
> > > ConvertPointer() and SetVirtualAddressMap() runtime functions.
> >
> > OK, so what is the solution here? Did you send a patch?
>
> I am trying to check if the installation can be done by disabling the
> ConvertPointer() and SetVirtualAddressMap() runtime service calls. If
> so, then I will send a patch which disables them temporarily till the
> actual issue is triaged and fixed. If the installation does not work
> without these runtime calls, I would say putting this change in with
> an explanation of what is happening (similar to the above
> explanation). Please give me some more days, and I will let you know.
> Thanks.

I forgot what happened with this. Could you update this thread, please?

Thanks,
Simon
