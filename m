Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FCAC5CFDB
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 13:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B629240D94;
	Fri, 14 Aug 2026 13:53:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crML5ep8itiS; Fri, 14 Aug 2026 13:53:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B04C640D4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786715626;
	bh=8cPkQZ4ennE+Z1E+7sUFoFSGLLJPtq3rz3wv0YAWEiE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yb7PWl1vi79vsIzlxIdSIyd68IAKbQ6xfL3Bm2j9pjglRD5bf/5zcLVJDJqFARx9t
	 3P5DstlvsLK2x6QT/j9yYMvRknkt20SjtcIPGvKqFcR/ISgIkjbk8cs1RnxCGClyp0
	 OsU0bxIKAs4ZENYjrv5ls+LHd9E7jlxCKrkG4NL+2ugcLVyhxlQNB2dMvzNS1qo0ui
	 BiLgRx0661X+vayi97DGcCjopiYW09cUS0xFhagCfCLwVjRkmmaXdN6qDpqwnSwRGX
	 G/TGhnNudAqGsua2dEnWg9Q6H2lgsx6a588J8ysfzqUbn0oGGCB8R3DUNbRU5YXcGR
	 uqI/SpBVnvhDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B04C640D4E;
	Fri, 14 Aug 2026 13:53:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23F13361
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15CBC606EC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QXf8kEEy_kk for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 13:15:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E22C860602
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E22C860602
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=PUAVUuSx
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E22C860602
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 13:15:46 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso5366535e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786713345; x=1787318145;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8cPkQZ4ennE+Z1E+7sUFoFSGLLJPtq3rz3wv0YAWEiE=;
 b=PUAVUuSxS8hdfQ9iPa6rkoVusGX/ec613+uiHU4H8d1PQK/NX57QcTH8Dzg7pKLiy4
 p/cqiTKdsai1jFkslBFLeus+vYnkg/CC6/dbd7BDi1y+omNBiS2aR0my+bEPJglgBWPo
 fFn8I2gb4lPkOEbC49107Od+5LRuGaMFQPG+4LiAUuFTwnqPxtbxBlBJz4wwG1VxmyMJ
 21k3jpogFwpLxS/mINk4Cl7nfnBMoP5TrX4wHKjl0Bn6GDHWJrxk+ql+8iqfm/LJU5g9
 Op1ED4vF6+CISxhc3xxJf2F4lcRgoVSY8j4/lcXnyky3mNjeLvkrIo67D6r3y7hFWHZ0
 t0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786713345; x=1787318145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8cPkQZ4ennE+Z1E+7sUFoFSGLLJPtq3rz3wv0YAWEiE=;
 b=OhjmhYCq+IrylZ7OCAOWvHIvLFrr33jkPTOhLTphU3KZnta/rrOQX9+huq8qyOHOfZ
 XsdoJz2GE5R87NDhOn8VY1WBxY6iH1WCOiW3LZSpF9bgTxWxZCwr9Vy4heVFv1AEX47H
 UA+Tac78/n24cmx3By1evPeFuRUVaLxR/hBv+zrKNUgpm52pynPJMWz5hYx3iJ3ElI8B
 yQLkwMyTRZ8D6tSXJgSDC1+j39bRKa3SgkaRQXPiH0IhYEi7yfSspW37pO9HC3CsGCQt
 RcLOYfBERncsGnMo83LBfoMOqdhwgDsZcC5dEUxOvbYyEUbcy5L/el3eh80FuPKxu4CJ
 AjpQ==
X-Gm-Message-State: AOJu0Yzrt/0tHA3wHStZepbBiQj9ZVIUMfR6UUKRF+lzYRzEGLkGYXHn
 0J0tOgGDBVHCee8LQQpnyceLZAyujPvllVPU/Z1VP/Z0JSNHze/w+ejO
X-Gm-Gg: AR+sD10MDjnxDYrrn5UWqMjnYf2nmsrRjRdgCn0zLBV3BtVFLnCJYNwpKMYyoaV5OfG
 rXJJZTYl3yoXtxNM/Y6M3j1tuYK3SfuRCpycpmESZEsGUS5KI5NVJQSYUvulX4ZA8CFLLhh/+EH
 UMhol6BgvfRnAC9gLtYxgEvBOfGpSAF+Y5CxOERcvOEVPjOjWA/LiIr3YwtFL9/8Xw4Mggx43pP
 YQd+Vt/Lzr8W7wKQYjhykO2SBAcHrBHqqI1x5WhplID1Sc7hrdp8zO22za6ypTIsdJ2eXZJdQCU
 S58+Gjl8buqqxjB3Qcd8jJ5RNEJ4F7lAn/y4ochfL14TIa9sLVZRjfTVYo/ozd3lLnakIQomcdA
 hGgAwhW2v0nLwGC+Gj4wkWA8PIfSh3VO6wJEk+kAUUFBN1Rc0ebzHgHHjGcbCHJvFlkGoqRyUw1
 WItUC1kwPiBcjtKhnyQ5TRHzIrVgBrvCMKRo70sV04YZ0=
X-Received: by 2002:a05:600c:4e0a:b0:499:737c:ce4c with SMTP id
 5b1f17b1804b1-49987948ae5mr87120955e9.6.1786713344612; 
 Fri, 14 Aug 2026 06:15:44 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f21a31dsm8534718f8f.9.2026.08.14.06.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 06:15:44 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, trini@konsulko.com, sjg@chromium.org, peng.fan@nxp.com
Cc: u-boot@lists.u-boot-project.org,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH] configs: toradex-smarc-imx8mp: enable SPL_SYS_MMCSD_RAW_MODE
Date: Fri, 14 Aug 2026 15:15:17 +0200
Message-ID: <20260814131535.308025-1-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 14 Aug 2026 13:53:45 +0000
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

Enable raw MMC/SD boot mode again so that the SPL can load U-Boot proper
from a RAW U-Boot sector. This was previously removed in commit
25fefa05d732 ("configs: Resync with savedefconfig") but is required for
the Toradex SMARC-iMX8MP board to boot from MMC/SD.

Fixes: 25fefa05d732 ("configs: Resync with savedefconfig")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 configs/toradex-smarc-imx8mp_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index 7301d7a4ace..83647284ae8 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -56,6 +56,8 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x42200000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
-- 
2.55.0

