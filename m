Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7107C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 19:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3724880F5;
	Mon,  8 Apr 2024 21:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GhdQQsTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42099880FE; Mon,  8 Apr 2024 21:38:56 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C1C487B71
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 21:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-78d543db3a4so167669885a.0
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712605133; x=1713209933; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3nY4ByNvYSpJHnDuwH03X9YmZeDfedeH/fU7fef3hfA=;
 b=GhdQQsTS64j6SxkpaENzaxKvpSLPgtKNj2toAop34KJub0bvhCUIVZiHU24/BQwVyD
 KnpJH/2RSsiBdhgzmN916eNzCeaoMSnkFfZbyPmZcT09+cqC6v4c41vRRYqfORg36OkA
 Xs/SBpngmoWbhXegSfC34pj4ScD57NDz2+j/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712605133; x=1713209933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nY4ByNvYSpJHnDuwH03X9YmZeDfedeH/fU7fef3hfA=;
 b=ttbaJmo4YyiMXpR8Uq34CA2slmB7YB3DCo/T++c939LTaw36+y5PekoKkDzPHsMcuG
 +7enKqz434w7H1NZLT7eUThn79G3so8k9XhU0FilmkCCce6LZygSx7HCQ7x8bVV6olA+
 PfPAv8wg31qDwc19pux5XGdU5McmiMonwDhojVXXgNwLNvb+L5daH/3vnaSP+m2RHSzY
 iAC+LxmQlR3/T2iJEvjSDzh5cZJ7Cjhkv28e/USaWSpts0RnmRDE2NoxrmEikwMScv7l
 T8hYXzjuIBxQeDrXbFlvZEnRlMlP2hSVv0988/fb0EuO1xWMs8lgn1XSvkdZXFMCnK1I
 KLHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgq5iDg+3+9V6ccc+/gjG9dzvY21GoEAk1WYjLtpiY7gDmLQpyFVFDeU1vca7MM2VNkfpvsGMf62bdhfAKvHydnHdFww==
X-Gm-Message-State: AOJu0YxY4YmcpoI8oPUVIyB2tiQ60WSoK3NqdMwS1YT0JXEl2nvoum4h
 jET97YwQQYDDO4E4mHsqyz4X0rR7TwtXRwCCs/8X7VQ8PNpGQGzDv05cSQ/E8M8=
X-Google-Smtp-Source: AGHT+IEKz2a0po34ZjuIo6CloVJO23FZakkk60vbGKzgkFNarpxP1ewXeykIUO0yOcDdm77n8CWNTw==
X-Received: by 2002:a05:620a:d93:b0:78a:72e4:d4b8 with SMTP id
 q19-20020a05620a0d9300b0078a72e4d4b8mr12153533qkl.34.1712605132342; 
 Mon, 08 Apr 2024 12:38:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 da35-20020a05620a362300b00789e1c94cf4sm3463339qkb.113.2024.04.08.12.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 12:38:51 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:38:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 00/14] rockchip: rk3308: Sync DT with linux v6.8 and
 update defconfigs
Message-ID: <20240408193848.GA6531@bill-the-cat>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IKY2mXXhyI+ynBTW"
Content-Disposition: inline
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
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


--IKY2mXXhyI+ynBTW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 06:13:57PM +0000, Jonas Karlman wrote:
> This series adds support for new clocks used in linux v6.8 device trees,
> enables use of FIT signature check for checksum validation and fixes
> loading FIT from SD-card when loading FIT from eMMC fails.
>=20
> It should be possible to move RK3308 boards to use OF_UPSTREAM in a
> future series after this has been applied.
>=20
> I have runtime tested this series on a Radxa ROCK Pi S v1.3 having a
> RK3308B SoC. Following was tested and now working after this: SD-card,
> eMMC (SD NAND), Ethernet, USB host and USB gadget (RockUSB and UMS).
>=20
> Changes in v2:
> - Add clocks and resets props to otp node
> - Add bootph-some-ram to emmc and sdmmc pinctrl nodes
> - Sort bootph-all prop after compatible and reg props
> - Fix rk3308-evb debug uart
> - New patch to move cru and grf include files to arch-rockchip

Sorry if I missed the answer in v1, but why aren't we switching to
OF_UPSTREAM here, which is also on v6.8 currently? Thanks.

--=20
Tom

--IKY2mXXhyI+ynBTW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYUR8QACgkQFHw5/5Y0
tywYoQwAjKhpiRFM89fcl6+I3kFyY1ReqKM2q79tbVoNyHchXywSS6KmA7uLtHme
F2pNijhe2jild6Sd6QZPS5cCW3RixZ6mg1pV8ZnUuxDpOYFS4mBsGd5j4r+sJNjQ
7vUYAvmNYn/vWSy7SMSgx4njZaJCQByl6D+PRbgNT2P+nNnhQSSS0ZaxM/z3jbam
MRYEZbepNhtnKfOmzaO4C9E2A3KezVA4awYVqkAqQrHnaT/jGCnoI4mZ//Cj11Qc
aTMMrmCSwWny0YH7Kf3M1nem3CQR6yOLAFHxgjQ/EMJU1RK3u6/Qi2FST/xaEZrz
R3xNMcQ1O0MZYe/TtZCwngjbrCBmGWayFM7i0tNz3E3F2a3QD9yfV0Pj0EM0TBip
VRah50s6G6CXcEDs/KzSrAVVrb4u6uAXdv1xmOPc1xscOgvS3ZMJdYfoD+KzNlFQ
4d70vfo6UoOuv7uQvAfd9D7E7gI3rleqb8LCw/f+mM9sgK8HGfnDC/aVcwSJSFQP
6Y5zoTem
=CWSr
-----END PGP SIGNATURE-----

--IKY2mXXhyI+ynBTW--
