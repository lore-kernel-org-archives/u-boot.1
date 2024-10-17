Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8C6D21274
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 576F088EDA;
	Thu, 17 Oct 2024 13:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kYvX6pgQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BFCD88DC6; Thu, 17 Oct 2024 13:07:42 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FCDB88EDD
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a99f629a7aaso140084466b.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729163256; x=1729768056; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bEwrKMDWbzbfXaozwAUpUeomk/EmCv5lWCHvwE+fvLA=;
 b=kYvX6pgQNx8lBR15ZAmeJsB8dbzlLj6F6wdV8/HXBg+xf4nsEetKf2dcCsUhLhdrCg
 JM6D4s9TTHRb7aYUGaZA7VvtkeU7Ab2g3FK0KueV/GQ/E+OmVF/yK2583ID+aqwM9LvY
 0actsZSHd6o4QnoHtnCudoEcCfniVuoV8C6Mx70P0bjzuA1Jb4N+YKw/lqwJRFkQzwEC
 8JQ1LBnS4fnvmsZNYdwQJq0OUATIC/AZI7eW+7OgPBfGxCpy+hns7SGhevb1VU5o0sQP
 eNhxKvvtlzapE2P001r5Vjo+uw2uacZCaXk5vUkKdteXJEUA7269QoqUjHr0wfwE8qXe
 mDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729163256; x=1729768056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bEwrKMDWbzbfXaozwAUpUeomk/EmCv5lWCHvwE+fvLA=;
 b=YlsG9BLPCTBjL6MgaQeApKidImtKmRZRUGYniNbP/GtSLoZ8Bpgli9xXkhlQSwrggU
 Q8bxjh0c0VHgy/ccF876kxyHWQELhebEup+jMYiROd5LxY8NBMLypF+20kj7PZt6nAPU
 U0rAalMHzstZp1F+5L0pM97VRQEaiv2MVRsVUzqEiauxx/37Wqzv53I/bKIjJQRQLCn5
 nNpUWTim79ADC+0ty9lcKvkKd0nMBQc1z8AWU+TK6LGMfwsQdaSLEC0ELt0mEF118iev
 0N21sQhL0aZiJk3cOphR5MdXd5hv1EWi03cY2Q6AuHYJp2hsj6u4EihItwErM1mg9ACW
 gLTQ==
X-Gm-Message-State: AOJu0Ywbkz/EERZspvpY04i9meDbrJN9wArfJTUCgWsI7Kx9/iwS6Mu0
 zQRVABNeN6fqsKknfTRtuU4pLEKZDJsbubO4WcxLWjWkLOHzkT9C9bH2GUxsaDg=
X-Google-Smtp-Source: AGHT+IH0C+2zH2bMsO9DfOiYCqYJgKZ90tQyLDqO51612wLxi1hS8N5dL72OoKCMvmpGHxLXi2gNcQ==
X-Received: by 2002:a17:907:7213:b0:a99:4112:5e6e with SMTP id
 a640c23a62f3a-a9a4c2c5301mr314354566b.3.1729163256299; 
 Thu, 17 Oct 2024 04:07:36 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2976f15esm284142066b.94.2024.10.17.04.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 04:07:35 -0700 (PDT)
Message-ID: <c6b7e22d-2d84-4577-a2e4-d15363a45993@linaro.org>
Date: Thu, 17 Oct 2024 13:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: use DR_MODE_OTG when dr_mode isn't
 specified
To: u-boot-qcom@groups.io, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
References: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241016-topic-usb-dwc3-dr-mode-otg-v1-1-4fda56072723@linaro.org>
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



On 16/10/2024 10:26, Neil Armstrong via groups.io wrote:
> The USB DRD bindingsa at [1] are clear, if not specified the dr_mode
> property defaults to otg, and this is how Linux behaves.

I guess this is (kind of?) a subset of

https://lore.kernel.org/u-boot/20240621021135.1600847-2-caleb.connolly@linaro.org/

I need to respin that one...
> 
> A cleanup is ongoing on the Linux Device Trees to remove dr_mode when
> set to "otg", so take this in account and do not fail anymore when
> dr_mode isn't specified in the glue or dwc3 node.

Definitely an improvement over the status quo heh

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-drd.yaml
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 2ab41cbae45..d62d687ece3 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -183,10 +183,10 @@ static int dwc3_generic_of_to_plat(struct udevice *dev)
>   		/* might be a leaf so check the parent for mode */
>   		node = dev_ofnode(dev->parent);
>   		plat->dr_mode = usb_get_dr_mode(node);
> -		if (plat->dr_mode == USB_DR_MODE_UNKNOWN) {
> -			pr_err("Invalid usb mode setup\n");
> -			return -ENODEV;
> -		}
> +
> +		/* If none of the nodes have dr_mode, bindings says default is OTG */
> +		if (!plat->dr_mode)
> +			plat->dr_mode = USB_DR_MODE_OTG;
>   	}
>   
>   	return 0;
> @@ -527,6 +527,10 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>   	if (!dr_mode)
>   		dr_mode = usb_get_dr_mode(node);
>   
> +	/* If none of the nodes have dr_mode, bindings says default is OTG */
> +	if (!dr_mode)
> +		dr_mode = USB_DR_MODE_OTG;
> +
>   	if (CONFIG_IS_ENABLED(DM_USB_GADGET) &&
>   	    (dr_mode == USB_DR_MODE_PERIPHERAL || dr_mode == USB_DR_MODE_OTG)) {
>   		debug("%s: dr_mode: OTG or Peripheral\n", __func__);
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-usb-dwc3-dr-mode-otg-88ec307e0970
> 
> Best regards,

-- 
// Caleb (they/them)

