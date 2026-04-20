Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A486BEA71B9
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 03:46:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C873980433;
	Mon, 20 Apr 2026 05:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DggFrTlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ACF883693; Mon, 20 Apr 2026 05:46:46 +0200 (CEST)
Received: from mail-dl1-x122a.google.com (mail-dl1-x122a.google.com
 [IPv6:2607:f8b0:4864:20::122a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A1980086
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 05:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-dl1-x122a.google.com with SMTP id
 a92af1059eb24-12c565dd3a7so1433736c88.1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 20:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776656802; cv=none;
 d=google.com; s=arc-20240605;
 b=RZLOjfHKesneF3sF1sX9/cE2XwHXHQEkbSVXr2DyepxC2lHXcLnxlwEgEDmmQNP8ry
 mh30qna8Mc1q2o3mwJT9IwxlxPICOwvt4SaP2l3+WcdQAdKtczhbrZ/ZUMtxjx6owlDC
 YGCIulmleQsMJ7LiHTjtpWxY8HUvB80pHS4MhjaoxXyHFuKWfOTvmvGWReI7FfyVEiLb
 we0GWAmrDY38F25luXRnAbpzw2UKozvWgPZbctzBfbjESDV3fU0unTpdIXa2zATFzcKQ
 CtNKS1MTiOrRKO36q+kLwWGhnzEYneo2lLtw+/WT1c6iH9PUbo8dz+dWJemj7oW2DK4G
 /08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KlIZz1BwyiTMTN2QX3iHSd/bTkZXgzL1W4bVSsd0zpw=;
 fh=MqVxsXbTqLT1mEOVeZrDVva9zXkQPc3S8baR4giEULM=;
 b=g71kvlNF01oxbVUlQ/6kCgtS5WADVewT6g4vwAt38uJ7T6cvXH8qlss73jdO2opmZ1
 IAD4EL0dDTffMAI0/HruUvfI2kADqBia1sd02I3slmmBFOX4MvZv2rWLXaQOesKWBGUA
 TmM5jdcd385NXW/apT0B3pMWWo65V/76Z5Ni7/u9oEsD1Xn92Un4zbg33GeO1Pc63Qjz
 6yV98rn3iIOe9zQbnd1vXaP0h39GwkmAackVr30CoOeph6W0FwuXFpGD6LAzAGYz6UBm
 nsEjOpksrQLQQJQsEZpkF11l8UFSUwzTohLcAcdBrti0KizUNimjA7BxiZWPJ5m4zHx1
 YTSQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776656802; x=1777261602; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlIZz1BwyiTMTN2QX3iHSd/bTkZXgzL1W4bVSsd0zpw=;
 b=DggFrTlkr9B37oMWK56OV9Zd5GPI0CgMrZcMvaUrJT9e+cfhm63eC74PWBBg/CafJk
 br4cbL5ibiQQQ0o/YDg0B/2my1nfyr6WAupIe3p+eoSvZBFLWcchv2lvlQZY9GxlNtIz
 jYk+BSRmOM6KFezSdOlxk1+6CQe5VcsUgfJxZ6mG1BQxTl72AAzlNt8codLmgmEMQPj9
 I26cXa/+KrE7f/onNX/uggQtMnm63Sv3y+7DiSpmEGCxIsHVAvgAuiXtVkZaonGp2C4P
 FB5yjO69+4RNBr8GDmZ6bMPpiBvwfCbw1Df5NAagB/Bau0XXrAcTs96DHIQA600s14l0
 oQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776656802; x=1777261602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KlIZz1BwyiTMTN2QX3iHSd/bTkZXgzL1W4bVSsd0zpw=;
 b=qQgVxxymuYdK5P23c3HZ24Osszlv/jSQ5iwks6SWcg+J3JqaXo3+w5ORdjpw4upNTP
 vZeqr/A8wa1NapbkbP1tJXO4nA0+YJKutRMCeVpILz0ZI3FqPuaubUqIi1uVD1ycJGjS
 orRuqyWus4EEUKjx/yoKhIUSaXUarn2S8OujxM8GFEg1TGS8OKvNiHWljLZHqq9BhrSs
 6YEcckcVxtQupRzE5dGRTCEWwfgISSqZbELAfaempe7FUREyosRyrSkA1B5LjO8c7Y6g
 doyg+1++NQnBmhQ24QwUCc36qpRx8KA/HPtAJY2jAchvpwVptDv6e934LpgIhz3gJ0Ei
 CSCg==
X-Gm-Message-State: AOJu0YyT/EL5e+Oha3FHfp9l0a/aDCMfyEITV6lUJedrxvVY0MLa+DzO
 e3othq3A4EMXhpqyzICosN+5Nlk/Oovz2zHwPRROTj+o+cVPTsbZ5MEev3qeB6BpD6e96pJR1l1
 wxYS0UCKRNhN+dnS/1EtlzDxftddsdQ==
X-Gm-Gg: AeBDiesORVzSbGhSbFyF2APnPdFj0hwUHFD/uZRpHD18i1hHAfDONc+p4bq+NBBK6GS
 TG9zPx9clGKdllJeNWF62nWm/OTpnqtwGo0MTt8oNPRdk1aaURfIjnVg8jFD2IuyYKJ438DHpG1
 snMDpG57StEwBQZJC846tHa0UJ7vP5uTm2FfS2sufxFHT2yDzGxxg72IC9NxNzeHGegkQn4m/Rf
 LpVo9aO8500bo29SwnyN31hoYZx9sql7p0SrGoPKSHb4bXqQXpA+Lh76B7YrsliCN2ltohJy0MZ
 y4lJIfRBJoYYx3cGtnJge2z/f4g2zcl8opwwowrzXkV3a/KkImLde8BsjTsU
X-Received: by 2002:a05:7022:69a2:b0:128:cedb:33ba with SMTP id
 a92af1059eb24-12c73f70ebfmr5923469c88.10.1776656802252; Sun, 19 Apr 2026
 20:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776344788.git.jcethrid@gmail.com>
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
From: Greg Malysa <malysagreg@gmail.com>
Date: Sun, 19 Apr 2026 23:45:19 -0400
X-Gm-Features: AQROBzBwgry45VEYNcRmwrLYOhZdaQUxnBqnGdrh5GYiC9Z1qJ9YPOP7iQU7Q4c
Message-ID: <CABdDSeW0PiVMSzWQXO+akar0=_-3jf9jusD6xF_5dHPg74b57g@mail.gmail.com>
Subject: Re: [RESEND v4 00/14] sc5xx Environment Cleanup and Fixes
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, linux@analog.com, 
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
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

Hi Caleb,

On Thu, Apr 16, 2026 at 11:19=E2=80=AFAM Caleb Ethridge <jcethrid@gmail.com=
> wrote:
>
> This series performs a general cleanup of the default U-boot environment
> for sc5xx boards, stemming from the decision to no longer store the
> environment in the SPI flash. The environments for each board have been
> edited to contain the minimum number of commands needed for all supported
> boot modes to avoid confusion, and the default boot command synced to spi
> for all boards that support it. The filesystem for the SPI flash has also
> been changed from jffs2 to ubifs.
>
> A bug with the Ethernet reset line on the sc594 has been fixed, and the
> sc573 has been renamed from the EZKIT to the EZLITE to match the name of =
the
> publically available board. EZKIT was only used internally before release=
.
> Preliminary binman support for sc5xx boards has been removed as it was un=
used
> and full support never added.
>
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
>
> Caleb Ethridge (13):
>   configs: sc5xx: Do not store environment in SPI flash
>   mach-sc5xx: Remove update commands from default environment
>   mach-sc5xx: Update boot commands
>   mach-sc5xx: Switch from tftp to wget
>   mach-sc5xx: Add USB boot command
>   mach-sc5xx: Remove preliminary binman support
>   dts: sc594: Fix gige-reset line on EZKIT
>   mach-sc5xx: sc573: Rename EZKIT board to EZLITE
>   mach-sc5xx: Update image load address
>   mach-sc5xx: Update SPI bootargs for ubifs
>   configs: sc5xx: Set default bootcmd to SPI boot
>   arm: sc5xx: Remove SC5XX_LOADADDR
>   arm: sc5xx: Add fdt_addr_r, kernel_addr_r, and initrd_addr
>
> Ozan Durgut (1):
>   arm: sc5xx: add missing boot env selectors
>
>  arch/arm/dts/Makefile                         |  2 +-
>  .../dts/{sc573-ezkit.dts =3D> sc573-ezlite.dts} |  4 +-
>  arch/arm/dts/sc594-som-ezkit.dts              |  2 +-
>  arch/arm/dts/sc5xx.dtsi                       | 41 --------
>  arch/arm/mach-sc5xx/Kconfig                   | 47 +--------
>  arch/arm/mach-sc5xx/init/dmcinit.c            |  2 +-
>  board/adi/sc573-ezkit/sc573-ezkit.env         | 17 ----
>  .../adi/{sc573-ezkit =3D> sc573-ezlite}/Kconfig |  8 +-
>  .../{sc573-ezkit =3D> sc573-ezlite}/Makefile    |  2 +-
>  .../sc573-ezlite.c}                           |  0
>  board/adi/sc573-ezlite/sc573-ezlite.env       | 16 +++
>  board/adi/sc584-ezkit/sc584-ezkit.env         |  8 +-
>  board/adi/sc589-ezkit/sc589-ezkit.env         |  9 +-
>  board/adi/sc589-mini/sc589-mini.env           |  9 +-
>  board/adi/sc594-som-ezkit/sc594-som-ezkit.env |  9 +-
>  .../adi/sc594-som-ezlite/sc594-som-ezlite.env |  8 +-
>  board/adi/sc598-som-ezkit/sc598-som-ezkit.env |  9 +-
>  .../adi/sc598-som-ezlite/sc598-som-ezlite.env | 14 ++-
>  ...ezkit_defconfig =3D> sc573-ezlite_defconfig} | 11 +--
>  configs/sc584-ezkit_defconfig                 | 10 +-
>  configs/sc589-ezkit_defconfig                 | 12 +--
>  configs/sc589-mini_defconfig                  | 12 +--
>  configs/sc594-som-ezkit-spl_defconfig         |  7 +-
>  configs/sc594-som-ezlite-spl_defconfig        |  7 +-
>  configs/sc598-som-ezkit-spl_defconfig         |  5 +-
>  configs/sc598-som-ezlite-spl_defconfig        |  5 +-
>  .../arm/adi/adi,sc5xx.yaml                    |  2 +-
>  .../configs/{sc573-ezkit.h =3D> sc573-ezlite.h} |  4 +-
>  include/env/adi/adi_boot.env                  | 98 ++++++-------------
>  29 files changed, 106 insertions(+), 274 deletions(-)
>  rename arch/arm/dts/{sc573-ezkit.dts =3D> sc573-ezlite.dts} (98%)
>  delete mode 100644 board/adi/sc573-ezkit/sc573-ezkit.env
>  rename board/adi/{sc573-ezkit =3D> sc573-ezlite}/Kconfig (92%)
>  rename board/adi/{sc573-ezkit =3D> sc573-ezlite}/Makefile (79%)
>  rename board/adi/{sc573-ezkit/sc573-ezkit.c =3D> sc573-ezlite/sc573-ezli=
te.c} (100%)
>  create mode 100644 board/adi/sc573-ezlite/sc573-ezlite.env
>  rename configs/{sc573-ezkit_defconfig =3D> sc573-ezlite_defconfig} (87%)
>  rename include/configs/{sc573-ezkit.h =3D> sc573-ezlite.h} (79%)
>
> --
> 2.34.1
>

For the series,
Reviewed-by: Greg Malysa <malysagreg@gmail.com>

Thanks,
Greg
