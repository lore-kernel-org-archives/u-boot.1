Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57051125856
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 17:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A0184035;
	Wed, 11 Mar 2026 18:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SKXnoHrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DB884057; Wed, 11 Mar 2026 18:32:19 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD1D183FB6
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 18:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d743ba241aso106106a34.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 10:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773250335; x=1773855135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/tmCZfCQ12S+zbwV4RHyJdkVvZKyhIOkcnJOkJugMOs=;
 b=SKXnoHrEpGSvOE6Sp1v8W9succHbHZEayLfpAqrQU1UgdiyM1HDeJsCOi6Oud9M57q
 loQQzhvJ8tuvtUUCt2VCZuhQFMImAdzg78GS7ny71Q6RGcZpJJxWIjxeKTJ+mifRpw3d
 H3fo0FcDg7niLilZec99n4K0G2dzSPqmUAfxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773250335; x=1773855135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/tmCZfCQ12S+zbwV4RHyJdkVvZKyhIOkcnJOkJugMOs=;
 b=JKgHRAdqZ6cvhvSXN4Mne4k9lla+LYHo0myFKVjOjf/0TOSc/q5XjApbYdk0olMgli
 Y/KS25r4+J61O2s4lXDInHWi5v2Uwkocc3uv7RjhiD5Ony9qz19EiphOH1vLqW6m5gc0
 OZpQZ9AulrAwFAcKhQ5ULPb0hNRQa3P9wwqXZUMOGrpHPT9iInoVr90dYqTVj0RxSDfs
 gSCk0FVYSDx8FH3CtZudC4xbdSwWNKqhT4r+nH/lu+qz/kwkxcQD/+flmHd9LghqCD7H
 wVoGawSlRK5sjYE765FqdCfpcjmZZVlD25Z7wSy61ZrDtmrxH/zimn0Ek7QYqBrtA55h
 YSfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ujqeEYcPSNHlm/OF8cmQtEoaAKegbOoeqD5qnfEKJ+KNtpVZCiunHhxwZ87min5oihHm47U=@lists.denx.de
X-Gm-Message-State: AOJu0YxmD2OWS0eVy25o+IbyobrBGhuBG2aQMv4twqP3KoWfE9NM5sEb
 DoiUXTyeyn3i4WpQmFoU+yGU4uzuTiTgZp3INZDV+lum09asPbJ6XBoP6mQoxXKOzAo=
X-Gm-Gg: ATEYQzw/MQf2D8TQt1MTWYubnvkw/hEKyJ0qBx/NzIWxawPyqK7IbIm9PWyL0paepyA
 pEJi8NoXL8fILanjwAfaZW8uwEjfsS6DNcm5bWiXSqhYBGlPts0UJ+YexZN5TC14Dp5YC/HqzSd
 /4m3/Bn/oYhjOKp7sdQuUqfQj4Y9++93xA3rajHFp+yBgrs/otCZ/l+YXpq7gWCbrqViCQrczWf
 pr7hW11XAjAgUTxWRsI7ygLPYoItmH+qto75tDq9pZq2spRjY969PvlNhErC/6QGzadL6sxcEU7
 yobO4WzLsJkSpzZeU6JGHHS9mbZjeYg1e7Ft1mhnQwAWg25KJRqBCIPUrnEJ1TVvaxmXpX/3bVI
 syaJV6UbcRmeX1PBqBeLWO6ZVrz1ROTd9DcLICUCpLFRs1qM9d81gDOPE6FixRYdPpc1XeMC9ub
 oxtgrSXCQGDrFcgWrzrPHeLZPB52jQFoBusl2VN3sBY8Xv8r5tuIP4LMLBB+j9jmZqssqyjLMif
 snxpfG7CAGh
X-Received: by 2002:a05:6820:2291:b0:67b:a4c9:9b6 with SMTP id
 006d021491bc7-67bc89d4de9mr2005515eaf.41.1773250335510; 
 Wed, 11 Mar 2026 10:32:15 -0700 (PDT)
Received: from bill-the-cat ([2806:370:5618:2cb:9d3c:e48b:fc5f:66ae])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9354e59sm1726284eaf.16.2026.03.11.10.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 10:32:14 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:32:10 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: add new MediaTek custodians
Message-ID: <20260311173210.GA378499@bill-the-cat>
References: <20260311-mtk-custodians-v1-1-000f9025b54c@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uPNv0Edt+bMaMpke"
Content-Disposition: inline
In-Reply-To: <20260311-mtk-custodians-v1-1-000f9025b54c@baylibre.com>
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


--uPNv0Edt+bMaMpke
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 09:52:49AM -0500, David Lechner wrote:

> Add new MediaTek custodians and the new MediaTek custodian's git
> repository to the MAINTAINERS file.
>=20
> Julien and I have volunteered to act as custodians for MediaTek since
> we have been actively working on upstreaming MediaTek support for some
> some time now.
>=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uPNv0Edt+bMaMpke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabGnFgAKCRAr4qD1Cr/k
CuUHAP9/mlA9rm2Rjzs+ALhvLHPuS4s9IC02r+5g1Jjqtv79aAEAnOwtbCl8bBpe
cLpTHKsSl66V00D/BSbbfGSXbZ5bRgc=
=weOh
-----END PGP SIGNATURE-----

--uPNv0Edt+bMaMpke--
