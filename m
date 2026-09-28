Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1A0CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 14:45:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 504F380EB0;
	Mon, 28 Sep 2026 14:45:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fNsx9kDL_V4d; Mon, 28 Sep 2026 14:45:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 265C680EDB
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606730;
	b=Ubg7Nft/shXItXQuJZtOflXv22QTUjpk6tTmrWXguMlVOy7QzuUSoUAXc0QTJfOWSFwe
	 yzO5mPYX71ekhdvmi31wHEt3LgJQkXqj+DvIdIziN0zknuCFuVe4OzxzCYRLIRDfw4Kx4
	 VzSNr8uFuUowI95ySvX4uyRwDS5vMVrd3IK5NCdcfmnQjCAI/tuFSBogzzsbCHCOlApJS
	 amIj5Z5nUDPO1riyRK7761IE9hReLQU42GrmpFxz0utz4SZiUmrh+ONOIK5vOVSsH/fYD
	 WvKO3CtKKUvpKFVt+gvyxya04Toaft56wMZzAPnProJqVp6UtfemMQ3hBYa47GW9uHQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790606730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=crJ3TwoFOuAlNNW4PdTREHQYdjSsb1mlILVkW8wYFQo=;
	b=mYQFE2Tp3A7Om0lhMW1Mpi8rVwv22mukxJgRoMMJej5ggnO0iAthvEOtCdI6p8zKyaI8
	 yyDqE4Xx2L3OBFEZuyLSpSQtnLH4yNLsva9vDbE98ZfB/rwsIw5Za1TpLecGchbtJph2J
	 TYFmbNX5LmnHUTCcaQLuuJ6aYI8myKU/gvnRD6TjJ9luxOxB3hA4m7VZSIDJ1P+oRiXCI
	 Ij5gv7WZgV9/A9tY4AfgmylcVKpcDFVlRJS1PXq8TrdU+9HYiBjbixjvJvN6vaBx3ziZa
	 OxMFCYgZQYkDRbBcarTb1UpcpnWkgglR9r/EyVA+34AEneLthNCRa8oywuZ8av45S9w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790606730;
	bh=crJ3TwoFOuAlNNW4PdTREHQYdjSsb1mlILVkW8wYFQo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fFU4ItbMl140/rYP3B+RdjzYpQXFB4yh6gSZmWk6suVafTfI44eZcZPoaMSLmwx9m
	 kqmJO9HfvvsYzBtRW+z9DFD2Cnk4OZ/ODL06XP0gkhPwdnY5I0CNukM+R0of+7PCA2
	 yiZ0i27ksVKivcTuz+7+piFKnbfiIQtFjaftC1IMY9i+5c9HHdWijqjoQgLrjWGbhQ
	 +BBziejKi4VYO4AOCJi129u/PYH+hUfwGj1OsbwZ/Awa5GKt/hxlpQ88bR2zAmAFON
	 ffEInPOqV7rwFWyF39Ax3qEnD3KrY7lo7uTK/xPPzB3+1LPXKFbYu3loYJFuG36Emd
	 kz2u4HTsSp7rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 265C680EDB;
	Mon, 28 Sep 2026 14:45:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ECEAD361
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1EEE40232
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l8rrM4weXCNB for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 14:45:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 390B440231
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790606727;
 b=bVWrAPgTLPmxT7Xbkm0OvjlxgFcgJNDbFjTboLJe5ZlHN0L+OYxKnw7o1DHLbTOHnhpc
 R5zgrIu4r0+iUmnvw3Tiozbmp/ndZQlb7YwFK+dP+afH3v26Z+RSDtvIdgTF9g+nN6Liw
 Gsz3yO7UTlAZ21wta+eMEKhnSIEUYAoZSZiIZg9Rp7GHW5+TZViZVtQftn7E5CW3cJpGA
 YGjaTLB7i51MqjvEQzVw0ynOA99VgQrZApnvQUT0GKbm1489F3JpWxySfsGshVCrxnbBn
 RMhjEvBOc7JTNC8m4n4dJy1r3Zd8fIoyRSiT2KAhnOnV7YPcsbYRfTsSzinBpKgo7uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790606727;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=crJ3TwoFOuAlNNW4PdTREHQYdjSsb1mlILVkW8wYFQo=;
 b=W1a2d1DnDSlyy0C0EPpTTmblUPGpbPw7JwKj1Kgan4CgklrZmW0EbVX9D34Gy2OhXyYu
 2bgt6VNx3U+Ry7wFDB6B/owTcJ7R4b/9rEmGBeZkUVvJszm+uE0z8BOIhd8j9oLrYj9mc
 DSigI0fdZLmypHtbZzGstPTj9Idan/czPfHEIqtEMxyEs1KuGFDqUdNt3sdELjU+eieB9
 K0EjuhIxGx4+N0OE4cXAAsVdtjcbygZo1Coo/S2kVJ3PM0K50tee/QFYG9zciCT+HYyeP
 1lWDfcP0ABgPcN7lniEcD9/GenyIuVHByDYk0t3cqBqZ9Xc4Qro8XkRzW2QTqTqQDXw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YTIeY5Cb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::e;
 helo=mail-ed2-x0e.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=YTIeY5Cb
Received: from mail-ed2-x0e.google.com (mail-ed2-x0e.google.com
 [IPv6:2a00:1450:4864:33::e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 390B440231
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 14:45:26 +0000 (UTC)
Received: by mail-ed2-x0e.google.com with SMTP id
 4fb4d7f45d1cf-6aafe2a64efso3048137a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:45:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790606724; cv=none;
 d=google.com; s=arc-20260327;
 b=OhMu/h4vg2qZPfv2NCKJP2K1Ko5yA26Vs8KoWbYS+x49/oM8pXa7TdbxT6zaN7P4KO
 sbaAyS6YBO4upkuN8ECOPt0Kjgj3AClsguhevwxYTF0c3eLGzcfmaENNzNTPG8awXK2E
 IUseC2HfybIQV5htdSct97sMZRutnR4XdYvqi44axRljTrjrb6cfhNvplZeCjb3dj3Uf
 ZlLW6nWP28Tw0KRAETSUwSfmeceNt04KSo/Phy3SL/j8prTRIptRyCQl+9BS6YK3i13A
 B8KvgK5pyHTc7LbGanwyS/jI+zHkwy7qAdxc6lmzWjvMLV2U8ZUxOrE104BGv6El0zc1
 408Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=crJ3TwoFOuAlNNW4PdTREHQYdjSsb1mlILVkW8wYFQo=;
 fh=oBbjtIpEUKdkfF8M4Lb3a8VoelWjtqHoput/N7L//rc=;
 b=ZePxh1Dlu0eBNwhSZGQbuxrPlhRCUIH9FG0+oSVOKzpXL8Olll3AKGEPceZENnkNy5
 1QkqhSE63Nhn9JxZbWBKPt8MCmWy7qA0EO1LNyTaG1hQbLrOdHYO23U2TGvNylSWQlAP
 jXUQVWWd69l/tAbZdvvJ8vEScGoqpmNDvv/iI1hMXEKISCQNj3XB7mEB6hHYubJfJBfV
 WUhcIu24h8PZkXqjWUfZQSOFheQhEPuNkjN1ZDpRvMyWGX9EoM0zakGrtU3VfV9sOJcF
 JDJW/PP4H76mVGdtDY9zTdhC11UqZjkdJetbDJPMJR1BAJZasoEA8kqhZIek+avw2yZG
 X2hQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790606724; x=1791211524;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=crJ3TwoFOuAlNNW4PdTREHQYdjSsb1mlILVkW8wYFQo=;
 b=YTIeY5CbOkAy2YDrKylKS8P29KiqjkwCb2cINsYl8zHbAoM/nLqoc8UfdddnOV7yt9
 yrGfJQpkTBI9q3LlhWyEe17guuJGFjmgs/cnWEMLuG7800PBCK1eOkNYZ6yDkuVz7oYi
 WhuNhYOi99/0ile8+wtgZKSF7TpzGq25LCkn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606724; x=1791211524;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=crJ3TwoFOuAlNNW4PdTREHQYdjSsb1mlILVkW8wYFQo=;
 b=BsyTa9NTKrqSPSmQllUkr2VjWCNXegQKpCbceuanKPKijFfVpqCXPcMx3OdZkYQghc
 HWVf0X1TvhrHplrq7CMdWcCtjJZNhpbtSOeDQF/YUrepewPtCXrVtUUFU1mExY/yhYHW
 csFX3IHDuc9UwmdkQlyE6N5+VKSxqlMgjwp+pVvrMhJkQyxrvdV/zV+Q5Qa7mYsbntMt
 Pq/T3prnil9UkN0I1Wqj34TmOKFqaz/bM+iGfNCWvsDn6iJnjbntpoofO5LZUVIgcBvX
 8P+3Evj2GdurU5bPwMVu86JlkAdz4foRUyBnKyj3aSGnMxrDpk8CHn0VLNMBDZpGundB
 MvxQ==
X-Gm-Message-State: AFq9FYLMsCmtiODez6mkY3dWz0JP2ItKVS5eor+RKuDEQ8ieQGTmCmXI
 EBHlMHrAFFFCAYUlRcBN+nIFUvZ0AAMi9VLZb4P991JfOpfjR6RQcdrb3I9v9d6E0I/7Ps8Csvo
 jpzhg4uIlWTWBbe2KQrf7afaMqwkPjz7qe6okCKUF
X-Gm-Gg: AYBFou30x8gIAEvqwttnP1IgvC9fPXPrZg9owOEBfYmglKn8CiODWDibTi8DaLnCqJz
 8d3vEQyoJXVU7HXLDuwugNyFXu03yIjB07afQQNWUyJNBZ1QVS43/JGHmuj7hTTT6PFd1bxWz7s
 Jxr5hr9N3TUWho4N6R8ORq8ZdTMyJxXP/ur8IW4fT9sbFN1escgTQsJYcYTwNwmoPZBctNpH0Hn
 w7VcIvEIdzRzAEovPd0Px7D+0ReO5APGTiOPocOYf1J9vC5EPhhqfHAG/RB3hh4Z6iqwvNXTKbz
 PTX5V42wVncu6NjsMJS6RDH41wD4QQrEc16DlhBTOG1fgJ47npPpWA==
X-Received: by 2002:a05:6402:454a:b0:6aa:f630:f855 with SMTP id
 4fb4d7f45d1cf-6aaf63106b2mr4923787a12.30.1790606724537; Mon, 28 Sep 2026
 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260922060941.534035-1-hs@nabladev.com>
 <20260922060941.534035-2-hs@nabladev.com>
In-Reply-To: <20260922060941.534035-2-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 08:45:07 -0600
X-Gm-Features: AclHuK-egGZIncYRSUtUgCUucImc54YBu0BKH5pfJWZHbfpoOOks-H-OiuKc8ZA
Message-ID: <CAFLszTgKFvGkH0OKpkffj7YpgqX98+591tnADOZVxBfX85L9Qw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mtd: spi: add driver for the Microchip 23LCV1024
 SPI SRAM
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Vignesh R <vigneshr@ti.com>, 
 Simon Glass <sjg@chromium.org>, Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Guodong Xu <guodong@riscstar.com>, 
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Ssunk <ssunkkan@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Stefan,

On 2026-09-22T06:09:29, Heiko Schocher <hs@nabladev.com> wrote:
> mtd: spi: add driver for the Microchip 23LCV1024 SPI SRAM
>
> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on an
> SPI bus and used as non volatile scratch storage. Bind it to the
> spi_flash uclass so that the sf command reaches it, and register it as an
> MTD device of type MTD_RAM, so mtd command can be used.

Is UCLASS_SPI_FLASH really the right home for a device with no flash
semantics? The uclass allocates a struct spi_nor for every instance
and every user of it (sf command, bootdev, MTD helpers) assumes NOR
behaviour. It works because you shim the fields in, but it feels
wrong. Have you considered driving it purely through UCLASS_MTD, or
adding a small UCLASS_SPI_RAM with the same ops? What do you think?

>
> The device powers up in byte operation, where every command carries
> exactly one data byte. Select sequential operation once during probe, as
> Linux does in drivers/mtd/devices/mchp23k256.c, so that a read or a write
> of any length is served by a single command.
>
> A RAM needs no erase before a write, but a caller that asks for one
> expects the area to read back the way an erased flash would, so both
> erase operations fill it with 0xff, which is what the sandbox flash
> emulation leaves behind as well. Leaving the operation out is no option
> either, because the uclass calls it without checking for it first.
>
> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> configs/sandbox_defconfig |   1 +
>  drivers/mtd/spi/Kconfig   |  11 ++
>  drivers/mtd/spi/Makefile  |   1 +
>  drivers/mtd/spi/spi_ram.c | 280 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 293 insertions(+)

> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
> @@ -0,0 +1,280 @@
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <spi.h>
> +#include <spi_flash.h>
> +#include <vsprintf.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/spi-nor.h>
> +#include <linux/sizes.h>

The linux/mtd/spi-nor.h include is redundant =E2=80=94 spi_flash.h already
pulls it in =E2=80=94 and it advertises that this driver is a NOR driver,
which it is not. Please drop it.

> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
> @@ -0,0 +1,280 @@
> +static int spi_ram_erase(struct udevice *dev, u32 offset, size_t len)
> +{
> +     size_t step =3D min_t(size_t, len, SPI_RAM_ERASE_STEP);
> +     u8 *buf;
> +     int ret =3D 0;
> +
> +     buf =3D malloc(step);

I wish we could avoid malloc() here?

> +     if (!buf)
> +             return -ENOMEM;
> +
> +     memset(buf, SPI_RAM_ERASE_BYTE, step);
> +
> +     while (len) {
> +             step =3D min_t(size_t, len, SPI_RAM_ERASE_STEP);
> +
> +             ret =3D spi_ram_write(dev, offset, step, buf);
> +             if (ret)
> +                     break;
> +
> +             offset +=3D step;
> +             len -=3D step;
> +     }
> +
> +     free(buf);
> +
> +     return ret;
> +}

Two things. If len is 0 we still malloc(0) - please return early. And
each loop iteration calls spi_ram_write(), which claims and releases
the bus for every 1 KB chunk. Since you have already put the device
into sequential mode at probe, one claim/release around the whole loop
(or a helper that emits one WRITE command and streams the fill) would
be much cheaper and match what the data sheet allows.

> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
> @@ -0,0 +1,280 @@
> +     mtd->writesize =3D 1;
> +     mtd->erasesize =3D 1;
> +     mtd->_erase =3D spi_ram_mtd_erase;
> +     mtd->_read =3D spi_ram_mtd_read;
> +     mtd->_write =3D spi_ram_mtd_write;
> +
> +     flash->name =3D data->name;
> +     flash->size =3D data->size;
> +     flash->erase_size =3D mtd->erasesize;
> +     flash->sector_size =3D mtd->erasesize;

Setting sector_size to 1 makes the sf update path in cmd/sf.c drop to
a one-byte read/erase/write loop over the whole region (see
spi_flash_update() and spi_flash_update_block()) - 128 KB of
byte-at-a-time round trips. Please pick something more useful (the
32-byte page, or a larger convenience value) for sector_size, even if
erasesize stays at 1.

> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
> @@ -0,0 +1,280 @@
> +     sprintf(flash->mtd_name, "ram%d", dev_seq(dev));

Please use snprintf() with sizeof(flash->mtd_name) - the buffer is
MTD_NAME_SIZE(MTD_DEV_TYPE_NOR), which only just happens to fit 'ram'
because it is also three characters, and any future change to that
macro or DM_MAX_SEQ_STR will bite silently.

> diff --git a/drivers/mtd/spi/spi_ram.c b/drivers/mtd/spi/spi_ram.c
> @@ -0,0 +1,280 @@
> + * Copyright (C) 2019 S. Bigler Securiton AG
> + * Copyright (C) 2023 Heiko Schocher, DENX Software Engineering, hs@denx=
.de.

Nit: please drop the trailing full stop after the email address on the
2023 line - do you have an email for the Bigler person?

Regards,
Simon
