Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4637DD42B8D
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F69884D2;
	Tue, 12 Nov 2024 15:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dG8cQDqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0EA89427; Tue, 12 Nov 2024 15:48:42 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2993C88F8E
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-539e3f35268so6359354e87.3
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731422919; x=1732027719; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=syhAMZtrtTLb0zkL/efXCZulgSVcvm58ZzJi2efssFY=;
 b=dG8cQDqWK1R1MrQrY4H+XxKQgBKS9YKMndJZLi534c34jLhi1F3ufkVRAYnjvQRstv
 fRvtuXOoUvjoIoWYQdkR1OgG7EO2omjGS80cIS47ptepoDF/3rGkyfPqzXgkFcvixlJy
 ghniZjZi1kn0KCkIxp9ivZEu/04xFpG8/lZ4eWgQOFDSO+cB/6qWWXrRRNdyAbnsxhiI
 e1orRCUo/swoK2Ce6KJByGnOL4mxl5Vdbl3OvwUXeBN9FTRrTXEsmhKm0qCiRoW3MBZ/
 iNCe0SMi3kdghDKxcb6kUPAJTpe4CIEXMTKA2kPAGS7QOQcWL9qLSQ/8AfZ/dAIqOcfh
 E8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731422919; x=1732027719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=syhAMZtrtTLb0zkL/efXCZulgSVcvm58ZzJi2efssFY=;
 b=HC7h4STAjDlvwPn1UN9CHnYUn0IfaWJZbEecj/sd0uDwBccAoDT3kG1KW7RYipWkqE
 komS4MTUpPn58JgVv/ddi5WEESA581e9H9vT3PXUiMySYJ5/PpLLwy/kBDevFaVUtjsI
 jVZxxsn21GuzGYSUeCHG6vedMafXzveppUFaMqrtwD4U5osfc/46/97aB2ubAwcrrbsu
 sczxo8JkJSnmqlqnX8JTywdx9pVQk0zavh9nJDkIbI4nj+ufWhGhsJwCSdud+8dF1Zw8
 0F4tj8z8fg5GZoonryoLp0srrEChmQt5Jjs5LzBLZlZE3LSzA5iVh6NYiR29eLBVzKde
 l9gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8RByz8NU3+lMzuRGNlXLxJM/iEbWwfNEC3HEveBPTJQgJAzsz8MXr2/JVUOggs/1fjucNmh4=@lists.denx.de
X-Gm-Message-State: AOJu0YybFQseVs5vOijHNApB5a5CrFFe0HMBgNpdoL1Bm4SqgqxQgaeJ
 BP8pBq1v4Mejs1ojLWqzkBNYpxouE9hDaoBC80VXXPijTIhKjJ2Dk4gJ/nq0stc8CPbrXdxBfUg
 5
X-Google-Smtp-Source: AGHT+IFDw0uXEStsgv5E0i/O3/Zy6UkMEtybpFdEWY3o94QJYh94xc+XfEXNf+Sla2bogbw69aFENQ==
X-Received: by 2002:a05:6512:39ca:b0:539:8d9b:b624 with SMTP id
 2adb3069b0e04-53d862ecd9dmr7147524e87.55.1731422919366; 
 Tue, 12 Nov 2024 06:48:39 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b5d7e6sm6109946a12.14.2024.11.12.06.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 06:48:38 -0800 (PST)
Message-ID: <d1ac9de0-2083-4f4a-a7c8-2f2e2e6d9f26@linaro.org>
Date: Tue, 12 Nov 2024 16:48:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mtd: nand: Update NAND manufacturer Ids
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, u-boot@lists.denx.de
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018083006.10349-6-b.spranger@linutronix.de>
 <56e48bdf-0dd0-469a-9acb-7c5b75c1a48e@linaro.org>
 <20241112145745.72d14afc@mitra>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241112145745.72d14afc@mitra>
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



On 11/12/24 15:57, Benedikt Spranger wrote:
> On Tue, 12 Nov 2024 15:39:23 +0200
> Eugen Hristev <eugen.hristev@linaro.org> wrote:
> 
> Hi Eugen,
>> On 10/18/24 11:30, Benedikt Spranger wrote:
>>> Align manufacturer Ids with the Id list from Linux kernel v6.11.
>>> While at it, sort the entries in alphabetical order.
>>>
>>> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
>>> Reviewed-by: John Ogness <john.ogness@linutronix.de>
>>> ---
>>>  drivers/mtd/nand/raw/nand_ids.c | 22 ++++++++++++----------
>>>  include/linux/mtd/rawnand.h     | 23 +++++++++++++----------
>>>  2 files changed, 25 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
>>> index 4f46378ffe1..e40facf774c 100644
>>> --- a/drivers/mtd/nand/raw/nand_ids.c
>>> +++ b/drivers/mtd/nand/raw/nand_ids.c
>>> @@ -180,20 +180,22 @@ struct nand_flash_dev nand_flash_ids[] = {
>>>  
>>>  /* Manufacturer IDs */
>>>  struct nand_manufacturer nand_manuf_ids[] = {
>>> -	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
>>> -	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
>>> +	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
>>> +	{NAND_MFR_ATO, "ATO"},
>>> +	{NAND_MFR_EON, "Eon"},
>>> +	{NAND_MFR_EON, "ESMT"},
>>
>> Did you mean NAND_MFR_ESMT here ?
> Yes, fatfingered that...
> 
> Regards
>     Benedikt Spranger



Unfortunately you will need a new revision anyway.

I get this while building sama5d4ek_nandflash_defconfig


arm-none-linux-gnueabihf-ld.bfd: drivers/mtd/nand/raw/nand_base.o: in
function `nand_reset_data_interface':
..drivers/mtd/nand/raw/nand_base.c:948:(.text.nand_reset+0xc): undefined
reference to `nand_get_default_data_interface'
arm-none-linux-gnueabihf-ld.bfd: drivers/mtd/nand/raw/nand_base.o: in
function `nand_flash_detect_onfi':
..drivers/mtd/nand/raw/nand_base.c:3884:(.text.nand_detect+0x318):
undefined reference to `nand_manuf_ids'
arm-none-linux-gnueabihf-ld.bfd:
drivers/mtd/nand/raw/nand_base.c:3884:(.text.nand_detect+0x31c):
undefined reference to `nand_flash_ids'
arm-none-linux-gnueabihf-ld.bfd: drivers/mtd/nand/raw/nand_base.o: in
function `nand_init_data_interface':
drivers/mtd/nand/raw/nand_base.c:1047:(.text.nand_scan_ident+0x1ec):
undefined reference to `onfi_init_data_interface'
make[1]: *** [scripts/Makefile.xpl:542: spl/u-boot-spl] Error 1



