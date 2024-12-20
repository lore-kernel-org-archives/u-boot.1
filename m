Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477B2E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4507280381;
	Fri, 20 Dec 2024 05:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="erFSFn8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11898804FA; Fri, 20 Dec 2024 05:06:20 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D4E8036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aab6fa3e20eso256092966b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667577; x=1735272377; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7zJiMkdvSuVwLFby1yzXIyXnY7fTF0nJGOMt7+/G7YQ=;
 b=erFSFn8VEDMMGgb0CL4HJYrh+iGNe6ITf/FxpvM1Y1eKjlnjtIr75dyT+Vz98TFKtD
 5XSe5hgkAcfeIESwL0GlHEz0IaaoNucWiV6ik8jOQJyoT1CwivBwzlUgwcIUYoS0aOlQ
 Q66Ae5cI6d43F2V/zeiyQSF6DFhRk9g1X72VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667577; x=1735272377;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7zJiMkdvSuVwLFby1yzXIyXnY7fTF0nJGOMt7+/G7YQ=;
 b=C3VPz1DThOI1WPzYmb8CwRYP2Hj3yzPhWdV7/bkpq2yDAbiGEMsXC8V2lfcVhY/d1c
 StEXgdG9azNFnNmrM+B8OvxaXMB4FhALIpYv6SYhr+jj4mMDZz7PO3R9BKKG6FCxOwEp
 MBOI0lt5ScrwCYvHKhBtLPXnQnTpBPO5BkhLutYsCQLftgFmzYWpNoIRd3eOn1uZLzlx
 rLwPK6xtqaDQTzg+rSPKciw46NOPxbqvXYUY2JsImvNacMvfZ2QB0bTgTTbDyMHUWGa2
 4FWREwx0SpXuiegmdGkU0SlPB0i5y91WdTAolzu/XYnNGv1H3+MxPySs4xg6jk35qEgC
 7VDQ==
X-Gm-Message-State: AOJu0Yw9Y/oYMThSCJvJcWPuqZ5MJZJxIryITHBbr/X3AK6SUdQTuzFN
 mkAAak3c5dzTTZyP6Twk3QXCEUQRiki8yWspd+CSK5bzlNs2jvzZsyu7CDZiGZD/AdBp52P1Fhw
 kuPYs8BsCP1/1hc8V+AjvtFwGjetAIwQ7whjd
X-Gm-Gg: ASbGncu4laAP96hmM+V6rHnlHS+sB8uMByz3KPwKCcyqD7O0RazLW59Zk7GGAfTdfd+
 uESSyiw+ysJAGlQKesd6BVBUftC0x7dfMLiyeGo4=
X-Google-Smtp-Source: AGHT+IFzMkWN1ee6lVlWxcVirvqAhiYlIwHmOcAd/LoWv3hB3BhYDLGBtLnJas/SLWAtlCj13fraaclxYjzzX7B/Db4=
X-Received: by 2002:a17:906:4fce:b0:aab:73c5:836 with SMTP id
 a640c23a62f3a-aac334c3d70mr93098866b.32.1734667577570; Thu, 19 Dec 2024
 20:06:17 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:16 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTgn++XiSb5FxxdBbyDcjYh287xrc82-h33J1w509vGa=g@mail.gmail.com>
References: <CAFLszTgn++XiSb5FxxdBbyDcjYh287xrc82-h33J1w509vGa=g@mail.gmail.com>
 <20241206023626.2456858-1-sjg@chromium.org>
 <20241206023626.2456858-18-sjg@chromium.org>
 <28dc85eb-6347-4f23-9781-52af035ea758@korsgaard.com>
Date: Fri, 20 Dec 2024 04:06:16 +0000
X-Google-Sender-Auth: a58gDGQNBL0tv5d4-25Lzuhtz94
Message-ID: <CAFLszTgmHQ9UMyuF26B1J-0BgFuLE4iPL9iWAeaX_0kdNvMkqw@mail.gmail.com>
Subject: Re: [PATCH v3 17/46] boot: Support compressed booti images in bootm
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peter Korsgaard <peter@korsgaard.com>
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

Hi Peter,

On Fri, 6 Dec 2024 at 00:52, Peter Korsgaard <peter@korsgaard.com> wrote:
>
> On 12/6/24 03:35, Simon Glass wrote:
> > A compressed booti image relies on the compression-format's header at
> > the start to indicate which compression algorithm is used.
> >
> > We don't support this elsewhere in U-Boot, so assume that a compressed
> > file is always a booti file. Once it is compressed, a check is made to
>
> NIT: DEcompressed.

Thanks, I'll fix that up when applying it.

>
> --
> Bye, Peter Korsgaard
>

Regards,
SImon

Applied to sjg/master, thanks!
