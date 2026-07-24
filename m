Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6451C531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 04:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE90081107;
	Fri, 24 Jul 2026 04:21:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i0IHWpzyPNsj; Fri, 24 Jul 2026 04:21:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B91F1810DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784866905;
	bh=BmwZKy1Qc38eu329GkYb7ZKU3xzqgqb94NoO41I5iew=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=HiOEEuvXk6WAX3CJuKxe5yeh451iNvL31b9taLcyqnNRhnmm/S1SqU4m2fpHUTzr7
	 X9OTkpnqb9ODa1P9drKW05PbrpDPQUjra8t5os2NBBLld9YfdsUiaoXemH5OlFg4k+
	 idfIwlf4QMwIx2IgVxDMtIIEn3FZwMNJwWCbDJNaiTNQ453HGonfbMZmVHcU9Vpmg0
	 SiP/JyWqYrGksulY5Ti5SmXqoIbhnQPWKTwip2JHum0p8xESSFosN87zYdbhnCLVyi
	 qKbjjA2DnxYxjSLHHLeaLU6YqE8xX6twqvvnvgyZV9+fqKJyNNc36P0H7wI5EUPurt
	 dc+wAa7KS7gmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B91F1810DD;
	Fri, 24 Jul 2026 04:21:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB7FD490
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:21:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1E83810DD
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:21:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mmmgzf-Ktfd6 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 04:21:41 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D0A98810D5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0A98810D5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0A98810D5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 04:21:40 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26DAF800AE; Fri, 24 Jul 2026 06:21:39 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E7480117
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 06:21:36 +0200 (CEST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h5vvN4jWjzMlDd;
 Fri, 24 Jul 2026 06:21:36 +0200 (CEST)
Message-ID: <0c11f834-7b7a-4e94-90b3-23de79040b4a@mailbox.org>
Date: Fri, 24 Jul 2026 02:00:08 +0200
MIME-Version: 1.0
Subject: Re: Regression on colibri-imx7 due to commit 9c1b13b3fd27 ("cyclic:
 reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
References: <27d77997-2651-423f-ba1d-652d5a133e39@gmail.com>
 <23084e8e-ad4c-4f37-872a-9d2a8feb325f@mailbox.org>
 <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
Content-Language: en-US
In-Reply-To: <140e540b-08a7-4fca-a6fa-ee398d92dbea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bz4wkzb6rm8i8a43us4z5rwbbh9hmqbq
X-MBO-RS-ID: 679a1400519d82c0e0a
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784866896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmwZKy1Qc38eu329GkYb7ZKU3xzqgqb94NoO41I5iew=;
 b=OhGljrcq1HufBb6FLEKO9AQRp1UVWSRWAZKvDwaSDs9rrXTubKcol1CdxG/GVW20ui+PQX
 FzmMERWXHtJVMv7DOs7xhhMvMqXDwgBgDbF13CWhgKVGqcnoJj8w7v7qJ0WCPgmm6t5J9q
 pfZZx49jMh04vt/dY9oZbH/DlTF0N4xc1s3FVB5ixr7wIQV2js2xtlcTV0JFwija7FaywZ
 ovdlF+SGs0lQ6XwGP254eTtP2JWc7iKlpAYdAGjpnj9iatIp929JKoqECMfpWLFFJ5MWHt
 UXO2XwjGH7ystkQX89GSbwVlAzPV+Z4V2qzH2NkfBdtFeJECbJO/hYlxsiyPwQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784866895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmwZKy1Qc38eu329GkYb7ZKU3xzqgqb94NoO41I5iew=;
 b=l15Aa0/qfWraxfS6qkdll70YxH1U2B7X2+vcO2JXqI8MiNvNpNfxN6oj/lMrNKIA5F0gTi
 hHCJmDQXFlcBTeqivoDPiriNdRDwte2qD278+CB9xs+qz1yOUKP1OOYDuFLIaDro9exaHY
 YxeiUXpNILRPtGgtgDDxg4LoGqO8EqwuT8sbWyKc5KGXN4wAa94RT/9IbAxHv/Kes6vpiO
 eBgAT5knm3YHDnFhQnv78kFPNEsWuFLkIMvV1yTdc1ZF+oJ7LKUsT4RjBGk4EnipQw+cLo
 rRR7j8ZUpnr58ZJkFZLyEXK74ZuQPGxHdbiKnHeAoe/F7hhSpOwhwggiS+OlMw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=OhGljrcq; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=l15Aa0/q
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="OhGljrcq"; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.b="l15Aa0/q"; 
 dkim-atps=neutral
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

On 7/23/26 10:41 PM, Emanuele Ghidoli wrote:
> 
> 
> On 7/23/26 20:35, Marek Vasut wrote:
>> On 7/23/26 4:53 PM, Emanuele Ghidoli wrote:
>>
>> Hello everyone,
>>
>>> I found that Colibri iMX7 no longer boots when commit 9c1b13b3fd27
>>> ("cyclic: reduce get_timer_us() calls inside hlist_for_each_entry_safe()")
>>> is applied. Nothing is printed on the serial.
>>>
>>> I bisected the issue: booting the parent commit works fine, and
>>> reverting this patch on top of current main also restores
>>> boot. It's not yet obvious to me what in this change causes the
>>> regression.
>>>
>>> Would it make sense to revert it until the root cause is found?
>>
>> Give Patrice a bit of time to analyze the problem.
>>
> 
> Hello,
> 
> after the regression, get_timer_us() is called on every cyclic_run() call,
> even when the cyclic list is empty. On imx7 this happens earlier than before,
> when the timer has not yet been initialized: get_timer_us() calls get_tbclk(),
> whose value is zero, and uses it as a divisor in tick_to_time_us(), leading to
> a division by zero.
> 
> I would fix this by ensuring get_tbclk() returns at least 1 on imx7, but we
> could hide bugs in this way. However, this bug could also be present on other
> architectures, so I would just guard against entering the cyclic loop by
> checking whether the list is empty before doing anything else, so
> get_timer_us() is called "at the same point in time" as before.
> Something like:
> if (hlist_empty(cyclic_get_list())) {
> 	gd->flags &= ~GD_FLG_CYCLIC_RUNNING;
> 	return;
> }
It looks like there are two topics -- optimize the cyclic run and fix 
the MX7 timer.

I agree the cyclic run should exit if the list is empty, but please wait 
for input from Rasmus on that.

Regarding the timer, how come the timer is initialized so late on MX7 ?

The Cortex-A7 should have its own ARM timer, that should be available 
right from the beginning. Is that ARM timer in use on your system, or 
does your system use GPT timer ?

Which board is this ?

+CC Peng
