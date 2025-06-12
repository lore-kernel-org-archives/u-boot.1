Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A41AC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 13:07:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 878F582C30;
	Thu, 12 Jun 2025 15:07:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="EFQAQP7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F88582B7C; Thu, 12 Jun 2025 11:08:59 +0200 (CEST)
Received: from SY5PR01CU010.outbound.protection.outlook.com
 (mail-australiaeastazolkn190120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40d::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D4EB800C1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 11:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zone.Niuzh@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjNf8uKu/7VVJcqyWaVCg7aWvcCOSUZFYhSOzPgKsxB3Gx7i8OVnCYrcgyygF4hcKgG/u/+/gAh6KVlwFZaHvvsKdIge3rPow6maG7s9rO9f9tg9vHd4LHnRyXYpzxwY1arMnoPIYsmSbqfOR5Yj4ijgpjTQzHM0aeEhbcwueg2RglSWzxpvGm9pYpGsXY/9QFgiyHa6SCagI1MveYnmhn1gAkhJz/dPo5wSSkf7+0pCbg6XJGVGW96gJLvQKIxusJxnVTU6UTT5Zj4OBL67/6QidId8nOb1XOmo3sZ/LFrMCoAV99zdyzdNnhw/rSlW/VJB2SxJ2oXcOnN5R/2jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94m91mDYxbv3mkAATMnmHVaeitBUsANB5Z/2ZZhRKkk=;
 b=QFisf+pVar2fUy2vHGI+xq1u2mMbd2zWg8CCoNMyI3PGZ2QGSw3HIPAzwuUW0n9KhYOTK/Q8zw7G6qvnw1G46vUfDHCZpgCNMkRKu/afqFzWXuuTT55KqK+qZ8XgZ00MNShyl2NaYcNqilUK3twvu0YoKc/loofFozb03wh/9wacBs8nB2s9LulXpfWoF8P1UWjYoZhMDl7PbZCAOg83dM3FjnhFXMO3ACGbkipTcJElru4Zws0Wwq2BIGosgZgt3u2fKqgxm6NgnMBa7Aa4yAmKTua6T9M467HbKbMaOACpdMvsCAgiFdSSOu/F1Em3yBZk1qP5YzXn5lZ6NWin6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94m91mDYxbv3mkAATMnmHVaeitBUsANB5Z/2ZZhRKkk=;
 b=EFQAQP7git6znEh46utBX2aApvIRd4wqsPRdXk8zjpoqeYRwtMASrkLb+o1218/SszCYBgJMjCzD813GWauIPEe2a2CY/4GpjPnX18xOU3R+rqBthXZxZo0KewSjoOhnz3aHsyocd1ZbNyKAznpmzGDS4qKMUj2TdHbRMapsqCepFJL/KsnLp6qI+sFDEyWFXnYT7r+cBYJsu/UG/F/AvTiUwIr4QzsVt01gC+Z5w5SsIerlD/1N5LPabSK5H2aoK6WGgdkTJ5R1ILvyOVhpG6rNqhJu6HSGf7N4nCvmpzLUHmWQ0TzRJ3UXr1l1HZPETgKLm2cxyMYJ05Zm6ZimGQ==
Received: from SY9P282MB5677.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2d6::18)
 by MEYP282MB1797.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.20; Thu, 12 Jun
 2025 09:08:50 +0000
Received: from SY9P282MB5677.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9aa:cec0:e196:8380]) by SY9P282MB5677.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9aa:cec0:e196:8380%4]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 09:08:50 +0000
From: =?gb2312?B?xaMg1r666g==?= <Zone.Niuzh@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH, v2] bootm: Pass SMP core ID and DTB address for ELF-formatted
 kernels
Thread-Topic: [PATCH, v2] bootm: Pass SMP core ID and DTB address for
 ELF-formatted kernels
Thread-Index: AQHb23Q10lR1FyZIX02A1Hx77Ny8rw==
Date: Thu, 12 Jun 2025 09:08:50 +0000
Message-ID: <SY7P282MB567599431AB1E77FD46913549F74A@SY7P282MB5675.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SY9P282MB5677:EE_|MEYP282MB1797:EE_
x-ms-office365-filtering-correlation-id: 65ec3e13-628e-4fbc-2c87-08dda990bf4a
x-ms-exchange-slblob-mailprops: vuaKsetfIZlbZo6yxvkAsA7LbwgtrKxEwKl7Omxk0dFu5cHwN10znuZh34dZyXzuN6qxa2VM2FbOxAmes6MR8MLVFIvvLGFVVN70kgsIhHEvFZ2utUwVh7SNuLDOxwg5I61qz4rT4v8cw9h116xqLlNfLSw06FpDexb9ZZRHUesw8oeCPmwHWYIBysSwYe0FeFL0aDf7JA6UjBUeq8Dbc5AIFkco9n9GgkFwjOmZ7T0wCAhnG2qvPk0rgr4XFsbaEpS2mHyVioHlpbpNJlwWj7bpKi2kjV/de5Jyb+cMkXgeojApXRWsfO2RGwVQX38Zg89mE6g4gbWH9xLW67WsV6FwKqn+axM9uWj/ixzPTdlu5ptBNEIXf9ldDsClTWzVi6/GX3Gm3J+0D7oYRYYgSAI9hF4AcJpX9Zq1NrlvoRucX+ETvEJ9EvFLECbsQGEim69mnINcwXsB/vPe0rvj8xpArbrmTwr4INXwOdLF5XueIb3LMS0+Wh5cQg9pdplVcHKUQ6vFVmVQq+ns/i3Jlqt73608odt9rUXgGVS1mxr9gUYt8sf9QbKfN01yvF5tA3F0dv77K1Pq1sNB9n6pA9/QfVUC3FqhKTdX42NYoARevgeM2k4WkAT/qOVTJKIVW4NghNEKDfQwshybtr+O4LBatZn2YxMkOnM+wXSXROGtOlfVE3S3NyDR9u4DlSbOTT63Faa0KTnXUP0GI9FZ7oKaI4GVbZK6LIBJgftoOwOqj50YvZCKsc8Yw00g9yhSLEknZy83fR8qV/4mpfhjCJUHZZcY623AcJXd/3ii33gTE5YO7a00Zd/jXNYA1RwF
x-microsoft-antispam: BCL:0;
 ARA:14566002|8060799009|8062599006|7092599006|15030799003|9400799033|15080799009|12050799012|5062599005|19110799006|461199028|41001999006|13041999003|19061999003|4302099013|3412199025|440099028|40105399002|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info: =?gb2312?B?YzF0WWlrZzhBdDVaUXJ2YzNKbFZxU2hLbWMxaGRpWm0vQ2NKYjlJWE1ZLzJD?=
 =?gb2312?B?WnphZm56MEk5amlYTURCVkZuT0U3ZE1SaGFMVmNTalJ2T2t6VlBWRXozZmpE?=
 =?gb2312?B?dkVaa0JDb2xsWEpMTGpkMy96ZHlhZkgyaUhsMFdwMEVSMS9LNXJ6a0ZBRG9U?=
 =?gb2312?B?akpEUGhDRjdQRGtjYWNHbjVCcHBidUQvU3RnMCtSR2FJbDFGYWV4QTZJbDQw?=
 =?gb2312?B?WGJ0U1MwUG9xV1dZaGs2NVFpZTQ0d2xwc0xDUnVpOW81Z3VNN3cyNEp4bFRU?=
 =?gb2312?B?Z3JpWG9PazA4TmUxcVBWU3dNc3NwdGNob0lweTdxMTM2MytXeDcvSGp5dVlU?=
 =?gb2312?B?cEVsZWhabEJnSGV2NUVKQmE1d3dKcm5HRDVhOFNFNnM3NmFyMWJWQTFnNE9n?=
 =?gb2312?B?MWtJd0pnNi95MS9NQ2F6eGV3QXRsQWVGVUVHUXZJcmQvdFRNT3dhVGU1RG8y?=
 =?gb2312?B?YzdPUTVQMmJ4ZFBTYzVMSll2UU9ISHcrNmpaaTRHYjFwbStNUVdyL1VuRTRP?=
 =?gb2312?B?L3hCbmZPNmtqODJPR1N1dmhzenBWSFArVnlsT0tBUU56T0hxb1I1K08vL09C?=
 =?gb2312?B?TFdnWmdGQUNMRzRGZ0o2Y2k1TTNMT1BJMFlObDAwaUI1NStsWGxDTitySGFY?=
 =?gb2312?B?M0FGUlJpd0ZMekgwZUtHbXBCaXJGTHYyUnhWNW9qM1htZnUyNFN5cWRjbE1a?=
 =?gb2312?B?MW1OcjE5VmVFS2tia3NRN3RCSWVFK2ZEc2p3NmhUcjdINXhuTkp1azhabkRp?=
 =?gb2312?B?TXR3eFprcHhLVUM5YTh3NWpxOHFhOXRXYlJWaWl4OUQrMzZJaVo5cW15UmlZ?=
 =?gb2312?B?dExUUi9UL0hwSnI2c0NqZDJGRWo3bFB6RmFSVVNZT2Q3cUNBL2dMcFByam1Y?=
 =?gb2312?B?WXVKU09Qa3JvVVZxV2tzdkVMWXRvZGN2ZXRMNkRORUZ3MitZNmtmeWY2dnhD?=
 =?gb2312?B?OHEzZFdVd3BqUFlWQU14TjI2M1RmUU9sc1hMVk1zNFlKNlRMN2drV29ZQTFU?=
 =?gb2312?B?UlJ2QkpoeS9VT0tuV3dUbnhiRC9ZV2R1SFlpUUVhaUVDQWFJUVRIK3BUaXQz?=
 =?gb2312?B?N0d6NG1BRmg2UEhLczBPYURZeWZ0elpmem9VclZPRjdMVVJIODdROFBhc05m?=
 =?gb2312?B?Q2JYZjJUUlRQQ3ZqR3hVMzR5U3diMkF5eU1sSE9qOU84VlZmUTh4NDVZb2Za?=
 =?gb2312?B?NE5DWG9wQXE2NmUzd1NncS85OWI2R2ZFbEdMWjlYQkNDSVdodVdYMmNaZ1Zi?=
 =?gb2312?B?R25mUUdJRlFIbGZtOEhMa1dVUFJ3eG0rdGQwcXVDNFlNa0lDR2NFKzNYOUxo?=
 =?gb2312?B?S3dqczQ3WVRmMXpUaysrVUpmajhFNFdwd25yYVpZRk8xd1p3Z3lUNStWV3Zs?=
 =?gb2312?B?cGxneG0xMTMrdDFld2c0OHA2WXJLeWdYb0VzcTNTQ3FPa2ZqOEtaS1ZZaHBD?=
 =?gb2312?B?SHRHcDFKZzJZVzRaT21zV2l1SVN3VHI4cTNwa3labDlhOGNadE1ZQnN4dVZx?=
 =?gb2312?B?T1B4dDNXeDJGUGU0YTNKSEI0OWdUci9UVUJVUm5BdHM1eUhpcE9LRXVrOFNi?=
 =?gb2312?B?Zi9DWjNoSExZcG9WNDZ3b1MrZDI5VUxLc2lKaGdvY0t6YzZpUkYzZ1VSZWtN?=
 =?gb2312?B?cy9MTkZIcEs5QnlGZXg5b2xHKzF5ank3Q3VySk1NbUtBbnNUOHl2Z1Z3V2ov?=
 =?gb2312?B?OXUzQVIxTDlQVHFqQURRWTAvK1ZHREFtMmVpSzc2TjNVTGdHdlZRbmFEbk81?=
 =?gb2312?B?alJ0N3psN2hrekdRSFdkNk1Ed2xBbXRiY0lzcURveWpwcVY4NTRZanZLN0tY?=
 =?gb2312?B?VnMzWlc1ZThQUEZzOTRRRndBdHlva3JhSEVkUFFVelJjeW16VjBka3pHOExu?=
 =?gb2312?B?YnNINGZNM0tEbjlwL3VVWG5kV3Nhd2t2RGpEdmpLTStrR1lsUDBuL2kyM1dh?=
 =?gb2312?B?MFFIZlBwM20yaHhPdjgyR2N1MEtPN0hHbk5IRGh2R1Q1bmpXbDZhWVdTZDNG?=
 =?gb2312?B?YzRaajlkL0FxVlFqZ0FFQ3hoODhMbE9xdEpQSG8yb2pubkVnOVJoVUNabzZ4?=
 =?gb2312?B?WGtiZ2JyUmh5YWs0aWN0RW81c3hJUDgvcHRMZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?M3c2UmtYVEx0QlBHc1NxSGFMR0drZ0RldzVzK3FFRExDUFJ4bTJVTlRGUmtE?=
 =?gb2312?B?U25EZHduemFVOUpUVHp5THlIb1FKM2hDbjVTdFUxY241NnpseTFKTnRsWTdz?=
 =?gb2312?B?TVczTDNKSWgwbVpWY1J1UFdJMWVHV2E2aC96eFpYMVVpZXpXaC9ac2hQYWhj?=
 =?gb2312?B?TVYrc1Fpd1hVblhKaDIrRXlmWU9WN2xxWGFyRGg0THlUNjRRbkpuakFGai9J?=
 =?gb2312?B?TmVEamg0Y2J5YVRDTVZyVWFlUmJnNGhiRUZZbmN2SGlJU0dmUFhZcmR5dUdE?=
 =?gb2312?B?UzcwS0pwUnErTWxKNHN2VStnM3M3THZ2VXhNQVJtWTc4WFlVYmIxWGp4UlBp?=
 =?gb2312?B?cVFXSjFURU51V2RjNnByeENSMkVnOFBNeDdMZjc5c2NwYU5yMFFUeCtnVFJT?=
 =?gb2312?B?NEYyMVhJNEdkOVRVOVVPWG1PQnFHaWROKys5TGZ6aml3Sm1ySWdkaUJuWWdm?=
 =?gb2312?B?R0ZaU2tmbk5Cc0tHTWZjSFJYSWVWWENNSTUrNzAvQjFHSTArb1VLTlMvOUts?=
 =?gb2312?B?WG01ck5MRzI2UXNydXNPVW55SjV4bVFSZEIvOHEvZjhSK1l3ZGN6TXRUYk1S?=
 =?gb2312?B?RkpCb1lnTFNlY1ZjRFFvVEplenZXK2luSGQ5ek9UWTBVRll2WnU3djVJajRu?=
 =?gb2312?B?Rkc2TjNnTDR6ZkJqOFlJZGI1YjhXTGovbW1hK1Blemw3Rm0ranArZXFlNTFX?=
 =?gb2312?B?Q2VoQTlaN0E4SHI5QTFTOHZmVFp5SVhVajljVlFtNS9rMVdVWEFQby8zMG5R?=
 =?gb2312?B?VVE3RW1zOG1JVXIxMEgySjc3cGhCQWxBeXdxWEVkeEp6c01Ta2g4SlZ6enYz?=
 =?gb2312?B?S0RhUlNFOURnb0M1SmJ4WDQ0YXNXUlZ1b0lFRjB6N3piWnJiejVnUDZGY0Fz?=
 =?gb2312?B?S3JnYTFQRCtsSTFoSUhwVVNzZnUxMnkxNHY2cW1ycDdJaDB0cVRKY0I4T3BN?=
 =?gb2312?B?T1Ayci9kL1lEOTRYTjFkbndVR3U4S1U1NGt2V24yWVVxbG1hUGM4VWM4M0VC?=
 =?gb2312?B?STlhdlV3eG9HdUhWKzlCc1AxUXNXMzR2OHYzNzI4MlpRbHhBVlN4UWdHeE5Z?=
 =?gb2312?B?UDFDbUVSUHlwWWsyTTlqSWh1K1d4NDRCdzUrQ0RmUEM5RXFJYVZZTDIwQ1VN?=
 =?gb2312?B?T3d5eFgxUDFmbnhwR0wxZ3JqeThnSTZjVFJNVE45YTJpRnJzWmt6UGJnTEsy?=
 =?gb2312?B?aVd4VnBEZUw5UFlyZmFXY3Y4OXhlU2E2dzE5dDNtQUpUd1ppUWIvNzhBZGIr?=
 =?gb2312?B?TGRmNG9rNzdNUTgzNW9MMy9Wd0FGNGRFZzZwSHB2bEUvOHhoOWJTWEwyVU5Q?=
 =?gb2312?B?MkxpNThzV0x3RzhpUm5qSUdvMGJYRS9ZaWRqQnRld0UwczdFbVZFWExIWHFK?=
 =?gb2312?B?TlBsOW1ncHRFekhhenpsSVlYVStQc0J4Y3lraDZkNlJyZjVEamsyYW1ybUFQ?=
 =?gb2312?B?U2ttNmZ3dTFlTHRXSGd1N0RiME4zSkVkeXRhWjNPRFdoMlo5clRqWUwzVVdY?=
 =?gb2312?B?RkE0OVpTVDJUV05MckN3eVFZVFhiR3ZQNSsvb1hSS0ZzLzBwQmpwOXR5cnZG?=
 =?gb2312?B?eGRVQkpJU21jbHYzUlYvUVdOWVM2a0FKa1hQQ0VYbGNMQnRSbytFZTZBQ2Nq?=
 =?gb2312?Q?Kj4IE4xbsX+mOyv1Gl3SLHBsml5JYc9FMuQzw5BvER2s=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7807-9-msonline-outlook-0c92f.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SY9P282MB5677.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ec3e13-628e-4fbc-2c87-08dda990bf4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 09:08:50.6054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1797
X-Mailman-Approved-At: Thu, 12 Jun 2025 15:07:04 +0200
Content-Type: text/plain; charset="gb2312"
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
dG1haWwuY29tPg0KLS0tDQpib290L2Jvb3RtX29zLmMgfCAxMSArKysrKysrKysrKw0KMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2Jvb3QvYm9vdG1fb3Mu
YyBiL2Jvb3QvYm9vdG1fb3MuYw0KaW5kZXggYTNjN2NiNTMzMmUuLmQ5NTQ3N2YxMzQ0IDEwMDY0
NA0KLS0tIGEvYm9vdC9ib290bV9vcy5jDQorKysgYi9ib290L2Jvb3RtX29zLmMNCkBAIC00MDIs
NiArNDAyLDE3IEBAIHN0YXRpYyBpbnQgZG9fYm9vdG1fZWxmKGludCBmbGFnLCBzdHJ1Y3QgYm9v
dG1faW5mbyAqYm1pKQ0KaWYgKGZsYWcgIT0gQk9PVE1fU1RBVEVfT1NfR08pDQpyZXR1cm4gMDsN
CisvKg0KKyAqIFJlcXVpcmVkIHBlciBSSVNDLVYgYm9vdCBwcm90b2NvbDoNCisgKiBhMChhcmdj
KSA9IGhhcnRpZCBvZiB0aGUgY3VycmVudCBjb3JlDQorICogYTEoYXJndikgPSBhZGRyZXNzIG9m
IHRoZSBkZXZpY2V0cmVlIGluIG1lbW9yeQ0KKyAqIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9j
L2h0bWwvbGF0ZXN0L2FyY2gvcmlzY3YvYm9vdC5odG1sI3JlZ2lzdGVyLXN0YXRlDQorICovDQor
I2lmIGRlZmluZWQoQ09ORklHX1JJU0NWKQ0KKyBibWktPmFyZ2MgPSBnZC0+YXJjaC5ib290X2hh
cnQ7DQorIGJtaS0+YXJndiA9IChjaGFyICoqKWJtaS0+aW1hZ2VzLT5mdF9hZGRyOw0KKyNlbmRp
Zg0KKw0KYm9vdGVsZihibWktPmltYWdlcy0+ZXAsIGZsYWdzLCBibWktPmFyZ2MsIGJtaS0+YXJn
dik7DQpyZXR1cm4gMTsNCi0tDQoyLjQ1LjINCg0K
