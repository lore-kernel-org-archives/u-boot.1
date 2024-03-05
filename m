Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C22C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 16:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A98E8808D;
	Tue,  5 Mar 2024 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709656123;
	bh=Wlv7aMZ1byr+rPmief0LO86Tq0xeItjMgWZogFWfhlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0zud5dEZ/dc2THCihgGJITuB2KFtXA2wuTHuW4TUpSuvnuqMWRWo4gxqJiFJxLN6
	 ZOSql5AgN6UhonNnJQtEFq30XJvF3PjbbWiscQ47bXv7GCfNJn89MSnEHnmnrkCrc9
	 gJ3HMDxeiDoOIp2Ya8CJEe4kQuVSiXl/0mJ4I246iAt9hj5sAa5VE2t+SKHfnGYZj3
	 wNrUCc76TkD8eejVN2EqTd2/LWuCYARffU5xH51+Ndc51skslo0mVtj8ksZDmw5PpM
	 JWmVj8lPD68IfGchyWsX4pxcCk7WyuVYDO5sDh8A/LpIZZZA4Tr65eluyzYlvI+8IV
	 Oxh3eix0iEa4A==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 20E4087FA5;
 Tue,  5 Mar 2024 17:28:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709656122;
 bh=Wlv7aMZ1byr+rPmief0LO86Tq0xeItjMgWZogFWfhlg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aHlqLXe6X870Bd42U1UlF2Kdi71fX8Y4w7djQU8lfgpZBCDTss/+WA31h/jZ6kIT9
 eQak/4NwQDuZ+50oQbVgzAkSzU825yrNiIsqW89BYbaRHjnJ0U+bJoh1tWXBgL7gHe
 ojInglHE6mMh2b4ZLSbgzze3wgKDD/8OJgmUV24dd275wZ7yiA8ZtJH7VD29DyMJ2y
 LQkHd0jNVQ2C+pFkallA0GCnD64WLKUUhsccJefNR2MUwS+bfbIAejHjpWiDqNqTkC
 cKsSjBQJKg9bqzre/T8ccbL4MYxoBm65+TQR0l9g+1H37mzOuUzjbBldgLix3s7pXA
 SvegWAfe7ebVw==
Message-ID: <faa78709-6b7c-4394-8048-3c1f09b65a04@denx.de>
Date: Tue, 5 Mar 2024 17:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
Content-Language: en-US
To: Michael Walle <michael@walle.cc>, u-boot@lists.denx.de
Cc: Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, linux-mtd@lists.infradead.org
References: <20240304161607.82759-1-marex@denx.de>
 <CZLOVK212G8L.2ISEL1IIWU1YE@walle.cc>
 <7c0e2496-4338-497d-96cf-41d75e2fc52b@denx.de>
 <CZLTVKVR3AG1.BZIQQU2PYSU6@walle.cc>
 <a28b0543-67ee-4e33-91c1-86ae36eb44d5@denx.de>
 <CZLXRLFU5YKU.1S5D9EZ3GUTH4@walle.cc>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CZLXRLFU5YKU.1S5D9EZ3GUTH4@walle.cc>
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

On 3/5/24 4:53 PM, Michael Walle wrote:
> On Tue Mar 5, 2024 at 4:37 PM CET, Marek Vasut wrote:
>> On 3/5/24 1:50 PM, Michael Walle wrote:
>>> Hi Marek,
>>
>> Hi,
>>
>>> On Tue Mar 5, 2024 at 1:31 PM CET, Marek Vasut wrote:
>>>> On 3/5/24 9:55 AM, Michael Walle wrote:
>>>>> On Mon Mar 4, 2024 at 5:16 PM CET, Marek Vasut wrote:
>>>>>> Some Winbond SPI NORs have special SR3 register which is
>>>>>> used among other things to control whether non-standard
>>>>>> "Individual Block/Sector Write Protection" (WPS bit)
>>>>>> locking scheme is activated. This non-standard locking
>>>>>> scheme is not supported by either U-Boot or Linux SPI
>>>>>> NOR stack so make sure it is disabled, otherwise the
>>>>>> SPI NOR may appear locked for no obvious reason.
>>>>>
>>>>> I don't think it is a good idea to just disable the WPS bit.
>>>>> Usually, that bit is non-volatile and the default is not set.
>>>>
>>>> Yes, that's right, the bit is non-volatile and should not be set unless
>>>> the MTD stack can handle it correctly. Currently, neither U-Boot nor
>>>> Linux does handle the bit at all, instead both attempt to use the
>>>> standard SPI NOR locking scheme which is also implemented by this SPI
>>>> NOR model and they both fail to unlock the SPI NOR that way.
>>>>
>>>> Note that the SR3 WPS bit only switches between two different locking
>>>> schemes (unset = standard SPI NOR locking scheme, set = custom winbond
>>>> locking scheme), setting SR3 WPS does not immediately imply the SPI NOR
>>>> is locked, rather the opposite. Out of manufacturing, the SPI NOR is
>>>> unlocked in either locking scheme. Depending on the SR3 WPS bit state,
>>>> different commands are used to lock and unlock the SPI NOR.
>>>>
>>>> I recently ran across a device which had the SR3 WPS bit incorrectly set
>>>> out of manufacturing of that device (i.e. before it was populated on a
>>>> board at board manufacturer) and the device was locked using the custom
>>>> locking scheme. I was not able to unlock or use that device because both
>>>> U-Boot and Linux tried to use the standard scheme for that purpose.
>>>
>>> Still, I don't think it makes any sense, to disable that bit for all
>>> winbond flashes just because there was one vendor which set it the
>>> wrong way - or the board manufacturer didn't test it and programmed
>>> the flash correctly.
>>
>> OK
>>
>>>> Clearing this SR3 WPS bit fixes that problem, both in U-Boot and in
>>>> Linux, since Linux that is booted afterward then gets a device that has
>>>> locking scheme configured in a way that Linux expects and can operate.
>>>>
>>>> Better yet, if some old LTS version of the Linux kernel is in use, it
>>>> will also work correctly, because this patch will configure the SPI NOR
>>>> locking scheme to what Linux expects it to be, before the SPI NOR is
>>>> handed over to that old kernel.
>>>
>>> Agreed, but it should *not* be done automatically and nor
>>> unconditionally. Please don't just overwrite any locking bits just
>>> because there is one flash which have it set.
>>
>> The unlock code is not triggered unconditionally, it is protected by
>>
>> if (IS_ENABLED(CONFIG_SPI_FLASH_UNLOCK_ALL)...
>>
>> Kconfig option, so this can be turned on/off in board config already.
> 
> Ahh, OK then :)
> 
> But keep in mind that enabling this option is foobar and I've gone
> lengths to eliminate it in linux. And actually made that option in
> u-boot.
> 
> See linux commit 31ad3eff093c ("mtd: spi-nor: keep lock bits if they
> are non-volatile").

So, how shall we proceed here?

The way I see this, if Linux ever implements this scheme, Linux can set 
the SR3 WPS bit as needed, it does not matter which way bootloader sets 
the bit as the protection bits are not cleared when the bit is cleared, 
they seem to be stored elsewhere.

But, if Linux starts to use SR3 WPS, then U-Boot should be updated to 
match, i.e. both projects should agree on the locking scheme, so that 
there won't be a situation where on the same device, one project uses 
one scheme, the other project uses another scheme. I think this would 
technically work, but it would be horrible from the user perspective. 
And if that happens, both projects should then be updated in lockstep 
and this UNLOCK_ALL should be disabled for such a setup then.
