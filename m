Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34B6CDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 04:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB9EC86D56;
	Wed, 18 Oct 2023 06:32:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697603527;
	bh=s48ciO0is2SapIosG+RkAG7ghFYCFX5oVCYgHsGhqBQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=U2lynYJE2tPDfRaRthdFzNUtxFzOcqLMl5c6h6HbI0ohPh0Dicu81IF9RYkT969/9
	 zfXeQh2ElBQK12gBCY6czOf2/KEuf8GyErIqgCXXNQyB811vtle3can/abflGMGA6a
	 Jg8oJXaDIIqgvwtYij038v9endgF3X8KTG7rlOsk3qqNezDA0QfIA4Jv/KiZuoZfXL
	 3e7M6Eq0GN4qlL2jOL+WFwlF7LC0n6ZCh9L57UH/Z4x5/+fO6xXozaS6iSdzg03KO3
	 OZoASeKu62uOHGhAL+HFJqvhKQ7yQCyiMOVmwOsgJv/t/SaX2zGKWckrV7QcS4gpW8
	 wpzDokJpSv7vA==
Received: from [192.168.1.107] (82-131-155-145.pool.digikabel.hu
 [82.131.155.145])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9F28F86BF7;
 Wed, 18 Oct 2023 06:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697603527;
 bh=s48ciO0is2SapIosG+RkAG7ghFYCFX5oVCYgHsGhqBQ=;
 h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=gX/oAqkBDqO/7TvImyp/ZmHDUiJM+blUFCzujqXlJbfohZlASjn/b98c/wbP1Ntdi
 wOctJ//AKwQXJGrOvyI9clcSvWXBiOA6W6cLtyDXH/Ai25bPxrxngCmMEDG27KQZxj
 6ua8DmRIC8uqoawEz1IC1B/zkIf90WukBW6P4xvHiUDMUSk1bajjAZFy5/hgzAEifo
 nQvgah9b/QNmHLtcotYPFdlvvO5n3oMUGtvrS3YqV2kkOTn5QBuXIkmHYC4D0O110I
 u5QHYCF2v8SRGKuXU1SCxtGCa4Uky8jdjyIOlGPofSGT22Utg+j5QHRoeYjnuo72Tq
 ZKUMcniUYFdDw==
Subject: Re: [PATCH 2/2] bootcount: Add driver model I2C driver
To: Simon Glass <sjg@chromium.org>, Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com
References: <20231013094302.28944-1-pro@denx.de>
 <20231013094302.28944-3-pro@denx.de>
 <037dac45-eee4-c0f1-b72e-ee0a2bfe3807@denx.de>
 <ZSk-2lBrLW5Bel_X@eryximachos.home> <ZS6ET7ExtDSCfsNN@eryximachos.home>
 <CAPnjgZ2OZka03fG5Bt49JxoLn-VHy5TB81r6_uXTy+K5SOGYOw@mail.gmail.com>
From: Heiko Schocher <hs@denx.de>
Message-ID: <1ba8ea25-bad0-b66f-b189-67754c488103@denx.de>
Date: Wed, 18 Oct 2023 06:31:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPnjgZ2OZka03fG5Bt49JxoLn-VHy5TB81r6_uXTy+K5SOGYOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Simon,

On 18.10.23 05:33, Simon Glass wrote:
> Hi Philip,
> 
> On Tue, 17 Oct 2023 at 06:57, Philip Oberfichtner <pro@denx.de> wrote:
>>
>> Hi Simon,
>>
>> maybe you can give me a hint on how to implement this cleanly in driver
>> model?
>>
>> To sum it up, I'd like to have a phandle pointing to *any* I2C device,
>> not knowing which UCLASS actually fits. Then the device and the parent
>> bus should be probed/prepared such that dm_i2c_read() can be used.
>>
>> Any ideas on this?
> 
> I suggest a phandle to the i2c device.

Yep!

> You can use oftree_get_by_phandle() to get the node and then
> device_find_global_by_ofnode() to get the device.
> 
> This is expensive, although eventually I suspect we will fix that with
> OF_LIVE. I think it should be implemented as a new function in i2c.h
> so we can change the impl later easily.

Yes, please.

> If you want to be more efficient you could do something like:
> 
> int phandle = ??
> 
> struct uclass *uc;
> struct udevice *bus;
> 
> uclass_id_foreach_dev(UCLASS_I2C, bus, uc) {
>    struct udevice *dev;
> 
>    device_foreach_child(dev, bus) {
>       if (!dev_read_u32(dev, "phandle", &val) && val == phandle)
>          return dev;
>    }
> }
> 
> but honestly now I look at it, that is awful. We try to avoid exposing
> the internals of phandle because it allows us to (one day) maintain a
> list of them.

Yes, please not ... a list of phandles would be great we can than
walk through, yes, may in future...

May Philip can use uclass_get_device_by_phandle and try a list of
possible UCLASS candidates, like UCLASS_RTC, UCLASS_I2C_EEPROM,
UCLASS_POWER,... and if found, check if parent is UCLASS_I2C...

may not so expensive ...

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
