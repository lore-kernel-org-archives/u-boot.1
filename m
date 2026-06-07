Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6CBCD8C8E
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 14:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D983C8063E;
	Sun,  7 Jun 2026 16:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VkrJSRVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF0783EF9; Sun,  7 Jun 2026 16:55:50 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34227801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 16:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e71dd64ea2so610694a34.3
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780844147; x=1781448947; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/rBz2BQizuoty7kLsmBdAZHGSCVLlfSta2ypql8yWYc=;
 b=VkrJSRVNSkzaTqun/bkScjeL4Rs1pJH9OL9mWupr8st0aaZRh3eooepGGDCBGNIQXd
 qDl01/SzhTT1Vkj1H4FcfOCZ/7YLUbf8U+XoD9xuGis07zXmluILMYkWXp7vB1NGvNzi
 Xn3gnhUd4qWzYhauc99oc5CjLASzm7vZrsP8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780844147; x=1781448947;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/rBz2BQizuoty7kLsmBdAZHGSCVLlfSta2ypql8yWYc=;
 b=WB+iSdfl1uFL7y0OMa6EykhweeapL6kNvhplPjnb/D/XC1teMTvFF9Rts403rnZ0Xj
 isxY5OlNSKy44tYrE4fuGwtSQi9KC4+rxtcR9iqVjkzpPL0iZX3h7X9mC6Vn/SUhONHA
 i1yG2iJmk1bVd/kd71CQB4RUSPstgZTbKpAQJ4q0x6zTCZZIvyXajXlKrUgtuN4M3YZL
 H49gaHCODMeTGMf+QxqXtGGW9+tQ0jVr0W9WzUyZuo64RtUQI5+eSz6Lr32wmufsN/Ae
 6J2JEVdDgka2RHWzH9S6A6gfkT4/gMFcj/PaVPw3/aoZ9qgoWcgcJOL4Y1PGCraJ0sMB
 rYrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JA1ojdielUSy9aIDh3yTuAgC9NRWf7wwnUy16lWPua11Wsm9VajCCIWq2dLGEsH2urBKnN5Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzRWAbuqeMWtEa9SaUd5BP0VEV1RA2vQaBas2Bzpd/TWQlzXqiy
 i0PZSbfAxDwzWqM2mVZlNvhfSBXL5Y12J9nUkwvHLZePA2SeU6Cw+spI9uu0HuLnAhRl7aRP9kc
 rdfC+CTA=
X-Gm-Gg: Acq92OGsy8d4LnS4YUQwUhkiFAPgOmlHHzZVj6Cy87y6oGVphrJIFH+dJfdQQIiTKYx
 H2L1lrf6C8jukkpOBA04xtS3MNGbFk1sWLqm+oDOswa+eLjlOcVxzD0WTqtx/Q64K9y45MsZg0y
 mQUs5wrkCpZVUVreu2l9+o8IuW7rUH28oLjzG6MxRQU834aDLkpBQFqpdZ7jxQ84l28oWCYWYGo
 8kkPr8e4aWiu7sND8E7Et3oKb7FBv4uZnR6gZI1aAkmt4hU07F904YBdwCfW2oSLniZYngZGRCx
 guKFlR2RejxmGwSClwxCxxim0s6Pgowak5QPK8nBjh1qDALGQpirJZNFxEgZ/G4I5fIsFS6jYFF
 1Rl+dYLEBTRKG18+di8y9evfLeh5Sey0k2aRr70Hq66bn1ahZYu9XjODgg35UTS24cunTeLGvsL
 y950HHPLkjlIMAs5Xwb4h/jt/mjR2GBKUUyf/H+rYwqYFlz+ajKw90huaOLsx0bxp6LcpgzEbPE
 Oj/UrF6reE7bVO+4q9ebYgjyPE1OoPREVdGuQNDCwHw82Pf9YldhyQy6PAmnA==
X-Received: by 2002:a05:6830:2b1e:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-7e70c4266ebmr7601319a34.0.1780844146916; 
 Sun, 07 Jun 2026 07:55:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e7f9csm10410891a34.17.2026.06.07.07.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 07:55:46 -0700 (PDT)
Date: Sun, 7 Jun 2026 08:55:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCH] xyz-modem: Select CRC16
Message-ID: <20260607145544.GD382693@bill-the-cat>
References: <20260607025650.3599544-1-daniel@thingy.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JAJIS1AXiAAIr62m"
Content-Disposition: inline
In-Reply-To: <20260607025650.3599544-1-daniel@thingy.jp>
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


--JAJIS1AXiAAIr62m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2026 at 11:56:50AM +0900, Daniel Palmer wrote:

> CONFIG_LOADB causes the xyzModem code to get built and that code depends
> on CONFIG_CRC16. If you don't have something else that selects CONFIG_CRC=
16
> you can unselect it and then the final link will fail:
>=20
>   LD      u-boot
> /usr/bin/m68k-linux-gnu-ld.bfd: common/xyzModem.o: in function `xyzModem_=
get_hdr':
> u-boot/common/xyzModem.c:388:(.text.xyzModem_get_hdr+0x17a): undefined re=
ference to `crc16_ccitt'
>=20
> Since SPL/TPL can also use the xyzModem code create a Kconfig symbol for
> it, select CONFIG_CRC16 there and then select the new symbol from all of
> the users.
>=20
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> ---
>  cmd/Kconfig            | 1 +
>  common/Kconfig         | 6 ++++++
>  common/Makefile        | 3 +--
>  common/spl/Kconfig     | 1 +
>  common/spl/Kconfig.tpl | 1 +
>  5 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index c71c6824a196..7e6044bad952 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1412,6 +1412,7 @@ config CMD_W1
>  config CMD_LOADB
>  	bool "loadb"
>  	default y
> +	select YMODEM
>  	help
>  	  Load a binary file over serial line.
> =20
> diff --git a/common/Kconfig b/common/Kconfig
> index 8e8c733aa295..5eafe05047dc 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -1274,3 +1274,9 @@ config IO_TRACE
>  	  confirm that the driver behaves the same way before and after a code
>  	  change. To add support for your architecture, add '#include
>  	  <iotrace.h>' to the bottom of arch/<arch>/include/asm/io.h and test.
> +
> +config YMODEM
> +	bool
> +	select CRC16
> +	help
> +	  Enable xyzModem library code
> diff --git a/common/Makefile b/common/Makefile
> index d62ea34599ed..bd809e2f34e9 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -99,8 +99,7 @@ obj-$(CONFIG_$(PHASE_)LOG) +=3D log.o
>  obj-$(CONFIG_$(PHASE_)LOG_CONSOLE) +=3D log_console.o
>  obj-$(CONFIG_$(PHASE_)LOG_SYSLOG) +=3D log_syslog.o
>  obj-y +=3D s_record.o
> -obj-$(CONFIG_CMD_LOADB) +=3D xyzModem.o
> -obj-$(CONFIG_$(PHASE_)YMODEM_SUPPORT) +=3D xyzModem.o
> +obj-$(CONFIG_YMODEM) +=3D xyzModem.o
> =20
>  obj-$(CONFIG_$(PHASE_)AVB_VERIFY) +=3D avb_verify.o
>  obj-$(CONFIG_$(PHASE_)STACKPROTECTOR) +=3D stackprot.o
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 5fa94098e498..2bd413cbdf12 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1655,6 +1655,7 @@ config SPL_WATCHDOG
>  config SPL_YMODEM_SUPPORT
>  	bool "Support loading using Ymodem"
>  	depends on SPL_SERIAL
> +	select YMODEM
>  	help
>  	  While loading from serial is slow it can be a useful backup when
>  	  there is no other option. The Ymodem protocol provides a reliable
> diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
> index a535b61ecd35..7ab4666d3705 100644
> --- a/common/spl/Kconfig.tpl
> +++ b/common/spl/Kconfig.tpl
> @@ -336,6 +336,7 @@ config TPL_DM_SPI_FLASH
>  config TPL_YMODEM_SUPPORT
>  	bool "Support loading using Ymodem"
>  	depends on TPL_SERIAL
> +	select YMODEM
>  	help
>  	  While loading from serial is slow it can be a useful backup when
>  	  there is no other option. The Ymodem protocol provides a reliable

Good catch. But, as the Makefile hunk shows, we should be using
$(PHASE_) here for everything, so we need to add YMODEM_SUPPORT as a
main U-Boot symbol (CND_LOADB should select that) and the existing
xPL_YMODEM_SUPPORT should also select CRC16/xPL_CRC16 (so we're missing
TPL_CRC16, but have SPL_CRC16). Thanks!

--=20
Tom

--JAJIS1AXiAAIr62m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiWGbAAKCRAr4qD1Cr/k
CuWEAP9DDQCyDeHePbigPHrkPJYPeeuF5mqxMIDWanjvi8SNdQD/cZnS7AG+KBUr
5D1aLMS9NR5ZRHI3VBQIAZ2I+Z+NQQs=
=yqWj
-----END PGP SIGNATURE-----

--JAJIS1AXiAAIr62m--
