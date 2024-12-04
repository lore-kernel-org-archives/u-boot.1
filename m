Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2EAE77169
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 01:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1698940F;
	Wed,  4 Dec 2024 02:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="PczS2b+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90C818940F; Wed,  4 Dec 2024 02:07:01 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7BF89430
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 02:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mlTmJfR9wyjaWl0I1y80uFIbR7+l1c3qTFMpaARJSmspMY9GGR1UGMgzXu92isXsYCCZ4TxSPrVXaKwBhyXiFtcCFvK45vrQ32fpjOTWZ+o9Jj5Oy8M8GhoEinnwUa+N7u2upkezHX9kt0739+1jB7EqQi05jqn1w5ZhOqEAcA0gvVc3z3xQoQNlDP42HbiYDwy6ErVGfBi15hxOgQ+RurwRaxwMSKBNkrVOx6pbPPu6cPXWxXOC/Buny0nGYFPCNLNyuTrb69sp1SRwK5y933cfggB2sXSIvrPCQNjLdmhsRgK5sK6lu3ZCRQyJRYMuU4ESb0PRURck5FxsbjULIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5LF0qppn9/dIHzXN4CbK4OWI7ikfkCEFMwZ/ahNZkg=;
 b=UMXs+ymMz7QCoYPC1EV8eDeTo9uEeGxsXDfNYry0pAmBlQ3B2OAXa4XYdy3zk9TESD4Sh7Ro0ucuNdkasoUNhvJ5cxNmU/CcD2pya1XVaYIb8zIhU66ekhtJelLLg7CfSOGHaZRHzjHG1h1rYZbYF3eai+xyg7jdly3mHYAHTf1nCHyE1w25ysGiOez9T2FslgOe28cGVIBMq1D7PiDSoIM2hZZhLTmC2Zv6v+UMHdLXdp1ayVWUTGqueK+Z99hCfa2TO6wkvQvZvkqcdAxheygGWwCGk44C8ZJetHC+aG7rSjKIgpo7CbPVmN+mNEOSNT5eai3hw+VogCCg1u+iKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5LF0qppn9/dIHzXN4CbK4OWI7ikfkCEFMwZ/ahNZkg=;
 b=PczS2b+M0uccJA6Jy+kxDo2pvkqFk8Zs/jjWjNKf6u68zgYOYk6X4/tT7ndhbHraGBMxaCb0t7OkXt+YF9AWmL2BTcZYE6ITBGoaymnKlYlEIu+iFja24CpjXD6dXgQ9aAWxieAbJEg8j5Ka0d5piUQWTaSO32pqhqdm2VDUurySLjvz8fiPPtrG2fKj/K11ijWvTlcmXp86rdSBIOOPJZcOzBz1wW0UjFelbFZVpjbbyDOjzQJM5vUyapWFaW7JRKPZs8wGAs7UvuxFGuN9GTWxFZgCQh1OgCbAuvahsvA/iLzinwY2Zh9OJ8L09qWsRQvRjSVQeYdTdf2JFSTgkg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9322.eurprd04.prod.outlook.com (2603:10a6:10:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 01:06:56 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 01:06:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 01/11] gpio: imx_rgpio2p: Move 8ulp_data to data section
Thread-Topic: [PATCH 01/11] gpio: imx_rgpio2p: Move 8ulp_data to data section
Thread-Index: AQHbRZDrWWClTPpwwUaw/5GAsj/NorLU1waAgABvAbA=
Date: Wed, 4 Dec 2024 01:06:56 +0000
Message-ID: <PAXPR04MB84599601D41C6A6811E793B788372@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
 <20241203-imx91-v1-1-48d2eaa4519e@nxp.com>
 <CAOMZO5BEEM_oWtoQE05VVTwKFiUe2yXwBvJyfeo089VSR1VkKQ@mail.gmail.com>
In-Reply-To: <CAOMZO5BEEM_oWtoQE05VVTwKFiUe2yXwBvJyfeo089VSR1VkKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU0PR04MB9322:EE_
x-ms-office365-filtering-correlation-id: 8946fab9-0eb4-4a29-ced1-08dd13fff29f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkdFY1VXZmphS1JHaml4akE5aHlyVUVpV0EyYWZtdTJ5UTNXT1g3bUliQXJw?=
 =?utf-8?B?Z2V5SUFhS1hiVjNpSVg4bFVqaU9lbTkrSjdISk1OdjJUbmVlNWsxWGZxWWts?=
 =?utf-8?B?SlY0YUMxSVU3emtPTDVyRXEvNlF6N2NoQTNIdHhtOTdNaFE5ZWdqTmlGMCtK?=
 =?utf-8?B?KzJZU2sxWDJXbXRmZHo5akhxTE95YWM4Nm83SUZtTlhPOHBYeXpVaHMwWVJr?=
 =?utf-8?B?K0pzN1B4WUUrVW0ybEtCNW5JcGxxVnduR3lZNTRsRXpSSko3Q2NDZHc4TUhw?=
 =?utf-8?B?MVJPWXdLT1NRQzZPUGFOdklGZUZNTHExRkdXcmVzWVlxM29yNG1hekxsdDNW?=
 =?utf-8?B?K25LTDJ6bk1ITUM4Yk5COTQrdzlaVEIzZWQ5WFE2d1hrbjQ4cXB4b0x1ZDJH?=
 =?utf-8?B?ZTRxWVJBOG84TFNYYTdMbzB4YVZYTGpQSFkyOW9FZFdOeXVocEJBZHNQSG9S?=
 =?utf-8?B?eS9MS3ErWTdERDZkNG9aeUUyR2FHamtrMjR0S1pJQmN4SVdxc0pzazlHNkRz?=
 =?utf-8?B?Q3RVSVMxdlQ4NzBoMXRhOFZjTE4zNXFhZWc0WWVyNXVOTkIyUVhpL2cwcHlk?=
 =?utf-8?B?WGx3Tkx0ei8rOFpkdHN1UnhQUnFlOFowT0hJSmhDd1YxRW14VThGbDBwT2lv?=
 =?utf-8?B?M0VldVRFVENsZHRtMktxL1lsY25TQlZXbjJaVTFpemd0Umx1N1pIS2szb1I4?=
 =?utf-8?B?c0xpVWxWQUc4K3NpS2hTOFI4REQrK0c3VVZDUFoxN0xxQnd3RzJ4TXVmdno3?=
 =?utf-8?B?Z3BWdU9hZFFmaUJHOUJqZU8xQS9CdmdsUkF1cWUxdVJ6NkRla01qQU56dEhG?=
 =?utf-8?B?Q2xXTmFWMVBwSkRPSytRRVY1cjdHWDJ3N1o3YmtSalZ2M0EydHRRMDZTOFAw?=
 =?utf-8?B?R0lvaUMyZzBZcDhRRzRadlpNa3RiT3VFOFl1LzdWMkdjUmZGajQ5YS93c1dY?=
 =?utf-8?B?bjlLMTh4ek5TTzBpMHkzaUhoMUJTZzhqd09UaThXRWs0YzFnYTlTMGI1aC8z?=
 =?utf-8?B?L2djZ3ZNWHptTkNzSTdQTk9lbzJZb2VaRGg4VVhFK1V6NytxSjhsMHJXSGJU?=
 =?utf-8?B?aUgrMVBBOUhPZkd5OHUveHJwUzBCdEVodUJmTU1TSGNjMVY0Tm1JSUk4NGVP?=
 =?utf-8?B?LzRvY1Z4Q2RER3VWa1FQZEZCUDY3TmR0aFNCMVNZWEU5Qlp2RGFlaUl3RkVT?=
 =?utf-8?B?Tk5Sczd3YlcwWFR3aXgyNDJDZ1NVbUxzUU1VTDFLQUhyQy9HVFlTRjhGaFFE?=
 =?utf-8?B?QnA1bnFOM2J6K0ZReG5PTG5uMXhmaVZTM1FycFdualFKdmhqcVRmd3U0bVZJ?=
 =?utf-8?B?eWNXZ2FvL0drem96bmVyVEU1YmtpZHV5bW5ET3JOT0dtYlcrYk4xcE5RVkdU?=
 =?utf-8?B?RDVQakl0SkI5WEpXUUp2aEdweTVpdWQwUDNYZ3NZcE92bW82SVhBQnJVaVVZ?=
 =?utf-8?B?MG05WTRlakZ5V1VKZEJuejhJZFcwZ29WZG5Ob2d3OXptSVczRlF3eThsYi9D?=
 =?utf-8?B?RitlS0kxRlNJamx1eURjVmVXdGJxUys5L0FEODgxVHRxY0p3dEdLdzlaOUdx?=
 =?utf-8?B?ZXU0ZjdtR1dNSFN6dnVOTURDbU5pK2dHRldsbUhYSTdUdUpUYWFiWGhaMUJY?=
 =?utf-8?B?ZU9GNUZJeUlWYVFPZDlVcVl6UUs3ZXl4eldBVjkydE5lWDhvaWFnSGxQekox?=
 =?utf-8?B?MENvWmpxRko0dzhxbkRDTmxHQ0kvbEUyMHRQQVV6SnRaZGJUUFJzWnBKQ0V1?=
 =?utf-8?B?RDZRSTJ2L1B3NysyWEd4WGU1T0NjNTdkWTVDaEtSYVFESCs3QlUxcUtiY1c4?=
 =?utf-8?Q?BEfCWyCI0cq9cviULK5LsWe+35CCDeeEhVzQg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjI2YzR5WXZqbFZPbTRpT2NmeXpjQkpoajc2MXZ6NFp0ZW44eHcyUVBkdFB0?=
 =?utf-8?B?SVh5SG82SmtLOUlQSDJDR0o1UkpFUnpld0dlelludGpZOXdrajREcmJ5Vy96?=
 =?utf-8?B?VGpaQ2M3a1dtRFhsMXAvMnRxeFRsK094V3B5bEJVL09aQ09hSlhSMFJ1azIr?=
 =?utf-8?B?T2FUSnFLT0ZucW9aRElYTTJmVlBLMDBZUVBBV3N6djdCSURyeUo5ZmhMdkpk?=
 =?utf-8?B?cjBoTENTUnJSTkwwUHZlQWhQeTdESzRsZjBHQm41TEhVR1ZxUmxUUFo3elNS?=
 =?utf-8?B?Q1NGQUJFdFZsNWJzbFUzQ0RJZ2VxU09JbmR1NElZRWZDL0JzNG5FY0x6d3k2?=
 =?utf-8?B?K2hoM1pwTThFS3dhc1QxYTZVOTJTMGdDOXpwNUdkSEd2QWNuN0NKclozV1NT?=
 =?utf-8?B?Mkh1Q1JJa3E2R2dyK1dsaVYwM09peEpRVlJEUUNBSXZaaGNyZHVETlFaemNU?=
 =?utf-8?B?U3QyYU1HQ2pnNkl1ZCtCU2lteHVCd2lZM3gxdnpyNnNILy8yWm8ya29BUm5O?=
 =?utf-8?B?WWl0NnIzUlR4ay9NczNTYnVqTHlRYW1nUGdoNUVrb0ZiY1JjdW1CeXBZZi9a?=
 =?utf-8?B?WVZOMlRPVkxTeW1pYllXbWVydm9nNDhHKzJGTDRuQ2I1eHNNQlNiYkJKUU1q?=
 =?utf-8?B?RGF0em9TY2VzQlZ4Z0ZxQTVremkxMkxEQXdFTkZZQkM1QnRtbGo5ekhteUNi?=
 =?utf-8?B?Z3FFZnlWNC82M3ZMQVBYYUlVY2NjSFdzTWdFY3BmSUkzVXU3Ym1vTVRqRGty?=
 =?utf-8?B?a0JydVNKczczbzk4ZmhzK0ZvMWVkRWVUZm5kUitGU0RTVnN2cHcrdTlLMnBM?=
 =?utf-8?B?enNYRVM1WkpVTXdQaXRxRm9BSjU4VWtsaHpxdlRaTFUzRlE5ZDR6U1g1RGJM?=
 =?utf-8?B?RVpoUzhGS2FVVUlCMlBVNHhYdWlET3NBcjNWb2VNcjVOSzhrVWZXZW11QVE0?=
 =?utf-8?B?bHc1cFVDSW90Y3ZQdUFucGhXRjl2ZWRxVGl4dUNGYll2Q2czVEJrQUcrMEIr?=
 =?utf-8?B?NU5QOTFJUnVlYkZyMjlxNXp3citoWWRvNEF3REhHblE4S2RPU0o1NmYxd3JM?=
 =?utf-8?B?MjRBZ21hc0xkWFcyNTJaNU51SFFkNFpGUUdTZWtRdWxJTG1MUm1tOE5tWjhs?=
 =?utf-8?B?L0ZQbWgyQmZ4S0ZybU1QTUZ6TGxtbDR2T1NiQlJvaXEvMkJZd24rYUgrRzVi?=
 =?utf-8?B?T3JiU01HUXRvY3N6SlNKNCtXV3lhNzNITklGcXpxNUFuQlZ1WHVaY0ZMMTVJ?=
 =?utf-8?B?UExsWWNnMFJRYmY3WHBtUUIrMEdwTXUyRTRjQi9kTFNuUkZNc1hPOHl1OVQ2?=
 =?utf-8?B?RjRvRVdwd2VHMm9qcGNQUzlUQVZZSnRGNU9OaFpLVUhYNWxYYmN3aHE1Nkkx?=
 =?utf-8?B?R3FhL0ljcTUrTXFTWEJuSHlhN1hKcWR0alRMQy9zbTBRNUhKcVJTRTlham9Y?=
 =?utf-8?B?YktmYnh1SkJFNFJWMmRLUSt4QnhOK2dNVkVjUlFvZi9WUXN1blU0UGtyRFRm?=
 =?utf-8?B?OGNwS01vb3JDRjhkSVp1aGJzem0rc05yWnRFclE1QVNmN0w0bUV6WUdRd1Bp?=
 =?utf-8?B?ZnBwMzZ6cWJnMWVuVWdoYmtXWlNmWU9EWFQ1WmlsLzl5cFExSXlvS1U0Z3pL?=
 =?utf-8?B?eWlTU2xaMnJveHpqajZ6TFAyZ3BobDE2TWhHdXNaWEVNQlJPUWtHRFFrQ3Qr?=
 =?utf-8?B?VGthWVVxaEFFTFlQcUJPWVVTSFlyQVF0RnZTcHFKWm9LR1JsUS9UOVFoZTd1?=
 =?utf-8?B?Z3hvUzVLYzhRWDZlb2J2SUxqdHdqUDl1aUhyYmVHOUVSSG42RnBsNUhkMzlI?=
 =?utf-8?B?MmxRZnRMTnNjVnRINUJBVEhPU01sTmQ0eVpYRStsR2dMcXhlNGx6Q1gzQ3lS?=
 =?utf-8?B?UWFNRXl4Zm1CR0dJMk8yR3F1Witwc0ZDdGR6eEdRajM3eWtDZW1hRUIxc3BH?=
 =?utf-8?B?a1UxN2x6dXdZWGg4VmtRL0RlNVB3VzQ2djJ2ZmkvTTRmQVcxVkRPYWx3K2V6?=
 =?utf-8?B?aDVWY29FbnVFMkpJbFJtUmhoMzJDKzA3RkJNTjB4TkhzUkdSeDF6LzRhV281?=
 =?utf-8?B?UTNsV1BScUJESDU4TnJmNHFJV09CRzhtQ0tvM2VBQSsvUVRTK09MTXE3VWRI?=
 =?utf-8?Q?PyX0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8946fab9-0eb4-4a29-ced1-08dd13fff29f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2024 01:06:56.4519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DgVoRUEJTDQk/ODI9sepR3n7UO6E1q8YN956M3MdNrfGeJhSSU0pm9wj8AoAjj4SO5UYciG9dI3JWgV7rguYug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9322
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAxLzExXSBncGlvOiBpbXhfcmdwaW8ycDogTW92ZSA4dWxw
X2RhdGEgdG8gZGF0YQ0KPiBzZWN0aW9uDQo+IA0KPiBPbiBUdWUsIERlYyAzLCAyMDI0IGF0IDEx
OjM34oCvQU0gUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gaGF2
ZV9kdWFsX2Jhc2UgaXMgc2V0IHRvIGZhbHNlLCBzbyB0aGUgOHVscF9kYXRhIHdpbGwgYmUgcHV0
IGluIEJTUw0KPiA+IHNlY3Rpb24gd2hpY2ggY29uZmxpY3RzIHdpdGggdGhlIGFyZWEgb2YgdS1i
b290LmR0YiB3aGljaCBwYWRkZWQganVzdA0KPiA+IGFmdGVyIHUtYm9vdC1ub2R0Yi5iaW4uIFNv
IG1vdmUgOHVscF9kYXRhIHRvIGRhdGEgc2VjdGlvbiB0byBhdm9pZA0KPiBpdHMNCj4gPiBjb250
ZW50IGJlaW5nIGNvcnJ1cHRlZCBieSBkdGIuDQo+IC4uLg0KPiA+IC1zdGF0aWMgc3RydWN0IGlt
eF9yZ3BpbzJwX3NvY19kYXRhIGlteDh1bHBfZGF0YSA9IHsNCj4gPiArc3RhdGljIHN0cnVjdCBp
bXhfcmdwaW8ycF9zb2NfZGF0YSBpbXg4dWxwX2RhdGEgX19zZWN0aW9uKCIuZGF0YSIpDQo+ID0N
Cj4gPiArew0KPiA+ICAgICAgICAgLmhhdmVfZHVhbF9iYXNlID0gZmFsc2UsDQo+IA0KPiBJc24n
dCBpdCB0aGUgc2FtZSBraW5kIG9mIHByb2JsZW0gdGhhdCB3YXMgZGlzY3Vzc2VkIGJlZm9yZT8N
Cg0KSXQgaXMgZGlmZmVyZW50IGNhc2UgaGVyZS4gSGVyZSB0aGUgaW14OHVscF9kYXRhIGlzIG5v
dCBhIGxvY2FsIHZhcmlhYmxlLg0KSXQgY291bGQgbm90IGJlIGR5bmFtaWNhbGx5IGFsbG9jYXRl
ZC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGDQo+IGxvcmUua2VybmVsLm9y
ZyUyRmFsbCUyRjIwMjQxMDE3MDM0NTA3LkdKNDk1OSU0MGJpbGwtdGhlLQ0KPiBjYXQlMkYmZGF0
YT0wNSU3QzAyJTdDcGVuZy5mYW4lNDBueHAuY29tJTdDODgzMmE0ZjI1M2NlNGYNCj4gNWY1OGJm
MDhkZDEzYzgzZTFiJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwDQo+ICU3
QzAlN0M2Mzg2ODg0NzI5NjMxODcyOTclN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKDQo+IEZi
WEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lr
Rg0KPiBPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9c1pK
b0MlMkINCj4gVlk1bEtSd29icTBINjJNYXVEayUyRkk4Mk9FUVp4c1cyT3hhUVBvJTNEJnJlc2Vy
dmVkPTANCg==
