Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CBDCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9C183631;
	Fri, 24 Oct 2025 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="U6z7l4FG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A55FF8334F; Fri, 24 Oct 2025 09:08:28 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DCBF832BC
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 09:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXgYlpdHikMHJSAD4G9UYM/bAAmLr6BlENqt0reGxMlJYgPK3VwZ1YGyMhvOCyRMEVqEgL7vuLt7r4tWIQD17Fpi1In5rgoZz2hwAChKkZyvNfLLGZGLXEJQTs8lq4B2oOM/a3MnRXDpVC1nQasaRfR2+O6r5IwWRGEJ2onddMHY3T8QOtB6DHEQeRHZzgmSqwPKk+QKSoDAXfwfIE+ODgsnAeHF6s/lovkynl7+UPCnLcRLGHnu5Y6JmSL04qdwgHrDMG+1SpqKePj9rbTobs7L9TMgcRBZfoF3SwA05ShI2ezoEPTfJffxvfPJjCQRl6GnYuG3QHZD/VzIr1bzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H2JGIZKVN9vQuuk3usFkdgPoMf0bBbU+nQoZzBtbUU=;
 b=Hyg3GeV93vlxPwp8s2twn7//VDoPTQMPUo4XvDjg5HnjA/hgudvUnz8LLa3vILuQ0AtfVFErmuH/o1SR7o3f5PR2WYCzo2phE/6doz75nI3WoISdyfl2fUNjuzwhYGdh89MY7BtB2DC773PzaufqBByAHfM23rAK16vt+nKYBb03K73y00Zl/3nZ40tGq+qbWrYXpB2tTWRAON1tOsoMfRoPz3WTD87n/Gz6iwzo4pR71gqG9PubpyJMnhvmOLIBJwdYFnUdkkdhE8ZdcX8iaAOWGvUka0N9ksM4MRMzMFWB6dO1j2C9LhlkRkAeL1QI0+/98KE03XXcC9y6cY7tGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H2JGIZKVN9vQuuk3usFkdgPoMf0bBbU+nQoZzBtbUU=;
 b=U6z7l4FG/FByT/kXc7d87rRngvFJ5VZvjLkk5psqQ7Ui9YdypbDs4YcZe8zVts+eHY5UVvdAABCjAnT/s+uh85RJVsFu2Y0g6FsaZMlRXjiWv/kvxn/qYhptOdr2VgkPT5kznC86XjMkH4/tUMO89i9E4O8oU71Wy5azTuts7rTH1oC2tzcbLOCDGW9UXZTkFZAXYc4I7Pr7XOmHESEc5soB+sj+RKHzk5WT4twBsPksOmJmkywWxqIHEY3n/TONXw8TTHgHjkQ/o7Hh14lXO1TSXUW0bAXqn1qf3CM0YYplwIEEH+l4VRrH189POK73jaVQD34nXF+6bZSzK5rzMA==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by GV1PR03MB10870.eurprd03.prod.outlook.com (2603:10a6:150:20a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:08:22 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:08:21 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Torsten Duwe <duwe@lst.de>, Matthias Brugger <mbrugger@suse.com>, Simon
 Glass <sjg@chromium.org>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
Thread-Topic: [PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
Thread-Index: AQHcOgD8HUzJwI/l802un+lqOr/ENrTQ9fSA
Date: Fri, 24 Oct 2025 07:08:21 +0000
Message-ID: <23539422-f5d9-41e4-b7db-5dd342b27047@epam.com>
References: <20251010161442.410C4227AAE@verein.lst.de>
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|GV1PR03MB10870:EE_
x-ms-office365-filtering-correlation-id: 8783f602-11a1-4382-d91e-08de12cc1df1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?TFppTUo0UlEwK2grYnNvd2tqWEliVFhRN3ZYSE5BUHd0cngwY3RSbFdSejIw?=
 =?utf-8?B?Z1NNNjFwVU81ZGZuR2JWcTdUcG5KTzQxZFdCV2RqamQxVkwrVGZxTGswYUhl?=
 =?utf-8?B?eFIxNTUzNUJ2cmFXWElyWERackRLRDRSeGwvc2Q5b0htaDVveWZzV1RUZ3JO?=
 =?utf-8?B?WmpuQjhzQXlud2hBckx2L0JtTGljbkIwcVhNRnZZYzZ1NjI2d0ZlSjA1ZTlT?=
 =?utf-8?B?MzVVRmtKVVR5NUFDUmVjSlM4WkVoeGUrbDhoYUoxSVBSWEdwSW9PTEU3cjVn?=
 =?utf-8?B?Y3NldmJobXM5b01ERUxiNkxlWHpOSmdaWnhERkhmVEhXcUZjRU1HK1h0eWF6?=
 =?utf-8?B?ZTlvMVZHd0ZLOW5HV3BIZWN2b2l3NERJbERHSURkV2tpMWdsK083Qi9jc2s1?=
 =?utf-8?B?ajhrRW5qY01Qa2lsY2dhWEdiVWQ2VG5idEFoVkttay9Oc1pnSllqeFpkQm9H?=
 =?utf-8?B?ZjdYUW8rWCswME96T1ltZ3FzRTExd1MyVldacFlqWXVTU2NUM0pRQ0lncFRU?=
 =?utf-8?B?WlJvTWE3UnAxTWw4aHBZN1VkZVF0ZUt1alVwdENDQnlvZFkzcHgwS1JPcXJG?=
 =?utf-8?B?aW4zSlFCN0JXNm5CTXZBck9oR1hWSFVTby9SZHBiWEhLdE1HVG9qWWlBRG1P?=
 =?utf-8?B?TDQzWUJ0S0FoalZGeUtGK0c1dEFFWUR6Wm5aYlVTT0x4K2lLSU5aNGVEQzBG?=
 =?utf-8?B?ZTBHeFdkRU9Yc0dkRHhWMTNKcURIWERXbTFvVG44Z1dOa3p0elUzN1NhOFE1?=
 =?utf-8?B?RG5rZmpmdHRLcUFEd0x0eW1WZWVJeGdQTnZMS3E2a00rZ1h3Rm9TajR0cUkr?=
 =?utf-8?B?WVFnenE2OVQrRXdneVNLcnZHMjZORm9hRi9CZ2VENEpqRjRvTnk1enBtT1l0?=
 =?utf-8?B?MTBEYS9uc09CQXNDRElteUVzV3F6QWsySCtCUlEwK3FUV3lyTkNQak5MSXVF?=
 =?utf-8?B?MGtWTWxiVDFOVGRaNUNOL3Z6a1FldTl5M2l3VFZXclQrNEx5SkhSL0xmRllh?=
 =?utf-8?B?V3dIaXJCY2pEUmdzZ0ZNSmlJZnlzdjEyYkI2LzRRNmZmUlVmcjdjeHJWd1FE?=
 =?utf-8?B?b2d3Z1Frc0ZvRDEvRHV3NjErUnpmK1RpTzdoUFM4b2RRYjJCb1hhTzIrdGFy?=
 =?utf-8?B?T3pPZXJmU0xRMmVpWDl1TG51L2JHUEtTTTFBSElFU012Z3cvUHIrRDdTc21D?=
 =?utf-8?B?K0Ryb3NZSnk2b1JGQ3ZpbEZnaExxYXBscTFORk1mY05wZmhEODhpT1VOcG1D?=
 =?utf-8?B?TU43T1FzRWw5b1RscjlQSk51eUpNKzVMY2lOTWx2UWwvVXlTRmZNLyt2dzFL?=
 =?utf-8?B?R1hIVE91LzRyYlNiczlqMkM5MEJvbXJBbWVmaGlXUlFXdHVOTkl3dnI4RzRa?=
 =?utf-8?B?Y0tNYlF6YnRYV3JjVzJLZk1DTzJ4L2lpc2hvbkZ0T3N4WHFkQnc0RWlrV0JS?=
 =?utf-8?B?UUtENnJ1cnZrQWMrT2dSVDYxekt5YU5IdVhpSUY4NTFyS081bjI3SnVzUVpx?=
 =?utf-8?B?Y2h1TDA2RmFyOVpqYm1rWW8ySEo4TlRPaHJ4M1pDZnN0Wkw0UlZScG9Eb2hQ?=
 =?utf-8?B?S1BLYkMrRzJrWUJkemxOU1NWdWVzZXRVa2M3TWFQZDhyVjY1VTliUGhUMFFy?=
 =?utf-8?B?czNsZ2hHL1dRZFBmblFTZkhMb1VWbHRWUUovOXJobGNyQWNSbEVXVGFXekU1?=
 =?utf-8?B?Mkl3VFRoc3RhV3ZSV0tkajZxMSs2YndVRU1hRkk2b2FGeFpVTkRVdTE1VFQ2?=
 =?utf-8?B?UHVWM1JzSEZxVmhuYTRoTDRtVGJHa3NGbXRFQmtDZmZLT1kwaU9tTElzQk56?=
 =?utf-8?B?OVlxcjJBbFBXL2xDaTFkcVUwQUpNajR2WWtTR0lxRU1sdXVuS2tSK2hJeDN4?=
 =?utf-8?B?WG9sVDVsN1UwdnJjeThqMHYxMnNaUWRBU3MvVlNyTjE4QU1YQ2dQbnFObG1i?=
 =?utf-8?Q?bKcXWdgak8KBzJ408r280+qFglQpqxE0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDI0OC9mQUlQMDd6TWVXWS9CdVJZSDA4WTJHRkFSUnQyR0l5aE1kK0l0ekY1?=
 =?utf-8?B?aFlUc01UeHc3VHBOZlh0MU9SWVdZRGFSTjJDMWpJT3crMnQzVi93anZlZ1VN?=
 =?utf-8?B?SkYrOEZyL3hvWXFVdjJRejFYOWlGcWhtMWpjV01yTTJmMENVcGdDWEFjZnNE?=
 =?utf-8?B?U0x2UEhmdEJwYXZ0WmFRSVZIOGpOVVVLcHFTUUd4Yk9lZ3BmNStaLzRDSHNB?=
 =?utf-8?B?ZXJoSVVrekI0b1Y0QlhEVVpTbjNNMy9vVEJHWFdHRU1Nb200QS9JSmdjQXhm?=
 =?utf-8?B?NFQyTk9yWHpLQUJuU21oN1VHcWNvUkxtZmcwc0tleVFNUmtOalA5VGIzYkVW?=
 =?utf-8?B?NWt0c3FHdmtNNkI2K1dDYkxsN0FEdmc1aGZSc3ZoekZQZDVCdmdUZ2FIQm9V?=
 =?utf-8?B?elQvM3hMc3dqMmNUeFN2K2prYXNZcGFsVHV2QlhKQm9talQvcXJmd2lQMDN3?=
 =?utf-8?B?NEx5c2ZrQXJaU3ZSTnhnd1IvaHp6U3l4enczSURsMkluSUFJL0RmcWVFWmNy?=
 =?utf-8?B?M21EdHBVZjhtOHhYSjJVc2N4Y0tXdk13cy9TWnNCMnVZVFFSa0ZwdGEyRnJ4?=
 =?utf-8?B?UDl3Z05SeXQ5K3FZdlQ3ZTJ5eHdoUi8vOHFsQVpRMkQyMTZTSDBEam9VVlBj?=
 =?utf-8?B?cldrYmtrMWp6YXhLbVJIOXBUR3A3WStlWnJaMFFDUU40VGtiaXRTZ1RRWE1F?=
 =?utf-8?B?RzNsZTNCUHd6anNicFpQTkt3Q0JyeGZFdVJrWks3NU9GaTlhOVVid2laalh4?=
 =?utf-8?B?RWFrWFhoU2N4a2FCWjRKUmd5dVplSExUYmJFRmpHUzhpM2ZrTGVUUjBoWmt3?=
 =?utf-8?B?MVpJSURhMDNMVEVVK2VuNWRtSXFlREE3UW1FM0hVMmhGdVI0cFVFZUV1Snc5?=
 =?utf-8?B?aXNES2hUSnkvcWJzRVZrK0ZKSndyUGxKUmFtZ2dyRnFBWTZEMzd5WTA5OXh2?=
 =?utf-8?B?TjZnemJZNWQxYTVXcHJKdFFEcjV0NnIzajZUMlFxWk1EWUxqbkFUdHBKT3F0?=
 =?utf-8?B?RjdwNEVVYklpYXdJOEVqRHh2SEcydWlabUpqdVl3T2U1UytzMVVURlFuMGs1?=
 =?utf-8?B?dFE5NWg1Ykc4YmwrQWR1dUUyTVFma1FUaW1yeDlxUE1XL2l3UGJOR2ZNSkZ4?=
 =?utf-8?B?OHREUDNIbC8wem52VjVYWjhLWCt0cU1FUXJxTFBWbjduRTVkSkZpN3FpQ0Vh?=
 =?utf-8?B?SkYwakdnTjNpU3NnK2EvVTlSaUJ5eGIzQlFXN0UwRnFmYUdMY05jSjdOcGhz?=
 =?utf-8?B?YXZmRnlhbEd4TW1kUlR2dFI2UzFHeFJkMFNUc2ZBQUI4alYyUldUc2tpaVZB?=
 =?utf-8?B?cFBaaUVjUVViVmZ0R01JSDVrcGhFc3BJdVoyUXZRVy9UMHBQbks3STM3NEsy?=
 =?utf-8?B?Y2tlNFRVUDYvcEVSeTlUOGZNaGdvLzZhangwUHptREF0VE85QWVqcVp4b3hy?=
 =?utf-8?B?OW1EQmxkbHJRM0JLeWdzYTVSVVNQWExjL2RxbnJ1N1dXdVRwWHUybHl0ak1Z?=
 =?utf-8?B?b2NqMGZiL3JCM2FBOWNuZ1Q1azhvVzRxSWVKNm01d3JrTTN2TEhSVlBhWlJD?=
 =?utf-8?B?SWQzREdYcXY4eElZRFFkS2FWQWxuNS93elRybDd6TGROc2kzQjBwaG51M1pP?=
 =?utf-8?B?TTNheFB6Z3dpOGZaUXlZeG1oZUtJaW9rdG1IMXVtaGtOSFhLVmd6REs0VnVt?=
 =?utf-8?B?Q0xVYmdkRWZ5RnJBY3MyUU93Qy96UGgxSHlkSXgzd2hQMUhmQlpMZUxjd3hQ?=
 =?utf-8?B?YVJ3Y3Fxd2JCSHo1NmhvM0tTTTZ6Rm05WlJxemZMRkZxdml3Y0JmeEMxNDFy?=
 =?utf-8?B?amF4UFRFRVVYc3MvMWZsbzlRTUJnWVBKaTMyQnhuYmkvMnIyREJIczFWYWdI?=
 =?utf-8?B?alE5VDlOWnR6NDZNMVB6a1lLd3hmc3VuaWdUcHhadHBXYnNJbVp6TWFsLzJu?=
 =?utf-8?B?aHBMYXF1emdmejN6MmVrV1lTaUhacGtWRXZXK2pBUzJtdDBoQjB2TXpoblZ1?=
 =?utf-8?B?VXJTMWRlNEJjSW1VM04xMWVIQlJOT3BqS1RMa09jWHNnZGNER01KdmxtajNM?=
 =?utf-8?B?ZVhMZHFMaG1qRG1PN0FlRFBaYjB5Q1lVaXRJbDd2TE1vUDZqV0NlalFjKzd1?=
 =?utf-8?B?V0ZXSzJSNnA1NHowbmxLdFZjL2p6ak03LzNNbjYxUGgwNUdSSXpuS1BFMW5n?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E20CFE6848C4D49B55F93B84F1B178F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8783f602-11a1-4382-d91e-08de12cc1df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2025 07:08:21.7683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQE+C3A1UodKDI7ZzDHES0zotxk4lXupE8IvXSxmQ5oHcYe7ABoh8Tyk0TJGdNn/jizDgk2OdDmVHuLuAJVA9GU/JkcX7N8HhaTPSU25ut8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR03MB10870
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

UmV2aWV3ZWQgd2hvbGUgcGF0Y2ggc2VyaWVzIGFuZCBpdCBsb29rcyBnb29kIHRvIG1lLg0KDQpS
ZXZpZXdlZC1ieTogT2xla3NpaSBNb2lzaWVpZXYgPG9sZWtzaWlfbW9pc2llaWV2QGVwYW0uY29t
Pg0KDQpPbGVrc2lpDQoNCk9uIDEwLzEwLzIwMjUgMTk6MTQsIFRvcnN0ZW4gRHV3ZSB3cm90ZToN
Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkdXdlQGxzdC5kZS4gTGVhcm4gd2h5
IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbiBdDQo+DQo+IEhpIGFsbCwNCj4NCj4gVGhpcyBzZXJpZXMgaXMgYmFzaWNhbGx5
IGEgcmVzZW5kIG9mIE9sZWtzaWkgTW9pc2llaWV2J3MgZnJvbSBGZWJydWFyeVswXS4NCj4gSSBm
b3J3YXJkLXBvcnRlZCB0aGUgY29kZSB3aGVyZSBuZWNjZXNzYXJ5LCByZXBocmFzZWQgc29tZSBl
eHBsYW5hdGlvbnMsDQo+IHJldGVzdGVkIGFuZCByZXNodWZmbGVkIHRoZSBjaGFuZ2VzLCBncm91
cGluZyB0aGVtIGludG8gYXQgbGVhc3QgMyBwYXJ0czoNCj4NCj4gICAgICAgMTogRml4ZXMNCj4g
ICAgICAgMjogUENJZSBzdXBwb3J0IGZvciB0aGUgYmNtMjcxMg0KPiAgICAgICAzOiBSUDEgY2hp
cCBhbmQgTUFDQiBldGhlcm5ldCBzdXBwb3J0DQo+DQo+IEhhdmVuJ3QgdHJpZWQgVVNCIHlldCwg
YnV0IHdpdGggdGhlIGZ1bGwgc2VyaWVzIE5WTWUgYm9vdCBpcyB3b3JraW5nLA0KPiBhbmQgSSBn
ZXQgYSAiZmlsZSBub3QgZm91bmQiIGZyb20gbXkgREhDUC9URlRQIHNlcnZlci4NCj4NCj4gTGV0
J3Mgc3RhcnQgd2l0aCB0aGUgZml4ZXMsIHRoZXkgc2hvdWxkIGJlIHVuZGlzcHV0YWJsZS4gQ3Jl
ZGl0cyBnbw0KPiB0byB0aGUgZXBhbSBndXlzIGZvciB0cmFja2luZyB0aGVzZSBkb3duLiBQYXRj
aGVzIHNob3VsZCBhcHBseSBjbGVhbmx5DQo+IG9uIDIwMjUuMTAgYW5kIG9uIGN1cnJlbnQgbWFz
dGVyIFtlY2RjMzg3MmE3NjddLg0KPg0KPiAgICAgICAgICBUb3JzdGVuDQo+DQo+IFswXSBodHRw
czovL2xpc3RzLmRlbnguZGUvcGlwZXJtYWlsL3UtYm9vdC8yMDI1LUZlYnJ1YXJ5LzU3OTU0MC5o
dG1sDQo=
