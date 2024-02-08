Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AADC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 12:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54AD87E42;
	Thu,  8 Feb 2024 13:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="jTRK9iTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC16D87DFF; Thu,  8 Feb 2024 09:22:37 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A849B87DFC
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 09:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ole.orhagen@northern.tech
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5116bf4dcf4so817116e87.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 00:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1707380554; x=1707985354; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yq8sf8pN18pmCZtHfPEly0i5YVMew/xNlwafQ5p1qRw=;
 b=jTRK9iTpZVeGWTYnNDdzNEw7jn4NEXYw8CKegx3roT4b9jKsE2GdZ2AXkGzL0CxOKE
 ZoTGPeQ5RbdSzhaWfztsGfaPm35m8FJtFN0ENyFPJknoU79JLpDr55AEZVqc/G2PZXDh
 u1Lxo9oTXoCxOZdhRuqclr2XNSSYo4CYQfqcHoJIvYhcGke5/lpIr6GZwjwiKlRdgkjS
 0A1Q/9gs4SEBcEsboiouTjyGhPW52Z6yyxiW09o6WAEtBzqaPArvDBPbjjsNH1I8JqA+
 xp4Uv8sW/SZjk+oyzExlLU+38ntUgdUgkJKOvSVxqSTq+tPvAQ4yAAnG/wMVV1Pnws7t
 nVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707380554; x=1707985354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yq8sf8pN18pmCZtHfPEly0i5YVMew/xNlwafQ5p1qRw=;
 b=iRyR806Ch9tVPwvQM5gjIR8zQWnivj677GRdt9OY8dOWSMCMCMUrV5uc97akSU+A4v
 FduLloLWiLcOwUIqoRkASmBo+HjOH8fCJ00+ThvyCfRWACDl9+5++PjxMIY41VGNzKSl
 BUQcw8P3aF8xfiuMgd9bThFIKPQXuM7XNC3eLMo3YcEt2i+Pt9p9m69j1PLVsc5mDW77
 mikhaIk6+77i6wf5YM8yMEHeYUVGCc8HI78w6LPzRVC45b1qA+NVKCBUVCdt6TziUvvu
 S4clVtKtI4dO3m6MQug1I0lhW24oWRJigBkLLGzeU/Ajt/5/XiDhIKt5MxpXvW/C4XVn
 kKLg==
X-Gm-Message-State: AOJu0YzCTirtPqdf97w/H/fLdHQrms2cdrZLW/P6jg8ivO1yW5QZFURh
 WMWQg9wNj/n11UdcRlesY5buuaLhcgy/rfOB7F4uHG3S70/fqOxuOAOrmfPh8L882eRGLZaVA4J
 QRHlm9hoL1QufaUtcTSn4zXF+uXzN9qp6brISpeBQ0Oc8yv9wYzyBj3hBmjLDCk1EUUJf3bztAA
 3tGV377u+nXQrxIms=
X-Google-Smtp-Source: AGHT+IFskaq4alI5DHKETNAFRSbWrryd9yLGwO7HjbXMBXIpbwPZrU7/eCk2z4DW4RBO57ENucqv8igsSSv2TIjZfb0=
X-Received: by 2002:ac2:5e8c:0:b0:511:68bd:e23e with SMTP id
 b12-20020ac25e8c000000b0051168bde23emr2264276lfq.41.1707380553567; Thu, 08
 Feb 2024 00:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <20240207154457.GB1152441@bill-the-cat>
In-Reply-To: <20240207154457.GB1152441@bill-the-cat>
From: Ole Orhagen <ole.orhagen@northern.tech>
Date: Thu, 8 Feb 2024 09:22:22 +0100
Message-ID: <CAD5A3Css2=AeozV1x3C3BBypH2LDYWOt9j85VzM89ZWg_WV4Zg@mail.gmail.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Kristian Amlie <kristian.amlie@northern.tech>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, 
 Mark Kettenis <kettenis@openbsd.org>, Patryk Biel <pbiel7@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
X-Mailman-Approved-At: Thu, 08 Feb 2024 13:10:31 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Awesome, thanks!

:)

On Wed, Feb 7, 2024 at 4:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:

> On Fri, Jan 26, 2024 at 01:47:50PM +0100, Ole P. Orhagen wrote:
>
> > This commit enables support for DM_SERIAL in the vexpress_ca9x4 boards.
> >
> > When running the board with the DM_SERIAL driver, the board ran out of
> > memory in SPL when initialising the DM serial driver.
> >
> > Thus this required an increase in the pre-allocated SRAM memory. I did
> > increase it to 0x800, and it now works graciously.
> >
> > It could probably be set lower, but I do not see any reason not to use
> the
> > available SRAM at this point.
> >
> > Also adds stdout-path to the 'chosen' node in the device tree.
> >
> > Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Applied to u-boot/master, thanks!
>
> --
> Tom
>


--=20
*Ole P. Orhagen*
Software Engineer | Mender <https://mender.io>
Oslo, Norway
<https://www.linkedin.com/company/northern.tech>
<https://twitter.com/northerntechhq> <https://northern.tech> Northern.tech
<https://northern.tech> | Securing the world's connected devices
