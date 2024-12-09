Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3000AE77173
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 09:42:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79A388936E;
	Mon,  9 Dec 2024 10:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="lGEHRC1l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9DF6895E8; Mon,  9 Dec 2024 10:42:05 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E27DC895E3
 for <u-boot+nodisclaimer@lists.denx.de>; Mon,  9 Dec 2024 10:42:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCqA3gfIUZ3lIVKYyswbwqsjBatng7dSSjHB3a8y26YWbOTk5qvI+18MKLAY8n55Y6vrIKTMCBjpMzeD3K1mrCcSinO2O3/hxPwnH3jModfEnMDRYH97LsqNCp8o2Qtu5MxmNxwcUTlBtZd7o61Y8521IKkxP+Kp1n9jqkYK4Tj/PbaQRnQ9fhib9gQI1onByJJoXdGKhYMnrDo2IhF7cdZoRqgSUo+hVcr5SzgyS6pgQcfRaZO4LJXWLV79EZxH9+h0l/sBMHmF/Qeec7r3SBo2JISIfEh2G+iOAVXadzIq2aNuxetU9R4bkOitwOzpf5TDI8hZtMGUo2OhJKgvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsxVKzji7BhDRvMg80k/1OvKeqHwRtNZ2hKvZ/O5ccU=;
 b=w6NucgjYAtNlcVudnuLi5gMplhgGhDHocS5/qRuEv6mXeOdQoVu7jClLDbWajkRwoYvN63avmBgE4Mx4aWs9KkRnic4g/YqctzP1Dwe4AavxekPyvuP8D2r2yPkypYYZC6t6rzr80wVwrvxDveGwSBCcUDosPLs+XDdqEPch0oOnwMf6xhya5GSX9tLLpVAYm/ncqcvkpQY5XrGkCJQb/6vx6+7x1zHFKE1k8ObqwTBsrX3piwc/UcorEHClveU6GM+Zym5D6dGZvNnBgcMxYp8UTMn0pi+hpqehq+uRPZZgGY+OA+DVKOGRYne2neQbhc1V0nEgeqGAXXjFomQJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsxVKzji7BhDRvMg80k/1OvKeqHwRtNZ2hKvZ/O5ccU=;
 b=lGEHRC1lEqv1LkLhFhPH/qqlSUOTXOI70RwSrEpGTvuwvhjazba1dhtnM1IHbBaxH4zJiCGZ/U0pPvfCk0VCCB738mQWxmhMVKxAm+mvpBSNLcU6hP6D9aRQQ681Rna6oW8p6KlnOyKFQNuElrXkwni1hQKarhPa45fD6zMvFiqezUMNFo8bBS1rGHbEBZnNH0ZBTd+sewnyPotaXVuQkkKzeBEqMpgsFzfxzBAnNesb0ln3EiOAc+E6+Misfdfrmw4FG6LMEficmwbe9ey993TmRdsgKGHpOxpP26f2101S0L+SrDcJdqF8QVfVTZO5XwzJIo89TewjvNHPiWZIuw==
Received: from AM0PR03CA0062.eurprd03.prod.outlook.com (2603:10a6:208::39) by
 PR1P264MB1565.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:193::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.18; Mon, 9 Dec 2024 09:42:01 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:208:0:cafe::ce) by AM0PR03CA0062.outlook.office365.com
 (2603:10a6:208::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Mon,
 9 Dec 2024 09:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7
 via Frontend Transport; Mon, 9 Dec 2024 09:42:01 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 687242013D;
 Mon,  9 Dec 2024 10:42:01 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: raymond.mao+nodisclaimer@linaro.org,
	sjg+nodisclaimer@chromium.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v3 2/5] lib: sha256: add feature sha256_hmac
Date: Mon,  9 Dec 2024 10:41:56 +0100
Message-Id: <20241209094159.8355-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241209094159.8355-1-philippe.reynes@softathome.com>
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PR1P264MB1565:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4e56c60-7a15-4f10-d5e5-08dd1835bb99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KiPKz2cGT0nNuuol7QFr48fJlNOxWFzj9taxxjb1eVdMM+slorOwQi2XTefe?=
 =?us-ascii?Q?swC+83GuiUP+mPCq7t/TPrxB8j1pnRW9Zzrfoo5ULh/zBaULnTdWxc6uNPKC?=
 =?us-ascii?Q?JD4KYxTDwQdluCoxi/ISg+ciTX0dxU4As3h6KNuBuFkCf6tzn+ehV/rXSHCr?=
 =?us-ascii?Q?wPkjQJHMBRY7X0bhxBAbhMgnYWtUkfTj0V2zfE1YVW1ibLmqtc6y9GZkk020?=
 =?us-ascii?Q?RDONfimwAvQgewtGCayvzAkSJo+FpenRvIkeNKMihMpGcJ5IoQ2o+mBibswm?=
 =?us-ascii?Q?IGG4/XiRyeGXVupPJSGIszCwfDb4Br1bHwNHTnLaQ2pBQafPFN7Pm9/AdJiK?=
 =?us-ascii?Q?JLvi1nhwiQ/iLrm9UkVktfdv9b4CjvFG/mYpGieAR6buEjv/eEb/l7sPWM+m?=
 =?us-ascii?Q?6c36LWOmngjenUsFHHSp0DoZ1Og4FIKqBr8OzCWiOtuEPysgzixXBsT6hJdp?=
 =?us-ascii?Q?exCwksq/QVOZUwQKCISd9i4p6FbirfvfkO3d0jb+FS1gE8bBcPKIcrCZv6Gt?=
 =?us-ascii?Q?b0Md03gtfhYziBnGZuzjU9tWJ6bc0GDbpBHVjYMN6XfbuwF3bjazrVls1Bke?=
 =?us-ascii?Q?KFpS2QRF6iooiVaSvtb+DVLn84G/2IL3Yyn8WfPU2oxBWtntnz4H+8U1geO+?=
 =?us-ascii?Q?jwWe9NUd8QSxENQGxWNFiGsjLbpEiZUtksrLqupYaHqDyBgdTtayLl7W2N0F?=
 =?us-ascii?Q?UW4AqqTpMW0zudoSX7VdSxDi4FDII2wW7eCWB1aZAi4+ox+gzm3vbMs+jUqr?=
 =?us-ascii?Q?syXOuWdC7E8u/JkeUqUfBLllqRrTEijwVfJwzLyCnAEHzy8ILJcSn7Hgx/Ah?=
 =?us-ascii?Q?nOP7ab/Uci/CVQJc383jNmMHl0fzfNTcuYtKtl+ycqGmXDGk5qtYubSj/TgW?=
 =?us-ascii?Q?nZRO/7JGDEvfFi4FHO6rVcqKTIhel1iiM6ixszKf/Eow3N0ejjLMuw2Ur0tR?=
 =?us-ascii?Q?ovZMDUChZv2YiM9ZpOqv4K2h98w4eyCR4YgeSiVlm9uXAcgiUtgk/ivaG22c?=
 =?us-ascii?Q?zoYISId94wsfSrsZ/txDyRX5SJ1+2R9sl1kJuOhhuXCCwsYS0vgaOmvgzc+1?=
 =?us-ascii?Q?b2X3hlpXSY+WXZ7jy3yJdsWvHA+gfHpV+yTzGHcxWJnKVF177UyjmnHScYRu?=
 =?us-ascii?Q?cGbwNaFrhSd6/8/ZYXNNrdGzb6yNMumVwdrkyIg1IG99Ax+brHgB9+O0G0Ci?=
 =?us-ascii?Q?48FxHJgMzeoKOMsbNheE6rGsGGx1NkWop44U8sCXSufb+k+4pBs6vtG2/XGZ?=
 =?us-ascii?Q?eQfQetmodx+ZaIz5zRQBfUuHxG69QPNk2gwkz+4tsbJKg4eCOw5UU8gdJkmS?=
 =?us-ascii?Q?XZc1MXSy6+iA60dmP4hhoWWjOks+Evk3ha1fXPk07bf290fVpQ5G7YoHLdr8?=
 =?us-ascii?Q?NljSnVdlbRjAQ3LSZc5/3hxjwkUWTXoH8AZXsJniL+pfCGUCmrXqxSfaycfG?=
 =?us-ascii?Q?cGKLGKpUXmzh3jsOQwFsC1YvN0BZCAQZ?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 09:42:01.5607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e56c60-7a15-4f10-d5e5-08dd1835bb99
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1565
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

Adds the support of the hmac based on sha256.
This implementation is based on rfc2104.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 include/u-boot/sha256.h |  4 ++++
 lib/mbedtls/sha256.c    | 38 ++++++++++++++++++++++++++++++++++++++
 lib/sha256.c            | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
index 44a9b528b48..2f12275b703 100644
--- a/include/u-boot/sha256.h
+++ b/include/u-boot/sha256.h
@@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t digest[SHA256_SUM_LEN]);
 void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 		unsigned char *output, unsigned int chunk_sz);
 
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output);
+
 #endif /* _SHA256_H */
diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
index 24aa58fa674..1b9fc1a8503 100644
--- a/lib/mbedtls/sha256.c
+++ b/lib/mbedtls/sha256.c
@@ -8,6 +8,7 @@
 #ifndef USE_HOSTCC
 #include <cyclic.h>
 #endif /* USE_HOSTCC */
+#include <string.h>
 #include <u-boot/sha256.h>
 
 const u8 sha256_der_prefix[SHA256_DER_LEN] = {
@@ -60,3 +61,40 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha256_finish(&ctx, output);
 }
+
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output)
+{
+	int i;
+	sha256_context ctx;
+	unsigned char k_ipad[64];
+	unsigned char k_opad[64];
+	unsigned char tmpbuf[32];
+
+	memset(k_ipad, 0x36, 64);
+	memset(k_opad, 0x5C, 64);
+
+	for (i = 0; i < keylen; i++) {
+		if (i >= 64)
+			break;
+
+		k_ipad[i] ^= key[i];
+		k_opad[i] ^= key[i];
+	}
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_ipad, sizeof(k_ipad));
+	sha256_update(&ctx, input, ilen);
+	sha256_finish(&ctx, tmpbuf);
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_opad, sizeof(k_opad));
+	sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
+	sha256_finish(&ctx, output);
+
+	memset(k_ipad, 0, sizeof(k_ipad));
+	memset(k_opad, 0, sizeof(k_opad));
+	memset(tmpbuf, 0, sizeof(tmpbuf));
+	memset(&ctx, 0, sizeof(sha256_context));
+}
diff --git a/lib/sha256.c b/lib/sha256.c
index fb195d988f1..66224c92dd9 100644
--- a/lib/sha256.c
+++ b/lib/sha256.c
@@ -300,3 +300,40 @@ void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
 
 	sha256_finish(&ctx, output);
 }
+
+void sha256_hmac(const unsigned char *key, int keylen,
+		 const unsigned char *input, unsigned int ilen,
+		 unsigned char *output)
+{
+	int i;
+	sha256_context ctx;
+	unsigned char k_ipad[64];
+	unsigned char k_opad[64];
+	unsigned char tmpbuf[32];
+
+	memset(k_ipad, 0x36, 64);
+	memset(k_opad, 0x5C, 64);
+
+	for (i = 0; i < keylen; i++) {
+		if (i >= 64)
+			break;
+
+		k_ipad[i] ^= key[i];
+		k_opad[i] ^= key[i];
+	}
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_ipad, sizeof(k_ipad));
+	sha256_update(&ctx, input, ilen);
+	sha256_finish(&ctx, tmpbuf);
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, k_opad, sizeof(k_opad));
+	sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
+	sha256_finish(&ctx, output);
+
+	memset(k_ipad, 0, sizeof(k_ipad));
+	memset(k_opad, 0, sizeof(k_opad));
+	memset(tmpbuf, 0, sizeof(tmpbuf));
+	memset(&ctx, 0, sizeof(sha256_context));
+}
-- 
2.25.1

