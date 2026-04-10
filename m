Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FB1F36B9A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 01:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55F8183DC9;
	Fri, 10 Apr 2026 03:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XoD2lk+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5F284105; Fri, 10 Apr 2026 03:24:17 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E86783CF5
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 03:24:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fsJx92KhWz9twx;
 Fri, 10 Apr 2026 03:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1775784253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tYYvxDEeU9uxEAlwNEatc73SNIozCf9NUpuGBnKxTt0=;
 b=XoD2lk+SgYABve51+BsFwu6ULUfLGWTboNvNcC4MzxEY3xgN9OjU0XZ2Oy6r9cRb/L62/o
 4URXYGekm04Q6TlWLem7BAuqucOPehsQ1yzyTquAWNB2D9NwzWowc/3zROsbTAlmEQ6ABG
 /ot1yppZVKdLk7ZBxA7VTPd/5K1PAHcgavq3FFUfePDlzpnAbekHlzwv/eOxq8UDg6X3w0
 Mu/S6Zb89zfvpJugngRKAL1SI5ZrIi6XzxUrBIWe+Db2pG+j9sRDqOQ4mR0okZI9zCzJaf
 Tab4d+grR5JODWFMSYTuFAEyUcyTLV31WL9qKx2/av0sedTKCyKmBNRtrzJ68g==
Message-ID: <a03ecada-fa00-41ce-99ff-cc1a2a8362b3@mailbox.org>
Date: Fri, 10 Apr 2026 03:24:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm: Add ARMv8-M aarch32 support
To: "Kumar, Udit" <u-kumar1@ti.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260329231442.332359-1-marek.vasut+renesas@mailbox.org>
 <c8a97353-0c3d-4d98-8252-c0bb91a658a5@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <c8a97353-0c3d-4d98-8252-c0bb91a658a5@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 895b722a46148d36a84
X-MBO-RS-META: ohozfnupwmtd8sh3ad1exem1tiu84jmn
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

On 3/31/26 8:04 AM, Kumar, Udit wrote:
> 
> 
> On 3/30/2026 4:44 AM, Marek Vasut wrote:
>> Add configuration for ARMv8-M aarch32 core, which are currently
>> Cortex-M23/M33 cores. These cores are treated similar to ARMv7-M
>> cores, except the code has to be compiled with matching compiler
>> -march=armv8-m.main flag . These cores have no MMU, they have MPU,
>> which is currently not configured.
>>
>> Unlike ARMv7-M, these cores have 512 interrupt vectors. While the
>> SYS_ARM_ARCH should be set to 8, it is set to 7 because all of the
>> initialization code is built from from arch/arm/cpu/armv7m and not
>> armv8. Furthermore, CONFIG_ARM64 must be disabled, although DTs
>> for devices using these cores do come from arch/arm64/boot/dts .
>>
>> To avoid excess duplication in Makefiles, introduce one new Kconfig
>> symbol, CPU_V7M_V8M. The CPU_V7M_V8M cover both ARMv7-M and ARMv8-M
>> cores.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Casey Connolly <casey.connolly@linaro.org>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Udit Kumar <u-kumar1@ti.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V2: - Rename CPU_V78M to CPU_V7M_V8M
>>      - Isolate V7M specific and otherwise option bits in cpu.c
> 
> Thanks for v2 Marek,
> Apart of name of config discussion over v1 [0].
> 
> For changes,
> Acked-by: Udit Kumar <u-kumar1@ti.com>
> 
> [0] :
> https://lore.kernel.org/all/30108d25-efd6-4ff6-9bfe-0dc55670a83f@mailbox.org/
Tom, is the naming now OK ?
