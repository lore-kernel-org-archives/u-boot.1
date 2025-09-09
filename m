Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96979CA1016
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 03:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B2980422;
	Tue,  9 Sep 2025 05:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZEY5a2xQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA7C82A9E; Tue,  9 Sep 2025 05:02:34 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C95800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 05:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cLTBs6f68z9tVN;
 Tue,  9 Sep 2025 05:02:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1757386949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugXkDyHYbsYL4AcIheqsqrVSMYcV4foFlPzvgNCzYAg=;
 b=ZEY5a2xQmNp0wSA4zNsoM1s/mzBdnBiOwNkl9YxK1eD7Pn7OhztUqbgI2aFrKqWbkXp21J
 8P2oAlJVlktlFRDZtrkeYFNsmt5YtVF50fFXn6CQTBhSegjnkgBE6H71CQKnv77ZNMFYpr
 m+kYFQBLdNxTFvvApdC3O1PmXBK/1ZMa8mGUeB876yeio2ZjL0ffSnAWdJgTeVrpaioBfj
 6cn26/W9tPRrJsVdCMAHxuAcNSfsxoWO6foxwDDq2H+rf7+cWO86MmwQOaHrPPVHHSg/Xs
 Nm8uJZqD6SG/UwKei5U+7oF4MzyVxZNA8ZHwGNssbVG9fbCBJz1bXMgGYM5Jng==
Message-ID: <24ae4a7a-103d-49c5-90cb-3ad8ad3e4bab@mailbox.org>
Date: Tue, 9 Sep 2025 05:02:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] ARM: bootm: Add support for starting Linux through
 OpTee-OS on ARMv7a
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250630000832.952206-1-marek.vasut@mailbox.org>
 <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <97DFDFA0-80F7-462B-B2A9-BDBAD42A191A@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8b15603bb9f019ae87a
X-MBO-RS-META: 4mdihgwc6i7suyt3iamzgimse45dek3q
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

On 6/30/25 7:18 AM, Heinrich Schuchardt wrote:
> Am 30. Juni 2025 02:08:05 MESZ schrieb Marek Vasut <marek.vasut@mailbox.org>:
>> Add support for jumping to Linux kernel through OpTee-OS on ARMv7a.
>> This is only supported if U-Boot runs in PL1 secure. This change adds
>> two components, one is fitImage OpTee-OS loadable handler, which makes
>> a note of OpTee-OS being loaded and stores the load address for later
>> jump to it. The second part is the actual jump to Linux through OpTee-OS.
>> The jump through OpTee-OS requires set up of multiple CPU registers, r1
>> and r2 are passed through, r0 and r3 have to be set to 0, lr is set to
>> Linux kernel entry point. This setup is done by new assembler function
>> boot_jump_linux_via_optee().
>>
>> The boot_jump_linux_via_optee() also includes STM32MP13xx late TZC
>> configuration write, this cannot be moved easily, hence the ifdef.
> 
> Hello Marek,
> 
> Could you, please, add a documentation change to the series. This would allow reviewers to test your proposal.

The fitImage TEE bundling is already documented in the fit spec:

https://fitspec.osfw.foundation/

This here is an application:

"
/dts-v1/;
/ {
	...
	images {
		...
		tee-1 {
			description = "OP-TEE";
			data = /incbin/ ("/optee_os/out/arm-plat-stm32mp1/core/tee-raw.bin") ;
			type = "tee";
			arch = "arm";
			compression = "none";
			os = "tee";
			load = <0xde000000>;
			entry = <0xde000000>;
			...
		};
	};

	configurations {
		default = "conf-1";
		conf-1 {
			...
			loadables = "tee-1";
			...
		};
	};
};
"

"
$ mkimage -E -f fit-image.its fitImage
"

I can add that part to STM32 board docs ?

> Furthermore, please, provide tests on QEMU.
The test would require booting Linux, how do you propose we test that in 
CI ?
