Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32986606A32C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b9TFrlk3;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=TiFN4QEj
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0416D40A79;
	Sat, 21 Nov 2026 12:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ObyzyvafC7yA; Sat, 21 Nov 2026 12:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org AC5FD40E10
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795264545;
	b=r4j1+QHUbotzYwJA/aot5NbhimmgM6fQirKbUtfuOUGDMrm7gHfcs4uy0nRTCCQuymql
	 0qXMNmaikSCsbHdlZD/Fr3JBVNsdO7NmQgDqdVIM6/OgSg2XchWhbK204g0XF2DOwfj9v
	 fv7aboqIaKbGAJee+akPLA8Ej6SzqbTie4nIAtpHEL58DRE2q7+t0WYRABLPdbjde4VEy
	 A1PGkqv2x6MZEClRM13NFUUGlq62yeJyB22LOm3wf9HN3C2pfks45LYvL/BOsw4hjB4cm
	 6k15mOFCRFUMIXpktj3jLzQHj9XeFRoC0dF2x9rulPjDyxtjjEa9seTW+GeoAQET2yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795264545;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EgS/jJfj18ltCZ73/qNelsAn8weiDiDO6wa/txy0kWk=;
	b=iLBiYJy4muNwSbyaXrrakKEhOu5vMAiBACIrO4LvggTOJZ7CWK9qFYvJ3+kYIbqc/qtS
	 797M5pFFKoKcXVQHaIw8OUlZDZk5u+lgqPE4/PoYnXJezYc3YU6mf+gjoySlZDAT4pCMW
	 eFYKaQox1pc9hjNZta+6qTbwGsPhPjEiTOKKAlq9ICV9uaHzGge6DtiJUF6ccNV36zn5k
	 BUc97ZUG3NpzKunljCmOTY4h/WcZTizTPjRTRSUoMO2Xt9WFMFY4CAQQtIsK9GRvuiSa6
	 bvtZnp4YUmYOvoUaEuk2VkobwVSHqVqkjfb0HrcxanaKq8qm2xNREmXo9hwgv2lhtvw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=TiFN4QEj;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795264545;
	bh=EgS/jJfj18ltCZ73/qNelsAn8weiDiDO6wa/txy0kWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b9TFrlk32vlhAvc9kYSeDRYp84ehbBgOlkQDYe9a7k98sle4UND9aSOK4w9zNXeOg
	 aeBSPdzT5XdJgmCfb/+QZWKSaWnaHY6FfZKEm190M/YCWwMIdW4Z4SRJRrNVeS8odE
	 1MrJYWh5hxzZEHnRREYbpC9Z6gnplrrbG0heO8SwVSx7pdGHaPYgSC/SU4A3wUTW/L
	 qA92O6gQmJrmyA5XME5I2qVGexlanSqt1By9hJbqvSTO3HJ3uQluYrQG4BULL/jF3p
	 1KPQrN+B/n3FtQ4PNxFwhpOrccIPFrg2QtXsnxLu8FniQ6pEExpjo6UeqGneWuM2cY
	 NKb27ZUyjIUnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC5FD40E10;
	Sat, 21 Nov 2026 12:35:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ECDB03A8
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD9E140ADF
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xGxo5lRdV9y1 for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 12:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6929C40E22
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=TiFN4QEj
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6929C40E22
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 12:35:35 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso818414f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 04:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795264534; x=1795869334;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgS/jJfj18ltCZ73/qNelsAn8weiDiDO6wa/txy0kWk=;
 b=TiFN4QEjdqu0d/Vaoo73Hvu7FkSy67xhq+rhyyHLx72Boxhrinnm7nho7vezRL9V//
 L5rfKD4a6kRVEYYsqohwRd4/aqlnrB7LfKpWm6zMob4B/9RYoUHL3biSzYdnaf+YRvbJ
 QKTS7d5sFW704uStkdfKGBVTt+z4joh2mKvYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795264534; x=1795869334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgS/jJfj18ltCZ73/qNelsAn8weiDiDO6wa/txy0kWk=;
 b=cPcVrn4iBpImbJVUVGlAeqFEleyN2MfSHDJ+cst2bEO2bkHb/2JQhR88l+L6TpTf5u
 gZdL1UT5ssYun2YYpeHZ1sAaeUgmfYBOyLXqJpYn7pwaUhMDZXf3XKugxvMXVRVj4dzD
 1Ge+sFy5UiEQrjEmAj59xBPsEwPoyml+cy+Ve3r2jVUwAsd7vBnocHmRrmLWONQabcex
 jvQPl/Tw2+mb4e/YZxR8UtbaDKeY0tDuf+3rm35g3n+q2erGigoM07HRIJRe5kCuOv3h
 db7jpbgfxXIYN8yw/FNaYOacGiJTxjLWJzTeKMF1dItNWI32DY6MoWQcuGjs1OEQCQAb
 65dQ==
X-Gm-Message-State: APuU4Z82bgOtO0M925kKMnVC0LEdlgEsWZnyOBG+cxjufZdDyEgjU4X4
 8TQP0nrefVbomGRcGH36NW5/apw9wLaH+J/IlGsd5upVQU4fME3KFFf94jLgqs764VJZNvNwDBd
 8BNVm
X-Gm-Gg: AZFdTZdtUDZuakvohJj/mIdvQ278C2UfAgqPrtRffEjqxtO9rrSK5z0LoakJzzcd4Ed
 C/Tm08FC9X0IeKOrwGrX6VY5Km3Oix3REBj7CztRMUEzYRoa3tOsGW9UnsBXkVcje67PZIXnNs0
 ofOAqhjuOgWm6SDRMKxFYFpsw4TMnxv3n0q/9pX0OJxPUPmv1foyq8rS3C2xFcsQrCGlvxYudh9
 2gKrSMeJAxD3QhI/hCioVxcfojvWXbOa94FnAZlsh+0PNK6OGjEQjinh/kpFAwciuBBaMl2Gi7d
 X80YqNMUQnZUAaChzkB2WUkXXAApij5OZElOJCy7/TixcsleOAkAydiTBJN/XK/Yv8lqRg9goi5
 6blSmNiRhM6G3ZqnXeHOKbvLbyJAkPfBlmDIGwMkJd0soqpqBkZ/w02O/YHsiOO1DlZ2SjLdohW
 PNzo4ylrFZGyPPVbRi2XtImMff6agZ/mLKfF2IhWwXFOulKrZPtkuuZ7WuEZzfhvj+8S5NJAU1c
 tIcwPQycqxlTLtHgFPNXADiox/W4NFAshWwsfYcJPYFo+womwBDGjSpW5qUBog4ix63vPSf3Z1O
 c4/7oz4J9kifu6MuaxnuzUTmnJG4L3+6BnqBU8flaJnmW0x+FBjUqhmtrT08TsPTZ2fPu6KyjMC
 sQOfct0e50yqSEaPGEVowol6pfG99ApWJ3cITuxYHMxQT3eLwRPWYKUg3axHJOkEYC+HZ9xpEh1
 NW6o5Q1Dv2upsYsWF8fUtKdRJ+sQ==
X-Received: by 2002:a05:6000:2406:b0:4af:e519:ccd1 with SMTP id
 ffacd0b85a97d-4afe519ced4mr1715309f8f.49.1795264534101; 
 Sat, 21 Nov 2026 04:35:34 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm11720564f8f.8.2026.11.21.04.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 04:35:33 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heiko Schocher <hs@nabladev.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 19/25] imx8mn_bsh_smm_s2/pro: Enable display on reference
 design
Date: Sat, 21 Nov 2026 13:34:09 +0100
Message-ID: <20261121123451.2471185-20-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
References: <20261121123451.2471185-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Michael Trimarchi <michael@amarulasolutions.com>

Enable the drivers and add the U-Boot device tree properties required
by the display of the BSH SMM S2 and S2 PRO boards.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Co-developed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

Changes in v2:
- Drop the dsi-host node
- Add commit message

 .../arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi | 16 ++++++++++++++++
 configs/imx8mn_bsh_smm_s2_defconfig              | 15 +++++++++++++++
 configs/imx8mn_bsh_smm_s2pro_defconfig           | 15 +++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi b/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi
index 19b0d8977539..724db21f11f8 100644
--- a/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi
+++ b/arch/arm/dts/imx8mn-bsh-smm-s2-u-boot-common.dtsi
@@ -6,6 +6,12 @@
 
 #include "imx8mn-u-boot.dtsi"
 
+/ {
+	aliases {
+		display0 = &lcdif;
+	};
+};
+
 &{/soc@0/bus@30800000/i2c@30a20000/pmic@4b} {
 	bootph-pre-ram;
 };
@@ -30,6 +36,16 @@
 	bootph-pre-ram;
 };
 
+&lcdif {
+	display = <&display0>;
+
+	/* panel is r8g8b8 */
+	display0: display@0 {
+		bits-per-pixel = <24>;
+		bits-per-color = <8>;
+	};
+};
+
 &pinctrl_i2c1 {
 	bootph-pre-ram;
 };
diff --git a/configs/imx8mn_bsh_smm_s2_defconfig b/configs/imx8mn_bsh_smm_s2_defconfig
index 3c585e8b0541..f63948806ed0 100644
--- a/configs/imx8mn_bsh_smm_s2_defconfig
+++ b/configs/imx8mn_bsh_smm_s2_defconfig
@@ -55,6 +55,7 @@ CONFIG_SYS_PROMPT="> "
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_BMP=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=gpmi-nand"
 CONFIG_MTDPARTS_DEFAULT="gpmi-nand:64m(nandboot),16m(nandfit),32m(nandkernel),1m(nanddtb),8m(nandtee),-(nandrootfs)"
@@ -72,6 +73,8 @@ CONFIG_FASTBOOT_BUF_ADDR=0x40480000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 # CONFIG_MMC is not set
@@ -92,12 +95,17 @@ CONFIG_PHY_NXP_TJA11XX=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8M_BLK_CTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_IMX=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
@@ -110,5 +118,12 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
+CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
+CONFIG_VIDEO_MXS=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
 CONFIG_IMX_WATCHDOG=y
 # CONFIG_FAT_WRITE is not set
diff --git a/configs/imx8mn_bsh_smm_s2pro_defconfig b/configs/imx8mn_bsh_smm_s2pro_defconfig
index b924f6fefaa4..713121eda886 100644
--- a/configs/imx8mn_bsh_smm_s2pro_defconfig
+++ b/configs/imx8mn_bsh_smm_s2pro_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_BMP=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
@@ -66,6 +67,8 @@ CONFIG_FASTBOOT_BUF_SIZE=0x20000000
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_DM_GPIO_LOOKUP_LABEL=y
+CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -81,12 +84,17 @@ CONFIG_PHY_NXP_TJA11XX=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8M_BLK_CTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_IMX=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
@@ -99,5 +107,12 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LCD_SYNAPTICS_R63353=y
+CONFIG_VIDEO_BRIDGE_SAMSUNG_DSIM=y
+CONFIG_VIDEO_MXS=y
+CONFIG_BMP_16BPP=y
+CONFIG_BMP_24BPP=y
+CONFIG_BMP_32BPP=y
 CONFIG_IMX_WATCHDOG=y
 # CONFIG_FAT_WRITE is not set
-- 
2.43.0

