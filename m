Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9575BCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EA3486E7C;
	Tue, 17 Oct 2023 14:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2669E86EA6; Tue, 17 Oct 2023 14:45:19 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8E31286E33
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 14:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C702F4;
 Tue, 17 Oct 2023 05:45:56 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDEC93F5A1;
 Tue, 17 Oct 2023 05:45:14 -0700 (PDT)
Date: Tue, 17 Oct 2023 13:44:04 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: SASANO Takayoshi <uaa@mx5.nisiq.net>
Cc: "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov
 <iuncuim@gmail.com>
Subject: Re: [PATCH RESEND] sunxi: add axp313a support
Message-ID: <20231017134404.63305833@slackpad.lan>
In-Reply-To: <87cyxdr3kd.wl-uaa@mx5.nisiq.net>
References: <875y4u9b3t.wl-uaa@mx5.nisiq.net>
 <20230908102404.3f386a43@donnerap.manchester.arm.com>
 <87cyxdr3kd.wl-uaa@mx5.nisiq.net>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 17 Oct 2023 18:38:58 +0900
SASANO Takayoshi <uaa@mx5.nisiq.net> wrote:

Hi,

> Hello, sorry for late reply!

no worries, glad you came back!

> > Anyway, my plan is to not add anything to the SPL code in its current
> > shape anymore, instead do some refactoring first, then have a much cleaner
> > and smaller patch with the AXP313a support. I am more than halfway through
> > with that, just stuck on some nasty preprocessor problem. I will post
> > something once that's ready, and will then CC: you, so you can add the
> > AXP313 parts on top, if you like.  
> 
> Sounds good, current complicated PMIC should be cleaned I think.
> If a testing staff is needed, please tell me.

Thanks! I have something easy ready, just the final touches needed.
Will CC: on the post.

> By the way, do you have any memory controller information
> when Allwinner H616 connects DDR4?
> 
> Simply adding AXP313a code make MangoPi MQ-Quad working,
> but OrangePi Zero3 requires setting up memory controller for DDR4.
> 
> At least sunxi's binary blob (boot0) can do this, no source code.

Yes, we have been looking at this for a while, and there is code out
there. The latest drop is from Mikhail:
https://lore.kernel.org/u-boot/20231016053441.3197087-2-iuncuim@gmail.com/
If you can try this, maybe even review it, that would be great.

Cheers,
Andre
