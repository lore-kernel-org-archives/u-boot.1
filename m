Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AD2C021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 07:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C5F80F1C;
	Mon, 17 Feb 2025 08:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ENDq/aU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC18D80F32; Mon, 17 Feb 2025 08:07:57 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7870480C7E
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 08:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggM5PSUYcWiG0gL9paFhjz61Y/ZF4rdi0JhKrfO1GdH7XBbFjeHqxbwaGPk8hV9i6WgUvuTdBpKjLHafwI0ks5lKedQEdwzdRoG7s7STZjFSW6sm9YAvuE67nj008kp1qHYwauQNKhJqe+WQac0FDdW87GQe/A6i8NEubVEVvsTYIHsquXtQPJ8/SBqFf3Z92JYNZMg1etXaR/dLFjiq5hRLe+jOWCWJWUsB7O/pdbCdKOdkgfOXOQd8g1qO+qzE/zT0gxuVVhKRoKonsQL56IFJN+JLZ0iVQdrCyNf3HrA/aag9Exyl+Gi/aIrbOb7IX7DI5/rAozFNFvytSLBtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIXrER6Id1kiHSC+zAemlgZZadJ0TfRTTvHzDR/z6pw=;
 b=XrXIKQO0bqrfZLzwwU/oSfjma8zGXKvWb0LC8yk0Ofuk7DrGN6GOG921tmkXFV5x8qt5lwb3PT+iM2bkbcMAGQhkhlA1BR2Ikmao1LVottKiVbMMzOKXzAlyBlUAFabKMfV9WHNHc3/PEYXHQoFaPd9oe7NjiVcpH2GYf4x7GZTz2MtAslvidY6uEsQq3ZCeUfp57GkZJzXoWBJH0knzIH0HU7uczTnKAker9lTsNOpfEbwydwSxBmAYO7I3QluMVUk4Egs6SiVilUo0smrUmK8UrAXx+jkiUWUSA9+YYsOPNrJNR4pi6Ju0TA662C3AKXPhECUF8ypPUcoqaVJ+9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIXrER6Id1kiHSC+zAemlgZZadJ0TfRTTvHzDR/z6pw=;
 b=ENDq/aU0+/DgxcOy7Pg5ByGsYjOGFJr+Z4LrtNwcRtRM1x3u/I8zDiqdoRLmfzCE1oEEKTQ0gpC+YhlePcyiwqLcLlEsZtbI2iWETezt3EQssZatZAox+BR5YSzlZPJDECOMVpe/gY4+zG2taIWayjnRx+zD5xL4f3BOsWz2aSyBWngOIXXfuKuBMO8hIkLle6+SXgchTg832Zu2fWgzmOnFHCDvvpxxQRWQ4s8Av7TEC7faYumgOFWZ9nS2KA3Hurg/20tNmT4IPad3OO3XJWP+44bkwSXAXCBYSCpXViYSpLcepeghyLi5qsREh7LYb1lSTPi2209uUQwXG2Tlgw==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by PRAP195MB1579.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Mon, 17 Feb
 2025 07:07:53 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 07:07:53 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
Thread-Topic: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
Thread-Index: AQHbcjjJSp861GWIK0W4zSUZ00TyrLNAlNqAgARUtoCAAHFrgIABIb0AgABtNICABEb0AA==
Date: Mon, 17 Feb 2025 07:07:53 +0000
Message-ID: <3550af8a5234bbc2d38065c7c0f216580cfcb5a3.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
 <CAFLszThHLn4+W0J0sdz=o84wObuYf20YhKV8XbxAGmAsct-8Vg@mail.gmail.com>
 <454617aa2ec54390e0fd40ff4693ba3b559cefc4.camel@phytec.de>
 <CAFLszTgQRzJh-fDn=qqh3_p5boeraOqwCOK0ivAABZWt0w1eiA@mail.gmail.com>
 <9a0969442915d922caedeb9fa9dd7c56dc3fa1ed.camel@phytec.de>
 <CAFLszTgdM3U3foHUKsXQY3SSs0-Gb1MpJOsW0KB+t1Wt=NUsWg@mail.gmail.com>
In-Reply-To: <CAFLszTgdM3U3foHUKsXQY3SSs0-Gb1MpJOsW0KB+t1Wt=NUsWg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|PRAP195MB1579:EE_
x-ms-office365-filtering-correlation-id: f6bc0605-c562-45bc-083d-08dd4f21cc17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OTlTZ1FPUW9hRjlMWUlPSXlxWk12a0hSa0xmdXZqWUtKU1ppQzIvd1ZGSThu?=
 =?utf-8?B?YUdtclFXdno0anFodDBkRjZDZ1hWRUlTYVBSTkQ4VkJaYXRULzh1aHMzcThV?=
 =?utf-8?B?cGJoc2VqZFJhR2E4WG0zZXBsZVAwNHJLL3FZVkZWUFVhSTMzclBmMyt0aHNa?=
 =?utf-8?B?OEJpWER6dmRnSWxXbFNmbVlveTdJK3ZRU2ZMVkxvYzVHdWhCSjRuVjVmdS9a?=
 =?utf-8?B?Rk5Hbk9rdU1CV0RlOUp6cGZpNnFxMGo4TDRIYXY2MDdva1B0OG5HU25pU1U5?=
 =?utf-8?B?VkVqeWlUTEtqVXk5QjdBcDBCWHZLZzBtSmpTQmFNWHVBeWFRSkJianFPcDlm?=
 =?utf-8?B?OW9Sd1lmSmRSSE9haGwxYUtrcVVXRjl0WEN1cGhHa3VTOGpIT3haK2p6U080?=
 =?utf-8?B?SXJLVEsyTHlQemc0STd2ZHdDZGZuMm1EQ1NFU1FyaXRwbTVTdjM5MWp5OUlF?=
 =?utf-8?B?R1FlN2IrbmQxL3ZvMUM2ekxXNUVjbnRRR2dKbCtlcE5oekFqSENLMlpyMktO?=
 =?utf-8?B?VmxNeHo2TnUzZEIrM1VGQzFTeFNGMTFHcksyLzNkMGFoaGppamlET1AzcGlj?=
 =?utf-8?B?dWtwMFJXQVp6cVF0NkJtMFNieE1rN0dISWIyUkNTRTYyVVV3ZjJRTGswZHFD?=
 =?utf-8?B?ckQ5UGsxTkl4dHNJamZBejFQa0thUi9CdTBOcklXbVJHVndOSFhld1p0TWFG?=
 =?utf-8?B?bEtSUnZXWUdXU201NWhjSHQyK2tPRFE5TE0zalRsb3B0WXhvVEQ5NGhwTkFM?=
 =?utf-8?B?cTRQTEg3RmdUeFp4aVcwVWcxVkhmZGE4UXdRUkwwb1JYVkp6NmQweXRaSnRk?=
 =?utf-8?B?MkgwcEpha0JCT0pYcTExOXRhVDE3ZllWcWIzYkwxc25UMnpKRitMeHZ3eURn?=
 =?utf-8?B?VERyV3pqTW9XRVlsRXRsd29GbUszTWJIOW5LeFdOSXZYb2hBMERmUW5EcWFO?=
 =?utf-8?B?QmZaQ3lEOEpmUGNXS1dLazB2Zy9oNE5PQ1NOZlhnVnV5Y0kxMGZ2U3ZPK0N1?=
 =?utf-8?B?aDVmaVhXN0luWnpsYlhMQnY2dUMzR1RYYmJ6cDlvSzJFb0UxYXhYWkNRNkFK?=
 =?utf-8?B?bTNLWXBQcWNINFpQOTNSY05HVDZFYXdjeW1yTnMvbjBjVEZGaTJKWFBPRVE5?=
 =?utf-8?B?QnpZMDJDcGgvWW1JZS9HS2xxekRvOG1ESGxwOWliMjhGMVh1M1dFdGxVdGhG?=
 =?utf-8?B?RDhyY1l2L2Y1K0hZSkp3VXNwVmMvVlRhZllucnVCdWdlUGxZVC9FaDJxVVFG?=
 =?utf-8?B?T1VBTCtOQ1hpUmFXQ2VtWThXa01KM2czTGxHbGYrczRPeGFOd2drd0JMK3ZU?=
 =?utf-8?B?QUZOWXpHUkpOeHZrbWVyOEVrc0dmRExpMVJlVzVOUVllRVhxWHZXcjdncXZW?=
 =?utf-8?B?Q3pseXhQSEN2MDVYWTVxZExRbHo3cURuUjB4ck8xWnhVNFQ2NTdKTDhRRlNy?=
 =?utf-8?B?Ykg0VGhRL0tuUTc5OVUrYUwyZ0ozeVdZaHh2VnFXekV2L09PTW9uSmhmTS9H?=
 =?utf-8?B?Y25JQTZZTE9MbFdUNjhlM0NKQmhXZFRuNmltOHk1cnhiaGIyU3hpR0lob2sv?=
 =?utf-8?B?U3VFbUJPbU1mSEQxRGl1SGtmRXA3THZVREVqUUF2V2g1R2RiVGJ1V3JQQnVt?=
 =?utf-8?B?UG9KaXJEK0U0VjBrK2EybHhsTDJMUjZRSFJBWC9xNCswbE05eG1FWEFqdjFr?=
 =?utf-8?B?dUJvclJaVVdZelpnbEdVZXBtQW8xZHlJeU11dk92dVo5RzZXdTMxMkU5RURi?=
 =?utf-8?B?NEkvbGJERUlIdWFrdjlWempJY1JGVTVBVDFYQ2t5M0Z4Y0kxMDZteXJyVkpz?=
 =?utf-8?B?Vjh5cTlQQzZqVUN6SzNOOTB0V0J5cW9uY3hnRXBjQUZtZkpJU2R3Y2o0alNi?=
 =?utf-8?B?NUJ6aHZ5c3FwMG5jMkRMeGJQZWNjN2wvUWxTMGVCNTlqTGV5S3lWZkpxbmYz?=
 =?utf-8?Q?00k+louGPmNf35SdpQo8N0Yny9Dq4HAH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3FicmdobnpOUFhqR3hzM2dBTkl1cU5lSHl6b01NTXMvWlFCdURvQkQ5dUk4?=
 =?utf-8?B?OHc3QU5tZzBQWEJvLy9BN2ZmaGxxRTVIbHFoTGZVQitROG53enRQNFpNZlZn?=
 =?utf-8?B?ek5WSjhVcStJOE1sdzZieXNlM3A1QWYzT1VEL0N2YUI0d0VxOGQvLy9la00r?=
 =?utf-8?B?VElhVmJwQ2dkYlhoSy9veWN1eHdLQUJlc2x1UlZ4WnhhL2VTUHUxRVRnT0tR?=
 =?utf-8?B?V0pwMStuNkozcTdVbUpnQUJROXZLNTNTYWZLQU9DZG5QM2N0c1lzaGZtWXVj?=
 =?utf-8?B?RXViejRRSXNQRGJ2bGxoaHliMXV6aEYrSlMzNUp4dmhBNnk2Rytqenowb2tC?=
 =?utf-8?B?UGpQU1l0Skp3N3RRVEtFb2s1VFRDcUMzZ3VkWHU0NmRvaHJiMUhSVnZlMVF1?=
 =?utf-8?B?Nmwvcy9LZVp1TmRzcGdEUVJFdmtXcW4rb3dCLzArOWcrWjRKVGpXYm5rT0RP?=
 =?utf-8?B?TUN1MDZOVU9NeEVLci9tWmZnV0YzekNUa0psYytyK2Y1QlJkWktUR3FWdFVH?=
 =?utf-8?B?eUJNZ1B2ZnU1OTlaNTF0S1VEQk5ocVhzZmovKzVaU29venRGMEdqZldXQ01W?=
 =?utf-8?B?MmxNWE9yQzd4N3JGK1NlSisrMkd0UzdBbHdsQTI5Q014eXdibFErNStqb2NR?=
 =?utf-8?B?TkIwNGZwMzNiSmh4SG51WGt5eUVlL09veUJFc0FseVVKMkFMc3lGZlRjbmlY?=
 =?utf-8?B?SjhkaEJOeVVpQW9jcWNBUXJ4UVVLMjRDcmxuQ1krRjhQaTBaaXBrdE1IS1VF?=
 =?utf-8?B?NUhvUnI3dXFVc0dxbUJIMGk0akxsZG9NN3htVGxEU0lzcHk3OHhBSTAvVDBI?=
 =?utf-8?B?MkZjOUtGalFKZGhVeEYvYkw4WFNyMVJMZnEySTlwc0liRzA1ZGZjby9ITHdv?=
 =?utf-8?B?RklBQ2NDbW9WRDg0WGNDNWUxYkxIbXNXTjcvRHpEM0h1VW05SUZhUCtFNDlq?=
 =?utf-8?B?VjJvd0dLUjlpZUV2YTlnTEp0QjY1TFFkbGd0dWRMcGp4TnNmd0E1UVZSTnB0?=
 =?utf-8?B?MndIdnZrZUdoejJDbUhFbGFVR0Ezem9sMFpaUTdRWUllZ0ZOWHloUE9sM2or?=
 =?utf-8?B?OC9DeVpzOW9yZlZMSzF3WVp4UjIvbzZqTDdXeG4rRXFSYThGcjdUU1YwTHFo?=
 =?utf-8?B?OW0yMHErUlZPdGN3RW40TnF0MEphbzgwNS9MajVHMy9QbytZSU5RdlQyNzl6?=
 =?utf-8?B?a1dTcS9OWFdjcFBNVFdYNXoybXdMd05vV3ZhcmxmWXFIN0Yza3NhUWVWdXNm?=
 =?utf-8?B?NDdYQS9sd1ZYdWltbjRRL1Q1QTYyU29LS1ppb3dnam1PSFFiMjZySkxUMXJO?=
 =?utf-8?B?TVFtWWtCeXdlUWxPeXFwTnFRSFRQL0Q5TEVnNGcvVFBpbUpLWEVsY2NqM0o4?=
 =?utf-8?B?VjdqUnN5MFgwUE9iRGNiSnBicXp5TFR2Vm43VzQwZ3Buek4rekErakFxMm0r?=
 =?utf-8?B?SzQrbWpFUHBuM0NYWkV4UndYNTUxMThMSDNlSGl2alRrVEtkVTJZSU1FSjBl?=
 =?utf-8?B?RExRWDB5dGU4T1dHcytMeE9wc2pUbERtYUtIZFRpSDBkMzZOc3d4MkZoRmlK?=
 =?utf-8?B?b2R4OVE4OXNMTWNOendtK1Q1MXhybmVnNHdTSGV6QXBCTmd4OXdlSGFPcVU4?=
 =?utf-8?B?OHE0cU5Wb3Zhakxyb1hFMWkxbGFvb3o1ZW4vQVhHU2VRN0RkZTIzRmpiSmJk?=
 =?utf-8?B?UFlDMGhGUHNiOVlsN3lYdnZjdHQ4Uk9RMWpFOVB2QmY1VWdvSWp6QUt0Q3gy?=
 =?utf-8?B?YWg3bkI4RzVMNUJHMHpuQzBoMDFHQXJDd0l1U0lrQnA2VGhCbGM0cUtYd1Bv?=
 =?utf-8?B?TWdhMzV2c1FOUHFna0tNWnh5Qmc5bUlndEp2WHBhdVlvOHlVSDBvRzNOMnR6?=
 =?utf-8?B?UWRqb1dTT3ZlZGQ1UTN6SG1Uc3NyVWdrNVlmL1hQVzJQM3NRcUtJQStNU3ZO?=
 =?utf-8?B?am1ZQ1V3ei9kWnhQVXA0dndGZFNHeFpMOEhGVmVxSXdVRC9aeDMzTStLdTlk?=
 =?utf-8?B?RVlwdmZmd1dMUk5VRllOL2NZSmZaWk9aKzhTMEJxYUlVcXBGSlE4bTRnS244?=
 =?utf-8?B?T0kxWjIyVmNyVWlndS9CSWtOcXZsSmluUEltSUF3akJxcVRhTGxWL2psWExS?=
 =?utf-8?Q?2Pg4teAeqGESfVf5t0uxYth3E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B271566A590259418D480F3879DC4F3E@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bc0605-c562-45bc-083d-08dd4f21cc17
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 07:07:53.2843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEi5iv1gJp+uYDqWsppmEnNKXQY2ZjC/28JZFRPeZiKH43113pQNZZJWbEm5e3qUJPpat9dnfBHYVdC5DooTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1579
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

T24gRnJpLCAyMDI1LTAyLTE0IGF0IDA2OjQ4IC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
SGkgWWFubmljLA0KPiANCj4gT24gRnJpLCAxNCBGZWIgMjAyNSBhdCAwMDoxOCwgWWFubmljIE1v
b2cgPFkuTW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiA+IA0KPiA+IEhpIFNpbW9uLA0KPiA+IA0K
PiA+IE9uIFRodSwgMjAyNS0wMi0xMyBhdCAwNzowMSAtMDcwMCwgU2ltb24gR2xhc3Mgd3JvdGU6
DQo+ID4gPiBIaSBZYW5uaWMsDQo+ID4gPiANCj4gPiA+IE9uIFRodSwgMTMgRmViIDIwMjUgYXQg
MDA6MTUsIFlhbm5pYyBNb29nIDxZLk1vb2dAcGh5dGVjLmRlPiB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IEhpIFNpbW9uLA0KPiA+ID4gPiANCj4gPiA+ID4gT24gTW9uLCAyMDI1LTAyLTEwIGF0
IDA2OjA2IC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4gPiA+ID4gPiBIaSBZYW5uaWMsDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gV2VkLCAyOSBKYW4gMjAyNSBhdCAwMzozMCwgWWFubmlj
IE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBUaGUgdG9wIGxldmVsIE1ha2VmaWxlIGNhbGxzIGJpbm1hbiB3aXRoIGZha2UtZXh0LWJsb2Jz
Lg0KPiA+ID4gPiA+ID4gVGhlIHRlc3Qgc2V0dXAgc2hvdWxkIHJlZmxlY3QgdGhpcyB0byBzcG90
IHBvdGVudGlhbCBidWdzIGJlZm9yZQ0KPiA+ID4gPiA+ID4gcmVhY2hpbmcgdXNlcnMuDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dA
cGh5dGVjLmRlPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiDCoHRvb2xzL2Jpbm1hbi9m
dGVzdC5weSB8IDIgKy0NCj4gPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQg
YS90b29scy9iaW5tYW4vZnRlc3QucHkgYi90b29scy9iaW5tYW4vZnRlc3QucHkNCj4gPiA+ID4g
PiA+IGluZGV4IGE1NTNjYTllNTY0Li4xZjE5NGY5ZWNhZSAxMDA2NDQNCj4gPiA+ID4gPiA+IC0t
LSBhL3Rvb2xzL2Jpbm1hbi9mdGVzdC5weQ0KPiA+ID4gPiA+ID4gKysrIGIvdG9vbHMvYmlubWFu
L2Z0ZXN0LnB5DQo+ID4gPiA+ID4gPiBAQCAtMzcyLDcgKzM3Miw3IEBAIGNsYXNzIFRlc3RGdW5j
dGlvbmFsKHVuaXR0ZXN0LlRlc3RDYXNlKToNCj4gPiA+ID4gPiA+IMKgwqDCoMKgIGRlZiBfRG9U
ZXN0RmlsZShzZWxmLCBmbmFtZSwgZGVidWc9RmFsc2UsIG1hcD1GYWxzZSwgdXBkYXRlX2R0Yj1G
YWxzZSwNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZW50cnlfYXJncz1Ob25lLCBpbWFnZXM9Tm9uZSwgdXNlX3JlYWxfZHRiPUZhbHNlLA0KPiA+
ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2VfZXhw
YW5kZWQ9RmFsc2UsIHZlcmJvc2l0eT1Ob25lLCBhbGxvd19taXNzaW5nPUZhbHNlLA0KPiA+ID4g
PiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFsbG93X2Zha2Vf
YmxvYnM9RmFsc2UsIGV4dHJhX2luZGlycz1Ob25lLCB0aHJlYWRzPU5vbmUsDQo+ID4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWxsb3dfZmFrZV9ibG9i
cz1UcnVlLCBleHRyYV9pbmRpcnM9Tm9uZSwgdGhyZWFkcz1Ob25lLA0KPiA+ID4gPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0ZXN0X3NlY3Rpb25fdGltZW91
dD1GYWxzZSwgdXBkYXRlX2ZkdF9pbl9lbGY9Tm9uZSwNCj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yY2VfbWlzc2luZ19iaW50b29scz0nJywg
aWdub3JlX21pc3Npbmc9RmFsc2UsIG91dHB1dF9kaXI9Tm9uZSk6DQo+ID4gPiA+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgICIiIlJ1biBiaW5tYW4gd2l0aCBhIGdpdmVuIHRlc3QgZmlsZQ0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gMi40My4wDQo+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIHdvdWxkIGxpa2UgdGhpcyBkZWZhdWx0IHRvIHN0YXkg
dGhlIHNhbWUgKEZhbHNlKSBiZWNhdXNlIHRoYXQgaXMgdGhlDQo+ID4gPiA+ID4gbm9ybWFsIGNh
c2UgZm9yIEJpbm1hbi4gV2Ugc2hvdWxkIGV4cGFuZCB0aGUgdGVzdC1jb3ZlcmFnZSBhcyBuZWVk
ZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBDYW4geW91IGhlbHAgbWUgdW5kZXJzdGFuZCB3aHkgd2Ug
ZmFrZSBibG9icyBpbiB0aGUgY2FsbCB0byBiaW5tYW4gd2hlbiBidWlsZGluZyBVLUJvb3Q/DQo+
ID4gPiA+IFlvdSBzYXkgdGhhdCBub3QgZmFraW5nIGlzIHRoZSBub3JtYWwgY2FzZSBzbyB3aHkg
YXJlIHdlIGRvaW5nIHNvbWV0aGluZyBhYm5vcm1hbCBpbiB0aGUNCj4gPiA+ID4gdG9wLQ0KPiA+
ID4gPiBsZXZlbA0KPiA+ID4gPiBNYWtlZmlsZT8NCj4gPiA+IA0KPiA+ID4gSSBtZWFuIHRoYXQg
bm90IGZha2luZyBpcyB0aGUgbm9ybWFsIGNhc2UgZm9yIEJpbm1hbidzIGNvZGUgYmFzZS4gWWVz
LA0KPiA+ID4gVS1Cb290IHJlcXVlc3RzIGZha2luZy4NCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+
ID4gSSB0aGluayB0aGF0IHRoaXMgaW5jb25zaXN0ZW5jeSBpcyBhIHBvdGVudGlhbCBmb3IgYnVn
cyBnb2luZyB1bm5vdGljZWQgc28gd2hhdGV2ZXIgd2UNCj4gPiA+ID4gZGVjaWRlIHRvDQo+ID4g
PiA+IGRvDQo+ID4gPiA+IEkgd291bGQgdmVyeSBtdWNoIGxpa2UgdG8gYmUgY29uc2lzdGVudCB3
aXRoIHRlc3RpbmcgYW5kICJub3JtYWwiIGJ1aWxkcy4NCj4gPiA+IA0KPiA+ID4gQmlubWFuIGlz
IHRlc3RlZCBieSBpdHMgb3duIHRlc3RzIHdoaWNoIGhhbmRsZSBib3RoIGNhc2VzLCBzbyB3ZSBk
b24ndA0KPiA+ID4gaGF2ZSBhIHRlc3QgZ2FwIHRoZXJlLg0KPiA+IA0KPiA+IFNvcnJ5LCBJIGFt
IHN0aWxsIHN0dW1wZWQgaGVyZS4gSSBmZWVsIGxpa2UgbXkgcXVlc3Rpb24gYXMgdG8gd2h5IFUt
Qm9vdCByZXF1ZXN0cyBmYWtpbmcgaGFzIG5vdA0KPiA+IGJlZW4gYW5zd2VyZWQgYWJvdmUuIENh
biB5b3UgcGxlYXNlIGV4cGxhaW4gdGhhdCBhZ2Fpbj8NCj4gDQo+IFUtQm9vdCBuZWVkcyB0byB1
c2UgZmFrZXMgbGFyZ2VseSBiZWNhdXNlIGluIHNvbWUgY2FzZXMgdGhlIGZha2UgaXMNCj4gcGFz
c2VkIHRvIG1raW1hZ2UsIHdoaWNoIHNvbWV0aW1lcyBjYW5ub3Qgb3BlcmF0ZSBhdCBhbGwgaWYg
dGhlcmUgaXMgYQ0KPiBtaXNzaW5nIG9yIHplcm8tc2l6ZWQgZmlsZS4gU28gd2UgY3JlYXRlIGEg
ZmFrZSBqdXN0IHNvIHRoYXQgdGhlIGJ1aWxkDQo+IHdpbGwgc3VjY2VlZCAod2l0aCB3YXJuaW5n
cykuDQo+IA0KPiA+IA0KPiA+IEFuZCBJIGFtIGxlZnQgYSBiaXQgY29uZnVzZWQgc2luY2UgSSB0
aG91Z2h0IHRoZXNlIFJGQyBwYXRjaGVzIHNob3cgdGhhdCB0aGVyZSBpbmRlZWQgd2FzIGEgdGVz
dA0KPiA+IGdhcA0KPiA+IChpbiBhIHNpbmdsZSB0ZXN0IGNhc2UgdGVzdEZpdEZpcm13YXJlTG9h
ZGFibGVzIG9ubHksIGJ1dCBzdGlsbCkgZHVlIHRvIG5vdCBmYWtpbmcgZXh0ZXJuYWwNCj4gPiBi
bG9icy4NCj4gPiBJcyBpdCBub3QgcG9zc2libGUgdGhhdCB0aGVyZSBhcmUgb3RoZXIgcG90ZW50
aWFsIHByb2JsZW1zIGluIHJlZ2FyZHMgdG8gZmFraW5nIGJsb2JzIHRoYXQgd2UNCj4gPiBoYXZl
DQo+ID4gbm90IGRpc2NvdmVyZWQsIHlldD8NCj4gDQo+IFllcywgcGxlYXNlIGZpeCB0aGUgdGVz
dCBnYXAgYW5kIGlmIHRoZXJlIGFyZSBvdGhlciB0ZXN0cyB3ZSBuZWVkIHRvDQo+IGFkZCwgd2Ug
c2hvdWxkIGFkZCB0aGVtLiBUaGUgZ29hbCBvZiBCaW5tYW4gaXMgMTAwJSB0ZXN0IGNvdmVyYWdl
LiBCdXQNCj4gZmFrZWQgYmxvYnMgYXJlIG1vcmUgb2YgYW4gdW5mb3J0dW5hdGUgd29ya2Fyb3Vu
ZCwgbm90IHRoZSBwcmltYXJ5DQo+IGdvYWwgb2YgQmlubWFuLiBTbyBJIHdvdWxkIGxpa2UgdGVz
dHMgdG8gZXhwbGljaXRseSBzZWxlY3QgZmFrZWQgYmxvYnMNCj4gd2hlbiBuZWVkZWQsIHJhdGhl
ciB0aGFuIGhhdmluZyB0aGlzIG9uIGV2ZXJ5d2hlcmUuIEl0IHNob3VsZCBvbmx5DQo+IGFmZmVj
dCBhIHZlcnkgc21hbGwgYW1vdW50IG9mIHRlc3RzIHdoaWNoIGRlYWwgd2l0aCB0aGUgcGFpbiBv
Zg0KPiBleHRlcm5hbCBibG9icy4NCg0KVGhhbmtzIGZvciB0YWtpbmcgdGhlIHRpbWUgdG8gZXhw
bGFpbiB0aGlzIHRvIG1lLCBJIGdvdCBpdCBub3cuDQpJIHdpbGwgdGFrZSB5b3VyIHN1Z2dlc3Rp
b24gYW5kIHJldmlldyB0aGUgdGVzdCBjYXNlcyB0byBzZWUgaWYgYW55IHNob3VsZCBleHBsaWNp
dGx5IHNldCBmYWtlLWJsb2JzDQouIEFuZCB3aXRoIHRoYXQgd2lsbCBkcm9wIHRoZSBkZWZhdWx0
IGZha2UgYmxvYnMgcGVyIHlvdSByZXF1ZXN0Lg0KDQpZYW5uaWMNCg0KPiANCj4gUmVnYXJkcywN
Cj4gU2ltb24NCg0K
