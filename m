Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1E9D2E9E2
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AA458932A;
	Mon, 11 Nov 2024 13:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="OSNRGvUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78248919A; Mon, 11 Nov 2024 13:08:05 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38EA8932A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:08:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtDqGS5YCXhPYONFRlxkp/skjhYttBaQNQsvtxt1Z659uCxZVShX5Ni+V7U9ovMz3I4TeYR7wnlNLFSvZlCD5Hxh1vy3x5KezvM1bkOdOa29FcfauremknJU+YTUDCakue9Ga9DBwdUq468ntDUAPW+3J9ETb3gsawAMEa2mqq2zHQJzGvfZ5MRUKaipL7zm4r+7GiRlmXrLizW1kAA61Nu1rdVcRPesbStUb1QD6FRG/nrrwDaoAS4VHlN+l+4w+BWDG6EV4wImiFNkcx6r8qN22PnPHnLJXkGkqqU7b1tbNcnpuVzlDz2fQMdqbHWyIeL+UItQBu2JjPmlNBRKHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePjDnxEdHZMyMxmTrsIXByH4l4ZRGtw0CDex+Ka/MWM=;
 b=dqpXxVsPmlMj3fFAYi4h/KpHF1hMIMG7PWj4GS4/8OJoU6N2CJGDmxhAUrZ7eymwJCnmdICBhE0JkSfbBT9YdHXI7EpzbKRSsiy5l2ACOJqQaTY4IZJfqO4ihoYLGwVVZWDWMuRNidjZAMSbnr8fqqTGYEqcaBJHAgzDUFiBIopyq9nTXSrIF+qu/e/RzePfwED+WhprsYLPwMVIFD9esqwZrJ+79QiWW9xmomNWtwk1fnQ9LnXhJOJiQ7JP2YeLZ9wZH6sqmkl0q9gEeQhIfaEsmYCCJAHosV3erlrpSk0DIsWCAG0F1v6JwnJ173CtuzFBPhfbl5AMHWN7bO5F4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePjDnxEdHZMyMxmTrsIXByH4l4ZRGtw0CDex+Ka/MWM=;
 b=OSNRGvUGVFZimSX7QqomElGlyLtMqJUIYz4ZQoppc9KB/ATDbfs+ijioyCiIfZkGXPPEEqoPY9I+DkcjFxOL5vA7wWqHweTHIg5RYp2klAozNXR2sDwwHIU3iYgL4zbHGO+761oCr+iVrh7xX2WhPHRqTIFTPN7hzh/uqYBlFqqD5+wwDIWw16E+oKZ3jop3ZndnGGxG0NnQFFIQ9tEe3tiPrT6esH4JVAd1sG35UOtWgRsysWE1VsPBx5QZO0qMfDZGsCiFBLzfFaEC1TvRijLYwKZr4JvlRGiWUlS9xOJ0/kHr8L5wP4kIw+omPBuPVmOT+4WHO2PwIBVPHK4Gfw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWPR10MB6831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.14; Mon, 11 Nov
 2024 12:08:01 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 12:08:01 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "festevam@gmail.com" <festevam@gmail.com>,
 "Leto, Enrico" <enrico.leto@siemens.com>
CC: "agust@denx.de" <agust@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Topic: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Index: AQHbMZ4q6Xvo8cei1UOJNXJECsAWV7Ku23YAgAK9HACAACq9AIAABi8AgAA3+QA=
Date: Mon, 11 Nov 2024 12:08:01 +0000
Message-ID: <77fda84f01f333d6e390b46b52c9e47211cf739f.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-16-hs@denx.de>
 <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
 <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
 <DB8PR10MB3737C4C148FDD4045198C460FF582@DB8PR10MB3737.EURPRD10.PROD.OUTLOOK.COM>
 <faee8636-da5a-f990-f506-e8bf1d975078@denx.de>
In-Reply-To: <faee8636-da5a-f990-f506-e8bf1d975078@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWPR10MB6831:EE_
x-ms-office365-filtering-correlation-id: 0b216742-ff3a-4b5c-12ea-08dd02497d87
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TTRBbEVkVjluTDBUWm9uVzVHYWQvdkRWU1ZBY0xGQmNicERnUXcySFllWXR5?=
 =?utf-8?B?UjV2bmpyZUJlOStvUmZhRnA4bXU2M2djQm90dkNyQVlNcG0vSWlmZXhXbVJK?=
 =?utf-8?B?aUE1djMyOW9FMzEyK0xRb2QvMkVTT2JpZU1GM25tMjlYdmNlM1JQeDZkN28y?=
 =?utf-8?B?Mk5ZK0FKaUYvV0MvbXYvMUtOU2VRVzBlMjlKeWsrQ0Mxd1lyZTNoNDVxQjE3?=
 =?utf-8?B?ZXJZQzgvNUd4Q01iLzJNT20xOEUzTXVDeU44YXVST3JucWY4KzdGcWJLdElu?=
 =?utf-8?B?TWIwdGJZeGlDT01ZOWdTdE9wZ3oxemRXWUd3YzEvVDdBeWZueTJuNmN6dklv?=
 =?utf-8?B?dWNQVm1NL1FCdGdxRStWaTZUWDRJQ1cxTGp4YVU1OHRDY2xITHp2VFdLeXN1?=
 =?utf-8?B?M3JlVE5UdGJ3Z3ZCN0dyTlB6R0NqMlYxcUVRMSs0R01XUkVqTC9ZTXlGWndO?=
 =?utf-8?B?OTFEUmNzREJFMExxMnFkN0c3Y1A5WktXd2JlL3Zqc3VLbVVETERNYytuVkhM?=
 =?utf-8?B?NmtJdzMxbnRrK0xEcitMbUJNeWRQd2RuWDMwT2JDMXBiVVk2am1tTXJMaHhs?=
 =?utf-8?B?S3N2Wkk1TjdoYS9TK2NXZmxXYi96c3N6K3JSMlh0eUozN3F5MEJXN0pwZXNw?=
 =?utf-8?B?MUpFRG5SZWsrUlRWcitGNTluMXJSaXVQaE5kc2hSWXB0MmVwL3NqZ1BibkNI?=
 =?utf-8?B?TXhOdHZsSDlrNVpObDRlMmxFNVRJR3E4T21kTVg1eGxYaXRtZUk0OGh3bVFG?=
 =?utf-8?B?RjJ1dnp6L1VPUjhQRmJWTjBuZXZVU1ZnZ0FmTnNRWi9hd0hqRjJEOEZSOWM4?=
 =?utf-8?B?d1FVMlBKbkJWMnIvaExqdk0wd2JCOVE1bVJDZFc5d3lQK09PNzEvaTVGWFo1?=
 =?utf-8?B?ZVhnK3ZpcmdrZnJaRyt6U2xXYUFrRW1VU05oRisvWXFKZ1NVNUVNYmFuNVVZ?=
 =?utf-8?B?c0kxV1dGZTJLT080Z011UXJGdlJPQ0lGWUFCMkdoVmJ5VXc2WGtsV0tlTnNz?=
 =?utf-8?B?ZW1RK2RvNzZvQU1lNytXMmtzQVI1SGdhb1dVZnY4c09yV0xNVEhmZHNUbFc5?=
 =?utf-8?B?b2NrdnlIZitGM0pmNm1MUUZ4ekFzSVhsKysreDdoQmJ5dTlFNU9tOVdyNW9T?=
 =?utf-8?B?c2pzdG5pZFNSL1RTaG00aHhUdjF1Vm1DSGk1Ujd4NE1JRVEyN3lJRWlZemZ3?=
 =?utf-8?B?OGJPSGV2OFNvcC9paTNYelVSSUFBU2JvOGFIY3BLNUlENTZiS3lNM3JWVGIz?=
 =?utf-8?B?am5VTkh5OXVWOHNjcG0vRmp2dFBpNDRIK2prb05rK1UvLytXZUtmQjlvT0hP?=
 =?utf-8?B?Z2Q5RnhpNDV5ejVXa2VxS3J1VjRLY1hCR1JYUS9yekdJN254SkJzU1N5RHYw?=
 =?utf-8?B?ZXBXaDc0d0RScElXVkFUU1RtWTAwRUN4SkdhcVl4YmJONGIrSkR6bXZXdytR?=
 =?utf-8?B?SEVsWUJkUVZPL2xZMHg3aHhRYVlpV0E4cjZBRlRYMW9YVzVFUnk1Sy9EMmph?=
 =?utf-8?B?ZllJTkFia3RmaXBDL28yd2JVYkFXeVlaVlJOY1pBZXZOWWEwNXovN3M5N1JI?=
 =?utf-8?B?VkNibmFqUStkRmdJZklDcGxSSGpkU3F6eTFrQzVaZVoyWkFxeG8wTzFZQnRB?=
 =?utf-8?B?UVVhM0did2xiV3o3MWQvbWYySnFLSnNCRHdYZHhmTlppLzBXMmd6SWZEdWd4?=
 =?utf-8?B?R0VSMTBhWXFiYXVqK2NxS2JNWTJtMnhPZjJJaENCWkdnaG9OU1p3Z1ZwSTFu?=
 =?utf-8?B?eGRYRFo2d01odmRJS0xFa0U2RWJmMk5zYXM0RFZQemRRc09yaHArdHgwUE1u?=
 =?utf-8?B?cDNOM2YwSCt2MEdCRmludz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk94QndiWUVGY3lYbHFaT2Y3aDAvRmlZbVVVV1JNRkNWbGpXWmFyZWFhMGND?=
 =?utf-8?B?dU05OElVRy9iOUNhSFJBdmp0WHFObTM1RXhzUkoyOGNiWWV6TGxTeWhyVity?=
 =?utf-8?B?SW1WVnZHbENYVW1kM0lRdXMyTnBlakdCdWxhMFQyYUlUbjdpZFh4UkFsZ2s1?=
 =?utf-8?B?cFlPcHIwSnpML1duT1IzaUdVT2dMSkNHSFlBMkFUbUVPOUZRYXNNaldIR1ox?=
 =?utf-8?B?SFpNdHB1QThEYStsbGxveEdzM3FhSUY3bnFROTRTOUcralV1c1dzYnZvN05D?=
 =?utf-8?B?Vjhwd1hSdDhpMUl5YlQyMlZPY08rZUlkRmZiSkJiOFZIbnRNUlp1NHFFNThH?=
 =?utf-8?B?SHR5R3czNGRBMGFDSkY0TGJnaHZaVCtPYm9aSTl3TkpQVjRUQ2wxZERqUlYr?=
 =?utf-8?B?ZGp0SHltbWFKeHZJdXZPV0xEcmxCUVppM3h6VEdIYjFlL2pTYkVhUEQ2OGkx?=
 =?utf-8?B?K2ZrRG1yd3dtdzJpdEhIRGM3SjBYTVY4QXhlWE9pYzdDdk0wUUJtQU5GTkV0?=
 =?utf-8?B?bVd6aFZvVGVxTG95ak9QYVRMbFUwUWsyNFlZT2dGbFFJdlBKWGFXZ3FxTTkw?=
 =?utf-8?B?K3NtVkNHODlzNkZWZk5ZL2ZjUUFZc255Z0ovZlBwbm9VQzhpcUpTOGU2T3Q0?=
 =?utf-8?B?OWVVQWhoZkNEUE5MRnk3N0plTHJLeGRsN0Jia1o3c29rSnlwSm53SGRTT0d6?=
 =?utf-8?B?K0RPaWpWWHN2eHNxTUpFQ21XTW9tRnl6b1ZNalBrOFBrSDRDcmVMVDI2LytU?=
 =?utf-8?B?TlVYRmQwREo5cERRbXUzUmcva1NIUjVjMENpeUxOQUJwQzNtakRRV3ZYbmwv?=
 =?utf-8?B?bSt1dGpPbDFTV3RPM3BDMFpMTFQ4V2NURGVHQyt0b1JUcFNFa01URkl5aTdD?=
 =?utf-8?B?ZmtEQzVQdThWVllyQXlnYlZyS3BxVlFtTUdhaFBCcU5vOXlWZ1piVysxbW9M?=
 =?utf-8?B?TXdJZFFGK1krd1N3c2t0UVRIOC9tc3hkY3VWU2s0UnQ5ekpkQ2hSZWpHeWUw?=
 =?utf-8?B?RFRLeDZuUlNwamppSkxYbmtuTUlkaHFUdjhQUHFqVjRkeVBKR2puNjFucThj?=
 =?utf-8?B?a2w4bWNNaFpveEZUMjBOQ2JTYnZHclhKc1Y1R1BwOXFqS3ZvcVBaLzA5b3Mv?=
 =?utf-8?B?NFdYOXJKbXpueDZ2TTcwNmtyL2lCZzVxdkIwd2ZQSkVUM0x0Wk5ualBuT3JR?=
 =?utf-8?B?TThPQmNKMzF1emE1ZHZPL2VlZjh6aEJKLzdoL2lDL3J2SnJxS3dlT1FWOFdw?=
 =?utf-8?B?bmpncTJOWWQzNmNkdXBCZG5xSnoxVktzeGh6YlhKbHk4a3ZhU1RVQjArMURK?=
 =?utf-8?B?dUN4emNLblJpUE5GRmJEazRRWEdsUVNyd0Z0T3B6VFI4aUNzVGE3RzlrZ09Y?=
 =?utf-8?B?ZmhMQUowbHRPVlhFNGMxeHFvVTNadWFvSW9PNGR4ay93cDlWTnVOU1ZVbXdh?=
 =?utf-8?B?TTFwZ2EzMFlXUVZSbG9uS3Fmd0s3QUZuVmpRN3lKSEQxRnMwVEFJVkNZc0lM?=
 =?utf-8?B?dm1jMzh4WjFvUzBnTmhXRkZUVGVkcFAyUEI3NkR4K1BZK3VwdTBwYUxCNWpp?=
 =?utf-8?B?ZW5WRVJJMzR2TWNiZjZBSFNrWjk3QmcrMTRWK2NVQUw0YTBCQk14Rm1ZRnA4?=
 =?utf-8?B?L1pRaW5SdXd3Qk8wcEQyZVpZd0E3R2RQUTJ3VHpqYnJrdENWYUZJM3hScHRu?=
 =?utf-8?B?Z09WSXZYa2JKY1Y0Q0wveTFmTE1xWEh6N0ZQMmlwVCtBTVpmckVHazhpK2xB?=
 =?utf-8?B?WE92ZWYyL2gzZWhRMmtIUHdwYmFqWUVTUUJ1dmVQOFE1eHhFSlczSWFJTXBt?=
 =?utf-8?B?WGd1ampmQ0dPR0k2NzJoZmxLL3Z6cncvTkdMcTdYN1dHeW5pandrWUwyTGUx?=
 =?utf-8?B?UWhKamUvUEd6clUyR3VYRU10TVdMbDRqaEtDUHRZM3cvaVJSWmZaNGRNK0ov?=
 =?utf-8?B?SmdubEo5Y0R6SFFrVEE5ckdEbXBWL0Q5dFJ4MytHSlhlTENZRnQrRk1TRlBU?=
 =?utf-8?B?VGZMRGJUUXJlUk5vS3VxYTdXazYwSW1IRUJRaGRpUkEzczk0T1NQSkpPNEhY?=
 =?utf-8?B?c0xnRGZJTzh2VlM4ajR1NEorckY2LzdXT2ZmMEZBcU5GQjgxRHJXd2FxMDBX?=
 =?utf-8?B?ZXVKZGZiUXQxeGhEV0xkbGN5N3Q1VlBzc0RmR1VLZHlOUHRBdGQ5MzBGdEtv?=
 =?utf-8?Q?woCDf19BXcRdWMDdx51PKBo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19ED7A16076FE4FB32220E363BFED02@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b216742-ff3a-4b5c-12ea-08dd02497d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 12:08:01.8227 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2Ca8bDO04WyEer7AvbnDPL8/fd0osO9IjRdwmSVicXda9OjCvgQtit1GAHd9iyDEvw6D/STuEH26i2Cjn7Y0QrGl6YNt36vzzyYE2IJV1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6831
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

SGkgSGVpa28hDQoNCk9uIE1vbiwgMjAyNC0xMS0xMSBhdCAwOTo0NyArMDEwMCwgSGVpa28gU2No
b2NoZXIgd3JvdGU6DQo+ID4gSGVyZSB0aGUgY29tbWl0ICJmZWF0KHNjdV93ZHQpOiBhZGQgb3B0
aW9uIHRvIGNvbnRyb2wgZXh0ZXJuYWwgd2R0IHZpYSBJTVg4IFNDVSIgaHR0cHM6Ly9jb2RlLnNp
ZW1lbnMuY29tL2NjcC91LWJvb3QvLS9jb21taXQvYTViOTlkMWM0MDZmZGY5MmNkMWQ3ZDUwZDU2
NmE0ZTFlNjZjNDQ3Yg0KPiA+IA0KPiA+IEBIZWlrbzogQ2hlY2sgaWYgd2UgaGF2ZSBhIGNoYW5j
ZSB0byBwdXQgdGhlIHdob2xlIGNvbW1pdCB1cHN0cmVhbS4NCj4gDQo+IEFlaG0uLi4gdGhpcyBp
cyB0aGUgInJld29ya2VkIGZvciBtYWlubGluZSBwYXRjaCIgd2UgY3VycmVudGx5IHRhbGsgYWJv
dXQhDQo+IA0KPiA6LVANCj4gDQo+IFRoZSBxdWVzdGlvbiBpcywgaWYgd2UgY2FuIGdldCB0aGUg
c2llbWVucyBsaW51eCBwb3J0IGFsc28gdG8gbWFpbmxpbmUNCj4gbGludXghIEJ1dCB3ZSBzaG91
bGQgZGlzY3VzcyBmaXJzdCBpbnRlcm5hbGx5Li4uDQoNClRoZXJlIGlzIG5vIExpbnV4LWNvdW50
ZXJwYXJ0IGZvciB0aGUgU0NVIFdEVCBzdG9yeSwgTGludXggV0RUIGRyaXZlciBvbmx5DQp1c2Vz
IHN0YW5kYXJkIEFQSSBvZiBTQ1UgRlcuIFRoZSBVLUJvb3QgZXh0ZW5zaW9ucyB3aWxsIHRhbGsg
dG8gZmlybXdhcmUNCmV4dGVuc2lvbnMsIGFzIEkndmUgZGVzY3JpYmVkIHByZXZpb3VzbHk6DQoN
Cmh0dHBzOi8vbGlzdHMuZGVueC5kZS9waXBlcm1haWwvdS1ib290LzIwMjQtTm92ZW1iZXIvNTcx
MDkxLmh0bWwNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVt
ZW5zLmNvbQ0K
