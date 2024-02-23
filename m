Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089AAC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 14:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6444587B07;
	Fri, 23 Feb 2024 15:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=steffen.cc header.i=@steffen.cc header.b="eJBoBJhA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 922B687613; Fri, 23 Feb 2024 15:08:19 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8647F87CDB
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 15:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lists@steffen.cc
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ThBdm47Mxz9srX;
 Fri, 23 Feb 2024 15:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001; 
 t=1708697212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpYHdS2FHk6gxaSWGdu3eDat0xMY2dgdNULA2t1O7LE=;
 b=eJBoBJhA7oJCa2+SnAMHFgrFAxTswkxdMCtzZUL3k1R4Vsj/CWPDWULfH9/MFD7OBDzObM
 Vj13BY3tK5g/FAsPOh5ruvFpj4SRGRA8y8xjlLvDm1F0xBJuRoZO0mae4N28BStR68udcN
 jJCXeocVKQtDDVUiEqgBP9ykgsrzxHMUYBR1i3kpq/8oeywAB1yMMDaWKF8AKVoCNVbiBY
 9z/jCMzPywP8sYAUL4hTjzNeAsoqBUgKH2gfgUggZUOzehvm3el6YXYeW+GYZnJo2u+GwH
 B54s8EIx0kEVFCgHC8VY9tex6RTOdgwYyrrvnitX5I6Ga27X6cn8OOMTlAIJvQ==
From: Steffen Dirkwinkel <lists@steffen.cc>
To: u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 5/5] zynqmp: boot without delay in psu_uboot_init
Date: Fri, 23 Feb 2024 15:06:13 +0100
Message-Id: <20240223140613.1240570-5-lists@steffen.cc>
In-Reply-To: <20240223140613.1240570-1-lists@steffen.cc>
References: <20240223140613.1240570-1-lists@steffen.cc>
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

From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

This seems to have been required for sd init. I don't need it anymore
with correct tapdelay / dll reset handling, but can't be sure this works
on all platforms.

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

---

 board/xilinx/zynqmp/zynqmp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index ba49eb7be22..b36c72c7e54 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -72,9 +72,6 @@ int __maybe_unused psu_uboot_init(void)
 	writel(ZYNQMP_PS_SYSMON_ANALOG_BUS_VAL,
 	       ZYNQMP_AMS_PS_SYSMON_ANALOG_BUS);
 
-	/* Delay is required for clocks to be propagated */
-	udelay(1000000);
-	
 	return 0;
 }
 
-- 
2.39.2

