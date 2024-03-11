Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB95C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D1B87F00;
	Mon, 11 Mar 2024 14:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="dp4Aw52M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C3787DD5; Mon, 11 Mar 2024 14:04:23 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 889B887E1A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710162258; x=1712754258;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LrKLYBpT5WWvjnaJaXfH2VhkmaLVCgL4JqaQg7kwqyY=;
 b=dp4Aw52MnGTnM8I8RYeTDNwegLiuNgjaA5SnNXN8V97czBr8T8gXftzysaz0FTTg
 YS+3pPxPpawJucZEbVFsYQkF30v0QjAZ9X9Du7uW47EnRRFC6DBLKL65VD6UwwPt
 8lMLFwCIJYcR1JX0xvLSrnJhDd63uAwcLJB9VHnjcvM=;
X-AuditID: ac14000a-fadff7000000290d-0c-65ef01529025
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 54.93.10509.2510FE56;
 Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 14:04:18 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
Date: Mon, 11 Mar 2024 14:03:58 +0100
Message-ID: <20240311130400.4023780-4-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311130400.4023780-1-l.anderweit@phytec.de>
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBRzeI8X2qwct3/BYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgybr7YzVLQ
 yF4x9WMrWwPjDLYuRk4OCQETie7eXUxdjFwcQgKLmST2TJ4D5TxmlLh4ZA07SBWbgL7EypeL
 WEBsEQEXiV9L9wDZHBzMAmYSEz4ng4SFBQIl1nfMAStnEVCVePn5J9gCXgEbiYP9k1ghlslL
 zLz0HayGU8BWYtaDv8wgthBQzZtNF6HqBSVOznwCtooZqL5562xmCFtC4uCLF1D1ShJ3Tv1i
 g5k57dxrZgg7VOLIptVMExiFZiEZNQvJqFlIRi1gZF7FKJSbmZydWpSZrVeQUVmSmqyXkrqJ
 ERTkIgxcOxj75ngcYmTiYDzEKMHBrCTC+1rnbaoQb0piZVVqUX58UWlOavEhRmkOFiVx3tUd
 walCAumJJanZqakFqUUwWSYOTilgaGcKfHG4Xhj43yvAMmpvRc+R7evV79b/KI/8YfaUYa12
 yMpJDQqPJt65fCev8oiZG0fF1d9T7UtU/72YPY1hA8c3oelc9amT+OKuTZ/2ZL5od92UxVpf
 LyX1iG0SXCp1f1oOy4maf+XHUq5Y358+feYv1UI7r6Dexf/ZDkw5OWvmlrk3a6V3eiqxFGck
 GmoxFxUnAgDCs9iVYAIAAA==
X-Mailman-Approved-At: Mon, 11 Mar 2024 14:06:01 +0100
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

Add support for the redundant environment.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index fd492eba3c10..6c67f14b5559 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -19,6 +19,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x3e0000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_FIT=y
@@ -77,6 +78,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=2
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
-- 
2.25.1

