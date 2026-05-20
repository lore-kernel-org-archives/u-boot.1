Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A15CD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A2A8467A;
	Wed, 20 May 2026 22:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xu5559R1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 262A7846B0; Wed, 20 May 2026 22:41:03 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5F5D841D7
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so12453087a12.2
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309660; cv=none;
 d=google.com; s=arc-20240605;
 b=g4hqAuU1Z/0WnuOlbX7Wx+THRhxFbdrej1YsUTrSVTzADDQ6TNuJZTGpaFOvjmcmUM
 rsWlaY0kV6yUVvJ9XCGnhCl+o4YVH2lXA5Xdp4tNkYsvkKtqKsSdIYH9zQXJNJjAJMZo
 kb3Snt6p5pJNAM+p12BoNdcpakbuVCYjpKBPy141eMLTF8TgNfG3EgCkDPjgY/8/qk9B
 47XUbSSIblQERbbpC2PjNwgbS2R89O1YMdclN37N9n9IW/4Tm5AVlzVbiVeQ6b14f7HX
 h3FIcW+noJCFzVMW8L+ONy41a052DCnJOI/iw5tiBTnfGEvpZf2Wpp/uBhCEYQCMHxp3
 3PeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3G3Pl2cOojZuTfYCGVvjLEeM0CVZyPKIVLh0uk4ipag=;
 fh=vdt6hR9vwojRx8rZuMcmxzh3E6ndsJiDYmPOtroF+OA=;
 b=OwZtAARfl7mYa1e5c7OnrcrkH8WBy1OsOEGj33SEZkZIxX0C28UIn8i8H+mecuvzVA
 ujlNXHSRZfZaOW5kTiYvMYLfbPoIwVQoFI6HZGos4LkUa7ftM80IWsoxuEdkcQpsS55k
 RPNVTf2ZvYhaFLuyP2v++gEdkM8/3EGDTY48FbZhsS3E65jhtVtZdb4afWGIfUqNygkO
 tLnM29EhMlwKKzBrZtXHRRMdqws6XkLARNC+GLQux3PLho+MvJpQePeYyhWa5ES3glVX
 BUTbMP1nP4tupti7V7J4xXRw0cwGelE+lF893x1Xu4uIPhWiBxfS6bRDzwgTJcKvbhxo
 cljw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779309660; x=1779914460; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3G3Pl2cOojZuTfYCGVvjLEeM0CVZyPKIVLh0uk4ipag=;
 b=Xu5559R1sHxWd+H3/TMqcho2vnenvG1HfhBPq3+NqRj0IWlA3RsLqI2KPDxdNNdv9q
 TFGAHdRTmnmKrIl9FBVI+smSzR0J/OosPF9LCc3l1stN+qZhz7RS1AQbz3KTQDHqVC6R
 UqW7jDulcf057tk/o/N6V0zUbOuppY8HbTzCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779309660; x=1779914460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3G3Pl2cOojZuTfYCGVvjLEeM0CVZyPKIVLh0uk4ipag=;
 b=E1vvlPH2vqAPVGEOKAGq+Guoe6U0CaAABEB57Tqxgb1yAwMTUsqLyT5S1yxYREsO4K
 HzX/0sS583A1i73XC3D1iuWav8GFj+02n//ANM4dUQaU++k87zaPNLoSwT9Ww6gkMir/
 XR9Ooi2XGw99iYRwp07V61+vXTXwJX+dqUbrw2MZxcarhFqhLrgjKT6TSbSC1I/f+lbM
 A7qHNbLw3Oxf5CDnlUFtWH06/3aZL/fMFVlN2k4u5C69QAjTN4mqmuHi+Z8wuniNXPZN
 5oTBjqhOTNsemYAjoY6qDSppUPDR4OqKi+1EAppCGTIeFFGeS5tG3zB42VZrCGBm8EeK
 XSbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8o/IQ1IdkmcdoXCGA0SA0cZBuQ9Q8Gn0RhCnxKQxr+c8/hN7ivD8vI43QQjgLWmQ6qIaoWMVU=@lists.denx.de
X-Gm-Message-State: AOJu0YwdBF4ExL1DgJ/MFb2PLqVwu1XQvGts1L06/YIgHjubJILOPSEj
 KPLXjHtmIpGn/wB4e/9uOR363M0aCLMt6dtoE1Xm/d5MjmY6xQE5cTo2z+CUaImkGGn32MBcWo7
 +qEoHr2/OM952Wo0u8o0JhrDXel8YH0LSCmgQQ0FkKyUkDqX/B33lGAX1
X-Gm-Gg: Acq92OELy6WQgfi6akX0oUgSPfz8wnRMVscAwJZgQ4c5PcQxR9m+FBTo5eZ2hyQ0w8P
 3zoxbQMphdzOypNKQ2nZ+wD1eIYCXYyueB59FazICMkEJiQD/eG3Jos23iDfIuLmy6z+uZ4GMcz
 KAECpjZqdO/1YvhMqXopn1cp/R5jTpBOugyVcDiNX1G9vU774mtsWB4ofdAx6r6j9LPgEUB+gUo
 o2YjyvnT6UbRq1CfArkdAC9SoykZPfHcOCk405x3EMLdSM5zIwJ9BXc/ZpvqgrC+1WF+GqvRSg8
 ycaVTQ==
X-Received: by 2002:a17:907:2d12:b0:bda:f3ec:92de with SMTP id
 a640c23a62f3a-bdaf3ed0845mr225624866b.17.1779309660347; Wed, 20 May 2026
 13:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515214305.GL1858239@bill-the-cat>
 <15041974-8838-56b6-b9d5-250383ed2625@gmail.com>
 <aa023095-2b32-070f-ff43-1f6922918b51@gmail.com>
 <20260515222107.GN1858239@bill-the-cat>
 <936f6df3-2bb9-f99a-45f1-4dcfa915f2c0@gmail.com>
In-Reply-To: <936f6df3-2bb9-f99a-45f1-4dcfa915f2c0@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:40:47 -0500
X-Gm-Features: AVHnY4IYJUYqVSTr-hsE0QcPVDOLdj_KimoO9Aw8uu2wJczF-N2eNomSil3svK4
Message-ID: <CAFLszTiSxcKyD1MWP+2p2zBbDzLoC5Z=wnxVNHO31DGQHCrLcA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Tidy command option parsing and use it a bit
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit.thebaudeau@advansee.com>, 
 Casey Connolly <casey.connolly@linaro.org>, Daniel Palmer <daniel@thingy.jp>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
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

Hi,

On Fri, 15 May 2026 at 16:27, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 5/15/26 18:21, Tom Rini wrote:
> > On Fri, May 15, 2026 at 06:06:38PM -0400, Sean Anderson wrote:
> >> On 5/15/26 17:59, Sean Anderson wrote:
> >>> On 5/15/26 17:43, Tom Rini wrote:
> >>>> On Fri, May 15, 2026 at 02:32:51PM -0600, Simon Glass wrote:
> >>>>
> >>>>> We have had getopt() for over five years but it is not much used. It is
> >>>>> much easier to understand arg-parsing using getopt() and it avoids
> >>>>> common errors. As the named maintainer I decided to look at how to make
> >>>>> more use of it.
> >>>>>
> >>>>> So this series explores the impact of converting a few commands to use
> >>>>> getopt() instead of ad-hoc parsing. It updates getopt() to handle flags
> >>>>> anywhere in the cmdline and provides a few helpers to reduce
> >>>>> boilerplate.
> >>>>>
> >>>>> The chosen commands are:
> >>>>>
> >>>>> - echo: very simple with no flags
> >>>>> - hash: fairly simple with just one flag
> >>>>> - env grep/export/import - fuller examples
> >>>>>
> >>>>> The series also adds a recommendation to use getopt() for new commands.
> >>>>>
> >>>>> To try to reduce the code-size increase, a lower-case function is added
> >>>>> and called from a few places. The difference is fairly marginal.
> >>>>>
> >>>>> Overall, the result is not pretty (see below) with about a 1.1K size
> >>>>> increase on arm64:
> >>>>
> >>>> I think that means this is a no-go, and you need to work out what might
> >>>> lead to a much smaller growth here.
> >>>>
> >>>
> >>> Unfortunately, the only way to get a size reduction is to convert as many
> >>> commands as possible.
> >>>
> >>> --Sean
> >>
> >> And to expand on this, you really only get a reduction for any given command
> >> when there are several options being parsed already like in the nvedit stuff.
> >> Since most U-Boot commands don't use options it will be difficult to get a
> >> reduction even when converting most commands on a board.
> >
> > We don't even see a reduction on "qcom" which is a platform that already
> > enabled GETOPT. nvedit is growth too:
> > 01: Prepare v2026.07-rc2
> > 02: lib: string: Add strlower()
> >     aarch64: (for 1/1 boards) data -40.0 rodata +40.0
> >              qcom           : data -40 rodata +40
> > 03: cmd: ini: Use strlower() to normalise case
> > 04: fs: fat: Use strlower() to normalise case
> > 05: boot: pxe_utils: Use strlower() in get_string()
> > 06: lib: getopt: Permute by default with inline reorder
> >     aarch64: (for 1/1 boards) all -6.0 data -24.0 rodata +18.0
> >              qcom           : all -6 data -24 rodata +18
> >                 u-boot: add: 0/0, grow: 5/-1 bytes: 272/-8 (264)
> >                   function                                   old     new   delta
> >                   __getopt                                   576     756    +180
> >                   getopt_init_state                           12      88     +76
> >                   do_log_filter_remove                       364     372      +8
> >                   do_log_filter_list                         444     448      +4
> >                   do_log_filter_add                          580     584      +4
> >                   do_bdinfo                                  160     152      -8
>
> I expected this to grow due to reordering
>
> > 07: lib: getopt: Add getopt_pop() helper
> > 08: cmd: echo: Use getopt() with '+' prefix for option parsing
> >     aarch64: (for 1/1 boards) all +3.0 rodata +3.0
> >              qcom           : all +3 rodata +3
> >                 u-boot: add: 0/0, grow: 1/0 bytes: 68/0 (68)
> >                   function                                   old     new   delta
> >                   do_echo                                    156     224     +68
> > 09: cmd: hash: Use getopt() for option parsing
> > 10: cmd: nvedit: Use getopt() in env grep
> > 11: cmd: nvedit: Use getopt() in env export and env import
> >     aarch64: (for 1/1 boards) all -4.0 data -16.0 rodata +12.0
> >              qcom           : all -4 data -16 rodata +12
> >                 u-boot: add: 0/0, grow: 2/0 bytes: 164/0 (164)
> >                   function                                   old     new   delta
> >                   do_env_import                              692     832    +140
> >                   do_env_export                              608     632     +24
>
> But I thought the nvedit stuff would result in a size reduction. There are 4-5 options
> for each command, so the env stuff is basically a best-case scenario. Maybe we
> need to revisit the getopt interface.

It isn't really best-case as there is other logic- I would say
somewhere in the middle.

Re the interface, what are you thinkg?

>
> > 12: doc: commands: Recommend getopt() for option parsing
> >
> >> That's why I used it for new commands where no one could complain that
> >> I grew their board.
> >>
> >> I think it would be nice for all u-boot commands to have proper option support
> >> like in barebox, but it's a lot of effort.
> >
> > Yes, it would be good to move in that direction. But we need to figure
> > out how to do it in such a way that's not such a big size loss. If we
> > have to do a big conversion to start with, fine. If we have to
> > restructure a few other things, fine. But "convert echo so everyone
> > links it now and it's sunk-cost" isn't the right path.
>

IMO we should move to getopt, for the reasons I mentioned. But in
order to do that we need to swallow a 1K size increase on arm64 (a
little less with my v2 RFC.

If we can get over that hump I believe we can set a standard that
converting a cmd to getopt should not increase the size...I actually
believe that is mostly achieveable, so long as we are OK to introduce
various helpers to simplify arg access in the command code
(getopt_pop() and more).

There may be opportuntiies to reduce the size - some I have already
mentioned. But unless we can swallow the ~1K, this is a non-starter
(and in fact we may as well remove getopt()).

Regards,
Simon
