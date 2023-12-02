Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94067C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA8F487651;
	Sat,  2 Dec 2023 19:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qhxThmyV";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lpt36zij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20FD987616; Sat,  2 Dec 2023 19:18:32 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 861FF87616
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SjJ8L6wCsz9sv1;
 Sat,  2 Dec 2023 19:18:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701541106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cq0dUm0gr+PiUuZ7kmJNxLLW90S6VMzErbpZrtz8la8=;
 b=qhxThmyVJNMrZyrW16MMRDuUBXNwZt5lLhclYMyM8vE/6Tj+C5wK+JA+BKD08XLK46UjIe
 sKbqlPDRlLL1UEugmU2NX8YfgnuYqSCZg0AzzoNu2FS7FGS1yTq/6D3mxruoxKQUzJeBOR
 k7QNlQJZydpoPlI7pggzjbDcYKox9emWC3dotTVVK1KJvEbIZ47bcVXdTpcapq/6yu4DVZ
 nZrkeXmgeF5/jK7emcECWNxBT+iYIWeq5+QzC2k36O0sYmdMsG9uibWgpb/3KxKdJuqYrS
 xhm0PYoX9K2Zk9yKYhtodcCxbWh7PjUJEWGowWWtG1t+rrGqB4dmQPkoso0riA==
Message-ID: <faee5984-fb92-46f0-a9b7-17f57eddbee5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701541104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cq0dUm0gr+PiUuZ7kmJNxLLW90S6VMzErbpZrtz8la8=;
 b=Lpt36zijHEbT9DBH+OcswGO8vrgP7Fe/3gbeHggdOyAxGdy2NVdVlI1eVEElROlPBiCFN+
 czESByIDO9NJq2ajzsxcPFL3T0M8DZiJc2qC+UM+UPDCD0/KazguknWmG1/L6y04rO9aaS
 kBOb1x2B3mr08VCK7Y5BTuWc2O5V86IKNT/44aoPrY42n42UC0hm7+f5WppG+CHUFH3MbT
 WSyPo72dq37zSgcWIt5UpoMqzqf9kgKZShIlPcia+CUbMmAzJMiJzf/6q4q839o6XEYTcS
 om8xQySRe1nuHZJJiOfH+JxPXp16uuURa4Tb2ZA3B+TJBVpEJhe1cnJ8shaWnw==
Date: Sat, 2 Dec 2023 19:18:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 3/5] i2c: rzg2l: Add I2C driver for RZ/G2L family
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Heiko Schocher <hs@denx.de>
References: <20231115174025.12974-1-paul.barker.ct@bp.renesas.com>
 <20231115174025.12974-4-paul.barker.ct@bp.renesas.com>
 <90feb671-d939-4dbf-9a49-418fc9a56b23@mailbox.org>
 <20231119204853.bmg4ghuo625c3zkm@GBR-5CG2373LKG.adwin.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231119204853.bmg4ghuo625c3zkm@GBR-5CG2373LKG.adwin.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 33828660a05056ae16a
X-MBO-RS-META: f5n6dbooeswxka4f3ahfjiyhznacf81q
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

On 11/19/23 21:48, Paul Barker wrote:
> On Sun, Nov 19, 2023 at 09:15:36PM +0100, Marek Vasut wrote:
>> On 11/15/23 18:40, Paul Barker wrote:
>>> This driver supports the I2C module on the Renesas RZ/G2L (R9A07G044)
>>> SoC, also known as the RIIC module.
>>>
>>> This patch is based on both the u-boot driver in the Renesas RZ BSP
>>> 3.0.5 release [1] (commit 7fcc1fdc2534), and the Linux v6.6 driver
>>> (commit ffc253263a13).
>>>
>>> Support for deblocking the I2C bus is included as this may be needed
>>> after triggering a reset via the Power Management IC (PMIC) over I2C
>>> (the PMIC asserts the reset line before the SoC completes the I2C write
>>> transaction with obvious bus locking effects). If the SDA line is
>>> observed to be low during initialisation, we automatically attempt to
>>> deblock.
>>>
>>> [1]: https://github.com/renesas-rz/renesas-u-boot-cip
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>
>> The driver seems very similar to drivers/i2c/rcar_iic.c , can there be some
>> code reuse ?
> 
> My initial idea was to extend the R-Car iic driver but I quickly saw
> that would be very messy. All the registers and bits are in different
> places, the calculations are different (particularly in regard to
> setting bus speed) and the read/write process has more edge cases for
> the RZ/G2L. The bus recovery mechanism we use also doesn't exist on
> previous R-Car SoCs.
> 
> The Linux drivers for these modules are also separate, see
> drivers/i2c/busses/i2c-sh_mobile.c (for R-Car and earlier SoCs) and
> drivers/i2c/busses/i2c-riic.c (for RZ/G2L) in the Linux kernel.

Ah, I thought some of the registers were the same, but indeed the RZG 
core is much more extensive.

You should either use devm_clk_*() in probe() or implement .remove 
callback. With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

And sorry for the delayed reply.
