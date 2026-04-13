Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F670F34C52
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3698A8421E;
	Mon, 13 Apr 2026 15:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pw1+UqAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7A9F84228; Mon, 13 Apr 2026 15:36:24 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDDD84227
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2b23fcf90b2so42032045ad.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:36:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776087381; cv=none;
 d=google.com; s=arc-20240605;
 b=AdEr5qu1bvL4JehnN+bzC1yHb+vIzaV1MfyV6VlZczBIaQSIu43Ksb5EA4gXbvBj/j
 5VPwgVw1ZsBkWFcwnd+3H1dIL/jwVqk/zBmkUcGNFLWteRfzjATd7h9Yd/YEIZjehY0K
 AjP9SkXNxHycwyeWOu0D4+HM4bZE6RPqqeYgKDAFPhsDZKTotj/Fj1CoJ8et6s4qy8/1
 qkyH4chGE+V0M453lQxddtQof7v+cpZib8xJahpACQ2A6ACGYAp3n4UjJ+QokmI8uPwW
 EJQTzr+n2YAQiTOZqv1HtRy/KtMGvGqmlhJ60cbaI5dwf81zYHOVK4/aVolVTL8w1Kqs
 8EJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AstAAIrtTuTQyzB/WWpdd6+BYmSn1FgD06bj796vcro=;
 fh=/TVO6FbF4O18NfbcdZKcO54HkyGWIpFzJvmjXOOBnv0=;
 b=iLtSAg+Ko4zRyeriBDnkfyb0Ok03+uTnBrWLccdTqWwLW6wvh+fVowjpSAOpCjjhp0
 Opws7TruH7Dybm+bjW+H4hPKHAYQQkuzBp+gjujaerCR52LOaABFDIApIUMyzuqjyO6u
 +SKCUYx00HHi9RfogioKTRfypMEPexhBZubsveZ61btnETkU2lhAWM2rSBTS3MCLeryh
 9T1z+4XOxkg2QZi+8JTOc0jtiLXWLPH3jGu+5TQFiQd5yLt8MrG3zqpiDvGjsPBRkTN1
 tomUUvPL8QXOFk7i7hvKO1dLtiARILRwR3wZoG1Gjv9nTs5cDT/ojTK+lRgAFi+Vx4+R
 MQOw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776087381; x=1776692181; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AstAAIrtTuTQyzB/WWpdd6+BYmSn1FgD06bj796vcro=;
 b=Pw1+UqATmyVRxRh+HvFd4vrnMjNEXG1PngqiHi89E3QC3n1tBBD9lY9z385efzXX8+
 XX5RAq7/iEEBUQIxEuUZrxcXwKn3lNVepVYzkjBgqIu6juxH6VhK/cWpw6ggUJy9+8Ol
 wgmAsMQ4wuVhKJswPCjYPnIxgGLBsrEZPzrfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087381; x=1776692181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AstAAIrtTuTQyzB/WWpdd6+BYmSn1FgD06bj796vcro=;
 b=RZlIM54eiY/p2Q9v+333GzGvh9PKzsAZveihGA/YCeYkYM3pJerqHInmBgDqskc3Mn
 HWJT6tlD1bQNXWnTvCNsoaBfJIXZPK0o6LATMVljEooyHZ7kFCVmLnA4NosnQhjgJZSt
 sScR/TAuUwW88TrD48nkhaU8GfMw/87Pg/suBdR91ZovkokEmVxrvX5FBN78nOHTPibC
 AgiHlpKAQRl/mxIMRruk9+VH0FE3Ra8+Sj7OZE29p+/0EFvtirNyTRB1gUVXi3d0Z9+g
 Nw70XTLmIditetT2oJAjIyuap6TA55bVAu8uRpJl1Ufo0ggiJQxpfXx1xMC3GFRyOdUI
 ESog==
X-Gm-Message-State: AOJu0YysH6kX4sAFxHR5tGcfW1dSwhIyqqFQ0I32xuqSv+i4bBL2OsKH
 iNq95JK1plRRrdTTupZJtePVMQDpQ6JcRt7GeplOvzUA80n1hMQqiQ6QXv/+aAo7QZXQiMN1aI3
 1CUTlePx2Ziq1ilbII2w0EbS6iIEUYZ98jOLZQF3n
X-Gm-Gg: AeBDieu8eSeIuz3WwsQiOtrrAYeYHGNG/d3fEWzeN7Dr1KcURUQ8q0cNIVyzQu1AtkX
 X9JAzSjj30bv1p5Nr3zC6dj0owtDQCgIxBVb7xobkF4AwXe7Ep7MXXJVLedSbzggAU24g1Xp81O
 P3XsFHy9CvP2yP1QlvCEDwlxm1quL3DXBguhL9kMBs2HdOtOmIFPz9VCEzWuV7gA7xiX08JWm9H
 3SPWB0isL9Xv1xVmvYDSvHI5t5eiljLfIHz+WZ9aalJo1zXmpkMANaWLqKQlr5RbzzU5XLZHGYO
 o3k2bA==
X-Received: by 2002:a17:902:bf04:b0:2b0:66f7:f7cb with SMTP id
 d9443c01a7336-2b2d5939474mr93470255ad.7.1776087380973; Mon, 13 Apr 2026
 06:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260407063453.18679-1-gregor.herburger@linutronix.de>
 <20260407063453.18679-2-gregor.herburger@linutronix.de>
 <CAFLszTgOx73JFqH9+ES4w6oVP=DeM81QJFqQP9dR4_g4eOm15w@mail.gmail.com>
 <adyKucgpN0v4ddhA@gregor-framework>
In-Reply-To: <adyKucgpN0v4ddhA@gregor-framework>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 07:35:39 -0600
X-Gm-Features: AQROBzAs53n-zSGwj1SqoBvZ5Pv79Z3eyK6NmnWwXz1ktXtChYHAouavKNyXIEM
Message-ID: <CAFLszTgJ3y_B2qGGNp5Kd-LqF-fCJAwWAhBCCOFRo9iMbLtd2g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cli: flush stdin before enabling cli
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
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

Hi Gregor,

On Mon, 13 Apr 2026 at 00:18, Gregor Herburger
<gregor.herburger@linutronix.de> wrote:
>
> Hi Simon,
>
> On Sat, Apr 11, 2026 at 10:41:00AM -0600, Simon Glass wrote:
> > Hi Gregor,
> >
> > On 2026-04-07T06:33:10, Gregor Herburger <gregor.herburger@linutronix.de> wrote:
> > > cli: flush stdin before enabling cli
> > >
> > > Currently there is no possibility to flush stdin after autocommands are
> > > executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
> > > serial, it could happen that junk characters sit in the fifo and appear
> > > on the cli.
> > >
> > > Add a option to clear stdin before starting the CLI.
> > >
> > > Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> > >
> > > cmd/Kconfig  | 8 ++++++++
> > >  common/cli.c | 4 ++++
> > >  2 files changed, 12 insertions(+)
> >
> > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > @@ -47,6 +47,14 @@ config HUSH_SELECTABLE
> > > +config CMDLINE_FLUSH_STDIN
> > > +     bool "Enable flushing input before starting cli"
> > > +         When this option is enabled the stdin buffer will be flushed before
> > > +         starting the CLI. This is useful when stdin is changed during boot
> > > +         (e.g. from nulldev to serial) and junk characters may be pending
> > > +         in the buffer.
> >
> > Thanks for expanding the help text!
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
>
> I just realized I didn't collected the Reviewed-by Tags from v2. Should
> I send a v4 with these or does a maintainer add them?

For a particular version, patchwork collects the tags in its database
and maintainers apply patches from there so the tags are colletced.

If you send a new version you must add the tags yourself (patman can
do this automatically).

So in this case, yes, you should send a new version with any tags that
were missed when you sent v3.

Regards,
Simon
