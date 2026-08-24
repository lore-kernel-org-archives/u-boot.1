Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07520C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80DE6605F9;
	Mon, 24 Aug 2026 08:50:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MXH39JzE_hS4; Mon, 24 Aug 2026 08:50:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561457;
	bh=ZFutmG7XSG5sRixMuMTht3qRA9qAOunxam0ba5/gBXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ItC3AjBZp4Eh6ZYlV/NhQbrwag8AXLdcBklLtQBJBb02kqN3GHZZl+hwfMI8UPOmR
	 qu5uxdBFiCeuFCip+GKnCyjbTPUjXNNlLiMIfFTlgvqGIo1rV5PCJwfArNXF3rMeTc
	 q6f5ThE7z/+w5e1CL/O+RpSTiMamLfGLlWY0CQR6JNSgOmrFo9WVwfr1mJCp5s2d12
	 XBDqmAdOa2hfi7xjLyvGGwY4xZSGbOcukWER+YwtcnBkND43wbAxvRh9G1P+6Gifrc
	 xfoAn/+lADYWkiUk4tKvA06tEIoS2qxjR68RZR82EQbYRiwTvox7yWvBLG1WNQHyOP
	 ptX/CDtbQqmQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A91B160617;
	Mon, 24 Aug 2026 08:50:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 004783AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E67156060A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:50:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7tzTUbvGB-KM for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:50:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=M/Pd4ryz
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47E17605F9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:50:55 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e3efab7e0so2309899a91.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561455; x=1788166255;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZFutmG7XSG5sRixMuMTht3qRA9qAOunxam0ba5/gBXM=;
 b=M/Pd4ryz0SgFdZkJAv7B5RpZXq5zJ9LsHuRRf6L8ErWy3vDV8ktFgUpxYbE8EzV6Ar
 QDSGLuihHZ7q6DrQNdcx4VNF/p8+yoqCi43eh1z1oibQeZhpDYvnH23Y7jt7mExq7YDn
 XV9dL9IM7uWPpay6ZOnoSi8H+CwieprnwlwRyCtwNk00GkdPqnWUTUJbTvlAQKeEY+Eb
 XZnOPNkBwqGknpqOHWGREj+/MkwSEkkzV1qA6hG+v4VRDuLAMOGjhzgfkU2gWCHIQFpC
 5EuWS7umbVP7dooTw+uyUiXS5A8VzrJoMtfDYupp8mNI0x/rzXuVgxQaBdPibEV5P7VH
 oWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561455; x=1788166255;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZFutmG7XSG5sRixMuMTht3qRA9qAOunxam0ba5/gBXM=;
 b=FxHUsXu/2W0WPuX1juxoBuny9Q4UBJulbfhpnc72nGLE5kmJeGMM2wrBES3WtDtZ+M
 VnffukbBW2RM5nxc4wMiBDmrosJEmKtYd5S5nwPu3ijeCpPYVUoMcrefuKWQSiG9uzLE
 K4UX4rkM3aLrHqLImI/BTyAUA+7xkhcUi6CcBvSMVpTSDNbXAHPQLLY1fDMqYoKSMr99
 td8VcBTbjC1wRKac3kHFhUoK05sD5RzygknXU4uFg3Gw5HBESNgwm21wRzcS70SGz6Yb
 P46ouqQ0TJNT/51UGCgIvzN7V2jQmC954qy6HgMgW+H5RL7GLlIa7hEoXJhhP5hsZCax
 8M6Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1221Mo2lvTAUtwxB5oF0R1fMF8ywZI2ShyfgY24+Ujojt+0Jo+L7jWJVgpm05wBvZYD74NgQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k8JUzLFfAhb/NFzn2sEnp9+gnMmFbStLpHBzq5zHa/Ki16717f
 Y+8QjA35xptF5dKAzQhPX3EzY096RwK6xZp1OIDDXw3uX+wDlWLX13X5mjeFUmMRjLQ=
X-Gm-Gg: AR+sD12EgXpiKQwf0raLOXioc8uyvdDTZbVjnpCT9M93RVo5sUuOMLTWSYP5Mh5hK/T
 LS89KmRpnESp6dUZhtVjaVf9HRIfjiUkgCg7P+cy3ycanJtVg04Jhg/WvdyHzGMKz8KQ1wP+9gC
 tyTWJdNREi1OGmo3PHeGjru903nXeJ0UZG+OuQ2AjpnIZKzyZwKfym3/GbvlmLHbKQsnzXBvR0Q
 4XPOUmfyQgVUyPVnL9zgMBoEQwk74ucSxEazI3snrfAT7vT4XnzaGvPCaRC4yTRdxT5oBalxlvT
 zfPAta5gsHcgryhDjEKphe+JUiFJMjsustg+okPc89ezXFjNlequSI6HjATZhwoFE6t35EZ93Hc
 5z6FCL9JR85vnbw4VDobLBumc2DlsXi25MuSSf7ss1BiC+K+SoB9v7QLMbymo6L+QusDH1qlTwy
 JjQNMY0/YlzP3pMSLzz+w3Faw0BKjcqw6PEnCAJaQDbEaSBWonqRfJ+lbZ5MBB2Sx70BJsNPdZX
 eVVFbRPzSFNKJu812f2uhnSxio9zCmGaGs3SSor7TpM80FXKtd2FeKWwtZMdRyFXEUA6qXgbbwc
 /diIZQoA5V6naPeFQk+HdIaACsPBBqW60uqy/g==
X-Received: by 2002:a17:90b:2dc2:b0:38e:4f31:8412 with SMTP id
 98e67ed59e1d1-395a062e5a0mr40319598a91.11.1787561455119; 
 Mon, 24 Aug 2026 01:50:55 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:50:54 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:36 +0800
Subject: [PATCH v10 01/17] spacemit: k1: select boot device via config
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-1-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add logic to determine the current boot device by reading the
SoC's configuration registers, rather than using a hardcoded
default.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
---
v9:
- Enhance detection on booting from SD card.
v5:
- Add blank lines around the switch statement.
v2:
- Use FIELD_GET() to parse boot strap mode.
- Remove comments on hacking. Since the sequence between eMMC
  and SD device is exchanged in the upstream DTS. So it isn't
  a hacking any more.
---
 board/spacemit/k1/spl.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index d749e21a2d57..b70eed14e6ed 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -13,6 +13,7 @@
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
+#include <linux/bitfield.h>
 #include <linux/ctype.h>
 #include <linux/delay.h>
 #include <log.h>
@@ -22,6 +23,20 @@
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
 
+/* boot mode configs */
+#define BOOT_DEV_FLAG_REG	0xd4282d10
+#define BOOT_PIN_SEL_REG	0xd4282c20
+
+#define BOOT_STRAP_MODE_OFFSET	9
+#define BOOT_STRAP_MODE_MASK	3
+#define BOOT_STRAP_MODE_EMMC	0
+#define BOOT_STRAP_MODE_SPI	1
+#define BOOT_STRAP_MODE_NAND	2
+#define BOOT_STRAP_MODE_SD	3
+
+#define STORAGE_API_P_ADDR	0xc0838498
+#define SDCARD_API_ENTRY	0xffe0a548
+
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
 #define PULL_UP			(6 << 13)       /* bit[15:13] 110 */
@@ -46,6 +61,17 @@ typedef void (*puts_func_t)(const char *s);
 typedef int (*ddr_init_func_t)(u64 ddr_base, u32 cs_num, u32 data_rate,
 			       puts_func_t puts);
 
+enum board_boot_mode {
+	BOOT_MODE_NONE = 0,
+	BOOT_MODE_USB = 0x55a,
+	BOOT_MODE_EMMC,
+	BOOT_MODE_NAND,
+	BOOT_MODE_SPI,
+	BOOT_MODE_SD,
+	BOOT_MODE_SHELL = 0x55f,
+	BOOT_MODE_BOOTSTRAP,
+};
+
 struct ddr_cfg {
 	u32     data_rate;
 	u32     cs_num;
@@ -58,6 +84,69 @@ binman_sym_declare(ulong, ddr_fw, size);
 
 char product_name[I2C_BUF_SIZE] = "k1";
 
+u32 read_boot_mode(void)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
+	void __iomem *storage_api = (void __iomem *)STORAGE_API_P_ADDR;
+	u32 mode, sel, ret = 0;
+
+	mode = readl(storage_api);
+	if (mode == SDCARD_API_ENTRY)
+		return BOOT_MODE_SD;
+
+	mode = readl(boot_dev);
+	if (mode == BOOT_MODE_NONE || mode > BOOT_MODE_SD) {
+		sel = FIELD_GET(BOOT_STRAP_MODE_MASK << BOOT_STRAP_MODE_OFFSET,
+				readl(boot_strap));
+		switch (sel) {
+		case BOOT_STRAP_MODE_EMMC:
+			mode = BOOT_MODE_EMMC;
+			break;
+		case BOOT_STRAP_MODE_NAND:
+			mode = BOOT_MODE_NAND;
+			break;
+		case BOOT_STRAP_MODE_SPI:
+			mode = BOOT_MODE_SPI;
+			break;
+		case BOOT_STRAP_MODE_SD:
+		default:
+			mode = BOOT_MODE_SD;
+			break;
+		}
+	}
+
+	switch (mode) {
+	case BOOT_MODE_EMMC:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	case BOOT_MODE_NAND:
+		ret = BOOT_DEVICE_NAND;
+		break;
+	case BOOT_MODE_SPI:
+		ret = BOOT_DEVICE_SPI;
+		break;
+	case BOOT_MODE_USB:
+		ret = BOOT_DEVICE_USB;
+		break;
+	case BOOT_MODE_SD:
+		ret = BOOT_DEVICE_MMC2;
+		break;
+	default:
+		ret = BOOT_DEVICE_MMC1;
+		break;
+	}
+
+	return ret;
+}
+
+void write_boot_mode(u32 mode)
+{
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+
+	writel(mode, boot_dev);
+}
+
 static void i2c_early_init(void)
 {
 	struct udevice *bus;
@@ -327,8 +416,12 @@ void nor_early_init(void)
 
 void board_init_f(ulong dummy)
 {
+	u32 mode;
 	int ret;
 
+	mode = read_boot_mode();
+	write_boot_mode(mode);
+
 	ret = spl_early_init();
 	if (ret)
 		panic("spl_early_init() failed:%d\n", ret);
@@ -354,7 +447,7 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_SPI;
+	return read_boot_mode();
 }
 
 void spl_board_init(void)

-- 
2.51.0

