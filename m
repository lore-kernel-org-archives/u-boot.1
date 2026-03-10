Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBEFFCC9DB
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 09:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E6783F6D;
	Tue, 10 Mar 2026 10:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="X27/3/0/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D7C83FA6; Tue, 10 Mar 2026 10:18:35 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB0483981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-485410a0a8aso9986055e9.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773134312; x=1773739112; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=d8dk1s1QzCzkWL7duSMNvTj9URqbuAQ+zjD9nAZfG2k=;
 b=X27/3/0/3ND2xDuRZcgJptXvkMgcM0kIktXVeCxetvf4Bn9nONOVP+6gUXFkYKqPAj
 5A0+SLi2Lo6KyGDaxt0MsmiX1WbfjrHMVtPQ0FOF0p5qzJNFOaUU3yRe3Vpr2uGhvheE
 xbnW+QuQ5XsJao+ICr7bbbpZyEgkS5kUmjHA6E20rH1cF7BXoui8GINEFIPmbgIkMELk
 KYIdkC4JPEKZQwpeAIXaQbRk6c0FGBX5qp0JR/CJWCZHHzu3LKhIpPYfgXgrRiMhVTYC
 qXZllr+/llbGz7mHjHFFZKEkgHpEoyjZloW3kDq9k+nTQWv/M9Sj4Sgq5sBhQ7XgcXaK
 4kEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773134312; x=1773739112;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8dk1s1QzCzkWL7duSMNvTj9URqbuAQ+zjD9nAZfG2k=;
 b=kVVbW8WM3Tc87gFvJAYDbGQ1HQ4pStkv7veZNIqeerL9bcMfyXBt5Y1AKHJ4oNGBqG
 iWB6Z41hdKjyPLYrjk9h2rQroRy8Q3pwyvU+czznmZbczodsPSq8Pqj3lum+W6EEKJIv
 WpR+fyaEBUf1JnQBD0cIZw5ofk2L2VkF3YhdeOjACr4ALGnBXaoIWXEZ6gDWa4+Du89w
 NM/HPoBz2xDnISmLVDlBYDpFbjAzSs2YYAXNfaYtordXn0EgIeYUlNWIXx+zxOgr+Kr1
 eXn0+hWoP0hYq9AYmxy86P86n0b/IGSdpqbINrES/8j6tzQulqSw1DUNklz9YzD2bTcw
 UJlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9+I+jeLY4KMBP2QrIWTyszMfaiksqBDbKSVEvmWNQ9yYHza8bt6I9Jpm7MCalraY610pflzM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyq9einA5WIqSylxAGmoYYkr0btdYQFnD/yr3ciuaSAq5f8G6JB
 aeiY8fRJEaYbhwg8TiDs7VqYMgk2vLmkVYxl5JcMlK9Fo7Ggm+kMcGlyFhDl+wrg3dY=
X-Gm-Gg: ATEYQzyIvwATYwaaCO2HGp3Le3NsdCzeTV9yrwF/FmmcC0/4/juGWsYmq8L6VTuwur0
 nDEXAaE8Wp3IfBlW5rt9gT/zlR0KWeXqGqGrYe392vrnPydrHdbXu3InkhDKyvzhGvKwZVZ6Wcy
 uko3D4VHoHLk1xB3Teje4DNUyynaDpd7skuPPVZIYUt2oCo8OlDJ4SkhK5lq6QaEsLkpfvl51zo
 FZjtvdRfMMroEJQGBO3//nVYttfqLlLhnCNdCX6EMck91jtPAsN0bNY2sTxexbU9woadhXL6wg1
 PC+xc68vBqXvTuwk5bcilU+g4ddyRmdK2zGIEkkrKblZ2wQLH8cxo+bbq2YvMiNeGWmdqOxTQ4i
 Lghjkm7t7zsyq1tLXNlZQehjblhFrVC4WdDYJ0FPnu8uggqr1wmDn/kNii0fpmRsWPEv8T1kSd7
 SvSGj1a9pbbdHIkVwN7w8AFTfoK7Z2d3GEvD7FBgvEBsYZANavYVTbQWggx9jjlW4qfHqTG2kOx
 Q==
X-Received: by 2002:a05:600c:8b01:b0:485:3b34:2f51 with SMTP id
 5b1f17b1804b1-4853b342fc8mr97928275e9.4.1773134311648; 
 Tue, 10 Mar 2026 02:18:31 -0700 (PDT)
Received: from [192.168.2.177] (241.85-85-167.dynamic.clientes.euskaltel.es.
 [85.85.167.241]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541b6f6b7sm80918615e9.9.2026.03.10.02.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2026 02:18:31 -0700 (PDT)
Message-ID: <9171ddb2-7287-4c92-902d-18f0f5077ac0@suse.com>
Date: Tue, 10 Mar 2026 10:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: bcm283x: Fix GPIO pull state register values
 for BCM2711
To: Cibil Pankiras <cibil.pankiras@egym.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20260206104701.34358-1-cibil.pankiras@egym.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260206104701.34358-1-cibil.pankiras@egym.com>
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



On 06/02/2026 11:47, Cibil Pankiras wrote:
> BCM2711 has different pull-up/down register values compared to BCM2835
> 
> - BCM2835: NONE=0, DOWN=1, UP=2
> - BCM2711: NONE=0, UP=1, DOWN=2
> 
> This patch fixes the pull state register values for BCM2711.
> 
> Fixes: 2c39d975f87c ("pinctrl: bcm283x: Add GPIO pull-up/down control for BCM2835 and BCM2711")
> Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> Changes in v2:
> - Moved pull value swap logic to bcm2711_gpio_set_pull()
> - Updated the function header comment for bcm2711_gpio_set_pull()
> ---
>   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> index 4ecc8bac645a..90eee88eb137 100644
> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> @@ -30,6 +30,11 @@ struct bcm283x_pinctrl_priv {
>   
>   #define MAX_PINS_PER_BANK 16
>   
> +/* pull states for BCM2711 */
> +#define BCM2711_PULL_NONE 0
> +#define BCM2711_PULL_UP   1
> +#define BCM2711_PULL_DOWN 2
> +
>   static void bcm2835_gpio_set_func_id(struct udevice *dev, unsigned int gpio,
>   				     int func)
>   {
> @@ -93,6 +98,17 @@ static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gpio, int pu
>   	u32 bit_shift;
>   	u32 pull_bits;
>   
> +	if (!device_is_compatible(dev, "brcm,bcm2711-gpio"))
> +		return;
> +
> +	/* BCM2711's pull values differ from BCM2835 */
> +	if (pull == BCM2835_PUD_UP)
> +		pull = BCM2711_PULL_UP;
> +	else if (pull == BCM2835_PUD_DOWN)
> +		pull = BCM2711_PULL_DOWN;
> +	else
> +		pull = BCM2711_PULL_NONE;
> +
>   	/* Findout which GPIO_PUP_PDN_CNTRL register to use */
>   	reg_offset = BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(gpio);
>   

