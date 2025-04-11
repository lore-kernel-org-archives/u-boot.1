Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37048C369A8
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 09:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47DF83F9B;
	Fri, 11 Apr 2025 11:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yVYFPYJU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2930083FA4; Fri, 11 Apr 2025 11:44:48 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A087E83F85
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 11:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30beedb99c9so14629451fa.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 02:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744364685; x=1744969485; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCO3cz2T2XOcG++2y6cVgy5Jrk67iXg9f92GWWLGd5E=;
 b=yVYFPYJUwC1cPtcSlYjnKnK01u5sA8rrMkwktBKpUVHaVS8SLx8fDwZFDnxZmNIHx1
 B7Ts/zts0RKBDaQA1xxhHMUMp4LjzdZlfjrn4uZcmxM8vMApp6+BI0vnGvyJRRml2vaA
 fr6dPu3yPgtIafVG73TJxbkx11XRyspo8Qhm64mE3AuzK5T/47fJ1M4sMzyOFt92F0TR
 juvYyKN8whECyX4O1Z1OHazMpmMobIKLJcw+1y3FwF4AzVv60dqrBWtDwivjflr/rupf
 BsOemz+dz5kiAJeei8doNG79kVxCD4bR/MSDk/cMndgrzwVhypO6wIlHDEZSt63QRUVl
 EfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744364685; x=1744969485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCO3cz2T2XOcG++2y6cVgy5Jrk67iXg9f92GWWLGd5E=;
 b=jsAdgqBISZKlze+gyf2ePAuqIu1fB7+hxH0qWYfp7HCa0dluU8GCvX4P225Wx6nMzP
 RA8bZlY7DkrqNYLbGxALlO//wicm12J5j8N4luLxoteVWx4hlkdO0CsDGC2Ki/wyktV9
 NBApiM+hnQ5nG5U0kn7dSYKtUttPq7YgS276FchBZQ9/e4QpqZ4Pt2Hp79TeH8ZkpkiZ
 p9jbvzbA3aZghvjQYW5T832GQ6HzY6V82NGEjliwlYEZkUb9sul3fPcdf4k7gaCC19PF
 4ylTbabJYfEfN6rJNuTjovQzjDGKPEZ2t0SCfYg/R2mF3B1Nlf5zcni7wNRCoYbIvNae
 3k0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX35tYfoaBsZCUOSU53616TDpTUGEhxnusBARVKmhD2/84l5TFFn0TeFDQuxXRh0zlsU8tc3nE=@lists.denx.de
X-Gm-Message-State: AOJu0YwzKGOA+sl21r9Mx6bbhGToSAzXEOFxocEPF3pwDhF7HMlxe/Nf
 2+fswZQoxEmdXu4VzjFht8JH5Z1UMsahe65NBM3rMnhxrUaC4hDjj8Dp5c1nRRGeGvE74+Ug+lS
 azV7fMJnZhQUNG1XuVf7f41LemGgSvSga5sbDsoHv0qpsohrJFC4=
X-Gm-Gg: ASbGncv4daFQvHgvxPsNDI7iBxhujY19Lnv00crzGH5ICZlDbugueDv+yhKjj+HkPjF
 4DJZzstEdUGJgChiq3a6uqMrSxA8I64U9t3rrrSDWy2lGCihWT31cC/GQjiFgtyhyi2sL1RbMFS
 sW5TTfmXIGHvDDGiCLjOH3mLs=
X-Google-Smtp-Source: AGHT+IHPVaeyER9ux1r225Z+rrBlzWNCZNI4xOxYUoDB9vrABIw/zU8PoRNIMARkLFUCYR+mBVVfKe61WEcEs+EOC7Q=
X-Received: by 2002:a05:651c:1545:b0:30b:c3ce:ea1f with SMTP id
 38308e7fff4ca-310499fbc07mr5177051fa.15.1744364684796; Fri, 11 Apr 2025
 02:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250323190304.45371-2-christian@kohlschutter.com>
 <09f26320-68a0-4ab8-bc22-a6fa20492b06@gmx.de>
In-Reply-To: <09f26320-68a0-4ab8-bc22-a6fa20492b06@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Apr 2025 12:44:07 +0300
X-Gm-Features: ATxdqUFIzQukTUn8YqKmQ5duTF8-vxy1e0UhF-woH8PeZ9N4Fk7zcW9o3oIl7c8
Message-ID: <CAC_iWjJh64iBVHhGAypaawnvro=s3AT3vmLFWpXR18DzDO6d5A@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix efiboot for payloads loaded from memory
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: =?UTF-8?Q?Christian_Kohlschu=CC=88tter?= <christian@kohlschutter.com>, 
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Thanks for the CC Heinrich


On Fri, 11 Apr 2025 at 09:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> On 3/23/25 20:03, Christian Kohlschu=CC=88tter wrote:
> > Calling bootefi on an address that was loaded from memory (e.g., cramfs
> > or SPI flash via "sf read", etc.), currently results in the EFI binary
> > not being able to access the EFI image device path.
> >
> > For example, iPXE would fail with an error "EFI could not get loaded
> > image's device path: Error 0x7f39e082 (https://ipxe.org/7f39e082)".
> >
> > This is due to an incomplete special-case in efi_binary_run, where a ne=
w
> > device path was created but not used in all required places.
> >
> > Fix the in-memory special case, set the "bootefi_device_path" to the
> > generated "file_path".
> >
> > iPXE will now boot, and report the device path as
> > "/MemoryMapped(0x0,0xSTART,0xLEN)"
> >
> > Signed-off-by: Christian Kohlschu=CC=88tter <christian@kohlschutter.com=
>
>
> Hello Christian,
>
> Thank you for the patch.
>
> For future submission, please, use scripts/get_maintainer.pl to identify
> mail recipients.
>
> Best regards
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
>
> > ---
> >   lib/efi_loader/efi_bootbin.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.=
c
> > index 10ec5e9ada3..f78cf972228 100644
> > --- a/lib/efi_loader/efi_bootbin.c
> > +++ b/lib/efi_loader/efi_bootbin.c
> > @@ -268,6 +268,9 @@ efi_status_t efi_binary_run(void *image, size_t siz=
e, void *fdt)
> >                                                              file_path,=
 NULL);
> >               if (ret !=3D EFI_SUCCESS)
> >                       goto out;
> > +
> > +             bootefi_device_path =3D file_path;
> > +             bootefi_image_path =3D NULL;
> >       } else {
> >               log_debug("Loaded from disk\n");
> >       }
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
