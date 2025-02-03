Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16171C02194
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 13:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38F580243;
	Mon,  3 Feb 2025 14:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="qOQtpt0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7152480087; Mon,  3 Feb 2025 11:41:53 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F535800CF
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 11:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wpt4b7l4QCTtl3/EJ+k89cC3mNT5jJOcNOR3GgD1l/RXH1xMU2lUjkFrVpR7q0WP0hnGhhD/1MRcrTHQEdnk7VJDrCoGcFqcYr2FDHN3s7HuKqf8g6ohG6pIpi+ET+qAGCj4ecmktZDFfjmGf17B6So4b/a7e/0X5W4MbUnOpKTGcleuKVrxuTht+Pw5MP3Dsy0jgEs5SJHaHh8keddvrsECsT4uatVfSMHxCRKyZ6wNfL9dCGElh/GoLP98xUSAZrr+lvOD6WRz9UlkgdncyCnu5RrW6mr5qMdHStu+8sDlZDHUpBFyJb9jpB6ksfDkTtAd8lIXOiuBqPTSy44JYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbP7wASOf9f/rU52v5zy5PIBMeoirRjPxcCOyr8tJGE=;
 b=abYCXXGv9G60B4Hu9xxmNm3x2Uv8s9cDxk1C7mgHGQneVaQF9uQTTPs5JKysLtCa3Csmo++hQ/gMnxH++zTdJ1ANEkmy3o0tbfRreJ3F2ezwukCUBEyKtUuqo5x9S7Bnreqh5QtvZ2q+O9jurRdU78cN6jqm1H3puPGeP1oJLUAmcMDDJ4NvVw5LDk2V/eosteyy49NCyA1ge0ApWJv2JZyPx9PbyJ6tZhYceHmyMxbRbqmvuJfA0OBkcKNMbkooZ3gVOjPzqeBAw59hAF6tLzk9qduqI7N4S0YlYsFpg02Ott3I1Vruq1CuOiJa45d7PdugIqPn6O3PEZ/uKyNr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbP7wASOf9f/rU52v5zy5PIBMeoirRjPxcCOyr8tJGE=;
 b=qOQtpt0zvrxWCqeCYfudDVxGxHU1LvhtAyLfoE/qGCczT8C5kDv3GD1AnnMMf6jkIUCHAuwE4d5d9Khvz8LsrAhMInBivUJ9jHrXRyk4CJCiVtLR2pfhw8c4sUZqzUBAA+ZFHShtzQX2JoPO4VvXOQhIJkzTu4zRd4QIkcViB+84W6/kj0cFY4gW+K3cKJOnERXSgSa4Xpw0a8yz2ystpJSVR2+lmVq5LJMq23HH6HpIWQ+HCFL2rmqd+DizO57a/9tBn391Lm/YzgJVhzVn7ehLUDA8etbpskV8/ajmIyhNX2HXklrRs2Iaz2uFbchJYSpUioOfwp+gWQAnAoI/4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by AS2PR03MB9394.eurprd03.prod.outlook.com (2603:10a6:20b:59e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 10:41:50 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 10:41:50 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: Manuel.Traut@mt.com, burak@gerz.io, Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/4] fs: Add unimplemented rename hook to FS layer
Date: Mon,  3 Feb 2025 10:24:48 +0000
Message-ID: <20250203102501.35750-2-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250203102501.35750-1-Daniel.Venzin@mt.com>
References: <20250203102501.35750-1-Daniel.Venzin@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|AS2PR03MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 40b6a2b7-3301-4e3e-2541-08dd443f5d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5XOY4tePi2+seaVchgIvnjsH0ZhjCoSB32EnhxCnfAmLCELLrtcYaAAdCrsj?=
 =?us-ascii?Q?Kplocpp+UxiU18UWkevp8rcv14I5jOTpEYwLO1KrnZZQOnLU8mkLuCylhfEf?=
 =?us-ascii?Q?bmscdOYtWpm79PS/ax2O6w3vu7iXFrQTQb97HunKRZOV6Ypon6P1jOOioI8q?=
 =?us-ascii?Q?yjyuAYNGwuYWJN7qgWRAtYTi09ixfADJz5S8guUufWx45rK/MyQLjVHt06/C?=
 =?us-ascii?Q?bjmLK/DFmBuNznCIFx3dIa5s56cTNHQYY0n/qE0A2Ta4aiG/Pv6W91BsnoMW?=
 =?us-ascii?Q?jSCh2TXHWsyqKxVSjiLTNzQITAQh+4qpNrKhYM1jpeF3nltRTVlSrthkXf14?=
 =?us-ascii?Q?QyUWUjBTjMnCy/2/zzis06n3g17k4Eqx432K2N9VuiziQB1JOUXFbtKpyWEa?=
 =?us-ascii?Q?GFXNrj2pyMfFuQPMFkf6ibjW94Ao0gBYonYzn0Ml2f4DRuugEJwXPB6mZC+d?=
 =?us-ascii?Q?mxn+5le6FITMUpfionj5vrFFmYO9FsbvgEAYtA78Z4M5F0pqrHcC/ARsjg0p?=
 =?us-ascii?Q?x4ZNOtrNiYzigggXZnr5bYjasOTWHCtsEtzaZ45H0AM6A3rOYCcz08rsR6wQ?=
 =?us-ascii?Q?7NCSUHZqI967fz6HkDFoyr7iLT/m4nEGReZ8JxvKx3MW04bE8mJiImXETFz1?=
 =?us-ascii?Q?756Z6fL/rrmg9yFCgzdykeLPxr5uR2e6eTi0WwUVw6ooeBeJ7aebN/HGcI1y?=
 =?us-ascii?Q?yd1LWr0HljAlSg/BelPbUcvsXN4Rc6iGs6BoycaJ0geia8+ZeB55hMsWOnge?=
 =?us-ascii?Q?v9sir3RQY6JiLAbcgpE63ZR6CBza/ldn/3Km7WAIoGGVgh6gtsMad7k1ipYs?=
 =?us-ascii?Q?NV8Us/Qc6hVcoIF53zSuPej0bb0Wm5r2DR1O2ccGUszv72GM0wW5STGqe9kb?=
 =?us-ascii?Q?u4cKscGzE5SReEU0z2bDVYxD03dlfS3c8yvNdFLK/58uJC+vdawyNoGoU9RJ?=
 =?us-ascii?Q?CNYGIVw9Q2PlW82s5TnNCv64bkxfytwZBkeqBp+8Yg3i+acelIhlYp9JRMte?=
 =?us-ascii?Q?aOB0l8XlMo4Ip+VT+EclkR+X6VA3aIVq5byU9fo+pDtK9124Vv2aIxBi9YWc?=
 =?us-ascii?Q?ZgWx3qdXfPsEPtcW0YzZ2H4WYLTJOY8WN1ms1BQAvaqVWW9w45ivYbPiTbJR?=
 =?us-ascii?Q?o1KbbfGnG/1JNWeamGKa8hccluuRV6SW7eLLRaZDHQuFmuOkYo1IQYJPEQAX?=
 =?us-ascii?Q?/LDbYQkpCxVjBjJ14vw/imKuD5zTveEFyRuoN5qhTqYXekRRMHT/4c5TMJaS?=
 =?us-ascii?Q?/SSCJKkCMu0ecW8q+YziXCg7EDav6s90u51PsJyW9t/eULAoMB5VBDRVGZYy?=
 =?us-ascii?Q?mQajdXAyNGrJW8/91VLF7zS4Fb4nHtCyDY11fc8/d0zaNucguyzkqpp8ySEy?=
 =?us-ascii?Q?B+1szrmV7AgSfI3jYL4/+1R1O6xsu+YjcE4GxX8+FPjri0lgw7Mxa+5lrKH+?=
 =?us-ascii?Q?SdAqQGk0wC06AiztAgexGdoaaLqUlomN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1ik//7hGOsLe+17ZDjCEnr4KwiFkG/CBQ/sOV3GeAuXs4g8DYi7YSySIW1Q?=
 =?us-ascii?Q?gwIcS1Gdm3A67/H9ll5zdw3o93FFvr7LNqc2SaLwA2sevDXRQ+XlRPYzj82+?=
 =?us-ascii?Q?pzH5E+yPAgsniZwB5VKNsOXe1R8NX4ydTGI3MdSs/kZ3zFlnByWa7L2g2eWI?=
 =?us-ascii?Q?rFOXB6CQJPBiNLEAt84f4xwdnJTmDIKRtUuIs2m+R8lPH5J3zhF0EGZtHS63?=
 =?us-ascii?Q?JRUhmw/uxbZuGOZyl1955DzB6YgpYT8HRCX6eJ/x9hg2fPiGop9+4AdlSm/7?=
 =?us-ascii?Q?fRDM2Ed1C3kWXITxD3AaUjvX8IPFhr4phwhkG4tdpzZEhimPd37Xi4oDnsmC?=
 =?us-ascii?Q?uUar9GG26cRc3kxAOVcsPyUiVn2QujgFpG27w95+BHNDB7I81lY/VKTsSApb?=
 =?us-ascii?Q?nU5iTpi9JuHuaKItIGy3oMpcGVd0lbB85DrKtOImTw4YNxS2e+orOwXtKYHB?=
 =?us-ascii?Q?KQolYODygUMqdmdSioXathnPfcFLpu019zmNqI+EtPhrctq7ySHjG52iexC1?=
 =?us-ascii?Q?dk+CYvd3J/g3BFsISX3AUdrVrcf5ORSOgYGrAR77NtyvqePZOgs9TrVkrTvh?=
 =?us-ascii?Q?+ISAi/LtwrF8m6N90cs5PH1o+Jf4mCqzmRysVCA/s8ndJ7phwGMXvasw0417?=
 =?us-ascii?Q?roP/SiQivVXt3rY+N/aQw/I1MMe0zvPgDppn+19ujBnD2z0E2O/70h2586HB?=
 =?us-ascii?Q?azPcSrhIsAy8pxwX5WLMIRW7wBM+8v+sRMKpkExCwOImIzOzjqucgqTliH+5?=
 =?us-ascii?Q?4EWenfFN5FAKHILEBVt7teINQph8mO1CEa84gK3OycdlPChaOoRIDH1NbKG7?=
 =?us-ascii?Q?r3xxs3oY5yLhgS1rlXSBHvSdcx+gMCD4TkCtsJFuTQBrAbDsKHE3BYPML0s5?=
 =?us-ascii?Q?9qOoWxGNLNxmDaBtj8kr/66g8+y+2V7+4TKrzijZYW2+ErOLxjJ1/XAa/BMA?=
 =?us-ascii?Q?G7ZKdypiiSV/xE5yEVONEF9CvRmy/9NEKUGzkF51Si/q1s92Io82qw2IJ6QW?=
 =?us-ascii?Q?DO4TPcCr0xTPyLjHQGkllzd2A9bfzJnThvr9BwRV0CXkrV2b4gm8CMx9DXn4?=
 =?us-ascii?Q?eLL/A9cs6BVYxp1T3a719gxrsDJzgtCF330SYHMUFJsDjE8v3My5C4Vu5UE+?=
 =?us-ascii?Q?6436PhntNLSOe6Z+xXxpXq0EQK3eDENvMWQp4kyPxemS3N6rQKDzOc5HPcSq?=
 =?us-ascii?Q?BPfUiWRfTepPjqfc7gnn7Z3WP5R2pFROV3fs72Tp6EcUoD1YUZxRvJySTtEY?=
 =?us-ascii?Q?D5FjlA8CJKxdAQAmq7/SBfbFK6oRnGrBR9vIfkKJszQeOJhdPDZQeiRzVzlc?=
 =?us-ascii?Q?AKpksTDsMgCGZIiBjIy6SKCzwca+5UXcaMc9nkh1p7mb+elQArJU2tXpIvdt?=
 =?us-ascii?Q?Hk9IrPo4ZhSq+IzC0WoT6mQ687yoShjOsvUwmj4L1S7eu/Y6eCf64CYyt0Dj?=
 =?us-ascii?Q?HjrxmU976IYQtUSIZD6cMawfuUiFHvOjdjr1DLapEQSBJb89pB9Ubtvy/0r5?=
 =?us-ascii?Q?QZCzj2deoDKujG1pbe6f1Uqlk8bkAlgQb4qHIT54Q96rv5i80HPsBjT06Cx3?=
 =?us-ascii?Q?l6gObc2Dtoy3gY/+RRZ5NJ2ZMmMOQk6Lwmsa7z7l?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b6a2b7-3301-4e3e-2541-08dd443f5d70
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 10:41:49.9636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlF42KxCOeUgQDk3tquCGtgEYzZ/eRAKAtTUQXVCiMazJMaZ76Fi+WVxIxl+9PVjtGSQ0AQkOFSShseanvmacg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9394
X-Mailman-Approved-At: Mon, 03 Feb 2025 14:10:19 +0100
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

The EFI API supports file renaming, which is required by
systemd-stub for its bootcounting implementation.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

Changes in v2:
- Adapt variable names for better consistency
- Add missing rename hooks

 fs/fs.c      | 30 ++++++++++++++++++++++++++++++
 include/fs.h |  9 +++++++++
 2 files changed, 39 insertions(+)

diff --git a/fs/fs.c b/fs/fs.c
index 99ddcc5e37b..b746d05ebcd 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -143,6 +143,12 @@ static inline int fs_mkdir_unsupported(const char *dirname)
 	return -1;
 }
 
+static inline int fs_rename_unsupported(const char *old_filename,
+					 const char *new_filename)
+{
+	return -1;
+}
+
 struct fstype_info {
 	int fstype;
 	char *name;
@@ -182,6 +188,7 @@ struct fstype_info {
 	void (*closedir)(struct fs_dir_stream *dirs);
 	int (*unlink)(const char *filename);
 	int (*mkdir)(const char *dirname);
+	int (*rename)(const char *old_filename, const char *new_filename);
 	int (*ln)(const char *filename, const char *target);
 };
 
@@ -201,10 +208,12 @@ static struct fstype_info fstypes[] = {
 		.write = file_fat_write,
 		.unlink = fat_unlink,
 		.mkdir = fat_mkdir,
+		.rename = fs_rename_unsupported,
 #else
 		.write = fs_write_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 #endif
 		.uuid = fat_uuid,
 		.opendir = fat_opendir,
@@ -238,6 +247,7 @@ static struct fstype_info fstypes[] = {
 		.closedir = ext4fs_closedir,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
@@ -256,6 +266,7 @@ static struct fstype_info fstypes[] = {
 		.opendir = fs_opendir_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 		.ln = fs_ln_unsupported,
 	},
 #endif
@@ -275,6 +286,7 @@ static struct fstype_info fstypes[] = {
 		.opendir = fs_opendir_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 		.ln = fs_ln_unsupported,
 	},
 #endif
@@ -295,6 +307,7 @@ static struct fstype_info fstypes[] = {
 		.opendir = fs_opendir_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 		.ln = fs_ln_unsupported,
 	},
 #endif
@@ -316,6 +329,7 @@ static struct fstype_info fstypes[] = {
 		.opendir = fs_opendir_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 		.ln = fs_ln_unsupported,
 	},
 #endif
@@ -339,6 +353,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 #if IS_ENABLED(CONFIG_FS_EROFS)
@@ -360,6 +375,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 	},
 #endif
 	{
@@ -377,6 +393,7 @@ static struct fstype_info fstypes[] = {
 		.opendir = fs_opendir_unsupported,
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
+		.rename = fs_rename_unsupported,
 		.ln = fs_ln_unsupported,
 	},
 };
@@ -697,6 +714,19 @@ int fs_mkdir(const char *dirname)
 	return ret;
 }
 
+int fs_rename(const char *old_filename, const char *new_filename)
+{
+	int ret;
+
+	struct fstype_info *info = fs_get_info(fs_type);
+
+	ret = info->rename(old_filename, new_filename);
+
+	fs_close();
+
+	return ret;
+}
+
 int fs_ln(const char *fname, const char *target)
 {
 	struct fstype_info *info = fs_get_info(fs_type);
diff --git a/include/fs.h b/include/fs.h
index 2474880385d..8c1aa9c1a7b 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -270,6 +270,15 @@ int fs_unlink(const char *filename);
  */
 int fs_mkdir(const char *filename);
 
+/*
+ * fs_rename - Rename a file
+ *
+ * @old_filename: Name of the file to rename
+ * @new_filename: New name for the file
+ * Return: 0 on success, -1 on error conditions
+ */
+int fs_rename(const char *old_filename, const char *new_filename);
+
 /*
  * Common implementation for various filesystem commands, optionally limited
  * to a specific filesystem type via the fstype parameter.
-- 
2.47.2

