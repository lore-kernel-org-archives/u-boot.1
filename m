Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC723CEF158
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 11:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC721889FC;
	Tue,  8 Oct 2024 13:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="G7jDiF9n";
	dkim=pass (1024-bit key; unprotected) header.d=amazonses.com header.i=@amazonses.com header.b="b+ZpjWBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 412F288B58; Tue,  8 Oct 2024 13:41:24 +0200 (CEST)
Received: from a7-47.smtp-out.eu-west-1.amazonses.com
 (a7-47.smtp-out.eu-west-1.amazonses.com [54.240.7.47])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF5A5889E1
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 13:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=010201926bef0b2e-c1230e3e-a51a-4953-9c41-c2b116ac28ed-000000@amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=bc7lryepznv65m6r2ewkpoafjt4fiq42; d=collabora.com; t=1728387681;
 h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=SsDwm6lbevrkJZhvrUmGqaOXypkVcaU2h8vhl6a7/jE=;
 b=G7jDiF9nmNYY/XTyxPswnTYCdXAPNyosJO1v+lKXPn7a3oJ9GHRGO5VVUIiheQ+v
 icBan5vQAXae90GH1GNYyIyHXj6/lSYzAKt1e5ns9M2xu4fHvBWYQK17RY2S6Q2AbFM
 fFRcsXj6arLFrn/LGYC7IJgCajEVwWiU6wQsZaMuRN/Lt6nvx8lG1pE59sEpPjpaBpG
 znboX6HkE/kgJTzXD3gMIbp/ltWbFqCzI+Bh94EYJYO8AM79FsYLsbZZ4hsGa/oVm2C
 cjqQGLg5dtwQ9n4m7UYtM3PZZuPpZ7f5l5N4wpCAavnI8wGC6ug1VMM/hGUiUuRHOm2
 G90fXuNXyg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1728387681;
 h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
 bh=SsDwm6lbevrkJZhvrUmGqaOXypkVcaU2h8vhl6a7/jE=;
 b=b+ZpjWBnqc/toK9CRx8h/Tj8nUY7UVuf47CrqXI7XspNacsG91p1cCvW2sZXD0qp
 txYVanl53W2OHCMvh9n4ZL82MSR/OVxpcwy77z10V+B790rvpOtLJSgTmsFmNID+J8i
 bh9JDatZ4PysSYns+yWbNLLeZlKANYOXUk4/8bow=
Message-ID: <010201926bef0b2e-c1230e3e-a51a-4953-9c41-c2b116ac28ed-000000@eu-west-1.amazonses.com>
Date: Tue, 8 Oct 2024 11:41:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Mihai Sain <mihai.sain@microchip.com>, Li Bin <bin.li@microchip.com>, 
 u-boot@lists.denx.de, Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.10.08-54.240.7.47
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

On 9/30/24 11:07, Alexander Dahl wrote:
> Hello,
> 
> Am Tue, May 28, 2024 at 12:32:44PM +0200 schrieb Alexander Dahl:
>> Hei hei,
>>
>> Am Mon, Apr 15, 2024 at 09:57:55AM +0200 schrieb Alexander Dahl:
>>> From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
>>> like we have to wait tREA after rising RE# before sampling the data.
>>> Thus pulse time must be at least tREA.
>>>
>>> Without this fix we got PMECC errors when reading, after switching to
>>> ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chip.
>>>
>>> The approach to set timings used before worked on sam9g20 and sama5d2
>>> with the same flash (S34ML02G1), probably because those have a slower
>>> mck clock rate and thus the resolution of the timings setup is not as
>>> tight as with sam9x60.
>>>
>>> The approach to fix the issue was carried over from at91bootstrap, and
>>> has been successfully tested in at91bootstrap, U-Boot and Linux.
>>>
>>> Link: https://github.com/linux4sam/at91bootstrap/issues/174
>>> Cc: Li Bin <bin.li@microchip.com>
>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>> ---
>>>
>>> Notes:
>>>     v3:
>>>     - initial patch version (not present in v1 and v2)
>>
>> This patch was send as part of a series, which you wanted to have some
>> more time to test.  Besides that, has anyone looked into this
>> particular fix?  Maybe it can be applied separately?
> 
> I'd kindly ask what the status of this patch series is from U-Boot
> NAND subsystem maintainers POV?  Could you test it?  Should I rebase
> and resend?
> 
> Two of these three patches are specific to at91 family, what's the
> opinion of at91 maintainers on this?

Hello Alexander,

From at91 perspective I have no objections.
As these are very NAND specific, I defer the patches to the NAND maintainers.

Eugen

> 
> Link to the series discussion for reference:
> 
> https://lore.kernel.org/u-boot/20240415074547.779264-1-ada@thorsis.com/T/#u
> 
> Greets
> Alex
> 
>>
>> Greets
>> Alex
>>
>>>
>>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
>>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> index bbafc88e44c..00ffeadd113 100644
>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> @@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>>>  					  const struct nand_data_interface *conf,
>>>  					  struct atmel_smc_cs_conf *smcconf)
>>>  {
>>> -	u32 ncycles, totalcycles, timeps, mckperiodps;
>>> +	u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
>>>  	struct atmel_nand_controller *nc;
>>>  	int ret;
>>>  
>>> @@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>>>  			 ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
>>>  
>>>  	/*
>>> -	 * Read pulse timing directly matches tRP:
>>> +	 * Read pulse timing would directly match tRP,
>>> +	 * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
>>> +	 * do not work properly in timing mode 3.
>>> +	 * The workaround is to extend the SMC NRD pulse to meet tREA
>>> +	 * timing.
>>>  	 *
>>> -	 * NRD_PULSE = tRP
>>> +	 * NRD_PULSE = max(tRP, tREA)
>>>  	 */
>>> -	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
>>> +	pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
>>> +	ncycles = DIV_ROUND_UP(pulse, mckperiodps);
>>>  	totalcycles += ncycles;
>>>  	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
>>>  					  ncycles);
>>> -- 
>>> 2.39.2
>>>
>>

