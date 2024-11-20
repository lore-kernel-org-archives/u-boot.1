Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED1BD6393C
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C796789426;
	Wed, 20 Nov 2024 14:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J1LkcGmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADC789426; Wed, 20 Nov 2024 14:55:53 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1B57891EF
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2fb518014b9so18934181fa.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732110950; x=1732715750; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=szc1CRczJzKQkCD9KZAYcdcwuAdvnBCf2I6ogls4Z2M=;
 b=J1LkcGmYIOOyHugl7EjglFmdjVGWuBMRWF0f8Y1RZOBX3VuFvsR6+fG4kanJNZ3/n5
 HoBeAKtsza0nKkV/jr9lumcEOn2SQrvYq4pTIT1OBLHUSn6tZkmd0RPRgyrR5cEN5Wqg
 NfemNZ6EE5nima5w+y7edaVf8zirNrscOvrrifWTPcQYmldnyn/kxaGwDVnP5+NdTI4v
 +2dmGuOd/LrzPQ8l2J77lpYZ6eJj9Lx+mvCjt/zKsiJohWWvT12sXKrdMTFbQBT6CPaw
 yjfpVJdW/Mom/opSp6Fzd8RhtVSNlcPFCSzpiAHZT8sp7NvV35sWsZnRbB3VV8Ha1YuK
 QF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110950; x=1732715750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=szc1CRczJzKQkCD9KZAYcdcwuAdvnBCf2I6ogls4Z2M=;
 b=JhaJcf83Yl37J7lIRz2JyBGwaZauhND2MUGraRrztJqSPItSkqrWckD22RItWdiiiH
 V7K8EvxMISAJdekmHG8G0dfAsQj+/YJKoH6YXirY5hn6HWb1oXqg5LP0q96crF0hTf9r
 R2FNp0rt6Ui7IegQACYRDL3ZZqTSQhIg+q6yRmsiLGt/Z127zo3DHDVklU1R/yPcngP9
 QdJQ/yyqf7Iteq9PXH5Wv7kAf4QUjeDWI6Ak15oUGjfQTp5lReZax0vF/GAjY9vZYMJs
 +ER4HkTBbwu7k33hKqsKKaTpTUfdFML+wr4LKTUNM/duoqIch+T3fra2XxbmBlXYmd+1
 aXaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPEMMPf6xn34cEPe5Gf1eRXd4gvAYcN4Aj0545vfbIp/UDz0eNnn7iEJl4s52Q8FYiN2mTGVc=@lists.denx.de
X-Gm-Message-State: AOJu0YwRzUbrZ5tERq2VwZwA7jnmTvHuAvGZ5anPxKjzbKOXK6Gp7ZKy
 3jSLt90/rXI2K5yUwbMjV9ba5x9IhWSkVN6MsPGtXnOrMVFvyTmkF67AdO7nPVE=
X-Google-Smtp-Source: AGHT+IHR6AdAyXJc0Idaonr1iChttIfQyg2zdpPsROyKoWlaqdt+Z15oLkOhU+xhEMncQZiHnkTWaA==
X-Received: by 2002:a05:651c:545:b0:2fb:4b40:1e18 with SMTP id
 38308e7fff4ca-2ff8db33d27mr16724571fa.13.1732110949900; 
 Wed, 20 Nov 2024 05:55:49 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cff453e1b8sm868571a12.63.2024.11.20.05.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 05:55:49 -0800 (PST)
Message-ID: <2f5b61a7-9417-49b1-90b7-8aaf25f65cde@linaro.org>
Date: Wed, 20 Nov 2024 14:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: fat: Handle 'FAT sector size mismatch'
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Simon Glass <sjg@chromium.org>
Cc: christian.taedcke@weidmueller.com, ada@thorsis.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, u-boot@lists.denx.de
References: <20241119073048.3469260-1-quic_varada@quicinc.com>
 <20241119154436.GW3600562@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241119154436.GW3600562@bill-the-cat>
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

Hi both,

Varadarajan: Thanks for sending this patch.

On 19/11/2024 16:44, Tom Rini wrote:
> On Tue, Nov 19, 2024 at 01:00:48PM +0530, Varadarajan Narayanan wrote:
> 
>> Do FAT read and write based on the device sector size
>> instead of the size recorded in the FAT meta data. This
>> helps to overcome the 'FAT sector size mismatch' error
>> and enables U-Boot to read/write those partitions.

Does this ignore the filesystem sector size or account for it? There's a
whole lot of logic added below which isn't really explained here.
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>  fs/fat/fat.c       | 227 ++++++++++++++++++++++++++++++++++++++++++---
>>  fs/fat/fat_write.c |  19 ----
>>  2 files changed, 214 insertions(+), 32 deletions(-)
>>
>> diff --git a/fs/fat/fat.c b/fs/fat/fat.c
>> index e2570e8167..f4bad99335 100644
>> --- a/fs/fat/fat.c
>> +++ b/fs/fat/fat.c
>> @@ -44,24 +44,223 @@ static void downcase(char *str, size_t len)
>>  
>>  static struct blk_desc *cur_dev;
>>  static struct disk_partition cur_part_info;
>> +int fat_sect_size;

This variable should be static, no harm in 0 initializing it here either.
>>  

[...]

>> +
>> +int disk_write(__u32 sect, __u32 nr_sect, void *buf)
>> +{
>> +	int ret;
>> +	__u8 *block = NULL;
>> +	__u32 rem, size;
>> +	__u32 s, n;
>> +
>> +	rem = nr_sect * fat_sect_size;
>> +	/*
>> +	 *           block N       block N + 1      block N + 2
>> +	 * +-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>> +	 * | | | | |s|e|c|t|o|r| | |s|e|c|t|o|r| | |s|e|c|t|o|r| | | | |
>> +	 * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
>> +	 * . . . |               |               |               | . . .
>> +	 * ------+---------------+---------------+---------------+------
>> +	 *            |<--- FAT reads in sectors          --->|
>> +	 *
>> +	 *            |  part 1  |   part 2      |  part 3    |
>> +	 *
>> +	 */
>> +
>> +	/* Do part 1 */
>> +	if (fat_sect_size) {
>> +		__u32 offset;
>> +
>> +		/* Read one block and overwrite the leading sectors */
>> +		block = malloc_cache_aligned(cur_dev->blksz);
>> +		if (!block) {
>> +			printf("Error: allocating block: %lu\n", cur_dev->blksz);
>> +			return -1;
>> +		}
>> +
>> +		s = sect_to_block(sect, &offset);
>> +		offset = offset * fat_sect_size;
>> +
>> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
>> +		if (ret != 1) {
>> +			ret = -1;
>> +			goto exit;
>> +		}
>> +
>> +		if (rem > (cur_part_info.blksz - offset))
>> +			size = cur_part_info.blksz - offset;
>> +		else
>> +			size = rem;
>> +
>> +		memcpy(block + offset, buf, size);
>> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
>> +		if (ret != 1) {
>> +			ret = -1;
>> +			goto exit;
>> +		}
>> +
>> +		rem -= size;
>> +		buf += size;
>> +		s++;
>> +	} else {
>> +		/*
>> +		 * fat_sect_size not being set implies, this is the first read
>> +		 * to partition. The first sector is being read to get the
>> +		 * FS meta data. The FAT sector size is got from this meta data.
>> +		 */

This is the disk_write() function though, I don't think this behaviour
is correct?
>> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, buf);
>> +		if (ret != 1)
>> +			return -1;
>> +	}
>> +
>> +	/* Do part 2, write directly from the given buffer */
>> +	if (rem > cur_part_info.blksz) {
>> +		n = rem / cur_part_info.blksz;
>> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, n, buf);
>> +		if (ret != n) {
>> +			ret = -1;
>> +			goto exit;
>> +		}
>> +		buf += n * cur_part_info.blksz;
>> +		rem = rem % cur_part_info.blksz;
>> +		s += n;
>> +	}
>> +
>> +	/* Do part 3, read a block and copy the trailing sectors */
>> +	if (rem) {
>> +		ret = blk_dread(cur_dev, cur_part_info.start + s, 1, block);
>> +		if (ret != 1) {
>> +			ret = -1;
>> +			goto exit;
>> +		} else {
>> +			memcpy(block, buf, rem);
>> +		}
>> +		ret = blk_dwrite(cur_dev, cur_part_info.start + s, 1, block);
>> +		if (ret != 1) {
>> +			ret = -1;
>> +			goto exit;
>> +		}
>> +	}
>> +exit:
>> +	if (block)
>> +		free(block);
>> +
>> +	return (ret == -1) ? -1 : nr_sect;
>>  }


[...]

Hi Tom,

> With this patch, we now have
> https://patchwork.ozlabs.org/project/uboot/patch/20241113044956.1836896-1-caleb.connolly@linaro.org/

I suspect my patch would corrupt storage on write, I'll give it another
test and see.
> and
> https://patchwork.ozlabs.org/project/uboot/patch/20230730111516.v2.1.Ia13846500fab3d5a1d5573db11a040d233994fa6@changeid/
> for seemingly the same issue. Can you please try these other two
> patches and report which ones do / don't handle your use case as well?
> Thanks!
Kind regards,
> 

-- 
// Caleb (they/them)

