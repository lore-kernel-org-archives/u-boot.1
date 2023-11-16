Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6435FC072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:40:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B62D87467;
	Thu, 16 Nov 2023 02:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B5CbHyw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E10787448; Thu, 16 Nov 2023 02:39:55 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B72A8743F
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-db057de2b77so241653276.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700098763; x=1700703563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yDpT4YrF1+A8763Zxtgj0FlQAaIK75pHap0cFCBa6UU=;
 b=B5CbHyw25pQIf33NEt8ioz8NTYE8jgt10uSNOFvIGtVXphI78wt/onig0n6fvl7LgU
 a+7GW+TxUVDdURV/iZKKGxWSQ0d488j3fPUVBGoi5ggam59ArU3bqo8+eC/QNTJgZcvt
 RVxS6ybFQ2Dz5I4HtJRSLejXT+0naRKtW+7n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700098763; x=1700703563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDpT4YrF1+A8763Zxtgj0FlQAaIK75pHap0cFCBa6UU=;
 b=NHW2qYQZQo5dLRBcg42KUdgXpDAHKgYsBn3bKnvDinlal2Gnw3wN5c7pAG35BPq7xG
 Eh8LFwyEuyqFpZYgd5D8aJQprKB57etlIE4HkWmFPnonBNKZ5YsEUtIwgpIIFjEfllf5
 EbFRmqxhmQtQCn+0EcqwK7fgvgyBwwYEmPEKYRQuApuWsSDXg1ZSduVJjuOk/EIhyaeV
 PfUQoT257f7rxCYNkhJZiAdq6ggzUrdPjay71aL69k9P+0vWP9Tt0qpJL9AQ4ZDKnv7S
 wdpXPYsJpg7+np2GBEpT+0Z9bUtvw+0vNULB3upM8qwhjqdIbeatRuIq8EzlomwKbgmK
 VPBA==
X-Gm-Message-State: AOJu0YwrNXAtrJ535RTQ3TNW9+nuYsGr7chUccMi7JpOKjgaMSnjrdaU
 p3PscjUgEjSUuQmvZaPepu53zmW1Y/qutJKDv+uHKg==
X-Google-Smtp-Source: AGHT+IGEm2AoT10um+1pCkgXiY8AIPCyFhNYgcNBISwuqazKc/TRDs9QGJPx7jhY+XXdXPJKn/62TL8Zw0AHQsFdeHY=
X-Received: by 2002:a25:3792:0:b0:da3:743d:ea3e with SMTP id
 e140-20020a253792000000b00da3743dea3emr14325876yba.21.1700098762963; Wed, 15
 Nov 2023 17:39:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2hrverfcsEEahUcRkcjrnF3jr0oyds2yo0RBVMB7E01g@mail.gmail.com>
 <CAPnjgZ1-_ohZaVwMGtTDt4-W--2q0AM2KPtX9RLgAbMEhMRugw@mail.gmail.com>
 <CAHc5_t1icj6d82GH+FK8qGg3MvDkpwEicH964ULcN971_=aSKg@mail.gmail.com>
 <CAHc5_t2vLU9gHufMS_Fjv6j5+E8ksgCCLzKQ7NxTHzJsdcmsNQ@mail.gmail.com>
 <CAPnjgZ3VY_M+zd2na+N9WCxj-L2F+KKhLgykQ21FTA7GPVrKNQ@mail.gmail.com>
 <CAHc5_t1fBzzpJaQed9kcKF92ProStsutmOBW-1jmi5vWFvLM8g@mail.gmail.com>
 <CAPnjgZ3WNmnNv7DjMFDM9Med3yRng32N6tku4NGxbwA5DRhQgA@mail.gmail.com>
 <CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com>
 <CAPnjgZ3V65sCuRV_NzJFZHL7-ZHq9SQUTxvvbj5GszFAhJ4WzA@mail.gmail.com>
 <CAC53B67-9BC2-4EB4-9846-F78166140BD0@gmx.de>
 <59b43a5a-6fff-4185-a545-7ddd14ac3af9@gmx.de>
In-Reply-To: <59b43a5a-6fff-4185-a545-7ddd14ac3af9@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 18:39:07 -0700
Message-ID: <CAPnjgZ0=Vu6UBbTX9-Nn9d9S=vVRGocqvbe4wbuqWjgVBzPLKQ@mail.gmail.com>
Subject: Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Shantur Rathore <i@shantur.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, 15 Nov 2023 at 18:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/15/23 23:46, Heinrich Schuchardt wrote:
> >
> >
> > Am 15. November 2023 23:15:46 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >> Hi Shantur,
> >>
> >> On Wed, 15 Nov 2023 at 15:13, Shantur Rathore <i@shantur.com> wrote:
> >>>
> >>> Hi Simon,
> >>>
> >>> I have figured out the cause of the crash.
> >>> It happens here -
> >>> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
> >>> while doing - free(bflow->buf)
>
> Unfortunately the description of the field bflow->buf is deceptively wrong:
>
>   @buf: Bootflow file contents (allocated)
>
> The EFI bootflow never allocates this buffer but uses the address
> $kernel_addr_r without allocation.
>
> We must not call free on an address that we never allocated via malloc().
>
> Doesn't this also explain the error you experienced before writing
>
> [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
> https://lore.kernel.org/u-boot/CAHc5_t3v23k_Xbws5o-g9iQfoQ7fhpKScf89XDaaAgo+bu8tbQ@mail.gmail.com/T/#m992e20fb25fe0f2f0047e901a76e78628e59da7a

Yes that is indeed the bug report from Shantur. I just sent a patch.

I still would like the USB patch to go in though, as it is wrong to
unbind devices before boot. We have a special device_remove() flag for
handling this and it should be used with all devices, including USB.

[..]

Regards,
Simon
