Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCBFD12D6D
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 04:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C8E89189;
	Mon, 11 Nov 2024 05:18:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="peeSZ4RZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ABA288F41; Mon, 11 Nov 2024 05:18:23 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C4189288
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:18:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+tX/NJJ8cPPnCcp3fG3hhcIBD9YWYejRXM/410lEKcK+2N8XOpWxnQHXmrgxJ3tHlyMDmfZ6r819YRgRywkQwjloXyH8BpCXbZKcw2aSAqeaqOQRWjwaIGDZjpuBtWvvRG8uup9zKSaS5XAIPAUGRhgOV5FqVpXpH2mnhzTftZ8hN+C5HO5uVInk/R1ZsdOsp/wW3cTP6/VTdyEUalouazXog5cKLmKSYxlGQz0rpXJUNCvghOJL5Iu60yPh75pnnReAEMwoICbRSpsUICdrwp2BmQ+T58LO9BPyG8Y1R508EjWiCvsOcfH4Hv4CA3BNE+167H1e8tsIBD7Xyn+fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ANl3c4v3HIiFZ4x2VR5KdYPlUTTKynd4hI503Zefcc=;
 b=ep9/kfmMuduDTwBINFWhr/EjcEhegjBylorxsNircpSHpzkqi/lfPQGzbiiCUfpJU4My5iGBUloSJH6/u46/yKPTLqnoQnCW2hnregsGEe4snMUIfO7WbPk5gtjWzFCkVWQu9vpbujnb4A5fqNvgZItdCjs/d804NfXitldO3fdJJ20zH+proqO7pimySAeDYLp1lgNJtxjK52nMC3wKRJC2wzx8/tHs8QBeX6T48EkMNwPMlTtZML1/lf65SqcBnEP6oVdaUPz0zDJWDfOeVfwusQk21/cv9/zOzfZ5Xu3a2qi+zElXZoAhcjwbTntzrmFSwEc2UwnThe/HJFy1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ANl3c4v3HIiFZ4x2VR5KdYPlUTTKynd4hI503Zefcc=;
 b=peeSZ4RZYYSaOpiScPRQSIFLZ5gMbR60sGr4oKMkP0kH0goi3vfUOaC+ZTsaFHE+VxrBKrGzFImhedBmyZmMpGnG2yuBLPVj7JMZM2IueQfZsQnSVUf1TseF4LPRZy3je2PDaXt7jDasCJaOGytNquodL2guHBWH/ZZINN4JrSk=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 04:18:12 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8137.021; Mon, 11 Nov 2024
 04:18:12 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "p.yadav@ti.com" <p.yadav@ti.com>, "trini@konsulko.com" <trini@konsulko.com>, 
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>, "marex@denx.de"
 <marex@denx.de>, "sjg@chromium.org" <sjg@chromium.org>, "git (AMD-Xilinx)"
 <git@amd.com>
Subject: RE: [PATCH] mtd: spi-nor: Add support for flash reset
Thread-Topic: [PATCH] mtd: spi-nor: Add support for flash reset
Thread-Index: AQHbKQeTszA35rJv6EiwCK2s/C9K87Kb82eAgBWa62A=
Date: Mon, 11 Nov 2024 04:18:12 +0000
Message-ID: <SA1PR12MB8697D2CA32F3C2F946EE8F9298582@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241028070325.17666-1-venkatesh.abbarapu@amd.com>
 <d8b75d2e-ab52-4237-82ad-fb0c75e557c4@cherry.de>
In-Reply-To: <d8b75d2e-ab52-4237-82ad-fb0c75e557c4@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|IA0PR12MB7775:EE_
x-ms-office365-filtering-correlation-id: 83a2b5ff-629a-47fc-fc5f-08dd0207db7f
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VnNKK3ErVjZBazU0bEp3QWs2bU80T0UxTWdNVERzeVUrYmttTGdiOUViUXlj?=
 =?utf-8?B?TkRjeWZ1ZG1OVmlldzhaMmx0bWF0eHFoc2hXclE0TXhJSWVVTmw2cVBzN0xm?=
 =?utf-8?B?Z1ZpOFJKZUNDZU1kRG1pRE1RdmRsK3d4S2E0cTFoNkt3YU5iK2IrU2ZvTk1p?=
 =?utf-8?B?Tytaa0J2VnBSQzJGTUNKa1RRb3VFaXAxVnBqQ2NuNkd1OWRuUnlvM3U0eVNn?=
 =?utf-8?B?cTMwalFYdUFSVkVQR2Yyb1ArYW1EZWwxOTZUTWhPZy81VW5MdzFoQnAvRldr?=
 =?utf-8?B?NEY5ZWM5WjY2d24vMDVvK2RyWjZ5ZUdYcGZnbG9ZQk8vQmpUNElUTStEeFJk?=
 =?utf-8?B?dWFjSWM4akZQWWpobU42QjZ3Y0FWeGJyRDJzZE1HcUkvYTVvaXVtUzBsV09U?=
 =?utf-8?B?aGdjVnd5NFJNdDhpdS9QLzhYWk1ieVQ1OFY5N2t4UnZPQTVLZDYyQWs5bHY5?=
 =?utf-8?B?SldkanZTZGpqZ0dtT2FnN05tVTNxRHVta0FPdlpXSFhQaXlQTGdFOFZuSkNr?=
 =?utf-8?B?eGZITzBaQ3AyYytNOERXQ1BITDZZZUl4ZVU2ZTAyVHplcDc3U1c4UmtNT1U3?=
 =?utf-8?B?Lzhha1pKWXFtSjBnbnkrenZhS3lacEtJM3BlcjRqL3A1RHhtVFdpRXB0YlpD?=
 =?utf-8?B?dWlsSm5NK2tmZVhjVVNUZUU5QlJTRXZaM2hQc1hldlNXTm9lZHpHN2NGUSs0?=
 =?utf-8?B?NU5wYks3UHRpQ0QzRGk1TGpYNmxXK1ZDZVM2bnlScGw3SlE3Q2NiWVlVTW9C?=
 =?utf-8?B?STlwVDYvakhldVFiSnI2ano3WFJMZjZmdDdobnlkaS9YN0dyWm5wRmFwMmNE?=
 =?utf-8?B?UzdvTktYbWdrWVpLTHlPM2t2ODYxdC9neVN3b3R3dGRBNGlKRVFyTnlWcUdt?=
 =?utf-8?B?QzcvZEtaRkJrUFZ0MzVXSVpkZU1sUlZPUW94enJtOUdXRDdtRFdBTTA3Zm0y?=
 =?utf-8?B?UVpzenJkdFV4VWUvL2NJQmtTZkRhU29pUmtoQzVNY0EySGFSQzRyMEpMV3Va?=
 =?utf-8?B?TTBPdVB3NzhIazZyTXB2YXp6ZEtTY1ZhTVhOMHU1VWMrRHRjd3pXbU5wWU93?=
 =?utf-8?B?c3J5b1BoYUM0R1pacXlTbllidnpTVHh4SHVzTkZsVmt4Sm1hWjBJRlkwNVZM?=
 =?utf-8?B?YkNINDgxVkxUZnErRXptNXJhaUZNR2Rsd3dWWStHS3RoTWRNUWUwWDVDUUdw?=
 =?utf-8?B?V04wd21pN2ovRnNwczhXVXNlTWVNcEVhTEhNckV5dGtEczNnSDU0aFFsZC9a?=
 =?utf-8?B?dUkwc2U1NDNKeldUNkZlTXYweDZqeW1HbHE5bUd3dHNTNlBWTVZjcFdWZU83?=
 =?utf-8?B?UWN0U3lvcDVNYlg2WDRzRE5rbDFTYTc0bXlBQjU4YkVITklmS3U1TVlDN3Iw?=
 =?utf-8?B?dmZ6elVKeWhyWnRiQUxzVG1ucThzS1hFaDNONGN4azV6OVN4MkdWMElmQ2NM?=
 =?utf-8?B?L2FpVjJ1MGFxSVFXc3ROU2cyeDArR3o4ZlhWWUJvMm9vVGhFcGdTbUdlV2tV?=
 =?utf-8?B?RklhMHpvWXU2VTZNcGlHYUpYRFFNdUNDaVhrQ3lPTFdrMFF3blk2bmp2SVdY?=
 =?utf-8?B?b3lscld2Q29CRFJqN2NXY21NbWwyT2N4eGdsdXZ6Z1ZONWNuUmF0aGMxNXFk?=
 =?utf-8?B?K0FnM014N3M5WXMxNWxqZ3RDTXRDakNWNnlyRW1Wa083dGgyb3RNMnJrZXFw?=
 =?utf-8?B?eEtreHRacmdCc2NObG1yZVljSTlDdVFHOUJKbzZ3WE8vVVVDWmUvd0NjQWZt?=
 =?utf-8?Q?tYaZXvuTth2tDh7byreL2MvwTXyV/XAqR2uIIIL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWRTeFhjSC9abVVtUUxVVjdKQllQRG1UbVZwV1JUbkMrYUpuU3E5dS9abGhh?=
 =?utf-8?B?blJlamRYSEREa0tLdThZeUp6MklmVkZwM1JjakM5SEJwdzhtMUpoQ3EwcE8r?=
 =?utf-8?B?djNsYzJRUUZwM1VNNy94d29WM2k1eUZkazkvbXN1M1dCSkN5aSt6VXh4RU9u?=
 =?utf-8?B?WnhJV2F5c2xkek1wWUh2alJVeGdleGV6azl2dUptc0VpOTNtSmlHbTVOdmVk?=
 =?utf-8?B?a28xYmlYMnNBUEd5bU1rLzczTk5vbnNBaE9VZk91M1dzei9TTGovaDcwcHND?=
 =?utf-8?B?Nnpwdkt0N0hzUnY3bWpWdERESUJyRi95Y2NsZThveTNsVWJjNU43SVROdlFy?=
 =?utf-8?B?UzFyVG9rUGpBajVPODgxTE8ycmRqRGphMUxIVGxSWk01WVdQY0lUazdDWURq?=
 =?utf-8?B?a3crZ3JPVHZDUHhWTjU1eUlQMFhyL3lSUGZKbTNrR3FJK0QrZUhnOUlpMkdU?=
 =?utf-8?B?UC9lbGI5TldUMndDK3ZMQmNnY0ovUWJTU2kxWWhrUlZidTd4Mk1kS1RkTFpv?=
 =?utf-8?B?N0pWNmZrRUNiKzF2OGV6ejYyajJNMjVEUFkydXMvengvNnJ4a25aREVVV0tO?=
 =?utf-8?B?L3BQd3ZCcVg4NDdCNjV2ZmdMR2dscmF6aVZyMEZ4REE4cm5YNkFTWkFEMmJX?=
 =?utf-8?B?dmRNTGkvSUNMVFg1ZUtEZzJhU1ROK01lV05mdVpsUTVRWjk3M1JwL0pGdDZ6?=
 =?utf-8?B?QVVXL0cwNWVCdmpuQTgwelFwVm9NN2dLc2haY0xHS0NiODlHZVMxNFZHU2RX?=
 =?utf-8?B?MG1qdmZGcnhhUFQ0NjZXa1MrZkt2LzZzUTNla0xISlArTHowWDFNRzVhSGtm?=
 =?utf-8?B?amxya2Q3UE1PVkE4cXF4WGlocUdmRmMyd0hHd1ptWm1WQit4aitMemhHSzBz?=
 =?utf-8?B?NjlUd0Y3clFBQWtOTUpObk8za1ppRDVTSGl4bEdxckFyeFpGNzdJSzQ4eFBP?=
 =?utf-8?B?WnVwN0J4ZmVFOGQwaTNvMExiekVONTFvZmJVNUxuZ01OT2JrZEMxZm51dnNO?=
 =?utf-8?B?ZVRnTXhpVjhCRENIdy9UVkRZK21laExSc3NVTW9QN1VCQjBYZWc5ZC9FaW8z?=
 =?utf-8?B?dFp3Sy9kTGdRcmdLNlFpL1ZEeU5iQ2wvNnBieFF2S3FqY3NNMmJZNGhHblkw?=
 =?utf-8?B?K1FtZkYrK3A2ajFObDd4TURlMTBNek9ZVllZOVQxc0p2djVOMEU0M1d1T29s?=
 =?utf-8?B?YTIyNVdjTmdWZGU0KzFzb2lKMTRIamZlNzB3K2pndnNCcE5nemVWbjZnMysw?=
 =?utf-8?B?K1g1R2NrYk5PRThyYjRYU3FJZk1vbzlyVUNhall4dDk3SkE1bjRhTzE4MXpq?=
 =?utf-8?B?RW9HbGRqRndxRFVJWkNZTEFLSnZhVmJuSUNMQU9Ka0xvc0NnZkFXUGVoU0VR?=
 =?utf-8?B?a2dJdFFTenNDM1hleUJ6ZkxjQ25GZDdCb1NUMEN5aGViUG1HOXpxU3pyN2wy?=
 =?utf-8?B?WC9qTmJBcnNvbW1xajFYWXhKWDMyT1QwWDRFd0F4cGZpQWwrVExsOFNmZ3Iv?=
 =?utf-8?B?UVpEY1FjOW5aVURUUFhvWGFPcHRlVUpadjdSTU00RVRwb0VkRE9ubXVSWUJl?=
 =?utf-8?B?eUxzS1dpU1BWaitBR3NFTlBTbmdYdUR6Z0JaZjRXVlBnRFRocUp3UUg0VnR5?=
 =?utf-8?B?YlpXSHJGNUU5YUVOMXhhR2lENTZndng4eEhIelc3OXIyTlM4MWwzWXJ5UXMw?=
 =?utf-8?B?ZnZ3Q1ZXNUJzNWc0UGYwMjRoZExKU0thWGFIcE9rSE4xdW1GYzN4dDdONWRm?=
 =?utf-8?B?aEkvb2k4NXNtaVUvbkhDV0RqZXdiVHJNTHdCOEFHWFdOeThFRGxwb1ZkY2VN?=
 =?utf-8?B?WFc5bTZjcjd0NENzRUtmWkdBT054czVSeHZPbGpBREoxalV0T1dtbjN0TE9w?=
 =?utf-8?B?N2VRUytpWFlVQ0xqVDNqWGI2NFRBN05zWDFKY1U5WlFRZFlXM1d6ZFdhYy9z?=
 =?utf-8?B?UlMzWi9PYkFTWVl2Z1ZuNWRDTlU0ZURWTWlONnNQc3d6bWhSeTVPY3BNaHU1?=
 =?utf-8?B?VUJxb3czMytJOWd5NlpVZ3MvWk1mQzExbFduZXM0aXB0a3FQbU1pbk9xK1Ax?=
 =?utf-8?B?ZnI1US9nK29acE5sMDRIR3l0ajBCSDEydEtHSlpuRTdGSlAwdGl1bnh3YnZY?=
 =?utf-8?Q?2YII=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a2b5ff-629a-47fc-fc5f-08dd0207db7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:18:12.6838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2kYN2PlUI6flzuD4ryqh4iJu8xGSjxfqD7Ke/XmEj413pxlLUHzev8wP/ty1HWUKept2mQY5mJujpJsiY1k0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUXVlbnRpbiBTY2h1
bHogPHF1ZW50aW4uc2NodWx6QGNoZXJyeS5kZT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDI4
LCAyMDI0IDM6NDggUE0NCj4gVG86IEFiYmFyYXB1LCBWZW5rYXRlc2ggPHZlbmthdGVzaC5hYmJh
cmFwdUBhbWQuY29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbWVrLCBNaWNoYWwg
PG1pY2hhbC5zaW1la0BhbWQuY29tPjsgamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IHZp
Z25lc2hyQHRpLmNvbTsgcC55YWRhdkB0aS5jb207IHRyaW5pQGtvbnN1bGtvLmNvbTsgdHVkb3Iu
YW1iYXJ1c0BsaW5hcm8ub3JnOw0KPiBtYXJleEBkZW54LmRlOyBzamdAY2hyb21pdW0ub3JnOyBn
aXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gbXRk
OiBzcGktbm9yOiBBZGQgc3VwcG9ydCBmb3IgZmxhc2ggcmVzZXQNCj4gDQo+IEhpIFZlbmthdGVz
aCBZYWRhdiBBYmJhcmFwdSwNCj4gDQo+IE9uIDEwLzI4LzI0IDg6MDMgQU0sIFZlbmthdGVzaCBZ
YWRhdiBBYmJhcmFwdSB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3Igc3BpLW5vciBmbGFzaCBy
ZXNldCB2aWEgR1BJTyBjb250cm9sbGVyIGJ5IHJlYWRpbmcgdGhlDQo+ID4gcmVzZXQtZ3Bpb3Mg
cHJvcGVydHkuDQo+ID4NCj4gPiBbUG9ydGVkIGZyb20gTGludXgga2VybmVsIGNvbW1pdA0KPiA+
IDhmMWVlOWVmNzFkMCAoIm10ZDogc3BpLW5vcjogQWRkIHN1cHBvcnQgZm9yIGZsYXNoIHJlc2V0
IikgXQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IDx2
ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbXRkL3Nw
aS9zcGktbm9yLWNvcmUuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gPiAgIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCAgICB8ICAxICsNCj4gPiAgIDIgZmls
ZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbXRkL3NwaS9zcGktbm9yLWNvcmUuYw0KPiA+IGIvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3It
Y29yZS5jIGluZGV4IGY1Yzk4NjhiYmMuLjkwMGY2NmIwZTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tdGQvc3BpL3NwaS1ub3ItY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvc3BpL3Nw
aS1ub3ItY29yZS5jDQo+ID4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPiAgICNpbmNsdWRlIDxkaXNw
bGF5X29wdGlvbnMuaD4NCj4gPiAgICNpbmNsdWRlIDxsb2cuaD4NCj4gPiAgICNpbmNsdWRlIDx3
YXRjaGRvZy5oPg0KPiA+ICsjaW5jbHVkZSA8YXNtL2dwaW8uaD4NCj4gPiAgICNpbmNsdWRlIDxk
bS5oPg0KPiA+ICAgI2luY2x1ZGUgPGRtL2RldmljZV9jb21wYXQuaD4NCj4gPiAgICNpbmNsdWRl
IDxkbS9kZXZyZXMuaD4NCj4gPiBAQCAtNDQwMSw3ICs0NDAyLDEzIEBAIGludCBzcGlfbm9yX3Jl
bW92ZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiA+ICAgCSAgICBub3ItPmZsYWdzICYgU05PUl9G
X1NPRlRfUkVTRVQpDQo+ID4gICAJCXJldHVybiBzcGlfbm9yX3NvZnRfcmVzZXQobm9yKTsNCj4g
PiAgICNlbmRpZg0KPiA+ICsJaWYgKENPTkZJR19JU19FTkFCTEVEKERNX0dQSU8pKSB7DQo+ID4g
KwkJaWYgKG5vci0+Zmxhc2hfZ3Bpb19yZXNldCkgew0KPiA+ICsJCQlzdHJ1Y3QgZ3Bpb19kZXNj
ICpmbGFzaF9ncGlvX3Jlc2V0ID0gbm9yLT5mbGFzaF9ncGlvX3Jlc2V0Ow0KPiA+DQo+ID4gKwkJ
CWRtX2dwaW9fZnJlZShmbGFzaF9ncGlvX3Jlc2V0LT5kZXYsIGZsYXNoX2dwaW9fcmVzZXQpOw0K
PiANCj4gU2luY2Ugd2UgZ2V0IHRoZSBncGlvIGRlc2NyaXB0b3Igd2l0aCBhIGRldnJlcy1tYW5h
Z2VkIGZ1bmN0aW9uLCBJIHRoaW5rIHRoaXMgaXMNCj4gdW5uZWNlc3NhcnkgYXMgdGhlIGNvcmUg
c2hvdWxkIGRvIGl0IGJ5IGl0c2VsZiB3aGVuIHJlbW92aW5nDQo+IA0KPiA+ICsJCX0NCj4gPiAr
CX0NCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+IEBAIC00NDQ4LDYgKzQ0NTUs
MzcgQEAgdm9pZCBzcGlfbm9yX3NldF9maXh1cHMoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gPiAg
ICNlbmRpZiAvKiBTUElfRkxBU0hfTUFDUk9OSVggKi8NCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0
aWMgaW50IHNwaV9ub3JfaHdfcmVzZXQoc3RydWN0IHNwaV9ub3IgKm5vcikgew0KPiA+ICsJc3Ry
dWN0IHVkZXZpY2UgKmRldiA9IG5vci0+c3BpLT5kZXY7DQo+ID4gKwlpbnQgcmM7DQo+ID4gKw0K
PiA+ICsJbm9yLT5mbGFzaF9ncGlvX3Jlc2V0ID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2
LCAicmVzZXQiLA0KPiA+ICsJCQkJCQkJR1BJT0RfSVNfT1VUIHwNCj4gR1BJT0RfQUNUSVZFX0xP
Vyk7DQo+ID4gKw0KPiA+ICsJaWYgKG5vci0+Zmxhc2hfZ3Bpb19yZXNldCkgew0KPiA+ICsJCS8q
DQo+ID4gKwkJICogRXhwZXJpbWVudGFsIGRlbGF5IHZhbHVlcyBieSBsb29raW5nIGF0IGRpZmZl
cmVudCBmbGFzaCBkZXZpY2UNCj4gPiArCQkgKiB2ZW5kb3JzIGRhdGFzaGVldHMuDQo+ID4gKwkJ
ICovDQo+ID4gKwkJdWRlbGF5KDUpOw0KPiA+ICsNCj4gPiArCQkvKiBUb2dnbGUgZ3BpbyB0byBy
ZXNldCB0aGUgZmxhc2ggZGV2aWNlLiAqLw0KPiA+ICsJCXJjID0gZG1fZ3Bpb19zZXRfdmFsdWUo
bm9yLT5mbGFzaF9ncGlvX3Jlc2V0LCAxKTsNCj4gPiArCQlpZiAocmMpDQo+ID4gKwkJCXJldHVy
biByYzsNCj4gPiArDQo+ID4gKwkJdWRlbGF5KDE1MCk7DQo+ID4gKw0KPiA+ICsJCXJjID0gZG1f
Z3Bpb19zZXRfdmFsdWUobm9yLT5mbGFzaF9ncGlvX3Jlc2V0LCAwKTsNCj4gPiArCQlpZiAocmMp
DQo+ID4gKwkJCXJldHVybiByYzsNCj4gPiArDQo+ID4gKwkJdWRlbGF5KDEyMDApOw0KPiANCj4g
VGhpcyBpcyBhIGJpdCBvZGQsIEkgd291bGQgaGF2ZSBhc3N1bWVkIGEgcHJvcGVyIHJlc2V0IGxp
a2UgbW1jLXB3cnNlcS1lbW1jIG9yDQo+IG1tYy1wd3JzZXEtc2ltcGxlIGJ1dCBmb3Igbm9yIHdv
dWxkIGhhdmUgYmVlbiBtb3JlIGFwcHJvcHJpYXRlIHRoYW4ganVzdA0KPiBndWVzc2luZyB3aGlj
aCB0aW1pbmcgd291bGQgY292ZXIgYWxsIE5PUnM/DQpUaGVzZSBkZWxheXMgaGF2ZSBiZWVuIHVw
ZGF0ZWQgYnkgbG9va2luZyBhdCBkaWZmZXJlbnQgZmxhc2ggdmVuZG9yIGRhdGFzaGVldHMgYXMg
cGVyIGJlbG93IHJlZmVyZW5jZQ0KaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Js
b2IvbWFzdGVyL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jI0wzNDI4DQoNCkRvIHlvdSBoYXZl
IGFueXRoaW5nIHdpdGggcmVzcGVjdCB0byB0aGVzZSBkZWxheSB2YWx1ZXM/DQoNClRoYW5rcw0K
VmVua2F0ZXNoDQo+IA0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+
ID4gICBpbnQgc3BpX25vcl9zY2FuKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ID4gICB7DQo+ID4g
ICAJc3RydWN0IHNwaV9ub3JfZmxhc2hfcGFyYW1ldGVyIHBhcmFtczsgQEAgLTQ0NzMsNiArNDUx
MSwxMiBAQCBpbnQNCj4gPiBzcGlfbm9yX3NjYW4oc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gDQo+
IFRoaXMgZnVuY3Rpb24gYWxzbyBleGlzdHMgaW4gc3BpLW5vci10aW55LCBzaG91bGQgd2UgYWRk
IHN1cHBvcnQgZm9yIHRoZSBody1yZXNldCB0aGVyZQ0KPiBhcyB3ZWxsPw0KPiANCj4gQ2hlZXJz
LA0KPiBRdWVudGluDQo=
