Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11804CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF488004F;
	Tue,  4 Nov 2025 16:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="fp3aejlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8413835FE; Tue,  4 Nov 2025 16:06:11 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8CA8003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2/g0chZB7iH5h+LX1lcjqsSJYyOlB239eJ37WVUt7kJLtpzmYbpJlqQbN4my1SJgdU5L/iMy9rV5LHJP9SR7dDs5M7gYo8HDryVTJJZs+r7Sy2g0O44agd59P5aKUjuUo467KnrPYqyb5bES306EQ5802u3LGiHCUkFyRI0lpDbAKJgT2NPMUtn4trzF6XslUBHHmjrXbV2uTl3n+TCieEHykzfkTDvC4rx/LWHsOmuwTe4eR0yifgFwbUdKeGFgyTdOz+kFCgrIusrqxBcfSaIMbISktXPUeRETsWI4W7i6D3I9GPWExV0ufQ7lVPl5HG0JJ9U82pI8nlCt3CdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wQW7LEKZXy24eXDWIWArlANZ16QmnmvfNSHmQHCuZ0=;
 b=nIlGVEwmtFEeGM0INvOolh3azR56unyx71bU+2mdsawjcG8FIOi46+FSw07umVg7j/0aBXCu1ZtLltA4MSEsvG60Y7H+u6f39HueVNg/Gsc6WuLX+xsU/BGwu6VMeWecRV9Y9aw690LzaqznRdvTWlw/j0sQCldUWudmOKTDka8b/4PjV170YpvFGZhzEoSrVJGqtifTOLMh9CNlYvgJ3PiW3ZYJgT9nNA4RKxfEsloouCSZaXIxZIhh/T1T39Eq7A0TF35iB/t0an0W4b2j538svcHcZuC6P+2nOeo1BVzaJZujWCa48T1Oqfw/pjBkSFks/7AIA6jQ5n2Hg32b7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wQW7LEKZXy24eXDWIWArlANZ16QmnmvfNSHmQHCuZ0=;
 b=fp3aejljMj5zSc4TplXkn+hplqDYIvC9oxIIwuPooyqaJQKoaFkjQUOwMICoItrtbmWfMR6qkNM4k66dJIfnJHQbfJrtf7lemqJeK7NCQZow81XA0DcC1ofIpC1TgQHQuqWMsyJdeGhhMB50c87uJW50/nJ6q8eoR9GovWxY9BnbAB/a7Sa1LHGunWDHQ+F5GCqsOi5KcdFiB6Vjue8WzUBxHFSS8IlP//StoWjO6bOU65GWnBjo3M2xVAQGbl+xClzO3GEZTOON1ftpGbmghAcS/TrKnaxGCustdsGTY3Qpfwwm4bbIbG7hb90bpunyF07T506mU9hH3eSQzDnhYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PA3PR04MB11204.eurprd04.prod.outlook.com (2603:10a6:102:4aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 15:06:05 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 15:06:05 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH v2 1/3] imx95_evk: Share the env file for both 19x19 EVK and
 15x15 EVK
Date: Tue,  4 Nov 2025 23:05:35 +0800
Message-Id: <20251104150537.1167930-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PA3PR04MB11204:EE_
X-MS-Office365-Filtering-Correlation-Id: d5067259-3bb7-49c6-75db-08de1bb3acd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|42112799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5NeHRV5ktEMLe/b8nP1UYDvMxS7/rU8GZ5c8GYf9weWVhVocEYKFZRId4AfC?=
 =?us-ascii?Q?ijp03LmNNMYOKq+h+WgxWjtVGSGGyvcgTba+ie5z4cTMJBJsfenfDaAsFPAN?=
 =?us-ascii?Q?K9cu/91wWMAQmVl81nx1Z+Yr+lI7zgiHojemcrDFsVZwFe7pMUsCYG5OfMnd?=
 =?us-ascii?Q?pQ40bfq6dgt2txT/jf2QlWG7cLf0yA8qHS43+UF1vi92P0aHsR9EUHMlZzJM?=
 =?us-ascii?Q?vVmVUUyeofMBjnYcsM4LAsjusSb9imbVQr1e9nVCORscn6KEHtEOWlgl/qyO?=
 =?us-ascii?Q?YEqBH+/r+4lkgY7KI56Dw/icrAQC6PMtRT3UppbpJkaJfmX+t+TjqsPS1cg3?=
 =?us-ascii?Q?auLYkc4PgL6XSJVsHAD0J6UpIn5MGQAdq+S+ohYkST92y/ynoOewPYtd69At?=
 =?us-ascii?Q?X9i3JXSjbx9CK86TdXEnHwv70m76N5u/2YTt7J/sp6laFUm8YL+Vqd5+ZKOY?=
 =?us-ascii?Q?a+Toc7tZY2GbI8oksC2npFhBSPk1jdeHJYk37ypPTVqKAeYSefjpFZPdyUGm?=
 =?us-ascii?Q?yCSiMZkD6cR8J+KixlnggSuTMK2vAzeiCckKMZe0zfy5lG3ZeXsqXyBqKJKo?=
 =?us-ascii?Q?GjW0t0aDPX5RY8ZGsylvt2GgvPvMphsoS+KuAIgarYMvnp5MzYCmTfCBaR5Y?=
 =?us-ascii?Q?S9Py1DrvWxpDgTRe+lR8qOtrgu4CpmTCkV1T9RrWhYKPzEaIJ5T7Xh6a/T3E?=
 =?us-ascii?Q?9/lfnd4TMTMosxtJv2NQ+EqcpLRt8L869GbQgS24Khk14VgblpzJmfUyXq9g?=
 =?us-ascii?Q?4Nmro8TqtV94hqRtxuBdB41B7lOfBKIH1cGyiX2FbOZQNDlq4OgocRPIEwok?=
 =?us-ascii?Q?UoE4HxoP/VI0qhAiD1oFCC1nol02NUHRJm43zaIS/hpniNFLxxSyqvku2QpZ?=
 =?us-ascii?Q?VzLRBTJ6H6JE9CvIB1kxlX97GFBl2wLwHBt/dfE7UU81L7k9jMCm0wBsTtz5?=
 =?us-ascii?Q?b8gT/Qb2FRmq2ajo1r+FdGcSfnZAjfRhYUOjA26bxzkX1i5ezWj0j2dFRlav?=
 =?us-ascii?Q?1J7nicK5tMu0tO6gvvsVdoeUp7lJ3nJjuZ1CceaJKLYWR6wBTQF61ghlx1+X?=
 =?us-ascii?Q?rBtHT1IkZvzvSu9vtbW2xB5GEankYoLazaVHP8yw7EIJapeWV74HjLtEU/xD?=
 =?us-ascii?Q?aJJ/craLSwYcqhj2VfsXMAdczRcTH/KRyd6OjMyr60Tg6o4FgOeg+IIYysJr?=
 =?us-ascii?Q?fluuZmK6+cgTNp8r0JektkALMKdDrcGFULCMwyevuRKsK1q1kVC/lLlc/H4R?=
 =?us-ascii?Q?axD3kMWcRxeGYK4mQ1ST0gknphDnugGus+U4cfr5jJy0k+eJNLqFGgAmgYCX?=
 =?us-ascii?Q?XXrC3TT3VsQaTYdZHgra6RVRjTKxDxxTp4n6+YVOI5avApQ3bRchLFrM8D8K?=
 =?us-ascii?Q?K/r9tdBvxYHnYs3cU9l3G96Cd8IbonO1MSv4/Vrq3ROvAcPW8wxfESAkD/RT?=
 =?us-ascii?Q?6fKQdPHLvzo8uGVO6mGON/hXgRkj16OhYTqYzFWfhcc48TB1er/BfNghVGia?=
 =?us-ascii?Q?Nx3D2ko5rajQfdxETe+reQ6OWv/gO3+rZ46Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(42112799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYkVgMTNy73tqDahJyqV0pPkCkE74Advf78NBnf8BiGqJ+SulORF6saguTqk?=
 =?us-ascii?Q?MphR35pgYdCPyOpDF3j9FXq7IpZhPVsw3pZCZd0GZ+eaCnBlM5MSTnC4RD8l?=
 =?us-ascii?Q?3dNbgOFmI2CIWIX9mKIt78ZF6VyW2z6+vClCJm2S/l50hyprMHRN+Tqh6nB9?=
 =?us-ascii?Q?/zBwviZP/565rD+MxSEWIjrisQ3/00SKKaaY8eco/ICWnPkhLCPRxeLQgLYq?=
 =?us-ascii?Q?gbekOBFYg4obdrAr4o6E2I5Co/44VcehAJOE6Meso/Haf/v1Ez+jDlJEvP8x?=
 =?us-ascii?Q?1IfrU3lWLL2ULSF1Qz3CxaU9ruAODskOVjNb5LUlwUWrE8scoCP5fnaq5j/4?=
 =?us-ascii?Q?Jb6CL7RovR+6zk34H2xL3i7pzuGHGzggmbdbIda4VOtidUe27oGDt+I2kdKv?=
 =?us-ascii?Q?8z5V7T5biWQ8BagGzvmfi78jFjB2wZ8TS6h5rlgnuo+S7k7+txIqseDvx1Nd?=
 =?us-ascii?Q?3ifTAjAegAXrWD7GrJC+OsnZktMunuCt/3UN6zuez3ZP4TDb4nEXQODgkl5R?=
 =?us-ascii?Q?mQqTnqwTStPjKO+4pH2i4oWCJe/V6SWGB/pEK6oOC29RpW54dAh6sChgOlhO?=
 =?us-ascii?Q?gBUEEsrIxia5HUuJJ7zKwrLjUx6bi3RDXRdZL8oSzckudWc7dn4BssOKZ2Wo?=
 =?us-ascii?Q?1t+owONYtCXXhv+s8hXoS4ou2UdMqSloULuGqhBMSFqmAHKdjDhA3RzskXmJ?=
 =?us-ascii?Q?0rrzGpUuu2k8QZ8MNCBGjOFPFqK42FCNbzdY7SPkY/BuZVyxBHxI9XanlDYM?=
 =?us-ascii?Q?J0fsY+tNnGuDQciFZ9fVMr32kciDE6kxLopuMVjiM95+yEgVOSk/UuL9JH+K?=
 =?us-ascii?Q?IXOM9rnJsMdTpM4O+F8qwAaHPw2riZXx2NyfoMN+EGxiIVo4h12WLLVig+Pg?=
 =?us-ascii?Q?O+gSEYzhRhOU6YPUJdhPKdKa1OWFiCAmJlkkYpyX4NgjTKDlyszhKDxir7HT?=
 =?us-ascii?Q?pKx67PREEht3K7pnC/tPRzCiYdBbavGyHwAIiYBEolqSblMv+KFQkuuY24yQ?=
 =?us-ascii?Q?TkYFFZboXzCjS9VBoe+imUE9ZdGYSqYvArVRcAZOyTsCVDe79dgHor8cajtu?=
 =?us-ascii?Q?PKK0dsUX728VgtEph5VoZ4RefxPe/64GfVR6Z/HsnROBYIKqaKdhPNXTjDcW?=
 =?us-ascii?Q?fyrTIA1i4sQm/5PFe/ZgYuRcptsnzhbUtzi9HDHkvFMb+gThDzy3JZQJB4f2?=
 =?us-ascii?Q?EiyQjes3DHiI9C7cs6b815DrUyObHojVQBoN76t3bzuLhDzOza+dLC8SitBj?=
 =?us-ascii?Q?lklZ/3AVB1RGZTR9B6zCrOqdu6LxnmcbqJkti2buDzFqT3eGkj5UU69/8JWW?=
 =?us-ascii?Q?jBoS8I2QRXo8q8snyAh2vCQsBMhiMkEbAwyNCIynbYnUHPLQLWmk2i7EhmXA?=
 =?us-ascii?Q?PUkSx+liVrbXwhSVmli+5s/AsNTMT/2buKZUBY1XSWVsJSEqnnVqoXKOZqIp?=
 =?us-ascii?Q?lHwVXSgtjymHWOnug/KLVtTR6B3zMenQXuIp9kvpG87kQWdeW2vQWnUvCG2u?=
 =?us-ascii?Q?ASoc1YOeIroCBVCiLas2JKNy1wfNU3uq/1c2kfDJF0qetVq+pV/rPf+Tvnaj?=
 =?us-ascii?Q?F4tYCgRIAguqgmbEToE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5067259-3bb7-49c6-75db-08de1bb3acd8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:06:05.3086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXLBjQFZN9wg5RFLYy02eYieoAbhx//mge1PIznIZrRSVSefkXWYrFnqSgfZ6KHl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11204
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

Rename the env file to imx95_evk.env to share it with iMX95 15x15 EVK

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 .../freescale/imx95_evk/{imx95_19x19_evk.env => imx95_evk.env}  | 0
 configs/imx95_evk.config                                        | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename board/freescale/imx95_evk/{imx95_19x19_evk.env => imx95_evk.env} (100%)

diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_evk.env
similarity index 100%
rename from board/freescale/imx95_evk/imx95_19x19_evk.env
rename to board/freescale/imx95_evk/imx95_evk.env
diff --git a/configs/imx95_evk.config b/configs/imx95_evk.config
index 231b42cb377..631ec23c335 100644
--- a/configs/imx95_evk.config
+++ b/configs/imx95_evk.config
@@ -7,7 +7,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=3
-CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_ENV_SOURCE_FILE="imx95_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
-- 
2.37.1

