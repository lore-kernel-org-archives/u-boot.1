Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A98C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 469AE80840;
	Fri,  7 Feb 2025 15:27:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="CQqd8Uu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2880807D9; Fri,  7 Feb 2025 14:06:48 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B43E80737
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 14:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0N/x70jDAqPKeSu754eaM0SALiRN0vstCDYjk+eiw/Exlq+ClqHZ4jRuvxScwvwCV0/iyM4VQsvvXkWAlVg/50AvpjS5rDRvRx64KQOQOMIia3/B85tMU1k19HaDp6sV9fIF0GK3F6rLTibR4oFj9bPMrzNnnivfiG30o4xgZFQCt/04weGMZMbLtkohgnLcSleT02JdWX33/orslAi061GEvP2ybLEznwKMU6vmVfSxDP8MbdXlE35geITEL3EYOVKkXuwoBoRII0aodKn5bOQF1Fla+YFNAedbCf4b5Fg6IFGkKK1MWy9AuroqERt7H/i6Uenh41sN0yozW/fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn0YzbHv5asUv03D8X970NocHrMABG0y6yo6R7Vdi9Q=;
 b=A/btw59Gc+I/RYoZ+cRpzKzVH7EYlJ5FdKy6GwwPmJ12nBBk7X1sCro5acN2+E5DZQUUsLksD7LvdWHj6nYGhozXCy6nwQrC1L/oyV/aCJ33RHpthnV1mzz1ipePiqDbvwUYIY+aXFRILUZX5bzEGGAU4Nb1A66tQTX2+mTtvE+HZBBHuIsjHo8IurJrMZFoxd8a3nzXvnuA/a6tIfsd8Mtqd5Cmzsc4NgXRiaDpNtgfDsIVw0hLgsPnyBpq5T9mhLSYf0QsHevtyjNRRP/nSrzG4YdER29ckqCRiOqt1y1DZR6dD3CoFhhE73LKuhyRq3/NIv91sl7E9Idqg9MZJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn0YzbHv5asUv03D8X970NocHrMABG0y6yo6R7Vdi9Q=;
 b=CQqd8Uu3lHtGI3bA6lxnl6hwJ9fIIsDIGtNwwQeHma3ynBG9OD8Rir4Jhm24U63sEDaTtmWXGTo/L9oAGycNf/QAcAfAwsmZaWRm2SvkLSjHlEcasU4Ef/vUyl7wvbwmYDRnzNZYTr6sfRpnr9JvJrlcENSqBRL//7FiO8Nh8R/PbUX0sL6xd3ZrEA3Rh7bSWvkzVTJa8uSS/rDWt8WQ0TghKHvTr+pwrbcMcqO4xJDS22Jh/l+P0WTfcApLJ7DdiLHime3fDxvIc8b99kWbGjzg/ggFq+Rlf5LKlL02FJsjj7olFZ07XfZ5annh/c348xVR4E1JFjB9Ik1ygzpnLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 13:06:43 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 13:06:41 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/6] fs: Add unimplemented rename hook to FS layer
Date: Fri,  7 Feb 2025 13:45:18 +0100
Message-Id: <20250207124523.85026-2-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124523.85026-1-Daniel.Venzin@mt.com>
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|DU0PR03MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 631b699b-27b8-40fe-12e3-08dd47784368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vn0ZJHcLb0rPuplsWPOZhBGkQi0nVEhZz8j2XKMHYV0xVhbHVrJoVT/hKbrz?=
 =?us-ascii?Q?0FuXXevIkcFdSwn2vClcC4vL2NUdH0kVJU+ltN1JDkVS+FluLUQ/i0V11TXI?=
 =?us-ascii?Q?GO1JCrcVzHnTdG/c0YBos936jFfRPhN2ugOQiGkdOstOEyT4i9USB41SGGIR?=
 =?us-ascii?Q?2lhgu46H6GCt8gqezDu+Ly3IVQzHVrfuypveI8xMN7E6A904qmXAtcx6NDPI?=
 =?us-ascii?Q?TnHJYPkDaDs4vV/0QMf6KLnXoJYMjtfY5j9XC31sVQJIQlY6BtSFtKTzjsHg?=
 =?us-ascii?Q?jFGaF+MT0XxatUF60Xplo8YmL2rydfPR+OaS/aJA3jz5vP3xn54QNC29nrLu?=
 =?us-ascii?Q?LhiOjqZvpeev0gXocenXA1QbSMj2aAUY6/9Ngq9dLVGZz/HZ8lJlTeSr1LXt?=
 =?us-ascii?Q?AygjPocK0W4qxKLe+kr8ICdZvfnERsxvw276mdMmnwvOHOLDBme0Y/jJ01/c?=
 =?us-ascii?Q?2MjN7DSmxR5XzvJk1WVWiZfxK5mRxDww70DK75MA0CU0/xZHpnCUqocU8+GZ?=
 =?us-ascii?Q?81Zosm2xJQTZkCVyax4m2kaj735GfTT+2N+cbS1yVNBVE+addFHCb5X+uF3t?=
 =?us-ascii?Q?gm/VRkdm4bIKQ+rlYKnrhtuCYnqHE4ybvlXJ9ibjWEsU9U/GMpRnDx+jiei7?=
 =?us-ascii?Q?/GoTfeLkPv8f4bjO65gfDWByhnQ3wR9wJA+wsFtfzCWp/ObkWFqp3Ueug1Nt?=
 =?us-ascii?Q?vcbunik2MUTtTekfWvj9zzDP61jhwQty2ezwBxvVWhgMNIEYs0TS9TnOZ9Ak?=
 =?us-ascii?Q?FlUldxiAWAX6eqBpdXGEKXB3y6IBZ/YUHGlGRVr4Xbz1OZRi5eII1/S94D7t?=
 =?us-ascii?Q?wOqXTQ6LZHj5Qafp6FkeX+2CzF8tH/BrSwQIpsJdplDwBoMjKlfjVJfMgPTe?=
 =?us-ascii?Q?xILzaFsMkuPhlU/2vpCFFEfkv/KC6NQu3FEonshX6odLSVQFpnIREjmhKpfJ?=
 =?us-ascii?Q?NvCUzLKN0AU977emdMNS8nxE9M5xTSWBJGW1dL1GiRtTh2NYwbf6ZpvcSxG+?=
 =?us-ascii?Q?tkOHDugUUVi31royAP5s5lgeqdUZoBgKaXqluuxxNajSasZJ8xWcw7xDzffy?=
 =?us-ascii?Q?KsM+vz7rilpKsioexJv835O3kbdmSgokEgycUSBozXXqvkH/yXnUEoltb/WA?=
 =?us-ascii?Q?tTnM8ZazV+eAwx9gk/19XVAIPuynPAHUQGFHh0Q6r4TQk1MaVhewEB79Ti/g?=
 =?us-ascii?Q?UL7vVTG8/MKeQ0euIlXpU9nnhDIM6WXTbG8mdCnxL8FwHuTq29bf1zFZ/DbS?=
 =?us-ascii?Q?3PCkUr6sPo7qkZZidkmHdWhX+Z94s+LkgL0FZjvGPdlT975sB691bZz3F3JQ?=
 =?us-ascii?Q?kBhIM2H+I59Jys36BrQqM+QycX1pspilpN5uv4Fh80dLOuUVXtRQwaFFwwsR?=
 =?us-ascii?Q?zdzxRXtxMN9E0vyIKjB8mebX5ocIIH0wFaAB5Vbez/obKuhlvWSdigBP0bJM?=
 =?us-ascii?Q?gZV41UGR2BJElYNOZbUWaINEajLAOdqw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pS8ftn9lNxXndm67TX/t01i8uE83JN6oXPMeTYhzDkj9I+P8hh6ZhADT2E+O?=
 =?us-ascii?Q?HipGx5k5YU6WhNHhNw5b+mBKfdG+p8bf5fh3WK60NJUZlmNHcvPlB18/zNx7?=
 =?us-ascii?Q?OpvYe3V2PBwVd0+KpoYP8Ou1TEDpIeKb5f4hHlAjtPcB0ibc6BesjI10dAQf?=
 =?us-ascii?Q?vHncTpSWZQMl1YCEKpzbe98P5FXGWRi/P/rS0Y36LFXzgs3KhbAIZ+oByith?=
 =?us-ascii?Q?8VvKbsTV5yQLitW4IXhZNcahdrZhO9jNgzpMG3XiISsIUeQ5o4XdAup/YSKS?=
 =?us-ascii?Q?/43C8xY6YCqcvuZRLEFy2DLidcumdsmudnpWcIsD9e+SYxHNzqoOWsAU+W4U?=
 =?us-ascii?Q?yLdB5EVj/espLOLGz67T9XpLX5nrk1I0zs7lfLbzU7ISltNtzoBde7XtsvyZ?=
 =?us-ascii?Q?3iAhoxEi4T4UVy1LU8DqU8b5D2/uX5qp137gf6JTGnYtdmFwOotNdTHugaaE?=
 =?us-ascii?Q?q/7CtsWcXlpHQ3RVjUz0jCQBys/op8NaWYiGUreGYrdI3PZEA2asdef+2Ykg?=
 =?us-ascii?Q?mtHwaDjRzWQ5S+rsRf/KBZkejbiz39dAr5KiPijCaR5d3SMG6a5jJRfpe44F?=
 =?us-ascii?Q?xds/8SJ114nmGf9sa86L2w3YD5jWlx95I2k82wWuhHCWWoV+PiCqGEz4SEDx?=
 =?us-ascii?Q?aKu2FfuPROSnKsLOadYUupO6w/aH3wYYDOLCIkjtqHkikED2OUP3HdtreYBs?=
 =?us-ascii?Q?5YJODSkYi8OIVKcQhNBWj6oPiSPtE9zn3h1DiQSDQj+a0VmWy3yG22R6tO+S?=
 =?us-ascii?Q?NSp+TM6SIfbfo6lktw7ur6u1mmq5YqMpcAToOk8rdCmn7xjyb3KW8ibEPVZ2?=
 =?us-ascii?Q?raqZbNqQdXDgrlhGqXjN0KGIndD8uATa1QtOvvtxs0zKrWQx/OpWHmV+6MNa?=
 =?us-ascii?Q?9BuPq0i4yu4XS1o7Bnx05SS4t4zTTngBFQHUFSNSdsQOy0wkWMxNRDyeJUT0?=
 =?us-ascii?Q?lu2DB2UhJ5AT0DhMjdr0JAt7LHLc/is4U5ZE1wxU2oFGsWxJbJhIvzTEg0qM?=
 =?us-ascii?Q?uOVoeq78HEjHKuMSoTIjsPR5p0sP6v+wjITYQs+MfHjw+z5V8KmMRpvhh5RO?=
 =?us-ascii?Q?a7qPmSySvbqiXewb/Sm+NJw+sBdV++nOxSaB6Y26/6aOlfpXc1RJTY04Omx4?=
 =?us-ascii?Q?HEyQMkZdElUUvWk0NIdfW0pEKxF/KXg5mFFuDSJnfFCSkskmnjF9n++lgm10?=
 =?us-ascii?Q?a5Vr52kgMVfmiorT3dbLTjrot8wv5VnaWYHYoTc8XNp4usi0gr89/OromqO4?=
 =?us-ascii?Q?iiZqFsxOx9dh8qfytqgpkzZewPch8LFp/ZRtasCLhs7wZTmTHrxMBlWTuDzp?=
 =?us-ascii?Q?w0hFnUcUzAIDLv4rxUU80mprgZUpbF2VtbnLApi23JsjCIOLX3L78h49B+/9?=
 =?us-ascii?Q?ZFLncHB080+fFyZ17olF7uU8atQ5go+2c3u76jH7tdJl0T+v4Z3v23hpwSql?=
 =?us-ascii?Q?MZoDqthH8W/3ZuhE9lZQqbF1YEP9Zw8WshimDzt3/gYUda/sBIrHne4C2coB?=
 =?us-ascii?Q?VZBcXBFmPt866+1yUW7QiW9quA7i6dZ7wyXAYj3DVNW5EgfcrDIIjJQv8qA1?=
 =?us-ascii?Q?aCarAFZOb1vl0hYJeeYnMTzYMDpppHdcRe0TtwKI?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631b699b-27b8-40fe-12e3-08dd47784368
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:06:41.0307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPHF29lFtT1cKBsL7n6Vp/OaFg8NsrWeuXfmBqSNLS1Z2ZtHMPV7BOX/3adjUDTbPj5Kn0gIrXKG4vtz8WxKPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8462
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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

(no changes since v2)

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
2.39.5

