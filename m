Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E344C5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 12:16:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CDD282BF6;
	Fri, 30 May 2025 14:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WnrOLIDf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 376E382C44; Fri, 30 May 2025 14:16:01 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9305482B0F
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 14:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-708d90aa8f9so18711947b3.3
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 05:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748607357; x=1749212157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CF7ZqRLHQoeGBvmuBu6Do5y84BeivIUxmDmvRSTiFBg=;
 b=WnrOLIDfMS4dv6+rZ2VY3tN/s0SjP0jkx8Wb3N/4iIlU/LIZWmL2JDXavUt9GeLAdX
 qhNU0t6jkD8zwgSNqF4TPhTxp1KZzObgJlQGt5Adluh0Ni2dirT3Bu6qyv06DvKNmkuX
 AzEvIo++oVKCY1QbOXLG8wZk53twpxQayRlNgPjVwc3Zcp//mPul+pOwQP9Hgpa7i/QE
 OXG7KOcrEHQxd3uPGNGfcUxosaf8lGkjbyD+0Sb+bFuwRkwtTrn5mg2X+1OmBoTKaS5R
 +yosdvBPjuBPYwsneKp9u6Svsiq8q3crynVAGNh4iQj93jHTBvfUqrqX4wyZ/W82nBXJ
 AH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748607357; x=1749212157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CF7ZqRLHQoeGBvmuBu6Do5y84BeivIUxmDmvRSTiFBg=;
 b=d3NpIke3CWiP4m4eMRJ+zgIrMDMpZKVMHkO/jvQNU61B6kLc79VLJK9sNiDJP9ONnT
 +QIIp/UTI+ouZi+GVnxqnCF0TSc5M/7pcKQ0rMe07Ovm9FgMTSXRFzHdOW7bGwS1YyGB
 0utb0HgCPeB7lXH+3nRhMr+3N/2oF0G/Fs3opelr0mgRmqpT7s98wRWNeYxARRSNuX/f
 ZS1QSRyFvEX8YTUZsN3fsFgvKhpsnM1XK/B5b05HR30jnqgPicbQMkiKeybv2czrjD2X
 phcFWbvbBu35LeCn9bsaodFTNb28+J7/PjepE2IvGSlVtqQpqGY5kokQlWSb7LYDsENT
 P3VQ==
X-Gm-Message-State: AOJu0YzogNu9U9qtZTvsSjEdW6uVnQy2B8cUctBSib0fM3BrJMJav4ja
 l30XvlO69Cda4iYCoI7QPa3541pKjaqKk83s/xkCfG5xhHtNt5i43ewll81EaUL9M3oIyd3qSPX
 tCB+C+TfOdssYAj6mQdbNEdJWujeujsUkEQp3iZ+7GQ==
X-Gm-Gg: ASbGncsQ3qW16KaqtU7Tr+s5a31LPXiaIrMZZDY7gxe+pq9c6P7S9VULU/A4DIf40X4
 W2fVwWdPtl/q56k3wGiZgKacLdH/0Cm2I0aGbjC6fNk/Lc2D0jwRFqQia//fZ6iJOaQojksWGl8
 hlr8wfzgAUMY36y+ePCG9m28bmcxaOQEaLDQ==
X-Google-Smtp-Source: AGHT+IHn6SpcEOtw+97mAiufu0t/VEs7StJawNzenD0iz8e/mhUj8vEopuj3IB6E3w2RbKU5AGmFII5CYQatkCxQp5o=
X-Received: by 2002:a05:690c:680e:b0:70c:9364:2c62 with SMTP id
 00721157ae682-70f97f13bbamr47968977b3.25.1748607356991; Fri, 30 May 2025
 05:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250528175901.GG100073@bill-the-cat>
In-Reply-To: <20250528175901.GG100073@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 May 2025 15:15:20 +0300
X-Gm-Features: AX0GCFsZv5q3mHWxPlxlK1sCf73B7-0PB3KhqjfgL-u-GRkA42Mm89NxY0TudG4
Message-ID: <CAC_iWjJ88yhfFpWk0YYxh7n+RNOYNuvUDEBghdqvS-yLTatuqA@mail.gmail.com>
Subject: Re: Determining Simon Glass's future in the U-Boot project
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

Hi Tom,


On Wed, 28 May 2025 at 20:59, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> First, I am not happy to be writing this email. But at this point, I
> feel I have no other choice, for the good of the overall project and
> community.
>
> Back in January[0] of this year I made a post with almost this same
> subject line. At that point there had already been a number of problems
> working with Simon and the overall community. I did not include a list
> of links. At that point the easiest answer would be to go to the mailing
> list archive, pick any thread that Simon and I had and see the long
> disagreements. This trend has fundamentally not changed. And while I
> started this out with some threads and my summaries of them, instead I
> want to point to this email I sent this mornig:
> https://lore.kernel.org/u-boot/20250528170533.GE100073@bill-the-cat/
>
> And to repeat what I said there, Simon needs to decide if it's more
> important to work with the community or have his way every time. Simon
> cannot have both.

+1.

Since I was involved in enough ... I don't mind reviewing patches and
giving feedback. That's what I signed up for. Reading the same 30+
series patches though with only 10% of the feedback addressed is just
not working.

> Simon needs to accept that some things he think are
> good ideas have been rejected or he needs to fork off from U-Boot. Or he
> can ask the community to take over as the project head. If the community
> wants Simon to run things, I will step down and just be an individual
> contributor again. Five months of this experiment shows me that it's not
> working at all and will only be a bigger problem as time goes on.

FWIW I think you are doing an excellent job and I'd like the situation
to remain as is.

>
> And, I mean it. I cannot take the additional stress of what new problems
> await me every morning. I do not take the above lightly, but I do not
> think the project can become healthy moving forward without some
> resolution here and quickly. While I won't claim my time as the head of
> the project has been perfect, I have tried my best to always be honest
> and fair and to seek compromise.
>
> With respect to voting, would anyone volunteer to run a poll from
> https://civs1.civs.us/ (which is used by the Yocto Project /
> OpenEmbedded and likely other FOSS projects/communities) ?

Thanks
/Ilias
>
> --
> Tom
