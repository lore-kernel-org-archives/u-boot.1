Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2207FA3728
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 17:10:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DF168424D;
	Fri,  2 Jan 2026 18:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ERbGqJxi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3A484248; Fri,  2 Jan 2026 18:09:58 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AC683A9A
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 18:09:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-4511f736011so69499b6e.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767373795; x=1767978595; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXzSZ6+Y7bz3azVivP8th0sONyTY50ofQTAmGe41kgs=;
 b=ERbGqJximiNstPuMqThOR/Nr69+YRHlrbLtbnJrpLl8vX7X8XwV1xURxXyKsSlhsnW
 WN4I0WB2mnGQvZCGkW5d4EQEDmKJe9stPDWV1N5vUdZsKfdj21jW3ztSsFFZTOzu3lwJ
 pjKlnTsp/K9NYZEAgefLRDBWJ+1s0hC/mgDJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767373795; x=1767978595;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YXzSZ6+Y7bz3azVivP8th0sONyTY50ofQTAmGe41kgs=;
 b=lV5hVT8UZGFXINr/krsZslLTj+e1LcC3Qg1Q0H9gfKJKmf0D1Hf15Jf9CVMf9Q++kW
 kLhu3tEfRPFB55B+66uPjhsr7dc2m4UsZfcVzN12IhgygGgxR9UG7X6av/IOCR7MxMTR
 FdlmFb3Lfmf2mLZXx6Y2eyWIQqLrjXCjvSbXx8OJS4FYgNfrbeklFaOh3uUVKaKoXTiZ
 6Uc+v0KLk5zMyuq4qQBCLYHrKSoW6aG3ANnHVTLuqvFBnnedOPbfI5wHwK58jnO4XzD+
 YqCcjRBBgB7Xcr20ch1hghjBg8QdnOjfTqLaB+S06+wCL9kWMC51A6LNteT7pIVnTsDc
 GGTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdEFyyYGWTZYECUHVBMsM/X1BK45JXwZclW3oAti8nLfkgzx2DBgIDBr61teiMhU7Fv2Yi3TI=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3r4I/ZpbxojIW3Pf2tZ97BUdGBe/u9+vV/rWIUX8vTsEFCtal
 F1eBDbsGMVUvE0FLkG9ObHJF5zVCFZv36efeMeQ1hEHtDlarKCyBzH0G5iH4/tacGFU=
X-Gm-Gg: AY/fxX5yuvik1EWeEcYfJDhbuSi6tvFygxB+wz1g/UnRPbHY2rTi156pHnMQeDBYdLD
 wxmPYQAig/hq8Ge0euMnZhF3k9szXdQqndnoRRDb2CNBGYjVAsUIAUbpgYMUjGTKLKY6iKTgFhG
 dehMjGL08QGPcsKwepniWopIOAuqbR4lWOqOzLz27U0Hf1pwPOwYOAyZdFUpXU3cY0a5JWWn959
 1gcbQuzqsDwsCnyS9Z287rI9R8PARNVoXPbwN3qrENivLO8TDSzUjjTVwsJre1OxCrjg9YMC0ie
 cesVKxeeZQ588Lc9x7jqv6sO/rfhfb5sVrs6ISIIqi9EJjcRpbG/MYkeZCM3cHkTQpXFqlTXdAk
 nnHj2XdN9k3OoMkkyag0sN8Qnta07/rbSzgPw7dc+IOSArNNFVbGMs0OefWD53PnwygJzyl51Ho
 nS3Jhbe5drZdS6HCa8sgalvOrr33DVWPMU+SST0UszDvGJJeRl2zix0NXC9h03N429ZVUAos+Ai
 dlDgo9pQvZxocQ62RWuRfBClsvuFIOggtODWg==
X-Google-Smtp-Source: AGHT+IFqlrut0G4xwldcYz8RtR734c0zutiRUNrsYYuTNzV8sS2lW+H2+3WSRSAtON4lGNU29Qok6A==
X-Received: by 2002:a05:6808:1483:b0:44f:8ccd:c489 with SMTP id
 5614622812f47-45a26dbbe08mr135125b6e.25.1767373795175; 
 Fri, 02 Jan 2026 09:09:55 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4598c356623sm14512228b6e.2.2026.01.02.09.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 09:09:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
Subject: Re: (subset) [PATCH 0/4] Fix CONFIG_CC_OPTIMIZE_FOR_DEBUG support
Message-Id: <176737379393.117620.5816720928915086730.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 11:09:53 -0600
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

On Wed, 31 Dec 2025 20:10:50 +0100, Heinrich Schuchardt wrote:

> When trying to build qemu-riscv64_smode_defconfig with
> CONFIG_CC_OPTIMIZE_FOR_DEBUG=y it became evident that the build was not
> using -Og as expected. This is due to an incorrect update of the build
> system with commit 5f520875bdf0 ("kbuild: Bump the build system to 5.1").
> 
> The first patch reestablishes setting the build flag.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support
      commit: 56ae3c2a44fcd8e2f680c51620011273727ae9db
-- 
Tom


