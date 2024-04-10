Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D23CD1296
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 09:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E67F881B8;
	Wed, 10 Apr 2024 11:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="AmYx5O6B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA384881BA; Wed, 10 Apr 2024 11:24:27 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EE6881B3
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 11:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1712741065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=upI8Xz01kD0j6J0hCzPJPB70pkLLguAm3H8jcu+puBo=;
 b=AmYx5O6BMnvXufCE0wID8MQxYo903lKyt3HqqaUMGdaY9dGj2mXVdMXjfRv0cSE7xnmkzF
 Ui0vebAabVnbCvyQCOK6bjGLKxJuL9g4spw2tSIPqcQ4fSwktlKChOQmdwlavHOrEpkWCV
 kYEdH8FmH/RmOinabxlKV5Ms8MQtHBQsuAsxWjkLmcNrKoH5AWnKPgXYIhcXjOfpEfLn4y
 LSclhxTFbGvyuAmxemWppFcZcsX6HVqo1FCgOGeM2v4z68XkKYqAmRRsV9GTUj1pmAw8Vo
 3su3T4ErWiHe5lEMRznjmjIFO9riMxgjHZK736tgwj0c6q3EXcURmd7FmEsnSQ==
Date: Wed, 10 Apr 2024 11:24:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] mmc: Imply HS200 cap with mmc-hs400 prop to match
 linux
In-Reply-To: <3f0733d4-1739-45f8-adf4-57070ad21d2b@theobroma-systems.com>
References: <20240408210619.3749231-1-jonas@kwiboo.se>
 <496013c1-7a57-4d12-bf31-c5257f35ee8c@theobroma-systems.com>
 <3b2643b4-dea7-43cd-9f9c-da63e6588281@kwiboo.se>
 <ac394528-ca53-41d5-8c4c-7c10943a7c92@theobroma-systems.com>
 <e73b2576-4a0c-4965-a1f8-debe6b364af3@kwiboo.se>
 <1cb93207c400d43518e95c713115723d@manjaro.org>
 <3f0733d4-1739-45f8-adf4-57070ad21d2b@theobroma-systems.com>
Message-ID: <0726c54821f0f505498923e3c6897fd6@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Quentin,

On 2024-04-10 10:47, Quentin Schulz wrote:
> On 4/9/24 21:30, Dragan Simic wrote:
>> On 2024-04-09 18:30, Jonas Karlman wrote:
>>> On 2024-04-09 18:02, Quentin Schulz wrote:
>>>> On 4/9/24 17:58, Jonas Karlman wrote:
>>>>> Agree that implying HS200 does not fully make sense, however it was 
>>>>> part
>>>>> of the original Linux binding when HS400 was added in v3.16-rc1 [1] 
>>>>> so I
>>>>> think that this is the expected behavior and changing it may be an 
>>>>> ABI
>>>>> breakage.
>>>> 
>>>> I'm not advocating undoing the kernel "hack", but rather make it so 
>>>> that
>>>> we add hs200 to DTs where it's actually supported instead of doing 
>>>> the
>>>> same hack the kernel does. In that case, we wouldn't need the hack 
>>>> anymore.
>>> 
>>> I will add a patch that adds the missing mmc-hs200 props to affected
>>> rk3588 boards, nanopc-t4 and quartzpro64 in v2 of the "rockchip: 
>>> rk35xx:
>>> Miscellaneous fixes and updates" series.
>>> 
>>> Also turns out the issue with those boards was because of my other 
>>> "mmc:
>>> rockchip_sdhci: Revert 4 blocks PIO mode read limit for RK35xx" 
>>> patch,
>>> so will need to rework that revert some more before posting a v2 of 
>>> that
>>> patch.
>>> 
>>> For this patch it is fully up to the maintainers if U-Boot wants to
>>> mimic Linux kernel or not.
>> 
>> I think that the logic used in the Linux kernel should be followed,
>> because one of the goals should be to add as few "touches" to the
>> upstream DT files in U-Boot as possible.
> 
> I was suggesting to fix the upstream DT files as well.

I see, but I think there's no need for that, as I already explained
further in my other response.
