Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685F5C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 09:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EA781FEE;
	Thu, 30 Jan 2025 10:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="deo5CIQl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0014481FEE; Thu, 30 Jan 2025 10:48:24 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::717])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B6B80AE4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 10:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyXRac9504iIcsoe8CxCINvMW/NUAt7am2JeAKY38VJjONJTmOb0WlLmAm8MzlLvV/mjxr4fmlbhPwllgyz1XJ+sxJJEE8JHgNKBsYHNJYyDoiUpirjF+cuozm0RgNHQdPw0XnRImvVojwnp/Uwl+bmmKEj29Cdv4xedr2Cmhg3pVrupBILpqDqtaxNhv5+rXerI+jMzLaCQ0cz8G0K3upayZG956jvVIbn4bXrdvxIMugVUL3B66D/+rZ1qAVRKyAO9JUjSrhuJ3fl7iZKjzeYZeQWPdHMWZ2VS0fL/tyq9PJbkZxhBEJEtSQSIWmAgXefjJoDXKdP5ecdn6EX6Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdk5mJu5cG7Vv/UoscgkY4iTYXW2Fe0vJeL74q2dwTM=;
 b=drGg5BRTlH3FMMyQTuO7SwHT2Z/CIABh7kUMyvdb5abEK0R8iOLvtol+H/vsYWGjyqEPW+GWihU2D7JIR3SYoDSc+UkFouNJYsWRxFvYwfWRpxrPS9eAZ2JB5NnICZWdiRHGETlrAqvtWoaRqegglM6BfedOfEeWuspumypZosq1T6Fl0Qilt11i69crWrMNJtGVQejeSwPZ/NlEpEEfFpa9uubbyl6B4whxFdZs41QcwAjDmPY2ocyWmCNumxC7jO/MpDGiqvdNAXEbMiAO+m0vIK7TOIpZLyomyqHA5I2ZhO66og/KjgEEE+arEi7TRI3B/1FYSKxr72EjmvF//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdk5mJu5cG7Vv/UoscgkY4iTYXW2Fe0vJeL74q2dwTM=;
 b=deo5CIQlxtgFxYmslEpgR/ehyatzcgf5ACAfVivgalAvp0J6M9W/KQduMA6HnOMpRNcUpc8DsMqrQumYEyMoQL+w+lKg+t5TGomzJon/9HswHkUvQa3lV/+tBQ+zmcksAoGrn4i4enhiU3vDdlV/Y/t3L1Nur6z/mRKIR9tzLF5C4zUcrfEnBFunl/6ZxipKvCHVElsbe0xE9iX1bcOWCkIeAJEUIH7jsuyZ8qs6cFKXNW5M0YLmu2DvtO3tYjN2h3pPLBkYEKH65Pwz5z+LdSIc6TJyqZYSp04nEHtZAcC3++6VQ48ppyHdRwqHcuLZV2TevtULrtHZmKreRMfxmQ==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by PAVP195MB2233.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:2fe::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Thu, 30 Jan
 2025 09:48:20 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 09:48:20 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: "trini@konsulko.com" <trini@konsulko.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Thread-Topic: [PATCH 1/2] bootstd: Add implementation for bootmeth rauc
Thread-Index: AQHbcmdXnoRY7L0agECSufq6P54vmbMvE18A
Date: Thu, 30 Jan 2025 09:48:19 +0000
Message-ID: <da13999132b06d7891ffc85edfc3147e64cbaa93.camel@phytec.de>
References: <20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de>
 <20250129-wip-bootmeth-rauc-v1-1-6308e732f314@phytec.de>
 <20250129160323.GV1233568@bill-the-cat>
In-Reply-To: <20250129160323.GV1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|PAVP195MB2233:EE_
x-ms-office365-filtering-correlation-id: f1473ebf-f3cd-4637-12cf-08dd41133a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cXMvd1lsTDlDQk9oQ0tTQkdNTmJNdUs3RkRmMG9SWTc2TTluTkVVRUtETG0z?=
 =?utf-8?B?S2REQXE1dHVMU0tyV3pUNlcva0FobW95Y1hXdzFzTS91Q3RmVGdoZ3hMRjhM?=
 =?utf-8?B?a1ZpTDB1S2dYR2o1a3N1bVVXVHBCeldNeU5ocmJ3TURJaEdFZllPRHh4UzZy?=
 =?utf-8?B?WXBUcTdsQStDeml1Wm95WEtYV0ZWb0Vzb3dhcStaVC9jMVg0SzdjcmtGcjVC?=
 =?utf-8?B?T1R0M1ptWXJDcDEyRkc1bTA5SXhTdHB4a0tua0tTOUVNbitockkxaHpiR1R0?=
 =?utf-8?B?ck80L09QZnZvTDk5c25ZWDVlTEVvYmJkYkh4UzFKdER1Q3BSMWVGdW52L1M4?=
 =?utf-8?B?NUpqYldvSjZwWmFCeU0vOEF1RkZDRHFKeXo0SCtJaVJRS1ZuVFUzZlFPTmVT?=
 =?utf-8?B?ZzROOHMwYkQweS9OaFc5Qi95elllZmFZbnYyazFBSXU5RlVVbC9WUVJaa21r?=
 =?utf-8?B?OUk1VG5TRFA2S1lOMlBoanJsQ2N5ZWR1OGFNQ0QxVW1sb0NzU0hrZEY5MW5M?=
 =?utf-8?B?WUQrU1JnMTFVL0pEQUgzY2gzRmFUTnFJYVIxQ0NjeWdrNmViQklYQ0hCdkRR?=
 =?utf-8?B?QkZnWXpoTkpyK0cvdFdCQVgxUTN0SWRDMFl0M3VuTG0zaHhrNERYbk00dXpU?=
 =?utf-8?B?Z0FxK3VWd0hrQlJNaDdoM3BDc0pvdnhWWXhsTmJZVTBaSnNNbTNKRWZ5b2hu?=
 =?utf-8?B?LytudXV0RU5zTlZRcW1mbVlYQUxFWjBpSDdtVWFlRHQvMkQzWFhaRTk5OWh5?=
 =?utf-8?B?VVNaQVNBZ1pvN1IrUjFGRE1zWUFqMS9yKzl6TFQwWlFreGluM0lRZldoK1Nw?=
 =?utf-8?B?MDErUzZRbDRuV2xqVmE0aXhyK0RneUw0M3ZJUEkvMmRMUWk2ZkN5TjBhTnd2?=
 =?utf-8?B?M2tEZmNPUjFjQjhvWUhuZkNiWEtJWG41eHE1SWdnTEdJbzhuKzk4eGgwRnRO?=
 =?utf-8?B?ZHNqU0htRjhkcERDdG1hb0VLQWRmVmhBaGZaSHNQdCtROXZQRG9QQVhXM0Y4?=
 =?utf-8?B?MFZqdjZjV0ZkcWNVVWdiUU1wU2FubDk0emE5akdjN1JZODNLd0RKVlhOQWx2?=
 =?utf-8?B?NFdnbW9UTGgxSEJQeGZhbm9DSnd4SGUvVzNUaTE5TjlWMnpnaG1mNk43N2hT?=
 =?utf-8?B?VnMxNmxEei9JZWtTK29XQlhaM1dJdFdPNS9rYUV2SG8vVk1pZUdGdnRsb3k1?=
 =?utf-8?B?VDZldHVHV2paS2IzbXFmQXV4N2EwZmYveWVIekRKTkZsT1NmejdpakpyQlZl?=
 =?utf-8?B?VGJhTWZlUzdXaHdDZ056c2ZGUnFGUnhaQmtiS2lCSHNXbXVYWVJFTGdBZ1Fa?=
 =?utf-8?B?czk3K0J1MFpiSG92b0FiSW1sNFpEdDR4YjIzaTU1QjNqYnpuQ3R5UjlCWTlm?=
 =?utf-8?B?S0RMbVFPdmtnVjQxQWl6QWhPbG9wMFZqVXY3NVJ4NnowTDRJd3lXS1MrMmNi?=
 =?utf-8?B?TUJyWG9nUVhTWWpxSE9zYkI1cGswMitPeTNaY0J4V2l6K0k5Tzd4bkhYdWxt?=
 =?utf-8?B?bVhxajNkbWdaN2JxYzFFSUhKRjg5a0hjci9OMWJUb2NlWUFsWHo2TEc3cWta?=
 =?utf-8?B?VWNVTytkamNjRE5iOVBGRGF3SDVzcWtlN3JOTGcvcjRDTEN6Ymw5YldlVVFo?=
 =?utf-8?B?cnhycEp4c0pKZXZ5bnVwNTdDR0ZBdkx5TitYQ0hWbU10Z2hNR09nUXhUT0Jy?=
 =?utf-8?B?UXgrL0FoZmZra3MvWlhXNU90RVI2cUh0bUpjOFFWR2ZNa1dFNkxzT084WFJ0?=
 =?utf-8?B?L0JLVG8zU0NwT2thQmh1UVhybU5Ta2tkSGNhVVlZcHltVTVOY01TZHVIVW9W?=
 =?utf-8?B?RHliU0p1RCtLZDNDRnB2VGxmU2ZmRlRNelE5STdNNkVKVXRJMlBXUGM3V0Rr?=
 =?utf-8?Q?rIUY/LXF/Y8qM?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnRuc3pUMzNZYkZXdWtNTkdyZjI4OEh5ZENzeXZqUTQwUkpTSUJRd2xIbzdj?=
 =?utf-8?B?Y2JkcUhaMnRYWWhOUEVFaEtSQkhrSUs2azVzRkljdmRkbzlzcXJrZ2VJakxx?=
 =?utf-8?B?c1k5SmVtdVBqNXNoUnN2L1Y1RHdTeFZ2dXU0NTNETno2TlAyT0dCaVNyWVc3?=
 =?utf-8?B?T2I3MVJnWXM0K2RsQmJ5TzZKVTdRYlN2ckZDVlVBbUl1Nm9JRnl1L1d4Q2lw?=
 =?utf-8?B?clFYcVl6eWtuQWllY1VNZDBWYVV6NW5lam04U2JqS2dMNW05R0N2WkdjUnZD?=
 =?utf-8?B?YzNDQkRvektLZ3NmeTBIMlM4Ti9IYkl6Skp4aFVNUTlVWXorNExodzhRbjJW?=
 =?utf-8?B?bEZvejV3TG03eUpkSExLZzdsVitnb1RhcjhMeVdPa2w2SzBPeUpOa01ZTVVy?=
 =?utf-8?B?bE1CS1gvNWdPY3ZvL1NmVWE1UDlHaEs3SFU4ZFN4YU9zTWNVRXVIL3RCYmRY?=
 =?utf-8?B?MllPRy9hNXA5ZlE2bjk4ZkRSODhnbTMvQ1orVTM3bXlKTEowOGxYMmVyN2dC?=
 =?utf-8?B?S3huYlJxeUdyaThiSkhwdFhCU0hFVHlUbGRpWWV1dHdXbVVrR0JXaHRlRmJV?=
 =?utf-8?B?VHEvNXJkOXR3MUp2NFBlWk1YQktCUUlQWkJYVWZiN3VWUGc3MjkwZmhxd01U?=
 =?utf-8?B?aGxsWEtJMERIRGhjZm9iL1h3VGN6aGE0Z3cvQjdKaGkvWWRQeVE2blhyaFFi?=
 =?utf-8?B?WkR2U0E2b3ZjUVRCZUFUMnV3bVY5NnpNWkxwMnpvM1JZZFAvcURaM2M1QXpB?=
 =?utf-8?B?b0FZanA3dmFvVS9qMFJmMDZLRGpyeTlxYkJQekJCRDY4SFlWNHRxR0lTcXJN?=
 =?utf-8?B?MnlMZVlXdm56TzMzaDdmZGxCMk5RQTErbzlXY3FKOXdEb09yeWVLeExHWTJP?=
 =?utf-8?B?b0xxVXRBYUp2dmYzQ1MxL2tETlg4ZEpLcmpzNWYvNEFCcWxjM2tXbXlMeHhN?=
 =?utf-8?B?c09YWHc2SnF2QUtHOUQyQnVqb3FpZ2hWVVVoOGRkY3ZmSzVIV1p5ZjMwNWVT?=
 =?utf-8?B?L0JPZVRvUFd4Ti91SVBhbmhmNlNXNzNRK2dCOVUrTkhkdGtYKytzM0w4SVF4?=
 =?utf-8?B?UmFvV0lKWWR4UElQZnQ1RkNibWc0WVdIVUp4cmkxNGt4b0cxcTlCRXFuVWJJ?=
 =?utf-8?B?TzNIRzYzRktsUTRyenMxbFlDVUI5OCtZczVpazdMRlFneE5FUVNhTTlmdjRs?=
 =?utf-8?B?VkpaOHBhYnpUeEQrejZSTU50VmMxc3FlK2dVS2NwMVd4cUlOYWNFenFodjQz?=
 =?utf-8?B?ZFRCSW5WK2pqMDRXeXNHdWU1bUFMSGdDUElLRHJlZGVoMm5DbWZrMVAwRnlQ?=
 =?utf-8?B?MWI1ZWVYN29PODhmWnU4VGs2TmFpdE44KzBUaThjMjBvR1ROYVFQZ3lmb0FW?=
 =?utf-8?B?YmgrcmN3dmluV1NBQlRWM0xNdjVNS1kvSG92KzJaWlFnaGJaOUg3ZTVmUWg1?=
 =?utf-8?B?Q0haMzNZMUpkNzFFVEc4bEZDdXE3emIreVI2N1pQNm1QbzdMT3BXOGo3dkE3?=
 =?utf-8?B?d2pCRFQwNU1hd093VkkzSUN2L1FVRGZyTWw4YnlqMHA1cW0xMHBFdjh5enY5?=
 =?utf-8?B?TmhpWFpZQS82N1hTdDhRbnpqMGw0YVBYY1E3MUVnMTY4dk1DcXBLd1gyVURk?=
 =?utf-8?B?RXRSREIrd3JDemVaN3FSN2NkZE9VZkZWSEw0R2puWHVaSFU2eVZGNmUzQXRi?=
 =?utf-8?B?cG9wSHZTQVV4bzRrUGJ0ZzNsZkpkREhkZGgyMGZQUWZGWG0wK3pTY0tNREc2?=
 =?utf-8?B?cUU4TUZaeHdNYjM0OUMvOGF6eEd3UkVRRUhabGtnSkxNbEhma2dKZ0JsTzhS?=
 =?utf-8?B?dFdHd083QjdYWUk4NEJLNnBKejR4VFFybC9OUVdWVXdmVDhySURVZjlkdGNn?=
 =?utf-8?B?Y01OT1NrTHBRdkNFcnhZUWpoYWM0RTY2QThNV0VLSDFHaml3QW1WTlBKaU8r?=
 =?utf-8?B?cFFQcEFqbGsyMUt6UkNMenI2b2crN0svdFlVb1JubU5GZjhIU240OHFpVWZz?=
 =?utf-8?B?RjVHNXE4bk04ZUoxU2cxREZiemNGK2FmR3o2cmRLc0ZEaHBZbEJkZ0RyOTVj?=
 =?utf-8?B?eXE4UGtvaUxGeHZMR3RITUw1cDFRL0dhUGRrcFdqcFZ1MjRRM05SdGNiaTR6?=
 =?utf-8?B?dTk1L1hSNWUyVDMrbE1PejI2NFZ6RHNTM3d1cFU4ZjVKR29JRjRIVUErRXBi?=
 =?utf-8?Q?JR8PJkmMqzgvzRMm/r1RLeiMiFLfbkc3pIr26+ftutFz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF566E93157093429513FD5C5FAE6191@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f1473ebf-f3cd-4637-12cf-08dd41133a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 09:48:19.6531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QUlZk+Z5tpvtIbX/gR9aj7BHTZ9ELy/KUSyzPn6IGhjBg1TmHQPAIRrZN/QqIZNk2YYMazjHj+oguiGPBU8P6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2233
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

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMjU2DQoNCk9uIFdl
ZCwgMjAyNS0wMS0yOSBhdCAxMDowMyAtMDYwMCwgVG9tIFJpbmkgd3JvdGU6DQo+IE9uIFdlZCwg
SmFuIDI5LCAyMDI1IGF0IDAzOjI1OjI1UE0gKzAxMDAsIE1hcnRpbiBTY2h3YW4gd3JvdGU6DQo+
ID4gQWRkIGEgYm9vdG1ldGggZHJpdmVyIHdoaWNoIHN1cHBvcnRzIGJvb3RpbmcgQS9CIHN5c3Rl
bSB3aXRoIFJBVUMNCj4gPiBhcw0KPiA+IHRoZWlyIHVwZGF0ZSBjbGllbnQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogTWFydGluIFNjaHdhbiA8bS5zY2h3YW5AcGh5dGVjLmRlPg0KPiA+IC0t
LQ0KPiA+IMKgYm9vdC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTEgKysNCj4gPiDCoGJv
b3QvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gPiDCoGJvb3QvYm9vdG1ldGhf
cmF1Yy5jIHwgNDA4DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDQyMCBpbnNlcnRpb25zKCspDQo+
IA0KPiBJJ20gY3VyaW91cywgd2hhdCB3b3VsZCBiZSByZXF1aXJlZCB0byBoYXZlIHRoaXMgd29y
ayBmb3IgYW55IGJsb2NrDQo+IGRldmljZSwgcmF0aGVyIHRoYW4ganVzdCAibW1jIiA/IEp1c3Qg
YSBsYWNrIG9mIHRpbWUgLyB0ZXN0aW5nIC8gdGhpcw0KPiBpcw0KPiB2MSBhbmQgdGhhdCdzIGEg
ZnV0dXJlIGlkZWE/IE9yIGlzIHRoZXJlIHNvbWV0aGluZyBtb3JlIGZ1bmRhbWVudGFsDQo+IHJl
cXVpcmVkIHdpdGhpbiBib290c3RkL2Jvb3RtZXRocyA/IFRoYW5rcyENCj4gDQoNCkJlc2lkZXMg
TU1DLCBSQVVDIHN1cHBvcnRzIHVwZGF0aW5nIFNTRHMgYW5kIHJhdyBOQU5EIGZsYXNoIFsxXS4N
Cg0KSSBndWVzcyB0aGVyZSBzaG91bGQgYmUgdmVyeSBsaXR0bGUgdG8gbm8gYWRqdXN0bWVudHMg
bmVjZXNzYXJ5IHRvDQpzdXBwb3J0IFNTRHMgKHByb2JhYmx5IG9ubHkgYWRqdXN0IGNoZWNrcyku
DQoNCkZvciByYXcgTkFORCBmbGFzaCBhbmQgdXNpbmcgVUJJIHZvbHVtZXMsIHRoaXMgd291bGQg
cmVxdWlyZSBzb21lDQphZGRpdGlvbmFsIGNvZGUgY2FsbGluZyB0aGUgY29ycmVjdCByZWFkIG9w
ZXJhdGlvbnMsIGJ1dCBpcyBkZWZpbml0ZWx5DQpwb3NzaWJsZS4gSSBkaWQgbm90IGltcGxlbWVu
dCBpdCB5ZXQgYmVjYXVzZSBvZiBsYWNrIG9mIHRpbWUgYW5kDQp2ZXJpZmljYXRpb24sIGFzIHlv
dSBjb3JyZWN0bHkgZ3Vlc3NlZC4NCg0KTmV0d29yayBkZXZpY2VzIGFyZSBub3Qgc3VwcG9ydGVk
IGZvciBvYnZpb3VzIHJlYXNvbnMuDQoNClJlZ2FyZHMsDQpNYXJ0aW4NCg0KWzFdOg0KaHR0cHM6
Ly9yYXVjLnJlYWR0aGVkb2NzLmlvL2VuL2xhdGVzdC9pbnRlZ3JhdGlvbi5odG1sI3BhcnRpdGlv
bmluZy15b3VyLWRldmljZQ0KLS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0NCg0KaVFGSEJB
RUJDQUF4RmlFRXZSVlZDMU41R29VV2s5SXJEUUl1d1FLZUQ0SUZBbWViU3VJVEhHMHVjMk5vZDJG
dQ0KUUhCb2VYUmxZeTVrWlFBS0NSQU5BaTdCQXA0UGdvaXVCLzBRWVByS3JwbysxZXYrUHVLRHd0
MjgxMXpyMG5QOQ0KMEhVbXo0TnY1NkNKajhRYzlTNE5MMnl5WXJIZ0ZBUTB4UGN1WWVtMjBORVpa
WWNjdEt6WDVwWXJ0dTR2WU9CbQ0KV1Vzb2oxKzNUVkliUStjMmkvNE51S0JQQWdzYWQxd1pjUVkw
NGNUcnRBWHpCV3pOeEk1NmtHUDBQZkxZVjRscw0KL08veEYwUWFtbmpYUVJ0SFVydjRrUU9ucWkr
UkJ2UUl4RDdJQ1ovN29pTmZWNHZLN2hVOFZ1N1Rub09TWktDRw0KcU5yNXpuWFpnVDhheExTZGtF
OVZqWDJJd3BUbStpaHVEZTk0L0JyTGc0RS81NHlCQmNmS3dQZVlzekZ5RG9YVg0KbzhITmQxZXlU
MTM3QjllM0VISzJQQzJoVmhjNUMvMVY2UktHMFNSSTFiVFRyZFlObFNMMHJmY2kNCj1nUGlzDQot
LS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0NCg==
