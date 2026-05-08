Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F08CD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92A4484DD6;
	Fri,  8 May 2026 20:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K0OAwNIm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F2084DE2; Fri,  8 May 2026 20:12:46 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C81E184DC3
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:12:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so413045666b.2
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263964; cv=none;
 d=google.com; s=arc-20240605;
 b=gsIfkluSKviTDxbSvpkiFDL+KhxlRVUy/KhADdpZDHTVTJ3fYk4UQ3C3y4aQC3WC7T
 glMZqed1PmUHV2XRA4nOGJJeSZUSG4jMcJPQSvLvMaZNSKGoE9CJzdGfZ6EcHRCiV36r
 YXf1Ro1YSBVef8F26Ai57ksZfCe/qwzgR8DzyM7pSb8gQCVsk+us1ABcUZogzUBkcz9G
 Il6DOupsBiNEkI716B9QqcbDMpUKCIPfZBwBrRt/iMU5tq2uJPcf4vr0gmMyD1HjjEx/
 s7LZbNQLFNPQZALgXVSwvDUhhCXrCI5llzOsNx0/DXGKWVJATH7FqcNz3+q5Rya6WHQk
 m4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=64O7vG2AX0zyxIwbM60+4Xh3YyQkhTWqut12iSsJuhA=;
 fh=ygRMXKfDeHWsHPoqZuiKJ52ykjHOmT0Fyb/GAJQ3Vhc=;
 b=QYqE4ENjpXEHU1k8Yvi4t9oMKyHH5BJ9J0rA+QzkxiC8ADUxbvqS2ZD9sx69WaUwSF
 G3fx+QqY0M7Og0eR1NrcRVNIOZopWquxLD84opTDSWtr1V4SQFIdBc4Lv1OATrHb0mp1
 66REwCdnC1sIFNNSrnrc9t44JosBpbiTW+lhOQoM03crq/2o5usaHbw01/poJgCdCblf
 wCOtL8wdtz8VE95EODlSBlR0WSoK0JVtw/rvAm6wzLenmeK8cgs906qomtqR31C1Nia1
 l1vUH5sfaodqzuX5EGUBrti5ZTVrCPiLy9hKi+XoK3ksCPgSGAToYLABe0sAbpF6q6X6
 6kkw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778263964; x=1778868764; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64O7vG2AX0zyxIwbM60+4Xh3YyQkhTWqut12iSsJuhA=;
 b=K0OAwNImYiztYshhip3iVYOgJ4AfEFSMdoX2zEzovEa1hm2x5yFdSJ2gyLNrwRCS0K
 ItXssnYZzJNFawUn2LP3X9E+bkR55vboQvHVjILCXR8E2ypxr3nduz7qnUoQE8RK761J
 2yfo7gAJ+f/DL0bhhyhUZdxQfykE2eE0LbHYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263964; x=1778868764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=64O7vG2AX0zyxIwbM60+4Xh3YyQkhTWqut12iSsJuhA=;
 b=bCa9p/Pzc5A9ypD65LeT+iowIEPvizM5KKC9rBAZe9Bn09UceA0v25j5lta8O2WNkH
 hWqEgfvE/wlshCnDMcbNT8rXo2jkCcvhjDkXnMnsTaF26YBuItoJIgxLkl5xKAMjqIF3
 Uvv+Aoj+0BZ6pY0NcJPOvmzWWArWSFQAImhTf2s31CLIkACOi2W4rx6X1i7Gdf5pk4uJ
 cE0/VqDqKzh9ZlZFY/Zi6xPHvNopZfC7Cb6I9aO0L1wmCuPd3dWVC/GyOzSBkEmMQS0g
 BzIc1N+ghhcKyv9sdpwldEf7LrGKNSb0Zedhi2Vk0RYoj7s8y9qMDmYX3RDomP4VEljq
 jCXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+76XSR2xQ+I2AlCWzUWcPDcc6tKn7QchPj9dAV8Mw9lbum7Sr4WUWgGNOGEyAdeCCJwAEDFl4=@lists.denx.de
X-Gm-Message-State: AOJu0YxgblNMpik16eDoY/cOVgDNt1OaHQHaqpZdCoUXlz3slvHtTcwq
 gUwSugEFP6oYNsvH/ITXwXyojIjC8dUsVxe8UDoC7+gzFPMCyryT6bLP8Pd39yrSaRtaBN8uqi3
 yTs7WL41U0VYYZNb2taNNiuPHap/KV+HJmxT2R/rv
X-Gm-Gg: Acq92OE05gR3MfYHlGgXaLi62bOjpjYmCc5POJD1SS4kw7Xj8gv8Aykb0RZ1wSdI8XR
 0tVn5e59oqKAyF8Yk560//8QEQ/K9M1uS14r61Gul1XnylN/h0HOZw3Nbc6hswuU6czk18QeVvi
 2izy7DVtKlQkt/lmC9gwFppIOHrllNLiNHdZnK7K4fGJXXzn9taQYjYcdaO2LCG3JlkKHsixAvK
 V+WjpSLuCj6WwrcV/hjMjMgG75R05v+tAVAn0NwmSR52+iwPKn2Cs3ktcZBlsGyhCUPmzl6cOMv
 NDd16w==
X-Received: by 2002:a17:907:1685:b0:bc6:7238:bd4e with SMTP id
 a640c23a62f3a-bc67239005cmr605620666b.5.1778263964126; Fri, 08 May 2026
 11:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260430223319.2663939-1-lukas.schmid@netcube.li>
 <20260430223319.2663939-6-lukas.schmid@netcube.li>
 <553ba73c-8a90-44e3-9809-185b0fdfd2ce@cherry.de>
 <CAFLszTjwdY_+17qWouSMq9Bh2N1UJ6_Sq-JP7huwA5Y-YKb9zQ@mail.gmail.com>
 <2cf115f3-c889-4b57-b20c-3eb2b7bbde03@cherry.de>
In-Reply-To: <2cf115f3-c889-4b57-b20c-3eb2b7bbde03@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 12:12:32 -0600
X-Gm-Features: AVHnY4IkHrkAHFd-hN1hdVK1-XxewlSe4BH_f4oyPjZldNtBBbNu581-BBxsAes
Message-ID: <CAFLszTgj0Bpq92jaRD=f5AzDM_SeqisjZP6LxNyuhWOZ9h+3=Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] sunxi: extend binman FIT description for signed
 SPL images
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
 Andre Przywara <andre.przywara@arm.com>, 
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.denx.de
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

Hi Quentin,

On Fri, 8 May 2026 at 08:02, Quentin Schulz <quentin.schulz@cherry.de> wrot=
e:
>
> Hi Simon,
>
> On 5/7/26 6:49 PM, Simon Glass wrote:
> > Hi Lukas, Quentin,
> >
> > On Thu, 7 May 2026 at 05:30, Quentin Schulz <quentin.schulz@cherry.de> =
wrote:
> >>
> >> Hi Lukas,
> >>
> >> On 5/1/26 12:33 AM, Lukas Schmid wrote:
> >>> Extend the sunxi binman/FIT description to support signed SPL FIT
> >>> images. Add an SPL public-key DTB image, per-image hash nodes,
> >>> fit,sign support, and a configuration signature that covers
> >>> firmware, loadables and the selected FDT.
> >>>
> >>> Handle TOC0 SPL output as well by adding the required filename and
> >>> mkimage wrapping so the generated sunxi image remains verifiable.
> >>>
> >>
> >> I sympathize with the effort as I'd like something similar on Rockchip
> >> but I don't think this is right.
> >>
> >>> Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> >>> ---
> >>>    arch/arm/dts/sunxi-u-boot.dtsi | 68 ++++++++++++++++++++++++++++++=
++--
> >>>    1 file changed, 64 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/arch/arm/dts/sunxi-u-boot.dtsi b/arch/arm/dts/sunxi-u-bo=
ot.dtsi
> >>> index e1a9a7f5d4c..313fcad3922 100644
> >>> --- a/arch/arm/dts/sunxi-u-boot.dtsi
> >>> +++ b/arch/arm/dts/sunxi-u-boot.dtsi
> >>> @@ -27,6 +27,38 @@
> >>>    #endif
> >>>
> >>>    &binman {
> >>> +#ifdef CONFIG_SPL_FIT_SIGNATURE
> >>> +     spl {
> >>> +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
> >>> +             filename =3D "spl/u-boot-spl.bin";
> >>> +#else
> >>> +             filename =3D "spl/sunxi-spl.bin";
> >>> +#endif
> >>> +
> >>> +             u-boot-spl-nodtb {
> >>> +             };
> >>> +
> >>
> >> You're missing
> >>
> >> #if !IS_ENABLED(CONFIG_SPL_SEPARATE_BSS)
> >>                           u-boot-spl-bss-pad {
> >>                           };
> >> #endif /* !CONFIG_SPL_SEPARATE_BSS */
> >>
> >> here.
> >>
> >>
> >>> +             u-boot-spl-pubkey-dtb {
> >>> +                     algo =3D "sha256,rsa2048";
> >>> +                     required =3D "conf";
> >>> +                     key-name-hint =3D "dev";
> >>> +             };
> >>
> >> You're forcing the use of an RSA2048 key which is not recommended
> >> nowadays anymore as far as I know. RSA4096 is "better" when using RSA.
> >>
> >> This also forces the user to have a dev.crt certificate to be able to
> >> build the image. It's not a secret or sensitive info so I guess that's=
 fine.
> >>
> >>> +     };
> >>> +
> >>> +#ifdef CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0
> >>> +     image {
> >>> +             filename =3D "spl/sunxi-spl.bin";
> >>> +
> >>> +             mkimage {
> >>> +                     args =3D "-a 0x20060 -T sunxi_toc0";
> >>> +                     data-to-imagename;
> >>> +
> >>> +                     u-boot-spl {
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +#endif
> >>> +#endif
> >>>        u-boot-sunxi-with-spl {
> >>>                filename =3D "u-boot-sunxi-with-spl.bin";
> >>>                pad-byte =3D <0xff>;
> >>> @@ -45,6 +77,9 @@
> >>>                        description =3D "Configuration to load U-Boot =
and firmware";
> >>>                        #address-cells =3D <1>;
> >>>                        fit,fdt-list =3D "of-list";
> >>> +#ifdef CONFIG_SPL_FIT_SIGNATURE
> >>> +                     fit,sign;
> >>> +#endif
> >>>
> >>
> >> This requires the user to sign as part of building U-Boot and therefor=
e
> >> have access to the private key. Some users may want to sign separately
> >> from their U-Boot building step such that building can be done anywher=
e
> >> but signing is only done on specific infrastructure.
> >
> > I wonder if binman could help here, perhaps by providing an option
> > (for CI) to skip signing if the file is missing?
> >
>
> If fit,sign is there, we should sign and not give an option to silence
> fails. The fact we can have SPL_FIT_SIGNATURE enabled and not include
> the pubkey in the SPL DTB is already big enough of a footgun, we
> shouldn't add more =F0=9F=99=82

Sure...I'm not suggesting that the build should succeed though...a bit
like how we have 'buildman --allow-missing'. It's just a wacky idea so
that we can avoid needing special cases everywhere.

>
> The thought I had a while ago was that we could simply have the whole
> setup without fit,sign property during typical build workflow and then
> sign with yet-unused info in the FIT Device Tree. Meaning the hash nodes
> are added, in images/confs/both, with the expected key-name-hint and
> all, but not signed (the pubkey can be inserted already if we have
> access to it, but maybe it's stored in an HSM also, not always easy to
> think about every possible scenario). So you generate an image with
> pubkey in SPL DTB, and unsigned FIT as u-boot.itb. Then have mkimage or
> binman run outside of the normal build workflow to sign required
> artifacts in u-boot.itb. All the info for that is hopefully still in the
> FIT Device Tree such that we can sign properly.

Yes I thought we had that feature somewhere but can't remember where.
It might have been my imagination.

Regards,
Simon
