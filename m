Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBC6CDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 13:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3FE6849EE;
	Tue, 23 Jun 2026 15:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dMUvk65r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AEE84A06; Tue, 23 Jun 2026 15:18:01 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C87849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 15:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chleroy@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF00D405D7;
 Tue, 23 Jun 2026 13:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7760A1F000E9;
 Tue, 23 Jun 2026 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782220677;
 bh=D8oWgz3VWUAnCfkmeK6AmAH4ngq/4oXJcrb1VR/aXyY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=dMUvk65rHs+w6PQ5LvRGPudgq+Br4xxMMsFeP3MIP9D/iJTGn5y7ABSRxWB3N6W3C
 mDooNmse9rrhyLhHnbKm25ljqcbbX7Wh9DgPd8rJV3sYIDNG04ebjDR87+qvMGZIrx
 b6eJ1Z42PVJj/XnVO2G6Ouj8eTglyPRU4Z9Xab6mk25ZAtDfHKmLM5IxTysTjHiSPF
 fQ0GiwIAZk5mMX/AvzPJ+PqXLnl3hViMJjHnkAoOiVK2guUyky4zQar7M701CG4xse
 0BfjsbTnrqJd5Ea1+NG6abXfXXU/aoyySRbtGs4A6PyNJagj1chiiYfztBdjWX3l42
 0BppGJJcU3KXg==
Message-ID: <4085e97d-f701-4675-852e-a4341288c6f9@kernel.org>
Date: Tue, 23 Jun 2026 15:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Relocate U-Boot in the last bank
To: Marek Vasut <marek.vasut@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
 <849b2c49-9d92-4c5e-be0c-97091f070918@kernel.org>
 <7a74ad03-e180-4ae1-955e-3bab54d3342f@mailbox.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <7a74ad03-e180-4ae1-955e-3bab54d3342f@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Le 23/06/2026 à 15:16, Marek Vasut a écrit :
> [Vous ne recevez pas souvent de courriers de marek.vasut@mailbox.org. 
> Découvrez pourquoi ceci est important à https://aka.ms/ 
> LearnAboutSenderIdentification ]
> 
> On 6/23/26 3:13 PM, Christophe Leroy (CS GROUP) wrote:
> 
> Hello Christophe,
> 
>> Le 17/06/2026 à 09:48, Ilias Apalodimas a écrit :
>>> Hi all, this is v7 of [1][2][3][4][5][6]!
>>>
>>> There was a discussion recently on the mailing lists regarding our
>>> management of memory above ram_top [0]. The tl;dr is that we have two
>>> problems.
>>>
>>> The first one is that U-Boot always relocates to the top of the first
>>> available
>>> bank unless there's special board code to sidestep that. The second is
>>> we don't
>>> successfully deal with devices that can only do 32-bit DMA.
>>>
>>> This patch series deals with the first problem by adding a Kconfig 
>>> option
>>> allowing platforms to relocate to the top of the last discovered bank.
>>>
>>> It's worth noting that this is easily testable with QEMU
>>
>> Following discussion on patch 1/7 in v5, I boot tested this v7 series on
>> one of my powerpc boards. It could start Linux kernel v7.0 without any
>> problem.
>>
>> FWIW,
>>
>> Tested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> That is really nice, thank you.
> 
> Which PPC board did you use ?

MCR3000_defconfig
