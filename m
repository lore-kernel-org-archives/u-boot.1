Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FF2C3ABAA
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 02:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACBA8820EB;
	Sat,  3 May 2025 04:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XeT4lGHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F658210D; Sat,  3 May 2025 04:11:31 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AF7820E1
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 04:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5f624291db6so4022784a12.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 19:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746238289; x=1746843089; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3WvQNoGdwMvZ2ZI6ybC43rxuxM1lPNoILj/iX1Q4Ki0=;
 b=XeT4lGHva4wMwFM9mN6DPlGx9hxNHcyrdGZ0Jw8kfYkCNE6hTKBc1pvXxq5g6Nv3ui
 5jerPfYAcOe5t2XHrLb1iNvHPI/HDvqv87j9jP7JcnSqpGU0X9GIA71hb1nGd89hH8rb
 NlmGJMw6fn93kSc6xID5qjkDzMyDbbb6U3wdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746238289; x=1746843089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WvQNoGdwMvZ2ZI6ybC43rxuxM1lPNoILj/iX1Q4Ki0=;
 b=vzeLwT2xbql865iGmuJYhVAJjbisfmaMhIwlkMRQuSNc3T4nNYT21uChp20vpfnyhf
 8SWJ0VyJjR3s2bFB9GFBFH/ia55hcQUGjaJaMZpMBwLvDPUwbSgUqHhhEpJGEJgRyZSj
 yAJbv1rk5MdYKOb+TEvuBWKC9r85wQXb2qo9JE/vmKLtsQLhY3YknssjOqp5ORtJDfHX
 7oKBAIK69mQ69h1kbft51gN9UX5xLh6Ha5uGV3jPjG5YMrxwTPGPjT+a+e7SvG/byY2F
 jAljjehOuXvx9afrRfGq/M0C0buloUQ9AmqZmdlja1FBaLlvBIp24K5J7nB558JivJGE
 YA8w==
X-Gm-Message-State: AOJu0YxrpGHxScJnrWz3WiTFkA4SOXxfotZ+cwnCAeORFbvUdUqZ/aZ0
 4lwasvpdk6HOMnWZ9hH3LRUAk0qa8rysx5xSSxkr2zPbPnD4Ep5LpPSbDuZsDR4/Ogs4MsHVoA8
 GeiLzyTTrOxYDlMy/oHWXzzCRUf3IqS/SsSFn
X-Gm-Gg: ASbGncuUIaT24lTJSYGwJQovypL1yNLXmyIyoPMgUhyoN6XxqkRi07hMpask1HVykn4
 JHEDG41lpXbFZr3+AlU49jV79wBhPfR6XA7L+VqpT5cbysan9oQtDjzi1h+JbwowyjbA1U89HNU
 Oi3PhNdglIDi9/kSLNrY7V114=
X-Google-Smtp-Source: AGHT+IFmluCDVNBqEFzukWPtn7mIgHSI5yB38tabrYshOHvsgPQ7gcGaFbhqT5FvQ/R091MOJme/mBHfeG7/zy0VHT8=
X-Received: by 2002:a05:6402:42c5:b0:5f6:23d2:e6f7 with SMTP id
 4fb4d7f45d1cf-5fa78985ddfmr4083200a12.32.1746238288752; Fri, 02 May 2025
 19:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTjmTK3n=nqmBMp3_9gONZBm3VctKkqguq3Pb3K3or8Pnw@mail.gmail.com>
 <20250502222120.GB1261075@bill-the-cat>
In-Reply-To: <20250502222120.GB1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 2 May 2025 20:11:17 -0600
X-Gm-Features: ATxdqUGCdIckXZJymKYt10rPBabrGLuRYiOVOoozS07scP6wcAO6XNeicHIzW-U
Message-ID: <CAFLszTgxkTLWZUw23ntowwA+MYCMy6t+0swjw_fTT3y-PgPpxA@mail.gmail.com>
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

On Fri, 2 May 2025 at 16:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 02, 2025 at 03:40:32PM -0600, Simon Glass wrote:
>
> > Hi Tom,
> >
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/26056
> > https://dev.azure.com/simon0972/u-boot/_build/results?buildId=77&view=results
> >
> >
> > The following changes since commit 6cc812f8cc55c132458c7da5b9fb7666315cbe8c:
> >
> >   Merge patch series "video: Enhancements related to truetype and
> > console" (2025-05-02 13:57:26 -0600)
> >
> > are available in the Git repository at:
> >
> >   git://git.denx.de/u-boot-dm.git tags/dm-pull-2may25
> >
> > for you to fetch changes up to d31d3a2949873b6217036650a449c1a1f74e6244:
> >
> >   patman: Drop the old status code (2025-05-02 14:54:39 -0600)
> >
> > ----------------------------------------------------------------
> > patman improved to prepare for new features
> >
> > - Create a separate module for the 'send' function
> > - Move to asyncio for patchwork comms
> >
> > ----------------------------------------------------------------
> > Simon Glass (30):
>
> You posted these three days ago, which is very quick for
> non-security/regression fixes, and didn't post v2 where you rebased to
> master and should have reworded:
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/5a4f8a1f339ce4de2eca812bc19cca1e2ad6b9ea
> as the commit message and the change no longer match up.
>
> And this is the same standard I hold everyone else to as well.

Oh well, I'll hold off for a bit. I'm itching to send the actual
feature, so I might do that while we wait.

Regards,
Simon
