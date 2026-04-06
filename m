Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF99EF4ED4
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 12:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CF0A83936;
	Mon,  6 Apr 2026 14:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="C8eN2udk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE7383C2B; Mon,  6 Apr 2026 14:07:02 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035548341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 14:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQP8Sp8ms0H+35P/ozkRuWVLE2ynVls4TVr9Q//d/utjNxVL13hL9oahk3cWH3nr22jKe73zgdb+OJwR5+Ohmy8AeM/TMuXPz8oHFTbZumCnSNXuoPeTPn1JYCKWfcPDvJWw/87YY1Pzpa/+is+l7nae3iLel/KJI7M3nInij9Bfe8gVbCBbl05csIM1DwDYTmhUEJJTuaSdPsr1iAqCuVMqYLnc+9M7bBICAOwH8JkToRPeNweASfeC0Ti5uEhoFVs7Q2r7r9BqllOu2+pwBY/g4NlIp5kjFCtmlKo1uL9Q0gdC1CApYsZr3dXjoLRG3PTRlbF4KqPwe6WNHlek7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AaO7ZdgMfS4R5ISGh9WftHbKydzIGwoGFakEv4LWZQ=;
 b=n/SgOn88bI7XagwzbcmGhAmw7uE+QYCFRufA5o0Oq49dfmAbFSHPn5AVRWQzeBe7Iuz9oCFjzbPi3se9AZsAUFA0IjRxroifwZmiGulwR6SerMI3dbOd5riuRSYWFwMwbC0bZCYQ0e7fdsbuSSKUyGYvkzMVrgHmU6Dqth2DSTowQ/YDilPRabEnsa9TASfV2lt5S9Qwon9sP/+XZezIyC9xxQ6gsGy9sFn7rTXM07t3FiS+1fsUeFi/72BGiplUxnVZX9Ha/LPcIrcDYiRenfYq4JtLXXyWaUZND+h25HynEVjlw2XUDE9hIDjHv8J4lygyU4MvD+IbEKG20tC2vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AaO7ZdgMfS4R5ISGh9WftHbKydzIGwoGFakEv4LWZQ=;
 b=C8eN2udkBnxHVf025uB3/TCqR18Rv5ndbgoyc/VyXDC4dTW8eJtxjynOiv/iYjqyoAQd0saS+KLSqC7JQEQ4A1koH7BJ80aI0huFWcIqRnERjQRS0FIrp3qTVUa+bfvpncr8ZuTfPHzoxspqBiQU+iECPAiZ3vbSizyvhoXtVXiVgLuMDHNrmt/WSbsRj6UnwL+2ygfrs3etfoJKv3jCdIEZD2ocVGScfVLU1P+xZJ4+T6wW3yvlRLOFBPoZK7OoZ1C/GQpF0NTPU8nAOV4b/kAB7SLrooHFWcLRPhZAQH6sq10BU6klkZU1qUvzUBiGney6DbjHlAxaXixeVPzylQ==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by PH7PR03MB7390.namprd03.prod.outlook.com (2603:10b6:510:2ed::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 6 Apr
 2026 12:06:54 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 12:06:54 +0000
From: "NG, BOON KHAI" <boon.khai.ng@altera.com>
To: Tom Rini <trini@konsulko.com>
CC: U-boot Openlist <u-boot@lists.denx.de>, "Lucien . Jheng"
 <lucienzx159@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng
 Fan <peng.fan@nxp.com>, Sky Huang <SkyLake.Huang@mediatek.com>, "Chee, Tien
 Fong" <tien.fong.chee@altera.com>, Weijie Gao <weijie.gao@mediatek.com>, Yao
 Zi <me@ziyao.cc>, "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, "YUSLAIMI,
 ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>, "LOK, CHEN HUEI"
 <chen.huei.lok@altera.com>, "Hea, Kok Kiang" <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] misc: fs_loader: Add QSPI RAW partition loading support
Thread-Topic: [PATCH v1] misc: fs_loader: Add QSPI RAW partition loading
 support
Thread-Index: AQHct4eYuATwuc2Sm0eoMka8P+WHArXMGNYAgAXzINo=
Date: Mon, 6 Apr 2026 12:06:54 +0000
Message-ID: <SA3PR03MB71873A9D91CD137CBB85216CB45DA@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20260319100256.965-1-boon.khai.ng@altera.com>
 <20260402171256.GA1914552@bill-the-cat>
In-Reply-To: <20260402171256.GA1914552@bill-the-cat>
Accept-Language: en-MY, en-US
Content-Language: en-MY
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|PH7PR03MB7390:EE_
x-ms-office365-filtering-correlation-id: 6e3056af-c346-449c-d4e5-08de93d4fe81
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003|55112099003;
x-microsoft-antispam-message-info: tUQrbwjRgyLvcUMR+O6QJr6jhNHc6hVBF0Vxr4wwKobaDSImowSxRed9A0DrB4O7rxdIsaFeGvFgslQz7t0GZuarnKr18YOYrg2dI/NOrz+KGm8poQJmmy0XUTCV0TVMbLE+QdDIesnvveVX8gSs4mlKAkzMWcVgmw003v+LANYAwtF7wOVMSS5UR6DfTL7B6fxmomqayprL6RJVYOemhfbbp4CTpIs+doTUyNLlYxOryke3QO/O7ovXDBlzGpPpOocP3JQOowh/DgJGPvEqFa2DiV24+t/mQprbufSiPmJ+hqgLnTlXsp7830AmgJJhRrJPD1M0NVA/nrH+cOOCdsZZ1gEYWJCRCNUfmzbZBKJ1ZIBebn9EdWBbQ6O+2H31o6/E1Sf4hTBum9jdKjv2b3SVhrD6Bb6qnHbDjDBdwyZybRCO8+TbZ61w4Lk5hrleWftxekxp6bh3TT5V1EHzTca2bmAks7brRIc0QlYhxQEzZGuRhZTTpSRzjDhtqqCxXf6ZfpVbPHYN8DjFe2SylZYShsYAnLx1ojPLlgMuN6wirhlnCX1FYS8URiOye7Am1XoWj5k5B3EBxMvyyw+aQNClj5jYxBmZ1xcsKWz4OaMVSefIeRXGyR28gKhq3pBYqSEjG+Wbb/DoPCA2ZD13LZMteUgasXI5k//t79GMoGPmv8H7eDbF9TrgK3WoeSogYeUI+9eatqebyM1YVoFwU4XBe2Rz6lmoW2mp5e3toCjG6awaPIaDO7lY8vZe+bVVo9PUOZa6elhOA+9iQ20jfTcd0W5VajQ830bZbINQyzo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MZsLpHzOg6jwRdfq4BbjhS7F/pcPp6kfOFJi/Luo0IMb/mqhasUFdvOCec?=
 =?iso-8859-1?Q?vB56B2GPIXS2E98g1V300BX4wLrwUYlU//fWeQ8F7h/87m1rw8M9UkwRjO?=
 =?iso-8859-1?Q?yYFczopJXCaxZ3wMYJzgF3SP+yqWvB2FwoGitGDGOoeqG7uqGy386qB35D?=
 =?iso-8859-1?Q?r10ylnV44eSsWJ6/Flw7f/exWzTTamNFik3y3sv43qHHrjnhf9/dLFLHvw?=
 =?iso-8859-1?Q?l0vu8yDSerHozlEC7hNWB/h+PvNu6XmlDZgum34PoDsglwmX1b73EYIcbD?=
 =?iso-8859-1?Q?SOs9PEYx9KggXTLLuYCjfZVwwCkvEoEiNc66feSVHmKNFwErGY0TgGWq/I?=
 =?iso-8859-1?Q?UuCYEbcZu9G7cSJAkKpYPYdKqomIwXJ77LkMeROdzsuZzNJvMjVTIV/a9K?=
 =?iso-8859-1?Q?krIxVL4JYNz+qYWSBAUivFx72sBZpV7g753wUeu0SSYBQKTIjes/PnpOtt?=
 =?iso-8859-1?Q?0NHHZyzrJ5oov5q1lvkK5uZJqlRXzPJ0ZLDdGMAnAf0IyPvDw2LwB5Rkwk?=
 =?iso-8859-1?Q?Gvmw6FeVQ57cY4liXj7sYB8/rsTpJppoPIfk8eD0C3Hu2hQEBg/lXVnwo9?=
 =?iso-8859-1?Q?RSUvvEE87hCo3GXbUoYcGmq/R0f42GylUhJfLzrwIDgAofTqxRK0omoj4S?=
 =?iso-8859-1?Q?fRlmoNgu7uAa3uLH0KwuUXBGbAQApZAXwaUvY0bLOcvd6b+WqBolIeXkiy?=
 =?iso-8859-1?Q?DjFSbokyuzHUnSxuMH/Y9cbr7sUB2x1Jg1Fu3TwGP9iA5qYKgrfr0IafOM?=
 =?iso-8859-1?Q?71Apn6JFfZL5C+kQ5hJgD9LjHqS50fipMfWE9Xy/1TBSmUUnxyw11q9WkS?=
 =?iso-8859-1?Q?jmPhWyqN+RzURHi7oTnFsX94yBluas/R4ZVXDQJYtDm6pXd5PRfvVNSgNI?=
 =?iso-8859-1?Q?7WJITz+Kd6jWMGGrIvN1+nZDCwY/iCBxFBBo64HS27sD6nVGzXzztjjAXc?=
 =?iso-8859-1?Q?wBAe4Q/QMrO+DZrNnI1n9oAuNlx/TlDJuOSb2PqHlx33S/yLjOCaFrImtV?=
 =?iso-8859-1?Q?AWFpyzI2degrCeUUXrFZ2z9z5orDDkAhLqK2qy/eAy4ZZcQBQ+mK+utvjq?=
 =?iso-8859-1?Q?DfhIFCnd4a0penc9azFPKgDe0RpYH/lW7jw/NyY3tRFy+l5yMKPEzJYU4M?=
 =?iso-8859-1?Q?nnVrH+bDzT4i/qYqTLybLAlhqNe1T+08ehvIIzL2EMYi4yI9m7n7Oqw6fU?=
 =?iso-8859-1?Q?r5xBwwL0dItHo5tSNkV3F9WGOqQ2CSPgz+TbwrL2y7iXKh6DaCasMo+NuD?=
 =?iso-8859-1?Q?bXbOhGdTWlfrIvHLCrnS8qUG7O2IygP+6iaogts+sFcnJU79axq0g4p04G?=
 =?iso-8859-1?Q?WspCbAD7i5CY2tBSkDcFGC46koXE40GHtge4hKXT2xIGbZai9euJ+a6mFi?=
 =?iso-8859-1?Q?6UyisJ7xgXS1puWGgQsuumlNRbXrnxTBNhXWiGlmY1hdib6KRNTSCSZJIX?=
 =?iso-8859-1?Q?dEfbTav1CXoKMMAhjpObpLgCEA6FXh7pnMfdLxW2q8lJfUubmDdez65/Ag?=
 =?iso-8859-1?Q?kfzoQeKt+s/seg9KloVnUi2cIeKcClORsWUV+qtFwOeTUKH62lKGnVnm6o?=
 =?iso-8859-1?Q?eYDVzXr0dDCWrpljxigSFm4htzTssXVsACs9usNWF/mFUVqY1jBQdhzqF0?=
 =?iso-8859-1?Q?gXBhwdQ6kBhZs9Lyc19iNVYH6UYJBxiPGwfD/fQnYZmnhNV1WumgwUMj5v?=
 =?iso-8859-1?Q?E4jLIXmRLQXsE99RXPWu9FUvkxMY4zrpvzSnByEkRhezWqheXOGjE7UeAL?=
 =?iso-8859-1?Q?ZXEmclg7Zk3MYevupoH6seLmGCRG5CyDuzzjq8MmkgO8COsllL2qPRE0Hh?=
 =?iso-8859-1?Q?NvZ824GWoA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3056af-c346-449c-d4e5-08de93d4fe81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 12:06:54.5252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MdzBc4cmvL7bYVpwRlOYmcAwgH3bOg/IGPffIcDOz0iJf7AUYr6dowV8+uLU0E17PEzfFXcTUYqAW2zV5tu/XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7390
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

=0A=
> Please fix, thanks.=0A=
> =0A=
=0A=
My bad, I think the Pipeline test caught the same error too,=0A=
https://github.com/u-boot/u-boot/pull/913  =0A=
=0A=
let me fix this and summit another patch.=0A=
=0A=
Regards,=0A=
Boon Khai=0A=
