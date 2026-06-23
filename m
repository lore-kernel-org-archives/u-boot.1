Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390D7CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:02:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B593F84A20;
	Tue, 23 Jun 2026 08:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Ah/AIkwM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0646E849BB; Tue, 23 Jun 2026 03:01:17 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3884801A9
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 03:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1fuMLzuJpAFp3PsAjmkyhx+2PWuiPOt9OlDK0h12LrIqkxZH6tnO+puulqoDNqTGd5OnaQsvS0G2XlYq3AFwe3EmxLH1m6LzBslNWwLjOn0eG/UHMzPhcwiuIuAZ/JgZVK6vK6dWVItn2SsHZw+Mf6Jgw2Grx5vtiAqTomNiuWQ6ijpG0rhUA7R+BPv5chPFq6ONulRJx14IZ5SG+FkwI988sk59em5XYMCyKpvQtSPs3e5rVyYsG8z6uMo+naICjk3e7sGpvyjFrMlK7McJGvqRnVSNxfuyGtrUtq3kINbgvz0FzqsHp5nWNgvkXQAvtOtsMLFlaeq0a0qhyY3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMUsUhaE46Rr1JvrU3eJKZ3eOf+9x225MW6MbLq5wcc=;
 b=Vym7tkYi5U+YHXeCsbOLxkG3Zx1QRMHm3+x9uptvJfoTUit2GpWmdYa8+Lcy577WysA/RXk8JcSImDYDOVQ1zkS0IxwXGIJQmFIrXoLbri71wBOKVE2NyDsjoRJ1Vlb3WTDGvyEkk0744VmAlDTs+aIjqUB4JcNHkoAB82zi97d9UNeTSSfR5gRC3HRGzaP1ZPb5gCf7lTOVVLJuO+Q1sv0xq2+YMQXg/Iqe6mfbVa/DDA31YRHxZxvrJLnuHkXY6ujeo9Bl5t6z/jYo+E68Mqd+ge6zIa/YAkkRXNd5riAt1wVEQgNM206NMMEqVeIuflIBZdZsJQQ5yyxsm0LXvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMUsUhaE46Rr1JvrU3eJKZ3eOf+9x225MW6MbLq5wcc=;
 b=Ah/AIkwMPsIyj4OaYr2omXYh0atEbKJNa2+XJ/nMbWUl6i0D2PRz6whxW1V4upO2DiBfqTY07bOaydgxgE1tZkJiO1h7cjDkafU+pBYQpsfR4xgQGxdk0fID2stezbftkQonBHf6WPtXT35MzmVoyf+IMfE0+vP6Y5jJN+ECf3WKAJwPkbX6S78xDdNzax1sns7/rVTSc26qnjwfXjFFmY5acSwNRsPr/l5c+bl2+vrN3DgnYMJBdaTfcM3ZKyKLPBN1g1JDYJYdzQGLhc+rS2vJz84fYPX9l76AvlTgK4EAdd5dmbZlXJY5iyFEYTZOsF/C9utaDOfh6fipgVIxog==
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by BY5PR03MB5156.namprd03.prod.outlook.com (2603:10b6:a03:224::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 01:01:10 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 01:01:10 +0000
From: "LOK, CHEN HUEI" <chen.huei.lok@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Simon
 Goldschmidt <simon.k.r.goldschmidt@gmail.com>, "YUSLAIMI, ALIF ZAKUAN"
 <alif.zakuan.yuslaimi@altera.com>, "MANIYAM, DINESH"
 <dinesh.maniyam@altera.com>, "NG, BOON KHAI" <boon.khai.ng@altera.com>, "Hea, 
 Kok Kiang" <kok.kiang.hea@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>
Subject: Re: [PATCH v3 6/7] arch: arm: dts: n5x: switch to using upstream
 Linux DT config
Thread-Topic: [PATCH v3 6/7] arch: arm: dts: n5x: switch to using upstream
 Linux DT config
Thread-Index: AQHc9uYf01TGGiBGSUW5pmvDVchfxrZKdu6AgADwYak=
Date: Tue, 23 Jun 2026 01:01:10 +0000
Message-ID: <IA3PR03MB80213159CC721E36E3A40C5DC3EE2@IA3PR03MB8021.namprd03.prod.outlook.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
 <20260608012741.23760-7-chen.huei.lok@altera.com>
 <7a41a912-1fe5-461a-9b20-60c38a92040a@altera.com>
In-Reply-To: <7a41a912-1fe5-461a-9b20-60c38a92040a@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-06-23T01:01:09.552Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=1;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR03MB8021:EE_|BY5PR03MB5156:EE_
x-ms-office365-filtering-correlation-id: 8285bd22-0a32-4511-5ec6-08ded0c2ea02
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|38070700021|22082099003|18002099003|55112099003|6133799003|11063799006|56012099006|4143699003;
x-microsoft-antispam-message-info: jEA4OzA8odqptMExrlVwHlU/A+rNvWrjEMSIdghEmbIL3D2gm4rhV2ZXdj34/vLOZVbbBxrTuUs5O3pzS4S9BlbJEiYYVWDvbkHyu3YN1ZKpmuBLdrCJy0jywKzos/rWjkXxKSIv3KoSvYJb84ynHBa7ClGMomKSP9qsUxSqwxXtrslxYoA857o+KGpoEVM0E+jSkrLUqnECJaKbRbDw/UAakdviCApu7IDMEMLElaZfptWi9zOlMNFlfFn1wFl6/tZ96qtaQc9Gddy4RLcE9cI1KP+8AHATd9COVgvHY9qN+8UQYO/lc6FnLD59+uQE82HHN0pPw6SajzPKtVwGkAlC7YDx8B6z64Pc6C6LfLLNqBM7Iv/8czQmkCDCk5f9LaNYqYKvZQim8EUL9kDXf/vYxCaPVQ1L8BP1eTHWO4lqEt+VJbGoi273d+tUcM+LOQalyQRIaZxy+rGV6+u08FqASdV0+jpeKee8gpwWPACW6oBbX+T0XH/176OAvt8iatGXeqcadNOd6N1A3mhRN0qubuL29bN+SRubXjtaWBX5K0BNjO5O9zo1Lmtx4mT0NiH3CWGUfy9GNAywfzXJHg4PQGz9ZPXdE5jmV39xwvfh5Rhgg09j03AGE/nrvk5N67MyaxqxBUtPIascP0a7dF3l6C4tKi+6sZIFJgcvUHO9EzQnql6894Uodj2p5lwWV5t1YPzv78Ksuz9sIYRecPe6K3OZzeSU3owod3rarcA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(55112099003)(6133799003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iu2yszb3DoUjI8YgtjJ2w6b8azjGluLMhjP0XyxUcuF1QV/7++Kx3ZzkFo?=
 =?iso-8859-1?Q?63v2NiY/L//WXDNN4CoTCyipqcw7J93sbI5Pr2AWFPwor5+QnC6HT0BWex?=
 =?iso-8859-1?Q?lg/2ktzNTfMjpuG6uzJFfwObX3+C8ZH2Gqy69+fYODIY1N6nQ1qv60KHO8?=
 =?iso-8859-1?Q?B4kizNNjALlB0S2ot5PYsViOUdm7Vk1Pi/1vprV1mSILV4+SgfUzrX0ZMl?=
 =?iso-8859-1?Q?bkriyH0func9PHIkKilbpB7hwecsDmiUURbqY7QWXoloIw0quf8+ERugWN?=
 =?iso-8859-1?Q?eqoNmPEtZpGsyfHIbHMfai3Et+TVpbU24nzY3Coe21vtcDqyWU5qKhBePj?=
 =?iso-8859-1?Q?NnmIv8Zax8QKz52NIp8jkWmW46VyJ0ZyyTdyACdbiEodXqv9rSHbqVBFp8?=
 =?iso-8859-1?Q?+JQ+k0HzT3ajA/8/gdzyzT3/zo0RS99SIAr9B7paPBdN/taQ4Wwwpa5GGC?=
 =?iso-8859-1?Q?ooZF4RP6L82SvY8PB9bJ+qj8tzrsjcbDbisk6xhg3ExTCfscAjr7pPstfZ?=
 =?iso-8859-1?Q?suOI+kSsPAvCDjRNKHKmp78SQTKf3ekFIuUQdAF1EqDlJv8xfz3vtWcG22?=
 =?iso-8859-1?Q?OXim6tXeHxZHUUikODvu5GsYpv8sb49PmRtsDZgqeIRzHyXIMtJd8P+3qu?=
 =?iso-8859-1?Q?cjixDCcV7OsXzsUr7Qk8W4/MtADCAjtKa14LV/+4flGiCIpHSSRkQc1E6n?=
 =?iso-8859-1?Q?YHtrKYYFIW6k3DbQaWqOeGKxX/BhymkpZ1cnou4K9t/yAlfAZ55LTWjy8U?=
 =?iso-8859-1?Q?1XhD/afe2YhHrtDjyJD8USjEbbI2hNkBWC0gTnUR44CAUZvsRxCHa2ZMeV?=
 =?iso-8859-1?Q?f9em8TtKvfI1mwwysefcgZ93vq+9iXpmgmsUOyk/er9rhdSTgCbgd29W0/?=
 =?iso-8859-1?Q?EilHgNVbALzvD7FvzJxz3mlUGw7sejRrUtIMaZIIS5IRhgwZHmGoEDH7cV?=
 =?iso-8859-1?Q?rmHX8PpIli6J4ZZ4tVV2XAndJjEzXRL6TpOggLdDlvlPcvySRzFiEiTTM4?=
 =?iso-8859-1?Q?aSYeDzHiX3xvR7mG618BxA6Q3hjFsSDQGbKwRA6MxyIW/oHXUwMC51Y5QT?=
 =?iso-8859-1?Q?H0tvMI6tEVtYKtOzPQvTYgryJjfoFWKYQYeVOfN5yFrbDO+GS3VZgku/VX?=
 =?iso-8859-1?Q?xpM4knLo0EscmNjItVqmKRms9TrFeqcizXLGvGJMr9Xth7fzoDjrIwSirW?=
 =?iso-8859-1?Q?luzZ9/sTbEI2FF7gszz0qGXUMxiUi7r4O2JwLHcGM79SS/BqRhXTSJpvyC?=
 =?iso-8859-1?Q?S8JptEc6XHV4zHemM2K9Q20Sze3X2WjrgjeIDTdBtvkUgbXq1c8Br43zfR?=
 =?iso-8859-1?Q?WzbKAAEha8P/MaijXjyFP9wxhnTJg1ffInLj2lfsqeLcgujCR9WD0liyjQ?=
 =?iso-8859-1?Q?N3SWCDwdCK0kZlJ4ZNRxZzMSi8mNUqGCsvjYOpRejtcA0+OBm862HPUay/?=
 =?iso-8859-1?Q?F7TJzF3BIgTYTILz/uuTba+GTjNGrBC/zCRK25l0AZkUpi6HqdOVAkXfrX?=
 =?iso-8859-1?Q?K2YNyCI9fOySpTwpuQWt99ZdkCAXvsZiJcsQYYjIty2Wfzib8j0ZDJ5yjH?=
 =?iso-8859-1?Q?W3C814AuPUDDVDVfaH4JPaEEG7C1rSdnsqWZCXq5K3S4L2E2N+3jTSrgEm?=
 =?iso-8859-1?Q?FuEiePtOloHH85MyWfsxqww9EXaXip4sXMZ97H4aKpTOziI+aLFQ06sTik?=
 =?iso-8859-1?Q?D/aDezAltUg3MH6xScvCWuCpKw6EUU44eA4MUm7puFGABXhljgExypOfmL?=
 =?iso-8859-1?Q?Q5BSMlQZzYto7xm/Tesw0o1gToMxLKx2VSTrPY2KeCzS4zbnFrJNJG7hAV?=
 =?iso-8859-1?Q?XORdyTIU2A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8285bd22-0a32-4511-5ec6-08ded0c2ea02
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2026 01:01:10.1085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BkOP18vmY90n7SfxQrr3EA458c0rbXDcQ56JdPaB48+4ebE4E0RRaOIWUSMLfF02obvZnxDABif/kTvyVxAgKYDquUyUbh/KCFoMt4/usk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5156
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

Hi Tien Fong,=0A=
=0A=
On 22/6/2026 6:32 pm, Tien Fong Chee wrote:=0A=
>> Migrate the legacy n5x platform to use the upstream Linux device tree=0A=
>> configuration. This helps reduce maintenance overhead and aligns U-Boot=
=0A=
>> with the Linux kernel's DTS hierarchy and naming conventions.=0A=
[...]=0A=
> Runtime build no longer uses the in-tree vendor socfpga_n5x_socdk.dts=0A=
> once OF_UPSTREAM is enabled. Leaving it creates a stale duplicate that=0A=
> may confuse reviewers.=0A=
=0A=
Agreed. The in-tree vendor arch/arm/dts/socfpga_n5x_socdk.dts is no longer=
=0A=
used once OF_UPSTREAM is enabled.=0A=
=0A=
I'll remove it in v4 and fold the deletion into this same patch.=0A=
=0A=
Best regards,=0A=
Lok=0A=
