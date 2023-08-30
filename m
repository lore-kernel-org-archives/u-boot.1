Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF55AC83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 15:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA968643D;
	Wed, 30 Aug 2023 17:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693408327;
	bh=G/0T1qtXjoNvpqFqoL1+ZXJP1T6eY7OF3aAgDa9WhJs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=swEN7J6fLig59snsAWtOblY/6MBCQcjhJSjxxUqU3JEZx6NNkpuejuhVEot4Fbg3z
	 cl1/AT90UvZst+LNTUaERW3Olus4CmlZcuaKm4IftTMkqnuOcwRyGnE1FErBz793XY
	 XZZtdZQjD16MQTQJVFGI7JQlfmTbPSx4QSvj4jbl8kuLJR1tvhRAMHCRqz+gC2oO5r
	 8/R+/t/Ikih5vufusSpo/C3OWon35zP/alYn3CLG1zfiDMw1VxpPpfO7u40aFhwe04
	 87dlD9XWk2EcK/R47BgNqeiWb1oth/vtjvFG3lLcCJqO1gUBcfSsKav1Czgvb8o5VC
	 tT1H92b7IFxjA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F145C863DD;
 Wed, 30 Aug 2023 17:12:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693408327;
 bh=G/0T1qtXjoNvpqFqoL1+ZXJP1T6eY7OF3aAgDa9WhJs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=z0K2KY1+wl2EDEGptq9X00akNJfGWLkGAhjv4YhSFWr+ivArCP12x2bLDlkeexp/P
 lFdiaoCmqLPwt6GH+OZ2DPMimXV7K8ChIQ1SLnq/M8uhPBlaiRyyJmWlXgjM9TGwHZ
 w2KYkeTn12tlLgaMq0Wc8hrHlvoRSs/ck7ipfwxrDzKZm4Ml9ISSTAmwZawX9eao2L
 ds3ykvLhfLZB5xN+yYVp7qyaQvuiAgulKufJLVKfvde0PHGThOHpYZJ8x397+thrAV
 AjITfZvtSFmH1ko2qvpRBhtCZQScbAobKryQnzkSo9rtvWIdz/kEiKDI/PrbFEFE4E
 /QJywBqaBkp/w==
Message-ID: <4e4f480f-8f97-cf8a-fb55-8d1ebaffb993@denx.de>
Date: Wed, 30 Aug 2023 17:12:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] usb: host: ehci-generic: check for companion controller
Content-Language: en-US
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, u-boot@lists.denx.de
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>
References: <20230830080008.455157-1-fabrice.gasnier@foss.st.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230830080008.455157-1-fabrice.gasnier@foss.st.com>
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

On 8/30/23 10:00, Fabrice Gasnier wrote:
> EHCI is usually used with companion controller (like OHCI) as companion
> controller. This information on the companion is missing currently in
> companion drivers.
> So, if the usb-uclass isn't aware, it may scan busses in any order: OHCI
> first, then EHCI.
> This is seen on STM32MP1 where DT probing makes the probe order to occur
> by increasing address (OHCI address < EHCI address).
> 
> When a low speed or full-speed device is plugged in, it's not detected as
> EHCI should first detect it, and give ownership (handover) to OHCI.
> 
> Current situation on STM32MP1 (with a low speed device plugged-in)
> STM32MP> usb start
> starting USB...
> Bus usb@5800c000: USB OHCI 1.0
> Bus usb@5800d000: USB EHCI 1.00
> scanning bus usb@5800c000 for devices... 1 USB Device(s) found
> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
>         scanning usb for storage devices... 0 Storage Device(s) found
> 
> The "companion" property in the device tree allow to retrieve companion
> controller information, from the EHCI node. This allow marking the
> companion driver as such.
> 
> With this patch (same low speed device plugged in):
> STM32MP> usb start
> starting USB...
> Bus usb@5800c000: USB OHCI 1.0
> Bus usb@5800d000: USB EHCI 1.00
> scanning bus usb@5800d000 for devices... 1 USB Device(s) found
> scanning bus usb@5800c000 for devices... 2 USB Device(s) found
>         scanning usb for storage devices... 0 Storage Device(s) found
> STM32MP> usb tree
> USB device tree:
>    1  Hub (12 Mb/s, 0mA)
>    |   U-Boot Root Hub
>    |
>    +-2  Human Interface (1.5 Mb/s, 100mA)
>         HP HP USB 1000dpi Laser Mouse
> 
>    1  Hub (480 Mb/s, 0mA)
>       u-boot EHCI Host Controller
> 
> This also optimize bus scan when a High speed device is plugged in, as
> the usb-uclass skips OHCI in this case:
> 
> STM32MP> usb reset
> resetting USB...
> Bus usb@5800c000: USB OHCI 1.0
> Bus usb@5800d000: USB EHCI 1.00
> scanning bus usb@5800d000 for devices... 2 USB Device(s) found
>         scanning usb for storage devices... 1 Storage Device(s) found
> STM32MP> usb tree
> USB device tree:
>    1  Hub (480 Mb/s, 0mA)
>    |  u-boot EHCI Host Controller
>    |
>    +-2  Mass Storage (480 Mb/s, 200mA)
>         SanDisk Cruzer Blade 03003432021922011407
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> 
>   drivers/usb/host/ehci-generic.c | 24 ++++++++++++++++++++++++

More of a design question -- shouldn't the usb-uclass handle this 
property ad manipulate with private data of "remote" devices instead ?
