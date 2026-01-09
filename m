Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04EA3D26D81
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 18:08:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC888436C;
	Fri,  9 Jan 2026 19:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dmalfSm+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A3D8439C; Fri,  9 Jan 2026 19:08:37 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEAF884206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 19:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-459a516592eso2973474b6e.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 10:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767982109; x=1768586909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9rYyEwIXpxK0HvUWaFAv0ndc+Jmpt6FJ4POwwVmgyc=;
 b=dmalfSm+GdX38JQAKGOxkedPkuZZCATA2xkhHgutMExELpKduHeSvUU0oN7Ci61OWF
 efaWz455fiQ/RCBI+9sgPuig2t98u0nb4sAruDmgDg0A1I/bHGYFyPccO15moUOKrsMj
 I8i+qLKKKL9g8TaJLxZUfA45BKb763GJwDbhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767982109; x=1768586909;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9rYyEwIXpxK0HvUWaFAv0ndc+Jmpt6FJ4POwwVmgyc=;
 b=Vz/5plnNMqaYRa9i5Vq4swYQR8FYmBERhbtBY/Kd4NFl0Y65CNSwEfVkU+q6hjqGLD
 4I18zZM4VlGZyhwcFFsfdN9MJnu+/r75o0uyglEWdlr/yoz9f7GJgfAtxQtPL/U0Bb9r
 cbBqqDoz5Qwaxxk0IRb5GzVyC1OY75YUiuEC6WVTGkkJUxUp8fw2zMIdVeryun2D/rEs
 dPtuCqMHO8ZX7yQ7upQHYhKJy60TaCHmMocoBRcTt4V/8aY/BROj+xtc9qZmO04VsK+d
 s0iMxVlMmMy11yUtQjz/Suo509DHM0ES4H3um3woz6yPxcA1cbAlhzpHy01mQxiFDVXK
 6fAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMrDeixqpSh4hlNv+K3PiBDrnTr5zazgCIv0fgNvo2ThvITZria7E7c4yWu6hneHff1l0kRO0=@lists.denx.de
X-Gm-Message-State: AOJu0YxWJMDqNJh3rmOrGPoCmcEz78MO9od3Y3aUV3gNGd2hcO4QVz6X
 2n3vPzVnlLXd89zEN0EAWHhAPBMtMTF7FauNfD1IeOmarEKLW91so9tCpQe4Lz+1TZ1THboGg36
 xwPoY75A=
X-Gm-Gg: AY/fxX6uku3/BZjO9ajQtG0o8GZmpm61ctAiIeXnMr2a7b0kTUPAV/Cr+6QuyfUJ0iK
 eC7VK+oG6gBuVxhAz53s5Y3DgEdL+yFnrzfSHJiRwGcduafgRTJoe11nheWiZS1a43QqEa44Qna
 NW2/hdtjpxVSYPasczV3MNb8Q+7nlUs8lwpDqTP6nL/ESrixfKNwnQ9PYeVk/FVhipnbzitznli
 RMj3fDv9t2RS3p/YsQRKNW2YvFVkT3pTOU67CS3FP7nBKTgODQvu2Pu3fniRIDOjqvF3RLB68kY
 dXGdwKGK/lY9ddGEZmF/jMhuEuvKw/Jbz16kWksxhe6f5H5PHDoO1xnPRwXASZU1IF64U1wEwsM
 sFRGCbsS10d6qXf8wujRNRjBvWAYn13pT8maMMLA/3Ul7UBWlyb2Aa2FDwAhoxSkF6a+I2Vj4do
 TTXYueIscHD+b9BiAdD1pLyTTekxr8NcvZ5dEmUWvvBTy9yVLDQrDQj3eQ3msNVVxg64sZxJWb4
 1z44fFW44RQQ0mPQd9+3Bwo+lqRpJ98cm0JOQ==
X-Google-Smtp-Source: AGHT+IEDU2qc4K1EhK5jbuG4bN4rTe/oNRGXq8+OJSL2phXilA56NvAYj6mi1Ky/ec0qILKJF8EmYw==
X-Received: by 2002:a05:6808:50a7:b0:450:af35:8b1c with SMTP id
 5614622812f47-45a6bdfc0d1mr5264162b6e.38.1767982109316; 
 Fri, 09 Jan 2026 10:08:29 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45a5e2b74a3sm5056992b6e.19.2026.01.09.10.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 10:08:28 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Stephen Warren <swarren@nvidia.com>, u-boot@lists.denx.de
In-Reply-To: <20251224080314.17188-1-heinrich.schuchardt@canonical.com>
References: <20251224080314.17188-1-heinrich.schuchardt@canonical.com>
Subject: Re: [U-Boot testhooks][PATCH v2 1/1] py/travis-ci: add
 u_boot_boardenv_qemu_riscv64_smode_(acpi_)na.py
Message-Id: <176798210837.1451314.4007621740567760511.b4-ty@konsulko.com>
Date: Fri, 09 Jan 2026 12:08:28 -0600
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

On Wed, 24 Dec 2025 09:03:14 +0100, Heinrich Schuchardt wrote:

> Add missing boardenv files for
> 
> * qemu-riscv64_smode_defconfig
> * qemu-riscv64_smode_acpi_defconfig
> 
> to enable network testing.
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] py/travis-ci: add u_boot_boardenv_qemu_riscv64_smode_(acpi_)na.py
      commit: 822a599deb1ad28a1a348fc4d02e6f351c27352f
-- 
Tom


