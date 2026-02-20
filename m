Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B1CC53200
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEFE383E81;
	Fri, 20 Feb 2026 10:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="CziWcOwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51D083AC5; Fri, 20 Feb 2026 10:15:26 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E7483E76
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:15:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A86QiZgUFhod++NLIYKTFBcTAXqvm8ULxoQV2UF/eZx3hdZJ28CBwUKfFeWxoDzEVCBWEBXLeeMPPd2FZOcTVRtcbZ0JEx2PjtpsqanE9kQJiTuJR1pb4bwJj90sxaA1xkipPDh6YoCShRi/erppPmYnjaUSpk+dXCE44er8HTZ3zAy8dV58aMl0OdE7ySC68uDGYxiD80oXuJNKCug1DWg9Mqif/RKw8w4/FD6K+ukFR0bpkVWoriKljxww9LynwJJKPcK+xNtzsxzzvFYUfzjLxgGuwiscR9wrxhw0EqAKZ3GmTkzuKIZ5JtLPk2AeZbGzQCnsW09xpp8XLk7Iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBwweOlCpZeftZbJuccgdi/1Nkjf80tmWb05ojhdlNM=;
 b=eyLFFZCwkBcX62GmJPxzBbYqd9DZmcgmX8YYUmUEzd2tFOVb8NLZfP39b9Sg0xM67GfbjtXE0J8Vgs/dkSQ5Cvtdpx9dnZIEGvHvmZxeersmHM1WRKseiAB7jhZCodK2BAEoWHPgydHnJRPqge0f4Czc9vfbvrIt+tDoI7NPOYjwW6pWemAU5RCVQgvyW0BIPapz5LeJrRFNMaoaCkpr8L1HP+0TfUQiv235FdHjWZyXDKKN9KCIXNyOVFKTpTVgAPNmQqWamhjut/Pgu6UaCnBhRZpi340Exu+Ouw74IYTNeNcfLDRfXmxLBLjiYFwZx627QbVNfIq3grPlCMbIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBwweOlCpZeftZbJuccgdi/1Nkjf80tmWb05ojhdlNM=;
 b=CziWcOwXoX4j48MZsPjhqdECF/fQSOY2o4D45+gZmLtUtPJCoQgzvR7pxYIua+gSQX/kg8egg1zeVonclL0iMZ/k0gJcNhR+Ix2NApBu6h5rmfcFnhxLG/kyX1Y4C/ujPHyLEE1opks/WvrxuqGI5NX9zPYnVLreoWRI7yAPAqeqsTV5FT6Hmj/eIjvYBsIK9MlifZ5w1GCMpidyV2znNUKsch2bOaNDoK/4JTWLrzWzDzyNvego3IYg3zFpUnXH+2tPvs/rUQ6l26xSWMDSIjQBS/4UUIAkLyjADuRh1FDDarLFnmPgqT9EZJIDAxgKh6y1eNr9OtaaHVx9E7v7gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DBBPR03MB10319.eurprd03.prod.outlook.com (2603:10a6:10:53a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Fri, 20 Feb
 2026 09:15:23 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 09:15:23 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, ilias.apalodimas@linaro.org,
 trini@konsulko.com, simon.glass@canonical.com, quentin.schulz@cherry.de
Subject: [PATCH v7 1/6] tools: mkeficapsule: Add support for pkcs11
Date: Fri, 20 Feb 2026 10:15:11 +0100
Message-ID: <20260220091518.180641-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::10) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DBBPR03MB10319:EE_
X-MS-Office365-Filtering-Correlation-Id: 043ba3e3-a03b-4bf8-bc15-08de706093c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|10070799003|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rmwyxPYAdGRbIzvIEoeR5Qa4Mp+qfQ8EboYWQiEQHh1y167CSZdfTyIfu+l5?=
 =?us-ascii?Q?kOdPKyEZvr/2vxv1kFj5uZcNP++XxhIm4orcK20tHgsiRg0n/kCU0fl9LLDT?=
 =?us-ascii?Q?2S4Zj1E/NppnKAo/Wgp8GJOe2C6JUboSAUKNPwiUxu0hhTxbTCa3fXNYHOQM?=
 =?us-ascii?Q?5K2lkEGE1nMm9IIc64O22M9oloGjtduUlwzscL89WH7zmCVeB2HQPhO3UXuC?=
 =?us-ascii?Q?+H/b2ZwlSOQlqhldR3vtG8AzQvmZAOYaQdT8brjIGxGLng97Zmw0n5cTuu4G?=
 =?us-ascii?Q?sm9Qw2eAag8YyMnqY7tvLxYPtH1hI9C/c0V7YQYnyfuEYO9JTHnnlLI2azqv?=
 =?us-ascii?Q?c+jNe5WRJ+9BaiwW4CeRDCFLBmtmCQCd3TX8KV9tYHFgKhcTyd+40LMfSfyv?=
 =?us-ascii?Q?kSqkHFlnX6zNXWOQzQzeHqQt9ubQbAAwFkR6TuV3Bztaor6g6K96KnPPQJ8a?=
 =?us-ascii?Q?r2eJE9y7Y2P15MsnlbOKKjSXEg97hOW30tE/lbqeP7OZuxcmLR5wUddhiGu6?=
 =?us-ascii?Q?NmAQ3UCeP4178qttMYuLAJIQXEo9g8HczxH6AZDldgJjmMZLdJSvIoH3gxGC?=
 =?us-ascii?Q?rjeqz8riRIt3Gg+X+J0tBqybp/2SGL9m0SDF3w8fIrMfLDUvoiqIaIphmMNw?=
 =?us-ascii?Q?d6k5Ej/tgPHPXO+xZkuJkMuYm2EiORJ+SCwq23+arOLFEt6a2xzngz8zjv/w?=
 =?us-ascii?Q?olAaBZ3Tuq4ulGEEQlBfbB8Wc2UiR9p2w6gDEqi3xDToAgT3pB5ny+J6XRY5?=
 =?us-ascii?Q?5CQVxMwVQ6lnx+u6oVP4h1t5d8I5lKa9sr2g0JZPgG+tXgHDzug1fUVbqs6d?=
 =?us-ascii?Q?EM4BCw9ostMPP9M6xTOyunpp6qABU99pY1FGNEgro/qPTGPX5i/hrOVVHecU?=
 =?us-ascii?Q?FOHBs3Xwv6ettG4ArQHZaoa24rojxm1R+D0Fz8kJMOcf9G8boa70Kj4IObu6?=
 =?us-ascii?Q?zKhfClSyFXvBZ66nLTXn44aEuJcib5Jhpj5ru1f949gjqGADg11mZQH0uRl8?=
 =?us-ascii?Q?3ioLAKV3ezob7xrS3LmHjYXgsDcsVwtg2LIiP8PNK4Y9+zlfV94pTGiSkWUw?=
 =?us-ascii?Q?p2IeAjulEvcngthwpjJP4mk1Vbq2u/BjWG/NLxxlJVfaEQMcFkxvXDWPZkRh?=
 =?us-ascii?Q?K4LEsCPq4w0sbY2aJ9xPmtNL6QNga2zgM3G0FpCQc9eNv/jp85CkNYoywM4r?=
 =?us-ascii?Q?LgAHNVi8wkW28UjeSK7DfIU/GWbGp9dBiPm8lHz6u7rdmKdJmRpzTBlR21Qh?=
 =?us-ascii?Q?36pgkZPghI1IiKyU/2YDhJFpTqhEmzXiUD3R0Rk99prUm+wEfYUQwaf/9+6g?=
 =?us-ascii?Q?b3pOrRIbU1y9ycTLgz3n46TqZPvU+1c+iOsbfZDN6vAMnCAeLKv85gx656l4?=
 =?us-ascii?Q?3ghPORJ0GFCByqQDmDb1m6nwKaGb1w0xy04ZNPO+cxvk+5aUcGecNH+YHj/o?=
 =?us-ascii?Q?b53Eshr69w0KWXxtGBiuEljOZK8eH/rXxlRjVWWOchBlIgWzeCHmxVX0q/Ty?=
 =?us-ascii?Q?14jNkTt97QygZoB5knb3il9jq+VwaRrL1FPvlC0XEvA38aL12Eu6czoaYB3o?=
 =?us-ascii?Q?TUdL7PDv0j1zI023E+U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(10070799003)(1800799024)(366016)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9vPXtlffU255Lm/Jc+cFwtpxKjqxYWSl2HpeUrXo9uzxV7ABfbCQumarM03P?=
 =?us-ascii?Q?y4dYLR/fg87uKgQ2+GZ0vuqgsC3mD10DxZgqB3GBI3X1aRioOG8WlsdNspkn?=
 =?us-ascii?Q?OOt3OO2EOXG0Dw66ghdkHWvF2hqIzESJ+G1hOgpdU2Cg/SFAoNmSbzwiQH/x?=
 =?us-ascii?Q?lOgJ/7+L9BuMacsQBPLbFUFFTQkEgCh+5KFXwUwUpy4rcV+R8TpeKrUv2GC3?=
 =?us-ascii?Q?xMm0flJ8Kb5UuRqEsIktzTkaBKxoX+X9x2iCVreI83nNJZqn78m2duxT+jKZ?=
 =?us-ascii?Q?mKjcwiegq02+AY7EAi/CRb4YfYjGzWh9gXjVWb0B2CiCEcfk2TyBfuA7mbOi?=
 =?us-ascii?Q?27cZ2ejtKwwKDssq0BcRZOUgHzm7ImYbKfYqlLmRcZS4bX//Fr56WFW/hYga?=
 =?us-ascii?Q?RWm1Lk/AsvRq5EJe9Na60a8LTtm2UekqXugdKirBhprbiexzBwMIBmQWMhuF?=
 =?us-ascii?Q?aNAOaO2FQxEptTzA7ChMweoft0+X4cH9dbF0THpYp5xGgmrl9RdsjhKMU9rD?=
 =?us-ascii?Q?7P5S9MWW/RMQYMnyAkgcQGX0oT97dqe7jaqaCbBdYLKPPmhoWxxHQEk7JPaf?=
 =?us-ascii?Q?LmZsdKkrN/An8Dr42z4zIP1xt6BTcFbZWXPtnWjbn8gpMQ2G2GphU3gPvYBJ?=
 =?us-ascii?Q?HX9fNtZipTrwj97Bc+Yi4ixnCEQxfE7d9Cl3GVaZ2PUQMKkI11AeOd4rr0c9?=
 =?us-ascii?Q?6Gpc26NT0IwR7+/3QqkEg36cP2M4kvj9fcswi3NsK6kqw0CQ6qghimfPjfwq?=
 =?us-ascii?Q?ryWMk+xzV9ARFkA6H/yqhhrdeHUIAI0Qo54B/p14cCqF6C8pSNr/jlpKTPPG?=
 =?us-ascii?Q?b670GePSCIiwP7ATnmiCH5Wy/ndVKAfzWSH0OK96eikrjs2IQl3JxOPnwDNS?=
 =?us-ascii?Q?w0IT4X1ZEWdndf+I0Wsh8SU8Zd1F+UjAyk3oUtuQB4aQT3UvPyji/VQVjjku?=
 =?us-ascii?Q?shqpjom4NLncWaCxDLaN83QLF5bK9az2y+Gr7UXbr7nrDWEYDpcQs+gggQQo?=
 =?us-ascii?Q?Wsj0TD/flgi/3mPCed+rqK8n8athgrJanC58sFPsSmTDEN7/UqtRcO37vHsW?=
 =?us-ascii?Q?DGJZUb3DhfwueTONXdE0yI8T+xCKQi7C6uI0vi+jdrg71cBBlq66dm+I9Ilm?=
 =?us-ascii?Q?j8SL1GrboPUM0geMUSQXoV8sfPtOgPoBPtmjvwd3E/9PRpYUexjGM9AlNFZQ?=
 =?us-ascii?Q?scwQ/t3lDKWxd1M4ApTAWoavCizIgzynWYx0UKWtOalqHSkQUTXuX97gY63k?=
 =?us-ascii?Q?HLFQa30AvIXqU4da8PmcB6XGCqo81eUQX1X7uJBvpzw2NuvZQxYhD940YJqv?=
 =?us-ascii?Q?dgOFQaJ8bBu1PhtmfkVNbpRwgECUNxG01LZ9HVU0tqb7wj2x/VQIeCI2Rn6m?=
 =?us-ascii?Q?JOXblNH93O6j0n2Jvs4Hm5dmREP2Q7uGRg5i71hrAcg5x85ZpOEuStDCs6WE?=
 =?us-ascii?Q?lND2uF3kmnQYdG/Ia7BvTZ5BRSrVIfQ4ekXPDobliZGKV7hrN7frVl7tefS+?=
 =?us-ascii?Q?vVqjkWh2qgimMjMSMQkvOMmWSJufPDGIo4aIWclSVEMrKrTRRGbMzOt9O6xZ?=
 =?us-ascii?Q?BE0+zq7JI0qpIJmF3cbah5AyjUUgTd19SKbpKivPy11Q7xOxBwddeZzpg647?=
 =?us-ascii?Q?xMzqikV5loRF5GkCyaGxFv8QZiTdxfRO6/+Wx6VABgl45VWjifEdDSL/HNbf?=
 =?us-ascii?Q?nbmRHAxl7QpjcJhNpv2zzcpjdMa4TegIoqx25avf2Fao1TGVrAYGdfz6d1W/?=
 =?us-ascii?Q?cSJTXe0l9Kn68JZYlxaZLr+e58HP3H8FtfcWtLzZKZdlAdHQHavFIXXJRLIy?=
X-MS-Exchange-AntiSpam-MessageData-1: NRSYBeZjkCJfkH54MLdwICnYC0vndVune18=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043ba3e3-a03b-4bf8-bc15-08de706093c1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 09:15:23.2306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp1HeEIx2F/Nk6YBSaZ2iNbMZRWtZJLcu7m7V7ytwH8Nn5BabBB8yyvwwKAmMOTczA7o+p6lvx+/Xd4QAqTY+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB10319
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

