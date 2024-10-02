Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E876CF31B9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 04:41:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 082078914E;
	Thu,  3 Oct 2024 06:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ame9uyR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A7388FC5; Thu,  3 Oct 2024 01:00:52 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85BC88F99
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 01:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb9a0c300so2204165e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 16:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727910049; x=1728514849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ALlOqMFZ81IbZQi9tiqvuTnGtIfEod3v3SrJh9mcn9o=;
 b=Ame9uyR6KfwKmHV8LUf2+a5zBm75FntRqxTePIbiwT0vIN83hZJRMR6cYa/1LKTttd
 ao704iYPSXmTUb+/JkB9TCXSKmfz+7V9exQUmJ/CsSHHSMNSqnEMbW3eajEPWq1C+3HU
 upcTyiu/6Nr3TYrKXaTd0jo4T1HPq5SPzLlJ2G6eDvklMknhfwPcPhka76TR4ReOHKSm
 mAr1I4TiZ3WzRH90PVyAv6PU0SGDJ240TyEswVUXEuVgzOBEmNWA60+/ampC5Rg/5PPx
 63F1G2kLgaeRnnHtxtNTC/3GWQhJKD2N8wpT+taXkIIqLR5ZOOFT9C9b7zzEhZO2QZ5z
 gOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727910049; x=1728514849;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALlOqMFZ81IbZQi9tiqvuTnGtIfEod3v3SrJh9mcn9o=;
 b=UciYS6u2VlKxMKqfRW5k8KF13MrGbX6Tg4KpvFO5B0uODZg816RWdtUsgq0fbljXox
 /Mv3KtgCDxJKqwX75c2Wn7c92o3FfyYcuyk/f+6kvgX7PCTOrOlrJguHXgXAg8F2oMbh
 j9euMBSpKUeCR3qjHY18n5PfsZmyiu5Bt/WpYcbQnwzX3+ZyPaL/jEAr3gFjmUAa8Z6Y
 kQCWVOhQoI6Apq3bJxGbsnFEeOdV5I/hpSnPp1QPEnP8Lbij7/+U7LaiPyr+fRpduTjH
 5rN5lzyuu/+F8do8eCPPXPQknu4XZ7r/NikirlgFSkmDD+f7VGi5z+giXiZaxar3VSC+
 yB+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgzZMoQQcFb9F0MVSDI6QV5j4Jsnk8j7dv3SgFKrwNFbbcdmncufRAmdss0AGewciPsmgmUyI=@lists.denx.de
X-Gm-Message-State: AOJu0YwSxxGjo477kGEy3jIxw9+Ex5G8pvUH2huHLsmvwGFaSHJTB4ze
 59ZBKIRPid3jxFdoVYOyVmDu/ymyOSZy7g9TNoyM56UJMAY6jXQZ
X-Google-Smtp-Source: AGHT+IHwVmFTFtxw2d6Bx/R3Ezvkb9OTqC+y4BhP5yXr4P1f713+LxadVR4aww2tOAWBhkFL61ui9Q==
X-Received: by 2002:adf:a388:0:b0:37c:cd7e:6638 with SMTP id
 ffacd0b85a97d-37cfb8b2d6emr2798149f8f.19.1727910049143; 
 Wed, 02 Oct 2024 16:00:49 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79c67c5csm30907095e9.0.2024.10.02.16.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 16:00:47 -0700 (PDT)
Message-ID: <66fdd09f.050a0220.75511.cc7e@mx.google.com>
X-Google-Original-Message-ID: <Zv3QmlVKUJ14x9Vw@Ansuel-XPS.>
Date: Thu, 3 Oct 2024 01:00:42 +0200
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjB4OV-k65rhqJ9pBTmKUnnWthbDJ2Vk3eRxzBgmMeOOg@mail.gmail.com>
X-Mailman-Approved-At: Thu, 03 Oct 2024 06:40:55 +0200
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

On Wed, Oct 02, 2024 at 04:55:42PM -0600, Simon Glass wrote:
> On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Implement LED boot API to signal correct boot of the system.
> >
> > led_boot_on/off/blink() are introduced to turn ON, OFF and BLINK the
> > designated boot LED.
> >
> > New Kconfig is introduced, CONFIG_LED_BOOT to enable the feature.
> > This makes use of the /options/u-boot property "boot-led" to the
> > define the boot LED.
> > It's also introduced a new /options/u-boot property "boot-led-period"
> > to define the default period when the LED is set to blink mode.
> 
> BTW could you please send a schema update for this so that Linux accepts it?
>

I open a PR there [1] or should I use other way?

[1] https://github.com/devicetree-org/dt-schema/pull/144

> >
> > If "boot-led-period" is not defined, the value of 250 (ms) is
> > used by default.
> >
> > If CONFIG_LED_BLINK or CONFIG_LED_SW_BLINK is not enabled,
> > led_boot_blink call will fallback to simple LED ON.
> >
> > To cache the data we repurpose the now unused led_uc_priv for storage of
> > global LED uclass info.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/led/Kconfig      | 11 ++++++
> >  drivers/led/led-uclass.c | 85 ++++++++++++++++++++++++++++++++++++++++
> >  include/led.h            | 55 +++++++++++++++++++++++++-
> >  3 files changed, 149 insertions(+), 2 deletions(-)
> >
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

-- 
	Ansuel
