Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E8CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 11:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E743801E8;
	Mon,  6 Jan 2025 12:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mVhdx4Qt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 638E68036B; Mon,  6 Jan 2025 12:09:54 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D18801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 12:09:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53e3c47434eso14661333e87.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 03:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736161792; x=1736766592; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AvAG7j6H+Jmn1eZQEqD8es5jZTuY65ybjNyPnhBuC5I=;
 b=mVhdx4QtatdbkkfQYVivVN22I2UKS8oaBCOGp0LAkpUIYKZl7V3drFnCCwDpIqROg4
 bJpLquGpQQ4Y5AB4zgWJ4XrweKmXAXnxCf3M4aseBDMQLi1GGXXiQxG3CNfkqrGSmGGA
 qYRsYQtzdpThZLQS9kPNGYO0/2qzlfvbGBMqAujILlkdph8GUK5qxh1MWklGHLvk0lz7
 JgoJx6OZ89vnw1r1V6Uo50wL/mLhalTaAxNu9fxGyt9GXOq4BY/hJFEwoIXxyYnNU8wY
 BkJN5PV/cIAJoc8fDIb68+vPRkkt11UF2E0l9jzG4x+3E/4lDGd+1Bv9NZH3/XfHthDc
 Qsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736161792; x=1736766592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AvAG7j6H+Jmn1eZQEqD8es5jZTuY65ybjNyPnhBuC5I=;
 b=sJUzP++Sv+pri8T5Q96FaCb07pyPld4X2oIZVmSxSgMGUBTjY9vJcjAj0iHP+qYAyP
 MIWpt/phquvO1yr+wkCzkR6sLnYVEhF/GOAhRAmWz91RR6s+0AwiVTObt34CCAhpsEm7
 kBQ8YJ4a3L/poWdFlBeqc+x/nNrxCLHaSK1wuUDoXxEP8cauS25hlAHyL3bZWPa/HCW8
 ZMqPlIIGGzrc4zyLxxfHiULzoWJ9K6dBHW8izBPtlEF2PV3+lZrVtaP3jT2otMo0RzTv
 Si9DJq9eDS/q6vFfJHirzHUpFQrYc94hL7iQD/u1Yj2bYp3/X6jxpEWykgZ2qO/I0VzI
 JkeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz3b9IZqi4llA66BRb80de7A9LlRMdfAZ9vj5X/Thh9JrWUpDl3qzat/WbxH0wMVfl7Kzrhw0=@lists.denx.de
X-Gm-Message-State: AOJu0YwK1SbP3l37eZ/3iecoCBjVV6kRLnMKVq/a4VJqNnbNckiVZ4Xh
 r5Ejjim+Ns+LkkXE6mHb4aAlDXDWw8MKl6hWbnXZq3fGje2OWhV2zBFrXB+3u7ahy0/h5Brkvr/
 avnaZSAGTUHlOhzrqaUkjZuJ8w+E=
X-Gm-Gg: ASbGncuvGqXsui2r/TIhujTxbQadmJrEE27a5xBFfH5vaaoWIBJH80LpGoWC6E/Rmts
 J2fHbHp1uw4FCOk+89tRGXZEm7fyU3ylfiQo89wbj7gUzErs6VwiqdDWQ6uurtMEVSv3tqw==
X-Google-Smtp-Source: AGHT+IFnyaCsoMP8xe5B3MS7gMoNz6y31rA2jPe8Vk1LE4J0BTKrPYw/Tt+1cKBMpA12Ttqj8X9hzdfGYPSo9FDSnoU=
X-Received: by 2002:a05:6512:6d3:b0:540:3561:8897 with SMTP id
 2adb3069b0e04-542295619e1mr15497702e87.39.1736161791550; Mon, 06 Jan 2025
 03:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <20250104-imx-bootstd-v1-6-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-6-e09618cc1d65@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 6 Jan 2025 08:09:40 -0300
Message-ID: <CAOMZO5DA8b1X+AFxnTbwjNBURg9xpAe7L4c31e1xFOibgUfe_Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] imx: imx8mn_evk: Enable dynamic settings to mmcdev
 and mmcroot
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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

On Sat, Jan 4, 2025 at 12:19=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> +#include <asm/arch/sys_proto.h>
> +#include <asm/global_data.h>
> +#include <asm/io.h>
>  #include <env.h>
>  #include <init.h>
> -#include <asm/global_data.h>
>  #include <miiphy.h>
>  #include <netdev.h>
> -#include <asm/io.h>

Sorting the includes should be a separate change as it is unrelated to
adding support for mmcdev/mmcroot dynamic setting.
