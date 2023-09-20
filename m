Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62749CE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8F6B86C5D;
	Wed, 20 Sep 2023 05:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XvjFYRJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 532E086C0B; Wed, 20 Sep 2023 05:00:41 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB4686C0D
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34ff11dfdf2so8076445ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178838; x=1695783638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i25damI3XW7924Vwz565XUdd2oHacfiVQ1totcJ71g0=;
 b=XvjFYRJbXeF8+zW+ZwTkadzB1OhJDCu0qE627cGZYvUx+b+jU4B81bxAcEv56J84Nj
 C3G3SZJLTU4KPcr6vGZUZHHzLPWgdGQCvLtks2PTmyC+VtJQ9oTo41DszALq8633yGZR
 9Y0ZYP2A9nKfSccTX6ebcBtHFAqMJ+6Um/tYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178838; x=1695783638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i25damI3XW7924Vwz565XUdd2oHacfiVQ1totcJ71g0=;
 b=c0HyfruqYCZDPU0M4NC1TLWXZXLYRMHkeitbqLHjSsHlu/B//ImNdJJ8LDUDj1jVSB
 NnUG7ODWIdACZIUJ2lNEHJ9Lpz8H3iHOXvanuTxVCbtHdebp3BKJSUpa7OGUOWx96aRu
 4YX7X1da3XuG+CoJQe9Pm2+tAqirZQPVs36/5c78Zd41U4q6gaCiSO8vT+Ip4/+GA52W
 AFkfuIoY7dXYM95Qqkpust8L12oGcwL1d1+iZzrr/FQysd3G+VHmE7U3AquAGpo6mbfX
 /Wbwq5xrvbm9dbSkA3y8d+LVSwAEy9xDjRV4zzx0/gAwT2detMJzKSqcSnXoBSe5pzKT
 7ahw==
X-Gm-Message-State: AOJu0Yxbtg4R+TP+F4ssXCol3gl/a73dT9yjFDsMjVv67yE3JRkpOBM5
 85m7TG2kYhe/ykvVxmzDt1NaPkwtx4evJHnrnvY=
X-Google-Smtp-Source: AGHT+IFPtbeZTEtvhsezL2AoMfdpuoX6tGpQmrwKiYKm6uh1mlFDmDjV/cN574oH/xeZPHLhVT4sCA==
X-Received: by 2002:a05:6e02:1d91:b0:34f:2edd:9213 with SMTP id
 h17-20020a056e021d9100b0034f2edd9213mr1918849ila.21.1695178837895; 
 Tue, 19 Sep 2023 20:00:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 07/20] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
Date: Tue, 19 Sep 2023 21:00:08 -0600
Message-ID: <20230920030027.1385833-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

The debug UART on modern machines uses a 32-bit wide transfer. Without
this, setting debug output causes a hang or no output. It is not obvious
(when enabling CONFIG_DEBUG_UART) that this is needed.

Enable 32-bit access to avoid this trap.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot64_defconfig | 1 +
 configs/coreboot_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index e8165961c199..c04056339462 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -51,6 +51,7 @@ CONFIG_ATAPI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 # CONFIG_PCI_PNP is not set
+CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 311ca6672cbd..e7e45c2b0a9b 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -59,6 +59,7 @@ CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_NVME_PCI=y
 # CONFIG_PCI_PNP is not set
+CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
-- 
2.42.0.459.ge4e396fd5e-goog

