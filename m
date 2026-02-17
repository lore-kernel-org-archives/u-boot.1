Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B7E6815D
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 10:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A4B83981;
	Tue, 17 Feb 2026 11:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Fq4AiCN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A970383981; Tue, 17 Feb 2026 11:12:09 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768018063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 63FAA10EB15; Tue, 17 Feb 2026 11:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771323125;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=Kxwnpkk7G9iORAgCfXJQNWf1mcu994Koeb8OXcBXXS4=;
 b=Fq4AiCN3m16K0SPAI6ZffSJjJzlTwoana4Jd6BvkUkulRqo4yC5126p4eKJemuvR6LQgWk
 pWis4U+BspEIq2tJRonlM3bF+Cl4370PyVBhRpSnVs3myrXHQkaWdP4n0jRri9euhg4Dxr
 jZn/1diMwTWsVkL2n1vchHGx3zenb9l/jscyEj0IpYUrkEdtNFgWNGVBUUV3pgu6lKZ6Ko
 8Aa1q4u0mXcJAolPpoqa46zH9yz0qDKX2/64W3kr3XNDdnSsmPwp6thz1bbAp/X+08Irbq
 G6KD7jG2iOX3J0LV1cGPDGQsowJATVuZBNsDvH3Jg+mc59QyfN0VjHB5aZ8NNA==
Message-ID: <ba5d329a-2e8d-51dd-e0e6-36954a91260d@nabladev.com>
Date: Tue, 17 Feb 2026 11:12:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 2/2] arch: imx8qxp: Override weak
 fb_mmc_get_boot_offset function
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260210054345.126651-1-hs@nabladev.com>
 <20260210054345.126651-3-hs@nabladev.com> <87jywbk82e.fsf@kernel.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <87jywbk82e.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Matjis,

On 17.02.26 10:55, Mattijs Korpershoek wrote:
> Hi Heiko,
> 
> On Tue, Feb 10, 2026 at 06:43, Heiko Schocher <hs@nabladev.com> wrote:
> 
>> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>>
>> Add IMX8QXP SoCs specific implementation of fb_mmc_get_boot_offset()
>>
>> This is needed as bootloader offset is different dependent on SoC
>> revision!
>>
>> For revision B0 the bootloader starts at 32k offset. On offset
>> 0x0 the bootloaders environment is stored.
>>
>> On C0 revisions of the SoC bootloader image starts at offset 0x0
>>
>> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
>> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
> Peng did provide some review feedback here:
> https://lore.kernel.org/all/aXbHDnU+SpgnEt+Q@shlinux89/
> 
> I have not seen a response to that. Could you please respond there why
> you did not apply his suggestion?

Seems I missed that email :-(

Yep, that seems a better approach, I will change and send a v3!

Thanks!

bye,
Heiko
> 
>>
>> ---
>>
>> Changes in v2:
>> - added Reviewed-by from Mattijs
>>
>>   arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
>> index 0e112af661c..27c431881b0 100644
>> --- a/arch/arm/mach-imx/imx8/cpu.c
>> +++ b/arch/arm/mach-imx/imx8/cpu.c
>> @@ -899,3 +899,24 @@ bool m4_parts_booted(void)
>>   
>>   	return false;
>>   }
>> +
>> +#ifdef CONFIG_IMX8QXP
>> +#include <blk.h>
>> +
>> +/*
>> + * On B0 revision SoCs the bootloader is on 32k offset
>> + * and at offset 0x0 is the U-Boot Environment stored
>> + *
>> + * So we cannot flash bootloader images to offset 0x0
>> + *
>> + * On C0 revisions of the SoC bootloader image starts
>> + * at offset 0x0 ...
>> + */
>> +lbaint_t fb_mmc_get_boot_offset(void)
>> +{
>> +	if ((get_cpu_rev() & 0xF) == CHIP_REV_C)
>> +		return 0;
>> +
>> +	return 0x40;
>> +}
>> +#endif
>> -- 
>> 2.20.1

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
