Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57714C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3F4D80C33;
	Thu, 20 Aug 2026 09:26:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B8M5kRKZhBrF; Thu, 20 Aug 2026 09:26:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218006;
	bh=0VJRn7iVNxN/UtiPnBYZMx0vP5faYzaVhTqGjT4CmDI=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sn9G5v5AaiTqeq9c/pCHyPjyzhVg8F2KSYosn26cax9UqPkWkA2/hD99QrgsdKA89
	 0JPxTZLT3epOcVJnqkxOgqZxoUEUaBBI07m1vzfNEjsZsKkbRyclC5FLAH4hEaluDR
	 k8jU91HFHRU1BK6qvIVmLBoD+mrgSJ5P7NTbKBz57iEAe/0jO8MOTGytwo1oR3IvBp
	 M0DufM4l1PG+r2jmq7CpTnznaVXa0PJZZnQ1uojg33mJ/sDNVUUhzuv1AkARnHrDMA
	 vdubsSTFrzg83uHbyk8VnllxHnbBOm5IAiQ6XayVm+1MWDImZDw2ntNa82OV+/l28N
	 D2HkT7jgVUvkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEC0B80BEA;
	Thu, 20 Aug 2026 09:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F9232FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1553B60603
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bgOb3LQlQQon for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:26:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pwaLsEDu
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E4AA605CB
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7IprvnZyzCfPPp6mT6zLGM0z0R7BmkuCLK2Rjo8uBuzvSAFjmMm4660u94Ol3qwVW3uaX7NcU32Lw2yBTdIMeiot1MHLkmGpz5Ds7GbvUaeKLd+RsbT8zj/S5Xt6uzimKJak6CQIp4e62JpjKmd9H6Rm08JB1o5oxoMmr7CGg7146CFdVtyBMm/RjRnOxc0Yanf54EDDhDR0ImeQRXADPz53UZ1RlAHYLLAId4Y/mWDOOtZE4Nq6jaCLgJBiO0OdjPO0GI9XUMuddpsSHEuFGH+FrWp34/7zndG2TyRsAQ5b2MIgicsLegc+yjinWocjE3kXwXGgn4tfhIg5lpyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VJRn7iVNxN/UtiPnBYZMx0vP5faYzaVhTqGjT4CmDI=;
 b=Ab9ZaLx+x0t/S0MXLczq0SkqkM93MktEEOozpvWBR4XOeUbWfWqkQqvjUBJ5RmZXpLMuI+BRAiau0+0JDNC/qPWvm7/Q5vAyHXMIgAgnf9uzcmEygTRV0tvUomJ1naEuQa7nAoiDi+HSWDadDqwxpVsSR3ynYUBvVW5DAW6EcxZW+MhDMM3ezXJI/Xo/Wu58iB03LhDClZIUKXro4/n+QQoid4H9QnoA6/s0YRdISY3laqKX36JKq1OeEB2jqGMuzChexUTn1x71FNUb1cd8zvfYREVvot9VlH5pMtRG2XownYcPzbOqZeWyC6wpxuDfNxtQfIHjwPWC9FnG9EWuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VJRn7iVNxN/UtiPnBYZMx0vP5faYzaVhTqGjT4CmDI=;
 b=pwaLsEDuGhvu8gJCptuRxooKpOdxpGx1KtgED/M+tEGf1BEIxT8GEyBg7V2klCwAmyFh2vBAaK0k0Vdr27vVSlhpqt4i8wMoRensHgL/cOw40UU0DXGdCgU2UEcDdTg09FB7i+rScyG/b+fz0WaGD90j+QllNnUnvplV1pBXv2c=
Received: from BN9PR03CA0642.namprd03.prod.outlook.com (2603:10b6:408:13b::17)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:26:39 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::48) by BN9PR03CA0642.outlook.office365.com
 (2603:10b6:408:13b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 09:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:26:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:26:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:26:36 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:26:35 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH 0/8] net: mrmac: Fix Rx packet loss on back-to-back frames
Date: Thu, 20 Aug 2026 14:55:46 +0530
Message-ID: <20260820092623.1647844-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da22bd2-8201-401d-df57-08defe9d22c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: ZK1iWEIiy/yine4IsBc0QRAdQKsTBcEaWjEwC6AUC3upCcf9+wDplG67lFACbWBVY7aKBU8viJlTiN+b4yABc4NZ9wzelAxjFNKYeY2XMhJ6m9dwKhvhmbZfPgKpbT/dwWX4rAAtqo/mp/skGzcLCstyEAUG7ZO/A/WGw/hsxU8VuE93K43NuaHe5r9spTID7yi4ADGm4fvpWEqZVwWdOJnZ9STagffBihwxPSIUolGMN02NE0Xb9dX1fsovynu5GDWZVyt4n0zXzDQLy7fCzGz/VJaqOtMB6/GMrdULXIwOvprrDeKDzVmmRmXeUU96RfNIBF+F5i1orTCX1i18bS/PTLF85lUs6oTN1NRU2gX717aezT5Y+Xi2a8+LA7/5l3FBfX77pB49VP0F+6zBq2f/rZvYWqGToJl2nogEE8BLmlQMfWZK0rZeY7QY9z+jzc4CGFIADZ0QOFlUDTfBdHsTHFGtbB25MN/pLouMMRmtLAFDLvFcMoza9SqMQ9XBcl10eUrbD4WChIgXYclBhaYoP5nTUUmCMKpzfk5S4AtqOmAPLirEcgndIEFWPBIfT1HEJBQoBFIC1dQFnd3FWZvlRMoG57ydmCAV6Yde2RzvaTzO9vRc9pKo8CpLdggsgM5fH3bDnr00Te30VDrAw28MOj7OVrjZXmH4mFxWGlI0LlItwXGag2Om8ph414pfY3oL5NxkeKcCENYTNmAsvQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pSDA6pMNve2f03WwfzNgRoLv8K3DEiOgGUffsoQJtH9lqkwCvxI6QTKB7sh/R3T1vzjJD8w46/07+t69mm3CxnRYcN0XVV1oW4s+E9CzjEOxfdd5fB3qU2vdn87Yzt+dtOe3tMvlg09Gr6yriIDwjHHHcNtpcEmEU/nCniJx02dmglgwQvyD7Ib/YwjfwJwhz+4/PdnwaAjtUJa03WS+7PWYglDJTaIn0VYO5tx2tEzip0XySlAC3U88vV7GLSoXS5Su6mud3fyD/fTUJWmfpmNvqXXgJgQ0aeiGpZiXySHtNjX3dPQpYibCQGi/frIXYtnyBgNg/Zm1vqtHrtD3RrsQi1ojF0riVKC/7XJoTgLLzNDc6gwjE4zijZEPw7qpil/6HqywGI6AfBGwNj7N+Xyc769ZlYoYyHbyZvOHm6XHA/CC2CCVnJsGVxJH5muC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:26:37.9704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da22bd2-8201-401d-df57-08defe9d22c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The MRMAC Rx path drops frames when two arrive back to back. recv()
always starts at rx_bd[0] and clears the status of both descriptors,
and the status field is the only record that a frame arrived, so the
second frame is lost without any error being reported. This shows up
with multiple boards on a switch, where the extra traffic makes
back-to-back arrivals common and network transfers time out.

Fixing that needs an Rx ring the driver can index, so the series first
makes the ring scalable and then fixes the bug:

  1-3  Independent cleanups: check memalign() failures, give the
       driver its own Rx buffer pool instead of borrowing the shared
       net_rx_packets[], and read the link speed from the standard
       max-speed property.

  4-6  Make the descriptor ring scale: index the contiguous BD blocks
       directly, build the Rx chain in a loop over RX_DESC, and
       program CURDESC only once the ring is complete in memory.

  7    Track the descriptor to consume next in rx_bd_idx and take
       completion from the per-descriptor COMPLETE bit, so a
       descriptor goes back to hardware only after the network stack
       has read it.

  8    Size the Rx ring from ETH_PACKETS_BATCH_RECV, so a full
       eth_rx() call can be served without hardware running out of
       descriptors.

Padmarao Begari (8):
  net: mrmac: check memalign() return values
  net: mrmac: use a driver-owned RX buffer pool
  net: mrmac: switch to max-speed property
  net: mrmac: use contiguous BD arrays
  net: mrmac: initialize the Rx BD ring in a loop
  net: mrmac: write CURDESC after ring setup
  net: mrmac: fix Rx packet loss on back-to-back frames
  net: mrmac: increase the Rx BD ring

 drivers/net/xilinx_axi_mrmac.c | 235 +++++++++++++++++----------------
 drivers/net/xilinx_axi_mrmac.h |  20 ++-
 2 files changed, 137 insertions(+), 118 deletions(-)

-- 
2.34.1

