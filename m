Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4064EC98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 14:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF8C560608;
	Wed, 23 Sep 2026 14:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V1Ktnl_7gTlk; Wed, 23 Sep 2026 14:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F39B60756
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790175308;
	b=qIWiPtonUcSJFcra6A/vubiAguSimu5Yeyemsa6zaUAtjEo4YvfdLuFnWrgVNXvLAD/X
	 Q9xm5YYFPMSu/+4KeS/uR3AIevZoQ3AIJ2NUv56zDynrXs0wAkSaYjUNhPMKi5gM/NKpc
	 zPwfCP2RcEskc9izPza81C1yopapzxS6qqoVhCDcyShN5LQhexKXZusmT4toR+e7tDLBB
	 qvQKbs2SeT1CmTSYEbLU6ZNBrN+LJkV5jh5rb1oFXfeewL3RpwS+nW88aRtv0y0JzxeZX
	 KWUjHPnzJEqBN2WwEkNrGizoyXFCLGcZhXlZqrZHmCQiDJ4o0uYsoXrMAwADptiadsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790175308;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hSPBZMXOtwBCBwGTAdD2stQVY5CmTVPSPTycUjFN/FI=;
	b=VHt6m1wZIZJRS2svyeAEKgTqakzHEiB4LZ+Ht9qttrNcIoKfkXq5I0hwD41PknGDao9r
	 tKTl3+Z9D3RA6jzG3h9dTOBWog+0r1Zcqay00kAPE/KYvJCLXKQ+YOxlPcwLxyHIYVg5T
	 PJCqh1E6fyWwf3LoVfsOD7pyDLpvaoZQv+u2AEwjsgXSAEO0Cxch3R15r9KUBeKHPtl7G
	 USQGs5ETG89rDp2ma6Q4EP8Uld29w8cbamMlm0Ictpr2tST/1r1pIuhco9yRkFij0+hRd
	 cZgi40VVh7UfZ7MWhn8qNa5+yX7pQTz2f+pm17wH+pLie37s4qML01N1Yl6n8vp7Q8g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790175308;
	bh=hSPBZMXOtwBCBwGTAdD2stQVY5CmTVPSPTycUjFN/FI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=owhIJLnabOqnyCWycCSBjAARPxR049fkyO1yGf2wCwu9ek1DRylBC9OACdu8jGMRJ
	 dOvVZcAyxqwfgguX3wEdr/EnZ269eJKiG3ZFo3ufp08NaUjIvpRJl5fB3dbt0BXgWt
	 qBPHjeOkvSiAgqYOWuioVQUsmYwwEGUyZEZKn1cMjh1kb0M01QEvQ/wGgVd/VeOEKR
	 5etiAbivTukp82YgpU/Q8UwHDTNxFWfAlB3F9VFXCBJbFIeAf4Qj1X8bUDSDSSIkOP
	 Ftyh/V785c9ROARzp63bQt/fMBy1S2EZ3pHoSNCeKOWmqCWDdysze+SdkznVsjf5y+
	 0byJrGxN2+Qhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F39B60756;
	Wed, 23 Sep 2026 14:55:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94AA1A29
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:55:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 865C140699
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:55:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2qPmaDerVTfe for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 14:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A902540694
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790175306;
 b=m2s8jG9A0K958R0ESI0iMwNBORSdvcGQElSnkNQKYQlBVv3UUe/7znUPiupNPqT1ljcG
 GqFFPWS2wtt6b+sbr5SYoIhS04prtlu249CDQiD9Sc3NhxJGoJMUxK9FRTdF4JmuLYDFm
 LqE/HcCoHsLFimw5Zp+XQe9EruM8/XCBaKBpreD2qxE5Xvvm2cV8yMl4AfaUf+/9X+B+g
 mWDCbLihvu1fhrITDSc9/BUPDGCVDZYqMsFA2cm1IgcZZ9C3jsE/EacnhSi/psUL/kr8L
 p69OA2OT/NpGFgWzBMko+eCHBY6X0qCLaYSIJrkJUcG++Lvwre34qnfAQLa+eTS7KUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790175306;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=hSPBZMXOtwBCBwGTAdD2stQVY5CmTVPSPTycUjFN/FI=;
 b=kw0P6YvD21tmuBrZt7NF6d0mQGBUJIG5Jcfc876ZC+A5TzTymg0CZuPnGztKxrUrAoKM
 Xpu+sGbHSfBPc9yZ1p1Jok/1ppYxxiya8cOo9j50l18nZNUXCJqlGJYlkM3iGPMBl8+AU
 FpJhamgyZRIzmz1ix3tc/gJSW/OBZ19UwyedMcSx+kxs2jCJyaYpZamUgzg/HjkXOllhM
 iaWIrd90BkeDBldMHsAeODxqqkNmseFCIRfHMlww9PEwk3s5AbB5pPZMvjnYry1Eiav5n
 p04i0CumJNFF1k3OLX0Dqflnxdmi0LQRVnoAagUc1ZdSXgO8GMS+zthhFqRvC6pnxoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XbzJYHeN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:41::f;
 helo=mail-yx2-x0f.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XbzJYHeN
Received: from mail-yx2-x0f.google.com (mail-yx2-x0f.google.com
 [IPv6:2607:f8b0:4864:41::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A902540694
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:55:04 +0000 (UTC)
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-66f943b286fso1015975d50.2
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790175304; x=1790780104;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hSPBZMXOtwBCBwGTAdD2stQVY5CmTVPSPTycUjFN/FI=;
 b=XbzJYHeNovPoHpdZ+NlZFNACkdQ9E2ScutkoqckM59CVg5CGScMdoeQOAks6NEoRCO
 j9I8qnEbzBird/XrH+Ag8qrLXgaKO0qw15KNw9VmVIUG6t3WC53MM9kypmCijrMIYNtt
 oJsq0A/skkyXnUKP0AjLzse5ft2av3BjvGHSRQJWh0TDEzPZsOmtdagPNEk2vfICN60i
 KibIUlLazFJ4iZ9gFdqAbxEsg5SuA0B1hRF8LOOjV0Tllt36mjwcfnCH1ZhHxpJJgZes
 MQYY4N+HzJHmZ30EtAi6HOxNSujUskL5HeaAzIQXXwmOej72fDzeu/eMd2K9j+G6OLTM
 BcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790175304; x=1790780104;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hSPBZMXOtwBCBwGTAdD2stQVY5CmTVPSPTycUjFN/FI=;
 b=Tfh1ePWp4Eyz/YlzTqs7ZlJZpIDzi4LtmYbNo+P4z9+2DNtGklVJ9gtkb+aSuGPfBZ
 T1ROCXEqs8j4rz3HZ+ZmNbmAB1R4I5JNWmhP3GFY/USXrQ+sawLuJ2pOFK9erpOGvkmz
 tQ02EHi/zLyWV8K9f/+AykHqMN+4/JTJrPV2l92jGa2+kCxvOxri6BJF+etjxkBeZnvv
 bfZLvAhTAbCS1qb0EgeZLNHmYJcdz8JoXhYTda6ZNsGexiFNe4i0sf3H3iIF7wKu/bzz
 4lPBVU+hoJbD4LxQJvVeqjifXTaWKo9hfrJ+hfyIbbwRCL9xADIkRw7Sfft8sZs3N9wG
 mHww==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdurGDcynP6Vb/IztWBiXzbF0Iki/PHenG8z6kEP+EUwwWjemnK2vsMpqA3VuCs/cn2fR7ybs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l99Ht54wViAvBPN+NttaVTlxLsisDwXSipMBt+b/QEnO4E1c4u
 b6R9Qgnimn5do9aM9ikM+Q5plmjPnVHW+M5xvTGu2SNRdwdz/+rLFxaFRm2dSZJE95HK1mC6WFB
 TS7ZP
X-Gm-Gg: AYBFou2sT7dHURDZlsEWs/0dwoovDkO4tTaHhkr0GoItdIiUOxUlLQq0GBev+uF5rSx
 1gkPKs2b9oHBrioPmwrZ/n/pcXocBCex1GqWB6zXpdCSwd7cXFm/KIefIhtZWRNTb9ekQ3rVCZn
 Lser2b0wL67t9Uo3h3c6JYE/ya9cLfflCvYxH9WJMmlySw+RNT1bg6MmFMmcHIDyFQR+Xe2MK1b
 rLh2rBDga3nn2AFUJSHVw0wQ8airMjN22rfBQL2p2vWTeBULweP2exi/bIsB+9V8U0pNuGPKqJB
 /HVsN4v9hm2OXo0Nck5TjK0mbCa0wpPkdFHGU7HuitKph3ClFLx4xEUwQ5akx8QxsH1/SNY4ACy
 MiphxcgKDOB1/ZqdCxYzBuzhjM18arv/oPTPIQT09k4e7GWa99fiYL4RFutB+5OnT1HMCXE9NjU
 RvIlF1b1wftMaQgBhWPEPASKzuLxVDC3vinp5NhG5KYfKTTswiDMs06jMSfoOqUPclSK3J5EFJB
 3lXHv7u68khe0G2Wvsi07C/4PZnLNri47EYUHTqYvA7HxSc
X-Received: by 2002:a53:ebd0:0:b0:672:cce2:42e4 with SMTP id
 956f58d0204a3-672d577af84mr1501464d50.31.1790175303794; 
 Wed, 23 Sep 2026 07:55:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:15b8:389e:2bba:8894?
 ([2600:8803:e7e4:500:15b8:389e:2bba:8894])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-672d8099876sm998703d50.9.2026.09.23.07.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 07:55:02 -0700 (PDT)
Message-ID: <74268f61-b3c3-418e-8868-bad64e7084f2@baylibre.com>
Date: Wed, 23 Sep 2026 09:55:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: mediatek: enable U-Boot fastboot DAs on Genio
 510 and 700
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>
References: <20260914-ccaione-upstream-mt8390-da-v1-0-b76f9e30ac38@baylibre.com>
 <20260914-ccaione-upstream-mt8390-da-v1-2-b76f9e30ac38@baylibre.com>
 <6070e105-ef8c-41bd-9dcb-29f6f0b92af2@baylibre.com>
 <arPe_JbLjVvUXjRM@macbook>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <arPe_JbLjVvUXjRM@macbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/23/26 9:25 AM, Carlo Caione wrote:
> On Tue, Sep 22, 2026 at 11:27:35 +0100, David Lechner wrote:
>> On 9/14/26 8:35 AM, Carlo Caione wrote:
>>> Some provisioning flows need U-Boot's command support in addition to
>>> fastboot. Provide a U-Boot-based download agent for Genio 510 and 700 so
>>> these flows can run without relying on firmware already stored on the
>>> board.
>>

...

>>>  #if defined(CONFIG_SPL_SPI)
>>>  	return BOOT_DEVICE_SPI;
>>>  #elif defined(CONFIG_SPL_MMC)
>> Should we have a precursor patch to clean up the existing entries to also
>> use CONFIG_IS_ENABLED() to keep this consistent?
> 
> I'll clean it up in this set, no need to have a precursor patch.
> 
>> (And I assume in the config from the first patch, this would fall though to
>> BOOT_DEVICE_NONE since there is no u-boot proper in that case?)
> 
> mmh no, spl_boot_device() returns BOOT_DEVICE_MMC1, not
> BOOT_DEVICE_NONE. The point is that there is no U-Boot proper inside the
> SPL DA, but SPL can load it from eMMC.

I might not have written this down in the review. When I was looking over
this, I was wondering if running the download agent should always end with
a reset/reboot or if it is supposed to be able to jump to u-boot proper or
linux without rebooting first. 

> 
> Thank you for the review,
> 
> --
> Carlo Caione

