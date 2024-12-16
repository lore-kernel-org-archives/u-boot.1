Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6A5E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 13:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5FEC80104;
	Mon, 16 Dec 2024 14:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cCpsmaEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772AE80141; Mon, 16 Dec 2024 14:59:06 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F978003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 14:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn1G/HsTM9O/80945hqfsM/PmcJflKN6IHf48P3Zp0JI1U0OhoJfDXivCLqOlnFdmz5X9nOxtowRnZ9MxvHmebomufwZac7ciOMhgDgtb19WAFB/nTtlUFegdpCsgVCSPq95wN8q8xcPsHVjlBu1UN05zDZHUB29uXvHXMONcp4DUffjHwdRV3Gk1q78lSnij/rP7pzRMq9AAhmT8agM/Ntfal0CJojTkFvNcRK5HiU2+1qO7ODkUYYSROqhgHXz6j/+15+N2Wsrnnmunf9vo8Ov+hC/lh59XN59JlavGbxxsJSMYTcpBJm78Tnzf4HyKAarde6AJ+Pk8Edd80KA1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PlybmwDP4Sm1ECUGGM/g49/30uRo/PvUOJGr+dDlSw=;
 b=d+Kj6SPFAxCv4KrQslqB7wOzDD4mtKcA/n/e7MQAWCp0+Lw7qffH2HkX8FxpPc8GqY38J1pyyiusTBrQFGRUcYlh0ftxd+mKukCTlL45fVAKmFOFqaesBLPIfK9tl0Nx4twrSbieWe7l3nTOLGwjHLyTY6SzCEbxNzcozR1S4631zYvrl6XmFp3ISQgOved/ybwPM3WE8yMJfKND6ESOGCyKQQZmmmkIRV5Bi+qDrAKqjvLfgeVaxghyJHx0dUkDOLsuv2Zdwg+bJ18AK3lxDLNjtCwD34VRBQToS2L7XVnrhKqPc1TTzlSyvU0FJNtWsQEblX1ii+SRc6yiWxeyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PlybmwDP4Sm1ECUGGM/g49/30uRo/PvUOJGr+dDlSw=;
 b=cCpsmaEKXjjXBRHUbWvKIT4ZJy5KipKSKbffkKFyblkcA8HdTK+xaLAlo3bKNz4T7RdDBG3GAkzZ4geMLPMiCpxY3QxecZCLlT+IFbi2p9ytlAiuD/lTzfIvdb//fGGwr/BvhBI55OSwu4K5XSCehHsn1EKaE0tRn/zOydeyquE=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 13:58:52 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 13:58:52 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tudor.ambarus@linaro.org"
 <tudor.ambarus@linaro.org>, "j-humphreys@ti.com" <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Topic: [PATCH v2] mtd: spi-nor: Fix the spi_nor_read() when config
 SPI_STACKED_PARALLEL is enabled
Thread-Index: AQHbS8U++/+ZgliyKU+5ZpBpRoNYRLLoAMqAgABIX5CAAGvTgIAALkRw
Date: Mon, 16 Dec 2024 13:58:52 +0000
Message-ID: <SA1PR12MB86974EDF358A58732A9B7A6F983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
 <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
 <SA1PR12MB869702808B7A784031F17F83983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
 <3307c1e3-123b-4ff1-8140-18be7393b5e5@denx.de>
In-Reply-To: <3307c1e3-123b-4ff1-8140-18be7393b5e5@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|DM3PR12MB9327:EE_
x-ms-office365-filtering-correlation-id: 13b02752-7018-4650-9666-08dd1dd9c61d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZU0zUXcyVXNGSUJaUXZ6cStjbGN3S2h5RUVwTEFnQXViOGViUHdlUzJWNGIw?=
 =?utf-8?B?NlBDdVdTVzc4SVorRVFTQWpwMThzclF4ZlJpNU1MUnl3OVVmQ1A5NURkalJZ?=
 =?utf-8?B?NFBPMWxWY09VWmNyVUh1alpTTE1vYjAxeGtGeitqS0J3ajRDUE5EMkRtaElY?=
 =?utf-8?B?dmNCbHNWd2FYWVlVcmhob25Ua1duZHR5SGxuUnVISzBRQnJhb0MvZ2FWTVo4?=
 =?utf-8?B?U2JsZFd2WjJOYkxzekFJUVNTcW9yS1NEOHB5dG9qUVdZN25QSktTRVRxWFlk?=
 =?utf-8?B?ZVlidnRWNjhVY2s4QTBVKzhTazlOUmtpWmV5RXorZ2sra2ZPYmxJTW5CaVZF?=
 =?utf-8?B?bis2Tkhhd1FaOHJPRGI2ZDdtTTdlUzNHRDlsSTh3empDbjAvL09UYUwzczk5?=
 =?utf-8?B?ODRZUUp4WlpGSjlJTXdEM2NnaHpjUmNsZElHcnFMb3NVS1U3aDlJd1c5TVFL?=
 =?utf-8?B?Mm5VZzU1bEZ6Y0RNbk1HUjlSeUZqRzA1WEM0TkhjSjhCQTgwK0NYelh4ZkVy?=
 =?utf-8?B?TGFpclk0emtiSXBwVURHOTVvSHBIRnRUOHMyUlpOd1RUYU5wSkl3N2JqMHVk?=
 =?utf-8?B?eExPUzNhMytZM0R6bFdtQzVkQmwyUHZMdHE0YnJLQWU3anl0QnBheHlQOWZy?=
 =?utf-8?B?WWxWZldUb1BXN0R5T3YxRExBN0pUUUtYakIrRUd0SVZlOFFnOVhJd3UyZlpz?=
 =?utf-8?B?UU5KRitVV1hXaExxUHFRSzZXYzRFVzNOeThuWDIyVTFua0p0STNsdkJZMnMr?=
 =?utf-8?B?amMrY1FIZHIrNVF5bmhJa0luNGptRTBzVUVuZkxNUW56WVppdngzYm50aXhV?=
 =?utf-8?B?d3NpR2s1ZWhzYkJXWXpDVnZtVXExdUtSdGMxcDZyRmtydVZkVitibk40WEZP?=
 =?utf-8?B?TUpabmtnOFpObFNyYUptV0NKNkVaeE1xOUFvUE5QMHhLTDB1S0EyZGUzMVVl?=
 =?utf-8?B?YnZlUVJGQWNNVS9JayttVm1jdXlaN3B6UkdqbktVZEZPRkFFUmFTbnZmMkc5?=
 =?utf-8?B?QUNrYjVSMUJKa1J5OUxlaUhtdzdUTmZRd2pJR0lMQmxpa0lpNjNBTktDU0to?=
 =?utf-8?B?WU9FZ0JkNmlKdU1VdnpNUWQwMmdxRHdQRDFvd1EwNkFLTVlKeEt4cDY5dU90?=
 =?utf-8?B?SStoZk9Fb3E4N1ZBcU9NM2JOdFpKSWloRzd1M3lZVjNOVjhHb2dKNVo1MTBP?=
 =?utf-8?B?TmYxWWNTaTd2SlE2VzR0Y3RnMklpNENIMC9STnRtRTRDdkF6dC9yUnFMbTFJ?=
 =?utf-8?B?REVSOUpNZk55UFltbnQyZjFXb3g3VEUvKzNNYjVubVFFeGJrZ242V3JyUHlJ?=
 =?utf-8?B?cWVndU0ySW85clBVd3piNlBSVDdxeVA1M1piMGZPZUFTRjluWXUyMnhVZHVL?=
 =?utf-8?B?UzBOYUh0bEo4VlJ0dFFWYXZmdnphRkhOWmFOWGhKdEFDMndNc0xOSC93MjBk?=
 =?utf-8?B?ZHg4OCtpdkJpWUpKTGxWV1l2TzlDZXdNWWo5OGNtYzVJUExLN0lrMU96QlNL?=
 =?utf-8?B?THdjS05VVUhyV0dBNitRVFNGVXJoV3kxR3NrQVd4cUNpUWN1MnJ1OGpBajRU?=
 =?utf-8?B?V2dhWHp0bHFFeVVKYU90ZVRRejNMTHBteXVJejliMW96Yk5sTk15UVFXclEr?=
 =?utf-8?B?QlZ3YzFnNDBPd0pVYVlNdld0NXhMeTR1aGR5bFFGN2hoekl2T01mKy9TV0hQ?=
 =?utf-8?B?SktNbkpiVDJFcHlicHBVUFdweGd2RkNhekZJKzFDbkNpREltWkFkTS96cEFY?=
 =?utf-8?B?YU5WWHk3cEtmV3ZsY1B5amFveHBGeU1HQWw2eW13bTB3UGlqdkNTSmI2ZTRl?=
 =?utf-8?B?M1ZJSXg5ZGZwTzBZWHN1UlZsUVZoL2lVSmRja1dhalBBT3hnb215TlA4RHBQ?=
 =?utf-8?B?UDdIOGdkUWZtNWM2akVrS21ZcmtnSEJ0clRjUmJpQ1VvUzR2R1NpQWRNOXZq?=
 =?utf-8?Q?LYrUayXQ5BPfpuW+Gybz4LxlLgV8VN22?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3NUVDA1ZjZtTTRCa0dGdWxhaFFtVEhZQnVySHhnM0YvaitQYWhHVVo3VDVJ?=
 =?utf-8?B?RzR5N2lTdWFlaWtoL3BQVmxxQmorbVBNRXdyWkdOdlJic0FyRkVDcklGaHgw?=
 =?utf-8?B?Y21RQk90aHlWLy9LOWhjUmlXbWhmM0dPYnpZdDJFL3luR2gzbFpPeEFhZ0pY?=
 =?utf-8?B?Nm9DQTQrMVZkSmlCakt4Yk5yeG5zUmIyUUZ1TGpIV1B6YlUrakpFWnc1cFJO?=
 =?utf-8?B?QzF5eHJxWVdJT2NaRURxdE9HSmh1NC91MWdTeEhZbnNFUU9UZnpJNnljR3hJ?=
 =?utf-8?B?Q3JEMEZWYm1oYTBwbG5MQ0tVN2pvbXZEMkp6S0pWa2FITnpGTmExdEJIRDNu?=
 =?utf-8?B?SDdsb1hxMmJ5NHZhbStpQmJkd29NbDBtWkMzc0t4bzBIb3djb2pTYi8rOWR5?=
 =?utf-8?B?NmI3TkdnMlRGa2FTTmx3WFBrM2RvRlk0d2s4NkFNZWtzOHQwa21sVWZiVndH?=
 =?utf-8?B?UndjblBQQ0tCRiswTVBLMUZFUXQrMWpQMWRJcGtSN0dUaVNSMnNyMGF5ckZl?=
 =?utf-8?B?YnlrWTFqT2lieFhlMWlneUlhVUV2K3lWSndxWjRESFlsbk9ZTHpvWmxhcUtu?=
 =?utf-8?B?SktqeGMwOCtVOVl2NC92cHRyeGlabWhiWCt2NVppdjRhb3IvREp5Tjl2bEVC?=
 =?utf-8?B?VVBrazBQK3F3ZWNzUW5aMzg3a3FEUW8rKzhvd2JzRS9lZW92ZzJzOWp6OVQ1?=
 =?utf-8?B?VVEvSG53L1Nvc2o4T21CZ1JGQVJYYWk5Nk1tMjlsbUhFQ2J0enRIZEZCV2V6?=
 =?utf-8?B?cTkwdVdNellQdjZ2bW82YVpBM3FwYkd4a3FhRjRKVnV2VFBkUXlUcjBZdTFp?=
 =?utf-8?B?YnpuQ1FFeVIrVXNwQ2sydDFTcUJvRzBVdHVHYkhJRkJ6Z1JEOStSRWE5NTYx?=
 =?utf-8?B?M0xoNktYdWU3dERUUmQ1TE5QU0V1Y2Jsc3NKRXA5ZGlIVzBwYWpFd3JUZFBQ?=
 =?utf-8?B?MFBHSktsMGhteUYzbWV5OURZdUZVVW9kVkNhNmVSSVZPY0JCQ2w0MUVDWVhB?=
 =?utf-8?B?eHVaR016MDJXVXBXRmtDSmlhWXNjYTdkZi82cER5TUpBT1RFeGFmbXR0UW5M?=
 =?utf-8?B?SEgzcWxtM2pPb2VEUDkzVlV0STJyYmUva1FBNkZrK2ViNmJQQmF6bGcvYnYr?=
 =?utf-8?B?bkk5REw5ZzVjbkkxOTRXUmhjcWg1OEpSSWlFRnZsdVA3RDVQaGpuWFhSSE44?=
 =?utf-8?B?eW1lM25hMGNIWXJaWTdmTlFNTTk2WUZITlpLVnJXM0d2RXA4ME0xcThLNUQ5?=
 =?utf-8?B?Z010N1BXQk14UWxXcHlFV3c3d1hxVUhWS0lpSm5VR215bm4yZ1lnQTlQcGta?=
 =?utf-8?B?UHc2MVBiS0tobmhJZUtLZFpCWStIeFFiUXZDdmRTTGZiZ2VuMDJ0UWFFbFZE?=
 =?utf-8?B?TzJIbXZhWXBOblRsV3Y5SE14TndxTXFSQThqU29LTEhYRDZ1TXZhMmJhRSsr?=
 =?utf-8?B?c0NJMTN5WUQ4TkdPSGVTQi9tZUpTSnNpYVVJRHFUWWMrcitDYXdLa3J6OGds?=
 =?utf-8?B?L0hhRVUzNkt6THRhUmt4d1FRZmtzMlhUR3dtWkVUY0UxNEQvNUFRY0NpNTJt?=
 =?utf-8?B?c3NydmpXSVp2Nm5JNnVIaDJ4VHB1TkllT3RIbnpPcnBSaEpBTmMzQ1l1bEkz?=
 =?utf-8?B?UnhEdG1oQi9ORUQwY0VUTEdPT0k1T1cxMldXNnpFMURPWkpBb0NnbDZxZm9L?=
 =?utf-8?B?Q1c0Qkw3UnZPYzJSVTd3V1VjcmFRL1N3ZGxWU09WNnhUTUdnVTFEeHl6UkEv?=
 =?utf-8?B?R2dWTWRpLzlobHM0K2szMjEySi9UK0ZnMUxLck43RWZOcUFDZTd2ZU9EMFJQ?=
 =?utf-8?B?TkRwbUgzdUdUQUM3MDlLejZKSy9JZGJQbU5lUHdxSzFHVHFjZ0p4QmkwRXlJ?=
 =?utf-8?B?ZVVsalVxeTBzbmhhcHdYOURMZmk0NDBwcGE1YjlWWHlpcmtUSk1KcTVjOXVz?=
 =?utf-8?B?ZVdoeHpVaVNrcWNVcDMxQjNFQUVncG5BZmJUV2gzT1dObThSRXAycU9XVkpa?=
 =?utf-8?B?Zk05Z1c2QlNZcVhteGR5ZUNRcnIrWkVYU21aVi90elpTRjFmcTNXTENrSEkz?=
 =?utf-8?B?MXQ5QytoV2o5WGgxV2NsS0Y5L0dhOHZCakJQZEMrM1ZUQkJCQTlwOFdpeGtW?=
 =?utf-8?Q?hjdo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b02752-7018-4650-9666-08dd1dd9c61d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 13:58:52.5176 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rKg9n5Z6d4bzvIyMJRpJ6Ommp5H1pPTrlqZSXBQ4Ykz7jR6ihQpm22e9pKqoJWuTIwpvJLZlhruxYCpoBGsADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTYsIDIwMjQgNDowNiBQTQ0K
PiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFyYXB1QGFtZC5jb20+OyB1
LWJvb3RAbGlzdHMuZGVueC5kZTsNCj4gdHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnOyBqLWh1bXBo
cmV5c0B0aS5jb20NCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsg
amFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IHZpZ25lc2hyQHRpLmNvbTsgdS1rdW1hcjFA
dGkuY29tOyB0cmluaUBrb25zdWxrby5jb207IHNlYW5nYTJAZ21haWwuY29tOw0KPiBjYWxlYi5j
b25ub2xseUBsaW5hcm8ub3JnOyBzamdAY2hyb21pdW0ub3JnOyB3aWxsaWFtLnpoYW5nQGJyb2Fk
Y29tLmNvbTsNCj4gc3RlZmFuX2JAcG9zdGVvLm5ldDsgcXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRl
OyBUYWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tOw0KPiBwLW1hbnRlbmFAdGkuY29tOyBnaXQg
KEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbXRk
OiBzcGktbm9yOiBGaXggdGhlIHNwaV9ub3JfcmVhZCgpIHdoZW4gY29uZmlnDQo+IFNQSV9TVEFD
S0VEX1BBUkFMTEVMIGlzIGVuYWJsZWQNCj4gDQo+IE9uIDEyLzE2LzI0IDU6MTYgQU0sIEFiYmFy
YXB1LCBWZW5rYXRlc2ggd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+ICsrKyBiL2RyaXZl
cnMvbXRkL3NwaS9zcGktbm9yLWNvcmUuYw0KPiA+Pj4gQEAgLTExNDAsNyArMTE0MCw3IEBAIHN0
YXRpYyBpbnQgc3BpX25vcl9lcmFzZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwNCj4gPj4+IHN0cnVj
dA0KPiA+PiBlcmFzZV9pbmZvICppbnN0cikNCj4gPj4+ICAgIAkJCQlub3ItPnNwaS0+ZmxhZ3Mg
Jj0gflNQSV9YRkVSX1VfUEFHRTsNCj4gPj4+ICAgIAkJfQ0KPiA+Pj4gICAgI2lmZGVmIENPTkZJ
R19TUElfRkxBU0hfQkFSDQo+ID4+PiAtCQlyZXQgPSB3cml0ZV9iYXIobm9yLCBhZGRyKTsNCj4g
Pj4+ICsJCXJldCA9IHdyaXRlX2Jhcihub3IsIG9mZnNldCk7DQo+ID4+DQo+ID4+IFRoaXMgY2hh
bmdlIGlzIHJlYWxseSBpbm9idmlvdXMsIHRoZSBjb2RlIGFib3ZlIGxpa2VseSBuZWVkcyB0byBi
ZQ0KPiA+PiBjb21waWxlZCBvdXQgaWYgdGhlIFNQSV9TVEFDS0VEX1BBUkFMTEVMIHN0dWZmIGlz
IGRpc2FibGVkID8NCj4gPg0KPiA+IEluIHRoZSBzcGlfbm9yX2VyYXNlKCkNCj4gPiAJb2Zmc2V0
ID0gYWRkcjsNCj4gPiAJaWYoUEFSQUxMRUwpDQo+ID4gCQlvZmZzZXQvPTI7DQo+ID4gCXNvIGZv
ciBwYXJhbGxlbCBvciBzaW5nbGUgY29uZmlndXJhdGlvbiB3ZSBuZWVkIHRvIHBhc3MgIm9mZnNl
dCIgdG8gd3JpdGVfYmFyKCkNCj4gPiAJd3JpdGVfYmFyKG5vciwgb2Zmc2V0Iik7DQo+IA0KPiBU
aGUgY29kZSBhYm92ZSBsaWtlbHkgbmVlZHMgdG8gYmUgY29tcGlsZWQgb3V0IGlmIHRoZSBTUElf
U1RBQ0tFRF9QQVJBTExFTA0KPiBzdHVmZiBpcyBkaXNhYmxlZCA/DQo+IA0KPiBbLi4uXQ0KPiAN
CkFscmVhZHkgdGhlIGNvZGUgaGVyZSBpcyBiZWluZyBjaGVja2VkIHdpdGggdGhlIGZsYWdzIFNO
T1JfRl9IQVNfUEFSQUxMRUwgYW5kIFNOT1JfRl9IQVNfU1RBQ0tFRC4gRG8geW91IHdhbnQgdG8g
YWRkIHRoZSBjaGVjayBTUElfU1RBQ0tFRF9QQVJBTExFTCBhcGFydCBmcm9tIHRoZXNlIGZsYWdz
Pw0KDQoNCj4gPj4gSWYgSSBsb29rIGF0IHRoaXMgY2hhbmdlIHdpdGggJ2dpdCBzaG93IC13JyAs
IHRoZSBjaGFuZ2UgbG9va3MgbGlrZSB0aGlzOg0KPiA+Pg0KPiA+PiAiDQo+ID4+ICAgICNpZmRl
ZiBDT05GSUdfU1BJX0ZMQVNIX0JBUg0KPiA+PiArICAgICAgICAgICAgICAgdTMyIHJlbWFpbl9s
ZW47DQo+ID4+ICsNCj4gPj4gICAgICAgICAgICAgICAgICAgcmV0ID0gd3JpdGVfYmFyKG5vciwg
b2Zmc2V0KTsNCj4gPj4gICAgICAgICAgICAgICAgICAgaWYgKHJldCA8IDApDQo+ID4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGxvZ19yZXQocmV0KTsNCj4gPj4gKyAgICAgICAg
ICAgICAgIHJlbWFpbl9sZW4gPSAoU1pfMTZNICogKG5vci0+YmFua19jdXJyICsgMSkpIC0gb2Zm
c2V0Ow0KPiA+PiArICAgICAgICAgICAgICAgaWYgKGxlbiA8IHJlbWFpbl9sZW4pDQo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gbGVuOw0KPiA+PiArICAgICAgICAgICAg
ICAgZWxzZQ0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICByZWFkX2xlbiA9IHJlbWFpbl9s
ZW47DQo+ID4+ICAgICNlbmRpZg0KPiA+PiAtDQo+ID4+ICsgICAgICAgICAgICAgICBpZiAoQ09O
RklHX0lTX0VOQUJMRUQoU1BJX1NUQUNLRURfUEFSQUxMRUwpKSB7DQo+ID4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKGxlbiA8IHJlbV9iYW5rX2xlbikNCj4gPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gbGVuOw0KPiA+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVsc2UNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlYWRfbGVuID0gcmVtX2JhbmtfbGVuOw0KPiA+PiAtDQo+ID4+ICsgICAgICAgICAgICAgICB9
DQo+ID4+ICAgICAgICAgICAgICAgICAgIGlmIChyZWFkX2xlbiA9PSAwKQ0KPiA+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOyAiDQo+ID4+DQo+ID4+IFdoeSBpcyB0aGVy
ZSB0aGlzIHBhcnQgb2YgY29kZSB0d2ljZSBub3csIGlmZGVmZmVkIG91dCBkaWZmZXJlbnRseSBp
biBlYWNoIGNhc2UgPw0KPiA+Pg0KPiA+PiAiDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaWYgKGxlbiA8IHJlbV9iYW5rX2xlbikNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJlYWRfbGVuID0gbGVuOw0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
IGVsc2UNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0g
cmVtX2JhbmtfbGVuOyAiDQo+ID4NCj4gPiBGb3IgcGFyYWxsZWwvc3RhY2tlZCBjb25maWd1cmF0
aW9uIGFuZCBhZGRyZXNzIHdpZHRoIHRoZSAicmVtX2JhbmtfbGVuIiB3aWxsIHZhcnkNCj4gYW5k
IGFzIHdlIGRvbid0IHdhbnQgdG8gZGlzdHVyYiB0aGUgZGVmYXVsdCByZWFkIGZ1bmN0aW9uYWxp
dHkgYWRkZWQgdGhlIGlmZGVmDQo+IHNlcGFyYXRlbHkuDQo+IFdoYXQgd291bGQgaGFwcGVuIGlm
IGJvdGggU1BJX0ZMQVNIX0JBUiBhbmQgU1BJX1NUQUNLRURfUEFSQUxMRUwgYXJlDQo+IGVuYWJs
ZWQgb24gYSBzeXN0ZW0gdGhhdCBvbmx5IGhhcyBvbmUgU1BJIE5PUiBhdHRhY2hlZA0KPiAobm9u
LXN0YWNrZWQvcGFyYWxsZWwpID8gSSBub3RpY2VkIHRoZSBzZWNvbmQgImNvcHkiIG9mIHRoZSBj
b2RlIGJlaGF2ZXMgc2xpZ2h0bHkNCj4gZGlmZmVyZW50bHkgaW4gdGhlIGVsc2UgYnJhbmNoLCBz
byBkb2VzIHRoYXQgbWVhbiB0aGlzIHdvdWxkIGJyZWFrIHN1Y2ggc2V0dXAgPw0KDQpJZiBib3Ro
IFNQSV9GTEFTSF9CQVIgYW5kIFNQSV9TVEFDS0VEX1BBUkFMTEVMIGFyZSBlbmFibGVkLCB0aGUg
InJlbV9iYW5rX2xlbiIgbWFuaXB1bGF0aW9uIGlzIGRvbmUgdW5kZXIgdGhlIENPTkZJR19JU19F
TkFCTEVEKFNQSV9TVEFDS0VEX1BBUkFMTEVMKSBjb2RlIGFuZCB0aGlzIHdvbid0IGJyZWFrIGFu
eSBkZWZhdWx0IGZ1bmN0aW9uYWxpdHkuDQoNClRoYW5rcw0KVmVua2F0ZXNoDQoNCg0K
