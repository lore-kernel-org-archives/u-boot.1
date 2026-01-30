Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA58E6BF1B
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 15:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED90484500;
	Fri, 30 Jan 2026 16:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="faApMF03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 562A8843D1; Fri, 30 Jan 2026 16:39:43 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35EA284067
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 16:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=george.mccollister@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-662fe3ff6f6so1293069eaf.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769787579; x=1770392379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0GijrqfwaxANQCAmtF3bTGN6FXJSIWRzGIcmKvGtJTY=;
 b=faApMF03W7Ilrm/Lhgv8oeqnKyLWr908Ly+QCYWhNWrDoJQfXtEIkiCbL1bWPtDXGy
 O0zmCBxFH6H+N99j1vzv8ezpWXUeWrTerxhAhToM+GA1SNpuQZS3G/Daqt8VwB0inwO6
 OHOQF1iroLYidbFRvXZFcU1pudp3Wx1DFWs9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769787579; x=1770392379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0GijrqfwaxANQCAmtF3bTGN6FXJSIWRzGIcmKvGtJTY=;
 b=uegvO+BdSCcDLa75nAB8ME4aHhZeIpplZixRGeb/Fn+8jGH5T5czvVs8Xo2vFdUHqb
 wNGUPwHR+3gAMau26oJpj6eCnG7qdWkLMgiLqtPIMIy4yYSdNJFRYXgoZbxKbNEAhdce
 FzOMpiihj9hUYoDe4NYXIYaeYSToVnn0vlxyYFKKI+DX131nL/CjSozZDgkluo3OBpGl
 i2ZlFnQjpEAPCm1SCH/tLfos+//y04LRG3sQmu486ugB4Rm6p7XO8hE2u7EaSm2V4Qvf
 VOyH3Y/4sXnis2hB4DgwNkkZg7benfkNZrDEHYWA8G2n1/1zKiCboKa3Tn1Oamz5Vlt1
 3QyQ==
X-Gm-Message-State: AOJu0YwbYYZdQml0zZWUIsA2kqs7wsItn4HaFYSeIMJ2+3z7a2Pjp8Qp
 7v3h4WeuMXh4oidkfmkUasq/qBuA/N2T9FnCgZgKCQlpb6nYYwuYh9kX9I+sOIXhrsQpTeGGi/9
 ii/ff
X-Gm-Gg: AZuq6aIPiANGbNmCqCQW9YfpIzGMQFMLgSJr3AI00qEHj7aN1y76GntZHoQNydxdaLP
 0P0ymBd/6uCrczxpMbHjiLsstGwtnews/AXz7lW+rE4EHNd5VYvUv9EWBLimpxNb/f0KOUHpc86
 C06aJLe8Gchw+DSgKkS6dHbUEIVy2WVDW5rcikYcC9V1UWeANTARYPcikyzyml+q258s7k9M6sw
 mDaAcB7YYKYTirf2h+WgUI9LdzovflrM22YOJR0oDrG0rRTIDSmbqUWo6zwG/AxK1MCzud1EcDA
 Q+jrR3sxseAAQa4ufsj96/+9rs68CPgLGlIdj8BONGD1i6fIb+2duiHoaH0mDuk4xY9r8kLquha
 oOYjOSAx3FYP3qvQj51Yr0kOpiuGzrTFt7HA7YySuh+cK4wCZn09SvgkZlhH4MMTCWQLWjB9gwX
 jBJTyiT51ld9yvNVOTJCdumFeY8/m/KCPS1lQ=
X-Received: by 2002:a05:6820:229d:b0:65e:f5db:f478 with SMTP id
 006d021491bc7-6630f03c99fmr1634322eaf.22.1769787579695; 
 Fri, 30 Jan 2026 07:39:39 -0800 (PST)
Received: from ryzen.localdomain ([136.33.243.183])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095752ef7bsm5944934fac.16.2026.01.30.07.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 07:39:39 -0800 (PST)
From: George McCollister <george.mccollister@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>,
 George McCollister <george.mccollister@konsulko.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Judith Mendez <jm@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>,
 Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH v2 6/6] configs: j722s_evm_a53_defconfig: enable PCIe
Date: Fri, 30 Jan 2026 09:38:06 -0600
Message-ID: <20260130153856.2049575-7-george.mccollister@konsulko.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130153856.2049575-1-george.mccollister@konsulko.com>
References: <20260130153856.2049575-1-george.mccollister@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 30 Jan 2026 16:40:08 +0100
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

Enable PCIe now that it is fixed.

Signed-off-by: George McCollister <george.mccollister@konsulko.com>
Tested-by: Bryan Brattlof <bb@ti.com>
---

(no changes since v1)

 configs/j722s_evm_a53_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 74a67da9033a..e84670c75edf 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -27,6 +27,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_PCI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
@@ -53,6 +54,7 @@ CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
@@ -71,6 +73,7 @@ CONFIG_SPL_REGMAP=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_TI_SCI=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_MTD=y
@@ -115,6 +118,11 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_CDNS_TI=y
+CONFIG_PHY=y
+CONFIG_PHY_CADENCE_TORRENT=y
+CONFIG_PHY_J721E_WIZ=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.52.0

