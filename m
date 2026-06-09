Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F802CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 632FF807C4;
	Tue,  9 Jun 2026 09:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="pSvST2hS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8185E838BB; Tue,  9 Jun 2026 09:01:19 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D40BD80087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ovbs4dD/lwz9NBhrH1wt8UXuEv6kshMZI/e20TmFpLNLrpi9KMPH/tt5D5wkQdlqro73twrJAmjwboq9GUS0tHUmbYrqN/2eBEuX1NTvsNAJ4K1G3cNO8/+KcZaAwOOTsagJhq2PcQpP7QiwXL5Ek/F/hzqDaP0q3QOY1jIfDox3eJvZh0IkpTAt6bSPq+4G2omHDbuFsV1I2kr/Xw4XoVpOXLSq9umvuCcKQP3QFl4vRygtlU9yq/OxTlJywq0cnAV6ukXhuV5aC6VyoMH5C9Gt+dlxUrj1ht5kB62x+8omhK4U5h8CbQC1k2R53kF9EFwf3Qo53VI44WJyiV4dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axdBS1Sb2DKFsUJxmAnqUgOCty8yHncN6pl8M3t1w6E=;
 b=h1TX35zHoI/nC6qEmm0Q2pU0XC3ycttWAHb9K8lPdcfaknc7dWseav4N6XQsj22qVe7sjX87Q0NUeQLnUJl3DISoZJRiFPm2kW5JQkMXxywccZ/M2DEg8nhx5GTy781I/OF6AoHsVIvjni3l2AVqOcEbUJK+blv+ImXjbb/Fvm1qIWjs7kXlUaalAxuFX5Q8+/EoU6S42gMZhcLwvsuW8Boi5DwIcu1LXwkTy3o2AteiY52oVoJjZ0TGUKIxu6DPvuPPPF6hFFOCHeSwlYtMYJDn45xMARu77gFFs9/ZEFSF79aiJsIIRTQxFwZd0b/dsAT2v+lCn9FlpLIK6+C6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axdBS1Sb2DKFsUJxmAnqUgOCty8yHncN6pl8M3t1w6E=;
 b=pSvST2hS9IaKw4GPMe++Mjho1JdBNzHjl1ffhvPbMDx7lEEgjwy31Qmp/foIXgx9RUqhzNU39hSbNgCdZH5+7NDqzCVlrjQCQ2CAudOj4QIOCpy8xniWC0DC7ly+rA0xZNBLDtfBsNLQffx/pK/F2Z8wctkLjo3T2qYvKmAh59aIrlTvYpQ7jX208RmqVkFiRwzM4SmZ2F7VG2b+k//20gD8WUE+fJn7/WpwZmaIiIV9VbZZa8xDE8+AlKm295JFdmb/gOf1TyKuJVe7wbyNJbBZvlL1LRWt+zEKI8hVG9kewUcIm8m3455l6vzPU7ZMttJ3s/WydIEK7TxvNoEWHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by GV2PR03MB11375.eurprd03.prod.outlook.com (2603:10a6:150:352::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Tue, 9 Jun 2026
 07:01:08 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 07:01:08 +0000
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v7] tools: mkeficapsule: Rework pkcs11 support
Date: Tue,  9 Jun 2026 09:01:04 +0200
Message-ID: <20260609070105.525348-1-wojciech.dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|GV2PR03MB11375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dedf933-a46a-47af-e532-08dec5f4e1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|6133799003|18002099003|38350700014|56012099006;
X-Microsoft-Antispam-Message-Info: Sy6OL1JJ5sBUIKzoDmkTJ/KRN+r3KWIba9CilKNyLmpCOFjb9njKC3ikpVdHrsBQjHRqqt7TBJJvrOS302PpMyYkqFqyVIrt7Z3sW6StYDyKIOtnFF3+4pCtOqwhxE+KXHN1udXiW/fcM5e2D1GOnJBUPLDqneMXg302/W4b0ywVxP19/maxakjP+OBGxgQazLkdQp0sgL6vPg1NDpCR+PzfPrq2VaE3L+Io6jzAu2dX21jqcC/4hIOOg5Jz+Tm4uVZ0bCONeZWnj8R9EWeW5iMooq3O51lFnWnjjX+xw+AmjNI47nXQwZj5440v80djJ3gVG29ZtrUTErZmZT+TIDubTHkeG6BUuBiOdaHh5Y4WraAlx5EfyJEW+CWzgeHDDYnsx8rumIcrNp9M74AKTg7HM1eBGwPo+0XQoQu9ejItiejTR0j9HTLdEYvajWr+KGjUpdBi/pckV0or4Y5n68i5HmffS60rkzklTUwIMtPRpYStudXJYDo7Bs/qxo0ae3BEOUNWOAavMV29XjLg3UH8QZy9/RTwYCbm383dUmwST8Tdt0yld3aSvB8nr6iRVp+aywHP3ZmhYf6YF4M6ysUnaqxb3Dd4WvugE1mJIccSqx13bDeucU3Vs3VNksDV6IEdBX8iarPhO7TTQ57CbhcznjXQn0ik5aSNvWgL4OmRtKTM9DtLpHfWpzp2rSdjvCUGyyX2mZap1lnuIAKsybE1V/ySS0dMTGLFDfYhQjgbQe6+ahyMQG+tzvYqMYdV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(6133799003)(18002099003)(38350700014)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eg+hgQv1NZNZQAo4QKLSiTW1juNWkyYwL5cKb+mEfnqxwmmWc4XJvDLCK1QY?=
 =?us-ascii?Q?C3yN/pIV259J4260tWriDvRSkma5x93rR20amEkMYahf7wjFitH5qAl+FQPU?=
 =?us-ascii?Q?2xV5WS1so9y/3lDAfeymxUY6/B/GdvOxVEZr8X3jt96pKTSAzBHTkJU3H+V1?=
 =?us-ascii?Q?DS4wdc/vnBAMXABEDZYPoQSUvdBq4fQLpy91xUtkPCk5jEhdbEr0etUbTcQb?=
 =?us-ascii?Q?DqNw4/03oC1NBeTWOIoDGsb/uiBGxxBLCSq/2lQSo0Zxig7OzxrleRzhDVeD?=
 =?us-ascii?Q?7KxVaqXoOHMrwSzuhAmzBdRPnIHJeNIlQUumeG2bilUKOw+qg6zBl+9upsgH?=
 =?us-ascii?Q?DQO/LZmby0jaNKlxK02kDjVXQq5geu74Kwtntc09GUK2EkjpfdNUpIx884Ad?=
 =?us-ascii?Q?nQuqGG14xhGaj3vdmw5/Jd3gzLSFnsXuLqjyZFTwSIMI+grLrPFcMHRUMUcE?=
 =?us-ascii?Q?6RAj2hSHAfcTocPJ1PvwCzphmrtLiTE6xRugQ480gxjJa+BCzRmSiG/Kfjwe?=
 =?us-ascii?Q?IeVdFrhYgSgDFqeXqh3HTsRVcuk5z0E5gmp22cBGLB7mu24+p+l68hHt6aBN?=
 =?us-ascii?Q?NFDpHPrW5401eG488htxTB+r7fraxNLj22CrQrcgLrk+ycDnHZWmJGoc7Gfo?=
 =?us-ascii?Q?pX3Js64+QJITjailWCN9zK0dYVpy9lm/K/Qb/InzBvHO/1jjW4ZcmrHGQ6mM?=
 =?us-ascii?Q?twVAfRzsWyQT5bDTp7icT9jDgBoPRnP65I2vZF9DW1/zxtNye0ZjEjISCOfp?=
 =?us-ascii?Q?0cBVxoSmx6iDauSgWlbdRE0cMnL7FPj7fEOhzk9mBj+FfYZubkfIEVK1b5Ph?=
 =?us-ascii?Q?uvrnfhEJjwfwZHl60sIDHJHA/6U4kgRg7rAEoJWXbpH66fyvwm2U7GnCto1Z?=
 =?us-ascii?Q?WGxn78849JZN8NWGNtNbnKo1GH+nAnO+XrnFFkoppV8qYtFlHhLRBp9l2erN?=
 =?us-ascii?Q?u7EviqUdGNmC5RiT6RhwOcC0TxyaE9MgAxEHMIeUuEzg82Ser+egXWkWkPr9?=
 =?us-ascii?Q?tK75+iJ3C31XpDC2AW8vemCj3T3+zjzCQdU4z3RNPspkSNF7huJhqoulSmwD?=
 =?us-ascii?Q?ugnZfqXMB8c/c90Yql7H0oBPWfwUW1/wn1ifEvxzq3gbP7pw9fHTpej/cuvQ?=
 =?us-ascii?Q?rLr9yhCkPOuh9P+eXacAeQ/lkNbHHnFISIwpEsJyoXkufU30h3t67/f6ij++?=
 =?us-ascii?Q?qGFU9IgtQA12+j09vzWNwuXDkGucLwHftPKzc4X7hrzo5qUI1JKSzYLulCRC?=
 =?us-ascii?Q?jl/8FTUVSYdSpOmyE7k1bNrEG0HKImk1PXuR9phfcNLq5EkFTkh+17HDK0CK?=
 =?us-ascii?Q?eIgtF1wRGVQtLbQKh555A7AL9SRX/ew8L9vCsvfoMJ46/Pjzo2X1GUX+WFef?=
 =?us-ascii?Q?onDAjnuxrEx9/tlIjfZV2R+xmL/RpXr5ruJd7+OT0b96ePpucPL3mesdbp4a?=
 =?us-ascii?Q?QSL29BSo/qIEaigXV3L3wBpMuf/mVCuwQsp7dcBRgKwrFwtAbfnV9F+dYmNc?=
 =?us-ascii?Q?CiXVfFWPpskKvaMeYg9ih7N1XWwbHxJcBZG3rS1OI4ZJ8vzUTQlzZQ+NC+LE?=
 =?us-ascii?Q?qHGA+IQlXIOT5t42A2RHUkXt8WUktXoV6cHCMwtMhVV3Kl5tpYEseMn2XsvC?=
 =?us-ascii?Q?aDpIZMybN9VtFwhay+o59eB7c24jAEchqjLVnzTOyPwSgoeiphR7ijG/yAFH?=
 =?us-ascii?Q?rGh8lkrR8khoQv+QX2bzo9lbu01A8ZHSwQMY5BNVkQh+3k/Ua+uW77p9nXmL?=
 =?us-ascii?Q?cEMcWIS6kg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dedf933-a46a-47af-e532-08dec5f4e1af
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:01:08.3735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w27oivqUFXB+bAOBpGkyyUXLrsv+EuMzoMavbPG3MmoBF3Cs0DtOOl6JIGLXU6AHw8dNNyJuoc6Ogt01J4GMOQ==
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

From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>

Some distros like OpenEmbedded are using gnutls library
without pkcs11 support and linking of mkeficapsule will fail.
It would make maintenance of default configs a hurdle.
Add detection of pkcs11 support in gnutls so it's enabled
when available and doesn't need to be set explicitly.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
Suggested-by: Tom Rini <trini@konsulko.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
Changes in v7:
- fixed return code in import_pkcs11_crt to restore the old 
  behaviour, spotted by Simon
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
index ec640c57e8a5..c3cf48f4cc1d 100644
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
+		return -1;
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

