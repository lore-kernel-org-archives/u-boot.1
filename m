Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648BFC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 08:12:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5468881C1;
	Tue,  6 Aug 2024 10:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722931918;
	bh=f6OCfsQDgOXh4Zqqvq0qHmTp082IKff6mmtoii7cmLw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sk+nUmgA4tVdlFOTPRkGuqhc8zZT+cG1cAQAB/Ac3P4SReY9kvmDgqy82Jm5p3k6F
	 /RVsszoKygt3qOrMOLW7Ed1J/BO+XwtGPH0ctbp2j3dkvfY8HIhnWPBB7SL5mquJH2
	 jTbMka0cWRwx0r89pdaIpi0C0Hy0XMYiZYxK3UGdctEmcdwzoSr3ZbxA8ij9VdsyeR
	 PXiORZe+bCFwf4fglt6/slE9xNYniBCd59938NmudvoRhgU14cyvWWlE7/4zzSg+GA
	 KzW1RLnT1e5yN2MTwYf9pIenmA1LX9yvWIF9AeJKIu75+kxYygY3nGmkDhHulwhm1v
	 hRny3X+30PGgA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id F2E1B8811A;
 Tue,  6 Aug 2024 10:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722931917;
 bh=f6OCfsQDgOXh4Zqqvq0qHmTp082IKff6mmtoii7cmLw=;
 h=From:To:Cc:Subject:Date:From;
 b=zIFVZzWMNwB/6LPUjAT1ThGJ/dbJdSjRVhJSB4d8BKu1qGjKDkY0wTXjJd6E6ecJV
 QR9xuP5HfAYlfJnRamASg4h/muPFVIYYC+0mZ5btGGOqCMbPAnn9+QPD+olgdCeRJw
 51R4fHAG5YpKwqVp5FBdYV57J7JPgCdx7mwZPwHvTyrQrPlU+R0pnCPqJzaMz8t9w6
 EtBBeAC6s9EangHuTl++aILD2f9Ovl5mbIZlQOagaru0M9Tqs2+XnxiIN5Djy50Ev4
 mDzb8yV6oiD4+XadGkgOYa1GLQ4NVlZpSKxERRPXQoFR58XSYu4oKgt6/T3labElTQ
 7mae0NPpEZ0PQ==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Cem Tenruh <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3] config: Add 'update_bootimg' command to update flash.bin
 on Phytec's imx8mm
Date: Tue,  6 Aug 2024 10:11:31 +0200
Message-Id: <20240806081131.4065425-1-lukma@denx.de>
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
---
 include/configs/phycore_imx8mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index ce6dc87c69..361e665676 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -29,6 +29,16 @@
 	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=2\0" \
+	"update_offset=0x42\0" \
+	"update_filename=flash.bin\0" \
+	"hostname=/srv/tftp/\0" \
+	"update_bootimg="						\
+		"mmc dev ${mmcdev} ; "		\
+		"if dhcp ${loadaddr} ${hostname}/${update_filename} ; then "	\
+		"setexpr fw_sz ${filesize} / 0x200 ; "	/* SD block size */ \
+		"setexpr fw_sz ${fw_sz} ; "				\
+		"mmc write ${loadaddr} ${update_offset} ${fw_sz} ; "	\
+		"fi\0" \
 	"mmcautodetect=yes\0" \
 	"mmcargs=setenv bootargs console=${console} " \
 		"root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw\0" \
-- 
2.39.2

