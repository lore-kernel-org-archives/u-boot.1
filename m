Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB93CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 11:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB66B80B9B;
	Thu, 21 Aug 2025 13:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1CE8129F; Thu, 21 Aug 2025 13:31:42 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC1D80548
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 13:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 57LBVTEc072093
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 19:31:29 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Aug 2025
 19:31:29 +0800
From: Randolph Lin <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <tim609@andestech.com>, Randolph Lin
 <randolph@andestech.com>
Subject: [PATCH] include: configs: andes: Remove fdt_high env variable
Date: Thu, 21 Aug 2025 19:31:22 +0800
Message-ID: <20250821113122.2438565-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 57LBVTEc072093
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

Remove the fdt_high environment variable, as a value of all ones
indicates using the FDT in place. This setting is incorrect for the
current board.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 include/configs/voyager.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/voyager.h b/include/configs/voyager.h
index f6630b07ec9..0e5fed99dd0 100644
--- a/include/configs/voyager.h
+++ b/include/configs/voyager.h
@@ -26,7 +26,6 @@
 #include <config_distro_bootcmd.h>
 
 #define CFG_EXTRA_ENV_SETTINGS	\
-				"fdt_high=0xffffffffffffffff\0" \
 				"initrd_high=0xffffffffffffffff\0" \
 				"kernel_addr_r=0x400600000\0" \
 				"kernel_comp_addr_r=0x404600000\0" \
-- 
2.34.1

