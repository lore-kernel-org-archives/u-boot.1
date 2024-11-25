Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B255D58D78
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 18:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35CB789A69;
	Mon, 25 Nov 2024 19:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="pGO9Gxsi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABCBB89A61; Mon, 25 Nov 2024 19:17:07 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazhn150100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:da0a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A99D688CED
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 19:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4ZSoO832Ffw4W/l1vG+406I4heetzjRRpguImeaaV8pQ6LUCvkpkXwKr22QN2eFnty2sICNpilxM9ZYINNWUAfruw5sBjurk9JXx77dSgO8xzm9xNVAIrCdL7pAw9I9+nuHmJWyQTl54dDrfEmTSxsKDXWjORSqJjvCu3Duiw5lUtslD/CQ2rBRAjjhxKtZtx8u+RPTlY8hZ5au5/tij/20SzsLreLyx359FevUPAsqHFrex7uXAlItycfBoMV2SJeB4s2T8k98WiGJXIHBx7f2GA4iQYbNawSVZehfVOenq3l4YTKf54xIaJCrrFgxjwIeV66d63Odu7fPwNQAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVTr7ztI1B3rNIku+X7eAdKCZM9LadqjyQM0Y/OztuM=;
 b=ZrPRP3exZ5+YXF8YR3POYPgX7+VWu0zDAOBwdKj3enTb+9G5gh4W5YN8KuDlmyIhr7A0kfZAa66NTzgIbOwxonlc7FApqsONMpH+TK7sX71MVW3lDVhG9PuuqZBfnY/bT9Fgq3z5iETDcWt3qnzp6fM818kXNKWSfQnXDmyc9U1Wy6g5dYpyZQeiTx96Jg0AYlV6UFm43bG3ZDF3pctb7WuqKee4X4QFyBk3HNMaozil0CrkqPd3UAbNDoRxUYFQOZXP/09fQDmjNWreLXwFGOCZyAUlGaD2ncrNI8KbQUshG1RYPi8+zdnUCS/gcXepyuC9QgqCAZDraYDZLKMqLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVTr7ztI1B3rNIku+X7eAdKCZM9LadqjyQM0Y/OztuM=;
 b=pGO9GxsiWu0mn/y7g6qQActuoDx/TR2LCzXTYTTwhZ6IGb6uyr+7AX9gGOnuRpnbp343MBSzf0VAHST+/vGZkKQILEBEQzHDdKLwC5bl6ANu1MKK12udvB/Yn1quFqb2M8ckzo3dUa5nTV8LcWs0ZJfF3w1p4H19u5fqukdM1RYyNPd19fUcfzyDCfu4LGmwmDRxKgNNbMErKQIYkbH+ng7OnnsqAPbuZsXhHih96EHej1YAuCkXKu6WSqDoT6lktr3jYgHhaIgx6WTT3ouWQ2zCe4jfin0BrFfNWuZxuFtU9ECV3BcVbKAX5YM8V5DI8NMR8+lIPNuzl9ZU1VfRRQ==
Received: from PA7P264CA0381.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:399::20)
 by MRZP264MB1797.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 18:17:01 +0000
Received: from PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:399:cafe::eb) by PA7P264CA0381.outlook.office365.com
 (2603:10a6:102:399::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.20 via Frontend Transport; Mon,
 25 Nov 2024 18:17:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089BA.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Mon, 25 Nov 2024 18:17:01 +0000
Received: from sah2lpt245.. (unknown [192.168.72.99])
 by proxy.softathome.com (Postfix) with ESMTPSA id 86CE720323;
 Mon, 25 Nov 2024 19:17:01 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 2/2] tools: binman: etype: fit: Append DTB directory to the
 list of input directories
Date: Mon, 25 Nov 2024 19:16:54 +0100
Message-ID: <20241125181654.1182646-3-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
References: <20241125181654.1182646-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089BA:EE_|MRZP264MB1797:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9b0eb044-e1ec-4f4e-22be-08dd0d7d5bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|34020700016|376014|82310400026|12100799063;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nB7/tyVTe7M1jWltO2o6DQgV/aQ4nBsXkZ3tvYE78ioN83y/hgMxryE4EeQ0?=
 =?us-ascii?Q?RDbd5hbBnusRu34XqZ0FoflPXWS/mR99613VZncFL+29jKxIiYM/jF2BMd81?=
 =?us-ascii?Q?l70iO3uUpDBVlBRzfEzDRM4m6e/tzkB6KHNCjokCU4v+F8mLSDROcP3FVHH0?=
 =?us-ascii?Q?1DlPv2LwrGjEudX8I/YEFuCy85kEe9JzXd4mritDFreXbrRwKsGE1eO0sN9j?=
 =?us-ascii?Q?FQ0RakFTo4Y8PJTABqdXpz3ajcrrYoYjb1LOmWje2mGz4c6oFQgJTjzpHGmJ?=
 =?us-ascii?Q?sJQ6xTxSwey1BU5YGWDvJQviPmIDYF8sJzRPpHmw8YQQ8OuuUIdQbxIHlaoJ?=
 =?us-ascii?Q?R2VFSC6n2IuuvFQGmMzKmrBR28sEr3Zlrr3Jo/1oOeuH+3EhHvqn9LlaP/Mr?=
 =?us-ascii?Q?NCd5xvIRYOfzj4kmBEJBBbuXa2J1OFQxm6il2SNh6/+al8Yn/tsZ3VlyvFQQ?=
 =?us-ascii?Q?EM6qqmu/vD/4xfoygTiDElgE5P/JPX/tug34fczRQACITEADLTd76BVRbpXP?=
 =?us-ascii?Q?tXRo4NU/WuQXbRfk5P4g3MU4ckRqL3WID9OKFZ7QYR5BwKJyF/aDpMawZ+IT?=
 =?us-ascii?Q?uTXHg3vI/vL2py/RXeeO/nOiKxC2vIuvMA5gHTuzwxOaxTegebCuJigQLLqL?=
 =?us-ascii?Q?2dx3UqIoULqivWF6ZfpSd6llTb3nQB/D8m90qEUSNS3xbwpkCM8xZJqcstos?=
 =?us-ascii?Q?US1iOBrp1QDGRFFH/SIPCff+5MNTC41S+FOa6xzc+j81lIBZVYYmvktQtV6v?=
 =?us-ascii?Q?fl1n07qPXKqJRafZVGuP5YG4iqtHOYt0nveo1d4a+l1gghqRMvPcB8IrCFbS?=
 =?us-ascii?Q?ohb5v+uO+DDCxJUeZixHxVBRICxQk+DC5UUgNeDYK4GWz0hYtmjN4VmlSyJX?=
 =?us-ascii?Q?mKg1lC+LBhJXwxQb60emU1u++jR6K9ydNzJG4AlD+nqnftiRGVPjA2xC4Qr2?=
 =?us-ascii?Q?B3kSGmTckVKKlC9ntPTWTz0CDZgD6H7CaEXMIioJ2K/8D6A0XBnnXNBu7nwW?=
 =?us-ascii?Q?RHqsWsKR7f71u8K/QV1yDTn6Mesf7DFNtMW+0BhmXJZfrQ46vCmx/UgOTmEX?=
 =?us-ascii?Q?ICzoIrJHnGI5Mxf8zzC9gOVsmnRjABJprTSn/8Z9LGvgt3sVrdwzb4ympuzX?=
 =?us-ascii?Q?4gepVNpVw1CfoO3L8Dy4byTprPtuNZPgtSSQ8Tt4zvYTmHQqc0MK0WDpdKyj?=
 =?us-ascii?Q?UAlgqb1oooRIxSWHWkZQ26CYUHSiJpcDg8meoyzdkAzYe/Zlnq0iJCyrd3+m?=
 =?us-ascii?Q?AEaYfxB3j4E8ax96/JP7dWX0zOqBy8FZ32szMK3tdVc0cFXCbxmpWoLfaMnC?=
 =?us-ascii?Q?t7p6ERQTJjGZZXStAnMl4A0SxzJFUhtTVAIGuQjqbT79BpN0q/oli3V+MDSh?=
 =?us-ascii?Q?bDsYjeXiSp8k4xphFBje1ZCZNBtW748qUliiCabpTA5qQDEBwWxPXCoh/ORH?=
 =?us-ascii?Q?v1vXDOioUdozlBkmE117NxLfbsAk1Egn?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(34020700016)(376014)(82310400026)(12100799063);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 18:17:01.8711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0eb044-e1ec-4f4e-22be-08dd0d7d5bd4
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089BA.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB1797
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

When specifying a directory containing DTBs with 'fit,fdt-list-dir', it can be
handy not to have to also specify this directory to the input directories of
binman with '-I' option and use the method tools.append_input_dirs() append it.
This avoids to have to specify the DTB directory in both the device tree
provided to binman and through '-I' option to binman.

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 tools/binman/etype/fit.py | 2 ++
 tools/binman/ftest.py     | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 343094a16e..803fb66ea8 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -477,6 +477,8 @@ class Entry_fit(Entry_section):
             self._fdt_dir = fdt_util.GetString(self._node, 'fit,fdt-list-dir')
             if self._fdt_dir:
                 indir = tools.get_input_filename(self._fdt_dir)
+                if indir:
+                    tools.append_input_dirs(indir)
                 fdts = glob.glob('*.dtb', root_dir=indir)
                 self._fdts = [os.path.splitext(f)[0] for f in sorted(fdts)]
             else:
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 4a2a9f2288..a553ca9e56 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -4285,14 +4285,17 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'default-dt': 'test-fdt2',
         }
+        extra_indirs = None
         if use_fdt_list:
             entry_args['of-list'] = 'test-fdt1 test-fdt2'
         if default_dt:
             entry_args['default-dt'] = default_dt
+        if use_fdt_list:
+            extra_indirs = [os.path.join(self._indir, TEST_FDT_SUBDIR)]
         data = self._DoReadFileDtb(
             dts,
             entry_args=entry_args,
-            extra_indirs=[os.path.join(self._indir, TEST_FDT_SUBDIR)])[0]
+            extra_indirs=extra_indirs)[0]
         self.assertEqual(U_BOOT_NODTB_DATA, data[-len(U_BOOT_NODTB_DATA):])
         fit_data = data[len(U_BOOT_DATA):-len(U_BOOT_NODTB_DATA)]
 
-- 
2.43.0

