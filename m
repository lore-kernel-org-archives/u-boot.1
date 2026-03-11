Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EFF1125803
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:14:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B660183F8A;
	Wed, 11 Mar 2026 14:14:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QWYWz51D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4D883FAF; Wed, 11 Mar 2026 06:00:23 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A73E283F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:00:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5xYGXcC1OXugUb8MlBpFzyuXfG9FPAXAD9JLyjDrQoarihZdj2bKNn2waKAMfmr2hGK6qqE5SM53/wgAY865PQOKvOzgSEPp04xMHj6LMgGO+u3yqWjM6UkE1JtYY9dNLAUKYrQgPFmTBG4atVyOKxwtFTugmIxdF6zTIMMldv6RUT8fL7i7Zx2BUO/8T3S004ETecRpZFoh2vegp2COdymJOCmK1sAoBRyeoImQIPdIHabJ7arW/YEiH49Bp37/DM5gLOUQaQHHw1wSf4FvxcISM4hj1zLA23mM5Z0oKGF4USHS3L4CGt3zgntT3AXlzNEdRV+lTULN4B/IynO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Raf0KH72Z1KF6UyEThQFZhf00hurOp49qZgnUH7GmiY=;
 b=nxpbG8rNt1iuY+nbih+u4EaOHHV0i+L+7OEWR7gxpR7L4EM2vg44fXkh2KZtPFyqxn2biUyfSRqerIFROvUJQV26cwmCl9Wu6KdWqpXM13/eH3JB63P3lhygRkDehFOYxqenhnuA61mXQ8e6ujdW2s8km8irGcBgotnuB2CmgYdZmXC1d1cJEcHoZoqlZwYvU37mHjYuaQJCNvoaB82tnj5oFYwwkmEw2/8fUjAH2QurITbR4DtF4AqkjgKJ+2utfUk+lzmxMlOKYPZnw5qUeAF/fz64eWBWsGZXk6AWERA7nt+ZbRsbACdPnk9cu90p0mKDe1kOC+k1GBW6E6II8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Raf0KH72Z1KF6UyEThQFZhf00hurOp49qZgnUH7GmiY=;
 b=QWYWz51DppI/MS2w9uGx+jLYc8pr50rY1NscJArwm/ys9/YYFJvDPP5jvluZpwbWvOYRo7TaEE3g5pqw+/Nqu3+kHQLWpwGMa/D2aqmabgtSFFuQHbvJIbz/F8004bFifhq9YMTzWXD/0u5pySRfhQwBzzNTtVACFiT16Idi1jxiItqXPBQOzBTj4Kpu4pju0IOengHH6Pbob25tTNl07FSZfnTI2WkBlCLkfltMoMq0V4GHdkKqEz15BE6huAit8qb7u31799WQxEiIAtqQcjnVvYw51bSgclCaZ6bOOOlvoNquc3t7tzhoyUdpfQZt/ZHUOXFBpxeQWUe0d0rvBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BN9PR03MB6073.namprd03.prod.outlook.com (2603:10b6:408:136::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 05:00:17 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9678.024; Wed, 11 Mar 2026
 05:00:16 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Ye Li <ye.li@nxp.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH] arm: socfpga: Enable MMC secure transaction in SPL.
Date: Wed, 11 Mar 2026 13:00:03 +0800
Message-ID: <20260311050003.20955-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0139.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::24) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BN9PR03MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 470bdb09-304d-4ebf-a78a-08de7f2b15b9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: XLbqToxXkVGcez0LywxF7OpoEL/4k7rmJshlwpI3KXVW1UvOuI7pJ9ICxTpfr2p107oCjmJIpR8jjikQxtD4+nYhX2ZwYRnsE7qNzkCquaNLx4ItTTzhPs5j1mmfSYZ7dC584FroDsvuunv+joGKbrkhCcBRlJbyAOL42Owq72yQVp+G5N3IPjD9CN9QnJEjabULwZvaCHnHq4IemdnolMj6POcnzfW5bX/NhkHvroJSR20z4QQ08T7cQZbS/kVOav2yUwzxuUjjRE1Dx9hyJ1Rm9xIPXu6OSTS01e9V3gaj+rXfxc3EeYdTxX/O/rad+KDaWgeORw9oFVg2+9aTyHwYthlo6mddu0f9kBKaiozNU69dKc6Mc7rtfC9aouqJzZ5MTtCh0bIT+oyUwyOyBqS2xWZ8xa9Rc5YM6ZCGz991OZMToniZasbjdsTCVb9au5Kfm2VhWI6MW504OC6YcfpQLhNjf3qoWuPH3LoxQluh2Xtv0PEU8nnh5LnGgVkF9njx0dbpr8GUfZXjzxu3rWqr6tje6pkRNDQ0zrBrrrl/3j+SSLrSdgLd5O73rG6vJm1Inu/uPmWhSSbW+HVHy/zV53OlOn58wdNI+tkMV6ZKysvyL+b+l8Su8ba/60aw6oqRSTJN7WBi8gGNipEObtRVB1/zNrUApSOYhw8AxSe+pw00Wd9GrzzDKjw0tptsVeasoVhkXtsQQsmQVgKgR3J5FCDXWeRiGc3E3/jGW2Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jvPrc0khGQJ+FGJYpSd+uyAtPeUqNY+K+myH2Oxc3U2Oj4SU64KJ+Dw3NZzP?=
 =?us-ascii?Q?qQJ3JBr/ZvAxpn4Qkpne4M/rSDKUzY3Chdne8XvffDiWiMlAp18cnuNCvDRy?=
 =?us-ascii?Q?g41tJ2JOKxzXdT8iKxUTam2El3+pJ0MHSx59Ppfy+AuVRArLz1MdwysY7Sqf?=
 =?us-ascii?Q?w/JM+cJwhgaTJEGLh985KBtmGwSNBVksezzFGiqlD+cJq47kILyYnyUQ7GUj?=
 =?us-ascii?Q?Bi0GNW5B0ULQWFPxV0IK8+/1o61ps21auYlXBJMXYyl0gcsCEzS7TI/UqywG?=
 =?us-ascii?Q?ZIAkvds7czOrBq3kkEgmyr0ECqsj5Lu8oblkEoB1vdK1/2sYIUPJdNHCx3iO?=
 =?us-ascii?Q?NpWEm9rmUwGSSoI+TptlYyyPXRWvUJzycD/E/6pq6/V1jMn/3zqYIXQNGG3Q?=
 =?us-ascii?Q?uvVn7uXzGVm64xaax9hxtWS4MbhNU8//D2CkdoMTaImGKwIx7rmMF3d10R0D?=
 =?us-ascii?Q?obi8qS2bRNhRpQ/OzSAVBAIA1c2rRKkbr0tXMmPdh8NtYjuqpJ7rAYzhFbl6?=
 =?us-ascii?Q?DTqTAWPM7fiAeK9u3BzbaXGMIPN2VFgvxFXBcJgd/dZ7bhf9/I769E9GGWS2?=
 =?us-ascii?Q?rtaVIjkvizCmD+0P/wn3f3fdd6uj2FsVA66v38nSGj0+mVKbigwVwGGglaWj?=
 =?us-ascii?Q?XgX8qqPUYfSNMRFa6/ua/E5ws0WoSG+8dVkQe28zxX2fqBIYbhfrTsvIL96N?=
 =?us-ascii?Q?6NBiBrDysGL4ZBj8JGcRyW/phXpq11Mcf9OvTqz/SP2QOYRYBRxswaG4BXxI?=
 =?us-ascii?Q?RMjy/Nmi+UeHOCG2TDR+ecSAS5IG2TM2w4oe3GOWdu8M3oJzaB7LjbA5Z7fr?=
 =?us-ascii?Q?imCXoGwOxAm81ghuCxSv3i9zGCDKpNYvhPX73QAPoRmM2/5rvB9iStqF/giB?=
 =?us-ascii?Q?MibIIFmKZnlgb2Za67hOvzG7MYciEFbpYHmRVnjQvEAcXJhR/LD+bT94FQfL?=
 =?us-ascii?Q?cOU9meU2xfzuIyLcGVm695oeV2I/0/i2TgTEhSpnBnHlRLWG9bHwwmzvphLx?=
 =?us-ascii?Q?pqut7pm9QeLtGVUjt+ZKZLtocgEqTIAXSQoWYlPvLK3LVDnNMk6FXvx3eF9x?=
 =?us-ascii?Q?QJQcq8DlkffFiiTiRPB2S+iZJRlAlqn/WGB36E9S48xm9I2XoZcafKmGHFfv?=
 =?us-ascii?Q?USic6vjdbE+1XVi4joEsSXd0v5tZaasNh6K/pkJPnlGbJbcRs8RllQ74VKMT?=
 =?us-ascii?Q?nWM8blR/RHnyrXDlymLSudKuQ2jIM76+spKOM0b6ECHgwbCICh8Xk83RwES9?=
 =?us-ascii?Q?OXX/fBnaKa7bwBhbZLKpYVgDx/wWph+8HbXnOemq1uwXH3ybmmdM8G1k7Rar?=
 =?us-ascii?Q?5rcLPAB3i6dNroDOuXfVnfQ4HrbtwajvK8ZUJzkuBt6YICNIizjydJmuOqWX?=
 =?us-ascii?Q?mV4g7l5ZMtLAQ7/ds2OtCE5Rw7BFFEthQECJsMBfsmeXChP4m1Wfa5VmBgt7?=
 =?us-ascii?Q?7HD108EPVCBeMO7siF/5ZqeAvba/U8K4UX5qYLHdW2qJVnxfACsCC6p8pN0t?=
 =?us-ascii?Q?xV9zSFDJxKp4xW/Wq9nBrhwCk0sZuEPybsaFOgSMDZ+aASpEZiZaOJaYFY+i?=
 =?us-ascii?Q?jY1Mcbb74SfDkcOpJV1QzTtpzftHVWB780zAQR9vOpXPliCQ3cu7mK7dT+WK?=
 =?us-ascii?Q?QZDz/1TbF2VDRQIhpiFbz8fvhJu/vRfgb/kzygoWOfxQn9UCHOiVKVGSZiru?=
 =?us-ascii?Q?iwcXjCMrv++z4qiaDCRa1/2iJy6zuMln1nkNC7uRJpUHE73Xx76rUY9Ww7/3?=
 =?us-ascii?Q?xSJ8jjSxyZLLXGH+SOr7dOxmNVoSUzU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470bdb09-304d-4ebf-a78a-08de7f2b15b9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 05:00:16.5691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUUD7/TuU8IjSX+nYNXZUxazUiH8v2h0c6Gc2plWkvkC/t1MlOf/OdtzBVi6SCrmcV0RS132EDHpyhOANt+ErpNpl/im6ip1W37SYloWSUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6073
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:14:28 +0100
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

Program SECURE_TRANS_REG when CONFIG_SPL_MMC is enabled
to allow ATF loaded from MMC to access the secure DDR region.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/spl_agilex5.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index 1be347360f5..d0c2af795de 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -110,6 +110,14 @@ void board_init_f(ulong dummy)
 		}
 	}
 
+	/*
+	 * Set secure transaction for mmc, so ATF image from mmc can be loaded
+	 * to secure region reserved for ATF in DDR.
+	 */
+	if (IS_ENABLED(CONFIG_SPL_MMC))
+		writel(SECURE_TRANS_SET, SECURE_TRANS_REG);
+	}
+
 	if (IS_ENABLED(CONFIG_CADENCE_QSPI))
 		mbox_qspi_open();
 
-- 
2.43.7

