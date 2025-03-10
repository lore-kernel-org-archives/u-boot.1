Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1979C282EC
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0803581878;
	Mon, 10 Mar 2025 15:34:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="QrCqHvSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513238164E; Mon, 10 Mar 2025 15:13:43 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 947C181417
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=51647dd51e=cheick.traore@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ACE0is006880;
 Mon, 10 Mar 2025 15:13:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=selector1; bh=wiEjIi794h4Bk8c/CoGfT31w
 8hNJLv6TvQkyMm3z4UQ=; b=QrCqHvSi9R6Nbgaq75jKdWADatSHoe+D1MHchCci
 4065AXKzpeJiMMTJkKGLhTP40LGRhIaLXajI6igAiJd0beLcrwah81Kv64BeYe7s
 OBY7gSAJnFTZasQeUcISOSsqn/Ry3MVQKXQIiFBqRmEsYR73t7Gth68Nh82e6lht
 cDLzapwkXClibJXeQTipWrJoJddxLLtf+ZaU47bjWCCrd3kq9YUZLFI9nLYJTlJo
 5gsSK7yZhDO3h7xKIV4FzZOvgc1i5qcPmiCuRbgkcOzgtsjemK/xAigGp4zkU964
 v7GUq4kqZ4k1M1W6b7dy6MdWucmq6VrdVAxKXAsOtGtKMw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4591qrw6e7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 10 Mar 2025 15:13:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3E47B40055;
 Mon, 10 Mar 2025 15:12:48 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6598C4FAACE;
 Mon, 10 Mar 2025 15:12:30 +0100 (CET)
Received: from [10.48.86.119] (10.48.86.119) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 15:12:29 +0100
Message-ID: <a168bd2a-6d44-4b36-98fe-3ceb31810edf@foss.st.com>
Date: Mon, 10 Mar 2025 15:12:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH 1/5] dm: pwm: Check if duty_ns is lower than
 period_ns
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20250306105620.624760-1-cheick.traore@foss.st.com>
 <20250306115558.1.I060a56226e03cddfd4a6d6b98bc86c91435710cc@changeid>
 <6ef98461-7ffb-4257-bc5f-bc0c543a773c@foss.st.com>
 <2ad51ae3-53d7-42f6-bb3a-800ba6c6b672@foss.st.com>
 <329df3e4-1493-4966-a7e2-ebd628503e8c@foss.st.com>
Content-Language: en-US
From: Cheick TRAORE <cheick.traore@foss.st.com>
In-Reply-To: <329df3e4-1493-4966-a7e2-ebd628503e8c@foss.st.com>
X-Originating-IP: [10.48.86.119]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01
X-Mailman-Approved-At: Mon, 10 Mar 2025 15:34:03 +0100
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 3/10/25 13:35, Patrice CHOTARD wrote:
>
> On 3/10/25 11:00, Patrice CHOTARD wrote:
>>
>> On 3/6/25 15:13, Patrice CHOTARD wrote:
>>>
>>> On 3/6/25 11:56, Cheick Traore wrote:
>>>> It was possible to provide a duty_ns greater than period_ns to
>>>> "pwm config" command. The framework must check the values before
>>>> providing them to drivers.
>>>>
>>>> Signed-off-by: Cheick Traore<cheick.traore@foss.st.com>
>>>> ---
>>>>
>>>>   drivers/pwm/pwm-uclass.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/pwm/pwm-uclass.c b/drivers/pwm/pwm-uclass.c
>>>> index 6543db1d623..b4491f7dcd4 100644
>>>> --- a/drivers/pwm/pwm-uclass.c
>>>> +++ b/drivers/pwm/pwm-uclass.c
>>>> @@ -27,6 +27,9 @@ int pwm_set_config(struct udevice *dev, uint channel, uint period_ns,
>>>>   	if (!ops->set_config)
>>>>   		return -ENOSYS;
>>>>   
>>>> +	if (duty_ns > period_ns)
>>>> +		return -EINVAL;
>>>> +
>>>>   	return ops->set_config(dev, channel, period_ns, duty_ns);
>>>>   }
>>>>   
>>> Reviewed-by: Patrice Chotard<patrice.chotard@foss.st.com>
>>>
>>> Thanks
>>> Patrice
>> Applied to u-boot-stm32/next
>>
>> Thanks
>> Patrice
>
> Hi Cheick
>
> Unfortunately, this patch is causing U-Boot CI test failed:
> seehttps://source.denx.de/u-boot/custodians/u-boot-stm/-/jobs/1054426
>
> More precisely ut_dm_dm_test_cros_ec_pwm, see test/dm/cros_ec_pwm.c
>
> Either update test/dm/cros_ec_pwm.c or another solution is simply to
> clamp duty_ns to period_ns as following ?
>
>   +	if (duty_ns > period_ns)
>   +		duty_ns = period_ns;
>   +
>
> Patrice
>
>
>> _______________________________________________
>> Uboot-stm32 mailing list
>> Uboot-stm32@st-md-mailman.stormreply.com
>> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

Hi Patrice,

It seems like this patch should finally be reverted.

When the duty cycle exceeds the period, some drivers already clamp the 
value of the duty cycle to the maximum value or do not apply the duty cycle.

So, I will check the duty cycle in|drivers/pwm/pwm-stm32.c|and 
return|-EINVAL|when it exceeds the period.

Thanks,

Cheick
