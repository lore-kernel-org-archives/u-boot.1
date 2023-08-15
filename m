Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32488C001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A67286874;
	Tue, 15 Aug 2023 16:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RSZAYCZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B9B8685D; Tue, 15 Aug 2023 16:51:05 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D518686995
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d45caf42d73so5518589276.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692111061; x=1692715861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+HSGfIx5X5G5UUtgCuX3p6mjyZX4Fjul/gqUD26Knhg=;
 b=RSZAYCZ/C0R8IvV7qCs1hAc5mSu/0hSLxYLudn/QQcgcDqkfsh57omWVk9CjN/DWa6
 L5Oy+llUNejuAILd6x6EsjvLJYoVDqxs+y66eLyeMZpH+iRyahqJLSCzxwz+zJ7GaT27
 Jy26ndy8xwH8pxKiLCLuYUg529Kp/HEkWPpYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111061; x=1692715861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+HSGfIx5X5G5UUtgCuX3p6mjyZX4Fjul/gqUD26Knhg=;
 b=DjPH92jWneluWhZqzqRCVDhUv/zM44iPIA4YLqDK1YzQcrpIWUxTeN1Ajx88R7IPDM
 nNO88yqaFBF4cEK4eXTiIVJkwgWeBUMIV3piVq8a/mJOIsSjb+XjLYHbfxaiU7I2cawl
 5OYE18EPmB7hNiAizjunDD1TvT4YdqUFWLLPNjKRvGhak6HjC1+OuRacqo0wgtxellCO
 cYr+AM8Nx1iAN9GSPT6kFwr++iNlJfFsfdDBhltZzGRPC57zegGqrSNa8SF90cVp52La
 s8HRFOnIUXUS85GJiKPsQ4OTFARdmk2tM/uLDxnSKQOtteT89x5fTGPgYFmJpqxnhaAf
 WWzg==
X-Gm-Message-State: AOJu0YzRspOR2jWFlNuuOM1eq2nIPxf7HM+0k8Owrlt1xqNQ9ujLGAvd
 geGp4Y1NoifyRD7BkMaz0F6v362oED6WZ6PM42UdIA==
X-Google-Smtp-Source: AGHT+IHEq5h+FzS9J2EUPBoeDQlKNY110m57bmPMYkB6ZMdP2KIrBxdeT15E4hqWf0z4Fl8EMu9ZlmFMdCTD25oEMxo=
X-Received: by 2002:a25:c017:0:b0:d08:82a2:6a4f with SMTP id
 c23-20020a25c017000000b00d0882a26a4fmr13268043ybf.42.1692111061380; Tue, 15
 Aug 2023 07:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230812142223.GI3630934@bill-the-cat>
 <CAPnjgZ380FF64cHtBjMTztJpj1bqF3-u2Vpt0YdRo7EzqSiVcw@mail.gmail.com>
 <20230812142824.GJ3630934@bill-the-cat>
 <CAPnjgZ3zC_F4OvuUqfU1=V_aAp74kyNNcEqgNky2VhyWhcpFOA@mail.gmail.com>
 <20230812223758.GK3630934@bill-the-cat>
 <CAPnjgZ0sfYRBGxB=_5Loi-9K=RgfSqLHA2FLafYgBs9vQaC59Q@mail.gmail.com>
 <20230813124045.GL3630934@bill-the-cat>
 <CAPnjgZ2moLG0HKVyQ5nZk91080dpNbC9EYD+u1H1Dw6sYkJ9sg@mail.gmail.com>
 <20230813144352.GM3630934@bill-the-cat>
 <CAPnjgZ0DpYY3X9w66N6G0tgAwoN_3-SToTT+2yMmk0Gibse8fg@mail.gmail.com>
 <20230815144645.GX3630934@bill-the-cat>
In-Reply-To: <20230815144645.GX3630934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 08:50:41 -0600
Message-ID: <CAPnjgZ0Ej6afQLTQ3i1TT1nSjjWZTteBqu_eH12AqFBDOT1UGw@mail.gmail.com>
Subject: Re: [PATCH v8 4/9] sandbox: Build the mkeficapsule tool for the
 sandbox variants
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>
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

On Tue, 15 Aug 2023 at 08:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 15, 2023 at 08:44:18AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 13 Aug 2023 at 08:43, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Aug 13, 2023 at 07:36:45AM -0600, Simon Glass wrote:
> [snip]
> > > > I see what you are saying, but from my side I am trying to enumerate
> > > > the boards, since generally I (like) build things without explicitly
> > > > specifying each board defconfig.
> > >
> > > Yes, but that's not possible in this case I think.  And I'm really just
> > > trying to figure out how we can make CI a little easier.  But maybe we
> > > can't / don't bother in this case and keep fixing up the sandbox
> > > defconfig files as needed.
> >
> > Maybe...it sounds like you are really just wanting a way for buildman
> > to manually build a single board with some config added, rather than
> > having it detect and build everything that is in-tree?
>
> What I'm trying to do really, is since you didn't seem to see the value
> in config fragments before, showcase how it would be beneficial to
> sandbox (and CI) if we used them there.

Yes, don't worry, I am past that stage and I see their value.

But I think for this to be more broadly useful we need a way to
enumerate the combinations permissible for a board and give them
names. Things like qconfig and buildman need to know what is going on
and cannot infer it from the filesystem...?

Regards,
Simon
