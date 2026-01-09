Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C8AD26D9B
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 20:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16375843D4;
	Fri,  9 Jan 2026 21:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BpGGmnVP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3034B843D6; Fri,  9 Jan 2026 21:23:51 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A3E843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 21:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=aargri@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-65d132240acso2806458eaf.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 12:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767990228; x=1768595028; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IVzg3pKxekIPwuRCGbATNbAbcZFayAaxU8jvi9Dlfu0=;
 b=BpGGmnVPVmQY2W9RxN4jfuzOBI/3iMlFCQ8uQdkSxGO8UaB3j9ywhI8xBoqppoZhB8
 TCxjgHx+Uji0DB7l8lmA5spdIRgTQa97XKzf/83DywRSPyZ9c9fXNHTQ1YmNMU59em1s
 dlL6eXxE3MMpYB7wiAdE1dTABykGpEk3Wxv8BtbTSgrLUFiej/oUToIN8CtWZrmio4Rc
 NzR8bLm9uoP0NED3ugANRnJnx+3yR1d96yll35bWSEh8ljvJrD8L+jVR25s19e/Mstvh
 RWkIm2dzOk6fpWZmLNdxxc3B/1jxoiD4RK/X8MfFX6CaMiZsAvYk2HF8nMi/s/28eMwD
 Q9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767990228; x=1768595028;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVzg3pKxekIPwuRCGbATNbAbcZFayAaxU8jvi9Dlfu0=;
 b=HkbctkDy6MCyMIXsrmS+EkqLf3IzasqEwPTnpK/IE377Hi0pPRpHiXpI7tMpj5LNUQ
 HYG8SS51yHX7WiXJHFcT/2S2njgxwqd15s6uMR6WVWtnmcpl7z4OHIxOhiovfSP9loZU
 PWIi2w0uADBZ0BGBwG4fQfIta/HvR50eLqo8aqDhpw2GlgGD8B4wm9OuOj7IWzYoD1Ys
 SsQPm8rcCqQqddp386oQhY7H1IYllWzvPalyC9KorT/yDWaBACmn+C2+5FAD6QHbEG8M
 6Nl55234fIbg7DoIe9XuwnLiobO94W+dfaZa4jvfjy75a7pzcfkux/hCHvEltmeklx5M
 lzDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKtFbe0DOMsBusXpv3q7Le5EIipyETDlpSUvJS/L/bVDsJIrn3FX+upQYOYfx/55ItJkovaaM=@lists.denx.de
X-Gm-Message-State: AOJu0YwvsR9F+md2O5LqvsHe1oVN5U3dYwo5YL39W/5FDSdu5fUKaHEZ
 n0KFZrB3RaXzY7D89PgTYwoP9TqtaqG1XWG15kuuwSMedyZw9AU+o6A4
X-Gm-Gg: AY/fxX62WzWDT3oA//d3poUHskxPdOUYmwNq2dSQbCeAYZto0SLbNKXPGgXEvRka54d
 RDUnG1IeKuVaQhrUERdbHHrR5HchT2vgz9X8KU/HBVXRWxyGnmPrR9AsP8W4tniDh1OPvxVYa/o
 JATvHPF/LcVpxn1MZblXMxyY/SJP5nXjxhzDxuNq9Sa59m43rUiwCusR402y8g1mQ4kE6z07voU
 EpqdVM8uqr78pGp6EvfpUdoaOswrQFcxCQqU3Mgjll2uba4LKNGP1C/E6cZf5ndLWvZBXkaRvwn
 Wqb2NeHQCAaLkOaST0vl1oJ+5hYWYHCX8dNAIsHzKeSlMwkyV8PoWrJjGdjaLRmZIsqb/7TEzq2
 ReU6juA95YWXpIAMVEDnnXm3iIryOyVCapsCRHm5tEHw9sLNi7xRoXMNVGfYAKBiaxbltnRb9CZ
 9ZEFHOASjXrdSlCNzPsuyu2bwVX/+h0cqBSeAOCT6zSIYMbkc=
X-Google-Smtp-Source: AGHT+IGBFTUj8Lf4s7LqXnXmBT800UrtRRo6FlhzqYwlKmzKBpO32460+D4ICOKAuuhVU26DPicpXg==
X-Received: by 2002:a05:6820:16a0:b0:65f:7009:d71b with SMTP id
 006d021491bc7-65f7009dda8mr331587eaf.10.1767990227700; 
 Fri, 09 Jan 2026 12:23:47 -0800 (PST)
Received: from nara (172-2-191-226.lightspeed.clmboh.sbcglobal.net.
 [172.2.191.226]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ccff66sm4360203eaf.16.2026.01.09.12.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 12:23:47 -0800 (PST)
Date: Fri, 9 Jan 2026 15:23:41 -0500
From: Aaron Griffith <aargri@gmail.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 00/10] rockchip: Add initial support for RK3506
Message-ID: <aWFjzQfEwfCK8RKJ@nara>
References: <20260109005008.101506-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109005008.101506-1-jonas@kwiboo.se>
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

Hello Jonas,

On Fri, Jan 09, 2026 at 12:49:41AM +0000, Jonas Karlman wrote:
> This series add initial support for the Rockchip RK3506 SoC.
>
> [..]
#
> With this series, board DTs and defconfigs it should be possible to boot
> into U-Boot proper (without OP-TEE) and still have support for MMC,
> Ethernet, OTP, RNG, LEDs, buttons and USB gadget/host.

I have a Luckfox Lyra Pi W board (with RK3506B) and a Luckfox Lyra
(with RK3506G). I've been using the earlier version of this patchset
for about two weeks to successfully boot Linux on both of these
boards. I'm excited to see this support heading upstream.

Using these patches specifically, I can verify that the RNG and LEDs
work, that it is able to read data from the MMC and USB storage, and
that it successfully loads and runs a Linux kernel.

I was not able to get the Ethernet port to work on my Lyra Pi board,
but that uses your device tree information that is not part of these
patches (and may be incomplete). The specific failure U-boot reports is:

    ethernet@ff4d0000 Waiting for PHY auto negotiation to complete.........
    TIMEOUT !

So, for what it's worth,

Tested-by: Aaron Griffith <aargri@gmail.com>

Thanks,
 -Aaron
