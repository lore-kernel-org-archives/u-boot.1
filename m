Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04A0C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 05:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7057988640;
	Sun, 30 Jun 2024 07:24:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719725048;
	bh=n55W+vUzKBsYFKKoQp8MWP1+mJBjepy6w4ZSAu0kIg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fhotvh/S1zEwFIxLYtb3jgNxp1icOlHIv44TUQ/WOA1pb1kbzhCT6QfHrU4aZFvwK
	 TyRps9+3hIB49bevrjAPrLKWEIZArNljKuHG9r7UWojlAzs9odzNqItXjtNsFJ13mN
	 SZP9F7pBpWxBC2ezgSoC+l0HapYXMXE7Hi4/2RHGV9fCQZjN5OmQEnO/qmaVKmFwn0
	 +P7rjt3prf5ej7U3jb9vlZnMUcHQz6HrpRLI69mj0ywPK30CLdGhU+6M6tzeKNQ4mp
	 iMN7+DclD4kMk68SMLI7MuRBFkFkEoRvnGPnWXzhsi7ZRRNTRVH3ZYKwAgUR+q+TDz
	 5AnO93ZkViuEA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E7FDE88633;
 Sun, 30 Jun 2024 07:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719725046;
 bh=n55W+vUzKBsYFKKoQp8MWP1+mJBjepy6w4ZSAu0kIg8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JFyZKrriwLFaUUd9+/EcMyfWcOJ+R3G46UFuUhLyr/OQ7Fogs5tmXLoi7RUPYnMaB
 B+zohKXO/cLYIU/MErYI+EbHY3ib7/9QBKTfuFg4y1MfcHNX+q6HYN9Fs43dQgxE8F
 b0KGkESqvAszZ+fBMHwNSBIhKmdGe8YSeeeb2g3iFurOOVp1J3TTFQQB3aMr/6O61p
 j9/v9mwfHN/Y9KGDh5fc/XeRA3xt8qXkeO2zIl+kQHlyDU5DMi7DIRgWEyh1YjS/zj
 yQnS8QMqGCst0mJzgqRdM7k+iSGap7kTcRow1xKHoFZqHoz46Zd9PA+K4PkjWmZ+We
 IKD903C3hI2og==
Message-ID: <36290216-33dd-45a0-a44d-af7d3273fb0a@denx.de>
Date: Sun, 30 Jun 2024 06:53:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
To: Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
References: <20240522002122.50796-1-marex@denx.de>
 <20240522063948.GA5278@francesco-nb>
 <e9a57cfc-637a-4c26-84ac-6f6530ca62ce@denx.de>
 <20240523150359.GA18323@francesco-nb>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240523150359.GA18323@francesco-nb>
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

On 5/23/24 5:03 PM, Francesco Dolcini wrote:
> On Wed, May 22, 2024 at 03:23:51PM +0200, Marek Vasut wrote:
>> On 5/22/24 8:39 AM, Francesco Dolcini wrote:
>>>> diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
>>>> index 55c02653da6..ef632d95f0a 100644
>>>> --- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
>>>> +++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
>>>> @@ -125,6 +125,36 @@ int board_phys_sdram_size(phys_size_t *size)
>>>>    #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
>>>>    int ft_board_setup(void *blob, struct bd_info *bd)
>>>>    {
>>>> +	const char *canoscpath = "/oscillator";
>>>> +	int freq = 40000000;	/* 40 MHz is used on most variants */
>>>> +	int canoscoff, ret;
>>>> +
>>>> +	canoscoff = fdt_path_offset(blob, canoscpath);
>>>> +	if (canoscoff < 0)	/* No CAN oscillator found. */
>>>> +		goto exit;
>>>> +
>>>> +	/*
>>>> +	 * The actual "prodid" (PID4 in Toradex naming) that have the CAN
>>>> +	 * functionality are 0055 and 0059. Special case 20 MHz variant
>>>> +	 * here:
>>>> +	 * - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
>>>> +	 * - 0059, V1.1A and V1.1B, use a 20MHz oscillator
>>>> +	 */
>>>
>>> Any reason why you ignored my suggestion here? The variants you list
>>> here are the only one with a 20MHz oscillator, and this is correct.
>>>
>>> What is not correct is that 0055/0059 are the only variant with CAN
>>> functionality. We have other "prodid" with CAN functionality.
>>>
>>> With that said, the code is correct, thanks. I appreciate you taking care
>>> of this.
>>
>> So ... what should I change for V3 ?
>>
>> Maybe just create me a diff I can squash into the patch before resend ? (I
>> think I am a bit confused, I thought I addressed all the V1 feedback)
> 
> Sorry for the confusion, here the diff.
> With that please add

Thank you. I missed this mail and now I found it. Fixed in V3.
