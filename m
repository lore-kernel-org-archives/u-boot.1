Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765E5CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 16:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E400283B99;
	Mon, 17 Nov 2025 17:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="TG8ojXza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF1783B9D; Mon, 17 Nov 2025 17:29:46 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C824D83A8F
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 17:29:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1763396976;
 bh=FzuvockqhJWtd9dM3qNZjSU/icuKLq3/kAlu51yF4/Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TG8ojXzaU6gamGoMO4dBjM6g0RnHI5nTp0htA8VW+qjxS2ZQNJ+h4Y74c4SLDJrKr
 j6VhLaaq0PpiwCZsfbdKacYEfsQThmxAXB2U+JPRvj44M/UBtCWpdqKXoumH5rLn95
 ev4ML1buP2bGiDu9XlovIX6bi3ujejlU6mzJ4ZnZAOHCFfuKzjrQ0SXKE4Hh7qhi9k
 9ZRy0ZMXkFwgYftMn6j9cObed2sU3l+VxcyLOKHJJ9rb+Jr9BhVAZ5mV5q4gVxCGRb
 i2RgThCjvRMBSrsSz8aoygk/dmM8QIFQwTYbO1IUpxn4dhi49eBTwJFAiEPhzoOXJC
 2diLC12yv6Z3w==
Received: from [192.168.2.54] (unknown [98.97.26.103])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 89971B2202CD;
 Mon, 17 Nov 2025 17:29:35 +0100 (CET)
Message-ID: <d0045b92-e823-4c2f-b7a5-efa7ececce37@freeshell.de>
Date: Mon, 17 Nov 2025 08:29:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Broken USB on StarFive VisionFive 2
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: E Shattow <e@freeshell.de>, Marek Vasut <marex@denx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <9d9357c5-4c09-46a4-bf33-f53399c176f9@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <9d9357c5-4c09-46a4-bf33-f53399c176f9@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


On 11/17/25 05:59, Heinrich Schuchardt wrote:
> Hello Hal, hello Minda,
> 
> USB on the StarFive VisionFive 2 is somehow broken.
> 
> The `usb start` via preboot results in an error.
> When I stop and restart USB it works.
> 
> I am on origin/master (v2026.01-rc2-41-g69cc92d6869).
> 
> I have a single USB stick plugged in. I tried with different devices.
> 
> Best regards
> 
> Heinrich
> 
> 
> starting USB...
> Register 5000420 NbrPorts 5
> Starting the controller
> USB XHCI 1.00
> Adding block device usb_mass_storage.lun0 failed, r = 20
> Bus xhci_pci: 3 USB Device(s) found
>        scanning usb for storage devices... 2 Storage Device(s) found
> Working FDT set to ff718640
> Hit any key to stop autoboot: 0
> StarFive # usb tree
> USB device tree:
>   1  Hub (5 Gb/s, 0mA)
>   |  U-Boot XHCI Host Controller
>   |
>   +-2  Hub (480 Mb/s, 100mA)
>     |   USB2.0 Hub
>     |
>     +-3  Mass Storage (480 Mb/s, 224mA)
>          SanDisk Cruzer Fit 4C530102811224103381
> 
> StarFive # part list usb 0
> 
> Partition Map for usb device 0  --   Partition Type: DOS
> 
> Part    Start Sector    Num Sectors     UUID            Type
>   1     64              4802720         00000000-01     cd
>   2     4802784         14112           00000000-02     ef Boot
>   3     4816896         56672256        00000000-03     83
> StarFive # ls usb 0:2
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> Resetting EP 3...
> WARN endpoint is halted
> WARN endpoint is halted
> WARN endpoint is halted
> 
> 0 file(s), 0 dir(s)
> 
> StarFive # usb stop
> stopping USB..
> StarFive # usb start
> starting USB...
> Register 5000420 NbrPorts 5
> Starting the controller
> USB XHCI 1.00
> Bus xhci_pci: 3 USB Device(s) found
>        scanning usb for storage devices... 1 Storage Device(s) found
> StarFive # ls usb 0:2
>             EFI/
> 
> 0 file(s), 1 dir(s)
> 
> 

Is there a different outcome with v2025.01 ? If yes, are you able to git
bisect?

-E
