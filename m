Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBA1C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 16:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9740987786;
	Tue, 26 Dec 2023 17:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efEBGmzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E8E87809; Tue, 26 Dec 2023 17:43:54 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870618772A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 17:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sigmaris@gmail.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-68009cb4669so13402656d6.1
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703609031; x=1704213831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ba4pyOaX09uGSocPIMFMwpa7Brm9vfB1iRXDGmFqJbg=;
 b=efEBGmzqvTjDCRsNOnSv3aS9SA4YQw2ZDFbYVfkuu1wbIHnqcDVM54C4WyJvSaPGgI
 /l5GuTT3wpq/EmHa2L+PmzYNo8IdFl0n/RFm1otFhkwzxOPc2KryWmFim5gq9D1v9jI9
 GWqMK8DymVMDpxecc1Tw+2mX+A5Kxm7wTUFawwBFDO4ziVR1fKWGlX0sx1hsbPZl962T
 XiQtEDXg+R70ZjfYQLDJ3c8zUdzfM9fKNDP8z0ZxjONo5IIfsupqaTzFtt0t1lOIc11S
 9jWf+nY+GUIlIn3/1QAlc2DYe8vk8ouUBp905NH0RGqoNKAbIzOBkHUXdnV2q41onecf
 XixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703609031; x=1704213831;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ba4pyOaX09uGSocPIMFMwpa7Brm9vfB1iRXDGmFqJbg=;
 b=R+jOV8k7Qm67yXfTrNn16qEzjEsPANoOPn72C+G1aG/NYTqmoDk/cQcgqRa2LzRuY2
 cAW5dP65Gn8xWg0Jva/s7IJXv6LYq2jLln48ywC9gcDK+gN4sp+tvL0Q0x1MTz9DJFC5
 tlKMHe6NmM1WKXS7XHgtgSYX+zJuw9a/TDoI908WDEdOXEwjB4ZvE+q/c7iAzw0c81lj
 MgOHMHZLZycv6k//e544zTZcgvcK4f/z+8cjT/mpL2g7i6W2CB2FyQuvAmfu6NSrVk2F
 03RxylLP6ItjPnU9RpsJHd+dgNnggrfnFeR3AAlQaKQ9wghwowi2IlXbcq2u9jPyt1ZS
 X4gQ==
X-Gm-Message-State: AOJu0YzAqqQ/BTsxgZy2RpXD0vU++JqVnXrISbec2bVXoaw8ySBaJnlX
 brvh8AVRXibiDa5eQhooN1hHoz+X5fMvug==
X-Google-Smtp-Source: AGHT+IElIqW9b7uijH6D1C6arjYL4PIFE1QH+QiusJubieo2cRgQgAYQhWB73FZzx9sMK0Ht8MoKug==
X-Received: by 2002:a05:6214:e8e:b0:67a:a5c3:8110 with SMTP id
 hf14-20020a0562140e8e00b0067aa5c38110mr13522947qvb.3.1703609030844; 
 Tue, 26 Dec 2023 08:43:50 -0800 (PST)
Received: from localhost.localdomain ([31.111.4.202])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a0cf74e000000b0067f0071e3a9sm4705812qvo.29.2023.12.26.08.43.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Dec 2023 08:43:50 -0800 (PST)
From: Hugh Cole-Baker <sigmaris@gmail.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 John Clark <inindev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Hugh Cole-Baker <sigmaris@gmail.com>
Subject: [PATCH v2] rockchip: rk35xx: expand space for decompressed kernel
Date: Tue, 26 Dec 2023 16:43:30 +0000
Message-Id: <20231226164330.63725-1-sigmaris@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
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

An uncompressed 6.7.0-rc1 Linux kernel Image built with the arm64
defconfig is about 40MB. This does not fit in to the space between
kernel_comp_addr_r and fdt_addr_r, so when uncompressing an Image.gz
to this size, the FDT will be overwritten. Rearrange addresses to have
128MiB for the kernel and its decompression buffer, then devicetree,
overlay and ramdisk at the end.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
---
Changes from v1:
Reorder things to have to have 128MiB for kernel and decompression space,
then devicetree, overlays and ramdisk.
Update kernel_comp_size to 128MiB.

 include/configs/rk3568_common.h | 12 ++++++------
 include/configs/rk3588_common.h | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
index 1b7d3437b1..48f93083de 100644
--- a/include/configs/rk3568_common.h
+++ b/include/configs/rk3568_common.h
@@ -20,12 +20,12 @@
 	"script_offset_f=0xffe000\0"	\
 	"script_size_f=0x2000\0"	\
 	"pxefile_addr_r=0x00e00000\0"	\
-	"fdt_addr_r=0x0a100000\0"	\
-	"fdtoverlay_addr_r=0x02000000\0"	\
-	"kernel_addr_r=0x02080000\0"	\
-	"ramdisk_addr_r=0x0a200000\0"	\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"kernel_comp_size=0x2000000\0"
+	"kernel_addr_r=0x02000000\0"	\
+	"kernel_comp_addr_r=0x0a000000\0"	\
+	"fdt_addr_r=0x12000000\0"	\
+	"fdtoverlay_addr_r=0x12100000\0"	\
+	"ramdisk_addr_r=0x12180000\0"	\
+	"kernel_comp_size=0x8000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS		\
 	ENV_MEM_LAYOUT_SETTINGS			\
diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
index 46389d087d..70430612ef 100644
--- a/include/configs/rk3588_common.h
+++ b/include/configs/rk3588_common.h
@@ -19,12 +19,12 @@
 	"script_offset_f=0xffe000\0"	\
 	"script_size_f=0x2000\0"	\
 	"pxefile_addr_r=0x00e00000\0"	\
-	"fdt_addr_r=0x0a100000\0"	\
-	"fdtoverlay_addr_r=0x02000000\0"	\
-	"kernel_addr_r=0x02080000\0"	\
-	"ramdisk_addr_r=0x0a200000\0"	\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"kernel_comp_size=0x2000000\0"
+	"kernel_addr_r=0x02000000\0"	\
+	"kernel_comp_addr_r=0x0a000000\0"	\
+	"fdt_addr_r=0x12000000\0"	\
+	"fdtoverlay_addr_r=0x12100000\0"	\
+	"ramdisk_addr_r=0x12180000\0"	\
+	"kernel_comp_size=0x8000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-- 
2.39.3 (Apple Git-145)

