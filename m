Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646D0C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 14:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E381B8383F;
	Wed,  6 Aug 2025 16:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LFmHifsW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9904783919; Wed,  6 Aug 2025 16:53:22 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05EB283721
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 16:53:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-741b1fe0dc7so5832a34.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 07:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754491998; x=1755096798; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NhMT6AuU/c9hKWcH/tvyj+xz+dXizFazf9URsR5LuBM=;
 b=LFmHifsWJz9MGZ+arcTLQesmS0BjEciU/PoJXkYMOsaAU2jQZbZ/vUyncc+wFzfnQB
 rMX2O0GdXOsDUEZ6UH0o5iNvo6oK/iYcxvLX68toxAm5goo4NB7TYtlDVcGToTvNGC4p
 Vf5ucLZgRgvbGAEqS4d+Lbko4Tzsihfggf88A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754491998; x=1755096798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhMT6AuU/c9hKWcH/tvyj+xz+dXizFazf9URsR5LuBM=;
 b=FXQYhs1OV/VrLcOQHooO2GMXoYSTk2caJwJcbuxXVEMYRK8N5sttEpr8KK/rualhlQ
 NuNGgoppQFC5bIJErsUsUHO+NLHPmWyOskYBvDLJi/NOWqjHoxjj/hUQQz2XmgjrNiDR
 wXnQ/xhmsUXkFpSYzoS1PldcHrKdjgcHIjkk/JlTMuxOvXVPRY9TyfJs/iqqDG+8uIaG
 fqigaOK1QEy04SRolJQMcd7fD+37Det5A2YldF6L0HPCkjTqmmSY/C4Y8tbXG9JSzo/+
 heU19QRN8JTbo3JfoWaf/68KC15VERkTM8onF4AYgANcNOuKbIXm+AvYLltVgiILhW33
 BCVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl3nxEfjZEVJYF50AunevSJuHAQorKWH2lQqL/Yrt0xuRh1jhth5gYDa7ehHWpwVKvMm1wWNs=@lists.denx.de
X-Gm-Message-State: AOJu0YxJgWl/wiLibP1+R0kYMgOB6GBHLwUEnYPP4VLIRdDwbEtjOvrg
 bDZsjmYM4DwK7ADos1ErVo6YY0DNisLou3ECZkav/xFiVGDJd8kWQ+Ku3STd1NAmT30=
X-Gm-Gg: ASbGncs0eHvoE3vD7hGkXHB9caEu3wOCTT4NxiQsFJQCPaMA54dPREQLGSTOF1aHyTg
 JKJQ3QjeiG9lPJ4dL4YppR2QBLBdfwdYyJ9tGMhEiemw2K+CQNj2CPD5CeFAsOUYI9Rc7mO82E4
 R8cgULdIU+pYbARsznKTxTsvrg+NFdwme1htuasMMEShyL1dybUuQuRJwgMeGiusr/hH2Jh4qN5
 jtr1XZUKyO9W+9KyZuz8Lt93SqecQNmnBX4l713vYCp30Ju4P6HonZLARzx5rpe8jp9dvSl9dVJ
 yvpw65XDRx8m0YX+ARsDtmcmN0rMp1IQN4HWsfs61cPmmiBjAR0sFFRZfCGdZv9gu2yoA5ZFVve
 AnRym47gaT6F3dzUmdyzoH1ClATr2tx5EwOfWGufuLcDwutg0hacYmV1Ly0Srgeo/r/U=
X-Google-Smtp-Source: AGHT+IHnk442mnde30eS3XKhRDaD9qQF1LqmcxixMbpNIfoJ83KXm+NN2Wk8t5qte95+kpTLR2aAnw==
X-Received: by 2002:a05:6830:210b:b0:73b:2617:87f1 with SMTP id
 46e09a7af769-7430b46317emr2157527a34.28.1754491998028; 
 Wed, 06 Aug 2025 07:53:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-742fd50d6cdsm846032a34.53.2025.08.06.07.53.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 07:53:17 -0700 (PDT)
Date: Wed, 6 Aug 2025 08:53:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Smatch report for drivers/net/phy/marvell10g.c
Message-ID: <20250806145315.GO124814@bill-the-cat>
References: <623c39a5-2438-42d5-aafe-bb80dfd12b82@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+LqF2wfWrs1ZmZl8"
Content-Disposition: inline
In-Reply-To: <623c39a5-2438-42d5-aafe-bb80dfd12b82@linaro.org>
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


--+LqF2wfWrs1ZmZl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2025 at 05:30:49PM +0100, Andrew Goodbody wrote:

> I have these Smatch reports.
>=20
> drivers/net/phy/marvell10g.c:384 mv3310_select_mactype() warn: was ||
> intended here instead of &&?
> drivers/net/phy/marvell10g.c:387 mv3310_select_mactype() warn: was ||
> intended here instead of &&?
> drivers/net/phy/marvell10g.c:390 mv3310_select_mactype() warn: was ||
> intended here instead of &&?
>=20
> Now there is obviously incorrect code there as it cannot work correctly as
> is, phydev->interface cannot equal two different enums at the same time, =
but
> simply swapping the && for || is not going to work either. Could anyone
> please point me in the direction of a fix?

Adding Marek as r8a779f0_spider and r8a779f4_s4sk are the only two
boards which enable CONFIG_PHY_MARVELL_10G (aside, ./tools/qconfig.py -b
and then ./tools/qconfig.py -f CONFIG_FOO is handy to see what boards
enable a given option and helpful when get_maintainer.pl has nothing
specific).

--=20
Tom

--+LqF2wfWrs1ZmZl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJNsVwAKCRAr4qD1Cr/k
CkWvAQCcHHc6fEmogPPQiAy25FvixoMJhzkuIfQnLr9iaEKxMAD/TGnZVYs3Y3NT
CWFueMiFnjYk+zy5qA9lSFRZqhEInQM=
=GNkH
-----END PGP SIGNATURE-----

--+LqF2wfWrs1ZmZl8--
