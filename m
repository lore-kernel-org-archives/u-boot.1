Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A47C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE65481E6C;
	Tue,  1 Apr 2025 19:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bzrCgAoD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C90081E6C; Tue,  1 Apr 2025 19:55:31 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B85381F28
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so976941666b.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743530128; x=1744134928; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zq18UYnUePpP6LBKLHQOkOfkIonjrWB3/3WJRNXUczM=;
 b=bzrCgAoDA2yLt9UeS6DBoWAY6SnjK0mA/xsTkOFwKKJlG80paT25tfq/qfjCaiFxqc
 7BUJKam4Puhb7pfsdDD0O+wDLFQ1KC4DjpRMqdBTr5EJeXapjpqkU5V5xTc2NNy3tSUe
 noTLA/UARYjD3s61NHDU+kFffS/9LH9ueRRjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743530128; x=1744134928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zq18UYnUePpP6LBKLHQOkOfkIonjrWB3/3WJRNXUczM=;
 b=o87t7OxJ34C0G1VAdkWn60o+BDIDCMvKAANrxMkeSOvFfMWjQDNmWEwzi5AyuvpuUH
 CrFN5cLuVJ6JhdKs1XkgSlt2vaWTN68caJs3egXVNz947M/ZyX7vq2zUGX4d/PSNkQdv
 DU4f88zRhliBeWi4VazA+jMtEJprWMQuFoioOdP590nzhd9hv59gLt1j4k/OtEOFvkXX
 Qn2Gkhkh2ZU3r4TJ9y5YdCIqLqlWZvV7nLjZov+lE0iZCACGS+Jx8J8wBjZx2yvvisIH
 ZW1QjNiAhrof35/9qAiOQKAazljvUKrRDJO0aD9FPQQWv5udx80NL/bTDuh8atsuNxnz
 TtrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQMyWcqnAVQCtfb8PeDlSd89Mw+cj/fTM5dLjzPMO4iLHzvE9ixy//k0LP+kel9PsYDU151W0=@lists.denx.de
X-Gm-Message-State: AOJu0YxjHJlbnZenMg1ZNYag6Y1wQQcg/or4ylxqv+MtDvYfa0Z1i0Js
 qey7LlW519Xu8GsA+Goo4wzCsc6e+mUCvAHAuEx/2NC4zpGU1VwN6wwdv6wy0AGsffPwPjSIffO
 GtKYoy17AUGI/fm91bQLuHW3VyCeo29kN52fc
X-Gm-Gg: ASbGncuATn5nsahEwXoxQtJ8QL1KfAxeIEQhZTJcXARVvx0btZS6n3KyM8PypnZeZO/
 dqwXBr/nC4N40pfxVwdRiLhsuZVfoQxfJUsCrAAKZvyVGCpBehCwEUvV3AlE0E3+Pb8fDhKSpCt
 Mhm13bwfxeYpda0WI1DJPmi6rGUlyk
X-Google-Smtp-Source: AGHT+IFLThxttMwJl8FaCdFl5/w9v0ZUW2i4I7Ou5Qwi0wJ0Xibk6akRsbh8P6RXM0aC4ALSETrQc8I/ngRhut83Gmo=
X-Received: by 2002:a17:906:26c3:b0:ac7:75b0:67d9 with SMTP id
 a640c23a62f3a-ac775b0682dmr598216566b.4.1743530128544; Tue, 01 Apr 2025
 10:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
 <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
 <CAFLszThN_0aRhtTRmEGmjyiekz1XtzZdH1qq0oLSyYcO5yKobA@mail.gmail.com>
 <CAC_iWjLHPLeX2DhnVqS3QtjhyPVd-Hkuqr0vF_dCXmBQApwvng@mail.gmail.com>
In-Reply-To: <CAC_iWjLHPLeX2DhnVqS3QtjhyPVd-Hkuqr0vF_dCXmBQApwvng@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 06:55:16 +1300
X-Gm-Features: AQ5f1JpTKpaIJgvYwihyNDIoi_kXaj34mc6k-t8C-vgP_1EH7tUYTLRw_8i3aKw
Message-ID: <CAFLszThH3a7pLJG+zppu2qr5RwXAOk9Sj+S+RAT0B758hzOsyQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] lwIP sandbox tests
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Ilias,

On Wed, 2 Apr 2025 at 05:33, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon
>
> On Tue, 1 Apr 2025 at 18:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Jerome,
> >
> > On Tue, 1 Apr 2025 at 03:14, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > Any feedback on this series?
> > >
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=448553
> >
> > No, not from me, but thanks for doing it!
>
> Aren't you maintaining the sandbox drivers?

Yes, I'm listed as maintainer for lots of things. What sort of
feedback are you looking for?

Regards.

Simon
