Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD01E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6370896F5;
	Tue,  3 Dec 2024 20:48:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kPmZdcdz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15730896FE; Tue,  3 Dec 2024 20:48:19 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CAF896F4
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee4f78493aso3553123a91.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255294; x=1733860094; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tZze7rt//zLN7uXTU5stZPnyXzIXBw4Tez0U+tE5JUM=;
 b=kPmZdcdzHZXznOFmpJjwjNL6dwEwt5rpStCTNIAEwGOTIHsClKPxgt0pDX9FSyNjxq
 iDYpF258lz3m+3EVTIEYiC8h5lNiIIH83J8PkEw4urWmj9m5feT3RSJqkO3V0MydSEDj
 6DfkwG0wBdwgZt0EhNri8An39Tq/f3onKWYDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255294; x=1733860094;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tZze7rt//zLN7uXTU5stZPnyXzIXBw4Tez0U+tE5JUM=;
 b=PAp4/7T5PPreM1ztaSQDAcx+77ZZe9DsSR8rzT6SzTQKhF3dNaUKnWDylLZCSueHYW
 b6GJsJdzAE/fB047GAwX5RNGKFrICa+I1F3MAHVPqBlEtrJQ/D79uDrQX66br0nPOo8Q
 VC10Gh81aIacvXgyBTGYZZSYVLjnDxD2bB+NXYi15kjoWRUEmi7kZrvz+mSves3AggpO
 7qd1IwrC5k5szdbygJqVnXF9g2nJL/Peuf46FiVeSmXv/ZOiiwWs2wvpXPsRvXJ8540E
 D4DDZAx43IJS2TytMNt//LAHNDt8rCoFLmqNo2YPcFAfZPajoVWn4DLsZPh3qQ6hMgeO
 UdHw==
X-Gm-Message-State: AOJu0YyEVM37nuHiO54ixkB1iJjDcRagaZIBWbaQBF1Kgkwe6z21U1HE
 grBYPlhg8btPN4hc29dxtHUmqc5EWWGTuNxdLHvU8UMIbz5OoldaBT0n0Pbs232rUbos2P7l4rG
 A9Qk7bTPilyiahKOEHp28Qaq4hx6lWIW1r3mQOcHwpgHYJL8=
X-Gm-Gg: ASbGnct5IfUUQwTzQSYaQh1zZXX3ZSj5r3ryDvDe8PaDjQlIEyFhyS3076ImSuxdt1U
 hYBcueRUjG9MLv8CQKMeroQTiu+OjdtHC
X-Google-Smtp-Source: AGHT+IENA3C3akJMgh5jAzjxljxf4VXmdt8telQvSWYkkl1ho0iBQ0b4Hbu+eHbXCkT0QGkaWiVGaXhT+dHgjYQ0Efk=
X-Received: by 2002:a17:90b:4f4e:b0:2ee:b8ac:73b2 with SMTP id
 98e67ed59e1d1-2ef011e3732mr4939249a91.7.1733255293700; Tue, 03 Dec 2024
 11:48:13 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-6-sjg@chromium.org>
In-Reply-To: <20241103003322.626036-6-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:47:34 -0700
Message-ID: <CAFLszTiAW3w1m2c0t0B3VzJpgkuFWcs-vMP-iPu0yj92GbFBog@mail.gmail.com>
Subject: Re: [PATCH v3 05/25] led: Drop LED_STATUS_BOARD_SPECIFIC
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Doug Zobel <douglas.zobel@climate.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

On Sat, 2 Nov 2024 at 18:35, Simon Glass <sjg@chromium.org> wrote:
>
> This is not used by any board and there is a driver model version of
> LEDs. Drop it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  cmd/legacy_led.c     | 40 ----------------------------------------
>  drivers/led/Kconfig  |  6 ------
>  include/status_led.h | 13 +------------
>  3 files changed, 1 insertion(+), 58 deletions(-)

Applied to ci/master, thanks!
