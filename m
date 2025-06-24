Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7487CC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92B582EA2;
	Tue, 24 Jun 2025 15:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="r3ckCu/W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B35882D17; Tue, 24 Jun 2025 12:27:52 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C25C82C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZWWa6claWQrWCJA2/w1S/SmFRAVY61C+bhoDptS6YEH73CsVI1+JkVTQa3IsRHFrRT9tUaQduxJv1G2Z1BeXJKsleWioaUOq5vcy7x03vtS1Q4wus8lPnjdLTtTzQLnYNATFt7RrGBKqOKMmOtFcjulEdkks2qeGWvTmBu/2CqNgHZvgRCJvjgJlmt8VrUtZrdjLGvb0ZxlU6XU9+S6izM2HjecAvZ7XDA9RKVVFPP4p2litRmC3eAmTv4cY1y+5ILWDW6SQF+/v9cWyZqI7hpZEb4MZLKC6CL/ZIX55OLsNaI4ZpEhtxMKqsL6F6XBieCR311s7uoGEoqPTFLROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=FId9iKiJK0v57psq7yDi8uD42OmTU4mSMlS/wRsQ5yenCoLTC9P69KMqVomXzDFbwArPlUXmAaHFXkneegKWG3EwcBB5480XqQyuSfV9CwZfrqtp6ZKFbdPg2P+5Sq1T9374KBQUBAc0om4hCnvLT/7j/+JwWolKTBe0KriNRcINLo5PDjT0rPD66SlPJt4Vysy9El4hVMxC1FqcN16vH+laYJ7teMBs8nO9WQe5GhYZaiKmJs6Iq66cbGgpN0KSUskPFvn8uJWfx7LfzvXobFp8baZbQWg4DdbXDVqYfsfWyntlqL/OBmr7F8RU0WQ7whMTkzMU+ZT1wgjEIHRi/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeE76XI3qhF7Jfyr/AdSLAmdgEx1F3qtbEyIijBA2Dk=;
 b=r3ckCu/WjoYS2QdojS08Br1rKTK14IfNpUuGEJoGDgy2tb8cvLDPI9mo5KIQX5zVTJsnTto1fb6w4LEC5O08jry++LZ/RfUjNtIo//H2zY+nq5PyBupzCb1PfK2M+UQk4I1p4vmfMkLUFYOuupxrzoM0EsNwOw9VNlyWitOEAlZqZF3JS+hfDXcWJex4azFiFoJeacxxqYMs56CzkXaNYxIHwaWs9wTwdOe97bYTbemZ8rmdmmWGsaGlzJ+GmcyVL69LOVvU1CZcSIE9U653daXTrOo0LBG8DlwyaHlqZmyuC6YsGeI+t8D63A/ZhRgY4nHbDVsUCt/qngwaoSh13A==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by PR3PR09MB5475.eurprd09.prod.outlook.com (2603:10a6:102:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 10:27:49 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:27:49 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v2 06/11] libfdt: Allow non-64b aligned memreserve entries
Thread-Topic: [PATCH v2 06/11] libfdt: Allow non-64b aligned memreserve entries
Thread-Index: AQHb5PKiQOzj1XBMQEm+xzCEjCGZMg==
Date: Tue, 24 Jun 2025 10:27:48 +0000
Message-ID: <20250624102449.324410-7-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|PR3PR09MB5475:EE_
x-ms-office365-filtering-correlation-id: bd00a7fa-e8bb-491f-9457-08ddb309c485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QkQ+N5+NhkmsrUrvczl1Bj422rPmmBppoowVYaoAfim/HwtFE7P8wQLWqg?=
 =?iso-8859-1?Q?hXquHLwjwYJsUupsbeHW2hEkEjCmbzVf+k4Y/SeF+iIJQyAS7Y2Sx8wjqi?=
 =?iso-8859-1?Q?GcLQ4PXyQYjKuJdOBPPx0o8vOt5EVDzrXD7clXyqQhhWMooz1hAEheA9aq?=
 =?iso-8859-1?Q?PWS2ZsxAWoNgDwp3t1dAmmdStKNtExJMcHaMGxgqbysopGItQRQwPl6P9s?=
 =?iso-8859-1?Q?AYSdN7rzuVf3kTLgI2JtXPUcOuy0Nug6RNJWYDHRvKD9WgSFXtkeF1YTse?=
 =?iso-8859-1?Q?3uyNtqBFquDh1HlczZyhBYojp1XrYk7C2A6ckRwOuEMaCk/6pFb+t/8F4c?=
 =?iso-8859-1?Q?IMSDgC4p+VNk2BsXLre4XIX/0vdUT7yZvPhtHnTlz6w7nv5Z8gadWzvN7n?=
 =?iso-8859-1?Q?C+QoFFfdEgqJw/njJY9wwDzxWOk3WboZ72qEQQ9FcnA64VBn+uBGJkz+zi?=
 =?iso-8859-1?Q?NpPxQHlpJAtClHTBFOrswQBtwS1Q/TMnGZjw8tnh4ohOkNLXIWvoIKQwX7?=
 =?iso-8859-1?Q?Z6BRzmVxwUQB9cqiwT//JpooDDZdPWK/BWd0VbZ7jWdN1svIWmXNzweRs2?=
 =?iso-8859-1?Q?XU6X7xb5Y41KI2K8dL37MXQT9BwIdJJsVTiiaF41WRgoNFYDMCR53qRSYN?=
 =?iso-8859-1?Q?Bf0vGIAoeJ/kAwj1WHV4xRfLoPNaJsaaM58JlLbNmPqnZ3JHmGwhy+0knw?=
 =?iso-8859-1?Q?OJM1SyVGSXdA6basJjpUb8Ls8wNyA2snEv/0ECS6cbdbX4cMynS8vqsiq2?=
 =?iso-8859-1?Q?oKkm4TCRjqdh/nefvyproRINaPT/eTbrjoR0AgbvTNoMFGvfW2XjQ6CulG?=
 =?iso-8859-1?Q?e9zkMtvrWTfnMcchvLIoYGZUbAJ4hbiNvHyRFCqeZ1+GtsrEiGMoyqkhai?=
 =?iso-8859-1?Q?hqoUTk8xYrmqBqBL9rhG+HPl1KDu/kLsQjz3PUS73L5/eUXPWy/K2DpvOR?=
 =?iso-8859-1?Q?BqOSftbWd5qUhqo3LAIOsmpcYRj1mIKkuDyPGHpSr2OEJJ7xY6yH0NSjBa?=
 =?iso-8859-1?Q?69GCmJmrXxjwI6oOXB1FMsmLcMCXWC36AgMuLczESzEzyuK5wjt3G7pF9n?=
 =?iso-8859-1?Q?x5XNpVCpXl04z9KZDDqnd5VeDWavULrfHrJhwxpKdYpco25iRelyvOSF3W?=
 =?iso-8859-1?Q?oS50R4OF4Dr7ZnaDwWZVlGJBKfQo+A6pR0ODYDDIZFLd+Q+oL2OXB4K16s?=
 =?iso-8859-1?Q?m9k4tRKRpNBFzbno4sp7upaREZOoH7EXKaQTy+i+qIF9Seo6V5OH/hu6/B?=
 =?iso-8859-1?Q?2Q6XgOwh19xUM2jgfHdIQnJQlAZLQHmlbEtCD7eKy+pD3HTKqqFEyXj+ky?=
 =?iso-8859-1?Q?MNk9m9+E+fzGw/bVP0vriBm/Ctw5HvMO+sU9Yejk/EFsm+S5VqrwKCLet4?=
 =?iso-8859-1?Q?JH/0zAa+bQ1NbUf4A6HtDm3yRFstYmPbZjXzTpIpV34wUpyoF6regPlvie?=
 =?iso-8859-1?Q?pQDTz5Awt5nnesjTYbelRMLT20PZfAauFgtleUZicHbd42LIx44eHMH7wj?=
 =?iso-8859-1?Q?wsDGrKIDERpxuwYnDBE7SAr5TgoBnOJ2C4Q8UOPXU4bg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pEYhunYuBbZr7zQd9DqnfLS0OVPdUHcyisHrsGx+iCXzsD03c1mm1NedVz?=
 =?iso-8859-1?Q?pr6s9uZ2467+Hd9/KxmPZCnW72qxtU79S3ZC67I3clrAU2NOmwVNDCEyuc?=
 =?iso-8859-1?Q?1+++iNAKYLTdU5xLtmEkDScyCdRHyQwPtid42aEH2JG8e7UEtjUYc0hFm9?=
 =?iso-8859-1?Q?jmxjRxtUZX2TctdKFD+4589CwHtxkbSqOZSFDmbDSHehJQsMrcLyaT2Lkk?=
 =?iso-8859-1?Q?iBJRqAHLZ7TF+MFog+66+QewPDkASNNsnhsjtSBKWj492Z1Tzd86am8gW3?=
 =?iso-8859-1?Q?WCrqFWJgK6PMkBDY6XIV0YVTs7fj34vNgUQ6U4pDQ5ym54VOdQt5vxbluQ?=
 =?iso-8859-1?Q?MoMhyVcRmdhdKddfis93VjTNzDBUyOdZxCQ/G8kXVsqx6EMvxRlc4Ar2VX?=
 =?iso-8859-1?Q?FXE89JMGwGl+34qi5yIYOP29xoSwXGyZY2iaF4M4WNDqftbT+y2umS7CKq?=
 =?iso-8859-1?Q?N9X2m6X4s4weYiBoS1O8yNOMx4lCxBcgzpZAtghxfd9ayJymzOFpen3Zsl?=
 =?iso-8859-1?Q?JpYV2XgBtY5ZFNd5RQtsJ1hurTjJxbjTo6gKWBaulPziFp4FyTCOzNIN6e?=
 =?iso-8859-1?Q?LhPE4xkwqzF628tAacxVl7cd88MplOPMejtANDCvzL0NOuizS3rPRthbdV?=
 =?iso-8859-1?Q?b8QvFknxz/oJKuaCsWyYFt0wL8Y1KrlxIb51N2I9PoC1TtOD+KFme2RbBM?=
 =?iso-8859-1?Q?/bxGDJVSyxCrGEiysrC7WpqBPVa8oTMzSJib6PKP5DWZT1k/Q1lxDTz3qM?=
 =?iso-8859-1?Q?VSbgwoGq96J4xtCvWKOAW7JCKaNJM10sxKCbFD9ZcPXehMG6BpVFwrPCiG?=
 =?iso-8859-1?Q?ANIR2Hx2QOePCECG1HX00K7zD4VH0LOJUHeg6VRYNDDWBF+7cXlCqgK5UD?=
 =?iso-8859-1?Q?rzEpmP7oOYCjs5ey/QlXVpFNpL2wOQdkw8nevRxXZAsafqPzyo0PvHM87T?=
 =?iso-8859-1?Q?bbM6gWvqOhA/RdHa5jAdL29Vrc9DfmCXMUX8kO5qNWis9gLig3IxvaZLqx?=
 =?iso-8859-1?Q?YJiI/A7n19NcVK6Ji0Q9oiuCbtmH4zcJ9+NovmhppUu/Fp+hXdEszHrBK5?=
 =?iso-8859-1?Q?tfp8v6VbndUC98H1xqtltylakJYI0WV2TnvQoQVlFX2C0s+hzsJ0DToVwM?=
 =?iso-8859-1?Q?4JJgdK6zgjox3navLe+sc5jd1v35YqmRKZxHj9Oi+8h5zxNipbTvwfz84v?=
 =?iso-8859-1?Q?Jw+lPQTCrbzQccqO9OL4fMohvFBucOw7MZJ7YKsyA+tNGcccbo/8MlNbuI?=
 =?iso-8859-1?Q?uGOG1oq1hKZexepNwMtiyAkFE8Z0jYyjluCmSo5AcDDyCw315GVlAGg62Q?=
 =?iso-8859-1?Q?DeZ0COmFDkaupNGteFrmhV0gkXrv2FL79xw+ttzPieAqTm7KCj6Qqki6J4?=
 =?iso-8859-1?Q?j482vu766BVnzP9vv59X426jGXW0YeWR99g5/PgUHH/pWPvV6aR9ZATEtC?=
 =?iso-8859-1?Q?k6Xkpde8J2mkB1oUu6AG2khMCIGuDABLfkoWE32Xt1X5bG1vBSmEKXohN4?=
 =?iso-8859-1?Q?4Xqig6x4cU6K9gWPFUy4JbvvuO7Y89vfVjZvAhWVyqOif2l9CaXzwJ2xdC?=
 =?iso-8859-1?Q?DHvP8FRihAfTeuy/3sIgmk9zfwmAxVX89rZWoF/r8WJNV2fRo9FMnMTsRV?=
 =?iso-8859-1?Q?Sv/XqC7gLIGNjmYgqS+poAKtJl+sSeqXm8YRBT6x/kVL/2OZZH6jkwBQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd00a7fa-e8bb-491f-9457-08ddb309c485
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:27:48.9357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcyVz6tBG89mtL6wxRy5ZVvpCrLHsfxx8s+g6xSdsIH0IBgMjMdiNZ+Nj5LZ7rdIAGjGPJQvi+TaS7gyExCMpy0g0s8YKHScwZsgrpi0jGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB5475
X-Mailman-Approved-At: Tue, 24 Jun 2025 15:12:20 +0200
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

From: Chao-ying Fu <cfu@mips.com>

Although memreserve entries in an FDT are 64-bit aligned relative to the
start of the FDT, we cannot guarantee that the FDT itself is 64-bit aligned
in memory. This is especially common when using a FIT image, where the
alignment of the embedded DTB cannot be controlled.

On systems that do not support unaligned 64-bit memory accesses, this leads
to faults when accessing the memreserve section before the FDT is relocated=
.
To resolve this, copy the 64-bit values into suitably aligned on-stack
variables before accessing them.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 scripts/dtc/libfdt/fdt_ro.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/dtc/libfdt/fdt_ro.c b/scripts/dtc/libfdt/fdt_ro.c
index d65656aaa8b..1c18aea66ab 100644
--- a/scripts/dtc/libfdt/fdt_ro.c
+++ b/scripts/dtc/libfdt/fdt_ro.c
@@ -174,6 +174,7 @@ static const struct fdt_reserve_entry *fdt_mem_rsv(cons=
t void *fdt, int n)
=20
 int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *address, uint64_t *s=
ize)
 {
+	uint64_t u64;
 	const struct fdt_reserve_entry *re;
=20
 	FDT_RO_PROBE(fdt);
@@ -181,8 +182,10 @@ int fdt_get_mem_rsv(const void *fdt, int n, uint64_t *=
address, uint64_t *size)
 	if (fdt_chk_extra() && !re)
 		return -FDT_ERR_BADOFFSET;
=20
-	*address =3D fdt64_to_cpu(re->address);
-	*size =3D fdt64_to_cpu(re->size);
+	memcpy(&u64, &re->address, sizeof(u64));
+	*address =3D fdt64_to_cpu(u64);
+	memcpy(&u64, &re->size, sizeof(u64));
+	*size =3D fdt64_to_cpu(u64);
 	return 0;
 }
=20
@@ -190,9 +193,11 @@ int fdt_num_mem_rsv(const void *fdt)
 {
 	int i;
 	const struct fdt_reserve_entry *re;
+	uint64_t u64;
=20
 	for (i =3D 0; (re =3D fdt_mem_rsv(fdt, i)) !=3D NULL; i++) {
-		if (fdt64_to_cpu(re->size) =3D=3D 0)
+		memcpy(&u64, &re->size, sizeof(u64));
+		if (fdt64_to_cpu(u64) =3D=3D 0)
 			return i;
 	}
 	return -FDT_ERR_TRUNCATED;
--=20
2.34.1
