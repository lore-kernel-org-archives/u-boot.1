Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E93CAC582
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 20:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA5A882B20;
	Mon,  8 Sep 2025 22:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GwZN+kWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 466DE83045; Mon,  8 Sep 2025 22:24:05 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E637982A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 22:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-30cce8c3afaso3408822fac.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757363041; x=1757967841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+Yd7wdkgUznuGQuyCInoQb5L5l/ECeatQj3gp+u7D0=;
 b=GwZN+kWUk1uCGEOshW8jMvSC19bYCag8zUJAE8olfjpslhA4nBq06P2+NDDpr0+fK5
 DgOZS7PoWxM8xkrHu8moxQCMqbPP9wCZWgAdnWYkFDWAyGluxAWV8xpMA5a6JdLROi8V
 I9cmmnf3Vh6jDVuxYtpA0o51cmzDOxopmXXeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757363041; x=1757967841;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+Yd7wdkgUznuGQuyCInoQb5L5l/ECeatQj3gp+u7D0=;
 b=ju2o5VSnIKzTXR1AOLJY8JyeI6ubRqXznKPxRYTWwNOqvBwgOLjA/ul/tx6DOmpfvB
 iyfC2eDDsbHd5+k9GzVtLvMr8Cy+Du2KrZPoZRvMGtKPcXhbHU1asqNEQoOwtsNZ5uY6
 SL4XXvjgbOAKUokCRHrlKjkJaOqH3gRSMyW0EGe/FpNMEQLGyul+gSQaV7LGy7+rOYLd
 8q5A9ZoIZbug0pdW2G1ea7mkmNUCKyiym7sU528m6Qe2JbKvUpQi9wK7V+TwEb6KySQQ
 kdk3bATSrEXRbvkg3kzDt+Cibdjmt97lSmdxzLkjjbS8z6qgSQJzw0KAQL/IYmb4slw1
 /8dQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyHLq8I8cO7kHmRPwdiA4nLQ/nf8tEhURscwMgK5hLLz5moieoFRo2jS8CIaKtUjc6Jhwy5H4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/TBRC7iD/CKNAtfPeExk9pGKha2q057B9n6eHMcw9Jshm6RaU
 agCI/mF0kBjkIgM8Lflk+gQ+hiuWVtxLSXX54BTenPKKfJRvmqtAInWBf5H+zMT2NYyLYJYb29s
 34xewCnE=
X-Gm-Gg: ASbGncvbOFseU4jxcfluT7/ft7cCUP4bfTmdCTar7aaNJ/Zu4IcOMfUvYUJdv6dwWja
 OweCSFFjpYFOkIwm6zOtdF7RZeRLxvgGlwCE0WHc89oQZzUQDYTq+EKxmOXcfodVV4rY2Zi2XmM
 +YPNspxB5VVxWO2dCp0iIWJOgRCOdw/HvC190hFhacZXe2UlbjnsS5qfVJOhbuqCWh1KCMRZcq+
 HV1p7fvWQd5cDmM+t0JjgSbu+zUGj+40eW0a6TRB8WUrIdgzApZT5KQBrbkkqMPvRSzwQVGZ6VW
 WAeTMhUGnc2QovPWK6vrUJBZ7p0HeFhvgSYh00BIqflOeiZJyYFcJaykZKOhNH0aRoE9lpNg2Fn
 dDyGg7brQ9eN3DvrTLw23OXf07OU2uvvQHWjssFppDez17BKYWM31tip9wPda48AYJQ==
X-Google-Smtp-Source: AGHT+IGFUZV8veHbD5pLDO1tMwZTIzQfbBx4RSdOPBKuUBhJIHq91Vp74jgZZAluLTD4vgaWAq8GZA==
X-Received: by 2002:a05:6870:3c86:b0:315:6c51:f544 with SMTP id
 586e51a60fabf-3226512f409mr5019834fac.44.1757363041577; 
 Mon, 08 Sep 2025 13:24:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-32128eaef7bsm3755893fac.26.2025.09.08.13.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 13:24:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20250901234921.35642-1-heinrich.schuchardt@canonical.com>
References: <20250901234921.35642-1-heinrich.schuchardt@canonical.com>
Subject: Re: [TESTHOOKS PATCH 1/1] travis-ci: add qemu-riscv64_smode* test
 environments
Message-Id: <175736304075.1510857.10234397096428245387.b4-ty@konsulko.com>
Date: Mon, 08 Sep 2025 14:24:00 -0600
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

On Tue, 02 Sep 2025 01:49:21 +0200, Heinrich Schuchardt wrote:

> Provide test environments for running
> qemu-riscv64_smode and qemu-riscv64_smode_acpi.
> 
> These use the OpenSBI implementation provided by QEMU and
> pass main u-boot as -kernel parameter.
> 
> ACPI is enabled for both boards. We still expect the boards to use
> QEMU's device-tree as control device-tree.
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] travis-ci: add qemu-riscv64_smode* test environments
      commit: d94ebdd2c823ce8776723184cda960dcd2954711
-- 
Tom


