Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92203C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 07:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C5A88348;
	Tue, 11 Jun 2024 09:42:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CCfxW0IT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C82588398; Tue, 11 Jun 2024 09:42:17 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6078288300
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 09:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-35f1c490c13so2742788f8f.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718091735; x=1718696535;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=46Ego2HJRUwV8bYVIN5ozCNJdS8KfJVy3LQGM2Yrck0=;
 b=CCfxW0ITJ5K/BKy5gZRxPW0aDOwsgpATm6rPzPEnfj7bm2EfIa6IyhoQMOLPPr20ln
 WnPBAYFMlevTXsZtSxRTDOqUiiGbdsm3uDLyIR9uuE/EzPPPhU5bEgKX+cohYSjRMDeL
 aDKq7T3XTLHlZa1lq+Ar+gGqVi+DB8+YGKsi/y8HoQdCitdtXNEaxErRQe2I5D8fFqO/
 7VhCFfG8DqhrWZfoba1d9PKKS4BfAL81N4OqmRzFCVLzK8QmIxsZIeu3DJb/IHVQVEnu
 uKj5XQ81HQzCReLuVUi00RuqBFetT/FfbG+UXwCXgYP+mSRNq7a+ZIB4oqJ5A4ROG/D+
 7Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718091735; x=1718696535;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=46Ego2HJRUwV8bYVIN5ozCNJdS8KfJVy3LQGM2Yrck0=;
 b=GU+NDFg2qCpgar+PZlusgPkk2nC3KfrzLcUsyE01O/pxZc/bOuQAVmm68KOoww4rDb
 eKr4CKDoPlLiPNNjwm2CJyIGwS2DFlng5hhiTIXq7p1VdM+HCoFZXD/GUg66B7ty1N+N
 I68QalEsmokreCCgT3DNUu7kP3O9IQoTONxAQK3Y+7KuIxODKnxR1Zrh8CoVQ5fX3CVC
 astMfLPPwjjvgXKTdvX5mmSz5kaFqci7INDIsYItMynhRsz3qVZTgYH79En6378qrrRQ
 UnHnPwMyrb+iDCpGZjDz9pfQiQNP3NebXe3GuNWCgGo6NAf1gjjEbUP3pzAOFGSLFLgl
 bm5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtO3C6aBJ38EzEsJEHLi5Y4p9p5hI09+kEq4YqtWxL6uxngkYYO+MveCcMRn2D7Te/XHXYAaN4mRFivDhGB4qrD0RskQ==
X-Gm-Message-State: AOJu0YyC4BMG8UfGgbunvHwxlXU39lx45wqpuj2bqkcfpRFeSXO62O9B
 i+XgOk7qgIxxbPWws57YgbuaFJUwdl3i+CX5bHfKnXEVFmj09k+LHi41wKxDcmk=
X-Google-Smtp-Source: AGHT+IHxxawgjUhVCgjSpA8zRJlJIM0gLVyPi3//SBQhzAFufdYJovV+jPRyxLeF0re2HDzpAk023g==
X-Received: by 2002:a5d:47a6:0:b0:354:b7da:d3d4 with SMTP id
 ffacd0b85a97d-35efedd7da7mr10541331f8f.50.1718091734518; 
 Tue, 11 Jun 2024 00:42:14 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0e49e898sm9205955f8f.22.2024.06.11.00.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 00:42:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Felipe Balbi
 <felipe.balbi@linux.intel.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>, Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 5/6] usb: gadget: Add full ep_matches() check past
 .match_ep() callback
In-Reply-To: <20240609213449.194762-5-marek.vasut+renesas@mailbox.org>
References: <20240609213449.194762-1-marek.vasut+renesas@mailbox.org>
 <20240609213449.194762-5-marek.vasut+renesas@mailbox.org>
Date: Tue, 11 Jun 2024 09:42:11 +0200
Message-ID: <87y17cylgs.fsf@baylibre.com>
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

Hi Marek,

Thank you for the patch.

On dim., juin 09, 2024 at 23:32, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> If .match_ep() callback returns non-NULL endpoint, immediately check
> its usability and if the returned endpoint is usable, stop search and
> return the endpoint. Otherwise, continue with best effort search for
> usable endpoint.
>
> Currently the code would attempt the best effort search in any case,
> which may find another unexpected endpoint. It is likely that the
> intention of the original code was to stop the search early.
>
> Fixes: 77dcbdf3c1ce ("usb: gadget: Add match_ep() op to usb_gadget_ops")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I've added Vignesh to the CC list since he is the author of
77dcbdf3c1ce. He might be able to comment if this was indeed a mistake.

It looks like a good fix to me as well. With this change we match more closely
the linux implementation (usb_ep_autoconfig_ss()).

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/usb/gadget/epautoconf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index 09950ceeaed..66599ce8efa 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -247,8 +247,11 @@ struct usb_ep *usb_ep_autoconfig(
>  			return ep;
>  	}
>  
> -	if (gadget->ops->match_ep)
> +	if (gadget->ops->match_ep) {
>  		ep = gadget->ops->match_ep(gadget, desc, NULL);
> +		if (ep && ep_matches(gadget, ep, desc))
> +			return ep;
> +	}
>  
>  	/* Second, look at endpoints until an unclaimed one looks usable */
>  	list_for_each_entry(ep, &gadget->ep_list, ep_list) {
> -- 
> 2.43.0
