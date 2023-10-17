Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA5BCDB474
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 01:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BDC786F25;
	Wed, 18 Oct 2023 03:25:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IaXf30Ew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8193786F12; Tue, 17 Oct 2023 19:59:41 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B36D86940
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 19:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so3721995e9.0
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697565578; x=1698170378; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PdhHxa2FNCR64O0hhskw4I5qZVx0d2fGojZJ+6b5PfU=;
 b=IaXf30Ew4Ax/lOe9Bx0bTSKskDRy0DxjlFR63f0Y8XWcBdU4iNhQt1kwu7ljwH/w/e
 PZbZWfKtp+CZRXDMrcwOJw4vlII359yXIu+gbjJRKOS/yAoxd8EwztF/ZYNQ+EhSSCFQ
 6Thtk297sXK2V+lAgWgdfxS/wVCbndkwo5izkRaDWRV4s+KtVhW03TscXfwzEq/b2PQl
 lLaxm3fKPREni1FEDU5lQJsSjNp7zvSyxM+LtZoUsgCgFqe6RFunFF/TuN3uW7rAdFLp
 EhGNwEdzNdbFP8CFFCmQe5UURPhasL9+a7dMjScBar8y9bASPqxo4lUe+RIJskYKdD74
 48ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697565578; x=1698170378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PdhHxa2FNCR64O0hhskw4I5qZVx0d2fGojZJ+6b5PfU=;
 b=knCBCNUGbIt45sJkBuAcbPwSpuYPu4EDtAVFbsWiI3JCi3XApFaJTqU2Ae0NUnfDXq
 dnCJNjZLbRAdt+4HBE8Z0keUGeAPCkTyMpxy9RRLVAnuLlwcg7fEf01L0AEEiKeUCQuh
 NYiKaKytbqKlHCZPVnTPZ6O5ERzOvyGOBIuVjyNvUFeB6XA9ZyPpLmdq/12++bFtmcNu
 yijyuLPQbFUAJ2JR3/u0RcmNATRO/Umm9LODLN6WQFckQGr0s0lQTUJU9svO9niFGh/F
 f8OvEQ/NQvfX2rUaGF/mw+kId1EBk6+QYo5Z4bz2tGvWbOMUwLwX5fkt5gLOcmjZ7ac2
 FfhA==
X-Gm-Message-State: AOJu0YwAHoOR134s29XlDFMXcGm81Ke1HXhhU45ahFGvy8V8wB5CCN15
 B2wEGoyIcNLKCwmt94VzfLiRbw==
X-Google-Smtp-Source: AGHT+IH8KVnOe8usGdiAsDt1PM5a1TWzsyKEb/jKyTI7AsymAjAH9tgxgi4ucxCcAp6yUIp7OPpk7g==
X-Received: by 2002:a05:600c:3587:b0:405:4daa:6e3d with SMTP id
 p7-20020a05600c358700b004054daa6e3dmr2230596wmq.39.1697565578632; 
 Tue, 17 Oct 2023 10:59:38 -0700 (PDT)
Received: from [192.168.1.15] (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 k8-20020adfe3c8000000b0032710f5584fsm284809wrm.25.2023.10.17.10.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 10:59:38 -0700 (PDT)
Message-ID: <a163b0a2-3ba8-4149-b696-4eb80a57f10a@linaro.org>
Date: Tue, 17 Oct 2023 18:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] smbios: Use SMBIOS 3.0 to support an address above 4GB
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231008213646.622002-1-sjg@chromium.org>
 <20231008213646.622002-4-sjg@chromium.org>
 <4295df86-0a0b-420f-b8d2-ed5c930ea9ee@gmx.de>
 <CAPnjgZ2Tt-=Botwz7QotJYJ9SxKBvS7Tx=C35+j+CRWOLD9ZbA@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAPnjgZ2Tt-=Botwz7QotJYJ9SxKBvS7Tx=C35+j+CRWOLD9ZbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 18 Oct 2023 03:25:10 +0200
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

Hi Both,

[...]
>>>
>>> @@ -513,13 +517,23 @@ ulong write_smbios_table(ulong addr)
>>>        */
>>>       table_addr = (ulong)map_sysmem(tables, 0);
>>>       if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)UINT_MAX) {
>>
>> You have to check the end address of the table not the start address here.
>>
>> The SMBIOS specification says that you should always supply a 32bit
>> SMBIOS entry point. Of course this is not possible on boards that don't
>> have low memory.
>>
>> In install_smbios_table() this can be achieved by calling
>> efi_allocate_pages() with EFI_MAX_ALLOCATE_TYPE and a maximum address of
>> 4 GiB - 1. Only if this fails use high memory.
> 
> Hmm perhaps we need a way to allocate memory below 4GB in U-Boot? How
> does this EFI function work?

Yes, prior to 53fab13a7b11 ("efi: Use the installed SMBIOS tables")
efi_allocate_pages() was called directly from efi_smbios_register(). My
boards all malloc() memory above the 4GB boundary and I just recently
rebased and hit a regression caused by this.

In my testing, calling efi_allocate_pages() from install_smbios_table()
did work, but I figure that's probably not intended behaviour...

I can confirm that this series does allow my boards to boot again, but
dmidecode is unable to decode the SMBIOS 3.0 table (even with
STRICT_DEVMEM disabled fwiw).

Below is EFI and board memory map info after applying this patch series.

=> efidebug tables
Cannot read EFI system partition
Cannot read EFI system partition
Failed to persist EFI variables
000000017ea22040  32313633-3532-3634-2d66-3765662d3463  EFI Conformance
Profiles Table
000000017ea21040  36366265-3139-6138-2d37-6565662d3430  Runtime properties
000000017fb13000  64663266-3531-3434-2d39-3739342d3461  (unknown)
=> efidebug memmap
Type             Start            End              Attributes
================ ================ ================ ==========
CONVENTIONAL     0000000080000000-000000017ea1f000 WB
BOOT DATA        000000017ea1f000-000000017ea21000 WB
RUNTIME DATA     000000017ea21000-000000017ea22000 WB|RT
BOOT DATA        000000017ea22000-000000017ea23000 WB
RUNTIME DATA     000000017ea23000-000000017ea25000 WB|RT
BOOT DATA        000000017ea25000-000000017ea26000 WB
RUNTIME DATA     000000017ea26000-000000017ea36000 WB|RT
BOOT DATA        000000017ea36000-000000017eaef000 WB
BOOT CODE        000000017eaef000-000000017fb13000 WB
RUNTIME DATA     000000017fb13000-000000017fb14000 WB|RT
BOOT CODE        000000017fb14000-000000017ff20000 WB
RUNTIME CODE     000000017ff20000-000000017ff30000 WB|RT
BOOT CODE        000000017ff30000-0000000180000000 WB
BOOT DATA        0000000180000000-000000027c7a0000 WB
=> bdinfo
boot_params = 0x0000000000000000
DRAM bank   = 0x0000000000000000
-> start    = 0x0000000080000000
-> size     = 0x0000000100000000
DRAM bank   = 0x0000000000000001
-> start    = 0x0000000180000000
-> size     = 0x00000000fc7a0000
flashstart  = 0x0000000000000000
flashsize   = 0x0000000000000000
flashoffset = 0x0000000000000000
baudrate    = 115200 bps
relocaddr   = 0x000000017ff26000
reloc off   = 0x000000017ff26000
Build       = 64-bit
fdt_blob    = 0x000000017faef6c0
new_fdt     = 0x000000017faef6c0
fdt_size    = 0x0000000000017680
Video       = framebuffer@9D400000 active
FB base     = 0x000000009d400000
FB size     = 1080x2160x32
lmb_dump_all:
 memory.cnt = 0x1 / max = 0x40
 memory[0]	[0x80000000-0x27c79ffff], 0x1fc7a0000 bytes flags: 0
 reserved.cnt = 0x7 / max = 0x40
 reserved[0]	[0x85700000-0x85cfffff], 0x00600000 bytes flags: 4
 reserved[1]	[0x85e00000-0x85efffff], 0x00100000 bytes flags: 4
 reserved[2]	[0x85fc0000-0x890fffff], 0x03140000 bytes flags: 4
 reserved[3]	[0x8ab00000-0x8c416fff], 0x01917000 bytes flags: 4
 reserved[4]	[0x8c500000-0x97bfffff], 0x0b700000 bytes flags: 4
 reserved[5]	[0x9d400000-0x9f7fffff], 0x02400000 bytes flags: 4
 reserved[6]	[0x17ea1f000-0x27c79ffff], 0xfdd81000 bytes flags: 0
devicetree  = board
arch_number = 0x0000000000000000
TLB addr    = 0x000000017fff0000
irq_sp      = 0x000000017faef6b0
sp start    = 0x000000017faef6b0
Early malloc usage: a78 / 2000
> 
> I don't think EFI has been set up by the time this function is called.
> 
> Regards,
> Simon

-- 
// Caleb (they/them)
