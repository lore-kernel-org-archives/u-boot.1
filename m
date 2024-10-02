Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303EDCF31A9
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB4618909E;
	Wed,  2 Oct 2024 11:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="HG6OMEfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF08B892F0; Wed,  2 Oct 2024 11:53:09 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A3C88F64
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37ce9644daaso2268335f8f.3
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862787; x=1728467587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bxm+HyrmKeXrnd9YHJzLZNIL0lV8fjM0vCrBqQUuiow=;
 b=HG6OMEfXZEZe9vCLUjHK5kAoEbVE3/TqUUhvXtE6TD/7SCNJuE/QV+5nzmy3jbn/P+
 EyViuxN2aMIv9AhrPV2DKQh1jofTSNHotRuNIgL5302ccKJjyoOhI7mOupTrSjYLOL3S
 8fR3ovCxq470khKeTGQVNCKOTDqKTS1DkrVivgU2C8ljuHryLxNaO0zFe0/ByuJfM8jY
 o9GvBt6c7/scnMlxDnUWLuGpx5yj8kTrl90+lpCWUsFh8zFcejB1k0AZaD2fjlVl2rrw
 cYU5sxRTxiHyQoyorHZW3//GvmmgpwubvZe5sM9nGlXj+7ukHIiJSgVZKleoRvCXi8/v
 hzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862787; x=1728467587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bxm+HyrmKeXrnd9YHJzLZNIL0lV8fjM0vCrBqQUuiow=;
 b=U9SVgGesueuxEooI4McCJXOOAsVFA3kYW5FmTCo97JXwBqOi+BN8HsAs9LCbpwea4b
 Bw45JNj32k1YmfYUacTgTLIkgQZKJwOt+UJwn6rsKGjFVH//L5sf/0pqr6igq9at0wQk
 K9QV8udjH06J0yY0AusAKBX/pPxYq0PaAViTn21ZWBRX5cXoPyrMQW4tBLNOY2L6JH2z
 cBUvJztx36LkakkPz7f95eV6AVaPes5NDEaoojoD1dBKNGZ3fViupv237TWbsPoGt7J6
 A9vn3EgaDwxwe+nd+kYD/i9WHvMZp8HWIyZgKtCgM6MsvyF8TIEyMUUxT6doOpn5aw82
 Ashg==
X-Gm-Message-State: AOJu0YxZeMPlrJfY2RmgZFuJxOWzJMatFdGM+xWUVLPwa4f82RKP/1JW
 8qePOeT3qZ11YHQVTYXYdVzPNsAHJW7QKAHGYfyiM/P3IsqfdVGHQOaRpLlvedvZbutfwhHAAk/
 C
X-Google-Smtp-Source: AGHT+IE17VtN4IIWOvLHwBH19wvtxeyTYBGA11OdKyhp7w1OFe5iqQQUDgV2gycNGfmZ37oTw+8Nyg==
X-Received: by 2002:a5d:5b85:0:b0:368:71bc:2b0c with SMTP id
 ffacd0b85a97d-37cfb8aa63fmr1474136f8f.10.1727862786653; 
 Wed, 02 Oct 2024 02:53:06 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:53:06 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 36/37] configs: Add RPI4 ACPI defconfig
Date: Wed,  2 Oct 2024 11:47:27 +0200
Message-ID: <20241002094832.24933-37-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

