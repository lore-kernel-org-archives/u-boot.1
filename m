Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B20C021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 22:03:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D66280F1C;
	Sun, 16 Feb 2025 23:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X3qmZtOE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A4B80F12; Sun, 16 Feb 2025 20:39:53 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA0F780F0B
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 20:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so741709866b.3
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739734790; x=1740339590; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t0CL/8LCaSyD1LwLVfAR35Q5bHbHfvKRcazmc+Grrvc=;
 b=X3qmZtOE/fGoNfnWmUuL7nYKfeeVx/wwddTkjtmvBx+vgLQ5Ra3UG0VVQiRdTcO7Xf
 unaqE/yGk3czuvC0G5/TGw+hF4xHaQZ0GkqJJ89dP14wOhw1+lPAfT3wWkXS/fAoPkRd
 0hQZlSv+bZBfuiJJ7MCpCDwsZlzYwqwL2elrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739734790; x=1740339590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0CL/8LCaSyD1LwLVfAR35Q5bHbHfvKRcazmc+Grrvc=;
 b=NUNBITz9Zb8EjG58nzaHd11gVZK1qLxmrXJRj/S/54k2+Enmpqenitt7mE+Pw6JnGn
 pFlrpFSsaC2B/gu8BWhCVBPv7sRPi3SA8RGmctJYyeeJr0tVrHP/z5OjVYMTqreFTIoe
 ErpXGvDEv2nWDEcno3OPIoloV+QRWghMoMTZhz73dDoshLTVLcnXWLW/zujNZ3Mf/QKp
 W/okOOqXsq3jacEpW2rhikGKIS9WbfnxAWi4xKx7a/LYRfLDSEIyXoOotvIYX6vGAqw4
 oFRJkKuLqmXq5fFTISx38FC6NfgOmLxC7PlQFCePRB8WFJKsYUK0XPUmPHmlkDdaPIVg
 JA5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0iQlF4qN4CR9cAoRPcYTDqy2N99F7OTVYPvoIQx7YqUyhlTNaMumJSmdceDIZ5666Gdwy55Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwRF5GKqkQN85soLU7G21cr0ELFuID9fRslWvf36M7BsIANqArj
 Oh4FSMAr1G6T96aido/Hi6iR/VTg7gARygWWaxXKEFj3d95GSj3AOCTPJ54AAOpbsYdomVKG1f7
 XZwY6uSFBUg/oLt8BqJb0eDqLeo8jnepTekzB
X-Gm-Gg: ASbGnctprQ6/g7D8jDxclfOOP4aLjBN3GVEPFbAM28hScDhjNYipQPXiJ+CSaifusHm
 61G5sHlHSUnut8UDkry+tObQQW3aN61wykb57tr/mQxvOQ+Q+XJW5ustAUGgTGtFQxioyS253Rg
 ==
X-Google-Smtp-Source: AGHT+IE9tZ+xYBl/csaii3uTyIJciaqnajeI8d+46ad+g8PmtiGakbq/O61zyxYsWcE+OXUATKeinU7u4yJndbyOHH0=
X-Received: by 2002:a17:907:7f27:b0:aa6:b473:ea4c with SMTP id
 a640c23a62f3a-abb70bfe005mr850154566b.10.1739734790015; Sun, 16 Feb 2025
 11:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20241206023626.2456858-1-sjg@chromium.org>
 <20250124191830.GS60249@bill-the-cat>
 <CAFLszTgZKtsCgrptCCJm2Ucbz2b0zPeOymT6aUb2=VBwjOubpA@mail.gmail.com>
 <20250215144652.GN1233568@bill-the-cat>
 <CAFLszTjnFH3tY5p5e0FNvufqVLzEAD8Sc7Fed=csuSQdMbebPw@mail.gmail.com>
 <20250215182112.GU1233568@bill-the-cat>
 <CAFLszTiG10LVJLeN=rvNBQxH=bHehnTYLTRJ7DGQ0qSOMK=epQ@mail.gmail.com>
 <20250216161516.GB1233568@bill-the-cat>
 <20250216162132.GC1233568@bill-the-cat>
In-Reply-To: <20250216162132.GC1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 16 Feb 2025 12:39:38 -0700
X-Gm-Features: AWEUYZmUsXK9WLVICFkgesbz7xFDwmf8kPlj5RrSyt3U8PAEQ0yhVNHQOzOa2wE
Message-ID: <CAFLszTgLznQ7cjdHG-wC2y6DZh=7tnHCk_F2fXRmgOrtvGOQEg@mail.gmail.com>
Subject: Re: [PATCH v3 00/46] pxe: Support read_all() for extlinux and PXE
To: Tom Rini <trini@konsulko.com>
Cc: Michal Simek <monstr@monstr.eu>, U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Adriano Cordova <adrianox@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Julien Masson <jmasson@baylibre.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Nam Cao <namcao@linutronix.de>, Peter Korsgaard <peter@korsgaard.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Rick Chen <rick@andestech.com>, Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 16 Feb 2025 23:02:56 +0100
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

On Sun, 16 Feb 2025 at 09:21, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 16, 2025 at 10:15:16AM -0600, Tom Rini wrote:
> > On Sun, Feb 16, 2025 at 07:09:57AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 15 Feb 2025 at 11:21, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Feb 15, 2025 at 10:24:08AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sat, 15 Feb 2025 at 07:46, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sat, Feb 15, 2025 at 05:06:42AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 24 Jan 2025 at 12:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Dec 05, 2024 at 07:35:39PM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > This series implements read_all() so that it is possible to read all the
> > > > > > > > > files relating to a bootflow, make adjustments and then boot.
> > > > > > > > >
> > > > > > > > > Unfortunately quite a few things stand in the way, so this series
> > > > > > > > > finishes off several pending items: zboot without CONFIG_CMDLINE,
> > > > > > > > > required support in pxe_utils and the differing code in the extlinux and
> > > > > > > > > PXE bootmeths. There is very little new code, but quite a lot of
> > > > > > > > > refactoring.
> > > > > > > > >
> > > > > > > > > The bootm, booti and bootz commands have all been refactored previously,
> > > > > > > > > so that they can operate without needing CONFIG_CMDLINE to be enabled.
> > > > > > > > > At the, time, zboot was left alone, since it is x86-specific and a bit
> > > > > > > > > more trouble.
> > > > > > > > >
> > > > > > > > > However it turns out that the booti support doesn't work with compressed
> > > > > > > > > booti images, so this series resolved that problem too.
> > > > > > > > >
> > > > > > > > > This series adds a programatic API for zboot and uses the forthcoming
> > > > > > > > > bootstd 'image list' to collect information from an extlinux file. It is
> > > > > > > > > therefore possible to parse the file, load the resulting images and then
> > > > > > > > > examine/adjust the resulting bootflow, before booting.
> > > > > > > > >
> > > > > > > > > The addition of options to extlinux resulted in the PXE and extlinux
> > > > > > > > > bootmeth having slightly different features. This is tidied up in this
> > > > > > > > > series, with common functions for both. This allows the same features
> > > > > > > > > (loading images as a separate step) to be provided for PXE.
> > > > > > > >
> > > > > > > > With v4 of 45/46, this fails with lwIP on Pi in the PXE tests now. You
> > > > > > > > likely don't need more than CONFIG_NET_LWIP=y being added but for
> > > > > > > > completeness here's everything:
> > > > > > > > CONFIG_UNIT_TEST=y
> > > > > > > > # CONFIG_CMD_EFIDEBUG is not set
> > > > > > > > CONFIG_CMD_BOOTMENU=y
> > > > > > > > CONFIG_CMD_LOG=y
> > > > > > > > # CONFIG_CMD_BOOTEFI_SELFTEST is not set
> > > > > > > > CONFIG_IPV6=y
> > > > > > > > CONFIG_IPV6_ROUTER_DISCOVERY=y
> > > > > > > > CONFIG_CMD_TFTPPUT=y
> > > > > > > > CONFIG_CMD_WGET=y
> > > > > > > > CONFIG_FIT=y
> > > > > > > > CONFIG_FIT_SIGNATURE=y
> > > > > > > > CONFIG_FIT_BEST_MATCH=y
> > > > > > > > CONFIG_SYS_BOOTM_LEN=0x4000000
> > > > > > > > CONFIG_NET_LWIP=y
> > > > > > > > CONFIG_BOOTSTAGE_STASH_ADDR=0x02400000
> > > > > > > > CONFIG_BOOTSTAGE=y
> > > > > > > > CONFIG_BOOTSTAGE_STASH=y
> > > > > > > > CONFIG_CMD_BOOTSTAGE=y
> > > > > > > > on top of rpi_3_defconfig.
> > > > > > >
> > > > > > > I just noticed this response (a bit behind on email), but I don't
> > > > > > > think it is reasonable to require out-of-tree changes. We just need CI
> > > > > > > to pass, along with any labs. This whole series seems to have been
> > > > > > > blocked?
> > > > > > >
> > > > > > > If you like, I would be willing to debug it if this series is applied,
> > > > > > > and send a follow-on patch. I have a second rpi3 in my lab which I
> > > > > > > could add to gitlab, along with the changes above, so we can catch
> > > > > > > this sort of thing in future. It would have to be added with some
> > > > > > > documentation, so others can figure out what is going on. Just to be
> > > > > > > clear, I have no issue with LWIP, just with this series being blocked
> > > > > > > due to out-of-tree changes.
> > > > > >
> > > > > > I don't know what "out of tree" changes you're referring to. I guess you
> > > > > > mean the test I noted above? It's only out of tree because you didn't
> > > > > > follow up with Heinrich's buildman patch to allow using fragments. If
> > > > > > that was applied then it would be worthwhile to have the Pi targets in
> > > > > > your lab do more tests, including the above. And please note this is my
> > > > > > lab that fails.
> > > > >
> > > > > I suggested a file format to specify combinations that we test. You
> > > > > wanted them to be created as separate boards. If you don't want to
> > > > > reconsider my proposal[1] you could create a separate in-tree rpi3
> > > > > board with these options. That would actually be easier for my lab,
> > > > > although with Heinrich's patch it wouldn't matter much, as you say.
> > > > >
> > > > > Heinrich's patch[2] is fine but needs a test. Are you asking me to write it?
> > > >
> > > > Yes, I much prefer what Heinrich did. As he's apparently been too busy
> > > > to address your feedback, it would be helpful if you finished it.
> > >
> > > Yes I can do that - so are you OK to apply this first?
> >
> > No, I am not. It (a) doesn't apply to master (or more appropriately now,
> > next) and (b) breaks my lab. I'm actually now a little confused about
> > why qemu_arm64_lwip doesn't break in CI too. I bet it's because while we
> > do:
> >     - ln -s conf.qemu_arm64_na /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
> > we don't have a similar link for the boardenv problem (so yes, your
> > patch to make it say something would be good, but also, ugh, that
> > https://source.denx.de/u-boot/u-boot/-/jobs/1025936 shows 6 skipped,
> > nothing passed means we didn't *look* for anything more than green light
> > / red light).
> >
> > So I'm going to go and fix things so qemu_arm64_lwip runs tests for
> > real, and CI would fail on this series. And Michal, is there a reason we
> > don't enable network tests in the boardenv files for xilinx? That's
> > using lwIP now too, but since most of the tests don't run, it would also
> > not fail there due to being skipped.  You can use the qemu boardenv
> > files as examples of how to automatically get something available for
> > tftp.
>
> And it looks like Azure would like fail as only gitlab was missing the
> symlink for the boardenv file. Azure logs get dropped much quicker and I
> can't see if I have that failure anymore, but I can see most tests run
> on qemu_arm64_lwip.

OK, that's fine. I'll pick up your patch and see what needs doing.

Regards,
Simon
