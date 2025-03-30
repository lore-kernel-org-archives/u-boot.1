Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18417C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 15:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA1E8144A;
	Sun, 30 Mar 2025 17:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FqxValXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7D881A0C; Sun, 30 Mar 2025 17:15:24 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5839580FDA
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 17:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A47D13F27C
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743347720;
 bh=3jacCGahCN8h5k42h36/Xjn1D446MrCSX7RVY1k4eHk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=FqxValXDdFDAlMmftp2ObxpdsZZZKn9Cd0hqxjv6JoE1qhKtIET48+XtLp/6qu+3E
 KxRQ8dd8zcRjaGlxx6PgdLkjf9u5WrKdZ4BKQb9jONqzFzQ3v2rTPsh2dyUJUocjpo
 RecVSuFTjKA4QEy24IW/dJG3yho3Iuq4dlK2sHrRTCDVj2RVKWcm6PeuQhTuNTU4wl
 3ED7WqPP0SwW+oNxKRwbZKwiqRh/crJtJwwaeuvte22cgw5PC8QzOlK8FBOV/Z4uCc
 Q0+XiHeUPBuWD2teEwpoy5mIg60YShZPf7ZUll1A8BR2HypIFVMp/TIH8f5EbanY7V
 wqSla1pXpq8Rg==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43bc97e6360so20170415e9.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 08:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743347719; x=1743952519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3jacCGahCN8h5k42h36/Xjn1D446MrCSX7RVY1k4eHk=;
 b=XijsBxCzbfGJYf1k/0+PvhxVGkDvzGKtXHmd0t1yZw0t9KdLnbxAHaEEtjCf4WTfNx
 UQRvtU2t61DI07H2eRATR2tXmiSUZMsfq7y5eLsKyAqihbvKHyuwU8v3XBKMKgi3ttH3
 5KE7EKUu+IKSZxSxGMWacz9I1u59tMYgpx9eDEP8Vmg6GTp8YL7nhL0zPL7DFMmiMNmF
 JFElQO4ZZW9ZZaeEWRITTdZKSI4fVxPoElWz6L/p4fyXeKTxcgII33fxAWJ9p86iArw3
 xkuhAsxYSfiABbGPCQRmwOlbBwLYVu67cxELjOI59iCJJe8nUR53WqnTtDI3fIYLhVCU
 UF1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtNKOUAFuWuZUvuoWIPlAKK3mmYv1YDPuUQOV6qJEXmRQdXw5edt1Fn3WcWIpmpRQRRogumIs=@lists.denx.de
X-Gm-Message-State: AOJu0Yxi59AVVgLO/txUc/NpMupvlufz45lqZtyszEGVFkTt7oBxUPVb
 /Su00Dr1q2pmsDpE/Qf5yalde9wCwGqR/QGjYmgFBDYXF9bh9jwKTY7AkHxizJMuMef/k52FkZj
 SHXIhPUWtRNgabWfnsVn2vRtAYjI3fPiWp518ZhsMl58XBnlS6oG5JOGCnfxSUFVH+Kw=
X-Gm-Gg: ASbGncuJOFLzZknLsvpz1ulAztKGPPMU1MWVSB7NUNUQV5OKOEQRfs50J9kQjRjfqQA
 zW79Rh+Q8mWnUZx5B1b8gag0BJOc2OLCXTgdXLbl44upkLRTy8Q82AHG7oFPcApmlF3KNN4F2i0
 Yk6EEltpHKlmNgyDN4iagWrjzEH1mgDawITE3tSyCKONmk0oDUSrxPlmmO2fA6bPWU+p+gICbZd
 4W8zVEqdiJPhNcjxDVG0PNdsvNy4RXSLtigQ8cs1iMV1LHx+dZkk1wFSMgycyEpL9MxNYsaubyN
 GvJ7BWRp5xhUGeA0jK7CwN7g/PiXgIECrHF2H5R3RSI059k4gZxLhjO2YdJwY+mUpU/gxSdyKi7
 XD8GNup9OUZwQ
X-Received: by 2002:a05:600c:4eca:b0:43d:abd:ad0e with SMTP id
 5b1f17b1804b1-43db6249689mr57816335e9.18.1743347719289; 
 Sun, 30 Mar 2025 08:15:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/t1+iLQQodRvL205xVHqeUzjBDt6dvNzmUswfaxdLR6VdZ+aKWPiJZL+ciVbfJLKMQklDgA==
X-Received: by 2002:a05:600c:4eca:b0:43d:abd:ad0e with SMTP id
 5b1f17b1804b1-43db6249689mr57816185e9.18.1743347718884; 
 Sun, 30 Mar 2025 08:15:18 -0700 (PDT)
Received: from [192.168.103.102]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02f84sm93918695e9.25.2025.03.30.08.15.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Mar 2025 08:15:18 -0700 (PDT)
Message-ID: <f6b85cb6-509c-46a8-984e-3881374ceb02@canonical.com>
Date: Sun, 30 Mar 2025 17:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
To: Marek Vasut <marex@denx.de>, Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Peng Fan
 <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com, u-boot@lists.denx.de,
 E Shattow <lucent@gmail.com>
References: <20250323160107.145749-1-marex@denx.de>
 <20250323160107.145749-15-marex@denx.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250323160107.145749-15-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 23.03.25 16:58, Marek Vasut wrote:
> Use clock-names property which is accessible via parent clock OF node
> to look up the parent clock by name instead of depending on unreliable
> global clock name to perform look up.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

This patch breaks booting starfive_visionfive2_defconfig in the SPL stage.

To dig a bit deeper I enabled the debug UART for SPL with these setting 
on origin/master (5e74863ad6613df):

CONFIG_DEBUG_UART=y
CONFIG_DEBUG_UART_NS16550=y
CONFIG_DEBUG_UART_BASE=0x10000000
CONFIG_DEBUG_UART_CLOCK=24000000
CONFIG_SPL_DEBUG_UART_BASE=0x10000000
CONFIG_DEBUG_UART_SHIFT=2

clk_register: failed to get pll0_out device (parent of perh_root)
clk_register: failed to get pll0_out device (parent of qspi_ref_src)
clk_register: failed to get pll0_out device (parent of usb_125m)
clk_register: failed to get pll0_out device (parent of gmac_src)
clk_register: failed to get pll0_out device (parent of gmac1_gtxclk)
clk_register: failed to get pll0_out device (parent of gmac0_gtxclk)

Marek assumes that property bootph-pre-ram might be missing for some 
clocks in arch/riscv/dts/jh7110-u-boot.dtsi.

Best regards

Heinrich

> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> Cc: uboot-imx@nxp.com
> ---
> V2: Rebase on u-boot/next with additional clock patches
> ---
>   drivers/clk/clk-composite.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 1191bdf87df..9e3b5191767 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -149,7 +149,7 @@ struct clk *clk_register_composite(struct udevice *dev, const char *name,
>   	clk = &composite->clk;
>   	clk->flags = flags;
>   	ret = clk_register(clk, UBOOT_DM_CLK_COMPOSITE, name,
> -			   parent_names[clk_composite_get_parent(clk)]);
> +		clk_resolve_parent_clk(dev, parent_names[clk_composite_get_parent(clk)]));
>   	if (ret) {
>   		clk = ERR_PTR(ret);
>   		goto err;

