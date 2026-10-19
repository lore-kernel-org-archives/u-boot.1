Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BA4CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F5AB40607;
	Mon, 19 Oct 2026 12:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IkXosHqYT1IN; Mon, 19 Oct 2026 12:16:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1AE7740583
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792412200;
	b=UdHy/H9YxYIRHRdIwuLmDr6TCg961CBp/FuwWqVap7JXShulzr+jwECCnPxFj3GskPne
	 Bybs+Q+baTXmwQP0fVKUluiICyFgHfegfdYnlabRkbhN3/xgFDovZMuHmBiuEACEn2khA
	 +F9zVjPHHEFNM1QQRXkmICcu2Fuho2o0JD8LzX3IARyMj1y7JqGblwnMtx5rWFjDte0bF
	 a2hhR0vz43oMeeeNgy3L/E1XaOGFVQWaQ+QtgSywew7Iq7miEfpJwn3H0TutCDk0gwt7h
	 Octb1iLpjMrO87qECHX0RbHby57VoUS0njjEd9tQWnAmqqLF4Uesv88a6E20psJvRRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792412200;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NHqS03EQf6rrNAQw01CSXsMjZizt84VWUbSfUoe6jNk=;
	b=IgkPjWAj95U0JfyyTJQpH4mivFnROX77vGqLgt5FE5yLjYUYqDuy3L9jS4UawSPTUvHp
	 4WQpr+jslV312ZRNk0W6yci0WsPKZ/NbkP1XxIWoZHjb5gLz9LQjNkOcCR8IHdn8cVVEf
	 CNJO+2tmRhVW6bWxkz6XMjx10izVf/vmId+s8wfqMBaDjbjGE5PapALYEoKgAOxuRNRle
	 +NszXWZD31GtUR3EbYFT921jlBOh0KZ80E69PGDeXcb4FSgQBWUFVSTsxRgdtyo33Xewv
	 YDQMatXzOE1ED8EpoY/BZrSOz7v62V53jbbfSLgB+WY5FHES6lTzYrPAAoowCR1y5sg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792412200;
	bh=NHqS03EQf6rrNAQw01CSXsMjZizt84VWUbSfUoe6jNk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=omMFr9ZIkgP6XNIhXPrj/l+zK6yhPL0rr6q4TrDeBtpqYfit4tSBWZsOHFsVOl0El
	 oT+PC/IIJz5gwbxk62Ik245ox1lrDZl+X/1EfUf832Yhqt/4cg3fgii1eF9b1QDwlQ
	 PYmzgFXydPK6iUUn9adiAc/erSgPaOQcIUiYQJh9FaEUI/lts1VYHgPl3mzxlEI6sb
	 3VgP4gjVc9xwF9RgS7Hymb+yWfARvZr8hNLC86dNVQLNmg2UHUN389b5dFhlo7ob9G
	 Qh71JvQZmu4lm7A2724AclCWCHPe3MihXy0NjDxn+Mkw+LnHz7rna0G09h9k8EJcCL
	 ThfzsiZD8j8/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AE7740583;
	Mon, 19 Oct 2026 12:16:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 061F3279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03A1B80DAB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:16:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 66fVCSaYujwq for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:16:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6986D80DB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792412197;
 b=isvp8cx53OuGbq8YWLEPTi+fPJ36TxoHpf3fHEKrUjDlTZvgK+GpfB2xPvprcZsiSc6S
 VTjHNXICOCXTC6ZSVhGgTwRLo8dzxB32THwZ/QA3bTSCLAzIPrivsLSmFGg1vxSJ2Nu49
 fDW1B6nn8ci1+JqsV3AmFGRNtvotTVhA/Op9o0hgPXjqOWIWvF8O0F97Vt4X8GslaNum6
 f4+WLYescSI4BpLrzPCGJkXD7nk/qn2g8OrygzfP3J8gKqPUjOEXGrscM1vMjAsWWPXye
 STQHCP2A+6WKSLWWEF3L3roB1Tpu4hHipJazh4h+wfOs2rIRDvdiK1Rf36hsspFuQ4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792412197;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=NHqS03EQf6rrNAQw01CSXsMjZizt84VWUbSfUoe6jNk=;
 b=m1QU3nGRlkWfrqrSNWO4jJ+GLRvuGuDNW22e+HuPuvvL6aPzzVAQar0wWUbA8Fwhm8HS
 vWa25KmarqopO1zj45lTTnaljiC0wubxo8ChjElr8Q+Ifpx6bHjIZxsKugQQrHMBUJi/J
 CSHtNs6wgYq/98/OEhhvGFzM6xCr2QUT8qzY2S6EM3z/sXRc5vSM3kgguOsmcz1hdPNJN
 pr9cM1H5d1LHCKZ53mPll+Wbhd5a/3AfpQH2LXiWjMXIt+9RZLPVPoBgEJ6fAq39sjJbT
 ajsTRqXt9cDLBeCfCG60e+l43OiZlopod0OzsAMNgLCodxVtDjVYZMptZXB/phQ4HYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WHqJBWKA; 
 arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=WHqJBWKA
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6986D80DB1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:16:36 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DCF881A125E;
 Mon, 19 Oct 2026 12:16:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AF7B260582;
 Mon, 19 Oct 2026 12:16:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7C97710328BE3; 
 Mon, 19 Oct 2026 14:16:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792412188; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=NHqS03EQf6rrNAQw01CSXsMjZizt84VWUbSfUoe6jNk=;
 b=WHqJBWKAcedj/InZcjt9apUmM/fZy/jJDbmleJC6QOuogOHkkwAbbXSrjIDWIfv1jjTQk2
 4wVEa2LfV5Ap/RbUvzGAuaLpsmoWnKaKNDICeVtLGW+pRQdVFOsIvLPAb4IcTQYSJr8a21
 f2tAplIWulyxD6Shvg3wVhu40SEr3WIAcmibu6271PAsmC9s4EiuOvsWZcbknC8pqpprRx
 jxhuqNS0GZvOgl1HVuNc1Qw0XojUU51lQngYVW4zK2seMm1Q/GBUEGIIMGk4GAdwEoeztM
 ZZQjnl9SPYMopCfIFTV/iu5TrfFffhJwSIrpXpELeGCGM4zSduS6sURFXeVGiA==
Message-ID: <747b779d-e24e-4a5c-b6bf-760948d5c313@bootlin.com>
Date: Mon, 19 Oct 2026 14:16:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm: mach-k3: j722s: Wait for TIFS initialization
To: "Kumar, Udit" <u-kumar1@ti.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Schultz <d.schultz@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Aristo Chen <aristo.chen@canonical.com>
References: <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-0-c7ab53f79b34@baylibre.com>
 <20261016-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v2-5-c7ab53f79b34@baylibre.com>
 <be2d29d7-0ae4-4110-aadc-b418e4a7f96a@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <be2d29d7-0ae4-4110-aadc-b418e4a7f96a@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 17/10/2026 à 04:40, Kumar, Udit a écrit :
> 
> 
> On 10/16/2026 2:35 PM, Markus Schneider-Pargmann wrote:
>> On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
>> the firewall on the registers at the end of initialization. On HS-SE the
>> U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
>> leading to a race condition. This leads to a broken watchdog since the
>> signal configuration doesn't succeed because the write doesn't take
>> effect.
>>
>> Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
>> ctrl_mmr_unlock(). Note that spl_early_init() needs to be done first to
>> setup DM.
>>
>> Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
>> Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
> 
> I have tested on J722S hs-fs and hs-se devices,
> Post this patch wdt reset got functional on hs-se device.
> 
> So for this patch
> 
> Tested-by: Udit Kumar <u-kumar1@ti.com>
> 
I tested it on my LPM series with j722s HS-FS, and I still need a 
ctrl_mmr_unlock() before spl_early_init() and also another after 
k3_sysfw_print_ver() otherwise querying pmic fails.

Regards,
Richard

>>   arch/arm/mach-k3/j722s/j722s_init.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
>> index 1180c75f551d..c15b3b2682d9 100644
>> --- a/arch/arm/mach-k3/j722s/j722s_init.c
>> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
>> @@ -84,13 +84,14 @@ static void k3_spl_init(void)
>>   	 */
>>   	store_boot_info_from_rom();
>>   
>> -	ctrl_mmr_unlock();
>> -
>>   	/* Init DM early */
>>   	ret = spl_early_init();
>>   	if (ret)
>>   		panic("spl_early_init() failed: %d\n", ret);
>>   
>> +	k3_sysfw_wait_ready();
>> +	ctrl_mmr_unlock();
>> +
>>   	/*
>>   	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
>>   	 * regardless of the result of pinctrl. Do this without probing the
>>
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
