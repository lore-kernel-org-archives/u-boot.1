Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67644C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 20:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEF980726;
	Sat, 26 Aug 2023 22:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ml410YmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE2FC80778; Sat, 26 Aug 2023 22:06:22 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD1C580702
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 22:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bbad32bc79so29927411fa.0
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693080379; x=1693685179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SrGxKKczcllrZNya5WFAU9M+SYHJxOgnVlHoowcIaNQ=;
 b=Ml410YmWzVdgu/3bGwO2G7yrebyPpxqbkhM+2E+tsvfeXQlRwltsc1cPqxFGRU6cpk
 10e6isCVGaC2yWec8CJiclfSJl0kKioPis1Q/+3uCZBeZA8x9w2u+l20P7E6LUmwHWfx
 /RnKnoJvCyqBidgkzkwL/zNATT4ysGnABiVMMdN9jjxWPeWayVPUN8YONpp0PJkjGleB
 zZlNMCkLuRCWq7ZP0PPO7VorCG3L/VEH16oFr+5LSHciqa3Eg/xBPlZGUQcW30YVWVt+
 DRvUaTlcxcg2RsdKJ+lwWbZ7HO+pxN007LX6Xohmr8mjYQ0YH8lCuPX1hCPinI4dYa8S
 M5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693080379; x=1693685179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SrGxKKczcllrZNya5WFAU9M+SYHJxOgnVlHoowcIaNQ=;
 b=QYJytXX3LQ1eHSDat9X5VhVRy/DYO4brZ8tIT5cRkBhjvsDEJ12q8Y9MNnQwZI1gNA
 hG3G1TZKBZ+Qxm6rsXSP0olY++VsmWcK/VjY5IrN1cy1qJ/+JqqjWkxE95HYP3SRCBLL
 fAXH8JFHObylsUvz52muklCuqS1NaeGdRGkDHIP1zXM+cHFXN1SwaIGdFmQKMDGUqhbG
 JkxSVE98qWbHrZR5Tgpgu+MEH2gjvpbknfPSHgpi1h1+Ha7im7TJphiXwVZWuyASRbdh
 FMVMs19ya628mGbU5QDbwEi9gAly/kxu0q693tIjv14YzNGVjq0MHPJcKbzktv+jbtCQ
 K6Jg==
X-Gm-Message-State: AOJu0YzpqxJ0MTSXG/MTee8FOxUX5DGYO8sZq3zQJ1KsHKkr/FLBkHID
 7PnJdvYaqa8pQAMMHOLP2Rs=
X-Google-Smtp-Source: AGHT+IFjo8ahl9NylOBuxPLga6cLA4NxiF5Kd70RbS5coJfFCWgxGjRaObO/zJpDdmXnlG+3LCRYWA==
X-Received: by 2002:a2e:8796:0:b0:2bc:cff6:f506 with SMTP id
 n22-20020a2e8796000000b002bccff6f506mr10767003lji.0.1693080378586; 
 Sat, 26 Aug 2023 13:06:18 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
 by smtp.gmail.com with ESMTPSA id
 p23-20020a2e8057000000b002b9fddc6d85sm902198ljg.62.2023.08.26.13.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Aug 2023 13:06:17 -0700 (PDT)
Date: Sat, 26 Aug 2023 23:06:17 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jarrah Gosbell <kernel@undef.tools>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Pavel Machek <pavel@ucw.cz>,
 Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Detlev Casanova <detlev.casanova@collabora.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Danis <frederic.danis@collabora.com>
Subject: Re: [PATCH] pstore: Use root address-cells/size-cells as defaults
 for reserved-memory
Message-ID: <ZOpbOcsTUFkxdh/5@skv.local>
References: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
 <f9fc81a5-1505-4cb3-8b65-798ddf16e1aa@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9fc81a5-1505-4cb3-8b65-798ddf16e1aa@gmx.de>
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

Hi Heinrich,

On 23-08-26 15:10, Heinrich Schuchardt wrote:
> On 8/26/23 14:16, Andrey Skvortsov wrote:
> > u-boot adds reserve-memory node, if it's missing, with following
> > properties:
> > 
> > ```
> >      reserved-memory {
> >           #address-cells = <2>;
> >           #size-cells = <2>;
> 
> This defines the size of cells for the children of reserved-memory and
> and for the ranges property. If you set the cell sizes to 1 you can no
> longer encode 64 bit addresses.

This will be limited to 32 bit only for platforms, that don't support
64 bit. These platforms explicitly defines #address-cells = 1 and #size-cells = 1 in
root node.


> >           ranges;
> >      }
> > ```
> > 
> > But with these default address-cells and size-cells values, pstore
> > isn't working on A64. Root node for A64 defines 'address-cells' and
> > 'size-cells' as 1.
> > 
> > dtc complains if reserved-memory has different address-cells and
> > size-cells.
> > 
> > ```
> >       Warning (ranges_format): /reserved-memory:ranges: empty "ranges"
> >       property but its #address-cells (2) differs from / (1)
> 
> I cannot find any such requirement in the Devicetree Specification 1.4.
> Is this a dtc bug?

This is current behavior of Linux kernel. When root #address-cells and
reserved-memory #address-cells don't match, then reserved-memory
region is ignored. See [1].

dmesg output:
```
 OF: fdt: Reserved memory: unsupported node format, ignoring
```

> > This patch takes into account address-cells and size-cells of the root
> > node and uses them as values for new reserved-memory node.
> 
> Reservations may be above 4 GiB. How does your patch consider this?

It's entirely possible to do on platforms, that support that. Default
fallback value is still 2 for #address-cells and #size-cells.


1. https://elixir.bootlin.com/linux/latest/source/drivers/of/fdt.c#L548

-- 
Best regards,
Andrey Skvortsov
