Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C6FE68176
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6655283D8A;
	Tue, 17 Feb 2026 12:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="HmM0nk9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B0983AA9; Tue, 17 Feb 2026 12:53:42 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33B483C32
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:53:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJzuTgWHsy50pp3oipS8VED7aAsljCRcpFAYfSS2voXxPWnRz7YrW3gDIcgpTl8bAwD9VwiCbeARi78VmVYBTA4291/QvZRlO56pRIT/mMFibSd7kMGb3xVVKqbwHkDLfevpPgEYbspufYfP3yQVrOP+nI31+pzWWr1EnzRyB9dn/A45amkiveWOMgRoQkUBfo2pP8iRUXYrMWFGLiJl+PeIOO9xrpzNG7O55uDDKRfMTl56ug2bXBhqhlJERx9fLXqVyJnR3YT40TVX18DSZIX/6rB/DbykPnziYXLjbEKidRjev3k1SUidrGZhiXMkdWFN5MRM0MmkXd7gtH+QOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBwweOlCpZeftZbJuccgdi/1Nkjf80tmWb05ojhdlNM=;
 b=lQ50SC5n3SdOaKvcGLau087w6CKXV1dYY7WAvJYky7KWEF0SS1SShCVmqb1fw1RVYzhkNq7dxevhHevjIUUZqgB4GP1q/dBBqnIOnPa6vldTQo3oOUUugjY5LjeSerdvd1MDa7o1skPEQDr5vPo/0I/wI20xkSezyzxT6AdNur0JygTBV3zTM7cAf4hdr7kZ4D8ZPhMzA10tfzDsU0ab8nuP62JIT2daY1zvf7sBHvrshuVs0XVT6wZ7JE5mSqcHGrqfp402uZnuNt48gtKKYEvjqlg5TqXm/4VggqXng4WHFLBp3VpaEufCrl9GnrCsIYGueAp+59BueD/hg/KFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBwweOlCpZeftZbJuccgdi/1Nkjf80tmWb05ojhdlNM=;
 b=HmM0nk9tWY7Fd2LTMbJKrtjph9dTiiySg2b6uBLywvQ9FvWP62Hw9qE8sUo+ivmMaHSOxQ+461f6EbcO9639veYbkflevS4b6WFgVw5TsoKOYz4YN/lP3Bc0wRIZBKfgCo3Puq18PfUSrsv6PtogeHC2Y2rzZzb41D6Qmo7mQF+BphA+pgjWShUr+rgffHReRrvKHbVRlH0iQPFN6G2TJGo5SQNrfAwBialpts2Dk8gfyv3dHiA48bvyCz644tyMAdK3As+7LrYQnEmfh11rz2pgVF+wQoa7wt/ePa9y11qenSjQkUufB4FWpwpQzxj7sFhsC00qDwP3Xg8bfF0v1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB6761.eurprd03.prod.outlook.com (2603:10a6:10:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 11:53:37 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Tue, 17 Feb 2026
 11:53:37 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v6 1/6] tools: mkeficapsule: Add support for pkcs11
Date: Tue, 17 Feb 2026 12:53:27 +0100
Message-ID: <20260217115333.503359-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
References: <20260217115333.503359-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::13) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad36f1b-795a-45ef-f67a-08de6e1b2f4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dJBQTp0MotqMIM7N+e4AWw+2sIVhMtvY4pffEdTrdctFJMiqnuof0Y0qAYWs?=
 =?us-ascii?Q?4v3vdYdsOCbYO9A4ap6eUUMK0Fp9DIqx3K+2eFa+hiz3sKodR0KD/+5LPmSD?=
 =?us-ascii?Q?e/iPphT5k68jPmrBwUrcuRPCGkB9gAEjQQNSZsj7oyNyg5HiIolnILcgvrNK?=
 =?us-ascii?Q?qfTG9ZZGz2Df7ORlQnjG/JKID94YdL2FEJ6MAwg/4AJCtKuMBVpfFcWhAFi7?=
 =?us-ascii?Q?hbTPP73V50DPpys1kUob7clLgpfA/mwNnuj4EpE9kwJFLisIKSf6jSJzq0vh?=
 =?us-ascii?Q?IX6PKFNcOAgnsP5sFQ3thv0l42o5RRYvVEJH76V4F5gy8lTUttp756Y8onpB?=
 =?us-ascii?Q?ysG9QWhheYdZ/S+GXI4u/a2h1o7AQ+x0SZgbWWwT/avCWmbf3TJBZ3Osm3GQ?=
 =?us-ascii?Q?ck0V0MKaNTfH2l19O+PHEVvjx3sp7I7L/57SnMY+NQARiL0UoHr3FuyviEpE?=
 =?us-ascii?Q?Ro2VtNi6Olo7vHemkYTjyeH53+V7NpjHYKlR2AuHfPxBRFVR72hGkKnlTIRE?=
 =?us-ascii?Q?6xbYvmo4gZaFnmJVJM3qglFcsJCycmDkgf8eoomlTk37FpapK3EOC6aqVjX/?=
 =?us-ascii?Q?GmKoVjHJYpeErie9h3qbDfqVtXx7GT/cS5Y/CrTkAgRT04w6v4FbebfFilcE?=
 =?us-ascii?Q?vDqi8kjlql6FcdwaMMGSFClzzYVYIAT/fP98uzCDPul4jPz867aKRQJ36CiN?=
 =?us-ascii?Q?XCgIXC5MOpBvFo13pQJhzI4XvIKJBLU/kif1AxxXGGgNNtOiJ0PdBy4eLtcH?=
 =?us-ascii?Q?fCmlO4a1+2ZNw4VVEPjv1Ae4ZEBdmlavQe/EicTpaUvwD4sz0uw28PMVcIyg?=
 =?us-ascii?Q?NUFR0l79S8960DhwvhrvM7N76X41NyEvEP/gSE2BrnyzN4YkoeQwRPQomFOz?=
 =?us-ascii?Q?nO1YV5agNQDZl59qj0RgqViRsujvwK4w+6PV2vkMcIv9D5PwIocgrR3TcZSv?=
 =?us-ascii?Q?EvLxfNYkKr+reagcz7owLd4Hv+xQrpj4Ecx6/9W17xi9d0n2a6grIC2BR1iJ?=
 =?us-ascii?Q?DoDwV/hfQgQ0WlzrTT62r8QNvxeRH4k5vHR4z6OP3U/uUkXjjE1JKShMNqgc?=
 =?us-ascii?Q?xLyPjumnYnVdykU8nIAiJK+3Oen04hwQMZtztcqfIm/8cxdaRS56pn36Mygl?=
 =?us-ascii?Q?aOO6FlhcJkqhc2kg4iGuM2ik0287Xvtk4jB1aaG+XscoDsWlOwk447KT1Hac?=
 =?us-ascii?Q?Ufz/fRfdIsTNGKUZmfHCW16qt8Pw86btztLkoCtEZXXYXeyKlLZb0YfGJYio?=
 =?us-ascii?Q?TNsYSPbQG41WRt5m0ZzZ8Gm45A7sNvlYOw0VbNX7Dvcp46pVGnT0n8U5MWeW?=
 =?us-ascii?Q?+BKNbQ9eUpxD1lUESO8YgUqa65KQ/KsHb6/PbLv40MQP7/3a4bIKxC7nAxo6?=
 =?us-ascii?Q?4345LBS+NG+XcvX6/9flWwd18G9HwZ8RT9RRkg6+GdSXBT47uQOoHeTmNSUI?=
 =?us-ascii?Q?ilc19MCJX7xYOpTZ9xNkPQbm4kwhOB7ptl3iWrJttrP7GgA0LgVlAcDKA8mX?=
 =?us-ascii?Q?ykEJI4sKvIL87OGgwa7yCqV3jyZ4uH7aM9cOjr1B9v5RfdKntvw2T45SZ+rE?=
 =?us-ascii?Q?kPnVClelw8XaURyNylRyOL4NIIgHizaxCsqkCcnJC/qORKDoD1nKbSRa43ss?=
 =?us-ascii?Q?0ZDDLLNb3lmS35r0LR2ubU0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hRSxhp4BOXrwNyl5zzLnKcwWj2jQ7tCnVIH2EKz4r6ncuhs6TBl/FuQgXVqz?=
 =?us-ascii?Q?rlKuvz59mpbYJrfU63nfKAoZEyI3Ytwy/v6wPxonI2REKe71NCvDZ4NYnqBQ?=
 =?us-ascii?Q?aAMFjVf8boOb4lY95Y2j/k2ISVtGqzA6LxrlVGQnRI4JkIEYBqWNuD/JRSkx?=
 =?us-ascii?Q?HHDCqb+t1fsDrUcOaI0KUu3QqpQY4EQhmHkzo1gqy5F8VIMmdHskgtvxpIOR?=
 =?us-ascii?Q?qY3Ol1EMylxx6HfeDnkKQFvaK3LEW2YS02W/OiuqsSGKUks3Z1Bvg4Uw9eOn?=
 =?us-ascii?Q?TI/21ER0rymKFrrc1tYsnyUtSzhHP8zJc+k+mE27BULD4q0BQGXE4y+gDl7h?=
 =?us-ascii?Q?dtQAOkk9sOqFe8kDZHWaa3XzVtfTwnCmOamXV3BFvmAD8OFIuqt9nV4ic3+U?=
 =?us-ascii?Q?7N3zHfdhOqR19yQVPkxaHVh2VjEjKrPt4jSz3GOPpDeKMo8Jh0Wb3wP1+GTv?=
 =?us-ascii?Q?pnHRerch+HEaxyPHNUBDk6AFf07UA3tUZ6t7UEfBAhGP9cvpDsBFf6FXgJpI?=
 =?us-ascii?Q?Zoelt3OF3SFNjUt0YuQZbEqWmhlJeM5FYp7j1hZWh9aKbfK3U7E3PBttdrk3?=
 =?us-ascii?Q?Wk/LfAdyOo4vMQ4+de1FF2rjU4ZhmVtkY2+UuxEEt2s+YAB9ps6Qh7sgKjTI?=
 =?us-ascii?Q?NjKTFHOx5fMkR5biyr6J2fd9Wgs2EiarzHL8TH2F/AWVuk6hSvekquylopLO?=
 =?us-ascii?Q?cvPLV9hFi9D75qutybq1kQOwNuiJKR/swGptZSZ2X9GGlyVQJXeV8WP5D4Gz?=
 =?us-ascii?Q?S+ufKpxmYkjXcNtHQ7Ac15NPX5eHoXCJpHZxthSMfyqeYzCxgizPDhLnns8i?=
 =?us-ascii?Q?ySVXGVYiQPeCsep/I2wRSAwGubi54WCr/ILx5llU/Cmk8Uxh2lByFKznu4Op?=
 =?us-ascii?Q?nnLOcBhYO3TuslVyelRQXCpmhEZkVk5jv6BtXxQZlgnuLW+nK+vGgsySGBU0?=
 =?us-ascii?Q?PRMaRerAHS4Kp8pfptvAENGnQ7mjXDjp6FO0VJitmumFxon2be7MzdcnEpz1?=
 =?us-ascii?Q?tfQh2YiHQbveMBYRSWY02rXX8C6EJ1mglG3LM62PUUkv6sk7fNrFUFjfsOmK?=
 =?us-ascii?Q?9iCIaXBtyNNF6zS6tM1jrdG9WMiNLWCghensiS7h+JbD6sYaIxMmeyu0vKvg?=
 =?us-ascii?Q?ATAu4k1Ysji0N3y5FGCdfTBTVSmx2AUiizNZmHRKDfg/KmpGD66elnJMs5l5?=
 =?us-ascii?Q?kz5GRwNsRxe4Nih8lOuHOiJO08lwoS1BcfvumqfaA16fLRzHswGdHYxQ0Lss?=
 =?us-ascii?Q?oSIxHh87JZoujoe9Ws8iYvH6t3OmoiPTxLKHUO02cldu97hrr8SMfpWsiLzP?=
 =?us-ascii?Q?obqYrPe6umw+AlYyKqDPh52hJ/zZphQHqVOjwsnF5jp8eksfkIiiRWuH7xov?=
 =?us-ascii?Q?b23Fz2MrNew0bbvOVGubOwWQOM+F+GyOWCsI03kpYP6IcyyT/nxNOkrFYldg?=
 =?us-ascii?Q?utfJhSpLvO6mQEdA5Tkv2rU+fbyy7tCZaHP0CWgkoXK0w52Mp2DvYcb+uVKm?=
 =?us-ascii?Q?/OqbDIvxtN2V9ZcrdFYv1hSFoSqufQ41QyZkVEecTf00aSVm9Szpi2SAVhmv?=
 =?us-ascii?Q?uNSDXQKr6M8cq0WM8ukL7e0WX3t3SgpsaD6CicFDPZ4RnW5Ms/opIFHXMZMd?=
 =?us-ascii?Q?QzKTnx1+9naFDlflHTwfUrSCEH5sBr+WlixtRZ1vGpER1mravHXCA9u1Lc71?=
 =?us-ascii?Q?M7USyl+OGmWhOT2zq5WEiv1OFRrSuFf1Fb3wGx/2qLFbsn7ZU0ges6oXtoEx?=
 =?us-ascii?Q?XfsnIccm2w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad36f1b-795a-45ef-f67a-08de6e1b2f4b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:53:37.0683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPyyRf6k6ZaF0emcBC/RDkuXt5MgSTyjQbMZs/i9yBzDf51ggs0do60hc9T0Slx7AnMNJYoUFDtnqiOQ2zqUpQ==
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

With pkcs11 support it's now possible to specify keys
with URI format. To use this feature the filename must
begin "pkcs11:.." and have valid URI pointing to certificate
and private key in HSM.

The environment variable PKCS11_MODULE_PATH must point to the
right pkcs11 provider i.e. with softhsm:
export PKCS11_MODULE_PATH=<path>/libsofthsm2.so

Example command line:
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap"

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 tools/mkeficapsule.c | 110 +++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 26 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 0f41cdb64f54..a0ee76295a1a 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -228,21 +228,54 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
+	gnutls_pkcs11_obj_t *obj_list;
+	unsigned int obj_list_size = 0;
+	const char *lib;
 	int ret;
+	bool pkcs11_cert = false;
+	bool pkcs11_key = false;
 
-	ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
-	if (ret < 0)
-		return -1;
-	if (file_size > UINT_MAX)
-		return -1;
-	cert.size = file_size;
+	if (!strncmp(ctx->cert_file, "pkcs11:", strlen("pkcs11:")))
+		pkcs11_cert = true;
 
-	ret = read_bin_file(ctx->key_file, &key.data, &file_size);
-	if (ret < 0)
-		return -1;
-	if (file_size > UINT_MAX)
-		return -1;
-	key.size = file_size;
+	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
+		pkcs11_key = true;
+
+	if (pkcs11_cert || pkcs11_key) {
+		lib = getenv("PKCS11_MODULE_PATH");
+		if (!lib) {
+			fprintf(stdout,
+				"PKCS11_MODULE_PATH not set in the environment\n");
+			return -1;
+		}
+
+		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
+		gnutls_global_init();
+
+		ret = gnutls_pkcs11_add_provider(lib, "trusted");
+		if (ret < 0) {
+			fprintf(stdout, "Failed to add pkcs11 provider\n");
+			return -1;
+		}
+	}
+
+	if (!pkcs11_cert) {
+		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
+		if (ret < 0)
+			return -1;
+		if (file_size > UINT_MAX)
+			return -1;
+		cert.size = file_size;
+	}
+
+	if (!pkcs11_key) {
+		ret = read_bin_file(ctx->key_file, &key.data, &file_size);
+		if (ret < 0)
+			return -1;
+		if (file_size > UINT_MAX)
+			return -1;
+		key.size = file_size;
+	}
 
 	/*
 	 * For debugging,
@@ -265,22 +298,42 @@ static int create_auth_data(struct auth_context *ctx)
 		return -1;
 	}
 
-	/* load a private key */
-	ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
-					     0, 0);
-	if (ret < 0) {
-		fprintf(stderr,
-			"error in gnutls_privkey_import_x509_raw(): %s\n",
-			gnutls_strerror(ret));
-		return -1;
+	/* load x509 certificate */
+	if (pkcs11_cert) {
+		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
+							 ctx->cert_file, 0);
+		if (ret < 0 || obj_list_size == 0) {
+			fprintf(stdout, "Failed to import crt_file URI objects\n");
+			return -1;
+		}
+
+		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
+	} else {
+		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
+		if (ret < 0) {
+			fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
+				gnutls_strerror(ret));
+			return -1;
+		}
 	}
 
-	/* load x509 certificate */
-	ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
-	if (ret < 0) {
-		fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
-			gnutls_strerror(ret));
-		return -1;
+	/* load a private key */
+	if (pkcs11_key) {
+		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
+		if (ret < 0) {
+			fprintf(stderr, "error in %d: %s\n", __LINE__,
+				gnutls_strerror(ret));
+			return -1;
+		}
+	} else {
+		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
+						     0, 0);
+		if (ret < 0) {
+			fprintf(stderr,
+				"error in gnutls_privkey_import_x509_raw(): %s\n",
+				gnutls_strerror(ret));
+			return -1;
+		}
 	}
 
 	/* generate a PKCS #7 structure */
@@ -349,6 +402,11 @@ static int create_auth_data(struct auth_context *ctx)
 	 *   gnutls_free(signature.data);
 	 */
 
+	if (pkcs11_cert || pkcs11_key) {
+		gnutls_global_deinit();
+		gnutls_pkcs11_deinit();
+	}
+
 	return 0;
 }
 
-- 
2.47.3

