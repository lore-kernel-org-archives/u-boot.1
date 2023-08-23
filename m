Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576C1C3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:12:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5FE86511;
	Wed, 23 Aug 2023 23:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N4OoWD0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC56855CE; Wed, 23 Aug 2023 23:11:20 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D97B864CD
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34cc8e8cbd4so2817795ab.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825076; x=1693429876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbGQGG+aHql2qmQU8oaSalZruQsJEurtLO5AiUU4rXI=;
 b=N4OoWD0Cg5IXThHrRv7i8781YkKTxoZaHhfzRmpCscIGN8vzOnuCpKClLRSWu+Sgh0
 c6zgFUdZQsquyrUhtNUjmfdYKD7/S1YzMq9iXCGppkplV+WUH84TXBGbv18FyHn9Dnaz
 womFIDfZzqHfd1+mC1Jo97woXb6gvmJ4gQh1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825076; x=1693429876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nbGQGG+aHql2qmQU8oaSalZruQsJEurtLO5AiUU4rXI=;
 b=MdtYUTQmNT231YYzW+qDPsD/LNsHSFGk59/E9Q+/t0/wtOI6/h98wim6mL3MWhnJKT
 IEKVsxT04ibZosU3Hq2O+E9r/UgdPM6ZhnkquaV14twJ+0dMzBq0+egY5hSgk4nlhJhO
 wZIcLplOhXHM7k8utAHKrf6hLVyqcWxQyltbnxmERap+RyrOhnUb0cQrXcxCnCNArYdJ
 wJViVptb+R1Dlso+YjJnMF5+DI0CKQPl+eehkaGKjenHn+QK23rz3z/dtjUDmygjVZ3s
 dvWqS2zAINte3JANrxhSF0zSDsj7qD5Qh0GRAPeiIEGKygXNNvcsgVP532Q2sZWtCg7U
 FL8A==
X-Gm-Message-State: AOJu0Yx3Dn1p54OCaoiPMXcmrPpLl1BxMYWgPrPh9x6uv7+Mkge2r1Gh
 kZlCY3lT8B3L+BH9RqhqEDsJCwgVfrejGRtgrGk=
X-Google-Smtp-Source: AGHT+IEZl3XVMS+K9Rt7xXyv2sLSnvnB55JPcn2zDbSybpEIkpFTESym9xQVelT0nw9RMXJsM2o2eg==
X-Received: by 2002:a05:6e02:e13:b0:34c:a244:bb9c with SMTP id
 a19-20020a056e020e1300b0034ca244bb9cmr3205792ilk.21.1692825075901; 
 Wed, 23 Aug 2023 14:11:15 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 10/20] x86: coreboot: Enable VIDEO_COPY
Date: Wed, 23 Aug 2023 15:10:27 -0600
Message-ID: <20230823211059.1235147-11-sjg@chromium.org>
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

At least on modern machines the write-back mechanism for the frame buffer
is quite slow when scrolling, since it must read the entire frame buffer
and write it back.

Enable the VIDEO_COPY feature to resolve this problem.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/dts/coreboot.dts    |  1 +
 configs/coreboot64_defconfig |  1 +
 configs/coreboot_defconfig   |  1 +
 drivers/video/coreboot.c     | 12 ++++++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/dts/coreboot.dts b/arch/x86/dts/coreboot.dts
index f9ff5346a79..0eb31cae42c 100644
--- a/arch/x86/dts/coreboot.dts
+++ b/arch/x86/dts/coreboot.dts
@@ -42,6 +42,7 @@
 	};
 
 	coreboot-fb {
+		bootph-some-ram;
 		compatible = "coreboot-fb";
 	};
 };
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index dc3548aa736..555d281ef3c 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -59,6 +59,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
+CONFIG_VIDEO_COPY=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 630eb9aa384..edc38f1f592 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -53,6 +53,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
+CONFIG_VIDEO_COPY=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/drivers/video/coreboot.c b/drivers/video/coreboot.c
index c586475e41e..5b718ae3e5a 100644
--- a/drivers/video/coreboot.c
+++ b/drivers/video/coreboot.c
@@ -73,6 +73,17 @@ err:
 	return ret;
 }
 
+static int coreboot_video_bind(struct udevice *dev)
+{
+	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
+
+	/* Set the maximum supported resolution */
+	uc_plat->size = 4096 * 2160 * 4;
+	log_debug("%s: Frame buffer size %x\n", __func__, uc_plat->size);
+
+	return 0;
+}
+
 static const struct udevice_id coreboot_video_ids[] = {
 	{ .compatible = "coreboot-fb" },
 	{ }
@@ -82,5 +93,6 @@ U_BOOT_DRIVER(coreboot_video) = {
 	.name	= "coreboot_video",
 	.id	= UCLASS_VIDEO,
 	.of_match = coreboot_video_ids,
+	.bind	= coreboot_video_bind,
 	.probe	= coreboot_video_probe,
 };
-- 
2.42.0.rc1.204.g551eb34607-goog

