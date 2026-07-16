Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E034C4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 23:25:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D0A84DF5;
	Fri, 17 Jul 2026 01:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sxRkQ7aO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC1E84DAA; Fri, 17 Jul 2026 01:25:17 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4506284DC3
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 01:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-455ca262ccbso3619554fac.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 16:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784244314; x=1784849114; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xr2pXPPujqFWubQ0Hee0rpQRN9YAQZyQQKnanHhWEJU=;
 b=sxRkQ7aOzsPSzQ8wwvGsRjsRCCDT/jao3DqEHqbNKsSm2HMTj4SSQJ2dUoTa+7fvDI
 pg7Tx381GYCER7Qqx3DQGDFzBRyKyBMmgvfR70rvCxIRrXiv9fV1imDv3igYWwSVhciP
 WKlSvgRiMmuyJ9mi6OD+v4cXgJzQQSdT1qgCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784244314; x=1784849114;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xr2pXPPujqFWubQ0Hee0rpQRN9YAQZyQQKnanHhWEJU=;
 b=DauXGsfMqNcqh/U1hVTNtRSBCrmgV75dGtYWmw6F0lptgRtc0dpuzjLyb1HSrWAijV
 GoeXmq0nz94oYlRZfd1odHgmLcvH8HGzQ+3R8IOiOtNByB11l8o8B+LvDWQCF1dCTOEA
 8Xuo9VfOL0/f4U9iHk6ORg9wfqZepT8j4kkNY4+tPYusX9WjSj83NnKI/Oaw9AISIjOS
 k3PPZDq1WotniyNJRGf3YA0z+CM7gWFC6ARYpDzwfcbHw7EQwc6/R3ree1w+Q64oAvsX
 y5AAv3WAY+PI5tbgNHImTJE8Uqp6mXUYLefJ3w34TZ9q0BPK32bOcVz+QybsfuaGP3T9
 jvzw==
X-Gm-Message-State: AOJu0YxQy2i//fswruniWlF5d9zmZcfvJ58UDaBe3c4tRMq6oQWfaro/
 6g6y4FJhd2gpVXcUx99v6m1B1yi7DHbyQP0Dor1rnuREH05ZyHUvDANXF0svZzrLUgg=
X-Gm-Gg: AfdE7cnLAqIZ3xwAy3Rm0KiIw1s8omCYDacNqnFT1koEF01OZgz8lxe/UmnUCC4JCUd
 dZJdw9bBcJUFFzMSuk1B+I181D+DHsBsXHRY4sIQ5H+GbkLEf1ySARJPePXwe1RgeR8L1lJrM24
 jVRJanh23iIF6rKHzoRHZjOagWbRwt607G/6Cc0KOnYSxKTXxg76E/JtyL8x7k8yE3e7eqNIDfq
 wT8UC5x02/hbSpqyPU/wT6lLGB6CgnTOlyv75gHxDoAd47TdWfdRik97sze3bBy4P1f1HPZAYKR
 NvkohRD/rbP7pn+WyRv3wOKuFCF/74MUuK2i0dvZ/zag88ai/CJLAGmo96vBIO9tFKwQo2qLj8V
 DGp0jDb7Bu40oOxwhd9F4hWiATEyEDtG4/aLDoU+7aZW2wZN4+Abob/Vzr71MoGedLuLLq7Sfif
 ReVck7cN/efcRfLeHyiEOhM77Mw5e/bR5xtN9Yf+pYrBXXiVz2rJZX62BtpNIgwIwZFy6lCUVPx
 HqTjiyMNVofzLzOOEP4FdUwJw==
X-Received: by 2002:a05:6870:968d:b0:448:84c5:ba5a with SMTP id
 586e51a60fabf-4562b69fa3amr6050344fac.24.1784244313937; 
 Thu, 16 Jul 2026 16:25:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4568da4ab47sm27308fac.0.2026.07.16.16.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 16:25:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Paresh Bhagat <p-bhagat@ti.com>
Cc: praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, msp@baylibre.com, 
 v-singh1@ti.com, anshuld@ti.com, afd@ti.com, m-chawdhry@ti.com, 
 joao.goncalves@toradex.com, bb@ti.com, n-francis@ti.com, 
 sebin.francis@ti.com
In-Reply-To: <20260701075021.3626094-1-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
Subject: Re: [PATCH v2 0/4] Add DM firmware reserved memory support
Message-Id: <178424431179.1470194.2877717920905276533.b4-ty@konsulko.com>
Date: Thu, 16 Jul 2026 17:25:11 -0600
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

On Wed, 01 Jul 2026 13:20:17 +0530, Paresh Bhagat wrote:

> This series adds support for DM firmware reserved memory fixup in device
> tree for K3 SoCs that use separate DM firmware (K3_DM_FW enabled).
> 
> The series includes:
> 1. Fix for phandle corruption in FDT reserved memory fixup
> 2. Enable OF_SYSTEM_SETUP for AM62D2 to allow device tree fixups
> 3. Add Kconfig options for DM firmware reserved memory for other K3 SoCs
> 4. Add DM reserved memory fixup implementation
> 
> [...]

Applied to u-boot/main, thanks!

[1/4] arm: mach-k3: Fix phandle corruption in fdt fixup
      commit: d3e287405f0a0f9683f9c6c49e84495ea18d9f01
[2/4] arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
      commit: f16e4c80040c2d5186ad3cfa83c469b26adbd46f
[3/4] arm: mack-k3: Kconfig: Add DM firmware reserved memory configs
      commit: 5e2be9f5ccc4ca3c9cd326d4671a853b783adcae
[4/4] arm: mach-k3: Add DM reserved memory fixup
      commit: 0cceea6e449888f4422e674e7157696d382eb686
-- 
Tom


