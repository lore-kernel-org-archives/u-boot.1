Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3790BE94617
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 22:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3378341A;
	Mon,  9 Feb 2026 23:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l4YPV1Gj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBEE583C5E; Mon,  9 Feb 2026 23:53:41 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5E4805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 23:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45f0dbe7dafso1214787b6e.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 14:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770677618; x=1771282418; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0ORU3BDQJxguR//Zla399iQCx/s1okcQz1eNbQs6WQQ=;
 b=l4YPV1GjqUkLFR/rA7nc9jyheKIW6J/ppvlJveknxNL9rEPlpAidog1hrkQFPhACHU
 dh4dD2qUiR/DsKircMtXCkzmo7SfEshQn+sonEHDDGRcgNgrXAI6Cxl92VF6WUgzRLQk
 nPY8zs7w5Lyo0ZG/UoTQF61PyGha0fvzQ5r70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770677618; x=1771282418;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ORU3BDQJxguR//Zla399iQCx/s1okcQz1eNbQs6WQQ=;
 b=XsQD7g8PP8Fg65WjWMEQays9hlVTRxgMztGw8zGwtz26n0Lbk3HydpACGnhcAeoUNx
 MirU/5DMr1W3d2vsI/3rbTx3VQE4xM1J5+j8yZm2wj11GKmbK6+mWrHVsT+6CG3Noau1
 yELvG2dEK5tNlvqLF16EYJa7K5XNjevQ9u9iaKkS4CsckgfnWRVuZmOCZ+bEIve4lSSD
 fUYrq+HE6TnuoEZc+HOiDsYi8IkugBCM1kvvtAw8jW0CRjDed83TQO7YqC9tvhRlQKvO
 WXw+87KHl+9+0HMd7uYauqR+murlZPkQ9iasVQj7G7bTpdBHcREBFLbw2rMuekvbMRqK
 igRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhtbBky9pIHf6QeEW5X8Ei3QRJTWolN9d2/tvfvLK16lM829rnkPIkCA3op22ZbrdkTiv3WPg=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3x1G7hKOdqMM0dcAh+Sj8LNgDYEm6Lj1j5CtW4wbLV+iptTk3
 X0g7CknYneTim1Dvoph/En8hSzHYGdBt6zyXRL7YUay1z3qMEiCLp22MfkZs8cn5H6U=
X-Gm-Gg: AZuq6aLjq4LVGSTOGcei+S1i0w177SC5g2g1AyRtGN3H5BQ0gNSlRv8iN7ah8bfdznE
 vxTBd2H6cS5RJn2gSOwnByQ0rRwZ1fkK8ZjQ23qt2eGAPchjFnkrxutbTqCl4hJXTQPWkjuzPXh
 5U6AwvXUZKMxTe9DL+nkoxYq+wH/9Mn541qiFmIkOOuI0HJ8K+f4BFNDWkkMnACD6oz+1hbSiGI
 NQ1KWN3ClNteHz3VbBpfcJw8RovuJOl6Sd2qFDQ7NAAbwwZB2v/8YrrBZNUGwU2+776I8AXKMlB
 MXd9SbE6wKKxU2P+Oh7VXajlz1Q6rMSrEDqd70UceCmrgyw82PtNPjXeHm5YfQztFPel8q3TfJY
 rT+qWuZLVGvjxm4kH+XcLfttZXyeHQQt527rm+D+2q+gPmLM9nn1BzSgpDaDLxBknWRbNt5muHb
 xbSGD8poKZuhUIhM52/+Uop1FGnBBMJqUC/+DRyvOKqUX+KMj6jOlaEGsoPgAN4qtFUnm5aToDd
 mxv0RHkvlOUAIXYJSdrTjTQzLOmdfzdFmsJ+P1eCOayX0Z1ZE2ahhrdZRrFSg==
X-Received: by 2002:a05:6808:4f23:b0:450:ac94:5ef5 with SMTP id
 5614622812f47-462fca1e98emr5679353b6e.16.1770677618564; 
 Mon, 09 Feb 2026 14:53:38 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4631407de2dsm5254179b6e.16.2026.02.09.14.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 14:53:37 -0800 (PST)
Date: Mon, 9 Feb 2026 16:53:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: core: Use IS_ERR_VALUE() for ref_clk rate check
Message-ID: <20260209225332.GA2436104@bill-the-cat>
References: <20260209201415.303190-1-jonas@kwiboo.se>
 <9a23daec-39bf-4b2d-85af-820e015ec4dd@mailbox.org>
 <20260209205126.GK2603314@bill-the-cat>
 <f5dd98cd-be29-4587-8ddf-3e43fcb7a811@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VUDPe3uz/S59PWdx"
Content-Disposition: inline
In-Reply-To: <f5dd98cd-be29-4587-8ddf-3e43fcb7a811@mailbox.org>
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


--VUDPe3uz/S59PWdx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 10:46:03PM +0100, Marek Vasut wrote:
> On 2/9/26 9:51 PM, Tom Rini wrote:
> > On Mon, Feb 09, 2026 at 09:35:54PM +0100, Marek Vasut wrote:
> > > On 2/9/26 9:14 PM, Jonas Karlman wrote:
> > > > clk_get_rate() in U-Boot is documented to return clock rate on succ=
ess,
> > > > 0 for invalid clock and -ve error code for other errors. This differ
> > > > slightly from Linux where only >=3D 0 is returned from clk_get_rate=
().
> > > >=20
> > > > Some clock drivers take advantage of this difference and may return=
 -ve
> > > > error code for clocks not fully supported in U-Boot.
> > > >=20
> > > > Use IS_ERR_VALUE() to check for an error code in addition to current
> > > > invalid clock check to fix broken and unpredicted behavior when clo=
ck
> > > > driver returns a -ve error code for the ref_clk.
> > > >=20
> > > > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > > I wonder if it would be better to fix the API discrepancy . Could you=
 try
> > > that instead ?
> >=20
> > Which API discrepancy? clk_get_rate behaves the way it behaves
> > intentionally and there's some fairly long and recent threads about that
> > resulting from attepmts to change that.
> Align clk_get_rate() between U-Boot and Linux kind of discrepancy .

That's not in the current list of options. Please look at the various
threads in the past 6-8 months (and some reverts about series that tried
this). That was my initial opinion too, FWIW.

--=20
Tom

--VUDPe3uz/S59PWdx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYplaAAKCRAr4qD1Cr/k
CsjTAQCKTtTZaFkreD0XpS1rZUo6Z0Qi4+VSwcfxYUhYp4Rm5gD/Vd8/WiBrtdg8
dykEDcjGtN9HS+T/csV6Cw9iSLyCoQI=
=FGyh
-----END PGP SIGNATURE-----

--VUDPe3uz/S59PWdx--
