Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66655EBFD22
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F2E984198;
	Mon, 13 Apr 2026 11:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="JQPHJY5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E546841D5; Mon, 13 Apr 2026 11:23:15 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14FE1840D8
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35e5770d013so884193a91.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776072191; x=1776676991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQjIR61/7oMvyAqnFFZLn/oGRFPehSkZqKTBaWvd4vo=;
 b=JQPHJY5QyOImFcoh+JxgXTPnArNbY2HiFbgeJ/1zJ0c3mpw8yETcqzv3KwlqxcGpKf
 NDUAYjtzgaubmFipXCvJHc2owOuLvhD2Q2BnYuis2VH/63CTIr07wscvbVSXNBL6NnF+
 9wIoMfeQUNQKLS2ymNxijyPtaZQWHPMiSeso0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072191; x=1776676991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HQjIR61/7oMvyAqnFFZLn/oGRFPehSkZqKTBaWvd4vo=;
 b=j+OPQW/Ufe26Ev4fqrOJ+g5fe3pHkKQSkSA9hYG81huEV5zW14eHsY7acuyx/tJDAX
 nsPa/m2y4N6Bdn9PmzVJjJBISFUJJZR6f7TCRRxoS531PK/TEZnLcrUPxSD0LQvCa0ga
 lgrxuU9JqUEoq6uYuVvm5TL1CCUDVpkTujhFlVRRT+eZLJz9g/F/fWv0luS9ea0DWQIT
 5FPTB1O3VEDvro4ow8norbe+qEcnjEqU47V092B4lQ5uoT2ZDgS+poXJ82QW/+idDcmQ
 aaoT3KVOKljA5DOdVj8m45LBsFQY/syNkRRyjmoUBgbDfF46/HyxkZXyn9WDz+Bfg8qe
 mF7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OLQz3fC+GWyHcy5/4B+73i/mfdknIPAM+Rk0wRa8mV7/nPlfw3pkOIpAVctIR1t/toG2+Lzw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz08SLoe2vwL6blNYqoA/xm8ORVOpmsHRZP5tKMHT+tuu4YTdeF
 EXSwGocRXYMt+CjEGwe1FQA277n3eXmTY+7OyXEmPr1HihtlpzfkdF/fI5C1LMw39uo=
X-Gm-Gg: AeBDiethblkS1BjiIVuiX5xnUgFykt8KlbCKXmpQ1dI1T2iIkgY7RGGOAdYbG+A7RE7
 bTWtTwCjGwWWrMAGLrjf57LTJ5eMJwgwOdwzyCCPdJ7FyZ2V+/uCuqP9/15K7kEeD839ziMKB8k
 Cl2YgzgGx+JMlfl99Xq0SK21WVLKumg2zIRE2mOIRQrGi8+JcLlU3Vdd9Ex0bNyJE83GLMIqBDC
 QpI/DmboeixKwXYOM5woUaxMZ31lkGsmngW3cL09XXpZIbggW96HD5/K0EG6nUj4E/WIr0wZUeU
 oPS7ineV4U0f0Myi3ylFtPJ4iON90Gc2eE7aGeeHJY9ggZwXraKgJbBDW6aDV/qQ3xkjw/PIVrH
 lTn0oj+02OhiXp4R8UCYjzm5AOs9hVCLZFyXCfoCVeKgpj2GSOhpCRL3ITahwdWYIkMV056+C9H
 ut/Z++O+u21aV2Bg==
X-Received: by 2002:a17:90b:3d86:b0:35c:30a8:319 with SMTP id
 98e67ed59e1d1-35e423f41c8mr13602585a91.0.1776072191544; 
 Mon, 13 Apr 2026 02:23:11 -0700 (PDT)
Received: from kinako ([2400:2200:776:9b18:a191:7a74:9fd8:591b])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm1055930a91.1.2026.04.13.02.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:23:11 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v4 4/6] virtio: cmd: Depend on VIRTIO_BLK
Date: Mon, 13 Apr 2026 18:22:38 +0900
Message-ID: <20260413092240.3719260-5-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413092240.3719260-1-daniel@thingy.jp>
References: <20260413092240.3719260-1-daniel@thingy.jp>
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

The virtio command is calling virtio blk functions but currently
depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
causes the final link to fail.

Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
on just CONFIG_VIRTIO_BLK

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 7bbeaad04ff4..7c86164ddb20 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1863,8 +1863,8 @@ config CMD_PVBLOCK
 
 config CMD_VIRTIO
 	bool "virtio"
-	depends on VIRTIO
-	default y if VIRTIO
+	depends on VIRTIO_BLK
+	default y if VIRTIO_BLK
 	help
 	  VirtIO block device support
 
-- 
2.51.0

