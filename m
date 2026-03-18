Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92794FCD0C1
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 07:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA37841D5;
	Wed, 18 Mar 2026 08:00:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yzNoueYz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEEBA841D6; Wed, 18 Mar 2026 08:00:38 +0100 (CET)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77376841A2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 08:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so7340094d50.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 00:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773817235; cv=none;
 d=google.com; s=arc-20240605;
 b=cXaPwTn2l508cYZp5MtC/+ucj/nxCPoH7oejpMrGyH96XlMHoDmUdJrft+fgwTfCy2
 SVxSo+V7BgNQzOtyz3/PymgDuwEBZZ+vzis+SJHPPvHHQwicEBCRe627UGZoSxa3PIZL
 9a2M2MdgAJS97qhKRsNcGDZR+Wna96sstDq/Ny7gIvmM/Veky1hHVoM5svFeRhYQutWw
 Y7o931Cv4/3Cx5pc/17YmANvxg3SvfR+g0LAnXAGA7OHEqpXPOhxslqFZgAzv+XD4fK2
 FlUXEVc4cpZw349tdgZotMCefZCqw/sQEkx6AObOtPJxdH2FCVf2/RcMr1EM+X1J9cVC
 2rBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WxJqa7cIBwhp/FLIjGa7Om0Uzq1Ykzw+MfkwBRt86OM=;
 fh=8QWU3tIEDFp42gt9antBK247vzu12+ozBoWEtdwRcD4=;
 b=idKIe30Haf5RqUXwWnZTZz5RfpiUtMFJwDHIC/6GE77ImNPi80auSMDvpOoJG1gna3
 bGbudVJWmFBsLWovSfoxvgmt/pMk6gudQDsQ4cVsCKNpyTrPFcAYMugiEUoj/V4pztJW
 suYxMJ14YupnbZaBwrA836vX4oeRCuM0DzUlmP8Uzb25q1MoUTR++HNelQXRjU46AWax
 cMLx5E9Q+ngIUoeJtcvI2gAQ6nae77gkAlHbk3vVsazW9iLmMldbzYxqVSM+XLbN96ut
 cegYBirc890idEsjVQY7CO6VjyBU5uO4VlWb4d5/bBN0QB35HtwQXYLa8QAYIeHUqIJn
 lssA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773817235; x=1774422035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WxJqa7cIBwhp/FLIjGa7Om0Uzq1Ykzw+MfkwBRt86OM=;
 b=yzNoueYzzJ2J4espECsWzDjtomKEfZZJSbu/bzU1JvBiLQcPaAYLfNo70oP5n193qG
 A74nkxxZYVQc8YQuREZBUpDxH1XZKO4k8V7fQbOqipqaG4Pethobij6pY9X0lxkCAJP2
 2pF9Xe6g0E0jj0wcdG/BMrnPQ2C8/hgLYjcn9f79WlXV2GTtD2pz+DF/d5LEwqQDQzNM
 0pmqL5jghUcElDpH/avtQgWo0opu2bpmVih7aeW6YGjfP1JZyDZ2U5yXAv0E9Y1ZDwrp
 Hu+RIFB74XWf7KIshDdbws+YO7zfr0OWzlA0kFQ/n/paKRv8pB6Rldm9KnahmHYQ2AyQ
 MNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773817235; x=1774422035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxJqa7cIBwhp/FLIjGa7Om0Uzq1Ykzw+MfkwBRt86OM=;
 b=sCOWNVoPe5K0gqkVatQFfC5SqmChzJtlozNggfgrJ3yp2oPe+5/4VfRCzCaoZ7zd1p
 YFCIhdYp7XFK0tfRio0vS6v7k7vJggMrG76r9cELfB9KmAT02AYGYxkg4MClk6ucJaZM
 bYxFBNZTkOc0gQLKkP19kPZeyjGwEakK/e7bqnlMr8H6fdQVV9Xn9Vew7IUBTzTrhfs5
 MrCCf6idEWCQAZTevLq0FkTyeleYRpQEO1Y/3oeIgr8kGfpKtjjbgidy5TYtDYqDqh5n
 DUZS2qXJzMW+7Z1d4XjxEpuH6gvK7WNbHMM1oU6XQ9sgi/XuBKOHbbZsLIPaWmV11wSZ
 Z5dQ==
X-Gm-Message-State: AOJu0YxeTVuHtpKfinMOVkZRD4mO0nfgyKw4zoPNSxbBSwip1QgmtWsf
 JaeDHlcwrnzkvY6uJ90qp4a2K8ZSDYea5lpUYg1cia2F8QU839VGpilA/LDozvmKKMuUB2ZTpuu
 AqYlAXUip27rMvCJcMaNWXC2ayaPDIUvjXd+7d6r1Cw==
X-Gm-Gg: ATEYQzxC9Q0lNn+NDlSCjDlOpqCpOsNM6gOIyF0febypjEpY85QeA/YXjsU20KLLMTX
 5Le/psHGN7eM1ls/xz4WDbks6be5GwiOx/GSPOG0ryddL+7LDgRoy5pusF8eE7UUL1IuKXkEn0k
 agHvhT8FASqRGLLk6BeoWi3OREEsS5e0LYFv9KtaSUx4+A/FDI9VEL/d7EaIogwK/vIATDrA5xc
 dsOYOUjJAvHup25M7EciE4M6Pavnt+6SsZB/tvjm6mPruVKqpKpTb/Ctb/eAxSXDzv6aoO6fDFv
 0qqag6dyu/agdJLdOC6LAOGPBxD264vHVKqCnDvDm5fvSIl54zs5QQwcxBAPB4uy5aUlhFi7uGK
 CQ2N8Jev+eW0rba6ZuZYo5/gS0P/PaNXgxDiSbQtaBpm8YsYpy1bKT0dDFgsc2GMCBx1jl3K60m
 PKbH0cRYGuycMMteVN1tTTDxAcqjp7xtgYXHY+8gGLnoKYvQGPix8wJ0OQt5Hlp7UJdMcpdllun
 GfrldbxKcMyZmao4fSMnbRyRxOVPpcYjpNxK4JY4rCLkA9yQ+h9ctokOECNZhM/zJKsNcI6wD2P
 qm3hzf+kssn6JZhJFhColafxQZiYbEXb6tWoUh7ZsJbE
X-Received: by 2002:a53:eac7:0:b0:64a:d1bd:8c64 with SMTP id
 956f58d0204a3-64e9135134amr1930849d50.36.1773817234802; Wed, 18 Mar 2026
 00:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 18 Mar 2026 08:59:58 +0200
X-Gm-Features: AaiRm52vnF9NrXThOrGQOQmMchoTAn3Rv85HwlPpMAM6Fo0v2ponDNMuJhFO9fU
Message-ID: <CAC_iWjKpGKM5ATDZkGLPKTNj2DycxNTjhag_ez7ziOMSQRZR=w@mail.gmail.com>
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
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

Hi Marek

On Mon, 16 Mar 2026 at 01:55, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Introduce new mode of relocation which relocates only data, not code.
> This is mainly meant to relocate data to read-write portion of the RAM,
> while the code remains in read-only portion of the RAM from which it is
> allowed to execute. This split configuration is present on various secure
> cores.
>
> The result of the relocation is U-Boot running at its original address,
> data relocated to the end of DRAM, but with added read-write area offset.
> The U-Boot binary area is not reserved from the end of the DRAM in this
> relocation mode, because U-Boot itself is not relocated.

We should mention at some point in the commit message that this is for v7 only.

[...]

> +config SKIP_RELOCATE_CODE
> +       bool "Skips relocation of U-Boot code to end of RAM"
> +       help
> +         Skips relocation of U-Boot code to the end of RAM, but still does
> +         relocate data to the end of RAM. This is mainly meant to relocate
> +         data to read-write portion of the RAM, while the code remains in
> +         read-only portion of the RAM from which it is allowed to execute.
> +         This split configuration is present on various secure cores.
> +
> +config SKIP_RELOCATE_CODE_DATA_OFFSET
> +       hex "Offset of read-write data memory from read-only text memory"
> +       default 0x0
> +       depends on SKIP_RELOCATE_CODE
> +       help
> +         Offset of the read-write memory which contains data, from read-only
> +         memory which contains executable text.
> +

Similar concerns with Tom for limiting the Kconfig selection. Do we
need a depends on the armv7 arch for now ?

>  endif # EXPERT
>
>  config PHYS_64BIT
> diff --git a/arch/arm/lib/crt0.S b/arch/arm/lib/crt0.S
> index d10c129705d..f2c5aa37a8f 100644

[...]

>
>         /*
>          * fix .rel.dyn relocations
> @@ -107,6 +117,15 @@ fixloop:
>         /* relative fix: increase location by offset */
>         add     r0, r0, r4
>         ldr     r1, [r0]
> +
> +#ifdef CONFIG_SKIP_RELOCATE_CODE
> +       /* Test whether this is data, if not, do not relocate. */
> +       cmp     r1, r5
> +       blt     fixnext
> +       cmp     r1, r6
> +       bgt     fixnext
> +#endif
> +
>         add     r1, r1, r4
>         str     r1, [r0]
>  fixnext:
> @@ -126,3 +145,9 @@ _rel_dyn_start_ofs:
>         .word   __rel_dyn_start - relocate_code
>  _rel_dyn_end_ofs:
>         .word   __rel_dyn_end - relocate_code
> +#ifdef CONFIG_SKIP_RELOCATE_CODE
> +_data_start_ofs:
> +       .word   __data_start - relocate_code
> +_data_end_ofs:
> +       .word   __data_end - relocate_code
> +#endif

Where are these defined? __data_[start|end] only seem to exist for x86
and microblaze

[...]

Overall this seems to be needed, I am a little concerned about test
coverage, since this will be fragile when changing asm and/or linker
scripts. But OTOH I dont have any bright ideas on how to test it

Thanks
/Ilias
