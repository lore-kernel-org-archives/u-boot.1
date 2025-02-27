Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AC4C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 16:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331048110C;
	Thu, 27 Feb 2025 17:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CgTLTNP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46688811CE; Thu, 27 Feb 2025 17:25:40 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A42810F5
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 17:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5ded368fcd9so1836801a12.1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 08:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740673537; x=1741278337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zPSiXDaLNKN4l+0KxuEmvgSp4J5G2HWGDNeG+C/6dGk=;
 b=CgTLTNP8oXjK9VPgR/yxH91bO8pVsKX8/q28FRdEgb9k+TZk7jI979vr9ECbFE35I1
 zVmg18eD0oqLIrXkN7GllMiIHg0006q7hkvaoCODqno6DQHO8bxS/4riajEyRgA0XjD5
 fjxCV+hfwcbYlsmmBdSTmamVTSS8Mgpuirq9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740673537; x=1741278337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zPSiXDaLNKN4l+0KxuEmvgSp4J5G2HWGDNeG+C/6dGk=;
 b=OugLotre1EKalF3iG28Z4r8iH1OsN6DVECnwiwlFuFTWA2h8wnR3ysKRpzHJUGWw3y
 Uf3EwNdbOyAWPkCQG/8DrOae2lOJZL59S5/+TLJNwuaLzbPQxbZktqXXdbL9fDazsoAh
 fdTgHm7p2AibKxhSZM9qOUbkWORFQeK4ELUqCj7QHEiewJJqcvvI4pmqsdRPQbf6TUde
 8CtG8yYURf89CFDKIC6Vzha02JqexGsyRwP2dyMWr8HK/Tt0WnwoNmJ+dqYRDUmvomy4
 9j1lNfymFPYLRW6VRk7gyo7HJ0aqj8zwZhlf/qoa1cKQowGu1HL11af/ldaD7101+Kud
 Kghg==
X-Gm-Message-State: AOJu0Yyd4LYxxyDJpfOch3u59YByf6RCIeMyrtw7U3RTDwXb51dnK6Em
 24nIpndwp4kbBRp8T2Zom1bVI9X8+5pjGaUCmyI1njul+lndT8Wew1tHvGq7v5K+fpb8r488AQ3
 WzBbvE5fHtgJP+X9jDErF1kn7bCHIrpszT4Y74qhzYSASZds=
X-Gm-Gg: ASbGncsg5P7r9XiM7ShkwI8VY2IVA8WhadUSkUgDFQGU+cqME4NPzkoxJ5yda3iBp+s
 9rCTllybYxBEwWRxS1HKxGzbzUhaJkVdh3Dbo7tK/xoKoQuIxYNkmn/fPdoW6HiDXFIvYTad9vc
 FQgb+70b7g
X-Google-Smtp-Source: AGHT+IE7N50lXl02Hj8jIDE2IM/4mBWGxBMynBKaA/+baPVanRcPjHrz7PNbM8OTZk2VFPVgsX6jx9AgQg0YrRY3tfg=
X-Received: by 2002:a17:907:7210:b0:ab7:c1d5:14f9 with SMTP id
 a640c23a62f3a-abf25d952edmr9119266b.10.1740673537214; Thu, 27 Feb 2025
 08:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
 <20250225213152.GB2640854@bill-the-cat>
 <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
 <20250225215306.GD2640854@bill-the-cat>
In-Reply-To: <20250225215306.GD2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 27 Feb 2025 09:25:25 -0700
X-Gm-Features: AQ5f1JpmqlcJhrx1yJW5jeQbdtB_KqNWENXUCyPs3oqht2ae9q_QCPZptksZIXI
Message-ID: <CAFLszTgen=t-SCrwE7nPOjUTGHO7smNZ5CSvxWR=4KhE8DJ=DA@mail.gmail.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

On Tue, 25 Feb 2025 at 14:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 25, 2025 at 02:44:12PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 25 Feb 2025 at 14:31, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> > > > >
> > > > > > This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> > > > > > are still not completed, so a work-around is included for those.
> > > > > >
> > > > > > A few fixes are included for some other problems.
> > > > > >
> > > > > >
> > > > > > Jiaxun Yang (1):
> > > > > >   binman: Workaround lz4 cli padding in test cases
> > > > > >
> > > > > > Simon Glass (6):
> > > > > >   binman: Exclude dist-packages and site-packages
> > > > > >   binman: Drop GetRootSkipAtStart()
> > > > > >   binman: fit: Drop unused code
> > > > > >   binman: Drop algo check in CheckSetHashValue()
> > > > > >   binman: Workaround missing test coverage
> > > > > >   CI: Run code-coverage test for Binman
> > > > >
> > > > > While we likely need Jiaxun's fix in order to be able to update to
> > > > > Ubuntu 24.04, the series itself doesn't apply to -next, please rebase if
> > > > > you intend for this to be in mainline, thanks.
> > > >
> > > > OK, would you able to pick this series up?
> > > >
> > > > https://patchwork.ozlabs.org/project/uboot/list/?series=444576
> > >
> > > It also doesn't apply. You should really put together a PR, against
> > > next.
> >
> > Oh, it needs another patch anyway. I'll send a v2. Once that is in I
> > can rework this one.
>
> Again, it would be helpful if you would send a PR and always base your
> patches on the appropriate upstream branch.

I understand that, and I'm happy to rebase / resend when you are ready
to apply. I'd like to keep the diff as small as we can. But I don't
think it should hold up reviews, otherwise we're just going to diverge
further. When you reject patches for your tree I typically apply them
to my tree in the hope that they might find favour in future.

For the skip-at-start series I sent a series, which you have seen.

Speaking of patches, the PXE series seems to have got lost. It is
'changes requested' but I'm not sure what changes are needed.

I also just found the membuf thing was never applied.

Regards,
SImon
