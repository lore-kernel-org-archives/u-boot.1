Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6A7EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329AE86EFF;
	Sat, 19 Aug 2023 23:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mDk32Ynj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4691686EE5; Sat, 19 Aug 2023 23:23:30 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4741E86E8E
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7910620f45dso80217739f.1
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480206; x=1693085006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYvCg3pLq093RX4ZW13+vBAiLOl5BdiYREIECtsEg64=;
 b=mDk32Ynj3ZLeeDRjpkBmdjSy3oDIHHLkbdps8JHfOj/+7RKd0k+qSDpC49HaFhTlEL
 SZRN5+ddkEKDFhyVP+JtNy/xf8O8sXFoI+R8X3STHxnJa5BjBwW+ruD7BKtiuKeHQ90b
 AJMBLhvNMQ3vw6b7NVp+TbzNUatdxoJoyFmQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480206; x=1693085006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYvCg3pLq093RX4ZW13+vBAiLOl5BdiYREIECtsEg64=;
 b=Zplsk0Y03FiugXuzGxzg4RWVkXbI7EzzgOdoW8gvYObYCxcJnFaxnIGIw4KPESbKKE
 pDUeLGbfZzN81kdDKXgzBx2pUXiO95CtKe1V1hVRJdr3LfdikhuAd0XVnqN1oCoTCKsQ
 hEZv6NnVLMOpoGhFqobOO5uSbT8fZpId9wM6q1FGkGUbtIfThf/cFDYzEMTmvvAwJIn0
 YpXXKvdSewb6py03+4w4eFu+x+0xlfTgKLnn/U/Dy9RdcxG993zxMTyB7/8iKHFgsHD7
 gJvAAd8JkYG3pepJxOsK75StFWrvO6pq1pprwvrLWsEI+hBVlETsX1IWmtuqxyCXk3ZM
 LBAQ==
X-Gm-Message-State: AOJu0Yy/lb62F6QAX8x5ZfflKst6X04voXPmbHHS5oUV4scLdIHFKq2z
 KiJ6YpBOdLKiXpLjVzYT1Rc4WBMX9t7cugRnSHY=
X-Google-Smtp-Source: AGHT+IEoRFirkr8OqgWSbPJeZxDTh4cRAXHJwP9Sd/ewWyEzSpIMBi/Ts3gDSgOtyfaN95hLNG38Vw==
X-Received: by 2002:a6b:6013:0:b0:783:5e93:1e7f with SMTP id
 r19-20020a6b6013000000b007835e931e7fmr3224490iog.18.1692480205837; 
 Sat, 19 Aug 2023 14:23:25 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 10/19] x86: coreboot: Enable VIDEO_COPY
Date: Sat, 19 Aug 2023 15:22:48 -0600
Message-ID: <20230819212309.1094440-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

