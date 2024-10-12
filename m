Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACD8D0EE3F
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB46588F85;
	Sat, 12 Oct 2024 03:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="twu4AV65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1971D88B64; Sat, 12 Oct 2024 03:33:26 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DC2788B64
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-45f059dcc77so27016791cf.1
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728696803; x=1729301603; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GI5Q/5qmZI8OWxeUA9ctawEw1PY1bXiynJrsHZkemwQ=;
 b=twu4AV65/x2h1Cw2qAkGcn40ByYC9GFBnTEN1xu4PZFEBr+xiZBQZFUptKMM2xPkRO
 yB73PcAR3H9LYAQjgNg00vIUwexBPfyUH7MRYVnNO1AOw6Z2WBp65C9KyAxvC+Dn2CIp
 GqDIH+9BP8T0JLYS4SSZKPEZwzLXx8ugHgTF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728696803; x=1729301603;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GI5Q/5qmZI8OWxeUA9ctawEw1PY1bXiynJrsHZkemwQ=;
 b=sKI9t2V/A9dT2enPWPWm522a60Beay3grUDUNjxiYjWcaHwf+Ghe5owE5T1+HO5U7D
 c/pFJodf2MRgJIIlZX8QWBmezt7B50sCCxn4pYSZYoysxOti0tXiwPy3xGHS2QVzBf1o
 hJTq1SqWgpiiOfVT+mOcRXQKOIfWviuSrCEgjnuRP08gO2dDQQkkb3++TMcihjCr9k98
 J8+xv9xM51H/Vvz+AvryYv6f1Dkg4Wl6RgD01SXWg4b2erGRy8Jpjc5nVO2P7qzPLZv3
 NJPZKhACPCIisefZ+1+uq8gOBwLaqzycscKw+MM+KVYLrnWg5giiH3E7RiayxasKqUmV
 tUwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8j0ErQxcLUZ03PShENpV1Y5hWEXWGPuX428pZyqaOK0qa2Xk3P/u0GLYku1TWU/en5uXEEUs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0G4Ra9KPjICATnu4QXdLd+gC0ospjLJUvvnF/0vzXXICzvHQD
 EgO86KDuH4vz6apgC47vIooAboki6bllapFdrxfzgUzl149NvWth0JD1dr1zfLo=
X-Google-Smtp-Source: AGHT+IG7hWwRLnj1YrYew/9vgeKemcfRI9XbC2uK39abvZyJzkeWe169eWEUaZaO4SQdTiTlmbWUOg==
X-Received: by 2002:a05:622a:214:b0:45f:886:4488 with SMTP id
 d75a77b69052e-4605839cc63mr28155601cf.4.1728696802792; 
 Fri, 11 Oct 2024 18:33:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1148d80a4sm186940485a.44.2024.10.11.18.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:33:21 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:33:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 2/7] common: Tidy up how malloc() is inited
Message-ID: <20241012013318.GG14210@bill-the-cat>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-3-sjg@chromium.org>
 <5F3C1A6C-4EE2-4E5A-A6D9-F7943827A3B5@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QCtiNE+gPJGho6w+"
Content-Disposition: inline
In-Reply-To: <5F3C1A6C-4EE2-4E5A-A6D9-F7943827A3B5@gmx.de>
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


--QCtiNE+gPJGho6w+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 01:25:37AM +0200, Heinrich Schuchardt wrote:
>=20
>=20
> Am 11. Oktober 2024 23:40:26 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >The call to malloc() is a bit strange. The naming of the arguments
> >suggests that an address is passed, but in fact it is a pointer, at
> >least in the board_init_r() function and SPL equivalent.
>=20
>=20
> Please, do not push sandbox only code deeper into malloc.
>=20
> We should strive to get rid of the sandbox only virtual address space whe=
reever we can.

I don't think it's possible to get rid of map_sysmem() and friends, so
this is I think quite reasonable as it starts moving the detail from
every caller and to the core places where it's needed.

--=20
Tom

--QCtiNE+gPJGho6w+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJ0d4ACgkQFHw5/5Y0
tyx4owv7BnGeTXNoSQxM2TetEtDz7PO5wlVEv2IcwMzBO+HnLT5+4DFcANPydqA6
2n4vbZiLQDjp6q/bLmdhUACqTC/rSIlM1RnEYapNx5kjF1X+Xr1e+/Ri8ZbnimTJ
kYCH/ixear7vSJNptM+azWi5Nw+gwpCDvR0/wNO0nVAQv3PIGhzu2dciDzrucmou
KrqqjyWXMS9UPvGlCOXzM97GqGx0Z75ycqA7y8ES8wyILPteb8dM5IBQXfi8393O
eXrE11ur4UUcHjevpSkZAuiC/CsQwINJjRzwCaaS3igcBuveVWMZTRcmndvBoVHA
E9v1JY/lO4TPkihTVIFX10KZlz81GRodPhnkVQYHz3g8Psfwk7Qs5JKl0pJLrRwP
ZBUBGipkZ4dvzkFZ2rjmb1MFsUsOSVKrq2JZwcBkIXI8wYu/mII7lsexiJqJGGUA
nCmVK4nsh827Wim3dbdkkFX0l8Cc2cTrl9ZarcKjBamNxnGWHmMfovH0qsDGtMHM
uKFbiUCM
=HPIh
-----END PGP SIGNATURE-----

--QCtiNE+gPJGho6w+--
