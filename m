Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D30FC36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9463B8192A;
	Tue, 25 Mar 2025 14:45:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BzdFnYpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B062681B42; Tue, 25 Mar 2025 14:45:48 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8802B808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso51929235e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742910346; x=1743515146; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HEWiR5X+o9OmqK8h6F+NQwAnOI/aP5xH8VG7NcKxOLw=;
 b=BzdFnYpnLvGQbW7G5MDtCMUOOoFryG/ZodHgM0RDmXW4AEcG90jGeVFRxPH7kt6CPc
 ix3/3WPXT8ITS8W3XZUqaCez65Jp38H39s317edlO4eIBcpJhTh12Ds34nHtGxI++s/U
 lEM44ZUP5lg05otdG43gTXDWkYe0lh4pl6jl/018qHD+HPVDULiMbDIBAJXHjLgn62uI
 +LEYG8x6Me0kokIPSEImf/+57+gql70P4qRwog7hJn+SbDUiSPtWPlFkVw9UbRmFYLNt
 iK/vNpGk8z0/fJDGOwhuBecXGL2xsfY6iqSsWZXV1e9Tvt7DhcXSKVUNcb5gG3xPaZDv
 dxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742910346; x=1743515146;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEWiR5X+o9OmqK8h6F+NQwAnOI/aP5xH8VG7NcKxOLw=;
 b=RBVdR99VuqgOmfNGTv+qpaxuuwFEkV0okLC5ZFnbNXMfNFbdB1/nGE3wFk7jSfphWx
 /uX3PaaC4643/9oGLXC51BP6Zo1zcZualROaVSuxdNvPps+b8TLUGM3Obs+50994HlKH
 VL8LGvHHByYvY80LfEuBJrYQOQnAUTAjH4Cq/srD4EG8tXlcgCLsrG9rfXzHR2NdY5Da
 PWy/xSnUPk0WguzUmrQ4lsmXKBvIIq7ZAlxXQ8+EkXnsqesr4UYQdsvGdACacxfXC+Zp
 Ufs34Lnv88tJX/1uE0Bnbzc9176SFnnMdF4YBT58hahsdnclxM7hGO9fyx7GrJg3Zdo/
 JKVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcP2TM7eP/NzwJ4EtlBjBlCLrrSYKwS8Dg0ZAkDHC+jLbPnYA+YlOrG+A2srQCCDvthXwY/r8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz36q8ExRJX7TnVN8a9ejfErj6ehq6eGzgohOWsyVV7Ryoe3RQ5
 zGR0aj5ztHW1m+rxml6sSP7HSOHn0t+zpw6vSFqukHIs/OPu8lAL9EtHyydEeDQ=
X-Gm-Gg: ASbGncvpxz0Yy6frnEB3xlYta4SKsIpR05X2Wxc9FGv+pn6LgmAXVv3gO+ffuKDU0L6
 mnx0EK0KW5WvbK0dvyU6ZXqLpnKyMOyk1xSv650pxCkpDDQO+A1ZR8sF/TSuOAlVDxQTXvL85TW
 fLzi1//aZyWltsAnM+jg8RJq8PalyMlIfAnMoJcS5cwAFhWxpCXnfiMv8SaTx/JffR9If6HowwV
 IvHclXQVBUZoJOfa8p6gyXA9B5WAWFb1LB7kQzzh6BQrjs1oxl5MOmmpSpEvmTIWhq3TPd+823P
 Hz5fy8iwCW/RmC7DVJzc/87HUHx/KK0EkUwERyZkoJybpLRfqVv6TekuSz7oh3yAtf7edp/NONk
 =
X-Google-Smtp-Source: AGHT+IH4cC7eqZ9kDWLIgpCmuqxr+GwjHG71QQn4EcpcQNkSnugUqD0OzlFGGV6CmTvXaQiBMiR4Kw==
X-Received: by 2002:a05:600c:4512:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43d509ed7d2mr175699515e9.7.1742910345877; 
 Tue, 25 Mar 2025 06:45:45 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3af8sm13968970f8f.31.2025.03.25.06.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 06:45:45 -0700 (PDT)
Message-ID: <572e6b40-679e-4ce2-bdde-6b825285a02f@linaro.org>
Date: Tue, 25 Mar 2025 14:45:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] scsi: de-dup calls to scsi_setup_write_ext()
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
 <20250325-scsi-sync-on-write-v1-2-3575aa1342e0@linaro.org>
 <10359646-6c8e-4872-8017-29d83e5d0f7e@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <10359646-6c8e-4872-8017-29d83e5d0f7e@linaro.org>
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



On 3/25/25 14:38, Neil Armstrong wrote:
> On 25/03/2025 14:02, Caleb Connolly wrote:
>> This gets called with the same parameter in two paths in scsi_write(),
>> de-dup them to prepare for additional logic after the write.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   drivers/scsi/scsi.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index 
>> 34ac47c03ab397ca999abf130d84ccbd3be4c419..1aa7fbdbb5278e387de72a3c3e73d19ea0342fff 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -220,25 +220,30 @@ static ulong scsi_write(struct udevice *dev, 
>> lbaint_t blknr, lbaint_t blkcnt,
>>           pccb->dma_dir = DMA_TO_DEVICE;
>>           if (blks > max_blks) {
>>               pccb->datalen = block_dev->blksz * max_blks;
>>               smallblks = max_blks;
>> -            scsi_setup_write_ext(pccb, start, smallblks);
>> -            start += max_blks;
>> -            blks -= max_blks;
>>           } else {
>>               pccb->datalen = block_dev->blksz * blks;
>>               smallblks = (unsigned short)blks;
>> -            scsi_setup_write_ext(pccb, start, smallblks);
>> -            start += blks;
>> -            blks = 0;
>>           }
>> +
>>           debug("%s: startblk " LBAF ", blccnt %x buffer %lx\n",
>>                 __func__, start, smallblks, buf_addr);
>> +        scsi_setup_write_ext(pccb, start, smallblks);
>> +
>>           if (scsi_exec(bdev, pccb)) {
>>               scsi_print_error(pccb);
>>               blkcnt -= blks;
>>               break;
>>           }
>> +
>> +        if (blks > max_blks) {
>> +            start += max_blks;
>> +            blks -= max_blks;
>> +        } else {
>> +            start += blks;
>> +            blks = 0;
>> +        }
> 
> Ok this changes the logic and the result of blkcnt on error, before
> is accounted the current command in the blkcnt but now it doesn't.

Ooh good point, will fix that in v2.
> 
> Weird we do not return any errors

Yeahh and scsi_print_error() is just a stub... This is probably 
something worth looking at in the future.
> 
>>           buf_addr += pccb->datalen;
>>       } while (blks != 0);
>>       debug("%s: end startblk " LBAF ", blccnt %x buffer %lX\n",
>>             __func__, start, smallblks, buf_addr);
>>
> 

-- 
Caleb (they/them)

