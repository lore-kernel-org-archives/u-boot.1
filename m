Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77024C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 13:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02FBA803DF;
	Wed,  4 Jun 2025 15:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JLJobFLJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E7F807B1; Wed,  4 Jun 2025 15:10:37 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05DEC801BE
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 15:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6049431b409so11968474a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1749042634; x=1749647434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jBlZWQGlQTyt2ig6llCCCUgn2xJ9vBWcJReOFdOFq4U=;
 b=JLJobFLJ8gD3U1VSqVlZhNi9gHHwxVBZxtHg0cmfkbwuTe0YmNPcjLjJURDMdgVHv2
 2kkz3f1LVaZRj1OmxDzGw1gHlewYFXwvf5lac2a2QhnHaWNYu8hTDzmrn1YSBYrCT823
 RhNH4Pv9XvCxN4Y8ZTfnl6xIue5WsWw1v2nrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749042634; x=1749647434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jBlZWQGlQTyt2ig6llCCCUgn2xJ9vBWcJReOFdOFq4U=;
 b=qlSRdnL8v1CrZSgncoDRwqL6RzHSk2HJsK5spT1bWB1aglrwDvuZjacQP5pQMTczCW
 YZu2b0ioclaR9fgFEzT6RkAFf18XXZwX257e5d9oskXRtICL40wdbKsK3c6ep6PhgVQx
 KeApILH0mN0eCGHFeO/900mpvtu+YZAERer6eL85/zoLXqO6bhJ0A9zjYuQGKUVL7ZRc
 ZUrPgNaKpKpq21iwgRVaJ7oV0MSoSxHQQRl8E6a7uCqj4UvPLnqW3RyWQUCqxPoWaAEQ
 djWpR4SkQoebMWGOSsOtkrHGIqdWEOc5avYn5zbmgmv+ZWW1Tn4uPlBI99IjaiOALJtA
 zwCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUndI6JqRyz3i0E1fy+r6QGjSstdDjopoBI/V+CN68+Yu/C9Eg3dpX+aMvFqCEJerYJr/QoKQc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8sT66+/I9Y+Z1TkffZ59oW8ReOpu2oWTPRONYlP8j0sbFuuDQ
 dlNXARGxsdVbxd/YeW6Hxx73BU4tOvXjM86AAFAdZ0MMitGP+SKpzwASudi1qybXNPY4XBt/HWj
 qaVAuvya6HVTkbeVn/DLU4yVvfrX5k/rx41lCG5tJ
X-Gm-Gg: ASbGnct5nwsCxTwzsF7bDRyryqYA8qvjfu948ntr52a6LilOpa1S4a52chGX3vALdII
 PzFOTZ1qiqsXSOpAVWQtKvRvklekFunDJ1Pn+9fH0W31U3DXudr32p6ObAVHRILLxMboTrKkruu
 7JJN7iKlC8giIXXbuSh0VNEvXD250zlu348A==
X-Google-Smtp-Source: AGHT+IHz+LsKfzrMeY6Mf5nzD/Nl7PkvzC6xuAAkNVE2Un8zD98ktT3A9k3nh5eZnSrNVDoNPbslG3vlNrk+/7FzaJY=
X-Received: by 2002:a05:6402:524f:b0:602:3e3:dada with SMTP id
 4fb4d7f45d1cf-606ea191585mr2984965a12.25.1749042634494; Wed, 04 Jun 2025
 06:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <20250404135038.2134570-3-jerome.forissier@linaro.org>
 <CAFLszThkuPyy+Z3gt1oo7ZDPo+60tzdqwevSD2HjA7KjLeNcQw@mail.gmail.com>
 <20250603161014.GI1382132@bill-the-cat>
In-Reply-To: <20250603161014.GI1382132@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Jun 2025 07:10:19 -0600
X-Gm-Features: AX0GCFvfVExVgAiEYoFvwpge2hVkSCWwi_M4VbroNVyBBFC9msPTL99hOgpHnzg
Message-ID: <CAFLszTih+F4zr-nL+9qmSKnNbCH902MFx3F27HrW3Kj22Re8Jw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] common: board: make initcalls static
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Michal Simek <michal.simek@amd.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
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

On Tue, 3 Jun 2025 at 10:10, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 03, 2025 at 09:22:01AM -0600, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Fri, 4 Apr 2025 at 07:50, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > Change board_init_f(), board_init_f_r() and board_init_r() to make
> > > static calls instead of iterating over the init_sequence_f,
> > > init_sequence_f_r and init_sequence_r arrays, respectively. This makes
> > > the code a simpler (and even more so when initcall_run_list() is
> > > later removed) and it reduces the binary size as well. Tested with
> > > xilinx_zynqmp_kria_defconfig; bloat-o-meter results:
> > >
> > > - With LTO
> > > add/remove: 106/196 grow/shrink: 10/28 up/down: 31548/-33829 (-2281)
> > > Total: Before=1070471, After=1068190, chg -0.21%
> > > - Without LTO
> > > add/remove: 0/54 grow/shrink: 3/0 up/down: 2322/-2832 (-510)
> > > Total: Before=1121723, After=1121213, chg -0.05%
> > >
> > > Execution time does not change in a noticeable way.
> > >
> > > Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > ---
> > >  arch/sh/lib/board.c         |   9 +-
> > >  common/board_f.c            | 223 ++++++++++++++++----------------
> > >  common/board_r.c            | 247 ++++++++++++++++++------------------
> > >  include/initcall.h          |  27 ++++
> > >  test/py/tests/test_trace.py |   8 +-
> > >  5 files changed, 273 insertions(+), 241 deletions(-)
> > >
> > [..]
> > > diff --git a/common/board_f.c b/common/board_f.c
> > > index baf98fb8ec8..a1bb8a01be5 100644
> > > --- a/common/board_f.c
> > > +++ b/common/board_f.c
> > [..]
> > > @@ -1049,8 +1056,8 @@ void board_init_f(ulong boot_flags)
> > >  /*
> > >   * For now this code is only used on x86.
> > >   *
> > > - * init_sequence_f_r is the list of init functions which are run when
> > > - * U-Boot is executing from Flash with a semi-limited 'C' environment.
> > > + * Run init functions which are run when U-Boot is executing from Flash with a
> > > + * semi-limited 'C' environment.
> > >   * The following limitations must be considered when implementing an
> > >   * '_f_r' function:
> > >   *  - 'static' variables are read-only
> > > @@ -1063,18 +1070,16 @@ void board_init_f(ulong boot_flags)
> > >   * NOTE: At present only x86 uses this route, but it is intended that
> > >   * all archs will move to this when generic relocation is implemented.
> > >   */
> > > -static const init_fnc_t init_sequence_f_r[] = {
> > > -#if !CONFIG_IS_ENABLED(X86_64)
> > > -       init_cache_f_r,
> > > +static void initcall_run_f_r(void)
> > > +{
> > > +#if CONFIG_IS_ENABLED(X86_64)
> >
> > This is reversing the condition, which breaks link and coral in my lab.
> >
> > > +       INITCALL(init_cache_f_r);
>
> The most helpful thing to do here would be to post a patch correcting
> the logic and providing a Fixes tag, thanks.

Sure I can do that. I also seems that quite a few #if macros could
change to if().

Regards,
Simon
