Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D132C79FAA
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 20:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 238C480C7B;
	Tue,  8 Sep 2026 20:58:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWtEAAF2idUX; Tue,  8 Sep 2026 20:58:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 23BFB80C64
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788901138;
	b=aDYvsnFjAi22NdM8x1nYHz+aeYzA92DmUPP17CGLHs3+AgFAMGgEUCGdqm38vTkThSiq
	 j6apeamC6jgmxLzllBN6y4V9EiOiVXBjrjKE/afrAifQDf7Jkr7YBeJ8mEeQCQF99QW5Z
	 14g0DAD72fp+Sd0gh0OVMAVEi6nH5SCWjP9SVe37H0t8+HW5VhzkW0zGeA3k+Y/h32uPZ
	 rp11Wz54zWvHKplj4+EhYC2x9yoiMlRr7H1tvuQ7uxWt+unagiTw6rHn+pQ1FtLmekkk7
	 hc2K0BUmJ/6vS+R3ucx03fBpIxt+GxQiK/TDX3uQempl3uYGk+5EuNvVhD1nU8cWfWw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788901138;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cm9dEe1g1wSq4KFoX71tDfCNlhLjlr2HL5fssojRxJA=;
	b=SOCN8Nu+GcWg3U8HtkX2+rHWcIgHt0ve/PQVWzhkmo+N9xay105wndCSU8ct/errVxrg
	 YQEaDoTXv/w97wcm3CWh/ptcMNM/FtJ90HDFvq4jzqau/GSfKbR+CFLQa1QhjTHiOoDC/
	 y4gVk5DcnwZQ0oUt1s1l1hKQN7i1ftnjCVz3DI2oFtZbu2GkF0Fr0QdA05QPGmLQgNRV+
	 hLl4Fi1jQeAkbf+X3LfIswTYf6xn3UOEhGJ0VfMef+jOo3K9TecIeQmBEYiIIN4Io61fM
	 RvBPVSRoDeQUXnDXKQ8jxkm5M8Z/n0esvFU7vUKd61EfS0trKy5bkKNK/L0rUSJTnyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788901138;
	bh=cm9dEe1g1wSq4KFoX71tDfCNlhLjlr2HL5fssojRxJA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=krO4SYPLHcahvkiihVvoc1tT+wkqi8wwXw/SSUAdYPnE5fAxx248IO++jsfzHQ3mt
	 lNKfoq/zuAzbQl50ja9FyRz6avVyMsj6j84hmgK3an4K84hRbxh756wL54of8zBMCG
	 A3A5DXX9ceKMPrEren7+VXkxQNGIdqnwomLurp57gIul56dLbRgntMwX4ww78paohB
	 6TsPf/504pHGb0eB/Q8LjeYfsTt/9WFM57pAc8N2iFuse5wr0GuJGsR3p+IU18ssch
	 D7C1hrDy3m7IEBZu0Hzv610ERMg2dSnaGDX6kcO1dcEQM02dxHQx/9Go5FHWWVcHr9
	 2IRG7sYtORypA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23BFB80C64;
	Tue,  8 Sep 2026 20:58:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C8AD990
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8258E4016A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:27:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uu8GQXa4_ptY for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 15:27:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 38B6140079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788881269;
 b=IkCWznFWF16Xz4CC6mrOe0PhhUo9mg1Rx97j5NbblwdDxKVELYJ4LIxxRAWoNWRbWHt3
 IOCwtP8ToEC/SmFlZ//by+Rwh1JKEA2YJXRnVo2HziOQ7YKrIdQvyeBlUrttLKvbT7xby
 5V1jwx2JpcdTzOaLBIGfIg7BYZkwI/YNeWG61ewvudu0yXdKz1o6CtBQsaNizxuGsgjaL
 DG9+jJMK0BPdeKrxcgxmv/Gztrkjt6cbBnW/0DjFSrXdyzRjrGLHh4IakDZcYWfDmKeSi
 cVHPt0BM5TsgJz/g4n2Wwil4hyDVW/4CKcz09WB359WWfoI8wCAlsKmIj60vK4a53Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788881269;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=cm9dEe1g1wSq4KFoX71tDfCNlhLjlr2HL5fssojRxJA=;
 b=ARavGpq4X72inPGRmnjSFUOUT7gt+hwBRpr/EdnlJ45khxFFOqtUPRUJDUAUnWMenldQ
 yGtTKdSyyhx74jv+6iZ42a/Q8XmITLCgsL4drrUDM65/yU2iobaNs0qqGY5tcy5/s/PQB
 BcU9Q77Vb+JueBDbqKeXePRMvMb4dLuoemuajsPTwmb6wcv+P3Uwdi97X4q3Q01xhbHnx
 e+WeTAmmXmIJPudqDBMnoMOJ6fv2DBa07xDE5a2ww00ykQAdGJJtTWTtSVjXQhOjVqiAs
 8XCryrpdM9CwFkKoBnYU2zSIRxmXe7lH/36Jq8lOd6AJ1XEJGzfqibmWdZPISRVcIYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Twzot68p; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Twzot68p
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38B6140079
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 15:27:48 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so47919095e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788881267; x=1789486067;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cm9dEe1g1wSq4KFoX71tDfCNlhLjlr2HL5fssojRxJA=;
 b=Twzot68pZB0igUWHk/mWDhlWVXfMET5t/bHZitufNzytLG2ZqKBMzPyzwQTj7NRc9W
 wjSBEc6NfxkBVCLMJn5JjNoUVfwcobrX4f2vrbwJtHCCP8TXC0bWBpgR7uXG6vPtSl8h
 S3BXb/JsF9FM3Y7Ka3d718Oc+Onsd3cVjWJHquDOZxbdZkDGU0YCpIirKLHVbLqwaXVs
 ggVrG4mH750cOzzFjuCqtiBLWmRWpuZOc1yAWuw1y6UqQXyRPuNcUe9BCvKIgcCo0+yC
 BYHC5eDv6jtHi5XFPAvE/eE9gepyDQGoqQTIG7TMutD1za0cMwntq/VL0NTepakTU+RF
 QSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788881267; x=1789486067;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cm9dEe1g1wSq4KFoX71tDfCNlhLjlr2HL5fssojRxJA=;
 b=H1JmcGtOhxwaIloRBLpcCcVQ37QypuVu2sxL9wIHLhCPobSOtuXrMPCxWE/bsMiSod
 mYH8AbJhn2Kbjc1uKO/9VgNGTK0PVN7YeHJKzhtVYABTFTefqDIWyOAjHX6VVWC66CBU
 EKA06k5IJHFpxVGw5zEElnJkgD3+RfWs+Ntpwn09CsAYZEFvjeE5VD7YWpRwOxVHrDPT
 57LGqgYW3GpduJybOutPUIAxgKFA9qdzHHfBRZkyy9zIQ/+thApYdMPXkttGFbIwef/s
 P7wjW1PhfnkUK3CCPfV803JNPf8k9B4k521rjtcozgmINuorkaLUXo1h1/eiUBIxM9YD
 zYjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiBaV+9gPg5x4T+ELu0kClH2nTnQkrqZG836sNlGFE8AJyr4SbRw+WIgWpqTFJfaiIomTCuXI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kDRA5qqwD3aDaJQLaEoywizepLYQcIWfc8bwK4D41MyvN2fuVs
 EKYZTV2SiAU+bjEUulnUbdzfI5fgAo+LzGEi0KPWwp/CDWkCe1WOz1P0
X-Gm-Gg: AYBFou1RRZoMu51xsKxm2An0G2e0NRKYlkTBvucgLFAzjBfEfl+3Q1+yq/eBjESSrh9
 ssp2l2aHwsSSC6yLM/BXP99chhdK5uDNB148e6tRD/4lFGD9LwQvTfiu2e+sJxaimVeA8nkqAFN
 I0YHNs94RQwNSMa6xqLQhFNheE3UMROAObKi7X9HKkstQr4QlgWB+5DFzBCDlmaIE/J+w58qRPt
 naK91qvhv01wbA009iDk2ndVaquL8cbwwX+Y5LScwpk/AE6ik6PG5nGOi5oGYqY14iK1Cebkanh
 /Qb5jtfrAlt4Dw+LAf0Co0EhYEj58zTH5xN4QU+lTtEhSkpOrGucyFqTXYTxbHXvPBPzrhbwAGL
 p1f1DIwHTg1Y57lNBCAQxcDobFPrb9EaSlWzL5WJ7yiG6ZuwKZTYa6ktLOIAhawDMrJ1maZPawm
 vkfUscd7q6wjYW/xBgbiwZLmtjFSRTLNdrl5xL7L/UkEnnkEZZAZodVM7EYvwlMsA3sL0n9pKlq
 4RaS/cKgKkkkMqIO/pUWQdw/qSczJFeZDIoX+hiY8b0KZFUhyXOzG+dHsD1u814pfHqPEexuF5r
 FBSgEMKMyhRg9docRTzLTAJqFpSkBMXdWTfWev9ntH/AnGx44dNZaOo9zr3gE58Sa6uV
X-Received: by 2002:a05:600c:4e16:b0:49c:fc6c:bdfc with SMTP id
 5b1f17b1804b1-49cfc6cc01bmr255873325e9.19.1788881265959; 
 Tue, 08 Sep 2026 08:27:45 -0700 (PDT)
Received: from ?IPV6:2a02:8388:e6ca:5780:d844:e1bb:e288:3473?
 (2a02-8388-e6ca-5780-d844-e1bb-e288-3473.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:d844:e1bb:e288:3473])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6023edsm465274465e9.7.2026.09.08.08.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 08:27:45 -0700 (PDT)
Message-ID: <0b3c324e-b1fe-4c87-a89c-887f6306def6@gmail.com>
Date: Tue, 8 Sep 2026 17:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: cv1800b_sdhci: configure SDHCI PHY
From: Andrei Lalaev <andrey.lalaev@gmail.com>
To: Yao Zi <me@ziyao.cc>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Hiago De Franco <hfranco@baylibre.com>
References: <20260907-milkv-duo-sdhci-configure-v1-1-606b59eaafa0@gmail.com>
 <ap79pdnPCUfaG5gE@pie> <f26f9e30-2f18-46aa-9d02-58933dd1ebc2@gmail.com>
Content-Language: en-GB
In-Reply-To: <f26f9e30-2f18-46aa-9d02-58933dd1ebc2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 20:58:57 +0000
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

On 07.09.26 20:44, Andrei Lalaev wrote:
> Hi Yao,
> 
> On 07.09.26 20:08, Yao Zi wrote:
>> On Mon, Sep 07, 2026 at 04:54:35PM +0200, Andrei Lalaev wrote:
>>> Some samples of the Milk-V Duo and Duo 256M have issues with SD card
>>> communication. As a result, the SD card is not detected, or the correct
>>> mode is not selected.
>>>
>>> Configure SDHCI PHY in the same way as in downstream, to ensure
>>> that the PHY is initialized properly.
>>>
>>> Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
>>> Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
>>> Link: https://lore.kernel.org/u-boot/20260822091510.3253162-1-andrey.lalaev@gmail.com/
>>> ---
>>>  drivers/mmc/cv1800b_sdhci.c | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
>>> index b756649f90f3..5c129682daba 100644
>>> --- a/drivers/mmc/cv1800b_sdhci.c
>>> +++ b/drivers/mmc/cv1800b_sdhci.c
>>> @@ -8,11 +8,17 @@
>>>  #include <sdhci.h>
>>>  #include <linux/delay.h>
>>>  
>>> +#define CV18XX_SDHCI_MSHC_CTRL  0x200
>>> +#define CV18XX_SDHCI_PHY_CONFIG 0x24c
>>>  #define SDHCI_PHY_TX_RX_DLY  0x240
>>>  #define MMC_MAX_CLOCK        375000000
>>>  #define TUNE_MAX_PHCODE      128
>>>  
>>>  #define PHY_TX_SRC_INVERT  BIT(8)
>>> +#define PHY_RX_SRC_INVERT  BIT(24)
>>> +
>>> +#define CV18XX_LATANCY_1T BIT(1)
>>> +#define CV18XX_PHY_TX_BPS BIT(0)
>>>  
>>>  struct cv1800b_sdhci_plat {
>>>  	struct mmc_config cfg;
>>> @@ -64,10 +70,29 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
>>>  }
>>>  #endif
>>>  
>>> +static int cv1800b_deferred_probe(struct sdhci_host *host)
>>> +{
>>> +	u32 val;
>>> +
>>> +	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
>>> +	val |= CV18XX_LATANCY_1T;
>>> +	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
>>> +
>>> +	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
>>> +	val |= CV18XX_PHY_TX_BPS;
>>> +	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
>>> +
>>> +	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
>>> +	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  const struct sdhci_ops cv1800b_sdhci_sd_ops = {
>>>  #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
>>>  	.platform_execute_tuning = cv1800b_execute_tuning,
>>>  #endif
>>> +	.deferred_probe = cv1800b_deferred_probe,
>>
>> Is there a reason to create a new function, instead of including the
>> logic somewhere already existing, for example, cv1800b_sdhci_reset()?
>> It seems to fit in cv1800b_sdhci_reset(), too, if it's for
>> initialization of the PHY.
> 
> 
> No, there is no particular reason. I simply didn't think about cv1800b_sdhci_reset (:
> 
> Thank you for the hint! I'll check it and will probably move it to reset.
> 
> 

I've rechecked, and unfortunately, moving it to cv1800b_sdhci_reset() is not
an option because reset is called only from cv1800b_execute_tuning() and
not accessible to SDHCI core (unlike in Linux MMC subsystem).

So I think I'll just drop deferred_probe() (wasn't actually required)
and call the function directly from probe().


-- 
Best regards,
Andrei Lalaev
