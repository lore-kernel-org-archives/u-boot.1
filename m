Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D22ECA0EF9
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 09:28:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E1988B27;
	Fri, 30 Aug 2024 11:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Re0brEn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D84A88B12; Fri, 30 Aug 2024 11:28:02 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D9888B37
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 11:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7c6b4222fe3so1041017a12.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 02:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725010078; x=1725614878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7RHLax0PHYMXb9DpoxxMijGt4aG1OSt9hS4ZIspB3jA=;
 b=Re0brEn+XAZhAlUD4lpYvctX8v09ykKDakFac3vrOJuH7RIBxjFNt1g3h4gl3UPXIW
 Jan/WH1SUJZzJ8ICoHMKKR7mMOEZZWhu26UT9pL69r7vgdFP6SHapWjfTqFkBuz1T5sn
 nIRaavDO9yVnsy19Wsw678OilpsQfofdICpQsDbAhc7afj49DQAw5FDBeFTXExXccOo6
 cq8WkaAl/wYAAVxTTbRelqxFgdpmBFg4dPeLamDVJfYKq116DsYYeS5DFqduEOoVvuoK
 fFB5cECtnNa0OT+l8mAV7+cQxW8YdbUAnfxP7jE53DwTxoTDhsLxImzKIF7LeKFl2BtT
 uAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725010078; x=1725614878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7RHLax0PHYMXb9DpoxxMijGt4aG1OSt9hS4ZIspB3jA=;
 b=Z7v3R98ytxwCv9pVDRTtteUWKWyCCn1ZXPOUBmMDxkshkHaQZzqEGOa0YdAUyGMpqH
 3vgX9tYMTc9teh1Llo1DM1fu4WuCRsCBe2TQWh2H0oh67UzlUAQpS6VR6llkivfvCJSf
 bByewWka5Ei4KEehe3JBWFOfhfCZLgyI9ew0RQMM60LEXGAR6M2wLuULYG/db8FRQIVg
 /PfvOZoFqXf44gLgT2huY12zCk3fdNwUHy9FWLDsRZ/qirzAK7SYpEOoMtSSE56Jb05L
 oWe0aWdxA9khaRuy6HlxAU63b2/cIhH6p863Zzgpqh13Zp440KattsPJ0kmku5K9Kx2Q
 gQdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJVU8LY78hL3ist9KnlmQfw1MNxsIbpOLYyGObsg/BJCXqvGVpuOAG5BofHLFzP8ZJm8lyoV0=@lists.denx.de
X-Gm-Message-State: AOJu0YwWMU4zmvl3qwwn+QUDdY1S6Vku1MxNK0jXUIpfNJ5VIy19a87A
 dcYnDP9crVByaK+d/TE7MV2JDwOlOv1roovXkl1GZOzmrJMDIGVsno7Mr9LuQUNDMySiYSAUGCU
 /mYLe+A+PYv9zAeh3yDumXWzaIAUCvIBwxmlAag==
X-Google-Smtp-Source: AGHT+IGSRqudqjfBqHno2Ogy115e0dCf2mDZyaKRAUte1VFcT4MbXQfn/xkKlynk3XkSaiSPEfBW3+EbBoezPxhCtoU=
X-Received: by 2002:a05:6a21:9688:b0:1c4:d438:7dd2 with SMTP id
 adf61e73a8af0-1cce1034a3emr5593959637.32.1725010078286; Fri, 30 Aug 2024
 02:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
 <CAFLszThJzVvHSd+dEjTSff2DUPPaQTGWeyCmHmP56Vtjr0WF-g@mail.gmail.com>
 <d2465352-66ea-400c-9216-a92ce5351475@linaro.org>
 <CAFLszThp9Ya-doN39L-uv6C_oZsw454PUiUfOZmYa7wHjoz+oA@mail.gmail.com>
In-Reply-To: <CAFLszThp9Ya-doN39L-uv6C_oZsw454PUiUfOZmYa7wHjoz+oA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Aug 2024 12:27:21 +0300
Message-ID: <CAC_iWjJ1aACnb2u+6+k30ATr6UAwkBQ++2syXy6xR5sSvzq4rQ@mail.gmail.com>
Subject: Re: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default
 except for SANDBOX
To: Simon Glass <sjg@chromium.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de, 
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

Hi Simon,

On Fri, 30 Aug 2024 at 03:59, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Jerome,
>
> On Thu, 29 Aug 2024 at 10:21, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> >
> >
> > On 8/29/24 16:05, Simon Glass wrote:
> > > Hi Jerome,
> > >
> > > On Fri, 23 Aug 2024 at 07:50, Jerome Forissier
> > > <jerome.forissier@linaro.org> wrote:
> > >>
> > >> Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
> > >> NET_LWIP so default to NET in this case.
> > >
> > > Sandbox needs to support NET_LWIP.
> >
> > I agree in principle, but AFAICT it is not a trivial task. Does it have to
> > be done in this series or can it be dealt with later?
>
> Does it build OK with sandbox? We use it for almost all of our feature
> development and testing, so I cannot imagine bringing this in if it
> doesn't work. How did you develop this feature?

sandbox is deeply rooted into the old network stack. It fakes ACK
responses, handles the ping request/replies with the sandbox ethernet
driver etc. I was looking on adding LWIP support for it, but it's not
trivial and I don't want us to add another hacky 'glue layer'. Since
LWIP is a big feature on its own -- and is working on real hardware
and QEMU, we discussed adding it, so people can test and contribute
fixes while we fix sandbox.

>
> >
> > I would need to look into this more closely to give details, but if I
> > remember correctly the sandbox tests expect a precise sequence of network
> > packets. For example when doing a TFTP tests, it expects an ARP packet to
> > go out first, but when lwIP is used the ARP might not go out because the IP
> > may already be in the cache. So the sandbox is definitely not a black box
> > in that respect which makes things a bit more difficult.
>
> The key thing is to have a way to reset the state. So long as you have
> that, you should be able to put networking back to the initial state
> before running a test.

Thanks
/Ilias
>
> Regards,
> Simon
