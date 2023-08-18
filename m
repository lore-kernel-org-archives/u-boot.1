Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126ADC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A51286C31;
	Fri, 18 Aug 2023 02:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ofdM3DVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6660986C03; Fri, 18 Aug 2023 02:27:27 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 787E386C00
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79198e7d9bcso39187239f.0
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318442; x=1692923242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYvCg3pLq093RX4ZW13+vBAiLOl5BdiYREIECtsEg64=;
 b=ofdM3DVYM5ozSbdK9/eDuLDU8j8wg0OYLKjihdDjfyBdeGf8khQ0HsmUDGgrLwIar2
 fVYuPtwXMEPFhp7GVWsoT6VTC8FVGB10KCbQrtiv3WtcGSsu0R6z9Je6ZIsooyu79GVL
 bcNbPUsxZYoelZ/BehKNThep3Uf/1yuosJdVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318442; x=1692923242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYvCg3pLq093RX4ZW13+vBAiLOl5BdiYREIECtsEg64=;
 b=DVzo/wyZSURocDx3a+aNA2KUwcb8Ez3Z6KoMgPShuOYdMVrdFMwU0eajDgzveRPZ0/
 M6qJrIFV2bocSwdTCcZ12Hm8h0F2vvBVJrUEehyxz+SY9qap2eyFue3SsSOm0R0tzxZf
 xYzXkrwiY05nH+gBgwrPFUiAALiJ2mJnMQvx2A6fGGqRUIp4cQQJyQcRh/CwUpa2U/cc
 adeNwakLjw+L2NGlBkidZ8mWHORv2S0s3RXYacI6wDQ+K066PiMJJOBOAbiD4bYrU6gQ
 qZD5MtSwEYPpLhOoIxAQv6gCyZYbuPJMokDQZ8B9hWcIq4pbvfC/a18FeirzU3RqEsag
 r4oA==
X-Gm-Message-State: AOJu0YwoqzL2pIKnl3XNL/Wq+voF+WJyUAv9wOuZG3912vCASK4fry/E
 oaRhPJxHZZLhC9cAI25IVoxFsmo+FhosT2PkElQ=
X-Google-Smtp-Source: AGHT+IFwDBcDNooaN5XaAzU/oNDRhHUlmn826EGGxrB4EkmHrYSkZTBiii5foOQxC8uxNrDyah8i1A==
X-Received: by 2002:a05:6e02:1523:b0:346:4f37:9ee7 with SMTP id
 i3-20020a056e02152300b003464f379ee7mr1147325ilu.13.1692318442066; 
 Thu, 17 Aug 2023 17:27:22 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 10/20] x86: coreboot: Enable VIDEO_COPY
Date: Thu, 17 Aug 2023 18:26:49 -0600
Message-ID: <20230818002706.853550-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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
index 2263554a47ce..e5546dadcb0a 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -60,6 +60,7 @@ CONFIG_NVME_PCI=y
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
+CONFIG_VIDEO_COPY=y
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_ACPI=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 790b84a87bc7..78694d635532 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -54,6 +54,7 @@ CONFIG_NVME_PCI=y
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
2.42.0.rc1.204.g551eb34607-goog

