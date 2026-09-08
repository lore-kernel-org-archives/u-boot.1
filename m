Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B154EC79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 12:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 707994054F;
	Tue,  8 Sep 2026 12:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r1DUSNj08VpK; Tue,  8 Sep 2026 12:52:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A47EE40567
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788871955;
	b=UcHnMJ2ridXltr9RXaqEg5O1DWSlKzrkS53uM6cPUAgbvGoxf8GfTqwWzlVtIsPjdJBq
	 2TRQN0pw1FZ3ybveexR3LYW8kpUhM0LuSpkPX4vhpaSTpkcXYrhqSb8FWyYaWddYvbg0V
	 mQIefoTCpr3APE+8bFhtP0fl3Iw3h9ELunaQMFOKUyCGw1oIuS9kZauKnUtTyEPaerIdI
	 UzK/xq+W2brf96CsPUP4cSM6wc1ggjlY2itJpqvTDudBgnayrnUYnfxucHomvGu0kV+g9
	 R5e1kIx9j9MjZBw4TXVpSTF5CvtrQCuUyua1cQUs4adhBn2rJvv6HW+DQ4EEpuzqA4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788871955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fCu60x0qvuR2yfOURqEcu4+fAK2/Ux1G3yb5kPhbd5U=;
	b=Cd9d98En1zVbLiyxVrSuj8hhnLfVFWOO/dpC7n54CvSijCbVaSkpQ1cP1/JHNYC5VKs7
	 uqaFRNLF+7KCA1CRZ8bYkn20G60lP3lXYoW/DsShtrXp1Dn7Th0uW+rSZ//jFb6oWkjGT
	 Lqk5vWUEFDJMwGxcV65bFg8vMpA4giNk4OnY3e73oDZZm3OYExt1NT4oLscvfrldj/IcM
	 4V5pbrc3Z+7P6jnJLGZctioRdYOje2AJwlEwTXq8Uv6JUrwFRqAawqIkIOTHH2djHLcCX
	 dqXkz1QkIEeTzjYvGqBRO1kU9h3YExjti4v86NKeX4bACJXnkUTMEGaXlYKl7yC/vuw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788871955;
	bh=fCu60x0qvuR2yfOURqEcu4+fAK2/Ux1G3yb5kPhbd5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rIs9EDLUts4QYOJzHsey5yPH7KN7ZbQYF3yXwHQpzrEmCu2EEcGJu10uTgY7UNJ6w
	 An8A4eby06CJsPA1WgLmk2qY9yfLNAyzej22cOCXUS9dioXrQRS8xz/wmSGW01Xf3T
	 HLB+QGXu01FP7GF/85tTm/5Zqw4tgnhWeNf/O4uQhN6MirONnHrSBWEX9+ST4jOcyP
	 gnotP2kqk2ZmABSnGDmKiEkYp2coBnQhEf+1mMMJB8wii1DY0sbuQGLdyvFJVoJF2u
	 oUcoubtyCC5lD+JAldtVQfsRLJCza+awsCS+ToPU99GDe2Si+b4Tibw822DD/XcvbX
	 lTWYqtZ47dG/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A47EE40567;
	Tue,  8 Sep 2026 12:52:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B65534E
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30C16606F5
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:52:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7GU9Bf_-pj3U for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 12:52:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 68AA2606C4
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788871953;
 b=pyrsT7P8onRG7Nwr4koW0NqcL8WBlCxpwpfGEm8CWNult3iNV9M+15B9xbRrWs40oQy/
 69SKcU2MCmKC7deJNaUZhAqo6ni8GQVF0+x4eWQJmQTCauPQa/zXSacRITHkgEz0SKWal
 Mv3BNG9AIU3k6O1F4o+sGY3jfLnbqxt3ghyzl+2NSiRJ6r1sJpxfsZAtwyu/2b18kce15
 j2u6M8jNouvXdMLtcmx4PhPi3vVczADJfHsEzHS2xlEgJzfQrd67iImQwZdhgXDNH8A3r
 yv7GiblwHZxz9PyJpgG+8Vv2D4AYP7MozPoLzIz8vPzrmH3hLR+NG+7BQAbXQqRa96Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788871953;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=fCu60x0qvuR2yfOURqEcu4+fAK2/Ux1G3yb5kPhbd5U=;
 b=bv3nFSAmxK87j9rWhP6LOMM8bIIMKAQjSVIQdi8/Fnn7waSlIzsS8fy/BV8lUpLd18VP
 uV//pRc2nAkXZ5JYbeqLnPx2rCocnURQRkxQI9F+LtCsb+///PEA2g1VWOOwl9ebqMAv1
 9rqyAIRj1dtSQ0XDwm+IQbygkbGdevVEKsL2D+ueldXrfsInVlWB7h+tp97FKVafTt/+B
 u9PnDyLJnUrzYy8ndoU5/5ou9wVzOOuo/TFEGBcHQk0JSrAcGlxFwRRDYZL3qUwO58df8
 A9USPYFEE0BM5NpkkyDnNKMg3bjQDlMMxzx83Lv4CkDx0XIjxf73vpMk1JZ8BuRrxyA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Pm9XfpcV; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Pm9XfpcV
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68AA2606C4
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 12:52:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F79F40BF9;
 Tue,  8 Sep 2026 12:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9DE1F00A3A;
 Tue,  8 Sep 2026 12:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788871952;
 bh=fCu60x0qvuR2yfOURqEcu4+fAK2/Ux1G3yb5kPhbd5U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Pm9XfpcV9D3WQ5fXysGwr6FQd2F2bTe8KNTVl80AMkAUCabrwJl78t3N0cXXI4SvK
 MGnDxk/g4+KRYEyqz1gL8o1baJwYcmqIdYCPZgcCUrENJbXbafhGiLhzJc8J6VJJ+b
 A041HqvsU52xpchioKPdO1Zid9YTQ/QFM9Ub26ibsYunjn4Kg/UKRh9qjqouBFqo2K
 84TLQ3Njg7Ieo/MOtOlOkYwM2y4RxnM4rzIqPEoSvZY4QAt5juqFlA6KyLNRdvrYHq
 iNzLMGWPNX6by8bLO7zuk4XTsIyQsTYj+BczkBSK78WSIhbV+7QLtviI1odl95WmeM
 vuk/RLbubaeGg==
Date: Tue, 8 Sep 2026 12:52:26 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v12 6/7] doc: spacemit: flash on K1 SoC based boards
Message-ID: <20260908125226-GKC2346@kernel.org>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
 <20260906-m4-v12-6-89eb5a8f879d@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260906-m4-v12-6-89eb5a8f879d@riscstar.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

hi Eric,

On 17:11 Sun 06 Sep     , Eric Chung wrote:
> Add document on how to flash images into eMMC of K1 SoC based boards.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v9:
> - Add to generate the partition table of SD card.
> v3:
> - Add document on how to flash images into SD card.
> ---
>  board/spacemit/k1/MAINTAINERS |   2 +-
>  doc/board/spacemit/index.rst  |   1 +
>  doc/board/spacemit/k1-mmc.rst | 271 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+), 1 deletion(-)
> 
> diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
> index 4b2bc4ecfc10..e12288a206e0 100644
> --- a/board/spacemit/k1/MAINTAINERS
> +++ b/board/spacemit/k1/MAINTAINERS
> @@ -6,7 +6,7 @@ S:	Maintained
>  F:	arch/riscv/dts/k1-*-u-boot.dtsi
>  F:	board/spacemit/k1/
>  F:	configs/spacemit_k1_defconfig
> -F:	doc/board/spacemit/bananapi-f3.rst
> +F:	doc/board/spacemit/
>  F:	drivers/gpio/spacemit_gpio.c
>  F:	drivers/i2c/k1_i2c.c
>  F:	drivers/mmc/spacemit_sdhci.c
> diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
> index a5e35ee12ab6..71854e5735bd 100644
> --- a/doc/board/spacemit/index.rst
> +++ b/doc/board/spacemit/index.rst
> @@ -6,5 +6,6 @@ SpacemiT
>     :maxdepth: 1
>  
>     bananapi-f3
> +   k1-mmc
>     k1-spl
>  
> diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
> new file mode 100644
> index 000000000000..0be5d5fa1c39
> --- /dev/null
> +++ b/doc/board/spacemit/k1-mmc.rst
> @@ -0,0 +1,271 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +SpacemiT K1 eMMC and SD Card Boot Guide
> +=======================================
> +
> +This guide covers two separate methods for booting and flashing U-Boot on
> +SpacemiT K1 based boards:
> +
> +1. **eMMC Flash**: Flashing U-Boot and SPL images to eMMC via USB fastboot.
> +2. **SD Card Boot**: Creating a bootable Bianbu SD card and optionally
> +   replacing U-Boot on the card.
> +
> +Tested boards: Banana Pi BPI-F3, MusePi Pro.
> +
> +
> +Chapter 1: eMMC Flash (U-Boot via USB Fastboot)
> +===============================================
> +
> +SpacemiT K1 U-Boot Flash Guide
> +==============================
> +
> +This guide explains how to flash U-Boot on SpacemiT K1 based boards. It covers
> +flashing images via USB fastboot.
> +
> +.. note::
> +
> +   This procedure flashes images to eMMC over USB fastboot. The fastboot
> +   function is not enabled in our SPL yet, so the download stage runs the
> +   SpacemiT released SPL; our built FSBL.bin and fit.itb are the images
> +   written to eMMC and used on the next normal boot.
> +
..
> +Prerequisites
> +~~~~~~~~~~~~~
.. first label here

> +
> +- A SpacemiT K1 board with USB Type-C and UART access
> +- USB-to-UART adapter (3.3V TTL)
> +- ``minicom`` or equivalent serial terminal, configured at 115200 8N1
> +- ``fastboot`` and ``flashserver`` tool on the host
> +
> +Hardware Setup
> +~~~~~~~~~~~~~~
> +


...


> +Chapter 2: SD Card Boot
> +=======================
> +
> +
> +SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
> +==================================================================
> +
> +This guide explains how to prepare a bootable SD card with Bianbu OS for
> +SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
> +card with a custom build.
> +
> +Prerequisites
> +~~~~~~~~~~~~~
second one, so this trigger a CI warning, snip from the log..

looking for now-outdated files... /builds/u-boot/custodians/u-boot-spacemit/doc/board/spacemit/k1-mmc.rst:186: WARNING: duplicate label board/spacemit/k1-mmc:prerequisites,

so how about adding an additional name of this specific procedure?
for first:   Prerequisites to flash
for second:  Prerequisites to boot

-- 
Yixun Lan (dlan)
