Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5673CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:40:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DBDC836D1;
	Mon,  3 Nov 2025 19:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QyHAjvS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EAA58393D; Mon,  3 Nov 2025 19:40:22 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B98838D7
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so2908075f8f.3
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762195219; x=1762800019;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L/xCZxTUcDADe5N5uPI/inMy/98OX0HrL1W0R1cEZZw=;
 b=QyHAjvS7IMerj2li04kRpNQuRuP84INmC1uQpzMms7tNzeuzUbpPDEsSWqiGsf3Vsu
 aaeLF8Rcb2IUJ8dBbUPq+vHu4I1VPrcCXrcBNwWMgccY0gAZCf2mJpSir/VHfHxGCeVW
 lRmz29zv+UMkw/5GP7iR7KhaTzO3erzaun5onytMZP4rYvJ0VHBaIE8APspxnexBfaVb
 IsV6fkS3F6FTsiaHevtKcv1bf8+yzp+ctK1MkrlinDzfHcvfb41g1OhrTX8xu5kRoeIY
 CceyJL6p4i4YLLFzC1E0Li1n8lNjMsa2AGF42WfRuBsd7puwsWLejK/774tM9AO5DWun
 DSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195219; x=1762800019;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L/xCZxTUcDADe5N5uPI/inMy/98OX0HrL1W0R1cEZZw=;
 b=P8KrHeA8ruVCowFJBGs0hN4MZVj1W+XEn7+qlfWM3cSUlJ1GnrBDYuSdZ0cDn2hYWv
 B/G9oP+TWgmmfh4gmHSvlJ6VaETn+lewYPPEJz7Z9jiDkh/c5p89QlPEp2WqMxYdoRsa
 SzaRDDuHpjk3K6o4Ldr7F3oOm5j+0HJlTmgDzXt0bWOkGfizjA/8EjdYrYqm7mtkCvKP
 LKsPO947qFkVyEfufGbty5zaEFP43pni+aD54DSihR/66w9cFv0tWU3APoJVpPwLjX70
 ZyuVMSiCX3MIz5opdfluPlUBx5KoSvpFuB3w+oBMKjhfkuatE5WR+LoVxixFCq9fILvt
 2VmQ==
X-Gm-Message-State: AOJu0YweWUCsO/Dip/I0YPNU1FiyrWvfkWF84plF/zcDqRcDNaE2lBIX
 ZlJrNJ4z5EBN82Be1C1fg+fjZzdT20TbHs2HKRX4jZPEsWZ2aWTEGgsB+S2i8UGXORY=
X-Gm-Gg: ASbGncvHhd2lipa5orIwheTpeL2R9+ZuN1i4rXdI3yqsRA7Qzz0Y2CQ42D3sfwV84cc
 UBS4PnN8j8Fs6rXvhmZcd49O7JdFzu73NrQel5ggWWWDz4IqWcF7tFdnAkEfze7CBAiZ02s4ega
 GJw4qJBuMuLV2A9va2LD7Djtz9z0Rypn9xDPy3htCPClABDHjf4sJwcoY3FPkJafJ9Dmo2xcd8B
 0yB2VRniugsGaUegCj9Zi038jlDlVah/nlNiEzTtyaQViDSjDt5XvZCNUP7v/a6DeC3goIVVY9F
 lfB6FakLj301OldWEf05CTRFsil1poJMw4HnyUGKJp/z62NAmBN2FkhgnMDYJY4eUqZJrBepRP3
 cDN+S26YLkB+xy7ujxa6DUvUH8JKhMb3qOXCB6wrOCyiXlrLhjB5LKQPYzRjKoNUsKvpADTuCLQ
 6YxQ==
X-Google-Smtp-Source: AGHT+IHFL6W0UlEi103BPryeFpKc87sPpLItDYM5AtLxBSdHkLtNdl83uS+Ghx/obU0GZCmWivi3Dw==
X-Received: by 2002:a5d:5f84:0:b0:429:d280:a242 with SMTP id
 ffacd0b85a97d-429d280a389mr4471514f8f.16.1762195219411; 
 Mon, 03 Nov 2025 10:40:19 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:23eb:8c68:e19:f7bc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f98d9sm160295f8f.32.2025.11.03.10.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:40:19 -0800 (PST)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Date: Mon, 03 Nov 2025 19:40:03 +0100
Subject: [PATCH v3 2/4] board: am62x: Add support for reading eeprom data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-am62xeeprom-v3-2-e390779c0fc5@baylibre.com>
References: <20251103-am62xeeprom-v3-0-e390779c0fc5@baylibre.com>
In-Reply-To: <20251103-am62xeeprom-v3-0-e390779c0fc5@baylibre.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>, 
 Judith Mendez <jm@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dhruva Gole <d-gole@ti.com>, Andrew Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Aashvij Shenai <a-shenai@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.3
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

I2C EEPROM data contains the board name and its revision.
Add support for:
- Reading EEPROM data and store a copy at end of SRAM
- Updating env variable with relevant board info
- Printing board info during boot

Use the generic do_board_detect_am6() and setup_serial_am6()
functions to avoid code duplication across AM6x family boards.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
 arch/arm/mach-k3/am62x/Kconfig |  3 +++
 board/ti/am62x/evm.c           | 51 +++++++++++++++++++++++++++++++++++++++++-
 configs/am62x_evm_r5_defconfig |  1 +
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/am62x/Kconfig b/arch/arm/mach-k3/am62x/Kconfig
index 81199ada3a1..f7ad52db7d8 100644
--- a/arch/arm/mach-k3/am62x/Kconfig
+++ b/arch/arm/mach-k3/am62x/Kconfig
@@ -14,6 +14,8 @@ config TARGET_AM625_A53_EVM
 	select ARM64
 	select BINMAN
 	select OF_SYSTEM_SETUP
+	imply TI_COMMON_CMD_OPTIONS
+	imply TI_I2C_BOARD_DETECT
 
 config TARGET_AM625_R5_EVM
 	bool "TI K3 based AM625 EVM running on R5"
@@ -25,6 +27,7 @@ config TARGET_AM625_R5_EVM
 	select K3_DDRSS
 	select BINMAN
 	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
 
 config TARGET_PHYCORE_AM62X_A53
 	bool "PHYTEC phyCORE-AM62x running on A53"
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index c2c7a0216b9..6bb243ee597 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -22,8 +22,15 @@
 #include <dm/uclass.h>
 #include <asm/arch/k3-ddr.h>
 
+#include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
 
+#define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
+				 board_ti_k3_is("AM62B-SKEVM"))
+#define board_is_am62b_p1_skevm() board_ti_k3_is("AM62B-SKEVM-P1")
+#define board_is_am62x_lp_skevm()  board_ti_k3_is("AM62-LP-SKEVM")
+#define board_is_am62x_sip_skevm()  board_ti_k3_is("AM62SIP-SKEVM")
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
@@ -74,9 +81,51 @@ struct efi_capsule_update_info update_info = {
 	.images = fw_images,
 };
 
-#ifdef CONFIG_BOARD_LATE_INIT
+#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
+int checkboard(void)
+{
+	struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
+
+	if (!do_board_detect_am6())
+		printf("Board: %s rev %s\n", ep->name, ep->version);
+
+	return 0;
+}
+
+#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
+static void setup_board_eeprom_env(void)
+{
+	char *name = "am62x_skevm";
+
+	if (do_board_detect_am6())
+		goto invalid_eeprom;
+
+	if (board_is_am62x_skevm())
+		name = "am62x_skevm";
+	else if (board_is_am62b_p1_skevm())
+		name = "am62b_p1_skevm";
+	else if (board_is_am62x_lp_skevm())
+		name = "am62x_lp_skevm";
+	else if (board_is_am62x_sip_skevm())
+		name = "am62x_sip_skevm";
+	else
+		printf("Unidentified board claims %s in eeprom header\n",
+		       board_ti_get_name());
+
+invalid_eeprom:
+	set_board_info_env_am6(name);
+}
+#endif
+#endif
+
+#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
 int board_late_init(void)
 {
+	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
+		setup_board_eeprom_env();
+		setup_serial_am6();
+	}
+
 	ti_set_fdt_env(NULL, NULL);
 	return 0;
 }
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index 18ffc991b25..d42bdf1f074 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -85,6 +85,7 @@ CONFIG_SPL_CLK_K3_PLL=y
 CONFIG_SPL_CLK_K3=y
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_SPL_MISC=y

-- 
2.34.1

