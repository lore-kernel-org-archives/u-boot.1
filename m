Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C02F557E2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C8A4842B7;
	Mon, 20 Apr 2026 10:39:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="C2sy2dnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA8B0842C7; Mon, 20 Apr 2026 10:38:59 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E6D4839D5
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+szjAFKCK6KNVUG58AJM+fnPKtPzxKO1+uWHChsZTmuodmF75HzfxwlUFZAq+hhePz5VXXalcM1J/FS42JHPS4UV2nw0CrXyk+0XUb1Y8XQOhV4usEsicibjTChyncLgqdnh/12hfSRKRlnpDF5XWO7fLZfFEPigq6AI5WW+dRdzNcLJeCgDoviLrJILCDWp2oijOu+NPYExKsT4MFcvgDVqXBOh5ULkZenzMG8fTE37ZQLF12RXMcp37uJ/xpi8yBQTlLLmM58DbXxrmO5JbBX+4xQwggwrnMEPVnZ+sRwTTyxw0SfI169/TO3kWbqA3SRunFbiFAPz0CnwtcwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilJA22Mt3ThAzt7TwLldmjbKrGPbqitbyRQmO6/aIFk=;
 b=wPoaPzHnusfK+2hTUyC98C2dhyDqljcZuVZKPCPcvDlcpZasCu6SknOj4j+3YI+nYjty4PkB1BjKtuaKdOGu4zjn/HdaVuAQAQgEvHzR5XQx2982VOiJ6DXWv77yacXKG6hWJxWDtyxn8BL88M+PXQKiFVa+tAQMKhXAmh6dAcm7kh8U9idCUIy9pONcgrm+VY9aGsTlOX2qgGMr6ZtfS7xV1UGReEb8fT1g2ER7sjz/WT91hkFZD4/BFwp4J50unfuBv2jJwqEg/nlDjTdGDWvJlzym5JXAMXD4HRkCcObcJ+E1dVGjWvCrs86P05u1P/La7J0i231oj+8awtxUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilJA22Mt3ThAzt7TwLldmjbKrGPbqitbyRQmO6/aIFk=;
 b=C2sy2dnzeHDBfIJVwsCXVuKBy0qsBEWktJAtN95ehOXUX/EUEIqlAYK0E2fTUxcj2plFN4gjxa04ofnyH2Ja2r8UWf8AKHQiFttV8wRFvAY7yCxDBRBdF3qAGZqNFz2+OeqlJCVoynvt/5TkyGmpK1mFA49vALDJY1DJNSnvENUaBs7UM0E5A5gM+2SXAF7IAGuuM5oKFdX9ygAaHs7bCmPjl5dPg7HZo2OAa9WArAnhyclKlmnOWKojKbLpG3B1/iNhh8x0pPQ0SdceVNNDdHCoVgvZMHE/H0M3b9iavrzTVXJxZtJn252d8vWv7CHEH6H/Jxt7wR1lAIq9wTxRFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by PAXPR03MB8228.eurprd03.prod.outlook.com (2603:10a6:102:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 08:38:55 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 08:38:55 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Simon Glass <sjg@chromium.org>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Subject: [PATCH v2] tools: mkeficapsule: Add disable pkcs11 menu option
Date: Mon, 20 Apr 2026 10:38:49 +0200
Message-ID: <20260420083850.8504-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0074.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::7) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|PAXPR03MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ae9920-563e-42bf-9dd1-08de9eb841ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|19092799006|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mxkByTUsTyt4Ip/joCUbdX7gd05I+jnxiHYZsIPtAzAYkt7NkzmjfB7dVBqVmbsTLuAOJ8M5rAo+oTitXT3OBe5jjfGYb0pNdYrKa+S+9035D0jKm/CfOGUxtNMjpdWdA1PFBwRgBQe1x6a5N0OvYoGf1Arg8kglgTKebDo97Czkxd8rQG+FoseGQgDyKM8emFl4tVMxkU0uLIhMlYSVC7grrifHkcE7TY08odaUDX6HMVIPA9JUiXAtXqSQcIYGCb1qCnn/uO/RDLKtpJocPwMmMb7MAxc0hJGzqlK7tevA2izQn930IVdVNh38QyCMYl3zrwy8N6Y+81bOchdzler41Yj7cq00B0uHHfInTKUhPtatNbKHAKomlLX60H5RN6ayxVxGLiIg9pG0bmjTeYhcuaIXcptf30fTkcWVYq2z6XIMpxKGqbojcj53I+ejc0ZenLcYZNycWViBswyus6Kiw0l6iwb2CiOPTNuKWNmmQvpAT/vYgsTAQ6K6jHlv5FQYlGXP+lI0go21wwy9hqpaINpbDOcjFoUSpXmp29f9s67Rc/aXOYrkeudLCv7P7/ag+7soB1v4n3OECpRLKwmLUwJTxXYIrKi0937gev+dhDJxz6F9Fv5tHJnAHy9Eaus77M/PZ44K7b4vPygR2bfeuqlVgtAUX9uHPcNRGzW+DsjSdqHVZ9XwTER1TlQ7+hK04K0kNg6r/wDFv8d7Q2DwDijRH3a19dQsNi308cPMidCCpkm41W8xZ5KRvNfVN0C1DBA/yrjU7zA9VfBDhmGD5PMtB0b70J4UE25iGbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(19092799006)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GI+CZn8ILStuCMSsmFsatXoex3g16vbC3RDc79mXlzaC98bJ8ehPj7+27cOS?=
 =?us-ascii?Q?gFpwka4tml611Ocq177j3sd/1c1qdyX5aSsomplIY4Ei2yWLpad0jlA3ktSE?=
 =?us-ascii?Q?tEtQhPO98HPpJrlOCaSpqagSJCHy8o7EKVQyd/S9T2GdSLIprmEJ9kZTzXlx?=
 =?us-ascii?Q?7vAMep9YfIRF4AmXdHf2vnflIUxLlcCUTjAIfRF59ds92g7S7J/WoNk0JXp7?=
 =?us-ascii?Q?9LrCKuoyhG8+lxHtP7RZUp1CNMsl3dccaNyleRJVup0thhWXVxR8WDtwNsxT?=
 =?us-ascii?Q?Gf90powqSgu2nLKkrsrIPCvKbdrDYbMC4+qRiqOJoWlMEKLFCGxJuoVHWGdL?=
 =?us-ascii?Q?1kVfuXf7NtdsHnq9r1jVKGNuG8RcNeeCpQF/XpOpsACLIKAQ7Bv1mCRhF+83?=
 =?us-ascii?Q?F6kq6pVp3dZ6zc7bKEZOAx5IXZQBx0blqNhJZbusblH8Qh9a3u7eXqL0GSol?=
 =?us-ascii?Q?IeMMCNKdCk0bCN32j868KBkNth2RlHqfD6LIgZhPSdKfs4U7okSJN++XLwZi?=
 =?us-ascii?Q?HESftlN1dUQl5TxjTZiiljOZjYR/q8cjFLtTtpYHyGWBwIlqaRlqAmeGEQiV?=
 =?us-ascii?Q?pIAX7uYy+rIltrx5OYB0A0JVbnOcjj0naSi2S5V+oyK7V+45vBmZQokwx86k?=
 =?us-ascii?Q?Xe36TtleCU/U2vjYS6pKl6iCyu1gYaxiUhaUCmMuJcNsY7prcT8H8oCaiymv?=
 =?us-ascii?Q?jEmvxQtDIkoGplHBwtQfbLryHvWXzEjK6nYBF+wRuQeaOZjLopGZ8a43j7m9?=
 =?us-ascii?Q?ER3DsxG0MizBX1TH8STWHgSPud6BDSQbcw/gBcmSxMy5cmy+gQV9EEy2U5XT?=
 =?us-ascii?Q?QHHjdSL8qwSbRW1nNGw5W2sB66Ia8QfK60OkL+rFMhbBLGfg3krI3n/eWSPq?=
 =?us-ascii?Q?ETi3FZXdWwtFQKEbrnEIT4JletTh9zkKZZ0dQqw+d6GWD1rizsNGS7zjiAcc?=
 =?us-ascii?Q?c36remfdzw3iRL1/zy+QN2kL0+f5lhWIHiFwG13RAdWRhxPuq5irT9EbZ27r?=
 =?us-ascii?Q?8exJo0TCqU+IGmLYQBi+K/Mi14zdA3Ag4+BueZapmxWwpMLx6aHVUzxOE0hw?=
 =?us-ascii?Q?qpxnfFtP+n/qlqmAh7WDR4jMJHzPQtCpP1HPSgHDKJ/ioTRstfKxUSIwVc2m?=
 =?us-ascii?Q?vZxuAFXvMILz/izGulfydkqm0rYYcHxTzMCOQk1EqbR1YFhLWKNClGMQgmDz?=
 =?us-ascii?Q?RJSF1kRVJzRCM4dshEfoZQyEkERnqNPxDdAv/7Xw4QE4KhJUmxLFMryeB0xm?=
 =?us-ascii?Q?P83PrHz6xQvk2mGjYsiJ+N7l3C7HQygOEQJK5ZCMb7oMQ9l2nOY/q/avekeB?=
 =?us-ascii?Q?+kSkznATr6rRXrx/GiMENyPLEysbR/lpmXVNklze3qOZ/GhgLMbeTa/JWFNT?=
 =?us-ascii?Q?AUXxy+SqG1kcvYPNDOtvsQxF3WzpvOSfop1tdWtY7NN6fhpndRihOxrL2xF1?=
 =?us-ascii?Q?ZDnczSy9tLuaXK+YgFlq37xPVRJKI87jrCesdwl/nLUbIM+j+g+H61fvv7zN?=
 =?us-ascii?Q?0L8geweaQmYCILMnRgB4EErMiwy0oBh5JS93h85uNyaIUcr6/yRwsVY1Moav?=
 =?us-ascii?Q?lnsLqP3TssN2qygjdh69DmfEBVJnlqnqyeLfLkbJQdX7iZWZuJr8xIH/keU7?=
 =?us-ascii?Q?BwEKLP+rxYrFicTTqwqvk0JwmZE/mWVk8Cma7p7zIoMJ5T0UkctLq0jXioS/?=
 =?us-ascii?Q?yvp/YV+XOD+gMm7SgeeqsLSBRwSPnIsOqtyxaiRYZyzG6VB+QxLBpA6LL5IR?=
 =?us-ascii?Q?ub65J6H0Yw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ae9920-563e-42bf-9dd1-08de9eb841ef
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 08:38:55.1467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkLZzNxlARqJyo/WrCYY9ToW6u2MTg2CrBfdkHBpwJ22dq5MPOXMBgX8Im9guqs/+aP9fi++07XktkDy3VTojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8228
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

Some distros are using gnutls library without pkcs11 support
and linking of mkeficapsule will fail. Add disable pkcs11
option with default set to no so distros can control this
feature with config option.

Suggested-by: Tom Rini <trini@konsulko.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v2:
- make use of stderr more consistent
- add missing ifndef around pkcs11 deinit functions
---
 tools/Kconfig        |  8 ++++++++
 tools/Makefile       |  3 +++
 tools/mkeficapsule.c | 17 ++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/Kconfig b/tools/Kconfig
index ef33295b8ecd..ccc878595d3b 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -114,6 +114,14 @@ config TOOLS_MKEFICAPSULE
 	  optionally sign that file. If you want to enable UEFI capsule
 	  update feature on your target, you certainly need this.
 
+config MKEFICAPSULE_DISABLE_PKCS11
+	bool "Disable pkcs11 support"
+	depends on TOOLS_MKEFICAPSULE
+	default n
+	help
+	  Disable pkcs11 support. Can be used in cases when host GnuTLS
+	  library doesn't support it.
+
 menuconfig FSPI_CONF_HEADER
 	bool "FlexSPI Header Configuration"
 	help
diff --git a/tools/Makefile b/tools/Makefile
index 1a5f425ecdaa..60e84bfbf20d 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -271,6 +271,9 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	$(LIBFDT_OBJS) \
 	mkeficapsule.o
 hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
+ifeq ($(CONFIG_MKEFICAPSULE_DISABLE_PKCS11),y)
+HOSTCFLAGS_mkeficapsule.o += -DCONFIG_MKEFICAPSULE_DISABLE_PKCS11
+endif
 
 include tools/fwumdata_src/fwumdata.mk
 
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index ec640c57e8a5..2f6e22626c51 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -229,9 +229,11 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
+#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
 	gnutls_pkcs11_obj_t *obj_list;
 	unsigned int obj_list_size = 0;
 	const char *lib;
+#endif
 	int ret;
 	bool pkcs11_cert = false;
 	bool pkcs11_key = false;
@@ -242,6 +244,7 @@ static int create_auth_data(struct auth_context *ctx)
 	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
 		pkcs11_key = true;
 
+#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
 	if (pkcs11_cert || pkcs11_key) {
 		lib = getenv("PKCS11_MODULE_PATH");
 		if (!lib) {
@@ -259,6 +262,7 @@ static int create_auth_data(struct auth_context *ctx)
 			return -1;
 		}
 	}
+#endif
 
 	if (!pkcs11_cert) {
 		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
@@ -301,6 +305,7 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load x509 certificate */
 	if (pkcs11_cert) {
+#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
 		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
 							 ctx->cert_file, 0);
 		if (ret < 0 || obj_list_size == 0) {
@@ -309,6 +314,10 @@ static int create_auth_data(struct auth_context *ctx)
 		}
 
 		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
+#else
+		fprintf(stdout, "Pkcs11 support is disabled\n");
+		return -1;
+#endif
 	} else {
 		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
 		if (ret < 0) {
@@ -320,12 +329,17 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load a private key */
 	if (pkcs11_key) {
+#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
 		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
 		if (ret < 0) {
 			fprintf(stderr, "error in %d: %s\n", __LINE__,
 				gnutls_strerror(ret));
 			return -1;
 		}
+#else
+		fprintf(stderr, "Pkcs11 support is disabled\n");
+		return -1;
+#endif
 	} else {
 		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
 						     0, 0);
@@ -403,11 +417,12 @@ static int create_auth_data(struct auth_context *ctx)
 	 *   gnutls_free(signature.data);
 	 */
 
+#ifndef CONFIG_MKEFICAPSULE_DISABLE_PKCS11
 	if (pkcs11_cert || pkcs11_key) {
 		gnutls_global_deinit();
 		gnutls_pkcs11_deinit();
 	}
-
+#endif
 	return 0;
 }
 
-- 
2.47.3

