Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C86CA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 15:22:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D32BF82F03;
	Tue, 12 Aug 2025 17:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ctqlaHNE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7299583287; Tue, 12 Aug 2025 17:22:31 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4BEB82CEA
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 17:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-433f63d7803so1799198b6e.1
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755012147; x=1755616947; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qHYm5YX62urGnExGqn7oeaq/nuNCjA1B96q9gi6Pr2s=;
 b=ctqlaHNE3YHmOi12i/2dGat6zV4AjxlHNjOcGZiprYGeJa0O8FZUkAydCn+f/4VzN2
 tDOpvs6PQwvLckvVffzXTUrwervBdFtuiyDd6P+yyTyp8HhpBHrVPtoaU8rDmjge3Yhk
 EWnTlqU6Ixu0cjfvq9m1xvu3/c01rwEDq3f4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755012147; x=1755616947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHYm5YX62urGnExGqn7oeaq/nuNCjA1B96q9gi6Pr2s=;
 b=esqUqtb2pFJb949nTB8rBkf0/tURWHE8KTM1E88YFXmgDzLQACrjHr9LFyJWAFNZve
 cqXnj3dFWkHdmmLI7sruCYgT/PayHJXV1qPT5uS0mlnTOxLUe+mR3mxMc0ZQjzXrZkvc
 brJjfG80m1mo85XsmB1S3HRfNzGx620sDGT3yL9JLskG0GkhLdl+Jc7GkCJLkypG+/SJ
 9fIY77IYJXuYeFKfpk0U5EO+Rjpngfz9xRYE5NMC0LB1fZ680F5k2Tc5BDRlOYNxCQvE
 sFpGotULlIaghLR2NUa0gkiSZOPXVojldxbyRN9guKw0LHVvJkM6uR+707rHDZNLoX37
 j0vQ==
X-Gm-Message-State: AOJu0Yyd6RCwfQkyXdDhbnZIoSz7iP5znOOxpDBDxcrICHdPmoD5fBnY
 ICmTir7bMCulPAXNAwdwT/PXIpQBUjrDNpPg8+iTaqVwc4dCtyQQ1apFCSPJBzi4pQAKwQ4kR3i
 fmMcdmeE=
X-Gm-Gg: ASbGnctNo/OoXtL2eWpfkoE1/yxrp29w0+sQ95l6Embu7WY94sQXdL1jeLXZX7hWomc
 G5qzdl2neH0h70i6iv2ug0uCIvO5Q+3I/zlbMdS9ffGzR8IfWzq68Bqa0YbucCd3EgpGWQiYOyN
 vMpzyDXi4Sppzp3EPsCT8n2JkWokuKgNUVnZarMm3uBOlFgzqY3Udj7KlJ0ex5me8O4mQqvM6eU
 x0PdytPBpCFKPg6stacXuzYf8heuogE2ywsqx3JEUNcQl8xTC+DtXi/0H8m9KlMbsryV0TXHDa2
 xQtOiddTHs7bkCLjDmLZ8zE8souxO73BHysGeB7K+h8zyhQYYz1ydko5IBDsD9akZGNjC3O2bGm
 m1XhiDudhHNUbfJLiy6sHUOTk+nlBngi65qfEsXYqJ4IHsH1+lRmb6v5A
X-Google-Smtp-Source: AGHT+IGRgf+tmmpQGGrToA4IYIdppwg8u+B6mz3SZvuwlDYL1Gfov1TWqoOv3xZb3TRsKcBRxPY8bQ==
X-Received: by 2002:a05:6808:8957:b0:434:ee4:b95b with SMTP id
 5614622812f47-435c9259a86mr2561226b6e.39.1755012147459; 
 Tue, 12 Aug 2025 08:22:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ce6fe528sm212451b6e.7.2025.08.12.08.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 08:22:26 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:22:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com,
 heinrich.schuchardt@canonical.com, ben.dooks@codethink.co.uk,
 jamie.gibbons@microchip.com, sputnik@on-the-web.ch, michal.simek@amd.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250812152224.GT124814@bill-the-cat>
References: <aJr1oclCSUMcK3bb@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bp0ET7GURns2n8hF"
Content-Disposition: inline
In-Reply-To: <aJr1oclCSUMcK3bb@swlinux02>
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


--bp0ET7GURns2n8hF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 04:04:49PM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit acfacf452441d0a659e3afbd55fd6061aa17e6=
47:
>=20
>   Prepare v2025.10-rc2 (2025-08-11 13:47:46 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to bddcd6bcba081aaaaafe30d1b8f9f3c83f069bde:
>=20
>   starfive: fix return code of `mac write_eeprom` (2025-08-12 15:34:39 +0=
800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/27348
> ----------------------------------------------------------------
> - Board: mbv: Prepare MBV for CI
> - Board: MPFS Icicle Kit cleanup
> - Board: Add Andes Voyager board support
> - RISCV: Update SYS_BOOTM_LEN to commonly used value
> - starfive: fix return code of `mac write_eeprom`

So, there's a few problems here. First, checkpatch.pl finds spacing and
spelling issues, which I would normally just fixup in place. But second,
voyager_spl doesn't build:
   riscv64:  +   voyager_spl
+(voyager_spl) In file included from include/linux/printk.h:4,
+(voyager_spl)                  from include/linux/kernel.h:5,
+(voyager_spl)                  from include/linux/libfdt_env.h:13,
+(voyager_spl)                  from include/linux/libfdt.h:6,
+(voyager_spl)                  from include/fdtdec.h:17,
+(voyager_spl)                  from include/dm/ofnode.h:11,
+(voyager_spl)                  from include/dm/device.h:13,
+(voyager_spl)                  from include/dm.h:13,
+(voyager_spl)                  from common/spl/spl.c:13:
+(voyager_spl) common/spl/spl.c: In function 'spl_set_header_raw_uboot':
+(voyager_spl) common/spl/spl.c:281:27: error: format '%x' expects argument=
 of type 'unsigned int', but argument 2 has type 'long int' [-Werror=3Dform=
at=3D]
+(voyager_spl)   281 |                 log_debug("Default load addr %x (u_b=
oot_pos=3D%lx)\n",
+(voyager_spl)       |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~
+(voyager_spl) include/log.h:234:24: note: in definition of macro 'log'
+(voyager_spl)   234 |                 printf(_fmt, ##_args); \
+(voyager_spl)       |                        ^~~~
+(voyager_spl) common/spl/spl.c:281:17: note: in expansion of macro 'log_de=
bug'
+(voyager_spl)       |                 ^~~~~~~~~
+(voyager_spl) common/spl/spl.c:281:47: note: format string is defined here
+(voyager_spl)       |                                              ~^
+(voyager_spl)       |                                               |
+(voyager_spl)       |                                               unsign=
ed int
+(voyager_spl)       |                                              %lx
+(voyager_spl) cc1: all warnings being treated as errors
+(voyager_spl) make[3]: *** [scripts/Makefile.build:296: spl/common/spl/spl=
=2Eo] Error 1
+(voyager_spl) make[2]: *** [scripts/Makefile.xpl:547: spl/common/spl] Erro=
r 2
+(voyager_spl) make[1]: *** [Makefile:2358: spl/u-boot-spl] Error 2
+(voyager_spl) make: *** [Makefile:198: sub-make] Error 2

Please fix and re-submit, thanks.

--=20
Tom

--bp0ET7GURns2n8hF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtcLAAKCRAr4qD1Cr/k
CtywAQCpkEGeZNGk/VqMzHSkWInwKOJB57GvCRL9D/gOwyIy9gD+PcwPZIdhjdUM
J9CWjSnXH3hLPrwOBqChcIjbcvkHMgQ=
=bZ9e
-----END PGP SIGNATURE-----

--bp0ET7GURns2n8hF--
