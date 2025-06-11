Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DCDC7113E
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 18:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3085E82B97;
	Wed, 11 Jun 2025 20:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UB3KIwQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 988AB82C65; Wed, 11 Jun 2025 20:56:56 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9AB828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 20:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-408e0986303so114929b6e.2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749668213; x=1750273013; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u+YsL3VAYksDMfdi/SzxG1QHaeDnLFqAM7KMUvh3t+8=;
 b=UB3KIwQtqIDFb0sxyOzRapvlcBNjn+/Y6PAuMhoIhQsfxjOg0Ph8ZWciZRm0jGJOPU
 83GoLXtKkJ6PAF7lTkcLLW8wqXVPeyH9kY4EeeCgo+IjYWLfLxoFn6c3cdA38ZYg5I2L
 0UvLY5Mw6iCjFeTku8Eextmd2slIO3jBE0KG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749668213; x=1750273013;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+YsL3VAYksDMfdi/SzxG1QHaeDnLFqAM7KMUvh3t+8=;
 b=V2Uw2I7JDUcir/oY35cqOMRuhK7/+kOqDFk6/DlSqY6EpNOQdanOYQZtl7fx7q0r5D
 aRpOCKymFyh40c+jAZ5/CUSW5vQaiHIgOLZUu0D4qghFS5jy1sziiT9TjOZSu1FjoUPI
 7H/KF/2Cwi19qlq8BNubu9g8XCzNCQMfxDy+gEiCw1OB0ooVXMMeCtzdtOr1vE2qwt6e
 T3KE9pymslQmg56WMhq2VgB/NBloLh9iifJgJR3g/LR+Tf1MDlU/bUeo9KjoeqWIGl+V
 VdYLvycQ6/3iWGQD6SkizxpMoJZufdleOFxHcQS/a14t8uq3ZHOQFuzTxN8nTIG5MJRn
 3kVw==
X-Gm-Message-State: AOJu0YxlOeJTT0agQsWHCYWhjsPPtMJRHquF4YxHR9yhmhDEL/GwDYpd
 AvP8CRvB74rYojXNr2TWZCP9nhXmRPn98nhhjlKZPejeQjYwfhLklmAP2UnXngpc9l0PuQuCiEY
 BapUnUj0=
X-Gm-Gg: ASbGnctBnXhdGPC61SCYkY1HuEUgv4Hu2DezWMstHkABgAY3IW8rouKWB4lHRf18SL6
 LNOlW3/dSAukG0kRCp45lAKVy1S9K4HUojJSagYCsUJP6TvDggUpb8oqvZo9K5aB6GddRQ+Jwcw
 PBaxxd/11G5i9p/4Wsz1TerjPBnxQUi0bGD4jJ03Z69ktLOIkiFkYq4fhc9XurIDyQU17En5Der
 bzOKA5Egc3Xm0qZyQz82oQBq9lYAaRWTEsIvqZoIUCvvJ68a7q1rMom+Xe/nfAk0P+c/XyIXTJJ
 CMHj2C8kSwV9DNZs4tKZhqx0l4i6kGzYvbOS0bxjiA7vKI2Fat4Xj/m9MAif5xs3ckYPnOnusEb
 7ZcszT5/wFRpgSucv5Jw/KQ==
X-Google-Smtp-Source: AGHT+IHBMEzftdnZeR8yuanIb7OnUIw8PEBPzgT4zAxvFOO8gNe05VdO3kwtU7xPWVS2OHaZxEqJBQ==
X-Received: by 2002:a05:6808:2f0f:b0:3f6:abbf:bb88 with SMTP id
 5614622812f47-40a660a211fmr348087b6e.29.1749668213239; 
 Wed, 11 Jun 2025 11:56:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a06fe0b6dsm409424a34.24.2025.06.11.11.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 11:56:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250610220432.166527-1-marek.vasut+renesas@mailbox.org>
References: <20250610220432.166527-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <174966821251.4178936.5102907942281301417.b4-ty@konsulko.com>
Date: Wed, 11 Jun 2025 12:56:52 -0600
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

On Wed, 11 Jun 2025 00:02:52 +0200, Marek Vasut wrote:

> One more board to support, this time Retronix Sparrow Hawk
> based on Renesas R-Car V4H SoC . This is board support, so
> master branch should be fine. The DT in dts/upstream/ is a
> backport from Linux, and will disappear on next DT sync.
> 
> The following changes since commit d7c449c3d83a986d61e38d1762433c0607caf5c5:
> 
>   Prepare v2025.07-rc4 (2025-06-09 15:54:18 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


