Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9233C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 05:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30C187EA2;
	Mon, 12 Feb 2024 06:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oK0vHeZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8D587EA9; Mon, 12 Feb 2024 06:51:39 +0100 (CET)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810BE87E52
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 06:51:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7d2e21181c1so1532454241.3
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 21:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707717095; x=1708321895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=laqKrV0hFE7TsmpuPywxALmmxrUdddjzl0erAD2I+Vo=;
 b=oK0vHeZIwP482Pw2AzzxctQhpMGbgniuAf2AgNWBzj+7IzTzfWYHLV9P7uQqMe5g8W
 n5Du/i97J3Eiys5AGSh2NcApHHke7HhGIVV3acXjg1fkCt6HnPEpRYMbfQ4PrPowaGsO
 +LeDAx+E1Vbz20Zv7RWLJEEgXlwz4k55XvgZUd8cBgUPJr+uEiVCzyPTdtBmLU5pPT8P
 /MHZOIJPCRuQVCMzrDBk49RE5E55db0kvSSKi1VUtyIhf/N7UA5pEsk2Yyl48hWglMAB
 JsjrWN+B3oKQLlEvVEJMDGlBKGDN/CfGxGXwJ/VMFkuxBAIGwpyu0OtjxxZCMtQx9yFI
 n80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707717095; x=1708321895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=laqKrV0hFE7TsmpuPywxALmmxrUdddjzl0erAD2I+Vo=;
 b=Y/9519qTEZX0al1bE2FJyQHNF3cIXz8MvP5fnZehZPZD2vgafA+TlPPsgm/RXlDHne
 1/b8K7VK3telvWLHSDhULploqpUIVacu8SdgOrbC8L29JA1XcseJmn2s5YzaEau0tF5k
 HtleqiUfuZhWyvonMwjHEVshpWt7RLMCtftw1wsXS0JF/epjoO/yLjmIwPXxjo/8Dlxr
 9pHKTIsTLc3DCCmp3l2b/lk41zmQtF+7afEpB7DWGdd7AKxdMQWN6OC+DaoPyix0S+jW
 osnPUSR4mHyx+A+/zizHOQRqYmOUEkQZYkxNnhcuq4ll126vkIP+H8vExxePnmhxzFHY
 OwLQ==
X-Gm-Message-State: AOJu0YwAZQG+k/jEhdsSaB5A1KbXeQYVTXgAmRfOre+I/zWZZD/0+z4n
 pwKayaqJMGt0650h9S88zrh26R6/wFM0v6zZbokhG0e68z99EsEij8sTTmIvDza/T6OCMWgevr9
 R1J/yzvXLZSnuBWGPpbizMgBzRDKElg8su2iIyg==
X-Google-Smtp-Source: AGHT+IE7McKSjDQBC7ijEWgLIWUSQwS+jGNl7WhnArld3K2h9KJP/EXVaFmt8Apdmg496QS0bhEele8Vdr8/WBMUDZE=
X-Received: by 2002:a67:e297:0:b0:46d:246d:d858 with SMTP id
 g23-20020a67e297000000b0046d246dd858mr3817604vsf.2.1707717094870; Sun, 11 Feb
 2024 21:51:34 -0800 (PST)
MIME-Version: 1.0
References: <20240209151221.3967655-1-caleb.connolly@linaro.org>
In-Reply-To: <20240209151221.3967655-1-caleb.connolly@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 12 Feb 2024 11:21:23 +0530
Message-ID: <CAFA6WYNR2z0UOp+-F2Tfa_jGY7CmS5PLGcc-hetMRj4V8GJiGA@mail.gmail.com>
Subject: Re: [PATCH] button: qcom-pmic: demote "unknown button" message to
 debug
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de
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

On Fri, 9 Feb 2024 at 20:44, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This message isn't an error (there can be a watchdog subnode for example)
> but it shouldn't be printed unless this driver is being debugged. Demote
> it to a debug print.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/button/button-qcom-pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index 34a976d1e6c6..e6702139ca2d 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -133,7 +133,7 @@ static int button_qcom_pmic_bind(struct udevice *parent)
>                 } else if (NODE_IS_RESIN(node)) {
>                         uc_plat->label = "vol_down";
>                 } else {
> -                       printf("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
> +                       debug("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
>                                ofnode_get_name(node));
>                         device_unbind(dev);
>                 }
> --
> 2.43.0
>
