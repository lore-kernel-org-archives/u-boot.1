Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A032DCA0EEB
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 11:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E20BA82D88;
	Tue, 19 Aug 2025 13:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fvw8HFRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B4FA82E05; Tue, 19 Aug 2025 13:10:35 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1417D80FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 13:10:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c5n1f4VKDz9srM;
 Tue, 19 Aug 2025 13:10:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755601830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZZ6lItFyUG1+O3SSzAUpIZ/CURVejigGkmKlwmSfqaA=;
 b=fvw8HFRCs9Glzjt8OrxVx0XwpEhAo00y/WURGWsXSAr1mYon31FKhkvXH5W3MWXTzTb1cS
 0u4YElQPU1Gd94LAXKXk85RUCwySEwrqTKLwK/rhXVftQsN6ZPqmxvGVpa6TSiNS1pEJ+D
 RxXhmvgGmNoqnIPQJWwp5FEAoR/UfbJmUm21mgQCWCn9tervcbKwyOE0d5sQdL3BJC1Ax1
 UIM/VtU7IVWNDE+NUUtxG7wt5ROLnfrMCM9CHgZTWngYIqLB5C+JK0DbuAmnMK2bF+HEhk
 X1fcr84pXx9VDaSTGwtR9vIutJ7U/bNB0y0H2rIogI2/6SLVraopKJRpMgSpUQ==
Message-ID: <905b7b4b-a216-4bdc-868b-5b38efb61317@mailbox.org>
Date: Tue, 19 Aug 2025 13:10:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] stm32mp2: Add SPI flashes support
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Alexander Dahl <ada@thorsis.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Watts <contact@jookia.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <20250808151154.472860-1-patrice.chotard@foss.st.com>
 <827b1b5e-ac74-4710-8424-5bf0390441f6@mailbox.org>
 <9c805dc1-fc95-4d01-99cf-306264fd4b2b@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <9c805dc1-fc95-4d01-99cf-306264fd4b2b@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8t9wduq6jbmaqa9695chgspthzqampuu
X-MBO-RS-ID: 129ef360455819f3eec
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

On 8/13/25 10:53 AM, Patrice CHOTARD wrote:
> 
> 
> On 8/8/25 17:24, Marek Vasut wrote:
>> On 8/8/25 5:11 PM, Patrice Chotard wrote:
>>> This series introduces 2 new drivers:
>>>     _ STM32 Octo Memory Manager driver
>>>     _ STM32 OSPI driver
>>>
>>> It adds resource check helpers which are used by OMM driver.
>>> It adds and enables OMM and OSPI driver support for stm32mp257f-ev1 board
>> Can I test this with mainline TFA and mainline OpTee-OS ?
> 
> Hi Marek
> 
> Currently, it misses regulator support in OPTEE.
> But you can enable "manually" VDDIO3 and VDDIO4 in U-Boot console
Actually, I need to enable VDDIO3/4 even earlier, otherwise I get no 
UART and no I2C, so that's not a problem. VDDIO3/4 handling seems to be 
broken in the ST downstream TFA with almost 1000 patches on top of old 
version of TFA, and upstream TFA for STM32MP25xx is entirely bare bones 
that it barely works.

I also didn't manage to start upstream U-Boot on STM32MP25xx at all yet, 
I still have to upport about 400 patches (reduced from some 800 from ST 
downstream old U-Boot fork), and the result won't work unless I use the 
obsolete ST downstream OpTee-OS 4.0 fork with almost 1700 patches on top.

Maybe the upstream OpTee-OS is missing something, like the entire SCMI 
implementation ?
