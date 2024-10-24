Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30DACE8E73
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 13:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C057B88F58;
	Thu, 24 Oct 2024 15:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E8TilSer";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DFFF88F27; Thu, 24 Oct 2024 14:16:56 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BAA288EEB
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 14:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c937b5169cso1364660a12.1
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 05:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729772211; x=1730377011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fZtkhbE0+ekr8pcO1wAyUtXKcxXDLZFcmy143byAU5E=;
 b=E8TilSerV8dWtqHUTdfi2HEFJ0VdFUdDS3l26TbfPownVa1G0CXPWoXJqkloRsUoyY
 yE5vIJGHLqZGV62DiqHN7BxGzHJPh7xzcKpA1UDvJQ7pMpOAL0QH9pgeaodOPcQ43YY3
 WH1eSu3Wie8SbKjoQIEh1QbqTRPKbJZn0JOHvaLCqQPfZycN+Q22sMHkTKJrh/5MFZUl
 eufhUzpNC95xGCl1qvTZIK80Tj9LMoSKu3VCheDpYSvD+Mo/nYNsLHshVg1MxTU0g3Re
 QUa/OT7iSc3Pa5JSNtMBZT7irKWQela9W1GXVVjQn40EJGG92q1EjXnrJwyCc/Ae4ED8
 71nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729772211; x=1730377011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fZtkhbE0+ekr8pcO1wAyUtXKcxXDLZFcmy143byAU5E=;
 b=JlTFArq1Gx0ayTV7+eMdrHrLIDhqCo7oDCLP2AlQpqIeZi3t8MVlIoBY1ZvD6Pirqk
 x40p2rjbnKNGPmNvFszRUNZTzO4O9e9M7dxUT4XVXYEfShNeizf2B/RgRRUy1N9zC1h4
 h47es41V2iABS5fVStvLVi/B8rT1rldxnm4U4iFHJ392kbvY/+HlUJrb6LIbKQUu/uLa
 5fGbe5LXx5SCe85PEV+lux8tGCFkoAPUkB00YCPN0TRtHoxldtP/mrQXmfzLC/51nn7J
 TlxnuzzFtRx3GDWXZnieKTYBpFAkWdtaH38tQYrRDskxuaaA40eoDmo8kYiEuFbmNGQp
 67bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS+ynLs+xQyUJNqxm3x+mrLgMvUJlSxoyvjobmZBCDwSZ/AsipZmM4UdLxOzjL2r9t/wWia+Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwMDv7sbZVwFq/Fxez8oTN35invvGxTJYwW71Eof7SlRNTEz9mw
 NLN8ssW5YqekZJrxzHIniX5W6u04rNTz86j8XVKYtfSZHH3XaCJL/BR0NA6TT/xP9myIiLVs5O9
 OblI888Bg61kB4qsbfxHVTpaXv+8=
X-Google-Smtp-Source: AGHT+IE55BSJ67yR8/wyoCIKddlNUZQ3EKgYO20nkoG8YLABHy8krUluwsbXxadC7QTKHFxzwTBp+Nmffju3poPK324=
X-Received: by 2002:a05:6402:5288:b0:5c9:7395:b9b6 with SMTP id
 4fb4d7f45d1cf-5cba2110aa3mr2066904a12.16.1729772211170; Thu, 24 Oct 2024
 05:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021172613.GN4959@bill-the-cat>
 <CALeDE9OVd49GiW+M8ygEA5CCF7F8f+MD4okNtk0a8aM1oqsTDQ@mail.gmail.com>
In-Reply-To: <CALeDE9OVd49GiW+M8ygEA5CCF7F8f+MD4okNtk0a8aM1oqsTDQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Oct 2024 13:16:39 +0100
Message-ID: <CALeDE9OA1EfoddO8yxsjvePAOqy2dMupU2uZnuZMZNtAkgdYZA@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] led: Remove old status-LED code
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
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
X-Mailman-Approved-At: Thu, 24 Oct 2024 15:12:23 +0200
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

On Tue, 22 Oct 2024 at 09:48, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> > On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> > > There has been an LED framework in U-Boot which uses driver model for
> > > about 9 years now. Recent work is underway to improve it and provide
> > > more features. It is probably a good time to drop the old code, which
> > > is only used by 5 boards:
> > >
> > >    ./tools/qconfig.py -f LED_STATUS
> > >    5 matches
> > >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> > >    socfpga_vining_fpga
> > >
> > > This series attempts that.
> > >
> > > Changes in v2:
> > > - Combine code-removal and defconfig changes
> > > - Add a patch to enable LED and LED_BOOT for these boards
> > > - Add a patch to enable LED and LED_BOOT for these boards
> > > - Enable LED on the 5 affected platforms
> > > - Reorder patches for bisectability
> >
> > So I believe this means you missed the feedback of just doing the blind
> > migration rather than disabling the feature, like we used to often do
> > for cases where it's just a matter of changing CONFIG options. It
> > should:
> > - Not introduce a failure to build
> > - Just work on platforms with either OF_UPSTREAM or semi-recent device
> >   trees
> > - Just start working on those platforms when they do move to
> >   OF_UPSTREAM.
>
> Also when the migration was first bought up I had a quick look at how
> to do it for the pinephone and I came up empty handed. Now I've seen
> the patch for the pinephone and grep for LED_BOOT the only form of
> docs I find is in the Kconfig and include/led.h, they refer to things
> that aren't in-tree and the out of tree reference to
> dtschema/schemas/options/u-boot.yaml, the only in-tree u-boot.yaml is
> ./dts/upstream/Bindings/mtd/partitions/u-boot.yaml, that I find has no
> reference to boott leds at all.
>
> I feel the reason there's been a recent move to add users of the
> obsolete method is because the docs for that actually existed and
> there's nothing for the new method. Maybe the first patch in the
> series should be to add some actually useful doc rahter than go from
> docs for the old method to nothing.

So I've tried the patch on the pinephone and it doesn't work.

I suspect you need to at least enable a led driver like LED_GPIO but
even when I do that, while I can make the led turn on/off manually, it
doesn't come on in early boot like it does with the old code. There's
definitely something else missing here.

Peter
