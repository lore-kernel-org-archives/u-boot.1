Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1D1C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B6F081B42;
	Tue, 25 Mar 2025 14:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AD6QPczG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B1D81CA8; Tue, 25 Mar 2025 14:49:38 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518798192A
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so52362805e9.3
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742910576; x=1743515376; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oZIIDpTpA7xiZ3T3M4vY53YkejTE+I4eKp3Sg29iRvc=;
 b=AD6QPczG09O32ATMIvuqhto6KIeL5sVvNg40JMuqPBvT8VHlWS/wTyIWABxiWciVbP
 RW32v1noHA/H9Obbfh2Biruph4VyBo3F7j5rsu0V10tu0tr56aCXNDfu5F+5ScsIV8kc
 /UAtb4eSettvt7iLBxQu2kihiBaN/QBvEybZeui4ege/SwecY7TDJGdzlw8sKsMfj91u
 S+5vhszypQwAXkiJ4DpbzTkV5unzZ/8dpRT8hXRU3ZsuRwqagD+VclabBFm3EcM0noTH
 kNPrXaTxiNtAgrjkqNxqYL2w98fGlQ2MtaWH91FkkH+JmVDoDJG7V4jetuAwPYzhQ3sH
 pD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742910576; x=1743515376;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZIIDpTpA7xiZ3T3M4vY53YkejTE+I4eKp3Sg29iRvc=;
 b=B+17CFRWeVjaa20yfqrjzgq5a3vN1ieNij8X3XgN1MZesP/Doasz71GNlSzbzP3SSk
 Va9BT0uVh5PkW8B5a/lynNTa8vkcY5cXSTZHre/gW0M3fXZ2ZTl4h+AYXziB3rT51f3O
 IGAqsgpNTHOK1PjQp7+90JQrLDBmw+GAPzbPZ32RvEggx1n6mBXuan3GbGkE2qg83WcO
 2LwS5ZzyuSPva26xWz1QpBZIXE9qknggy7g/e6+OfrBUNs5CY+OlQCHVni+BBWw7pjSI
 +8RhVnrDNN5NC40IOoHr9+rDCXAwCy3bm0E/eKA/X7n8U4HmALAx1dl0j6WrL3ifeP07
 TJFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNyBQcdWz5HyeKcXdVIV+wXKMni5wZtCr1muXBUj0g2maWsaDp0hUWR92INnkVul12Y6JdLoY=@lists.denx.de
X-Gm-Message-State: AOJu0YxSUjDbrBYqan3MN9KJd+GV/h271gtcgcmI9bAdpLz5eGhD4aPx
 F8nZSubMhj05KH0U6cD8BnCClygbQFgBMRZd+ru1H/ija4V6Pu/Oxk8Tf7fcA10=
X-Gm-Gg: ASbGncvM2KVCa4o4+tiVsmPcOqy9CQbPHi5SxvOZgiokCbuXn9ktW6QvDF2CcDL9bZ5
 RcCtyv2oxmZ7yun9efA8iicsOap0IbaiqEYtkQ5AsscK56mrGXo7OQqawJjqtQ3rTgjrLq26/wn
 Gh0gYBTly0AspWw+1xkHxsFcwcMxyUbmU57O7R9ptzWuwp5MQ4jZv3EB/eOXDogRGEvjFJeV9M0
 DgWs/SNklRNZI6vfKC6ExURcWh9ECzWmUyAk7+XiossP5vDYUtXnJOGWPODWz35dJgvUbjrCM/2
 rAcp23TW6jaBVnl8Ae4IRyWCGoPkspimlHL+Jy2SNKuUC6AOb82tMN3uzrDahW8Oj1zncTdSS1A
 =
X-Google-Smtp-Source: AGHT+IHSOIttQ3sPIWQ1F8tMsDqeEz96/NmJB6MW6nia247r0jNDzdH5skdhIOsXrpYBZDXbvV8Uog==
X-Received: by 2002:a05:600c:1d88:b0:43d:23fe:e8a6 with SMTP id
 5b1f17b1804b1-43d509e4658mr184762645e9.5.1742910575680; 
 Tue, 25 Mar 2025 06:49:35 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43d7c6a5sm203616595e9.0.2025.03.25.06.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 06:49:35 -0700 (PDT)
Message-ID: <b10dbf6c-c30f-44b7-950b-f7fb16afcf73@linaro.org>
Date: Tue, 25 Mar 2025 14:49:34 +0100
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
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <b737a955-36fc-4816-8169-2a27270d9fce@linaro.org>
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



On 3/25/25 14:33, Neil Armstrong wrote:
> On 25/03/2025 14:02, Caleb Connolly wrote:
>> We don't have a mechanism to safely shutdown block devices prior to a
>> baord reset or driver removal. Prevent data loss by synchronizing the
>> SCSI cache after every write.
>>
>> In particular this solves the issue of capsule updates looping on some
>> devices because the board resets immediately after deleting the capsule
>> file and this write wouldn't be flushed in time.
>>
>> This may impact NAND wear, but should be negligible given the usecases
>> for disk write in U-Boot.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/scsi/scsi.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index 
>> 1aa7fbdbb5278e387de72a3c3e73d19ea0342fff..1b71e580b89b100395ea132a4976366a713cba8a 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -77,8 +77,25 @@ static void scsi_setup_inquiry(struct scsi_cmd *pccb)
>>       pccb->cmdlen = 6;
>>       pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>>   }
>> +static void scsi_setup_sync_cache(struct scsi_cmd *pccb, lbaint_t start,
>> +                  unsigned short blocks)
>> +{
>> +    pccb->cmd[0] = SCSI_SYNC_CACHE;
>> +    pccb->cmd[1] = 0;
>> +    pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
>> +    pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
>> +    pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;
>> +    pccb->cmd[5] = (unsigned char)start & 0xff;
>> +    pccb->cmd[6] = 0;
>> +    pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
>> +    pccb->cmd[8] = (unsigned char)blocks & 0xff;
>> +    pccb->cmd[9] = 0;
>> +    pccb->cmdlen = 10;
>> +    pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
>> +}
>> +
>>   static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
>>                   unsigned short blocks)
>>   {
>>       pccb->cmd[0] = SCSI_READ10;
>> @@ -235,8 +252,19 @@ static ulong scsi_write(struct udevice *dev, 
>> lbaint_t blknr, lbaint_t blkcnt,
>>               blkcnt -= blks;
>>               break;
>>           }
>> +        /*
>> +         * Ensure the writes are flushed to disk so we don't lose data
>> +         * on board reset.
>> +         * FIXME: this ought to be in a SCSI shutdown path instead
>> +         */
>> +        scsi_setup_sync_cache(pccb, start, smallblks);
> 
> Why can't this be done at the end of scsi_write() ?

We have the same limitation that we can only flush SCSI_MAX_BLK blocks 
at once. It could be done in a second loop at the end but I figured it's 
more sensible to just interleave them.
> 
>> +        if (scsi_exec(bdev, pccb)) {
>> +            scsi_print_error(pccb);
>> +            break;
>> +        }
>> +
>>           if (blks > max_blks) {
>>               start += max_blks;
>>               blks -= max_blks;
>>           } else {
>>
> 
> And perhaps a sync subcommand of the scsi command would be nice to have !

Good idea, that would tie in nicely if/when we get a .sync() op for 
block devices and call it prior to board reset.
> 
> Neil
> 

-- 
Caleb (they/them)

