Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40337CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C924C84852;
	Tue, 19 May 2026 16:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pccHlboA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C7FA843B6; Tue, 19 May 2026 16:17:53 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C03C484851
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlqwXPsLJa+/yjGsrldy/sBlT3Er7MRLpEpx8vRmRmXdjoxtz/qTHuLEStGATQaCkag5BXEcOUWcuvobrXM9z4CYldx7kAdxjap1F4dTpT5GrEaw9yM4tQLD9kOSn7PBUKdSTVPfKQ1PDeXe5Z5yHzc6iCL3HrBtVEAZeZ8O7+wWSpnZ12n2CpykN3aRWJ/7cIdp3TLIggWwW47tswGzKhLYlITPyGrB2JD6bcm5eP5Ln3GdcGPSZB0cQ7HKXQ/L/PY6PA00RmWNH08Gs/uckYBkEGvyH6V38pmc5JpcMkBWOLTMKvyiO4QZKPuMaxHr4/9pMSzWjqbFBXCBRKR6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8//xF5/EUqUGdzl3t+5abm1PzBxFohlNvZ/4NRyAmjw=;
 b=p27JfOPm9RpcDIOxAJo14y14sqk7CwKPS3k8YAc2+wMWx1irUPCuMcxqV8R0qpydinpyCCDcNdemvSekVscNcYx/RcnxZMlekool8I0gnCrAIhputmbnWEwed4y/yaizf9RWo2W+GmW6UZPK68t2FxyaXXds8HE3BTAXrbKPAYzNQgtFDPoEsb2ql5LRZO8SHQdJinmENHpJNKrvpZTLnVTasD36alsTXSfJUKS2ak1+1U8EC7jRpJXCEvxf++Lw373kPR+e4OlIeGnNpAw/l7sk59oa9MlR9SgtR0JHZJknuMMnd0yjQd+9G1C9BhrnclnhwHuLyEF500s0kgjnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8//xF5/EUqUGdzl3t+5abm1PzBxFohlNvZ/4NRyAmjw=;
 b=pccHlboA34MsLuHJztcc/5eND5ZkK0dpjAdcNLKCnwyQoiPz7sXictT88YYpiQI1dNCeqcDqvtrqFHXpSIpee/bKgq89ToY/U15LGCbZwOwJWdXDW4D59ApqaYuekUANekM68Ww6GekhSCX67mCzorZrW9dwzmZ9RZ4AtmPN09s=
Received: from BY3PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:39a::19)
 by DM3PPFF584262A5.namprd10.prod.outlook.com (2603:10b6:f:fc00::c58)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 14:17:44 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::21) by BY3PR03CA0014.outlook.office365.com
 (2603:10b6:a03:39a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 14:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 14:17:42 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:20 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 09:17:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 19 May 2026 09:17:20 -0500
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64JEHH0Q3643846;
 Tue, 19 May 2026 09:17:18 -0500
From: Swamil Jain <s-jain1@ti.com>
To: <bb@ti.com>, <trini@konsulko.com>
CC: <devarsht@ti.com>, <anshuld@ti.com>, <praneeth@ti.com>,
 <n-francis@ti.com>, <s-jain1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 0/4] Enable splashscreen functionality on AM62X
Date: Tue, 19 May 2026 19:47:12 +0530
Message-ID: <20260519141716.1346635-1-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|DM3PPFF584262A5:EE_
X-MS-Office365-Filtering-Correlation-Id: cceee976-0086-4fca-501e-08deb5b163fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|3023799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ad9eMcjZZWF5hK8NB9fvgCFDDgRTnTNBCtZjGn9hz2jaTpEXKCGf5+LmbmYVlsdrwDPnLenoKME5UUdVa0XNNWcr2wwumpyrVmmYu16qriOExpQolMd493IjeNpj0zK6PMfc+R7yZlGE5PQXOMEfUNRfcj40Byw9Z7gXZPvkSvXBqyd77AYzJWBTwngWCkr72OexzYjhwrpMAeNkJ70INAnjFyLQZFJK8vh86VklUaSPZgLU1Vnxgfu4FXTHlb5oWek0OvLYuIJ66ZuECgkEz+H1PkFwX8yu+W4Jn/XQERIDhPHn0t9OzpWxvjSn2MfmV9gwaCVxKRClD9go9cVRjchO3LYY6y7CiM2rSD12RHaZfh959SYE0RTRboyXoD67xrfUgp6WB2RVbHVw5Y7IEswp003TKwDCWJ5bcgoYP65bLwjOzUw3Hd/ZRQsRorJXK7ZcxooW0YbDVCc9x41HAtPoH/emhoGNQsYMMGGG8nzUd75KvmN46H/Ch9NdRZqyo7foOZMHD5pz2OicxfycvU2R3GdK/ggPj8w5Ctb4Bf2RBM+Wd9t3LMIEf9J6fJRpsNpIeBmZFFG4cyjFh5AsKWLe6lt4Z1+BGFsVRGcLehIlVTnJhQBMvBZSJiPb0PrE+H42XDcWbN4FPEsHRVfG9UZe8Xjeg3CGx0UDDIsrk9QZdkbPE92gJHiQyeCdZtZ4tACpg5mf9dDdncUGciJPeq4jxtI+LL78+t9TutpYgtw=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 98yCPjjAqQnL0/7n1y7bg+SQabOHz7W10BhGAoLd3xAv+hDkeWMe0/9Ttdf1OFlGTYDkCO9ulftu6PamSKQ4Tkb3aTCVF0gGxuOHHMxmuglydDw4dHAZpJvFu97T1B5nnuPfnTkTjzg/gJsh6xxeEOK4B6G8VC2Y9c47Iem+bgQPPxC3L61ZenZXQ6fbPyff3QoYtLmvfZINZpB3nVUQIXtjavvpC9CWJ04kabD51DHI7H1RsPNJYCe2RSOp06rvQSF6QLMPI6DPvsDp+a4KXTppFesR/CngTz7kN5GfiojWHbudgZe+V4nLZD099YVmUPXbS0bgiOLIcboMhU04UYgsi+pDvBqHok1VY+zOrHDk2yDP5xgx8RiSoPXfNxe0Ztm2lVaNWhL4I1LZQNXRWynSgD6sByPJ/kK63HM+f0+yvIEExG2TUoVoY9AbWlST
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:17:42.3200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cceee976-0086-4fca-501e-08deb5b163fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFF584262A5
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

This patch series introduces splashscreen support for
AM62x platforms by adding configuration fragments and implementing
selective splashscreen enablement across different boot configurations.

The series adds two configuration fragments: am62x_a53_splashscreen.config
and am62x_evm_prune_splashscreen.config. These fragments allow platforms
to selectively enable or disable splashscreen functionality based on
their specific requirements. The prune fragment is particularly useful
for platforms like AM62P where splashscreen must be disabled when using
TI-DM firmware with display sharing features.

The series enables splashscreen on AM62X.

Note:
-----
A patch was posted earlier to enable splashscreen functionality[1].
It breaks ethernet-boot builds because of size constraints, and
splashscreen functionality is not required with ethernet-boot as of now.
This series addresses the issue.

[1]: https://lore.kernel.org/all/20251106085842.629521-1-s-jain1@ti.com/
---
Devarsh Thakkar (2):
  configs: am62x: Add splashscreen config fragment
  configs: am62x: Add splashscreen prune config fragment

Swamil Jain (2):
  configs: am62x_evm_a53_ethboot_defconfig: Disable splashscreen
  configs: am62x_evm_a53_defconfig: Enable A53 splashscreen at u-boot
    SPL

 configs/am62x_a53_splashscreen.config       | 16 ++++++++++++++++
 configs/am62x_evm_a53_defconfig             |  3 ++-
 configs/am62x_evm_a53_ethboot_defconfig     |  1 +
 configs/am62x_evm_prune_splashscreen.config | 16 ++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 configs/am62x_a53_splashscreen.config
 create mode 100644 configs/am62x_evm_prune_splashscreen.config

