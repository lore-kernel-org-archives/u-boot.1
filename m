Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA822C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 10:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D3688053;
	Sat,  3 Feb 2024 11:19:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m33AoaBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E34880E2; Sat,  3 Feb 2024 11:19:30 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 949578801F
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 11:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jorge.ramirez.ortiz@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33b0e5d1e89so2147395f8f.0
 for <u-boot@lists.denx.de>; Sat, 03 Feb 2024 02:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706955568; x=1707560368; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/+F/xnuFQQp5WUnEVoX35R4vEVw2uynDPH21adws9m0=;
 b=m33AoaBSii+h0g4VoAL2cRA+AxYZ776rbftE+Z6RUQgAbNcXpKn6JQk9b7Lw9Ngu3S
 6gflhS7MX7M9XKCfkKKxLBgFtE+rX1OZkL22U/+WuAgkYuJpAoI4eqfIqgR1Cp2EXUhE
 +TEFdE7KwZtscu50xx/SP454v3oK+wrgrwuD51xmFChw6MrxNNrd4PGtw8LYd1boI6Eo
 eEF7jfIPvv+vZy1K6LOJzZBt1Hy20GDafIV7Pr/CGQb5u4i4h7HNW2AuZwzy/hcluSls
 +m6KmGzN2lcu3FKa5XPU+yV4OGth5A2s++KyUMRPr0UCB+Rfy/cjaljZvnis/VAiP0Yp
 389g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706955568; x=1707560368;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+F/xnuFQQp5WUnEVoX35R4vEVw2uynDPH21adws9m0=;
 b=aYbprEE/6q6a8r/6OjkPOj+/JI/JRnIwFLYOKorDE/OR1Lg9DWDDQxTi1qY5dk7B4M
 PzIALFA0a66+l4VVyiFM5zkpTlHqJrkJNhAJUN+Gx0Q0s4SzXbTKs28W1LLdZJDHUx8k
 mc2TqstdjmcwsS9+7pl3g0q+FgV6LWDoDhE2qsuCJhEDsqq1OPJv+If/qQVRztMqAUGH
 3GxgbPLDNF9kGDUs0x7TuffFi6Dbry0kPt0rRUJCWtirjCg6Z9KBGHCWlhUTgUc4EiC5
 8JjSl2QRRjWTNH/wjHSU1k2BgPmQQsqV6DOFhRXVu3GmfA+IzP9Tj9WES0+cvtv/mjAH
 JeBA==
X-Forwarded-Encrypted: i=0;
 AJvYcCXQpxN3naWLb8YAXnrdLX5NGnfcmMzHhA1cyu+eEufozRCUDXjk5Wrj1Qen57j6nttwxGixZ3iWLjTvTRM0QEo/2K9U4g==
X-Gm-Message-State: AOJu0YyZnqhtx5sjvAUvOnFb3WMmYBDqbfb+u3m4h72r5241tRTygXz9
 XrtrDJeZL0naqqFjRt3dFut60awakYOVm39vwbEclpKPRK3XL3u3
X-Google-Smtp-Source: AGHT+IHYnNGCiDLLWSVzmzEX6XQkbjkXNQK5hHkt600ohmXqnz3pwKAoJ5Lcf3zzyoO8YqzgMq9NvA==
X-Received: by 2002:a5d:6a8a:0:b0:33a:e8b5:28f3 with SMTP id
 s10-20020a5d6a8a000000b0033ae8b528f3mr5260570wru.24.1706955567696; 
 Sat, 03 Feb 2024 02:19:27 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXglK3yztyTeUVTHI9Ls9GLhwWq9c1QiQFP6coFPzm8dtPOLupnihziN7DJZpYSRAXJc5TV9rgpoXHkiBfxxHJrWS1A7d0gHASVknlbneqwdHFSUPDnntLYR+wUwM39z7KVRw5pjL65Xf4vyT+XJ2RrZztfgUUzUmMKomlW58fvpxPSZ/6t7uyRFp1SqOa4DipM9c8PYlkmG153Tq7o/rD1btQrRjUwf4UX8Rj3SgY6FyvbCkeJ
Received: from trax (8.red-79-144-185.dynamicip.rima-tde.net. [79.144.185.8])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b0033b1b01e4fcsm3744910wrq.96.2024.02.03.02.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Feb 2024 02:19:27 -0800 (PST)
From: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Gmail" <JorgeRamirez-Ortiz>
Date: Sat, 3 Feb 2024 11:19:26 +0100
To: Yang Xiwen <forbidden405@foxmail.com>
Cc: "Jorge Ramirez-Ortiz, Gmail" <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] poplar: add myself as co-maintainer
Message-ID: <Zb4TLv2E58KvrgCO@trax>
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
 <CAAQ0ZWRFak3LwsSVCxi7sd6AmpJsegdv6A4Y=piwb8eStLTjLw@mail.gmail.com>
 <Zb36M+p4z2+zd+XB@trax>
 <tencent_0A657770FEC7B98668A070C65A10F4166007@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_0A657770FEC7B98668A070C65A10F4166007@qq.com>
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

On 03/02/24 17:45:42, Yang Xiwen wrote:
> On 2/3/2024 4:32 PM, Jorge Ramirez-Ortiz, Gmail wrote:
> > On 03/02/24 07:54:22, Shawn Guo wrote:
> > > On Sat, Feb 3, 2024 at 5:44 AM Igor Opaniuk <igor.opaniuk@foundries.io> wrote:
> > > >
> > > > Add myself as co-maintainer for Poplar board, as I'm currently
> > > > working on it (re-testing releases, addressing issues etc).
> > > >
> > > > CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> > > > CC: Shawn Guo <shawn.guo@linaro.org>
> > > > Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> > >
> > > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> > >
> > > I'm not actively working on poplar any more, so maybe remove me in the meantime.
> >
> >
> > hi Igor,
> >
> > Yes please go ahead and thanks for offering.
> >
> > I'll sync with you later next week (I found my Poplar in storage, so maybe we cam improve things a little)
> > Also it would be good if we knew there are still users.
> >
> >
> > Acked-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> >
> Hi, everyone. I'm working on a set-top box with a Hi3798MV200 SoC. It is
> very similar to the Hi3798CV200 SoC and many peripherals and drivers can be
> reused. I think you can try moving arch/arm/include/asm/arch-hi3798cv200 to
> arch/arm/mach-histb and let's maintain all HiSTB series SoCs/boards under it
> altogether? The same thing also applies to TF-A. Currently upstream code
> refers to poplar everywhere but actually the port is portable enough to
> handle a lot of other Hi3798-series SoCs such as Hi3798MV2x, Hi3798MV3x
> etc..

Sure, if this is indeed a family we should do that (documentation was
scarce back them when I did the initial port).

maybe you'd like to take a stab Igor?


> > >
> > > Shawn
>
