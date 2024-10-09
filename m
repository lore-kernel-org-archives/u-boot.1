Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5F0CF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9A389111;
	Wed,  9 Oct 2024 03:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dliYSXYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D238911D; Wed,  9 Oct 2024 03:56:58 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0661890F7
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:56:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7e9ff6fb4c6so4774807a12.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439014; x=1729043814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sLmhiLEjmSXGM257WVCNlBgqBs0zS55SeP+GGKBzM5Q=;
 b=dliYSXYjfaGhDlooiuld/7cbRRK5SNo2aODIS7L32J3anH6A3Zjohu0iIAQS5xD0fn
 kUdy92djO+VdyZZ3WZDPpiHu0P/bD6p5NGbFnjfP8L4S7IvVQ+03BsrwMlb9RpuDVxD/
 ULJvSodE1zUcIN++d2yNHdtz2UrjXW0yvdMSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439014; x=1729043814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sLmhiLEjmSXGM257WVCNlBgqBs0zS55SeP+GGKBzM5Q=;
 b=DyyX6MLcWmaekUJbYGQvWnO7UikwvPAjyFWMLLxndjjXGGr8KwW7Ydy2q2+bJo/HSL
 Cp20n367BRmQGNJAFui2EMFHw9MP9VoBKooWmAP5GVjOEZ1aV05Tt16hLWFRu+lCXLF2
 YuNdMotZsJJaWqVH6Kleiu33JjcGAM4MNN5qIe1VZe8W8uv+9sf0FE5p1jQjU4PJschg
 0J4SK4zIBjh/YvgWBN7xnwTlOyxUN3juTq+YzSUPMbw6ErXpgtbKT9zfFabSvGpxpY8Z
 U7h+D8lxnX0oZZgnzR9WNta0lYsRbB8Akji3/9MHynpZZvHI1I7oaQmHMrEGF9C+zI6l
 Xg4A==
X-Gm-Message-State: AOJu0Yw1Md9OUot6ogWW2d7ZjvFU87tfeFMpUG/17x/KnC/QDDVTJMGR
 sEpE5aok7XjlegYDwHNl8I4ikBPh537mQnXc8dhskJ5HS7xvafzZOBinhENYANdhnDv/XVq2/43
 UQLobKjBtCVFKwjQ7BQMq/weQhwYAEXd++HpUtydc4m3DYIstbg==
X-Google-Smtp-Source: AGHT+IGES+BCNLljNx5I6ut2elN4xMgOqhMnQ6naFw4EURe6wxR9L8+SZKMgerwiD1+DZX1Vwl9wiHAWRd9YdyQe72g=
X-Received: by 2002:a05:6a21:6e4a:b0:1d6:97f2:71b4 with SMTP id
 adf61e73a8af0-1d8a3be3888mr1607663637.1.1728439014341; Tue, 08 Oct 2024
 18:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU3wz22Ni+Kqy=NuFiEYPdrRkzjRJDNhYGJcCdDsLpbvBQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU3wz22Ni+Kqy=NuFiEYPdrRkzjRJDNhYGJcCdDsLpbvBQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:56:41 -0600
Message-ID: <CAFLszThkQ4pVmko8PPK5Yyt5RXFQkSatMycjH7GU5eN-_8L7ZA@mail.gmail.com>
Subject: Re: modify live DT with OF_LIVE breaking phy_connect?
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot <u-boot@lists.denx.de>
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

Hi Tim,

On Mon, 7 Oct 2024 at 14:16, Tim Harvey <tharvey@gateworks.com> wrote:
>
> Greetings,
>
> I have a need to adjust the U-Boot device-tree live with some board
> revision specific fixups. It would seem I need to enable OF_LIVE to do
> so but when I do this on imx8mm U-Boot proper seems to fail
> phy_connect() called from the network device probe.
>
> The board I'm working with is an imx8mm-venice board and using
> imx8mm_venice_defconfig (without OF_LIVE) results in:
> U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:58:38 -0700)
>
> CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> CPU:   Industrial temperature grade (-40C to 105C) at 44C
> Reset cause: POR
> Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> DRAM:  4 GiB
> Core:  226 devices, 32 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... Reading from redundant MMC(2)... OK
> In:    serial@30890000
> Out:   serial@30890000
> Err:   serial@30890000
> SEC0:  RNG instantiated
> Net:   GPY111 eth0: ethernet@30be0000 [PRIME]
> GSC     : boot watchdog disabled
> Thermal protection:enabled at 96C
> Hit any key to stop autoboot:  0
>
> Yet as soon as I enable OF_LIVE:
>
> U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:59:35 -0700)
>
> CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
> CPU:   Industrial temperature grade (-40C to 105C) at 49C
> Reset cause: POR
> Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
> DRAM:  4 GiB
> Core:  214 devices, 32 uclasses, devicetree: separate
> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
> MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
> Loading Environment from MMC... Reading from redundant MMC(2)... OK
> In:    serial@30890000
> Out:   serial@30890000
> Err:   serial@30890000
> SEC0:  RNG instantiated
> Net:   Could not get PHY for mdio: addr 0
> Could not get PHY for FEC0: addr 0
> Could not get PHY for mdio: addr 0
> Could not get PHY for FEC0: addr 0
> No ethernet found.
> ^^^ phy_connect failing
>
> Any idea what I'm missing here?
>
> Are there other ways I should be modifying the live dt in U-Boot?

I am not sure, but the best option would be to debug the PHY stuff and
try to see what is going wrong.

Since the number of devices is smaller, I suspect that there is some
code which doesn't use the ofnode API. But it is hard to say what is
going on.

For modifying the devicetree, you can do it just before relocation
using the flattree if you like. The reason livetree is better is that
the nodes don't move around when changes are made.

Regards,
Simon
