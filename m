Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7221BC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0456C86A76;
	Thu, 17 Aug 2023 03:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SKQqc2kl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984FD86A52; Thu, 17 Aug 2023 03:52:12 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C975E86A75
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bca5d6dcedso6045390a34.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237127; x=1692841927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWDR8IJMgWgcJCIg01y99vhhEV+uQ7u4sRXD7rHsa1I=;
 b=SKQqc2klp+h8y7vVbPTLuEu52Q0yF78yhxe6k+JxyuxuUbr236va8CIzN0C/qYuAS2
 fIrksBABabHS/f2Hzh/BwN91tt9X5AJulNUq+riuD7paiJR1Lygv8AjzQDrgxDbY0Zlx
 VegHNaysYYR45ID1jBL/VyKSdBseFSOlVDCfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237127; x=1692841927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWDR8IJMgWgcJCIg01y99vhhEV+uQ7u4sRXD7rHsa1I=;
 b=Y0D/AnUzamg1bDnjSz60mq9SpCFiM8/MOoyxAcldqw6N7OJ9YpbemxmUfZfPOJVRWx
 CATVsYrGwETb0YeomtWHX1yQrqVycP6yaLlTAzWB4Y8RFRp/246Bxs1UpHje8CSNPS7/
 MxppKM4w+8XkNyG0NmUKCkaa1OhASMtD6txYdvbohyhW9J/4fp52Jw3TGlvu1tmwbzQG
 02r/Nr+MPh92S0PCsAG8MHjS4cYND3uaKSwIxoAo3yOfv5+8A9wPulKkB/d/4Vj1kekf
 GANZg9WjGYaOHKi0qaBrZ6MS+wiv3Iwjip1uChhDPvDxq0TupAr8o9ZRnPwWOxwyI+2r
 L1og==
X-Gm-Message-State: AOJu0YwcMn9IvgpPnNTpI3i2Dfrv4kcwUvpvXpqUm6dt+NzGmwrG0nWW
 WD+s0w3J04wyvP162gIcj8gPRE44fi2ap6S3/cw=
X-Google-Smtp-Source: AGHT+IFYR2edxNxfTiLKUOEnrI/Sggnbq+SD7pz3IFzSzDQeCXFbd6jnnFE6QXN9HNS9vzYMv+zImg==
X-Received: by 2002:a05:6830:20c9:b0:6bc:c9e6:30b7 with SMTP id
 z9-20020a05683020c900b006bcc9e630b7mr3804987otq.26.1692237127374; 
 Wed, 16 Aug 2023 18:52:07 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 9/9] x86: coreboot: Enable VIDEO_COPY
Date: Wed, 16 Aug 2023 19:51:44 -0600
Message-ID: <20230817015149.774847-10-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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
index e5cb3f3d4ebd..54360255c691 100644
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
2.41.0.694.ge786442a9b-goog

