Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBB4C3DA7F
	for <u-boot@archiver.kernel.org>; Mon,  5 Aug 2024 08:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9808886FC;
	Mon,  5 Aug 2024 10:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722847347;
	bh=ALv2S9UvlDhQwCehYMvpj8oo0k7S4cXjDH+JGdmKb0g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yASLnRd3m0+qC9xItyr5Iw3sU1GiPY9APaPyqjk2ET7wAUKJsKemCmk1tLaXrPmEU
	 ih1Jhu1voI6V43jzmCo5FRU6fS8nQRC7vtbXci/lXav7ENq4vVEcocFSo/tyj3099K
	 +0yMsKOqwQT0AhvFgUqyrBNxXtKTl+ooF8BjB/WgAD0OWpUUPSNeG3etUhgomyb73H
	 eSiCUSgj2SZPoUFLHx3eJXxHosvJ48fAL2W58ZEtJ4oqdLZLcvp2qQ2dZ+p8oWHnSZ
	 yoskbVWwuTEccAc7ou2AxTgM2wsFIztwKZaMLY5pYiUUyhNXRUjTvrFJiYb1QlZUXJ
	 P+hxnK2ELNePA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B567B8889C;
 Mon,  5 Aug 2024 10:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722847347;
 bh=ALv2S9UvlDhQwCehYMvpj8oo0k7S4cXjDH+JGdmKb0g=;
 h=From:To:Cc:Subject:Date:From;
 b=t8tYUD+ZPUNZPmW9hSYw6ZdcPrFS2VJxfwd0jTH2TlKOxb4Q5DNdx4HY2PjfYsMQk
 VGecb2JYklZhV88Uky4r1XPNJ9g//m5BcVmhTBbbgZYK0tg6YQXXe8qb/6Hwxta+J6
 +47EFpeYFcgiGndPYA2GfvyFebMlVtnZYLBHhLtg8jp4330KQK/be0QEmB3LXbP9KX
 qXFCB9dhOBo+uXzyjckxdaeZeE2I1zT+EiUdQAOsuM2BRbvEwyUy/k7JQ/325BVhBG
 076A78QyuTHsoaSWRz9EjOa+m4cZrdvcrbKKfFLetlBoo7IgGxgxZFf8EL8OTuIZqW
 C3XL9MR5r36vw==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Cem Tenruh <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] config: Add 'update_bootimg' command to update flash.bin
 on Phytec's imx8mm
Date: Mon,  5 Aug 2024 10:42:02 +0200
Message-Id: <20240805084202.3530203-1-lukma@denx.de>
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
+		"setexpr fw_sz ${fw_sz} + 1 ; "				\
+		"mmc write ${loadaddr} ${update_offset} ${fw_sz} ; "	\
+		"fi\0" \
 	"mmcautodetect=yes\0" \
 	"mmcargs=setenv bootargs console=${console} " \
 		"root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw\0" \
-- 
2.39.2

