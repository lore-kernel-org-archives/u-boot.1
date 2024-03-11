Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816D9C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 11:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0967C87F70;
	Mon, 11 Mar 2024 12:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="prEgCGNU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA5487C48; Mon, 11 Mar 2024 06:40:26 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20800.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::800])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A971487513
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 06:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hkang70@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8lcgqQnh4gy/CYLaO6UA25/6qjdZFEkBc7tIoLQI/iVrTcLPYUZRYb9Irmb3UJHyPDrRT4Z0YoscdJ1dC45HMyvWuKDr5p2UMk9qJ/UzfUHbKpKA7GhqGMaTVipDk3yp+z3b1rjS0ce7vzKggGINOAIKQbhr77Oq8RZxdJzET536ZmzWug/rxS2vBU0c4ByRuQQWO9z4S6DvmcYkyheY5gYe9eslSkfeelst4+g7y/YLrzysRdVYyjCpDi7dxu1AW6paWG/eqA7baC5xfj2wVmDbQme+v4DMYv4TMUBo3MdoiwaPht4KyuBLFFeXROpWZYIMv7Vfa+zvJmvTEpw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rStpiM90Diy1yHO7ordJJr6D5m/657nam29ujrMjHA4=;
 b=FhxZpwFPkt1X6rtaDC+T9AzSb5HAABP/VElFGMB/A0/jPl4QUCW7IyIh5YYDlFmsJqMRF/f08paERPslF6g7fYK6FPZmtfvyWNsqq6e7lFydin2RVJPm+ApMXSQMpZ4rJpnFOOEAnjjySNnErHVH87SZ4vi380MBsA/Q0Eyws04P8Zn6BjOwgrT2L2r/uLSUoO2ZJDzh16jDsBobAGkfLzYm3mKvp4JcPtWPcKVQJRKWHmf0f5Dvt71PHCcIAO6czqGh1sB7Fi0bjE/SfEUAkhW9pANgtZgYomZsrV1fJiL7Q6xkXZ6PLvvK2ZFrXQTdZO7zn/f89OwTXQMwm/6zlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rStpiM90Diy1yHO7ordJJr6D5m/657nam29ujrMjHA4=;
 b=prEgCGNUJKqSE9l+A6w9V990jFLj0E8Cdy2xSgFtBD2g1gJ0dRpvT+s1XS2hqC60lVsv574i+d7fL8QU0HCEgbtkLPGkGucbjc99Q6nDcu1ZPc1PCGtT/m/5h0h60JTlGL8yNqDWgnRIxYTk/V+SAdBfAZn25Yb5BCS8j6oOG80R6N3ARs6ct+A/+YgKZnmKSP/3O6ilUCcNxcX17DN5LiSjkMhbKmu+Fyt2ONEAs1JhpXBEDTiRPovKPfHzzZAqPSlnmXB+XH2F3uIVnqep4BV4gm+Q87PC2I8M6e2kFX7Nx/+63cA7zuHdMaSYM20sqYsoDifomX61X1VFg/Cemg==
Received: from SEYPR01MB5364.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d2::11) by SEYPR01MB5696.apcprd01.prod.exchangelabs.com
 (2603:1096:101:14a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 05:40:19 +0000
Received: from SEYPR01MB5364.apcprd01.prod.exchangelabs.com
 ([fe80::ceec:ae93:4bc2:4637]) by SEYPR01MB5364.apcprd01.prod.exchangelabs.com
 ([fe80::ceec:ae93:4bc2:4637%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 05:40:19 +0000
From: Kang Lion <hkang70@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, HOON KANG
 <lionkang70@naver.com>, "lionkang@wavetc.com" <lionkang@wavetc.com>
Subject: About U-Boot License
Thread-Topic: About U-Boot License
Thread-Index: AQHac3aPmIxv58JRBkWKy3nUScEAHA==
Date: Mon, 11 Mar 2024 05:40:19 +0000
Message-ID: <SEYPR01MB5364E20BEC422DCA667399F5A3242@SEYPR01MB5364.apcprd01.prod.exchangelabs.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [UGAYqyhWyapJhJrOVfvZ+oDvkPQ60QOM]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR01MB5364:EE_|SEYPR01MB5696:EE_
x-ms-office365-filtering-correlation-id: 1ec19e7d-51cb-4da9-c7bd-08dc418dbcf7
x-ms-exchange-slblob-mailprops: q6Zzr5Fg03HT/KpNVnxolKAsmCSnipDbnW6G/2d96Vs2FwwTqEuZmM3h6IHWnpvrl1dltKSL+1BOe8GOEH1mixiEbu3aO871SN13CQcKFwM2fx96ynZ4vDpO0x9mO4RKpWfWToPzJemNxkeqVE4GUtAgsKumZrVKDgcD9YAAzMBNhQ4ngicotUwfzoDJT31eMoJEgxxcgsmj/Mjx5AYNjBXm3fDcmtKuDD0tIIrFRTH8A355ieowUF/21gbacuXdb8ForjVVk/zvvVsXuABuewIfflNgpxKBzHJqFj861wBsZRPeAEqisHg2flyztH0NdYApXyCqig8ycbvW2guteNkPgKVSQS5TYI5of6QWhHT5W0ZXk2CptUnLczjuU4nlUHKEwISR076o12tHAqF/x5w0xYF/DE+4mlFcWFnNEvskMr4ra0n4oAmQEKkwp+b4FR3Y4DOe2w0si7FZJofJcrqnggUIa+/o7E0lscNBpXijkh1YE/oY85jZT1k0xuXv/hj6EiHfwJndgg0O3MQ2Z1bwGZmr2x7LIrkCIXF3Ve6cVnfLXOWucewHE/O3O/pgwHmwhed13k3azV86cy1Xk+K3nPwaTbCckh6if8wOYvxtpQU6b0yQRYGY9JIgs/+Kbu8JB1e5IBDTq3X4wa+9g+psL418RtXO5qCnZr/N8Ts79i4dBgmOkrDP+PY7aU3x
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lol4tnUvDMld9UJxMNTacOSkNCyqHVTE5KJ4YaDmE5tZ84sFSNVfOqmg3FfEXmojH1C965rhVGldYdK36bu0t+xiJF3mn5wmhn3q/cgkTW8d2dWumF26xh/bGSijDpxBxnv6DBMvZgKqfQN7scf+bOois8QLjVId4AbEwQn8i6cVr/Vb6Qb0RQ0K42dVzNUbXKM987zGRH7xSoCMS65dC1RwJoofqQdfVzMAzN2LtHKN0R1Y4k4zDheExblBOh+ImvNxI+Z40x4NlKS4b27BlDfXorW6rd/DeROX9TwbPvNlQHXWgXIV7R+qnGjC3VFchSvtGaWgXaph7GDghTBmkIC5sHcoiUYHOjdUGxHELmzfoTup2NuDBVyJiSuImw8rN8bUd8ovSzer2X24cDZHhftSUq3+ZVqp7ypJVz4rB1yrW/t/8cXruMV4SOiO2+8IhqQKqE1ToyIvINm1C2H9dRwkJQ6U93ADOa8uKteRXc/QM1McZTim+PuUaehiCEh+rU220sRooQ4TDA8n4k8Eoq5DhWxJWBF8rOPlCcxMeXE4sm+wW3Q1hDws6mKL+KBG
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?ks_c_5601-1987?B?VUVUWEZkLzRQUHAvWG9GcnY2b29kNnZyMERucDg1cXBiLzhZYkUy?=
 =?ks_c_5601-1987?B?SEw1cElaSWVKV0YxalQzcUk3MlVTWStOeHg4MHJDQkhVcC8rNTNv?=
 =?ks_c_5601-1987?B?RFFDL1RZbU5ab1NIMHBjcDA5TEt6Z2tmYWJJQklsN21GL2o5bk9v?=
 =?ks_c_5601-1987?B?RkY0RkM5QWwybVJBb0lWWVhHS3pyNnkyR0hYZlo2OUg5OUt6ZlpW?=
 =?ks_c_5601-1987?B?WEI1WXFoMzkzRDBGckg5ZzFqTFVYaW1VYlE0NmNkUnRqb2oyWUFL?=
 =?ks_c_5601-1987?B?c1RId0hhNTFVY0lsZHE2cFVUbS93dDRYRGVtcGdMdXpZd2hVajYz?=
 =?ks_c_5601-1987?B?bkp1RVBjY0dHY1k2MFBkYVVJOGdsN3JvSm1vS1hTZzlrYkNRaytY?=
 =?ks_c_5601-1987?B?aVFmamVuYm1mUVM2VHRyM1M3RHFIdmRlZnFkMFRLNEpCWmxJRnQ5?=
 =?ks_c_5601-1987?B?anNVaUc4eUZrNDVSbUdjM1V2aGhBYkVBQk1ncDNRdEMwSHpVK0U2?=
 =?ks_c_5601-1987?B?VStEUHpCUXBlYTNoeEFULzRkam5QMWdFOTNhRVpKWlJmQy9ZN0tP?=
 =?ks_c_5601-1987?B?OHRYV0FEZnZ3TTkvbDZ4aU4vTWNlUTY0b00yRFVWWUVyOTk2OXJx?=
 =?ks_c_5601-1987?B?dVd5RHBSeWt0MHZoNkYrTy95REFSVHY2ejlCVnBIdWhtVU5qNGhp?=
 =?ks_c_5601-1987?B?d2QyUUkvbm4wUWhXbVc3RmxFSnBEZ3JLU1pManJOUS9ORWt6aEtr?=
 =?ks_c_5601-1987?B?QmkzallLRFFCZ3B1ZHdjVWh0M1FvS0ZTNHEyNFE2c0NKYVd1MzJX?=
 =?ks_c_5601-1987?B?RWIrcitMbU9IZGNvdGxRTWExc3VRTDVyem9FQ0Jpek1NQzZYN3la?=
 =?ks_c_5601-1987?B?SFRYazJiU2t1bXFWbWJmc1VvTWtRc1lWYXBydGMwd25Xd3hxOHZ0?=
 =?ks_c_5601-1987?B?aDNsMWhSV1hoY1NxMnJOZTZwcVNEaFl4elpsMzk3cFJsYnJ0TWFm?=
 =?ks_c_5601-1987?B?RHZpMEJHVkhXZVJmSWR5NTRmblFXcjdUWWt0R1VqTWljTHQ0Ynhp?=
 =?ks_c_5601-1987?B?TDhzV3A5bVlVZWFtZVVxNUNtVWw1Qlp3K05mQlBqSGNJKzk3d1Jw?=
 =?ks_c_5601-1987?B?eHZwVnM5bUg5cVVZTFBCYm1Hd1cvWHFwRnZHcUY3MlhwNUwycW1i?=
 =?ks_c_5601-1987?B?NXcyR2l5MkxYUHpVanpJRE9ibWhJZS9xNnZOYmxlak1YV3NONkcx?=
 =?ks_c_5601-1987?B?d0lMYWtEL1QrRld5REFnTnppcDFWSS9UdGpseU5WZWhBNWtUcmhi?=
 =?ks_c_5601-1987?B?TVRpaFlCdXNNNlFRTkphZW9SSTRyblNDRzBLb1NMekJGOVhuNWNk?=
 =?ks_c_5601-1987?B?dXdvSi9pTms4Q2FFZ3gyU0RtV2ZNMi9qQVpjRDJVbmljWnl0bDlW?=
 =?ks_c_5601-1987?B?VlRMRk1zWldta0F0SjZiYmZsYTJ0U3ZRMGRvWDRYOXJHRHRjNTZV?=
 =?ks_c_5601-1987?B?UmIzM1NORUF3RVB2UUNiK3dWclh4REZqZUg3YU5jckZOTTdHMUkx?=
 =?ks_c_5601-1987?B?S1V5V1B3WVNjNU41QzUxb1JLalVESW12cDBnMUdteGowSllPWEty?=
 =?ks_c_5601-1987?B?YVVjdkMxR015L0pUbUZCSytRRWRkdFg4NzZTS3NuWW1ka3RpVnpp?=
 =?ks_c_5601-1987?B?UDM4R0lUS1RJbUIwUzJ0NXlFbXE2Um4weVBKNURzcS9RMktVNVVO?=
 =?ks_c_5601-1987?B?SXp1SXBlVVhFRUxqU0JCbXNac0JCZWFITnhBa0JISlZWVi9DWHp1?=
 =?ks_c_5601-1987?B?c1pFeUZjRWIyaU50cDlLRHB6MFZNWlNRbmFKRkUyazBDWjNUU2VP?=
 =?ks_c_5601-1987?B?ZlFWam53ekQyRjQrRDJKc1lpZUU1SFQvRHNYWkE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5364.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec19e7d-51cb-4da9-c7bd-08dc418dbcf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 05:40:19.5737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5696
X-Mailman-Approved-At: Mon, 11 Mar 2024 12:12:24 +0100
Content-Type: text/plain; charset="ks_c_5601-1987"
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

RGVhciBEQVMNCg0KDQpUaGlzIGlzIGxpb24uIE5pY2UgdG8gbWVldCB5b3UuDQoNCg0KSSdtIHNl
bmRpbmcgeW91IGFuIGUtbWFpbCBiZWNhdXNlIEkgaGF2ZSBhIHF1ZXN0aW9uIGFib3V0IHRoZSBV
LUJvb3QgbGljZW5zZS4NCkkgd291bGQgbGlrZSB0byBrbm93IGFib3V0IHRoZSBvYmxpZ2F0aW9u
IHRvIGRpc2Nsb3NlIHRoZSBVLUJvb3QgY29kZSBjdXJyZW50bHkgcHJvdmlkZWQgYnkgWGlsaW54
KHp5bnFNUCkuDQoNCg0KMS4gV2hlbiB3ZSB1c2UgYSBjb21tZXJjaWFsIE9TIGNvZGUgY2FsbGVk
IFJURU1TLCB3ZSB1c2UgVS1Cb290IGFzIHRoZSBib290bG9hZGVyLg0KQXQgdGhpcyB0aW1lLCBl
dmVuIGlmIFJURU1TIE9TIGlzIGNvbW1lcmNpYWwsIGlmIHdlIG1lcmdlIGFuIGltYWdlIHN1Y2gg
YXMgYW4gb3BlbiBzb3VyY2UgY2FsbGVkIFUtQm9vdCB0byBtYWtlIGEgZmluYWwgaW1hZ2UgYW5k
IHVzZSBpdCwgc2hvdWxkIEkgcmVsZWFzZSBhbGwgdGhlIGNvZGVzPyBJIHdhbnQgdG8ga25vdyB0
aGUgc2NvcGUgb2YgZGlzY2xvc3VyZS4NCg0KRG8gd2UgZXZlbiBoYXZlIHRvIGRpc2Nsb3NlIGNv
bW1lcmNpYWwgUlRFTVMgT1MgKyBBcHBsaWNhdGlvbj8NCg0KDQoyLiBPciBkbyB5b3Ugc2VlIG9u
bHkgVS1Cb290IGFzIGEgc2VwYXJhdGUgaW1hZ2UsIGFuZCBzaW5jZSB0aGUgT1MgaXMgY29tbWVy
Y2lhbCwgdGhlcmUgaXMgbm8gbmVlZCB0byBpbnRlcnByZXQgaXQgc2VwYXJhdGVseSBhbmQgZGlz
Y2xvc2UgaXQ/DQoNCkF0IHRoaXMgdGltZSwgc2hvdWxkIHRoZSBVLUJvb3QgYmUgZGlzY2xvc2Vk
IGFjY29yZGluZyB0byB0aGUgbGljZW5zZSBvciBub3Q/IEkgd29uZGVyLg0KDQoNCmNmKSBXZSB3
aWxsIGp1c3QgY2hhbmdlIHNtYWxsIHBhcnQgZm9yIG9ubHkgZGVmaW5pdGlvbiwgYnV0IEknbSBh
ZnJhaWQgdGhhdCB3ZSBoYXZlIHRvIGRpc2Nsb3N1cmUgb3VyIGV2ZXJ5IGNvZGUgb2YgUlRFTVMg
YW5kIEFwcGxpY2F0aW9uLg0KDQpUaGF0J3Mgd2h5IEknbSBxdWVzdGluZyBpdCBub3cuDQoNCkkg
a25vdyB5b3UncmUgYnVzeSwgYnV0IHBsZWFzZSBhbnN3ZXIgbWUuDQoNCg0KVGhhbmsgeW91Lg0K
