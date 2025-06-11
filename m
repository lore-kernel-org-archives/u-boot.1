Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9849DC677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 11:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03ED18070C;
	Wed, 11 Jun 2025 13:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="XP7pCdFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD2682B20; Wed, 11 Jun 2025 13:06:12 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3914280050
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:06:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=RsfWOLPruODVYybam1ucMl1su/cuqMudHd7AxKvpe98=;
 b=XP7pCdFpKseHVelzReDb0IKNbFadJaf2rGlwnTG7w+b7qMkIRxfEwNX4K/JIn6Wd7J8f2x9g8HvCdMBTAgVPKOFLVlaDU64Sym1/FbL8eBT5/7V4VqBAIomEW7+ddVeU7+FgFUb+6IdINH7tNL+kWXGMSIdAoNuMKHBwW46eorx+W0R9TQT1/j43QW3YnPHVhhPqhZCHkyd8OMYQUbmpvHxiMG+VUwWDCsLZ4RDCZh6Pv/w2XdOcKay4ZO
 8ZX6MXCJA8HDZ64wEGlTd9fzv7owcbMFd3wrdAgO/bmjnNxA2ScHxx2exoMlgesBRzQrsGWCY/oscJs3oYPWlhmGHfdA==
Received: from TkB (188-24-194-246.rdsnet.ro [188.24.194.246])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Wed, 11 Jun 2025 11:05:55 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH] rk3288: add fdtoverlay_addr_r to default env
Date: Wed, 11 Jun 2025 11:04:54 +0000
Message-ID: <20250611110454.23428-1-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.49.0
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

rk3288 is missing fdtoverlay_addr_r.
The new addresses match those used by rk3308.
Tested on Asus TinkerBoard S.

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
---
 include/configs/rk3288_common.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/configs/rk3288_common.h b/include/configs/rk3288_common.h
index 0c449e31099..52c3695ff8e 100644
--- a/include/configs/rk3288_common.h
+++ b/include/configs/rk3288_common.h
@@ -18,7 +18,8 @@
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"scriptaddr=0x00000000\0" \
 	"pxefile_addr_r=0x00100000\0" \
-	"fdt_addr_r=0x01f00000\0" \
+	"fdt_addr_r=0x01e00000\0" \
+	"fdtoverlay_addr_r=0x01f00000\0" \
 	"kernel_addr_r=0x02000000\0" \
 	"ramdisk_addr_r=0x04000000\0"
 
-- 
2.49.0


