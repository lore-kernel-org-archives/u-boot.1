Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F1BD3CC9F
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 08:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1229382C7F;
	Thu, 15 Jan 2026 09:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xiZuJ0Hg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8EB83015; Thu, 15 Jan 2026 09:01:17 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7546C82BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 09:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-646b8d2431dso481023d50.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 00:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768464073; x=1769068873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mZaA4ddvIBwmY6R0XxboSKL/5FZerjd3w5AirFWqbaA=;
 b=xiZuJ0Hg64jQpiR0TEvjoxiY4llTLfRXHKJ7iGylByHiNXegTlQ6yi2NqZz3BHUJnN
 +F8qb3lT2uz2Y2VHCjFt+xjiHDJzR7mwsbkKlnmJZBN/8NjLKwzdthNyVlREpuTNUH2d
 HAOGGGVCo63XPtV6FtVyGKRhW/G6uVISqPCS8Bt/C80AotqJkcr0x5Uavt1QcEqXsIss
 QjWQPytz3NV1IAobXr48ah8rxJrnyTvvUBwurUwn0ZuNjywJQk2apGMFFM19UsB7ME3V
 z9JbPh5pbjMKskYf/J7/i+pBxt3eGIJ7Cys7nX7o5kzWVRPbMyJuDZrh3EyQFcjGActq
 K1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768464073; x=1769068873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZaA4ddvIBwmY6R0XxboSKL/5FZerjd3w5AirFWqbaA=;
 b=aLjnwPZI8oNFIrVOHCdUJNjyd1yCrJxs+Q6rHtQ470gY+oqenLVj38u17vWlEuRoGE
 kfi/a5woGAdSZP9Bfah5ncqg0dc5d4Xs4FZQl8KIbYk1T8PvWg1tqYs/hi3ahRPM6ouQ
 2bw13t3jnZPgPM/ORLkLPVsOtyd3YGonK13n9+a4RsC3sfoz1vrB4pFGTp2A96/y9gUZ
 CssOEM4R263iu/OW9OdMFWU/u4GsRWDeE0xgMUfNG6cXp2m4HqMPsEIihBk7XoHMy8j4
 jt5kAa9w4dSPef6py+F0WrRuFlOzIU9/QjXWVy8TmCUz7kyDAYxNrSnWBEpAvSype8/3
 MLPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqpFm7G7sAk5sS61V40n7tEcggUo0m624sZcadTcqBm22cvWyqHXCd7+1+bEBCNykweMKAL7U=@lists.denx.de
X-Gm-Message-State: AOJu0YylDhEPT7fHPiRuQs8B6wcGPVNvFqCYnYAwIbs27KL8mv7rYAw2
 NdzyyIuk7jSGuBOrjd7rJS58N0sUnNEbMsWjm7dnd6YvHR1Mps2vT5xlVxp9wJphjs+jgitJrHl
 qdCJJy2FupEeOT9+EjCVqq6cmbTwfyhLPyxZWqBKJ/A==
X-Gm-Gg: AY/fxX6SUB6MWYXc9P38k9yejhFT2NVuKhtAwswBgOt7Gv1GXAey5IA2WUOiC19hq5L
 KTpn9EcvYqW86lEx/oDbW2PjqTUz0y/W9VAgTLYOmY95docY3DP0Fgm8KvPyDgPzRod5dBip6o/
 AZ9c1lA2gLQ55fdP3V/YxcxI9pPHQADLSqsLEWYV3zshNArqhepmsPeTiXUEGaso0eoEP94ORSP
 v2Zpx8vAVQ5B8J8p/MhXG5y9H5u1fTAWxhYQG0SnqLlkj6D4/9aCu9C+q1SYhxD5mB30C/cufK4
 U/EaCpUqv3WtHY95qQoPeHP5+0dzwvfaXdvPWqrFZwU6D4cH63tFSr+xq2He/G/0xYrJHZUHsyd
 fthxyR1VNawFKWV76sEh2yQaGIrpOSJo/AzAuI4GS27eW8BxPxjESaqsHIPJNvlJnOI/znccwPd
 49vW/qundtoarCsHoF65gZ3210zNvGmMcajWbQcyd3DwvkbrqIXVeJcznb/LWl0KHfXsx4MK4rb
 7s1jHiagjvcRrl6voGDvNuFFK3WD2igqVMcoCsPP2wBqowNLeXpE0kAdlxKd+S9rRhv4wWwjN75
 O4lhIgYhdlS/1JgotldsV3Ei5b0eDOzmv7+zGP1ivJQ=
X-Received: by 2002:a05:690e:11c4:b0:641:f5bc:694b with SMTP id
 956f58d0204a3-64901b11096mr3926343d50.79.1768464073114; Thu, 15 Jan 2026
 00:01:13 -0800 (PST)
MIME-Version: 1.0
References: <20260112101102.1417970-1-b-padhi@ti.com>
 <20260112101102.1417970-3-b-padhi@ti.com>
 <DFMMUHPP8BW8.3M5VVTPEB9IZL@ti.com> <20260112164854.GQ3416603@bill-the-cat>
 <8eb4eeea-a755-4032-ab95-2b293f2d2289@mailbox.org>
 <20260112220536.GU3416603@bill-the-cat>
 <66ec9e5b-1488-4e35-9a56-91d4b70ff0fa@mailbox.org>
 <20260113150024.GX3416603@bill-the-cat>
 <bbbb72e7-a7f5-48b0-b3e2-fcc83d5b1658@mailbox.org>
 <20260114141735.GA3416603@bill-the-cat>
 <7f1f7601-23ec-4a36-8e2b-3b4b679da6aa@mailbox.org>
In-Reply-To: <7f1f7601-23ec-4a36-8e2b-3b4b679da6aa@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 15 Jan 2026 10:00:36 +0200
X-Gm-Features: AZwV_QjiFU2FyrkWb7lSYV4He3u6EO8WIZBYspBlHj0VOo4LmoJBYwG_Mn0ygNs
Message-ID: <CAC_iWj++nNLDMzJECV__VBQkNPwURGsRpnD5HUUt40+dA3w9Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: OMAP2+: Pad SPL binary to 8-byte alignment
 before DTB
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, 
 malysagreg@gmail.com, sughosh.ganu@linaro.org, philip.molloy@analog.com, 
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, afd@ti.com, 
 nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, 
 u-boot@lists.denx.de
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

Hi Marek,


On Thu, 15 Jan 2026 at 02:02, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 1/14/26 3:17 PM, Tom Rini wrote:
>
> Hello Tom,
>
> >>> OK. And why can't we make that check at $sym rounded up, and ensure our
> >>> build targets pad? Going back to the commit message here, it's easy to
> >>> tell the linker to place $sym at the right spot, but it's hard to make
> >>> sure the output is padded. So having typed all that, maybe we need to
> >>> do:
> >>> d) Update linker scripts to ALIGN(8) the above symbols and have the make
> >>> targets use dd to ensure padding prior to concatenation
> >>> ?
> >> d) looks like what we should do, yes
> >
> > Poking at this harder, I'm not actually sure we need to use dd at all,
> > but we do need to fix our linker scripts, and then going back to when
> > Ilias reworked and cleaned up a bunch of them, get the changes reviewed
> > by the toolchain experts he got ahold of :)
>
> I wonder if LD can always guarantee trailing alignment of the binary. If
> it can, then yes, dd would only be obscuring alignment problems and
> trailing DT look up failures which are hard to debug. It would be nice
> to drop the dd part, but I am not sure if we are able to do it reliably.

LD won't pad align anything that doesn't have code afterwards. IOW
inserting an . = ALIGN(8); just before the .end symbol won't guarantee
alignement unless there's a section/code following.
What you can do is add an ALIGN(8) inside the last section. That will
guarantee that the last symbol is aligned. There's also the SUBALIGN
command which messes around with the input section alignment -- that
normally is automatically calculated, but Tom tested it yesterday
without success.

I'll have a closer look to the linker script in case I can come up
with something more elegant. Which defconfig should I use to reproduce
the issue?

Cheers
/Ilias
