Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8F5C48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3DB48803A;
	Wed, 21 Feb 2024 11:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708512197;
	bh=bdDvanOuXxYNXIvUjo38LQf7rJBAWIRsV+UWefRT8Uo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vV5qyN3XOwpbMqB8P2ZxK1pTJ5KdCigJZZ9ZehWrY7NP74IoXdQ2nxGCzu1YZ5waJ
	 f3YougZIgP9iX9YNm4fRfZ7rmQHgdw9HWZGaozpJ1yt5bCyfuleF74FareEzHz1Io/
	 23OVMhCUjLiXwqUT9AZoB/S9/JxE5Z9LWWpRx89YUNm1LUfDXEuG7wuyXuNOASlNE8
	 tchSZ2BsUIfH38KCFIRvKb2kQZlk2GmEVKVCdtr6aLix1sNMH1RgT5aPWYDvXO3YTv
	 2IY7mGr+WCZGSk9Wj6ghSzEl+0DYu/54KbbZ3xROLlMxvNq5B6AfG2UwaAd8do4Ljv
	 x53SPw2/kH9XQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 848E5880A1;
 Wed, 21 Feb 2024 11:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708512065;
 bh=bdDvanOuXxYNXIvUjo38LQf7rJBAWIRsV+UWefRT8Uo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p47mVpuaXw5yjJwwEGEDftTTtaLOFY85ZlyE/UCbVjTBBMCHZdCXGDmFQ8RZnoAcm
 rnnBzyGFH+rXWFctJGxVu+bUXeME8KfdHcj1B46dTbtq/iat/mVxOq3pFvLue67aMz
 MLJdWJmC1b4lZ541USMqVZ6jmS3OPyJuzVdCGXVQKghrDisB6gU3kP9mBxb4F8V293
 M+yaOr4nw/YiuipXSxPeU4erp7I5Bq8oamDAAiMQtxcUuvzPo/M7Bov+aDs04+e8wM
 63G4HnQ8y5mfIdHYXE66RH9lGMCy8UeiMaNqAJabpcpF2APs5daAIImELLMM46jWna
 zcAx//BrQjtaQ==
Message-ID: <42f24803-8e56-46b2-a3c5-0c09dba69778@denx.de>
Date: Wed, 21 Feb 2024 10:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
Content-Language: en-US
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 "sumit.garg@linaro.org" <sumit.garg@linaro.org>
Cc: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
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
From: Marek Vasut <marex@denx.de>
In-Reply-To: <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
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

On 2/21/24 10:18, Marcel Ziswiler wrote:
> Hi Sumit
> 
> On Wed, 2024-02-21 at 08:55 +0100, Francesco Dolcini wrote:
>> Hello Sumit,
>>
>> On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
>>> Also, enable reset driver which is a prerequisite for PCIe support.
>>>
>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>> ---
>>>   configs/verdin-imx8mp_defconfig | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
>>> index 22b8a334dfa..d8bd644322b 100644
>>> --- a/configs/verdin-imx8mp_defconfig
>>> +++ b/configs/verdin-imx8mp_defconfig
>>> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
>>>   CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
>>>   CONFIG_IMX_WATCHDOG=y
>>>   CONFIG_HEXDUMP=y
>>> +CONFIG_DM_RESET=y
>>> +CONFIG_RESET_IMX=y
>>> +CONFIG_PCI=y
>>> +CONFIG_PCIE_DW_IMX8=y
>>> +CONFIG_PHY_IMX8M_PCIE=y
>>> +CONFIG_CMD_PCI=y
>>> +CONFIG_NVME=y
>>> +CONFIG_NVME_PCI=y
>>> +CONFIG_CMD_NVME=y
>>
>> This will increase the u-boot proper size
> 
> Yes, I checked and it is actually slightly more than 32 K.
> 
>> and marginally increase the
>> boot time (because of a bigger binary to be read from the eMMC).
> 
> That was also my concern.
> 
>> Apart of that do you expect any other impact on those changes? SPL
>> binary size should not be affected, correct?
>>
>> Asking this out loudly to confirm that nothing unexpected is going to
>> happen because of these changes.
> 
> Other than that I actually gave it a quick try and PCIe/NVMe does indeed work and the regular boot is not
> affected (other than the slight size and boot time increase, of course).
> 
>> For my curiosity, care to share what's the use case? Do you plan to have
>> the OS stored into an NVME device?
> 
> For us the question is basically whether that use case does mandate enforcing such changes for each and every
> customer. Plus the regular expected maintenance effort any such change brings with it, of course.

You can always enable this support on MX8MP EVK, it has M2 slot and this 
would add build coverage of this code too, without impacting Verdin.
