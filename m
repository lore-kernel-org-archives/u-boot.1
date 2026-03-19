Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154C0109024C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 16:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6AA83DA6;
	Thu, 19 Mar 2026 17:16:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oBgRa3hJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C56483DC9; Thu, 19 Mar 2026 17:16:16 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF99E80517
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-4043b909ed4so560137fac.3
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773936972; x=1774541772; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sLt4nhDjMx3P+c9XWAUIwIwuNnVGt3QIGufiJi6dLzI=;
 b=oBgRa3hJPdpX6147hScPbb6+fiIpQLjTrxA/hlbT+9NeBmsgDA8VbwSa8QXboovXOL
 beDT05TAydrsatODiMoEk3fL7CTRfQo+ZfZHp/lhh57zGuQsyRbaimiBxV9h+6/GoYJS
 fwemTexGmcTW4zX4iDInRuQCkoWoHBZzme9kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773936972; x=1774541772;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLt4nhDjMx3P+c9XWAUIwIwuNnVGt3QIGufiJi6dLzI=;
 b=npRcCVmHHWHu6g/BcwHngwgCjRZ5XS5jQesOgJi6Z6zDRnxmZUJHyg5derNtrR53r+
 LDBg5pbP9yd0GEDI9aAvxThc/9YyfvSDMexOW1BF55pT+4Mi+I6mPXg8PYN1KQrw3dIg
 Gds6gtuoEGr7gTJzPrU7r27mb83g75cbO0N1f++r7QScv3qmDVVNSzzcYME3WzWxQXz1
 eSmrdy69pwD1v1GdbV5zrJeTzgOQS6M21jJh6jtYI6fc3ZQsIvRQfAE2TZb2Tk4wCLh0
 HBI+lgtVq/DWhGvvYywYp1zn27DJKhUq8KsjBksfpm/4neMrCkb0SlkYosjRKhpU4AAJ
 s6Pg==
X-Gm-Message-State: AOJu0Yxzgw/ReSvC+ftUL97aHHZvB06B2tAA4EaloF4VvQgW+OK/ktuY
 61+zPU8rOqgULrQBLlhDiY6cGZ3dTqNCeLiuuPpvPc2fzFNzKj8cRGF85ggTxPK4tPk=
X-Gm-Gg: ATEYQzyP/NqzFRR7wokizMsJlf41Gy/zklL1u8VUrynJkVdO2SDPlzTaSW62XMbiMAS
 /Y8TEdthvrhZkYWZ13gFEVy3dnxsSUiOEFUEKwGs/WItSgZkqcKkoEy0ChpySVK+7ZOsfOdtOnP
 XEOHnOor0nf6Nyj3i6ZHdqDxyth/1YTJjITOosu0yzwzjsP2ia87sZPIU7HpyKBawIMg7XIZ1b2
 o3Mv9PUTiQkVCZjNWZfDunjfQRfFp5dJT9+M6t1xfe4By4IzT3cQsUVY6zvNpUDNJFdymC2uozW
 GtL85Nt718lPIT2mYOBVlxRWsJcTe8B3lOVhFrY+O3+51SXWCv3ejewZY9gDiIirgZxGfxytMVT
 2z0EiR+cvep3qoLEB2PT41Z62LvyC5JNQXolq4240PNESveozoQTFAgKTUlE2r8ZbifD7S3X8Hk
 L0F5F+3edxQysqIu3qDnNqEvmif28LMQdGMcGVzo1DuMqoWfoIZUfMXJ14ZXcdVLdTJ7MUagP0s
 yAVhfOUXxDmWti7xq1I2OIXf/ugG3JP9vaqKyjdYZhIiE3c+kRZyRphH6o=
X-Received: by 2002:a05:6870:e0cd:b0:408:694d:ff34 with SMTP id
 586e51a60fabf-41bd3ea1239mr4981458fac.9.1773936972068; 
 Thu, 19 Mar 2026 09:16:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41bd22dee78sm6283192fac.0.2026.03.19.09.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:16:11 -0700 (PDT)
Date: Thu, 19 Mar 2026 10:16:09 -0600
From: Tom Rini <trini@konsulko.com>
To: "NG, BOON KHAI" <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "MANIYAM, DINESH" <dinesh.maniyam@altera.com>,
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>,
 "LOK, CHEN HUEI" <chen.huei.lok@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] configs: socfpga: stratix10: Disable mkeficapsule
 tool build
Message-ID: <20260319161609.GU502704@bill-the-cat>
References: <20260319112717.7805-1-boon.khai.ng@altera.com>
 <20260319134809.GR502704@bill-the-cat>
 <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eB778krYkv6KzVyl"
Content-Disposition: inline
In-Reply-To: <SA3PR03MB7187764E2EBF3FACEF2619DDB44FA@SA3PR03MB7187.namprd03.prod.outlook.com>
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


--eB778krYkv6KzVyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 04:11:09PM +0000, NG, BOON KHAI wrote:
> Hi Tom,
>=20
> > Why / how is this failing to compile?
>=20
> When compile without disabling the mkeficapsule tool
> will hit into this error:
>=20
> tools/mkeficapsule.c:20:10: fatal error: gnutls/gnutls.h: No such file or=
 directory
>  #include <gnutls/gnutls.h>
>           ^~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.host:113: tools/mkeficapsule.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:2201: tools] Error 2
>=20
> We are not using that tools, I think we should just disable it.

That's a documented host dependency. We generally don't want to disable
general tools even if, sigh, I see a few other boards are also doing
this now.

--=20
Tom

--eB778krYkv6KzVyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabwhRQAKCRAr4qD1Cr/k
CtwjAP9n+LBnf+dR0qD/oOCVchH6kHRuXLmVq5SSJ9bDs5jggwEA1p4NF2pNQe2p
o4bQo6df5W4GDphqKkzs6EH9NKuQsAU=
=M4er
-----END PGP SIGNATURE-----

--eB778krYkv6KzVyl--
