Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE843C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A1D870F4;
	Tue,  5 Dec 2023 10:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iKtDZYxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7105D87075; Tue,  5 Dec 2023 10:46:03 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2890870F4
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-49618e09f16so1674014e0c.2
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 01:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701769557; x=1702374357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xQhEkQTazVc8KR2U5vhflHnfxBilbhz2J1KZhBqN8o8=;
 b=iKtDZYxyY3DLnIqSYoRvK0M+TkUgigcgnv6pTdGanwKPtS+MvDbjo51Zt2Q0+6kVTA
 3vg3i1Qk62eM0XEJheqRJaNc4Yg+RrJ1Z28RLcBhxXBIVahxUb7T2FIM2Sri9JLYhCXy
 9zOQ9l24v16L+eYI5WB/EuGPMViqbe4N4G/rGFu/cLcocl0EtGadkprtldUFsVm/H2cH
 XvZ7XIXMo0MIJBl3o75LXHhKeYPN9SIjjJOQ4wK2Ayr3e7uUmr8QbGmKN1ZAVv9rqaG5
 BLcjIDJuTzXcT4MErZPKwxsCxDOfflNaUSYRzVnMTilTFvf1EpnF8ZMnCg9G9hS+ZOa8
 mQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701769557; x=1702374357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQhEkQTazVc8KR2U5vhflHnfxBilbhz2J1KZhBqN8o8=;
 b=I6UaOAw5RRAL4OVI8Hxo+y3Db/dgUTeKt7sGI39s7dyPqMezWkbcgDV2KHt1dKADej
 nUZOfw7PNxQuM0SJYNxfKK4HiVKZpOKumVCpXGSBVx+bIoUxXwHwtkqoQToSewE2kbHZ
 DsdIZwX0KlgBbSfo3u54plvzns3si2hyQiA7gDrfWPUgyl8XhErvBVpnmsKZIoUxR/xQ
 ZoUYv+w4LZZSdkx7mQAc+bans+DRwd4/JOsXJuyLCxUBbr0x3iuJYeDv6VQpqd0alNyT
 9HE01xvsleyHPQEfXnuqzu3ZrToJhSUvOsIEdkD+1IXYE91Iwft2WQjWKRyx2h2LMD8h
 VIJQ==
X-Gm-Message-State: AOJu0Yyx4yiQvyDOtnCbyJpvO/tCMB5Uum6f/G82LXiRXBE/U6xsBNIa
 1XiNGE9RrV2p2NgL1bRS9oz1As4HdVw6ynYRs9rA6w==
X-Google-Smtp-Source: AGHT+IHksHNvIsMqELHp6IpXrslWsE39vUjyROYryGCaix47Hpel/pp0NpREaUQZqS2ngqUymXLs1bqHyye/Z01T9bY=
X-Received: by 2002:a1f:c986:0:b0:4b2:c6ae:d73b with SMTP id
 z128-20020a1fc986000000b004b2c6aed73bmr2558271vkf.7.1701769557117; Tue, 05
 Dec 2023 01:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
In-Reply-To: <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Dec 2023 15:15:44 +0530
Message-ID: <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 u-boot-custodians@lists.denx.de
Cc: Rob Herring <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, conor+dt@kernel.org, 
 Caleb Connolly <caleb.connolly@linaro.org>, neil.armstrong@linaro.org, 
 Ramon Fried <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Boot Architecture Mailman List <boot-architecture@lists.linaro.org>
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

+ U-boot custodians list

On Tue, 5 Dec 2023 at 12:58, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/12/2023 08:13, Sumit Garg wrote:
> >>> @DT bindings maintainers,
> >>>
> >>> Given the ease of maintenance of DT bindings within Linux kernel
> >>> source tree, I don't have a specific objection there. But can we ease
> >>> DTS testing for firmware/bootloader projects by providing a versioned
> >>> release package for DT bindings? Or if someone else has a better idea
> >>> here please feel free to chime in.
> >>
> >> This doesn't work for you?:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
> >
> > Thanks, this is certainly a good step which I wasn't aware of. Further
> > simplification can be done to decouple devicetree source files from DT
> > bindings.
>
> Why?

I suppose you are already aware that Linux DTS files are a subset of
what could be supported by devicetree schemas. There can be
firmware/bootloader specific properties (one example being [1]) which
Linux kernel can simply ignore. Will you be willing to add all of
those DT properties to Linux DTS files and maintain them?

However, DT bindings are something which should be common, the
hardware description of a device should be universal. IMO, splitting
DT bindings alone would ease the compliance process for u-boot drivers
in quite similar manner to Linux drivers.

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/bootph.yaml

>
> > AFAIK, DT bindings should be forwards and backwards
> > compatible.
>
> The same with DTS.
>
> > So if you pick up DTS or DTB from any project tree
> > (upstream kernel or stable kernel or u-boot) then DT schema validation
> > would ensure that corresponding DTS or DTB doesn't regress the DT
> > bindings.
>
> And why is this argument to decouple DTS from bindings?
>

See above.

> >
> > Ideally, it should be more user/CI friendly if DT bindings can be
> > easily installed alongside devicetree schema tools [1].
> >
> > [1] https://github.com/devicetree-org/dt-schema
>
> Does it mean you will work on this?

I am happy to collaboratively work with DT bindings maintainers and
the u-boot community once we can reach a consensus on the above.
Basically the main motive here is to validate DTS files present in the
u-boot tree and be able to reliably pass them to whichever Linux
kernel version you are trying to boot. IOW, make Linux distros to
reliably boot with devicetree supplied by u-boot.

-Sumit

>
> Best regards,
> Krzysztof
>
