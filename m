Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927BDCD6E7E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 22:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC55B84932;
	Sat,  6 Jun 2026 00:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UCCilsNL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05C9784942; Sat,  6 Jun 2026 00:06:27 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F52848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:06:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69155ca09d8so258491a12.3
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697184; cv=none;
 d=google.com; s=arc-20240605;
 b=e/aCsaSduuU+rLSWbVY9ZngeFRj5UUuKzyq5+E2xg3/yx9Jtye9GOxBwi4u6gW43yi
 BN/K/EwYqKPWdXOaSlw3sZWDIvMPuACnWeP+wX1BfIAkmwjNtH6ku7YrbUdU50zxS46V
 V+VTxnOePNvsMYDbx6ocaKDP8+qyGff4kE0wkg7QqAo7BCMnTdeNdYrT7MnmoixznRTq
 OpZLDmSCJEsuVR5SnR0fUE2lc3I31H0Cxl/itT6rpDXcD6pqS1lqVYbmBS5JRZ5Qvi8l
 yRjEc1eG/agxVWq33QN2pOsgKm4cAmrCp9r2HCRUR4IEPVuoPJ08I9ZbkcYN02bamD1H
 3hYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FV2YQfzc7b5mxdnMOAg12dZEnpIoCAi5JABPgrHAOVY=;
 fh=dagBcsuW9ZTKfY75/jASW4WhNJ01ngjbrnW02coCJVA=;
 b=aDjJ5MR5BTo2LtgbtWYCvNLQI6M6pOdNrBmwGeUy607qq8cbRg40Dkx46CDQg4eUS6
 cQWFsg/2WU7fH5eWe02pzCjaLE8QyYI48Q+45DtHBz8En1QYFYk4PkDz6EHYsIDs9ivc
 NTi9Fi5snJiI05D7CVgkTzYKiZojFictUeeXTJmc44cNygUCpaoEsB66OpEcPJ6fx2pc
 M2+w1rmCat5rb4bMcHhk9haJz+7bm2uwJTRgVsR88hSE04VYdQx/CT+9eLvdFNvqd+fz
 2aD4RH2Xey1q78KezmVAfCbdr4XPVBME3GyARcQhWs+XpECbdknlz7wLdwrncFZbXbvF
 ajLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697184; x=1781301984; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FV2YQfzc7b5mxdnMOAg12dZEnpIoCAi5JABPgrHAOVY=;
 b=UCCilsNLyFnTMOajodLixEN8f3R8EVefwWIG5rYGTUCUVBvNWfHh0NZmZDL8insD63
 M6mPiAQYdePOOHQaBuc6zk8DmV1b1DbU8duIhDc5tkrPVlB7Dk37b07a87HA56nBie1O
 fIm6mpC4rnSQjpjXZt4wfjZkK/0FbuUg6FROI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697184; x=1781301984;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FV2YQfzc7b5mxdnMOAg12dZEnpIoCAi5JABPgrHAOVY=;
 b=F5diEwpFup9RRtXUw1TRyX0iYZ+WjmACcDblpOgKyYTWrgUDjVKs+7zsq3yZv1FnXh
 k87QlPDYcKuvLEkuBEX3whrpONWpXtXm/5c3NBWzw+FJV8TDQCtGfB/BNzCoNeWD+VLq
 NqFwwIZD0w8RqmyJE96xtsHMhH/VuCNhx6Rlj6ghyCisbFEI4tYIVVFKjjwWxCxEqfFc
 EFxnsmJFeTPZbXSvjxnv8ZRikQdXk6liar3kD9cJ19r29ldVIZXK4sVlFKDXPrpofNAZ
 b64WfnF5D+Bb+tZMhl8fmJagVR19fS+MqSnyKF8w4nJ0y9ngMRdYZzdSRlES6chhMKx9
 BVpQ==
X-Gm-Message-State: AOJu0YyXFlgSQZVxv4j15Vwt25yaD/UUlOi8tWrOkDbt1kNwRjfZ6pfQ
 nVACJSbLv1EhUmymDri/ycvZx3eBc0AyFhdoEI0AAH+9U4bNJiW1oOHBoXMozyk5pklvVZ52uqE
 wwmZ7a/kZ0x65gFB75/tE7uaRsh6XAWx58WuSbAAEQ9iSnHFQmKk=
X-Gm-Gg: Acq92OFrSQHSVj2BsuPoIE2x4beWYqvf7faHF+ZJOQOAMBPsOdp8FtYKOYm1xdZu0NQ
 lSUvXGTpKnL9F7TkVB9+xI2AKlt1SyVj6eLfw8T1Eu5tBO5sE/7FU13voKttiS5/8AN1no2MGm7
 wtAGpwvElEoPzjl9a5DRrR0VVDaZXUK8TS3XYidykLbwqwpkdpKbMt6AzUexsp2dgaHNqCTuuOf
 t7tj4PrvICmpmVTGX7zysixVODAaBMU6lT6+P7y5Ky4zsGoINBHeyjp7YgtGR4gjAqeEtH3kp4J
 TvGcDiudefDccqgE9RWGBfdeLmM=
X-Received: by 2002:a05:6402:3715:b0:68b:e0de:1386 with SMTP id
 4fb4d7f45d1cf-68fa503b4c7mr2780295a12.13.1780697184344; Fri, 05 Jun 2026
 15:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
In-Reply-To: <20260602-devfdt-spi-v2-0-08374650778a@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:06:12 -0600
X-Gm-Features: AVVi8CfIsjUH_fGVwINzNvJXPom81bjxb-g3HP-lCeNVGCE-Uqhe0XDECMSTyqg
Message-ID: <CAFLszTjFZR_UeJhQXgiZSmAGkw-ExUd-6f14OeY__+uQGt-kYA@mail.gmail.com>
Subject: Re: [v2,0/5] spi: Convert drivers to dev_read_* APIs
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de
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

Hi Peng,

On 2026-06-02T11:20:14, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:

> Changes in v2:
> Per Simon:
>   - Patch 4/6 (cadence_qspi): Update commit log to note the new NULL checks
>     for regbase/ahbbase as a behavior improvement, not "no functional changes".
>   - Patch 6/6 (ti_qspi): Fix dev_read_phandle_with_args() call to use
>     cell_count=1 instead of 0 so syscon-chipselects offset arg is parsed
>     correctly. Wrap the call to 80 columns.

BTW these numbers look like leftovers from v1.

Regards,
Simon
