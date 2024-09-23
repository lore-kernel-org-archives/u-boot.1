Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E41BCF9C5B
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 08:31:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A969B881A9;
	Mon, 23 Sep 2024 10:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="J7XTUaHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1EC488CA3; Mon, 23 Sep 2024 10:31:02 +0200 (CEST)
Received: from HK3PR03CU002.outbound.protection.outlook.com
 (mail-eastasiaazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c400::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF988814D
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 10:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kM7wt2tvyOYPvrebaL+Wx5kwK19kmGFfi1+BXfKe42uvPmggLkJ5P5l3blflTN31DOQwEPjcyONpNlxfUBcYjwnIsBi4s99SyFnspj4ic0XdUd3M9WEAZ6Gq3YxF1zawFRjMZPht1O7ZNYP0VipXnzMJZkyzMWlxh2jPxLJ1b9pq3k9pLii7cHTssYZWBS2z5Fe2IDTpgbtpDKREe7fwZrbz1QxZuY5RxiPNkoUvTh02wa/ohYVVaJHT1KyusKgHwETrA+iCRj1xYIE13gz6v7EkZsi26FCqu1C6UIG1/93MSkVb6mzUCxx/L7iD3NKV26a3JvQsPe7YLHwZbdv13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV2lq7TVkXl7+GY5YpTl+aFf/6/yBXWd2paFNchnF7g=;
 b=feYF3ag9BsR/Hkj1Q/0AsG4pYkQ0JeQ50ueG05eSio5s/4usttynghyKniiVd5PgkFcTSW0YKHr+o9+3RXuF+CE/LuBI4JMbOlcEiT71CAAOqAko7acCnS3Q+79FpfU9sHeCs/5T3tl9beFIMEJ+GobTIVm2SmvOR18+egqD2yEmiofDkg0dCxB+U3Z0e3799o/VlbEF+0TUoyqWOdQdQSIxxEelpQHWcj0ny/3wNVNSuuTIx8SmZm+SMLfNFk2jo3zpxH3xfRzv3wOPpQAO2qN7TeZZYIwn6UK/4h47ZutqSpG8JHsZgOwONXE4Km6uqh7DVslLuOumsH15mQXSGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV2lq7TVkXl7+GY5YpTl+aFf/6/yBXWd2paFNchnF7g=;
 b=J7XTUaHrUi31g8oRuh9+ZpIAXn17pysM0jADkv23bTm0SpIL+E7Sdqp047aSp1FfnK2ysQnq0poRB7gUFxl47yHFAH+8vU2LIBhw3QhgD3pUiA45RvcVqeecd9IveHpeT53LvjxWqMcuK0GvGFEgJjLDlNzkJULViGhcv1CVC7yNJ7eC1y0ZrWMHazRHWVQwMQFe8yXF5LXouDoVGvQMqD3+crwXCwSS187SZSMkQn/rJoM2Mbxl9hudWtx2YB7c8/16LNVoioahK4i4INe4h/lkvUj/AknH/M8U18Ed/HInWZOMABNmnpNKDBCzG13PAs4CgOe4XJ9NImkY3qLtOA==
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com (2603:1096:820:f9::5)
 by SEYPR06MB5717.apcprd06.prod.outlook.com (2603:1096:101:bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:30:56 +0000
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27]) by KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27%7]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:30:55 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Simon Glass <sjg@chromium.org>
CC: "trini@konsulko.com" <trini@konsulko.com>, "bob.wolff68@gmail.com"
 <bob.wolff68@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 2/4] lib: ecdsa: Create device tree node automatically
Thread-Topic: [PATCH 2/4] lib: ecdsa: Create device tree node automatically
Thread-Index: AQHa/Pm23LAVW0G+B0ubHeHDXcPaObJg8s4AgAQ42rA=
Date: Mon, 23 Sep 2024 08:30:55 +0000
Message-ID: <KL1PR06MB6652CBB9618DDAB2F1294386916F2@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <20240902053326.3273410-1-chiawei_wang@aspeedtech.com>
 <20240902053326.3273410-3-chiawei_wang@aspeedtech.com>
 <CAFLszThedscRNb8+X2pw0aLAjUQC8iof238GFQTOVVxOqXdhAA@mail.gmail.com>
In-Reply-To: <CAFLszThedscRNb8+X2pw0aLAjUQC8iof238GFQTOVVxOqXdhAA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6652:EE_|SEYPR06MB5717:EE_
x-ms-office365-filtering-correlation-id: 17501bd7-ae08-465e-154e-08dcdbaa0b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RTI4VTdRV3RhYmtxRnBCdTlRNHVlQXB2N3ZGN1pxY0Q1U1c5dlFCeCtsd3NH?=
 =?utf-8?B?S2NJNU5VbkZCTitXeTVDUDJSNFFTUE8veDVUeVduZUE4cUpJdEFkYytpYzZ0?=
 =?utf-8?B?TW9OU200SE5SazA5MGFXUk12UUM3SWN4b3VIWjdBYk5Ec09WYm82dnk3R3No?=
 =?utf-8?B?dVNhSFIxUFhXZDlDcU9BVzFmQnI5MVZlQ3RTNy9LZ0VmZ3FjVTNvZ0RaMG4y?=
 =?utf-8?B?SERoTGRCVmswRHhlYm4xTTc4VFhrTmJvck12ZFRDeTcwZFlUYi9KcG5LMlRq?=
 =?utf-8?B?U21EcTlranFubVE3b2VXU21zOWllZ1ZBUFNGQXJycFFLcUtrVjROTDN2WTR0?=
 =?utf-8?B?L1JoemdsYkZQdDYrVEhEMTlONHRUanVkZmVwcm5xeDZqdm0waHdQd3Z2RmtJ?=
 =?utf-8?B?UUR2dXJ3eVVTRlZZanpnakNJeGRLbEJSeTBkUXF4cmFJMHFEd1dvWElSZUU4?=
 =?utf-8?B?V011ZjRodnh0R0ZiMnUyQWVDOXlmN2p1T3ltajNqN0luVGU4UHNueTViV0pY?=
 =?utf-8?B?VmFDUFBvNVljblFFVzNHNFhBOG5vNFBtK2N1WE93dkl0ZVhPUWZjVy9ReTAz?=
 =?utf-8?B?Wkp0KytELzFuUjFiQ2xUakpYalhCRHcrZkZVeTYwMmg5UitRSU0xemQ0VWMy?=
 =?utf-8?B?NlBFMlAvMlJWd0FJcEY2c2h6RTFzV1VmQ09mYkVnK3RiTzNUS0ExNGdycEY4?=
 =?utf-8?B?YVN3bG5iY0hJUkgrNmFIWFRWajg2bzBXWjU3SVJ2a09YL2dUaVdiL0w3SHBJ?=
 =?utf-8?B?dzhBQTZNc0htbEZOYnByNkRnTUE4Y0p2T1lVR3I5UlAxY1BIRjY0QmREVTFS?=
 =?utf-8?B?UHFtanB4WXJCZ0ZMUUVyT1k1Y1pGWWVGOFR0Nyt3dHRzUU9XRTcxZ1NpVEMx?=
 =?utf-8?B?Y2Nwa1hBNkZ5dUF3elBiWkFsZUdPa0FaN09xSkEzV1E4OEFSb094Zlo0K0Np?=
 =?utf-8?B?cXJjQ2FqMGNWa1lsREpjZ2JDcml3OWJrQWRwTEhTNTNlZnlwSSs1TFdjWUFT?=
 =?utf-8?B?SGJlTm80NEtVTE11b2QrRzAyTmRvME9Uc1ZjKzNGcHZNQVV0TjVndWNRRHRL?=
 =?utf-8?B?U3B3M0pnQm00VzEvemhFL0pLWldoRkRtbVBwWVVyRzJncW1Md0RnSDZPN1B5?=
 =?utf-8?B?VTh0ME56emgvSnZjVEQ5NnhWQmJlY3U3TCtIMWROVW5ZaXpLeDNpdFNaMnRH?=
 =?utf-8?B?YTYxY3ZKODVjOHprU3huVEFwTURHeUlkeDRkdWp3NDBNTHAvVk9td3VoWFVH?=
 =?utf-8?B?OUxOeEo3bFVmTlI0KzExWTc0T25RdXVmeGxBb1lLZnhsS3M1dnNtb245cVpa?=
 =?utf-8?B?QVA0eGpMUEtVK1ZoZ3UvNWVMaDZybytqR05ZTzgrbDVyU0huUkx5S3NmNHda?=
 =?utf-8?B?SnNERzg2bWQvN3FpQXBYMFJ2aHBFNHVqU0FYQ0VjZVc4YnF3MGhRbzVrOUU0?=
 =?utf-8?B?Y2NyNU85TlFUS3V3NWFOK1hZQlNWeDM0NllHY0wzMWduY2o5MUh0R1AzMldj?=
 =?utf-8?B?cWFZRUFJMC83RTFjVDZnbUR5MThVa01uMTlzUkcyZzVtRG1neCtOcUhWTGF1?=
 =?utf-8?B?aWt0eUtZbkxOcTNKLy9TUHlaVGdIVklKV0M3Sm5wZGo3R1k1a2ZMVHp3Vk11?=
 =?utf-8?B?c0w1VFhLN0V2V0JEeFRBYWZKaDNFWERGNmFqbTJoOWJIaW45eHZKTnN5ZjZq?=
 =?utf-8?B?N0tkNXFIWk5tcTBGTUhnczgzWGluWnFsdCs2a0NDS3EvUFVFQ0JPZ0ZjUWNS?=
 =?utf-8?B?cXRVdzRjalc1eTRpdVhyYkhlSndlWXBpazhieHJFaUJGTTVZdkZjTEVGTmtM?=
 =?utf-8?B?dGVYV1R5UUpyT2V6T0VUZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR06MB6652.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW5ob3paS0NOK1p0dk1hbnpRcS96UDRpTUpTSk4ydS9MdGlkVSsrSGtQQU96?=
 =?utf-8?B?WFVLUU9XV1dCNldMRktMRlRUZDIxOHY2Z25zdUhYYkpjRWtiYjcvQjlyUEwr?=
 =?utf-8?B?VFV0VEhsVjdTRWFpQnpxSWxBaHllNXA1dVVnQUFhQ1FZanpjbnRjaklkdEM1?=
 =?utf-8?B?RktwcGZwb3dBb2pXYVV1dU0yckp2M2tGZ0Q3b3VwZ2hzRzNDanU1THdCYVJk?=
 =?utf-8?B?azhjUmY5ejNmU1Q0U2dUQlZHRlpHNVpEdkI5WkJVYk9yOUJMenpnVjA3aWJn?=
 =?utf-8?B?ejBOdmFSUTArclYzMWw1aDBUODlJaUpiaHd6ZTU5ZUpRVksrSE9FZzNRZ2gy?=
 =?utf-8?B?R2hvekxjZXUvOUhCRkZsTW1iN1RPZmFtUERiZ0pxRFlzZ2pqSXNBeUR4eE50?=
 =?utf-8?B?aE1XRmdIY0YyYlFDUjB6Ri9ZZ2p6YVkwOThicUZ6VlRJNE9ncVh4Kzd2MXdU?=
 =?utf-8?B?S1FMWjRTMHZ1L2hiY01jeC83aU1DNFJnM3pzcjQzSW1lODg3TThOWWZVbWx0?=
 =?utf-8?B?RG5tRlJqWlBlMWtnY2VXV3o5bjc5cjgzN1ZiSkgrazFnWlBaSDh5RnBjdlUr?=
 =?utf-8?B?VUx5OXprdTV2RlRueFFEY3ZubUF2aGkxaGlZRGlxYm4yb3E1Q1lXRW9vNmF0?=
 =?utf-8?B?S1Z5Ri9Ya0VNdU90Mm9GK0dHQms4V010R2Y0R0UwZlJ3VHp3TmJwNytsUzV4?=
 =?utf-8?B?QlNjWnFyVVRWOUc4VkFob0o4ZzVReWRMd0VTVnRiL2pwczZTZ3hneTRlaWVB?=
 =?utf-8?B?RmMvMW9pMitJRGVHeUxpdzlRVjFVK3Vya1k5ZTV1Z3pvS2k0NHdyeW9EVVNl?=
 =?utf-8?B?KzBqYkhlbzMxckc3UGFWVnd1MUprYWlIeDgvM0c2VDNzTXJ6RGZ6L3Nnd0lD?=
 =?utf-8?B?SnhaRTVPeXdtRG5zeXREZlFJTWZ5TzF3b2hnaWo3bWZEbTZZZVVaNnZIYUov?=
 =?utf-8?B?MjVuR200dXBJRmVzVWcydEcyUHowRTdXdFVobHZLVWlDZjhUalNrNmhlRXlr?=
 =?utf-8?B?Vm92bkNNQWRNZXdBN24xU202UlFpRzIzcjN2VmNIV0hXbE1QVndmTXdmR1Jo?=
 =?utf-8?B?ZFM0WllLVEpDV0NJUHRZU2ZJL01KZCtzeFJ4T3N5c00xWDlKQWVhSkZmWlBw?=
 =?utf-8?B?RTZYTlJqbTdBRU5VcldtZkx3ekdPbDROTjhnQjZNOWRROXJKZ3h0Tm5wWk90?=
 =?utf-8?B?TTh3M3NGUDBsMWMwdTZ4ekEvVHQ2K01zcWhPZ0hQck10Y2U2d0p4YjZKcGQw?=
 =?utf-8?B?N0Fwbm1na29YVlp5MDB4ZG1YcS9ZQ2s3cWRwaFF5aFYzd0J0clEwRHkrUHZB?=
 =?utf-8?B?c2lka201TzNGZnR3UnJBV1JsdElXR0N0bjJvcktsQ3k0aGZ5ZzZ4NGpkdHJo?=
 =?utf-8?B?TkcyRDNTV2lNSTVrRnZQM3JyL0ppR2N5WU92QW5SdDZJQWZWSlVzL2xUM0E5?=
 =?utf-8?B?M3JQVnU4M1ZsazNmUm04eVpNMXZzTHVsaDZVUzNNaVk0VGpvWmhaZEJvcE5V?=
 =?utf-8?B?VzlNR0FZMDRkTUpVckh3NlJZQkdmRlFYbUlpMFkyRTJJK2lsYnhvdWMyQzF6?=
 =?utf-8?B?OTFMNUY2QW5odlhNZkZVY1FLWFMrRW9PL3pFR09aUkgyVjRkdmczdmUyNHJk?=
 =?utf-8?B?WXRBTXpLNmtrY1dBTVZBVnBEOGtoeThaM0VjVmdFd24zTFI2RGJjeUs0Rklh?=
 =?utf-8?B?S2o0eWFaZlBHQW1xT0RlTHJ2SUtTWVVIQmRqQ2NoRDJqTUpqWEdEYW9LOGpq?=
 =?utf-8?B?TThrOHMrM2NvTjRkckNmdFJRYzA5ZkJlYU0wUmlHazYrSDFWMmVGZDhvRUkv?=
 =?utf-8?B?dUlPTzJxQ0svSWdzeHczaDA0d2lHS3lvRk9WUi93UkZCcGJXdlk4VE0ySk1p?=
 =?utf-8?B?VHN6MHlOQ0x4QmJhWmRyQUFiYnc3YmtMWlE2MVJBdm9XRGdneXU1cmdxZ0Zh?=
 =?utf-8?B?dWhCWDhMVVlGMmF6b3hoTWtNTnlTMzFPNEkveGh4QjBYRzlZWHNoMWcyQW1q?=
 =?utf-8?B?MGdSc1Y3a0E3WjcweHZyMU1QM1RpVURkR3oxbnMySmc1cy9MQTNSQzFHWXhR?=
 =?utf-8?B?NUtQYWdIQUkzei9uOEJ4bUs5UEFiUThNR2liREdta09yeWNQL1MxODNFckJo?=
 =?utf-8?B?M1dkeTJZQ1ZOMjh4aXNIQUtpQnViWnlIN2xqUmxUZVRIZlk5Zm5Lb1ZsNDZo?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6652.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17501bd7-ae08-465e-154e-08dcdbaa0b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 08:30:55.9385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: glnzSCxgIG8R022EA/aVAHtkvvNEmogZr7E63kSdDf9RyYWCphfBGwU/8oTa+SDiCKZw/hiQvYVTRxEttaz7UX3pWkTMZtJDMoiELRi6hNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5717
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

SGkgU2ltb24NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaW1vbiBH
bGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciAyMSwg
MjAyNCAxMjowMiBBTQ0KPiANCj4gT24gTW9uLCAyIFNlcHQgMjAyNCBhdCAwNzozMywgQ2hpYS1X
ZWkgV2FuZw0KPiA8Y2hpYXdlaV93YW5nQGFzcGVlZHRlY2guY29tPiB3cm90ZToNCj4gPg0KPiA+
IEJvdGggdGhlIHNpZ25hdHVyZSBhbmQgdGhlIHB1YmxpYyBrZXkgYXJlIHN0b3JlZCBhcyBEVFMg
bm9kZXMgaW4gdGhlDQo+ID4gRklUIGltYWdlIGFuZCBTUEwvVS1Cb290IERUQnMuDQo+ID4NCj4g
PiBMaWtlIHRoZSBSU0Egc2lnbmluZyAmIHZlcmlmaWNhdGlvbiBkbywgdGhpcyBwYXRjaCBlaXRo
ZXIgY3JlYXRlcyB0aGUNCj4gPiBub2RlcyBvciBvdmVyd2lydGUgdGhlIGNvbnRlbnQgYXV0b21h
dGljYWxseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtV2VpIFdhbmcgPGNoaWF3ZWlf
d2FuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgbGliL2VjZHNhL2VjZHNhLWxpYmNy
eXB0by5jIHwgMjUgKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEv
bGliL2VjZHNhL2VjZHNhLWxpYmNyeXB0by5jIGIvbGliL2VjZHNhL2VjZHNhLWxpYmNyeXB0by5j
DQo+ID4gaW5kZXggNWZhOWJlMTBiNGIuLmNkMGMwOWNhNmU0IDEwMDY0NA0KPiA+IC0tLSBhL2xp
Yi9lY2RzYS9lY2RzYS1saWJjcnlwdG8uYw0KPiA+ICsrKyBiL2xpYi9lY2RzYS9lY2RzYS1saWJj
cnlwdG8uYw0KPiA+IEBAIC0yODEsMTUgKzI4MSwyNiBAQCBzdGF0aWMgaW50IGRvX2FkZChzdHJ1
Y3Qgc2lnbmVyICpjdHgsIHZvaWQgKmZkdCwNCj4gY29uc3QgY2hhciAqa2V5X25vZGVfbmFtZSkN
Cj4gPiAgICAgICAgIEJJR05VTSAqeCwgKnk7DQo+ID4NCj4gPiAgICAgICAgIHNpZ25hdHVyZV9u
b2RlID0gZmR0X3N1Ym5vZGVfb2Zmc2V0KGZkdCwgMCwgRklUX1NJR19OT0RFTkFNRSk7DQo+ID4g
LSAgICAgICBpZiAoc2lnbmF0dXJlX25vZGUgPCAwKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGZw
cmludGYoc3RkZXJyLCAiQ291bGQgbm90IGZpbmQgJ3NpZ25hdHVyZSBub2RlOiAlc1xuIiwNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBmZHRfc3RyZXJyb3Ioc2lnbmF0dXJlX25vZGUpKTsN
Cj4gPiAtICAgICAgICAgICAgICAgcmV0dXJuIHNpZ25hdHVyZV9ub2RlOw0KPiA+ICsgICAgICAg
aWYgKHNpZ25hdHVyZV9ub2RlID09IC1GRFRfRVJSX05PVEZPVU5EKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIHNpZ25hdHVyZV9ub2RlID0gZmR0X2FkZF9zdWJub2RlKGZkdCwgMCwNCj4gRklUX1NJ
R19OT0RFTkFNRSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChzaWduYXR1cmVfbm9kZSA8IDAp
IHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIkNvdWxkIG5v
dCBmaW5kICdzaWduYXR1cmUNCj4gPiArIG5vZGU6ICVzXG4iLA0KPiANCj4gcy9maW5kL2FkZC8g
Pw0KDQpXaWxsIGZpeCB0aGUgdHlwbyBhcyBzdWdnZXN0ZWQuDQoNClJlZ2FyZHMsDQpDaGlhd2Vp
DQo=
