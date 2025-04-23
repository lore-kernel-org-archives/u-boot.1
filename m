Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C166AC369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 12:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B825809D4;
	Wed, 23 Apr 2025 14:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MIx+U5IY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E16C480FA8; Wed, 23 Apr 2025 14:28:37 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF9F80050
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 14:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so754612666b.3
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745411315; x=1746016115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YgxYvHWr1zFQMc17l25rzAUVIu4zw8WFznjzKLvzZe8=;
 b=MIx+U5IYdE8jM9wgDEQ9/KyTpb6cOxpMmZhGsw7VUVBXXQCH4vSiYewBYBQ+YQKSi1
 HG+ahkyiudC2C88LoiyTpKW523jCOlKtYIDJjxX/MzY0PDX5UO5db4WB/SuLRh6OoJol
 C4zmAMbpnsz8EbbG2bHD4nN8LuymyC53tXxQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745411315; x=1746016115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YgxYvHWr1zFQMc17l25rzAUVIu4zw8WFznjzKLvzZe8=;
 b=PH1HwsbHq3TADwQ7lHJtG+6MoURaX/PyCCddrx7t339q0/Evxf0gn/g+MSNtPA/ewt
 AREs8DyPS4yvtyA2+0OkrEcTSpQQRb36YJ7TdF4to/pI+0M8fzgV1uvIFTeBqzhuW3WR
 8uAa0MZ5bNCEIJKpyEhZa9jWR0qrNNGgmyAR34lbsCdB9ZmFypeJOfaj1HAi+QyyPgGE
 LtVVO6jrh2wo+uWokXJBsouq81a2ojdhQtfcnw43BJjQ1nIA7xeRMInuqTu6NeA3myfZ
 fW5y7CJJh8TFdElphr5FKm+RLKqw8MCto6APbIQtGFjaavp83yG9/g4k6DUMBxZWUTAc
 RQZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnMusBW0qcIS/aBEaD9fMuVYpjS8W9nIb+HCsSTBm7GKvZXzbcNk1wBAnOwMMP6hr3sXim/i0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh49IijkHTG2KYIXkSQIjH3X0cx/x5lakFI1J5ZbyiHAUais1s
 xcvmq3rx50/ZtPOlgCDRh0Fl2UNYRmNVgz4B/3bd8jxJ6rLsBrWr4Q6h18fjziUbs8ifJOu3ytJ
 msKoPF9krAjeHOKUlaglfvxOTXlwSdRmpSNm3k32nX4MI+qs=
X-Gm-Gg: ASbGncuQnP47bi4+bAxZ/i+a0iMPJkXtKwFrVs95xfuwibembEpycX2IbJyQGwNtgZ8
 4FP3adYW9K3a9csK2LRQSj2oeSB4bYCiuKh+8C/w/iD21wGjc2IeJ17bxABqNsf1FbmSQZuSxMJ
 5RrJVxP88xw7W2HT/EQPVqNlE=
X-Google-Smtp-Source: AGHT+IGPWLuBYZAJ9ggoik2F8f1YsNHFNasplMo4kWfmDo1n7Qf6wk2IxmcJCKiHPs+D1ACGhfjICjf3qIUkBn0PDgY=
X-Received: by 2002:a17:907:1b1f:b0:ac1:f19a:c0a0 with SMTP id
 a640c23a62f3a-acb74b1ca7cmr1789569166b.20.1745411314957; Wed, 23 Apr 2025
 05:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250327080642.2269856-1-m-shah@ti.com>
 <20250327080642.2269856-2-m-shah@ti.com>
 <CAFLszTjB+HuX68tmTrLP=gbbpzt0kJr22137cSLiedx6bh6PVw@mail.gmail.com>
 <3d2c894b-11f1-462c-b9f5-8d3f45dc0b61@ti.com>
 <CAFLszThs5W+=tFpUsCE0Qi5mvuymtsHF57jeLpV9KUQfGXBXnA@mail.gmail.com>
 <3287617e-3b6a-4387-90d4-7bbfc810f9c7@ti.com>
 <ec117e91-7b13-4ca9-8509-3075d7071427@ti.com>
 <CAFLszTjD+Aofu8jLMyX4FPxatmt_SaRC8amf7rziNmNKECFrGQ@mail.gmail.com>
 <f39453a5-fdaa-4fab-8230-0d8ddcacb040@ti.com>
 <cecd2c70-92bf-4e7f-a3b5-b4fde4635044@ti.com>
 <b11e0c13-d7a3-42db-820b-a89e415588a9@ti.com>
In-Reply-To: <b11e0c13-d7a3-42db-820b-a89e415588a9@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Apr 2025 06:28:21 -0600
X-Gm-Features: ATxdqUEl7e9Lm6wcZ0smjUUiT6q9JtI4CxwkJjNxZfmcO0xLyh25P5K_5dCX6lY
Message-ID: <CAFLszTjSb1jGH-w7=QSFYZSJx=nyWkj=hQFaEoBdaXxt3dCSdg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2 v2] tools: binman: control.py: Propagate bootph-*
 properties to supernodes
To: Moteen Shah <m-shah@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, u-boot@lists.denx.de, trini@konsulko.com, 
 alpernebiyasak@gmail.com, quentin.schulz@cherry.de, m-chawdhry@ti.com, 
 n-francis@ti.com, vigneshr@ti.com, a-chavda@ti.com
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

Hi Moteen,

On Wed, 16 Apr 2025 at 03:16, Moteen Shah <m-shah@ti.com> wrote:
>
> Hey Udit,
>
> The public documentation[0] has the required information which is
> sufficient. The build instructions mentioned below are a subset of the
> information present in [0] which should be faster in recreating the issue.
>
> [0] https://docs.u-boot.org/en/latest/board/ti/j7200_evm.html
>
> Regards,
> Moteen
>
> On 16/04/25 13:47, Kumar, Udit wrote:
> > Hello Moteen
> >
> > On 4/16/2025 1:23 PM, Moteen Shah wrote:
> >> Hey Simon,
> >>
> >> I missed some essential build instructions I should have given to
> >> you, apologies.
> >
> > I assume our u-boot public document should capture this information,
> >
> > It not, then please fix
> >
> >
> >>
> >> 1. Clone ti-linux-firmware:
> >> https://git.ti.com/git/processor-firmware/ti-linux-firmware.git and
> >> switch to ti-linux-firmware-next branch
> >> 2. Clone U-Boot: https://github.com/Jamm02/U-Boot-patchwork
> >> 3. Set variables :
> >>         $ export CC64=aarch64-linux-gnu-
> >>         $ export LNX_FW_PATH=path/to/ti-linux-firmware
> >>         $ export UBOOT_CFG_CORTEXA=j7200_evm_a72_defconfig
> >>
> >> 4. Inside U-Boot source:
> >>         $ touch bl31.bin
> >>         $ touch tee-raw.bin
> >>         $ make $UBOOT_CFG_CORTEXA
> >>         $ make CROSS_COMPILE=$CC64 BINMAN_INDIRS=$LNX_FW_PATH \
> >>                      BL31=bl31.bin \
> >>                      TEE=tee-raw.bin
> >>
> >> Let me know if this works.

Thanks for the info. Yes I was able to repeat this.

But the problem seems to be that your tree is broken. When I try your
patches against -master things seem to work OK.

In your tree, even before your changes, 'binman test' fails. That is
an indication that something is broken, so there isn't really any
point in trying to add a new feature to that tree.

Anyway, apart from that and the changing of the u-boot.dtb file, your
implementation seems fine. I'll send a series with some suggestions to
incorporate.

> >>
> >> Regards,
> >> Moteen
> >>
> >> On 15/04/25 00:18, Simon Glass wrote:
> >>> Hi Moteen,
> >>>
> >>> On Thu, 10 Apr 2025 at 05:39, Moteen Shah <m-shah@ti.com> wrote:
> >>>> Hey Simon,
> >>>>
> >>>> Is the problem discussed in the thread an actual bug or am I missing
> >>>> something in the implementation?
> >>>>
> >>>> Regards,
> >>>> Moteen
> >>>>
> >>>> On 03/04/25 11:51, Moteen Shah wrote:
> >>>>> Hey Simon,
> >>>>>
> >>>>> On 03/04/25 00:52, Simon Glass wrote:
> >>>>>> Hi Moteen,
> >>>>>>
> >>>>>> On Wed, 2 Apr 2025 at 22:01, Moteen Shah <m-shah@ti.com> wrote:
> >>>>>>> Hey Simon,
> >>>>>>>
> >>>>>>> On 29/03/25 05:17, Simon Glass wrote:
> >>>>>>>> Hi Moteen,
> >>>>>>>>
> >>>>>>>> On Thu, 27 Mar 2025 at 08:06, Moteen Shah <m-shah@ti.com> wrote:
> >>>>>>>>> Add a function to scan through all the nodes in the device-tree
> >>>>>>>>> recusively for bootph-* property. If found, propagate it to all
> >>>>>>>>> of its parent nodes up the hierarchy.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
> >>>>>>>>> ---
> >>>>>>>>> [..]

Regards,
Simon
