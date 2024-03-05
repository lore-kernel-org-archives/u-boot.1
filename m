Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23268C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 18:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE3B8810E;
	Tue,  5 Mar 2024 19:54:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709664857;
	bh=m+EsjXjaR4MsTxIiSXikAzNQuGqDAzze5Gp5vgGP3Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yx8sQomcJpjKQLnpGoES/9U9MTM1Fn4JsEJ/r9bEY3yf1qqqCCrFP4VGS6ePcP0p4
	 kfs90eiASpTzaEvR20tuxrgHs4fycerFkTe+1pjdo1XpN8+xI0L0u5LPHS0ugev2Oh
	 tUOIw9cadLAXk4SE7rFDvfvtn0XU+LE+4NZ/chvMNF1oZP1OsN5DWk6zCBrhi/RXNT
	 pcxrn1+/+QADPN6jqGTf7HDxhX/XP2DazXnp6oZM/XqEiFuKK/GmjI4LGoU/wERVbG
	 oCaYHqkbJVl/FMb4U5uWRaiTW1lBBYQ9OulA1t9r/7BzMGM/gpV7XIsVa4H5pdIXxU
	 o8e/V/dSLCC1w==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A8A0C87FA0;
 Tue,  5 Mar 2024 19:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1709664856;
 bh=m+EsjXjaR4MsTxIiSXikAzNQuGqDAzze5Gp5vgGP3Po=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DZlYBzGFIDvBPuon6+SmJDadoWSGwe538ZMzvrTzlu7VDpIXYtrKLBRsNtNltF5HG
 azoxMVOpyUJO9RKMunjWbVo0/023GfBghMQZ5Qmdl+KlfM8z2z2k/UFMdv/sJFRyMj
 jHh5cVzPUgS18n0coTeSSqMyRDMgBas8nl5XVy7EkfY8tA2jZMgpi16wIU+wsotGwl
 QRf4EAm3b97nyIj1u9Zr6+cYB/bQHQsQRQGXudgXmX4cWYuO+bWlp5E0acmwlEuZwT
 0J03n3uEbH01wCL5H78oFtD7NH0ks0y8Mkf0RHOm2R9laNW7y4VjP2KtOnjf2zSUAO
 yoFAUZxG97OqQ==
Message-ID: <d522ac8e-8664-4798-9069-947691c6cd43@denx.de>
Date: Tue, 5 Mar 2024 19:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
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
 <faa78709-6b7c-4394-8048-3c1f09b65a04@denx.de>
 <CZLZ391C9O5F.38A18T9S51BNT@walle.cc>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CZLZ391C9O5F.38A18T9S51BNT@walle.cc>
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

On 3/5/24 5:55 PM, Michael Walle wrote:

[...]

>>>>>> Clearing this SR3 WPS bit fixes that problem, both in U-Boot and in
>>>>>> Linux, since Linux that is booted afterward then gets a device that has
>>>>>> locking scheme configured in a way that Linux expects and can operate.
>>>>>>
>>>>>> Better yet, if some old LTS version of the Linux kernel is in use, it
>>>>>> will also work correctly, because this patch will configure the SPI NOR
>>>>>> locking scheme to what Linux expects it to be, before the SPI NOR is
>>>>>> handed over to that old kernel.
>>>>>
>>>>> Agreed, but it should *not* be done automatically and nor
>>>>> unconditionally. Please don't just overwrite any locking bits just
>>>>> because there is one flash which have it set.
>>>>
>>>> The unlock code is not triggered unconditionally, it is protected by
>>>>
>>>> if (IS_ENABLED(CONFIG_SPI_FLASH_UNLOCK_ALL)...
>>>>
>>>> Kconfig option, so this can be turned on/off in board config already.
>>>
>>> Ahh, OK then :)
>>>
>>> But keep in mind that enabling this option is foobar and I've gone
>>> lengths to eliminate it in linux. And actually made that option in
>>> u-boot.
>>>
>>> See linux commit 31ad3eff093c ("mtd: spi-nor: keep lock bits if they
>>> are non-volatile").
>>
>> So, how shall we proceed here?
> 
> Regarding this patch, I think it's fine. It will unlock the whole
> flash as advertised.

This change won't unlock the flash, it will switch to the supported 
locking scheme, one which can then be used to unlock the flash.

> But u-boot should really consider making that a "default n" option.
> And most likely adding =y to every existing defconfig out there so
> that at least new boards will benefit from it.

Yes, I agree with that.

>> The way I see this, if Linux ever implements this scheme, Linux can set
>> the SR3 WPS bit as needed, it does not matter which way bootloader sets
>> the bit as the protection bits are not cleared when the bit is cleared,
>> they seem to be stored elsewhere.
> 
> On each reboot you'd wear out that cell with two erases/writes.
> That's another reason why that whole unlocking thing is foobar for
> non-volatile bits. For me, non-volatile bits are for provisioning,
> so during a normal boot they should not be touched at all. Just
> during board manufacturing or because the user actively want to
> protect something.

That is what happens here, the write to clear the bit is triggered only 
if the bit is set , so OK .

And if Linux wants to use the new locking scheme, then the bootloader 
should ideally be updated to match, i.e. SPI_FLASH_UNLOCK_ALL=n etc, so 
that is also OK .

In other words, there should be no writes into the non-volatile bits, 
unless U-Boot and Linux disagree on the locking scheme, in which case 
writes are unavoidable (if you want unlock to work in both projects).

> If you clear this bit during the unlock all command, all the locking
> bits are cleared anyway. Or do you mean, the individual bits are
> still retained?

The lock bits themselves are retained, this SR3 WPS only selects which 
of those bits take effect, whether the SR ones (standard locking scheme) 
or the per-page ones (winbond custom locking scheme).

>> But, if Linux starts to use SR3 WPS, then U-Boot should be updated to
>> match, i.e. both projects should agree on the locking scheme, so that
>> there won't be a situation where on the same device, one project uses
>> one scheme, the other project uses another scheme. I think this would
>> technically work, but it would be horrible from the user perspective.
>> And if that happens, both projects should then be updated in lockstep
>> and this UNLOCK_ALL should be disabled for such a setup then.
> 
> If you don't touch it, I don't think you have a problem here. u-boot
> and linux can support different schemes, as long as the user is
> aware of that. I.e. if they want to lock a region and the flash is
> configured in a mode which isn't supported in u-boot (or linux) it
> should be rejected. There might of course be a command to switch the
> scheme if someone want to do so.

That is why I wrote that it is technically possible, but probably not a 
good idea because it is inconsistent and therefore error prone.
