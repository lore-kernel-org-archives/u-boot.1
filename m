Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFCAC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D52768880B;
	Thu,  1 Aug 2024 16:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B+8/X4rB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BA8A8880B; Thu,  1 Aug 2024 16:20:28 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32869884BE
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-26109c97728so4277459fac.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722522023; x=1723126823; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x1hjWmZeT0RW0ZMNW1K1TnSt4FiDWQbrnxi8O3nIRCM=;
 b=B+8/X4rBTSuNFw/S8wcZDlPe/RgWCBVL6b9nYReb7WU5otilb0GT9aWKkUWbmRLy3X
 6O3GSldSGBDQ8K3dYiMKz6r7lrTucEz/3hxYm/5UPPhhdjpglatedusmH9PZ7gjsTbDE
 ZDam0IgEnWL0DOAPIQmMD+g2ppfdgmsPYiXIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722522023; x=1723126823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1hjWmZeT0RW0ZMNW1K1TnSt4FiDWQbrnxi8O3nIRCM=;
 b=oq3MXYUE5RQN7NEkf3ghRHBlA4w2ErO2uBDIMqrW45Oi/QeOPRjCdyzejolsTWhQJY
 foOUfzJHbj7MVaE7eW1+h+UIaJXpH726E9P74pQdP6j2P70sxOD5ouIm7Y/lzNW9bjGm
 PPnhUqzzepcjAqHrM/NVENfsMC2cXLWPNR9Qf1l7rUg1OCSGKfkZMRlv2V42AzN6FKBF
 0LJpfn9Dd0e8I3G+00Xax1SYdvwM+HJxN3U+3BKNuUw0Mv7Ovw0lwaUDxjacAiC/Su+d
 TqyELlsjlEOAFS22Am4LCemrb8H9ZNEyRLhwFZKnfsHjBEXY7O+OcD5EqvgdTFIz0Y6n
 Lw3w==
X-Gm-Message-State: AOJu0Yz619NIkDHCU2t6TKi+2fQnAtWq6GZEK6IaPZoqXk5MdAgi1R27
 dtySb+iKft1s937UDB/x9IPxcaIQMtjvdz3bvV60xV7NNZ525wgaZnG0REQAxyA=
X-Google-Smtp-Source: AGHT+IGDFxUc0ptck9Ro0qTCFgSpRQ2RDpAWVUXUVhWkIezE2eeWDCAOFzwb8nVU5KHNP//3+3uYIA==
X-Received: by 2002:a05:6870:41d2:b0:254:c777:6327 with SMTP id
 586e51a60fabf-26891e92eeamr302065fac.36.1722522022863; 
 Thu, 01 Aug 2024 07:20:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2653e446f07sm3108167fac.13.2024.08.01.07.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:20:22 -0700 (PDT)
Date: Thu, 1 Aug 2024 08:20:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, caleb.connolly@linaro.org,
 christophe.roullier@foss.st.com, epsi@gmx.de,
 eugen.hristev@collabora.com, festevam@gmail.com,
 forbidden405@outlook.com, ivprusov@salutedevices.com,
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com,
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org,
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org,
 n-francis@ti.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, philipp.tomsich@vrull.eu,
 rfried.dev@gmail.com, seanga2@gmail.com,
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com,
 sjg@chromium.org, sumit.garg@linaro.org, xypron.glpk@gmx.de, marex@denx.de
Subject: Re: [PATCH v3 0/5] net: dwc_eth_qos: Add glue driver for Intel MAC
Message-ID: <20240801142017.GA4041738@bill-the-cat>
References: <20240717122906.117861-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pGLkIFD5Oxl9jkjm"
Content-Disposition: inline
In-Reply-To: <20240717122906.117861-1-pro@denx.de>
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


--pGLkIFD5Oxl9jkjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 02:29:01PM +0200, Philip Oberfichtner wrote:

> This patch series implements the dwc_eth_qos glue driver for Intel SOCs.
> Before doing that, a few general adaptions to the dwc_eth_qos.c main
> driver are required. Most notably, the preparation for PCI based driver
> instances, which do not necessarily use a device tree.
>=20
> This patch series depends on: "net: dwc_eth_qos: mdio: Implement clause 4=
5":
> https://patchwork.ozlabs.org/project/uboot/patch/20240507094237.168238-1-=
pro@denx.de/
>=20
> Changes in V3:
> 	- Replace mfence() with mb()
> 	- Clean-up eqos_get_base_addr()
> 	- Several style fixes for dwc_eth_qos_intel

This adds a failure to build on stm32mp15_dhcor_basic and all of the
other stm32mp15 platforms that use this driver:
+(stm32mp15_dhcor_basic) drivers/net/dwc_eth_qos.c: In function 'eqos_get_b=
ase_addr_common':
+(stm32mp15_dhcor_basic) drivers/net/dwc_eth_qos.c:1415:30: error: format '=
%llx' expects argument of type 'long long unsigned int', but argument 2 has=
 type 'fdt_addr_t' {aka 'unsigned int'} [-Werror=3Dformat=3D]
+(stm32mp15_dhcor_basic)  1415 |                 dev_err(dev, "addr=3D0x%ll=
x is invalid.\n", addr);
+(stm32mp15_dhcor_basic)       |                              ^~~~~~~~~~~~~=
~~~~~~~~~~~~~~  ~~~~
+(stm32mp15_dhcor_basic)       |                                           =
                |
+(stm32mp15_dhcor_basic)       |                                           =
                fdt_addr_t {aka unsigned int}
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:51:24: note: in definit=
ion of macro 'dev_printk_emit'
+(stm32mp15_dhcor_basic)    51 |                 printf(fmt, ##__VA_ARGS__)=
; \
+(stm32mp15_dhcor_basic)       |                        ^~~
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:110:9: note: in expansi=
on of macro '__dev_printk'
+(stm32mp15_dhcor_basic)   110 |         __dev_printk(LOGL_ERR, dev, fmt, #=
#__VA_ARGS__)
+(stm32mp15_dhcor_basic)       |         ^~~~~~~~~~~~
+(stm32mp15_dhcor_basic) drivers/net/dwc_eth_qos.c:1415:17: note: in expans=
ion of macro 'dev_err'
+(stm32mp15_dhcor_basic)       |                 ^~~~~~~
+(stm32mp15_dhcor_basic) drivers/net/dwc_eth_qos.c:1415:41: note: format st=
ring is defined here
+(stm32mp15_dhcor_basic)       |                                      ~~~^
+(stm32mp15_dhcor_basic)       |                                         |
+(stm32mp15_dhcor_basic)       |                                         lo=
ng long unsigned int
+(stm32mp15_dhcor_basic)       |                                      %x
+(stm32mp15_dhcor_basic) In file included from include/linux/printk.h:4,
+(stm32mp15_dhcor_basic)                  from include/linux/kernel.h:5,
+(stm32mp15_dhcor_basic)                  from include/linux/libfdt_env.h:1=
3,
+(stm32mp15_dhcor_basic)                  from include/linux/libfdt.h:6,
+(stm32mp15_dhcor_basic)                  from include/fdtdec.h:17,
+(stm32mp15_dhcor_basic)                  from include/dm/ofnode.h:11,
+(stm32mp15_dhcor_basic)                  from include/clk.h:11,
+(stm32mp15_dhcor_basic)                  from drivers/net/dwc_eth_qos.c:32:
+(stm32mp15_dhcor_basic) include/log.h:224:24: note: in definition of macro=
 'log'
+(stm32mp15_dhcor_basic)   224 |                 printf(_fmt, ##_args); \
+(stm32mp15_dhcor_basic)       |                        ^~~~
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:86:17: note: in expansi=
on of macro 'dev_printk_emit'
+(stm32mp15_dhcor_basic)    86 |                 dev_printk_emit(LOG_CATEGO=
RY, level, fmt, ##__VA_ARGS__); \
+(stm32mp15_dhcor_basic)       |                 ^~~~~~~~~~~~~~~
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:55:24: note: in definit=
ion of macro 'dev_printk_emit'
+(stm32mp15_dhcor_basic)    55 |                 printf(fmt, ##__VA_ARGS__)=
; \
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:92:41: error: format '%=
llx' expects argument of type 'long long unsigned int', but argument 4 has =
type 'fdt_addr_t' {aka 'unsigned int'} [-Werror=3Dformat=3D]
+(stm32mp15_dhcor_basic)    92 |                                         "%=
s %s: " fmt, \
+(stm32mp15_dhcor_basic)       |                                         ^~=
~~~~~~~
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:91:25: note: in expansi=
on of macro 'dev_printk_emit'
+(stm32mp15_dhcor_basic)    91 |                         dev_printk_emit(__=
dev->driver->id, level, \
+(stm32mp15_dhcor_basic)       |                         ^~~~~~~~~~~~~~~
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:97:41: error: format '%=
llx' expects argument of type 'long long unsigned int', but argument 4 has =
type 'fdt_addr_t' {aka 'unsigned int'} [-Werror=3Dformat=3D]
+(stm32mp15_dhcor_basic)    97 |                                         "%=
s %s: " fmt, \
+(stm32mp15_dhcor_basic) include/dm/device_compat.h:96:25: note: in expansi=
on of macro 'dev_printk_emit'
+(stm32mp15_dhcor_basic)    96 |                         dev_printk_emit(LO=
G_CATEGORY, level, \
+(stm32mp15_dhcor_basic) cc1: all warnings being treated as errors
+(stm32mp15_dhcor_basic) make[3]: *** [scripts/Makefile.build:256: drivers/=
net/dwc_eth_qos.o] Error 1
+(stm32mp15_dhcor_basic) make[2]: *** [scripts/Makefile.build:397: drivers/=
net] Error 2
+(stm32mp15_dhcor_basic) make[1]: *** [Makefile:1895: drivers] Error 2
+(stm32mp15_dhcor_basic) make: *** [Makefile:177: sub-make] Error 2

--=20
Tom

--pGLkIFD5Oxl9jkjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmarmZ0ACgkQFHw5/5Y0
tyxVggv+Okmb8HLdPp1v5k1uzTCuW1Lr3VMy6xvnZH2hSBMTCkxjJ15cjaKgQEoq
DsCQ1Xyxnh86NwxdFYl4dNJotEOGsdFJ0BfcXhnoSLO86HxlUkuiSMqlgZTTLCSg
zZsdKKHape0PnxbbuCQHrpzcONZJ2Ns9bxVNmMIN0PLUznumD98vraysZApq94/9
8ZeaPUUD4alovIOCuJo3zUIpF/XGvjsggZfcCQ5a5XY4nETH2fKCJ7GDAf5OL/H9
r13HaDVY2FUqk5LNCEDsLb6w2hgxMe1DBKDBlYq2RgD5L9IuUv0Zaa+7ESagGMHL
u+K4zx0DVjyX4DAUkim+QdD3LurGRv15RhRSH6maAxBfauivwvp6ffD3/Wz7vEEK
cvSeSA1riK4vPgjcfb9yvMbD2LlQlaXYGQZ3WUaxLhFzwcH+4xGjBXa9hI3Ic6qW
B2KDRA/fdKEOQ8++846OxDi+cAOMBNRuVStfWe6hNMitDZ12PKigWXDfB2yLKIUr
uiYf5x82
=dl4r
-----END PGP SIGNATURE-----

--pGLkIFD5Oxl9jkjm--
