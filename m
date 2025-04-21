Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CA9C369C2
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 13:24:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B721181F69;
	Mon, 21 Apr 2025 15:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pWKaf7e5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1638144A; Mon, 21 Apr 2025 15:24:33 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA54381E25
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 15:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6060167af73so1558473eaf.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745241870; x=1745846670; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aE8gFPCHD1g8BUx6hwTR+xWw44NBuN+QTq4hfCEgYVA=;
 b=pWKaf7e5FXgLtu6R7LaTEbV/lzZUiIhJsl55j5MJcQDNDiqJoN11Cq9vyn9zbfUQ8+
 iJvKTBsWFi9lQ4oHLbZuAq776P2xXfioYY6WWPTHALrTDrB1ouazNWr870SG8J7AZjIH
 /HUyJ1802vsK03j7dSwO/AATOW5M7/BJjgyjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745241870; x=1745846670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aE8gFPCHD1g8BUx6hwTR+xWw44NBuN+QTq4hfCEgYVA=;
 b=aYZqSzEL7k2VEekTSmi10fv8zyRqRnhrN1EWQPqsU26ZAvRA4u2Pb3gcnsXYy0zODh
 kp82s5QyzEtuRxTI4XKo2WW9A0Qdd48nDGDIr2SLK9N0bBk8Gp57RDnBRY0q3jv2fvlr
 bSgKvzAWRkd/XBz1k0ndUxzmNkTYeS0eL25nxlr9HbxrAFi5R0yLM/I8a4PHgHn4jm4p
 149Ua5cyXGIb2sBU15nMXKTbgN/rTzmSua/RVkFCTPbz/rvWcF+qrgQEiw6VaaLVTS1E
 KjjReTBk5MdCgV8ZVt+Pggnqao8com4nC22XJbCj4OQdK3ai1b4lgP5OEj2xUy+/P8D0
 UpxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSkzcPBPs8jpzn6lgt0pW582du/heUj4G0aCG8cLKaTuhlfyrGr0w7miWlbqtTVbmOr3kujDM=@lists.denx.de
X-Gm-Message-State: AOJu0YxQnnXpCtCYsnEg2wH2HtW/2ndFiZW928GPI5Oza6u3iIPZ2kJN
 xOm545/wifji4q5rCNhVx8YhgP9GDfE06wc2dG9fgiqyYosLwnjzK6FE364o79lJEATmTYvDXNh
 c
X-Gm-Gg: ASbGncv4AeUPJSSpie6lqskViUbmXUHDVtkQW43w8jWvJCkmdQfHaG/qRfrtEgsQlXm
 wlbvUMamhf7mBWmZbnKAoWcszsYig/4LlfRIILEIyyr1TsdxnxqFFw87lcxvyOalcvoOEg3f5Sz
 4k/VCKFmRM7ZJiIJiVhaL1SwWR6pSlSWe5f/EyvUSo5W7ZLDEp7ISOGCSm7qNnFIwjwMGESQnJS
 6cRLvWYvRUOc+/glBmQWsMP4yJdciVYHH03MrvlS2ZnU21YPCLz5H1zSLtr82jfuCIBWEMcWPvW
 9QSS/tdCvl8COJJWbsRYgpNM7iy46tSqoMt4TbybGp0pcl9kV/ib4ns22jWkKa2XxnoMoL5VMqs
 PRQ==
X-Google-Smtp-Source: AGHT+IEnsaoUtVt87Hi9IXIBRrUX34Jr+axh3YRoMSAst62jG31XX2cFajgdBmiFPOjJGHl3D/5L3w==
X-Received: by 2002:a05:6820:308b:b0:604:18c9:79e4 with SMTP id
 006d021491bc7-6060054a2fdmr7023172eaf.3.1745241870296; 
 Mon, 21 Apr 2025 06:24:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff5ec0c7sm1571305eaf.10.2025.04.21.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 06:24:29 -0700 (PDT)
Date: Mon, 21 Apr 2025 07:24:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] configs: add qemu_arm64_acpi_defconfig
Message-ID: <20250421132427.GU5495@bill-the-cat>
References: <20250420085929.36226-1-heinrich.schuchardt@canonical.com>
 <20250420085929.36226-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y9fK9g7yz+Y7VJKl"
Content-Disposition: inline
In-Reply-To: <20250420085929.36226-2-heinrich.schuchardt@canonical.com>
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


--y9fK9g7yz+Y7VJKl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 10:59:26AM +0200, Heinrich Schuchardt wrote:

> Add a qemu_arm64 variant that supports ACPI.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--y9fK9g7yz+Y7VJKl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgGRwsACgkQFHw5/5Y0
tyxj5QwAk7fRF4yGQcFaQGolc+BwaP5k45/Mu7M12VGrrTjS+wY0ILjxptxtJXx8
pucOXL5qGUZvoiOCiRYDxNzRMFTrNx6Mw12BpkyuPQyQ6B8M2YprWueFq0yLmsg3
ZAsNszZ7uXmBdPerPCVEXlj4pfSPclwIDMci4WT06WwSwmTjsSIxBCqFGt8pz5mA
6rIL9syooe4sqn7i1CLL7aFaRiArOWC2QOJ9pPxAQrQ/3+qEOvYjpWuRcybhys47
l4Czqkv2ky+c5BuRHjK3i6Ic8Weu2w27+qV3oQ2LMX19DLzoPKpYf3fGHCiNFYgD
czXTDtGMijmx36Wi/OdrKwAJUHXmh11Agz/I3+jy9HVXAQCcy1dgcydbqDI/gfms
dKTNGbWwTHdTMzhi7a45KzRyPR+NoxyMTTW7HcpFIXJa5xS7XEm5f8cn0ISJtz7S
2erv3CX7oYUCEk3KYp85OVhe2XB9pr/6W1rx90o19Q4OJMiXRTADlRyl7u4jED/x
718sGD1l
=kl/2
-----END PGP SIGNATURE-----

--y9fK9g7yz+Y7VJKl--
