Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A959C25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF21788245;
	Tue, 14 May 2024 14:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F5EjziuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4FF880A7; Tue, 14 May 2024 14:48:34 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDEC9880C5
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so2052696f8f.3
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 05:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715690911; x=1716295711;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=T4czDaFejD6eDba8r65rbUii38kRPLC35HwHeogkdJY=;
 b=F5EjziuGRCy73WSIi590aTHs5vdZtI4vU3ZdBkJO591mY8Va5ga4XNwsW0dTJtbpNj
 VawLNpyhbxsp2LOyGhZcjxT5GtIRR0MVFyxz97fq8EXYrgzbrqcGKzlJDog6a3N/Dh7Z
 ztC051lINzlDNl0tFY98JWEgOA4X+YjKcKUg63K1bd1CMSY9aOA+KlTANKQq4YCY3EWa
 NVCDBq+onr2/v3h44LmxNVlxIM7+yejNU2AKMs07gc6p3l93sab5pasoUaGYACy4VAjP
 lxed/MG6iWLgAsQ4ObMS4vjTZjD+fXFpfxMS76Wa77vt+n4v5XoZuC4wmEvKYIUqd6WR
 g/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715690911; x=1716295711;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T4czDaFejD6eDba8r65rbUii38kRPLC35HwHeogkdJY=;
 b=Lj0/YUM5Sg1uuPgEsZZrNiMsI8vccwiYr+2aD0k64JWONH+LUMJPKG223FAzuCWfXS
 huuD25pufRPD5UyS+1+BuQI6WFwZ06JTHEcQoIRTuXYY4coRf18+UccAlKJoD/xcXmCH
 jdtHpiByh3biLZfLbsIclIQm3EQj9blVbtBKz3I+C2w7Yr/UBwa9UPBNkPY2C0Yyiii+
 /Fwa3Iy0BsgpdRIR2/Ch8nwqJH67ZBm5hasZjAU44xZrHzVy7Fs8USnq0decLLO5Y5lW
 udHKIUrm9yHhqkB8CT/R00j4MCJhsGdoGljJRjZNU0dtv85rQhM3WhJHl4c9Xom9RlVK
 Wj7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAXFMZzcXq6OraZHVYMUBMiy7zFJAx9CB619/boyQlZROddM1cUVFuUfTd+GOScs617Nse///VklJcZvlAWd9kFFHQsw==
X-Gm-Message-State: AOJu0YyNb48pyR+zzDqLywkTB4TKC0r7j6wLMnBqVb2mIEMyo0Anipzp
 NrP/86ZWkpOIu+PGdq0Xo4Q2z+rDKVn4dGE2fJzRUu7Reizg2NkCDKsPkK8wuhY=
X-Google-Smtp-Source: AGHT+IGKUrR5xCARla4i6lVdtIhyoTGpQzAeB4rN/eKKI8Rt6xj5eQyHPmicyC77m6t0dduYWcARGw==
X-Received: by 2002:a5d:52d1:0:b0:34e:4105:b3f6 with SMTP id
 ffacd0b85a97d-3504a73ee8dmr8719812f8f.39.1715690911030; 
 Tue, 14 May 2024 05:48:31 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbc334sm13559464f8f.103.2024.05.14.05.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 05:48:30 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>, Marek Vasut
 <marex@denx.de>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Nishanth Menon
 <nm@ti.com>, Sjoerd Simons <sjoerd@collabora.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 1/6] usb: dwc3: gadget: combine return points into a
 single one
In-Reply-To: <20240412202611.3565052-2-alexander.sverdlin@siemens.com>
References: <20240412202611.3565052-1-alexander.sverdlin@siemens.com>
 <20240412202611.3565052-2-alexander.sverdlin@siemens.com>
Date: Tue, 14 May 2024 14:48:29 +0200
Message-ID: <8734qk5zky.fsf@baylibre.com>
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

Hi Alexander,

Thank you for the patch.

On ven., avril 12, 2024 at 22:26, "A. Sverdlin" <alexander.sverdlin@siemens.com> wrote:

> From: Felipe Balbi <felipe.balbi@linux.intel.com>
>
> Upstream Linux commit c0ca324d09a0.
>
> dwc3_send_gadget_ep_cmd() had three return
> points. That becomes a pain to track when we need to
> debug something or if we need to add more code
> before returning.
>
> Let's combine all three return points into a single
> one just by introducing a local 'ret' variable.
>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/gadget.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 69d9fe40e2f87..17c19285f1c24 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -302,6 +302,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  {
>  	u32			timeout = 500;
>  	u32			reg;
> +	int			ret = -EINVAL;
>  
>  	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR0(ep), params->param0);
>  	dwc3_writel(dwc->regs, DWC3_DEPCMDPAR1(ep), params->param1);
> @@ -313,7 +314,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  		if (!(reg & DWC3_DEPCMD_CMDACT)) {
>  			dev_vdbg(dwc->dev, "Command Complete --> %d\n",
>  					DWC3_DEPCMD_STATUS(reg));
> -			return 0;
> +			ret = 0;
> +			break;
>  		}
>  
>  		/*
> @@ -321,11 +323,15 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
>  		 * interrupt context.
>  		 */
>  		timeout--;
> -		if (!timeout)
> -			return -ETIMEDOUT;
> +		if (!timeout) {
> +			ret = -ETIMEDOUT;
> +			break;
> +		}
>  
>  		udelay(1);
>  	} while (1);
> +
> +	return ret;
>  }
>  
>  static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
> -- 
> 2.44.0
