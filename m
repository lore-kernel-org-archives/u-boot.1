Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81B5C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13449875BF;
	Tue, 26 Dec 2023 10:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cVhg451Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D58C86EF3; Tue, 26 Dec 2023 10:31:07 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF1487725
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:31:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bb86235596so2974826b6e.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703583061; x=1704187861; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sNoQ+uShv+6lhTPIUU79tYU6b2wsnECCTfQhcmVDykg=;
 b=cVhg451QnGHmL8syAx5c+UecQky7iVfYYnuHQ8HPtowxjSxiVm0zh0h9Q44/2mPkFd
 RO9USGSd6RWXwcp4fvdwosihjMu9Zb90iUZS6edvZs0QHDnJKgLBIaJbrWx+gLCSYo/D
 zNkQxEf791xSGEBdLk1HtrrrALEyPWdZBa9K8mi5qW0iI4UofhgBqh35T+kj8O0kF0eM
 dRcdPHKXfH4vBidNpyIkv0d7tvPsXFLoA1wE/XCeaH713N8o9hmMUaq8ev6mkdXYllMR
 BKtRXSAEDDzgLL3DxbAvQY9BPNOQQiGWl4RcnWPwww0q1+aUCJuQQYOOpE/60T/Af6X+
 4z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703583061; x=1704187861;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sNoQ+uShv+6lhTPIUU79tYU6b2wsnECCTfQhcmVDykg=;
 b=jBD0Z3MZBFhoIDMSrbrgpw2QRrwQQ93jwZVZjyR2UPkVHH0Lec4mKEhQ1MWTMAmyk0
 ry/YvtGj5fVUFj3wfmOLUP4hOjvUCXuYTCZoDW8WmR8K/Iz5xm9f6Qktd9BPLVsoMaOT
 f78zLmOT6yDf0+LsVMR59rMD0bNtxTNVtfvm9oZxKKtTh5od0XwypTQzcCxL4dtXfzm0
 07L15Z0hqc+0221LZMXLIsU7KUZ5jWnQcxaKLa/LHyJ+/osfrhnEj7fwlFTby0nhOvoZ
 jna4ml2UjkCRIj74l4FU9IfVB3crtxjvQTB3jcI42PPh2YGYx+z/blW5313X5CS8/bnT
 BhSA==
X-Gm-Message-State: AOJu0YzbmyN0xsFfbfcB87SA5gpxzymKzuc7HX+NbxU9qX9Ecpg6iq5k
 3dGQoU25/ywjfLaCh9+nj73pKZeWr8idO1A0OzHMUpuMyrzaew==
X-Google-Smtp-Source: AGHT+IF90YggRRjXOG96F28Qeobs+1ChRsP/t4i5VrzJdV1nu7LpeyEiAh0XLHtabBNUNHU5juzdj7+k/nQZZ6htnIo=
X-Received: by 2002:a05:6808:218e:b0:3a8:7c67:7cd with SMTP id
 be14-20020a056808218e00b003a87c6707cdmr7855955oib.24.1703583061322; Tue, 26
 Dec 2023 01:31:01 -0800 (PST)
MIME-Version: 1.0
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-12-b6dd9704219e@linaro.org>
 <CAFA6WYMvb230qm95QLPW4iNOXPk0fhxDCP-OFN1FWLCsx9P2yA@mail.gmail.com>
 <e45ca070-82fc-4e5b-a7e9-eb44e956b98f@linaro.org>
In-Reply-To: <e45ca070-82fc-4e5b-a7e9-eb44e956b98f@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Dec 2023 15:00:50 +0530
Message-ID: <CAFA6WYNn0PDxikfVNnACiT2HZ=zge=O7XnpynPVfe61rKiedDA@mail.gmail.com>
Subject: Re: [PATCH v2 12/32] board: dragonboard410c: upstream DT compat
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 22 Dec 2023 at 21:43, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Sumit,
>
> [...]
> >> -       if (init == USB_INIT_HOST) {
> >> -               /* Start USB Hub */
> >> -               dm_gpio_set_dir_flags(&hub_reset,
> >> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> >> -               mdelay(100);
> >> -               /* Switch usb to host connectors */
> >> -               dm_gpio_set_dir_flags(&usb_sel,
> >> -                                     GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> >> -               mdelay(100);
> >> -       } else { /* Device */
> >> -               /* Disable hub */
> >> -               dm_gpio_set_dir_flags(&hub_reset, GPIOD_IS_OUT);
> >> -               /* Switch back to device connector */
> >> -               dm_gpio_set_dir_flags(&usb_sel, GPIOD_IS_OUT);
> >> +       /* Select "default" or "device" pinctrl */
> >> +       switch (init) {
> >> +       case USB_INIT_HOST:
> >> +               pinctrl_select_state(usb, "default");
> >> +               break;
> >> +       case USB_INIT_DEVICE:
> >> +               pinctrl_select_state(usb, "device");
> >> +               break;
> >> +       default:
> >> +               debug("Unknown usb_init_type %d\n", init);
> >> +               break;
> >
> > Can this pinctrl configuration move to the corresponding USB driver instead?
>
> Possibly, this is definitely something where DT is currently lacking,
> similar discussions in Linux resulted in the USB onboard_hub driver, it
> would be nice to add support for that U-Boot at some point.
>
> I don't think putting the pinctrl code directly into the USB driver is
> the right way to go, as it definitely wouldn't be accepted in upstream
> DT bindings.

As discussed in the other thread,
arch/arm/mach-snapdragon/board_apq8016.c would be a better place for
the time being.

-Sumit

> >
> > -Sumit
> >
> --
> // Caleb (they/them)
