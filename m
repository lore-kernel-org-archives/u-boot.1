Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EF9C44522
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 12:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2DE083A83;
	Wed, 21 Jan 2026 13:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GPO2sh+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0883882A9E; Wed, 21 Jan 2026 06:48:10 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5AEC83015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 06:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIIiIoDyCwp1PBAaV7EoPpnIESt3m76OTK48eqBlMSCFAu7kRKolREIThNKCk6CAJj53Z/jGMcBhCgJF2epqGiseOKws+oW5LoLKk5AQMfXj9JUx/sEpg7x5trG40a7coZ4ikJHIW73vvsZWVOAxpuTYAlZod1nnoVLcsqU6pFyX6hbj64b/kF7TpTNuTKZ5P5vceomOhxebYo8lA90koJY1VIezQ0KT0bfm+gAo2EmZxwv39mhS7Kk5zCajNe2DKYhqRIwfqeFe9atHYT9HOxzgLVQjEF8EZnYc1pmqOWcE0yYTr87l+s11wgZPCEu4+mwbnRneyg0W9ltgSYvttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcJWvixI15G0zamgTg6VIxn3yYxdcmbxxpOY81YO5hk=;
 b=AOKeH4Tt2Gafluvv4DbxSyp5yzkXwPclLlvTZEi+J4r73SsMYcyW52oOCzX+0aroetvDwuZ+Kbq8kfgLTvaaTijjMtoBXEWRLyfezrw1++b6hbbYmjdnbYnleOhmqdWyO0rr01EXbElLfLx6lxse7t70odialQ9RRdaPpcBBeCezdTfgo1UHM6yLcXEVNjpnSls4OcyO3sdy3FsvE/Y3UgobWq+nEihCKg8jMwzMNdMV0t7zWxJUWC6RcSJ26A0r/cwXuzknXj2IzzdUeMkAdb7VhSF03Vz8CbNvdInsWNHHsdrt8gxD2tzQtYyRFOK7+HRFa9ZB9VIDZwwBy4l4ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcJWvixI15G0zamgTg6VIxn3yYxdcmbxxpOY81YO5hk=;
 b=GPO2sh+WRnxSkggGfXdB5GGmzpq34xEeS9tpNWWRAsBnVhq6LjxTOZGmCcRQfjuGLdiiUif01+MjAPi0k+7aSd0U+AaNY8AQshpFh4wN+zkjGHnCfDmaRXZud3OZmO8B8T48kDXXV0XoB2HrxSp6ck6ZZdXVcbAzOVYelxcHuD4=
Received: from BL6PEPF0001640E.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:15) by SA1PR10MB997763.namprd10.prod.outlook.com
 (2603:10b6:806:4bf::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 05:47:59 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2a01:111:f403:f903::3) by BL6PEPF0001640E.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Wed,
 21 Jan 2026 05:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 05:47:57 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:36 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 23:47:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 23:47:36 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L5lZpm2472453;
 Tue, 20 Jan 2026 23:47:36 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>
Subject: [PATCH v2 0/5] Firewall ATF and OP-TEE memory regions in Sitara
Date: Wed, 21 Jan 2026 11:17:07 +0530
Message-ID: <20260121054712.176939-1-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SA1PR10MB997763:EE_
X-MS-Office365-Filtering-Correlation-Id: aa4eb997-5aad-4834-94a3-08de58b0a12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+2dsTBjwc4UT26ICSmXMn4n//fPn1FLQcrEK10lDSgFwOKF6JBIwAVBX5+Ef?=
 =?us-ascii?Q?+z0Lbp5N9wWmj7TZDsxoGqyMJC15k6B8X7YguItXDw04ZtRjds/zuDrkX+dq?=
 =?us-ascii?Q?dn3cgGIDh+qHne3W4iHg2ZkCRNOYie6G7n3iWYlOHvlT+aVO83ZttxPXjB8j?=
 =?us-ascii?Q?p+H8ly/7SDfunSJGvojGBs/xso3Mly69Cr/AKYTthIp5cL+88QFx9ozZaGbN?=
 =?us-ascii?Q?eJ68gNs276yUKHBUbSiATlMp+46jeJH5wIntDCx8vlDkcU8azllJB9JNAVLc?=
 =?us-ascii?Q?Jy+NuGLnpgRRYXTbTV2iYC1zb+otr4IAGjc1z2MhqUdBakReqw6YSzkteisa?=
 =?us-ascii?Q?7PdLorrU92TYIELkNf0kNAVxmiqpNmLNVQ47QikNUVIONWGROvYl3kVrOVEA?=
 =?us-ascii?Q?lLVZKk7xr/HZZVBLK8EoAL8iQv8KOOIPwB4v+bGg/JKKnEed7XnS1YILc0E8?=
 =?us-ascii?Q?og/e5lFPGpniNNS6aSewywa7l4ZivtIel988kn6UvK1CPA+SN7RNFt+YQ8Rr?=
 =?us-ascii?Q?FmHBkpgS8p+E4HRrcxnIAYhl5whLq0zwOoXag3/223r4JsK7pP1Z2GU6pGMp?=
 =?us-ascii?Q?QjdUr6IrSVQNv4OGuBJwTTmjvd1h8jwhYiyOJh/n1vBmccErlnizknP9FuVk?=
 =?us-ascii?Q?JB0WsXwu505CRfjiKmLsyM6seXFq7S0KYIiq8poiQFo+tdQh3vNkd8tiOEyw?=
 =?us-ascii?Q?va5voHsmH3wIIX62ew8/sfLqjRSUq7hTGBefDO9uhCnWGac8TQ6AMxJWBjzO?=
 =?us-ascii?Q?Pyi1mPatZoSlE1eTmnw1cAxk3nC6MLe7ZTnKBYteWpTR61q23iQMUXRpLI/b?=
 =?us-ascii?Q?mqCxsJxQYQXoK0FpwPhMswK54nKULXn/+pD/LZkZuNwAh/VBZG5sTDHKm4rJ?=
 =?us-ascii?Q?KN/u9RWOljpAo7JwwluXKvZWZDk6RqCYzefOcMhiVyZeAKxblI9HkGoznKVS?=
 =?us-ascii?Q?2zoYYscpv0L8jtN1iURSlvbjDMrC/BRYlaRicEXKbESj7IsjleVfH0e550jq?=
 =?us-ascii?Q?ZeNgDjZ2EFPTaSgsZ2h+vRzQF6yuMyGJrTP1crIeIWPEK3dxJvz8J7ZSUfzv?=
 =?us-ascii?Q?oFgq8uCzeywlWEBQqfKaf8hsvraBZDB1f7xHbNF0BA2UVoDTKonkLxP+oJa2?=
 =?us-ascii?Q?/MrOsAS3UxuZxmjZPeeAoEmjBaOqi+9SOd3MYTWx6NsPn0V4eYlGMlTRFgf5?=
 =?us-ascii?Q?GXwd5TOqwYcx+HOOkFKs0J4+ShmRLcYBXUWofVXM8BgcjGPRcODekAaJzma7?=
 =?us-ascii?Q?gwSDTwXGbvrvHKH6iScRcJvRjd5PDeuGktfdrFR8SamSX71ZuG1rSUv6emoI?=
 =?us-ascii?Q?NJ/oCf57tzMpCZImiy/bSsD/2s+ed/iWDUezJyv4UewxPj775xtu9Bysk6BF?=
 =?us-ascii?Q?lql4R9PeBihnRx248iqkhpWbMBXBK9Wjruqv2INHFsiCz1xOrB24wZJDZgT/?=
 =?us-ascii?Q?j78WxzAJGU9uKSICMm63erRCB0q44N8BQ7sFScTbQrGGg5pu7Ne7mbdPQJnx?=
 =?us-ascii?Q?iCWy90X+Z/IxyfU7E+R5+YUh8D5mImrNANN3gUlNV4OXKGU3dS5G/YPsHSPO?=
 =?us-ascii?Q?OtbH0dZv93TwJxRiiBt4tMhytPJ00AwpJ+2j7YpEL5HvQjzN+6iQN1bibEh6?=
 =?us-ascii?Q?sLldbt8ESRmH0OYZXUUo0ljkNjutCAhs+Xa8DZ6LoKGQWP88tB1b1OQeOw+M?=
 =?us-ascii?Q?riDr6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 05:47:57.3518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4eb997-5aad-4834-94a3-08de58b0a12c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997763
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

This series starts by replacing the hard-coded addresses in firewall templates that are defined in
k3-binman.dtsi, by Kconfigs. Using Kconfigs would make it easier for someone to move ATF and OP-TEE
to another location, since they wouldn't have to fiddle with the firewall configs in the dtsi files.

The rest of the commits in this series add firewall configs to each device's dtsi file.

To test this, I used `k3conf read|write <atf and optee addresses> <val>`. These operations were
disallowed when the patches of this series were applied, expectedly.

Changes v1 -> v2:
    * Removed some un-required empty lines in accordance with Neha's review.
    * Link to v1: https://lore.kernel.org/u-boot/20260112093643.885903-1-s-joshi@ti.com/

Suhaas Joshi (5):
  arm: dts: k3-binman: Use configs for ATF/OPTEE addresses
  arm: dts: k3-am625-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am62p-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am62a-binman: Configure firewall for ATF/OPTEE
  arm: dts: k3-am64x-binman: Configure firewall for ATF/OPTEE

 arch/arm/dts/k3-am625-sk-binman.dtsi | 29 +++++++++++++++++++++++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi | 30 ++++++++++++++++++++++++++
 arch/arm/dts/k3-am62p-sk-binman.dtsi | 32 ++++++++++++++++++++++++++++
 arch/arm/dts/k3-am64x-binman.dtsi    | 31 +++++++++++++++++++++++++++
 arch/arm/dts/k3-binman.dtsi          |  8 +++----
 5 files changed, 126 insertions(+), 4 deletions(-)

-- 
2.34.1

