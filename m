Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3320DCD5827
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 09:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFE683B03;
	Wed,  7 Jan 2026 10:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nSGuZEIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46B7683B4B; Wed,  7 Jan 2026 10:53:01 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1ABE83AC5
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 10:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 62FF260141;
 Wed,  7 Jan 2026 09:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3ED6C16AAE;
 Wed,  7 Jan 2026 09:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767779577;
 bh=D/duCqzA+7zCOHG/snky2/L3nM3P+vLhRw4sBtwRk6Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nSGuZEIA+Jf3pPe18TXBnBy3ZTj8JTJAqnXCSCNR/uaQGWosZ+/AEt1AnqGllEwOW
 D1Dr4ymiAyoUNx4KRvT7d5I4Tue8Y9ZtuYhoCPD2Dh03OONQeMKoef58tdFCuPfhoC
 n1ADyfFvkJUI1weVcZw3vkYExEIzcZKcBtiLn2cE0hPoXZ30aH3WggmLq/YHMYzUqb
 2Wg8RVjyFe6gApkq4yzZlibkdy12HxsxDvLgjvjAQcF/eNwZrWA3eEZYP2DiJg0VUD
 2mMfBJOnhDNurX3ice/jP/ElhoW1NZTH2so/cosBGqtaOATvb4uaYUGFdEq73UTRlY
 IQdWtuHF6MpGA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Tom Rini <trini@konsulko.com>, Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, macromorgan@hotmail.com, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, sjg@chromium.org, jmasson@baylibre.com,
 nbelin@baylibre.com, bisson.gary@gmail.com
Subject: Re: [PATCH] bootstd: android: Fix write outside of memory
In-Reply-To: <20260106171633.GI3416603@bill-the-cat>
References: <20251223234456.1983614-1-macroalpha82@gmail.com>
 <20260106171633.GI3416603@bill-the-cat>
Date: Wed, 07 Jan 2026 10:52:54 +0100
Message-ID: <87ldi9g361.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jan 06, 2026 at 11:16, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Dec 23, 2025 at 05:44:56PM -0600, Chris Morgan wrote:
>
>> From: Chris Morgan <macromorgan@hotmail.com>
>> 
>> It looks like under certain circumstances when reading the vendor_boot
>> partition it causes my device to write outside the range of memory
>> available. Near as I can tell this occurs because
>> scan_vendor_boot_part() calls android_image_get_vendor_bootimg_size()
>> which calls android_vendor_boot_image_v3_v4_parse_hdr() which calls
>> add_trailer() which attempts to copy information to a buffer allocated
>> with malloc in the scan_vendor_boot_part() function. On my board the
>> memory set aside for malloc is at the top of the system RAM, and given
>> a large enough vendor boot image size this causes the write from
>> add_trailer() to occur outside of the system RAM (nevermind outside
>> of what was allocated with the malloc().
>> 
>> While I don't know the absolute best way to handle this, I would assume
>> that if we simply map the memory we want to use to where we will
>> eventually load the vendor_boot image that would be the most logical.
>> 
>> Fixes: abadcda24b10 ("bootstd: android: don't read whole partition sizes")
>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>> ---
>>  boot/bootmeth_android.c | 20 ++++++--------------
>>  1 file changed, 6 insertions(+), 14 deletions(-)
>> 
>> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
>> index 1374551dbeb..c2c25d53ef3 100644
>> --- a/boot/bootmeth_android.c
>> +++ b/boot/bootmeth_android.c
>> @@ -118,9 +118,10 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
>>  	struct blk_desc *desc = dev_get_uclass_plat(blk);
>>  	struct disk_partition partition;
>>  	char partname[PART_NAME_LEN];
>> -	ulong num_blks, bufsz;
>> +	ulong num_blks;
>>  	char *buf;
>>  	int ret;
>> +	ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
>>  
>>  	if (priv->slot)
>>  		sprintf(partname, VENDOR_BOOT_PART_NAME "_%s", priv->slot);
>> @@ -132,28 +133,19 @@ static int scan_vendor_boot_part(struct udevice *blk, struct android_priv *priv)
>>  		return log_msg_ret("part info", ret);
>>  
>>  	num_blks = DIV_ROUND_UP(sizeof(struct andr_vnd_boot_img_hdr), desc->blksz);
>> -	bufsz = num_blks * desc->blksz;
>> -	buf = malloc(bufsz);
>> +	buf = map_sysmem(vloadaddr, 0);
>>  	if (!buf)
>>  		return log_msg_ret("buf", -ENOMEM);
>>  
>>  	ret = blk_read(blk, partition.start, num_blks, buf);
>> -	if (ret != num_blks) {
>> -		free(buf);
>> +	if (ret != num_blks)
>>  		return log_msg_ret("part read", -EIO);
>> -	}
>>  
>> -	if (!is_android_vendor_boot_image_header(buf)) {
>> -		free(buf);
>> +	if (!is_android_vendor_boot_image_header(buf))
>>  		return log_msg_ret("header", -ENOENT);
>> -	}
>>  
>> -	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size)) {
>> -		free(buf);
>> +	if (!android_image_get_vendor_bootimg_size(buf, &priv->vendor_boot_img_size))
>>  		return log_msg_ret("get vendor bootimg size", -EINVAL);
>> -	}
>> -
>> -	free(buf);
>>  
>>  	return 0;
>>  }
>
> I haven't forgotten about this, but I'm hoping there's some other way to
> solve this, I'm not super keen on adding another environment variable
> (that would need to be documented in a v2 if we can't fix this some
> other way). Mattijs, do you have any ideas?

Sorry for the delay. I'm trying to catch up on my review queue after the
holiday break.
I hope to follow up here in the coming days.

>
> -- 
> Tom
