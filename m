Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2CACDD0CB
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 19:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC20891E9;
	Tue, 22 Oct 2024 21:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PcbT/NSl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B3DA88FD6; Tue, 22 Oct 2024 19:01:22 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1A4892B9
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a3dc089d8so817911266b.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729616479; x=1730221279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hZ7TxmuWVdMYQM6FK4UPGLewCCDmvomuMHhfQf+4Is=;
 b=PcbT/NSluEnAio45bQ2HeqjIoPp+l06lkW61REtL0ywnkB9C5tSj6n3IDsRcCtF75a
 vG6g2Zf/9WhrVz/W17qUDUp4fcQLQ/xH+ryWSVbkx+OegusLhVzXDZtTNwKu1mRd8ojF
 d8H7veOaknnm2PABXtK53xpX5PhpPuTnm+0S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729616479; x=1730221279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hZ7TxmuWVdMYQM6FK4UPGLewCCDmvomuMHhfQf+4Is=;
 b=i7Xt05VhdsfPFtc9pbzpPTIhG9LowfhIWe6fA55hQ9/LtfTvXmnvMhcKgkiXkcvs74
 ju3rn+pcKfsrs0eKqV5rbwL03Bx5U9ugIlyKzfanMu4kUls0qPtxz8Gm1nlWCVWJsKnn
 2fmRAJgT2oxhH5IstzLJYUUVZJinNdFF1BpPF86nEy+NG97cPRux/v1wDihemLXjbOrT
 +hY3YbjQJkqtFgfaBbqyjMzFucPmjUPvxf5x/DFVrO6onI+Nf9VSeV9BrRREO7IqnWqh
 LTNvqjWmGtsmUvhjRme03SU2bLLtoi3xSB8byBkTTpvTpfNp69JYy4r3dsM8NAlOfDCr
 Co7Q==
X-Gm-Message-State: AOJu0Yy60mu0Kw5gP4L0U2P2Mbb6fha82rtM57hzmezkW3OuXveMeBwh
 nhkRCWjbrJuetDM2x2c0dPYrnlxl6rFNWMeX/568KK9VSz9BA+0DhBD9TmkyTW8hyq4moJoC5Bs
 2qqk3hlxa6cJkvFKa31EpK133fwmHbOUERbOL
X-Google-Smtp-Source: AGHT+IGJ27CwJs4Z4ktN0LEh0MeFx/aFCCbkqFj3PWkvwAXZmKv/dop3LkcszLXflbY9zGGkn9pkPmC8IR3Q8xchsUs=
X-Received: by 2002:a17:907:928b:b0:a99:5773:3612 with SMTP id
 a640c23a62f3a-a9abde181e0mr4338666b.36.1729616478862; Tue, 22 Oct 2024
 10:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021172613.GN4959@bill-the-cat>
 <CAFLszTguu7hRpsSLxADsBkMgTzA_-fAR0t8Axv+8=OvxJvSRCw@mail.gmail.com>
 <20241022140204.GY4959@bill-the-cat>
In-Reply-To: <20241022140204.GY4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 22 Oct 2024 19:00:46 +0200
Message-ID: <CAFLszTj92aehOTfy_MJmaS316jRs5yYgDKFA5htOoSZs1=faNQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/25] led: Remove old status-LED code
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, Andy Fleming <afleming@gmail.com>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, 
 Artur Rojek <artur@conclusive.pl>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Charles Hardin <ckhardin@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Doug Zobel <douglas.zobel@climate.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Hans de Goede <hdegoede@redhat.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jens Scharsig <esw@bus-elektronik.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
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
X-Mailman-Approved-At: Tue, 22 Oct 2024 21:02:05 +0200
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

On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 22, 2024 at 02:15:34PM +0200, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 21 Oct 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 21, 2024 at 01:38:08PM +0200, Simon Glass wrote:
> > > > There has been an LED framework in U-Boot which uses driver model for
> > > > about 9 years now. Recent work is underway to improve it and provide
> > > > more features. It is probably a good time to drop the old code, which
> > > > is only used by 5 boards:
> > > >
> > > >    ./tools/qconfig.py -f LED_STATUS
> > > >    5 matches
> > > >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> > > >    socfpga_vining_fpga
> > > >
> > > > This series attempts that.
> > > >
> > > > Changes in v2:
> > > > - Combine code-removal and defconfig changes
> > > > - Add a patch to enable LED and LED_BOOT for these boards
> > > > - Add a patch to enable LED and LED_BOOT for these boards
> > > > - Enable LED on the 5 affected platforms
> > > > - Reorder patches for bisectability
> > >
> > > So I believe this means you missed the feedback of just doing the blind
> > > migration rather than disabling the feature, like we used to often do
> > > for cases where it's just a matter of changing CONFIG options. It
> > > should:
> > > - Not introduce a failure to build
> > > - Just work on platforms with either OF_UPSTREAM or semi-recent device
> > >   trees
> > > - Just start working on those platforms when they do move to
> > >   OF_UPSTREAM.
> >
> > Perhaps I didn't understand what you were saying. I thought you meant
> > to enable LED and LED_BOOT on these 5 boards?
>
> Ah, OK, I see the disconnects now, sorry. The first comment I saw was
> Marek's on patch #2. So yes, along with Peter's request instead of one
> commit to disable and another commit to enable, just do 5 commits to
> migrate from one to the other please, thanks.

In order to maintain bisectability I need to delete some code in each
of those commits. But if that is OK, then yes, I believe this is
possible.

Regards,
Simon
