Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D2DCD342C
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 00:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E4A8490D;
	Thu,  7 May 2026 02:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kVGFpAGM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2497E849BF; Thu,  7 May 2026 02:54:52 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 314A284903
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 02:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXEsTV8Bv4fkQsLQtJ/PtW4zWNqFedhYpWHicGNgW+QDVkXyOSwUAxfHtwU9YeZP37aNKPRmt1IL+T50f8Y38T3fJZN2ytv4jkMDDisD+Wms5mYfxnKhvVIbng9IGXCmGNRx10eEQFPuoCGw8iii2UOGupLOp1QI3LDQeGTGebOXtdNGoknrY5dIoFV7YyiJAGCxAd7H9ULxi7WmU44TLUqvMwDsVJwMzxF2BreHIacpfJauDakYo7MLSH1dCn8+jMz0pXYiPn02/E2qOUXd1BVBSiStlZmMX9IhNZmg0xhakRrdn5sTFcbfz9uOH+98i/YhPcAkK/HnUtlqJDCjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywgFjtostnnDOX2QKpKQxQ700GrZedwbqrTSReqVNy8=;
 b=UFzE0GTlN2q+zpsJva/TPKAnmHPeuTMUlcS8UDpqEc23/SI+Ss3I61Fk4xA78vA05XqRlrzr81ct7Vk8h/0bo1tL3F2ojopZD94aC3SNI2sL1dd5u3tVgg3AofB1VVph81nD+B1y2XUZrClSq/c29s5cofSl4+0/zjNcGPXfktVxgU4pz7MaheLuHNA+sn++mgb4h4sSUs3FywOMs2Jwb8BSwr8klBkVL42SnNQx372mbtuH/i7Sv4JhAbIHoFu12U2VgjovNTGDz9RZWVrTd8bnVkN4vNoTbeP5xdBrddK28QhYtmSiVtrVfX2yCjNSmRAGCl6c9PWPaVjKXtF/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywgFjtostnnDOX2QKpKQxQ700GrZedwbqrTSReqVNy8=;
 b=kVGFpAGMaqBl+e7p8cDPtTKkRRNmiiq69Kn40myYUglevmJT8Gi4aa8ACZbwGo2E1y0ARCRW5lic3gDzMVCO6F6r+EiDZsLw46zacp4CYSKMTLCFJhMqsHcTK+35xeSilxApYxIeiMXs7sgXerZI2YtqM3nIBNSm7Hs31QLEzp6pX9BKgqAVHA1nRWNP/GcYPL80x6E3k4AO1vxg89qG+ehGCAj0HfsZ///6jgrDr/bcdDNkfgbMLZJ28L4NeQ3hre8B7Xl7Meir+1aRpLRj7rHPa/D8XAYGpHdKzBn+VqgEqL+hZq1YSqonj66lZwcVuspHdv/SdnaluPSNvLK51Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SAWPR03MB989177.namprd03.prod.outlook.com (2603:10b6:806:4d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 00:54:47 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 00:54:47 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>
Subject: [PATCH] configs: socfpga_common: Add fatscript env for optional
 U-Boot script
Date: Thu,  7 May 2026 08:53:58 +0800
Message-ID: <20260507005358.2340-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::11) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SAWPR03MB989177:EE_
X-MS-Office365-Filtering-Correlation-Id: 12da9e19-aa06-468f-ca84-08deabd33c44
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: eFfquHV7yXLBN92UmJ5MKHLpb/J4hwopm5+7TJbHCgS3sUlui7wx2qO+mYXrt4Z/NW8qyPyU85/cw2IxyVCvV1vv4kHZwLwL+fdeZsGzwYTtHi5WCdbjQW0vIhgk35JCUbjqvKqG8F93ofcKrQyQ1hf+a7sqfglQeOR9W8ixoWCmWVLcSMEjgaC8q5ChFJxpGXypY6FOYnharWr53YxSGxEGkx/bQyUuq4o2J2VxIA1ErnsXGSKtVSSa7qfDhH/QuSW84Kdeg/07CcjMSSOClc5H5Fnee+bx8mirWR/iwO8FZDQP/Iwy+/+wckpSB3uO9PLIHa3iDinAZTR1nQrjvp2BY3nnYpNi/UNFnZ6v0E/d0rrYUIr4S0mtxteVAzDbqz7PQY5IMZx4YZeTaKqCNfz6cqQkcHA+3aslXw8h+doZlkp9rkYLlgSDb1I5XyBF4ahMPIFlmtuOfY0gzFRVJVluJ0vUxNBEd/smBN07kpBkbwfPML8T0Y12RWcPXk/iXoOK3jKXiEJWJl9t/9BrVMbRX/MVYr1s6Q3qmjf+1S6l/DkoPHebqXd32wbl2JpV1qziJygIL2TSTTF2HLYZ3zLliZHnl7rrJ3hjZpvENJ41YmfpUalKbdAXbJX7soIRRPEtRuH2PJgRcfPpcPxZ2Tcxiato9vA886MRXsSNXvZoVomnj2BKVkqMvQIjNrwj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bZ/T8uEO/jQJK77QP87bK8KE5k8VOrtEM3IuRs/PkSEwVSxAjQuptOsuMaya?=
 =?us-ascii?Q?K+L4mAIk8qpFdFJTjdT/O5VcLO4Cn+dTCBHVpNelb2XakgFDu7lE6iikNoIH?=
 =?us-ascii?Q?IVhCjThEpXk0B6CIKfwqv++oZp+Wz+XoDlyqACgkFLgFblYvpwhEdh5G4Q93?=
 =?us-ascii?Q?DaO6Q+yDZM3eA6J/5FKvlniQwB12RvBYLbrB6gEUj1HLh4HC1qB2tIn0ODXY?=
 =?us-ascii?Q?ZzwBweoPH+qHkQl8z7Au66XtWAe56dRX1M6SkjXRSF/C/pzzOPvJU7pnKnTP?=
 =?us-ascii?Q?vswTFL5i1zlfX5NEZ0yOW5acop1ZKt/rWZm7q0e3sVlfCEsavtwZ4iVq4Bpm?=
 =?us-ascii?Q?tUsbxbJSs94Pw7kKXwcZ3CtEzkx4K9ByP1wekQU2zt+iNw0YA3ym5Sh3X7TP?=
 =?us-ascii?Q?RW4CJxqbkPb+suyCIlTs7UDDuBY8+/6Uqz0VEcikfSod353i7B/9HOZqbA1U?=
 =?us-ascii?Q?ePxhoImntyCzLHqW+a6lreofk0q18Af6NQ4ynOhZGmXQem/Jr/PPWIJSZCd7?=
 =?us-ascii?Q?gvxI/V+0x0PK+HUVm2QA31uQXUMezMqqsYBzb1QAJWjyAPxV4skUy9F53/ws?=
 =?us-ascii?Q?JhfmWBvheoM16AMS4/vMr1v/EYeQheTTbadHtnO+MaW4Z5Doj8/fboRQVeFg?=
 =?us-ascii?Q?O7fMXOPwmlBlq+VLnCny9tqteNUu3MRO8oclpSYv7zVFFs4WV3DqwyvkT7kt?=
 =?us-ascii?Q?cTNU0mykbyw8hgO3bo7+6qK5LaBh3y9CEy6g/aCtxt1MdH1vhiqVtvq0FO/m?=
 =?us-ascii?Q?/IyC03SnT8BzXmNkxWw5up0nr0//lmc/GSAe51i3PF8KNuPG+OejoPnbmWXZ?=
 =?us-ascii?Q?vPscMMXSrPUZCReM6VywMYC1h4ALDJTUugwyjDxdGBWYqZMnjXWrer3jND5F?=
 =?us-ascii?Q?oCHnaJDiBqMlmyK6HoHuYBxMf7Ck56yNfqZW8h4eEzXKG3boIwuSdl+Vdwg1?=
 =?us-ascii?Q?bGJWf8WtP4g1uwMZ7meJwuFty9m7n1L7cFSfj5xoN3oDR0bt/oCXZTMlm3+O?=
 =?us-ascii?Q?+/EYHjw4KbI3QRrWabxsxdPD08h4Pl+fFVsICWi+o8PslQARpkvCZYr0Hbxe?=
 =?us-ascii?Q?5mEATaT6mGKLNnMgCx1ZZi7V9FXGbt8rUZwTurKG8Spmqla/yyqvw+PxVzPt?=
 =?us-ascii?Q?bSpw/LVpwIN9JVuLwzyn9F22X/4rQSD43c3y4Lxw6pwaIGY11AsEbxju4sMm?=
 =?us-ascii?Q?9pO4CP6rKtY+94FTbAKjgI+fgpIznxN+5Yjsk9/XtqgIU8BsH+BpP/8bK+/M?=
 =?us-ascii?Q?+yRAtcZ1CBEF61+CEgvbnU/d6IozsNDswktui8HVGu1M2+Bi2mjsWJVhf/0f?=
 =?us-ascii?Q?DnbH1oZz/p8KUeVvwN29Metf/uIdHQkeRBqt93fm7momcTjQziwIgNvvs7ud?=
 =?us-ascii?Q?FvPJy5fT2tqwxVqSseKZKT/ZoNP7K4u7mQkeORLei8F8We1ztsBBeK2tXQi3?=
 =?us-ascii?Q?9nZmE97sSq6TfuuwOvQs/5n9hKp0yStwH+fet33sJU/w2nIvGZ9WYp4Wc+c7?=
 =?us-ascii?Q?6B3GlZp5kmNM5kFJKWCcjXWgtmE7mZHUti1dIeYTDda2S90/zGKduEs6ObNF?=
 =?us-ascii?Q?jtpkY4SyQfrGn/HDZSvVrHhFj3nxiiNmanYHmUa1gzf/iC4A1ZB6tSHw4e79?=
 =?us-ascii?Q?8lHD94HYNFUXAWg/qjmVVfNWwoBCP4p8iH+RiIofPFQ9fAMZ3h8jvMAQhjLl?=
 =?us-ascii?Q?XjjL0SmDlvpGqPBkuNsU29cYRjEW77xOvF8kc7aB31KNqKyA3XxKWVs9HeQq?=
 =?us-ascii?Q?M7fkTS/yRx4VfMqIUvcBim5A+3Xc1SE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12da9e19-aa06-468f-ca84-08deabd33c44
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 00:54:47.4032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3zRewczBOkofq9AbiMY7kmNObzXKhE3491+J6q66wjC/wclWMxWZv+SonqjCxlPoMYCP6Rz9cpGNE7erAc9lYB7jbinZxORn4alYH5ka8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989177
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

Add 'scriptfile' and 'fatscript' environment variables to the SoCFPGA
common config so that users can drop an optional U-Boot script
(u-boot.scr) on MMC partition 0:1 and execute it without modifying
the source code. This is useful for board-specific customisation such
as register tweaks at boot time. The script is optional and not
required for normal booting; users can invoke it manually with
"run fatscript" or include it in their bootcmd as desired.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/configs/socfpga_common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 36d6bfb3d03..ade020bd216 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -151,6 +151,9 @@
 	"kernel_addr_r="__stringify(CONFIG_SYS_LOAD_ADDR)"\0" \
 	"fdt_addr_r=0x02000000\0" \
 	"scriptaddr=0x02100000\0" \
+	"scriptfile=u-boot.scr\0" \
+	"fatscript=if fatload mmc 0:1 ${scriptaddr} ${scriptfile};" \
+			"then source ${scriptaddr}; fi\0" \
 	"pxefile_addr_r=0x02200000\0" \
 	"ramdisk_addr_r=0x02300000\0" \
 	"socfpga_legacy_reset_compat=1\0" \
-- 
2.43.7

