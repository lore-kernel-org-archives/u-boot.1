Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA7D4EB8FDE
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 12:23:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B7DE8685B;
	Thu,  7 Sep 2023 14:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbsCDHr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1736E86863; Thu,  7 Sep 2023 14:23:41 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503608620C
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 14:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7f0a60a159so754283276.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694089417; x=1694694217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MJsD8e1Rv8BaUS74FI1nHxPeOKhaRKEa7W84+WShn20=;
 b=LbsCDHr18I2xoYmMqTir0DfaJL6U5yvILdrCgwIYHcGF2Y8FrBK1omDLWUDDX6X2uR
 C56KvQtbt32rTwvvgvxQllQHR4CCeo3YjtmP1ts5M79oNHMjchzgQBurEhdokQc14wrX
 sY7GvC1IqvEvQ2NWLBy7eHUJwsQ0myHhMLQbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694089417; x=1694694217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJsD8e1Rv8BaUS74FI1nHxPeOKhaRKEa7W84+WShn20=;
 b=T6UjPZd8kmTCLZkV4NX13pA9KUMx+cxRQG9AoYsADNJf1eRqL/JWOHW6FbM0UjcryH
 7jup0thZjca2xSMdwAwCeba7euEVTEasjY28BHrUg6U5B1ANicHjoib18nlVTdMnnoQI
 dd6Lsk82STnI7SWNuB5yX9YG5ay5OuppvQxppFOVDc6q/oQ0e6OWpC50zndh5c8ByLQs
 tCqkWETo/KLC97QoMqVkUzPKYO/xGyxbvThUS1xBvEOzmt/SLjsv29/07BwlCWJUubqX
 Rc+V6vCpQlpvVIYtSuA4Y+JugenGI3pKwCOwfmOamRqHZY8eHAs0rWgHXYv2D1oMYg/z
 mo/A==
X-Gm-Message-State: AOJu0Ywp5yEYnEtyIvOBUMyU5ICdxJpk3j3BPqbB1czcKe4XkRF50mHn
 bU9WWUOzzEm1dUoV04jHzK2rJD0VGZlu9nA5kBQD5w==
X-Google-Smtp-Source: AGHT+IH6xlK3Y2axRGU1ckQBgtlC92Ka6yiNKVC4b7hbxtLeGxk4bwdeDC1FEXn+ksrMqqAHy96b3+yL3A1WRQ2Jhr8=
X-Received: by 2002:a25:ad03:0:b0:c15:c55d:c26e with SMTP id
 y3-20020a25ad03000000b00c15c55dc26emr19198725ybi.54.1694089416802; Thu, 07
 Sep 2023 05:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_055CBAA884BC568E56211618940881653D0A@qq.com>
 <CAPnjgZ37OL8XjMu1eOYPYR8OdmEp52tMwbVfJ5+j8_fCE7WRig@mail.gmail.com>
 <bd2a0c45-9d6a-494b-9ffd-f32fdec21027@gmail.com>
In-Reply-To: <bd2a0c45-9d6a-494b-9ffd-f32fdec21027@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 06:23:07 -0600
Message-ID: <CAPnjgZ1s5HAHzNJqE-rko2Vb6Hf=yCE4x=8S+KOtez8aK=mcSg@mail.gmail.com>
Subject: Re: [PATCH] Adjust gitignore for /build
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Rong Tao <rtoax@foxmail.com>, Maxim Cournoyer <maxim.cournoyer@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rong Tao <rongtao@cestc.cn>, u-boot@lists.denx.de
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

On Tue, 5 Sept 2023 at 23:04, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>
> On 2023-09-04 22:18 +05:30, Simon Glass wrote:
> > Hi Rong,
> >
> > On Sun, 3 Sept 2023 at 20:50, Rong Tao <rtoax@foxmail.com> wrote:
> >>
> >> From: Rong Tao <rongtao@cestc.cn>
> >>
> >> /build-* can't ignore /build.
> >
> > How does that directory get created?
>
> Most likely `make O=build` as an attempt to do out-of-tree builds? FWIW,
> I manually create and use build/$board/ directories for build outputs,
> but adding "build" to .git/info/exclude is an easy enough alternative.


Reviewed-by: Simon Glass <sjg@chromium.org>

>
> >> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> >> ---
> >>  .gitignore | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/.gitignore b/.gitignore
> >> index 002f95de4feb..9697f0088f80 100644
> >> --- a/.gitignore
> >> +++ b/.gitignore
> >> @@ -35,7 +35,7 @@
> >>  *.tab.[ch]
> >>
> >>  # Build tree
> >> -/build-*
> >> +/build*
> >>
> >>  #
> >>  # Top-level generic files
> >> --
> >> 2.41.0
> >>
> >
> > Regards,
> > Simon
