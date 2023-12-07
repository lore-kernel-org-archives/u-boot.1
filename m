Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF5C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 14:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B548387185;
	Thu,  7 Dec 2023 15:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y8QuTmMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A19286F40; Thu,  7 Dec 2023 15:22:53 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3D787185
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 15:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id F2DE9CE2381;
 Thu,  7 Dec 2023 14:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19886C433C8;
 Thu,  7 Dec 2023 14:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701958967;
 bh=71GRLi10KsRY3/c2IyqfAKSTK19PKBYA7JM02ACQegM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Y8QuTmMlBGx7t/sCGFFChLj5SqTtVDwbM97cUo8TPjCb86bz5zooR+1DzHNCaoOg9
 F2iUlMnl0BJadIbufdldd8gDxXQ/fmKi1wUoMei9rMTV5EqknB/y7wSGABhPpa5n56
 7xz7yGsYyKgYC2yU0HN56ZrYoUCVgLaT9gNfKYbgaKOyi9G/I8hbsaxcUEj7dnIo2p
 KhpR+G7J7clrdbLW8aspEjyE1SPbjFCTXe3eZ0K7v1VhVFPHmVey1a7GmNdrTJddLA
 t+LSKtOW43phYHFYEfu9UbQySCQwcYWCgA4qMaJXtdK2j9O2Lt+LJrxH5X4RAXSgcR
 xcKlaADAdKaSA==
Message-ID: <619f6788-9f00-4729-a945-1b1af0621735@kernel.org>
Date: Thu, 7 Dec 2023 16:22:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de, enrico.leto@siemens.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
References: <20231125111605.47536-1-rogerq@kernel.org>
 <20231126173520.GA2513409@bill-the-cat>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231126173520.GA2513409@bill-the-cat>
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

Hi Tom,

On 26/11/2023 19:35, Tom Rini wrote:
> On Sat, Nov 25, 2023 at 01:16:05PM +0200, Roger Quadros wrote:
> 
>> AM335x uses a special driver "am335x_spl_bch.c" as SPL
>> NAND loader. This driver expects 1 sector at a time ECC
>> and doesn't work well with multi-sector ECC that was implemented in
>> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
>>
>> Switch back to 1 sector at a time read/ECC.
>>
>> Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based correction")
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
>>  1 file changed, 29 insertions(+), 66 deletions(-)
> 
> I'm glad to see this fixed. My question is, can we abstract this
> slightly as I assume there's a performance hit on the newer SoCs that
> support more than one sector at a time for ECC and I assume it's just
> am335x and related that don't support the feature. Thanks.
> 

It looks like that the ELM driver (omap_elm.c) is not yet ready for multi-sector setup yet.
I will need more time to test the multi-sector implementation.

-- 
cheers,
-roger
