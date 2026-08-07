Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 295F0C5ACAB
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D002660A99;
	Fri,  7 Aug 2026 14:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QeEr0zB9j36u; Fri,  7 Aug 2026 14:18:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00FDA60A9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112295;
	bh=22twdDPlzE6ougAYmT3WyzNAN/m1M4ZIU3OdOIHcGnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PXWadfEC42ZI0DgmBRb05Jm+ls3MREBSgkX2EPOo4H+fGZRb0hPr3Dhb2PXd8UzZI
	 6lRpJPAPm+CHsBY1EBBnP1rLlXoF/aO7dMcAOwAv79XTnReFD3zD+ECmSVdlcpcp5v
	 DfoSmojwxD9wcy4kT1uTozk3LWLPENcsM0ZrsfdE3X+zH4nBpIE2C0u76qQGxIKNxv
	 ZbTMiEkEOJV1BxYVFmGDiG3tr5uxrNHQs7eqafDLhdQk0q0BUD5NbCpe4rmexxmIGv
	 YuBZYfZli+LiUT0dcjUe96z+EVDSGwohZfsjdFvUX7jQXXauMkWpW5FKPw6MIvVi2Q
	 sjErsZ7aI8Tww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00FDA60A9C;
	Fri,  7 Aug 2026 14:18:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45782259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3777C6077A
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O1mW6_Ip1Etv for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:42:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42e; helo=mail-wr1-x42e.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 508B1606E3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 508B1606E3
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 508B1606E3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:08 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so2013154f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102926; x=1786707726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=22twdDPlzE6ougAYmT3WyzNAN/m1M4ZIU3OdOIHcGnQ=;
 b=axZsxrJtlkvZ8GxHKU78g6a5ZXhbRn5vvC4ksuFqlmlP96a5b1QJpqb0P2tNHO92o4
 2NwaWLbvvbEq1ytiUHH+MLI/9ifvGsKaL+4dkxMxT/I/3O2WcSFBImhGNZhv2j2sSpoM
 ozmwxw4ssmK2h5B1uQD3rTg4z4VcB/tH21ZcDLVsC09qtZfYtu20UzTsa8SVLvq2Az3D
 +2HLMhb+hBN1ruUydmfDRr2gqvC4d4SI5W+kmIPeVLUXedBOxa2pHVh/+ykjitnI7Pz7
 gdmRbQl77VbUJN/d+LpOurCpaZ7WvMdXXcsZsvL6iCW8eWDSVPFm0v0mDJR60+EdCLYd
 AEkA==
X-Gm-Message-State: AOJu0YxAi/XgMJNVpxo9y0IcM7bZibFhC/3JyG3osP7EC/cRok4UM833
 8v5ctZy5GSWi6o5qiPwdRcEAjo/xJz6lTbSAUMJplYOsIZm6uPOiATh3
X-Gm-Gg: AR+sD114N+Fa72xgbvgT4vrhnWMja6f086by+v1MAYNicUSPCHe8uCbVxxeciEnOg0u
 2epUZrzUvteeeyERgax1i+QtImmTgw2PeLpMD58XfRRkuVpwBkgp+9iD4ccf0yXb+bYHX+kQoE8
 CeM+NrX1v3hPbs+B1NtshfbFw3w3f/o8tydC737ckrAnuq0LUmh6oZKC6Uo31UvbidtPRli3za2
 HnRd4dVaIunNaMLj2N4c46FfCktiBoZ6wG2x67flbcrKWwIovW38CJU1AEWjoqjwiRnRTGsF1fB
 faFNZYwelKoyOq1+qAhFhaa+xZfIuwBek1qQOVkKbFTeTMLumx3PJSp8FB4LNk+CF4m/3loEqJO
 7xodTDey9oJE1tBhMRQX56fJsD/LQJZ1Dwv7kj8YZQVO867OLDt7SiIFzw37UlD/xePFBpDW/7X
 5BYBOIzCD9vy2MgFtV6oiV+yEqvMDm5jdBEy7sZC0++d8=
X-Received: by 2002:a05:600c:1991:b0:493:e451:a9e1 with SMTP id
 5b1f17b1804b1-4994e7448d9mr273825205e9.2.1786102925998; 
 Fri, 07 Aug 2026 04:42:05 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7b2898sm42085455e9.4.2026.08.07.04.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:42:05 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 1/3] board: toradex: verdin-imx95: add SPL quick boot
 autosave support
Date: Fri,  7 Aug 2026 13:41:52 +0200
Message-ID: <20260807114200.271420-2-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807114200.271420-1-eichest@gmail.com>
References: <20260807114200.271420-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 14:18:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786102926; x=1786707726;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=22twdDPlzE6ougAYmT3WyzNAN/m1M4ZIU3OdOIHcGnQ=;
 b=KawncHTgPyg3JEdeBtpX5RLdd9fhEJbGYasQw4Q/j/XX1F3BIKNTnNU6RHnsCmd6oe
 nI8cqQ1KF8r6kU3CV4yTSee5grCAnztyGHlZxSrWRl4pc0vVjbYafVEDtxJ+rgDbbN4l
 GReJ4D2LIhSHUoRrYDS0Pn2QEMtPLmIoiheyTV3I74Dei9o79G6O9F9Se/rLyoLSENnr
 MO1X+HW7HXC9azAEgZh8oG3YX4dGy4zaiTEpNv4B2DySJ+/TX7F+1W2001MYR/p/1cj3
 BYLp/Bdra7rnzgSGAdIV143cimwGj364yRUZYbtsQmQzZber/B1l77hcINpE66guexrl
 8ZSw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KawncHTg
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Add support for the QuickBoot save feature in the SPL for Verdin iMX95
modules to speed up boot time by skipping DDR training if a valid
QuickBoot save is found. When CONFIG_SPL_IMX_QB is enabled, the settings
will be stored automatically from the SPL. Otherwise, the command 'qb
save mmc 0:1' must be used.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/verdin-imx95/spl.c | 4 ++++
 configs/verdin-imx95_defconfig   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/board/toradex/verdin-imx95/spl.c b/board/toradex/verdin-imx95/spl.c
index 9f501c11c1d..93e76be6145 100644
--- a/board/toradex/verdin-imx95/spl.c
+++ b/board/toradex/verdin-imx95/spl.c
@@ -6,6 +6,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 #include <asm/sections.h>
 #include <asm/global_data.h>
 #include <clk.h>
@@ -40,6 +41,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_imx_qb_save();
 }
 
 void board_init_f(ulong dummy)
diff --git a/configs/verdin-imx95_defconfig b/configs/verdin-imx95_defconfig
index daf41a8b830..d7076231bbe 100644
--- a/configs/verdin-imx95_defconfig
+++ b/configs/verdin-imx95_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_LOAD_ADDR=0x90400000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
 CONFIG_SPL=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_SPL_IMX_QB=y
 CONFIG_PCI=y
 CONFIG_SYS_MEMTEST_START=0x90000000
 CONFIG_SYS_MEMTEST_END=0xA0000000
@@ -60,6 +61,7 @@ CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_MMC_WRITE=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_WATCHDOG=y
-- 
2.55.0

