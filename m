Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896EBE784BF
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822208718A;
	Mon,  2 Oct 2023 17:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696261978;
	bh=e1gPxWYij3h8mGbOu964Lm1W3e5zEjfbXbRVIKNALdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N6yAYYOUMMAvr7DRXuwao+lRMKo9AtvsepJSH7pNbTOBAivOdCOuEJ5JuGvLL7kKK
	 dA3664Q41YWRd4BTs1luGT3ivelsiYbr3HZDxpwHs8fPAeWXKINHFf4Me83XINgfDk
	 6E5gt2EliXbJipBjgGjDVNq5sgy+zX3j8VK29W1+d385zBjeJwSFFGX5NXG7eadZKr
	 WS4xRsqGhPjs7VbbyGL+lopM6f5dJ/yv1v9aVEwQ9QAReMYqEfm0pNDrcquN5b9gUz
	 Hrw2tVl558oNz1/BxtjyhE3kBHHgFCIo/VyAC/kPEHAGG/27SN6hReiFtuvcXLwykp
	 B++gdxuPSGSCQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EE83986C59;
 Mon,  2 Oct 2023 17:52:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696261977;
 bh=e1gPxWYij3h8mGbOu964Lm1W3e5zEjfbXbRVIKNALdg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cF08puVorpyD14x1KwnBH0h+/JcokM1HGM7u2wW9nz4G7Yt531MMQQgIisVZsFNZb
 VH+vhWM5OlhWxLbrl8y2Dtx0u0DYisc/5Yctv2gm+olAXQ5KLxMrc5WWhUHyrhKZ5u
 U6PSA7xvR6Zr8xNJLtI/9NfqnqRciR6F07rDiJgcBROk4niPHY1Vf32Up/AfWwicGk
 0nFsbAzHh7QhJmVglKv4kBThkUeVkxI+0QAkzRvWml9BVI23OQio4nV+OHj6YLfoE4
 vVXNGVGJmWCqW3BVcZM6GM2u7bOVXExYfh3EmleiLO9oyRGkGdEktptASlG4bMFTyw
 jvTfK99aXzYHA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] ARM: stm32: Add dh_update_sd_to_emmc to STM32MP15xx DHCOR
Date: Mon,  2 Oct 2023 17:52:34 +0200
Message-Id: <20231002155234.138630-2-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231002155234.138630-1-marex@denx.de>
References: <20231002155234.138630-1-marex@denx.de>
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

Add script which installs U-Boot binaries from SD card to eMMC
and makes the eMMC bootable.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 include/configs/stm32mp15_dh_dhsom.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index c7ebf5cd180..8ff882264f4 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -20,6 +20,25 @@
 
 #define STM32MP_BOARD_EXTRA_ENV \
 	"usb_pgood_delay=1000\0" \
+	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\
+		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
+		"load mmc 0:4 ${loadaddr1} boot/u-boot-spl.stm32 && "	\
+		"setexpr sblkcnt ${filesize} + 0x1ff && "		\
+		"setexpr sblkcnt ${sblkcnt} / 0x200 && "		\
+		"load mmc 0:4 ${loadaddr} boot/u-boot.itb && "		\
+		"setexpr ublkcnt ${filesize} + 0x1ff && "		\
+		"setexpr ublkcnt ${ublkcnt} / 0x200 && "		\
+		"mmc partconf 1 1 1 1 && mmc dev 1 1 && "		\
+		"mmc write ${loadaddr1} 0 ${sblkcnt} && "		\
+		"mmc dev 1 2 && "					\
+		"mmc write ${loadaddr1} 0 ${sblkcnt} && "		\
+		"mmc dev 1 && "						\
+		"gpt write mmc 1 'name=ssbl,size=2MiB' && "		\
+		"mmc write ${loadaddr} 0x22 ${ublkcnt} && "		\
+		"mmc partconf 1 1 1 0 && "				\
+		"setenv loadaddr1 && "					\
+		"setenv sblkcnt && "					\
+		"setenv ublkcnt\0"					\
 	"dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD */ \
 		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
 		"load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "	\
-- 
2.40.1

