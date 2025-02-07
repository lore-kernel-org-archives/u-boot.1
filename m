Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20487C0219C
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0EC80A23;
	Fri,  7 Feb 2025 15:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="R0Cekmrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414AD807B3; Fri,  7 Feb 2025 14:07:07 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB33801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 14:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MV9tnHpkhjtZv45J/bcQ0qcD2RnWLUKdxjAPJ5agfrk54mhebkSg/1VheYtXIgzwicID+d3iGTWRQw8sjJT8lxk74vUEZHaB4ku6rQqcAAIoERu5omzY3+/pwb7RCu2ghpXIcBaUu+zctgoTr1hEE1WV8ff+SFt7mwO7cgHVOBtCpW9b1/fa/NsBIBVnDho+ok3PVEve/BA8TWnlK+qumNol4pPi9n5BKnsToi1LTn0Wbb119+qUFMJZf0Uquqw1cRTAFhIVi1MnX0/djcXe76m0oESrAkJ6YDcetpsF43SYAqdzdoVMdRxSUDG/gkJ9XKz5OccYknY6ZChic61wBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC209i2vofccEoyvQItpbzoksl2rEHdYkOgz4+IXTXg=;
 b=AaUX4JUB3yteq1avnysi3o2uubskZPvMjKxIHGNnrIfzBiAhTshiZzVnRhJNQQfpMw+ZC6YpUjeDyNUFz7xIqmg6TvZCjb2GQV0LP5ijwsa4Yywad7+WiE3OfvnFYuuOx49FdFS5b9RoaLSkR+nqyz/VC4p7SdTpprEi2LNXgm6TZclMXYwT4FKai/sE9X25k0Wiz4yeoK5liaI7Z1tgFII2peEMVJgzn0o7yun0f8rXZds0AjjAMTLUWl4/cEXmJc+OMKF0iIKGdODcFNNJgysOI0KHrP3fbgWEohVhOGw1TXs4ojBCIvUq5uBGTZluFDWwP/UEaEuvPdUENaRbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC209i2vofccEoyvQItpbzoksl2rEHdYkOgz4+IXTXg=;
 b=R0Cekmrm23zj3Ra+m5yNtY0Ehh7FsY8bvp1Wf/Q1v2Z5h3l+wUcQNyWf/grtdoAawYyCgm3dBGM9DvOtafQ8lpGnZXG2Ow1dhwNLkkaBrvR01IqujveSRpRk2ikJUVANRuDstYRnIVLEMF2c/yb7zsBjtRDbBTNPyK8U7zxTcpHj6RnveqyRmKKFNp8pBlFAiY6XtbKePmcBGwYRw8UFmu5JyH3KZst68xASncrpC6QG5p8Q2DPhF8UF+M2HOu1n1dYUtgIOw8Rtgf/mck/cqFLf5tjAtkdbcR1RGBShYyuKZiLzvMsapE02PMy3IIGQtzOPs1B1SSl+fz386yb/Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 13:06:49 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 13:06:49 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Daniel Venzin <Daniel.Venzin@mt.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/6] cmd: fat: Add fatrnfile command
Date: Fri,  7 Feb 2025 13:45:22 +0100
Message-Id: <20250207124523.85026-6-Daniel.Venzin@mt.com>
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
X-MS-Office365-Filtering-Correlation-Id: b61022f6-eb8a-475c-4019-08dd4778487c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P00xqFWDr80Dl+4yZjQgOGZ+evnu9pIRklb/OhSlsHigj7QUVL8OZUCqmXGL?=
 =?us-ascii?Q?Q4V+M4pGyF6A+KNXMiu4Adzi8e1kHKyEZKfFIwbpac9Q0SXB5vl8rBrnNzKN?=
 =?us-ascii?Q?vPyjgA+cIWtPNzFZCinhigjfx5lxLHUO0XASq1Wh736Syzx12sWsDJtKbl9q?=
 =?us-ascii?Q?V6vrdshQednxx22KAtwSjlNe66gEbxe35QGJ/vbd9l7MrSaGAJ/qsKrEYVlp?=
 =?us-ascii?Q?z/8EUWDXf67EdVbb3OVz7jOMEKSn1RsQSVeRxeoJdz3G6xJlGrR0P2YE+w/b?=
 =?us-ascii?Q?lCuk4JDB0YQbkJbd8LcW+4xlm3hakg17AYNg9fWHzS9jF9IHwt0vMV5/8cXK?=
 =?us-ascii?Q?JADpdfsEhgzIQmoRS+kgO3iXPGzSNyKIh0ifp//T66rURmgUQqn5loE2ae4p?=
 =?us-ascii?Q?qVyWRKBVymS+FrvwEfTDXcZGwY7YDrxkQ2m2PtrYPs11eqpbCCTJHbLRpxGu?=
 =?us-ascii?Q?aQV6iNag2XQjI/pYS+44HdBiNZAx9oPLRrr2llDSsd8lr7NY2D4HX/kfQtVD?=
 =?us-ascii?Q?A1bqsQCII7kn6/Xt3IMTCQuvChfC3MVKQGEHKWT9Rcz7cgaJOx8kcPvJpXM5?=
 =?us-ascii?Q?b80zYSuW3fLkVr1GsM2EhB1ip7erQmHkmF3jEPlHv2Prqtd7LACBYtBgZZAt?=
 =?us-ascii?Q?1EqfYHEbxW+ayoypyLKV2c2ZSlu8yqSLh1XKQua4nAaK9p7zZzsKNz+6boNI?=
 =?us-ascii?Q?jd2ftY3qfvRXmYWupqitOjGCEpFP+8cA1K9amJfGNq0pvGFfvdmUq9+k/qaS?=
 =?us-ascii?Q?CD0cEXo3iI6HNdTft8WGcINz2V1wupdw8hlaEcxEmT6EkRvNijL4nE5BtOuE?=
 =?us-ascii?Q?eQ7GlA+gnSOPSPMK9RqcZ1jfGBRMRFYu8euRhrnpRATi6p3OnRcFaDUCbNVF?=
 =?us-ascii?Q?rXeOTfx/fKgXFUro+w/EnFpbJRhUZx2IoHSDpaxDdnSCmzIB0q7lscj3QCHU?=
 =?us-ascii?Q?SGGs0RvBH2q3R5BJjrLs3Aogw3cq0OzA+z2iQnmei9xOlV95ljw5IHIZhCSG?=
 =?us-ascii?Q?inQ9gbgaeafRM+4II7QmZ3W0J5iR+8iZfjyHkqSKXKJ5sJ7Zr7npZtKrIjxD?=
 =?us-ascii?Q?5cnHebs8+7r6gOLBDpLfWDDL6zpKdRgmI876XpAM9fE6Rl1UVSVaLcj9mFWt?=
 =?us-ascii?Q?RLVD8M+JHs2QWzYCQ3X/2ZdnD+pa0Th7gmXCwlzJCc+TGs2HZJAsJ8kEDI+0?=
 =?us-ascii?Q?OZBN2By5es6SxbJQJXWsXC/2gSOAe5AhKQv2UTzADV2Y8Ycet5QTY5y6iBih?=
 =?us-ascii?Q?Vd0RrxlrzOicuWKnbYy0/ZrKWrZt50zPMLTiCLsUjhWjYi97SRdvxlbKCwQr?=
 =?us-ascii?Q?le6DXt3evJZyY4eoyJUuDJjqWY1uZgVmgxhK0oz3ncwDKn2K/Ci9UXug+pfu?=
 =?us-ascii?Q?NVSpDAtBiIlt4S1290XIoIizlxVQbC8oOZ0CA5BrBy7KI5yB5uUTTuLFjKVM?=
 =?us-ascii?Q?E0qVBRS+YEjMTbDTeEpGaHXFDKv4ljTq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IksCZwsF4FQAbp0jw+WqY7/Tio5fSejpQFwpOVFdJTTm7YcSTLqym6FhOZvh?=
 =?us-ascii?Q?g/qFUmQrVXetVVZTB6PuAnKAglrxUsenc/hz7d8Iw9jTZa591Mp7edveymO0?=
 =?us-ascii?Q?CjxHCY/USVKeMX6mtZub/vYYHuKCFRbP+5YN+YSHmGv7+RRayNE2QblKxBYs?=
 =?us-ascii?Q?ufBnkLOOBr7UczOjzhWlbKJnJJChVzWVWKVpPmf/sK8fjKCzhs3tuPiXXd0b?=
 =?us-ascii?Q?tLh/oaiW+a5Nqk00v8Ju+xCMo7zZnEcLphBcPGdjmXNYe6lVYAmQzMS8eRIi?=
 =?us-ascii?Q?z9kyGDa2+92LF2n8ZLoOr1lBoqq8aSng5WHHfotL3ppN2XAyqdXwxkPtjEhS?=
 =?us-ascii?Q?svAUqPbTbX8z5yCc4cD44JXVZK7lSsXxeNVfC7OLAxAT5+tMY8nDuuAg/8rN?=
 =?us-ascii?Q?XVGAOaM5stdBKwxHJXWa6TnxtWsfXzpvcbcPIxLo9r95pxlpkjeZ34atBohI?=
 =?us-ascii?Q?XchEoywIqR3EoaDEJBy2lEDiIdfXt/UKgbWqaO2e5XmtDRyN098Zv6s+9xiV?=
 =?us-ascii?Q?cu9j5f/oPxU/bQeh21pyegoEzngPtwaZkl7y/bconU6ejMc651S+h8dGSDZ0?=
 =?us-ascii?Q?85y9FHurxLCQzdzFsvxhSY5Vw5YnduXK1e8wWq6oCT5W0IEMuTxJsmfJSN/e?=
 =?us-ascii?Q?7e9k134HeVum7h6A0H+nOZw73WUPLR++LkhpJMWrN94KUhSmteHehHI1Ff9+?=
 =?us-ascii?Q?CWTRSEVGpU8IH9Z0wGqHZZLvJ3hvCtJUEXelHVAfh0PimMGTvcdZmqcXPUn1?=
 =?us-ascii?Q?UolU75TCJp+UuHRlC4f+vrVhkOyxovs1cG/ZZHFMQ6KGypPi9xEL92c9MEo3?=
 =?us-ascii?Q?yKLYUxc8qY7Xs/PnC9W79b8A0VjJuz3IzWcT+9PhvakELpb4eCmLWF4OPZ0u?=
 =?us-ascii?Q?wVK2G7XQivdMYIOMwaZQw8gg7EnMPrrNadUhzkH9k55a8UZZGAe9XAuI0ZWA?=
 =?us-ascii?Q?jSD5QFAhPLEJ00HjL6U/e2BSRHTmwBZvrUCK8s4sMoFz9YK+ElkSmPebU7Wt?=
 =?us-ascii?Q?AInaBJr5mc28jG8sV3FfWCNHFrBAPJqtq4aOBDb15rKgzurYNtQqQx9wEINP?=
 =?us-ascii?Q?fMhJSpWyXmmGfQQXCA4mhaOwTzz39BMbDPtTqCc8XFdGC9qoTQ+qx1XNy4Nn?=
 =?us-ascii?Q?Yw6XLLRSZ0O205Ucgc4+qfSmyFjBoMn3hOAxUpU1meGqSJ/zPo8RSLKB6m43?=
 =?us-ascii?Q?dJu97sBQK3h8CvU5rDYNYvA6Se2F77ZZhwJnuepqmzMlqtIjmIwaX+CL6U5v?=
 =?us-ascii?Q?DEGxP0svMqkg1KBDY6dznPLb+R1wlWZmgVz1ydSfNWjjGFoEqsE/uFwcmIi6?=
 =?us-ascii?Q?hKVjZjYPAQSyqBgUw2NkcngAGzhMRMqgjY2ojX//OI5xkQCr/kc5IkF/MrQn?=
 =?us-ascii?Q?LMcyda9NNUT5P8ZS3ldmu3CrnWp+LpR37QsrKC0W4SV8Mnd8Jp7h/ZO6m58h?=
 =?us-ascii?Q?DZGvexg5YIe/H9VEUz6cZGHEmgI+FXCrFBv5cKeClbxd94VSCecjJn9KP1UM?=
 =?us-ascii?Q?/hsuZen8z+AZqxc1B7j1pkkrSTsRSvWKdBuWMv2y+Z7B5VzGby3T/f6Ld5fM?=
 =?us-ascii?Q?QtkUKAmhXS+q/5wGgjPSUvVvwec4DQMgGo/TSqGn?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b61022f6-eb8a-475c-4019-08dd4778487c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:06:49.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn1JU0Y2VgYgLv8QkhdXHAUu4WfctGNHVfPrp1vRg6XWLDv9Ra/F5dP7VUkIsmxhLf24VRSkP2550B2Co4D0IQ==
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

The FAT rename file command supports renaming of a file,
used by fs_test test suite.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

Changes in v3:
- Add fatrnfile command for renaming files in a FAT file system

 cmd/fat.c    | 13 +++++++++++++
 fs/fs.c      | 20 ++++++++++++++++++++
 include/fs.h |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/cmd/fat.c b/cmd/fat.c
index 5b7484dc1af..c66583cb427 100644
--- a/cmd/fat.c
+++ b/cmd/fat.c
@@ -132,4 +132,17 @@ U_BOOT_CMD(
 	"<interface> [<dev[:part]>] <directory>\n"
 	"    - create a directory in 'dev' on 'interface'"
 );
+
+static int do_fat_rnfile(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	return do_rnfile(cmdtp, flag, argc, argv, FS_TYPE_FAT);
+}
+
+U_BOOT_CMD(
+	fatrnfile,	5,	1,	do_fat_rnfile,
+	"rename a file",
+	"<interface> [<dev[:part]>] <source> <destination>\n"
+	"    - rename <source> to <destination> in 'dev' on 'interface'"
+);
 #endif
diff --git a/fs/fs.c b/fs/fs.c
index 3576d5c6644..fafe00cdb9c 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -990,6 +990,26 @@ int do_mkdir(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	return 0;
 }
 
+int do_rnfile(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
+	     int fstype)
+{
+	int ret;
+
+	if (argc != 5)
+		return CMD_RET_USAGE;
+
+	if (fs_set_blk_dev(argv[1], argv[2], fstype))
+		return 1;
+
+	ret = fs_rename(argv[3], argv[4]);
+	if (ret) {
+		log_err("** Unable to rename file from \"%s\" to \"%s\" **\n", argv[3], argv[4]);
+		return 1;
+	}
+
+	return 0;
+}
+
 int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	  int fstype)
 {
diff --git a/include/fs.h b/include/fs.h
index 8c1aa9c1a7b..79dc442ea75 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -297,6 +297,8 @@ int do_rm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	  int fstype);
 int do_mkdir(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	     int fstype);
+int do_rnfile(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
+	     int fstype);
 int do_ln(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 	  int fstype);
 
-- 
2.39.5

