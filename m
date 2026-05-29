Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E362CD6E4A
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 11:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6558484671;
	Fri, 29 May 2026 13:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="Jty2dEEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E69F846A3; Fri, 29 May 2026 13:05:48 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F11844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 13:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oapbk2UKbjTzCORMiVRDpPmw08f3CxcWcnepq6mShYTtX/57+4LdWmu0X6CK4QzgIvjRX+gxM7h0Pd5JhhskHuR96PU59TGa/Og/nnsAOAB4eBlaylJ/eMOdtDvAX31/Xk3hjMtPJgfhXoBpQvMbCUE7gM97g1BoVp1BlVeVon6F1meNyUROtwFzX+OGKtzFs2NIDYNRZgNjlhaEgvqkkP2FmMzIYQON5reIB8uGcZBvc5Sga+kyOLc6xEF1Jsieyp0OZlqz7A4qc6laRCPaepZZtcp9U0a2PzJ3qZz5SPEJMZJ2T8sft+5yODJ6R6QCUh2rkt35NNRhQUUG8D14ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbQHaJM+EJApczPty9Ie141cxU06/f6EkfiLktEWXyQ=;
 b=Xi0wMPZWsr70bJy08bWNoYhJqpacLc3yDOAWVXHOeT475uMpYzaRtwWBm3Y7KwUtNOl+DukyGb/LsAYaEsZz3UYT4CHJHdTmxj9wHQsJJFtIzlttSCGclL2dI1yl/RJJHTzNq1HZpu5754tb6VffVUoRFTMGFH55hzL9seG7KhWQ/5vD95p3Hf64jesV1MxHrSIugCZBxpLFAi1ycCPPD1wYoxufLRp7kMl8/W3TVkvUvo7r8/2WtXTGQxOjdnkAsMjETQWunjNjrXjJoPHiCjAgtuArxwWFR5PhRQZgAdXzuJ47qPyQL6TOFIIvqxrVSlHh5anLQ8HQ6eGINk+Dfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbQHaJM+EJApczPty9Ie141cxU06/f6EkfiLktEWXyQ=;
 b=Jty2dEEcihdHBn0u3DAeHrEDXQeFwvH0xK0YnvUxkplOOu11cI+sdLRE+n91OkrobwJJjasw4IuTjVk921SY2C7Xdi38UVCVppnrE587sb2TCArKhQfyq2aDD9i4mfOLA2rqGCVnN2wbqwXCtd2TFoT6oYXD1mago1AmEwqR9TpN4EHQnamrx49/Uhi8rGrUxD16CwAzcoJeBNHRVywKqYtx6kBCe1diMGogcDowRwhfZeUs/6FR4TYt6zT57+4NC9acl67WXvaOpiC3yUuC/xNbNyQbtaHlpCL3zxKNR+pw7uBAARcUIRKQUGnljm+Lg/Deew71RkQVd6dH4SComQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV2PR03MB11375.eurprd03.prod.outlook.com (2603:10a6:150:352::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 11:05:40 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 11:05:40 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v6] tools: mkeficapsule: Rework pkcs11 support
Date: Fri, 29 May 2026 13:05:24 +0200
Message-ID: <20260529110525.22822-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0086.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::16) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV2PR03MB11375:EE_
X-MS-Office365-Filtering-Correlation-Id: a947de58-ff3d-4a81-7371-08debd723854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|52116014|376014|18002099003|38350700014|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: n8/QQttQwZjYHzUqVp0SQzFoWI/zM8KXi5GK3xk248YyWS56n+GvqtVH+3uvR2w/E5fzjkrZ7y+ENg9QCMlMA3R7Enp69sEk0cvnn+BNyV4J4Wr6O51GZ2VDBPTew95JAucPJ6RpY34o0mrh+zoKTs+nHSAhW+n+YylFI3O1gXruRzWVY8N+739xQWinq6AwIWMSZPc31QLubHOvx5XW77TTNw4H6YsBmcTFIWFg9YaKnpQ7dpT64JvKzOiXR5XSDak/k8et9pbJzQtC7Rgd7MqxI4m/wZyvSyvgyudJc2TuPwUtvTWdoON+NspqYfVXge28yl6J211H8CO+G5lJcg3EaRBY4ZfR0RbozvaQnNlGei/YtU2R3k5fX7OkbvnwYcB9KUNWepshqkvi10cHu7g3NtgrRo/LdX2fSczO3Tz6/pOLMmCUUz3Gv2SUKFjIHyU7tekk4d0Cp0x/v2yfzPAv6oJ98OgU/rZXR0MFrGd/RVetTvibDXHA9rVMvI6iFmMDHrYu7CXfEdeRJuUpART5Tksf6Eqei8OeZmBJRDPt4SV0XpqCQ6wzDskBPgbBF8Oi+sDSc8rxS8873Zt9eRUzr8n8ZkjcIO33xnGXwvcuVSuVNNXr4+FL113RWw472IM7w9DelrN5mVAmCyqLiFCHV0Y8uh60fYOAL+ih7jbmtxX/YXw7M0W0bp3cJEwr8LUhplPEyv322wYuPhayFMV0ki4dVDm4HNLNLFosKSdj7dlt7bC45vg7/Cr/VcxL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(18002099003)(38350700014)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uze5e+tKXd+UUwzwY6zU8NkkNMgz7dFGpk9flyMe+ENDbdWrF1RCI0e+dVdk?=
 =?us-ascii?Q?VPluNBWBYuxgq9YdQv4V7SPJp4gduOOwDj5o4rAbZQ9lviUv1UL8pypwnwlX?=
 =?us-ascii?Q?tapVDw8hRimrnQm0p967mIg8MlULmP+0ynLOFEFvrdZkLn+U8Z05fo6EHiEB?=
 =?us-ascii?Q?o6dvlvNvjceJMi3TIlLZwsfKAk4nZ75BbewJIMw3+FVsMpNhXefw67OXQHXY?=
 =?us-ascii?Q?l0dJR7DoODL+Wgc4mbOm0D+XcegXdgKACbHxkPGNlJTbSakvUqJRqUi5lQ/Q?=
 =?us-ascii?Q?D3cvj8pfuTM3w9LoDSRz23kFwRcUjDi3a0FlENXBH64BqJoMUF9LciZwusai?=
 =?us-ascii?Q?OeyErYsFQxCqwYLTJdbfkB9vSNukewEVN1V1VXUMwSzENdKEknow+8O8ANfO?=
 =?us-ascii?Q?W8jr5bSsD799lRi/DzeRCC7eisRqblx2rC4vz7KbAOUZbDyOd5sPsfIADxh7?=
 =?us-ascii?Q?LTdvNEOWlS4ZdXCTXNitBKTAJ1Hl+xtjnRYit9Zpq4k4DWfUOerbg8PLiynR?=
 =?us-ascii?Q?puci5NP2EkDJvhqmWwCVs6/xhNKHKVO8aydvCO4MIAhn0p2GjbaJHBQfHdc2?=
 =?us-ascii?Q?F74KB1PasABVB+AfPVP8Lm8H8E1UEPT0CBUWmUp3zMEhaSRpDmBn8vyCZeEQ?=
 =?us-ascii?Q?Sq2QPW4NNkeMUpyjKlAo1mPosMnfZDYdmhwBcTkeqh8sRrBTWh5+4oYcoGe8?=
 =?us-ascii?Q?T5A1ASoB1RyHEZshmedfpD5rI4T8le6z6FfTYb/MSVPE77rtSaFdSScqdWUl?=
 =?us-ascii?Q?dby+HNdU07R727B6veoGOtQDLU6ylsbb6XouhGYNt0PYqNyayfvFxjQjBPRy?=
 =?us-ascii?Q?GOYXi7OXw5rit31o2eHPVwrtyO72PBhUwgrSn5VeMrEPzTl4GNtHlv8JkZ4b?=
 =?us-ascii?Q?f8oIUGhxaRHmEVaTAA/pxTeuj2TVNzUDeGrWnE7mgaZZIlBBRfFdX6WK6U1A?=
 =?us-ascii?Q?EKn//AwCdnhFIJ9tbpMLacc4rhH3DwseCe/85MotYvJaTXR6Yifp5qrEX3UE?=
 =?us-ascii?Q?gNcACjWidIzuEJdpuAGuMfbAPpU0vMLjMZiQVXTzo4i0ofuS/zCaeNJOvb4p?=
 =?us-ascii?Q?olzzK/XFOzIekZej0OHedjcPgCLKS80W9TcyoBbkpDz+OlB5JPnxuNnzaldK?=
 =?us-ascii?Q?SSwzGEP4r41455P5Pax25W8Ud8h1mf2+4e1quXiG4LcDlz40y0o49HLvbldT?=
 =?us-ascii?Q?A64bMSrtd0f3UCvJH6O+iusLxmHaE9Ftjn/8Z9e0wjypC8KR3Of5wqzSiOUX?=
 =?us-ascii?Q?kf1oiC5hBQhIHEjI0Em/1HcJ3gJHKsDy6JxxFVbLhNkWkDKB6+XSgCHuFEh7?=
 =?us-ascii?Q?acPQgHaD4RBnAOzY4GY5UUWF9jwS/NBS0yRd2vy4J5D074Ea31wgYjo1gOUz?=
 =?us-ascii?Q?RSvJg/3jpGl/XiyUfAvxNqcw8s8LFdBcr6lxwwGBl0X9Vz+7eMCnygOGA6/9?=
 =?us-ascii?Q?/HjbQqzp+82m+uUCw941nA6RuOvJp8jAUZA2r7pgR3lvUYqdOmSUMywAa8dc?=
 =?us-ascii?Q?cL8JsQ7a51fH58cGljTw3gYRO95r42aO4KJ4jOCHUfJu1B6JsdNmPBtSnccp?=
 =?us-ascii?Q?WOkLlbFeA2kibzz8kkzycs+KztuMh5rlG8w0+3psKsmhnXEblcDCUnYHWBzH?=
 =?us-ascii?Q?zQn7d4GfBEG6RHXDoiTS/+6r1cIxMsnn+Jjh0142WMLQ2TPADRygwq40RGlI?=
 =?us-ascii?Q?Dkn4QptvJkwLMV7WKKtjKX5v7LlV4PYvq3porQbbyJWGP+623D0DfVUNGmZQ?=
 =?us-ascii?Q?BL5KPzilMQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a947de58-ff3d-4a81-7371-08debd723854
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 11:05:40.3951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwrEWJxDJr5JgRzoDpoAUhtaraknPDnK7I6IlyLoFWl2DHCEJ/GJirLhYx4Rjz2P76CTkiZJfcEVz6Ulm4/UDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB11375
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

Some distros like OpenEmbedded are using gnutls library
without pkcs11 support and linking of mkeficapsule will fail.
It would make maintenance of default configs a hurdle.
Add detection of pkcs11 support in gnutls so it's enabled
when available and doesn't need to be set explicitly.

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
Suggested-by: Tom Rini <trini@konsulko.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v6:
- removed return code check from gnutls_x509_crt_import_pkcs11
  sugessted by Quentin, to be sent in separate patch later
Changes in v5:
- removed more unrelated cleanup improvements spotted by
  Quentin, to be sent in another patch later
Changes in v4:
- abstract pkcs11 init function
- removed unrelated cleanup improvements, to be sent in
  another patch later
Changes in v3:
- remove config option for pkcs11 support and add auto
  detection in Makefile
- reduce amount of ifdefs by abstracting import pkcs11
  functions
- add missing free and deinit functions
Changes in v2:
- make use of stderr more consistent
- add missing ifndef around pkcs11 deinit functions
---
 tools/Makefile       |  5 +++
 tools/mkeficapsule.c | 95 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 1a5f425ecdaa..e85f5a354b81 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -271,6 +271,11 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	$(LIBFDT_OBJS) \
 	mkeficapsule.o
 hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
+GNUTLS_SUPPORTS_P11KIT = $(shell pkg-config --libs gnutls --print-requires-private \
+			 2> /dev/null | grep p11-kit-1)
+ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
+HOSTCFLAGS_mkeficapsule.o += -DMKEFICAPSULE_PKCS11
+endif
 
 include tools/fwumdata_src/fwumdata.mk
 
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index ec640c57e8a5..576903753660 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -207,6 +207,71 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
 	return 0;
 }
 
+#ifdef MKEFICAPSULE_PKCS11
+static int pkcs11_init(void)
+{
+	const char *lib;
+	int ret;
+
+	lib = getenv("PKCS11_MODULE_PATH");
+	if (!lib) {
+		fprintf(stdout,
+			"PKCS11_MODULE_PATH not set in the environment\n");
+		return -1;
+	}
+
+	gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
+	gnutls_global_init();
+
+	ret = gnutls_pkcs11_add_provider(lib, "trusted");
+	if (ret < 0) {
+		fprintf(stdout, "Failed to add pkcs11 provider\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
+{
+	gnutls_pkcs11_obj_t *obj_list;
+	unsigned int obj_list_size = 0;
+	int ret;
+
+	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
+						 ctx->cert_file, 0);
+	if (ret < 0 || obj_list_size == 0)
+		return ret;
+
+	gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
+
+	return 0;
+}
+
+static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
+{
+	return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
+}
+#else
+static int pkcs11_init(void)
+{
+	fprintf(stderr, "Pkcs11 support is disabled\n");
+	return -1;
+}
+
+static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
+{
+	fprintf(stderr, "Pkcs11 support is disabled\n");
+	return -1;
+}
+
+static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
+{
+	fprintf(stderr, "Pkcs11 support is disabled\n");
+	return -1;
+}
+#endif
+
 /**
  * create_auth_data - compose authentication data in capsule
  * @auth_context:	Pointer to authentication context
@@ -229,9 +294,6 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
-	gnutls_pkcs11_obj_t *obj_list;
-	unsigned int obj_list_size = 0;
-	const char *lib;
 	int ret;
 	bool pkcs11_cert = false;
 	bool pkcs11_key = false;
@@ -243,19 +305,8 @@ static int create_auth_data(struct auth_context *ctx)
 		pkcs11_key = true;
 
 	if (pkcs11_cert || pkcs11_key) {
-		lib = getenv("PKCS11_MODULE_PATH");
-		if (!lib) {
-			fprintf(stdout,
-				"PKCS11_MODULE_PATH not set in the environment\n");
-			return -1;
-		}
-
-		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
-		gnutls_global_init();
-
-		ret = gnutls_pkcs11_add_provider(lib, "trusted");
+		ret = pkcs11_init();
 		if (ret < 0) {
-			fprintf(stdout, "Failed to add pkcs11 provider\n");
 			return -1;
 		}
 	}
@@ -301,14 +352,12 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load x509 certificate */
 	if (pkcs11_cert) {
-		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
-							 ctx->cert_file, 0);
-		if (ret < 0 || obj_list_size == 0) {
-			fprintf(stdout, "Failed to import crt_file URI objects\n");
+		ret =  import_pkcs11_crt(&x509, ctx);
+		if (ret < 0) {
+			fprintf(stderr, "error in import_pkcs11_crt(): %s\n",
+				gnutls_strerror(ret));
 			return -1;
 		}
-
-		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
 	} else {
 		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
 		if (ret < 0) {
@@ -320,9 +369,9 @@ static int create_auth_data(struct auth_context *ctx)
 
 	/* load a private key */
 	if (pkcs11_key) {
-		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
+		ret = import_pkcs11_key(&pkey, ctx);
 		if (ret < 0) {
-			fprintf(stderr, "error in %d: %s\n", __LINE__,
+			fprintf(stderr,	"error in import_pkcs11_key(): %s\n",
 				gnutls_strerror(ret));
 			return -1;
 		}
-- 
2.47.3

