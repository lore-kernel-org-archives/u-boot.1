Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB88AC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661AD882B8;
	Mon, 17 Jun 2024 16:58:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="C7mWkc11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEAE882B8; Mon, 17 Jun 2024 16:58:10 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12CCB87D70
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1718636286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGjy+imlL46MK/0Po7XvSgCBV6eT1kUJ6RUO5czpyFM=;
 b=C7mWkc11eTOhjm2I1OQp8k+bU7cihYfBOXTVNLV7JWn4d7IFxhVRWh27vN7z3d+QUUsKG/
 J0AbZ1A8M9yq2z5lPZVmAXgZpxBOcNkzwDVeBrR5jzt01ecST5Jzy/0lYKFbVpncLU/gKx
 QNLuDJrvYeU18R0FsyMjMZzwoQlRT+SUkEnA/svhkX+zSOENxYmznZkJKKcZ4PGQHz9VNc
 qLeTCFeVuBbHRbvaPZVi/+vA1oD+6aL+5vbzUJG2Vt5+iyzPUQp7O1PdUpmM7tRyGNvM+r
 zrwya0awOsM5OY8NrLaDryjk7dAk7KxIiMuzDH5Uj3naPeQROQ4G3yjvHaIDlA==
Date: Mon, 17 Jun 2024 16:58:05 +0200
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
In-Reply-To: <46be03e2-c456-4842-9dc3-9a3f975d9980@cherry.de>
References: <20240606-misc-tsd-v3-0-728d721c464a@cherry.de>
 <20240606-misc-tsd-v3-5-728d721c464a@cherry.de>
 <46be03e2-c456-4842-9dc3-9a3f975d9980@cherry.de>
Message-ID: <d6c3c6d65ce164e6a193f1f306c10c8b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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

Hello Quentin,

On 2024-06-17 16:10, Quentin Schulz wrote:
> On 6/6/24 10:45 AM, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>> 
>> The ID of the PMIC is stored in the 2 16b registers but the only part
>> that matters right now is the 3 MSB, which make the 3 digits (in hex) 
>> of
>> the part number.
>> 
>> Right now, only RK808 was properly displayed, with this all currently
>> supported PMICs should display the proper part number.
>> 
>> Additionally, when the PMIC variant is not found, print that value
>> instead of the masked unshifted value as all PMICs we support for now
>> have their LSB ignored to represent the actual part number.
>> 
>> Tested on RK806 (RK3588 Jaguar), RK808 (RK3399 Puma) and RK809 (PX30
>> Ringneck).
>> 
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   drivers/power/pmic/rk8xx.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
>> index 12ff26a0855..617bb511e4e 100644
>> --- a/drivers/power/pmic/rk8xx.c
>> +++ b/drivers/power/pmic/rk8xx.c
>> @@ -6,6 +6,7 @@
>>     #include <dm.h>
>>   #include <dm/lists.h>
>> +#include <bitfield.h>
>>   #include <errno.h>
>>   #include <log.h>
>>   #include <linux/bitfield.h>
>> @@ -277,10 +278,9 @@ static int rk8xx_probe(struct udevice *dev)
>>   		return ret;
>>     	priv->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
>> -	show_variant = priv->variant;
>> +	show_variant = bitfield_extract_by_mask(priv->variant, 
>> RK8XX_ID_MSK);
>>   	switch (priv->variant) {
>>   	case RK808_ID:
>> -		show_variant = 0x808;	/* RK808 hardware ID is 0 */
> 
> This line removal is actually incorrect, I should have left this in as
> we cannot use the same logic as other PMICs for RK808 as it returns 0,
> so 0 masked/shifted is still zero.

Thanks for catching this!  Moreover, I think we should skip reading
the msb and lsb values entirely for the RK808, because its datasheet
lists the default ID_MSB (0x17) and ID_LSB (0x18) registers as reserved,
and provides no information about gathering the chip variant.

> I saw that Kever has already sent a merge request for next with this
> patch, so we have two options: reject the merge and I send another
> patch for next branch, or Kever cancels the merge request, I send a v4
> for this patch and Kever sends a new merge request? How do we want to
> proceed with this. I have a feeling the additional patch is going to
> be easier for everyone as 1) it's for next branch, 2) isn't breaking
> anything except some info message, which was already wrong (but for
> all non-RK808 PMICs :) ).

I think the latter is the way to go, because the pull request has
been already merged.
