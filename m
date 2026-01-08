Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F62D185C2
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 10:49:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C8883B8A;
	Thu,  8 Jan 2026 11:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="fnxWt1B8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130FF8410B; Thu,  8 Jan 2026 11:49:46 +0100 (CET)
Received: from mx-relay48-hz3.antispameurope.com
 (mx-relay48-hz3.antispameurope.com [94.100.134.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DCC83B87
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 11:49:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=04619a1675=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate48-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6,
 headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=jXfo09dz2DdhiIQX7KODKd1ZE5ku9uvrCWDut7MEKUU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1767869381;
 b=CzIJN4q1p09VsKp2p1779WpXTSFFRZgonTSZvCLOZHGZSiHcpKekrmbpV8EwqjWwbNkOcvHu
 pF+F08TwxhEgVycXgN51XV/OO6rBU3tRmu4IyvLsnKHuSKP+DpBQ+jDkTJGzj4GLAGDHf8LZpq8
 jd3l9I9HhMSntO+EM49YzC5aU98kXzrt83IoItcrkIZXlA5bLpO8tXpAOB/kjTQ1lkZn58K6ioU
 yXekfbfYKd3CoMc5rFbf9ADnkauvH0Svaqcr5s/+Hgo9zf+dAJ3eMuRoO+3a/hAw7Kvl2iHLjbl
 2WB0dSeMCA0J0vykXnLi6uWmIFoAuLg6d4GOw6u4z4zOw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1767869381;
 b=on0ntrrDQC9Z9BGXTP20YUNRSl+oGGFrQQhnkCITEWFaGMtJdY1Yo+a0h3pVSd+ckYlwKKMq
 yp+27kZbmTXnWbngaCLoI8WEVflxpNCkmV2KZbzfBNbtrg3Nrz2CkavyjIX94tDhZomCYQdcAJY
 1GAcxeibbaL1RwieZxpImZYeh6RT4z70Au6HNPpikVkDwdfd/AxeQ/zTFsZjEi1g6tslCcZJCiZ
 I8SZ+N18RXx0U+LRd+1GCNTVbrey4AkoTQ9lDCdSkmSINGeUgVHakptScJ0LHMmlrFQcQmCerCZ
 WmXegwWIS7UpwYLsc9fiArJLUeS4K0czOXMq5ZjmuR3kw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay48-hz3.antispameurope.com; Thu, 08 Jan 2026 11:49:41 +0100
Received: from [10.123.75.134] (host-82-135-125-110.customer.m-online.net
 [82.135.125.110]) (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 26EC5CC0E8B; Thu,  8 Jan 2026 11:49:21 +0100 (CET)
Message-ID: <71c47575-6a2e-4210-95c2-01cf36e55481@ew.tq-group.com>
Date: Thu, 8 Jan 2026 11:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on i.MX8M/AM62
 platforms
To: Peng Fan <peng.fan@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Vitor Soares <ivitro@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "vitor.soares@toradex.com" <vitor.soares@toradex.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>,
 "balsundar.ponnusamy@altera.com" <balsundar.ponnusamy@altera.com>
References: <95beb49733a28c7695dd0bf026b4ffe8c3fc73e3.camel@gmail.com>
 <d9978b24-65d5-4f8f-8ef9-e551c5baf9b9@ew.tq-group.com>
 <6e24770b-ea18-4678-90ef-6338bd40b147@altera.com>
 <20260108090428.GA5224@francesco-nb>
 <DB9PR04MB84613047013E58521989D84B8885A@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <DB9PR04MB84613047013E58521989D84B8885A@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay48-hz3.antispameurope.com with 4dn1qj5ZGXz1kNh4m
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 079d297bd67beac9316eb8fb364e2b8e
X-cloud-security: scantime:2.141
DKIM-Signature: a=rsa-sha256;
 bh=jXfo09dz2DdhiIQX7KODKd1ZE5ku9uvrCWDut7MEKUU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1767869380; v=1;
 b=fnxWt1B8X9SD6+R1S67PRLhcxzTzICte7gRMeaLfNwijEtn+L4JwpV0L0wDRFmWs/uvs+RY7
 wvhGVJ8TJxORzo7w+rFU5WnozBOjfoWiFZQURw8ZG3Hw6MOZPy8Hn8Cmyv/HmbjztlAPDYMX9cx
 sbv/0V5wOPNDrs7O/PfCLEe6Gu+grFmPXU1gvvqj/iDu37I/DcsfGE+DCzCtbGy3xhuCu9VCY+e
 w3YPAac2G3cT0VU2DbFERI8pAYIzgBoSlOqemhKXsoTaIjrmzhhG4RMziqkiWRgrN52UpZS6UK6
 wejSIc8e7Qw0hfC0FTExdKuJnz8LIGVBuDc4JfMX8mtpg==
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



Am 08.01.26 um 11:33 schrieb Peng Fan:
> Hi All,
> 
>> Subject: Re: [REGRESSION] mmc: "unable to select a mode: -5" on
>> i.MX8M/AM62 platforms
>>
>> On Thu, Jan 08, 2026 at 01:37:57PM +0530, Tanmay Kathpalia wrote:
>>> On 1/8/2026 12:32 PM, Max Merchel wrote:
>>>> Am 08.01.26 um 00:15 schrieb Vitor Soares:
>>>>> U-Boot 2026.01 fails to initialize MMC devices on multiple
>>>>> platforms with "unable to select a mode: -5" during
>> mmc_select_mode().
>>>>>
>>>>> Affected platforms:
>>>>> - Verdin iMX8M Mini (SPL boot failure - cannot boot at all)
>>>>> - Verdin iMX8M Plus (MMC init fails in U-Boot proper - cannot
>>>>> boot)
>>>>> - SMARC iMX8M Plus (MMC init fails in U-Boot proper)
>>>>> - Verdin AM62 (boot failure, no output)
>>>>>
>>>>> All platforms use eMMC and worked correctly prior to this
>> regression.
>>>>>
>>>>> Bisect results:
>>>>> - Last known good commit: 228810d0bac3
>>>>> - Known bad commit: 36aeeb591b0d
>>>>>
>>>>> Between these commits, several MMC-related changes were
>> merged.
>>>>> These seem particularly relevant:
>>>>> commit aebb523a2381 ("mmc: mmc-uclass: Use max-frequency
>> from
>>>>> device tree with default handling") commit 1e40e419aeb2 ("mmc:
>>>>> sdhci-cadence: Use max-frequency property from device
>>>>> tree")
>>>>> commit fa7e82127fad ("mmc: sdhci-cadence: Set controller and
>> PHY
>>>>> speed modes for SD and eMMC cards")
>>
>> ...
>>
>>> Thanks for the detailed report and bisect results. I've looked into
>>> the issue, and it appears the regression is introduced by commit
>>> aebb523a2381
>>> ("mmc: mmc-uclass: Use max-frequency from device tree with
>> default
>>> handling").
>>> The problem stems from the probe function in the FSL eSDHC driver
>>> (fsl_esdhc_probe). Here's a breakdown:
>>>
>>> First, fsl_esdhc_init is called, which sets cfg->f_max to the minimum
>>> of the controller's sdhc_clk and a hardcoded 200 MHz limit:
>>> cfg->f_max = min(priv->sdhc_clk, (u32)200000000);
>>> Subsequently, mmc_of_parse is invoked, where in the commit if the
>>> "max-frequency" property is not specified in the device tree node for
>>> the MMC controller, this function overrides cfg->f_max to 0.
>>>
>>> This results in f_max being set to 0, which prevents proper mode
>>> selection during MMC initialization and leads to the "unable to select
>> a mode: -5"
>>> error you're seeing across those platforms.
>>>
>>> A potential fix could involve either:
>>>
>>> Adding the "max-frequency" property to the relevant device tree
>> nodes
>>> (e.g., setting it to 200000000 or the appropriate value based on the
>> hardware).
>>
>> In general solving a regression in code, adjusting the DT is not ok in
>> Linux, not sure if the same reasoning would apply in the U-Boot use
>> case (considering that both U-Boot and DT are firmware).
> 
> Please see whether below changes could work on your platforms or not.
> It works on i.MX93.
> 
> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
> index bf0bea93853..a32cd25ba85 100644
> --- a/drivers/mmc/mmc-uclass.c
> +++ b/drivers/mmc/mmc-uclass.c
> @@ -249,7 +249,8 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
>           * will set the MMC configuration maximum frequency to the host controller's
>           * maximum base clock frequency from capabilities register.
>           */
> -       cfg->f_max = dev_read_u32_default(dev, "max-frequency", 0);
> +       if (!cfg->f_max)
> +               cfg->f_max = dev_read_u32_default(dev, "max-frequency", 0);
>   
>          if (dev_read_bool(dev, "cap-sd-highspeed"))
>                  cfg->host_caps |= MMC_CAP(SD_HS);
> 

Hi Pan,

the change prevents the function from being carried out on the iMX6.
Settings of max-frequency in dt are ignored because cfg->f_max has 
already been set initially.

-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

