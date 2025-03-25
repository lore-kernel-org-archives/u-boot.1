Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387B2C36010
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9AF981E13;
	Tue, 25 Mar 2025 15:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="HUGYEeRv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C00181026; Tue, 25 Mar 2025 13:27:39 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05olkn20817.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2e13::817])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 524F1808AF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 13:27:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludovicw35@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gH00MXtcYhm5JakhO5vLVTu3GbxQLEvs4wbc5n1ILROB6XvJCkszYGo/mOItolvoHwubRNs9u3dQoQqikADrB5Iy/kQxrPMwXEQX8+cTCHIGv/IWpmSAQy6mNEpZaLp8JG1o90W+tV+B4/dH+JyotWLXq7OLHL/wvs3gfSSwUxoCa2JVS3/UbOsVcl3wxw9KGhxMOcTSTP/1jSN4YpyoWd7Mo9EYRw3V1Luam03U6DMonL7XDC7q9oPRTMeExzoQkilRCwExe7CA8qdfJGyX35hwfOyp+Yy0/g1G1HDh7Gwyq3qCNdmh60/5I3K9PGVrkdtuOEisF+VRXMxtfWegTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jrL2o/he1T6lReKopjPckK0vZ65HDYUtndbGsOtF7g=;
 b=Q5HnMPF2i2blvFkeBc5UK60fJFcYjB6AChoWQ3ffgV50LkWw/85BRMYXvhPyX4npBLhWHCYjIJeIVaQv0YjDINalRf6BdFxUvAzYycqI3tujfoSU1fP0z+4EArQmidBorcQBWK2iGIZXvi3neKwIBprPmi8w1HK37SBo7scdvSKYkbstrk5jjehET4O5w4RoWNxUE/eTlrovf9//2u0zL3GZegPsL5o/b9GKlJy8tf5u3ylNmXDCRSnxDDaySpxYFqvzUPWx9nqJLy02X1CTNYHnDk4OMXU5SFI1yd4b0IZDOmyQYGwdQ3AbU0hwfrpjZ/pXxvPH2hrBf6sJ/8ILOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jrL2o/he1T6lReKopjPckK0vZ65HDYUtndbGsOtF7g=;
 b=HUGYEeRvVs9yKOF4rYk+7sEBSMVmpVTrgSiIXoKTtzDBCetBTNWe7/aE42F4xcKMsjOlitny83Fee7kO0xum0lAlnJBs3ugmS8njFYO58ND+JKKWj8FFeT5pV+Xkm4sUqzXmWy0PLp7L4PcT27x4S4eCsUJ07Q3MBPOGfOzLtbwH+XGTZtNP/8AKIInBESq2vDww2Jjyp7RtibppMERo9L6tMkm68UBB4+FfgoAGuXgK0v8JBbdlkHFju2TXv0BEtDgXwSV3KABcTEPl3s79b+PussEpgLJtgEqOe6Eh1E4yV3oLtheOhEya4bl53EEavgD9kMGhiJ9UMEaW9kR2ZQ==
Received: from DB9P189MB1612.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ae::9) by
 AS8P189MB2200.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:561::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Tue, 25 Mar 2025 12:27:36 +0000
Received: from DB9P189MB1612.EURP189.PROD.OUTLOOK.COM
 ([fe80::3617:7f7c:9bdf:823]) by DB9P189MB1612.EURP189.PROD.OUTLOOK.COM
 ([fe80::3617:7f7c:9bdf:823%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 12:27:36 +0000
From: ludovic wittlin <ludovicw35@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Rpi5 usb boot support
Thread-Topic: Rpi5 usb boot support
Thread-Index: AQHbnYDj26AzWUq2EU6vpeDJEyMyjw==
Date: Tue, 25 Mar 2025 12:27:35 +0000
Message-ID: <DB9P189MB1612ABFDB8BF170AB1D64CA7D0A72@DB9P189MB1612.EURP189.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P189MB1612:EE_|AS8P189MB2200:EE_
x-ms-office365-filtering-correlation-id: dc41a98f-2ae0-45cf-bd1a-08dd6b986cba
x-ms-exchange-slblob-mailprops: VTa9p188PROidwBiCD6iRezKWwMvs90Tnox0+y5uJCpoK1DDLNQZ/EnzaBA4ypt/PHL7VoYb3uqOzJPWdhPjdQgaBle1PCp7tk/nMPuKpx97eQKnfPHOYIzm5/cLcvidHUcDGhoYj1gM/kekAsYBddmaiwLTU4SiqdjCs16CEJ13X/ZjzocctUEz7/8SThEMJjfBgZodJBQ1SIKMZo6HwKwhzDXkx1+KMdUPlZjdDXc3GuizhuS4LbC8eWNxHeFHZp7/Y1Wis1+VwcgLiXQB77rUr+1L8OHN9vstSM0QMRSwa+5kcEQj6k2m9UHZ5MR09wphuUs9KbF+mmOtNY4QIXPO/SdnLWKaB7VUlP9/v9cAyljgPVjSRS9H7j8LRwOHRb8uIpWeH0Oc1s49K1n6UBxl7UKRwKobp4g45aBP1Q/lO5xAIaF4zvqH/Hle+zuvDAMzJE573QSIwS2WGyE8PZL4pJvMqw/8Y0edxaPXMtoKJi3jGBQ6ASBwn2uCguAjC6oJeJ1oyhCTAorU2cBq40DO1cHCA28aVgUMK0cpUZuhTUCdeqn8CZzqOfSQmYnjinJWkRuteq752OgvBe1QIbaDe2lT8KAZdw8YICddDVZp2BrGAamr4ZVQiRmlHjvX
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|19110799003|7092599003|15080799006|8062599003|8060799006|15030799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?NSgtVS83bL0IDZ+/EIBiOp1OVKupP4N13lkHkpS7cI8yoYL9nTSJXpyjvt?=
 =?iso-8859-1?Q?sn9jANjRdFcRvXYR+9RITz8R16h3XmfjMsvxLpJiRvRvRDlOCq/NA+sOMq?=
 =?iso-8859-1?Q?W72fMTiLnYZi0FM5K5MOrzsl/WDOh2dCSqBKVQec/6/4EENB3zmi8hY25z?=
 =?iso-8859-1?Q?c2+jdca3SAbXrOCZQxqUyYLNqBFR2HwfEzH+FMbacoCktm+jaaT703eTGR?=
 =?iso-8859-1?Q?urXXB/GTOsrkDH7tnWzwEIRwo/2cZ1aK2Ds+EntS4zjGWXLIn4LJEoyYEP?=
 =?iso-8859-1?Q?DjHhHQ01LVhACaP4EoLKtrVz9oS/XnNM4FukdCENUnRjOPojAIPT2u8hJI?=
 =?iso-8859-1?Q?3dUuXpTI8pCf6WXoTuor/qpptddRLxSev6hsRFOCdUWvsHH1sH4/6ycA+z?=
 =?iso-8859-1?Q?DFglnrLGm7w4YaGeqBLnpA18/mrL/Un/I7m5UxlxREH0KH9iil53A3icIO?=
 =?iso-8859-1?Q?2Ra8yjlkLG5bAgGUBVXMiSf8wmvi9g1ljy+SmHX/5K7eXw90ufFwwGZ5dx?=
 =?iso-8859-1?Q?iSXP1tLHm4ilQbtQKbArlJXR5qzddmP7D5R5ooFEGLrvVXYCnPELrVKxQF?=
 =?iso-8859-1?Q?ruYHsTABQUUoIWCay9PPZwFR0MY7T1cZItggRS+cxlpc85ebGkV08/6S1u?=
 =?iso-8859-1?Q?mv/RACRDmPlt3z/j10LmBhucHIRKow4sQDweo6qAWj6OMmWDO6r+8OvPHv?=
 =?iso-8859-1?Q?X9VbKIhoQC+ZzoA+IZaqAscxQUcejkTYK/kr7iHIN4BMCBHMcN0cR7hEWg?=
 =?iso-8859-1?Q?2CTaaEYfvr071X/oLWSbjJMudq7w4mZczsGx2vXO6t6UaXiQWLzgh8R+bT?=
 =?iso-8859-1?Q?+T5HZhIpv5WmBT9ew0vimiQth+E5uQSo13ZHqElk0xDYuJcip2aN10DkJE?=
 =?iso-8859-1?Q?V9sWWkPK+8RCLVVmHM3dAKfo6gg4sXnLYEH5B/D8QXI+3aD5UlMBwF6QY3?=
 =?iso-8859-1?Q?wkU4K7mM6kCutqbuFRxsGZXMj0WV2nyyPVP5vaiP0qcNVJP3W+bH07Q2Bp?=
 =?iso-8859-1?Q?b2xiffxbEYoxhx8lAWGHMl4eEtv4lUjnVNlSwbn0uvCrIgaIoR1X5XI9fa?=
 =?iso-8859-1?Q?6v3r5vFmFPgKRhHbmAKZqIi5nVbeclq5shz2xg4F7Dp/b0zoIILcQOz/9V?=
 =?iso-8859-1?Q?AmtSNpZH4b1pbSJGV+779oNdvlHqc8jTUhu2Xow/DW/IV6Z9HXZwi2wKyU?=
 =?iso-8859-1?Q?bK2BBcntbVVQ8Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IpthmuV6G+mE3dzANJORjvwr8Fibne39f9iMxgvDcBv2ZjtZaysjpBHpRp?=
 =?iso-8859-1?Q?R9mIGGb2bnpH2ES1aw+u7mUdkixNUChHMYjZUETEfr62HOL4ha63zjhoxX?=
 =?iso-8859-1?Q?ALd7OU51scbbSYROGwAKlSBzL2FaUtnF7arPfNl/+AtIlBtCALiEWHQMBC?=
 =?iso-8859-1?Q?PMg3q0ji2JKCad/a72uKo6b8fIws0pfFvjZQ1dk80EOEP6+goWbN5IkO/5?=
 =?iso-8859-1?Q?IGRC3aYwpFUZl94KKF7s5yYYQ4KGn4vyDH3AiCT39MMcArj9RTrToo9p6S?=
 =?iso-8859-1?Q?x7AEndVmvaYAxODslT9gUQQGFKPXKLzBB8fNR5EA1ueVaY+aSoBZUa8US1?=
 =?iso-8859-1?Q?+E17d30MumOdLVpPL2tBgXa9LQV3yl2oa5t30ezM4ra3GeOJSEXXOxrkXh?=
 =?iso-8859-1?Q?7bJOtjOSbb/e6+V/kU4B8aQmsIcg/qhhMdY5IoDQG6wc/rnPjGX4qpctBU?=
 =?iso-8859-1?Q?A1iQurXTZxPFOcpuqe07E6vZn6KRFkcWMbhmwW25u7L2yAYtzzEC5fWRW6?=
 =?iso-8859-1?Q?K/ZUuLEgZyMLnRo/20yiZeh9OXhddxkY91O3UDCr7sXWTVOYr6DSyiFak7?=
 =?iso-8859-1?Q?/wfEAXIC6j7chj18BZiVATEmWL+ibOUd/KcK7Is4askGwi2zrERMT826N4?=
 =?iso-8859-1?Q?dZjlmNQ6TfzVv5Zdcza3BBhhVd/zY0rRi5niK8vgA6/ABvmKkNrWD6KTva?=
 =?iso-8859-1?Q?ANy0WlKQ3ln4joJBWZPrmUETW6shnb/ta/m0t7puACcAmKRKH7jSe1u5ik?=
 =?iso-8859-1?Q?QkZRnj1Koa9tJa6gMQVHBQguzs/zddB52demfY36IhfhOFwCAR1fFVB3GD?=
 =?iso-8859-1?Q?TrVp3K9jTo7dfjNgwldDOI+l1k7Nc7uwuKbwdrr7zfxxpXq9Ap3mce5hoN?=
 =?iso-8859-1?Q?MkbT5zyvlXmiVQEUPBPfdB/X71wDoSgXQ5VyZ6/GlovNHnWeh1BlWvJJ+1?=
 =?iso-8859-1?Q?BBdhfp3hFKTfN/SijhXt0PLC3TecY2uu8jbu42u8pedA0Ar8UoBWm3JruW?=
 =?iso-8859-1?Q?eFEmcP6/FPbGHFVhrRrxwNc64a2tRwjhv6OH/Fdn29y4qiP7u/WAjLBfeF?=
 =?iso-8859-1?Q?et12vT0oDeKfgG0maqR93LOVmIGmoN0Zb4cue7Wh/UQHoE3TwfvzKk8Xcm?=
 =?iso-8859-1?Q?QgvXkz1WIvsrMDtX5RVJMCW6hTM9z3i5ndD8Q5/vDRBmKU+FJNnb0yqsCZ?=
 =?iso-8859-1?Q?kTEMiZPaKto4pErAPs3wU6yFkpIE+yXfzf+pBSqM/3U2nkfyJWiGc+EGB5?=
 =?iso-8859-1?Q?mnVcSh9wX2iMkGgOSNcbNdgJ0Y7LQ2JsziJvMyrdc=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1612.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dc41a98f-2ae0-45cf-bd1a-08dd6b986cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 12:27:35.9531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2200
X-Mailman-Approved-At: Tue, 25 Mar 2025 15:56:16 +0100
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

Hi,

What is the status of usb boot for Raspberry Pi 5 platform ?
It's the last thing we need to use u-boot on Rpi5.

Thanks,
Best regards
Ludovic
