Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB74EC4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 12:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37F1387618;
	Tue,  5 Dec 2023 13:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w+mhsth2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D0078721A; Tue,  5 Dec 2023 13:48:39 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E8338772E
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 13:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel.thompson@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33350fcb2c7so1177378f8f.2
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 04:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701780514; x=1702385314; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ifj4R7XB9Wga4zYezBn0SOBpDaW80mS0JIuqKuWhTyU=;
 b=w+mhsth2t1UGKoc9S+AhP5x9vjMX0Ae2WqWjOlKzJG8iQDZWfQ5U3XLzOqK30IZrJ4
 x1yeICdWFohEMZUmrY1uQC3qpA+5MNBBmhitHDj4OrhRt+sDNLerQAAJ7uL+b/Ne7+DX
 UhTJQrazjphf7JC0eoT7dIhx4Wu7d5gRM23iRwLSoKMPTV25+X/ZN9BzbyjX3HkSwv6O
 E3iiUbz7y0BBfyDtAI54eyKxSCYUAaz2DD4yT6A+Dhfx1H30X7OsGryidapJdF+fUjZ7
 lTvTTQJKTJHVS5/74hYKDYOZiDRXonWx4dMYW25lw6ZIuVu6hfxS5KIY8eNEy3wu42+K
 lfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701780514; x=1702385314;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ifj4R7XB9Wga4zYezBn0SOBpDaW80mS0JIuqKuWhTyU=;
 b=P6B6xvsNA2Xhy79U1cqlB3/03i63+1DD4foMby/U3bxUXAzsGpLxn8r6jg+JmgiGtX
 TLQm8XMlQg5X0PYAwU2UU8dPBONjPtDN0Lxm8aoNbYcwcv/M1FEhhQ2Hi4fB8xCQFtTd
 9X+oxBAo1h/C/ceywKES5DMnypQTgUkU5rNLGOEhzJ6VgXz48H7twgg7TRvp/ceXqZOV
 H7rLMOfZI6nXbnb/ODOrcM9KdJskaXzJJ61/uJTSJNvqaBuaSqELHFL0rQmVC+N9olR2
 B+YLL+gak1kyguOZaJ+D3ytGFIvpJvDQ0G88GWlp96D/CZ1DnOyHIX+i7fD0HH1ZqMuj
 e/2g==
X-Gm-Message-State: AOJu0Yz7ZQp8aSV/lHiRb8xKy42YgZx0xY+uDMiNKAkLbRIj+TdLB0g4
 6N8vQrGGA6DQUr59cSu4eaITHg==
X-Google-Smtp-Source: AGHT+IHevNWRDdEbIzpfaETzNZ48u1JhPbqA3pi5rYg16GDi8ayM2jqdXPDcQz2aQcB7HvIkyuRuqA==
X-Received: by 2002:a5d:4443:0:b0:333:2e1c:9553 with SMTP id
 x3-20020a5d4443000000b003332e1c9553mr4037280wrr.32.1701780514505; 
 Tue, 05 Dec 2023 04:48:34 -0800 (PST)
Received: from aspen.lan
 (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a05600001c300b003333b8eb84fsm8819864wrx.113.2023.12.05.04.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 04:48:33 -0800 (PST)
Date: Tue, 5 Dec 2023 12:48:31 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: ff <ff@shokubai.tech>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>,
 Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>,
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Message-ID: <20231205124831.GB56725@aspen.lan>
References: <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
 <7E60C667-59C9-4210-B8B8-041E00B14D1E@shokubai.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7E60C667-59C9-4210-B8B8-041E00B14D1E@shokubai.tech>
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

On Tue, Dec 05, 2023 at 10:36:28AM +0000, ff wrote:
> > Le 5 déc. 2023 à 10:46, Sumit Garg <sumit.garg@linaro.org> a écrit :
> >
> > ﻿+ U-boot custodians list
> >
> >> On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 05/12/2023 08:13, Sumit Garg wrote:
> >>>>> @DT bindings maintainers,
> >>>>>
> >>>>> Given the ease of maintenance of DT bindings within Linux kernel
> >>>>> source tree, I don't have a specific objection there. But can we
> >>>>> ease DTS testing for firmware/bootloader projects by providing a
> >>>>> versioned release package for DT bindings? Or if someone else
> >>>>> has a better idea here please feel free to chime in.
> >>>>
> >>>> This doesn't work for you?:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> >>>
> >>> Thanks, this is certainly a good step which I wasn't aware of.
> >>> Further simplification can be done to decouple devicetree source
> >>> files from DT bindings.
> >>
> >> Why?
> >
> > I suppose you are already aware that Linux DTS files are a subset of
> > what could be supported by devicetree schemas. There can be
> > firmware/bootloader specific properties (one example being [1])
> > which Linux kernel can simply ignore. Will you be willing to add all
> > of those DT properties to Linux DTS files and maintain them?
>
> A pre-existing effort to solve the same problem as [1] is System
> Device Tree, discussed in the context of Linaro supported OpenAMP
> project. It is not just about cherry picking devices that have
> bindings in Linux but also information about clock and power domains
> or devices that are not seen by Linux.  It is obvious that the
> resulting bindings should be maintained upstream in the DT repo
> regardless of the communities adopted solution.

This seems to be artificially linking two topics: system DT and DT
schema validation within u-boot. They are somewhat related but one of
not a precondition of the other.


> > However, DT bindings are something which should be common, the
> > hardware description of a device should be universal. IMO, splitting
> > DT bindings alone would ease the compliance process for u-boot
> > drivers in quite similar manner to Linux drivers.
>
> I remember a discussion with ST on that topic related to Framebuffer.
> U-Boot can need a very different representation of the same device to
> use it while Linux need an in-depth description of all shaders and «
> stuff » (another reason why [1] is addressing only a portion of the
> problem) So even if there is a single frame buffer binding, there
> should be two (at least) conformance tests.

I don't follow this, for two reasons.

1. DT describes the hardware, not how it is driven. Having a relationship
   between u-boot and linux DTs with different representation would
   imply that the hardware changes between u-boot and the kernel.

2. Even if we were to accept that there must be two device tree instances
   (beyond transient workarounds for missing features), why would there
   need to be two conformance tests rather than one conformance test run
   on the two DTs?


Daniel.
