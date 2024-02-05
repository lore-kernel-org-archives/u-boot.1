Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F289C4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 22:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4B2D879CC;
	Mon,  5 Feb 2024 23:18:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nvhJbE5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21E8587AEC; Mon,  5 Feb 2024 23:18:59 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 114E4871A7
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 23:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-42aadddeaf8so36734911cf.3
 for <u-boot@lists.denx.de>; Mon, 05 Feb 2024 14:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707171536; x=1707776336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d8xqkLS2bGpCdHrNmsVyyBNzAEHJRmf6IO2kLF1PCOU=;
 b=nvhJbE5gOrfoviwnOyKL9lT4D5eBNWMFCGNryYaZYQl4yNjn9XnK4GPhNqJuNPhjx7
 EqIWHYdpOmKD4VYsWLFQVfWeuX+l6RQNgTlvk8LBJY9HYjGw41n2VvZyWTk04LM3Yugy
 wATmSzej1x7j4XsefOPxVgd43eqSHrHDSp4pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707171536; x=1707776336;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8xqkLS2bGpCdHrNmsVyyBNzAEHJRmf6IO2kLF1PCOU=;
 b=oeIDeRTL7hVxH3x2a4P4PkeCITuthKWzVd6wiBjvBXUXd5a7RlnoVc9+UR6HvQXZyT
 hs5qbIM8/xgGBFohJr5Epj8OsalyHRiw0fvu0nLTLxRmi8vLNSAN89VL3IhXivODqOGm
 A/LEyU2UxxlNx5fIQc2zYPNKmiVy2hIfky/Z0oWIwqPWgBOQqhZM+c4xxkeHkJnnIpT6
 txm0YJ0Oo6yILTI2ziWh2/KaG4Ov3R6MTlWkU+GZYYnqBzMFaNjmBrfVJwBIm0W60s+h
 qilprm87LO9AnRZrCr6yjEvWya51RRw68x6ALIigr/6TuGutKZk5aU/u7vJrrY5w2p8l
 klxA==
X-Gm-Message-State: AOJu0YwCqrunb1Xr8+G+tffh5ivYSZPcPjDYmCH4quGKHB+LtVeZJboc
 4y57BRkUEa9l7NL8yC3tzVxFxhuscDNWJSxQFJ1DkR18cVogKE8+rpJ+qrvsVqX8WJv4GRGwDYN
 9
X-Google-Smtp-Source: AGHT+IGDlYrWDNV9GoD2Cvj40G04LEhVkFNBWA86ywmQ93E3JicydO7sV2aEZk/3q7OrIFGHjeMcBA==
X-Received: by 2002:a0c:da90:0:b0:68c:4632:b71a with SMTP id
 z16-20020a0cda90000000b0068c4632b71amr608001qvj.60.1707171535826; 
 Mon, 05 Feb 2024 14:18:55 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXzxTKKnGtLiVvM1Fhytbg+ujWDNCNPZvIezUpKjSB8lgaFAJG66ziF2PrylZFkXHYVAbcs2s6duPo2tiZLLKegiUHnAxJWAyhqRXJxyICJE3Wc1e49jfjyqST4zcEKYKVhLX0JnP7q
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 nw3-20020a0562143a0300b0068cb0e575acsm121882qvb.55.2024.02.05.14.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 14:18:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, alexander.sverdlin@siemens.com, 
 Enrico Leto <enrico.leto@siemens.com>
In-Reply-To: <20240124144355.2040380-1-enrico.leto@siemens.com>
References: <20240124144355.2040380-1-enrico.leto@siemens.com>
Subject: Re: [PATCH v6 0/7] board: siemens: clean up subfolders
Message-Id: <170717153519.1633660.12546835964476907187.b4-ty@konsulko.com>
Date: Mon, 05 Feb 2024 17:18:55 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 24 Jan 2024 15:43:48 +0100, Enrico Leto wrote:

>     The common folder was initialially created for the common parts of
>     the products based on draco-am355x board family. We have the
>     product lines 'pxm2', 'rut' and the base line unfortunately named
>     'draco'! Adding the new capricorn-imx8 board family, the files
>     were enhanced without cleanup.
> 
>     Simplify first EEPROM probe and access that implements both i2c
>     with & without driver model. Use abstraction functions for this.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


