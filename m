Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5ECD12D5C
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:25:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC83D8937A;
	Mon, 11 Nov 2024 03:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE61C8911A; Mon, 11 Nov 2024 03:09:49 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9901489312
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQEQZ+q/KoLfFDUq/ZzJfr6XI5lBQrNmDB7ahmq8yShu35OMj0PpckAtFtB5Ly9Z3VPmtSIdxvKSzu5nHJRnkEyUIGMBpKJYjPHlhKWZ+Q3oU2gzMyAgrm+8slVTv+MwBoBNnZhaYEuhvZiLzFwMdSTcoq0zLjrPm+S32iQEwtk+ONmrhPCNSxFGOwPDunTBX4XiIv6idG30ynKT3JrE90cCyK5q3UzgqFSZpXwkCLoTdX5Oeok5Z1SyL+qDUNCMTb4f67gj7hROI4YMpBqdnd/HmS95lKU1S/A4+KJajZLHMEcNx6/Z9ugwZiwl/qcoMSQOisMwT2iXcs7pnyIxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puqyiKD6HLx3xa/8IWwsr3tAKZFZrFtvQXHRkp7j60E=;
 b=en1M+5+Naqji9kcX2ScIEyYOV4g0uVqV7zhn5ID9ygfNOg+G5W88JWwKghqi8M69r4u6BOUEKWsxAPLPEfeUD/gI/CC3+/3D4fGCxj5opYelCQ+3myKC2Zp8nDn468ewl+UNYYhiazTIjLNAlKQw7mBtK6d/+DUUHqfoRz7vHCh2jaWNcsbUgsj3wWGKDo0a9gNXD4TiOAzrxFubTTpz3MLT+ZDPjB256UGO8ryVFQSUKjgtihbtweWOxR6Rq27CsDRvO2OTHwESaqEmR+QcHCyX8VcEmBzmCrz6bhaXiDdZ1Ys6SfuvZD4N95P05gRatTN1iN1be3K2Lg+OQjlsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:55 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:55 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 13/13] board: starfive: spl: Support multiple DTBs for
 JH7110 based boards
Date: Mon, 11 Nov 2024 10:08:08 +0800
Message-ID: <20241111020808.38974-14-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bbb824-80c0-4e83-4eff-08dd01f5ef3e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: oiSTJhvnCzbOXipBUvhatMF6VoE6zdmZstLMx1dZGsT6gOYJ9SAJXrh6apTEQrUeCY3ajVLjB9u9rGwgCePx/OvYeBObFavwHGeOvNQzmPSCCmdNt7UPbDyS57rlz/Q9y4Obhl5BhaDNpSRe021v5YDqJtN/quMSm42EQ0dwTbYCFRV/ZzI9A3hQPfFKNZp5LcnRiHkxd5tPdKlbK1JCsq4Jl9c1Gg6toweGVqJokLkrX/5KavEMj0GKuBmAaQZekuSXA0q/aNrV63LMw9sRGacDeRlfNOSIc03QwHqIENZvyC52kXWU5h5Lk9TQdKjAU1uYL6q+OT8Ei+tLDJdwc1xd8zmOlDugD30h6p9oVufAA/zBiv3IhF9d7AaRf3Mq1UQi6duEEa5gRDddIZdrpnTTV2DSpN92LbT2ZsVO4ejbjn+cfZFIDWpkUg7+JXGH4SX5NQaRaYyzQRa2lRfCfLQAnflpk6zdOnuulYafLxnbDfFWCaxSTp+gHXyC7FmX0okYXhM9Myn50k9ADlsZz3oerVm4NUCcAonPvG7Q8K365WwHDLXSZXA87UIxPqOGWS8zka++c4WIysgkc5wv9/qO3bApHPFxLJl+a4cTZO3He/lYS28fvVnYg/VVqzW3ElPMXWvSOfGuW5GfAeI8+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a8xAmx6v67inrVr3Oar7FY0nF96bhaSmqyw6Z8/bi+P94C/rKDhn7Bm1nfHz?=
 =?us-ascii?Q?ijNWrrIqMGcoJ3irKAciM5aBYJsVaj+nTcpu8Np/0qtiR9DA0oRtC2Bfa8x9?=
 =?us-ascii?Q?0FB0C3G+4OK0kuMyOeZjhrYpjm/bKS2FXvup6e5am+2xetjDJZehZdTdbLhT?=
 =?us-ascii?Q?3Wh7XgNXaVdHWoYZeDvF2UDp23uYPIl9Vp6dpnhaxO8hIbG8BSFvEPU0y0p1?=
 =?us-ascii?Q?qPkKD+p/ua9toL0HaQ0ysRV3c05tI03o/HKJOVvi4fJOtygBkt3JPW8rmCAP?=
 =?us-ascii?Q?w4vWsX3grMI7VycQNAQyy6zFZd/QZ/ozA3U5wAY8Hs5TefE8/2Dx9cuLT++c?=
 =?us-ascii?Q?3awTLhRFTk6lPuw4DE6zwk6ElNvwr6P/dEoDiw8L8pWWQgtBn58L+DxLvKAJ?=
 =?us-ascii?Q?2WJc5BAPVm5PY8Pa+t1pASlEIF4fmtUbbfw4NbIygI2yjjT+cnM/ZDxyvkMe?=
 =?us-ascii?Q?uf1frzOuUeOpn/C6JpHQn+Gykgv4W4xUmmV0wS8tVteUQ4WQh8eUgISKuBKk?=
 =?us-ascii?Q?J/6KAG4x1zCXpNA2j719qc6g3VcDVFpQ0AoMvqid0AUJJAYZLqMCD0HCxI+N?=
 =?us-ascii?Q?Zk5HWrgMWEFiS/92rD9moNZItdhsTG0UVTj85OYatb5rWqSk7kFW+S+F8Uzb?=
 =?us-ascii?Q?mMNqvTalUNy1LibYeMhuOx1viSJOTSNef8vF737+AXtvegp4pjhKotw0HDxj?=
 =?us-ascii?Q?eqy+rmr9eSGbr7A3jN6a+G1Nuq5SoF0NQTF5jR72r/ENEiqruT1Ytmws6a5u?=
 =?us-ascii?Q?+/fVhRpMqVeM1obREdG2MwPcvl9huAN4zSwDXjp0Br0TwjitRDfeZ6YcGLsu?=
 =?us-ascii?Q?NSlttJRHFTwafn0BhMTGh2zHyJSCC1L/NTIaUM9sJ5l4H1QyLTmis63vpIxL?=
 =?us-ascii?Q?FzjcejVoqbN0W/4LBwdbkgCYuBDiyVmjvZXHN4CZXofPL+53O0EZAWmDbE4d?=
 =?us-ascii?Q?EfJw2I3M3vZEm5jAf8zCCH4HkCcTcvKbU7ibBehXv3YVGrEILxVrFQ7rBXsc?=
 =?us-ascii?Q?YB2+7G3RBmYbBnlnvlY2toS0xi5ADMrhD4gS9xTYPkslNbxeikR/j3wV3lxB?=
 =?us-ascii?Q?X3mNVZqpZ2xF/tRZEek+LbFJ6yQRtBmdUoGaij6f4VXIp/PwgyH8TiHP25ml?=
 =?us-ascii?Q?dFZunLTN1bRnlxi5U3B+2+Sl45UP7usuxUAdLHU+ILIToR6TxGg6RHx5/hts?=
 =?us-ascii?Q?R+akwyvFNTvYoq7b9n0ab5530Q6iIacnxnWQdyOZIH4mo7vX1McqHlnqz6wL?=
 =?us-ascii?Q?jXKYCZ5jH6dgNvqlpcXoYv2JJwcyJGU4c64j2QhdzW9ork5Om48jdPyy9Wan?=
 =?us-ascii?Q?E44Kyrroe76/iubClqXWqE3ES1Mu25SxAmBNVU2XX3uY8VBn2kzpTJ5WpCLu?=
 =?us-ascii?Q?5ARGT6xIrxeT9PUrHmRJsyoSROzktbZDH4nfFEJL8DTyt/wx0sxGt9JR9KZs?=
 =?us-ascii?Q?WXwWzBxhOfkwEqPxSXM86D7MKfVoYfL96oK0vq9O3bT+e8OGFNmndVzNIvFF?=
 =?us-ascii?Q?IylK+uaF6DP/aFvloRWlgJx6IZdQCDLGUSUbLMmizvKaDbGod4MYGt/13hvo?=
 =?us-ascii?Q?KGMM5hzoeCINC9uN/V3/IBljQDmyUN1psRJkpdeMh97Z+eN+3O353R2hiD4K?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bbb824-80c0-4e83-4eff-08dd01f5ef3e
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:54.9703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mnyet2txXbp9OR+Z8LQ0GXAnJoPyE5lVrYWLxU/PTnL8fMbhPix/4hX6J2cQ6MmSeURANVNpbUHa7+9HbryPrvBDhFh5UAqLooD+jxa/2p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

Get product ID and the other information from EEPROM, use them to select
the correct DTB.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c | 33 ++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index cf7f39d5c5..22afd76c6b 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -113,7 +113,36 @@ void board_init_f(ulong dummy)
 #if CONFIG_IS_ENABLED(LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
-	/* boot using first FIT config */
-	return 0;
+	const char *product_id;
+	u8 version;
+
+	product_id = get_product_id_from_eeprom();
+
+	if (!strncmp(product_id, "VF7110", 6)) {
+		version = get_pcb_revision_from_eeprom();
+		if ((version == 'b' || version == 'B') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.3b"))
+			return 0;
+
+		if ((version == 'a' || version == 'A') &&
+		    !strcmp(name, "jh7110-starfive-visionfive-2-v1.2a"))
+			return 0;
+	} else if (!strncmp(product_id, "MARS", 4) &&
+		   !strcmp(name, "jh7110-milkv-mars")) {
+		return 0;
+	} else if (!strncmp(product_id, "MARC", 4)) {
+		if (!get_mmc_size_from_eeprom()) {
+			if (!strcmp(name, "jh7110-milkv-mars-cm-lite"))
+				return 0;
+		} else {
+			if (!strcmp(name, "jh7110-milkv-mars-cm"))
+				return 0;
+		}
+	} else if (!strncmp(product_id, "STAR64", 6) &&
+		   !strcmp(name, "jh7110-pine64-star64")) {
+		return 0;
+	}
+
+	return -EINVAL;
 }
 #endif
-- 
2.43.2

