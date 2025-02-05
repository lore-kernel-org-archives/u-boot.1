Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0030C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 19:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 146A980104;
	Wed,  5 Feb 2025 20:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pK7F9Dvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E14380562; Wed,  5 Feb 2025 20:36:37 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5441800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738784192;
 bh=BNd+DIYiBQhUPIkct48NtHj6CfLnFARpbcmnenG8ZdE=;
 b=pK7F9DvgDFF39GRhxZEzt52lYd/NOn7Lh+TW/Wsa5eJ5eE9HnudERuvXztQdB59TqLzqU8Az5
 l22A8Zqtfv23uo5nR1sJ2L2qN/v8TUVV0SBe1Evu49fLeXyfyuBwd7kGjfBUyr9zKH4X6wjsAPP
 y4M/f3DO3TlZ5l7wAmHwERlZFApT529jHgCHBicTEm5kbB3Bh5EdJgL17RmLImJxNx6Elyu+be0
 fSrvvP7+vSduQlYAHx7Otvcrqbjm9cmSdXDVBSmANjVuCjjzb4TPsfoRtztGmL+Ni1BpjrR9ht/
 EwIy/FJokkW6C25yi8D5G6N/PQCRprDKAM3tBP2HnkcA==
X-Forward-Email-ID: 67a3bdb84f7eea50c61f3732
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5caa2b45-ce86-44f2-aced-ff6df88f1635@kwiboo.se>
Date: Wed, 5 Feb 2025 20:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] rockchip: mkimage: Print image information for all
 embedded images
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-3-jonas@kwiboo.se>
 <6827e64d-a7a5-4dfb-9a90-800aa1bd40be@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6827e64d-a7a5-4dfb-9a90-800aa1bd40be@cherry.de>
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

On 2025-02-05 16:57, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>> The v2 image format can embed up to 4 data files compared to the two
>> init and boot data files using the older image format.
>>
>> Add support for displaying more of the image header information that
>> exists in the v2 image format, e.g. image load address and flag.
>>
>> Example for v2 image format:
>>
>>    > tools/mkimage -l rk3576_idblock_v1.09.107.img
>>    Rockchip Boot Image (v2)
>>    Image 1: 4096 @ 0x1000
>>    - Load address: 0x3ffc0000
>>    Image 2: 77824 @ 0x2000
>>    - Load address: 0x3ff81000
>>    Image 3: 262144 @ 0x15000
>>
>> Example for older image format:
>>
>>    > tools/mkimage -l u-boot-rockchip.bin
>>    Rockchip RK32 (SD/MMC) Boot Image
>>    Init Data: 20480 @ 0x800
>>    Boot Data: 112640 @ 0x5800
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   tools/rkcommon.c | 41 +++++++++++++++++++++++++++++++----------
>>   1 file changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index de3fd2d3f3c2..ad239917d2bd 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -331,8 +331,6 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>   	uint8_t *image_ptr = NULL;
>>   	int i;
>>   
>> -	printf("Image Type:   Rockchip %s boot image\n",
>> -		rkcommon_get_spl_hdr(params));
> 
> Not sure this change is related? It's also not replaced by anything if 
> I'm not mistaken, hence why I'm wondering why it's in this patch.

Following was meant as a replacement for this, in rkcommon_print_header_v2():

  printf("Rockchip Boot Image (v2)\n");

The old printf() was incorrectly done at set_header, not in print_header,
that is called after set_header or when you try to "mkimage -l <file>".

> 
>>   	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
>>   	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
>>   	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
>> @@ -486,6 +484,29 @@ int rkcommon_verify_header(unsigned char *buf, int size,
>>   	return -ENOENT;
>>   }
>>   
>> +static void rkcommon_print_header_v2(const struct header0_info_v2 *hdr)
>> +{
>> +	uint32_t val;
>> +	int i;
>> +
>> +	printf("Rockchip Boot Image (v2)\n");
>> +
>> +	for (i = 0; i < le16_to_cpu(hdr->num_images); i++) {
>> +		printf("Image %u: %u @ 0x%x\n",
>> +		       le32_to_cpu(hdr->images[i].counter),
>> +		       le16_to_cpu(hdr->images[i].size) * RK_BLK_SIZE,
>> +		       le16_to_cpu(hdr->images[i].offset) * RK_BLK_SIZE);
>> +
>> +		val = le32_to_cpu(hdr->images[i].address);
>> +		if (val != 0xFFFFFFFF)
> 
> Can you explain why this value is explicitly excluded? I know this is 
> the 4GiB boundary but why does it matter?

It is used as the default value, unknown why, see:

  @address:	load address (default as 0xFFFFFFFF)

Can probably add a code comment here as well.

> 
>> +			printf("- Load address: 0x%x\n", val);
>> +
>> +		val = le32_to_cpu(hdr->images[i].flag);
>> +		if (val)
>> +			printf("- Flag: 0x%x\n", val);
> 
> Matter of taste but the dashes were bothering me when parsing the output 
> with my eyes, two spaces could work better. In any case, not a big deal 
> to me.

Will see what I can do, initially I indented to align with the size @
offset and changed to the dash just before sending.

> 
>> +	}
>> +}
>> +
>>   void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>   {
>>   	struct header0_info header0;
>> @@ -502,8 +523,7 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>   			return;
>>   		}
>>   
>> -		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
>> -		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
>> +		rkcommon_print_header_v2(&header0_v2);
>>   	} else {
>>   		ret = rkcommon_parse_header(buf, &header0, &spl_info);
>>   
>> @@ -521,15 +541,16 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>   		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
>>   			    init_size;
>>   
>> -		printf("Image Type:   Rockchip %s (%s) boot image\n",
>> -		       spl_info->spl_hdr,
>> +		printf("Rockchip %s (%s) Boot Image\n", spl_info->spl_hdr,
>>   		       (image_type == IH_TYPE_RKSD) ? "SD/MMC" : "SPI");
> 
> Please keep "Image Type:" this is what's used for other SoC vendors 
> also, I assume some tooling could be parsing it.

Sure, will restore the "Image Type:" prefix here and for "Rockchip Boot
Image (v2)" above. Should probably also adjust "tools: mkimage: Add
Amlogic Boot Image type" [1] to do the same.

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250103215904.2590769-2-jonas@kwiboo.se/

Regards,
Jonas

> 
> Looking good otherwise,
> Cheers,
> Quentin

