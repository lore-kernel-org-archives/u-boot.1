Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DFDC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276288650C;
	Wed, 23 Aug 2023 23:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WfL9iy8J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794B1864E5; Wed, 23 Aug 2023 23:11:17 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19D3E864CF
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79264ca4b34so23659039f.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825073; x=1693429873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeN0sAorqfb9/fKDh96Of5nbP+zUwT7hbKMbcXpR3RY=;
 b=WfL9iy8JCR7W1yXY6szEMk/3S+j9oaAJa91Xwjjf2YrDSBBK1PKEJDteOJ1PV3YYs5
 NOAOO4Kbo3bJBYTwwOoOoxKBPpAeQKrATj9RrCvzmZwX81mp04avdGaYv8pDRSQdPSV8
 cm4qTMHPAmIK8ZAYG5Gh2/kl/PFZMtWp6ZDH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825073; x=1693429873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeN0sAorqfb9/fKDh96Of5nbP+zUwT7hbKMbcXpR3RY=;
 b=AsDPOvKd4h274AKJggYTlenmlreyVes6Psb1MgvcVLMBEVQLTaqKr1F6HCUeW4yr/i
 NGxW0Wa0FxAcBKLLo1LWZ088uOe0f9+3Gd1BM7x7vcne0qzvRHm/jhtInZ9qnH8yHURe
 S7sYgpjmHUEhav82CKOAAHwfyfLfGGCrqx98Adru5C76iTssBQ0ub+YfIDDwsx5c9md3
 Qlo3iotyabnIazkVSUCBcIXepDRIBm1BgVIT9o7QRmlwvn+vLyq2PfvJ1bgEcxK5xjSf
 xSwBVXguNJaxdok2gg+zogurhrniX6ULYwtYk1UIEj2RtG0yBr+RNT8+BHuuQ6D7qgg1
 gSFA==
X-Gm-Message-State: AOJu0YxKsoEpgU3pxNYYt9GeSmzQvwYQ/aAXr5EEyGkBTMkPu3F+T3Hn
 2ftKj4J4Qa7Sk5ANM2oI5WqbkGTXieU/MNaSStM=
X-Google-Smtp-Source: AGHT+IF03ACZBHuvfSZ0cGUVs/8VqBKw+UzctkligC2Kc97x1Mv3Fr09EUiWABq/gC5u44fjQjo39Q==
X-Received: by 2002:a6b:6514:0:b0:791:7e14:4347 with SMTP id
 z20-20020a6b6514000000b007917e144347mr4258954iob.13.1692825073751; 
 Wed, 23 Aug 2023 14:11:13 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/20] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
Date: Wed, 23 Aug 2023 15:10:24 -0600
Message-ID: <20230823211059.1235147-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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
index e8165961c19..c0405633946 100644
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
index 311ca6672cb..e7e45c2b0a9 100644
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
2.42.0.rc1.204.g551eb34607-goog

