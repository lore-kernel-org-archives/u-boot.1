Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F02CA0ECD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 01:07:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35E788D35;
	Fri, 30 Aug 2024 03:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HnGF2xAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6916288D33; Fri, 30 Aug 2024 03:06:50 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ECE087FA7
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6bf6beda038so7424986d6.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 18:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724980007; x=1725584807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U5r9hKfgbqqENUbmfdvC8LIh4cbbZwKSeQe4GVqlPqU=;
 b=HnGF2xAGwSgmzIUh1HPOUzyEUrU1vxahdiucO8YL5ca7Sprw12auPDf40AwqzVKRjx
 bzuqLTslfaeuYYIe9sqZhDqxSSe0KdEfx12yZZuP5ek2rNZOShFRvrPKiJ6b2Q2d4r6m
 hK9RaiFd01u9g80Q2FCVq9ovTGY1aOWStPJQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724980007; x=1725584807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U5r9hKfgbqqENUbmfdvC8LIh4cbbZwKSeQe4GVqlPqU=;
 b=O1cpZ7MRfQ4+TgpsXgjgN2QTLu20QNYgHpNIjyfe6DDciIQRpUAu3hyqn0UJ8fEyPz
 uXWxL0TEUhQ9BAkd+HrPeo+LjpkSRkWDu2d36BS56nVNNKytxlsKIe4z0TJ0jaXpVxve
 zjH2QG8uy8l24/w8n8O7DVcvgSuYXf1nM3Zt2+ef52ptqW02Ocx74IBnzK3ogdknNL5y
 vuL5ev8WbyJhzXZcp8VO1A6Q6M7sKoultiS69jmKp5Wg4WwefNrFExvCM8Isx8uzzixd
 SzsYmKFPTBP+cWQTghbBgsEiZ2cIx21Kq113DAXcphLDj6SBgUpVWL4CCUV31W6TmFKj
 NMVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBD/x7vF4IZjJEWcU3A0XXCa33LIlPdVI/wwTXfHYgvlWi45i50MAcUFRfptXLkTtxqz+IoCc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8yAn2RlDBG17bGIspyIpRfMABvez6Fe5GXnWERDv4VmD9f5rg
 qr65HkaJi06N1xFBP6vcXuAK5WQcVD9wvoXXc6CihyjMhhri+nNQuPHFhTKPb4BZckOmGtMc9lx
 IsETFa0yStJTh4P6P7e5ytjS6bqihtcweAikX
X-Google-Smtp-Source: AGHT+IEcARg2owHbVjldcnix1WsIDtz8LA5leKIRvq9aA0VjBSmWNYI4p81A4yM1MzDNu6a2lp98n79oOGch+gpn4U0=
X-Received: by 2002:a05:6214:4906:b0:6c3:3de5:c70a with SMTP id
 6a1803df08f44-6c33e5e830bmr57265496d6.9.1724980007088; Thu, 29 Aug 2024
 18:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-4-sjg@chromium.org>
 <b2a176a0-f3fc-440c-ba59-8bb97fb858dd@linaro.org>
 <CAFLszThcq98op7bcJY=-tW8EtVe6yav43tA0WnoXRiybdjDgaA@mail.gmail.com>
 <20240829164848.GF2479150@bill-the-cat>
In-Reply-To: <20240829164848.GF2479150@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 19:06:36 -0600
Message-ID: <CAFLszTits_BWakK8EZi+XGcYPkh+E3N6ks8c3R5fwh-eD_B8WA@mail.gmail.com>
Subject: Re: [PATCH v5 03/20] test: Pass stderr to stdout
To: Tom Rini <trini@konsulko.com>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Thu, 29 Aug 2024 at 10:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 29, 2024 at 09:01:11AM -0600, Simon Glass wrote:
> > Hi Neil,
> >
> > On Thu, 29 Aug 2024 at 08:22, <neil.armstrong@linaro.org> wrote:
> > >
> > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > Some tests may output things to stderr. Ensure that this output is not
> > > > dropped, by redirecting it to stdout
> > >
> > > Can't you make sure to output all labgrid output to stdout in the hook script instead ?
> >
> > Possibly. Do you mean having the hook script redirect stderr to stdout?
>
> This gets back to one of the points I was making. In this case, "some
> tests" is what? And then, what's even going on? Are we missing output
> that we should be parsing? Are we not catching errors? Or is this just
> related to how today we have for say the filesystem tests so many
> try/except things that we inadvertently need a series of failures?

When Labgrid crashes for some reason, the output is currently lost, so
it is not clear what happened. I suppose Labgrid is not supposed to
crash, but...

As a starting point I have erred on the side of more output rather
than less. I have found that to be very helpful when developing it,
but I am sure we can refine it once it is stable.

Regards,
Simon
