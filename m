Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C19D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82BA388F55;
	Wed, 16 Oct 2024 08:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="f4giauF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E01C088D56; Wed, 16 Oct 2024 08:13:46 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2BDE88EEA
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:13:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c9709c9b0cso4801542a12.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 23:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729059224; x=1729664024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgvIuxiR0qr2MX26PsBx9W13efeAR1L3XMSoFmXns1s=;
 b=f4giauF7TQZLYil4ZitlwMGhN6bQSGFFqGlQBmqVQJkazZhpwFve18N3l46AZPuHPt
 vdPK2kvVoHNyNaz8LNACMd4X9qWSZ8O0VYG+PI2TzcoXtIfO0QIKMNUk3iA6fk66G51j
 7CvrJsRY0vIA4tkA7vPg+0JT9esDRsji5kEBz7LY6DoWjnqlvdHOghK5zQ4jpM5TPO68
 4p52DDb7OIoYAWojJj7c47TAEM+Kh53ecUjkl6E3XyrsKpkzRS9FiY2DULEHihT3oP4B
 zgiDpRFeqRrSvswwZBT4kHd/cUvoxM0TtR2pCuAn//Rh2enq2wpgrhblQUkzRSAmHQw7
 Xz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729059224; x=1729664024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HgvIuxiR0qr2MX26PsBx9W13efeAR1L3XMSoFmXns1s=;
 b=f/IUDhN7lGC2bh80DMpo5jdlxLWTmWozSxAIm5+rUPqv7u+p0GsdGKViNqZhIxeKVg
 hUU0ln5rEILIcDbGcS3mBdh484aVjXEzppYIl1ztaqU+0+SopNEv86QOb6uOqzU4OPQj
 IVgadywySnUn58oFTJ4AiSnGYZX+RQ3o42Ck5KS/h8Ap6I0xk7U3iKlnKRKWzkkw8iuG
 xkwYmQXbUmktKAF95G18H2rvx5WpfyRqkLs4it+Ea7QC8UytW+DFkGPI5hkMNV8NmBxe
 sM/nw4g8nTURC2ACttX61nWf97HH1pUEzj+8XzdvvzV610yNXQa/et8dsxPhC6v0P0r4
 n9+w==
X-Gm-Message-State: AOJu0YyvZxHnDuuQc+QOxh0eNXs3ti3gR8+dpPNoQa6ya/Q/lfM/lAeY
 C7D3P4phhzJhXLYK0QJPggpOZip76f5kFhZm8qH8kWzy5RAW2Fj+U5guQyYQXMZjAoCr2GT9zpK
 T
X-Google-Smtp-Source: AGHT+IHofIqkiKYzxTVuzReKgoFdUk5JSToEVInkoaIwE7dvHQAF/LMXmn9NmTkzmfPLnyR8SDVa0Q==
X-Received: by 2002:a17:907:3f15:b0:a9a:76d:e86c with SMTP id
 a640c23a62f3a-a9a076dec5dmr956385366b.49.1729059224261; 
 Tue, 15 Oct 2024 23:13:44 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a2981702bsm141743466b.112.2024.10.15.23.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 23:13:43 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v9 36/37] configs: Add RPI4 ACPI defconfig
Date: Wed, 16 Oct 2024 08:04:22 +0200
Message-ID: <20241016060523.888804-37-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241016060523.888804-1-patrick.rudolph@9elements.com>
References: <20241016060523.888804-1-patrick.rudolph@9elements.com>
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

