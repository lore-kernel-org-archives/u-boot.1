Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD88C3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:44:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F4BF88791;
	Mon, 29 Jul 2024 17:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0B388829; Mon, 29 Jul 2024 17:44:36 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id EDB198881F
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.64.200] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>)
 id 1sYSXw-0007J3-AK; Mon, 29 Jul 2024 16:44:24 +0100
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
From: Chris Webb <chris@arachsys.com>
In-Reply-To: <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
Date: Mon, 29 Jul 2024 16:44:33 +0100
Cc: u-boot@lists.denx.de
Content-Transfer-Encoding: 7bit
Message-Id: <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
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

Simon Glass <sjg@chromium.org> wrote:

> We cannot probe devices when they are bound since it breaks the
> ordering of driver model.
>
> From your trace it looks like everything is happening after
> relocation. I can't quite see what is actually going wrong. But if you
> look at dm_init_and_scan(), it does the probe at the end, immediately
> after all devices have been bound. So it should do what you want.
>
> Is the GPIO device not being bound? There is something strange here.

Hi Simon, many thanks for your follow up. Yes I wasn't convinced the patch  
was the correct fix (hence the RFC) but posted as it was one of the two  
ways I found to make gpio-hog work, the other being adding a .bind  
function in U_BOOT_DRIVER(mt7981_pinctrl) like

     static int mtk_pinctrl_mt7981_bind(struct udevice *dev)
     {
     	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
     	return 0;
     }

to force a probe after bind in the parent pinctrl device. I was hoping  
someone with more clue than me might go 'Aha! This is just...'  :)

The device I tested on has been deployed but I can probably get it back  
for a bit and resolder a serial console on to test again if that would be  
helpful. Are there other significant places I should be adding some traces  
that would make the problem clearer?

Is it significant/relevant that the gpio device is a child of the pinctrl  
device in the mt7981 device tree?

I think the gpio device must be getting bound, because otherwise my trace  
in gpio_post_bind() wouldn't get called at all, but perhaps it's bound too  
late somehow?

Best wishes,

Chris.
