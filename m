Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018A9CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 12:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AE883EEF;
	Sun, 14 Jun 2026 14:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XGg3UTYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8A384704; Sun, 14 Jun 2026 14:39:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D73283FEE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 14:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-68b90fc6a1dso4804563a12.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 05:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781440746; cv=none;
 d=google.com; s=arc-20240605;
 b=L85p8kt1gmYNtP2p/PwNluiZbFSwZU+RalpzDIB12XwBuYKFEth19NTLERK7bFpXfm
 cIVnw36mfkmodtJm5M14mTmOlSVb13AwgTtdPiWRoyHdwGfeDMgHjjqHutMqTFWIKhhH
 amuzpoQQPVIWawK3n9bZBh7eFgu2zF294YqF7DTBvwf41MzeP8q8yjdzKY9Nh/3/c8lh
 Od9Dt1pA2U5RPb2rors7vkEvySWTRDYlenbjDWuiLaqZWHviITsPQjlxj/o3OCSfOwJy
 Hes0VelUCK6WkDkCcNN8ZW/45ciI4EkXaQsX01Bt7X7bw9ipsa/USMJHpcpGPhxu3Vxj
 wleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vK5Urlf65mH5laqGPO19O0N5521hLp5G4oak16DnKDE=;
 fh=x8CHnSGD4cRa4Gb5OxW3DEd7ozMoYZsI49tbFC7/xcM=;
 b=CPV6AOyhZW5Od3xvqBbVz8MaJqgTOMzvtNmYfWlWCjyyXiDenpinmmSH7RilwY7ewp
 2HnqxGdhRSOKhA9DnefBnlQKEkDf+r9dVUrtowNASbYRMGcpDgtjCyYoj5oBLnNvak1W
 XRu5Mb+X//5KMcg6ExvCsEkTfrI/vByLhEIYOkBf8oLiFyaKGSCQK7bPb5o8rdLGJP4A
 x1yvPL+0qjE8NlbDRmZRI1bN6y/JFDJelXbP8k+Rp3kGAugDkDDq22UoZnsdItuH/C5x
 s7nowUED7owcxrWMNgq40Cq8M/x2/uv1HytPvaTmiFfyLe4iAvGwdiXeN1xnBSB6wVeh
 Z4Cw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781440746; x=1782045546; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vK5Urlf65mH5laqGPO19O0N5521hLp5G4oak16DnKDE=;
 b=XGg3UTYlJLBtSQB2q1e+f3e853Sis/eEu/PJ92gsvIWjbHGu8WQDprzPoMPyutqKDd
 ua8JHyY4k4P6tEKylgu7TRnk2Mx6RKUN3d1ySDuCA/XwDryPTWs3Rp/964KfxhtDwuAt
 +JG+bWpuUP8cVsEgKgply4+l36Xl+6IEr7ufc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781440746; x=1782045546;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vK5Urlf65mH5laqGPO19O0N5521hLp5G4oak16DnKDE=;
 b=iMO47B7EiyF0gydk1GYznQOevrZxmWD+QHE4gHhST3z2f1DuP3BaU9adhnGk0ucFLY
 RfvU7YwvZVN3ui1w+gxN6127mlB6eGICB/D9vltZwEeqxnP3SVGRu9RHQPDNgcomoB8K
 avJxoIFJ2tjlfeYKG5Mbbp1mtRvtmgEtx1mSW9os3+qjYoFHWuw+duH2OEnJB3oTz0W8
 hYQeCbChoLq18QXtA04/ooo1egr4VlYTQyrpSMcoyyb2hN8ZOCoyJiBJ6lwk84y3L0tc
 3H+3nRZsTR7Zh8Kwb0+53SjkSux5AhcEDQqUWqgFzOl1EVV0Dd07TtEa2cR5fDumS38v
 1MgQ==
X-Gm-Message-State: AOJu0YxVPn6IgN/cmZwlCGViEnE9wEF9k9iU/3dhgtJnb6WHn490RQE7
 qx4Vrzq8GBZNelFiJNwtPPQLtxk5yj6jwmSFJkVyU6+qGD47Etm9ijm6+YD2vbC9gzpR4/caLCF
 pPAKyHx7pSvI3/WLk1ssPOk1q9tKKWGZhdgcDfYlrpkW/o2Ak6SM=
X-Gm-Gg: Acq92OF7Izl7WhV/dR0IbiZcawJWfncidEfapqgsVcpbGC4/JHbce4oipTozlAqgkg+
 KTlHdui6ah3sCzjN8Nf3T62qLVl/xpCLHzUPtANCloENRf09ozM3BAXfOHXwFPjGfjTvaYRpPyq
 uFgTsdHAgCec3kHii8ny8NI0VYlRyvoguQLGnqQmZ9l5xxzZFdfeLFvi6SW0huanRtrjVozqtRh
 QPnGYZxQ+9GSR6v8gjvWDmj790WqI+Fde9sWee5rLJKXOHdysE0yphlB7qPWvbmaYKsZ8cQ+Tmt
 7MIhtg==
X-Received: by 2002:a05:6402:22da:b0:691:5578:7fb8 with SMTP id
 4fb4d7f45d1cf-693695c349dmr2831576a12.10.1781440745837; Sun, 14 Jun 2026
 05:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260412111958.943933-1-sjg@chromium.org>
 <20260413201344.GF41863@bill-the-cat>
 <CAFLszTg5kA7fee0t_w93Xt9cR89V-8VWQ-_2eKLz1M4rjaqA2Q@mail.gmail.com>
In-Reply-To: <CAFLszTg5kA7fee0t_w93Xt9cR89V-8VWQ-_2eKLz1M4rjaqA2Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 14 Jun 2026 06:38:53 -0600
X-Gm-Features: AVVi8Ccd2e4Ifgsq0NPtWLh1FYXuRH3t6XwL5ENMQTm6-eyNCEp0MIS_yUZOA4Y
Message-ID: <CAFLszThPmOyKzRWU-go2cvbESJiK+bru_Z-8SS4nV4ePjfn0tw@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] test: Add support for passing arguments to C
 unit tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@denx.de>
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

On Thu, 16 Apr 2026 at 11:42, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> On Mon, 13 Apr 2026 at 14:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Apr 12, 2026 at 05:19:37AM -0600, Simon Glass wrote:
> > > Some tests have two parts: a Python test which handles setup, such as
> > > creating filesystem images or configuring the environment, and a C
> > > test which does the bulk of the work including assertions. At present
> > > there is no way to pass information between these two parts, so
> > > things like paths and device names must be hard-coded in the C test.
> > >
> > > This tends to make people write tests in Python, but this is not ideal
> > > for several reasons:
> >
> > You still need to work on explaining your changes in a positive manner.
> >
> > > - Python lacks access to things like return codes and has to scan the
> > >   console output to figure out what happened
> >
> > Pro: Python exercises things the way users exercise them and so exposes
> > deficiencies in our user interface as well, when applicable.
> >
> > > - Python lacks access to internal state, so it cannot directly check
> > >   the result of an operation
> >
> > It's unclear when that is, or is not a problem and when tests that do
> > check intermediate state are providing value.
> >
> > > - Python is ~100x slower due to console interaction, etc.
> >
> > Again, maybe you should go back to your suggestion of several years ago
> > to see about addressing that, as the tests themselves are not slow, it's
> > the pipe? Our brave new AI powered world runs on Python handing stuff
> > off and getting it back super quickly.
> >
> > > - C tests can be stepped through in gdb, which is much harder with
> > >   Python driving the console
> > > - C tests can exercise internal APIs directly (e.g. fs_read(),
> > >   fs_size()) rather than going through the command layer, so they
> > >   test more precisely what they intend to
> >
> > All things that may or may not be problems for other people, or are
> > intentional choices as they again test the system the way it's used.
> > Using gdb attached to u-boot in the other terminal where you're running
> > breaking things sounds like a reasonable debug path to me. And having
> > unit tests calling in to functions is why today we have a lot of things
> > not marked as "static" and so not being optimized as well as they could
> > by the compiler, which is its own set of trade-offs and not an automatic
> > good thing and design win.
> >
> > [snip]
> > >  16 files changed, 1437 insertions(+), 279 deletions(-)
> >
> > All of which is to say, you need to explain yourself in a positive, not
> > negative or oppositional way. Otherwise this reads like "I don't like
> > what we do now, here's a bunch of change to what I like instead".
>
> Just to check, is this a discussion and you would like me to reply
> with more details about the benefits of C over Python in particular
> circumstances? Or are you wanting the cover-letter rewritten. Or is
> this just a NAK?
>
> I did some work on using a socket to talk to sandbox (it is faster and
> also avoids some of the confusion as to what state sandbox is in
> without having to rely on looking at console output). But I never
> quite finished it. The other option (which we briefly discussed years
> ago) would be to build U-Boot as a Python module. I haven't tried that
> at all, but it's an idea.
>
> I am well aware of the tradeoffs between Python and C, so I am not
> advocating one over the other in all cases. I use gdb a lot with the
> pytests - e.g. hunting down memory leaks recent. Really I just want
> them to coexist better - i.e. improving the sandbox pattern where
> Python sets something up and then C runs it.
>

I see that this series is marked 'deferred'. Does that mean rejected,
or is there something you are waiting on. I believe this (or something
like it) is an important new feature for testing.

Regards,
SImon
