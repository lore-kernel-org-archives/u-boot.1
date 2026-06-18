Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7564CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5182E849D1;
	Thu, 18 Jun 2026 17:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DC+8Nwis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DE2849DA; Thu, 18 Jun 2026 17:54:47 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE40784874
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso179270a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798084; cv=none;
 d=google.com; s=arc-20240605;
 b=Eje9NCk7HqusXpNIw/usTsJZP+Zc8M/ojHvJPRf+1wfV34ylLgUo5SbivdNs25/QEL
 55/0y9+AUkrX2sd/oubnLjKHKvz9CwGVu5Pu1Dtx6lce3nkHE3CAmg3k6tXLHqWL/2hf
 r0rx9bGWGzuVtE/lOOQjgepaqftFEKtQXZ+v8R+B1NPYHXYTYo2YPZ9qoaWP39gXL1nV
 AHKaYYcpEKaHkT6Wr/SjCRyPMeO0rAUYNY2zn1AhRb23JryzadPpJQFzF8oWFC8bTpx5
 dNHvtEkfqMGnbv8+vvJVayMBdlnqWjzA1pI0VEkI6tB5hpXf143s0FF2QNjN3/zWYctp
 24vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jnLBW1Ynx5IPDPsbGDYl2W7m5CYfRep2wTe09Y7YRyQ=;
 fh=upkYJoYWU8qjVWIteQ02TepH03lJcEMYfBNmBkVTMPM=;
 b=GKFOHH99sROWXNjwWhWV5iDDWi7URH+uwl3Ig/2rSvC6gObfxmUluzTn3JJGxjAh35
 XXQM2gMeULzHuqVBKzsgkNFP2Qn/GmnYvZSgHSMuvJUXbIt74TXGxy0DJ7D8WEYibZYe
 i7S7moDalihDvJYxALNV3rI15eO/9KFacqQkcSgVFu50uSVXxhKXY6HJJ2ffkqZSAO55
 aNWR8Y0RIcoEpEfBMzT6x+5ez53ydpZwfPHUC+9vZSXQbT70d1ZRzEP9ltxIv8lqYOEs
 vD+DMxWrKnocFb7SdEMG7z0mPk9ErJtAKPouk/Wb5HE3KwrSsPmUWJVt68cwshn2iO+d
 se6w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781798084; x=1782402884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jnLBW1Ynx5IPDPsbGDYl2W7m5CYfRep2wTe09Y7YRyQ=;
 b=DC+8NwisKsHFn8KYPX0BYBvP7YvBBmig8Olo/G1Jmg0c8O0qwsA5AjXGksNISonb+J
 ECU/Kbv4U20ebsPqGwE1pX3gky04hDnXprchgXQFnPWZIolx7IdAC6bnwi+rwH3Ny9xH
 P8qJCr8aroM3cgg0ii+8BAnzPm55oXFEE8piY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781798084; x=1782402884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnLBW1Ynx5IPDPsbGDYl2W7m5CYfRep2wTe09Y7YRyQ=;
 b=I8FVxvf90D8+c6RB4Ybg5XFcXb65WisYKNMjEfyqsw3w6gJdq4kPBbsAatVfunQ0hm
 B6T/s9WQwa6/xzIN96LaqcjNeWpxbJD+G7Up2nO64CUpaHXS6hnjGuYpWwGDsj9TXaQl
 lyVCKB757rWZS7rerCO2lxxvwkWT/5pdBbWOym/uB6b/88aBqjcqhz5lE2XadU8vg/ms
 iJs5p/vezuNrzk1Mt4E9q2VxzNPphKKOsxVT5L6VVLd5ndvSGiVO02v2v7SSBk2jzvyl
 XxD3yRPpgfQqJzczqa29iVB3KRjfGMZbRReMVVHyinUabc/7iBicArKoV/wIKAHVieR+
 HCWg==
X-Gm-Message-State: AOJu0Yy3MOXJIzvhDHv5J3e/KPaisSjT9FOgGxx7SJblI7SjpzUszMQe
 hwLCGJZERvmM3expRKWThH5W40XtgJkKzEzfs1vEa+B02DrgSXufVRFZguAZwzgkpq1uCfb5laB
 LXWm7aU5bhD5aqTqYZc3fisXXKr1cg/gfLciYhGvg
X-Gm-Gg: AfdE7cn19fUP/QwozN55iLVhPhyLiYrnH95U9Y/dvoHfyjdIeZjeolvhCaWrePWypXk
 NsGYkEOmJIsZ6wCKecoJMoCFqMZud84qFpKNJhLki1/JKbg8J69E4fKm3/fqJ2oB+Aof1F+HUTp
 2WDF8uyz2uqyCY/PtWPuiPyRVo7i53CnsvB+wGoo4aXuQV1FJoxcWDQ6mmEXr8xucGTYaejG0Kl
 6xasRmhH4MYISHlkGMSdsFdm75Vr/psL3hXgECjokTHNA3KzLDWKzNG1JQ8/0386Gy+DOHIzQ3K
 B0qSq3hM
X-Received: by 2002:a05:6402:1356:b0:691:2ef1:d7d1 with SMTP id
 4fb4d7f45d1cf-695baa3561bmr1609963a12.16.1781798084151; Thu, 18 Jun 2026
 08:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260616142859.54136-1-sjg@chromium.org>
 <20260616142859.54136-6-sjg@chromium.org>
 <CALeDE9PFgy-GcCRiEavFxLR8fWJri8QYzRpc-1MLOcdyFNthgg@mail.gmail.com>
In-Reply-To: <CALeDE9PFgy-GcCRiEavFxLR8fWJri8QYzRpc-1MLOcdyFNthgg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:54:29 +0100
X-Gm-Features: AVVi8CfBYVQysHc9irP6b_8PcyXiblZz0Y-n4DkD0c--cgcZjkhZSIjK7WyJWcI
Message-ID: <CAFLszTgfHzsyEdvf2XHbO-gGFpBTq2t9Wt2YV_XYSeJ_PHUw0A@mail.gmail.com>
Subject: Re: [PATCH 5/9] patman: Replace the documentation with a stub
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
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

Hi Peter,

On Tue, 16 Jun 2026 at 21:38, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Tue, 16 Jun 2026 at 15:39, Simon Glass <sjg@chromium.org> wrote:
> >
> > The full patman manual now lives with the standalone patch-manager
> > package, making the 1000-line copy in the tree redundant. Its published
> > page is a long-standing URL, though, so removing it outright would break
> > existing links.
> >
> > Replace the in-tree manual with a short stub that points readers at the
> > patch-manager package, and keep the toctree entry so the page still
> > builds. Drop the README and the tool's own rst, and point the
> > patch-sending docs at the standalone package too.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  doc/develop/driver-model/spi-howto.rst |    5 +-
> >  doc/develop/patman.rst                 |   15 +-
> >  doc/develop/sending_patches.rst        |    4 +-
> >  tools/patman/README.rst                |    1 -
> >  tools/patman/patman.rst                | 1023 ------------------------
> >  5 files changed, 20 insertions(+), 1028 deletions(-)
> >  mode change 120000 => 100644 doc/develop/patman.rst
> >  delete mode 120000 tools/patman/README.rst
> >  delete mode 100644 tools/patman/patman.rst
> >
> > diff --git a/doc/develop/driver-model/spi-howto.rst b/doc/develop/driver-model/spi-howto.rst
> > index 9dc3b9b4aac..c5b07ba0e47 100644
> > --- a/doc/develop/driver-model/spi-howto.rst
> > +++ b/doc/develop/driver-model/spi-howto.rst
> > @@ -649,8 +649,9 @@ board.
> >  Prepare patches and send them to the mailing lists
> >  --------------------------------------------------
> >
> > -You can use 'tools/patman/patman' to prepare, check and send patches for
> > -your work. See tools/patman/README for details.
> > +You can use the patman tool to prepare, check and send patches for your work.
> > +Install it with ``pip install patch-manager``; see the
> > +`patman documentation <https://deinde.dev/patman>`_.
>
> So this URL seems weird, and it redirects to
> https://patman.readthedocs.io/en/latest/
>
> If I search for patch-manager on pypi.org the project goes to
> https://github.com/nxtboot/patman
>
> May I suggest that deinde.dev and nxtboot and patman and patch-manager
> as different names all feel disconnected, maybe some consistency
> around patman for the URLs, even if the github project is nxtboot, may
> provide less confusion for the users.

Yes I agree and I would like to, but it's a matter of what is available:

- patman is used for something else on pypi
- nextboot and deinde are taken on github

I didn't cconsider using patch-manager as the github name, but that
seems wrong because everyone thinks of it as 'patman'. It is somewhat
of a mess, but I'm open to suggestions.

[..]

Regards,
Simon
