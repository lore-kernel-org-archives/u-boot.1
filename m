Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5145BC25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 07:47:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3EB788361;
	Tue, 28 May 2024 09:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TQp7yzKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E088588361; Tue, 28 May 2024 09:47:39 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E831587F31
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-68187c5534cso350044a12.0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 00:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716882455; x=1717487255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S9Dds5Vkq9YvtNTrPC+g03NcFI52IUr7tMMYu/R6zfU=;
 b=TQp7yzKMOUbuZSzIvKAktboQM5w4EivEDbQAP/TR/pFtYUGAWdaOdKWObuo8PT1Fxt
 RTCQk337m5XCnOl/SsxuLjTkDZEt4H1ix1E5jSUSTKlQy/FLRA3hziZskUskDCasmfZC
 EfNfKNanOVEOum03Asi8tNh31oMqQSlqRKnwcrVMktWQ3QZAmWsZHjkzYtbT9XfOYR9n
 GwZzXnavg9YLb05crrszcxZ1UJn0BrHZTzOFR5kRe6IxqyTBaGxzNdBEZyHlhSnxoySo
 391zUyBCa1TumcPaYYAL5Suc3dZyC4rWks+opf3BX1Ql8Efjo8cvnHtnezwEXuiHXzvR
 AoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716882455; x=1717487255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9Dds5Vkq9YvtNTrPC+g03NcFI52IUr7tMMYu/R6zfU=;
 b=e2SI0ikVpaMqB3/tBt28XFaDDHBVK/buxflT4snD9Fwe5ggr5cgmwKAEqEEdOfN7ef
 wE7/8jxLSW977B02otV5m7wTSqL4KkdXNv5F3OtDjISNrT7+EVU+Ae/eC0lK5mnEG8jS
 k5D6EA9p/jcKc2d68/QiT8repjZzcUutOS9cuM7vvIFXX27Hr+eOzag39NTcQhoajrvw
 oXBjvCO4VKENerTBhUDZb2tqqxM3ZkzVG0SHMRu4tNvCisqBUvuLS9TI4ibMDDEMowoo
 3dlu/Y/Fvtb/Lg4VNqiyGBEdbNH9Y7v29Yjr4hhw772BSGBnF26Q0H+TSv8GNVSsn/Bv
 4JVg==
X-Gm-Message-State: AOJu0Yz+6xKwktw9a+1RDxX3PBtnMmfVVcJoIkZRETePjdLy1uMmLIil
 uwRip/SEKYv3axEEDh1SDnYV4KFCSWUqM2zmqp4Q+cOwIpESq2acP9odj/2G8XLwpLnxX4AhXOR
 Mccww3gfs0KCZ5iXrwaYJqlGA0W5D0TVPWQdm2g==
X-Google-Smtp-Source: AGHT+IEjxz7vS7mUfron7e+1tiCnn3wiYPO3jknaE0Qi+igq4hOiyrvf9pX5r5gp4vOhnjkDt+Iqr/4vtGOkxOEge7Y=
X-Received: by 2002:a17:90b:438a:b0:2bf:597d:f1d5 with SMTP id
 98e67ed59e1d1-2bf5e4738famr10441074a91.5.1716882455420; Tue, 28 May 2024
 00:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240528061827.183403-1-ilias.apalodimas@linaro.org>
 <e8082f27-e1e9-406a-84ea-b9f35de077b7@collabora.com>
 <CAC_iWjLS-igrVSqUJj2voe6f34X__hKkBG5GJoa96YL7oq2Xeg@mail.gmail.com>
In-Reply-To: <CAC_iWjLS-igrVSqUJj2voe6f34X__hKkBG5GJoa96YL7oq2Xeg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 28 May 2024 10:46:57 +0300
Message-ID: <CAC_iWjJNc=AP-6tgGts3wchGKJ0oX9P5KYwtW9BpYVNMJHcVmg@mail.gmail.com>
Subject: Re: [PATCH] arm: move _end to linker symbols
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, CFSworks@gmail.com, 
 trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, 
 ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, BMC-SW@aspeedtech.com, 
 joel@jms.id.au, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, michal.simek@amd.com, aford173@gmail.com
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

[...]

> > > -             *(.__end)
> > > -     } >.sram
> > > -
> > > +     _end = .;
> >
> > Does this have any kind of consequence in terms of checking the offset of .end vs
> > the SRAM size ? (.sram)
>
> The value of _end does grow by 16b on the SPL for the kria boards, but
> it doesn't seem to cause issues.
> I can only find a single assert on those checks in
> arch/microblaze/cpu/u-boot-spl.lds. Anything else you spotted?
>
> Keeping in mind that the code used to be like that before that linker
> bug -- defining a linker symbol instead of a section, I don't think
> anything will blow up

Also if you compile with -O2 instead of -Os the final binary and the
_end memory address remain unchanged. So I assume the changes in the
_end offset is due to compiler optimizations since the .end section is
removed

Cheers
/Ilias
>
> /Ilias
>
> >
> > >       _image_binary_end = .;
> > >
> > >       .bss :
> >
