Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DEAD185FE
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC7F984194;
	Thu,  8 Jan 2026 15:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="UjWf6zq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A5F841B9; Thu,  8 Jan 2026 15:14:02 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90D584180
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:13:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZ5GGvKkSaLa0VcDQPWwkrieRnX5w37LJAk/yVogcbO3JmXBuVIicpRyGYmlDenttESOCDEpLUBCVsv2y06YQsg+x4QA17rt6f2LRsrz5bXEHZIxzlYXqPVNreW1keTvVQI+eg+hONv2vnAggYMYsveW3IkEi3+SjhK24Dy0mLIt0UEFjLJPYFp1zV76L4NgbvlfwV/ebH4klsk3wzhuhixDRHOWg2J1kbjpPjYHSc9E39/GCfA2gFJNn6S7sAcu8Retd1oW30HSKg411nbPst0xdS8if93F7bDWk/mu9PPoceLa+N0xTrpAbDMOKt01pf5kFo73YW08s4WYTBEsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=kjhm2d5GaUj9D4lnrIYgwrh5ZQ+P1ZiWnfgSzheJYlt/GNVWATsbQ9/iKEStpRyxZKVNSwcR6yEspsiHxeHhRLiVr8uhGMPtlb4huzfyxZvB4QPG67TxPwA4s9fs6ijWfArfdIlZZuvdCEh+mAODlgwiyxE5kSJDWy6ccVuiIe7wrk7p7M4JXdJDp1TmYRbcPDIrzft1l3gxVKysyBsA4x5sAeEHFvL+tcqUGo+/2hjCBJQBwLowAWyfPvdsr61Bq4neHpmb8QtUNvRValM1/X9hlhI1NAGquhLMjkqhvOwo0nDeYwWTWgONs/eHw5Od3cznro+vLP6bByIze5zamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/gUDvV9VyUgBRzNv3Ae+BAF/m1pAeba2w4vc/H8QkE=;
 b=UjWf6zq+v/3aUmycUp2EV4O9SPf+FMI+3xa6TRa/tYnrhDaJkWUma+Fh7D+H7Eq/6UNR6UECYcSydl8exn+s95RTUX5oLc3kc7hhaWTd6hH6jxz5NDSBRKak1Up/BhTDTPp+aUgZA5VcFXWQd2E71RgF+jCYlT3H7/vyNBa0YLe5bVW9qFcGphpPGSVh+jtGeWRP6cOBkCZSEAAqr/Cporm9xAahRg9/uc5uuZPUpEeT4cMQHkdNorvnrLRA3POsEe6XNa9N99hcaYF4urmvagWJ8HEzU/N0vLROSWLIOSCVi52kiD8u8XcYMt5lpJWYJ/yqtjxhiZ1MgLghQrd9Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AM9PR03MB6836.eurprd03.prod.outlook.com (2603:10a6:20b:2d8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 14:13:58 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 14:13:58 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: u-boot@lists.denx.de
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, trini@konsulko.com,
 simon.glass@canonical.com
Subject: [PATCH v3 1/3] tools: mkeficapsule: Add support for pkcs11
Date: Thu,  8 Jan 2026 15:13:42 +0100
Message-ID: <20260108141346.1663305-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
References: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:610:4d::11) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AM9PR03MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb7836a-5365-4b32-a27b-08de4ec02a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|52116014|376014|7142099003|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XO0ZUNx/3rEV1zH9v2KmTCxfq9D+xhhIYfvzhf7kQQ3sQYoYJsQBTGMQw1Wm?=
 =?us-ascii?Q?8TSdbFA2ytY5cDsbDodDsHd/MYz7/lv7FRsVqgn151tw8RMvI6Z+r8bncKis?=
 =?us-ascii?Q?wXtop4CbMMg1D1PKN8za+KKieotVEUbMPgcd/n1cfQtyQs4vexjs/DLbva/Z?=
 =?us-ascii?Q?WfW+3hQ8cJK9vrFNrz/D9BgRGfvTmqJ+djmh/okezdAUcZYLYjt7GtJSD0eS?=
 =?us-ascii?Q?7BY3UErJWUucDhXDel0MyIoQRiRKGLNO5qfC7e5/yBBSIkcLYWNbNlV0SgQ5?=
 =?us-ascii?Q?rDnAUZ2i2V4qAz1mu7WPCkNUnYAQwPKPMtna/B1yw5obp6fF+HeH4hD/pCy/?=
 =?us-ascii?Q?Z18cFItmdApQVLXWBsvq+LxuI8I8fxq/GtcC9qsqMAlnxt9H7zuMTmttMWnV?=
 =?us-ascii?Q?3WfSAof3CSyQj0XAuNKP0HOYGvTGhbRPzYBQ4fqFgcYiRLQ+qSdD6toeAg3z?=
 =?us-ascii?Q?4+BFmutsmslmpqYo/2UU/6UEqkLUTijyf3D0uHR/gJVQvFSlL3Qo195KehJu?=
 =?us-ascii?Q?28yZE4P2qNHOknZcs4f80FpsMqCUU2NDc7Mz1tYD9Y51WQcyurbpyd8jF+7I?=
 =?us-ascii?Q?4fhM3eVqAgM1YpkfN2qfLQ0NXSHUu76i8oFf0N9fUngXVuXuNswjAzzIgk5n?=
 =?us-ascii?Q?4i1XKtvw7OEMkcXI6gMey6dfdFFmNkX7qq6Y7GfZxRTwMsBF1OJugSm5Zoto?=
 =?us-ascii?Q?GOCN/lp0sh4Bm0aRphFntuHPOab1hEJAmEe9420GEXCUyWnt4Zjl+tEaxEm+?=
 =?us-ascii?Q?YNtFMU4kibbzGD9qD5VlpgbJ2E6wa5rZXICEKXQwrOFa4fB2reeTIg/uR//x?=
 =?us-ascii?Q?MhzOSn8J8Ec2WPguEULQoO6Keq5E15es2UqU0yimHfZuzXLOQ+yAiBOZHKKC?=
 =?us-ascii?Q?URpM4RrB4lVf+dX3EBC89oaa6NtGyAD65Zht+lhIF694ZT0D+nNilW16DRa2?=
 =?us-ascii?Q?6N5aWbEKmBZ6X8ZSYPgsBJ80F1QFGiFOwknCJZy4Fs8CgIeTbaP+Y5WfZFgh?=
 =?us-ascii?Q?o2557znnbKNN1B6j4g7PgI04skEjS53pVfBjzrMXId0ZaQW0QNRg6moHG0Pw?=
 =?us-ascii?Q?cD0e5CT6gBk0u2Ll1WHy/+/bDsovvNJ6TfDkwkZHUDTwGxdxQQpRrQAe/9TA?=
 =?us-ascii?Q?B6t3K/AJRNCh5RoEnk2c7G+syBqTGWEZSxu02JHlaHb6evegbYuGrnMXd3Kt?=
 =?us-ascii?Q?t/a75WD/rgEJZ2ppLKuJ5eDqpmv0ZSuzJkKiPFwkOYJpIFDdj2ZOCPmYX1sl?=
 =?us-ascii?Q?muJwGXtkDsWQKX2bBLXgn/eX8hXQBZuVvuF+NvibOo3cGX7XavT1dtg/1XyR?=
 =?us-ascii?Q?Z//tpNWtgEFnZyiXdLtRobsoNBJP3w9/QzaspQrD5UC7/MM6seR0FGdF6mCF?=
 =?us-ascii?Q?9Fy0dr1OpkXu/Bb/PYnrlN+ZTGbN1XmNjql6Rqh43Pi9st2XpPzihAn91QMJ?=
 =?us-ascii?Q?0UFBy7uPe7UefierZgkQMRoCbpsVEi83oQBhs9NNOQJTNl0yYpYwKYcOSkMY?=
 =?us-ascii?Q?VyfVG4Ib9hDxoIXRuGCVHUNow0OfGSbG8t8o?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7142099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dfpbRY17Apwd6BrgsOigoUf7/5V3ltudXOaDe3P3x4erHRyfHF45wJ8yyIHq?=
 =?us-ascii?Q?fKhMxksXtL6kkHoaZwzEm36lOFFjsZ9zQpUumWpF7FBaHa0P6YDtLGOWR4oa?=
 =?us-ascii?Q?GkeleD19lG1iEYYuXDY4bcrQevXWj7vf3+qY8qI8YMIS8hs5lEvkQwnRWTH4?=
 =?us-ascii?Q?/oVVzih/i1Eyj5mJib/tjI47N4V9VPQqnu7ZTmOEOsdq1k1zTJkYTWd6xHBk?=
 =?us-ascii?Q?ncy2wESFPoK9kyOrdTX2YzJkrN7IeV09F996GJIyLdTWpiOUB71cA4fUAXeZ?=
 =?us-ascii?Q?bFYe9COVri5nwBFXHzGgFI76VAxksg1kibAW7/GupkIfFX4LJ9MyvXjhpQM4?=
 =?us-ascii?Q?zWN4z0LbjmAzxSBJU9UbS9SteZQ1WxgNTvIDoQpYbetiCAOC/RSBd+Dh8QVt?=
 =?us-ascii?Q?HKj7SHRKFl41W4BqNi0FQRuElqNpT0kOw/p1s9IzlOgxx4Jimhcx077rvQB1?=
 =?us-ascii?Q?+OexAkKZF7oEQVFEoPSNjIrY/d7zi2CkiKHWOvVxQ0EiPXsw+EX1qxVdCPSS?=
 =?us-ascii?Q?AXlfdP+M1xDdO7Y6jBuhUWQE+LqJd7hRTGBF4TlawF0EsRL2n369c5u4xo5s?=
 =?us-ascii?Q?kL9P49T2fEmdpQl+/vrUFQPAy0gmWAGKrpPFCf044jC2LDBo+iVY6hGBTNyC?=
 =?us-ascii?Q?lxerPaw+C2BzEu8eToPP5ElsUdHVnIPlXOMwBYrT8tuK4eLoQ5CMj50n+Vg/?=
 =?us-ascii?Q?c1UR8r2+8G5RNTHh2ss7fitb26AuUJlaCV84+x+OImj2fAM80F17+mBJGm5I?=
 =?us-ascii?Q?GOF3gWBwQXSsphH+T1/Qbb3lxSZI6upjoU6wlH45PvzUcJToJe6ELVZIqUke?=
 =?us-ascii?Q?A5286Zyog8+jdE85l7FEjAO6u1GWw+ClGJEs17NEAxRbLKdWjumf/7rY9FJd?=
 =?us-ascii?Q?iZ+qjIV/heznI/uNZnItkx50llx0UuceGfIYxJ1R4Pkamlul9AVmRQh1fgoI?=
 =?us-ascii?Q?zi2kup9Y0i0IwAPGt23P1QlLKtI2ODH6zO3qcYyKZN5egW1SsOZCRlCX7Ggk?=
 =?us-ascii?Q?Thi0Xi0+r4dM8aBA7xVWT7QZeD6JvndtfRN8Hy+fSMcJoTXZViAW2ZRKlUGW?=
 =?us-ascii?Q?/3KF3J55hvetlJk6JoSEOrL/K6cqGYpia4tpsvrePt4qD+iceytNJYcZ6aIU?=
 =?us-ascii?Q?4K5qq5WymyRIvHW/2kPna18fpkU6VrSgVcHl4OFcapU2SINZV8xG5z00yDKr?=
 =?us-ascii?Q?ZnCx7v7hNxVzcRDRu+BHXA3suoWqRfvz2s6Ym/aLh2UvVHxMgihTVJm2Mvxu?=
 =?us-ascii?Q?cNAjvZj5hBjelZeRb9SG7uYy7VXNSFIJwDQfEY8fTNwzKvATF5rpjo7B+8Lt?=
 =?us-ascii?Q?5uhwyloesV1Tuo19aW7+j/eb3FpZObeRvRfvr928dEk3gus+DJrE9ktuWfPp?=
 =?us-ascii?Q?kqqOJEXEC6TmP9GTtpGh3yWP2TWc09QqEbW295W0iEvK20UP1YSJ2Bzco3O6?=
 =?us-ascii?Q?rhaVj23Th7Pk2EDVkdsN4cfP2hSgkuSQ5b4/DyZfDvPsDTXvM4QJRqcxz3Ob?=
 =?us-ascii?Q?+4yeIj/7np/P58ZYSXdR9CRKv8JQFeFgmCxBDLg2sKe62go8b/vKH57yJiy7?=
 =?us-ascii?Q?yRxYrbXYT/4E8O5/oFzpJkq0JSneNG3f+6eBTs4qqLKpUUB4pgMAnJIJWSvO?=
 =?us-ascii?Q?D6OLu9SaZ8uMxVjgiZTNTDJPxqqu5tSJ4wBAjr8SF3kzxr4nmHQ7yiena+TO?=
 =?us-ascii?Q?YP+AOy9L69mYgqECa89aSxhvAzhEXmB60tgyx3GLji+EduR8RpabStUQKSl6?=
 =?us-ascii?Q?viKAIWr1gw=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb7836a-5365-4b32-a27b-08de4ec02a5b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:13:58.5355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqDENPds/pghCc0wDdKm2YvPiFnoOtBubk7yLMlq+gZ1spWqLVtVA13nkq/5uSczalk8hoALQ1HW9xLwTBVDIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6836
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

