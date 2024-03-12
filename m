Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B640C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0739C87F83;
	Tue, 12 Mar 2024 15:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="A3e0B9rI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F228787F50; Tue, 12 Mar 2024 15:30:46 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EBE387F56
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710253843; x=1712845843;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4g5DlWpQdBTNv2sjQ3JWo+FIHJtW2mmDIEmU75mbsw0=;
 b=A3e0B9rIXL8SuBUdH4ur3XZv1tBDEggoxbLQU2a/cTDGdbw630eEW/PUbeA0kzr6
 peGBCgcx4esI2YGZOhSaUn7ieQBcKEFiJwslluM6yGVwVfyPwctqh5weMhCWa0sa
 mHgDrp2DLYXau/kz0qzZI5LKfitkT39yKRr7fg+l9zY=;
X-AuditID: ac14000a-fbefe7000000290d-9b-65f0671309e6
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AA.0A.10509.31760F56;
 Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:30:43 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v3 3/5] configs: phycore-imx8mp_defconfig: Use redundant
 environment
Date: Tue, 12 Mar 2024 15:30:31 +0100
Message-ID: <20240312143033.3336-4-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312143033.3336-1-l.anderweit@phytec.de>
References: <20240312143033.3336-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR1c4/UOqwY5PUhYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgytrUdZSnY
 wF4xZWUnWwPjIbYuRk4OCQETiYOfG9i7GLk4hAQWM0ksmtXBBOE8ZpTo3tfEAlLFJqAvsfLl
 IjBbRMBF4tfSPUA2BwezgJnEhM/JIGFhgRCJpul9zCA2i4CqxKopm5hAbF4BS4mGG1MZIZbJ
 S8y89J0dxOYUsJLY9m4XmC0EVDO79xEjRL2gxMmZT8BWMQPVN2+dzQxhS0gcfPGCGaJeSeLO
 qV9sMDOnnXvNDGGHShzZtJppAqPQLCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz9QoyKktSk/VS
 UjcxgoJchIFrB2PfHI9DjEwcjIcYJTiYlUR4X+u8TRXiTUmsrEotyo8vKs1JLT7EKM3BoiTO
 u7ojOFVIID2xJDU7NbUgtQgmy8TBKdXAuKxOMY/pzR3TlCCJnF1Fa9T3a7u38uhd51n2lXc/
 14b9yX4nv7acvmldK5H2cum+BpmujKtbJHI7w9vOfCueNPN76NwZN1j/+XvWRc+d7Pqvpb98
 sZUbf9Sz6e+T3Z9WWK7yL7/UErd6pWfcMbalCkEO63M98yYx8Bh6ht74M2+O2M516a//KrEU
 ZyQaajEXFScCAJwGrxlgAgAA
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
Tested-by: Teresa Remmet <t.remmet@phytec.de>
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

