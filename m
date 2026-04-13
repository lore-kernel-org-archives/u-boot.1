Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484BBF34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10BF584246;
	Mon, 13 Apr 2026 15:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Os/s8AeN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26C38423D; Mon, 13 Apr 2026 15:36:34 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4770984199
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35d9c7bf9a1so3929367a91.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776087390; cv=none;
 d=google.com; s=arc-20240605;
 b=SHAn7xq7tfCE4jvLcihb+fMiuC0eFbmyIBWXorm6hnvxWslLd+7qqyCmBIrgVDjCLc
 bMNwpBmAwYQ48RerF1BJf2BYqOrLmM4f3qsuSuU/z+Zlp6+IAmydLzDibsECN5VK21s0
 plJZyujjFAYK+wgS5VoFDiFpF+rjTRkG7oUoanhQIdT2mUB1+Cvr0z+osxbTgz7r3uEF
 BDdaXhDorYvuugyntVBm0c1DGKe2TvRFK4lskjX0XIDgoUdtvoPI2fqFK2UFknq9GVlP
 p17SG1qrbOOd+8NJhUvisobb5j63646UfPL27UDFl+v0VCDzWzxu0TZbDsfSnymW3ssO
 10YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6syZNdbyKIWxOaFQiLmobjOLL99Fwgkn2F+mv6Fe1+4=;
 fh=g/AySMeZ8irarr3MNV8jIwt2YlL2g9WaFK3gZX7WKCg=;
 b=Dul6CNvzoiSNi+7lL/a3kdutoEaT7EU+bygOkuhezT+zTHQ8rf8LEiiYY7YQvbksT0
 PkN8xBUMNMEvA1qawLp+/hsB6UF+EmZEZidnbU9ExyNPi2uArZqqOyM1QdvsqDrHL1kg
 NAZ9UwbsrozakiqiaLgQzU1fN5J2Ncg29PWt65/q/LfWXmPxu4pIzBDBuMdfZQbEN+rP
 tRnMmbP0plejQjj2wyeLkQ/kGNqrqhVs+Jl6/Z6z8BWqoZ29/WSEiRoLeUMeAs7yrjC4
 ArOP70GwzVh4VjbU/+FJYOlKJcHlfyQLrgcK0JwhVX7jmi4iWmoWiMkt4uHoUd7HsP18
 CFfw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776087390; x=1776692190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6syZNdbyKIWxOaFQiLmobjOLL99Fwgkn2F+mv6Fe1+4=;
 b=Os/s8AeNpIGQxUPUOg1CeTM+JSyw+oHUveBMIoFIm1JwH+os8NpzN2ZZIEARmyxyo8
 IBukmHDNTqvfBfEnOChARCaRnXvGdQXJlHSPm7Igh+6I0qfBqVe1a63Kj0IrcBRTzhMQ
 YHjp2f95zSGEza4wLzmZ0T3Z2NMG4hs0KPqCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776087390; x=1776692190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6syZNdbyKIWxOaFQiLmobjOLL99Fwgkn2F+mv6Fe1+4=;
 b=aU5Powyuuuc+djO3fAhDLxBRyLEHFkoFVZXk1Il2Yjr7H5Maz2DWGQWMA+UA5dJJy6
 2VgQz2wTm6UmaSKpXI3g4Y9R3qVmmbxPaTynqP014kAEvTsOCJfBHWtj2KGLKbeIgxfe
 aqPG407ZGTlRPzZ9WSCVfvwVL2mvvDQxeXg9nytutNyGeThvqNxCJFmNyc8pAbZZtmP2
 ll8rB9oX01IsgLdyNNCXsA8cymUyQV3+ywZMPGCkX6dlY5lQtJwyI1nXqynpsEZEsNde
 5AqRif77MTzgU0MayzI0P2chs6AoZs1qF9qLWVx/Dsy4txmqmSgwUMA6Ed7yxpmPx9Q/
 /nmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HaM8TNuefB0DPsO+WVKcKG5bOuL8tq4wOUBACx0VtpvtxqJJDTBqHghXMlXWYIlsC/n0eHPo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0qlEvbj1TLvWsUgZqoTuOigpQb+P9nTw/8uF37xPiofYSFkdg
 v0Qb80p9SuRobe1OzqB8QUqoJSzVaJSI6rVQqkRxkgPGfYTyLHBOCdGlKPMdYyCg6LfE+mmOiVZ
 n4MsVKMPPvgIIMVkRKIG0N8Q8t861cAdZUManq330
X-Gm-Gg: AeBDieuSK1RpZBuZRWnkOEyX9ArbA2R2C1uoiuAwVsqCO/SOi9ysq0Ba7CAbCn2JN1p
 8x0LMx/uajeu9cCYFeIsLeUK2/Ucvmi+7YenOuwKnrr/URwMtlUFZD63fiLpffcB0cU3e/R5+l5
 PxUd4A7CRiFR6ZNnZ0ygw5ULA+lQuIIFYFtC7uxpM13u0Od8Mh2iHEwTNHpm9ov+dExUP9ltoBp
 1FfuYJghkH639L15fQpo2FZlgJ/ebJIBqNtiXrk50AOs9sksjSjyByJylbecITtQfKuleSyBwPJ
 d+Cu7g==
X-Received: by 2002:a17:90b:1e0c:b0:35d:a3b4:2f00 with SMTP id
 98e67ed59e1d1-35e427ea4c3mr14757907a91.8.1776087389718; Mon, 13 Apr 2026
 06:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-6-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTij2Asndsdy4gdVgHWXqayKztvdV5mySX2A90+1xzOfdg@mail.gmail.com>
 <adx/vkAHk96k/CVv@hu-varada-blr.qualcomm.com>
In-Reply-To: <adx/vkAHk96k/CVv@hu-varada-blr.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 07:35:48 -0600
X-Gm-Features: AQROBzAbYPoAzob-CuTXDAy6aeaXs1QmyRI9IWxoRD-_N44k3Y0xhUMzI9pbDHA
Message-ID: <CAFLszTj3L1442VW8cuQZaTomx8qRLrCyL37fR=WXX=k+2pCkdA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] misc: qcom_geni: Add minicore support
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 13 Apr 2026 15:49:01 +0200
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

Hi Varadarajan,

On Sun, 12 Apr 2026 at 23:32, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> Hi Simon,
>
> Thanks for the feedback, need one clarification...
>
> > > +     ...
> > > +     if (elf) {
> > > +             hdr = info;
> > > +             ...
> > > +     } else if (IS_ENABLED(CONFIG_QCOM_GENI_MINICORE)) {
> >
> > If elf is false and CONFIG_QCOM_GENI_MINICORE is disabled some
> > variables are used uninitialised. Please add an else clause that
> > returns an error.
>
> Ok.
>
> > > diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> > > @@ -377,15 +413,22 @@ int qcom_geni_load_firmware(...)
> > > +     if (IS_ELF(*(Elf32_Ehdr *)fw)) {
> > > +             ...
> > > +             elf = 1;
> > > +             info = hdr;
> > > +     } else {
> > > +             elf = 0;
> > > +             info = fw;
> > > +     }
> >
> > Using 1/0 for a bool is a bit odd. Please use true/false.
>
> Ok.
>
> > > diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
> > > @@ -492,7 +540,11 @@ static int probe_children_load_firmware(...)
> > > +#if CONFIG_XPL_BUILD
> > > +int qcom_geni_fw_initialise(struct udevice *dev)
> > > +#else
> > > +int qcom_geni_fw_initialise(void)
> > > +#endif
> >
> > Having two different function signatures based on a preprocessor
> > conditional makes future maintenance harder. Consider always passing
> > dev and ignoring it when unused.
>
> The signature difference is because for one case it is
>
>         int (*probe)(struct udevice *dev);
>
> and
>
>         typedef int (*event_handler_simple_t)(void);
>
> for the other. Not sure how to reconcile between these two.
> Please advice.

One way is to use two separate stub functions (one for each signature)
which call a common function.

Regards,
Simon
