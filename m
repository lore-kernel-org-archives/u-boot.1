Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CCAF364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8693F84227;
	Sat, 11 Apr 2026 09:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bY0OCOxF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6941184105; Fri, 10 Apr 2026 15:58:52 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5157184154
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-506a747448dso17084141cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829529; x=1776434329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=bY0OCOxFV8C4UloQ/urbPyz1tI3YiNcGzGG4GygpKe4YN+2/zEKLHe4sYc2E03bdvQ
 yCET1P14rs1L1HpKXdLrDjm+Qa1ewZlyqhBHttRHlAm8wrufxE08DeiDjjuePHdBrjzn
 nx6hv3GvYHdQnrZveWf43obIUMtrLLBKu/SisbAH288nc3CcHmEOsHOIg+fM0ypNqrHb
 xkoNPnFWh05RVpz9//HYFUor3oZd+VjWACtoa+BYaMT4zZL5HHNo/EflRaBnS0MBopJq
 TOOkeky4J8KstGqGMFmh87bEAGAkaqQvUFAWdYm9fszmc2vXW0K1QWm1rBE01AgUQwVv
 wvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829529; x=1776434329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=jw1WkirWhRmNfZHlh4/S+NC5wXijDjzzarhFtJfWjVqbnto8E3DM6h1O8k4FtPu/9t
 pO2mfFVz6sKcMnOHpWFrtEliIqWsV8WiO77IMUj3kYZh0Z5vVfdPVsKZCju9YnMYlbQ5
 zRuGiyF8nkGsn+3sG08YthfCZZMkwsWGNOtMep+Lu6jEz2mL7PHADo30O0D5szHn+x6o
 Ww/gPDuzWpUrh4S2RL3MmATdGe93hNGppwnK/ZTkpMEkjIKbD4WqLXmZEtQkpvQfaNaf
 UMVh0cXaVqYDN+6HB3AWu9TBV30mZIB90rok+eeJpByVrFeN9aooDkr588EBowe3a7oc
 MT7w==
X-Gm-Message-State: AOJu0YxsHeT4+jD2Rg4wwxHjjfl3SrB38PkXhHBGhNAxihrvTU+wM2eZ
 vJtkk0terac6uTmHlyKSr/HCkebWrx6gPnjt7cmTWddQoCVNqPRvRVdTITgg8W8y
X-Gm-Gg: AeBDiettImv4GoPknKmv2KBeRcG349l3A1lhpgXu4CkbOzWaL11xVlvJXn5Vqt47Lz9
 fO3R8hvDJ0Z4yeS2zwlilSjl14JxPw6hDSCZnd8nWpBh+c1FRDm793AhdheJpa7UP0BxyrepPSc
 6nxVBhdjekzUAyXP3KTTUkpDweCZeyQIu37sMrv9pSOrCl9WXFoCwoIZy3oRvmQfZnMYkwofJv7
 hBGsNZfPqo1rOHQPvMNskAN85s2noomXBWaxH2P6S7fy4JyfDo2+Y3ZGBanvTAGRNR5oXLGCPrb
 a6tyOzzBkuErXGQutM4aONnNf14M1xd2JHPN8NvnPjknjs89GYEWa/vlXMXPXY67iBOpadCqkRL
 rGv/5eYpEaB+V7MW1er9pvKsVH/Zs9wDRh/Iw8giQ4UVFhShZUtJ0vAqyiZyzaIBYb7x7F7is3m
 U6P/gahdW4VP5WhUrNI0xUODqrS/DhtDz7NuDNuhhlou1t
X-Received: by 2002:ac8:5a88:0:b0:50d:adce:551d with SMTP id
 d75a77b69052e-50dd5c23511mr46177571cf.60.1775829528527; 
 Fri, 10 Apr 2026 06:58:48 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:48 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Ozan Durgut <ozndrgt@gmail.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [PATCH v4 13/14] arm: sc5xx: add missing boot env selectors
Date: Fri, 10 Apr 2026 09:58:08 -0400
Message-Id: <8798e17f1a91a79333fe58dd5499dcda0b4656bc.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

From: Ozan Durgut <ozndrgt@gmail.com>

Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
environment includes the expected boot commands for this board.

SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
environment, but it does not define any of the USE_* boot mode selectors.
Without those selectors, the shared env does not generate the board boot
commands such as `spiboot`. This leaves the default `bootcmd=run spiboot`
without a matching environment command and breaks autoboot.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index c7d7932064a..ab1acabef53 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,4 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+#define USE_USB
+
 #include <env/adi/adi_boot.env>
-- 
2.34.1

