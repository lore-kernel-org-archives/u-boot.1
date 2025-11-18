Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AF3CEDD97
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:30:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7292E83DEE;
	Tue, 18 Nov 2025 15:30:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FQ9IJ0it";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0315283B95; Tue, 18 Nov 2025 15:30:40 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C8DB83C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYB0nZbPCkRRaykp02XavOBXIyFvAli4NlsQ+sURNro6FSgrieeqr6KKlez62irj6bOdjTHIi3U7U2qBkDhuFnHaA5KhZzqhUMc6qSKgxj0ZCjxez+EXSGQomiV0vLNr7fR9Vv4DDDgTqXSCfUnS5vC6/OXzhQne7Ds5uCSAn4EfsgtAbEvTfUBgp4xCYqTpnuciKeFsaG0b1B3UaIYTLQ9ftWnZ5QQvTSzZkixStavDvI2eh9Kw8MHR24TgjzZ29lOPk4KQH63GCTloaK1AsrYnGRwPqHbveZ0YcHCpqLaNlSjSIyXIr5GZuMqEPmv2SbxKQNTx4wTfuo6VqIOjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOj3VxDa8t5hOX/37joAVaEEq1A7lBgYp5F+meNP8wM=;
 b=M9KPSZdDLwK1KXgTDJyk3REnXHymxx+dd/GiZuC37wiMYmPJg66QdQVdNqTKSy3as8i8aNrXTelR9But+OPAgh6Mnu/lpkOnrSnP65NS1EpUY8xL+/NdyInqlt3AZI9pe6GZC8BmPtPywu0qkfjDD+wnm0AqbNJ/rX2SXGUWbLRCUNYgMz6AEHm9QKlavqjdK7U3K0qkZC7bvpZe4/MZq9/oevwf23JoEbnnNe+WFNbDpEUFnU94/O2tFluPVMxgbRiYU/WbPIdJDbOFPBAHuYaTIdh61kOiES68iv16swMVpZfOnrg46BvskdgWASw8ESCBLsy3yvT/oYTUmg5MBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOj3VxDa8t5hOX/37joAVaEEq1A7lBgYp5F+meNP8wM=;
 b=FQ9IJ0itURACXqEOxXLm+lu+4moiPybWwuPDne7pcR6pBcxcGoyfDUMY++MQO7BCHVjDi6i7jfo3YgS9yQSKRY8NOL90LK5vwTI6wUwOeSrw0OhpKYNTla75UM7/haNTIwZdkiWRgtfVeZM61t/c+yNiYC/rB5Ip4D8M450QPv/ePcUtnxno/jiPnTzfk9CjjMi4MITHBRdZaXm1fmqtmtSW3CSc0JxAqdx7y9gWM0JUjYuy7wUsMY2TwoRiply2fMt/AKZhKT7A8s+wFmzu1xPZeGp+2rvNIm65FSlfyasJO81ARTHYR6QUxgTLlPOUp2M/2CZdLLydhsFEY6mqZA==
Received: from DB8PR06CA0047.eurprd06.prod.outlook.com (2603:10a6:10:120::21)
 by VI0P195MB2651.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:258::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:30:35 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::ee) by DB8PR06CA0047.outlook.office365.com
 (2603:10a6:10:120::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:30:34 +0000
Received: from llp-anderweit.phytec.de (172.25.32.82) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 18 Nov
 2025 15:30:33 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <m.schwan@phytec.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <upstream@lists.phytec.de>
Subject: [PATCH 2/2] bootstd: rauc: Only require partitions for one slot
Date: Tue, 18 Nov 2025 15:30:21 +0100
Message-ID: <20251118143021.1757423-2-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118143021.1757423-1-l.anderweit@phytec.de>
References: <20251118143021.1757423-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.82]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|VI0P195MB2651:EE_
X-MS-Office365-Filtering-Correlation-Id: 841a2732-41d3-41bb-1b92-08de26af093a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9lTu1W6stzzZdsR3GtbSDUS+ackLDzJasUOZKKVvchAObMarXDHjbi1JBw5R?=
 =?us-ascii?Q?O7BeQDLt6Uy4jNq/AOT6MM4G0j8zI7dSoUcMvrCkCnHbKWcKpH0WrWKXrxzc?=
 =?us-ascii?Q?hbvx4J9rrhSe5JvjNRuFGXDhPpV5dhO5ElMfxB4BDo46gaLPg8kwaKJbEJ2I?=
 =?us-ascii?Q?a5oJI7lz7K/pEBB/Nql3SCZrzJF/7Qz6rkOfKE9MhgqyC3OmzHkcyENViRVB?=
 =?us-ascii?Q?lOL40pe/wnaDMk4dXkS/nTtwnj6skpKqlj+h0mh5a33oAnC7Yi5QowI8y/k/?=
 =?us-ascii?Q?GBmS1se3sVvGLImf03FhfDJk943Sx9dNYocG7pWr69buSwoqMug4V7cXb7BF?=
 =?us-ascii?Q?Mv/NELAyAVYjQ9kolda3tU8PsTR1pgEvdr7pUvt0fDiR3sKeaqmcTjIAzej1?=
 =?us-ascii?Q?KrivctxBy9odH0o1wsrdOIYFbDA6Py75hi2By86puf6aPuUZ16iyyZ89bWTr?=
 =?us-ascii?Q?Hose5LklUG7X/qldKzWd7UetAAGJNerg8dryXIWhP75NxmAuDIWM6Mb0/cp8?=
 =?us-ascii?Q?S/Y5uc3kdmE3RXBkbX2bZq+Xap1hIZ4pNnquZ+OnoNHdniJsQVHAAgicd2nf?=
 =?us-ascii?Q?hTSmBlqmVg8AZWMwjpWRBSyDWWjd2YlmMgRfSyi3KWiHN7sUFvE9FlIMK6zm?=
 =?us-ascii?Q?+6UnN7RN1zyDc7GTKHofZbuyMAm05Ekwf6D5BTYlAMDI3/Mxf4rQ39yPe/RJ?=
 =?us-ascii?Q?DMf2L5E6+EWz6uKSyXiWVrH8hfkti4ffiRUmSr18oNZ3RUn8mib/q/Yz3brr?=
 =?us-ascii?Q?fZ7uvQ2d4BSAr7XiifeFD9vjEojVWgT1L+O2/HXcUvkz7/sk0gllO2+sHrxx?=
 =?us-ascii?Q?+ukzIuNPjRW9O5htjpxwDpaMAw1zAwQJo8L/MFCnvb8C6ktlJAzczVjv++1C?=
 =?us-ascii?Q?f5fT/yWdtS4QiIuIvQE99Bwl7s2V77GW85TNsTQPZZ30vdLpPBNevLh28MPe?=
 =?us-ascii?Q?/lRy6MqVSiWm8Jbut1HnD3fOfgVycusebMoGuwrZ3LpYIUi/AHbgsCUdo2wm?=
 =?us-ascii?Q?QTH+mA3ZZQmQc+oWN2GyBusFjG4m4PaTlBpoCQaDGVB1iGu/pt+ygRyw1X5K?=
 =?us-ascii?Q?iFstMn+pSlc+zs/ZightYIy62Tjt4+momGErJx0XH9DgfR0o4henoOg9wVIU?=
 =?us-ascii?Q?gyvsdFBdQS5KjRcVhw2gmuZ9JVc9F3sFpibxhntmY2g2E8Un/vIMBBFr7Gdf?=
 =?us-ascii?Q?a5+fP/ed4PnD08JdjWAMjWAUl6hi2ERhtyyAbEb2WvrCyC71WWtu6JuRWGDd?=
 =?us-ascii?Q?PSkCUz+Fox6+qkzCTqvjomvtJzu3tI6YBzgj5iUTlrdH41hbkx+A15UBJjpG?=
 =?us-ascii?Q?T0iY9zOtlFpYkSHzcVj+uHslclKNbtkTxKhXnIr3GTdhz24xciAhXn2rTa46?=
 =?us-ascii?Q?hZKtYOfHIGY4+zPwfMqkQ+zQvmQl8RxvpIuAoF/IG/FKWslxm7eV2XeWQ5S0?=
 =?us-ascii?Q?h4cJfuS03q9xi2Ax2q1UcTCSdkwJ+AaofhWSvT6h+I4x1Lbs/FsOs+OXNFRi?=
 =?us-ascii?Q?tPPumr9ylHKg+7tY45w++aHmFcWGjMjDZyGQzeQeo4Vz2uW6cIYHjtNuZJ2c?=
 =?us-ascii?Q?7p2IbiDaaDNr6mW3bxU=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:30:34.8393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841a2732-41d3-41bb-1b92-08de26af093a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB2651
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

Partitions can be become unusable due to power cuts or failed updates.
Use the bootmeth RAUC if partitions for at least one slot exist. The
bootmeth can then select the working slot.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
Tested-by: Martin Schwan <m.schwan@phytec.de>
---
 boot/bootmeth_rauc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 1096daedb5a8..833715e13952 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -99,6 +99,7 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 	struct distro_rauc_priv *priv;
 	char *boot_order;
 	const char **boot_order_list;
+	bool slot_found = false;
 	int ret;
 	int i;
 
@@ -120,16 +121,20 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 		if (desc) {
 			ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
 			if (ret)
-				return log_msg_ret("part", ret);
+				continue;
 			fs_close();
 			ret = part_get_info(desc, slot->root_part, NULL);
 			if (ret)
-				return log_msg_ret("part", ret);
+				continue;
+			slot_found = true;
 		}
 	}
 	str_free_list(boot_order_list);
 
-	return 0;
+	if (slot_found)
+		return 0;
+
+	return -1;
 }
 
 static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
-- 
2.43.0

