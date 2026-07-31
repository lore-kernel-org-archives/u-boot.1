Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F750C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 16:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D605B80F21;
	Fri, 31 Jul 2026 16:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aWCOWwY8Xk_q; Fri, 31 Jul 2026 16:36:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0276B810A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785515773;
	bh=4EPYbDLqJXsYF2N+kS0swtUUsYinD9cVML0nrygLkWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a86sF5v2fuv6lfSftG4PX6BfDXECGjD6PvwWJ+5gRgFdVgwT2NU/HHIRNrq6mX0gC
	 ZzIxaHKazp8FYi0ccOwBHBNJ38Cc9WQHMn+0MXcF4q7gKRbRN8quA6ZYIGpAcq9FkC
	 VAiM0eBZbk+hpx7gLvB9mselVzlgY1uZhfIAlh54tTHLGV09829ysjbfEmuWxnwste
	 leK5Y+J5NxqTOMG/6yXtWW8p7nfXIebnY4XNeNXMxwinzXBAy/52El6upLTDmZSLMm
	 jzuNix+7WLJQWtnTnr0udaGy6pfFMw5a5ZVCxx1QRoyw11Gct6HWUWzyiQaetf53L3
	 YwRZI3UZxSm/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0276B810A1;
	Fri, 31 Jul 2026 16:36:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8614336E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 783A360658
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPWY-9JTVAlq for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 16:34:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2d; helo=mail-vk1-xa2d.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C041A60657
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C041A60657
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C041A60657
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 16:34:32 +0000 (UTC)
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5bf83925ddaso479887e0c.1
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 09:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785515671; x=1786120471;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4EPYbDLqJXsYF2N+kS0swtUUsYinD9cVML0nrygLkWs=;
 b=AywTGQja0TjlkpN+DkWbv1hMuE8TVrDpXIMckwz4fWjFRbvnoyu1RuRBrUT0id3axN
 R6DrpAAJcRvXvAp4BcknLYCR2IwYrIOL15AZl7/Zn95DREDhMYVlbSAQM5EqptK329Ns
 24Vokz49XUM+q9jbjfGuk9wlWNtAQIH9MSFU5lUe38FGEBC89bBW/VYXeNypqPtQkSDe
 CSbj0IsjOJGWlW6JmgdyZi9smZkiXaLrXNARERv+7B3C/qIL5DovVtF21Px1yndWi3na
 ZdOj4OVj+fYbKvGyG/p4FUyZXa8ur6oos87jU6/sYtTGLV4+rHA+ORz/t8Z/2zFRHKCd
 QPlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmzLWxOQr5VPUS/tkUsxDYOSA/IIFGiNuaal8dkLYAYaGmBc7fMjEyVhrKTJ+nJ4jvInv4yaQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyiMZ8GcBxexBo+VID8COT3nES7qjbvUkK0792HhznunwF3rvwx
 8waaDFydYx1wVAQpxT/astfPFBCG6ZZ82QCyWQo38YVezDci5dKIr9RerLj+ggASXhs=
X-Gm-Gg: AR+sD13c3XiNPQ2n9s3/AaHGIYYq1LYXuJAcX75XZPPBUfDLLd+l7RL8JD5r+9qhJnc
 3zXVBzIc+gQj+qbCE791Zmtk9VKWhrlOyXr3ghAL32rjlTnLPfmiODqtSoEohjmX7mMpkemfF8F
 LRwH9BZ+0b7Zr1ft5EIFH1xrIZWTMysekHS5z4JYuKTI2bZxHRmVYXAFdJupm2sSK7fqF48kMg1
 TD1iAYATVvzXrwC15Varf9DFVoeFXiYIli+GIfutF5mIB9TZaGe1R8gxsxBq/kuKzXmqXc+o9gK
 iLO+rTBt0RB5IFpSm1Mq7IXjSnP7q5AWQqreokpdsy2m/WisBO/hq9hNDHnCGydDlee3TyUHe1Q
 FMKPRxu95bKxU+1sx5kM3t/uSScmw/gs+uJLZxONskM1NDVuG1LylAsgk8mqcqNWBAViNg8RZkx
 i/jjLbc6Ei16ZAqO8JMd558VFSU5UB/AaTcXzvZtRXJ1klmbrjlAhHbYJevQh4sJlpp2+/vFAce
 2hueq04tPnH1OqWUqpoV7h0ISiqwN0W81eTRf/NRyGHg2WU31K9lHH7jSs8
X-Received: by 2002:a05:6122:d12:b0:5bf:b879:15c0 with SMTP id
 71dfb90a1353d-5c387692fb6mr290521e0c.5.1785515671303; 
 Fri, 31 Jul 2026 09:34:31 -0700 (PDT)
Received: from maple.netwinder.org ([198.58.133.142])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-977e5eb9f77sm1084778241.0.2026.07.31.09.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:34:30 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 31 Jul 2026 12:33:46 -0400
Subject: [PATCH 17/17] configs: rzn1_snarc_defconfig: enable new drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-rzn1-2026-07-v1-17-af2ce80db9d8@linaro.org>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1785515626; l=3527;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=PaVT7fpWUBpoT5H3NosUuURJ29bEsYxhVMxlFi1DObw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMf6RFpyyOfMoDCR/HDb6WvI3AqGI3c/Zrs48NAADtHwF5pJ1x8vCFpxeQfxAaV2a5z761E2a7J
 fu2yMt2hF4wA=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-Mailman-Approved-At: Fri, 31 Jul 2026 16:35:45 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785515671; x=1786120471;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4EPYbDLqJXsYF2N+kS0swtUUsYinD9cVML0nrygLkWs=;
 b=AfMvBUyIeJwQgCL3b96Dg5BKGIbIPLuq/jjwxvbWZtJL0yECTLsjLr8u/vjT+5RJ+N
 59KDd1oCF85MsnX+/9TYqE+ZpCWXxvdAkS6V9mlyluq/idmo+r23nae+E8TD0Z3sMH2V
 qknOFDL/kTAsGXCK2LXY01o+3Mvs3UkKkGRN7JPVbsxpLa0Er3DbcKPHomQziKYN9QrE
 0Ko1pUh1jNkz/ZB7nsQf0qWQ6ulBbRHJ9vjYrZ/CNugWmmePrSNfko+R9OAJqDtt1ean
 Q+r9uDuu26VxR5V0+RCZKiA6eNBvMuU33q/o7AXJ+LQEGc9wfVap3/t/aOhlCVvMhZN/
 PjWA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=AfMvBUyI
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

Enable drivers which are now functional on RZ/N1:
- Default environment from file rzn1.env
- MMC controller (ARASAN), and FAT and EXT4 filesystem support
- QSPI controller (Cadence), MTD and several flash vendors
- QSPI write protection feature
- GPIO driver (Designware)
- Ethernet (Designware + A5PSW + MIIC) and PHY
- Ethernet needs CONFIG_DW_ALTDESCRIPTORS
- NAND flash (Cadence/Evatronix)
- USB controller, gadget for DFU/fastboot/UMS
- BOARD_LATE_INIT for serial number in environment

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 configs/rzn1_snarc_defconfig | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/configs/rzn1_snarc_defconfig b/configs/rzn1_snarc_defconfig
index 65a9c25b4aa..dc3c076c5cf 100644
--- a/configs/rzn1_snarc_defconfig
+++ b/configs/rzn1_snarc_defconfig
@@ -3,21 +3,97 @@ CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_SYS_MALLOC_LEN=0xb0000
 CONFIG_SYS_MALLOC_F_LEN=0x800
+CONFIG_ENV_SOURCE_FILE="rzn1"
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r9a06g032-rzn1-snarc"
 CONFIG_RZN1=y
 CONFIG_SYS_LOAD_ADDR=0x80008000
+CONFIG_ZYNQ_SDHCI_MAX_FREQ=50000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x8fffffff
 # CONFIG_EFI_LOADER is not set
 # CONFIG_BOARD_EARLY_INIT_F is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_SYS_ALT_MEMTEST=y
 # CONFIG_SYS_ALT_MEMTEST_BITFLIP is not set
+CONFIG_CMD_SHA1SUM=y
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_MTD_OTP=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand0"
+CONFIG_MTDPARTS_DEFAULT="nand0:512M(ubi0)"
+CONFIG_EFI_PARTITION=y
+CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_CONTROL=y
 # CONFIG_OF_UPSTREAM is not set
+CONFIG_DFU_MMC=y
+CONFIG_DFU_MTD=y
+CONFIG_DFU_NAND=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_UDP_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x81000000
+CONFIG_FASTBOOT_BUF_SIZE=0x5000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_OEM_RUN=y
+CONFIG_FASTBOOT_OEM_BOARD=y
+CONFIG_DWAPB_GPIO=y
+CONFIG_MISC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ZYNQ=y
+CONFIG_MTD=y
+CONFIG_CFI_FLASH=y
+CONFIG_FLASH_CFI_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_NAND_EVATRONIX=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_DSA=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_DW_ALTDESCRIPTOR=y
+CONFIG_MV88E6XXX=y
+CONFIG_RZN1_A5PSW=y
+CONFIG_RZN1_MIIC=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_FIXED=y
 CONFIG_RAM=y
 CONFIG_CADENCE_DDR_CTRL=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_CADENCE_QSPI_WRITE_PROTECT=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Renesas Electronics"
+CONFIG_USB_GADGET_VENDOR_NUM=0x045b
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0239
+CONFIG_USB_GADGET_RENESAS_USBF=y

-- 
2.55.0

