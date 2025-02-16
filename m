Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7318FC021A4
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 270D980F1C;
	Sun, 16 Feb 2025 21:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DyWlo18v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F73D80F18; Sun, 16 Feb 2025 21:44:55 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C5B68056A
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3d2858ce82fso3266675ab.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738690; x=1740343490; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DreV9NBWw1rAAKxQDwzKoQMmZrapH2rDpG7DGjQOfBQ=;
 b=DyWlo18vZ4zbv1DIFxdcrlWpcrsc8Ae7kKNtAotYRql4N1k8Iu869B+zoNZCmdGwQA
 4ul8cSR4mzpdHn8RWWPDZ+9E2iwrQKCBq1Vm7K2Xw2Qb+VRmM3FH0B/rVTX7O2Q4DgP0
 Q9osGtUyowoJqTcB9f/b8WkERDkhCaudjFh8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738690; x=1740343490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DreV9NBWw1rAAKxQDwzKoQMmZrapH2rDpG7DGjQOfBQ=;
 b=JfXGr9cx3W9LMv4MGXmWHoYfAgJf7j6MN/8oiRHbAvU/QnwQVmseqgxGKwgqfDw2z6
 LWx/MAGxSMA9rAz5HrJImCvnZbh6sSbDTZN8z83Pl5kcnHHW9yLEwW3z6Z6GVApeG66Y
 Tkr5RB0jxGyJhdm2YA6aDGCKdaoNI5LGBrdk/3Mdi6FBt03guGtne99k9woF8hre8+8H
 NKcNPkzLHmlx9Zv/k34LCIq/YRbMEW1h3IN51QW9+K6CvY+Nk4frcOOTYMkFWOImeL36
 m8usBMnpLE+Q28k8gXD0wS/Dpqg6D9ehpzjNkp9m+YNwnNV5plR97UZyPc1ImrdwEulW
 hZog==
X-Gm-Message-State: AOJu0YwTif1LlVpA/sNgB3AT8ACzq8fg88B6/24T00bN1boLI5vEO1bb
 tmkJcI0Jp53N4XIxj/TmpBCynRPr9CPQrp7GgVGlbkKM7OK0WQfKir7/PFBgaLB6zNjalbUaJCI
 =
X-Gm-Gg: ASbGncs34lYdGZ09qyGyzLiiORMVnQ4cAAjVCmjauJLjbF6E4QyqFVzvrsHOIViCN/v
 0gv9Pq01LrUddknsVJtyc10AOZ+BAr0zpB5bzFP5d1aSRX+FqKWVtDFDOSKzQZrhcH/yfVnf2fU
 RERqj26z1qY1hIuho3gROkeQ7y9H5TOfezoSsIEmMmul33HfRaj/rH+9NTdxtUk6qSrneWzfNIw
 QowWhbQpb3az47KeF5ZghUqB+r3k2LjwJu5t2lvN5OSvthGstZnH8nX2DLc8pt6BzUy5YJxHFZY
 O0a8NOVqJS7v/29vEFQXK4OYF7ONs6BNdnr1+6qcScB0SmhzbzZZ
X-Google-Smtp-Source: AGHT+IFVW4sYH36KMd/WtC0pieXo6dZkD4DFQF6MqOw1XkQ0XCh5/OjhdzlMOChRjesLs4sLeAimXA==
X-Received: by 2002:a92:d34f:0:b0:3d1:5dce:5105 with SMTP id
 e9e14a558f8ab-3d18cc7476amr85680815ab.4.1739738690507; 
 Sun, 16 Feb 2025 12:44:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v2 02/28] x86: qemu: Switch to bochs display
Date: Sun, 16 Feb 2025 13:43:47 -0700
Message-ID: <20250216204421.3560012-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216204421.3560012-1-sjg@chromium.org>
References: <20250216204421.3560012-1-sjg@chromium.org>
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

The vesa display is widely used on hardware, but it is a bit of a pain
with QEMU. It requires executing option ROMs, which either doesn't work
with kvm, or is difficult to do in a kvm/QEMU-friendly way.

THe bochs display is probably better anyway, so switch to that. It works
fine with kvm as it doesn't need an option ROM.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/31
---

Changes in v2:
- Redo commit message

 configs/qemu-x86_64_defconfig | 5 ++---
 configs/qemu-x86_defconfig    | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index af275e8ce8f..ff2a192ee7d 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -83,9 +83,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index 0b0e10c795f..ee5b150e062 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -62,9 +62,8 @@ CONFIG_SYS_NS16550_PORT_MAPPED=y
 CONFIG_SPI=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_CONSOLE_TRUETYPE=y
-CONFIG_FRAMEBUFFER_SET_VESA_MODE=y
-CONFIG_FRAMEBUFFER_VESA_MODE_USER=y
-CONFIG_FRAMEBUFFER_VESA_MODE=0x144
+CONFIG_VIDEO_BOCHS=y
+# CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
 # CONFIG_GZIP is not set
-- 
2.43.0

