Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DD4C982DA
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 15:05:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73946812ED;
	Fri, 18 Sep 2026 15:05:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3lniiXomImdK; Fri, 18 Sep 2026 15:05:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BFC8C812EF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789743933;
	b=jQ/4B6PFIT01HjwkXtwww4/e17sti20It+7/h9m0mdXK2JW37nf18zKMJXfa6HEwnL8W
	 MXtRQ1Ge+RtNZcQ8c99uhUZOvAcJst2z6H685OMwsxiQiT3aYca5vMMopISTe+TZXyuAd
	 vkULu1ID2zbaCwSnN/CPHuU187EZ7SYxNB8lNfH9//Mxnpyt41XlpDN6g+XmHYt9b6Yul
	 u+wSAoL5xWHYfjVy/enoh4mwgcfmBejaa1tbYxAxwaW9CRebB7w4AL/YH9DF+NG9MeMzw
	 khTu1wX0q7eJu/6bryTcYDEKnEc7XEX1kMScDQgVIesom6dvRU68AQkBA+E+UmrRyaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789743933;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lPJsjjMPTmkY6HGX8KJw2PZHKfmXkU8rK+7zHZC4+k0=;
	b=rPcjKtuuvjjO6rDOd7b9sQ8BBsQPWhDiC1IYX6XBJOOyQwwYxGfyzC+9tEDTLpi/p36I
	 6VINahpXTC/iA/7PxfZj9WsH57zdlmMN8YvM76ewzz1d+Jm8+7TqOG0pWdGiPapBHVOG5
	 58k0FQIpaakCl1PBhjBphaVyxmx3XWxa7JVeplw2EQCdkM+vCenIxfEJ+j71J83VIGPRP
	 47BJnP9i5Bnxb2dLSHSRS4nHH1UpytsOF7uiyKAN3QteQDlt3In90FQjq69IpawHpxwcD
	 pPODL0PDgkqJJaTzLrRRUnluVki0XpYdDv0m2DdA4qvIcv0Wkx7TO2p0AcywyNmbEgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789743933;
	bh=lPJsjjMPTmkY6HGX8KJw2PZHKfmXkU8rK+7zHZC4+k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tjRStyj/K5kGLin8MTkp/+nezqrcwsq2ijn34CH3NOHaCsvE49wsakvS3+6YkWk0u
	 4NTf0EapEOhVs/RCj2z/AVE3X+E2GDHq50pdn0IaxTM9T35gwpcjP3mAl34X/ERfR8
	 8V5p1ZoWT9Ekr313O0iQFErFsHbOoXIcR6LSYAEYz6D7jYusQ9GN08WtJpqOesS2k/
	 WH5tb5f+A5FCw+PF3a6gi+YU7uisKLkScRpT7HmYjZXwtP/yXXq360sLYoFkbpZ05E
	 9Dz9EIiND6bkLP3Wo3mC076dXp9kjoevRk+UMlDHL8v5GE5Npduz1AEtaAKg2C6/n0
	 i90LnJt56zQdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BFC8C812EF;
	Fri, 18 Sep 2026 15:05:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F25513D
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 288DE60D77
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:05:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNk6RtvHczsL for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 15:05:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6DB3B60D70
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789743931;
 b=LeTuXArFFjCK3R0JoA8Wl0InGzaZx6Yc3iT/Vz6N5Q4JjmPi686JlTvWK9xR45Sthen3
 49XCbtBBtfL65ijNWck3bP0NFmQCMRk52r8eJqYsnpHVvhlD/BN3ruRiT0qgrGqp4tAj9
 T2DkBq2oU1f1pJnNTu02nyi65LH+F6R7TRQcqSUQJW0dhkak0KHET4ehGjF//Usprj7Ml
 MOKY8dXvdFNHrICa6LjWvkjreN+Kmv94rgmjPf5XdmhITsUazAXsDrFv0Z7MbYHUZ3P1C
 SIUIY6AqrTn2SNp+aEVQXiBCJATGHrJ+lDvhIPcc66RBFHdWHr/83QCUPNHahHuzaRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789743931;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=lPJsjjMPTmkY6HGX8KJw2PZHKfmXkU8rK+7zHZC4+k0=;
 b=SruJ1eSGGISDD50EVtzUzN3YqWdNs+jaQZezWP3YX41eVGowwlOEEiVTs9mhadSmQtaW
 nsDcV+0jOsgTbRoQMSGEVVjRvM6Co7iLAxE9BkBSXW1ZnwYNshSkTRLhWf7xpw1p1Fxwn
 KOchAeoIsT2QfGWxVeMv0ZqH5UEGXenpAJJe4aasQ42j+hM/v2gxyQyUwp0OyYTh8LnWk
 cey7XvDwYytayj9OZd+JNBnr6abD2tHrwUzq/J2cyRauBIRSo6iOKvDp6/cvtxF+gCX1q
 kZwy0Yy/waLlHu9e+8/09NttirC7QOp+uWAQUbmuxkJmdF6MNaWUYhVrdJhLKzTBuNA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=exwiaNaQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::d;
 helo=mail-oi2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=exwiaNaQ
Received: from mail-oi2-x0d.google.com (mail-oi2-x0d.google.com
 [IPv6:2607:f8b0:4864:32::d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DB3B60D70
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 15:05:31 +0000 (UTC)
Received: by mail-oi2-x0d.google.com with SMTP id
 46e09a7af769-805cc8b4231so453344a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789743930; x=1790348730;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lPJsjjMPTmkY6HGX8KJw2PZHKfmXkU8rK+7zHZC4+k0=;
 b=exwiaNaQEYA8MRn3fE8A6HP+LnPmRbmV+fHdexoHyW6cLHTssbZ2YF9DBrrvXBXTFu
 /ISR6fGC1WclyIeqfoUYp4nBNlY8TbURnWFjjSXBw0bUMEJN53C6PXD1BMYpYu1vEuW6
 K/0aGpL4CiZcEM1/3gHyXFTqOGV7F6yQvY2Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789743930; x=1790348730;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lPJsjjMPTmkY6HGX8KJw2PZHKfmXkU8rK+7zHZC4+k0=;
 b=ZemoDBybAMs2erCAyvp+oPa1chWkbAqSGQg003AsYD3ZjPXDiZkV7gaEgoIkIKff46
 enlD9CCoxYdaKbwnHT05nw4w3EuzsBIdyVjGO7gdrCqHeYRqnKbbL669EwDb+SAdC7+U
 SmLbGEAaFsyp+++4Jx5QowUXlbUGQsfKhsnCjmbURar03oEh+mSXqJUMagEb8+ATt9NF
 /FldsYTwzJaLaQGLdXyC/fgUP6qM/nPTZDzJVBm7wFwhISohGeW1VNLQBTTJUJkaSQ3X
 Rc07XCWEjQR/9JIQH9i9QjV7MGJbP94uMcelOgD43kQUakhyKuNXvygHBUZH1C20BPEq
 aeWA==
X-Gm-Message-State: AFuF++kDGr5q27ULn5w+uNWptP0mCqk8Hu6VxB+EtYG7vrI9PElFU7CI
 IXyhp87EJHPzj+yAUv1G6SEGlCoKv9oFT+MCXdAXCO+jMNj+U04540ahRiTBGhabcHw=
X-Gm-Gg: AYBFou1qWB+12ZF46j0RRbHJ2/T4d3Ke3861frowUoztkEok/Eqcr9t4/YuXHrOLEXC
 fLGEXUljmow7r4o2GsriRGO5JOPkkNEF6r4NxrvEowaJ9FhQWhorQWirKHOFElGsNPfOe11vk/P
 DHkkQV4/6m0WeQNQPKR+AGZQGb+pARVwdVf6REFkyPbMkPm5Cyh3k4/0hy3spJMkVu+5lWadSii
 WWNhJ4q45Gad74wMexqyYVOsSSGhOlAfGynlEVvdSD8mo1mFGhGSDacQzK4sodRgfeqKWsEqJ+E
 QRIX+K1qxg0us2TefnhzjFAAFx81N7WB0XgpXawvWYt9UBE3fjCCNVG4WNX1iaF5zDnSCeX8Er8
 c0zbeMMzS7bWQsDQYwuD4x+ABrcgGZP1UITS31CAyxUxdb7LGgQdj1sMFWqKBo/N8dkdqxVF19x
 w3pAQYoqREJLG9fSod8N+OIyROQBY/fmQihY56UuarGkKzBE9BF6GS4CWWatkLJXyuiKg2N4wGv
 6hiS+qB8hCijv5yAR0ORsvAj15xymkZw+FyKL5chx+m/E8/wrRyLGOO1tqHczEfCsXqhfiqwjEA
 q0FJZke7SY1tu9ex+r3r
X-Received: by 2002:a05:6830:380f:b0:7ee:41ca:e7b0 with SMTP id
 46e09a7af769-80de21c378emr3209597a34.14.1789743930062; 
 Fri, 18 Sep 2026 08:05:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e5235e3a3sm1552648a34.24.2026.09.18.08.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:05:29 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:05:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>,
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>,
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>
Subject: Re: [PATCH v2 05/11] spl: fit: Decompress any supported algorithm
Message-ID: <20260918150526.GR858934@bill-the-cat>
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n4pZ56OeuElVAjOY"
Content-Disposition: inline
In-Reply-To: <20260918-spl-fit-compression-v2-5-28e946f57357@flipper.net>
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


--n4pZ56OeuElVAjOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 02:52:32PM +0400, Alexey Charkov wrote:

> load_simple_fit() open-codes gzip and lzma in two places, so a FIT built
> with any of the other five algorithms image_decomp() implements is
> silently copied to its load address without decompression and jumped into,
> causing a hang with nothing on the console to aid debugging.
>=20
> Call image_decomp() instead, which can handle all compression algorigthms
> enabled in the config, and will abort on an unknown one instead of trying
> to silently jump into it.
>=20
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--n4pZ56OeuElVAjOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaq1TNgAKCRAr4qD1Cr/k
Cuj4AQCZCO0HjbGPkYIOQ6cYcUid1rPQ2mXOIFuyn7FufaZkhwD/dUiLf6x/E9ss
D+YmJNr2wKzS7+on9V4oasaM2OVYXgM=
=3Nuf
-----END PGP SIGNATURE-----

--n4pZ56OeuElVAjOY--
