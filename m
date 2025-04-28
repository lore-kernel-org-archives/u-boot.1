Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6D7C369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 14:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A87882B45;
	Mon, 28 Apr 2025 16:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="V8qSNdkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0B8A8293C; Mon, 28 Apr 2025 16:49:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::726])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06D482B07
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 16:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aolt4cHq0yD638EdZg4ifjWNLUWxCQgkshVHYboHfApf+DlJxPbevYzpqRXgJiWV0NMRvzOX/Rr/6LTcNdiqV5uORUxdHhNr7wEC0cA6lBVJ/hcIYc8YWjcNVb3pdVCbbhOdFj/7l29vez//+Drn3seKDH5wtTUfUyGbOQUob4xxen0BPESeZb6dMgOwQPM/Bpa1x/sc7cztNPB4TJeZsgF0L26xShqDHKAm9+JmiekzbD2kEYOvcnpGksGmcqQNhl3XQhTc2weS7cX7i/3+w3r4h2tcLZIsYM2e82SOd2aKoapvFEgZ/e3FJZurSOxoevcE08JHJhhzVlUHd2l3gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en3pCaEdUo12OkdytZOFeRuemWyMlZKE9GHv/UZDEmA=;
 b=d0IP3BfOh6I2Caz9p8fFrNXDZXsgcaCTEnE+zfnl7sKP94rDC5cfDcjlMY4iz92kowrFo3RGopc2EOORZwrBqZIzsHgMQWChNrlrl+ReFF7v/SvfstAhrx7ju06YJH6fOHgz0k6eEooNcWcvRkQ20pjTdJXUWXI797PPTvEPtrHIpKeGq1phCM5TfhcYmqZawWKWkpGhwLEOt98gPM/YwXgnEZD202DZQddaR+ty80c8VrjWgLhG3BYljco5tsAbDhXIVhMMTBaM7HPlSVKBGDJWkF1oLocl90g7rQyWegFTQBDtpPLMkK9tWN39rz+4ScZtIZdf8PxuEDD4ZwActw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=phytec.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en3pCaEdUo12OkdytZOFeRuemWyMlZKE9GHv/UZDEmA=;
 b=V8qSNdkOJl/+P4WR8cnNmRgfhdDLQbfTmBH6YMuFIXFA0dwvWWKXY8V1dRUfgI0YtsDAMuYD+cWp43OK2sLNo87tREmNkLzBsWq0S3B36aUK7oewpXEfslt6tZ6+Ci2HnmksYBs74z79oC7zHEqKSonj0X1I5uquDjXb+XHjNRFfUI054JyC8T2oyQiWvnZDx45PPueOJ11wHgLYm9jvUwMeGpZk3ps3997RBgcw9tj3+tJUsYEtU41DESC8ch4Dc8E3OYYvDaFJzNv0PB9/d968PaJdEqlxE3RlfX9f7Cpb449Ke6EzApqxjcAf+4erdjbKlZb3Xv+BMDFQmhPDNQ==
Received: from DU7P194CA0015.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::10)
 by DBAP195MB1002.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Mon, 28 Apr
 2025 14:49:24 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::67) by DU7P194CA0015.outlook.office365.com
 (2603:10a6:10:553::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 14:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 14:49:24 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 16:49:23 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 28 Apr
 2025 16:49:21 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <ggiordano@phytec.com>, <w.egorov@phytec.de>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <joe.hershberger@ni.com>
CC: <d.schultz@phytec.de>, <bb@ti.com>, <nmorrisson@phytec.com>,
 <upstream@lists.phytec.de>
Subject: [PATCH 3/3] board: phytec: phycore_am62ax: Update Environment
Date: Mon, 28 Apr 2025 07:49:04 -0700
Message-ID: <20250428144904.1058574-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250428144904.1058574-1-d.schultz@phytec.de>
References: <20250428144904.1058574-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|DBAP195MB1002:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8d7e42-0461-4267-0e76-08dd8663de41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ni3HwT/WnFd+Wv1s7wJ8dv/tTOeDgCGprylpF6Xn4+zgwSKoPogZjslWHz74?=
 =?us-ascii?Q?Z7EXv74bMtu9zO9yc612G2oXUJaS5Q+gQzg9jNcceRLVwv828G2kIvY/VtKE?=
 =?us-ascii?Q?BItNHn2xFqEgoDSXr9a9vEt4IdbfnxJH8196APnwTJm1vfcuhtkLb9j4SPuA?=
 =?us-ascii?Q?uhVoT74bXMJoY67i6Qr7ctK/ioa+w4TI3ASR9hlRfPzVGegf8kUqneuiWiMt?=
 =?us-ascii?Q?E5LKMS0utVGVWFodETirDxsWE+vkKkUdva7S+537Fur8pKjS9+nG89nQP5d8?=
 =?us-ascii?Q?HZ9z5aG5Bxd+kEtaKThGaBhvrpZqB6BMXkTJdt2wOdF7Whtdp7HbchBQKjSb?=
 =?us-ascii?Q?TScNQohM2OSJH9Jm4WKf3GQNi5eJeKM09EZVGj7mJ2dANQOKBeIGSNYESbCo?=
 =?us-ascii?Q?+H2H4tHp7KHJ96eSZYske0TpAwBMs9a+OIEobF5hZktkNWBbmbQPAh5mo2ji?=
 =?us-ascii?Q?8CcuES2oWEPhQIFBoBnm+P+YpFqX2vsctnWqImlGCSCH3xPbHkI8m86b/ZBu?=
 =?us-ascii?Q?plFwW+HIpa1PNgpoAtCn8ZxGvO258T8CX8apOmIX/mokUwtBV0tK0Djxiir9?=
 =?us-ascii?Q?Ezy5nms/eAVmoZSB+TWONbtxMNiT8Rwc1rPzRKbmSosGbbohJADa4/70gEdH?=
 =?us-ascii?Q?Ad9cVfxvIof7LVNavDWbUkLE/xmhR2BU3BzY42oB0tajOstLG6up9XQ9Yxnb?=
 =?us-ascii?Q?w2qVKmyi0pVBYrzLCdprcRcKKMOo+Y4aHegnl8qn7vAKTL4mcyReiRLYpTwR?=
 =?us-ascii?Q?meruETFa7gDMKn40VkSl+/vs9V8CmZ50vT7uGdMxo/obHxbrOdASy1iQWJX7?=
 =?us-ascii?Q?21fGPXVKeu7oBMa3DJfFyzyQ1WnlSCA5BhxT4e0KqXbdRXS/rvPO+31vFe50?=
 =?us-ascii?Q?+7eu4RLROOcp/CVhbovbRqiDmdQveCT+f3pigC5mY0hcfcN624tdKMVuocx8?=
 =?us-ascii?Q?PSafbBi3MQyIRguHGm6lBteIwReHR/gJNaev3iD8lXSVowz9Jkq1RMu4mu+f?=
 =?us-ascii?Q?hajCk7gNA7w/DaJLNicICFHOx4BPet3/zCvPnRG8owA+SVyVwcXhjS43Q3hb?=
 =?us-ascii?Q?Fw6UxwoujMyBf6lGM8A4TjcCSFFWxip6sng0w9D090uNgx0vheambBtZLTfz?=
 =?us-ascii?Q?ziezrEGWilVhFINrx4qJiMQaULRJxxjn8fkHdzd5etL4LdnE5XJCLBZwHjkc?=
 =?us-ascii?Q?gBMybo9qvBc3lf7TW6PIDug/VY3bPU61mqG2+LnCWVd59eFk+D1CQkG9/jPs?=
 =?us-ascii?Q?YsfVAseiBjdmao1Oox+sGXE7LQH6OXiqUX5yE6fYrHl7pQZX6W5+VdOCVwnb?=
 =?us-ascii?Q?T86RtVvulMPRhrcC/7G+1tRJGg4vTSWQ54AogFICG+oXy6+KZ0rUs5aH6Trr?=
 =?us-ascii?Q?r/zVd8DFPGGyl0vl/LB6t3ngKXlBdSktU59TE6waF/ZMvpClLD/cVTpFOt90?=
 =?us-ascii?Q?RZW/E+P/HG4YYd4ofVDSyKZ23Lxgwkk5X0iODPAA18+3kaY5BKKPAEOmwRoJ?=
 =?us-ascii?Q?gjv4ukm92vxvwggRsYK+9lcmbJmMT2opXhNh?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 14:49:24.4479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8d7e42-0461-4267-0e76-08dd8663de41
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB1002
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

Add fit_addr_r to the environment to allow us to boot from a FIT image.

Increase the maximum Image size from 23 MB to 26 MB by moving the
initramfs start address up. This gives us a bigger ranger to
provide kernel images which are not stripped down too much.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62ax/phycore_am62ax.env | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
index a0eacd1dfc3..40787b0cbcb 100644
--- a/board/phytec/phycore_am62ax/phycore_am62ax.env
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
+fit_addr_r=0x90000000
 
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 mmcdev=1
@@ -22,4 +23,4 @@ get_cmd=tftp
 
 spi_fdt_addr=0x700000
 spi_image_addr=0x800000
-spi_ramdisk_addr=0x1e00000
+spi_ramdisk_addr=0x2200000
-- 
2.25.1

