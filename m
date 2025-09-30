Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF19CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86091802C1;
	Tue, 30 Sep 2025 18:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="x9XfG8JZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 098B983071; Tue, 30 Sep 2025 18:03:38 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E44B9800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Conor.Dooley@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1ToFsVE6Iq6Ut5f2IOBZ1eSnXyrJGWAsS12Qu9V+Nt4lldzPUs9qZFPtnlmqSIlLjAcg3gwqt/HUEYoQsUKh07J2kjdiJ63INTJRJ5VbQM4vUGVYD8u+AQ4yAiPyItn5DQt+PQG8LHe6gCxlSPl9Jnje1GiLL1tEk2/nwvsp7IqS4RCn4L96w6p1S223p/tgVPUGCuHMjrKINHYjO3JFcps8gsO/+cEtVnIjAzwqr52rZ2b4ftLJewQVuKzsANbkQ8ZatfeE3tYbhw6v3bHBQJ2WM8XfDBAotP1zZrl4xpmclgChlLvVC+sgC7AlMNm8AO9mhBgNjSQux3Y6YzbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6kOIfxyuiBmDxM6buWCXY5hn4scCJPYYOAEfeskYqM=;
 b=o0O5fKONGLrpQMOp+fKN3ra9KpE9PWKV9mcuA3QYMWiW/f3MmV5+QkEYnaPZHQ3xGTiblahLwQkzZn7sV7TZS3DgRkxPfpMROLCpxx5xjK+603s97uJaPB48lNLtsCn5wAMZdg9HVvnOWMfmFUhn1DNXzlCD3U3p30gJd07ravOd2ELnV0I/NLMJ2ZkAVoTuUyfCftYE5AXNB8CJ8iHoYw4C3CMEoJnd8e7RCZ52dbjyX7s/a/RIgMFHeEokPfkHc5cXhhrz3qQii5iymmKxeCsF6LrEj2LR7bOuGqTEwbU3J5vkjRUwSa6eEv1Y0jIt3wX5cvZ+FmVGe08EbsqHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6kOIfxyuiBmDxM6buWCXY5hn4scCJPYYOAEfeskYqM=;
 b=x9XfG8JZLSFzHqgLZEXbo3VdM/+UsoboOkpPQifvTEiRpdi4OOolJ8UGxuJmeei9wSvgJnuZ6dEymzyPb1UJPQwzrIJFxdLbZlGFckKmknDZrCEtuAlzyHfbt8UktfrMN4O3uQ9k2H0xn3o2Js/s3HUfRY/FQGp2Yf0xR178Iw7KULuRVmbQc9ct8TGYNAuDdi7oFpp2rPNv5CuCmvROGts+wLEQUERzd1WTrn2inw4Cl5uRmx8NzdPZvaDg6G92v7Cw+2kUOlcrgD8NX+3h3jCVUui1pnrXnCvnR6oZgTU+tl4j2fTa6AAnITKv7Xm2iE92DXdhqus2OebpvqQpvg==
Received: from DM6PR11MB4282.namprd11.prod.outlook.com (2603:10b6:5:1db::24)
 by MW4PR11MB7127.namprd11.prod.outlook.com (2603:10b6:303:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 16:03:29 +0000
Received: from DM6PR11MB4282.namprd11.prod.outlook.com
 ([fe80::da3e:dd0:e4ef:f2be]) by DM6PR11MB4282.namprd11.prod.outlook.com
 ([fe80::da3e:dd0:e4ef:f2be%4]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 16:03:29 +0000
From: <Conor.Dooley@microchip.com>
To: <trini@konsulko.com>
CC: <Jamie.Gibbons@microchip.com>, <u-boot@lists.denx.de>,
 <Valentina.FernandezAlanis@microchip.com>, <Cyril.Jean@microchip.com>,
 <ycliang@andestech.com>
Subject: Re: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Thread-Topic: [PATCH] board: mpfs_icicle: fix pointer assignment in
 board_fdt_blob_setup()
Thread-Index: AQHcMiDJOBM3kXBI00CKAui/dLrTGbSr3xyAgAAArQCAAAExAIAAAkkA
Date: Tue, 30 Sep 2025 16:03:29 +0000
Message-ID: <6e30a206-a0c0-4ecf-9d69-6ce35f4a52b3@microchip.com>
References: <20250930154534.3914214-1-jamie.gibbons@microchip.com>
 <20250930154837.GB6093@bill-the-cat>
 <f6b35b7a-457b-48e9-bec7-df3e57b9f6ed@microchip.com>
 <20250930155518.GC6093@bill-the-cat>
In-Reply-To: <20250930155518.GC6093@bill-the-cat>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4282:EE_|MW4PR11MB7127:EE_
x-ms-office365-filtering-correlation-id: 5d7bc334-7cf6-4e13-9bb0-08de003ae5b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZWtOdHBnQVBzYmkyRjRtZ2hPWmY4RFc5T01mZUo0L1ZTU2J2RFZKeFVJWlpW?=
 =?utf-8?B?TE94TGhXRENpbEUweiszUGdHZCttSmRIL2ozY3FUb25yZHUreG9oZEhYWHMw?=
 =?utf-8?B?a3VadEF2ZEZhc2VHeER3QmRCWXlmYjdEV2lYTnpJZit4eDk0UDIzS0dnaTFn?=
 =?utf-8?B?Vmp6VE9hRWxDYVMwMy9mNENVbjR1Z2p5ODk2bFZJNUNsMzlFMlJXRzUrQU5t?=
 =?utf-8?B?N2tsSzluSmp0SGl5L3VQcGRMNW5FdXVSVzROVkY2RnQ3eXlSK2EvN0dVZ0FW?=
 =?utf-8?B?bGlYcmI2aWdCQVJkWXd4VUgvak1rdkcxd3luZ0wwbmJvR3Nhb096clpaQVJk?=
 =?utf-8?B?TWNMRHRzWjBxbmo5MzZ0N3VYQXVnN2t4UUlwWWVTcUJRY01QTlhwTy9OWUd5?=
 =?utf-8?B?NHZpOG1NZWRMUGFDZmlHR0pxdUtVNk1RM1dYTUY5UXFRWi9FUmhmaEdoOXBW?=
 =?utf-8?B?cmgydDFPRGluSTVqNGlQNldhRVZjUWNCQnZTbjJZUEpyR1BCK3hKWWlDM1Bi?=
 =?utf-8?B?Z3d5dTdMSktHVjBVS3Y4Rlh1ZGFIc3EvRWp4QVlqNDdKL2o3TE9reUcxa0dB?=
 =?utf-8?B?SUNGV2c0eUJKdU5wUmUzejVuRUI1b3JKQ0lMeWxGVGdjTlIwZHBac3FmVEhM?=
 =?utf-8?B?cVIxWHhmSDRnQlpnNEZ0SkE3VVYrNGpvOXZBYnlmd2Vkd3RyaWZOQjVyM05D?=
 =?utf-8?B?eE1vbzE5d1ZBbTZTZHd0anF6OFZCcHpHYlBkRklnVDJUWm9WcE5oVEVRMzly?=
 =?utf-8?B?VkxWVGZzUmdyRmNpRGN1dGhISzlnRkNMZzd2VU82NFU0aVZnNlFUZmtJd3hJ?=
 =?utf-8?B?ZXVtWlN1OTcwTlQ3blZNVEsxdVQ5NDd0OXFlRWhmSFkrRXNHcy9LS0ZISUNq?=
 =?utf-8?B?WUV5dTVzK2xES0kyNG5EcEZEMnRQcjdScDlqZXFBamNBRlF1ZWJnckNPN0V0?=
 =?utf-8?B?dUJLQVRYcXA5WEtsSXdYMGtxMnpXdXJkaHVOcGtXaTVNek5meENaNEZORExR?=
 =?utf-8?B?SDdmR3MvT3hnVGRRYzFGM3pKSHpqNjQ5K0lvakVJY3JsOFlGTEFEb2lZZzFN?=
 =?utf-8?B?RHZqNVhkN29LaldvMUJpSXhlTXJaZkpFdlg4eU1XM3JlSkZ6dlhpdUk2Uzh3?=
 =?utf-8?B?bzRqOWZtTXdHcVk5Lzc2Z0I2ZitjVGh5eEtwd0JXU1BBV0JBcWQ1ZTVDWEZi?=
 =?utf-8?B?cWxTZzY5R0w0b0p0aUx5cklrSmJaNVdVWi90YzhYS21Za1Vnem8yMmhwOEJX?=
 =?utf-8?B?eituajM1aGNKL2Y4b3BUWUJtN1pEMUR1ek9EQmRBWjlpUW9lYmFLZ2Fna0ox?=
 =?utf-8?B?L2hwM3htOFp4L0hDUTZrNXQ5aWhlM2NFZ2R3bFc5Rk9hTEE1MEJ0VGszSytR?=
 =?utf-8?B?RDUvV2krQWFGV09EZnNjRjdZZXcvUDdwcDFrU0puMk5ZQ0x6UWxodEhFQTFQ?=
 =?utf-8?B?dW81OWlqTjJqK1N6Z3UyZTRxYitJK01RQkZlZGV3MjFhUW5JbFRDaXV0eVo0?=
 =?utf-8?B?bUtOTnZsQm9CN1dCcU1YMUQwdnZNQnNqbElhRjh3dGVVMUQ3dEN0K0Y2UzhS?=
 =?utf-8?B?a2d6OXZhbW9wWVFlMTcvWENFNE9XazJIc0JGeC85V3VieWhsbEFpbG1BY3NE?=
 =?utf-8?B?QmE4aGpvdS83enlvVnp2dFVaWGo0NWFVVW5IVDVNZXRZVzZINXN1WndzUXNj?=
 =?utf-8?B?b2VwSkVXTm1MNE1OT29mTmx1bC9XTldkRHRSeXloWWpoSGZ6cnVhcnNaOThP?=
 =?utf-8?B?MGtCRVlqdlJJbjUwb1ByazErS1RWMUJoYTNua0xRTDhaWGd5YVE0b242RE0x?=
 =?utf-8?B?emlnVGMrZXZzRXcyS294Z0RqeHhEUldESDFoaS9uckRrMkk5SDAybXJHK0dQ?=
 =?utf-8?B?MWxhWVU0MlRiL2dqb0V0dEtVZCt4Q2hoN2NEclZibFc4YU94NE1MY2FGV1Rl?=
 =?utf-8?B?QUQ4bXBZODV2MXNVY3oxVDl3NEdRMVpLZUU4Qzh0dWYxZE1VMGVYNFVFZ1Aw?=
 =?utf-8?B?WXMvS3JLQlFGUFZndmp2YWFiMjZ1Z3N3SnNjaS8wOExKWkcrT2l2YVFVcnQ5?=
 =?utf-8?Q?IkKNoO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR11MB4282.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1NKSExzdGNYaDBBRCtCYlJuM3paaUt0YW5uOVQ0cUhWNG16RGdXK1FuVFNC?=
 =?utf-8?B?NXgwNU4rMVJubXp0cExsSmIvb0hyR2cvaFppTGNSeTdUY2cwN1pPUHJCdy9t?=
 =?utf-8?B?bzJNbU5mZUhOZXBTLzd4Tkh5WjFYemdLdmpUVXlqQkY5TlBxSGlNaVhUTS9p?=
 =?utf-8?B?YkRRUDJVdVhCaFFXeDJrcWZRWDhpbkY3dzdSSGVpSlNWYmtJMlhneTF1SmlX?=
 =?utf-8?B?bDdObjhYelJlOFNEVjg3eFFuRmxTQ1Rwc3JiR0tFMU5BWmtHZ3ZDbkVzNEtu?=
 =?utf-8?B?SXByYWZFeUJCTkFSdUE3QjVJQlpBTjZkSGNtWnBVSEVES09FeVVlYnBPSUk2?=
 =?utf-8?B?LzNiOGcyb2lRUElDOCtzdDcyUEtvWS9USnRkdHB4Y1ptR25IaVFYWmF3VWZs?=
 =?utf-8?B?SWpWSEorRUFISFRoM2llY1p5NHgwTzNnM3pCUDZheUwySEh1RWdlSVltalJL?=
 =?utf-8?B?ODlBb2w2NGZCU2t5ZjVucXp0bmZJdW50MW55b3ZvQnVsVFhaNmJoQ0JyL1R4?=
 =?utf-8?B?c3ZNVU9sUmQ3eG1XRDZJdlRNQlNDNnA3a0xjUnYrNEY0eUY0SXEzTW53Z3Jn?=
 =?utf-8?B?RXQ3SXlwTUx5Vkw2Q3p2eFlTSy9US3NVL3ZidzdKeGlMUFpTNG1SdlN0TGtO?=
 =?utf-8?B?RmhJRWNqWU9jUnhBQUpOQzFOYzNuN3c1ZDV3QXBoWjd4WXJoZ25qWloybGNV?=
 =?utf-8?B?NTFaMlJXUHFSRjBwUlNxS1JLbnBMbW9JTDdzTGxnckkxSi9ud3pVZVhQVnJ4?=
 =?utf-8?B?b1NwNVdyb3E0UFJldENHR1RtaUh4RitVTXNtL2ZUc3NMbWo0ci82dldLK2Na?=
 =?utf-8?B?TG5KNHdYSDVpUFhZTExET0R0M2lkeHE2S1dldkc1YkswN3lVUVVkbC9sbEt0?=
 =?utf-8?B?NmFKM0phZnFyTDFjZk9tRXBQSENyUDZIc0VxNXZxZ0FNbEpaVHFYUW1uQnVC?=
 =?utf-8?B?d0hJSjVNbjBJc3U1U1QvUlZ6cHFQSGlCbTU5ODFwT1VJNFpxZWRya0paUEZi?=
 =?utf-8?B?YkkxMUQzVDc3YW56VW9TZTlSaWtwaHM0TEUrN3E2ZHpoSHV6NldmNTUzTWNu?=
 =?utf-8?B?ZHpjSjRyMDVvOW9SNFIzeEVuYVllUEFSbzc2czlJa01Pd0VPNjZEVS9VM1FD?=
 =?utf-8?B?MWxidzJUaUltN3Q4K1VZWWpUcm9tVXFIdUpReWJ2WjlRMjVUWFd3NldEcTF6?=
 =?utf-8?B?WHB5T241OVBTU0lvZGlvbEJTQzErRXllUDlOeHhUbTBBK2VEUmdOZTN2Vllt?=
 =?utf-8?B?dllidlFGU0VpU2QxZUk5aXBCNW81djJKWTdIQytHS2I5bnpaclRyOG8xcGJo?=
 =?utf-8?B?UFpteUFwVTFxUkF6eTRicFIzenl1aHZXSExmb0JsTXlzRFMrK1pjVkJmREdW?=
 =?utf-8?B?VWdLYkM4a1dLdmFvK1RsRlE0d01uc2phaGthOHFGanZwKzl3dy9sbU96U1hx?=
 =?utf-8?B?WGRFWHZscFNDbC9hQmVncDJlUzhGSlJNS0ZkUzJKakx1S0QzQnNuMnJOZjBU?=
 =?utf-8?B?d1I3WHo3RGpPMHBERlpmNU1XRkxCaEZuNmNvdXlJMkFJbDR0eVdJYXVXOHF2?=
 =?utf-8?B?MCtNcDFvNFNuVWJZWWFvZG9ZSFZrU09mVngvZkRhMXlmUUhtcjJQa1RyaU1R?=
 =?utf-8?B?TzE3WExhejZocDR5V0FUU0JsMnErOUM3R0JkamVPVTA0djJacmRrNjVLMmov?=
 =?utf-8?B?amRUWG16YU5TWTVVS1BJUCs2NWY0TG8xNEgzMjNEa1kvMm14MVE0Y2RxV29N?=
 =?utf-8?B?UXVETnhFbTRRZ3VTa1JxWWYrWjJxa05sUEJZNjVvNDNWbEt1aDRVelZLb1pS?=
 =?utf-8?B?U1lIREh5M2pQcWI5dGtlK2h6ViswaG1QSStRd3lRbXBSYVRHM1hWT0hTcjUw?=
 =?utf-8?B?TFVhdENLK0tTeHZnYm9SeEV5WVhyaEk0Wm9XQTl1dmcyUmF0ejZ4V1NuWGJT?=
 =?utf-8?B?SnZZOUw2Z1duT3ZzT240Y3JpTXVIdFdsLzhPUStkdFRMVy9sN24vbXF5K0dI?=
 =?utf-8?B?eEJXblRsazBFK3JIUnBGUXRvR1hXUFFjSXQzb3ljT1VMMHJtNHdnSGRXbjdp?=
 =?utf-8?B?cEpOTEJtUGxrMlAvVld1ZU13VUZxNWJlaXB6QWR2MVJwT3JkSlY3WHhhcm92?=
 =?utf-8?B?MW9ML0pFSkhkRXgyV2plaXd1ZXUrSVZxcHQ0ZjF1R0NMZk9KRCtPZW9QOWxD?=
 =?utf-8?B?Z01TaThMMDhnOTVEQW1NNE51MXh2RFBFQzAxdmFscTNPMFE4b1RVbnNQMkZE?=
 =?utf-8?B?MDdLbVRtMElsNG5kQ2xzbnl6NnBBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D8799795F64604DA7A9BCCF088BACAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4282.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7bc334-7cf6-4e13-9bb0-08de003ae5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 16:03:29.4778 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: issFOgDpL12CPQbYZG7PLSotk6S9Eqpd7tQG6rpbbCLladOJVzyd7vi55alrjBooi/scasr6c0UJ/DEBkwRF0cWNqUEGDcMexWfiTL42RcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7127
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

T24gMzAvMDkvMjAyNSAxNjo1NSwgVG9tIFJpbmkgd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDMwLCAy
MDI1IGF0IDAzOjUxOjAyUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPj4gT24gMzAvMDkvMjAyNSAxNjo0OCwgVG9tIFJpbmkgd3JvdGU6DQo+Pj4gT24gVHVlLCBT
ZXAgMzAsIDIwMjUgYXQgMDQ6NDU6MzRQTSArMDEwMCwgSmFtaWUgR2liYm9ucyB3cm90ZToNCj4+
Pg0KPj4+PiBDb3JyZWN0IHRoZSBhc3NpZ25tZW50IGluIGJvYXJkX2ZkdF9ibG9iX3NldHVwKCkg
dG8gdXNlICpmZHRwIGluc3RlYWQgb2YNCj4+Pj4gZmR0cCwgZW5zdXJpbmcgdGhlIGNhbGxlciBy
ZWNlaXZlcyB0aGUgY29ycmVjdCBGRFQgYWRkcmVzcy4gVGhpcw0KPj4+PiByZXNvbHZlcyBhbiBp
c3N1ZSB3aGVyZSB0aGUgZGV2aWNlIHRyZWUgcG9pbnRlciB3YXMgbm90IHByb3Blcmx5IHNldCBk
dWUNCj4+Pj4gdG8gYXNzaWduaW5nIHRvIHRoZSBsb2NhbCBwYXJhbWV0ZXIgcmF0aGVyIHRoYW4g
dGhlIGRlcmVmZXJlbmNlZA0KPj4+PiBwb2ludGVyLg0KPj4+Pg0KPj4+PiBGaXhlczogNjNhODUw
NjU4MGI2ICgiYm9hcmQ6IG1wZnNfaWNpY2xlOiBpbXBsZW1lbnQgYm9hcmRfZmR0X2Jsb2Jfc2V0
dXAoKS9ib2FyZF9maXRfY29uZmlnX25hbWVfbWF0Y2goKSIpDQo+Pj4NCj4+PiBUaGlzIGNvbW1p
dCBpcyBub3QgaW4gbWFzdGVyIG5vciBuZXh0LCB3aGVyZSBpcyBpdD8gSSB0aGluayB0aGlzIGlz
DQo+Pj4gc29tZXRoaW5nIHRoYXQgY2FuIGJlIGZvbGRlZCBpbiB0byBhbm90aGVyIHBhdGNoIGFu
ZCB0aGF0IHBhdGNoDQo+Pj4gcmUtcG9zdGVkLiBUaGFua3MuDQo+Pg0KPj4gSXQgc2hvdWxkIGJl
Og0KPj4gRml4ZXM6IDdjMTZlYmJhMWVkICgiYm9hcmQ6IG1wZnNfaWNpY2xlOiBpbXBsZW1lbnQg
Ym9hcmRfZmR0X2Jsb2Jfc2V0dXAoKS9ib2FyZF9maXRfY29uZmlnX25hbWVfbWF0Y2goKSIpDQo+
PiBhbmQgdGhlIHBhdGNoIGlzDQo+PiBSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5k
b29sZXlAbWljcm9jaGlwLmNvbT4NCj4gDQo+IEFoLiBBbmQgdGhhdCBpcyBpbiBtYXN0ZXIsIHNv
IHRoaXMgc2hvdWxkIGJlIGZvciB2MjAyNS4xMCB0aGVuPw0KPiANCg0KWWVhaCwgSSB3b3VsZCBz
YXkgc28uIEl0J3Mgbm90IHdvcmtpbmcgY29ycmVjdGx5IGF0IHRoZSBtb21lbnQsDQppdCdzIG5v
dCBqdXN0IGEgdGhlb3JldGljYWwgcHJvYmxlbS4NCg0K
