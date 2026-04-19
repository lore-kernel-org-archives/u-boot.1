Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7E6EA71A1
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 15:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64FF783B99;
	Sun, 19 Apr 2026 17:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rPJb41MM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E9E839D9; Sun, 19 Apr 2026 17:40:33 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AA0583B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7dca21ab599so1248964a34.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 08:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776613230; x=1777218030; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yNb+zYjrBvlsJZWPrHxgh6OglPV3SWAceVFeYX+SkBU=;
 b=rPJb41MMa2hml/Sgk+t+JgJhix/5U2gK/g3l61edPmJQdFuXG5ZEc7OFLoKJzFBPha
 c3ZaK4SsquLGZ9NlayLHSxUdXNFRGVCqp9pjMyCC8sFcMzSi9/PR/LmFL6aUUfRWUehO
 SZfYQL7cEH/tXBlLrE7oaol+1NNEVPhvfQzZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776613230; x=1777218030;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNb+zYjrBvlsJZWPrHxgh6OglPV3SWAceVFeYX+SkBU=;
 b=amLWCNhX/KmpD7H1gDwtdwD5QKQ6phL1Ouy8gyJZ+Gf2QBkab7RQx7/3uTFhsqsI3Q
 U/OwD+fpQmo+gLEpNb92r42LeByYJpNaoHh/wjgeZt7knLN+zB2CbNHFlwdK9SKoDfnS
 PfTS4MYSHhUVbDao1RD1xwWN/lEX7a5DV6tFKs5tIaKlMy744NPTpm3KsmGe6KRKirjq
 mdYXFuGkDS6U8v7nww20iAur4WlUkwBgEtkIEjvXxsBoUvmyJ8mS1DTzuBVLk/6DIzQT
 IXYFkR4+//eE+Rju+TJMmHNk4C75q6APCTqwF08b8uy9BZOCRHn4wMkqnhH/0MWAFHKL
 Y0Fg==
X-Gm-Message-State: AOJu0Yw7j/8WUj069l8UZrAB+Bycb8Nny7u5cMfM8XQKVv0PgXTAanlb
 MScbvf7sRAYwAgh34H6LyLFSiAJlIDFeqTRI4lrZIo4uCdLg8d9b2ZnJfe+usQNRXsU=
X-Gm-Gg: AeBDiev5GMFpI11VrKSrs/tqD9T4JeCIIiM2QyNOO7z05NKVErHrSJOn8ZRES6cD4by
 aflPIZAb4jfILWju2S2m1b/fA7TltgIoBkq228ANvyMo68sMExcjIWhwXZT+0If5KKSb8Q80ISr
 wSfHgUk1pL7V2GzlzAxve8UgSX5b+yP4Vgk5MYv8ZErDzWP4UGEDJaatmW5pmTew+aeH81GvYGf
 ZkQpzVJn52AgzqMod+tuSAlDQk9n8+K+CyRgZ2/Gn3sohDy9RIixTvcTpzbPQSQBjw52Tc5vW8m
 lOKQCbwQFr0qb3EHXInqi62cxw5uRgtg31ofhVnsSdRd4HfHzle91il6rNnr0tNKN+BfC2cYAfr
 zgGSEr26dBSlb58g4z4gtoJ+FiNAI4h0VwhRbxOelidbMPln4W4d7hopyvvS+6xZXKVscR0YpO6
 niVYNraChBdzYqwfmP7lkMtlB5QHzK+k+EdbHpXD96v8jZ9WM5UU+reiBK5WXT5jN82/0IdfHk7
 43nEBTpigitLA89LU6oF1pnNzMkz1yLDXiCFgFg9H59OrpKQRn7EV9YoC63WA==
X-Received: by 2002:a05:6830:2b0a:b0:7d7:f031:37bf with SMTP id
 46e09a7af769-7dc95230e00mr5809085a34.19.1776613229892; 
 Sun, 19 Apr 2026 08:40:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc9751a2f9sm6250540a34.12.2026.04.19.08.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 08:40:29 -0700 (PDT)
Date: Sun, 19 Apr 2026 09:40:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Ajit Singh <blfizzyy@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PULL] Please pull casey/qcom-main-13Apr2026
Message-ID: <20260419154026.GV41863@bill-the-cat>
References: <20260419030602.2470577-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gysMLENdmEJ9Pnqw"
Content-Disposition: inline
In-Reply-To: <20260419030602.2470577-1-casey.connolly@linaro.org>
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


--gysMLENdmEJ9Pnqw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 05:03:16AM +0200, Casey Connolly wrote:

> Hi Tom,
>=20
> Various Qualcomm additions this cycle:
> * USB superspeed support for 1 platform
> * Initial support for the Milos platform and the Fairphone Gen 6 (chainlo=
aded from ABL)
> * Improved support for booting with OP-TEE on supported platforms
> * Initial basic power domain support
>=20
> Notably there is a generic change to the device core, missing power
> domains will no longer cause a device to fail probe and instead will
> just print a warning. This shouldn't affect any existing platforms.

Unfortunately I get a fail to build in CI:
https://source.denx.de/u-boot/u-boot/-/jobs/1428016
+(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c: In function 'qmp_combo_co=
m_init':
+(qcm6490) drivers/phy/qcom/phy-qcom-qmp-combo.c:288:35: error: unused vari=
able 'cfg' [-Werro
r=3Dunused-variable]
+(qcm6490)   288 |         const struct qmp_phy_cfg *cfg =3D qmp->cfg;
+(qcm6490)       |                                   ^~~
+(qcm6490) cc1: all warnings being treated as errors
+(qcm6490) make[4]: *** [scripts/Makefile.build:271: drivers/phy/qcom/phy-q=
com-qmp-combo.o] E
rror 1
+(qcm6490) make[3]: *** [scripts/Makefile.build:492: drivers/phy/qcom] Erro=
r 2
+(qcm6490) make[2]: *** [scripts/Makefile.build:492: drivers/phy] Error 2
+(qcm6490) make[1]: *** [Makefile:2205: drivers] Error 2

--=20
Tom

--gysMLENdmEJ9Pnqw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeT3YwAKCRAr4qD1Cr/k
CvMCAP9X/vNIqCn04ufETw+C97x0YP77MmFocsO+rqBZHUCQ8QD9HQiKVn2hj7u4
7T1XiYjKcFeOTpa5H+/gi+CZhvfHZgg=
=wyqr
-----END PGP SIGNATURE-----

--gysMLENdmEJ9Pnqw--
