Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6DAC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3AD88847;
	Sun, 11 Aug 2024 16:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dy1wKDq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446DF8878A; Sun, 11 Aug 2024 16:50:20 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CBE88453
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5d608060241so2207964eaf.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387816; x=1723992616; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gEdWC2rVb/pVX/WEQt2m1D1CbQQoSx4UHQqLjMKkEZM=;
 b=Dy1wKDq8hatEQCL8KqQf5p0RVXW0G72ZijQKyODcY4R5bZ9q4vVI/RpqUD0+o10W1q
 8bjrUg5nfxmMjkqQAIOByaw2wexOzYdhox/u7IxO+MZuxlyjOLA9c3fR1hUII5iv18cr
 nj9MDr3KmyjHrOPxUGl2FEcnOsMVuo2ZHAddQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387816; x=1723992616;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gEdWC2rVb/pVX/WEQt2m1D1CbQQoSx4UHQqLjMKkEZM=;
 b=OJgbaKFqmt5qcjNEXeEMLcwUGmizucvMLk7tSHmb1whyv60mfN1yjeEX/q/fNBSpyR
 rW00NUHdmYEGzcXfScdYuIQbSArKjN0ghTSMzIYYEUwQnvdJnSJMVz7Q9K42Wqj/AteP
 BEBtGtdJCQROXhc5IDyNsDVZ/Sjbn9FuJ2Nsc89QEh08lj8Cf+uEZ7ANLJy9Rtoc7zMq
 mzZqwy9XMh+y3M5mXNsA6SyhkxnahpD4sRUc4sYU/0v8iAAILu3TPzCH7Uu/8ged4hfW
 uL8H0MUtPAVnFiHiaCeesAclyJyqsCToJ5bu4uGtXrLgWSIBnX2/LgPOJnbyk5b/KIb1
 mHIQ==
X-Gm-Message-State: AOJu0YyBUMk+xUprrymrkcBbRUNaXfMQqbfPw8YM6ycoAUci6grF6bhJ
 TH98R5RLMHzk0oI5lxhqvpi37qwl96hEfWGZ/RGTfvMiS2XYcIYXB3OqvlR+h30sR/AoVClTGW7
 b4AGacl/he4laPF9MEkItb9RVwJo3gupwsnyf
X-Google-Smtp-Source: AGHT+IEne22vdahjC0TZKY1IitRH65Q1SB6taqpKGnkZ9AkJFPVg9imx0A4/Erpjce2iBA9ipP8qE/G95gqSUAEmYz0=
X-Received: by 2002:a05:6358:5288:b0:1aa:d71f:6921 with SMTP id
 e5c5f4694b2df-1b176edf133mr1002408255d.5.1723387816712; Sun, 11 Aug 2024
 07:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240810135249.4037082-1-seanga2@gmail.com>
In-Reply-To: <20240810135249.4037082-1-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 Aug 2024 08:50:05 -0600
Message-ID: <CAFLszThUVC_KF==4yR0jp7TCo3k3gPR8+g+deVqxwusTegaC9w@mail.gmail.com>
Subject: Re: [PATCH] sandbox: Fix pinmux warnings with non-test devicetrees
To: Sean Anderson <seanga2@gmail.com>
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

Hi Sean,

On Sat, 10 Aug 2024 at 07:52, Sean Anderson <seanga2@gmail.com> wrote:
>
> The sandbox pinmux driver is used in the non-test devicetree as well as
> the test one. I didn't realize this when I modified the driver for
> tests, and so broke the regular use case (which only resulted in
> warnings). First, making the pinmux and the UART group available in all
> boot phases to avoid ENODEV errors. Then, convert the pin groups and
> functions to the new style, adding onewire group as well.
>
> Fixes: 7f0f1806e3a ("test: pinmux: Add test for pin muxing")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  arch/sandbox/dts/sandbox.dtsi                | 14 ++++++++------
>  drivers/pinctrl/pinctrl-sandbox.c            |  4 +++-
>  include/dt-bindings/pinctrl/sandbox-pinmux.h |  1 +
>  3 files changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/u-boot/-/issues/2

Please feel free to take over that issue if you can and add a
patchwork link to this.

Regards,
SImon
