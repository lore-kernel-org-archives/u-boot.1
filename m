Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA80C3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 12:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067E18778A;
	Sat, 23 Dec 2023 13:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AjQgJAk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4215C877BA; Sat, 23 Dec 2023 13:13:51 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C317875E3
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 13:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sigmaris@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d41555f9dso20876435e9.2
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 04:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703333628; x=1703938428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nnV1ekOMIGCfmz+CnhviC6hrKSsqc3TreEBbkhiZ7Wc=;
 b=AjQgJAk8uyuZ3zERhHBv9LQ7P66YxSf7Ne353Fsz2taO2teVC7KlmD3OTo1Hu9lMIh
 CBFaXktFDNmqEQu6842GY84gn34bPHO6BkZ5Vh4H04v1EKTzeKok9sYrAKaxRHNHgRDk
 flhdqUpZsofXuUq9GaDdUugWW00zELCFvJv4G7Obx0Ma2GHQX9DbyDfRx/eF7oFVeySJ
 K1tt11sfzegHsQsp37TiVl6ImpQLnaf0JTqxbKXMP2vd4DtUvLVrl/cKZYBdjCiq/NeP
 I+D3P2UHyIbakKpfmZEb8k2NYJa2vU4k70US8Mu+sk24oOtBpPwQUrsmscmz1Iwi8VxJ
 rc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703333628; x=1703938428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nnV1ekOMIGCfmz+CnhviC6hrKSsqc3TreEBbkhiZ7Wc=;
 b=qjtv4S/03pT683NtUR+mhCF4OeJgYbBUNO4r2aJxj7g7Z2G3btbx/ZEJtq+eAIb0ny
 HRrU0lRMfHn9X6CpfVVC/6+y98/hItVnJfVfygpGKW2Grs0jTOW+dfpwgk5x+cdG1RQX
 Hbvj1h8l+VG35xzjReXy8TPohviUhmJWHDjdMn83Xt7jzCegdIuGEmu1GzYst2yJTxGn
 VqFCJ+o2Uc/Re3LHbmKZKlu3cXXbAx1o4n526qC7ozNYekSuFq38ca2zEFr4KFcnBzVt
 PVkaTb1I/61GNd38k9GHkAxg/vf0KR/KRPWZ+2EV+k7S5NhpL0n59axMvDyrlnPwHAgJ
 X4pg==
X-Gm-Message-State: AOJu0YyoQjoSfPQNuJ8XRieoJKkjKTdoUa+A5sqAoCVOo8CCc8RbPKt2
 H/IliFtc6akAYF+DL9fOvFm4UepppcyrFw==
X-Google-Smtp-Source: AGHT+IHz+N/pTJXseOOkg3iMFMkcbXAFoCZlXkOLR3VTfdJm65jcyX66q/XakoZSHrrYBJP1E7Euww==
X-Received: by 2002:a05:600c:1614:b0:40c:32d5:18e1 with SMTP id
 m20-20020a05600c161400b0040c32d518e1mr1457525wmn.179.1703333627798; 
 Sat, 23 Dec 2023 04:13:47 -0800 (PST)
Received: from localhost.localdomain ([31.111.4.202])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c35cc00b0040d3dc78003sm9292934wmq.17.2023.12.23.04.13.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 23 Dec 2023 04:13:47 -0800 (PST)
From: Hugh Cole-Baker <sigmaris@gmail.com>
To: u-boot@lists.denx.de
Cc: Hugh Cole-Baker <sigmaris@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] rockchip: rk35xx: expand space for decompressed kernel
Date: Sat, 23 Dec 2023 12:13:10 +0000
Message-Id: <20231223121310.43790-1-sigmaris@gmail.com>
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
to this size, the FDT will be overwritten. Move fdt_addr_r and
ramdisk_addr_r higher in memory to allow 96MB for uncompressing kernels.

Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
---
 include/configs/rk3568_common.h | 4 ++--
 include/configs/rk3588_common.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/configs/rk3568_common.h b/include/configs/rk3568_common.h
index 1b7d3437b1..da5b38803e 100644
--- a/include/configs/rk3568_common.h
+++ b/include/configs/rk3568_common.h
@@ -20,10 +20,10 @@
 	"script_offset_f=0xffe000\0"	\
 	"script_size_f=0x2000\0"	\
 	"pxefile_addr_r=0x00e00000\0"	\
-	"fdt_addr_r=0x0a100000\0"	\
+	"fdt_addr_r=0x0e000000\0"	\
 	"fdtoverlay_addr_r=0x02000000\0"	\
 	"kernel_addr_r=0x02080000\0"	\
-	"ramdisk_addr_r=0x0a200000\0"	\
+	"ramdisk_addr_r=0x0e100000\0"	\
 	"kernel_comp_addr_r=0x08000000\0"	\
 	"kernel_comp_size=0x2000000\0"
 
diff --git a/include/configs/rk3588_common.h b/include/configs/rk3588_common.h
index 46389d087d..5fdbdb6fd7 100644
--- a/include/configs/rk3588_common.h
+++ b/include/configs/rk3588_common.h
@@ -19,10 +19,10 @@
 	"script_offset_f=0xffe000\0"	\
 	"script_size_f=0x2000\0"	\
 	"pxefile_addr_r=0x00e00000\0"	\
-	"fdt_addr_r=0x0a100000\0"	\
+	"fdt_addr_r=0x0e000000\0"	\
 	"fdtoverlay_addr_r=0x02000000\0"	\
 	"kernel_addr_r=0x02080000\0"	\
-	"ramdisk_addr_r=0x0a200000\0"	\
+	"ramdisk_addr_r=0x0e100000\0"	\
 	"kernel_comp_addr_r=0x08000000\0"	\
 	"kernel_comp_size=0x2000000\0"
 
-- 
2.39.3 (Apple Git-145)

