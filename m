Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98413EEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AE087097;
	Thu, 14 Sep 2023 18:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jwZrIsUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324288708F; Thu, 14 Sep 2023 18:56:41 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F8E869F1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34df2a961a0so4064045ab.2
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710597; x=1695315397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2pjP2MEVV/cY3BWLBwElJrCfJ+SDBoevgTl6OLv0WI=;
 b=jwZrIsUD/fzHaCawwuTYQ1SwwmRlx3oF1Yn2LhQb4SmZia9LwHDrkg3lMi9yMHDYBM
 i1DXhgz4z+8uRyjg/NeoewhWwigAiKO9C8Y7/RzG1NO3kftHLHUOkjnuWonSsIFDLDsw
 YN1wQvmtpXBHwlU/JnwhGpKwxp6wF7MoMnkaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710597; x=1695315397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2pjP2MEVV/cY3BWLBwElJrCfJ+SDBoevgTl6OLv0WI=;
 b=V5OwgydGnVLTBgiaeKrbzdIokQldeLm+125cB0rm9EAN0qBEckO5RNmZMLN3MEzmkQ
 iXvBQ0XM8kJvowSillrJCD7oRpQ3y4G8hXFC5dxy/SmqY7v1aMAn5atmnnhL8tOQJTWQ
 vOE8iab14ClVlHL2mfcGxNSPIkGJcuQg7R7P6DjLmsB72CvVH74ItWex7gXF9pMLI0sj
 SrzbZELaK7RMHQ7pf9kLwPE5NQUCB/ZIgQosoi8G+C1HrdvIG9tD8I2UjZ/1M4cVfPWg
 /icCdFnnd9yglA7aUDD1DkBJZs8gLoLi32Kyw4Uam2iuwyGoooP01b/KBrZPUD7eC0f9
 OrDA==
X-Gm-Message-State: AOJu0Yx10VjFQiLIQAFjvex3d8maUg0YkRHwPCUTIDBXmhMTjWx1OIRP
 PpfvRh7/ToVZsuSKVC/IatKihc94MQHyz/tiQF0=
X-Google-Smtp-Source: AGHT+IHagCyJ/8nZUw3TgWMRY0ArjNraX0Lzn4aDUQOBR4+Ah1zDDINpP1XptYJzCcPY31vjFqplQA==
X-Received: by 2002:a05:6e02:1c83:b0:349:a4f8:8815 with SMTP id
 w3-20020a056e021c8300b00349a4f88815mr7581796ill.2.1694710597773; 
 Thu, 14 Sep 2023 09:56:37 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v5 07/21] boot: Move fdt_support to boot/
Date: Thu, 14 Sep 2023 10:55:45 -0600
Message-ID: <20230914165615.1058529-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

This relates to booting since it fixes up the devicetree for the OS. Move
it into the boot/ directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Makefile                  | 3 +++
 {common => boot}/fdt_support.c | 0
 common/Makefile                | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename {common => boot}/fdt_support.c (100%)

diff --git a/boot/Makefile b/boot/Makefile
index 10f01572237..f15a161614f 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_QFW) += bootmeth_qfw.o
 endif
 
 obj-y += image.o image-board.o
+
 obj-$(CONFIG_ANDROID_AB) += android_ab.o
 obj-$(CONFIG_ANDROID_BOOT_IMAGE) += image-android.o image-android-dt.o
 
@@ -37,6 +38,8 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 endif
 
+obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
+
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
 obj-$(CONFIG_$(SPL_TPL_)FIT) += image-fit.o
diff --git a/common/fdt_support.c b/boot/fdt_support.c
similarity index 100%
rename from common/fdt_support.c
rename to boot/fdt_support.c
diff --git a/common/Makefile b/common/Makefile
index 0a3f75f2f1c..0948721d0b4 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_DISPLAY_BOARDINFO) += board_info.o
 obj-$(CONFIG_DISPLAY_BOARDINFO_LATE) += board_info.o
 
 obj-$(CONFIG_FDT_SIMPLEFB) += fdt_simplefb.o
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
 obj-$(CONFIG_MII) += miiphyutil.o
 obj-$(CONFIG_CMD_MII) += miiphyutil.o
 obj-$(CONFIG_PHYLIB) += miiphyutil.o
@@ -51,7 +50,6 @@ ifdef CONFIG_SPL_DFU
 obj-$(CONFIG_DFU_OVER_USB) += dfu.o
 endif
 obj-$(CONFIG_SPL_NET) += miiphyutil.o
-obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += fdt_support.o
 
 obj-$(CONFIG_SPL_USB_HOST) += usb.o usb_hub.o
 obj-$(CONFIG_SPL_USB_STORAGE) += usb_storage.o
-- 
2.42.0.459.ge4e396fd5e-goog

