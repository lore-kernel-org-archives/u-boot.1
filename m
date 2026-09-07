Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58363C79FA0
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 19:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0468B40515;
	Mon,  7 Sep 2026 19:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYkqMcEYaOuk; Mon,  7 Sep 2026 19:36:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 130AB40505
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788809807;
	b=mEno2jXtv+HNW3JmdpBIymFUCQIcFN9gH0w/mh0T9i82oGye/ZKl1Z8K4TLn6cmf/+0W
	 hdxkCLKSSlME7bay7n2fxZnIm2R3QZRgzAC2VsOs+6MTIrKGFPIIX2qFpx//BwdZicylg
	 aVP1EJRR9GVHpkLzH26ZlqxEaLwlS2VgFObJmfV6J3iShgvQwRNOeMAbWU3CZdLiMLs9e
	 z6v/t65xRjghVzhXNWex5+bu0wBb99RAbn0Qf5P9PaOYrWoAcAjh+pcDsG8e8Qdj851RJ
	 w1vp3ktDyukg3vQQTaMO/03K4MBsFwqFxQeeh+sQ54p7yRwd9+zQyqj9FoRQ3REoQmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788809807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ezfM1FPGrCHXuDc7Hy/8b3WkGRZiKP25wygQAECxCpc=;
	b=MdGryfwGj+VmwEnYzBZHUj3fcIeGNR5TCRxIwqVm3b8hBezmds9ui5Di/KM7vN3eINyb
	 55mJuu/QOCa5ykhrSVv9tI7I3qBhpKO1wdw34TwyhgLxR0zXmLLwKLvvup9yVmuuIlrNB
	 7KvSYS3ad9bC7Eek82nYZRBTSAkxt5Wecp9y+K5dJ7IzHVeQWUZtZLLNz0s6ZBoxgTv/c
	 D3f4sRYIG6GfBXBTeiuZAadMsdJpoCfI+GcEsDIGbq17bHtozz+U6+dlL5v5Maczc/Ikc
	 QiU1D5rEQ8fmf15XO4wLb/DaSCAtrzTLBQ6/+WuFxq7IIfvpfDpVWy3E1VzRD5eGFHw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gvGLwoAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788809807;
	bh=ezfM1FPGrCHXuDc7Hy/8b3WkGRZiKP25wygQAECxCpc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aNY3sxoIpna/GhbRDJt0JeySjElt22oWoYXOX5HHPTJKXeSs5kNOtR/NOznUJcBNh
	 EPJlTtd2MwH1RfRLU7RhVDWSfsMhJdR9Ab7Pl1by8aeQT6oM/HVCThKgNGi8fDW7NO
	 vICH+wJGZEtWW1yUXjKRUU9rRJodYnkGgqG/Yw83hfSH1g03GZjOi1yW80iKMtlLFM
	 /pZTiLU7AjI/tfxt7haIRDvpN4EZxmdqj/tVfoBUs/LqEvgYRuAeeoCQ2gcH0BlViB
	 37tJs1tOVTqj0ub/LBZ+vUbMtpQvJGg9oGpWy+SfyoPNUmkhyEk5PBO76cALnVGOpo
	 NOBuwCkTsP2pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 130AB40505;
	Mon,  7 Sep 2026 19:36:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EB7C9CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7C5A040411
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sjdRDi6yObzV for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 18:45:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6CA454040B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788806700;
 b=kNnushPUlkNn4yvkpmSeuXwluGBxwkoc4pYzsDJkTc+zuf8GApwWiUNsOTHZLRGvWw4/
 p/NZep/8m9Y/fB/+7HdMuykencTgjWS7iUIpmlwrwZzvD+sW3NB5NB/E9f2D3AGdbO69j
 6fwlZi5c7zbPDD4ldlsRkd8aRwWf5VMEuBBqKodqKcejZ86W53twigBq1RiucN5Qlqler
 9h05OQBeBpSLlb6wwXFOslMBOacmLw0bhYR+DSJ8PSeFRYFeB9isoqL0asitNHOvHneXM
 viH1fg3M55hAuh8Wm+TxjYSu812PfiOTZ06qyzAcnsl6YuHYBjU1A+qKtJ+JB4XmjmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788806700;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=ezfM1FPGrCHXuDc7Hy/8b3WkGRZiKP25wygQAECxCpc=;
 b=am2JinKIBb43cZLa17DsuxDJdZaY7etZ/Uuk2KI+rQMv7MQ90GhIiz/+kdiYdEF0RVc+
 dC7Wncbg6T1DuGvhJC9jN0+2cQLVHq35Xp+sD7i8q9Z3CnTxJzt43ajt6OZYYPnsKT0g9
 308rq5ArmunPw5otf7HofSeGjs/ujZtgq3LXcJoX4FiUmy8iaveL2IdG3sJvokoz1E6um
 s/F6YEy14wpPg5Fvnv+mHKLcTwqm86zOvA0nBy9k+x3LezKCqLZCLRs1hQdneYo0DUqJM
 NQwoVpRTB3qqp3awZxd8Wdbt8t1AH5tTrdiCTMDS3acLMdSZWc8ZLPJMU5DkZxfw0ew==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=gvGLwoAU; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=gvGLwoAU
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CA454040B
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 18:44:59 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so194352f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788806698; x=1789411498;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ezfM1FPGrCHXuDc7Hy/8b3WkGRZiKP25wygQAECxCpc=;
 b=gvGLwoAUBjcJjrPtgatT9ocAYRtv8m6JwyaxffyLVhTDivioSiGZxEgetTbs9/hprM
 B8/hDWZeMy6q8k5GUdOnDaZ9LuxhvovBea8f2MXU/hRA80ZtOw+9FToUa2+c8nMtyp/S
 rDXPpXgRjCXZ0K86HsFzi8YPELCZmk0NdWJxJhWOR75PSsDrq4y3N9RnxOJxwPJ79XFD
 CThu5ll+aJn7wicQdBtJqYXZxqiHG262zrInNaNPsaVDtFSfhCaI8k2PIMaX1JVgXyRC
 oVEvv33SKM3xbYTC04efMMmwKirow9f4/uVMAoEo76LSliVcdHOcQkzgyUQumiLmIx7t
 t8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788806698; x=1789411498;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ezfM1FPGrCHXuDc7Hy/8b3WkGRZiKP25wygQAECxCpc=;
 b=bO9V6hlJJDDV7CfK1Y01jufbGPDXt2z6t703vhQRaPGHAUwj8VbMny1aytwdIpwBDj
 l2i87X9IbOXw0JNoaZlNMUtC7AsebpvNOVtfLLMVgH+UZAh+nzZO6rcrxlu9yGW2ooRE
 wkQxzm+43Nsg9Nnq3XCXGTjMFJlK/bCDf225B/rqM9+JmGLwVb/5SXK+rMBOnOu3tY5v
 0bdey7vehusubVE22T3TVT0OVk2baCqBTIhyqjIaJ817JHRZWD0d+hGXB1dMbZw9G/2r
 n+bHI6GzkqBcq31s1a1jUA9CPh0fMiXW5WG72LUc9LAHM197R0jYizh6IWOvuwP0UZiW
 r4fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByG4P5nVGy6YUNWjOH3mLukiZH6aGfpyX629vEbPM4w9/5KtogcxPpzFKHcqa8hNOtWvEuS0f8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lyR3DfrVzFBaK5zoBI4gUtgTDMz8LvQxCC7eZ/ORHqbzFhLKUL
 TRNtWL3qpPARiuYsghxS+0zj3aWBgzfrlQ3a3bOVy/kYHIrqTt1KpADb
X-Gm-Gg: AYBFou2bNric564vL5g5zuLD+gwlOUymzuIN1zdFlifPWcmbvQ6w0XxekXnTDo/KRtK
 4MYTT6wz1Lb9Hxdv3qqygUIHTDX4gDGJVUubAI0fZ5HXNBPQBLkQ3KTBb0JDS51/cBLVdtEhoog
 4Uq4AJProuC962ZSlM2FRWDr3e0z+Zif+HGR0m/NUua1Z7Ia55vW4QXzcSPtCcIBUACdA4x+gGJ
 BP4/FwBpF7Ry6eyRKGwE7D0XW48t26WDTypMBQP2khgaeAcRUeikDw0AEHru6+2wPtmcPrXHVZ8
 pNjeAmOt/nMdhjsPI8GX/cCPJkqiaB2o5CBK6FjN4dOrI7rm0jaB0uOInFKTrA0chn1QECOurMJ
 UR/SInptNV2Ke95UJZBajPw+E9cYfJp/4m6b8Daky0VXaQLiCNrBsZQqWMN1ow8JaLT/sC9Ih1U
 OEx/CUCmbQdJsAsKzAisVQxBzErOjprqaE05rL4DPUx1aZ8+BGzLf4XQ9Tt9tDtHu00hTjpuL3f
 VpM8qqgWkDM7U0Y8gLxAkrMR6srcIfmHKCHscwqpY1yEPfeArImCWDeKNnRNMkRfs7iF4kIQV61
 usrrdMSdTc2JNVSBckJposOFr3rGY1uWGBRYDG7LQZXIbYKUAqdT+SEKga62FLpA7iX4
X-Received: by 2002:a05:6000:4543:b0:484:3311:2579 with SMTP id
 ffacd0b85a97d-485a241838dmr2552440f8f.13.1788806697515; 
 Mon, 07 Sep 2026 11:44:57 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:d844:e1bb:e288:3473?
 (2a02-8388-e6ca-5780-d844-e1bb-e288-3473.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:d844:e1bb:e288:3473])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm29241244f8f.3.2026.09.07.11.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 11:44:57 -0700 (PDT)
Message-ID: <f26f9e30-2f18-46aa-9d02-58933dd1ebc2@gmail.com>
Date: Mon, 7 Sep 2026 20:44:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: cv1800b_sdhci: configure SDHCI PHY
To: Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Hiago De Franco <hfranco@baylibre.com>
References: <20260907-milkv-duo-sdhci-configure-v1-1-606b59eaafa0@gmail.com>
 <ap79pdnPCUfaG5gE@pie>
Content-Language: en-GB
From: Andrei Lalaev <andrey.lalaev@gmail.com>
In-Reply-To: <ap79pdnPCUfaG5gE@pie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 19:36:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Yao,

On 07.09.26 20:08, Yao Zi wrote:
> On Mon, Sep 07, 2026 at 04:54:35PM +0200, Andrei Lalaev wrote:
>> Some samples of the Milk-V Duo and Duo 256M have issues with SD card
>> communication. As a result, the SD card is not detected, or the correct
>> mode is not selected.
>>
>> Configure SDHCI PHY in the same way as in downstream, to ensure
>> that the PHY is initialized properly.
>>
>> Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
>> Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
>> Link: https://lore.kernel.org/u-boot/20260822091510.3253162-1-andrey.lalaev@gmail.com/
>> ---
>>  drivers/mmc/cv1800b_sdhci.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
>> index b756649f90f3..5c129682daba 100644
>> --- a/drivers/mmc/cv1800b_sdhci.c
>> +++ b/drivers/mmc/cv1800b_sdhci.c
>> @@ -8,11 +8,17 @@
>>  #include <sdhci.h>
>>  #include <linux/delay.h>
>>  
>> +#define CV18XX_SDHCI_MSHC_CTRL  0x200
>> +#define CV18XX_SDHCI_PHY_CONFIG 0x24c
>>  #define SDHCI_PHY_TX_RX_DLY  0x240
>>  #define MMC_MAX_CLOCK        375000000
>>  #define TUNE_MAX_PHCODE      128
>>  
>>  #define PHY_TX_SRC_INVERT  BIT(8)
>> +#define PHY_RX_SRC_INVERT  BIT(24)
>> +
>> +#define CV18XX_LATANCY_1T BIT(1)
>> +#define CV18XX_PHY_TX_BPS BIT(0)
>>  
>>  struct cv1800b_sdhci_plat {
>>  	struct mmc_config cfg;
>> @@ -64,10 +70,29 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
>>  }
>>  #endif
>>  
>> +static int cv1800b_deferred_probe(struct sdhci_host *host)
>> +{
>> +	u32 val;
>> +
>> +	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
>> +	val |= CV18XX_LATANCY_1T;
>> +	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
>> +
>> +	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
>> +	val |= CV18XX_PHY_TX_BPS;
>> +	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
>> +
>> +	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
>> +	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
>> +
>> +	return 0;
>> +}
>> +
>>  const struct sdhci_ops cv1800b_sdhci_sd_ops = {
>>  #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>>  	.platform_execute_tuning = cv1800b_execute_tuning,
>>  #endif
>> +	.deferred_probe = cv1800b_deferred_probe,
> 
> Is there a reason to create a new function, instead of including the
> logic somewhere already existing, for example, cv1800b_sdhci_reset()?
> It seems to fit in cv1800b_sdhci_reset(), too, if it's for
> initialization of the PHY.


No, there is no particular reason. I simply didn't think about cv1800b_sdhci_reset (:

Thank you for the hint! I'll check it and will probably move it to reset.


-- 
Best regards,
Andrei Lalaev
