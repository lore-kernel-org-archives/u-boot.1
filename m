Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ED7ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F11B88D83;
	Mon,  9 Sep 2024 13:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ul/JRCjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE37B88DB7; Mon,  9 Sep 2024 13:37:01 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A09788D1F
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9bhk0U5tkVxMGNmn/e/Lhx8F65VmBoq8f9DoML8nDCxXA0B6ofnfwKZCX+wfNR9ZTvuBQnW3Ezi364kcRjm8E4qmNB49irbOhVs+Vy7Ubl7mLVclsIAIVID+T02eaJ/Q0NMloE5ca+9K507a1jV47Z2iNFKm+mKmpWca1t/tIFHQbOpsTsEDfrgZdKjssesdWYxvRVm2is961C9JAVwIXGGpDybBu8I4I+p+c2+4wrg1qGujD5uR1kk8KPqhzOFz/dybZgvyjIurreWMI9KntuoKLQsrVgReF1pEnfaU/QmpMlYNJoRSGYm15NqMwdZXDgW8kMebbIDhMDbRSwbHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxziSKgWSqLglBfTw0mjFbBfbSCbd6kM9F0WuNuWu7Q=;
 b=MieFB+NyQgJXM+AqIIjEDUvHH4QLOv6SRo8CZY69TnxTCdvaGZm/ZOFrrmaB2gjvLBxA3ESUhufxCPoNfWXM5eg3Jq49Bp1yuwO8g6oVbo7c7tmEZxlGSIayo8gXkNaeAjIxvfwo4mzZWHUZFKXmYm1A0lvZWNUxw4O4/i24v4jTd2HLpZtC/Y9n8XlGkCmDG/Zp0zTt6nozrrgJ6uOhG+jfiSAgpB9fIDVKOKcOshyi3e7mIgnJE4HIm7Zxt/ffevqJOX74G5jdImdsKTSy7gvvi8euMXrrKV6/773Yh8S1g3plp0JDJg4K3AWBurYhENOO4km51Xs3XgmINVYHZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxziSKgWSqLglBfTw0mjFbBfbSCbd6kM9F0WuNuWu7Q=;
 b=Ul/JRCjWDIhsxQZVwzAixqDC22exa/OeUjMh7Ge5rpp8Mgsk5ZH9WKNwXIYvjA+TV3nSNRsnenyClO2WdYAtKcuvH+uqJecbJ+dlCTwpZXQKRYFYNn0Gilhr4mmikPATkBq5dUy9SgWhSymf0Dp5PUiJVSYtcVT5+jgbYbESXqQ=
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 by MW4PR12MB6730.namprd12.prod.outlook.com (2603:10b6:303:1ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Mon, 9 Sep
 2024 11:36:54 +0000
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf]) by SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 11:36:53 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Simek, Michal" <michal.simek@amd.com>, "Abbarapu, Venkatesh"
 <venkatesh.abbarapu@amd.com>, "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 "git@xilinx.com" <git@xilinx.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "n-francis@ti.com" <n-francis@ti.com>,
 "d-gole@ti.com" <d-gole@ti.com>
Subject: RE: [PATCH v2] cmd: sf: prevent overwriting the reserved memory
Thread-Topic: [PATCH v2] cmd: sf: prevent overwriting the reserved memory
Thread-Index: AQHbAp0BAFc+aAjMA0iZGK7wkArwX7JPPfeAgAAT6KA=
Date: Mon, 9 Sep 2024 11:36:53 +0000
Message-ID: <SJ0PR12MB66858FA88251E68D0065AEB182992@SJ0PR12MB6685.namprd12.prod.outlook.com>
References: <20240909094509.1481038-1-prasad.kummari@amd.com>
 <CADg8p96yfYx3GMgqHyS5d+=2cOhjGdk56AgAkMLtHvYat=FkrQ@mail.gmail.com>
In-Reply-To: <CADg8p96yfYx3GMgqHyS5d+=2cOhjGdk56AgAkMLtHvYat=FkrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6685:EE_|MW4PR12MB6730:EE_
x-ms-office365-filtering-correlation-id: a866c675-4f7a-4058-9510-08dcd0c3b426
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M3dkNDFwYncwM0JkVEV3WHBIQXV6Ymp5V0MxUEJvZ3BiWFUvbjFpZ3FxRkdR?=
 =?utf-8?B?dTYzSXVvQWJTZnFjYXIrU0RKWDk4VmRsR09tYlIzejMydDRrTzdESjhMSmZt?=
 =?utf-8?B?bHR3RjgrSjU4SDBoNERCRHBuQ0U3cHBFenp4dU9jTkRxTENHQ0ZmQTFROGlR?=
 =?utf-8?B?WmRFUW1IQitYalZyL0N6czF2MHR1TDd6dnNIT1g4M1c5YVdzS1RBOGlGTk9J?=
 =?utf-8?B?UWpOUThJWDdJWGlHU1AwZ3Fvd0ZEVmNsOXQxQnRFV1RMVXJSdjJ1akFkODJQ?=
 =?utf-8?B?N1EvQVJsek4wNjNTZis5Q3laUmd1Qlp3MEliSEZVdzJCRHN4MDgyc1ptQndC?=
 =?utf-8?B?K1cvekhLMmloVHRkT0dRQXd3dFI3cWIvY2t4aUg1VkY0RkpOd3NIeVRJbGRE?=
 =?utf-8?B?aVdwM1ptQ3BMbEp5VFFOanpxaUZuZEFLTXl0c3k3TytVT01tVlRkTXJ2MnZK?=
 =?utf-8?B?NXgybzVnUXpOL2dRYUtXbW51dWFuMUllNjhXck9xcHBBT1ZGbVpueTZIRkxN?=
 =?utf-8?B?TVVFVC9LNEtoZ3M2aXg4SWRLNWFZcUl5VXIxa1Zkc1lSUW43cTk2L0VlWkMr?=
 =?utf-8?B?dlJyaGhXelZ6S25MYzRPeGJZUXpydDRJL2hna1doMXc3MWRFNzBrdHNkZnhl?=
 =?utf-8?B?UmF3Y2JaMkJTWFVFTmlhZ3pyaGRVUXZUdmR5MU56NEMwblRaWGMvSEFHL2FZ?=
 =?utf-8?B?eGNZSU5yOEtwMGlJMjFPbzVFOWxUa3dYWmVrQlo2UklIZ2xoVWFrUSt4TXp6?=
 =?utf-8?B?YTBPUEpzMytMbDIvWXo5c2RDaGpzMU96aE9yeVRMeEhkeTBlNG9HWURlTVFY?=
 =?utf-8?B?alVGSlFEeWJjekRUdW9Bd0NoTmE4UjFFa3lJY09TVXFFYXMraktLZEQ0QS9J?=
 =?utf-8?B?K0paaklXSTEwd0dsUi94VmUyWWYyczBrSWxwWFdHU0VvbS9YYVVwSjV6Rnpy?=
 =?utf-8?B?bGlmRXE2YmtCZ0M1SGdmaVg4MzNOMmlqRGVkTUdGQWtZWjd0cklmMWxmb1h4?=
 =?utf-8?B?clJWaTR5cVQzTzZUMk9OUy81TkJsNk05dkJVVmFnMGlmb0Z1TnQ1c1BsbE9W?=
 =?utf-8?B?MnduYkVBQ2ZuWW5tZFJoaU5FaGpkcUMvMHNZN2tCRHphSHBwSDYvSzFaTlJk?=
 =?utf-8?B?OXdSOWExRUloK1FxSW0rYzdsMkwzYXBmeHlyRWpwZW13a3pmVXJrK2VVdzUy?=
 =?utf-8?B?R0NKV21Hb1lVVGdVQTBPOWtNeGYxUENkMU5sclFlbjlRQnZXSng5MHliNmZX?=
 =?utf-8?B?LzJwMjJXNjJNeXVkTjdzSVVUdEljYk1BRkNsTkdqbTRwTFBubGEySkdKL0tk?=
 =?utf-8?B?NHc3L0tIMS9kQktDNHg4Y2RXcWtwRzVaL1oxOVNSME1TU2RCTWZaaHBIOEVm?=
 =?utf-8?B?dkh2SFBTSXJQNm1VNjc1T1Boc2JxNDZTV2dpeWszNDI1SzVEb3hpa3U0bzdW?=
 =?utf-8?B?bjBUWVYxYlNMci9oV2RXaTJyQVV1amFUcXBXdTZORUx1VTNJaERtMzB3V1E1?=
 =?utf-8?B?MXp5L1hzK2RCSjdPRDkxd0JldGw0K0VnbjFneE9Sa1RaZGtSU085RENFd0hO?=
 =?utf-8?B?dmpHSG5RdmxabGJwL2NQaWdIWXhTY0V4WEVFUzk2a0M1VzJneVBnV1ZyZkpl?=
 =?utf-8?B?cWs1S2lSTkpmTUZzNlRNd2RZQ2FiSkpXSm5BUG5rWVk5ckRkdlI1dU4vOXV0?=
 =?utf-8?B?YXhuRWZSUk5BRGI0c1dlWXMrU1l5Zy9QUDV1dEdybnNvSHhnZHVEdmsxUFRF?=
 =?utf-8?B?N1VYemZVTWVGeHRiNlA1M2t2T05mZHgxSThEZ2haNnpCa1kra2ROcWJkVzVV?=
 =?utf-8?B?NTh5QjROdGU4cjN3QlF6VjNxOHhwRVZLbkhsNFRZN3RPbHZCaS9tdXJMMkVJ?=
 =?utf-8?B?ZkcxcTNxWDBYcEZ0SFl3RlN0TjliMVA3RWJOUnhNNUpXV2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEFGU0xGOWxaMDIyWm1waDE1TnlUc04vMEtKMXBxbUxDT2dqb0JPZDRHQnFv?=
 =?utf-8?B?ZEZCSlVMcE51TyswN3FEREU3emxaeC9RYmFFVGVHUEhINEdtRFY2MWYwa0dl?=
 =?utf-8?B?dVZlREdrd21Ga0hoRytSTklrSkUyWWg3dlBBU2pmeWo4R0VQemt4bCtkOUZt?=
 =?utf-8?B?YndnMDlWcFFiQXdSOHRKOG01L0YyaXpQeWo0VnNyVW9UZDRya2xIRFpyWFVn?=
 =?utf-8?B?N21IV2toa1lFdE45UkN1c2pyMjVCbDEyRXZwZzNJQ1N5NlBsRWZjTDlhbEpl?=
 =?utf-8?B?bk5DTXlodWV5VEJIOStYSVdKT1RsOGFkaXpsNHhpTkFzeU9xNXRnZ0Uvd1pK?=
 =?utf-8?B?K3ZyS3A3Y2M4UjNib2Fha2QrbEt1YmNWU2drRG5ZdFJZTmNBKzFaYkl4OVBF?=
 =?utf-8?B?eGhSTFY4Q21TT1ZDdlZic1dIMVZWTWZsOHRRekdMU0dNOTZzQjE5TTRZY2Ji?=
 =?utf-8?B?UXZ5ZjUrMEEwWXEwQy8rdC9mb1Y5VTVuZmVEZkQ4aGhQZ015Mzg4eHpSQjc3?=
 =?utf-8?B?MkNCa3IzN0hWcnRNamh1TjV0cVRNUkhsVlpDVkdpVVFzVmFxR044cjBJeGFI?=
 =?utf-8?B?ak5XNG45WFcxY3oxL0g3Vi9qeERXYVMwMmZHQ3ZzNDY4MDJ2MU50WmZPaVBF?=
 =?utf-8?B?YnlmdGJnaFFCdEt4WGIwcnROYUJWVG9OL3FydUd3UXAyNFNIdTVMWXIwR0Vz?=
 =?utf-8?B?SGUxWWtPRUt2dmkyNXpva2JmWWVvTEwwTDVhTTlCek13YXR4WjNrUzdTTnJT?=
 =?utf-8?B?TnYrRDlyWHV2MlNNczFNMWpqM01Dd3gzeDZ2YTZlbmdOYnpjN2luL1YvUnY2?=
 =?utf-8?B?REp0S0RDWFdqdkdTcmdOUHpXanVDN0VmUU1qNk1BcDkvLzEra3lxWWNtbTUy?=
 =?utf-8?B?eTNvR0VkOHlXTDNzc3VXT2tQb3ZNREVKWlJPREE2TVhhdWN4VFVvWWRVN2x2?=
 =?utf-8?B?S3kySGlKRDJTc3pvOWtaZkFvRmcwTjI4ZW54c2luVG9GV0tIMGw3VlJFd0xG?=
 =?utf-8?B?Z00wQitLTUllYVZMSHN3OFVsS21VZzc4RzdpUmlSTkFHWVBXNm9KUWZNaFRk?=
 =?utf-8?B?N2NseTFEcCs1MzVBZHJ3S2VXNnBuNUM0VVdiOEpIZ0gzd0xDdVZGYWpBc2JL?=
 =?utf-8?B?SmVmVldGc0FzdEVLWlp1a0htR3hmbkwwZXJQLzhOSUxPRE1oYjh0UUlKY3Ux?=
 =?utf-8?B?Y0plcllRUkN0S25YZ0VoSitYQkV6QzFKQ3ZNMjZmVlIvdXBlN1ZFNTRxQkE2?=
 =?utf-8?B?SDVhaGl4Y003aVlqR2VkanNlY01ib3ROTVBLS0lEaFp2UjZiKzFpMXFtd09n?=
 =?utf-8?B?OUlUeVdDWGVHU0l4dUdyV1JzZFptLzJSWnM3UHNXN1FHcGJhc0M5TWtFUzQz?=
 =?utf-8?B?RVpuUUord3VpOGQzTE1rVFVHQU9BeDhURUJEVEVHaXNiM0xDaCtqL3dPS2xE?=
 =?utf-8?B?TTlqYUFCWEdnRFcxR2ZRRVNSS1psSVRIa1haZHgxR1FVZzFoNFFEcWlCSWR0?=
 =?utf-8?B?YTdpZzYwSnV2WFZXeDlZUHF2QXFPWXU0Ykg5UEhBaGFkSUxjSVdoWEk3YUpJ?=
 =?utf-8?B?SnJBMjNsSHZJMjA0WHF2eXh5S2JBRjFrZFBDaFBqTVZYK3FwU3ZiSCtkNGtB?=
 =?utf-8?B?aHBoUHdPWHJLd3VZOGh2Wm9SOXpNTWQ4VFoweXNuVG02NXhhTlA3ZzJubXZE?=
 =?utf-8?B?K0Vna0pmWkNXSHo4S05pN3huQWthc0hyZ1ZRZDh1YllUUEF2aUo0NXloWHRo?=
 =?utf-8?B?ZGE0ZUpJZkd5WHR0WUkwbFFBeDd3WVpXenZ3WCtHS0MwTTJYWGpJdHgydGJw?=
 =?utf-8?B?N3dGT2JBWUc5UWpoWHJwYkNLakJRL3BkeXQ1N1QvcTdNNHdCNklNWlY2VUlQ?=
 =?utf-8?B?RUIrZ01ZVXhhZ3I5eFd4a2hQTm1xM3hlSU54YXo2UkxlT2Qxdi9WM1hROW5I?=
 =?utf-8?B?KzlpSEVXWEFHRlZRTlV1SThVS0s5Uk1BTU9COGlXbXN6ZWMwYm9GUXJVNDZp?=
 =?utf-8?B?MTV3NEUveEFXNFY5S29Hck1Gb3BZQkZqNWp1Y0RVaTBFMGZtUU1PSjZiQ3l1?=
 =?utf-8?B?NFJOYVpyUE04N1VXS2JUNGRmVlp0bjhnbEU2cklQc24wWFVWeHhRR25PVlgr?=
 =?utf-8?Q?MIko=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a866c675-4f7a-4058-9510-08dcd0c3b426
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 11:36:53.8971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPLLjWusiuXuEelp3vCU8U/AghGnGsn3iIBgymH3sY5uaGjICkY3YzTXz56Okskn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6730
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

SGkgU3VnaG9zaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdWdo
b3NoIEdhbnUgPHN1Z2hvc2guZ2FudUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIFNlcHRl
bWJlciA5LCAyMDI0IDM6NDggUE0NCj4gVG86IEt1bW1hcmksIFByYXNhZCA8UHJhc2FkLkt1bW1h
cmlAYW1kLmNvbT4NCj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlOyBnaXQgKEFNRC1YaWxpbngp
IDxnaXRAYW1kLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1la0BhbWQuY29tPjsg
QWJiYXJhcHUsIFZlbmthdGVzaA0KPiA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+OyBCZWdh
cmksIFBhZG1hcmFvDQo+IDxQYWRtYXJhby5CZWdhcmlAYW1kLmNvbT47IGdpdEB4aWxpbnguY29t
Ow0KPiBqYWdhbkBhbWFydWxhc29sdXRpb25zLmNvbTsgbi1mcmFuY2lzQHRpLmNvbTsgZC1nb2xl
QHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBjbWQ6IHNmOiBwcmV2ZW50IG92ZXJ3
cml0aW5nIHRoZSByZXNlcnZlZCBtZW1vcnkNCj4gDQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBv
cmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyDQo+IGNhdXRpb24g
d2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4N
Cj4gDQo+IA0KPiBPbiBNb24sIDkgU2VwdCAyMDI0IGF0IDE1OjE1LCBQcmFzYWQgS3VtbWFyaSA8
cHJhc2FkLmt1bW1hcmlAYW1kLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGRlZCBMTUIgQVBJIHRv
IHByZXZlbnQgU0YgY29tbWFuZCBmcm9tIG92ZXJ3cml0aW5nIHJlc2VydmVkIG1lbW9yeQ0KPiA+
IGFyZWFzLiBUaGUgY3VycmVudCBTUEkgY29kZSBkb2VzIG5vdCB1c2UgTE1CIEFQSXMgZm9yIGxv
YWRpbmcgZGF0YQ0KPiA+IGludG8gbWVtb3J5IGFkZHJlc3Nlcy4gVG8gcmVzb2x2ZSB0aGlzLCBM
TUIgQVBJcyB3ZXJlIGFkZGVkIHRvIGNoZWNrDQo+ID4gdGhlIGxvYWQgYWRkcmVzcyBvZiBhbiBT
RiBjb21tYW5kIGFuZCBlbnN1cmUgaXQgZG9lcyBub3Qgb3ZlcndyaXRlDQo+ID4gcmVzZXJ2ZWQg
bWVtb3J5IGFkZHJlc3Nlcy4gU2ltaWxhciBjaGVja3MgYXJlIHVzZWQgaW4gVEZUUCwgc2VyaWFs
DQo+ID4gbG9hZCwgYW5kIGJvb3QgY29kZSB0byBwcmV2ZW50IG92ZXJ3cml0aW5nIHJlc2VydmVk
IG1lbW9yeS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByYXNhZCBLdW1tYXJpIDxwcmFzYWQu
a3VtbWFyaUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+DQo+ID4gQ2hhbmdlcyBpbiBWMjoNCj4gPiAt
IFJlYmFzZWQgdGhlIGNvZGUgY2hhbmdlcyBvbiB0b3Agb2YgdGhlIG5leHQgYnJhbmNoLg0KPiA+
DQo+ID4gVVQ6DQo+ID4gVGVzdGVkIG9uIFZlcnNhbCBORVQgYm9hcmQNCj4gPg0KPiA+IFZlcnNh
bCBORVQ+IHNmIHJlYWQgMHhmMDAwMDAwIDB4MCAweDEwMCBkZXZpY2UgMCBvZmZzZXQgMHgwLCBz
aXplDQo+ID4gMHgxMDANCj4gPiBFUlJPUjogdHJ5aW5nIHRvIG92ZXJ3cml0ZSByZXNlcnZlZCBt
ZW1vcnkuLi4NCj4gPg0KPiA+IFZlcnNhbCBORVQ+IHNmIHJlYWQgMHg3OWVhOTAwMCAweCAweDEw
MCBkZXZpY2UgMCBvZmZzZXQgMHgwLCBzaXplDQo+ID4gMHgxMDANCj4gPiBFUlJPUjogdHJ5aW5n
IHRvIG92ZXJ3cml0ZSByZXNlcnZlZCBtZW1vcnkuLi4NCj4gPg0KPiA+IFZlcnNhbCBORVQ+IHNm
IHdyaXRlIDB4NzllYTkwMDAgMHggMHgxMDAgZGV2aWNlIDAgb2Zmc2V0IDB4MCwgc2l6ZQ0KPiA+
IDB4MTAwDQo+ID4gRVJST1I6IHRyeWluZyB0byBvdmVyd3JpdGUgcmVzZXJ2ZWQgbWVtb3J5Li4u
DQo+ID4NCj4gPiBWZXJzYWwgTkVUPiBzZiB3cml0ZSAweDc5ZWFmMDAwIDB4MjAwMDAgMHgxMDAg
ZGV2aWNlIDAgb2Zmc2V0IDB4MjAwMDAsDQo+ID4gc2l6ZSAweDEwMA0KPiA+IEVSUk9SOiB0cnlp
bmcgdG8gb3ZlcndyaXRlIHJlc2VydmVkIG1lbW9yeS4uLg0KPiA+DQo+ID4NCj4gPiAgY21kL3Nm
LmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2NtZC9zZi5jIGIvY21kL3NmLmMNCj4gPiBpbmRleCBmNDNhMmUwOGIzLi5kMmNl
MWFmOGEwIDEwMDY0NA0KPiA+IC0tLSBhL2NtZC9zZi5jDQo+ID4gKysrIGIvY21kL3NmLmMNCj4g
PiBAQCAtMTAsNiArMTAsNyBAQA0KPiA+ICAjaW5jbHVkZSA8ZGl2NjQuaD4NCj4gPiAgI2luY2x1
ZGUgPGRtLmg+DQo+ID4gICNpbmNsdWRlIDxsb2cuaD4NCj4gPiArI2luY2x1ZGUgPGxtYi5oPg0K
PiA+ICAjaW5jbHVkZSA8bWFsbG9jLmg+DQo+ID4gICNpbmNsdWRlIDxtYXBtZW0uaD4NCj4gPiAg
I2luY2x1ZGUgPHNwaS5oPg0KPiA+IEBAIC0yNzIsNiArMjczLDM1IEBAIHN0YXRpYyBpbnQgc3Bp
X2ZsYXNoX3VwZGF0ZShzdHJ1Y3Qgc3BpX2ZsYXNoICpmbGFzaCwNCj4gdTMyIG9mZnNldCwNCj4g
PiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19MTUIN
Cj4gPiArc3RhdGljIGludCBkb19zcGlfcmVhZF9sbWJfY2hlY2sodWxvbmcgc3RhcnRfYWRkciwg
bG9mZl90IGxlbikgew0KPiA+ICsgICAgICAgc3RydWN0IGxtYiBsbWI7DQo+ID4gKyAgICAgICBw
aHlzX3NpemVfdCBtYXhfc2l6ZTsNCj4gPiArICAgICAgIHVsb25nIGVuZF9hZGRyOw0KPiA+ICsN
Cj4gPiArICAgICAgIGxtYl9pbml0X2FuZF9yZXNlcnZlKCZsbWIsIGdkLT5iZCwgKHZvaWQgKiln
ZC0+ZmR0X2Jsb2IpOw0KPiA+ICsgICAgICAgbG1iX2R1bXBfYWxsKCZsbWIpOw0KPiANCj4gQXJl
IHlvdSBzdXJlIHRoaXMgaGFzIGJlZW4gcmViYXNlZCBhbmQgdGVzdGVkIG9uIHRvcCBvZiB0aGUg
bmV4dCBicmFuY2guDQo+IFRoZSBsbWJfaW5pdF9hbmRfcmVzZXJ2ZSgpIGZ1bmN0aW9uIGhhcyBi
ZWVuIHJlbW92ZWQgYXMgcGFydCBvZiB0aGUgTE1CDQo+IHJld29yayBzZXJpZXMuIEFuZCB0aGUg
b3RoZXIgQVBJJ3MgYXJlIGluY29ycmVjdC4gQWxzbywgcGxlYXNlIGNoZWNrIHRoZQ0KPiBmc19y
ZWFkX2xtYl9jaGVjaygpIGZ1bmN0aW9uIHRvIHNlZSBob3cgdGhpcyBpcyB0byBiZSBpbXBsZW1l
bnRlZC4gVGhlcmUgaXMNCj4gYSBjYWxsIHRvIHRoZSBsbWJfYWxsb2NfYWRkcigpIGZ1bmN0aW9u
IHdoaWNoIHNlZW1zIHRvIGJlIG1pc3NpbmcgaGVyZS4gQW5kDQo+IGxhc3RseSwgaXQgd291bGQg
aGVscCBpZiB3ZSBjYW4gcmVmYWN0b3IgdGhpcyBjb2RlIHNvIHRoYXQgYWxsIG1vZHVsZXMgY2Fu
IHJldXNlDQo+IGl0LiBUaGFua3MuDQoNCltQcmFzYWRdOiAgQXBvbG9naWVzIGZvciB0aGUgaW5j
b3JyZWN0IHBhdGNoIHNlbnQsIEkgbWlzc2VkIHVwZGF0aW5nIHRoZSBMTUIgQVBJcyBpbiB0aGlz
IHZlcnNpb24uIEkgd2lsbCBzZW5kIHYzIHdpdGggdGhlIG5lY2Vzc2FyeSBjaGFuZ2VzIGluY2x1
ZGVkLg0KDQo+IA0KPiAtc3VnaG9zaA0KPiANCj4gPiArDQo+ID4gKyAgICAgICBtYXhfc2l6ZSA9
IGxtYl9nZXRfZnJlZV9zaXplKCZsbWIsIHN0YXJ0X2FkZHIpOw0KPiA+ICsgICAgICAgaWYgKCFt
YXhfc2l6ZSkgew0KPiA+ICsgICAgICAgICAgICAgICBwcmludGYoIkVSUk9SOiB0cnlpbmcgdG8g
b3ZlcndyaXRlIHJlc2VydmVkIG1lbW9yeS4uLlxuIik7DQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiBDTURfUkVUX0ZBSUxVUkU7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAg
ZW5kX2FkZHIgPSBzdGFydF9hZGRyICsgbWF4X3NpemU7DQo+ID4gKyAgICAgICBpZiAoIWVuZF9h
ZGRyKQ0KPiA+ICsgICAgICAgICAgICAgICBlbmRfYWRkciA9IFVMT05HX01BWDsNCj4gPiArDQo+
ID4gKyAgICAgICBpZiAoKHN0YXJ0X2FkZHIgKyBsZW4pID4gZW5kX2FkZHIpIHsNCj4gPiArICAg
ICAgICAgICAgICAgcHJpbnRmKCJFUlJPUjogdHJ5aW5nIHRvIG92ZXJ3cml0ZSByZXNlcnZlZCBt
ZW1vcnkuLi5cbiIpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gQ01EX1JFVF9GQUlMVVJF
Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+
ID4gKyNlbmRpZg0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBkb19zcGlfZmxhc2hfcmVhZF93cml0
ZShpbnQgYXJnYywgY2hhciAqY29uc3QgYXJndltdKSAgew0KPiA+ICAgICAgICAgdW5zaWduZWQg
bG9uZyBhZGRyOw0KPiA+IEBAIC0zMTUsNyArMzQ1LDEzIEBAIHN0YXRpYyBpbnQgZG9fc3BpX2Zs
YXNoX3JlYWRfd3JpdGUoaW50IGFyZ2MsIGNoYXINCj4gKmNvbnN0IGFyZ3ZbXSkNCj4gPiAgICAg
ICAgICAgICAgICAgcmV0ID0gc3BpX2ZsYXNoX3VwZGF0ZShmbGFzaCwgb2Zmc2V0LCBsZW4sIGJ1
Zik7DQo+ID4gICAgICAgICB9IGVsc2UgaWYgKHN0cm5jbXAoYXJndlswXSwgInJlYWQiLCA0KSA9
PSAwIHx8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgc3RybmNtcChhcmd2WzBdLCAid3Jp
dGUiLCA1KSA9PSAwKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGludCByZWFkOw0KPiA+ICsgICAg
ICAgICAgICAgICBpbnQgcmVhZCwgcmV0Ow0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19MTUIN
Cj4gPiArICAgICAgICAgICAgICAgcmV0ID0gZG9fc3BpX3JlYWRfbG1iX2NoZWNrKGFkZHIsIGxl
bik7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gPiArI2VuZGlmDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAg
cmVhZCA9IHN0cm5jbXAoYXJndlswXSwgInJlYWQiLCA0KSA9PSAwOw0KPiA+ICAgICAgICAgICAg
ICAgICBpZiAocmVhZCkNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
