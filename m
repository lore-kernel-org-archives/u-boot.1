Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C951F8FA6A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D01805D7;
	Tue, 21 Apr 2026 14:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="ZVDYa43V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DBE483693; Tue, 21 Apr 2026 14:14:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E838801A9
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8IVpEqMWTvhLg6K2Gnxu2FhCDHNv5dZirBokTnB5e8/pjZu0gtmH/YLZ08hNtSlF5+dTaR6EdYSt1rvkXkXbVZpdoSLO8CfQn+GUR2Gz6w/TkSCda3kkdKRybZwBBWBOJ2Xy145EHlI9cYmY4m4njo1UpO9egEokZ5YpamrL0HUZ52UnbpoGnmsZOThdzt7t9AEz8b3++aAgEDdPf0kzWbkcPsfBWSc3C9YfCyDhW+eXRnBLd4jrCweipC7uJO8foE5PvEC1w3jwV6mGMELD94RMH6Omv2gUtEJXTgZ18N0TmtYNers9LRrgAURb/dfJOIZnQjKYcusRvi5XUu+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWzX9p4wA5cRs0tEV1r1VbQXZUY31v7Ks3huRPHOQdg=;
 b=sTHiYMJ8tKgQt6u9lvB9QULrhESzn8oJNFzay9v9OVjLMhTH+6qZ8sLbFWKnnUjqey18McTbd8EkOip9qTvn8JLHrYyUN4qnsZGiTnABIxIWC9yMqVBScJUamgLF7OTpavyK4lbJdae+CBBjJEAUPGldbJEaq4muD/0HJLAWUiCSgeEGIcM1ZqvEEO6pUyh70X+hFSy1rFDRR1U2xlF3s7qkwa57Qs7P4XlLX4SuQM0lR86Vg+28Pn9vvGcxJI9pjU92TrRAq1qPZkEcMtIXrZlO7jEmbBqdEm5W+AQD4Ai0nfn0PZqkVcjcFchWVbKItvxRP/R62rIDZJSs6X3WCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWzX9p4wA5cRs0tEV1r1VbQXZUY31v7Ks3huRPHOQdg=;
 b=ZVDYa43V+2a8w+L2pjK8HaKs+F/uVYC3JDKt/y/NlVL10A+rHHJTFUTXU4IRCJmoPE16+4XT4a8tgOZepK1xBhhFITlyI4TJ25sS7oRxQ7YryaEv9JHQoa6DJYSBmYW28lztEiySqt6OPIVWJFb9E/plHlgMy8aALv11hqTYtqNEaKN1KEbbmNZHYbqJYmkBwFCniIzCRkmyFNjrNgRlWHnkFEWdB0bwaApjU4YIvnY/n0Y58kT+63bvWKovLfHLdresQHrcUleH3/BgBgbV3TYMVsHM38/hAsrDQWKQpUcGgzVk84iJtEcY4Cy7tXpvbh1Ya9iknbuyFi0IJHw0nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS2PR03MB9877.eurprd03.prod.outlook.com (2603:10a6:20b:546::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 12:14:23 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 12:14:24 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>
Subject: [PATCH v3] tools: mkeficapsule: Rework pkcs11 support
Date: Tue, 21 Apr 2026 14:14:16 +0200
Message-ID: <20260421121418.3257226-1-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR1PEPF000077DC.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::41a) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS2PR03MB9877:EE_
X-MS-Office365-Filtering-Correlation-Id: e48f0e2f-a003-4bd5-7e63-08de9f9f8693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: I7f+2/XKfN7W5HgsXkSb6Cq81e5tILYb0nX7PfGSg/wlcdx3FJekffk6qA4hGSx5OhNKG1fCjzNo4TtFv41sYgX/bjJZ6ZJCtnL1IGlewoFuA034Bgx/z3MrhU9hCAYyZJkXUTZkYOl9/oqoj87UyLHwauV5gsWwm1Wavc7qwhGYMNqOns8rz5PeaiwkBrpKeL9bggb4MOhNOj+93uZGpRZSAS+12oY6QLtFKopf9JWLGMEeKEs7nXtoh4KbnZcreLDByNW2NQRxT619ujhnrjklpl9M48rpW6thVSY9FeYyOGi3WsxBnSaHuGFlJdE9m29bIbMgn3+bt1g36X/bub0Zt16qYQ2h5NquA+qmH0yP9mxG82TehIpgUrzTvQKP4nIGrJwpA/1JPQQSF+f+rPER0euNqCAoS9H8E0XTzhG7YdJbsruKfBKFvsmNRIbmFaCoCycQvJZTAF76+GLj7A0kM56uqFU6WWeme59wYjfDJFzqkssoEpIpGCFYkhctoxwZgAJs5DpOfjs6l5dLJbzB94nXRvPgV29dIuLNZw+HJ/2FKrOyIU/horG1vwWT7cil9H1snMhUxDeEuFs2jcB+CoYnN5TPAH5oCtVGAfBvEC0BanIeMN5DhpcS8Enh1eb5gp75wNeooS/A4RVul7mSEZear/EsWuxUwzAZTVHdC2T6OTiatvB/iccShgkDOfIsut81C8jfycbvTWcvmHyUjZ3KaU/o5sUEJI3P1d/vwOubWwuXkKQK23q4hMP9wmEAveMvKN0JphRTz0wHaT9uFjItuAoCSZ2JvgyDEQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uc7hOJvPRs1EFcGgOt3MP35Oi+ZfEvT+j/KDkuuNnX5AJUL5XVqeegmOYnes?=
 =?us-ascii?Q?bgPCYci5HnR3BqI9cOOcIM9IPbyOO2K++dCZnR/Oph9QuGYM4CT0C1Q0k0TD?=
 =?us-ascii?Q?BLKqzyf4gHhjKmrk6OU66W5PNElWc0tL3K+odVY8F7gq/+PdYF9lo/PIb/QZ?=
 =?us-ascii?Q?h6xpKx9n8CiAIWjMFS7Dvdq+Vz/W7K4ci5BQ4l1bk8hn6EJz5APwQuFTfN/G?=
 =?us-ascii?Q?Cjax8hTOkp1lbMQYWypAhadTqcKDj419vgcdIl7D7yV8xU/LBY0l4c5/k3Cv?=
 =?us-ascii?Q?lDRXCL7Qny9/zMZFFX2Or+2EsZfDKvJqDmSejH1YWz+QRy7266NgBMLpA55w?=
 =?us-ascii?Q?WrO5tAt7afS66pueFhcpXcuU1V8EZQwsKEb2GUOgtIhK3PvYxLy2qRM6bZTu?=
 =?us-ascii?Q?ncAtsDd/XwFgCBBUf1hzSDp54aMsJGY/Lh2bsCDAPN3mWI1D70ePCuD3YeOq?=
 =?us-ascii?Q?HMLCrNPOVLxvUSp7tkdXgrley3RHxlnVqEd7yvL4x4YxNVe3h7ZNsF0Q5iuv?=
 =?us-ascii?Q?YQZVsZzGfIEEVdnpJHUo7jhKroR2THvMRjCcKdM6hdTjJnsTmZWBruWQC65n?=
 =?us-ascii?Q?USG1G3ow2cWXO7+WtW8GoFrhUwFThGJl1GM2mAthiq3/275ZwJOP56fMlR8T?=
 =?us-ascii?Q?IGu5hZv8SB49hwDbauFGNly8a0YggjaqaJG+mZDBthEPlnfw3WnN0i422uk0?=
 =?us-ascii?Q?a/IptXxt6Bc5rtPGhWfkZJ5j5NzZODmju2/GSo3LGU666WbUZzRkv/5wDa52?=
 =?us-ascii?Q?2Zvcf8XuFIrOR3q8TSUeA5XWlztcx0fflS30ASX8hKXKsa+PhyJWgh+pXJ3U?=
 =?us-ascii?Q?DXIXhHiRr5VQZFLtTqj9+zWJKcBo4uHqlox+dP1ZuZ5wTlPz9xJIWW1mK+m8?=
 =?us-ascii?Q?ya7u1wyPG+Qt9OizSTksFv8vsMeqCYihLXEE5nkMVry2OvtWUUuYblkmc17Q?=
 =?us-ascii?Q?lIlqVwXbwjMkZTXZvhcvsaF9SIuY1LgugTPcr0VRJUKfWZqu2TDYAi80p1So?=
 =?us-ascii?Q?U8mE7wVnpqPSHooDYL8C+tyFe/YV4vJyVOTVlR7cSdHws2ogVp7TkvUBc4Ho?=
 =?us-ascii?Q?/WXSetxTlVK+UGzbPk4zQ6DW+48pFRdYAUzc0LX5xRhHzx9B4F/Uqtyo5Ol8?=
 =?us-ascii?Q?WPleFkL8fwT/ZHurhaJ9OYExgXfqX82cMFhzCm7xYOM2Dgy1hWUTiEYwVPVD?=
 =?us-ascii?Q?Sa/Bl9js2jTltce+lBkRenbOay4rFK6FHYbL9vgnp0A9QO6ZUauDRALnaUJr?=
 =?us-ascii?Q?uMU4/ZuMKHJLejONrGNLr45Woznmxpnh2VS0iDkMUCq33wugqB9HA/kLEmyd?=
 =?us-ascii?Q?pq82SAKdCtXiI27mZMDjkBG9g+xoIylqf4BYtJVYbD+s8iJIdj+SfeVTnb9U?=
 =?us-ascii?Q?tXY+WqiNWNKJYQpwNzRjAmxPgsICvoXWGP+FHUTnMT8i6okaXo2pNXDE8USo?=
 =?us-ascii?Q?F5TUlcU1zPe0ge/dmasT89njZQjGsFDFvJjo2q0K1bRXS9jeywIqTisxgFKh?=
 =?us-ascii?Q?gU668BI9gHwsf0Y+hcZiDsqjWpowNv2XkT10tRtM82IkXkDKlk8YU7oVrj6/?=
 =?us-ascii?Q?MTJwSax4FfedOAzKCMwE6tF/Zauj2OwxpRThIYC0tF3DzsNr+oAkalpqYAIv?=
 =?us-ascii?Q?wfMPMSRR9+j18UoVEJD0BKIbTs1mfjot5uJcVRB6Z898AVtLGk29HF15QEaI?=
 =?us-ascii?Q?WMX16EhPlD77zeeIPZlL5ricek/bwxEMleCSuODOuRNTuFZR82rMnfHqDGxC?=
 =?us-ascii?Q?F6f1jxzIow=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48f0e2f-a003-4bd5-7e63-08de9f9f8693
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 12:14:24.0989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QGrJlYncIXKRtes37/HQwLHaoWJk/7FFhrGTzwQGlk8uJfqr9FD6XjNxWzNYGhFmnblrSbirKo/IYn9Ynt0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9877
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

Changes:
* remove config option for pkcs11 support and add auto
  detection in Makefile
* reduce amount of ifdefs by abstracting import pkcs11
  functions
* add missing free and deinit functions

Suggested-by: Tom Rini <trini@konsulko.com>
Cc: Franz Schnyder <fra.schnyder@gmail.com>
Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
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
 tools/Makefile       |   5 ++
 tools/mkeficapsule.c | 117 ++++++++++++++++++++++++++++---------------
 2 files changed, 81 insertions(+), 41 deletions(-)

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
index ec640c57e8a5..747431bce8fe 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -207,6 +207,45 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
 	return 0;
 }
 
+#ifdef MKEFICAPSULE_PKCS11
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
@@ -221,17 +260,14 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
  */
 static int create_auth_data(struct auth_context *ctx)
 {
-	gnutls_datum_t cert;
-	gnutls_datum_t key;
+	gnutls_datum_t cert = { NULL, 0 };
+	gnutls_datum_t key = { NULL, 0 };
 	off_t file_size;
-	gnutls_privkey_t pkey;
+	gnutls_privkey_t pkey = NULL;
 	gnutls_x509_crt_t x509;
 	gnutls_pkcs7_t pkcs7;
-	gnutls_datum_t data;
-	gnutls_datum_t signature;
-	gnutls_pkcs11_obj_t *obj_list;
-	unsigned int obj_list_size = 0;
-	const char *lib;
+	gnutls_datum_t data = { NULL, 0 };
+	gnutls_datum_t signature = { NULL, 0 };
 	int ret;
 	bool pkcs11_cert = false;
 	bool pkcs11_key = false;
@@ -242,10 +278,12 @@ static int create_auth_data(struct auth_context *ctx)
 	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
 		pkcs11_key = true;
 
+#ifdef MKEFICAPSULE_PKCS11
 	if (pkcs11_cert || pkcs11_key) {
+		const char *lib;
 		lib = getenv("PKCS11_MODULE_PATH");
 		if (!lib) {
-			fprintf(stdout,
+			fprintf(stderr,
 				"PKCS11_MODULE_PATH not set in the environment\n");
 			return -1;
 		}
@@ -255,10 +293,11 @@ static int create_auth_data(struct auth_context *ctx)
 
 		ret = gnutls_pkcs11_add_provider(lib, "trusted");
 		if (ret < 0) {
-			fprintf(stdout, "Failed to add pkcs11 provider\n");
+			fprintf(stderr, "Failed to add pkcs11 provider\n");
 			return -1;
 		}
 	}
+#endif
 
 	if (!pkcs11_cert) {
 		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
@@ -296,35 +335,33 @@ static int create_auth_data(struct auth_context *ctx)
 	if (ret < 0) {
 		fprintf(stderr, "error in gnutls_x509_crt_init(): %s\n",
 			gnutls_strerror(ret));
-		return -1;
+		goto cleanup;
 	}
 
 	/* load x509 certificate */
 	if (pkcs11_cert) {
-		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
-							 ctx->cert_file, 0);
-		if (ret < 0 || obj_list_size == 0) {
-			fprintf(stdout, "Failed to import crt_file URI objects\n");
-			return -1;
+		ret =  import_pkcs11_crt(&x509, ctx);
+		if (ret < 0) {
+			fprintf(stderr, "error in import_pkcs11_crt(): %s\n",
+				gnutls_strerror(ret));
+			goto cleanup;
 		}
-
-		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
 	} else {
 		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
 		if (ret < 0) {
 			fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
 				gnutls_strerror(ret));
-			return -1;
+			goto cleanup;
 		}
 	}
 
 	/* load a private key */
 	if (pkcs11_key) {
-		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
+		ret = import_pkcs11_key(&pkey, ctx);
 		if (ret < 0) {
-			fprintf(stderr, "error in %d: %s\n", __LINE__,
+			fprintf(stderr,	"error in import_pkcs11_key(): %s\n",
 				gnutls_strerror(ret));
-			return -1;
+			goto cleanup;
 		}
 	} else {
 		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
@@ -333,7 +370,7 @@ static int create_auth_data(struct auth_context *ctx)
 			fprintf(stderr,
 				"error in gnutls_privkey_import_x509_raw(): %s\n",
 				gnutls_strerror(ret));
-			return -1;
+			goto cleanup;
 		}
 	}
 
@@ -342,7 +379,7 @@ static int create_auth_data(struct auth_context *ctx)
 	if (ret < 0) {
 		fprintf(stderr, "error in gnutls_pkcs7_init(): %s\n",
 			gnutls_strerror(ret));
-		return -1;
+		goto cleanup;
 	}
 
 	/* sign */
@@ -357,7 +394,7 @@ static int create_auth_data(struct auth_context *ctx)
 	data.data = malloc(data.size);
 	if (!data.data) {
 		fprintf(stderr, "allocating memory (0x%x) failed\n", data.size);
-		return -1;
+		goto cleanup;
 	}
 	memcpy(data.data, ctx->image_data, ctx->image_size);
 	memcpy(data.data + ctx->image_size, &ctx->auth.monotonic_count,
@@ -371,7 +408,7 @@ static int create_auth_data(struct auth_context *ctx)
 	if (ret < 0) {
 		fprintf(stderr, "error in gnutls_pkcs7)sign(): %s\n",
 			gnutls_strerror(ret));
-		return -1;
+		goto cleanup;
 	}
 
 	/* export */
@@ -379,7 +416,8 @@ static int create_auth_data(struct auth_context *ctx)
 	if (ret < 0) {
 		fprintf(stderr, "error in gnutls_pkcs7_export2: %s\n",
 			gnutls_strerror(ret));
-		return -1;
+		gnutls_free(signature.data);
+		goto cleanup;
 	}
 	ctx->sig_data = signature.data;
 	ctx->sig_size = signature.size;
@@ -391,24 +429,21 @@ static int create_auth_data(struct auth_context *ctx)
 	ctx->auth.auth_info.hdr.wCertificateType = WIN_CERT_TYPE_EFI_GUID;
 	memcpy(&ctx->auth.auth_info.cert_type, &efi_guid_cert_type_pkcs7,
 	       sizeof(efi_guid_cert_type_pkcs7));
-
-	/*
-	 * For better clean-ups,
-	 * gnutls_pkcs7_deinit(pkcs7);
-	 * gnutls_privkey_deinit(pkey);
-	 * gnutls_x509_crt_deinit(x509);
-	 * free(cert.data);
-	 * free(key.data);
-	 * if error
-	 *   gnutls_free(signature.data);
-	 */
-
+cleanup:
+	gnutls_x509_crt_deinit(x509);
+	if (pkey)
+                gnutls_privkey_deinit(pkey);
+	gnutls_pkcs7_deinit(pkcs7);
+	gnutls_free(cert.data);
+	gnutls_free(key.data);
+	gnutls_free(data.data);
+#ifdef MKEFICAPSULE_PKCS11
 	if (pkcs11_cert || pkcs11_key) {
 		gnutls_global_deinit();
 		gnutls_pkcs11_deinit();
 	}
-
-	return 0;
+#endif
+	return ret;
 }
 
 /**
-- 
2.47.3

