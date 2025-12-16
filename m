Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9127FD637B3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 21:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CF9D83979;
	Tue, 16 Dec 2025 22:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EE4Vldkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFE883A2D; Tue, 16 Dec 2025 22:53:38 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4328334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 22:53:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so4160596a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765922014; x=1766526814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmaywoRqKRGnzOkZIwqhy+jElL0uSmaYq7LwU/+thQg=;
 b=EE4VldkqUqO/g89R9Ze5LVsaaOcl/iZ3XNIFq9Mz6oVjrAe99IFYwxYkjnAWkK/qZc
 F0kcc3xvvKg78vG5Je92it+MlijNNTnrWJ6bEqVIrgl2FhubAWMFvpJJmVOVDo5OQI+u
 1E/NxcA+skmf1h8pK0BIVXWxq1lWN+iOW0Mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765922014; x=1766526814;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GmaywoRqKRGnzOkZIwqhy+jElL0uSmaYq7LwU/+thQg=;
 b=tijJ3T3NVJPTOexHz1cKSj0sizLS8vQrjPYHh68mVqja6ZgqwbHUp0n997vJQuZBwO
 7gmGj1BJe8CdAgBKYMs+SgY4IK6i/00+tAk4aSBzGRBTlG1NPza5PyS5ye1SLSzlmcjT
 Q53vDFpe5eMmXLj5KdiaUha3qHhxkJY4r1PXnyUkkgT60WScofsd2yHmAdse9gnWDI8t
 BiC1DrdXCzi5j6wubpUCz5QAGaepzq1fyKLKLIEG45HXNpOyu0FLBMhghBpp7x5Otcuu
 UMJ1mPM0KDE8yuYXRbYXhyoARxnkfF3UB7UCQaO+ONUwsr/MwMXl4a0+vNKE1QeyWGAg
 +XsA==
X-Gm-Message-State: AOJu0YwaM9aCxfL5pMTWNIvAB9OJKdfDXARGGgkdTYS+dlLIV2MkE/7r
 14/JiB7OFqYdxvvvfbTJbrpyPavqGNwpmqr0mn3B6g6UsqHjeNojmLGy+ILvtcqGpWttBDNnsXY
 axDdLNOc=
X-Gm-Gg: AY/fxX4Nle5xky7oyFRB61UBwtYLlz7k7KEf+KP/MbwtlNygNzbLf2h0JVKyOcUdYOb
 0INrhJxvewMQ95KN2m/3GIK/AXhV54MpHfxvSjtcFykv44GmHfTbuQgyCWQG5ouYiYYUwKjEZnv
 DyIEXG27t3UbQiVt5TB8TpPsI8FHR0zcIE7EP2KN5LB73ufdaOVcTeHiFAqj7r74Oq8ljxegh0s
 ZOdLc4f+OxuFfdbo/ia//1av42UOYgLNFfSwqjPG4pYb1cWnU46U1U1UjDLUq6ECpXJ+mJHTaW+
 1wd4DiO1YxM9ywOAj3nBOdpDyng3RqcP+iqL5ZZyUEnhfntcdwJTL0CZVBSPwD+bUhVKS5iXOGl
 s/eGPbAXkDwXpjIYguLr5WBVDbahnH7tT6J8bBRRH8S4b4+u670RVACjR0J5qF5ntJI3hVqmmIX
 ph3VKcs/p+BAym+Fe64mNC8/WbNlTpAGuGtw6hNLDJuvtqE1z0
X-Google-Smtp-Source: AGHT+IGIa/ORNrtMjiE5TOKDYEycuBNgL8LQNVPx15YOOsjjyztbMc1OG2rgAv/bQBi4/I6c5/NTKQ==
X-Received: by 2002:a05:6808:103a:b0:455:d5b1:1f9b with SMTP id
 5614622812f47-455d5b156a3mr2471313b6e.64.1765922014054; 
 Tue, 16 Dec 2025 13:53:34 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598b9966dsm8814255b6e.9.2025.12.16.13.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 13:53:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Aparna Patra <a-patra@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aniket Limaye <a-limaye@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20251204-fdt_refactor-v2-1-37ad350281e2@ti.com>
References: <20251204-fdt_refactor-v2-1-37ad350281e2@ti.com>
Subject: Re: [PATCH next v2] ti: k3: abstract common fdt api for reserved
 mem fixups
Message-Id: <176592201269.2225391.3223203500803488200.b4-ty@konsulko.com>
Date: Tue, 16 Dec 2025 15:53:32 -0600
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

On Thu, 04 Dec 2025 16:41:55 +0530, Anshul Dalal wrote:

> The usage of fdt_fixup_reserved is repeated for ATF and OP-TEE for
> multiple platforms, this patch creates a single fdt API for fixing up
> the reserved-memory node with added error handling.
> 
> All k3 platforms already share a common tispl template which ensures
> binaries are loaded as per the respective CONFIG_*_LOAD_ADDR. And the
> provided new_size for the fixup is overridden by the size from fdt node
> anyways. This allows for safe abstraction of the reserved memory fixups
> for all current platforms.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] ti: k3: abstract common fdt api for reserved mem fixups
      commit: 6c8dee07c346fcca8f851e18ea554c81f3483d09
-- 
Tom


