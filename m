Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A58CEF173
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89D7D88C24;
	Tue,  8 Oct 2024 15:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dshPgHKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AD8288C10; Tue,  8 Oct 2024 15:22:00 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE2588E6F
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42e82f7f36aso49642605e9.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728393717; x=1728998517;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=09JKdKDYyFEgS5uw83OYf/4Wl8slIYaXPEiRPDsuEJA=;
 b=dshPgHKOQ19BCaQEREB5PJWKzjtPcbbusYTPFkPAY1chJ6EytEiiYsxBYRc0YZ1kpp
 mdwx/eriN0qDgL1Udhwu3dy8NsIT+e1M0l3xEBnHceePV0PicgPXSm7xWEeOmajZJz+I
 rhpQohu6McnALt7gWaILLKL103eq2EeXeBjWii1Yi6ViflrvOk+xhwAWOlw44OnHkN4S
 Mie3ewP3RDjDIBM+/J8ugebPCTx1oY9TCeUWz28EvMXlZyQqzDOKzB4RXof0gN7x51vV
 w0dRy3LPOfxi1UjgFcoSuN96wNRJMEn6OPGZ76Ur14AG/6TmSWQf/3OGvGfedawuH1Ej
 LDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728393717; x=1728998517;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09JKdKDYyFEgS5uw83OYf/4Wl8slIYaXPEiRPDsuEJA=;
 b=GBB+0tN+trKAsKD6u3CoyJzF/7/ENqK5wfC5IMDM+b0GXTMc8svY+o9pchZBMqf5Nz
 AG3lzsU6rHdf8UaehG5mBzljvF3my7pHXPWK/dP8CN4joonI7/SSaIa0fFmHVoiDvvqA
 fAgxbXkhwtjo8IjP7udwhatphcM66uSZOyrTE+nhGcyfcKXkk8Nbx4cRqajGpFvZSLK1
 SrJmmH6b2CEGeRVxTchNmC4Kh5qLuWl34+vU0Einj7ePQOARwFZHQ4a0CTd5Xc6BidrK
 AU9a9tHAGKPTVyKKsI3LNZ3cK9yxQRf78Tleqsyeu3sm32OLeGWy7enQuFUz2jaKe+xn
 sesg==
X-Gm-Message-State: AOJu0YwpZWQFpPMBHYMxeq4Iyu5FzYxK4/s+rxgr46fBNU5wr4tufQT/
 VY5kP/D0WTAYKPAZ4RaOpQdmtbbnnuN2QWF9M0qZZqC4qqtsUiYXaAF9IbxIerA=
X-Google-Smtp-Source: AGHT+IGI8H0x2jOmA/pp9/v83FxcifTGkVw6qeEp9VIHgM+1gfKUhQ1y708JsXxiJ+/Z8+QFaKBVxw==
X-Received: by 2002:a05:600c:5128:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-430563ab791mr10938775e9.11.1728393717179; 
 Tue, 08 Oct 2024 06:21:57 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43054aa7733sm14774655e9.35.2024.10.08.06.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:21:56 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 lukma@denx.de, marex@denx.de, rogerq@kernel.org, vigneshr@ti.com
Cc: u-boot@lists.denx.de, srk@ti.com, s-vadapalli@ti.com
Subject: Re: [PATCH v2] usb: gadget: cdns3: Fix cdns3_ep_config() by setting
 ep.maxpacket
In-Reply-To: <20241007121927.1680039-1-s-vadapalli@ti.com>
References: <20241007121927.1680039-1-s-vadapalli@ti.com>
Date: Tue, 08 Oct 2024 15:21:53 +0200
Message-ID: <87a5feg26m.fsf@baylibre.com>
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

Hi Siddharth,

Thank you for the patch.

On lun., oct. 07, 2024 at 17:49, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:

> The function cdns3_ep_config() calculates the maximum packet size based
> on the Endpoint Type and the Gadget Speed and stores it in the variable
> "max_packet_size". This value is then programmed in the USB Controller
> for the corresponding Endpoint. This may result in a mismatch between
> the maximum packet size programmed in the USB controller and the maximum
> packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
> Additionally, since TD_SIZE is calculated in cdns3_ep_run_transfer() on the
> basis of the maximum packet size stored in the "maxpacket" member of
> "struct usb_ep", it may lead to an incorrect value of TD_SIZE when compared
> with what the USB controller actually expects (max_packet_size).
>
> Fix this.
>
> Fixes: 7e91f6ccdc84 ("usb: Add Cadence USB3 host and gadget driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Hello,
>
> This patch is based on commit
> dd4d130c8e clk: renesas: rcar-gen3: Fix SSCG caching replacement with MDSEL/PE caching
> of the master branch of U-Boot.
>
> v1:
> https://patchwork.ozlabs.org/project/uboot/patch/20241007104239.1624430-1-s-vadapalli@ti.com/
> Changes since v1:
> - Based on Roger's feedback at:
>   https://patchwork.ozlabs.org/project/uboot/patch/20241007104239.1624430-1-s-vadapalli@ti.com/#3389960
>   rather than using usb_ep_set_maxpacket_limit() which changes
>   "maxpacket_limit" in addition to "maxpacket", only update the "maxpacket"
>   member of usb_ep.
>
> Regards,
> Siddharth.
>
>  drivers/usb/cdns3/gadget.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index ac7e469469..a30c40ef80 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -1637,6 +1637,14 @@ void cdns3_ep_config(struct cdns3_endpoint *priv_ep)
>  	else
>  		priv_ep->trb_burst_size = 16;
>  
> +	/*
> +	 * The Endpoint is configured to handle a maximum packet size of
> +	 * max_packet_size. Hence, set priv_ep->endpoint.maxpacket to
> +	 * max_packet_size. This is necessary to ensure that the TD_SIZE
> +	 * is calculated correctly in cdns3_ep_run_transfer().
> +	 */
> +	priv_ep->endpoint.maxpacket = max_packet_size;
> +
>  	ret = cdns3_ep_onchip_buffer_reserve(priv_dev, buffering + 1,
>  					     !!priv_ep->dir);
>  	if (ret) {
> -- 
> 2.40.1
