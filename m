Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED75110A1E82
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 11:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB3B83E76;
	Thu, 26 Mar 2026 12:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hRxTXlWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EEC83EAC; Thu, 26 Mar 2026 12:52:50 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6940581E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b982b0889d8so98275766b.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 04:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774525968; cv=none;
 d=google.com; s=arc-20240605;
 b=Q5Qrnu4TJ72BV8zboFeNz/qtOv2oSpRIF48D7x0vX64+kW9oVnnKLyxGgSQkrtGiup
 mUSohLX7qyy6gT3m7GKnBIDEfBEzNzxlk+hUiApYfKMQgbqDJqEHSyrXoE5M11ezYAYi
 OsahJYfIpjmQ9ynMRYAp17QMCVbdd9UIZ0M0x4q3EUAStqVmnKohMghzGFbtG/dr2hsz
 Sthrx48ibxKOqXTRk4jTjK9E/YegaU1UMjLh1itPzrLE7sehGSHk3tPAMgg4Q3siGIFb
 qNUy80NHyCWFVbkSPznFqCbaI+03EhKYje2H2pIKN4mKiRFkxiSlt1PCnEO03SblMru0
 znMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uQTjkRn6bAiHqBdbOK7XQS/kLvhT4v67B4Jk+TeM4Co=;
 fh=2w8mYF4LuweTY133cjdJkKBJK54+rTD/AxCP+o9GCM8=;
 b=CRNlpya8T9FU3JB0m+ZX3quWIbSLGkfg8di3G7lxtyx2t9axnkPzr/kLRLaQEpoysZ
 JSB3Ybe+RT5WXwz1x/emgewxpMOtgHzNOXgEAB7pLwcf9qV3D5SqC3U9+ZHXtZgvqTQy
 sien2f1oqhHJeKHtHL/fH9gJbbPC98ABERTCuXPFbQI6RGX6Kh3QNso72Eu8syus5EKT
 mhqbRqH82EplyZndFAxt6CJihPv3891X7I8A05ueLbX5VxgcQiWB7sXzlgNgLESY0+YS
 2316nY609zYGBWRtQ6+eNynsVFy9qhITE7haZBJk3Xx/fgm5dM2DRGruS6g5ahCmqOHm
 liWw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774525968; x=1775130768; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uQTjkRn6bAiHqBdbOK7XQS/kLvhT4v67B4Jk+TeM4Co=;
 b=hRxTXlWkWTlODUkPmLH9aYnR4Ov77gaSx/07XDBp0cqtuyY78M8fi4jXIEtZjjpP5L
 lKbr3ViVNOz+b4gXxGYrvJlIxcODdt5KUr7dr/KnB8ZAprGqR2AVQ/mY+kCTroWOD6lT
 lpCxQSX+FkD64q1FXNB20BDxCqveB/cY/eOVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774525968; x=1775130768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQTjkRn6bAiHqBdbOK7XQS/kLvhT4v67B4Jk+TeM4Co=;
 b=l9W9IPsYrPsVkbQkVzABxKYkOJ1v5YSfTpqZjmSIzSYvjeUEhGz/NyxnF5TnrmLV2g
 LwuZ7wRcKTTeBosMy6m1DBcPxcdU10v8BEYS84YNNOnwGvJBbbW8vuiMliYZp4rQ28RM
 Hmhm4Nf310NUzleSq/tFIfQd1kcfW4GZTyotMfo9qD3LLQb/HyX6gbMGl9P1u22XxEpR
 lWPueqmrS/l6ul4B6C3E+SoHCwPUlyebxuVlw+R9NlwX9i7LANDAGll3JCiS7jU/w5X/
 MKx9ul6aDm3htieHc5/pgNgFKmw10W3N8WP3b5tDkxscd7nVAujxTeno3jPAzIyQH3Jw
 Ou0g==
X-Gm-Message-State: AOJu0Yx7iAJ/LRpwWT/JlmLjTDWDPr8ryWEnyTKiYQJYCTXusaBn09EA
 J+YDxG3j13/AVqKY2k5haW2k9zidmvhNLF+Hv8fPnIdI/OjpDxgIqjKL1FsBmkRUrz3bxvgzJ5O
 RLsXvvPVLF5XjSeB+dYMjBll0nv7AS6cWQ4EC2M9S
X-Gm-Gg: ATEYQzwa7WxYf66xKxmcZ5D/nY0QqrFLcpNBcn6hdV/BwT8qV59mItY7wuYyW6/oX4Q
 cOKrmk3nDodQF7/RyhzYzApsJ4CbDiu8nAt3Hu0S90fFa5q1ivWfi502MnWBvKkoj+Db358UOgW
 Z3MLLfFwCJw6883VtiuslikOx8NXZa4sa35Eau1e2I1eHZj0tadhEKjD/H0r4ldPmWgnizCv1pR
 Rs1pF3o+5aqA2dtSSBaUzR1BmxHv4+HDUw7us/cjFJuGjntyeeFvfp0/AeSoAf5iMfnvxgcGsPj
 nBhYP9A=
X-Received: by 2002:a17:907:cbc5:b0:b98:82c9:d1ba with SMTP id
 a640c23a62f3a-b9a3f161d53mr499151966b.1.1774525967865; Thu, 26 Mar 2026
 04:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260325130811.447377-1-sjg@chromium.org>
 <20260325165420.GT502704@bill-the-cat>
 <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
 <20260325171540.GU502704@bill-the-cat>
 <CAFLszTh3NgpY1VQer2wN9-feOvM8khXaFyp+ePhTpqowGK_qrQ@mail.gmail.com>
 <20260325182619.GV502704@bill-the-cat>
 <CAFLszThCO2a1COB8kBwYfTXM65AGJEugo9MWZAjphQNuX16Y-Q@mail.gmail.com>
 <20260325195337.GY502704@bill-the-cat>
In-Reply-To: <20260325195337.GY502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Mar 2026 05:52:36 -0600
X-Gm-Features: AQROBzArWZSfkefDwD7-5JAEIv8CXH47Ou8Uj3nKgnH4Kqj7nC3igso1M1JJdgo
Message-ID: <CAFLszTimy0pLBYd=my+uDafTyS9_AmhOonhSo9TBcnzJMzM_yQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Use relative paths in generated .incbin directives
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
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

On Wed, 25 Mar 2026 at 13:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 25, 2026 at 01:21:54PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 25 Mar 2026 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 25, 2026 at 11:57:17AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 25 Mar 2026 at 11:15, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Mar 25, 2026 at 11:12:00AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 25 Mar 2026 at 10:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> > > > > > > > The generated .S files for fonts, splash screens and EFI apps use
> > > > > > > > .incbin with the full prerequisite path. When building with O= this
> > > > > > > > bakes an absolute path into the .S file. If the build directory is
> > > > > > > > later used on a different machine (e.g. in a container), the assembler
> > > > > > > > cannot find the source file.
> > > > > > > >
> > > > > > > > Use $(src)/$(notdir $<) instead of $< so the .incbin directive contains
> > > > > > > > a source-relative path like drivers/video/fonts/nimbus_sans_l_regular.ttf
> > > > > > > > rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
> > > > > > > > flags so the assembler can resolve these paths.
> > > > > > > >
> > > > > > > > The DTB and DTBO rules are left unchanged since their prerequisites are
> > > > > > > > generated files in the build directory.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > ---
> > > > > > > >
> > > > > > > >  scripts/Makefile.lib | 7 ++++---
> > > > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > This is generic kbuild infrastructure now. Is there a fix we're missing
> > > > > > > from upstream, a change we haven't pulled in yet (as we need to keep
> > > > > > > syncing upwards) or a problem upstream too? Thanks!
> > > > > >
> > > > > > Linux does this with DTB files in quiet_cmd_wrap_S_dtb:
> > > > > >
> > > > > > echo '.incbin "$<" ';
> > > > > >
> > > > > > But Linux only uses generated files in the build directory, never
> > > > > > actual source files. The font/splash/EFI .incbin rules are U-Boot
> > > > > > additions that aren't in the upstream kbuild. So Linux doesn't have
> > > > > > this problem.
> > > > >
> > > > > Shouldn't we be generating these files in to the build directory too?
> > > >
> > > > These are actually source files, e.g.
> > > > drivers/video/fonts/nimbus_sans_l_regular.ttf
> > >
> > > So, the first thing then is that S_ttf is a local U-Boot rule. Lets
> > > start by moving this out of scripts/Makefile.lib to
> > > scripts/Makefile.lib-u-boot as that will make future re-sync work easier
> > > (and is something we've talked about in the re-sync threads, splitting
> > > U-Boot specific stuff out to new files). Then 2/2 of that series can be
> > > this change, thanks.
> >
> > Almost, but I still need the a_flags change.
>
> Think a bit on how to solve that without touching the files that we
> really want to have no delta with upstream on please. It's 5 files,
> adding AFLAGS_foo.o += ... to the fonts Makefile and a note doesn't seem
> bad and reduces the chances of the a_flags part being lost in a future
> resync to zero.

I don't like it very much, but I'll send a v2 along these lines.

Regards,
Simon
