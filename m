Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C9FC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 10:45:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 772BC880BF;
	Wed, 21 Feb 2024 11:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708512171;
	bh=Wr3kEVPuxP5x12yRHw7WVBWJtLmEVY5g3loTTTvFuyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=irYjT6FbWW4TCVCLkYVDiruAaSggL57tR4fvE5m5+kMAPLsmiqeOEEAQz5Gkk1i3K
	 /z90E0bGmQeal/F9e2fCOaOLk7O8EwpsFVaIc3dLzfw/5sDt39DimcVLlSJMsE8daF
	 frj/ZwyEmjXwHrb3CIMgMgL1il9NAmlx+ew4MHP6gTm+ve12iqf1P2jU5YiYmy3rKR
	 z+h4z+Qo1P9Eryu6a1eHaGBVPaq6j+h04REF/uUG+mgG4mCGKvh4ve6u6DAgLtvebn
	 qhCVtv8/FhUXVokKE2tjzwYHimsMq3Ig1jVmrfSoKWfFNGJ5Cj6wjEaNFKYRr/wVnG
	 vSDweLVXGPbkg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8AF0B88084;
 Wed, 21 Feb 2024 11:40:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708512036;
 bh=Wr3kEVPuxP5x12yRHw7WVBWJtLmEVY5g3loTTTvFuyQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cxMAUd+zs4Ma5IkzmKZl28RNF9pZO3cPw3Uyc14pE4EFT+Rk2UBTas2ASGTdeiXSb
 YZccxrIv8lfCNv7wd1RJdlMhl1rSW1voIhBPLQsrLRa1keTOZNKgzjIwC6asR7xNT0
 WHL9bzhYnPOU/+RYA4VRawlsxKn3oto9YXVogPHpO8S97LyhOtl2m4h1IiwVbSOWwl
 EkT8mt4y+SfeQAJBoNh1B2f+bAJHoOK3ESP+WQHIspBlcKZA5ittaphEzHB4UYQwL6
 lICo3GP2Gvmx7QVQjtd72bYiS5yQUvxNs1L32xLVekcsfnEy8ff+d1/V7MXCS9pCfF
 jSNess3JXqfgg==
Message-ID: <3fb07a1b-a369-4b07-a8cf-df159707340f@denx.de>
Date: Wed, 21 Feb 2024 10:28:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] reset: imx: Add support for i.MX8MP reset controller
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-3-sumit.garg@linaro.org>
 <314b12f0-7b5d-44f4-bcf1-69a287a9005d@denx.de>
 <CAFA6WYPwHdSZwcHQaszVG_0++DRU4ykmsLcxO3m4PJhyGRcy3A@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYPwHdSZwcHQaszVG_0++DRU4ykmsLcxO3m4PJhyGRcy3A@mail.gmail.com>
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

On 2/21/24 06:40, Sumit Garg wrote:
> On Tue, 20 Feb 2024 at 21:02, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/20/24 14:10, Sumit Garg wrote:
>>> Pre-requisite to enable PCIe support on iMX8MP SoC.
>>
>> Please write a proper commit message .
>>
> 
> How about the following?
> 
>      Add support for i.MX8MP reset controller. It is required
>      to enable PCIe support on the iMX8MP SoC.

The part about PCIe is not relevant, it is a reset controller and it is 
needed to reset various IPs. See e.g. Linux:

e08672c03981 ("reset: imx7: Add support for i.MX8MP SoC")

>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>> ---
>>>    drivers/reset/reset-imx7.c | 114 +++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 114 insertions(+)
>>>
>>> diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
>>> index eaef2cc2cdf..c1de84dea8b 100644
>>> --- a/drivers/reset/reset-imx7.c
>>> +++ b/drivers/reset/reset-imx7.c
>>> @@ -10,6 +10,7 @@
>>>    #include <dm.h>
>>>    #include <dt-bindings/reset/imx7-reset.h>
>>>    #include <dt-bindings/reset/imx8mq-reset.h>
>>> +#include <dt-bindings/reset/imx8mp-reset.h>
>>>    #include <reset-uclass.h>
>>>    #include <linux/bitops.h>
>>>    #include <linux/delay.h>
>>> @@ -252,6 +253,115 @@ static int imx7_reset_assert_imx8mq(struct reset_ctl *rst)
>>>        return 0;
>>>    }
>>>
>>> +enum imx8mp_src_registers {
>>> +     SRC_SUPERMIX_RCR        = 0x0018,
>>> +     SRC_AUDIOMIX_RCR        = 0x001c,
>>> +     SRC_MLMIX_RCR           = 0x0028,
>>> +     SRC_GPU2D_RCR           = 0x0038,
>>> +     SRC_GPU3D_RCR           = 0x003c,
>>> +     SRC_VPU_G1_RCR          = 0x0048,
>>> +     SRC_VPU_G2_RCR          = 0x004c,
>>> +     SRC_VPUVC8KE_RCR        = 0x0050,
>>> +     SRC_NOC_RCR             = 0x0054,
>>> +};
>>
>> This seems copied from Linux, include Linux commit ID as of which this
>> was imported from in commit message.
> 
> Do you expect imx8mp_src_registers to change? I expect them to be the
> same, so does Linux commit ID add any value here?

The import commit ID makes it easier to cherry-pick follow up patches or 
check for changes. If that commit ID is missing, that task is harder.
