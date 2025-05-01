Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC08AC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 15:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1C4809A5;
	Thu,  1 May 2025 17:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dgd6+9AZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9777F80F03; Thu,  1 May 2025 17:03:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EFBF8081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 17:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so145099866b.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 08:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746111807; x=1746716607; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fa5ulnkplkMBjTmID98zJwDMt6zvRDJCLR/aWR7i/kY=;
 b=Dgd6+9AZUhVB8V/3heTkdmxfrJ56VRq5gUR5ARHaZ8AUVCV2J4CufQOLmuch7LVOg3
 xof1C8N4z51hSkTj35H/KArUjJQ5r7r21hdX7lt+WlUkyHoGY1/I81tA2FyMrHhOG+In
 Hj+85qmMS3A4hL7DVz7oJLs59AeDAgZsRRQ48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111807; x=1746716607;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fa5ulnkplkMBjTmID98zJwDMt6zvRDJCLR/aWR7i/kY=;
 b=cLNxzrYTXaD/p6KJJKzgaNFNvVC7rul24WJGXb88SwkJrrS5aVu53QPN2rCW+uzW3e
 eQE6bVM9yMTI5QMt243P3TgDhdqHaa2bBdRgKbwFVvYzpdJvm6FS55neXJ1lid2qAvZ4
 5e/3jnV+aSJKL+XSVVNsypZXe4QCqklGu7n9i/FELDogum0l0yNe724GwcUvCukfcsjU
 Z+eCU/g1HWTv9nfBQWwvGNucy32bAIQn68i3w+JEfBkFE6GEEzrg0ztSdjUPBFAFzjGy
 QQFHP8odyr+l7NdheqAjw8Z2SInG0eNHi1VBwpUOY4EO5LHibVRyAvUoUX4cZOuKzq11
 gu2w==
X-Gm-Message-State: AOJu0Yz+XNsW3tsmW5osxFufcBj0sJQ1U2J7w+R6NMHjeEzVPy/17XHX
 cVj9jezIz6yrfy99a+mtLyVCq7RI5YtNcXaEMIFAJI8kMDEPBkAn98kxycWCdYw61zkcLC13pAq
 Om5ncSs3acc6+BUvHQ8h3aJGvO2fk/AghAPMqoNxyqrAh/w0=
X-Gm-Gg: ASbGncvYRwYsOVT0aRrqBJ+ztwvAEe/Nq1jLYtKTcr3Ou96kMDbnASsbZgo//yf+76I
 d0CKaQx69mxuZbL2IxB9n2MJyHhUc6vF01e0B553tTvKgB6xVlGb8zTXgy0L3I1sG41LtdzME1W
 3pBx0tLFgpQRSlH2+ZUZYYHl4=
X-Google-Smtp-Source: AGHT+IGor+ETr0ylCaMX30sl2RZaEsMzTwngtUfM7hBGMr0TDt2f12LbdldqChnd1AhOBwK/eIFVzkao67pQuTCXtfs=
X-Received: by 2002:a17:907:9724:b0:ace:9d90:c568 with SMTP id
 a640c23a62f3a-acefbb373e1mr258736466b.24.1746111807395; Thu, 01 May 2025
 08:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250501012530.3954999-1-sjg@chromium.org>
 <20250501140354.GC1261075@bill-the-cat>
In-Reply-To: <20250501140354.GC1261075@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 09:03:15 -0600
X-Gm-Features: ATxdqUEc7ThklGwQSwhURiojXNUuTFjAO3nFsmfXy4r9iLURf7Kbem1sBS61QNI
Message-ID: <CAFLszTgKbsE0N1AEkwydiQQLMrMRNDtivQWVKmDsESYqZE-4VA@mail.gmail.com>
Subject: Re: [PATCH] CI: Update the CI lab
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
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

On Thu, 1 May 2025 at 08:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Apr 30, 2025 at 07:25:24PM -0600, Simon Glass wrote:
>
> > Update the boards in the lab to match the current situation:
> >
> > - bbb and pin64 are working again
>
> And were never disabled in mainline (since iirc I never saw them not
> working).

OK good.

>
> > - samus and c4 are still broken, with no end in sight
>
> Good to comment out.
>
> > - new boards for colibrimx8, rockpro64, rock3a/5b, rpi5, zybo
>
> Except the imx8 board doesn't work in CI in mainline and had it's own
> long discussion that petered out.

It has been fine for me.

https://sjg.u-boot.org/u-boot/u-boot/-/jobs/49094

>
> Please v2 where you drop the line about bbb/pine64, and don't add
> colibrimx8 until you or someone else are ready to work on the underlying
> issues this exposed. Thanks.

Do you know what issues?

Regards,
Simon
