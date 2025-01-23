Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2B7C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 17:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32304801B0;
	Thu, 23 Jan 2025 18:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UNETPM4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A7080214; Thu, 23 Jan 2025 18:12:48 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80CE580137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 18:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd43b08674so10629316d6.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737652364; x=1738257164; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z58MLF0nlkabZcDq8TwuZxJsQ4s9zj/WtRuaoBzfpYA=;
 b=UNETPM4l2rM3QFfQTJVoMbwXuw9Zr9ITI/QR7exFJuUbCO4E/WvQnzvdcghiZrxMBx
 BiAGpMVD6id+GbILUeKJQKuBgqAAFYQvwqc+avKhK3vRfEG+CnlDu3nRxeoLc+87k67l
 IrLQHkVULrCcfmuDWO/bZQeWAT2gsR/+wDNRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737652364; x=1738257164;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z58MLF0nlkabZcDq8TwuZxJsQ4s9zj/WtRuaoBzfpYA=;
 b=xDsg2Cx3uyaaIoX82TOEGFg/Yva/yOFyjx0CYS8q49zy1Ho7mCt+gbTuYMX0Kw/Niu
 NZgVNglj3D+WnkP12HpI7U4OtI/S51GgOAIrHSVObhipjB50H+bypQAqv1Ql7U5PN/xg
 V/jnfUCnWrG2uceVoMhmFTRugIoHQP75WxG9UvJWyA4gEX3nZAm6ohnZUUVsRLpEGVxu
 2xUe6dJY4KVAxAXR0/n0Vy/fDwvlxVmJCvz2GMeFMBgg8n/lk5JmBT9pRYHNF9A9oRnz
 Mk2QiK4LcVVDaVylcFLRmtB/+LJNSAeVgWaDBvnJ/tHPfhIrRPVU2qg9dLa80ZoflOcc
 622w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSzr2DMcl5ttC7E2SPRbdoSpC2Mxj2FGZ5e5m+GhNjlxAABW/3/UZ1GpkPpFMt6Xr8WZ3daFQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1vDEImV3rUpyAh4vs8cbu8J4GI/Ec2bfgqVIk3nGCW7NhpJCr
 IJyK/C0iR5ij3+zJDriWbSQXwoRSJmGTJU24V5/wmq90tFNAiSTg7p5IzSrozvuSeLnE+Au8mRL
 Qct0=
X-Gm-Gg: ASbGncshAyWr/NaRoSGQW4lEACfhn7IMu4+u0QgIAK61bfg6EEH2J0S9j82UtSIFuhV
 vW34vDoFe72u20QeRhhe4QFXkKKBjPOfBv4MKvgwnwnyfykmCSqyvBPJOtFkTGpAHk7ecR9KfVf
 h9CrO56HSxDbszq8GGl/bKLntVWS5SpN8WBR7bgxNib2RLIvDSjDMMNs2kq18VeeEBzQl/ZiNyc
 RluppEBhPuE9OTLX/Av+cIESH1BTXNpdoxM42iIRToa+TLEgPLwBr+bI/LX+QxDNnfmJNw98J4l
 2QA1
X-Google-Smtp-Source: AGHT+IE5tdQIbOEeGch5hbBJ5zx7Z13s2PKcFiD+Tai+ZCAnQsXRAG7XYImRmdDw/qpYmO81rP23Rg==
X-Received: by 2002:ad4:5c6a:0:b0:6d8:a4fd:d247 with SMTP id
 6a1803df08f44-6e1b2170094mr436477466d6.7.1737652362800; 
 Thu, 23 Jan 2025 09:12:42 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e20524b383sm469956d6.49.2025.01.23.09.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 09:12:42 -0800 (PST)
Date: Thu, 23 Jan 2025 11:12:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Message-ID: <20250123171239.GM60249@bill-the-cat>
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
 <20250122172103.GA52306@bill-the-cat>
 <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w2o0P3kHoPmjiT1m"
Content-Disposition: inline
In-Reply-To: <71c99ce9-673f-43e7-8bdd-86afb64c3707@arm.com>
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


--w2o0P3kHoPmjiT1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 05:03:40PM +0000, Harrison Mutai wrote:
> On 22/01/2025 17:21, Tom Rini wrote:
> > On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:
> >=20
> > > When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
> > > bloblist present in the incoming standard passage is utilised in-plac=
e.
> > > There is no need to specify the size of the bloblist as the system
> > > automatically detects it using the header information.
> > >=20
> > > Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> > > ---
> > >   common/Kconfig    | 8 +++++++-
> > >   common/bloblist.c | 5 ++++-
> > >   2 files changed, 11 insertions(+), 2 deletions(-)
> >=20
> > This leads to failure to boot on qemu-arm-sbsa as seen in CI:
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10392&view=
=3Dlogs&j=3Dac5e904b-a30c-5e1d-9570-462b8181c990&t=3D863544fb-ed04-5d34-fda=
c-10f5bbb057bd&l=3D423
> >=20
> Sorry, I'm unfamilliar with U-Boot's CI but I can't make out what the sou=
rce
> of the failure is. All I see in the logs is what looks like an intermitte=
nt
> error.
>=20
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10392&view=
=3Dlogs&j=3Dac5e904b-a30c-5e1d-9570-462b8181c990&t=3D863544fb-ed04-5d34-fda=
c-10f5bbb057bd&l=3D423
>=20
> Would you be able to share the results XML?

The problem is that qemu doesn't start anymore, sorry for being unclear.
Looking at
https://source.denx.de/u-boot/u-boot-test-hooks/-/blob/master/bin/travis-ci=
/conf.qemu-arm-sbsa_na?ref_type=3Dheads
we can see how qemu is invoked.

--=20
Tom

--w2o0P3kHoPmjiT1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSeIMACgkQFHw5/5Y0
tyxOoQv+IeaUoPdWNvJB+LEyJyNMpPTj1TK789e5q39SfWBHtAO7kBonRu+ioOSI
DILFAZg7Kj1P6sPlCaV2vV69bBGUJHIiPJ9T7R5I9WlKbkWxhn7tLIPfAtq12xCF
CUrB0KMLoVKEDD/yk/0aTsRSInUa4RBADMZRv/rxaXK2jGk4zMVkh8IOj2LCHI1q
mFNf3YcDPklgFyvb6aAwL5w8EM0wLbtZ+IGfFGppFW6BAP1dSZlhrYQ12v4bxVYq
u7ltCMDWBgfw1gzvBcp+eb2fbrO7KtkLGnesVA2uUy6tP5vTskwaidRBrVoPvdRZ
6pHj0d12nzU7jSdXVCCaRKtYtIliYnZMYq852zxrSjiZiWM5ueQMAEmpBD9PykF1
C6hr1c2grx3Fc23xcOlJ/Vf7jm77pjsh34w9zIojw0NCrvDCFFqGIEsK1yQhVYIm
2bsnfhtndIDJ8a1SUhGpcPHYaDt/NPI+ZwConS1b9hcTOMCnbqs9fCbe9h2i4EF7
mdJ8wUK+
=vrcQ
-----END PGP SIGNATURE-----

--w2o0P3kHoPmjiT1m--
