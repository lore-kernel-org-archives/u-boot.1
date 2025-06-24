Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB63C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 13:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AFCD82F4B;
	Tue, 24 Jun 2025 15:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="EFwIUOgY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4525B82D17; Tue, 24 Jun 2025 12:29:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A68882C4C
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 12:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DM0kEmoDaRuFMr6aEEF0wCF8TyJAefrFgPKOTQVQ1ZiH/2YNqnJAIPgMw25tQtW8sZMu2x24tgvZpAA3U6ajCBhbyU8ZTtSL7c0BCSyKa4E07MevRu0GZNwG+EjscdeP6e/zJzXdo92MDr3lCLNvKXXHOooz7rawt/p6o/C77nZm02f6XflWiUjSd0/6BpRCOixbrVLPkKG7ObZbVzcVa4lycVUoRNTr38AUus88EzHj4nU8MB/nkR4PPeFJpQko40uVfLZuyMIahYwx7DUkjfESErIPDU82g5tJwqJM7CoTn3cd7QbE/6vn3RhSg+8WDIl+ePrZcDtEvEfoXMQSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkQtx4vpxlyHWCXNRYujjyY816IXKC8SGnPFiNk2JDg=;
 b=Gw6tGTb302pSLeQE8LKmtgVnHNCxIftrbYsFpgM+aoptE7Vc3notW5XwKrEGuCt8GxhdunbCCXJHTsjQAzG9zIU7pbhtqBvUwutWDudaoEgvleHUCyt2+wgnPaabso7FfuXzzC3ixdbdnEdLmb6CHHw8wPvRM1tAdRp1fv33P3J/Hqa9xvpXFClDJ+ANh55YdUtNbk1j3Ccdg5l7VJ+zgrA2t08ixrWaXqWS8pNIc0bJ38St7fV744HcSZaGKQE7NG7m6so19Uofss2OKmAHFtm4b8g3Xz3uSQjgqPswC9At0qVtxk/1eIEBSp5XiAi0QrF/mKhxgxI1ZzOW0IuTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkQtx4vpxlyHWCXNRYujjyY816IXKC8SGnPFiNk2JDg=;
 b=EFwIUOgYI3icQ4tVkF7aGThr4C1RabZTTA77Aw05Q67eEt+uiBpWcn+S82lyNn8AS8RklGfzCyB6FQ+f7sNWfP6qSU0qD8v4MpyhJ63AKMEFC98DUxvCGdkTU5ZeXQ7MLSU8W+QlXqo1c3ZsQ/GoUgaaENTvwBfmOKAHt2e9+Tn6eJ1ZeJqFVbWuyrbIfN+9/qBUORsbmAwCDQ2ef45RheYH/SiCxq5jU/nXymDS7Qy5mWaJmjmj1XvAevRhj/+ZbEL94ahpVBzX0to93jexUvTWF9EsA3+gT2OcrydYyfJI+KBZ81OwCbo49XsyIiCMGw7VOCXL1YwtoozsMAKGJQ==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI1PR09MB4191.eurprd09.prod.outlook.com (2603:10a6:800:122::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 10:29:28 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8857.022; Tue, 24 Jun 2025
 10:29:28 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v2 11/11] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Topic: [PATCH v2 11/11] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Index: AQHb5PLdfyBMXYJxhkaceQq3SiIcsA==
Date: Tue, 24 Jun 2025 10:29:28 +0000
Message-ID: <20250624102449.324410-12-uros.stajic@htecgroup.com>
References: <20250624102449.324410-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250624102449.324410-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI1PR09MB4191:EE_
x-ms-office365-filtering-correlation-id: 0e5fc548-c7fb-4013-f535-08ddb309ffb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?QB7GoOuvhLmEsRnFwJRvUPFA/gb7ryE8FaeLQUdbmyzwvotAw86/jmhOQq?=
 =?iso-8859-1?Q?9QfjcJ/Moy9RQCzbKn145nvmRwFqT/hiyc1ktTsaGEn1s9PQ2o8mwgcw3f?=
 =?iso-8859-1?Q?PHwGypkT5kv3ofpq09xfW0DFiRhV3Q3wFxuG1tSofFJViWqmYmjhHiDIHD?=
 =?iso-8859-1?Q?D0ODBt9UEnGgYMgw9Cyo8w7UhnSmw1tixQX/9CMEjwdCakhV0D8uKNvFqk?=
 =?iso-8859-1?Q?CmrYI3Ow6LSrxf/e/PimmL92FZCKQAgZXUEKv6I96m2pONE0gDvzI68P+V?=
 =?iso-8859-1?Q?Z95WP3+PRjVXHvGsTWRKQAEpJ/MzuB4q2zMYU0TjpFn+64dewV5EcUARYp?=
 =?iso-8859-1?Q?hxR1GcmoQBi6hZBAkMlcc315a2PLR909ohxzdX0nMKfwj6oCS/JATaqbJS?=
 =?iso-8859-1?Q?QZ7h2Hb8J2gOj0qF2LIOr9SztLWAcuOgSS397V7blKeYkEAjVAzHDi4qu/?=
 =?iso-8859-1?Q?r2Ogj9i3tpnZwh4k1iKj4JrtccCpewQsZzvbt/aLxFdCHD1DMpztk0swnA?=
 =?iso-8859-1?Q?4ldNU0SyogU6fwpiA3gskXKs51qcQ/MjLsVm4Yyp6fiPR/zD8dkQV1zIcm?=
 =?iso-8859-1?Q?wEVX7QyhpddLME/Rc5XJ77U41rubHqwMJUn3Av9qyjyySK9BXklUZ8IuWy?=
 =?iso-8859-1?Q?K0325lSsr9Czq1YAYQY2vEIpBE7gncH1KOoTFZhmhdNvfp8ZW3EWbbJBMp?=
 =?iso-8859-1?Q?OsvPJy9bgqK2Gi+d0ZZB/DbWtbQo2dXx+l0a3sPFpnm9jCTBPaB9AXnU98?=
 =?iso-8859-1?Q?j4+vNPYOrhdlb6xxYJYV5ZFWCazS0XZ3U2+Ks7rMi27Au+O6C9p8w3yNUI?=
 =?iso-8859-1?Q?1C4nsKtfCav9mVthJv4yNK/AeNogb3XJLBUHqQ5H3kZFjSJzkr7c4bOooS?=
 =?iso-8859-1?Q?cR5vDb1esHn92rOC3OGUdUllRMK5IS153/3Da3Z8dRROAE76FWDJrhZnIY?=
 =?iso-8859-1?Q?arlS1IMXxnccYcZG5mQohyKZOkX4jYBjHFT3gxiAXGzNULpP2D91W3z69z?=
 =?iso-8859-1?Q?s0egkRpszOardMszJCiUmOLydaaQQ5g7uzSL+Udna+SbQMeQvPZuIyaXrY?=
 =?iso-8859-1?Q?YaMiI3uI8sjVtBhyLTalmFM6rwjRehUWddBeUjeFyc0tGRmgqSwds5dC1A?=
 =?iso-8859-1?Q?AbXOlhRnvNIEptB5ATlYlBwCOs46zSnUP9IZWUAhI2zjMXrXrxG1gHUVXF?=
 =?iso-8859-1?Q?gJ9366HrDrMMzHDn66SEs60bePJn57UdveOFRLpy2ZXh6V7mOSDX0SMJME?=
 =?iso-8859-1?Q?bsnNKZs8mlJojLb7Nc7hhH8tQ329VzpVQ+40NHufh3bM3BD1wajZqSoFj8?=
 =?iso-8859-1?Q?t+EoPENXWtIVtSrbTtSHHV9bHHMgNxM+zkCn0u/x0DX67fnjjFz3l81wQj?=
 =?iso-8859-1?Q?K47ODoyjLxU+JfBoguiH62PfTPjslzoBi4FkQau+CmSjM+hut319bP1mMl?=
 =?iso-8859-1?Q?F9tmzeprxkBTUxrMnc5qWBiYlbEp35qq1TbNVdWQfP6cd7UkgQfgaTGVHO?=
 =?iso-8859-1?Q?guqnZxD+EK+rP0Clz0ERMpSxnkU97Cc0JFbuN8ba0xeQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fpUzvfW2Rt2hh/OiIkE2AWRkqvJ9pJ7+fUk2m3nzX5pPl3MZw7NwnIaHV3?=
 =?iso-8859-1?Q?MKl6gaIVsz30dW80KQG3ythdwV+WGnLALhwK5p8KOj25cfPz04jQbGSnCz?=
 =?iso-8859-1?Q?/i6HI3uoVIWCDwJqRaQpnNY2SH4RlX2xQRKr6C+/1zS/sKapaiwClB2+wS?=
 =?iso-8859-1?Q?Vzxgqt7DIQeM+AeeGfdW7bZiTakaASfn4DXKK9ZPWarDH+UMBt+jDdTez6?=
 =?iso-8859-1?Q?TP7+SpAY8NLnFSYpfsrOdLhLIqwCm6Eiq2/1YVctzNJxR44VNqTY+3DwLQ?=
 =?iso-8859-1?Q?SouxvmwwhAdFeVN8/VHxjG/YLZGrmrnrDr4PPi2Y3ajNmEzya7/p8mrlNq?=
 =?iso-8859-1?Q?sKL/1ZjoLSh7x8sUERtEutAvZx1SkFAl4KNBPTFR3gpJCD37weEnTUSjT+?=
 =?iso-8859-1?Q?Do8cNEuauU7QWbEDAE3dicMMhRgop2LnsLfJ7rOkfYS2FUeMgl/LiQciH3?=
 =?iso-8859-1?Q?7rcE8TvijdME0tnFcO2VTdJElyMhzUrCM0NWy3+kZ+5a0PrFWy5UzJNH06?=
 =?iso-8859-1?Q?AtrE38Xo6Y9G5wBcsrcK6iupv9NeKkhx4JOlHmMkRm9B6chwyFC4JBbPeK?=
 =?iso-8859-1?Q?hIyZjmXalj1YdHXD1kSU8VuvhLCyxckQGjup83luZFR0GoEQjnhAnFhzeo?=
 =?iso-8859-1?Q?ag7VrrpqvQQqDu8mZ+49jhruG2VSnnYxQNYn1vLJRWkicSixmu7hx2zpK4?=
 =?iso-8859-1?Q?3rfUq8ioiU5XIUhtzDNCOvGdDMzKAj5RjsgUlAVh4xiGHgRCko26ikJKGc?=
 =?iso-8859-1?Q?Eb+H19oohoFEpbDydIVohA8FmpJpFIhWQS8Ii46tGPBVbTK4FHL27rrwQo?=
 =?iso-8859-1?Q?3JBuwngGaV/FnvXCe8yz8pCU7wn9ceuuPn0DphgYXk1IXfAyDweVXVONu1?=
 =?iso-8859-1?Q?6FEhJ5jT/coErXVUDTRSWo2mcdxrcL2sD4U9cDwcWeGzgq8pftLz1l3JVh?=
 =?iso-8859-1?Q?oNoDdhYwdLIVNJtM7DOOvvyIgn+h2MLbD/XT4kYFiG5aslEVHR7wx/6aq5?=
 =?iso-8859-1?Q?xaCi8wdKAoampDiYNLfmjtI/TqftAcKaOLJ0r/j/g3ADMrtBMtt5r2My5A?=
 =?iso-8859-1?Q?FCdHZai8ku5E59x0HQ2ZR8lLpPjW5PNyYY28VGB7AIZm20CXbmOwdeiFXk?=
 =?iso-8859-1?Q?sPKdOTOXNsDa/ShKX4WR9e4xRLnkeGfNevinMr/ovoBF+/3sb+egD8CR/I?=
 =?iso-8859-1?Q?WrlaeMwl7+DYZqYtR10sa2WtOUswZCrGti2c4DJKE+933PktwTXCxwDs4z?=
 =?iso-8859-1?Q?xzBXVxybtdmzlcXumqnqQLyyWrdgCXCYRAUo3zum1kDO7SBn9tmZAtQeGG?=
 =?iso-8859-1?Q?Un11LvK46w30cOAeaRhxbZwNayZBB5DxqQysJKD/nr8wu2+D9mtyAZuRDr?=
 =?iso-8859-1?Q?aZotiC4AfS1zLFIzNUdteIs2Orwuv5uiKVUGdw8v3O0CrQjqw3gvEN3QOs?=
 =?iso-8859-1?Q?hGXakMWEqu/nc9BahumrLE/Xqnwr8t7bN7FyJlEy0Xel8KonNIqlYCU8K2?=
 =?iso-8859-1?Q?jTN9q9Z6IcJzhL6uudyfSAIwrjLE1wsQgLBrachlskpfYaxOS/cs6FUsAV?=
 =?iso-8859-1?Q?1//TKoiWdqxLDdWV65T85k8D7NZMVdbaiXdNpzODDE/JDPfUp32rgQM4BN?=
 =?iso-8859-1?Q?a02a4fs40WJTyX6awpt3XZtp8kcpGw4hdZ1x64Y0tRcUmFxxQRU8Co/A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5fc548-c7fb-4013-f535-08ddb309ffb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 10:29:28.2332 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q+GGpqhNr2IYSDBVjGqzzkJ6gUIM/t940Zp2Ft+UnF4l3JUEFVlggwxg/uzEgdNwyDYpOiElI2sVeRKIuVmbTkjCXWFh+dc7mEguXFN65OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4191
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

The P8700 core does not support reading the time CSR directly and
raises an illegal instruction exception. This patch adds support for
reading the timer value via its memory-mapped address at 0x16108050
when running on a P8700 processor.

Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 drivers/timer/riscv_timer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/timer/riscv_timer.c b/drivers/timer/riscv_timer.c
index 1f4980ceb38..5138236a028 100644
--- a/drivers/timer/riscv_timer.c
+++ b/drivers/timer/riscv_timer.c
@@ -18,8 +18,15 @@
 #include <timer.h>
 #include <asm/csr.h>
=20
+#define P8700_TIMER_ADDR 0x16108050
+
 static u64 notrace riscv_timer_get_count(struct udevice *dev)
 {
+	if (IS_ENABLED(CONFIG_P8700_RISCV)) {
+		u32 *mtime_addr =3D (u32 *)P8700_TIMER_ADDR;
+		return *mtime_addr;
+	}
+
 	__maybe_unused u32 hi, lo;
=20
 	if (IS_ENABLED(CONFIG_64BIT))
--=20
2.34.1
