Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6451C83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D10586539;
	Mon, 28 Aug 2023 17:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20221208.gappssmtp.com header.i=@baylibre-com.20221208.gappssmtp.com header.b="ia3Kx81E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2A3864D8; Mon, 28 Aug 2023 17:28:12 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B75E786539
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:28:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fee5ddc23eso31586115e9.1
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1693236489; x=1693841289; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lMcxXl/hHZst+NaCwjwSBxWYNMxD4iVp+HVqQxg30SI=;
 b=ia3Kx81E9aTRLqdxyYljqxyVTVTvaleGKuLoW2GPEOrE3FoxrWzBlxdfaj8wqBpk0o
 2KqBphulTIWL4Ti8Wc8jMZv8K0ugukSnGj/CjSbylki2mBnBZXE05QJIGx7vllI5G1ZN
 w77rNPUkAMLvheYBPjSwfhDfSYG3r2cj7ke07wwv9Tb2IxYdxhWp7yc0njYACI3Pf8Ff
 JYpp/hWwhKNcoiACA4kmOAXqQ9yyDFHHXllohxTzangw+jxnru6WNOxYiz5OIBOYuB0a
 3HVdI3sylY86ICOVIBgSNcWsUXRKF+8DmS4HYs66XJ3+ZOUyEEYQUMQR5g8FgA+z1wmF
 VxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693236489; x=1693841289;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMcxXl/hHZst+NaCwjwSBxWYNMxD4iVp+HVqQxg30SI=;
 b=fB0tR76y90o3LNdWdITUz1dqLBqCHureQdllW3e5iwHXAj84eabUSnv6r9mggmi2vH
 fzY1Uf2K+a+OGt8j7lunWUZW0Mn0C2/UvfthqjIfjav3UB29dVK5gcDsrWT1STRT1Pl7
 xmVW12bDQUQWDQTcDvYcoD6g78hooAOEEasf4fwWZ3qaFe8b9e4eiKgHDLBzMCtuN4gV
 zI0Wz9R6z5wechq3OR3HDIxrvt+24sQvl17cvlEuFodFXSnz/gcU5I6if8z0x7d30Ml/
 GSHE0Jzmp8GYg9Vm2PL/oQNII48RrD31rKBNcPB42aDHRVXJnJm2wWXV39jMcAP2U7yt
 RfAQ==
X-Gm-Message-State: AOJu0YwldbkbyJF10uXZUY/OJfWiC9XuYwN1hezstDoyAtzcNVgaibyK
 iroZNvsNZr7or2KVsLKGd2Hb+Q==
X-Google-Smtp-Source: AGHT+IF6fw0mtCrHaSwYLQJdYKditLfE/VDAeDihffHEiwCt03H0H+ikfleTtik8qjbVuxkZ5Lp+Mw==
X-Received: by 2002:a5d:4d85:0:b0:319:7b57:8dc5 with SMTP id
 b5-20020a5d4d85000000b003197b578dc5mr18813048wru.54.1693236489177; 
 Mon, 28 Aug 2023 08:28:09 -0700 (PDT)
Received: from localhost ([2a01:cb19:8704:be00:4f55:bd9d:611a:6c8e])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4205000000b00317ddccb0d1sm10838229wrq.24.2023.08.28.08.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:28:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V6 06/20] board: ti: am62x: am62x.env: Add explicit
 boot_targets
In-Reply-To: <20230825180305.69515-7-nm@ti.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-7-nm@ti.com>
Date: Mon, 28 Aug 2023 17:28:08 +0200
Message-ID: <87bkerw5iv.fsf@baylibre.com>
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

> Add explicit boot_targets to indicate the specific boot sequence to
> follow.
>
> NOTE: The non-standard ti_mmc emulates what is done for distro_boot.
> With bootstd, this will eventually need to be replaced by equivalent
> class.
>
> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> No change other than picking up reviews, tested tags along the way.
>
> V5: https://lore.kernel.org/r/20230824031101.3460411-5-nm@ti.com
>  board/ti/am62x/am62x.env | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index f2dc87893a92..1cf56dbd8128 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -11,6 +11,7 @@ args_all=3Dsetenv optargs ${optargs} earlycon=3Dns16550=
a,mmio32,0x02800000
>  	${mtdparts}
>  run_kern=3Dbooti ${loadaddr} ${rd_spec} ${fdtaddr}
>=20=20
> +boot_targets=3Dti_mmc mmc0 mmc1 usb pxe dhcp
>  boot=3Dmmc
>  mmcdev=3D1
>  bootpart=3D1:2
> --=20
> 2.40.0
