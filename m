Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC449FF60D5
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 19:46:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60EC68406D;
	Tue, 31 Mar 2026 21:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ni1JA20U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6C08406D; Tue, 31 Mar 2026 21:46:54 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF35083AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so1154816666b.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 12:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986411; cv=none;
 d=google.com; s=arc-20240605;
 b=YQaTbH+6TPaboE6GB/CN1mBJNpP7Chiz7mdV/bNbifMzZDIFOYZprLd1EJn+D3I78g
 lBaIMTzps2MBDxuAaSD7cOXqy72w0LIDzKG+/7jRi/ijGQqc+S2kTaGa6lHEgX5p9iQG
 LMiEiwLjHVdVi425oTDj11Jo4vJ+3Osovi1//KHX6aGyqPcuH9M9B5XBACgcTud+13O5
 BMoJ6vu0PVnqF7HtZmglFe2194U+ZTqgePUh3sBa2oWMSQKKjR/6MRaehKTVSAJqtp2l
 /Y3o/WS+dgY2hDIkNwSS9TB+O9rR06dkExW1uzzDXpEXW0SpCX5MbIus9pHrPGGxO2jP
 0KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=l4aid4s8kV3cmEz9kLv8Tr0IqydpjoYRMuGAji/aCfA=;
 fh=1mogUeOk2SquYsioe8jLMVPXbOwyzPswdW/y0+GyMAU=;
 b=cswB44gsMHBFFUEsYLlQ04PlITAaSqemhjPQBIQp22oC8ikD8kNx/w1OF3dJEzuqom
 Zd0/yN1fuLRu/2dB/bVRVPddlUKiiGZ0USq1kEwAwJ37Y6IBHKfuX8AVPCDdMYNQHPJn
 1a5jssYVT0E6Lp32fXtMrhHrD2jWbrssVd2896zpeiNs8zrgN6Lx4I42JjgBamnI2Kwk
 FxLcULP3NPm15rHp+AXtbhBgyJ8qq2M2RfmvPdy6JkOkjEPedCseFFFZvJypG8+r2WPf
 xqwixM4JiN6hmpy8JjvFqBbj/S9IPFxHwIzXkrSuNMN06zuQHoz5Rpl9CWSc8hNDLyPI
 Twsw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774986411; x=1775591211; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l4aid4s8kV3cmEz9kLv8Tr0IqydpjoYRMuGAji/aCfA=;
 b=ni1JA20USUSEIiTdp2y3Von4Ca8YJolQiXro6k5yeYoXZyr8WbYi4F92/R3uX/OLvZ
 Wpq1r3E3pCY1WW+h6bTVgS8m1g2ijrwJepfIe2swnuLblmKi1hq3zH65kfbjouqN2R4r
 Eq1iHLvTHdJL7klY1BxRGmUaWzd4bb0NcFnfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986411; x=1775591211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l4aid4s8kV3cmEz9kLv8Tr0IqydpjoYRMuGAji/aCfA=;
 b=OkNGX9rQi4wuX3brcL2mLMY6CQxLWKX85WEEAch+Fj5Lsqm7bpZ4a8PbnRCV3uhAok
 2HpFhss56X5pzBIOt/VsFv+R3bFglvCYaO+lC+uYF6nqDyLV5tviRzGAAmWFsIE79Bt4
 jxXEXbQ0v+f0rOJdMwIOaAUZ5EqEvzg105Qcsv7kDJSx52VFAeSxlubTZrlYaR03n4z5
 41KAN2IVqtNoxPajINJp3l58KgWl/KjRrv8s4cGSL8IzCtFdskyJsPmYAIyBJCNk4+wV
 O1GUi0/+58BTMNV7oDPumojOBsSrXFEWk5DL07IWRyxH7CLNfgejX24oRxSM/gtKVw8O
 giOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6LHdnOvXH342JbOnFQo1k6KET4MZtAeJdCkS118BTujJHyX8hHFZjbgn+ltFtVnSCAGLoAus=@lists.denx.de
X-Gm-Message-State: AOJu0YyofgxefD6CE1Lb2GcLc/lIhHekMASyYWxq+or4vSh91YCTrjLN
 z1GjZTdMhk5vO8amw9ihHTk3HNUllVUjjlO36i08OaAn+01MXvG3+1a2GF+SyVW+bHvqYnjl/U0
 X6xA7Zd2SeCBNmXbuTnir7kWD+Tnv0/le+nXoDnBB
X-Gm-Gg: ATEYQzyIQsvAzuNniLe5HLKvy8e8VDYD4h3TVcTEQi2S+757Er2tBfz9L3uJAPQqgth
 MywW/kubnSJ+lruylyA1KqgYdtfm8TsvgkZSW5nA/wH27s0L5c6SuMJ6DVItARq6Wtu78f3qfs7
 GheONIFmFYmk+e1bpgygUccLHJqDnfxs7I+M+J8hiJsxsoYkNAJQAlIIMZr6mJqYpIRUB8Py1lh
 cfb6JPSX17V31OzRS3oSMmIFUm5CReg5n9jl6DDU6q1U/YDZuchD4z64gMmf+b+kDl4DjvjHcuy
 jJ1ngQ==
X-Received: by 2002:a17:907:a688:b0:b9a:cb5e:5379 with SMTP id
 a640c23a62f3a-b9c138df799mr60317866b.15.1774986411291; Tue, 31 Mar 2026
 12:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-6-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260330171419.1117817-6-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 15:46:39 -0400
X-Gm-Features: AQROBzB5a-t4Vcq6abq3RGU_9ny7awPgYTAJdYohNpRwUXS1Yxk5BAdMhv1UJW0
Message-ID: <CAFLszTg9XSWeb2p5gpGhgxmYnNNo3--3tMyiFTVzDHJU89xdqQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] qcom_defconfig: Enable reboot-mode support in
 qcom_defconfig
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, seanga2@gmail.com, sughosh.ganu@arm.com, 
 ilias.apalodimas@linaro.org, gchan9527@gmail.com, mkorpershoek@kernel.org, 
 hs@nabladev.com, marek.vasut+renesas@mailbox.org, msp@baylibre.com, 
 dinesh.maniyam@altera.com, peng.fan@nxp.com, quentin.schulz@cherry.de, 
 kever.yang@rock-chips.com, jamie.gibbons@microchip.com, justin@tidylabs.net, 
 xypron.glpk@gmx.de, n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Mon, 30 Mar 2026 at 13:15, Aswin Murugan
<aswin.murugan@oss.qualcomm.com> wrote:
>
> Enable reboot-mode functionality for all Qualcomm platforms that define
> reboot-mode device tree nodes. The drivers gracefully handle platforms
> without reboot-mode configuration, making it safe to enable globally.
>
> Add config options:
>   CONFIG_DM_REBOOT_MODE=y       - Core reboot-mode framework
>   CONFIG_REBOOT_MODE_NVMEM=y    - NVMEM-based storage backend
>   CONFIG_QCOM_SPMI_SDAM=y       - Qualcomm PMIC SDAM/PON access
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v3:
> 1. No change in v3
> ---
>  configs/qcom_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
