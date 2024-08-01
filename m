Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB281C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 12:54:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A76988AD9;
	Thu,  1 Aug 2024 14:54:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722516872;
	bh=c+PH0tWuLoQ5BvDJGmUaW5CnUCirARvhqWgoPgBvGWs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sMWSpd1x23X+sp1EqtbDHHLX1BV8Uqcj87/6k9mTvp89Sc5Wkg358/P94ntKs1Trv
	 ddxwe47ThubBY3tCV6X8QhmrAlp9Rr/Y6p6zsy7VkUKBR6IRlgZy33WcLo1BgZUvvX
	 +MZwcSfeC8FYGT13SCKow8A9yhqplWx0mBDt7osa6m/zI5Kt7Ib7yNU70QlmF/D4+S
	 xBzxITZ4S7g1bl/fzmRh8R0lesmhazAVX5Ymo5+dnJkTS4p7R7oUjFPMXI56qlI6Xh
	 70CsDrILQHE2myJ2el/TsUaYBVrM51we/ui1Vo5TdNMDn0ML0upHhlQI0UEYOm2vIb
	 4JaMWBIQg2ODA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E9E6A881BA;
 Thu,  1 Aug 2024 14:54:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722516871;
 bh=c+PH0tWuLoQ5BvDJGmUaW5CnUCirARvhqWgoPgBvGWs=;
 h=From:To:Cc:Subject:Date:From;
 b=sK/yAqTs6yJtvUquEcvRpbp2IeRKgOVxo71LeHoU8lAtyH1+btrF731ynIvxnHkwI
 XlP3WVPF4FWWMGQmy94DUIhbDoSkI1291LByLgB59eIV7R7zJnC7P+Tatn4JpxzJIx
 gocLGmORM3BZh5l7tWQw9i8klZxAfCLfJP2qshz1vIR0ntF3H2J3ZikMrZoyrvfnQE
 b7QjdXJkxQ/DpdegIDJIEdLS0c5FjPUpz0Zl/XPGpg7JDmIvlpWaMnVfDD/YWLQnLh
 FdV8polZ32kYKG8bckPhgAP66MQYbPi1ZMUS2LckqyP+yGc00x3Qj7ZkiBmIrH8aXn
 ODqmlq4d8+csA==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Cem Tenruh <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 1/2] config: Add 'update_bootimg' command to update flash.bin
 on Phytec's imx8mm
Date: Thu,  1 Aug 2024 14:54:15 +0200
Message-Id: <20240801125416.1582652-1-lukma@denx.de>
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

This command allows easy update on SD card (hence the update_mmc_part=1)
of the flash.bin generated during u-boot build.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 include/configs/phycore_imx8mm.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index ce6dc87c69..fdeb11933f 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -29,6 +29,17 @@
 	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
 	"mmcpart=1\0" \
 	"mmcroot=2\0" \
+	"update_mmc_part=1\0" \
+	"update_offset=0x42\0" \
+	"update_filename=flash.bin\0" \
+	"hostname=/tftpboot/lukma/\0" \
+	"update_bootimg="						\
+		"mmc dev ${mmcdev} ; "		\
+		"if dhcp ${hostname}/${update_filename} ; then "	\
+		"setexpr fw_sz ${filesize} / 0x200 ; "	/* SD block size */ \
+		"setexpr fw_sz ${fw_sz} + 1 ; "				\
+		"mmc write ${loadaddr} ${update_offset} ${fw_sz} ; "	\
+		"fi\0" \
 	"mmcautodetect=yes\0" \
 	"mmcargs=setenv bootargs console=${console} " \
 		"root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw\0" \
-- 
2.39.2

