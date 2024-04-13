Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FABAC4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 06:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1B087E62;
	Sat, 13 Apr 2024 08:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wdzcXDLB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99E8E87D98; Sat, 13 Apr 2024 08:02:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F02F87E62
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 08:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gregkh@linuxfoundation.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0DA77612DF;
 Sat, 13 Apr 2024 06:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F0C113CD;
 Sat, 13 Apr 2024 06:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1712988131;
 bh=f/YJj4fPab2A7saEk9AGld0OW8r+zNmrnA+f6vcNuP0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wdzcXDLBPWwKMRI4iUYf0RiZMLPihTD7FdfjPvs29Xq4bIQeIP2nQU0B8TwN7Od8E
 3B3yqwV62KrHa46oxBMz64N41Zh2qAJXHXEaF+uZzMqBl8o7IYN2w4DVMltmgZC3+1
 H4heOtB8lTnIBckzgU1IbJSaJ6t52NPxZbD2QTZc=
Date: Sat, 13 Apr 2024 08:02:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: u-boot@lists.denx.de, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Marek Vasut <marex@denx.de>, Felipe Balbi <felipe.balbi@linux.intel.com>,
 Nishanth Menon <nm@ti.com>, Sjoerd Simons <sjoerd@collabora.com>
Subject: Re: [PATCH 6/6] usb: dwc3: gadget: Disable GUSB2PHYCFG.SUSPHY for
 End Transfer
Message-ID: <2024041354-exciting-suggest-b896@gregkh>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
 <20240412202611.3565052-7-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412202611.3565052-7-alexander.sverdlin@siemens.com>
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

On Fri, Apr 12, 2024 at 10:26:06PM +0200, A. Sverdlin wrote:
> From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> Upstream Linux commit 3aa07f72894d.
> 
> If there's a disconnection while operating in eSS, there may be a delay
> in VBUS drop response from the connector. In that case, the internal
> link state may drop to operate in usb2 speed while the controller thinks
> the VBUS is still high. The driver must make sure to disable
> GUSB2PHYCFG.SUSPHY when sending endpoint command while in usb2 speed.
> The End Transfer command may be called, and only that command needs to
> go through at this point. Let's keep it simple and unconditionally
> disable GUSB2PHYCFG.SUSPHY whenever we issue the command.
> 
> This scenario is not seen in real hardware. In a rare case, our
> prototype type-c controller/interface may have a slow response
> triggerring this issue.
> 
> Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Link: https://lore.kernel.org/r/5651117207803c26e2f22ddf4e5ce9e865dcf7c7.1668045468.git.Thinh.Nguyen@synopsys.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Confused, why did you resend this to us?
