Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B341CCEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 08:44:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F20783B0A;
	Mon, 17 Nov 2025 09:44:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MEOo8Tcw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95F1283B0B; Mon, 17 Nov 2025 09:44:46 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8907383AEF
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:44:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso6644955e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 00:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763369084; x=1763973884;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QU1laIzJfONbZmx4VqaOZ8yBoJWB0KY7/woptWKeChI=;
 b=MEOo8Tcw/TTYGP8yEhWnMd8/XsUtBcCb62ZZ+W1LpbULZAcsPHqevlm5GhEwCLLoMz
 akfymEsg/PqQa93k82YuGT3R3lULr1uN3w60NW1env0j0IoYJFZ11ukMLJAdezDmpPfF
 w7xb5XKWf6NVvSJiPEewnR+a5xZt62sPx0HmEzi050j8sRXClVVeBvm5qSCAionW4Y4v
 GxErKzgcnACDzjFxFRHJxVrjyaFVgOCeG42ijGfbxtfoiG157PUDIZxRkcqOFjFs+JqG
 LOW6nSUB9Hp+iZYK4UJ00bKDUtYOYVaYpV+GwD3uTZhn/dnOeYBVziM8LesxVjhLb6VC
 ub9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763369084; x=1763973884;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QU1laIzJfONbZmx4VqaOZ8yBoJWB0KY7/woptWKeChI=;
 b=OEcd0S9Ogsg8J8SXufxSlmlntpuasO+zMugU/cfYj4LehWjdjiVkkE+z/1yrWrNpuG
 xkMt7KCqmeUq5i7X6VCBh4BSs1OscD6XY/29kzmEN0RRo05a7yYG7fV7gPdQ+0qu78Cj
 NIYYC9oaOrWbiRCcb7bppwXZHBW6oxUPRyQvy5Ql1lruMRp6rytFKlck6Y4S/+0aKGmS
 IZHNEjGR41K0lZUiLovi/ePoivXeLyovwqSjYKxyU8SrS81NqzIhH+DRTq7BHFxiVa6S
 DjxNfYhvAszYJcZU57Gq8bqKHPrrc+PPx0JSnfbx8PxW2z5FPFG0F8zXF2XXPhgUeTB6
 iARw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz9aBIBN9rWs0mzCAFg9Rvi8p+2Eh4JKRqe5UqXLsZFv2sIGcDxno0vW/MFsNA47jTJJQatS4=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl2wTz1zXeGX3O6S1IhXY5qg1o1XFxHiNHIX5GFkpec2lLBQAI
 gnh/Q8nH8SggkatnUOwNqIXf6dyfTFeiIHTdyX0iSihQJaMSNpH0d/gcXoEmMThkMEM=
X-Gm-Gg: ASbGncuER/XJv01R06K2XSzOnaJah7Mavp1JkZDLThdQSdYCBpVZfNhsNfuMrirIztO
 jU4tDdgBiBvNXGj83WCyhAC9R15AwGDyUCiX6cu7+sDQtSYId2DGlFdQPgCeW9ZgQValzdjEJIa
 g+d4xr3FSSe6JuCOaODWpyt3whCDPXnHZqildJRBAkaMUy97qpIKFkUgGRQJOplhoHQCF9Sx2w+
 rI+C91hBPL/ozxX2E7wjuW/+vfgLtik6YecYiw52sllZyVwaA4HluajdTtWK2xHGyujqtOq3sfT
 tT5FviuWnyPbeySOB3gwiYariOJIx2DVnDRsYsoA/RTaK9ECE1ztm2oOPgxV1ycF1v0bgIqJlLn
 zbOMK+F0Y2yO67PU+IygW37SYy29/POktSUmTxhaQkIFqpBjlz9fhDa8H8RY2QnwAYV2tSlXh0u
 qpWjJ2phIwfLxa+dO6xdtktowpnuVwXUXX
X-Google-Smtp-Source: AGHT+IH6cc421S58QrwUheSNJA1e8Bgf36NmJcSExkkjcaF8teS4LtkinzBQ/UoEQhPVby9hEB2UOQ==
X-Received: by 2002:a05:600c:4513:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-4778fe5de1amr112704675e9.11.1763369083896; 
 Mon, 17 Nov 2025 00:44:43 -0800 (PST)
Received: from [10.1.5.210] (88-127-129-70.subs.proxad.net. [88.127.129.70])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e6acsm306921055e9.9.2025.11.17.00.44.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 00:44:43 -0800 (PST)
Message-ID: <09c24924-572f-4e5b-9fd9-1dc4cc95dbb8@baylibre.com>
Date: Mon, 17 Nov 2025 09:44:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: Re: [PATCH v3 3/4] board: am64x: Use generic AM6x
 board detection functions
To: T Pratham <t-pratham@ti.com>
Cc: a-shenai@ti.com, afd@ti.com, anshuld@ti.com, bb@ti.com, d-gole@ti.com,
 devarsht@ti.com, ggiordano@phytec.com, ilias.apalodimas@linaro.org,
 j-humphreys@ti.com, jm@ti.com, marek.vasut+renesas@mailbox.org,
 mkorpershoek@kernel.org, n-francis@ti.com, neil.armstrong@linaro.org,
 p-mantena@ti.com, peng.fan@nxp.com, s-k6@ti.com, semen.protsenko@linaro.org,
 trini@konsulko.com, u-boot@lists.denx.de, vigneshr@ti.com, w.egorov@phytec.de
References: <20251103-am62xeeprom-v3-3-e390779c0fc5@baylibre.com>
 <20251114133303.1955041-1-t-pratham@ti.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20251114133303.1955041-1-t-pratham@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

sorry for that i will send a fix today.


Guillaume

Le 14/11/2025 à 13:48, T Pratham a écrit :
> Hi,
>
> In our daily build and boot test of u-boot master, am64x board is failing to
> boot. The boot stops at SPL stage.
>
> With git bisect, I have narrowed it down to this commit. By reverting this
> commit, I'm able to boot the board. Looks like some issue with the configs when
> using the common board detection functions. Bisect log:
>
> ce56e553c31377b9cda7c53e2161c8e02071fc4e is the first bad commit
> commit ce56e553c31377b9cda7c53e2161c8e02071fc4e
> Author: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
> Date:   Mon Nov 3 19:40:04 2025 +0100
>
>      board: am64x: Use generic AM6x board detection functions
>
> Regards
> T Pratham <t-pratham@ti.com>


