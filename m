Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D6FC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 16:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54BF386C56;
	Sun,  5 Nov 2023 17:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EU1i5Sd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B018C86EF2; Sun,  5 Nov 2023 17:25:38 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E25986B0A
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 17:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-543923af573so6315700a12.0
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 08:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699201535; x=1699806335; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yRON6SqRbp0UbkKPnZYWZ+XsSVHP+yfBv+oUPBzq9PI=;
 b=EU1i5Sd772I1/bqPLqISBk8wdEsHRGgpK73+vkOG9Ec4JXHHTTN2yYNETKtet0m2jP
 V8QUfTbRH+4s/gyZET7gVZKVKi53r+73riLBFkhcMpFGYA5MMfn8rJpqTMyXv1OdtjqM
 CmU1dogxTIdqdDb734RZBixUrwY+QmamDOXWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699201535; x=1699806335;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yRON6SqRbp0UbkKPnZYWZ+XsSVHP+yfBv+oUPBzq9PI=;
 b=JmWBNUHPKL2fKiqtuhf9GaQr5bdZ36eLcwJSxiaM+iURl96N2LeCEtCbHwO6sSiAd/
 SkrnuGKPv6iUpjlKQuGnUPaf64GXIZyvATCqCYX+mjFAPVS+P6TFonxjdxWpOdZ+e9IN
 tBcJwVISzmm0g2Qw7IVEVxs1fl3CJyJf4JSUSeMmgempaio+I7FtUWbj5WioOncefr0N
 M6j95ublHLJkk1alrJpI4BFBm0c7LcKtxKUJ+WUdavsWC+mA6zxsD25xGEokO2xMgvhi
 QQr31nXd3nVNDECg3ymmjgvc60kSAcBRk2eB4zsX8sB9NZCnLXSWlaaJn0Yp1LxRo8kt
 w21Q==
X-Gm-Message-State: AOJu0YxhD60hYwv76nTt/AQmE2gjgzzfJLVIwh9Z7ixbo01JuNWe6CO1
 s9RrbQDrpxt2/p1a5Ow5cVERZLyVrhG+OwAbT/Y/Yg==
X-Google-Smtp-Source: AGHT+IHpJPhUrCr8n1tVTGnXsVIytSIujyc3j0WawxXZiE86L64x8Z32mKPyT2RslJJqaDNnKmxgLAuJqo/YJMBN91E=
X-Received: by 2002:aa7:c494:0:b0:540:f0d8:d748 with SMTP id
 m20-20020aa7c494000000b00540f0d8d748mr23875762edq.23.1699201535264; Sun, 05
 Nov 2023 08:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20231104065107.23623-1-heinrich.schuchardt@canonical.com>
 <CAPnjgZ36uRkVGKicr_hD-=0HO+i9giQ7vRxo0uKD+BGQnLWdWw@mail.gmail.com>
 <874c3e34-56db-4f3a-acad-099d16735333@canonical.com>
In-Reply-To: <874c3e34-56db-4f3a-acad-099d16735333@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Nov 2023 16:25:23 +0000
Message-ID: <CAPnjgZ3LHxNtf1RGRJzwT-9vF_03JdN_3SRF3o9QYNzshpp1cQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Xiang W <merlew4n6@gmail.com>, Andre Przywara <andre.przywara@arm.com>
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

Hi Heinrich,

On Sun, 5 Nov 2023 at 03:47, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/4/23 21:42, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sat, 4 Nov 2023 at 06:51, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> The existence of devices should be checked in the bind method and not in
> >> the probe method. Adjust the RISC-V Zkr RNG driver accordingly.
> >>
> >> Use ENOENT (and not ENODEV) to signal that the device is not available.
> >>
> >> Fixes: ceec977ba1a9 ("rng: Provide a RNG based on the RISC-V Zkr ISA extension")
> >> Reported-by: Andre Przywara <andre.przywara@arm.com>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   drivers/rng/riscv_zkr_rng.c | 34 ++++++++++++++++++++++++++--------
> >>   1 file changed, 26 insertions(+), 8 deletions(-)
> >
> > This device should be in the DT, so you have some control over which
> > RNG is used.
>
> The device-tree provided by QEMU does not contain such a device as Zkr
> is an ISA extension and not a device. This device-tree is not under the
> control of the U-Boot project.

Why do you bring up QEMU? I would expect that it follows the norma dt
bindings, so it should not be any different from real hardware?

Anyway, you could add it. It is just a binding. I believe RISC-V has
all sorts of isa options which result in different machine features.

What are you going to do when you want to choose between the ISA RNG
and a TPM one?

Regards,
Simon
