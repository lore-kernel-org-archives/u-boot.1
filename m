Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99042E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 05:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB98895B2;
	Fri,  6 Dec 2024 06:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yPwTvRiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818538959D; Fri,  6 Dec 2024 06:23:52 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B2778938E
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 06:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so294081166b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 21:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733462629; x=1734067429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jYXHSqYI/x4hJ7oSyYaQ/IBdwvj0iq7ErzE0vnQv95E=;
 b=yPwTvRizvdbiGo9qoG6xqxW0uloj3YMgvNalD105ZgsOkSU3aSIzLy0lGD8vRzZWRd
 VS/aZJ+K0OkHslsRSYTxzmHqC7fPzUH7kOs9xenJ20TNqSm4xZdfTzQ05qGWHg7/n6d6
 r32trM2mIg+Q1B6tH+j8zgoyPUKJwX4jNQK6tWxfmsK0b0hvoy9jVWmyk//K1QdegXs9
 +Wyt2M00obC/9AsI5GBItQMIQLafQbIjlCMuHQQCiEaIn5GujI2iGTKMXPfcXci3dPio
 sR7snyisywmhLDXvPKLuHkfisPPC6+s6RT/eCJyneVEZoZu+jCHxomPdyO9X2t+3jW7k
 wmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733462629; x=1734067429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYXHSqYI/x4hJ7oSyYaQ/IBdwvj0iq7ErzE0vnQv95E=;
 b=K4YGhIqc72+e62XrGT9XXMIxCmE6+GbaM3lVHjDKUCmvsOj4GA/xFxjyyQaLL0rdjs
 i2xhDLKxpNjUforamwyg5bvGDoRvd8c4vDRd3sEQO78Cv6ipxMArXydrQHVPKiLMc0t6
 a3SOocrYfOyYVTBixIr8Evh34rW6cce+Cb47tveH4KYPz9ZvMMyhahMxZLnZHraFMTwF
 1cJoaAw7dHJWVf5UP4V3jP5z11yQUWiwsRz7RfSKfIACmKNpLRJNYf0uelgmZO0UFgvE
 RK0iKeMSFCJaHfqwTTjZoZQQDOYk4XLTfOEJKLyFRimvRrbUu4Sk2xe6YLD2R1WowfgO
 U69w==
X-Gm-Message-State: AOJu0Yyvns2Bn1ruAigDLOhksh2LFDokju6uC2lg8aTigGm7taLi9r/Y
 B/1cFuwXC//AQK1D6gUX6D1Zj0kD3ebF9CVaweHR5nGJNPhCVJvFbXIdHP/YiQUL/W3YATKZmEV
 6WqNhlQ4Nr3nt6YoCoRr8wqKEhaJ26PXsSnmWkz6OcTOWlp/pwiduoQ==
X-Gm-Gg: ASbGnctSsXBwoggng6HSpbqJWGRvkwAR4Bm4X5dLQoHboDsjG1w04MD5jI5A6VHKVMX
 tkW5EgQtxfu1bOSQUdTCwNR9mKoV5S5da
X-Google-Smtp-Source: AGHT+IHvkQoU9VwCM4+Iq20WYbrXtrMAAsrVg2h+zR5+oohg0b8wEKthXkVpVBzLYkXDrP0sSfeihGXhQgBl0iFsA6k=
X-Received: by 2002:a17:907:86a6:b0:a9e:c440:2c9f with SMTP id
 a640c23a62f3a-aa6219df7b4mr587044566b.19.1733462629521; Thu, 05 Dec 2024
 21:23:49 -0800 (PST)
MIME-Version: 1.0
References: <CAPLW+4=qP6pCN0xd9n3U5jBePJk2jEKgixCs1A_uBaDTwFLT4g@mail.gmail.com>
In-Reply-To: <CAPLW+4=qP6pCN0xd9n3U5jBePJk2jEKgixCs1A_uBaDTwFLT4g@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 6 Dec 2024 10:53:38 +0530
Message-ID: <CADg8p95bi5G48xZdT9+gqzKEByN4C3ZxfQHNPEaCX=0_559T9w@mail.gmail.com>
Subject: Re: [REGRESSION] lmb: add and reserve memory above ram_top
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
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

On Fri, 6 Dec 2024 at 09:55, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Hi Sughosh,
>
> Commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
> causes a regression on the E850-96 board. It looks like it could be
> not E850-96 specific though. During U-Boot boot (the most recent
> master branch, with this commit present), before U-Boot shell appears,
> I observe the next error message, which doesn't happen before this
> patch:
>
>     ERROR: reserving fdt memory region failed (addr=f0000000
> size=200000 flags=4)
>
> The memory node [1] is defined like this in the E850-96 dts:
>
>     memory@80000000 {
>         device_type = "memory";
>         reg = <0x0 0x80000000 0x3ab00000>,
>                  <0x0 0xc0000000 0x40000000>,
>                  <0x8 0x80000000 0x80000000>;
>     };
>
> And the reserved-memory node [2] has only one entry:
>
>     ramoops@f0000000 {
>         reg = <0x0 0xf0000000 0x200000>;
>         ...
>     };
>
> Here is the relevant part of 'bdinfo' output:
>
>     lmb_dump_all:
>      memory.count = 0x3
>      memory[0]      [0x80000000-0xbaafffff], 0x3ab00000 bytes, flags: none
>      memory[1]      [0xc0000000-0xffffffff], 0x40000000 bytes, flags: none
>      memory[2]      [0x880000000-0x8ffffffff], 0x80000000 bytes, flags: none
>      reserved.count = 0x4
>      reserved[0]    [0xb922d000-0xb922ffff], 0x3000 bytes, flags:
> no-notify, no-overwrite
>      reserved[1]    [0xb9230e10-0xbaafffff], 0x18cf1f0 bytes, flags:
> no-overwrite
>      reserved[2]    [0xc0000000-0xffffffff], 0x40000000 bytes, flags:
> no-overwrite
>      reserved[3]    [0x880000000-0x8ffffffff], 0x80000000 bytes,
> flags: no-overwrite
>
> The same error also occurs when I'm trying to boot Linux with 'booti' command:
>
>     Working FDT set to 8a000000
>     ERROR: reserving fdt memory region failed (addr=f0000000
> size=200000 flags=4)
>        Loading Device Tree to 00000000b912a000, end 00000000b922cfff ... OK
>
> Although I think the device tree portion above is valid, I also tried
> to cleanup the 'memory' and 'reserved-memory' nodes like this, to see
> if that was going to help working around the issue:
>
>     memory@80000000 {
>         device_type = "memory";
>         reg = <0x0 0x80000000 0x80000000>,
>                  <0x8 0x80000000 0x80000000>;
>     };
>
>     reserved-memory {
>         ...
>         secure_reserved: secure-os@bab00000 {
>             reg = <0x0 0xbab00000 0x5500000>;
>             no-map;
>         };
>
>         ramoops@f0000000 {
>             reg = <0x0 0xf0000000 0x200000>;
>             ...
>         };
>     };
>
> It made the first error message (during the U-Boot boot) go away, but
> the later errors (when trying to boot the kernel) still persist. Here
> is the relevant 'bdinfo' output with my dts change above applied:
>
>     lmb_dump_all:
>      memory.count = 0x2
>      memory[0]      [0x80000000-0xffffffff], 0x80000000 bytes, flags: none
>      memory[1]      [0x880000000-0x8ffffffff], 0x80000000 bytes, flags: none
>      reserved.count = 0x5
>      reserved[0]    [0xbab00000-0xbfffffff], 0x5500000 bytes, flags: no-map
>      reserved[1]    [0xf0000000-0xf01fffff], 0x200000 bytes, flags: no-overwrite
>      reserved[2]    [0xfe72d000-0xfe72ffff], 0x3000 bytes, flags:
> no-notify, no-overwrite
>      reserved[3]    [0xfe730dd0-0xffffffff], 0x18cf230 bytes, flags:
> no-overwrite
>      reserved[4]    [0x880000000-0x8ffffffff], 0x80000000 bytes,
> flags: no-overwrite
>
> The error messages I'm observing after issuing the 'booti' command are
> as follows:
>
>     ERROR: reserving fdt memory region failed (addr=bab00000
> size=5500000 flags=2)
>     ERROR: reserving fdt memory region failed (addr=f0000000
> size=200000 flags=4)
>
> It looks like all mentioned error messages are harmless, in a way that
> I'm still able to boot Linux, and U-Boot reserved areas still seem to
> exist in 'bdinfo'. But seeing error messages like that is definitely a
> nuisance by itself, and might be an indicator of some actual issues.
> Do you have any remedy for that by chance? Please let me know if you
> need more debug input from my side.

This seems to be happening because the board is trying to reserve
memory above ram_top with no-map or no-overwrite attributes. To
confirm, you can print the value of ram_top in setup_dest_addr().

-sughosh

>
> Thanks!
>
> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/exynos/exynos850-e850-96.dts#L55
> [2] https://source.denx.de/u-boot/u-boot/-/blob/master/dts/upstream/src/arm64/exynos/exynos850-e850-96.dts#L144
