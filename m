Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA563F3ED4F
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 14:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48BA18419E;
	Sat, 11 Apr 2026 16:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A4sKHMpH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F039841B9; Sat, 11 Apr 2026 16:57:45 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32F018419C
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 16:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9825ba7f9dso438809666b.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 07:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775919463; cv=none;
 d=google.com; s=arc-20240605;
 b=dWC6IgIBUbRNoe9e3dS5u2x0A51F0lCmlNGEkxH3Cojxlfqcinh3daaK02S8txCZSE
 k7dGwuJy9jlzEuwqSaaB10ElJIJ8Ha3yDgKyGMe07yAhpVcLGVyekJlcMkf1PrDXjpaW
 J5kDAie+h3bGLISbPj0b0tzT3/7wI5oc/JiN91b3vyTO5/jQ2UYukzcCcYJyNUwTLXQh
 nz/mkNnK3+C5LCuaLmu6vWpSI5/AUdIN1iCt+gRpELpwaYhXv2LK4rBXO4FfK+xS6Hm4
 s1a+mZsrlKf3hrXEknlcI04jrYc/cenktOWmT5dh4wZw/glASFDoW4HYsh7tNSs+d3Xv
 w5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bpik3QYi4RrnA4WT+oN6mGEqpDhs/s1TLm9TwM14P18=;
 fh=yHqBN7NFClq905zqB96KeXXRqRH346QT5urrBm81ZP8=;
 b=Eh0fVSio1ODaf6eh7nBittPFunfXx5BsFYUpHirVMwsmUR2nB0coqBvwlDi+wcAdAy
 hVOSuqrqo/DspT/IVFUnoCZV8I+K6G9NDnUNvuh1eJFVCw7xgMxgJmgo0MArxUXIPdSB
 3D3DhH9jMQDrMwacYWZQ/fqyVsWSNa68cr5n+1nMIon2d4I9mdBXCWYRvvQLRVL+kGp4
 IKpx41H5S8ON9UX1ed47wHdAe679uvEK1RGJmTHBE7GzPZW8hFmXssTNgzo1RNY5k3/U
 Pt4k9JBD40Y72PLWZo7nFksghOWzaroBNecqB+reYiLp8HLy9fQpHwkWi6YJrbtIMXYK
 iqvw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775919463; x=1776524263; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bpik3QYi4RrnA4WT+oN6mGEqpDhs/s1TLm9TwM14P18=;
 b=A4sKHMpHAs4neGob480+vSgtBea73LsXfPHmJK7A1+Fj8iiLJ8jpOhgz8w4RhD8txM
 /UMM/eqSVZTBM65VpYZuOQW+Jls0j6D18dg271EMzsdu/peCWp+p4ymK36LwM087yr3v
 GnkeqzTlGNuNRbIhFjXTtdVgFPbLu7YqN31kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775919463; x=1776524263;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bpik3QYi4RrnA4WT+oN6mGEqpDhs/s1TLm9TwM14P18=;
 b=m4YSriguMXIh1ZSOF+JSrl075K7KWojAf3TUKb5TeY1+ehMFx2XEn1SI8CkHvEFumX
 bEJC8Mi0bDb43q1Cyj7BrZXxaeiNDOHMrXo7LcNY1ueKJfGh0q6zRQWtNJZfmMr3iljW
 unYRNvo+7l6oElSYsCsEQMcLdPp9LrMkgy2uTuIaaywzhsl3h/kfBs0AAASrszaPnFTx
 d5h7Dgjr2tYnvMxYBIIuT4xA+kf7FvwPYyAya5Mg2rF1AibY4JzLfYg+bcawjFSmsRSS
 CcUaN7rUupOPvIWBVy7qxuDotdhrcQf9VQYCDaZSc/pnMWtcgo9drXrCD5v5NIHv0tWt
 IyZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzK/E2ezYko80x6itFsbbqlIABxoOEzIB0EpQQIyvnJqKqvurpdKMM866+KOMpC5PpX6FvHFY=@lists.denx.de
X-Gm-Message-State: AOJu0YzCdxeDKeZCvku4nYzbZzka0aWCRWnM/gn5MHcWftKikzOupAoA
 4+tQdMBAgrbxQtoelewQYe4p1vPC/3taQloclYqsn6LKpGpwnugPiY2WV9cMasauP+kattoosYY
 5IB5B3ykdMZwfmyQU79gIn+MWX990kad+oNFdOhke
X-Gm-Gg: AeBDiesK9APCZOAU5gF3FDErQCN9yo/lUZLTltP4EdJeG+rDgQf7G5YF1k+y+xw0808
 ieSavGFHJYf1PL+ereblVbmsa2n2ArXRAQ9gQixiRkOezz+GXESfpnMMLkHAcfJCaLX3vXAd4z2
 6PnsnDrVZK4dCOtc03M7X5aoY+WulXaGo3mWsQYguuxv3RRxQug9+fIBggql92Kt7y3Gb6Bxl5y
 l3OxWZtnN2kUBRhJxLXC3i3WTurMLeF/AG4+3/ug/LiMtLAA8dNQqouMhkFRZxuGcDNMYxJ9yAV
 OE+f3w==
X-Received: by 2002:a17:907:26cb:b0:b9c:617b:4a36 with SMTP id
 a640c23a62f3a-b9d46227ffamr596955566b.21.1775919462545; Sat, 11 Apr 2026
 07:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260409133303.31875-1-ansuelsmth@gmail.com>
 <20260409133303.31875-6-ansuelsmth@gmail.com>
In-Reply-To: <20260409133303.31875-6-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 08:57:30 -0600
X-Gm-Features: AQROBzBh8WoF28_iP08RPgasgPLvZ4rqBIYYmYz98FvQuZ5s5x6IjkrrmB12kU8
Message-ID: <CAFLszThnYjfy2Y=pfWWeUmguG4Xne7qk7zikpBMEkwM7JoJswg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] misc: fw_loader: introduce FIP loader driver
To: ansuelsmth@gmail.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peng Fan <peng.fan@nxp.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Justin Klaassen <justin@tidylabs.net>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Christian,

On 2026-04-09T13:32:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
> misc: fw_loader: introduce FIP loader driver
>
> Introduce a variant of the FS loader driver to extract images from FIP
> image. These image can contain additional binary used to init Network
> accelerator or PHY firmware blob.
>
> The way FIP handle image type is with the usage of UUID.
>
> This FIP loader driver implement a simple FIP image parser that check
> every entry for a matching UUID.
>
> Similar to FS loader, this driver also support both UBI and Block
> devices.
>
> Also an additional property is added to handle special case with eMMC
> that doesn't have a GPT partition and require a global offset to
> reference the FIP partition.
>
> An example usage of this driver is the following:
>
> [...]
>
> drivers/misc/Kconfig                      |  11 +
>  drivers/misc/fw_loader/Makefile           |   1 +
>  drivers/misc/fw_loader/fip_loader.c       | 544 ++++++++++++++++++++++++++++++
>  drivers/misc/fw_loader/fw_loader-uclass.c |   3 +
>  drivers/misc/fw_loader/internal.h         |   2 +
>  5 files changed, 561 insertions(+)

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +#include <fs.h>

Is this header actually used?

> diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
> @@ -0,0 +1,544 @@
> +static int blk_read_fip_toc_entry(struct blk_desc *desc, u32 offset,
> +                               int pos, char *buf,
> +                               struct fip_toc_entry *ent)
> +{
> +     unsigned long left, consumed, to_read, read = 0;
> +     unsigned int blkstart, blkcnt;
> +     int i, ret;
> +
> +     consumed = pos % desc->blksz;
> +     left = desc->blksz - consumed;
> +     to_read = min(left, (unsigned long)sizeof(*ent));
> +
> +     blkstart = BLOCK_CNT(pos, desc);
> +     blkcnt = BLOCK_CNT(sizeof(*ent) - to_read, desc);
> +
> +     /* Read data from previous cached block if present */
> +     if (left) {
> +             memcpy(ent, buf + consumed, to_read);
> +             read += to_read;
> +     }

I suspect this condition is wrong. When pos is exactly at a block
boundary (e.g. pos = 512 on a 512-byte block device), consumed is 0
and left is 512. The code then enters the branch and copies stale data
from the buffer. The condition should probably be if (consumed) to
match the logic in blk_read_fip_firmware() which correctly uses if
(pos)

Regards,
Simon
