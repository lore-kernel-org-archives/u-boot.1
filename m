Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC1BC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 18:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8F880104;
	Wed,  5 Feb 2025 19:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="t6XF4xtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CBE980104; Wed,  5 Feb 2025 19:50:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F560800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 19:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738781431;
 bh=dXg0cGEsOAwNzttSsBEczPGY3XZ4YSSryhvfWXnm4pE=;
 b=t6XF4xtlzfAaK4yZQyJQRw2QxYNjcZj6Z9MGw25Rbb9Ljwu7suS8nMISfXwUTlY38sCRjkIhL
 D5sV4fb4cQTxY6kW7L0o9Td8xXLhKVBX44f/lgQg3Gs9BLpBCctibNyFKOCklRVHbAVDHFpW4XI
 Oi1pxTNEvw15sLhNX1CIWFHLJSRYmZlBlop23Fn8Dh7cm64rXrIn13CjAEK2DMr6+UlPobvSyy9
 5LpBDEZ65bG0hxUfp4+B/fEdiLjYRxlHIqzleriLmn/V2VALxVmCKtFb1+dh1If91msNaz4IxGz
 KDg04a0XxQIEZi4w2YdGGyftdqK8j7fM4yKo8UUWfYTg==
X-Forward-Email-ID: 67a3b2f54f7eea50c61f33bc
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <4b904cbb-cc39-45ef-ae5e-3eb2cf161e54@kwiboo.se>
Date: Wed, 5 Feb 2025 19:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] rockchip: mkimage: Split size_and_off and
 size_and_nimage
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-2-jonas@kwiboo.se>
 <18e356d3-de3b-4021-8ffe-e0b33d5db2cf@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <18e356d3-de3b-4021-8ffe-e0b33d5db2cf@cherry.de>
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

On 2025-02-05 16:40, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>> Split 32-bit size_and_off and size_and_nimage fields of the v2 image
>> format header into their own 16-bit size, offset and num_images fields.
>>
>> Set num_images based on number of images passed by the datafile
>> parameter and size based on the offset to the hash field to fix using a
>> single init data file and no boot data file for the v2 image format.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   tools/rkcommon.c | 44 ++++++++++++++++++++++++--------------------
>>   1 file changed, 24 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index 3e52236b15a8..de3fd2d3f3c2 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -34,15 +34,16 @@ enum hash_type {
>>   /**
>>    * struct image_entry
>>    *
>> - * @size_and_off:	[31:16]image size;[15:0]image offset
>> - * @address:	default as 0xFFFFFFFF
>> + * @offset:	image offset (unit as 512 byte blocks)
>> + * @size:	image size (unit as 512 byte blocks)
>> + * @address:	load address (default as 0xFFFFFFFF)
>>    * @flag:	no use
>>    * @counter:	no use
>>    * @hash:	hash of image
>> - *
>>    */
>>   struct image_entry {
>> -	uint32_t size_and_off;
>> +	uint16_t offset;
>> +	uint16_t size;
>>   	uint32_t address;
>>   	uint32_t flag;
>>   	uint32_t counter;
>> @@ -56,16 +57,17 @@ struct image_entry {
>>    * This is stored at SD card block 64 (where each block is 512 bytes)
>>    *
>>    * @magic:	Magic (must be RK_MAGIC_V2)
>> - * @size_and_nimage:	[31:16]number of images;[15:0]
>> - *			offset to hash field of header(unit as 4Byte)
>> - * @boot_flag:	[3:0]hash type(0:none,1:sha256,2:sha512)
>> - * @signature:	hash or signature for header info
>> - *
>> + * @size:	offset to hash field of header (unit as 4 bytes)
>> + * @num_images:	number of images
>> + * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
>> + * @images:	images
>> + * @hash:	hash or signature for header info
>>    */
>>   struct header0_info_v2 {
>>   	uint32_t magic;
>>   	uint8_t reserved[4];
>> -	uint32_t size_and_nimage;
>> +	uint16_t size;
>> +	uint16_t num_images;
>>   	uint32_t boot_flag;
>>   	uint8_t reserved1[104];
>>   	struct image_entry images[4];
>> @@ -332,17 +334,18 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>   	printf("Image Type:   Rockchip %s boot image\n",
>>   		rkcommon_get_spl_hdr(params));
>>   	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
>> -	hdr->magic   = cpu_to_le32(RK_MAGIC_V2);
>> -	hdr->size_and_nimage = cpu_to_le32((2 << 16) + 384);
>> +	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
>>   	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
>>   	sector_offset = 4;
>>   	image_size_array[0] = spl_params.init_size;
>>   	image_size_array[1] = spl_params.boot_size;
>>   
>>   	for (i = 0; i < 2; i++) {
>> +		if (!image_size_array[i])
>> +			break;
> 
> This isn't related to this change I believe, can you please make it its 
> own commit so it doesn't get lost in the diff and has its own individual 
> commit log?

Yeah, I mostly wanted/needed a test to stop the loop on the "last"
supplied input file/image in a later patch. Adding it here made the
later diff little bit smaller :-)

> 
>>   		image_sector_count = image_size_array[i] / RK_BLK_SIZE;
>> -		hdr->images[i].size_and_off = cpu_to_le32((image_sector_count
>> -							<< 16) + sector_offset);
>> +		hdr->images[i].offset = cpu_to_le16(sector_offset);
>> +		hdr->images[i].size = cpu_to_le16(image_sector_count);
>>   		hdr->images[i].address = 0xFFFFFFFF;
>>   		hdr->images[i].counter = cpu_to_le32(i + 1);
>>   		image_ptr = buf + sector_offset * RK_BLK_SIZE;
>> @@ -351,6 +354,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>   		sector_offset = sector_offset + image_sector_count;
>>   	}
>>   
>> +	hdr->num_images = cpu_to_le16(i);
>> +	hdr->size = cpu_to_le16(offsetof(typeof(*hdr), hash) / sizeof(uint32_t));
> 
> Same here. Just do a migration commit (possibly one for struct 
> image_entry and another one for struct header0_info_v2) first and then 
> adapt so it handles image_size_array[1] = 0. We don't today so a 
> separate patch explaining the usecase would be nice.

I was trying to avoid having to create too many commits, and mostly
cared about the end result, guess I can split this even further in a v2.

All in-tree use from binman will always supply two input files/images
for v2 image format, so has not really been an issue or need to handle
image_size_array[1] = 0, not sure what would happen if you try to run
mkimage manually without the second boot image.

> 
>>   	do_sha256_hash(buf, (void *)hdr->hash - buf, hdr->hash);
>>   }
>>   
>> @@ -497,10 +502,8 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>   			return;
>>   		}
>>   
>> -		init_size = header0_v2.images[0].size_and_off >> 16;
>> -		init_size = init_size * RK_BLK_SIZE;
>> -		boot_size = header0_v2.images[1].size_and_off >> 16;
>> -		boot_size = boot_size * RK_BLK_SIZE;
>> +		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
>> +		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
> 
> Ditto. Separate patch for the le16_to_cpu would be nice as I assume this 
> is not a side-effect of switching to two u16 instead of one u32. This 
> likely fixes a bug :)

I have no idea if any of this was or is really working on big-endian
prior to (or after), there was some bit manipulation and change to
use leXX_to_cpu seemed appropriate, will try to split it out in v2.
Could possible try to use qemu for some big-endian testing.

> 
> I was wondering if we shouldn't have CI to generate a handful of 
> Rockchip dummy binaries with the header on different endianness so we 
> can catch those. I remember we had someone fix those for v1 already.

Sound like a nice task for someone else :-)

> 
>>   	} else {
>>   		ret = rkcommon_parse_header(buf, &header0, &spl_info);
>>   
>> @@ -514,8 +517,9 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>   		}
>>   
>>   		image_type = ret;
>> -		init_size = header0.init_size * RK_BLK_SIZE;
>> -		boot_size = header0.init_boot_size * RK_BLK_SIZE - init_size;
>> +		init_size = le16_to_cpu(header0.init_size) * RK_BLK_SIZE;
>> +		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
>> +			    init_size;
>>   
> 
> Ditto, separate patch for le16_to_cpu.

Sure, will split out to a few more patches for v2.

Regards,
Jonas

> 
> Looks good otherwise!
> 
> Cheers,
> Quentin

