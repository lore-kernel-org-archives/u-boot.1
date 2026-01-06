Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F52C47BE6
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 11:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED63983F5C;
	Tue,  6 Jan 2026 12:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="FVdpf6pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0E183952; Tue,  6 Jan 2026 12:11:14 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6FF839A5
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 12:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaazYQnH3cMbRMSGxwyHjgKsjGTwHHCFQ9m8Qfnf0/9uUrZzoW7xImDG3WRkLlSf0twIdGCqKvdHWJJYsOLnsGHTOlcaLUNr0vwSVg4CZoRvJyINQIHOqHZK4Rkt7L/sZoeAtfMsJZm3obPuxpAAZBI+FTdbgaMXQ5mVnLXTLUIP5XLHTcMrYl1YfEyGJnCzW364xnWpT77snMMM4IxsNAjfH9YSzBi+xgwxEfCA8J7ZDW6qYSUHum7NnHJ+Wfyxz4GxYZDLEhHNJYeEqAGiQNyGJU9Npk6OXTlr1PzyH7ubgF2J93DbszUyBIB39icPAQLI7n52H/n91SGINqljiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=zREhONsmr1F3Pyy2V5zij/JkKh/3YrCdqjsCbtJFhhWZFIzY/biP2o/ACkjRiwbVaoQdcH8L6KnOEXOpuX6maji7M6o9AiCE7o5fvLjrL609DEq2dJcG6M2KYQ2FCwdxyojMQW978iPxwCVopZE4Y77VCKMNdWXsCix5YLS+mqDAUxZBI+Im+z7nDbTA0yV5zjd+vOgKFC08VQyCUs5Om6whCjk4IHM43TBn//2rG7FC90MzBvfKRGwLvNgaznIyX7zfYZsKn5tkkuK1QC4RZ3A9R8pxVfpM3x82Me5MA4KB6qkewSCenMi3hMh6K/ZhTKdhp9xSNxPUKBX9RIwTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=FVdpf6pjht/0bwEUkJpLBblxFrcaGnf8Aj7uMBqUPFq/K8+18TYE4lUGGmYKSgtliY0pGpkMfUhydSmVwRO9r7sm5vW34pSrHiEMx345GQgjlfPymgNVWWZ8XP2N5mOLrwlAxIokpClz73sOzx/FBOzMdHaijKUVdTuOY5vq6UCnrhr0jnMXC4CVij9yJIopjwhpwUqRAjlqS3glYO2ecB6Vdnfc4P1TetiwnLty5OFkYSPWX2OEENvUkGUEZKT+H7HWJM2tIgLBOAqoQwwlDr4Tq6SJCQvTw1p4ULcd9ZWikvQk/LtWVf/oGZ3LkTbaeUpMhoeDtkfqkqkPdUM/DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB7302.eurprd03.prod.outlook.com (2603:10a6:20b:2ec::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 11:11:06 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.001; Tue, 6 Jan 2026
 11:11:06 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	trini@konsulko.com
Subject: [PATCH v2 1/3] tools: mkeficapsule: Add support for pkcs11
Date: Tue,  6 Jan 2026 12:09:57 +0100
Message-ID: <20260106111034.889964-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
References: <20260106111034.889964-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0046.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::19) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: bfe8fc73-dbcf-46bf-bd2f-08de4d144995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|19092799006|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wa9c2uCSMqxA9PQVaRS448iGBqik/C5xMmWJDZ9lCUQPf9pXlyjCcv4bifXj?=
 =?us-ascii?Q?05an2zuwXlUj/c5p/xHIoLShSBi3W5nQUdfkwkmc8xZBblMsxHcuFxCOLhdT?=
 =?us-ascii?Q?1zMRM8rvOqL+Hv+j12xsPbb76BCn46tHWMFCVnszwFuyCK+qJxe/Tw3gwJ8b?=
 =?us-ascii?Q?XJrfQoij6w8MWXI0Rm1ClQtbPrT45z0eVWAKCoE/hJuS6WbiTU5CnN4Nc7bd?=
 =?us-ascii?Q?cnw61X3U6ynd8MBDrrEHcNMZHflbgBoK7e+eeXMCjCz1QK5BMfK4LwqrUMAZ?=
 =?us-ascii?Q?I4x5+yxgvPsrNfq37kICMrLKI/e0DDYR+X7T2DUifAYMnlDS7gaMnI5HWjgN?=
 =?us-ascii?Q?ghelYcSSGyLwJyxffgu0Z6O8IVP75YZ+hhEbm8KfkWOebv610ymsp8ctjjP/?=
 =?us-ascii?Q?HDMqKalE/MV3KwM9DwPVhElibQ57fql8TBb8p+3mI2vxe7b37rUwUI2ybUEL?=
 =?us-ascii?Q?waciKD1PW9rM0903fXkO+hxspn4oeykCY3vLr1aZXAlCYaSfWqxy+8sv0ZzP?=
 =?us-ascii?Q?fAg9LIMcrdI1mSg29S2TyzvxK0AVODArHXCr8181JDGF2EwDUgEsCJs2qa+b?=
 =?us-ascii?Q?7hLrTJlit51YsV8WrACHNBv7iND8OJvWc2lvroqHoChAIpFIp94dtMpYA0xP?=
 =?us-ascii?Q?lU0m8VBfOPz5oXSZakLnpDNsEHkDmpqmK7SabHplrmKB+R7rx5//xST9q/bc?=
 =?us-ascii?Q?V+oN/FhYIBRQanzO0eP4aP9ku4ArMHT2eNbvymdig7Ks3tus6jK0upxe/F6G?=
 =?us-ascii?Q?/W5NCSswMOqIC7DD/o80FYULRmtO5Z1Ig4rUWAkFsAG9oPuUUW+cKSZaq8+g?=
 =?us-ascii?Q?ow94MXvmikxkQrr7fW+2o+SC4lguU7Rk+vORd0UcVW7nQo4cFZYCVczbkC9v?=
 =?us-ascii?Q?+NckH9udYN+aFS+zqSs0vMgKA9jXMZzgRpbwShLuW6Xh4hu6WSB1hsu+r2Ae?=
 =?us-ascii?Q?Ri+UT88L3pqGyK4zdb0Fua7TrWIQuFxDfpBAqukQ9V9bX3KS0XOqRMCECqqp?=
 =?us-ascii?Q?T61Naky30kmEVUmYDJSTKR08Qg7jvg33ekpYmU53TCjab2h4iU3xIjqhC4Qa?=
 =?us-ascii?Q?afgz6m0Fnb2Ey/ZuiwUqhKE4ROzTiYPMOcvhf7PbwtTnvd+kKWuju/5YT9TS?=
 =?us-ascii?Q?cMvEO+RTQ2VW4wOF1BGSrf0Mhn+uE23L9FSsFMpnZecERtb8i8N0CqWHe1Lg?=
 =?us-ascii?Q?tumNIprP2Iz4tUaD+cVaMODsPYvE7odonT3a7b7W8otkA9SlDgwIG9PwVyYZ?=
 =?us-ascii?Q?3aydgCu3L+zWKxRYlp6jYWuqeKeUGJtoiV94lHms7TWy3WptWAqlb+Cxh2wN?=
 =?us-ascii?Q?6SQ06Rlydr9dn+JDPEIIbfDZCFFjMTTpEFEikUUE9bHb1CfrQtxT+CCIDrn8?=
 =?us-ascii?Q?/y6u5BFOkSYW81dOVk1AYjMEKQCMrZHdhRuiSdz17R4ZZdfiQmUGvonYb1xj?=
 =?us-ascii?Q?xtqmOe/7VGZ5XmYwuC2d77eP3aP07AY+YAvq2zAUFtrwaRKoEZqGsyriWw2C?=
 =?us-ascii?Q?2xVGE0mojVSLZ9sL3+qeqYRNYMxhfAE+foKl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gi5jZB2TitS6uKij5GTh2DpGZxsCOF07UIRHJaoGdvHrDvDtA8ofVF8d0MCf?=
 =?us-ascii?Q?z7ANSrdH5RoQYHTW++u6SDTJ3fX/fAp9UNZgdl402iIL3+oipY6wFcjqOmPc?=
 =?us-ascii?Q?3U15KAmIy+LISFez8+1IWepLIgrcszNgS6WOfcLyc4sPuGwQRxALNQEnLTpY?=
 =?us-ascii?Q?w9kSD36/nklGUD1sl3eTarzSPKG5g2yEOGeqOXTgXZ7lyJTlmGHBBnrz9G37?=
 =?us-ascii?Q?5ZdAe3pk6g4wpp3/X2X3GuJcMsks9Ix/jzAwHmCi+9AHydGqJx6mTT1fbH71?=
 =?us-ascii?Q?DL2MR95Yb9504+ZEdU3hiV6aPGbr1fVe7XIfwp8aYlxEuB2u/3i0OGknAYhU?=
 =?us-ascii?Q?YXgF0JdGXbK8kDO1c217EmT4XybXHsvYaPgUzKkJ9OSUL289LJaDk8gGc8+B?=
 =?us-ascii?Q?HyJzeZQPxhtkzZjVBBn+yvT3ARG6vOft2stJxtRuow5IulS4X7FSsy0axQby?=
 =?us-ascii?Q?nGGmt9/llJh5/6UPF2eAosyP+Bf6u9xUi8zHo8SmGlguJ3jgRf8IyH7rtBoI?=
 =?us-ascii?Q?3ndCZ1S1vcF1bOpcE//vmDC24UrnQrgJLIlV5Pq8d1nb0wj7z/uGdLKCZR7o?=
 =?us-ascii?Q?rGjFTrlucdy8BGn7XzQUktplzlJcLaV5oizYXCbM1Mc2ppXcHpA5gAzRHzjN?=
 =?us-ascii?Q?6sMCl/S4GutCyaITS1pXc06MF8++1NJFv6Vd5XRiE+l066GLQbEF2yPCs8Lw?=
 =?us-ascii?Q?KdgOheG1HxTu+DEWgkN9XXJLh0JiTGjcM4jVFcTci5uWbs6nn/lyLJODuw/7?=
 =?us-ascii?Q?FfEkPnRIOFNVwWJCfAXY3ZRy59iRNltiWNu0jjEWpC5uNX+ASkug6eoBN1p2?=
 =?us-ascii?Q?SYPw4+gESD0bw7NOarzlxsjICdPJx9zpY64L8HZ7OhhN8A6OU9obCn7NqjAb?=
 =?us-ascii?Q?jkv9jLYf3G5ue37+Puu+YoD+h7ZCVUAgU1SS69iyHX9p5VmFBS8fWu3DRg2X?=
 =?us-ascii?Q?1Peo67C2YghYRXW9JzoY9oqgnXOw1UwybhhIMQ62qyLBrEhlbswRD0zk7IXY?=
 =?us-ascii?Q?1hm1YLsEJEzoT1vZ+kwm4GEzPQlabZm47riAA+5stLht+4irNinqapbK67zH?=
 =?us-ascii?Q?vV8geezDcxLZncx6hJ19cfLsUgFWJ4uhYTPZX3Pj+Wvoywk9gEJYmNcbPBzD?=
 =?us-ascii?Q?2EH53lZiiaaS3ODuMngnFTcvsO+fEl1MU/pByh4CUZ7pQGi5lU/TwCWNqakU?=
 =?us-ascii?Q?J1lxlN0Q/EQ7c+1Lwhj58Cn5qP9tN6zinekkme0EdNhTEyGRiqsDqYccBZuf?=
 =?us-ascii?Q?HcbMjpuyiTOdpyu2kj9GFaN0XqiuqlljFvsBTk1w1U/aVx1xG4EZzqT6laZR?=
 =?us-ascii?Q?pc0hXV9WcJelpMo/572WXyI33a+qUeP1/GSakex4vRY9rZZVgi9Y0/UBFWVe?=
 =?us-ascii?Q?5UEu1G6m1UkriETD54eaKi0RfItw6/kJrlqVA0GTqvTVsm2loqd9KzE7y4wu?=
 =?us-ascii?Q?8twB1Gx/woTLwPAaXQXJ/SQRJDHLlyXODKu2/UF7BQUVnGHezcOFYaRcqrdI?=
 =?us-ascii?Q?gGeuGBMvWg184asHw2D3AH8PzHV/UfjUwzW7/mzQ3hp7kocBHKR3NArbjrO6?=
 =?us-ascii?Q?fgexlIXQe6NYyX+cvsBglNz0ZnURKe+6MwIHGtTKATs7IlZpSyTE6yEEEEVk?=
 =?us-ascii?Q?eXF31v5gStiHKMSB2snClCReJ5OOzKKC2AFtOoP/ovL5fm7JeO1HfbMu2IsY?=
 =?us-ascii?Q?NZeyFWLIY9TLL8tjpU4/pdge1X5OyPSYp1Bo+4bqdoVjLz9AYLhSLUrfV8IQ?=
 =?us-ascii?Q?X3v4kuGQ0w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe8fc73-dbcf-46bf-bd2f-08de4d144995
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 11:11:06.3301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2xwrseH+jeGIWQy2YhqpYiTw8AlpBMHf/Qqg5RqUGrWwx0NiFnsKN/QOrOryEpukQqLLhMMb0Z8AZOkKxirRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7302
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

