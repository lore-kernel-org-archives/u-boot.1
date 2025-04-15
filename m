Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225B5C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 16:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F686820E8;
	Tue, 15 Apr 2025 18:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744736117;
	bh=i9o3alRWIvo0NzjG9ZoFsP/s56uEFHw8mWQ1jmrV19A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q0sxP095IA6PiVnhIIbgOV/i3vpn5nd9ouEBHbv48fdojFiUDiLy1ZHyp++F5OpVJ
	 SZkZ7IcDJCtaXWMd9YFCMz8+24S3lBbHcLgBcL4qiGS/EbXQ42jl8d3jjh80yBHhfc
	 bE93ManUqgFy9ydWSR6eDUXOzPraNFqMke7ksHiEUjjCyvKbw43GjjyPvGiWxcejf8
	 m/34kf4/vIOwlf4A7O6XHTgyt4dU96TUyuEn/np9Dx0A4+7sg2npBYVQ1RdCxUVkoq
	 Gm+1iky+DZgnqvNYbxGWa9vAmRAfbdvjGLrmNWf+/i5n196doptTN1M2y/N5YYjzkL
	 vcrureiVL6mAQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A48682102; Tue, 15 Apr 2025 18:55:16 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8036E8209C
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 18:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="R9k9w+ir"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E3147102A4BD3; 
 Tue, 15 Apr 2025 18:55:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1744736112; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=i9o3alRWIvo0NzjG9ZoFsP/s56uEFHw8mWQ1jmrV19A=;
 b=R9k9w+irE1l9dAr4jKWEVxi+atrvimgfkONWSYC59tg2vfZGWqWwjUwZSj8sUY3XhkAQPL
 Fu5J5kZ4zJQDcMnSNxXPlaFbKv89Tv/BcZSrp0AqkgLkcH8FBLXI2T6rdwFyNzPmkZC8w3
 5kiTNmik6VA6FN19JmvXcj4tVkqmm/rMyDfILlPa7gLRQ5mtojK0MH+Y4Jta8EiQqQDl57
 uPn0iFOHAsK1/zuVdOh6WkVVr9jG6jeLI/kAfjV+IfJ6KweB8d5eNnGNLKOnct926YjwMD
 vohptsJdB+evsbnu/O3XRIV0ZC/gSYX2qbDqVHpTtmc3cEgGVnnQF2aXf+hY5g==
Message-ID: <b396cb96-ff95-4822-ad24-ddff2e3b6545@denx.de>
Date: Tue, 15 Apr 2025 18:50:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: [PATCH v2 16/24] clk: imx: Convert clock-osc-*
 back to osc_*
To: Francesco Dolcini <francesco@dolcini.it>, Adam Ford <aford173@gmail.com>
Cc: Fabio Estevam <festevam@denx.de>, u-boot@lists.denx.de,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-17-marex@denx.de>
 <20250415142846.GA244333@francesco-nb>
 <CAHCN7xLa5W-AtRso6RUZwZG_sfDm9CHierfzt_WfOqFjSGJZoA@mail.gmail.com>
 <20250415150344.GA246483@francesco-nb>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250415150344.GA246483@francesco-nb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/15/25 5:03 PM, Francesco Dolcini wrote:
> On Tue, Apr 15, 2025 at 09:43:12AM -0500, Adam Ford wrote:
>> On Tue, Apr 15, 2025 at 9:28 AM Francesco Dolcini <francesco@dolcini.it> wrote:
>>>
>>> Hello Marex, Fabio, all
>>>
>>> On Sun, Mar 23, 2025 at 04:58:45PM +0100, Marek Vasut wrote:
>>>> Convert clock-osc-24m back to osc_24m and clock-osc-32k back to osc_32k.
>>>> These are the clock which match clock tables in Linux. This is now
>>>> possible because the clock drivers now resolve clock names based on
>>>> clock-names DT property in the CCM DT node.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>
>>> Current USB fastboot functionality from U-Boot proper in master is broken
>>> on Verdin iMX8M Plus since commit b4734c9c333b ("clk: imx: Convert
>>> clock-osc-* back to osc_*"). Other i.MX SoCs might be affected, I have
>>> not looked into every detail.
>>>
>>>    Could not fetch index
>>>    Failed to get PHY0 for usb@38100000
>>>    Could not fetch index
>>>    Failed to get PHY0 for usb@38100000
>>>    No USB device found
>>>    USB init failed: -19
>>>
>>> Reverting this commit on top of master is not trivial (there are
>>> conflicts, and I have not looked into the details).
>>>
>>> Full log for reference
>>>
>>>    U-Boot SPL 2025.04-rc4-00537-gb4734c9c333b (Apr 15 2025 - 16:14:09 +0200)
>>>    Training FAILED
>>>    DDR configured as single rank
>>>    WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
>>>    SEC0:  RNG instantiated
>>>    Normal Boot
>>>    Trying to boot from BOOTROM
>>>    Boot Stage: USB boot
>>>    Find img info 0x4802ec00, size 1116
>>>    Need continue download 1024
>>>    NOTICE:  Do not release JR0 to NS as it can be used by HAB
>>>    NOTICE:  BL31: v2.12.0(release):v2.12.0-946-g4d913df8f85e
>>>    NOTICE:  BL31: Built : 13:19:07, Apr 15 2025
>>>
>>>
>>>    U-Boot 2025.04-rc4-00537-gb4734c9c333b (Apr 15 2025 - 16:14:09 +0200)
>>>
>>>    CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
>>>    CPU:   Industrial temperature grade (-40C to 105C) at 56C
>>>    Reset cause: POR
>>>    DRAM:  4 GiB
>>>    Core:  309 devices, 31 uclasses, devicetree: separate
>>>    WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
>>>    MMC:   FSL_SDHC: 1, FSL_SDHC: 2
>>>    Loading Environment from nowhere... OK
>>>    In:    serial@30880000
>>>    Out:   serial@30880000
>>>    Err:   serial@30880000
>>>    Model: Toradex 0058 Verdin iMX8M Plus Quad 4GB WB IT V1.0B
>>>    Serial#: 06849144
>>>    Carrier: Toradex Dahlia V1.1A, Serial# 10763256
>>>    SEC0:  RNG instantiated
>>>    Setting variant to wifi
>>>    Net:   pca953x gpio-expander@21: Error reading output register
>>>    eth1: ethernet@30be0000, eth0: ethernet@30bf0000 [PRIME]
>>>    Hit any key to stop autoboot:  0
>>>    Could not fetch index
>>>    Failed to get PHY0 for usb@38100000
>>>    Could not fetch index
>>>    Failed to get PHY0 for usb@38100000
>>
>> When running my 8M Plus in Host mode, I got similar "Failed to get
>> PHY0 for usb" failures, but I hadn't yet bisected it.  The PHY itself
>> doesn't appear to have a clock reference itself, but it does reference
>> a power-domain which uses multiple clocks. I wonder if one of the
>> clocks in the hsio power domain isn't registering properly.   I won't
>> be near my 8MP until much later tonight, but can you run 'dm tree' to
>> see what clocks are enumerated and which might be missing?
> 
> Here the logs,
> https://gist.github.com/dolcini/035ede9e94026c8f7f34e64ee07e124b
> 
> commit bcb141d11428 ("clk: imx: Pass struct udevice into
> imx_clk_composite*()") is the last good, commit b4734c9c333b ("clk: imx:
> Convert clock-osc-* back to osc_*") is the first bad.
Do you have af9cdd1ccd2d ("Revert "arm64: dts: imx8mn: Include 32kHz 
oscillator clock in SPL DTs"") in place ? If so, try and revert it, does 
it help ?
