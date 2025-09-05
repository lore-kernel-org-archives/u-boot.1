Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25803CA1010
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 05:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7140483887;
	Fri,  5 Sep 2025 07:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=karo-electronics.de header.i=@karo-electronics.de header.b="EzS7V4l8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D896A831A4; Fri,  5 Sep 2025 07:35:31 +0200 (CEST)
Received: from dd54918.kasserver.com (dd54918.kasserver.com [85.13.167.58])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F3C831A4
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 07:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=KARO-electronics.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=LW@KARO-electronics.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=karo-electronics.de;
 s=kas202509031142; t=1757050529;
 bh=eTmolUL+a3c8twdFOrhM3oMfwoJd8QEuYs7Aw5QSArg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=EzS7V4l8ku7yRwRguBea5KgXgeHLEGleeNRYC0YSoRGncNZsJHOpQ30G9EscY64TI
 q9FN0bIvGUOUgzOOMqmgszq4haeGSCamrj5+nrg8yXYSKSeU0aQtddQwScVwezWRlV
 PDwnVRpx0eP7WQDHQAMZDkXiwTgWaZqhiywSnJ3mmozlwWabPvxU65wa/o378T50HF
 nBQBF2nKyK2ykYjH1yTy3QX8WmNhlBLf4iEDkVwlmR52Psm+tJhy2qPTkmI7yt3Wpl
 zWcw5kCIJNazytE4akkhi9pdyqtp3TTYdhzu0+5S28l2b06MXvt1StVzPUVc0TczUM
 tPVLwsCqUjrtA==
Received: from karo-electronics.de (unknown [89.1.81.74])
 by dd54918.kasserver.com (Postfix) with ESMTPSA id 604E27721617;
 Fri,  5 Sep 2025 07:35:29 +0200 (CEST)
Date: Fri, 5 Sep 2025 07:35:28 +0200
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>,
 "Lucien . Jheng" <lucienzx159@gmail.com>
Subject: Re: [PATCH v3 2/5] misc: fs_loader: allow using long script name in
 request_firmware_into_buf_via_script()
Message-ID: <20250905073528.4cba3123@karo-electronics.de>
In-Reply-To: <3af4ba436c9d890096d679766cf3d6d6b0b65e71.camel@mediatek.com>
References: <cover.1756885599.git.weijie.gao@mediatek.com>
 <038e8258c903367dccd9c7cd1adb51bcf2bdf307.1756885599.git.weijie.gao@mediatek.com>
 <20250903133600.52169228@karo-electronics.de>
 <5ada4f98b8d09bd78915bef278dee780de5d7fa2.camel@mediatek.com>
 <20250904112811.5a104f4d@karo-electronics.de>
 <3af4ba436c9d890096d679766cf3d6d6b0b65e71.camel@mediatek.com>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: /
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

Hi,

On Fri, 5 Sep 2025 09:26:05 +0800 Weijie Gao wrote:
[...]
> > > We'll get compiler warning if using const char *[]:
> > >=20
> > >   CC      drivers/misc/fs_loader.o
> > > drivers/misc/fs_loader.c: In function
> > > 'request_firmware_into_buf_via_script':
> > > drivers/misc/fs_loader.c:243:33: warning: passing argument 3 of
> > > 'cmd_process' from incompatible pointer type [-Wincompatible-
> > > pointer-
> > > types]
> > >   243 |         ret =3D cmd_process(0, 2, args, &repeatable, NULL);
> > >       |                                 ^~~~
> > >       |                                 |
> > >       |                                 const char **
> > >  =20
> >=20
> > OK. But at least:
> >         char *args[2] =3D { "run", (char *)script_name };
> > should work... =20
>=20
> You're right. I thought string literals are always const.
>=20
> >=20
> >=20
> > NB: The right fix would be to change the argument type of
> > cmd_process()
> > (and all functions with similar semantics...) to
> > "const char *const argv[]", since cmd_process() need not and should
> > not
> > be able to modify any of the strings within argv[]. =20
>=20
> I agree. But this should be sent in another patch series.
>=20
Above all, this should be considered when designing a new API.
There is no reason why a function like cmd_process() should ever be
able to modify the strings it gets passed in the argument list, so they
should always be declared as 'const char *...'.


Lothar Wa=C3=9Fmann
