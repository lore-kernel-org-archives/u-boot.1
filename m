Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845BFC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B2E48647D;
	Mon, 28 Aug 2023 17:18:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="UzIUZcx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458C5864C4; Mon, 28 Aug 2023 17:18:55 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBB4846B8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:18:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fee8af9cb9so31276905e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693235932; x=1693840732; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pHargzU823OnEbh4qq9+35GYPA+cYRDFtF9kXf4ofJ8=;
 b=UzIUZcx079sS7MqiKG12atQVH2LnXXAs8Jm3uJr+NSkchzbZnKj9xChyZQOhKFJLlg
 7HxediJ0aJdtVf3wT0FoGyobBxXReAQ5fQDALu7L8OaquoTQtPW8lkafrCbERnACmHnu
 0wzjP1vGG0e6gQDEPXg71PeHiLEk1JBrNbjXO+htj8zFb5PfUEFQvvoqPrgoLvHPcAvR
 QOn2MYBT9e8TlsjKErWNOCspqtsqaCI1S7UtHIpaHfkELlZYhnNtUqB8EY5+pOy9oQYi
 UZuKbhQpCAj5JfJUK3A+jWIpEDBzHrtjyio/3mxRNemf2GE5j/CXHiLRNEwT8I50Ffl7
 cfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693235932; x=1693840732;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHargzU823OnEbh4qq9+35GYPA+cYRDFtF9kXf4ofJ8=;
 b=i0BCp6XcIDaAZNITT2a7SxpyNQaQkfYXsh/p2nUSv6ZRYdGMMwTOPjLlpmdfQov9yC
 6JAt10G30i68vcD3+oNFA/xlA613rkpoo0aR0yxbAZ34+/10hx1rvrOOIpG99jS99Acl
 JwhoZbxGNCf1AaA4Q44W0v0zpGHR2aHCZAOOoKFDj05ZzRG88trY8Be00dIFyCWNuDuW
 dnzsyC6DY/b2YE3luiqknA5PYurFFp4evPF4dNlQddv1QtAJXKwlRBVRfgAjgpeDqZ27
 sLT7j0APYQvCynG1mXjztZDvEwmyZlgjngSgn55mJ31CiaSY8YjtkksW0SC1TOryB79L
 McXw==
X-Gm-Message-State: AOJu0YwgjoroPkK5Psxz56ccUuv7RkGrJGErfJwxJqvePbJt0pzSWapN
 woiYcyK7GBa05sKwHopg1WYb8g==
X-Google-Smtp-Source: AGHT+IGpm84W3supY0xl5dnZXnqyvvAbgZjRDZJC6ncNWpsnkPj5B7W7Qt2IAhkzkg6zigrxNCy0zQ==
X-Received: by 2002:a05:600c:3486:b0:3fb:c9f4:1506 with SMTP id
 a6-20020a05600c348600b003fbc9f41506mr20060675wmq.1.1693235932277; 
 Mon, 28 Aug 2023 08:18:52 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c210b00b003fe2b081661sm14256705wml.30.2023.08.28.08.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:18:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 01/20] include: env: ti: mmc: envboot/mmcboot: Check
 result of mmc dev before proceeding
In-Reply-To: <20230825180305.69515-2-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-2-nm@ti.com>
Date: Mon, 28 Aug 2023 17:18:51 +0200
Message-ID: <87msybw5yc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On ven., ao=C3=BBt 25, 2023 at 13:02, Nishanth Menon <nm@ti.com> wrote:

> If mmc dev reports that the device is not present, there is no point in
> proceeding further to attempt to load the files.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> new patch -  noticed a series of 'MMC: no card present' in boot log
> and was wondering why, now I know - shaves off 2 seconds or so into boot
> process.
>
>  include/env/ti/mmc.env | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
> index 6fb47fb26673..b8eb51ca1744 100644
> --- a/include/env/ti/mmc.env
> +++ b/include/env/ti/mmc.env
> @@ -15,7 +15,7 @@ loadbootenv=3Dfatload mmc ${mmcdev} ${loadaddr} ${boote=
nvfile}
>  loadimage=3Dload ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfil=
e}
>  loadfdt=3Dload ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfil=
e}
>  get_fdt_mmc=3Dload mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${name_fdt}
> -envboot=3Dmmc dev ${mmcdev};
> +envboot=3Dif mmc dev ${mmcdev}; then
>  	if mmc rescan; then
>  		echo SD/MMC found on device ${mmcdev};
>  		if run loadbootscript; then
> @@ -31,6 +31,7 @@ envboot=3Dmmc dev ${mmcdev};
>  			fi;
>  		fi;
>  	fi;
> +  fi;
>  mmcloados=3D
>  	if test ${boot_fdt} =3D yes || test ${boot_fdt} =3D try; then
>  		if run get_fdt_mmc; then
> @@ -45,7 +46,7 @@ mmcloados=3D
>  	else
>  		bootz;
>  	fi;
> -mmcboot=3Dmmc dev ${mmcdev};
> +mmcboot=3Dif mmc dev ${mmcdev}; then
>  	devnum=3D${mmcdev};
>  	devtype=3Dmmc;
>  	if mmc rescan; then
> @@ -58,7 +59,8 @@ mmcboot=3Dmmc dev ${mmcdev};
>  				run mmcloados;
>  			fi;
>  		fi;
> -fi;
> +	fi;
> +  fi;
>=20=20
>  init_mmc=3Drun args_all args_mmc
>  get_overlay_mmc=3D
> --=20
> 2.40.0
