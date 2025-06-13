Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1B7C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 15:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1291A82CE7;
	Fri, 13 Jun 2025 17:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k+5INSpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62D8682D21; Fri, 13 Jun 2025 17:49:29 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07CCF82B0F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 17:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-735a6d7c5b1so1486523a34.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 08:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749829766; x=1750434566; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5k7VZR2skNMJWrpPy+4ZxPor8kN3dTQsCJ4g0jMRgwY=;
 b=k+5INSpj1uSMK4N4dJI23iVstGXqVjg24sPlx/4ghLFiu0k/P6pthbSF8lRAhc6Wrv
 499w79SVwEFF6GilLDTsfYKG+/0ijdnIWorRFaW6+JEFxSSfiDTQVSswgZrpBmcgCWpm
 ZPQqmxhbOlAu/7a7MRPmX5Iw6mAWTWLIO5ud4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749829766; x=1750434566;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5k7VZR2skNMJWrpPy+4ZxPor8kN3dTQsCJ4g0jMRgwY=;
 b=DvhR2CU0ONguxqSGtuDvEGHbmK99BYmIeXXYzX2B8q2ufDGsO2gJ/yOc/dnbwaA4c5
 JWAMwVdhYLZApnVH82JpAcaI9kucYp1jaDXQM76d/swn3jN/KtGl6jICGZfXHjQU4Jc0
 RK2XHDnJ1zAjhExmL3tKHyrX4Gtx0g7haF9S2e/M5RqTmq07RpI+nM6qfr2KXGm7I4TZ
 D5gELxnoY0WVBCzA/8rFblwwJhAOFa7O8eDOPM72ankjvBtGU4NzLlYWkds7+iduyIe5
 mm+LM3G1eJunnaJlpoRRHGIQQDbl//VWmxo62VJ/8d7gflulotQmi2LDDpYcPb2///19
 xPog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSEupHSII/0F4ju+imrMiPlyLjdKrwhEWczfNPoVu5M8CsRpqHAynzSoBeK/gwyvfBkM+bpK0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxowlg9EB6v7A+vYfCgvxULowl5vf+M+epyeTKrcqVQwTz3R/Xf
 pFFq51m1ivM3CszZJU8LLnZhhALEXeLnzk6EYsyOJxJPwota/Ht87oMXyyh5J8X5+sQ=
X-Gm-Gg: ASbGnct5UfQkPBmxsMqLWJsxkI368l8u++z6C3vJyZFNOJurxjO3k/QOdjkeKrd+Fzx
 cq6Oiq2gMeteW28Dmq7z3PrbT9mfTTLJuGRF3CHkCGUWr74vjQbC6P74Q8yCCIcjBPiwclQ2jfj
 H+KPkcoPCZ7ebNRfoxaUsiKibkNCDP2ffaIsZIk1ish/6C8TIW66vyqh5oUR4DOjFEcpoZJ84az
 uP1sF6rU6zdrXvhx6pEwchWZ3s5njS1tStpWc7svizsVBxFDJYG8l2Yt4uWTXMz1g+ahHzjHvYR
 mOZzfCOTJmVh86ep5qjGlzlDXe/66q/1BVB/GNiL1tJY7vjENBRndCOTED1LxOVdm74SXaBsb4o
 A2Wc/dyPI1dSBU1ytGn8e5HAoMa7IKNjrmQ==
X-Google-Smtp-Source: AGHT+IE0OiFA65XCuioZm/BlH2H1/ATT7ZUETEwp9J4s5GVdA5Uxm3RnBz4fRWViP12PDJXoNIsbRg==
X-Received: by 2002:a05:6830:6c88:b0:727:3303:7ea8 with SMTP id
 46e09a7af769-73a363d18fcmr147588a34.25.1749829765729; 
 Fri, 13 Jun 2025 08:49:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a285319f2sm243288a34.48.2025.06.13.08.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 08:49:24 -0700 (PDT)
Date: Fri, 13 Jun 2025 09:49:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 mkorpers@redhat.com, mskrivan@redhat.com, eballetb@redhat.com,
 mripard@redhat.com, alexl@redhat.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 3/3] efi_loader: disk: add EFI_PARTITION_INFO_PROTOCOL
 support
Message-ID: <20250613154922.GY1382132@bill-the-cat>
References: <20250613085742.796015-1-javierm@redhat.com>
 <20250613085742.796015-4-javierm@redhat.com>
 <2584944A-D0CF-44E5-ABAE-C3E156ED8539@gmx.de>
 <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v40jQ51L4Kp8vngf"
Content-Disposition: inline
In-Reply-To: <87ikkzvghz.fsf@minerva.mail-host-address-is-not-set>
X-Clacks-Overhead: GNU Terry Pratchett
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


--v40jQ51L4Kp8vngf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 04:54:48PM +0200, Javier Martinez Canillas wrote:
> Heinrich Schuchardt <xypron.glpk@gmx.de> writes:
>=20
> Hello Heinrich,
>=20
> Thanks for your feedback.
>=20
> > Am 13. Juni 2025 10:57:38 MESZ schrieb Javier Martinez Canillas <javier=
m@redhat.com>:
> >>The UEFI 2.10 specification mentions that this protocol shall be instal=
led
> >>along with EFI_BLOCK_IO_PROTOCOL. It provides cached partition informat=
ion
> >>for MBR and GPT partition types.
> >
> > U-Boot is targeting the EBBR specifcation which defines a subset of UEF=
I.
> >
>=20
> Interesting. I knew that the u-boot EFI implementation was to support
> SystemReady IR (what is now called SystemReady DeviceTree) and EBBR,
> but I didn't know that meant to only implement what's required by EBBR.
>=20
> I noticed that EFI_PARTITION_INFO_PROTOCOL is not even required by SBBR
> and only EFI_BLOCK_IO_PROTOCOL is required there just like for EBBR.
>=20
> > Which application needs this protocol?
>=20
> We are experimenting with a new A/B boot protocol and an EFI binary that
> implements it. It's inspired on what the Android Boot Loader does for its
> A/B booting too.
>=20
> The project is https://gitlab.com/CentOS/automotive/src/ukiboot and reads
> UKI (https://uapi-group.org/specifications/specs/unified_kernel_image)
> images from raw data partitions. Just like ABL reads Android Boot images.
>=20
> > Are you planning to add it to the EBBR specification?
> >
>=20
> I haven't thought about it before but I also didn't know that u-boot had
> this requirement. Probably it should be documented somewhere to make it
> more clear? Maybe I didn't look enough but didn't find a doc in the repo.

We are not strictly and only EBBR requirements, if there is good reason
to add more features (and tests). But Heinrich's follow-up question is
quite important. I feel like there's already a half dozen offerings of
A/B update that works within UEFI.

--=20
Tom

--v40jQ51L4Kp8vngf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhMSH4ACgkQFHw5/5Y0
tyxhmgv+JsEivvvIuQUpzpRouXEp27v5elVUEAbR0MsJ6gAkXqWeUBopE9YKSRSf
EQB1yQTGzFSv+sJp+li/x4LzV3X6wNcOZWWwc5Lvpp5l5LIh+y04d3uBVv+PfE8U
jdyxne2H/IYtSL+nCNdf5BI3UMdTkgwlZscAprvsHeDbpOiHVaEvH+sCRglc69p7
/uEWo3YvnMVUhg0o0sOH9g9HakvjhE3OJeJ3ifC7cY5SaE3MpNnMdCd4hcNSYgZK
pCdZbR9e6p1TR93s73HfJg+/Z3kXLIpWtK4dTbiydp4BLcAEgSRd3NspRbtVbj7W
80JJVTGkUBBojh+ndzPTrfKUfd4B/M7BDalpmYnm5/vbKBCDLaL+4wWxJz9Vypa/
szt5HNtFb88TUCRQenO9FA93H1CVvWVhCDOFlvgVMuZtyR7dzmewaJg1+7bVhzPq
lKFPGDUCrdS+Hwp3CPF83KAHG3CvF8WGnx87NxJF+36YTpfZZdHvEahYEzRe9y8j
OuPnJRN9
=paeH
-----END PGP SIGNATURE-----

--v40jQ51L4Kp8vngf--
