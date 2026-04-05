Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88579E63FE8
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 12:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E63D8352B;
	Sun,  5 Apr 2026 14:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S3oj0G/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A82183C14; Sun,  5 Apr 2026 14:13:46 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CABEA8341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 14:13:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66b2f6e983bso5015094a12.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 05:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775391223; cv=none;
 d=google.com; s=arc-20240605;
 b=UzZR7D6S3477PjYh+ylRIQV2YCtJxj9w6wlZMNKuBfdaWF/bVl0XpHYLfNok20G+kr
 zUPTEYI1X9VUUdyhgKSETc9v5Uwy9NmaHwii9ojgJjw+2ewOy908kQD4Wa0YAkPL8zhh
 jIKT4YcXW7bj5CCe67DHPzixbvUKXHjUhB+4YlhF53sZBYyeVLDv9m3pR++33t7aGWPK
 iTEXtnpXN3oVT1os8Z5VJdT2+2MgTDZ8hNnMeWJk5Bm1bdpyTV71XM6DJbiIySZcSJPX
 FK7iMhGrSUucfPmRKYZMlhFzayYUEH5UH4cAzQ5S7uLF404IPj/7capFgaFxwEyVcILg
 iwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Nl6vPKVQJ343dfKjbLKzjX01hNpYVyz+fITodoYN1cU=;
 fh=X+TXTfimi8ikLXygKYSNqmXeuVlv5IEYi0IesntAZJo=;
 b=W43jPa/95FL0b4qidoVUxB7bne7h6b5rSzGZcZasE8JZOT8MWkxySXPJ+OlTjvOFdB
 ZBCyzw2RRApxZhCE9I9kGgjKghk3Yj9c4ak4DbvqZ9mCUwXT5lQVuH3UQsAer1K+KWV1
 dJ2ssnRkiHXhWoKXHRPbVCgcmNTRit7FKoJDFoEWoFe1OivDj0HZ7iwjh4RGQe9KFsAP
 08jNYooSG02fUOnFQlZkvrrkRto6X0u/xw9k+Pm4lupq0sAcFLDNFaK4reOUSbeAlV9Z
 NgEGG5pLF1JUGMXFFn9z0T0qnR9qGYuXzKhOY2PRdL8UzUylLwOZGuhzM47dZoCc1pKk
 68eg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775391223; x=1775996023; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nl6vPKVQJ343dfKjbLKzjX01hNpYVyz+fITodoYN1cU=;
 b=S3oj0G/gRK3ByFPU5C2kM6cXgoLatJyvFGf7vvaFv8k4Pz1Nkg+1LtlAFxIx47CIm2
 9e0I3Rg+1rZtiHB+JwKHmTu7C4OkkrQJagmWNLcymWxdXsn3X2XMlFLX+zvRsbjqJQ7k
 FikK3AiWYXr3sd+EP/v4oNvuiySnDQg/Ur/dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775391223; x=1775996023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nl6vPKVQJ343dfKjbLKzjX01hNpYVyz+fITodoYN1cU=;
 b=HbEDpM8hc/JlXzO6QHAR4iBwxcnQJYU1uoPJNRDqeuPnI5Dx8JGcW/INJw0AR2Y3Ru
 bdRrUHR7HK0SvzvQJFsOjh4XLMSXPnpoh7tIaMy9vfGE4gOyFZ49+LAnKkkgJiNdBksK
 Y2wfRpsIYgrgHsUf1UpFx+Wfasv0ns4Zlofmm9uPrX08KzPTHRiEZO755rf61UIPcM7N
 diS1nbM4zu6zEJUC7XXhP9QqVaTnO5yfmbRCpEaK07nxOB4hu70d5lkBogMcqu8/purd
 VFNqMRpPHPrpHr28CSTx/T3xXQObmTJDwNxwfT7y0tihHhY4PZmNFosXiCSNlxEjarbn
 aGKg==
X-Gm-Message-State: AOJu0Yxohita554f+GXIIh1MmdK/X4gvHLo2ICONE25I7P9uqHoHH1vc
 cyByDjSk4ckx5CKwpUMofJ8LdA0AX/38bLZ/ek5zdFZ+FDbozXjaxzgMMhiYM0lOw7kdrkKGR4r
 yLwTRMdiMBj38F5W4ZIHuMLdi1UegJADawqOGGJqv
X-Gm-Gg: AeBDieuw8OEGu3xNNbRdWliSK0+N22xPfpfkdcaU2Ewo8IlvzPthurhEA+8J9NpnTym
 kaR38lIAfhgSarkkvllcG51pJlHbw9gC/tHvIkpLNZNzc/7+QgKZ0rHF9SUksa4RU9orW2DKFuj
 B+AxT/f4H+/R0upzjivO0mxxcBLinTWcGeWTFz7HyiQGDOxw/2ffcdtuKkWKKtw03ERd6TaQHRd
 hFebD4J0wIyX18TOe+Pl4StUcMb+wfSbaGZ+Mfe/Jv5NLyxRXxWZdHtXBXvbMwyGeqTKVgRzx6/
 nNOT1T3gkNqCct4r
X-Received: by 2002:a17:907:c002:b0:b97:c5e2:d7c9 with SMTP id
 a640c23a62f3a-b9c67b8f3f3mr484307266b.44.1775391222976; Sun, 05 Apr 2026
 05:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260317131839.2418655-1-sjg@chromium.org>
 <20260325201806.GA3445024@bill-the-cat>
 <CAFLszTgEq7e4ee9H3mbNeBOgG-8B8L_-E0LsQNmGPZfXLK2BXA@mail.gmail.com>
 <20260326154716.GA502704@bill-the-cat>
 <CAFLszTjovewJ3YCz-Fu39Tr=W8ZOWo9EC3m1VDVBuEjJG2zcJg@mail.gmail.com>
 <20260327165319.GD502704@bill-the-cat>
In-Reply-To: <20260327165319.GD502704@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Apr 2026 06:13:29 -0600
X-Gm-Features: AQROBzBVgdKpRua2Wm7YZ0NrmBu9d-iSxadOWc-GFTBYhXndj-Cq4n3ZlzXSzDA
Message-ID: <CAFLszTgV6Kye+gmrJEF1xL5T4JrPxt+QZihYNYhvA=Jn0rVZFw@mail.gmail.com>
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

On Fri, 27 Mar 2026 at 10:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 26, 2026 at 01:46:24PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 26 Mar 2026 at 09:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Mar 26, 2026 at 05:44:29AM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 25 Mar 2026 at 14:18, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Mar 17, 2026 at 07:18:35AM -0600, Simon Glass wrote:
> > > > >
> > > > > > Various updates:
> > > > > > - c4 lack signing so does not currently build
> > > > > > - samus hardware is non-functional
> > > > > > - colibrimx8, rockpro64, rock3a, rock5b, rpi5, tk1 and play are new
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >
> > > > > > ---
> > > > > > A sample run is here:
> > > > > >
> > > > > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/29552
> > > > > >
> > > > > > At present, coral, play, rpi5, snow and vf2 appear to be genuinely
> > > > > > broken on -next
> > > > > >
> > > > > > The ff3399 board needs some investigation.
> > > > > >
> > > > > >  .gitlab-ci.yml | 46 ++++++++++++++++++++++++++++++++++++----------
> > > > > >  1 file changed, 36 insertions(+), 10 deletions(-)
> > > > >
> > > > > I have two sets of problems with this patch.
> > > > >
> > > > > One, it doesn't do, but perhaps I wasn't clear enough when bringing it
> > > > > up, change it so that failure to pass is a job failure (it's currently a
> > > > > warning). This in turn means people can't tell expected failure from new
> > > > > failure.
> > > >
> > > > It looks the same as sage...can you post a snippet of what the rules should
> > > > be? It shows failure for me, when the lab fails.
> > >
> > > https://source.denx.de/u-boot/u-boot/-/pipelines/29670 shows a bunch of
> > > warning for failed boards.
> >
> > OK, but how did you generate that? Did you see SJG_LAB=1 for the
> > pipeline? The rules look the same as sage, but perhaps I am missing
> > something.
>
> Yes, I ran the lab job (via the UI instead) in that case and I'm not
> sure what you're missing in how you've got your lab setup.

Just to check, did you pass SJG_LAB=1 when you pushed to the pipeline?

>
> > > > > Two, when you had previously gone about adding at least colibrimx8 I
> > > > > noted that this extended how you were having labgrid build U-Boot in an
> > > > > even further non-upstreamable manner. As the sage lab yaml shows, we can
> > > > > bring in external binaries for buildman (and binman) to find and use.
> > > > > We'll need to extend that logic a bit, to be sure, but it's a solvable
> > > > > problem with the baseline already there.
> > > >
> > > > Not quite. Buildman builds U-Boot, it's just kicked off by Labgrid (via a
> > > > U-Boot 'provider' class), with some pre-built Intel binaries for x86, plus
> > > > BL31, etc. put in as environment variables. My design approach is different
> > > > from Sage, in that I often connect to boards interactively, send U-Boot
> > > > over USB in some cases (so different files are needed depending on the
> > > > board) and at the moment I have all boards connected to a single server.
> > > >
> > > > Labgrid has 90 open PRs, including my terminal one
> > > > <https://github.com/labgrid-project/labgrid/pull/1571> from over a year
> > > > ago. There definitely are PRs getting in though (20 so far this year). In
> > > > terms of upstreaming, my approach has been to break things down into
> > > > smaller PRs, but four of them are still outstanding after 18 months. I did
> > > > ask on irc a few times but didn't get a response.
> > >
> > > Yes, your approach requires changes to upstream labgrid, while the
> > > approach I suggested before, and was able to finally get done a while
> > > ago, does not, and still allows for using boards interactively. labgrid
> > > even supports python well so whatever tooling you wanted around labgrid
> > > and building u-boot and anything else could be written in that, instead
> > > of shell, for example.
> >
> > Yes I suspect you are right. One of the design decisions I made was to
> > put all of the config in one file (the labgrid environment file).
> > That's not something that the labgrid projects wants.
> >
> > I really can't operate with an external terminal program though, as it
> > loses output at the top for some boards. Also I need the USB drivers
> > and QEMU changes. Perhaps tougher are the changes to the UBootStrategy
> > to support sending over USB, different power/reset combinations, etc.
> >
> > If I could get some of these smaller PRs upstream then I could start
> > to do some rework. But until then I'm not it is worth the effort, as
> > everything will still be downstream.
> >
> > I'm definitely keen to replace the shell scripts, probably with
> > Python. I've had good results with uman being fast to start, having
> > shell aliases, etc.
>
> You've outlined a direction above that I don't think is good for the
> project as a whole which is why I don't want to encourage it by adding
> more machines that will only ever work in your version of labgrid and so
> it not replicable for others. I don't think anything you're describing
> above can't be done today without making upstream changes and that
> you've designed yourself in to a corner.

Here are the main things that are absolutely required:
- USB drivers for Tegra, Samsung and Sunxi
- Servo driver (for Chromebooks)
- Internal terminal, so that boot output is not lost for some boards
(I believe we discussed this issue at some length but you have not
seen this problem yourself)
- Update U-Boot strategy to support sending over USB and different
reset/recovery combinations, as well as things like colibri-mx8 which
need some work-arounds

I have PRs up for the first three.

Re the last point, I suspect you would argue for separate 'labgrid'
commands to power on, set reset/recovery, do delays, etc. But that
logic needs to live...somewhere.

It is certainly possible for others to replicate the setup[1]. I went
to a lot of trouble to document it carefully, too. I did a rebase a
few days ago.

As to the direction, I would like to see some progress on the existing
PRs first, since without that I would only be able to support a small
subset boards anyway.

I do have concerns about performance too. How long does it take to run
a smoke test for a typical board in your lab?

The main issue is that Labgrid's support for multiple boards in the
environment is incomplete, but it is improving, e.g. [2]. When I asked
about this I was told that I should be using a separate environment
file for each board. I suspect I could move in that direction with a
bit more tooling.

I'd also like to move the scripts to Python. For your lab, do you have
scripts for interactive use, smoke test, running pytests, etc.?

Simon

[1] https://github.com/labgrid-project/labgrid/pull/1411
[2] https://github.com/labgrid-project/labgrid/issues/1194
