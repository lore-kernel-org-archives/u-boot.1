Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7272CCD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90FC84119;
	Tue, 16 Jun 2026 14:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b5L2125v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0525584119; Tue, 16 Jun 2026 14:24:30 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA4E84105
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hHJEZwJBbmWCtul7AYDFUFnGYXbI9xcjvgoIJTRECpEOrsXHcAygTf8ZwDEqgRUaHucON71ZpuMggtm6wQJpIeWW6OlHdfKf1HJijIRhxFk7KY0r5xIhvSlSCbnVDeYJFLcVB9fJalEPM7PZIinhkZQphJkDZzHzH2PjWWL9YtXGv+TAF8Iq0Or2z2oKmUCRkIr22yPp/M8Q7YiLjZUs4XhFNqWDSyF2VshcuOlXDH4+Z9Qn7pgpuTHP/MPW0tRDGKyAzpUfybiX6GGPwy9TH/XQac5xLR3MW9vDw9TN7C0G23sFTFBHBFR+ooNwwOxr/0cj5LePysBmAeDka2ao+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXlBayyRGLZxDBAysXp7Csgu/NrjDWGQ9DEAV3pu+Vs=;
 b=vIadFpyDo6KF92+DqxvCkikTkz/xxCr4E07G4Us1RoKgxNBsIu/9L4hbEHY2NhURWT9LLA7O2XXkzTbUbaw6CjRzikYqsD5VO7Xhn05UT7fwznJZTS0VIC6AM0fc3vxUBGOUPidpxC0ZZkZWnJvaP6UWVH32xaJ+IyjUlorth/jdVhuhIKQYQnePRRT3OJWZ8vCV2U1MpbV+h639x6DImiIze6lyVWtuti3cM40TIZVzK0LVcgQa55WRkvh1FjD8WtM8gLb/D8KhWjzQ1eUTV3qrc12dXKlDQa9dPvYjwV96w+1BgfwzVQfsMfnaWU7Ozz8B4QK4yCHx4U0KKqIdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXlBayyRGLZxDBAysXp7Csgu/NrjDWGQ9DEAV3pu+Vs=;
 b=b5L2125vnoTXdRsATHAzL2/5PgxodX8jxHDZXnR9AoJrnv/x59hOe2NxKCQ5JyjtGxdwV0ojQJl8lJjy4HDZOVaSQIh2HXTDfOJGJboukdGAHOma8ADYVuu49jE+EzTarDg65w3+vVKToETExpm86u8NIBUonZotjRj+5HG90ck=
Received: from SJ0PR05CA0180.namprd05.prod.outlook.com (2603:10b6:a03:339::35)
 by DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 12:24:18 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::1e) by SJ0PR05CA0180.outlook.office365.com
 (2603:10b6:a03:339::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 12:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:24:18 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:24:17 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:24:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 16 Jun 2026 07:24:17 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65GCOHp24167107;
 Tue, 16 Jun 2026 07:24:17 -0500
Date: Tue, 16 Jun 2026 07:24:17 -0500
From: Bryan Brattlof <bb@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: Vishal Mahaveer <vishalm@ti.com>, <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>
Subject: Re: [PATCH 1/2] arm: mach-k3: am642: Update MAIN UART1 serial alias
 from 3 to 1
Message-ID: <20260616122417.olghe5g5hksmxoud@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260605193829.395161-1-vishalm@ti.com>
 <20260605193829.395161-2-vishalm@ti.com>
 <b5ff80b6-d40e-42b0-a8a5-99f72e61aaa6@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b5ff80b6-d40e-42b0-a8a5-99f72e61aaa6@phytec.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e09b225-216f-4397-2ebe-08decba22ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|5023799004|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KnOW2BnSxL+rQRRVzMNcZtM6nlNZB/uLctjzGPvSAzk8F4pPxPxYzFsjlTPAdNhcJL4VBIX5xUP7ZijXaNBVh9DgQaYS4lyVA+4lHLb/CfU9rtQXwt6pwLxWHi8iOv4waN3kbrbgjSWD8Dk/Db1bMxDJ78YVXtG1oWS6Wvpfk4JDxLg+Y2EpSuh18abQzYanmyD/eEApu7gTBq4S5jVnuSN/AAJ9yfgt7ahKnXWKdmWaZmJNHlT1wwIUeJHZWuif1QZ6GYStVFez5Z0swBpC0w5xHDGn2a3IfT8aH+nL+uW+4sQxqcWTAG6BJ+DXUVCb5w3tjEsTuXrHFTN1LGo+gLFtIerqAWpzDdmhQFG9bBt1WGDtvB+bTId4uLu2xUgskjWpAB9hvz1YdHSJp6+ESBu2XLZpmyYdVac0iSPJuoSnbTAwie0M/Mm80wNRCy5l4vqITNLq4+IC+YfpBKwkT2LafxuEFAUHwtPrOYECXTtzuqude5PLUlwmdHxMvYdMI2FC15Xc9Efh58P7nt3xYaRGBkhJZ7PIi1BRQMnXvdsOhkwdFxkJNMQDZJ2xr+SObY4YFM/w9hkII5Ay3ea+4U0arWNqqiHS/fJ7Jw4erSevAViWdVdW2GgWqRE5KiheqTZ5qbtvypAl+64d6A3W1JgVhkLHsvv453xBPf0L5jmCAG5W+djZX1hqKK5EovdgCgNTh7fbXaRjR42PHC6yPtdbjBSlU5aZx4rTVPEhaVU=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(5023799004)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZSQuEJsV7FImeXVn1ssosokFUPaL9DWYHAy7TDkxB/mjoUWEKuDbBEMsGVuoy7MV4ZJMD8Ieqs3XcSbqGDZPNYVYYR91j2wbCwF5XTi3bF9jdKJomPTA7bRlqJcrZ6kjBPO56A2+csI4cfvwm5qFfLu2w5y6ycHtZYnlObl3OxD5F7CT2xLZM1jaq4IuPDgjiMsyIi/CzVTTOGARFSG9TM/D6zMyaHqfnATrBYaLN88kpM0QP0k5Cdh7GmIgKlCxz84P4VwbV7xyysyRLxFzRG4By8kAsahR6MGcgBwmlF+Okg3Y5k9O4kyusJHtaQG8Jk7kmza8V4PfxWI/6qjKiWCl3YTKY8B9AebnyTCamzTvyln/FThPyuut8Fo6FCUL/SkW8oSXAhvnX43BzJzhuxy4cqs8DugLSe5ts3zEtzflcjY6yLSYQZyBZh0Fvs34
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:24:18.1660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e09b225-216f-4397-2ebe-08decba22ff6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
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

On June 16, 2026 thus sayeth Wadim Egorov:
> Hi,
> 
> On 6/5/26 9:38 PM, Vishal Mahaveer wrote:
> > The upstream device tree changed the serial alias for MAIN UART1 from
> 
> upstream where? Can you point me to the related change?
> 

Hmm a quick scan through the history nothing seems to be standing out. 
Serial1 looks to have always been where DMSC put its traces. I wonder if 
this was ever working.

I'll try to see if older versions worked but I'm thinking we may need:

   Fixes: d2edabfa8de5 ("arm: mach-k3: am642: Load SYSFW binary and config from boot media")

~Bryan
