Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC4C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 170478198A;
	Wed, 19 Mar 2025 16:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DKU4C7Pw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E17F18198A; Wed, 19 Mar 2025 16:04:04 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C32880FF0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac3b12e8518so231090366b.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396642; x=1743001442; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f0aBZNFdolKDt20myBkhT+ops/AqVIOdQZBc9Z3fCqk=;
 b=DKU4C7PwoVFGrC7hRzqS0+kMh86+JJjImZwOHjZXGLBvaJqPgZ2RBhAOkKf/L4XSs8
 s9uHEXp1/nLNCNcrXnCrwe1aHl0q8ldUFrIlNAxUnf5Zgvl3LC6b3fs1Im2gkziMAUVo
 M+1E/YzY0hMjjd+HtA24xnt/3QLFGLOue+1gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396642; x=1743001442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0aBZNFdolKDt20myBkhT+ops/AqVIOdQZBc9Z3fCqk=;
 b=ljJTXNsKhsQ5LjpeNj5jgeLktm+G9fGBK1HLBDYqpFZ3ks4cw1eB+8Ml9pTDPJvOMs
 72Xwk/m/aH3xfca3x3f/I7VXoOF1FLFmAVJyNVbdOp980Kul9vJaYca9JUoTPj7vvEd8
 W4C0L28wIEEp7A7Doo8HNRXbTGdL2OhzDwQK7dWz8Gi4/mfye2gD+iNXagdSNjST1RUe
 lSsqtBLiq00eKfv/rfVRmUnvbqXC8C6v6LNRTVbKnbDx1Bta7URHXbQu7xJgZJdSITmO
 WQe/KIX1kbawbKWesCRMnIkZdIfwSiGBQHCM03o9+HWLh5+VSpT6MTjwgh8sd9U9ewPe
 q9AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnIenahUD2ALQaGPHL0fzwKRs27SYH/j2e1lVsOlLkinyMxtRuAOxEGOgOjGWeZF1LmUOlrjg=@lists.denx.de
X-Gm-Message-State: AOJu0YzHmsTO9aIkVtwnzYFNyNGGVTD2kZa/qV3evyDksm7uc8dMglXs
 mG29irmexcW2vDhualgBDdu85fhh2KgK/JTpHtQmMPFZZ6ogLzeI0fgRvwXwl/yq/r+UmDxvtC3
 n3D+1suArX0r9dkuUnsF0+ZD5vcJ1qDWdM0oe
X-Gm-Gg: ASbGncvcXHWu9+pLYp8GPDYxVSElof1iACMol9UAJ2P3nMIwCQJfQrWPDFfhvSAaXHl
 23JpSKhIdJZ2CHcmUWC1Q4yrWh7baKjqaVTN5aJra49WTBboEm6pE/WfqNjv3vKsIEJkKmysUaB
 Qr5dLgy4CU3mc70umqM8EnlzH+HBM=
X-Google-Smtp-Source: AGHT+IGjO0MiIGzRxJZ4llCYXqKaK1b1zpK9VvPzGfditwBgy6CyVKUHuGwyBLeR1WMYQkE8iLdMPYJUyToPQ4Oi7P4=
X-Received: by 2002:a17:907:6ea9:b0:ac3:9587:f2ac with SMTP id
 a640c23a62f3a-ac3b7de18b7mr328758966b.33.1742396641809; Wed, 19 Mar 2025
 08:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
 <20250318155256.GA2640854@bill-the-cat>
In-Reply-To: <20250318155256.GA2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Mar 2025 15:03:49 +0000
X-Gm-Features: AQ5f1Jpdu21jevrKltmqsv19DjzJxlyjh1UWEUc9DNje97H1nnbNwQYYYOL0Rfc
Message-ID: <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Tue, 18 Mar 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> > >
> > > > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > > > bootable partitions for that media. This can mean that extlinux.conf
> > > > files on the root disk are missed.
> > > >
> > > > Put this logic behind a flag and update the documentation.
> > > >
> > > > For now, the flag is enabled, to preserve existing behaviour. Future
> > > > work may provide a command (or some other mechanism) to control this.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Isn't this backwards as the existing behavior (prior to bootstd) was to
> > > scan and use these files, and so that's the behavior we need to preserve
> > > by default.
> >
> > Not so far as I know, but I've already spent too much time trying to
> > decode those scripts.
> >
> > If you look at scan_dev_for_boot_part, that is what I was trying to
> > replicate with bootstd.
>
> The feedback from the community call where this was brought up was that
> it used to work and now didn't, I thought. Heinrich, I think you had one
> of the cases here (something about RISC-V and multiple distros?) or am I
> misremembering?

OK let's see if Heinrich chimes in.

Are there notes for the call? It would help me if they could all be in
a shared document, like we used to use[1].

Regards,
Simon

[1] https://docs.google.com/document/d/1YBOMsbM19uSFyoJWnt7-PsOLBaevzQUgV-hiR88a5-o/edit?tab=t.0#heading=h.byz50ta07iok
