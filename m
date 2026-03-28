Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2839010BA424
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 06:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA4A83FA3;
	Sat, 28 Mar 2026 07:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fjRzWW1X";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KNBUR8lJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827CA83FD9; Sat, 28 Mar 2026 07:44:14 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4897583F14
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fjSfH74CJz9tC6;
 Sat, 28 Mar 2026 07:44:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774680248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dX60bXGN/yL5iTb298pEnsUYHhW3NeCgQrDccMJsg3w=;
 b=fjRzWW1XytaSqMPkFPhbB012Py97NrIZGx5VE3GXE+wESHw3lx7drKxyv63OkeTLTaFel/
 g9Rh6ingdFoaykiizOe4qhicLWVt0HthDLOtSavtryaXC3B2VVyxc3Gw8vA9fj697lqxZZ
 m0fGuoj69WfEySdjMMUCIsVONHxcx0dlnJozsN5aVoVDA3jXQWK66pqIn7EUUyjdBVLdLd
 KypPTxcMV4eGewXfw5NvE06Ydb/WVn92NqkKhj+6T5KrKO02nKEhVJ78trOV3wK2dWaBQk
 L2F3lSfFYlQ0bFCrjRGTUIwNd07EMFEJf0gHe0FTy9CgajdguSw65j+K2IvsTA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KNBUR8lJ;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5d08b02a-9d74-4988-b308-c8d217dad2fa@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774680246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dX60bXGN/yL5iTb298pEnsUYHhW3NeCgQrDccMJsg3w=;
 b=KNBUR8lJ1MNiunnHVIXucdLheVJNxqcWbNI5puX2m/j+6MEgK8i2lttZa4S37VQ4s0e/6A
 KyIgmDKLweYZdKQcg/BhQJsz8zSvQSo5e0P7p4Hs2fR5l9Ap9Y3PdqtCez/3TDk7/U2+aZ
 a2tg8IIF5Eeny4MfLF9usjG0/XKXkxQMhNAdxZWMfiKdELMHs/jdWKiCmbG0O/Q7FnsBTR
 CBve9kiOvFqW5VJYi0sqCMTCJyxoSFZavXnqsWUgAvNz7N4Fwk60z8nIRP/5J90ORFMPZN
 3RxnWWoYIH0zGa8YyrcMUQIjNB6bHUQbkiAed5shzgVqAm/jc6J9aL+Iz2lT9Q==
Date: Sat, 28 Mar 2026 01:07:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjKpGKM5ATDZkGLPKTNj2DycxNTjhag_ez7ziOMSQRZR=w@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjKpGKM5ATDZkGLPKTNj2DycxNTjhag_ez7ziOMSQRZR=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jbmxbj6xg5puhjtekfsjffjsk8164qbt
X-MBO-RS-ID: 41a3a1f901515fe8b1f
X-Rspamd-Queue-Id: 4fjSfH74CJz9tC6
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

On 3/18/26 7:59 AM, Ilias Apalodimas wrote:

Hello Ilias,

>> Introduce new mode of relocation which relocates only data, not code.
>> This is mainly meant to relocate data to read-write portion of the RAM,
>> while the code remains in read-only portion of the RAM from which it is
>> allowed to execute. This split configuration is present on various secure
>> cores.
>>
>> The result of the relocation is U-Boot running at its original address,
>> data relocated to the end of DRAM, but with added read-write area offset.
>> The U-Boot binary area is not reserved from the end of the DRAM in this
>> relocation mode, because U-Boot itself is not relocated.
> 
> We should mention at some point in the commit message that this is for v7 only.

I actually do use this on V8M .

> [...]
> 
>> +config SKIP_RELOCATE_CODE
>> +       bool "Skips relocation of U-Boot code to end of RAM"
>> +       help
>> +         Skips relocation of U-Boot code to the end of RAM, but still does
>> +         relocate data to the end of RAM. This is mainly meant to relocate
>> +         data to read-write portion of the RAM, while the code remains in
>> +         read-only portion of the RAM from which it is allowed to execute.
>> +         This split configuration is present on various secure cores.
>> +
>> +config SKIP_RELOCATE_CODE_DATA_OFFSET
>> +       hex "Offset of read-write data memory from read-only text memory"
>> +       default 0x0
>> +       depends on SKIP_RELOCATE_CODE
>> +       help
>> +         Offset of the read-write memory which contains data, from read-only
>> +         memory which contains executable text.
>> +
> 
> Similar concerns with Tom for limiting the Kconfig selection. Do we
> need a depends on the armv7 arch for now ?

No, because I use it on V8M.

>> @@ -126,3 +145,9 @@ _rel_dyn_start_ofs:
>>          .word   __rel_dyn_start - relocate_code
>>   _rel_dyn_end_ofs:
>>          .word   __rel_dyn_end - relocate_code
>> +#ifdef CONFIG_SKIP_RELOCATE_CODE
>> +_data_start_ofs:
>> +       .word   __data_start - relocate_code
>> +_data_end_ofs:
>> +       .word   __data_end - relocate_code
>> +#endif
> 
> Where are these defined? __data_[start|end] only seem to exist for x86
> and microblaze

Currently, I have to use own linker script, the data section looks like 
this:

"
	. = ALIGN(4);
	.data : {
		__data_start = .;
		*(.data*)
		__data_end = .;
	}
"

Any system which will use this will have to patch the start/end in their 
data section too, or ideally if they use generic linker script, patch 
that generic linker script to emit those symbols. Maybe we should patch 
at least arch/arm/cpu/u-boot.lds ?

> [...]
> 
> Overall this seems to be needed, I am a little concerned about test
> coverage, since this will be fragile when changing asm and/or linker
> scripts. But OTOH I dont have any bright ideas on how to test it
Maybe QEMU can be extended with Cortex-M support ?
