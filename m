Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5804C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DCD87F6F;
	Mon,  4 Mar 2024 15:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="d1n7rF5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1848987E4F; Mon,  4 Mar 2024 15:11:10 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F55387D7E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 71F2DA0265;
 Mon,  4 Mar 2024 15:11:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=mail; bh=1NF3ZwBYulDGtqX8mUhW
 IQehxsHbN6XKWY3zWoH/1z0=; b=d1n7rF5H1zcgvGAHuJ6unoAxLLetKgCVnEWn
 XHLaeeELjY/DIaTw8IYyhX5I+Z0asWy0rNuGks9iGMiS1mBIGmofY7MZLpG8S5hn
 ZRATn92BcSB82sW3zeYEnbvS3pjLgMeNA2oylKZJ1XSLDeUGF1sg9zI089VeCDl3
 eNQuXDpnNxAlALIvuEgQbNXGGic0Ch86fiAaVkgXTqttoA0fMarO2QPogXmQBrwA
 ePZB8UQJBGRTrwzaYdNtQyx3FZk7LVZi/8nFLbhJPniW5ORwOUuDtqOkdrkEiObA
 ZBCpFxcmFi1iZ5rT95qre9kPF6A3Q2YJ3tiZ435qiphLIb/P51HpT0hHdzZDs70q
 nydUth2Zdd1Gw4WYtlp8FOCo4PDn6GoYFVLNlXJypMMo5JGIHyD5rJ99ToRBVwFy
 OFnT1zLKKIDRrrw4eJr1d2OUpFedIJ2Uw+jGL6ZzVhu4jjOC0mxSDh2ZBeLr79ox
 fJmh0TMc98AbC5ccI2T6002KncaKjKS6mDCcWplASltyMNMLuDhu2xRu3djSIJsH
 uOAYbY9MtsJzd7U2oAKYDlKgCr1D0P7Yk6jwHXshe7ucgK2XRPZyoh2MYUczuTSr
 4AB9z5jVa6w2x+ZELAchof9pqW26sioRCTQYIUApY1ZECImwwCRSVO1h405HKRgu
 +JMyu5w=
Message-ID: <007f1c98-4871-49d6-b601-4766ff45e20c@prolan.hu>
Date: Mon, 4 Mar 2024 15:11:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: Enable CONFIG_64BIT for static analysis
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Dan Carpenter
 <dan.carpenter@linaro.org>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Andrew
 Davis" <afd@ti.com>, Andre Przywara <andre.przywara@arm.com>, Bin Meng
 <bmeng@tinylab.org>, Linus Walleij <linus.walleij@linaro.org>, Fabio Estevam
 <festevam@denx.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Yang Xiwen
 <forbidden405@outlook.com>, Peng Fan <peng.fan@nxp.com>,
 <u-boot@lists.denx.de>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>
References: <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
 <6907b26a-9eb2-4ffd-8337-50ee96155c05@canonical.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <6907b26a-9eb2-4ffd-8337-50ee96155c05@canonical.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.254.7.28]
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 sinope.intranet.prolan.hu (10.254.0.237)
X-EsetResult: clean, is OK
X-EsetId: 37303A29916D3B5562746A
X-Mailman-Approved-At: Mon, 04 Mar 2024 15:12:51 +0100
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

2024. 03. 04. 14:44 keltezéssel, Heinrich Schuchardt írta> How about 
other 64bit architectures (sandbox64, x86_64)?

I think that could be its own patchset.

> Best regards
> 
> Heinrich

Bence

P.S., does anyone know why I'm being CC'ed here? Did I participate in 
this thread at some point? I only remember contributing to lib/rsa and 
also a small patch to arch/arm/lib/vectors.S. Maybe because the latter 
touched arch/arm/Kconfig as well, so now I should expect to get loads of 
mail for a month or two?

