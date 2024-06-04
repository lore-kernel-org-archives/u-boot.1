Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6BCC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 19:57:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C595A87C69;
	Tue,  4 Jun 2024 21:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3sVyK5yw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B9487D0A; Tue,  4 Jun 2024 21:53:37 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4082F87DCA
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 21:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Sam.Povilus@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OM7S+XmPkiN6iso57lrKCkhoYlA7qiJmJJxkhSnNn8SwAeVs0L+6J2/GGxy+Vgy8oNzVyrtxW2MU2VXFB51bsr8AB2+ZlfSFWSZurWKXvG0XC0mSyqMg1Rx3bj4lDDvEHt+jfuxZAaxkYm4FKXxUPyr78OJhFop+2WtOadALxUGa8rjYkb6AFJPw+NcdUZVKf5twI+Glv0+R1QpZzoDxKEmm1Tszb9ksMzWCPI2PYrjc5Y1k7NuSG5z+jrhWogtr3xwOtZx8MJINkmQSDABCYF2GMmaU2ZsP4RQTZU3f9HWqSRTFjD5fCo+pYbthOAGeefYXFBFOFhA/tTQMxsX6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qw9sR+xGiHGC5fc8QeB4k1LEmzYS+OGwlpeUN+K/00Y=;
 b=mfVoK9YkD21HJ0wJy+x1I4OL/SxuKkNghdW+VoI+grK05RG99XBBeU2N/yNBE0J7cWIF3TV2fkdGi1P1oB8TisKJegPhJksZ73FIs4Dzcc0ZG2KidfI/Fxh6r9NZIqbDbccVow5Yy+YoqVRE4E5wWfTMR0ndnqLMzvf0jTN7J2ewPv+DYr2/DIUN61ys1HpEeVIDEv6GrUnZ+MiwP7cjJD+gY0k6vUiDFxosAZzHk9Qt0E1XgnpRKU21CZAMeRPb6pPLHYjv+VsVAgYhelyK2aQtqxPUS+JcV4tLmOiZm1eCd9VmZkF6Ayp3RzcijZwYdkEayTtkgAUrsGxZ1+8+FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw9sR+xGiHGC5fc8QeB4k1LEmzYS+OGwlpeUN+K/00Y=;
 b=3sVyK5ywMSuESRJ3wEwDEgF3+YxKDyjzKDdpR/sTqyTJpclHcpjE2xQDHc7slwsCcElNw7twpgwtffm1e9o9OKlCOZqw59Bc+8nBGB13LACu2qsuOL2aRtD/UtPiMpaPa3sz/UY4S03YSNGOuzxStVGurergKAC15Qpwhnd60PQ=
Received: from BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::34)
 by CH3PR12MB8258.namprd12.prod.outlook.com (2603:10b6:610:128::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 19:53:28 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:10c:cafe::a6) by BN9P222CA0029.outlook.office365.com
 (2603:10b6:408:10c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 19:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Tue, 4 Jun 2024 19:53:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 14:53:27 -0500
Received: from xcoapps69.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Jun 2024 14:53:26 -0500
From: Sam Povilus <sam.povilus@amd.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, Sam Povilus <sam.povilus@amd.com>
Subject: [PATCH 0/2] Cleanup fit documentation
Date: Tue, 4 Jun 2024 13:52:54 -0600
Message-ID: <20240604195256.1820285-1-sam.povilus@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: sam.povilus@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH3PR12MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7660ee-28f0-415c-3ec5-08dc84d000b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?upBNCUjmIH1NgZDMQExS75K0Zpgd8BmaPDo5+EgM7K6WPBfn2jjKjaECeP/R?=
 =?us-ascii?Q?aNkM7wTwer2A287mDRvQPB7evlsrWfZNufPUth4n1hMEnIHxsVtKoHgmvEYg?=
 =?us-ascii?Q?TlHzePwR4o+I310VeZAAaClmlrnpjOTOMdy0t0tzenSnNtJNWPvt5JxpMCCx?=
 =?us-ascii?Q?D44szkOt8kDk0zUKpCrsYl5QlXJ6+LW3jQ+RoLBk4Q1Vq0+IWyckCfro9DT3?=
 =?us-ascii?Q?FzPhBW4gjlyRTTiRwTbXswGytDjzztsHd11IRGFbqZUIZU6ObZHr6cIb7OOp?=
 =?us-ascii?Q?A+FRsArK3Sbi63eAWsexDE8zbf83vZLmtjvJt03Wh8i0JgQ/h9oFQfRqnrDY?=
 =?us-ascii?Q?d7A12H4nQ89k1+F5fkGBRM4HzpZT/ij/FUmiXtsrHrZzuk31NzvVfEv/oGQ0?=
 =?us-ascii?Q?cfWcyYZtoK8mgR0CDYVJIbvRnVfqdY/03UzxUs2j5xLyy9ylaejuNNbKsM7X?=
 =?us-ascii?Q?H1rnQB+UiUquIudGMcZ0Mdkznx2KyPdiWuixBCVyI5aeP+sahclfMB2BP3hc?=
 =?us-ascii?Q?jCEbKEJn7W5x7V7Rdb8jPiJk7XA4P13mnc/ogEPFVfuNjh2KD3Cx24M5sUt6?=
 =?us-ascii?Q?4RrYxArDqRHiZ5gwVohyLGj7y9zhlzzVMpV5aF8xuLf8Unp/ZCHhyIfpbCnz?=
 =?us-ascii?Q?temZkFOucNeoAHnICGQQAeXyGygKKsoNgwYIFgsk0q44rc7wWEyoVFr5fg14?=
 =?us-ascii?Q?ZCy9JDI5yPNTw5H1Q5pFUr1tzj7vZyuaNWwMtfqGGiXU/he2qS08c4lU7p6E?=
 =?us-ascii?Q?w/X9WQK9e2qstlGlhiLXpv/3Fg3+/bTA9KbXlFa86wVHqngu1hbxCpReC+GR?=
 =?us-ascii?Q?5QRqQ387ci+/eV8S1BWagj2aBOmlOklbpDk0lCqrpcitv4jHpvaN7a6P2LCX?=
 =?us-ascii?Q?8Hb9Omo4oGLC2KkGhCDRPaZm4axfj8LLY8TSk7QYZpSiOFQf9fXZFHcpWMIY?=
 =?us-ascii?Q?+mrTrwx9+wcjHy7S5Fa3XLlTMgT4ppNKhRxOa4qbF4btWZdzFeSrFiUEbB2s?=
 =?us-ascii?Q?nDyyDd0ekMrLZncyXcExM4k6w7uIfRmRb6UyBx9AzN0jZ4C/uVCdGX6MlVvs?=
 =?us-ascii?Q?Hd5ZiZcuaPFzNF6jgaZsXL6dDybyVp62g4IIfNvAUl6g8O59HjP31eo84sbC?=
 =?us-ascii?Q?ULb+NjgTmdqLwa+A0uB8AdX8DAL9Ov/82suXeSoYfwyORgd61qNOXAW/pz5W?=
 =?us-ascii?Q?zgi9Gs5r4/sUXx4n7SM0J5A65uq8CFKGyUflhYFl2G4PmpHqofhBXrYN9VUQ?=
 =?us-ascii?Q?jXT0SpBPlWZI5Tx6X58Y/OevIadfVwtNtWYy7hN4+Ts23gUaLu5Ij5Zv0dat?=
 =?us-ascii?Q?/ok7s1YjIytmoPlK+x+osvNkm1sYFawham1mf2VzTSSGcgH8080/4fr+NJfy?=
 =?us-ascii?Q?4OYBiDJUZSAqw2ccZnYWUKTjJKkWSsgeuMrgVHBjCjycbKrong=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 19:53:27.8197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7660ee-28f0-415c-3ec5-08dc84d000b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8258
X-Mailman-Approved-At: Tue, 04 Jun 2024 21:57:40 +0200
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

Sam Povilus (2):
  doc: Remove extraneous curly braces
  doc: add clarity to what a "fpga" image is

 doc/usage/fit/source_file_format.rst | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.34.1

