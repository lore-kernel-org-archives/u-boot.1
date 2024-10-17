Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F93BD2F7D8
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 00:24:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 209EB88E36;
	Thu, 17 Oct 2024 02:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729124689;
	bh=8Z3ETCYCLOh/kaKu5K1FGHRxW/6ZVFJNi9PErTAP0Gs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N7ps//uT+4UOTgpQSqp4VFhSpSEz8lEaEjYg7gX5UgZ+EBNwSw22Ob/KJFiTZHVJ4
	 6d5ex0z4FDpShYZgRCMYRE2vW7T03BU/7/a+trQs19d+ZuXAwlUVgkhBfzla1iv+Zb
	 e7xbRd/I6wOBSvag1LFuSzhdGhHJtByNrBNHkFBjgT+tw2nPTERpJwqgitPtkxInd3
	 8OyXXVCvCB8HGTx0nCvGMgjoo5Rx97QSEoO5QR5YkeANich7bVMDmipj8uNSlkMjH4
	 bCHaz2GIJT1989KeCveT0CyahQGkimD25j6IJU8aNggtN/sm1K2TvzRR0zTHCtEEaY
	 2nC4HCvltZiiA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A274288E2B;
 Thu, 17 Oct 2024 02:24:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729124686;
 bh=8Z3ETCYCLOh/kaKu5K1FGHRxW/6ZVFJNi9PErTAP0Gs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=G4TrsgkkfRd3fuetUl9gyOlgF+k9XKgwAqjNCye4mgVxUxCk8JkRvkJcf1KBSbnrd
 c0snti+I+zwM1HSeZT4aVERriDLQ2VSycPYsjfNmd22KHeeFkedBRAuIc84gmeuLss
 9dPM+KD+7mn087PbznpBhknIxB4YdPDcF7yr5PA/OE8z7fX8IyfbNxSnrK2pSKba6Y
 3BuX4tyuwmC4aFtmZR52ubScfsTJYwVsUvHdrtaX1bwYUIYhqwaRUnRmmqpKjo0HAM
 P4DyEmk+PQGCssg6VErqc9STBjy+K9DPCZyOJfjMG6Fdd87wbu1Qa5s50Aezuqje5s
 hNkS9rhB+Np8w==
Message-ID: <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
Date: Thu, 17 Oct 2024 02:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: imx8mp: Read item and serial number from
 EEPROM ID page on DH i.MX8MP DHCOM
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
 <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
 <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
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

On 10/16/24 2:31 PM, Christoph Niedermaier wrote:

[...]

>>> diff --git a/board/dhelectronics/common/dh_common.h b/board/dhelectronics/common/dh_common.h
>>> index 4c22ece435..1baa45e340 100644
>>> --- a/board/dhelectronics/common/dh_common.h
>>> +++ b/board/dhelectronics/common/dh_common.h
>>> @@ -6,6 +6,8 @@
>>>    enum eip_request_values {
>>>        MAC0,
>>>        MAC1,
>>> +     ITEM_NUMBER,
>>> +     SN,
>>
>> Why is this patch not squashed into 1/2 ? It seems to be changing the
>> same code.
> 
> The first patch add the reading for MAC address from the EEPROM ID
> page and add the use of that addresses. The second extends the reading
> to the serial number and the item number. So that the patch doesn't
> get too big I found it useful to split it into two. Do you want me to
> make one patch out of it?

Yes please. Once you cache the EEPROM content, the patch would likely 
get simpler anyway.

[...]

>>> +     ret = dh_get_value_from_eeprom_id_page(ITEM_NUMBER, item_number, sizeof(item_number),
>>> +                                            "eeprom0");
>>> +     if (ret) {
>>> +             /*
>>> +              * The function only returns the value -ENOENT for SoM rev.100, because
>>> +              * the EEPROM ID page isn't available there. Therefore the output makes
>>> +              * no sense and will be suppressed here.
>>> +              */
>>> +             if (ret != -ENOENT)
>>> +                     printf("%s: Unable to get item number form EEPROM ID page! ret = %d\n",

'form' typo

>>> +                            __func__, ret);
>>
>> This will be printed on every device, even the ones without ID EEPROM,
>> correct ? This should not be printed on devices without ID EEPROM. Also,
> 
> This is suppressed by the -ENOENT check.

Does i2c_eeprom_read() in dh_get_value_from_eeprom_id_page() return 
-ENOENT in case the EEPROM is described in DT, but not populated on the 
board ? I suspect it returns some other error code, -ETIMEDOUT or 
-EINVAL maybe ?

>> if (ret && ret != -ENOENT) {}
>>
>> works equally well without the extra indent.
> 
> I have an else to (ret) here not to (ret && ret != -ENOENT).
> This would change the logic.

} else if (!ret) { or similar should fix that, right ?

Basically, the question is, can we avoid this two level deep indent ? I 
think yes ?

[...]

>> Also, this shouldn't be repeatedly reading the EEPROM, the EEPROM read
>> operation is the slow part, the EEPROM is 32 bytes, so the EEPROM should
>> be read once and cached, and once the cache is populated all read
>> accesses to the EEPROM should use the cache.
> 
> This is already covered in function dh_get_value_from_eeprom_id_page().
It seems that function always calls
ret = i2c_eeprom_read(dev, 0x0, eipa, sizeof(eipa));
?
