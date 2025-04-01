Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B036C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:02:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD1F81F44;
	Tue,  1 Apr 2025 10:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HE2ec+fP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A7281F66; Tue,  1 Apr 2025 10:02:49 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2F7981F0D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIMkDqWgDUdcbqGNJCt0BonV/gG/4MUAGBj/V4ljBVYph4bVwe6bttkH9+ZhrZ7Ol1J2HakDuhX2gkvO+DtBszuippiIUPNwVntLpaIXTW1AXR99Lbl82/321yJUfV7GcFbJBJN7JNjusGb8m7nY/Oy61MMDpu2kpUTjRMK/s22TiJyg5ZSXnzLkeyhLJtSCJO82e6StW6Ped6jH4m++GdCcJ4mFqEETYhM+VroOXIBqnHx0Cui53oTW8Rc84KNg/1KXEkb+7HccpfIZCyDpK5HTvyhh0CYdMF4KBmcL6kHFpln6oorVDA9wKmdCvZciMms29ZI9Q4Z1+DaJf8hgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAgesPRLzqWuYiXa+QaZ8T3RgYwqrEuGhEa0JAM3smA=;
 b=QsWd9/FrF/B/mx1jQVt1BCEq0ZK3hdxl8EnAcDcqtxEvcIjwy6S6+zYGaQ9/W94Bhxsuokqw7ayqgPceZUtzMY2YO6pTNComR7rytXgxFssj/gBcn2hTlWiJ/XykB+bhRruh6ZKCI1gw2Dv96p1Gc3UJxzDfuzrJEuJzH0WK4s4OCQBsCHDo7WZHyIcRMCpLBvc8JgtiBJXrIPI8lqMtMbHk57NVbBf2YwRH7ruAu5p9zvDurIOBEZ688VKiQUcZXkulJSj9B23mDT6hiNxPOe+8lWmgVc2OfSEtFgr39jnVnvq2CiM/AZJMOs/Y5jNq6aBQr3e4NcScqo+PJKJMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAgesPRLzqWuYiXa+QaZ8T3RgYwqrEuGhEa0JAM3smA=;
 b=HE2ec+fPiXBqULKsTp5iwomTPcXlq0YgKIsXZFxC7DCJ6SPqc2AJldHtn2iZ00sIHU2XsighQfmO2DMWmMbHTcVWRzs5+ZGBiLfwJNJ8eAkiTqA/n+c9D5WrtjI9Gayy0SgfzhljmQ0MM9u4aeF0TBEW7VzyESMA246WM/W/v+ZZZ3yQOjxKFDpILs49z2cXBJsumw4HvZBTGfLKhTdww4fXL1vRRrrNX2ieINUoO9HL+N1OtnWMoKXiWOhNxHxvEWraqeUe/25eT1OgjaAejYSnrMvT78tBa2pVl2XuGjLOXuq/tFT1EdEe3b3g2J49yL9HUyArIU4PXadkhwzQEg==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7609.eurprd04.prod.outlook.com (2603:10a6:10:1f7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Tue, 1 Apr
 2025 08:02:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 08:02:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Stefano Babic
 <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>, =?utf-8?B?TG90aGFyIFdhw59tYW5u?=
 <LW@KARO-electronics.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Viorel Suman
 <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjggMDEvMTldIGZpcm13YXJlOiBzY21pOiBzbXQ6?=
 =?utf-8?Q?_Interrupt_communication_enable?=
Thread-Topic: [PATCH v8 01/19] firmware: scmi: smt: Interrupt communication
 enable
Thread-Index: AQHbmjEXlzHUdXyfmE2RkvS3AV8nbrN+UPoAgBAyuyA=
Date: Tue, 1 Apr 2025 08:02:44 +0000
Message-ID: <PAXPR04MB9644A20E1A0CD486012B0783E2AC2@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-1-f2c8ba815f89@oss.nxp.com>
 <aa808e29-5a8d-4662-b70a-21af4b011c19@denx.de>
In-Reply-To: <aa808e29-5a8d-4662-b70a-21af4b011c19@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DBBPR04MB7609:EE_
x-ms-office365-filtering-correlation-id: 095729fc-651d-4ab5-925b-08dd70f395e2
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?N1VRUXprUFRYRy93ZDRnY0lIMTlKS0R6Z2ErVkNDSkVlUkNwRmNqSTJ4K2Yz?=
 =?utf-8?B?WUtOVThhSXZqQnliZXh1OXlhTHpSZThyakd5QjlnQUhrTlFuc1RxV2U2Z09v?=
 =?utf-8?B?NzgzK2twOXlBMEhNemR1TG9oTVpsc29pMUpRYjRrakJMZ2VWWUxLUGJSaUw4?=
 =?utf-8?B?Sm9oYTZ4M01CS3kzZytMY3NvZ1JQS3NiUTZuRHJpSVpmd1BLa1c4Z0hvM2ZX?=
 =?utf-8?B?QTJJUzhuc1R5Y09PbzRGUm5idXRoZUJUQnAycVVEb1VWSVB3Mm5YblpnaWNF?=
 =?utf-8?B?MjhlUS9uUjRPa2dNYW9nQ3pFQlpPd043cU0rT3EzaHhiRDFwZllHSUoyM2oy?=
 =?utf-8?B?MlBsbzdyK1JCd3BUVEZEalFVaVR1QnJqMVVrM0NoMmlVU1dvVG1iZi9MRVVF?=
 =?utf-8?B?ZDJESzJWYTF1QmhuNWxzUHV4aVVuai90WUlxL0tnUVUxcHNuR2pEWGZLejNn?=
 =?utf-8?B?K00xbnZ3K1RJZmtvZUJUU3BhRC9xc2xoZU0xaHdEcTBxUnkwTjNLWEo1NWF2?=
 =?utf-8?B?YnlOQnBQSjJBUXlVS0ZNemxvOWxPL1lQbmk1SmVPSUozbFo0MFY0a2lJNjBT?=
 =?utf-8?B?WTdKMXJxTnBxNXdaRmJxNjcxU0hTSWNTK3VqTGJJV0swdFRJRWM3dHFQTzNz?=
 =?utf-8?B?Y0hyemNEVGtYRXFDM2ZPUURDUXF2L2NuanYvMWlZcmVVd0ViblNxMW50N3A3?=
 =?utf-8?B?V2NpazJjdVpib1dDNnd2SURtVHRiV01NdDBoeXZYSDYyUWt0RHhPNEw2bjRL?=
 =?utf-8?B?T2xDdHUrYUpTL244MTMvVDNJODFxOUFCVTJHamV1V0E0SFRWK1ZKTTJvYTJ6?=
 =?utf-8?B?dFpyNHVydk0wckFPdGFSVkkzRC9lN2l6elFESWt3QlFCbUM4eHpYTmtJUkxh?=
 =?utf-8?B?Y1ZoeVJzTWJXVWxkazcyWGhjSnZtSk9UTzhFOU04dDdUZFVaMW1zYjVZVkVB?=
 =?utf-8?B?S2ZGY2ZFUXZ6T3FZQUVpdHZ2blJQRmlSbFliNFRONG0zOG9ZMmltNHl4Sksw?=
 =?utf-8?B?VlJmR2J2OUh4YTNvbyt4VW9WNnpWZ0ZKVmRwOEdYSUNCVWlLa1lZZjU4dE51?=
 =?utf-8?B?WHBiY0hnaVFEa3lOaXN3eDJrMGFqL2ZMS21HdGg0OEtxcWErMVBTQzhabGJz?=
 =?utf-8?B?Ykt0cFBFcXhlV0pXL2VIek9JRnZkZHBEYjlhb2Q1TGd2a0pSTTVPcmIyTlp0?=
 =?utf-8?B?SXFORzBLcVVTckxCbmRVazlNUDFvQUdseXl3ZVIyR2dwZzV5TXlzNkZncEN3?=
 =?utf-8?B?QmRvVzJVMThvN2xFRWFObzcyNmRZWFdBNjRTWHlKTWpKditERHlnYkdwMURh?=
 =?utf-8?B?R0I4bHd2K3NqSi9xeFcwZm9NaXBYc2xSSGJWR3FlZGFuZjQ5eVRHamQ5M3FG?=
 =?utf-8?B?ZXpsWEV1NTl6NjExNjRaOUo5bTM4aWwvakhuOE5IbEtFVjNHYVkybWVzcGJt?=
 =?utf-8?B?UVNRVlg1cFVKNmhiS0xtRXRHT2c4c1FoaFhiSXF3ekdab0JaRXZzMUNQZDFB?=
 =?utf-8?B?QzN6QmV5R3pNRFV0VSsvRG9qZW0rM0dudWhBTHZKMUtQU1paQjFhRTVEKzVv?=
 =?utf-8?B?djdnRjFSbTAranVTdElUemo5SjkzWCtTSk02NjNvNmt4NGs1ZW9xSnZweWs1?=
 =?utf-8?B?UUpnM01hSmhXa0VzODNFMmo3dXVQSmcveEd6Q2FXYjJGbFBialJhMU0yaENL?=
 =?utf-8?B?TGFyUUgvNHBnY2g0S1A0ZU5qVEp2WlpvakorOHdlU3VpRnNaSVpWd3ZtS3hj?=
 =?utf-8?B?S0x1Tnh5d1lOVXFYMEkwVEsrRVYvVWFCUWdPeWlLL3ZBd2RNWGs2dDlseEtO?=
 =?utf-8?B?eFZ6M0h1NU9HK25oaGpjclBpRXkyUW1MZ3VUYXRtblhlYTNWMFU1ZzFRMW5Y?=
 =?utf-8?B?RHlBK3dXSkhQQmxqeXFFRkVvdkNrUUhkVDIrVkxsbnBQTkFMUnZPMW5xKzdU?=
 =?utf-8?B?eWxlLzBGWk5BQnpYZmJsb0pDRFcwTFoxa0htRmJLS0pUdWxCYlFkZDhSZnFx?=
 =?utf-8?B?RkVWTEE3M1J3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck0vL3hiTS93N0RVZTAxb2c4RVA5UGZmRVNjejhpZklBaENacS9JRGtqRERl?=
 =?utf-8?B?eEJ1TEthSk1xNTFHVTYyTXNZaXFEQWV0bnllVGRLTlk1Q1BRSU1Fb1lyV0NC?=
 =?utf-8?B?dFloNEV2UXRvbm5ScHlyUCtXRTBRWG1UTE1QbDhtZmJMWDZQSlk4NllOcVdJ?=
 =?utf-8?B?SDFNU2hQOHlQWms0YVhGSkNCdDZDaURFT0xGd3JrWUlnMW80VzREYWxSTi9C?=
 =?utf-8?B?OENYelMvVUhaVXpldFYwcmJpWXBRbkcvUEZBZ1Axd1Z0aUJjaEVlUEJReWZy?=
 =?utf-8?B?T3duRnA0eEtuS2xLaWFsUUFFK0ZBbldEQ2dQVWJkR0g0VFZpSjJSY21lRnB4?=
 =?utf-8?B?QkFEckhveTc4LzAwZi9aUXhHTWkzbmFwekpBN1l0TWVmcnZwK3BSckdzVm55?=
 =?utf-8?B?K1RPNTdtcUZjNWFlYkZqM2JNQXYrOENKVXJQTnduVFVpL2EvUVdxTmN6RC9m?=
 =?utf-8?B?emNObjViVDN3Q2ZQODM0ZE0wbFo5WnFvcWRabDBsLzNMSnNrOGxXV2ZPUXdm?=
 =?utf-8?B?VmlyRi9uRlJ4eS82ejZSTFVNUllZeXZrc1pjZ0xRbXRsVUtUenE3YVprd0o1?=
 =?utf-8?B?dDhjUkdVckZpWmVUUGErRTFuRjBCZ2ZzWGNIYWdKRm0xM2lYc2hkWE41SFha?=
 =?utf-8?B?TVI4REpOMDFiNUx3T3Z5UXVjaVNYWmYxcmUzSWVPRC9WelE2UlhtclBGeG9I?=
 =?utf-8?B?QlBrVFVHc3dFWFJZOS9INnV1Z3hVOG5UYm91ejA3VDdud1RWYkEvUGgzWE9O?=
 =?utf-8?B?WWk1WElDNDVRa2pJUTJXUUJpdmcyZFBRNlpXZm44VHljaTRLaGRkaVJBZ1Uw?=
 =?utf-8?B?OHp1cFZsbmN2d1hZL3BQRUpWOStnTGEvVzZJVktCcHYySTZlaHh5SjN6YXM0?=
 =?utf-8?B?QzVpUERvb2VCKzg3RlZndU5HUzRNdnIrMlI5M3hINmkrT2NOUTJDeHFQaGZL?=
 =?utf-8?B?ZjNTYnhLTVNFMkc5NDV5azB0dWFvZnlDNUVoRTgvOGNCaWlyTy9TaGNIUlVW?=
 =?utf-8?B?UURSSGpGY1lxWDNOTi80S3NaK0l0MUV3VTNTaG5zZC9yYnNwZ2U0TldTUGpm?=
 =?utf-8?B?dENpeVNlZXl2QVJKbkkrYkZML0djdWlRZWtRL2g0WmtCNkxIdndEYXcwRnp5?=
 =?utf-8?B?ZGd0R2FZcUd5OFJ3QWhKRFE0WVZsNERkeDlNeHJlZk1seXYwQWJ6bXVuNy9h?=
 =?utf-8?B?NXVrV25URlQ0QzZ5NHlrNzNDVG9iMDcyZ1o0eVU2c25iMENabFd4a3BXNzFT?=
 =?utf-8?B?eVphaVkrckdoT1hqV3FhOWxxRVZTRnVVRmJtUitQY2NaS3hvNWRNVUpKNGVk?=
 =?utf-8?B?cFhQbWpSRHBOVlJHYjZ4T21tdWtldCt5ZGFibzNzVUZJaWFtQzU5a29CQUZh?=
 =?utf-8?B?UTdQZllZcDNFUC8wZFd0bE5NTVlaSWptZlRyODViRlNZekNJckZSbCtFS2Q0?=
 =?utf-8?B?WUFqYnBUVDV0YTZJM1lxZ3Y5NDBHdS9RUkpURGI3SGlQTS9qMUxDaERENWE2?=
 =?utf-8?B?SUZ4ems2RFpjVjBKTzBkZ1NjRjc2eHlhcWZMOFRtdENKUGM2TUFXUHFqK2xF?=
 =?utf-8?B?cFQxYVpTeUJ1ZlZkaDlrU0ZRY3F3aHVISEZ0TVoxQlYxQ0p4aTlqWlp1NWZT?=
 =?utf-8?B?ejI1SStCL2Q1RjJsbXNFcGVnSVVMNG1EUFBsSDBQMjBlYmU3ZVRCZGNCcFky?=
 =?utf-8?B?d3FpTFQrVlJ5ajhMV0ZVVVFoTmJDVHlhcWkxcGJPdEx4bkYrRHVpUG4yc2pC?=
 =?utf-8?B?RzFFajJTNWd0bVd2ZjZDTlJxL1d6T3o3UGZINXVuVm9JVkF6QStCc2RCQnVZ?=
 =?utf-8?B?dS8vQ2t5WXMxY1I2L1k2a3kzTVJrQXZDRG1hbTlQUnhhQXViNHdyNTB2bVhj?=
 =?utf-8?B?azFzVUlJTFpGTldnVGs4VHBTOUlJQmRTc3k2MlpqTlZxdktTdTEzcXUzSDlZ?=
 =?utf-8?B?S1YyRlRwM3BwMTdaUHlmZzNzd1g3OUd6OG0vQ01FUThES2o1bU5qTEpHVzQ1?=
 =?utf-8?B?bDhNT2gwQTNCVWhzbEcxZ0tNSUlWQlJ5K2QvaUVGeGNMbURtOEQ3dG5tdWRy?=
 =?utf-8?B?ajBNajg2OFFqVytESXZNazlVSTZYcnA2Kzg4bWZRb1pZMytRS3AzbkQwT3V2?=
 =?utf-8?Q?2r2E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095729fc-651d-4ab5-925b-08dd70f395e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 08:02:45.0196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s177hOBhY5iIgLry+39D5mryivNAkLAXmezzJgQRzubx2/ZtOGqiRm1veYgSQjJonn0S1BUXVCXwYJq2nvLRvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7609
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIgyMuaXpSA4OjM4DQo+IOaUtuS7
tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBUb20gUmluaQ0K
PiA8dHJpbmlAa29uc3Vsa28uY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsg
U2VhbiBBbmRlcnNvbg0KPiA8c2VhbmdhMkBnbWFpbC5jb20+OyBTaW1vbiBHbGFzcyA8c2pnQGNo
cm9taXVtLm9yZz47IFN0ZWZhbm8gQmFiaWMNCj4gPHNiYWJpY0BkZW54LmRlPjsgRmFiaW8gRXN0
ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgZGwtdWJvb3QtaW14DQo+IDx1Ym9vdC1pbXhAbnhw
LmNvbT47IEFscGVyIE5lYmkgWWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNvbT47IEFsaWNl
DQo+IEd1byA8YWxpY2UuZ3VvQG54cC5jb20+OyBMb3RoYXIgV2HDn21hbm4gPExXQEtBUk8tZWxl
Y3Ryb25pY3MuZGU+DQo+IOaKhOmAgTogdS1ib290QGxpc3RzLmRlbnguZGU7IFZpb3JlbCBTdW1h
biA8dmlvcmVsLnN1bWFuQG54cC5jb20+OyBZZSBMaQ0KPiA8eWUubGlAbnhwLmNvbT4NCj4g5Li7
6aKYOiBSZTogW1BBVENIIHY4IDAxLzE5XSBmaXJtd2FyZTogc2NtaTogc210OiBJbnRlcnJ1cHQg
Y29tbXVuaWNhdGlvbg0KPiBlbmFibGUNCj4gDQo+IE9uIDMvMjEvMjUgODoxNSBBTSwgQWxpY2Ug
R3VvIChPU1MpIHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiA+IEBAIC00OCw2ICs1OCw5IEBAIGlu
dCBzY21pX2R0X2dldF9zbXRfYnVmZmVyKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHN0cnVjdA0KPiBz
Y21pX3NtdCAqc210KQ0KPiA+ICAgCWlmICghc210LT5idWYpDQo+ID4gICAJCXJldHVybiAtRU5P
TUVNOw0KPiA+DQo+ID4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfU0NNSV9UUkFOU1BPUlRfU01U
X0lOVFIpKQ0KPiA+ICsJCXNjbWlfc210X2VuYWJsZV9pbnRyKHNtdCwgdHJ1ZSk7DQo+IENhbiB3
ZSBzb21laG93IGZpZ3VyZSBvdXQgd2hldGhlciB0aGlzIGludGVycnVwdCBuZWVkcyB0byBiZSBl
bmFibGVkIHB1cmVseQ0KPiBmcm9tIFUtQm9vdCBjb250cm9sIERUID8gRm9yIGV4YW1wbGUsIGNo
ZWNrIERUIC9maXJtd2FyZS9zY21pIG5vZGUgZm9yDQo+IGNvbXBhdGlibGUgPT0gImFybSxzY21p
IiAob3IgIT0gImFybSxzY21pLXNtYyIpIGFuZCBwcmVzZW5jZSBvZiAibWJveGVzIg0KPiBwcm9w
ZXJ0eSA/DQoNCkhpIE1hcmVrLA0KDQpJIGhhdmUgY2hhbmdlZCB0byBjaGVjayBEVCBhbmQgc2Vu
dCB0aGlzIHBhdGNoIHNlcGFyYXRlbHkuIFBsZWFzZSByZXZpZXchIGh0dHBzOi8vcGF0Y2h3b3Jr
Lm96bGFicy5vcmcvcHJvamVjdC91Ym9vdC9wYXRjaC8yMDI1MDQwMTA3NTYzNS4zODAyNjQwLTEt
YWxpY2UuZ3VvQG9zcy5ueHAuY29tLw0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
