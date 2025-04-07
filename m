Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29FF4C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAA382F65;
	Mon,  7 Apr 2025 17:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="tsVLOCkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFBB282F6F; Mon,  7 Apr 2025 17:26:50 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D62B82F42
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so4317727276.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1744039607; x=1744644407;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqErqkwR1FI27yhgmfKWcLVjQ7ZvlmJGWtpTl29JLqo=;
 b=tsVLOCkwZsjyyXURp7n7xwcGS9DJnf4Wp3apI7Ra1UyELKC8xbV9ZJkAvhjl1Ev4V3
 O7b5p1lQPGgSGaZDCzYtVsbRsfdIttEHbsNCMiXIZQ0FJKZDC+T4sgCPJT73ehJqcyx5
 YDFBl1/Un/JzOa/GWehb/4aR56+EsMMTMQEhi4DtFH9Fv/XH8S0B1DQ46BDEi+MlFT/Y
 7Xl4m0NzE4qQ00oTvuHEGdDffOmQmnP63mM0DxttvGjlLgEhC8uo1LV2bMzkUoiwwg1x
 o5nx+XAL/t23Ze2GpmPpp3EUleD93BsoO+4r6hS8oIHm/Z9/BzNFMpvJ7V68O0kWbOCB
 SALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744039607; x=1744644407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqErqkwR1FI27yhgmfKWcLVjQ7ZvlmJGWtpTl29JLqo=;
 b=cNZTS7GeKShJEohb6MysTy+ZP5a5icMP7FQzb31iq7ZQAFw46adWBV6puqCwWe3SVb
 aBtewVWCmKRnXOVpZ6a93n971keC01Z5TuE0VwjvqkNWnClk0IZXBKLXs1zFr2oAoNVT
 nkIrnSAsZimT/5ML7UWYVjrn8cellbV+68k2EtiN7Z8wiNIo0mWKxfuVVH2+Kr890lVy
 dXVsmN3WAUEtSfsZb+CJxOzYbDRpVkCxzIng7G2Xn4HbyiPiUaflMofFGjcBEviSpPIO
 QV4WJ+RMCHvb2C/4Yl9wD0Siii+e0WqitJ3wFbm4uoPV3XLxYAapugSmyCvuKFxQL4FV
 05CA==
X-Gm-Message-State: AOJu0YyFQYjR99qdz6MCK6p2N7GDbLvTPsntlCAAQCDDEfdBG8+qRmqB
 jJNBwYDNAM/RKAnv5zFNuYiBN8hcNyNXKry0qxaT1ciOVH6/xi8eBpUP8NgfGYBi7MnTyycCsMg
 udsRrt8Iv3kSBZ0xyNwp66ohAjGcB5YviUlG0rnK9okkIDQho+jOm
X-Gm-Gg: ASbGncsEvtOdq7RNG8Q3T/vVhRia3Dv17my5xR06eQXpjO/dLOHZzJttOMnyUdNlUry
 07Q46voL1EPeF5g1yZGxYqegEp5U24fL3POzC4qk3BwYawxVFfKfmh8DSJWpiPYxt6PHi7LdfpC
 iKhH9SX9nq5vz64tWxPXbZBtOZRs4=
X-Google-Smtp-Source: AGHT+IFJAuUgokaDexRCdNLyIrm8YdI6xFDOu6UhsGvl7EIukEcA0cRBlwCeODJibn3J3nfSkDpLCrS2uMYrfaEM6KI=
X-Received: by 2002:a05:6902:2411:b0:e63:f191:e8a7 with SMTP id
 3f1490d57ef6-e6e1c2ac3bbmr20158789276.31.1744039607440; Mon, 07 Apr 2025
 08:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250221110344.2301862-1-ibai.erkiaga-elorza@amd.com>
In-Reply-To: <20250221110344.2301862-1-ibai.erkiaga-elorza@amd.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 7 Apr 2025 17:26:36 +0200
X-Gm-Features: ATxdqUG0j0Z9SFtPOrkHSuwGBb58ro_taw3CIH18bVvP1qLhGRxxPJn0pF9OEus
Message-ID: <CAHTX3d+42A47K3YF_Fh_59vcQhWJgdhzU7kP8ZJGR4yyROSLrQ@mail.gmail.com>
Subject: Re: [U-Boot][PATCH v1] cmd/fpga: use config node for loadmk
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

HI,

p=C3=A1 21. 2. 2025 v 12:04 odes=C3=ADlatel Ibai Erkiaga
<ibai.erkiaga-elorza@amd.com> napsal:
>
> Current implementation requires to provide the name of the FPGA image
> within the FIT image. As the configuration node is mandatory according
> to the spec and includes an optional property "fpga" to define the
> bitstream image, use this approach instead.
>
> This way there is no need for an additional information in the loadmk
> command for FIT, and signature and hash verification of both the image
> and configuration is performed.

I am not convinced about this. fpga entry in config defines link to
bitstream partition and likely it will work for default config but
you can describe multiple configurations and have multiple bistreams
in partitions and by this you will
lose capability to extract/load different or multiple bitstreams.

Look at doc/usage/fit/multi-with-fpga.rst and describe multiple
different config nodes with different bitstream and try to
load them with your patch applied.

Thanks,
Michal
