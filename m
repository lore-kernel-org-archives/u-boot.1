Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C768CDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1764384704;
	Thu, 25 Jun 2026 17:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HIOzUjL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFFB847C8; Thu, 25 Jun 2026 17:13:12 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BAF8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bed19623d6eso440570366b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782400389; cv=none;
 d=google.com; s=arc-20260327;
 b=s3RGUKKiHjH87SW4Hu/kFgBq662nV0iV4OvwwgpDk0sDCY+SPl488TllSLobOM6c1+
 RYqZSUlByFBJy24StLe3Ufy5soR34gJRUFr9CnQPbZ+z4nUTQQMZy2o7Qm3765ubwdBC
 u3T5FqSbAuwybVw3JX7Qoh8eUW4iC8HB2sYThU6nkTTnZDucdFybZeFXPQUZRACsOjLn
 3DONu4Ixd9IH5JkM6mjWWVh3P3E8V9t/jHLZIw2BrIxZwL9hDN9wr0RQxuFuX21JtiWs
 mzrkmBaHpCW8gwZvOgwkPz1UMGReskw3j28hRhbc4IKCx+QXcx2FzfEvfJHrAMBGo5HC
 M43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Je+rN6q714X6BFJMilPYlCPJ3qB22+3AOIaT1OAsI8M=;
 fh=IIgt66E0vMH58kRgarRMMZtzmWpVr2vTRhmJ5C9+8PE=;
 b=GT6cdf7eWFNtKhlcyFWBvSHG7TGLnFE0J7TSoK6JgHhr+P0m0S9HqkwOxdl2toaue8
 zBwUo3z26l6Rb9/kk+FQKImghnbGNeJyO7nc5E+/6TEXXaNPhLyQiW9Mf3nvQe/yJLfC
 Ea3qBXj4NN8jBD6cIKphJL8KQYmk4l4JhHYZsO64MSW+wBGpuk+GFGnQSvM9WptUTVvi
 95wAxjQZytYGzs0Lr2FKwRznexCm/CarZwfyGpM9d7icKz8FiQjQsymNL7+HY3GqtLhf
 13e2J8/IqUjBA1BHpBZ3HS7Z+tFeBWFGTvoOA4J7bLEkBPjrQSul7pcaZlthIqebOybE
 FD9w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782400389; x=1783005189; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Je+rN6q714X6BFJMilPYlCPJ3qB22+3AOIaT1OAsI8M=;
 b=HIOzUjL3U6nFrl/VnjExnRBcnUYIFvRSAx5Ja4VUmS08pebwu9FbzV2r9IDT2zijrM
 xsfa4J2SodmB87yRJU/d1bHTHAiY/54BFeqqXbemHVpv6kMygYckGGxDpLJAuAooRibh
 nTtPQ9Zm4z91s/A8uIWF3tZ6rLUitqQLE6tUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782400389; x=1783005189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Je+rN6q714X6BFJMilPYlCPJ3qB22+3AOIaT1OAsI8M=;
 b=V3aXiz7/fVeKg2AWYuRXMSGpWsi22pRhWcUsKbsP95WDVoFoNL1kycKL6IikSQnvtf
 kqOTE+qbjdNX497uNXBV1aupkwSmIYuxtHuQb7yS2XvM1OGzOWl4CSavFiqf8cguNvpP
 2XSnnTniDlwlVpdoTOqp9CK5SGWKspP3XDdE+2Q9OOCkUFHQjB6tVhvDiACJiIgUqjN5
 os0R0/hB+8wx2M79pxdmhHHYvBHuNOpjNpcMGUn3S838jDefdCYdLSOZd3LrAU/4IFt4
 XyHCBive8TAGDVcjgxsK8/dfnJjArwghMvXINXZp6RS8av8R7NRdeLAPvrehLh3qrGXT
 a8fQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtzajCGN4zJvHqTA2GQMg0C13dktBjHfZT262z7+dYYhvpaz2fRbhRahCIeGkzUAW78mXgMcA=@lists.denx.de
X-Gm-Message-State: AOJu0YyMtyc9JWYC77MIeb0UHDH+GSL3mAK6KsVWo3c5CKxBSOYrG2QH
 ZORtG4mQ91EavUOnyP3Qo5HtZrAxels60P7J4B3s8ZqPEh1n3svDYmS4CgOHIE7pszL8+I2ZXda
 C/tiydD4yDtk3QLctRPHpWcskZB3ryGn99cADLsLB
X-Gm-Gg: AfdE7cnI1OIHYpOV9taafUMi5ox5omdV1v85Fc4xp2KkaRhMY7cA/jfsfeXI4ZC+dJM
 C1T8mb/yshEvpymI3tEuK2yptiACjlwQlmgcy8O6YhG/VYF8qc6Q0/tzpjvQPKydqBCA9ivk8Gs
 OstxQPbCVGRTGjAtqTuGD1VhIMgTA5/miS2zZ7NGcrnQ7Ep+3HWD7RDZ65E46pCZ1kFW4BCNEE3
 gfEoyEqTP8pYPDkPFoJTbMqQXetKfU8h/2lZyxWgKZq/px1veHm94EFo92x3WIxXnlpaXFKsg==
X-Received: by 2002:a17:907:968a:b0:bd2:bd3:1ef8 with SMTP id
 a640c23a62f3a-c1205ec5915mr210118066b.35.1782400388913; Thu, 25 Jun 2026
 08:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260618150913.314507-1-vincent.stehle@arm.com>
 <CAFLszTh1p01CC8-1Or7AQhziLkNqzN4NKADJ+hKYSEVjM15t3A@mail.gmail.com>
 <b3e09fac-0328-4aba-a59f-4d876b9a7475@pengutronix.de>
In-Reply-To: <b3e09fac-0328-4aba-a59f-4d876b9a7475@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jun 2026 16:12:56 +0100
X-Gm-Features: AVVi8Cc5HArUIZAYX2iLDwizCFhvLfvH-XWkSmyC3j5B9Ju9yeQ8VlwVzuNCDkc
Message-ID: <CAFLszTj21Z__n=r-tcVwp_9doqzOn10TmrfM=D7HppxawBFADw@mail.gmail.com>
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

On Thu, 18 Jun 2026 at 16:28, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello,
>
> On 6/18/26 5:18 PM, Simon Glass wrote:
> > Hi Vincent,
> >
> > On Thu, 18 Jun 2026 at 16:09, Vincent Stehl=C3=A9 <vincent.stehle@arm.c=
om> wrote:
> >>
> >> Make sure to call EFI_EXIT() in efi_disconnect_controller(), when retu=
rning
> >> after having called EFI_ENTRY().
> >>
> >> This is inspired by a barebox fix. [1]
> >
> > Hmm, does Barebox support EFI_LOADER now? I wish we could bring these
> > projects back together :-)
>
> It's not as extensive as U-Boot's yet, but it's usable for the common
> boot me a distro GRUB use case. The code originated from U-Boot with
> some parts heavily rewritten to fit barebox, e.g. the EFI filesystem
> protocol is implemented on top of dirfds, so it reuses VFS path handling
> and other such things.

OK good. I did create a VFS in Concept but I have not tried to get it
into mainline yet.

>
> The imported files have Origin-URL comments pointing back at U-Boot
> including the revision they originated from, but we are still in need of
> better tooling to make use of these tags.

On another topic - where did we get to with the whole-FITsigning
thing? Should we set up a call to talk it through?

Regards,
Simon

>
> @Vincent, I suspect a number of fixes in [1] are also applicable to
> U-Boot, but I haven't checked.
>
> [1]:
> https://lore.kernel.org/barebox/20260216084758.3548990-1-a.fatoum@pengutr=
onix.de/
>
> Cheers,
> Ahmad
>
>
>
> >
> >>
> >> Link: https://git.pengutronix.de/cgit/barebox/commit/?id=3D080db65e39a=
877b000baaf843c997a69821dfe69 [1]
> >> Fixes: 314bed6c854e ("efi_loader: fix DisconnectController() for sole =
child")
> >> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> >> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> ---
> >>  lib/efi_loader/efi_boottime.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_bootti=
me.c
> >> index de57823bd44..b6966652d97 100644
> >> --- a/lib/efi_loader/efi_boottime.c
> >> +++ b/lib/efi_loader/efi_boottime.c
> >> @@ -3895,7 +3895,7 @@ efi_status_t EFIAPI efi_disconnect_controller(
> >>                                       &number_of_children,
> >>                                       &child_handle_buffer);
> >>         if (r !=3D EFI_SUCCESS)
> >> -               return r;
> >> +               return EFI_EXIT(r);
> >>         sole_child =3D (number_of_children =3D=3D 1);
> >>
> >>         if (child_handle) {
> >> --
> >> 2.53.0
> >>
> >
> > Regards,
> > Simon
> >
>
> --
> Pengutronix e.K.                  |                             |
> Steuerwalder Str. 21              | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |
>
