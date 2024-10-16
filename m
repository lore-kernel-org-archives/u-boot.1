Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD986D2069E
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 06:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34E9888CA1;
	Wed, 16 Oct 2024 08:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0RPEZTFX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DACD88B86; Wed, 16 Oct 2024 08:33:35 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47B488B0C
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 08:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qz3NtVgef2uxVyUexM6Erjr5SXd5JK+Ax2bXL3zaxzV9u37xvO3HUGEaJVd/g+GRKlFHCB8Xm0widsYly5IFQVJLRas9IvPYevXXgpzpUwCVmnxNqcCpOeK5RePERMW43XQQ5FJDIJRVBy/hvvC95tzCP8hsDMofkc8qdBGN/iKojLaE7Il4zcertKuLAIa+P9YnRxL+v3QwL9d1XxB0jieN6UAAlcD8t/8uHzr2KWGX3b7AHOOePFukkqATWWsIcJYmthfgKz+PkLAlydhjvr86GO9GD93iCMVVCLJvQse6glpewpSu2QPz+KH5oSE7bFBOhVZFusCIsi0+Rn74PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9l6crd2pOomkPoXLwqkgwCD8InevU43G3EhO2Kxe+c=;
 b=YoQFn1t+z7FR4gzrHx+gki4hxUQTC2ofw6xKi9IQlrAlYxqnMpbAE6a+mNIuR3hvbQQPEi3H5HVORU20J2xU2smtZLDcwgN8RhX4ZjuktlmJaK9pczfuq94yMTaCQjo3Wc6QhqybdIxG9rg+h49UjpGNVV0cCwKrz8Iou+rFXuFbeJ0oUJEb+jDvIMzGrkav6c49kEn4/33tLQMhzoPdiGaMRN+VzbBfrfmQp+BGSSNABPnsmU5pQvYOd5eXi0lPA9xU/JRJx8BDG6lW/tW0WkXnsDNop32HYTYY63OXMIGLwF3CqMgd5MM1pqN78UINBGBBNWQGSgDQ7sdk6SaX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9l6crd2pOomkPoXLwqkgwCD8InevU43G3EhO2Kxe+c=;
 b=0RPEZTFXLr7aPfVMGtMa4MuMBgavi/zn7YGuy6RzutKT74yLucAqEQld5y6v55T7mehYu6a6J59WNkLG8OVX04DKy3uISRpCId5jQRMlAvkdTNLbKUPVptwv9p4TfPmps5weOWbEBn2s/u1jLR+vbaWoPyEuT2OUhaTV8H+ZAlY=
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Wed, 16 Oct
 2024 06:33:28 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 06:33:27 +0000
From: "Kumar, Love" <love.kumar@amd.com>
To: Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>
CC: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: Fix test dependency on ext4write command
Thread-Topic: [PATCH] usb: Fix test dependency on ext4write command
Thread-Index: AQHbHw0FJOmZ56FX6kiY6whle6S02bKH804AgAD4YRo=
Date: Wed, 16 Oct 2024 06:33:27 +0000
Message-ID: <PH7PR12MB65388EF5AFC0FC77B30DDCDE83462@PH7PR12MB6538.namprd12.prod.outlook.com>
References: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
 <f2859286-0e58-4373-b5ff-7121da452ddb@denx.de>
In-Reply-To: <f2859286-0e58-4373-b5ff-7121da452ddb@denx.de>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6538:EE_|IA1PR12MB8360:EE_
x-ms-office365-filtering-correlation-id: b55d095e-fcdf-4985-d8cb-08dcedac71ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WDNuVzFiUkFHUVZJbXFSUUxlVHVTR056QTZIMFJlL3BPaHR4Y1JQTTBKTEpz?=
 =?utf-8?B?YXBWZmRGaTFmTndTMEtZeWFvSERjYXNFYnRtRmRMb3BBUEN2dmdYM3hwL1M1?=
 =?utf-8?B?bmJTV3JFd2R0QWZQUkJ5RHNNZGptSVFBRmVpVG1Ba0FkTng2YzVjRCt4MGVx?=
 =?utf-8?B?VVI5TEkvcXU5TU9Sb3NpTVpFMVQwTFhRUktVcUFwZXdzUHJpRTE0eDR0TXg1?=
 =?utf-8?B?S1BYSm1TRkg0V3B1UkNPY2xLSStqVjZmcjJnWXBJU2pHbEJLSHY0K0E0Nk1a?=
 =?utf-8?B?ZkV5b2hZNlh4NmkxZS90Um53UkF5QThiOUVqb1JyRlhYWDQ4WmgrajAwdVhp?=
 =?utf-8?B?Vzc3ZnpEemI4d0tPalk3bzRhSjhHdVd1Y3hGYXcvTVM0VXprb3J1Y0p5Y3ZF?=
 =?utf-8?B?VGtyM3RwQkh2WEJLWjFkQ3hsVEU0azhhM3BGUndDMFhOQ2kyZUNrNXpldjQw?=
 =?utf-8?B?WVN3Y0oveWRuY1l2VWlUV3JlWjVCRUpST0U0Y3NmcTFRSU1UUjl1UjRSdStX?=
 =?utf-8?B?SnZiaEVsRGc2SHUwMW43NXlvZkZmc0xRaUx2VWI5a0ozYUNkZjJBVUZMZURp?=
 =?utf-8?B?SDFZVnJ0REZtdHlHZ3gxZnM0L3lLZmlzREtDcDh2Nmo4OEE0dzhpU24vRkFr?=
 =?utf-8?B?SW5BelM3ZDhHbVgrYzkxV25IMURuS2VRVk5WQVdBY2lySmtRSTZVVUZaWXB0?=
 =?utf-8?B?UklTN2NkTzYxT0Y3TEkrRklyRyt0V3BRZ3B0ZGUxL0wwaEc0T2h2eC91L1d1?=
 =?utf-8?B?MEoxRzRTb2NJYmlZd3B3MEx0dVF6dy9WQVNLbXBOakhLVVZpZVhWbXRiZnZy?=
 =?utf-8?B?SXVDd013VFdtdUtJWlNBK01IMTF5ZStIay9GK05admxoZFNVMWRCcENwWFlK?=
 =?utf-8?B?TEZyKzI5TXIvM0psaHlXU0hteVRBZ2Q1MVpEQnlUM0lhZXhGa2tZTm9Yam1n?=
 =?utf-8?B?TkhlZDBabXB2MDRtZW5YY0pEdElTbVJXTWVUTkJ1dVRqaWJYZGVCb2pNUVV2?=
 =?utf-8?B?SDQ5S3R3d04zUi9MaVhxaWhtalNTSlV0K0ZuZTN1V2tsTmRvL3FMUTY3Qzh3?=
 =?utf-8?B?Uit3a05jLytaL28yeHNBTG9wQmRMTGkvc29wMW1pQ0lpUC94dDVuLzlDcUZl?=
 =?utf-8?B?RVFHZExyVzQ0ZlJwNk94dkVMMnB4dDlPQWRkZUI3TFFpZXZRcmloL3MvRzRU?=
 =?utf-8?B?VXBldkp5N1diYy91enY5amJpMjNrNndzTFhKL0dkdFplNlNrc1BBRzJEZXlZ?=
 =?utf-8?B?UlJSU3VFT2UzQnNoRmhhMDZLZUJPbytCd3Z4Y0gxT3Irdk52ZnJxcW0wZFlm?=
 =?utf-8?B?K3pqa0tVWFMwcVFMbGNQeVZCbTFBOUNJVExxZExaMTI3NUptbitZdTA0ZDU0?=
 =?utf-8?B?Tmh6YVFLYWF1QUZvUmZUSDVnekU5Q2N1UXY0WTh6SjlKYmI2S0t4WUM5T0VD?=
 =?utf-8?B?U2pvemdtdnQ1QmlncnBqaU56dUZSdi8rV0VRT0tPSVo4QzBoMndtNXVTcFJl?=
 =?utf-8?B?MXZ3S0ljenRNUmo5cisxRTVITjlCN1VqUjhsNUo3c2VHQ2FFbktsMWZjRlR2?=
 =?utf-8?B?b1pneTJRR2Q5N0E3V2Yva21IYTllWTlxOE4vdi9RenhxbUpTNjhlbXNTZ3cr?=
 =?utf-8?B?Y3VsNXlpVGdsbm1YaDZXc2VSRDlWUEpTV0h1R0M0cDNhbklnaElOa1IvRTZS?=
 =?utf-8?B?YzIxWUxCcWVHdUUzTXVhL0FhS1pMUXZzQTZPb1dzbi92RDFHM1RqVGlIU0pC?=
 =?utf-8?B?dGV5RzhSdDR0ek1UTUpKbGlxVFE1MDE4bkN3c3Q0YUFSZzFBc3ZLbkk5WlZE?=
 =?utf-8?B?LzV6V0xaMExMNE5xeEJGQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWZLWHJVc2FPYldjMmtpd1QyRE1nSCs1ZlNjbzN2UnNTMG9DOFkwUFJHNFVH?=
 =?utf-8?B?QjlMRWpwYmhFUjNrOXltNC9rMzVkQ0F6dlVlRURuaXFmQThkNWx5d0E5UzYz?=
 =?utf-8?B?YmNTQStuaDZzbEFuclRCK2dFTGtSRkpHNVR3R1pXcDdQbnJLbnhWNWQ5Wk9M?=
 =?utf-8?B?RDJmeHRwdUQrOU80cWUwS3kvQTZiQ1Myc0xQWk9ycVRRbE8vZk1QS0NwdzNV?=
 =?utf-8?B?ajE4cDRWcitIZWtDWm1LR2drb0FKa1k3RUpwN1V4Q2lRYW1PVDFsY3VWUjY5?=
 =?utf-8?B?NUJtT2prQWFVWmdvNXo5YlFuWWhpdTFMS2lYWm9JNkRheDNPVWkzNFZFYW1s?=
 =?utf-8?B?b2p4L0xpYlNxS0FBdGI4VzRSOUhLczd4MS9JVkoxUGtDdjlGcXRrSVFCWXh1?=
 =?utf-8?B?T2k0KzRRMlNIZFRPWG9aWDRVV3p1ZGdkbWZ3dW9rZDFxMkFtVG00UmlGTVdX?=
 =?utf-8?B?Tm5FM0dHMGU1cVlraU8wdVFXTlh6cXRCODl4dUl2UHBXRTJscjI3S1VoRUVM?=
 =?utf-8?B?WFlNQUZvT3dMUlhjQXdTTDlvUi9ySW5CMXBLWDZLbzBncTc0Z3p3bTE5L3B1?=
 =?utf-8?B?ZTRsVE1IaURUUGExR05ubG5tSWdrWVNwdm9TWG9LeHJ6Uy9VN243bTZvS2xT?=
 =?utf-8?B?UUpuSkxKU0MzdTZwMXE5ZnRXS1F5UTJkZ0tzOVZTTWdyemFFOXRzN0JDNjY3?=
 =?utf-8?B?RDcrNksxeXJpcDUxQXBWeFN3QnZ6VCtuYTB0VWJiRjVGM3Z4UnVkaExoRWls?=
 =?utf-8?B?ejdUdXFXQkVuNnlBaXlDM3BkMEx1SFlpdXZaNHpPalQ4NWUyUHZET200U3BI?=
 =?utf-8?B?TXZ3anNCNUNtVlJKMFExNEZRenE4UmxWczJJZmd2T1BQazBCYWpRTnZENyts?=
 =?utf-8?B?N1RhZ2s3WVN1TFk4TVBWVnhiUWFDM3RzTUNwLytLRVBwMjBIa1phWXYwcDVr?=
 =?utf-8?B?SUsya0FFWklBNXBlQkl2SFR6SEdCTnVHRmFOVXhWUFZ5N0hqUjVaaFhkeXJw?=
 =?utf-8?B?YmRCeUdtaW9UMVpqMTF6UlpTMFNoVG5qMW1LSFNrT2ZoK0h1VUlEU20wdVNi?=
 =?utf-8?B?OGw0TlZ2RnE1cGx3L1ZYcm1tNXFzdml5eVZ5c3NuaEZaUUVqcGh1ZjJKdVRN?=
 =?utf-8?B?cis3N1YzNUFFNWxHcHR3WmdnQytKei9TVGI2a2lra2dCbllxQXVmYjBacUJH?=
 =?utf-8?B?RWtjQzhwK2VGUmJlT3FWTHN4TSszdU93VjBWaTB6QkUyTzJKWG9wblJWSmJ2?=
 =?utf-8?B?THcwbTVRcUxxMlkraDVVekJjanlFS1hLRnZrWnFnVXZpTkwrOUJybG5Wamdz?=
 =?utf-8?B?V1dpMkE5d1hCYWZKMHVuTUhmbmQ2YmNEejRaT1Zja2RXTmlXS3VadG5SQTln?=
 =?utf-8?B?MUxvbldTUTJTSDd3bW5NQlpsUVpJMDcxaUE3cEhwNEpvcGVJeDMwOU02aWp3?=
 =?utf-8?B?VkhWeWF6U1hub3FnT3J3VnBXS0d3VmdkeDFYYXhSR3gvUEI4YTdsZzV6MUpO?=
 =?utf-8?B?OS9GMDl5dFIvdVBWR1J3M1ZuMXI0Qkd0RGZqbGJVRFlmSDNvdUlGYktNVXd1?=
 =?utf-8?B?L284TURwdGk0Sm5tV0hUSUtSUUlVZ0F5VEZBMnFQT2Jkem9FbDdOWGZJc0Jm?=
 =?utf-8?B?bkhLYXIzeTM1aUdwTGVVaXpmcHNGUUViUEhydjJwZHM2UUZKVVl0VDY1SERn?=
 =?utf-8?B?dm94QUJtMWd0SCtjZGRPUW9wRnFPQ3Z5bFpYQ2JXRi9iWDNiUUNxem14d0ZL?=
 =?utf-8?B?Uitua1FISVU2QnRsU0RDajlLRkF5clVhMldEWXl2YkloaWsxRmt2bXEycFVU?=
 =?utf-8?B?amtOK2NxT3VrQlY4akVwWmFBTjFVT3EycTRjdUpFTVZnU05HM2YwekFTd0U0?=
 =?utf-8?B?V2xUcEhiZlFQNFJXaksrMEw0RjljMDJZT3NTMk1lWGdybVpsNWFOWGZ3WGNq?=
 =?utf-8?B?MkJWYldQZGZqSWxLNlNxZ09QNWNEbm95dWprY1htUG5tSUpGL2gyQmVmaTZk?=
 =?utf-8?B?TEl0dDc4bFMyWEJHQ2RUeDlKZTJnV3FOUmRpMDUreWFzQmR4a3k5ZEd0OG5s?=
 =?utf-8?B?NDkvUE1NU2JQOTNocFA1VDhhYWJhanNpY00rRCtyVmRPb3F6M1FpbDVBSlYx?=
 =?utf-8?Q?DeKARZG0o+M7SUgoKPvOVSYB/?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55d095e-fcdf-4985-d8cb-08dcedac71ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 06:33:27.6937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmWAHRWGwYZ8SrrhOFBXphnWunoafVZ+tmeUcIkv6fm2XobSMrieZoq1UBibQPCX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

UmV2aWV3ZWQtYnk6IExvdmUgS3VtYXIgPGxvdmUua3VtYXJAYW1kLmNvbT4NCg0KT24gMTUvMTAv
MjQsIDEwOjI14oCvUE0sIE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPiB3cm90ZToNCg0KT24g
MTAvMTUvMjQgNDoxNyBQTSwgQW5kcmV3IEdvb2Rib2R5IHdyb3RlOg0KPiBUaGUgdGVzdHMgdGVz
dF91c2JfZXh0NGxvYWRfZXh0NHdyaXRlLCB0ZXN0X3VzYl9leHQybG9hZCBhbmQNCj4gdGVzdF91
c2JfbG9hZCBkZXBlbmQgb24gdGhlIGNvbW1hbmQgZXh0NHdyaXRlIGJlaW5nIHByZXNlbnQgbm90
IGp1c3QNCj4gdGhlIGZlYXR1cmUgb2YgYmVpbmcgYWJsZSB0byB3cml0ZSB0byBhbiBleHQ0IGZp
bGUgc3lzdGVtLiBTbyB1cGRhdGUNCj4gdGhlaXIgZGVwZW5kZW5jaWVzIHRvIGluY2x1ZGUgdGhl
IGV4dDR3cml0ZSBjb21tYW5kIGl0c2VsZi4gVGhpcyB3aWxsDQo+IHByZXZlbnQgc3B1cmlvdXMg
dGVzdCBmYWlsdXJlcyB3aGVuIHJ1bm5pbmcgdGhlIFVTQiB0ZXN0cyBhZ2FpbnN0IFVTQg0KPiBz
dG9yYWdlIHdpdGggYW4gZXh0Mi9leHQ0IHBhcnRpdGlvbiBidXQgbm8gZXh0NHdyaXRlIGNvbW1h
bmQgYXZhaWxhYmxlLg0KPg0KPiBGaXhlczogMWM1YjZlZGFkMzgxICgidGVzdC9weTogdXNiOiBB
ZGQgdGVzdHMgZm9yIFVTQiBkZXZpY2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgR29vZGJv
ZHkgPGFuZHJldy5nb29kYm9keUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4NCj4gICB0ZXN0L3B5L3Rl
c3RzL3Rlc3RfdXNiLnB5IHwgNSArKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS90ZXN0L3B5L3Rlc3RzL3Rl
c3RfdXNiLnB5IGIvdGVzdC9weS90ZXN0cy90ZXN0X3VzYi5weQ0KPiBpbmRleCBmYjNkMjBmMDgy
Li5iODZmYzI5MGM3IDEwMDY0NA0KPiAtLS0gYS90ZXN0L3B5L3Rlc3RzL3Rlc3RfdXNiLnB5DQo+
ICsrKyBiL3Rlc3QvcHkvdGVzdHMvdGVzdF91c2IucHkNCj4gQEAgLTM4Miw3ICszODIsNyBAQCBk
ZWYgdGVzdF91c2JfZXh0NGxzKHVfYm9vdF9jb25zb2xlKToNCj4NCj4gICBAcHl0ZXN0Lm1hcmsu
YnVpbGRjb25maWdzcGVjKCdjbWRfdXNiJykNCj4gICBAcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdz
cGVjKCdjbWRfZXh0NCcpDQo+IC1AcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdzcGVjKCdleHQ0X3dy
aXRlJykNCj4gK0BweXRlc3QubWFyay5idWlsZGNvbmZpZ3NwZWMoJ2NtZF9leHQ0X3dyaXRlJykN
Cj4gICBAcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdzcGVjKCdjbWRfbWVtb3J5JykNCj4gICBkZWYg
dGVzdF91c2JfZXh0NGxvYWRfZXh0NHdyaXRlKHVfYm9vdF9jb25zb2xlKToNCj4gICAgICAgZGV2
aWNlcywgY29udHJvbGxlcnMsIHN0b3JhZ2VfZGV2aWNlID0gdGVzdF91c2JfcGFydCh1X2Jvb3Rf
Y29uc29sZSkNCj4gQEAgLTQ2OSw3ICs0NjksNyBAQCBkZWYgdGVzdF91c2JfZXh0MmxzKHVfYm9v
dF9jb25zb2xlKToNCj4gICBAcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdzcGVjKCdjbWRfdXNiJykN
Cj4gICBAcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdzcGVjKCdjbWRfZXh0MicpDQo+ICAgQHB5dGVz
dC5tYXJrLmJ1aWxkY29uZmlnc3BlYygnY21kX2V4dDQnKQ0KPiAtQHB5dGVzdC5tYXJrLmJ1aWxk
Y29uZmlnc3BlYygnZXh0NF93cml0ZScpDQo+ICtAcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdzcGVj
KCdjbWRfZXh0NF93cml0ZScpDQo+ICAgQHB5dGVzdC5tYXJrLmJ1aWxkY29uZmlnc3BlYygnY21k
X21lbW9yeScpDQo+ICAgZGVmIHRlc3RfdXNiX2V4dDJsb2FkKHVfYm9vdF9jb25zb2xlKToNCj4g
ICAgICAgZGV2aWNlcywgY29udHJvbGxlcnMsIHN0b3JhZ2VfZGV2aWNlID0gdGVzdF91c2JfcGFy
dCh1X2Jvb3RfY29uc29sZSkNCj4gQEAgLTU0Myw2ICs1NDMsNyBAQCBkZWYgdGVzdF91c2JfbHMo
dV9ib290X2NvbnNvbGUpOg0KPiAgICAgICAgICAgcHl0ZXN0LnNraXAoJ05vIHBhcnRpdGlvbiBk
ZXRlY3RlZCcpDQo+DQo+ICAgQHB5dGVzdC5tYXJrLmJ1aWxkY29uZmlnc3BlYygnY21kX3VzYicp
DQo+ICtAcHl0ZXN0Lm1hcmsuYnVpbGRjb25maWdzcGVjKCdjbWRfZXh0NF93cml0ZScpDQo+ICAg
QHB5dGVzdC5tYXJrLmJ1aWxkY29uZmlnc3BlYygnY21kX2ZzX2dlbmVyaWMnKQ0KPiAgIGRlZiB0
ZXN0X3VzYl9sb2FkKHVfYm9vdF9jb25zb2xlKToNCj4gICAgICAgZGV2aWNlcywgY29udHJvbGxl
cnMsIHN0b3JhZ2VfZGV2aWNlID0gdGVzdF91c2JfcGFydCh1X2Jvb3RfY29uc29sZSkNCg0KK0ND
IHRlc3QgZXhwZXJ0IFNpbW9uDQo=
