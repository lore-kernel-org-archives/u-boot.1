Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5324DCF58E3
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:29:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EE689428;
	Fri, 20 Sep 2024 09:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YISf6Pyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B13A8941F; Fri, 20 Sep 2024 09:26:07 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D84E89417
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a99e4417c3so150388585a.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817164; x=1727421964; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=izLGl4yjNvVBGLtntlHMxQ7id9KGy3CQuAnRHdq/hu4=;
 b=YISf6PydWP0cU83xQzxYFj/QdNR360bsKnIO46Q0yb/8GFos6262WI1uvvT2L7xHKU
 UqJH/wVVVqbojlG3KDjW98fDTLUKhtlWPyQWWU0hYkKc0nV1PX6IumEl7ZT8UxLoPdDF
 Xfkz+pOlfNm4NwKXBIVmQNJeVBE0ysPNxQZIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817164; x=1727421964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=izLGl4yjNvVBGLtntlHMxQ7id9KGy3CQuAnRHdq/hu4=;
 b=IqrkJn9FVOeZrU+ASu0SYE05iNbFBNVA086MXcigJejMW4o8hY2hBcs5HL7wApCHYN
 MzEFE+ABKIld64ebOlOdYYllu+KU92jjEBVdTmvByFSZ/Sncgzo3oG2tAPKk6qLJdbOO
 0O0IVwmBWpNzsOiS6yTjzWFusR5m/W1jlqkFG/gvs0C9Wxu4MsK+9r/PWq10Q8UPBGQd
 1Qo5yrUiMolQec/y5gnXd0kJgav7bafsDim0/dzOHpJpWerJQhtaIyOr3mbSILlSa4PU
 aoNnFdidB19G3U/ZcBQk3HIjehBoAgKx81fuxzyFmIGguclT597EZcz/g8P99txjLUNM
 Pykg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW/2fw3iYmSE16FzfAA4HOFo1gYrZxe+cgOnHViAVZu5tc6oU9VL9l55wmPuVykni7H6gCOLw=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ0Of0e/tuFbAviYFaz6TRTLbvd80kM3PrwwMyX7ANZrV0jCmb
 gOWdsRlhNFZD/HzQXaIQ9c/jbxTC8ezuv7mmOpWDiDutseeAX9AVp0uXqJaWn6HHGqncjbQ2Kpp
 wh69fKej+oyfQik5sYsbJMYd0oerVYbRBTTib
X-Google-Smtp-Source: AGHT+IHXcW549lRJxXtmrMlgphujwUHbMNlAavbeusugx2MQAfel2gB76OXV+n8KSg0vM2H9+om1ceVkRDiuDoQxrrg=
X-Received: by 2002:a05:6214:4186:b0:6c3:6556:70a4 with SMTP id
 6a1803df08f44-6c7bc7a29c9mr23236016d6.50.1726817164221; Fri, 20 Sep 2024
 00:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240828014538.3322013-1-sjg@chromium.org>
 <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
 <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
 <20240830004936.GP2479150@bill-the-cat>
 <CAFLszTjjni839jghOpforB-4+MnqRh7JXw575VtP_UO-SzfnKg@mail.gmail.com>
 <20240830014622.GQ2479150@bill-the-cat>
In-Reply-To: <20240830014622.GQ2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 09:25:53 +0200
Message-ID: <CAFLszThE7mrnOyGCzPcC01soCvoT++SgvUp4WpHiJZH4CXhWQw@mail.gmail.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Apurva Nandan <a-nandan@ti.com>,
 Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 huang lin <hl@rock-chips.com>
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

On Fri, 30 Aug 2024 at 03:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 07:06:32PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 29 Aug 2024 at 18:49, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Aug 28, 2024 at 04:16:55PM -0600, Simon Glass wrote:
> > > > Hi Peter,
> > > >
> > > > On Wed, 28 Aug 2024 at 03:59, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > > This includes various patches towards implementing the VBE abrec
> > > > >
> > > > > What is abrec?
> > > >
> > > > It's a VBE method which supports A, B and recovery images and permits
> > > > updating from SPL onwards. The idea is that you can safely update
> > > > without bricking a device.
> > > >
> > > > >
> > > > > > bootmeth in U-Boot.
> > > > > >
> > > > > >
> > > > > > Simon Glass (18):
> > > > > >   sandbox: Add missing header file
> > > > > >   bootstd: Add stub for bootdev_setup_for_sibling_blk()
> > > > > >   gzip: Correct function comment for gunzip()
> > > > >
> > > > > Is this from upstream gzip code somewher?
> > > >
> > > > I'm not sure, actually.
> > > >
> > > > >
> > > > > >   fdtdec: Support separate BSS for all XPL builds
> > > >
> > > > Needed so that VPL can use DDT
> > > >
> > > > > >   tiny-printf: Correct return values
> > > >
> > > > I can't remember, sorry.
> > > >
> > > > > >   tpl: Support numbered aliases in device tree
> > > >
> > > > The MMC needs to be accessed using its sequence number
> > > >
> > > > > >   ram: Support driver model in TPL
> > > >
> > > > That should say VPL...but again I'm not quite sure
> > > >
> > > > > >   serial: Support debug UART in TPL
> > > >
> > > > This allows debugging of the jump from TPL to VPL
> > > >
> > > > > >   armv8: Support not having separate BSS
> > > >
> > > > VPL doesn't want a separate BSS since SDRAM isn't available that early
> > > >
> > > > > >   arm: cache: Drop a stale comment
> > > >
> > > > Just something I noticed
> > > >
> > > > > >   arm: Fix up a stale comment in sections.c
> > > >
> > > > Another thing I noticed
> > > >
> > > > > >   mmc: Support driver model in TPL
> > > >
> > > > TPL needs to read VPL from MMC
> > > >
> > > > > >   mmc: Add more debugging for SPL
> > > > > >   mmc: Log the error when init fails
> > > > > >   mmc: rockchip: Log some error returns
> > > > > >   mmc: rockchip: Allow clocks to be missing
> > > >
> > > > These all help with debugging reading of VPL from the correct MMC device
> > > >
> > > > > >   rockchip: mmc: Fix a missing colon
> > > >
> > > > Just something I noticed
> > > >
> > > > > >   rockchip: Provided SPL control over efuse presence
> > > >
> > > > We don't want this driver in TPL or VPL
> > > >
> > > > >
> > > > > I'm not sure what most of these patches have to do with VBE?
> > > >
> > > > Basically there are a lot of little tweaks needed.
> > >
> > > Well, I think this gets back to some common feedback. You have a lot of
> > > little bugfixes, which is good, but they get sprinkled in to the next
> > > big series you post, which is bad and hard to review. And that leads to
> > > fixes not getting merged / reviewed timely because nominally simple fix
> > > A is in part 3 of a series to introduce something larger and to which
> > > there is feedback to work through.
> >
> > I actually thought I was splitting them up quite nicely. What do you suggest?
>
> I would refer back to your own comments about what some of the patches
> do and say that "Just something I noticed" should be a one off, and
> little fixes for this-and-that should be a 1-2 part series and so on.

I really don't have a great workflow for keeping track of more than
6-8 pending series and even that is sometimes a struggle. For testing
I need everything applied so I have every series in a sequence applied
locally.

I will have a think about what can be done. I wonder how others do it?

Regards,
Simon
