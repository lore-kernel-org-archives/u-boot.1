Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D33C71155
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 05:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBE982C4C;
	Tue, 17 Jun 2025 07:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YfIQ5TV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D9D781E18; Tue, 17 Jun 2025 06:42:52 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6508C80C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 06:42:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFzydylqlqnxyxB2wYXXo5JIH7EpN21kPvDz/onE/iHBGyx+5yXn+nnOx8wS1tVdl+3ds899l6GDzxxaP3rWtHF+U01EYWDZ3xfGKNWvF8YbNpzoHx6Rs+Huu9P5mgen0xVruQVsnsJjUTILDzQhkVE370zmajz/3WDrScBMH8eY1/5zQSIXPRrHpbQ+xOpd91ON3RaZ8cjCvf72bOHf/5KCuKhY9v5TyxelbQH17F2DW0b7pw0mAkQIjvIgMJKytrlX3WsANscIsatpixp3gCEC1usFHLHcXV82ecSzDy6y6fgPpzFT6OcV9Tcvr8u0E/5Em6fo79btBnHUilGN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXlaP2x4ttD6Aum5VqffArIAUAhO4rCIsoCZhTo5nIs=;
 b=dLManVwFGstKdpPt2RLzFzX7BkYq+R5rZsemqZ8xoHCF1IU8v2YoAUwnf9PRqLnCKnR5qYpdsm0IBisQdQb4bXJK9iO/k9M8iMLGSsJs2C9QXsJQRjCkxk10aVfEoKz/ZgmIjrU6Nu+0ZfyBzsauiORN/TaOmJAgtuFFE+VM+A+wj7vyoUeI1cpQDSTzjkKPnYua+2/oyOYK2vXv9xbzqgOXAvjw2uKIjIuP7OuLYyMxHps0qNsryfyu3QsTOGYIQNF3pOo9jdaE2OBgU/BBtiYZarUx9zQJFI56244wNanYw7pkNrxSC/JX9MsVBTtK4nuQCw1dfhvnf0ONXf6jcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXlaP2x4ttD6Aum5VqffArIAUAhO4rCIsoCZhTo5nIs=;
 b=YfIQ5TV6OuAeyDoK7OtEXdYaYXCujwvXuNjAbTZppH9WI0k+54WAgPHRAT/XEtOl6i3MfGnV7BAa5dFlAM5K4Jj7qYtWjh7KpJG1n2iCtNhHC07Dc1qQj5bjU/v/wxUQfIspEt+Gn3ykdakORSq3AZ/4g4VSQ/K7IcRuhuM4/DvDApv/EKNN1nuO4Y221JeIcWRbyILR/tMutSvPYsO/APRQ1CAxZjO+Wa6aZLbyGZUjUS6+9kEcr3lqWovCtw5KKvcQk5Df+MZbxp7V3sCdx11JE4+uE3ujyJ3aeOWIhkSWY4gsk9Tt/FFcIDOsz84bqr5Wq/uFtGHX7grgUzkPrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB5999.namprd03.prod.outlook.com (2603:10b6:5:38a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Tue, 17 Jun
 2025 04:42:45 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%4]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 04:42:45 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH] configs: socfpga: soc64: agilex5: Enable NAND boot with UBI /
 UBIFS
Date: Tue, 17 Jun 2025 12:42:28 +0800
Message-Id: <20250617044228.6637-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::14) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|DM4PR03MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 835d1fb9-34cb-429b-83b0-08ddad596730
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z75/orcQZghm9zWTxudQd1PiXw3VME6fhkXsaYo6aqUeYlVULIuFRVrVWjRD?=
 =?us-ascii?Q?0Q9rZR8tARlv5rIq6twsLHc6knX1DGFX3VxLjDE90c9T8XB5rZwvW4XBigE+?=
 =?us-ascii?Q?MrOSrvxEkzcG7VKNvr7M4qFMAWb3pkOh06abnqdDSrOOF1W8OmaA88oq2bN3?=
 =?us-ascii?Q?LUz+oxTLQhfhLwYtONr32fjjxhI3AbrIBC767SVtazfuV7McX3UoYmscI8VS?=
 =?us-ascii?Q?bLyCiVJEjUqhf4zPLrYtSWnufTdDBc05FGFA4Bo/SkpKEZbIXzA5X1as1HM8?=
 =?us-ascii?Q?SZXfS1JqZHJn4SvmMsCVeQy3hIDHA9dLuFpXWo8yMAraXw8bcMqcLAHkQtf+?=
 =?us-ascii?Q?6ka6x0Suko2s/xDQnYosHPUqB87Hl4ZSOiFEgzh1+uTZHHC0CU/kP7zfu3Hp?=
 =?us-ascii?Q?Uam9kqBahI351rb2uLV/y0gnISkuKGnlRh3HGCpDltDqkUYk0yX3BsfUNP4+?=
 =?us-ascii?Q?/7atho3CaBrhBDZpQ4pfUH8WqZRK13LNlK3Skt9pCViiUnw0a8fREPJW76rv?=
 =?us-ascii?Q?QY/xJK3WvYGSpRYb7hAGPcS+B8lhcoHavw+o7Y3BJyvgZkaotMJszFPmKB6l?=
 =?us-ascii?Q?XUYVtCRsy4HKiBDLo1Cj4lX/Gwr8FCQGC0stl7WCBK4gZ7dIV6Zgx83gC6s2?=
 =?us-ascii?Q?j8IT/H6+x3P50zDfJg8tS1nHHOboC3hl42i9zkZ2TXza3omYr0g4qFr9Hw+W?=
 =?us-ascii?Q?1FoxoSC4/H4Nzqb5GzmNB2nGJ65jI9HK0k1sHeh7pqVlOSniJISs2jZAyvlA?=
 =?us-ascii?Q?mXfSzyP78GwNFQoX410SPUqCF8x5qo0MOLAEBkoEx/3B8UyJZfz0JmaHsErJ?=
 =?us-ascii?Q?u61QEXP9tByLwEW1n/M2nbjqYZOJKqeYmCUQMU+EF1ex0NzMsbj/0QGaFEi9?=
 =?us-ascii?Q?7EBkvUYxKqf7FUo1UyrA60zeIbvqiyCa4k8b4f+nT4CYLZqruqOh1c4sGiqI?=
 =?us-ascii?Q?6XPcuP9d5Z9GuLi4H9Yf21QoDF+JkrdxerZe5MD2ARUPUP4VENudwmgSPn22?=
 =?us-ascii?Q?CHPhwtGajeHHelxoIxBZAJAKkAnmt2euZlBK+tOBY+2FjHNZ8rMIl3Q5OYO7?=
 =?us-ascii?Q?JUOm+jdNjjyLasXoGNYxjv4gEArVwoZxlzs8g0Wty7vk0Zw//IUK9HEffFNC?=
 =?us-ascii?Q?62EGwMKzgFwF/hR8IdnkqOzRT1pho3Adz2ixY1TqUukuw0LQ/64S5kJM/+PE?=
 =?us-ascii?Q?xc4zZXVMgOeEDCseskFVZHNFcMf/9dPNRRkySjrFGYHkaqjwGRTCisSbJ7g+?=
 =?us-ascii?Q?BGE/oxjNFB9csctW/JxsG25zC1+JpUDwoeaDWt04nEg/U/VOl+aqsiskbOcC?=
 =?us-ascii?Q?UYltR1HGin8KkYha1hKiUbgFnW13iJkh/qniPckinGKq67Pto+1UoFlgwaIo?=
 =?us-ascii?Q?2FYFn8kDm2q06y66oq4iYB1EK54SmOJvQ63viiBvCzpSygCC5dvlY/jqwqEx?=
 =?us-ascii?Q?Nxi9bp9Fczw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qGDmT1m+8oMMCdOeGgxk2kBqmtfe+ix0WsaTgrpLia0AQBdjh8rtvZ+G905W?=
 =?us-ascii?Q?xWyEw88rlhYRZUSOuCDLqFjxJpgqZBvzzqkGWwjHmvPdpzyLhOY/8Wlc/8wd?=
 =?us-ascii?Q?sKj8b50WmI+WtEfRAawFuJ+ayWIQESu7kxIY4gpsrFlqyN9n3d6XE1z4tWqN?=
 =?us-ascii?Q?+jIo+9RyRJAGWmR4NkM0aUF8SWhPAk05mmwtkZg1wovJNYB0W2SCgE9/Iyzq?=
 =?us-ascii?Q?4Smgs40QqJCLflBCEtQY2IdVDakQYL9+bTP+BKmi3lxayNjYmFtcjlF9V/EM?=
 =?us-ascii?Q?uAkG3oYf0Iq7p/XX8t740RV6CfPi9qJHGTg+TIHPf7rdmtR9mlE7nuVgjwpk?=
 =?us-ascii?Q?MZSy6i0ANCWBq+l8lRBbAtgfLuB0SMPKVrc0pVBKJNTBOzl3+h7m579Y99G+?=
 =?us-ascii?Q?j5UMHIJ6lY7Qf6FaT1Qzfq6Kl/jTInEsfIrSaWlIPkUUaYxqif7+owVRUlkQ?=
 =?us-ascii?Q?PIKdtWSATZ0aJqxKiF3UIG2XPcZuzD7tDhrDbTQzN9fXulxTyTe8lioUL0BK?=
 =?us-ascii?Q?VKr0RgVfp5sgmTGHJ9BdUR4cZbWaX+ncsKdJ0VG/zk1t3/zmwFO7eDThaazE?=
 =?us-ascii?Q?w7ZAwgE4ECSKDw90cr2702MIpVRoUkDHWS6IF7spjFQIGr+kMInkSXgS+Mgf?=
 =?us-ascii?Q?vVuVqGRwcYD4Mq4p06HsAVQTnAzUkvVCZXVzAbfIe+bX1ZF7/kh1jwI5B3bv?=
 =?us-ascii?Q?RNFHh752VO4YhVC9i36Ye9CSVJ2n18TIvS200DmAx4TXUYaXeBuUZ6rbFto6?=
 =?us-ascii?Q?NxbYV2y6numxsNgOuGYYBkblJw8e4ZxQ8EfKgLG7DOwtrI3W19MU5SWyhWp0?=
 =?us-ascii?Q?XEBaQ5a6UkATKznSi4nPQQQz6sftc+A1nZ6ZpxhsoLCQMrPQlomrofjj8D5H?=
 =?us-ascii?Q?o95cA3UGJll4mfJozWODYub6LMMbdQI/NYKTGB84FBAUmz4XWBDPPdB2rCZJ?=
 =?us-ascii?Q?DUd1NOX8IdInP9SafJS+acmZYwQf6C8lNn9YPZlXXr+PttoSFLSMz2Bhtiw9?=
 =?us-ascii?Q?74QhmPnZizPEyKtUlkqK8Yc9btLJo9MIH2RSHWFYKFhqVK7aX5DcDrzZjoCA?=
 =?us-ascii?Q?SIiBuG+I7Z3I0xBYeGuREat4RKIvXueQWVe/mbBYgLjMgbtjXj5Uz3jzgHRx?=
 =?us-ascii?Q?jiQXDg1MKBv4kXcPF/MZzj2HRZnYWhFWAIWOwDY2MC3kuCOHsgIJeWVPdsXL?=
 =?us-ascii?Q?xKSwk87xrbDVZwxQfGnvYVU8v63QdvMm93TAjfc2BK1L6MTs/WZJxUG8aBYm?=
 =?us-ascii?Q?vECKoTh96JW1Rbx2u4rDgZQpM9WJ8Ru+1rrHmPfdIQT8IMY/vc2FwNYYK6aQ?=
 =?us-ascii?Q?qMMALltRi3q5XEhd/d790L8k0yG5aOGhoLkDqQ5FODS5yzrc0eaWORuaLXY9?=
 =?us-ascii?Q?/+Qn+sLALYqLP7X0uj9nY3Zh2ZUH5+DB0oPAmIeHL6H7iqbIal99yEvd4596?=
 =?us-ascii?Q?M4FZKAVlYSmDOoACjlf8DgmZbztDN8gsNGOa/MLEE+CRThnOPtg+wkTPqZKT?=
 =?us-ascii?Q?PaLVosDWFvQ5OOjueZ1Ql4yr6SHW+X4+PjGPZvKTQQPdDczmvVpYuYjd8Axr?=
 =?us-ascii?Q?6c5AVcvgWe4tseyPYAxv3vdgahMHpykldDM5rck14DdyMHc+yuVeXGfsk1VX?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835d1fb9-34cb-429b-83b0-08ddad596730
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 04:42:45.5056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUP4TnWPZzENKqINHvfYs/a9ss06cIk5kTXN2kmL4dpduWqVTs/+fdngjlIneJG47fDrw5i7kmenwCLWBQcrdJnEP3ZvWwdW6teV8XsnyBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB5999
X-Mailman-Approved-At: Tue, 17 Jun 2025 07:41:19 +0200
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

Add the required configuration in the U-Boot env to enable Linux NAND
boot with UBI / UBIFS.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 include/configs/socfpga_soc64_common.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index 5ed17671f79..145c22f7309 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -73,9 +73,31 @@
 #define BOOTENV_DEV_NAME_QSPI(devtypeu, devtypel, instance) \
 	"qspi "
 
+#if IS_ENABLED(CONFIG_CMD_NAND)
+#define BOOT_TARGET_DEVICES_NAND(func)	func(NAND, nand, na)
+#else
+#define BOOT_TARGET_DEVICES_NAND(func)
+#endif
+
+#define BOOTENV_DEV_NAND(devtypeu, devtypel, instance) \
+	"bootcmd_nand=ubi detach && " \
+	"setenv mtdids 'nor0=nor0,nand0=nand.0' && " \
+	"setenv mtdparts 'mtdparts=nor0:66m(qspi_uboot),190m(qspi_root); " \
+	"nand.0:2m(u-boot),500m(root)' && " \
+	"env select UBI; saveenv && " \
+	"ubi part root && " \
+	"ubi readvol ${scriptaddr} script && " \
+	"echo NAND: Trying to boot script at ${scriptaddr} && " \
+	"source ${scriptaddr}; " \
+	"echo NAND: SCRIPT FAILED: continuing...; ubi detach;\0"
+
+#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
+	"nand "
+
 #define BOOT_TARGET_DEVICES(func) \
 	BOOT_TARGET_DEVICES_MMC(func) \
-	BOOT_TARGET_DEVICES_QSPI(func)
+	BOOT_TARGET_DEVICES_QSPI(func) \
+	BOOT_TARGET_DEVICES_NAND(func)
 
 #include <config_distro_bootcmd.h>
 
-- 
2.35.3

