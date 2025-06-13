Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF22C71135
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 04:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324F9828A2;
	Fri, 13 Jun 2025 06:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="DX5y7U6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5313782B0F; Fri, 13 Jun 2025 03:45:37 +0200 (CEST)
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40d::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F0D828A2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 03:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zone.Niuzh@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQ4hzVzRTa+Fts9v44RUgHvTnY+bpoCeWM0fwnsQl3ELE7PM6S7d0dcVMgAKhR+v6jf/j0ZiQODtk3aCL/gSE43u8loDavBOxhca2NBJQ9lgvKB9fIMmoGIh9CEa9RVParS8A+F6+ihIx5J/Y7etE4vZEJlBOIteW2jeHNr500Xn6xkLKYq1v+ShRUWJTFPY++npme9KH2VAQ9vHAFojngdfaq15i/qVoAA8NWYFjSMy3k3TeCPowTImqPipcI3hyIdiVlEwb5XqfU/lMnqdFxS0JU+X70scvRKM4bgpsMZO1QLaftziDWrWSdI8/Q8Yt2U8MjET8E3R7+KFMw1cvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTnMGOqMamivsH2kKNPcuiDTqYHl1y1LV8A1DcIZS+g=;
 b=bMRzOx6l4RC+ZsOs41f9rTeN9cL3xHIncE9AuJ/ZICVGg3G3YxBbK8+Ie2rgVVJf7TIYKxRRr8iBHrFjtNETSsFdKVaHFmlgCmy6dhFBVQROmh3/ipdhW6iyDQ1R7atWkq9E3Shy/FE6CGkoK+YqyjG2mReMFCH7dmWqYK8TgikfIXahY80630ZRqSOkkIdYvpBogXDrzKp9wwnMTrAq3YcdfX/Kloufd2L+z82N0Xwhnm+kRLNA/U+tfimp5fybnm6yQz4SNgg0LONbykFRtbM/jaGB0HKSTiyovdjQjIsQsXK2cUXYy+7bY4eq9SdR7aIwMn49Z8l6VhYxRdOzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTnMGOqMamivsH2kKNPcuiDTqYHl1y1LV8A1DcIZS+g=;
 b=DX5y7U6Ca92MfLkK3mCFvBxVynxvKhJqobfVHYPewOoWuySFzdly7ekk9SeYk22eCip774ckD/LV6FSQ3rD77ZyT+RA20WIO/DTRtJGokPfUww+A+xp3ITY2IiWdnZ/ZSvQKpIXG4q4v1HDQ2NpAFSVxWpwaOvwyqFHmA0E0rhp+Mqhj2t/LVt5Q2I4adRCMeTZNzAUw4b8CO9NkuZedgqEoGUcqxFZqE+bDxvQmqDtl8DN0mTdlhN3YpGoE2bZY2+jVQbkbaQVH2vq69fRAlWOxQZLTSzgkOHHTvNWk+HvaEUGMedrD1sJYgE9F+HmuVdhXWLTsDHWQQpsHGbV4fw==
Received: from SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2d2::13)
 by SYYP282MB1038.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:bc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.25; Fri, 13 Jun 2025 01:45:29 +0000
Received: from SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM
 ([fe80::12f7:70dd:49c9:6697]) by SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM
 ([fe80::12f7:70dd:49c9:6697%7]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 01:45:28 +0000
From: =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>
Subject: [PATCH, v2] bootm: Pass SMP core ID and DTB address for ELF-formatted
 kernels
Thread-Topic: [PATCH, v2] bootm: Pass SMP core ID and DTB address for
 ELF-formatted kernels
Thread-Index: AQHb3ASKtfjV+9sfn0yAaRFEvLXUSw==
Date: Fri, 13 Jun 2025 01:45:28 +0000
Message-ID: <SY7P282MB5675687EA430C83D458678F89F77A@SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY7P282MB5675:EE_|SYYP282MB1038:EE_
x-ms-office365-filtering-correlation-id: e72b1508-d7c3-488f-7bc0-08ddaa1bf9ce
x-ms-exchange-slblob-mailprops: vuaKsetfIZlxXGD4rgFMDi8JK+6YKJp37oEtM3xGHuiSmF4UuVu4xaXhBfSmhJ34DPIFaoI7YKZsg53kCv9D6RhJslO52A3BigUiuBWzVi6/QtfRenICX+8MwJAWNc/czRD0J5q8BMbLnADXh+7xqmd3du0+3hZQ7u0dvFt3tUfnbhL/jdCO4ePJxagrOJRdB0I2JRO7AvaSnOwjAmmjLHSCSEvMLxXTdBNxgy/4VnLkVoEPuE3+km3XOBNTWDWKda3WOtyiqVWnX6tsW/sGVTdl2476ZAvjFL+CG0+YS+wCj+eeCz3l+QPG4bbm0vrB5OnsA6OmjXKByt4+2qbaVWVgm2tYBjZrw8Uzo/nx8FBvnTrATdkBHH1FCy/edV+nyJQb+7o6LOgOjNBwWu9I4cmGKPtJ2iF7KuFjpPo2QY/mlm9V0sxmZsjSVyqSjyHGGQPTVYZUNI2IaKyoG1NwwBkeEFCPAwOoQ1jw53swXvn9ZGzZ745locWIC+5/WJCzEKElE8t79xOdOIbBbGuoHnr3lwZHbwK+74vShy837xT1mUF39Gc80gaklT6nZgA7P5h/O0+UMOrHmrO2logNLl3HlQKUKq8Vo3k+q5UWjNTGJaVjLjfhL5iPQoyS92gd8Xa9ulZWhxzd2X4P+MlG05moj8vjpPXOHZOducLqbDH1bowX1M59uW7Ufb2VN5/DYqOoB1NQDoSJ51P8xI8TlQyGxsiM9DJwSpAyrdRRPS512jsUxwB/JdsF7hPxN8kRoIoAmKHB/bjisUcAR7K+ehAqMWTZOqT7gG9TS7UR12B+vYSEitx6KvrzRYBD08zz
x-microsoft-antispam: BCL:0;
 ARA:14566002|5062599005|9400799033|461199028|8062599006|8060799009|15080799009|19110799006|7092599006|12050799012|41001999006|15030799003|13041999003|19061999003|4302099013|3412199025|440099028|40105399003|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info: =?utf-8?B?S1FTbVB0emlyMzU5ckdXZm9kUkduK2xmclB4YmVwQ0pYQXQwMlMwUEJQcGdS?=
 =?utf-8?B?NjlFTkUvM0lEYjB3S1Y0dzNwNXIrZ1VIbUFnbUN5RnJSWnZEN3dRRWtBQ1NI?=
 =?utf-8?B?REJoMjU2d3Q2NnJjL3pRdFZ0TmNzV3JVMU1YNDVSNnk5aVQ0T2ZYd3M0ZHBv?=
 =?utf-8?B?cjRqaWgwSGp3VzYrSDhVcWFoTjR0dCswcFdLZmozYWxjUFJGUU1BV0p1OGd1?=
 =?utf-8?B?VVppV29DN2ppZ2JLMkh5clZsK205YWE1TGptbW9UbDVwZEM4RHg0RDlMYjZv?=
 =?utf-8?B?L0xPR1ZpQ3dVRGg2YUJaM3VTd1pzMGxXZ0Rsb0Y5QzBPUWhxZmMrU2Z2UURQ?=
 =?utf-8?B?c2xHeFR2a0dqQ2NneWFPK2hDWDBUY0ZiRmxkVzRNdnpYU1RFb1VBN0t5ejY4?=
 =?utf-8?B?SEpIL2h1Mm5IUjZBV0ttejNaZHZ1eTZDdzB6YlBMQ2k5NjhDOUFIaWRLSXZB?=
 =?utf-8?B?eW9kc0hqNlIzZ2hHNCttZnVlZCtrTHkveDVOTWZsS0l3aXNkSXRDd2d6OEpk?=
 =?utf-8?B?OG50UHlSTjRndEFBTU5qN0tOdjlQNmJqeGhZSmtFZzhNM0Y2cVBCMUxLNjZv?=
 =?utf-8?B?UFRYUUhXSjhjNHVORmUraFJkWTJEVmY0SDRKVDVYaGJ1RWwyait1UFRqL2RM?=
 =?utf-8?B?Ym5Lc0VtYmU0eDNLOWJHWWk4Q21PSW9iN08yNmhZM1Q5bDdtRXArVWJDcUlo?=
 =?utf-8?B?YzJnZXhPd2lZZ2ZoMWdaRTVLYThCb00yQWdkUDRXenovN3RxVGJhZXhsQnlY?=
 =?utf-8?B?a0ZwK0NlK2J1dU9mYVdVRlhxbUowdzcxR1c0allYR2hBcEl5a1JwV3hpdjA4?=
 =?utf-8?B?TC9ETmVTQXZ2bVNiLzBqYjRCSGRFUkN5dWZKRzgvNXROWnRnZ2lpSnVsN21z?=
 =?utf-8?B?NFIvcGI0N0w1WFB4UUcwTzJzRGpzMUFhcTBUOUlXaVhObWs4WStiZk56WER0?=
 =?utf-8?B?ZG14a0Q4bm1zWDEyY2xHTHk2aW5XRGpHYmRHeFBuMURaNlhLNStoUWxtYUlY?=
 =?utf-8?B?WStEYnhjSEVFTzgvQWNnbm9Bc3AxWUhhOGVseUpVYms4OWRPSVVrSXhtVEJJ?=
 =?utf-8?B?UldwSEdFV0lmMDRkdUcyN0JXWDBkU3B3RElvdUtDNzAzRkIxTkVPV1FYUHQ3?=
 =?utf-8?B?eUdiMU11dG94U2RRTlF1MHBHUnhvOVFiVTB6L0hia3Q2K0IybmdaMGpkalgw?=
 =?utf-8?B?eFdhMzlJQ0d3KzRMUk5XWktxbnpnS092MG5ndUNpTmdkWFg4V25kTHJicldD?=
 =?utf-8?B?S0FJOW0zQ09YZkw1NFRZUHU2elIxWnRwOGdZSWVsL1hBbkhodDZYL3RLUXAw?=
 =?utf-8?B?M3hsczFaaEJZRVFXN2dPV2hlVXlpYmdkWEhONm10RE1nY0ZOdXB5Mm4zWnBX?=
 =?utf-8?B?aGFldFY0S3owY3FPNndSeXdBRy95N0FSeXdpeHY1L0h3QTJFRWFoQXA4SzZ1?=
 =?utf-8?B?RjVLN0tOQnNjcWtBeTdPMHhWbTh2VzJTRk1GaFFBclVySzNtT3NzbzllRmU3?=
 =?utf-8?B?czVybm5SRVhjaDFYRU55RDhNbFhNdkhiNk04YzFOWmVOOWxnSVU2djNUYXpv?=
 =?utf-8?B?RjhmQ2MzSVlrbVYvQ2FCT25OMy84TXFaUStCTUtoeE1XWHNxd3lpVHVTTkN4?=
 =?utf-8?B?TUVQOFVWU09QZis1NnNZYTIycXVxekI3UWE1ZFE3eW1BTmozNGJnRXlrU1ZR?=
 =?utf-8?B?RjA2dkxobCtlbnhvUzkwemxZRnptY09pTytZbXhrMU8zWjk0MGFtZmpWNklD?=
 =?utf-8?B?V0JGZ3lHa2gxRDR2LzZvRXJlV2ZEd3hTR1NreWFiMGtUdS9JNExGb0Qzcjk0?=
 =?utf-8?B?Y1pteWplWE55aXY0alV2c21XdEdCVWV4TzhKOXc3WFc3clpPdExmRUhaZ0Vs?=
 =?utf-8?B?ejVJZm5VL3VJUysydHN6a0cyUjBVWTFyZjhZeW9objNzUnpINzVTejhka3ZB?=
 =?utf-8?B?aXJqMTYrVWVxUlp0N05yZmZKTmlMQWlHV0ZFRVFqQk5wRWhlQzAvUUVROXJq?=
 =?utf-8?B?Y2djWGh1WlVOK25hQTc2cyt0NktUVUYzUmtwanliTTNMYzBtRUxIdEtBR0Uz?=
 =?utf-8?B?OEhITE1jK2tGOHpVM0VnQkxRVEFFN0lKUmY2Zz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEo2MjJXT0EvVS9DS1FFbTUwbDBjekRLME1wQkg0eHk0S09rbCsvM3dzbTRZ?=
 =?utf-8?B?eE5pZHN3L1RYM0Y4UzQycUZkNFR0ZjE4YUFOMHpSa2JiWHNwZDhBNTdReURQ?=
 =?utf-8?B?Y05OMEczNUtZKytlV1RBeWpsUEQxSlFWK0w3c0NKS1cyN0lTRU5oTDZlRVp2?=
 =?utf-8?B?cUhDZjJNTkxJM2h1QnQ4N3N6RnpETDFuUkdVbUFCS0Exd1QyZCtScEtQaUJw?=
 =?utf-8?B?MUhpY3BWbHBCbW0xam42ZVQwTjJTOXcyNzVvNkQ5QlEwVTQ0Zjh5UDFVNWdk?=
 =?utf-8?B?cDRDU3N5WWFTcTVESmY0NFRqdEc3VElOeHo5NTNZOHVuTklBd0VWWHV1aUhY?=
 =?utf-8?B?czNhcExMbGlhZE1RVmVPUWlsWXNTQU9ESzNQS1FNQ2JFVm5TZU16a05XcW1l?=
 =?utf-8?B?NzVGdWQ3YkhRMDFZa05hOEMvWDNTUk01TE00NFh1RXFRWTd1NE5KMEZNT3c4?=
 =?utf-8?B?RnBpeU1ydWFTZ1NRWHpyQVk5K204YjdURXhVMzRtcUcvTk13L0M4UkNRQTBJ?=
 =?utf-8?B?Q1dobGZvOFZpVjZFVFY4UXU0SmFTelJrTTdwU3J2ZDZHV1hkaTd6S3R6UEo2?=
 =?utf-8?B?a205N0FOYk0zbnQ2dW56Z0orY2U3MUJlNGFzWnpkYnJ0NHdqb0xhYTlKbVkz?=
 =?utf-8?B?Mzl3NjhmWlVhKzd1WkxKdytuY0lyamo0SURseEtXbHVWamNHTE83VFFyTC9s?=
 =?utf-8?B?VXN2OWJvWFVLZFNCcEdQeVZyRVhKU2lEdHhXQjdvNGk0a2t6RXM4cmZzRTVP?=
 =?utf-8?B?eFhIRzN0U3o4bU5Ub0czN3lhQ0Fyb0lLMlA5YUwxOC9LOVJweVA0dmVlcUQw?=
 =?utf-8?B?OUFGZjU3enl0dDJ6T1QwUERDNHBLWHdvSTdRQVBSbjFZei9oTWJIcFlUYVlZ?=
 =?utf-8?B?QVZUWXBsMzFCWXlUbGNGT1c0WU9CSEpmRmVwWjcvYnI0dHMvc3NUME5MU3BX?=
 =?utf-8?B?USthc09iZmtvS3lrd0QwRjdLTnVtR291QVU2R3YwOXZBUmxyU2xMV3JOY0Y5?=
 =?utf-8?B?UWVsajk2VjRxaHBzS3pLTU4wZFdEM1k2MEg1R3RvcjVyRmtCZzdEQVcvYkd6?=
 =?utf-8?B?NGFYMmxtV1ZsQ1VlbGZDdGxPNXA1cEQwU2dRVEJRYThrNm5sdFZTbmdCRGls?=
 =?utf-8?B?cms3blEvbjRFZmRhUEtiS1lNRFNlL2pnVFdpMGE3aFRsbEd6ZUx4dUhNTFVo?=
 =?utf-8?B?QmVwd0dlVmZ2MmdiMzNET0ozUXFpQmJPeW1tTUNURUpYcGxHVm53Sm91Rk5a?=
 =?utf-8?B?WWh0OVZ0d1J6OHhXdDVaMTlwUlJ2WWNydVNDV0czMzdhS21QZ3NrS21TN1hZ?=
 =?utf-8?B?OG5acitkUHVyMVFQK252dzgxdUFwMlJNbGRsYm5BMVBIaDFtbDFLdGRRZ3ZO?=
 =?utf-8?B?TG02RnpNYWcycmNXVk92UkliUWdnd2YraHhYNFYxa24rRXJpYk50QnI0dE5w?=
 =?utf-8?B?QnVDQnk5VU9CZjgycktOV3hXOE1vd1NPa2s5aC9jUEVjKzc4Z2pWRXkwYUtN?=
 =?utf-8?B?R2drNTlqenBEdXVCN1FYM0pIR2o2eFlxbFRkTU9hK2V1NDU3Y1VLSHIwT2VP?=
 =?utf-8?B?YjFoY0twcnhTQlBydENrQWQwV0RKTFhaOVpESGliNzhWL3QyNVBpVHh0NGg2?=
 =?utf-8?Q?gLFvV8Dv7MQ56shjrxw2nqCV4muOT7T+ZkdwP3HmWMvw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7807-9-msonline-outlook-0c92f.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e72b1508-d7c3-488f-7bc0-08ddaa1bf9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 01:45:28.8296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1038
X-Mailman-Approved-At: Fri, 13 Jun 2025 06:53:08 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

V2hlbiBib290aW5nIFJJU0MtViBFTEYtZm9ybWF0dGVkIGtlcm5lbCBpbWFnZXMgKElIX1RZUEVf
S0VSTkVMICsgSUhfT1NfRUxGKSwNCmV4cGxpY2l0bHkgcGFzcyBTTVAgaGFydCBJRCAodmlhIGEw
L2FyZ2MpIGFuZCBEVEIgYWRkcmVzcyAodmlhIGExL2FyZ3YpDQp0byBjb21wbHkgd2l0aCBtb2Rl
cm4gU01QLWVuYWJsZWQga2VybmVscycgYm9vdCBwcm90b2NvbCByZXF1aXJlbWVudHMuDQpTZWUg
aHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvYXJjaC9yaXNjdi9ib290Lmh0
bWwjcmVnaXN0ZXItc3RhdGUNCg0KU2lnbmVkLW9mZi1ieTogWm9uZS5OIDx6b25lLm5pdXpoQGhv
dG1haWwuY29tPg0KLS0tDQogYm9vdC9ib290bV9vcy5jIHwgMTEgKysrKysrKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYm9vdC9ib290bV9v
cy5jIGIvYm9vdC9ib290bV9vcy5jDQppbmRleCBhM2M3Y2I1MzMyZS4uZDk1NDc3ZjEzNDQgMTAw
NjQ0DQotLS0gYS9ib290L2Jvb3RtX29zLmMNCisrKyBiL2Jvb3QvYm9vdG1fb3MuYw0KQEAgLTQw
Miw2ICs0MDIsMTcgQEAgc3RhdGljIGludCBkb19ib290bV9lbGYoaW50IGZsYWcsIHN0cnVjdCBi
b290bV9pbmZvICpibWkpDQog4oCC4oCC4oCC4oCC4oCCaWYgKGZsYWcgIT0gQk9PVE1fU1RBVEVf
T1NfR08pDQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmV0dXJuIDA7DQoNCisv
Kg0KKyAqIFJlcXVpcmVkIHBlciBSSVNDLVYgYm9vdCBwcm90b2NvbDoNCisgKiBhMChhcmdjKSA9
IGhhcnRpZCBvZiB0aGUgY3VycmVudCBjb3JlDQorICogYTEoYXJndikgPSBhZGRyZXNzIG9mIHRo
ZSBkZXZpY2V0cmVlIGluIG1lbW9yeQ0KKyAqIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvbGF0ZXN0L2FyY2gvcmlzY3YvYm9vdC5odG1sI3JlZ2lzdGVyLXN0YXRlDQorICovDQorI2lm
IGRlZmluZWQoQ09ORklHX1JJU0NWKQ0KK+KAguKAguKAguKAguKAgmJtaS0+YXJnYyA9IGdkLT5h
cmNoLmJvb3RfaGFydDsNCivigILigILigILigILigIJibWktPmFyZ3YgPSAoY2hhciAqKilibWkt
PmltYWdlcy0+ZnRfYWRkcjsNCisjZW5kaWYNCisNCiDigILigILigILigILigIJib290ZWxmKGJt
aS0+aW1hZ2VzLT5lcCwgZmxhZ3MsIGJtaS0+YXJnYywgYm1pLT5hcmd2KTsNCg0KIOKAguKAguKA
guKAguKAgnJldHVybiAxOw0KLS0NCjIuNDUuMg0KDQoNCg==
