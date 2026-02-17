Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13338E6816B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A2E83CF2;
	Tue, 17 Feb 2026 12:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="XXw/UTL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F5383DDD; Tue, 17 Feb 2026 12:53:44 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6869683CF2
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIsRN6rImhRy5aI6Clkr1I6MgbhnQmDEB4WvBvvWd3OUnRJBe2TdSHnkyUp2sewrRpQA39eurGWOMVeZx2ZkX6w+sWDlAac6gk9FJ7wJzsMxM5gax0srvgkQlX9L+oANcpw/TC+E8SFvFo+8TiQnIeqF8pnjFIKdRQ28otlW7SrZGbHebJf5x29J57bcqU9FkhOtAb4FblMYQxAT/XkhWfb/Qm7+SoF+gngQqmLStvo5bAdMNBcqlaJ8nxBrxve7LSjX12TDSHdkQzYmBGrJt0RgD4+0WnVFyQ6YvyTMnZM5w7xC9mvqXkyTB9h758JZeZO4tF0WvX3FWxaq6sNDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbZFX5FWOcAUQK3Y+2aF374THyiWyOztaMIW0orcmvo=;
 b=UCcJ1X6GVJ/OJFvKKefQMEJUofjstSGq6B9SDXz26nYAWVZEekK436szbUiZV18ZKT6mkwkOwQ/MiEmmAr5lOpK/GMTA5HAkRno5eBkkHx6u5DsCmLnmIN9131wztwHt0s4PxcYslMxr9672sLEZZ7s7BogYSHsvjotDRBXX+poQC7eNgCN+4L+/NtpwMbXRS+opcfTVy+HUtKqshQwu3nsLJt4boTWwV/l87pg+G9GJFHRmHF96sbrP2sqP0p8+gk1Xtanc4XuRuAC+/bwGdhrz9V7G09syc9C28rpXPWpa9qEt5U9+VJWCS9BFzrlmoUPSGAS4Tu+ns+NXeWrodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbZFX5FWOcAUQK3Y+2aF374THyiWyOztaMIW0orcmvo=;
 b=XXw/UTL5OQtzBgBcsWLqemNUSUzDD13p/mLYWYO3kjra7ozRWgHKfusk5M+QtBtKC5XkodloG++z5W21cBCRTYdJAZWnHGCI3l6QyFntWMdumaoQd1RUL/6Rvw2E8Ji5NGtnQWWcvhADiT7C4c228f+lrM1Pj7H6N6SUWeEiAyzRhPINj+jp9atnJfi3fNdWtI26GhDE+VzM1VxW0JKltv1YtvZRMJH1cxlv0lIAHiU9/9cktDqpjXtwawoyZpB8dQUfhfURW5DZyc+IO3FnUf39qN1Qca8ZTsuEGShX3FxYPS+GX2QPQPWYllMCShHnpeD4hjL5w4T7pv7I+ESjYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB6761.eurprd03.prod.outlook.com (2603:10a6:10:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:53:41 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Tue, 17 Feb 2026
 11:53:41 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v6 4/6] binman: Add dump signature option to mkeficapsule
Date: Tue, 17 Feb 2026 12:53:30 +0100
Message-ID: <20260217115333.503359-5-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0125.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::22) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d746c39-23fc-431b-fc8f-08de6e1b31b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z2dTkwwJRyM7Pihp3C6mA8OvzJ5LzriMR1unP0N/lgUIqvGppmYQZsLKJQx4?=
 =?us-ascii?Q?hJ2vL1df1SxKmtbjCwN3IcekShRKvAFzZqSwy07twgLsWjqW8D4mUNJskPUT?=
 =?us-ascii?Q?yKLrI+Z4JHmBi8SQ2U2lq+CBt/zSmYUsHkeKWhtWGi4M6XXxGAzE8EZnBQ2e?=
 =?us-ascii?Q?zAPSUTGqb4yLolzZ4vviIc2ebwNUvr+nJ3Rgh/KGgLR0doguxKuAveOdQJ8m?=
 =?us-ascii?Q?Tb4I8BHtrno8Zdpv1XEqQ4hmj1tEOsdnPeNHW+MOnmJLgFwnlAlaApsUYf+X?=
 =?us-ascii?Q?iamgytzTUmlV6sV0tDDPO5Ho6HcsGLpZv58n6BgBChAp00o7bl7vwCVlkvRC?=
 =?us-ascii?Q?d+rhDrWXAffRozotq3npohy4TLbO2L8Dtv4WGB+dBG2d2YbfszRuaf6TR2xc?=
 =?us-ascii?Q?XPf+LYuJ1oCOvgNnorHd5AGvDud6pb4wBlVen8IitkM6uZXFtOJphucgsBkI?=
 =?us-ascii?Q?WT2gWi2rD1TkwB3AAyENO8FcM82A7857qMxGWoclTFDYBW+7hfw2gd0YvKmu?=
 =?us-ascii?Q?cBskX/K6JwEWnMHvfIsAnQ+V0RbxFz8zk6lzINCvT3WuArUn4rlKwM7REMDo?=
 =?us-ascii?Q?5J1hbTB+szikr1VIgo64jsYbzRS2DE0QSqNbUfzLl9gE+OMM51YmRU3Hd2Pj?=
 =?us-ascii?Q?anDkisHHPV8uWIn6uJ8mSa30ykB+B5/xJ5bqeWg3ZLe+NWRmefwHZc3eWTfd?=
 =?us-ascii?Q?BihdEMrUZ9GyoHqEgjXZGBvUFi7O7Y/CtwAQLUhgaTe2BTwU6p8H7qZGA7Hm?=
 =?us-ascii?Q?UWS2DmRJ7zdQc086X+uyzQLh4ZB3GlK/FtTzbibPFXQUazZPIxQEZ3w1dNY0?=
 =?us-ascii?Q?sSSo3yM5XusddhmwHOsjIqIa4nfeU+QZ/4OOR26YaBjlYS3TY8IGdazfeOdW?=
 =?us-ascii?Q?gluC8KnsbC41EoCUjCAAK8BuEaf9/wbF6M7DQFRzd9+NGCcZuLbujwE5urqM?=
 =?us-ascii?Q?jgatSHTOLK/C39TZuH11NilVdhiLpgRKTh7P6UmoA4w1nMwHQ4fFM0blVs26?=
 =?us-ascii?Q?OEPK/NxDRXuul/W4MaW2dUQDn/r2VwW/hA5/dXbIznbDWQTty/TCyn6VXZiC?=
 =?us-ascii?Q?MdKLNSDd5olTuOAquKkGbLcZTtSQxl2zMXvxrCtHPO2WvLuO/tFZa1lCzUwS?=
 =?us-ascii?Q?hT2Mdi2dHkUHotg7tVg0/xMReB90V7Gn4IWWaY6YeSqBiQTFhhAd2HGDmuFX?=
 =?us-ascii?Q?YjdXbTr5Y8U/dJIdFgZiZ1U5G8stoFzvnikOAOM5ogEfioWnnq9NZuAmOcCm?=
 =?us-ascii?Q?pTLPNwbb8534wSa9Gdrt9UWQTEEKbFvxYhyIDkJ7bMFYfaMz9b1y7onS/f26?=
 =?us-ascii?Q?8v4g3MAyMU1f3bmkuxypCtPiKV9e2rrCXesttVhFFF/2Rfwd0Yk3ETHkrTLW?=
 =?us-ascii?Q?X26+4Am26RsA/iIu61JzkdGBDYFycFw5qbP8KrC6+GkDwwxsWZ+67yJsdwXl?=
 =?us-ascii?Q?ApYomvxr/Ab6ZeETotAL1m3KmObwpFd/5eH+47If34VmsnuCixXLYLpBN+aK?=
 =?us-ascii?Q?1cWDbOFvtjrWak78DkdGH5xx9luKF/AQQex5uF84Ki6FbDOy0Twn4QjUeNdq?=
 =?us-ascii?Q?XeG51OeTrmWeLCnb0c6+ruR72+SR3qv7NpR9agHncziiQsbHNHv1gTR4KoCf?=
 =?us-ascii?Q?ktM1PtBQxXaNR5/ybd5J/MA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wVHFHKEODc1KjFyi5f6qOGDjsRgT4WItQH5OgAm2KAahtkXA4sXzefGLbIOS?=
 =?us-ascii?Q?m3KuvqZPyhIP6aM5EqWUMoJv3lz+gj1zmrlttXlu4U/Q+42y8x9KMJUr0lbU?=
 =?us-ascii?Q?x7Ymq7rE0nfxM+a1Lbcnxrj8EtQmvLyAGStYZ8qWIRT86WcfrR4lXCKTWfZH?=
 =?us-ascii?Q?Pox4d4q0E72WwRy2VBNhTRAhhEqTmYAMp2d0YosTH7r4i9Wt9aUojkUwfvWH?=
 =?us-ascii?Q?HA5zTDgRw2W5BBtiePq2wAJF5f1ABYWIRc66qrdNjIXcuk0lRpSzF8zroWTo?=
 =?us-ascii?Q?LsOhFidH327TGQ68Ji8qWZfDUuYgmV5gTzVlTtu+9+G3qLO/EVpWECBiuyUP?=
 =?us-ascii?Q?AqvDJx8dRlNlQDKqk2mKltun8d+Ec3X3PGUeZA3pk8GqMWhJYLEh5ndkNYGh?=
 =?us-ascii?Q?o6BfWuMEXR0burdR5Z3qKDA3UPBsSguyWDyS5RE1NAEpjertJmTyhiMIL6Ud?=
 =?us-ascii?Q?pCciTqo8vp2ZeOlgYIRLo/G8QGN3T0OxSD+wcr+cUk8a+FqglQqME+2sRFx5?=
 =?us-ascii?Q?0lpZIVPyk4sxJjd7EDnpV6n4llBQHmlqnF/8VyDR97IljJwk3IG+evkLyhbi?=
 =?us-ascii?Q?uBt+Qhwga8dFPfPExPq5Vp9e30phX8Ur757V4f20q474DwuYXfo4qevdJKRu?=
 =?us-ascii?Q?DDAeIXlNLU3Zg/FkFaHeh5/9zRJoJnMdMOIU3/DCYXpRdjxiUVQCZYVCXFZa?=
 =?us-ascii?Q?gCUtEyWtBaFgnuKQYAPFhv9BdusdCsZfP3Z+0r6V8kH5KLqxSsGmJSxwT7bn?=
 =?us-ascii?Q?tyflD+of/c+Z6NdcbHjG6PstTqUKRqaXW6BFLAAbESl7nZGNcLtCNQioPwy3?=
 =?us-ascii?Q?xp6KfPbjXTf6G1Oel2HBJ3mrkjzIR55fw64nz6mz1xMhwCXlvNGpAMgl+N0y?=
 =?us-ascii?Q?+Af/Px6+jj3CBihJ7ZnZ7vkR9UMKq8Fw1/1VOzZl1p/r9orVYyTxjYC9qE/E?=
 =?us-ascii?Q?hRkWC/zopftyTeFxl+vX3J+bgJxtjitUt0+Uh01NCJ7PK5fW3bELU14F/KMl?=
 =?us-ascii?Q?/3tK9KduOPyk5OJBQ2b3mzmwY1KuxCod4dW7HuZDdSzkDLXgLwCCJ0JFEYO2?=
 =?us-ascii?Q?FXIptOnfrhiny74WcpHikza1007XhdmKh0E1ugHkpDZzTXy1KafUMx/XS0Td?=
 =?us-ascii?Q?TwlH/imrh3myJXtOvY2R8o467SosQFz6uI026EgXn5FPQubTYGKQAtY8KSVV?=
 =?us-ascii?Q?1mtXNpYXi4F+Lt9eFkYr0fV9XDg6Em8VCNBDmj52rF/BRbLriV7+osKh4MqF?=
 =?us-ascii?Q?snp16x+kaVf5Z1xrSh0n7xD621eAAdOu5n/1nUh+8/WUcYLJd1L3IqCyqRkU?=
 =?us-ascii?Q?iKDYiArzV78ZJvrxOSPqjtLyFo8oWp7j7gudyaH8v1abaAwCkMwdOYyTCE4O?=
 =?us-ascii?Q?uo5Es3h1j3Da11Tk6VZO69JuVlRsu/UeCx1Lyw8f2iyINGrQUVYVQACimQ9W?=
 =?us-ascii?Q?RB3T47Bnvf64wxegAqacsj9Exexo3dO0U9Ydw4yxOhOJJHf1iMArTHD7I9uN?=
 =?us-ascii?Q?WcI7ttpMUR6J6qLgNYXr6d9DuiRcgWEJ1B1lnQmpUEYAZf/L5loBgLlzF4Hk?=
 =?us-ascii?Q?z7a+h2DHBL2YZ5QGlOCBmPydy8FtnH1O2UZoFQNjEiohagjFtuwSNB7YkonG?=
 =?us-ascii?Q?L2TStV0n1+gaO2CAj7Q+4NDgp/kMUxj6iHG8oPJicvkvHJu0ob30HdBaa4w4?=
 =?us-ascii?Q?HDQX/jleoOm5XHh3ewMzjVhNlBodPD7TRmw5XymoY+rC5G+PiDNjdQqJc932?=
 =?us-ascii?Q?RMLTqIDVKA=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d746c39-23fc-431b-fc8f-08de6e1b31b2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:53:41.2581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+kXeyiaabZTxkL3VQVfiYPk5LCzPLNKQDqwIUFwrgYIHxDd1F/8W2WN1fPxp2IT8ynAgQbPHjEysbsQaFypAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6761
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

It will be used to capsule signature verification.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/binman/btool/mkeficapsule.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
index f2ac654db81e..7638c941a8ee 100644
--- a/tools/binman/btool/mkeficapsule.py
+++ b/tools/binman/btool/mkeficapsule.py
@@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
 
     def generate_capsule(self, image_index, image_guid, hardware_instance,
                          payload, output_fname, priv_key, pub_key,
-                         monotonic_count=0, version=0, oemflags=0):
+                         monotonic_count=0, version=0, oemflags=0,
+                         dump_sig=False):
         """Generate a capsule through commandline-provided parameters
 
         Args:
@@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
             monotonic_count (int): Count used when signing an image
             version (int): Image version (Optional)
             oemflags (int): Optional 16 bit OEM flags
+            dump_sig (bool): Dump signature to a file (Optional). Default no.
 
         Returns:
             str: Tool output
@@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
                 f'--private-key={priv_key}',
                 f'--certificate={pub_key}'
             ]
+        if dump_sig:
+            args += [f'--dump-sig']
 
         args += [
             payload,
-- 
2.47.3

