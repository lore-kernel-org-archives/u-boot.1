Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E6AEEB56F
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 20:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8CD85DD2;
	Fri,  8 Sep 2023 22:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kywM8vjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2C9869CD; Fri,  8 Sep 2023 22:32:51 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230DE8071F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 22:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-502153ae36cso3959401e87.3
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694205168; x=1694809968; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0GqdVas5Ho65h547F5aFQ5o57KOoR//kT762k4QjXAA=;
 b=kywM8vjQ2GH/HfqdyBHy1OlKkT30/Gh+XRuU/QY8ZxqzJXaoj6VYf+1mbBbHo5z5ld
 8LujCo6OB0rBFuOwyR2FaTdctEgpmnWBRlGfC3HqO/8UyRSuJoeYZ71zPIuhgggtYq6f
 FW+EtRVlmbcg8OPJ2gqr6ZhtkfZK2fvn9Vu6S6YoQ57QwQ9jxMhY1m9F274pUGLlOAa1
 OExciitLeLmvBH0qqPNZfLyygx/Rsnie7PT75VA/0QWidxUIA8TWApI0NWivqOwPreNu
 nqN0z07FmYvQ6jRfM8CPtgZAvJDDWLl/3tna/RKtIoPhqN1fvYLMr5FJCGKMs6U1+dM8
 d4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694205168; x=1694809968;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0GqdVas5Ho65h547F5aFQ5o57KOoR//kT762k4QjXAA=;
 b=YGFbTklOLgmT7f7EWOcvu6CVs5d9b2zfOYVqtmSXt24Uu1IlJfa9FMRvFA6NUWAPth
 9MWyrECG6hhjL26Ks89dWC7iuNT+kWr3WLMq+b7Khqx1MaTAlYwUMsukhxkbOCuX169y
 zlcedaQGAS5gx0XveLnVGVDcDsobX8oj48vE3K6Jyc3BE20ShrnTYAp8xmEKHF/yDP5R
 HJNSEbL5vSQEXQaLVKddaeo0oHMnUaOBHGh1OTbLeSqfE8jao3VQNHtehyP8KBOmwaQa
 i6+PNt0e6SA0H1MDLuRZTXPS6keJzSZy9u84gYlz6S1GCNwhHs4w+gx19soVWgJam8MU
 nheQ==
X-Gm-Message-State: AOJu0YxqDKVeFC+4HqIQ0tcUe3nJLrDDchzfX4Gw+7CRyigyCkl3jbfS
 Ek2HurH5Mdth3bCs+l3tnyy6KlS0fAIrV6SFzTjlWQ==
X-Google-Smtp-Source: AGHT+IFrjnidrNtbLso11PqOgq8UoQ7zBV1BrLcS03y6ER2OJqIYGUcw4dyOrErNeIitVwdZMxED56hcRzD1u8QzDfM=
X-Received: by 2002:ac2:4bd3:0:b0:500:adbd:43e7 with SMTP id
 o19-20020ac24bd3000000b00500adbd43e7mr2987067lfq.8.1694205168330; Fri, 08 Sep
 2023 13:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230616084253.490380-1-ilias.apalodimas@linaro.org>
 <888a4523-0dfb-4b35-a809-947758519607@gmx.de>
In-Reply-To: <888a4523-0dfb-4b35-a809-947758519607@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Sep 2023 23:32:12 +0300
Message-ID: <CAC_iWjL9vxFuA2YpUUFUdHbf9W0WEHj6LpuJQ0UtV60RarPDZQ@mail.gmail.com>
Subject: Re: [PATCH] doc: qemu: switch swtpm instruction to 'tpm autostart'
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: sjg@chromium.org, u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 8 Sept 2023 at 22:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> On 6/16/23 10:42, Ilias Apalodimas wrote:
> > We don't have a documentation page for our TPM subsystem.  I plan
> > on sending one in the future,  but in the meantime document the
> > new 'tpm autostart' command in the QEMU instructions while using
> > a SWTPM
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > ---
> >   doc/board/emulation/qemu-arm.rst | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
> > index 16f66388eb1f..30819637723d 100644
> > --- a/doc/board/emulation/qemu-arm.rst
> > +++ b/doc/board/emulation/qemu-arm.rst
> > @@ -113,7 +113,7 @@ In a second console invoke qemu-system-aarch64 with::
> >
> >   Enable the TPM on U-Boot's command line with::
> >
> > -    tpm2 startup TPM2_SU_CLEAR
> > +    tpm autostart
>
> Do you really intend switch from TPM v2 to the deprecated TPM v1?
>
> I assume you mean "tpm2 autostart".

Both tpm v1/v2 commands will call do_tpm(). That function will
properly call a v1 or v2 API depending on the device it discovered. So
the autostart function will work for both variants correctly.

P.S: Looking at commit e663b2ff4ba2("tpm: Add 'tpm autostart' shell
command"), I apparently messed up a c/p and autostart is missing from
the v1 version of the command.  I'll send a patch to fix that

Thanks
/Ilias

>
> Best regards
>
> Heinrich
>
> >
> >   Debug UART
> >   ----------
