Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE73FD3760
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:05:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDAC283EB7;
	Wed, 25 Feb 2026 14:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KAJahxTH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFAA83E61; Wed, 25 Feb 2026 11:02:54 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F48E83DEA
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfr04YLp4WYomIuMFJ+82ewSsvEvcdMx1klqpCFyxLHRRHRPHsMiY7b2Lj/YGlVaYBX3frWF/dEGryrphPGKJxLmoJJZ8l8kxiMyomKjIuz6CAt91Fxvf/FcrbJ5UstXYSRdZ5zINzsaBGtbtPMRmnly0ajpOGaLQzRrE+0Y1rWh9tFvkQi748D5w9+843cGPnApTCRjOk943KvxMIhLljsdI7w566/zFGOI2T+HY1JLdnZQThiuWZvbVJzRXh71SG6H7y/eem/zD8Ibl5ZXVoPs/9bzrnCYcDYxM7D/0xfxQ0J7jO5QbLu7GzzqOUdYJ9ec16jP4l/8GA9nrusEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4ifKPbFstM30CnULB3c9cW4bXZyxLYTmf4Yjxc+YPc=;
 b=ybKw1RorHxeXcFEPUtz173caa2S2yp2+otgPVK+uD1m8n/NXBo4Zj/kUbZh2Ob3aDqLK2kGosohc1bk1zAG2dcal0bfwIQPTX99oswKdR3AEU4Aw/OAG9hGtTJo5hwzyk+UOiMrtksYxozdXS2bRRbN81PkoSQB2cIP8tuBLCnJdAqlIL7weD/iIYqoKrqXmk10SjJLhExk+m+4IoX6Q1gQOjFV84k+N93ESyjB5VknWKqxeIOH3DpPn6EVdTiJHr61UDniMvDDTd9nTPlBvKqbjHEYOsGGIsi6cXfTePnRe000+5Z5jvORpa14iSpynwaZPkzL28LcVuiJW1qFiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4ifKPbFstM30CnULB3c9cW4bXZyxLYTmf4Yjxc+YPc=;
 b=KAJahxTHZxnypr9iIa1rmgwTuh67GmCObxoka1vKS5MK83+ftXZLudG5OOHE4jKHa+wIDHzflYDIIiDkC+RKgJjohhEFbP98NrJ99z3EgPJ3RdLs9tOdeRwuLy8MHNflH3zBoLt4MXu9PDUWmLjhNZyapNYE3qGyrXoqZ55ciD+XrzZCYqnJ7LlpmFNRi3W9lFWKnwT1mQzpdb1FiJQtdijBXAN7dXfzo0fGMt1Q0lRiIL7BtR3Yz1dXudivytoA+kv6Xe5X8QH0ODh01WShF1x3pKicNrCt5H/bdVUGmDdDIHp/6xnPeCFpPi6iOJRWApt8ku+QkJv7X06JOkGsSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DS7PR03MB5415.namprd03.prod.outlook.com (2603:10b6:5:2cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 10:02:49 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 10:02:48 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Chin-Liang See <clsee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] configs: Enable CONFIG_WDT configurations for cyclone5
Date: Wed, 25 Feb 2026 18:02:18 +0800
Message-ID: <20260225100218.9072-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:a03:332::31) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DS7PR03MB5415:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e257367-c5a5-479a-e8dc-08de745507d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: wg9S7gt7ap4BkES+9wSe5Z2ScphFnPSaVvttIznABA0fCyJd1EI41/TK2rQf/sr+sKbaMbJqHEEz5LJJCTX1V0vKwvyICUDB4bV1G3dNiTITl/fUAuX1iKWYoE/43UNeVBXylDZGtUMuqvKto0/93SfS+YRAx2aIfZGVTbjRA6ivIEV8NG4AR0YpfINUxgTkUxDxKKmcUqfS9+fq/NHaqsF0JPnv9l47zsRl8I/WcbRJK4EXHYY2qdGC5bDw0TP9xPVOYp3zgrJxkjvrvQidseLdob6HoVUyuBnv2gKbzzVzHHFlyJG0zV+esbSXNjfpAwv1/gIMoOuyOd2G7W3dyJFq2mIBzWhKA4/OltJFQc8JSzy1WcyiOe+qKD7IqMq++V1MmjmIkDgSkV627Iy5KsMXIo86O6RiydjPEK9w10WWLDOp6CTHEei/DkpPp0Vow6hvhS7l5VE7qcoVVv7cI9pD0QjLmlh/1ZdPjGBCXKrxzaElGnUljLmqtVPVVL/T3GMXYEx1hUsff2eoFQcH5AvSyg+JPic8JGlxkjdroxwohJNJ6JW65WYIUHL30Fj+aPjOxqZZ6EzUIXWHA6ObWVyi2130pikJWd88axyhYcmj77Mh9UcKu27jzwPzEVTLC79kUSCup++x0qX2p7ajG0053MYGhMA3f00FhmZGNhSpPlNHhBSVR+k+18tzLUmMWJe+DcOEi+QZ+LPPv9zNZGgo81FjGpZiicTGVgpzTfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oAV59oj8wVx73xY1C/Q8cG89w85HI6cHBAloukO8ig/t57sXouNImVQEyC/t?=
 =?us-ascii?Q?nCXkPE9gtVZZng4hsDpF8j6UD/ntBFYtbg2Dhw5QC3rjUIvmo4WQEQTNRORM?=
 =?us-ascii?Q?h9+WhYIc7+yOO8H46PsUG3nIPpwZcIjN6eJwYv0PzzsvMDGKhYFWAiTahK/m?=
 =?us-ascii?Q?fCCBxmjQDpe75DfVlHToUj+v9IsrL5TcJs7T6s3MIv99KwBAEqqpNQmnEwxJ?=
 =?us-ascii?Q?+dxY1WyY9zNP1VckohF9To7BrStjXLazAOjrUyMg6+lVSNMYt5YJMXBS137B?=
 =?us-ascii?Q?MopKlE1+Jjr44lL4xzKidAnXZk8c6Kc8UJGXLp4PR3e0bZM/DoxX+if4RQoz?=
 =?us-ascii?Q?Xf5w8ojeFVfpptOWGoq2J2NNqLTUtCsXMYbj+dHAhS2X/fgEMyXa2CxX/hvc?=
 =?us-ascii?Q?Tk2u4fRbsw63u1hv6NIOt7HCXgC4tE2sUaUzaJHL9V6tZDVyxQjl0WAmJxgC?=
 =?us-ascii?Q?OAMLOuT+DWatXwJ80L0uzgyCqFdb/YyEXCaObHQinceAsxfI2RvG005ZWD4b?=
 =?us-ascii?Q?p2or9S9ks5ajyqyPeXdygn+65QL7bCwBZGzxlcZuRAI/rI5nO0HwdN8INA1z?=
 =?us-ascii?Q?CVN6S7EPjSFUuSjUkp2MD6G8ZT26JSsjafy5h8DrtJoSKzd/ZDpcMV+DF0+y?=
 =?us-ascii?Q?51Ck7Yhhj4pvWel/neG1C3JQ/XXGWRSZkmyCAEqM/qVQjf9X1eSjgGodMLfG?=
 =?us-ascii?Q?Q2UYWKOJwbF2rL9TmXz9GeJEF5nthMhzuUxBofasBKgB1e/wQywMFd7swo1a?=
 =?us-ascii?Q?Y8EYnVd9oXwELCQxl6tlz8c5rbkjuJ/H92zwPjKN1UJX9utIZeBj6ngaL85E?=
 =?us-ascii?Q?J1WJnMaS114iFxzpRoyYK2Aao3vgOSMNPXcwzwjkUptgWo8CydTrkvbSYlRZ?=
 =?us-ascii?Q?wLH03GXcRZbrhFux/BZqEswsBhEbuJ+Ozl/dI5cc+bu2PAC1tMNqHpNwfiyi?=
 =?us-ascii?Q?Ob2sdw3jPAcKqQlCYgzvMNj3HBVrig7T7mm1i29jo6BfYXmJOEFPTSKrDhGZ?=
 =?us-ascii?Q?+jvCGi96IgzlOW2iNOk4oxL7CJ0jSjNfXbh8MDxSapNvwFI0rJnh6YzPCl55?=
 =?us-ascii?Q?t6sAgNVo9vFaHec1t65wkfsoDEbjVVNstZSZz1dKYMGwdvCfUatJeYyDuXlH?=
 =?us-ascii?Q?l9wsX/b3+GkyTeXrgaFpApNRhVJ2Kq2/yD7ljT8/BvjHEKcB2rVwsqDFeaev?=
 =?us-ascii?Q?/20vralrNtT+S5uFUygEu5ghiQrpR9glyWcdpGIyISlK2nPb6a0rwqaoEiFi?=
 =?us-ascii?Q?vgOZ1tb3reWz+am0/EXE1HAa/nr8njX+h5VoZ4T+itawIVfEBA6OdH6W+YpD?=
 =?us-ascii?Q?OWXl8LZQBaLLIgDvZ1yg9CMHd6kvN+VKtNpCUiG1vutEr2Ni89RNiQ0w2wgv?=
 =?us-ascii?Q?L+MSljwQPt64k3u9XbhqW34W3TkTPYdOIpn4uelQO34ZeVrGwb1jXTlJc6nC?=
 =?us-ascii?Q?pM2vBbKtIdQ5va2X7lfMSmo2X43l2/rFk2/glGlQVMIkNa6rS3UCUDDDMeVa?=
 =?us-ascii?Q?eK2rJGAnsbXbqs1rdwl6MzD6RfwnTOpiKPGfXwggUTlAzG8LKImdhIWrDreO?=
 =?us-ascii?Q?iV8clWye5oGdmg+eNAihELihYH0y07Fcjl9Ey8r63fY3MVscid2B+BP1B6hP?=
 =?us-ascii?Q?VZ2TTmQeRSVzmjtnJpZpYBWj5rjNe0lIfu6RC7DI8h1tvunDs2h2KCPGBYH2?=
 =?us-ascii?Q?ZoIN50w27AwYXtQ/ISEBszrBv4a4RfNtLwueZoW1O+GhQ7E4ShaJwO+W4Osa?=
 =?us-ascii?Q?6POFEYN3lw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e257367-c5a5-479a-e8dc-08de745507d4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 10:02:48.8716 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dQ/TMXrHZcIgkgnGDBAuFLmLpvckP4/XkZeHO5epWCBTOU2TpwJodBfeTO6FEkMf11a6NS6MdUP6h4tjRNkl6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5415
X-Mailman-Approved-At: Wed, 25 Feb 2026 14:19:09 +0100
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

Enable the CONFIG_WDT configuration to fix the compilation
warning "unmet dependencies". CONFIG_DESIGNWARE_WATCHDOG
requires the CONFIG_WDT to be enabled in order for the
Watchdog to work.

Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 configs/socfpga_cyclone5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
index 1ce0b63aee1..80886199645 100644
--- a/configs/socfpga_cyclone5_defconfig
+++ b/configs/socfpga_cyclone5_defconfig
@@ -79,4 +79,5 @@ CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 # CONFIG_SPL_WDT is not set
 CONFIG_SYS_TIMER_COUNTS_DOWN=y
+CONFIG_WDT=y
 # CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.7

