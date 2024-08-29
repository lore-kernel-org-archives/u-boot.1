Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427B8C87FD2
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 18:56:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300A288C67;
	Thu, 29 Aug 2024 20:56:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ViuaQmtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D48BD88CFA; Thu, 29 Aug 2024 20:56:08 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B501F88CE9
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 20:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e179c28f990so972946276.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724957765; x=1725562565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bbg/2Y5Yk9K/4KA4fs9LNSb9T0pEWHrC+eBog3yOM/E=;
 b=ViuaQmtxmDZM7/aL/6qTx72z7Hhg9ka3yy/SrdCbeW/98gvAkPI2C1sgV7CgYd8Is4
 U09snqr20D8zidR3oGNMsv4Wjwy+KkDX5rsKbzlJwupRomL9YAzIQ4O3932jKyynvZ5t
 9HAOIMGDoFvlhgzugUbceijmvW109Cjz4eyEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724957765; x=1725562565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bbg/2Y5Yk9K/4KA4fs9LNSb9T0pEWHrC+eBog3yOM/E=;
 b=bzsM/gzUkRJ+AWogIR+tzRiWi3JARqP1pmeegLxbHgzcXe9swOc33aJLEpQEwVhWky
 pLko9FAQKKBH0puHuL2KIdmIzn9rfOpBJ4LxHQwXng87olmWLEiDmI5WALwwW4kTEhQc
 zJIfKxO5hhIyKxzEKrydlG/kDqrjjzS0JbyQZ9XohLTF21T/vMAYBg7bJBYsg8/4M3+H
 MRpKM5nBhG4+gr6NHXQ5HzblAOEQcNO6lV8tBc4jnDlV+Q0NsUwBSi4Dm84t/h9N31EV
 hxhFR5UgKU/aJh2XEIywGdtcEzjoC3mEfwVw6SUyrUsmAgLFPyPQhGFWp39k5pIrrR99
 r9tg==
X-Gm-Message-State: AOJu0YyIvl+UdrX/F/EbyGTrmkBbpAxVEfgcVdugQ4wLYfJhAYgf364/
 dGsSZo0mci2lAPmnv6+2ao+/0r4wuWUkhcMtLUzTW7CjuSnbRzg0jMhhXVBjiSdF2Xlon6REWwH
 T
X-Google-Smtp-Source: AGHT+IEhGyUQR+ag0H6BJWKEvP1Yjcdfo+JytxXZKCSiDSqn8mlIRqNI8v4EzUgZKCk5Q65vvBDiYA==
X-Received: by 2002:a05:6902:1545:b0:e13:d834:604a with SMTP id
 3f1490d57ef6-e1a5aca2c9cmr5232563276.32.1724957765255; 
 Thu, 29 Aug 2024 11:56:05 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340ca68b1sm7887866d6.111.2024.08.29.11.56.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 11:56:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [u-boot-test-hooks][PATCH 1/2] bin/writer.rpi_mount: Use kernel= and
 simplify logic
Date: Thu, 29 Aug 2024 12:56:01 -0600
Message-Id: <20240829185602.3179812-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

Rather than guess what we need to name our u-boot.bin file as for it to
boot make use of the kernel= option to always call it u-boot.bin and
then on 64bit platforms (and since future platforms use rpi_arm64 this
list should not grow) also pass in arm_64bit=1.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 bin/writer.rpi_mount | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/bin/writer.rpi_mount b/bin/writer.rpi_mount
index 73fb8bf6af04..ab7c3b5a2430 100755
--- a/bin/writer.rpi_mount
+++ b/bin/writer.rpi_mount
@@ -25,30 +25,17 @@ build=${U_BOOT_BUILD_DIR}
 
 echo "Writing to ${mount_dir} from build at ${build}"
 
+sudo cp -v ${build}/u-boot.bin ${mount_dir}/u-boot.bin
+
+echo "enable_uart=1" | sudo tee ${mount_dir}/config.txt
+echo "kernel=u-boot.bin" | sudo tee -a ${mount_dir}/config.txt
+
 case "${board_type}" in
-rpi)
-    kernel_dst=kernel.img
-    ;;
-rpi_2)
-    kernel_dst=kernel7.img
-    ;;
 rpi_3|rpi_3b|rpi_3_b_plus|rpi_4|rpi_arm64)
-    kernel_dst=kernel8.img
-    ;;
-rpi_3_32b|rpi_4_32b)
-    kernel_dst=kernel8-32.img
-    ;;
-*)
-    echo Unknown Pi \""${board_type}"\"
-    exit 1
+    echo "arm_64bit=1" | sudo tee -a ${mount_dir}/config.txt
     ;;
 esac
 
-sudo rm -f ${mount_dir}/kernel*img
-sudo cp -v ${build}/u-boot.bin ${mount_dir}/${kernel_dst}
-
-echo "enable_uart=1" | sudo tee ${mount_dir}/config.txt
-
 case "${board_ident}" in
 3-32-pl011)
     echo "dtoverlay=pi3-miniuart-bt" | sudo tee -a ${mount_dir}/config.txt
-- 
2.34.1

