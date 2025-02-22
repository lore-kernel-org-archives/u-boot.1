Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F1C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 05:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4571580FC9;
	Sat, 22 Feb 2025 06:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tx+zXsMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1811380EC0; Sat, 22 Feb 2025 02:03:57 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA7680017
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 02:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7c0a159ded2so260891185a.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 17:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740186233; x=1740791033; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to; bh=Y50n/SZFHR6Vn6viihUiJseF4zc/8lJU8gJRjjbM34M=;
 b=Tx+zXsMIIKClPMmz+sUElFxbF1LyoWh0XK8rF0gwncoYyoa1a0ekkBsZtcFkEQlwOL
 o9CGxrdF69ZWkIRgudlgy+3TPjlsc/F3K6I7LGiu37g8hi0hGzQj0KOu3otkPHi+LPIn
 9yknOzhiZbcraa22hVEydXi4zH7EDINlPxqoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740186233; x=1740791033;
 h=cc:to:subject:message-id:date:user-agent:from:references
 :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y50n/SZFHR6Vn6viihUiJseF4zc/8lJU8gJRjjbM34M=;
 b=bBwSDhQ2uPg6ZzMB2QGAyKsybCHGAqEAsD8zvfP8D18AdgtYxydpEz0jdUtSwJJlJW
 VyEops8TpPI3xzGAUsvTWdBSDQd5pasNxXFe3OaDEvdEtHqrKKAWaC9pY02EU3pjJnlr
 bxHokNqod/0i5kVN9eaOLaK80REO++pAgkV+8hlRQxXZ7yIutknAz9Ycx/tJFs35cBFE
 ouA8fWGEd1E/CiThO1agUOnfrxZHG3iGf8jT2zSnnxNRD0qoRkqSuFiE1DYByBdQKI33
 g8jsBK7FF15hGj/HqSxMOkOnwXScVeDw5nqbXmZIg+cQbpZnO0WGZnvF6aVzSIJaPYrN
 ph+A==
X-Gm-Message-State: AOJu0YwXx0AFpPWEBHhH9fRcqZO4jkf/f+OdpRriCNA2bQplxULGK2fV
 sAI+yWExOiQNFsRMnkrOr0gxON2iszek6FFrrwTyJAUQpZ/QBMHzumnVChxKZe3Yv7n9b7VqU3Y
 MDbjIGorFDNNH+75avRf7/Bpg6i1p7a31xj0q
X-Gm-Gg: ASbGncuAErtHYz2M8knJUS8QPpcgrJHjBII508LOE1v8Yg4ePs6AfVDLlAtF8CRlYzP
 yG6V5tbibvG/MWGZR91ySlM5M/Jw7F70pmXwHQGWgRE6IhI4NaY/lc0bOlytf7wYBIt/BqmsTgO
 0G9g5p2rHOniaNY3b8LrAjLX8C0nNRoyqSX7Q=
X-Google-Smtp-Source: AGHT+IGitorYc/frmkgi9bfrLH8Gpqa4Kr+2r6UzPdrHUoZA1cEMZCL9rw30rLqS+tMuWk8lHuZuIsEvUMDiXyiVBfI=
X-Received: by 2002:a05:620a:2405:b0:7c0:88e6:f76c with SMTP id
 af79cd13be357-7c0cef6da4fmr826643785a.51.1740186233069; Fri, 21 Feb 2025
 17:03:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 17:03:52 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 17:03:52 -0800
MIME-Version: 1.0
In-Reply-To: <20250221010711.GE1233568@bill-the-cat>
References: <20250220205900.3127680-1-swboyd@chromium.org>
 <20250220205900.3127680-6-swboyd@chromium.org>
 <20250221010711.GE1233568@bill-the-cat>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Fri, 21 Feb 2025 17:03:52 -0800
X-Gm-Features: AWEUYZnCtDta0BFzwFyJLBp-Q5fwjzA-eVKvB2SVYfjnX9J5-0J0dkTCKCzTjSo
Message-ID: <CAE-0n53x0NdhoF=w0kEzcgjsgPF7a8R0-sVndemsT3e45PJkCw@mail.gmail.com>
Subject: Re: [PATCH 05/12] arm: Support running U-Boot as a coreboot payload
 on ARM64
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Anatolij Gustschin <agust@denx.de>,
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 22 Feb 2025 06:35:05 +0100
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

Quoting Tom Rini (2025-02-20 17:07:11)
> On Thu, Feb 20, 2025 at 12:58:47PM -0800, Stephen Boyd wrote:
>
> > Add a 'coreboot' cpu to armv8 that looks for the coreboot table near the
> > top of the 4G address space.
> >
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  arch/arm/Kconfig                     |  2 ++
>
> We can't really ask SYS_COREBOOT in two places, as unlike the kernel
> everyone always parses arch/*/Kconfig, so we should move
> arch/x86/cpu/coreboot/Kconfig to say arch/Kconfig.coreboot and do
> something like:
> config SYS_COREBOOT
>         bool "Support for booting u-boot as a coreboot payload" if ARM64
>         depends on ARM64 || VENDOR_COREBOOT
>         default y if VENDOR_COREBOOT

Ok, thanks. I'll do that.

>
> And then any of the sub-options that are imply'd by the existing stanza
> in the x86 file aren't applicable to ARM64 they can be "... if X86".
>
> As similar to the work to make EFI payload be a more generic option
> rather than x86 only, this too needs some thought to be easily
> expandable to cover the ARM case today and I'll assume RISC-V at some
> point in the future.
>

Do you have a pointer to that EFI work?
