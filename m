Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846BEC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 18:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E857E829E2;
	Fri, 25 Apr 2025 20:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kaqLCs00";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29395829F9; Fri, 25 Apr 2025 20:05:18 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D92C282977
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 20:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3fe83c8cbdbso870731b6e.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745604314; x=1746209114; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k2q8VfqAbweKKVPxMRYrtuAvS+zSaxvEGikYBp66TcQ=;
 b=kaqLCs00PiHeYYBYZEB9WjDLTlrwzCKQwlqY5Wz+m3XIBgPgCHO8lKzr8qOwALh+uR
 Uz9CscpQCIqmZu5YIjTXq6Gj2NIxKrj626Q87Fd8LmgICzz/q8g4teg/tSppkwezoDV2
 M3meuXf9UOsyfGlBpzmxZ6AFLjiseieylhiMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745604314; x=1746209114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k2q8VfqAbweKKVPxMRYrtuAvS+zSaxvEGikYBp66TcQ=;
 b=uLF0sy9MHK2VFKcPZ7eWSHb13jeKTpDbJeih5Zg8E1YlU8Gfq1wLdzCuC/nzn/ytlK
 NpdpsqzLp6KijOzzQiHeX6OUyhiNFOBUszN8TdxdLdGAIKddljW4qjqqgmAcArwm6XPN
 uOuQloJ9QDVweu1PWmZhVLju6VTR5wY7VCELz5ZGtjiP+RXioD7aLL+I4o6hIC8MINzY
 QUWadDRRal0TAw7l4is0lG3AOLhekVtSH2JnvAWK960SC+vJQiRZNRvlBpyrRD9TH7/J
 fGEV9ak5I03Ez5SkTv3msFsW/5H2Zf+tnt3izwFzWICDGWV3a45ZJ3wgVocrcbaJuRPl
 jY4A==
X-Gm-Message-State: AOJu0Yz9QfdgOysznNjCmQ810jQZt4bSpSV6zZv5U6T1RV7PFKuR7ARc
 NWdYOU77Pg9PEOzlMgHNHbOk6Q+05lXhDvyPLw3DKsmANLceam9i9cJaNqiZDjI=
X-Gm-Gg: ASbGncu5ArnwhdGS5oIILBWHcR9NpZQJsRh1MbYAgIMM2VcPR3BohtCJcJm1HTD+Yto
 +yonOW8CHg8WZw/aEC8s/oO9hOZToQL8bBjkNlArKwO6GU8dSOjfaiwG0iB3M00ZETWp/WEZuEE
 R/OjZLSHsDA6zzyTtOyKnvYbTRnItrTEwKqNaorLc904jye5JKmu8Uuy5jSkzMmQ1zXOr73mKCq
 hthWW89+v63mayDGzyDN0hGm71pSISaUbevSf231VSqoi1yhhtCLaGVsHSNDBqx8f0+RLlmpAv7
 0xpNjzsilH9ICwE7uO/oQC7ncfklykfpEn6+pwlhB9veIC+N/6xEYbZUXWBpBUkdTCyatxzQjvR
 XFo1klZRczuJP
X-Google-Smtp-Source: AGHT+IHr5Os/OJfuB0/SYmL9Ar4NqPD3n58lxoBB6n8DkeLVLPmwUcs40iImm/5qjJpaeAaYWWDxLA==
X-Received: by 2002:a05:6808:164a:b0:401:e98b:ee41 with SMTP id
 5614622812f47-401fd755733mr149179b6e.21.1745604314603; 
 Fri, 25 Apr 2025 11:05:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401ec8e36c3sm857283b6e.26.2025.04.25.11.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 11:05:13 -0700 (PDT)
Date: Fri, 25 Apr 2025 12:05:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, khasim@ti.com, vigneshr@ti.com, afd@ti.com,
 m-chawdhry@ti.com, n-francis@ti.com, b-liu@ti.com
Subject: Re: [PATCH v5 9/9] doc: ti: am62: add falcon mode documentation
Message-ID: <20250425180511.GW5495@bill-the-cat>
References: <20250425145644.2228186-1-anshuld@ti.com>
 <20250425145644.2228186-10-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ycEwsmwgFrMafNVg"
Content-Disposition: inline
In-Reply-To: <20250425145644.2228186-10-anshuld@ti.com>
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


--ycEwsmwgFrMafNVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 08:26:40PM +0530, Anshul Dalal wrote:
> This patch adds user documentation for falcon boot for am62 platforms.
> The main section is added to am62x_sk.rst and other documents just
> include the section. Steps to build falcon support, usage and the
> modified R5 memory map have been documented.
>=20
> Two svg images have also been added for reference, one for the modified
> tispl_falcon.bin and other for the falcon specific fitImage format.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  doc/board/ti/am62ax_sk.rst                    |   7 +
>  doc/board/ti/am62px_sk.rst                    |   7 +
>  doc/board/ti/am62x_sk.rst                     | 248 ++++++++++++++++++
>  doc/board/ti/img/fitImage_falcon.svg          | Bin 0 -> 5511 bytes
>  .../ti/img/tifsstub_dm_tispl_falcon.bin.svg   | Bin 0 -> 9466 bytes

I suspect these SVGs suffer from the same feedback that was given to
some of Neha's recently, which is that instead of being good line SVGs
they're embedding other graphical blobs. Please check and rework these
so they show up as just good xml files on the inside and not binary,
thanks.

--=20
Tom

--ycEwsmwgFrMafNVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgLztAACgkQFHw5/5Y0
tyzROAv9HwNsnKulhErpJP8uM2MBy2QTP3yc3ajChvFEI3EM2kEBm/RZiMb7V87j
J7SDKAV18TEF3CnOm365E9QGemrOZUD8QKeLq579Ix767+3cAg6nDuJ3mFgxK86E
8WldeTzB9yL38Lj0l29JP3lHRD4l6LfwhxpJD1l54JfcAxmNcltWAHKQXI4UGZzc
puEWRSmezJ4KFrMWjNyVClH4nUkJtVatGX5lgTWFNhv0ZxrDLr4qYB6KHDJ7rl9Y
S3DwKx3LLhByLszewKKDUyLCNeJYTW+oMiUOy7JmH8opDuE6uZSurZjDdJQmmdmb
vB72ioluxE/p8ULKWANlTo4px+5ISqH16pOO5ntSC50rMw2Kv2CGaIEqSCq3eRHx
3HRPf3VqhYdJ6rWDs6LBgC2Y+tkFsVJsnFO+ryW9vP3y8MvJJ29qV9siMguALL4C
pdoS1pNrwfScRQGAeZx9VVy6J3/usWu+Rb/lNHGkOe0+IsfIldv76sW7x97Iyvyq
d6a4H0uv
=RBJb
-----END PGP SIGNATURE-----

--ycEwsmwgFrMafNVg--
