Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D44FCA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 08:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79BDB830A0;
	Wed, 10 Sep 2025 10:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MGyJ1xp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A8D08318E; Wed, 10 Sep 2025 07:40:31 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ACDC830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 07:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chalianis1@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-807e414be94so629430085a.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 22:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757482828; x=1758087628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4DG3FHM4I8DwOnxf+U8nb+dpj4IxtDp4CLyPTEPEEOo=;
 b=MGyJ1xp0oEPjHbftWPUTNwSudj7igJ2Swc4EjZeFW9Q3VXc9tz2MY7hpBoKE3Bg1IB
 69M+awIN67vl0aTgF6P0RqZxMOU+6UBi9KIYmG0ZnW5yusKbIUQ5HwoP0sl/ulrXqeR2
 Tu3+69Cd+3lbSbBGStSaNe5LMVq52fwbNI/sIpHSquAcbuo/ulc9q4tJBEkgNWtF8slQ
 Y9OJaPnJaa6epaZBtg+J+9cucwFWhJ+495Japb5HcS3TJC/0Q+yEmtZhZm5G6PfGwd4x
 ofwe6hzGxJ1zeLQ12+zlO5mDQ2EOZ+LOawOpSP8ySJi02cW5HhTvrOQnHa1blWANPdUf
 joow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757482828; x=1758087628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4DG3FHM4I8DwOnxf+U8nb+dpj4IxtDp4CLyPTEPEEOo=;
 b=ZGMv21JG63a6ekWW5PiFg4Y6IIvXyvxzfJaDgRmqacHEyQw4a5Ync+yXbmpnH+L1YU
 6K1aiXN765g1OA1NseFiqwzuCzeEPWOPr6mq+Nt6sPsB0M4M84Txa3bBPesAn3n6nJ/A
 jJRtxgqHCQWojUS5B8cfHRXcHXNk4CTbxs6uwknWj2VLLFqmNmaOeJFQDaD9Hi+Van5J
 hUdg3VUXeBEfmxjpGZbTDkisLh1ksYqNFc4kriSMlYhcc8VtVmFz90z0rCMMWc3/Ios3
 i/WpXFF9YN7Kt4FCdnUt/VGfUgn+/y8DKkOvpvLttvCkKxMvQlRzpin5JZwG4phDbmBS
 21ZQ==
X-Gm-Message-State: AOJu0YzurOGSjMyxSvd+hOUy2dTkXyyuabdFYYgcD0+ryt6VrC4D7Ry0
 X3MeAKAzs8EE40NaYjc67VS06zvil+NI09KdRxbNJaX2gj9ZAaCFgxUz
X-Gm-Gg: ASbGncsuiKGSaClR7nsfSbMLKCxpqTT5HFsNje4oob8+FAJTTxjxkYICTXo24FhdBnq
 frOqduzojV8gbuoFJnE8mYD33gNYmnJ/d3P+dyptaoUopF5QeJt9PSchBAlayJh8MVvToETgNky
 P3h+syPF6dXAr7pZtHq6MZI5jnAARFbsXNRCO3AhdIiaHwAGoZ585C9XxORw9wkApv/t0YscJY3
 7MQuHA4ziKMCAJ89CbDxayTpQxn+t7m67suVi3vgThF8hAHcUnVcKNadAANbpE97SvM6Os7j6sH
 X0jEx//jTszWyqBt5UEN5VFcmZzLTmeNc4hWgfR4YNrftk0qzfjlayGJeWrWiMXT79uR/OVSsBg
 Ydlkt6Jx9dNEsQFMix3D8ME7MZSdMy+5suML86D6uRli0b1pmnbGFc0BRIpqkg6UVxm5+fIsTK+
 mjl8lYrnJTVGwrInLriQbY0EySAQ==
X-Google-Smtp-Source: AGHT+IEJPpOT1Rrn8IeEnYhAtCU9XycL4H3X4FOOxcL94Moemr0fvMA8h79faALSLzD1Vm+Fo6cRAQ==
X-Received: by 2002:a05:620a:3909:b0:813:a1a8:d4e2 with SMTP id
 af79cd13be357-813c39a167dmr1269609485a.74.1757482827942; 
 Tue, 09 Sep 2025 22:40:27 -0700 (PDT)
Received: from Latitude-7490.ht.home
 ([2607:fa49:8c41:2600:3cd9:bfaa:3049:64a8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b5ed72b86sm230003385a.54.2025.09.09.22.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 22:40:27 -0700 (PDT)
From: chalianis1@gmail.com
To: trini@konsulko.com,
	patrick.rudolph@9elements.com
Cc: u-boot@lists.denx.de,
	Chali Anis <chalianis1@gmail.com>
Subject: [PATCH] arm: mach-qemu: add support for boot from TF-A.
Date: Wed, 10 Sep 2025 01:40:12 -0400
Message-Id: <20250910054012.2055983-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Sep 2025 10:19:06 +0200
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

From: Chali Anis <chalianis1@gmail.com>

add support for boot from Arm Trusted Firmware for qemu aarch64
permits to exprement TF-A boot, Tested on qemu-system-aarch64.

Signed-off-by: Chali Anis <chalianis1@gmail.com>
---
 arch/arm/mach-qemu/Kconfig             | 1 +
 board/emulation/common/qemu_mtdparts.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
index 9c06c6a3a5ce..316dde5145c0 100644
--- a/arch/arm/mach-qemu/Kconfig
+++ b/arch/arm/mach-qemu/Kconfig
@@ -18,6 +18,7 @@ config TARGET_QEMU_ARM_64BIT
 	bool "ARMv8, 64bit"
 	select ARM64
 	select BOARD_LATE_INIT
+	select ARCH_SUPPORT_TFABOOT
 
 config TARGET_QEMU_ARM_SBSA
 	bool "SBSA Reference"
diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/common/qemu_mtdparts.c
index c1501276789c..c3863d3b0479 100644
--- a/board/emulation/common/qemu_mtdparts.c
+++ b/board/emulation/common/qemu_mtdparts.c
@@ -59,6 +59,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
 			debug("mtd device = %s\n", dev->name);
 		}
 
+#ifndef CONFIG_TFABOOT
 		mtd = get_mtd_device_nm("nor0");
 		if (!IS_ERR_OR_NULL(mtd)) {
 			mtd_partition = CONFIG_MTDPARTS_NOR0;
@@ -72,6 +73,7 @@ void board_mtdparts_default(const char **mtdids, const char **mtdparts)
 			board_get_mtdparts("nor1", mtd_partition, ids, parts);
 			put_mtd_device(mtd);
 		}
+#endif
 	}
 
 	mtd_initialized = true;
-- 
2.34.1

