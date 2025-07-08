Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78393C83F09
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 14:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7200832F0;
	Tue,  8 Jul 2025 16:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C0opEn4Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C93832F0; Tue,  8 Jul 2025 16:32:59 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E095683297
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 16:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so36982655e9.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751985176; x=1752589976; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ATSURZVGIaKJpvj5EwOr02mJYdYAvyv9qvyCS4VnjH0=;
 b=C0opEn4Y6x5nMFTGoS6Owth75/toAM/xf7le/QE9GO/Z+igRtywFH9rgJfuzr31cAB
 iiffbUK2XGR9aET5QLu/v4kkEzYpN0ghK3zvA1ACxbYrVFar2oiBSxG/jIhpdX76ZoyW
 ZiTNGdjPDiZ54yjpsGx4jhd7YtG16567pokIYm6q/yoB9teXFlzojdQCuRrBAsxN6Oro
 2doYVtRNzkeP+MjW8IAURTcvXctiQaQAPR72xAfapdkRmab0VtN0BlMJ27ajvWg+llUE
 g9+DRBxhvVtoKiADvqE0yiHSTFFcrLtQloS6PDOqqsLDBik5DSVmX74yTetuoaIWsmGL
 6RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751985176; x=1752589976;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ATSURZVGIaKJpvj5EwOr02mJYdYAvyv9qvyCS4VnjH0=;
 b=dTFT5NEJK4sF9FnF9gZ+Y0Zep4sIEJ3LqID414HFbCCisX8i+l1+X2l3rcIdZByzZX
 BgmHTlRDzHa70CzlHVpb/hC4JwFUhhRcki953bL6YO3n6b1TJ7LicQ0Iw+Jdc7ci8Row
 ach+ghxpZvt7Fmk1mbj2bHBhHE8FsKi+hJyPEdjlBSVpnsKWzPvohROwZ7Tf5hyxRDA/
 3gRXQgl3HFwXMOKToarPEgbGqO+iA5uc59pT2izMqb6CudAv+tBqTF5aWStccMQgoKeU
 Jtyp/71a8e4AkOhUYc2i07BYVW8VB8aRTUQGWbVYssbFb5ELMcujachsBTb2b8jJnDt4
 E56g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxkXZTEFsrZCGf/2m7UXc/Q20pWjY1FAwYlOYR7QF5mnA1kGBGgkAgUhZBSn3IyY4YObOvHSg=@lists.denx.de
X-Gm-Message-State: AOJu0YzigezpN8j7uUrlPeGXxMOOD6KncQCVI3jgd6fSb0cq1sbnhmRo
 8ZSEllNVpVLCF7WuziWW0AG7VzWf5uN4gKehfeU1w+/rE8RTVFFX1oCn459tqKFpyPQ=
X-Gm-Gg: ASbGnctKL75zKr2kxk3oZlruWt4wgpoCPytVnTqmuHJ7jZ7CD2h0ciXYz3zleMgwebc
 vPnOVtr+jf3fp5yctu1DjIQkV3DwH+s1JYB8PdTDUeI5WYM6QUEU8iAdDtUDqOWE6/mCm9sio8h
 UipSRyMO0tfQrkexeeQCPLQ6AycvogcaU4c5Lbp59JAf14LoHSmkA4bMhAAfpKpqb9/slpKZHWI
 zNypPsqiSZA/p6crPDb9U4jVu/vm1i7hbNTXCmM0heW2VPBtEdmnF05k4y6Xo4E3/yNDx4ajeY4
 lbg5CQBFigV9vP9D/k3Y4D2epKA3ip6vd8c/om29e44kH/afZ/PD5lAjmvQJnd8d6/sIFTnX+75
 FCsaAI5CWAcnBqfLqnbtySATJJm06rhQfUl7yuGNR2igfoc0=
X-Google-Smtp-Source: AGHT+IFGzl3lG1fpNkM0UCSome96qNyNLTi1NJFw2XDx9R4YoKmM3bggjDKJ1SVLU9Rn00CmUnbL2Q==
X-Received: by 2002:a05:6000:18a5:b0:3a5:2182:bce2 with SMTP id
 ffacd0b85a97d-3b4964c0a9fmr15969556f8f.17.1751985176225; 
 Tue, 08 Jul 2025 07:32:56 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:e07:801:a08:6480:3e01:6cde?
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd45957fsm23055335e9.17.2025.07.08.07.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 07:32:55 -0700 (PDT)
Message-ID: <43d86312-c109-4f22-9ea2-92725030f053@linaro.org>
Date: Tue, 8 Jul 2025 15:32:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, WenRuo Qu <wqu@suse.com>,
 Tom Rini <trini@konsulko.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
 <8780edf7-e89e-424c-8770-2d45ab8849d4@wdc.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <8780edf7-e89e-424c-8770-2d45ab8849d4@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08/07/2025 15:16, Johannes Thumshirn wrote:
> On 08.07.25 13:35, Andrew Goodbody wrote:
>> multi is guaranteed to be NULL in the first two error exit paths so the
>> attempt to free it is not needed. Remove those calls.
>>
>> This issue found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>    fs/btrfs/volumes.c | 2 --
>>    1 file changed, 2 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 5726981b19c..71b0b55b9c6 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -972,12 +972,10 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, int rw,
>>    again:
>>    	ce = search_cache_extent(&map_tree->cache_tree, logical);
>>    	if (!ce) {
>> -		kfree(multi);
>>    		*length = (u64)-1;
>>    		return -ENOENT;
>>    	}
>>    	if (ce->start > logical) {
>> -		kfree(multi);
>>    		*length = ce->start - logical;
>>    		return -ENOENT;
> 
> What tree are you working against? __btrfs_map_block() is "gone" since
> cd4efd210edf ("btrfs: rename __btrfs_map_block to btrfs_map_block")
> which is more than two years old.

master

https://source.denx.de/u-boot/u-boot/-/blob/master/fs/btrfs/volumes.c?ref_type=heads#L975

I am not seeing the commit you mention in master or -next.

Andrew
