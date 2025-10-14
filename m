Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D2ACCD18E
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 08:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58112807C0;
	Tue, 14 Oct 2025 10:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="e1nTR8jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49740809A5; Tue, 14 Oct 2025 10:31:18 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC58680422
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 10:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIVtKQNgWkqtM4b1SJymrqklmTmJ/NLC0mkkVW1rKJ5XuvgM5My1wSPy0bMOzKk08R3jpSD+xvkJjVKuGOkSQzKRr0VCml4vyp/NalnfPlXT0iH5R2VpkAh7Ig9bUT5J41w9m85nKYo5Y0wpVHKPPTRq8f8EuB9+HzgPEKpb/lA4tOgoLStNE5YUIZBIMlwEhYC0+ZDKymbgHAqpKVGM1893Z5tsdlRKpGX293ZSCsY8oTT21IQm42nHDg0gTNvZa9imdes81BLjByutPZoVsMZg0TJa/Hdi/NHWb0Z/M85O8MhvoUVEKbIG/+N2vsR5oVsOzOsCiWCUl1LQl2Ipiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97XUooALBQTuAMkQlkatZkPYLn0F0vQvS3SIOKnAJ28=;
 b=bPAOBLk/BefNPTfGCtXn0UQfH8TeYthMiAMb2tMeS90iqRELmnkJhh5//AFZbl0ccP4GLzOfpVTBY9jGs6hKahYcIyOlm9h6Iv2Vy+r/I2bS0/Q0PMVF6I/whQQoVK6B6YYLW/vd4D37w4LjjX/9SfZy1Jd9ZEaQ0+R5HfuTUhmt0YXLa0xMHIMy0h6KpYBV3T45isgVd0swSUpjcXPMS0HU1rWkZCl7LrBZbvo3R9AWqj1a1guYbQqG9J6YQaUKfq0gFql+Pdy4jJyoH2BDNgjBJ/itfOviObbkn5gy5Hh73QroXlfLI5tD7TfPHZboXFAVbodIEm9SSUxUn6jfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97XUooALBQTuAMkQlkatZkPYLn0F0vQvS3SIOKnAJ28=;
 b=e1nTR8jf8F7zXwf89jbiboL3lyV4WYJq1iUBRFWLVfRUi9nyIi/VWImCWlDxK91OvwgU+lMzz2S5VWpJZVTcflyvH+enIvACyk0/8+gxqKzblYaal5X0zP03rP0K39iGLEyLKqX7c1ME5+Qr//FGn5g5amrrEMbKlko7pHBhc5KJSyA09btn3vL7kVTe+5EvGYzs79A4Xgo5nSS1utHTjKfYv/WFP9kATMkzofmNtB7tqjNgUX47yZKudjtJno4C4OP7ttWVR0bFmK7u93XYdGXlT7zIrBt5VHCaNb0OxXh2egyE6QX8XQ3gCJ6mSZZrN/WMjFGlCcuErJY55zJSlg==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by DB8P195MB0742.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:146::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 08:31:13 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 08:31:13 +0000
From: Martin Schwan <M.Schwan@phytec.de>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Andreas Pretzsch <apr@cn-eng.de>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>
Subject: Re: [PATCH v2] test: boot: Add test for bootmeth_rauc
Thread-Topic: [PATCH v2] test: boot: Add test for bootmeth_rauc
Thread-Index: AQHcPIWQu4caxI40Sk2cpKixGiZ4d7TBUMAA
Date: Tue, 14 Oct 2025 08:31:12 +0000
Message-ID: <161597811da9f312d986c3e44f34f6a8c66c23f8.camel@phytec.de>
References: <20251009-wip-bootmeth-rauc-tests-v2-1-08fbd3738e0a@phytec.de>
 <20251013210836.GL6113@bill-the-cat>
In-Reply-To: <20251013210836.GL6113@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|DB8P195MB0742:EE_
x-ms-office365-filtering-correlation-id: fe0e578f-4061-4cc1-db55-08de0afc08c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aDBKMXJjWkJUeXR3clU4NmNVOU5tTmw5OHM4SlVwdmMrNllkcDNtRmZKWWE5?=
 =?utf-8?B?LzBpVGMzVDNGT0dKTEljSEdFdHpyZHk0THByRFpGV05lMWEyaGJvTDVTY3Nu?=
 =?utf-8?B?L3NJbzZsaWxzOHg4YVNsWlFsVDBtSGJRa2RmQnpkSFJXem1nMDhkdTZiSTVD?=
 =?utf-8?B?SmcwRlJTS3NvN0RpVytSaDVOaHFsVnFkYTQvOG9EdDBkcnZUMG1JUk5scnI4?=
 =?utf-8?B?MCtGVEgwMnlVd2RMb2I2RDhpTlVYOUJ3bkllWFdweXZodUlBY05jcTBCcm9s?=
 =?utf-8?B?aFZ5RS8wUG5ZMi9EZVpkWVVPYUV4NjNaMjNkd2xnbDB0SmZQZ3FxMEJLcVRX?=
 =?utf-8?B?VzA0YlR6NHNadGFGN1J1QUNpWk81SFN6UWVteXA2dlVBSkVzYXdzN1BpRkpV?=
 =?utf-8?B?NXpxZ1dJYkl0ZE1RVmI1YXh4V1o2aWtCQ1dTRjQ3RmRxazFEZlE1Q3pST2FR?=
 =?utf-8?B?Q2lrV1RRZEFNcEx0OWFFaEJUNmRXOC9OWStxQ2JBb0lDWk5XQ3R1OThmMHQ3?=
 =?utf-8?B?OFd0NjFsVEVCVkhvRUIrMG5ZZFlac0xIZHNUOTF5NDZjWjRlVjJLdUcxMEFD?=
 =?utf-8?B?UjgwQWhmU3BXa3kwNDJucURnYXFqenY5VVZTQk9KMEhXN2VKdGN6TTdMSEdJ?=
 =?utf-8?B?dWltVHVCYit0OGJ5UUw3V2dBMFNrQ3pad2g0cTdKWHpiVTJrZi9JU0ZlZXZy?=
 =?utf-8?B?aStITG9KYkk2TndWcjBsV1BjWU1jT0pYYzZQQmRQZjJxbkQvaFVhVWVnUGN2?=
 =?utf-8?B?enFXSWNJUkJlTkNuTDMvd2g2eG9nNkplbTAzOHMybS9kb2ZLaW91ZWN3TUtu?=
 =?utf-8?B?dGRVRGpNMFpHSElJa2VTWnhUdkZMSXZoaHp6K2Rjc2dpSWJabnFvSzFrYWtr?=
 =?utf-8?B?QlEyVU9sTlg4Z2JMRUx3YmlZWVpCMWJScmx2bHI1d0RDeXF3UmttbHp6L1Zj?=
 =?utf-8?B?SnZWeXgrcVBlNUNmRFRjUkRsZWdRWTErYnRUWWtPRFpOMGdWSE1TUkwvWEQz?=
 =?utf-8?B?cjB0NG01dkFNeS9YUVdrRnN4OGFUbXJNOVJWbXE4U1JoVHFOVVJ6ZE1NWTNS?=
 =?utf-8?B?TG1XMDhrdWt3aDcwMDdJWGJ3TVhNcStPa29GVzRRc2RVR2ttU25GZ285b0dh?=
 =?utf-8?B?VmJnWjIzR1NDZk1zMy9QeW50NWFhUE1jVVYveXlrQU9GcldyVWY3ajdza014?=
 =?utf-8?B?TXgyQzl3NGFkaGdpWmdOTThOUyszbDZsSGpKam9sUzFsTFV2UVNpY29LUndE?=
 =?utf-8?B?RVRLMWVyM1AyMGM4QU1VamNtcW84VDZxbmVXdUxxSXJHNVR5N29qd1BGTk5a?=
 =?utf-8?B?anh1NjhFelNDVnI1cXlacjFQaFdFV1NZaWtsb3VieGowK3Q0T1ZkT251a1h3?=
 =?utf-8?B?QjduWFZaYU90cU1leTluVVJXUnJZYnh1emxLcFBXRzZEN2c0SVg5by9oWElT?=
 =?utf-8?B?ZkNtVEMwQ1dlTXE3ZlZTYjZ0aWVXVktzczNDODNpSGJDaHNyenpCZ3FMMnp0?=
 =?utf-8?B?cnNSL3hXZTJPbVA1U2I3dXdVVWRPdkNObUdxZE1vUnc2WTA5T2JUS2Y1M0xM?=
 =?utf-8?B?ajUwMXJxMlRhT2w3VWJyV0N5Q2VkdS9XanFodjFJbHJMeCtId0ZuWU84VjdL?=
 =?utf-8?B?bzVUUVRHTGtFK0FrRy9xcy81bTZSb0lZL2ZRT25paFNaTmg3d2dpVm9OTFJa?=
 =?utf-8?B?UWxvc1p4c1ZBTHJ4UVVzZmE0MkVodm8rWkl2YUs5NDhCV1VpZXJCVjNxK1BW?=
 =?utf-8?B?WmlORXVPUnNib055T2ZNMXdSTERGR3FZcW5qYUZEcFhRUDV2ZTdZMWwxbm43?=
 =?utf-8?B?elpjRGJMOE1oNzZ2NmZFZWNla1p1UzRMNnlPMXJVSERGa0dZUm5zYzViNjU4?=
 =?utf-8?B?MnBrR1BLRGhJSFhya3hjWXFxNjNFYXlFMy9yNU5BTGhyVEo0cEttbm1KaFdE?=
 =?utf-8?B?aytiQVBLZXdsSThnQmxObDB1bk5Ba1RCdkgwSXRuRWFZQXg5S1hIWXJPZWk2?=
 =?utf-8?B?aWx4VDV1eFFWdVY5azNjejJZbldyRjJGeWh6ZVJkbThGSkhmMksvckRlTHdJ?=
 =?utf-8?Q?ZP7dvJ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0t4aU84dFE2dDdIS01LaWo1bEpEQXFvdWY3c1Q5Mkc0N2RFVFNYSjJGby9Q?=
 =?utf-8?B?MDd0VlZRbklJZHdmLzQ4SXlXa2xObXpqYUx2bDFoR28xNXVseW9hZDdaekIz?=
 =?utf-8?B?cmxCdjcxRkJiaVBvK3ZMK0R3dVp4bXJZVXM3N210ZVB4K0JydFFLMFhacVpz?=
 =?utf-8?B?Qy9xc3RreXlXODFWS1pjQUN6d3lsMVphYVcwRUVuN0Q3VTBTa1g0SFk2Wkxa?=
 =?utf-8?B?c0t1S09jYW9TRDJ0S2FtUG5mR2xrTG5SY1VmYURLVUFmUzVJaUkybHFBbXYy?=
 =?utf-8?B?QTBUSWRFRUtUWXlKZk1TbytkcnA4bGVrNzFBSFViVEsybFpsMnpibDRQcnRL?=
 =?utf-8?B?L21MSG0zdDI2YmVIejFITHZMcVFkTENONkQ1c1FHYWdTVUJSRlFZZ08yei9F?=
 =?utf-8?B?Vld3Y1JGK2pUOVpMUmozN2d3VFFZWGlHUklmbUFYZVBBNWNUdThKTSs5SFhn?=
 =?utf-8?B?Uzd2UEx4em56UmFyZnlIRGFYT2U5aHVubDBVSjhhNW9mRy93VHBZL1MzMHpp?=
 =?utf-8?B?dGZSV0pSQXFXQmZaLzAzbEVKYmhQTWpvbTg4TXIweFlMTlBBVzNudC9WS2lv?=
 =?utf-8?B?YnZtV2FUTjMxYVBnVlVEVVhSNElpNmJtRU5tdUIwRkwxM0hkMi9yRStYSThm?=
 =?utf-8?B?V05VLzZibzc4NnJKUWJWOEN5aHVRMUxpcjFuYkpsRkJqK2VETHdCSFdWTEta?=
 =?utf-8?B?QW1nc2hmb0I5THRvSHJacTIxcW5IVVNBY3JLTkJkSzlKNW9JcE8yaFk5VUpT?=
 =?utf-8?B?bnZuLytycFJIUW4xNDRTUFlvWW9KYTBLTGNXVDN5RzcvekhyckszNUtRMUdH?=
 =?utf-8?B?RGtZTGpOYjZvdkJsbW5NVHhXbnBmUW9zR1dpRWJRRlB3RjRDS0ZSSnAvbkNH?=
 =?utf-8?B?MEhJektSYWxtWW5lWnlFeDhrWWZ4Yk10N2Y3eE9RODhLSDc0R2ZCa0FMVS9H?=
 =?utf-8?B?T25kNXY4MUtYWWhhTXQrSnFNR1prZjhzb1d2YTJTUTBYMnd4cW5aQWRBOE41?=
 =?utf-8?B?b1hmOW9rNFRXeUFYZG1ybU5ZU2JiT0lRYTFzd1J5RnZvMzR1SlphOFc2U3Rs?=
 =?utf-8?B?VDZJTnZCbjgra091eW9GQUNyeGFvTC9vdG15ZE1oSHg0dFFRRWNxUVFIdjBM?=
 =?utf-8?B?bm5jNEpycW5kODJ2ZmpDLzdKc1BNaXlzakg0bTlZejdoUE5rWHNvcmtnVHJ1?=
 =?utf-8?B?b2xiMUQ1Wk1NYTZNcER0WjR2V0ZTd1hWdk5XQ3JjVFNxbHRFWXE2cDEreXRO?=
 =?utf-8?B?VWE4bUFFbFVoWS91U3J1NENWQlJpT3dVcFRaTTNrQXlXOGR1Q3RZN2h3RURk?=
 =?utf-8?B?TG91bmZmcGV0bmZCeXo1SkFyRWV1OHJ3QUFrYmRYQUpnaGNvSzJGaEk1U2po?=
 =?utf-8?B?K2V3Z3ZDNWFSNy96OGR4MjRUWUtUS1dRSTN5MDZ0aGlrRCtmNEhqNVN2K0RL?=
 =?utf-8?B?aTJITEtqYkd1SCtpVzVyMlVqY21zblJlRG9RR1dSRXJIeHRjYnpwUkwwSWRo?=
 =?utf-8?B?Rk03NTVtaEI1K2hISy8ySnlHYlMyS2dNaVZJRmdzeUdFay9RTXJnb3E2K0Ey?=
 =?utf-8?B?azU4elgwTi9oUEJvU1U1Q0FBRzJMN0lZd1pUOEVqVmNnT1o3aFBiUEt4aVJM?=
 =?utf-8?B?TE52MkNYYTVxZWRKalhDOExtOHlKZFFNc3NqT2l4MlllOHluUVNMbTlaaUlX?=
 =?utf-8?B?Tnhub0VqdHdqMGRmRUlHMmk0M3ByYTdrakxtbm9EeHFLdkJsUlE0NE52YWhD?=
 =?utf-8?B?MDFIVk9YMTFCNnR3TzJBekVNNmRMQVF2NHR0OFhxLzZweDRDQmhBcWU4YWNB?=
 =?utf-8?B?QzZBbVZ2YXV1cGhnZ3B6ZndVOC92SjVXYmRHdnNCVWZ4a2pVQ2E3d3N4SkF5?=
 =?utf-8?B?eDhqWW13eXhQRHFEU0FqWS8rc1ZVMFcxTTdyTmRoTzBlWE9BejZhbFZXeGlw?=
 =?utf-8?B?N015MlBELzVlVnhKbEp3aW9MTmplUWJtUkY3YVpTbWxZYWNsZlhBT2ErWlYv?=
 =?utf-8?B?U1FXTVRLd0JRQXZzVEd6TG9oSUcvODhLNVFvTHAyQU9WOTRTWmlFY3VTcHlx?=
 =?utf-8?B?VEhXZ2pGQW1PNUtmZHJudXZxSlIwS3gwOFN0T1VPcXNheUxZYW8veEV2cCtL?=
 =?utf-8?Q?TsfE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D80B9949D33023478D459847A3675139@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0e578f-4061-4cc1-db55-08de0afc08c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 08:31:12.8096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GUn06ByvMxtEn9KC+fvO3H79HB/wt5kdw34H1v7AVlBKDH49Qf4LKSQaENn++8Qepx6fdbpva+uyrP1O4167jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0742
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

SGkgVG9tLAoKT24gTW9uLCAyMDI1LTEwLTEzIGF0IDE1OjA4IC0wNjAwLCBUb20gUmluaSB3cm90
ZToKPiBPbiBUaHUsIE9jdCAwOSwgMjAyNSBhdCAwOTowNjoxMkFNICswMjAwLCBNYXJ0aW4gU2No
d2FuIHdyb3RlOgo+IAo+ID4gQWRkIGEgc2ltcGxlIHVuaXQgdGVzdCBmb3IgdGVzdGluZyB0aGUg
UkFVQyBib290bWV0aG9kLiBQcm92aWRlCj4gPiBvbmx5IHRoZQo+ID4gdmVyeSBiYXNpYyB0ZXN0
cyBmb3Igbm93LCBydW5uaW5nIGEgc2NhbiBhbmQgbGlzdCwgdG8gdmVyaWZ5Cj4gPiBjb3JyZWN0
Cj4gPiBkZXRlY3Rpb24gb2YgdGhlIFJBVUMgYm9vdG1ldGhvZC4gTW9yZSBhZHZhbmNlZCBib290
IHRlc3RzIG9mIHRoaXMKPiA+IGJvb3RtZXRob2QgY2FuIGJlIGFkZGVkIGluIGEgc2VwYXJhdGUg
cGF0Y2guCj4gPiAKPiA+IFRoaXMgcmVxdWlyZXMgYW5vdGhlciBtbWMgaW1hZ2UgKG1tYzkpIHRv
IGNvbnRhaW4gdGhlIGZvbGxvd2luZwo+ID4gcGFydGl0aW9uczoKPiA+IAo+ID4gMS4gYm9vdCBB
OiBjb250YWlucyBhIGR1bW15IGJvb3Quc2NyCj4gPiAyLiByb290IEE6IGNvbnRhaW5zIGFuIGVt
cHR5IHJvb3QgZmlsZXN5c3RlbQo+ID4gMy4gYm9vdCBCOiBjb250YWlucyBhIGR1bW15IGJvb3Qu
c2NyCj4gPiA0LiByb290IEI6IGNvbnRhaW5zIGFuIGVtcHR5IHJvb3QgZmlsZXN5c3RlbQo+ID4g
Cj4gPiBUaGUgYm9vdG1ldGhfcmF1YyBzY2FucyBhbGwgZm91ciBwYXJ0aXRpb25zIGZvciBleGlz
dGVuY2UgYW5kCj4gPiBleHBlY3RzIGEKPiA+IGJvb3Qgc2NyaXB0IGluIGVhY2ggYm9vdCBwYXJ0
aXRpb24uCj4gPiAKPiA+IEFsc28gYWRkIEJPT1RNRVRIX1JBVUMgYXMgYSBkZXBlbmRlbmN5IG9u
IHNhbmRib3ggc28gdGhhdCB3ZSBjYW4KPiA+IHRlc3QKPiA+IHRoaXMgd2l0aDoKPiA+IAo+ID4g
JCAuL3Rlc3QvcHkvdGVzdC5weSAtQiBzYW5kYm94IC0tYnVpbGQgLWsgdGVzdF91dCAjIGJ1aWxk
IHRoZQo+ID4gbW1jOS5pbWcKPiA+ICQgLi90ZXN0L3B5L3Rlc3QucHkgLUIgc2FuZGJveCAtLWJ1
aWxkIC1rIGJvb3RmbG93X3JhdWMKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogTWFydGluIFNjaHdh
biA8bS5zY2h3YW5AcGh5dGVjLmRlPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gLSBV
c2UgbWtfZnMoKSBpbnN0ZWFkIG9mIGNhbGxpbmcgZmFsbG9jYXRlL21rZnMvbWNvcHkgaW5kaXZp
ZHVhbGx5Cj4gPiBmb3IKPiA+IMKgIHRoZSBib290IGFuZCByb290IHBhcnRpdGlvbnMgaW4gbW1j
OS5pbWcKPiA+IC0gTGluayB0byB2MToKPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
NTEwMDgtd2lwLWJvb3RtZXRoLXJhdWMtdGVzdHMtdjEtMS0zZGEyMWE3MzE1MjRAcGh5dGVjLmRl
Cj4gPiAtLS0KPiA+IMKgYXJjaC9zYW5kYm94L2R0cy90ZXN0LmR0cyB8wqAgOCArKysrKysrCj4g
PiDCoGNvbmZpZ3Mvc2FuZGJveF9kZWZjb25maWcgfMKgIDEgKwo+ID4gwqB0ZXN0L2Jvb3QvYm9v
dGZsb3cuY8KgwqDCoMKgwqAgfCA1Nwo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysKPiA+IMKgdGVzdC9weS90ZXN0cy90ZXN0X3V0LnB5wqAgfCA0NAo+
ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoDQgZmlsZXMgY2hh
bmdlZCwgMTEwIGluc2VydGlvbnMoKykKPiAKPiBUaGlzIGRvZXNuJ3Qgd29yayBub3c6Cj4gPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0gRkFJTFVSRVMKPiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fXyB0ZXN0
X3V0X2RtX2luaXRfYm9vdHN0ZAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiB0ZXN0
L3B5L3Rlc3RzL3Rlc3RfdXQucHk6NjA0OiBpbiB0ZXN0X3V0X2RtX2luaXRfYm9vdHN0ZAo+IMKg
wqDCoCBzZXR1cF9yYXVjX2ltYWdlKHVibWFuKQo+IHRlc3QvcHkvdGVzdHMvdGVzdF91dC5weTo1
ODE6IGluIHNldHVwX3JhdWNfaW1hZ2UKPiDCoMKgwqAgZnNfaGVscGVyLm1rX2ZzKHVibWFuLmNv
bmZpZywgZnMsIDB4ODAwMDAwLCBmc2ZpbGUuc3BsaXQoJy4nKVswXSwKPiBib290ZGlyKQo+IHRl
c3QvcHkvdGVzdHMvZnNfaGVscGVyLnB5OjY4OiBpbiBta19mcwo+IMKgwqDCoCBjaGVja19jYWxs
KGYnbWNvcHkgLWkge2ZzX2ltZ30gLXZzbXBRIHtzcmNfZGlyfS8qIDo6LycsCj4gc2hlbGw9VHJ1
ZSkKPiAvdXNyL2xpYi9weXRob24zLjEwL3N1YnByb2Nlc3MucHk6MzY5OiBpbiBjaGVja19jYWxs
Cj4gwqDCoMKgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCj4gRcKgwqAg
c3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ21jb3B5IC1pCj4gL3RtcC9z
YW5kYm94L3BlcnNpc3RlbnQtZGF0YS9yYXVjX2Jvb3QuZmF0MzIuaW1nIC12c21wUQo+IC90bXAv
c2FuZGJveC9wZXJzaXN0ZW50LWRhdGEvYm9vdC8qIDo6LycgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dAo+IHN0YXR1cyAxLgo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIENhcHR1cmVkIHN0
ZG91dCBjYWxsIC0tLS0tLS0tLS0tLS0tLS0tLQo+IC0tLS0tLS0tLS0tCgpUaGF0J3Mgc3RyYW5n
ZS4gSSBjYW5ub3QgcmVwcm9kdWNlIHRoaXMgZXJyb3Igb24gbXkgbG9jYWwgbWFjaGluZQooQXJj
aGxpbnV4KSwgbmVpdGhlciB3aXRoIFB5dGhvbiAzLjEzIG5vciAzLjEwLiBEbyB5b3UgaGF2ZSBh
ZGRpdGlvbmFsCm91dHB1dCBvZiB0aGUgcHJvY2VzcyBjYWxsPyBPciBpcyB0aGUgY2FwdHVyZWQg
c3Rkb3V0IGVtcHR5PyBNYXliZQp0aGVyZSBpcyBzb21ldGhpbmcgaW4gc3RkZXJyPyBUaGUgZXhp
dCBjb2RlIDEgc2VlbXMgcmF0aGVyIGdlbmVyaWMuIEF0CmxlYXN0IEkgc2VlIGFsbCB0aGUgcmVx
dWlyZWQgZmlsZXMgb24gbXkgbWFjaGluZSBmb3IgdGhhdCBjYWxsLgoKUmVnYXJkcywKTWFydGlu
Cg==
