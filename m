Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F405C3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 10:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65B286DBD;
	Wed, 31 Jul 2024 12:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98A7889A6; Wed, 31 Jul 2024 12:14:38 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id 0317C83989
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 12:14:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.64.133] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>)
 id 1sZ6Lh-0007Xh-MW; Wed, 31 Jul 2024 11:14:25 +0100
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
From: Chris Webb <chris@arachsys.com>
In-Reply-To: <CAFLszThCz2NL+6svYMRD7qAHHNN8frWzrM4tyhDbuS77M3jUHg@mail.gmail.com>
Date: Wed, 31 Jul 2024 11:14:34 +0100
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Content-Transfer-Encoding: 7bit
Message-Id: <E1381CA1-72D5-42D5-BB22-2B9B458B29C7@arachsys.com>
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
 <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
 <CAFLszTggwpCnhZ0xaPR2n=e+x+PDe-wP4WxnPE60BqyF1ms3UA@mail.gmail.com>
 <43228DC7-4184-4C63-9BBA-65F056ECC91F@arachsys.com>
 <CAFLszThCz2NL+6svYMRD7qAHHNN8frWzrM4tyhDbuS77M3jUHg@mail.gmail.com>
To: Simon Glass <sjg@chromium.org>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
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

Hi Simon,


Simon Glass <sjg@chromium.org> wrote:

>> Presumably it needs to apply to every mtk soc that uses
>> mtk_pinctrl_common_probe() as they'll all be affected by this problem.
>
> Yes I suppose so.

As well as the mediatek case (patch just sent), I thought I should look  
through the other pinctrl drivers for other examples of this problem you  
explained to me.

Both starfive/pinctrl-starfive.c and mvebu/pinctrl-armada-37xx.c do the  
same thing, calling their gpiochip_register as part of the driver probe  
method. The pinctrl-armada-37xx.c driver also has a bind action:

   static int armada_37xx_pinctrl_bind(struct udevice *dev)
   {
           /*
            * Make sure that the pinctrl driver gets probed after binding
            * as on A37XX the pinctrl driver is the one that is also
            * registering the GPIO one during probe, so if its not probed
            * GPIO-s are not registered as well.
            */
           dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);

           return 0;
   }

which presumably wouldn't be needed if the gpiochip were bound at pinctrl  
bind time instead of pinctrl probe time?

Alas I don't have any boards to test on for either of these platforms.

Best wishes,

Chris.
