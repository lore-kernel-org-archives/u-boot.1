Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E28C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 06:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4553488D41;
	Tue, 20 Aug 2024 08:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EF6LrcNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FD6A88D62; Tue, 20 Aug 2024 08:09:45 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B47187042
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 08:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4280bbdad3dso39633995e9.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 23:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724134183; x=1724738983;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QX+4+I41p6iZN5it8SwVNajXB2f2h732NU6hLtfTegE=;
 b=EF6LrcNGLnxTYdvPhQgTqKhnvtFiF7CjsjY9c27bPJ5tGnANdxvAxYWCe9/1gwHIC5
 1NW/w39G+gf3sgPGEftvDzkkc+YNGX2MuaHTTtugBGOk3Kw+jmeRJxwKoAuySZH1l8CE
 DHg3P31dAIhDMKR0Drl4wzbeVyuF1TN7Hi+HLzKe00dw+nodVmek4l3nEBet00B0Oypj
 WJtSOmW1OiNRRaW2OTlvz4+V2Z2KhnfUdLWkLLO9gNmv/Fiq9QkS0Kyw8zM6YBWafgQN
 egvaaDc3DbhZ3HXITfbyyO/Y13Fm3pPbviIr4DBcTsS7wG3S42Dtdxc7SjP+eyiDoI8S
 5ZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724134183; x=1724738983;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QX+4+I41p6iZN5it8SwVNajXB2f2h732NU6hLtfTegE=;
 b=R2k3tf8cKf0w7rPOOFS9bnb4Xevj0qFZEPUOdccVcCLa8BEjoF1iwzHTKSqP7uv9cd
 fJwaT37ABcWy3Dvt8AqWRDdBRo3NJrSLXPwXtN0fYdNraeDhXZjUNzlU3lq9rS9tmdR0
 D20hN2Kpiqs6g3HWaG2mbLO8coqAjYXDKWjCZDqJNiE9ocKnT72Fs4rgGfZKRMrktpuf
 9os2HQTyYn56J8m9aaFUwvcG4gxXE03G9ru9Dqy+gkcTRCI6puxY8XlKIgxMTINwrdbP
 7z/c7fEcwdCVGqTPDqMtRvn0HFeVVdyFmJbWDtZuyxNn/HuKpYmmdSrsPoy/vVi+RsRw
 u6sw==
X-Gm-Message-State: AOJu0YzxliKdcpNB4LWFOPEd5SvNriu7xb5CRtvCatZJ5xQ3QYITRolM
 q0Rd3tgzYS7o4MUDMpbq1gTXMqiJ2xnr6G6wd6BPgN+91lwtlkr5D9adPlw1MKo=
X-Google-Smtp-Source: AGHT+IFGDB7cd8epOzcvCgp2ziLnRiv3mKbP58/yh6dnYJVAsbdZR821dZQnUwZ4CV39nimKYciXDA==
X-Received: by 2002:a05:600c:3b04:b0:429:994:41a2 with SMTP id
 5b1f17b1804b1-429ed785b80mr71476415e9.7.1724134181749; 
 Mon, 19 Aug 2024 23:09:41 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed648f55sm130781705e9.3.2024.08.19.23.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 23:09:41 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240818200425.89045-1-marek.vasut+renesas@mailbox.org>
References: <20240818200425.89045-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] usb: gadget: ux500: Do not redefine ops if
 CONFIG_USB_MUSB_HOST set
Message-Id: <172413418109.65039.6234923718288779063.b4-ty@baylibre.com>
Date: Tue, 20 Aug 2024 08:09:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
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

Hi,

On Sun, 18 Aug 2024 22:04:15 +0200, Marek Vasut wrote:
> In case CONFIG_USB_MUSB_HOST is set, the ux500_gadget_ops get overridden
> to musb_usb_ops . Simply set the ops one way or the other depending on
> whether CONFIG_USB_MUSB_HOST is set or not.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: ux500: Do not redefine ops if CONFIG_USB_MUSB_HOST set
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/cc4424db44f62edfcb96fef16102ad769a3909de

--
Mattijs
