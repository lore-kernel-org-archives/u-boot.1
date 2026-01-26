Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7D1D19520
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 22:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E4783BFE;
	Mon, 26 Jan 2026 23:15:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Qz/Z+reB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375B983F01; Mon, 26 Jan 2026 23:15:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8619383B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 23:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8ebe=AA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1769465749;
 bh=+pkg8PmC2j/qwoxjdcpGM54byJZDbncR6EALskHlPTg=;
 b=Qz/Z+reBciiA8dI2efkEoJkjDVaFEYqlXX4tlC6hYwNwPCek1XfL6aol1ZJjOK77l9gFOSwPO
 LUrhXoDpiMBvTfWcleXOY3mDkKToyZFWos+VcFfu0mQaMly3M4NhH4Hr8bZqCR0IAUPBBSP3JGX
 rGPQFdcPG3mt8A7Jp/ydGGGDnFnD2Yp7/xmgYqJy0tzM838dpS3XFOag0a7M05URDLAiyBiS6XS
 uiwBl2Gm0R/iSxRLNeWQ52xM+xJyoTbZU/ydIkLlM34A+iNZXMkWes3uHtneBSupYVNhynxvhPo
 JE0bZH3eCna2XnWps/uD52MOg5rQ9KNAiJS+912c6g3g==
X-Forward-Email-ID: 6977e793685398b2e40dea26
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <0e76f528-01c8-478d-9df6-7a3a4022a3d1@kwiboo.se>
Date: Mon, 26 Jan 2026 23:15:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] armv8: u-boot-spl.lds: Place binman symbols at end of
 binary
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260122172057.3212673-1-jonas@kwiboo.se>
 <aXbNxxNqePSlVUeq@shlinux89>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <aXbNxxNqePSlVUeq@shlinux89>
Content-Type: text/plain; charset=UTF-8
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

Hi Peng,

On 1/26/2026 3:13 AM, Peng Fan wrote:
> Hi Jonas,
> On Thu, Jan 22, 2026 at 05:20:54PM +0000, Jonas Karlman wrote:
>> It can be useful in xPL to access symbols from binman, such as the
>> offset/position and size of a binman entry.
> 
> Would you please disclose more details? What it will be used for?

The binman symbols can be used to get offsets of images in the binman
generated output, see [1] for U-Boot documentation and [2] for a feature
beside current normal usage of u-boot-img symbols in SPL.

Today the binman symbols will be spread out for ARMv8 SPL, this patch
concentrate the binman symbols to the end of the binary image, similar
to how it is handled for ARMv7 and RISC-V.

[1] https://docs.u-boot.org/en/latest/develop/package/binman.html#access-to-binman-entry-offsets-at-run-time-symbols
[2] https://lore.kernel.org/r/20260113143132.3401001-1-jonas@kwiboo.se

Regards,
Jonas

> 
> Thanks,
> Peng
> 
>>
>> Place these binman symbols together at the end of the xPL binary for
>> ARMv8, similar to ARM and RISC-V.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: Rebase on master after "arm: Update linker scripts to ensure
>>    appended device tree is aligned".
>> ---
>> arch/arm/cpu/armv8/u-boot-spl.lds | 8 ++++++++
>> 1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
>> index d9963846c4f4..b732133ce76d 100644
>> --- a/arch/arm/cpu/armv8/u-boot-spl.lds
>> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
>> @@ -55,6 +55,14 @@ SECTIONS
>> 		. = ALIGN(8);
>> 	} >.sram
>>
>> +	.binman_sym_table : {
>> +		. = ALIGN(8);
>> +		__binman_sym_start = .;
>> +		KEEP(*(SORT(.binman_sym*)));
>> +		__binman_sym_end = .;
>> +		. = ALIGN(8);
>> +	} > .sram
>> +
>> 	__image_copy_end = .;
>> 	_end = .;
>> 	_image_binary_end = .;
>> -- 
>> 2.52.0
>>

