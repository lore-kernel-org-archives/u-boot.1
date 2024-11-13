Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79EBD462CF
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:03:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C3D8916C;
	Wed, 13 Nov 2024 17:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cngb7uBe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B797D89269; Wed, 13 Nov 2024 17:03:19 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5225988A43
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so1292371466b.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731513797; x=1732118597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z4C343BDSHuTyBYJ9pTWAN/p1dJGMLnXgSRoser+FvM=;
 b=cngb7uBevdx3GWsqDEJBAG7WO3vMN7pBX91U7XPbJDiIbZP6lH70DV/LBR2q5cqkmP
 K7IdL0PBZ3R2igWwVwAiS6GwKh4zr6GKt/Ok5/MCpmsBMhEWbufYu1FYnIDEd/YuCwoh
 MEMPrOxFKbkKj2AOW4F/MtZBhnNG4NlYQznbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731513797; x=1732118597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4C343BDSHuTyBYJ9pTWAN/p1dJGMLnXgSRoser+FvM=;
 b=ECpDBgd5ViuFM5FqfVsAZZ/62RhhjeDzxZn8DPwMQ72ui+kJftlyJZHe966hrejtWw
 PS9gFJlIFo647UBHJU9cPBZ5lyQ+rN2Sl81yIUzPdh1+LvA93XQ1g1TweHJY6YR5+Vhb
 X2vEvc56owIh/svcWvWWGGn8q1DU1jk2T83UonSwYmDomH/ycl+4J5WFzrVOWEV7Vsa5
 +jvD5rTqJMu+UFplZ7HNLN8aevZQU6J26GPJ7kAcvhuGn/wCljrOX31q3L8oADjx4evH
 X1VjqD55mT8cz++K9ufLcaVTzZut3pcCqbM56jpxxl5/KzXAPq35OcUK/KAnkgHJXRtb
 /R3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOqaEY1Xq7NNSrAiyNmQkwTDkWJInt28VAhEcdRZ+MtIvCKF/wRR14Ij+O1rfj/krddmlONtI=@lists.denx.de
X-Gm-Message-State: AOJu0YyqfHw6kRlpW/1VZQiWMvOTIKRRy/FWdfYb4Z/c4e44m2+oTaQC
 5td/6/DqIHKn3bw4h2XGqIym2mRmDskEWkc5Ntrynkz7i66tY7Yffe19/9oW+h3edmuzS4wqrKX
 66Rw13Z23oVWiLdCeK4hZjbBfswMPYIy6bnHX
X-Google-Smtp-Source: AGHT+IGkHGfR1jkYR+RROpRK+DqjDynqH8DPX2cZDZQ4w+wp+Dp1aidX9xR3u/yCJ0vok1ftbLs4ofr2B2Oko7DDxOo=
X-Received: by 2002:a17:907:6d24:b0:a9a:9df:5581 with SMTP id
 a640c23a62f3a-a9eeffeee58mr2102285166b.38.1731513794825; Wed, 13 Nov 2024
 08:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20241031-iommu_apple_dart_ordering-v1-0-8a6877946d6b@jannau.net>
 <20241031-iommu_apple_dart_ordering-v1-2-8a6877946d6b@jannau.net>
 <87zfmi4rzy.fsf@bloch.sibelius.xs4all.nl>
 <4ff61e8e-03c7-42d2-b2fe-8dba1697641f@gmx.de>
 <CAFLszTjDaQGaaL9qM_s+oxNrAkGhunGkbAjyR1giEDgnShUfzw@mail.gmail.com>
 <5FA71CBD-F9AF-442A-8564-4F663F44BF42@gmx.de>
In-Reply-To: <5FA71CBD-F9AF-442A-8564-4F663F44BF42@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 09:03:03 -0700
Message-ID: <CAFLszTi9As9YFFoWuD9GW6gHpriZSNVCFmq5fKkdCi9jeRuqjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] efi_loader: remove non vital devices first
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Janne Grunau <j@jannau.net>, Mark Kettenis <kettenis@openbsd.org>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

On Wed, 13 Nov 2024 at 08:17, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:
>
> Am 13. November 2024 15:39:22 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Hi,
> >
> >On Wed, 13 Nov 2024 at 05:52, Heinrich Schuchardt <xypron.glpk@gmx.de>
wrote:
> >>
> >> On 11/1/24 21:29, Mark Kettenis wrote:
> >> >> From: Janne Grunau <j@jannau.net>
> >> >> Date: Thu, 31 Oct 2024 23:48:02 +0100
> >> >>
> >> >> DM_FLAG_VITAL marks devices which are essential for the operation of
> >> >> other devices. Removing these devices before their users can result
in
> >> >> hangs or crashes.
> >> >> This potentially fixes EFI boot of Renesas rcar3 devices. Their
clock
> >> >> devices (and with this series the dart iommu) are the only devices
> >> >> markes as vital.
> >> >> The arm boot code already handles devioce removal in this way.
> >> >
> >> > There is a typo in that last sentence of the commit message
(devioce).
> >> > Otherwise:
> >> >
> >> >> Signed-off-by: Janne Grunau <j@jannau.net>
> >> >
> >> > Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> >> >
> >> >> ---
> >> >>   lib/efi_loader/efi_boottime.c | 1 +
> >> >>   1 file changed, 1 insertion(+)
> >> >>
> >> >> diff --git a/lib/efi_loader/efi_boottime.c
b/lib/efi_loader/efi_boottime.c
> >> >> index
4f52284b4c653c252b0ed6c0c87da8901448d4b4..7db3c95782970f8c06a970a8ee86b1804cd848b6
100644
> >> >> --- a/lib/efi_loader/efi_boottime.c
> >> >> +++ b/lib/efi_loader/efi_boottime.c
> >> >> @@ -2234,6 +2234,7 @@ static efi_status_t EFIAPI
efi_exit_boot_services(efi_handle_t image_handle,
> >> >>              if (IS_ENABLED(CONFIG_USB_DEVICE))
> >> >>                      udc_disconnect();
> >> >>              board_quiesce_devices();
> >> >> +            dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL |
DM_REMOVE_NON_VITAL);
> >> >>              dm_remove_devices_flags(DM_REMOVE_ACTIVE_ALL);
> >>
> >> Simon's patch 6224dc9ba428 ("arm: Remove vital devices last") addressed
> >> the same issue for bootm on arm. But what about about other
architectures?
> >>
> >> This logic should be moved to drivers/core/root.c instead of
replicating
> >> code.
> >
> >We could have a common helper, but it should not be in driver/core as
> >this ordering is more of a policy decision. Unless we can add a
> >parameter telling dm exactly what to do...
> >
> >BTW, Heinrich, this behaviour is exactly what my bootflow_efi() test
> >was supposed to check. But since it doesn't have the
> >exit-boot-services piece at your request...
> >
> >Regards,
> >Simon
>
>
> Why can't we generally remove non-vital devices first if all are to be
removed?
>
> I cannot see anything device specific here.

No objection to that...but it needs to be in a new function, not become the
default behaviour of dm_remove_devices_flags(), which is supposed to do
what it is told and in one pass.

Regards,
Simon
