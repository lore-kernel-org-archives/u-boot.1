Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8C8D1D493
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 20:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5864842DB;
	Thu,  8 Jan 2026 21:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LLm0lsay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813D58430F; Thu,  8 Jan 2026 21:34:59 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 321DB8415E
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 21:34:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dnGqG2MVDz9vRW;
 Thu,  8 Jan 2026 21:34:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767904490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3ARbeMwwD2Lw5XnC31Sx2Az4AUJ5hK/VHr/2rA/JEA=;
 b=LLm0lsayoGAN4rtImSrdCZXS/aUfHBizIZos9RP+i+KZbInNVXnuOEZraMR9ZZKsocCAIU
 cnNAton3GhlwoIxeY6lzx1eLJ7TVjvgLoGDQCG6rwRZIfJ6W5v6yxN0r/JhvaUcALEBQlq
 lfcnMtCEnpiLEJ+6axMMxHKDfCF1Tjx3DiEWE7g+MbXzG4TombjBbpr4fuAP7/94c16ezm
 dQZVKrtmgXe+vIcd4GhAOz5kHcNRllVZ2aQMxWA0A3Epg+55algyVamfGltVe/VDIi5jBb
 +9d5z+YtPAWNVXeWGstKX1VWtZVCBZKQhTXbG8s/cSg7ua+bEC3Z35Y7vBPp9g==
Message-ID: <f0eed6c7-54fb-45aa-be22-c1d84c0ebb75@mailbox.org>
Date: Thu, 8 Jan 2026 21:34:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ufs: uclass: fix potential unitialised use
To: Casey Connolly <casey.connolly@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260108191626.3119582-1-casey.connolly@linaro.org>
 <4780165d-9e32-4628-b457-299972a21fa8@mailbox.org>
 <27fd1b95-798f-497b-98f3-2697ad0a6cda@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <27fd1b95-798f-497b-98f3-2697ad0a6cda@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8e7efa354468bf57804
X-MBO-RS-META: epwwj3u9imiy1p53bb981k47r4tio6nj
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

On 1/8/26 9:09 PM, Casey Connolly wrote:
> 
> 
> On 08/01/2026 20:55, Marek Vasut wrote:
>> On 1/8/26 8:16 PM, Casey Connolly wrote:
>>> When host_ref_clk_freq is 0, err will be returned before being set.
>>> Assign a default value to fix the warning.
>>
>> Indeed, nice find.
>>
>>> +++ b/drivers/ufs/ufs-uclass.c
>>> @@ -1854,9 +1854,9 @@ enum ufs_ref_clk_freq
>>> ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct
>>>    }
>>>      static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
>>>    {
>>> -    int err;
>>> +    int err = 0;
>>>        struct clk *ref_clk;
>>>        u32 host_ref_clk_freq;
>>>        u32 dev_ref_clk_freq;
>> There is another weird piece in this function, look at this:
>>
>> ""
>> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
>> index 3c8e4299259..da46b3ebdfd 100644
>> --- a/drivers/ufs/ufs-uclass.c
>> +++ b/drivers/ufs/ufs-uclass.c
>> @@ -1868,12 +1868,11 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba
>> *hba)
>>          }
>>
>>          host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
>> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
>> +       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL) {
>>                  dev_err(hba->dev,
>>                          "invalid ref_clk setting = %ld\n",
>> clk_get_rate(ref_clk));
>> -
>> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
>> -               goto out;
>> +               return -EINVAL; // I think we want to bail with error ?
> 
> I don't think we need to error out here, Qualcomm platforms don't have
> this ref clk wired up properly yet but somehow things are working ok.>
> +       }
This will print a warning. If on qualcomm platforms the UFS is working 
and these clock are not needed, then this should be fixed, likely by 
making the clock optional, or using fixed-clock in DT ?
