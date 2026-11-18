Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E6606A320
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H/XPZnyD;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ina/v1zP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BE6640897;
	Wed, 18 Nov 2026 19:26:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqmyoJociOmL; Wed, 18 Nov 2026 19:26:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B4EE40884
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795029978;
	b=rmAVKg5stdcTRYVgxa+ReXcyQ5/4o97Y2fSj1gxis/9SE7xJxmzANBc4btY2ji+8xoR+
	 GFwggSCEK+6n91Ri/mqRAtxv08NKvxqZA8g9YGVZL7HnxnMNddkIwbx52Z4N+4Nl3TjBA
	 cvInKnbcJcWj9qu1HHVh9G1lLev/ugiH8UjFwSoNTDKNzXkrzyo4F3LMZHeVOM0p5jx6u
	 Ynbip4HlJhcMtjLLn9GzhU6oe156coK9NqetMo5qRUnG2mKPv1tsqXXsVi+Hv3ycsi8Jx
	 xlWZa1Lz0/T+8Y9yLw0F/1gRaxyM0ZuYRDpkjv2vHVV0EswVNQiODxpjTq46vMhcilQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795029978;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VD6rJK3z9NCH1uOn9E0ZFlUX30nJToKjrH+i34mxibY=;
	b=r160KCoXnwPtUqkRjXuzJyiG15qZSU6LHyApOUghuIs36l/jsrljE7rH6rhIyFnz1LUi
	 1MBk/pDX+3XC0nGZGiNhxgTJbamW1wlxyfRuypjoLTjiBm+uTl9s7a8hMWDxdK2OxwkBe
	 PL1APoTpxussh2IYDP+G5FNMYIGIOAgg+hJrC0cz89i5yyrsB0FbTlIGaK2L3Q7Eem9SE
	 zb3KFKIsSeV747Bf1tv4SxTl6rQVA9XhiiTNpGd+9PpovgFismV1lSKRil1MsoQQ2FLLy
	 7J6NhH8Bh0cBsbnF6FUMz9YS/H18toy+JGlB1gQTJ76Rz3H874DcM22RrwfWGxynFbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795029978;
	bh=VD6rJK3z9NCH1uOn9E0ZFlUX30nJToKjrH+i34mxibY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H/XPZnyDRo2hBWcU+xkUm0710KHWKNKQyeN0NdnZfBjC+4QeAZ9M6My+9sqmCTX7d
	 vHqSuh22WE5dCudF96ijN5cFAXLvxsTZt3UDoAQKcPX7rJZXmUcwJcmkLrxQlfjMxl
	 VouUmc484VFB3Np1Kre31GesWZvLgKmE0QrXZdVv0gDzGVLQsUMDLGnCwqk0Q5Jw+J
	 SwXDohj34/0oi5LCoLIfMAdmo5U8RRVd1wJFZFDc9ak3gSiUMglrZoU2Jvj7BECKoE
	 qpCrpCFRg5K4QIjiaFcrTNhBi+cOt+TKZP9pioQ4rjUlqJcdRhxdWNyATbRjYdqzvW
	 yek6tCkX0HyfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6B4EE40884;
	Wed, 18 Nov 2026 19:26:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D63313C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F2CE400A8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:26:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLCn28_ptT4l for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 19:26:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D7C6340095
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ina/v1zP
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7C6340095
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 19:26:12 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c50cc7540b7so201924666b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 11:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795029970; x=1795634770;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VD6rJK3z9NCH1uOn9E0ZFlUX30nJToKjrH+i34mxibY=;
 b=ina/v1zPWF8hNWd0cL81al61wuaM4PXOT8S7EqjeZqEBm+l/HdT4MgRFsQx/QzSDM1
 HKu3jSmvUJW/C+WRgbz+DktXOFhjVsCMOoQ8A9zBDmf7youDgK44xO2tfEW9COgOQhTU
 VeHJS5G7rVa0YM6A7HRccUUe39wl6hWFZFECBD9z1VS5DTGMtqkA/sOZwXB3w7D9npNJ
 OYjLjwyVO5FAuHEBIIpvNpMYlmhEEUEuI241vsmQXWPyyH5yeXjhR/Y+qXOLIE42NwFq
 oNGOxt0ALwt9mgVqvWVurI/4tmbMcLbyA4k0qS2WtzckGRHmxGH68IoqRWGr5Xlvd0a2
 zXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795029970; x=1795634770;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VD6rJK3z9NCH1uOn9E0ZFlUX30nJToKjrH+i34mxibY=;
 b=vDyCN59THjQIyl5ljvIhpYzCMXmA1EKWU3/Yuzhq4Vb1OCNdoJ8OJOuNvBfYwBseKJ
 52Cjzov7BTwb7qEtBl5XkEAlixEL7Rj3O5LEvD3zxuSX++ZFi8/BDZpeQk4fnucdHjqT
 HVaXslNXbQB7NzrxJhIWLfLcSn5zM+Io1VkHo/N1aQmpmMH93TAV43Sc/E8BxtAD2ARs
 +SFriwWQNVBVDhY6OeY6hNxi6Jpm0m5kzYPkXnZ3Gurv7GiJ3obLVRuMdvhfVWCL8Djv
 V0VT61sfzbu35BSa+Ehh80nZ17Zzdn/t4WGw2/CJkvISVBpb2Fefga70D3D/uFmvy6ot
 g2rw==
X-Gm-Message-State: APuU4Z8vIHDyv0JPXo/2+CmB7EtFE8iq0vdkRQIRuLIMs4srvjqkuz+a
 sWCzick499nAZakKEi74uUtPhSXu9liY4vH8UoRZWBs6yXxlS2lWn4oEfXAFJ++1X1OqkETeNs/
 kqygQEAhgtofpIq8t6DFtc7D3fQwP+8E=
X-Gm-Gg: AYBFou3njNwlcqVJfJhgjEbtnvTPvCTZFUijdhOIaeXoffCieCroJK0WYW1nba4mZl6
 UZMbVQFrC1QY8WAnsm3ePQTeQtLOB9Hmc2jRlGldKDZhp4yGJm7huuiVC0f1jNFadnPVTEWhqle
 x3VMCEyHZyBky18uhVWi/aHrSmWTu3zIxqPAhzrpwWEbDQrx4guDr3+qxDSoyGZ1x3yds91UxoY
 mTJehk7o3XfkvsL5+CVpz/3EZg4UHRf0yOaq68F/9QKbC862uST63Kj+RtzadvynCnPTRiP4wAc
 dQ6lqPJhliR7unACw3PLeLqrZC03heN+qt9kZBZfRW1BMxe/say0lLcZ4g/iWcIkv1aHUXjqqs4
 gjR8Wlw94BEJmkbNIV7EECZtHew/nfh1XkbvwgQ==
X-Received: by 2002:a17:907:3d8b:b0:c3e:ee86:d2c with SMTP id
 a640c23a62f3a-c510e39f83amr369375366b.27.1795029970159; Wed, 18 Nov 2026
 11:26:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261116-ddr-multi-v3-0-fe9fb30a3169@gmail.com>
 <20261116-ddr-multi-v3-1-fe9fb30a3169@gmail.com>
 <469c26c9-c2cb-4007-abf9-5fdf5ea0acde@cherry.de>
In-Reply-To: <469c26c9-c2cb-4007-abf9-5fdf5ea0acde@cherry.de>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Wed, 18 Nov 2026 20:25:57 +0100
X-Gm-Features: AclHuK8a4MokWXEUzlICI8Gnf4mXtUuvsUx3nZ_-RFsLP7eKJzfRbGzhHkls3XA
Message-ID: <CAC928HZGjwUzVcABE1TK+-nij_8C2f=xKWHNDAQpO=9RRu6LsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ram: rockchip: improve sdram type configs selection
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno mar 17 nov 2026 alle ore 17:29 Quentin Schulz
<quentin.schulz@cherry.de> ha scritto:
>
> Hi Massimo,
>
> On 11/16/26 7:39 PM, Massimo Pegorer wrote:
> > Not all the SDRAM types configuration options named in the Kconfig
> > are supported by each of the Rockchip SoCs: improve clarity adding
> > SoC dependencies to the options.
> >
>
> Considering what I said[1], I'm wondering if we shouldn't simply report
> what the driver (seems to) supports even if it doesn't actually use
> #ifdefery and the symbol state has no impact on what will make it into
> the final binary. I haven't decided yet, so this is an open question
> rather than a suggestion, and this applies to the "thought: " comments
> below.
>
> [1]
> https://lore.kernel.org/u-boot/9d263ab1-5880-42d0-afc8-2f2ebdae4a95@0leil.net/

Happy to discuss and share opinions: hope others will join, too!

I would start from: "What is the purpose for?"

I expect a config option value to change the final result of the build. And
I would prefer not to see any config option that is not relevant to what I'm
going to build, at all.

As an example, if I'm building U-Boot for RK3328, what should happen if I
choose DDR3 or DDR4 or LPDDR3 or none or any combination of them? The compiled
driver will be the same in all cases. Would you like to raise an error if none
or more than one is selected? Or instead, should the ROCKCHIP_RK3328 config
option select all of them? In any case, the DRAM params will be defined by
the Device Tree, and everything will work even if they do not match the
selected option.

In the end, the only purpose I see here is information and documentation.
I do not think that doing this type of documentation through config options
is the best way.

But let me know your reasoning, please.

Thanks. Regards,
Massimo

>
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   drivers/ram/rockchip/Kconfig | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> > index d707d09c1c8..74422947452 100644
> > --- a/drivers/ram/rockchip/Kconfig
> > +++ b/drivers/ram/rockchip/Kconfig
> > @@ -26,26 +26,26 @@ config RAM_ROCKCHIP_DEBUG
> >
> >   config RAM_ROCKCHIP_DDR4
> >       bool "DDR4 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
>
> thought: add ROCKCHIP_RK3328?
>
> >       help
> > -       This enables DDR4 sdram support instead of the default DDR3 support
> > -       on Rockchip SoCs.
> > +       Enable DDR4 sdram support on Rockchip SoCs.
> >
> >   config RAM_ROCKCHIP_LPDDR2
> >       bool "LPDDR2 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30
>
> thought: add ROCKCHIP_RK322X?
>
> >       help
> > -       This enables LPDDR2 sdram support instead of the default DDR3 support
> > -       on Rockchip SoCs.
> > +       Enable LPDDR2 sdram support on Rockchip SoCs.
> >
> >   config RAM_ROCKCHIP_LPDDR3
> >       bool "LPDDR3 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30
>
> thought: add ROCKCHIP_RK3066 || ROCKCHIP_RK3188 || ROCKCHIP_RK322X ||
> ROCKCHIP_RK3288 || ROCKCHIP_RK3328 || ROCKCHIP_RK3399 || ROCKCHIP_RV1126?
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Please remove the Reviewed-by if there's a v4 and we decide to go for
> more SoCs in the depends part of the Kconfig symbol, thanks!
>
> Quentin
