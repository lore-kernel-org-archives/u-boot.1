Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29402CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 13:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C0EC831B4;
	Tue, 19 Aug 2025 14:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="Llz5aFCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABD881FEE; Tue, 19 Aug 2025 12:34:05 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62995802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgzWOwgWK4UrB6BzfDFtsrQKO7e6bWjqmjhxm8WT/NJJuxnck8EcECsJ5bpKf5VDdDEoin8ZtWW9r1cWpUixSxomogLeMfCZxd0YuXbJgtDcB66gGZIz4Kh32KGiA2N+s7oX0Fg0TNAGFs4PDp2Hiu8HNR6F8LaL/OvIEvGg6vYCxbqkMNd2DB46M9xJlL9Y6dHPTUDNucfwLKN1K5RWOPivuUvwMT493AcLUlQIBsj/avS4AM1PZZfGh5gkFGxd/QxqNJsUjOtC9qq4Z7NlEsWbzsqu1M1cThouRg0szw0jjsgWRIsIBVPpXuylAra/1h0r8Xp/3nLNDYOAi3oqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s37VPEYrNVDqdr5z6esfgFvvl4L2YRqs8TGmZmx1TLA=;
 b=Ncxo2EUyZfIurGq/DeN3jecJ/8pwK/zeM1i0XTclT5DtIEiO3fE3gn+Vp7c0j+eboF8WOXRESsGDtBEhjBQKA+G4N7H75S+s1gZBYxuUIUc84FYCsbZ5CRu8q7+/RWrDIUKzo+AQuAeduBp7u+ZEsyY+dXuRzUogIbn91v+GH4WXjkXah5CyzxGzNSxfCkRJxu8YZXGgKy6rZgN7VgI8DP+bGcSkCbuMFeJsBHMLPhAXg+OdWD7RiCpE25foDpPGnF1T+IaJ+gfjZf1b7kp3D8qP0gU4o5KTwIxaAiIlzKhlh7S4rCky2Bq7rC60xzVj/qWPiPBNpSsw4w8h5qUVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s37VPEYrNVDqdr5z6esfgFvvl4L2YRqs8TGmZmx1TLA=;
 b=Llz5aFCcV2qxZiuEw0vm6OAxtO6tNR/ZpZTAcCuWUYjNQflf/zvPmN9BVCPK3B7k6NDN9jxekHAY4J0vKj0mXVEksRt+ZSgceITR69pI33UKx59Qeq7eh237robtmVE/YhrL6SZXM8q9ar1CXL/hEnsV0NGqAeFmfGxw8o5bBcNKgG8+HRNWesHhrvHkRxUPF9LpjwC6h7azdsCAvyB6sIkJ4cPrMhj04Rzus41l6OGmI/k66S4A+1rAYregK5CPnBBuXr6qk9BaEk6G+aJpANogRBcdJXerD1T9euEv76eYxMzSckjnDC5vq3Hg78XR4+iaQAb65tJOgCVAfDbGow==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM0PR09MB4321.eurprd09.prod.outlook.com (2603:10a6:20b:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 10:34:01 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%6]) with mapi id 15.20.9031.019; Tue, 19 Aug 2025
 10:34:01 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v4 09/10] riscv: boston: Add support for LED character display
 command
Thread-Topic: [PATCH v4 09/10] riscv: boston: Add support for LED character
 display command
Thread-Index: AQHcEPTHlbhKd/LjnEqPAfjGwK+3Lg==
Date: Tue, 19 Aug 2025 10:34:01 +0000
Message-ID: <20250819103021.1518687-10-uros.stajic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 83cfd3f8-2ce7-4e53-7b0b-08dddf0be9ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?WsBkioyOcbgZVCG1zccZRHOgt3/r6m/86GJonaO1v6WmoONY5ieQOq+UWv?=
 =?iso-8859-1?Q?MzncNOwzdDGTTWawRRdwlnKj6v4KbBRsxfZF4QKQlT9Og32pnsoHFgbkqR?=
 =?iso-8859-1?Q?AmaEo+5Ebh35sOyjhqmh9P9IcLlmqPXxosL5gaQwylCdy8wmBVidx6rbwO?=
 =?iso-8859-1?Q?F0zH8bmJpfphMopVVUfm7vbGtvWbG2PoCnvYwURrKh4tMbwC3e4Zt5jhbi?=
 =?iso-8859-1?Q?3dU7cHAFxF66pPqC3/DZy+9sK7LbfYnobIBWC0avUAMcnYuIjPO/Bw5LSC?=
 =?iso-8859-1?Q?EIZQxMPlxKDAZrwuyblBCjYn1sTrHmnZyDP0xe6b522mzOpF/NmNRT0Rrz?=
 =?iso-8859-1?Q?EqcwkWBP8JaCkzLPXdqdzEL8wanJSzqGAI8HzeYIyDxFYCAnZjLQkOJYwg?=
 =?iso-8859-1?Q?1qgrozVWVE8aJF8SR+W1Iy3GG/g5N6z6Qx8Jp5WzFlQLiuUvQtNilkY0as?=
 =?iso-8859-1?Q?wvynp+NlKLC/REuwTStH0ERGH3O+jqMvl0XAOfOT7Qm0c71RB77bsGgIGT?=
 =?iso-8859-1?Q?1+9hcVfxvBh5HY0WtXJEtLdAIGA6tHiPN3y/iflDlKlKcgSM12G5dcyJ9M?=
 =?iso-8859-1?Q?5hilwLD+1Kwni6BY4K1Hy5JQh/uiK4BntZeVSfigqD0KZOURnJWsb2/7+A?=
 =?iso-8859-1?Q?nTOdBJztmFFU+RhITl2PgAZOThJPuRYasvOlZ9FW4pIxz3nFlSdRmIteoi?=
 =?iso-8859-1?Q?0PfKJ9L+B/c1dhgO8mXqeBCEPdRCH/2XEzjCIRR/JAHhcrmvqy5/uf1v4Q?=
 =?iso-8859-1?Q?gPAdUkQw6op6rgaclsIwZFioShXgZL+ABlByGY/Wk5y7i1qjnjiFlP8kxz?=
 =?iso-8859-1?Q?w9p1shVE8kOHrav/YSwrtMKBJQgeEy4AQZzT6lONwL6ZxxOyQ2D/Y4tS7T?=
 =?iso-8859-1?Q?n/eDty9qQMMwiNlDWxm9n+HYIUiZZyFq4E9wCc9KQOewnFuTVP4VUz6sRB?=
 =?iso-8859-1?Q?j7ibA7fxG/XEioI5tH/CbTNkXpIM9Xv+4vqwzjK6EeUB8DhWvAYBh3qQlA?=
 =?iso-8859-1?Q?LULVFPPAkYhOwdCHfLaWdB/49+0iB/kfb9uEx2sLLA5h8M8sT6zG7UoJdy?=
 =?iso-8859-1?Q?0kjBA8j/RIEEzRBx5mKooLdQONHD9E0O6pSvcPev3jJV3J1jGZxiPR81Ye?=
 =?iso-8859-1?Q?A3VX20h0l8ShAi16bd0WH2dSA+ZllYFTKVeLcS8s3rZ8b6huA1T8OcO7qJ?=
 =?iso-8859-1?Q?PQuTRvOvwm5SVFmhp5rHfOyPxrjFJ7y2UbJgUYVbojZCuveG7BE4cQv5Ch?=
 =?iso-8859-1?Q?peZCzdO+0FSA7ZLF11nR48rGK2eTIjDu2S8w4wZKPNs+w0imvMYQivigas?=
 =?iso-8859-1?Q?eNxw2thNDjyKjUHYeeGr+QcYVt1iOTggEMI22G1+tDP148JtvtS5nZuFoQ?=
 =?iso-8859-1?Q?7j8YjzGsxyOdexSNLSMey+S3I9KJ1jQAuTIVUTgf6ejzHQTa2AfSpG3s3Z?=
 =?iso-8859-1?Q?Kp+GxF9yVJpVjthDBsEx+EjYLTfkSdgi0ogqpZXkrrhXY/8myYhg+QF6DO?=
 =?iso-8859-1?Q?QsOuCeOHjx0apdNdwjVMGpocT6FhTco9IjYqm5j02XF1AvDIEuMrwvHOw/?=
 =?iso-8859-1?Q?Jfw9fg4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SUiW05Sg8e/MTAeALEH1fl0R3xyfAfpMHXT1jk1NkwK/oT8o9gfr7PnAEA?=
 =?iso-8859-1?Q?Xvvg7urfEPL8/bCT0JaWKw8rdnmprqfVUdYFvkGzcUSO3uRYc9OkkyE6UE?=
 =?iso-8859-1?Q?O30PpdY/8t0FNWBjWX125GVl1cLGXHuiJp2Z+7+EIdsvldrgXZ//67Ovuz?=
 =?iso-8859-1?Q?d6FjpEZ/au4XkY8Ql9I07MDPU7ceBeqiDqHGggtMsVRxIW2yUBrq3oE+Mn?=
 =?iso-8859-1?Q?XbR5gB0beaobGYo7/HS45Wa7TnlDOkJOSokC9yz7aNLhU6MUkZvyQlXiA5?=
 =?iso-8859-1?Q?84qs0Z339mV37hs5R93H2ZkDdJpyH8jzdGIa/2kzikGtgS80dbfFr42HNZ?=
 =?iso-8859-1?Q?b1jVy078Rx7su2R/hId4yMCsSJCOkjrFBb9EcQIOw/U6GcrpHmaXagXHp/?=
 =?iso-8859-1?Q?NlqylBiSJ2CZl2hJa64paZTrcnqQzCCuS38nyf+U1U2daQT1aQk+UBrMw7?=
 =?iso-8859-1?Q?8KNPLLp1GnrXYpK+NSwDvz9K7dt3YJTWvAZCNeRmQoeHLsd4NsrUIX4rUe?=
 =?iso-8859-1?Q?jhj8RfS4fJdjqm5jK4XXJz4crj2KCLBvxmrqw0EYmzZbeHhgDgdtyr92PG?=
 =?iso-8859-1?Q?m5x6UintZfv57HxMqQjeMJEwcpocbmhmgmlrW5egrApO6nMw02UiJYob07?=
 =?iso-8859-1?Q?MOGmqUq/ntrImZUOFFfpsoL6AtW/WdgHKgrlT/pB8UJt/MVbJxDReF2EHS?=
 =?iso-8859-1?Q?AWViiR7RFKmUsqMN/9jZVa+tb98VZ16CfbfneXQyzJAww0BGyzXWODZ/wb?=
 =?iso-8859-1?Q?iqLR7lvaeGdLrRRLGe3+Tb2HcvYORF5XVZszrqvwNforGAMoTHaq+OqvoR?=
 =?iso-8859-1?Q?uSQPq1PQ3E6/2XH6BkCuqgs6E8pqewMAQgSSln6knFAXmTDLOGZE/Ej2qG?=
 =?iso-8859-1?Q?YV1MQ365UZDDUKOodDmgY0sLWewIL8mQfhTrpLO4pv1PRm/o4R7vjrMhoN?=
 =?iso-8859-1?Q?0n7Gfswt4iJkNYbTOgf3L97OAgbXpKlesZTanQCWav/nu8H9vlmHFGzovj?=
 =?iso-8859-1?Q?wz4U1CJvjE6I1H/Qp353Z1182NkKpwgmhptjyGFMZ7zeTtSKcsS+5SQUdu?=
 =?iso-8859-1?Q?rUZmVnUKMCr1lCd1j5UI53MRr/GWtbPrCJffXFe4RMV47nmfG/d/63Pg/9?=
 =?iso-8859-1?Q?4dp6RMJ9c7ndMQmsszzgLvH3wsMmQCSyx+l3JhWvMTh+ugFkTpatqBxKoW?=
 =?iso-8859-1?Q?J49piTYqUnxE4T0f2ECu6zhI6xNNkRhjQIZ3rDbUnjN61sF9WpyUO9R2n7?=
 =?iso-8859-1?Q?7fKYptaH3Vfg9PIN+gI73G4eHM4W3kQUWrZXX+tT1gZbW+xmsnfsefIPW1?=
 =?iso-8859-1?Q?z3mLk6obf4x+HgXiLqJHtMTA6prY+r08vO0MpM6VAhtcb7MNMZCol24PDi?=
 =?iso-8859-1?Q?vD5B+vImpibwwr6gYdJaWskg8Hp0/Qz2beW+HHEFaqWAPGUEn+e3AKKYh6?=
 =?iso-8859-1?Q?m4LcazXwWr+aabjJQWVf/IJR75s32B/oVBSX/6ZIICXqJ4eyaBubzz0ylf?=
 =?iso-8859-1?Q?ErXg7fmZz5MqlcRSi5dwSCvrAIyZ0CzP+v/rQHVE6OzuYhLgDUwLfVb84e?=
 =?iso-8859-1?Q?Lqe4m+X7MMWCXhPtVqLGZjLu4DFP5HZNl0NPf26mOExcX5q2ftSZmQymeD?=
 =?iso-8859-1?Q?nxOJHFPFZc/or8JubICIOX3aOwRzUHgRb49g90ZeBoN39Oodj/21cofw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cfd3f8-2ce7-4e53-7b0b-08dddf0be9ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 10:34:01.8322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKh83uamfh6iJZBXqBeB2G34tn0cWcXr8u/FJJUwRRUZJnxGYptiEFz5tO7OvPXAt1We+u9oG1rOjnqpJbbGQ0M5zYocpwnOJ3lHLKabc28=
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

Add basic support for the 8-char LED display on P8700-based Boston
Board using display_set() and display_putc(), enabling the generic
'display' command with clear and home support.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 board/mips/boston-riscv/Kconfig         |  4 ++
 board/mips/boston-riscv/MAINTAINERS     |  3 ++
 board/mips/boston-riscv/Makefile        |  1 +
 board/mips/boston-riscv/display.c       | 33 ++++++++++++++++
 board/mips/boston-riscv/lowlevel_init.S |  2 +
 cmd/Kconfig                             |  8 ++++
 cmd/Makefile                            |  1 +
 cmd/display.c                           | 51 +++++++++++++++++++++++++
 doc/README.LED_display                  | 26 +++++++++++++
 include/led-display.h                   | 33 ++++++++++++++++
 10 files changed, 162 insertions(+)
 create mode 100644 board/mips/boston-riscv/display.c
 create mode 100644 cmd/display.c
 create mode 100644 doc/README.LED_display
 create mode 100644 include/led-display.h

diff --git a/board/mips/boston-riscv/Kconfig b/board/mips/boston-riscv/Kcon=
fig
index 4d55d96603e..5ab89cb5a69 100644
--- a/board/mips/boston-riscv/Kconfig
+++ b/board/mips/boston-riscv/Kconfig
@@ -44,4 +44,8 @@ config TFTP_FILE_NAME_MAX_LEN
     int "Maximum length of TFTP file name"
     default 256
=20
+config CMD_DISPLAY
+	bool "Enable display command"
+	default y
+
 endif
diff --git a/board/mips/boston-riscv/MAINTAINERS b/board/mips/boston-riscv/=
MAINTAINERS
index 0d9a951441f..b04dcde943a 100644
--- a/board/mips/boston-riscv/MAINTAINERS
+++ b/board/mips/boston-riscv/MAINTAINERS
@@ -9,3 +9,6 @@ F:  configs/boston-p8700_defconfig
 F:  arch/riscv/dts/boston-p8700.dts
 F:  drivers/gpio/eg20t-gpio.c
 F:  arch/riscv/lib/mips_gic.c
+F:  cmd/display.c
+F:  include/led-display.h
+F:  doc/README.LED_display
diff --git a/board/mips/boston-riscv/Makefile b/board/mips/boston-riscv/Mak=
efile
index c67c001d4e6..2a180820a74 100644
--- a/board/mips/boston-riscv/Makefile
+++ b/board/mips/boston-riscv/Makefile
@@ -7,3 +7,4 @@ obj-y +=3D checkboard.o
 obj-y +=3D iocu.o
 obj-y +=3D lowlevel_init.o
 obj-y +=3D reset.o
+obj-y +=3D display.o
diff --git a/board/mips/boston-riscv/display.c b/board/mips/boston-riscv/di=
splay.c
new file mode 100644
index 00000000000..cd222cb6648
--- /dev/null
+++ b/board/mips/boston-riscv/display.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2017 Imagination Technologies
+ *
+ */
+#include <led-display.h>
+#include <asm/io.h>
+#include "boston-lcd.h"
+#include <string.h>
+
+static char buf[8];
+static int pos;
+
+void display_set(int cmd)
+{
+	if (cmd & DISPLAY_CLEAR)
+		memset(buf, ' ', sizeof(buf));
+
+	if (cmd & DISPLAY_HOME)
+		pos =3D 0;
+
+	lowlevel_display(buf);
+}
+
+int display_putc(char c)
+{
+	if (pos >=3D 8)
+		return -1;
+
+	buf[pos++] =3D c;
+	lowlevel_display(buf);
+	return c;
+}
diff --git a/board/mips/boston-riscv/lowlevel_init.S b/board/mips/boston-ri=
scv/lowlevel_init.S
index 8fa85749e40..f65021a0974 100644
--- a/board/mips/boston-riscv/lowlevel_init.S
+++ b/board/mips/boston-riscv/lowlevel_init.S
@@ -15,4 +15,6 @@ msg_ddr_ok:	.ascii "DDR OK  "
 	.globl lowlevel_display
 lowlevel_display:
 	li	t0, BOSTON_LCD_BASE
+	ld	t1, 0(a0)
+	sd	t1, 0(t0)
 	jr	ra
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29de857ba7c..3be6459acf6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2326,6 +2326,14 @@ config CMD_CLS
 	  Enable the 'cls' command which clears the screen contents
 	  on video frame buffer.
=20
+config CMD_DISPLAY
+	bool "Enable the 'display' command, for character displays"
+	help
+	  (this needs porting to driver model)
+	  This enables the 'display' command which allows a string to be
+	  displayed on a simple board-specific display. Implement
+	  display_putc() to use it.
+
 config CMD_EFIDEBUG
 	bool "efidebug - display/configure UEFI environment"
 	depends on EFI_LOADER
diff --git a/cmd/Makefile b/cmd/Makefile
index 36e79cc3c28..e1bdb7f05e8 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_CMD_SOUND) +=3D sound.o
 ifdef CONFIG_POST
 obj-$(CONFIG_CMD_DIAG) +=3D diag.o
 endif
+obj-$(CONFIG_CMD_DISPLAY) +=3D display.o
 obj-$(CONFIG_CMD_ADTIMG) +=3D adtimg.o
 obj-$(CONFIG_CMD_ABOOTIMG) +=3D abootimg.o
 obj-$(CONFIG_CMD_CYCLIC) +=3D cyclic.o
diff --git a/cmd/display.c b/cmd/display.c
new file mode 100644
index 00000000000..0602345e6c9
--- /dev/null
+++ b/cmd/display.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2005
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <led-display.h>
+
+#undef DEBUG_DISP
+
+int do_display(struct cmd_tbl *cmdtp, int flag, int argc, char * const arg=
v[])
+{
+	int i;
+
+	/* Clear display */
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+
+	if (argc < 2)
+		return (0);
+
+	for (i =3D 1; i < argc; i++) {
+		char *p =3D argv[i];
+
+		if (i > 1) { /* Insert a space between strings */
+			display_putc(' ');
+		}
+
+		while ((*p)) {
+#ifdef DEBUG_DISP
+			putc(*p);
+#endif
+			display_putc(*p++);
+		}
+	}
+
+#ifdef DEBUG_DISP
+	putc('\n');
+#endif
+
+	return (0);
+}
+
+/***************************************************/
+
+U_BOOT_CMD(display,	CONFIG_SYS_MAXARGS,	1,	do_display,
+	   "display string on dot matrix display",
+	   "[<string>]\n"
+	   "    - with <string> argument: display <string> on dot matrix display\=
n"
+	   "    - without arguments: clear dot matrix display"
+);
diff --git a/doc/README.LED_display b/doc/README.LED_display
new file mode 100644
index 00000000000..19977ea7e0d
--- /dev/null
+++ b/doc/README.LED_display
@@ -0,0 +1,26 @@
+LED display internal API
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This README describes the LED display API.
+
+The API is defined by the include file include/led-display.h
+
+The first step in to define CONFIG_CMD_DISPLAY in the board config file.
+Then you need to provide the following functions to access LED display:
+
+void display_set(int cmd);
+
+This function should control the state of the LED display. Argument is
+an ORed combination of the following values:
+ DISPLAY_CLEAR	-- clear the display
+ DISPLAY_HOME	-- set the position to the beginning of display
+
+int display_putc(char c);
+
+This function should display it's parameter on the LED display in the
+current position. Returns the displayed character on success or -1 in
+case of failure.
+
+With this functions defined 'display' command will display it's
+arguments on the LED display (or clear the display if called without
+arguments).
diff --git a/include/led-display.h b/include/led-display.h
new file mode 100644
index 00000000000..50830903b0d
--- /dev/null
+++ b/include/led-display.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2005-2010
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ *
+ * (C) Copyright 2010
+ * Sergei Poselenov, Emcraft Systems, sposelenov@emcraft.com.
+ */
+
+#ifndef _led_display_h_
+#define _led_display_h_
+
+/* Display Commands */
+#define DISPLAY_CLEAR	0x1 /* Clear the display */
+#define DISPLAY_HOME	0x2 /* Set cursor at home position */
+#define DISPLAY_LINE2	0x4 /* Move to line 2 */
+
+void display_set(int cmd);
+int display_putc(char c);
+
+static inline void display_puts(const char *str)
+{
+	while (str[0])
+		display_putc(*str++);
+}
+
+static inline void display_sets(const char *str)
+{
+	display_set(DISPLAY_CLEAR | DISPLAY_HOME);
+	display_puts(str);
+}
+
+#endif
--=20
2.34.1
