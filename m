Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC480FCE08D
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 14:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490BC83EDF;
	Thu, 26 Feb 2026 15:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QA1SL5sV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A19B83E85; Thu, 26 Feb 2026 15:23:54 +0100 (CET)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC8083E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d4be7c4ebeso619987a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772115829; x=1772720629; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aIGb2NgcQcpWTRKd/6BmFAIfJ7PenRSBhdrEqGhrl6M=;
 b=QA1SL5sVU/oojqQ/9q0W3MD6atcDRT2xg1+VFiXAdYVjfI00S7yaohc4m8p6KKleJT
 w5+pAAV2yvr1Rs2fz0bsC3eSI3iYhndI5CIsZbLilkBw0DItu1jj45xNSawk1OGmGmja
 vHIXzBrbKRuX9XhzzVfSLz3l1Fr9kTlKScjW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772115829; x=1772720629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIGb2NgcQcpWTRKd/6BmFAIfJ7PenRSBhdrEqGhrl6M=;
 b=DrYJmM9CbgeTuby4zRccUzfX8AYMb0C6N7IrW8jgBIp0avwGRiRX2glgzxVb3sBNWU
 Bu/EtTvEQwlb83oJSYNOM4G/zZAApLMch2S7QLFx8Rj2aT5/Z4nftdaRnPkdPghryCTK
 9q9vWrXdUMpZYzzJ8a+WvWKJxeIp1JvsSFTm/21g9JVcbE7+ihdy7dwox8H1J1N5NYA2
 2/8CAUGzfyNLbq1SYnTm0Fd8evJ0dO98uztv+3cjmJaxO6uCzA/q3ACj0xYJA75swQNj
 GIA/Kgqo6VPrshsJgYpZfrNALavaaLNCdjmDj4EA1F8EmZz3WrGrJXLk2qQUlmQUCG6X
 unlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9DBAairpe9CEzbt6YV49ryvIVgpcD8Sn0GFghj13gaLikgTFFiUl44DaF+BCqv543DrrO3Ws=@lists.denx.de
X-Gm-Message-State: AOJu0YwgW4ySzguxYB/GGKYRb9CcZYN8aud7ww07rsXNTxqLYu6Vq8rG
 Ryrfrlzd8405RMG9QecD5bx1PAz5ke3J3sRDuKXOHj0zIa4T0bEupp+SFAvNP/Jn1IQ=
X-Gm-Gg: ATEYQzzRLZsAXxBo0nh8jh5w69rRE/mMGyRu2GXKwIX4s8eFAO5gmHTZ5y/vv68wZCJ
 ldhuaPLgxROPAaQfSG8Yy5V9U329z+DUNF6Jg7Ud072pkt18HIt9ev6njLtznMGwlqUWRWBKBtM
 6fVnnYEcaeWbBQoMmfMsIvR8EDdls6+C8wyEaf1ORvKVKQzPP255bWofw5usAZZi6MTUxYeFCKk
 Hu1jh9MK6BNKj55C76jB8jOZNPUNsfrH56Ih98xUYYZ2tpVdArrCN1bajvg5dabisyyHC74MJoD
 8blqX1hRn/p+FPFxGo/yTEANykhN/Hl/yXaIhGxZ+IUa9tDBr6Pt5Tjx030EyCQjQ0RCQvYfYgT
 nhFQs1Bx8IDqvEamsa9NRPHdBknErCIQz/PYskDxV9xWJWvKahjkPMzCb2Vd9wGhlPWa8rs4i+a
 yuUKd9qzDkT87hZEGgRgxRWdEcNXBjRGkH8EEJu9aMZqWpxdGSteNw/VH5G4MbYhm/JY695HQIM
 HGqkrilFyswNv0OGyDr5bpA6L31XP5/j/QIe1aVCixod7WYeNc=
X-Received: by 2002:a05:6870:f61b:b0:409:95c6:f2dd with SMTP id
 586e51a60fabf-4157ac7facfmr10757105fac.22.1772115828683; 
 Thu, 26 Feb 2026 06:23:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160d2cc08csm1883103fac.19.2026.02.26.06.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 06:23:48 -0800 (PST)
Date: Thu, 26 Feb 2026 08:23:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Stefan Eichenberger <eichest@gmail.com>,
 stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20260226142345.GB1593142@bill-the-cat>
References: <20250314100734.23777-1-eichest@gmail.com>
 <20260226070502.GA6701@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D2XuMYMjZ86yTBtO"
Content-Disposition: inline
In-Reply-To: <20260226070502.GA6701@francesco-nb>
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


--D2XuMYMjZ86yTBtO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 08:05:02AM +0100, Francesco Dolcini wrote:
> Hello Tom,
>=20
> On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >=20
> > The get_ram_size() function fails to restore the original RAM data when
> > the data cache is enabled. This issue was observed on an AM625 R5 SPL
> > with 512MB of RAM and is a regression that became visible with
> > commit bc07851897bd ("board: ti: Pull redundant DDR functions to a comm=
on
> > location and Fixup DDR size when ECC is enabled").
> >=20
> > Observed boot failure messages:
> >   Warning: Did not detect image signing certificate. Skipping authentic=
ation to prevent boot failure. This will fail on Security Enforcing(HS-SE) =
devices
> >   Authentication passed
> >   Starting ATF on ARM64 core...
> >=20
> > The system then hangs. This indicates that without a data cache flush,
> > data in the cache is not coherent with RAM, preventing the system from
> > booting. This was verified by printing the content of this address when
> > the issue occurs.
> >=20
> > Add a data cache flush after each restore operation to resolve this
> > issue.
> >=20
> > Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a comm=
on location and Fixup DDR size when ECC is enabled")
> > Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache i=
s enabled")
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>=20
> Tom, can we merge this?
> This is the last bit to solve the regression reported here,
> https://lore.kernel.org/all/20260224152405.GD340942@francesco-nb/

I wasn't happy with this at the time, and Stefan's last email in the
thread left me with the impression more investigation was needed and
likely something else was the root cause.

--=20
Tom

--D2XuMYMjZ86yTBtO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaBXbgAKCRAr4qD1Cr/k
CjNOAP9qY547uO3sZmL32pYjRt8slc2tdO+Gt0yte+wCwvPrGgEAsPvMZz1QVD8A
tT7BA/+AsQcaUaRk1ckh/9BGK4UDQAw=
=mIrM
-----END PGP SIGNATURE-----

--D2XuMYMjZ86yTBtO--
