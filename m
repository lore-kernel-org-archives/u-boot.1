Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4160C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11D318786F;
	Wed, 10 Jan 2024 10:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tgt7j+a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60827878B2; Wed, 10 Jan 2024 10:34:20 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D94C87811
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 97345B81CF5;
 Wed, 10 Jan 2024 09:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671DDC43394;
 Wed, 10 Jan 2024 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704879257;
 bh=DyWa8v1aJwyNYLFOpcHf4pEdhVP5N5ar8tg+vSPrRbs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tgt7j+a4sMTrO2YRgrE8EpdTW84XG4kyA9WbnjVLHsmoTULgRfqJAad0dqtMZzAXw
 SyOUmv2h6fqplGIeTXeBvMLqIhsQ4sLBB+h8Md2liGyn7kiXeY0zyk4FQ6xeFY5u55
 9tWgVDUizB0ms5/bRdPF/1LAaB1W6LaIDk+fQMKQWlf9iPwd0ki5+oTrCONm1QvEz+
 FqRei66jXFS9oQlhvgRqaXgbouQwW7LNo+1H0YCKx6khAcMmMXRrH/oIi29orZXzi7
 9/gxwK2sdyTLbTK7rmmYMSAnbnXEahRpr3fs+/6MDzQWJOhpSplGf08CWOddAMyQU/
 LjccKp9t3xa4Q==
Message-ID: <f6b3cf36-8e33-4e0d-9794-35ea32410c88@kernel.org>
Date: Wed, 10 Jan 2024 11:34:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, afd@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191859.ljtnotdn4voabwko@animate>
 <20240109195400.GY1610741@bill-the-cat> <20240109200053.GA94696@francesco-nb>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240109200053.GA94696@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 09/01/2024 22:00, Francesco Dolcini wrote:
> On Tue, Jan 09, 2024 at 02:54:00PM -0500, Tom Rini wrote:
>> On Tue, Jan 09, 2024 at 01:18:59PM -0600, Nishanth Menon wrote:
>>> On 14:26-20240109, Roger Quadros wrote:
>>>>  CONFIG_CMD_PMIC=y
>>>>  CONFIG_CMD_REGULATOR=y
>>>> +CONFIG_CMD_MTDPARTS=y
>>>> +CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
>>>> +CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:2m(NAND.tiboot3),2m(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup),-(NAND.file-system)"
>>>
>>> Why not handle this as device tree partitions?
>>
>> I honestly forget what the preferred way of defining and passing NAND
>> partition information is these days. It might even be the funny case
>> that passing as cmdline args is "best" rather than fixed-partitions
>> binding?
> 
> According to past discussions [1] doing the fixup in U-Boot is not advised.
> 
> Using the command line or having the partition fixed in the DT are both
> valid options.
> 
> [1] https://lore.kernel.org/all/20230206224838.75963-1-francesco@dolcini.it/
> 
> Francesco
> 

This was not about passing mtdparts to kernel but about getting 'mtdparts' command
to work at u-boot. I need to figure out why OF partition parser didn't work here.

For a start I didn't have CONFIG_MTD_PARTITIONS set. Maybe I'm missing something more.

-- 
cheers,
-roger
