Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9530DCD4842
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A2EF8394E;
	Mon, 11 May 2026 14:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xoDKGXAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C7083CF5; Mon, 11 May 2026 14:26:57 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB1380F0E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 14:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bccd251d622so262528766b.3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 05:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778502414; x=1779107214; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0PuAoOKipDx0xGRMcpHH9yhThhwEwHGe/lAkGYrWFY=;
 b=xoDKGXAxcNaZGa4TPj8EthRk7yueVxEJQ2UEAAEjstRq3IA5RNomlVKWvdOxlrmlUK
 IWunXD7Q/Tov9wmjPHsrj0XGAncO6I3bGONs3HxI8Wc8BS3FNf695/ySCFeeNxnCOs+3
 3w9f3pVaSZM++vfkU9txG+KM95kBX5B1Z4e/JaJ2Vl09+tbxRhs7sMOXZWhnIhmAhlLO
 ntozr/2/eA4BkK8tMkesu8hpaS+XqDYYXCWCGDokdr7y11gkcNKhA5xTbDoRGiyIGmkV
 Ft/R8lIm9onHG2D4dM5L/kEn9wu4boMxMNwEjQTC94Lw//cJHjPgrD0cPT6egtnMsFIA
 /fqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778502414; x=1779107214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0PuAoOKipDx0xGRMcpHH9yhThhwEwHGe/lAkGYrWFY=;
 b=U6mP/LciczAHoSWWyjz5DIDq5T0cl+AkQNtziGNJdmXXOm+gaeWLl+NoTecy5JGHNJ
 AucD6Ku0M4LZO8roREUCS79L6U7NebeyAEOA1W5s1XRR09266peQbv3ppB6ZFrun3ZgB
 aquU5/GUPsowCFCCKDOh4hdgFbuj4leBp8yka2JAIXEBMn55TgX4w1F0xL2oNEAW7c3z
 CImAPUBmW9Rzn+t3G3xA6pYQmo8SZx3tG36CyEiI1eLEzY9hdOSziSOFx9gc23GoqE2X
 48ltmEVydDFgYp8+lV/YgVN+2IK/H5Yg2u6QhE2rxWe6LLaZJdpx8rDvXkywi/rAm5zi
 Krrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+03Kf4AaNnptdd8hfsx1wQuqqSYWJIBlB/r66XIB7fF05KaH9ArzdPbO45gM1xFFjAudzkRb8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxid1e1/hAwX0lwe5DSM3cqHM5x+dPfS/n67DyBHkazuKJKIDIn
 /m/vr7+kESE/X7jJMYgnnOUsLiz/4a2+2/DZSMRBt83t4p5cUHzbkpfjU2KOLf7MPTk=
X-Gm-Gg: Acq92OFPTYeuDLqdJIS6JdwYRhTGWvfvf+FTqVrwclmzbD4V4FJXylVzxutlnRey0ro
 zH0UvOdcj7cFD61NGsEA+8E6vrcUYzrHVQgnrh7uXwqMR8JU4fe5Z0lCiChxOl1rgJ24kkuH5ci
 T5bV6DVkSTqMG5sGcpLxf8Ew0NFzloqBPhWVHXJAj0zOYXxOcnnql+TkmVH7Ek8BC8CJU6Z9iQN
 0TJVm4qMoVdoA6gSW1KloE0WAi6Wy8lHGOv8Ka9Fa1PY+5MKwkc2ab01WVIsML6eZrD2zSNq2/4
 yMibHLEDfiCwwQWCDr5+fGV82cCAnik9hsW5SkWwgec/kgNhYxgW6kRpTI0kinr7Kcz2dvyF6GA
 pvpKhd2l8mevtgqLAukVUtvw2x3iWfB55mNyFMkvXWU6YDajt1covRG7QXLsdWM3V0erWA4gZSu
 OOVdGeCJzVjGevLJPv36618Xivi2IfJR3PUWH61Cu2FtMqI+93AQYXP/YE8AKPxN4u9d4I62Dmt
 iY1
X-Received: by 2002:a17:907:e106:b0:b9c:b069:8ac3 with SMTP id
 a640c23a62f3a-bc56be400b2mr823548866b.3.1778502414437; 
 Mon, 11 May 2026 05:26:54 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcb2882737fsm459381966b.63.2026.05.11.05.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 05:26:53 -0700 (PDT)
Message-ID: <28f7d0cc-4e05-4eaf-9217-b82f6dfb755f@linaro.org>
Date: Mon, 11 May 2026 14:26:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpio: qcom_pmic: Staticize and constify driver ops
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot-qcom@groups.io
References: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260507220549.209113-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
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



On 08/05/2026 00:05, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Rui Miguel Silva <rui.silva@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
>  drivers/gpio/qcom_pmic_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/qcom_pmic_gpio.c b/drivers/gpio/qcom_pmic_gpio.c
> index 4458c55cd3d..3cabb7df88c 100644
> --- a/drivers/gpio/qcom_pmic_gpio.c
> +++ b/drivers/gpio/qcom_pmic_gpio.c
> @@ -410,7 +410,7 @@ static int qcom_pmic_pinctrl_generic_pinmux_set_mux(struct udevice *dev, unsigne
>  	return 0;
>  }
>  
> -struct pinctrl_ops qcom_pmic_pinctrl_ops = {
> +static const struct pinctrl_ops qcom_pmic_pinctrl_ops = {
>  	.get_pins_count = qcom_pmic_pinctrl_get_pins_count,
>  	.get_pin_name = qcom_pmic_pinctrl_get_pin_name,
>  	.set_state = pinctrl_generic_set_state,

-- 
// Casey (she/her)

