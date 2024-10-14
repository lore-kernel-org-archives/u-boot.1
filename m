Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC64D16261
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 13:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3833891EA;
	Mon, 14 Oct 2024 15:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="IvxXU7Qn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F35891BC; Mon, 14 Oct 2024 15:13:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF38891D0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d461162b8so2853575f8f.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728911593; x=1729516393; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyYINupvISodKxhBKiNQ0fA3TEq25G64HyoT9bMD81k=;
 b=IvxXU7QnH6tBeUCa+TZfcA1AjjhTWnFWGA4NNqjR7e95fuXmb4h3F94dIvEbUUldC5
 4YKLwzCyYDyQ2XAyw1bdxR3WaD5eI0s5fAt/yV5erA/ValHty/3vBjMCNop4aQteQuyd
 QvrDzOdxRhh5/0om/wafcPu2iutlOZQyqLukvJNppNgK99ORFrYz3F4WN/EBJnhgCVgj
 C/qEwaLE3FZop798FetYoMI1Yn3Ptp6AELeDzDw4gHmM2opW8UytM1fT4XTtVEU9IlkH
 uMXWkrY4ElZz422SSZLZZkVxlIxQ5uCcCxhY3TTt+rBr0YKxJISh/y4cRBHtGWSLECZ+
 LWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728911593; x=1729516393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyYINupvISodKxhBKiNQ0fA3TEq25G64HyoT9bMD81k=;
 b=avSK4ZS/8CDqnh9v9frrrixIAeVQlTmNXGEil+KsAUVYb5/ruRU2J2ZHFCmNFlteFY
 cDtcNhBOJnqi/y95FZLyXv9+neYhLi0iXeLDh6O+CEjjUazD/Kd6pCMfyvUB8N5VNXsL
 n0auGGHAiU2KtKepTQS6CGHIW4D3ehvR8BQntAq/jxZMEnHKPC1bvxYpFGgMSv0aZ7C2
 jgNF9+xtJp36mjYbgD5KqPer3cUlwhGKVP85NCvCzDoz9MTlz44gebLd9DdXvfsqGxKs
 5hhA5IfBjtoO2wpYHNd0tjdD+WD3+NB3HQNGJ/Two/W1pA8+lYT/TLLWwRm5/a2xOe1X
 dKgQ==
X-Gm-Message-State: AOJu0YzuUrYkk2JSJqvzp9vrGlEMQR7cVzly9dKvYNboMd8LRXyL1MtU
 uAYi7A8roQf1sfq0p4wcGLxWONxDphKf09mvEy8iQkzm8J9PO93p249TVpXCl9QqBkBTeIwXv1L
 S
X-Google-Smtp-Source: AGHT+IFOR+4oZsIsOcnCqDQuKvFLisMuVWOgrbZrkjeNVAJUBAJGTHPgaYV+aa/N6DtLj8Wr2pidpw==
X-Received: by 2002:adf:e581:0:b0:37d:5134:fe1 with SMTP id
 ffacd0b85a97d-37d5feae8f3mr5160332f8f.17.1728911592968; 
 Mon, 14 Oct 2024 06:13:12 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d605c197bsm7103718f8f.38.2024.10.14.06.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 06:13:12 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 36/37] configs: Add RPI4 ACPI defconfig
Date: Mon, 14 Oct 2024 15:10:52 +0200
Message-ID: <20241014131152.267405-37-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014131152.267405-1-patrick.rudolph@9elements.com>
References: <20241014131152.267405-1-patrick.rudolph@9elements.com>
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

