Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F091C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108CD88065;
	Wed, 20 Mar 2024 13:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SNEGpjJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 397D08803E; Wed, 20 Mar 2024 13:42:01 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06ED58808A
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-dcc84ae94c1so6078028276.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710938518; x=1711543318; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1GKwlrswwsgl51KHAgVM8AAR2aX/IApVR5OoSfTcD2U=;
 b=SNEGpjJLfQki0TI6PIADKOpS/LmX6PGLWhrACuTsZQLqCAitrMZFTRKGAvon1QLRP9
 MYci24IZO+E0DI/cu0zkZKIeD9wtqDBji78jHxp7tu+i3c4jQ8NJHzlAVjxDiQPelMlJ
 f2GXELrsjFeFFDOD0HRrTl4gEl+YKHYPjP2zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710938518; x=1711543318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GKwlrswwsgl51KHAgVM8AAR2aX/IApVR5OoSfTcD2U=;
 b=UBUi9PjrZn63D9G+moPND4Ena45zb4Tbbn2/SOXOxHJRpgpvW/ZS62WIDoBwHiJAzH
 ioRDSgw6SO4hgfgOQTkyRylc9yHWh10HfZ26apnLp1b8jTlLGjzzS90WWOmhM7AHpGqZ
 QEM71fA0ns0E8eAupGSV9w3av7vz4fHXUY73TtAJsD8trw7TRlLXeBYhohmjs7RsoiIt
 aZEyfcjIvWwiAblX/VA2lM6Q+ONLPHCIj9UXHAaFcfmDX8n1sTKrqD+RikykeBh7ezI8
 QaPi/f2w9fZli1WD94z0T+GHveCC242BYu/z8I9zdCcB7NFwOsYJeZODEZylUrSf5dup
 ONTg==
X-Gm-Message-State: AOJu0YxFxY/oIHfRAaMJn4JjzBnToyjzt5BIGBP7pu0ni1lDM+mPyzJk
 Em8WdDnTOX3LeuhlfjwPMTkEv5DEO8u8fNNj+0y+lF3mhl8tl0Jtzr517df3QfM=
X-Google-Smtp-Source: AGHT+IH7A5qmVaZ2jw6tXat3mNXuw/QheCOTfJ7j9ZBaAzM7SvunlTe3l3YLPqNgHXqVDZ9qxU8JYw==
X-Received: by 2002:a25:dc82:0:b0:db9:9537:2c39 with SMTP id
 y124-20020a25dc82000000b00db995372c39mr15159105ybe.2.1710938517829; 
 Wed, 20 Mar 2024 05:41:57 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a25868b000000b00dcf27be1d1bsm2492664ybk.28.2024.03.20.05.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:41:57 -0700 (PDT)
Date: Wed, 20 Mar 2024 08:41:55 -0400
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v4] test/py: saveenv: Add a test for saveenv command
Message-ID: <20240320124155.GQ3442575@bill-the-cat>
References: <e5be61472f03d771eba78625469a851363b0efba.1710225217.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7pCKggAQHdIy0mMo"
Content-Disposition: inline
In-Reply-To: <e5be61472f03d771eba78625469a851363b0efba.1710225217.git.love.kumar@amd.com>
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


--7pCKggAQHdIy0mMo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 02:16:10PM +0530, Love Kumar wrote:

> Add test case for saveenv command in non-JTAG bootmode which saves the
> u-boot environment variables in persistent storage.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>

Applied to u-boot/next, thanks!

--=20
Tom

--7pCKggAQHdIy0mMo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX62ZMACgkQFHw5/5Y0
tyyi8Av/c9QSBJxiNB7g+0YijREX/pwsG5j2bHoWwGhs398BemlUkwcvOEAxtRyD
ytaVeKBlINaDyyHt8yufqN+8X0lgXJ3EsBKmJyAJ197tGOm5Oq4rqtowkkNC1Dg8
Q+xl3w4+lFOQmLCdQ67H77T/rZYZr1waEhbrX0iacVGxf1/jJUbjXnl9y44kBZqb
HmRCTbfp9i8Y31TUyXqt+KMDa+0N9VHMgF/oxmShaZ0usKAzffWbC82h/mlm0Ubh
olSRbwHvzk6iB/mLGRX+HXqlw6w6v9BRjMRx0kDON4PM8u1tAzXUjsPei4eEqrJx
WlvxXQEMuqZBrlxWVX3Rakxe4EKd7iGXco/HuR1qRnlb3m5Dc3VNfrm3PO94F4xK
0dVdqi+O4Ha8sLuqaj69/ANbpjIkF0FeCd/Vg3fcGWFwwleWeAvGHNtzcJHzjqHw
yPJycgrPMXKnLjDvq4SiFYWs5JHuYGOY2K/V30QH/veSd+cTIv8a4oxIKOviDobS
GUARUtPu
=Kw3t
-----END PGP SIGNATURE-----

--7pCKggAQHdIy0mMo--
