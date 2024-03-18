Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3A4C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6AF7879DC;
	Mon, 18 Mar 2024 09:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="wBRy0GSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E12187D66; Mon, 18 Mar 2024 09:27:13 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235B087666
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710750428;
 bh=eDiOjpgAf+ic7g2AcBxlxNCp+phFl9Gaq7feo3C/eUQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wBRy0GSGEvoY/5y17NF1LjLDjgOxcFxaG7W8XCJ68EDOOmPWjb+IYJGG8FT11nty5
 xcV+YKq+hfGn7bl7jwNVl5AKTVy3V1brrnH21ZYpVjFNgMTBZ0rRSd2tM/jJvWI+Bt
 F6pidIfaOOGub273xIyTWqSoxYdkq+sHC1hIJHuyGxNOJJ8pLBPTyLjjpC/mH+OTOz
 Xzm84gz6xvJuouzGEqmiOUQaxAG0HJCGrG6aOYC0pRtYBKkvm3pdTIGUISPEG1Gs9k
 lnGyEFQp9YqGrqrfskvE7MAw/1vYWuJsQACJNpHHqNgO19ra9Xrd27hkydnug1gpeK
 BeHQeOTsH1KeQ==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 426EB3781FCE;
 Mon, 18 Mar 2024 08:27:07 +0000 (UTC)
Message-ID: <00241bf0-2543-4836-b43f-1b6452caf2e6@collabora.com>
Date: Mon, 18 Mar 2024 10:27:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
To: Mihai.Sain@microchip.com
Cc: Balamanikandan.Gunasundar@microchip.com, ada@thorsis.com,
 michael@amarulasolutions.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
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

On 3/18/24 10:09, Mihai.Sain@microchip.com wrote:
> On 3/7/24 11:10, Alexander Dahl wrote:
>> For now adds one new command 'hsmc' with a single subcommand 'decode' 
>> to read and display the content of the registers of the Static Memory 
>> Controllers (SMC/HSMC) found in different at91 SoCs.  Needed to get a 
>> better picture on what raw nand core and atmel nand controller driver 
>> try to set as timings based on ONFI parameters of the connected NAND 
>> chip.
>>
>> Tested on SAMA5D2 and SAM9X60 based boards.  Example output:
>>
>>     U-Boot> hsmc decode
>>
>>     mck clock rate: 200000000
>>
>>     SMC_SETUP3:     0x00000002
>>     SMC_PULSE3:     0x07040703
>>     SMC_CYCLE3:     0x00070007
>>     SMC_MODE3:      0x001f0003
>>     NCS_RD: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
>>        NRD: setup: 0 (0 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 7 (35 ns)
>>     NCS_WR: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
>>        NWE: setup: 2 (10 ns), pulse: 3 (15 ns), hold: 2 (10 ns), cycle: 7 (35 ns)
>>     Standard read is applied.
>>     TDF optimization enabled
>>     TDF cycles: 15 (75 ns)
>>     Data Bus Width: 8-bit bus
>>     NWAIT Mode: 0
>>     Write operation controlled by NWE signal
>>     Read operation controlled by NRD signal
> 
> Adding Mihai as he is usually very interested in such debug information and methods.
> 
> -------------------------------------------------------------------------------------
> 
> Hi Alexander,
> 
> I tested your work on sama7g54-curiosity board:
> 
> U-Boot> nand info
> 
> Device 0: nand0, sector size 256 KiB
>   Manufacturer  MACRONIX
>   Model         MX30LF4G28AD
>   Device size        512 MiB
>   Page size         4096 b
>   OOB size           256 b
>   Erase size      262144 b
>   ecc strength         8 bits
>   ecc step size      512 b
>   subpagesize       4096 b
>   options       0x00004200
>   bbt options   0x00028000
> 
> U-Boot> hsmc decode
> 
> mck clock rate: 200000000
> 
> HSMC_SETUP3:    0x00000001
> HSMC_PULSE3:    0x07040804
> HSMC_CYCLE3:    0x00070008
> HSMC_TIMINGS3:  0x880402f2
> HSMC_MODE3:     0x001f0003
> NCS_RD: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
>    NRD: setup: 0 (0 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 7 (35 ns)
> NCS_WR: setup: 0 (0 ns), pulse: 8 (40 ns), hold: 0 (0 ns), cycle: 8 (40 ns)
>    NWE: setup: 1 (5 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 8 (40 ns)
> TDF optimization enabled
> TDF cycles: 15 (75 ns)
> Data Bus Width: 8-bit bus
> NWAIT Mode: 0
> Write operation controlled by NWE signal
> Read operation controlled by NRD signal
> 
> Best regards,
> Mihai Sain

Hello Mihai,

If you have any suggestions for improvement, changes, or you are happy with this
command, is it useful ?
You can provide your Tested-by then if you consider this is useful

Eugen

