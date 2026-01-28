Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEA4D35687
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 08:05:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0448423D;
	Wed, 28 Jan 2026 09:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="A1HSY5Ls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E18D5842AB; Wed, 28 Jan 2026 09:05:32 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53F6B84277
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAfyfJxsdJaahLwyaDNRC05GzMBSkE8GwBFjYCKQxdR2Qy0mcmd/n/vKhzC1kVxybxIUUmPLmkts52maukKT0J1JH0gKol4NCKfmYP3wm2iUTK4yw1KWJ1cu4QFR4tV9Pkyb03+0678WSgfFxpTiVBVG7kcdPo+ixZUIvqFv0nIGez3P2/UE+SvDx0JDIeoWNZq8uw3Z+cUARE3OmglKCb8Twl3PSpdNfyad52dPcLhvGmFbWPfijD6CnwvTewIFDzHQWwWkNkrUzcVzr2kBtAjfIFHs6fL23f3SLbthXNg+ldc6V5tO13Aa0LFvbGlfysIqe9mJDl+m50BE4XMe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=yBxgVX88ZQ4YEX/VSWvhEUCDGAVt9jweLEOgejPNC0BydxIc9RohTAcw8lBUJ/G7C5xjSfo5rNqsZdGKySOC9iRU75C2l/x/iazQBa9f+w82v5NDnfLPaFrPrhv+Hi4L78otCnI/m2g3sNxyNUSliAi5B+C5CYoVS48Div1s5hmnkRQoTJFbULDYZGJ+4rTAiinbX3qkX6I0N837CQvk2GCA0bSI8eusxBXpOCYHUu6wRMKcfp2b2BMu6522F4zFs145fY9QIvnuyXdqdQ/T+M/0lVLw5uHYeeDvKpUbj1yBsxtf4wznks0czQ9RuAJTN25USYifUQrcLHvWKvra0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=A1HSY5LslEHfz1cxiToxLyBxH0Fr/C4855M+xk35zZH+bVzqVDT9muHqmffBkVU9KH9AxwToG9TNeVaNg4IQNnCuhw24awKkSN40ly/6ezUtgPfksemNH6o9B4ZNrvo1s/FTs3qviwEWnQH5DIUpoJPbUcfXpzz50DClYTQwCn4z4i9rFrUfgM4r93qHc6rHQ7WNI1s0f9x17HvMP2Lz6A+y6GB2d6PyKXBjgkdJ4pW48CxAnqXJndLvS9gHwHd99U9R7K46sVcJrxXT+Z7LhiQ2OcwJTzPc3sSDMPkYsVdlPm7PicJFZUOG5fQ1Ot9iNhT4Nv7DPwSmVBNSh/8uLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DU4PR03MB10912.eurprd03.prod.outlook.com (2603:10a6:10:581::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 08:05:26 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 08:05:26 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v5 1/6] tools: mkeficapsule: Add support for pkcs11
Date: Wed, 28 Jan 2026 09:05:08 +0100
Message-ID: <20260128080515.1275941-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0011.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::21) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DU4PR03MB10912:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b40dcb-104f-4b36-a622-08de5e43feaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V5UwyI8k7ytu9EMXE8IXZybnUvwJrtFJ3R8+2Hge97tW/UchdfD/qQrDvknM?=
 =?us-ascii?Q?m8xI2jWUrQgp8/FCcD+ndHOh9fIkcQikLRIpMwG9Yctf5YxfnmuRX6uzsuPo?=
 =?us-ascii?Q?gkNPn3FEbCUkUhy7UV/kKvvG4kryktid2psDcax70fVGvaO6dlph+XcR7qfc?=
 =?us-ascii?Q?CYsLcK0p5h0ifx88Ct1iJNdJaWUTup3ImWFCgPMNoiuftl0pzHazxbwGtUZv?=
 =?us-ascii?Q?PTkJIod1mm4XGj75/vebHmz71P0w2pD+70bwaNy6EmCrNEHQdYuODc+8xhzb?=
 =?us-ascii?Q?hrF40fjuugzMZFY2v9WGR8rSgMYVNQY1w67OSngiQ4/B01pBsHjXx9WTVLUl?=
 =?us-ascii?Q?FPbX98XEi4SUbA8y7/yP39CZx9gSS19GDdGbZ5NLR//fTc5zokD53RGBQ7LZ?=
 =?us-ascii?Q?WEUBVTcaBtBaOoYNbSWH+7n83ix0xNjweexTrbgct1q42QAZmiGaFSHpJmsY?=
 =?us-ascii?Q?lBSCGfGSpbdyLvYqpr9k/D1BSf6fCU/xElzcrZ18Z7PbI7AeJVWP6rHKXvyi?=
 =?us-ascii?Q?AGMTSH/DIDMQVg/4WRFxmG2Cr4s6g1xaNnfHxKTAwmJK5lI0oSOT13gmYn9q?=
 =?us-ascii?Q?JG+XuxtJ82ZB20b/lhjeq2LBwEHGuBNgBCdEJttRhqdYEwDRb/jPQG2zPpGG?=
 =?us-ascii?Q?xTVoofkFgvDiSlEiEBlxrKg3ZMhZrxm40RoAgBDYET4+fC/EtesWm3XH6elu?=
 =?us-ascii?Q?FU9YfXR/Ofj4bm9gDZharfBUMVbq4MJUMZdR16A/0BGQbA/+wNVZEaeeECC1?=
 =?us-ascii?Q?LQigGJaCIldTDAT2mAdEtU1l+KHLF4+XqbYGZlMJbjhBfqQtBZGASKp2qVBy?=
 =?us-ascii?Q?wYrb4UiS8C3it0Bn1lJRw/wCikhsU4HlqTZiZ6oRLRKvKh8usPMGZri679XB?=
 =?us-ascii?Q?YDmLLPtB/A57j4rNZC4nL6Jp4Hfajch+SZwREYhyM0CH1j/YTdQicAM+3sBa?=
 =?us-ascii?Q?6H6ZaYt87vhibwZ9X16U7vQqJ5wX3dVXNmMPCqmO4uHMsojpwbPIC8BpgDrw?=
 =?us-ascii?Q?VQfZtr1GrgNazbIGNU6GJVW/S142R8w0LgfHRH0XxfPZ1WGlC+tAeWNdCaYG?=
 =?us-ascii?Q?854jvMCerSPKMOgXtpxZamRmj2dkonIGnQrMGTFsavyezedsVhTBQ11XmNAJ?=
 =?us-ascii?Q?5tL5MS4Uv9PECJIF8IAJlKolh+vQ49kaOW6D/qJ7PPwRR6q7jA1KPzygDd82?=
 =?us-ascii?Q?xOfrHtXIH6u4NvPtv4W975T/PhNJ5F+vo1cHgozjGQxWMgXyEapjOE/cZ8vO?=
 =?us-ascii?Q?Uy16619Mo6EMuqnQvfs6N1icAkOi1gCZ3ld47fg3bTrftspdnlwpHOwAdH1h?=
 =?us-ascii?Q?5Dk0vdAaEVwQggts3Lw25EEahllD5ZngQ1z2YmMw44E+U6Y9r0m/1EtLYmBR?=
 =?us-ascii?Q?LqAp1CgLH6H+T7Ssl12dsorInPUvyi61YY6QmwJpZlx6GlceCWucYTqFCu5P?=
 =?us-ascii?Q?x/l9CVXz8MOi8d0iXnrxnPZ484uqFcVbFa41ojACfnULKFSwfcANGfzYKF7j?=
 =?us-ascii?Q?NtMUO2xpBS+kCSXJ+A98mYbHEnaUANC10VMN4nXr2Mp9JK5hu22Hqlyd1gar?=
 =?us-ascii?Q?PCsFzJ/fEQ5ErRmZGI1ywilCtZp0N7Y5mJuQ60Y8AsEP5Vf4fiKV5tgo41F8?=
 =?us-ascii?Q?HQFhLDFZWzaMpj2x7LjwNwo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEAYDaXL4/C88K6coN8yOVdLhgYPzH+mq4RBSHuhKzOmnaXNCOVblHrWkS7u?=
 =?us-ascii?Q?kwiIMvxTfBKsXzKl/uYaOvZHMQmTe8vTKRxBfbrf9TwJ2j7dVCpt+Bjbb47h?=
 =?us-ascii?Q?27wWR3XBJGQ4jA5mKvu+5dIexDfhEny9xuHtA44t4ABvhP4USKWqyBHe5iMU?=
 =?us-ascii?Q?bYvFEhYcmqZXkQpc1Ljq492kiUkDwznmc5dhQoCZ3cxzQ2DJrEGThazgXEA3?=
 =?us-ascii?Q?WG/l2DIX5MuY4fdxni7eeh1ArxYIDdZrUIOaHOUD81/pIvulC+l/JAF+On2M?=
 =?us-ascii?Q?NVzy6jUoEBUOI4Z0mIhlkA51yIdl+UHbBr0LIDm4CkY2A0ith2xowl16kFvE?=
 =?us-ascii?Q?Sjf4Z1WuwUC2QA6aA8CiEgXRBmUvvfUoEWHTvr6mZKIWRn6W3oqNGco7f3t6?=
 =?us-ascii?Q?Oo6HDRWwLVq/VEeOpRSo6s308w5utRGoVn/CStqYWAOXo8yWmoMfD4hboJl5?=
 =?us-ascii?Q?VsJF3jOjYxhwOWqJxQHmhgf46KKH/FoHIsfHq0gPO35TVBNLG7FaT/sykZx/?=
 =?us-ascii?Q?PWzjwGkx8yyoj+ion7T919vNAt6h6OYxNZjsIcg1u2/9pHGEsRqVsUxVmiPC?=
 =?us-ascii?Q?RrVQi8lyTRXfMMQzfl31Ha/kI6teAQJHFyQAmDyPYBqFYCYqmhOXKBNKXEXj?=
 =?us-ascii?Q?1gBmSnWaG9dSpEIm6gqRV0XmBCXlr4rCDgVggGgQWWbMpZKMdQ8PyusYvqxt?=
 =?us-ascii?Q?/4b72m4aepzTwMsI4Kks2WrEigwLtJNkH6rl6nTu1kEZhGpDJPIkpVC7CxH4?=
 =?us-ascii?Q?uJhYXEQ7ukzX2B6YDJgq+P0DswslT4GrxvI+XUDVwE0GpT4cA6IOAjaM0wVx?=
 =?us-ascii?Q?YXqrZ6KajX5lxGX6hBX4WilspZWun+F3xEXkT0fjjm5WfNsWQfDtaMCWIymm?=
 =?us-ascii?Q?1164QTV6T7+SL3xvJpOILi2mOA3mdf7PY3H51emc5/LS+JLNqxXbAv41BbIM?=
 =?us-ascii?Q?ukyOaILkVAaKots+4ITTlwNN3JFIlUvIDX6TpKPJPnW2HzSYtyJ2diERJzlU?=
 =?us-ascii?Q?Cww547NRVyvsTPtHr+YxSAWwj5ZBqaimeEEUhMfzawvz47T+PdSEXJNwNPYJ?=
 =?us-ascii?Q?UF70jz3ufIlIt5kcMVtyxNBkoFKxb9poSXtBmmjIRh9L5B6ydLUMZFFwIWM4?=
 =?us-ascii?Q?CBhzLVRnTiM9jR2A8+JoyHUYVAs4oQp25ZBK5LKQTXOPc9kHYgg6Eyl0Y2u1?=
 =?us-ascii?Q?KaQaGqn0zqFLD55LXgTv7oLrXVx3uKaBKPpWYRzi1DcrgYL4NFZOCyiBuVhG?=
 =?us-ascii?Q?EMeeQOG6yr62n+XEVvlhoqmr4Viwfa8iueYiZAIPd/X51kP4b6VdBXdI015E?=
 =?us-ascii?Q?uXfY+1mpRwqLkwxXrLqHsLHK2HhRV6SKtqaxQ1AoREtdFTEqY8WU+rxeBwus?=
 =?us-ascii?Q?mTTMLdWhlGA8lKGMpQ+g0PUmcATkjjPfFl3Jwg+tgJwzDh/2HEo17CvDXS8B?=
 =?us-ascii?Q?pNmhB9B5Hj+W+Xp2on2Zt+bIYz8i+mPyGhdcBRsqJuVelirR5Pr0HpjMfSJu?=
 =?us-ascii?Q?BQXJUssf5k+1fBwDx/MyxECX4+dU+7uN5B+YcsmX/34bb9cBlvhjdkLH9lCd?=
 =?us-ascii?Q?RVNFdeBQynfvrZwGrYifpZnRTFqjKlcCYjJMc+gdLvdcCHxlJdwVJY31+sUr?=
 =?us-ascii?Q?xKoKP0yKGK7AuV0ptFnIWWTbLUKJN9xP1GSi9Wd+jhSDR4ucvemmatORwDUD?=
 =?us-ascii?Q?zmvlWUn2pGegAWy3DJmqZBGg/PKCLFTHq0d3F227uW+0rmEV0wTaIL+k7Jpf?=
 =?us-ascii?Q?8vOMWKzYZw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b40dcb-104f-4b36-a622-08de5e43feaa
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:05:26.2625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rR6KwTBHMn3OljboMpufn4aXq7l/aUEZsOJTVWqlXw5iBwX8/oFuvKLW34rDog3o68dCGnMwedbnR79fckIzcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR03MB10912
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
---
 tools/mkeficapsule.c | 110 +++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 26 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 0f41cdb64f54..a61557b73bef 100644
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
+	if (!strncmp(ctx->cert_file, "pkcs11:", 7))
+		pkcs11_cert = true;
 
-	ret = read_bin_file(ctx->key_file, &key.data, &file_size);
-	if (ret < 0)
-		return -1;
-	if (file_size > UINT_MAX)
-		return -1;
-	key.size = file_size;
+	if (!strncmp(ctx->key_file, "pkcs11:", 7))
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

