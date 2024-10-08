Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4563CEFC31
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 16:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9B8988E84;
	Tue,  8 Oct 2024 18:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728405548;
	bh=Y1tvEfG0GA+oom4jQEfEIBx6ObA6iJOF6xLI1blJPys=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uPWQp0AHh4GvF/IPR1nD+sppEYt+v3DqGRiUWli5+qCgPokunydBrp4uKpoIfSXTy
	 EPU78EQwYeGQ7G4bs9a5RiWNvjOUxUbzDvgjdhT7vuuW47WdTlClMvnMWtXIIsowqr
	 2mcGJZsBn3e2vwf3hxHfkxPYPwCIv0zIwlY21hvjC8q25G5Y0n62dqK3FrJCuokOnY
	 5Q3LhOt1TYXW3EJzAUc5a9O2rTSAz2tOQ9kn7YeC2NS6BsBHmXgnvGxqYWjWro/9tp
	 uZ0v/yiLzLDXg3ooApS+NU24AAU6Lf4otIw54q7uNV/dRcC3109+0rsgu/iZlJdnH6
	 WvaHmpE1faVQg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E987F88DD9;
 Tue,  8 Oct 2024 18:39:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728405546;
 bh=Y1tvEfG0GA+oom4jQEfEIBx6ObA6iJOF6xLI1blJPys=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WkhIGqDhrBCZw2JmUnVYO2IoMYyEjvzwgtBtLHEqxOJcSp1VTpTlieUS39U5oQza3
 s8VU36IC2jMcR0JKu/lEtuTT1tw/aKs3B4D/lO95KHyTjok8MJ+JR0p6gR1pwwlwOw
 ix1oQrV0Dzs64vD0qeB0et9nVuB3S4mURAwCoZVkN5ryqr24ndzp0SA3mcgCpMjZn/
 5jUGC26U6hRYTk6yRU9j+rCU5Wt5yi2d4d9ifRRqHSwQUHXKWCDca9wkkYCRYkwNQi
 RvRGp0vnyPIyd8j7MxooSSZpAVC0rJ30UzZK0Zv5VCljRFO0mxrDHujplAbH60A1SJ
 VQWUg3HVl/E1g==
Message-ID: <46e6d21c-869a-4e73-beda-897b04127239@denx.de>
Date: Tue, 8 Oct 2024 18:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] usb: onboard-hub: Add i2c initialization for
 usb5744 hub
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
 <20241008154139.31204-5-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241008154139.31204-5-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/8/24 5:41 PM, Venkatesh Yadav Abbarapu wrote:
> Add i2c initialization hook and set usb5744 platform
> data with function having required i2c initialization sequence.
> 
> Apart from the USB command attach, prevent the hub from suspend.
> when the “USB Attach with SMBUS (0xAA56)” command is issued to the hub,
> the hub is getting enumerated and then it puts in a suspend mode.
> This causes the hub to NAK any SMBUS access made by the SMBUS Master
> during this period and not able to see the hub's slave address while
> running the "i2c probe" command.
> 
> Prevent the MCU from the putting the HUB in suspend mode through register
> write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2 register at
> address 0x411D controls this aspect of the hub. The BYPASS_UDC_SUSPEND
> bit in register 0x411Dh must be set to ensure that the MCU is always
> enabled and ready to respond to SMBus runtime commands. This register
> needs to be written before the USB attach command is issued.
> The byte sequence is as follows:
> Slave addr: 0x2d           00 00 05 00 01 41 1D 08
> Slave addr: 0x2d           99 37 00
> Slave addr: 0x2d           AA 56 00
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
