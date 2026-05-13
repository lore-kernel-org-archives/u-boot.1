Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202BFCD484C
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 04:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D96A838BB;
	Wed, 13 May 2026 06:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="hwsbhzfy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA6B83CD3; Wed, 13 May 2026 06:45:56 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE2380F0E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 06:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dY4a2kGdzQha8ef1ko3PazztLwJgqVEPwrfe2xB0pj4ApqM3kH1FFKPD12w7t372qYqGfuALJzeZdm4tTX65wcji0A1WjJTuyTOuD/2NsYR9omu2zsiksqy8sT1w2pYjdljJhsRwATJltIghy9zZZ5d3+rpw8J2TbWIwyxFbFKRh6ejuMJ0o2iKOVn2QdUlo3LADtzbeCDne13UG7rWJ4Sau6sTxya4bjciK53uE2m0AB/QEAsDge5/W7lhb1tNCdUoTnIqWgrPUxdr20ujxM2rllMinSohZ55PUpjBlmrALoZM3wD93mViIMcW+v27spWxQ7eYTfK7WTBj90G3TqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RveRl7AshGSVwi0Mm/tQxLU4Mh4/qUMjbBOBfFNDHJo=;
 b=IvUD3uj69cqEmFPHoKn84QfipTfj6MJu2Ey4w6aCpT7J/OtVKoyvHFqjuG7CnOj1sYMCxDjVr3DJkrMmSdzSXKmiOUK+tuwsqMOTADAIvBNfYwKhgiGoZrMSTALkJ2V8K9V9ThI6wDtglDN8gUfF8BQ0+GpBSrp4WbK+KR14n2QrbCAJ8cGTYJ5uEd6RiUOoe6lpHxP8xWDf4yyCPswROxEL0QHOgi17BWsymOmTOi11uZUCcGLPfDwL/5YdtxdTRVbkBQEaMOTlnz74swLeSoxnZiReH2SlV0ZH8J50Oz65tgkFDKzObkc57M7G3n8h/Kc5LCa9QKb+ZcyfFe1dvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RveRl7AshGSVwi0Mm/tQxLU4Mh4/qUMjbBOBfFNDHJo=;
 b=hwsbhzfyVAq21ynM4IKEpW31r/5a9isYBAaEkEv1rX+a+NfsxfijhvGExhl1+Oc1Zqk78oCVcZnjZPXf4XnFSniZJwQONhv76H9vPDs9yhveJTHIBH4ojO8lkv/tKC6BbMgXFglvtWlXLd+QN9qTOdQERyxO+/KCz8TY2OL9fxlANAEPOu8lsZhItk9HOwF6Z9Y96MSHC0rT+F/3/fDNGH9wOTKYtObDgdoVsKGUQwVlRg3CJi7m0At9ajqBwS6OL7w8YsuRSv+uxQaEdHAWUk1ZekZUfg3zwqGulAWqj0XNX3VRHfZXSRJL8Gxl8khVG56turUyA/O/sqaNtPPaoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DB9PR03MB8775.eurprd03.prod.outlook.com (2603:10a6:10:3c5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 04:45:50 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%3]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 04:45:50 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4] tools: mkeficapsule: Rework pkcs11 support
Date: Wed, 13 May 2026 06:45:35 +0200
Message-ID: <20260513044537.22773-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0093.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::8) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DB9PR03MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e4838f-2e40-4212-dabd-08deb0aa8176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|1800799024|366016|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8jvNt/Wc8izYCT7x4pHqtmYnpRUAbRNcdyNouof955MIQFUHeKAf3dqR5TFHNnQhSpGybSB9IhUADaxQUwlmB1ncyIZVyAr55GxYo6oZ3hBPqPW08+mElcxYVdZBXI6ArdDrd93T+tc5FlJ2lgHy1brfW7TpqtXE+EBGXgqVD+4hWvLOffhHR8Wm6cJQsUGHnXCpiXdNpCsCd4OJHNMEc4Ye1jf2JLW5JZiUzNAbUji+nmM8GLNn47LP1AtkAENHQTQW55ODBp4RfDS/+qE98vR4aH3OET7nzbPxXtUz0Ni67XhnxfGs1mexevVcr8p+0uGnKEldAt33W6bRGbORcLAdpnKHGF5jsIwgRslko5E3k9kAtT1b59einZ3O63UJ1ySkuuHPLkJvuu5AnqeeXBY3j8r1uaNgDx+BRTi5rOYCX/p/YYZ06u6TU1jb6FfBsTkc9vqTPy6//mjfBMlcLknQMpS+YP+XirvzYbRbixalIv2RA6/AABWDiB41bhZ9aV3vZybPVazgkzsbqMPPwj1eo2pOBRv+ydz2S8tRM53Cq7FYgIxFsPxqbD5/wWTJPtrVTtYOyoRmHGAazyRxmvFxjOkvAPXgmQ9C8vvQ0BVD98oT75yMFcvk5hzOpt0xhH60iHopJS77x7XB57YRpswBpoUC3Bc6ZMizkFoi/C7ReOqmdp2nZI2YZxw3Vepo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(366016)(10070799003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMEItVhbMy3E/dD4ZzovRQSfkBLpunYb7q65DUmhmDt3vQoLK8hfUkqMUlqt?=
 =?us-ascii?Q?wR0gGQujSgKXGj3ON2l9ax9M5x8l6m6IlUy3FrF8RWA6zSVPdGGHusyVZLxd?=
 =?us-ascii?Q?9ZSO+azUBUV4zQ8sbM+RGzKZ0PX1ZcQpYcGzLwHaysX8RVwAMA4PW8nHyjiS?=
 =?us-ascii?Q?GRzg/zuz5XmS0SrCIj//q16sj0Gp+Ofl+XjLj4b7ClvN0VLXEFiWpp7ZA3dE?=
 =?us-ascii?Q?icIr0s4J6Yzsa8baZB5OrWRqfsqbmFGxLud8Xizq9W19nxjwAfPxKACYu9NY?=
 =?us-ascii?Q?u1UmmKMQu/l9murJu/ODENGDkOkFFDOFgmNN4QTLvOhDSiOoQ8nihk3tUIcn?=
 =?us-ascii?Q?rETNalS7yyJ4RN3JsbDAXE7yQzQaHUx/P9SXKAUQc9efTD5/c1YBnQIv0Xa7?=
 =?us-ascii?Q?Yg2sGiUwNRc+tAMoFEjXP+f2+YgmsqYD5K9rCRI9xekRGPXKMXRGvvuDLcwk?=
 =?us-ascii?Q?8B8/jw2wqlYkNbFLZFerNB3Dy7VVvQvIfb2s6U4J7wefmla4GZWD67/9QWVY?=
 =?us-ascii?Q?iyhvHcFCaYcZmd8nRRpKTi9F+ZvYnBRecU6z/M3j8cnn0FFzy/j1LcHr9W3K?=
 =?us-ascii?Q?eTHhJFPEsPgkk2gDyJAEzOU0XoDlK/e7l5btN28IMkfVGaS/ZSPe8GvuXDA+?=
 =?us-ascii?Q?fUS/ubqDTpETCXp7eIVz86bCsFWP13wMoTV4oS76M0rWwHjhlDoBBm2IzLuB?=
 =?us-ascii?Q?GHBfkLlWubV9NKP0Gway7l0wrCC5eXhtr8tuaEea3MuHlTSUxJVCPfxGwkjf?=
 =?us-ascii?Q?DtPosRwqgJC0HC1h7UBu0eIy1+wGKXJR3ciZ9kHwmxVKEAIXSBpbR4BIaUvw?=
 =?us-ascii?Q?PDq747e5/niw0WjXECJDlElyA5S7wh5VkR6exbneCGCfgj4/6fN6on3Cyo2M?=
 =?us-ascii?Q?SM6YnqmYcV482NT5y48toIeEDY41P0CLY8PBh9KWaijmtx7NpnpWzjc6yE6e?=
 =?us-ascii?Q?a7UUPUbtAJWbidZNgIDNcvjMwxH/I4uyu9pd/Uy2W/4zhyUtgZgDPmHjlsqa?=
 =?us-ascii?Q?UMo8NwNTA9ztxo4EF6iJMsQPYnnGRmXtYL4n+7AHug5/zKwK2DB0aa/bxG+/?=
 =?us-ascii?Q?x6TYQAeV9LPMUubkmKOlDZbpF821jhINA6Ml5VJcAHrqIAEcGRyF4wVfuJRM?=
 =?us-ascii?Q?7vEarQ/hJIZ50gfy75bAMGig1Tx/8+27PioI8h5wT40CcrZ5Q0tkEfq6Pv2D?=
 =?us-ascii?Q?Rhgx3npQUsAac5jci0eDLx1LCGCPmh75lu/cJZKTa42/7ecFhV14U/YJIpee?=
 =?us-ascii?Q?5X8t4b+mFVvmi45tGByGAeXIOLmNKhrZaLAUMSWNJd66OqvcZ9iI45IxBhT9?=
 =?us-ascii?Q?QE2bwfzw+Znx6zcpc72reKfew4RdyRqcTjaQpBWaFuupxgiccnRvCpmAbo7w?=
 =?us-ascii?Q?Abvllerq6uJpJ2abaVjfPj3UM/+UXsyFsjsmAj+qXlubP8Yhf2dt3/aHIen8?=
 =?us-ascii?Q?u5MDHNVDUnuhOLxr7BF7FLhAfdX+M5FfPo7lthAGKi7XINMo5VFMvZAdNlNF?=
 =?us-ascii?Q?ngqdx2edW5SHKPzqFDR8aBYraLoDnPXSN6/CJgnys+h+HqO10Bz9HoZhX+mw?=
 =?us-ascii?Q?S1R3eEoP8+4zdqe5PAviO1LWZi2LHvwzkMa9bxIihxo/xExFJ2+FGkRoDrzq?=
 =?us-ascii?Q?VcTWeZPXizJNyQimXoKpzmNemi8UU8p8axzVZu6l77Kf+YKT3iyWQ2cINd9c?=
 =?us-ascii?Q?FUVbXba4XQ7aTZRLYtoFUjcpVf6SqTjOxUGGFzrwQtI1IbVZb77O5aJrbH1D?=
 =?us-ascii?Q?EhGkiNzZ0CGuIib/oXQhVm5sjrP9WaPl52uVB6C/RAbTtErJkQUWCbs4sTOi?=
X-MS-Exchange-AntiSpam-MessageData-1: Mz/aMIliiqBHLZMh6Qi9lv3eSVqxu/wCYm0=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e4838f-2e40-4212-dabd-08deb0aa8176
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 04:45:50.0312 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUrTIRfuzCvOGy5J1SMy0uvZS7V8Hc45uBbepAlHdV0hBMjPUNizNB4AI+tGBEb9Pmb+2S9dmFtnz9hwwmTCdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8775
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

Suggested-by: Tom Rini <trini@konsulko.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v4:
- abstract pkcs11 init function
- removed unreleted cleanup improvements, to be sent in
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
 tools/mkeficapsule.c | 99 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 81 insertions(+), 23 deletions(-)

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
index ec640c57e8a5..132bba286e4c 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -207,6 +207,75 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
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
+		fprintf(stderr,
+			"PKCS11_MODULE_PATH not set in the environment\n");
+		return -1;
+	}
+
+	gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
+	gnutls_global_init();
+
+	ret = gnutls_pkcs11_add_provider(lib, "trusted");
+	if (ret < 0) {
+		fprintf(stderr, "Failed to add pkcs11 provider\n");
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
+	int i, ret;
+
+	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
+						 ctx->cert_file, 0);
+	if (ret < 0 || obj_list_size == 0)
+		return ret;
+
+	ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
+
+	for (i = 0; i < obj_list_size; i++)
+                gnutls_pkcs11_obj_deinit(obj_list[i]);
+	gnutls_free(obj_list);
+
+	return ret;
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
@@ -229,9 +298,6 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
-	gnutls_pkcs11_obj_t *obj_list;
-	unsigned int obj_list_size = 0;
-	const char *lib;
 	int ret;
 	bool pkcs11_cert = false;
 	bool pkcs11_key = false;
@@ -243,19 +309,8 @@ static int create_auth_data(struct auth_context *ctx)
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
@@ -301,14 +356,12 @@ static int create_auth_data(struct auth_context *ctx)
 
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
@@ -320,9 +373,9 @@ static int create_auth_data(struct auth_context *ctx)
 
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

