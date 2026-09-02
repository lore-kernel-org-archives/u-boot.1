Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2D6C624D7
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 14:27:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 049A480F8D;
	Wed,  2 Sep 2026 14:27:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OYPKJ6UwdFQp; Wed,  2 Sep 2026 14:27:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788359260;
	bh=4jCHehVQL+kWxmRZe1A5gJQpfTKPtwwTTgFBrOpydjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=db2vQdnxrbpHnzfMo6BJ+A6A5FyDN6tJXnJncr+Hz/Kktes1Fsanzrn6x1c2OTzOa
	 Brw9UHrHnleDWvhaeBljtTMaW24WTPEWit4jBL64XC4T7hy8OEjxFRBE7PhzshVeTl
	 qzY7RQ4H5rfgO1y62B3iyf/s2YdpFyHtH8OXHK6JI6fK8oIaWr4zJwNf/6ugxcUm55
	 2J0p0RJUSYwXivNmzrghR7bafMXuci5DDu4y/yzq92lw+WXXh9PA5SdFByaoGVcjzx
	 MUyNyedzzvIEdrfmzBvWy3VwyRrjwhw39bhDL8d9eKniU8d3zvjQuqol8IEOnHtgdQ
	 acNv6eogoG3iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C697A80F77;
	Wed,  2 Sep 2026 14:27:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 755CB465
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B86E400A6
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:27:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id womOw5IqUlI6 for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 14:27:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::;
 helo=mail-oi2-x00.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=f9hd4CxT
Received: from mail-oi2-x00.google.com (mail-oi2-x00.google.com
 [IPv6:2607:f8b0:4864:32::])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A3734006F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 14:27:37 +0000 (UTC)
Received: by mail-oi2-x00.google.com with SMTP id
 5614622812f47-495d5d27acfso313759b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 07:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788359257; x=1788964057;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4jCHehVQL+kWxmRZe1A5gJQpfTKPtwwTTgFBrOpydjQ=;
 b=f9hd4CxTzY6ag47gLZRt0MduU5jfMThQJ4ARbKwrVOD398FtFKVFQEpxaM2YJy78qQ
 htTef7p8/D2NGCeKmAMM0sLQZ5GFlAbL384sVdy6JGJ9Guxarzln39LkrPE+P9MgguQy
 9pp9VxK+HewdIlyiP0G8K5zDJB/C6TXbjydvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788359257; x=1788964057;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4jCHehVQL+kWxmRZe1A5gJQpfTKPtwwTTgFBrOpydjQ=;
 b=RNDcN3zJf9ZQXs0xwtISi1yZJvPUsy2P8EL/FRmDprYZYglPgcZXAZIbqeqB0nG3pv
 Hh3CtYpEsnyeHlN24jhnBaSjB6pFSTKIEOR3H8kcC5MjyWBYnQ5gCvWtnnqIpJwnaJDe
 PLrEMlFFOrkTgCtNQgH6NCBO2c2kz8KPoj9DkAKrFM+oP861cmlC1vUuToJWPj2IzuKT
 /ThnXR3dVMGUIlWZWFXkmpwkFoo9NJjQggcUduGUqTOYbhQtFX9VJlmfRyeLmtaY2j9h
 ealQkwO7oWAQ0FBylXDKgSD1AU/PhskYyf9FAQqnjcSSY6GmqTpv+rJ/dAjMl4JhTGqx
 +Nbg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rprrc7TZDTYojXWAOKZ9jXU8LksJ9ULGf83XTwszudx0rOPYZFOzYQ/mKQKd++w8duy6Rwvayc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l1gLYd/FQZ/ky/KqbkSJxQx5fPDi9AVZ6NA1M/iZFjV+IygDwB
 qwobDmsDeG3o1RLlcmKDzXJ0Bkvxel2cAdPbH3nEocxqAfPtb2vaIRX0L+sKhDFWC6g=
X-Gm-Gg: AR+sD106juPne6rrtbBIzpZAa3pHEyykD0UhpGmvEFcS8PJE0VWog600bwwxn39Ly0Y
 4mLC5RoERofEW9w3ZFsC288F5ik0vEn9wExhCSBndBuxcElBmKGyMpul/h3ej3oHFeQqZ3xD4eG
 42oPryzaAYjNr1Z+jvnTqC93Wk/VxPggVRhNHKiQo9/VUXvadAiUGNf4GkuOVnQRBOynutLYsDf
 8Cg3x53d7zTpGyU1nMWH+YPwqgpofqk9bVfMY09EHR+bNKxy6aLvcoSLZtwtSrmCwDD42sa83nj
 hBXD4NIVNLBWD2KQYcJO/w0ns7qBQOpy7cfHd5UXl5InTMJpSkLQLPdrp3myqZmSy5+lEPVozgo
 fydvxh9qdrUJLUw841LZNjvvHK1VabHxdHu8UNZQgycD705HjgiJKJXKVJhriCFRIIrZIdOSpkW
 /qMCw0ynQonNOt3UP2Uhjt5EXZ+OiMKCjhM0OkGlLVb3fYcfa69u52/9KM+9+9qogqydzwLFQSu
 U/Z7wuEBz+oXA36wKzEGRLYa+Aybqx6kbaWik2IeUuCU5B+HZU7wbkrJvcqgZLwBlclc6OGXpZ5
 2QYlndCU+Q==
X-Received: by 2002:a05:6808:3518:b0:49b:c387:36b6 with SMTP id
 5614622812f47-4b6be1fdb51mr4262996b6e.13.1788359256890; 
 Wed, 02 Sep 2026 07:27:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b69bd2638csm2148644b6e.18.2026.09.02.07.27.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 07:27:36 -0700 (PDT)
Date: Wed, 2 Sep 2026 08:27:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2] airoha: add support for Airoha AN7583 SoC
Message-ID: <20260902142734.GH1145425@bill-the-cat>
References: <20260821070345.138264-1-ansuelsmth@gmail.com>
 <20260902021814.GA1592625@bill-the-cat>
 <4716de2e-50b9-4b2b-803d-74f9d33e3fcd@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7v04OLt9QqQM83nd"
Content-Disposition: inline
In-Reply-To: <4716de2e-50b9-4b2b-803d-74f9d33e3fcd@iopsys.eu>
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


--7v04OLt9QqQM83nd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 02, 2026 at 11:59:49AM +0300, Mikhail Kshevetskiy wrote:

> Tom, could you use
>=20
> =A0
> https://lore.kernel.org/u-boot/20260902085311.1550804-1-mikhail.kshevetsk=
iy@iopsys.eu/
>=20
> instead of this patch?
>=20
> The above patch series based on the same commit, but provides much more
> complete an7583 support.
> Changes from above patch:
> =A0* fixed arch/arm/mach-airoha/an7583/init.c compilation issue
> =A0* added an7583 specific helper needed for clk-airoha
> =A0* patches for proper support of clk, reset, network

I will look at that series instead, thanks.

>=20
> Regards,
> Mikhail Kshevetskiy
>=20
> On 9/2/26 05:18, Tom Rini wrote:
> > On Fri, Aug 21, 2026 at 09:03:44AM +0200, Christian Marangi wrote:
> >
> >> Add support for Airoha AN7583 SoC. This adds the Kconfig and Makefile
> >> entry for the SoC, DTSI and initial config for it. Also add the code f=
or
> >> CPU and RAM initialization. Everything is mostly based on AN7581 that
> >> share lots of common piece.
> >>
> >> Acked-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> >> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >> ---
> >> Changes v2:
> >> - Rebase on top of next
> > I see:
> >    aarch64:  +   an7583_evb
> > +(an7583_evb) arch/arm/mach-airoha/an7583/init.c: In function 'dram_ini=
t_banksize':
> > +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:26:15: error: 'struct =
bd_info' has no member named 'bi_dram'
> > +(an7583_evb)    26 |         gd->bd->bi_dram[0].start =3D gd->ram_base;
> > +(an7583_evb)       |               ^~
> > +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:27:15: error: 'struct =
bd_info' has no member named 'bi_dram'
> > +(an7583_evb)    27 |         gd->bd->bi_dram[0].size =3D get_effective=
_memsize();
> > +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:30:23: error: 'struct =
bd_info' has no member named 'bi_dram'
> > +(an7583_evb)    30 |                 gd->bd->bi_dram[1].start =3D gd->=
ram_base + SZ_2G;
> > +(an7583_evb)       |                       ^~
> > +(an7583_evb) arch/arm/mach-airoha/an7583/init.c:31:23: error: 'struct =
bd_info' has no member named 'bi_dram'
> > +(an7583_evb)    31 |                 gd->bd->bi_dram[1].size =3D gd->r=
am_size - SZ_2G;
> > +(an7583_evb) make[3]: *** [scripts/Makefile.build:272: arch/arm/mach-a=
iroha/an7583/init.o] Error 1
> > +(an7583_evb) make[2]: *** [scripts/Makefile.build:497: arch/arm/mach-a=
iroha/an7583] Error 2
> > +(an7583_evb) make[1]: *** [Makefile:2221: arch/arm/mach-airoha] Error 2
> > +(an7583_evb) drivers/clk/airoha/clk-airoha.c:19:10: fatal error: asm/a=
rch/scu-regmap.h: No such file or directory
> > +(an7583_evb)    19 | #include <asm/arch/scu-regmap.h>
> > +(an7583_evb)       |          ^~~~~~~~~~~~~~~~~~~~~~~
> > +(an7583_evb) compilation terminated.
> > +(an7583_evb) make[4]: *** [scripts/Makefile.build:272: drivers/clk/air=
oha/clk-airoha.o] Error 1
> > +(an7583_evb) make[3]: *** [scripts/Makefile.build:497: drivers/clk/air=
oha] Error 2
> > +(an7583_evb) make[2]: *** [scripts/Makefile.build:497: drivers/clk] Er=
ror 2
> > +(an7583_evb) make[1]: *** [Makefile:2221: drivers] Error 2
> > +(an7583_evb) make: *** [Makefile:189: __sub-make] Error 2
> >     0    0    1 /1              an7583_evb
> >
> > When trying to build on current next, please look in to this, thanks.
> >

--=20
Tom

--7v04OLt9QqQM83nd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapgyVQAKCRAr4qD1Cr/k
CgYwAP0Yf/ftLypVbjLeUcmBnLvvVYMfTJxGd8VYMJCBJKNFQwEAmOTUojYCuIKA
kzA2HhLsOoodOw9w9r8qe3M6YARWPwg=
=m/X9
-----END PGP SIGNATURE-----

--7v04OLt9QqQM83nd--
