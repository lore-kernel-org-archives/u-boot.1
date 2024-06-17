Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CC8C2BA1A
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 22:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D93628824C;
	Tue, 18 Jun 2024 00:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dR5rcM/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 650A0883C3; Mon, 17 Jun 2024 22:21:07 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3969188398
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 22:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHXbwv6H50XdLTjrwTaEFGmf3s4u+fizPSu2OZ6pioXx/ISMsS407Y40Gwft4zGlxXbl1J2jtN7MZvOhrUvexMQhE/mcrVPGjHD6irU5EQWC6BkBiHsCQKoNRSlKuvuNopIUSrxKGgbB9eZqdhWI68/l6c8aMvNoIePll4iXY3ZR1yzSzlhVS81oCnqxze6ORcGTRuhcRmoTKOV8AERD8RvUoUKHyaVDzFcB9+y2E2DrfXI56ByG/6amcYyjln94KgT/Z1yN7d9s1g4qZJ7ivp2bMXw39kXfYaDCIQjcBs5IGRkbmq2eAh+OfeBW11sx4aG+oi9sQQb0WVgtJwbPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHsBQrvrLzLdw9R9pSPqVJwS4Dj5JgDQR7sjZLQkhKE=;
 b=a4z016Qr6dmnNnOAcxkhg9JveLsserjz1d+cXoDb0gNK1mdiGD1S4BeUHtUg7P6P5y1ny9d1ZNOz8NTQNe18RSow/GS4fTPTT2qql+Q3u7n3wiRLZWuLsqtY01NgUmhE+a+HvyzSwrrMZqmblZuxlbXZOWKjC7crnhb0gkieR3HYThK8yFDzplsdvi9dwTgulZH/rFkSYxB2qJV/cKmAdeWxeFbFERuGLJNFfXFqzfR301pGbhqrRPqwWtlID7ZmkvQHTWY12b+V7TcNrUlJf7Onz6X4/R1puHJW2Wf9kCT4RGMRao+yowBJwtJdlXxESdAmoVdXO8uYnag1tBLMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHsBQrvrLzLdw9R9pSPqVJwS4Dj5JgDQR7sjZLQkhKE=;
 b=dR5rcM/XBvbKzUf2/D47e0uu38/uNhTQhs9i0EW3+lV4+XJUTALK5KKszMdrrvfkTP3XPZSol6hiUqxMAZhHakE6A+iSoC2WKnqzUWbtA3KC5ndYHGDJn86eDcUknLyIsnieGFggxpLNTmqJXB+UlfiqdpTFl2fsE3UKBygMUI4=
Received: from DS7PR03CA0112.namprd03.prod.outlook.com (2603:10b6:5:3b7::27)
 by PH7PR12MB6466.namprd12.prod.outlook.com (2603:10b6:510:1f6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 20:21:00 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::7a) by DS7PR03CA0112.outlook.office365.com
 (2603:10b6:5:3b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 20:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 20:20:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 15:20:59 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 15:20:58 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <xypron.glpk@gmx.de>,
 <u-boot@lists.denx.de>
CC: <sam.povilus@amd.com>, <git@amd.com>
Subject: [RFC 0/1] FIT documentation link vs copy
Date: Mon, 17 Jun 2024 14:20:40 -0600
Message-ID: <20240617202041.3740154-1-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH7PR12MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: baaee926-efb1-4628-55f9-08dc8f0b0100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uOTzoQgvTzOIq82QlACGBNw0WxIdmJfRBYTqRVFHQSUIgezUBdI4xVJ12r80?=
 =?us-ascii?Q?ZPbDk0KdeJrv93O/SfYr3LOao6qUgSAvBOT9rmO+jRlEzP+2SVlyp5UmgoYq?=
 =?us-ascii?Q?KPCrJTFQ13vebxQNImDVOllKg/U3+K730yGnmzQ+xRoJDT3em6nP8QUjT23n?=
 =?us-ascii?Q?81+u5iNJUcYbjD1ThmbX1Br+Fu2yLjZGRMZnTMqaHHuQ83DODPh+tPsUkVMa?=
 =?us-ascii?Q?6OMBsyKx1tKbbdll1hIBVGOLbYjW87+OQATrDH9jEe5da5lgbiMsHH0eR0V8?=
 =?us-ascii?Q?VaZnPHSDjvkwt1XOLnPjsogtPuD+oWWVC8mfH1gF1LZ2ByA6PSiGSRsyk09m?=
 =?us-ascii?Q?QuWE2v/2u3IMEAy6wi/zj/LT+u7ekoOrJ0O+TyckI63S7LUUms2hLsP6A6ZC?=
 =?us-ascii?Q?6fAZ7NVscpQG0TN03RdWELNmF97awIyR+Y5sQIsWs/Fp23BWq0htxB3/c0Bk?=
 =?us-ascii?Q?0KHffjlDenRegvfEo7AXQsN2bw7VkDcaKmaMtzeppqE6QjpwdDU4lFbU0btT?=
 =?us-ascii?Q?0D4nPNhMLEMB6eb2RQCeFk5y9CxiYLn5HzjjbJfObenOpRpxwKgjYTrOl3GY?=
 =?us-ascii?Q?Xp747zxFYHgVdY4CCdDOYi25hiuFJWXD1+TjxXQ6NN0WZQ9Ch5Ursr7+VB4n?=
 =?us-ascii?Q?r+ZaWYYSgkVGjVPHbIRYL7drA3dB+9/51qXKngUl0tc29WzbgMUTxPcrntDr?=
 =?us-ascii?Q?oyaPDytlVjrmB+z2cVRqS5aqat7uG7PikD/h+yDJ7UJxDBpGxgCzzJJWZrxf?=
 =?us-ascii?Q?B904oPVOQ0IUiJS5Xf6u6mvdINjZPGijDiw4hpCmEsJl90pP186lEjk0+Kep?=
 =?us-ascii?Q?5dAYMazR76pBhK+7Ji/yDleS4Kru6cno3K37Dq62y/60KYrXFrDfWCZxKPbH?=
 =?us-ascii?Q?NIfO+V5BOqnDefxc5KPTCkGPk3hV8ZvKfFUi0vkJSnxGD/jqwrtUeaMg+XDp?=
 =?us-ascii?Q?Tc+UjIXmFSgEBopzrZXhRu/XT/UDvp6v8a7wRXgdQdlGMsl8qWcCzF6glzXK?=
 =?us-ascii?Q?GQA+1eG0m5AOIoq6+PJGs2GRA4p+KL0d98AunHu4PB7n+cDu3AoI8I0pqW03?=
 =?us-ascii?Q?r4cklMLXt7IzW3BvcPuTIHjkjlftPHQlhFC7oY0/9PjZ6olNYwSsOv0Y/bCX?=
 =?us-ascii?Q?72uRhDQH24YM61qpZdPfIGiILCEu2h7vh1ZnFVCgicbyTNLDV2dDP4YleeRm?=
 =?us-ascii?Q?J2o7tZ9FchPwzGvayk0OL05IsHteS8M+1jfzfdmA4kXjCO7mTDaAa3+3Ok01?=
 =?us-ascii?Q?sEOv9Yk9xSBK2Zq9bcq2b31AOt77OJWTe9AM0WQjGrFF4r1InwfPC2BJENo5?=
 =?us-ascii?Q?jNfagsQGm7fn9wP8fFqaY/sJC7QUqLry+SxSttcDMf9dFpWGsjJaURAebPC1?=
 =?us-ascii?Q?anIxj2UrRpuIdLQi//Igro6KuAoD2XgaGPdvruSFUx5YZURchw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 20:20:59.8041 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baaee926-efb1-4628-55f9-08dc8f0b0100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6466
X-Mailman-Approved-At: Tue, 18 Jun 2024 00:35:09 +0200
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

I'm proposing linking the FIT documentation instead of double book keeping it, 
it does have the disadvantage of making it more difficult to see the 
documentation especially if offline. 

Sam Povilus (1):
  doc: Remove FIT documentation that is elsewhere

 doc/usage/fit/index.rst              |  14 +-
 doc/usage/fit/source_file_format.rst | 682 +--------------------------
 2 files changed, 5 insertions(+), 691 deletions(-)

-- 
2.34.1

