Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D65CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 18:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9FAB833E9;
	Mon, 29 Sep 2025 20:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O8zCM0gY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936718344E; Mon, 29 Sep 2025 20:11:39 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2586982A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 20:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-43f64a5014aso404953b6e.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759169496; x=1759774296; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XS2PCu7eNxAoaoGgpY76TXacN3CnyEsrCjw507ShIHc=;
 b=O8zCM0gYSljMGFF4Q/y3IK+pByp6bRLiUdn62bBskAevqkaynPRQSA6O39LY6Ruezy
 84V2KHy4rwdrHKHyRKMapzWQjo14ZWp8KLIRRbGL4R3AbAL07QJJwgJ9ci+X+y29XtBs
 5enupTbawAaovNH+0FynDSTAtdnRkNi3bhDx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759169496; x=1759774296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XS2PCu7eNxAoaoGgpY76TXacN3CnyEsrCjw507ShIHc=;
 b=HdDiHPzh3ccq4FJd5PWLf1r7ayVrl52/TBnkYCQupgqbnEVg67+8Xf5eq9TlVSu4iV
 UWIYjssn5J/O6wHDwrS89ajStMMLFDZHe2PeV+kT07h6kXPBqdhuVXBSkibDN3RAgDZX
 kf2+wbBeXmf5VXc8ydDyxUbE8xamY4jktsStJHCMB12OSDWFMJUUeeX6MwmG6uXYleJT
 U22S7JUA6FwQmlLu6/cUz6qTPttiSqx9YEhQJBhsslZ+zXQUa7cSHqP3V5pTEhGSW1Ls
 fMvD4k89kSKt+DJPac3t9sT+bDeVyihXO0yhqtOYa3kyn/C6A8HWbtoMFLJjd0m1r/1m
 AaDg==
X-Gm-Message-State: AOJu0YxZwQk+5EgH35FOorARqIsWWRGTUFRBiDrB0NdkWDSrMpqrdRkR
 I6vg7f95mPugeTy8n51Nv7dAMkWJbrmsNqDiXJnc99m2fprhNl9bc3Gv+PyL5pCAEF2Ye975PPL
 9pRlCcRQ=
X-Gm-Gg: ASbGncspROCr2N4gOs4W8+ZRlPt3wgPsKy+BUNPuaBXqeii5xfHP+kwRQUuKkYjhD0t
 tdTbmXhKJlGHG1a3p3zwjK15i7Jw8LM9JbGe3i3mKcSNVpg7crHXUrd0nvvNhyNXyp/EAGciT2b
 r/AuoiPGVQiaCR6t4cGy/eZVnwaN+yiIXsh/2GRy9lB68c2a0hpWE0xXmW+6gNQswtLhxMFg0sS
 qWcRxch6Yqi5sVoRJ2Skk7L9uaFxmyUtxi2AceB9SR2vBmmsDyexpBWPBOyp8nSXb8QXP+3Avz7
 x3spC1FzuqRNJAeaxHdzRNi0Rda533atGTBMgkW8ZUjABT83OHfyixY8BxCIHNC+4Lxddxd8ILH
 ES78s1+OPeivwI/YqiaD0Xxo/5LZ5aRof8xXoj7+yLFATZ4rHyCQXt8JgkpxCH4qfSQJmm3e9+8
 hXOg==
X-Google-Smtp-Source: AGHT+IE2Chk4v65Px0yFwoYSnHBfafnNjTkUPMa/PGIpj00x3FpOfYBN2PJohwCW2YLLnPZjhyIiqA==
X-Received: by 2002:a05:6808:308e:b0:43f:7287:a5ac with SMTP id
 5614622812f47-43f7287abe0mr3878674b6e.30.1759169495741; 
 Mon, 29 Sep 2025 11:11:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-63b1eec7515sm1367440eaf.2.2025.09.29.11.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 11:11:35 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:11:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, nd <nd@arm.com>
Subject: Re: Transfer List Checksum Correction and Impact on Bloblist
Message-ID: <20250929181133.GM6093@bill-the-cat>
References: <b7c008b2-0a1f-4971-af4e-428faf818d4e@arm.com>
 <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h6Cdx1K/uQv2vcBV"
Content-Disposition: inline
In-Reply-To: <ada31617-374d-4f87-97eb-c91da2c4e9b5@arm.com>
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


--h6Cdx1K/uQv2vcBV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 05:09:53PM +0100, Harrison Mutai wrote:
> Hi all,
>=20
> We recently applied changes to the transfer list library [1] to correct t=
he
> checksum calculation. Previously, we used a simple byte-sum approach.
> However, we later realized this contradicts the Firmware Handoff
> specification, which states:
>=20
> > The checksum is set to a value such that the XOR over every byte in the
> > {tl_base_pa, =E2=80=A6, tl_base_pa + used_size - 1} address range is eq=
ual to 0.
>=20
> This discrepancy creates problems when interoperating with Bloblist.
> Should Bloblist=E2=80=99s checksum calculation be updated to follow the s=
ame
> XOR-based method?
>=20
> [1]
> https://review.trustedfirmware.org/c/shared/transfer-list-library/+/42548

Erm, since this has been out in the wild so to speak, we can't just
change the algorithm without bumping some cardinal. Or are there yet
other implementations that were doing what the spec said?

--=20
Tom

--h6Cdx1K/uQv2vcBV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNrLzAAKCRAr4qD1Cr/k
Cim9AQDWDy+xiN0HT7uHt+HKqeiAra48xrtnrhk2DWO6UXDFGwD/Tif7P+KpYMHm
HixnmFU5Bw3mVG8Zn2VL6qK6oClSHQ4=
=9Nnz
-----END PGP SIGNATURE-----

--h6Cdx1K/uQv2vcBV--
