Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867C0C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 07:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A332080EB6;
	Fri, 31 Jan 2025 08:26:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O98gaNip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693C180EBD; Fri, 31 Jan 2025 08:26:56 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E396280C77
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 08:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so831793f8f.2
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 23:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738308413; x=1738913213;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qB0F6ikbDy6/OtdE1Jsd1d9jta2XPmS/XknKJPaijA8=;
 b=O98gaNipA2uFww8+2EkC5B9J9z8fn+zDbYsoIhRssOFKe8s+pNe5puAuwWbbgrESLb
 ja5FL+/jP5Xl3ivjS6HcaH+oG9EFbDvaiC4ar/dBP0ZQKk5m2zJ1PK97+FZMXZAfqTPH
 3L6aGSBuxGCdf23mghAoxwLbogDNVQShXSOnlqAlN0bxVJGY7ot6qHtIhhLkFAK3bcGU
 QhRhBW+AyTg0yTVD2DEjyDBX3MHSdMJ8tWiGombr31X5TLzX/9Z6w9U+zMPJP7fdhS8r
 yqIoy7G38wOMbTffbO2MIWSfMAKPD9TfbEIZ8UBzpfECtV2wLRJ8yqTF/pq4zsxKtH5x
 D3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738308413; x=1738913213;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qB0F6ikbDy6/OtdE1Jsd1d9jta2XPmS/XknKJPaijA8=;
 b=Shw5FbwzW9VPCB0gJ3eXBhJ9djLMo69l0Z7XbNbJgFOFSvYLKwt0URJ6OmGsI9RHNc
 R+R80QHtPaqOCLBHMAe0QPiek5RSP0Vc1Ov0yqXGMc0ufxSq1aeG5xNo+TmJ4wYDc3sN
 ioY1r5lXl1wn6+Cy5KVq4kZkbjRRG49KpG/xeQ8PJup539w6jhpWF/9/pAvEFcfUg5Tp
 DnZQevp38Bm4Bn5K/WFYrV8ILC/8zFoQ9e24t5sh324PoxCbmH88EZStb7urmc2qASF9
 4V0C5rcKUkUkZbsglZt53nn7auOYJq5QQ6KCRZX0zATq62pUvs4HL1utDOSAEVN2DMp3
 wyYg==
X-Gm-Message-State: AOJu0YyCq6BOXyCRpcpjCF2yoQiTManr9P9/kCCAahR8aozat3+MDSaR
 qtvArygpG8q89H7A/Fj1mFCMxFcQUmEWuGEmVcQXBie+V3EnqMeAWcxRkq6QXVA=
X-Gm-Gg: ASbGncvGQYTHUQsQTIXJ8gx5gXgy1sCgl1bfm3ipnv8Tpj3HG5o3pEVHdz9sjhyCKhQ
 RQg5aBolUNAYNgVSitQmY9UjEj1OzLJ6+HdduN0waor5gs7UiIDtuKtfyfU7MM1S6u8ImvNBy36
 1LrkP6p5K42wPrhs9Lj3evbesX4Z86DIBIlnQHWgbOtnNXx/ppGSTERuf7VIDBdB8chmvZ9x8g3
 AojOHHK37ysDXCSRQojqBKeu+uEp3o1CTHH9pUkwzF52QGh3fyHrFdWTGXAcwLQH8sozkL++asN
 FDdRRzGmQUYFBLm8KFD/bV/g
X-Google-Smtp-Source: AGHT+IE6V+FeM/tH9HCGgkWfg/PA+0DUliFIIhdZ0hl8LpbICgLcVrPRa6F/X1vxwwEngmYHjeOVkw==
X-Received: by 2002:adf:e701:0:b0:386:4a24:18f2 with SMTP id
 ffacd0b85a97d-38c519748e7mr8037178f8f.25.1738308413216; 
 Thu, 30 Jan 2025 23:26:53 -0800 (PST)
Received: from localhost ([2a01:cb1a:4074:4dd7:fefe:5ab4:19e5:2ed2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c122465sm3925650f8f.47.2025.01.30.23.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 23:26:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Federico Fuga <fuga@studiofuga.com>, Federico Fuga via B4 Relay
 <devnull+fuga.studiofuga.com@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] Fix fastboot handling of partitions when no slots are
 supported
In-Reply-To: <da361464-8326-4050-9556-9fad720b2022@studiofuga.com>
References: <20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com>
 <87r04kfm2w.fsf@baylibre.com>
 <da361464-8326-4050-9556-9fad720b2022@studiofuga.com>
Date: Fri, 31 Jan 2025 08:26:47 +0100
Message-ID: <871pwj8mvc.fsf@baylibre.com>
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

Hi Federico,

On jeu., janv. 30, 2025 at 16:03, Federico Fuga <fuga@studiofuga.com> wrote:

> Hi Mattijs,
>
> thanks for your kind response and suggestions.

Happy to help!

>
> We are actually suspending the development on this board, because it 
> seems the support for our hardware (sunxi A33) requires too much work 
> than expected. We were trying to update our 2018-flavoured bootloader 
> but it seems we did a lot of steps back, for reason I can't fully grasp.
>
> Anyway, I'll try to work on this patch in my spare time.

Thank you for contributing, it's very appreciated.

>
>
> Specifically:
>
>
>
> On 30/01/25 14:49, Mattijs Korpershoek wrote:
>> Hi Federico,
>>
>> Thank you for the patch.
>>
>> On mar., janv. 28, 2025 at 12:18, Federico Fuga via B4 Relay <devnull+fuga.studiofuga.com@kernel.org> wrote:
>>
>>> From: Federico Fuga <fuga@studiofuga.com>
>>>
>>> The fastboot module has a bug that prevents some command to work
>>> properly on devices that haven't an Android-like partition scheme, that
>>> is, just one spl and one kernel partition, instead of the redundant
>>> scheme with _a and _b slots.
>>>
>>> This is the schema of our NAND storage (board is based on an AllWinner
>>> A33 sunxi chip):
>>>
>>> => mtdparts
>>>
>>> device nand0 <1c03000.nand>, # parts = 4
>>>   #: name         size            net size        offset          mask_flags
>>>   0: spl          0x00020000      0x00020000      0x00000000      0
>>>   1: uboot        0x00100000      0x00100000      0x00020000      0
>>>   2: kernel_a     0x00400000      0x00400000      0x00120000      0
>>>   3: ubi          0x07ae0000      0x079e0000 (!)  0x00520000      0
>>>
>>> active partition: nand0,0 - (spl) 0x00020000 @ 0x00000000
>>>
>>> This happens when we try to erase the spl partition using fastboot:
>>>
>>> $ fastboot erase spl
>>> Erasing 'spl_a'               FAILED (remote: 'invalid NAND device')
>>> fastboot: error: Command failed
>>>
>>> The error occurs because getvars fails to handle the error returned by
>>> nand layer when a partition cannot be found.
>>>
>>> Indeed, getvar_get_part_info returns what is returned by
>>> fastboot_nand_get_part_info (0 on success, 1 on failure) but it should
>>> return -ENODEV or -EINVAL instead. Since the cause of failure is not
>>> returned by the nand function, I decided to return -EINVAL to make it
>>> simple.
>>>
>>> Signed-off-by: Federico Fuga <fuga@studiofuga.com>
>> I could apply this version, finally :)
>>
>> b4 got a bit confused since it has been send as a v1 but using the
>> following command worked for me:
>>
>> $ b4 shazam -s -l --check 20250128-fastboot_slot_fix-v1-1-1a4688936662@studiofuga.com -v1
>
>
> Yes I did notice this, I tried it after sending and I was puzzled why it 
> spit out the same error as before. I'm still learning.

b4 tries to do some intelligent lookup where it matches the subject name
to find "other versions" of the same patch. Since it found some other
patch with V2, it thought it was the latest one.

If you keep using b4 this should not happen anymore, as it automatically
increments the patch version.

>
>
>> Now for the patch itself:
>>
>> Please use 'fastboot:' prefix as a commit title.
>> Use '$ git log --oneline -- drivers/fastboot/' to see what other commits
>> where using as a title.
>>
>> Some more comments below. Please make sure to answer this email to
>> acknowledge/reject review feedback.
>> Also, when sending a v2, please make sure to include a changelog.
>>
>> If you need help setting things up properly, let me know. I'm also
>> reachable on IRC https://libera.chat/, channel #u-boot, my nickame is mkorpershoek.
>
>
> Thanks, I'll surely do.

Do not hesitate. I'm not always around but I try to answer when possible :)

>
>
>>> ---
>>>   drivers/fastboot/fb_getvar.c | 5 ++++-
>>>   drivers/fastboot/fb_nand.c   | 2 +-
>>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
>>> index 9c2ce65a4e5bce0da6b18aa1b2818f7db556c528..816ed8a6213b5c1f0948a813c6f6a865a4b47ba8 100644
>>> --- a/drivers/fastboot/fb_getvar.c
>>> +++ b/drivers/fastboot/fb_getvar.c
>>> @@ -121,8 +121,11 @@ static int getvar_get_part_info(const char *part_name, char *response,
>>>   			*size = disk_part.size * disk_part.blksz;
>>>   	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
>>>   		r = fastboot_nand_get_part_info(part_name, &part_info, response);
>>> -		if (r >= 0 && size)
>>> +		if (r == 0 && size) {
>>>   			*size = part_info->size;
>> Maybe the patch is simpler this way, but I think that it would be better
>> if fastboot_mmc_get_part_info() and fastboot_nand_get_part_info() would
>> behave the same. The naming is pretty close already, and having
>> different behaviours/return codes seems confusing to me.
>
>
> Indeed, having the same code would be definitely proper.

Yes. I thinks that if fastboot_mmc_get_part_info() and
fastboot_nand_get_part_info() don't behave the same, it will cause
confusing.

>
>
>> Is there a strong reason for not modifying fb_nand_lookup() so that it
>> will return a negative error code?
>
>
> The reason was I didn't think about it. I misread the code and thought 
> the error code were different.

Ok, thanks

>
>
>>
>> This way, we can keep the same logic in getvar_get_part_info()
>>> +		} else {
>>> +			r = -EINVAL;
>>> +		}
>>>   	} else {
>>>   		fastboot_fail("this storage is not supported in bootloader", response);
>>>   		r = -ENODEV;
>>> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
>>> index afc64fd5280717ae4041ed70268ccc01cfbb0496..9e2f7c01895785a4409eb67ea48abd02a6a6da26 100644
>>> --- a/drivers/fastboot/fb_nand.c
>>> +++ b/drivers/fastboot/fb_nand.c
>>> @@ -151,7 +151,7 @@ static lbaint_t fb_nand_sparse_reserve(struct sparse_storage *info,
>>>    *
>>>    * @part_name: Named device to lookup
>>>    * @part_info: Pointer to returned part_info pointer
>>> - * @response: Pointer to fastboot response buffer
>>> + * @response: 0 on success, 1 otherwise
>> Why has this been modified? @response is still a pointer to fastboot
>> response buffer.
>
>
> Yes, reason is same as above. I simply misread the code.

Understood.

>
>
> Thanks
>
>
> Federico
>
>
>> If we wish to document the return code, use the Return: syntax:
>>
>> For example, here it would be:
>>
>> /**
>>   * fastboot_nand_get_part_info() - Lookup NAND partion by name
>>   *
>>   * @part_name: Named device to lookup
>>   * @part_info: Pointer to returned part_info pointer
>>   * @response: Pointer to fastboot response buffer
>>   *
>>   * Return: 0 on success, 1 otherwise
>>   */
>>
>>>    */
>>>   int fastboot_nand_get_part_info(const char *part_name,
>>>   				struct part_info **part_info, char *response)
>>>
>>> ---
>>> base-commit: a517796cfa5d8f4ca2f0c11c78c24a08a102c047
>>> change-id: 20250128-fastboot_slot_fix-69251576d9bb
>>>
>>> Best regards,
>>> -- 
>>> Federico Fuga <fuga@studiofuga.com>
