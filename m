Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A30AFD375F
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FFE83FAA;
	Wed, 25 Feb 2026 14:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NOaohKkj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A6A83F63; Wed, 25 Feb 2026 14:30:09 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 845EF83F64
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=sparsh-kumar@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKruRGVghfYh9J2pacHDATHKQV+lQfLE3H/b01q8q2E7fnigNUjQMlzIUFMgiytEKlUuoy26IiolIqhF9itbpVnPaQB1PHUjzU8RlPRgFfS6oW61YBPx+DrLvU8Nky4zgVfFOz4uh7N3gT6DgyGhqz0a6HVlz9yne+e+EiU2qulb7UL0LaT3l9bnpKLMJeg8WcvH1FizGOw+4mqVyeCRHX879pH4x7devPmv5lhnym5UiC4mBU5Fxq2G4FpQM4+anwLKnYMKIvhImDs7mOfrRni0BWoMu5DhRKlwAcm7eXUrN1cKBzpx48Wa+05BZM81Pe8BKXOb40v/8qnW032FbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jUS+u4FoJmKbTFtcgxx+HzyS7dluBhAw8ylUdHyjr4=;
 b=McNGXNiBAgD+a1zDxj/HGTPjiGJyPuJoq6zRD0pUrYo/QoT+9B0vQFfT/3JUvV7Klb0jjA42i6v6hobsUGj6CN5JEVP5/rRqycQuqgsw6HTjyw6QS8+q0Y9Q1iy9QHfVq2lpyh64u+4y1tCi/HlLs8ofL/YAqRKVpoL0/Xo0d0KPEbBu/XBvDoY4VHbWSTQmBJu9FllhfTXV9jlLL3n/a4qzjtQagxBBrkGeA24T6YBT3tOrkxVw8bo01Vs+XugQjU2n6NDYOfXi5DRlmQv/t85RWIYpW0JlSBXxrhptBoP8WnJAtcse/x+82c2rxG1NxZZ8HEU7i/Fa8H1tbRLPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jUS+u4FoJmKbTFtcgxx+HzyS7dluBhAw8ylUdHyjr4=;
 b=NOaohKkjcDneoqT8X3LXdF5A9Eoef9PEtj08CJa5y075ECy/Ti5mmKKmAltzeM3EKNgqeRARaowNZ46S4+E+3ra/2ZSOWe6+3rQkg1UWO0XxvDkptsIqZimry6bnZH9znpwNVXwVtzWHSaOvrSM3+I1bQTFIEHfSAsOPy4Yito8=
Received: from MN0P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::13)
 by IA4PR10MB8754.namprd10.prod.outlook.com (2603:10b6:208:568::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 13:25:06 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::2f) by MN0P223CA0012.outlook.office365.com
 (2603:10b6:208:52b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 13:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 13:25:04 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:25:04 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 07:25:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 07:25:04 -0600
Received: from uda0510137.dhcp.ti.com (uda0510137.dhcp.ti.com [172.24.233.216])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PDORGx011150;
 Wed, 25 Feb 2026 07:25:00 -0600
From: Sparsh Kumar <sparsh-kumar@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <bb@ti.com>
CC: <afd@ti.com>, <n-francis@ti.com>, <vishalm@ti.com>,
 <sebin.francis@ti.com>, <d-gole@ti.com>, <a-kaur@ti.com>, Sparsh Kumar
 <sparsh-kumar@ti.com>
Subject: [PATCH V2 9/9] board: toradex: verdin-am62p: rm-cfg: Update rm-cfg to
 reflect new resource reservation
Date: Wed, 25 Feb 2026 18:54:25 +0530
Message-ID: <20260225132425.3096103-10-sparsh-kumar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225132425.3096103-1-sparsh-kumar@ti.com>
References: <20260225132425.3096103-1-sparsh-kumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|IA4PR10MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b4711a-ed04-4654-71c3-08de747149ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|34070700014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: 0V7ezzPCISK/QYERDazWmcM7rRkCRPsXCtUlffwDXg3Sbt23elc4pTH1Tk4UoZGkqin98ATg8/08a3Ur4uuVmf74y9akBeZp9gJZnrIK8diSRS+bApriGoUmoYxn1cdUnA6S705EE/D4V75Zf57bhlpv0Yj6eoWeJfxMhnS2h/paBVtzuxPhuSgHxzquFa8W5c07iPOROhdW7Fum06/rQbyABA5DmkWI9x+NhNIN+XSU8MOMpWNml1kmC5ASARXKoD6pbXkOvG6ayjZ2NCvqHfiQoPOBvX1YawRxXQaL7PVzmV4QXFRYI6gAnB8g7MJdGBG0aM5TaMpXpsMVree/jSrUe+xICOwEi2pdLCOOvRHml68hOF9nmNeMVreZ/jHGuyn0Z5ZY9x4Rn74SSgXgBx0u1K809rgrZ0bOV/UiBfj1JXkeepdZVR4/NTgzvusNPgyrU0eRktTxQjNgexz++yU8Jr0pRRcOIJqWel9qmKrKzv5eyigaIAbcXkuVoBY8WZ4DzOQgmdaCkYB7eAaX16+qAtnldf8VlM1wtBJhIumiy5pDzS4RFo3JQELbXCVnSGgHNXr7cBpbGHkHDrF3ogqFXbDo0IpNz2/jBq3tXfuE8zs4C/rn3btniNIxVc0t5u56TOFrezU4uJy+KlpzmTYsPrQ7ORTXNdESIfVAlTtdxQso/hNrDjxBWRY36Fy57G5TLzk5wfKl4P+TznXT5/vt5hrDAsTizvppUO470h/l+o9/BtH7CpAbfm/MaDj7EIKIC+T5r0Ql8OdS3Cjf/yMuyUDZ3ulRQ3Cqa8G+zfkXX/P4JziLJHQrmGZcxlx91IPxYk+6kw9u4W5R3wnjOg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(34070700014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iFS61E7nO3FgCuBKCRYRNLhsby+W/UWz6cHmgzKznf7j5BtsGRh9Q352OoF74EJSePYPtSfjw9hEKP4P2u2JNGLYF/s38Mo67xKWf/BhlSqtnFqYSGfCTUPKMP12c9rIXpl/9sQ38HfC/mw3vjMGF8MWn+5ek5D04sYhT10Lv0CyCLZjogSQnh4ui95O6k8D/Yy6lAPzcjU/jLpcPQug3MIQUGVcBWFYkXJ4T5cCTKAjRtTTD1RMg/HlB7nKnQkG8ufsqRIS2IT/5rMNv3EnJoDNTXTqxBpTTBWIUxOQEFqk0xgMq8GthSuKSqmp+guU7xftc4+4UW8Pb4MIaUla1JuvsXxQ7HN9HdiNqFkVQKuNqeqjxfMIBa70K+nOfcbER7EUFAz+M28V1Q8eaU4zjgETVwJ/KHqgUH8ddqmxWP/8DQ+SVW0htNBLrJKfN4eF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 13:25:04.8263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b4711a-ed04-4654-71c3-08de747149ad
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8754
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:33:08 +0100
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

With the latest v11.02.09 TIFS firmware, an additional
virtual interrupt and event is reserved for MCU cores
to DM usage on am62px devices.

Update the rm-cfg to reflect this new reservation.

Signed-off-by: Sparsh Kumar <sparsh-kumar@ti.com>
---
 board/toradex/verdin-am62p/rm-cfg.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/toradex/verdin-am62p/rm-cfg.yaml b/board/toradex/verdin-am62p/rm-cfg.yaml
index 73da85eeade..bbbb208eb33 100644
--- a/board/toradex/verdin-am62p/rm-cfg.yaml
+++ b/board/toradex/verdin-am62p/rm-cfg.yaml
@@ -567,7 +567,7 @@ rm-cfg:
             reserved: 0
         -
             start_resource: 909
-            num_resource: 626
+            num_resource: 625
             type: 1805
             host_id: 128
             reserved: 0
-- 
2.34.1

