Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D00CC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E4E80104;
	Wed,  5 Feb 2025 17:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="M+i9YbRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C31298033D; Wed,  5 Feb 2025 17:42:59 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462BE8003E
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:42:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738773775;
 bh=bF+5FaGYR40IEDFNNRLwYTO06/63qoPW+drEYAvxvDA=;
 b=M+i9YbROIEHNheZ5HKIt7Eivjv/qEQ5Wn5SB4k0orfgV4XsmgfHQa3zRDRDQXR4YMEvUPokiR
 1G85BPrJniHLw2kfj8TnIXXKR6LinczdnCthsAMFZEtNdaxLq1DVUFPB94wOrhvyQTN9wyJC5AM
 lOSkSLhI/QWXKLMtnikTBAvyd3YZWNdxo06/LOwZbJFk+XZ2uu/LG0Euhiv8n576zOK6/pja6tZ
 03xBxEG3oQl8tGb39VKzvggBE+7Symnfqlys1pD63ry/Lojzj0NzP/3ttHR66v4KbQfgKSnLqHX
 nuWLLcFu10Se/tU8Dt0ZPnDOM6BIcNpaZ6z+1cUveaFw==
X-Forward-Email-ID: 67a3950dfb44099d0e595155
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <511da0ca-bda7-4ab9-9a4f-b28d638c9343@kwiboo.se>
Date: Wed, 5 Feb 2025 17:42:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] rockchip: mkimage: Print boot0 and boot1 parameters
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-4-jonas@kwiboo.se>
 <d50be23f-ef3e-46f6-8862-32bc18903bb2@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d50be23f-ef3e-46f6-8862-32bc18903bb2@cherry.de>
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

Hi Quentin,

On 2025-02-05 17:04, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>> The v2 image format embeds boot0 and boot1 parameters, the vendor tool
>> boot_merger may write these parameters based on the rkboot miniall.ini
>> files.
>>
>> E.g. a RK3576 boot image may contain a boot1 parameter that signals
>> BootROM or vendor blobs to use 1 GHz instead of the regular 24 MHz rate
>> for the high precision timer.
>>
>> Add support for printing boot0 and boot1 parameters, e.g.:
>>
>>    > tools/mkimage -l rk3576_idblock_v1.09.107.img
>>    Rockchip Boot Image (v2)
>>    Boot1 2: 0x100
>>    Image 1: 4096 @ 0x1000
>>    - Load address: 0x3ffc0000
>>    Image 2: 77824 @ 0x2000
>>    - Load address: 0x3ff81000
>>    Image 3: 262144 @ 0x15000
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   tools/rkcommon.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index ad239917d2bd..324820717663 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -62,6 +62,8 @@ struct image_entry {
>>    * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
>>    * @images:	images
>>    * @hash:	hash or signature for header info
>> + *
>> + * Other fields are not used by U-Boot
>>    */
>>   struct header0_info_v2 {
>>   	uint32_t magic;
>> @@ -69,7 +71,9 @@ struct header0_info_v2 {
>>   	uint16_t size;
>>   	uint16_t num_images;
>>   	uint32_t boot_flag;
>> -	uint8_t reserved1[104];
>> +	uint8_t reserved1[32];
>> +	uint32_t boot0_param[10];
>> +	uint32_t boot1_param[8];
>>   	struct image_entry images[4];
>>   	uint8_t reserved2[1064];
>>   	uint8_t hash[512];
>> @@ -491,6 +495,18 @@ static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
>>   
>>   	printf("Rockchip Boot Image (v2)\n");
>>   
>> +	for (i = 0; i < ARRAY_SIZE(hdr->boot0_param); i++) {
>> +		val = le32_to_cpu(hdr->boot0_param[i]);
>> +		if (val)
>> +			printf("Boot0 %d: 0x%x\n", i, val);
>> +	}
>> +
> 
> This seems to indicate that there are 10 4B params for boot0, is that 
> correct? If that's the case I would at least add "param" before %d, the 
> output looked odd to me at first glance.

That should be correct and is what boot_merger can embed based on the
[BOOT0_PARAM] section and WORD_n (n=0-9) values from MINIALL.ini.

The only reason I skipped "param" was because I thought it looked
prettier to align the "BootX %d" and "Image %d" in the output, can
change to include "param" :-)

> 
> If they aren't guaranteed to be individual 4B params, what about just 
> printing the whole boot0_param in hex format?

There is only very few WORD_ values in use in linux-6.1-stan-rkr5 rkbin
MINIALL.ini files. So I opted to only print out the params that have a
value different from the default 0x0.

> 
>> +	for (i = 0; i < ARRAY_SIZE(hdr->boot1_param); i++) {
>> +		val = le32_to_cpu(hdr->boot1_param[i]);
>> +		if (val)
>> +			printf("Boot1 %d: 0x%x\n", i, val);
>> +	}
>> +
> 
> Same remark as for boot0 params instead with 8 4B params for boot1.

Correct, boot_merger embed WORD_n (n=0-7) from the [BOOT1_PARAM] section
and also only very few are in use.

My main test to validate this was to add different values to WORD_n
under BOOT0/BOOT1_PARAM and then compare with the generated idblock.img.

Regards,
Jonas

> 
> Cheers,
> Quentin

