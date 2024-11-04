Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECC1D1CA0E
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 01:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08998887D1;
	Tue,  5 Nov 2024 02:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XKAHtjBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95A4588F14; Tue,  5 Nov 2024 00:13:59 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 474AF88ECC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 00:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37d55f0cf85so3101520f8f.3
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730762037; x=1731366837; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PvTrqNQleMKSbvVuwOkG4DPkBayvs6uXmyWCqfWsw/o=;
 b=XKAHtjBIoabdYFc0cBFgZEigQDiZhDbqQoqcfaexdeZmuPf/5TvAOz25/82pUPAD5e
 6z2FuEneGpv5gDrCa36lBpdJLz1tFCHi/zSKSWi8NVPDwPmdb+r9MeXx0Jo+SHflI8RL
 ihlwPS8fJIXL5ZAVibtid2tWiJEGgreQ8/vetty8lMB5SkhwuenfjcWyhTce8Wm+V1Ff
 MsDncMlCISaUrjOfvP+Lx0V9etR+q+bnLcTc5nJkAW39aKtf2LVQe9hDNOEC2vz4Zqy/
 zbm0ZKaJ0LuI9XK/b9GUw0AeKohTRqTMi3SlGA94gqWCVcWOCsT/oajFydtFrWRNZ2z2
 SrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730762037; x=1731366837;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvTrqNQleMKSbvVuwOkG4DPkBayvs6uXmyWCqfWsw/o=;
 b=NPtINL5/eUxZc7JdRg8Xsexequ4nQEVbT+CsCnXRBdY0gdqO6ujpLv9CcyK96rkOtb
 qLXa4oJDxn0wpjD4OF14gjTPK9rFDCxiYeI6w4Crh4IGW/K230bmwog5e9gnSiw/Jw+C
 RRJdCCa3VoO3cbuiCZkXxEv0VA5XsUHgzTsCsG3b8CSKXTKIJdKZgVwOeGk0YXOarVEa
 ZDPsR29cdVATfgmFPrpJn10VEmkD2f8vA80CLmXCNp16iyE38nbZ3coypTGadjK4dCko
 zZbAhb+N51mM3SoOHnU9lzJvr/WIo5kRQxdigGedBJceFtN3HBWEmbSuDXj0GSW6ZnA6
 Xhqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCm2winj1F+LBhJQtZfTHgKuktLmr77juHN7i/ZRKRt1webY1QudLUrt4U4p1KsGsZFb7beko=@lists.denx.de
X-Gm-Message-State: AOJu0YxmvUcmXHpLvE4uer+zK+btiMIVrwlVUJ+GOekspQGnt6pS5m3o
 szxhCcBU3RWQM9KUxYSuWZAVE429qjRamr1L15N06l5nzkrWqa5T
X-Google-Smtp-Source: AGHT+IG5cu3xUUHsD0ujh928NPwCk8pea1b7cDNUN6Ti7CDJ9ckjqKoaGCOe93TXCTjuLV0CdHcpsw==
X-Received: by 2002:a05:6000:2a82:b0:381:cffc:d40b with SMTP id
 ffacd0b85a97d-381cffcd78bmr6894980f8f.39.1730762036491; 
 Mon, 04 Nov 2024 15:13:56 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e8466sm197962305e9.2.2024.11.04.15.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 15:13:55 -0800 (PST)
Message-ID: <67295533.050a0220.e889.dca0@mx.google.com>
X-Google-Original-Message-ID: <ZylVL0k7vUtEM9wL@Ansuel-XPS.>
Date: Tue, 5 Nov 2024 00:13:51 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v5 03/11] led: implement LED boot API
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-4-ansuelsmth@gmail.com>
 <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
 <CAFLszTh9WYnya=8YXXFEcSuVUYuhCGy-+iYFRucgMZq+-1H5UQ@mail.gmail.com>
 <67267f36.df0a0220.87602.7b89@mx.google.com>
 <CAFLszTgP5r56eCTGuG4fbga7Wj8iU97dQZmcvw4ze0UBOhRj1g@mail.gmail.com>
 <672682f5.050a0220.361a4b.7e2b@mx.google.com>
 <CAFLszTid7ZhM-mrkP4PQmSMsOp3PxJ+8tkWj292MUwpeZB7v=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTid7ZhM-mrkP4PQmSMsOp3PxJ+8tkWj292MUwpeZB7v=A@mail.gmail.com>
X-Mailman-Approved-At: Tue, 05 Nov 2024 02:28:58 +0100
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

On Sun, Nov 03, 2024 at 07:46:19AM -0700, Simon Glass wrote:
> Hi Christian,
> 
> On Sat, 2 Nov 2024 at 13:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Sat, Nov 02, 2024 at 01:50:13PM -0600, Simon Glass wrote:
> > > Hi Christian,
> > >
> > > On Sat, 2 Nov 2024 at 13:36, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > On Sat, Nov 02, 2024 at 01:33:10PM -0600, Simon Glass wrote:
> > > > > Hi Christian,
> > > > >
> > > > > On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > > >
> > > > > > > Implement LED boot API to signal correct boot of the system.
> > > > > > >
> > > > > > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > > > > > designated boot LED.
> > > > > > >
> > > > > > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > > > > > This makes use of the /options/u-boot property "boot-led" to the
> > > > > > > define the boot LED.
> > > > > > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > > > > > to define the default period when the LED is set to blink mode.
> > > > > >
> > > > > > BTW could you please send a schema update for this so that Linux accepts it?
> > > > >
> > > > > I'm just checking that you did this?
> > > > >
> > > >
> > > > Yep [0]. Also tagged Rob 2 hours ago. (eh the coincidence)
> > > >
> > > > Tell me if I should send it with usual way with a dedicated mail. (any
> > > > hint on the mailing-list address?)
> > >
> > > OK great! Yes, once it lands, please send a patch to bring it into U-Boot
> > >
> > > Regards,
> > > Simon
> > >
> > > > [0] https://github.com/devicetree-org/dt-schema/pull/144
> >
> > I'm confused what kind of patch I should send to U-Boot?
> 
> Something to add the binding to U-Boot also. See my patch at [1]
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20241103003322.626036-26-sjg@chromium.org/

Ok thanks for the hint.

Anyway Rob checked the patch (good news) but he request some changes
(bad news)

I created this PR [1] waiting for CI to confirm everything is ok.

Would be good if you can check the changes while CI tests.

[1] https://github.com/u-boot/u-boot/pull/686

-- 
	Ansuel
