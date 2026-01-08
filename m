Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A0CD232C2
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 22:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632BA841C8;
	Thu,  8 Jan 2026 23:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vp79MK3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE9D800B6; Thu,  8 Jan 2026 23:45:41 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AEFD84206
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 23:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dnKk81S6Lz9v6H;
 Thu,  8 Jan 2026 23:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767912336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrjVoxaoGsSw4Gk0AjnoG3sHUmA0aMiI4TtZqyHaaOw=;
 b=vp79MK3rQ11zJZpkHFN8/EIz2q9JzQ9LuPClsIEbGXDlo5tK3Q8b6kfmmuxCAlrZXXtUiR
 EKKUgTLeEWjGfXKUe7Ud3XnLFvRI56tOwAMkDLUOQH20ac1FIdNfpPzVymJmytSIJeuxVm
 VtBrriOzg/qy0t1VvdGzCEYDJ0DRWMwk0NiJZ9/0uxFbxUdaHi6uARNENqQL7yj05xplhY
 kIdCxz/q1DxMV6GsYihvLq+aS/jmbpFxl6EUySs/TiPPUaWGs4zPLdIF+RYzbtcaACtZ/9
 vxBdb144wRomWYdc8F804Sat5lwzEmqFIIfEzjD2hSBsGmTq8HsCm31V8nJhsw==
Message-ID: <84d1a5dd-c545-4021-80b5-b534d90edd19@mailbox.org>
Date: Thu, 8 Jan 2026 23:45:34 +0100
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
 <f0eed6c7-54fb-45aa-be22-c1d84c0ebb75@mailbox.org>
 <23321b6c-535a-4b75-b218-f49185de91ff@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <23321b6c-535a-4b75-b218-f49185de91ff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b996cece0e0ec1551f0
X-MBO-RS-META: ikfak8esczkx1ru9eqaxwi1a6h45cs7d
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

On 1/8/26 9:44 PM, Casey Connolly wrote:

>>>> ""
>>>> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
>>>> index 3c8e4299259..da46b3ebdfd 100644
>>>> --- a/drivers/ufs/ufs-uclass.c
>>>> +++ b/drivers/ufs/ufs-uclass.c
>>>> @@ -1868,12 +1868,11 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba
>>>> *hba)
>>>>           }
>>>>
>>>>           host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba,
>>>> ref_clk);
>>>> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
>>>> +       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL) {
>>>>                   dev_err(hba->dev,
>>>>                           "invalid ref_clk setting = %ld\n",
>>>> clk_get_rate(ref_clk));
>>>> -
>>>> -       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
>>>> -               goto out;
>>>> +               return -EINVAL; // I think we want to bail with error ?
>>>
>>> I don't think we need to error out here, Qualcomm platforms don't have
>>> this ref clk wired up properly yet but somehow things are working ok.>
>>> +       }
>> This will print a warning. If on qualcomm platforms the UFS is working
>> and these clock are not needed, then this should be fixed, likely by
>> making the clock optional, or using fixed-clock in DT ?
> 
> I think the warning is what we want, it will be fixed properly once we
> get a driver for rpmhcc which is what provides the ref clk. As for why
> UFS works despite this I have no idea but I'd rather assume it's a lucky
> accident.
So, would it be possible to add fixed-clock into the 
qualcomm-*-u-boot.dtsi in the meantime to avoid this conditional, and 
return -EINVAL here ; and once the rpmhcc driver is available, remove 
the qualcomm-*-u-boot.dtsi change ?
