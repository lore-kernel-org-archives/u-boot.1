Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9253C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55FEE8083F;
	Wed, 29 Jan 2025 17:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NjIxIAVO";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oWifY90L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE45080843; Wed, 29 Jan 2025 17:42:28 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2DF08082A
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Yjnxs5bQHz9t1G;
 Wed, 29 Jan 2025 17:42:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738168945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuKwzkzgxSgklAEhXbT/Ze9kdUf8N+CsimWH5nTPPsg=;
 b=NjIxIAVOeiCixF7HRy66fhRm+I7Tq2VN1ASyt89ZbBzpkiQP26kiW0pKcHpUln26Qo1VmA
 Rw+6YI5b4wXAceLlH9hGWGdkT5ZBakg9Y9rE4oAWydMX7gFn5etghzPJOQEvEa8GMbKxrL
 fHxyzj3bWVakZVwX4dbfFCjqaBpKiO2PJCOLaV9gEf0oYhWsgIvHVWE4uLO44LZTPyTkSM
 VJyGMrZNi2axy11/q0HOMdAIHP77fq0g4018RI3KXuh2psB7lQj+JHeQV59O4/sWK0Fdu/
 rbFEym/XAMq7mkFuFl016ZLXsjyy//re3QPYaxUGu2Ap2/pqCHygpWgopEvANQ==
Message-ID: <cb34f827-0c8f-41a4-849f-52c8ba85bd1b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738168943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tuKwzkzgxSgklAEhXbT/Ze9kdUf8N+CsimWH5nTPPsg=;
 b=oWifY90LHnA/1GJghe3+BveMmYf9jKc2AWkvN7ZLq52EqgO9GNdNdG9KGGm6UDHNsAzI83
 W9edMbGTdPphDL9wXgSLrJoJ/V2lgEQ/TY5UwtxpdRtsIxcZCNOya2AzayLYHaYvgKSxa+
 pHSDB+LlMBMQDY+Nm5Mvc7WXfea+zhRvtuvo5mBF6jE8mMIJYdx4SK7AhAzo2HEZ6sKwuT
 crxFN7kzp4zRu3R2h71kPk8vMMSFapjZASNPMoAiDJB4ShYcsG/eB/VbHP/Q/f3bVm1jkV
 zZx3e4TOY72KpkfR5PdMi1CLkHHvRHWpcMCPVdpR9hpyaM/9xRqZtEKB9P1oUg==
Date: Wed, 29 Jan 2025 17:42:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/8] ARM: renesas: Simplify board Makefiles
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
 <20250118111621.362188-2-marek.vasut+renesas@mailbox.org>
 <3bf8432b-619c-4834-8d0c-c91f45a8f167@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <3bf8432b-619c-4834-8d0c-c91f45a8f167@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4j6mbx4dnmi5ksztwzftiqodhhfa5noe
X-MBO-RS-ID: f1762023657c700b5b8
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

On 1/29/25 3:54 PM, Quentin Schulz wrote:
> Hi Marek,

Hi,

> On 1/18/25 12:15 PM, Marek Vasut wrote:
>> Introduce board/renesas/common/Makefile and remove the multiple
>> duplicate copies of obj := ../common/*.o from board Makefiles.
>> Let the build system include the common Makefile using the
>> HAVE_VENDOR_COMMON_LIB and build the common objects that are
>> shared by all the boards that way. No functional change intended.
>>
>> Some of the remaining board files which include board specific
>> settings have been updated to use obj-y += to avoid rewriting
>> the board obj-y target and avoid dropping object files from the
>> build.
>>
>> The board/renesas/common/Makefile is now also used when building
>> RZG2L targets which also set CONFIG_RCAR_64 symbol and 32bit R-Car
>> Gen2 targets, however, this common code is specific to 64bit R-Car
>> only. Inhibit the build of this common code for RZG2L using extra
>> ifndef CONFIG_RZG2L and do not include any code for R-Car Gen2 so
>> far.

[...]

>> -ifdef CONFIG_XPL_BUILD
>> -obj-y    := ../common/gen3-spl.o
>> -else
>> -obj-y    := ../common/gen4-common.o ../common/common.o
>> -endif
> 
> Was this a mistake on Falcon? It used to use the gen3-spl while being a 
> gen4?

Falcon is V3U which is something between the two generations, but the 
SPL is not even being built, so the whole SPL part can be removed.

[...]

-- 
Best regards,
Marek Vasut
