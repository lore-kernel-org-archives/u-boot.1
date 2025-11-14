Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EA0CE7B01
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58C4840CF;
	Fri, 14 Nov 2025 13:46:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="THjsUw9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8DF3840E0; Fri, 14 Nov 2025 13:46:17 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE801838CE
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64180bd67b7so2710556a12.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 04:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763124375; x=1763729175; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=74SiY4q7HoN+NWCBAhQ9JzmPYxbb10tUorLnzOp0C2o=;
 b=THjsUw9Dt4tejiY+Xrptx9EMjSwe7/GXFUScXkfyO4WtfIErg5GuDY310FFNDnaeOE
 YjeSe5Ks8T7JrS9y2U9rBOUckHp+Ws+YzVHDJo0US6OZxSMD/YwM3Zhchqlxrd0AfGf/
 52ARI6fLAoOA0Li8mSZh5Q62AEoFAgO5mhF14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763124375; x=1763729175;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=74SiY4q7HoN+NWCBAhQ9JzmPYxbb10tUorLnzOp0C2o=;
 b=wLh31kP5ahhL8Q/+4vLB9591B1T1o4vH5d5SOAak89F5evuWUz7jas07Q5DOrwzVNu
 kWJUb/J9hXXF2YtUZZomA03ubKmZ3522B7OXYX2NNiyUbqVlsP853Tv2lUUVmiRuJWUl
 51NY782/ESCTXxUGA5L48XTx+ryrmxdFZCAx4gGNF1p49N2K9lLXY9mCc5NXMN4PtkTq
 dMupbiZmmhaMRpScDN7qKq7hbpbuTBnnIUstRukLv9ZxjwQIbQBlbCkikXyV9Z9Sjusz
 R04NQlV4axrF8WPKLthanb2ewJpb91Ltmc/qO0TBeRqRlGPjNiYNQfFJBCCAIY9CDHTo
 smzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6gBm2kY03yj5930GHPjZWJVrTmlTr7/kE+anASJzwbmdoNfswrz7RwXvM3RmDYGf3amdtGWI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu0GkvQENqGHR0NvRH7cHvv5P63Q+pXDci3y/dPugWcjEbaEaz
 lOOkrSll95hSBgpX5GYtSet6L2LmR0/e6b8HiAeh7Kq2SszClwQfmalY3PggVQFEkOP77TISqDz
 HX0VW54blpjixTencd/7EkddH5CJdMOCGfX/SLyCx
X-Gm-Gg: ASbGncv2nzn88B2LQMVWVchC7We1y3bsZPa+CehETa4K4iszdDgTjOK1Sw2wDGrdUDx
 7QV3FZy6HnNYhpNXGTvlybpiSuw/iufiYWtl1WyrtJGsti2hDaW+AsSLYDqx4OTYKEspcK7BTug
 eWC/3qIq3NWddKYP5L4h7qE2BXAlgt/ugQeSmHBo5djz+5T7Q+pTE1Vqc9AOoqWBNqP+yUwaRc1
 AUQ4A9bjMJGXp2aBgy2DTuYyX4lqc/O4ZboYVnsonXGroPLd+wWmzguabLXbfDMpNL9DQ==
X-Google-Smtp-Source: AGHT+IEXbc8X3r5UhvlYf0/WknsLEyHqbJB9ZGOT3JUOGA9oQ+bEJO97+lb+pJwpfFHTvq9bYinUFa30kCX7++Ye/6E=
X-Received: by 2002:a17:907:7eaa:b0:b72:d6a9:e1d9 with SMTP id
 a640c23a62f3a-b73678ea6ecmr302299866b.41.1763124374830; Fri, 14 Nov 2025
 04:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20251112011717.360045-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTjofjQ_zmwJrGZ-sLejQ=x=-8tyqr4SBPYgt3683GVAbQ@mail.gmail.com>
 <20251113193816.GP6688@bill-the-cat>
 <CAFLszTjwpoCwCKKvJX5cZMLK480EK-=BWaFd5A6yLMrfsVWC6g@mail.gmail.com>
 <20251113200527.GQ6688@bill-the-cat>
 <CAFLszTjydNqmo=6qLv--m4fB07QzWd01XHGY3hxgTEbarJF-VA@mail.gmail.com>
 <20251113203654.GR6688@bill-the-cat>
 <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
In-Reply-To: <385cdc16-cf73-443b-a0a1-440e233d4506@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Nov 2025 05:45:32 -0700
X-Gm-Features: AWmQ_bnHBSrj4MzruUdIyBy4xtQts5UF1MQdfqtvrgnKlIjNqx9TViwoTB2APq8
Message-ID: <CAFLszThc4YC6mKp5sNsiuCFfaMNqMWJjVV27d4UkyLU4rPWY6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] boot: android: Always use 8-byte aligned DT with
 libfdt
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.denx.de, Aaron Kling <webgeek1234@gmail.com>, 
 Eddie Kovsky <ekovsky@redhat.com>, George Chan <gchan9527@gmail.com>, 
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Nicolas Belin <nbelin@baylibre.com>, Sam Day <me@samcday.com>
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

On Thu, 13 Nov 2025 at 14:57, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/13/25 9:36 PM, Tom Rini wrote:
>
> Hello everyone,
>
> >>> Which is different from disagreeing with your specific feedback about
> >>> how we get there, to be clear.
> >
> > And again, since your feedback to this patch was "Don't?", I'm saying we
> > need to. But the rest of your feedback was structural on moving towards
> > resolving it and so I assume Marek will respond.
>
> The "blast radius" are these patches, that's all that tripped the tests:
>
>   - boot: android: Always use 8-byte aligned DT with libfdt
>   - test/py: android: Point fdt command to aligned addresses
>   - test/py: Use aligned address for overlays in 'extension' test
>   - sandbox: Fix DT compiler address warnings in sandbox DTs
>   - sandbox: Fix DT compiler pin warnings in sandbox DTs
>   - boot: Assure FDT is always at 8-byte aligned address
>   - arm: qemu: Eliminate fdt_high and initrd_high misuse
>   - efi_loader: Assure fitImage from capsule is used from 8-byte aligned
> address
>   - MIPS: Assure end of U-Boot is at 8-byte aligned offset
>
> Regarding last minute alignment, the problem with this android image
> seems to be in the android image itself, which packs in badly aligned
> FDT. We therefore have to copy it out and realign.

My request is to implement these checks as part of the boot flow
(bootm, etc.) rather than adding memory allocations in leaf function.
We already support copying the FDT to a different address so we can
expand it and add things. Can we make use of that code?

Regards,
SImon
