Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F7EE909D3
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E6583E63;
	Tue, 17 Feb 2026 17:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Uzime19O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E9583981; Tue, 17 Feb 2026 17:39:25 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4AD83DEB
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4973110ADD; Tue, 17 Feb 2026 17:39:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346362; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=T6LsRZs000qTvDaJ1hS/64GpuRVr/mbmiQOH02z90VA=;
 b=Uzime19OtfYHtfmrghiZuiuc60OgAQpA518xV/rgfQN323MzuESKT0c1WYebhoL4gtDORH
 7G1d4lF/RHkdjLdBvVbUt0V+5I7joESOfZJgfZPx0QgfTEF5CwvWJqxzwRGRtQEJkk8B3D
 7tz9p47TUMDd+wTwIulqwzuhArl9wYFH7gjn0L9kVVSKRe2plDWDEdyuE3cidtDCL1qoNf
 soIQLM7SwcXtrv4OVfXSIgoGbMBHupb+O7UBZtWrz3VThU1sBbo3Vj+KPnJ9aqJq72Kk94
 j/yRtxYatMmHey5HeXAV+ZYZ+fqy0VuqfvWMriVPQKKbBkRD2R559qVBPxxQPQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 09/11] siemens: capricorn: fix fallback bootm call for
 fitImage
Date: Tue, 17 Feb 2026 17:39:09 +0100
Message-Id: <20260217163911.31878-10-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260217163911.31878-1-hs@nabladev.com>
References: <20260217163911.31878-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Walter Schweizer <walter.schweizer@siemens.com>

When dtb_name is missing or a configuration is missing, try to
boot the default configuration in the image. The call to bootm needs
the correct loadaddr to succeed.

Fixes booting when factoryset is missing.

Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

Changes in v3:
Fix checkpatch warning
board/siemens/capricorn/capricorn_default.env:23: warning: line length of 266 exceeds 100 columns
as Max suggested

Changes in v2:
Added Reviewed-by from Peng

 board/siemens/capricorn/capricorn_default.env | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/board/siemens/capricorn/capricorn_default.env b/board/siemens/capricorn/capricorn_default.env
index ad88f7ed770..c150025c882 100644
--- a/board/siemens/capricorn/capricorn_default.env
+++ b/board/siemens/capricorn/capricorn_default.env
@@ -20,7 +20,14 @@ ip_method=none
 kernel_name=Image
 loadaddr=0x80400000
 mmc_boot=run set_bootargs;run check_upgrade; run set_partition;run set_bootargs_mmc;run mmc_load_bootfiles
-mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;if test -n ${A};then setenv bootargs ${bootargs} rootfs_sig=${sig_a};fi;if test -n ${B};then setenv bootargs ${bootargs} rootfs_sig=${sig_b};fi;bootm 0x88000000#conf-${dtb_name}.dtb;bootm
+mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;
+	if test -n ${A};then
+		setenv bootargs ${bootargs} rootfs_sig=${sig_a};
+	fi;
+	if test -n ${B};then
+		setenv bootargs ${bootargs} rootfs_sig=${sig_b};
+	fi;
+	bootm 0x88000000#conf-${dtb_name}.dtb;bootm 0x88000000
 mmc_boot_image=ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name}.dtb;if test $? -eq 1;then ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name_default}.dtb;fi; ext4load mmc 0:${mmc_part_nr} ${loadaddr} boot/${kernel_name}; booti ${loadaddr} - ${fdt_addr}
 mmc_load_bootfiles=echo -n Loading from eMMC ...; if test -e mmc 0:${mmc_part_nr} boot/fitImage; then echo fit; setenv fdt_high; setenv initrd_high; run mmc_boot_fit; else echo image; run mmc_boot_image; fi
 net_nfs=wdt dev scu-wdt; wdt stop; echo Booting from network ...; run set_bootargs_net; tftpboot ${loadaddr} ${bootdir}/${kernel_name}; printenv bootargs; if test ${kernel_name} = fitImage; then setenv fdt_high; setenv initrd_high; bootm ${loadaddr}#conf-${dtb_name}.dtb; else tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name}.dtb; if test $? -eq 1; then echo Loading default.dtb!; tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name_default}.dtb; fi; booti ${loadaddr} - ${fdt_addr}; fi
-- 
2.20.1

