Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1AEEE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A610864EC;
	Tue, 22 Aug 2023 20:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pt6cpjfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49DA686400; Tue, 22 Aug 2023 20:58:04 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A075864E3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:58:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-d77b9d574f8so117336276.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vQx9r7o4DXQSziV81FEGIcyIR8+OHiHBaTNUWswvqso=;
 b=pt6cpjfEKVZNQjSYTc9a+fVOblMIM35l0lAZubzbf3Hgq1ay8QJYxqkP75E+5seu/d
 xULIobLoayu4pVGCEhktZMOtHayWfSOwN696FAVa0e4R+wiEPcKzQ9M/6C8LJbeTU33i
 MRr2g9NIEuQTsFl7Cc7XPKFqfQU6jmiztFPhLlpYjRk/RGLfLsZGqn8iEjD8qCYXFBAg
 1Are58T4uSYSQdnqLFtmIn9dh5MfmUrIqDuWyIQsA1SgaLmGBvaImaDmq+67ENsBt/Og
 I33Ph9yjlKosl34ei61KdxD/7uZfZpY5ovrr4SdYcBhG3U/5TaFyaYzxLUenDEQcrBzx
 k0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692730679; x=1693335479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vQx9r7o4DXQSziV81FEGIcyIR8+OHiHBaTNUWswvqso=;
 b=PK/NRiMFX1rTyn6VI5bvroAssJOHrxask3ucg8aq+UMRrZe31gNEwBLVJ81fwQjarH
 hIxJbqrWHGigldTLIm5DJ2//jfSTPfeuXnwsOcxsKL5RVOMCowqfwn6+cM5kH+bPmaAs
 LRVlOv1JQGgV7S3AXkVBt9huxEYlXBqbs6SnGTBISSNj0GliIdPOltuN/HYEmdlL4+/b
 3Shmhv7o1DxSnzTcQNZt9Amzrx6o5jFrx073OYB/hHpmkAUJSB4r1R1jFQ1uWOKo5QPi
 v+YkkVXA+q8SQQpKM8LW22mG+0iM6dC/dx/BmujG+X6y5I0UkSac3l5KSuT5TmR0A6Ww
 e+Vg==
X-Gm-Message-State: AOJu0Ywdas+Q1/O2kpw48glfFLFo200KGDcsRNC1CsoWFOKkHNAbEbNK
 OAgbkQnJytKI7PYaQ9JK4ZLSl2sZOLvKDJRvb2ttpg==
X-Google-Smtp-Source: AGHT+IFmpPIDXiG3ceB9Hf9gEwhZ/PLkFq+bgvGO6bWozzpCqgA8hdL7Az4QFzRBkZW+zHpdC8N8uSJdOIMobPC0Gp8=
X-Received: by 2002:a25:8c0f:0:b0:d3b:24b:561e with SMTP id
 k15-20020a258c0f000000b00d3b024b561emr9648841ybl.42.1692730678881; Tue, 22
 Aug 2023 11:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ3Wfnc_rMJBVZTv_eikUu7vpPWsL1MQ_SruXySV9EZi3A@mail.gmail.com>
 <20230710083443.fuw74gbvwoha75ab@cab-wsm-0029881>
 <CAPnjgZ1aZsFBaX2eBh35CXVExaE90YJHQ98S+2XOWJrJ9pz37w@mail.gmail.com>
 <20230711102459.phpyem2ehlya7osz@cab-wsm-0029881.sigma.sbrf.ru>
 <CAPnjgZ2t2xf05PSgCbQr7MUvJrpQPcRs_Zoux804h4UmTrZRKw@mail.gmail.com>
 <ZLDdaIyXjp9yN5aW@laputa>
 <CAPnjgZ3oQ1qZtWFpezNfV-dZhbCrnqbi1+B=JKb1sfJP6xk-cA@mail.gmail.com>
 <6303961e-3edc-4356-905b-89820a52b227@linaro.org>
 <CAPnjgZ2GA7ktNi9HVJ1Mw=4nuqcQJALVBqHQr1_JtVmkzEVgdw@mail.gmail.com>
 <7a9f5cf0-d7b2-4477-8a56-a3aa7f764e2a@linaro.org>
 <20230822125932.jvem4lsr7crnybmi@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20230822125932.jvem4lsr7crnybmi@cab-wsm-0029881.sigma.sbrf.ru>
From: Simon Glass <sjg@google.com>
Date: Tue, 22 Aug 2023 12:56:32 -0600
Message-ID: <CAPnjgZ0Zp8Ww9seOkPasaMFVP2PvpKM1mD5oFycDmFjO=eFj3Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drivers: firmware: introduce Meson Secure Monitor
 driver
To: Alexey Romanov <avromanov@salutedevices.com>
Cc: "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 "narmstrong@baylibre.com" <narmstrong@baylibre.com>, 
 "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 kernel <kernel@sberdevices.ru>
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

Hi Alexey,

On Tue, 22 Aug 2023 at 06:59, Alexey Romanov
<avromanov@salutedevices.com> wrote:
>
> Hi,
>
> On Tue, Aug 22, 2023 at 10:24:23AM +0200, neil.armstrong@linaro.org wrote:
> > On 21/08/2023 21:11, Simon Glass wrote:
> > > Hi Neil,
> > >
> > > On Mon, 21 Aug 2023 at 03:16, neil.armstrong@linaro.org
> > > <neil.armstrong@linaro.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 16/07/2023 01:40, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, 13 Jul 2023 at 23:30, AKASHI Takahiro
> > > > > <takahiro.akashi@linaro.org> wrote:
> > > > > >
> > > > > > On Tue, Jul 11, 2023 at 01:13:29PM -0600, Simon Glass wrote:
> > > > > > > +AKASHI Takahiro
> > > > > >
> > > > > > Me?
> > > > >
> > > > > Yes, I'm asking for your help to try to clean this stuff up.
> > > >
> > > > The thread is long and hard to answer directly, but as AKASHI
> > > > said there's no point to add a SMC class since it's only the message
> > > > passing instruction, and there's no point using remoteproc since the
> > > > firmware runs on a separate secure state of the same CPU.
> > > >
> > > > And I don't see how we can actually define a finite set of ops because
> > > > none of the secure firmware interfaces has even similar functions.
> > > >
> > > > So a new UCLASS for each firmware interface should be added, not sure
> > > > this is scalable or required since those firmwares are mainly SoC or
> > > > vendor specific, except the PSCI or other ARM specific interfaces of course.
> > > >
> > > > So I think UCLASS_FIRMWARE is good enough since it avoids using UCLASS_MISC,
> > > > but it should be probably documented somewhere that the ops are implementation
> > > > defined.
> > >
> > > Yes it needs docs...but what exactly is the 'firmware' uclass? I
> > > assumed it was for loading firmware into a device, but it seems that
> > > it is something else?
> >
> > Nop, it's based on the same "firmware" naming as Linux, which is an interface
> > with a system control firmware like PSCI, SCPI... not to interact with loadable
> > co-processors.
> >
> > Systems do have multiple interfaces implemented like PSCI, SCPI, OPTEE and other
> > vendor specific ones like Alexey is changing, all via the same instruction call.
> >
> > >
> > > Perhaps we should have a UCLASS_SVC (supervisor call) or something
> > > like that, rather than continuing with firmware?
>
> You propose to create UCLASS with an interface consisting of functions
> of something like: ->smc_call(), ->hvc_call()? In this case, it seems
> ARM specific.

Yes, but we have a lot of arch-specific interfaces.

>
> Or UCLASS with only one callback, different for different archs, which
> will call the hypervisor or something like that. In my understanding,
> this add-on are redundant.

OK.

>
> I still think UCLASS firmware is the best fit for my Secure Monitor
> implementation at the moment.

How about you create a UCLASS_MESON_SM then?

I don't really like the idea of a uclass with no standard API. One
goal is to help people understand things and can't see that helping.

>
> >
> > I have no opinion on that, I don't think the call type is significant here.
> >
> > Neil
> >
> > >
> > > [..]
> > >
> > > Regards,
> > > Simon
> >
>
> --
> Thank you,
> Alexey

Regards,
Simon
