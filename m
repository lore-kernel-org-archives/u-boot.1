Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E06E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 14:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E46A80104;
	Mon, 16 Dec 2024 15:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V1L/NhY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CA680141; Mon, 16 Dec 2024 15:28:50 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65E7A8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 15:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2164b662090so32682175ad.1
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 06:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734359327; x=1734964127; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qT8TkPQDX1iXWaysxv5t9Cu3xSwS8U/spaZlHFA8Ds0=;
 b=V1L/NhY5FhEHvtqLpgIQuq3d99v771HccilKHU3bPqmcYDShSzdGnp5dcDHQ+/bZVo
 StWIE/2+DDaN/JfwXnXbnT9lCzfUvzbA3Hog99qJKJjSVQOzKbNyZoLtqP9UnJ3PQwY2
 kT96TZARkJdOnl+8NDL9Yr+pH1PfsXmflsjRSAch7a6i9G+0G+LX8QMv1PvUsYFa0K5T
 9LyGH4Mo46gyBj1P/wvC5W6AIu9fkIiXcuqZ5GFcLsLD9EsXl18/vInYQd/6gmFdA6V/
 s3tkTWwKmbmtZg+JAux+vjcoprQWVKSqvg7xArVADqBvPclwmEveRp8MnVD+Ol12m62F
 UWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734359327; x=1734964127;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qT8TkPQDX1iXWaysxv5t9Cu3xSwS8U/spaZlHFA8Ds0=;
 b=hdGgMqMyJLsqf6JaI+94n5QB3d2HpEVEtSHZX1buNHm1oyY+3vU4s56z0obLrVOWg5
 XmeINwFsgNzaNkgLzmmMQNFzRmhXCY3tRJ9igwlnZLTIvZe7SB7K5sxlIaI1FoAnwHFd
 b+kJXbioSyrVW64cJ/aD7l4rq5uHJEBsK5akIaIwT2fqIH/MVWd0qpavwYxw519srQRg
 nrZ7DTViXc5znDjvaYKyiClaR2V1vBW0WnfFkFDbNfPC+4iNoWGpZT6c79fNjEUxEfX6
 yP4Uin8Z3ZwxfwrPtgCYSRUc2q5HlL3xMPOm4lyc6igb+4lWLrv3tnCcsRrIFB0z3jEw
 +CLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqQgcW9+JLyPJALYfUuhfc4nqpn6eLzIOWGYHTx5r2ATQ+7WDsvC7S8Zwx6bdzPohbCsgw4G4=@lists.denx.de
X-Gm-Message-State: AOJu0YywPHIL4/UXqY8Lgeh+bvKEV2avGjIt/5+WMhxuZasRDb0HVupf
 WeWUQOPpIRUC5iWiTG1Lgi+sukdmjT6xu38H04SiOQWx2lm8qLpb
X-Gm-Gg: ASbGncuPhmhpXaMuwUEvyuuUuPtqr5XChfoCGClDB87tmLmwEi2mzVj3HGdGZFv+80o
 Cf4G/H5OyRVnsuzdi1w7KD/aFKhhODQ5wc0+olvFZWcGHUFZpRbJHK97JZVdTNAXb0CL2AeBxqt
 xcxQyj179CgoA9izfehXiUfxZ5ktXJMV+lFlMQ0O2cPXEY5LWzpd4GjYMchSLvEIu4BykvnTx/B
 acOHZVR0CmHJFQjfMGEiCYTjne6M5abvvxwGx04ZOz8EQOIK9SART1rvh3mHx9BUN8YaxnwKMx2
 WPHJkWy2MqzstXo=
X-Google-Smtp-Source: AGHT+IE8oGHCHfbJRiFWRXkA+tkGH+YjCeSgdC5mTDfNFe5M7G09fzvByKqR2clGQsqQcKfSRL3olw==
X-Received: by 2002:a17:902:d512:b0:216:1cfa:2bbf with SMTP id
 d9443c01a7336-21892a41ecbmr167068385ad.35.1734359326615; 
 Mon, 16 Dec 2024 06:28:46 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e655cesm43468515ad.244.2024.12.16.06.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 06:28:46 -0800 (PST)
Date: Mon, 16 Dec 2024 11:28:42 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 u-boot@lists.denx.de
Subject: Re: [REGRESSION] Out of memory error: unable to boot on imx8mp/imx8mm
Message-ID: <20241216142842.p5j4otcinwpszt5l@joaog-nb.corp.toradex.com>
References: <20241216114231.qpfwug3zfqkxn3d5@joaog-nb.corp.toradex.com>
 <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg8p95K5sgLbqutnGWwcggU+o94GFrS5w3=GQecuO_NT5y6PQ@mail.gmail.com>
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

Hi Sughosh,

> Can you show the output of bdinfo. And also print the value of ram_top
> while booting the board.
>

Below are ram_top and bdinfo:

U-Boot 2025.01-rc4-00025-g4ff8ecd9b14e-dirty (Dec 16 2024 - 11:21:18 -0300)

CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
CPU:   Industrial temperature grade (-40C to 105C) at 51C
Reset cause: POR
DRAM:  Ram top: FFFFFFFF
8 GiB
...
Verdin iMX8MP # bdinfo
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000040000000
-> size     = 0x00000000c0000000
DRAM bank   = 0x0000000000000001
-> start    = 0x0000000100000000
-> size     = 0x0000000140000000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 115200 bps
relocaddr   = 0x00000000ffece000
reloc off   = 0x00000000bfcce000
Build       = 64-bit
current eth = ethernet@30bf0000
ethaddr     = 6e:79:12:b6:72:24
IP addr     = <NULL>
fdt_blob    = 0x00000000ffab8450
lmb_dump_all:
 memory.count = 0x1
 memory[0]      [0x40000000-0x23fffffff], 0x200000000 bytes, flags: none
 reserved.count = 0x1
 reserved[0]    [0xffffffff-0x23fffffff], 0x140000001 bytes, flags: no-overwrite
devicetree  = separate
arch_number = 0x0000000000000000
TLB addr    = 0x00000000fffd0000
irq_sp      = 0x00000000ffab8440
sp start    = 0x00000000ffab8440
Early malloc usage: d620 / 10000


Best Regards,
João Paulo Gonçalves
