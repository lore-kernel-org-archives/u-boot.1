Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BDBCA0EE0
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 06:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC4683A24;
	Fri, 15 Aug 2025 08:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eMezy8Cb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31B483A8D; Fri, 15 Aug 2025 08:46:55 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B728398D
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 08:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xUg+Wqsek5gJOhX9ZvoYrXGXX+9xnvCrkjNCMh6M8t1kYP6eikjQEUvwpXLdvFoEz5pCx3WSdZz7Gop0SRTZLXQAgAYJc6Nakw20p2jB8qpEufA14hgElKDOkyY+o2UM7VvcP9nFTuNUpVmPeIdS0ilQyvjEkic+B6PoLrEoneYmRNrcW+e0SAGkJQEXo2pol//fMpwXCEXeWIXU9gmZSpUjDNl5yHyXr460eR0lNsqMaw8w2JblgwTOZdDq8KsigQX4x4k0uuNCjWkLYb+meloMDDlyuEhyjSEyzflYo/v5UrUo8E1c8Fokq1mkxRtwYcqMFB+POGBFaK5D+uB5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnY2hOWz6oo67tmjn+HWHw7yk9yR5F9ucYUcqs1Tl8s=;
 b=uwS4gvFTzNR83AEg3o2QHTKwu4pJZAPnq5a6KBftlDaAnwxGvfHvm4cAR2V5LgVxw0L9o85WGCJLGJAAnhj4MqdGgd+115U5pdoSmjW1MhYBRwU5bzYLb6LFLQ9Lp8WDC3MxH1nsds3sfHzWV/17VXzGR36ZMtTYbXLxsuU9ZsxyEEZgjsxrMM1I2ThybRwKdmadBcZGxczxBZNHQHxIOKZUS7qAmG1biPPU27O/Avecc6X2/mOyJ5g39lfmuBLhteReRrfem8PLzW5RY1MN7yVjdM+YZsfQ4x7Oj2sgJX1+Admm2K9sk5nIM6kdKdtMaxmILBBN3CU4tjoeLdSX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnY2hOWz6oo67tmjn+HWHw7yk9yR5F9ucYUcqs1Tl8s=;
 b=eMezy8Cbm56SvMtc5YwY4bpD78B7IscOlUW4+Se307E5+gWu6joxNxbj2gy+LwGnNGecCJ/cZJ9o5RIM8kKl9XVwLb9ECzDUfKS/oedDactXi9LNs5P5pCtNsNOVs8QzQ/vRGugLuw1uayHw9MGdT1VwVuQ0W64eBgt7EyOkOq2o/7IQBl9mikXmLLR7POzLYzYomtGbDFY2DkwjVqZhPyi63ToFQAZD2AbscBnlyzZg586uplLjr7FI0ac6EGfe8YtaK52cy2PAc2ka+0fBCBij7MQwdhX1bcGSesFFcN6pq9ZczSbMNjxIejfIB8rCeyENLYuwGMzwJynNmizgUg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PAXP195MB1560.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:281::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 06:46:51 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 06:46:51 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v3 0/6] Fix handling of optional blobs in binman
Thread-Topic: [PATCH v3 0/6] Fix handling of optional blobs in binman
Thread-Index: AQHb3FsnMYVoZScobE+z4BY4QnCudLQVzqQAgE0jRoCAAKSpgIAAEXcA
Date: Fri, 15 Aug 2025 06:46:50 +0000
Message-ID: <5afb0dd2ffa60298890a9778a5e44047a5e39753.camel@phytec.de>
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
 <175096060477.1879961.6525302263431603846.b4-ty@konsulko.com>
 <CAJ+vNU1c6RchWTjX+A1dUi-WQ+m-60QacY+-dA5ScodFsc95_A@mail.gmail.com>
 <e22d803c78a0e02747be94bac23f02da37bc13fa.camel@phytec.de>
In-Reply-To: <e22d803c78a0e02747be94bac23f02da37bc13fa.camel@phytec.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PAXP195MB1560:EE_
x-ms-office365-filtering-correlation-id: 2c8ef2b3-4f6d-40d8-b54e-08dddbc783a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2c4Ym92bDNqbHZsNFU2bmI0VnN5cUZhSCtENDl6cFlGZzN0cGRsUWRyaUNF?=
 =?utf-8?B?a3BwRGsyaTBMZ3FEUmVTVTg2YVg5c05oOUFlSXN5Y1ZFNEgvRVRPU2JRV010?=
 =?utf-8?B?V1FLdytvTnQ0WHlZMldrd2dXdTNNcEE2QkR2NE9acVNoSS85Z3FQWXBkQkZM?=
 =?utf-8?B?Q0U5SzNuWlFGYmpXRTY5OU5EOXpxYk5NQStDQnZBN1FQRFhmQUtGcHNCSnFa?=
 =?utf-8?B?NkpuRjN5WEc3OWRNTVRNZkladGZEU1ZQcVhtckpveXVXOTliS1NTOWlramVM?=
 =?utf-8?B?Nms5WjJ4KzBOYVlQOXZ2dzc4T2JuU1FCb0FzSGVVZ2IvQnVLRlFZeXdqQlF6?=
 =?utf-8?B?RXpmSUR0eGhqSnduNldFOFYybGwwTi8wTnpjMVAvTHY0Yi82cjZGWmFBRzg1?=
 =?utf-8?B?SVVrc2ZTYWdISCtGemNkT1MvakVNc1Q2czdnRFhub01lcUsrMWI3TWFGMk5k?=
 =?utf-8?B?cEgyeEtNOVhuUTJwQ0xFeGwzMmlqRmpaLzZzU3locnlzeTFwS0NFbERPVllE?=
 =?utf-8?B?cUFwRkNqZTJhbUlhcmFSVSsvSDdNc2k2Q002eCtWU2R2R3NRa21Td3FlRFp3?=
 =?utf-8?B?WjBDQ0EvZzV4clR0Y1JmUGc1c0pFVDZtSFNIbmhRdDJOVXlONEpqOGpYSTZa?=
 =?utf-8?B?d3NnQ0VQMi8yQkNyd0RkeUdFTHJtSWZUNFpsSlc2TjVCM0hlZmtYa2JlV01B?=
 =?utf-8?B?MGZPd2xnUWVVeG1rUmFWV0lpaW1ReTJVRyt3SUNET1BOMW15TlZxM0hHMUZO?=
 =?utf-8?B?QW9uMnI0N01EZHJCVmhidDVwL08wMjBEeUhCcmNrb0ZmUkdHT2JaM2h5R2xl?=
 =?utf-8?B?ckE3R256VTVQcG9JL3pyWnVwVS9QdkllVUxEYitlQlY5Z2JrNk4vL2t4aURz?=
 =?utf-8?B?ZjNFeUJKakRSS3lmc0VubnlpK1BRUWJYTnA3ZjNTdnpGUWZTcnFDdkxYcHFj?=
 =?utf-8?B?U21LUFFEWTF1bkJhY1hIWFp3QVpYcnVPZVhJYjlqZG5RMHVuRHpIRHhPUUVL?=
 =?utf-8?B?ZnBMWU5kKy9EL1NXWmg4TjNpRHV1NEZ4VTRsQjVCcjRQQjVvYTVHeU5OUjJP?=
 =?utf-8?B?bTd3OFNDRGF6MWd5R0RFNm9VUFpDYVhPeVFobnlOcFV1MjE2dXlLUE1yRmVT?=
 =?utf-8?B?UjJiTVJWY3NZbmhwUkhtN0hSaXdkVHNsZVpIM0hqeFFzN2Y0akVaaHhHYVk2?=
 =?utf-8?B?d2JGVUZTRGZSNkJxRlVnN2JJYS9Pc0loR0hqOENOcjZFT043K296RzdOdUY3?=
 =?utf-8?B?NlBiWmNabU80WVZEOUR1L1dwYmJJOVdsbUR2SzNmWTBmRUZJTVg5NDB6Qm54?=
 =?utf-8?B?K3o1aGFsaHpSODdmbGptSWVNbWZHdXUwYlJoY3U4aVdQalBZUmdPaU8vKzBW?=
 =?utf-8?B?MC9teW1IY21XeE9oMGRYODZWNDlwbVZxVXFYNWRGaEJQTFB0NnZyUi85TGhX?=
 =?utf-8?B?ZXB4SlBvcGpicnJBYTNvYW9RYnFhU1RrMUpMWE5TN0tCRnd4U3RrbHIvbEtB?=
 =?utf-8?B?WTZ5bkJLVmY4a0tnK2h5dWNHemZYMzBKeG1veE1XVmFQY003WFN3MkY4d1ZH?=
 =?utf-8?B?SjVZczB5ZXZVV2JYYjVzWXNGdzNaTEZhakJ6ZEh3R292L2NQeDNid2F2dmFT?=
 =?utf-8?B?NkFjTGpXQm1VS3dLTldveEhvUHNTTk0xUyttRTFhMFBIWEFXb2ZjTkN3ek5U?=
 =?utf-8?B?VlBSeDNsRndnOTcrdmxKSHBQaFRtcUtZdWh1TC9acHJBKzdxMzFoaXJEM1M4?=
 =?utf-8?B?dUVuMzBhbVgzR1lMbmxlN2NYUW05eXRYcGtPSitXbzNyUHlVU2ExcDRjTklL?=
 =?utf-8?B?ckV3Wms1dTAyUTNkZnp3cUZIOGxPRGFqQ0owUTM0eWpzL09GaWFWdHB5QlJY?=
 =?utf-8?B?SDFKQjIvQlR3VlRNZ2dyRklneU9yajBPY2oyV2ZYWHE0b041Q1drd3dvOC9s?=
 =?utf-8?B?dkhBY3dKMW15RUJqMDdZTGhoeUZxS0tpSnpLWnFVdHFyNEpXSmsrdU9BL3hR?=
 =?utf-8?Q?iIXVe3FYZgWKxSE1vnGL6S3s6rMzas=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHlWVGcwbURCR2FJemlZS1FmanYwT3J0bjZMcFAxMlFEWTNmYlZrMVVaQjBw?=
 =?utf-8?B?OXNhdWFINmlPeGVVQStQNUVLSGZYUk9XS0hKTVhNK1IxdTlkaDlQTGM1MW00?=
 =?utf-8?B?OGRlcTAxVHVBUUhibStjMXpvQ1BwbGNHMVJjUS8yZ3hVZzBmMjBaQmNqaWty?=
 =?utf-8?B?Z3lWWnkxWTFUM0dZQ2VEalp4L3ZIbjFXRnhUS0dRZ2xLUXY5OFBtMys5NHBR?=
 =?utf-8?B?c1hNTm5zTU5hUFNtN2VCNU82Zk1pQmZINGNUOURleGVJd1dpMmpESGZsamhq?=
 =?utf-8?B?YkJIZ3Z4MEVhY3F1UktuL0Y5L1hxTFEzclVGWlJWWDZnZDEwU1ltTWRicGdt?=
 =?utf-8?B?ZnBWbzQ1cDR2ZlZocHNFS0Y2UGFvSFF5MUxLOGc3RTRkTGxDZUJTc09PQTJv?=
 =?utf-8?B?UTNEaCs2V1kwSXZHUEpKN08vQXQrN1hKZTNidTBqQVRkY1o4eWoyT1Z2MmtP?=
 =?utf-8?B?TnFia1NZYmQ2bU5TN1hFaGk3VUZoMHluYW1TRldSbzNCeDNlNysxc1FuaFFU?=
 =?utf-8?B?RUpnbHZCd0xPdFkrR3F5SWVjYnVkYytkYUFqZXpwQlhIcXhFb09IZzRSKzlY?=
 =?utf-8?B?WmJFbGJEZ0I4aFVnNWJ5T0dJaE9hUGJPUHhtNHYyeStnUTUwVUhyY3RJbDNI?=
 =?utf-8?B?QkpnTUNaQW1FWENhODllUVRxNG5vZXgvbjJlSDA1N1Y2bVp1S2RXQTFFSGVp?=
 =?utf-8?B?dWdFbDlOSEY5UTdjeU1vZXBBdlZSeVZ0Y29iNlhJZktHMkU3aGdka2VqL2xn?=
 =?utf-8?B?b1Nqd3UybllxY2RQYmFEcTFwNjdldTFLRnFpRnhJUXl0RGVCbllndmNBTVow?=
 =?utf-8?B?bHNGVE9IQUJUWTN1cC9xVzRtUlJZanUyaGlBbGp5eDFTaVF1TU45c1VrL01W?=
 =?utf-8?B?Q1BJNWo2bnNNbDhmYTY1MXlrZTEwTWNvVlhRTkhKZlZZTXRZRldqNE9ScVBv?=
 =?utf-8?B?QnNXMkxxazNRdlJYZG9IaTUrSE91cVFvNEh0WUlodXJVUUNJOE5pQWVqODVY?=
 =?utf-8?B?YnZyS2pWZ3JvSjQ1Mkt3a3JDSTFkak9BdFpXd0hTU0VJUjhJTm5leEJLRzRm?=
 =?utf-8?B?ODU1ckx3Y0lxQVUzK1hwMWdLalNtUWtXeVIzNTF5WGhHNlM2SkhUVTJoTzBN?=
 =?utf-8?B?Yms2UHo5UWsweWRnbFNSRHFMWGJVL0FDNlU4cWJGVFRmd3IvckJwYTdaS1NR?=
 =?utf-8?B?bWZpQlAwaDA5eTgxL2VSdE9vSXJHSlJxSFpHSUo0Q2NaY25xVThER1k2VTFq?=
 =?utf-8?B?RmRDOTQrMDc3UHBXbWl1eHRTcGorSWxCQjJYRTFVQVFlR29oVmpiNVhnWVRX?=
 =?utf-8?B?TDdtTkx6R1MrWkYzeG5kRkc4Y0hOZFpFYnBlcTRyRnFDdFhwbHBtOGxCdlVl?=
 =?utf-8?B?UTNrQUpKWHFrZ2FRanZTdTIvT3kwTWtUOVpuUE8xT3lVdG1MaFQ4TFdkbHBn?=
 =?utf-8?B?YTkxTkM3TnhMOVhHa3N1eTlPSHRySWVaQWFHamdqdjlZdnBha0hocGpHaGc0?=
 =?utf-8?B?V1lJQUFZZk9rUTNFdXlYTDlXNHlNOE82dUkwLzJqNjhnNEltU0oxR1N5UXFy?=
 =?utf-8?B?SWpvSkpqYWM0ZjNwUENhZlg3M1YvL3NYck5VVCtuTU5vUVdIWXV0RUIyY1RL?=
 =?utf-8?B?bFRmeXVDR0xtNzRNb1ZZUmlnOEs3azArVE1hNFpMOFlPUzZoSG1JNkNLNGNh?=
 =?utf-8?B?RmhnRnEvSHk1bkdyL252cHBZcGhGcytGelVON2VyQ2gxTlczWjdhd3NFbmpw?=
 =?utf-8?B?dEFXRVRkRjIwczRjOUsrNVJjWGpka2xJTGlkSmcxNStlT2NIVUxwalBzZzlw?=
 =?utf-8?B?WWVSS3NyQ1RMcG10OTBMVThhMGM3R2dYUnFWMXFlb21BMjVJSUg4alFMOWM1?=
 =?utf-8?B?UXRQTkJBMkZFaWxzTFRMRkxQQXJOU2gzZDBJVWZtY0h4K2EwcFBTQWJ5aUhN?=
 =?utf-8?B?YUl3OEhXa3lYSEswWjdiK0RCaVZDbEV2a1pWdDlpK1BHdjdzaWtLMTNpZUFp?=
 =?utf-8?B?QVVsOURUaEtsbXNYeWZtblNmOCsxZjVvbXMrUzA3UWZQUDhURXJRS0lLU0oz?=
 =?utf-8?B?cjJQMVFCU2t1ZTNTdlV6Q0lUaW4yeW0vR0lVbFhTNTB3SnB6QkJvVlFoazFl?=
 =?utf-8?Q?/IBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70C658E98DBD404293DA7EEFF7F9FE15@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8ef2b3-4f6d-40d8-b54e-08dddbc783a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 06:46:50.9826 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W7UdoiKUJ9PWKCFwlAEu57BB08gWUufiz02kSo2lQvz/nHcYOhI9huMWBJWuhu+svd+Q1rMN3B3VA/CjZwl0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1560
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

QW0gRnJlaXRhZywgZGVtIDE1LjA4LjIwMjUgdW0gMDU6NDQgKzAwMDAgc2NocmllYiBZYW5uaWMg
TW9vZzoKPiBIaSBUaW0sCj4gCj4gQW0gRG9ubmVyc3RhZywgZGVtIDE0LjA4LjIwMjUgdW0gMTI6
NTQgLTA3MDAgc2NocmllYiBUaW0gSGFydmV5Ogo+ID4gT24gVGh1LCBKdW4gMjYsIDIwMjUgYXQg
MTA6NTfigK9BTSBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPiB3cm90ZToKPiA+ID4gCj4g
PiA+IE9uIEZyaSwgMTMgSnVuIDIwMjUgMTQ6MDI6MzkgKzAyMDAsIFlhbm5pYyBNb29nIHdyb3Rl
Ogo+ID4gPiAKPiA+ID4gPiBUaGlzIHNlcmllcyBzb2x2ZXMgYSBjb250cmFkaWN0aW9uIHJlZ2Fy
ZGluZyBleHQgYmxvYnMgcGFja2FnZWQgaW4KPiA+ID4gPiBiaW5tYW4uIFdoZW4gdGhleSBhcmUg
bWFya2VkIGFzIG9wdGlvbmFsLCBieSBkZWZhdWx0IHRoZXkgYXJlIGZha2VkLCB0d28KPiA+ID4g
PiBtZXNzYWdlcyBhcmUgZW1pdHRlZC4gT25lIHNheXMgdGhlIGltYWdlIGlzIG5vdCBmdW5jdGlv
bmFsIHRoZSBvdGhlcgo+ID4gPiA+IHNheXMgdGhlIGltYWdlIGlzIHN0aWxsIGZ1bmN0aW9uYWwu
IEJvdGggY29uY2VybiB0aGUgc2FtZSBiaW5tYW4KPiA+ID4gPiBlbnRyeS9ibG9iLgo+ID4gPiA+
IAo+ID4gPiA+IEJpbm1hbiBpcyBzZXQgdXAgdG8gaGF2ZSBmYWtlIGV4dGVybmFsIGJsb2JzIGlu
IGNhc2UgdGhleSBhcmUgbWlzc2luZy4KPiA+ID4gPiBUaGlzIGlzIHJlZ2FyZGxlc3Mgb24gd2hl
dGhlciB0aGV5IGFyZSBvcHRpb25hbCBvciBub3QuCj4gPiA+ID4gVGhlIGltcGxlbWVudGF0aW9u
IGRvZXMgbm90IGFsbG93IGRpZmZlcmVudCB0eXBlcyBvZiBlbnRyaWVzIHRvIG92ZXJyaWRlCj4g
PiA+ID4gdGhlIGZha2luZyBkZWNpc2lvbjsgYXQgbGVhc3QgdGhlcmUgd291bGRuJ3QgYmUgbXVj
aCBzZW5zZSBpbiBkb2luZyBzby4KPiA+ID4gPiAKPiA+ID4gPiBbLi4uXQo+ID4gPiAKPiA+ID4g
QXBwbGllZCB0byB1LWJvb3QvbmV4dCwgdGhhbmtzIQo+ID4gPiAKPiA+ID4gWzEvNl0gYmlubWFu
OiBkcm9wICJmYWtlZCIgcmV0dXJuIHZhbHVlIGZyb20gY2hlY2tfZmFrZV9mbmFtZQo+ID4gPiDC
oMKgwqDCoMKgIGNvbW1pdDogYTY1N2Q4N2YwODc4OWM0YzUwNDIzODk3YmQ1ZWUwNTJjNjIyM2Vl
Ngo+ID4gPiBbMi82XSBiaW5tYW46IG1hcmsgb3B0aW9uYWwgbWlzc2luZyBibG9icyBhcyBhYnNl
bnQKPiA+ID4gwqDCoMKgwqDCoCBjb21taXQ6IDNhZTY2OGI5ZDIxMDFkMTExZDI1N2VlN2Q4OTEy
YzE5Y2ZiMGUxMDIKPiA+ID4gWzMvNl0gYmlubWFuOiByZXdvcmsgZHJvcHBpbmcgYWJzZW50IGVu
dHJpZXMgZnJvbSBwYWNrYWdlZCBpbWFnZQo+ID4gPiDCoMKgwqDCoMKgIGNvbW1pdDogMjFiYzM0
MzNhNDNkM2FkZDM0MzA1NDNjOWVlZTJhOTVkNGRlZTJmNgo+ID4gPiBbNC82XSBiaW5tYW46IGFk
ZCBmYWtlZCBvcHRpb25hbCBlbnRyeSBjYXNlIGluIENoZWNrRm9yUHJvYmxlbXMKPiA+ID4gwqDC
oMKgwqDCoCBjb21taXQ6IGY1ODE3ZTA1ZWZkMzlkZDQ1NWMyZTZhMGYwNjIyZDcwOWZlN2VhMmQK
PiA+ID4gWzUvNl0gYmlubWFuOiBmdGVzdDogcGFzcyBhbGxvd19mYWtlX2Jsb2IgdG8gX0RvUmVh
ZEZpbGVEdGIKPiA+ID4gwqDCoMKgwqDCoCBjb21taXQ6IGU3NDlkNjRiNDYyMjgwNjA3MmM1NmE4
MzljZjlhMzZhNTA4MWI1NzUKPiA+ID4gWzYvNl0gYmlubWFuOiB0ZXN0OiBhc3NlcnQgb3B0aW9u
YWwgYmxvYnMgZG9uJ3QgY2F1c2Ugbm9uLWZ1bmN0aW9uYWxpdHkKPiA+ID4gwqDCoMKgwqDCoCBj
b21taXQ6IDBkYmIwYThkMWYyYWVmYjJhN2ZkZDhlNjI3ZWRkOTU1ZTRmZThkM2EKPiA+ID4gLS0K
PiA+ID4gVG9tCj4gPiA+IAo+ID4gPiAKPiA+IAo+ID4gSGkgWWFubmljLAo+ID4gCj4gPiBJIGhh
dmVuJ3QgaGFkIHRpbWUgdG8gZGlnIGludG8gaXQgaW4gZGV0YWlsIHlldCBidXQgaXQgbG9va3Mg
bGlrZQo+ID4gaW14OG0gYm9hcmRzIGFyZSBmYWlsaW5nIGFnYWluIGluIG1hc3RlciBkdWUgdG8g
dGVlIGNoYW5nZXMgYWdhaW4gYW5kCj4gPiBwZXJoYXBzIGl0cyB0aGlzIHNlcmllcyB0aGF0IGlz
IGNhdXNpbmcgaXQuCj4gCj4gVGhhbmtzIGZvciByZXBvcnRpbmcsCj4gCj4gPiAKPiA+IEhlcmUn
cyB3aGF0IEkgc2VlIHdpdGggdG9kYXkncyBtYXRlcjoKPiA+IG1ha2UgaW14OG1tX2V2a19kZWZj
b25maWcKPiA+IG1ha2UKPiA+IC4uLgo+ID4gwqAgQklOTUFOwqAgLmJpbm1hbl9zdGFtcAo+ID4g
SW1hZ2UgJ2ltYWdlJyBpcyBtaXNzaW5nIG9wdGlvbmFsIGV4dGVybmFsIGJsb2JzIGJ1dCBpcyBz
dGlsbCBmdW5jdGlvbmFsOgo+ID4gdGVlLQo+ID4gb3MKPiA+IAo+ID4gYmlubWFuOiBtb2R1bGUg
J2ltcG9ydGxpYi5yZXNvdXJjZXMnIGhhcyBubyBhdHRyaWJ1dGUgJ2ZpbGVzJwo+ID4gbWFrZTog
KioqIFtNYWtlZmlsZToxMzM5OiAuYmlubWFuX3N0YW1wXSBFcnJvciAxCj4gPiAKPiA+IEkgdGhv
dWdodCBJIGhhZCByZWFkIHNvbWV0aGluZyBhYm91dCBhIHdhcm5pbmcgdGhhdCB3YXNuJ3QgYW4g
ZXJyb3IKPiA+IGJ1dCBhYm92ZSBpcyBjbGVhcmx5IGEgYnVpbGQgZmFpbHVyZS4KPiA+IAo+ID4g
QW0gSSBtaXNzaW5nIHNvbWV0aGluZyBoZXJlPwo+IAo+IE15IGluaXRpYWwgZ3V0IGZlZWxpbmcg
c2F5cyBpdCBjb3VsZCBiZSByZWxhdGVkIHRvIHRoaXMgc2VyaWVzOiAKPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy91LWJvb3QvMjAyNTA3MDEtcGtnX3Jlc291cmVzLXJlbW92YWwtdjMtMS0yNzAx
ODhiMzM1YWVAcGh5dGVjLmRlLwo+IAo+IE1heWJlIHRoZSBjb21iaW5hdGlvbiBvZiB0aGUgMiBz
ZXJpZXMgY2F1c2VzIHRoaXMuIEFueXdheSwgSSdsbCBpbnZlc3RpZ2F0ZQo+IGFuZAo+IHJlcG9y
dCBiYWNrLgoKU28gdGhlIGVycm9yIHlvdSBhcmUgc2VlaW5nIGlzIGVuY291bnRlcmVkIGhlcmU6
Cmh0dHBzOi8vZ2l0aHViLmNvbS91LWJvb3QvdS1ib290L2Jsb2IvMGM1NThiYmFkOWU3NTgxODA4
YjM1ODA5MWQxZmQ5NzlmODYwZThhYy90b29scy9iaW5tYW4vY29udHJvbC5weSNMOTgKClRoaXMg
aXMgaW5kZWVkIGNhdXNlZCBieSB0aGUgcGF0Y2ggSSBsaW5rZWQgYWJvdmUuCldoZW4gd3JpdGlu
ZyB0aGUgcGF0Y2ggKGkuZS4gZm9sbG93aW5nIHRoZSBtaWdyYXRpb24gZ3VpZGUpIEkgZm9vbGlz
aGx5Cm92ZXJsb29rZWQgdGhlIGZhY3QgdGhhdCBpbXBvcnRsaWIucmVzb3VyY2VzLmZpbGVzIHdh
cyBvbmx5IGludHJvZHVjZWQgaW4gcHl0aG9uCjMuOSwgeWV0IHdlIHN1cHBvcnQgPj0zLjcuIAoK
SSByZW1lbWJlciB5b3UgdXNlIHB5dGhvbiAzLjgsIHNvIHRoYXQgaXMgd2h5IHlvdSBzZWUgdGhl
IGVycm9yIChhbmQgSSBkb24ndCkuCgpJIGJlbGlldmUgSSBuZWVkIHNvbWUgaGVscCBvbiBmaW5k
aW5nIGEgZ29vZCBzb2x1dGlvbi4KRm9yIHRoaXMgZGlmZgoKLSAgICBnbG9iX2xpc3QgPSBwa2df
cmVzb3VyY2VzLnJlc291cmNlX2xpc3RkaXIoX19uYW1lX18sICdldHlwZScpCi0gICAgZ2xvYl9s
aXN0ID0gW2ZuYW1lIGZvciBmbmFtZSBpbiBnbG9iX2xpc3QgaWYgZm5hbWUuZW5kc3dpdGgoJy5w
eScpXQorICAgIGVudHJpZXMgPSBpbXBvcnRsaWJfcmVzb3VyY2VzLmZpbGVzKF9fcGFja2FnZV9f
KS5qb2lucGF0aCgnZXR5cGUnKQorICAgIGdsb2JfbGlzdCA9IFtlbnRyeS5uYW1lIGZvciBlbnRy
eSBpbiBlbnRyaWVzLml0ZXJkaXIoKQorICAgICAgICAgICAgICAgICBpZiBlbnRyeS5uYW1lLmVu
ZHN3aXRoKCcucHknKSBhbmQgZW50cnkuaXNfZmlsZSgpXQoKSSBoYXZlbid0IGZvdW5kIGEgZ29v
ZCByZXBsYWNlbWVudCB0aGF0IGlzIHB5dGhvbiAzLjcgY29tcGF0aWJsZS4KQW55IGlkZWFzPwoK
WWFubmljCgo+IAo+IFlhbm5pYwo+ID4gCj4gPiBCZXN0IFJlZ2FyZHMsCj4gPiAKPiA+IFRpbQo=
