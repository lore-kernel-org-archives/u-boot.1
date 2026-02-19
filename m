Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F95E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:27:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95F1683EC6;
	Thu, 19 Feb 2026 14:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="n9sapkHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 209F583E7A; Thu, 19 Feb 2026 14:26:20 +0100 (CET)
Received: from MRZP264CU002.outbound.protection.outlook.com
 (mail-francesouthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C246083AC5
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFzPcJ/DVq2fhk3N/SicoaypNfX+wb11XMDyDzYx5dzI0tFiuJt23kGb/5DNJv+mDPXViLsOSRKzyfYW9oYrZe+NfenspiDQ9lEJ5IK+nv2WTNGFM3JKtmu2EQhSvXwiXt7v6BJKF5qb6Bvd4oKwr0GoJ/V3cDF1+oj+6VWo0rncXKYMdp+ZHcSiKk0qGA/L0mRVtrjIXLtYjTN5yWWvSW/uuycJvqUGUK8ipoHwbLqohyz2nYCcPb8xL0MRSbK/s/QslzUPvh5ReWE8HXAaUqbQPekkha+TrnUgo24Ns+8MgrerR/VeOM3xpv1Kz7OzQwsDHu+IE6+NMFE5gOI1JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVS1ROdBp73KJ/sMuX8wDMBYMnHZYRpsDNu+W4wY94E=;
 b=wso0KVY1BUa2Gu6msKBYQCw5eoHXq36VAwQb6nQ/sx0eEtcdTjgfaiI2PBAscqA/C2OX7Ou69/3Mnhk2gTXvURnmMzrFg+md5QW7gwb5YoCxakXLR4lPo1raL3nZJkSk9kXqxd8J7laKrLE7zOQvc8T4lw7UT6M3dVA7lkRo9F2H4Vo2UsNHJVla6sHT10gohRUsQgj16bujisltusavdpdF64WrneIcRPO7bjADS9o5BQzx3BnFNM7F707x2gqK1S8sy10FPvA7WoOdT+QSqxjoTYVtL2OiU/CyOsWtOhy4zGIvMRC5oepQoNZV3Ivz7rSwNGKWvOCc+E3GtXyNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVS1ROdBp73KJ/sMuX8wDMBYMnHZYRpsDNu+W4wY94E=;
 b=n9sapkHLAytbvMKk+jWfle4go0bv0Q/Um06eGsZMyFzGpmUVOQhpQPvhJhx+p9Ri5QTE8DIvhDnm5GkaYNxvzZ3/TddhnlynBfbG2GsVAtTZrACdyHuPdN+Paiu4Pha6Tgzf1gvt4gNuHMeHjV8K5VooRY5GxRV6uLTwqg1EhLpL+UUUrzgluyxKuldd9YBJ20X6UW5+jzKx9xK8je4wbzDCmwtfIkCLeg55gtjcqzvtAbErTQ7+KN5DDDd/cQqlBk5wfy3HE0TsPj/6vNYn4siMJnLsCwTc9fHDnid+3w3UCWWioWju8tCUWoXSPskXVQPCjk/S1J02kWybCTfFTw==
Received: from PA7P264CA0482.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3dc::10)
 by MRZP264MB2103.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.13; Thu, 19 Feb 2026 13:26:10 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3dc:cafe::9c) by PA7P264CA0482.outlook.office365.com
 (2603:10a6:102:3dc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 13:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 3D27120737;
 Thu, 19 Feb 2026 14:26:10 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 8/9] test: py: vboot: prepare integration test for ecdsa
Date: Thu, 19 Feb 2026 14:25:51 +0100
Message-ID: <20260219132552.1499698-9-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|MRZP264MB2103:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2006713c-91f6-4143-0c92-08de6fba7246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7142099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qv1NtXNzvP3nNEyXMMhpzcd+6jujqadUv+zaPngCXg/NDgE9UdCvNQvKbV6Y?=
 =?us-ascii?Q?6c1bZKWxKDUTSWxNOABAbZXiNjYnKHeG2Ibe9ypHzwS9avPd1PfpgtiD5y9k?=
 =?us-ascii?Q?HV611O3Z3TC7jVHBQCqsZG02tKOKsjNePE+KStuDLaALALAWhgEv/A16kIJ2?=
 =?us-ascii?Q?mkHgOMhTDrbFl1iJvPx5HvMqXZI4IKgRKUrlWDtuZHxMLYkeYceXNQEwzzv6?=
 =?us-ascii?Q?Sc7etsmT5cZM3Qm8CODkDM/KJtGi/ktE6TQezuBE1FH2njYkpdNC0ULT64Xe?=
 =?us-ascii?Q?S3uff01GyQNvAJ8sXNGw4vzcKd189Uou6z4BirMLF5i7W7jx5Ehiz+lYa2R5?=
 =?us-ascii?Q?Us1kbIyXdbVa9CRWDttYMevQnmAiXH5xXt0euILZGdgW749LDn7mEDH3xVDU?=
 =?us-ascii?Q?XGprStQa8Ut4y8Qo8uMSFCN212Ipb8U1kGKF6gSdieVF5obY5aPfXlOVhoSG?=
 =?us-ascii?Q?aGm3DHTRzJhRtWqebeGKi66bfwxzHTnrCuHTIZ1qE6eE05vITZ2nykYy0nX0?=
 =?us-ascii?Q?FAvIhTIdi38t7itfIgtCq5MfveZdb5NEAVIbR23ux4AbOIkdG10MKytLJM3N?=
 =?us-ascii?Q?23onVWm2oZe/hW1PgUFWRsHmmFC6E98k3JOF27U4/Umkz1K7gisE5WYZZN86?=
 =?us-ascii?Q?aVss8IHvRoTwwLEDC5kQVsj6oOeSgr7swFzKkJHeNKqeYF8kPdDkPjboouo9?=
 =?us-ascii?Q?GkVaei3KX8jrLuus1TqSsV9Aai0dSH6/FfttMlUUuVWer5t9ctV2fyVQg1en?=
 =?us-ascii?Q?/Ud6W8TFeDK3uRBnXEqNEZlNKsQUxBbeA+UbM6qY1O0V7NteZzqQAFBHtBxE?=
 =?us-ascii?Q?KTEjKgzSREVJr4VY5/Lq3/0eUmuBZ43cUytqm1stQaxrB9qXHgG9XP4+J743?=
 =?us-ascii?Q?RLFn3c6k5yGzUredhqArM/SFOiIg3vGirTG+o7WeUugbZ1ebya+99fteNctG?=
 =?us-ascii?Q?oIIZCJ6Rmhised/2kh/QIDHPg3/G4Bk7TDh1U4TArbR1/oQ9z44OUdKRSia5?=
 =?us-ascii?Q?S91A9U8QQmPGVTJgLYpDsG1/hXfnrn4b1cU3Bee392YcoO9APApvXpFI27IN?=
 =?us-ascii?Q?GawqoP43LuohMUU1MyFyCDkfz7PUWeCtqwS38xcZn3bKj3OZdGA9BGVEk8ui?=
 =?us-ascii?Q?yOaTbhs88hWHxM2Ol4mmtuUHxH/3kCVit3i4CvMoe7E6L5whZIEYjkg/hAXq?=
 =?us-ascii?Q?Op443Dr7rYR+goTUzrjn6+73pnC7lMOjA7T2CY3obhDJ9Pssgl13FIm3Cdh8?=
 =?us-ascii?Q?GjRywEH66SZ9DgKuq1ZqKXQMrT6M5SMGYdIpqF06LIaAf8/rjBNMfwKQgTxB?=
 =?us-ascii?Q?7VqsUSKERX+f7mcwk2WxtxpAqyN6jdXNU/Gtb4XhHfeXhruFIiA9EqvGsboQ?=
 =?us-ascii?Q?RcMGz6zyZT7c9UjUtjsiHcaYwZ5ccW8uL8UHAYdMeRgrG1oT96VJP1/L4+1R?=
 =?us-ascii?Q?Fbx1gk6FCqBD5BKz9fs0Rpo0/QTq2PIvnHTUGpTMLMFQKGrF+r0zuERyaf3d?=
 =?us-ascii?Q?CC0SgSKiquG5gwANuQ2U7TrpviXXb+AN9gYCt25OHcZXvOlOO0FN8zDjV58p?=
 =?us-ascii?Q?1HohZk0UEMry34a6oVNoblAzsksoczlHvhJl70fsrBUfSsXF6QtRcaZ7xfUr?=
 =?us-ascii?Q?UV+fgjW6VtS/ELtdLpm0gATghaV8UhLmgFMkU2AMoJ19gRn2qsBl0G/Oz74F?=
 =?us-ascii?Q?d4xQhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JRjISWZS8W0JpLI73gULXTVDbDPzZHnnPIhMxX1MNJJ5gxByyJct3kh7ZohJk7PkTLq20zH8aUlUAeH+IIWGC/WchqJh9bjLJL2hOd6c7dczYHr08zobwmwBBSrLt1O+yoDm3iBQVjZ9oageqOw0b+F8vM6KHKKkKe5SwD/O0ZbAE2CSPsmN5/iI3Bq84linfkomBtKjkS4T24WOThqkPL7gfyYFc5MnZfrhVwD2xX8E/lqhM4Grg0JVFOmilVWH0213w8c7YLXcCPUJokhZyEB8lXk0MG7FenWSDFQPHy28rcFe8ksoo+oKfUfLj+lHGws2h8eGVCAwN60brUTODM9HOpjJZGMcjiz5r1BVgrfpL9pBflinxLrzUe9LUXXX/rnMd3EGeVNr2WBZTabry6uKuRnhBYczR+T8DkhSNI20stZTbHzub2Bd7WxvkYNJ
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:10.4520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2006713c-91f6-4143-0c92-08de6fba7246
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2103
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

The vboot tests only consider rsa algo for signature.
To prepare the integration of ecdsa test, the signature
algo is now explicit.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version

 test/py/tests/test_fit_ecdsa.py               |  2 +-
 test/py/tests/test_vboot.py                   | 99 ++++++++++---------
 ....its => sign-configs-sha1-rsa2048-pss.its} |  0
 ...sha1.its => sign-configs-sha1-rsa2048.its} |  0
 ... sign-configs-sha256-rsa2048-pss-prod.its} |  0
 ...ts => sign-configs-sha256-rsa2048-pss.its} |  0
 ...56.its => sign-configs-sha256-rsa2048.its} |  0
 ...84.its => sign-configs-sha384-rsa3072.its} |  0
 ...s.its => sign-images-sha1-rsa2048-pss.its} |  0
 ...-sha1.its => sign-images-sha1-rsa2048.its} |  0
 ...its => sign-images-sha256-rsa2048-pss.its} |  0
 ...256.its => sign-images-sha256-rsa2048.its} |  0
 ...384.its => sign-images-sha384-rsa3072.its} |  0
 13 files changed, 51 insertions(+), 50 deletions(-)
 rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)

diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index 3e816d68eb6..e59390374af 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -102,7 +102,7 @@ def test_fit_ecdsa(ubman):
     with open(key_file, 'w') as f:
         f.write(key.export_key(format='PEM'))
 
-    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256.its', tempdir)
+    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256-rsa2048.its', tempdir)
 
     fit = SignableFitImage(ubman, fit_file)
     nodes = fit.find_signable_image_nodes()
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 7a7f9c379de..fd1bf6eb8aa 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -84,21 +84,21 @@ def make_fit(its, ubman, mkimage, dtc_args, datadir, fit):
 # Only run the full suite on a few combinations, since it doesn't add any more
 # test coverage.
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False, True, False, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False, False, False, False],
-    ['sha1-pss', 'sha1', '-pss', None, False, False, False, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-basic', 'sha256', '', None, False, False, False, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss', 'sha256', '-pss', None, False, False, False, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss-required', 'sha256', '-pss', None, True, False, False, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', True, True, False, False],
-    ['sha384-basic', 'sha384', '', None, False, False, False, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False, False, False, False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', False, False, True, False],
-    ['sha256-global-sign', 'sha256', '', '', False, False, False, True],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False, False, False, True],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -111,9 +111,9 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
                          TESTDATA)
-def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
+def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                full_test, algo_arg, global_sign):
     """Test verified boot signing with mkimage and verification with 'bootm'.
 
@@ -287,7 +287,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
-    def test_with_algo(sha_algo, padding, sign_options):
+    def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This is the main part of the test code. The same procedure is followed
@@ -308,7 +308,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT, but don't sign anything yet
         ubman.log.action('%s: Test FIT with signed images' % sha_algo)
-        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-images-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
         # Sign images with our dev keys
@@ -319,7 +319,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
         ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
         # Sign images with our dev keys
@@ -369,7 +369,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
 
         # Create a new properly signed fit and replace header bytes
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
@@ -401,7 +401,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             ubman, [fit_check_sign, '-f', fit, '-k', dtb],
             1, 'Failed to verify required signature')
 
-    def test_required_key(sha_algo, padding, sign_options):
+    def test_required_key(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This function tests if U-Boot rejects an image when a required key isn't
@@ -423,12 +423,12 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with prod key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'
-        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s-prod.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit_norequire(sha_algo, sign_options)
 
         # So now sandbox-u-boot.dtb two signatures, for the prod and dev keys.
@@ -440,7 +440,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with dev key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Set the required-mode policy to "any".
@@ -520,8 +520,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
     dtb = '%ssandbox-u-boot.dtb' % tmpdir
     sig_node = '/configurations/conf-1/signature'
 
-    create_rsa_pair('dev')
-    create_rsa_pair('prod')
+    if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
+        create_rsa_pair('dev')
+        create_rsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
@@ -540,9 +541,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
         elif required:
-            test_required_key(sha_algo, padding, sign_options)
+            test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
-            test_with_algo(sha_algo, padding, sign_options)
+            test_with_algo(sha_algo, sig_algo, padding, sign_options)
     finally:
         # Go back to the original U-Boot with the correct dtb.
         ubman.config.dtb = old_dtb
@@ -550,21 +551,21 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
 
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
-    ['sha1-pss', 'sha1', '-pss', None, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False],
-    ['sha256-basic', 'sha256', '', None, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False],
-    ['sha256-pss', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha256-pss-required', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha384-basic', 'sha384', '', None, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', True],
-    ['sha256-global-sign', 'sha256', '', '', False],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048' , '-pss', '-E -p 0x10000', False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', True],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -575,8 +576,8 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,algo_arg", TESTDATA)
-def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,algo_arg", TESTDATA)
+def test_fdt_add_pubkey(ubman, name, sha_algo, sig_algo, padding, sign_options, algo_arg):
     """Test fdt_add_pubkey utility with bunch of different algo options."""
 
     def sign_fit(sha_algo, options):
@@ -595,7 +596,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         ubman.log.action('%s: Sign images' % sha_algo)
         utils.run_and_log(ubman, args)
 
-    def test_add_pubkey(sha_algo, padding, sign_options):
+    def test_add_pubkey(sha_algo, sig_algo, padding, sign_options):
         """Test fdt_add_pubkey utility with given hash algorithm and padding.
 
         This function tests if fdt_add_pubkey utility may add public keys into dtb.
@@ -618,7 +619,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
                             'rsa3072' if sha_algo == 'sha384' else 'rsa2048'),
                            '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb])
 
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
 
         # Sign images with our dev keys
         sign_fit(sha_algo, sign_options)
@@ -640,4 +641,4 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
 
     # keys created in test_vboot test
 
-    test_add_pubkey(sha_algo, padding, sign_options)
+    test_add_pubkey(sha_algo, sig_algo, padding, sign_options)
diff --git a/test/py/tests/vboot/sign-configs-sha1-pss.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1-pss.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha1.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss-prod.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha256.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha384.its b/test/py/tests/vboot/sign-configs-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha384.its
rename to test/py/tests/vboot/sign-configs-sha384-rsa3072.its
diff --git a/test/py/tests/vboot/sign-images-sha1-pss.its b/test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1-pss.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha1.its b/test/py/tests/vboot/sign-images-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha256-pss.its b/test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256-pss.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha256.its b/test/py/tests/vboot/sign-images-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha384.its b/test/py/tests/vboot/sign-images-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha384.its
rename to test/py/tests/vboot/sign-images-sha384-rsa3072.its
-- 
2.43.0

