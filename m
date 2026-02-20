Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822EBC5516E
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:16:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9F583EA6;
	Fri, 20 Feb 2026 10:15:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="b74kHzw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF8583EE8; Fri, 20 Feb 2026 10:15:32 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D28DE83EAC
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGifk11Kg2iYkmLEBPnrd+tnnCcmiZ1IiI3tG9qw3qTKbHpgmaFvQHiD8QnWvSHBJhTqCz8Yj0MUNCoj3MfbK1/gm8l13OnHAIaGOuxyZpW/poVAUs+teK4oGR1GCh6BrlJ5FT2j0FcZuevqO65ZwiwER3kxCWgOZWTrVZ88HM80iuHCP5COh0tj3ig1b8o7ab/2+1Jl6cMjlp4qLKBTwfwxT8DkRdsOaS/3FRtejp4JtV7PQEjggvWNDFRX3rizm/IMcUkRQn1C2jaKAvn6yvc2mM3ACfGUeUfRp2r5/WSkuxEsbBUfBjg45yEN3GhiWeSZVbvRMgbT66lLUR7RTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=YWaviQIdawgfF87Jf7/cdC0q5aq/if/XeGTeHDwm+b9hH6eRSLzK5Qa8NEsR+lRZimC/rMB1wL9bwIhfI5lHRcOQ2P8I+mDzpD5KzWkWJzwgEhT4a8gTaCzr5bOEdUmTkEns3Scc8KSMhWCgeb62NXfuoW+3pfgFhZyFyWZXoYiS8C5/hg6L8Lzg0r1VTOzFI4zru7LPlfzFmCVXBA+C8fiWJRJKLDq9a4WYaXvPXXYzWVxBUtU9C+36wUhoznSvfhbmjTn0JFnR1GRF9YGY9g8WJAlPQoDiXxD+H/vrincjh3vcoIaGrkrtAZly8zgnDcCTGY5oXVGupaWjWnbT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=b74kHzw5VJuJSyX7dAJmOvWBiUN87mTiamV5Qs2/d9BLVKulWPLQfc7SneHXkWNoTY70HgQvAgrqLdaklk1LNZ3uuzBj/ViRUwnFfXqiXlY0LyFHXgi4FMqmLAVKER/mtdnRzJvmOaoU4JaYslX9m54A8Yh7VUkDpmPZgMu6IW6A7lnwFLtCQYE4hlcQ75aoISuanvkhL+AZnjt4EIeGe1KYTMVVz7/jutJR53V7gE5uq3QGF0w/80dITqy/GUjwNDsDWn1usVSwlG3RIodcOvkzkyxYteCFZTXDhNmtBYthse0BoBe1mkGjnIWX2mlExfJrPor0D2nrnXvSXILLqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV1PR03MB8544.eurprd03.prod.outlook.com (2603:10a6:150:9c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 09:15:24 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:15:24 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v7 2/6] binman: Accept pkcs11 URI tokens for capsule updates
Date: Fri, 20 Feb 2026 10:15:12 +0100
Message-ID: <20260220091518.180641-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::18) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV1PR03MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 11119fc2-e5b4-44d9-d8fc-08de70609463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|376014|52116014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9iFKw6N/wQUuoS8v0DxEbYLd8HXo8Z4U7nQB/QZYyhv1mI+q2A2P3lGrKgPD?=
 =?us-ascii?Q?l4ni+rQrWpFpowB6ghln9hbcmeHZkmhTCWnHzbjLZ6jqVEXFi4P/s+7xCUp9?=
 =?us-ascii?Q?GSTxjO9OiXed+Y4JxuV18SLgjkHqWSjVAHU2tbHXA04Ugk7jlcVPlD0u4xv2?=
 =?us-ascii?Q?ZZiawpm4LFk8rUPMG6EVpgmfOPyRuorfQPKCv1FwW2J0OAmC2Geh+Pn5nulp?=
 =?us-ascii?Q?m0QWbu/j9tUIwWmy3+xSLBKrcrpzgl9cbJqiXJYNZzwOd4WP46Z0KN0M53oo?=
 =?us-ascii?Q?xwNYbaoCTvaHzwnYjIVuGaW2MQSPH3x+IH4wGjL/E1P0qxthT52JKk09hvsu?=
 =?us-ascii?Q?ElpQSXr7oeslsOmvsBSLwmXIQ1CHfPAn6l9Nyy1//5lhZjaKxAR1XezlDFNj?=
 =?us-ascii?Q?8IIeB/0ji94hjqBXtgnZapMKFplZ8nX0yRlNb6wATnbriaqfFv8NzBneWoB1?=
 =?us-ascii?Q?xeIWMyvg+Z/x7lSpvhLVX2B0UE4yn7MBSbT2iDUWPiF9A872tpgqIF9a/mIj?=
 =?us-ascii?Q?IRTXkFgi9nbd23Y/lYYGF7zafW9SUeb96higKiHkDIyaCl6Nw2KPM66Zh8k+?=
 =?us-ascii?Q?fr1YFtArexJMpdXT9AEWEypB0DzW3aRG4/1+4J5Cdt6oR88+wS2k3W1i0poJ?=
 =?us-ascii?Q?ReJrz8jvwZoX0SSklaVagC3NjQY99YxYFRkmNNFatkm+qaQTDVJxpJ6GbULH?=
 =?us-ascii?Q?VsQxi0VikaPKdw/fkHf1hBwjJxMZTXZgO47ntU2rQReJSnYObEXa1wJ38PmQ?=
 =?us-ascii?Q?ohkEcChcWYBZsu/ptx65fBkbWNXgTFwg6hTRz8w4FATimdcdFYi5QafqOOAN?=
 =?us-ascii?Q?bueoysT9RCowbKCiXsGv7ZP2Qn5Hr0DJwFY3WRvQuIcBCKSZT4Sx3JlupJFN?=
 =?us-ascii?Q?Vc+38I+UjSMKL8m+4CFPmlLUprnidqKmnxL9QF+EouNMOsBz9ox8C6RkryUW?=
 =?us-ascii?Q?vGJSknskGh6lQvzAbD5wmi46mD4lEmjqm5GhTl1+zVphSJa9OoIYl6TRGB3i?=
 =?us-ascii?Q?RIFHQFJCGEd75HrzKJ2iVQThk9Csck1rLtkPFpPfgS7InaBBud1Hn99btzYi?=
 =?us-ascii?Q?fWszDh/URdRvqtYaygt76MnBoR+34DIGX+oz4xXESduPBbtRUvso4zZE8QUu?=
 =?us-ascii?Q?iYMS2l7S+jfg0dAS3HwjhWe/X8bUEmzHtFO6OD7HV7xXZD8hOeCJQYGn/Rnn?=
 =?us-ascii?Q?rj6bWXClKV9OLp9pMsTw1XRs5Vmm5rQUC7XXjT2VT21yk9d3iH2SWc4c+fHB?=
 =?us-ascii?Q?1wp6rKSHZxRcAvFD9Xkn8FwUXZOldQO9uc+rkTCUS3Z4eOGe2rj+URK+7FHq?=
 =?us-ascii?Q?GZ3HvJF/KZH62Moh2RieMl0F1gv4gNJkdqwjJj2R6qnP7Qqyc+7Pp/4k+yBU?=
 =?us-ascii?Q?20tdc2eSRF8WLJsp6/vmGO9q276rJUNmlt/2CnITh5rEL3cq9aIdAMxbx1xk?=
 =?us-ascii?Q?ZDjVcqZF8LuJII0/a0ZiTnlp4woYkeQ0uiqC8hJ0x3wXBTr56EBI6Qk6moQ9?=
 =?us-ascii?Q?PTG2hBNIVtrKn1c+tCKZO83zSOGaEXgUWviQYp+/P20QDbs6J3M8Ce71Jtvs?=
 =?us-ascii?Q?UsE4Y9czM7s28h6ZsIU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(376014)(52116014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sk06B3wgbydaDVWTghqIQ73uL26lnrBlsldBvD6uU8BUh9N0fFQhd9zn2HKt?=
 =?us-ascii?Q?OzaICw90yrWZKehga5RSXg9755oBDPfSwQepcL7u1Qd56a1PuSuP10mmNlJ7?=
 =?us-ascii?Q?57sbgSQokCGQPTDWojukSmPLkqj5RHt+Mgwu0lQ7BGAVso+zjO5zYBjcxx1j?=
 =?us-ascii?Q?OkrzKrFmMuvCxwN5yFqzywq32QbJ6KiPX11IPVdnwotrDCCMFQnNXwUm+9vZ?=
 =?us-ascii?Q?AL1vRmQ5pzoVqHDdGrjAWUi18owgqLaWy8qs69S32znuROkmDAAle1MLlwSg?=
 =?us-ascii?Q?Jt+n0+c7ssz2gdpcL/Q1h1J/U9NAxNZou7qHWfqIFh59WN4+svG/glWqR+J/?=
 =?us-ascii?Q?FSIg0phl3xYrVm99O9BhEi/qlCo43s3E8SBQdoxjCH/ymcKl32YaalhIexjo?=
 =?us-ascii?Q?1dtYMGHAHA4BNcANIVOBMczL0c3Ju4FBJFpCHk2i/bBincUytuTB9POiumXS?=
 =?us-ascii?Q?RE6W0p7dMJYlcOYavaOhHNeZp0i/SNZ6OywJEynwBx7FVWtxSHt/HTJLoQPi?=
 =?us-ascii?Q?77ruNbIf24wQHfyzirkBq5dmkYcJuhWgkKs+B84N20bEG2eot5PlMUdGKI2o?=
 =?us-ascii?Q?7gfQmUA4bWFx1XRPzJGH5Sz5ytz41+UpmMS+DUHg6n99pmjl08Lxjcbzwnx8?=
 =?us-ascii?Q?j9RDsuU/PcKcjgvYmCGCBmIgWAi/xn6Vx2p/yyFHIvhbPYNh2SFLfI6YQqwA?=
 =?us-ascii?Q?KPJwzV7YERoHBNirb4ZB3Lc7FrHI6YVUDStGXvYqVC1lhrYrep11A8sTQH+o?=
 =?us-ascii?Q?RbfVAuU6S75NVgq8Grs2eqNP/JC+GInNoTZZepBI8D3W+LzJDIk4IdX/WC+P?=
 =?us-ascii?Q?/IZjhFMIUhCa+b7OID5zvqaW7gHhI/x1VWLinSe7sC9SxTZCA8Jnptv9/imA?=
 =?us-ascii?Q?9FMw2yVKDyosFyYGGwuBaZqV3A6yFjr2SlW09VPhNQY2itvr8ZYGdlHzksOf?=
 =?us-ascii?Q?ncvje5KoRbJLYb59vMdpuZqvCGGlXQG0FA0/HjJreOjJILUE7XHh6IqSg/ad?=
 =?us-ascii?Q?CMQdGoI7L+rBwBnkyznytDAYZd63/cURhAJxpteC02CxDIVo6Hk/5ejtGWx9?=
 =?us-ascii?Q?JCmY3PBmzP+7jDZKksneunWWorI/YZgguQzKwy/iUDoac3cpW3KdQ8n/WlrV?=
 =?us-ascii?Q?2Ya8oocHAgb/5XNMWMyemXTzPMagfEZ7eaD62SsEDpPkGCOhforEGUksayYn?=
 =?us-ascii?Q?xuHJynZkVDVqXU+PkIE8oEoFlyOmyRK2A4ROSrhLf0Eaj3Nkxq0x0m4Lc8d8?=
 =?us-ascii?Q?zDzXdJyWHLHrEe+URBA7Qprf3xxobEsaOdnMBe7v5QgfhsMKekgVquHXsFYv?=
 =?us-ascii?Q?sO+onx8cn1zANLAsw3Rf0zbbQw+q3jBIwWRaUlPxlPClN82so51DSgz0xkLF?=
 =?us-ascii?Q?AXar4bR/qN1jrkK2NZJNUA9dGRyQA04AxLKQhcIgboy8qEgKIzuKvOQptQwX?=
 =?us-ascii?Q?LHgT5HGXYpWakwsnV6ClzjH16MdM9L3u9CrJvnlPBv1Kth3s/qFjZdLR2312?=
 =?us-ascii?Q?zHIEJMwJ9vf3VG/g30JQhX641F3/dcNNEAdnHz/yW8Kp/doeCRKZuHuxdILs?=
 =?us-ascii?Q?u8PHRHLvUDWmKxVrj3GovBDwqQ14gP/23Z0TYbXjpkbrCOqXZ6q7bBoM/ouU?=
 =?us-ascii?Q?pEUozwxnlykwJ8tnCCnGA48xrF561sZIoUZCVjGW7ZNAV5jZKvKXpBqyfLKY?=
 =?us-ascii?Q?f2Ngw8gApWwrRLhQE7I6cP0flwMGmhp1fbnW6t47fIUD+M7b1kQ5hNkIwkQJ?=
 =?us-ascii?Q?r3cnkW8IgFBI1r5EPbbjXBNHWH2CAMIx6wpg62QGLeWrfsgHlVOcqnzEzhYQ?=
X-MS-Exchange-AntiSpam-MessageData-1: swfGqs6yN4aMrrrrFShKVTFpyJnuXCA7yuQ=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11119fc2-e5b4-44d9-d8fc-08de70609463
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:24.2940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SK9iXE5fUteO10nfpO28RF2hkp+wKFM82vPLMmdsStiK3WpRPyrbV76Seg/UCakzK5BR0Bowjbys1e02uVF+sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB8544
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

With pkcs11 support in mkeficapsule we can now accept URI
tokens and not only files.

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Simon Glass <simon.glass@canonical.com>
---
 tools/binman/etype/efi_capsule.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index 9f06cc88e6e5..3b30c12ea514 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -125,10 +125,14 @@ class Entry_efi_capsule(Entry_section):
         private_key = ''
         public_key_cert = ''
         if self.auth:
-            if not os.path.isabs(self.private_key):
+            if not os.path.isabs(self.private_key) and not 'pkcs11:' in self.private_key:
                 private_key =  tools.get_input_filename(self.private_key)
-            if not os.path.isabs(self.public_key_cert):
+            if not os.path.isabs(self.public_key_cert) and not 'pkcs11:' in self.public_key_cert:
                 public_key_cert = tools.get_input_filename(self.public_key_cert)
+            if 'pkcs11:' in self.private_key:
+                private_key = self.private_key
+            if 'pkcs11:' in self.public_key_cert:
+                public_key_cert = self.public_key_cert
         data, payload, uniq = self.collect_contents_to_file(
             self._entries.values(), 'capsule_in')
         outfile = self._filename if self._filename else 'capsule.%s' % uniq
-- 
2.47.3

