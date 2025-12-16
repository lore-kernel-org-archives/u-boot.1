Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A3BD637B3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6B083A83;
	Tue, 16 Dec 2025 22:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b8JZGJG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D0A83A7A; Tue, 16 Dec 2025 22:53:39 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D47083A24
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 22:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-450b5338459so3135245b6e.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 13:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765922015; x=1766526815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJlwiTu7f8Pd33Pt/Ne9JwHhxIzKDI+Ah3s9U1a1xL8=;
 b=b8JZGJG3IstDtvKi8Es4ykWbJHfpR8OBZsNIPHPJP3lzvbCfVqhlDDjNx/Tr2zXBMS
 s96o79Bi1pmnf/jTV8LznT+ej+3k5scVbZBh14ifeznwtKQhcTe40/6ZUDP8yvvnfEfu
 RyuES0El3LR7KohBA5GY/Sd/vrLtf+qajKzAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922015; x=1766526815;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJlwiTu7f8Pd33Pt/Ne9JwHhxIzKDI+Ah3s9U1a1xL8=;
 b=rUoRs/9eLd5hPP6EyCiGVeG2f7rIFaE/P1yFHvBuHXDt0S47zNA84buiyQHVY+1gse
 yA3BYz1RHKfpOMAZJLc8zICK4x8B3OzT/q7jGJ+gvFL4PhJaEsfXKCeHFjzgjbXO2ftB
 /vHJkxAvyu7iYhytOtPLzwyb5WCwQ3+Ry3kS7+TW1u0LAgSn/h05vBY+ea9uGAdpuXNq
 DII79Ci0yHDLxo8aOgkVdD3kzAn0/pGuFvu7B6UDnKMYQlPaDry8B5E0xleagOKCdgMR
 qtVBxwmYoz61TphscWxQFJLw5bkxLw2KtPCKDc2/ExMRxGzeKTY4MDaJz/VFXusdWG1k
 SRew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkSq+C+aRPbY2pTWzQQERAQo+7czDl95xKAmLw8w/G9DjIrR9mLfuMrCZKNgwB68VgNhf2e2U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8wOlqm9FOMigYyihjCLqZIqZIJXk6SFyAq8vKcPHYIJDid1jL
 4sWdY9gxN/WLajx32LOctY3dXKpAaVkx4HtDWzX5aqs5nr8PPcEoHmldnhGQ/NmhzBQ=
X-Gm-Gg: AY/fxX7yHAsfT9QencK1/Hsmd/0D+qlOuP7Ys2JM10DwoH8iGBG6bMuR7U5udE+IVhk
 WuDUnY/cpsLnC1vAIEhnBwfRAabXs5Do2aAC+54io8escBW5+kZ7PgWNmpZ6iEd9NnywYqPZcAz
 vKwnEZiLVVxPuT3dLMgnT5wmrGzuYU7cSFFePFy0qcsAmtmVAR2WqK9ZzL0I/JuOB3mOO4EulRm
 8Xj81w1tWQqnBoi6WZidbg+/5ZZALIu8VvMsSZluR1XKS4kxM7GlYZOVV03tPUQ0DYZ9dhdoRvz
 hrI0bZDuBA8wYZ7bnWM9sUpecZa7MnNtMR4+zjeVB0WwIwSAQvoVSoDjl8li4TbhdAcW146wmyP
 wsE2n72MDklePePZ+tkk0/9qFDmRuUlrSRZ7RFWmYggPt5mwplevA9dT04EcAFtj2GoXzL7/64A
 PHg/509RJ8ZRmxvZppRLps3fuyg9DZJwyVQgkMeLiP+b8tcDpx
X-Google-Smtp-Source: AGHT+IG9M3/S1fPT2XWFeqPCHmr6a2RKE8Hnwbsra7R7UxcA9Cd/FK19rQKKTMD20op3Wyw6kNhxqg==
X-Received: by 2002:a05:6808:384b:b0:450:ca65:ef59 with SMTP id
 5614622812f47-455ac89db2dmr6667416b6e.30.1765922015465; 
 Tue, 16 Dec 2025 13:53:35 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm8814255b6e.9.2025.12.16.13.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:53:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
In-Reply-To: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
References: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
Subject: Re: [PATCH next v2 0/4] fit: print conf node compatibles + use
 property string constants
Message-Id: <176592201423.2225391.6508157052767689143.b4-ty@konsulko.com>
Date: Tue, 16 Dec 2025 15:53:34 -0600
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

On Wed, 03 Dec 2025 17:19:31 +0100, Quentin Schulz wrote:

> This does a bit of "cleanup" by reusing constants for some FIT
> properties instead of having the same string in multiple places.
> 
> Additionally, this adds a new constant for the compatible property in
> FIT configuration nodes[1] which is useful for FIT images with multiple
> FIT configuration nodes to support multiple devices in the same blob.
> U-Boot will try to figure out which node to select based on that
> compatible[2].
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] boot/fit: use constants for property strings
      commit: 634dcda25924567d000396542948fc33c7e8bc1a
[2/4] lib: rsa: use FIT_ALGO_PROP constant instead of "algo" in FIT
      commit: 883359e152d5000943411ef7d2daaec6c137f47d
[3/4] boot/fit: declare (and use) new constant for conf's compatible prop
      commit: 3059eb0c27dd1b4a40a06bda4a47e10246185aca
[4/4] boot/fit: print all configuration node compatibles
      commit: 6c7d3ba292c648c9075eb0b82278a844bb1ff953
-- 
Tom


