Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62884CE835C
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 15:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E0488E56;
	Mon, 30 Sep 2024 17:55:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jAUjmrBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B612C889E9; Mon, 30 Sep 2024 17:55:43 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C67688E56
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 17:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb2d2a7d48so31943836d6.3
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727711740; x=1728316540; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rIKgu7cUxeJNky8hWLy6yxrjKZbnLuf1g/fyElyo4To=;
 b=jAUjmrBsJOxIMQRtU+MZ9iwkwvuE5njioi2t4kzWugoYG19h/Xt47ssKgtzmhNjUap
 rTBDAbaEE9NZcGaoPegV1H8QAOWCkjku+TW/AiSFkIE/VaTk+plgDrtPmiUVf/+yUn72
 VGUIi8Q4FlvuP82nO3LyHNRRafnaSBTUb1EWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727711740; x=1728316540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rIKgu7cUxeJNky8hWLy6yxrjKZbnLuf1g/fyElyo4To=;
 b=lINO4t8JHuyBJO2WtaW4aiXKjymKf2l8JbHp2zwEzwljhPVC2WoiOXS/6SkL70PXWu
 Eqr++sGUJzWRagNsL7sWJRD9s8PQ7/5KBcTjl23C6ahpd5/xI/b+JedqOEvQu3AGruae
 b1XhLDF9s65tTUZX+bPYllKUxVYD0QgpeD6OeXwcEgtkB5Yd4Oj1q45zCV54/yRBWsNi
 ZBzIMM9STCodidJRF23Soa7Nr4R6V6g1uK2G80c7lt5qqS9F58CW9RmB3Cz6b+Ptf0i9
 KhbRa1VtkbWYszb+S1QONUGIbSQmnoCmbqgRUJhDNL5GnI1HnHCFlDG00IpLwwbduY6b
 y8dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw9IqtCTNw6b5MvdO59PLbnCo+uvzIURW9Ls4eIs1iblC3P427WkOcMnHamMyHC51La//Y9V0=@lists.denx.de
X-Gm-Message-State: AOJu0YzUqgcfvzrOX/+Ry6g8XcNdf+YsbeyYeczZdyLQkSfeyk6WY7Ue
 3GzdrChskFIEkmGKCTX5+myXRdMBKRbLW8J2Tag/0ShEwmEL989wnfbzvNS8oWkiQmFJxKE/4v4
 ZU5Tcyvg2EllYdRPtb5M+DkQhLEJ2UxfqJSc0
X-Google-Smtp-Source: AGHT+IHZvghBHUTBtrv5Mnt/shSPAdtdVRneDU/K9GcUB9QcZYIi7XOfoEIOV+xsv5rVycyCgQq/1OcmITvDWoD/chY=
X-Received: by 2002:a05:6214:3b8a:b0:6cb:465f:368d with SMTP id
 6a1803df08f44-6cb465f3bc4mr183464256d6.47.1727711740227; Mon, 30 Sep 2024
 08:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
 <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
 <20240927204046.GW4252@bill-the-cat>
 <CAOMZO5DAUD3WR5z8ZxPkVhnv_2VZpYaHRziEvZ7MHvwooNS8Jg@mail.gmail.com>
 <CAFLszTiUQBJvaU_bhUYdsujo-oeeT8RCDguu+pYQ9YEppqqALg@mail.gmail.com>
 <20240930004623.GA5579@bill-the-cat> <ZvqJJ7DOhxpEBgXl@zoo11.em.health.ge.com>
 <CAFLszThuGsiQeQXaL6jtHezj_JAQ+TwJTco_8C=qDTiu0sLFOg@mail.gmail.com>
 <Zvq6B84h6xEw9GmD@zoo11.em.health.ge.com>
In-Reply-To: <Zvq6B84h6xEw9GmD@zoo11.em.health.ge.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 09:55:29 -0600
Message-ID: <CAFLszTgH2btdXxRd5p4+vX8d3t5_4ZTRQRpxHiMb3Beyh9AsBw@mail.gmail.com>
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

Hi Brian,

On Mon, 30 Sept 2024 at 08:47, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> On Mon, Sep 30, 2024 at 08:10:49AM -0600, Simon Glass wrote:
> >
> > WARNING: This email originated from outside of GE HealthCare. Please validate the sender's email address before clicking on links or attachments as they may not be safe.
> >
> > Hi Brian,
> >
> > On Mon, 30 Sept 2024 at 07:01, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
> > >
> > > On Sun, Sep 29, 2024 at 06:46:23PM -0600, Tom Rini wrote:
> > > > On Sun, Sep 29, 2024 at 04:49:17PM -0600, Simon Glass wrote:
> > > > > Hi Fabio,
> > > > >
> > > > > On Sun, 29 Sept 2024 at 14:53, Fabio Estevam <festevam@gmail.com> wrote:
> > > > > >
> > > > > > Hi Simon, Marek, and Tom,
> > > > > >
> > > > > > On Fri, Sep 27, 2024 at 5:47???PM Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > > > Please can you coordinate with Marek as we need to sort out the test
> > > > > > > > coverage for this etype, before adding more functionality. I did a
> > > > > > > > starting point, now in -next, which should help.
> > > > > > >
> > > > > > > Well, when someone has both time and understanding of the tools and the
> > > > > > > frameworks, we can expand the automatic tests while still having
> > > > > > > functional testing as people use the feature.
> > > > > >
> > > > > > Do you think this patch should be applied as is? Could the tests be
> > > > > > handled later?
> > > > > >
> > > > > > Please let me know.
> > > > >
> > > > > Who is going to handle the tests later and when?
> > > >
> > > > Someone, once how to write and run the tests is documented. That's a
> > > > big hurdle this private thread has shown, to me at least.
> > > >
> > > > --
> > > > Tom
> > >
> > > Hi,
> > >
> > > I fixed a minor issue in the patch, and sent a revised version.
> > >
> > > Seems that you don't have the testing quite defined yet, so I don't know
> > > what I can contribute there. Maybe something can be done with the CSF
> > > parser to check that the signing works correctly?
> >
> > Just to be clear, the testing is fully defined...this is actually the
> > only entry type which doesn't have a proper test. Every other user was
> > able to add a test. The goal here isn't really to check that external
> > tools are working (they should have their own tests), more to check
> > that Binman is doing the right thing.
> >
> > I will get some sort of patch out by tomorrow morning to help this process.
> >
> > >
> > > However, I think this feature is quite benign, and it would be great to
> > > get some functional testing in for this feature, as Tom said. For us,
> > > this is an important feature, so we have done extensive testing
> > > internally to verify that it works.
> >
> > I fully understand that...but of course without an automated test in
> > Binman it may break at any moment, as Binman continues to be expanded.
> >
> > BTW, minor code-style things: U-Boot's Python code uses single quotes
> > and the line limit is 80cols.
> >
> > Regards,
> > Simon
>
> Hi Simon,
>
> > Just to be clear, the testing is fully defined...this is actually the
> > only entry type which doesn't have a proper test. Every other user was
> > able to add a test. The goal here isn't really to check that external
> > tools are working (they should have their own tests), more to check
> > that Binman is doing the right thing.
> >
> > I will get some sort of patch out by tomorrow morning to help this process.
>
> Alrighty. I'll include a test once we get this sorted out.
>
> > BTW, minor code-style things: U-Boot's Python code uses single quotes
> > and the line limit is 80cols.
>
> I don't understand what you mean because I did use single quotes :)
> Perhaps you were looking at the CSF template, which is not Python code?

Ah OK, I see. It would be less confusing if you used f-strings.
Unfortunately Binman does not use them always and there are tons of
pylint warnings about it.

>
> As for the column width, sorry, I was only trying to follow the pattern
> in the file. I thought it was 120 cols. I will include a predecessor
> patch to fix the column width to 80.

Oh, OK, yes I wasn't around when the original patch was sent so didn't
review it.

Regards,
SImon
