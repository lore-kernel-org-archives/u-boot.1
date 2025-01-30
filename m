Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D36C0218F
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70A0B8210D;
	Thu, 30 Jan 2025 17:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=studiofuga.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=studiofuga.com header.i=@studiofuga.com header.b="ijedG0Zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3742D8083C; Thu, 30 Jan 2025 16:03:46 +0100 (CET)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C8280C77
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 16:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=studiofuga.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fuga@studiofuga.com
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YkMjV0n1szWXD;
 Thu, 30 Jan 2025 16:03:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studiofuga.com;
 s=20220517; t=1738249421;
 bh=n3NqJYpkUTIsX+Sj6R0gwwGlZuEinlGZ5A4qXdAHAMg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ijedG0ZjE+xBAnlshOEGOx7kOdrdmjNbrTp/bQwVhMRufyJYlQKMf49JKHp1XqN3O
 NYrt3zM8KT4MpJUhuj0NcZGYhMG7R6R2SyctDkm61ypsyW1PxAXb7SJ6bI0Ge/P4UV
 m0a6bnP0hFjXbTlTi5Nxps7hUWZmQLuVPAZTDz4s=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YkMjT1k67zKjZ; Thu, 30 Jan 2025 16:03:41 +0100 (CET)
Message-ID: <da361464-8326-4050-9556-9fad720b2022@studiofuga.com>
Date: Thu, 30 Jan 2025 16:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix fastboot handling of partitions when no slots are
 supported
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Federico Fuga via B4 Relay <devnull+fuga.studiofuga.com@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com>
 <87r04kfm2w.fsf@baylibre.com>
Content-Language: en-US
From: Federico Fuga <fuga@studiofuga.com>
Autocrypt: addr=fuga@studiofuga.com; keydata=
 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
 3Z10R+iQ3XwjCMCTFTN+4NBJ1U0=
In-Reply-To: <87r04kfm2w.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Thu, 30 Jan 2025 17:06:58 +0100
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

Hi Mattijs,

thanks for your kind response and suggestions.

We are actually suspending the development on this board, because it 
seems the support for our hardware (sunxi A33) requires too much work 
than expected. We were trying to update our 2018-flavoured bootloader 
but it seems we did a lot of steps back, for reason I can't fully grasp.

Anyway, I'll try to work on this patch in my spare time.


Specifically:



On 30/01/25 14:49, Mattijs Korpershoek wrote:
> Hi Federico,
>
> Thank you for the patch.
>
> On mar., janv. 28, 2025 at 12:18, Federico Fuga via B4 Relay <devnull+fuga.studiofuga.com@kernel.org> wrote:
>
>> From: Federico Fuga <fuga@studiofuga.com>
>>
>> The fastboot module has a bug that prevents some command to work
>> properly on devices that haven't an Android-like partition scheme, that
>> is, just one spl and one kernel partition, instead of the redundant
>> scheme with _a and _b slots.
>>
>> This is the schema of our NAND storage (board is based on an AllWinner
>> A33 sunxi chip):
>>
>> => mtdparts
>>
>> device nand0 <1c03000.nand>, # parts = 4
>>   #: name         size            net size        offset          mask_flags
>>   0: spl          0x00020000      0x00020000      0x00000000      0
>>   1: uboot        0x00100000      0x00100000      0x00020000      0
>>   2: kernel_a     0x00400000      0x00400000      0x00120000      0
>>   3: ubi          0x07ae0000      0x079e0000 (!)  0x00520000      0
>>
>> active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000
>>
>> This happens when we try to erase the spl partition using fastboot:
>>
>> $ fastboot erase spl
>> Erasing 'spl_a'               FAILED (remote: 'invalid NAND device')
>> fastboot: error: Command failed
>>
>> The error occurs because getvars fails to handle the error returned by
>> nand layer when a partition cannot be found.
>>
>> Indeed, getvar_get_part_info returns what is returned by
>> fastboot_nand_get_part_info (0 on success, 1 on failure) but it should
>> return -ENODEV or -EINVAL instead. Since the cause of failure is not
>> returned by the nand function, I decided to return -EINVAL to make it
>> simple.
>>
>> Signed-off-by: Federico Fuga <fuga@studiofuga.com>
> I could apply this version, finally :)
>
> b4 got a bit confused since it has been send as a v1 but using the
> following command worked for me:
>
> $ b4 shazam -s -l --check 20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com -v1


Yes I did notice this, I tried it after sending and I was puzzled why it 
spit out the same error as before. I'm still learning.


> Now for the patch itself:
>
> Please use 'fastboot:' prefix as a commit title.
> Use '$ git log --oneline -- drivers/fastboot/' to see what other commits
> where using as a title.
>
> Some more comments below. Please make sure to answer this email to
> acknowledge/reject review feedback.
> Also, when sending a v2, please make sure to include a changelog.
>
> If you need help setting things up properly, let me know. I'm also
> reachable on IRC https://libera.chat/, channel #u-boot, my nickame is mkorpershoek.


Thanks, I'll surely do.


>> ---
>>   drivers/fastboot/fb_getvar.c | 5 ++++-
>>   drivers/fastboot/fb_nand.c   | 2 +-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
>> index 9c2ce65a4e5bce0da6b18aa1b2818f7db556c528..816ed8a6213b5c1f0948a813c6f6a865a4b47ba8 100644
>> --- a/drivers/fastboot/fb_getvar.c
>> +++ b/drivers/fastboot/fb_getvar.c
>> @@ -121,8 +121,11 @@ static int getvar_get_part_info(const char *part_name, char *response,
>>   			*size = disk_part.size * disk_part.blksz;
>>   	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
>>   		r = fastboot_nand_get_part_info(part_name, &part_info, response);
>> -		if (r >= 0 && size)
>> +		if (r == 0 && size) {
>>   			*size = part_info->size;
> Maybe the patch is simpler this way, but I think that it would be better
> if fastboot_mmc_get_part_info() and fastboot_nand_get_part_info() would
> behave the same. The naming is pretty close already, and having
> different behaviours/return codes seems confusing to me.


Indeed, having the same code would be definitely proper.


> Is there a strong reason for not modifying fb_nand_lookup() so that it
> will return a negative error code?


The reason was I didn't think about it. I misread the code and thought 
the error code were different.


>
> This way, we can keep the same logic in getvar_get_part_info()
>> +		} else {
>> +			r = -EINVAL;
>> +		}
>>   	} else {
>>   		fastboot_fail("this storage is not supported in bootloader", response);
>>   		r = -ENODEV;
>> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
>> index afc64fd5280717ae4041ed70268ccc01cfbb0496..9e2f7c01895785a4409eb67ea48abd02a6a6da26 100644
>> --- a/drivers/fastboot/fb_nand.c
>> +++ b/drivers/fastboot/fb_nand.c
>> @@ -151,7 +151,7 @@ static lbaint_t fb_nand_sparse_reserve(struct sparse_storage *info,
>>    *
>>    * @part_name: Named device to lookup
>>    * @part_info: Pointer to returned part_info pointer
>> - * @response: Pointer to fastboot response buffer
>> + * @response: 0 on success, 1 otherwise
> Why has this been modified? @response is still a pointer to fastboot
> response buffer.


Yes, reason is same as above. I simply misread the code.


Thanks


Federico


> If we wish to document the return code, use the Return: syntax:
>
> For example, here it would be:
>
> /**
>   * fastboot_nand_get_part_info() - Lookup NAND partion by name
>   *
>   * @part_name: Named device to lookup
>   * @part_info: Pointer to returned part_info pointer
>   * @response: Pointer to fastboot response buffer
>   *
>   * Return: 0 on success, 1 otherwise
>   */
>
>>    */
>>   int fastboot_nand_get_part_info(const char *part_name,
>>   				struct part_info **part_info, char *response)
>>
>> ---
>> base-commit: a517796cfa5d8f4ca2f0c11c78c24a08a102c047
>> change-id: 20250128-fastboot_slot_fix-69251576d9bb
>>
>> Best regards,
>> -- 
>> Federico Fuga <fuga@studiofuga.com>
