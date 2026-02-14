Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E4FEF99E1
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D2E883E13;
	Sat, 14 Feb 2026 05:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="IqLDtdpL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53F9C83DDD; Sat, 14 Feb 2026 05:57:18 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F32483E8E
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A9C95110207; Sat, 14 Feb 2026 05:57:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771045036; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=eX3f6AHAGZso/W1j1dNJui1AdNA6ts0jz60E3afep2Q=;
 b=IqLDtdpLj4okmCrmFnYvpZPxc/Lti8HzQUJNM399ec40CfleIYRp9SM0TWh+w3um38eqPz
 BkA3S7Scn8HrsceX8lHnAnTiUUcdjYiVyxBbiBFiU+KK13qyDEV+gWsPuooAOKrZjbhK4R
 kkOlf08qZpW1VYmtseoGIyAanPzv5ikqT+NUCXvau/GQYdjx0DZ+QWdx+cyDNV4dWNlAth
 gH4luP9oZVkZJOalXvJWT0kBd3S5LGg5US4+q4Id1xqJvE2gmZs4iVoGpColsXKGzwAnRU
 qP90s3XXRRRceds3zVELTUW+Vqaf/xcVU1mVu/LUGqMuMzswkXlWqqL4MWZFfw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Heiko Schocher <hs@nabladev.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/11] siemens: capricorn: fix fallback bootm call for
 fitImage
Date: Sat, 14 Feb 2026 05:57:01 +0100
Message-Id: <20260214045703.28051-10-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260214045703.28051-1-hs@nabladev.com>
References: <20260214045703.28051-1-hs@nabladev.com>
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

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
Ignore checkpatch warning:
WARNING: line length of 266 exceeds 100 columns

Changes in v2:
Added Reviewed-by from Peng

 board/siemens/capricorn/capricorn_default.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/siemens/capricorn/capricorn_default.env b/board/siemens/capricorn/capricorn_default.env
index ad88f7ed770..cf5bd09a4da 100644
--- a/board/siemens/capricorn/capricorn_default.env
+++ b/board/siemens/capricorn/capricorn_default.env
@@ -20,7 +20,7 @@ ip_method=none
 kernel_name=Image
 loadaddr=0x80400000
 mmc_boot=run set_bootargs;run check_upgrade; run set_partition;run set_bootargs_mmc;run mmc_load_bootfiles
-mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;if test -n ${A};then setenv bootargs ${bootargs} rootfs_sig=${sig_a};fi;if test -n ${B};then setenv bootargs ${bootargs} rootfs_sig=${sig_b};fi;bootm 0x88000000#conf-${dtb_name}.dtb;bootm
+mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;if test -n ${A};then setenv bootargs ${bootargs} rootfs_sig=${sig_a};fi;if test -n ${B};then setenv bootargs ${bootargs} rootfs_sig=${sig_b};fi;bootm 0x88000000#conf-${dtb_name}.dtb;bootm 0x88000000
 mmc_boot_image=ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name}.dtb;if test $? -eq 1;then ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name_default}.dtb;fi; ext4load mmc 0:${mmc_part_nr} ${loadaddr} boot/${kernel_name}; booti ${loadaddr} - ${fdt_addr}
 mmc_load_bootfiles=echo -n Loading from eMMC ...; if test -e mmc 0:${mmc_part_nr} boot/fitImage; then echo fit; setenv fdt_high; setenv initrd_high; run mmc_boot_fit; else echo image; run mmc_boot_image; fi
 net_nfs=wdt dev scu-wdt; wdt stop; echo Booting from network ...; run set_bootargs_net; tftpboot ${loadaddr} ${bootdir}/${kernel_name}; printenv bootargs; if test ${kernel_name} = fitImage; then setenv fdt_high; setenv initrd_high; bootm ${loadaddr}#conf-${dtb_name}.dtb; else tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name}.dtb; if test $? -eq 1; then echo Loading default.dtb!; tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name_default}.dtb; fi; booti ${loadaddr} - ${fdt_addr}; fi
-- 
2.20.1

