Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CD210BA424
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 06:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753EA83C14;
	Sat, 28 Mar 2026 07:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xhkwylN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60E783C5E; Sat, 28 Mar 2026 07:43:54 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E6A8394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 07:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fjSdy62Dbz9tty;
 Sat, 28 Mar 2026 07:43:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774680230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/kWXF/WwF6P2Bj3DXLCtSRXLQ8xJXWOg2dYhMFkX8Q=;
 b=xhkwylN5iyO1MehbMREYhdpr4meO5F4jFeoq8Dio0na/Mb6HnkINr4gru0hEYvY+cCjjqU
 QxvnEi3zbLhk8tyvCfVvyLOcGr9n8VlQ4DmgoGm1Sl5x68RWivf2XuhWE6HhztoT1YwZNQ
 6oTG6S9YEV04y/NVB0hz1njwwdNrMYt8BvVhYVWeMAl6UqCpHFKiy5cXLNBoxh/EOFpEKk
 u59r3AzAVn5Hkmo5Vz3+0xilN7uAxPkrbuyHClI5qHZ9D7qackwuU5nS2DMyf22crx2D7p
 pE2lfjJFg/u0hPI7nbtUDCIz22nkPUjuVbksadVZAQyrzBy6qI2i2cZmCpToEA==
Message-ID: <30108d25-efd6-4ff6-9bfe-0dc55670a83f@mailbox.org>
Date: Fri, 27 Mar 2026 23:20:07 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: Add ARMv8-M aarch32 support
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260325011414.288343-1-marek.vasut+renesas@mailbox.org>
 <20260327175222.GE502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260327175222.GE502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ba20704e2caad33551e
X-MBO-RS-META: abffy8wckjq9p6k5ybpwmxsid7jmk69p
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

On 3/27/26 6:52 PM, Tom Rini wrote:
> On Wed, Mar 25, 2026 at 02:13:57AM +0100, Marek Vasut wrote:
> way that it either can't be upstream, or wouldn't be handled externally.
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
>> symbol, CPU_V78M. The CPU_V78M cover both ARMv7-M and ARMv8-M cores.
> 
> My only feedback here is that I don't love "CPU_V78M" as a symbol name.
> Since we don't support ARMv6-M does a CORTEX_M or similar name instead
> sound OK? Or is there some other term that covers what is common to v7m
> and v8m (and what we care about in U-Boot) without implying things in
> other Cortex-M cores that we don't support?
CPU_V7M_V8M could be an alternative ?
