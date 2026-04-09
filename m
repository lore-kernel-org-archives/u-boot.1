Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173FCE9DE5D
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 07:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BAE7839D5;
	Thu,  9 Apr 2026 09:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="WrOm3Tn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D3283CF5; Thu,  9 Apr 2026 09:47:52 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 339E183693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 09:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljY+2XaQPlzPxWVCqtcU7mnuSeW/Miw1KRx+uffTJsLnjsuUSKYtR9dtwEOHFXj37e8HC8QiAdyLTmXK1Bh2X4zXScJv7h/5bTwdPrVgLj6lA8UXbimejJXdJy2HaRq/A8btxf7hpN63mFlSamXySEtUftBW7OYamwzAo6jLQp0c3zPxj1YYgTeRg40FRwU0/jBs5WrS2+FRIaB6kLbfMWo9sIsUmYx2Mg7aLBVVYFDQHKg3z+yvmhxVioOOowZbKMIUmygmdvuf4hqz2KI6hr5vdKwIZQBgBKf0GZtcxj4yyzXxm/EnULJFqQbonD7ksekQoox2UB9xCvqmYCMnPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0kwWEtFtb1J1jVNX5QaZXMxnNwJUAr8QdrisWxqpvc=;
 b=AjVCv95EGQEgmcueYB0Sa1WlgsV12Shd5WhKTfDebhzSawwJtiB4lI3zUPhXkm8yhkIMAV8yEruoh569VqtUgJ9QtomMP1/Y5f251Lk+ZUy3VvxM8evlTMMisfnghT4vrWHuKzTvzT5gjP9LOfrUMSygDCAk0mWBz0oV1WYIeCmo+YlPbSoQTzpr5JsTVX4Dw3uARQCQTm9ZWbJsQON3zaG6lXWads0AwTj5sH84Xe/iO8rGh44bRA/DFSTavdv54EamEHZSvOa0xd/7ol1slABf7BbDsYKoi4VXgqf+cmGMRl5YClAyJOsQIXKCovFqAR7X+tqH6sjsKNUV1fWTcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0kwWEtFtb1J1jVNX5QaZXMxnNwJUAr8QdrisWxqpvc=;
 b=WrOm3Tn+F3TLIFjn9yOiXdhHBvCdiwn8m0LN45gTCS9hAAFuzf59eMUqF+slcdTP/CsmaNIRCLCMUlK3gc0PcDEMkOutABvq1RsKlkRGTtkjkGtn9qBSizv8ik2Dj589gTUG2+c6sIVbWkzOpfCGYDydbbjoMH5PSIVhJUE3RXfgcXRaElY7fOiKKbwiEF9oGhJhqMi8wzXl4Q0jfBSOQiWQ2MVpzwu/cWx0sRwD1u2P7NnIAnxYzQRAAcFGbaKltXSbsVWFOmIgP/BCDbQ4jwQMSJ7HidUpHcBqXfSfaS2Ipw1D/T6VocxTvHE/bbMmZQrxRSlE4Jh2D3dJTvBT1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by DB9PR03MB7811.eurprd03.prod.outlook.com (2603:10a6:10:2c3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.41; Thu, 9 Apr
 2026 07:47:46 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 07:47:46 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Subject: [PATCH] tools: mkeficapsule: Add disable pkcs11 menu option
Date: Thu,  9 Apr 2026 09:47:07 +0200
Message-ID: <20260409074710.1322519-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0076.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::9) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|DB9PR03MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3df442-30ea-43bd-1b6e-08de960c4a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|376014|52116014|56012099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: TdqFboHjkhXuXIqlXZPFQd0w/rGDNStJBu0on+lrbEfCzxMMa76Sx6DOrtlbTz7bKryRJjrN2iYJM4Zsqyh0CSuFfJ+Fw5iIBq4At+gQZtM+MT90EV0lFjQuQz2qwz+JyPPRvmts1YftZltwJlny9wGPRh+cI32fDvHVq+lZi7yrlYQAx4gqLcZ+E7o04E+2EbhSa8OZeCFEAjF9gqONhaXLj7uYUDb/EpzRQHfzutdcQh/wAQqq44Cxipvqhvy4n+rJe7SwdeKH1lBoGoZuKehexVOj02VHSBc71OL1wkvEU3RPqJ3nhyETIVhpV7yQ0M+F7A+SUaD+gH6asN4kOkONYM6ZylhE3MmZFes7ZREobj4+BwwXiHOsi2IcaOutUhvwgKEUurdercP+eCjpXuCWqxiIhQ26brVJ3y0XQNHuuYlBY+e9IOfK4peFWaljUW8g4oh0gVtJSzyhfR7kf0zE9hweOEPCUM6uUTzmhDNGAhqIGI+gvK9VIgrvk/PYwe42kLZNz2PFptSBsuS6XjHXI7oOaDjj5qy7QoPBLUdqQCVVNR3I9EOB/OBxk/9HPl65ztiH9yZ4fZR0uhXuZCK0u1rQ1f/V/kBgbx0B3MsomD3ftb9DBBl31L3W93f/kLUtHmSlTiRu1/iRuy0J+G/aqZMv/5ZjVQVL/+Ba16mbO6W2zs9ddhnz+1KdAdJgND0N/rrog8h7ZxcnCGXO/GiqpDqM9NzRP5CA/tDUM7S6+BxA9K881tahU9WDwjpZiXp0tJJQldOJkSif+ags/Xeyv8PyFirow7t6ByulgX8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(52116014)(56012099003)(38350700014)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8dQjew9KIu6WjdTxk4i8ZdfxbA4yz5zM3Y9cZCkg4wqUBubUc6nfiv+T0ieN?=
 =?us-ascii?Q?uVCrVnJCGbu9JIz3o6j4sEHCiptFL3SH8Zn9DwubM+297yAT1PTttNszh9cp?=
 =?us-ascii?Q?LxboHMRgb8RTf7gdz85Yqscp5v8gmzrpOUrrP9CMjCVbHKqEebJqAoyWOx1e?=
 =?us-ascii?Q?X0dyXJg4bIS82W37774w7jMilEHoMwB7C2Uf/nS/Dz+6nPXnxdQpzbpQmkhg?=
 =?us-ascii?Q?8cIhlcb4GdSoltGpeSsHTssk70vcyqpYv9d/Wi7FBe6CIeBPAlWosSj8gAKI?=
 =?us-ascii?Q?coFVpQOe1xu68aXFq7ThvM9wxpnmBUluTiz4u4PCQwVLowLTWfALuh/nP4gG?=
 =?us-ascii?Q?5DMEiA1uYYtukjN7b9XIyAq5ZwGw1+OsL0L36GF1Y0/yu+gNXJxtjZOcBkt/?=
 =?us-ascii?Q?RaPQ8WuCfH0D3ZwxRkIhUr0vNlLrEN8sKhFTkrveb/65Nlk4clyWKuYiqIVr?=
 =?us-ascii?Q?Eye/0nYoqcFxPTHcOLw/rS+qfauk5mSOx6Tu+Cw/Pe8qaM+Im+LCD38Yr39l?=
 =?us-ascii?Q?4BT3S/Jd1oM/yXhega1XUJD4MIChRf4C1Uow+C1bp6CRwSVLIRKjKNThyNeY?=
 =?us-ascii?Q?7zOosvL1tv7bsCnqdJNOZuCtvSWh8PrlXrgfqp0r1Kzny/0jAW9Byr3QG0zL?=
 =?us-ascii?Q?ivj67WU7q+4iQQHnhIwjTaAr05WPlqEMt+oe1pDgKHX1AazEjCEunmnJhW4l?=
 =?us-ascii?Q?XkiZBYbbJvFGEqcmncC0k6hh4nVyboJg92LWpsLkVc9p4WugDk4oRhv09cgX?=
 =?us-ascii?Q?m+++dXH/AkGOJmN7wxuxlRG1WEJThX38U1DBvbD5K+gMtmZtg6G5E2XebH6X?=
 =?us-ascii?Q?xtlBBYbLMirkc+GNjARzbB4WTETX8oe2veA+CgbZ26S+hJTXV6cAnsIUZacL?=
 =?us-ascii?Q?VGiC6h+AlWPI2ecJuAEa/5oucN6sGijADKqt1zt0t3LnF9JHoXRBEJ8tRyFz?=
 =?us-ascii?Q?8nWd7JMNLG0ffVSzfl6DDMq53rTSVrrGNgD6vn5l9CKJICAo+jJqDaWRM14O?=
 =?us-ascii?Q?2P7tQe/ZUChfNTLTHbJgyyvNrTPSz7DnOia7BHyniKlbTy0dEASWkxMUkfIz?=
 =?us-ascii?Q?hkEuCtybLvQVZ2dMfN4aSjIovA0vpkfBS7KRWF6TEFjS3rCsOHA0ku8yhfWF?=
 =?us-ascii?Q?pVmJ79Nr5gG2TmZrcLMBMTxh8tbBwa8aaoE82xMTAHF/NoygbVVBm0BwwMFT?=
 =?us-ascii?Q?SXEUENj2FzPIhhvDRbqFne+ve6e0enjbLLZzK8OCDWVFNciXp91895Qi8rth?=
 =?us-ascii?Q?pyM13zL/6mDRcMqLujIVt6/8/YrX1jzoRjyM893LD/dobwnAlt4iSA/VxDJY?=
 =?us-ascii?Q?LPb6GpKNLY9D+DFi8aUvwHMjtKz1xUDKjY1/q6aryU6HyUQNmC0kBmMqGeGG?=
 =?us-ascii?Q?CPZLJ1NK99XAjFO2+SkdlJNrBCYquWFzP4M81nkWHYcHw9ZjX+nz76m7aCkG?=
 =?us-ascii?Q?M++iorR67mMcyQbtdEUzgGCALOHgkvy111PFseL6tffloh2JJd596Vb0T/Aa?=
 =?us-ascii?Q?yWHvvFq47MGl2YSdkQUHQ9yzdbANhMO0YDXe5iHA94pXoxOBC3yW0HYte6zQ?=
 =?us-ascii?Q?VFIwbmaJfB9vvOqc8l/TDMw17r2BojFGc/G5NG1m1NkKmfMXUIfvVCRJ/h+9?=
 =?us-ascii?Q?cOmKhHo1GIJE1SBleDpihlsssY0KhIFoJP9+t7oXNBi+SCq3XEGCNz0+Esl7?=
 =?us-ascii?Q?in6asHarLoHSe3qS3sTGCIysh2Tap1Tr3rtCUeanARGoF+UxAUnl3aTip41a?=
 =?us-ascii?Q?3JU0e+56EQ=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3df442-30ea-43bd-1b6e-08de960c4a5f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 07:47:46.6784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MDI81CS0PYbpkoLrrtrYHaI2fOwIZWRlH8J3xdZNXE2RB59XltwNDS1p52A2cVYKvMblD5mXdOrnC5gnuS6ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7811
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
 tools/Kconfig        |  8 ++++++++
 tools/Makefile       |  3 +++
 tools/mkeficapsule.c | 14 ++++++++++++++
 3 files changed, 25 insertions(+)

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
index ec640c57e8a5..ad1c46f0e909 100644
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
+		fprintf(stdout, "Pkcs11 support is disabled\n");
+		return -1;
+#endif
 	} else {
 		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
 						     0, 0);
-- 
2.47.3

