Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E37C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 17:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80422810E8;
	Tue, 25 Mar 2025 18:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XdZZIvr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B398186D; Tue, 25 Mar 2025 18:57:38 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C95581026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 18:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso38217985e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742925456; x=1743530256; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eK5Bh1wJUEGD4bO2CWJ6aKOQpoaWQsVh6h5kFfqmbFM=;
 b=XdZZIvr6wTY63Hv/A8N/a41QkFtsJy51EUcGlFb6dLVNtu/5qQyMAFv2fOPcVoFYEr
 3SAwExxtGUTyVpZrJBwYtbdhIACdcVtxviEvbz6XR0iXetdRzgffw3FPKXHhrO6BhQ+T
 9e2MpBhgKDHI6n+7gjIy3EzUAxHcXxuYwgJHjF0yhDwiUUPVTPsm2pcBmUhXjSTBazo8
 RXFXV/ko2OLiQ32XWFrx8ClFQ9BD4lpHMj0aE+tanpk1vC63dgtGIKHuX70VivBsAa0u
 wOWiQvfkgKOeRiuNlGc2D1mm8Ma/08aUjplERsnjzhdN1z2uiFMzVO9IW+WkhT9RopAr
 AOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742925456; x=1743530256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eK5Bh1wJUEGD4bO2CWJ6aKOQpoaWQsVh6h5kFfqmbFM=;
 b=DjgdplU92z1xyexyS7ES4jzQUmwFn9xILb0qlqCluFvWEkd0ewigGzv2E1pq8JxdOh
 f6wYYPJds9/hO15mqkz9CKhokIuPgcE7AHmkA73LRRDvUtRT/7kzjvFJfr/NGYQfFsmW
 GM05jCuMtiafCHHkWGPh7d0vFrAi7IcDTwkJ5LkQ5QpkRiVdXLyQOsbrSe8okBnkwi4M
 HHq0o5BPApgv4vvrsNHeU8hi3wt/6vL1SEmET330tayPq3HiPjHxYrFFpYSn4Pcqw0FB
 aaydcBIhoRZ+lszVWlxzF0M6sgPCx7ULYR0s4EXBK6YEBNMvTmG4MJz3XGVwkl2dJwbz
 FLbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR/T7KMb6gdP4wyRax+jQjguyv2uYFUkJW7pK8w7r4GGK1sNWkGj/TJyiUwjvw4uLaqkpH1e8=@lists.denx.de
X-Gm-Message-State: AOJu0YwMgyGfZWT9MJtBHfgDhGITsOn78KydUwaAY/ss3QmmuGp1cbVX
 G9i9WRT03bqhvn6wapUl0yZgbhF+PgTz0VLie9oPw183MtJee/B9IXBCbBE5o1I=
X-Gm-Gg: ASbGncssFjbZjWb6ZJKXVMxDMEXKxKA0ONaO4VyEyUT0wbxpPCjQN5ET7aBt2KhBEM3
 +TPrAAO0fWtZZKJyZqCHBSGiFPGOptI7/OctvL0fx5I0LJDlQC4XPXmg2gh1azStcsxYCLUZzt7
 WKe2yUO0GkgHEaK5zX2lVTkZYfFWzhWL8fbZBGsOqaeHNX5Z63mouvxPZgUQOq+LRT4TnsZUkx6
 ILh5hgczYZ2EHuRV272AHTyYtJ7hbovpFKbP3r0bTDf6Nc6q7AwPf9eJ8UKJNC08JH+GPgcr4Qi
 c9n8CcNtatYZc5g1Q28UNjCG6k25oJBjFfqvhJ7MToXb3+0B7byJqEGyfFN3ATriB4xBW5G7t3Q
 =
X-Google-Smtp-Source: AGHT+IHgxbmSJnAU6wmd2Q6YoQj+/f2fsZoZQbKb8GeJgx/6KJv7NWmWo/Z3o0lDfUzAhqk4mkBH+g==
X-Received: by 2002:adf:e19c:0:b0:391:2e97:5788 with SMTP id
 ffacd0b85a97d-3997f94041fmr16617151f8f.55.1742925455595; 
 Tue, 25 Mar 2025 10:57:35 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65f0sm14422527f8f.74.2025.03.25.10.57.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 10:57:34 -0700 (PDT)
Message-ID: <d7e2f337-bf71-45cb-b3a3-0ccd8379535b@linaro.org>
Date: Tue, 25 Mar 2025 18:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] scsi: sync cache on write
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
 <20250325-scsi-sync-on-write-v1-3-3575aa1342e0@linaro.org>
 <b737a955-36fc-4816-8169-2a27270d9fce@linaro.org>
 <b10dbf6c-c30f-44b7-950b-f7fb16afcf73@linaro.org>
 <5256bf47-ba7c-4ec8-8757-6d59910176dc@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <5256bf47-ba7c-4ec8-8757-6d59910176dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 3/25/25 16:18, neil.armstrong@linaro.org wrote:
> On 25/03/2025 14:49, Caleb Connolly wrote:
>>
>>
>> On 3/25/25 14:33, Neil Armstrong wrote:
>>> On 25/03/2025 14:02, Caleb Connolly wrote:
>>>> We don't have a mechanism to safely shutdown block devices prior to a
>>>> baord reset or driver removal. Prevent data loss by synchronizing the
>>>> SCSI cache after every write.
>>>>
>>>> In particular this solves the issue of capsule updates looping on some
>>>> devices because the board resets immediately after deleting the capsule
>>>> file and this write wouldn't be flushed in time.
>>>>
>>>> This may impact NAND wear, but should be negligible given the usecases
>>>> for disk write in U-Boot.
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>   drivers/scsi/scsi.c | 28 ++++++++++++++++++++++++++++
>>>>   1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>>>> index 
>>>> 1aa7fbdbb5278e387de72a3c3e73d19ea0342fff..1b71e580b89b100395ea132a4976366a713cba8a 100644
>>>> --- a/drivers/scsi/scsi.c
>>>> +++ b/drivers/scsi/scsi.c
>>>> @@ -77,8 +77,25 @@ static void scsi_setup_inquiry(struct scsi_cmd 
>>>> *pccb)
>>>>       pccb->cmdlen = 6;
>>>>       pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>>>>   }
>>>> +static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t 
>>>> start,
>>>> +                  unsigned short blocks)
>>>> +{
>>>> +    pccb->cmd[0] = SCSI_SYNC_CACHE;
>>>> +    pccb->cmd[1] = 0;
>>>> +    pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
>>>> +    pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
>>>> +    pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
>>>> +    pccb->cmd[5] = (unsigned char)start & 0xff;
>>>> +    pccb->cmd[6] = 0;
>>>> +    pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
>>>> +    pccb->cmd[8] = (unsigned char)blocks & 0xff;
>>>> +    pccb->cmd[9] = 0;
>>>> +    pccb->cmdlen = 10;
>>>> +    pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>>>> +}
>>>> +
>>>>   static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t 
>>>> start,
>>>>                   unsigned short blocks)
>>>>   {
>>>>       pccb->cmd[0] = SCSI_READ10;
>>>> @@ -235,8 +252,19 @@ static ulong scsi_write(struct udevice *dev, 
>>>> lbaint_t blknr, lbaint_t blkcnt,
>>>>               blkcnt -= blks;
>>>>               break;
>>>>           }
>>>> +        /*
>>>> +         * Ensure the writes are flushed to disk so we don't lose data
>>>> +         * on board reset.
>>>> +         * FIXME: this ought to be in a SCSI shutdown path instead
>>>> +         */
>>>> +        scsi_setup_sync_cache(pccb, start, smallblks);
>>>
>>> Why can't this be done at the end of scsi_write() ?
>>
>> We have the same limitation that we can only flush SCSI_MAX_BLK blocks 
>> at once. It could be done in a second loop at the end but I figured 
>> it's more sensible to just interleave them.
> 
> Indeed you're right, another solution is to leave count to 0, and it 
> will sync all data after start:
> ````
> If the LBA and COUNT arguments are both zero (their defaults) then all 
> blocks in the cache are synchronized
> If LBA is greater than zero while COUNT is zero then blocks in the cache 
> whose addresses are from and including LBA to the highest lba on the 
> device are synchronized.
> ```
> 
> And it seems Linux only passes 0 parameters, and just flushes all data 
> in cache:
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/scsi/sd.c#L1145
> 
> So either you leave is as is so all data is written as soon as possible,
> or we wait until the end of the write and flush everything.

Ahh, damn I should have checked for that!
> 
> I think the last one is just simpler and safer.

You're totally right XD

Thanks
> 
> Neil
> 
>>>
>>>> +        if (scsi_exec(bdev, pccb)) {
>>>> +            scsi_print_error(pccb);
>>>> +            break;
>>>> +        }
>>>> +
>>>>           if (blks > max_blks) {
>>>>               start += max_blks;
>>>>               blks -= max_blks;
>>>>           } else {
>>>>
>>>
>>> And perhaps a sync subcommand of the scsi command would be nice to 
>>> have !
>>
>> Good idea, that would tie in nicely if/when we get a .sync() op for 
>> block devices and call it prior to board reset.
>>>
>>> Neil
>>>
>>
> 

-- 
Caleb (they/them)

