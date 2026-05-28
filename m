Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC92CD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 08:04:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 594E0803C6;
	Thu, 28 May 2026 10:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="p4vMyaJF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2B03803C6; Thu, 28 May 2026 10:04:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2398880087
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGprM7M0MO28AXnLg+UuVd4sIYN3iuP6Qbd5NAjIfSplh/VcVmvvTVtcNNWeNluxX2lyiW3PYlIpksPcmfryzrtDToxcGUbTU/HzW+aX+j/E4bwelBhzUr6AN5Wd4pRB72tQYvCkVcUBxAahqIO6ZRoqgQiBAPpXXF3px+0BJVHPXrQxZ5omEJ5SE6E3qHTu5SimdgSrfMXyH5e5Q+jIjLq/pucqlShg7hTv0vWoCzKpUv8WHr3+MwSlzCeR4PuopwuKVEwA0eX/xHIqlF38sA48yKk+njLHluZqhSfsyDSa8Djm5Xhoph9HZoRccErECBoVrIC9eXlb1jYv34fgFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFvpPbyKVIZVSW6kypbWueSf6k1eHsP3WgiWXEY+Lzc=;
 b=qQbyC2ZNjT3RzEsE+dh5kdOCwMpWp+qThYLweNzbtoVQ8MB23sKL65i5M8mT2oeVwuzXh//4QFesFOwSItVFrSIRBgl/MvgqAZMySkLd4HqP7wTSGafR53P5tqLDKugL3d4aNLk0+F1FU2AtJEdaz6OiTtR+bFsqm3Ld4xqT7n+nFkJfC1NHbnn+Gyj5/EJ5TKus7hx+yJ8Pp3BOGrB5ArWCtsStqkRCeqHbZsagZzoMOpaBUZM67ise5LeFTH6a8C66rKgWz5P1Vt3ERld6JM0WzLBOuxN8bR63O5rh4FgsVPPf4T8q8kcWzBQcg2Toe2YaXQf1lRkPdCFqZHgFtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFvpPbyKVIZVSW6kypbWueSf6k1eHsP3WgiWXEY+Lzc=;
 b=p4vMyaJFBypjDzlZRaITS6g1qGmb80w8Fl7gZSIm8mxFIVwtIIFECdZnbEaJHmUR5YueFbK8LOsAwFaxaDS57K1BWyQmH1fjn6kqfy/368E9FjOe0iGpdv/sbHS9QoUaN5V4v/QSEI8VjTTJPCr5Qa4P/9J57Sv04ZusYhBCG8mnuwBkHJ9YNFxHGkv9ESgVHLCSe1MLJQMCDm38Xog78nZJQan/1U/nUMH4sxsKtqaVi+d4CMmkqDAfECe7xoUCrhdQB02d2wNjxUdF4gGgAn09Jd0CHi8qI8Sx2OD5hvMZxD3wvS4HcS6fXzzYYl/1R/ga9KqvCjy/nGM+0edMzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB9842.eurprd03.prod.outlook.com (2603:10a6:20b:619::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 08:04:00 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%3]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 08:04:00 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v5] tools: mkeficapsule: Rework pkcs11 support
Date: Thu, 28 May 2026 10:03:54 +0200
Message-ID: <20260528080356.399082-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0131.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::10) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB9842:EE_
X-MS-Office365-Filtering-Correlation-Id: b1f1f1d2-8ba7-4372-9c3f-08debc8fac73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|19092799006|38350700014|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: CZiweY1FbFqFU2Mqk7TMV9cUqqaR4mHQYfQC8F79/gnYyBUPohI6PceArqxT0kBG7bSDr2/fdgKzFxhyd7b62vKbukcbwWpitBNC6Gs/TFGEjghxfevdHpDzXRkz6VaU1/0ZHt0DfYC0LRtxLc7AdJas9gIveZP2cW+g2jOC+1qZgFiMYIZARtXkV2o9sUidqFutcc1rWLZGLIS34kBxtjef5PQZVuatDPZ66tCdzTtvlG7Dj0hHWuEdfCTu9YsC9qlELoZLmKHP9T+dKpFU1Bn1kqob1DmizEBDVyPkcZabKolx0p0tBPLk9ZDBAKLc4Fpo5IfefMwIjH0CsqfpRLhte0f//cxpDj5wfPqbFcQs1eXp04+1bm7Pxa0zhg7Ij9ZbndYKxFrPdXxowIzg2J0aB8sWHvWdmImCL86dyngUs1rWqVKpShEoXAtXumr3/3nPMFpDQaNT9nXGfPUHAksd6iIOmdcLkJUmwUY27nOemjiuSByMyeLYJvUwo1EZmcJd5V3vlWPnliMCWatLHSSm645wc81eGQXduocOY/GhgiHbtbQ+7Fys+EwGOosq3O7bnS39QCwRE2+kSxRvcwGOol2w/CCr0tRyJ1PiGMr/7aHLUMO9tT1pCcX8E4M0OiH+7P66RrR5VdJtPB/qEmRpfNzBm4snwy6P7NHgoLF1quSJCcOiYDdECjyM83Fo3FU3KR18kzBocElH8LOKUeWTW5w7vzhlvkv7P2jqKldkW4VFKTEO9iMC4GDcUuwq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(19092799006)(38350700014)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ed9t3Gh9kW0TK0b3mJKnR9b615vSl6VV4dahm8fztWidIiJdjw0xyzzT1DO1?=
 =?us-ascii?Q?wXfghA3iuzTWrK8Hcr2iXAq4Y7lK7idu4R2j+mYKds3e1PB5fAzksJwascM3?=
 =?us-ascii?Q?gasXgO8hm2cR8/Ko2echh19OphtguEvxxC1oc5KUFBxPF7i43SvOFn1n2gn5?=
 =?us-ascii?Q?DofS3iDCJbr/JPTrtOQmdw7MHOSxp9nF64YCYaw+8F/g3A+FNP9uReXwzsDS?=
 =?us-ascii?Q?/dEC2avqYdjp48hMthu+RgKsXb2Mnudwxx7iaxyqNwwHWsMfVI7iNfrb+x+w?=
 =?us-ascii?Q?09DmTm4XKDeJsNEv8uTyN3XdNApDfgMYH8o/LjXpgBBL/gfxnox9U5ekOrCE?=
 =?us-ascii?Q?u+Ro4ZOggVxwLHW0gKcyQBLj4UzvKoQ04+uwIP7pCB4v+3ziCytMfVC76RqR?=
 =?us-ascii?Q?oZtaHghEI0v9F8gJyfOnaaC+V0Gr2lImat1oH7t7/+VQShGqCca/gPuB5jye?=
 =?us-ascii?Q?hV6gf9i21nouHcQOu/1IXFh/n/WJEvzoc3p/Kkg5G/d1dZNFlx6ZVYnwJQXE?=
 =?us-ascii?Q?BhBxhdMXw6GgWPUxkpSV5LIzL0BcCjE9PLyaHhuZPh3RQwT+s7HyA5aRKXBv?=
 =?us-ascii?Q?MXgq3XTiWSyyIPsJD1VYKtnB86Psx0PP5+FO8IAfC5koPtKFOXSz3BpIf55G?=
 =?us-ascii?Q?DCs5tr6rpsK/nlOZXmKs4fJbLi/rm/pWovWU8aNemJMyGzo9ucWAruPWVBYP?=
 =?us-ascii?Q?5vCZBsblVDask2GKZlIMJ3Y0eKgea7pdZQbZqayIf9NTgFoKuBWpuOPJpy8D?=
 =?us-ascii?Q?zVppRiWExcScA2tg0/tBcd33czNYV4W4ZEm7bSJwl9sxvEsjVCm6KISadkgC?=
 =?us-ascii?Q?CX/JEkmOAPzv9xcmsTdix1aUSXTdMX0mwfN1x2ka2sO96NaOVf8i3ITbPgQ4?=
 =?us-ascii?Q?OwGPL14eOsrddTu/2CBRvx42jgM2Db2qnEySy6Io7SVvFGPhlmnfx2ZzrV75?=
 =?us-ascii?Q?6jVOyxWAPVdx2tIRbINvGRc8S4y5EL2uqXIVF252SRlC5u1dCVm5SYj1Dkgf?=
 =?us-ascii?Q?zwe+SWY2p1bJrHcFKiMJhYb+tPy/MXc2Wgf4CnqTGfdhWf4VxeH6lz1hywnW?=
 =?us-ascii?Q?4w2JSU9NmqhAPvWKntLJjEf//yMPIJlDT/jRwtB0kiDwfVZFIGU/+d/QdE8H?=
 =?us-ascii?Q?KQvuRkQkwl2xdoYVtqKxhqNLHs1egw31aK7yPqf098TyhjQ9FRM8/soDzTPZ?=
 =?us-ascii?Q?jI8oVL8ixTVTEmqo1M/1X3J/O5FJqX+X2jSIizGG2NCy0eRjl47eVyU1sUUU?=
 =?us-ascii?Q?w9WrfgwS44ohAmqanp8HHF2YROnicAQ/OfQQ7JZiJlhjE9BF/fJsbgx+/oDU?=
 =?us-ascii?Q?PVF0yoW2gw0zXc+2oxVR9CMManHrHVTimfPgTI/AT7YZM/Dh7J1jrzNWEEhj?=
 =?us-ascii?Q?j66zCDdKVsOH11NSASK4UIoan/L+R5R00CdK28tw0ewn9L9Jq5kSbOn8TIxC?=
 =?us-ascii?Q?XnJ/T6A7oHzTnxTfvGbSIMFTJ7I+xL68SfbiInyy3NswuRJ16/HmhknL+p/v?=
 =?us-ascii?Q?GV1s5oDX/cQ1b6+6cb5ZH8lOvrusHNNv/sry6FcKDETA87b4plVFMsEekA4X?=
 =?us-ascii?Q?ktE89Q8tzHnVb+zTzqxjpdflX2HuyPkaw4WAn8h2SGKPNoo/YYq2b+v3Pq2l?=
 =?us-ascii?Q?yoNAM8/77s4k76LQ3bT+yA9diYB0RNgicGEKpn/UXXZBZeO79a9m7jNi0m1y?=
 =?us-ascii?Q?WgBBXMQrE+L7I18WKTGXKROVKJlyDiJzIo9uzCq6dpT3b/5pxwfmWZ5K+twC?=
 =?us-ascii?Q?/BZ+sB+35g=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f1f1d2-8ba7-4372-9c3f-08debc8fac73
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 08:03:59.9452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L7Eopz5CheO+a5vITb8C2NB5E/uuo0ZucFRMHxvQnPabduxGRMR8DjHsFvpbh9kWVk43BhjvA6bOo/wAXpyklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9842
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
index ec640c57e8a5..a36332567e0c 100644
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
+	ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
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

