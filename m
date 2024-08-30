Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130BECA0ECD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 00:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C7688D2E;
	Fri, 30 Aug 2024 02:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GpEYHNzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE19D88D2D; Fri, 30 Aug 2024 02:59:25 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FF6388D30
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf6beda0c0so7409656d6.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724979561; x=1725584361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C689Wl4h/TtO4g5j7A/Yzep1Broqg6W4pKiJ9AFRtjI=;
 b=GpEYHNztPXhAPAeXqdiihVpq17mzD5xzAJyAL43MYmURZ36XTxICSLCyH4adun5uWf
 7Ibbfh3iRxzoUStBbN2sByAAt5D8gpaoC8IpMcNLqKsCCRtpKpWB2AqQDfb0tdi3ESLp
 9EB5sSDCTcO3OtqCL+fLMn5XHZQTBDp/ohQuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724979561; x=1725584361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C689Wl4h/TtO4g5j7A/Yzep1Broqg6W4pKiJ9AFRtjI=;
 b=KnksH1lgNd4v7JuvYn0WlemKnm8yl2JVqTGMBJGtK2uYtR8rEk7AZGYr+aj3o2fUqH
 ZqUIrHpug7eVz4JYdyCyEIecQQd71Frpq0RKYHXS0UhoNg5Pfa02u42ifEZufoY0j8kg
 EvBVxdaiBKUbpIvUl48R1KxnLZqfQQVp7YcvqLIOj8DHfD0XSP9QXprR26Edpnl+FoQv
 AYOT7wxb9gHyPqJzdrdTl8LHEF7f/nU/9Z+1SYwir9sDSY5zd6eiz2IcQ8L6Un6EqeVC
 Ofm+85tv0iRo9T6CzW2VSLHGefgcW0TuTSaxMPistlkoekghnXNVk3okbXQOFb/GfqSF
 aAVA==
X-Gm-Message-State: AOJu0YzK4earQehIqaLKnrByVXwwkIkdgzkPb4xL8R2D4neDJ5G/mZq6
 RCnngcBpigPYm/F8gDzZ3lbD5GFNdD7sDegYB5E6hfd3xq2CYSK8DVbcYoU7RfJhVMqBC9f7vnT
 vmeBTaVXpzTqfnUxUbZMcAHiiP2A/tMAqSHLQ
X-Google-Smtp-Source: AGHT+IHeyJGBKUEEh/CCP4RLp1xKwpKb3DXL+oDQxcuCxwhe2T29py0VxcmXwMs40uaa1qQy6iDcW/GclqjUIb40z/s=
X-Received: by 2002:a05:6214:3a8a:b0:6bf:940d:286f with SMTP id
 6a1803df08f44-6c33e6a7ec4mr61302096d6.50.1724979560917; Thu, 29 Aug 2024
 17:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
 <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
In-Reply-To: <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 18:59:10 -0600
Message-ID: <CAFLszThp9Ya-doN39L-uv6C_oZsw454PUiUfOZmYa7wHjoz+oA@mail.gmail.com>
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anton Antonov <Anton.Antonov@arm.com>, Tom Rini <trini@konsulko.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
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

Hi Jerome,

On Thu, 29 Aug 2024 at 10:21, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 8/29/24 16:05, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
> >> NET_LWIP so default to NET in this case.
> >
> > Sandbox needs to support NET_LWIP.
>
> I agree in principle, but AFAICT it is not a trivial task. Does it have to
> be done in this series or can it be dealt with later?

Does it build OK with sandbox? We use it for almost all of our feature
development and testing, so I cannot imagine bringing this in if it
doesn't work. How did you develop this feature?

>
> I would need to look into this more closely to give details, but if I
> remember correctly the sandbox tests expect a precise sequence of network
> packets. For example when doing a TFTP tests, it expects an ARP packet to
> go out first, but when lwIP is used the ARP might not go out because the IP
> may already be in the cache. So the sandbox is definitely not a black box
> in that respect which makes things a bit more difficult.

The key thing is to have a way to reset the state. So long as you have
that, you should be able to put networking back to the initial state
before running a test.

Regards,
Simon
