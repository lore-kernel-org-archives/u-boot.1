Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14F3E9DE5A
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 07:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 229D1839D5;
	Thu,  9 Apr 2026 09:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Gz0Dttwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0BC483CF5; Thu,  9 Apr 2026 09:27:19 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5534483693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 09:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOczTq+A18JdKfRbw0oLPR9ekP9+9wtBId5piOEmZqCd+GFY3ZP8f5gfPFqSD3HlR+i+LU429bTf8pAx0p7eNp1HnBr0zlV8TyHLAKgulXWZu1ymQ7Nh0f8Q5/b8QrLThFOBcdiKcigLmHc83ihz9XvQsYceOmBG12lD3zkax8PfCPSowSfwYe270gPzNqsE7KBMenFDRvRav9T0GpYFSQQ6dImkuIWi/IupvTe4uGzinovevVDSelX/yIrDJ3AXAGUQjXNuuAOQ1OUUSDgvTVy20jOmdUyFjF7/XGGuNwGo7R5Sm8c/4cOludfHmvtseHqgF1MAK3Hiq/Wg1rEonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBKDOblSwQBtHDGpQMo2VOpRZPKaueLgIPmvRl9gZqE=;
 b=GAxCQWfL8PsZW0rIIiGty9oLr4Q4qEwfEt9U+AH6XVjjdZdIrPnM16CTbi4hI9lmsaI1iG21w+4gCnmRO+zeF2EFVk1qsjknZEu/c6cPFyhuCA4ebglbZ9lwOmveuY3j5d7ZsdrccdYtzHr15rMujk9WZt20fCnYJg4Hixz/v8JS2pfiAWtmsddgMU8+y3SopsxmZYHq8cx1elxeA4uPSZVsN+QYettVohUoyPhCw5OjSJr4/Wgwj1rJ1qtoGKTf90IOcxTFfhYVf+bAcIPlBXpZGeymRJ3558MfYd7Sf87nC6GSdKc+IEhD/o+alxPYvzC7zQcPF9IXFGsswSxnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBKDOblSwQBtHDGpQMo2VOpRZPKaueLgIPmvRl9gZqE=;
 b=Gz0DttwaSj3MC0qLziHAdT9CnWy1D1U+SbXUAylhz7Auy+bRX8WHQLjF/Yu2bKL8byK3iuTH6KcEn8MmOVCr8Gjv4GqwGtfgPKpmwR7F7CxKg3RliCjgfZkVzt6QaioDGFJOuWewtMNbmw40g0I3puCXwiH9k8x+PEUSeWIzW3g=
Received: from SA1P222CA0080.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::17)
 by SJ5PPF5B5767B72.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 9 Apr
 2026 07:27:14 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::bb) by SA1P222CA0080.outlook.office365.com
 (2603:10b6:806:35e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 07:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 07:27:14 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 02:27:13 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 02:27:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 02:27:13 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6397RCEm3368329;
 Thu, 9 Apr 2026 02:27:13 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <s-vadapalli@ti.com>
CC: <jerome.forissier@arm.com>, <srk@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Anshul Dalal <anshuld@ti.com>
Subject: Re: [PATCH] net: phy: dp83867: default to 2ns delay if unspecified in
 device-tree
Date: Thu, 9 Apr 2026 12:57:00 +0530
Message-ID: <20260409072659.509356-2-anshuld@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406124559.2481344-1-s-vadapalli@ti.com>
References: <20260406124559.2481344-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ5PPF5B5767B72:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0d5ad2-ad11-406a-2999-08de96096be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yHGJA/gRycRTwV5mVUBDLvgcWZlYzAz6kAmaaUofTcjZLM04Ym7JcO4RcnUkhKhF6rSpgx+K7AqQAR5WTzWXqKuUI/X+mbBYqadW1aZgbCt3+KKvSN5BEup9RLsNjz962ulx3dJU9BeGbEUmo9+XkRpQJqjYZI6T+p4l0wCltDE4H7/AckWcSRT7N/m7z6kcOjCz8UHmOFB9o0QJOU53orJ9220MJWh7zxlzKXlUb0ibYkTSdlbr4WmBBpdqDrrxXMOB+J+4UtrbZ4AkzSh/mdqPEwBf9AAxbVF9RFy3kXaLRBdIt9TSRLLqj+TI9LWrvtEovfXfN34tGJ38y9iovnhiclqp6BTonUkBkorC1yat258sIMA2uP2GSenWKy27wlU5y98i9Pg523Fc+gXPQM7UqOUB+u3AnCT8x/TZoGOmvsRZGjm1KWd0CaF65eWhLoz/8yLHzTfPmEYI/Cz81ifD39YNw/EMm9GNcTI/dOhbMgoGttcabT1RHa+UhMJE1r5bMf8x71hA89JiQKoq0cjPS/jyPmsoU3RBNpTv6kY0D/KsUU5pzxLUFAsn7nxKPW3mzaNgOlxgTlfaXSs6UKBXqwcNsYBP+a42E97zIx50konuKJFctTCi/owT+gwrulWYACPAAOYjelrTjO7zfxZmgNvpOuTYmdQPXjUMRfsC+1/aH2T6wJPwJK2Jxaapd8Y3Rfh2OvnKVnn5iCDcgYBuwODJrEKU5BAwsAnzthgjczL9r5Eo8P4V/JWOnPnfUqxUaL3PMvT9X4GuMYUUjQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1si7vbuT4h7MC0vWLA+mw/4E6Mf7LmUYkcQ30x2qPzLSHdWXY5Ucn1QIi0/zF18F724rivC3rJhRxBl0WN+6fqch46x3alPiB9aVqXDCsoiShl/UaLMB2kUgdMsK2fklD/LCc0OLDEsibS1Bs1bu1BSK+cBCqJO2zLmhjMlu6vxr7xUPYaZHc5HUc0moPBf4KvO/aqTaTnDa7O8Z2+AzcdzkbbKtnFSBZuwH3Zyx+sTI2kiwKscGQR6vxImueXahvOUTmSpB7RTEJ7q7eCcueSQDvsqFSkxKW1t5mfXZyVhhs90ccsWK17wPqVjeZ+9HDvIY9CH3wYIiC0QBAtZUgdGTDs/779w1xlef/BKNhVGxk0SNgSG+uoQNQ/ZZArXcZnYG3FGFPTRwSFKPpF1cXxAGWYk6nDrTMTGW4FrMkAnIx2RBl3xBJlx3c2e954Jt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:27:14.1358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0d5ad2-ad11-406a-2999-08de96096be3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5B5767B72
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

On Mon, 06 Apr 2026 18:15:57 +0530, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> Since Linux commit c360eb0c3ccb ("dt-bindings: net: ethernet-controller:
> Add informative text about RGMII delays"), the interpretation of RGMII
> delays has changed. Prior to the commit, the RGMII Variant among "rgmii",
> "rgmii-id", "rgmii-rxid" and "rgmii-txid" clearly specified whether it is
> the MAC or the PHY that "should" add the delay. However, post that commit,
> the RGMII Variant only specifies whether or not there is a delay on the
> PCB traces between the MAC and the PHY, leaving it open as to who adds the
> delay.
> 
> Hence, instead of enforcing the existence of the device-tree properties
> "ti,rx-internal-delay" and "ti,tx-internal-delay", default to a delay
> of 2ns, while continuing to override this delay with the aforementioned
> properties, if they exist in the device-tree.
> 
> This is in line with the Linux driver implementation updated by commit
> 6bf78849371d ("net: phy: dp83867: use 2ns delay if not specified in DTB").
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

--
Anshul Dalal <anshuld@ti.com>
