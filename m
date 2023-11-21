Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D13C54FB9
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 08:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 558AE87232;
	Tue, 21 Nov 2023 09:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mj09NP+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C3988717E; Tue, 21 Nov 2023 09:17:47 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59A987444
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso23141855e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 00:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700554663; x=1701159463;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=dnZsGRjNne9NoiCnfMEKwUK3g5pl6CMOmZBgdXEaPGE=;
 b=mj09NP+CRR8xHT3joXB0mztc5MQQLsoaUt4UGQSXK8/Ezt/qqzb9Kid6TlPxYLYTCQ
 j/IqC7wmKW+jO8Di+rl7gQlMwQk7aH203jVXV/SfIq8WY0jo1917/eyx9mzRzc//OrkI
 EM10rnsfMf5+x1bMj/XmHl2SH8lT77l40RAAFydqcoetJuVN2Obe4jMgfXQrA35hWAGN
 LywnLGHBGMRmOIPjz4RVMofhYRacbzUufN5elD5+uJtCcXkP5sZgPezFfjXlEhsQatK6
 UjvC6t8jTvB85+WYYq8Pll00+g17dcQQixQMQkRsxunoKXBDtum+Cvpysy1fhZOP3Brm
 PBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700554663; x=1701159463;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnZsGRjNne9NoiCnfMEKwUK3g5pl6CMOmZBgdXEaPGE=;
 b=XCag4qCnE/hTvH2gqjrm43vQTn4MfBZqe3Ku3PZc16uXc6YTk0FQ0GyE/O2t1HNftn
 bLoBQdqwQvKrQTkpV04tj4Mz1HsVgaW3iL2pVAvqU2g/3W6MGbeSlHJsZ3j3A7NfrIer
 1JLaIiifaVPPvOTnWhULR8k292imhfMkTblFJczyKOYt28f2uZF20qoq/PW/isbB1Y1v
 6JRJcelQ9zQjaiAQnmiWZevQI8pIU5MKxeDXloNlona8qmZD8lBtPd///d2hmngLD8x5
 fqkieWS4M1101iu7iVMHNpifinHBMrKYQRLdn4bnkbaoydzJdMj5nstRbLFHKNFY2t7R
 Lgxw==
X-Gm-Message-State: AOJu0Yx2HAMGCmavGwSd1W0AqRoSoDcFlNSsUdH16F8MLdsZR+pl0fdf
 y1jc/latgo5KN4TSglvSfWuLGw==
X-Google-Smtp-Source: AGHT+IHLYwQjp4lzmzOUsbEz62Cqm32TBiOneb1xb+RCVQd0Z791lcLPnMDTmp9v3YaNORu/0jzyZg==
X-Received: by 2002:a5d:4012:0:b0:32d:8855:138d with SMTP id
 n18-20020a5d4012000000b0032d8855138dmr6059348wrp.66.1700554662956; 
 Tue, 21 Nov 2023 00:17:42 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 c15-20020adfe70f000000b0032da8fb0d05sm13637841wrm.110.2023.11.21.00.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 00:17:42 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Holesch <simon@holesch.de>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>
Cc: Simon Holesch <simon@holesch.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] usb: fastboot: Add missing newline in pr_err
In-Reply-To: <20231120002024.32865-2-simon@holesch.de>
References: <20231120002024.32865-1-simon@holesch.de>
 <20231120002024.32865-2-simon@holesch.de>
Date: Tue, 21 Nov 2023 09:17:41 +0100
Message-ID: <87cyw3msey.fsf@baylibre.com>
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

Hi Simon,

Thank you for your patch.

On lun., nov. 20, 2023 at 01:08, Simon Holesch <simon@holesch.de> wrote:

> Add missing newline in pr_err.
>
> Signed-off-by: Simon Holesch <simon@holesch.de>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - add commit message body
>
> Thanks for the review!
>
>  drivers/usb/gadget/f_fastboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
> index 741775a7bc..9f322c9550 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -520,7 +520,7 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
>  		cmdbuf[req->actual] = '\0';
>  		cmd = fastboot_handle_command(cmdbuf, response);
>  	} else {
> -		pr_err("buffer overflow");
> +		pr_err("buffer overflow\n");
>  		fastboot_fail("buffer overflow", response);
>  	}
>  
> -- 
> 2.42.1
