Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8735DFF885D
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 01:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 013E983C14;
	Mon, 27 Apr 2026 03:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fAx4vnII";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F80683FDB; Mon, 27 Apr 2026 03:12:44 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73ABA83693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 03:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g3lt0604bz9tjF;
 Mon, 27 Apr 2026 03:12:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777252360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2//r1NXbMFvbcaEwYaf8YwywpUO4RI5Z/TzxahSTkPE=;
 b=fAx4vnII+OAo2Vzdchwqol42LUL4ywa7WMR3IU1ePCLw9TI8eFiCOIcBncUkWV0KUS8cNY
 7NNDP6I9uyXFHhzzh52peeF1VouKtfASYpoIGUuyqSE+FTq8msJURAPhyjhtoo/Vbcj1tB
 pyssEm464pWqm9nY7sFzoQYYumRGaepf5ndZvmQp31UIvyxV/l/LivcQhbDtmO/EPIQVXp
 9YAw2YbBBYFUc621pb5midpRT50lrxkcywiVLGmL1tGGK8Gz6TWDCdiM6k+FiRKGKOFxtn
 Ht+Xxa+INaIgEaTY8dtgJmry6qXELjat4it70bHb3+aeDZX3v252R06LiA5Lng==
Message-ID: <f6e399e2-e0ef-46ea-b2fe-be9b9445e7bb@mailbox.org>
Date: Sun, 26 Apr 2026 21:52:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: renesas: Add Cortex-M33 build option to R-Car Gen5
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Anshul Dalal <anshuld@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20260329232419.352743-1-marek.vasut+renesas@mailbox.org>
 <83f03231-f05b-48cd-bf94-eb73398c55a0@cherry.de>
 <31a007c9-c58b-4916-9657-2ac2bf69b7fd@mailbox.org>
 <b1065108-f878-4153-a54d-28d03c9d8d4b@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <b1065108-f878-4153-a54d-28d03c9d8d4b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jhfwxumoi8ryx4qnq66jj83gqbowp369
X-MBO-RS-ID: 0a69b0afb01e4b3489e
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

On 4/23/26 10:37 AM, Quentin Schulz wrote:

Hello Quentin,

>> U-Boot can run on either the CA720 (64bit) or CM33 (32bit) core, hence 
>> this duality here. RCAR_64_CM covers the CM33 core tunables, ! 
>> RCAR_64_CM the CA720 ones.
>>
> 
> I've never seen anyone prefix the Cortex core denomination with C before 
> so it's somehow confusing me :)

C stands for Cortex, right .

>>> The main issue I have with this is that RCAR_64 doesn't mean a 64b 
>>> machine anymore, and the naming doesn't help with that.
>>
>> It covers the machines which have 64bit ARM cores in them, Gen3/4/5 
>> and RZ/G2 . Sure, those SoCs also have 32bit cores in them ...
>>
> 
> Meh, I find this unnecessarily confusing. At the very least, update the 
> comment above RCAR_64 to highlight the 64b part applies to the main 
> Cortex cores in the SoC?

The Cortex cores are equivalent, there is no real "main" core, but I did 
include the 32bit CM/CR in the code comment.

>>> I'm pretty sure in the future someone's going to make the mistake of 
>>> doing a simple CONFIG_IS_ENABLED(RCAR_64) to check if it's a 64b 
>>> machine or not.
>>
>> IS_ENABLED(CONFIG_ARM64) is what they should use .
>>
> 
> No, they'll need to do
> 
> IS_ENABLED(CONFIG_RCAR_64) && IS_ENABLED(CONFIG_ARM64)

IS_ENABLED(CONFIG_ARM64) is enough to determine whether this is arm64 
build, why wouldn't it be ?

[...]

>>> Should that be a symbol instead? Then you can have
>> No, this is not user configurable, this is hardware IP address.
>>
> 
> The symbols don't need to be visible to the user.
They are not configuration symbols, they are hardware addresses, they 
have no place in Kconfig.
