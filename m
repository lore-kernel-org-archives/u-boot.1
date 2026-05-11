Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0ECCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E00D480F0E;
	Mon, 11 May 2026 14:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A6KDgxCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2607E83A41; Mon, 11 May 2026 14:22:26 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4453838BB
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bcc2b199c17so239627766b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778502142; x=1779106942; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jY1M8WKDcw8mZuZvwQfvaxvrMAT/+mynfzrdxfy7Tho=;
 b=A6KDgxCfRFJfQNXInGmn3B7TJZRNknRs+q+w7Q6YuoV/iusf6ipKpPBqsDlkRFKarJ
 Q42MTmhh8vTBOv2ZwCimyitu356e64mdRD0BaLCGNp8kwEOzRciCw5zOfBegc4ZEr9ja
 2O2h4137fp8F3RIszQxptysa8j4I2wsk03krB/bQwsFLafohiuvC3oXDC2/Gi3JnxRmN
 cywMkiJjfN4lgQrT1feasVZLwpa2fZ0zbvMiqXJctfI628Q11QpV801CrUVrt1/8tmkT
 0HRwl1UXhCbPl5UHgTtgZ5NvcCOryL9uOlIXObilUfp0Ik1ElHVV2qALsxG0o3/JAt10
 Ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778502142; x=1779106942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jY1M8WKDcw8mZuZvwQfvaxvrMAT/+mynfzrdxfy7Tho=;
 b=aI6diVj66NChOTapsWCzdaT8UWHJR0THXZZAw7XTOFz9MVH2kOZpMYxJYR1jPpiZGx
 olY7WLzbr+Oi88LBAPGZaTm2blij5eyTqDorUkvzVa/hcxrvqYIBcLXFFgZkYNUrpevK
 WZxMgG0dbtknjrBwdkFeFrzl8ZiK2diUjm9RK1RhrrOjot/XVN/+tmifQL7JCiPjOV6g
 uejUcsCnA6YR7NkKRbP+zs7Zgb8yaT1hBqbaQm48oZmwLEIMmdNRXvQ/KC3DV/XW1LzO
 WGhM7+0Fitf9w44BEdK61FPJwll/SrDRR56MQtm8jqhLc2kOrAMeCQYny/nPDNYrhh1z
 NBEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mi4ymuGJLzuir2qe/D9yR89Y6pYbSg5Rp06xeDFnRGA/H8tWSPkuSQ7fIvr9SZipizrzXOho=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5Eucgd50egwpBgmQ0SmSd029fmD3GkXGHJF1Ls2jNwMvhzBMz
 nM+E6HJrDgmEaVJAZODIAHacawAM18gpr+Zd0596xhHR5IArOpMIhNxwx7ADiTc6FB4=
X-Gm-Gg: Acq92OGSDpjhXe7MC/WSMjrG41gGMMlYSH+tDWL12vIcU8uljjwY8R49ORfROdhbqap
 lML2Ji16OHnBvzpJC7eHhmrmcqY2T3uA68+1k3HpD26bH0FRNc2c96hkNSoQFCZAgqM5HXbxb1x
 hhLwl10i+wggZHGfq61+mPStrVuPLAik7pa27R4tbCWQodUGZC4NP/dt0Jf1S1D513xiN+5+WjN
 lgKtogNnaUWijuoovOx4RsIRnU7XZOn2Qbjwl34ZDgecgpLQ/xJej05PuNfKdssNpcviWUB+Cyp
 h7WugtTlkjZU5libh1cbyqMRzp9IF7ihajbkH/kGeJzy8hpwJlzcYeGwAcLITuOvTydOuT4lR45
 2L12ahKXPeCr/S0mBx8qh2Z+lmWgpuCnbDTWZhi8CvsYPKIrl2kz2bd03NzFnlEPhJwxeFvKTcV
 UoEITjbRf8qJRzseuBMwyq9R1EyN325U+7KQtvt/D5tJPl7Pg6+bAWx8UvLKFPeqmlAZd50BwGl
 vTH
X-Received: by 2002:a17:907:c30e:b0:bcb:9a37:f00a with SMTP id
 a640c23a62f3a-bcb9a37f0a7mr627691466b.19.1778502141898; 
 Mon, 11 May 2026 05:22:21 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bce4c41b1e8sm231470066b.8.2026.05.11.05.22.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 05:22:21 -0700 (PDT)
Message-ID: <e9d0eb88-4568-4a65-be10-a1b2834523af@linaro.org>
Date: Mon, 11 May 2026 14:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/15] soc: qcom: smem: adjust for U-Boot
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
 <20260504-b4-modernise-smem-v2-8-c01ec2ff3886@linaro.org>
 <6ce5b9ab-d6b3-47d2-81f9-56b4ee1edc67@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <6ce5b9ab-d6b3-47d2-81f9-56b4ee1edc67@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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



On 08/05/2026 12:43, Aswin Murugan wrote:
> Hi Casey,
> 
> On 5/5/2026 12:27 AM, Casey Connolly wrote:
>> Port over the smem code to U-Boot and ensure the smem region gets mapped
>> after dcache is enabled.
>>
>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>> ---
>>   drivers/soc/qcom/smem.c | 399 ++++++++++++
>> +-----------------------------------
>>   include/soc/qcom/smem.h |   9 +-
>>   2 files changed, 104 insertions(+), 304 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>> index 7143856e85c3..96288d7bcdef 100644
>> --- a/drivers/soc/qcom/smem.c
>> +++ b/drivers/soc/qcom/smem.c
[...]
>> @@ -1058,153 +962,100 @@ static int qcom_smem_map_toc(struct qcom_smem
>> *smem, struct smem_region *region)
>>   {
>>       u32 ptable_start;
>>         /* map starting 4K for smem header */
>> -    region->virt_base = devm_ioremap_wc(smem->dev, region->aux_base,
>> SZ_4K);
>> +    region->virt_base = (void *)region->aux_base;
>>       ptable_start = region->aux_base + region->size - SZ_4K;
>>       /* map last 4k for toc */
>> -    smem->ptable = devm_ioremap_wc(smem->dev, ptable_start, SZ_4K);
>> +    smem->ptable = (struct smem_ptable *)(u64)ptable_start;
>>         if (!region->virt_base || !smem->ptable)
>>           return -ENOMEM;
>>   +    if (dcache_status())
>> +        mmu_map_region(region->aux_base, region->size, false);
>> +
> dcache_status() can return true before the MMU and page tables are
> initialized, which makes calling mmu_map_region() unsafe at this point.
> Since the intent here is to check whether MMU operations are safe,
> this should use mmu_status(), which correctly reflects MMU readiness.

ah good point, thanks! I'll fix that in v3.
-- 
// Casey (she/her)

