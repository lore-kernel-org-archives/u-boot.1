Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A80C2BA1A
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27940883D2;
	Mon, 17 Jun 2024 19:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="VgKI2L87";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE84883DA; Mon, 17 Jun 2024 19:43:56 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9BA8811A
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718646233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK10x6d5gzW1MeEkm19xITFsdLwX+BWf8YjeWjXiqJE=;
 b=VgKI2L87qXa50OzufiTuSf7lPRsWaLQbeuR4jIhs0qcUGKSP+ohmBjzvzMlJWOChM1t9Hn
 YOiE7kgpCIZ4PmKASdI5SdOjV4j7z7GK+NWuznAR8NMyctaZ/5lXSIH+iU7Vs5vonS/cbB
 4BiSoxN4Gg06RIX7cqXDt3uk76DNtu5iITcefknJ8bUyUJYBSNLurGCJsYmgYnbQjAqxy/
 WmnTI2c05EJo56dQmzfFSpu0RiYLY9hZ5NEPcx8HqXFKrpUkGMjTm7yYCul5KTvU49Kk+v
 8hJiM/5jaQFeuDsx3+sjzEx+EWm4vnvi8Tn8DqDD5SbuUdyA2TmiMOfdIUutkw==
Date: Mon, 17 Jun 2024 19:43:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH next v3 5/6] power: rk8xx: properly print all supported
 PMICs name
In-Reply-To: <4c08d1d4-698e-4331-95f9-4accd91fb5e5@cherry.de>
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
 <20240606-misc-tsd-v3-5-728d721c464a@cherry.de>
 <46be03e2-c456-4842-9dc3-9a3f975d9980@cherry.de>
 <d6c3c6d65ce164e6a193f1f306c10c8b@manjaro.org>
 <4c08d1d4-698e-4331-95f9-4accd91fb5e5@cherry.de>
Message-ID: <7ef07d9b9b8a1b9064eb506c96ca8213@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-06-17 18:54, Quentin Schulz wrote:
> On 6/17/24 4:58 PM, Dragan Simic wrote:
>> On 2024-06-17 16:10, Quentin Schulz wrote:
>>> On 6/6/24 10:45 AM, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>> 
>>>> The ID of the PMIC is stored in the 2 16b registers but the only 
>>>> part
>>>> that matters right now is the 3 MSB, which make the 3 digits (in 
>>>> hex) of
>>>> the part number.
>>>> 
>>>> Right now, only RK808 was properly displayed, with this all 
>>>> currently
>>>> supported PMICs should display the proper part number.
>>>> 
>>>> Additionally, when the PMIC variant is not found, print that value
>>>> instead of the masked unshifted value as all PMICs we support for 
>>>> now
>>>> have their LSB ignored to represent the actual part number.
>>>> 
>>>> Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
>>>> Ringneck).
>>>> 
>>>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>   drivers/power/pmic/rk8xx.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>> 
>>>> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
>>>> index 12ff26a0855..617bb511e4e 100644
>>>> --- a/drivers/power/pmic/rk8xx.c
>>>> +++ b/drivers/power/pmic/rk8xx.c
>>>> @@ -6,6 +6,7 @@
>>>>     #include <dm.h>
>>>>   #include <dm/lists.h>
>>>> +#include <bitfield.h>
>>>>   #include <errno.h>
>>>>   #include <log.h>
>>>>   #include <linux/bitfield.h>
>>>> @@ -277,10 +278,9 @@ static int rk8xx_probe(struct udevice *dev)
>>>>           return ret;
>>>>         priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
>>>> -    show_variant = priv->variant;
>>>> +    show_variant = bitfield_extract_by_mask(priv->variant, 
>>>> RK8XX_ID_MSK);
>>>>       switch (priv->variant) {
>>>>       case RK808_ID:
>>>> -        show_variant = 0x808;    /* RK808 hardware ID is 0 */
>>> 
>>> This line removal is actually incorrect, I should have left this in 
>>> as
>>> we cannot use the same logic as other PMICs for RK808 as it returns 
>>> 0,
>>> so 0 masked/shifted is still zero.
>> 
>> Thanks for catching this!  Moreover, I think we should skip reading
>> the msb and lsb values entirely for the RK808, because its datasheet
>> lists the default ID_MSB (0x17) and ID_LSB (0x18) registers as 
>> reserved,
>> and provides no information about gathering the chip variant.
> 
> We've been reading those registers on RK808 in our production lines
> for probably what's half a decade now, I think it's probably safe to
> use :)

True, it's obviously safe, but not reading those reserved RK808
registers would be more about accuracy and following the datasheets
as precisely as possible. :)
