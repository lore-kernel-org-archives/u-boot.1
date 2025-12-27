Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D068E8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0EBE83C04;
	Sat, 27 Dec 2025 15:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C6czUN/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F01083C0E; Sat, 27 Dec 2025 15:58:24 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6142483BFE
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so9149742a12.2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766847502; x=1767452302; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IFQa+UmbjV9CR0aCpLUdU9gLZQjoy1MNDcpM7jCuZLE=;
 b=C6czUN/4Olmw0QXwEUJO08sKQxB5mJYK9oA/4vZnFzoeZMJ6IsRIj/8nvqXtpkyxfo
 JRHd1baRchJpP86Ek+/ic/OSje4imk7U/nCsJzJbodM/RTVdr2HPaej/EwwEUwTjWgsb
 UTKPKvAOYDg8RrNBcxxQCPFqFJtdpnxHCpJVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766847502; x=1767452302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFQa+UmbjV9CR0aCpLUdU9gLZQjoy1MNDcpM7jCuZLE=;
 b=IEoK2f+gk3lirh4U8YrFnF6dBT1EW8Xy+ipixxDlDWeFLjH8LAj2FHuZzYbW/SgHvE
 BPOHlnEvRgNiE1fx3Dj+0MFC/Saz15b/X1/X/nvBlZslPTZtQts2qoj52gxcp3YTTNaN
 6fs5FK1s8bhReU4LvBPqMTgfXdYIosGtVOx6w4KobgKILywO6slaJ9YKVAPF9tE7wTON
 ljUzzksoCDKTdny91EkRD1mDixcra0+euPN8C4oQFRaeLaDbLwQ3cOqepMIM5f8YD0tt
 imPmDZxootJonGA71v4kN5u6pS4PIMWW+EWkis8JCAqPMoO04BQLkRDy1VAyXmtW3BaD
 ip0w==
X-Gm-Message-State: AOJu0YwKHSsvkCeuOZBbEzz+Bj9TfdLfoJKBsCoqARP/LqAmnyY0PmnE
 dapnTpAw53299aZdSJfIVBqDV2JuEHapg2mKIR/lIB1RkFVI320aAnIP16KWxIZZMvFkte3Xcaf
 xAui2kHSmrbVe+PNGct6G7VNha60KMDfU/nY/VLc4
X-Gm-Gg: AY/fxX5oSZe1sYIBodlBp02HjELHZW7hxybI74WVgkC6jHk037soKD2lnL3aeW+vGwL
 UUEN5yL0p69BUQ3BtviJI/jFzj3FfRoBYC+jtjgfq57f5EF2lzsEoKMIWEuFm3UtNQ8qKu55PpQ
 F+kkBpJkewLx1i2pO2AILF1GApxhOL/WkD7jnjEPC03hJDMu6h/t0MN47elj3QD1xT0bQbBl4Nk
 M+uiQR3p3KVgtgnlG5JDPv4uK56og7dfHKyIKHaq+s2jbRaitT82ursYb8MJzWxjg/8tg==
X-Google-Smtp-Source: AGHT+IHs/0qmiDtiy6DULzKAeX9stZGYtAIsyoX3crPVaK8u0zleO0jiUgLU2b5BoDpOOKD4I6QwtvO8pY/yyUx2FtA=
X-Received: by 2002:a17:907:94c9:b0:b70:7cd8:9098 with SMTP id
 a640c23a62f3a-b8037288a09mr2692136666b.61.1766847501832; Sat, 27 Dec 2025
 06:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20251201194857.2371332-1-simon.glass@canonical.com>
 <CAFLszTiS_hQbKnguY=ykyNOKk_hsMzBOAZAnOPjn7U49eunuFw@mail.gmail.com>
 <20251227144800.GJ710860@bill-the-cat>
In-Reply-To: <20251227144800.GJ710860@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:58:10 -0700
X-Gm-Features: AQt7F2qPQBe-cZCr1KNRj6aHk2yBreqXBCDej0usMkXpQbSbV_GrKnY4rnp6eVM
Message-ID: <CAFLszTib_BXUxdfkNTey0_r+RV9bKLwv6mqMd8P-ab-YevoWLA@mail.gmail.com>
Subject: Re: [PATCH] dm: core: Create ofnode stubs when OF_REAL is disabled
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>, 
 Claude <noreply@anthropic.com>, Anurag Dutta <a-dutta@ti.com>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Pavel Herrmann <morpheus.ibis@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
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

On Sat, 27 Dec 2025 at 07:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Dec 27, 2025 at 04:44:07AM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Mon, 1 Dec 2025 at 12:49, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > When there is no device tree there is not point in trying to find nodes,
> > > etc. since they will all be null.
> > >
> > > Add static inlines to skip the code in that case.
> > >
> > > Unfortunately this makes the file a little convoluted and there are
> > > two inlines for ofnode_is_enabled() and ofnode_first/next_subnode(). But
> > > it seems better than the alternative.
> > >
> > > We could also consider splitting up the header file.
> > >
> > > Also add a rule in drivers/Makefile to compile ofnode.o when OF_REAL is
> > > enabled but DM is not (for kontron-sl-mx6ul) and move the
> > > ofnode_for_each_compatible_node/prop() macros outside the OF_REAL
> > > condition, since they only use functions that have stubs.
> > >
> > > Co-developed-by: Claude <noreply@anthropic.com>
> > > Signed-off-by: Simon Glass <simon.glass@canonical.com>
> > > ---
> > >
> > >  drivers/Makefile      |   4 +
> > >  drivers/core/Makefile |   3 +-
> > >  include/dm/ofnode.h   | 714 +++++++++++++++++++++++++++++++++++++-----
> > >  3 files changed, 641 insertions(+), 80 deletions(-)
> >
> > Any thoughts on this patch, please?
>
> I'm not sure what you're expecting for AI-developed patches after we
> talked on the community call about not doing that.

I haven't been able to join recently but should be able to join the
one in a few weeks. Which meeting was it?

>
> That absolute briefest review I can give is that it didn't solve the
> problem either, and so you didn't test it correctly.
>
> I was just planning to ignore this, rather than get in to another long
> thread with you that I suspect few people would read.

The problem solved is in the commit message. Is that the problem you
are referring to, or is there another one? We can discuss it in the
next call if you prefer.

>
> --
> Tom

Regards,
Simon
