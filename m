Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EC2C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 20:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6AA83FEE;
	Sat, 27 Jun 2026 22:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oTYCSApg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B486D841C2; Sat, 27 Jun 2026 22:10:18 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C57A80398
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 22:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gnkDQ70QSz9tgl;
 Sat, 27 Jun 2026 22:10:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1782591015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iksm5UzNgZvyH3rsIyADMsDwxARwnBVmbhOwgU1GUkQ=;
 b=oTYCSApgSdMUn75pSy50gtkjWEIxEIbobhiUpqkUvcYbYsdX7irjqVE9ylQ9XKRKv/sHkF
 QnA9CrU5HwO5xhCBWXrahCEmOC0ZdolkLF7p4yRXYAxv1MrT6xTaJ19NYShQb7pnJMiOED
 5RfWLaqG1SnENmMm7nyoQHR3iUc+y2lrILlU1S1qs/tSDEdtGRCYvJe3D0v4crJNFcRV9E
 fXSb/yMCSxJjZdM+NKJ/Q5/IJxJ+cwMMpqrH/ystRDj24MzlW2BSRYj6i+5Fgcp59lyinJ
 x8aRqemzG0VeF+zx3SfIyF4E7nCkLfSMyvSQJM7yOiamKIrzAg7tOu/UT/j+Ow==
Message-ID: <dc5ecf1c-ee61-4434-a19b-966f287f1533@mailbox.org>
Date: Sat, 27 Jun 2026 22:10:13 +0200
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] usb: xhci: Fix bNbrPorts overwritten by another controller
To: Beibei Yang <13738176232@163.com>, u-boot@lists.denx.de
Cc: bmeng.cn@gmail.com
References: <1782563839-11379-1-git-send-email-13738176232@163.com>
Content-Language: en-US
In-Reply-To: <1782563839-11379-1-git-send-email-13738176232@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b0017be307fcdfb8fa9
X-MBO-RS-META: sutoiqz5u57diimwbjynmbsnbkk11f7f
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

On 6/27/26 2:37 PM, Beibei Yang wrote:
> In a system with multiple XHCI controllers, the global descriptor.hub
> (bNbrPorts) can be overwritten by a later initialized controller,
> causing the root hub of an earlier controller to report wrong port
> numbers.
> 
> Fix this by dynamically setting bNbrPorts from the current controller's
> hcsparams1 in the USB_DT_HUB request handler, instead of relying on
> a stale global value.

How about having one descriptor per controller ?

This is probably easily doable in xhci_lowlevel_init() with some 
ctrl->hub_desc = kmemdup(descriptor.hub,...); and related tweaks.

What do you think ?
