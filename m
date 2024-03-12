Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA66C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 08:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AD3E87CAC;
	Tue, 12 Mar 2024 09:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b9TI3w7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2420D87C86; Tue, 12 Mar 2024 09:29:23 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36DF687CAC
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7d5bfdd2366so2766884241.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710232159; x=1710836959; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BFl+6p0bFlGEiuisiTnG99EOf7dP0UQLi1pC9ZUQMGI=;
 b=b9TI3w7dLk5sxJ/S/DNuSANEL5PHofJ/mfmbUyQOkpDUBA/rfY9ZC9S+vlEb2sewsN
 Ig4+aF8LZIpE1oot3MVytoHbMW59q7ar6V3dX8H7iU8Pm7yIRmXCCyQ8pUOrn9WX4fwe
 8bdjf0YcZbBq24ALEY6Drj6JvQZ0dNoH9487SUnzpzzhZ0oMiX0y2RZfxO9SGeZ/Ergo
 duxiqmNyXzOUHuoPHRGIgt27JL6Tan9IXB4WoLFLUaTi/8tQosNKsBvlCe4csJcVOKIU
 ACxUCoFziQRf+epBAvC7RPNzNvQK9jxAzyZauf4oNZq3bcTJqG/B49idhj+R482MFNbZ
 B79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710232159; x=1710836959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BFl+6p0bFlGEiuisiTnG99EOf7dP0UQLi1pC9ZUQMGI=;
 b=Nx7P04pmC4KITCja93s5rzoQ0mYwUYrqn5LAH1TJehImywhV/ERRDQEk2xDLZqkvjb
 3LRXfr2r8DaplUJNCbU7i+4dO6EI6RMbN/A4mCkyjrwmgL6Y11ijvI2/sM9YBAU18wW+
 l/FhDp+XSxKNOqne5BYn248CIbSQwfaVcLHGQVdbgRPyfilfipCs5QLgxsAtywRkmAox
 BFyHjY9oP3mgGicylbe/mIknTISHmwOckj3w3j+SBLmNRn14hkEt040tg6wGq5fkX+KO
 Dpi2zvPZLyIVokfrGWJNeqnhzB1eEpkhd3eo8wiWumVMk8Bm7KTmDiPFcpYt1zNlNPH9
 dT2Q==
X-Gm-Message-State: AOJu0Yy3k64ct3YsalCD/mjvSiJNcNyj52OXGuigt7rFGZybTG2taBgV
 zMeJX6BPFoFJi4PjT24HBVIG8r0R9Gs4W++quHD366KBVHNuTkDx7LOqm74RM7TdfrA7ss7GIw9
 eDTZ20jxX/nPYp9XWUmwhOlsThZMkLykefidMBw==
X-Google-Smtp-Source: AGHT+IHfhHWPTytKQvhArdyRlFe+nk+FfxqbdGCCwYy0TNXqkuAav5ZSdZEX/hUnkAxf8YEozG0oBC8tMPlBb0HC680=
X-Received: by 2002:a05:6102:238e:b0:473:c49:283d with SMTP id
 v14-20020a056102238e00b004730c49283dmr6948880vsr.2.1710232158821; Tue, 12 Mar
 2024 01:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
 <20240311213334.3567389-3-volodymyr_babchuk@epam.com>
In-Reply-To: <20240311213334.3567389-3-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 12 Mar 2024 13:59:07 +0530
Message-ID: <CAFA6WYNTH+GVzm3dqcfUjRd94fAtO6vDj2+8PyjuApmj0_qffg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] clk: qcom: clear div mask before assigning a new
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

On Tue, 12 Mar 2024 at 03:03, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> The current behaviour does a bitwise OR of the previous and new
> divider values, this is wrong as some bits maybe be set already. We

nit: s/maybe be/maybe/

> need to clear all the divider bits before applying new ones.
>
> This fixes potential issue with 1Gbit ethernet on SA8155P-ADP boards.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> ---
>
> (no changes since v2)
>
> Changes in v2:
>  - Reworded the commit message
>  - Added Caleb's R-b tag
>
>  drivers/clk/qcom/clock-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
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
