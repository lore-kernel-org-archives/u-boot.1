Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC3CC2FC27
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44EFC86B7F;
	Thu, 17 Aug 2023 15:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="knFv4MXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D490E86B63; Thu, 17 Aug 2023 15:42:55 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384DE86B69
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-ccc462deca6so7357234276.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279769; x=1692884569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=91H27Zem7kAuMj6mPQ94z1n7uhtMn9IKAeHYK5Y9jXo=;
 b=knFv4MXzRFci4rfgMEj30vm2P97USkomRrZrpIhMPBLeHUNIPppXNjaGPQt7Anu0A4
 noJkzKLq4SrMJG0yPwiREqIErxe4hoKbcmD+98Ekz9NIQYb7Al1SBxZamYk+gXEWfCMc
 TVde6g6MIw7UL+O45Y6Codj+mtqo1iI29t3rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279769; x=1692884569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=91H27Zem7kAuMj6mPQ94z1n7uhtMn9IKAeHYK5Y9jXo=;
 b=Ax2fCiBOO8EybdQJzdEudpHsjqKYZaD5/flkSAiwDolxQFtebQA9RgPIDlYVsfaEgO
 Phum/HpFXoxOwrQmEI0ZBTOwvgQcrg0liKDHLi5+2yTxbWMuy+WtLqVkoGXvF3EjGkso
 eX1WYqMfsEF5Cmtdp7iK1hvsYZ4nqyFkBld5s+PTIWpcdx3bDoCcii7MbhUSNtYtJoF7
 mTFrHT+JNmgFQrUaRjtuhCpvDH6nEGyd+rEh2Tr2VHhpBhwC9heai9UDP1jGGbY0/Dpa
 cd4qNMWuQfavidoh4UIaeMjA8bhodJ7L/7Rhw8Wi+R6fZw2DqYRr9GuM8oA9zOsLLe06
 k3vw==
X-Gm-Message-State: AOJu0YxEdqSQ7jfV/ZoIObTvBPm0EdUg+m2HEn2qaAsNVlFUk618FZWb
 6fuiq/0t+GwUVNaLiLTXQSdBp8th8rwxnc1Lz8IDbnVyM020gucwo7E=
X-Google-Smtp-Source: AGHT+IHiHZo5wPO9gk+n2E83bX4DgFlJMjWBRReaYE+MIZdFvU649TFAMHGFFoFyrNS56EbI1Vuz24boAANAhnN6sYs=
X-Received: by 2002:a5b:9ce:0:b0:d19:824a:490e with SMTP id
 y14-20020a5b09ce000000b00d19824a490emr4388425ybq.31.1692279768674; Thu, 17
 Aug 2023 06:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0Gj==Q-YOU+EoD=s3h25Waw5EYa0DEOD_comoAy_bRMw@mail.gmail.com>
 <20230813155208.GN3630934@bill-the-cat>
 <CAPnjgZ2_y3coEzTh=3Y=-w=B+qFAmxM5CbCYsKDWvCNaeO_-Kg@mail.gmail.com>
 <20230815145638.GY3630934@bill-the-cat>
In-Reply-To: <20230815145638.GY3630934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:50 -0600
Message-ID: <CAPnjgZ3Tj1kwVViSfnqEcApkQ=At3pkKVVrfft6zvD4JmnbMzw@mail.gmail.com>
Subject: Re: Strange gitlab idea
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 15 Aug 2023 at 08:56, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 15, 2023 at 08:44:20AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 13 Aug 2023 at 09:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Aug 12, 2023 at 09:14:45PM -0600, Simon Glass wrote:
> > >
> > > > Hi Tom,
> > > >
> > > > I notice that the runners are not utilised much by the QEMU jobs,
> > > > since we only run one at a time.
> > > >
> > > > I wonder if we could improve this, perhaps by using a different tag
> > > > for the QEMU ones and then having a machine that only runs those (and
> > > > runs 40 in parallel)?
> > > >
> > > > In general our use of the runners seems a bit primitive, since the
> > > > main use of parallelism is in the world builds.
> > >
> > > I'm honestly not sure. I think there's a few tweaks that we should do,
> > > like putting the opensbi and coreboot files in to the Dockerfile logic
> > > instead.  And maybe seeing if just like we can have a docker registry
> > > cache, if we can setup local pypi cache too?  I'm not otherwise sure
> > > what's taking 23 seconds or so of
> > > https://source.denx.de/u-boot/u-boot/-/jobs/673565#L34 since the build
> > > and run parts aren't much.
> > >
> > > My first big worry about running 2 or 3 qemu jobs at the same time on a
> > > host is that any wins get from a shorter queue will be lost to buildman
> > > doing "make -j$(nproc)" 2 or 3 times at once and so we build slower.
> >
> > Yes, perhaps.
> >
> > >
> > > My second big worry is that getting the right tags on runners will be a
> > > little tricky.
> >
> > Yes, and error-prone. Also it makes it harder to deal with broken machines.
> >
> > >
> > > My third big worry (but this is something you can test easy enough at
> > > least) is that running the big sandbox tests, 2 or 3 times at once on
> > > the same host will get much slower. I think, but profiling would be
> > > helpful, that those get slow due to I/O and not CPU.
> >
> > I suspect it would be fast enough.
> >
> > But actually the other problem is that I am not sure whether the jobs
> > would have their own filesystem?
>
> Yes, they should be properly sandboxed.  If you want to test some of
> these ideas, I think the best path is to just un-register temproarily
> (comment out the token in config.toml) some of your runners and then
> register them with just the DM tree and experiment.

OK thanks for the idea. I tried this on tui

I used a 'concurrent = 10' and it got up to a load of 70 or so every
now and then, but mostly it was much less.

The whole run (of just the test.py stage) took 8 minutes, with
'sandbox with clang test' taking the longest.

I'm not too sure what that tells us...

Regards,
Simon
