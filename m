Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4FDC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1881D84B92;
	Wed,  1 Jul 2026 14:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L4HCc6f2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47EE84BBD; Wed,  1 Jul 2026 14:17:25 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C1D84B62
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6982e71dfb0so831216a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 05:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782908243; cv=none;
 d=google.com; s=arc-20260327;
 b=cr+oqDxOomfNxHDRQ2/md6oNDisxCZ7Kzr5tdgepIQLuG1sCuLE76rAur69pdzw+wp
 5xw4EhASWR1iPiv44BEU/WIKDNLhJqye8BQSyER55jUYGa1vf0AI1/8E+py7lSwNIx+D
 rIn/BXH/J/1ArIbgbERQwyKpZ02Dq6khIfToCGGQQ41FNXc3kDWl0wHrn+K7bUqDzI6/
 74V+rYQOPeEpBcBu02sbMyTX+qebnBG/Jy+R3m8V+ucZv7pfMWYYRVGe9DALyZe+degF
 wW336ayYwjMJJmNLWDHiJtfIl1DXrokKGVPEP9ZzrJ9U8hCjbv/XR+7ZDyZl/OxHMr/X
 ZVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VmT0cIRtHfNNU5QbAbIu5ElmdHFglM2BRbaK9yu2iu4=;
 fh=AfbpCGlXQJ+uqvM2sCk9+bHcgJgFXbd5chXxLi8vatQ=;
 b=okMxp6a0eNKdpVBZwUtuhtaxO0J6vuosTHYtJ+O4H6CfnjgiViA3pEeeAFKShtayhc
 OafPCuj+OhgTNbacopU6NBelev0PhxVdgORqHqfFaEZgNjwouyHgh1QtDw/cGrgH7bt0
 C4q4+nWnJ87p0AT0SRCygGFkJcGK+ponbH7hgy/IHC5nFHh6IENXJ95iyHjgIfm5ix9o
 t7z7wP9t5TqH13OafmNrB1eX7NDm8r3pGTsqZDOUEqhkE8bMwhf/F6TTtuiQA7pEzAN7
 1Tzuc1iY8oR2Rhmzc5ZPU001dzxI/r/+6Y0L7eXyjE4449Hu7WlyKGX2jBT65qui2uI7
 NPpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782908243; x=1783513043; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmT0cIRtHfNNU5QbAbIu5ElmdHFglM2BRbaK9yu2iu4=;
 b=L4HCc6f2PCdV3wapBBGszYhPQ3RESKd3UmKgF+eO4DTIdHKJNRv2PJam00aWzs6XRv
 eqtliUs3QhIhj1d8XpwHhOZZHOIsnx/kf9uOBZsg2C5QDv8ibt72k6V50UEexZ8/bqYe
 uHh2hN6Ctz2jtQKatZY+d4CwKo+4UE39/Pb94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782908243; x=1783513043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VmT0cIRtHfNNU5QbAbIu5ElmdHFglM2BRbaK9yu2iu4=;
 b=Bo3ojS8mClivyRM8l5i53W/wssR1RhtjSy3XrieqFFM7cvQ+jZTDCxCcvLtIt1kllh
 bBVnO2NfH0FMOokImfd41fuz3v3kL6khjZ5q3QAuSYUsAK0lTSMEyIvFRERV3ve+Ia99
 pLgd+yR3UauZhF9x8A0yAqCpgchdycrem12EYcNI30HJ6tIiv7sizs5NpfLgWuIpB0WU
 2Q/9qTZQI6o9eshWLLQTHtRpG/mmae1KhXSBvX5MamKeOBY7l2D9eyFfg9U6fPGQO5cp
 +t+qIqJwxLZxAkin8uj40H28PpUWE3OZKVkIJmHAuYgUZfhI4sjZWPRfFgfMSSh4IyuH
 gwtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq96zTEpjrzJmvZX8OnZ7Yl80sS/zAC1Z7orjUvcoo5PSw1WeKZDbq7CBPBizB5QhtqGAqPlF4=@lists.denx.de
X-Gm-Message-State: AOJu0YxO/5ccVufEZAP2a4i5bYNEmdyVCjy4pV+SUiI5LxCdBtWubJNp
 LhAOwCAjRhTMZLYgDnOKsH+LdRg9jFYnUg1ICYi5ILi4mJ9/5NCKjqQnF7e6KssiqIFIp9w6zqF
 QRJPd70UBV5Eq/Z/HllEHmBFv/WAGSKdvTpcb97zMQSbO/flISuuFkw==
X-Gm-Gg: AfdE7cn+nTnSmpjFLKatCxZVmmfihn8oKAH2RuJh/8UwuR1dKRQENH9Ju0IRqFLxwyY
 3Y/gbHr30/nPVTcVzj8cJDpTr3kR+oNq+HKM6W6YdeyAc5/Vl1t6n/xdfwfza+3CclNzaRgKtwG
 OmlOP7OHJzi7jo1gVzNbklyaR5d6MW22v6SLOT+U8Zij47mE4BeA1Xtwon92O9WkzTdp3xWTjX2
 iS3CWlIgim0i/ShqXjW12xWMYlZZgM2gyyhINXizzB9RqmUzzYh/UBMLnpuBliUXoPJHPDvtRpx
 arxNuTLH
X-Received: by 2002:a05:6402:5409:b0:698:9a31:3651 with SMTP id
 4fb4d7f45d1cf-6989f37687fmr678205a12.19.1782908242727; Wed, 01 Jul 2026
 05:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
 <b3e09fac-0328-4aba-a59f-4d876b9a7475@pengutronix.de>
 <CAFLszTj21Z__n=r-tcVwp_9doqzOn10TmrfM=D7HppxawBFADw@mail.gmail.com>
 <9dd01627-7a0b-4dbb-8215-7eddf424a6ea@pengutronix.de>
In-Reply-To: <9dd01627-7a0b-4dbb-8215-7eddf424a6ea@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 13:17:11 +0100
X-Gm-Features: AVVi8Cdz8e3CYf2hhAWv2oa4obXYOYXJQCnGC7TehNgSiETGWVJNJ5mMg06F2hU
Message-ID: <CAFLszTgFOkFm3VSOo-yMyp-uRTPXHGv4P3J0srPmod5FnA0Z6A@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: add missing EFI_EXIT in
 efi_disconnect_controller
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ahmad,

On Mon, 29 Jun 2026 at 12:06, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 6/25/26 5:12 PM, Simon Glass wrote:
> > Hi Ahmad,
> >
> > On Thu, 18 Jun 2026 at 16:28, Ahmad Fatoum <a.fatoum@pengutronix.de> wr=
ote:
> >>
> >> Hello,
> >>
> >> On 6/18/26 5:18 PM, Simon Glass wrote:
> >>> Hi Vincent,
> >>>
> >>> On Thu, 18 Jun 2026 at 16:09, Vincent Stehl=C3=A9 <vincent.stehle@arm=
.com> wrote:
> >>>>
> >>>> Make sure to call EFI_EXIT() in efi_disconnect_controller(), when re=
turning
> >>>> after having called EFI_ENTRY().
> >>>>
> >>>> This is inspired by a barebox fix. [1]
> >>>
> >>> Hmm, does Barebox support EFI_LOADER now? I wish we could bring these
> >>> projects back together :-)
> >>
> >> It's not as extensive as U-Boot's yet, but it's usable for the common
> >> boot me a distro GRUB use case. The code originated from U-Boot with
> >> some parts heavily rewritten to fit barebox, e.g. the EFI filesystem
> >> protocol is implemented on top of dirfds, so it reuses VFS path handli=
ng
> >> and other such things.
> >
> > OK good. I did create a VFS in Concept but I have not tried to get it
> > into mainline yet.
>
> Cool. I really look forward to `cp /dev/sd /dev/emmc` just working :-)

Well, you can copy:

=3D> mount hostfs . host
=3D> fs cp host/README host/Kconfig
81004 bytes copied
=3D>

but there is no device fs :-(

>
>
> >> The imported files have Origin-URL comments pointing back at U-Boot
> >> including the revision they originated from, but we are still in need =
of
> >> better tooling to make use of these tags.
> >
> > On another topic - where did we get to with the whole-FITsigning
> > thing? Should we set up a call to talk it through?
>
> This is still something I am interested in landing. I had started a
> review of your counterproposal, but got distracted before finishing it.
> I submitted it now.

OK great, thanks, will take a look.

>
> Cheers,
> Ahmad
>
> >
> > Regards,
> > Simon
> >
> >>
> >> @Vincent, I suspect a number of fixes in [1] are also applicable to
> >> U-Boot, but I haven't checked.
> >>
> >> [1]:
> >> https://lore.kernel.org/barebox/20260216084758.3548990-1-a.fatoum@peng=
utronix.de/
> >>
> >> Cheers,
> >> Ahmad
> >>
> >>
> >>
> >>>
> >>>>
> >>>> Link: https://git.pengutronix.de/cgit/barebox/commit/?id=3D080db65e3=
9a877b000baaf843c997a69821dfe69 [1]
> >>>> Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sol=
e child")
> >>>> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> >>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>> Cc: Tom Rini <trini@konsulko.com>
> >>>> ---
> >>>>  lib/efi_loader/efi_boottime.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boot=
time.c
> >>>> index de57823bd44..b6966652d97 100644
> >>>> --- a/lib/efi_loader/efi_boottime.c
> >>>> +++ b/lib/efi_loader/efi_boottime.c
> >>>> @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
> >>>>                                       &number_of_children,
> >>>>                                       &child_handle_buffer);
> >>>>         if (r !=3D EFI_SUCCESS)
> >>>> -               return r;
> >>>> +               return EFI_EXIT(r);
> >>>>         sole_child =3D (number_of_children =3D=3D 1);
> >>>>
> >>>>         if (child_handle) {
> >>>> --
> >>>> 2.53.0

Regards,
Simon
