Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CC5E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 06:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459EC80087;
	Fri, 13 Dec 2024 07:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930D98012C; Fri, 13 Dec 2024 07:51:32 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BC480086
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 07:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
 by Atcsqr.andestech.com with ESMTPS id 4BD6pN9d045502
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 14:51:23 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.11) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 13 Dec 2024
 14:51:23 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, Randolph <randolph@andestech.com>
Subject: [PATCH v2] riscv: spl: add FIT name for RISC-V Falcon mode
Date: Fri, 13 Dec 2024 14:51:16 +0800
Message-ID: <20241213065116.512111-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.11]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4BD6pN9d045502
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

The FIT name in RISC-V Falcon mode should be different from that in
normal boot mode; it is called linux.itb. If the setting is missing
in common/spl, the normal boot file name will be used.

Signed-off-by: Randolph <randolph@andestech.com>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 240543c9c7..d7527b6c2d 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -751,6 +751,7 @@ config SPL_FS_LOAD_PAYLOAD_NAME
 	depends on SPL_FS_EXT4 || SPL_FS_FAT || SPL_FS_SQUASHFS || SPL_SEMIHOSTING
 	default "tispl.bin" if SYS_K3_SPL_ATF
 	default "u-boot.itb" if SPL_LOAD_FIT
+	default "linux.itb" if SPL_LOAD_FIT_OPENSBI_OS_BOOT
 	default "u-boot.img"
 	help
 	  Filename to read to load U-Boot when reading from filesystem.
-- 
2.34.1

