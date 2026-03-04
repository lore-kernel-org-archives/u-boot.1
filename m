Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B371EDEC04
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 04:23:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D78E383FBC;
	Wed,  4 Mar 2026 05:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vuteXU/n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F351F83E7F; Wed,  4 Mar 2026 04:30:52 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005B583F7D
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 04:30:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6yGLouvNzRF7UJhPiyuMNZd1ike2Dy1NcGw0pbyRQNzzCs3WFS2YA5OQvhP8ydwkpc/xFagi80ipbAh/hFS5yXtCA5uNW24PwZVkJE1ol8CmvzyjDUEiFUUfDug9CNi4SuuAr4OAerK0eFleiMB/TwNsjHVYAL0NrYPc1SVZc6RrmArgKXmlXTmFeA+hegOPVhs0+RduRkN1/gGQIF4OkT7u7aWJkEF8varZMIy7Z/NvYtB2f6UeWGYa3iFwp2qqfs4abIhm1IfS6sm80aqITQm77KZ/fSjhnbk52YL/sSeoeekFWisRRhk2SaRcW6rbQfsWmihEPrp4l3jTybvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUWJfIVoiWFvSODyMMNIX5aQ6We9g7CKiVzpTQKX2Pc=;
 b=tQcA/5DTBXVxXKTIRL4HLlCgH/xKUDg54pDeRoxdqC+m50hi02GW5sD6ytJ3mufgRXYKcTtiy7/2ALAWLYU0CYicXb2+SlbzJx0PM3awN9vA2Owzvs6bf6GfyF2yfhiqg8QEwV9/+vhxEjDr8OX5ETBQ0RZC/aBjzlNSWCJpQst9c8K6MYERmKNl63bWiBPU1ElE1ef9w8jaR+rD2ETwObfGJokYVsR+TLOrFZErSzr2REkYWAAGIBlZAcu+v4EyvHDvSp5Od6J3SK/Yc6GWhRlRZGIa6fbjDllAWafqo2MFj/E2ZnRY1zdGYgKvi2Uq/IGxUNZLrm+XhIyOg1qrKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUWJfIVoiWFvSODyMMNIX5aQ6We9g7CKiVzpTQKX2Pc=;
 b=vuteXU/n/ZpyZZs9OimbuOpzfVO3GogpPw3VQL/h0nvihCtIc6jLjzU2HgFb7SQxBi7825KRbFX0TWaTu5LLSjv7UPota+xSXOwie3wB/yCcYcqW+b+WvadxqqQzqfEirZueypqtYUbGnx5zvXDjYalpOa11kms8bcByVWEzRM9q/xtmICoMBC4tm5mWnOvvJ0xGvnzJSRitcYdvQqQE9IDNWY0itsLif7Owb8/kAWwzHZ+ZBmuyIZDRetexVA04H0I5TdLkQCN6Pvi9G0aFbtYZD1NPKEA8vK10nakhJvOy8rQI0m6Iu8ijJ/OQ0wR74bdvT+SuJzqVY+w7HrmDfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB6605.namprd03.prod.outlook.com (2603:10b6:510:b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 03:30:48 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 03:30:48 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH 2/3] arm: socfpga: Add SPL fitImage config match
Date: Wed,  4 Mar 2026 11:30:28 +0800
Message-ID: <20260304033029.10825-3-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260304033029.10825-1-dinesh.maniyam@altera.com>
References: <20260304033029.10825-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: fe871cba-b0e3-4944-c6f6-08de799e6db2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: mSljhmInSi2ov7pO+F5R/BSZm8YPo9iovZLOBncD7PA737oNrXw0imxVr5UWGSzo3P9/kZpqfHImVjhVU1+vCkxMu9ex19ku5iIFoDTb3W00cITL0b3f4rHlmDIRPFyPp6HTiH/lIBRKJrzgsaHL33p6l9sdhKg2HWCse9s/D0PSws7UOwa8pGg9Dce1Z7Czdwcjb+4DlGDGo5dCVO03r2Pd8arQdMVMbhzisHcOKDmymgELdAnglFMJVRAxppcbI8hlwu7qOzeCR2N7u1gM5mAhtE/nPVR8E7DXLQnLvYXcJEz6NAp1PKnsLpdb3nQRV27aTcaUjh6i6EL7CIAmyhnQNHbHh88WFuzpQRnGf29di9r4c7Blpd69HIoqcABBUU98eohyAKz2//buAwfW5y4d3D2DBHIBBpYtUWIBB3mErLC8rROfnhYPHw8wN7fusceKI+NnekxfbDso/tFcgxRulEfZUWbRJdjgPkgcwMnMcKy+/UiIhEiTO+wzM4PqFsjr+hJ2goPe82ZF2LADi/ICA8x3naRhHTA2KlSXQjAmOThrRU0ivq32Rp7H2mxLxU8GrQhtbZ/LKWGjmpAFfXCV94ZBSltsjfMwekQhChKyQaTP4dD5EdMzVfK954AshobkB9P3rOTtfiRQvWbKSy8kik+J9qBU7aVe/TsuhNz1HQ9Rpb6b3TFc36Ehqoahwi+CWij3cYGKy4N3JfAs9Vb13SULTByCMCNe2V0MRdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lX8mgUbGPl0ra2z9RObcw86lxy30qqdvqbdgERgFz5dZlezEuY0U5PQZ9zPH?=
 =?us-ascii?Q?gG7kXLJnxvgETla8Dw0ZWeS2i1DGK5L6049YF93flMJ4G/kmJoueVuX/yx3a?=
 =?us-ascii?Q?5OSea0xOK0NdIafcC0qs9Gzuyok1dM726w48IdXbrut1Y3G0rpHmudAeMNzm?=
 =?us-ascii?Q?ysBulC5FaRPcN7rHkqN341KXaM6fWZFlPES75X2hS60psskGHGYvi0kUYnxG?=
 =?us-ascii?Q?B2smRAB/t5C+nosAfgS3b9840+JnRiEB2Obny+UmHTF6B4rmESSz7HB9zpMr?=
 =?us-ascii?Q?E6cxdZDPHpuWgECgmFeHnnp3D7XOivfsO94IAojOdUhk80wrm6ZLMBs3EVYv?=
 =?us-ascii?Q?Syv3LbIxFNCMc9dBdhlyerdIIxI8AZ3J3dPU/Y+beGeGXelmAZwn99nSlZsy?=
 =?us-ascii?Q?XnQkeZXxK5lEgyezDVG97bRT029DN/WQ7laEXuPMLi6jwhb9gY3qVUJNNzfm?=
 =?us-ascii?Q?P+w3l6x1VN4kHLxYnG4s9QlSZbyuwo8eG4XuTTlqp0cnQYf4auqVXr9jcvU2?=
 =?us-ascii?Q?mbnoUmc8r5xhC+LD/TU8VtOMXZlY/lmzbZVnlqWoGrsHPBh2U/pFaN+KM8kP?=
 =?us-ascii?Q?ZCiESNNnOnSKdQvx6Y8eAEiNMoZ8ujz0/DOE95Xy2U8NHxS450RwgxhvOLyc?=
 =?us-ascii?Q?5Khl7jqic0UahYBGxl1ZdYXHo1JNjJSMm3m9KuEMWZDeTTED7ddk29etQGh7?=
 =?us-ascii?Q?dISeNtwWE1vem6sKOYTSFen7wukDS6xe20a2toDbpkIfPznHPB2YnhwJyTnL?=
 =?us-ascii?Q?SHn2EaCa6ipf7v74fWZuCrGVLibRTVM0kQicYWanRdA4movADUqo9WGrCkbp?=
 =?us-ascii?Q?L8TyWeSkt8mNGJFHwqb9l+mlYd8GKiFhmgrBTRhQ0QZJ17PTcCt/8fn/XK5/?=
 =?us-ascii?Q?Ea9hbTmP7JHih7vt15rq/eX/VALbrjWmsFLWz1FoSASn2stiQmRX5f5vgdSx?=
 =?us-ascii?Q?8h4VjwPo4LoptsguheFOZatMtVbkL8qZS0mr8T0c8jJxOqB4dWaTFguVGtQK?=
 =?us-ascii?Q?OcQUTh/T7SjUqv2T2MWt6dvjPnSFbAnVvqRmEMaeC40qTd9OpDIoYlUHyGl1?=
 =?us-ascii?Q?IU6M+cqNHxddSgdSyKKulnY9CZuARzmcz6qT4dxNiD6wMcNKqWErQDNH8vWG?=
 =?us-ascii?Q?1ty0tAx3DpJ6H4pfCLE6FHT2RqwnTq2qZfGgxIQsRi3xaj28kVY4BtVBROFu?=
 =?us-ascii?Q?F2jZ72Zg2Ckff0ikeQIEDvQN29rWuwMGThxO+ktZHJ2uCKKplU97GBjtt5xm?=
 =?us-ascii?Q?L3cZekpXlRulAvtKu2i1rrkMhvf0rL1/2LoIIQ6zoPqyU7h1Lw2iKxogskpn?=
 =?us-ascii?Q?8eqZ5v/bivHh41648CDxzJpEqsYsJbX4f4Bj0Rd4kK+RF5+btBivnsrYjofN?=
 =?us-ascii?Q?DmQA6KMviQUn+AYXx93Yh7I+MjTtUSUTzQOvxqN0oTd9iw2kTLjkMZe9W70l?=
 =?us-ascii?Q?5GaFDbsR0XObJKoaFI0MKOL4joKHL34UxcGjIsbajy8v69Izu6g8YB6qwIyV?=
 =?us-ascii?Q?Hcy8EC4nWpxcjDskfAsliY1kMQZbGb2JTFp65Y2RwXUxwxxJmqh4uEX25KCD?=
 =?us-ascii?Q?3WraT+hzNoXH+24gtSs2cH7Pl6FLuFI7SctlXbeCBROyz1ipFmbbM4WwVfog?=
 =?us-ascii?Q?UK5WFjXZ/IC7GxYr6coCrUgcsvBvS08lL7sb7UzXYTm0XgbqfwoKQ9unJ4oC?=
 =?us-ascii?Q?glpATPTBoj635YPSFoXvuc6tGYb3vhQDftumaU/RLFLJvo+H4GEjZgsju+lZ?=
 =?us-ascii?Q?I/otN4hwvfBeHX7mAWEwdLHGcCwjJc0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe871cba-b0e3-4944-c6f6-08de799e6db2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 03:30:48.8669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdbPpN+YOlJDKg6ONBPDIPMIrWA1bEUlBRb55NTakbO2mlAc9qUzMBEz1XXy67AQPNuBlnSPd9rofF4Vd4xS7+rgoeD0OaNlQnvohH0YAnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6605
X-Mailman-Approved-At: Wed, 04 Mar 2026 05:22:07 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add empty SPL fitImage configuration match. This can be extended
if there is ever need to support multiple boards with single SFP
image.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/spl_a10.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index c3fd90de8c5..f2f82716ae2 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -295,4 +295,12 @@ struct legacy_img_hdr  *spl_get_load_buffer(int offset, size_t size)
 	else
 		return NULL;
 }
+
+int board_fit_config_name_match(const char *name)
+{
+	/* Just empty function now - can't decide what to choose */
+	debug("%s: %s\n", __func__, name);
+
+	return 0;
+}
 #endif
-- 
2.43.7

