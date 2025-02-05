Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208DBC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 19:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74B380762;
	Wed,  5 Feb 2025 20:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="dTgwGDux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E24A80762; Wed,  5 Feb 2025 20:00:10 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51B2F800CF
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9fbe=U5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1738782005;
 bh=NIf5xiION+LFQUC4epcwojk9LaCP/Z2Sidjj7e481Vs=;
 b=dTgwGDux7kKg5dRMyxR0JcirmMRwR2dfPv0sfDeAYZl7l2xEl5zJ67Sx74VLSFmHgHS39PB94
 ASzsdyh4cH9b/KoC3pY7bzanF8L2MBVGziuL/jtR3C/FLEs0oBus4vY5xIlo0w9NmgT8c+/zETE
 ek4YFZUJc1AnISstq9meaKgzrZNazNiL6Alcf3hafmmLfrrlD0GBTRPc7tRejVXbQsN4kUh/fK9
 xS6Zyp+jThT2HAsGn19JtZD2SDZYEWAn+OkOi84vNESMCUKgm1xPebTvzCTxnNzfui8p6nQETdZ
 lgIvxTaAkFfQKF7tZ+gO4qzJKCNDijD9c5OhHQhzO+zA==
X-Forward-Email-ID: 67a3b5344f7eea50c61f346c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.56
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <d220c0af-2a28-4592-ab37-a9abf997d254@kwiboo.se>
Date: Wed, 5 Feb 2025 20:00:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] rockchip: mkimage: Add support for up to 4 input files
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250129223641.1888833-1-jonas@kwiboo.se>
 <20250129223641.1888833-6-jonas@kwiboo.se>
 <4dec97d2-0ee8-46a5-bf3e-91776ddb1833@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4dec97d2-0ee8-46a5-bf3e-91776ddb1833@cherry.de>
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

On 2025-02-05 17:43, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/29/25 11:36 PM, Jonas Karlman wrote:
>> The v2 image format can support up to 4 embedded images that can be
>> loaded by the BootROM using the back-to-bootrom method.
>>
>> Currently two input files can be passed in using the datafile parameter,
>> separated by a colon (":").
>>
>> Extend the datafile parameter parsing to support up to 4 input files
>> separated by a colon (":") for use with the v2 image format.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   tools/rkcommon.c | 93 +++++++++++++++++++++++-------------------------
>>   1 file changed, 44 insertions(+), 49 deletions(-)
>>
>> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
>> index 542aca931693..4ff48e81a636 100644
>> --- a/tools/rkcommon.c
>> +++ b/tools/rkcommon.c
>> @@ -148,17 +148,15 @@ static struct spl_info spl_infos[] = {
>>   /**
>>    * struct spl_params - spl params parsed in check_params()
>>    *
>> - * @init_file:		Init data file path
>> - * @init_size:		Aligned size of init data in bytes
>> - * @boot_file:		Boot data file path
>> - * @boot_size:		Aligned size of boot data in bytes
>> + * @file:	image file path
>> + * @size:	aligned size of image in bytes
> 
> Not really matching reality though. Could make it easier maybe to have 
> an intermediary
> 
> struct spl_params_image {
>      char *file;
>      uint32_t size;
> };
> 
> and then have
> 
> struct spl_params {
>      struct spl_params_image images[4];
> };
> 
> ?

Sound good, will use in v2.

> 
>>    */
>>   
>>   struct spl_params {
>> -	char *init_file;
>> -	uint32_t init_size;
>> -	char *boot_file;
>> -	uint32_t boot_size;
>> +	struct {
>> +		char *file;
>> +		uint32_t size;
>> +	} images[4];
>>   };
>>   
>>   static struct spl_params spl_params = { 0 };
>> @@ -238,31 +236,32 @@ int rkcommon_check_params(struct image_tool_params *params)
>>   	if (!rkcommon_get_spl_info(params->imagename))
>>   		goto err_spl_info;
>>   
>> -	spl_params.init_file = params->datafile;
>> +	spl_params.images[0].file = params->datafile;
>> +	for (i = 1; i < ARRAY_SIZE(spl_params.images); i++) {
>> +		spl_params.images[i].file =
>> +				strchr(spl_params.images[i - 1].file, ':');
>> +		if (!spl_params.images[i].file)
>> +			break;
>>   
>> -	spl_params.boot_file = strchr(spl_params.init_file, ':');
>> -	if (spl_params.boot_file) {
>> -		*spl_params.boot_file = '\0';
>> -		spl_params.boot_file += 1;
>> +		*spl_params.images[i].file = '\0';
>> +		spl_params.images[i].file += 1;
>>   	}
>>   
>> -	size = rkcommon_get_aligned_filesize(params, spl_params.init_file);
>> -	if (size < 0)
>> -		return EXIT_FAILURE;
>> -	spl_params.init_size = size;
>> +	for (i = 0; i < ARRAY_SIZE(spl_params.images); i++) {
>> +		if (!spl_params.images[i].file)
>> +			break;
>>   
>> -	/* Boot file is optional, and only for back-to-bootrom functionality. */
>> -	if (spl_params.boot_file) {
>> -		size = rkcommon_get_aligned_filesize(params, spl_params.boot_file);
>> +		size = rkcommon_get_aligned_filesize(params,
>> +						     spl_params.images[i].file);
>>   		if (size < 0)
>>   			return EXIT_FAILURE;
>> -		spl_params.boot_size = size;
>> +		spl_params.images[i].size = size;
>>   	}
>>   
> 
> Can't we merge the two for-loops?

Possible, suspect I kept it as two loops to avoid having to work on [i]
and [i - 1] too much in same loop. Do you have any suggestion on how to
merge the two for-loops to simplify this?

Regards,
Jonas

> 
> The patch diff makes sense to me :)
> 
> Cheers,
> Quentin

