Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B75E77180
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 04:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B7D800D2;
	Mon, 16 Dec 2024 05:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K0JId9ei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66C0800D7; Mon, 16 Dec 2024 05:16:29 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E402F80050
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 05:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRdtddlrhIhfyCHCmNm0cEs7oxmtOk/mmuS15TQLAZ0wzq4PdUSiKj7uNFLgCNcZMRsYYF1SvyDawt5/A+Q8KZB5yYtmsGQtXFLcW3OA1prl2iBnIUH1h3qRunFIZ289b3EoEaamb2q39I5oyuv0IuNgewmJ65P1bRUHyeeIu7cXSU0n08c1vmGNGU9JRE1n6SeFvIAC5qW5dvVlDv3gxd5Mtmq63bTQdTOvfN0uFmOKKpxI07+Yj+cLNXBfF6FsxPBCFw2wRU2SMAqdG5vlDuCkTO2sMvBRhuXozS2NpUBqOHlD3JnfhE+45SkvAtG31QHuesND88pjhD7mP6ykvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ob+blxCpsVBhOvt2HPrTR0/ePGLNe+qljlHUOm1bdq8=;
 b=nVIur3Izn890rfgmId/Ad79451O1deUI1qEKFm7fTOXGDbMb7fmUW1WEn0//tU0JsHPE9vvbHAAF5xHHuRBi6JnBLGwXo6vsD4WyaJELA2HkOTMwvk9tKQC3OOZtEQU/etm4LpdAKLMi3lEBAyZeUABmTC50iPDBrQkc/ehvAih3rxdRaVsLwDUX8JnHeoVmQUhQC4vgsfOR8QWymVvO79MLH8dQhSZEMQHFNVICkGyNs27Nkci8pkTs+8L9r0g0cm5HNoin0P/wGftP/RPfnK+m21+CSrmiolOMtL/+4ucOhMnkfYDJRDhheI3pdrgSRw9RjQaZAJ7bReJ5e71aWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ob+blxCpsVBhOvt2HPrTR0/ePGLNe+qljlHUOm1bdq8=;
 b=K0JId9eiojUNbBnvoWemILKIKkvNuX9mcitz4AY92fGEF8YlJgg6mlbM75aaEx7DumunC8k3Ypu9+6Rx/0gqErNsqeXnpdYeucd3cqvHvFYKlCq6aXwDMSV87gLn8Dm4aI/GhfFnQWkFu43Fee8hC8FVVLd3S+MoUnnJBWq8kDA=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 04:16:20 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 04:16:20 +0000
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
Thread-Index: AQHbS8U++/+ZgliyKU+5ZpBpRoNYRLLoAMqAgABIX5A=
Date: Mon, 16 Dec 2024 04:16:20 +0000
Message-ID: <SA1PR12MB869702808B7A784031F17F83983B2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241211120644.775575-1-venkatesh.abbarapu@amd.com>
 <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
In-Reply-To: <fccae74a-3097-4172-8ae5-3bc72e8d9aa0@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SJ2PR12MB8784:EE_
x-ms-office365-filtering-correlation-id: 1b5f9c14-d226-4d71-a0e8-08dd1d8864ed
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?WTBqSzc1c1B4YzllSWNXQ3gwQkpDTFU0MzhVOWlIeGZ6U0dRTkpBLzcrVVU3?=
 =?utf-8?B?SDhOcDhwckphbVVVSGNhSnV4Zlp4ZEVrdTlaYVJPbHUwRmRmQWxqK3puaXJB?=
 =?utf-8?B?YVQzNys4TllkQTBaZ1dvVU5xdHVMc05zaWxNRXNNd2hEU3ZKKzVwM1prZ0VY?=
 =?utf-8?B?L0FKK2FDMlNPbHhDeTc0a2hDbjUzTHg4WWY4RkFCVG11NWNwRTNOSEVyUmtD?=
 =?utf-8?B?QXdkMTU5TDVEQnZmOVhTaUxKMG1iTmVSNmQ4SjlrdFBMN1JpVmRaTHQyQW5H?=
 =?utf-8?B?bmFmRDFDTlVYQTRYMldRaithNm5pTEVsaFJyMFNUWkNsN28wRmxGb3ZtL0hw?=
 =?utf-8?B?ZlpGWkR2bTJud2lwS1E5N2VQQ1luWXEzeEZIbW5DcUFSaGRGYTJRaFFhTHJa?=
 =?utf-8?B?UHdadzRiUkZleXlJcFBLWjROTXAvODJZRFVKR05mYWhJeFdFcGYrb2JyV2dK?=
 =?utf-8?B?M3Z3Ri9TTVBjdzRKd2pKMnhJeWoyRExwL1BnS3VGQXM1bDdDcU9WSFVocTd2?=
 =?utf-8?B?SFlBK04xMjk1dHBRUXF6WFRrVjJGUkxwK0UxU0J0R1FYZ3llWEVOeEVjU3E2?=
 =?utf-8?B?dnJ3M1BjcUU3MlMxK08veWhtN1p4S0NscFMrSEtrZzUvcXhtTmQ1UEUzNkZx?=
 =?utf-8?B?OXpkTGxlc04yQ0VPRG9QL1UrRkJzNTVZUStxMDMvOENWM1hOV2NKc29zaXY3?=
 =?utf-8?B?ZGV4dU4vOVVJOHhZMkc3azNCcElZQWx6L2NRNkJQcFFVQnlpZlplN2IyNmpO?=
 =?utf-8?B?a2N4cmJpbytzZ1JUVzVCNit6YTlTV0NybkdKbHdYb1Z4cmNFWWdmbEFzV3N0?=
 =?utf-8?B?eHIrZ0VKV094ejNRVFE0Z0JGT3FTNkU1Q1dvNkNQZHVQNGNQN0lxM2RMNzlu?=
 =?utf-8?B?QnF6T1MveGdhRjRCT2RFOGtsdUdpdy9JV1VjNm5EN2w5YXNtVER0N0JaN0sw?=
 =?utf-8?B?clhvWnE2b1BnV3oxVEptM1pLSGYrSm50V0psR3F0bEl5cngzbXNYajVuaUFK?=
 =?utf-8?B?VjBUdncxanAxS2VqNWJRUmxGbmo5T3dhU2srRUYza1pHdy9ZdEhmeDNBVTZ0?=
 =?utf-8?B?bmg2SGdDQ1JOekh2NmRVYjQ2UnFtTzM4TjlpOUtsN0lMakxBRVFlR1BuYnQ4?=
 =?utf-8?B?cXFHOExSR1hRRXV0MmNtSzlELzVCQi9tY2xFVi9DSkZqdHl2NjBtK21wTFpS?=
 =?utf-8?B?QmlzbmVoT1VXSEN3R0JlazVFVE8yL056cUc4K2tvUENIcmpLL1ZvajRVUDJl?=
 =?utf-8?B?cDhJNGIyZlNuRGtaVTVNM0tDQVNqT0oxSDNjQzNFM1lrc2ZTL0RCZDFtY2dv?=
 =?utf-8?B?R0VXbXB2VzJ0RFV4eHRvUnhtOXRmdWNmbkNzY1pwdHNua0t1TXkyK09jMk5o?=
 =?utf-8?B?ZTdpc3pFOCtZR2RVN0hSL2FNcEhIMGErb0FMbFBEcEhsQysydTFyaTZFWUdq?=
 =?utf-8?B?aTMwTlRzMlFGS25ieEJkU0s0b2RkR2R0R0dYM0VLcW8xTzJzU1ZkV1N4eWFz?=
 =?utf-8?B?eUQ3RmEvNEFEOEc2UzhtZjFNSHl3emVxNWxSQm5McVRMU3pTUW5tditZZEJT?=
 =?utf-8?B?NzlncWxYdWFTZ3IrbFFzZkRsUU1vNUJuY0NnYkowc0szVERwTzRRb1dVWi9y?=
 =?utf-8?B?djU0b0Nyblh4YW4wUXFsd3lOZFc1dUxTUzBCTkVWTXZ3d0hoNWJEUXlINGYw?=
 =?utf-8?B?OTlzeW04NWNKQ0xiQS9oMUZMeHN6bVRDQWU3b2xMUDhmN0xxdGhtNGtSekdu?=
 =?utf-8?B?ejVBR2RuRUJFTWNtU3o5ZU1WYVVwdTJ0aHl3Ky8xMFRhR09UOVlKalp1UEl3?=
 =?utf-8?B?ZktiRFZVSHQvMGNrS3F2SDhwL2FNOWMwcWFpbDJ0ak1STUNZYXZlUFMrN0J6?=
 =?utf-8?B?dnVEeDVPQW9mVTdHRCtvZFZseUNzK01BbXNURkZ1SEliNEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW5xT1lRWnpVZjl6NkQrYW5qc0kwQkZYWlVYMk5FVDB6NENoaENma0ZpVmNz?=
 =?utf-8?B?OGtpYVZtczZ1VFdoZDhBN3hFaWk1Z0Urbmh5UWtMc3FPei9nMjlTUTZqUEVv?=
 =?utf-8?B?bUhkZW9keHYrWWFzMS8zWHFWeG83NVBqcmdEK2x1Q3JsVFJwZjFVZ2NZOHM2?=
 =?utf-8?B?NDY0VWEvNUtvVFYzejFsSFhjaTJNSjY0dGhvdEE0ZENmcy85NHhzZ1ViV2h1?=
 =?utf-8?B?djRhOEdJWkxOOWpUTUhKNU1jb3hFd3NQb0JMYy80WTFzaStCMVV1UkJJdVZj?=
 =?utf-8?B?TmdTb2p4SG9hRE1GVjRxN1VrTFdkakhOUmNSTXI0QjY5bWdyV3lqNjNiRk5q?=
 =?utf-8?B?YzBudUZOTjh3NmJqNFVhOXRjTHNmMTErWGErT09yMFR3YlFkdEhuc25Bejlm?=
 =?utf-8?B?VXJCZ1p4ZHROMlZ6Z0pZOVBueXlka3EwZDJ3MlBRaldkK0dGSDJjcnROOUZp?=
 =?utf-8?B?ekFaS1g4WUpJb2FwbWt4a055Z1pacUsvTUkwVEU0UHVyUk9QOXBRMUhEckZu?=
 =?utf-8?B?Z2dZZ05DemphdHpSOG1GOXg2UjY0YzYydEg3YWdVdkdCR1lDVlRLZjJDSFBa?=
 =?utf-8?B?TURMaE9uelV3UjZ4UW5CaHo5a1dzc1lLSWhHS0cxQVJMNG0ranIra2liSzdj?=
 =?utf-8?B?V1dkZDB6ODlMdEVObGxJZzk1TjdDaEkrMGd1QkpBR3o4ZkgzZnQxR2JjSjB0?=
 =?utf-8?B?VlBoL2ZsV000T2RvVFVONFpaZGxIb2huMThpQTNjS1psWHVjV1hSTEhnbE5P?=
 =?utf-8?B?eGZ4NXdaVEh6ZEx1REdBOXJMMU5UbGhFOUdEVEFMRU0yQnp4TmU1aTJyQ3Ja?=
 =?utf-8?B?dVBma0RsOGFaVks5V3dlTjZtSzY2Z0NDOTZlcUZITkdBeDRMSld5ODlSMkxD?=
 =?utf-8?B?RUtjYytTWU03T0VvZ29PQWZ4TUh6WHFaNVZxYTgwVGc4Nm1lc21pbEZtUnVF?=
 =?utf-8?B?c0xYK0oyTGR4YUpWb3lkWHpCSUQ0TThIbXNKV1d1c2hoMEhyVDlqLzBmYjBL?=
 =?utf-8?B?Ym5RbWJvUmNob05ndE1SaS9sZkwxai9LVGxkUXRoSThCY1lmcHV2OWV3NDBh?=
 =?utf-8?B?cnp3U2VEeUp1Tnp1MFpuS2tLdDhhU1F4WnRGa0VpdVNVVHlOUSt0eUxFV1FO?=
 =?utf-8?B?eUZzQVFObW4yVlNKdmZIQUJHbTJnVnoxYXZFcnprTllFN3VxRjc2UzQ2R1J6?=
 =?utf-8?B?bGhhQTAwRGJYZGRQWkFXblpIb240OFFkSVBEQ1RYL3VNbFdYZ3crV1Q5dnRU?=
 =?utf-8?B?VHlVTUJTMVJZS1FYOEIzbVBaRWREQm82ZmU1VmN1dnJyUUlueG11dnJKR2Jk?=
 =?utf-8?B?OGxCUDFPUHFCRDY3Y1hidkh2TmZOcHpwak11WXBiQUlEUGVMeFFxd2IremFl?=
 =?utf-8?B?eVRsK2JCTVNOSkI4WlR3QXRHY0FrOXVhMFBGWGd4dmp3Y1Jtc3RLb0tvOFgy?=
 =?utf-8?B?SW9xcGNrbzRGM0JtWllEU2w2NzdyZlEvOFZwOVBHbnNZcTlZdFJaQlB6aFBQ?=
 =?utf-8?B?ZVBaOG5hcFZ4ejhmRmdHYkdoYndnaENsa292cGt1S2J6S1I4RHZGeWVGc3hv?=
 =?utf-8?B?ZXkzaGlyNkczRzdIaWRlc3BndU12MXRJM1FWME9tYW9pN3MrOE9LbVVZRjFo?=
 =?utf-8?B?YWxIMVd0Z2pBQllCTUh6TjZCTDYvTWJieW9kSGZPU0tiZVJyTWliL21zNG56?=
 =?utf-8?B?bElYK3pFaHFubnk3THNXSFVpdWNFZjNkYmxMc1hEdlY2N3ZxcDZzeVMxdXNX?=
 =?utf-8?B?UDhnRUJvbytxbVVQQkg5SlBTMkQ3Y2Vod1BDTndSOWdUNElwMWNNc0JCblJa?=
 =?utf-8?B?RTFqTzkvQzBCVEQ3KzhvOW9mdWllaDBwNWVyS09jQkZpVDFZY0o3LzdIVFA4?=
 =?utf-8?B?SVZSdFYrb0t6ajV2MktGVFNPdW1FR0VYTktYb1BSaGR4R3BVMXhUUFhnTXhZ?=
 =?utf-8?B?eDg0RmZMUUdUelY3cTBJdmlLanZuc09iZnZ5Q0JsY0RJRGt0ay9ZM1I2TU1q?=
 =?utf-8?B?QjgyY2x4bmZsdmMyVXFlV0dQellLVkhSdVBlTWxzYTZ3S1JPZkZrNDY1VHVj?=
 =?utf-8?B?dzFDckVVWXR3V3U5TEhiS0M3cFhUckh4QWNEZTg0Q1pIay9OSmZ0c2czSWdR?=
 =?utf-8?Q?mlp4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f9c14-d226-4d71-a0e8-08dd1d8864ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 04:16:20.2469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkRuBVy8qj4BZk/mpAwTCfeHxSJZJNfndesGyRWtL3b1Zkbzh81W+yni7eviKti/Yir08KX70ZDTxxjlk/tXzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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
cmV4QGRlbnguZGU+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMTYsIDIwMjQgNToyMSBBTQ0K
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
S0VEX1BBUkFMTEVMIGlzIGVuYWJsZWQNCj4gDQo+IE9uIDEyLzExLzI0IDE6MDYgUE0sIFZlbmth
dGVzaCBZYWRhdiBBYmJhcmFwdSB3cm90ZToNCj4gPiBVcGRhdGUgdGhlIHNwaV9ub3JfcmVhZCgp
IGZ1bmN0aW9uIG9ubHkgZm9yIHBhcmFsbGVsIGNvbmZpZ3VyYXRpb24NCj4gPiB3aGVuIGNvbmZp
ZyBTUElfU1RBQ0tFRF9QQVJBTExFTCBpcyBlbmFibGVkIGFuZCBrZWVwIHRoZSBkZWZhdWx0IGNv
ZGUNCj4gPiBhcyBpcy4gRm9yIHBhcmFsbGVsIGNvbmZpZ3VyYXRpb25zIGZpeCB0aGUgcmVhZCBp
c3N1ZSBmb3IgNGJ5dGUNCj4gPiBhZGRyZXNzIHdpZHRoIGJ5IHBhc3NpbmcgdGhlIGVudGlyZSBs
ZW5ndGggdG8gdGhlIHJlYWQgZnVuY3Rpb24sIHNwbGl0DQo+ID4gdGhlIG1lbW9yeSBvZiAxNk1C
IHNpemUgYmFua3Mgb25seSB3aGVuIHRoZSBhZGRyZXNzIHdpZHRoIGlzIDNieXRlLg0KPiA+IEFs
c28gdXBkYXRlIHRoZSBzaXplIHdoZW4gdGhlIGNvbmZpZ3VyYXRpb24gaXMgc3RhY2tlZC4NCj4g
Pg0KPiA+IEZpeGVzOiA1ZDQwYjNkMzg0ICgibXRkOiBzcGktbm9yOiBBZGQgcGFyYWxsZWwgYW5k
IHN0YWNrZWQgbWVtb3JpZXMNCj4gPiBzdXBwb3J0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBWZW5r
YXRlc2ggWWFkYXYgQWJiYXJhcHUgPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiA+IC0t
LQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBVcGRhdGUgdGhlIG5vciByZWFkIGZvciBwYXJh
bGxlbCBjb25maWd1cmF0aW9uIGFuZCBmb3Igb3RoZXIgY2FzZQ0KPiA+ICAgIGtlZXAgdGhlIGNv
ZGUgYXMgaXMuDQo+ID4gLSBGaXhlZCB0aGUgY29tbWl0IGRlc2NyaXB0aW9uLg0KPiA+IC0gVGVz
dGVkIHRoZSBjaGFuZ2VzIHdpdGggczI1ZmwxMjhzIGZsYXNoDQo+ID4gWnlucT4gc2YgcHJvYmUg
MCAwIDANCj4gPiBTRjogRGV0ZWN0ZWQgczI1ZmwxMjhzIHdpdGggcGFnZSBzaXplIDI1NiBCeXRl
cywgZXJhc2Ugc2l6ZSA2NCBLaUIsDQo+ID4gdG90YWwgMTYgTWlCDQo+ID4gWnlucT4gdGltZSBz
ZiBlcmFzZSAweDAgMHgxMDAwMDAwO213LmIgMHg4MDAwIGFhYmJjY2RkIDB4MTAwMDAwMDt0aW1l
DQo+ID4gWnlucT4gc2Ygd3JpdGUgMHg4MDAwIDB4MCAweDEwMDAwMDA7bXcuYiAweDgwMDgwMDAg
MHgwIDB4MTAwMDAwMDt0aW1lDQo+ID4gWnlucT4gc2YgcmVhZCAweDgwMDgwMDAgMHgwIDB4MTAw
MDAwMDtjbXAuYiAweDgwMDAgMHg4MDA4MDAwIDB4MTAwMDAwMA0KPiA+IFNGOiAxNjc3NzIxNiBi
eXRlcyBAIDB4MCBFcmFzZWQ6IE9LDQo+ID4NCj4gPiB0aW1lOiAzMi40NjQgc2Vjb25kcw0KPiA+
IGRldmljZSAwIHdob2xlIGNoaXANCj4gPiBTRjogMTY3NzcyMTYgYnl0ZXMgQCAweDAgV3JpdHRl
bjogT0sNCj4gPg0KPiA+IHRpbWU6IDE1LjUxNSBzZWNvbmRzDQo+ID4gZGV2aWNlIDAgd2hvbGUg
Y2hpcA0KPiA+IFNGOiAxNjc3NzIxNiBieXRlcyBAIDB4MCBSZWFkOiBPSw0KPiA+DQo+ID4gdGlt
ZTogMS41NTcgc2Vjb25kcw0KPiA+IFRvdGFsIG9mIDE2Nzc3MjE2IGJ5dGUocykgd2VyZSB0aGUg
c2FtZQ0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItY29yZS5jIHwgNTAg
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDMzIGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWNvcmUuYw0KPiA+IGIvZHJpdmVycy9tdGQvc3BpL3Nw
aS1ub3ItY29yZS5jIGluZGV4IGVjODQxZmIxM2IuLjhkNzA4N2I1YzkgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9tdGQvc3BpL3NwaS1ub3ItY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQv
c3BpL3NwaS1ub3ItY29yZS5jDQo+ID4gQEAgLTExNDAsNyArMTE0MCw3IEBAIHN0YXRpYyBpbnQg
c3BpX25vcl9lcmFzZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgc3RydWN0DQo+IGVyYXNlX2luZm8g
Kmluc3RyKQ0KPiA+ICAgCQkJCW5vci0+c3BpLT5mbGFncyAmPSB+U1BJX1hGRVJfVV9QQUdFOw0K
PiA+ICAgCQl9DQo+ID4gICAjaWZkZWYgQ09ORklHX1NQSV9GTEFTSF9CQVINCj4gPiAtCQlyZXQg
PSB3cml0ZV9iYXIobm9yLCBhZGRyKTsNCj4gPiArCQlyZXQgPSB3cml0ZV9iYXIobm9yLCBvZmZz
ZXQpOw0KPiANCj4gVGhpcyBjaGFuZ2UgaXMgcmVhbGx5IGlub2J2aW91cywgdGhlIGNvZGUgYWJv
dmUgbGlrZWx5IG5lZWRzIHRvIGJlIGNvbXBpbGVkIG91dCBpZiB0aGUNCj4gU1BJX1NUQUNLRURf
UEFSQUxMRUwgc3R1ZmYgaXMgZGlzYWJsZWQgPw0KDQpJbiB0aGUgc3BpX25vcl9lcmFzZSgpIA0K
CW9mZnNldCA9IGFkZHI7DQoJaWYoUEFSQUxMRUwpDQoJCW9mZnNldC89MjsNCglzbyBmb3IgcGFy
YWxsZWwgb3Igc2luZ2xlIGNvbmZpZ3VyYXRpb24gd2UgbmVlZCB0byBwYXNzICJvZmZzZXQiIHRv
IHdyaXRlX2JhcigpDQoJd3JpdGVfYmFyKG5vciwgb2Zmc2V0Iik7DQoNCg0KDQo+IA0KPiAiDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1jb3JlLmMgYi9kcml2ZXJzL210
ZC9zcGkvc3BpLW5vci1jb3JlLmMgaW5kZXgNCj4gOGQ3MDg3YjVjOTUuLjY5MTk2MmVmMjcxIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1jb3JlLmMNCj4gKysrIGIvZHJp
dmVycy9tdGQvc3BpL3NwaS1ub3ItY29yZS5jDQo+IEBAIC0xMTMwLDYgKzExMzAsNyBAQCBzdGF0
aWMgaW50IHNwaV9ub3JfZXJhc2Uoc3RydWN0IG10ZF9pbmZvICptdGQsIHN0cnVjdA0KPiBlcmFz
ZV9pbmZvICppbnN0cikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJhc2VfZXJy
Ow0KPiAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgICBvZmZzZXQgPSBhZGRy
Ow0KPiArICAgICAgICAgICAgICAgaWYgKENPTkZJR19JU19FTkFCTEVEKFNQSV9TVEFDS0VEX1BB
UkFMTEVMKSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKG5vci0+ZmxhZ3MgJiBT
Tk9SX0ZfSEFTX1BBUkFMTEVMKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBv
ZmZzZXQgLz0gMjsNCj4gDQo+IEBAIC0xMTM5LDYgKzExNDAsNyBAQCBzdGF0aWMgaW50IHNwaV9u
b3JfZXJhc2Uoc3RydWN0IG10ZF9pbmZvICptdGQsIHN0cnVjdA0KPiBlcmFzZV9pbmZvICppbnN0
cikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vci0+c3BpLT5mbGFncyAmPSB+U1BJX1hG
RVJfVV9QQUdFOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAg
ICAgfQ0KPiAgICNpZmRlZiBDT05GSUdfU1BJX0ZMQVNIX0JBUg0KPiAgICAgICAgICAgICAgICAg
IHJldCA9IHdyaXRlX2Jhcihub3IsIG9mZnNldCk7DQo+ICAgICAgICAgICAgICAgICAgaWYgKHJl
dCA8IDApDQo+ICINCj4gDQo+ID4gICAJCWlmIChyZXQgPCAwKQ0KPiA+ICAgCQkJZ290byBlcmFz
ZV9lcnI7DQo+ID4gICAjZW5kaWYNCj4gPiBAQCAtMTE1Miw3ICsxMTUyLDcgQEAgc3RhdGljIGlu
dCBzcGlfbm9yX2VyYXNlKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBzdHJ1Y3QNCj4gZXJhc2VfaW5m
byAqaW5zdHIpDQo+ID4gICAJCSAgICAhKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfTk9fT1BfQ0hJUF9F
UkFTRSkpIHsNCj4gPiAgIAkJCXJldCA9IHNwaV9ub3JfZXJhc2VfY2hpcChub3IpOw0KPiA+ICAg
CQl9IGVsc2Ugew0KPiA+IC0JCQlyZXQgPSBzcGlfbm9yX2VyYXNlX3NlY3Rvcihub3IsIGFkZHIp
Ow0KPiA+ICsJCQlyZXQgPSBzcGlfbm9yX2VyYXNlX3NlY3Rvcihub3IsIG9mZnNldCk7DQo+ID4g
ICAJCX0NCj4gPiAgIAkJaWYgKHJldCA8IDApDQo+ID4gICAJCQlnb3RvIGVyYXNlX2VycjsNCj4g
PiBAQCAtMTU3OCw4ICsxNTc4LDggQEAgc3RhdGljIGludCBzcGlfbm9yX3JlYWQoc3RydWN0IG10
ZF9pbmZvICptdGQsIGxvZmZfdCBmcm9tLA0KPiBzaXplX3QgbGVuLA0KPiA+ICAgCXN0cnVjdCBz
cGlfbm9yICpub3IgPSBtdGRfdG9fc3BpX25vcihtdGQpOw0KPiA+ICAgCWludCByZXQ7DQo+ID4g
ICAJbG9mZl90IG9mZnNldCA9IGZyb207DQo+ID4gLQl1MzIgcmVhZF9sZW4gPSAwOw0KPiA+ICAg
CXUzMiByZW1fYmFua19sZW4gPSAwOw0KPiA+ICsJdTMyIHN0YWNrX3NoaWZ0ID0gMDsNCj4gPiAg
IAl1OCBiYW5rOw0KPiA+ICAgCWJvb2wgaXNfb2ZzdF9vZGQgPSBmYWxzZTsNCj4gPg0KPiA+IEBA
IC0xNTkzLDE4ICsxNTkzLDIzIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9yZWFkKHN0cnVjdCBtdGRf
aW5mbyAqbXRkLCBsb2ZmX3QNCj4gZnJvbSwgc2l6ZV90IGxlbiwNCj4gPiAgIAl9DQo+ID4NCj4g
PiAgIAl3aGlsZSAobGVuKSB7DQo+ID4gLQkJYmFuayA9ICh1MzIpZnJvbSAvIFNaXzE2TTsNCj4g
PiAtCQlpZiAobm9yLT5mbGFncyAmIFNOT1JfRl9IQVNfUEFSQUxMRUwpDQo+ID4gLQkJCWJhbmsg
Lz0gMjsNCj4gPiAtDQo+ID4gLQkJcmVtX2JhbmtfbGVuID0gU1pfMTZNICogKGJhbmsgKyAxKTsN
Cj4gPiAtCQlpZiAobm9yLT5mbGFncyAmIFNOT1JfRl9IQVNfUEFSQUxMRUwpDQo+ID4gLQkJCXJl
bV9iYW5rX2xlbiAqPSAyOw0KPiA+IC0JCXJlbV9iYW5rX2xlbiAtPSBmcm9tOw0KPiA+IC0NCj4g
PiArCQlzaXplX3QgcmVhZF9sZW4gPSBsZW47DQo+ID4gICAJCW9mZnNldCA9IGZyb207DQo+ID4N
Cj4gPiArCWlmIChDT05GSUdfSVNfRU5BQkxFRChTUElfU1RBQ0tFRF9QQVJBTExFTCkpIHsNCj4g
PiArCQlpZiAobm9yLT5hZGRyX3dpZHRoID09IDMpIHsNCj4gPiArCQkJYmFuayA9ICh1MzIpZnJv
bSAvIFNaXzE2TTsNCj4gPiArCQkJaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfSEFTX1BBUkFMTEVM
KQ0KPiA+ICsJCQkJYmFuayAvPSAyOw0KPiA+ICsNCj4gPiArCQkJcmVtX2JhbmtfbGVuID0gU1pf
MTZNICogKGJhbmsgKyAxKTsNCj4gPiArCQkJaWYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfSEFTX1BB
UkFMTEVMKQ0KPiA+ICsJCQkJcmVtX2JhbmtfbGVuICo9IDI7DQo+ID4gKwkJCXJlbV9iYW5rX2xl
biAtPSBmcm9tOw0KPiA+ICsJCX0NCj4gPiArDQo+ID4gICAJCWlmIChub3ItPmZsYWdzICYgU05P
Ul9GX0hBU19TVEFDS0VEKSB7DQo+ID4gKwkJCXN0YWNrX3NoaWZ0ID0gMTsNCj4gPiAgIAkJCWlm
IChvZmZzZXQgPj0gKG10ZC0+c2l6ZSAvIDIpKSB7DQo+ID4gICAJCQkJb2Zmc2V0ID0gb2Zmc2V0
IC0gKG10ZC0+c2l6ZSAvIDIpOw0KPiA+ICAgCQkJCW5vci0+c3BpLT5mbGFncyB8PSBTUElfWEZF
Ul9VX1BBR0U7IEBAIC0NCj4gMTYxMywyMCArMTYxOCwzMSBAQA0KPiA+IHN0YXRpYyBpbnQgc3Bp
X25vcl9yZWFkKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3QgZnJvbSwgc2l6ZV90IGxlbiwN
Cj4gPiAgIAkJCX0NCj4gPiAgIAkJfQ0KPiA+DQo+ID4gKwkJaWYgKG5vci0+YWRkcl93aWR0aCA9
PSA0KQ0KPiA+ICsJCQlyZW1fYmFua19sZW4gPSAobXRkLT5zaXplID4+IHN0YWNrX3NoaWZ0KSAt
IG9mZnNldDsNCj4gPiArDQo+ID4gICAJCWlmIChub3ItPmZsYWdzICYgU05PUl9GX0hBU19QQVJB
TExFTCkNCj4gPiAgIAkJCW9mZnNldCAvPSAyOw0KPiA+ICsJfQ0KPiA+DQo+ID4gICAjaWZkZWYg
Q09ORklHX1NQSV9GTEFTSF9CQVINCj4gPiArCQl1MzIgcmVtYWluX2xlbjsNCj4gPiArDQo+ID4g
ICAJCXJldCA9IHdyaXRlX2Jhcihub3IsIG9mZnNldCk7DQo+ID4gICAJCWlmIChyZXQgPCAwKQ0K
PiA+ICAgCQkJcmV0dXJuIGxvZ19yZXQocmV0KTsNCj4gPiAtI2VuZGlmDQo+ID4gLQ0KPiA+IC0J
CWlmIChsZW4gPCByZW1fYmFua19sZW4pDQo+ID4gKwkJcmVtYWluX2xlbiA9IChTWl8xNk0gKiAo
bm9yLT5iYW5rX2N1cnIgKyAxKSkgLSBvZmZzZXQ7DQo+ID4gKwkJaWYgKGxlbiA8IHJlbWFpbl9s
ZW4pDQo+ID4gICAJCQlyZWFkX2xlbiA9IGxlbjsNCj4gPiAgIAkJZWxzZQ0KPiA+IC0JCQlyZWFk
X2xlbiA9IHJlbV9iYW5rX2xlbjsNCj4gPiAtDQo+ID4gKwkJCXJlYWRfbGVuID0gcmVtYWluX2xl
bjsNCj4gPiArI2VuZGlmDQo+ID4gKwkJaWYgKENPTkZJR19JU19FTkFCTEVEKFNQSV9TVEFDS0VE
X1BBUkFMTEVMKSkgew0KPiA+ICsJCQlpZiAobGVuIDwgcmVtX2JhbmtfbGVuKQ0KPiA+ICsJCQkJ
cmVhZF9sZW4gPSBsZW47DQo+ID4gKwkJCWVsc2UNCj4gPiArCQkJCXJlYWRfbGVuID0gcmVtX2Jh
bmtfbGVuOw0KPiA+ICsJCX0NCj4gDQo+IElmIEkgbG9vayBhdCB0aGlzIGNoYW5nZSB3aXRoICdn
aXQgc2hvdyAtdycgLCB0aGUgY2hhbmdlIGxvb2tzIGxpa2UgdGhpczoNCj4gDQo+ICINCj4gICAj
aWZkZWYgQ09ORklHX1NQSV9GTEFTSF9CQVINCj4gKyAgICAgICAgICAgICAgIHUzMiByZW1haW5f
bGVuOw0KPiArDQo+ICAgICAgICAgICAgICAgICAgcmV0ID0gd3JpdGVfYmFyKG5vciwgb2Zmc2V0
KTsNCj4gICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiBsb2dfcmV0KHJldCk7DQo+ICsgICAgICAgICAgICAgICByZW1haW5fbGVu
ID0gKFNaXzE2TSAqIChub3ItPmJhbmtfY3VyciArIDEpKSAtIG9mZnNldDsNCj4gKyAgICAgICAg
ICAgICAgIGlmIChsZW4gPCByZW1haW5fbGVuKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBy
ZWFkX2xlbiA9IGxlbjsNCj4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgcmVhZF9sZW4gPSByZW1haW5fbGVuOw0KPiAgICNlbmRpZg0KPiAtDQo+ICsgICAg
ICAgICAgICAgICBpZiAoQ09ORklHX0lTX0VOQUJMRUQoU1BJX1NUQUNLRURfUEFSQUxMRUwpKSB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAobGVuIDwgcmVtX2JhbmtfbGVuKQ0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWFkX2xlbiA9IGxlbjsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmVhZF9sZW4gPSByZW1fYmFua19sZW47DQo+IC0NCj4gKyAgICAgICAgICAgICAgIH0NCj4g
ICAgICAgICAgICAgICAgICBpZiAocmVhZF9sZW4gPT0gMCkNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRUlPOw0KPiAiDQo+IA0KPiBXaHkgaXMgdGhlcmUgdGhpcyBwYXJ0IG9m
IGNvZGUgdHdpY2Ugbm93LCBpZmRlZmZlZCBvdXQgZGlmZmVyZW50bHkgaW4gZWFjaCBjYXNlID8N
Cj4gDQo+ICINCj4gICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChsZW4gPCByZW1fYmFua19s
ZW4pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlYWRfbGVuID0gbGVuOw0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZWFkX2xlbiA9IHJlbV9iYW5rX2xlbjsgIg0KDQpGb3IgcGFyYWxsZWwvc3Rh
Y2tlZCBjb25maWd1cmF0aW9uIGFuZCBhZGRyZXNzIHdpZHRoIHRoZSAicmVtX2JhbmtfbGVuIiB3
aWxsIHZhcnkgYW5kIGFzIHdlIGRvbid0IHdhbnQgdG8gZGlzdHVyYiB0aGUgZGVmYXVsdCByZWFk
IGZ1bmN0aW9uYWxpdHkgYWRkZWQgdGhlIGlmZGVmIHNlcGFyYXRlbHkuDQoNClRoYW5rcw0KVmVu
a2F0ZXNoDQo=
