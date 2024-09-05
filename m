Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F33CE7AA0
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 22:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8437688CC8;
	Fri,  6 Sep 2024 00:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bi7leLc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B7888CC2; Fri,  6 Sep 2024 00:02:46 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCFA9885A8
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 00:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4567cdf32d8so8208591cf.1
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725573761; x=1726178561; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Aw17wjPKJ0CdKuoTn0vR60B7yUy892ZBnMXH3dYifEc=;
 b=bi7leLc3+46EchGqDD1mYwuR45roKNK2hdpsAKw+kuyY5BmcK+HVa4bHfCWDoyaR7/
 hvgkKyMbPuau0kEVXS6jmnxds7q1KXK17gVdcTxFgRXAnoxrBQHqjoc5HlL5kjDmsmhv
 izaDWVpowPD55LkWF4m16BQYwWzhxnjBIYLnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725573761; x=1726178561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aw17wjPKJ0CdKuoTn0vR60B7yUy892ZBnMXH3dYifEc=;
 b=j+FqakaIeWtyK2V1NGRsHwKA+9FT4WAj8KYlI/6xgjTHbXFt146mlYhHWjNzVHhoEh
 HYYAK0zG2We6i8fdBtytk0TFzZAJizilFA/LOw6NrvxPKVo92uLRkBAiqE87NshYxstc
 J3i1eOC6UALpCbHYGlSZqY6YED+Qz4j/VmGUmfiovm1ZhFjz4O96g46p9DIEIFOsvN6D
 Ni+L1dpbJZxiqI5CDyE/wGpSPxv9vhkaYuA2TpftyrX/IwzcdwUHtOk9LNjSvpwO+Egl
 CfEHAB6wSuRmbWzZQITC4lLF3kq0YK2NzwtQXsWQk20Ouk9FMU/l0gVqDs6UJ1qO478D
 6qLw==
X-Gm-Message-State: AOJu0YwxADfJhVqp2D/rd+BBrLLn8urBWAv85JYevMoQeuWEhPriPwBL
 P6BqWczmE102mNHqY61UpPXKqBTLMsQr+2zGvfulBY6Z6YszzifimnbylRGX3KU=
X-Google-Smtp-Source: AGHT+IFxiW/m9uWlpr2G2FiI4I97NWmLE8Q4FP7gKKmUyrkZWSNEweNl6W08cMtGtvConzZiRi+PAg==
X-Received: by 2002:a05:6214:3a07:b0:6c3:4f56:475b with SMTP id
 6a1803df08f44-6c5284f4dcdmr8349686d6.15.1725573761307; 
 Thu, 05 Sep 2024 15:02:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201defefsm11250736d6.6.2024.09.05.15.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 15:02:40 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:02:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5] mmc: Poll CD in case cyclic framework is enabled
Message-ID: <20240905220237.GA1823175@bill-the-cat>
References: <20240616145857.26833-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PSvPEPiIgWfvuPHN"
Content-Disposition: inline
In-Reply-To: <20240616145857.26833-1-marek.vasut+renesas@mailbox.org>
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


--PSvPEPiIgWfvuPHN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 04:58:49PM +0200, Marek Vasut wrote:

> In case the cyclic framework is enabled, poll the card detect of already
> initialized cards and deinitialize them in case they are removed. Since
> the card initialization is a longer process and card initialization is
> done on first access to an uninitialized card anyway, avoid initializing
> newly detected uninitialized cards in the cyclic callback.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
> V2: Move the cyclic registration/unregistration into mmc init/deinit
> V3: Replace if (CONFIG_IS_ENABLED(CYCLIC)...) with #if as the former
>     does not work with structure members
> V4: Stuff the code with CONFIG_IS_ENABLED() variants to avoid #ifdefs
> V5: Rebase on u-boot/next

Sorry for the delay here, this no longer builds:
   sandbox:  +   sandbox
+(sandbox) drivers/mmc/mmc.c: In function =E2=80=98mmc_init=E2=80=99:
+(sandbox) drivers/mmc/mmc.c:3081:56: error: passing argument 1 of =E2=80=
=98cyclic_register=E2=80=99 from incompatible pointer type [-Werror=3Dincom=
patible-pointer-types]
+(sandbox)  3081 |                         (mmc->cyclic =3D cyclic_register=
(mmc_cyclic_cd_poll,
+(sandbox)       |                                                        ^=
~~~~~~~~~~~~~~~~~
+(sandbox)       |                                                        |
+(sandbox)       |                                                        v=
oid (*)(void *)
+(sandbox) include/linux/kconfig.h:97:23: note: in definition of macro =E2=
=80=98__unwrap=E2=80=99
+(sandbox)    97 | #define __unwrap(...) __VA_ARGS__
+(sandbox)       |                       ^~~~~~~~~~~
+(sandbox) include/linux/kconfig.h:95:26: note: in expansion of macro =E2=
=80=98__unwrap1=E2=80=99
+(sandbox)    95 | #define ___concat(a, b)  a ## b
+(sandbox)       |                          ^
+(sandbox) include/linux/kconfig.h:102:46: note: in expansion of macro =E2=
=80=98__CONFIG_IS_ENABLED_3=E2=80=99
+(sandbox)   102 | #define __CONFIG_IS_ENABLED_2(option, case1) __CONFIG_IS=
_ENABLED_3(option, case1, ())
+(sandbox)       |                                              ^~~~~~~~~~~=
~~~~~~~~~~
+(sandbox) include/linux/kconfig.h:95:26: note: in expansion of macro =E2=
=80=98__CONFIG_IS_ENABLED_2=E2=80=99
+(sandbox) drivers/mmc/mmc.c:3080:17: note: in expansion of macro =E2=80=98=
CONFIG_IS_ENABLED=E2=80=99
+(sandbox)  3080 |                 CONFIG_IS_ENABLED(CYCLIC,
+(sandbox)       |                 ^~~~~~~~~~~~~~~~~
+(sandbox) In file included from include/asm-generic/global_data.h:24,
+(sandbox)                  from arch/sandbox/include/asm/global_data.h:26,
+(sandbox)                  from include/dm/of.h:10,
+(sandbox)                  from include/dm/ofnode.h:12,
+(sandbox)                  from include/dm/device.h:13,
+(sandbox)                  from include/dm.h:13,
+(sandbox)                  from drivers/mmc/mmc.c:13:
+(sandbox) include/cyclic.h:63:42: note: expected =E2=80=98struct cyclic_in=
fo *=E2=80=99 but argument is of type =E2=80=98void (*)(void *)=E2=80=99
+(sandbox)    63 | void cyclic_register(struct cyclic_info *cyclic, cyclic_=
func_t func,
+(sandbox)       |                      ~~~~~~~~~~~~~~~~~~~~^~~~~~
+(sandbox) In file included from <command-line>:
+(sandbox) drivers/mmc/mmc.c:3082:56: error: passing argument 2 of =E2=80=
=98cyclic_register=E2=80=99 makes pointer from integer without a cast [-Wer=
ror=3Dint-conversion]
+(sandbox)  3082 |                                                        1=
00 * 1000,
+(sandbox)       |                                                        ^=
~~~~~~~~~
+(sandbox)       |                                                        i=
nt
+(sandbox) include/cyclic.h:63:64: note: expected =E2=80=98cyclic_func_t=E2=
=80=99 {aka =E2=80=98void (*)(struct cyclic_info *)=E2=80=99} but argument =
is of type =E2=80=98int=E2=80=99
+(sandbox)       |                                                  ~~~~~~~=
~~~~~~~^~~~
+(sandbox) drivers/mmc/mmc.c:3083:64: error: passing argument 3 of =E2=80=
=98cyclic_register=E2=80=99 makes integer from pointer without a cast [-Wer=
ror=3Dint-conversion]
+(sandbox)  3083 |                                                        m=
mc->cfg->name, mmc)));
+(sandbox)       |                                                        ~=
~~~~~~~^~~~~~
+(sandbox)       |                                                         =
       |
+(sandbox)       |                                                         =
       const char *
+(sandbox) include/cyclic.h:64:31: note: expected =E2=80=98uint64_t=E2=80=
=99 {aka =E2=80=98long long unsigned int=E2=80=99} but argument is of type =
=E2=80=98const char *=E2=80=99
+(sandbox)    64 |                      uint64_t delay_us, const char *name=
);
+(sandbox)       |                      ~~~~~~~~~^~~~~~~~
+(sandbox) drivers/mmc/mmc.c:3083:72: error: passing argument 4 of =E2=80=
=98cyclic_register=E2=80=99 from incompatible pointer type [-Werror=3Dincom=
patible-pointer-types]
+(sandbox)       |                                                         =
               ^~~
+(sandbox)       |                                                         =
               |
+(sandbox)       |                                                         =
               struct mmc *
+(sandbox) include/cyclic.h:64:53: note: expected =E2=80=98const char *=E2=
=80=99 but argument is of type =E2=80=98struct mmc *=E2=80=99
+(sandbox)       |                                         ~~~~~~~~~~~~^~~~
+(sandbox) drivers/mmc/mmc.c:3081:38: error: void value not ignored as it o=
ught to be
+(sandbox)       |                                      ^
+(sandbox) cc1: all warnings being treated as errors
+(sandbox) make[3]: *** [scripts/Makefile.build:256: drivers/mmc/mmc.o] Err=
or 1
+(sandbox) make[2]: *** [scripts/Makefile.build:397: drivers/mmc] Error 2
+(sandbox) make[1]: *** [Makefile:1897: drivers] Error 2
+(sandbox) make: *** [Makefile:177: sub-make] Error 2
=20
--=20
Tom

--PSvPEPiIgWfvuPHN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbaKnYACgkQFHw5/5Y0
tyzh0gv7BX/ZCSzFiueb8ZMIesZgiEkE/T32QKCLQ9YvPioyCS6Rx3Z8rTQKnMaa
USiuMnj0/gVFDXU6oP8feEn5+hyz2xAOqS+9dux8RsqwcqPgbre3NKlSFUTLg5QS
aFIQgEMgvQC4askDOO02sGNKjveoWF+ozhiVlHupn7m9rOlKGvA188MMPTQkU0U6
/TFk1B4U7tBYURFZVTP4LMxNWx30aMIKsRpqR98DXu2ru4uVh1AA9yEmPyqAIm9F
8BOEqqaVnaoD8t+phsf1BIvZ31aLGGN1geVBQHFUKPcz2ARnVTnyV6Qti6j2z0bs
9dBDMUQeIYnLbF3asxDZhWDBwjvZe2zpLeTuXWfZbKMMNF6R6jdBBLdTqcw+qiEK
tdiB5GaA2bmwCmfCMu758hDLQzYln0t3Ve6KVVx6I4Ej0xnVX1SiyMuRRAZBqkFh
kh4edNmTUPHFepwZ5mBdgOGkpi2rQRpq6bG/v7vzUqM5+1bjjp626n2QMelJX4z+
HZ/OV2Xq
=zv2O
-----END PGP SIGNATURE-----

--PSvPEPiIgWfvuPHN--
