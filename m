Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3972F013FA
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 21:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4486C841CD;
	Mon, 16 Mar 2026 22:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PDdidq/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6423E841CF; Mon, 16 Mar 2026 22:26:53 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB5A83FC0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 22:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-41706b23543so68510fac.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 14:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773696409; x=1774301209;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uI8BRlCsMcZERNNmSEqETXFmUTrpuW4/yG8WQ7GfKh8=;
 b=PDdidq/Ppa71DSoc6hOB696FTxydQZqrKC2dAHNa4AXDth1pIrSgnYWaUx//AEBbuf
 c4eK+0IVYTf/Ii9CFqjGfCMBNlf4c5FLpyym5unhiRaUxQ9DLc86am6e5mrxy3f4SQZ8
 iLW/hWL49ii55XGeXBIKR7Q//N7S++HKJC9s5nYw4YdqO+SzdN1ow+YKCO9uGlJTtVVx
 KndRssGZje7AI91QPGmjHzIbYOaqGncC2OOqCIgWB8njc32UxHlu2fH/S5M31ixNqwkq
 XJKOm7kUS/8KGYadvL02jqa00DtjKjbL6UCHq4lJeVClM4c1RqblCVhv66V3csZ1koHz
 FJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773696409; x=1774301209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uI8BRlCsMcZERNNmSEqETXFmUTrpuW4/yG8WQ7GfKh8=;
 b=gk0JVdnLs6tbAA0v1w7g2ucsrmEvJM34LgF9TDzA5EWHNSLsiZIXm5QiQRrAPTll3X
 lonE52PPfy2oFZI7DGgPFNadffdp6hFEDvR+N+Fdkz72Ofsrq0vN5iNMq9qHXHoDfiwt
 NevdGcng7/MIamFEsgWXQPGACpiQ9xm1og7hRZwe7B0+Lw4OTb1ShIikRh29qibpM0VQ
 dVlEFlNpoiizj2tBjyYNUxAuimCDnR3j27GwI30Ku/I8CgvkNfFRf2Emi4m1mAheOeLC
 HjVSEJV9qxOkWDpcvHme7G7hrqBrbPPmCbi04Ad9wPIjK0MnJaNu+8GUxlVPLCj5bI1M
 Vkkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbDICmyh3uUg0Z+5gIeE2e7Mk571+roUd8QN8DjIzFRDYaGSWm5XwoGx5jsnwXycejnvVbSZs=@lists.denx.de
X-Gm-Message-State: AOJu0YzZOYJMU5TxmyVeoIfz26S/R/oKWtR3rTsf5KO789FkoVB5MzJt
 hBmLkn4MMXowQKXzyg+carLWZATf2fM3VmIYsLTp62ybgXcwCXrEk8IB9Ibwk+nwWzA=
X-Gm-Gg: ATEYQzy+kzS9WOXpioozvHMBmSyg67IaU9LD/k9FKtm8b/SiGNbgr62/LcPqI+Mzwgb
 QD2WC+Fe4TUP/v+NSbAmLEfintBhzrxR1Gts5mbIlfnPCQufPCDczy42e4xr1ROvzXy59jZM3tA
 2RwEUAH0o18645YoiGTj/R5GIQR2CyqaTudB7lrc3kDWjQY48nBcD8W4gZ0LHIzkt2qGmTojINY
 TN4jGavQ4DnvMJGi2mS/BS4cdUXWRiFC7eFELWt45BuYF2cHgfmHpTZOekLe/ssRSpyHTAY5ICT
 ioqPdFveDhzNJl6g+OgX0U2in++FNeH9V8gV0oNYwUPns/CYfxOz2wUtEbaV98dj3+TwDuL8KcE
 nFZ+Li0ryzck5rr6rXZnIMpJgLq36LLABlYfHiBgkJ+IEuQbqhOXwu+QYxnnuYF3dFEHWtAGwwb
 /TTjS92z2f/wPeCe+qwcVTjnGI7U1lD+Rx6Q6OCIo6oudkY+8Rgx1u27uvu8dg46i83XEIfSQVB
 A==
X-Received: by 2002:a05:6870:249b:b0:3e8:9b72:5cda with SMTP id
 586e51a60fabf-41bb032816dmr612089fac.11.1773696409580; 
 Mon, 16 Mar 2026 14:26:49 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e504:a034:1152:a664?
 ([2600:8803:e7e4:500:e504:a034:1152:a664])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e6e82cdsm17949744fac.18.2026.03.16.14.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2026 14:26:49 -0700 (PDT)
Message-ID: <43bd1d9b-7381-42dd-939e-a37ec2740033@baylibre.com>
Date: Mon, 16 Mar 2026 16:26:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
To: Julien Stephan <jstephan@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.denx.de, Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
 <20260310-mtk-mt8391-initial-support-v2-6-1dc862d58532@baylibre.com>
 <CAEHHSvbduE9Naebb8hk3xu+0ZEwRuO8yuh_1GUM9QFOP=BA2vQ@mail.gmail.com>
 <38e5929d-4d95-45db-be93-28232a9de954@baylibre.com>
 <CAEHHSvY-NRQcLKHizS0S-++5CgXrvKdxjH4QUrsWP_LbW+AC-Q@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAEHHSvY-NRQcLKHizS0S-++5CgXrvKdxjH4QUrsWP_LbW+AC-Q@mail.gmail.com>
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

On 3/16/26 10:01 AM, Julien Stephan wrote:
> Le lun. 16 mars 2026 à 15:34, David Lechner <dlechner@baylibre.com> a écrit :
>>
>> On 3/16/26 7:38 AM, Julien Stephan wrote:
>>> Le mer. 11 mars 2026 à 01:17, David Lechner <dlechner@baylibre.com> a écrit :
>>>>
>>>> From: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>>>>
>>>> Add basic defconfigs for Genio 520 and 720 EVKs.
>>>>
>>>> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
>>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>>> ---
>>>>  board/mediatek/MAINTAINERS             |  7 +++++++
>>>>  configs/mt8189.config                  | 34 ++++++++++++++++++++++++++++++++++
>>>>  configs/mt8371_genio_520_evk_defconfig |  4 ++++
>>>>  configs/mt8391_genio_720_evk_defconfig |  4 ++++
>>>>  4 files changed, 49 insertions(+)
>>>>
>>>> diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
>>>> index 446a9e8e53c..4f371592059 100644
>>>> --- a/board/mediatek/MAINTAINERS
>>>> +++ b/board/mediatek/MAINTAINERS
>>>> @@ -1,3 +1,10 @@
>>>> +MT8189/MT8371/MT8391 EVK
>>>
>>> Hi David,
>>> I would not put MT8189 here since there is no MT8189 EVK
>>>
>>>> +M:     Macpaul Lin <macpaul.lin@mediatek.com>
>>>> +S:     Maintained
>>>> +F:     configs/mt8189.config
>>>> +F:     configs/mt8371_genio_520_evk_defconfig
>>>> +F:     configs/mt8391_genio_720_evk_defconfig
>>>
>>> Any reason to have genio_520/genio720 in the defconfig name?
>>
>> The upstream devicetree name will have "genio-720" in the name, so
>> find it strange to call the defconfig something that doesn't match
>> the devicetree.
>>
>> If there is a (not Genio) MT8391 EVK I would expect it to have a
>> different devicetree and therefore a different defconfig.
>>
>>> All other boards we are currently upstreaming don't specify it in
>>> their defconfig name:
>>> mt8365_evk_defconfig/mt8370_evk_defconfig/mt8390_evk_defconfig ...
>>>
> 
> I get your point.. From my understanding, mt8371_evk IS genio_520, so
> IMHO there will be no non genio MT8371_EVK.
> But, I understand that it makes sense to have the name of the
> defconfig matching the name of the device tree.. In that case should
> we rename all other defconfigs for mt board?
> (8365, 8370,8390,8395..)

The upstream devicetree name for 8365 is mt8365-evk.dts (or MT8365 EVK
!= Genio 350 EVK and I don't know about it?)

For the others though, yes, I think it would be good to be consistent
with the naming. And we could also use a #include in 8370 and 8390
to reduce the duplication like I did for 8371 and 8391.
