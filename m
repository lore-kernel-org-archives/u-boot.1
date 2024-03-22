Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FDEC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 19:26:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D3BB881A0;
	Fri, 22 Mar 2024 20:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AztD1iRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D7B87E8E; Fri, 22 Mar 2024 20:26:13 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10DB87964
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 20:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-69107859bedso16774106d6.2
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711135570; x=1711740370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K1wr6qxcaENNwUI/Y79zw9YYXTWNBBI1knK4DodxQ10=;
 b=AztD1iRLeUav1I4FcM/iFVLTdT8gZmsibaYpN6Dt86KPDwWgCjdAYhBO0sLVJe0VzN
 G9gZeUcYAy5x61iKz/MwewNvyem4Zu3bgf9Z+U31Au5ZFPlUSAFEV+v6+8FqI64wXMIX
 Ey1yABzhsKNQXXGtJ89D7P0EP7hHqwATW+bdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711135570; x=1711740370;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K1wr6qxcaENNwUI/Y79zw9YYXTWNBBI1knK4DodxQ10=;
 b=xINz3d9q3057tFUqd65Wu65APAdP81UCWL26oGqxBiv9PKdGthyoOAqFDve1GDeA1l
 zTyoIuZvFt8ERE2u9Hor/DE5Ga7dh2tcDejP6BT7KGdk6IOe0gCAXoz8ssHCVuUf5KS4
 MnPSPPtYnny3QqZlbSF2jTYEQ91Whj4brJjG3+cp7tbfOw1aYUO6O1D9yfGF1/cfgQow
 C0yqAY5vwg4atEpH/D94DtnXAYMulIjT6BwLgEuzKKj1xWU2a/u5FgQdHdjYLH5kIilQ
 iWde2hp0A28nojPOlJdgvDlb7hiZX6o4xl/6tsTcGOsNTjelmjotOI8Xsix6sl6cYVOy
 UePg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN+J08Qf3eu7f9fhgE2j+tLXGY93+Gf4vc3mug3opXBMemGlPG+016cRj/QFaIam9qHYFaS/l6cUQksmMQwefOMSjQsQ==
X-Gm-Message-State: AOJu0YxjScldml435IXnWMvSzxqz+MBrQK3L1pNJwAOAEvY72ynTv+HI
 p0gFTL7Ej1H8kSzbeD4lC/b76Gdmm4cfdBOI+Gd8DVnPbWGqEERddwTZqpvku7E=
X-Google-Smtp-Source: AGHT+IHtIDA3qnWnIVg540AG2YNuQFELOkFQX97acMxxyQYdlWgVudVgwTGLW0BIEnXI2nzp5DwIRQ==
X-Received: by 2002:a05:6214:21ab:b0:696:3704:712a with SMTP id
 t11-20020a05621421ab00b006963704712amr430022qvc.28.1711135570578; 
 Fri, 22 Mar 2024 12:26:10 -0700 (PDT)
Received: from [127.0.1.1] (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 jo10-20020a056214500a00b0069102f97e08sm1362309qvb.97.2024.03.22.12.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 12:26:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Hiago De Franco <hiagofranco@gmail.com>
Cc: Hiago De Franco <hiago.franco@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20240320164845.141894-1-hiagofranco@gmail.com>
References: <20240320164845.141894-1-hiagofranco@gmail.com>
Subject: Re: [PATCH v1] board: toradex: verdin-am62_r5: Increase
 SPL_STACK_R_MALLOC_SIMPLE_LEN
Message-Id: <171113556974.2191577.8759982207251552650.b4-ty@konsulko.com>
Date: Fri, 22 Mar 2024 15:26:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 20 Mar 2024 13:48:45 -0300, Hiago De Franco wrote:

> Increase the SPL_STACK_R_MALLOC_SIMPLE_LEN to 0x200000 to accommodate the
> size of tispl.bin fit image. With the recent upgrade of ti-linux-firmware
> from version v9.1.0 to v9.2.5, the size of tispl.bin fit image has
> increased to 1.4MB, causing allocation errors in the R5 SPL:
> 
> ```
> alloc space exhausted
> Could not get FIT buffer of 1325056 bytes
>         check CONFIG_SPL_SYS_MALLOC_SIZE
> ```
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


