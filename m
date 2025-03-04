Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33310C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBFC980F56;
	Tue,  4 Mar 2025 16:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a6Voo2Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C320814A4; Tue,  4 Mar 2025 16:36:35 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E462280BAA
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac1f5157c90so149124066b.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741102592; x=1741707392; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1yZ5+MTtHNqiHkeoU1l8jEa+XTNESeddR0tpyq4H9A=;
 b=a6Voo2WbPDnlb3pDuoNq3xlC69BBVn44eHGv00y27LbTQLqQk2SETBiO+wu/mMCLPP
 mppNBRv/Sy7xrXKud/LgOwec3pu2BkQ5quQDdmiOaQttbHAX8IJGLfc/ZCG9k/E1Q8Nw
 n6irTWzYFAGcY+GL1MpirHYnFyL2J9zcSzXSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102592; x=1741707392;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z1yZ5+MTtHNqiHkeoU1l8jEa+XTNESeddR0tpyq4H9A=;
 b=U5Oj3ATHpslPzQlw7DcZ/pvihQuj+lzDXIUZjeyMD8wRSA7obrpeTyD2Mz/CdV61A5
 27FXdKcSDguPx7unQb7Vqo6L6DMZJo9St5oCbSEcs/142kmsfaH7vp6Igzf8pLNFRxsb
 02zRSgI/1M0uTiRISy7Cb244kZUzerkMgQT2LUL5OrK4r9UQxwfGI+Ke3kV4s3Rj2o8c
 gENYam0DMl+NqkoOLdCqT1XAuru68yaHAk5yBg3TzfoI72vMvabKGFC9YFa9kSwGgky5
 EB/FO7JnvhAYIpbQP0Wyf+MiV4KURorhOAjDrUptsu7OIH6s0QRPxna9HrfRnoGGUbx8
 8PGQ==
X-Gm-Message-State: AOJu0YwZRXawGCiYrTNVChk7+6iDvXBrErMD6ZVEwRR2gq4u1uxVZvKv
 HhJRwy57uWeWkchrOGtlWK7eYzNOBg4E6e++67uUG8ZY3xSVxtinjFW4C6k+5Wh+SNVLYxzNBVr
 XwA9qEgP71+RBOIIw5IbUYABhz+pcSoAq+/dj
X-Gm-Gg: ASbGnctQdaE+jcQpO7chtjSJ6KfaQ+tXqr/goLmzUNpsz5d/Ey8EQa2K/tbozZbuqEQ
 GB/rRPeF74DjbWo2GKM34ynJkrIBuEe6JgpIK7G4mL1S1jwKI/5Bpbmo2AkDxMD1DJZAdQtj3uN
 tsV+mld3jZr/JQ4/+gBTysnpSa88Q=
X-Google-Smtp-Source: AGHT+IHY3uoOKxIwuzKaSkTcyM6wq5oYK/jezCPhTz6Y1yGnC4MrsicEaeb8vq8OJk8Y450aQp5jiKidkehYdhKZgR4=
X-Received: by 2002:a17:907:86a9:b0:abf:6424:79fa with SMTP id
 a640c23a62f3a-abf6424d073mr1261174166b.28.1741102592261; Tue, 04 Mar 2025
 07:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
 <20250225213152.GB2640854@bill-the-cat>
 <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
 <20250225215306.GD2640854@bill-the-cat>
 <CAFLszTgen=t-SCrwE7nPOjUTGHO7smNZ5CSvxWR=4KhE8DJ=DA@mail.gmail.com>
 <20250227170441.GF2640854@bill-the-cat>
 <CAFLszTisYPa1_pbnHNb9a7F2Nrfk70KH27p60_sQ+UTR3tAA0A@mail.gmail.com>
 <20250304142044.GV2640854@bill-the-cat>
In-Reply-To: <20250304142044.GV2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Mar 2025 08:36:20 -0700
X-Gm-Features: AQ5f1Jon5IniMrCr4MR-bcvm6EloOlsQWlNWjT9kK3W1qlmApRV8IahvDdyTJAA
Message-ID: <CAFLszTjsX1kZP5zOD=Htnm5qdGDn_YYSHvCTcQtFjGGcvRPW+w@mail.gmail.com>
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

On Tue, 4 Mar 2025 at 07:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 04, 2025 at 06:10:27AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 27 Feb 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Feb 27, 2025 at 09:25:25AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 25 Feb 2025 at 14:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Feb 25, 2025 at 02:44:12PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 25 Feb 2025 at 14:31, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > This series adds a cover-coverage check to CI for Binman. The iMX8 tests
> > > > > > > > > > are still not completed, so a work-around is included for those.
> > > > > > > > > >
> > > > > > > > > > A few fixes are included for some other problems.
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Jiaxun Yang (1):
> > > > > > > > > >   binman: Workaround lz4 cli padding in test cases
> > > > > > > > > >
> > > > > > > > > > Simon Glass (6):
> > > > > > > > > >   binman: Exclude dist-packages and site-packages
> > > > > > > > > >   binman: Drop GetRootSkipAtStart()
> > > > > > > > > >   binman: fit: Drop unused code
> > > > > > > > > >   binman: Drop algo check in CheckSetHashValue()
> > > > > > > > > >   binman: Workaround missing test coverage
> > > > > > > > > >   CI: Run code-coverage test for Binman
> > > > > > > > >
> > > > > > > > > While we likely need Jiaxun's fix in order to be able to update to
> > > > > > > > > Ubuntu 24.04, the series itself doesn't apply to -next, please rebase if
> > > > > > > > > you intend for this to be in mainline, thanks.
> > > > > > > >
> > > > > > > > OK, would you able to pick this series up?
> > > > > > > >
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=444576
> > > > > > >
> > > > > > > It also doesn't apply. You should really put together a PR, against
> > > > > > > next.
> > > > > >
> > > > > > Oh, it needs another patch anyway. I'll send a v2. Once that is in I
> > > > > > can rework this one.
> > > > >
> > > > > Again, it would be helpful if you would send a PR and always base your
> > > > > patches on the appropriate upstream branch.
> > > >
> > > > I understand that, and I'm happy to rebase / resend when you are ready
> > > > to apply. I'd like to keep the diff as small as we can. But I don't
> > > > think it should hold up reviews, otherwise we're just going to diverge
> > > > further. When you reject patches for your tree I typically apply them
> > > > to my tree in the hope that they might find favour in future.
> > >
> > > I think you've got this backwards still.
> > >
> > > > For the skip-at-start series I sent a series, which you have seen.
> > >
> > > Yes, and what blocked them to start with is they defaulted to your tree
> > > and not mainline.
> >
> > I can send a pull request for things, but your tree is missing things
> > and that seems to be growing over time.
>
> By definition your downstream fork is missing things. That's on you to
> fix, not me.

Yes, so let's try to minimise that where we can.

>
> > As you have seen, I sent [1] to test the water so we'll see how it fares.
>
> That's not a very kind way to put it, given that I've only stopped
> applying your various series once they don't apply to upstream. And
> since that's actually fixing platforms and not just tidying up code I'll
> likely apply that later today.

OK good, thank you.

>
> > > > Speaking of patches, the PXE series seems to have got lost. It is
> > > > 'changes requested' but I'm not sure what changes are needed.
> > >
> > > The changes requested was that it breaks lwIP + tftp. You asked that I
> > > ignore that since it wasn't failing in public CI, I said it was failing
> > > in my CI. I then noticed that it should have failed in public CI (and
> > > likely was on Azure, but that's often overloaded enough I cancel runs
> > > when I see failures elsewhere). So I then fixed public CI so that the
> > > lwIP platforms there too should fail.
> >
> > Well I did offer to add a test in my lab...I'll take another look at some point.
>
> Well, it's blocked until it doesn't break platforms.

OK I'll have another try.

>
> > > > I also just found the membuf thing was never applied.
> > >
> > > Was that the one where Rasmus asked you to do it differently?
> >
> > Yes and I spent quite a bit of time investigating, and replied, but
> > didn't see any further response. The power-of-two idea is too
> > restrictive and anyway is beyond the scope of my series which is
> > mostly to add some tests and align the naming better with U-Boot. I
> > did suggest some follow-on ideas. Anyway, I am wanting to use it in
> > future series, so it would be good to apply it.
>
> No, I'm not going to apply something where the feedback starts with "No,
> that is the worst of all worlds".

Well, perhaps he's just wrong. I'll reply again. I've applied it to my tree.

Regards,
Simon
