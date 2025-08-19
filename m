Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4CBCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 14:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE8C1809A5;
	Tue, 19 Aug 2025 16:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="W18pI77D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E4682BF6; Tue, 19 Aug 2025 15:23:10 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F705802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 15:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=J.Remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKQflR6YO8afelaTWIcuX0KSkXQ2P10tuyRvXWh84H4Vn/3ukJc7ezur0y7vZBb+uBMbVqLh8gIdXYffhK15OCeVX45B9ngXdFlIsa2FYGjf/+rpIxWwmVb7GtO5ScN6IinutC5t1yCrTsGC7fosIl5jK/5Pk300y9YNTMKeGtzfVAQf+19feXrGd4Ojr23KNFNoKOUrx14OFwys1r1zQbm+qvJwJWJP81FDCa3AAJVH6gGHf92fDWdnEc1BTnYoO6+jIiCcGQPfjQkGZCV/GhXEyruulweACcPOtmis2FxW4PQm+8dmPSDjvY8ilh2yXV41g5GC0rkLs6UQsK7GkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU5wCdJogB5llMWQ9/e5kKF/9kcrEZZtTloQjuCAeas=;
 b=NBql+fhsEV7KFlxI2e/NnS0FvGa+M4lLEgvrU66gNSIiONz0ysrKyMQm0f6h9/oaZIfolpqIQ2MGlLg+DrIAAwJWC/8ZHCOJlDUs89hP+mVE+4MUsKc0VMznlSRtvqKXD1vwf0Ckw5vr89qydBITc1pUoQwkuS9IlXASWl+nzE0pcSNn9KS8E4i5Jp2w6iTDhZKGvAjfbEjjejP1hXeuAXBU/pjFqQlehfSo94g9hWapuknWPPuGiadmrQxtEwq9O7hqPxqpgSHKdzWyh+mJ/8lYqT+nYsGCAoxK8L5QtkdsEofE/OXlrXKxIu9RRUk4uHAyPhCdOJXc9BAHAVA+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZU5wCdJogB5llMWQ9/e5kKF/9kcrEZZtTloQjuCAeas=;
 b=W18pI77Dn84BSv/3tB3j0Qiqd473JWqriwc1SwJRQixe14rKZO+JptknjqhT1Ezu0nDioBqwOpBTwhU9ZFPPdAKq8IL4DWmjxRY62oqDQhsuyEY48JLyTnxMobVBDFZhB/idomSZlS2Z/c9x5dlHywKJ7RKRPRFbJ55Vyb9i1ThDCPywjuJpmx1cd5B7CbYUze83oVMVbOrdp3VmuSN5+I8mzSnXhuEliySWcpZMlTaOGvmFOPMTNT5pSyPJG/2rbCkUf97nmb2tBkX6k6bVxM8s7P3xt45uskVNeGStNXpBMsFouBBJ9R8HrE65O0QQw0UENWcldTf2IX6mUQDnGQ==
Received: from DU0P195MB2325.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:425::22)
 by BESP195MB2906.EURP195.PROD.OUTLOOK.COM (2603:10a6:b10:ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 13:23:05 +0000
Received: from DU0P195MB2325.EURP195.PROD.OUTLOOK.COM
 ([fe80::ce58:6abc:a395:f7c4]) by DU0P195MB2325.EURP195.PROD.OUTLOOK.COM
 ([fe80::ce58:6abc:a395:f7c4%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 13:23:05 +0000
From: Jan Remmet <J.Remmet@phytec.de>
To: Benjamin Hahn <B.Hahn@phytec.de>, Yannic Moog <Y.Moog@phytec.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [Upstream] [PATCH v2] Add imx8mp-libra-fpsc board
Thread-Topic: [Upstream] [PATCH v2] Add imx8mp-libra-fpsc board
Thread-Index: AQHcDSMAnJ/FZGFlkEeeTWqLDaDEMLRp/oMA
Date: Tue, 19 Aug 2025 13:23:05 +0000
Message-ID: <fdddfed8-3d62-489f-ba44-608e7c727bc0@phytec.de>
References: <20250814-imx8mp-libra-initial-support-v2-1-9b91d437ea48@phytec.de>
In-Reply-To: <20250814-imx8mp-libra-initial-support-v2-1-9b91d437ea48@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0P195MB2325:EE_|BESP195MB2906:EE_
x-ms-office365-filtering-correlation-id: 469fc71b-444e-405f-d2d9-08dddf2387d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ODc2ZzMvOTgyY0p3RVhBQjhHOU5JODMwWURyYSs1ZWJhallFRE1pVnE1QjQv?=
 =?utf-8?B?VExDUFBFSzErT0s2MjIxdGNpcDQ0NkVVVEdzd3VpTUZzbDIwZ0RscmtBamRl?=
 =?utf-8?B?bzhkRmZKN0w1QnlVOFliSERlOTExdzNwSmV5Ti9nUXprbk50ankxc1BBbHBO?=
 =?utf-8?B?S2x0MkJ5dXZxM3hHUm9vOWxxRnpwbWZreVZzeUxaYTNpbk1TRUVhemJQd1dt?=
 =?utf-8?B?dHF4emxJUGFyeml5TUUxZXV2RjZnTGpkSjhGYnN5WUJpRFZ4QnI3UUZnek16?=
 =?utf-8?B?MGNyNEV6dHFYYzNlMHZqWlczRWJTVVNrTGJuV3VSUDhhTys4NGYySUVjV0Rz?=
 =?utf-8?B?NWxoM1pGL2E0M2laT2pMMVpmczJFRkZJVlo0OVFRanozZFZSSU55M3d0RlA0?=
 =?utf-8?B?N2JwakNHVlZaMThwbUF4Vms4Yng4Q2RSTkl5bkxCVkhGckJRVEtFNzJUNW5Y?=
 =?utf-8?B?dU82cXp0OHhvNjk2K1p0Ny9BRXRkSlAwdjdudDBBYmhHTk93azlyZlcyZGF4?=
 =?utf-8?B?d3pLUW9MV0NtakQyN3BKUXk0aVIyRStGTHNsTTJaTXlGQmswbGpIblcxdXpE?=
 =?utf-8?B?V2dGaS93TzhDVFhabnF2bnlCZzBmczNBd1UrVjUyaE5zWEovSnFJTmxjSGpB?=
 =?utf-8?B?c2dMdTlYeC9WcGI2bjFZWjNmUnJpSXF2RGYvaE13aVRYenJWdk5nRzRQaU9m?=
 =?utf-8?B?LzUwbGVtdC9MVkhXN2JyRkRwTEt5SEN1ZDlySFB1M1ZjTEdWb3E0ZFBXZkxt?=
 =?utf-8?B?SVFMRU9wVzA0eklFVU4yelZOWUNCaU9iL05JZ1ZvTko3eVBnNXZEL2U1QUtM?=
 =?utf-8?B?RkxVeThMckRiUGczOFVNK3NKVno2M0JhbXFyc25TNXpVbnNTSVpycWtQZ21I?=
 =?utf-8?B?RkRhSitRUFFtNXZCeEYrem1sdjBsUU82MmlKbFBYUEFBQ1BodlZ6dXJyUDNU?=
 =?utf-8?B?NUFLOWloRm50dmd3dE9DOGU5bWVZVWhDS1ZkZlNpK2dFc040QzJaemtHZVly?=
 =?utf-8?B?RUF2YUhzV3d6UjBjek4zUmtOekcvNGZkTTVOZDFyVHh2VWUyeVZveFZHK1d6?=
 =?utf-8?B?TUJHTmtQcm9BczdxcktGMG1nbEF3LzRvbG9KNEtNWmp0ZzQrb0ZvYVU2VWhW?=
 =?utf-8?B?c240Qjc0eDBFeU5VUWxJN2pwYnY3VXdCUUVFNzl0QU41RWo1ekk1YmlGMkt1?=
 =?utf-8?B?ZWhEZit0ZFhNVzJuSjFYdm1zeVhhVEdkZ1FkSkpKT0IyMDcxa1FkT0s0SVds?=
 =?utf-8?B?N29NS3VIYUNZOVdqUDJhK00xRG90Wk1zN0FxaVMvYUswaTZ3alhZcnRjK1NI?=
 =?utf-8?B?cVZGRy9PS2VlNGRVSW9YRHZwdjVwMERjNGQ5NE5HVWZGd0lOUHlqSThDeVIy?=
 =?utf-8?B?Tnd4Y0xrcHhHWUF1SUllRHVheUFMYVZ0ZUhlRldOM0d4OFAzUUZKYUMwNlh0?=
 =?utf-8?B?ZnI0Q0k2NkVIRjJhcm5udkNCc295WjRuK1pSVVRRM2RjYW1QZ3JwMHdaSWE5?=
 =?utf-8?B?NXdJb1IzUS9OK0x5LzJuZVp4NVExaUw1YnhMWFE2cFpraUk4cUJGMTRtdG1F?=
 =?utf-8?B?VUo2YU5obzJISmticVpzR0F1SU5nTy9rS2ZxRzZwMlBPYVpsWmUrem1xUFNN?=
 =?utf-8?B?czY0Vk5RQUdnM2JZdWs0VzNvTWl5czFELzg4ZFhwbjRNTkY0Z1dkcVYyZTRv?=
 =?utf-8?B?c01pUmRkcWRqNlh1eEVKN3V0cVMwZ1NvLzNRZVoxMkFNdi9JSWNhZlBDWHJ0?=
 =?utf-8?B?WjZoVXpRYlMrOVQrK2o3cjc3L2MyQ0tYVm93aXRlVGlDWEhnUk5vOU9vd2dq?=
 =?utf-8?B?MUFNQkE2bThSdjVRS0NDaWhnckFXeFI4ZlZSNUV6aXV1N28xMnpKQlRwcVBv?=
 =?utf-8?B?bmxacnhVR3p0TzljL2orWFBJR1IvTWp4VTkwejdJTERXK2k4ZmhsdkNTZVll?=
 =?utf-8?Q?svVYWARZEmI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0P195MB2325.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3dud3BmL0dMSVdpWFduZFF2OHo2TlZIRE13UlFRNThzQ2Q1a1k3NS9aM2dB?=
 =?utf-8?B?b0V4YVdOaHJWKzNQdHZPbHZZV1FrbHRNWWFNaDF4Rmt3NTNURTBYWmU2Qy9w?=
 =?utf-8?B?TFpZdnpNWEtCUEYwUE92RlFBTWkybmkzaStHdHBRU1J6K0cwbmRQRG1RTEVZ?=
 =?utf-8?B?dHM5dmJQMnRDY1VCNnN2cUZIcjRiZUMrcnIyV1VhT01SN3hoUEsrN2NxT2I3?=
 =?utf-8?B?TGl6MW5ld0ZLNjQ3RzJpNmxabGRSc2lRUGlSTzJOanRTSlJ3WjRYaFBwWVhi?=
 =?utf-8?B?bjl0L2NLM0ZJQ201aUt6Mkh6aE0rVVRkNGxpK2QxUVhwT0RMWkp5L3BBTGM4?=
 =?utf-8?B?LzI4QTBIL0xsVkgzTlRMc2YwdG9hNDJDWmtwUjk4bitzNUxnWGZWOWpVQWVI?=
 =?utf-8?B?YWxrUExyRWJlWVVHaXcrVCtIZWFVeVJid09DSU95Wlp0ZTByNVhhbkxvOE9h?=
 =?utf-8?B?dFFwN1M2ZzZCWStNUjRzZllTSVNabE5tbDZVT1Z1NGxIK0lDNmhqdUVLNmRL?=
 =?utf-8?B?WVdGdnFxZGMxQ0FYZDBhVkh4S0NscUlueXVkcll0L3ZsRlBUNldXcVJOZWdr?=
 =?utf-8?B?V1lCV0hKSTl1TVBzTTdZVXh0eWZIR05PYjhOOUJqaUQwN09HQjk5RzQxdVRv?=
 =?utf-8?B?ZUxOZThEU051NkFoZWE5azN5QXdwN1JDbit2aElWNmJPbWExYVRVeHNmaGhD?=
 =?utf-8?B?YXZXRk1XdFhpczE3bGQ5ZkM2MjJnUzFYQnhFdktBOUxySzNiUGZEN1lRQ1Rs?=
 =?utf-8?B?Y0JwZWFuY0gzTFQ4eUY0MHRiWkRMWjZEdDJINWJKamVmVXpWZ3A1VTJwd1dS?=
 =?utf-8?B?ZjJURUdjeHBwdjhOQ2hBRGpaWE02Mkw1bmNUa1RndFdoNGIreVFycnNpSlNa?=
 =?utf-8?B?aUQ3RHFMU3dVVUpKcHE3NkYrdFV2ZDhsZEVPa3JZVDI1MEluN1BjSkZlRDdR?=
 =?utf-8?B?eDVKMk5GSmZIb21vNGtCekYyVmxTNDRqWUFlS1JKa3pKbjJyTm5xeitLcjZP?=
 =?utf-8?B?RFFDNWhzdk0ybXAwVC9HQVVkMjBoODlIVDdjNHBuMXdCd2FWbVlLQzM4Qjds?=
 =?utf-8?B?SWtYQms0WnRIRmpUd3VBVE9GWlgzSlVxUW9HU0hQei9ISEovbUFlS3VETWlh?=
 =?utf-8?B?L1EraWtQcnRNK1k5WkJlVDJqRERqM3BiaVJxVllNZ1FHclRJbW5ldEVYZTBm?=
 =?utf-8?B?U1ErbXJhQlR6bjlabXdCYkhJWXg2ZnFaT0hoWHRjaUZ2Mkh0S09ybmkwTEFX?=
 =?utf-8?B?czNNRDYrMXExWHJpWU1INkNYSTVPRWJsd2ZTNFo5ci9mcGg0Zy9zWGZmS0NB?=
 =?utf-8?B?R1RCT0pLUUU1VmVuZWJLQTN4djEwQjdvbitDZnRrd2VCby8vbkY5YWlkWWgz?=
 =?utf-8?B?c3dtVnQrcEZwUzUwcmpSdGpwVnVIVDNncG5CZzVSTmtOcUtIUTFZZENLM3hn?=
 =?utf-8?B?OGJqR0pxelFQZVVjcFlSS3l6cWlPMXVWeklwSVJ0Wm55K1FUbldEbHk4cnRH?=
 =?utf-8?B?ampZNkdSNENadTl2QkgybElyd25haGZMd2FiOHBtSzAwWnNNTkVCWTVuMUdt?=
 =?utf-8?B?Uytxa21TWTNKWE0rRWVscXFQK056anU4OGtGN1JpWjQ0d0tGVHlHZjNVbFR6?=
 =?utf-8?B?ZW5QelVBNEt3dVpZaThERTJDSTZTcmZjU3VSZDBxODdvcTVUQ2tYdDZnNzh0?=
 =?utf-8?B?OTZFbkJ2VE56OUpzTmxOM3NteWRrc2pBUklISFNIMURtbENNaGQ3VWYvaEN0?=
 =?utf-8?B?MjN1QnNsckh5Z1l4aXpqa1haMFN1ZytjSTgrVDZ4OE9VaHoraVgweHZCODFy?=
 =?utf-8?B?cXVvb3c3ZVZXcHRmZzFVRU0zMFlha2Q2VDVtZXh4R2VKMGRSUkd6SVhYUWwv?=
 =?utf-8?B?MC9OQWxpNTRldmNUa1IxMmZHdGZ5eGZUZGdmRlhMQkcvN0I4U2JJYll0MDZo?=
 =?utf-8?B?WlkzbUZWUzB1MElYNmZvWmlJbnphM0ZxNHdRNDhlYUgwM3NXYllKKzFRUno1?=
 =?utf-8?B?T3pkeFpPeUE0dGtMVlkyU1h2VTBXWDNvNkFRaU9XdzBDS00yZmN0SXRsUURP?=
 =?utf-8?B?QmlGQ0dmNDlvbElOYTNnUWNtc3JQQzFoRlBSTDIzUkNoeGYzVVFqL0UwZ1FH?=
 =?utf-8?Q?62SfiRPPo2Y5hTBSlQZRrgoiz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62E01CDABDDBCB4BBEE250AE8B4BEE5B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0P195MB2325.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 469fc71b-444e-405f-d2d9-08dddf2387d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 13:23:05.1849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jwjhYrC80ilWdIXtEjB2OxpRedV5sR+4nEtzmD5fh3Yhvwwf7Bk0o1+C1hzj1x/3lzh/4vaX2JFNJsgsXoxDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP195MB2906
X-Mailman-Approved-At: Tue, 19 Aug 2025 16:35:36 +0200
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

QW0gMTQuMDguMjUgdW0gMTU6NTQgc2NocmllYiBCZW5qYW1pbiBIYWhuOg0KPiBBZGQgbmV3IGlt
eDhtcC1saWJyYS1mcHNjIGJvYXJkLg0KPiBVU0IgaXMgbm90IHdvcmtpbmcgeWV0LCBhcyB0aGUg
ZW50cnkgaW4gdGhlIHVwc3RyZWFtIGRldmljZXRyZWUgaXMNCj4gbWlzc2luZy4NCj4gQm9vdHBo
IHRhZ3MgYXJlIGluIHUtYm9vdC5kdHNpIGZvciBub3cgYW5kIHdpbGwgYmUgcmVtb3ZlZCB3aGVu
DQo+IHVwc3RyZWFtZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBIYWhuIDxCLkhh
aG5AcGh5dGVjLmRlPg0KPiAtLS0NCj4gQWRkIHN1cHBvcnQgZm9yIGlteDhtcC1saWJyYS1mcHNj
IGJvYXJkLg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBSZXZpZXcgY29tbWVudHMgZnJv
bSB2MSAodG9vIG1hbnkgdG8gbGlzdCB0aGVtIGFsbCkNCj4gLSByZW1vdmVkIHRoZSBmaXJzdCB0
d28gcGF0Y2hlcyAoZGV2aWNldHJlZSBpcyBub3cgaW4gb2ZfdXBzdHJlYW0pDQo+IC0gYWRkZWQg
dGhlIGxhdGVzdCB2ZXJzaW9uIG9mIHJhbSB0aW1pbmdzDQo+IC0gYWRkIG9wdGVlIHN1cHBvcnQg
KGxpYnJhIGlzIG5vdyBpbiB1cHN0cmVhbSBvcHRlZSkNCj4gLSBhZGQgQ09ORklHX0NNRF9NTUNf
UkVHIGNvbW1hbmQgZm9yIG1tYyByZWcgcmVhZCBjb21tYW5kDQo+IC0gTGluayB0byB2MTogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcyNS1pbXg4bXAtbGlicmEtaW5pdGlhbC1zdXBw
b3J0LXYxLTAtZDk5ODJkZjIxYTRiQHBoeXRlYy5kZQ0KPiAtLS0NCj4gICBhcmNoL2FybS9kdHMv
aW14OG1wLWxpYnJhLXJkay1mcHNjLXUtYm9vdC5kdHNpICAgICB8ICAgNzggKw0KPiAgIGFyY2gv
YXJtL21hY2gtaW14L2lteDhtL0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwgICAgOSArDQo+
ICAgYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1mcHNjL0tjb25maWcgICAgICAgICAgICAgfCAg
IDE2ICsNCj4gICBib2FyZC9waHl0ZWMvaW14OG1wLWxpYnJhLWZwc2MvTUFJTlRBSU5FUlMgICAg
ICAgICB8ICAgIDkgKw0KPiAgIGJvYXJkL3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9NYWtlZmls
ZSAgICAgICAgICAgIHwgICAxMCArDQo+ICAgYm9hcmQvcGh5dGVjL2lteDhtcC1saWJyYS1mcHNj
L2lteDhtcC1saWJyYS1mcHNjLmMgfCAgIDk5ICsrDQo+ICAgLi4uL3BoeXRlYy9pbXg4bXAtbGli
cmEtZnBzYy9pbXg4bXAtbGlicmEtZnBzYy5lbnYgfCAgIDI1ICsNCj4gICBib2FyZC9waHl0ZWMv
aW14OG1wLWxpYnJhLWZwc2MvaW14aW1hZ2UtOG1wLXNkLmNmZyB8ICAgIDkgKw0KPiAgIGJvYXJk
L3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9scGRkcjRfdGltaW5nLmMgICAgIHwgMTgxNCArKysr
KysrKysrKysrKysrKysrKw0KPiAgIGJvYXJkL3BoeXRlYy9pbXg4bXAtbGlicmEtZnBzYy9zcGwu
YyAgICAgICAgICAgICAgIHwgIDEzMiArKw0KPiAgIGNvbmZpZ3MvaW14OG1wLWxpYnJhLWZwc2Nf
ZGVmY29uZmlnICAgICAgICAgICAgICAgIHwgIDE3NSArKw0KPiAgIGRvYy9ib2FyZC9waHl0ZWMv
aW14OG1wLWxpYnJhLWZwc2MucnN0ICAgICAgICAgICAgIHwgICA3NyArDQo+ICAgaW5jbHVkZS9j
b25maWdzL2lteDhtcC1saWJyYS1mcHNjLmggICAgICAgICAgICAgICAgfCAgIDI3ICsNCj4gICAx
MyBmaWxlcyBjaGFuZ2VkLCAyNDgwIGluc2VydGlvbnMoKykNCj4gDQoNCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtaW14L2lteDhtL0tjb25maWcgYi9hcmNoL2FybS9tYWNoLWlteC9pbXg4
bS9LY29uZmlnDQo+IGluZGV4IDc0NDE2YTc4ODQ3My4uY2I0NTA4YTcxMTBlIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybS9tYWNoLWlteC9pbXg4bS9LY29uZmlnDQo+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtaW14L2lteDhtL0tjb25maWcNCj4gQEAgLTM0NSw2ICszNDUsMTQgQEAgY29uZmlnIFRBUkdF
VF9QSFlDT1JFX0lNWDhNUA0KPiAgIAlzZWxlY3QgSU1YOE1fTFBERFI0DQo+ICAgCWltcGx5IE9G
X1VQU1RSRUFNDQo+ICAgDQo+ICtjb25maWcgVEFSR0VUX0lNWDhNUF9MSUJSQV9GUFNDDQo+ICsJ
Ym9vbCAiUEhZVEVDIExpYnJhIGkuTVggOE0gUGx1cyBGUFNDIg0KPiArCXNlbGVjdCBJTVg4TVAN
Cj4gKwlzZWxlY3QgU1VQUE9SVF9TUEwNCj4gKwlzZWxlY3QgSU1YOE1fTFBERFI0DQoNCkFkZCAi
aW1wbHkgT0ZfVVBTVFJFQU0iIGhlcmUgbGlrZSBUQVJHRVRfUEhZQ09SRV9JTVg4TVANCg0KSmFu
DQo+ICsJaGVscA0KPiArCSAgaS5NWDhNIFBsdXMgTGlicmEgRlBTQyBpcyBhIFNCQyBiYXNlZCBv
biB0aGUgTlhQIGkuTVggOE0gUGx1cyBTb0MuDQo+ICsNCj4gICBjb25maWcgVEFSR0VUX0lNWDhN
TV9DTF9JT1RfR0FURQ0KPiAgIAlib29sICJDb21wdUxhYiBpb3QtZ2F0ZS1pbXg4Ig0KPiAgIAlz
ZWxlY3QgSU1YOE1NDQo=
