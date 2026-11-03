Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E7606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 05:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zp+JXzTj;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=EZa/EbI6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AE8A405E6;
	Wed,  4 Nov 2026 05:09:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QpDV3Ol2KI3N; Wed,  4 Nov 2026 05:09:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E2C4F40478
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793768969;
	b=tD+IVhqdqyFQ3UnP9ygYLgLWpvS9eyKVR4olT6zq/70q3agFZu+IBvPKkAzBS4OwmLPq
	 oBQWut0pgJsMGbffGPnY2ry/5YM6N3M/R8LOlche3kITNG93TtvpUynd6Qk0cKT4MV/hj
	 KtSqwtj62yFsrYk+07pcYVkpAz32ID3dXnZ2WwdQnDJP8BGpMj7UHpApFNG8qsT96TWgg
	 xjzYRPUQgoAvM0BlO3iY5cxm2QXAWWX8l8Nk3JoDYu12jEYi26NrAx3PM5LOBpvvyNkJS
	 5HzrwjrWgXVVxjpSUEuFUqqs7ehWi2vIFnaPVgMPF7/CBUBo9bdg7MHrxm2IDiMU4Wg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793768969;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/Qq7ECXd1UGnT6ICmT8ykHZyGbTC+95konjgXmsmmDc=;
	b=NGWsgFOEhDZmvviJizRw7TPzFXDrHKMQ7f2/PI416CdmPELuOrfMDp1BhHbO4X0RqZ0G
	 ZvjAvfv8vGMyh7utLDmGnaFBdeUacmGaJycBxUSoDWWTw4hADef6R+3XU8+pHL6+rlfbS
	 ROSEok1++dwZnUNdkQDoKGXStccqf4JKB65tR6x3BBjrgKphY0Iv2Hejn/K0uvCGKkJ6O
	 vLwd8CFqeANYDvITuOmnb4BGhMkyrCNOQdJlfE0uaabKwOxkGEJCqFWVaul9eZ9qJ5FK/
	 qGA3Cre0G4nudDU1Vcg89cfoGfJcjS2VoeLM1z5hD/nHIHVFEvjYPXWt8IPKPCBF8Ig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="EZa/EbI6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793768969;
	bh=/Qq7ECXd1UGnT6ICmT8ykHZyGbTC+95konjgXmsmmDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zp+JXzTjRdp1PCFAc+EZPUbq0E2Y37Zt5OwLlvKQ6CTrN8/fMw+pzs8TGa1xvM5M4
	 BWCIz63FPX8h/epnuri9b/Dcy5YkD5W+ANDTZZU+lGuyvYNaQLjuLtQ2ziyN79AIZX
	 mwdeOmzOjRUIwi/AYnZXVNQp7h1Nkm/5vTYALNVqswEnZpxUkRr4B5GxWnbPempVW3
	 Pd2X1uCHaowugq79MshG/+fs2RIRIgoPJr6Uy5SVyFQ6h+Q/WRwAGjRKu70ZqW+Lv+
	 Q6TJ1uTmtYc1CEhbDOGUZYYawtbKWBIELZ4AIxGyEv+ufLpvv49CuAQ78MKT4sreiH
	 V3HOXBdoDc2mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2C4F40478;
	Wed,  4 Nov 2026 05:09:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EA142AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8437A40478
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AxfT5JNsn_cK for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 05:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08E664043A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793768964;
 b=H89X5ikKREK22BObucrmKz0Q8e5kRQTGeAGu0Hmrm8Fdp7xXMg55yIbsNYJ3vGaVNtL1
 YCUl3DigBK9XDZxO4b4sUE0zOVbLqbo1fk7Ce8S0sYCVJYSyf5PE51Yrqt3jZsrAvQsbA
 YaKE0PolnP8Jo4CWe6qspPV4y7uEm1zWedw6qmniKea5FeKomNgBwuBvD8pmaktjnHfPk
 eL57BjMJoPNcO7wdroCUzaVP6nWiKf7KMvIgOOWGPFQj2MsEteatVlURRAlGQGMdZx2z7
 qpyfD+dkBj9AyprWpOGUmI4X9bxJZkig4sAbG2Q7N7hw42Apqs8gy1dnGVJCrZchMZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793768964;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=/Qq7ECXd1UGnT6ICmT8ykHZyGbTC+95konjgXmsmmDc=;
 b=myl4BiyvjRqdsN0WVJRVA2tv+b+FwLa5bgTFA0b1hY9ju31r6UHDwqKFmhJ1D5b510fr
 5kkYCG0b4n6kgOYpEr4WPHSfzEHn3a9Bs4tWs8hdPEbzQU/QMFy+FKq2jr+Zj0yZTbgww
 T2gtwIaAU3nrr6sm0zHMOIoOS7DAGIU3wJlbtotFDRFiftu70cZP25JsJJw39Cf3w+RQU
 RN7ENi8EHCjgsCc9SysmixA2uuCe4Bga7Ypq0PngmoCjYeI3wSGbjBDJ30Go+L+eft/IB
 OacZN+9DistrSYBOXlauKSpnn2Eb6F6sf6s2sM5ISlx+k5l3MYeNirTM3A2GO9gp+VQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=mailbox.org;
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b="EZa/EbI6"; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=EZa/EbI6
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 08E664043A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 05:09:22 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jKD4t61rlzMltF;
 Wed, 04 Nov 2026 06:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793768958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Qq7ECXd1UGnT6ICmT8ykHZyGbTC+95konjgXmsmmDc=;
 b=EZa/EbI6xMkQ6hLU1JhwKMjbmldKIP+MLaX4gbBkdi2Ilm2JPqEdcy1DpcYtSPAhCit3+e
 cTIwMPAdHIGdZ1zedYhL+SwImOTaGSkInCv78j5B4XAMd/YCMT5x3lLkIWJV0ydG1/HmNR
 RS8N2n8P2HU6mJbe3l3UA7yHUhw/oa8U2nAKXIC2mcgzrH+nFUju83vr2TNGGkO+A8Jb1i
 O8N5cxtqagWr+8kBDpQ3xCCvH1XIT9WOQ3hEM79U9GTI6AqGjOsnpOJ08W9/4IOR0MvlZi
 8JHg4iOdpa7nDLDU2lIr1Ov+p/PlO6s1CEIJmvRXXJrIfkn8TYCAU2bfOM+fdQ==
Message-ID: <4e720f9a-be35-45a2-9d90-d574ca7b488a@mailbox.org>
Date: Tue, 3 Nov 2026 17:09:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: renesas: gen5-cm33: Start the generic counter
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clegoffic@baylibre.com>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
References: <20261026-clegoffic-gen5-generic-counter-v1-1-4297803e85e9@baylibre.com>
 <bfbc69c2-32fb-4d2d-858d-a4ed36ccf592@mailbox.org>
 <4c9fc2c7-c131-4e6e-908d-0a7e8e6ffb17@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <4c9fc2c7-c131-4e6e-908d-0a7e8e6ffb17@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ba18bb37060910f1b19
X-MBO-RS-META: 5seushk1wn8xtnrdb8gu8ndstcnyi5w7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 10:15 AM, Clément Le Goffic wrote:

Hello Clement,

> Thanks for the review,
> 
> On 10/26/26 11:18 PM, Marek Vasut wrote:
>> On 10/26/26 4:36 PM, Clément Le Goffic wrote:
>>> The generic counter shared by the Cortex-A720AE and Cortex-R52 cores is
>>> stopped at reset. With U-Boot as the first stage on the RSIP-M, nothing
>>> starts it before the Cortex-R52 cores are released, so their timers 
>>> never
>>> advance and a timed wait such as a Zephyr k_sleep() blocks forever.
>>>
>>> Program the counter frequency and enable it before any other
>>> initialization, through the RSIP-M alias of the counter frame.
>>
>> Why is U-Boot on RSIP supposed to be doing this, why is Zephyr on the 
>> CR52 not doing it when it needs that counter ?
> 
> In the Renesas SDK it is the Gen5_IPL that start it. U-boot replaces 
> that stage.
>  From the manual "Set bit 0 in CNTCR to 1 to start the Generic Counter 
> when the CPU is placed in the secure mode."
> By default R52 is in secure mode but this can change by changing AxPROT[1].
> This mean a zephyr running on a R52 not in secure mode can't start it.

U-Boot on RSIP is not using the timer, so shouldn't SCP start the timer, 
since it also starts all of its users ? That way the timer is only 
started when it is really needed.

[...]
