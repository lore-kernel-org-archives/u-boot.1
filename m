Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADB4CA5FED
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 07:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 770316082C;
	Fri,  9 Oct 2026 07:07:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CNcwilnJhYb; Fri,  9 Oct 2026 07:07:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AA0646084A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529629;
	b=ntF2fuqX7FQNL73sxZnjVAPw2YLzu6neLbv2V1affKWDD0DbZ8zkkfwEbrLNysvnx8l+
	 h8FYxDQuNLl6mTZU5T7j4JCbdMCwsOiMu/L/V+vYVBcJW5lxer0I6FIfnC0n2ssVMWrt+
	 YP0oSH0vFcIvb9CX5dVQZbzpVFkqws6cxSxp5lQzyaGyCckFQA87vuuSW8JGKRQU7QWzk
	 3/sjG4rC3GNPcr4M6Gvz6AmEB7zqmRqldKtBB7y84WXj8e41Re/iMq+tql7DeVuQ9CszH
	 DzOiDcPiH80TTGCJFZMShU2Y/zHQS41QITmWYtLaLfmJmsFQgZGCZa/eOMTjJnAmW0g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791529629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eLigQmE1YIC/x/l4Bm6AJ2quVZy7O3tasg/g52s1kow=;
	b=ioHXfPrwtqW/TX/1zoUbEPlR8+EvAbQwH7qZCI6PFReYXRCqSt7VPqFW9DDzbaCvqrGh
	 i4JZ+NlIL7+id9wUO0O2D9r8sJnVHeLDTEO64GLfdjdOm23VK6ZpmnyGwnuDVssBYpklQ
	 QzvxQQWtmWJN3M5U6AfA/agwkgxJBH2dqjrrLewm4QIAmCHzBqAfGcYR48g0/PN9IzujU
	 oFikaL9vH1HInwKgBwLoe7ZM38eeVbDBx/2xT5M8ZSamrC53dlALD8v1ZKliDELqq2j4N
	 CRLRr+xPvZv/NU7JJeebJoA+HUXm9CsmR0m1kC1PqyOvM3NJG2bWIozCb1ChbtbDGYA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791529629;
	bh=eLigQmE1YIC/x/l4Bm6AJ2quVZy7O3tasg/g52s1kow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iCfkBNOFryt9mytbPpjtgFmiHxpExDY8GIpLnQ3JYEVATf+hHWOPwX6Mmb1eObXg+
	 lNdhREKFL+k154+c3hVCjpRpz/tkAbOZdKEBjVGDhPARajLUu6aGz75lsKN3Ey5T9C
	 z0orKFP7EcfqtCHjsdqf8LApd/9DcKPPCKvG9WSKevaRZTycEP3B2q67vHrl8SXLx0
	 /aZQiaVpq2VaEHk25uTZ0EV8BVbw+LGCzEnUx6mvcg7dutRortbm5cYgFfcU71KoDT
	 /byT155+zZqevD+p9rjAmobi0LIik2FRca8wOlH0jSW/4QcUtWTKVVEr2Hut8cnkEb
	 +b5GVs5jNR4Mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA0646084A;
	Fri,  9 Oct 2026 07:07:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D6CF61C6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C7D8A81460
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fxY_HZA-WJBy for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 07:07:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDB198089D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791529624;
 b=C7KWYnT2mN3GafYnuCRHi2Xr7uQka4nkDE7St/SwNyDXSHxqhw/z2cAzqupA0Ba5peL5
 UQGzpWV8WUOWsjriuPUm1dGIUG75V0P9MumBa5n5NywmENuWXfqiw9061OtwQOjyJ3iJW
 6p0hEKtVciydj72mqajIa7ZAt/q0uaPOfNx8IY8YfiW4GzQ0dVPi/mXLGmO3kyLu5Hh6b
 yycsp68hEicqJF7vRYGPkveVztQptcOJa6aaKFpjsf1J0zUwPkAf/fQ0H1a9i4sxdQGHT
 oqI3/PYBLXr8yRKfGyCBF+dN2u5oR1+QGT/6epjUQv2AF5OmHrMcl3adPCxYB9Je6Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791529624;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=eLigQmE1YIC/x/l4Bm6AJ2quVZy7O3tasg/g52s1kow=;
 b=qv89uqH5fgPeX5ycBMRMz2dYQRcqveN0r5SO2XBbkyuZynlp4TB4HMfyJMAMGt8e2LwG
 OWpjhRaI4pj0notoiVnmITMb5DV8pKhbgfMBLAyMGfL5+urDJ9r0MBjk13itiXdV8D3cJ
 I8aJr0+21NyWHlRfrFPZ+RXYmgj7sGBY1JEZyryUQ5pqzrAT4AdQ/YtgdfFD6cUvjRzA4
 kOe4OXWvIwu1x0P/kjj9oRs37ZbZrqbsZmGhGWBNs3+VDsyrFqmdoPec3qKKygy/YgtHk
 CKH1AzRcEun+5ALrCTBG4HXhi2mso6RN3NeIAeY03UaPKxIkIRb53AIc8crvXjE0lvg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LZced6gZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=LZced6gZ
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CDB198089D
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 07:07:02 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6afe29c08ccso4994634a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 00:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791529621; cv=none;
 d=google.com; s=arc-20260327;
 b=GcAgJJuzgyt/NviJkDy+GKMjk2QuXq4NX4qHEjXaAJMqEHbnjZ/y8qwyjog7q0Kk42
 +zJOcZTVbCOSFjzm5pgn/z8kfSU7/CwlixQtexmkw0B6A+FM5mDrLtF+9stnhcFbsksS
 f9b8Rsz2t66cUruNGn/cdUdavrW4k54LS01yegWWK5imlvKEet7AitKhkzcLtjneK5ro
 fO04V9y0+AdzVQS3MwZ0T4tdObOorjKvGwYK2Yi6pAe8834JMCCj0VgQeDRIEZagk3YO
 UnsOS5n248E+ldLa/lJ2NIxcdm48E/Bvfkn+VtDwmOOsupsUuadtfOG5ve5WwKAv+M9N
 S5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eLigQmE1YIC/x/l4Bm6AJ2quVZy7O3tasg/g52s1kow=;
 fh=AsfHF+s10HJN/euzG7aPlmsWloRbPBYenO7cyXU03o8=;
 b=KEJiDCQCvGXouF47pLcwo2sNk4yMv8IZGbEa9alCnlNHia9QmjqWguFKDanItKKmS9
 HmFThtRX8GKs2i44O4PT+pFJMPVS7d1hFAUlo7u3G8j3oUcluWWs8ZmZ3PzwlF3V0b8Y
 CTwdiT8nPDvmnC3vS10v+zNRsFc5MCYmLmdC/KakrCa85v4+nOD0RSnyqfvgqp8cr53k
 PdsMem/WqxHJzNc3WJu4zQ8OFVDboy1KqdVjjs3gbedPRsgMzWdaaoAF/+zxHWSWJ1Nx
 HpitaHF7e+xzsKtiL3DUiRO3XFIPxHVRvqofy9XiCcHKgg6BkD4CuBTrAswEAKhTdW9W
 IoZw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791529621; x=1792134421;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eLigQmE1YIC/x/l4Bm6AJ2quVZy7O3tasg/g52s1kow=;
 b=LZced6gZV6fxKYh3zkO8eFPUnFKiAbMPPWvfgjVPdCKRCT8qzWdkN/4UIkBXyurEb+
 WFZYNmKCC1JExwHP2G3CLxfZILEKf5L/uJ7SpfrICXABFfhLdUtP/WBSsSD4o+VJaa6T
 fnoQm4hqk+jSYOWGSIviTO86Fq47uSwoIsApA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791529621; x=1792134421;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eLigQmE1YIC/x/l4Bm6AJ2quVZy7O3tasg/g52s1kow=;
 b=nfFFMOadLZ50i9P5UToRUTAv0St5m1FOuj9qPzHntDu2LFHltAkKI6fHQTavOvmOaH
 uZjBvouc/hINdeXnImt9qs77+zl0lFuwOfa6aXe4LUPzcW+549IWzOftSf+5NTbwEAM1
 dZg1vlS7JNiAShp11cS1ScwIS/YvydJRAw1qUf4pY6qH/jUaG2FNKqCtt0rfDEesNPhK
 E+lu279Z+TH1XUB1gCJHCb0si3QTx5GoEaq1cwb1nbpHxz0d6hVsEyUX7oJjFVwg+bXp
 uXRacT26cq7yNpj8tszNZuEmvF+AZiQSbT9/h55vHk8FN6I9svdCoFaBiuNIHwPuJvWr
 y0PQ==
X-Gm-Message-State: AFq9FYLPbwcoW59OaVWCOgcq9IluWxZCrYXO5bbUL6ChKS8y4b674IUI
 W/dU1qpO8axvd31Ye/JLOEyBqwRmXSGRdgKFHjwIdV8y7kCqjYtZRsrvYkohC0LUIC0TlUF2Lpw
 O7huGq4+rqpagN9l6DDHKZOYpgrbaOs8ZvTCivkeB
X-Gm-Gg: AYBFou2Xb+kz0DMx66BBukYbEqko8d8/FIwCTm/a7Uzs6rR7IFlQ/tJLgzdsLk/Niw5
 dPLG+b7Yb2EqV2nF9qqhYWkQeU4iue5UVCibK5FR29izwNVN4G2GBeXpDM4MQcz97R2s1oT6hNe
 z9eFfMTfGjZyMhRVyKH9N3oKVF7J4BfctTmJr5Ehvg3g65JJzcvxEG62FzIr1zoGj/HTRWHsze3
 ulK2xyYtKpnMU+a5qJ8LL/C4nH6d0Gpy0vuZ6Dg3H719/Y9Phi/PIRwJknhn7UTBNZrY28h8AEb
 rnOtU4VkGDtBg5+eAjIKihljqSnjulhPVqidAD+jknAgaw5YnLo14hU=
X-Received: by 2002:a05:6402:1f85:b0:6aa:e589:87df with SMTP id
 4fb4d7f45d1cf-6b17c2d4df1mr586863a12.30.1791529620604; Fri, 09 Oct 2026
 00:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20261004040657.3156402-1-hs@nabladev.com>
 <20261004040657.3156402-4-hs@nabladev.com>
In-Reply-To: <20261004040657.3156402-4-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 9 Oct 2026 08:06:48 +0100
X-Gm-Features: AclHuK-rbkmizf1MVEGpfcMnIW7r7jTfHp1q-tzwSRw5raGR5p58tbsji3xiHOs
Message-ID: <CAFLszThGYtvGYmYi1iOjRiqBANzbNSOt00n1HHzOWX8GXw3P0A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mtd: add driver for the Microchip 23LCV1024 SPI
 SRAM
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Stefan Bigler <stefan.bigler@securiton.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Tom Rini <trini@konsulko.com>, Vincent Jardin <vjardin@free.fr>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heiko,

On 2026-10-04T04:06:44, Heiko Schocher <hs@nabladev.com> wrote:
> mtd: add driver for the Microchip 23LCV1024 SPI SRAM
>
> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup, sitting on
> an SPI bus and used as non volatile scratch storage. Register it as an
> MTD device of type MTD_RAM, so the mtd command reaches it.
>
> The device powers up in byte operation, where every command carries
> exactly one data byte. Select sequential operation once during probe,

Just to check, is this right? My understanding is that the
23LC1024/23LCV1024 data sheet gives sequential mode (01) as the MODE
register default; byte mode is the default only on the older 23K256.
The Linux mchp23k256 driver never writes the MODE register. Setting it
explicitly is still a fine defensive step, since something else could
have changed the mode and the part keeps it while on battery. Please
can you reword the commit message and the comment in spi_ram_probe()
to match?

> so that a read or a write of any length is served by a single command
> and the bus is claimed once per transfer.
>
> Writing needs no erase. The driver therefore implements no erase
> operation and says MTD_NO_ERASE in the MTD flags.
>
> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> MAINTAINERS               |   5 ++
>  configs/sandbox_defconfig |   1 +
>  drivers/mtd/Kconfig       |  14 +++
>  drivers/mtd/Makefile      |   1 +
>  drivers/mtd/spi_ram.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 243 insertions(+)

> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> @@ -194,6 +194,20 @@ config ALTERA_QSPI
> +config SPI_RAM
> +     bool "Microchip 23LCV1024 SPI SRAM"
> +     depends on DM_SPI && DM_MTD

SPI_RAM, spi_ram.c and the spi_ram driver name are very generic for a
driver that handles one Microchip part. Linux already supports this
chip in drivers/mtd/devices/mchp23k256.c (CONFIG_MTD_MCHP23K256), and
the binding in dts/upstream/Bindings/mtd/microchip,mchp23k256.yaml
lists both microchip,mchp23k256 and microchip,mchp23lcv1024. How about
using the Linux names, here and in MAINTAINERS?

> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
> @@ -0,0 +1,222 @@
> +static int spi_ram_xfer(struct spi_slave *spi, const u8 *cmd, size_t cmd_len,
> +                     const void *data_out, void *data_in, size_t data_len)
> +{
> +     unsigned long flags = SPI_XFER_BEGIN;
> +     int ret;
> +
> +     if (!data_len)
> +             flags |= SPI_XFER_END;

This duplicates spi_write_then_read() in drivers/spi/spi-uclass.c,
which has the same flag handling and debug messages. You could drop
this function and use that one instead?

> diff --git a/drivers/mtd/spi_ram.c b/drivers/mtd/spi_ram.c
> @@ -0,0 +1,222 @@
> +     ret = spi_claim_bus(spi);
> +     if (ret) {
> +             dev_dbg(dev, "failed to claim SPI bus: %d\n", ret);
> +             return ret;
> +     }
> +
> +     ret = spi_ram_xfer(spi, cmd, sizeof(cmd), data_out, data_in, len);

A read or write of the whole 128KB goes out as a single spi_xfer().
This fails on controllers that only implement spi-mem ops or that
limit the transfer size, where the SPI NAND driver you are modelling
this on would work. Using spi_mem_exec_op() with
spi_mem_adjust_op_size() in a loop would cover both cases. I'm not
sure how much that matters for your boards, so I'm just mentioning it.

In any case:
Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
