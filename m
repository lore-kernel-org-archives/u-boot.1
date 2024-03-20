Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046DDC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 20:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34EE987D6B;
	Wed, 20 Mar 2024 21:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JVC5slkT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W9xnWXIH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23E2288076; Wed, 20 Mar 2024 21:52:42 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 767DC8723E
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 21:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4V0LPy1PLGz9sq5;
 Wed, 20 Mar 2024 21:52:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710967958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+L6BRQXjnt2WaVDUHwsOJyS2QDTG+8uuWteja1rJbqo=;
 b=JVC5slkTSVLBosGt3TG7GW3J4X80w7WyauFSCm7F2MPrNdj3kkKA5shEO/QU4eAX6fVgD8
 ALQOEO+uj2DVSl0wip3ougZIjcGHsPTC+XHnesEqR4s1aUmiYI3XBm7Wq56qvDs5utfklo
 zsLWNtlEUR4505axHjTZ0xHaMfjTDEB8KmMSTS+9/BA/PzgEI3xqJOMnP0NKUCUxQ/wJrh
 nG8WvLGpuXMVSWpzIzuG9G+CzS7keQO5zkCde/YAUA/e8d9JWpI2oV+uFrCIpuOgYjzNnZ
 UNdMOCZyDfo5l0PxFd924urU1f8057AUDtf5LtxV21JxOiQa7SdwZ1Ly8ZQt9g==
Message-ID: <b13328fd-03ed-49e0-90b2-0f0697e8c415@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710967956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+L6BRQXjnt2WaVDUHwsOJyS2QDTG+8uuWteja1rJbqo=;
 b=W9xnWXIHMJmn27nJmOIeqYi1GVZG7kSCEZIYVJVxc2DvR1kcz5Tb/wghxmyP3Bn71/wYkf
 RxnDgUyjRpoNQyioQ2TJfrgA7c8FhL8+CdGfCyn7pFaQaizjWP34GyJwvRqPUyz57A/wU/
 hxcXTOZKf8wPFqxTbXGw4JtSC4a6Kp7YqHZ5ZMhwWj69jg0MRq0ca1UQS3i/eJPALkMWAJ
 8Ll2NqQv4gRs/J8xHsKCPZTL4YzWPKurdEdromoO9zeGFlsYM57xs+Bbr1MkfglMfuln02
 SeF3JVmaVrsej+iRAmOpLvhvIYFH2vGcBA4LAnFvoqeg7K4vv4lvRrnXzuZ5Kg==
Date: Wed, 20 Mar 2024 21:52:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] boot: fdt: Clean up env_get_bootm_size()
Content-Language: en-US
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240318150200.8178-1-marek.vasut+renesas@mailbox.org>
 <20240318150200.8178-2-marek.vasut+renesas@mailbox.org>
 <20240318161813.GF13682@pendragon.ideasonboard.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240318161813.GF13682@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9d2cb7a537aaa767529
X-MBO-RS-META: rymyqxc9xzzwi6a7hurnghi1pgqo51ow
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

On 3/18/24 5:18 PM, Laurent Pinchart wrote:

>> @@ -142,7 +140,7 @@ phys_size_t env_get_bootm_size(void)
>>   
>>   	s = env_get("bootm_low");
>>   	if (s)
>> -		tmp = (phys_size_t)simple_strtoull(s, NULL, 16);
>> +		tmp = simple_strtoull(s, NULL, 16);
>>   	else
>>   		tmp = start;
>>   
> 
> Maybe you could even drop the tmp variable completely by writing this
> 
> 	if (s)
> 		size -= simple_strtoull(s, NULL, 16) - start;
> 
> 	return size;
> 
> I've never liked variables named tmp :-)

No, let's not do this. With this FDT part, the code should be verbose 
and as easy to understand at first glance as possible, no subtraction 
assignments and other shenanigans please.
