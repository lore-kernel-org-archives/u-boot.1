Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB3BC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE122806D8;
	Fri, 17 Jan 2025 17:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jq0dzfeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA8C80717; Fri, 17 Jan 2025 17:40:41 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682D48036F
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6e1a41935c3so31997886d6.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737132038; x=1737736838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JCeNA4sF0KsNSXNdjdhcRd+m0Rt/Z6q64lmr/29/9pU=;
 b=jq0dzfeV37+GplLRvTjXA77AJpir3BaS6+ef72jHGkDhNRXPfVEvAx7Xsviu91twZi
 YnZY8XyDHA1GSBjH9tIEzJSqiK4LQWYj9qy4A6AcNQbZy/fl5Xnk4vK3EERc/dHE7jUc
 DvEmDjnUcGwgipCUNfdhrWTDxJt/iTwgI84zwdC7qSg7AgDtM4CCBg3wm1TNwWAnvNog
 D6nkOzovXqQXt+WyI79jCvO5RXBnmoGuphBD+0vxXxXFjFDd3h/aUlx40DUrQS791za/
 3rJY7AUj4yFLdd8g4X4NXlBSx4jTKlNQND/MUZITzA4R8N7BFaDFh9PWr9l7/uYOCkgb
 0y2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737132038; x=1737736838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JCeNA4sF0KsNSXNdjdhcRd+m0Rt/Z6q64lmr/29/9pU=;
 b=bTG02/ajEEzUqOS0pwPRpuBVVAMhveTdFhxi6Zq2I12BO4m29CYhaeIHAx/oQp3NTY
 LRE0ic/a4jnvl0dkVN+SVZV/u2daKhi3vP0isOmehO/wbWugi0QAjd/3V7obpIz1Cn8C
 QqNxzdWco4mjXOwSE7jbKg5LGncZw+SA09VoTxfA2GGJ/eDLlONELjlDxxolJgOYht8a
 o/Ed2Epn6kmPUTW8sd105+yJl1PL7OMlLkPUlzpe2VkldktOXx5cL4agpQYIDr3WpHag
 IETZbd8FT14HDvaMONb/R+rlc7tI44kcxWOvRWxDwPF70DLMDUIQd7Hqfr3lLzM+3wBg
 rZWg==
X-Gm-Message-State: AOJu0YwD1NOewLWjLP2z2p9M9HB+6i12V8h/CqdBrRJJy3HHt/bWwxSa
 1F7kQuyIsciz87SzXtcQ58zdy1K9J2LcK/I2JPHZ9JjO6oeNKcr5nkznEjakwu9/aNKoMY1TSwR
 UyK4=
X-Gm-Gg: ASbGncvWCqJ96W8ablM0emre0oe401UIdTrTHJ3ckuzly88e6bDCeTgrn0V8IGMfLF2
 b/fjRiihSM2rujIcEisrLfnLlkjUC8WrvyxILvfEEo2uIRFm+QGQXuL0rikbuppWTFM7+gMSXj1
 8KvzWirZHy0pYA+/A16ecRkY4cJNwJ3jnUX61yTZGYZ6/0ChMo5N+m+O7SKtbAKHZnW7fb/e8ut
 rNwVsPbIQo0Z+GFx16Vu6PUDTkfgLe5u5SrVTgqykOvJ3MZKpJsZNsROZfNTn5ziKs6V5JkclhW
 41PLl/lAexQDtGROOQTBkr/97dqmocQpQ/XAyFRgLy23aQeEnasmwxQ=
X-Google-Smtp-Source: AGHT+IEg0Jkc8OFwso9c8s1VAE9/xreQ9MkYAWcV8V7ionEertgyDzz1fKCGcFyyVRsPzVPD2dwCHg==
X-Received: by 2002:a05:6214:3b81:b0:6dd:13b0:1008 with SMTP id
 6a1803df08f44-6e1b220a25emr49313016d6.30.1737132038030; 
 Fri, 17 Jan 2025 08:40:38 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3887sm12867746d6.9.2025.01.17.08.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:40:37 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 0/6] Reconfigure TPM when active hash algorithms dismatch
Date: Fri, 17 Jan 2025 08:40:23 -0800
Message-Id: <20250117164032.88942-1-raymond.mao@linaro.org>
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
  tpm: add TPM2_PCR_Allocate command
  tpm: add wrapper and helper APIs for PCR allocate
  tpm: add PCR allocate into the eventlog handling
  tpm: PCR allocate during PCR extend to disable the unsupported
    algorithms
  board: qemu-arm: select TPM_PCR_ALLOCATE

 cmd/tpm-v2.c                 | 128 ++++++++++++++++-
 configs/qemu_arm64_defconfig |   1 +
 include/tpm-v2.h             |  54 +++++++-
 lib/Kconfig                  |  12 ++
 lib/tpm-v2.c                 | 259 ++++++++++++++++++++++++++++++++++-
 lib/tpm_api.c                |   4 +-
 lib/tpm_tcg2.c               |  52 +++----
 7 files changed, 464 insertions(+), 46 deletions(-)

-- 
2.25.1

