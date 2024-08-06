Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C05AC52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37D4388B1E;
	Tue,  6 Aug 2024 23:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fFVGSnlp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003C788AE3; Tue,  6 Aug 2024 23:51:18 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A397C88B1E
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7a2123e9ad5so186029a12.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981074; x=1723585874; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0xDPEksGgQ0JKtQOeW0kct2RjskKb45QX8kZ5HIhNSU=;
 b=fFVGSnlpBbjVZQsrVDJ+GM7cSok0pODZ+7geSYMsRz7Wp3MTVcfNoqdJLKEUuhNjMT
 oZlFCw814tYt6OaMe1w7wqMSCMGQDfcwJ25RmDc/HiuQxJFJCiefvIQ6RONCtACv96tt
 V+Yp0X1/hawIDUyxSyyXv2Q+R0xJtQdjCHGko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981074; x=1723585874;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0xDPEksGgQ0JKtQOeW0kct2RjskKb45QX8kZ5HIhNSU=;
 b=uGvEE/g22kZh7nYXcMOQE/xBmt+2WeArfQ2jJ8Rhl5Krq9JQY2oNs1KlBwAI0a5P5b
 KAeR0RpJ9LM2GqYXQ8mkSTmemqzPGv/Hw2yJu273lDMI0N8fe2It1h2eL4mH8jt/lf/1
 42frHAaCgYTT6yK109E8IcEKlSx/hOKrbkqhhSiM8/Wr4+nxHIBYpo/SNmz08uzErKjx
 4eqI5O8PYrHA1dkplhgk5Cp15lnMu3hQdMgHOP9gFJopqYHdidyX9l3WSGfwtL6zHTC7
 hkl+37obp5ua9rxZO7b+27j2bOSP1Cxm9VS9/ooXfhDgWkJZokKwiG2SqS+Uqr62laB+
 Yekg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlLV4MtPtjEwHrbMX5Qu+ngiFJo2deAZywIs7PsPulzKiJF4cXb+2kIa+ZL3Es/Vw6QTbBejwgsRK6U8KZCulU1Of+CQ==
X-Gm-Message-State: AOJu0Yy/9z707jjuDlBUFXG7QRFgyWIr1GJNh8n9m6ebva8amDIdhYAa
 tT7w4hl9vt8USYx5sLAQ5lkmkpDJ/djaadaVbQs9rzgzJoSMPkhzU29qwNz4fmM3DBfd3d1lRaX
 n+QuX9Bx/YivFdWMVtd3ozD7h0NC9sHKqLQPx
X-Google-Smtp-Source: AGHT+IEdj7DmMl3nU4APnlGzi6ORt+hVrNwl+Qz5YkiNG21FUZyIFzPrDcFl2w/xmlxjSgerKy72DqnJE/Ee+76BDW4=
X-Received: by 2002:a17:90a:c905:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2d1b2d6b05fmr278738a91.15.1722981073858; Tue, 06 Aug 2024
 14:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240804150556.3519995-1-jonas@kwiboo.se>
 <20240804150556.3519995-2-jonas@kwiboo.se>
In-Reply-To: <20240804150556.3519995-2-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:58 -0600
Message-ID: <CAFLszTgqxDsQ+mxpOPguETPoO69cpOdW5B57pXwn70reQWHt6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dm: core: fdtaddr: Avoid multiple calls to
 fdt_parent_offset()
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Sun, 4 Aug 2024 at 09:06, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Use of fdt_parent_offset() is very expensive as detailed by the function
> documentation:
>
>   NOTE: This function is expensive, as it must scan the device tree
>   structure from the start to nodeoffset, *twice*.
>
> Re-use the returned value from a single call instead of having to make
> multiple calls for same nodeoffset.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/core/fdtaddr.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
