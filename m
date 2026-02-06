Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A52EEE20B9
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 17:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBBBC83A64;
	Fri,  6 Feb 2026 18:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HqL/t7ln";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nQ028O3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8846683AA7; Fri,  6 Feb 2026 18:09:58 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EB1836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 18:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f70vS2sQtz9thw;
 Fri,  6 Feb 2026 18:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770397796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7NiwOzXK47SUG3H0PjQUQWHOfsbIdCZK/G1ozgjiCv4=;
 b=HqL/t7lnlIU/X/YtFzyiNvPi+eCUfgQbATTefHxk10GaHS2m6rLMCyZRR8P9LQevy9MAFw
 atOqjcz8XeTF9fJ0VbpBpoypyBRs207UXUJXwBe83eNKbZyx8u3xVTdkw/A1QbVx1agkQP
 iTlEnHHpgGSl1CcJa5ep+TOjTuRFxOSByDWEDWAZma2Jql5egMlBKKvnmBBZnSUDq3PdpG
 Uy5wLWzoxqscQV55PrqSYh0WmwbdHMcFzRa3zDgoIKtetm31DUgvWHffO5obYGgAxVb/RK
 JgumYrcXfZg6PjSKTZ0Waoyn/VtPzq5KO6W/8l9NkxOuqR0tLons4/xvA3mBiQ==
Message-ID: <d3550af8-04ba-4cca-a062-5973f9dac251@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770397794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7NiwOzXK47SUG3H0PjQUQWHOfsbIdCZK/G1ozgjiCv4=;
 b=nQ028O3eVxs706Kk4uFE086Q3S5rt0Jec0+HWJ7Cw9sZKT7PevxhcS2sDQfn42AVHMM6Sq
 g0V2zqrIBWcA3wziDbjKvk2ZFSWWzHVADoD/FJodqDLi09F8mLwrdVmUpDio6hW+DKix2U
 GcqsP9eSUqqNHcJUhCcyHGa4KolHV9Py8N8zY/lChlwcd+eZdz4duiEVC3W2MzLZ1eDMcx
 sqZ+sN8tvQ8G/EvYo//cAKzaMnA36WGL4D3kVWmfnK4TYeir7a93vG58mYIKrB/x0YW1nI
 LvaApAxEllWA87mMG+D5uHcFvK1V87ShpjPhghUMlgzLKLKfzxas3xIcEkPZqw==
Date: Fri, 6 Feb 2026 18:09:49 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB
 without separate BSS
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Brian Sune <briansune@gmail.com>, Phil Phil Sutter <phil@nwl.cc>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
References: <20260130183635.2612933-1-trini@konsulko.com>
 <20260205234158.3768337-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260205234158.3768337-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: t4gzjqu9hy8gsjfyqtkf5qjbt55syicb
X-MBO-RS-ID: 051455a3259912baa94
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

On 2/6/26 12:41 AM, Tom Rini wrote:
> Historically, when we have an appended device tree and also our
> resulting binary will contain the BSS section, we have ensured that
> everything will be where it's expected to be by declaring that the BSS
> is overlayed with a symbol matches the end of the port

part ?

> of the ELF binary
> that is objcopy'd to the binary we concatenate with. This in turn means
> that the logic to generate a "pad" file, which is the size found in the
> __bss_size symbol, will be correct and then we can concatenate the
> device tree and it will begin at __bss_size at run time.
> 
> With commit 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
> we removed this overlay as part of trying to ensure that we met both the
> requirements of the device tree to be 8 byte aligned as well as that our
> logic to generate the -pad file would match what ended up in the
> resulting binary. While it was correct to remove an unused section it
> did not solve ultimately solve the problem for all cases.

solve ultimately solve ... one solve is enough

> To really fix the problem, we need to do two things. First, our final
> section prior to _image_binary_end must be 8 byte aligned (for the case
> of having a separate BSS and so our appended DTB exists at this
> location). This cannot be '.binman_sym_table' as it may be empty, and in
> turn the ELF type would be NOBITS and so not copied with objcopy. The
> __u_boot_list section will never be empty

How can we be sure of that ?

> , so it is our final section,
> and ends with a '. = ALIGN(8)' statement. Second, as this is the end of
> our copied data it is safe to declare that the BSS starts here, so use
> the OVERLAY keyword to place the BSS here.

[...]

> @@ -99,5 +99,6 @@ SECTIONS
>   
>   ASSERT(_image_binary_end % 8 == 0, \
>          "_image_binary_end must be 8-byte aligned for device tree");
> +
>   ASSERT(ADDR(.bss) % 8 == 0, \
>          ".bss must be 8-byte aligned");
Please drop this extra newline ^ .
