Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0578CF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05B6C89325;
	Wed, 23 Oct 2024 15:29:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="B+5291Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA36C89334; Wed, 23 Oct 2024 15:29:52 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E4D892E8
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso72193215e9.0
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690178; x=1730294978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgvIuxiR0qr2MX26PsBx9W13efeAR1L3XMSoFmXns1s=;
 b=B+5291XcQMdsFypypsT/xrEaciF4hhbv/qFAOF+UBn2zGCJzybIfu+6SrVqxIin99x
 VFkQd0BT+cuBiBQ5BLo8b0AI1rVEXrPcZz+lZN8v/kBksYAYz1f4qIF5HyHdprPjGniN
 95fsd91dGGKyGbyD4Nl744+WURT93XvLQuxGVdsk5WQ+5NwbvHj7vS4ut8gDYkuGGEcv
 ZW7Yg30Z6DRe4asTX8PRl7dmb0xLtVFtjED/JnSDrTLHiJVLxX7lhRXD85tIK6CGuSKL
 Rilx8UI6mmsMtp09DoWncSeKD1scmMFhiBw3xNXAonFVqNdq3IAuh/1eLjCyrn7RpSZz
 FG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690178; x=1730294978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgvIuxiR0qr2MX26PsBx9W13efeAR1L3XMSoFmXns1s=;
 b=TR0J/+IxpPXGyy5LV/he/P9vjhZDAG+byPT56HEqCQ4uYrXs8RMeX8SBnis93s65ub
 Mex0MoeJSGQVKTY9CSzIXmW0qEObOsweMSlKY9vmH9krn+dkbdXv+LEImULX1yCXeMLL
 0LpjjjOA2O3v2TrSimVS3aUhBwoVrdwxNr0wa6bDF2kDsL5EhSVB/t23b+5jLHlADzZg
 /Aq6kqgG9pzgnzRPGZWY85b3wH022wUR/lSnyk7x1ZYAt+9QPlBV7A4SPU/0XIdWSyBB
 +ji5oes9a2aBXIcKQQDD3VDYgqnIDi9NWwbFhJA88P5euYBc80m6AEfExsSxXj/kpd7k
 Pedg==
X-Gm-Message-State: AOJu0Yw8mlQGqo1BoaxTauL9lTOpIFaRTnzd/HeioGySw2my7CqtYjcm
 XRVMMLGTNlPTwDjgcSy33OUFxUEzk6y/4kQBHwbvzUGn0aoSbDKR+9aKQ03VBOfOn2gdo+d3eLb
 N
X-Google-Smtp-Source: AGHT+IFm296RRktwtyvky5ta6iUWtR/Nr8kRw+hD3APXhwUy5lVxyLWEwmFfHDnxLYJWuA55xCkWnQ==
X-Received: by 2002:a05:600c:4e55:b0:42b:ac3d:3abc with SMTP id
 5b1f17b1804b1-43184242221mr30038105e9.24.1729690177593; 
 Wed, 23 Oct 2024 06:29:37 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:29:37 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 36/37] configs: Add RPI4 ACPI defconfig
Date: Wed, 23 Oct 2024 15:20:19 +0200
Message-ID: <20241023132116.970117-37-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Allows to build the RPi4 with ACPI enabled.

TEST: - Boots on qemu-system-aarch64 -machine raspi4b
      - Boots on real hardware with arm_64bit=1 in config.txt

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
Changelog v4:
- Enable BLOBLISTS
Changelog v5:
- Enable OF_BOARD
Changelog v5:
- Use include
---
 configs/rpi_4_acpi_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 configs/rpi_4_acpi_defconfig

diff --git a/configs/rpi_4_acpi_defconfig b/configs/rpi_4_acpi_defconfig
new file mode 100644
index 0000000000..b32dfc16a1
--- /dev/null
+++ b/configs/rpi_4_acpi_defconfig
@@ -0,0 +1,10 @@
+#include <configs/rpi_4_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_BCM283X=y
+CONFIG_TARGET_RPI_4=y
+CONFIG_BLOBLIST_ALLOC=y
+CONFIG_OF_BOARD=y
+CONFIG_ACPI=y
+CONFIG_GENERATE_ACPI_TABLE=y
+
-- 
2.46.2

