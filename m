Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 945C9C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36FA48331C;
	Wed, 30 Jul 2025 07:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="SJM0Uh82";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B59882F00; Tue, 29 Jul 2025 18:25:17 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6F482BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZD0XAUnAQCNDu0rl8lQi6HifwwxJk3C8HaJnfMZN9yX2wMhAiNBSxDgA/HDnfAgwFQXTYEulpRNm6gbjqSHVemU5x4jyamwzWVGKke9qGB8NxHpeP32aHe5RbyE+/X3wPBVX5y9hz+mnH0htV3b2FYeWQ4Crq3e4NLNrS5Kf8S1JVsTq/M2BVbvsYSfea9Z/bLR5PPubzyXmTCJb8e/3VH8mH68sEDcp/UQs+Fpb1KFcyMLLLjfbH+O2AM4ruhTJcngFjjqJ9x/GoE7iw1gEQBgu6dTyWJ8p/ma8/qCIRJmn71Cyxxk3w/1EEML63usc+tN1D8uNcjuZaW3t9+XTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkQtx4vpxlyHWCXNRYujjyY816IXKC8SGnPFiNk2JDg=;
 b=f1NIPyilBEYLQ7/0gTe6sjBfWeZgKCQxa9h1iC8CJDiROSota1+ct0fWBN2n26KIBBiAZl/JytvTfhAc7GkAaIEJ58yCsAFg4xCFa/Eoss60cVUWNC3t2UMfAt6qzd6Dtse/amQ8UHv1mUhIkwfELervb1Ap1C3+fMbuMTUj1tcEV6pZL4lLjLlyfFoaywef76UvLwR753B6jrwbmqFWN4dsb3l7FIEhoi9tKtTWQT8MR7f8sHv6FjFFg0bS3MJ8tF7AkESP55OxV+DDzrlf7X6WsPQbEkWbhePbCYmkkogyEY+/VWfXbZBJyaPabunwXDOWYJ3EbifB38t3BiWPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkQtx4vpxlyHWCXNRYujjyY816IXKC8SGnPFiNk2JDg=;
 b=SJM0Uh82bXE5glTC5lfkyMd0G3RSQV2JKUFV/FkggHVnHpopAe5T0RDFHjLFAJzepiqHdAylzdS2lMQG76l3EkHMKxENQ/Vg5puRIT05TSfwX17SjjMl25x12pbAJHU2Eqt6X+okX5FdWiU6CK/dDo0RnuEOFrS+OZvzi39iUDjtioQG1wX/lfYspc/+sRS4F/Drzv/ULgSmAwm3C5gZpDRi+9z/R5ySPzP64kEoWxhamCyAG+XRdVxg+8SbOPxpmvktfJRBwaNaWt3JE/yieDOMJ+1SeLJXDX8VTdjKe6r2Ffs2xQm5H6WpwPDH92+eo2Nvqyqxj4OyWWwQPFb32Q==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by VI0PR09MB8338.eurprd09.prod.outlook.com (2603:10a6:800:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Tue, 29 Jul
 2025 16:25:14 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:25:14 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Uros Stajic
 <uros.stajic@htecgroup.com>
Subject: [PATCH v3 12/12] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Topic: [PATCH v3 12/12] timer: p8700: Add support for reading time from
 memory-mapped mtime
Thread-Index: AQHcAKVcpmvHGbIIWEa8cpsUoyOLeg==
Date: Tue, 29 Jul 2025 16:25:14 +0000
Message-ID: <20250729162035.209849-13-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|VI0PR09MB8338:EE_
x-ms-office365-filtering-correlation-id: 166eb803-d21a-4b08-1e5c-08ddcebc7f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TKRJpE6FNAgNtURgRfJPsaMwZu/NR1SPufuR2dIqWD3iagv79e+ow1w6ne?=
 =?iso-8859-1?Q?WjU5yTnQiuRmqwfZViatAkJIPE4GHDRxGl2NfVK+l2ewZpeZMKkVYjPWYO?=
 =?iso-8859-1?Q?3290x01WbuMroajXkEuXhkOliy+20qK/PAS/MnE2akpTeLkBZRT6MGtWzp?=
 =?iso-8859-1?Q?sNawDS6CZSEwUJzw5tyS0bz8uZS2W+URXTVJ4YjZZCY1W2h6w82eCVL0NJ?=
 =?iso-8859-1?Q?UbsrhqYoJ+ScyuBOsGDCpqMhvH4TLYGVMp99M/6tDLZuzW5EThLwf2a704?=
 =?iso-8859-1?Q?oIIAveUWYYk2nSUueGDYOBMlF8wjLV5fOOqpDN9OVSrEc5ktpl1aoNG8g4?=
 =?iso-8859-1?Q?ozcjNfZWZvYUXWcq2+/YSPo7w2VZn1PXcCYUpGqbeTnfGxGLq8KPc0egJE?=
 =?iso-8859-1?Q?TzwAFAw9jNnHXK7AiGskZN4zKiGkQLp7WHCG3ufTpGZFElP1jXhEQ/tIFD?=
 =?iso-8859-1?Q?jYmYJRrMqORTARXnIdniImVcJ3m65XZSwuqDYNqkY/vvz3pQ/bZQbDoh5B?=
 =?iso-8859-1?Q?J4BAxwh9uH4Ntwo9DtTFsiXe8OKLTh3IgQ/R5hahJ0KI3T9AHYgxYOHjww?=
 =?iso-8859-1?Q?7UGY3VY5haqkqqttuUJwzUfg3PMZQ0B9x5BvDmcCeR7Q7abBnfBEe94tyq?=
 =?iso-8859-1?Q?tB5MHr0Y9nDeqB0v4rmMquzPaSDu8FMes1n3osNZ9NG90w9zhpK2q4Ht1B?=
 =?iso-8859-1?Q?DvoWcKyb1HIeQ5Rs3aJh9G5Lm0Fb7YMkY3y9qSPzl2Bu/zReJhnGDdi9Jv?=
 =?iso-8859-1?Q?KobXStxpifwJUmeuttJAQJ+IJpjeFEVj1Yc0ZguBu16UTE0lUvF2RSSRDr?=
 =?iso-8859-1?Q?MuDL6Uvuczru0Ccu1tQ4wAdYYGJU97vlOJ6LJIYq1tpMu6Gyf1TypqSo4U?=
 =?iso-8859-1?Q?nvz/KkwYmre8DX5sCISZvxKUVXCXc4TjvJ7Du5zg9genbwNAZkYUv8GpzN?=
 =?iso-8859-1?Q?etPg1CiNvR4ByTtfPVvVh8k1TKFEYb7ZSONWbgD0Pa20dJ0y4UkfLSk3+8?=
 =?iso-8859-1?Q?8plePaC+Z8tQ6aWt1C90zIu4s7u8zCjEqUH7VLnZnHHf/sqTipKU+C3i7D?=
 =?iso-8859-1?Q?KZBn9Lotjtxd5qyDl8eDKBkoLQL/hNGwfhp5sDQ53Pjqi8dFI5/McgtLgI?=
 =?iso-8859-1?Q?curY36wSCOrlji1tgdZA/IZ38ZpFPXxuWQ0FPSDeP4ycOdAQDjjV7lZdJP?=
 =?iso-8859-1?Q?wXb98H0KzQvbelN7cl2swbPX/rp6RE5RUrz/A6jy4ixbWGdNAWAMwJvKMs?=
 =?iso-8859-1?Q?vzKG22CcwnSPjHp0DGIk8DIuiu+737CuX+NQy7C6srfVbj1r1mKaYu3lFJ?=
 =?iso-8859-1?Q?0wA1ireKQEfvV7NPgmn2SahWvpXEMYu/StMoA9WsPGEWWYYylFMHEaJ+j6?=
 =?iso-8859-1?Q?9VWZrUaVq0VfIDyABfq3LbP+dUHMKOYRq5gW+Xx4IlyHAbm44MSBlA45pZ?=
 =?iso-8859-1?Q?NNMdYJQ57cWMQ4Nj/0xT/Lv0Z2O2bgdUC1UG5wvBIdfVZppw1TSNtr9kdJ?=
 =?iso-8859-1?Q?LdyKH00aNSGmgomhzrP9pMgCTYPBymaV8UoSiwbOl0eA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?enqewUYMiLmCwd4fLo3KpOEpGCQ9o7mqHDVfWK2nuJ+0zOtenT6sV8PVci?=
 =?iso-8859-1?Q?5N7EJ92WIZ9N1UkJNR4pb8JyUm80dGv5DMaWlL3xZgVEK3VPzureglgzdP?=
 =?iso-8859-1?Q?9NMmpidpazDdLPY7SmmRG4Bm754T7mg0u5ueJbB7T+TLPV+Zu4YJT9hdcQ?=
 =?iso-8859-1?Q?nBInwqR6s/CGsY8mVLLBFX+LHAcLon36mkjM0O3ZMnrMi3YTqH8YjvXE8C?=
 =?iso-8859-1?Q?j/3LOEJiV/rix1eAlj2UUhX5he8prJV73XUn3jiE8aoNfN3DUixpp6hLJL?=
 =?iso-8859-1?Q?cJAlHA27QjtfBOt6ubTXdnvyvaVA1hdb5NfCL34vLRa93mdEKaiGHEypfk?=
 =?iso-8859-1?Q?xgqPEj5Xewy+Anwfzxmnk6/Ym4EXkauFUDETDJIBlkqMafMnlVSiSI1GsX?=
 =?iso-8859-1?Q?aSgl+xc3b7BMpve9kqHRqCC9yHipVY9pwzLuJILTD51xF6TJb8zSQTVa0F?=
 =?iso-8859-1?Q?USTltTisCxcVlAoZ+J10Ohp9t04RhCy3nyaRM1XI1v4vTCLTFqFRXWktMd?=
 =?iso-8859-1?Q?MkpZG/iqOfSypHHZAgT7hB9lA3aRmXt3tJFg6Rxbh08YRwePyil1iBZDOX?=
 =?iso-8859-1?Q?Ry1M45CYGQIepSL2R+XB0i7lP3M8GHVZvcPCoK7vPydPSeJZv9HUBLMIKl?=
 =?iso-8859-1?Q?bcXojKOeUoQlM16B0wgFAxMsWICRVGBsx6OsgnKGk1rHeKx1IcVH1NOUJt?=
 =?iso-8859-1?Q?wgWYQqDLc5jixT3qGtpOSXjXWqTatkDyDK+zdZ3OAiSVjy7k/QM5hth/xm?=
 =?iso-8859-1?Q?LWQZ6W6Z6894djlC0ObK4UCFBMDLb/Q0ihf/nGo6srfcwjdulDykmsYwoq?=
 =?iso-8859-1?Q?WteOlA+6FHgEN9kTx4qE+Zkym/+TeGhjX+KvSJcKtM6Xbz9ovYTl381iCD?=
 =?iso-8859-1?Q?Zj1pc+z3sEwMdsWnZiAbWUwZlDu6S2peo80vievVuVGgHkb3A77kv6K6Qv?=
 =?iso-8859-1?Q?0axEenmKHY1RO9WJIfgyCPcFmrM5RfTasrvDTIW4K3siQuJ2IaMeQTAfV6?=
 =?iso-8859-1?Q?3T7xT8SLDn15FgJ9kf21K1c0Vc5JJb04Qz9j4z7J6RdEwUMdzKrzQN3d0Z?=
 =?iso-8859-1?Q?8YlCuBempR7+TJ4Nc9e3v8879Tb1ET9svZh619RWz0iS1xk5Me1z6fkYjI?=
 =?iso-8859-1?Q?hEWGBRyRA6nyVnlSj5jParcACR1EFffoAYlwnZaeXB8nEFOj+XEloTH2vh?=
 =?iso-8859-1?Q?fEtVLaZpltFHjU+LIK4IjkIk6Xkw4dzO9b0/j7by/43GMZyr//cob9mZ/w?=
 =?iso-8859-1?Q?vI/cR8y7RjU4gQVCcgIGrKz7K4zxan0BVbyUU2wmg8y+Go8YC3bJsXaYOh?=
 =?iso-8859-1?Q?IO+g8vKX/vvr+vhiAVKDrOl/JMuZteAr3/hQ8/dmwaj1dxDT51lF9o2ZFz?=
 =?iso-8859-1?Q?2pmB4VG64Ftbl0DEU9aiz29b295It9qWezSDAaFRg87ecZ4KE0Cr6ugkAR?=
 =?iso-8859-1?Q?tKs3WslFr1d8q+HpdOdJIg3AeNWkE+XYVaV86mQlUMusEVC4b8p1HLs5FQ?=
 =?iso-8859-1?Q?+8TGO+0p820ekQlHp21szQ89RAO6V0Syit1eqduoT4KtG4KIM4UixHnS1x?=
 =?iso-8859-1?Q?CMRIwqz48qAB00Gy1xdA4K1kg9NLX06ba2TvJ9X63abpRqVr03gzJCKvFG?=
 =?iso-8859-1?Q?sAujfNj0SZygf7FJmyw2QGfdFNmLK7PAAdW83WhaMpzmWtozu3miSycg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 166eb803-d21a-4b08-1e5c-08ddcebc7f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:25:14.2830 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9fawuWQDuRYloNIkVBZqg3Da6Xm4Y4DFrLlTbY1R1su7cszirwK07151nW6VpDhRqSao10d8DIRZ2iDaJxxjZNg3eKfaCWbjnMyHnhStLMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8338
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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
