Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA5DC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88767405BA;
	Thu,  6 Aug 2026 13:16:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lFB6jzqZdeGt; Thu,  6 Aug 2026 13:16:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46E4B403A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786022196;
	bh=Z8Uy3Rf3RUQ6BlDeaEvpnR8MoDPiLUe9wGYG7txGLY8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GcMu639Qog/Ly4aE5eaxbGRTZbF80FUDMIbInB4mDkhGGgDk36HxzDTQLnvb4Bmvc
	 NUqKG8DrztyBStFROS4kHsqsIqGz08tCNejTk+wB/5uIWo29NA55WE7PyKkVAJynn4
	 ht+H8B6bF8RlJdXkKlAy+KyYrfRtP3kNanUHScopmSFNiTzP/cPjiXGgHggKaZt+V2
	 VUn3luDvxp6XfEPuhhXsQ37ktmjjU8Y3Bq+6HzOp+aRrTSuIKKN+SkdQY/ZvsnM70t
	 RHGDFB9nj3npdzN2twf5rxqmxrCX6HoE9PYU3UZFHD34nlKDuvqsBq6MedQm7Pp92K
	 F4ZW4GANRIRjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46E4B403A9;
	Thu,  6 Aug 2026 13:16:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5678198
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6E7B4027D
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:16:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8em9RRlpnYSY for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:16:34 +0000 (UTC)
X-Greylist: delayed 329 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 06 Aug 2026 13:16:32 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5D7F34027C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D7F34027C
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=121.127.44.73;
 helo=smtp.forwardemail.net;
 envelope-from=srs0=165c=ga=kwiboo.se=jonas@fe-bounces.kwiboo.se;
 receiver=<UNKNOWN> 
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D7F34027C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:16:32 +0000 (UTC)
X-Forward-Email-ID: 6a7487926cacfbe9118d54f4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.13.10
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <df2d1736-1498-4620-91da-1faa0cdfa14e@kwiboo.se>
Date: Thu, 6 Aug 2026 15:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] rockchip: mkimage: Split size_and_off and
 size_and_nimage
To: Quentin Schulz <u-boot@0leil.net>, Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-1-9d23aa08f674@flipper.net>
 <521c648b-9941-4e95-b3e3-4ca69f6c4c6b@0leil.net>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <521c648b-9941-4e95-b3e3-4ca69f6c4c6b@0leil.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kwiboo.se; 
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1786022191;
 bh=Z8Uy3Rf3RUQ6BlDeaEvpnR8MoDPiLUe9wGYG7txGLY8=;
 b=zbZs7QL4TVnQkKa6pTL+82+Kj7w5SmuF0Kkpi03lVAUyhtI3TpoyO/IRAs3JyPIZJEfhVo0uk
 NoPfRLV0D9x2pVxE9llkwF1G29r4I4Cio7c9rNsN+4FgX51Yiwx1SrCzJ6peD8ZMDWOEeFWgpjc
 FDBYZh86HWF1s2fszIPPJa8I8JmJtFbNFrGx17rGbcTiPV2jvrmXGLtKqK8nHlFNWkePQzhXhak
 i6FTj+y0ZcmFW5LkL3v6j/gk4LZPRKnk6Dcl0Rg/RBwMQg82j5zK5rbQ8o/QrchMJfkuH3mREfp
 48QruVAnRHPXOd71sYc2yn9ZLVlGbC8vJtfFcBZr4NcA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.a=rsa-sha256
 header.s=fe-e1b5cab7be header.b=zbZs7QL4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Quentin,

On 8/6/2026 1:15 PM, Quentin Schulz wrote:
> Hi Alexey,
> 
> On 7/13/26 12:02 PM, Alexey Charkov wrote:
>> From: Jonas Karlman <jonas@kwiboo.se>
>>
>> Split 32-bit size_and_off and size_and_nimage fields of the v2 image
>> format header into their own 16-bit size, offset and num_images fields.
>>
>> Set num_images based on number of images passed by the datafile
>> parameter and size based on the offset to the hash field to fix using a
>> single init data file and no boot data file for the v2 image format.
>>
> 
> When you need to start listing things you do in a commit, it means it 
> needs to be split into multiple individual commits doing one thing at a 
> time. I appreciate this is taken from Jonas's tree but it's fine to 
> modify (well, from a maintainer's perspective at least :) ). Please list 
> between Jonas's and your Signed-off-by what you changed since Jonas's 
> version, in square brackets.
> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>> ---
>>   tools/rkcommon.c | 44 ++++++++++++++++++++++++--------------------
>>   1 file changed, 24 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index b39777fc0607..034896d57f80 100644
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
> 
> Can it be anything but 0xFFFFFFFF? It's not even configurable currently.
> 
>>    * @flag:	no use
>>    * @counter:	no use
>>    * @hash:	hash of image
>> - *
>>    */
>>   struct image_entry {
>> -	uint32_t size_and_off;
>> +	uint16_t offset;
>> +	uint16_t size;
> 
> Do we need to start __attribute__ ((__packed__))'ing the structure to 
> make sure there's no padding involved ever?
> 
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
> 
> I'm assuming we mean "unit as multiples of 4 bytes"? Is that correct? 
> Can we say that instead, I find it clearer.
> 
>> + * @num_images:	number of images
> 
> Can we improve this documentation as well? I'm assuming this is the 
> number of images stored in idbloader.img (so typically SPL + optionally 
> TPL + optionally VPL/boost?)
> 
>> + * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
>> + * @images:	images
> 
> Not sure this is helping, either specify what those are or simply don't 
> comment.
> 
>> + * @hash:	hash or signature for header info
>>    */
>>   struct header0_info_v2 {
>>   	uint32_t magic;
>>   	uint8_t reserved[4];
>> -	uint32_t size_and_nimage;
>> +	uint16_t size;
>> +	uint16_t num_images;
> 
> Do we need to start __attribute__ ((__packed__))'ing the structure to 
> make sure there's no padding involved ever?
> 
> Side question, should we start using the proper expected endianness 
> here? e.g. __le16/__le32 instead of uint32_t and uint16_t? What do you 
> think?
> 
>>   	uint32_t boot_flag;
>>   	uint8_t reserved1[104];
>>   	struct image_entry images[4];
>> @@ -351,17 +353,18 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>   	printf("Image Type:   Rockchip %s boot image\n",
>>   		rkcommon_get_spl_hdr(params));
>>   	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
>> -	hdr->magic   = cpu_to_le32(RK_MAGIC_V2);
>> -	hdr->size_and_nimage = cpu_to_le32((2 << 16) + 384);
>> +	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
> 
> Please don't mix cosmetic changes as those and logic changes, in the 
> same commit. The whitespaces removal makes it harder to identify quickly 
> what is actually changed.
> 
>>   	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
>>   	sector_offset = 4;
>>   	image_size_array[0] = spl_params.init_size;
>>   	image_size_array[1] = spl_params.boot_size;
>>   
>>   	for (i = 0; i < 2; i++) {
>> +		if (!image_size_array[i])
>> +			break;
>>   		image_sector_count = image_size_array[i] / RK_BLK_SIZE;
>> -		hdr->images[i].size_and_off = cpu_to_le32((image_sector_count
>> -							<< 16) + sector_offset);
>> +		hdr->images[i].offset = cpu_to_le16(sector_offset);
>> +		hdr->images[i].size = cpu_to_le16(image_sector_count);
>>   		hdr->images[i].address = 0xFFFFFFFF;
>>   		hdr->images[i].counter = cpu_to_le32(i + 1);
>>   		image_ptr = buf + sector_offset * RK_BLK_SIZE;
>> @@ -370,6 +373,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>   		sector_offset = sector_offset + image_sector_count;
>>   	}
>>   
>> +	hdr->num_images = cpu_to_le16(i);
> 
> Is it though? if image_size_array[i] is 0, it means nothing was passed 
> as the i+1th image to mkimage -T rksd/rkspi -d no?
> 
>> +	hdr->size = cpu_to_le16(offsetof(typeof(*hdr), hash) / sizeof(uint32_t));
>>   	do_sha256_hash(buf, (void *)hdr->hash - buf, hdr->hash);
>>   }
>>   
>> @@ -516,10 +521,8 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>   			return;
>>   		}
>>   
>> -		init_size = header0_v2.images[0].size_and_off >> 16;
>> -		init_size = init_size * RK_BLK_SIZE;
>> -		boot_size = header0_v2.images[1].size_and_off >> 16;
>> -		boot_size = boot_size * RK_BLK_SIZE;
>> +		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
>> +		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
>>   	} else {
>>   		ret = rkcommon_parse_header(buf, &header0, &spl_info);
>>   
>> @@ -533,8 +536,9 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
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
> I could identify multiple commits to be split out of this one:
> - update documentation,
> - whitespace around ->magic assignment,
> - break the loop when image_size_array[i] is 0,
> - properly translate init_size/boot_size into CPU endianness,
> - split size_and_nimage u32 into two u16,
> - split size_and_off u32 into two u16,
> - programmatically set ->size,
> - programmatically set ->num_images,

As stated to Alexey previously I have started re-working my old series
to address your old review comments, current local version have:

b86f1ed33d9d WIP: rockchip: mkimage: Compare full string when matching imagename
d849f5710a62 WIP: rockchip: mkimage: Print image-type for the v2 format
690bd184c62f WIP: rockchip: mkimage: use le16/le32_to_cpu when reading header fields
01e1ce9ccab4 WIP: rockchip: mkimage: static assert
d5b2191eae34 WIP: rockchip: mkimage: split size_and_off in struct image_entry
0bbb7bf20348 WIP: rockchip: mkimage: split size_and_nimage in struct header0_info_v2
4f1cc2100120 WIP: rockchip: mkimage: Set header size based on offset to hash
2031ef00ddaa rockchip: mkimage: Split size_and_off and size_and_nimage
deae586379d8 rockchip: mkimage: Print image information for all embedded images
15867436697d rockchip: mkimage: Print image information for all embedded images
c5f38fe9aa85 rockchip: mkimage: Print boot0 and boot1 parameters
c03eda77d517 WIP: rockchip: mkimage: Print hash algo and image hash value
c28f75ab3d22 WIP: rockchip: mkimage: Print signature type
744b76c3e716 WIP: rockchip: mkimage: Extract and use rkcommon_get_aligned_filesize()
e667ac1ff977 WIP: rockchip: mkimage: Extract and use rkcommon_get_header_size()
776f4b84625f rockchip: mkimage: Add option to change image offset alignment
403e40c9fe80 rockchip: mkimage: Add support for up to 4 input files

But I have not completed addressing all review comments yet, will be
sending a v2 of my original series in a few days.

Regards,
Jonas

> 
> Cheers,
> Quentin

