Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D834CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 11:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3638389A;
	Tue,  4 Nov 2025 12:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MfaV5Pux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C834808AF; Tue,  4 Nov 2025 12:19:53 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazhn150120000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d90f::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEFB28003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 12:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikZjWkhtoMyjSYF5tfJVPgrnSy30qx7KnviUm7TCQWfdBliovyIJdvLshqlL0fxVzulacGXnErcZ/iczpSXpRxzpglEwZjojNk3/9FICozr0g71QzLt2RA5YhL17ddn++Cn4PKp6KwnwMScu6pTFSpcQ8H2vY4PndgbiO0fqBl8+UuEXrMz/a8Lu12AEb+HU+6pvSdKaY3AOs6Dr9V//22vvOVL2u2rkAl9Hu+d2WyakTf6nHuFc/syoF3g5AEpSruBZYniZpC7nolqSa02dhRW4IIuDjaJBFr7mXoujODGdWCNelXhzgKxD6K2s0Ux4XM0p6TUhJfA1uyTNyqwSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6YbDS1bLS2aYqmnkoH8rXZ1KBVyP2Mvl1P8Ix6GbHY=;
 b=p8uEP+brSrsrEysZmIs4AnadGyvsO5bkf79g2UC8nS61cKXnc41Pric7v7SrWM9WtBuoqL4tFA2QDxuSdG2UatSGlUd4N6UUr5vvlPcGcRCAZrHvqjPt81F+oxIn4esgGX84q23XTYuMkrLqXeHvo/Z65goBe77dleTI0+iUDOJ+AxyRJ1o/FyDq1PF4t9rKTc0WsyBHdH9H0UgACJ0REIabaag5H99GgQ43otofRlv7T8iXvxDkjJYngfJe7wz0KIES9fbMZKGhOXMe9C0urYC2MsO2C9yqApuJ5klWbwoMCn7SNP3lrDEdQtf6MIoLgYuulNolrqxynrbQVfMJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6YbDS1bLS2aYqmnkoH8rXZ1KBVyP2Mvl1P8Ix6GbHY=;
 b=MfaV5Puxl2vdqo+WFN4ltjg/YNVPNyKOoAx65w2qQvO2FxISA5L6OWGlgMitqJkeroJuvQ4+9i3HWOaOXT57bxa4VLASzJGm/B6yc84xOsGqsNwm9uW6oFpbSkF3yKH2c1xq8+bqK++ANXcmbqQOUJY0Ddo8rnWJPK5xegigysQ=
Received: from BN0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:e7::9)
 by SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 11:19:46 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::fb) by BN0PR03CA0034.outlook.office365.com
 (2603:10b6:408:e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 11:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 11:19:43 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 05:19:40 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 05:19:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 05:19:40 -0600
Received: from localhost (kamlesh.dhcp.ti.com [172.24.233.19])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A4BJcS51821234;
 Tue, 4 Nov 2025 05:19:39 -0600
From: Kamlesh Gurudasani <kamlesh@ti.com>
Subject: [PATCH v4 0/2] Add compatibility for scmi clock protocol version 3.0
Date: Tue, 4 Nov 2025 16:49:29 +0530
Message-ID: <20251104-b4-scmi-v1-v4-0-51f101a6f8c3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHhCWkC/23NTQ7CIBCG4as0rMUAQ3905T2MiwKDnUVbAw3RN
 L27tBvbxITNN8nzMrOIgTCyazGzgIkijUMe+lQw27XDEzm5vJkSqhSNBG40j7YnniQ34NA0tW9
 rqVgGr4Ce3lvs/si7oziN4bO1k1yvfzP5CW7QK+EtKKfNbaKzHXu2NpLau+bgVHYooJRWuwYue
 HCwd5eDg+ygElKXoq4M/P5bluULOq69WBEBAAA=
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, Maxim Kochetkov
 <fido_max@inbox.ru>, <d-gole@ti.com>
CC: <u-boot@lists.denx.de>, Kamlesh Gurudasani <kamlesh@ti.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762255178; l=1425;
 i=kamlesh@ti.com; s=20230614; h=from:subject:message-id;
 bh=4lyCFLn71cHq7S6qkFAz5bTgppSMvLysG4ljLK2LNN8=;
 b=YMlmMc5zE5i4LSbbo4Wtlgtyo1VEGPBXyyNoMAmB/jikT5GjiY/6oOCeRwERaXnAerBLi3u+M
 osAUUQjY3R+CwxhvQ2Y4tGb8Gg9rxiRjZ2OiXYuTIoVmDXJPeT5YZHd
X-Developer-Key: i=kamlesh@ti.com; a=ed25519;
 pk=db9XKPVWDGJVqj2jDqgnPQd6uQf3GZ3oaQa4bq1odGo=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|SJ0PR10MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: ad894604-a00b-4064-528f-08de1b940ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|34020700016|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UStGdzllK1NISkxkRzNTWTdhS0RKZEJkbS9SUkI0anFja3ZpUU9JYXdpQ29F?=
 =?utf-8?B?MFJsZCtPYjUvU3o1NDErUEJPK01DTXB4QVhSTHh0MDJMZTBrVEFvUGw4MEh0?=
 =?utf-8?B?TmJ6QjlPMEwyalg0Qlc1bXZpQ1BGSGUzNmFSZDZiR2prazduSHJaNDU3cHd0?=
 =?utf-8?B?a3YwUE0vcmRyTGVlZUs2U0dkQ29qTE9CNUIzc3EvajZHWDA1NkEzcHNrRFd6?=
 =?utf-8?B?NGt0d0FvNlpvaCt3V3NWaUM5bUppODdudTVvVjNQeldoZHQwU2d5VVhvSEov?=
 =?utf-8?B?eEZjcXZ3VXRJRVRiSERadjFzSjNCaURkRnE4Zk5xbU5GaVduU3dDYkp2ajZW?=
 =?utf-8?B?VnVWd2RmSUJKTW1oNWljZjBGbHFpTG1ZWVQweUppSkZLRUo3WDhvenV3dnZl?=
 =?utf-8?B?NHY2MjFIVG4ycHZ3Y2lLWklzY3E3NC9ZRWJzSzAyUEJpT2F5UTN5cGc3SFFD?=
 =?utf-8?B?azJpREIvbFZHNTJSdy9BUkRVVUtiS21qNjZOZWhrUU1YdjJIV0krKzk3dkdU?=
 =?utf-8?B?M1hUdWl3WjFtc3JHQzV2ZSt2MndmMTB5TTlSYWZlamJTaG1CVlhiaEt0dDhi?=
 =?utf-8?B?NTlLcHVQWWgzcU16UEd5SzdGTG5jYmt6VHJSbHJJMVEvcnZyNktiTkErcVly?=
 =?utf-8?B?dDN6dGdiNi92bVVQK1E3bFhkNlVKcjV1WFZkODRBVzJ6THo5TXdTYzhMYkpo?=
 =?utf-8?B?Z1VkcGdkbTVjV2JoMlJQTEIzZ0ZwT3JWQndTRE5vZ0FJLzFwazBsY2piVU13?=
 =?utf-8?B?NkEwamxtZGJxZFk1R2QrTEgrWEk3ZUtXdS82WkFIanlUTE1pOHg2cGNCc3Fs?=
 =?utf-8?B?Ujg2QnYxSG1XRUt0bFVTWWp3cDg4ZGJXcG0vUW5ZOVQ5WEtpakdDMlJ1d1Jk?=
 =?utf-8?B?enN1NkM4aG9VS3hLTEQ2VDEvYU1EYzNGd0tSR0RVcVZxZmFBSnR5aGpOWHZm?=
 =?utf-8?B?RlhlODZuMFNPRDRjTUgxVXhGYmNKTFd0OUpCcnJLV1o4RlRzUGE2Y2UrZ0xV?=
 =?utf-8?B?eWloWHJRVjRQUGZWZ1lOSmpzd0RDUzJ6M0UzQlpYbWNKcm85RTJNM2Q4K3Q4?=
 =?utf-8?B?N3RscGNRK215alcrb21ETjgxODErR2FEclhOVEViSG9hNmc1SUI4bUVWZnBz?=
 =?utf-8?B?clJzOU9Ndjd0RVhSMmYyZktQYUtYb05Wc0R4VGNyUVNpVXVmUERFd1I3bmdr?=
 =?utf-8?B?Y2wrK0Ntb29GMldYZUtQdEpjVEovMjR6Q3RUZ1dmb2dDQkFjV2FLa1l2SlZo?=
 =?utf-8?B?SUlwVTNOSzJxYVBCK0NvenpZM3NEMW44aFhnb1gvdTRlTXlyMmJMMFphdGsw?=
 =?utf-8?B?d0ZEdFd5RmNkU0ZHTzRnaGRsaUFVckhlVXdjcWRIbXdUUTlDaHlnd242dXgx?=
 =?utf-8?B?QU1iZWxpa28zN0p3QVhsV0NtMDF0NWE0Rk1DaXBPQjQydm5tb1I5UityYnZW?=
 =?utf-8?B?bWMvL0w0em02QmRyZFlBMjAveTR4SnF0Y2VhdGJNMFBSOTNVVGZnYkVtYnps?=
 =?utf-8?B?d1VVa01NVnpBTkVaY0RkNDV2Smc4a240QTlGOHlxSUtHTk9JcE9zc1dHdUlQ?=
 =?utf-8?B?TGpjWTBkOHRVbUowTitWajgzaHhzSWFPL3JaVVd1aVVua2FzZXVqR25SaFlm?=
 =?utf-8?B?ZFcxS3AvbEZoRmppVCtodlhRM2kxcENvUkRpM3BBU2hWVDVYTGVZRXZta3A2?=
 =?utf-8?B?dHJVTU1qbS81VXhoR3pIWXZvakdiMkk0eFdYN2N3cDdJWGgvaVFDRDRCWEIy?=
 =?utf-8?B?SiszVUFJemNZeWRMOHFNV01wRE85b2JBMjhTWStlNjgwRXQyY0RQVlJCcStH?=
 =?utf-8?B?T1pYa3E5a2pZN0RSdEtjU2xEU05OQnB3ZkdCVEsvSytreHlMT3k1M3pDYWtK?=
 =?utf-8?B?ZXgrdnU3ck5scFErRnlhUDdQVE9vaDR6Wkc3RVZ0dEpPRWZFOHhOVE5RaFNB?=
 =?utf-8?B?MFdoMlFoRy9HTU9pd0VQVjNLdjJXWHhlU0NoL05tWlBFc1Y1MkRYbWYycFpK?=
 =?utf-8?B?NjNmM0xpUTN0YUNYb1R2cjBNeE1NOEFoeURKVEpnYTh4QkhjVkNQcTZjVER1?=
 =?utf-8?B?MzZNNVVRbHJ6UUNKZHVrQ01nYkxwWUVhdjlkOHJLcm4wQjhNdFZqMjdyam1H?=
 =?utf-8?Q?HrHw=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(34020700016)(36860700013)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 11:19:43.3775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad894604-a00b-4064-528f-08de1b940ddc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5550
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

Clock version 3.0 specified in ARM SCMI Platform design document
v3.2, adds extended_config_val parameter in CLOCK_CONFIG_SET.

The SCMI server with clock version 3.0 rejects the message if
it doesn't have this field.

Add support so that both SCMI server with clock version 2.0 and 3.0
can be handled.

While at it, fix the set_parent support for non CCF flow.

Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
---
Changes in v4:
- Added seperate handling for CCF and non CCF versions
- Link to v3: https://lore.kernel.org/r/20250819-b4-scmi-v1-v3-0-360145076b3b@ti.com

Changes in v3:
- Removed a checkpatch warning, which helped avoid reuse of code
- Link to v2: https://lore.kernel.org/r/20250818-b4-scmi-v1-v2-0-e0351c4d839e@ti.com

Changes in v2:
- Fixed the code according to review comments
- Link to v1: https://lore.kernel.org/r/20250813-b4-scmi-v1-v1-0-bef20fc32d4b@ti.com

---
Kamlesh Gurudasani (2):
      clk: scmi: fix set_parent support when CCF is not being used
      clk: scmi: add compatibility for clock version 3.0 and onwards

 drivers/clk/clk_scmi.c   | 54 ++++++++++++++++++++++++++++++++++++++++--------------
 include/scmi_protocols.h |  6 ++++++
 2 files changed, 46 insertions(+), 14 deletions(-)
---
base-commit: 4e4a9de31de2a5f395ee25c59e4026422fbcb27e
change-id: 20250813-b4-scmi-v1-b3deb87fa712

Best regards,
-- 
Kamlesh Gurudasani <kamlesh@ti.com>

