Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FC0EE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8B698403D;
	Wed, 31 Dec 2025 14:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JQWlcaq3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F29E484056; Wed, 31 Dec 2025 14:44:02 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D2A8401F
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 14:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14EFE3F85B
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 13:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767188640;
 bh=iBXqYqU2sqbK/e8OGOAzAdm0s3tzKDuU1vDapGuxvrM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=JQWlcaq3x9VJbI1wq72HCOiQQxoyg9CRZBQcTC9KXAeiePgljeTv7oV4oME/xpyxk
 W3GYXzLwx/xi52xUuV/Tgo9RucA9ebTn6XPtp+1pxqsP0Ka8lcaLufFhwh9c5VsJFM
 Y+ycDThSNrX7Mf+lKg6svZX6e9FXhjryYDk3p1llc7T/wFmeieDUgR5BTq9aWS0d69
 LQP/nBvmUM60Dn61RhzdpoHTvIP/ciKA7tAyirlvHXhdz9nCNBG+P6fGL6B55pfgiG
 vX8Dx4tOIKo0h796GuctJCPWZ2YMGueMh0J9iYdSiKxy9/TwuHFCWq8X9gOxQ9dFtP
 suqDKTMG/nNeon3JadyO83IA4W+1/ZRJvRjH/U2mNLEZTKpk8kC2V6A56DUz83Vr9m
 +dQz51hHNkIwwV/se7Xfnp3/8L04qHF2wQS+ilW0uwelsHBuiTr+Bi2ESulmmyBk9g
 XYT2kJjojkX8Zr7sC3YtvIo36czbr1KyIzr9JHtQtjFMukuPxxaGslV+qyolzJV/Bn
 PpmCm4pS/38BShVzM0rDkkiFHBfx0/5ckRvh6g1+hcXS7TtpzdipPlz3tu93yK39J4
 iuN/ebeACvpqiVAO6BvLC+ydoNTOnmBACMWw42vNF3sbb1dkXe7dv/f+5ol2x2c5r3
 RFuB/2kMb80dRWWZW2pSnXEc=
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b801784f406so1098783866b.0
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 05:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767188639; x=1767793439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBXqYqU2sqbK/e8OGOAzAdm0s3tzKDuU1vDapGuxvrM=;
 b=vGK4IgXuwg1plWnOm38QpDsWalo2un5QJvK/hwJeHWrqo8yoNrbKc8LdoZi7+PUqyP
 WOQLAMWH0cliciVY0gwIG8/ByeXXD1fzy7vEiu2ceLrJNrVXXXLQiL47X1KK1Or75/5t
 SRyktgfi/UGaOY7I36mriokzr4v+j/xTwMMluiw+tWD7lWmSKS+UBl9boWegfeEGXxdp
 GK/i5m66ynGqGWaVnFneb6eDEmKKhccFuiOSpGW48A/0hSbZF88u0FCW5uguWRLslxX6
 9KTCXdmivl6ay6JeDpd+A2I9D20eDRTyfS3RzRXqV0xllRCausq0Dj94WrnDlI6gso9I
 CkYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6diAfxinM4DZ0jPgNzWiiUEMMqyMO3u4khnCx39mNUfHes6O+ilXqVTJ1DgWEEJ9zZ5MDX4Y=@lists.denx.de
X-Gm-Message-State: AOJu0Yzmsbb0SKy32NlmJbfiBpypgPoeuz1mK8A2Xex1AYpq0zSkOeWZ
 jwh6SPg5rlQqWKHYt87BwN0YBlW49qRMMPgKLtQFLFkRfzt7OLCH9PJ75EjZqIJe8ykIjIELmez
 Rp6EbxD/KGGqJet64tY5LF0j54vgeYXx3hCiNseNqh8hkOWB2eEkXkAqTjAr+wRAsLyOilzCfF5
 el4ec=
X-Gm-Gg: AY/fxX5c2A8gFqWzAduVl/LRoCLcce+Wb+DOVfrYvxWIquUugGpWbH6UNEq457naZa1
 NMGLMTCLi6DXR8AL8decmGIP+4Nx45+mPtECHUnOZVMtHFXlFXmPfsIMhHZy+V+hj+jPP5by0iI
 XKFDLGi/Yxr7okSKUpdSiEaZid2puclvQ+rB+ykJdmXyfz4FUJnQtfOMbNmQLhuH0pb+JUylssR
 UNxFdcQtBlcg9XMEso43Cq5lJECzn+a2fpz5SbcT+KZEX3h8KmZc2RknOR0opssHKyKY6WY195r
 HfFbXwCKbfwqrR3B7DZdYEAQjYoFYcrsDGmFN9bNunZOULCvbFGQoHQ49DbvZT80Mke4gIJkq58
 LRM/4Tnylgk/duJgvm4s6E8M81NqfX7RfkeX55BP3dB031EfMjEXVAC+rpdfgxenSi3rPi/jUc+
 I4
X-Received: by 2002:a17:906:6a1d:b0:b79:c879:faad with SMTP id
 a640c23a62f3a-b8036f61bf2mr3821091266b.21.1767188639591; 
 Wed, 31 Dec 2025 05:43:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiPxCOiZY9fEcHFCKmR7aNFma2eznCDkECV0syUPbI1EcnCEbF8QpTkC6hqgx/bBmIYf7P/Q==
X-Received: by 2002:a05:600c:1384:b0:46e:3550:9390 with SMTP id
 5b1f17b1804b1-47d39ddee7amr305684465e9.20.1767188626554; 
 Wed, 31 Dec 2025 05:43:46 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4327778e27bsm41276096f8f.12.2025.12.31.05.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 05:43:46 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: describe QEMU VGA emulation
Date: Wed, 31 Dec 2025 14:43:20 +0100
Message-ID: <20251231134320.53025-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Describe how the QEMU defconfigs can be used with an emulated GPU.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/emulation/index.rst |  1 +
 doc/board/emulation/video.rst | 63 +++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 doc/board/emulation/video.rst

diff --git a/doc/board/emulation/index.rst b/doc/board/emulation/index.rst
index f8908166276..bda2240725f 100644
--- a/doc/board/emulation/index.rst
+++ b/doc/board/emulation/index.rst
@@ -15,6 +15,7 @@ Emulation
    qemu-sbsa
    qemu-x86
    qemu-xtensa
+   video
 
 Also see
 
diff --git a/doc/board/emulation/video.rst b/doc/board/emulation/video.rst
new file mode 100644
index 00000000000..4943dcabeab
--- /dev/null
+++ b/doc/board/emulation/video.rst
@@ -0,0 +1,63 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Emulation of a graphics adapter
+===============================
+
+Currently QEMU's ``bochs-display`` is the only emulated GPU that U-Boot's
+generic QEMU defconfigs support. It emulates a PCIe connected graphics card
+with VESA 2.0 VBE extensions.
+
+The following parameters can be specified.
+
+edid
+    controls if EDID information is available. Allowable values are ``off`` and
+    ``on``. The default is on.
+
+vgamem
+    specifies the display memory size. The default value is 16 MiB.
+    For UHD resolution 32 MiB is required.
+
+The following configuration parameters are relevant:
+
+CONFIG_VIDEO_BOCHS
+    enable support for the Bochs GPU.
+
+CONFIG_VIDEO_BOCHS_SIZE_X
+    defines the display width.
+
+CONFIG_VIDEO_BOCHS_SIZE_Y
+    defines isplay height.
+
+CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE
+    sets the framebuffer size that QEMU can use for a device driver that is
+    enabled after relocation. This should be chosed as
+
+    .. code-block::
+
+        CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE >=
+	4 * CONFIG_VIDEO_BOCHS_SIZE_X * CONFIG_VIDEO_BOCHS_SIZE_Y
+
+Here is an example QEMU invocation for qemu-riscv64_smode_defconfig:
+
+.. code-block:: bash
+
+    qemu-system-riscv64 \
+      -M virt \
+      -device bochs-display,vgamem=33554432 \
+      -serial mon:stdio \
+      -device qemu-xhci \
+      -device usb-kbd \
+      -kernel u-boot
+
+``mon:stdio`` provides a serial console. ``qemu-xhci`` a USB root hub.
+``usb-kbd`` a USB keyboard.
+
+To start QEMU without GPU emulation use parameter ``-nographic`` like in the
+following example.
+
+.. code-block:: bash
+
+    qemu-system-riscv64 \
+      -M virt \
+      -nographic \
+      -kernel u-boot
-- 
2.51.0

