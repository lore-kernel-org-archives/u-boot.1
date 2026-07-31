Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7CAC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A53B241013;
	Fri, 31 Jul 2026 16:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3-zmISSHWxIV; Fri, 31 Jul 2026 16:35:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F65F4100B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515749;
	bh=Dgk51fESqvNBXINuXLnPjwr4hLccFsiSawZ/Vil44sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+FKCiRFKHAiYVfYOua4+Bgy0nwhvQ1sMlPy5tPuVbZm36tR2d59cPXJp7dI+DaYx
	 ZmJVcgt+OiojRLMaE1JFSZvI0yNANvwk2HohLpX4kstuQZ5HwdR5Qq/AzdZ8Dr6mc5
	 XLrMu2elNCFCcfdvvTaBY82Jo4OYoM4FAB7JOMSSVthdu0QOCUyiPuzSlSCgm/R92L
	 AGGgQg4agKWDhZm5nCdWVMrPl4i9lavDL7nq9CSdqRm6mwqMBYONbTwI13Ondxju+F
	 9L1sPrdMr7wJyHVU5+iaXNo6pUExB1l2qCBw/VCxvas4jnex99lowV07IhsD11i3Nz
	 ouaer3SyECM0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9F65F4100B;
	Fri, 31 Jul 2026 16:35:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B631F3B6
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A906860658
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JRjh_lAWS0XP for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:33:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::92b; helo=mail-ua1-x92b.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 987CB60657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 987CB60657
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 987CB60657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:33:57 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-9690c99c917so385556241.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515636; x=1786120436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Dgk51fESqvNBXINuXLnPjwr4hLccFsiSawZ/Vil44sc=;
 b=TTMFkkMrPIq3gEqqHAFpbJ26YjHwM8fKUDodtRfLEp231F3g3cnxRZZZSPdLWhxiMa
 EtEmO2CLbfV2kJ83d5eD7RpiO1wBkrKwYMRgTZe/FvMCA07EosJokUA3RAMIawNgOsPi
 IzCcCgUxaY5FGIIr4fq9SVc8sqXiXkfJdQpLzH/l0C6f9FdUGxRuUTEVmQ4IW4EXlTcB
 aTGyFYxvF6Qu8qI11EaNzHqIxx8iKNPH0hUPNl5hLCUAfce7BqPN2bQ891UpIoEC8tzT
 yR2R6dLlXk3tvtploTsfKJD0zv7iWl8QoLCaGoR5OkB8lCD4lx7qZAGhOTSTwcMVDy/f
 7LMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqM9hntCLUso6fS3FnfCG8A0/w7VqAD5iu0rHFxBVGZ0q5q4U/8Q16un9YmzPX0aJ0jUcCQtVg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzJi5t8MAA9n91tSFutMNb4b1EPURlggMABErQcpOeSoR9blkCL
 dSHc2HDMrtB8YSzarKYpEOAjQieJ1ljCwg95/0N6c7NS6O55axD69Jwwi81kQZ41T7c=
X-Gm-Gg: AR+sD12OCoUtmEFRnEX/kO0ws4Ycuvi3CVxMn4G6/xd13clda+gAbGp5USRe8nI1kLv
 x7volkA6wkCAj2DcTmv0rRSCEOTIi+a9zhIgCWGvypTp7FmuVxfmhwUmU57atk3xFob74HWi/SC
 11P86aamCBwkZh6hAwnCm/OPqyyTVj8PKTfRiKMAj+WQzLC/VcDUBO+ur4YAzNMbNqZ7PU4wzjz
 5aepCj7COPWib91w0EDi7a43yxDjj/mMwR6FPzIFicxkkWMixgI2XtMUA8tzVnQv3PgS2ugMosW
 0NXla52BKBBbLq/XBNwHup0UG93z+ISQWyInAn+7fcHn5Utneu8YSPTrdNcyym5CWquhHUifscv
 iEZxLfcdKj4LBwY8xBnHbRA6d8LKh6jaXtyn49eSzR08qt1Z4XdWBfDF8rnfj5DfiUktfbSXMfF
 BnImfyMT5Ds67/rn2DKDQ1DrFBUf4fIksAgtMDrukImDBeuiszcEY+J/BcOcDz8R2nxATyVDhWB
 VOuFZ/xfwMgIQDWnK1kHFV+fihzq9v0UQSx3yTRp5o1QLcs7JkDwXHZnuNF
X-Received: by 2002:a05:6102:3707:b0:6d4:ba3e:bf97 with SMTP id
 ada2fe7eead31-75b21c5ae20mr766640137.4.1785515636084; 
 Fri, 31 Jul 2026 09:33:56 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:33:55 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:32 -0400
Subject: [PATCH 03/17] spi: cadence_qspi: Use APB write protection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
In-Reply-To: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>, 
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 Stanley Chu <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>, 
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Phil Edworthy <phil.edworthy@renesas.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515625; l=4439;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=C0JrUFW1l6Ib1F6vkBfqxtyYvqIvKQrKy2g4F5a2FKI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHxqKrC7ZZeGcjmYlj9vvIhtR2j9nzAYgZHzavVYy1hWbMSUmtGgwgjWjbe3+utQK2Ql5rV2Sa/
 oICbqY8P3yAg=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515636; x=1786120436;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dgk51fESqvNBXINuXLnPjwr4hLccFsiSawZ/Vil44sc=;
 b=RPN/XFsID8qxjP+M2lqpRjZ34nZczJz7Fs8MCppfxYJ3Sggp3X5Fw/KVnAkLKbjW6w
 oVVL/xA8UtdVbNQSbZ1rHZrDyYhYS4serOxKhyWI79UFntB6pfmxFSYcm2pDEM3lVD7h
 EkZjWQd/Viana02do+On4hHc4R7bVobYOsjpecXoJ9E1PbRKHW+iq4Cv8SRMGlM63Pov
 Cp5pPAGHTsgZXWzBpwOwpBfjp9DVc5zmhu99VJV2IZlRS7d0+HFOkpRp3xaEW8HmWlKc
 zB9o/iKRmYn53GUj47WlSEVRfrrfYLFfhGSdzzC+VN7lslxSf5pcSgV2kRncvTNyyN0c
 4adw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=RPN/XFsI
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

Prevent random memory writes from corrupting flash memory.

When using the Direct Access Controller (DAC), the QSPI flash appears as
a memory-mapped device. A stray write within the DAC region can corrupt
flash contents.

To prevent this, enable the hardware write protection feature. Due to
known errata [1] of the QSPI controller, the entire address range is
protected, and only gets unlocked during intentional QSPI writes.

[1] https://www.renesas.com/en/document/tcu/qspi-contoller-issue

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 drivers/spi/Kconfig            | 11 +++++++++++
 drivers/spi/cadence_qspi.h     |  6 ++++++
 drivers/spi/cadence_qspi_apb.c | 27 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 007ad5e7733..19f8d48507b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -168,6 +168,17 @@ config CADENCE_QSPI
 	  used to access the SPI NOR flash on platforms embedding this
 	  Cadence IP core.
 
+config CADENCE_QSPI_WRITE_PROTECT
+	bool "Cadence QSPI write protection"
+	depends on CADENCE_QSPI
+	help
+	  Enable hardware write protection in the QSPI controller. Helps avoid
+	  flash corruption due to stray writes. The direct access region is kept
+	  locked by default, and only gets unlocked during "sf write".
+
+	  This is similar to SYS_FLASH_PROTECTION however blocking is done by
+	  the controller, rather than by the flash device.
+
 config HAS_CQSPI_REF_CLK
 	bool "Cadence QSPI static reference clock"
 	depends on CADENCE_QSPI
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1e9081c2d17..6b3ed46977a 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -119,6 +119,12 @@
 #define CQSPI_REG_IRQSTATUS                     0x40
 #define CQSPI_REG_IRQMASK                       0x44
 
+#define CQSPI_REG_LOWER_WRITE_PROTECT           0x50
+#define CQSPI_REG_UPPER_WRITE_PROTECT           0x54
+
+#define CQSPI_REG_WRITE_PROTECT_CTRL            0x58
+#define CQSPI_REG_WRPROT_ENABLE                 BIT(1)
+
 #define CQSPI_REG_INDIRECTRD                    0x60
 #define CQSPI_REG_INDIRECTRD_START              BIT(0)
 #define CQSPI_REG_INDIRECTRD_CANCEL             BIT(1)
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 0d4bc685f5d..353b57a46af 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -325,6 +325,17 @@ void cadence_qspi_apb_delay(void *reg_base,
 	cadence_qspi_apb_controller_enable(reg_base);
 }
 
+static void cadence_qspi_apb_write_protect_enable(void *reg_base)
+{
+	writel(CQSPI_REG_WRPROT_ENABLE,
+	       reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
+}
+
+static void cadence_qspi_apb_write_protect_disable(void *reg_base)
+{
+	writel(0, reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
+}
+
 void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 {
 	unsigned reg;
@@ -346,6 +357,18 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Indirect mode configurations */
 	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
 
+	if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT)) {
+		/*
+		 * Enable AHB write protection, to reduce the chance of corrupting
+		 * flash memory due to a stray write within the DAC region.
+		 * Protect the entire address range, regardless of the flash size.
+		 * During "sf write" the protection will be temporarily disabled.
+		 */
+		writel(0, priv->regbase + CQSPI_REG_LOWER_WRITE_PROTECT);
+		writel(~0, priv->regbase + CQSPI_REG_UPPER_WRITE_PROTECT);
+		cadence_qspi_apb_write_protect_enable(priv->regbase);
+	}
+
 	/* Disable all interrupts */
 	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
 
@@ -955,7 +978,11 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
 	 */
 	cadence_qspi_apb_enable_linear_mode(true);
 	if (!priv->dtr && priv->use_dac_mode && (to + len < priv->ahbsize)) {
+		if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT))
+			cadence_qspi_apb_write_protect_disable(priv->regbase);
 		memcpy_toio(priv->ahbbase + to, buf, len);
+		if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT))
+			cadence_qspi_apb_write_protect_enable(priv->regbase);
 		if (!cadence_qspi_wait_idle(priv->regbase))
 			return -EIO;
 		return 0;

-- 
2.55.0

