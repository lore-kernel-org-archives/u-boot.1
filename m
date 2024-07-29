Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6141C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52230887B9;
	Mon, 29 Jul 2024 18:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD74E8881F; Mon, 29 Jul 2024 18:45:09 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id CB0158854A
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.64.200] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>)
 id 1sYTUW-0001X5-N3; Mon, 29 Jul 2024 17:44:56 +0100
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
From: Chris Webb <chris@arachsys.com>
In-Reply-To: <CAFLszTggwpCnhZ0xaPR2n=e+x+PDe-wP4WxnPE60BqyF1ms3UA@mail.gmail.com>
Date: Mon, 29 Jul 2024 17:45:05 +0100
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>
Content-Transfer-Encoding: 7bit
Message-Id: <43228DC7-4184-4C63-9BBA-65F056ECC91F@arachsys.com>
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <CAFLszTiwfVg7o+Rhf10U2exgUA-vJ4V_A-2L75ZLpwJ8sW=9Kw@mail.gmail.com>
 <CB131E81-078E-43FF-BE67-90D7F48EDB2E@arachsys.com>
 <CAFLszTggwpCnhZ0xaPR2n=e+x+PDe-wP4WxnPE60BqyF1ms3UA@mail.gmail.com>
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

> Well, yes, mt7981_pinctrl is wrong since it is not actually binding
> the GPIO devices until it itself is probed. It should do it when it is
> bound.

Oh I see! Yes, I can see the mtk_gpiochip_register(dev) in  
mtk_pinctrl_common_probe() exactly as you say.

> Better still, those GPIO devices should be in the devicetree and bound
> automatically by driver model. But, sigh, I see that there is no
> compatible string in the gpio subnode of pinctrl@11d00000. It should
> really have one and avoid all this pointless code and problems.
>
> mtk_pinctrl_common_probe() is misnamed, as it actually binds and then  
> probes.
>
> So (unless Linux allows a patch to add a compatible string) it needs a
> new mtk_pinctrl_common_bind() (called from mtk_pinctrl_mt7981_bind())
> which calls mtk_gpiochip_register(). Then you won't need to add your
> dev_or_flags() into mtk_pinctrl_mt7981_bind().

Yes, that makes complete sense. Many thanks! I'm very happy to write that  
patch and grab back the physical hardware to double-check on if you like?  
(Or equally happy to leave it if you'd prefer to fix yourself?)

Presumably it needs to apply to every mtk soc that uses  
mtk_pinctrl_common_probe() as they'll all be affected by this problem.

Best wishes,

Chris.
