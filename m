Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A2DF3029C
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 03:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3748063E;
	Mon, 16 Mar 2026 04:21:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bc+3Pfyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B36D807C0; Mon, 16 Mar 2026 04:21:44 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A73280212
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 04:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCTgeYY9Mx6lywmVrj/sd4J1ENet+vkeYLg01E0HbVjtAbjB6HYRhWl3OdxWipucQJ4dH1KstDUsXmk/c3qHTOBJxYtUFynXgf/ZhgasSmBdbMFUjHKhTzxEWSAnxNVNnd/Oj9UK2KnBfKvsAj3JVtQtIRyuYFbUHtYpDYeH8ndOpEy9V5LqypNTLxOtv5/8hrC+al58X4fgAugYNNRsw/bTF8ZQsCYtmfB/f0hGoNOnF1SzwqyBbax6Dp7ioijfFlUd++cDTM9LXvfAOky/Ch82h8KXr2xFXDiBxXzrl77BOv5LG3GR27hskL73u+z4bE3RoKCb9zwoB2DLaFwMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lobxIKSh5N0u+woJybsdvbzBBzs5tPpw9P4PxceIrCE=;
 b=sV5A/LFsB4zSCgqtsKbX+9JMYyGIzqdRxFGw1xUNtXcCPZLvq9jf9XLnEDB5yr3fI8xwaa8ZZ6lABP7sb90L1iN5CQPK8DXhfLFJXiKlEKuH+uVvDiVHPqRmvYfxU9qO72EM77BNwqI9s2/Zf5eHAW82NX4BK6T9dzUKMhVC1Mk+KMfiJBzvF4meJotXW28YIxjOMpjoGBVnh7YD6LGjvzAbzBvpcgp9PM5PyMNquTgZZrUEfVHUlQuQiXDoo8ppZStX9lkIky7Ov4nhN3sYWdYJ+0F0HsE7g60K3UOo83SizFxV/RNS/oH4Vx21sFGOii3Z3zqOnQlgDeDj4KoVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lobxIKSh5N0u+woJybsdvbzBBzs5tPpw9P4PxceIrCE=;
 b=Bc+3PfyozNQJcJWJ38eOMu8QQ5NW10pAu71ltoCqwQfF22tjlaZyCIKEoBnwGuxXI7n//filq+nl0kGRgUV7PSNADWp+fyEzxHBI9dzeEOkQwR+g6h4poC4cm9WHYx7rvOcDqNgfzhPoLSoAdcfHJiEQ7F4ABH5NIrnKNsk8xhQptecppfddmyc5xcqurg+v8e5/YMEaoDUF5WH1iloawAtqZbRrp13TQ0nikEDeR2dkc3hunrR7PC5yMcWOJNy3rG6JDcZqERn6jKLqxUTQtzNKQxgPDr9/Lzj96rkHCS8LoRGfbz+PZnJ1zUSQTMpfTLx8xpRZFQrpVhLDcti3qQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA6PR04MB11871.eurprd04.prod.outlook.com (2603:10a6:102:518::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Mon, 16 Mar
 2026 03:21:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9700.021; Mon, 16 Mar 2026
 03:21:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH] remoteproc: renesas: apmu: Fix typo in Kconfig symbol
 help text
Thread-Topic: [PATCH] remoteproc: renesas: apmu: Fix typo in Kconfig symbol
 help text
Thread-Index: AQHctNxGoDbWLDqrl02Efm7kXJjg8bWwfiOg
Date: Mon, 16 Mar 2026 03:21:32 +0000
Message-ID: <PAXPR04MB84598136C918A0CC09B9221A8840A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260316003148.306056-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260316003148.306056-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA6PR04MB11871:EE_
x-ms-office365-filtering-correlation-id: 9a4f2752-6eff-4ca8-66ce-08de830b1f52
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|19092799006|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: /7ArXnm/f5yIAx1YnoZtUXw6ylz7tYq51bVw/CNGEuwdIOXnkq7Va7is3bTrtpMVCSxksyhcayq0ruCSaaU00segV9v54AENxIkk6oaIy86JcJC9Vyf4B4oFsFG3kte7m2At2M9I4tbZcd5t9+wNtM4rM6H5mDQ/2DZMKSZb2t72SW7zynuSttc5YxMGnReZjJEWnLxjpwRdICJ5w4Fd2n+popok81qxz5qoikLPX+ywgu5g3d2FtBEWn93rBXQfgNbtp1xJwoo2rgPHEjO+ss7LWzbjZQHcBBLcvUOihab32Ec3SmcbB1bUj5SfkyoCSgqOH82Njffdoqgc+7mGwirt1vlcCykHZgyW35pDEihP6haATbnNWjKxdWORT7hnxSOsuFFLaG9wSQ5S9KwHJBxUg1tXJRN4Z2+4SSFTDWElWBNAZigs+wy3ZDe2vSXhCoWWsindh4L9yuxG4Kl/LIHuX2KFdNqtGfE7HieoCLt9xzKIuXsoBNofgtkSkG3mXuryUffak3ONpynVSxvMcnbm8G2DlZWp24pDfWUNIpUwURtVQX2nfZ1MhHdbw3tebSb5KR4Iq9mp7/cxbpMPRNTbYcJla3WPRZGs0fdoc1xtsqX14SBp3FwKg29T05Kk5uNRZgndpJFPQjHBWabu5M1qqAxLNNFXLB9YdwN95L/O+D+Me6PoKOpcKLgEYthmw/2J42KghKjojDxbni5K0LTVHeEXhqvr+stR07GxnShfNSkDpCEl6186zEOPPa5PHLGa43bIGJV6s+ziIdU4cp8YBig1Ra7oMUBj7WqbYSc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2DJiWf38/1fCyH+Qkc2ibdk2U2xnC1ne9dEp1qPdLS8OFt0RQlzpqPEuEnF0?=
 =?us-ascii?Q?ZYtAgSfLzMGNwii4VCnuzdHD6QcD6xWDgOndMPtXi27YK7Y6I+DGBdogt4/S?=
 =?us-ascii?Q?E+EYOVOlrdvgagRhYT+5lyhBx4hsKeRQHHU84yZc7LtBifCTmY10xFg+aQof?=
 =?us-ascii?Q?PZKzbz8+F9LwKPv9nMGJCax1DwWYwxEQnD5eKMUsKndm2MuNm5Vprg68bj0B?=
 =?us-ascii?Q?C3atJBTP9wMwZdOI5Z9ABexydZNsAfZCXUUBkun/AqkCWg9twYibCo0OaPmi?=
 =?us-ascii?Q?DFlt/Nd7uZn+VQUGF9iyhYl1qvygC41SCSJ55GkefjFQVQw/LXz+JsGPa6h1?=
 =?us-ascii?Q?BYLkIWLDL9HAD/y1hLwF8PpNUHBdOvZZMzoAZMpZjDhHUAMlWwdkvPOcgh/f?=
 =?us-ascii?Q?hnwwCR+/8EyecC+Ti4ZkrhPABe4sasYrElx6v46nxNa8my7ET2uz72XWvlUn?=
 =?us-ascii?Q?hgiA+u+G/SOEmXk1EvZMH0a2Tjo5JZK4aYLOaQszRQ6D+W/PV1lGUbjAT3/4?=
 =?us-ascii?Q?cJCVr+dCoYvg9nsaEz2b95Hw1ESWtdap86oMrUTO1AY1q5dfi9y2/Tm+4uZh?=
 =?us-ascii?Q?tjSpsUJZi3+V93pjtdQ8jXdOQ43o93Tf4vVzrN9EUI99J6UKB1rZwyE9VQ9o?=
 =?us-ascii?Q?UNOLBN2RVGUbkO0sz+SiPfvK2odY4mIoh9BW4FkWwm8HZy1vKTU5/uppog7I?=
 =?us-ascii?Q?yRya4SM+7qjlBGLX2SYI6w+4f1pBNf0wqu47v2KK0UW5YkHN8gwvm/V8PIPC?=
 =?us-ascii?Q?0XI8HfAp7E7J6h6z/hjo7hPfTqMr7rbOI2cRdefVbB8xUQh1gc5+5xjjQHPS?=
 =?us-ascii?Q?vGkY+rpHew+RAejOaiu2SvxJhy/bfBr0080+H61XEne8GnaK2WIl1wA5Drjb?=
 =?us-ascii?Q?eGTuY6iykwJj1hCaLAWSAWmhDYYs18RONrTL7eJ8San89Zkh2k4TAkxU0OEA?=
 =?us-ascii?Q?663YNYEydpLdUhbv+b2Okcy5mUSHrOL0EZZ79Bx0aDOUBOSSYbtG0hdiiw07?=
 =?us-ascii?Q?3IBEOctJdjSgqFlOXSLjOx6vjNe5+f7AhXQPfu5ClVjBjM92HdQu7z6XZ/1v?=
 =?us-ascii?Q?1riQmUCcidQXPVYouJxgItNBkMrDnY4/DLGKkIajzMyFX82zbRqPBv6lrqxy?=
 =?us-ascii?Q?rl4DivptQWapsI+8t4u1NOfzxiAY7yaEaVJeVViRWLn8D2xlBKOfxIV8DYV+?=
 =?us-ascii?Q?/hoNzzXz4l6vTKtgxZcZEnVFxGiPC+qZ0OHG0A7LW1LV/bWh35QAAUVHX+Bv?=
 =?us-ascii?Q?DYFxgI4YbQSFij6RfMCCwN1MkWHtIsg3nuFSLIIMCox0uTWnSXwkX+rD3GUt?=
 =?us-ascii?Q?+JtrV70x9niPFFzLO/8HNge+zHjMZMGlevSttADqio/Rtkr4JLQpXzXj3mc4?=
 =?us-ascii?Q?/ftqH671v/bVc6kvtaP3mnwth5OT/Z1Te+UPq2q8QA0zCvZBeP0BJ0zL2xq+?=
 =?us-ascii?Q?DeR/XhrM74udDy5/rJpFIn2PM23tWDkGuiycA75b092CwK3CjdaKZhYmpvv1?=
 =?us-ascii?Q?KLKBAEF1jVs69B5UXVPYyhAcgan/fTd2NTZcPOzQQ1pmqL3LkoJC1y7dr1Y7?=
 =?us-ascii?Q?AH8JamBQ6lABh3bCwpiEAcI4ePH4NjQjwqPqRPdFnDx4mMxqj44/Di+RVo1E?=
 =?us-ascii?Q?iLQSPrEZ9PlLJSUybbZY69gyRS2DeWPhTwASFkL2agThMuaUvcpySE6U3hHV?=
 =?us-ascii?Q?eC5adQqEkzt9pG6qVyJB1Z2auDMvV6NysSYnz93VfwCZUIHq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a4f2752-6eff-4ca8-66ce-08de830b1f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 03:21:32.6328 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P4HwvQUp/9rUxQUpVFzaGgVHpiM3wJx6+rx6wYhz9F7AOpAtQx9B0pkJaJ3H76+yRTAIehdMt8A/qprWePmGPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11871
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

> Subject: [PATCH] remoteproc: renesas: apmu: Fix typo in Kconfig
> symbol help text
>=20
> Fix typo in Kconfig symbol help text, change incorrect A52 to correct
> R52.
> No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Acked-by: Peng Fan <peng.fan@nxp.com>
