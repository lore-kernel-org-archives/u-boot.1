Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559ACC0218F
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D15380FDE;
	Mon, 27 Jan 2025 00:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jgOpn8u6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7255B810EA; Mon, 27 Jan 2025 00:58:53 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524F580FD8
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-467a17055e6so43419251cf.3
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 15:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737935930; x=1738540730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA5g+5Ge4qtc1c+NWy1CkIG0o4kuCLgAJ0AX7Ui9LXs=;
 b=jgOpn8u6XWoZIdxJvgN0tEFaTzZrsNUksFS9h5y4I3OSuZyLPOgMnbQGCFxQ1VmQKJ
 8i7pJ6qInxUuiNETAgrDASKuGHNcnYdZ05xZHft4aqkRBVJXwkY0lkQwNAT2zUFRp54W
 UiDBIj/w99Vuyuc0H5Sp0dZ3OGqNnahvvtcmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737935930; x=1738540730;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dA5g+5Ge4qtc1c+NWy1CkIG0o4kuCLgAJ0AX7Ui9LXs=;
 b=BtihszBaUq2a+ytYB1dx1Nwd24HQFjQwDoLbrat8LQmFMZfuQrv6fi++hJ/fNgDtf2
 apH4NgarJYImP40V5LgFgwocYSAnBhYb8Np8HOAwByoxhijEmdMSUZq/FIopcgJHgcOr
 cMjpXBUgwzvu/JfWtaIL2NJRV/tCF6v5fjkr89ubiFjIGoYw06C/X9ZGLFiPEvFnRnX8
 tjpdQmZPTV3IFpxMR4DK9796muWaDyD4uEtofp5OpP2iF434aG/yVmzGdSiLeHR5x6fX
 i/JzN44fiWazPNoUUOsl6Cb2vXzTnxFIwtXo+Fc9jfuMFMHw0L6iYn4g9ZPYGOTG88c/
 6Myw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV26HpJ0JTV0RnX1i5du1ippsFuMYxIcpZ7+JTNwcpUCCz/QApBsiiI/NwPedhw28a56ocJnE8=@lists.denx.de
X-Gm-Message-State: AOJu0YyecbJgjJ6COw10W80/HYUfNTwrmMv418lB2dXn7TUHBetPiekd
 Z746p5JiM9A0TkvAqa/4WIX/3l3JOxbXMHnFKinS0zQbKf8Qt3NWNdaNCtALImP9ebhP/LTRzAm
 LKIDjDQ==
X-Gm-Gg: ASbGncvCvRKttVwkVbibdv/3oR0n85a6uR9tR0TEXy4sTKLYq0I2woo8lBeI0hUO8v3
 Iq+eM+ZT8AghTM1+XRFohxsYKmYpkuLuZwFgHBHAx8baLKDRy20T0AwqOCGGHULGncFoPVVV3hr
 +MDcxN3JunmDYoWMURa/WJZZjpvK6yv/4vsnz8B+K2tmWzHUguaAIhz5EhLdi6/YIuZ8rOAbLgb
 JR2ER8i9dPvYudqV2erCy1BltH/hO/d7u8nqnYuBCrctttdoBXoj6LhbXnV699dQRH3HkVRbCuk
 Pv8=
X-Google-Smtp-Source: AGHT+IG/un0JLvw5j+hahcowud+6agUXmYE2nl/YzTmeafePIzTJKA/bG/gRO2X1QRro+KZQiGdAXQ==
X-Received: by 2002:a05:622a:52:b0:467:6cce:44ba with SMTP id
 d75a77b69052e-46e12b96babmr523538041cf.43.1737935930219; 
 Sun, 26 Jan 2025 15:58:50 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c3332sm29367206d6.111.2025.01.26.15.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 15:58:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>, u-boot@lists.denx.de
In-Reply-To: <20240127162922.284598-1-jonas@kwiboo.se>
References: <20240127162922.284598-1-jonas@kwiboo.se>
Subject: Re: [PATCH v2] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
Message-Id: <173793592854.1408499.11088119598553520736.b4-ty@konsulko.com>
Date: Sun, 26 Jan 2025 17:58:48 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Sat, 27 Jan 2024 16:29:21 +0000, Jonas Karlman wrote:

> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
> issues together with the peephole2 optimization on Amlogic SoCs.
> Following was observed while working on SPL support for Amlogic SoCs.
> 
> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


