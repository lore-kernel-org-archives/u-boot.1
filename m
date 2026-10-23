Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F98606A320
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 07:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MIw51lVR;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=u3V9AGst
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6A8B8117D;
	Fri, 23 Oct 2026 07:11:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whwtMMfkv-tw; Fri, 23 Oct 2026 07:11:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 86C2F811C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792739488;
	b=rzz0EoMwC986W30AAojVUAW/Jr6PX6bhYy3QMbCA7hftvwZyI4knrmrfv8MsQpRPJV6r
	 vU2f5M0T8qDtJZJSbzoLG87kc9CDWF9SGHei88aU1CNG5wpwbMKiA8Zh2Mw6+uS55prh9
	 eMGxARBpZOx7fHGFp24AEanDkc0Lc1OtC6LVJSlol6QJkFw5rnPqTpdEaAgTzXjBvNPY5
	 HFfCHn8r3WF95ZfvhbelxfB8+G5nhLQDVYTGsd6mejSrDgt0XlGryvQ52mNwXTO7XrvJc
	 ozGMjau7Q0vww1yRddGYIquTikwq+s/6UlusjyECxG6yHvrPB5wkGQdYzDezcKk2xmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792739488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YWpzINPi/otm8RIQMvCG0YddQVUgMfmCd3Rzc982w3Q=;
	b=hhYsCIgYXJGSXDwdIo+BKAToaNgO33Gc7Tf+sLemG20T4BHtdFeMFZXJE+LrKnLHJCZM
	 W964P9R8MwRob456SFXFMsI32+MXj3Tr22g4+1X5CTnavr/Qko4aFPn1y1xr+WgQL0vwT
	 cnmEa26Pz32jK+vKsJmAtMLVGzd8Ia0+7HLTjfg7ha1g1tRZCTfMThSAuSGdx4c83ER8O
	 ltZ2K4lq4aI+Ho02E9Sje/FshNO2Xhuai83+4ZugMY8uL4k+6BUWqopRJArWW4tF8SlQk
	 fbHmDDFq/TSbODKDjILvdDOx3ssTksZf7inLvXqCNkET2CThMu97rPWRzZBCe9j08GA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792739488;
	bh=YWpzINPi/otm8RIQMvCG0YddQVUgMfmCd3Rzc982w3Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MIw51lVRt+7/r7K41xDV103ivaewFEqvQmfZkYXSiD+TNr3DjRscCG6kUa7dLJCZM
	 QH/x+hdSjwCmyKwAWhtbGMK305MQSzlFOiRFmq6XJWPIPPNTYnBNETyalZS+wm3Q0D
	 UJ0JOmMIZqodWlOVN871/rKXPmAAxbKPqiLU+TCGurrvzwUSS0dXq49O4sY9CtKHsO
	 OPaQ/59nMmjXw8z3QGkLPYnWRwmyMCMbvB83c5/R3TYN/BLyw91JGUtJ/y/JrBZiSA
	 1g/utc5fzy/nSnLlJK4Rq6GKuof1Dt6XibbAclv/8gV9U2f677tLlyTYl7p7ysqJX2
	 vY9xcKD5IXg4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86C2F811C1;
	Fri, 23 Oct 2026 07:11:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E9B049D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:11:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2012360665
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:11:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cpa14zNJ3kuy for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 07:11:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B753F60660
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792739486;
 b=OaUBJIOIPZm3/5aV+2QlTI7N4J4IfbmbOU/qxV6jGkfhHL0tH3UjklhuygPT4RcHqAfS
 uxDmvpyjwrX7QR9PyDWcmqr6FZ9F7nTOiaP0KQCgX9UV4PJeFOgOXyJ4nFd6YBNmu1agZ
 WdJD9ttivztk8HyWp2nRTioJUI5kmOqvWtSYVpZrSjaIv8oZO3bt83FTtPjpWnSxOYvf7
 u/MGGeluxarqZ/YI809e//+XMOq5NoZgU4clj1lfjK6kYEyDZMouCfilgMedUJyJJ9f6j
 YHlwgRF5q3QRSow0r01FAHBiwzPZfQik/2ZJnqqgxxXDOqSY3GX9PncULsGfNZMjQzQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792739486;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:Organization:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=YWpzINPi/otm8RIQMvCG0YddQVUgMfmCd3Rzc982w3Q=;
 b=HdGcHTudyozx/ekR76SkgetGiR1wmlALspWDVwXI4pQA8Cn5NrbFj898HychvbRSzsbb
 JFuimoVR1HuT8q1prMuO6WDvvA9HUxo7e9IrVK0yVw89Yjuk3aBo/N/u6o/bMtNRTcpwP
 56gcCREdVGHLVO77e5CnAjdISnM2lVQCaU/9g6LepXuC0k48eUyAW/xSxlj8yBbLSFAXn
 fmyoyuEgne6JhI85ET/7QEZzGYH1XI9KDT/4gfLd+UBps8Q6kJjDNpRv5Fthx32cnx781
 VL2ONZw5tz8T0oooP6PspCWc+ThWlYCbUbWBkO931xAxMkPHHMJrS2eB9tc4jPI2P2g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=bootlin.com;
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=u3V9AGst; 
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=u3V9AGst
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B753F60660
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:11:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 3A792C5145F;
 Fri, 23 Oct 2026 07:12:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6EC6460398;
 Fri, 23 Oct 2026 07:11:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2FBCB10328F4D; 
 Fri, 23 Oct 2026 09:11:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1792739481; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=YWpzINPi/otm8RIQMvCG0YddQVUgMfmCd3Rzc982w3Q=;
 b=u3V9AGstm5l740RoxWyE2Cu3V9goQKZzrlFfhFtJb+mbixUhhc7HC2akOswqqevQKIt0J+
 C5CyHxzrElDVtuCwNHMM10XXh8sOaAsyCnyu7NABK4QX8vTNPiixKN8lRCuEagsz1evVBp
 qpL319vEqC+XG+fnBw3U/4iY4t+6NW+SBlm5RusUqMlEIC6lYUgQtqhGJr4Uh/2rRBMTsC
 ushDvjRSuz6bODb9HD12lIUxcgfhPfP/hqjQcsomNJNUXHKc2JqQwb0hnHozYF7XU238ai
 MwCdXz7fbPkhWDIxmmOEvW08JbpQ3Ch33N4hdJEXVUujQGJsRKSD0qQuNX/Mkg==
Message-ID: <afb22430-4cb1-42e8-9b22-5fc57eaf7625@bootlin.com>
Date: Fri, 23 Oct 2026 09:11:15 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: synaptics: add SL2619 SoC and RDK board support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marex@nabladev.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 Adam Ford <aford173@gmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20261022-sl2619_base-v1-0-ef20cc43d78b@bootlin.com>
 <20261022-sl2619_base-v1-1-ef20cc43d78b@bootlin.com>
 <20261022182920.GB3596691@bill-the-cat>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20261022182920.GB3596691@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 22/10/2026 à 20:29, Tom Rini a écrit :
> On Thu, Oct 22, 2026 at 10:08:23AM +0200, Richard Genoud (Synaptics) wrote:
> 
>> Introduce mach-synaptics to support SL2619 SoC-based boards. This adds
>> the platform Kconfig and build infrastructure, along with initial
>> SL2619 RDK board support and defconfig
>>
>> Introduce SYNAPTICS_SL2619, which selects ARM64, along with ARCH_SYNAPTICS
>> which selects driver model, SYS_NS16550 and GIC-v2.
>>
>> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
> [snip]
>> +ARM SYNAPTICS
>> +M:	Richard Genoud <richard.genoud@bootlin.com>
>> +M:	Terry Zhou <terryzhou05@gmail.com>
>> +S:	Maintained
>> +F:	arch/arm/dts/sl2619-rdk-u-boot.dtsi
>> +F:	arch/arm/mach-synaptics/
>> +F:	board/synaptics/
>> +F:	configs/synaptics_*
>> +F:	doc/board/synaptics/
>> +F:	include/configs/synaptics_*.h
> 
> Use "N: synaptics" instead to cover most of these.
> 
Ok.

>> +
>>   ARM TEGRA
>>   M:	Thierry Reding <treding@nvidia.com>
>>   M:	Svyatoslav Ryhel <clamor95@gmail.com>
> [snip]
>> diff --git a/arch/arm/dts/sl2619-rdk-u-boot.dtsi b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..a886ed7355ff
>> --- /dev/null
>> +++ b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
>> @@ -0,0 +1,5 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +&sm_uart0 {
>> +	clock-frequency = <25000000>;
>> +};
> 
> Isn't this allowed upstream?
Definitely.
Jisheng, maybe you could add it in the DTS in your v2?

> 
>> diff --git a/arch/arm/mach-synaptics/Kconfig b/arch/arm/mach-synaptics/Kconfig
>> new file mode 100644
>> index 000000000000..33282060a8e0
>> --- /dev/null
>> +++ b/arch/arm/mach-synaptics/Kconfig
>> @@ -0,0 +1,36 @@
>> +if ARCH_SYNAPTICS
>> +
>> +config SYS_SOC
>> +	default "synaptics"
>> +
>> +config SYS_VENDOR
>> +	default "synaptics"
>> +
>> +config SYNAPTICS_SL2619
>> +	bool "Synaptics SL2619 SoC"
>> +	select ARM64
> 
> Shouldn't this be with the ARCH symbol? Or are there 32bit cores you'll
> be supporting later?
> 
Indeed, I think it's safe to say that there will be only 64bits.
I'll change that

> Otherwise seems quite reasonable and I'm glad to see this posted,
> thanks!
> 
Great!
Thanks!

Regards,
Richard

