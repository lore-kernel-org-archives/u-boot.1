Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA5BC3DA64
	for <u-boot@archiver.kernel.org>; Sun, 28 Jul 2024 19:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5916C887CD;
	Sun, 28 Jul 2024 21:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h0DbhGk7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B58587F7D; Sun, 28 Jul 2024 21:36:25 +0200 (CEST)
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com
 [IPv6:2607:f8b0:4864:20::a2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1DA88730
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 21:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-4f50c673e83so857042e0c.0
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722195381; x=1722800181; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7H71EG4//THjNSRe3Izd3g2A9tanXOSO8tpSS1UpkfU=;
 b=h0DbhGk7ff6w8CwOHnYczVOgg8qWIz1trP7OkjLYQCRAR+CJSqBOK9GcoxYtS+kw3p
 PCQgVW6zacF7nL5Wnv0VYI1a5MTO1OwuxTCMufvZTwjgUzAdWU1kSl70Pnp29O8Ek0sS
 kBPNeFC551cprnz8Mq5Qyg5SOfeVB62gjrokA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722195381; x=1722800181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7H71EG4//THjNSRe3Izd3g2A9tanXOSO8tpSS1UpkfU=;
 b=UBVT3u4HQcQ0Cs8ZTbPIol0DcPQ1/vEQZ8ATSHuU2lCyZ31AZ/HJpY8hmdslvBhziP
 K7r1cB0akYMs3SMHiysJMCuVZOA4u6ExI8RK8Y53Ntx9QJSm7I8GT8jsXYfAwOL8vaDh
 /NIhYh3Wh1hT+5/0HoUyqGeBmL9Ps7ukZCQPfNfcggtChkflJkfV1rxQJ1UTrpvljEi9
 Q2+/jcZwQjkvTcZEMrjKPi93coG8/X/zUhoDlXJb8ETFDiOTPNH+SbQenj43fml6W8DJ
 g6hH+ZTeORKxHMxnYcBgmhXQpL4qhgOo7S4IQYELVM5nHxOOmG7HKKj8kuxjrS3iLfVo
 BHOg==
X-Gm-Message-State: AOJu0YyGXa58DSPjwmEQipgSMigymDHDufl5I/FsZPUh31ADlqwv2mV/
 0smJjqSCG+oA9VG9KKMcnGQoFMIYRKlyAKs5up9OjRtWIJOm6uTiJsO92Iri36jKmTwCsvUTPiP
 xbirjT7Jvnxl72LSzsr7CS4ZrQdgqmoOVCf3F
X-Google-Smtp-Source: AGHT+IGPGI7wO6WHyQpftlIUPnmrUGXNLfEePLi91vBlAnxkdKYFKjY9+pOD+Sd0uLSIki1e2GgbwTgMEQeK1rAWtgM=
X-Received: by 2002:a05:6122:2901:b0:4f5:261a:bdae with SMTP id
 71dfb90a1353d-4f6e69989dbmr6012700e0c.14.1722195381166; Sun, 28 Jul 2024
 12:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
 <c2853d56-4bdc-4d1b-81d8-c880aa298988@app.fastmail.com>
In-Reply-To: <c2853d56-4bdc-4d1b-81d8-c880aa298988@app.fastmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 28 Jul 2024 13:36:10 -0600
Message-ID: <CAFLszTj8eBf_ffT-kXNXRFRsBcPtLvUN9WHe+5U1xW39wo=fag@mail.gmail.com>
Subject: Re: [PATCH 0/6] video: pixel format handling fixes and improvements
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Wed, 17 Jul 2024 at 08:34, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=
=E5=8D=886:16=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> > Hi all,
> >
> > This series fixes endian related problem I found in general
> > video system when testing my fresh virtio-gpu driver on big
> > endian target.
> >
> > It also removed a lot of duplicated code on pixel handling,
> > and make implementation of new pixel formats easier. Further
> > more, it removed limitation on bpc for BMP display, now we
> > can display any image depth on any target display controller.
>
> Ping

I believe this is waiting on Anatolij?

Regards,
Simon
