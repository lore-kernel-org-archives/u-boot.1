Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A685FF886F
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76F583EF9;
	Mon,  4 May 2026 14:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ikl35zx0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23ACC8464D; Mon,  4 May 2026 14:15:26 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8B1D8394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bc1f0830f44so158517766b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896923; cv=none;
 d=google.com; s=arc-20240605;
 b=jzvMcOD/EuoA8RgXat3tlAnC8hBoBGMeN7AB1aea3XdZogDaT60gAARo14/+b4rvkQ
 hPscv51RTsJyzeQTHxhAA6NRxFpjXWGWJUWlqse8UA2NOFF2F+SEIjlbY7Lk2FZo6/NC
 MaGonuzrVIkoHngvcKQDyVgxypg5Ui5N6Agmv1J0pSbzTl3yim47QPS/hz7tIPHfHHn7
 80vs6A0HlnLR8RZnyL0wyYs9ZsVg+bOI/OMcefkjkDRPKTRB1onLJuQF/aW/clt8Sc4K
 EeoVN013cOquC+nBW+HnphnNvdK17CqfX4giJu5n1EYOLeeJrJU4xC2S8NQGvLXsx2zW
 cCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6LGkRJEysN17YwYs8bV0mp6qYaRDIMS4EgFp5eUUtus=;
 fh=e2rH7ycBJosHKSsif0WP87up4NnPfdXsHR72MGJpv9o=;
 b=DYVwYgivX/7hx2H4GBkM6EFfhyhGTdslZmFzicqvLCQaMhgV9JxER+Zmc2S9wwK29x
 Nd2YPVvbfGOWXPgNLHTnUBFnEPLlznpwOLNubnve0Gux9CutOsgytUm3lqaH/oGbD8Te
 scU/arY7BuB5DKhS2SyUXxO4fYHUuCLby/QpsvZi4abxsNM1Xo7ZrtwfG3KdtvFxWRhs
 60IRCNMK5Hhnh3df/RubbWorA0GIrE7v8re3Ynhjrk0K8e8QUGZgX69kp1B9nTt16DXY
 UQG5e0yPnUwJ+LyPfqro81IZg7a0wnf/zB3mkgckWcNZIVIR72jFyHs0b0qdFe3Dz6Cx
 ocpg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896923; x=1778501723; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6LGkRJEysN17YwYs8bV0mp6qYaRDIMS4EgFp5eUUtus=;
 b=ikl35zx0ppAtxzI2pAO3bmFnS9oaQfm/KxV4HP2zjPDUaCPIzcKMd6sR67HTOsRC04
 CRDajMO8sAqvve4/ebRtb7eL2pvf/kVlAfkDN1cP+je3CMirq+51DbEG7d2S9nfzzwDk
 au5UsabnXmAHuy8VQpGRJoRin/hMl/ERJsJtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896923; x=1778501723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LGkRJEysN17YwYs8bV0mp6qYaRDIMS4EgFp5eUUtus=;
 b=p8Wx43uS4QF88rGBWzvSt7gmP+ofX97/NPo8VmDFbFB9WnezDDs8UPgG+xdGS5w0o3
 6mNeumdw/KYJspHwEAuOPnRLCVn9nHu7pdgXXzWSm15n5Ere7fpN0sOFcvMGvi1ZwTvA
 sYDq+4IhnCD8YitltY+0XV6ZJYlvEpfU3cGiRAd0l6hE8CZEFfId8VHWG/dUdpjGoYeg
 6xIvO/hBqoqGy/4wCg9ABMY1VXs4sVSb/NeQlECgecpa9pPX0pbkPa1Eznul0nTgwA4l
 INKuAPGjewnb/45h3g1YsIfVFw58FohKHCcS5q7M7P8lOtvX2X42TTwXdQ3Mi1duRxgA
 pQGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/zV/QjrfsMrmrHQxIKg54MeBpVO3vhafJusqFQkiR+L+Uxidbfv6A/wJcrnaDo/9GDbsjEfCc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxf6czjiolGzqNIwzpyVbcR9uV7SwVho522AbyYnhbUtg9ovDOX
 lTheyCJLQ38w11fYn2sq357oEp25yK/clEMtrS8pL9kZZyJphuWxTQsqYroA4e+uGIkfK2F1qvV
 BXqq4sgJvcnBT9hWU/JAlRBemN6CHkpBM/ZaJ5pQo
X-Gm-Gg: AeBDiesQIoiUtlKS8g02MSc8/FcWRHOGRDyhJfRCV0MiZWZTRhc65e+nLkVZ7mMwAC+
 fSm3aWbMcNmE8rXJdYK1OXAw/xPaw7SgExVrZL1H4sRdYUdM0q4mRLl2VXF+Xaf21M4kswGQ62G
 TEUtcmVMkjEGgXRrzTOGdp7NPBWwHHVKsAr4S2AL02qFJdveNe2Wlc9X+1iTTtnFj/t3hpIrAex
 Sil2Ls4PbOftqtvXuHO67gPxpuAgBGVSvh6BxmDOAWutwcOajoAmc76HOm39JqBAyftxPS39AU5
 1JsBFVJOFFtK3cMy
X-Received: by 2002:a17:907:3f14:b0:bc1:4e2:854e with SMTP id
 a640c23a62f3a-bc104e28dedmr305018766b.4.1777896923054; Mon, 04 May 2026
 05:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260425033742.1519298-1-b-padhi@ti.com>
 <20260425033742.1519298-2-b-padhi@ti.com>
 <20260427195405.GL41863@bill-the-cat>
 <9863b81f-e6ad-41cb-8e02-4f22377d0137@ti.com>
 <20260428140606.GR41863@bill-the-cat>
 <CAFLszTgBzgYYF8s9u_5=-4Yd-zV5Z+wNF5SzP6M+MSowRreJOA@mail.gmail.com>
 <2eeccc2c-069e-4b91-adca-2917a24372d2@pengutronix.de>
In-Reply-To: <2eeccc2c-069e-4b91-adca-2917a24372d2@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:15:08 -0600
X-Gm-Features: AVHnY4Js49xi3OOi8cWZtLkfM5qMhGzinNHD2db0CYEOts-9Pc9IxHBxxsFOAXw
Message-ID: <CAFLszTi98wvn5B8vmuzfJHOPWgR3BLto5p6d_C9baCVKkTKqZw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] spl: Use FIT data address as fallback when
 'load' property is absent
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Tom Rini <trini@konsulko.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 afd@ti.com, bb@ti.com, 
 anshuld@ti.com, hnagalla@ti.com, jm@ti.com, nm@ti.com, n-francis@ti.com, 
 u-kumar1@ti.com, u-boot@lists.denx.de
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

Hi Ahmad,

On Mon, 4 May 2026 at 02:32, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello,
>
> On 4/29/26 4:23 PM, Simon Glass wrote:
> > On Tue, 28 Apr 2026 at 08:06, Tom Rini <trini@konsulko.com> wrote:
> >> On Tue, Apr 28, 2026 at 04:26:31PM +0530, Beleswar Prasad Padhi wrote:
> >>>> I guess the real question here is, does the spec allow this to be
> >>>> omitted like that?
> >>>
> >>>
> >>> Could you please point me to the spec? I could not find it.
> >>
> >> Sure: https://github.com/open-source-firmware/flat-image-tree/
> >
> > It is mandatory for kernel and firmware images. Instead of allowing it
> > to be optional for 'kernel', we created 'kernel_noload' some years
> > back.
> >
> > Which image type are you using in your case?
>
> FWIW, barebox has always interpreted lack of the load property to mean
> that it should just compute a suitable address itself (i.e. free memory
> aligned as Linux expects on that platform - same as kernel_noload).
>
> Writing that into the spec also allows for Beleswar's use case here,
> although it doesn't give the guarantee that the address will always be
> the image address.
>
> I think that giving a guarantee about the image address is wrong:
>
> - If the code is not relocatable, then its load address can equally well
> be written into the FIT image node
>
> - If the code is relocatable, then forcing the load address to be the
> image data addresses will make non-external FIT unfeasible for most
> users, because of code having the wrong alignment and for external FIT,
> it will mean careful placement of the FIT itself is required, so we
> don't end up with misbehavior at runtime.
>
> I thus suggest, the spec leaves it to bootloaders to select appropriate
> load addresses if its missing and if the bootloader can't, it should
> refuse boot (current U-Boot behavior). Future U-Boot behavior will
> likely need to be adapted, so this loading at image data address is only
> done for these specific firmware images and not in general as otherwise
> it would preclude any other use in future.

This seems reasonable to me.

So load becomes optional for all image types, not just kernel_noload/fpga.

I drafted something here:

https://github.com/open-source-firmware/flat-image-tree/pull/50

Regards,
Simon
