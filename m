Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A1ACA9ECF
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 22:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACEC380BDB;
	Sun, 11 Oct 2026 22:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bGinGh4Lzz8X; Sun, 11 Oct 2026 22:24:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DDEA980C06
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791757492;
	b=o/lCviWQ2lEig8y6AJy56dQbGPTntFtMlZ0p9ELZ2DpFPAUMK1z1LQtp9Vh9TPvFAIjK
	 0Jzrl3ZFKZs6SCAjFYj/TQp5ZMJCV51ou2r6DdLXv9WPJsd44nd5/C/rk9Bp5bFl62fkz
	 gBuxuA9hhzSVecVmEEd/m0l4Mr2xyIU8KFsSyBo/U5V8Tw9lUc7MUtPXMfoax53TLThKJ
	 S9/aiC92rgrGnYWYxXpqHd/SlAbLIDBZpXZTP+Rq4eYsjLS0vUn+eiE6VKFrrDmvYAuSZ
	 lfsrDAJZdiTKFYxU/7+8ocyJgMwClBzhwKth5YyQNAdvgiPF62UeWgtxmg79+n52pwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791757492;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=AgR2Gm3f7VY1OsjVjA5hx3nykWpSJaF4LXCi/k7giE4=;
	b=KSPRGuKG6SOsAkijSYfu1oXjyTS7t78IpknGPYgjF9i65hMAUwMIpz8KD2wTOr/fOYu+
	 NAeDSNVxWHBXn//gxLXoXbgf6R1P4smcaIUt90V8OY4GOf85uFYrO4e2hnTiC+P2c+bPL
	 A4kdDMJsOpTNmzcUN7ZT4Vpa9HxrFlM8Zw0jwlWb6gwIVt85o2kkcRU07T/Kqtw/DDsG5
	 sDLRKniJvZXTofpAzZrFjj0Xua/snCGzS6cI+xbkdgIlRCAZacpiRMRoRJsvLwLbib7tf
	 1BBzrNuH5yGS2Hs6hh4ZIhcpdG/zMoyQ2AKCOs9R2aMIN0RtMpUEdPr/WnKg9JKOTsw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791757492;
	bh=AgR2Gm3f7VY1OsjVjA5hx3nykWpSJaF4LXCi/k7giE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RpbBe2rYZZ0zN1a1v3JiFFTNbxOJ11V0N4isflxYP5Ww4K/G8u9tn2K89CaUJKoCT
	 rroBTJcB/Wv5A+79QwmVeOuTA/5i90AH+HCZqS9Of8yQAOn4o3KPgJ6bJMjNxNLQ/h
	 mjUhhztcyoLuePfzg06UeqgvO4iLEV4oZDwybT3nwGsggkMdJonRN0XJJX1gd/DlLS
	 AOywv3GdptYlsfceu7tOj3fmL9xxfvEeMhxHCuhZRbS1SHwN662yb+eA1KUMzpTlMT
	 VxTqSRMtfikPU57TGpqqA80i5ppO53+BZrxNhp/TrbLrZ9QpfS3y3Su5N4hZOf1Ea7
	 BRFWBw594WS4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDEA980C06;
	Sun, 11 Oct 2026 22:24:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5323175
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4494940587
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:24:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2BisqdvbgQV for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 22:24:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 50FE04056C
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791757489;
 b=CD9PeK86oCk9jkD28nhAxz6SywtBa/omg0F0Qd1BKzcRibu0Hqs4mJdxrmGElCUa00bX
 4Dp/jwjD38bBPQWS4qRw9intHc25qByFrjdC8uofncWQcLvd3X7a7/3SX9wF2f46/XRJJ
 Yq0tUhOw0eVbYQS/cid/rSs4+HvOuOa9h7MSfwI/tAUmSAgqNebfbwlyI23Qbxobx457B
 NqWk39rG3dPVS91wym3JO1cghLbQjiFXzTr5GEndzzQKuWbETLpJ9ATf0Ve2JBzZ1MN7+
 g0JXtL4ox0YAYkbFgtH59LJh/zYwsusulTwhs98wfKX+pDABEN0xwBlIH9NfypaHJKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791757489;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=AgR2Gm3f7VY1OsjVjA5hx3nykWpSJaF4LXCi/k7giE4=;
 b=Z+eCo1VwYXVVJ53JUNCuz0GQjT2ZStDMZgF/v81RfZ8LwWUsgXWWp6ZKEL783TZMcH7y
 tbKBL5blmLNUN2UEx1yOXTTPEomDl0tm0Gn1QP36iImVjiHR3gKdKo/emae8ZoTa+Ntiv
 KiuzcMBHtndNqDvRkL0GgqhazCOJKuj2TKxntTwXaUdHiGWAjFfQFW5nK82jvDv5ztxEt
 4MsPbxvul8QM1i9Alif8z6rzABpGNDKc4D2gmR3dsNqlzkIXK4rOLRqavHdlcgKjFKfYH
 /PK2ydTjIrnKnpthFb2Cn7IoAOckO+O5tEl6Xk7rGNhqrXnGEIt9/redCh8kUrgzD0A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=NJm5Jwei; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=NJm5Jwei
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 50FE04056C
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 22:24:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B32BB106AE6; Mon, 12 Oct 2026 00:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791757480;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=AgR2Gm3f7VY1OsjVjA5hx3nykWpSJaF4LXCi/k7giE4=;
 b=NJm5JweieJ7pDiEf4leUiRf1Z7jz9VG8EKzV1hpxWT+ROoD4S0qWUw9NQnvVOviu6Gbhev
 0+x/Pa9LMTX5glEvuYFg72gHM9boAVtmih4N/oCH9tFjsiOgMyXqCcUGfd/mbUiDWDw4sG
 qYNQGLB4QPAhrnRUdqkdh0sRc48aAW1HiEZxuUpnprU3/H5Jy+F2URcj7eYEMYysaUlpAl
 S7ktniM4paqn5ZzWFW0IFstdMFHjcJ9vfMMNc5ebPYF9Llm5xZk6g27hqKaPbXnl0tLNJm
 K1pYRdmgOd1T5Q5NWj8vXpScRzEGZPm6uOrDbbBVyeEc8B6YEtrTubbYwvP0dA==
Message-ID: <489e6811-cb25-4085-8077-427100154182@nabladev.com>
Date: Mon, 12 Oct 2026 00:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: stop generic OHCI and EHCI at OS handoff
To: Tom Rini <trini@konsulko.com>
Cc: khaliforce <kforce@gmail.com>, Romain Beauxis <romain.beauxis@gmail.com>, 
 u-boot@lists.u-boot-project.org, Neil Armstrong <neil.armstrong@linaro.org>
References: <179128521948.5.12131679420803093421.uboot-usb@gmail.com>
 <3ae0a18e-0fa5-477d-bf5e-89072b9634ba@linaro.org>
 <20261006155833.68374-1-kforce@gmail.com>
 <20261006161015.GB1356209@bill-the-cat>
 <e4661500-74e4-4bed-b09a-a54d24eb6062@nabladev.com>
 <20261011220316.GJ769217@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20261011220316.GJ769217@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 10/12/26 12:03 AM, Tom Rini wrote:
> On Sun, Oct 11, 2026 at 05:16:41PM +0200, Marek Vasut wrote:
>> On 10/6/26 6:10 PM, Tom Rini wrote:
>>> On Wed, Oct 07, 2026 at 12:58:33AM +0900, khaliforce wrote:
>>>
>>>> The generic OHCI and EHCI drivers provide remove callbacks, but do
>>>> not set DM_FLAG_ACTIVE_DMA. Their controllers can remain active
>>>> when U-Boot hands control to the operating system.
>>>>
>>>> An active controller may continue DMA after the operating system
>>>> starts reusing U-Boot memory. In particular, OHCI may continue
>>>> accessing its HCCA.
>>>>
>>>> Set DM_FLAG_ACTIVE_DMA on both drivers so their existing remove
>>>> callbacks stop the controllers during OS preparation.
>>>>
>>>> Signed-off-by: khaliforce <kforce@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> - Use DM_FLAG_ACTIVE_DMA as suggested by Neil Armstrong.
>>>>
>>>> Retested on MangoPi MQ Pro with the downstream D1 port based on
>>>> U-Boot v2026.10 and Linux 6.1:
>>>> - Read a 64 GB FAT32 USB device in U-Boot.
>>>> - Verified a 4096-byte read against Linux using CRC32.
>>>> - Booted Linux without running "usb stop".
>>>> - Confirmed USB reads, Wi-Fi and SSH after the handoff.
>>>> - Observed no panic, Bad page or failed services.
>>>>
>>>> Standalone builds pass for RISC-V64, ARM64 and ARM32 on upstream
>>>> main. RISC-V64 QEMU boots. Checkpatch reports no errors or warnings.
>>>>
>>>>    drivers/usb/host/ehci-generic.c | 2 +-
>>>>    drivers/usb/host/ohci-generic.c | 3 ++-
>>>>    2 files changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/host/ehci-generic.c b/drivers/usb/host/ehci-generic.c
>>>> index 1ae3619ce25..57f1bcbd9c0 100644
>>>> --- a/drivers/usb/host/ehci-generic.c
>>>> +++ b/drivers/usb/host/ehci-generic.c
>>>> @@ -167,5 +167,5 @@ U_BOOT_DRIVER(ehci_generic) = {
>>>>    	.remove = ehci_usb_remove,
>>>>    	.ops	= &ehci_usb_ops,
>>>>    	.priv_auto	= sizeof(struct generic_ehci),
>>>> -	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
>>>> +	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>>>>    };
>>>> diff --git a/drivers/usb/host/ohci-generic.c b/drivers/usb/host/ohci-generic.c
>>>> index cc44226f5e0..7493750f8d1 100644
>>>> --- a/drivers/usb/host/ohci-generic.c
>>>> +++ b/drivers/usb/host/ohci-generic.c
>>>> @@ -110,5 +110,6 @@ U_BOOT_DRIVER(ohci_generic) = {
>>>>    	.remove = ohci_usb_remove,
>>>>    	.ops	= &ohci_usb_ops,
>>>>    	.priv_auto	= sizeof(struct generic_ohci),
>>>> -	.flags	= DM_FLAG_ALLOC_PRIV_DMA,
>>>> +	/* Stop HCCA DMA before Linux reuses the controller memory. */
>>
>> HCCA is communication area ?
>>
>>>> +	.flags	= DM_FLAG_ALLOC_PRIV_DMA | DM_FLAG_ACTIVE_DMA,
>>>>    };
>>>
>>> Ah. Perhaps this is also what Romain needs for fixing the problem they
>>> see on an Apple platform, and would be more palatable to Marek to apply
>>> generally to USB host drivers (and switch the ones that use
>>> DM_FLAG_OS_PREPARE today?) ?
>> This works, but maybe we should instead unconditionally call usb_stop()
>> before booting ?
> 
> I believe the answer there is that we have flags to handle this problem
> generically rather than hard-coding a call in every arch's
> boot_prep_linux or similar like we had to with the old USB gadget stack.
This is shutting down host, not gadget. And I believe usb_stop() is 
necessary to correctly shut down the devices on the USB bus, while the 
DM_FLAG_ACTIVE_DMA flag is necessary to shut down the controller, so 
both are needed.
