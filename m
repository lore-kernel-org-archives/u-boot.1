Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F4CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:20:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E888467A;
	Wed, 13 May 2026 09:19:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QpoSW9hs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D6084674; Wed, 13 May 2026 09:19:24 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727C384659
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO0e1mO3assuNKU7hOtuZabxv0/QWeDN3974RAKtW0PjOLKLT8rD+wNKf11XIxlI6uxVeCoFYFTJRTVTfgOwhpq57IKNigDPXZk0zJYYdsofJI7XPvPXXs6aPglGJLvdSN/4vZn9KcNltv3KSRRGrMuYtkLSPSPz5kXuRI68KF+3MZYEmiCYSbXsKvXpnJmkqhOHih7088QYyr/0sdqjIFv1P/q1tiqauY5THl7SCvarHFTl6z2UpwpcNtJxaPREDXYAUgHBFeQ9jLT3/qD7lcr5qAcl2PkvCIk+LE2StiKTGfelsJ6jK5HGFUB/WbnSjQHzAAh5HbeTfMMpqwJVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXa+FU3QpmSPxgLUq14oh6OahSc0IeiQQOVESoKKIec=;
 b=ouFhPYBLMxrf9IJiA3Itfirg6o2PdwFgVM3yCIZjnj7M6qY/yXH69Ibt/fX/XSao7OpvXEeayw4HCc7mI1cMWXUewM/C3jyen8gAq4YXvKz3w/AqbU1oTKf34CLUBqYMR3EMm7JO3qHDi/+t2eRjHMARpndi9tD6jERh7k/QCGR+S4H7Wx0pYamBCAIHH03fzIGsbHgAMCrKkUTMhOUwWgh25afjGH2kBTS8dmIURP0GLhqYOpBZh5GRfE8+Ga3vPhj53UV7wU38I+Uv0nlQB01ShtvOm65gnTzHq7lPOueK2gucuSG9d/DuKblb5TRQQQ31xCfJkl5rEQANpNXFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXa+FU3QpmSPxgLUq14oh6OahSc0IeiQQOVESoKKIec=;
 b=QpoSW9hsxgXVReP6EwMZ2pFEdOhQKXJ3aDvkeSkMvW14kL/Ohvj8ItCytGFTzt0jd0IONzXn4l6e4+/yzLMC9D749wOmFPPKOXztB4oATeDjA+EneElHqsoKE//EP0yE1cOd9MnzFUu03TTCJymHMy7V3OrPcZrB04j+eGToEuP16fc/0C/+MmIV0C48ZWAP+5anVrzNf3HI5iq01HoswegZwQ3EPchAtQGjlT+LSuCrIs10wOVv+s/t4uVfblxTwWbcOCN3SIMlcPwB0URYup+tNGAzQFPHdMcT98X63ZfUBqyhwLR+Cg8eVjgjuFW0gYWupXypg7s9c5wDujorUw==
Received: from AS4P189CA0060.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::15)
 by VI0P195MB3249.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:31e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:19:16 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::72) by AS4P189CA0060.outlook.office365.com
 (2603:10a6:20b:659::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 07:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:19:16 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 09:19:14 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.haller@phytec.de>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 5/7] doc: board: phytec: Fix typos and copy-paste errors in K3
 docs
Date: Wed, 13 May 2026 09:19:03 +0200
Message-ID: <20260513071905.83522-6-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513071905.83522-1-w.egorov@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|VI0P195MB3249:EE_
X-MS-Office365-Filtering-Correlation-Id: 340987fd-b8a6-4800-d73c-08deb0bff123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|3023799003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: SdJ1tZMYKHRsmSc9ESQZGB+BqYSNUhZGh1MAPe5UmznbxHK8ar7ffbolmWveKRiIPt/ZW/Qw0t4VEq2aQUurVWzwSQ4cfPfwl9iyfRamgWRG5UIAuLspdwbS0fuNGCcmJqDZUqJM5gltKgNCsKsEC7xX0Sm7b3aK5gnk83zRDYEdoGKj0SU/vYrbah9C0X1RkR6m6tTaDDgbqrryb+Y3DBxdB2bcvHaTMFR9M0tmOEOApgCeDsdabuDSnGrTLuB2AwlADo6LoWffI9crPpcdmGpZLLmJFDuGutg1pe6cdlYMMJ09LV+Y+sgKzL7ANwZ0OqQmVYn6rfjcQr36cEOAQOsgHl4XgPRuUTx3bBrkt+nw1yHCbUk4wBF/Z+EFDRWEuEas789Y8EtdBF1HmBo69AlCz/YjJkYDU7d9gPpmtv0CQqSb1E8ACO8U/BTl32EOQuAc1cRWyj7eb8Akbe9HEdj6jW0fUC1NMl6eJ0GlpqfrfHNT+0HPTH+e7dzlxis894dmfTSo1XOq04Ekz7/YX9k9y06HFqscmsiZB8y0zjGr99viXf/BoDUK9YxGd6qOKfzkoYii91d4clnR/sFbYrBGwspb7CkG+pMRXX21Di9h4AFbZ77MhQyQqrLpQRxDN2ImEVcsWBuSB5tUu/fBNbx1sYX7ZIe01jQtBk0310A1N/YQyl/8WhKFCRdyJNHrz/Q3MGiOK1EXJkmNpPwyzixqrg80oU6OBVtjSd7Cnkk=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(3023799003)(11063799003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 91fhOy8ggdoFtVcZxQ5p+n3Zx4CTWEhoiMrvkSHHRz91IVgZdbMcqS45vOfb6hxx2HnAxfTKagAsV2j9yAMr0AEviC6apk2yolEA4kPKBj+HYkOhhbxSq/aEBI6JcXqEesA/h+UHbUPX2exC5j2hKV6yrjbHY8visbf5lkGIc5gSXALTzHDfyf312ElG7LwJUqLq5C4iVpS1//UEqwKDnREpGVlFG5bf+Lo0xfBLKLGXbzXUT/YzTCsmKTwfhOGLOA1pUoWtZVUzQxrwLL+RNMu6blVTqM3XEDugbj5KGr/iMieo2R1ZIddx/CJbtTT7jm+0YuuvdQb7o5QyfYI8C5v13u+YJaoJYD25iF/clq/3pBVrwpgaiTuapi0Fv7iT+g7AnCKcnI6W419STnP4bz/qF0IH1teTd7MhiBD3asng4lEcR1tlEp1tVlIdGQ8k
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:19:16.3611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340987fd-b8a6-4800-d73c-08deb0bff123
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB3249
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

A handful of small inaccuracies had crept into the phyCORE-AM6x docs.
Mostly typos and formatting Issues. Fix them. While at it, update the
am62a board to use the correct product link.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 doc/board/phytec/phycore-am62ax.rst | 8 ++++----
 doc/board/phytec/phycore-am62x.rst  | 2 +-
 doc/board/phytec/phycore-am64x.rst  | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/doc/board/phytec/phycore-am62ax.rst b/doc/board/phytec/phycore-am62ax.rst
index e1f741011e7..aa3518a07ff 100644
--- a/doc/board/phytec/phycore-am62ax.rst
+++ b/doc/board/phytec/phycore-am62ax.rst
@@ -9,7 +9,7 @@ SoM (System on Module) featuring TI's AM62Ax SoC. It can be used in combination
 with different carrier boards. This module can come with different sizes and
 models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM62Ax family.
 
-A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62x>`_
+A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62a>`_
 is used as a carrier board reference design around the AM62Ax SoM.
 
 Quickstart
@@ -57,10 +57,10 @@ Set the variables corresponding to this platform:
  $ export UBOOT_CFG_CORTEXR=phycore_am62ax_r5_defconfig
  $ export UBOOT_CFG_CORTEXA=phycore_am62ax_a53_defconfig
  $ export TFA_BOARD=lite
- $ # we dont use any extra TFA parameters
+ $ # we don't use any extra TFA parameters
  $ unset TFA_EXTRA_ARGS
  $ export OPTEE_PLATFORM=k3-am62ax
- $ # we dont use any extra OPTEE parameters
+ $ # we don't use any extra OPTEE parameters
  $ unset OPTEE_EXTRA_ARGS
 
 1. Trusted Firmware-A:
@@ -147,7 +147,7 @@ the main domain serial port:
 Boot Modes
 ----------
 
-The phyCORE-AM62x development kit supports booting from many different
+The phyCORE-AM62Ax development kit supports booting from many different
 interfaces. By default, the development kit is set to boot from the micro-SD
 card. To change the boot device, DIP switches S5 and S6 can be used.
 Boot switches should be changed with power off.
diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index bd61d0c16cf..f5a0d51240a 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -60,7 +60,7 @@ Set the variables corresponding to this platform:
  $ # we don't use any extra TFA parameters
  $ unset TFA_EXTRA_ARGS
  $ export OPTEE_PLATFORM=k3-am62x
- $ # we dont use any extra OPTEE parameters
+ $ # we don't use any extra OPTEE parameters
  $ unset OPTEE_EXTRA_ARGS
 
 .. include::  ../ti/am62x_sk.rst
diff --git a/doc/board/phytec/phycore-am64x.rst b/doc/board/phytec/phycore-am64x.rst
index 71f1fd7b404..c6677f6a440 100644
--- a/doc/board/phytec/phycore-am64x.rst
+++ b/doc/board/phytec/phycore-am64x.rst
@@ -60,8 +60,8 @@ Set the variables corresponding to this platform:
  $ # we don't use any extra TFA parameters
  $ unset TFA_EXTRA_ARGS
  $ export OPTEE_PLATFORM=k3-am64x
- # we don't use any extra OPTEE parameters
- unset OPTEE_EXTRA_ARGS
+ $ # we don't use any extra OPTEE parameters
+ $ unset OPTEE_EXTRA_ARGS
 
 .. include::  ../ti/am62x_sk.rst
     :start-after: .. am62x_evm_rst_include_start_build_steps
@@ -148,7 +148,7 @@ Boot Modes
 
 The phyCORE-AM64x development kit supports booting from many different
 interfaces. By default, the development kit is set to boot from the micro-SD
-card. To change the boot device, DIP switches S5 and S6 can be used.
+card. To change the boot device, DIP switches SW3 and SW4 can be used.
 Boot switches should be changed with power off.
 
 .. list-table:: Boot Modes
-- 
2.48.1

