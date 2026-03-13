Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F9F106FD89
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 06:24:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AF983F2A;
	Fri, 13 Mar 2026 07:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gxB8gZQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C716E83F53; Fri, 13 Mar 2026 07:24:55 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5BD583F14
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 07:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4+UHbFP+tov0oH/LPOIr+f6cxQDUjkFPwMMkqqPM+jVeZQAWBOaFUKsBy35mtJWHVMwWGz+d2ftNB7uTrRz6PX+1AlickRtCBRixle0l6rw2qD6vZRN3UKmSbLgks0ch9MKChoDP/umJSvrmOL65JF5lvUCXPBcZ5P0GRzLLGWZkZp3VOV8EDuxL8wiPbiTXO8mqDgehyF3nzOB3tOzm2ypM0ql7jRFPrDVMCldguv5gyK5Vg54MCAsafOIV0dDkVIaNKNiYdyBfreJcsR3QugxUHJl4yjma4OccWBNbjSfgMDg2GTBCNM+V9+rC4wQf65YXjktZAe7aknL8gVPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0B3Qrkdfo1T8U1Z+Vwdd3tl63aQLO4dvauwm5bZCCqw=;
 b=IRDuuYJHbrLVb23iyVRHbF8LqI1mjHYXEJXxq89sIFwAKksfor8x2MwsnwFnW8oSApieE/uJsq36Pt6E/Pl/eVI4vBJ3YhM8+cPPKOMrl17UhLY5I3g0HuM+UfhQcogj5T+MAZanD7XpVPFbQzPoCBxXsJZpaThqICKDGOR9IhgGeLt73xi8qFlGQ5HKyCiegbMPuhUoMiOKgEGfrMq4IENigZEYS3g+EGhPkN3bkL2EFsT5FnD0jpajWXuwUaYu6uhEU4cXOSbsDtvl9AQu1YdfvE+058AzsXM+dIeHFVQtOZG8+PLkWDQlxtHqyxVFql2Xev5nSdjT+MUrUr5PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=cherry.de smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0B3Qrkdfo1T8U1Z+Vwdd3tl63aQLO4dvauwm5bZCCqw=;
 b=gxB8gZQuSqNTRJQmdGzCqXcPnfeOJWStmU4seCXhNu0IMj0D7ltSWs5RmCm14bHl22XCU9a/yvrMl/hjtIaIkcZQHk9NF5qv0vBpTNvRS3/WxRwv5ZQ0gMusRq6m+vbg5RqVUlLX8qIWs7xVjzSbzpaiR2te0eLzibW1NizlKyM=
Received: from BYAPR08CA0015.namprd08.prod.outlook.com (2603:10b6:a03:100::28)
 by LV0PR10MB997661.namprd10.prod.outlook.com (2603:10b6:408:343::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 06:24:49 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::eb) by BYAPR08CA0015.outlook.office365.com
 (2603:10b6:a03:100::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Fri,
 13 Mar 2026 06:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 06:24:47 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 01:24:47 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 01:24:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 01:24:46 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62D6Ojvn052334;
 Fri, 13 Mar 2026 01:24:46 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Mar 2026 11:54:45 +0530
Message-ID: <DH1FU6M5OHPK.16KN2XIGIUBPO@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Rasmus Villemoes <ravi@prevas.dk>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 0/4] add [ as alias for test, fix 0/1 argument handling
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260312100106.702368-1-ravi@prevas.dk>
In-Reply-To: <20260312100106.702368-1-ravi@prevas.dk>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|LV0PR10MB997661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9a4862-67b3-430a-bb0c-08de80c939bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: CH7AoZs/UCtYvf4qcfZdvWHdsv9d8Bxq9dd4609cvRFAOE4E6haSLP3B4+32TsHOxBgvvinY1uzAqeTAFUMwG7i/rKD3ZrXSWicwH3PNk/41O05uHfEpJyEtq7hr+8gekmWP+kCceSBnn0xVOdtnQsceJg+Q2Cc79U0Cctfrin+xJskaIBFIaJbGUI9bQtha/lIwoWQ0tDAdH0HuksWw0LYR9Q0qJpXRod4TslUUq9T1LAr1Bac2vEt2r+F48uSr2uElQx0rzFMyPffLWsBV9XoeMie313ZUyz0Hbbmicj3JlyMP3kUoAJvkxte2IECZSzf4H/tYJteM4SMwnwoOyZi/pwtmSUB4HZwZTpkzClb4hcGJXDxF+T7M4tfE36C9ww+k/J6SYP0UqOYweArA9w9JqSj1sUIcSw2M+jLpL17TnDtViZV+47lVNte3d2uMh0FMU5tt3ShVh17ZDIBmPU6PK5Idyh/FPr1V1faA0TgdkYsXpQLLsRK3GNkiI9VgOy9s5JQrm4fSxVP8aiH5dbnOI8c87gJtIh2+MJlZPfS/ecIb6OBStXXwP32wAdVN5be7g5Q7/nYy1QWIgdXNVY484g3+BKlwyXU6gAhHvO4QWuTjOf3NIhSPUdcC/CW+0ckeqmZepmJFywGnobwKwLktGlyrDxHv114IHSqIUxnIXn/t2ziE96+WqlfoAslX7sYzqJht2WlBTbMklCIqSLL4XG/QELb0I900Bh75reA=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wEOeTJtWlDhHLhUmHaTkh6BYogSTFWya7mzrgU5uAg229tP6bPWCJkF79qvYzmAmQAugN42nyWLxynOiFKHhWpyUwCmsKF5q4PPVa9fhfsdybpZ4b8yKGgahSQTpTyetJ5NjDET2Ja+dtujxsO8uIDyIHwpn6ZTIwmnWeTyNd8mDLQEEqqrQxVpghncgwxK71xxAgbn0W+RngwJTzbmy2CfXFa043KeguzdM5Ws6ygNlhs6CjKbaJ5OHBQyaCNfuNI5JpuG842zrD6DM3H9LTsR8Mapo7/h8h1OJMLXdAxtIF36kSUJq7xNbTYmg/iL+dmlY6c6R0au78n3zXdgzE5CWWjA+ie1begngO7oN8cFnVEEaXYkrIzEyoCbC0oK6sgXPd8OUsxcheocchREFdHcrGPZ6QHmIQcPGyr3WZaMZQkLQWsUl/FYR+8JkVzCe
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:24:47.7393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9a4862-67b3-430a-bb0c-08de80c939bd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997661
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

On Thu Mar 12, 2026 at 3:31 PM IST, Rasmus Villemoes wrote:
> Make 'test' behave a little more like its cousins in other shells, by
> allowing the [ ... ] spelling, and while here, fix up the handling of
> a single, non-empty argument to comply with POSIX.
>
> v2: update documentation, add a few more test cases.
>
> CI is happy: https://github.com/u-boot/u-boot/pull/905
>
> v1: https://lore.kernel.org/u-boot/20260311120910.3934114-1-ravi@prevas.d=
k/

Tested-by: Anshul Dalal <anshuld@ti.com>

>
> Rasmus Villemoes (4):
>   cmd: test: allow using [ as alias for test
>   doc: test: document [ ] spelling of test
>   test: add tests for left-bracket alias for 'test' command
>   cmd: test: fix handling of single-argument form of test
>
>  cmd/test.c             | 30 +++++++++++++++--
>  doc/usage/cmd/test.rst |  5 ++-
>  test/hush/if.c         | 73 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 3 deletions(-)

