Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55791C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C04E806DC;
	Wed,  5 Feb 2025 09:02:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RwGJ9mgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F74280819; Wed,  5 Feb 2025 09:02:41 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DBC3806DC
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhA8G+pfk6lflfHGks3HQMyTm9Fj645r3dpWg3K3kro45pIveGCz5Yk+L4WP9AJNdMaz3xCKNhxG8vcAHhG21L+66VyE3AzyKelSqnFmFJK8qsV+QxR+Wi9Pi/9lwqYl4Gqm2XtQQNBgLtnJzzMRyhOsu04H2/xLBRC+TxD+cObgediaHELcbblesHwCiCeomIoXFl6B45M0XlJFOXoz0wp5BtJK5/j1NaVuPo1vCq00QOxntk70xnRO+fgg3zqBo8ypiiFZ5plePlq/vonh/rZEI56iY9tLUKYoP3LZU4tCiimERtRXe3Bfn0aRZBdm39E2zNfV0jGPsxXvk1Nqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cjClVNDctIVFgE5OOnp4DbJl7C4K/TP3HvgZZb6Thg=;
 b=kDWyOCULuHDnJi2mUWIFZTxmG05hdsPIYHa9R2NgBZDx22UTeN41ozv1FRStcoZuYkSxAe67yVr+0RIi05YZbchXOBUMuxvivjEkECd9F5VNbLpCYvB+cheTZKLx4C26BwtfRU20zWWMYzTofvFJrT0pi/WqxWjxfuJBnZPcbzSF8msy9GFM9vf/wpTZZ/l1jG8tq384V1lwTtHICMAQ3zmVB1tQ4Zb5xqcSgm/PoGXbCBHCg+OHnnmxxr6gxFlxeVVd94QRg7sd61Mm9pxQkSWNV1FnEJlDZ5eUeVcHIzBhSjMh6Ge4AgidaE8oEtwY2ZirolQWZaIlZqw1AxhIZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cjClVNDctIVFgE5OOnp4DbJl7C4K/TP3HvgZZb6Thg=;
 b=RwGJ9mgPIHQL0VY/uAs5bTid9ZYbOuu/Tna594n23cuhEnzMeW0+bf7/5lNWh/wJTqrsW2h+eZUgprm+tcZRDFYea3kKdJ+g/Kg+G7JtOHgetseVLdiUrXEPTRUQKwF+rDU5DTd87OD4c6o14GOfppl6ltdMGs632wPYOfiaZPWvZm16flyMaALQ6IO4dA1tvTTZYdYeJz6jZ5fW6qkf2i/tNcSnQK7Lsqf5+E1OjnQ7GjQbOE6pJJBOEm56ydSWR7h624G2eNJoBqlToasWKjrueE4fRVP6GmGTgLfuQuuWhRMIP4qaArZStalfihdrcSG6DZwMqhDzt8DYNYWmoQ==
Received: from AM0PR07CA0034.eurprd07.prod.outlook.com (2603:10a6:208:ac::47)
 by DBAP195MB0921.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:1cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 08:02:35 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:208:ac:cafe::d9) by AM0PR07CA0034.outlook.office365.com
 (2603:10a6:208:ac::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 08:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:35 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:35 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:32 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 09/10] board: phytec: phycore_am62x: Update environment for
 fitboot
Date: Wed, 5 Feb 2025 00:01:45 -0800
Message-ID: <20250205080146.1944928-10-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|DBAP195MB0921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df5ae15-5944-4e22-29de-08dd45bb73a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7jz9OQ59paFg2E1xzVFLHWQ0S0O1OIuvNbjY2/0iynY5JwcnNI+UsYrjel/1?=
 =?us-ascii?Q?yQR+iMs5eTtBeiUa29e+NJ2KcTLhXp0q+FCFgASM2LXGif1gnzYg1OyUmbih?=
 =?us-ascii?Q?AYcLPpTk3IqkXwndyAXptRkyNMiKlNf2NP6CNVU1vwmqCNRUuUaFGIZQsMXO?=
 =?us-ascii?Q?TdFp0SItmQ1ZrJLKpct+CO9zsr8vcjZ2p5zke22AHm0EMZXJRvbNUKUakAqv?=
 =?us-ascii?Q?Ozkk/jY71WG8JyyFyLJyoZ1idsapCunqk0Gh1ngs1iXB/dspqqYHBZoNN7Sf?=
 =?us-ascii?Q?hj6NUgUw0cPaIjd93n4v08/kzjL2/YvMHb/Uu2CA8hGDL4ZjRj6PsJBVVnM3?=
 =?us-ascii?Q?4A0rAaCIS43xBy4QptWNH++GZlC2bNvYYl9MmoWlaT8XQIg/0+a2B6D5uU/w?=
 =?us-ascii?Q?7kSCosLr/tmhWy4/xcEWuRI/ThhpJy+hWNVlKqnBaggF8R1xQNGCzYVm0H7/?=
 =?us-ascii?Q?rhk+OYXd2dhT0a8Bt3SM6Kl7h67YZ7u6cdiu4yK7GdbJ9X8iE0Q4HjZSAfBa?=
 =?us-ascii?Q?5FdStsALAw9UcxaBPR6JDo3K13At5dlBIim9QrQCx1pP7SmJb5lD/Z6kF8tA?=
 =?us-ascii?Q?aFNzQH8bv5AYITN2Fcq2QY6TQ+9a6F5fp2O47+vksinQEYIwvdzk6z89U4eA?=
 =?us-ascii?Q?1UPOZwr+vnZZV63vBskzkzcuX16hj1IsSJktSBABmVUXsCn6nq4XTYGa7VDZ?=
 =?us-ascii?Q?hsRvG8g1717pcbVWKr85U+6Nb+PaoSAIXCQ1i0S+cq0GIt79KalGupPz3D93?=
 =?us-ascii?Q?0dwnDnznSaJYbdLCsKHmnKtyOOarPQOBsDCHbH8lHe9dbl705v4PZJvYQRSs?=
 =?us-ascii?Q?VRbXGpjICLMT1vghSku5gain3GsQQjY/A6cH+Ao3WFQQiSJqttuFMhOvMjpc?=
 =?us-ascii?Q?Qs3hgctv9T4obI3n12T2jJ3oKI4C9rUmXUfz5HBGn+Mgg09I1QUV18Yiy/Zw?=
 =?us-ascii?Q?uL+RJ9Jj+zBClF00gZGb62NpPiWPI1DO2X6MPlUe47K7RGNx65wp43r1dwJo?=
 =?us-ascii?Q?FpWvv3n12flZRixub7k39d3KG885/k5p3Bdte3MnCLMBW0W570dClffjlSBC?=
 =?us-ascii?Q?AdklYXo9NJZRkgsdHAZxP2wF2vy+8d8b9HrTfsVPZ6t8UFPftf2SM4HbEVH9?=
 =?us-ascii?Q?SzL0TNCPdRjtKPq0r1FLFTva7ZVjDE2QcS3WLJDezgAX2DcCNW4gz71br617?=
 =?us-ascii?Q?a0xY+aGDIa8xaPxuLYME+wjh3En0MakQ7uPeffPxsNiZkhrHPMkTcJGob64H?=
 =?us-ascii?Q?MCaw7nEJGBPHZbccWyCpeDfbPuv6iPIYcTR8FQXABYUPEmb0r/xIbHAyvnLT?=
 =?us-ascii?Q?uFBKLyAeozQBzRxEKfClNVE8nFdU8pJSk9FPZAFHME7rrl9LEOcD2jnSRpoA?=
 =?us-ascii?Q?NakN+x3k40QOWgSCpSn7wjKUFun9K0evFTf0YmHsjNhaS1WLajLRa27mFDWC?=
 =?us-ascii?Q?zvHpbfV49YJgroarldZHTHaFH3SPa3tg3FcVmYxOpHGQ5GbIEqIOmVm4ZEfu?=
 =?us-ascii?Q?H04CpbFRiCQdNIw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:35.7505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df5ae15-5944-4e22-29de-08dd45bb73a4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP195MB0921
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add fit_addr_r to the environment to allow us to boot from a FIT image.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 711ca3040c4..a5160a1e56a 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -10,6 +10,7 @@ fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
+fit_addr_r=0x90000000
 
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 mmcdev=1
-- 
2.25.1

