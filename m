Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE98C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 15:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE838877E5;
	Fri, 15 Dec 2023 16:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rK8/SMg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A224387A7F; Fri, 15 Dec 2023 16:00:41 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B0B87603
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 16:00:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e215f5a38so310494e87.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 07:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702652438; x=1703257238; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pvs5l1wWEDAwCNrVI7uwxS22mO/FO7Q0vFqQZD5qWPE=;
 b=rK8/SMg1PUZE6dEOkTX9JMZXSsU8iJzpBpuNmXFS6ihAG1OE0cNeHDMITgGXIirx98
 nKBSELF2ZecYPDn45459v+roPIImbttm/Ho9qk+vvPHT6BGPXRxP56qJCfcWOfbixSDr
 /wYtlqa5GIkoE3tVcLrWkftWJc1prs+Je4oxNPKiBgGNeGWiGk6pEnFZU8EYtuAuJ+Ob
 n/78fywOgq5WFcDzchhQtkCcDaex1pXUbAutzkzjjnYx8atUEofQXrQA4Z707NT4JgM3
 Op4dJfHM/TS2bjndzlGF/TAAd68Gvu4xtcamVQKPh2LMX29qQeEIflFJg39EusZP9ZoG
 scAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702652438; x=1703257238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pvs5l1wWEDAwCNrVI7uwxS22mO/FO7Q0vFqQZD5qWPE=;
 b=MKFz/g9qe9AnEy549We7tnYV0IOYD0Bhat5fHR3ZcVoGPM/21sT2KoTvQv8NM9btLy
 mSR45ceK/Hoqkn2stGmZuXZBV2JT6HGgzXOsQo5MCFZN92s+oZ3Cogblg29KwyCvn5We
 fbeWs+O8IRi5U47Wo1JCcrVMl/M0XRtX3rslJf6nVxR91VeFoCzPZa5vZ4zj0VIshzKd
 VU4YEH2kaU2rBdn4HeGabKHvfB2VXKEgpLmStGhnE4wO85/1Gl3L/7vYOQIGiceiDbdo
 2JlqfQJZnqKN/60mztfjeI3MXQv2ZouC9vevDjvNg2iJUng8vyPprn7UXNt+7Shuo1MU
 PwMA==
X-Gm-Message-State: AOJu0YyJmhr/0uTXN/F9dqSTCFGDaH1L+6Jq/jcpo8bjOEc+PUPdC4MG
 75vC1mt3OPokl1nAAQ+O2qKVJNk4HhL2A1vFI52lvg==
X-Google-Smtp-Source: AGHT+IFAGlmL0bxXYBhJHeTn1bv80zjeRyRHWFFWVufq36llbQCRRTHqh//aOIitwv+2G0rxn3Awe/j/4/8w+dNh5LI=
X-Received: by 2002:a05:6512:31d2:b0:50e:1fa1:5ffa with SMTP id
 j18-20020a05651231d200b0050e1fa15ffamr495139lfe.130.1702652437933; Fri, 15
 Dec 2023 07:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
 <20231215133245.7923-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231215133245.7923-7-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Dec 2023 17:00:01 +0200
Message-ID: <CAC_iWjKXjgT3DS=wRvm_KHOEZ5YSsfCO3pbRKayPKp8DOzRJsQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] risc-v: add support for QEMU firmware tables
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 15 Dec 2023 at 15:32, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Enable the QEMU firmware interface if ACPI tables are to be supported on
> the QEMU platform.
>
> Enable the QFW MMIO interface if the QEMU firmware interface is enabled.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> v2:
>         no change
> ---
>  board/emulation/qemu-riscv/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
> index 2709c9ca1e..59cf66896e 100644
> --- a/board/emulation/qemu-riscv/Kconfig
> +++ b/board/emulation/qemu-riscv/Kconfig
> @@ -33,6 +33,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
>         def_bool y
>         select GENERIC_RISCV
>         select SUPPORT_SPL
> +       select QFW if ACPI
> +       select QFW_MMIO if QFW
>         imply AHCI
>         imply SMP
>         imply BOARD_LATE_INIT
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
