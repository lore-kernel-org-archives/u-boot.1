Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F60ECD6D6
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 18:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A4B83B64;
	Wed, 11 Feb 2026 19:22:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="f/MsORW+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D962383DB6; Wed, 11 Feb 2026 19:22:54 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A402E83B64
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 19:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSa0c8FkIwcxUjF4HAiv3y/DbFLyR4B0xZX46urywAP1X7Dwr03sfjSjlgimMlFo17nX+rvHlV7vsAQZJZ1Z+h7MN0c/0yNAewGaPeYkIiUCTIiJIAqnWIrMin7os/wZSuo4+TlXueBP+xDKfAmsPsnlKAM5dOWmy9qvFPqkp4aZXwrujVXvlUqHje/sAFPI9D+dWco013gB50VcO9mMBOrDHButxrpBhlWZ8yXMS6zsPAX1/ABuF2EA+oV5Mn1mzoE5Nmdb9XaDm4rYOPawxpKidAtNsN8g3qn/LaQA/1Y61ldfkB/7bcHx0hvZhoTg+oL5Um3jq2jvlS77SAcLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNWszupRlSzkrIVYTWNmGAQwV5VgQm5NdVYfWky5RWY=;
 b=X9zIECcr9KyaEqsqdPvOohQS6wEOQjGCnhJTT/PP83M8q1IzWD3GZrACTckHA3/aPDkhHg/mH8RI+ElcLUPISui+gzWEa8h2jGjr1wmY6X+X7psh32dSDhvXojKWS/SeahlS3U4Teub4A5FfLJA9cCEJWiM2FrAfvQB3bovXYJt1Fh2s2HQjmxeAPNz8Xy30HRD37om4W4tTFUBPYR+KeZHmdA5dVWQz84nNIJCTqeec0c/5mPQQXHSMnfpjpI8V62+WlBYAxh+h6bGLWo/PEWwCwmsH1MmkUN8Z/9geVUFqkqODAMjCA8QFAvOwcpgbXRWGip46boqxX9ByYbQU6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNWszupRlSzkrIVYTWNmGAQwV5VgQm5NdVYfWky5RWY=;
 b=f/MsORW+uilUikDnb78u0+b9Sz2BIu3t21JWVpO+npzxXHmTaLrN8irXzJEotsky8RDC+GJd22+2/Xay5gpOXU6Qj65ajP7AsUR2pOeePd0fhrcdDzFnrZHKoYJio7gD/jUaHyf2GmNSfknJaKap1RwJu9l1wHX88pwdz1Qu0ku/DmwsOggQt51UNhpmEO0Ycxh1v53ao4tfQ/VjO9Ejo2ucc41C2yDOREwDAL568HVIu7tLujEDAlDf8i3EUEQSt0VAFwzUAYBK0amt+LUcLV11o/dyt9Zp+jG6RTRLCS8MF9jozSJiHE57lq54ELvmqE6vIAwBaMquvYOTxkaFtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by GV1PR08MB8572.eurprd08.prod.outlook.com (2603:10a6:150:84::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 18:22:50 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9587.010; Wed, 11 Feb 2026
 18:22:50 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Ray Liu <ray.xy.liu@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>,
 Greg Malysa <malysagreg@gmail.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 02/16] net: airoha: add initial support for multiple GDM
 port
Date: Wed, 11 Feb 2026 21:22:16 +0300
Message-ID: <20260211182230.968921-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260211182230.968921-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|GV1PR08MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4d34da-9306-48b2-54e4-08de699a9090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X3TLOQAKOzpXbCvYXiyinBHIAxCJqDgQQa6DbUkN4JM1JWzmxwLSCmsMO6M1?=
 =?us-ascii?Q?pvIiq+jS73fnTbLBBzEJHRTnhDiliyIlwvxdymwP90jcnohgKt+X9g6+ec9Y?=
 =?us-ascii?Q?NBzZvVpVXxpsLkuvuMRFgU+inwHW/57zF/058KiwPuP71NSqBDef6LJp6tZx?=
 =?us-ascii?Q?t7kNRtTvfXizSWGc1bSfvqCABYnE8+QYKzR/mhs+F21V3HhVuGIA+/UrVNS0?=
 =?us-ascii?Q?JajAo1BBuaXn1OMW7POPkQ/xVyB9YO/iZGQTKs0p6H2B3d3YJAlzgZxJf1m0?=
 =?us-ascii?Q?JTiR+DKEht7wWvh5kxx4PlCOwysiqy7V265YSf5l3dKtwsGI7wOHTzIRvUn5?=
 =?us-ascii?Q?PXSu9KqNfcZ+nYSvMriqQF8xVgxSyBknDuiFJGBhQTRUXaUqPFEZMo3DrqZ2?=
 =?us-ascii?Q?YSGTkQ2J1SV/Q39K8K6J+EG02fIKkhcMNOPxJjivDK4G/9MZJrw7aTR7LBX8?=
 =?us-ascii?Q?1HCN5QI0EI01W0G9nWTATP5Y29ewg7mBcJzb9hwmcJDMAwZJDG5XsFYKRYc+?=
 =?us-ascii?Q?kyvKNTFipJFVIMro5kqW4wt9miisRuM6Kao76M/wGbrl4RW+cjoRHl4TX9zh?=
 =?us-ascii?Q?pexVXpnefEDid9Umi7eCpnxyTf/+0Cg2OdDLnR29TmBmvtJg2xbAsbL30GUy?=
 =?us-ascii?Q?JHZoYsOeIKOY+E1dorH7jpD/DaqyM5XHvNUhwzLQG4yruCusd4vJfmIzdqt5?=
 =?us-ascii?Q?p47ZxdvqIWDwN/Thya5NPFRIzUpSPwbV+LdgwQRcGeF5hCw9oqtxAelwJ5Ik?=
 =?us-ascii?Q?MPUrgIbEDnR9xhenE0KcWX9OeeINTN4zF5MXbnB5/nsq7LA2C13+SsP/ZJ8Z?=
 =?us-ascii?Q?kNFu7edmWYRsDh4xWsCoNQA9AmTwjg4eoPi/MHpUGwB7x48vRqHCj/4BDLQH?=
 =?us-ascii?Q?YnKgPXgpvz5icB9HFhIxxVaPJpKJFViVDxxFoe50yecBhXFcOErC28VRgIsC?=
 =?us-ascii?Q?1Zv4rXsIK9yy3xkz7qX0AnCvsy2/Evo9nl5t4xi3+9JyifKvSd/9w4MPGxOo?=
 =?us-ascii?Q?X7luSbom8mGkErbPGDJLSBn0dA8IYjuMiWWYy0z4XLS2G4GPzufY4AO2/qTu?=
 =?us-ascii?Q?2g3gsQm5rP8bKD9lRqbaJekXuPKlRU9bPxPoCXnulKE3m+prYVn8ZyMeCOrm?=
 =?us-ascii?Q?bxBeX3Uvbid9tuihp2wxQ55qhWFJ6oLdKwAuelv2oypzSCpHcuohunsT+UK7?=
 =?us-ascii?Q?/jCx8uDzaj616NnBzufUoZG/UyMikoPNdMUEZHKousb3r+gMSlouvKS5BUEp?=
 =?us-ascii?Q?6nwU0qUHmlirFvEu4Ol+Hal9+tsD6dBXnIqr/eB23oRsrlrw2mfc9i4QJK/c?=
 =?us-ascii?Q?bhtzXR8U3RCFrtGIrRljIPE2dt0Bffbu+G86629mqJJ5IXLbVzIBFMC9gXQ6?=
 =?us-ascii?Q?N/kohMINgkzvveDSEFzbjFqCyCHa9LxWUFOb1d3ZSLChLgNb1wke0UXddYNe?=
 =?us-ascii?Q?DXy9NdzCt3rz51E+T4ZhRdr90e40aPHHmyMx4ZsNBai5otQ0wDUksNlFyUKN?=
 =?us-ascii?Q?kSf8AI4QEppD1RKZ9yOErw/mpVriumuA2bcu58S/dhcC9UH0IF82dGab1MIJ?=
 =?us-ascii?Q?6Ep+eafPToYNWryHGXVJsJfmm2I0vACePn+GrSEkKGkWJURmx/BhwOu2MPNI?=
 =?us-ascii?Q?yyX0J61n8WVA2XVOx4cQF4+cP+5wkCkZuwBdrzp3pSPU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPjdTJ6SW4M3DU4FNJPxhhWOa6WLMPp8OUkvx5kwW+h5A5ZvyDG1rwvsbzFV?=
 =?us-ascii?Q?1XrjuNDG1WJXS4f7hvLG7wjpWAg9xaVGNL1rEprPBKgOWZQpCeCRwJ/Rr5RJ?=
 =?us-ascii?Q?xAMW8vAwgGFTiYShNNNVeVm54vA8mNrzwkycYwXkX1xz+S9m07zNPkFzivo5?=
 =?us-ascii?Q?6IODvrdEnNTB19q+EdbHLw1B6DWPjmWiogaz9DVGJA1KUqVzRnhLpDynqnnn?=
 =?us-ascii?Q?4lXe/Rj4lG6vQKs+FpW3aCO5okhVT9IJxHvKjU369WxrY4CEgnGlW8FQD+8Z?=
 =?us-ascii?Q?wDEBu6bq3gG6C+flnbljyfpRVMpsG03GoOIvNFFw9MB9ng14NYi27Gyhesew?=
 =?us-ascii?Q?yxNlKnQ3W7EUxd248H6bX2NWJ54UoNgy0s61rrs4wIfbSNtFcVKPInWAYFkq?=
 =?us-ascii?Q?HkX4ORTc0uMy8P57wOfMPEbeu7R55/1A2awP51EzDqNCQ/C1Vxqr/Vzhcyt/?=
 =?us-ascii?Q?+fMvj2AolknVClDjO4HliHxjePP/YY8WvVDTkVTjuMZNNNMS/30g93uwJ+TC?=
 =?us-ascii?Q?CDAyXPjIVg3tXOljoa8Qu1h1OhPRLlpf3HIkHX1D3yhRDqOlTTf4KXQeZH5L?=
 =?us-ascii?Q?YdftAkNjLvALhbYa9K9Fv0b+UBQWKH/UeAQ8yeejnUnJUanjMH5fkHt0tMXV?=
 =?us-ascii?Q?wZZC048JazXVqG5NKLvg6vYgpFutZd+yVoFKpiCs9ql0lKJI0yj+ijXfbtmo?=
 =?us-ascii?Q?0vIk5ePYonmH+gnJs5A3rZFaokLKgylZvjYY/2opHeiBXgt9dfA/5tmuLOdC?=
 =?us-ascii?Q?tGFB6HPgO9+nlGmgQO0g55KW1Owj9bhxiyIURFr3n1ht6q0jy9VkM1zK86l+?=
 =?us-ascii?Q?4s70rUc8SIM39GemNrYew7noBErKq7AKWvcYIfQYfwv3tcps8zwX9Tv+zpjD?=
 =?us-ascii?Q?VvrhUH2w5cBBpKys/v49IQ38H5Q4/H/QqACfu+PkyXhQXlcabF0dqmO0kdPG?=
 =?us-ascii?Q?IKKrsCwJs/7u312Ahs9ZdYQX94YdCwgbKFtG6+/qqJsp3st6bC11oYDzg8kB?=
 =?us-ascii?Q?fje2fqEmmzkNWI9s+6eZ6aes4gyD4A6/SNQIcY6uitPmL4SE0OG3rNNXCtPu?=
 =?us-ascii?Q?ZavWW5Ieac4w2qDnNjKT4HwpPLyNW/tu4AjC8a+AOYYtNR82mttxU+Bvym+s?=
 =?us-ascii?Q?A6bpzqe2T6r9XOB4CJhKjVrwgJn/52856IbtM+zt+n7Wt38RTShM76AkOWru?=
 =?us-ascii?Q?WgQe5chQxUz2SLxWRQCGNlnO9TGnxKnFNtICuBgh75xNCabjv/h5N+k07/lR?=
 =?us-ascii?Q?4LaTD6Qqpq8/QmMuXaFmK8DXTXOidwGKsHt3OOVVBXOowUXhGxSinuBKK6e7?=
 =?us-ascii?Q?v/9eByS0aWGdKmjbe5BuNBxWE4CZ8sr8BcwTkKaup1imd8vVq+c+AkSCOJga?=
 =?us-ascii?Q?km/+eCT5pvocndC8oEouKT/Q+on2g5wTvfhiJOcED4E0eePwXLRq7UXP2mPd?=
 =?us-ascii?Q?shaEPcMyxXCwW4N1zA7lICN1xsueB8PsO9iNuj0H+kh0b4Vos3f76qcKwUyl?=
 =?us-ascii?Q?/NrhfYz/WlvQNEhIEOLneak9P6wI6G/+6kGqJJuDqn+FlzeWr3CTVu8KhqXI?=
 =?us-ascii?Q?/whm1j7k7o6afFSozNJ5zmEuxrfawUrQSG3XRu5GvdlKjrJoklaV1+DkQ+D5?=
 =?us-ascii?Q?NFqDfWpx8CZPFmf2Zs1SixqAorz+pEDml2f/2daGZqIyXBfzzkrawanXfC9e?=
 =?us-ascii?Q?kmy86FXhbbDMl9bG9H3eP2/CIl5r8ay8AZUV+8r6siaZlDsHyDK/50V0rXCu?=
 =?us-ascii?Q?ACAyIt7+5t7Y/hgOyt3ThbHcdNIarh8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d34da-9306-48b2-54e4-08de699a9090
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 18:22:50.7932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6yqU++uVz7daeY3LSG5ZEPwR2tPYb9n74JzCzqVrihoDa3YLs2cSYIca7vGnzX0b5uFh+nyGgLP3sMowYD2d9BJ5P0k4msoBEGONje2QKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8572
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

From: Christian Marangi <ansuelsmth@gmail.com>

Rework the driver to support multiple GDM port. The driver is split to
main driver as a MISC driver with forced probe (by using the
DM_FLAG_PROBE_AFTER_BIND) and each GDM port register a ETH driver.

This permit a 1:1 implementation with the linux kernel driver and permit
to use the same exact DT nodes.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/airoha_eth.c | 150 +++++++++++++++++++++++++++++++++------
 1 file changed, 130 insertions(+), 20 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 3a0ac7ce368..2007642ebae 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -9,6 +9,7 @@
  */
 
 #include <dm.h>
+#include <dm/device-internal.h>
 #include <dm/devres.h>
 #include <dm/lists.h>
 #include <mapmem.h>
@@ -24,7 +25,7 @@
 #include <linux/time.h>
 #include <asm/arch/scu-regmap.h>
 
-#define AIROHA_MAX_NUM_GDM_PORTS	1
+#define AIROHA_MAX_NUM_GDM_PORTS	4
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
 #define AIROHA_MAX_NUM_XSI_RSTS		4
@@ -38,6 +39,8 @@
 #define TX_DSCP_NUM			16
 #define RX_DSCP_NUM			PKTBUFSRX
 
+#define AIROHA_GDM_PORT_STRING_LEN	sizeof("airoha-gdmX")
+
 /* SCU */
 #define SCU_SHARE_FEMEM_SEL		0x958
 
@@ -246,6 +249,21 @@
 #define QDMA_ETH_RXMSG_CRSN_MASK	GENMASK(20, 16)
 #define QDMA_ETH_RXMSG_PPE_ENTRY_MASK	GENMASK(15, 0)
 
+enum {
+	FE_PSE_PORT_CDM1,
+	FE_PSE_PORT_GDM1,
+	FE_PSE_PORT_GDM2,
+	FE_PSE_PORT_GDM3,
+	FE_PSE_PORT_PPE1,
+	FE_PSE_PORT_CDM2,
+	FE_PSE_PORT_CDM3,
+	FE_PSE_PORT_CDM4,
+	FE_PSE_PORT_PPE2,
+	FE_PSE_PORT_GDM4,
+	FE_PSE_PORT_CDM5,
+	FE_PSE_PORT_DROP = 0xf,
+};
+
 struct airoha_qdma_desc {
 	__le32 rsv;
 	__le32 ctrl;
@@ -310,11 +328,14 @@ struct airoha_eth {
 	struct reset_ctl_bulk rsts;
 	struct reset_ctl_bulk xsi_rsts;
 
+	struct airoha_eth_soc_data *soc;
+
 	struct airoha_qdma qdma[AIROHA_MAX_NUM_QDMA];
-	struct airoha_gdm_port *ports[AIROHA_MAX_NUM_GDM_PORTS];
+	char gdm_port_str[AIROHA_MAX_NUM_GDM_PORTS][AIROHA_GDM_PORT_STRING_LEN];
 };
 
 struct airoha_eth_soc_data {
+	u32 version;
 	int num_xsi_rsts;
 	const char * const *xsi_rsts_names;
 	const char *switch_compatible;
@@ -376,6 +397,8 @@ static u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val)
 #define airoha_switch_wr(eth, offset, val)			\
 	airoha_wr((eth)->switch_regs, (offset), (val))
 
+static struct driver airoha_eth_port;
+
 static inline dma_addr_t dma_map_unaligned(void *vaddr, size_t len,
 					   enum dma_data_direction dir)
 {
@@ -397,11 +420,26 @@ static inline void dma_unmap_unaligned(dma_addr_t addr, size_t len,
 	dma_unmap_single(start, end - start, dir);
 }
 
+static int airoha_get_fe_port(struct airoha_gdm_port *port)
+{
+	struct airoha_qdma *qdma = port->qdma;
+	struct airoha_eth *eth = qdma->eth;
+
+	switch (eth->soc->version) {
+	case 0x7523:
+		/* FIXME: GDM1 is the only supported port */
+		return FE_PSE_PORT_GDM1;
+	case 0x7581:
+	default:
+		return port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+	}
+}
+
 static void airoha_fe_maccr_init(struct airoha_eth *eth)
 {
 	int p;
 
-	for (p = 1; p <= ARRAY_SIZE(eth->ports); p++) {
+	for (p = 1; p <= AIROHA_MAX_NUM_GDM_PORTS; p++) {
 		/*
 		 * Disable any kind of CRC drop or offload.
 		 * Enable padding of short TX packets to 60 bytes.
@@ -739,11 +777,35 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 	return 0;
 }
 
+static int airoha_alloc_gdm_port(struct udevice *dev, ofnode node)
+{
+	struct airoha_eth *eth = dev_get_priv(dev);
+	struct udevice *gdm_dev;
+	char *str;
+	int ret;
+	u32 id;
+
+	ret = ofnode_read_u32(node, "reg", &id);
+	if (ret)
+		return ret;
+
+	if (id > AIROHA_MAX_NUM_GDM_PORTS)
+		return -EINVAL;
+
+	str = eth->gdm_port_str[id];
+	snprintf(str, AIROHA_GDM_PORT_STRING_LEN,
+		 "airoha-gdm%d", id);
+
+	return device_bind_with_driver_data(dev, &airoha_eth_port, str,
+					    (ulong)eth, node, &gdm_dev);
+}
+
 static int airoha_eth_probe(struct udevice *dev)
 {
 	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
 	struct airoha_eth *eth = dev_get_priv(dev);
 	struct regmap *scu_regmap;
+	ofnode node;
 	int i, ret;
 
 	scu_regmap = airoha_get_scu_regmap();
@@ -756,6 +818,8 @@ static int airoha_eth_probe(struct udevice *dev)
 	 */
 	regmap_write(scu_regmap, SCU_SHARE_FEMEM_SEL, 0x0);
 
+	eth->soc = data;
+
 	eth->fe_regs = dev_remap_addr_name(dev, "fe");
 	if (!eth->fe_regs)
 		return -ENOMEM;
@@ -795,13 +859,42 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
+		if (!ofnode_device_is_compatible(node, "airoha,eth-mac"))
+			continue;
+
+		if (!ofnode_is_enabled(node))
+			continue;
+
+		ret = airoha_alloc_gdm_port(dev, node);
+		if (ret)
+			return ret;
+	}
+
 	return airoha_switch_init(dev, eth);
 }
 
+static int airoha_eth_port_of_to_plat(struct udevice *dev)
+{
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+
+	return dev_read_u32(dev, "reg", &port->id);
+}
+
+static int airoha_eth_port_probe(struct udevice *dev)
+{
+	struct airoha_eth *eth = (void *)dev_get_driver_data(dev);
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+
+	port->qdma = &eth->qdma[0];
+
+	return 0;
+}
+
 static int airoha_eth_init(struct udevice *dev)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_queue *q;
 	int qid;
 
@@ -819,8 +912,8 @@ static int airoha_eth_init(struct udevice *dev)
 
 static void airoha_eth_stop(struct udevice *dev)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 
 	airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 			  GLOBAL_CFG_TX_DMA_EN_MASK |
@@ -829,8 +922,8 @@ static void airoha_eth_stop(struct udevice *dev)
 
 static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_qdma_desc *desc;
 	struct airoha_queue *q;
 	dma_addr_t dma_addr;
@@ -852,7 +945,7 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 	desc = &q->desc[q->head];
 	index = (q->head + 1) % q->ndesc;
 
-	fport = 1;
+	fport = airoha_get_fe_port(port);
 
 	msg0 = 0;
 	msg1 = FIELD_PREP(QDMA_ETH_TXMSG_FPORT_MASK, fport) |
@@ -894,8 +987,8 @@ static int airoha_eth_send(struct udevice *dev, void *packet, int length)
 
 static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_qdma_desc *desc;
 	struct airoha_queue *q;
 	u16 length;
@@ -922,8 +1015,8 @@ static int airoha_eth_recv(struct udevice *dev, int flags, uchar **packetp)
 
 static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 {
-	struct airoha_eth *eth = dev_get_priv(dev);
-	struct airoha_qdma *qdma = &eth->qdma[0];
+	struct airoha_gdm_port *port = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	struct airoha_queue *q;
 	int qid;
 
@@ -964,8 +1057,9 @@ static int arht_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 static int arht_eth_write_hwaddr(struct udevice *dev)
 {
+	struct airoha_gdm_port *port = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
-	struct airoha_eth *eth = dev_get_priv(dev);
+	struct airoha_qdma *qdma = port->qdma;
 	unsigned char *mac = pdata->enetaddr;
 	u32 macaddr_lsb, macaddr_msb;
 
@@ -977,8 +1071,8 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 		      FIELD_PREP(SMACCR1_MAC0, mac[0]);
 
 	/* Set MAC for Switch */
-	airoha_switch_wr(eth, SWITCH_SMACCR0, macaddr_lsb);
-	airoha_switch_wr(eth, SWITCH_SMACCR1, macaddr_msb);
+	airoha_switch_wr(qdma->eth, SWITCH_SMACCR0, macaddr_lsb);
+	airoha_switch_wr(qdma->eth, SWITCH_SMACCR1, macaddr_msb);
 
 	return 0;
 }
@@ -990,6 +1084,12 @@ static int airoha_eth_bind(struct udevice *dev)
 	struct udevice *mdio_dev;
 	int ret = 0;
 
+	/*
+	 * Force Probe as we set the Main ETH driver as misc
+	 * to register multiple eth port for each GDM
+	 */
+	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
+
 	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
 		return 0;
 
@@ -1015,12 +1115,14 @@ static int airoha_eth_bind(struct udevice *dev)
 }
 
 static const struct airoha_eth_soc_data en7523_data = {
+	.version = 0x7523,
 	.xsi_rsts_names = en7523_xsi_rsts_names,
 	.num_xsi_rsts = ARRAY_SIZE(en7523_xsi_rsts_names),
 	.switch_compatible = "airoha,en7523-switch",
 };
 
 static const struct airoha_eth_soc_data en7581_data = {
+	.version = 0x7581,
 	.xsi_rsts_names = en7581_xsi_rsts_names,
 	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
 	.switch_compatible = "airoha,en7581-switch",
@@ -1045,13 +1147,21 @@ static const struct eth_ops airoha_eth_ops = {
 	.write_hwaddr = arht_eth_write_hwaddr,
 };
 
+static struct driver airoha_eth_port = {
+	.name = "airoha-eth-port",
+	.id = UCLASS_ETH,
+	.of_to_plat = airoha_eth_port_of_to_plat,
+	.probe = airoha_eth_port_probe,
+	.ops = &airoha_eth_ops,
+	.priv_auto = sizeof(struct airoha_gdm_port),
+	.plat_auto = sizeof(struct eth_pdata),
+};
+
 U_BOOT_DRIVER(airoha_eth) = {
 	.name = "airoha-eth",
-	.id = UCLASS_ETH,
+	.id = UCLASS_MISC,
 	.of_match = airoha_eth_ids,
 	.probe = airoha_eth_probe,
 	.bind = airoha_eth_bind,
-	.ops = &airoha_eth_ops,
 	.priv_auto = sizeof(struct airoha_eth),
-	.plat_auto = sizeof(struct eth_pdata),
 };
-- 
2.51.0

