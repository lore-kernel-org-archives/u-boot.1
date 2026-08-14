Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3717DC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9DDF60DCD;
	Fri, 14 Aug 2026 18:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u867g_MeNa62; Fri, 14 Aug 2026 18:39:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0556A60ABE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732759;
	bh=4EPYbDLqJXsYF2N+kS0swtUUsYinD9cVML0nrygLkWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qzC3Fk/9suz57VvdJI+a4dhgwBcwHFPeIcFPb2pyGQsoyeRl7k9rplu7qFcUzcF+y
	 ApQQv4n/zOn+jkW7HkxxkVBzmZayZf/xikYIjopmV8eLwTYvNmj5MxU+Siip61EQGo
	 Ho7cjrajKi73JwVX7DwYO0cG8uZlVb9CMm3T2kFhwDAbJF+1XzV/2gTsdgVYztFfCm
	 ZV2Oob2AuAinJ0fjwuDY/Q8at+uLZRqc9Yq8UOGo6B/CHIST7w2/uURx9ekOheBauf
	 7I3jYxMtMx/SCV79zlbCsbZ/qbXQGxBqYET5pSJeMRIuwFKG60i7jgcdyXFuKBNUmo
	 eDkIYG2H/IMhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0556A60ABE;
	Fri, 14 Aug 2026 18:39:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B9FF3A0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FF1440C9A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rQbT4Lr2iMsX for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3CD9A40D21
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CD9A40D21
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=JWcS9Uzr
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CD9A40D21
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:39:11 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-517dc520840so10755851cf.3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732750; x=1787337550;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4EPYbDLqJXsYF2N+kS0swtUUsYinD9cVML0nrygLkWs=;
 b=JWcS9UzrCrBejrgn/n/ijus7+EdY6ZYeZKI+YYG3Popz8RQKL7vxegFUiOSkoVUJO2
 UuPsBXSNpMds9Oe3m6uECeq2+dTs05sTXZ/o/t8IYVE1SpGpTqL2s5zpnHQSY8AwkemW
 c+EDgaaTW/R+7JzS+9fTY83LjElLvYHUo6ZQFl/tfPd6/uPQR/mORsmkwNVhhzkSUsWl
 +xb7oUTyInzM5FK3PU6bTDTk/6snLu3mLshJWV99V9qR3Pq55s1NX/mIDcXvyw+zSES/
 RQhvvmTrweBaxqkLyLd2FbJEVKk7qg/lqgugGNoPwH7Oxg1RLX2/N+TooDKhB7VsrMEE
 pCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732750; x=1787337550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4EPYbDLqJXsYF2N+kS0swtUUsYinD9cVML0nrygLkWs=;
 b=jEKC/kn3hpSVCy1jTR4VEbtYVTJ0s83bQnjOpsIPCdBisPc0gDtwuRdLzdwxORdgUP
 MQwy+Fs5W+ERkF0gYqYtTqBAhTqdtcnOVMedKGePRyUow6DrmG10HOb6CpZmLNTQdpRP
 qNfQcXaWdIFhf4ykveJ0DBr6W+Ip2axZCzwJwyplTr/WSmbD0KRBXHYkQG5BF89s3NMv
 QgphVEpzuMmSZE/Vv+kjuOZwH3eQg2CNPIE1IsFv6vITYUUkchiEM4QvkGtNdMzUOPVN
 vhJ/nm7GG4EvA236hFcF4dcrB/GgVAYP0XoHqX0dDELxVh29sDsht0Tz2H41xPmt5pWZ
 I9XA==
X-Gm-Message-State: AOJu0Yx1HPfhtiRMG1NIz0FHBtmpxKzqlcy+1igEG89TmnRfWhtsXX0e
 Nxgx1okJ8r81M7cs/hEB0p29DRv86/mBzUPO0STk6fhXno8GLM+T7vr3HJ5oWNlNGE/1TYNP8mp
 RZcbB810=
X-Gm-Gg: AR+sD10TyZw9g59h0BEHz41VY1N40eDnDJ7DVFj1+ANn062rn8Qr1pidUrM/Wbba3Jo
 FMdGmM2/hAEpn80oirHbAWTa+Q+abWZG2qQk351WpN2RAijH5MQk8+8567Jpia1jlIk5ij/xOCH
 QEXjO6yqR5JOMtTgN0iT1BPw9J8I4W7TpRlFE5gxawFM+kKud0TGeq4SeUKCekhy+1ccuDMnpRm
 QFf7Zq1agmRlZH+bsXwkGoS/u2O6cq6GCIKbxuCXHJEibjzuqFTc+1aEwGvmkcpiUz4H9QbhwH1
 wxJpSzkU5q3S9yfaCeGcmlWXOZa17Vlzq/869M0jpPo8gyrurNJzitK5SP0IP5CK2YqITpHP1eC
 R52zfFUaPmzoo2SWnb8V32FKzr0IXjRene5c9nUQEpFNtW9Wv43U/u4ar2KCOtNftdr3JlfytK8
 oY5jBHc5hc9cSYAl1TK9hQIF7V7Vmm3WFvNqFgFsNiD67OVNo1PyEBsDx75zTsBl8VZnYBsbFXx
 POUSuOn4+CM64vYA3hkqzUT6z4zg31IxJLTD0GJPyIRfuG45K35qxE5
X-Received: by 2002:ac8:5a0c:0:b0:52d:2b8b:a138 with SMTP id
 d75a77b69052e-52d854c3207mr89950921cf.26.1786732749779; 
 Fri, 14 Aug 2026 11:39:09 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52d83f00024sm27617031cf.11.2026.08.14.11.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:39:09 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:39:00 -0400
Subject: [PATCH v2 8/8] configs: rzn1_snarc_defconfig: enable new drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-v2-8-56b6acef0439@linaro.org>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732739; l=3527;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=PaVT7fpWUBpoT5H3NosUuURJ29bEsYxhVMxlFi1DObw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHz3HMIdt2cojsDQV7KyILOama7y7aa6fFFXrRzozWVURlIfGk75f+40Wh/nUDdWCqLHjYcQj33
 6Z9DkDo4zww0=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
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

