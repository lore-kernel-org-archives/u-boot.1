Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C8D7C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 21:06:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4A8260831;
	Fri, 14 Aug 2026 21:06:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N7XJpdCeLkoo; Fri, 14 Aug 2026 21:06:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8886E60685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786741612;
	bh=A2UQVa8jgOWeC+42DvSzCQMzB89M/3dMVTU764us9h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bCIWHKcy0lp1dPHCAZkUcWzA0uLfWFnHYthszF1oe14BymK2lrmzidP8/3Lducm98
	 eizH3Ur0qF8NMGdpPxROhBl597Ksk2QoyVVQU7QvjEH8FsWUJNI+YMV1Oi+cdDgaGi
	 y+o766be9hWfA6b7GgSHPDFxKUfvZtIYBYk2/61AZ8B1QM4rSMa0mjqSxfzbxthNkl
	 IC0zCzFlyQthczbQ1/zYQLd9svwrUM7wqh97hq9mVd8XN2BvUBAuryJfZBuqIHJuAd
	 MY37sPlSE8G0xcNUTXVp38YtS9mkHV1YzcWAoniNRQ0J8ah6v9IRnEeB3GFbj/5HuD
	 DW0E+B88ymuhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8886E60685;
	Fri, 14 Aug 2026 21:06:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 489C523F
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 321A680F69
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:06:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfEHf_p0884z for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 21:06:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 66AF180F62
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66AF180F62
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=VIJylZb+
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66AF180F62
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 21:06:50 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4960fb63c75so832983b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786741609; x=1787346409;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A2UQVa8jgOWeC+42DvSzCQMzB89M/3dMVTU764us9h0=;
 b=VIJylZb+IOWYz2zNURDaebbq+nl3BuU5RIzdZ/J8KOmTaBl85B7SWaH3QhMoMyvX1Q
 CbfmvJmF8dUgGWKMHsSKYHV1r8lu/Yacx9hbsRIJiwualtx+cgoHpbyA3FaKJ/Kb1mc0
 KF0PFGSCsjCIiaZVY9qkVyASXPoPXLuz3hH8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786741609; x=1787346409;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A2UQVa8jgOWeC+42DvSzCQMzB89M/3dMVTU764us9h0=;
 b=b+wqKaP/EOOMS51aj8vjWvKb6/Rje72cujgk0ExfrE1YuRIYknTJN4Iy5LUJKggyWT
 fjjgAbECbaaeUg0d9fntIbW7Zi1u9v0rM+U5TnW7zocZnE2Ye3WbwHzdx60r4YLKYGiN
 yvbfLuu4YOuWv9+Z0E4danMqLNonwjYScdRUHizxTR0GaahVZ0jfsUmE5cjOBtMZpHCT
 lOgXKA6mv0fyzwdWzin0RZFYoGqj+oXn7xTQW+SPqK5uVUX5iXzgz3I+0OdAE18bnbqq
 +HaK5p0qAP/yf04jnnphmuqLu4DpCClJQsT9icZzGAd5ig+cqdKC6qAAksFpx56pY1nx
 2l/A==
X-Gm-Message-State: AOJu0Yzx9kMb3Mg+qdCflvHO5BEVYt+8FD+6y1hkA1CEtYcWZsmjSMaz
 eqddAnhLgVeS5Yaf7aDgtpFzbahD3dgUpoyNP/brjfEUoL/WH2k2b3JMdftFCYaCTi0=
X-Gm-Gg: AR+sD13dhcrWkniqh+qVfYL/7Sn3oK0i6MPw17T6vjXHZ62yUBX46++InFoYd2/oB0n
 FGNAa/Nev5jMWnly+ITq6df3+kumEE7HjBDLJf/69R9YeK4ZdVAgfpB+NmkMUnKRo15kGZgEJS+
 bMcxDoJzB/sqsAagYkEKSPQkwwfNExk2crsZBOIETOJ26XKwAo+2oqopW712HXgrDGWHTw55MD+
 uXpPuG59TSayslg6YGXxJvLqsTlJq77A5hb4ILzTtswRJlhB19Gj7Dy774Ol4SBYSq5qvg2k3Ok
 D958vZCbG39nJo+YukYwmzew8n05eAVkxGwmeR8E6PtZQXXvobnsjJohmME0ZYIy7kS/Ve5y+oF
 uOqtmrbIzGsYPDLNxXy1ie/WT1+TSDPrXN/c0EwmctorIQoM8oLfyQ1FjXcj+WRXxXZr7xIET+s
 oL71ulqGqzf3lK8+yRrFvs/K44i5ElJjeKTzrZf5XV12NKspZXUHZzW0pErSrIzRAYcIJteAo1q
 n1gdthFqAXxU2Yy1erg5UHVhLG9lGj41J/bLuBF+cXLCqoyHAwTkDSo2G/gmMErsPQHqTSiEcHg
 XcfSd7WsCws/gYs7ag+D
X-Received: by 2002:a05:6808:181c:b0:495:eb8d:bf7 with SMTP id
 5614622812f47-4b241ccc8a4mr6755011b6e.12.1786741609114; 
 Fri, 14 Aug 2026 14:06:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b24dbc632bsm1761378b6e.18.2026.08.14.14.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 14:06:48 -0700 (PDT)
Date: Fri, 14 Aug 2026 15:06:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH] lib: zstd: update to latest Linux zstd 1.5.7
Message-ID: <20260814210646.GL3297518@bill-the-cat>
References: <69502f5a39ab3f07b7872cc6dcbf7e86f7e7d42f.1786670589.git.Munzzyy1@proton.me>
 <dd01c4b5-ed45-4fc7-8670-026aa38ee284@proton.me>
 <20260814185328.GK3297518@bill-the-cat>
 <259e9abc-603d-4a07-bd6f-41b357abef49@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J9bSj780VHt4bo+4"
Content-Disposition: inline
In-Reply-To: <259e9abc-603d-4a07-bd6f-41b357abef49@proton.me>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


--J9bSj780VHt4bo+4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 07:43:18PM +0000, Cole Munz wrote:
> Thanks for the qconfig pointer. It caught a mistake in what I sent.
>=20
> The count is 47, not 41. My scan followed #include of .config fragments b=
ut
> not defconfigs that include another defconfig. That missed am6254atl_evm_=
a53,
> am62px_evm_a53_ethboot, am62x_evm_a53_ethboot, am62x_lpsk_a53 and
> sandbox64_lwip.
>=20
> qconfig -f ZSTD reports 43 here. The other four are sandbox_nocmdline,
> th1520_lpi4a, turris_1x_nor and turris_1x_sdcard. They are missing from my
> qconfig.db because 234 boards failed to configure without RISC-V and Powe=
rPC
> toolchains. Treat 47 as a floor until that database is built with a full
> toolchain set.
>=20
> Size numbers are unaffected. Those five are AM62x and sandbox variants. B=
oth
> families are already in the table.

The important thing isn't just the numbers, but what buildman gives (and
bloat-o-meter for example didn't last I knew) was really good answers to
where the growth is. Which makes it easier to sometimes ask why, and
then work to reduce it.

--=20
Tom

--J9bSj780VHt4bo+4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCan+DYgAKCRAr4qD1Cr/k
CkgaAP4ndbv0vHs3IN+pyqaCNIlCxZ43Kt/+pSinWtWbj35eWgD+IL1TyoQmd6d4
AFqiW7oyrI5DLeJ0k2oMiBD3L5PVmg0=
=Cmxt
-----END PGP SIGNATURE-----

--J9bSj780VHt4bo+4--
