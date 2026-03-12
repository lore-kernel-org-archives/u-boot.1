Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D03FED2F7
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9231883F00;
	Thu, 12 Mar 2026 10:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="frLXnIkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5663B83F53; Thu, 12 Mar 2026 10:33:19 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4B0183DA7
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:33:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKPefuK93O2abydv1kyFSFFnAFxjhZy8/0h4/bjnx1dB/lROx/XLlnqcxeQbwRsJ+NlEKeOs5RTVfacJSrO6DjMOh4nks7+cE4O7K2zhPFM4zyyoBZJHP9bjKaHJwj9us/ba7bgLhMfA6lNw9bAR7Q5YYJ6BkRiO+CEcDZRbKQqD5k4bGEu6Epx9DXajwlWDeZAr/ahx72F/2HAoPxoHqjMQOrd85MrMK7UuqHnZOIVIYPBUU5RMpEyssi8GCY+v+p/6f5/T0oDi7VjPcocKUPzYWffRwiDcHJhwM9QVIVvvwDNG8tweGCkkf+N/uV8DDWRbiyQNdiBIuWij2NjC5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32y4TPVWzFOjS7qFdEXTWBGQNM3KvipU55z09mLIIAg=;
 b=tvecNCBnXU8ejsy1K+XUaiNEtAxdl0l3DKIuUi7SkuH6yT1/iONGAuO8JDVg7vJwGcuxEp+9kBymwIXbd+G20iKER9AQnXgcziJ4CA95HbBOAMyc+pudeb1rhnAk5fAV3YZYcKsWkd90FcAIyj/eXiM32Wn56KFj4KPMBz8/8dZBSNxWIRUtLKxVq65olcmobslixVOxrIe04sgSae7gOULokGMM6+1wfagG3vFlZYWqJZtLe3Cn1PUt9OojDN/IYAZ2HPjjw6xrL7HdVSrN+q6x2ZxT1DxOzf39hJXpKd1k3ItgiJLDUBnCm3vRcggfbk6rbjjuQ4iTPt29eIiWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32y4TPVWzFOjS7qFdEXTWBGQNM3KvipU55z09mLIIAg=;
 b=frLXnIkW1vIqRn4TLMkkIbp+ovYxBEB5B0Zzmatcz3DmWKN6q1kux9LuK9luwS/epiDHf1/SuSUJARJhxtXqvRlUV4S2ohprkkDN4dy4BgwaigKIQJeOkEehUhCjzVSCPztTRnPGBg/tgGIlpFFhdEJHG+jcYfnCjLjkye12LKU=
Received: from CH0PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:b0::18)
 by DS7PR10MB5133.namprd10.prod.outlook.com (2603:10b6:5:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 09:33:12 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:610:b0:cafe::de) by CH0PR03CA0013.outlook.office365.com
 (2603:10b6:610:b0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.29 via Frontend Transport; Thu,
 12 Mar 2026 09:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 09:33:10 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 04:33:05 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 04:33:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 04:33:04 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62C9X3Kb2578561;
 Thu, 12 Mar 2026 04:33:04 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 12 Mar 2026 15:02:49 +0530
Subject: [PATCH] doc: board: fix OPTEE args for TI SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260312-optee_args_fix-v1-1-55972621c005@ti.com>
X-B4-Tracking: v=1; b=H4sIAECIsmkC/x2MQQqAIBAAvxJ7TlCTDn0lQjRX24uKRgTi35OOM
 zDToGIhrLBNDQo+VCnFAWKe4LxMDMjIDQbJ5coXIVnKN6I2JVTt6WXWKGu4ktwrByPKBYf+h/v
 R+weNMQkGYAAAAA==
X-Change-ID: 20260312-optee_args_fix-ba4ba0420f4d
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773307983; l=3742;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=t6GXuNS24IMFfio9xJG9XBIRWPZKbjryWwQRy+0qcZE=;
 b=2EGRoo0O6RzOm4HpoksneJDqFiXf5xL8C/pe3m7qdtbEEAkqfI+ztQBfYZ2jP0W2uyaPVilXC
 rhbz35uUElxCP+lj/Oevgb03iokadld/vcIWzhNZ3E7LXGe7U4cPzLT
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|DS7PR10MB5133:EE_
X-MS-Office365-Filtering-Correlation-Id: 673d9840-e0c2-4ea2-b793-08de801a607a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: g1i9mdMn9wkRGnFtlBBcKcNJvQ1rAwAw1TXwDyjR2T+6wRCFFKRipmTFXRurmL/XzJLPgLGTjpFbISFJvgaF9d2eup2BBxcDGWtZ0UpcZqxcaxDo13vKq6KOkSWcM9/S+y2eUZZhndbs7jUpFG1MknhqslDAIhsWPHdmgXa/mcxdISl7XQXWZojiYisxop8Kq2+BjU49uyHFqpmZVssZruVwV8ucvYHwJBH1FF5V+G2uoqGdQ0+h41y3bJj9rztl/ex0KzWa9RJRfXTDLhbtdMAVQyNxY9MmQvuzwcJqhxuRGL9a6nrD+eW0GgM/Iv3hnEmknm7hbuvwhWEOnC/7Z1KmLY+8n2/k3FFReJVC2J/BD3f7rscg4Fsby5oyomRziQK17/a/S0qW5JYVy7QZmqjnXuYlNqgxqIy3NDyj16VkuNzjRQnNHhVquER34jEzXtw8ZA2FDFjuF2DEKfeOZQFlBZHEDepm0vTzvhUGX0BFSf4BT3ti8LjEqq9Px5JGl/0GrWozAHEYjM8x/Q/lgvnnmTnnTJGBRdCCDKXf4EN2gXb5RU+xpZv3nN8yZX6Wo2IvIpWqpGIhIB8nDm1/mtt+Tb3sB7YfRlsq2tZe6JQQbkrN0XHX8xcbtz9bYZ0AvAgcRL7x3upO1dhKNAqVk3uH1afzHk29/Tq7phtKgy9+VpWxr1Kk6EzYvdcoGaB3heZxE8tNaob8rUwWOqbRBr5uesKUAaPDJeQVQPs7lDM=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sZJuKpC3kQmYt/dcJ8v9eT/2g8ziH8SfFO7yv8hc1bZTUxk3J1Fo5W5H6gzMTweIw4b/k2J28HtcFT3JtPnVufGH0QgQ9Tu9alfQ6RRvpc8s0nwj2jWFBQ1BScJtOz2kH1pVwJqYfuSRyNpVbfSzEcSaXPgaMKwLf7//UrKyVZFjl2havqvu0OUYYJskLC/vZvHe9/7C2iwGt2hvDK/nJvlzIFzLjQ3SZ5Av1+09dJbPMs/D093EMN0OSDcq3X0/6mkvUbx3E/4NfA8Cen+g1YGEduvq2Hrg4nqdjfhYxDVRKbSFRCguY5/D1rjsSjFydItrpli+PNTH9bDc2VejkOCaDejT5FU2SHmYD4y4QijoEEMXsU5VgJijepP+Xv9xlS8ggO80/JWQA+dEXRpn3XYwyT9T5uHI3aiT/pnPFAZppvfjwwhZMFUxOs91lZvg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:33:10.8352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 673d9840-e0c2-4ea2-b793-08de801a607a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5133
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

CFG_WITH_SOFTWARE_PRNG=y was added as an OPTEE argument to workaround
some bugs related to TRNG which have been fixed now[1]. Therefore this
patch drops the redundant argument from the documentation.

[1]: https://github.com/OP-TEE/optee_os/commit/e313f4765fd0478bb66985827441411793433773

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 doc/board/beagle/am62x_beagleplay.rst | 3 ++-
 doc/board/phytec/phycore-am62x.rst    | 3 ++-
 doc/board/ti/am62px_sk.rst            | 4 +++-
 doc/board/ti/am62x_sk.rst             | 4 ++--
 doc/board/toradex/verdin-am62.rst     | 3 ++-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
index bc71aabaac3..64a05549caf 100644
--- a/doc/board/beagle/am62x_beagleplay.rst
+++ b/doc/board/beagle/am62x_beagleplay.rst
@@ -67,7 +67,8 @@ Set the variables corresponding to this platform:
   # we dont use any extra TFA parameters
   unset TFA_EXTRA_ARGS
   export OPTEE_PLATFORM=k3-am62x
-  export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+  # we dont use any extra OPTEE parameters
+  unset OPTEE_EXTRA_ARGS
 
 .. include::  ../ti/am62x_sk.rst
     :start-after: .. am62x_evm_rst_include_start_build_steps
diff --git a/doc/board/phytec/phycore-am62x.rst b/doc/board/phytec/phycore-am62x.rst
index 36315b49931..bd61d0c16cf 100644
--- a/doc/board/phytec/phycore-am62x.rst
+++ b/doc/board/phytec/phycore-am62x.rst
@@ -60,7 +60,8 @@ Set the variables corresponding to this platform:
  $ # we don't use any extra TFA parameters
  $ unset TFA_EXTRA_ARGS
  $ export OPTEE_PLATFORM=k3-am62x
- $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+ $ # we dont use any extra OPTEE parameters
+ $ unset OPTEE_EXTRA_ARGS
 
 .. include::  ../ti/am62x_sk.rst
     :start-after: .. am62x_evm_rst_include_start_build_steps
diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
index da70cd58095..2fd00e88285 100644
--- a/doc/board/ti/am62px_sk.rst
+++ b/doc/board/ti/am62px_sk.rst
@@ -99,7 +99,9 @@ Set the variables corresponding to this platform:
    # we dont use any extra TFA parameters
    unset TFA_EXTRA_ARGS
    export OPTEE_PLATFORM=k3-am62x
-   export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+   # we dont use any extra OPTEE parameters
+   unset OPTEE_EXTRA_ARGS
+
 
 .. am62px_evm_rst_include_start_build_steps
 
diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
index b50fff87506..2480733e2da 100644
--- a/doc/board/ti/am62x_sk.rst
+++ b/doc/board/ti/am62x_sk.rst
@@ -87,8 +87,8 @@ Set the variables corresponding to this platform:
   export TFA_BOARD=lite
   # we dont use any extra TFA parameters
   unset TFA_EXTRA_ARGS
-  export OPTEE_PLATFORM=k3-am62x
-  export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+  # we dont use any extra OPTEE parameters
+  unset OPTEE_EXTRA_ARGS
 
 .. am62x_evm_rst_include_start_build_steps
 
diff --git a/doc/board/toradex/verdin-am62.rst b/doc/board/toradex/verdin-am62.rst
index 93912adc896..aaca6fd1a73 100644
--- a/doc/board/toradex/verdin-am62.rst
+++ b/doc/board/toradex/verdin-am62.rst
@@ -59,7 +59,8 @@ Set the variables corresponding to this platform:
  $ # we don't use any extra TFA parameters
  $ unset TFA_EXTRA_ARGS
  $ export OPTEE_PLATFORM=k3-am62x
- $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+ $ # we dont use any extra OPTEE parameters
+ $ unset OPTEE_EXTRA_ARGS
 
 .. include::  ../ti/am62x_sk.rst
     :start-after: .. am62x_evm_rst_include_start_build_steps

---
base-commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37
change-id: 20260312-optee_args_fix-ba4ba0420f4d

Best regards,
-- 
Anshul Dalal <anshuld@ti.com>

