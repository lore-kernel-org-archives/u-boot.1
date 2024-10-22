Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82980D2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2FA488FA7;
	Tue, 22 Oct 2024 15:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ee0SioUX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D83788EC9; Tue, 22 Oct 2024 10:48:52 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C9B88F66
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:48:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539f72c913aso6211646e87.1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729586929; x=1730191729; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yXOG4bAnuNruA+w4vpSbSR1SmdXTLwDkoXzo1msrvxY=;
 b=ee0SioUXlNI5N/PJ/vTN9w6k93B4jmM9JHQbxwKNG7kMYkXDZ67XJ5Nvv/gXlKk6zN
 XHGwCXDskLQaKQ9rS+50Li5sWnmYC94Afa2kK8K7bB28pN8OZn1qk5wyul2aUD2Dt8KH
 TeUeZCXrGBKI1Kku2PGF/CKKl+o16vLvTRHz03WeTjwVOsPqY4V3i4h1pZcXyVM/FEJj
 eTrQn5O8aC+Fs8twpTnyS4EIgWsDlzTPsKwhZnj4HZHAzKopHrcbX8AOHk/Vei1rXBQ0
 c/cvQB+3np+iUOUBrf1SYy+zeUY5w7QDInmBVYujU/pKr4GIAEwKgugv5bSwWiP2KDH8
 SO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586929; x=1730191729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXOG4bAnuNruA+w4vpSbSR1SmdXTLwDkoXzo1msrvxY=;
 b=tahBx7QPPSirJqI6hdlMa6nP3tnqmwb1WGpsHlq4ZRIcO4crT9stWrmKqubcxSJuLE
 HsY1woAU9j4oOAnfjXmSjKkWg1h7EMeFe8lyiCdqiW2tyv6rhfFN1UpHCtxYfRwGdCNI
 XyIRQC5MtTaNwfhAAndxG4E+QIgiKeLhPhaFbptW4UTjCC0HYcKU3RTeyt8x263+VAEc
 6tCH3VH9pYVhs5pQvB0kP1BHom32Vx5V7XDzWz4JXZBtmFpZdzTUgPY7IumIlJYUqGoa
 t8TPGkORy+VJ5EJhKFWX7EvQkqch0GSHa4JQ2DHhKdp2BThlIqsGlrA9b0w/eSIIdALl
 pYGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7TqD6SAEto7I/F+vFXh5QaIj6sU5ZRIJKw2pTZk7M1P8mEWF/KVAVm7tgsAToJi7xjRf6ZDc=@lists.denx.de
X-Gm-Message-State: AOJu0YxetFcYnBJSngtljP8am0p3oCFG6j50mlCW0uzm00bEYuZM2Md2
 JsKfUqkmLiZQS4UziwVXteuPXxU2FUK9JDIfXCPW0yBz502KLkdBsWxPaoeC6Xr5naPBNuqC8LO
 c5kT9dwx8dpr9hR9Fg3AeKcVrBK8=
X-Google-Smtp-Source: AGHT+IESDJ30NOXZlrNVe3MHVFVKMJkdGbCKDDCyLk3bWq90A/sQPszJvQs3aN/4SDx3h9OLgyN10NY18y3fsS59Y2U=
X-Received: by 2002:a05:6512:acc:b0:539:e9b4:7ff6 with SMTP id
 2adb3069b0e04-53a15445f78mr7872135e87.45.1729586928951; Tue, 22 Oct 2024
 01:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021172613.GN4959@bill-the-cat>
In-Reply-To: <20241021172613.GN4959@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 22 Oct 2024 09:48:37 +0100
Message-ID: <CALeDE9OVd49GiW+M8ygEA5CCF7F8f+MD4okNtk0a8aM1oqsTDQ@mail.gmail.com>
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
X-Mailman-Approved-At: Tue, 22 Oct 2024 15:18:38 +0200
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

> On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> > There has been an LED framework in U-Boot which uses driver model for
> > about 9 years now. Recent work is underway to improve it and provide
> > more features. It is probably a good time to drop the old code, which
> > is only used by 5 boards:
> >
> >    ./tools/qconfig.py -f LED_STATUS
> >    5 matches
> >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> >    socfpga_vining_fpga
> >
> > This series attempts that.
> >
> > Changes in v2:
> > - Combine code-removal and defconfig changes
> > - Add a patch to enable LED and LED_BOOT for these boards
> > - Add a patch to enable LED and LED_BOOT for these boards
> > - Enable LED on the 5 affected platforms
> > - Reorder patches for bisectability
>
> So I believe this means you missed the feedback of just doing the blind
> migration rather than disabling the feature, like we used to often do
> for cases where it's just a matter of changing CONFIG options. It
> should:
> - Not introduce a failure to build
> - Just work on platforms with either OF_UPSTREAM or semi-recent device
>   trees
> - Just start working on those platforms when they do move to
>   OF_UPSTREAM.

Also when the migration was first bought up I had a quick look at how
to do it for the pinephone and I came up empty handed. Now I've seen
the patch for the pinephone and grep for LED_BOOT the only form of
docs I find is in the Kconfig and include/led.h, they refer to things
that aren't in-tree and the out of tree reference to
dtschema/schemas/options/u-boot.yaml, the only in-tree u-boot.yaml is
./dts/upstream/Bindings/mtd/partitions/u-boot.yaml, that I find has no
reference to boott leds at all.

I feel the reason there's been a recent move to add users of the
obsolete method is because the docs for that actually existed and
there's nothing for the new method. Maybe the first patch in the
series should be to add some actually useful doc rahter than go from
docs for the old method to nothing.
