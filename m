Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC783C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 09:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6408832D;
	Tue, 16 Apr 2024 11:56:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VZgQJtY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ADD388325; Tue, 16 Apr 2024 11:56:16 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABF58832D
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 11:56:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so10818191fa.2
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 02:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713261373; x=1713866173;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qm+7FYucYsnXmlD4u7g033Q7mOB+5EdYh7RSvS+XwmA=;
 b=VZgQJtY0lpReHddVCSXqCM8rPaDe+cTr5NAQjdxVfE9eX7PDlUHJllH9wQm54Szfs2
 fd9BXFgVUXuTq5CgLybJ1QRWvz9OI0wzD7K8TE7FC3GecZV8ws2i9YWJXNj30IDmTV4F
 ccUTkf16RH61cCYOxQADxMKDwZD0qaRso3pkPDRtRIALhzKcto3hEqGpczyC2+Vy4/6r
 AyrBF8mNJAy6nVJcj3qYqocEP2IkKsPzHx+lANAl5cV1W4Jx/rObhgTby5araMUVclIN
 JYKVFRN2Cc4MfMTFiL21yEtohYM9VLb5LN8dXwVrsAXk9EgtX8xpF9XzUfEQvD6FsX5e
 arlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713261373; x=1713866173;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qm+7FYucYsnXmlD4u7g033Q7mOB+5EdYh7RSvS+XwmA=;
 b=rknzG+clqoNe9dFon/sWxgJX19KkYFheJN/461DNWTSu5meE3Z6A1EC87y6svqTSDS
 qE0gekvlStfr3GqmcBBsd8MNIhqIFq/VDYoDZAISDlbM5fjsX6+g7RPOC8oFFDGKdJNV
 ZQW1Orfr8KXbhtrq3Q5qZ0pq8OL73rRKBJ1PrJvr1/gmtWOs7i2xVKnP4+D/lWzL22sB
 YCXyskvWy163p50Pzj2oeey4KHwx/qYQwlQaL6gZ/Eg9830lk0sMy5+ekzu4XU2jbpPC
 3OOsnwUsTnBk+Qae1Un4TeJaWrhkT4mWiENJ3DbMuU7eZK5b3DamEZ+DgjK7wkqOwYF9
 jC6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlxPsVotdw4fHa/fAi3i2RnT1P79V5qHSI/764M68Rip3xl5m6uyaP76txdIME4KFoMw0hRBljJLOtmmXuPSThFWPdIA==
X-Gm-Message-State: AOJu0YwbP03uDvH5AmaHcNMvdqEwL9tzsVqSbyHGViKzzoUPyFl03xxR
 MoEYr3JgIHN1G2FjgwTAL3JmqU2WelWohdkvQZ11lKUJpaGjLBD8MpE/oJjpljA=
X-Google-Smtp-Source: AGHT+IHoPXFWJlUaSSAi7DKjx4z93GHd7LkTpN9cBv7i3pNVuV29tC9a5IXxe8hyF3qt8qsXuFnsGA==
X-Received: by 2002:a2e:9f55:0:b0:2d8:8fc4:ff14 with SMTP id
 v21-20020a2e9f55000000b002d88fc4ff14mr9072986ljk.9.1713261372852; 
 Tue, 16 Apr 2024 02:56:12 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f19-20020a05600c4e9300b00417d624cffbsm19216511wmq.6.2024.04.16.02.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 02:56:12 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Igor Prusov <ivprusov@salutedevices.com>,
 Marek Vasut <marex@denx.de>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] usb: dwc3: support USB 3.1 controllers
In-Reply-To: <20240411160527.835767-1-caleb.connolly@linaro.org>
References: <20240411160527.835767-1-caleb.connolly@linaro.org>
Date: Tue, 16 Apr 2024 11:56:08 +0200
Message-ID: <87il0h4onb.fsf@baylibre.com>
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

Hi Caleb,;

Thank you for the patch.

On jeu., avril 11, 2024 at 18:05, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The revision is different for these, add the additional check as in
> xhci-dwc3 core_init code.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/usb/dwc3/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 96e850b7170f..db045f5822d4 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -594,9 +594,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  	int			ret;
>  
>  	reg = dwc3_readl(dwc->regs, DWC3_GSNPSID);
>  	/* This should read as U3 followed by revision number */
> -	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000) {
> +	if ((reg & DWC3_GSNPSID_MASK) != 0x55330000 &&
> +	    (reg & DWC3_GSNPSID_MASK) != 0x33310000) {
>  		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
>  		ret = -ENODEV;
>  		goto err0;
>  	}
> -- 
> 2.44.0
