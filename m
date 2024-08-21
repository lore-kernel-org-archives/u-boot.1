Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186C8C52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982A688B67;
	Wed, 21 Aug 2024 16:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JQ6xf9b1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA7FF88B63; Wed, 21 Aug 2024 16:37:26 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1DCE88B67
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf6beda038so40172526d6.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724251043; x=1724855843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KRgi3dnITRfLtz/eeglNUhFSWMh3xYiOE+mwmSTnxg4=;
 b=JQ6xf9b1nkCLNcp4YHat18+Qqlxhj80B7Fi9MZoHbc8SfMTyiw+IBpb+wNnCTovzhM
 aKodbvAf/A6iDdj0S8Xpkh44YMaaq+5+Yazrqif8momwVFeWgj2nuMQWtFrZxWXtCvBr
 3aQS50uIdQZCVOk9O3ceF1C/pe/Cbxz1MoFYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724251043; x=1724855843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KRgi3dnITRfLtz/eeglNUhFSWMh3xYiOE+mwmSTnxg4=;
 b=eziC3dxVYSM9+Cq/K4TWq32JdPFe3DEr/iFWQsOnnsoaeUqLS/19l3k2WEc+TdBBtF
 SdjZLT9FPcZuWbrqsTh67ITSaczE/U4sO3XDv+51CzGFTajoyreEpIiyJhX/nTr52NPJ
 92wMlVPqQECiS82Xad2e5AmyYo1H2PPk9Guq/L3fKFwOYMfKDFyfdDTMY0egtz/wd5kH
 TePCTwgyI686cZTpzCrvY2yjexUvM/SQjHw4UugXbwIBcvizRKAftW5YxjE5wF6Wuhl5
 AX/MuP98d6DSe9alUCKoDXvtcjVCI5G4q/vGKrlFaKnHKL4oxWpZlf2ettgsLr6J1M6A
 mJDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6mGvIj5fbjbDQhg8nOqG825CDtHdhevAIziJqAYhvDdugZrihGMiK9tJQd4bOqNw4X6yhdrI=@lists.denx.de
X-Gm-Message-State: AOJu0YyzN1OP9qMqiFLj8rz9T067RgCnWAkAbxwXAxZxKToEJkJW2f9P
 ddOn7OxtqCFTcdQacDOoTfQ5pZHhj412jeMuhghdCkmiRGzPy3Y3LnP/g9Hsd7llkJhvjnfAO6i
 Q8W9fNTO6LVMDK7pxSSUt39u82vhRk+u8AKjYSDj/8pP7Xyg=
X-Google-Smtp-Source: AGHT+IGgQDd3FnK5K7nep2DgicS+ODA7RCSyXTN24wkaqYA5UBppQRvGeMq7J3GNui9eSd/5x0obV8T5p7qOH9UB4Fo=
X-Received: by 2002:a05:6214:3bc8:b0:6bf:6e24:1d96 with SMTP id
 6a1803df08f44-6c1567d818emr25642896d6.19.1724251043401; Wed, 21 Aug 2024
 07:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
 <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
 <2a45562f-792f-4ad5-9871-bef82ccd2d18@linaro.org>
In-Reply-To: <2a45562f-792f-4ad5-9871-bef82ccd2d18@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 08:37:12 -0600
Message-ID: <CAFLszTjwjUnGYMdujDUNePBiEU8_oMpkZYpSK8REKxrMYUadpw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Wed, 21 Aug 2024 at 08:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Hi Simon,
> >> +U_BOOT_DRIVER(gcc_sc7280) = {
> >> +       .name           = "gcc_sc7280",
> >> +       .id             = UCLASS_NOP,
> >> +       .of_match       = gcc_sc7280_of_match,
> >> +       .bind           = qcom_cc_bind,
> >> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> >> +};
> >
> > This should use driver model, with a UCLASS_CLK and UCLASS_RESET
>
> Please refer to qcom_cc_bind() which binds the clock, reset, and power
> domain drivers.

Gosh, why? Are these devices not in the devicetree?

Regards,
Simon
