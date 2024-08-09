Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F030C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B0E88B63;
	Fri,  9 Aug 2024 02:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q676i8Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A04988B63; Fri,  9 Aug 2024 02:10:48 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082A488AE8
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-530e062217eso2010228e87.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723162245; x=1723767045; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vF10uGq8k6om67kTM1AiLd+QueCPAXcUfCdbu+FmJA4=;
 b=Q676i8AjROuk74wewGrbf34F6DIjm3OptHjefaox9tJHmim0l8qpz52sM9Nz5kxfa1
 yMbyLE+V62SBeGC/z9A5AXzUK+PhAf1oSKo7lzvZjbBKEbcXB5Iit045rOI3QIQqruFf
 KbvGQFsSU7Qb346pyALPsdxzqDSuS85o1YVvUrC6OFaPLfmgv3SuuXunvX0K55mN+HNm
 g9e24EkE5IvRQt9x3shumfOWVd0WXpanYhLPYYrNYMNoKo2yaUY4T5KDAwXEP2MhdTig
 12ttSfu8lFIEDa6rOQN9PUzApFDmGkwASM2H5uwB9uFLrnS/UnbcYe7eXokAW2CBQb/T
 BSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723162245; x=1723767045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vF10uGq8k6om67kTM1AiLd+QueCPAXcUfCdbu+FmJA4=;
 b=fv+XcOZHM+e+U3Y/0Kw/a9gi4b8djj/CQE9WYzuHs2KHn2346cn3npUzqUnHhHaUuC
 VFZZYSUV74xBi4StJh0GDi87NPYPGXL06/hBjQ3LPVfAyNEFds+sbWD+iTi48eOwxiwf
 M1rC0uONUhwODrAHySsJyuVT9zIDFjmN/kXqR04K3ayVipZTmgZiFcmwecxS1ZjNCBpF
 Ud40gkXtkt7K6htlMDE8ynCGYG+JY9tZZIdBhA3nYt467C6Eeb0mnCQFJZpMl2NEdUbI
 M0m0K1luSNOo90rJ7/vaudlAq0qB3G7S1mIZBxoxW7IM78jqMKQirgqjC0WqjFwvJs0z
 jing==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJCbQcjKREulDD3uPBdB5Y11zf70PW3hE6gMrwrY8OLpfFPTE+eRtpUYiVJgjrtpBMJMBiMShlOJEdpjh6vE/w1aW2jA==
X-Gm-Message-State: AOJu0YxBlq+YtKyEgSRIh7PA/tWHlK2zEcbV4awV8L7d1IF7OHaSBGHJ
 0By8vhNRooiFtMmTVP9G/1ifYlZFcjziZkVFcGwz9E1C+l53MgP7503rC+LS7oM=
X-Google-Smtp-Source: AGHT+IGtygbxFlW6zZvvAYDr+IihaQHAwvMOo8oPbkK2a3Ox5BOVeSUiE0Z9QGVef7FiZYm97Y/6lg==
X-Received: by 2002:a05:6512:124f:b0:52e:7f09:aaae with SMTP id
 2adb3069b0e04-530e583c51fmr2294731e87.27.1723162245064; 
 Thu, 08 Aug 2024 17:10:45 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::7424? ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9bcf044sm785167766b.7.2024.08.08.17.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 17:10:44 -0700 (PDT)
Message-ID: <4f3bf2dd-3843-4a48-a1e9-5261c6830163@linaro.org>
Date: Fri, 9 Aug 2024 02:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: support USB 3.1 controllers
To: Igor Prusov <ivprusov@salutedevices.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20240423141551.2410199-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240423141551.2410199-1-caleb.connolly@linaro.org>
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

Small ping, I think this patch slipped through the cracks.

On 23/04/2024 16:15, Caleb Connolly wrote:
> The revision is different for these, add the additional check as in
> xhci-dwc3 core_init code.
> 
> Equivalent upstream Linux patch:
> 690fb3718a70 ("usb: dwc3: Support Synopsys USB 3.1 IP")
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes since v1:
> * Reference Linux patch
> * V1: https://lore.kernel.org/u-boot/20240411160527.835767-1-caleb.connolly@linaro.org
> ---
>   drivers/usb/dwc3/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 96e850b7170f..db045f5822d4 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -594,9 +594,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
>   	int			ret;
>   
>   	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
>   	/* This should read as U3 followed by revision number */
> -	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000) {
> +	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000 &&
> +	    (reg & DWC3_GSNPSID_MASK) != 0x33310000) {
>   		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
>   		ret = -ENODEV;
>   		goto err0;
>   	}

-- 
// Caleb (they/them)
