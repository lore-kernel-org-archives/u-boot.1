Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19136CF34C4
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 14:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C33D889AE;
	Sat,  5 Oct 2024 16:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728139059;
	bh=DFfPr9VpQWrDHoXLj3GkQ8jLAPiXqBSeoCfeN4NceXM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qyAqT7g9Jk4VHbHwX3htCk66ttJ3qRnHYuBntHgRAjbI3ymNgVqkSX+VObc0sY9t0
	 SYFo2OC3Q52NhZym0cnpk0yhrdaeRAHs3Us6JU+173HqQoCm7sRgI6j09T9uEHrU32
	 Kp75qo4dPMVxeLRI9zB2hP9N6iKtzuH7aSO2+EnG13Sy0qg2+6KDJBpudVKRXlF7sO
	 sIboHjyr8h3CutZmANWtHw294L0psVlf/AmeADHVOIpoF6Ra5v5vEe/RpB3gHsfTpR
	 lptjJ5eqWFJBrCe9S9bW/TLOL1xDEkmT7LTtOTmqlM7HsA/9IL5fR8V0z1QdGCSV3y
	 gECg8+Hpidtfg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 77A858898B;
 Sat,  5 Oct 2024 16:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728139058;
 bh=DFfPr9VpQWrDHoXLj3GkQ8jLAPiXqBSeoCfeN4NceXM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aQgcMHcZlqAbCeuuEZyQzxzP+2H4cvE/o0RSU8excDUtiIdPoOjPpd5exNWZlRe03
 QbFos7FvRVKZu/SgoFVqJDvuOzkaiLAOQCs+IRxvN4O+Fr8q6ybBIYml2QbNHr/dSs
 /8f1VBD6y9QJiMKS+m7bywhWkJxKSid+Gi8JeeNFZ4qVscdsZez5q7Ycrag7KlNiXT
 GiaTR7Ic7LHfBnhcFN3gMVKpn7xAafwpZD7RxsvU9ebPuddhwmUN5LTkFboc26fvgw
 txOCKO0cX8WtMcLGHLVDbKlnCkqrhjd/nqQpji/ZgFwJsyJjolMPRPBE3WPDcbP0kA
 ayU1tLpkUbwIw==
Message-ID: <017a2c6c-9140-47f9-93fc-26111feba3da@denx.de>
Date: Sat, 5 Oct 2024 16:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sandbox: i2c: Make sure phandle dependency is probed
To: hs@denx.de, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241003203736.298649-1-marex@denx.de>
 <80e7d47f-335d-4c81-ac7c-3af531474e50@denx.de>
 <ac403d08-cacc-9074-f3aa-df2e87a2d32a@denx.de>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ac403d08-cacc-9074-f3aa-df2e87a2d32a@denx.de>
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

On 10/4/24 7:04 AM, Heiko Schocher wrote:
> Hi Marek!
> 
> On 03.10.24 22:47, Marek Vasut wrote:
>> On 10/3/24 10:37 PM, Marek Vasut wrote:
>>> This driver depends on i2c emulator via DT phandle. Make sure the
>>> dependency is probed before this driver is probed, not when it is
>>> first used during transfer. This fixes the following i2c_emul_find()
>>> error:
>>>
>>> "
>>> $ ./u-boot -Dc ""
>>> ...
>>>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>>>    sandbox_pmic_write() write error to device: 0000000018c568d0 
>>> register: 0x0!
>>>         out_set_value() PMIC write failed: -5
>>>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>>>    sandbox_pmic_write() write error to device: 0000000018c568d0 
>>> register: 0x0!
>>>         out_set_value() PMIC write failed: -5
>>> ...
>>> "
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Heiko Schocher <hs@denx.de>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@lists.denx.de
>>> ---
>>>   drivers/i2c/sandbox_i2c.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/i2c/sandbox_i2c.c b/drivers/i2c/sandbox_i2c.c
>>> index 74bb5e93397..9a39ac14fb4 100644
>>> --- a/drivers/i2c/sandbox_i2c.c
>>> +++ b/drivers/i2c/sandbox_i2c.c
>>> @@ -80,6 +80,14 @@ static int sandbox_i2c_xfer(struct udevice *bus, 
>>> struct i2c_msg *msg,
>>>       return ops->xfer(emul, msg, nmsgs);
>>>   }
>>> +static int sandbox_i2c_probe(struct udevice *dev)
>>> +{
>>> +    struct udevice *emul;
>>> +
>>> +    return uclass_get_device_by_phandle(UCLASS_I2C_EMUL, dev,
>>> +                        "sandbox,emul", &emul);
>>> +}
>> Hmmm, no, this does not do it, but it does show what the issue is -- 
>> sandbox_i2c_xfer is misused to defer access to this emulator until the 
>> first I2C transfer, so the emulator can hopefully probe in the 
>> meantime. This is fragile and now it broke. What I am not quite sure 
>> about is why this uclass_get_device_by_phandle() returns -2 here 
>> instead of probing the emulator ?
> 
> Hmm... -2 means it does not find such a device ... why, I don;t know ...
> do you have a chance to debug?
It seems I was too hasty with this patch, now superseded by:

[PATCH] sandbox: dts: Add missing sandbox,emul phandle to sandbox-pmic
