Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9D6C56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 21:11:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F73F60838;
	Thu,  6 Aug 2026 21:11:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZPGTVdfcigt; Thu,  6 Aug 2026 21:11:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 37CE260834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786050663;
	bh=tjyMOastO8Z5qZM8JHG3jWmP54bq7JJbCEQ/mebSy0g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ak6UZJZ1JdrA4W3T0l1Ocw9k4iVtUGMAdHcV50o/GzEecI0FKkYkc4JeYVxJR3EAr
	 Eb/+6Xgb3GBPFuqYznWnMp2k3hGvyl0rN4YnVGlDv+SUU+TllpP+Ug7ddzcm4qgPWk
	 XoCgLy66fKLELCQS0uyrInQBQDNIaZZMs1JaRR9F2JsDKMxiGrzBIQR9er0dp7A1wt
	 Cq+vC3ij+B51fp7ixiR93M3E0ncxYIIaSEK2emAL0fHoRl0m2tVeYNgv4JefZvPg7/
	 Hpm0Hw4pCqPx9dzbFUHeMdtI/ZlAQqLEyeGin6cEyu1FTipP8q4U0yZBxayRu+6P2Q
	 jI4NsR7SU1ysQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37CE260834;
	Thu,  6 Aug 2026 21:11:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DBEE23F
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:11:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B2F980F2C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:11:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BtiJ798yNMav for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 21:11:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B1DDB80F31
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B1DDB80F31
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B1DDB80F31
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 21:11:00 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2020421077so442524666b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 14:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786050658; cv=none;
 d=google.com; s=arc-20260327;
 b=E3F4DqQj8CTW3xWA66tM+A+0cCc+roOHgBnR2YRq5Sk8e1sGYTuVFW+P9K/hWWncdw
 ARPTIQHHFuhb3WsK2pd7uEYCac9VKjxKIGfee3rw0nqCZaX+my5NMCBvaHFVkiOUHUI6
 cTemJwUfmMhShhmoWWlZ9zhw7JWMxkkNWhpf71BtYtgHg/Px3wUAJiNVzOcpQ5MwSsDn
 fVZa7xfUWr4uXQlTlt64XWKy4RLIWVnV3vkNhshBy79RrHXnHoIEn2FnV1xoI+N7lU47
 aAe+zbmOIoE9PpZQGEVLXg/8lzBkPjE2gLDuW1AJgFES0MV5NL4st0AI9tRCYcaYBsUu
 VEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tjyMOastO8Z5qZM8JHG3jWmP54bq7JJbCEQ/mebSy0g=;
 fh=Ye9d8c9UuIgjdEYE5AmpFdHtipkFyQbZju95WIBagdg=;
 b=JfTqwgSyuwPNYAjI7cCr2azb5HQkXvhNRzFAu6CaM44VaAi9o14S1tp07hqA1Mq64A
 Y2pT4UUAR3tV7MxBt9mchRfKCGIYVrBW2vW9WyxVX6cTqpPWyzq4FFhrA4zRUWfm1Dwi
 7UmlbbUhaqI75YOuEY1+6t2CRCef4W8AifzV5N8oQ4vkMjNsYcr56oJiFBeDRgm2gdRv
 UnZvvn+fr2uyXpj17qhWEiAcguZ5YlSugzLFdajycQFfCrRVKAjbB3DlHS2BoFnKptKw
 6q8rfYnNpXGpt4mGjCTtPgjlrzZZ0Dakf7hwkPDPDp3qtA5TeHrUmrhwXQpy2CsfMBEv
 2RBQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786050658; x=1786655458;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tjyMOastO8Z5qZM8JHG3jWmP54bq7JJbCEQ/mebSy0g=;
 b=csPgSRbPUDwyVtROHw/5vQE1V8WCnH90JggcuHM2kKAIVxj88j8XcrvfEbAhmnAKdQ
 efHzGSuZn1TNfSsCmSgmLNPVpOhtlSbHSkveq8LdOGzub/8coTvQOIoaNdjwcXR1sl/4
 CmVIO4FofXhxgcDB9rRb9GlCkrYJZTKIGzCmT0/PiiR3bJUx4Xvy/na14rbFZJZkLPGo
 /xs1aiL4TxAw7x1wPZ5bTByBntWCR0pXtj9+oz1cI/q/u4TQ10FIZGXSmxXw3v8sHOYz
 3mlVgqcH/z/3z18Fgaz0WovwcjnSWJCO3P0g+noZu8bEgAEN8/XdtyoZzKzcBk3lE9TH
 ptCg==
X-Gm-Message-State: AOJu0YwmisohsXHINF5gfwlLEfDbGV8pEw188eh9frddUHoF1DqdIyMY
 E4rNPuwf4zORalG53k/+XweLjbOGTrxOzIt+ly5DDLxHS1p6p87Me57qHDqtOxdEgmC2LHM+Xhu
 8lVJ/3cUYl0sbIKznWo++1ZF4VzuiEWdLASm+hdxr8AUu3XKVeeU=
X-Gm-Gg: AR+sD11w9TRK4AxLF4gJm3es9hxX6rUSesk5eNGiJfBYyADl95HPesJTw7nUosVYKnv
 ++V0Ql232icxecKotyKbeaiimCyKzII1bK8Qou7fg0WaUy4y3CakUsb7swp6IwC/69V6tco5oM4
 xGOzJE6uM62d5hjC9w5JGsx86i5xoq5FKV5vk0ZYog38JxKp/JFdSt58BT0x2aHj9e/F/vHnCz6
 gq2WqEGRulDkFBVrxMynZA3+UY07pyY0NKztRSo0FdIqtvGopPsL9il18h5qGyUVemKcNDmlMfe
 Qe82Ah2zW0IAdSET/t21y6N2w441TIZGNnQWolGxrbY=
X-Received: by 2002:a17:907:7b83:b0:c15:ffd3:da25 with SMTP id
 a640c23a62f3a-c2039d05581mr935315066b.28.1786050658554; Thu, 06 Aug 2026
 14:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
 <20260804-am62lx-v4-7-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-7-01746157643d@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 15:10:45 -0600
X-Gm-Features: AUfX_mwndesHUqzmHvp0fQW0lZeMmocyLrzLA6SD1J7mwWDwHBa1LRQwJzLVEsk
Message-ID: <CAFLszTgyg2Crj4ksqj5UoSEd1go3Q8-Zb4NnORGq8b=ZTgf+Vw@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] arm: dts: k3-am62lx: Add binman support
To: bb@ti.com
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786050658; x=1786655458;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tjyMOastO8Z5qZM8JHG3jWmP54bq7JJbCEQ/mebSy0g=;
 b=XeuilPJ718+RQaF8JIJFjFLFwxADujECR7aYYD8XKo0hp/5V8XjTR0jD4MmMTOenXh
 F4VJFhdy1oYoYNwavLBB7D2R4/N+d9eC6kupX7UizfwhJ/AqvsvabIrLe5MeRJ3qz4qD
 whb1JVNA2RHX6U/vfjZiXllCdE4fVCP13fSwI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XeuilPJ7
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Vignesh,

On 2026-08-04T21:55:02, Bryan Brattlof <bb@ti.com> wrote:
> arm: dts: k3-am62lx: Add binman support
>
> Add the initial configuration to build the boot binaries for the AM62L
> family of devices
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
>
> arch/arm/dts/k3-am62l3-evm-binman.dtsi | 218 +++++++++++++++++++++++++++++++++
>  arch/arm/dts/k3-am62l3-evm-u-boot.dtsi |  12 ++
>  arch/arm/mach-k3/Kconfig               |  21 ++++
>  3 files changed, 251 insertions(+)

>     arm: dts: k3-am62lx: Add binman support
>
>     Add the initial configuration to build the boot binaries for the AM62L
>     family of devices

The body needs more context - how this differs from the existing
k3-binman.dtsi (why AM62L cannot reuse it), and why the new Kconfig
options are being introduced now.

> diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0-only or MIT

Per the SPDX spec the operator is upper-case OR, i.e. GPL-2.0-only OR
MIT. Every other K3 binman dtsi in the tree uses plain GPL-2.0 - is
there a reason to dual-license this one?

> diff --git a/arch/arm/dts/k3-am62l3-evm-binman.dtsi b/arch/arm/dts/k3-am62l3-evm-binman.dtsi
> @@ -0,0 +1,218 @@
> +             fit {
> +                     description = "U-Boot fitImage for AM62Lx SK";
> +
> +                     images {
> +                             uboot {
> +                                     description = "U-Boot for AM62Lx SK";

This board is the AM62L-EVM, not an SK, isn't it? Please update both
description strings (the two k3-am62lx-evm ones look correct already).

> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> @@ -129,6 +129,26 @@ config K3_EARLY_CONS_IDX
> +config K3_TIFS_LOAD_ADDR
> +     hex "Load address of TI's Foundational Security (TIFS) firmware"
> +     default 0x40000
> +     help
> +       The load address for TI's Foundation Security firmware. This value is
> +       used to build the x509 certificate to tell boot ROM where to place the
> +       TIFS firmware in memory.
> +
> +       Unless you know what you're doing. Do not change this value.

The last line reads as two sentence fragments - how about 'Do not
change this value unless you know what you are doing'.

Second, these options are unconditional so they appear for every K3
SoC, but only AM62L3 consumes them - every other K3 binman dtsi still
hard-codes 0x40000/0x67000. Either gate the prompt on SOC_K3_AM62L3
(with per-SoC defaults) or convert the other dtsi files to use these
too. Introducing a global knob that only one SoC honours is confusing.

> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> @@ -129,6 +129,26 @@ config K3_EARLY_CONS_IDX
> +config K3_TIFS_DATA_LOAD_ADDR
> +     hex "Load address of TIFS configuration data"
> +     default 0x6c000
> +     help
> +       The load address for TI's Foundation Security configuration data. This
> +       value is used to build the x509 certificate to tell ROM where to place
> +       the TIFS firmware.

The help text says 'place the TIFS firmware' but this option is the
load address of the TIFS *data*, not the firmware itself.

Regards,
Simon
