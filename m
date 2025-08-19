Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6BECA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 12:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368F68317B;
	Tue, 19 Aug 2025 14:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="cqav9sP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAB3681FEE; Tue, 19 Aug 2025 12:33:49 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF33802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAwvkf4aKJeRR5qhDVn866nB5Tccm/Ffx5BBn9615OnDRSgY6EfqJLGQhWVsaMspgQg/n2tCIF9/H7mad1WZRxf5P4lf4K+m36AzNxLuXdnBBUF/VlAWVAmyvLTPvjrJvGMI2NalEMoIOVT7B9eohEuuJ/BPE4CwWafkNBlnn4N8xBGNUTEW9znDNhr6dEUZQRQ1bSbcvHdKvZ5Ac+Ceixr5YGIsYKNcwnrgY1unD7+gfQSlzhB1+08W33+Kh/ruXlFAZqIJ32ZQniGQm/6iPOfpserYdbwGaob/ETTAKehpiDOBu7UGZHivIVZ+oAB/RiTYRUWy7M8vqtWJB5kzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y+rlnpX1cJaLCyJanrGPza/zdhfOEZksZHvrTifEtU=;
 b=U0kRZsL+aViNSS526cftNmBPM3ZZ0kU7dpyu8ZK68lNRnOtclep4MU6sT66C8gqVC7ImvdXzqvpwqDe8aFKSaliI7OufuPl/3Yichd3LicvBZDNF3uu95qDtN+YRXirpCmQbJFdgdaXK5Ca2uL1MJWUIvcTNqY4t7La7fXS13Pwaw5BcITqCuj2xurIMw8KbjdpitRYkg1UsyOo+5kxKPfKVkJV9rm5lBs0/nbZd7o1YXNJvCf4mIzbDgw2/I3KmsScUpxnplbdyv7bPQyIwZbE1xFlnN0FeMk9jTVqWMZ+QNgPwUIfo9XlOfWOHmIg7Zg1/ZrYrBExRSyc6JzSUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y+rlnpX1cJaLCyJanrGPza/zdhfOEZksZHvrTifEtU=;
 b=cqav9sP+2O6AGJyCAUTmaboNdWZiWKx7A4KCDJgII0yA+bdXUAxEE46hpeXrKG3Ml4Ji2+SEaHrlb7lTH40WYNCVG6raIqQQcao+DnufbsPpvQdY33QplSqFpybpnITyhW4TpXF9Wrlp/hjkRtRilKAVbggT00ffcVlOoiOf+lMxe6Rtohu3+H+nXd8OF5Je5Q0MzelLGqiCOW42kP0UDl25Kti16TuYoOQzsjDdoO3XsGWsP5shMOnbNbuapnFy2ukxKim049R1sFKQSRP8Zo2S//ZAmSE9vclDgzeiKPYBN+8IIKxo2XpoLvNcU2AUNdvEAOFUWIWE+fh+ZOQATw==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM0PR09MB4321.eurprd09.prod.outlook.com (2603:10a6:20b:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:33:46 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:33:46 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 08/10] riscv: p8700: Add Coherence Manager (CM) and IOCU
 support
Thread-Topic: [PATCH v4 08/10] riscv: p8700: Add Coherence Manager (CM) and
 IOCU support
Thread-Index: AQHcEPS+qgvn7rjgHESe1Rr+ZtJm6Q==
Date: Tue, 19 Aug 2025 10:33:46 +0000
Message-ID: <20250819103021.1518687-9-uros.stajic@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM0PR09MB4321:EE_
x-ms-office365-filtering-correlation-id: 0b59d34c-a4d3-4e82-aea6-08dddf0be0a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GFQGj7SGuGB0sahDSrd7WsMh0aGhKgToLHHnxXEbQxBIKB1cxbXQaobcev?=
 =?iso-8859-1?Q?oswy1AYuN5q0GwmECi3OOIWA4sJ5ooLmNoaUr789CexGpiW3jvxSMT1CFg?=
 =?iso-8859-1?Q?8xygU0uyRtKygLr7Iupb9imTKv0503vo5L1tNQFfTUdEjJKc+3vGzZYeye?=
 =?iso-8859-1?Q?7zzxIAY62TeWkUteg56jImOPL8ktjHoJR/hE9wf6vhSt4h6RP3t3LXQORq?=
 =?iso-8859-1?Q?U5EwRbJB3fULgksVlvbzanx8/SCMdw6G2tH3Zl7TSskhRhOGx18UzCVTqb?=
 =?iso-8859-1?Q?RQU0JQdxrMVVEY7qESNGkoo7Wn5gozUezFDtML2WxTsDaO+6yDayQUko4H?=
 =?iso-8859-1?Q?c0l2bLyL0uN7GQWbV3eFW27HVU92ankXkWmbvJqRXe+zCTbTJktbJTIjCf?=
 =?iso-8859-1?Q?wFOov0TXFfOIMC3LzA2W4w4vm7aBUR0Hh7zEs9vuwpA8mdglEca+16TvxT?=
 =?iso-8859-1?Q?ihFIMmLbc4bwKYTvefGiIIwxXE53s5aLqne6sr0e9kUFjUUPpVzaW/ziv9?=
 =?iso-8859-1?Q?6uc6qeokAUZ6PYfSmkqZgfE7iisUlihcMjlH6tCL9wYMLURQr/iyMUCvYy?=
 =?iso-8859-1?Q?H2z2V0V8x86IaHdxg2hlso/5vl1D0kjbRV1PCa3ddUVcrdyRl61HSUeMB0?=
 =?iso-8859-1?Q?WmrXX8VoBdcVOPgi9jqE4+D5a8Q1UdHqw9joUc0dC6BETdMm7TCVA6lIN5?=
 =?iso-8859-1?Q?HTCeGiBVYdfn0vWZDIY9InWmYn46IeBmulyAKrefPwLyImssC2Cik2IvQv?=
 =?iso-8859-1?Q?KnUzYblE8KWwSjqnClV+lQ7TQdom7qEGTWZS+6sTrC4UmCjrJayYu1yTeu?=
 =?iso-8859-1?Q?WtewYudoqwuD4HZrR9Y+Ax+S0xjVr/8TeZLJiM58zP4UzrQoFw/pigvizO?=
 =?iso-8859-1?Q?SkIS0fmS0I76nrP/IEpHWSY0m2ji7m7+fEiDfhc6ImZpX7SgbGb6Y5XmT8?=
 =?iso-8859-1?Q?Yyifh13NE1U42BskikJOVpDCjLyiZTAYoC+tlVQDFfeSQKVpT0En1HCRD1?=
 =?iso-8859-1?Q?a9tG98mxxp9noZJ5RjqP5KAFD+SUxyLNyvaSR+b9HqO8ErvLNx9ytMKskz?=
 =?iso-8859-1?Q?aDv49JrQrNLfKpP4vH9RAZP5GjLqf6Ghyn7J73UmFHZqvOWjtRWHbgIpQ7?=
 =?iso-8859-1?Q?hIP7Ccb7OddFtna5ovbOrH6qSgAHJdlXXho3zSQIQ7Ab2eWpbq4GlkJur6?=
 =?iso-8859-1?Q?enJ/pDNGItotGWy/Rr2eKUy2jZLd7s154fAXMHhfF1siBKz+q4mpzpHvqc?=
 =?iso-8859-1?Q?+MzvOOXPq+Zv5hc826HHq0fDdhyye4fb/DJRNg3NWus8UaZeKHQUMPM5C0?=
 =?iso-8859-1?Q?p623lu+QrTqyrpDPfW5NQQs7zb9lClu75rSP70oT3IIXCbIKmHeApB1Bow?=
 =?iso-8859-1?Q?xBXsGkiKEJ9baFTMNgwKWXkMGvr5qsYk8cvF/pkQQL++9pLSFMld54nDgB?=
 =?iso-8859-1?Q?BHRShqAR3z/31XNd0PYnJOZL9Ytna6g3gXdi60MBokHzhIWMLK931iEKkB?=
 =?iso-8859-1?Q?QU7e2/faU8lYRko+Nw84twEXry6S7O2YhYEhcGtgrLrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bEP0ZJ7ViDMrIwf7P8P6Ng0gBLhASQkTwykE86lgCNvBCb/rJ8ePS6zojE?=
 =?iso-8859-1?Q?hTHieR/ngdtb25LfwBTKlgeTJ5G8S97683IOTlNCsQnvH0qJS6gDVjo0ax?=
 =?iso-8859-1?Q?4T9FInYB0Ng0f8QTekgrLy8/Z6gP/2x+Lk3glFQHb4L1LE03LLcNtndSV2?=
 =?iso-8859-1?Q?5mxUJDW/Pjdn537We4rP56NxmPmt+wvWlMPIIQ71LUT+HSKPbs9gu/S7o6?=
 =?iso-8859-1?Q?EjwCY35crINo84PF6OwOFHxxuDxKzMaj/NM2dIWpBIzA2y0r34g+y6bHBC?=
 =?iso-8859-1?Q?/olmT0KfCTkz3GIUhKWy5OkUiA+zxpt3isQzJwkKx5ozTJxALtQI4ZaEl3?=
 =?iso-8859-1?Q?eMF6AJIXzjnadcM5g48t9GXAaVXYzITZmDcZzwGkEZsR9P0IS/fFiWzy1P?=
 =?iso-8859-1?Q?p63DZ3ReOZWsJQ1WtFmjjz0XsYOAjmCx+90+/meMirWYUvp0tUPmGRHcne?=
 =?iso-8859-1?Q?b7wNdrgj1r7QJVs9mL9+dcGWPk2t2Co+9z2wBm1UgiE2CeZcB6RuQSTkot?=
 =?iso-8859-1?Q?oSXFqgvsvcawYbk0Ee5FiG93UoQnSQow6DaGSBrtyaCqsZ8C4qsJR94mZ8?=
 =?iso-8859-1?Q?zaZYiHXpFaunWA2HYpxUX5jIaneBISWg8bFab0fiHZUreFGFcpuNzhJ2NZ?=
 =?iso-8859-1?Q?d4XkjvmgTXU1iY0ubADS/sQQlYqgLGN6zDQBunKVyHK9GdAZe/glhlIUGv?=
 =?iso-8859-1?Q?PHHPicpl5wnrq6mCD2PCJII3LLpNfQPmcxtgnLstTcDKr72dFD6q9Rn3cO?=
 =?iso-8859-1?Q?K+VGDELahKal/54pluxBDBFmRexWbrzGCTVJXw3dXT3WpG214lUBYplGQd?=
 =?iso-8859-1?Q?4+BAmiJX7ae1coGDy9dNLoyLP2EUM4NjeaKot7cMqbBuCMYPZrUhTk6rQY?=
 =?iso-8859-1?Q?2osfcO2aTGCx0B2IYiQRjRvLt5YXzCSzxtM4teF60MW6BPYbptPsUGKJum?=
 =?iso-8859-1?Q?aUqR1qgN0pm/i8cadXumMAhZ39hDrMRgUPsY98Y/FjYfnvFvY4eNThGE5w?=
 =?iso-8859-1?Q?Xyfxr3hiMUpAYVcHTAyk2k59IX2qYDpqkZvIGbl06f7cxkKDPYvPGCJ95D?=
 =?iso-8859-1?Q?//loHVvG2yt4xsh++KAz7YOXaMRMyFqHn+92sVU8vwnPCz91y1MB11sz9j?=
 =?iso-8859-1?Q?dWRzsqsZIJhV5NR8/RbnyMUN1QOiVR3xWj/UT9+4gzIVX6XodGydQSRbkO?=
 =?iso-8859-1?Q?1OLU3SWjMc21YTRJpSfF4mD4Eg6gnBNMNjAeOp+bWEA1/9tj46IZOgVe3K?=
 =?iso-8859-1?Q?hIMIKzHQmT+MlBI5+CtpcFoljYalDKWk6e6fZePfobPUByJp0GTGtUuT7n?=
 =?iso-8859-1?Q?QrjJCCfeEa5AkCrEUzce4NtOTJrDZYHoSMqE1+psTpZ+it5Fcj8XUxPUiU?=
 =?iso-8859-1?Q?h60GIc7Az0oRnjbtYNvNRRlYejNr1MYJHDVIgqNHZEQnOdeQqwiFMoa1NM?=
 =?iso-8859-1?Q?rgiUMe+dSkfixmXSSTWyheIAXKqaWQocWiMHZje7wXbJIO7Ki5AAujainK?=
 =?iso-8859-1?Q?qG7tfLoGhsVALRVSmYUoki6M3zgQWzMsZndue8FudUSfsxrB+Sn05btD5s?=
 =?iso-8859-1?Q?FQVOEVeyhnK+8eXgdi6ElXtuTd72C2/xMLonxQCEnsOABqT+qHjZuB1Di4?=
 =?iso-8859-1?Q?BD7GoVtZaVHuJeFu5SG9EBfy4/w1pEpTBRA/l+9vcIbo2mOy/nO921Jw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b59d34c-a4d3-4e82-aea6-08dddf0be0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:33:46.2163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xSGoLGMSJ0wpP4pPgYxTSegrmDPvql6ucCJ6MKJFocIJvibr128tq5SwZFij2hLZzASn1mGnJJq6j+Kuyj6iyHtrEYuta2C1cUCAtJ9hNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4321
X-Mailman-Approved-At: Tue, 19 Aug 2025 14:58:37 +0200
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

Add support for Coherence Manager (CM) and IOCU discovery and
configuration on the P8700 platform.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 arch/riscv/cpu/p8700/Makefile             |   2 +
 arch/riscv/cpu/p8700/cache.c              |  10 +++
 arch/riscv/cpu/p8700/cm-iocu.c            |  75 ++++++++++++++++
 arch/riscv/cpu/p8700/cm.c                 |  92 +++++++++++++++++++
 arch/riscv/include/asm/arch-p8700/cm.h    |  61 +++++++++++++
 arch/riscv/include/asm/arch-p8700/p8700.h |  31 +++++++
 arch/riscv/include/asm/global_data.h      |   2 +
 board/mips/boston-riscv/Makefile          |   1 +
 board/mips/boston-riscv/iocu.c            | 104 ++++++++++++++++++++++
 9 files changed, 378 insertions(+)
 create mode 100644 arch/riscv/cpu/p8700/cm-iocu.c
 create mode 100644 arch/riscv/cpu/p8700/cm.c
 create mode 100644 arch/riscv/include/asm/arch-p8700/cm.h
 create mode 100644 board/mips/boston-riscv/iocu.c

diff --git a/arch/riscv/cpu/p8700/Makefile b/arch/riscv/cpu/p8700/Makefile
index 4dfbddc5cba..7494254dbf0 100644
--- a/arch/riscv/cpu/p8700/Makefile
+++ b/arch/riscv/cpu/p8700/Makefile
@@ -3,6 +3,8 @@
 # Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
=20
 obj-y +=3D cache.o
+obj-y +=3D cm.o
+obj-y +=3D cm-iocu.o
 obj-y +=3D cpu.o
 obj-y +=3D dram.o
=20
diff --git a/arch/riscv/cpu/p8700/cache.c b/arch/riscv/cpu/p8700/cache.c
index 7559c688321..b465b4090bb 100644
--- a/arch/riscv/cpu/p8700/cache.c
+++ b/arch/riscv/cpu/p8700/cache.c
@@ -48,6 +48,11 @@ static void probe_cache_config(void)
=20
 void flush_dcache_range(unsigned long start, unsigned long end)
 {
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (gd->flags & GD_FLG_COHERENT_DMA)
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
@@ -71,6 +76,11 @@ void flush_dcache_range(unsigned long start, unsigned lo=
ng end)
=20
 void invalidate_dcache_range(unsigned long start, unsigned long end)
 {
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (gd->flags & GD_FLG_COHERENT_DMA)
+		return;
+
 	if (lsize =3D=3D 0)
 		probe_cache_config();
=20
diff --git a/arch/riscv/cpu/p8700/cm-iocu.c b/arch/riscv/cpu/p8700/cm-iocu.=
c
new file mode 100644
index 00000000000..5850647d20f
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm-iocu.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+#include <asm/io.h>
+#include <asm/global_data.h>
+#include <asm/arch-p8700/cm.h>
+
+__weak bool plat_iocu_usable(unsigned int cluster, unsigned int iocu)
+{
+	return true;
+}
+
+static int init_cluster_iocus(unsigned int cluster)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	void __iomem *global_gcrs;
+	u32 cfg, num_iocus, num_iocus_usable, local_cluster;
+	int i;
+
+	local_cluster =3D mips_cluster_id();
+
+	global_gcrs =3D mips_cm_base();
+	if (cluster !=3D local_cluster) {
+		// FIXME
+		return 1;
+	}
+
+	cfg =3D __raw_readl(global_gcrs + GCR_CONFIG);
+	num_iocus =3D cfg >> GCR_CONFIG_NUMIOCU_SHIFT;
+	num_iocus &=3D GCR_CONFIG_NUMIOCU_MASK;
+	gd->arch.num_iocus +=3D num_iocus;
+
+	/* Discover how many IOCUs are usable */
+	num_iocus_usable =3D num_iocus;
+	for (i =3D num_iocus - 1; i >=3D 0; i--) {
+		if (!plat_iocu_usable(cluster, i))
+			num_iocus_usable--;
+	}
+	gd->arch.num_iocus_usable +=3D num_iocus_usable;
+
+	/* If the cluster has no usable IOCUs there's nothing to do */
+	if (num_iocus_usable =3D=3D 0) {
+		if (cluster !=3D local_cluster)
+			power_down_cluster(cluster);
+
+		return 0;
+	}
+
+	/* If the IOCUs are in the local cluster we're good to go already */
+	if (cluster =3D=3D local_cluster)
+		return 0;
+
+	/* Ensure that the cluster's L2 cache is initialised */
+	return init_cluster_l2(cluster);
+}
+
+int mips_cm_init_iocus(void)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+	unsigned int cluster;
+	int err;
+
+	for (cluster =3D 0; cluster < mips_cm_num_clusters(); cluster++) {
+		err =3D init_cluster_iocus(cluster);
+		if (err) {
+			gd->arch.num_iocus_usable =3D err;
+			return 0;
+		}
+	}
+
+	return 0;
+}
diff --git a/arch/riscv/cpu/p8700/cm.c b/arch/riscv/cpu/p8700/cm.c
new file mode 100644
index 00000000000..ce7485c564d
--- /dev/null
+++ b/arch/riscv/cpu/p8700/cm.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MIPS Coherence Manager (CM) Support
+ *
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+#include <asm/arch-p8700/p8700.h>
+
+static void mips_cpc_init(void)
+{
+}
+
+__weak const struct mmio_region *get_mmio_regions(void)
+{
+	return NULL;
+}
+
+static void p8700_setup_mmio_limits(void)
+{
+	void __iomem *gcrs =3D mips_cm_base();
+	const struct mmio_region *rgn =3D get_mmio_regions();
+	unsigned int num_clusters =3D mips_cm_num_clusters();
+	unsigned int limit =3D MIPS_CM_MMIO_LIMIT / num_clusters;
+	unsigned int i, reg_off;
+
+	if (!rgn)
+		return;
+
+	if (num_clusters !=3D 1) {
+		// FIXME! Need to support multiple clusters.
+		return;
+	}
+
+	reg_off =3D GCR_MMIO0_BOTTOM;
+
+	for (i =3D 0; rgn[i].addr_high; i++) {
+		__raw_writeq(rgn[i].addr_high & GCR_MMIO0_TOP_ADDR,
+			     gcrs + reg_off + (GCR_MMIO0_TOP - GCR_MMIO0_BOTTOM));
+
+		__raw_writeq((rgn[i].addr_low & GCR_MMIO0_BOTTOM_ADDR) |
+			     (rgn[i].port << GCR_MMIO0_BOTTOM_PORT_SHIFT) |
+			     (rgn[i].enable ? GCR_MMIO0_BOTTOM_ENABLE : 0),
+			     gcrs + reg_off);
+		reg_off +=3D GCR_MMIO1_BOTTOM - GCR_MMIO0_BOTTOM;
+	}
+
+	__raw_writel(limit, gcrs + GCR_MMIO_REQ_LIMIT);
+}
+
+int power_up_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int power_down_cluster(unsigned int cluster)
+{
+	return 0;
+}
+
+int init_cluster_l2(unsigned int cluster)
+{
+	return 0;
+}
+
+int mips_cm_init(void)
+{
+	int err;
+
+	mips_cpc_init();
+
+	err =3D mips_cm_init_iocus();
+	if (err)
+		return err;
+
+	p8700_setup_mmio_limits();
+
+	return 0;
+}
+
+int arch_cpu_init(void)
+{
+	int err;
+
+	err =3D mips_cm_init();
+	if (err)
+		return err;
+
+	return 0;
+}
diff --git a/arch/riscv/include/asm/arch-p8700/cm.h b/arch/riscv/include/as=
m/arch-p8700/cm.h
new file mode 100644
index 00000000000..ab5ea7385b2
--- /dev/null
+++ b/arch/riscv/include/asm/arch-p8700/cm.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2021, Chao-ying Fu <cfu@mips.com>
+ */
+
+#ifndef __P8700_CM_H__
+#define __P8700_CM_H__
+
+#include <asm/arch-p8700/p8700.h>
+
+struct mmio_region {
+	phys_addr_t addr_low;
+	phys_addr_t addr_high;
+	unsigned int port : 4;
+	unsigned int enable : 1;
+};
+
+const struct mmio_region *get_mmio_regions(void);
+
+void setup_redirect(unsigned int cluster, unsigned int core,
+		    unsigned int vp, unsigned int block);
+
+int mips_cm_init_iocus(void);
+
+int power_up_cluster(unsigned int cluster);
+int power_down_cluster(unsigned int cluster);
+int init_cluster_l2(unsigned int cluster);
+
+static inline void *mips_cm_base(void)
+{
+	return (void *)CM_BASE;
+}
+
+static inline void *mips_cpc_base(void)
+{
+	return (void *)CPC_BASE;
+}
+
+static inline unsigned int mips_cm_num_clusters(void)
+{
+	u32 cfg;
+
+	cfg =3D __raw_readl(mips_cm_base() + GCR_CONFIG);
+	cfg >>=3D GCR_CONFIG_NUMCLUSTERS_SHIFT;
+	cfg &=3D GCR_CONFIG_NUMCLUSTERS_MASK;
+
+	return cfg;
+}
+
+static inline unsigned int mips_cluster_id(void)
+{
+	u32 temp;
+
+	asm volatile("csrr %0, mhartid" : "=3Dr"(temp));
+	temp >>=3D MHARTID_CLUSTER_SHIFT;
+	temp &=3D MHARTID_CLUSTER_MASK;
+
+	return temp;
+}
+
+#endif /* __P8700_CM_H__ */
diff --git a/arch/riscv/include/asm/arch-p8700/p8700.h b/arch/riscv/include=
/asm/arch-p8700/p8700.h
index 5ca9b4b9497..6c47de9a633 100644
--- a/arch/riscv/include/asm/arch-p8700/p8700.h
+++ b/arch/riscv/include/asm/arch-p8700/p8700.h
@@ -65,6 +65,10 @@
 #define CM_BASE			0x16100000
 #define CPC_BASE		(CM_BASE + 0x8000)
=20
+/* Block offsets */
+#define GCR_OFF_GLOBAL		0x0000
+#define GCR_OFF_LOCAL		0x2000
+
 /* CPC Block offsets */
 #define CPC_OFF_LOCAL		0x2000
=20
@@ -75,6 +79,33 @@
 #define CPC_Cx_CMD		0x0000
 #define CPC_Cx_CMD_RESET	0x4
=20
+/* GCR_CONFIG */
+#define GCR_CONFIG						0x0000
+#define GCR_REV							0x0030
+#define GCR_CONFIG_NUMCLUSTERS_SHIFT	23
+#define GCR_CONFIG_NUMCLUSTERS_MASK	    0x7f
+#define GCR_CONFIG_NUMIOCU_SHIFT	    8
+#define GCR_CONFIG_NUMIOCU_MASK		    0xf
+#define GCR_CONFIG_NUMCORES_SHIFT	    0
+#define GCR_CONFIG_NUMCORES_MASK	    0xff
+
+/* GCR_REV CM versions */
+#define GCR_REV_CM3			0x0800
+#define GCR_REV_CM3_5		0x0900
+
+#define GCR_MMIO_REQ_LIMIT				0x06f8
+#define GCR_MMIO0_BOTTOM				0x0700
+#define GCR_MMIO0_BOTTOM_ADDR			(0xffffffffull << 16)
+#define GCR_MMIO0_BOTTOM_PORT_SHIFT		2
+#define GCR_MMIO0_BOTTOM_PORT			(0xf << 2)
+#define GCR_MMIO0_BOTTOM_DISABLE_LIMIT	(0x1 << 1)
+#define GCR_MMIO0_BOTTOM_ENABLE			(0x1 << 0)
+#define GCR_MMIO0_TOP					0x0708
+#define GCR_MMIO0_TOP_ADDR				(0xffffffffull << 16)
+#define GCR_MMIO1_BOTTOM				0x0710
+
+#define MIPS_CM_MMIO_LIMIT	4
+
 #define P8700_GCR_C0_COH_EN	0x20f8
 #define P8700_GCR_C1_COH_EN	0x21f8
 #define P8700_GCR_C2_COH_EN	0x22f8
diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/=
global_data.h
index 33f2b5ec5c8..fce2f2bb77d 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -44,6 +44,8 @@ struct arch_global_data {
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
 	struct resume_data *resume;
+	int num_iocus;
+	int num_iocus_usable;
 };
=20
 #include <asm-generic/global_data.h>
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index 0615c677d23..c67c001d4e6 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -4,5 +4,6 @@
=20
 obj-y +=3D boston-riscv.o
 obj-y +=3D checkboard.o
+obj-y +=3D iocu.o
 obj-y +=3D lowlevel_init.o
 obj-y +=3D reset.o
diff --git a/board/mips/boston-riscv/iocu.c b/board/mips/boston-riscv/iocu.=
c
new file mode 100644
index 00000000000..8478670f350
--- /dev/null
+++ b/board/mips/boston-riscv/iocu.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2016 Imagination Technologies Ltd.
+ */
+
+#include <dm.h>
+#include <env_callback.h>
+#include <asm/io.h>
+#include <asm/arch-p8700/cm.h>
+#include "boston-regs.h"
+
+static const struct mmio_region mmio_regions[] =3D {
+	{ 0x10000000, 0x160f0000, .enable =3D 1 },
+	{ 0x17ff0000, 0x17ff0000, .enable =3D 1 },
+	{ 0 },
+};
+
+const struct mmio_region *get_mmio_regions(void)
+{
+	return mmio_regions;
+}
+
+static int set_io_coherent(bool coherent)
+{
+	DECLARE_GLOBAL_DATA_PTR;
+
+	if (!coherent) {
+		printf("I/O:   Non-Coherent (Forced by environment)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable < 0) {
+		printf("I/O:   Non-Coherent (IOCU init error %d)\n",
+		       gd->arch.num_iocus_usable);
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus =3D=3D 0) {
+		printf("I/O:   Non-Coherent (No IOCU)\n");
+		goto noncoherent;
+	}
+
+	if (gd->arch.num_iocus_usable =3D=3D 0) {
+		printf("I/O:   Non-Coherent (IOCU not connected)\n");
+		goto noncoherent;
+	}
+
+	/*
+	 * We have some number of connected IOCUs. Map all PCIe DMA access to
+	 * hit the IOCU by offsetting the addresses as they pass from the PCIe
+	 * controller to the NoC.
+	 */
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x10, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	/* Record that I/O is coherent */
+	gd->flags |=3D GD_FLG_COHERENT_DMA;
+
+	printf("I/O:   Coherent\n");
+	return 0;
+
+noncoherent:
+	/* Map all PCIe DMA access to its default, non-IOCU, target */
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE0ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE1ADDR);
+	writel(0x00, (u32 *)BOSTON_PLAT_NOCPCIE2ADDR);
+
+	/* Record that I/O is not coherent */
+	gd->flags &=3D ~GD_FLG_COHERENT_DMA;
+	return 0;
+}
+
+static int on_io_coherent(const char *name, const char *value,
+			  enum env_op op, int flags)
+{
+	switch (op) {
+	case env_op_create:
+	case env_op_overwrite:
+		if (!strcmp(value, "0")) {
+			set_io_coherent(false);
+		} else if (!strcmp(value, "1")) {
+			set_io_coherent(true);
+		} else {
+			printf("### io.coherent must equal 0 or 1\n");
+			return -EINVAL;
+		}
+		return 0;
+
+	case env_op_delete:
+		set_io_coherent(true);
+		return 0;
+
+	default:
+		return 0;
+	}
+}
+
+U_BOOT_ENV_CALLBACK(io_coherent, on_io_coherent);
+
+int misc_init_f(void)
+{
+	return set_io_coherent(env_get_yesno("io.coherent") !=3D 0);
+}
--=20
2.34.1
