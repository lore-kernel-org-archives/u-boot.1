Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48568C54E4A
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 13:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB4487ED6;
	Mon, 26 Feb 2024 14:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708952975;
	bh=HzZmEWAG5+iRoGW+z33FgwXFuiaosy6a+J1xxoSfRqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qr1RfrSidS01+ONd1zm+KTbQPyAm4AkQo0Q58ORfaY+paVruPZiop29G+FiWVOK2A
	 qkW+SUvfi9YTr12DcGvI7L6KqUo+sDMh/N4elfnIOXzZcAWTiS4pyDEVWogTACGKNV
	 cAMbgcDKqcRdTEPQF/zvA3WPefOKPeBFqA0y7FSjHqTyzMiO1r5f5iQDLQB8JqtQDG
	 wWdT3mamSglkHgHN93fS2SBxkJsqfWdxwMHcq5QB8NWGXw6FL8BYpbQRCxzvC1iDDj
	 VWnPJPDOaGi28MYmb2HDLsXK8B8aE6n2ahO3PUmbaqjGtwQdXXEpz+Yo18ISXJe6oI
	 rlTp/j7SucDKg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2EFE387E40;
 Mon, 26 Feb 2024 14:09:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708952974;
 bh=HzZmEWAG5+iRoGW+z33FgwXFuiaosy6a+J1xxoSfRqI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rmWDQeDT9x0rhh2O+44GDqLxUTxoLR0SpH3dSzTF5c+p6bMt7yDvFU5v25g74PR9k
 xLrPJF2hRzLqS8RbFIpObGUIxtSr27s8uDU5PFtj4UimtyNV/TzTrwLGjgemo9BF6u
 pUpWgkydaOxr38Mxze4Tq1fZz0d+BJpTZZ2TuYxBOwQCMraB2B0a5Rd2ATy93qSANc
 Uo5D8NUQO1hZnE7FuiVC+Y0UiSSV4tEg48WL3LSpU24ZlhvVUI8r7VSVjEqUuPtiGK
 udwkWt70NxrqHFO8O/LciaFC4uGYd9hNrhgnOdJqRaaFjA1q4BsB9ELGQ664yEXOrc
 Jh+IAaZ0pD++Q==
Message-ID: <b0480488-2e79-4641-8674-3a70d921b4c8@denx.de>
Date: Mon, 26 Feb 2024 14:09:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it,
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, festevam@denx.de, andrejs.cainikovs@toradex.com,
 sjg@chromium.org, peng.fan@nxp.com, aford173@gmail.com,
 ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
 <c8f5815a-bbec-4efe-95d0-77dec441a183@denx.de>
 <CAFA6WYOhyHzn+XOsUwrqs5kajHjSFhDcsHGu6=CAB9dT+VCV8Q@mail.gmail.com>
 <583d9f9d-6f95-464d-a912-aebaa837dd7e@denx.de>
 <CAFA6WYNDXmQJ4mPo6HZ8bZnFx0+9qwqHcG20F4vUH3YGRa92aw@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFA6WYNDXmQJ4mPo6HZ8bZnFx0+9qwqHcG20F4vUH3YGRa92aw@mail.gmail.com>
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

On 2/26/24 2:03 PM, Sumit Garg wrote:
> On Mon, 26 Feb 2024 at 16:26, Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/26/24 11:43 AM, Sumit Garg wrote:
>>> On Mon, 26 Feb 2024 at 14:24, Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 2/26/24 9:04 AM, Sumit Garg wrote:
>>>>
>>>> [...]
>>>>
>>>>> +static int imx7_reset_assert_imx8mp(struct reset_ctl *rst)
>>>>
>>>> Linux calls those imx8mp_reset_set() can co. which is less confusing
>>>> than imx7...imx8mp() , use it.
>>>>
>>>
>>> IMO, it would be more confusing if we choose two different naming
>>> patterns for the same driver, see existing function names
>>> imx7_reset_{deassert/assert}_imx* pattern.
>>
>> Maybe create a patch which updates the naming scheme ?
> 
> I can do that as a preparatory patch.
> 
>>
>> Using two SoC names in one function name is confusing I think .
>>
>>>> In fact, why not copy the code from Linux outright ?
>>>
>>> I suppose the question here is to not convert the driver to use
>>> regmap, right? If it is then that should be done as a separate cleanup
>>> patch.
>>
>> If it isn't too hard, please do the clean up first and then add the
>> MX8MP bits on top.
> 
> The coding part is easy but it is rather the testing part which I am
> worried about as I don't have access to all the platforms which rely
> on this driver.

Don't worry about that part, I'm reasonably sure if something breaks, it 
will be spotted sooner rather than later.
