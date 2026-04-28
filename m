Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F083FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00BFA846A8;
	Tue, 28 Apr 2026 09:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KPYh3j0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3EA8416F; Tue, 28 Apr 2026 09:00:59 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B131083A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpE/0isLLND1hmqPqX/rd0etKnttTmswoFvpC1WTv5kV/Hq9BtFnYDANxnKO2R6+2rgfXPigBhow8ydXLENQITmbUJq47TasRovghiHN3AXhYkE48pMnUWT22+DHeLwdD8MB7qBnng1F5QhW4dC3X3MJ8Q1aNGScKY7azBYYUyQK7if6/xx9/XMUAJcbaEsYISQlqNYgnHCEJ3ba9hK6fmc3DIIjPfyAghZqRRcCvbCR0YHlDs+90Cl2I/blpZmGzZYIwKY7MU9lgq/Qtcx28yZw4Gy4YU9VcaptOP7mvTP+vSbJ5E2cuS6di1WgxnMazZUoKwp2M+bklv4t2m3kCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EpgrA+gxa8tVS9w9el6ZcrMdUyjzrRn4i6wEXPGmtg=;
 b=T9kUu9ybG7DPZgAgD/Z/yh6vkwE8VEqqSgE3k9ehkuV4W37hCDzsN3BkAzDZ8FI1KVnC8kV1PKGsPCnm6DQg4jMyjhES3rE5jU3MUb5CtqBWl5TpT8pt3s2tUu73xH/lj4d4G0mKrkOVrH9UlF73mG5F899DvqnufrXKc/VmK4SlliW4G2o2XKrObtxifPU6PpyR2/wVEBiV7S/EJTPEEAGNB7AufiCmTjCvdOJjvJevhyys08n25CeBq7jfUXIo+IG/IwiyJtqsMgQEp/EUbaXBvKuxPcGCR+LIICyOFdtVvW+DG2/wiZJr5imYYbxMItlVOCgRmSaHUsD1268QYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EpgrA+gxa8tVS9w9el6ZcrMdUyjzrRn4i6wEXPGmtg=;
 b=KPYh3j0rY+gzk/AyNZ+Vqlmn15MUH67Xl25qj4eIr7CEwH6hE6OG4bKhiNviJCQoJuAfoMY/XzOv1pu93lHZYU9s4JeWss+E3gdMFHp0115dy1ec6tD781oyc2BXt06bjOqzj2Bj6l2MZ3/kPGCXdK0S7mhoP1qGCFsgf23/ajfmaSlgp56pPwZoKObYP3i0LkBSyQit9maUxsZMUb/EHngvRkBOdF9bvHfgOfMr8iOeq4OpdMuYlFEPlWVnBsqOP3B0jyxkhxGWLgQI2eV3aYab5e4zNKQEbI66UvF6T6J3J9DTILdRLpe3ED1UdY/7rk59uD2kgcxvt7mXIg8BPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:51 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:50 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Subject: [PATCH v2 5/8] configs: socfpga: n5x: enable ISSI QSPI
Date: Tue, 28 Apr 2026 15:00:14 +0800
Message-ID: <20260428070017.16807-6-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c30718-1ab9-4e4a-a52e-08dea4f3e18f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: w+AV4+OLLZ1uSs4Wrur0/vrSSN5KzDADUd7vz/2Wk7qLAnKc8xFoWqSqtocJJ6gESUxLIDwzaSVStnuWEEjbhtmCpubX0hsw7lMQ6XaSzbACwukwYEf8cElvO8PAmZozWg1oeXO8va/VeW9qFjiAl4X2yFV5yNn20E5ygy0nq8B7/LM+HTOPvAsD2Lsje+KqtSky7akJ/hRIjj9Wc/uSz7E3DqWzF98Ip2TIfaGHOnjxbC7scDlh/cSy7b/TVsYYG3basZNm/Cl1rmomNaPRp1ERoS97YrxdD2aGhHEIwmY4Qr9yO2G/PCN97nZl+o6TViD4/1jtiY6qwysKg6g91TaeVeHH0btkKcgEUwrEJM2NRpyNEe9TaI7gIZxNj0FBIo2DVgkKoWFVpEGVFLJN1rQ5HEuxU4peXxDnWcEJBK6y+2d7dsYs9iEPbKsiblo3MjCzlZ+qhSi9oFNDWloqLfxH5W++XuEFr2+HucQquHr18zSIS4LTugUie3QhfJymNMf6mJvGiWUkWfQgnqBFSTNeairgEaUSDrCC+9DTuZr1H/qrrhoXWWmP289AJbVKwoO3qzF4nU2ZHhbb+Pu8fvnX29UZSp2+rQhbRS+o2xSVvl8OxzZnU9S65k+Aiq1IncOKg4MxbMhet9DQgzYyvSXu0UmjOitDfSwFgAZIuwurAhcw9lYYU1cBqcCg9scXCl1NDJyyzDu9LY9jrTxoGqRSxMQqe74DcsIMFgEzw1k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tfv8xLbW7rnAK6kY8Z7QP7KWHEe2SR8mS6OPqN6lRVq94utPbng2jAa9dyyo?=
 =?us-ascii?Q?NQBc+bG9Yy5F4qU+fw4Mobx7rXvkDSeUgWZUOtSuhnaVetk3S8dH4B7HPo6N?=
 =?us-ascii?Q?zcPR9te+yxv+4AIpYB9dtURC3i5lryQUQfAT346OPvKQ8RFMJDjOUTglnZ3B?=
 =?us-ascii?Q?OopSRbuwvQ2d7/19lId9C48BZsMtkat8aG7VTNFgi4WFvctQSMlWjowT/C4S?=
 =?us-ascii?Q?oR6ytY+n/6qzoBT6MjIpw4Y8olHNEY3rZ4YYO7GOnDyq5XWY/iHQYgd6zaMo?=
 =?us-ascii?Q?zubdQPOClo+ANI9eWkOD+7TmFpaqaNIvBlJrp6kJEwacO37EyJCHNlHWucHW?=
 =?us-ascii?Q?g//hMoyupN4s/8YosmfmSFl0k7W4TYBRLiX0/p7x8Gl6xEhdTWztRBX3n2P6?=
 =?us-ascii?Q?dkvRtlgrYpwwrOaWQlFb/vekrDt7fw/DqADUfj9hbR4OauWZfyy02TkB0evX?=
 =?us-ascii?Q?AaVeeQvnGdxwaDMjtumAQsy4oyjrk+/LRGmYIKXDYScBnYXRkARQb+HSi3R7?=
 =?us-ascii?Q?/HMFc0i3rX11E164EDN3hIaAQ/PFYDxFYhqTKl8Ctd/M3HJWXzioZQW/REiZ?=
 =?us-ascii?Q?UCta6Y/KmrdQqPT2GHXYcj9Yevp92KQgsfSL4XpFw29cSi7VZvCrDPtqSrds?=
 =?us-ascii?Q?1OmqVJDGiioUGn0mj4J0rzIFmM7MrUt/RXyHhTkUzzWNclfO+sQIX+i/wP7T?=
 =?us-ascii?Q?qADGJnmI5BowvlxCSm3hggApMJ2Bw5Uq8Cw+0UOpssga1RQEq0/unB+HoFQg?=
 =?us-ascii?Q?mXyUA7a+VWJM+UkHJd502Xj+MFDOADkpZrruTcTWWEA6FzqsPhuCqvBGuOe3?=
 =?us-ascii?Q?d+R+k9JWRKbAjcrbYsKxQZzNi3VSP4hj3zD7qU0PGQcV+EhnIu3LG9wkdlla?=
 =?us-ascii?Q?/eABbyU0GZxD2p+VzIHBJzIU54DL3hPv6kDCSQ4IixlPem6PhA8sXDRDuJF/?=
 =?us-ascii?Q?ItiJyIIlSj1R66IeMkBIYy+OvHNn31uXC2kPW2g1HKMsybwklzrrezhh8OoL?=
 =?us-ascii?Q?kxVPCrGYUzWqIzJgHLeiofQKAbu1pmmc4Lmmg7sr0nJKksQMIOhJMrq3Xm26?=
 =?us-ascii?Q?EhFbwbdKg8ezCzMcq9fKEkhfHsbbvnrWBSYefX5IgzhRqPDrUo52ulD4ewmk?=
 =?us-ascii?Q?cMgTkqLQ1+hUsfDEOCPuTDNDZCYswgA02ncDiY7XkApyU+4UvWfGzqqNtLAh?=
 =?us-ascii?Q?nJ2o/d739+883hrHnMhbgwwsfiOzDcUsmL6Fm0r3hWYXnbX54qqn7kiSDTZe?=
 =?us-ascii?Q?xZQEcw9ZQX0YLvpQb5yTHbsrIf1ziTnNfVGzI2EkNqBnN7uxlBIhHPS/rOhs?=
 =?us-ascii?Q?5xoeuzuMHKLsrnCCWk/7xkoigtlFpvQyW/tdvhY4CvEQ7I4lOWmffECKdhPK?=
 =?us-ascii?Q?6DRwatwr4T4bAJJJzuyglNqmKBc8Wt9/Ki95IK4cv4PGpkS13+vc1fL3qUto?=
 =?us-ascii?Q?L2leBIduU6JvsvZDV5eh/ZilKtfj3v9rlBnY+ZP8STSdtewnwH2GpLIy8s1k?=
 =?us-ascii?Q?74avsPGEyBAX3ynRwoJL2U7YRgEzVi2x6YvkoI2Zruj1Cpc/FxlBsy42Z05p?=
 =?us-ascii?Q?hy7bwO8sCdkLTGfH2pe+ha/Z/8M962qkEwGz/BotWenSc5U9ezr1bgF84041?=
 =?us-ascii?Q?4eJilgUxpndHDJgW476ZTGcIMdrX9lwyj7T7jUBUW6ALK/AWuBdf3nTxkC4i?=
 =?us-ascii?Q?68yeos0qpg4yj25HCC3juXah+hTqwsOveMdJBGVda8gCeUYUJQ1ZAxIaDe25?=
 =?us-ascii?Q?PUkQPpY6rwNm84W5zYLt7kMlrg3Al2k=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c30718-1ab9-4e4a-a52e-08dea4f3e18f
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:50.4952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3CcfZ8p8g+89r3YwuYTZbzoo0paCn9O1YHvXOQ7OCavSp3caq+h2/gxf/ryUy32mld7pdq0L/xVTj0RvHYlqS36NnBwEhZwvC2YZS+J+KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable ISSI SPI flash support in the N5X device.

Signed-off-by: Abdul Rahim Ahmad Syazili <ahmad.syazili.abdul.rahim@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 configs/socfpga_n5x_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
index 273e74c6499..17dc55aa41a 100644
--- a/configs/socfpga_n5x_defconfig
+++ b/configs/socfpga_n5x_defconfig
@@ -74,6 +74,7 @@ CONFIG_SYS_MMC_MAX_BLK_COUNT=256
 CONFIG_MMC_DW=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_ISSI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.43.7

