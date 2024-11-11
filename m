Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66687D2E9C0
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:48:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF1FE88C0F;
	Mon, 11 Nov 2024 09:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ub40Omlg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D9288AE8; Mon, 11 Nov 2024 09:48:48 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C102B88E17
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 09:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hn5TZ7Bez0+NEiAWtBNNGddB3Bo6b+3tvxkHKinXzJCj0phhbvJRu3ZTWrUa8ChVC8ZEIAAk6xIBDwc9rBeUJDO/JrDwMlJ09eZ5XyD44SqV2p6fPErqhhH+pszooZH6ZBJqIM2lhLcDaQSg1/vg+GMX5+JsCbvXqCbLeZsXEOUAF8MI3OPslFOxnmEshpjs8ZsYlrwQv5lA9AOr4jogLZ+C0iJJsUWCjKrB9/a1bl/Bw6JvhBfhS3qfPeTuf2FLfnz4YSgyDro9xI/ARBrmSuS8rQQbE/a+ElV+NczhcdzAdNjH8xTRAIjOCFHiuGKwlum0XFTizx0Tz8l/1wngVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dewe+7VLKWavjjSiMT+LaxI1Hd9tAIs8sc6Vcc6TqWU=;
 b=cD/NSDVugJMBW+6bjUw/mfs2h936sp5+5zawAdIzDEjqFTQxo2BuQ82N2dW/Vw5aJ/6IBUikL2qTMk+HtaveP2qUq6dj3U9QLJJTiLfhaz0gbYMZg5i/uL/PN2oAUhT4zNcv6uj8MpW1UT6fkPAi/4qvSEb3eS5U6lVZgYx1Z1/vmrWGXD0oxkn39Nia6Uv/RBZnjbG+p53TdjAbid/lzJeiUWQ0QSADDKZM+5xYEAVT0jKGc2hY0Q6A2kK4UneGgEKljAOuJ9lJpTB5CvfQKCpN6MURcDJDCsVDxzk+bNXe5DcD/4QeTY35YKOW3kBGv83hvyF21+WEUH1eN57p2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dewe+7VLKWavjjSiMT+LaxI1Hd9tAIs8sc6Vcc6TqWU=;
 b=ub40OmlgKeYXA52Eg1Ato2kX1BZ5ULfex1fYC3J3KI302egdvOleya2MrGWwLOucEOXKpAHjqB5uObjw5d81QJIl1sDVqM+CQ0wALR5Lq4S4mhAHiIIR4w550fk35ID5YvM4nBUYd9WkWDQjySTjkIizinYyYoWjGjtpnLqWDovdIl2n6ihZvm1B++6UXgkBMHKMp2wp1AAjx6ulMB/sCyBJjwKdRIIyrgm+E7t9BzkCS3qy5LZtaIuQDP2ISrIxmVlTZ9OAL7unMpZqBnKW5gWyUyZizp9CJ1rm3Nu5CiX0EKngf8wSE2TsQLCGNjKWlTWSPC3XYIDOJCDWxlJoMA==
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:119::9)
 by DB4PR10MB6046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:37a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Mon, 11 Nov
 2024 08:48:42 +0000
Received: from DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c697:dfe:4400:dd6d]) by DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c697:dfe:4400:dd6d%5]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 08:48:42 +0000
From: "Leto, Enrico" <enrico.leto@siemens.com>
To: "hs@denx.de" <hs@denx.de>, Fabio Estevam <festevam@gmail.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Sverdlin, Alexander"
 <alexander.sverdlin@siemens.com>, Anatolij Gustschin <agust@denx.de>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH v1 20/22] siemens: add ddr full memory test
Thread-Topic: [PATCH v1 20/22] siemens: add ddr full memory test
Thread-Index: AQHbMZ4r4AsQmXUFn0+7oQQ2msn6/rKu3EyAgAK9HQCAAC5wUA==
Date: Mon, 11 Nov 2024 08:48:42 +0000
Message-ID: <DB8PR10MB373743FE8A33134DC9E4118DFF582@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-21-hs@denx.de>
 <CAOMZO5Btc3grPOChT5VQyaLWSx1uyKHdBgH5q3m3b1s_neiCrw@mail.gmail.com>
 <6e1933cf-64de-a02c-e6a1-6e8e5a7eed39@denx.de>
In-Reply-To: <6e1933cf-64de-a02c-e6a1-6e8e5a7eed39@denx.de>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=cbbc81e1-507e-4594-820b-99c54295fe91;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-11T08:41:46Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR10MB3737:EE_|DB4PR10MB6046:EE_
x-ms-office365-filtering-correlation-id: 7353af43-4987-4abd-3fbf-08dd022da54e
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aDBXb0YvQkFyK0VmRzU1TjFCVWFwdVVLaTdtMnloczdOelh4b0QyWGcrYUlx?=
 =?utf-8?B?UnR6em9BY2M4YzNFWWc4bDhWdE9mTTgyQ0c0dlg1THlBRXZpS1RzamdMa3FT?=
 =?utf-8?B?NXIzOVRmbDQwY2RjV1NHWlBoMUdvRHUrSzEwT1pXNFdUZkdGKzdJWVNyTU45?=
 =?utf-8?B?RUNQSVJqamcrRHdJdE14U3VJSFgwKzd6UjVscUlNOUZrdCtVbzZ4UDE5bmxZ?=
 =?utf-8?B?UTRLL1E5cEQ4ZXQ1TnpyalpRT1U1dTdiRjVGcXd3b0ttM1kxSFVvRnNtSkRS?=
 =?utf-8?B?cHBnSENxM2RPSmVmKzdXKzhWVXZvUmFaQkNGenhTcDNnOHJ6Qzk0SzhJcW9S?=
 =?utf-8?B?RjNzd3NrcDlqTGg5ejVaMitPWXd4aERDMS8xbHpYVDViQktTSlU0d0t1cjVy?=
 =?utf-8?B?VHVrSXVvSTRESUFrUWVQRklzRmZEcmRXaDJETnVWbnB0bkhGU1JLV3M0QzFK?=
 =?utf-8?B?ZzFMVU1yN2RpSVRrRnErS1p1UHJQRXJndUhTMjFscEh3dkJPZzNZekx4TEZp?=
 =?utf-8?B?S25ybUJrdk80M2hKeXVmN0FlWjNGL0J3czdUWGZ0V0dXcE51aFlacytIK3JX?=
 =?utf-8?B?eFY3dU9ycjQ1NEFmRllselFUOUtuRVF2N1Z5Z2U5akpMVHpxM1B2R2MxdHZF?=
 =?utf-8?B?UmhSNzd2SjBNMnZsV2ZuNEJDWmVVUzN1K05OaWdNcyswRVVnM3FFL0lmejEv?=
 =?utf-8?B?ZFhQdGtFbkpicGs0TWJlbVFZaFpDcVNyd29GT3lQMzVrbVNEYkFZM01wNElV?=
 =?utf-8?B?ZFF2Sm52NHpXSkUvRlNXVE80dkYzMWdWYVpvcHNMTHF6MnBlQVBIVTAyT0ph?=
 =?utf-8?B?OFAvRVpiMFVsK1Rtd3F2ZVdJR2tDR08rT0tOaWlHanRQclpqUUFDMnB0OHYr?=
 =?utf-8?B?M1FZajA4Mm41VXFnWmpzNk1Ec2xCWkFSN0x0Y05SMnYrY2lnVTZ1S1dLbS9u?=
 =?utf-8?B?TE0wQjV0YWQyaktYbE84SjRud1AzYk90aGcxQVB6MER4aXlzVWJLOHE2ZzRo?=
 =?utf-8?B?OTJnMWk5ck9qTXpxZGdWNHJxWWN0VXVXdzlzMHcwSmgxOTRXdVpxNEhtZEE0?=
 =?utf-8?B?UnpVZ2pCTFMrRi80ckFzMlNGdGRrT0EzNG1mVmpuWkZad2wrd25Mc0tlRmd2?=
 =?utf-8?B?YTJqSHRZaUllc0luenNZaTlucnhTbFhMMG5OVENKQ2RmUUJHTkQyaEhHL3By?=
 =?utf-8?B?QkpMRTJmL3l0TE5qR0FxVjl5WDc4a0QrNU4zSE9NTHlpUERzalNFb2l1TG1T?=
 =?utf-8?B?d2ZpeEZqRHd0RVl6UktSYmVLTDRGRjJsMFVKOXhqWkNTbXR6ZERycUpmOG5q?=
 =?utf-8?B?a2NRdUxDSS9QK0pZWlp3SjJoeFVMQWowWWcydlp6Y0I0MUkwc0E5VVBQSi9S?=
 =?utf-8?B?enpSYysrcUZBeG95cE5OUzVHRHdtN1VObDRHSEs1c3FTZmo4OTBhZ3VwUmdw?=
 =?utf-8?B?SDRhR0ZSMGlnK1JsaGVSKzgrT29mYmtOU1gwNFNvTVJvNDhmL0NKazFCeC9t?=
 =?utf-8?B?a3U5WU9FVmpPR2w0RDJqWGJDMkttK3NvZGV5d0plY090cEdjMisyWHRhWUJL?=
 =?utf-8?B?bVpVR3NtdHR0V0twZFhqejVHS3pNNmVQekdkOUgrNzRDM3lmdE10U1NBY1JT?=
 =?utf-8?B?cGdDUC8rbFI1SWlCODlManpFQTZaVjVzMjRrY01mZ0JoZlZGOTlmd0hqWUpt?=
 =?utf-8?B?V0NpTHpKTjI3aDJ5QnJEbUFmaUN2dTJxQW1CQWdvR3IvZmMwY1UvaWJhVjQ5?=
 =?utf-8?B?N2hhRXY4QldJdUxBWVN1MmdiOUF3ZWJOMUNCYmNLVzljUXZHSVlIdmhmZWFF?=
 =?utf-8?Q?7Du1QXkV7MbzqDZk0iFUAmdW/W/m374RNQ53s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE8yam1pRGNSeFdwUXZiOHVLMXJWTlZYaDJuZUJNS1lPbjJNcXBlQlNjYVhR?=
 =?utf-8?B?L21XdjBGeHpLajNFTmVvV1ZLc0gyNEpDNGJ1L3dIRkY2aEh1VkdmaVM1SjA4?=
 =?utf-8?B?bE16ZVpEcTg1d25LWW1CekpydjVibW1uQ3VGMjFEV3VxQ293TUpBS0ZrQmc5?=
 =?utf-8?B?NVArZXR0UzdsTmZnTFdBcVpwZVIzN1g1UEVKRE43cEMyN1JuZHBQVFdUWS9H?=
 =?utf-8?B?V29vbVVuZ0xQQThzc0loL05rbkw4MWNabm0vMHErQngzTW5CUkZ3NVB3SUo3?=
 =?utf-8?B?VjQrQkl6SWZwMGwxY1dUY2FrUDNjYUhoRDQweVl2a1RUM0hZS2ZjcmVwM0VQ?=
 =?utf-8?B?YkNyL0NXeHFHeTZwZnlNMTF0cktIV0VKblpsaUtMUVVjT2ppT2JwWXlOdldV?=
 =?utf-8?B?V09oVTVWMFh6V2VPdXZ5Ulp4NTc2NG1jTUJhTWhHd0l6RXJkdC9WQ3RwMFBZ?=
 =?utf-8?B?Z1FHc1lUWlN0SmwyNXRtZGFPRmNPRlY0UERWM2Y3ZVl4VGUySzBHOUt4enhG?=
 =?utf-8?B?TjViR0Y0djdXMzlueGpuN0REWmR6OEFFVlIvSjhHd0Z5LzBEa1NEdjdkUnl2?=
 =?utf-8?B?ZU16Nkw3M1hNaktOT3JQTGRtbUNwZ0Z3VWRYMzhlK2VheVo2YXZmSlJHcko2?=
 =?utf-8?B?b0M4ZWZQY0VBRDhDY0NmZk9QZzNEY2FnMFV4RGVVaHVNWllMS1o0SDlNS1hS?=
 =?utf-8?B?K3RnS0pXK1Y2Z05KUHYveldOR3hwaDNBQVUvT2Y1QUYxTW40c2xlREFFRUlO?=
 =?utf-8?B?SS9KUWM1WHJuWW1oc0hIdk1PRXdrWkVqU1lPeHJSaituMUI0ZHBlNHl6eVo1?=
 =?utf-8?B?YnlCUExMYWtUS0ZOdUhhUFNvNWtSc1dSSFVkc3JhR1JQYllZNlREWHh5TTY2?=
 =?utf-8?B?cll3UTlVZ2RtcExYU3hRVU9PT3lCN2FNQThFb1JsSjV5dWoxQXd0Z3cvRFBV?=
 =?utf-8?B?TzBtNU02d01BZnIvT0NSU291bGszWFMxNkpBbGFmRXFCdnZQTTRYeDZFcVc5?=
 =?utf-8?B?QjZleHd3NzJFbTI0NWZoWmxmUGhZZ3JoTkgyWk14bGl0cHc0LzJxdDB0K0w5?=
 =?utf-8?B?MmhicjJ2T0lUckNWSE8xTXJJTUFveEM5MDEzVHRxdFhuSlVKZjd2WURhb1No?=
 =?utf-8?B?V1VHOXhxTE15ZWVYbkUwUVFhWnhKY2tDLzYvRVNaRjFLSlF3ZDQ3R3JSMjM4?=
 =?utf-8?B?ZEtUU0FPUmorMGJ3OEFRV0lpYnUvRTJIcmtRVnpEalN5c3VqRGJGZnBmdWd1?=
 =?utf-8?B?eEFHa1hZUmdyQzZCMmtURktTRzhPb3Fia3NwSjFiVERiZDdnM0FLUzZXY3VM?=
 =?utf-8?B?V2h3aGhaZXMrYVFCS1Y0NEVVcnllZnBVUklQUGVzVTJnZnZBY3c4MXE2cDd1?=
 =?utf-8?B?a2dya1RiRTZyOGkzN2N4ZG5jSlZid1BueWUrNlM2bkNQMWFoczN1Z1praGlx?=
 =?utf-8?B?SVA4Skc5bXlvNFhma0ZMZXlycmF6cHJLRVVKVTd6ZjlCeW8wcVpISUVZTkl0?=
 =?utf-8?B?YjFuQWljUkNvR0ZTQ2RtSWkyUUJOdXBQV1lodE52UENSWVhkU1VHN0ZpZkZH?=
 =?utf-8?B?K0VtOG9xa3FSWXJxeFVsY20wUHY0NVdTVzFzNGZEd2IwYkpkZUZaS2ppNzg1?=
 =?utf-8?B?RmRZanNTL0tJNkpjbnVyT1NDWTNyaWJMUnhSb1RjcFJrYWRlMWJHaTVPVnM2?=
 =?utf-8?B?TlRXQVNiemJjb0NuTW10b3BZSE4wR2Jxa2pBbHRSbVNhUXZKUmwzRzFQQk5K?=
 =?utf-8?B?VWJ2K0tvejRtYWNQb1hML2F5bHc2UStsc1hZOXdTS2ZFL3JOUHZJVTdnS2gz?=
 =?utf-8?B?SmVvUXFPbmRXSEFJcWNjY0d3ZlduRWY3OUFDN0lnSW1vRS9SdW5KRHVYajVj?=
 =?utf-8?B?S241RUZSS2gzanRqdFJkbGg0RHMyeEJzdWxvSzNoakdlTUNXa3BKZzdhbUo0?=
 =?utf-8?B?aG5LSXBPWmFXYXkzSWY0MlF0dXVFTERuc2xDeFNqT3BKT0E4aE9TckFJMXVo?=
 =?utf-8?B?NGFFNXU0ZC96OXNoeWxMM21vSEZrTndxQlY0bU54b3B6cnFiWXJSNTN5T1l5?=
 =?utf-8?B?WDdSQmVsMDRZTEs4dytUQ0duVE5FWEljWmZvMFJLaVVHRmpoQkF6bDlUS1Fv?=
 =?utf-8?Q?s9LO4e++ErAEnK5sBUeMnvNAE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7353af43-4987-4abd-3fbf-08dd022da54e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 08:48:42.6609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJ6AooRy9yZcrgo8zNA6GU3IkJZ6lUHd7kf5j7xTLRCS8o5KgwMAVGY02bgUydgMhftxSVltBg8fgqdK/eaKAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6046
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

SGkgSGVpa28sIEZhYmlvLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEhlaWtvIFNjaG9jaGVyIDxoc0BkZW54LmRlPg0KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDEx
LCAyMDI0IDY6NTYgQU0NCj4gVG86IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4N
Cj4gQ2M6IFUtQm9vdCBNYWlsaW5nIExpc3QgPHUtYm9vdEBsaXN0cy5kZW54LmRlPjsgTGV0bywg
RW5yaWNvIChTSSBCIFBSTyBUSSBFQUMNCj4gQ0NQKSA8ZW5yaWNvLmxldG9Ac2llbWVucy5jb20+
OyBTY2h3ZWl6ZXIsIFdhbHRlciAoU0kgQiBQUk8gVEkgRUFDIENDUCkNCj4gPHdhbHRlci5zY2h3
ZWl6ZXJAc2llbWVucy5jb20+OyBTdmVyZGxpbiwgQWxleGFuZGVyIChTSSBCIFBSTyBUSSBFQUMg
Q0NQKQ0KPiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPjsgQW5hdG9saWogR3VzdHNj
aGluIDxhZ3VzdEBkZW54LmRlPjsNCj4gU2ltb24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+OyBU
b20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDIw
LzIyXSBzaWVtZW5zOiBhZGQgZGRyIGZ1bGwgbWVtb3J5IHRlc3QNCj4gDQo+IEhlbGxvIEZhYmlv
LA0KPiANCj4gT24gMDkuMTEuMjQgMTM6MDYsIEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+ID4gSGkg
SGVpa28sDQo+ID4NCj4gPiBPbiBGcmksIE5vdiA4LCAyMDI0IGF0IDI6MjTigK9BTSBIZWlrbyBT
Y2hvY2hlciA8aHNAZGVueC5kZT4gd3JvdGU6DQo+ID4+DQo+ID4+IEFkZCBzaWVtZW5zIHNwZWNp
ZmljIG1lbW9yeSB0ZXN0LiBFbmFibGUgaXQgdGhyb3VnaCBLY29uZmlnIG9wdGlvbg0KPiA+PiBT
UExfQ01ULg0KPiA+PiBUaGUgdGVzdCBpcyByZXF1aXJlZCBmcm9tIG91ciBIVyB0ZWFtLiBJdCBy
dW5zIG92ZXIgdGVtcGVyYXR1cmUNCj4gPj4gZHVyaW5nIG1hbnkgZGF5czoNCj4gPj4gKiBtdXN0
IHJ1biBpbmRlZmluaXRpdmVseSB0aHJvdWdoIHRoZSB3aG9sZSBERFIgYXJlYQ0KPiA+PiAqIG11
c3Qgd3JpdGUvcmVhZC9jaGVjayBhbGwgdmFsdWVzDQo+ID4NCj4gPiBJc24ndCBpdCBiZXR0ZXIg
dG8gcnVuIGEgdXRpbGl0eSBpbiBMaW51eCBsaWtlIG1lbXRlc3RlciBmb3IgdGhpcyBwdXJwb3Nl
Pw0KPiANCj4gQEVucmljbzogQ291bGQgeW91IGFuc3dlcj8NCj4gDQoNClRoZSB0ZXN0IGlzIGEg
cmVxdWVzdCBmcm9tIG91ciBtYW5hZ2VtZW50IGFuZCBkZWZpbmVkIGZyb20gb3VyIEhXIHRlYW0g
dG8gbWFrZSBhbiBpbnRlcm5hbCBjZXJ0aWZpY2F0aW9uIG9mIHRoZSBERFIgY29tcG9uZW50IHdl
IHVzZS4gVGhlIHRlc3QgbXVzdCBydW4gb3ZlciB0aGUgd2hvbGUgRERSIGFyZWEuIEl0IGNhbm5v
dCBiZSBwbGFjZWQgYW5kIHJ1biBmcm9tIEREUiBpdHNlbGYgYnV0IGZyb20gaW50ZXJuYWwgUkFN
LiB1LWJvb3QgYW5kIGxpbnV4IGFyZSB0b28gbGFyZ2UgdG8gdGFrZSBwbGFjZSBpbiB0aGUgaW50
ZXJuYWwgUkFNLg0KQWx0ZXJuYXRpdmUgbGlrZSB0byBydW4gdGhlIHRlc3Qgb24gOTklIG9mIHRo
ZSBERFIgYXJlYSB3YXMgbm90IGFjY2VwdGVkLg0KDQo+IGJ5ZSwNCj4gSGVpa28NCj4gLS0NCj4g
REVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILCAgICAgIE1hbmFnaW5nIERpcmVjdG9yOiBF
cmlrYSBVbnRlcg0KPiBIUkIgMTY1MjM1IE11bmljaCwgT2ZmaWNlOiBLaXJjaGVuc3RyLjUsIEQt
ODIxOTQgR3JvZWJlbnplbGwsIEdlcm1hbnkNCj4gUGhvbmU6ICs0OS04MTQyLTY2OTg5LTUyICAg
RmF4OiArNDktODE0Mi02Njk4OS04MCAgIEVtYWlsOiBoc0BkZW54LmRlDQo=
