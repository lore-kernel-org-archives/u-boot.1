Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D039BC47258
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 11:17:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104AF879BA;
	Tue, 16 Jan 2024 12:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HgXwQrB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2153D879BA; Tue, 16 Jan 2024 12:17:08 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D1F5879A0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 12:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e78238db9so17745875e9.3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 03:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705403824; x=1706008624;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=EDd4XQS1ZwegvKYGc01HX/UV7tgP5bVokRQRrX/slVA=;
 b=HgXwQrB2XhakxQ0YYew6lRrTyWXWnkyn5ylSeoGb9vwT5wbIclFYJxnqr6VQakGwWj
 sX9di/LS9+MgUn7OFYGvOJiYtKYVXTMjFHwliVv8BEmubeBfpvwZyvdr6gLuBi0jCPMW
 UgXiEqpy5plEgy/fEuaro7TJV5Ju/8FIVvBqFbSfrv4q54X2wZYamdJ1v+oqaUTngt6N
 2iOYqFvh+eQ9IyADz6zv+JOF6fKiD6gSGa8QCXOkFZe+AZhisXP02BQtYkZ+BSYI0Wcq
 xtinexnndMewcoesNCTFKSHcsCH7q0BVOv4Ks0fVNDf91oYbWMOXkb9J9Z2p7CS8cdKU
 XNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705403824; x=1706008624;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDd4XQS1ZwegvKYGc01HX/UV7tgP5bVokRQRrX/slVA=;
 b=azSLEqyVkF7FSigZQ62nVQm7eii3bg2NzPcsiFUn9snf+/a2a1s0BUfAF0lmGohBPz
 fbKd74xUQllU0yT6+Z8ovxGAcCR+Un+0XQSSFs2buKKRShty6chKS+iAiIc1JzAxqStl
 Z0cjtz66jjza/Q66/z6qQowpwKdXw3jeiHm5U57q6F2C/LTHPs2/TdZjdSOETY6BHnUy
 cNgO1stUil2lQ5idS+xtdzx99DVQHGHPquaX3Hf9bI0Mx7FFAxc9+uLgxJzxo83q8wiX
 FXT/DRME2FpUkn+p2UIe8FhrFr3Vi103r5Qd8ni+cjQmewj0xRirMqRUbGZ5rC07sO3W
 jiQg==
X-Gm-Message-State: AOJu0YxQs0nKc5lQTyIJg8xJzc0/YsgCCE4YiscBKS4rsaPcHTqxMccC
 cWnCC4A8MXWbajIiH2jfoyZ3mfE+y4Y97A==
X-Google-Smtp-Source: AGHT+IEmTl9zR7ZoAe9wp/kiohJ8k5XKepQ7LGdCw92k689vl/7mV+LlTDbGiyMXrVSVAjwoH0FCvQ==
X-Received: by 2002:a05:600c:3ace:b0:40d:8557:9263 with SMTP id
 d14-20020a05600c3ace00b0040d85579263mr4009849wms.130.1705403824388; 
 Tue, 16 Jan 2024 03:17:04 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 z17-20020a056000111100b003377cb92901sm14196387wrw.83.2024.01.16.03.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 03:17:03 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH v4 4/7] arm: dts: k3-am625-sk: Enable usb port in u-boot
In-Reply-To: <20240112085317.1866449-5-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-5-sjoerd@collabora.com>
Date: Tue, 16 Jan 2024 12:17:02 +0100
Message-ID: <87bk9l4jf5.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sjoerd

Thank you for the patch.

On ven., janv. 12, 2024 at 09:52, Sjoerd Simons <sjoerd@collabora.com> wrote:

> Enable usb0 in all boot phases for use with DFU
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>
> ---
>
> Changes in v4:
> - Don't force usb0 into peripheral mode

I know that dr_mode = "peripheral" has been removed as requested by
Roger here:

https://lore.kernel.org/all/054aa15f-05b9-4645-ab00-fac1be46dad7@kernel.org/

However, the reason for this was the following series:
https://lore.kernel.org/all/20230706-handle-otg-as-periph-v3-0-27e24fa17345@baylibre.com/

I've spoken to Julien (off-list) about the above series and he confirmed
that there are no plans to keep working this.

Therefore, I'd prefer to re-instate dr_mode = "peripheral" here to make
this series simpler and focus on enabling DFU.

Would that be possible ?

>
> Changes in v3:
> - Enable usb nodes in all boot phases
>
> Changes in v2:
> - Only enable usb port 0 DFU in SPL
>
>  arch/arm/dts/k3-am625-sk-u-boot.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> index fa778b0ff4c..67c9fa2bbc3 100644
> --- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
> @@ -46,3 +46,11 @@
>  &cpsw_port2 {
>  	status = "disabled";
>  };
> +
> +&usbss0 {
> +	bootph-all;
> +};
> +
> +&usb0 {
> +	bootph-all;
> +};
> -- 
> 2.43.0
