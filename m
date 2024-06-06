Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2B9C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 06:36:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD3788363;
	Thu,  6 Jun 2024 08:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PL4PH/MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 073B2883EA; Thu,  6 Jun 2024 08:35:58 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A159888276
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 08:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJqYaESaoxKxeyBpykZ+w0pqk5ZA2o6aq9B+tpljKZQDcbT2IJZqt29KuBErdCdqHIkXbrkA6FYP332bbwGCsecZq1nSTG1cd0TXEmaXC/wjV/JxJCkQeH28hYlauZpIOP9dwCA/bzSEWGmQ0YFNIfmpxSOz+4dhN0Jji1130WCS2KEBmMwU3++Kkb6Y/yuuwr6Y8PJQDZtJX30sHvjx5XQrMO3zkXaMraTq4o8diLAA+R5Z40UdCBC2XUsmVcdINiaPUCKUn/ibSBbL1ycNN5uybUbvtJKWb0ZAMruvzyjEpKvAuZ1Kl5qunJxAsmdu2fBTz/C+pnivrhKeQMgx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4Uq6MOcUOkBLpTQ7Um24u7txGlxIS0ijDnsLF4z3iU=;
 b=LHdR1F/rIPxO3qXiwIBmhZ5ezkSiIGio5iYv/U3TK4nymGCJgfH9FZ+Q8vzgxgkhlGtMEpVF76I0bfAuxZpG5topevsewGRDPVYpLG2vOOU++SNWkToHCHhEN+n8Z+x7cUhwa3fbCcVKe5dlwXCXAmkX0102asXAVPh9mkuh+h1KabWzLmUUvcOdPrFfiV4+BKYeQ7iGFWJ9YQ7PilUO9hAbLDoVtWwmxklyEKRJYF5R4lk1OcsRusvlxWefqxRo3Hmg3/SbO9j15zyagcI5RF+eqwRDsyDw+yhFHJJwU7XOmW1Bx/mN+6GrCWCQ67ZF9fkMC1FiNfvR41luEK2cDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4Uq6MOcUOkBLpTQ7Um24u7txGlxIS0ijDnsLF4z3iU=;
 b=PL4PH/MBUFBY1Ogx6g70c0aXdAlZbQ6RoSgkanowxADxFtzQMphD4GbcGyZcz1tysulnbpgGaoB/T1cBNl+a4uzSevxGywYQhS1AnmqDMRGUloaXRk4pJaKNMRFv8sytJd3g4UHNnK8mt2JIG7WkXmuQfB3fCaW2sMtqXovi/b0=
Received: from MN2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:208:178::16)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Thu, 6 Jun 2024 06:35:51 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:178:cafe::cf) by MN2PR19CA0003.outlook.office365.com
 (2603:10b6:208:178::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 06:35:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 06:35:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 01:35:49 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Etienne Carriere <etienne.carriere@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] cmd: fwu: Also print information about size
Date: Thu, 6 Jun 2024 08:35:46 +0200
Message-ID: <4fd96b9f7312793109fe32a85fc717566ef6fa92.1717655740.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=727; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=wiQ6qBmY8l/pcJURc7beyZ2n818fmdWhesKTHIXUVWw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrTEiL1BvaxTJqUXfU3gnMvK2vdDr9g1KEBOzKDPPW92l
 Vkkj3lHLAuDIBODrJgii7TNlTN7K2dMEb54WA5mDisTyBAGLk4BmMibTIb5Tguvr2HIc7DhW9eo
 6xx4ULq1fU8bwxz+HbYXZ8mz1qZyTA/dPWOhQEPnWTkA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: aa680be6-a86d-4eb2-c588-08dc85f2e8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YK4XIYaZ398y9IE6VE7q5CJsJYmLxzVFyOMxZmHPI2Ngz4lnG5mtdn7Xmy3s?=
 =?us-ascii?Q?GL47TfPzxXKMuIDn4/r42N6Lzj/UIf9iAiAmlhMC8+axXQOGLupkZ1BjTcRr?=
 =?us-ascii?Q?ng16wkb+AS3dA4omMkDxVHI9MaqwehOJLh4w1N6o6/hlOtquPQoJGOAPVXJv?=
 =?us-ascii?Q?UK1sU3dcupwg6uXZGOtF0Gumjk/Zz0/ulZ151SSeQ6zdIagdkFbellqnbsu0?=
 =?us-ascii?Q?UbEiSH4OYucULHMHBYwuW1IFOQ88d5jxN9B193XwFbD6TlGawyu90Op+rzyz?=
 =?us-ascii?Q?p8HMq55j6yR6cNK2pzmLQ4tDX3KrfZ3jAXXKw7c9Oaqfax9wv7AsJZMoaUCj?=
 =?us-ascii?Q?2u+Dx5He7rjooEaCaFlky2VWlL5/nArqvHjCtYeh2qyX9nlSiokcAA5s83Jp?=
 =?us-ascii?Q?un5FVAoazliul4p9g0EyglF3uPCSuWSrJJHiWiDvGg2lfOXH58c0fBXouC4n?=
 =?us-ascii?Q?WPhgxTbefiFoCavE+OIeNXwA5zCgWSLwn5OPbJVs+MqRUzTFNp5D6WCqEpwP?=
 =?us-ascii?Q?Lxh47huQrVBu5aiJrzL5PKVrIqmMRvJUK7MYCtitQ27K4i8qh+JaDLiVEV8b?=
 =?us-ascii?Q?uoosPWHuGklRLisaRH2YdluUfuP7/DMYL0XLV6vDZ2BB+sb2xfq74EtviXY7?=
 =?us-ascii?Q?ECsSQjIPZ38JJzEE7oa0dk1ivG+reXXYsGLrmNhCuAgVkgoj38IhY+TPlWuG?=
 =?us-ascii?Q?y3QQBg4qe/MuhI7gas+LKt0oUiqJ4rZt+29m89rbp8lLGBg1J/LXswUytsLn?=
 =?us-ascii?Q?iMQTz4HrPp1jOjW4IZQQL+FqslL7qZTydGYYUg+fQeY0Z9KVRJyMHiS8557t?=
 =?us-ascii?Q?t0Yv5IQCZIzAx2PhHafFVNB5ZLc4Op5YR6EI2se29iRoorUFIH+abCcEHzXp?=
 =?us-ascii?Q?OVv2YN8fmXn5lR13C8I89qMWq/GaqB/IVnXffZiwAUi7e0NmLse2ngmDnlDI?=
 =?us-ascii?Q?sJNbVrcYvxMI+bNSwwYEKBe3g3ZQ9VtlXd12iPOxkwBhF+vIS+azILsI1xO3?=
 =?us-ascii?Q?v/zyW8col6scIOnhp4osYOyWjIWofdbsT8AzbTffOi0ll1KhC3qZIBQnVLKb?=
 =?us-ascii?Q?J3b/acwiDvEtANO43Ai+cVJNOGUK6fy76xE/tuDkVokzcH17M2PaF2bd4fn/?=
 =?us-ascii?Q?yMvYXpI7C6NrlrQGK6fAWFxUngeaQoZ6AjpCxmM9mrjjkwuheKXsl0JmBsjG?=
 =?us-ascii?Q?i1PjvbIhEI1uTRqFuAhWeQhjQrEouWOZwNJKwQOi0lj5tIGV6mVifHh3oG4i?=
 =?us-ascii?Q?qrrqg3pD9qj/3q2xzlfQt6AC8f8emoLlma3/4D/BFov4Xgt/rKUeTwUInkfN?=
 =?us-ascii?Q?6xvjvmo4NPy8AyV3hlJ+j9SKusWWbAiEDszmU6L3KGl1ueRrnRquVBs975Fe?=
 =?us-ascii?Q?+/pXv0wkUgx1bEKZ3hTY2Yy52GH/iC++sO7fTZ0xwrSaAtD/9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 06:35:51.5357 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa680be6-a86d-4eb2-c588-08dc85f2e8e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
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

It is useful when structure is also used for saving vendor data covered
by CRC32.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- print it only in mdata v2 version

 cmd/fwu_mdata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
index 6d91935b9b54..56654ba1b93c 100644
--- a/cmd/fwu_mdata.c
+++ b/cmd/fwu_mdata.c
@@ -27,6 +27,7 @@ static void print_mdata(struct fwu_data *data)
 	printf("previous_active_index: %#x\n", data->previous_active_index);
 
 	if (data->version == 2) {
+		printf("size: %#x\n", data->metadata_size);
 		for (i = 0; i < 4; i++)
 			printf("bank_state[%d]: %#x\n",
 			       i, data->bank_state[i]);
-- 
2.40.1

