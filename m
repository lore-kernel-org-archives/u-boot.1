Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5299AC369D3
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D7D82A0A;
	Fri, 25 Apr 2025 19:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745601409;
	bh=0f6Czl41GpFZ9zSBxKsVpH6rPCFUT1+GJa2qZHFgrkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w04vvwkZYI0lmESVnaWqpOiHw9KrC4A8HVJ3sQu4LdUPXyiMvkNCo5FGIfUqmDlqA
	 pmEzP/ZjT0vEMEYCWFY9qRnwLWh5cDDhl8fQNTEADlVdHiMi7rT8WJIa8d94EGMzX5
	 H5QAA2SCMKgzwqrw/9roM4JIhm44l7xtnKqo9XEPFdlYVtuWz26S61B2EfaOGXtxBO
	 4XzGJLwVVEImHEi8Xz5QSC/QVM221Ev+a6gmhnvspWbwlQfasXT9tgMDWSM6AAVZd2
	 py4UFGRte8t6VWxD7cyLeLtgijjc5aaY6gCf5YrBa1OWvQrIELH6JU0i82P2qXdli1
	 9SMwsdDUm91Tw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B40C828BC; Fri, 25 Apr 2025 19:16:47 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A08D2828BC
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="fYRydtq5"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 52EEF10275AD5; 
 Fri, 25 Apr 2025 19:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745601405; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=0f6Czl41GpFZ9zSBxKsVpH6rPCFUT1+GJa2qZHFgrkM=;
 b=fYRydtq54QBugFaa8wZZXZjxoXFXrsCgFRHDCykI7v9XhhEGF5q3pPU0urc9cI5Xn3Zaqj
 lg6UFxGClBpK3P+kRV4u7CrBqU2jal4uvKc9zgbWgST6nIeyKbRlHtSeD8RjUphDTmDumL
 2V3jLvp1h/zuXfyo5eXlxxVRJUupJc6zetvsiRk1UJKFbQoe2YGYAezYyh813GTeJMl4rj
 ct5qLQ3fkzWOApT00Fpw8ID+CvCYuHNDdwQ0S7Cl3wg0Kouzsqw+hQGMp+6ske+j/OCeOd
 dlkFKys7QvAJgFJcrJ9Ynxs7XHlpx0jVbKcdYrZdmTmElSdNjJpJGfuDHqe1KA==
Message-ID: <26892d20-b71b-4e05-96c8-66c4120fb003@denx.de>
Date: Fri, 25 Apr 2025 19:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Fabio Estevam <festevam@gmail.com>
Cc: Adam Ford <aford173@gmail.com>, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, francesco.dolcini@toradex.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
 <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
 <CAHCN7xLkDnLX5PHFNjXYn7AFXA5+S22aksgv62PpWpg80ZDQmA@mail.gmail.com>
 <d81112ad-017b-491a-b517-de828dd30c25@denx.de>
 <CAOMZO5CpQ-yv=8GhNv7=yjnA+uzzP9ZmB=P2d+xmhY1ktQJX9A@mail.gmail.com>
 <28b4bb24-4c56-4fe3-ae9b-db43c63290b1@denx.de>
 <CAOMZO5Cz1atyi0OSOrzUfSGiLb-9XdnyX-d8L7un5PuAdkBeBQ@mail.gmail.com>
 <703a0297-24b2-42f3-9fa7-62a78e38f1a2@denx.de>
 <CAOMZO5BitKDL2QRAzBuKK9rdfPsob_jdsYx86CRXJq8RjC8xoA@mail.gmail.com>
 <CAOMZO5B6V4=5et8XpnN0-TkaCSLaiAf2sRw8C+_H97LeU17U+g@mail.gmail.com>
 <CAOMZO5B4_7bZ_+evgWUsEHtOhnhWtdNi4qavCAyes=91W9qjPg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5B4_7bZ_+evgWUsEHtOhnhWtdNi4qavCAyes=91W9qjPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/25/25 3:55 PM, Fabio Estevam wrote:
> On Fri, Apr 25, 2025 at 9:55 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
>> With the top-of-tree U-Boot, SPL calculates the wrong sdhc_clk on the
>> imx8mm-evk:
>>
>> U-Boot SPL 2025.04-01380-ga9820e12db18-dirty (Apr 25 2025 - 09:40:45 -0300)
>> No pmic
>> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
>> SEC0:  RNG instantiated
>> Trying to boot from MMC1
>> ****** sdhc clk is 204522251
> 
> I have just sent a series that fixes this problem.
> 
> It contains some clock patches from Marek that I missed applying
> earlier, as well as an IMX8MM SPL OSC24 M clock fix.
> 
> Marek, care to submit your clk.diff patch formally so that the i.MX8MP
> USB functionality could be restored?
If it is OK with you, send it as part of the fixup series, else I will 
send it sometimes next week.
