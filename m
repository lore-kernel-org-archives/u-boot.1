Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA01FECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 08:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A6B68860D;
	Tue, 10 Sep 2024 10:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="puQ1pKsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F95A8843A; Tue, 10 Sep 2024 10:27:18 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C848860D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374c7e64b60so262859f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725956835; x=1726561635;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V/GrDu6PXRVApt/gnVaFVv3O9vkAtwevi02JV32w52g=;
 b=puQ1pKsEOXVC+rKCUvsWky4A9SQ4yfCSgGp3mXdPhtfzw7/DGzCS+m/T+A8sw9qJhP
 JrCRIExyiR0bGOiJSU9TtUye4Xl28ShWNKsglQI7e/i19tiAp9bNmsotSJJ6JsJyAo3Y
 3pDOvtorHlbJ6p4Js7rEiQhYhlIKEsLZsIlAmbctA7E5y3qfVnLFvhMZfugbI1ewZkdV
 3OFI/ErfUyMyF4CGieZo3Qjbm7vydVDA1neYsrGpha/UrWr8rH8/SbjR4oY41WAhishT
 D2/OUyAkCl6b9e1eU6/+uPlfQOGq+Q58/Jj6KQedDki9BK3nmjknJdcPCmMAaN9mbJaj
 Fgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725956835; x=1726561635;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V/GrDu6PXRVApt/gnVaFVv3O9vkAtwevi02JV32w52g=;
 b=bgtjvUrK2kfaPlDnt18Sk9UHjUCjjQbry5G23o0nXtnQo8SMdSXaV9AxEv16KqOSkG
 T7QZbWO2fVqdqdgHwlCgDNojlNUCSgfL3mhLpJ4uCv+F+VfOn9Gx8y2sp2Owjqpb/fxx
 kQGIMA7zGQuOqGgEvK8Su4aYtf5uVrvKTBZDr0NTzkXOLz4FEJ/mpjSxv7tJnGtfAIRh
 mhuBDxJaEyvo0/zoG2eXSqCCG82nnRDJPJx6hCkoLzySzmflYa4LBm+ZNjdcYfi10Fm2
 XC7BFbFsA5AKoqOnDlmrDHB+wqyyfquz7nDQ9K16eqxXzKkeRGCvOz6waHflhTtOsQ15
 +alA==
X-Gm-Message-State: AOJu0Yz3fjSAdePA8ET8KJrj/kO4WqxUlRLHeEUbHHMuXsA6wq6BbarC
 pE2OT0yXVVoFfLJx/GainXRxdHK7uBezyoHXbAi0qTZMph4ajnYG4qa+YJV/3kw=
X-Google-Smtp-Source: AGHT+IE9Y50e2dH387f8RCWbV/0S4jsFByLnruWLaTQlpJPy2oE9yGHOBZNebdwdLq6kg6Snv/0Lzw==
X-Received: by 2002:a5d:5185:0:b0:374:c911:7756 with SMTP id
 ffacd0b85a97d-378896a4873mr7553039f8f.38.1725956834105; 
 Tue, 10 Sep 2024 01:27:14 -0700 (PDT)
Received: from mkorpershoek-xps13.carmes.etincelle-coworking.com
 ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3789564a16fsm8228471f8f.10.2024.09.10.01.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 01:27:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Miquel Raynal <miquel.raynal@bootlin.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Zixun LI <admin@hifiphile.com>
In-Reply-To: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
References: <20240826143851.8020-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 1/6] usb: gadget: Inline usb_add_gadget_udc_release
Message-Id: <172595683295.66154.13022419207192728411.b4-ty@baylibre.com>
Date: Tue, 10 Sep 2024 10:27:12 +0200
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

On Mon, 26 Aug 2024 16:38:36 +0200, Marek Vasut wrote:
> The release parameter of usb_add_gadget_udc_release() is never used.
> The function is never called from anywhere except from a wrapper in
> udc-core.c . Inline the function into the wrapper.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)

[1/6] usb: gadget: Inline usb_add_gadget_udc_release
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/188b26ea92f86b527f39ab66b38771a13fd67c7a
[2/6] usb: gadget: Drop usb_udc_release()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/1ef703d73dbb5cf524045bdb34226a86b4ab0680
[3/6] usb: gadget: Track driver data as part of struct usb_gadget
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/534a3e8c1a067daf31f290acfbafdd0c407d28ad
[4/6] usb: gadget: Drop dev_to_usb_gadget()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/1d030ba01de4ed7c2ae08301a00453c937df3cce
[5/6] usb: gadget: dwc2: Drop get/set_udc_gadget_private_data()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a765f5d6b4982202a42905db27f609365a47852e
[6/6] usb: gadget: Pass struct udevice to usb_add_gadget_udc()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/75c142c73242d91b0ea9670d3b7b891216351749

--
Mattijs
