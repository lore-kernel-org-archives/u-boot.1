Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE72D2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:54:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B67891AC;
	Tue,  5 Nov 2024 16:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KIMAD4zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2214891A6; Tue,  5 Nov 2024 16:15:45 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 673F48913F
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so43275195e9.3
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730819741; x=1731424541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=T4ACGCc5ek6TPhQk+7uW62DqTYwnVOTLGW/0qMfzBTo=;
 b=KIMAD4ztFFAiVAJkwHmrZlaxQzSVxc7ficPTR9cBwiRHLddlheBx0LIeLVGVwI8OcK
 K/FuGaCFRKNF8B38lgRe9RMjjIrQD+h3w/J3CaXEdcu/ad/r8Iu+E6FfVWPpaG3ugjT6
 zL891I7JFVtdCAUAqcYG/T+LEEWFEo6smBxYlZFMDAsmFhCBSOCmVyLtU08DuUwyOq+x
 zQI4sIabRuYfOMKh109KQz73fihJos65lXKSepbR1jTPv660C8/YJjB2MWLGSYeXuyQA
 rOMO2+rmA3n5dhNDcnC23QkoFRVjhb4B/JMLxfmfcGTlbt7CmTw+4bQMNh48TKC/wS/Y
 L1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819741; x=1731424541;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4ACGCc5ek6TPhQk+7uW62DqTYwnVOTLGW/0qMfzBTo=;
 b=R1d9O7UtYdUJM8cNiC7rJtt9o47pie7WfOhJSX+IEgpl66u4GbjsIk4H9pWnlG6Bnt
 3D28UIkvktbZi9eOMXEcEeosETNBe9e1ZlpybMk8EjUMm6lQIq59KjqFoZWhOJztqyW3
 ZSzosH9GBP62EY3WoKDw2uXoQHQvcUClKSIpuVmvErFhRh+q+EAkWQxT2dvhldbINhr+
 3GdjE2Ju0Qab7K4830u/kqspl/wBzKtbbWnq1U5o568jQdOI2GviwRMmiIcxvZBgiOJ3
 fa5fBaxrWpAwec8vr/DbrY+4lS0UapBqvogbYLhOQ+1lvxlBgZzl2Opfey4ZaaHmkYvM
 +Spg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8fs3E5yTifaGSdVMRDO/HjylGS6EmRZbeUAEE6mv+sedrHtL0wCpIoZKiACo+z5RaMnFGlxc=@lists.denx.de
X-Gm-Message-State: AOJu0YyzNqCFT3g55x5+s+dr9XOK6K4dMejIDI8RJu+Vg8HASccttMXi
 pgu1tLHKECIErhrUxOuYM4bRoQucMO7zbXh7rsza8CGifpah/K21
X-Google-Smtp-Source: AGHT+IHY9LQlVDeEFd48PSLFYxYasSOoFzJy4UuvHrPl5IRQQuB4hmh7b6opsi6yYMGfqLGkjKGtlw==
X-Received: by 2002:a05:600c:5114:b0:431:60ac:9aef with SMTP id
 5b1f17b1804b1-431bb9de94bmr225223245e9.29.1730819740393; 
 Tue, 05 Nov 2024 07:15:40 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10e7449sm16517891f8f.49.2024.11.05.07.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 07:15:40 -0800 (PST)
Message-ID: <672a369c.5d0a0220.2a81fb.f4b3@mx.google.com>
X-Google-Original-Message-ID: <Zyo2l6VupoH6PWIu@Ansuel-XPS.>
Date: Tue, 5 Nov 2024 16:15:35 +0100
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
 <67295533.050a0220.e889.dca0@mx.google.com>
 <CAFLszTjwqrufzc7Ujt3oOhsL5AxPa-Bbr61edrHomChtPqyEjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjwqrufzc7Ujt3oOhsL5AxPa-Bbr61edrHomChtPqyEjA@mail.gmail.com>
X-Mailman-Approved-At: Tue, 05 Nov 2024 16:54:11 +0100
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

On Tue, Nov 05, 2024 at 08:12:47AM -0700, Simon Glass wrote:
> Hi Christian,
> 
> On Mon, 4 Nov 2024 at 16:13, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > On Sun, Nov 03, 2024 at 07:46:19AM -0700, Simon Glass wrote:
> > > Hi Christian,
> > >
> > > On Sat, 2 Nov 2024 at 13:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > >
> > > > On Sat, Nov 02, 2024 at 01:50:13PM -0600, Simon Glass wrote:
> > > > > Hi Christian,
> > > > >
> > > > > On Sat, 2 Nov 2024 at 13:36, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > >
> > > > > > On Sat, Nov 02, 2024 at 01:33:10PM -0600, Simon Glass wrote:
> > > > > > > Hi Christian,
> > > > > > >
> > > > > > > On Wed, 2 Oct 2024 at 16:55, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > Implement LED boot API to signal correct boot of the system.
> > > > > > > > >
> > > > > > > > > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > > > > > > > > designated boot LED.
> > > > > > > > >
> > > > > > > > > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > > > > > > > > This makes use of the /options/u-boot property "boot-led" to the
> > > > > > > > > define the boot LED.
> > > > > > > > > It's also introduced a new /options/u-boot property "boot-led-period"
> > > > > > > > > to define the default period when the LED is set to blink mode.
> > > > > > > >
> > > > > > > > BTW could you please send a schema update for this so that Linux accepts it?
> > > > > > >
> > > > > > > I'm just checking that you did this?
> > > > > > >
> > > > > >
> > > > > > Yep [0]. Also tagged Rob 2 hours ago. (eh the coincidence)
> > > > > >
> > > > > > Tell me if I should send it with usual way with a dedicated mail. (any
> > > > > > hint on the mailing-list address?)
> > > > >
> > > > > OK great! Yes, once it lands, please send a patch to bring it into U-Boot
> > > > >
> > > > > Regards,
> > > > > Simon
> > > > >
> > > > > > [0] https://github.com/devicetree-org/dt-schema/pull/144
> > > >
> > > > I'm confused what kind of patch I should send to U-Boot?
> > >
> > > Something to add the binding to U-Boot also. See my patch at [1]
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20241103003322.626036-26-sjg@chromium.org/
> >
> > Ok thanks for the hint.
> >
> > Anyway Rob checked the patch (good news) but he request some changes
> > (bad news)
> >
> > I created this PR [1] waiting for CI to confirm everything is ok.
> >
> > Would be good if you can check the changes while CI tests.
> 
> A few things:
> - Better to return -ENOENT or -EINVAL if something is missing, since
> we use -ENODEV in driver model to mean there is no device
> - 'nodep' instead of 'node' for the parameter, so it is clear that it
> is returned
> 
> Otherwise it looks good to me (with the proviso that's I'm just
> looking at an emphemal github link!)
>

Thanks a lot. Fighting a bit with the tests but thanks for the feedback.

> 
> >
> > [1] https://github.com/u-boot/u-boot/pull/686
> >
> > --
> >         Ansuel

-- 
	Ansuel
