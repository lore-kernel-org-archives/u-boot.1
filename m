Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A10310AB807
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 19:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FBA081E18;
	Thu, 26 Mar 2026 20:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j4nxSz2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C509683CD3; Thu, 26 Mar 2026 20:46:39 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F28C80517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 20:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so234154966b.2
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774554396; cv=none;
 d=google.com; s=arc-20240605;
 b=MhVXDUfcuqZx1TMko2q34bBv6wFM7rm8MS6esmfESFLt03NCKzpBG43jvqsr9P0d9R
 116tCGfxp/i01OMB3xacx0UNMKKIWX9I7BanrSUWwR4j4IY8CGx1GWN0Eg4lwykwfQVP
 QJzjeOT1MSgAlsU/GNqZeLo+Ea8vqIePR4xb/M187MFWAuxhOGXoJKHewbpB/h5YQc2o
 iZ+KzK08xF9Bd8Pg+lFFpdowO7Rv5ld7Gu7JG6k5ezk6sZboO9y0dBYuBnH95jvgraRs
 WV6WcJpxAeqQFoMs2p9pC7ugLaqTGDne2QMHqWNLDVNdVKC65cv750JEWKzrYQLLwV0I
 Y8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Pbj3BbRScsVXrLnNb4V+BMAkQbPRDM9SkYwrhQ4UPZo=;
 fh=X+TXTfimi8ikLXygKYSNqmXeuVlv5IEYi0IesntAZJo=;
 b=RnCTs3YoZcPC3DO3DNvns7hbtv27aGnxum5/RyEDc8Ymx75KdhgzaydsN/N1H2s9xc
 /6s+0dhlPP8ZCjF96LDJYrUQMHCp8tnmDf9cValSx8bbRKJLFiBK7jI78PjJ6N/OT+bV
 NN+xecSSyBA5KGOCmwfpEN64K2cdYdZAhiBojIXZ9x8SJS59m+yCcoaw8WMjxy286juI
 /hnwaNS+bvmHm4LN0fWuDfELQsc5fUE2eaR8GwPLBl6s6mwbaYd512V/AKsmbXN73VMF
 9HcewxPiLKcAguwByt8lhOJL5xb5ICOsk9HWbTXK+/1Hz1pDMbvrRqJiWoOiw9x+RhU6
 7jGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774554396; x=1775159196; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pbj3BbRScsVXrLnNb4V+BMAkQbPRDM9SkYwrhQ4UPZo=;
 b=j4nxSz2dcNR31UmEBk608WDMGfO+h7r4Aca8/zDssfb+bzhLEBrW8orI3zslsdIOsm
 P+jBz0hl3M6fORbTJwHc9uDsZ52ekwQ4dIbnMmgtQRksWAqOj7lT7FNrzCIiFYH25g93
 54ZYElhyMrZ3erOLw1qGR3HJHt+Dj0QEaDftU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774554396; x=1775159196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pbj3BbRScsVXrLnNb4V+BMAkQbPRDM9SkYwrhQ4UPZo=;
 b=hyqIRT5JHzc3Apddm1xD/8hvf+UsnjxKr0T8A10Smd6lkzDbL2G3lPKYEo+GS82T1u
 JJa+k07N7+I2IvsCLVjiT29WcW8XTzZhC4uh7z/C8GLAfeaQHQOG9Pc68dKI4RJYwV1U
 0DZ1OZuebOgpHnZCeCX34GJj0uoL2bbmU2nt8+u5N4nDjsJbUV+A2L8nXK4nTq7qWVMu
 +K+5+JkcFANWyYiiO0aXt/HOczzKbsH6Yj+iBRw8DLQFagT1hEDjS6zVnBH8IRvgiB6w
 fZLR2qf53kshDJB8jvYu4jGz6jgjegGGA6sSh95vcGg6LUO/OpJK0NH8WzoLaQwWoowJ
 PzrA==
X-Gm-Message-State: AOJu0Yz3OYDb3z3NlrNvCZmdRGvJ3XNeNvoxpllhyeVnIKz0OlD881Ar
 P3eAUfk4tVxcCdTR9STcM4hZrEB++noP7DK/NdzCmvB2tr8PgCiO05ASlKXnWiE9mXmhrbgQx1T
 AbFG7mEBcrGjtFERrQJvWrtIiEy/J1Ciz3PqZzXF5
X-Gm-Gg: ATEYQzztQTflr2q+UE3j9lTOM2JYLfCVz8DzwlYf1DvUNPOEd0J2Y2/ukiSSeDR0XXm
 D08UAQVtvxSMzzwI1g5m4HBFpFrGMoMJX6a6V/OYEQ8zYMkWf6xc/49c1mKhCTB23CDRMzVSTHA
 pj8kt6Zol6tnhCsAo6uf0Wm1HxiKWjHhCLaalWWmKrs72yojnqEyDETz/Bg55l1zZGInIrScnWu
 H008SoHDUatPfRolzg2s27QDcS5sd9/VQJT0MGTVmsFTPeSKCbFiffdEjNd8C4X22PNBQo3kjd0
 KoAWXG6x8lP3QVkfFQ==
X-Received: by 2002:a17:906:60d:b0:b98:4156:8787 with SMTP id
 a640c23a62f3a-b9a542c0b0emr456289066b.49.1774554396431; Thu, 26 Mar 2026
 12:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260325201806.GA3445024@bill-the-cat>
 <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
 <20260326154716.GA502704@bill-the-cat>
In-Reply-To: <20260326154716.GA502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Mar 2026 13:46:24 -0600
X-Gm-Features: AQROBzAXoaGmMSlPGXjmrZv-s7cqRufkSEJBbJEYVWkDCfAYK8VVDs-AiIOtLAY
Message-ID: <CAFLszTjovewJ3YCz-Fu39Tr=W8ZOWo9EC3m1VDVBuEjJG2zcJg@mail.gmail.com>
Subject: Re: [PATCH] CI: Update sjg lab to match currently actively boards
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>
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

On Thu, 26 Mar 2026 at 09:47, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 26, 2026 at 05:44:29AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 25 Mar 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> > >
> > > > Various updates:
> > > > - c4 lack signing so does not currently build
> > > > - samus hardware is non-functional
> > > > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > ---
> > > > A sample run is here:
> > > >
> > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
> > > >
> > > > At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> > > > broken on -next
> > > >
> > > > The ff3399 board needs some investigation.
> > > >
> > > >  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----------
> > > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > >
> > > I have two sets of problems with this patch.
> > >
> > > One, it doesn't do, but perhaps I wasn't clear enough when bringing it
> > > up, change it so that failure to pass is a job failure (it's currently a
> > > warning). This in turn means people can't tell expected failure from new
> > > failure.
> >
> > It looks the same as sage...can you post a snippet of what the rules should
> > be? It shows failure for me, when the lab fails.
>
> https://source.denx.de/u-boot/u-boot/-/pipelines/29670 shows a bunch of
> warning for failed boards.

OK, but how did you generate that? Did you see SJG_LAB=1 for the
pipeline? The rules look the same as sage, but perhaps I am missing
something.

>
> > > Two, when you had previously gone about adding at least colibrimx8 I
> > > noted that this extended how you were having labgrid build U-Boot in an
> > > even further non-upstreamable manner. As the sage lab yaml shows, we can
> > > bring in external binaries for buildman (and binman) to find and use.
> > > We'll need to extend that logic a bit, to be sure, but it's a solvable
> > > problem with the baseline already there.
> >
> > Not quite. Buildman builds U-Boot, it's just kicked off by Labgrid (via a
> > U-Boot 'provider' class), with some pre-built Intel binaries for x86, plus
> > BL31, etc. put in as environment variables. My design approach is different
> > from Sage, in that I often connect to boards interactively, send U-Boot
> > over USB in some cases (so different files are needed depending on the
> > board) and at the moment I have all boards connected to a single server.
> >
> > Labgrid has 90 open PRs, including my terminal one
> > <https://github.com/labgrid-project/labgrid/pull/1571> from over a year
> > ago. There definitely are PRs getting in though (20 so far this year). In
> > terms of upstreaming, my approach has been to break things down into
> > smaller PRs, but four of them are still outstanding after 18 months. I did
> > ask on irc a few times but didn't get a response.
>
> Yes, your approach requires changes to upstream labgrid, while the
> approach I suggested before, and was able to finally get done a while
> ago, does not, and still allows for using boards interactively. labgrid
> even supports python well so whatever tooling you wanted around labgrid
> and building u-boot and anything else could be written in that, instead
> of shell, for example.

Yes I suspect you are right. One of the design decisions I made was to
put all of the config in one file (the labgrid environment file).
That's not something that the labgrid projects wants.

I really can't operate with an external terminal program though, as it
loses output at the top for some boards. Also I need the USB drivers
and QEMU changes. Perhaps tougher are the changes to the UBootStrategy
to support sending over USB, different power/reset combinations, etc.

If I could get some of these smaller PRs upstream then I could start
to do some rework. But until then I'm not it is worth the effort, as
everything will still be downstream.

I'm definitely keen to replace the shell scripts, probably with
Python. I've had good results with uman being fast to start, having
shell aliases, etc.

Regards,
Simon
