Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC19CA0FF0
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 13:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9026830A0;
	Tue, 26 Aug 2025 15:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Z+7mDmEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1EFD82DA1; Tue, 26 Aug 2025 05:05:29 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCED7809A5
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 05:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwqVJJIOd0s3eMH+kLu8t1KVJm6Zvwliv3wiy7xWLzEw7ONQckqlpc4bocjaDW29N9fM/vnBzUzCyD8QUXEPGM7N+cULubpk4CweCP2jZTacxWBP4QEi1FUhlR63HPQ6XnQb0UdEvsgqBdC2nsDPxe4NddRaQ94fTOu8L8fDL/xt1NqiuQlniE2lpqt1edMQDlqtQ/X3SFPuGap49Ji0xPcAR3oemGSrOjkNXF/tBkdEysqyECDOf3T8cVHyirmYLykERjDe7JPX2wuiQ6aQICuD2gHErvQCYDGXtTDWVPK0Itz56gRWqj9GQlAMXgjyRtEROGIVxSufDNyVmCIpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4HJvVN0JwNPAyENzGVUidO2zaN3CDFUymDAZKVnGG9Y=;
 b=SzmsoFXD3IT7hII4dXasYs4HJs0LBxagK4QXR7AJg+pNLS42tBl2l56l0WtYQ3WpDlWgfOOw8DqUMSOREsCsdQ1fFTXmT4jGC8Q4pQI6ke3Hfe/fUg0sX0MzYlk/0chC6Tzjx6zwUgBMU3ZocnKr2Ws0hMMXAW2w6qf866XUFyUQXSzE88YBLyivBskIl92mqluRvp9L06v3WdKA1kqRGK8cKUdY3+XBbW1TJzoK5ZinGln3BMuHxaKx5LSMV65rQ3qDK1W5vr0xG7Ao4QrOHQTTMbQEqsJo3PdAlLXUS8HNKPO9zAaOXD23LsTQlpTgwI4VZ6+wBFY8Kki6MHxlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4HJvVN0JwNPAyENzGVUidO2zaN3CDFUymDAZKVnGG9Y=;
 b=Z+7mDmEVo1hC8mZD9cZGApxEBKc3jIyRLowfrX8RRptHCulcb8KWvky3S+Y3qSe3VBv1ZtNoe30af28Nu0lAT5id1xabRrkHx5uMo4t3QsRBafHgjcMmnyUo5kOGEmw9SjlO0SsrLpE4dNrZClvqHTY1BU/oyZVDxHjI6DYAPu5Jur9XEgPPNPAZFPK6kztLdpXuy4nYCLNqI9FwADMBd9YUl8pqCd7eVG7OBSJ+7FKVlRVlbSdE//kR1L+SzBxjKAOoLc52IkKhdWNnogopVZI8URSqjInQ/UuKRjgh+wfVs9rt9HvR7FsYJP3c70uCAoyhF6asXVvEsSk8atWUuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.12; Tue, 26 Aug
 2025 03:05:25 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 03:05:25 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Boon Khai Ng <boon.khai.ng@altera.com>
Subject: [PATCH v1] MAINTAINERS: Add entry for DesignWare XGMAC driver
Date: Tue, 26 Aug 2025 11:05:05 +0800
Message-Id: <20250826030505.24964-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0238.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::33) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DM6PR03MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: eab2a096-73d9-4382-9bab-08dde44d66ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XxFb01qeD2LlhCqEwWysohjY1CNKe2N4EtSPGqDmH+UpiUrVerJ+VPDR7sff?=
 =?us-ascii?Q?I3PTA9x+GY02ylgx+WUnTrlqHZP9ezfudLBgpmwqLUPOqTBv8zuUY6MNQHmj?=
 =?us-ascii?Q?vPhpzouFb2vdMbijUBnwpGIkICBF1WfzrdT2l+Da7rLZKpvxK3IdTH65jmsG?=
 =?us-ascii?Q?vLJKTLNAOSoWY3SF0ZEAVgpIgbL3OJzcjbbGNRNxSuIrW13nmyl0RtKYNrk+?=
 =?us-ascii?Q?9gVUXtn7Hn5bP0lL7VV8XSHZtgk/K2DPfckKetRQqN+8hdZ+S3ODCxcwSw+q?=
 =?us-ascii?Q?QYz6L/78mW11kdX+FMSdaeBwnA6bbx2owAYJeuShxyJiyCduL9R6e6v32LsX?=
 =?us-ascii?Q?T1rvoF3O4KF79OuJdRybF0tZiwsASCeioI+voae7rCHSHN2nyAmksc/K9Jim?=
 =?us-ascii?Q?sBghWqSA8+JaYMCd5Img8Ygf3o0oqXWO3gGbuKhw2Xtj/u2u+7+4/ttmz3kO?=
 =?us-ascii?Q?gTCwpsXJ5cut1XfKoaRizlBwBxy3UcTy+sw8cu291cezR89CtTXgHP0oytjl?=
 =?us-ascii?Q?9CW944V+pnbajpow2MWEOybZ3rjxxOiEhM3I/0qHn3DFcxF17q1/3uE47aoB?=
 =?us-ascii?Q?ThWQXXipRO/DRspZa4dgiuAVem/BcDM7NO6W5Xx+KLFK8dNMcjXjaRbhwPHb?=
 =?us-ascii?Q?ATXLPp6IfeveAyQL8j+Im/nqZJ0LhDM8Uf2Y2oLMjarWErshSKROYvw/U3ek?=
 =?us-ascii?Q?A2Yx5VAPIdBReXGhSVGGMT3tord77uX8g8FPyhLxzOFxh9tfxSh7n1u8aLRw?=
 =?us-ascii?Q?1l1z2ICDwV19anuYC0qexr7IymkE7mEL+oejO9x41kHz+CGknu+PDyq+WOWK?=
 =?us-ascii?Q?22jojFwXSjWOxllRO4h6etxuNAXo3WwDQxertJg15256gHGHgMesHLVvCJEN?=
 =?us-ascii?Q?w1ip7MxalVfSfRNtIMcRizp8490uKh2AQA8p5rNfXuytCULQvxfcnlKIVrES?=
 =?us-ascii?Q?8Qj/WIVFJKTUTtCYOMwmLW0/iRNpvRDI7tceipwC2ix/ST86CS4g4/Fbgcm5?=
 =?us-ascii?Q?NSermGjyyPbZFIqRP+PuAU3W5reS2lvr+/RmbM9e8UzmcarKsL5zxBHXvX2t?=
 =?us-ascii?Q?jiYTBkxJ0yVuHt0Yf424qxBAOvCXNL9jNs3QqDDJefREOMUu+dKtnquDy7Vc?=
 =?us-ascii?Q?XpRznhxkY9kKfzAQenXC2ZcJ12VvlzHD64QJGU5UnxbC4k4E7whQMQ6yGclF?=
 =?us-ascii?Q?TqzMDmqJn2vgETMghJN04g/rpTxISVpG5BL1BxHbs2y0ZRsUii81++6fq89o?=
 =?us-ascii?Q?R28FbMpaZ9UbrQR2lsmpY0pmbOeAp5pywrBEwKvI1aAzU5PxEmikLBUXQSHJ?=
 =?us-ascii?Q?PHxBZPQKNMXYKiUwHRpGNSHNeRCqbusEMPm9v1xZdhYrvP18mDmtM7Xg7roe?=
 =?us-ascii?Q?KS9tCYolzQUPiA2Xrqp3FV12QGN07Y+kGoCI3uqsuwDpr46DuThaITNCIQCq?=
 =?us-ascii?Q?EFOzh/v9b1w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?16qiWlwh9yzJVVa1dAfpgDL4Q/s7YRwjblhAcuv4OMWEtNSMhEtA7SV7hTeM?=
 =?us-ascii?Q?Pai4SoYvfyILAKgZD5omZRNjtsH6QOFl4c3rmmEaNMAZVWucnIGX2IEXoH1k?=
 =?us-ascii?Q?uyw0ZVhCQ3bTgPCHAl17EjNZKYZx/DQtRzQDCveTP8S8BGlDlraaRc0/WMDQ?=
 =?us-ascii?Q?3ooOVuISSsDtUAA8CeMwTlxovgzMBBTxndaWfAjfq9jMxe/GAaKAhlDKLYDo?=
 =?us-ascii?Q?psyN6V9DBN7EeKPkUPODnGyZvCD9BDXg/z/TnGyXkYfz5kMbYJgZdwqkZomL?=
 =?us-ascii?Q?26eoLY2jIkZDpMpSY6GWFaFvWooLj6GL1PbF2VKphOEzYiR0gEvY7ojblBy0?=
 =?us-ascii?Q?wvjpzrF93M5sUB9p0PYvtIuhvQ37QUeEKU6erhG2vSiJApXonpC61rDgXvc3?=
 =?us-ascii?Q?p0Efr2Fvpo4ra7QdsccNtd3f+yusOWM3rV0URXZ063HdB5WFlu7k8MQ0+kEc?=
 =?us-ascii?Q?aB9pBqYKH/uV6TEtJRKI96Iqodho5EBXiUEi/OzBbyBnq0Gr6R5788w8gdYH?=
 =?us-ascii?Q?3mEsttHZ+/SFS7SRSKMf8VPS4h1su/TBQCtetanoWpGo0vcPlI3fgkynPRBx?=
 =?us-ascii?Q?o12hgf3aORd6m0sP6HtKm1Gj1cYXZ1ngTc7mt3JTB/M/2Qo6DPjIqdS4vJGw?=
 =?us-ascii?Q?MjoIwf+cG/v4sOozGheheLWqRNflRwJLDKMrYIFmwIRZ1r3ssZLW1UPHMsy/?=
 =?us-ascii?Q?PMKuQb08A3fYmUG4dWG2SctKNzRi4BWuzTDQzSFrSuGZ/ym8YmRXQQe6Y61y?=
 =?us-ascii?Q?0855dTlbavH29okc/INMQd7BrAdZ117SSjJIBx6VdeNC1ToZK/XRoYQ4jlGU?=
 =?us-ascii?Q?lfuO/w1wQ6i5O0nZB7OPQ8sxa/FANw8BLyNIvxE3NBPRubFlPxldxMPreHt5?=
 =?us-ascii?Q?tjwrYZpcu2qze2mPNvQMtBQlWpw5bjGExqVsGs3ULcl7UmoWvpCihmX3bFKH?=
 =?us-ascii?Q?mVWgRBI4WVHZjsUChqG5t80WgQLqY6Pi46o3kS2EK/BZE9qTw7EjJnMj4Ero?=
 =?us-ascii?Q?WFUefdwv4rrqImHEVAxitKjDn1kRnjnrjm7qciXym3qQTAFBVXoPnhSoQz3S?=
 =?us-ascii?Q?afht3fPGfuWq0gUIGVIPTl7hC6RhrEdrHDiHmNOO9QIixstSuqfE2pgWcrLy?=
 =?us-ascii?Q?Osco/Z1U+cg8m/puuKoogUC/Opa76m7pWAn5P0ZbCE4Ua8fILtKcM+A5Fw6i?=
 =?us-ascii?Q?meAg0pdJhginX0FQd2B9Ni73Ip2GYEAZ8D+bqOAD8gYs5u4YBfXZcAF2S2Jl?=
 =?us-ascii?Q?svyUztvKQtjdZQxwmx5yROM/ZXLI0mWqCdz2mh13xnLo7eFf2ReNr4vqmr9Z?=
 =?us-ascii?Q?hay+N6gc3V1AFRj8QwWT0wlnMGirZa+Qk8+IYIFht67UESy8YwNrRBKSzWvH?=
 =?us-ascii?Q?ofKxeCy/kXsOBMw0xEIA4PC+TraoJ/DYYhAnmx6XUuzNDkDAyaBk3wqh3pEo?=
 =?us-ascii?Q?Ioui7+oEdx5zHkzcCqefmtfqQyKLdtHnOykcvpkMd8XZtdo1kzGMKQ2JIWKv?=
 =?us-ascii?Q?E7oJxZeBbhY02pTaLSTChFG3aTy/nefTP+4PD94ijujQXszDYqUHpmf0eVPc?=
 =?us-ascii?Q?/vElCV3f9qDwmpAUMo2mLa4QyPejMd706ShgEhrcsTV1jfC35eI/kzDQ/tkt?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab2a096-73d9-4382-9bab-08dde44d66ee
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:05:25.0150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tieGMdsEm2cpTH7hludsuGZevMbPlE6+7cajQZ5SiDjbyWvazCbvPVclMzoOiF/DZmRRePDsN/6VvVUnvsidbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5196
X-Mailman-Approved-At: Tue, 26 Aug 2025 15:08:40 +0200
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

Add a MAINTAINERS entry for the DesignWare XGMAC network driver to
ensure future patches are properly routed for review and support.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 drivers/net/MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 drivers/net/MAINTAINERS

diff --git a/drivers/net/MAINTAINERS b/drivers/net/MAINTAINERS
new file mode 100644
index 00000000000..fd002295d0c
--- /dev/null
+++ b/drivers/net/MAINTAINERS
@@ -0,0 +1,6 @@
+NETWORK DW XGMAC
+M:	Boon Khai Ng <boon.khai.ng@altera.com>
+S:	Supported
+F:	drivers/net/dwc_eth_xgmac.c
+F:	drivers/net/dwc_eth_xgmac.h
+F:	drivers/net/dwc_eth_xgmac_socfpga.c
-- 
2.25.1

