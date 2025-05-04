Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAFFC369DC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FC182724;
	Sun,  4 May 2025 15:23:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RNTn8Lli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA5CA82757; Sun,  4 May 2025 15:23:35 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E8582163
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f624291db6so5309468a12.3
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365013; x=1746969813; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YS4uLJfTQsGNP4b3MsSb0vcNX08qga8MLEANLbTuzpA=;
 b=RNTn8LlidPnJC+YDyvgPvmS6974J75Ucb/157yYkJmWHndD0YA4A0+n/zjVEzdZV22
 iYIJP+fDmn45Rf5R93WI9xHXMKTnrk1P/MxANRoRbKEEI8wlQ3g4QQthZNrZtyHUhAFS
 EsFdwiBuZKUGSivzSwQjP/6roUYCkO8rhhpUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365013; x=1746969813;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YS4uLJfTQsGNP4b3MsSb0vcNX08qga8MLEANLbTuzpA=;
 b=hgGio4+K3VM+dgRGbFS6N3Am+SS8ZPfaoJ1fx0ls8L7ROXqsrtGuh5yyq7COhy/Ak7
 O3BttUi3E0q6wqHgw+uvNVLObfJfKwhH8DCfseeFuqJsYqGZxyVIvpXkDewVvwjfw4DR
 oDHFZJcHUTWydpyACHiQwBDwQsrFfZIlUSDWXd+niJzz8QiTx96lLYZ+PlftSCYJCzJS
 XgkUQKmjY/03NSxMgsB5fj9x3v0mDcjjCGdJ0q33vGmGLs4UbWSvhVSMaFOmi/TB7CCn
 B0ASrQ6ijw3l0TEZXHX+16dBXSzKBWOkYfiAmBK3jtyFO0qKWLT+JLtcn7M0qXNClnhM
 aHgQ==
X-Gm-Message-State: AOJu0YzOUJIHHJM9X1ybV0l4pWBr5mZxWG6rSABRq/uF34gh2oYIaei/
 C2VYMdjlrXOMJeSsfy4uYvPdOBnRJEafW04vyHBB11290FsypNUuvFVgBi7qymTVGFtAY5YHY8f
 z4xJVl0AZk9Es3clHtzQ0V1dP6sBQxRwJCCo1
X-Gm-Gg: ASbGncuwoy2BOkdgujKJJ7QPmYEIotSlHmFmiL+6KbCoGZHEOF/wOxGFSByn27An5up
 bpXMrHrx4tYh5GhucpBbzVA+xwOul/lbvkinWW7jJjBxR5YKV1GUFFOzCvFsb4eVC959502ImWr
 C1x+U6aL8E0079mZPy/1JAwd0=
X-Google-Smtp-Source: AGHT+IHfgJWbj/FpNfSetSoqiVdGkzoB9EhWSOa0hx9tUIbC4opktqg0/gwtNg8mGkxVEBFLtWChvlHRruw3YQFoEWw=
X-Received: by 2002:a05:6402:13c9:b0:5f6:23b1:ab43 with SMTP id
 4fb4d7f45d1cf-5fab04bbf9bmr2946640a12.0.1746365012729; Sun, 04 May 2025
 06:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjmTK3n=nqmBMp3_9gONZBm3VctKkqguq3Pb3K3or8Pnw@mail.gmail.com>
 <20250502222120.GB1261075@bill-the-cat>
 <CAFLszTgxkTLWZUw23ntowwA+MYCMy6t+0swjw_fTT3y-PgPpxA@mail.gmail.com>
 <20250503165134.GE1261075@bill-the-cat>
In-Reply-To: <20250503165134.GE1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 4 May 2025 15:23:21 +0200
X-Gm-Features: ATxdqUGF5CV94A5x0te1Sfqazsey80g36uKx6M2uR_JKJ37bwDw2cStvAxdmCR4
Message-ID: <CAFLszTh_uQ6cUvSqp_CKdVzOtZWrVCZzG=47r-h3C1hK2MiUGw@mail.gmail.com>
Subject: Re: Please pull u-boot-dm
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

On Sat, 3 May 2025 at 10:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 02, 2025 at 08:11:17PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 2 May 2025 at 16:21, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 02, 2025 at 03:40:32PM -0600, Simon Glass wrote:
> > >
> > > > Hi Tom,
> > > >
> > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26056
> > > > https://dev.azure.com/simon0972/u-boot/_build/results?buildId=77&view=results
> > > >
> > > >
> > > > The following changes since commit 6cc812f8cc55c132458c7da5b9fb7666315cbe8c:
> > > >
> > > >   Merge patch series "video: Enhancements related to truetype and
> > > > console" (2025-05-02 13:57:26 -0600)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.denx.de/u-boot-dm.git tags/dm-pull-2may25
> > > >
> > > > for you to fetch changes up to d31d3a2949873b6217036650a449c1a1f74e6244:
> > > >
> > > >   patman: Drop the old status code (2025-05-02 14:54:39 -0600)
> > > >
> > > > ----------------------------------------------------------------
> > > > patman improved to prepare for new features
> > > >
> > > > - Create a separate module for the 'send' function
> > > > - Move to asyncio for patchwork comms
> > > >
> > > > ----------------------------------------------------------------
> > > > Simon Glass (30):
> > >
> > > You posted these three days ago, which is very quick for
> > > non-security/regression fixes, and didn't post v2 where you rebased to
> > > master and should have reworded:
> > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/5a4f8a1f339ce4de2eca812bc19cca1e2ad6b9ea
> > > as the commit message and the change no longer match up.
> > >
> > > And this is the same standard I hold everyone else to as well.
> >
> > Oh well, I'll hold off for a bit. I'm itching to send the actual
> > feature, so I might do that while we wait.
>
> And you're going to post v2, right? The thing that needs to be posted
> and have time for people to review it first?

Yes I can post v2. I was going to wait 3 more days but can do it today.

Regards,
Simon
