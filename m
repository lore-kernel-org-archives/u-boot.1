Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21693C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 12:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39E7C87E1C;
	Wed, 21 Feb 2024 13:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708518439;
	bh=0ixdqN7XvlOqTTpq7zzBRWKWaxgr6+B/vRb/uejpJHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZHo4va/u4/sv9c3aQWgOq9UHaH0gGFwVOTYOxzNKWgdM8uYlSWPDj32XMxfDE9v20
	 vOymV7tLAaJnTsmzxMPfbDSlPzXYioA7RulzFmAmBy6Kb1rWy+x5e7uAAB60OD14CU
	 bv8a+Nu+G2KgDu5RpU13Em+3a3x5/j8uSsTJJTrMjfUR9iw9/XPLaDBejbP9l7iSac
	 PMzxFm1OkX8vtAzhsJOnysuHB7YUqzYPgAmNB+cVYkd2uVhEjVZvKfQJJgS2Oo3pB9
	 os6Mpq8JtDyVXcjEskhsrRoZyuFgObZ52zj5wNvVVC8+pDWDYd5FXSIMNhhQCvnZF8
	 bx+QxNXvbQxpg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 38EE387BBA;
 Wed, 21 Feb 2024 13:27:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708518435;
 bh=0ixdqN7XvlOqTTpq7zzBRWKWaxgr6+B/vRb/uejpJHw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=atBRRChVqMFktzoSJ8X5P3wkOgReyOVkorayz3D5otY2a8sKscGokz3R+EgO0P/Xd
 qYAF3y8mC27RnXIn92IUQulyKtfKCWzALHDlfLxhvFZq4Nu6acT82A9cHDqhhNA61p
 6t7jz4qNIa1PjjwRx7CRV1/3VV5fKk5l9evEU/lsBkfKxGqS6TSe33bIY9NQLRfV2V
 dlS4KErrKYzWbWt6n0tqoGVlgHphmC9uq1KXPVVO9NJomqM01SDZ0ZbNe/NOPX9XrH
 asdKmViqRc8JMv7foYdt5zPNTZo4KD0DYUz4AxEMvliLw9y/PRMB44UHZofmHLsE/8
 81UmlkKwUtoeQ==
Message-ID: <a74a468a-8255-4379-9430-41b794499d3e@denx.de>
Date: Wed, 21 Feb 2024 13:27:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
 "lukma@denx.de" <lukma@denx.de>, "aford173@gmail.com" <aford173@gmail.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, "festevam@denx.de"
 <festevam@denx.de>, Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "fathi.boudra@linaro.org" <fathi.boudra@linaro.org>
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
 <42f24803-8e56-46b2-a3c5-0c09dba69778@denx.de>
 <CAFA6WYOErpAFC4eqjtyFiMgwjsh0Wc2R3j94XEh1NoBn85hbhQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYOErpAFC4eqjtyFiMgwjsh0Wc2R3j94XEh1NoBn85hbhQ@mail.gmail.com>
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

On 2/21/24 13:12, Sumit Garg wrote:
> On Wed, 21 Feb 2024 at 16:11, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/21/24 10:18, Marcel Ziswiler wrote:
>>> Hi Sumit
>>>
>>> On Wed, 2024-02-21 at 08:55 +0100, Francesco Dolcini wrote:
>>>> Hello Sumit,
>>>>
>>>> On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
>>>>> Also, enable reset driver which is a prerequisite for PCIe support.
>>>>>
>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>>> ---
>>>>>    configs/verdin-imx8mp_defconfig | 9 +++++++++
>>>>>    1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
>>>>> index 22b8a334dfa..d8bd644322b 100644
>>>>> --- a/configs/verdin-imx8mp_defconfig
>>>>> +++ b/configs/verdin-imx8mp_defconfig
>>>>> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>>>>>    CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
>>>>>    CONFIG_IMX_WATCHDOG=y
>>>>>    CONFIG_HEXDUMP=y
>>>>> +CONFIG_DM_RESET=y
>>>>> +CONFIG_RESET_IMX=y
>>>>> +CONFIG_PCI=y
>>>>> +CONFIG_PCIE_DW_IMX8=y
>>>>> +CONFIG_PHY_IMX8M_PCIE=y
>>>>> +CONFIG_CMD_PCI=y
>>>>> +CONFIG_NVME=y
>>>>> +CONFIG_NVME_PCI=y
>>>>> +CONFIG_CMD_NVME=y
>>>>
>>>> This will increase the u-boot proper size
>>>
>>> Yes, I checked and it is actually slightly more than 32 K.
>>>
>>>> and marginally increase the
>>>> boot time (because of a bigger binary to be read from the eMMC).
>>>
>>> That was also my concern.
>>>
>>>> Apart of that do you expect any other impact on those changes? SPL
>>>> binary size should not be affected, correct?
>>>>
>>>> Asking this out loudly to confirm that nothing unexpected is going to
>>>> happen because of these changes.
>>>
>>> Other than that I actually gave it a quick try and PCIe/NVMe does indeed work and the regular boot is not
>>> affected (other than the slight size and boot time increase, of course).
>>>
>>>> For my curiosity, care to share what's the use case? Do you plan to have
>>>> the OS stored into an NVME device?
>>>
>>> For us the question is basically whether that use case does mandate enforcing such changes for each and every
>>> customer. Plus the regular expected maintenance effort any such change brings with it, of course.
>>
>> You can always enable this support on MX8MP EVK, it has M2 slot and this
>> would add build coverage of this code too, without impacting Verdin.
> 
> I would have chosen that as the base platform to enable but
> unfortunately I don't have that at my desk. However, if someone is
> willing to test this patch-set on MX8MP EVK then I am happy to extend
> corresponding defconfig too.

I think we can surely find a platform on which this can be enabled by 
default and tested by people.
