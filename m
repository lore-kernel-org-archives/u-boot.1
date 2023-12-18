Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE36C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D63F877EA;
	Mon, 18 Dec 2023 12:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZXWHT7yx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9495B8773C; Mon, 18 Dec 2023 12:41:02 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C80087E00
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5e730eb1770so1783707b3.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702899659; x=1703504459;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ki0O0zvXe2/IpEYiuN8A+k4vnW/67tP/11jv0gfZwrQ=;
 b=ZXWHT7yxMgY0UdifKlS19j95JnWI7k/DbWZwWr+blp5oYNbtWAe9V/4nWOG818kply
 2BYPtAQfyFN4u5ASfzAPsVDIvf3R0hTjQNhiYieKMPB+xBvfKba/1iCl2tL8XWSe+RUd
 MkYt5HrF3bvZstL+333iSqJ6H0nK+2sSY60/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899659; x=1703504459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ki0O0zvXe2/IpEYiuN8A+k4vnW/67tP/11jv0gfZwrQ=;
 b=Eh+1Wmms29yfhpSHWteA1SldQEkgRb4FWdMNLgv9+8SePw8ZrWbpK5fDH3GIHlXuDE
 doh+/AytdvKOGzQpd96Ef3lANk3RFNfv2lD0bstdyQVwbiqT/xYCIVT+P3m3bvMojG/9
 Cb9hNKXPl2K9TIZRuJsz4E6E4FPrHCuKjSlXuTUMValYdCCEX6SUD2oBsnW/exiptxnM
 nIO8TW6RYHWI5Q+RMIlVrt/UXBId6tIjClaQjr4iK/EZe/tVKeugnL4+YcDq0lhdKgEF
 4J6mZtN6YBXmm3Lile24ZcuswZubK43STzPlDBKFfzCCmSiCb6v87iGIpgtJ7tpVI1ct
 Oxfw==
X-Gm-Message-State: AOJu0Yy+RVA3dJzGfk+BPTzyWEoscZgzAxHNnBlbm57v7Z/rTsT7WY61
 WL+o6o9BUBd96hoFDHay/aHkMu0saKBvRf38Ojm9N9XpLtotJnjItJQ=
X-Google-Smtp-Source: AGHT+IEOIlIY3sxs+XYm33aGrHCbVoWN5fy25bYo4/6WnTsfg+BGNHmcbc87P7ajLI622t0p7cyE9TmeYehDNhNzyoE=
X-Received: by 2002:a81:6586:0:b0:5d8:96c:690d with SMTP id
 z128-20020a816586000000b005d8096c690dmr10952530ywb.7.1702899658900; Mon, 18
 Dec 2023 03:40:58 -0800 (PST)
MIME-Version: 1.0
References: <20231025074951.3161356-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20231025074951.3161356-1-hayashi.kunihiko@socionext.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 17:10:47 +0530
Message-ID: <CAMty3ZD3Bxh-2ragz1RcXWf44kxAue6gT-xO-5k59m-vBd0n9Q@mail.gmail.com>
Subject: Re: [PATCH] spi: dw: Use controller clock rate as maximum frequency
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>
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

On Wed, Oct 25, 2023 at 1:20=E2=80=AFPM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Currently the controller driver has maximum frequency in plat->frequency
> that is specified by "spi-max-frequency" DT property in the controller
> node. This is special to U-Boot and doesn't exist to Linux.
>
>     spi {
>         spi-max-frequency =3D <A>;
>     };
>
> Usually the frequency should be specified by "spi-max-frequency" at the
> slave device node.
>
>     spi {
>         slave {
>             spi-max-frequency =3D <B>;
>         };
>     };
>
> The final maximum frequency is set to the smaller value of the controller
> node (A) and the slave device node (B).
>
> Currently, if the property in the controller node is omitted, the default
> frequency is fixed at 500kHz. Even if the controller and the slave device
> allow the higher frequency than 500kHz, the maximum frequency can't excee=
d
> 500kHz.
>
> The upper limit of the maximum frequency should be determined by the cloc=
k
> rate of the controller clock. And this patch determines the maximum
> frequency based on the clock rate if the controller node property isn't
> specified.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---

Applied to u-boot-spi/master
