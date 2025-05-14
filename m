Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAD2C3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 19:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 316AE82A33;
	Wed, 14 May 2025 21:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mTB06ph4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E568382A8D; Wed, 14 May 2025 21:39:41 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D212B8205B
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 21:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5fbcd9088a7so462236a12.0
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747251579; x=1747856379; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vk5ZzX0XeMHvJ9DjN4/Pz4uAkcAsg4+veRtS3z62UEU=;
 b=mTB06ph4X6uXHuHLt3KAd4rJFC/WTwv0EE7pVDNIsf8xdwSAQ245YruyeqYa/xf+tp
 h2S1dAIIjbHwWAYnyu1fagq7sxDpOdz0z8iwpBzY8V+/x6eDQmzElQyQhjZU9viYk3xY
 m76E7O7tOyc/DbZEzyF1B50XGvf1fLIlpDSxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747251579; x=1747856379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vk5ZzX0XeMHvJ9DjN4/Pz4uAkcAsg4+veRtS3z62UEU=;
 b=mniHwqDF9CkjnuB86pw5p7MH8Q+//1Wzj438mogQGgM4cEgn3Q2s38xdYDYCC9OQxw
 hSDwMNPfgsrWIwOl0WhiXdP7m2nS80f2rSKreVR/OHKKx4ExnVDrn4I+m079AW3cZQx3
 HdivXUX3x7HbhARUi0x3vcsZSAMKARqn+bxYw40DlkyALHoEwHGN10pQOjM7/CLBlNMJ
 TE/ccbNcfN2Vl+UbKBgJoSWrMxDqEc2nsOQ2yNM5MveVl73CHg1Pg84kElpHou0gjWbQ
 hYywtO9oWyGbHR5BADV9cik4w0xmXJskvaXFdnlKC40oLj0CTEjxBuHXBQxCE/dzV0aX
 zVkw==
X-Gm-Message-State: AOJu0Ywsyhg49gSC5Iudd5VHju6h6Msi5BVJH4xdVgO0nBqdn4EKxcOd
 Z68tRu4iwQL1VRqPjj47ViAEwmqDGvGMT4nxcIaE2z1m+6oGU3kUvF1d99FpCZQcxFlYY7yJ1Yg
 VPJrhLwk3QdvMVtiUorWs8EnOJYINWDwGK1YNbSmx
X-Gm-Gg: ASbGncv7jtkQv5rDAnZ2Ve+WkzLNmdGQsJW/EKX4t9Vm8X7X7j6Nl4BqrBORX6xUS+G
 PeUl3w2noj52Z39hRH0H35UG71hjIOkjzJbywPuf8hR/iWk6sea74tmFaxcPvV4DGXRgaxl70x3
 HylXtlpgqM0++TnLaukVOEvnoyPA3bdKrb8A==
X-Google-Smtp-Source: AGHT+IH4NK+QFIs9aDh84SP8xLiZwZCOr9Z9UcozTqHt8lk7ATd6+9Tnqi4AM8qzW67jgzTxEJyWz9/osx33k2/BtkA=
X-Received: by 2002:a05:6402:1ecf:b0:5fd:1778:70b1 with SMTP id
 4fb4d7f45d1cf-5ffc7900839mr663063a12.17.1747251579150; Wed, 14 May 2025
 12:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
 <CAFLszTjwfGV6P7GzFDYFVp8G5oTvoXUKvOXZy6KLNW_=BMO+xQ@mail.gmail.com>
 <20250512220439.GS603748@bill-the-cat>
In-Reply-To: <20250512220439.GS603748@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 May 2025 21:39:27 +0200
X-Gm-Features: AX0GCFu8za7gHTIl8T1SPcfMSlQ2zngIaEnqD77HgEhU_6KCFmjpj3RuOiqnYCE
Message-ID: <CAFLszThK_syj73fC7Xc9YydBm7b55hYrHBJNuR_HCA8xADDPLg@mail.gmail.com>
Subject: Re: [PATCH 0/3] doc: Document remaining test_b* tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 13 May 2025 at 00:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 10, 2025 at 01:27:23PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 8 May 2025 at 23:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > Hey all,
> > >
> > > This short series is a follow-up to my last series. It could have been
> > > longer, but I think this is a good point to get some feedback on a few
> > > points.
> > >
> > > As background, something I wondered about and the answer seems to be No
> > > is, can we automatically take things like:
> > > @pytest.mark.buildconfigspec('cmd_button')
> > > and get some nice output? Since we can't that limits the value,
> > > possibly, of generating some documentation.
> > >
> > > First, as this series shows, is there value in documenting tests which
> > > do not require additional configuration? We have some tests with no
> > > comments and some that are fully commented, but at the end of the day
> > > when trying to run these tests, pytest will already say helpful things
> > > like not being supported on a given platform, or not run because
> > > something isn't enabled in the build. Spelling that out in generated
> > > documentation would require duplication of work.
> >
> > Yes, I agree. I think the code is the best place for most of the docs.
>
> >
> > >
> > > Second, is there value in documenting arguments? Especially ones like
> > > "ubman" that are just required and always present?
> >
> > I like documenting arguments, since when people see the docs they
> > continue the trend. Python suffers terribly from a 'def
> > my_function(*args, **kwargs)' disease where you have to spend hours
> > spelunking around to figure out what is actually valid as an argument.
> > Highly Pythonic, but dreadful.
>
> Maybe I wasn't clear in these two points. Let us use
> test/py/tests/test_cat.py as a concrete example. Today, most of the file
> is:
> # SPDX-License-Identifier:      GPL-2.0+
>
> """ Unit test for cat command
> """
>
> import pytest
> from subprocess import call, check_call, CalledProcessError
> from tests import fs_helper
>
> @pytest.mark.boardspec('sandbox')
> @pytest.mark.buildconfigspec('cmd_cat')
> def test_cat(ubman):
>     """ Unit test for cat
>
>     Args:
>         ubman -- U-Boot console
>     """
>     try:
>     ....
>
> My point and question is that "@pytest.mark.buildconfigspec('cmd_cat')"
> will not be translated to generated documentation, but also that if you
> try and run this test outside of sandbox, pytest already tells you it's
> not supported, and a similar error if sandbox but not cmd_cat.
>
> So is there any value in adding doc/develop/pytest/test_cat.rst that
> will consume the above and generate valid documentation that I'm not
> sure would ever be read?

No, I agree, I don't see any value in that.

>
> > > Third, should we document internal functions too, or just the tests? I
> > > would be inclined to say no unless they're expected to be re-used. The
> > > test_net functions to bring up the networking are an example that of
> > > reuse that should be documented for example.
> >
> > Sounds right. But I am likely to continue to document all Python
> > functions, since I never know when I'm going to want to export
> > something for use elsewhere.
>
> I'm certainly not saying we shouldn't comment the code, but perhaps
> a follow-up to document test/py/tests/test_distro.py would clarify some
> of what I'm asking about in your mind.

OK

Regards,
Simon
