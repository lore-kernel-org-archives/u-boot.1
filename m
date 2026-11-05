Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88508606A335
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 04:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WmOrgjII;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Z0qfwNRN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 639EE40462;
	Thu,  5 Nov 2026 04:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyrRcsWodwzZ; Thu,  5 Nov 2026 04:41:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 76EFB403BD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793853693;
	b=UJiPNoYWuSDXES60ApxRZGZy8+H1aoDS/JDR7ePZWQyHFJ0Kan4Q5rOTg9WQVbb9hwon
	 NU7tpOQcXgvSBtT4nvaGwN+y6sugVfh/fH4VOVj2p8h8Mhi6OQYRPkpIvqF+AxtALSdC2
	 y/q2ZcnY6cb2sk4xU8n2VN/lJr1cYvDU2lNfB4A4crqlObK7y6Pa4Q6GGXZmtoGtqRM9O
	 dr/snoXa6lyr9f95OfrDVzLKu+n9Wms2WHJThthWxrnCCW3FxVCuFZLkHSyeFWhfm6xBT
	 vnTek2Y7Ny/w53fAfUZ4co4wrxj78k9gd6HdYTmLKGdca7YL65ZAIrbPkrJCm0KHy5A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793853693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XG8j6aZLL0mwt0w8ktZflcQ/OW/4L5cW35/+Ia16cGY=;
	b=O2yasjsTqobGDVN7ggZqfDeaMCBk9EiWHGZGT+Jluv5AuzUcpThYe8Iu2AvzkqKTcRNz
	 bm8UMRp2WH7UXqwuWDYv0iecfAebIrFFSS5RYZhhjUPj3/M8lJCBd/0dxBn/QQTt+YPz1
	 yFDgTjaEvnKvqPVFFLznq/+SLLpy7YXJmZUhaP3GgH/PnEbVoCyPayUANOhHhUpWfsUpK
	 o0vjkm8ETYrmFWra38DiKf1pomPkfagRwVrEFeH3LRisjoLV/2GhJbAS0uWZr2IsbmjyF
	 meVfw0VsFn3TyEASROvqpCQvd6/WwP6TMN12HFGGYEv7Kq+eG30YjXsJfGInzrvYEvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Z0qfwNRN;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793853693;
	bh=XG8j6aZLL0mwt0w8ktZflcQ/OW/4L5cW35/+Ia16cGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WmOrgjIIFSFdpsYuK71E1HXx2fVTc8rxntix6/4nSI9Ys68m+Jt6KDjxvXTNN8/Sr
	 cUlPey9mYWzgq5OwWZF4Ju+f7jma/uvjHDLchHkVmIUre40wJFGV/CLL+zuI/Z9jrt
	 OTAsyIrmg6EKOaDQZiashNwHNqi8BLPhYx0rN72wOCSurtw1Gbyio0WBzkxy3Jdnaw
	 13IDK3wLupLbfn4Rhes7sJWaMk7bdlZfI8qbXbBpth1oIS2bU4Dj2ubL0OULoZ+Slw
	 ZK+VM0oWm+REWUXAM2Fw80Vy1kh83ksDBja7Mhn/3cZI7T7Rvt/V8ojdGKCURl2nVb
	 CqYNBHSS5G3aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76EFB403BD;
	Thu,  5 Nov 2026 04:41:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63EE837B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 55761403B2
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NJPr303wKDPE for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 04:41:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 38565403BD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Z0qfwNRN
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38565403BD
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 04:41:30 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKqQG6dvYz8v0P;
 Thu, 05 Nov 2026 05:41:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793853686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XG8j6aZLL0mwt0w8ktZflcQ/OW/4L5cW35/+Ia16cGY=;
 b=Z0qfwNRNhYrSYYkavTGh+iQlLOYZWDH8GiDw4o5A03Ux86mZry8DWHq5Cz28m2XkHZksTS
 ivheXqoxvjN4P/JZqniPWyA8mRuCv/NMKQPZa5BCyVIeubieSjj4dfJ3bFWSo29bKcAY4N
 tbR3CJ2AIJEAN3KC+MeIowIqAWqvBLbBJv4VP8+s0u0byIOZrQbzbBDPGIhIDD2t36wCOB
 jWCfC4X+K409sMd0Qka1+MLafn09jon3hVirCjUNHZ4eyMIJOtBr3iX52OvPdT+ptE2tDJ
 mmGIiMdYIm0TmVfHaP1M11rYjBiT13LVIF21rZCDQ3w6tBhoVgmdqLY8I+N6OQ==
Message-ID: <172cda1e-2147-4ce6-8d2d-27ddcb7cdbc2@mailbox.org>
Date: Thu, 5 Nov 2026 02:41:48 +0100
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
 <4e720f9a-be35-45a2-9d90-d574ca7b488a@mailbox.org>
 <7fc1e0d3-c7f4-45ae-914f-d485f1ed25eb@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <7fc1e0d3-c7f4-45ae-914f-d485f1ed25eb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 83c6c75e2fd63278ad7
X-MBO-RS-META: giz7egkz1gaqqqf175yjuer8uhfzbmtb
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 9:47 AM, Clément Le Goffic wrote:

Hello Clement,

>> U-Boot on RSIP is not using the timer, so shouldn't SCP start the timer, since it also starts all of its users ? That way the timer is only started when it is really needed.
>>
>> [...]
> 
> The SCP isn't using it either. The timer is needed by the AP and the RT cores and is always needed whichever SW component start on the system.
> TFA on Ironhide even start it here (I consider to remove it once this land):
> https://github.com/ARM-software/arm-trusted-firmware/blob/v2.15.0/plat/renesas/rcar_gen5/bl31_plat_setup.c#L161-L171

If AP and RT cores use the timer as a shared resource, and SCP is the 
coordinator of shared resources on this system, then I would argue it is 
task of the SCP to set up that shared resource, i.e. the timer.

> SCP doesn't start by itself all of its user, it is U-boot on RSIPM that sends the "start" request.
> SCP is the SCMI server it just react to SCMI requests. A "start generic counter" SCMI requests doesn't exist. Hence do it here.

U-Boot (client) sends a request to the SCP to start the first user of 
the timer, so SCP should take care of configuring the system correctly 
for that first user, i.e. enable the timer.

> The generic counter is the platform counter, U-boot on RSIPM should start all what is needed for the platform to work as a bootloader would do.

U-Boot driver model is explicitly designed to not start unnecessary 
parts and boot as quickly as possible.

Why not start the timer using the SCP when there are actual users of the 
timer ?

-- 
Best regards,
Marek Vasut
