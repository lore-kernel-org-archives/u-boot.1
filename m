Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AA7606A339
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=piL9rEQJ;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=nWu2Yzii
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 909B381346;
	Wed, 11 Nov 2026 12:08:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ID720PhB8y1j; Wed, 11 Nov 2026 12:08:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B2DAE812AF
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794398901;
	b=SJI9/3VkKS18oT0ilPxeabIomeLtxEPqa714vbOqJChfpc5eMWv19F1UGw6ORfUhChRf
	 uUcMQx9oAkpTlP7KS23DeAmrlbd8tAZzsT54e34/hsFa3tpB7WNHn12tqA8c4D9zVVnCm
	 Fl2/G4Q9RYhJhnp+YFFj4GyDT24R8nyPxH5nfFzU8XEUyW8Ie0EIB1qbkEvsvul/MGwgE
	 RCYQWmybRfjPhzLGwEiHl2fPErry+Qs6I/Qu47aUykounaG/jX/RVmbMQeafCCHgkHT71
	 8uosjfB2UDaennLlMf/jzz24EF0vja5gR3Pv0oa8pp6dkOiXt7EyXvpaShwwK1wy96g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794398901;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2ZGWe2776yLptdQDWSOVE6mbxde4xIhzXtiuw43xtmk=;
	b=PUrAnMQP4B1gXnCqiPIOsmtJSs1mO7Ihk/4L2FgH3pmgZWv6CrUWZISndeohAwhXfUmh
	 Eeck7vELrJ//aSQvNjBFgx65v9SIkPb+hJJqawrD4mRrkiUKrAVluA1gKeSOfUSmPxUYB
	 pzi2lBptxkOXVUuaLFOoflBLyitoH62Oc189fcWbIwBh3V9JwkCMvmfesIPkTRd7lkSOM
	 yaF9vtA7xlBNxFkt1ZpZz1EZNDLlWOMYQG9MMQnqNnXyCue2trL/9nfdZhWOkkV8HntoU
	 U9yJhpJlouWW1ow4XdwXwnFWSb0GX5XzTlnHdM//rQIV2uLYPecHL7LrcYBrM4nYHpQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794398901;
	bh=2ZGWe2776yLptdQDWSOVE6mbxde4xIhzXtiuw43xtmk=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=piL9rEQJMzIr7HGDgvNBLBPlflhCM5QwlqD1YJHRD9SfW3emWazS2UuJiCyBIeN7g
	 FiOGXmEL8P/4xRuVCNw11sW8dnC0SPGH5Q/Bsq9eE8BZMG0zQgvTKVyqUl77RWJOsB
	 h6XBA9KxMTo2kOqXwb2FjjBCjLJ7nuheOf6PLytYn/SaJSLi3XrtAVBjpCMoIZ7WHi
	 cnbOkin0sRjsOp3e0RBVWvsHq/od2MzYkz5mD+Q36IlXqRVbiAPdQN8PPYV7eyzn22
	 Xp4PTVz8D2M0w7EGEoVEFzFyIxnCQ+qSQ2wfl4LZONhWAluOLAGIFBzX7AeVGlqaQO
	 g69185NMgxBsA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2DAE812AF;
	Wed, 11 Nov 2026 12:08:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4804731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A616440AE7
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOKrEKl4rhut for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 12:08:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3033040A4E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c111::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=nWu2Yzii
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3033040A4E
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZGWe2776yLptdQDWSOVE6mbxde4xIhzXtiuw43xtmk=;
 b=nWu2YziiN6P/FR39XlAZ72Iyva0Rur1iRX3cDj/vgQ4rIG0wRhHKojevrfbLKfJqIA+Rc9ZUs5IpvUKn+gNCyNLx9IwN8crc0tKixtpP7G5EC2gJ+VcoiCUMtq2+uy+Ijg/rezy5qYbMTi50/MICXBx3EeLGs7nrtv0VYOdB1UY=
Received: from BN9PR03CA0953.namprd03.prod.outlook.com (2603:10b6:408:108::28)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:07:27 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::5a) by BN9PR03CA0953.outlook.office365.com
 (2603:10b6:408:108::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 12:07:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 12:07:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:07:23 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 06:07:22 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 11 Nov 2026 06:07:20 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH 0/5] mtd: spi-nor: Micron, Macronix and n25q512ax3 updates
Date: Wed, 11 Nov 2026 17:36:40 +0530
Message-ID: <20261111120713.1526940-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7d8b11-b356-4aa0-7ab1-08df3fec5a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|261102123227099003|11063799006|56012099006|261021121427099003|10067099003|261021123027099003|261026121527099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8ssGGXYVqyY8v1iIB9ujo2HM62QBEKhsDK271uYeiuNPkUnerBhQbD/OCGebhw7DR9II6tTAX7CTOkO3Wy35Eow/jKe9hF10PbQTk7svVUocje7+uaFe7PG4/h29zj6y8NvhPf8ug8UKnwzz4n1ObkLXJ3WxKfmFR2YIhujb2xgkYc7yDXtx78zDDTQeoSjrdUZg7Z4kI3RTYIpAwD93jmuKs7YJS41za3h5D/2t1tIlMflv+pLa4VaeNQOz0Rnu0f2HNy1YA5Jz8lIjaci9lenkAQpdCOgCR6AEhH4WbW5dEAnSPtZvqx0qbLiyofiXxiCPc5dpsXqkaszbtCj/CHzUQPppZcMol/cA8M1FPfbL9a6E7tyloQtGbKBZexfZuG8EUuqCBwi3LbNECps0O4Xs2otQ5hAX0e0owZor/CCFaI4bmIpCDDk09vEg9pGHQWCaWWOEoiEttseWg6UVU/9Uh6f4d/chRjrjSp06fxJkvKvk7KIZ/HjXMh4VavIsWo4WXMzbGBvqEH3m+Ec/T72rCrpMszaLodG/FDs6P161rLWqKqzRsb9U/Wvnh5TZU+Nw/hurSuhm484UMLmKXjfMiKqSUxA6qt6X6J8uN8vEuCe7qeK1uhk2Dzfl+X68BA2YxPbtBMlz70gDfoWT1QnGwlyyFXACDINAbWHnFwcQhcsXsY0X0IA36nQzx5MK1O+k8u52qwfuH5dRji4DFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(261102123227099003)(11063799006)(56012099006)(261021121427099003)(10067099003)(261021123027099003)(261026121527099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kB/dYgnqfILMtbhnVzgso7+Kwa2CrdI/sKDYGSk8kBGZ9Vs3ApujfUsbttq0aQta9bvsnLuJZuZ3M1bwWMuVxueupGRcDTw4BNeoPyq83dHx6XfuYTxQnoKgqK2CVH6h9GY+28j/Ko59sdDRz8jgAcL9jmqT3iRgxw4+ZuclRTaPCOd9+5nuSr+57ucJjp77/z8qMOIaH24Z5RqRb29AStcK/9nwFrG1svS8IXXHgoFSFK9RceX5rA+eWL5fN5vBh39i+yJuxpPuJCqtz5gdUU18o3CDiLvafddTN3bXPyeo8+6+tuWWrMzCp2+eNminin07mRBX1mPgu/TaQjZDhlYKxKQpIJ/DWrytd/2lK8DT2+0ozb/Qhiu/90lblXd6WjYJvL8hDXn6i9P62qtJvjugd/qnhKXjsk0ddmrBZ3+DSE8H4SGUYD4W7XdHQ+aB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:07:26.7321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7d8b11-b356-4aa0-7ab1-08df3fec5a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series updates some Micron, Macronix and n25q512ax3 SPI NOR
flashes.

Patches 1-3 enable octal DTR read for the Micron mt35xu01g and
mt35xu02g flashes, and apply mt35xu512aba_fixups to all mt35xx flashes
with octal DTR read. Patch 2 moves mt35xu01g before mt35xu01gaba, which
has the same 3-byte ID, as mt35xu01g is never detected otherwise.

Patch 4 adds the Macronix MX66UM2G45G flash.

Patch 5 disables chip erase for the n25q512ax3 flash, which does not
work, so that sector erase is used instead.

Abbarapu Venkatesh Yadav (3):
  mtd: spi-nor-ids: Enable octal DTR for mt35xu01g/mt35xu02g
  mtd: spi-nor: Use mt35xu512aba fixups for other mt35xx flashes
  mtd: spi-nor: Disable chip erase for n25q512ax3 flash

Padmarao Begari (1):
  mtd: spi-nor-ids: Match mt35xu01g before mt35xu01gaba

Tejas Bhumkar (1):
  mtd: spi-nor: Add Macronix MX66UM2G45G flash

 drivers/mtd/spi/spi-nor-core.c |  6 +++++-
 drivers/mtd/spi/spi-nor-ids.c  | 12 +++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.34.1

