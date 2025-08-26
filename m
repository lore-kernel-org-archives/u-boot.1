Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C47CA0FE7
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 13:09:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7293C8311B;
	Tue, 26 Aug 2025 15:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="MLwbzP1b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF3E48307F; Tue, 26 Aug 2025 09:29:21 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D1DE828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 09:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxIbbC2GFq6FUj8XP7G2VB02J84gWNgrIiYDX1vtjTovr0z2KQXoLXOLdcfh8atq9bgGlc2uo+qbGPfcoWo01lNYjE5UExf755ZTYOaJb+1gyWQmXgWWo1H/VeRt7cSxvedyTE4jAO5+MZT9z9sw+gmad1V4wwnT46QuWOfVwzuLMvJxl/lh1eogu6kxX6Gw42AHvaf4y7V4U9CevSC52VDD+sU/ichwXpPGsgWkyMsgCljiI1Auma6OplDBP4tQAgbAff5XFIsIvVN7EK23LrAwvZy1eTbh92hmsZmpANcEhVqhntHtH6JgcbP65TTyjFC/tGdGSCZgFkWLNqrqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuAaitX/TTWaNYmVmzlOrc3KtRTeEMIn8jheB3suR7k=;
 b=H0inasUarnb4QGT2CCZC1J3YOkSnJMA21vj+AvDfQiyZ8um9nIlW9Lspw/K0PsSxP2P2/k5tlLgUods8nhw5zIKdz5zeKxOS7bwusABnORxY9latubViUKbDpJXZ6ZN2Mqkt6LdsEphyIevRflCDcljBPaqmnth4l959Yt7/qolmrjxpzIFQzF0V162znW6jP+sP2atdT1Fh2FVZsa59QPYDj1XclvYh2kR26GJGTyuOqPzYEw5yBkJ+qDYtcokOzccUIV4wosAXDhy1bMgo7I3L9LaWHsPKUgDmEqgJXVqeIIARbBD86lr3uTMvWXZkL8MoPhcQfAXDD+7+KGY3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuAaitX/TTWaNYmVmzlOrc3KtRTeEMIn8jheB3suR7k=;
 b=MLwbzP1bnrYTA1jsCt+XX4egjPd7DyzQbSb+RXRy4jtPJb3GV7Y0+kNmhffKX9SUnaYhr2xuu2dxdUu+C7G8xGRo2ySvZS+IPokf2m4OFnbekr/IIPPCTKz6NgdId/q6b01ZxWjW5f8zJz3CNx1p50373ZscRUvco88CajiZdyGndyN+jN+d5s1nXFgt/NkSwe6VjbvvJMhYm85NDszHKETjPrcQ4SFTeTIVZImswZgDmokoZDcOcYGCgEQ8aPT3eK/P67fzS8Y5AOwLfKO1kijozXG/mzGGz9zG+PwumSBJvJNzS1mdeVUp9u+j+zeIEi09NxAUmQGvLyvlAtXMlQ==
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SJ0PR03MB5648.namprd03.prod.outlook.com (2603:10b6:a03:288::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.11; Tue, 26 Aug
 2025 07:29:16 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 07:29:16 +0000
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
To: Nikunj Kela <nikunj.kela@sima.ai>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: "tien.fong.chee@intel.com" <tien.fong.chee@intel.com>,
 "boon.khai.ng@intel.com" <boon.khai.ng@intel.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Topic: [PATCH] net: xgmac: Augment mdio read/write with cl-45 format
 support
Thread-Index: AQHcFcg2UvEtYl5nhkiWXIAFm3SfdrR0Qy3Q
Date: Tue, 26 Aug 2025 07:29:16 +0000
Message-ID: <SA3PR03MB71877B9BDAE3E60FA1A5E4CBB439A@SA3PR03MB7187.namprd03.prod.outlook.com>
References: <20250510041200.2552981-1-nikunj.kela@sima.ai>
 <c186daa2-2ad4-4a7b-9729-e6a3329b968a@sima.ai>
In-Reply-To: <c186daa2-2ad4-4a7b-9729-e6a3329b968a@sima.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR03MB7187:EE_|SJ0PR03MB5648:EE_
x-ms-office365-filtering-correlation-id: b640bd62-6489-41f7-2379-08dde472433b
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NjlnL2I2bldsemljS3hzcVlOdmdIM0xoclZ2QktPSEdJT2orVjBDMEZGQ0Q3?=
 =?utf-8?B?R3FPYmtKYStmTU53WHkraGQ5MHYyTTN3Mk1BOTd6Y3lubDhmQnpmLytwaDMw?=
 =?utf-8?B?MmtLUUxBT2JMam9aZWpjSUw3MkViYXJpaytMZlNkNzhzMmVWRmJpUVJqb2xG?=
 =?utf-8?B?bnJzWi9KeXhIcGhIOEtvbmZLNHlkYTNEeDIzdDEwTCt1NXY3QTRyS3JYdDJj?=
 =?utf-8?B?OWZScjM1L1IzNmpDRHJIT0ovU1Fnb2p3SWZ1NGFwSVZ1dHBaRUVHTklHcHMr?=
 =?utf-8?B?WXRUNWNybldWTDZYK2lpSVd4dkhBRWQxTjYrSG9hWG0rTUMxb0JwdkxJRkQ3?=
 =?utf-8?B?a0JnanlId1RSVWt2dWdIaktxN05yMnE2TDJHelpSeUYrS09LQ0pzRVhud2Mw?=
 =?utf-8?B?OXRqTGs1SFRBYWxXVldlRzJCZ0o2OUNROFVseHlsdVhrRkYxaWhISWphM0sx?=
 =?utf-8?B?RmZZYlJEeTZHRkd6U0ZPdThOckw2TTNGZkRDNlorTUM3eE1lTzl4UWk4TlBj?=
 =?utf-8?B?TkJJNmcvQVd5dGJvUG9KbmxSVVJ0R2xyRU5tU0NxTHlSaUxvUlRJaGlOejY4?=
 =?utf-8?B?d2RNYkRZTXRBOWhoUTU4blhTKzlzWVl6bXlZRndna1dNVUZNeG5XSWlXR1Nk?=
 =?utf-8?B?cmpoUjJteUVLS2hyakhNQ2V0dytJNGxxMm0zSkN1TVNFejJHRnJ2WTJ0c3Fk?=
 =?utf-8?B?ei9IbEpnYVRidDFhVXVvSHJTR1ZXVDBYODBNd3A3bGVxZVNYM2pJZzVLZ2ll?=
 =?utf-8?B?VFNwWDRuYk42WU1DcXlYeDRwVjhlejJxNzBpMlZlbmc2Smk2NEFuOFRReXln?=
 =?utf-8?B?YVRoeXI1YS82RWh2dDd1cUpZN2FRRysvUU9NWW1MWEdnaE9FZEs0blBOVGNx?=
 =?utf-8?B?UkZSVVFHVFdOdm52OFFUaG1UVjM1WTcra052aHBuaEVVMVBFS0VEWm9HNmpF?=
 =?utf-8?B?RXdFOWdjOVNscGU3M1lkT2ZDNU1QUmVJdTFTNWpDQnhhRGxzS0JVaFo2eHdo?=
 =?utf-8?B?a3Arb3R2VDFiMlcyYlR5Mnk0bzZGS2NFbjdCV1VqS09nZXkrejJpRFY4VmZr?=
 =?utf-8?B?VktWd3hiQml3QzU2ZWNpM3QrVWpwclAwaUJKK0NQTmYzaHZEbk1qYzlzQmZp?=
 =?utf-8?B?VVFGdTFYTVQ4cUNyL2xKUmJVcDVDRi8yWGZNYXVMOThPRWxicXpDb1JMZHNX?=
 =?utf-8?B?bGRRQzd0bW1QdGRnY2hjT0JKNndPWnR1ajRNVDBPaG9VZldZOXdXWmhPUVZE?=
 =?utf-8?B?M1l0cGZtUTE0ZVFYcGk3amZXcG1wbHNGK2w5YlBEdEw2cGNaRlVGOVltMUJS?=
 =?utf-8?B?M0hpREM3V3dHZHNnMlplZ0NxdDVkSW9WYk5ZTnJGbWVQOGNka0FmQ2xMUHlm?=
 =?utf-8?B?WlBxdFNyOWlvSVl5ekZWRTJQRmJFelAwYlNhWUpZWjU2eWhFaVpPUmhBdHV6?=
 =?utf-8?B?V1RzYXk1ZWlRWXIwdlpuVXNtSEhqSE1zUFR1SS9ISXpiSG9Jd0dLVjVKRFoy?=
 =?utf-8?B?R1ROMGJzOHd4c3QrSEJieVFnbnYwQno4Q20rQnlScVJTS3d0SW94MjBwYWNL?=
 =?utf-8?B?eUwzc292cjBjbmErNlZLNlJjVHBTa1dPbVdHN2RsUkZMajZhUWZNVk5kamJs?=
 =?utf-8?B?Q3Z3TStqdHFSa2ZFVHJ4RFp3elNSNXdiZUdLOUtjWW96ekczRFlvUCtjZmlq?=
 =?utf-8?B?aEZEcmNNSXNEOW5qdllyQ1Y4KzNlelJvVHZSR2tVUGFNN1dtaHBIYldneU51?=
 =?utf-8?B?cTZNNk52dE5ZV0R3dzJ4N2UzUlVmZDBMaDVVd3Q5RVRpWXB0dHNNbjAwclVw?=
 =?utf-8?B?NWdDdmpmbmMvaFFUa05VZnltNWtxM3NWb0hrWkM5bEFvQmdQd1hBaTAxVmZz?=
 =?utf-8?B?aUtWT0RPWjdzSzA3OFExTmE2djJpdXNQMEV5TVVaTDB0bTJITTA1VnVPZDhC?=
 =?utf-8?B?Tm12YkZlNEdnYUZqdGZhdEQyaEdRRXVuSWsvQkxsc095bVgvK2g5d0dlY0Jk?=
 =?utf-8?B?WGNKNHdWSDF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWFxWXNCcDdvSHFjbm90MkZHcjJSeG9ZenhlUmZiL3pMM04rNUZXYk42STNl?=
 =?utf-8?B?OHlkRXBiWmdnQjRKRnZrL1VCcVRYa1B3a1BOT0RrbXFPOUNDTURRcTVOMVZ0?=
 =?utf-8?B?L3hlSEgxWFRuOUZHdlZqb2xaZ0dmMEVtL0xiUzg3TC9sa1oyWkd5VHdVNTE2?=
 =?utf-8?B?Y2VEZzJVcXVJcWNjVE9TNHI0cGtMTC9Xc2JkS2k0aFZZRlVzV2VGRXF5aHpt?=
 =?utf-8?B?aTlIYVdsTzFyUWdZbkNySzgrUjl6SEJvWis1enBZMFhKNW1PQ3QwR1ErR3FL?=
 =?utf-8?B?T2tSdy9XbVdZTXdZcWQrU0FQMzRpN1lWQmI4a1NFZGoxS1pUcWNiTkRTSHhO?=
 =?utf-8?B?MjNRZVdEc3FBL1Q1ZmZlSFd5eHIxMG5KNmVOb0dQeGRjMlBLSENUUU9TckNh?=
 =?utf-8?B?ejFBRjc0cWZnaDdvdDJsaFZiOEFKS283enI3TDJvdThSR1ZaamFWTVFweGV4?=
 =?utf-8?B?RjhaTU5LSmxEbUplallRVVY0VFFPY2tpMFZJWTJtMXNvQUF6L2E4MnpiSGZT?=
 =?utf-8?B?bkFRRFJ5Q3V3RnNNMjMrZ3h5UElHdHU1S1R0ZDVDQlpOdHZSbnBoejFzaktk?=
 =?utf-8?B?TldsUDRkaUdhZmhoMjM3OXV0aHVxamE1WlM5amowYlU2TlZMSXZQQVJvOXZ4?=
 =?utf-8?B?RGpxWkFhd3RTcFpIWmJpRy80ejF6azRySit2YkF1TjFUeHpiMUtNTEV3c3dZ?=
 =?utf-8?B?NXVKeEFydjlaSGVjUmJjZGptMStTSXVpTEdzRy8xcVBTNEE5NnZrVm1QNDBZ?=
 =?utf-8?B?UXBnaTBrSHhWYTFSREt2VDFaNjVkT3NFOXd5d3hCZ1VEc1NaT2xiT1hBeUFv?=
 =?utf-8?B?VGwvWWJEY0tMTmcwdU9kQm1oZ1k3NGlUNG1JS1llUk9PamxyT0pVNms1VjVM?=
 =?utf-8?B?cWZ1OWdSV25HVDlQZUU5N1RYMkh6cUxuMGdTTy9wQnFMY0ttRTdJb3FrREZY?=
 =?utf-8?B?aDV0ZUZHQXV3K3RTdm51UXJOUndGdFZFeFhCS3JEU3lhZ1JLckZKVm1kd2FM?=
 =?utf-8?B?UjhwWFZqeU9zWURLaVRsa2l5RXg0bzFLeC9DcGlxMlM2QWVNdlRvcFdBODFD?=
 =?utf-8?B?amxNUVpyYzJXRlRRRDIvWENaeFFuRE9MSVc1Q25FbGppQ0lXTGE1TEc3RGx0?=
 =?utf-8?B?T1YrMURJbEg0aVdkejJJM3JpRXBHY0JXNm8wZlRTd1BGSVp2Tk1LSGZXVVVX?=
 =?utf-8?B?dWpaVDBkTmQrb3BudUR5TUdGL3dHNkNmVlgyT2Z1YkRucmZ5eXBwOUZsWHVp?=
 =?utf-8?B?UFNYa2ZGL09qQ1BZWmpodHhDZEw0OTQ0NWJkVW5zVFl3UGoxZUU5Mzc2aWZh?=
 =?utf-8?B?cVlvS0F4TXVzSmpxdmxTNzZxcFFqUCs3bitIYlFOeVg2ejZJcXNSeDF0UjZk?=
 =?utf-8?B?dHk3djgrbWVXakV5a0lqdHFKN1FOb0VLK0p2Wm4yVVRGS2JiQTc5UWFmZGNS?=
 =?utf-8?B?QVZHdkVPUVRFMGVObjNqTHNsZFJQR0VWbEhtUUV4ZjdmNWtDN3BsM3Z0VStt?=
 =?utf-8?B?dkkzRkVTNlEyTnJRUndmVUl6Ujk4a2tKb3BRaExBTEd2amtlMXRtNDdpTEk3?=
 =?utf-8?B?eTRWeHR4Y0IrVmUyanVpQW1hQldBVU5jN1JaTDVSRnFZcW8xMTJMbHNaQ0Jp?=
 =?utf-8?B?RXlMeWE2MnhBdDJIbmExakNGMzgwTHZEVXRybDlLK3A4Y2JXTTdEU2FoTEJa?=
 =?utf-8?B?VUNjY2YrS3NzSHJzUlk0NXVva2V1VUg0T2lZbWNQQzBZOUJLQ3hGWEIyM0to?=
 =?utf-8?B?NTM5enZXM3BqRFhWekdQNnkwTXMrS3FWMk56UlYvRjNGZ0dXYnRSdW5pVThH?=
 =?utf-8?B?THZyQ1h5Tk8yUlB2eUxDa20rOTd6Vkc4eXJjNVpHbDJFWFp2Y2VkWTI3MVpa?=
 =?utf-8?B?SU9VSHlnUkh4eC8weVE5T2pCTnBWTmoxdHN0L24zdERTcGpwRXloSnVtMDdZ?=
 =?utf-8?B?SWlHVVFlMUk4QzZyelBVSkwwTDVJZjI2NmgrTnk3cUxIUm5ZbHNPcVN3RW5X?=
 =?utf-8?B?RDl5aTk0TUdXWk9ITVlGSXNwZHMwb01IRUlWNXoranFJVUxRQ3BqY1IwajJ4?=
 =?utf-8?B?OXlTbTVwa25ORXlSelU0NElVUGtoRkx1Q0JheVlYUGYxU2dMaGYvQWVkTHVy?=
 =?utf-8?Q?hglFBRKS0vpFqGkbH+yVxjg1E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b640bd62-6489-41f7-2379-08dde472433b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 07:29:16.1554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8k6+yjKGOlVbtfr5SADFtYnCOYNDOZoixBy7yuqaxOIMmlNhRKBHzc1rIv/cWzWpq5vq7XLjvA6oHJ1SWf+tzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5648
X-Mailman-Approved-At: Tue, 26 Aug 2025 15:08:40 +0200
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

SGkgTmlrdW5qDQoNCj4gPiBAQCAtMTQ3LDYgKzE0Nyw3IEBAIHN0YXRpYyBpbnQgeGdtYWNfbWRp
b19yZWFkKHN0cnVjdCBtaWlfZGV2ICpidXMsIGludA0KPiBtZGlvX2FkZHIsIGludCBtZGlvX2Rl
dmFkLA0KPiA+ICAgCXUzMiB2YWw7DQo+ID4gICAJdTMyIGh3X2FkZHI7DQo+ID4gICAJaW50IHJl
dDsNCj4gPiArCXUzMiBjNDUgPSAxOw0KDQpVc2UgQm9vbGVhbiBpbnN0ZWFkLiANCmVnOiBib29s
IGlzX2M0NSA9IChtZGlvX2RldmFkICE9IE1ESU9fREVWQURfTk9ORSk7DQoNCj4gPg0KPiA+ICAg
CWRlYnVnKCIlcyhkZXY9JXAsIGFkZHI9MHgleCwgcmVnPSVkKTpcbiIsIF9fZnVuY19fLCB4Z21h
Yy0+ZGV2LA0KPiBtZGlvX2FkZHIsDQo+ID4gICAJICAgICAgbWRpb19yZWcpOw0KPiA+IEBAIC0x
NTksMTkgKzE2MCwzNCBAQCBzdGF0aWMgaW50IHhnbWFjX21kaW9fcmVhZChzdHJ1Y3QgbWlpX2Rl
diAqYnVzLA0KPiBpbnQgbWRpb19hZGRyLCBpbnQgbWRpb19kZXZhZCwNCj4gPiAgIAkJcmV0dXJu
IHJldDsNCj4gPiAgIAl9DQo+ID4NCj4gPiAtCS8qIFNldCBjbGF1c2UgMjIgZm9ybWF0ICovDQo+
ID4gLQl2YWwgPSBCSVQobWRpb19hZGRyKTsNCj4gPiAtCXdyaXRlbCh2YWwsICZ4Z21hYy0+bWFj
X3JlZ3MtPm1kaW9fY2xhdXNlXzIyX3BvcnQpOw0KPiA+ICsJaWYgKG1kaW9fZGV2YWQgPT0gTURJ
T19ERVZBRF9OT05FKSB7DQo+ID4gKwkJLyogU2V0IGNsYXVzZSAyMiBmb3JtYXQgKi8NCj4gPiAr
CQljNDUgPSAwOw0KPiA+ICsJCXZhbCA9IEJJVChtZGlvX2FkZHIpOw0KPiA+ICsJCXdyaXRlbCh2
YWwsICZ4Z21hYy0+bWFjX3JlZ3MtPm1kaW9fY2xhdXNlXzIyX3BvcnQpOw0KPiA+ICsJfSBlbHNl
IHsNCj4gPiArCQl2YWwgPSByZWFkbCgmeGdtYWMtPm1hY19yZWdzLT5tZGlvX2NsYXVzZV8yMl9w
b3J0KTsNCj4gPiArCQl2YWwgJj0gfkJJVChtZGlvX2FkZHIpOw0KPiA+ICsJCXdyaXRlbCh2YWws
ICZ4Z21hYy0+bWFjX3JlZ3MtPm1kaW9fY2xhdXNlXzIyX3BvcnQpOw0KPiA+ICsJfQ0KDQpDaGVj
ayB1c2luZyB0aGUgYm9vbCBpc19jNDUgYW5kIG1vdmUgdGhlIGNsYXVzZSBzZWxlY3Rpb24gbG9n
aWMgaW50byBhIGhlbHBlciBmdW5jdGlvbg0KRWc6ICh4Z21hY19zZXRfY2FsdXNlKCkpDQoNCj4g
PiArCWlmIChjNDUpIHsNCj4gPiArCQlod19hZGRyID0gKG1kaW9fYWRkciA8PA0KPiBYR01BQ19N
QUNfTURJT19BRERSRVNTX1BBX1NISUZUKSB8DQo+ID4gKwkJCSAgIChtZGlvX3JlZyAmIDB4ZmZm
Zik7DQoNClBsZWFzZSBoZWxwIHRvIG1hY3JvIHRoZSAweGZmZmYuDQoNClNhbWUgY29tbWVudHMg
YXBwbHkgZm9yIHhnbWFjX21kaW9fd3JpdGUgZnVuY3Rpb24NCg0KDQo=
