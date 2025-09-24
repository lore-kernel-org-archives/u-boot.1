Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A29CAC5AE
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 16:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 048B98323A;
	Wed, 24 Sep 2025 18:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FP0c7LpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52ADC835B3; Wed, 24 Sep 2025 18:34:20 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7D5B83071
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 18:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-4259247208aso2691165ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758731656; x=1759336456; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IUExP++Lmz5KBDYDhHaDUSb+Jk31imiyTJ+8kJdoyj4=;
 b=FP0c7LpAzcR19cXJVKMfXDhwe7IEpGCU2oLjHjRvfOF1hG72RozVPZY38OnskE1NA6
 5785xJ4ja5s2Yg8tNbEzJjmmnEbgjRlqz/sSE0aVbvxNSck62iD7tYF72TdsS4dKTawh
 daevxfM36aEM6+Ik2GnaCNf6LXpb5ueldzTYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758731656; x=1759336456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUExP++Lmz5KBDYDhHaDUSb+Jk31imiyTJ+8kJdoyj4=;
 b=DNuC0UTHCyPBx7kGp75mhq6pNp1pe5eJAGHcG6NCKIelw2QugHV6FkqusO6iy4yM3s
 4jD/oK/HrFd/xzXlPt9v0CmD3i/lbFXbPxAMu6R9fHBwtinEnBD9b+xuXKpb2Du4XtRv
 1Ml+FAIS2wecMY/KPXkMhgqlpumI2cXJUEPOOOFX95J3woftlC6M4hGov9XvUNqdapzA
 W6KQ/UqU47gZ9Y2ZkIjchEpW6IEwRxNPPfUDuzRG0TaaBMVnW49zoVVAX3+1nAgk7WHy
 gESbrt9S3VatDtw8qiG/XSHbPZ650ScyvjPg7pMmhsrrN3wbm1Qmxr5i0BlwYcALNgqx
 J7AQ==
X-Gm-Message-State: AOJu0YwodPh9VGP9jhxGANLk/YDx6IkyTx86IdzH2F7O1XVw8sfYZs5O
 jACRpS4to3s6OtGFio1XbYXcRHw435NsMQMiGkSyUb99W7dXKghHUj4USy04UY3MBAE=
X-Gm-Gg: ASbGncup2MQQCUu/2sYAPU3c6VecqBuTqq3//amOMSicizG8ktsa5vK2nEm7NYijNLj
 C5UOx4NnVAVm9AJgrXfdzxw0nO6OyR6fDIvsHf8i6KzcZo+jd8RR/7AtfYCb3bw+vtnz1HhI6WW
 CuPa0Kty3O7b2VtKVlmLSH5AzldYwKb7pcsGPAP9qbtxBvz3LGyRNYh25tyii14Ui2Hxm6o+VbZ
 Mkal2w3ueKSDyXAg0j0+sWZ5Wrrf1rg2JD9wvbs6jfWCAY9mmbNGNZcVlbMr8RIR3ViP7CIsR6e
 aK5LaJ7+jYjkJfqgPP0y+FomxLyB8yV/mrFx3IPf+G1Z3Uu16i2ZWXND/4PQo2ZMpFgxf7aa8AY
 JyXaKBShl7wONxyI8r4oO2gFKa32/RvrSewEU+JxF0Bkb/LdT5VdQT1Rq
X-Google-Smtp-Source: AGHT+IFzS8HxR2RwmTXv2TLY/c2kB78C6TN6WX90j57o1AL4Y0iydkKNFW3A0bTba0yirWYDfCLjwA==
X-Received: by 2002:a05:6e02:4509:10b0:424:8c04:6080 with SMTP id
 e9e14a558f8ab-42595637d28mr2901535ab.22.1758731656455; 
 Wed, 24 Sep 2025 09:34:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-55e58af148esm3485423173.5.2025.09.24.09.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 09:34:15 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:34:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Bootstd for sunxi
Message-ID: <20250924163413.GJ197373@bill-the-cat>
References: <CAFLszTg1=XAnzoBEtduADXLS3xQxeNh1Dn_77Dc_V3bTUhhFzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P1H0Mi6QHnpVQyVN"
Content-Disposition: inline
In-Reply-To: <CAFLszTg1=XAnzoBEtduADXLS3xQxeNh1Dn_77Dc_V3bTUhhFzA@mail.gmail.com>
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


--P1H0Mi6QHnpVQyVN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 10:28:45AM -0600, Simon Glass wrote:

> Hi,
>=20
> After the discussion on the call this week and Andre's suggestion of
> putting FEL as the first global boothmeth, I took a look this morning.
>=20
> I created a new v7 series without the 'efi_loader: bootstd: Drop
> bootmgr for sunxi' patch.
>=20
> It seems to run OK on a Linksprite_pcDuino3 but I'm not sure that is
> enough. The FEL boothmeth is first, which is good. But Heinrich did a
> series to reorder bootmgr which hasn't landed and specifically I had
> concerns about this patch[1].
>=20
> Given that Heinrich can't make the calls, I'll talk it through with
> him separately and reply on this thread. For now I don't see much
> benefit in sending the new v7 series, but I can if desired.

The biggest blocking part of the sunxi series became that it showcased
the more generic problem with integration of EFI and standard boot [2]
so yes, getting that resolved first is the next big blocker for trying
to migrate more platforms. It was unclear to me then, and still unclear
to me now what the value is in exposing more platforms to what I believe
ends up being a less than optimal experience is compared with what they
experience today.

But since no one can actually test things out and see what is or is not
different with the switch, yes, you should post v7.

[2]: https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.153493=
1-4-sjg@chromium.org/#3418689

--=20
Tom

--P1H0Mi6QHnpVQyVN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNQdgQAKCRAr4qD1Cr/k
CoeoAP9a0jLMRqQaH5WK4SedeWufQXEVlqbag4Vm8IiMjKNTaQD+LsuB/6iEOI+u
xry7vZ7Q+J1h8YA3+RhWtPc8YFTKZwo=
=/UIt
-----END PGP SIGNATURE-----

--P1H0Mi6QHnpVQyVN--
