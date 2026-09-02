Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE668C61DD3
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 02:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68FC4607E0;
	Wed,  2 Sep 2026 02:18:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2WBPOw2zcUIG; Wed,  2 Sep 2026 02:18:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788315501;
	bh=OzYM2nxfkNbJECB6r3fB0KGqn9hA7c/40VZxLcZwurw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DF8HZflYgDqLjf4nm5AULxbKa4S5xWxTHNHImmr5+1A1faaef/bNr7BR+5IXRbiyx
	 ULGVFLXwHK1LrduypwipyZV/ZlhbumX3Qwck7CRawE7tFpvMMWh5SgJjm6U2MIfAwG
	 xh5v3n1OhD8MS8ti5Gs/yhIeZVRBWNhaPQrq6zKJpSCQ5ZbWywn3t0mZL/aP3HOkGl
	 TWS446ANsQYpb9c+8prz1r066kCWa9kcZkEwBYjEFELfAm0mJT6GfgED98fpZzh6Al
	 jFpqj2AdBmQwoj4f1GzBoGZkijgnJta2S2Tu8WsWk4x/xjvZVpMG+RfEtDGJ6EOLTr
	 dMyaGXq386EFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4144D6067F;
	Wed,  2 Sep 2026 02:18:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D5C4363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 02:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B686400AB
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 02:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ivrByWlKIpoU for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 02:18:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::32; helo=mail-oa1-x32.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=IldKv4Xq
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D34940076
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 02:18:19 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-46adfc81112so331904fac.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 19:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788315498; x=1788920298;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OzYM2nxfkNbJECB6r3fB0KGqn9hA7c/40VZxLcZwurw=;
 b=IldKv4XqTrP5s5VqHOKOWbtEnVy+0GpCYpHPAMhr4aXaO1kwW3IK53GmKGUgN2TE7O
 OE/5sKkWRQRG2sb/2pOh3p8BDIQHQypQi+0arncgn19OccgzsEGhzqu6c0N8W00UuyFD
 H1HvUE7OGYsLGanJ1RaUvAe324M7bukYIRiOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788315498; x=1788920298;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OzYM2nxfkNbJECB6r3fB0KGqn9hA7c/40VZxLcZwurw=;
 b=lqDqvmYVqQvhoCKv1wSYOoJHokkaRcnHKR+l22foai3boxRZDJ13OaRsawbLxG/0vx
 5YE6l4P9IilNfEWCOKrka71g+tBhxZqjxhzg7mUJp78hzAPBiPnN6BKUNUQ6m57pfXYF
 6NgZUr724t1J6PyaPrxZzHTXsIQkU70bn8v3y0q3ceRIiWCj/GEGQv/cojk/yOqeFV9U
 wHayZqWtdGex21qW131628SUwkygFfNeZp1V0aFf4He2JzvSv0DLI8m/v40V4vFhni7D
 2sgvX2EWLBXAWXDaqSF3MMWP+k+ODGFZT1jEoixYKdclVmXD9ILT3EqFXxEWWF4TV6OT
 bOJw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqagLZ1tDzoBYf5DzHtR4FainA6Y5AxPv1GGRrT5Kg6+AbcRTY+pdtBS1oTqXcgjL9y3CxbIu4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lP3Gqjm707wEiVWoKFJGLYcJ3E21uKllHNRRa2v1uaUcGnL6cy
 PAUIDOsDPVKq0QVQzzYGHVYwih5k8M39L39RoaNu4e+TtkIeNHTtldVmxKcFSTa7rXc=
X-Gm-Gg: AR+sD13RH5aN/hNu+Oxeh710ARgAJSb3hpgkYvRL7N0X97cgoAVtCGTZk344OD/w/Zf
 hUbdmV6N6qsCdCgGLAnRATsaNEkd+cF9Bb8l84rgrQfv52/ToHa0S6euEYK8n6ttNvIwlpqjPaw
 8aqD/Ti+SdvOvWK1jHFtoK4ppdsMA+3ieqKGj7T4PF+B3vBsRlMLpTrXmdNdAGZPvQghjRZ8Kl+
 pn/80n4oNLdcb43+DQ+BJ24Jn5gCW+/WGYyP/C0nIteHh70vozGKGsa6fSeUYA0Mr15YMAi4PCb
 OAhbQcDX7CHklMY/rQKg6bUUnZD08+XATo8n7btJ2MPAnpsqXJ9RQ600SYWRS4ZPc7z2VNeZHSS
 WGROga3Q7dhNmD+7W92LJLj42xhxm+k1R50dGlrxfERA0XKkaQoIBfLCnFABt96BXK/2C0X6G/j
 0Azguom+YfEIiT2JKGANK9UQyjfEVpChsW/DfSaqisFCkETUZsj57pvu8QJia7ccoXwfw0Wk63y
 qychQ0A+OQT7RB1WES30BrZLk4HT2juJkln+OKcMTK+pjgn+QBoW+8pnwz6JlzzRbCxicm2wwXA
 hlmV1ClcgxJ3MuXEQmBG
X-Received: by 2002:a05:6870:a0ac:b0:44c:5514:4e7b with SMTP id
 586e51a60fabf-46f85277d53mr1422714fac.2.1788315498019; 
 Tue, 01 Sep 2026 19:18:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-46f33084673sm2387745fac.16.2026.09.01.19.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 19:18:17 -0700 (PDT)
Date: Tue, 1 Sep 2026 20:18:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] airoha: add support for Airoha AN7583 SoC
Message-ID: <20260902021814.GA1592625@bill-the-cat>
References: <20260821070345.138264-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hML7jmfS109lWvWm"
Content-Disposition: inline
In-Reply-To: <20260821070345.138264-1-ansuelsmth@gmail.com>
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


--hML7jmfS109lWvWm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 09:03:44AM +0200, Christian Marangi wrote:

> Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
> entry for the SoC, DTSI and initial config for it. Also add the code for
> CPU and RAM initialization. Everything is mostly based on AN7581 that
> share lots of common piece.
>=20
> Acked-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> Changes v2:
> - Rebase on top of next

I see:
   aarch64:  +   an7583_evb
+(an7583_evb) arch/arm/mach-airoha/an7583/init.c: In function 'dram_init_ba=
nksize':
+(an7583_evb) arch/arm/mach-airoha/an7583/init.c:26:15: error: 'struct bd_i=
nfo' has no member named 'bi_dram'
+(an7583_evb)    26 |         gd->bd->bi_dram[0].start =3D gd->ram_base;
+(an7583_evb)       |               ^~
+(an7583_evb) arch/arm/mach-airoha/an7583/init.c:27:15: error: 'struct bd_i=
nfo' has no member named 'bi_dram'
+(an7583_evb)    27 |         gd->bd->bi_dram[0].size =3D get_effective_mem=
size();
+(an7583_evb) arch/arm/mach-airoha/an7583/init.c:30:23: error: 'struct bd_i=
nfo' has no member named 'bi_dram'
+(an7583_evb)    30 |                 gd->bd->bi_dram[1].start =3D gd->ram_=
base + SZ_2G;
+(an7583_evb)       |                       ^~
+(an7583_evb) arch/arm/mach-airoha/an7583/init.c:31:23: error: 'struct bd_i=
nfo' has no member named 'bi_dram'
+(an7583_evb)    31 |                 gd->bd->bi_dram[1].size =3D gd->ram_s=
ize - SZ_2G;
+(an7583_evb) make[3]: *** [scripts/Makefile.build:272: arch/arm/mach-airoh=
a/an7583/init.o] Error 1
+(an7583_evb) make[2]: *** [scripts/Makefile.build:497: arch/arm/mach-airoh=
a/an7583] Error 2
+(an7583_evb) make[1]: *** [Makefile:2221: arch/arm/mach-airoha] Error 2
+(an7583_evb) drivers/clk/airoha/clk-airoha.c:19:10: fatal error: asm/arch/=
scu-regmap.h: No such file or directory
+(an7583_evb)    19 | #include <asm/arch/scu-regmap.h>
+(an7583_evb)       |          ^~~~~~~~~~~~~~~~~~~~~~~
+(an7583_evb) compilation terminated.
+(an7583_evb) make[4]: *** [scripts/Makefile.build:272: drivers/clk/airoha/=
clk-airoha.o] Error 1
+(an7583_evb) make[3]: *** [scripts/Makefile.build:497: drivers/clk/airoha]=
 Error 2
+(an7583_evb) make[2]: *** [scripts/Makefile.build:497: drivers/clk] Error 2
+(an7583_evb) make[1]: *** [Makefile:2221: drivers] Error 2
+(an7583_evb) make: *** [Makefile:189: __sub-make] Error 2
    0    0    1 /1              an7583_evb

When trying to build on current next, please look in to this, thanks.

--=20
Tom

--hML7jmfS109lWvWm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapeHYwAKCRAr4qD1Cr/k
CsX0AQCuzRa1ZI7hQxHJc1JC2VOQ3a0pzSHkjxcgEW8PdJ0B+gEAgTCgyNPAbgn+
W9MHzBY7EJXbjU65L19+yEvF8sUCbwQ=
=0viK
-----END PGP SIGNATURE-----

--hML7jmfS109lWvWm--
