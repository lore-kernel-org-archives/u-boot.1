Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF216CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 05:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AEA189009;
	Fri,  4 Oct 2024 07:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728018385;
	bh=2dB9GfzL6dm6eGUibDPMQ8z154PyijUqU8ufdA/7/i0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=wAZgcF5aAcfRER/YjxriI9oTTKaFVNvQJ91cizoAiV3+tu9tZYJ9qH3DPjfCwYKXB
	 dDivE/OryasHglKcOWF1XDqBFw1hDu+kAJ78U+n/PhfsM/UqPg2xd+Go65mrpcVjja
	 xUabHJgFkBcgTjCz4cyJMxlRQBGtTrVv1PVD3MtEkEeHE2bxVMqVTJSJlp85lnG6iW
	 4j1pc4DHIihHjJ9jPMrBfCyDSStr+QK1qgqDyrMsVCHxbY4YtTdUu3BolNLyc4iHA/
	 aXWDb9A1GoT1HvqZzmFmMMRt0dgUhqEwHIwxFs/otR638oe6HBwykChJSXkc1gAteH
	 WTgaPbXxpGbtg==
Received: from [192.168.1.107] (82-131-157-225.pool.digikabel.hu
 [82.131.157.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 603BC88AE8;
 Fri,  4 Oct 2024 07:06:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728018384;
 bh=2dB9GfzL6dm6eGUibDPMQ8z154PyijUqU8ufdA/7/i0=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=X1PZpO64eBevdGVNe2GHIEDl3eOxYp/9a4Juhooo2sUI95pmXi3uXyoo6yEo7C+YQ
 u6RiCU1ovQCGf8O47B9uiS92FSHAIp8h8Ncvp8F6rG8joBwvdDwUQMY/OL1RCB/tSw
 zlu1ddNnsJJHMLVwJrcL5Vf+ucfJTOj9P4u5pSv5N4w6qFzm3L908oUNEYhfZhIeT+
 dTIqkKD+Ub0ZWBP8IaKKNGMyNFoJvXALFQWGNk/HOMP4CE5zrZQJUdJ/CDmb945pf9
 3V+Ic1zsOSgIhgZ7THHMvXdXzXdsH2p05BCC7JcBkRJA1OVtuxPhwb+aAA6zq4gJoP
 Lnz/+Lc/Cty4Q==
Message-ID: <ac403d08-cacc-9074-f3aa-df2e87a2d32a@denx.de>
Date: Fri, 4 Oct 2024 07:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] sandbox: i2c: Make sure phandle dependency is probed
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241003203736.298649-1-marex@denx.de>
 <80e7d47f-335d-4c81-ac7c-3af531474e50@denx.de>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <80e7d47f-335d-4c81-ac7c-3af531474e50@denx.de>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Marek!

On 03.10.24 22:47, Marek Vasut wrote:
> On 10/3/24 10:37 PM, Marek Vasut wrote:
>> This driver depends on i2c emulator via DT phandle. Make sure the
>> dependency is probed before this driver is probed, not when it is
>> first used during transfer. This fixes the following i2c_emul_find()
>> error:
>>
>> "
>> $ ./u-boot -Dc ""
>> ...
>>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>>    sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>>         out_set_value() PMIC write failed: -5
>>         i2c_emul_find() No emulators for device 'sandbox_pmic'
>>    sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
>>         out_set_value() PMIC write failed: -5
>> ...
>> "
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Heiko Schocher <hs@denx.de>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   drivers/i2c/sandbox_i2c.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/i2c/sandbox_i2c.c b/drivers/i2c/sandbox_i2c.c
>> index 74bb5e93397..9a39ac14fb4 100644
>> --- a/drivers/i2c/sandbox_i2c.c
>> +++ b/drivers/i2c/sandbox_i2c.c
>> @@ -80,6 +80,14 @@ static int sandbox_i2c_xfer(struct udevice *bus, struct i2c_msg *msg,
>>       return ops->xfer(emul, msg, nmsgs);
>>   }
>> +static int sandbox_i2c_probe(struct udevice *dev)
>> +{
>> +    struct udevice *emul;
>> +
>> +    return uclass_get_device_by_phandle(UCLASS_I2C_EMUL, dev,
>> +                        "sandbox,emul", &emul);
>> +}
> Hmmm, no, this does not do it, but it does show what the issue is -- sandbox_i2c_xfer is misused to 
> defer access to this emulator until the first I2C transfer, so the emulator can hopefully probe in 
> the meantime. This is fragile and now it broke. What I am not quite sure about is why this 
> uclass_get_device_by_phandle() returns -2 here instead of probing the emulator ?

Hmm... -2 means it does not find such a device ... why, I don;t know ...
do you have a chance to debug?

Just a fast grep (I must admit, never looked into this parts...))
may it helps if you use

int i2c_emul_find(struct udevice *dev, struct udevice **emulp)

found in file:

./drivers/i2c/i2c-emul-uclass.c

instead?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
