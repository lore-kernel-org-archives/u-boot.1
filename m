Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA178C25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 04:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F477881CE;
	Wed, 15 May 2024 06:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.b="vev0TxI9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564D0881D6; Wed, 15 May 2024 06:05:50 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15699880B5
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 06:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=wiwynn.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Delphine_CC_Chiu@wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCGFn1tDQsmLIEpWjIg6GH+tSXY/UgzWTaloM9ndJ0pmeEOJ4/XqTAh/6iKZWYH9dR4Mw92qhoCN3tl76UlKj1O+9edkvjBZ4yjkbe/mkrdX6AgDX9tQMICSb9oKq3/tj2AJdIZHDV3B+cML5dbEwrQwMBr6BJ2vFZTNOcNP9elCM+PsmlkLBa3uCfXVOUaRietQxvEcKyGzOQx4gEoySgBoKUObDdu97D4QtzfU100nFM7iU+Z2iqTgkm+F6ZUVGojwzSw7ySr+jH+eRq6iekivh67/B96bQlidi4ZsdJnNi41RuSYFqRQdmyv43UPq+/Aj7olpLsTBrewe2Y4LLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfHqK9iIRJOdfa+IvhDZ0Omxndz09hRo3595QGW9gMw=;
 b=gwuJJblMusQNKQpv+817kYCOO3wHEw0kkG1JQu0ODzvr9mZmkPA9uKuRTMWczos4etZUwrQHmjtxmCxxhpim35GtzQodBbgV/zrjILDQ1Za04gPxY04mT9qJG2PpM5K8E3pVCRNVWBXZKmkBqaaMZrcnjuTnPf2Q2Cac/DkuLvsV8SAHCrNn7J6rsmO4Hu1ivXgp+KWB2bMsttlMvo9NdtXqR86IROQbo2Hb68cioXWsjM9MrLuvHX7TvM1JHJSD/wi6BnlJyjazSgKWGdv2TnUp6l+N7KoFI19IQOHRZtLfvNkR/BwlA48fGlcfbrGRMKXpwrsvwWrbE+y+tEbLNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfHqK9iIRJOdfa+IvhDZ0Omxndz09hRo3595QGW9gMw=;
 b=vev0TxI9zqO3vU8WTArIYJYe52IRC5V0mmIfKRJeKkacB+hFNRGQE3o1T5m9PR7ZqaT0NQ1o6w4cs4tcc8Vhz2PaOwD2bjUmVOi304XKkjuDxHqZawpM14q1+HbgPOQ9NXUe7ba2EFQ1r0O3RiXJwynspUNdtlRVXWJaDuEoKZYn1/jEQFF0e+TJcEDK6Pz6VSOUaw1OthkBuI+OHIfC0WulVEJgLgNR9jxFdpz2v9pZgYO9MbR2jRvWUs9SqLmWj04n1mm5Oicxy+VZWwJZ5K+9JlXXyl++ydCZuWiiikyPhcxxFhgXeG4f7gEglcJnaQHBbEoE3OrdRYqjXRwvhg==
Received: from SG2PR02CA0119.apcprd02.prod.outlook.com (2603:1096:4:92::35) by
 TYZPR04MB8272.apcprd04.prod.outlook.com (2603:1096:405:df::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Wed, 15 May 2024 04:05:35 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:4:92:cafe::36) by SG2PR02CA0119.outlook.office365.com
 (2603:1096:4:92::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Wed, 15 May 2024 04:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server id 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 04:05:34
 +0000
From: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 u-boot@lists.denx.de
Subject: [PATCH v1 0/2] mem_test: Support to save mtest result in environment
Date: Wed, 15 May 2024 12:05:23 +0800
Message-Id: <20240515040526.178161-1-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|TYZPR04MB8272:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a1452da0-540b-4cd3-3928-08dc7494454d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HSL9k/zSH8E+I1tlDh4k7vQUxabSsS3WuD1Yrb0M+8Y6OQgBaxQml2oCNCUq?=
 =?us-ascii?Q?c1LTYoobm+kGsen4tR2utXBH1hscntd6DY0PuRXkWnVAh/5T9WVzZBiIqhth?=
 =?us-ascii?Q?LsBPxIB2NleMI3SraPZtnauTQ069IMX/slS88LpYm0OnvGoDFSOkG+IZDSZA?=
 =?us-ascii?Q?HA44J+jixW9IN8/kXkWzzvx6H4U8IzFxgVxY0iUu0LHPjQA5qYTZD86y6pWk?=
 =?us-ascii?Q?G9pNpoY3YaA5y5eqfngxGzS/y0OhvH1yzo/cjaJYFb9PhRbLmEUZDHjZb7FI?=
 =?us-ascii?Q?Y9cGfGP+f+u3G7vEqF/IpqZ3FUnUG1svkaZ8+zT5DLtODncTRw9LbVteM0RZ?=
 =?us-ascii?Q?gpDMJ+wY0FEStKuza9RTntjNSjkvoZWDfxEq+1iuWE11TFlTBgZrL+ydnPBg?=
 =?us-ascii?Q?osfSHvtcj7mvSy6EttBz6ZmLLz5uL4t485lY9rWaiYFeHgvp4j5ZiuxiVVeL?=
 =?us-ascii?Q?AiZPZsikCnP4VSs1crDwhuvP0AtfJbNP+Y735Z/uxJBtrYMPziZBtTWckn48?=
 =?us-ascii?Q?ra0NkWzDb09Y0X+C8fpemoX8gncVoN3+QcPBECtyJSY7SbUkk/WT8exsUHeD?=
 =?us-ascii?Q?dM2slHHS820vp1tp7z39kKsLn95GkMdKDqUqWeylQJ8bL7pfBEFYgIjFFfMI?=
 =?us-ascii?Q?GQWwI9ughP8+7ELmMxH1oN2/bCdH9kSnj1dTflE4l19eBxAs3G9z3iWfqCHB?=
 =?us-ascii?Q?4qMpuNFutsSrgY+8PHNPykFbtd9m6bC9Y+T+YZxNxchrhlaTn7a+8UcJyFYr?=
 =?us-ascii?Q?G7aEzCxP4DKsEE9u2J3W1ZQ0obYjsYox+db0rEtUkK1ly9o1iGSn50w6opoJ?=
 =?us-ascii?Q?SsxL2pVJztA7Q+VUAyeVDoyUn4xJFc8DrvIStK6tD3TXiPhVsdpX0JZj6tYY?=
 =?us-ascii?Q?8qvED798b1WdY+WjirDbRR739BqOqkOsEKGE5HUhtnXEmwyjokh1q9fK4+xw?=
 =?us-ascii?Q?83RxPBhpnR8NRf/1tEqwt6/bK/jwrSeC4YvR2ekq5CZTATDpyXNNTE+9NJA+?=
 =?us-ascii?Q?QPn/7t1GzXuKQUV0YpEm+eZGmvECwHBzqTe+/OP/eVPGuNdf4SXnBcutbrsw?=
 =?us-ascii?Q?SpdV+/yC771I5solytR4ozIEMg04/QFqpKXONVELXpB2P1PVD8s5ceXQrb6a?=
 =?us-ascii?Q?AmOB2ksDLwP7gxs4ITEFXawxFKcj2XpUso9+cgyITll2jjTXr0vj43temB03?=
 =?us-ascii?Q?HrtY5b5tsP/euwOph3BliheuD0actdZwjeh0RQCae4jltAaulLKS7Yjcd/eC?=
 =?us-ascii?Q?K3+pmwBtt9Wg6xo8nkzoMplmCiPEqe4T9H6AGS87BAKgJCjB0hYdtWWX+WRS?=
 =?us-ascii?Q?EglV4LBAmUoZR8/UC/VrA9ANLyODFoTMKHLeT6rCnf+9mmhjoE2gA4WX/e50?=
 =?us-ascii?Q?xtSTWPc=3D?=
X-Forefront-Antispam-Report: CIP:211.20.1.79; CTRY:TW; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:211-20-1-79.hinet-ip.hinet.net;
 CAT:NONE; SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 04:05:34.5188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1452da0-540b-4cd3-3928-08dc7494454d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167; Ip=[211.20.1.79];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8272
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

1. Set mtest_result in environment after doing mtest in u-boot so that user can check the result in user space.
2. Revise CONFIG_ENV_SIZE and Add CONFIG_USE_PREBOOT

DelphineCCChiu (2):
  mem_test: Support to save mtest result in environment
  configs: openbmc: Revise size of environment and use preboot

 cmd/mem.c                             | 8 ++++++++
 configs/ast2600_openbmc_spl_defconfig | 5 +++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.25.1

