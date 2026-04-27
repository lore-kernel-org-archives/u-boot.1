Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950D7FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51FC83693;
	Mon, 27 Apr 2026 21:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GKqhRETy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B50F83BC4; Mon, 27 Apr 2026 21:12:19 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D41805D7
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:12:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-479932ccab1so5585983b6e.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777317133; x=1777921933;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4OmG8FyQeNIT2fT+fuWv3k9OQc1v2irCbuLgdNyYDLk=;
 b=GKqhRETy8W8c2Jm8W0MHcrfvCfrrZr409REKiith1vSB6KdAoLlIKG7rd9ulbmr5mr
 3QM8EGZywM3gE8DtwJhgLkYrkvHRjujqdS2BxTfLmq6zxmjYLfgWFnqqTcLQkMmbjFlh
 1i6K6EZbxKuhUnvsMeBwUtmEgyHe3e6IydV/TI6Izp/QzYljaGHVP5+EIXQbxVqMFsPZ
 Vwxh0q599GmpUNSt/Rr2FLTQHYMMgbbd0bPMPue0Rjj5lCemB5hjxHxCIAp7BLFUDn3r
 MpblzgOPvyTxVM34nPy5moXoB+l17YgV8EKTxdaAP+BHJDBxHw+LiC8bLeKCdLYKzosn
 RE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777317133; x=1777921933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4OmG8FyQeNIT2fT+fuWv3k9OQc1v2irCbuLgdNyYDLk=;
 b=K2kXFhmxK73LzU7MeoE+pHAGanFKG0IRaWkVfaB8BwCvc1D+0u3YVkzXL1hbfR0XGR
 7lNvWySlO/07Nx+f4lUYAPIVcbn2r0Yxzu3g40WbUO0xaeGadt3hjPeFTVxe7OX2tMLZ
 +LbueN7m/81pUATelldm//vB6ho62AF8ekYWnuinmfZjOZkuk7prHqSg7zKrw1q2SdGP
 zwFBLOEw2VnywYUmi2P1AYTqEprUHi/SHTBbATX4VCRCH2q2QSIbp6bYPX8q71JQSGj6
 pLV7iCRbHMwW4dJvHNdyMEMI/8U1OCE8hvdFYGVE4bYhPz7YACE54gjcpDZl9IHE6Ezd
 XyTg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bOP7xR/30oyV9f+gndYk/NC/6XhzZeY4x03Q1gvYgpzud2z0DqLwS/r63KCsWr0lRD8S62g8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywpw9KlhRzuagVGKoV2HeANS/5g2a7gE0CL6vFyqGS3N3yvzGmS
 GI5XpbecFU2BsSDf5ZAPXqqMiwKudEMIbDKbfSY5g+fm6CS/gL3AXHUa/DwulRqOC2w=
X-Gm-Gg: AeBDiesRrAFaDz39n5qpXLpwgPLXKvovqNmIM7I9XcamFCqTH+VFLsANBnV6IJUp0uZ
 6SbyveRBGMSHAXcSs45VsXk/MSxeBVbSfQlXKU6avsgf3e63Wrxm5FH+TUU5sZBmyRGzc88boqu
 fpTttrEsexD1Goi7zxxujAdA9dE4AlBq7eVMmLODRDM9lgC6ky5HPy/YjzaHU23BV8MZIra9meP
 7X9OhsjdiHGfeiWoxDMSIb6bosfnNbqHAianIsSoEWA6DOmjA+TsLuzreFHJOHA2UAmigDJq1dY
 L2ZVfbI2lWuOnrwDSW5k7h7jImt33OjzsZZd/aEnYMJR3kw/Uy3gsBwVd8fhjiQylr55gt4kF6+
 Psg1yqdlufPSjMu3ywTEfCPcyA/GJFPDMSuDHIzFnINRTdLArKfIqWhEasLl4BsF74ymQ96sDJI
 mxR8ipjoSMovF2pLUNCXHck1H7eHclRoZ5STpCVmH4KV9lbyi+z3Hu3Z4iG7nCoosmwTkluu5FW
 Hcb9X5ssDZa
X-Received: by 2002:a05:6808:1b10:b0:479:e9d2:26cf with SMTP id
 5614622812f47-47c28e77201mr19230b6e.15.1777317133496; 
 Mon, 27 Apr 2026 12:12:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:96f5:eee9:c87c:c599?
 ([2600:8803:e7e4:500:96f5:eee9:c87c:c599])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c28f51315sm2983b6e.3.2026.04.27.12.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 12:12:13 -0700 (PDT)
Message-ID: <c6eab955-e5d1-4738-8fcf-f887a6902b65@baylibre.com>
Date: Mon, 27 Apr 2026 14:12:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: mediatek: add airoha an7581/an7583 pinctrl driver
To: Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Linus Walleij <linus.walleij@linaro.org>
References: <20260420172158.838063-1-mikhail.kshevetskiy@iopsys.eu>
 <1f8ca89f-0740-4ac6-bd18-4cb376518ddd@baylibre.com>
 <79f0b0cc-d412-4dcd-b8d6-8b85946142d5@genexis.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <79f0b0cc-d412-4dcd-b8d6-8b85946142d5@genexis.eu>
Content-Type: text/plain; charset=UTF-8
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

On 4/23/26 5:20 AM, Benjamin Larsson wrote:
> On 20/04/2026 21:54, David Lechner wrote:
>> On 4/20/26 12:21 PM, Mikhail Kshevetskiy wrote:
>>> The patch adds pinctrl and gpio drivers for an7581/an7583 SoCs.
>>> The code is based on linux airoha pinctrl driver.
>>>
>>> There are several '#if 0' .. '#endif' in the code. This was done
>> IMHO, `#if 0` is just noise and we should delete it.
>>
>>> to make it easier to compare Linux and U-Boot pinctrl drivers.
>>>
>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>> ---
>>>   drivers/pinctrl/mediatek/Kconfig          |   22 +-
>>>   drivers/pinctrl/mediatek/Makefile         |    3 +
>>>   drivers/pinctrl/mediatek/pinctrl-airoha.c | 3297 +++++++++++++++++++++
>> Wowsers! This is a lot of code for one file, let alone one patch. hopefully
>> we can split it up. For example, move the SoC-specific tables to separate
>> files.
> Hi, we have a split patch for linux here:
> 
> https://sirherobrine23.com.br/airoha_an7523/kernel/pulls/17/files
> 
> So the code could look something like that and it would make it easier to add more targets later.

Yes, splitting it up like this is what I had in mind.

> 
> It would be nice if we could get pointed in a general direction where to take this. The AN7581 and AN7583 are very similar and the Linux kernel reuses lots of tables but I think that optimization makes it harder to add other targets and it adds complexity in the maintenance perspective.
> 
> Any comments?

Personally, I don't have a problem with duplicating some tables in the
chip-specific files to make it easier to maintain.

> 
> MvH
> 
> Benjamin Larsson
> 

