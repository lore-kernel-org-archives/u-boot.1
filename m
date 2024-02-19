Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06731C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 18:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62E6D87F53;
	Mon, 19 Feb 2024 19:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708367094;
	bh=qXyHT2x4wz9kDLBqcZhv0Xc8nurYkYP0N1G2UZfZKw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DI05ETRdGkHeVyK1WnB0T6QZEmRbE1+ATqiDMqtBksFrEJLeIXe6MFV123/I1dN6+
	 h386Hve3PHRWWI4G/YNf0vNz5H5VFuqYmEyW//kmoqeb/AgdFOpEhODW7bQvSISz+K
	 8cVCK06FvZWKl/AYAtbKxBb07GmhrPA9Z1pjfZ5CVHGVzWWmoUPuJNAcHhQSnhJ6yU
	 5lEOLvUlbEMGe+FpEFKtSeJVQW22wbji/eiGjcSnQ45Wx+YWwDQR6k8FaHdEjK0Uup
	 V4P41piX9y0E2ix/oPHeSN/mVMnRK/wVFqhFSeuPUAOakSVApBfXG5LOl0H7YGdZe+
	 vCLrTQrH10oFQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6E46787DB7;
 Mon, 19 Feb 2024 19:24:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708367093;
 bh=qXyHT2x4wz9kDLBqcZhv0Xc8nurYkYP0N1G2UZfZKw4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HBKDs2WWhPg3XnyvueJU2DLtAaXQEYeErI1iSQWfJhI1gf5BPsKp6dc1eW5NkZgh4
 A28TOSBchN1WgHMXE2qzROn1OBxx+bGCN62GL/G20kIZPZCWSwotETw2tGJjihcn3s
 PKop2PP2ymSnusdbELqCTI1wsSsUoKrBFfoKGoEiKAwuBki2BLR2HqCFngWbkhQ8wx
 CgFDHW/3l1rbcLYTzpFPU7C9v+dW9ZRDG18S8xu+5sivVM5AakNBT6+/SdpaZ569b+
 uajWvD61s2385BDY54H2HUm4r/Vt6f9mmt1cPOFEK7iuKade9CbVEGTrB2niosZNQx
 WE2YskIS89cnw==
Message-ID: <053161b6-3eee-4c48-b163-70b22bd116bc@denx.de>
Date: Mon, 19 Feb 2024 19:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] common: usb-hub: Reset USB 3.0 hubs only
To: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
Cc: dsimic@manjaro.org, andre.przywara@arm.com,
 Hector Martin <marcan@marcan.st>, Tom Rini <trini@konsulko.com>
References: <20240214095403.53051-1-i@shantur.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240214095403.53051-1-i@shantur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 2/14/24 10:54, Shantur Rathore wrote:
> Additional testing of the changes introduced in commit 33e06dcbe57a "common:
> usb-hub: Reset hub port before scanning") revealed that some USB 2.0 and 3.0
> flash drives didn't work in U-Boot on some Allwinner SoCs that support USB
> 2.0 interfaces only.  More precisely, some of the tested USB 2.0 and 3.0
> flash drives failed to be detected and work on an OrangePi Zero 3, based on
> the Allwinner H616 SoC that supports USB 2.0 only, while the same USB flash
> drives worked just fine on a Pine64 H64, based on the Allwinner H6 SoC that
> supports both USB 2.0 and USB 3.0 interfaces.
> 
> The USB ID of the above-mentioned USB 3.0 flash drive that failed to work is
> 1f75:0917 (Innostor Technology Corporation IS917 Mass storage), it is 32 GB
> in size and sold under the PNY brand.  The mentioned USB 2.0 drive is some
> inexpensive no-name drive with an invalid USB ID.
> 
> Resetting USB 3.0 hubs only, which this patch introduces to the USB hub
> resets, has been tested to work as expected, resolving the identified issues
> on the Allwinner H616, while not introducing any new issues on other tested
> Allwinner SoCs.  Thus, let's fix it that way.
> 
> According to the USB 3.0 specification, resetting a USB 3.0 port is required
> when an attached USB device transitions between different states, such as
> when it resumes from suspend.  Though, the Linux kernel performs additional
> USB 3.0 port resets upon initial USB device attachment, as visible in commit
> 07194ab7be63 ("USB: Reset USB 3.0 devices on (re)discovery") in the kernel
> source, to ensure proper state of the USB 3.0 hub port and proper USB mode
> negotiation during the initial USB device attachment and enumeration.
> 
> These additional types of USB port resets don't exist for USB 2.0 hubs,
> according the USB 2.0 specification.  The resets seem to be added to the USB
> 3.0 specification as part of the port and device mode negotiation.
> 
> The Linux kernel resets USB 3.0 (i.e. SuperSpeed) hubs only, as visible in
> commit 10d674a82e55 ("USB: When hot reset for USB3 fails, try warm reset.")
> in the kernel source.  The check for SuperSpeed hubs is performed in a way
> that also applies to newer SuperSpeed Plus (USB 3.1 or 3.2) hubs as well,
> which hopefully makes it future proof.
> 
> Fixes: commit 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")
> 
> Link:
> https://lore.kernel.org/u-boot/20240207102327.35125-1-i@shantur.com/T/#u
> Link:
> https://lore.kernel.org/u-boot/20240201164604.13315fa6@donnerap.manchester.arm.com/T/#u
> 
> Signed-off-by: Shantur Rathore <i@shantur.com>
> Helped-by: Dragan Simic <dsimic@manjaro.org>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Reviewed-by: Marek Vasut <marex@denx.de>
