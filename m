Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B83C4450D
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C498341A;
	Wed, 21 Jan 2026 13:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tORAzLyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D880C8341A; Wed, 21 Jan 2026 06:47:52 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8160482A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz8CcZj0NIQ0pkGJ7xYw1KbQjKmT6h78nALevOvtS33JmvEXw7sA8RliGYUWkFSAiUP23vE5HhT9El9ZCCls6TXzmtl4v3Epl7+htkxpEHnUNiQoJbOZFjZ63GwLReLTtMoBcUfPAUlIW0wWEgPmG+KdNtB7bBv7LkFGEtyoBERqtYCJMVDyHotTv2M75STjCDQjX1GOTBOXPW7vjamHDOfnIJTmlMpPef0NxEDc7yIJZ/B3XaCKz7CVw0r+RNHYHUPRjNkQ9HjVqBXAJX+hI/nSsmO+2nNmhgmZwhSfs38xqd7qD6SvTaIQD882kIPPxH71z1ZPVoHxF6Shq/mmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIJEhV/SO6C2IVseJhdy7QWuvzqZnHxfiKIoGeKrZuA=;
 b=COQkmvtb3luuTXhicXN8OLTBA9WHyoDEEu7CqdJRPaeZCYsXwgAmtMzuJ62+LS+Zb1graJDZsBLT93cAE9qgx4VexGaaiGHNwNtjsH/lH/QS2FN3TqP8G71/YHWNRTjcj/NlvOlToEVaB1bj7Ad5xL0K32sZxhWNtKonmOacpybsz2+1NFqoKWT/oS7aHAhtrBItvXcK97ThUUmcmvNPrfO8jhVbWqunJCX7a7O2oSvoCpriN+7zLAz52sAXVeAP2FAoV//+4jRFpu96a/Iq11mshdirIgxGVS/SeQyLzqN+2Y/NpoOvscaQbfNdgAEymAdweMR99g6wDvMjMohiAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIJEhV/SO6C2IVseJhdy7QWuvzqZnHxfiKIoGeKrZuA=;
 b=tORAzLyOrlS07QVYZCtYJjJi8dOmmC9RhhMOsAtuaAJlMpqeQZVQs/TsCJyOMlbG0r5d01EJs+9TPtkdsre8UTOxJ12B3rJeJLgoTD2yJqUZWfvom4nqOMEF+gADyDlW4vknVW/wc6psxTZD9TWVMWAkkWhpgbRxLwP/aiKXaDo=
Received: from CH2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:610:4d::31)
 by DS4PPFB033C1B5C.namprd10.prod.outlook.com (2603:10b6:f:fc00::d42)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:47:47 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::1a) by CH2PR19CA0021.outlook.office365.com
 (2603:10b6:610:4d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 05:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:47:47 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:46 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:47:46 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5ljnF2472678;
 Tue, 20 Jan 2026 23:47:46 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH v2 1/5] arm: dts: k3-binman: Use configs for ATF/OPTEE
 addresses
Date: Wed, 21 Jan 2026 11:17:08 +0530
Message-ID: <20260121054712.176939-2-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121054712.176939-1-s-joshi@ti.com>
References: <20260121054712.176939-1-s-joshi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS4PPFB033C1B5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfc9387-f1ae-4983-c654-08de58b09b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?omgQXLnBBzOq5gHRXD0lelWMQJyjRaBTH18KrRm4Ca2JaSEtEjp6t4uKvXCI?=
 =?us-ascii?Q?S1FvJt+Yf4Lm0TrjKEEmx6iddzyObXm6jWzk8EkWF/RpCCNLR/9uMYqQERk9?=
 =?us-ascii?Q?h1nv1KZv579eGBaEVn5A374TSy9VrEBQIfARZN89ycrvy+a0gJCWKX+mYb1o?=
 =?us-ascii?Q?rc59SvqOun8r/8JZ4AlZACkkVwJhq7eq5deTFxMlW9C92UAczJwucySepf3D?=
 =?us-ascii?Q?ds2QiJqslTscx+SkQux6pJGeYsCWORweaOE3VDHwAihAhyGtKlcSadaen4Ix?=
 =?us-ascii?Q?vb7Ae2AHXGrbLPf0V25E+8diLkKYfGk2VRGeW8Gy6GyNep6lUGn1Ntrlt0GO?=
 =?us-ascii?Q?0xOHGpwEQWx2SW9WatMi6iRC8g9WZcSvoBNE8HldSgKAerz0/e3B5sXcVVBP?=
 =?us-ascii?Q?qX8zqfhud6T2Sl7Ih0AqFcadyrKXrPFiF5QDpJoDGD6Lrhhnv7FO00qwb/26?=
 =?us-ascii?Q?2CXIPcu8qtajct6ZRF75oLPbWVRQGaVFoWM7RWxnAGMqgDoYjm81D1d1YjTw?=
 =?us-ascii?Q?EQwlxDDkKZT4pBDSd0RAI4T8TlISFPrqsLCFnUDVwHeOlvuBzx5hPMyMtZR4?=
 =?us-ascii?Q?MC5CKWJ9dBld7gCe0cdnFT9miFJPhYkanBv2Q3ZiqbtaYCHwmDCSPdF70Is6?=
 =?us-ascii?Q?CwFmKAWIW964g7jhownaO7pZSwezlcCMThJtSY9vYYa30LcXkqaWl2+ibS0J?=
 =?us-ascii?Q?vZ7trkxv22Lj6SaOXB/gfPx4oIfZFQmvKVvNIqvoMMqx6MAms5HyyEuI4L7l?=
 =?us-ascii?Q?L0p3IUFDRpCwd6Z+1UfHY3LVuk6g0QkL+1TKNjcjNHSQWCmEoa3JllaV9got?=
 =?us-ascii?Q?F15WqIUcMcpj8QapLr3QzH2nTKbjl37/AiDy7KKXdetw8g9UIHHQXJCnt4s+?=
 =?us-ascii?Q?M+5e4p/E8uZfDBXJDYwtgUOs91wDwEKblnvqqpWfQnjyldhXDk9HOJ/XbtR/?=
 =?us-ascii?Q?w32kGdDHrzmH3oymu3tbO5+nzUbx5u2s5CR+h0jqDvE5c1DiJavHNqSK5tZE?=
 =?us-ascii?Q?zxw1kMdRM55A1inNQieJkGJMQOaBqMXRYRhMJy0rsMyT531KKSA33xnOrJZw?=
 =?us-ascii?Q?KHBQqiSfW00o2x6cFMmI6JBzbzmEWk8Lldi8RgPH1fven4wvOb9JJP3dswZD?=
 =?us-ascii?Q?/yKiCltUAEFlwz2SA+EmDna8OZFMd0H+NgMDzxU7FRhH3D3lgtt07YTtioby?=
 =?us-ascii?Q?H9hHHnUaylitlBA748G99ndH7B8hy5MjG62tk+mFa7/MGciLotJYv5ZXpCkZ?=
 =?us-ascii?Q?LiR7ISyexVom8eGlxGGmWFi7iKDwvZnZvJgTcZGhzI1/chlvFyTEHxi5x/Uw?=
 =?us-ascii?Q?urcdMrL4z35ZjG+oZbqbp1AX7SJ165ppy0nXnydCLyCrDqc/4BraZJE35wxy?=
 =?us-ascii?Q?UNb9kNY0C+aMgzHVTlUMNveWlFAiFCuqJhq/4B9kjKiI5Rt8OkSX5sgYxaE1?=
 =?us-ascii?Q?TKDh8D9z4LG/JiJmAkTUQyDApXrX1QEdNvaiZsIXi/u7/5HpxVNKrYJAxnas?=
 =?us-ascii?Q?2B14syOk2wqqqipfw/+ndbe87BI7Ppm2uaqvygJPwoQ+dvsgogq4fggu64dp?=
 =?us-ascii?Q?0q3uhJ3BoUMItr7QHrLTgnYaC4Ui1pzyX9iN5oJk+9iolK2E9qV5Nr9cmEYF?=
 =?us-ascii?Q?3q8GEj0voBNmUu5t7B19BNT0PM8WrW3jlTfP27eZaDIQRXtPa6WdWGzxKePS?=
 =?us-ascii?Q?odW6zA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:47:47.2450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfc9387-f1ae-4983-c654-08de58b09b21
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFB033C1B5C
X-Mailman-Approved-At: Wed, 21 Jan 2026 13:15:54 +0100
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

Instead of hard-coding ATF and OPTEE addresses in firewall configuration
templates, use K3_*_LOAD_ADDR. Doing so ensures that if someone moves
ATF/OPTEE regions, the change gets picked up by binman without
explicitly having to modify dts files.

Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
---
 arch/arm/dts/k3-binman.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index 761b1730464..0fd93f9536a 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -476,8 +476,8 @@
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
-		start_address = <0x0 0x70000000>;
-		end_address = <0x0 0x7001ffff>;
+		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
+		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
 	};
 	firewall_armv8_optee_fg: template-8 {
 		control = <(FWCTRL_EN | FWCTRL_LOCK |
@@ -485,8 +485,8 @@
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
 						FWPERM_SECURE_USER_RWCD)>;
-		start_address = <0x0 0x9e800000>;
-		end_address = <0x0 0x9fffffff>;
+		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
+		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
 	};
 
 	ti_falcon_template: template-9 {
-- 
2.34.1

