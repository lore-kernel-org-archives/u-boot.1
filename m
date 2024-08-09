Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1599C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 16:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E634C88A2F;
	Fri,  9 Aug 2024 18:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723222440;
	bh=AoUHAZNlelI3OaShFU7g54jCVgO6ZqC8gwOqiNAzx1A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i7bSHXvLDmkJi0VRFpXk/u7F/Fu7fWqX9BvYTrBZMcoePNMo8ahjYrvaX8rjY6k/N
	 EA5AcR+JavYGVAINejWnHpEEpnzTvkYPAueEAK1PY8AJOsnlNrE/GeeMLCrpfhK7nb
	 iTCzGPl8lGIKKI1TSl05O7mXofYMTNnwo8+cbXWF9lcurfJ4Nfpl1wa4X+h+P9Tw/H
	 9rg8cxYTTIGvhfua5k50ETyKN6pgJwLBFLTY92011zdtvWKfzdglnhRe7yD4368bDi
	 WZoDyL8JZttwYKPN+TI1xlNLMgI92KGWUHetyCsP4GEAIOkJlnHeVxny+u0rgAJr24
	 Uvrg+KL/Gpuzw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0426B886FD;
 Fri,  9 Aug 2024 18:53:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723222439;
 bh=AoUHAZNlelI3OaShFU7g54jCVgO6ZqC8gwOqiNAzx1A=;
 h=From:To:Cc:Subject:Date:From;
 b=vtpv7yvd1UsNAtgtYwN4m1AizYQRSiO8cpQ80nBoVx2GcGSaNHx4Bm18poZIGHnEQ
 MInxGyYp77etLCR5D4PKdKyf3sVeqYQLV95iEOtro5eie6gH8Um/vbo2lKYRQsXtcw
 T4LQI+Sv8kEMm/6Q3NxnlcAShAUIdBJ/B+oJqN8Jx2Sl6rxw3WCOmkApVyCrhyTNQI
 RPgVlzUk7FGgNctm0C2KXPnvQJy0zvIl6dHW3ZQPhOh3gIh8wE4TRl+8aFHhC3plbb
 S+6kwhKr/rwKdA6T0O3WwuPHm2we+LMuJO6Z4hnP5MF62H+eypWDlJidDXfqiUSbP9
 gmDh37Rdp9Q3Q==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Cem Tenruh <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v4] config: Add 'update_bootimg' command to update flash.bin
 on Phytec's imx8mm
Date: Fri,  9 Aug 2024 18:53:32 +0200
Message-Id: <20240809165332.1898756-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

This command allows easy update on SD card or eMMC of the flash.bin
generated (with binman) during u-boot build.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Remove 'update_mmc_part' variable
- Change path for hostname
- Use full version of dhcp command (${loadaddr} added)

Changes for v3:
- Remove +1 when calculating the size of binary to be written

Changes for v4:
- Replace ${hostname} with ${update_filepath}
---
 include/configs/phycore_imx8mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index dd7cfdba52..0910ae2d87 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -29,6 +29,14 @@
 	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=2\0" \
+	"update_offset=0x42\0" \
+	"update_filename=flash.bin\0" \
+	"update_bootimg="						\
+		"mmc dev ${mmcdev} ; "		\
+		"if dhcp ${loadaddr} ${update_filepath}/${update_filename} ; then "	\
+		"setexpr fw_sz ${filesize} / 0x200 ; "	/* SD block size */ \
+		"mmc write ${loadaddr} ${update_offset} ${fw_sz} ; "	\
+		"fi\0" \
 	"mmcautodetect=yes\0" \
 	"mmcargs=setenv bootargs console=${console} " \
 		"root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw\0" \
-- 
2.39.2

