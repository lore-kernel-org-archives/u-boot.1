Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8D9F8A16B
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 12:15:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F337841C2;
	Thu, 16 Apr 2026 14:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="nMJIiZd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF92384255; Thu, 16 Apr 2026 14:14:48 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91A0F841D5
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1776341683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqvJ/S44k1m+SHoBClEDaUVga0wRa7u6Bgmiudlh+X0=;
 b=nMJIiZd9VXSSk5lpFx97lHzsKR3ScS7nvrgciVSRsVgIeSJPq+cWpiuDme7afX0VZIDMVK
 vdEpgkjWczZCH8x8ZoFF46kSuSOPk+7X4Mw3ez2DdcSdCRjdO9Gptvo+LxVYtWI5aqUjQE
 BvCscTgR9w21/GrY4/10DRvl6gS+yTE=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 597fe1e0
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Thu, 16 Apr 2026 12:14:42 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH 3/9] board: stmark2: add sd boot command
Date: Thu, 16 Apr 2026 14:14:25 +0200
Message-ID: <20260416121431.20852-3-angelo@kernel-space.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416121431.20852-1-angelo@kernel-space.org>
References: <20260416121431.20852-1-angelo@kernel-space.org>
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

Add command to boot from sd.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 include/configs/stmark2.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/configs/stmark2.h b/include/configs/stmark2.h
index c8a39e191a2..a7afbb3be1f 100644
--- a/include/configs/stmark2.h
+++ b/include/configs/stmark2.h
@@ -14,9 +14,12 @@
 	board/sysam/stmark2/sbf_dram_init.o (.text*)
 
 #define CFG_EXTRA_ENV_SETTINGS				\
+	"boot_sd=load mmc 0:1 ${loadaddr} uImage; "		\
+		"load mmc 0:1 ${loadaddr_ramfs} uRamfs\0"	\
 	"kern_size=0x700000\0"					\
-	"loadaddr=0x40001000\0"					\
+	"loadaddr=0x42000000\0"					\
 		"-(rootfs)\0"					\
+	"loadaddr_ramfs=0x43000000\0"				\
 	"update_uboot=loady ${loadaddr}; "			\
 		"sf probe 0:1 50000000; "			\
 		"sf erase 0 0x80000; "				\
-- 
2.53.0

