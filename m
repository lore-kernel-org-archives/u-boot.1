Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB50C83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 19:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8564833F9;
	Tue, 22 Jul 2025 21:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n5lNGWzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA6683414; Tue, 22 Jul 2025 21:46:09 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1838331F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 21:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-306ab1b63fdso575291fac.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753213566; x=1753818366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n++sm/kP+nyYyUSCLiplzYFRkoqyuXkWRreDi/tF7og=;
 b=n5lNGWzFmIQpyeVgYnrBUBcdg6vccDB1BpgI1TZEIOAscDqULwFY7GkfvoFL1RK8+P
 a0u3XEPD11IgQ7ClDfOvDTPjiUzSPudzpzhQaJk8kegrCql9zW9VrHtuqHee256PstST
 hML0gOOZ6Z+FEMe41JPh0AFknDIupKyEjqOm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753213566; x=1753818366;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n++sm/kP+nyYyUSCLiplzYFRkoqyuXkWRreDi/tF7og=;
 b=w3gQmMXRVtRevzRGxxoCIcUZQM3UMxcKI1YhO+4bjaOx3Nq09jdQ5tCXfN/Pj648dS
 xCTe4OVbXNZF48MTZb9fgFOZZ1erVk5RAxnaK6r5yHM9HLc1dcGUgabQeA1IQopgFBP+
 sSYTr8ckuWLkdDbld65UNfEymiIUOk8IlPkxvzfXKz3zprGnRMEiogY92Y9Fggqrlzyr
 JASX4lre1w2wxbzBzKrdYN2U95dHAQO16zFMPk1AzMDkRdqMEsGXN2TdE4HKu8Azsfln
 uOqj1k7BuNpvx28tbNeDxxE0qiEBDGspoPSoQxFZGnFdfc815n1+Hglq/Pi37tqyWpcE
 T/mw==
X-Gm-Message-State: AOJu0YyB0e1PX5V0xt/fGIlN4jjd7nrM5OhFPMjpSlIyt8BRaNTg0hpj
 8zlfa1yPk5YstZ6YnwSONLyqJup0jLpggNQBxFbklNfIXeOTL45kSnQdUclbZcNLg0w=
X-Gm-Gg: ASbGncuFdZJ2OIeg/V+3xnHKP0NiKe5V3b/liGDg1sUUpys5cGf8IY8prHVkNYyxpfA
 sveA8aZfg82MWAbPk2rf/rHYEtYIB68Ivan4I2Fmtl7Bh5a8F5k3Bzh0L3eYb8FrxZ1GYRbj1kr
 PBeFW1Rfx5tqCI/6fEpYP5Ozo4mMlQAD/Kth7XLExkoiXOLsO7qLRPkqGxcI06jTV0Yc2lQNgIa
 0b+87Yy8zVsQft6IueA2Dj09Y7G1b+xX+8so88LUOSz+W6tzeVJaLMh+eKSjFJNg6wAHyWkzQyA
 hE52Dt/NyEO+ntLVRLDhiOflVstjQSO5Vgebbb4dydB2Ybgh1YM/El7/nXOpNQdarJJISO5YPwE
 t6fmSdVil2ZVgDLRXmNi79GoytUTX9YSMaFXJ8KyFd+/qmCU0+MW1Kss=
X-Google-Smtp-Source: AGHT+IHRqdkmnpaZ7R4WajDyLq0SeLjULZJ+SZl1/RPR0R+k9eulKsjERW9fvCYCCCDtnJojT4KYlg==
X-Received: by 2002:a05:6871:894:b0:296:a67c:d239 with SMTP id
 586e51a60fabf-306c6fc196bmr181996fac.12.1753213566083; 
 Tue, 22 Jul 2025 12:46:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e83b0c3fbsm3749811a34.30.2025.07.22.12.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 12:46:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: rayagonda.kokatanur@broadcom.com, casey.connolly@linaro.org, 
 sjg@chromium.org, m-chawdhry@ti.com, Gokul <g-praveen@ti.com>
Cc: u-boot@lists.denx.de, j-keerthy@ti.com
In-Reply-To: <20250710095922.144361-1-g-praveen@ti.com>
References: <20250710095922.144361-1-g-praveen@ti.com>
Subject: Re: [PATCH v2] configs: KASLR OPTEE RNG support for K3 devices
Message-Id: <175321356485.77222.7103469625177962064.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 13:46:04 -0600
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

On Thu, 10 Jul 2025 15:29:22 +0530, Gokul wrote:

> KASLR, or Kernel Address Space Layout Randomization, is a security
> feature in the Linux kernel that randomizes the memory location
> where the kernel is loaded during boot.
> 
> OP-TEE RNG is a Random Number Generator (RNG) component within the
> Open Portable Trusted Execution Environment (OP-TEE) which provides
> a random number to U-BOOT and U-BOOT provides this random number
> as seed value to the LINUX kernel for KASLR.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: KASLR OPTEE RNG support for K3 devices
      commit: 7d4136397715d2c08161a32a873c052dd1bb8b6c
-- 
Tom


