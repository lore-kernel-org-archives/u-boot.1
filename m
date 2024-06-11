Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC52C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 405D68863F;
	Tue, 11 Jun 2024 11:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="daPhQlkq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C44878862E; Tue, 11 Jun 2024 11:42:07 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8726483333
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so40472595ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718098922; x=1718703722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJLNd2bVDtFBGplJnB/N8CCKyYJc/gcR46Ikjmo7Rnw=;
 b=daPhQlkqd6DzUAVrr37DYe4Oo6/0emJ/4s+98TqD0Fg+tBuY94sPGx65jbcaVUT3d2
 HEP/h4sUMBb1Vk5zMemNyuuo8+33CcpbvF3xgOBODF8b1cNLNI6BLTEsgVWKaLU5gmkH
 mJuyC8p9WtFpy1V1gtJ0YfNWil41M7fRtpq5jLdM8XrsxtreDqwYiYnOyiX5aksh8kb2
 l7MGUOxxKN9vVPYpfQxw33impJJrTKQsImSfvUsk8GbB8boxgUOL24FRHCxP+V0Ntf2R
 Te5Cki65yEG8E5BLg8kBTptE3eDAQaHb6fW26fhbVuYniTPgGDOyvT0pIqt5/J7Tan36
 xTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718098922; x=1718703722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJLNd2bVDtFBGplJnB/N8CCKyYJc/gcR46Ikjmo7Rnw=;
 b=EDp8EyM03EaBulmwFYvPSPKivJlX+Rsjk2h9TUuszJINUdJ55KttzNCNAGkCfzcDcs
 n0Dk15/yl2biwqMufIn4LZ3DQxv5w+CTQEJCIuL7G/w0rIfqaA7AF7DpeVXNYzovrM9Y
 hph8FGJNvf/iykBsupHv18KbOwVlGErgZGgRRsi96ZJc2Jn1p/5/8C4l5/pUfMkPBGR0
 RcPWQK6e880gn2kGeogaM0VcuUcMylGOfF34AI35LLInMEu9IMG34iBZg9AkGE3Dwprh
 I3j77woi6d4Qsa7Tr0YaGH3/COk/SSaYNKyMzAhqhPGFm9qRTSpXINZoeMWntZ4Tv36m
 ScSg==
X-Gm-Message-State: AOJu0Yy2yW4ULTz77Ex3LPuQGBhDf1KwFs+6/nrBoHOx+DC7Q/sMADaF
 C3+P/F1apNk3ev+TfKCczczWbqBJNt6umjXBx5q/5OS9KLlLAnblaJo2WdqA
X-Google-Smtp-Source: AGHT+IFCesba84y1+Zv3b0Z95+YdX/BFtNYJCubrYv5+52zLzYuxgYCL0LdDqyIhqEu3ovqzjUkoDQ==
X-Received: by 2002:a17:902:f552:b0:1f4:a04e:8713 with SMTP id
 d9443c01a7336-1f72892538emr32825005ad.28.1718098921965; 
 Tue, 11 Jun 2024 02:42:01 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6d859ea3csm76873555ad.178.2024.06.11.02.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 02:42:01 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 3/4] configs: milkv_duo: Enable clock controller
Date: Tue, 11 Jun 2024 17:41:15 +0800
Message-ID: <20240611094134.18868-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611094134.18868-1-seashell11234455@gmail.com>
References: <20240611094134.18868-1-seashell11234455@gmail.com>
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

Add configs to enable clock controller for Sophgo Milk-V Duo board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

(no changes since v1)

 configs/milkv_duo_defconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 0cb2922de4..1186763a73 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=y
 CONFIG_SYS_MALLOC_LEN=0x820000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
@@ -26,17 +26,18 @@ CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_CLK_SOPHGO_CV1800B=y
 CONFIG_MMC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_CV1800B=y
-CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI=y
 CONFIG_CV1800B_SPIF=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CV1800B=y
-- 
2.41.0

