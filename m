Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E91CD98D3
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0F58400F;
	Thu, 13 Nov 2025 20:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KP6cd8s5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFADE8400E; Thu, 13 Nov 2025 20:33:47 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508528400F
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-343ee44d89aso1580017a91.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763062421; x=1763667221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MjmJSQG0ZxuRnGOxAcKuzKjtlvNpK8FAy0OOw4TTSYo=;
 b=KP6cd8s58OSLgAC+ZzCdyZLeoc8p77hH3uOiT4FQlYwXcTSthKUYOa4fsXewaXMmdN
 dD3CrAjwqMv3fBYCQqdLDLz0Q60Axmzhwbh5YHsDE3IQ3tNyEDbaScnhoIUl+moiz9sf
 nz64inHWmBS9p2safSAn16TJtt+4O8bSqNd7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062421; x=1763667221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MjmJSQG0ZxuRnGOxAcKuzKjtlvNpK8FAy0OOw4TTSYo=;
 b=CpME4JZZyEIEJGuHQQ2yjLn89AD3Hlz59omtdDYClMw27xCNQudD6vgjQhkp5kerd7
 FComXfKOgzvG/gVA/Afb9YCLHNxOY3gx/R7LQZ1njbO60WpEpRXviY3OFKUmHTOETqKf
 wVYDyGungyanXEbqF/DjQMfgpeSrgWKCFX5T8ySi37HjoqA07LLlm6MGO6rRyadircHq
 6UbzV+IpNfduMySrCGX1el8HlxPPgOwp1s+PbE+yjyqrslpEmMG7+uUxWfQT/ybyTLEb
 Gzqs1k6ug0GPCZiEhWfg+xGBumK8pZIjTj9Jq8WR3ukG85HQrGVA1TGnJX0AUl2jijIe
 NBFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXda4hWUfIoI62BeQaVjB2DnYdT1Twlf5T8VMeZfmGdHlGi1OypBfC1XLkVwikNQsmuZ85gLiA=@lists.denx.de
X-Gm-Message-State: AOJu0YxS6TKupYgO9I+k7scvIJHONrUaXqWfijFIRayzHnuv07YTqiyT
 cxLVLBOxFMVRaHH0+vP52RrWsGz0mJvXVnRlTxFKZhVd6eusyCNpFpgzhVcJFytWtOohBlvr9xE
 Oz5XislbLSXn94Ryp0iYSyM+lvcaRkyh7Tq/wU5aS
X-Gm-Gg: ASbGncspxawMen29t4uTbwOv4M439VD/wd2VKom8OSpfgsjqjJYO7QSVnDHuYwu9ga1
 4prRdPE7JmNKjJJWq5xfjRL5szMDGgz7qWRckuAPNVs+LW4+xCveqK9KIXB9XrRZUuu5PCulVL+
 1ETe5gNnLPDOBj/xZU9z3i60nVTxJOU5k5oTG13DRJFOiyeR51eOvvW0bRqNPAp979ISe+r7WAD
 pBl/WUHpX2H8D8XfoUGzdp9gDoUgWayONefwXItYTLbrroSkVHHLms+RaOn+ShXy6F7BEZ2P5RW
 vkEH
X-Google-Smtp-Source: AGHT+IHu452efcOpMWlcn1XxosDVCnBwtmOSECaPu2mJ6Ef7B6OOT20yCdZ/RTfJqn674Uk8PvgYkWwx17UAkYnMVjs=
X-Received: by 2002:a17:90b:4c86:b0:341:8ac7:24d3 with SMTP id
 98e67ed59e1d1-343fa793c5cmr393042a91.34.1763062420848; Thu, 13 Nov 2025
 11:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
 <20251113184917.GN6688@bill-the-cat>
In-Reply-To: <20251113184917.GN6688@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:32:58 -0700
X-Gm-Features: AWmQ_blEjQx1acK_8w3RrnWAyF8738UvbXyHvdWM2ws40RAgLzWQLWWVEeBXKyw
Message-ID: <CAFLszTh7f--1tZZmtq5Q+dUkCbStkoi-LUXLVAsZzDGbTxY6Hw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sam Edwards <cfsworks@gmail.com>
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

Hi Tom, Marek,

On Thu, 13 Nov 2025 at 11:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 13, 2025 at 07:40:29PM +0100, Marek Vasut wrote:
> > On 11/13/25 6:57 PM, Tom Rini wrote:
> >
> > Hello Tom,
> >
> > > So, taking a look at the test branch you pointed me at, my big concern
> > > is size growth. On imx8mp_dhcom_drc02 (where we're already LTO'ing),
> > > with the CI gcc-14.2.0 toolchain full U-Boot grows by more than 6KiB and
> > > SPL by a bit more than 2KiB. This is a bit of a worst-case, imx8mp_navqp
> > > is a bit more than 3KiB / 548 bytes, with the average feeling like
> > > ~4KiB/1KiB for aarch64.
> >
> > Do you know why this growth happened ? Is that in libfdt ? How did you find
> > it ?
>
> Using buildman. To make it easier I put my wrapper around it at:
> https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-boot-size-test.sh?ref_type=heads
> a while ago. I can also send you off-list the world build comparison
> (it's 446KiB gzip'd).
>
> > [...]
> >
> > > Rather than a full-resync for the last time we needed a feature found
> > > upstream.
> >
> > I really don't want to do partial resync, it will only make it harder to
> > maintain obsolete code base going forward. Even this resync was hard due to
> > that exact current divergence.
> >
> > > There are things we *need* like to be 8-byte aligned and also the
> > > phandle resolution thing I believe inspired your investigations here,
> > > but I don't know if we can take the whole sync. Or maybe needing to work
> > > with upstream to shrink down some parts, I'm unsure.
> >
> > CI does show that no boards went oversize . If there is some growth on
> > existing devices, maybe we can shrink that, but maintaining obsolete DTC
> > code base going forward and picking random updates into it, that will only
> > lead to increasing maintenance pain, so I don't want to do that.
>
> Yeah, it's not an easy spot. But I'm really not happy with growing main
> U-Boot almost everywhere by 2KiB - 4KiB, and SPL by ~512 bytes or more
> just to keep up. I do see that integratorcp_cm1136 barely grows at all,
> so maybe there's something that can be done more widely and just wasn't
> clear at first. m68k only grows an average of 500 bytes and MIPS is
> ~1KiB. PowerPC grows a lot. RISC-V a little.

FDT_ASSUME_MASK was my attempt to handle this upstream. It is likely
that people have not been using that very much upstream and some more
of the code needs to check fdt_chk_extra() before address/value
checks, etc.

Regards,
Simon
