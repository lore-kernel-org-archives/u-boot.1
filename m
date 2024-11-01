Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F5E6F06C
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0215892B5;
	Fri,  1 Nov 2024 16:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n5P0b+Lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6D8892F5; Fri,  1 Nov 2024 16:33:14 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094CE892DC
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a99f1fd20c4so266549466b.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 08:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730475191; x=1731079991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6wG8KBOb/8Tg3TehtLsvVjxXsBgb7cg0K+ebuUKosdk=;
 b=n5P0b+LqFpiFpEIcM+jkULijGSi7KjgLWe4PPa+o8hg+0rpghaiIAd+a2YSAJvAGSJ
 fBJE4yxZeelhxEhwGrla4tBcm0JuiYzKZAVwOOAcBUJ6gWWxzu4MiPHuiZIJCRTZWZbu
 /wvBp4Ew9cLqGbwTwML+V19YaGxvmn0uUdzNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730475191; x=1731079991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wG8KBOb/8Tg3TehtLsvVjxXsBgb7cg0K+ebuUKosdk=;
 b=BuaYxBFztGeCbPuAoXCibYzu/+RB2POFnVsxLiqAlwE18itwbbzHKx4LPQaKeiTy22
 0z6qmHQ/WOL9ptNqqNGf2niKRukjR3gN5gt4XAiYqDCIyqf/BV+xS8kZZGv19kRS3D4b
 NM5cTwjU1eAg2lHkAscjsBGKdXbTHjxYB0lCgCsF7bTPJMHi2lj0K8RGUT8djQQbHWUy
 Qeh6FOTWxWJez/ikEoIe3MADbNF9w/zT8LTPKD83leg8Xw35WKemhunMdRR3SxpOhqth
 x0aaVTUankajwhvPkjMMxWwAXSrIZ+s13Z6MKnPOBST+Nd+2tUR3WHFl14gXvjwUTA7O
 l1Xw==
X-Gm-Message-State: AOJu0YwhxJs4rO8h8n+mam0rqXRdam/h2Yr8JYMz5LOaLXt+6DAhLsk4
 WLjD3bjC8BEUPitxo2+etMoINc8hABaUklOdHzR8TITFaZc4liStc+Zr4c9IeQXhox+bFUMYekt
 SR08mFSP1ZTOTH37niG6V15Wj9HlwTKKb05l1
X-Google-Smtp-Source: AGHT+IGoGDvkZ/sxS6+Gq6HD4D/knrveu9PrXxRbVKkSkfmKaDAZ7j24T3I10KB8nFCK83peyEFHR8dtQQEo/lN1c28=
X-Received: by 2002:a17:907:868a:b0:a9a:7f84:940b with SMTP id
 a640c23a62f3a-a9e5089d4efmr721088766b.10.1730475191474; Fri, 01 Nov 2024
 08:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-4-sjg@chromium.org>
 <20241028193310.GS4959@bill-the-cat>
 <CAFLszTgHHgBPByBdBxGWPpJ0tTkoTfZ=aN3MY80mFBR+CujvLw@mail.gmail.com>
 <20241029163642.GA4959@bill-the-cat>
 <CAFLszTiXXXNFUeGoe+0ivyWgh-9MDYdCETFoWDcskYwHd-c9bA@mail.gmail.com>
 <20241031181049.GV2558755@bill-the-cat>
In-Reply-To: <20241031181049.GV2558755@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 16:32:56 +0100
Message-ID: <CAFLszTit0yePZLL-_iNjKOBFhCgKN2Wd=fXxB6OeV4j7Cnb9LA@mail.gmail.com>
Subject: Re: [PATCH 03/21] bloblist: test: doc: Move into the common suite
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>
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

On Thu, 31 Oct 2024 at 19:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Oct 31, 2024 at 07:00:41PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 29 Oct 2024 at 17:36, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 04:45:40PM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 28 Oct 2024 at 20:33, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Mon, Oct 28, 2024 at 01:41:08PM +0100, Simon Glass wrote:
> > > > >
> > > > > > There is no particular need for bloblist to have its own test suite.
> > > > > > Move it into the common suite instead.
> > > > > >
> > > > > > Add the missing help for 'common' and update the docs.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > This feels both like churn and weird. I would think "common" tests are
> > > > > for things that are kinda legacy and too catch-all to have their own
> > > > > subgroup.
> > > >
> > > > It's just chosen so that the test for common/ is in test/common - i.e.
> > > > it makes it easier for people to find it.
> > >
> > > Then I really don't understand renaming bloblist from something
> > > descriptive to common which is not.
> >
> > Old: test/bloblist.c
> > New: test/common/bloblist.c
> >
> > It is only the directory that is changing.
>
> Then some of the commit messages need to be reworked? It looks like it
> stops being "ut bloblist" and part of "ut common" and that's my concern.

Oh I see...

I basically decided that there is no point in having a special suite
for bloblist, and some other things. A better way to handle this would
be to allow running tests which match a name, e.g. 'ut common
bloblist', because we are adding way too many suites IMO.

Regards,
Simon
