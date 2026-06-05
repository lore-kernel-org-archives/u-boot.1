Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D83DCD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 11:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42D9A848BC;
	Fri,  5 Jun 2026 13:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vCowGaRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5CD848F5; Fri,  5 Jun 2026 13:38:12 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 854C084879
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 13:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwIi+gX6PQcYamxmSFFZLhINtI+5GFq6AwYvtvgvttA56+xdwkG4x9auoq82niebclHI3qQ4s6OZyNI5gm+9mTWWXphWyal9FOUMexrvdq62kvGXNJK+Pu3dHv0nozrJPR5yQR5k07H8NMHeym8YY8jmrJT6Pzpr4P7qyIdsgat+/sO+ZT3kNE75O7tJGJYFQnHPRQ/4ORS89HTIUGmmwFA75znnGkM5JNO1GLbV69M3bOiM7mxYLXYb6ff5QnV87g0kbdDgwBsP4Zh17WvZg2eHJVflBGWiOXhNEDao8mKMerDUmotsiVKm9WZVqma3ZgrGn80S5jjsa6SXN1eRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLWi97+YBIs7wqznL06vfOOMy4pTa4FSYPv/pSkN4sQ=;
 b=wKWk7J1UNohceh7I7pcMgBHVE6YnPqkPsJhliPDfSxH1CRkh43wlg0xUN4toAQ+oUZh7sbM/NOYoHwyviw5NJJHwtKAWai7aDCEXSSrP++SdNDzKgTBsNubxKCZ5SuITrMltiQcxSDbPeoHbOhLlVFb/G43FWTV2y4CkCm094OAQ3+NvyOxVN5Or+n4Y2jk1Y34m1PTtlTqxylbqSQ/rJNw5sYk58H7+nCwRV0BH55tVOakRX1CznB8YI05vGxha7v0fQ1VD/UJKrqSoOoJaYniF1dWLXmFhrqP6bGuBQigKHRn/fH5rZIAhJgPXIi1HlFR1lWaJK9W5bo+WuedS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLWi97+YBIs7wqznL06vfOOMy4pTa4FSYPv/pSkN4sQ=;
 b=vCowGaRCs9A5LrM1WGGsXVrK2b0JFIPEUcmHPtYHV0asd+eYNb0OFqtXJ+VutqIPfsyo5C/by/zVf4wmJX8YHMW1s+e2NPHFssAHW5j1ndHpNihAG6g79Z1f6XPl2HxX3bkfM+A8NeIyX4drJ5ryqt7jOcqUNvv92tX9Z3pb/PqZBDmFUatPf6zvxRXVqRfG5G8+z4Fs1rHdT2LfOXII0VUrOi9iH1hX3DosmyO8RicIWg3Bu4fqHYkrJhvrezVM6oocIgJo5lRNwSgHMuKhU6wlA4rqfwRiyGigY6Iw5MZojjUEcUej50JFE6i47jaKKuW95BkAL4eY5VdP6hyNJw==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA4PR04MB7952.eurprd04.prod.outlook.com (2603:10a6:102:b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 11:38:04 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 11:38:04 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "Ye Li (OSS)" <ye.li@oss.nxp.com>
Subject: RE: [PATCH resend 1/2] cpu: imx8_cpu: Add iMX8MP UltraLite Part cpu
 type
Thread-Topic: [PATCH resend 1/2] cpu: imx8_cpu: Add iMX8MP UltraLite Part cpu
 type
Thread-Index: AQHc9NCGMW8hFplzE0SApCTw9mFwN7Yv1crA
Date: Fri, 5 Jun 2026 11:38:04 +0000
Message-ID: <MRWPR04MB123304A275462C5385828CBBD88112@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260605095108.3223321-1-ye.li@nxp.com>
In-Reply-To: <20260605095108.3223321-1-ye.li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|PA4PR04MB7952:EE_
x-ms-office365-filtering-correlation-id: 449df9f2-d8a5-4ee5-d11b-08dec2f6e7ec
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|19092799006|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: odpc+l01VDrVH0hWcwmrKVTiWTwiv4eldRUrrA5x4sNFAgwEnjB1k6iHYfpjhJUj8Z9O68YwEc6x5O4SN/+S4kd9rMnXdEiX85rQDaMd/ATZqwg0dKNxV+aaMWkAPbpKhDs5UunKGksA7g6pp3b2lAG7NN+Y3CL6C+xtMnJ6DLVJJdHkShovHXiQytgEXZU5TPeaUQV0TG/y7cxgKJ630gI4t1MEQDThTSS9EXrVL0YhirzUal5Sx22GfESafQOL+qC7bbKq6Ehh9Hs9qtce20c2VLntBfJZe9OsTf/aaLn7XMcbjQy7OttDENhCNv2hpMjPEjUD4Qs1mf4t3RHYVGck6nkcB/azIONO4lVVUo5prbLd0j9AjcJ2h+k0JOaO6qz4VRBjOC5kpZg49d5MHPW5nli9H5twPnY630+AlHSsYd973dU/5CeqfPF1vHUsL0+YM9K8FdTQwm+KtnAhkKAb5daEjSXaM+Dt7p5s9kZLTOzVwYMCc+r4UbVQ3vSAH9zClNp1PbyJTPe1C6xRjKtMMMUSCRBqz9F8Cd1pVMkYwqnBqOy/xVpCunk1khrJW50ILLGhH6DTSYhMqG9cSqoESG14T1JJ8RX8mVg7dNi4ZK1NmLc+RrX0QUcwGSO8vr7VeAFO0XMA9kYh5cSOuy0UUqxy6yuU2YUKRAefz7Zw1qfBXfQXUY9RWLJuAIzbDWhPlGamVcQlpCpl8vHV8pGTr97k13qlqh4sAelXTb6kb9aRq1B3HDGwde0ZDm/2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pe28abP9CX9HUGiDkN7brRDItofppkHDpKTeDotRseuEqKN64wmg3vNSH1k+?=
 =?us-ascii?Q?qs6vSbeta0cry+kBg2QLYORChi0UETU4MXpY84mdJzOSPhTKtt+lMW2jay4Z?=
 =?us-ascii?Q?8kT9uIuAcD0Vwg1s3+/nRq8e97HuEED9prCk1LJS0bN1Sx8+Gy62rH2aDaPn?=
 =?us-ascii?Q?DiIKFYH2YXGD/Rwgnv2hOxMMhRX//cbDNiv86f3mXwAev2aSQrF8ocd9Slb3?=
 =?us-ascii?Q?fKNtxIoq1qBEXX0HvxWLCuPedUgiNsYssTzn7qpVsVmkKc4P0s4xyzQNcH/X?=
 =?us-ascii?Q?dCLfXH0I4Y6oV2tWu1aNaIkGwZBmOiPU1Z3LQUlwa72BWmk0+gbjAfWzOwRA?=
 =?us-ascii?Q?LI6OzLJFcip4mTfUQYpaJbNSqA5e6NLbxvjblr/OdzrWB3le1EBgADxgm/tv?=
 =?us-ascii?Q?y2DA56z2XZl0RjgQ+ClzXNf/vHoLMM9yqWXmcmibNmNpj4O0FcyQ+PVo2+V5?=
 =?us-ascii?Q?MYZL66z96P7WquZNtSIP4BLFMCW9UQySpzN3MG8+VQL3XNujGxq+sTu2JOCn?=
 =?us-ascii?Q?Si3NzU6GAkaGCsgNkt7yfRPTvEkQ3WK+Tn/MwMdg+P/0aLyyR9hTyIinckqa?=
 =?us-ascii?Q?DcwjTDtgZa/skKgrJgsm2kobsPwptCrQqa3aI0nHIpNzGAbaZdvZCPrxvnKH?=
 =?us-ascii?Q?Bqfu9HVb+M3GpBFozH12V+10dpQ9QtQpSC3FYQVfRb6EEI+aDF3PXMURiA6m?=
 =?us-ascii?Q?aIum9f74fD4KJptQgOZG1ya1blT9xgJb1BtV4ENH80PSHZXTf6cmsAnxpi92?=
 =?us-ascii?Q?EW3Io8F50QKLjuE4XNszPkJyAhMSzYDIP/64VcGCkpXHd1GKCFDNYi+clr6O?=
 =?us-ascii?Q?gpR7O/qIGiV6luJAy1indVyJ5C3ypo3vWBK2vC9Lis/6Acb6xE3D2JROKVe3?=
 =?us-ascii?Q?WZv1+CFqQLd+MCN9OZyE/P2ask1Ejk4aMA1J88tUTRTqcIFFbxELaLOdA4DN?=
 =?us-ascii?Q?dx05dxLTjcdCsJIhQqbCtw99tsiShRW8EyPkRcciWLVPW/H/1oC81akdK8xA?=
 =?us-ascii?Q?UKRqGyg+qSttYGIMHOQABNNzVcZNmo4Tsd/nZZU9DOCYTtRakDZheK3SmLrw?=
 =?us-ascii?Q?wfbkdlsy7+RYVSXGK7SoQfB0pbljN1zKKDtkvkVI91tmyDo3PQL3CdU+Z8Yr?=
 =?us-ascii?Q?7mJi25vteRp6KPF21TcLbbahh4QKxNIPipD5ddac5hQ7p9JqNRJGeFBL4jmy?=
 =?us-ascii?Q?g/P8nsS6vrwS6uIibT3hM/o49/6qTxvpbR1mif4zWiif0x09SYmjOvv7Nkg0?=
 =?us-ascii?Q?Vsi8CbrQ81fX9Nlc4XNLvJCndpRM9nFA3FQ6mJYIf3jQ6VoXKkLUXY0bP/sV?=
 =?us-ascii?Q?cY4CBha7MfU2Jko+reC4b31y5kAw1aHSSS3TrKK7wFYiXInxmpPH6lfl4oaw?=
 =?us-ascii?Q?Ekafs4vlgnegLHak9E0mAdWcfKO7FldNfAOS/1QqhWFu+seYJpPRMC/ZX86P?=
 =?us-ascii?Q?aWkQV7WY3/Mfxvkeka9+reMllVtChwrvP2lPcWF2Yq47Ih/FAdhe8Sx6zCb8?=
 =?us-ascii?Q?uWCmcqrUtr+4sqFmWb0lM+k4b/2HXqOssgwZ6HDPDwcE9YZEsXbqFmN4RFFU?=
 =?us-ascii?Q?3a7QBdJ1PXHneUKQi+H5QRmJ6ne6IfuwC9lufVe+nS5wnhb7Jmh5GP2SdEF/?=
 =?us-ascii?Q?4EbLVhejLg7SXE6a4+IqPEfjyHJ5tUIPkOeWKzaMf6N7Loox1n3IGcWHOcES?=
 =?us-ascii?Q?Vrjx5WG0mTVBULmPgG7MH7D/7YaqDCxOtagUIrPwJU2IfBV4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449df9f2-d8a5-4ee5-d11b-08dec2f6e7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 11:38:04.1716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnQmgDUiWJkgTsGikhun7IyLMuXbxNktGUjDztxc6GzNWKRrCXsb/G+wZsjlQFpixWY192RRZBqabK0ttt7tPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7952
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

> Subject: [PATCH resend 1/2] cpu: imx8_cpu: Add iMX8MP UltraLite
> Part cpu type
>=20
> iMX8MP UltraLite part is missed in the cpu type print
>=20
> Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
