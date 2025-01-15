Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F31C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 20:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 002888033D;
	Wed, 15 Jan 2025 21:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ux5lDueE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F5380214; Wed, 15 Jan 2025 21:02:08 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C83C28060C
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 21:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6dd1b895541so5097876d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 12:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736971324; x=1737576124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UcEzQLRBoxtYYh2PT0cx659/qJgz2SNTU1DR2i9m+0w=;
 b=Ux5lDueEljqI3yPMpJoAee4YjBvVeCwlYRyHw/hcxJ435qX2hSCIJ9NXA/yNt4p4zs
 CCERf3EUd/4hJyc0GyQJtgXUY1aiYM5X5D6UrEBowMH6tAvihAuODMZqlR6Y4T/FLURb
 3j9lB4rYeXgfgl5/5ni5wFvwS461mbfKL6g6JSzjMW3gV3shof1qahseX/LInyoaTVMa
 xolFfnqlJ01cNSI/W+EA6E31WA0Dhf9/rPt1pxO0pptwK6FkFIi+MTvLnqWiKxFYgSc8
 DzB3W/k2AeMBQB+v1Otpq3IhFnzfQoQHOF7v0sAaY6b13DXTRpjtSV7r4SK6t5C/SZab
 hUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736971324; x=1737576124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UcEzQLRBoxtYYh2PT0cx659/qJgz2SNTU1DR2i9m+0w=;
 b=DsIG+SL5gsrQTkec5JHRIbhvSICj7NJXdn7hYAcFO+5ONsFBkuo8VDBwEII40AtnT/
 307bBV/2ROLDB8Fatgn1TE7/HSVf5keVIGdhdTLyhAbT1mEBTvAR76lYgRTUXaADDHNk
 9n9h6z8e45yGQtY6th60m0YbfRV4T1e+V4dIA/mjq0UF23iPXd88UxcafLBLoYKXQYkB
 P/7b9uhvinQYS1oZ1eq9jMMJLVCnzvvIsXmsF9xaMBg0UEOFMXoJ9ih7XPzUN2cNRvHi
 zzayq5ry6cUigiu22svp40UZvinPmpWyLB5mhgvSL1OWyGy1PQ1IroKdWwI8GhePy4T8
 mSsQ==
X-Gm-Message-State: AOJu0YwcW7byccclfgw/RbW5THxlyD9pLLhbhqbAmp+LrtkEXJtIUTJq
 o4DsCeMfzjeP3oZNg5+1HlfP771fgmzXT8EZqxvNRqxttx0CaNxUlt9kZZVCOfc8CpJIt5mDY4l
 kTYE=
X-Gm-Gg: ASbGncuh9GndAA/dGwXcGkoPXDEcY/QorpxR8uCtnuznZjHlA1UYZHpI2eaSX50Is4f
 y9Tzm23L68vb3ib5OMHedmy+XjcH4gO8mlgO/0YUYeGu51By8JmhN1W0SrWe56mG1mTeVUsqXkL
 sKZ21jFh47Pm5QpkuSflSzkO06/QTclRkXl6FiAQWAT/B2advcSoCwx5uOaS/RtZnLMcs93KR7f
 riQFbJyQZUEx5MUfZ8Gdihbs2wwxMSR0gJ2ZBHGtJGQWO7xgS2fqxsNjCZQ9nhCDZ3Q5vt+eule
 7hQ/vgEZTOl1VyGaLe+p2WGhoJ27LCit78uEgOsbpM13bLOratkeVMA=
X-Google-Smtp-Source: AGHT+IFISkc87Q0/OAiKt/0DGap611KjfioH2LC64hrI6ZI9nPajO19Ap8V9Q/+wpOBZhN6poq/B8A==
X-Received: by 2002:a05:6214:3bc8:b0:6d8:9062:6616 with SMTP id
 6a1803df08f44-6df9b1ce1a6mr529943556d6.7.1736971324436; 
 Wed, 15 Jan 2025 12:02:04 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade733e9sm68328686d6.82.2025.01.15.12.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 12:02:03 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 0/6] Re-configurate TPM when active hash algorithms dismatch
Date: Wed, 15 Jan 2025 12:01:34 -0800
Message-Id: <20250115200144.951530-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

This patch set implements PCR allocate command to handle the algorithm
dismatches among TPM device, eventlog from previous boot stage and what
U-Boot supports.

It re-configurates TPM device if any active algorithms are not supported by
U-Boot or does not exist in the eventlog passed in.

To re-configurate, a PCR allocate command will be sent with new algorithm
configurations, followed by a shutdown command and a hardware reset to
activate those new configurations.

If any of the algorithms from the eventlog does not supported by U-Boot or
TPM device does not support all U-Boot algorithms, exit with error.

This new feature is under control by a new introduced kconfig
TPM_PCR_ALLOCATE.

Raymond Mao (6):
  tpm: add TPM2_Shutdown command
  tmp: add TPM2_PCR_Allocate command
  tpm: add wrapper and helper APIs for PCR allocate
  tpm: add PCR allocate into the eventlog handling
  tpm: PCR allocate during PCR extend to disable the unsupported
    algorithms
  board: qemu-arm: select TPM_PCR_ALLOCATE

 cmd/tpm-v2.c                 | 108 ++++++++++++++-
 configs/qemu_arm64_defconfig |   1 +
 include/tpm-v2.h             |  52 ++++++-
 lib/Kconfig                  |  12 ++
 lib/tpm-v2.c                 | 259 ++++++++++++++++++++++++++++++++++-
 lib/tpm_api.c                |   4 +-
 lib/tpm_tcg2.c               |  52 +++----
 7 files changed, 442 insertions(+), 46 deletions(-)

-- 
2.25.1

