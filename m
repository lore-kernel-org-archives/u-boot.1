Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA48C2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94BF08127A;
	Fri,  7 Aug 2026 14:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LT5k0XHhW6n; Fri,  7 Aug 2026 14:18:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E352E8127C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112299;
	bh=q6U0JfyJOzLmHEVn4S/G8OSzXZvUh6dlOR939g4SuC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LPxGAd1A02FuOGPYbmxmFfq1rOlRxEBV2MWp24mqLz6QNsbvhBM2b8gj/dseY6Ozt
	 ulCI+AFn60COedco46NSwW8c9RPPnCckmXwge3GmD9hNlvMXccO0sxPyIjBogQbJxC
	 kNiP58JDv2YHkSInHwqriqSQBBV2HjY/Iz+oU7Cw+5NxWn5+wvaIZoFOP4vtKFiDqk
	 lYPJXj58nokDy5StS8V6YEAPvmuI0B9w2dF+phHoAPbt1SiGnh+O9HeBjOtPqD9fM0
	 e4nNPrT+/gk9CQ/dufekANYwhElPSqTU4m1hpYC69s4Vw6fxZ+h1XIeR+qlozwa1no
	 gNVFg/OPxQo4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E352E8127C;
	Fri,  7 Aug 2026 14:18:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1151D259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0356780EC1
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HbrP6n6H7ehI for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:42:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0504181149
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0504181149
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0504181149
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:09 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso23049095e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102928; x=1786707728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q6U0JfyJOzLmHEVn4S/G8OSzXZvUh6dlOR939g4SuC0=;
 b=StPFcT0zMTRwWwf6FP6olVjLJ1d3fQy3a1blL6DO69joYbp4NGdxUbM2dzP5m73v92
 re6DJsJukbhZW08OyUuz/ifCRwT7FF5nDUw4H52fwVtMIK0Y4ZEthAZfiF7X9GSHY/8E
 0ZPEf1fiLrcGpng+B9CYbJ8U9XywxYtZzb+vw21NC+d1EOZLVFWMsnC0BSq+KdaUEZcd
 SU/EurJqozdiuN1+BAjUhFz4wMfrIFHQn7IDRl8MNePplDzhtlsX7ib+0CIfL8ERmlSW
 Q8a822xo//XS7rvYVnjhsA4URjej4dR5WfdZyMaOAL/486ivhwMsWNSVo+D60Mj4cmCl
 uy9A==
X-Gm-Message-State: AOJu0YysD0jJl4R0nfTBv4GjuTChshOz8eT1HKe220zHsUKiOOu6qwhy
 eXC5lF4sbN49KC2SClqPXPfewilRvwMKUgaIz4wPciTCKEuY83asiiVd
X-Gm-Gg: AR+sD11cQZZBgdKMoGAxMxJjSqSM4stafebT8IPT6kTUliQeAffMSPgbBIQNwCC4TLd
 lYHJYeE1E90+85fSd2lAEjraZ4sxit/ThRSC+gLmI6pmgcrrLI16nL/b5fawqCNz/2v8VblAWRk
 jhBanDwg2oRazke5VGl0wKvMsc8fOO36AW8QHlR9+GLIW/7fFcG6ZuFcDh86uL1pfV4vAIPketN
 Ik9wEXi9WdDmw0K5a5YfE4HTZJk52ksScKmHn6tNLB8aVn1wVitlJA6BRYe4LRqeMVFSOhwBzRK
 EPGURb/WSoPd3L3i70PBQfgRJv/HWgbsN2evaq+ba4cnV6voFWKh23BwaC/++xYY5VQbiM20QPs
 f47/pkfdzyE+/TRtfY8IRbwwtZnNaEt0jlU9vaQEkYEEBdkFtvuDTDUQ9kHHza+tAP7y6QAmR8l
 ceC3/P5c+jSv5+xJbmLBY7x25lTxbc0EKajzeg411H4TM=
X-Received: by 2002:a05:600c:34d1:b0:498:1595:be7b with SMTP id
 5b1f17b1804b1-4994e794ee7mr327502225e9.4.1786102927846; 
 Fri, 07 Aug 2026 04:42:07 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7b2898sm42085455e9.4.2026.08.07.04.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:42:07 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 3/3] board: toradex: aquila-imx95: add SPL quick boot
 autosave support
Date: Fri,  7 Aug 2026 13:41:54 +0200
Message-ID: <20260807114200.271420-4-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807114200.271420-1-eichest@gmail.com>
References: <20260807114200.271420-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 14:18:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786102928; x=1786707728;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q6U0JfyJOzLmHEVn4S/G8OSzXZvUh6dlOR939g4SuC0=;
 b=KHQj7S3zSbUG3251ocIz00NnGV/nmnsr1ZoDsJBZtJ4x3vXudW4fnzZcV4gnNNTu0T
 Jy/WUTOq3q1xzJGiouNEJMuma85hG0CEejwCscwqH5+LHeDK2IGWc2a7ldCNWWSnr0U+
 ITuynoHFSGjlaUtSchcLPm6A6BKd6OqFRWx2RI8gtlNHDLrgfL8HWvM87OdmabVR69jD
 hA168VBaMIlf28tmHXYGnKHcsa0bz+kPAy8vRuB4DNnQNC6pw0aKl/DzOtELwkL2gWNK
 YbzxOb+3leZqCtrLV2KOy/9/c2hVipGOUaTL1Omfd71NUg+zRUIvZQBd539IvuIMkir5
 6HEQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KHQj7S3z
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

Add support for the QuickBoot save feature in the SPL for Aquila iMX95
modules to speed up boot time by skipping DDR training if a valid
QuickBoot save is found. When CONFIG_SPL_IMX_QB is enabled, the settings
will be stored automatically from the SPL. Otherwise, the command 'qb save
mmc 0:1' must be used.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/aquila-imx95/spl.c | 4 ++++
 configs/aquila-imx95_defconfig   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/board/toradex/aquila-imx95/spl.c b/board/toradex/aquila-imx95/spl.c
index 9f501c11c1d..93e76be6145 100644
--- a/board/toradex/aquila-imx95/spl.c
+++ b/board/toradex/aquila-imx95/spl.c
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
diff --git a/configs/aquila-imx95_defconfig b/configs/aquila-imx95_defconfig
index bb3d475ef4d..ee66cebfa4f 100644
--- a/configs/aquila-imx95_defconfig
+++ b/configs/aquila-imx95_defconfig
@@ -26,6 +26,7 @@ CONFIG_SYS_LOAD_ADDR=0x90400000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
 CONFIG_SPL=y
 CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_SPL_IMX_QB=y
 CONFIG_PCI=y
 CONFIG_SYS_MEMTEST_START=0x90000000
 CONFIG_SYS_MEMTEST_END=0xA0000000
@@ -59,6 +60,7 @@ CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_MMC_WRITE=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_WATCHDOG=y
-- 
2.55.0

