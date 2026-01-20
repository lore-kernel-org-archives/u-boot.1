Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF01BD2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8072B83A2D;
	Tue, 20 Jan 2026 09:39:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F5NafIlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF72083A8F; Tue, 20 Jan 2026 09:38:59 +0100 (CET)
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BFEB839E8
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64938fce805so1037706d50.1
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 00:38:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768898336; cv=none;
 d=google.com; s=arc-20240605;
 b=azpQ/DKxcFPDwi6o7tko8oVjOAwfEcfUUSqR93DqNiXFBfea5WLGEdMySPRo3cw6qC
 XAfBVnAb4kEYmA7wdiylWEKnXL6l42Hi1TOQgDw39KxH+VTgY7ayTshLzTWIUJ0JVwtt
 fq8pP1Y+EwZAzSVVTRTODiuJlMw9wb66Uz1AbcCXazWyYpu83hhxP2DGg9qH/7JpY15h
 Ygeb1CmWM5DF+ilWcH/exoJEUpkZ015+//Sb75QsI6owXs7kvnrVMrV0UZFkOLf+kwQz
 TI3kHYBjyAhN7Nu/wQcD7/gc6jHzIhrxDzUra8XmP1ZelOXxGBDxBmA9fVjq0mZtNtO3
 Zkyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yyZkv08gZ2lC7YUuXwf/MLleBXaOldA1gKnfjNw8QeY=;
 fh=dgjDR5ljvYUS7D/4Ak7O/wuLaIcZs0La2Y7nP0DwpDQ=;
 b=goeYhO0UmNXI8da+sDc9jPYuh5mAXHtw+tOzIeDqcVJDWak3Phzdxam6nnt75ShtPn
 lJ3JXCXbifMZoItGjIDfHEYI1p+/gJbuzmLD1TumxJLLfJ3+zIocSzTZ5DgZB8xh2j8O
 pbnS7icKtLRQRGrb+rrSTdXvgYb5FiuEepyCzVjwMy7EdXVo/zaOsZHcM0k74D3fWbGy
 5ipGzyxtLCg/BgYJfQdxkZ1/H9glDCu9rIjyAkSBd1m7MgM0+PeaPlYxxCIbRv3HVujE
 UM3smFXfjEt+xTtYxcrGvE36Gg9YVo++usYoKBserUoV+uE/mlhMZdSY2pGbbEBHzzrw
 6GXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768898336; x=1769503136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yyZkv08gZ2lC7YUuXwf/MLleBXaOldA1gKnfjNw8QeY=;
 b=F5NafIlWP7mDzclMhqewgpKCPxtjJ3b0y50wA8dvxNSK/0En2uJoe7SGzEJQBJBx8H
 iC/wqeV4LZRfJXNi9xFSsB2aDnz5r6egcfm5EO93pPEfPlglt+ROANXj8EI0oCQcBiYT
 C76INRqLjbNcU5XWnYJW6N92EQSzvr4ul04rj9K+ylsIRPODtCcpx5LavPQ1yTrAIZw9
 GrxoLgptBvI5mSPfMeY9kSqU5/374Ezj2eAfwWAoK7KBZZpZujzcB/coMdDhDp84FEFN
 3/1nyQWm7uyOt1dviRJFaJgkhNkjORmWgr7uKRIooQqDNDIFTXfbKM1AdlU0c1EQzQ/v
 6rPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768898336; x=1769503136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yyZkv08gZ2lC7YUuXwf/MLleBXaOldA1gKnfjNw8QeY=;
 b=qUAV7HFUEWdXGvYLCUzSxXdctc8bQO70aUSykM0DsOI1NMjtm8ZO4dLpNQU6kF1aXf
 T/jASxg6GactGJMeDZZAJTLfT3xmGnM/9lTl0z1U0ah/+dYkPIphBZ6hX4z3KaYPTGZB
 GBwatHka3fRDehm9hCAr+z+4IPSptE5lXbCSRfqd8g6pSGf6LFjq+b6dINY/1R8GEZB2
 R+ZdQYXIWOmSTGtjxwIKpSASrta+eFWRYej7fc/oHhHdkFierGaLpPfm1vIwDEA9a3OY
 8+qrlFVj6SoYThXEwme7biGVPUX4TlDhHJN+FLWbc+KPXqTH4GXYCfaerFwkPMWtIcQM
 fCtw==
X-Gm-Message-State: AOJu0Yzbp/G8L2is0dQReMcveIyv7ohH5kmetsEAbruWVk+u7iZ+CL8A
 QSen1HZ/FA1tVib7Xm4DBl14n1OLvnIAmHpeqYgvySusTuI4Xx4MRCevxS5OhYR4Z2oWixTzPVS
 jlYBORZXuVdNwlUYi+NHGD/XPubyFXZ/ksm7b17QdRA==
X-Gm-Gg: AZuq6aJxcst24eI24eoqGkXVwlzF0cBPrMjR2wMwVNvN/W6euWl21y/VzL/mE8wjU0E
 jsOee2sbmDIZzQfoDeDdQMuZyfmo4Syc0pfBL4xOWrFmi0KHlbCPuTkjbXNzyT/MXjHv7P+Y7iD
 hAPK1Xov/26tWGjZPlbvVm8aGPZFcekXzMiR6UUJeSvOhW0Ew6uiImBynl/kgZNNg7V6pW/n/Kf
 jaJC3BjmH8ZOuiY9UJ/iK6TrBHDiyD9G7B/1vkv8b1SmHKQd/J/nB1hWa+lZDtMTASLItndF7X0
 /m/aRUDCePb8K4NDHhS0mWE2CHWkol4Rwflk0njHkToUW90dU0uDr52DL6SiaR5A1fkrLxYW5aP
 apAH/avqaNjMlVW/p/Ac8bhPT0FqrqCPLNs9zj1FiTCC3UH2T8+9Z7okCDIzHnVTDoJjg23MPgN
 m6881teQFhDkXgRl5eC4Q0eTz34DnEThjuoiKQnEm9N/L3YmI1iUjYWxNAqtWQSeFNr9Ut0FpB0
 69b3zaq0eLJf/gz/hNdhhyThzWFeLLZ32frfRdvFHyU4gDHm9O0oCEk+YQ7TNNL4fI45fV5AfNW
 OG+os64tL/34H8XjcC6JaaumdfBHxJyT
X-Received: by 2002:a05:690e:120e:b0:645:54a9:11b6 with SMTP id
 956f58d0204a3-6493c84819bmr800970d50.52.1768898336069; Tue, 20 Jan 2026
 00:38:56 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAC_iWjLUX38Z0ucpN37EsKE8T8w+Qw5hpteFRm=5uaf+Yfnv7g@mail.gmail.com>
 <20260116144024.GJ3416603@bill-the-cat>
In-Reply-To: <20260116144024.GJ3416603@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Jan 2026 10:38:19 +0200
X-Gm-Features: AZwV_QioTC4VcO8R2VQnV9IgX8s1ZT8SdnLPXtudlNc7Y6PcBliwCoD-OpxzQqU
Message-ID: <CAC_iWj+Uhq-GFDVG78=GL+xtFTSy3cMbmer1fb+gfxv4U0YZ=Q@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Fabio Estevam <festevam@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Joel Stanley <joel@jms.id.au>, Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
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

Hi Tom

On Fri, 16 Jan 2026 at 16:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Jan 16, 2026 at 11:59:49AM +0200, Ilias Apalodimas wrote:
>
> > Hi Tom,
> >
> > arch/arm/cpu/armv8/u-boot.lds and arch/arm/mach-omap2/u-boot-spl.lds
> > can use the same alignment. Is the omap2 case covered by the TI
> > patches? I think it's better if you bundle this up in this series
>
> Correct, the TI patches fix omap2 (and a number of other platforms, that
> linker script should be renamed, it's the sram+sdram SPL case)
> platforms. I mentioned needing it in the cover letter btw :)

Ah, I wasn't in the cc list for the cover letter and missed it. I am
ok with the TI patches going on a different patchset. Can you amend
the arm64 .lds file?

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> --
> Tom
