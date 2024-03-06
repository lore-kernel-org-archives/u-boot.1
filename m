Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FA1C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 06:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C08987D25;
	Wed,  6 Mar 2024 07:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l2LmxnYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E13187D25; Wed,  6 Mar 2024 07:01:11 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85DB86F6E
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7db36dbd474so1502447241.2
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 22:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709704867; x=1710309667; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKJaJNUzrYnVi1scyqbcPyKIzawmks2lnisFcXIhZIQ=;
 b=l2LmxnYxImeIWsFDu+6D81TDqaGBsFyU++bkjW0Is8UEcdRMKBguMeuqxMlhhTM7M0
 Ttuqej/IfPFVTfKbMSe6nYr2X4E2huEvGzFOyCY2dlE421ZOypb7spenr9eJok+njiw2
 2zYPf7E2AfYC3DuGLZUNTGRZBYbSZVBEOCGOqoofEiChgDnyLxDZCX/qmW4T2TCaIfsU
 HZWgWuZLusx9RrF2HGNqZfqxTq5gssajYXmeKDENgJ6dD65UrhbhRonBAHv5f94rV36U
 ny0BYpMC3SmYkG2dMEqjRMRi6w8NJE2S2XdQtwZxQwtgkUTf0auCpvsQLq4SsVPDigZP
 YAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709704867; x=1710309667;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKJaJNUzrYnVi1scyqbcPyKIzawmks2lnisFcXIhZIQ=;
 b=oNCV19viAKZwwtMFNorkDNRGcdp3YkVmsa1FiLoBz3JoubLl9fwWmn0vNWS5lpZME7
 V9Az+CKB5tvV8xto7156/m+vloPGwpnhFnl0AP1jYsb97fqHAdWIBXun9WQ40n90fIQg
 HQbfWTHlAuSRFPIAsjyKmhhoL1aBe2ne5l+ii4JF5b3tzr+GJFJ6JaEYa4mtmnlZw/L2
 OlgLbxRF78x8Tf8+mg0KgmEwbYQ9UtvjyD+SJ7r0vSnrvRwsE3O52TPq/FA7b6zEtMbQ
 3KNrazgjQI1Ori1vpXtvuFg1+lEHuV8iZrRwQ3+BkL2kiHvVJ8iX4H6gJjtB6VRiav/h
 ncNA==
X-Gm-Message-State: AOJu0YxHnwOpCM2yUAKiR8HHkfoixQo3NlGsQxTeZ7tUcnZiwqrufqrg
 qcS7z2TCqNTch0GPdPKsOd1ccDseRZCB9HWl3je724GikGteCG/sZF7Fmp9eETBgqfu7/opuZ/z
 rIwbS/AGoZYPpXOHzd8WmyotaR7MRDhVMhQGR3Q==
X-Google-Smtp-Source: AGHT+IEp4/v8gwpRzq48o2TQ3QsMXRx4OMmQI3rI84y/cPrSTvRYv+WLfDxJ3CmGW9uW4XVRKTfRW+Z9gN2dKipxlsw=
X-Received: by 2002:a67:b106:0:b0:472:e77a:dbb9 with SMTP id
 w6-20020a67b106000000b00472e77adbb9mr2017108vsl.10.1709704867717; Tue, 05 Mar
 2024 22:01:07 -0800 (PST)
MIME-Version: 1.0
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-3-volodymyr_babchuk@epam.com>
In-Reply-To: <20240306005230.2638972-3-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 6 Mar 2024 11:30:56 +0530
Message-ID: <CAFA6WYMBfE3+jJK8E6_PxBk_Aa1he2Q=hYBqRUqR6JHtAfmKDA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] clk: qcom: clear div mask before assigning a new
 divider
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, 6 Mar 2024 at 06:23, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> The current behaviour does a bitwise OR of the previous and new
> divider values, this is wrong as some bits maybe be set already. We
> need to clear all the divider bits before applying new ones.
>
> This fixes potential issue with 1Gbit ethernet on SA8155P-ADP boards.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>
> ---
>
> Changes in v2:
>  - Reworded the commit message
>  - Added Caleb's R-b tag
>
>  drivers/clk/qcom/clock-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 7c683e5192..729d190c54 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -117,7 +117,8 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>
>         /* setup src select and divider */
>         cfg  = readl(base + regs->cfg_rcgr);
> -       cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
> +       cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK |
> +                CFG_SRC_DIV_MASK);
>         cfg |= source & CFG_SRC_SEL_MASK; /* Select clock source */
>
>         if (div)
> --
> 2.43.0
