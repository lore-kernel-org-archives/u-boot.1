Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2251FD3B7CA
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87C0489A07;
	Mon, 25 Nov 2024 01:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65E72895A0; Mon, 25 Nov 2024 01:33:44 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20705.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::705])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BBF6895AC
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:33:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik2/YlcIlsPV+8Tt5E4GzEgKx/yCxdKETP933KzoogQqxayjg/d1Jq5iTyOUW8Sqlz9TwFkbJOhoni0NrwFhiaCpz/DIOKR4r/NrVpZt7v6RieIvkxWT7vzr4yqIl45kXJaiYtaegtLErmAfAR7s52+qPAFLLcOK1kl0muH4SvlT1GXT/7VegB/FYjH0UykPmvhR88eEy1p8Co3K18tdhQh99pOPNLIKjlBbWtL3s+KHDMGR/jEzpQBTOpJ2LHdCA4IOl8lmxMtV0qdm3I/JLsp9WBuKli4nRFNmshhJS4lroNfn1X/b+69RXF6z5o9wvrhBzvWb3vd2ErEGkN66ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66/qO0jQCPI8WcHAawq1e40cYnYPcnCdT1PGg7llfuw=;
 b=OiytfXgcoXkknlTF9l3lKC6NHKCe6C6266KBplGz/+n2OpXwA0JFznfan3mwbKL0SlnbIdbpSte5qSBuK/QcJZvzFcP/UCLA3jmtfymsgLbaYdZ7ggu+HCesg4GQHoaqI0zAI8tRFKW8AKmWxGuMKHExBkYNVCNtXuepTZdsH/zsgF6wWhFT3s5fx8FIn7xmO6tJhqbCNShglaj0m/Wq88nlV1gIZWqHMj59L5POYQXoemcCsii42mokH1yHqKanSc/C6r0Y5GWRK33YTq82UufubJX/VOZwVry5jrcZkhB16rxfWaYoHq58P3v9vUKakAuhqhf2eVm6zjy7phoZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1244.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 00:34:03 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 00:34:03 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v6 11/11] riscv: cpu: jh7110: Sort the list of imply statements
Date: Mon, 25 Nov 2024 08:32:05 +0800
Message-ID: <20241125003205.75327-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241125003205.75327-1-hal.feng@starfivetech.com>
References: <20241125003205.75327-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0033.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::10) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1244:EE_
X-MS-Office365-Filtering-Correlation-Id: f54edd5a-9ec6-4ad3-4950-08dd0ce8dcad
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|41320700013|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info: yBKLPVRsYur0u02qo7qkAzsYhV1jVkGw6oh3OYRc6+/3aqOeWIJsZ+SUHqLDCFSd7/2plz66IJtaDInCP5YDd3W/Brb4tkQ22q3PewJNuIRnUcPjzAJrQYaXeTxFMqi5HNcPnP0SSfvpdHvbeuPWatLpHGyXM84Kbn7cQwqsYSKn6iI1OatqKB0+Cm8Elkx7V+oMbF2m+ZKEiP8IIfBHYjo7jGRQKyt9cZZfMw/v9v8+NlQ9UCnbyou/zugyOWxEakFFLaujaCPBBkj2EiytYhxJHDSZnTepe3WRPj/IBZrrCh9B4hT7+XbkUYlaze1x4Rlu1WUmQ1xaqhf6dIxAj5A7k6FWcoDFtAyhXtTH67mCNF7HomMwbeFjsMLM5BZeH0nJS6Tmf6/FmJN0V/e/Zyiq6ay8kaQVcIYopzjOzYqSQZbweGp/rkaiX7uvN+pOdor5XyBA5yW/1fmDNYBxCmJTiPgKluQWMS12yf9ngrsJwkrIGDYy0y2ISaEWklmlML67eX3N/ngJSW3RlYLI37xO2ZJG4C1sYjUA8Upa5wCtocL0MxNMxTh6RX/8ViXHbTlGqW4r2JEPwRZGzfk0SpHBH+eg8ELbOR7P1gAqaJsdUYiWsXyP0kCFcIgF3oJgHE8YVXh0UtoarH/RJIWbww==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(41320700013)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dOnetZLHuZJlZoejCFqtnXYmhwS3+JfoDBreT+4T226T4hGulAzkqNnolGS4?=
 =?us-ascii?Q?9pGhEl1i16KMDi6kLJA8YCCrrieUlK2iKfuY3WccYxpSRFkokYbuEDqxoaKO?=
 =?us-ascii?Q?Ah466vTnC2hiS3OYBg5AGgbPdnawCWs6E7sWpaTnJ4zAq1A7rR522z0huVG2?=
 =?us-ascii?Q?P6Q892qhT4jI/qjTx5PVgitmqZVBmcLvzSd5CmhcniFv1z0yLANoL2HjdObk?=
 =?us-ascii?Q?w1gcmYzDhmEyPLNFvRYfEDb3Y0yqsh77fUy3nnVieVNvhG0qyT7cU6iA5vEj?=
 =?us-ascii?Q?3kDoYUXZEIHuXsRd4ZyaqctNgvTVcgSDQtjMCRdyYbFRNf92XjfqD8nCTOPF?=
 =?us-ascii?Q?nz31ZTHNfcoqVC/p8Qkb2z71XzCnOJB/RAhZ/PeS5fMSuYPY6ohH8nMaVuUW?=
 =?us-ascii?Q?pnPkQHba/SG5u0EloPh1Fg4mgs4dwjvEmenXf68YC8nEr8W2pXqt+BR41PWd?=
 =?us-ascii?Q?tvo5TtsIIX0vsMha+9ETuplkECref/rm8Jo4qtsVheWkVJdCO26gjYjCrX9L?=
 =?us-ascii?Q?3YvyuLG7n0SH51bbGxu4WpupLKfTq0jNj8RGCN7Rp7KW0fO4DOMoy0f13MQ2?=
 =?us-ascii?Q?PUy+j8ZJyPNEaCbES+N8cLV4k/7LvqmB/zqlWjEklC8eu204yrQoGONaBx0w?=
 =?us-ascii?Q?FnTfOt7VlkShqoehnFP5Q2hhBuBOshoiQG38Qx0abDgde1iIbmXdHaPW2N8j?=
 =?us-ascii?Q?89ZtuAFAjWG30PLLaYmNB3cjNQ6ejzSWzNJvwTZNEJZRh197YreKOKmIf8Cu?=
 =?us-ascii?Q?Invz7deh50Lt+1/4sVf6tXc3DCOMSGIDKP4UPr+7zaC/nLUd0KEPjQO8adKS?=
 =?us-ascii?Q?DImWG1bGHtk6kiwmCdJyXyg7JXnOlCIdi26DFbu+tcuxq3wEMLckrzNS8uhW?=
 =?us-ascii?Q?fTkVM1hzO6BjVkAECy6WgiSsol/S4ke0v0/usbYIAoxjJv8ARtwrYCJp/Sf1?=
 =?us-ascii?Q?plGyxXvpeTAGgZN6z7YS1QLH0C/9nN6y9WVjOn0NkE9iPqSKxyLkXqZplLuY?=
 =?us-ascii?Q?PhHNS7z3rSN3d8qQPIcsvgbr3zbcPt0D52ErBbbg/4W2Pkoh/zGXegWWIZhD?=
 =?us-ascii?Q?7x3yS19qowxsq7nBrgAl9PHDxmqAosZDFC33AdZRrgHEgUKeYhcBQ0pRFdxf?=
 =?us-ascii?Q?PXyCOHwny6CcCAvRWURtGbomajFooDOaVgYuEPy7b3huqd1B+zcGoNIlNBaU?=
 =?us-ascii?Q?J2jdi2rOBbZ6QIwmFtChKeVpj+6SHXAm5E2C5HQAesIpmYd4w3suj63nSmI2?=
 =?us-ascii?Q?WQr2AzRZiWKeEJG/fOwiYPq5lhI8haUkrsVb7BQPVA7yqz0Dw4n+m6EEhcYz?=
 =?us-ascii?Q?x+wtBTp1+6Zz5O5fOR+cibQUhrO6dShQ4UNi+lUiwnzew6R+c0tz6BaBzLE7?=
 =?us-ascii?Q?CAsz0DWZPdFI8lYYgNAmYXEcLRgzQxY15VIV3f1WQUKC6XHpayvQjM4ShhNP?=
 =?us-ascii?Q?qp3FalNWHdGjFITEem9oon0ZuI1JdYn7dFDO3kEjynx8yufqif8s1vQMW3/U?=
 =?us-ascii?Q?fEf7sHw+x1/DW8LE1gKbQoLBGqNdATh96SGc/R0QftnHIDP+eEKKU3Bo9u8V?=
 =?us-ascii?Q?2LHU8L8XXYttBdOYWk/Ps4O+7S5ID3YqJNGjOISIqhOMMYRp3vJkVhdtJ8P+?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54edd5a-9ec6-4ad3-4950-08dd0ce8dcad
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 00:34:03.2113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HUTouDsyW79Zh6ii0c8toz1ajK2J9v/9y+baVV6Utg7ZARquEPEXsceel7YtC2kNYhFKIPxVEhha1UE8cPBqsMSr27bHQNRmqyTiVbsnttQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1244
X-Mailman-Approved-At: Mon, 25 Nov 2024 01:40:37 +0100
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

The imply statements should be sorted in the sequence
of appearance in .config.

Tested-by: E Shattow <lucent@gmail.com>
Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/cpu/jh7110/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/cpu/jh7110/Kconfig b/arch/riscv/cpu/jh7110/Kconfig
index 9904a60ddd..fa47e55226 100644
--- a/arch/riscv/cpu/jh7110/Kconfig
+++ b/arch/riscv/cpu/jh7110/Kconfig
@@ -16,17 +16,17 @@ config STARFIVE_JH7110
 	select SYS_CACHE_SHIFT_6
 	select SPL_ZERO_MEM_BEFORE_USE
 	select PINCTRL_STARFIVE_JH7110
+	imply SMP
+	imply SPL_RISCV_ACLINT
+	imply SIFIVE_CACHE
+	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply SPL_LOAD_FIT
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply OF_UPSTREAM
+	imply SIFIVE_CCACHE
 	imply MMC
 	imply MMC_BROKEN_CD
 	imply MMC_SPI
-	imply OF_UPSTREAM
-	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-	imply SIFIVE_CACHE
-	imply SIFIVE_CCACHE
-	imply SMP
 	imply SPI
-	imply SPL_CPU
-	imply SPL_LOAD_FIT
-	imply SPL_OPENSBI
-	imply SPL_RISCV_ACLINT
-	imply SPL_SYS_MALLOC_CLEAR_ON_INIT
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
-- 
2.43.2

