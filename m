Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55304D35172
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 10:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9165784056;
	Wed,  1 Apr 2026 12:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ONZ7u0wT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0CF83CE3; Wed,  1 Apr 2026 12:25:13 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC87083F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 12:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBdupjbcT4chPPIab5oa590x1FUEVR7MQ4Ks0MNUOXqFE18lAXMJmdzOKwGAwk/ysYjdr3/+axPBsvy56vw8Q4i3SyBr5Eiitq07hPlRkHLUtPFJDluRXRArXjY1taDYVPXE26154ZztALeYvb8OwfaMIz435A+RaeVBhMgG+LregPnRh6py/1ND0y0gmHn+uhUnWuLaWvr4Cce2REbYuYIBI36oJZEmL+uVSX6ltOiVAs5q1c2mpDJKi2ccxGrTLbQd7M3VLx09MSDRUAO+D8WardfA7Wi70bSrAt3bFEi+l1IQJuMaZYFZJQSQSQjvSmHpsUFigWg5CA8gLVukwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1Y5EGwlmK080wUkEb5ieWb2x6F+JNt0/CVWZNIUdOs=;
 b=V25Hch+fRO7t46h9oveSmTVAJTUzzQxCQ7dW1EEqozscfYhKuvxLi/sB5PxaCpjB8KCPOz0RZWKmhd92FHRirb5f9iQU1ZBarpAo/cSArAmH7OMlFsCUR5JqBecZdsKfKh+0jW1oiRJS0yCbSql5WAV5TahNrauPiGJotqpcBl7WcDZ2tZd3v5Fol2OeMQWOsxb9YYoPVcZIX+8B8Vg15BKADR4yS9+NKV69tRmoqkT43Y5KWqNBcqkT3u1QmUe/SgXk0holARP1cGn2vY9SIX3TeK8cPLiPblkq0dSr7G5RsZlAWFxFJFZOA5cxqb7axPqLSpHZN1AJ8kay8b+kqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1Y5EGwlmK080wUkEb5ieWb2x6F+JNt0/CVWZNIUdOs=;
 b=ONZ7u0wTZXIpYDF16K/8OBaFmIskIxwnz30plD6HMEe5MYUBXyUe6Nt/Xk2/27uBgQMXfIR7ydhqszJr9YHRgQ6ZRyYVhic/y6t5j7No1XCYtO2YbhzUZA+d8z1LDUGMWQuKgTwGfj7fr2tUUryara68upuUqNECG6aJOhkmWwI=
Received: from BN9PR03CA0206.namprd03.prod.outlook.com (2603:10b6:408:f9::31)
 by SJ2PR10MB7787.namprd10.prod.outlook.com (2603:10b6:a03:56c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 10:25:06 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:f9:cafe::22) by BN9PR03CA0206.outlook.office365.com
 (2603:10b6:408:f9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 10:25:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Wed, 1 Apr 2026 10:25:06 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:04 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Apr
 2026 05:25:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 1 Apr 2026 05:25:04 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 631AP3KI362151;
 Wed, 1 Apr 2026 05:25:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/4] Relocate U-Boot in the last bank
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <marek.vasut+renesas@mailbox.org>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 15:55:00 +0530
Message-ID: <177503910093.1968416.18317568984906145690.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775039103; l=865;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=DFKWu0CvkWlcPqfqTS9lT2qLb+uBtw9ccG+VyY105B0=;
 b=A6SpX38g6a6U6AjzKBAoJ+FWw7sHE8WZYxKPCxQ+E08oixVByOPTrwV0w3gMKgGifuVJ8d0Wz
 PVE/I1r8Sa+D2kgeRsz2Wmk0iqW+jrMXJAogp+cbwI+jhzrkBS0ZfGb
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ2PR10MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: ebcc1906-82cb-4ae6-e1b1-08de8fd8f18a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: XNMautBPcIDYpHEdWHsTlKYeoC/n3PRxp669Gqtur6O+1jQMmnoTAXWjwZifqn/xqlNVnl9418YjrgFKwKuIQ0TlnglkVZ1ydWZiPTgVRmfnLjne3GZm9UKJtdXSW5SjDUeN2O4zMxZQX21fsz9r3z0i3ZfCQZBluYfeCPEk10KAS8n1+ANbmWG3CP1ehu/R+iuI0Vc2Jkbg80MpltYf0zrAKra5Xg4ozE1+SfcTk/Pfyl4iFEWXH2ffU274/ni0gNOU+m/v6q//umUUbO6e7NTnwWcgGpr+WOAp/Z4kGg5Hz+vbwESP7RWAt5+NqCkYqqRCLk6cKtPNMohFCju52iCS3Ixtw4JcPZro+AKOeaVl3yJc0MeunKKg93VJ+oUhq6s6D+jTLIAFlRfNl7UXA0v9jqYgjX+s/biGDUB0hTDZFIfpAY5uFFD8acRUGBUv6lmj4csolH6T7AMp9/nPD90nRGvA5tOo1EeMEXR9CBzF47tCsh9JqqkY36AAO5atSVvvKg0LyFRaTrmJt4fd9g5UIUn9zbAAaNkY24B6C8/6D8n2U9jIbVsIC2R2ky2nSgBj9E8dEqOW65x3aO0ZGX+/+bubu4d5ge7ndX+iXStu2DE174bJAF5f8WUB9FAAVbJPtMH6n0mMDGsQICnaIbRSmDZxnrlcNOyX5JjLo7+XSDu4RrRsgE+/38xfoUT8Wy+6KZE9y/R3f3ptnxFDFB5H287ajvPQM/6DYq/f8dfoy6NLkaTR519ZdD4/4iQhj41S9vFxDtb0J5CMj8mT/Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RoYaKdeXWQL3Zu6onOu5VA1SuYYwFl7BUIPrAfhAuWPVofyxigPbno/p25WlMvxpj2eCk2dz/cMHX6tPvdHRed5dE6KIp7w8xpJB5ZMcxnczY5V/CeJgYQscXVbsIze3+GGdTq9jwAqI/IFVsnQrE+m3j/aoTJKKBbD7RhYzCSsKZi5JbrkwxsBv4wAKz0bWLKCweYBgtMrfNO6nAGmGVIomXnfN4Cif/yfNzyFcSeeHwVWfwhXy5lArV5XNYleO3/qwJWPAi3WI9h30qtEH/gpCKZfqyqusB11Sj6kwGPRI1SvkE0t8dMfcsXLnrCq0MPYHfkwF6E8PYj5S5KZbN/TT4g54c1+8LiY4UYoB1fKE2Essihcl3085IbTKE/1daT7+5FId6sXer1l85kLq72aN+w/vPwIyzaHj1Xvdai3QtYFsvD1T/C7aMmoiVm/C
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:25:06.0170 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebcc1906-82cb-4ae6-e1b1-08de8fd8f18a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7787
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

On Tue, 31 Mar 2026 11:01:10 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> Hi,
> This is v2 of [1]
> 
> There was a discussion recently on the mailing lists regarding our
> management of memory above ram_top [0]. The tl;dr is that we have two problems.
> 
> The first one is that U-Boot always relocates to the top of the first available
> bank unless there's special board code to sidestep that. The second is we don't
> successfully deal with devices that can only do 32-bit DMA.
> 
> This patch series deals with the first problem by adding a Kconfig option
> allowing platforms to relocate to the top of the last discovered bank.
> 

My subsequent comments are based on testing with this series on top of
v2026.04-rc5.

Kindly rebase the series to next for subsequent revisions, thanks.

-- 
Anshul Dalal <anshuld@ti.com>
