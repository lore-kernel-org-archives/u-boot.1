Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAB5C0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 09:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9125581BC0;
	Tue, 28 Jan 2025 10:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=studiofuga.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=studiofuga.com header.i=@studiofuga.com header.b="pa6iEZoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C74C81CC5; Tue, 28 Jan 2025 10:07:48 +0100 (CET)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EAA78197D
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 10:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=studiofuga.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fuga@studiofuga.com
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yhzvj1kj3z1ms;
 Tue, 28 Jan 2025 10:07:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studiofuga.com;
 s=20220517; t=1738055265;
 bh=rL10CnC/KER8lFK8DnqrJNFmDPD/gLLRAn8DkhrxuJQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=pa6iEZoDvH0e3jUMNyYkpXboeIgOpsBwmUsUMWNunuoxmdq5gscvxKVYHNmHq00c/
 NKkE8olDIKvRsNHLwWlZ3JtSSSp2weDmA0HW8V0BzzguIePE7AeCTt6XkFF4Acpu7/
 T2ni2gLfIbT7yftYOLyeBJmedeIpgcI4lqyGwKVk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yhzvh1yFtz54v; Tue, 28 Jan 2025 10:07:44 +0100 (CET)
Message-ID: <a4e474b8-2bc2-4c73-8532-5891af424445@studiofuga.com>
Date: Tue, 28 Jan 2025 10:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix fastboot handling of partitions when no slots are,
 supported
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Maxime Ripard <maxime@cerno.tech>,
 u-boot@lists.denx.de
References: <a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com>
 <874j1js4yb.fsf@baylibre.com>
Content-Language: en-US
From: Federico Fuga <fuga@studiofuga.com>
Autocrypt: addr=fuga@studiofuga.com; keydata=
 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
 3Z10R+iQ3XwjCMCTFTN+4NBJ1U0=
In-Reply-To: <874j1js4yb.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
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
sorry, my bad: I exported from the wrong branch, as I was working on the 
latest release, not from main.

Resending it.
Sorry for the mistake.


Federico




On 28/01/25 09:44, Mattijs Korpershoek wrote:
> Hi Federico,
>
> Thank you for the patch.
>
> On ven., janv. 24, 2025 at 11:49, Federico Fuga <fuga@studiofuga.com> wrote:
>
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
>>    #: name         size            net size        offset mask_flags
>>    0: spl          0x00020000      0x00020000      0x00000000      0
>>    1: uboot        0x00100000      0x00100000      0x00020000      0
>>    2: kernel       0x00400000      0x00400000      0x00120000      0
>>    3: ubi          0x07ae0000      0x079e0000 (!)  0x00520000      0
>>
>> active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000
>>
>> This happens when we try to erase the spl partition using fastboot:
>>
>> $ fastboot erase spl
>> Erasing 'spl_a'               FAILED (remote: 'invalid NAND device')
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
> Unfortunately, I'm unable to apply this. I've tried using b4 and via git am.
>
> $ b4 shazam -s -l --check a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com
>
> Grabbing thread from lore.kernel.org/all/a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com/t.mbox.gz
> Checking for newer revisions
> Grabbing search results from lore.kernel.org
> Analyzing 2 messages in the thread
> Assuming new revision: v2 ([PATCH] Fix fastboot handling of partitions when no slots are, supported)
> Analyzing 0 code-review messages
> Will use the latest revision: v2
> You can pick other revisions using the -vN flag
> Checking attestation on all messages, may take a moment...
> ---
>    [PATCH] Fix fastboot handling of partitions when no slots are, supported
>      + Link: https://lore.kernel.org/r/add4f6ac-3dd5-4707-a40c-a41191e62912@studiofuga.com
>      + Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Traceback (most recent call last):
>    File "/mnt/work/upstream/b4/src/b4/command.py", line 435, in <module>
>      cmd()
>      ~~~^^
>    File "/mnt/work/upstream/b4/src/b4/command.py", line 417, in cmd
>      cmdargs.func(cmdargs)
>
>
> Downloading the thread from this patchwork link (clicking on "mbox"):
> https://patchwork.ozlabs.org/project/uboot/patch/a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com/
>
> $ git am Fix-fastboot-handling-of-partitions-when-no-slots-are-supported.patch
> Applying: Fix fastboot handling of partitions when no slots are, supported
> error: corrupt patch at line 13
> error: could not build fake ancestor
> Patch failed at 0001 Fix fastboot handling of partitions when no slots are, supported
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
>
> Can you please confirm that you are able to apply it yourself?
> Maybe the email client is misconfigured somehow?
>
> I've also tried to apply the one that has been send yesterday
> (https://patchwork.ozlabs.org/project/uboot/patch/add4f6ac-3dd5-4707-a40c-a41191e62912@studiofuga.com/)
> but I'm encountering the same problem.
>
>> ---
>>    drivers/fastboot/fb_getvar.c | 5 ++++-
>>    drivers/fastboot/fb_nand.c   | 2 +-
>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
>> index 93cbd598e0..f5d8b03301 100644
>> --- a/drivers/fastboot/fb_getvar.c
>> +++ b/drivers/fastboot/fb_getvar.c
>> @@ -121,8 +121,11 @@ static int getvar_get_part_info(const char
>> *part_name, char *response,
>>                *size = disk_part.size * disk_part.blksz;
>>        } else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
>>            r = fastboot_nand_get_part_info(part_name, &part_info, response);
>> -        if (r >= 0 && size)
>> +        if (r == 0 && size) {
>>                *size = part_info->size;
>> +        } else {
>> +            r = -EINVAL;
>> +        }
>>        } else {
>>            fastboot_fail("this storage is not supported in bootloader",
>> response);
>>            r = -ENODEV;
>> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
>> index 5a55144479..3ee0f40ea8 100644
>> --- a/drivers/fastboot/fb_nand.c
>> +++ b/drivers/fastboot/fb_nand.c
>> @@ -141,7 +141,7 @@ static lbaint_t fb_nand_sparse_reserve(struct
>> sparse_storage *info,
>>     *
>>     * @part_name: Named device to lookup
>>     * @part_info: Pointer to returned part_info pointer
>> - * @response: Pointer to fastboot response buffer
>> + * @response: 0 on success, 1 otherwise
>>     */
>>    int fastboot_nand_get_part_info(const char *part_name,
>>                    struct part_info **part_info, char *response)
>> -- 
>> 2.48.1
