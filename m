Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48475C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 439B960A6C;
	Wed, 29 Jul 2026 05:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZB-HgDKdw6qr; Wed, 29 Jul 2026 05:03:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D7AF60835
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785301410;
	bh=7rlFc5VkJC4MX4aOJlpwPC/wZyOpM+R+aK8ObWisnNY=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Mi34sFAY7J6zlPLtDa71r1henmR76Wq8c6RAQfjiR/lyt4z82OEDWdjZ5DOgPxLOL
	 cw6QJ39ZYAu4KTAoXCmEMUKLhwUDw8uhOs8QxVdr5HpmxYfpOAqVwy0WPRz1iLPx8p
	 qAArV+1a/+5h27bHe9og09cLe0aemKFV4o3qAI/IFiITmUsJRnS6R7/Dp/bWyi7jr5
	 fpo0pbgL2mmwZD3ld49jGF2r28DOeFOdThWfHwL5pgu2fGD7VVEEIWZ9f1qtpTny1M
	 b1LslX6dgV4/NKzD8p2w04fpL+UAXO8cJJT6kEsdJ1enHtuVyIBQ/glu7c00iiuii3
	 fpmlRFvhVZsmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D7AF60835;
	Wed, 29 Jul 2026 05:03:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9D42C2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:03:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A72F40232
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:03:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wqK2eS5nuBYo for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:03:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B35BC40231
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B35BC40231
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B35BC40231
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:03:27 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h90bJ4MmtzKvvC;
 Wed, 29 Jul 2026 07:03:24 +0200 (CEST)
Message-ID: <89b46c91-ea30-4043-84cf-56c1d0fbac1b@mailbox.org>
Date: Tue, 28 Jul 2026 13:53:43 +0200
MIME-Version: 1.0
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
 <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
 <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
 <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org>
 <a164c15a-9331-4361-8a50-692e9855512a@gmail.com>
 <af758a22-b8c0-470a-90b8-a3ea92db1783@mailbox.org>
 <ee20cf64-0541-4d63-b00e-6c9ac5e2382b@gmail.com>
Content-Language: en-US
In-Reply-To: <ee20cf64-0541-4d63-b00e-6c9ac5e2382b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eqitkobqwm7f86ah5rfq57dgqpr5sfjo
X-MBO-RS-ID: e616897ac976bce4923
X-Rspamd-Queue-Id: 4h90bJ4MmtzKvvC
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785301404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rlFc5VkJC4MX4aOJlpwPC/wZyOpM+R+aK8ObWisnNY=;
 b=RXW9SK+erQVT9v/+jMQjDPN/f4sbEIda0nSC1xBC3UQZYHbVDypHYUvVCtweq2wtFLTJiH
 5cDn/+iNzsEJDBLYpaJnFcVrE82BsL1iJbd6b4B3TRm5JD9P4NDVlWV+TDd0F2hHjzNMhX
 c2tq6jYFJ03SbbE0jv23G3J8RxGtUMmC8fifcG9WFmoPhz7lSV0XkZTxLKSXs75WlPGVyY
 7V2B3okAVbm3NSmxBJ4eIelzqGh1hV6PROjK4YDkXy1IoZZTDoVDlmcIxoBT7ZWNuBPPN6
 UMARphnkT8GkmDeLQF7AZP54QcpTgzPdG3bQ9Ui3dXaTmsulvJ1iRZnyhsyhOQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785301403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7rlFc5VkJC4MX4aOJlpwPC/wZyOpM+R+aK8ObWisnNY=;
 b=DU71zaiBivIs0sdZDNz8YouDF+VfyldqZG2g93fS8J/YjeNJcQzl+ogR+y9jnpNa3cVwby
 RGlJHSPiuMEDtgPntQfKXN2Ay5VhnfinXtj149+FUUN0lHF5ZzRfBDkReDt0r4SSEAWWXa
 8nxUHbVYXEANHGZGZUse3mSeezNK8X/5O6R82K4SISHvJBEt+h2GPUlGctErgnewwec58t
 rNsTfChKTnhVrhYKLDuORPdFyk8vNoXOtbhv/fs9/jM4aQs7JoxFX68rYxZBTWiCLxxlbO
 o4XhUdNFxDjs9/0A+DSp9HsGgIuIDq7pTwl4kODvgSlAqqrU8evq8aiWZ+4kvA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=RXW9SK+e; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=DU71zaiB
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DU71zaiB;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/28/26 11:46 AM, Emanuele Ghidoli wrote:

Hello Emanuele,

>> +void syscounter_init(void)
>>   {
>>       struct sctr_regs *sctr = (struct sctr_regs *)SCTR_BASE_ADDR;
>>       unsigned long val, freq;
>> @@ -80,6 +80,12 @@ int timer_init(void)
>>       gd->arch.tbu = 0;
>>
>>       gd->arch.timer_rate_hz = freq;
>> +
>> +    return 0;
>> +}
>> +
>> +int timer_init(void)
>> +{
>>       return 0;
>>   }
>>   #endif
> 
> Hello Marek,
> thanks for the suggestion.
> 
> It works, build and tested on Colibri iMX7.
> 
> But imx6 is obviously broken:
> /home/emanuele/tdx/u-boot-build/u-boot/arch/arm/mach-imx/mx6/soc.c:441:
> undefined reference to `syscounter_init'
Excellent, could you please submit this timer patch as a proper fix / 
patch ?

Thank you !
