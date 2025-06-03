Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410FBC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:46:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A23D882D66;
	Tue,  3 Jun 2025 16:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="TBTP7F0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A2881E72; Tue,  3 Jun 2025 15:41:22 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A20F80F9C
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTXeIrN8/yahIWjdIh8PgSh6Q10XGFiyhO/6HBNcm4c8W4RTVWfklI6H2Rz3QUQQOE8meVYIKzAlJTx0p9bXUR0DlIxoAjSfXUxSfwdlxp91dox3pOSf7CapnxT4X0vRe627F2yIGT5eI0r3Ye0MjaxBYPz+VQ3gTmuPvBqie5F4N6D+QvaMPWJhepqO0yZG1Gza4MAvvexACKrJAPADiLZ0+/t2xc405zjGetkZkANBIngatISdJUzeBXdsTdFzKWHDcdzJnMReK7YUkuA6+jzjg/3AH+j7Yg1PuCHMQvT8kEWF0/mQfjQO/Sn/pqzArVC+mUKQUr2GUlrx9Sm09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkQtx4vpxlyHWCXNRYujjyY816IXKC8SGnPFiNk2JDg=;
 b=lrptoEhjv6cGR6xRC2vG/r159HN6Ex4KZ56FKgpe0v51k6i6w4LNiVSpfpfCb+XcjCmUFQ33iCN5/W07wVFxcSMEEL21Knvs0d7dfjHuzT6Mw9YJP67GD0ZVA8AXG3InbxodBviS2W3fyeFJtrKGTNLGMnqp4eNzcZxWO3B9eFXodDl2lYWvw4VDPkH6cTqcRNCqSCXeykiXIm7RaGudcPeZJrtgSYeoOOQR0J/yJdvamnKrIRjd5xfxBX5998uxCR5Gp31f4KdC5oQM1PtpZjtELlPQ7t4q3Fu56jZP2ToOkLpdlNDybvGmyYREpI7usMs9racz/BGvvIVssQPKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkQtx4vpxlyHWCXNRYujjyY816IXKC8SGnPFiNk2JDg=;
 b=TBTP7F0WET9MIWvUwj7YeVSu0AyPDMqAnmDGsjklpCBZqT8E9ukSg/y7gSR39F48tq0FGfqYhb8iO5hN8ZK5tRFDgQwaA+QuNDfFttXTEan9FOjfOj+SgnfEj1p07G56dTq2G1dAmVYh/H2YgPiV4GU3kFmah5IvnLfXJOS+CZOnQikqMNkf1MicyJcm7QUxYsQPG/z4i4504yFp0wwpgx3oh+OLJL9i1xGrWl0JuJFboedJrDK6ztWdMJxXXMA4jVvnYTLCg5GBU3UiQhcWuUNl0DxZfHNNGmO/bpWcAj3xbS6llmpFi5dsaVM+2Hdbqf66T45/NjxbijL1HxusIg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI2PR09MB7303.eurprd09.prod.outlook.com (2603:10a6:800:223::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Tue, 3 Jun
 2025 13:41:17 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 13:41:17 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH 11/11] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Topic: [PATCH 11/11] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Index: AQHb1I0u1p86RKGsekGfXpRDltLhPQ==
Date: Tue, 3 Jun 2025 13:41:17 +0000
Message-ID: <20250603133744.278790-12-uros.stajic@htecgroup.com>
References: <20250603133744.278790-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250603133744.278790-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI2PR09MB7303:EE_
x-ms-office365-filtering-correlation-id: 57c46a97-3855-40f0-9ccf-08dda2a45121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BwzJ2YA18FzlIbQzfgvmRE7AYuyH82feQrOuIeyLKd5acTxkDwOAg9T2gz?=
 =?iso-8859-1?Q?GHRuzkbQj0VOl5MtEiwQH3oa5Pm517DRfAweQW6F5Gbd6pILGHvXlIof6k?=
 =?iso-8859-1?Q?N0fcbu7USuzT5nvTu4m3iqAlUmJVuk/zzLOrXGFKw9OvMaglz+HxG30yBr?=
 =?iso-8859-1?Q?mIA75mzuwS5uJBE3RIeGL+DN0aNcK/xu/Csg6jV9DLiAzECe+GiyAXe9cR?=
 =?iso-8859-1?Q?KqR86FfLmj0OqI7Qfr5A5vfip8iZiNs1aX1exEnXP4IY/qGvVNCe4izxZR?=
 =?iso-8859-1?Q?SuypU5DBOv2MUShz3SNufiLeX1H/cxCUF2q+QoxFBatLWuXkcWtEa7AGqk?=
 =?iso-8859-1?Q?A00XLQRWn7SecOjRDPvu8O8HqsN5x5N5uJY/VyEx1nHKnh6gYJsxXhmlVk?=
 =?iso-8859-1?Q?Fr0H/2a/cBYPScTR6pmdiU18bphzoZl7wh7h3vw4L6352cJl0BDD/nCXtS?=
 =?iso-8859-1?Q?2twO54zROgUN8EWh4oM69WO+rv4w0vW4Ickht//Y3b71qklF8Ua9ZiXgIJ?=
 =?iso-8859-1?Q?/QqgR0u1Hv5rOQpzNsWT6/gEjfEYf3rpz1RIjeQ0L4RR/XL2rXF2DIccdC?=
 =?iso-8859-1?Q?srxLoDGGwp+lrZE49IJtkfdLhiYbZmiavcwSWvpvtRdqvhforJcK37xvxf?=
 =?iso-8859-1?Q?bR/cce7J3+p+mMp3aBWy+e8xlkymluwTf4PY0GlRlF4MQ+Co7s3/1sNBGm?=
 =?iso-8859-1?Q?kUxTuodWc0rChVsi5c/1g6CGgaVNSJzJ/r5bfy0zEAUEPTVNREN4tOQUYu?=
 =?iso-8859-1?Q?rgkvRKa9NZ6oCdGyZg1bfi6Utvv3JPv6iHZfUmBmb2gnglb9PK+OCONNUA?=
 =?iso-8859-1?Q?8dgABhxWu3wNcmK3SvnRkT3OzO4/uaOegU+ZlwFCpmbyt6/qq7uuzpUy4e?=
 =?iso-8859-1?Q?grp3GwxdYQLxkLn6OdkX8Qz4eA9lMyUrLOlSFc5ypTkUt1agJxXW96vY5o?=
 =?iso-8859-1?Q?XqKXHYrSdn2QCk5+zkN2lbm0oy+LvW+T88/dzm5qzgeA1TFZ4tfsP+Dx6Y?=
 =?iso-8859-1?Q?lPAKidN8Du3Y1gqQKyBP5D9G5/PjjCYGwn7XPMnIv04RdqRluA+AIETOUj?=
 =?iso-8859-1?Q?O+OSqd2ifX8G9gW6fPASsLDwA/xJgufcevvs5biDXjAfsBAR3GCPXyTDbj?=
 =?iso-8859-1?Q?QepUuhGIsThLDt9oq0QKA11wyBW4lc5frENgWVrUMxYqzB6pwTikPqgcQJ?=
 =?iso-8859-1?Q?uKJ6nq3fKfAQM9l48vmhJRiydw+5CB9agpSZRO8g8dDbcbwAeNHqVQXfVL?=
 =?iso-8859-1?Q?D+MBMDOCCcded91dQBBHn9KauioBh6Q/wgvfVm/Q7/1SoE0LRFKusR2p95?=
 =?iso-8859-1?Q?EvWFYcTfitATjMfsI231kfM53yduivEHHx+NNDBqVLS6dDhWGYFBWoTJb+?=
 =?iso-8859-1?Q?UG+GmpsTTcOmO4fByf1ohyHPFKTRd4IxCFX4UAXr4Mn7159vQ9mqhcgGS2?=
 =?iso-8859-1?Q?JzoDuojIm6YFv+vO8G91b18P7BvLaYWCmbUrWY7Wep0gxvYq1eDnU2tuSj?=
 =?iso-8859-1?Q?zK/RGJhyx0TOFst/kzzJQ2KH3sMYLO4AIYGik6LYwYWdBS6QiuDkX/UqH9?=
 =?iso-8859-1?Q?Dyq9KbU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C4AB1rup8TbFWOeVMCKFIQrgFQE86pcXTCyKGz+25/B7KQDe+YVZbkBH7Z?=
 =?iso-8859-1?Q?o1pUqkRwPvn8YTXShchbdqGKbok+zm8AFpON7EnQDYuxQppdPTUpwEAw96?=
 =?iso-8859-1?Q?SN0lI63/txkIUP1BAobkHWTqnTi1Ewhc8MfATWFSKX9pSqcWGfxZyyHkb8?=
 =?iso-8859-1?Q?j1XMA7vIPh7julFDLInJvCgjCeglvpFAqcHOnLA/wExpJUb/xMwWvHB8za?=
 =?iso-8859-1?Q?Vd4V/1yMu6qSkw3QghnRMilfCcJM6pGA8ojoyK7HBqax1kMd2naZXWSVf1?=
 =?iso-8859-1?Q?KCP6XLC60ileoQfSgrXlNy9qbggZEZab3tq5zwu0+7MaLtqkk/Pm8cjUNb?=
 =?iso-8859-1?Q?DBv7gUqE0bKColMjZIFeeRXgVM9xokfApi7HCaPTfi5ZJw+5JZ7iisl0/s?=
 =?iso-8859-1?Q?C+mrFtuSztcyO5Kv3ka/KQHKx+ZpS0yP2AtXSMgV1V+feUp6tWRZ26XlmU?=
 =?iso-8859-1?Q?fcJOal+yRgv3aNXZIQ/ng5deyMaZ6JDzJ88JQp63CnAf5o4VBpZCGnikLm?=
 =?iso-8859-1?Q?fniTmQouMhw5AokYRqHw82Lrp8UESHso4bXsGB5ztTdOApMOqELRQ580S6?=
 =?iso-8859-1?Q?4MRk+RpxA/xbQPgwq4naswvjSSF11UuVMcL2nwxfM1E/uCO4KahO9zGkqo?=
 =?iso-8859-1?Q?Om+BRMArcuAhuFP8f49q4pq7UA+svz+K850+nvi+sl3wmdLkwVlhEv5YH3?=
 =?iso-8859-1?Q?NQvQbEUDqEI60eCWfkL896T0ubceIuYVM3g2ap7L8Inwtsw5G8Qoc7Hulo?=
 =?iso-8859-1?Q?MZ8/4rZOfVbw77y4odEjnACUQBBPIvg+W6/n+4ojmYnJyzr0MXwBRjgtFA?=
 =?iso-8859-1?Q?kHaKRlI1Gl+Gxtq26InraSCiJTfSg036Ae/dEZX0qRD2nIVbdQgQd6zvGB?=
 =?iso-8859-1?Q?jJg0Do+Aj7YJKlRhSiYO83z5s0Vl068AlSZdakJWjaIzw/VDWrt75E39rf?=
 =?iso-8859-1?Q?41TZBq2rKAvZ76y9rp8lnZxGOKpipwo7AxShq28NqFiIzAbMOexbDDvyND?=
 =?iso-8859-1?Q?8x9Y5McVM/qkh8Lrus+bSwZIGmmteh09hRoaKgaO5MM+53KjGjglNdR0p/?=
 =?iso-8859-1?Q?pWrWs/rkQSWS2hI4YKkJbfz4R5BYYIJVHhdW8LQrcCAQuTtB4tpMXC+3EA?=
 =?iso-8859-1?Q?Td3MHJpP2dq6jMsU99zlXqRiZwr+Iw0Zrtr6pxTQHQF3BW1K4zC+2Lt8/O?=
 =?iso-8859-1?Q?GrikmSAEo6Ak50+cx2IuSBlfzBj1oH7xDKKSJADzg/mdQO0MLNPpWEMqna?=
 =?iso-8859-1?Q?3MMsF+c8FJnIRl01L+zYO9gmlUqL2zCnsk3rbJTAxVefRYzapk990HC1zf?=
 =?iso-8859-1?Q?96HqTisQNK5o7lr1YseH/mTnswSOh8uHdHSMaU/KICZpjgnfULsqRBO52g?=
 =?iso-8859-1?Q?7Pkj633AwXAbpBzJRSmByHlGwgiCSpXYPmT/5ZTQcxK13GCKtb+HLOB09G?=
 =?iso-8859-1?Q?P8vPfEioSF9An127m0oORSLN9M65E4NU0iv+EJln1nVRu3dWXalTZc/+tX?=
 =?iso-8859-1?Q?MY37TpHm8Q9RApeaWRhBz/EADzEXwMo98MMGElm+scL7esMR7dB5mJnjFW?=
 =?iso-8859-1?Q?1vQy8l1xHW4m7Kc0+e9v/dX40vd0/DZwAXuo7tSdZXLaabBTjBzLZGbwTG?=
 =?iso-8859-1?Q?M4t8mxo0O/oeQMcAk0Uy5iI3UNxGB2Sy/fbDrlxzAz/uXXZuTaRlBrfg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c46a97-3855-40f0-9ccf-08dda2a45121
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 13:41:17.5405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rO2EFP3gR/k0rWSPg80vdIGQdU6XCZ5e0h0B7gqV6VciAwNcJ9UMXP7jSbfQGWWcmAILYHjA2/szAOM77FWwfcGlhcp0pEy3mByAktrEQUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR09MB7303
X-Mailman-Approved-At: Tue, 03 Jun 2025 16:44:26 +0200
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
