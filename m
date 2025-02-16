Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE81C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 14:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5864780BA8;
	Sun, 16 Feb 2025 15:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NWsEDbzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C91808B6; Sun, 16 Feb 2025 15:10:26 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9B580C7E
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 15:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e04c044224so875173a12.0
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 06:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739715024; x=1740319824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G6AcettGHYOjE9ArUkq/wDF4+X+Wn6a89vxAMCUD6SI=;
 b=NWsEDbzw+JZ2OWuFXpEMNo3ZQVZ8dBdXVrv2Q5LBuEJIHhQaDwVULIIxYXXE9bTvy2
 5/ClO6iyJnMCAVaheXWZa2A7ntcsp/oI0wmFfhsoF7vw5mhHBqnmF5GRcWyje/DuZbZc
 jwBcdiVgSddke3FwM7/ifEufjOckOJSuviewY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739715024; x=1740319824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6AcettGHYOjE9ArUkq/wDF4+X+Wn6a89vxAMCUD6SI=;
 b=DmCnMRHIqEsK749kQ0QxeYq+52tApZiGwWbh2ETym6BCFiP1kA3Ug/t9CylVMWV0m4
 qF9MFIPwjdgt0XEZg9QUgdHkLMiLsUnIbCjHqusY6hTHlWqB9qGGjeUT8dC6sASDoHqk
 pBYHlB9YO0arxm74ILLBY07qWxhHuJ/+HxOrpru9FUm8QWuwt8R7W4uc+xXjkccrSYo2
 yvVwexHSyWueedn1yORJIiHQGDYzMbZAaIueJRGQ9oz5y+Kw1y98YV98On3O5ppTvcML
 kKO/WJJNrapvM1DKUjleHuvQTaDqQsq1tTIv8g7VxWTSfHZ5pZCTxU8hGVWjwBLU1a6G
 tfDA==
X-Gm-Message-State: AOJu0YzbTyNMacdgFZ7DYGvpGJ2OGROMBVwIm986W9aejyaVliTb6WGY
 LUaOgWTvqJ4o9NCLCu3A27MxgFyFS2at6+g/8qy2M5e8pK2JOxsejILNcClwtUUkgwLgjMxsPJ6
 yuSM1T8WqgE1NElEJb/5aEoiCz0+5yWZuzY1i
X-Gm-Gg: ASbGncus6VikVH0Pu/hydfJuPPQ+DyS5sUg4K5UieOVEYfAMth4rQelLT+Vkh2NM/Z1
 9+ki4I9X8yezt259xC38rdsE1eIGwYQyjCulsLZxMYbyNagV3JPB/INQIsFjY6/oHJgiJioDIUQ
 ==
X-Google-Smtp-Source: AGHT+IGjKcwrq3eRFt8MA0K1wdNUg3sXhQroP32gFMZYSNl5mlQHwcxCYhEkFQcuDhk6oGdOQGWPd1xdZUdgf9SUbwk=
X-Received: by 2002:a17:907:60c9:b0:aa6:7a81:3077 with SMTP id
 a640c23a62f3a-abb70e61e75mr592929866b.54.1739715023663; Sun, 16 Feb 2025
 06:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20250206223858.64672-1-sjg@chromium.org>
 <20250210162518.GA2902864@bill-the-cat>
 <CAFLszTidZzhttm99Eafxwp2y-61yhY+0o5OWmfwowKNC+nQtZw@mail.gmail.com>
 <20250215144147.GM1233568@bill-the-cat>
 <CAFLszTi3D4g5LadMvaxEAn3uUu2V5L1wKCEBLu8=dzicb0Rbww@mail.gmail.com>
 <20250215181227.GT1233568@bill-the-cat>
In-Reply-To: <20250215181227.GT1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 07:10:12 -0700
X-Gm-Features: AWEUYZl6_GpbAkUyTpuQ_n6jU_E4Q4Ttyut0UHtpUpWH73CJW7i3Z5olnNv0e-s
Message-ID: <CAFLszThJ11Ph-8zaNV_D0u7-UD18XtULm0kwhgQmMAj5xFgHtA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] CI: Move default image under global defaults
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

On Sat, 15 Feb 2025 at 11:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 15, 2025 at 10:21:16AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 15 Feb 2025 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Feb 15, 2025 at 04:59:40AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 10 Feb 2025 at 09:25, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Feb 06, 2025 at 03:38:55PM -0700, Simon Glass wrote:
> > > > >
> > > > > > This is a global default, so put it under 'default' like the tags.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > >
> > > > > Please make v4 include the way you redid the second patch and be on top
> > > > > of mainline, thanks.
> > > >
> > > > That's enough versions for me, so I'll let you do that, if you'd like.
> > > > It probably doesn't affect your tree as not as much is done in
> > > > parallel.
> > >
> > > I am disappointed.
> >
> > I'm sorry to disappoint you.
> >
> > The background is that I looked at the difference between our trees
> > and the gitlab files are quite different. My CI runs take about 35
> > mins and it seems that yours is around 90 mins. I would like to reduce
> > / remove the delta (for time and patch diff), but I'm not sure how.
> >
> > My goal is to get CI runs to below 20 minutes, best case.
>
> I'm sure CI could be quicker still with a number of faster runners. But
> if you can't be bothered to make changes against mainline, what is the
> point?

If you recall, I was working with your tree and had various ideas to
speed things up, but you didn't like it. So I've had to do it in my
tree. This is not about more runners (although I might have another
one soon). It is about running jobs in parallel.

Regards,
SImon
