Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A3C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 16:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2775A86A4B;
	Tue, 14 Nov 2023 17:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r2otqKHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67660871D0; Tue, 14 Nov 2023 17:23:35 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 468D486940
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 17:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1dd71c0a41fso3400187fac.2
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 08:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699979012; x=1700583812; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S0d7b9PvrHA+To22+/b7fGinFIWPIBLkF8f8rMIkbWE=;
 b=r2otqKHDfSqAWYvzTLYZXxEbMEr9IrKxdwwd8noH0FiAlx+j7LREIPlCBTkBGh+qjp
 6ykRtXFIOLy5QvihuzuGNVBr68QjZ6JIkJkv2U448agEWb0FpBjVggjtUNJHdJqqsedS
 fiAcCb/j0K439KA1aTyR4lzYhZCFJEbDjV44o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979012; x=1700583812;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0d7b9PvrHA+To22+/b7fGinFIWPIBLkF8f8rMIkbWE=;
 b=HWeg7jmsEkJo4MLfTUKH6G/rcYjFgLer9CvSgbBtyj0/SrGJeeoUSraXMcWXPb5AuF
 SqRrD5y97oL6rAN+DN924DKNtngsIW5yYrRYySH6INGQwxFU70YlPLev5+74DEFT5wy5
 GjYylS3pnj5AwbuIfM4mC5gj3TnwscYTWDRKjAVsRdIE3TpcxRAo0ft3BWofDEAdjR9V
 wgEjSRBsXzO1bOV38iEuTwvgKzbGMK4XpUY0x2qTD8pBond5nAI9a+YlNeisJo0F+iUE
 /rOuI7GxZlADtV8e5HMcTPTCj2/3PjOwvlhfPya7tgfBpz/OJK1iJVqpyKagtmsKxwnO
 XoCw==
X-Gm-Message-State: AOJu0Yxyn2s8FATbB+Itdj0sgu8bBwXhygrG1l9FqemX6M3/N9mrTPGc
 64G6Cw2gm3J4CIN7LtQE8yg09g==
X-Google-Smtp-Source: AGHT+IE8ufhmdmKPfz77rK5ZPozR7Jl5SdM1U3tv/cJv4wdyt4sNXrumNcrheSN7ds8VIQtMOi2M2w==
X-Received: by 2002:a05:6871:5289:b0:1d6:cbcd:80f8 with SMTP id
 hu9-20020a056871528900b001d6cbcd80f8mr14457008oac.54.1699979011893; 
 Tue, 14 Nov 2023 08:23:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2a5c-a31a-8ead-8e73.res6.spectrum.com.
 [2603:6081:7b00:6400:2a5c:a31a:8ead:8e73])
 by smtp.gmail.com with ESMTPSA id
 h21-20020ac85055000000b00419b67d2823sm2821500qtm.34.2023.11.14.08.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 08:23:31 -0800 (PST)
Date: Tue, 14 Nov 2023 11:23:29 -0500
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/4] fix/add npcm845 serial and board error
Message-ID: <20231114162329.GV6601@bill-the-cat>
References: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iLmwLCEniABAwMBb"
Content-Disposition: inline
In-Reply-To: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
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


--iLmwLCEniABAwMBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2023 at 04:51:55PM +0800, Jim Liu wrote:

> 1. Fix serial error and add bypass serial setting.
> 2. Fix/Add dts node node.
> 3. Add full function defconfig
>=20
> Jim Liu (4):
>   arm: dts: npcm845-evb: fix/add node and aliases
>   configs: arbel: Enable full functions
>   serial: npcm: support skip uart clock setting
>   board: nuvoton: update console environment variable
>=20
>  arch/arm/dts/nuvoton-common-npcm8xx.dtsi      | 11 ++-
>  arch/arm/dts/nuvoton-npcm845-evb.dts          | 29 ++++++--
>  arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi      |  2 +-
>  board/nuvoton/arbel_evb/Kconfig               |  1 +
>  board/nuvoton/arbel_evb/arbel_evb.c           |  7 ++
>  board/nuvoton/common/Kconfig                  |  9 +++
>  board/nuvoton/common/Makefile                 |  1 +
>  board/nuvoton/common/uart.c                   | 71 +++++++++++++++++++
>  board/nuvoton/common/uart.h                   | 11 +++
>  board/nuvoton/poleg_evb/Kconfig               |  1 +
>  board/nuvoton/poleg_evb/poleg_evb.c           |  8 +++
>  configs/arbel_evb_defconfig                   | 16 ++++-
>  drivers/serial/serial_npcm.c                  | 39 ++++++----
>  include/dt-bindings/phy/nuvoton,npcm-usbphy.h | 14 ++++
>  14 files changed, 194 insertions(+), 26 deletions(-)
>  create mode 100644 board/nuvoton/common/Kconfig
>  create mode 100644 board/nuvoton/common/Makefile
>  create mode 100644 board/nuvoton/common/uart.c
>  create mode 100644 board/nuvoton/common/uart.h
>  create mode 100644 include/dt-bindings/phy/nuvoton,npcm-usbphy.h

I just want to make sure now that you've given this series a compile and
boot test on some platform, yes? Thanks.

--=20
Tom

--iLmwLCEniABAwMBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVTnwEACgkQFHw5/5Y0
tywK4gv+Isniy8dTUG/DjS2hV8RLiwZv89MmIZr6E8TJp2/hl/bThu5mb+4LbKfj
kVwHht6zj0bl8GntI1ZDjVFOygX/VatxKcGJ6ZETqo0RXVCw6qDw0eeWtBkg/vcq
FQLxpqnswGhC1XrFPpKYWjSjSslf2oHXHJ1aRN9CXKdH3FF7tFNBrdNDtZ0sVhD8
oiGz/rXWRTfLvVZHY5vUKiUffKuvbiOAU9SD/nXK05b3u2MQ3roHDX3tumN9gDCc
lqsAD6L4VM1qVwNja3VjkSGZYd7feumEwaFdyCIrBMht+Ai2XUV7dIXS5qyTwnzZ
qh3h6Q72OIfzmarYeFABJZ01c9Jl6NJkuelHvGD+Wp3N2U+OZRNIXT8u+0rRGWNC
97kfQaDLOKKZfo6PgjEPNQnLQ2dzMdrb7/+pt1BRHcOjcqHtPTNQOBLi+L1eh0WF
Xbg8WjSP7bbLg3biqgAG/0BS2Typax7cqUDZ5YoR5QHr1xSv3FE5KYgRDIkavkFd
AtSnO3yq
=rgvV
-----END PGP SIGNATURE-----

--iLmwLCEniABAwMBb--
