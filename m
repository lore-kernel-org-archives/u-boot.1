Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E11C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 12:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9AF287251;
	Wed, 15 Nov 2023 13:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="cJuNuaS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C996F871B4; Wed, 15 Nov 2023 13:44:41 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7d00::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36304871E7
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 13:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Christian.Taedcke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uwfgml9gnTpVo+P6VtVKoA6zcDlyCuefLLEKcziIrJ1SskEnt4AAyHKH8IfqCg81y9uj5xg5NzK9dNIQfeadkX9Xa7hpGgN9v8pghvrsgKJFvBQ4zZ8koe23CeLvrrbWmgZZe0krJaR5bO7OIIIS+0D6M2IRn/gpWhlzOCKbtpqoWW8zDnsHsTsZ6oZ+CYu6K1XKTktInNHEQhhj/KaAbZkGAWaCelCIdWWsxfQZFmOWzxpT+R6cVHApCqTKcreE1/7mai5zusBzzzeAFSQdu6ZyLND0FAK70/sANJS0CTmNmmqL40c/iV7RjihIF2fiz4S91XebWGtA2SKB1MK7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNQxAqlclIcN+HCjVSTxU2p4pbdd11q73JZoDbxnFjw=;
 b=HeQ4yYBWC0Zfe/7NfADFDRpAT//KGw8SByQ4K0Us0KFwj7Djo/hdqvzFkKB7h+VsNQwoAXbNQnfCgEkoU4IooLCM3na/+Evqv8UYD0eojeyVyBueenwsHOweaFcA7XCdYDd8ba21FQF7J+gSXBO4q5c7IRJnBXu/7T08l+pLil8vZoTbagkimJPru+M8uHTCvnsar2ivdkTOEtCcO/Gyp9WQbx+z152mte6vODRJbtiXZe0gYCCd+GF/mkzbz77XDSVGjxBfZpoBhWqRHOhUAfOYgl/asNpAl2VAde2ncs/JOlE9v2KSW42xNEsvrCTdTMCUmiDKD/v+Wer2w0deug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNQxAqlclIcN+HCjVSTxU2p4pbdd11q73JZoDbxnFjw=;
 b=cJuNuaS8877RyTzV7WqsIA7WJJUUfHlft9N4SXlv6KH0n49xIjdXK8towNsuLR636dMM7Ue8ocoC5uVAisSYVDzH8vHSinFOa2o9qYfFIIqfYy9OOBu4XJo0cBT6lbieAZ8ufBKlsYtKQILlWHKupnw5gGGmpevKhl+s0jAG4IY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com (2603:10a6:208:165::13)
 by DU0PR08MB8614.eurprd08.prod.outlook.com (2603:10a6:10:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 12:44:37 +0000
Received: from AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5]) by AM0PR08MB4946.eurprd08.prod.outlook.com
 ([fe80::a732:6327:19b0:b4d5%3]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:44:37 +0000
From: christian.taedcke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Christian Taedcke <christian.taedcke@weidmueller.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 8/9] test: Add size granularity parameter to mk_fs
Date: Wed, 15 Nov 2023 13:44:23 +0100
Message-Id: <20231115124424.125823-9-christian.taedcke-oss@weidmueller.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
References: <20231115124424.125823-1-christian.taedcke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To AM0PR08MB4946.eurprd08.prod.outlook.com
 (2603:10a6:208:165::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4946:EE_|DU0PR08MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e28c82-f85a-48ca-610d-08dbe5d8a076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtI8otNxLS6Ka5nlVkocDTov/veIzSrY1f+nv4aYKr3S7gwucPzM4dN2XZZBXa6SLMNEBytmDSHoLBtucGm7xqA6Xh01wJ9tnA0I+QnWnC0okaFn6rMcP/28T++dFnwGIR4HvQmn6GVygJlCme2yp+tZyTSoH4yZCLWcPASpYjE4RCvsdwQAzmUT6OEvo2b02qGV/yUfAcb2AiMZQR+/2aSRTkG44nOigY1d6B4E7aR52Haq8gnuvHWfmF/+y7lrllXHT8Tq4C8cOUc/50yaHHCCFkRpIlikPQXmNda1BrwCP5+Pm5TgRT8Ngm+JLXMzK+LclGM5J1WUveXVO5r13171QS+2GWmdrox7D3eB+2KhyiN/WUF0pEylC4Y5z2kzJ5Xe1Ow6hWHZc40UkziVdCn/79Kqo5b7WMfW0+YVF59ZtlLBPn8v3koKYwwtBDGeL62Gc+vSg9m9NSWM1VVyAjLNzrMx2Fz0ScUysHqzUTemNYtpo6/HyOM9YGTDSMXjCPWm2JdC0UhxNViFcAo+q3fABPOAFVIfFgr95r1AxaRe4wFoeQnzKPRu9tHq2mLh2ZAS5rd7Z3GHvAxmiLLcHzSHiVJDCfz1/Kc2XTTjvTukc6sQ5NN7tW0jgsAIaDg9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR08MB4946.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(2616005)(66556008)(54906003)(6916009)(38100700002)(26005)(36756003)(316002)(66946007)(66476007)(86362001)(83380400001)(6512007)(52116002)(1076003)(6666004)(6506007)(9686003)(6486002)(2906002)(478600001)(8936002)(8676002)(5660300002)(4326008)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?soIgpeLbUbq+2UWplg5RdUgiosURKtFHK9LzfG7adk3MW1ETJTEzqP6pivRc?=
 =?us-ascii?Q?wiU9oX+p9/B6jQiUzuYHznVOQ9OAfwIvFzcje9RmajdkrJLEAW+fyWfdBduD?=
 =?us-ascii?Q?AfUXsLy0BVdRLR0bjXlpS6mlSxEluLiueHg9H96THJ4Z3CYDbZneEugGmr1C?=
 =?us-ascii?Q?/++0fVD6whDeMaTs65UlCO7HJsFRJ2gBFQxSVolRmcUbLE6yB8vS393MIyuc?=
 =?us-ascii?Q?XVCYpYez/C4Gx9GgZyU2kp8ynMBv+eCrHc9eZrns97YIqdSV7ZdErYnAFR9k?=
 =?us-ascii?Q?HBj16747R0JvusKv4LxJ6QCqL08ERzgGZCbQI7o8OKFvr4/Ao4KvUsTh7Vq5?=
 =?us-ascii?Q?WjT4sk5vGti+pA5O1BkTdrpMQ6ZbEcrgWNoDY5qLQ4m3kHKDokDuhyx5/yiF?=
 =?us-ascii?Q?kxktbyJkpGOhVkNpTjQL/Z9O053kY386i0odWdgxezUsSX6pvsSyQhexK2Cx?=
 =?us-ascii?Q?akEseRKcGwrPK5mPFFu8PgGltb62lpjJ705O3UXd3aclgSu1BotfH9+5q0wa?=
 =?us-ascii?Q?H78ZwmSHOsQ0cs51aZ5PKg5ofd9mzF6PYVz5wP40TFnuCojtqeCG6cC5YULs?=
 =?us-ascii?Q?3lWa+ADs8nNWP97Il7jWPvcVtuzQOOfsp8RoeTF05cLzd5JAifJwpCDNvUIr?=
 =?us-ascii?Q?Rvq0PxmLDQSwrR2WvpcCS3cEaNjv9x8PoXF8v5DACr5ZIonJCwB7vlXdPpcA?=
 =?us-ascii?Q?+0ywTKVseylOgpw2dxjYgZQNmS//4kCXdGKnI5JZ4+WuaBxqQrGYC+093kRj?=
 =?us-ascii?Q?TOS7BhNqTx/ZLIdW8RHZ9MGc7+MCetxgQGC8NSvpvesc//swUh0jaDs4xHlt?=
 =?us-ascii?Q?zmokiN428Xi9FaQUUZ/4HsfiYxZMkDijMWYm4CfyIw5LgjLitssWJV2HHmlr?=
 =?us-ascii?Q?mKkwmDMxPv6zY6tYAcmGaTo9An9+84tzyEgscEbyQqenN+/D+XWqZrs0vv0h?=
 =?us-ascii?Q?A+fWwTu1WszzF69lZMtKbt+h6SeZdHh4aIfQ3Td7Dp1W2Vr8FDXT8fYqPvUk?=
 =?us-ascii?Q?QbGLcgrpbnIP4A3jQKV/dnOM2ZypELgpozYqqD02tLOXCJsbXcK9+Z0Emzk+?=
 =?us-ascii?Q?GRIDvn8h2g14n16OtD6oNciJF9MeUaJxPoETDhlZc1Nv5iRcDOs47yGq1Xaj?=
 =?us-ascii?Q?7+vNOzrowNo6ISCjHMDEEvx2b2vHHiYJqN6zJpqOcz2Onst5l3oYA9c5K+VP?=
 =?us-ascii?Q?VYCdynEjx8at9zkAQLoojfalAcm+/x/Bu4e8agquAGVqBfMfl/Gac0wiu3zp?=
 =?us-ascii?Q?NZDngyTfEZH4afZ8OK1ZQVlcssdRG0Kp2Z9nlcWE/QGY6piHXZXK4UM0kiWy?=
 =?us-ascii?Q?UgGNVCfsX4Np5WM9bTbeUYiOz5NeuOz5He+sPt0H1Vw0yZztw64iGMA4CLt0?=
 =?us-ascii?Q?MeftDF0PKJDTGjx8EmMM8XO+Ho2N+bgcdcyhuQbNMtaph/l7eMfG0Q7Et1hV?=
 =?us-ascii?Q?Qrc2FoXBuUAoYALEEt9+J+UMMa864CsQCFFb/738KqYrJoHD5Wt6ULJa/v4z?=
 =?us-ascii?Q?7boMwlgkZGezBbwocJjzLRoT/x2YypjUhDhHHZCUlmftzZ77paEisDz+YLYp?=
 =?us-ascii?Q?EHbqzXhcb7aSQD9Z0OQK1j4Bmq1fFogD6L3Jrk/qKVR1npjm0yxjd2YzC8NJ?=
 =?us-ascii?Q?+mIIOQiaXqGW2yliLBs3A4KS0E99hsuzn3hDefJRRUvG?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e28c82-f85a-48ca-610d-08dbe5d8a076
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4946.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:44:37.1768 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdkq8iatSb8ZmweLeZYaKvnsTtO6XbhCYJ46eO9rotINgZVuHVp/Od0Ns19WRhsVCaK96sR0nNIms9Wrd8r+jhyVbocUPKnwTWD2YExCKs+owE3X+lp8Gw8j558JYQQq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8614
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

From: Christian Taedcke <christian.taedcke@weidmueller.com>

Without this commit it is only possible to create filesystem images
with a size granularity of 1MB.
This commit adds the option to create file systems with different
sizes, e.g 8.5MB.

Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
---

(no changes since v1)

 test/py/tests/fs_helper.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 0ae7a4c4d7..380f4c4dca 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -9,7 +9,7 @@ import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
 
-def mk_fs(config, fs_type, size, prefix):
+def mk_fs(config, fs_type, size, prefix, size_gran = 0x100000):
     """Create a file system volume
 
     Args:
@@ -17,6 +17,7 @@ def mk_fs(config, fs_type, size, prefix):
         fs_type (str): File system type, e.g. 'ext4'
         size (int): Size of file system in bytes
         prefix (str): Prefix string of volume's file name
+        size_gran (int): Size granularity of file system image in bytes
 
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
@@ -38,7 +39,7 @@ def mk_fs(config, fs_type, size, prefix):
     else:
         fs_lnxtype = fs_type
 
-    count = (size + 0x100000 - 1) // 0x100000
+    count = (size + size_gran - 1) // size_gran
 
     # Some distributions do not add /sbin to the default PATH, where mkfs lives
     if '/sbin' not in os.environ["PATH"].split(os.pathsep):
@@ -46,7 +47,7 @@ def mk_fs(config, fs_type, size, prefix):
 
     try:
         check_call(f'rm -f {fs_img}', shell=True)
-        check_call(f'dd if=/dev/zero of={fs_img} bs=1M count={count}',
+        check_call(f'dd if=/dev/zero of={fs_img} bs={size_gran} count={count}',
                    shell=True)
         check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True)
         if fs_type == 'ext4':
-- 
2.34.1

