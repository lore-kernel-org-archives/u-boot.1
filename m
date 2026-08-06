Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F651C56207
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 15:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B4DA80DEC;
	Thu,  6 Aug 2026 15:25:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bdVJXqeIy1hw; Thu,  6 Aug 2026 15:25:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA2D980CA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786029932;
	bh=kQ6wCH+ZeVoX3C8jR8es8G6CuHCjSFBQBUSHzohx5bg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=yphGAq0oKj+FrC216dmllzQIjXREganhu/WnE1C02hHpzK/BK8f0WmeGbinnPLIyZ
	 CAdeIe+pI6T05LVtKHO0YwoBaRTpp5xN8hcOeq87BtUilEcr1BnZJ4QdM5IgrczA4x
	 RMypjJ5E4kJKIP2dOnyXVcrKfUKhZ/aGP3HYmi223v263YphCSoDYKf6Nc8QmL6up3
	 D7W4kBYjmyB70ZIMHrcEfweW4CUzS5zw6vrnQ9FwrTGS8Q/7curFfWDUm6pB4UvRYF
	 OtBayeJ3xK2t7KwsfLtt80IbNCoo0VzDRRToDmLfYiUk2ByHLJ4yjmuYgjcm6AJgBR
	 e7SKTCYKiNx8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA2D980CA7;
	Thu,  6 Aug 2026 15:25:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D00D2282
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 15:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5F80607DA
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 15:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9dtYq-ABraON for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 15:25:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.157.188.13;
 helo=smtp-bc0d.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 551B360763
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 551B360763
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 551B360763
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 15:25:28 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hGB1K203jzVkc;
 Thu,  6 Aug 2026 17:25:25 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hGB1H6hKSzXYJ; Thu,  6 Aug 2026 17:25:23 +0200 (CEST)
Message-ID: <636c02a7-a7c5-473b-b5cf-2900fd1adae7@0leil.net>
Date: Thu, 6 Aug 2026 17:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] rockchip: mkimage: Split size_and_off and
 size_and_nimage
To: Jonas Karlman <jonas@kwiboo.se>, Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260713-rk3576-boost-v1-0-9d23aa08f674@flipper.net>
 <20260713-rk3576-boost-v1-1-9d23aa08f674@flipper.net>
 <521c648b-9941-4e95-b3e3-4ca69f6c4c6b@0leil.net>
 <df2d1736-1498-4620-91da-1faa0cdfa14e@kwiboo.se>
Content-Language: en-US
In-Reply-To: <df2d1736-1498-4620-91da-1faa0cdfa14e@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1786029925;
 bh=kQ6wCH+ZeVoX3C8jR8es8G6CuHCjSFBQBUSHzohx5bg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h1ST9SSNSXf0j5HlOaqf6f8qdGo5dF90sK6h9OrBLaBnPl3R8MpqLsB64W7KbsBlI
 cmY02J2a/vdWcUN/GPTXhd9HswRKnga5yv2PPXSgJ6HOs6JQ+D2XR9+JuVoDQcDjaS
 kTL9R6E73OaJrwdJpQc26zzd/lOolZPsw2PUhhG05MbYN6DPP1I+jBrRWgAk6ht5hK
 9BwwxvxbCO7CxVcZGsTzBu/Zju+AvLSytV9KA8rE91FtfEDcRDZahk8RVW1h5j6zkx
 PMXEhCPz36L+LKpzb4n9ZiXYsXe7NbkR/nP2g4ukreCSDI5VWVKQZD1YOY33xvdLER
 gINDPxu0b2Wyg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=h1ST9SSN
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Jonas,

On 8/6/26 3:09 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 8/6/2026 1:15 PM, Quentin Schulz wrote:
>> Hi Alexey,
>>
>> On 7/13/26 12:02 PM, Alexey Charkov wrote:
>>> From: Jonas Karlman <jonas@kwiboo.se>
>>>
>>> Split 32-bit size_and_off and size_and_nimage fields of the v2 image
>>> format header into their own 16-bit size, offset and num_images fields.
>>>
>>> Set num_images based on number of images passed by the datafile
>>> parameter and size based on the offset to the hash field to fix using a
>>> single init data file and no boot data file for the v2 image format.
>>>
>>
>> When you need to start listing things you do in a commit, it means it
>> needs to be split into multiple individual commits doing one thing at a
>> time. I appreciate this is taken from Jonas's tree but it's fine to
>> modify (well, from a maintainer's perspective at least :) ). Please list
>> between Jonas's and your Signed-off-by what you changed since Jonas's
>> version, in square brackets.
>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>>> ---
>>>    tools/rkcommon.c | 44 ++++++++++++++++++++++++--------------------
>>>    1 file changed, 24 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>>> index b39777fc0607..034896d57f80 100644
>>> --- a/tools/rkcommon.c
>>> +++ b/tools/rkcommon.c
>>> @@ -34,15 +34,16 @@ enum hash_type {
>>>    /**
>>>     * struct image_entry
>>>     *
>>> - * @size_and_off:	[31:16]image size;[15:0]image offset
>>> - * @address:	default as 0xFFFFFFFF
>>> + * @offset:	image offset (unit as 512 byte blocks)
>>> + * @size:	image size (unit as 512 byte blocks)
>>> + * @address:	load address (default as 0xFFFFFFFF)
>>
>> Can it be anything but 0xFFFFFFFF? It's not even configurable currently.
>>
>>>     * @flag:	no use
>>>     * @counter:	no use
>>>     * @hash:	hash of image
>>> - *
>>>     */
>>>    struct image_entry {
>>> -	uint32_t size_and_off;
>>> +	uint16_t offset;
>>> +	uint16_t size;
>>
>> Do we need to start __attribute__ ((__packed__))'ing the structure to
>> make sure there's no padding involved ever?
>>
>>>    	uint32_t address;
>>>    	uint32_t flag;
>>>    	uint32_t counter;
>>> @@ -56,16 +57,17 @@ struct image_entry {
>>>     * This is stored at SD card block 64 (where each block is 512 bytes)
>>>     *
>>>     * @magic:	Magic (must be RK_MAGIC_V2)
>>> - * @size_and_nimage:	[31:16]number of images;[15:0]
>>> - *			offset to hash field of header(unit as 4Byte)
>>> - * @boot_flag:	[3:0]hash type(0:none,1:sha256,2:sha512)
>>> - * @signature:	hash or signature for header info
>>> - *
>>> + * @size:	offset to hash field of header (unit as 4 bytes)
>>
>> I'm assuming we mean "unit as multiples of 4 bytes"? Is that correct?
>> Can we say that instead, I find it clearer.
>>
>>> + * @num_images:	number of images
>>
>> Can we improve this documentation as well? I'm assuming this is the
>> number of images stored in idbloader.img (so typically SPL + optionally
>> TPL + optionally VPL/boost?)
>>
>>> + * @boot_flag:	[3:0] hash type (0:none, 1:sha256, 2:sha512)
>>> + * @images:	images
>>
>> Not sure this is helping, either specify what those are or simply don't
>> comment.
>>
>>> + * @hash:	hash or signature for header info
>>>     */
>>>    struct header0_info_v2 {
>>>    	uint32_t magic;
>>>    	uint8_t reserved[4];
>>> -	uint32_t size_and_nimage;
>>> +	uint16_t size;
>>> +	uint16_t num_images;
>>
>> Do we need to start __attribute__ ((__packed__))'ing the structure to
>> make sure there's no padding involved ever?
>>
>> Side question, should we start using the proper expected endianness
>> here? e.g. __le16/__le32 instead of uint32_t and uint16_t? What do you
>> think?
>>
>>>    	uint32_t boot_flag;
>>>    	uint8_t reserved1[104];
>>>    	struct image_entry images[4];
>>> @@ -351,17 +353,18 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>>    	printf("Image Type:   Rockchip %s boot image\n",
>>>    		rkcommon_get_spl_hdr(params));
>>>    	memset(buf, '\0', RK_INIT_OFFSET * RK_BLK_SIZE);
>>> -	hdr->magic   = cpu_to_le32(RK_MAGIC_V2);
>>> -	hdr->size_and_nimage = cpu_to_le32((2 << 16) + 384);
>>> +	hdr->magic = cpu_to_le32(RK_MAGIC_V2);
>>
>> Please don't mix cosmetic changes as those and logic changes, in the
>> same commit. The whitespaces removal makes it harder to identify quickly
>> what is actually changed.
>>
>>>    	hdr->boot_flag = cpu_to_le32(HASH_SHA256);
>>>    	sector_offset = 4;
>>>    	image_size_array[0] = spl_params.init_size;
>>>    	image_size_array[1] = spl_params.boot_size;
>>>    
>>>    	for (i = 0; i < 2; i++) {
>>> +		if (!image_size_array[i])
>>> +			break;
>>>    		image_sector_count = image_size_array[i] / RK_BLK_SIZE;
>>> -		hdr->images[i].size_and_off = cpu_to_le32((image_sector_count
>>> -							<< 16) + sector_offset);
>>> +		hdr->images[i].offset = cpu_to_le16(sector_offset);
>>> +		hdr->images[i].size = cpu_to_le16(image_sector_count);
>>>    		hdr->images[i].address = 0xFFFFFFFF;
>>>    		hdr->images[i].counter = cpu_to_le32(i + 1);
>>>    		image_ptr = buf + sector_offset * RK_BLK_SIZE;
>>> @@ -370,6 +373,8 @@ static void rkcommon_set_header0_v2(void *buf, struct image_tool_params *params)
>>>    		sector_offset = sector_offset + image_sector_count;
>>>    	}
>>>    
>>> +	hdr->num_images = cpu_to_le16(i);
>>
>> Is it though? if image_size_array[i] is 0, it means nothing was passed
>> as the i+1th image to mkimage -T rksd/rkspi -d no?
>>
>>> +	hdr->size = cpu_to_le16(offsetof(typeof(*hdr), hash) / sizeof(uint32_t));
>>>    	do_sha256_hash(buf, (void *)hdr->hash - buf, hdr->hash);
>>>    }
>>>    
>>> @@ -516,10 +521,8 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>>    			return;
>>>    		}
>>>    
>>> -		init_size = header0_v2.images[0].size_and_off >> 16;
>>> -		init_size = init_size * RK_BLK_SIZE;
>>> -		boot_size = header0_v2.images[1].size_and_off >> 16;
>>> -		boot_size = boot_size * RK_BLK_SIZE;
>>> +		init_size = le16_to_cpu(header0_v2.images[0].size) * RK_BLK_SIZE;
>>> +		boot_size = le16_to_cpu(header0_v2.images[1].size) * RK_BLK_SIZE;
>>>    	} else {
>>>    		ret = rkcommon_parse_header(buf, &header0, &spl_info);
>>>    
>>> @@ -533,8 +536,9 @@ void rkcommon_print_header(const void *buf, struct image_tool_params *params)
>>>    		}
>>>    
>>>    		image_type = ret;
>>> -		init_size = header0.init_size * RK_BLK_SIZE;
>>> -		boot_size = header0.init_boot_size * RK_BLK_SIZE - init_size;
>>> +		init_size = le16_to_cpu(header0.init_size) * RK_BLK_SIZE;
>>> +		boot_size = le16_to_cpu(header0.init_boot_size) * RK_BLK_SIZE -
>>> +			    init_size;
>>>    
>>
>> I could identify multiple commits to be split out of this one:
>> - update documentation,
>> - whitespace around ->magic assignment,
>> - break the loop when image_size_array[i] is 0,
>> - properly translate init_size/boot_size into CPU endianness,
>> - split size_and_nimage u32 into two u16,
>> - split size_and_off u32 into two u16,
>> - programmatically set ->size,
>> - programmatically set ->num_images,
> 
> As stated to Alexey previously I have started re-working my old series
> to address your old review comments, current local version have:
> 
> b86f1ed33d9d WIP: rockchip: mkimage: Compare full string when matching imagename
> d849f5710a62 WIP: rockchip: mkimage: Print image-type for the v2 format
> 690bd184c62f WIP: rockchip: mkimage: use le16/le32_to_cpu when reading header fields
> 01e1ce9ccab4 WIP: rockchip: mkimage: static assert
> d5b2191eae34 WIP: rockchip: mkimage: split size_and_off in struct image_entry
> 0bbb7bf20348 WIP: rockchip: mkimage: split size_and_nimage in struct header0_info_v2
> 4f1cc2100120 WIP: rockchip: mkimage: Set header size based on offset to hash
> 2031ef00ddaa rockchip: mkimage: Split size_and_off and size_and_nimage
> deae586379d8 rockchip: mkimage: Print image information for all embedded images
> 15867436697d rockchip: mkimage: Print image information for all embedded images
> c5f38fe9aa85 rockchip: mkimage: Print boot0 and boot1 parameters
> c03eda77d517 WIP: rockchip: mkimage: Print hash algo and image hash value
> c28f75ab3d22 WIP: rockchip: mkimage: Print signature type
> 744b76c3e716 WIP: rockchip: mkimage: Extract and use rkcommon_get_aligned_filesize()
> e667ac1ff977 WIP: rockchip: mkimage: Extract and use rkcommon_get_header_size()
> 776f4b84625f rockchip: mkimage: Add option to change image offset alignment
> 403e40c9fe80 rockchip: mkimage: Add support for up to 4 input files
> 
> But I have not completed addressing all review comments yet, will be
> sending a v2 of my original series in a few days.
> 

Should I stop reviewing the rest of this series and wait for your v2 then?

Cheers,
Quentin
