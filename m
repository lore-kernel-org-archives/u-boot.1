Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7022C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 20:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10AC988D8B;
	Tue, 20 Aug 2024 22:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mao2ZKcX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A7688D88; Tue, 20 Aug 2024 22:16:15 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A66CD88D9C
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 22:16:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-70942ebcc29so4104665a34.0
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724184972; x=1724789772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B5RdmkQtYlQBtMRjRcngE8mEmml+C3SW5Hq2GZ6pQcA=;
 b=mao2ZKcX9l5bZKl0fTOxwRKYm2KX0v7+RWGpSal9Ybcob0SxEW4UXYUJD3hTevxqmJ
 7hmQiDUvmGD0A+Jlp/w5z4Y5LEHVcLygQ8tmOYgVOA0dLb5pIEBWCDvrZwjWKEVRuTey
 yzUNnWD8o9uQxVB/f6RpviPZj8ksM+dZqaLbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724184972; x=1724789772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B5RdmkQtYlQBtMRjRcngE8mEmml+C3SW5Hq2GZ6pQcA=;
 b=aYUX7DP6fKZVsNIAGCSDef8ussyBhrHBkKFddTj5h9v24KPppmPLoatgoEkLLI8+Fm
 TMxdRv+5p5X0jv1lpDF12emnBEbSsGELs4Sl7RHy2X6v5dNBLoamj+71hkRbQ9fM/jCN
 zBfEVdY6jGjHOKkXIEUQEQSM4mmB172VLxcwFBWxeikUITakFX/O1IL/vlS6ertNACxH
 0l6b1z070j2H5+EA6YHgKDFcA3GCR/4Uzvw+nI9u8rPAbbcpQOwz0NFi6y7eSBqXXHV9
 E45HwGjyVzvce2PM+gPYSpzigGRpcaho46kxhtJ8ErJHhsjaMTrvPpUlRjxfZ87+h9bs
 0BVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGp9I7nKTMr14Ncau88zW/VT9OGVvd0/+Uxo/mBq5X/0Rmf1BQQtnFppPDL7i4T8zTNkYBpBw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz25V+GWMFoz2CH8X0QVaF+bWdTyzxKCNG5ih6uHzDtXktzQ17E
 dL/6vnY63v/KL9zJuM8GU7fpOEd0NPHcEOeNYdrZ3DCTIBVGxIVBZ5A2iQHVbaA=
X-Google-Smtp-Source: AGHT+IH5c/i3GEtureX2rpHhkSD0pDsoj3yKEo643Qu8iBDhWHRxLmzNAlm/rDpH2ZRGwqu8PjxJlA==
X-Received: by 2002:a05:6871:8703:b0:270:4219:68fe with SMTP id
 586e51a60fabf-270421971f7mr8421821fac.1.1724184972190; 
 Tue, 20 Aug 2024 13:16:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca66205d1sm2908003a34.53.2024.08.20.13.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 13:16:09 -0700 (PDT)
Date: Tue, 20 Aug 2024 14:16:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Henrik Grimler <henrik@grimler.se>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: Re: [PATCH v5 00/38] mmc: dw_mmc: Enable eMMC on E850-96 board
Message-ID: <20240820201606.GN1626301@bill-the-cat>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
 <CAPLW+4m_rzR-96+4kNfE1a73kiASRAm9m+M56EqqNBZb6V7+5g@mail.gmail.com>
 <CALrBrZ3H_FzVUvCOz59gJCiHEPY3_fG6xH3sQ4nMeMdzugwfBg@mail.gmail.com>
 <CAPLW+4ngCAam8K1atOfVqvhUAvN53oa+t3QQR1YiVeHMpfQp1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Qd2ZrM1EVyEllA9x"
Content-Disposition: inline
In-Reply-To: <CAPLW+4ngCAam8K1atOfVqvhUAvN53oa+t3QQR1YiVeHMpfQp1w@mail.gmail.com>
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


--Qd2ZrM1EVyEllA9x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 02:48:59PM -0500, Sam Protsenko wrote:
> On Mon, Aug 19, 2024 at 8:45=E2=80=AFPM Minkyu Kang <promsoft@gmail.com> =
wrote:
> >
> > Hi,
> >
> > 2024=EB=85=84 8=EC=9B=94 14=EC=9D=BC (=EC=88=98) 10:15, Sam Protsenko <=
semen.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> Hi Minkyu,
> >>
> >> What do you think about this series? It's been pending for a while
> >> now, so may I ask you to take care of it?
> >>
> >
> > applied to u-boot-samsung.
> >
>=20
> Thank you for handling this, Minkyu! Is there any chance this series
> can be merged in 2024.10, or is it too late in the cycle?

At this point I would like to see this for -next and not master, sorry.

--=20
Tom

--Qd2ZrM1EVyEllA9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbE+XwACgkQFHw5/5Y0
tyz2xAwAjaR3MzVmYXww4zXdHL8FalB/l9zgAFrnWEdcGQkfq7oA1PMwoHovuyZj
G9neNtBC/um4yl/WdvhhTFfdVB8ed8AVVko9DSwmawQYu23HyY9c2zH4DLOesKih
nE/nYWEaomFOmr84fGHb+Q/kFwMb1QZ0gu5Yk9p+EF1TVgkw6MMoE26VfjpHX53J
Hleri0Lx4U1UYYRGiP5ez+YGcbW8RqoiSpXq4gY29h+F5fbRYAz5FMgvxEaaswpE
7LYPvaFN6VS0GcZP3BBXrUB/rUPWBk8RGK++fh00Diacd3Ui0O4N12f1rmNOkazf
cTaKavfveGDaZ/SuQvVDxQRqypgr28Te8h2gFP/pIJAddSBzpMBBBLaYRe/9fDBh
q7wqB9OUe4x2Ce3OZOC35sKGpPl7b3E1TfXZHU3rm5vFlT2ie2jmYTMqAt0RueiQ
dagTRqNuWQ4q3g5yDzJ7VdMarbaM6b74IrG/rXnqFNPFbFc6B0ed1X9A1hZhb2op
50X55h0c
=LYS/
-----END PGP SIGNATURE-----

--Qd2ZrM1EVyEllA9x--
