Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6464CC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:18:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 273FF60AA6;
	Fri,  7 Aug 2026 14:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r2noSv1vaNap; Fri,  7 Aug 2026 14:18:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0544560AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786112297;
	bh=Me0/IqqtdLbK0RHSMIDCFpqGcmJOpwyzolK+jzIYIgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P25mr5Y1RTSLHp0bOaUWkAlLWpJoIgQ8OfSK0CtGBYmsMSVR54YzKjpdlAzrlLDYv
	 op7pI6bzsAjSlJsAtMR9ID2iywQw1+FNLuatWzc+iByUzGOZ4qdtoW9FEMX+sQfTHp
	 pt1TI5tHpvIicy0uKAGZATrpQAmwMeobwZvsk8d3jv//Di1wrZHXxwjC3k2isELufv
	 Sdi1+TRW34Umz3jMY3ixL3ZuQUycSstHf8gQ73G+1msEdU3gpzMtHH6Cd58+OVVUQ8
	 Xr+MRqL5B5okJhLaWcz6DvDyNSZca31U3k0E4miOpbTQ5wZqeMQFtYrkVRETx0xm7g
	 Sv7aaGoD86ngg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0544560AB0;
	Fri,  7 Aug 2026 14:18:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 100252F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA961606E3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AE7aG5vS3Sad for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:42:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 155606070D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 155606070D
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 155606070D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:42:08 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47362928f65so2722431f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786102927; x=1786707727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Me0/IqqtdLbK0RHSMIDCFpqGcmJOpwyzolK+jzIYIgg=;
 b=gp3ULrDR4E56XSZ4V77vg/ADZGOoCICDMe+tW5pHl9f8XmgQW5yVo1q4hEdehwkBPP
 LG9J7sJyVtM8GOR9SGuY/aCup4TLgPqoqXQvAX/J1e+6o4S/eX7sF1OxG8SmyPE2S54Y
 yIBLeOHPZyPlHSFsEiktMWOMO46kNRoc8K6rW/Vae6vJPKerSSkAwP83fPC0luV5S4Vy
 gebiblxMc2uXsRVEUPCtyO5On76+LsugyovlwXy4lPMPbvRXh2yHwlYK9jeunQkkMAkb
 tY2fvHdJpHIp3U1DxWy5+/x6PSVdpe/km0ghttULKXE/zXxeSnTXTIWw6ZlxHwwhc0vW
 KGBA==
X-Gm-Message-State: AOJu0YxTEdKykUNl8ArkyVz4ZqjlCeapVgE/KS9nVqQuhF2VIWiDSy8S
 QuIzxJBG+w5PTiClY+mdmMArdGolAPiLbRTKFCM58KfDeb+vGHEhCYU0Clamwl6C
X-Gm-Gg: AR+sD12aLYpFW26p24deL6sLIYYIOksQREhe04lpFFMmMFYgIvG5TwMp61B5kctxIHp
 6XfA/4NUUPM7PaXiDna7uIjJ0otLy+MvN9RUNmUiO/jfjjB0kVw0Rf+2eqYYdZWCG6hdbrJOBOd
 hLHlZxd/ls1cT6kPqBr503DQDKm6pbNp5zL/JY+10ok8gDC+ADNiiwGHA3P1o0ktnNBbg2AKdKK
 zIPUiducc5zzqgy8dd9zzQxaQVvk5UQZ+jLp5FXHgq4oufwr19JVUHVydLeJdgJ9t0uHh+QZgT6
 HA1M/EiMh/UQN/VssG1zNZvN4Wh5lkDw4RWdXREph2DobfpUa/nmiSmnpG6fmLQKuTu6jWK7IrX
 OY//ckOguXeqbL5GqLkeGIyB0JHalg1ke50F3J9omY7ASyzMzJKuQtD+6b01k/lObF8OlYvqhFa
 1DXaZwchlPnndT7sCUDRUrT7ARkf0QQVEp91pSx38r9Vs=
X-Received: by 2002:a05:600c:4e87:b0:495:573e:1c54 with SMTP id
 5b1f17b1804b1-4994e7c1122mr268295825e9.9.1786102926862; 
 Fri, 07 Aug 2026 04:42:06 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7b2898sm42085455e9.4.2026.08.07.04.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:42:06 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, franz.schnyder@toradex.com,
 emanuele.ghidoli@toradex.com, stefan.eichenberger@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/3] board: toradex: smarc-imx95: add SPL quick boot
 autosave support
Date: Fri,  7 Aug 2026 13:41:53 +0200
Message-ID: <20260807114200.271420-3-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807114200.271420-1-eichest@gmail.com>
References: <20260807114200.271420-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 07 Aug 2026 14:18:10 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786102927; x=1786707727;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Me0/IqqtdLbK0RHSMIDCFpqGcmJOpwyzolK+jzIYIgg=;
 b=JEc3Dr1NnuhX0BQSdOmjvGzrruAhheJ/WJdPOZElGnsT5ZxmPPXeAVc1cyT/gPjqI0
 4q4/hWsaqi3LyL4OnTpK2Te72Asd6fLRXNLmqdhU1yRXTMtPYr8C0wGatddErlUcqGE4
 v94kG69gbNM5gqlY6ZpWrrHPxSwtkt6VchLyj0Fdrs7e08p1LOYRo6D5eAUB195mCJcd
 d68x2oPvW/K5NJd9zrGbE/QfjuJwByvCAT8Nw328iOz0YAbo2w55EN4k99ECBaLBlryv
 YhKLRGXJu3PjVZu08NTftNTQJJ3ZEgd1vzyrEkbGbWc3qlCTOex+NaTzkyqdseW5LfXW
 xRaw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=JEc3Dr1N
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

Add support for the QuickBoot save feature in the SPL for Toradex SMARC
iMX95 modules to speed up boot time by skipping DDR training if a
valid QuickBoot save is found. When CONFIG_SPL_IMX_QB is enabled, the
settings will be stored automatically from the SPL. Otherwise, the
command 'qb save mmc 0:1' must be used.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 board/toradex/smarc-imx95/spl.c       | 4 ++++
 configs/toradex-smarc-imx95_defconfig | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/board/toradex/smarc-imx95/spl.c b/board/toradex/smarc-imx95/spl.c
index ce8da89410b..aebb4a2f0b6 100644
--- a/board/toradex/smarc-imx95/spl.c
+++ b/board/toradex/smarc-imx95/spl.c
@@ -6,6 +6,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
+#include <asm/mach-imx/qb.h>
 #include <asm/sections.h>
 #include <asm/global_data.h>
 #include <clk.h>
@@ -81,6 +82,9 @@ void spl_board_init(void)
 	ret = ele_start_rng();
 	if (ret)
 		printf("Fail to start RNG: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
+		spl_imx_qb_save();
 }
 
 void board_init_f(ulong dummy)
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 9abadb0ed1a..b76d1fb3cd7 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
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

