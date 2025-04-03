Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCA4C36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D036F82385;
	Thu,  3 Apr 2025 23:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BksnIFkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA5F826AA; Thu,  3 Apr 2025 23:20:49 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC4D8215D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-603be85490bso732720eaf.2
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743715246; x=1744320046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZcHYgcyDRTUtQNBgDcN07S+BwTSo2dcJMXDMC/H35yU=;
 b=BksnIFkXHouaI9o2JtIjjLZC7OgbznY8rlMHLx3Pxawuzodvqswdtndsj0tNP9tZHJ
 rQjkeZjrDGk8aSVdl+4SGRa6IMiuCz1SbHbR9aFMb5ZI4UN00ToD60mgTFfnkVJXkTGT
 UJUXZN+AVn2Tr0pkk+MkbzsxE0MEQqYYkWU/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743715246; x=1744320046;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZcHYgcyDRTUtQNBgDcN07S+BwTSo2dcJMXDMC/H35yU=;
 b=CEX+vokkK1cC8ZoEoIhnL0Mv4mIGooPVAoHFAS8InrRX+qSXrx0w0N6IAuPnz/5EDD
 kcLGp+5JDimNj3loGgoKGshnrOblxndJ9+dSbB++5W7/GmDu8XYHNst8p9te+ka/lw90
 pLzMtzvn+S4/VAiKZghijPrLO9G3KpbG3RT2OA4qZEqhwQB2Stjmb90zxP5ojPGGrb84
 f5ni9y/a14akmIQkkvJVURgs7Fk9FPfW91rampDRH3GHca4tT2l26O0+v9h7HektNFar
 NwlUBwDMDB46cn1Z/0Mg8gIjFlBf6uvXdrHECDVYHY6ifu6W2887B506OFaNL2H9PTtW
 TMOw==
X-Gm-Message-State: AOJu0Yy7TAaxSaaCQjpanrepRO7DMtqk/NIQ4NLwGYIkadySj9UGJjLs
 4gU/t82itrCz1/EOOEPFbgqR73JtcYbjNQRMC2gdCveakoR02LaeeJsS6LEKRtc=
X-Gm-Gg: ASbGncssc8KbdYAOu0b8dsJjJ6TazgTDJayfD3EsRXUw+xHgI3TNuhpiXUrEXaz1d7+
 CbrSglkQeN9/XKMoR24v1KAB62Foor1+Ir6Op4c2yWtPLxuAuF9HVK3GtEKeh11c9miANPRQo1v
 yWbTRVGzKe5TWDx8LjVLtkFEms5BdAvyRxrBwD93q3W+CMItOAlgr/Bh9l94qZIOBWscx4RFHhZ
 ju3UYtYGAJx2je/srZsnqR6ZFI64ASUXlvsHv/P4vrF7kW+gMV2kfNUPZvBvUpxyoH63JWXiGES
 q9GzZM7nKiKYQ3ZIJPtKruNVxmEx3mx617jgdkxUF7y/XHiahqHbhNMYG0pgvksn5+iiMOfTqQD
 zqVZjjJOgPwFSi1A=
X-Google-Smtp-Source: AGHT+IF2FeCpHitrlYmAZIWQzd4Ex/9gubrjF8+V5mgTHPpAGHj0hi5Sag7rTiR/8stanGaLrlfEGA==
X-Received: by 2002:a05:6820:1ac6:b0:603:f29b:85b4 with SMTP id
 006d021491bc7-6041639bd15mr224112eaf.0.1743715246271; 
 Thu, 03 Apr 2025 14:20:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6040c4eb1b1sm386902eaf.20.2025.04.03.14.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 14:20:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, 
 Keerthy <j-keerthy@ti.com>
In-Reply-To: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
References: <20250317-b4-upstream-j742s2-v4-0-4ba88bfd357a@ti.com>
Subject: Re: [PATCH v4 0/8] Introduce J742S2 SoC and EVM
Message-Id: <174371524421.2460555.1668777832051830583.b4-ty@konsulko.com>
Date: Thu, 03 Apr 2025 15:20:44 -0600
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

On Mon, 17 Mar 2025 10:24:19 +0530, Manorit Chawdhry wrote:

> The series adds support for J742S2 family of SoCs. Also adds J742S2 EVM
> Support and re-uses most of the stuff from the superset device J784s4.
> 
> This device is a subset of J784S4 and shares the same memory map and
> thus the code is being reused from J784S4 to avoid duplication.
> 
> It initially cleans up the J784s4 and AM69 files so that they can be
> re-usable for j742s2 and then it introduces J742S2.
> 
> [...]

Applied to u-boot/next, thanks!

[1/8] tools: binman: control.py: Delete template nodes after parsing
      commit: 42ce9ed7ffef726640fa234966e8c36d39252422
[2/8] arm: dts: k3-j784s4-binman.dtsi: Clean up and templatize boot binaries
      commit: 9e1295917e48c9bb03defdde876b14ded0fa43d6
[3/8] arm: dts: k3-j784s4-ddr: Refactor J784s4 ddr file to a common file
      commit: 61b6b2fcc9c4513f8d9243e02bd872c6ab94a305
[4/8] soc: Add information to identify the J742S2 SoC family
      commit: 201b08702e3de90ba8465b34ab2445cb2fd72de7
[5/8] arm: mach-k3: j742s2: Introduce clock and device files for J742S2 SoC
      commit: dd837d6c88a85f7718b2f496625f20acc5d3f5cb
[6/8] board: ti: Introduce basic board files for the J742S2 family
      commit: 4c31c0a4ddcb57fc48f64be7267cc8ccb2245163
[7/8] arm: dts: Introduce J742S2 U-boot DTS files
      commit: 45d056e275d683b0c215543c63fa689fd07dcab2
[8/8] configs: Introduce configs for J742S2
      commit: fe36b22c3219e50e829be486619c9bd349a239a1
-- 
Tom


