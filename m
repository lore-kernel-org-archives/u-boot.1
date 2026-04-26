Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BC2FF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 21:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D06D2839D9;
	Sun, 26 Apr 2026 23:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="a4lOCsXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6590883FDB; Sun, 26 Apr 2026 23:03:32 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A399C80087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 23:03:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g3fLS2VGRz9skc;
 Sun, 26 Apr 2026 23:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777237408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91B/kSQ3bNGyivvgG5kPokUezxPzH64ZyAena6daXlM=;
 b=a4lOCsXIKg3OrI429Fd7rymI/HhZCVdE2kAxXwWPIw61DO/V0LJv4fjobNJkX8uPLocuHB
 XqAAN2rqgAvRA2crAI6qC6g3QBNl3jyKu/X6c3hrlfcxnDmrPr1W0EM8LlXh6tFu5w2urK
 dMH+nFbEgW1K//tNW7JNNPOOtknzMDC3O0ADbI2ztHdaOG6FuvZSbOF9XhPgIuj++3YN5h
 /++J6xzSocqNzu++DjuWUM0R5pvK/kbEK3E+SzB3HY7v7AluLUR1GwDBVqG6m1xk/ubzvE
 /eBUHzoF3A2N1hkWF5oj8qN2c/J8pGmotkq621k8yy/oep/OPtCZaWohLbwpjA==
Message-ID: <5918d7a2-bba4-424f-b5ac-b5342a89e5b4@mailbox.org>
Date: Sun, 26 Apr 2026 23:03:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm64: renesas: Add Cortex-M33 build option to R-Car
 Gen5
To: "Kumar, Udit" <u-kumar1@ti.com>, u-boot@lists.denx.de
Cc: Anshul Dalal <anshuld@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20260422224957.142539-1-marek.vasut+renesas@mailbox.org>
 <c7c0936d-adb0-4b6d-b726-0d3ee6f4775d@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c7c0936d-adb0-4b6d-b726-0d3ee6f4775d@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ix6qczdg58s4a57bwww55gdrwfg5kmrf
X-MBO-RS-ID: 86a0f501b2c0a207514
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

On 4/25/26 6:46 PM, Kumar, Udit wrote:
> 
> 
> On 4/23/2026 4:19 AM, Marek Vasut wrote:
>> The R-Car Gen5 SoCs contains Cortex-M33, Cortex-R52 and Cortex-A720AE
>> cores. Add U-Boot build options for the Cortex-M33 core.
>>
>> Since the Cortex-M33 core is a 32bit core, select V8M and ARM64 for
>> RCAR64 accordingly. Select TMU timer on the 32bit core, where it is
>> used instead of the ARMv8 timer. Adjust TMU timer base address to match
>> the address map of the Cortex-M33 core.
> 
> is there any reason, you can not use core's timer ?

I don't think there is one on this particular core.

[...]

>> +# Renesas ARM SoCs R-Car Gen3/Gen4/Gen5 (64bit)
>>   config RCAR_64
>>   	bool
>> -	select ARM64
>> +	select CPU_V8M if RCAR_64_RSIP
>> +	select ARM64 if !RCAR_64_RSIP
>> +	select TMU_TIMER if RCAR_64_RSIP
> 
> You can selecting TMU_TIMER, if this is M core, and later TMU_BASE is
> defined for A core, as well or I am missing something.

That TMU timer is accessible from both CA and CM cores, it is at 
different addresses for either core.

[...]

>> +++ b/arch/arm/mach-renesas/Kconfig.rcar5
>> @@ -1,5 +1,13 @@
>>   if RCAR_GEN5
>>   
>> +config RCAR_64_RSIP
>> +	bool "Renesas ARM SoCs R-Car Gen5 (use Cortex-M33 RSIP)"
> 
> Sorry but what is RSIP means here

Renesas Secure IP, but for the purpose of U-Boot, it is a Cortex-M33 .

>> +	select SKIP_RELOCATE_CODE
>> +	select TMU_TIMER
> 
> TMU_TIMER is selected here, then you can consider to drop
> select TMU_TIMER if RCAR_64_RSIP, in little above of this patch

Good point.

>> +/* Timer */
>> +#if defined(CONFIG_RCAR_64_RSIP)
>> +#define CFG_SYS_TIMER_COUNTER		(TMU_BASE + 0xc)	/* TCNT0 */
>> +#define CFG_SYS_TIMER_RATE		(133333333 / 4)
> 
> Please check for alignment
What kind of alignment ? Details please ?
