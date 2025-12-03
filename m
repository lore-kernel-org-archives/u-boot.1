Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5714DD1BDD8
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 19:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F0A83B7E;
	Wed,  3 Dec 2025 20:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QiO80IOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 264A483B99; Wed,  3 Dec 2025 20:43:01 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EF2383B4A
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 20:42:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-bc0e89640b9so73158a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764790977; x=1765395777; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uH8spR31xEL+AEW6jt77JHe08jvvuM4rRXUXTVamSK8=;
 b=QiO80IOqNTCyEWM1y8Y1zuIw9OtIAz+fCnPwZhTj5rBnSCGuRvqSsOln/0G3Llxzr4
 2piSwuXMCTxpK8P0Dm9XLCFKZ9v1EOp9/HHgE8oHeYbQR/flCvlURbX4Q4vwKOnie0Sn
 WIfGUdVeLXSxbw0i106rakVVfWnUhiY6YeTVRq6rkHLg66srFNpIkQU2v0cF6EihWOMX
 BatyDtTo0KNOo6EkRVL8q0gGoalZ7RAo3ukEUnqTgb0CE6hlLjUQRH+6TAWCtSjZOCxR
 1I4pHV0OPWYtJDs70RK0NwumJxzFj1iNKCknoTCMcoOJC17Wh3+EYLPuqBjACG9JZjVq
 NH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764790977; x=1765395777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uH8spR31xEL+AEW6jt77JHe08jvvuM4rRXUXTVamSK8=;
 b=u8LbaHOPA8Y7xBQSgNxfD13Twfs7p45isLncK1bj3EXVqavalL/t4R5/F/U0XdY3wB
 ERSTwG5A5KY9vPSaQaEwEoAmyL0f1S4OLxXkmtbgz3Z6Bit1dpWIMWK8nWJE5mya/q3X
 OtXodny5shcUH6mj9tGaQ/1DoolZd5+RpZL2lrnCOpE8HrmIVBVxLm1LOSFvKjXcysYB
 9jqbIRTNJAtwhO/pT4AaULWcdFEqiv0dx9vX85WUhNQn1/L5NpP+NsNsj/vtKvEI9TLr
 M7jYB9dDjjA67pSrvCbM2XS32dGhwE+1lDYymo+FrhZNeN9H8fxysPqpQGox3CrJaBV4
 0CUg==
X-Gm-Message-State: AOJu0YzjK1WeJBsXwNHYRThObc5aHgeLoPs5CM2D7j+VdbqbXSMUk9ZD
 7avRObb7SyJ12X4T+mlScCemopjVMuiuyZgo8Fym2d4BpyT3rbtn8GQVNV1vkrkl7bX0WDGsfvm
 qo/Zf8IuDE6EESPI3pkSRGMu5lHSGe6l4uME2iqp6WA==
X-Gm-Gg: ASbGnct267gNYCf0RPyWdPIeCt9Lm0Ucr/uAlGcX+121BpLuNoAPXehnjE5ZXmc+G89
 ozgnxDA1g4k7l7jdt1vFTe9rBNB09OFKIeSGpvEPKlGqP6kwuW/1gGw6RScaqX0x5j5F/iQcrxM
 XDimdBabeEJpqTd45dKZ3jceFSYJZie6G9qILni2Zc4N+eS5KZ+stAzR2wKCIEjn/6LbmBMdxLQ
 BN5AfZxU/llpbY3huSyDrD3AK7tFH8t0wGS83a2Ov1IgZXPQZ3JRu5SpSLNnbBG0HHtD5frXiZE
 /J4ws19j
X-Google-Smtp-Source: AGHT+IFjdnGh4upez5KCNpmp3tuPzW5hBn52GqKz0hsKryd2vxy7TUPKEnTtxqCRUql+mVj8DDsRLtL1x+oNxm7B4MA=
X-Received: by 2002:a05:7300:4628:b0:2a4:7b65:1a16 with SMTP id
 5a478bee46e88-2ab92e2e189mr2308397eec.25.1764790976541; Wed, 03 Dec 2025
 11:42:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1764574369.git.jan.kiszka@siemens.com>
 <ada2fc90d01cb54e178853b766896f0f69b26451.1764574369.git.jan.kiszka@siemens.com>
In-Reply-To: <ada2fc90d01cb54e178853b766896f0f69b26451.1764574369.git.jan.kiszka@siemens.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 3 Dec 2025 14:42:45 -0500
X-Gm-Features: AWmQ_bnLF9gGONAYb2jPNvfdfcStyVs-Tw0gVr1wBw2M27RCm54_ebFN0jZK4YA
Message-ID: <CANp-EDadXjDxHKTZDUSCSmdxruGKUk3CEFRB2tN6LCQnuPfKGQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>, 
 Sune Brian <briansune@gmail.com>
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

Hi Jan,

On Mon, Dec 1, 2025 at 2:33=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com> =
wrote:
> --- a/common/spl/spl_mmc.c
> +++ b/common/spl/spl_mmc.c
> @@ -137,11 +137,7 @@ static int mmc_load_image_raw_partition(struct spl_i=
mage_info *spl_image,
>                 return ret;
>         }
>
> -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>         return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.st=
art + sector);
> -#else
> -       return mmc_load_image_raw_sector(spl_image, bootdev, mmc, info.st=
art);
> -#endif
>  }
>  #endif

This patch seems correct, however in testing, it does not boot for me
on cyclone V.

The reason is because the sector offset is zero, rather than the
expected value (0x200 for socfpga gen 5).

This happens because of Kconfig dependency:
https://gitlab.com/u-boot/u-boot/-/blob/master/common/spl/Kconfig?ref_type=
=3Dheads#L586

I removed this "depends on" and thereafter I am able to load the main
u-boot successfully, although I don't think that is necessarily the
right way to fix the issue.

Regards
Ralph
