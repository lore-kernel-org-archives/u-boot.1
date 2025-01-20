Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEF2C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 18:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9A6380759;
	Mon, 20 Jan 2025 19:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HRiV3Sm1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9975780711; Mon, 20 Jan 2025 19:07:33 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81466806F8
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 19:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-467a1d43821so54547131cf.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 10:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737396449; x=1738001249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euYEV/jBvgwkbe7Kl5F6ZbCr672HrHcwW47n5CvzGWw=;
 b=HRiV3Sm1JbzNIg+JkkLbmC0koQLKU1CQAgtMHEta+Pfycf3TX8bREfjvfo/ESmNK+N
 YZQepqBz3NRaaXSj9osyPHQXFfLl1BAvzmk0cd6akmWj6WB0OlL1bnFC2y2p5FDiet97
 CNFuSco5Pe8uXsGeEGNPgSWZE+NGYma/IR8Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737396449; x=1738001249;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euYEV/jBvgwkbe7Kl5F6ZbCr672HrHcwW47n5CvzGWw=;
 b=YekQEP4WQCDRYAEgQ6v2dFKzh5Qm41Dbsj+u0Fn8SZvqDvcrVDH/5n5NVfZsAray64
 ENgmBbySGIpEdbvs71dwT7jBC055nw7McnAGD8uL55ejx603QTjAVeUjX1xngt5xkpll
 LTqRHZz2tPweEIXzuRWPHeivV7HUhToUBY3dPo1WRj0RCzfP1zzIw2uC52GxDheFnTsq
 06UK5cgUR28PDYE5nIbIORokgP1xHoifBwlqGiNa4mRPLjLn7d9iVmVDkoK7jDsaZPSP
 NJhZdDWKcA9HHDuWg8fwVsRJFTLMxMpPNnN+70aKciZw+C6NWriqO6Wi46YdhUJ5p6GQ
 VM4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQRadxhhbG723AAAQoxOmeEew2C60p7Iq1Njf0Lg40ABm47B1YJ5e4o6FnJ8pze0yL5SSoSc0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+Vzhbeuam+k0TvcXxCLuVkJmCgABpCcA8YCvPPdwqZcfwalso
 QJ49g8SUBUUF1i2i9m0RKBBC2i3JeICukGZP9DA70lZ8eP7XORd36wHtivj4ZGo=
X-Gm-Gg: ASbGnctJiNIgfy2IeELsNajkzE3cIgmJMzoZQYRgYuunFLLuxzt0LcL6YdSN3xKyTRJ
 qkwrKE4vX0k6WHMFBbM/M0IHr7HLp9kN3q01nqt8uWEHVbXhGkLz53XDZQVgU+7jN12vl738EWY
 izAxdHRV2j7Vm/tOJ0aEW3Rvn83nuizGLC+ROTo/hwHxxLulF6dfh/17+6jtDDIpJ4d+rAD3GoA
 Jr5Vy1pPmOJmjSFKlnXDF7tPHlFQBs7udKbZO/5puh0lKmZDAw0HbbDbjJEt+jiUg==
X-Google-Smtp-Source: AGHT+IFti20UtNdvwgVGeM4+YIk++v3HXU4iYq4OjYb2Fmf14uhNg2b4Pr6ychF0UILN3D6cnnUsIw==
X-Received: by 2002:ac8:5887:0:b0:467:5734:da89 with SMTP id
 d75a77b69052e-46df57d3376mr384012641cf.23.1737396449309; 
 Mon, 20 Jan 2025 10:07:29 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afc230a4sm43258946d6.50.2025.01.20.10.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 10:07:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: vaishnav.a@ti.com, j-choudhary@ti.com, Beleswar Padhi <b-padhi@ti.com>
Cc: rogerq@kernel.org, nm@ti.com, n-francis@ti.com, bb@ti.com, 
 u-kumar1@ti.com, afd@ti.com, hnagalla@ti.com, u-boot@lists.denx.de
In-Reply-To: <20250108102516.2103132-1-b-padhi@ti.com>
References: <20250108102516.2103132-1-b-padhi@ti.com>
Subject: Re: [PATCH] board: ti: j722s: j722s.env: Set remoteproc firmware names
Message-Id: <173739644730.2747182.15124370057806392137.b4-ty@konsulko.com>
Date: Mon, 20 Jan 2025 12:07:27 -0600
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

On Wed, 08 Jan 2025 15:55:16 +0530, Beleswar Padhi wrote:

> Include k3_rproc.env to access rproc boot commands and specify rproc
> firmware names for adding remoteproc support in J722S SoCs.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


