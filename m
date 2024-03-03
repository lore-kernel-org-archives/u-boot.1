Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2619AC5475B
	for <u-boot@archiver.kernel.org>; Sun,  3 Mar 2024 13:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6C187F04;
	Sun,  3 Mar 2024 14:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Kn7mNj63";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A6D787F0C; Sun,  3 Mar 2024 14:01:29 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 859E587EFE
 for <u-boot@lists.denx.de>; Sun,  3 Mar 2024 14:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-095-222-037-056.um34.pools.vodafone-ip.de
 [95.222.37.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A6D213FB53; 
 Sun,  3 Mar 2024 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709470887;
 bh=i2e14ejVUM/58+BbsEQMZbxMuYdj1gLVTFfDByyr7mY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Kn7mNj63VQl9nJAohCTYDyMXCZZ96+B78xwPS62gTkDii5LLeX7ymX+K//gXnyHqD
 8Bcn1xyM5rZgAGj96GRZjVI1vMehsYm+FzOt0rW7tvf/kfzSDaFvaynzOOeT5eelqH
 nFlgN6JiDceMCFlJ4vF67qvG1kCYNgcI2aTVCqajhpY0IFZwHG38IWAeaNjBOVbaFr
 fJp96rsOuypiApa3wy2q78My269wDL0Qe2AZnYOD5Rnst8cR87Nd5FQLrRZdJsTE4F
 NBcM9J9/Y0kj6ocpJyCP+RqyQsmtlay1kz9CbBrD6WeWST6VHyH5P9ljEKI83BRtbU
 SKTuuNmA8UzHA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 1/5] eeprom: starfive: function get_product_id_from_eeprom()
Date: Sun,  3 Mar 2024 14:01:18 +0100
Message-ID: <20240303130122.29983-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
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

Export a function get_product_id_from_eeprom() to read the product ID.
This value can be used for fixing up the device-tree on JH7110 based
products.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/include/asm/arch-jh7110/eeprom.h         | 9 +++++++++
 board/starfive/visionfive2/visionfive2-i2c-eeprom.c | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h b/arch/riscv/include/asm/arch-jh7110/eeprom.h
index d2776d5b6cb..62d184aeb57 100644
--- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
+++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
@@ -12,4 +12,13 @@
 u8 get_pcb_revision_from_eeprom(void);
 u32 get_ddr_size_from_eeprom(void);
 
+/**
+ * get_product_id_from_eeprom - get product ID string
+ *
+ * A string like "VF7110A1-2228-D008E000-00000001" is returned.
+ *
+ * Return:	product ID string
+ */
+const char *get_product_id_from_eeprom(void);
+
 #endif /* _ASM_RISCV_EEPROM_H */
diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index c36de1a5125..a9f4376c8e1 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -405,6 +405,14 @@ static void set_product_id(char *string)
 	update_crc();
 }
 
+const char *get_product_id_from_eeprom(void)
+{
+	if (read_eeprom())
+		return NULL;
+
+	return pbuf.eeprom.atom1.data.pstr;
+}
+
 int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char *cmd;
-- 
2.43.0

