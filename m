Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28B9D0E3F3
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 19:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C60E88FCB;
	Thu, 24 Oct 2024 21:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hlAEmyR3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DC1488E63; Thu, 24 Oct 2024 18:52:53 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D83688D47
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 18:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so1495059a12.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729788763; x=1730393563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oenq2X7z2zaYul/29pngbzDgtCwAdsg+ZDSf6N5KXN0=;
 b=hlAEmyR3keDUFZBQY+ZTiPOueCgZOZ7v/YGLzAR+Y0G5eDTzHEvM9Ze6nUut2mnzeE
 1mYgpiN1oodPZkheeATSWsMDKFZxxdRTGoKkPm8+BQaOoOk595jJePjTwlQF9ib+wNGG
 Z4dJWhEm/H2tTcHLuA1GCP3asjzeLT9v2YzqaqDAGMvp/WGZgh+23hpUofuhvselN3Ev
 nXAb9c53SDnBg4qcUwNNE6ERKt64Mdts8lXnSsVGduIZqNUlLmeJRHEuK7/RSxnz5zeV
 5kJ2ORIqMlO7hvNQlqomip4YuwYW4D0WUkW1yKn7k1ZSFvvtoo8+sZmtQmYoSb5GGi43
 6L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729788763; x=1730393563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oenq2X7z2zaYul/29pngbzDgtCwAdsg+ZDSf6N5KXN0=;
 b=Qw1gmeOjQMx6ZsnE5LMU77764c0/LhpJf3pz15e33ymJXk2ljLBsBChi5DMxYyc+cu
 3SWNNqd3TfTAIG4EaQp3pQvSykqoDRug8AMFGMp9Utq5mD5n+tErewJ0IwGbmP0+jLbr
 jYpmgveyBNhwc2GYze+DxKagVO2LyI6d5xcCopNu8LSUmnQYbRzQLQVgsJEFj4FlH9OH
 rdWtzacActu1CD87vwvjVyV6jTchRhMUxr3QTjDOh+VknSPHoUeSXIeLNKXqxlA9oJ6e
 MG4aPXJudT2bCkXuUZgB2L3k5EuDVRti4MDSostqqc2k+GKqOf92tSZj4WTea5PVX9vs
 yWCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV88EodKmtpum9t5nyTB62gT/se7bN+IULsf86PkxpFxYKWOd7Y57AfN6B1Ro7i87mKmZaMXQg=@lists.denx.de
X-Gm-Message-State: AOJu0YzAt/KCiccnzEOKttYHlNowtOAbp1tv8a+3PrniWV8EO9Zba/2J
 Lrf/vGpSSO4LJYXyFcHjamyLC6Mmsy60TfsViaWz3+lMZyeSO6roU+B5TKEQC7kDvZKcSXYdFHb
 Ut3EE8K1QN2UbPlKmpnMTJTXiyoo=
X-Google-Smtp-Source: AGHT+IG4NiAIcrET4kI6FLDfF9ZbxaqASRHQjAoF8Cc2tYzqbyfGoI9vFTK0RXcntPYtbPPCbeJH0cGJyXMTC1REStU=
X-Received: by 2002:a05:6402:34ca:b0:5cb:6ca4:f4cd with SMTP id
 4fb4d7f45d1cf-5cba2427f70mr2020156a12.7.1729788762277; Thu, 24 Oct 2024
 09:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021172613.GN4959@bill-the-cat>
 <CALeDE9OVd49GiW+M8ygEA5CCF7F8f+MD4okNtk0a8aM1oqsTDQ@mail.gmail.com>
 <CALeDE9OA1EfoddO8yxsjvePAOqy2dMupU2uZnuZMZNtAkgdYZA@mail.gmail.com>
 <CAFLszThzGGfPU9wWdxXLfmWpPB4LvGFALptHU_PJwn8BUs4Cqg@mail.gmail.com>
In-Reply-To: <CAFLszThzGGfPU9wWdxXLfmWpPB4LvGFALptHU_PJwn8BUs4Cqg@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Oct 2024 17:52:31 +0100
Message-ID: <CALeDE9NjjmHUDBkQ39wWkBnP-xXS5OTLy+=-prSQS38WcjHDDA@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Artur Rojek <artur@conclusive.pl>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jens Scharsig <esw@bus-elektronik.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Okhunjon Sobirjonov <okhunjon72@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Sam Edwards <CFSworks@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 24 Oct 2024 21:39:34 +0200
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

On Thu, 24 Oct 2024 at 17:36, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Peter,
>
> On Thu, 24 Oct 2024 at 14:16, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Tue, 22 Oct 2024 at 09:48, Peter Robinson <pbrobinson@gmail.com> wrote:
> > >
> > > > On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> > > > > There has been an LED framework in U-Boot which uses driver model for
> > > > > about 9 years now. Recent work is underway to improve it and provide
> > > > > more features. It is probably a good time to drop the old code, which
> > > > > is only used by 5 boards:
> > > > >
> > > > >    ./tools/qconfig.py -f LED_STATUS
> > > > >    5 matches
> > > > >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> > > > >    socfpga_vining_fpga
> > > > >
> > > > > This series attempts that.
> > > > >
> > > > > Changes in v2:
> > > > > - Combine code-removal and defconfig changes
> > > > > - Add a patch to enable LED and LED_BOOT for these boards
> > > > > - Add a patch to enable LED and LED_BOOT for these boards
> > > > > - Enable LED on the 5 affected platforms
> > > > > - Reorder patches for bisectability
> > > >
> > > > So I believe this means you missed the feedback of just doing the blind
> > > > migration rather than disabling the feature, like we used to often do
> > > > for cases where it's just a matter of changing CONFIG options. It
> > > > should:
> > > > - Not introduce a failure to build
> > > > - Just work on platforms with either OF_UPSTREAM or semi-recent device
> > > >   trees
> > > > - Just start working on those platforms when they do move to
> > > >   OF_UPSTREAM.
> > >
> > > Also when the migration was first bought up I had a quick look at how
> > > to do it for the pinephone and I came up empty handed. Now I've seen
> > > the patch for the pinephone and grep for LED_BOOT the only form of
> > > docs I find is in the Kconfig and include/led.h, they refer to things
> > > that aren't in-tree and the out of tree reference to
> > > dtschema/schemas/options/u-boot.yaml, the only in-tree u-boot.yaml is
> > > ./dts/upstream/Bindings/mtd/partitions/u-boot.yaml, that I find has no
> > > reference to boott leds at all.
> > >
> > > I feel the reason there's been a recent move to add users of the
> > > obsolete method is because the docs for that actually existed and
> > > there's nothing for the new method. Maybe the first patch in the
> > > series should be to add some actually useful doc rahter than go from
> > > docs for the old method to nothing.
> >
> > So I've tried the patch on the pinephone and it doesn't work.
> >
> > I suspect you need to at least enable a led driver like LED_GPIO but
> > even when I do that, while I can make the led turn on/off manually, it
> > doesn't come on in early boot like it does with the old code. There's
> > definitely something else missing here.
>
> It's good that you have one of these boards. Would you be able to
> debug it and send a patch?

Well I spent some time this morning and never got any further other
wise I probably would have. When I first tested this against the
2024.10 release I discovered the new boot led stuff has been only
added in this cycle [1] yet you mention above the other code has been
obsolete for 9 years, not sure how that's possible if there's been
nothing to migrate to. Also looking at the patchset the docs are
bbasically non existent! so without having to dig through the code to
work out how to specify the led, like Is there DT requirements etc
it's not something that I have many more cycles for ATM.

Peter

[1]  https://lists.denx.de/pipermail/u-boot/2024-October/566459.html
