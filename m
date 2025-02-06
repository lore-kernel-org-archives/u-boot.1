Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288C1C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 21:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD05580EB5;
	Thu,  6 Feb 2025 22:28:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HZy4BFkS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2629A80EB5; Thu,  6 Feb 2025 22:28:12 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F8080C6E
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 22:28:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21f3e2b4eceso19081245ad.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 13:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738877288; x=1739482088; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GBAKpS06qT9HWCL/X4ZubiUHfXUFWhE8QBkWGPtCArk=;
 b=HZy4BFkSAiFXOhd4MySmToBsWAp39EAyIpwQTxDgvy4BWTgfYjsew4UnfkUASGZXai
 15shI8rXrl/0kO7B+wqMY3zL2ZDd6SYIRlDED6Qj7XJhKxCBHxrso9lv98LrSc1adJg4
 TuIaDpDpr2074yxxoFmUpsH9pnb6g4YePT3tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877288; x=1739482088;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBAKpS06qT9HWCL/X4ZubiUHfXUFWhE8QBkWGPtCArk=;
 b=KRFTh0HTI/JlEys8lac/gjUlSojutn1Hb6jGGATcd2/MQ4OoGO9/5T+emYYbqbIXki
 iVHAgs5MdoOoBTlYoLDgIAvuHpkccqvn2AHZR9oNGvhRce+7kRFSsnMnVCJXjV0GU72g
 0GmJ0Xtgp6KxB0uSRCDeuK7drbOTJEQcBde5zcoq6pHL8fFYmtLtrxdhFiulPcFOuZqb
 gIOGQqq3zDMs24ngBS0XN1/o4sHU+n3vfulZgoHjJThZHrAipcTpzpTvqtj4GUM5KLIo
 OiRvmDC+oSaVQASo3YyzZFMVdG9CHtXeU+3nLGHNrNwQxWlgqXBAqTMJmMudBjfZVkQZ
 cLRg==
X-Gm-Message-State: AOJu0YzvH4xYsjP9pVbkz7/GDsNPgvd6KxXv7W2EyKBK1LSbd27YPSzw
 UUKQeZTND1XXHG4MoWgFd/7RsaaTUyQFsgWgAZPmY2L9yPr48xBypNwW2SoML7JHg7l6psmqC10
 Us4i718n/00ignlqDhv3Be+thVmk10Yv/hiw5
X-Gm-Gg: ASbGnct35YwjxJzc4IBM7QnMoPq5FM9+lxengkftsxPlu5sKcv//iQ6UV6gE0uu2h1D
 bvMQXPa7kUHedS9JT93J96YesQ8SNQHN2Vd11DwDBvrPLsw8fzgA7sm1LnNv5DHRvwS11EKApbA
 ==
X-Google-Smtp-Source: AGHT+IHh2iDTY3hYzz0YOqSbnDIv7neSWVLbZj579hmMomxwigkJDSomPQ5bNco4w0Rejdk+901zVp7pVbNbIFuhcYM=
X-Received: by 2002:a05:6a00:1da9:b0:72a:bcc2:7748 with SMTP id
 d2e1a72fcca58-7305d2cdd0amr1523580b3a.0.1738877288494; Thu, 06 Feb 2025
 13:28:08 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-30-sjg@chromium.org>
 <CAEfUkUKqhf0Y9v9U9bTw0A3_odkDVpbfXLKM08qtrcdARyOsbA@mail.gmail.com>
In-Reply-To: <CAEfUkUKqhf0Y9v9U9bTw0A3_odkDVpbfXLKM08qtrcdARyOsbA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Feb 2025 14:27:28 -0700
X-Gm-Features: AWEUYZk8eSodj1dQBDrETxa2pc4AZYmZ16x1r3_WFPawajCVZLINkdJ4fyXfqsw
Message-ID: <CAFLszTj3-1KSRqgDyvdKFt0V9=Nt8Rksd5+j88Rp+_oAZDKxVw@mail.gmail.com>
Subject: Re: [PATCH 29/29] bloblist: Allow relocation at the end of the SPL
 phase
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>, 
 Levi Yun <yeoreum.yun@arm.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson <seanga2@gmail.com>,
 Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Raymond,

On Wed, 5 Feb 2025 at 08:35, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
> >
> > Where the bloblist is located in internal memory and TF-A's BL31 blob
> > removes access to this memory, the best option seems to be to relocate
> > the bloblist just before running TF-A.
> >
> > Add an option to select this behaviour and provide a relocation address.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  common/Kconfig    | 20 ++++++++++++++++++++
> >  common/bloblist.c | 15 ++++++++++++++-
> >  common/spl/spl.c  |  9 +++++++++
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/common/Kconfig b/common/Kconfig
> > index 0e8c44f3f74..962e7fd76eb 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -1125,6 +1125,26 @@ config SPL_BLOBLIST_ALLOC
> >
> >  endchoice
> >
> > +config SPL_BLOBLIST_RELOC
> > +       bool "Relocate the bloblist before existing SPL"
> > +       depends on BLOBLIST_FIXED
> > +       help
> > +         Some platforms locate the bloblist in SRAM in SPL. In some cases,
> > +         the TF-A BL31 blob removes access to SRAM, e.g. with Rockchip RK3399.
> > +
> > +         Enable this option to make U-Boot copy the bloblist from SRAM to SDRAM
> > +         before leaving SPL.
> > +
> > +config SPL_BLOBLIST_RELOC_ADDR
> > +       hex "Relocate the bloblist before existing SPL"
> > +       depends on SPL_BLOBLIST_RELOC
> > +       default BLOBLIST_ADDR
> > +       help
> > +         Sets the address to which the bloblist is relocated at the end of SPL.
> > +         U-Boot proper uses this address when it starts up. Note that U-Boot
> > +         always relocates the bloblist again as part of its own relocation
> > +         process.
> > +
> >  endif # SPL_BLOBLIST
> >
>
> I think the relocation you mentioned is a board-specific behaviour and
> should not be part of common/Kconfig if only a few boards use them.

Where do you suggest this code should go?

Regards,
Simon
