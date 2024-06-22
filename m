Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3164DC27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 11:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B7FD87AD2;
	Sat, 22 Jun 2024 13:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B634287A09; Sat, 22 Jun 2024 13:04:17 +0200 (CEST)
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
 by phobos.denx.de (Postfix) with ESMTP id E54F087B4D
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 13:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=arachsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chris@arachsys.com
Received: from [31.94.8.245] (helo=smtpclient.apple)
 by delta.arachsys.com with esmtpa (Exim 4.80)
 (envelope-from <chris@arachsys.com>)
 id 1sKyXS-0007kK-8R; Sat, 22 Jun 2024 12:04:10 +0100
Content-Type: text/plain;
	charset=us-ascii;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Subject: Re: [PATCH RFC] gpio: Fix probing of gpio-hogs
From: Chris Webb <chris@arachsys.com>
In-Reply-To: <20240620201617.GA3566532@bill-the-cat>
Date: Sat, 22 Jun 2024 12:04:14 +0100
Cc: Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Content-Transfer-Encoding: 7bit
Message-Id: <12A8F8B4-C25C-4056-919F-005344CC3E86@arachsys.com>
References: <0b24ac9c0f40ba2410529ee6e0ffd603c9453cff.1718275638.git.chris@arachsys.com>
 <20240620201617.GA3566532@bill-the-cat>
To: Tom Rini <trini@konsulko.com>
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

Tom Rini <trini@konsulko.com> wrote:

> Adding Marek, as the author of commit 48b3ecbedf82 ("gpio: Get rid of
> gpio_hog_probe_all()").

Thanks! I don't claim this is the correct way to fix this, just that it  
works.

Specifically, the two things I found that got gpio-hog working were

   (a) adding an explicit probe instead of DM_FLAG_PROBE_AFTER_BIND in gpio_post_bind(), or

   (b) adding a .bind function in U_BOOT_DRIVER(mt7981_pinctrl) like

     static int mtk_pinctrl_mt7981_bind(struct udevice *dev)
     {
     	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
     	return 0;
     }

However, presumably (b) isn't right as it would (presumably) need  
repeating in lots of other pinctrl drivers?

Best wishes,

Chris.
