Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFE7C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:59:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02BB68128D;
	Mon, 27 Jan 2025 15:59:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xa4ObS8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 017F881292; Mon, 27 Jan 2025 15:59:05 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B93F81276
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:59:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46901d01355so44955031cf.0
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989941; x=1738594741; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mP4euvezwmsyqunHHfWGRE5X4c17PJV84D/rOk5yiz8=;
 b=xa4ObS8O7F2mIgVgJbs13FwZUfasERW1Y0WFbdDW3qT/cYpLMRMap5e9tz2iDr67Cn
 p/3Munx8kxDvE6TteFhtr8cZf0v7DjPfuzb8TybICdds9uX9G/BCP2DeH4vFlqRWU43o
 5inUj5mPcEe0hncBfzr5LVrexWjO9fnPnuGoLV1KSzk/NU6SNX5MMJgWNq1yFh/QxMZb
 XMRIS2zM6qWd4yV+DRCSHjzX6JsA+MSLQBUvnziREhFCAjxJNmDiRl62frkxxoP+61hO
 pldCy2h36qXmOz80PXchzhflpkd0IuMc8CQ+y+Bcofn3flQqBH/Y1UXHhY4xbC7ITQF5
 JXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989941; x=1738594741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mP4euvezwmsyqunHHfWGRE5X4c17PJV84D/rOk5yiz8=;
 b=kyDLoA5EtIQCufNSTX+MM4b0QpQ9Qzqo+q1glUw8naLt52eO7T3Ui7lALSTweSK1Ir
 B15ZXCrUlbzeq5mhgkmFwG45Ph6trbB7wrZu73tYPd0Ikoc7/QWXL1vEbWJpv4khtR7w
 T2bjtpcXoiYA4zy3dGopK3NiRLy5tQiyjF9Vqyh5esZ2GxtjBMREcZyMWVuJcZrHBErF
 YVp0bQvplqAvQuikcoqQzKuLu+yretWKEeFeY9MSlKWFBkppBTZ0xh/NitZSqf/Vx5dD
 lmdo8LjPyjEItnLAa++p3MYoj2ImVG2Q89bfUtXVzYu+ubgjCwYrm8iNf/O03PBeubHv
 fd7A==
X-Gm-Message-State: AOJu0Yw5eGtB8ks0nxHZnOXwHAO2YQS1IG7uBzCaIuGfQ5+LipBNGQAF
 gx7H7Ncwkg8Teg8ZM18KH/Ltoj+7T2I9ZJzHRbogz5Vxz6cFQyC+zasd3jTuEhgMJE7ILUDuhzf
 AJcM=
X-Gm-Gg: ASbGnctJXbQX6o0QT5E+awjqY0kx/q5Ekf1TT8isLP4EF/sDfAKrXp1bLLKBLowxzP5
 yLcGifg/+ORZxrTQLhlp4pvVxq31gvQwAuBD1gzn1u8qGoRoXp+ktV4NzHYq896iHx+TmZ2wVuA
 UajCcv+yoI1YS/5dRIlKVkV5xMwPeOu3PfpdDc5fA06r+et+JLBSpXdxVh8XlQhwn9D4vAQe4bk
 Wv3HIjGRqrdEBzrN4fb2auYtrq2J9319M8mmVX/FYDpbkPUEE+1dAIv4V05ptT/dU2p0J5lA+dY
 M9cAjHgKCAjk+zqyGdSxRbWeKXlL/DefA808t61HhfSQWIFUmsNDwafvNRRJzQxuSRAGIAZ7LsM
 z+e8=
X-Google-Smtp-Source: AGHT+IG9KeGM79kdX8G6+rkn+g7ywDtznBe37JZ+dXAWfajV125oclP9eXwbeFVDDtnNxvujs/ruJg==
X-Received: by 2002:a05:6214:1c0b:b0:6e1:6c94:b5cd with SMTP id
 6a1803df08f44-6e1b2168e8emr605177766d6.2.1737989941019; 
 Mon, 27 Jan 2025 06:59:01 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9cbsm40945951cf.41.2025.01.27.06.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:59:00 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH v3 0/6] Reconfigure TPM when active hash algorithms dismatch
Date: Mon, 27 Jan 2025 06:58:45 -0800
Message-Id: <20250127145855.645845-1-raymond.mao@linaro.org>
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
 include/tpm-v2.h             |  53 ++++++-
 lib/Kconfig                  |  12 ++
 lib/tpm-v2.c                 | 259 ++++++++++++++++++++++++++++++++++-
 lib/tpm_api.c                |   4 +-
 lib/tpm_tcg2.c               |  52 +++----
 7 files changed, 463 insertions(+), 46 deletions(-)

-- 
2.25.1

