Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771BDEB26F5
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 18:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3BF083D8B;
	Tue, 10 Feb 2026 19:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ddo9QuEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3682683D9C; Tue, 10 Feb 2026 19:08:21 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C58C88367F
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 19:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45effa36208so720745b6e.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770746897; x=1771351697; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYF5im18zma3N6pg/INniQn2vj7lqBlTCtGct5a/o/8=;
 b=Ddo9QuEGRKOti1bCXlCDrG/yX6qDA7wPCUlS/MhJ/dOW+dVUYM9lV8dZWeYOVO6QjY
 nnQC9ZpianheiaPsAuzPoPrqFC35pdLUPD7RhDntahSe1n6NGzsVNJhn77aY6iE2C5GK
 aIOO5JDeWDCjPV9u5D96vlkRZHFdK26FOjWlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770746897; x=1771351697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYF5im18zma3N6pg/INniQn2vj7lqBlTCtGct5a/o/8=;
 b=lc3FMBlva6ScaNZkMDVWExvUjxMj4zTvFoNkZUzGTacUba3BYXZaZSpIhFjWyYft8T
 13n4j/lCggQtN7PkTONZT8Cn6s2L0jsROg4JhUvimcQ5fz7rG7Rw1D6enADY5FM8DnQ+
 h5QANSZOK8h2JyjTlG3H7h3m0EZQ0yT38TbEIF1CQ01ChPX5+bLoo1stlEQiHpQmbzUK
 u7oHAfDwr0tBk+CpGxjKoNFPsaSz5HjxuzCLN/roj3YMVTNN899p9ZrSJYDGEKINKNYl
 yVKxsOGTYAKN22dSqx5+sNi724QQ25Xr1f7l/91/bohhtXzxDSXq5UCfDmvW/Qp17vrg
 MPNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsuWwNeBIkDKN52YF9jXlv9tHirR+j2zx//bueDX2LBh8xqYi2ogWPBxRQCplIL37UXwqa2wA=@lists.denx.de
X-Gm-Message-State: AOJu0YxmhE2djB/NoYuoTo8uubHW4yMZHwtPY8MzoUsul0gIc147PuKe
 RxYp6oh5q25ZYs2cfUI+DBtZuWY71/TICI8fRmPObPXwFfGk/FpY83Bq2oZvLtOVPa4=
X-Gm-Gg: AZuq6aKYMNiqTXpHwKv/bUMoaRLaRv5ILgSFZ+O24HCBmulb4LxAvyn/u87jj1lf9XP
 wCi0Ndik6biDN9P73pnE67tTu7kEd5WSZ6UMCxTASWgdnx/D4Sz16/1K2gz1llX8K7z7bKgwvHs
 92nO0TIFrttPIDFlVrvnXUP6/OEEuJ5H0O6j1QvO8k3/q0fOlkPDc1G3/181FohFRLLYgXu8sjM
 Gg53+r5vqa8MLYgOb5FgpsbLofR6kmQ5OmFmw5XiqHhIFO/XlB03G1AzfFvWguiDJis1zT9tXI/
 SsRqUyLs1qaG0kQ5Giw8LgdOVt2PATJWN2DQV8pAy/D0kQNyGssrBzOYIf6QzPnNjHyUdZgGqUP
 nHWYVy5SPAFSWh6wZ8fsbmECYdEXl6PhJe2PEmQNQocjwldz95+inGMgWYBUW/RAE5wyLvHCvxV
 NIyUYoQWuKaHQ6BamJEQ7ySwm3xS+124DO409nwF21d5tcSsp2yVUtEsuy+YLZVaB+HlWQIcRqa
 I6mD1/oSaUFGUCL8Zu426w1Vpd4o7ybMhi2r1pbt6smkpCfkOk=
X-Received: by 2002:a05:6808:2389:b0:462:de55:9d48 with SMTP id
 5614622812f47-462fcaf6e96mr7814637b6e.1.1770746897510; 
 Tue, 10 Feb 2026 10:08:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe9db9fcsm8966105b6e.8.2026.02.10.10.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 10:08:16 -0800 (PST)
Date: Tue, 10 Feb 2026 12:08:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: vigneshr@ti.com, bb@ti.com, u-boot@lists.denx.de, n-francis@ti.com
Subject: Re: [PATCH 0/5] Update DDR Configurations
Message-ID: <20260210180814.GB2728096@bill-the-cat>
References: <20260203063529.1551907-1-s-k6@ti.com>
 <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="14fC9Q69KJhyCdSw"
Content-Disposition: inline
In-Reply-To: <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
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


--14fC9Q69KJhyCdSw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 11:35:02PM +0530, Santhosh Kumar K wrote:
> Hello Tom,
>=20
> On 03/02/26 12:05, Santhosh Kumar K wrote:
> > This series updates the DDR Configurations according to the SysConfig D=
DR
> > Configuration tool v0.10.32 for the following devices [1]
> >   - AM64x EVM
> >   - AM62x SK
> >   - AM62x LP SK
> >   - AM62Ax SK
> >   - AM62Px SK
> >=20
> > Testing:
> > memtester - 50% of memory for 10 loops - PASSED
> >=20
> > [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/=
docs/REVISION_HISTORY.html
>=20
> Gentle Ping!

Is this required for v2026.04 or is v2026.07 fine? Thanks.

--=20
Tom

--14fC9Q69KJhyCdSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYt0BwAKCRAr4qD1Cr/k
CjuGAQDVNt5xTVMWAWkTuIPl8kiRa8bEWOVHVuO9nclJizCHZwEA0u7YAJ16elCW
JnFSBIwonSmXi0bTxEqUxNin9cB3tA0=
=ygB1
-----END PGP SIGNATURE-----

--14fC9Q69KJhyCdSw--
