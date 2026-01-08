Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F95D185FE
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4482D841BD;
	Thu,  8 Jan 2026 15:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="NIBip1BQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0AC083B72; Thu,  8 Jan 2026 15:14:06 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D47EA841D6
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiPtS/j7GjqN2mYQFtUlCwqa2+EWYvVZ200Wj0uv8bdfX6uGQ0DtrnjU4CoPVXW7o9WcJ5rzNE+h1ADXVI0Nxux4b+5pDymwV7AaOO/WQ9a+7FmDQY5llQb6qZwTt85wst+18e4rn4UA/ey9bvQtzzEZiaTXdDypzIEdca8XIBXX7pdBTSigunKBwOg79wWcgfYAbUAikpE9wAH2kXF10R6/XHjOD+ioa/pUIAILsz/ezP7xEzpe6eLVxpNqOKWCqV+wHK3YQY7i/V7+PlEegMFkMHWrVc5EAsGLkBdV4isOlTLZ7w0MwXo9UzWCVnBzvulDHMEOUPT9bKbToQQhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=mEanWeyVjqOlSrfp447pOGvQ9EDoVOVQQ0epqRaRC54ZQbLyIG2TPKMtjKRH6sofAyHMzVRRHOstd+6+W1zSRI9VgXQv7GtlzoW8Y6trGYQABHEDf5hph0rw/6WK6+5mEvBz8wAunWkOswDmfjUz9NimNM0qxwrL+ODj+oIKPxpBUnvE/1mE6LmJ4DH4EEWSeTua0IMLsWp2WNOiZg6Kr6vYxoHO/0pJ5SxFUdlFVxRmjE4xcyhipdClaDKhpkOMvoZEYLrsiTf4Pk5gvc7EVtH748yjpNBVYQx4l39Nu7Y9Qb0+/FU/mUJKRpqcLTCzVRck9CSCrQIZY98abyutQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiuHgs3Kki0ZeBz8l7YxkWwGdBTr96MtaMePxHyEqm8=;
 b=NIBip1BQW/Q09Tmkplkc4asCxmjtsLU2NkaQ5mL+lgo2/y+N3pmO476HQ7nKRFkV3Y5e5ghajEGhq/UN7wT+E7eLuf1OFKsjTRopQ0U/ZWg0S+Zmkoa/ntkARpST2clPepLXIOA4mdSmodqKQXnv3B4uf6S1nNnucclF3HRStdIes5+z8ubcGDTHOGCWeDDNtkgooXt9KQQCZYAnytDyhFP4m9hGWuPk2VKSGEFiIlBPi9dpxD7ixdab4+95Scd+E+p/CmvRyXexxTvNyv2mWAhtEfCurCtvay2uPb7VhnBzsmL1Uf3nW6GO6S4BI70c5fry3bnXiXUuBaV7GR92HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB6836.eurprd03.prod.outlook.com (2603:10a6:20b:2d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:14:03 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 14:14:03 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com
Subject: [PATCH v3 2/3] binman: Accept pkcs11 URI tokens for capsule updates
Date: Thu,  8 Jan 2026 15:13:43 +0100
Message-ID: <20260108141346.1663305-3-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
References: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:610:4c::26) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM9PR03MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c40d88c-a1ae-4187-3fb9-08de4ec02d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SIvO/lpNwpJUe0eULLrwN1aMg66Mn2RXYdaJdS36F7KI2k7Iy0sRCYZqWwSr?=
 =?us-ascii?Q?QZkgF56emwko79ET4gDTz2m6nMAV89UBOth5C9E6lv9F0mJHnG65GDBj/1Ew?=
 =?us-ascii?Q?Gf+sQ67H9HC2W9GiyZQXjY0dwm+ajox+9AKuFxLNIyB0lkirCPM3Jxu1IKZi?=
 =?us-ascii?Q?cPrmJmCwk41iRIUXPBiXogzbM7iTqjPQEAIQRcsDWsncv3bWrn1lrpe/c6Ai?=
 =?us-ascii?Q?VAdMFmgp9BD404KgA+xvMtBZ1rELfOyyJv3cTNFKtSRHTXi32R/GzirxQnxa?=
 =?us-ascii?Q?O4J9g6dicq4z5WVJ2Z5uAFLpX4JWTlxI+ETQzjjryf2smx6qsDE2xUR0BDrm?=
 =?us-ascii?Q?MOkegrgzXTRL6y9jpOTHzI84OWpbZ0qqUESed9+020bgd3+rkW4eJbtcpDA0?=
 =?us-ascii?Q?dYNBN6NAvWgFCoXVbsrW7VKtxRbjktHLvbA9O9lCoPUDvQRaanXDdi484QDv?=
 =?us-ascii?Q?ti50doJ9xNvNIQJntEI+Uhgn334BeY90Bv9+uCKQuv6GkIxJ0Op6iEPpkTI2?=
 =?us-ascii?Q?6MKC7SvSTTpqd3wX2LrJ9r9Wr835K9XSCgPpRccnsmKd9LnZZBQuXuBKPeIE?=
 =?us-ascii?Q?bA4lT4s/ffht5kFzeGYLHQUB0VqxORYgCGH/Jl5q9cUOf/ioXZEeB4CvSrd1?=
 =?us-ascii?Q?BK2d0TrHOlJSlkArLfCxnTiIwI/d8rOjCDrQq4wBuRkh3jDCMbrpoHf7rFYd?=
 =?us-ascii?Q?jpZEIYEEWXOOOosSZ2gHS3Kopu5Z8WIUUv/Rc+SOfspOesFRcB1FEzdOrKPu?=
 =?us-ascii?Q?rKTU5Dpy0s4SEYzQUyJWsD7EmJsPGqq7Tuj1T4TnFSarhEcz2OhPbhCco0tv?=
 =?us-ascii?Q?meGmr9GtYlXfNb+fviNHMalWrQyrhm+LziXbPpodD3MXdhJ/HydDLYZye1V1?=
 =?us-ascii?Q?8xi52P+8LlPUeIjOawM4+om12Nvyr0inWxTgyu5JJ4uE1YJ2fVwSQnT1mhwq?=
 =?us-ascii?Q?PG6y9RHMUf99RxxwnAyBiDRiP2QSwLQ+0kG/8jN/yoT2CJvV1st+9batM8bU?=
 =?us-ascii?Q?xTrdEXlIjfgPpeDKSIt7pZh6P/sYQitmToOYsUkkFj+lL2r6JIAkfStb9Nqj?=
 =?us-ascii?Q?5EY0hqFiyu195cdwx/buLpWFY9T5Afmy211OJEbkY3UeYtJ9ewJ+vSerts/u?=
 =?us-ascii?Q?r6xOryxjbsOxCaO6pgnGtOlmGGwgbzPWSj6Tqt8tZKyudj3asS4dCApCxkcb?=
 =?us-ascii?Q?v0iFbhubwMrrVfj+tY2LShICMXSL+CthhzqK1Kv/rOKnUKNWSqXV0A6UKfb5?=
 =?us-ascii?Q?X0XY9nav3Y+6JyyjoszHyqHbXeJRf5LQmXXzU19fnXFafkHzyjBDLcsalUA1?=
 =?us-ascii?Q?OA8u/7Eoi5SEt60bSOMKNdiQbhrnzG0yASWFAsFellf0EF4X2G0iUXI8BaGk?=
 =?us-ascii?Q?/78LA0AK+d8zwpw5D1MZM0/gEddsHw6wAZfo7p0AdhnbpS8KeBT4jYuOAwGW?=
 =?us-ascii?Q?/7jDaBK4if/5oe+RgQqbmXjFCWVJl4RiSg5XnW5JMrCLomLVB/7olTS1611R?=
 =?us-ascii?Q?Y3wuWLM1YxyRMJZuLmZ+80lizJHh5UnjIyKc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZIrw4ymqQAFB4ElB/DuapDg9cW+YFgy7rpQF1Qjpn7kCErAmJgFeCTJ/OTnS?=
 =?us-ascii?Q?flZyLzif2H8yjBQngIYVO7hWgR7UrA8rdfCeZXTPfxvFtJqSzfJk5mPlRY2V?=
 =?us-ascii?Q?P5gUrs1D/xK7XdXg313LujCHOo9Tnc7ybTsWYizNIT/+KPE8qgTmUhvn0o1u?=
 =?us-ascii?Q?We3qQ5EOBduLYCJag3hrve/3Z4eA9MlDU6Q1IHnpXVVfsDz4yVIaD7Zdwpuy?=
 =?us-ascii?Q?lDS143fOXPArfe5sNCd1kVOvMsduimqEi4F/oIvULApNyGiOt1FWbWsrv67d?=
 =?us-ascii?Q?VPmt0s7I537ntownG7UD0xGPWWF3E5mTZMYFOeRCwPe/w0JEQnqS9c1+XxBk?=
 =?us-ascii?Q?VNwRNLlWxw+eu1xLlgq8/MsEu1aHuHKfNFraDWSd6DchcQ0SqutVogL2vgrr?=
 =?us-ascii?Q?56IRfAs0v4YoU61aBEMAO5zIAbKYeDy1Mok+PMuGth1+wS5EhJEadb/sMLiF?=
 =?us-ascii?Q?LNAq4ZO+1XxWEnLz6r77Ri6WUingyZHiUG2ralrWgLEqjrKcRKtk0rH7Fej3?=
 =?us-ascii?Q?S4E47tmfw6ZwTH5/ckS5asU9L0fES1qAqrDY/j0N9VeBWDmA9fYZSFNrC53O?=
 =?us-ascii?Q?BlcZxdETkmUe3Z+PTOe78/FnVOnYt1iwPekYosdiqKLVaJHJPS1rN4ofUDDA?=
 =?us-ascii?Q?ysf4gNz1e7wiyrpOF6ueGEdDJDvYL092DVwsGM6KLdubULCzuTv7P7zHCddi?=
 =?us-ascii?Q?H9ZHqxIBLlomMp+5SJnGBF0GCM+ha/ZcpfHsDq7oI4tnEgoU6w53tY4VBEDz?=
 =?us-ascii?Q?YysazinDmVd1Zez+vQGoL/kKGsT2HRQcEmo/JaCME5iAET47MbJUTHBSBtkA?=
 =?us-ascii?Q?P2wXiqOcBGY8Fiz+W2JOXaQdaHEhFUcL6s95k+tvgJ9Yy/ZN4WKZq6vKcTEh?=
 =?us-ascii?Q?S4rDcrU2RrnWuuet/McAJp1Dn27BAZtY1dz7pjaFS8PwGYW2WHgPkY8+4ehr?=
 =?us-ascii?Q?yRROTnJiVeZgzvFpdnEGNID9yYxMrpT0+YMX6ZtnRtu6zOZ6zDhX7wP36LJ5?=
 =?us-ascii?Q?IJKXqyuGU/pJSaqtKqQZ1XRon0e6huY2NSA+hz8DbO/3KlhfAn46MZxfRVjw?=
 =?us-ascii?Q?kcB5H7n68/OVkmqCeiVIoNHe5rHYYjZKQ6xjbR+/JAY/V3XWhC7f7C0M86d7?=
 =?us-ascii?Q?bUWV9tfgxGmndWmYN38YDtiPjlDV5XMYBCRxQbrk7dp7MXqSfxAaBf4L60q5?=
 =?us-ascii?Q?vPNTuSRKcGCO7YMw/rDlepuGrUotut74fOcMdzEc/jeyQyW2Ex6x8cUMVWIZ?=
 =?us-ascii?Q?10gsykVfy26aNbwLPbW/utxsMjf0hxna4U34QrR4pAOjEXNyv+V9l1PIKOJi?=
 =?us-ascii?Q?89zPAUurhJOJ+epOUFpznoMIswKcZBl5F0a58bcQt3pzsRDIAl/pbNlJgQqo?=
 =?us-ascii?Q?KmcJbmaD85wWtbtEB97u9+Bm98tqSTG5mCgE06xa2XzAHYNmFlb9hrrQ6s2L?=
 =?us-ascii?Q?k+l1W1f7IGROf9N4o1GC62Kr0J7Uvovz9YgmI9vQc7+8YpWW5NejMQKfAV4i?=
 =?us-ascii?Q?lBkrvIUIrFlaQM3wyArrMrgdotADPHJZ01iMQ2eqRpXmXEQcOepEJqH1vgSq?=
 =?us-ascii?Q?bCY+8YmGvsstI3qHXPLA7erOWgv6USuR5opQWXJxEG9APclGBzn+0XNzGgVs?=
 =?us-ascii?Q?SCt+JpuoZ8j9TWdOjk5h74JuNtHvocmc15otk0JCHKQ5jkeSM8Quq5oAR4iL?=
 =?us-ascii?Q?NNJSeNA11AudR0wXnbhrMfys/GTFHNTzMkms84FxXdQR5u83evWiYoUOWRY4?=
 =?us-ascii?Q?9qcqvM3MJQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c40d88c-a1ae-4187-3fb9-08de4ec02d19
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:14:03.1209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPb3C/4XyipYzgDFY6544lU/kF+h3lsjI5zIdl/fq4e9YnRhH7jAG7065Y+EQiVJQ3taf7gn9Gn/LwTa/MVmzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6836
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

