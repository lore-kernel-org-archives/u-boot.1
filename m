Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDFD3C907
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 10:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A688C892D5;
	Sat, 19 Oct 2024 12:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dk1oddxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC32A892E4; Sat, 19 Oct 2024 12:51:26 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10CF8892D4
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 12:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f7657f9f62so29719571fa.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729335053; x=1729939853; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b62KFGuBfhOwVJtzkMjxbBqmfn2LIcspLB/oNKxGAss=;
 b=dk1oddxQylLOCGgFY5STB/xbxMlWHRvbpLmI9P8JYDRCYxoGh41lFfvr6k68NUm8Ji
 dwBj07YgpuugJIr1TILw1y9hTgLohFcOmkc54MfCVGfIkQaIanNL2EdG/dsrrR3vPNGn
 LkxoWl5NH2ym10y5PnBawCqDhMhgDrIo3EnOIyEWCvTw6naiFXjqEk9D00c6gpiBWbtR
 njoSSyq0KYV962Tp8lgsXGo8+opvMTmPtPw3miacXqQF9mkqI/+z7OsDYqU5s7qlPyil
 RIlJe0J4wpG+jlidQmzeAMBkchvxf3lVqDyp43NmGlm/b5TuxtwzmV1hdP9uu6Ehnier
 I+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729335053; x=1729939853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b62KFGuBfhOwVJtzkMjxbBqmfn2LIcspLB/oNKxGAss=;
 b=TNLdnmDMopL8/QZl68Dx7l6dlOJplww6N4AUtrkFl+mEmqRTCpk8KAfTWq7LEKUqhN
 dft8rz4vmV+hB56N4Dv9Y8RxXxlWcqa0PI2/lzzw7bpsJWPEu5+NfaBM1I/GtdNTiSAU
 RVzGmhDj/f2NWLmcXI9oNva0hgJPAoeKnnbklbO4hovXGEXAgf5exPqunFx7Hxprrm/R
 SS5U9ZKuRWS/cqu3lTT9wyfNcnELpK+lvH+ymLF4DJ0XiaBuSibAi7MMY9JkmwBNUnDv
 187Yr/iPPf4aeUpIMrT99CeuwCGyHE+quC1O6uOIR4lV/Ng2/OVkGMRBQYnpW/+MjJ9p
 Bt7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyrGfYsPznP/d3/GrSf5H5AX8vUiQtyFIZS7jiiwFLSm4S02Cn20BGi3GvlyBGDAboQk5okIo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf4mJtNMXh+GZ5smZ1zzFNCrqZ/ZUn2vcPZ0R3ewXTHKGBwmlT
 e4bvd/4gAt3vjvPpFj30BhWBjPZKwAm1UOeR0vRIFUFjkXle9bOJbr5Fz5lccdH38KCHOtWo59G
 YlKsLx/lmibt+bb/Z8r6kuPEiETA=
X-Google-Smtp-Source: AGHT+IE3zx8gt0/iHeRWepFMVTaLNjuhX962CqPMs946b3Q+zscMpf0YkGel/j+r9u2P4Ln/TPYGH7d6tYYe3EZpCsY=
X-Received: by 2002:a05:651c:504:b0:2ef:17f7:6e1d with SMTP id
 38308e7fff4ca-2fb82e93013mr29476721fa.4.1729335052893; Sat, 19 Oct 2024
 03:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241019083109.12113-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241019083109.12113-1-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Sat, 19 Oct 2024 03:50:41 -0700
Message-ID: <CANV2PTMAwFHjLNW_JkXq6ohAZb6=XGnN8B4qrF6AV-AHBwG9wg@mail.gmail.com>
Subject: Re: [PATCH 1/1] configs: visionfive2: enable CONFIG_CMD_ERASEENV
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Chanho Park <chanho61.park@samsung.com>, 
 Nam Cao <namcao@linutronix.de>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Sat, Oct 19, 2024 at 1:31=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> When moving from vendor U-Boot to the upstream U-Boot it is necessary to
> reset the environment.
>
> Provide the 'env erase' sub-command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/starfive_visionfive2_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_vi=
sionfive2_defconfig
> index 511645cebef..c3508926d6c 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -62,6 +62,7 @@ CONFIG_SPL_DM_RESET=3Dy
>  CONFIG_SPL_SPI_LOAD=3Dy
>  CONFIG_SPL_YMODEM_SUPPORT=3Dy
>  CONFIG_SYS_PROMPT=3D"StarFive # "
> +CONFIG_CMD_ERASEENV=3Dy
>  CONFIG_CMD_EEPROM=3Dy
>  CONFIG_SYS_EEPROM_SIZE=3D512
>  CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=3D4
> --
> 2.43.0
>

Looks good to me. I would also enable CMD_NVEDIT_LOAD in combination
with this, for:

env erase; env load; env save

...which is easy to follow for users and works consistently to go from
vendor U-Boot to upstream U-Boot.

-E
