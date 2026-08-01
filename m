Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA63EC55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 181E580E2D;
	Sat,  1 Aug 2026 16:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kEcLAQ7zs16R; Sat,  1 Aug 2026 16:41:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8752580E1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602464;
	bh=fL41GQSQwZf94m3lC6+nxk8keK7aLUslNIEwn5xQS8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mw3UO+Cy+XClUexymk1Y9JRIbRHnAKNy5JfIS1Zwm7Qwr/nPJQNfXKHAuzbLjRVXg
	 x/yFSF5ni9+R3xWFmvnZ1GwSHy/tgWJtXCOyCtoFkJGbvWuBUNou1ZQKjyWlvb7Udk
	 qsdIo9Ex3g3NtC2wHuUFPGJPP6u6nWfyAf4VSwnkbyDz6TTYnM02hhvMNBCS7ZMl0r
	 UVn/ep/OoRN/ZysURQGaSMERPe9wZi4rmfuiuA59wEMvGDOrEJOu7qjzZea9jAZang
	 G/HAxC53r7e73kGiYnSnpbEnQFkk7zgxOxOItSA9zYiyIafm1w9f29/rU9vj8l052Q
	 uXoQD+0Rp9zFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8752580E1E;
	Sat,  1 Aug 2026 16:41:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8923B26C
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B39640025
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfA_1YaOR15i for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 478BA40015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 478BA40015
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 478BA40015
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:01 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c966b9ee9cbso1115981a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602460; x=1786207260;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fL41GQSQwZf94m3lC6+nxk8keK7aLUslNIEwn5xQS8I=;
 b=PJgRRygoIuuwazRsaSjl2dg5bH+bSRYa8D2b6rQ2Kz4Hy5q9xpKIP/1PRxn/UDo7Pl
 Ed6ySF1xg4TQPTvEADqcoDR2qhhsdJlQvVumtys01INTTBCDMmpvXPCHoc8oyxXFqVCB
 gsiq3NYMA3uzpG5Ly1ocgic/hYQaym7mCSu2WzbAKK3sncFtF5xicsdRTbrUhzQ/aGuN
 8InFFI5fmSH5geWJcBG48av5LpS3cYxCG2arWTjB/vDjEmz4L/pxW29lzB5QPqAsjYr+
 h9ExGHAz45osrf45WtQz8hrejJBrk56WroYSfyxXBF7J+mRSsfVKz7VrxmiFmKZIPvCR
 6JlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrA1XVWU54wUOvzbe1kzliMMmeVroWsRxya/yGzheC1CX6CQhpuQGsD3+TuOTjvRSdFLlwJToI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxsqASMWcE4vaT2uidxhFC1UX0w5+J/Uz1MmK4pDzvLQXSRTOY3
 d4dwzOgKWKYmmc2b7ewHNdY8wyUG4cgbjjxxhiKKPGOuPrV+lUGh/dlB7H+wKWE65h4=
X-Gm-Gg: AR+sD11X1Ahk0ncx3p9UWbwfOmNp9lxHmICG/m84Vz2t3NLjX0zWDsKfCJuXskI1zqf
 iny1z+z0HmBxl4j1Vvu/LZVzGJgELpTWL7srmqcWQ9voOC7Pb+0Gkz5UDHICVBvGpWrb8sezIo/
 4s57XVu6TF6aWpTln5sgiD3KdQXFAsGYQHD57E+peHovGtHhCMGjzaN5xZSIS5Z7dGlA/UmHeKP
 2xcyAcFSd1G88DOtimcq6rDqkMFy1U2cJK1vLYrH6+a0CQf2ucNKvk6gFPwc/H43Vw9gmjQRvVS
 vQ9uDpQiUtm60mx1F5pQ60gkIg023QQ29d5TZQZHdNoZmKCs8SdkyVmKhbp2kgzsbDM9oBQ+MbA
 TBqETMp5EiAS04JUWuI/fUcx07YD03nhjBchIMBtYeL12BjgSEtwEDgx15PrsmFLUIL2TINyzJk
 mH5+VPbLnh9mxfU1vRAQ8fRsOydV9wFzj9DXLkK0y0/p9/YOTl/4SeeWdfij2w7VwJ/66BZfI3u
 RU3gg1hgiAz/8RyBr9I5Ff1/ffhIOh3ytgWetlvWavlp3EFIVsPLYLaALjteFNMeCOgeyhSDaDm
 k1lHbYRc8veNvek/VU4xq57m9w==
X-Received: by 2002:a05:6a21:e58d:b0:3c3:a804:8eed with SMTP id
 adf61e73a8af0-3c92a8b7943mr4109030637.56.1785602460568; 
 Sat, 01 Aug 2026 09:41:00 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:40:59 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:42 +0800
Subject: [PATCH v8 01/11] spacemit: k1: select boot device via config registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-1-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602460; x=1786207260;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fL41GQSQwZf94m3lC6+nxk8keK7aLUslNIEwn5xQS8I=;
 b=0c/KyvXN0PaOL89zW+DSA4R08cZBPOD+3o9eTe+0Twhpcg41WCwVNtwNrXczu1rbcX
 12UMnJP0OEtpSsqe/os52ZDEaMaG5TtHKdeRKE4H42b4sbQ4LszRrPMFwkqTyX9flFgo
 SG8LqaLwYhEIgBHl+KOUs4jaut3Ho0IkQ7SasnBBHHkHA9xYUrR0KrplQRVPIoCQ7CWj
 TitTXXKh3qUJCwKJhP6OJ7xG5N2SIIsRxMFmO5JCm9f+G4tTHUOdsOj34ZoL+963iDUi
 I5uci+Q9+z9A4GgVsfu0KUhJPHg7tbdP7gJq/VmvO9Q/b/9KyuNrGCH+3LaIr5gvVibp
 fM+A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=0c/KyvXN
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add logic to determine the current boot device by reading the
SoC's configuration registers, rather than using a hardcoded
default.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
Reviewed-by: Yao Zi <me@ziyao.cc>
---
v5:
- Add blank lines around the switch statement.
v2:
- Use FIELD_GET() to parse boot strap mode.
- Remove comments on hacking. Since the sequence between eMMC
  and SD device is exchanged in the upstream DTS. So it isn't
  a hacking any more.
---
 board/spacemit/k1/spl.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index d749e21a2d57..613e8c4cf02a 100644
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
@@ -22,6 +23,17 @@
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
 #define MUX_MODE4		4
 #define EDGE_NONE		BIT(6)
 #define PULL_UP			(6 << 13)       /* bit[15:13] 110 */
@@ -46,6 +58,17 @@ typedef void (*puts_func_t)(const char *s);
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
@@ -354,7 +377,53 @@ void board_init_f(ulong dummy)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_SPI;
+	void __iomem *boot_dev = (void __iomem *)BOOT_DEV_FLAG_REG;
+	void __iomem *boot_strap = (void __iomem *)BOOT_PIN_SEL_REG;
+	u32 mode, sel, ret = 0;
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
 }
 
 void spl_board_init(void)

-- 
2.51.0

