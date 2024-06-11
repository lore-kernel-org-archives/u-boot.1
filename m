Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EE5C27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 08:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6209885FA;
	Tue, 11 Jun 2024 10:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WMA0vBDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43E288606; Tue, 11 Jun 2024 10:55:18 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCEE388381
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 10:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so921390a12.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 01:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718096116; x=1718700916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nq6dVffrRx6TUJg+pkp5Jz2Y1o+CqGvljfM/SkiXVJY=;
 b=WMA0vBDSsO4hfL6Sv3MXRZmlqpW5rgzn5LAEX/jKNhLn6AjH2Gr+cOJ+u3x57ttrU+
 2YWX8Nyt8bMN+YaPOnwXUYou9hjHt4lFVEvqdAfKXcKjo3OdGp595OliddaLj8OTkZHf
 fo2LudZ27cZQrTthuRxzXJ7dY5JFAKI5RSOXqR+dKiN0xTUeJ04vA7KqRHNrPZ5sXrvt
 dcGzdJX0QMd0yKpPeIUSTCLsAbKZ31SU4Jc6cgOVltKTXT6xqVFgaNAhosWUD7wz6p2q
 +xuk3AAFX5wKYVaXCzlIWwJjS31uHGju7lVlVim9mgoDrAG+9yFnVGQjTgzEibNjHw/Y
 DEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718096116; x=1718700916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nq6dVffrRx6TUJg+pkp5Jz2Y1o+CqGvljfM/SkiXVJY=;
 b=ppyPQni/qf+202kRCYXjzHgdAMMM5STKikAOpv6wZrpPDefzr3ceZTmp7crKC4WCpT
 VZkleahU6XI+MFviFEQ5ylrTxlVnX1WXmhBQ8XrooyB4TouThrMhMWXitLedPMkJXcYE
 xqtIJvXHm8Yi3mwuHsX9jzpQ6WcGcUxiVPAt0pIcSo2fJ/qSCUeY/lhPUGzHR/zudw8f
 Tczos+cAYyy45w17tOhI7tdOQSS2/h0jO9UU2a70pBQ83gfhllZIoY+xVgfcDkwxKU5X
 IWym7nsqMNODxDWvkyOo3+GM++4YzrGsvS9HmvOl0wPh9/H5AbQy06VJ4RvknwUXOSft
 Xscg==
X-Gm-Message-State: AOJu0YzuEppljKmGyH+8k95BVmw0QQtCnCl16V6eIfmWEIK7xts3rKpV
 JHpHThE8sXovc8TP+n5O/ibnG+/x4GdYU6A2ct/pAqeVzOgSsbOB/RQUzr/cANW7EWsOHNQGipY
 8AuIHdMJP63/l7z683I1Bro9cV+wpH0xxM2EgOw==
X-Google-Smtp-Source: AGHT+IEXNauHjjJvCtSYohbcfEy2fLm1ufyvm7KFqF8/46IN5Gvf18x/hFYMK6geourd5U3q+/ofaSb/lmV5d1J6KkI=
X-Received: by 2002:a50:9509:0:b0:57a:339f:1b2d with SMTP id
 4fb4d7f45d1cf-57c5086e237mr7895156a12.5.1718096116180; Tue, 11 Jun 2024
 01:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-23-sughosh.ganu@linaro.org>
 <20240610174450.GX68077@bill-the-cat>
In-Reply-To: <20240610174450.GX68077@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Jun 2024 14:25:05 +0530
Message-ID: <CADg8p96rjN48peBf=cxbs7k7ku0stV-4bBhL5+RrTnPJVS1tjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 22/31] test: lmb: run the LMB tests only on sandbox
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Mon, 10 Jun 2024 at 23:14, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jun 08, 2024 at 12:22:31AM +0530, Sughosh Ganu wrote:
>
> > The LMB memory map is now persistent and global. Running the tests for
> > the LMB module will result in the memory map getting reset, and this
> > will have side-effects on the rest of the working of the platform. Run
> > the LMB tests only on the sandbox platform, which is meant for running
> > such kinds of tests.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> I'm not sure about this. We can reset real hardware as often as we need,
> too. Did you run in to problems with this test on non-sandbox?

But do we want to reset the state of the LMB memory map on real
hardware? This was working up until now because of the local nature of
the LMB variables. But if the LMB memory map is to be persistent,
should we allow it to be changed for running some test? That would
have side effects? I think running these tests on sandbox should
suffice. I mean there isn't any aspect of the LMB module that is not
getting tested on sandbox, right?

-sughosh
