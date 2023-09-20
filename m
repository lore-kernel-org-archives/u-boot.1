Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77782CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C249186C87;
	Wed, 20 Sep 2023 05:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ia8ATQEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF45D86C66; Wed, 20 Sep 2023 05:00:43 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E520186C0E
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7927611c54bso253320639f.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178840; x=1695783640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93Mr9u995mITdoMWqCCXYwKCiRhUkVWPfoheu6/uUMM=;
 b=Ia8ATQEZkrtsCdao//pcEND0BuX0/8RrzLbyuLoSdFSN2/8PIM3WXSFKtfyZ//2SLL
 Dkj+iX59o6ECGjGNNMCjjtX8LV65OxyR3LuCDlKpK3BVvsWH3RHKdspW2dvoQ35wa7hX
 /i1EXTAlmvbpvaWt1QZFFuKDf2LlLYtA6r8Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178840; x=1695783640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=93Mr9u995mITdoMWqCCXYwKCiRhUkVWPfoheu6/uUMM=;
 b=qPX/ILAwf5XqURPV82VKyh0e/M+JFgtcfmFP960n0WPo0Py9AqIxeJvm70els70dk/
 kjmUBEmKjBuhZghvS+VWr+vL1sQdKPJAzf5LSxEOT1wg1qEz0V2oJXFYRdyoA5QMgiTk
 qZDdVde4LtO3huzjQ4oSS7GWbChviUev+65NwlpZxonF5z77TZK7MgVmQs9PT9OxoyaZ
 eVlEpr7QL1eIgocIL9HVwNaP/zTdbhNESa9n/M0RSPPw4fdw5CGQG5vpq+gQJ0Naj66u
 KvI7BH09FTHXyWgBIDhpJpjv9D0jUWpXo2u4rXSr1g/rTVyUu2O1qbTe7bsh4r5sHcSV
 vZ0Q==
X-Gm-Message-State: AOJu0YyRiQWqM/RwPwcHFOBBAzw/DUuW5PWOWM7nnxV7C3/mrje1vGVh
 Nwa/D0Uzai9Zo4J4GmT9/DGeOm2W4xdkIHfWMlk=
X-Google-Smtp-Source: AGHT+IHDaV7kJaeLAJ8ob10fvhT9IqNwaDdRy5Gl4jktwlnoSWZ2D5+CIExaO13CgFAbwGy0zPtd5A==
X-Received: by 2002:a05:6e02:219b:b0:34f:1e9c:45e0 with SMTP id
 j27-20020a056e02219b00b0034f1e9c45e0mr2014113ila.3.1695178840487; 
 Tue, 19 Sep 2023 20:00:40 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 10/20] x86: coreboot: Enable VIDEO_COPY
Date: Tue, 19 Sep 2023 21:00:11 -0600
Message-ID: <20230920030027.1385833-11-sjg@chromium.org>
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

At least on modern machines the write-back mechanism for the frame buffer
is quite slow when scrolling, since it must read the entire frame buffer
and write it back.

Enable the VIDEO_COPY feature to resolve this problem.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 arch/x86/dts/coreboot.dts    |  1 +
 configs/coreboot64_defconfig |  1 +
 configs/coreboot_defconfig   |  1 +
 drivers/video/coreboot.c     | 12 ++++++++++++
 4 files changed, 15 insertions(+)

diff --git a/arch/x86/dts/coreboot.dts b/arch/x86/dts/coreboot.dts
index f9ff5346a79b..0eb31cae42c1 100644
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
index dc3548aa736c..555d281ef3cf 100644
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
index 630eb9aa384c..edc38f1f5923 100644
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
index c586475e41ed..5b718ae3e5a5 100644
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
2.42.0.459.ge4e396fd5e-goog

