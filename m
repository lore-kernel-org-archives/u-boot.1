Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E357C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F28086505;
	Mon, 28 Aug 2023 17:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="extIHpWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F8A86515; Mon, 28 Aug 2023 17:27:04 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B315B864D8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so2765287f8f.0
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236421; x=1693841221; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8a391nyts/XUqasnTn7bUdk5lGzlJQynmFAF5upK+g=;
 b=extIHpWp0QutuxmH2/zxSPhZUWvf7Vy78SGWwYjlMy3AmQrYc4kwIebv9rm49DrATF
 VOE+4+p6FpyBCkL+rvEyu+/yoTcYZSW5MHIpwCrQ83+E+hZ3oS60gWtsk89Y6R072N8i
 6CrHM2veBwA5hGON703PFesdiWpqZfTmIJaaDGZ4pnjfLUFXVpHI9YmlgihMi3D25T85
 Jg9twA53th7yPq/vZhwtD8T9/pFz/T6QAWOQfLdW3LPZMsTWx7/8AESPOpsrByrQQnNf
 LDKlG87+OZGOWE7uQwyP96ei9VI5boMBaYeiJrL80y+kP8sd6bhp/B2iWGHKdVqVBImm
 KbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236421; x=1693841221;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8a391nyts/XUqasnTn7bUdk5lGzlJQynmFAF5upK+g=;
 b=CM+RgjCjRZhK8zzQUvjWE40rQxcReCSclZcpIElVYiOgixFuWQel9DBAz9R+ISI+IN
 FeXHI3AlHZiO3NU+LMGEIVreF8XvZn76DUB0x0AQlJfs3f7wRJw4NsG5bE9GjWtxpRU6
 EJugo7JYvDbNq6QXsQmPPVzBSYWKNJzQ2MdlPSXTPBOXf5t4kuZssqPH+Ke/OTdV1yEK
 KBQE7Baz04zyPXXB2+PM2EcGYWrKGFWeDxy1KivVB/kN+BFsIqaSCn6TkYIgo6R63vdi
 UWz0doPoQlQkesNUb/AxyNWt7iGuds+UYPBXqhM6n1FSWkjtctBPGF3Ew+x5ikOQHpGy
 5Pfg==
X-Gm-Message-State: AOJu0YznCvvoZA0Wv9Il2QmfKYnnwc4PtJ+oBI/Wz+m9wKjgn9LdONS+
 ZcURQsnD18OhvrKjpcyt2kky3Q==
X-Google-Smtp-Source: AGHT+IFcmmIh3LyAL3ucwA0gsBZoKXxdl1GFFAWYXNQWUjqdJAAvLOYQtBJi+3f18c8KOjDclhxrxQ==
X-Received: by 2002:adf:ec8a:0:b0:319:790e:3bc5 with SMTP id
 z10-20020adfec8a000000b00319790e3bc5mr19774171wrn.41.1693236421061; 
 Mon, 28 Aug 2023 08:27:01 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c22d900b00401c944b7adsm4516348wmg.26.2023.08.28.08.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:27:00 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 04/20] include: configs: am62x_evm: Drop unused SDRAM
 address
In-Reply-To: <20230825180305.69515-5-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-5-nm@ti.com>
Date: Mon, 28 Aug 2023 17:27:00 +0200
Message-ID: <87h6ojw5kr.fsf@baylibre.com>
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

> Drop unused macro. This was meant for a second region of DDR which we
> do not need for AM62x evm configurations.
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> No change other than picking up reviews, tested tags along the way.
>
> V5: https://lore.kernel.org/r/20230824031101.3460411-3-nm@ti.com
>  include/configs/am62x_evm.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
> index 44180dc7687b..379e0c13a395 100644
> --- a/include/configs/am62x_evm.h
> +++ b/include/configs/am62x_evm.h
> @@ -12,9 +12,6 @@
>  #include <config_distro_bootcmd.h>
>  #include <env/ti/mmc.h>
>=20=20
> -/* DDR Configuration */
> -#define CFG_SYS_SDRAM_BASE1		0x880000000
> -
>  /* Now for the remaining common defines */
>  #include <configs/ti_armv7_common.h>
>=20=20
> --=20
> 2.40.0
