Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B0CC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 13:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64670878DE;
	Tue, 26 Dec 2023 14:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fMnfVgFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8AD1878D5; Tue, 26 Dec 2023 14:54:19 +0100 (CET)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEB10878B8
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 14:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4b7480a80ceso466513e0c.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 05:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703598856; x=1704203656; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Mb6jWKGLCkp2DPwuvf49zOzhN1MJRMp00Kh4+fo6vh8=;
 b=fMnfVgFURhiXIFlNVPZJ42Qs0G1CbeNihfxtnGioU5jlC83bOc03iw88RY3Wob9PKM
 ScbdbSopn46Kfu0pGZwLxot2zKSb20ffYer5yE8Ol48KN8On5hhNcL9OBdhtaHxjdvqZ
 rSPi6G6VUcEnPSmMbhRUnrVvmV+j0kVOUYnpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703598856; x=1704203656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mb6jWKGLCkp2DPwuvf49zOzhN1MJRMp00Kh4+fo6vh8=;
 b=RYO+JKQywWgdL3d6SLNL7ucVaEJhtloqpzXFxAj+6tfKIQFuQHkNXNoDPK0oUjsd5i
 w+0fbciEuMoKzmz5f8ajrINlv4UCv2HaaTlkZ7sWGN6/9L1oHwnBNf1hksq1DMW/ja58
 CCFtQd3QKHxFjWVNRdwyXdbfjiXbf11pf8uAc7lFYQZ06W3OleamEykKgEW+yVsVe55G
 kvFkT3/pcNO1n7DMiEwC4BN3/hL2OqF2yA7EZBWBhK7mPYruzz1iqKnsPMmmqFvmYCI0
 D2yuLSQZdsr5wPFcfzS8RHhxcwGxF7FRwNRXQbBv79B0zW+5hvmEP/+Xsnn4UvIVgHin
 JysQ==
X-Gm-Message-State: AOJu0YxmnUHdQopxPt9cAPY1JXQl/Zem2zjJanhGuVjOw/QQyhX7L6wD
 UyHov0S7aJNstvVWd0ca5unDzowaMzgqUXoCzNd5Bk34Urw=
X-Google-Smtp-Source: AGHT+IE2RoF49UcSc9wNYCP0vr6dsYF73L0kpGtDMKIGD/MUjRgbIRKTvL9JzTeb0AeHpt8JBRb22w==
X-Received: by 2002:a81:53c2:0:b0:5e5:3969:130a with SMTP id
 h185-20020a8153c2000000b005e53969130amr5935437ywb.4.1703592433163; 
 Tue, 26 Dec 2023 04:07:13 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 m187-20020a8171c4000000b005d781a2e123sm5378675ywc.109.2023.12.26.04.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 04:07:12 -0800 (PST)
Date: Tue, 26 Dec 2023 07:07:10 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231226120710.GH2652760@bill-the-cat>
References: <20231226094625.221671-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="11tZBo3IeAoFNUfs"
Content-Disposition: inline
In-Reply-To: <20231226094625.221671-1-sjg@chromium.org>
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


--11tZBo3IeAoFNUfs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:

> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>=20
> Tests for this will be added as part of the Universal Payload work.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> The discussion on this was not resolved and is now important due to the
> bloblist series from Raymond. So I am sending it again since I believe
> this is a better starting point than building on OF_BOARD

I really don't like adding another option for "DT is given to us". Why
isn't adding another enum to fdt_source_t sufficient, and if we have
bloblist enabled, that will look for and use if found? Maybe some other
code needs to be restructured and cleaned up too?

--=20
Tom

--11tZBo3IeAoFNUfs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWKwesACgkQFHw5/5Y0
tyzyYwv/dZacUeMyZvDZ7Ty/vmbfp5AiblluVqh72t82wKakv56DeHlKRbBidBsN
4Edz0ix5BJRSed+rjzdyiaRf+VqEZZqF6amsbW1e5r+6jopisPg0v/pfrNBZph7p
/eeCVfZ6/Lf3guZWcGsiRWAwHaoDZW8Cf8m45uif7Z5Lx1pjB/BafSO2NN0WQH+e
HVcdLfk2VXT/jQTYnuXchS233lZiXjFojsrlcrt8lM1c6T3sIZTKaoG0oFugxiax
O4fah9S+NqfR4l4nxLrnsLyQX8lrpFhv1Ol4DkeWIFQjr68dvUbdMppkrQ09sCyO
q23UUeG7N4PJlwfTwtEadcy2FOCZ/BNY1kpCyYW8iOyI6OgHOl9R9C4Dyb+OXiwC
iP3NTz+RzRtbqc/DogTSlcOQhgh8FDFDyT7PeWl8PAEqHjkJ/VPab/DZNW+4FGPS
G98L/tWGKzx+Ks3ZXTqVzAR/2ClIazNFBQTdBXJGQG1PwnfUaRl6apujkeKYvmPW
nfItRWoD
=vcWt
-----END PGP SIGNATURE-----

--11tZBo3IeAoFNUfs--
