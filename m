Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96B1CD98CC
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 01:59:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7989E848A2;
	Fri, 12 Jun 2026 03:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e7wa7cnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2F1839A8; Fri, 12 Jun 2026 03:59:15 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 666FC839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-43d1470491aso277723fac.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781229552; x=1781834352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfNVzcpcVgv883/o+JOLPQ+SxQ8vGApdE3AzrTvvOx8=;
 b=e7wa7cnSppfNtJY/179kuDHdoSbSCSUlb2eNqPEDET/N0ciN5t9u+16CQvILaawESj
 la6y9lXfsirhuerWDvayYHYjM734FgBVQPWLlKqNsBdXKToCMnxY75+9QugxgQzQHDsQ
 UAIpB4Fa8KJhbUFd/MHtmQX0P5QBuUGtO7H9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229552; x=1781834352;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IfNVzcpcVgv883/o+JOLPQ+SxQ8vGApdE3AzrTvvOx8=;
 b=EH8N+anJV91PsEBqXJ+440c/LwfB+wN3GSxKcwaD1p0OB58G4nMj85vhhyfEFC2WZ+
 E9i0lkoGzNANYeJCZNTpmz+YXqdOX3IVtti5giSlwEeqVuBodcj1i3Qs7yr7J4vBtAqh
 LhieKjZ0wWHkKA6Lrn9xiIH6/oHePxY0EK8dGEcwVC1l5WFD9XbkM0yYmh2mCUAB0Pqa
 R0l8FxB4kdbdIMqEatO2nHQE1YS+L6Xez9ygZIhjGzwk4SHi/hK/Hox+NRKLHTZ4LvOd
 0gxjQN989Xpxn+36QMqlMG/EbrTAVZhrIt9POUU19YOFJH/Jb4syb8vLzQvYys+Yl1gG
 8/dA==
X-Gm-Message-State: AOJu0YzMxx/BJ3fxv2xfC/xlkM/kCOhEVlSATJ+OSPMpg8UttsOQ3UDC
 AlXYh0BvRgUjsLL5zVI42qzdLmNNcn4bdGHf0CZWbpPZQ/+FuaGMdQxxI3nKhdlrOv8=
X-Gm-Gg: Acq92OG4oqbcgbgS6xUmkDIrAVtMhuJM141yMw+FS0AIs+cY00xcvj69Rv7doYADm24
 MuzAK3fSbUdsTYNxIoyGMawF7le8XjwnrSKbPaioMv4ip+/F4oiHNI/zkLwH69x1s75Y6i4s5lm
 19KJlHgg8NYoAdvPLkkeg51xJmpa13+DsPNTY6McgIrrDb9w8elFln4flRF8h2Fgz3Z3GpF7HLx
 5ZoMv/AYCOtQ3jr0R+7G9HdQH+ynCSA6kkb880E5L8MUAoieqG3gfoyqted4QyyhnnVF0UWZPYI
 2Lq0/HtLaDS/nY49aGhNE2OwErk6oeKdiSyjDGI1NpNACjg0cIScZ2kpCkA2Q2yJl4gs224l0mc
 /Vhs+I+7C8tlcs+QrpzbEeDsn5ABpRKTrKhlGFCqG1SUzOZloYizmlDMB/3otHNz/f5c6bFlU28
 uJ5cEdjI+saSuYdVD70YqdXPUTE60ZPJv1iKrAb8NzovgoN+REdjLy9ZVHK6+uiTYgi26OGnGOD
 +aXSr1ienJz4wHARaJFm2SE8iNsHHqPbZWpOYVpqheyUlg=
X-Received: by 2002:a05:6870:d254:b0:43b:973f:185a with SMTP id
 586e51a60fabf-4426e15579bmr383959fac.19.1781229551964; 
 Thu, 11 Jun 2026 18:59:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426abf184asm534734fac.5.2026.06.11.18.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 18:59:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, bb@ti.com, sparsh-kumar@ti.com, p-bhagat@ti.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20260507123127.1518673-1-s-vadapalli@ti.com>
References: <20260507123127.1518673-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v2] board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA
 resource sharing for CPSW
Message-Id: <178122955096.605671.4813240526962252452.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 19:59:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 07 May 2026 18:01:15 +0530, Siddharth Vadapalli wrote:

> The CPSW3G instance of CPSW on AM62AX SoC provides Ethernet functionality.
> Currently, Ethernet is supported on Linux which runs on the A53 core on the
> SoC, by allocating all of the DMA resources associated with CPSW to A53_2.
> 
> In order to enable use-cases where the Ethernet traffic is sent from or
> consumed by various CPU cores on the SoC simultaneously, while at the
> same time, maintaining backward compatibility with the existing use-case
> of A53 being the sole entity that exchanges traffic with CPSW via DMA,
> update the DMA resource sharing scheme on AM62AX SoC to the following:
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA resource sharing for CPSW
      commit: 379e74323d328dc7df16cf406e237d6187b1a307
-- 
Tom


