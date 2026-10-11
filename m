Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB19CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 04:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7763560720;
	Sun, 11 Oct 2026 04:53:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iiXReBNDbVp0; Sun, 11 Oct 2026 04:53:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7B9560690
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791694402;
	b=U63AC6GHKYFwtcgDRINrLwQVMPDdfm6KQh5LfRQAugCKSL01QgvO0My82+TwQqhXkYtx
	 yEAfMkNWhbEvr63UrpD9Z04HtUhxYP93ScGpu8CtUYlaX+diZsOZMPzdAVfLQLO/py2G9
	 dZ4I738op67Ku8bfnZWUKz2/Sumu/ENYdlcqtQxVqy/oZ2wtFqC1WFmfpSWg3pV0K5fS1
	 pAnw5V1d+7Cw7FwYOuBRTVLFmaafEHzYYSBXqUxuAyjePS/L/Onoycu6m6sCiKWDktfuf
	 NpvCdte0QXDVl1lEIU1ksO2f74Z2K/Q411d1sgzbDGZTCMlFGaWHIcm2SG0NEc3aREg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791694402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2xU70uIEXKYtl5UGvwhpB/mVljXXIrH3cu1cQ0TusdY=;
	b=KIzLe1XPlLHHYS+HYVhRtQAno8q2eS3bhlQyFHHhZwJu7x/HH8GSnR1wsRnTlXMRNJNG
	 tiHpswasZhc89GtegAHbzB2Q+xWkK7FEUvDuATElSKLkp2bLr6PPtpoSxRf7OLIvyjDf+
	 LMXzYF1qMDo61sRgbaDioLZImZTf27g2dsXkeiA07dYALICWvb9VtgTMX2UAmukeaPQxY
	 1gFYTuG/2WR493zS+gVMKC9040xhFv5oUqzBTu4SiImW908hwVEv18kdclVMQzXWxZA8O
	 3pgWl4YKKgI36/JYvlb/o5iM4DXgH9stcGg8SM9C59wGzAGcqy90lbc3DvMkxedqijg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791694402;
	bh=2xU70uIEXKYtl5UGvwhpB/mVljXXIrH3cu1cQ0TusdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OUiKwyhQN+sqwQc2C1olY4RumMayR/WPMWeVpqJgYimaeTkaWYbxRGVCsOKacF8D2
	 xR2Nol4O44ESjbL4Kar4o5ZNwTC8vEI5Y4daEAfwskiG66hHT/ghv6mSzzbyJ6lAvk
	 0dsUpffIS5jK4cYNCEU0tinLTzaHz7zvaXsGuFyQ8Y0Ea7+z4lCzCV2SRntSOfpZZo
	 axA+XB4BUMt2llMiSAdpTuUXerdQYNVvSKZqXr0hgtNg7mtyqKw+83Po4caKyGqVgS
	 YJTXAI8unBIogEUPRbL2zVl1GQ/I3CPF0KJopr/K/X7fC/rF3mz2jYXx1o5+GVd/jm
	 miqsLKar3xfWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7B9560690;
	Sun, 11 Oct 2026 04:53:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 40E6622B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 03:38:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E79C140042
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 03:38:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wt1BO188ooHS for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 03:38:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7A97F4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791689907;
 b=Rpeb/FuIp5DHbL6Ib37YCj0IzbhCVS7zUAjhCPmJ/sPPpMXripQrCOzSk8IvQHD+GVLn
 twRQQtd5lkntEAiu62ohR+8wR+eAI0vCwQCUAdSecsQgLaPrhyWjZ5udJs1f9FLyxozNJ
 2WattptECVMDjRV+N3mHcYtA5Uj/hy/055bFljCYzjWzWaiarAI7dsVsMbcmkQPkayNO+
 8eg6DN8fbsI/TnQztkJTsiLtxUhiHO/ZahRBzvKhwup5Od4NiLQB1DJwOvyP6/m5Cl4cE
 w4UgS08cWmPQQUlK4tbQL3Q3TVEWk8m4jlhuw9gnazY34Bdkt6Iop3NSPlVfPqfQaXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791689907;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=2xU70uIEXKYtl5UGvwhpB/mVljXXIrH3cu1cQ0TusdY=;
 b=H/TucIUAHBky2F0D78UK7ntkJ15DYUX20ji0Ul5jwDYOe/C1Unbpr9DcOPx+37mnvk5/
 CImQM7JRwQdchJqa0mgMzDu/77c0mgunsUBeAvEQxpZ0+pzMdFKinhIsyNbvuaw0qBw8n
 xofJ8ke20TJb7ZpR7VwAMM8ndbIi/FZeyIHb7g0QWqM0XHt3EXO3xxYrD7kiZZRKShc/i
 UKkqvFQGiBvR7jSLj6jL9VezTHmzOVqF2k7rCS6kYi7YIMILWoyFzxzd71f1eXizkaU0z
 9yG7AOcjGCwdzVauOUNSEvYE5Gd/geH6RorsFqS5LCyJ70Hq0Tl+GScZh2hChkHAaWQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=NxRyVJOK; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=NxRyVJOK
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7A97F4002B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 03:38:26 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-85377c8bc96so299308b3a.3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 20:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791689906; x=1792294706;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2xU70uIEXKYtl5UGvwhpB/mVljXXIrH3cu1cQ0TusdY=;
 b=NxRyVJOKuzcs1ygb5KZHvxfcTCCsONnL9i5rjKfEliMVlMWSL9V6EjpqwgfBUy+Lve
 nNp3Pn+QH09yGg/aaUMSQuXA9YnnLMdb6RomI+H0dNHXSlaL4M0PNrXUfw75HGYTWbx1
 AJuBALwnq896IQiqy7hbZAKg0iATfl4xq1h9tKdkDLVRbEq1RGeBgp72JzpIr5IAsVao
 GZTpbbQ4+fq5A1dSxRnUOZPZVBpTJ6/iItaHYlbz5JdjLDqedoCkCIR0QtuMoH3H994Z
 o1o7i9wQX5oOkFqO9r1kiOsrDGCWm5BQRvRw4qDKW/bEQ3tPoEhGoUhTBmOG7N7c+ZtR
 nRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791689906; x=1792294706;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2xU70uIEXKYtl5UGvwhpB/mVljXXIrH3cu1cQ0TusdY=;
 b=T7lxn63jy8Kqq//s6h2+tVtjKntCBSH4M6ol7stDw9V14upuKTHWiM1Q5MA+IFDRpa
 CKG4InMXNPAhZW/+DfGwRrpz/m+cpH+8TTS/ji1lUkhI0If+GzwdhXnQLLST/F5e6Z6x
 0abvUxSZ6OwV8Yy6aMFnt6RpEE//JoPMQ6PsbOD8ZuIY50WxHJqRFepvPqn0RDBFv2Tz
 iR4ck5ZAvq7PdxCikn+bJingcVJaSUniiSlE2RR8+kpZPUht8NiXyprfCjjKvVQEoGZ+
 DKDZi7MTZXVkRvU/0uaIYOxXiWLzl8JfMTZCy/r7BcB0ZRbfbP0tOor7iI8rjf+iDeF6
 AUrg==
X-Gm-Message-State: AFq9FYI05UVxIX4SibnE8DJbuV+7w0lAgn4NI2CZuVTI654v/Vpb54IG
 Nc2twyqPgXqLM87Ds0tU9zp6NnQGYD6Nm+NmR0Cx8XmbjvcCyLuUlpYu
X-Gm-Gg: AYBFou0OkbzEAdAKVhNa52rP4/c3cMoZvu1QFOWnXjkaBX079Q8XwUEq68/YdzuXryx
 QbhzlD1trnvneoLIFRB6Ze65IeC0+KL/LEqR3UIM4svpSe9AcSwPneY3QTWHfDVYOUX+CCP4oFF
 wlGaGG57L7U4/Y7ONzZ2VwdbAXqwlBCpeRcZUuavwszXb9UTslUEZ8CiMUses0yz7QygMHe/4bn
 X7//Zl1dzt6YCRzFzKbwUkEW+cYweu91ll1lMSNPjHuJJctDpEAAdkMzFCY442GQxgI+SEsWepx
 U5c9MhbetNApmwDKAalv1lYg/kSFVOBFkqB8xvaSoJorE+axMEcl0strtUQtuh38hPx+GB9rc4A
 DS2vP7NjjOpvRncX8SXCJq5eYni8ID+FmkNtQoK8cYZrHvPAtUtiSlbZZX3imRk8mlhhXdRogxA
 mmPezVW5BO0AgaalUtJCzD0XAX/v9wXw7H3E37f1Il+1hqcXqVkte500al5WX5RA5rh1pPsyYaG
 z5jFl+R2Zs=
X-Received: by 2002:a17:90b:4d88:b0:3ab:189b:6980 with SMTP id
 98e67ed59e1d1-3ab3a79cf22mr5669490a91.39.1791689906126; 
 Sat, 10 Oct 2026 20:38:26 -0700 (PDT)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab339684f0sm5622898a91.1.2026.10.10.20.38.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2026 20:38:25 -0700 (PDT)
Message-ID: <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
Date: Sun, 11 Oct 2026 11:38:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
Content-Language: en-US
From: Zixian Zeng <sycamoremoon376@gmail.com>
In-Reply-To: <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 11 Oct 2026 04:53:20 +0000
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

On 2026/10/11 03:16, Kathpalia, Tanmay wrote:
> 
> On 11-10-2026 00:32, Kathpalia, Tanmay wrote:
>>
>> On 10-10-2026 11:47, Zixian Zeng wrote:
>>> Hi, Dave:
>>>
>>> On 2026/10/6 02:01, Dave Klotz wrote:
>>>> spacemit_sdhci_get_b_max() limits every SD read in the SPL to a single
>>>> block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
>>>> separate commands. The controller handles multi-block PIO reads in the
>>>> SPL: the OrangePi RV2 has loaded U-Boot from microSD with them through
>>>> the v2026.07 and v2026.10 trees.
>>>>
>>>> Drop the limit and use the host's b_max.
>>>>
>>>> The merged v13 cover retains the v9 changelog entry choosing single-
>>>> block SD reads in SPL. This reverses that deliberate policy for the
>>>> recorded RV2 SPL boot use case; no general multi-card reliability claim
>>>> is made. K1 does not advertise MMC_CAP_CMD23, so the MMC core sends
>>>> CMD12 after a multi-block read rather than requiring CMD23. Additional
>>>> card models, cold boots and transfer-error recovery remain required.
>>>>
>>>> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
>>>> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>>>> ---
>>>> Validation: unchanged executable change from v1; exact-base source
>>>> replay and checkpatch pass. The corrected combined integration, with
>>>> separate clock/MMC and DDR relocation fixes, passed SD SPL/FIT and
>>>> automatic NVMe EFI boot on the 4 GiB RV2 in a warm-boot trial. This is
>>>> an integration result, not an isolated test of this patch.
>>>>
>>>>   drivers/mmc/spacemit_sdhci.c | 11 -----------
>>>>   1 file changed, 0 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/ 
>>>> spacemit_sdhci.c
>>>> index 6488ae0fdb..4284553177 100644
>>>> --- a/drivers/mmc/spacemit_sdhci.c
>>>> +++ b/drivers/mmc/spacemit_sdhci.c
>>>> @@ -324,16 +324,6 @@
>>>>       return 0;
>>>>   }
>>>>   -static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
>>>> -                    lbaint_t blkcnt)
>>>> -{
>>>> -    struct mmc *mmc = mmc_get_mmc_dev(dev);
>>>> -
>>>> -    if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
>>>> -        return 1;
>>>> -    return mmc->cfg->b_max;
>>>> -}
>>>> -
>>>>   static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
>>>>   {
>>>>       struct mmc *mmc = host->mmc;
>>>> @@ -574,7 +564,6 @@
>>>>         spacemit_mmc_ops = sdhci_ops;
>>>>       spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
>>>> -    spacemit_mmc_ops.get_b_max = spacemit_sdhci_get_b_max;
>>>>         ret = clk_get_bulk(dev, &plat->clks);
>>>>       if (ret) {
>>> Using the current version of the next branch u-boot (ed869863c7),
>>> with your MMC patch series applied.
>>> Since the SPI controller is not enabled by default on the BananaPi-F3,
>>> I also applied another patch series:
>>> Link: https://lore.kernel.org/u-boot/ 
>>> cover.1790976767.git.DaveWK225@protonmail.com/
>>>
>>> I tested u-boot SPL with three SD cards on a BananaPi-F3 and found
>>> a reproducible issue, the specific error I encountered is spl: 
>>> partition error (Error: -38)
>>> At the meantime, when i was revert the commit:
>>> mmc: k1: let the SPL read SD cards more than one block at a time
>>> the error has gone. Same SD card, same operation steps.
>>> Maybe BananaPi-F3 do not support read SD cards more than one block at 
>>> a time?
>>>
>>>
>>
>> Hi Zixian,
>>
>> Thanks for testing this on the BananaPi-F3 and reporting this. The
>> same cards and steps failing only with this patch shows that
>> multi-block SD reads in the SPL are not reliable yet.
>>
>> I would request to try one more experiment before dropping it.
>> Please add MMC_CAP_CMD23 to host->host_caps and boot the same cards
>> again. CMD23 (SET_BLOCK_COUNT) tells the card how many blocks to
>> transfer. mmc_read_blocks() then uses CMD23 plus CMD18, and it does
>> not send CMD12 afterwards. The current driver does not set
>> MMC_CAP_CMD23, so a multi-block read is CMD18 followed by CMD12.
>>
>> After the SCR is read, the MMC core clears MMC_CAP_CMD23 when the card
>> does not advertise SD_SCR_CMD23_SUPPORT. Those cards stay on CMD18
>> plus CMD12.
>>
>> This also matches Eric's earlier note that on K1 ADMA depends on CMD23:
>> https://patchwork.ozlabs.org/project/uboot/patch/20260707-m4-v4-3- 
>> dbd01185f911@riscstar.com/
>>
>> If the CMD23 test also fails, I agree that this patch should be
>> dropped.
>>
> 
> Hi Zixian,
> 
> A few follow-up questions about the SPL-only failure:
> 
> The callback limits reads only when CONFIG_SPL_BUILD is enabled. U-Boot
> proper already uses mmc->cfg->b_max, even without this patch.
> Therefore, multi-block SD reads should already be used in U-Boot proper.
> 
> Could you please boot U-Boot proper from another device and test a
> multi-block read from the same SD cards?
> Could you also compare the following between SPL and U-Boot proper?
> 
> - selected SD timing mode
> - card clock frequency
> - bus width
> - PIO, SDMA, or ADMA transfer path
> - whether the card advertises CMD23 support
> 
> Although both stages use the same driver source, they may use different
> configuration options, transfer paths, clocks, and timing modes. This
> could explain why CMD18 works in U-Boot proper but fails in SPL.
> 
> Regards,
> Tanmay

Hi, Tanmay,

Sure, I've added some print logs, which you can see below:

commit 53c0ff5f65b0c7c4ae9f4563265741cd0ca23a0c
Author: Zixian Zeng <sycamoremoon376@gmail.com>
Date:   Sun Oct 11 09:34:03 2026 +0800

     Add mmc debug log

     Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index a619440fc4c..6e18d13884a 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -458,6 +458,13 @@ static int mmc_read_blocks(struct mmc *mmc, void 
*dst, lbaint_t start,
         struct mmc_cmd cmd;
         struct mmc_data data;

+       if (blkcnt > 1)
+               printf("mmc: multi-blk blkcnt=%lu clk=%u mode=%u 
width=%u caps=%x cmd23_host=%u scr0=%x cmd23_card=%u\n",
+                      (ulong)blkcnt, mmc->clock,
+                      (unsigned)mmc->selected_mode, mmc->bus_width,
+                      mmc->host_caps, !!(mmc->host_caps & MMC_CAP_CMD23),
+                      mmc->scr[0], !!(mmc->scr[0] & SD_SCR_CMD23_SUPPORT));
+
         if (blkcnt > 1 && (mmc->host_caps & MMC_CAP_CMD23)) {
                 cmd.cmdidx = MMC_CMD_SET_BLOCK_COUNT;
                 cmd.cmdarg = blkcnt & 0x0000ffff;
@@ -483,8 +490,12 @@ static int mmc_read_blocks(struct mmc *mmc, void 
*dst, lbaint_t start,
         data.blocksize = mmc->read_bl_len;
         data.flags = MMC_DATA_READ;

-       if (mmc_send_cmd(mmc, &cmd, &data))
+       if (mmc_send_cmd(mmc, &cmd, &data)) {
+               log_err("mmc: cmd%u read failed: blks=%lu blksz=%lu 
arg=%lx\n",
+                       cmd.cmdidx, (ulong)blkcnt, (ulong)mmc->read_bl_len,
+                       (ulong)cmd.cmdarg);
                 return 0;
+       }

         if (blkcnt > 1 && !(mmc->host_caps & MMC_CAP_CMD23)) {
                 if (mmc_send_stop_transmission(mmc, false)) {
@@ -547,6 +558,8 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t 
start, lbaint_t blkcnt,
         }

         if (mmc_set_blocklen(mmc, mmc->read_bl_len)) {
+               log_err("mmc: CMD16 blocklen=%lu failed, read of %lu 
blocks aborted\n",
+                       (ulong)mmc->read_bl_len, (ulong)blkcnt);
                 pr_debug("%s: Failed to set blocklen\n", __func__);
                 return 0;
         }
@@ -556,6 +569,8 @@ ulong mmc_bread(struct blk_desc *block_dev, lbaint_t 
start, lbaint_t blkcnt,
         do {
                 cur = (blocks_todo > b_max) ? b_max : blocks_todo;
                 if (mmc_read_blocks(mmc, dst, start, cur) != cur) {
+                       log_err("mmc: read of %lu blocks at lba %lx 
failed (b_max=%u)\n",
+                               (ulong)cur, (ulong)start, b_max);
                         pr_debug("%s: Failed to read blocks\n", __func__);
                         return 0;
                 }
diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 962a99cd05a..339b222bb68 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -131,6 +131,7 @@ static int sdhci_transfer_data(struct sdhci_host 
*host, struct mmc_data *data)
         dma_addr_t start_addr = host->start_addr;
         unsigned int stat, rdy, mask, timeout, block = 0;
         bool transfer_done = false;
+       ulong t0 = get_timer(0);

         timeout = 1000000;
         rdy = SDHCI_INT_SPACE_AVAIL | SDHCI_INT_DATA_AVAIL;
@@ -138,6 +139,13 @@ static int sdhci_transfer_data(struct sdhci_host 
*host, struct mmc_data *data)
         do {
                 stat = sdhci_readl(host, SDHCI_INT_STATUS);
                 if (stat & SDHCI_INT_ERROR) {
+                       log_err("sdhci: data err irq=%x present=%x 
mode=%x blksz=%x blkcnt=%x blocks=%u/%u t=%lums\n",
+                               stat,
+                               sdhci_readl(host, SDHCI_PRESENT_STATE),
+                               sdhci_readw(host, SDHCI_TRANSFER_MODE),
+                               sdhci_readw(host, SDHCI_BLOCK_SIZE),
+                               sdhci_readw(host, SDHCI_BLOCK_COUNT),
+                               block, data->blocks, get_timer(t0));
                         log_debug("Error detected in status(%#x)!\n", 
stat);
                         return -EIO;
                 }
@@ -294,6 +302,11 @@ static int sdhci_send_command(struct mmc *mmc, 
struct mmc_cmd *cmd,
                                 SDHCI_BLOCK_SIZE);
                 sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
                 sdhci_writew(host, mode, SDHCI_TRANSFER_MODE);
+               if (data->blocks > 1)
+                       printf("sdhci: multi cmd%u arg=%lx blks=%u 
blksz=%u mode=%x dma=%u\n",
+                              cmd->cmdidx, (ulong)cmd->cmdarg, 
data->blocks,
+                              data->blocksize, mode,
+                              !!(host->flags & USE_DMA));
         } else if (cmd->resp_type & MMC_RSP_BUSY) {
                 sdhci_writeb(host, 0xe, SDHCI_TIMEOUT_CONTROL);
         }
@@ -325,8 +338,12 @@ static int sdhci_send_command(struct mmc *mmc, 
struct mmc_cmd *cmd,
         if ((stat & (SDHCI_INT_ERROR | mask)) == mask) {
                 sdhci_cmd_done(host, cmd);
                 sdhci_writel(host, mask, SDHCI_INT_STATUS);
-       } else
+       } else {
+               log_err("sdhci: cmd%u status mismatch irq=%x mask=%x 
present=%x\n",
+                       cmd->cmdidx, stat, mask,
+                       sdhci_readl(host, SDHCI_PRESENT_STATE));
                 ret = -1;
+       }

         if (!ret && data)
                 ret = sdhci_transfer_data(host, data);
diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index 13bf6bf6000..23c655c6def 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -640,6 +640,19 @@ static int spacemit_sdhci_probe(struct udevice *dev)
                 goto err_reset;

         spacemit_sdhci_phy_init(dev, host);
+
+       {
+               u32 caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+               const char *path = (host->flags & USE_ADMA64) ? "ADMA64" :
+                                  (host->flags & USE_ADMA) ? "ADMA" :
+                                  (host->flags & USE_SDMA) ? "SDMA" : 
"PIO";
+
+               printf("sdhci: %s path=%s flags=%x caps_sdma=%u 
caps_adma2=%u max_clk=%u\n",
+                      dev->name, path, host->flags,
+                      !!(caps & SDHCI_CAN_DO_SDMA),
+                      !!(caps & SDHCI_CAN_DO_ADMA2),
+                      host->max_clk);
+       }
         return 0;

         /*


commit 75d6b28ba7b020d3100586f586ee6d1a4488ac84
Author: Zixian Zeng <sycamoremoon376@gmail.com>
Date:   Sun Oct 11 09:33:20 2026 +0800

     debug: Add MMC_CAPS_CMD23

     Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index 88e06a681ca..13bf6bf6000 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -624,7 +624,7 @@ static int spacemit_sdhci_probe(struct udevice *dev)
         /* Set quirks */
         host->quirks = SDHCI_QUIRK_WAIT_SEND_CMD |
                        SDHCI_QUIRK_32BIT_DMA_ADDR;
-       host->host_caps = MMC_MODE_HS | MMC_MODE_HS_52MHz;
+       host->host_caps = MMC_MODE_HS | MMC_MODE_HS_52MHz | MMC_CAP_CMD23;
         host->max_clk = plat->cfg.f_max;

         plat->cfg.f_min = SDHC_MIN_CLOCK;


With appling these two commits, Debug logs as follows:

⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ⥄ git log --oneline 
origin/next..HEAD
53c0ff5f65b (HEAD -> k1-dave-mmc) Add mmc debug log
75d6b28ba7b debug: Add MMC_CAPS_CMD23
6b4af8b1dd8 mmc: k1: do not release the shared AXI clock and reset on 
probe failure
4114764d716 mmc: k1: let the SPL read SD cards more than one block at a time
6676ce89521 mmc: k1: handle a missing max-frequency and clk_set_rate()'s 
return value
6427189ef33 spacemit: k1: fall back to the other boot devices in SPL
b58a31797d7 spacemit: k1: do not require a PMIC or an SPI controller in SPL

U-Boot SPL 2026.10-rc5-00641-g53c0ff5f65b0 (Oct 11 2026 - 10:31:28 +0800)
Fail to detect board:-2
vdd_core, value:900000
vdd_1v8, value:1800000
vdd_1v8_mmc, value:1800000
DDR firmware: [0xc081d700]:0xf0227179, size:0x8d98
DDR is ready
No SPI controller (-19)
Trying to boot from MMC2
sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
max_clk=204800000
mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef 
cmd23_host=1 scr0=2358043 cmd23_card=1
sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
sdhci: data err irq=408020 present=1070800 mode=32 blksz=7200 blkcnt=12 
blocks=12/32 t=2ms
mmc: cmd18 read failed: blks=32 blksz=512 arg=2
mmc: read of 32 blocks at lba 2 failed (b_max=65535)
sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
sdhci: cmd16 status mismatch irq=18000 mask=1 present=1070000
mmc: CMD16 blocklen=512 failed, read of 1 blocks aborted
spl: partition error
Error: -38
SPL: Unsupported Boot Device!
Trying to boot from MMC1
alloc space exhausted ptr 104380 limit 100000
Aligned buffer alloc failed
spl: could not find mmc device 0. error: -19
Error: -19
SPL: Unsupported Boot Device!
Trying to boot from SPI
Invalid bus 0 (err=-19)
SPI probe failed.
Error: -19
SPL: Unsupported Boot Device!
SPL: Unsupported Boot Device!
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###


After I revert the multi-block SD read commit,
I booted into u-boot proper. Debug logs as follows:

⋊> hack@morise ⋊> ~/k/u-boot on k1-dave-mmc ⥄ git log --oneline 
origin/next..HEAD
55e8da25a70 (HEAD -> k1-dave-mmc) Revert "mmc: k1: let the SPL read SD 
cards more than one block at a time"
53c0ff5f65b Add mmc debug log
75d6b28ba7b debug: Add MMC_CAPS_CMD23
6b4af8b1dd8 mmc: k1: do not release the shared AXI clock and reset on 
probe failure
4114764d716 mmc: k1: let the SPL read SD cards more than one block at a time
6676ce89521 mmc: k1: handle a missing max-frequency and clk_set_rate()'s 
return value
6427189ef33 spacemit: k1: fall back to the other boot devices in SPL
b58a31797d7 spacemit: k1: do not require a PMIC or an SPI controller in SPL


U-Boot SPL 2026.10-rc5-00642-g55e8da25a70c (Oct 11 2026 - 10:38:42 +0800)
Fail to detect board:-2
vdd_core, value:900000
vdd_1v8, value:1800000
vdd_1v8_mmc, value:1800000
DDR firmware: [0xc081d740]:0xf0227179, size:0x8d98
DDR is ready
No SPI controller (-19)
Trying to boot from MMC2
sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
max_clk=204800000

<debug_uart>


U-Boot 2026.10-rc5-00642-g55e8da25a70c (Oct 11 2026 - 10:38:42 +0800)

DRAM:  4 GiB
Core:  339 devices, 23 uclasses, devicetree: separate
MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
max_clk=204800000
sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
max_clk=204800000
mmc@d4280000: 1, mmc@d4281000: 0
Loading Environment from nowhere... OK
In:    serial@d4017000
Out:   serial@d4017000
Err:   serial@d4017000
Net:   No ethernet found.
=> mmc dev 1
mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef 
cmd23_host=1 scr0=2358043 cmd23_card=1
sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef 
cmd23_host=1 scr0=2358043 cmd23_card=1
sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
... omit duplicate logs
mmc: multi-blk blkcnt=2 clk=50000000 mode=2 width=4 caps=300207ef 
cmd23_host=1 scr0=2358043 cmd23_card=1
sdhci: multi cmd18 arg=82002 blks=2 blksz=512 mode=32 dma=0
switch to partitions #0, OK
mmc1 is current device
=>
=> mmc list
mmc@d4280000: 1 (SD)
mmc@d4281000: 0
=>
=> mmc info
Device: mmc@d4280000
Manufacturer ID: 3
OEM: 5344
Name: SD32G
Bus Speed: 50000000
Mode: SD High Speed (50MHz)
Rd Block Len: 512
SD version 3.0
High Capacity: Yes
Capacity: 29.7 GiB
Bus Width: 4-bit
Erase Group Size: 512 Bytes

I enabled MMC_CAP_CMD23 and the card does support it (SCR bit 1,
cmd23_host=1 and cmd23_card=1 in the log above), so the SPL really
used SET_BLOCK_COUNT + CMD18 without CMD12 - and it still aborts the
data phase with SDHCI_INT_DATA_END_BIT after ~20 of 32 blocks.
Booting U-Boot proper and issuing the same 32 block CMD18 from the same
card succeeds, with the same PIO path (flags=0, dma=0), the same SD_HS
mode, the same 4-bit bus and the same CMD23 usage.
So I think CMD23 is not the trigger, the SPL fails with the FIFO
permanently backed up (it drains slower than card delivers, so the
controller has to stop the SD clock inside a block).

Now answering your questions:
mode    : mode=2 = SD_HS, in both stages
clock   : requested 50 MHz (SD_HS) in both stages
bus     : 4-bit bus, in both stages
path    : PIO in both stages
CMD23   : the card supports it and both stages use CMD23 + CMD18

Best regards,
Zixian
