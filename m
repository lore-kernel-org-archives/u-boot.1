Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60157C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 16:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA5AD8033D;
	Wed,  5 Feb 2025 17:58:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="UMe++A4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBFE806FE; Wed,  5 Feb 2025 17:58:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A84380104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 17:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738774703;
 bh=+S4XPOdTpCTdRv7rvrzzjaGaZ6oU8ycpMEX7a/4YLgM=;
 b=UMe++A4bJhz6glDWZeTaRerf5FJv/U1PXf70bOmwK6AsG1rmW1wNT86Dgv7KVHoG8PlpnSbSL
 D0RlvihOZ0d639zzEK1s2wbs1Ihz/wYn9pyT/zF3W9g7k0++UhWE0I3KIX+x2K7VHh7wPO4kDfu
 lIc/W9+IYSTn6AHaJ+tzYXbXAK0sMR5m/jr+oLW4F7ZxUo5FS3k1ccx+huC+/NYsbSgAfN+g8VF
 5FgTESuvBXAuK3CkOVkmyfqlobfWSHMZqdvj12gGEQDb8D6L9PfEd7Ovpjh3RNjphrVBGilyNMZ
 2pgVYyd0NshTf3jyoK0HGvt+6iNSoevmo90icPZvLGYw==
X-Forward-Email-ID: 67a398adfb44099d0e5953c5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1dbe12a3-4f7b-4119-875d-81acdcc91d77@kwiboo.se>
Date: Wed, 5 Feb 2025 17:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] rockchip: mkimage: Add option to change image offset
 alignment
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-5-jonas@kwiboo.se>
 <7aa55d4f-42d9-490a-8a20-705358db00cc@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7aa55d4f-42d9-490a-8a20-705358db00cc@cherry.de>
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

On 2025-02-05 17:29, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>> The vendor boot_merger tool support a ALIGN parameter that is used to
>> define offset alignment of the embedded images.
>>
>> Vendor use this for RK3576 to change offset alignment from the common
>> 2 KiB to 4 KiB, presumably it may have something to do with UFS.
>> Testing with eMMC has shown that using a 512-byte alignment also work.
>>
>> Add support for overriding offset alignment in case this is needed for
>> e.g. RK3576 in the future.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   tools/rkcommon.c | 75 +++++++++++++++++++++++++++++++-----------------
>>   tools/rkcommon.h |  2 --
>>   2 files changed, 49 insertions(+), 28 deletions(-)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index 324820717663..542aca931693 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -124,6 +124,7 @@ struct spl_info {
>>   	const uint32_t spl_size;
>>   	const bool spl_rc4;
>>   	const uint32_t header_ver;
>> +	const uint32_t align;
> 
> Missing documentation update above the struct definition.

Will fix in v2.

> 
>>   };
>>   
>>   static struct spl_info spl_infos[] = {
>> @@ -181,14 +182,19 @@ static struct spl_info *rkcommon_get_spl_info(char *imagename)
>>   	return NULL;
>>   }
>>   
>> -static int rkcommon_get_aligned_size(struct image_tool_params *params,
>> -				     const char *fname)
>> +static bool rkcommon_is_header_v2(struct image_tool_params *params)
>>   {
>> -	int size;
>> +	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
>>   
>> -	size = imagetool_get_filesize(params, fname);
>> -	if (size < 0)
>> -		return -1;
>> +	return (info->header_ver == RK_HEADER_V2);
>> +}
>> +
>> +static int rkcommon_get_aligned_size(struct image_tool_params *params, int size)
> 
> Maybe use an unsigned type here as a size will be guaranteed to be positive?

Use of unsigned may be more correct, can adjust in v2.

> 
>> +{
>> +	struct spl_info *info = rkcommon_get_spl_info(params->imagename);
>> +
>> +	if (info->align)
>> +		return ROUND(size, info->align * RK_BLK_SIZE);
>>   
> 
> Why not make info->align be 4 (RK_SIZE_ALIGN / RK_BLK_SIZE) if unset?

Can probably change to something similar in v2, spl_infos should
probably be a const but can introduce a local align value (what I used
in an early version).

> 
> I like the change, though I felt splitting in more commits would have 
> made the review easier, e.g.:
> 
> - split part of get_aligned_size into get_aligned_filesize
> - migrate hardcoded RK_INIT_OFFSET to get_aligned_size
> - migrate hardcoded RK_SPL_HDR_START to get_aligned_size
> - add align to spl_info + handling in get_aligned_size

Hehe, during development I had everything in this series + rk3576
sd-card workaround as a single commit, and I thought current split into
6+1 patches was more than enough ;-)

Will see if I can split this further, it will be with a cost of some
quick/bad commit messages.

Regards,
Jonas

> 
> Looks good to me otherwise!
> 
> Cheers,
> Quentin

