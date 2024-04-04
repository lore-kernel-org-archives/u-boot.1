Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75795CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 12:23:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CA98844F;
	Thu,  4 Apr 2024 14:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="IE+LmdLU";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="IE+LmdLU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1BA58821B; Thu,  4 Apr 2024 13:44:55 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D2A586EB5
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=petr.zejdl@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkyyHrbI19IsEDcCdLHgXZZVwprHCGH95X7+jMSUylqi01ZJE9aco9Xr9nzta/zXrSy4SsEwEO8cdQBAqsgJVO+haL5+C6QJqzNWhw1cizb6t0fsqbnG7KKSMiCcOidLPTk+DbWIvHYUpPi8COXNXjiz/Zf7Iwa8fhStEeY3RF58gmkpjlRRvLJk7uSHg0tQuB7ZRrSjNi/xtBPFw62/tnkw0d/OYic73JcVys7njNywCUG6RgkCKwROc9VQz/8z+fbU9YUorcNRAezLb6KtlvV8/MVR2Qm/+Fn6osieHnmgxeD5Mbu0TscbrUP0vwj73rtI8FkNWeOW1QPRr+H3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fda9aiBD7gohlCbenQG5MPPAI4z3xNq/lXs2f73RgSA=;
 b=ZL0imgaG/KQwd3fOQXnNBFSub78BOo5SYjv5u7neZ/S45Vtqh2xMdUOWVx3cduj5m6Z2CxIQgfHlWcqOKaYHaSuEc5GjqablJqXoKS0uvTcM35xYRqP2cMX359DvRaQPDBLaa1S/+CgcfVf9mGyUcb/o0+EXJ3NEp/UVlHwmYjx3XIK+WqamWswnfWHyibLH36C809Ke5IX2sv4cackawQ6s7WA/aa5AeEYGIEVPPGQSAWggADEgMAoFfnzpZHM25NoqAIu4ACLx0QFCSghify3yuBiKDqILFi+7GV1B16vbK6CoDQxbH7g5FGv2Bkjl1vcqTELPO3+OpXB+7pvLFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=cern.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cern.ch;
 dkim=pass (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fda9aiBD7gohlCbenQG5MPPAI4z3xNq/lXs2f73RgSA=;
 b=IE+LmdLUD7obutnMVKBhVjDGvjVhXVzZOWgT7eeVJqWiBtluy+jGnfJO09MyabNegNoOulKfnqWklJx+1HkmNdmQO9t8e+s4kUSBzsLDYcWRjqpE8TMHWQMeFY+Ta/vfXDICfduuqLZPo7ipOXKZ19tKz202qYxTMjeTEcW4KxM=
Received: from DUZPR01CA0299.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::10) by ZR0P278MB1696.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:a1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:44:50 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::63) by DUZPR01CA0299.outlook.office365.com
 (2603:10a6:10:4b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 4 Apr 2024 11:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7452.22
 via Frontend Transport; Thu, 4 Apr 2024 11:44:50 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
 by mx3.crn.activeguard.cloud (Postfix) with ESMTP id CA00883D37
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:44:49 +0200 (CEST)
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com
 [40.93.85.1])
 by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id F404383D21
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 13:44:48 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=IE+LmdLU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fda9aiBD7gohlCbenQG5MPPAI4z3xNq/lXs2f73RgSA=;
 b=IE+LmdLUD7obutnMVKBhVjDGvjVhXVzZOWgT7eeVJqWiBtluy+jGnfJO09MyabNegNoOulKfnqWklJx+1HkmNdmQO9t8e+s4kUSBzsLDYcWRjqpE8TMHWQMeFY+Ta/vfXDICfduuqLZPo7ipOXKZ19tKz202qYxTMjeTEcW4KxM=
Received: from AS9PR05CA0157.eurprd05.prod.outlook.com (2603:10a6:20b:496::24)
 by ZR0P278MB0893.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 11:44:47 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:496:cafe::b6) by AS9PR05CA0157.outlook.office365.com
 (2603:10a6:20b:496::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 11:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 188.184.79.121)
 smtp.mailfrom=cern.ch; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.79.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.79.121; helo=exonpremqa.cern.ch; pr=C
Received: from exonpremqa.cern.ch (188.184.79.121) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 11:44:47 +0000
Received: from cernxchg91.cern.ch (2001:1458:d00:65::100:423) by
 exonpremqa.cern.ch (2001:1458:d00:6f::100:2da) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Thu, 4 Apr 2024 13:44:46 +0200
Received: from cernxchg92.cern.ch (2001:1458:d00:6f::100:187) by
 cernxchg91.cern.ch (2001:1458:d00:65::100:423) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Thu, 4 Apr 2024 13:44:46 +0200
Received: from cernmx.cern.ch (2001:1458:201:65::100:11) by cernmx.cern.ch
 (2001:1458:d00:6f::100:187) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.37 via Frontend
 Transport; Thu, 4 Apr 2024 13:44:46 +0200
Received: from srv-b1b07-12-01.localdomain (128.141.22.62) by cernmx.cern.ch
 (188.184.36.24) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 4 Apr
 2024 13:44:45 +0200
Received: by srv-b1b07-12-01.localdomain (Postfix, from userid 35189)	id
 5891B400E9BDA; Thu,  4 Apr 2024 13:44:46 +0200 (CEST)
From: Petr Zejdl <petr.zejdl@cern.ch>
To: <u-boot@lists.denx.de>
CC: Petr Zejdl <petr.zejdl@cern.ch>
Subject: [PATCH] xilinx: common: Fix MAC address read from EEPROM
Date: Thu, 4 Apr 2024 13:44:22 +0200
Message-ID: <20240404114422.2905194-1-petr.zejdl@cern.ch>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: AMS0EPF00000199:EE_|ZR0P278MB0893:EE_|DB5PEPF00014B9B:EE_|ZR0P278MB1696:EE_
X-MS-Office365-Filtering-Correlation-Id: ba75f3e4-c6b7-46f6-0ab6-08dc549ca2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original: uZYE1F7xhSiNRqGjwzbTvULje5JBk912eS7k7GYuqyfAwuPmFjFQ4p8+hDu6t7TtlpJ5nj3SEtOshkqPPLONrPLub+r2SGFrXRHHVgAO8fvzdCv89q3xYbOsXZvHhJ2zjLiKxOy6uxkb92UDZCeidcGg7rTddQcMSdz5qx7x0KSNVbNoisdSW5svavSh2kDv4JfKm0kWgXXuaDwIrq1W1rhyF07vIV4h723ta7h+PIUHs5rL3/+Hj66SjKu7LBcEgRhuEdpCy8bZI4LL1WCCY6w/5Ic3DbUt3IMmZ1zqgalWXwrIvBWPfT36ukNOwvkk1CFAFXCSlYr0gXjASuoAKXqLz2gT+zj77X3ic74q9rsti+/nz4/MMFC/wLT7ngvrgS940Aex3VusWB8C1GiNdpWcfOuIDIKIWOocQkLcKRIlt7tGScRXtEmPoi6Ow5RVk8i86QEdF6sN5asNME0fACB+TU3N/x7JhxTCcrh36QRQIWBN2bDXUEJX92tjWNcexgax4E7+Rgd1011fS430FHDubrIrRqswcDjytAX3gbTzLKhMiT78aOOJ3bRXyqotkOLHjjZNuzpo/rTIKxeCR33M/98NtbA5ZZTYKVoQsojemOupfOOSXcV91OR6uw2KT7ru7s/LTTjWzBiks1ChHANMRm4oavtNy3w9YBr3jExgbppjw33A4DJeEp7XHleNCyF1tSaFA/eIXAuNjUD89bTBTCyiwRmLxjM2lhpmK/IPssxN8VBNJQDieg/3lAIq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0893
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 50aec4ef-3a3f-4e7f-4be8-08dc549ca10e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qd17B91PQvqrLv9OflyYaDyRn+CJCAMCytOBjozIlwfMO90opgQtB190fV2nsZDgsz4PnRAGGjqIgs/zqLbQ/ux1bizCC6QcU+uQ2wPN/gQ3Hrr+BulstZBNc5kwVX4V0IKhAjo1nuTEPAjKp5MucvlFiHHOH4KYaNCNCnv1bOIOpjzyp2B8GXJymM2cZ2sCQ77oU47bvusV/oJDTinOmVBp/UgqD2PBb4iF5bNCwEk924yOBeZ7zScmoRPcl8mFo3seDMqZnmnrwbjdhW0wDr04jNzAdjw+nktcChYmyiVxb2NI0EiU4QY/l2y+yL8oTAb7UI1PQMjkR7G2HsGDflgrAFwA/xRSqzv5wZuCe4aLhJyOugK4lLWr7rsuj0S30FnvrkYhSgSAymsg0Q67zcNAdcx237k6XB0FtezG5xHDFmMTRR2xWaeEn2gNbw3JYsouMxX4PxzsEGj82brZFhC3ao2GvzFAveylDhwAhE9BJdR/n7s8FZmyKpRvS5/Se+G8MyfjvcPOrDeiLAj9hb1q4OexIcTKb/RpPygaqeRgXdzRGjzJ/kiUctPqBqYCHo5i/AcpSK6N2yQmLpuuI2lbiPqbNcZsR2xjocVoBOpNhHGTeS6P1Q2TnHZQ8mCv4cNHs2rIT2w/WdjxvqB2g8QaVWTclrwHZaA0tUlSRhS2x97nNFe3YYj4kh/dVEDWMRYqVBBShvMV7b35QHk4B6vQ89PSPmbymOGIYVY7rvlNp3BS9TOqjj0QJGX3n60
X-Forefront-Antispam-Report: CIP:20.208.138.155; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx3.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 11:44:50.1692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba75f3e4-c6b7-46f6-0ab6-08dc549ca2d0
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[20.208.138.155];
 Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1696
X-Mailman-Approved-At: Thu, 04 Apr 2024 14:22:35 +0200
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

The upper-to-lowercase character conversion now avoids altering the
MAC address field. In the previous version, this alteration corrupted
the MAC address.

Signed-off-by: Petr Zejdl <petr.zejdl@cern.ch>
---
 board/xilinx/common/board.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 66edf857f1..49dc5d10cc 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -101,10 +101,14 @@ static void xilinx_eeprom_legacy_cleanup(char *eeprom, int size)
 	for (i = 0; i < size; i++) {
 		byte = eeprom[i];
 
-		/* Remove all non printable chars but ignore MAC address */
-		if ((i < offsetof(struct xilinx_legacy_format, eth_mac) ||
-		     i >= offsetof(struct xilinx_legacy_format, unused1)) &&
-		     (byte < '!' || byte > '~')) {
+		/* Ignore MAC address */
+		if (i >= offsetof(struct xilinx_legacy_format, eth_mac) &&
+		    i < offsetof(struct xilinx_legacy_format, unused1)) {
+			continue;
+		}
+
+		/* Remove all non printable chars */
+		if (byte < '!' || byte > '~') {
 			eeprom[i] = 0;
 			continue;
 		}
-- 
2.31.1

