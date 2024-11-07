Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11874D5AE60
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 04:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AF5688EE4;
	Thu,  7 Nov 2024 05:58:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3rgCtrji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701EF88F4A; Thu,  7 Nov 2024 05:58:01 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BD588E3C
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 05:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7uu5v+5K/ntpiE5qALSHPsM01qLwS9uk/aSd4m7+ggE5d9LF1vdSU3zRH2VVLWYnbe3lXSOdKixZJ2uNQtrOQ5kNmFcP2Gda1kw3uYvb164oc3YkvBhMRmTgM2LfQ04+M6kFrz8auOkpcb7CdVVQoNjmtNQKSHCZdSBI+tlOzI7mNaFrFz+g6VKR1BTgzMpNFj0cFTfB1VRg171vtNYi9ciau1p0X7iLMmq8sewuVofQmLwCdB1+l5w0f8ORZxVMKOCtcWeGq5xfIO+byW+G6g5gEhJiOJILGcZPyxgpfXjOVrLZB7TdTp3kjiWf9/JLHP6CDkb/kKryGDPbN6MCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30Q4R2WTxuRX1m2kwKr0AIArFK/YP9FJ6nmMHFIst9g=;
 b=pJITCfDXXkq650LnK4sGF2oGrTlZ34DIDxNw4RH5sgQMGPxIEi5f2Cu7Scyc7iys/7K2DkrHa1obgChyXzK9TqOPDbiFdTZmmg5KZmTJTSmdmEJQKeNRj2cubtwvNXfIzIzjf/6yOeBwvFil8OLg2AkLwxoQSOp1X3aV5lF4I+scVCD/U3FrHSENnzOSqRWqaQ2RTI5MfdLr+XOv5tgwwqdIEa4ZcGlD572A/AI7IBpekCzClr+jkXFMFOcBob1zw+yHzGhr54e5IOTGoxkSXEeqlvs3wfi+iEZMuSH7Bd68Cugf5bU4eWDmh8flDcaNqdrnGZkUtab7tuYt2D9KKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30Q4R2WTxuRX1m2kwKr0AIArFK/YP9FJ6nmMHFIst9g=;
 b=3rgCtrjikMMb6yXyFETsiT8KTi182lkS+htN1avTWEUwQuLGBMtb+te8dZXbkOSTVR4BmXZX14XHyKQUjx9imRAC2ktEJ/Wl3kKBhYpXL6p3gh6h0vYRklsqEJ9PgvQfvioXwsKSXsoSrfXzBC9XPHRNAqKlAb+J6mytODldKps=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Thu, 7 Nov
 2024 04:57:54 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 04:57:13 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, 
 "sjg@chromium.org" <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH] cadence_qspi: Refactor the flash reset functionality
Thread-Topic: [PATCH] cadence_qspi: Refactor the flash reset functionality
Thread-Index: AQHbKRtSKLAqoNgKt0mP+/DhSVtmDrKqMP+AgAEfRJA=
Date: Thu, 7 Nov 2024 04:57:10 +0000
Message-ID: <SA1PR12MB869780A320010907ACB78979985C2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241028092430.19841-1-venkatesh.abbarapu@amd.com>
 <f52cea21-8171-4fa3-9fb6-b8e54344fd0d@amd.com>
In-Reply-To: <f52cea21-8171-4fa3-9fb6-b8e54344fd0d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|CY8PR12MB7585:EE_
x-ms-office365-filtering-correlation-id: ccf0b179-85aa-47e3-23bb-08dcfee8a31a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RjNnR2ppNjZmaDFTcnhMOURNTFJvSkgxZitrVGljdkd4YmZxdnJhVEphNTZP?=
 =?utf-8?B?NDMvdkVtRkRlUitEbzg2OVQzUXVxYlMyd0xuWEpENVM3dGFoWkduajhxUlpP?=
 =?utf-8?B?WW03QWNuWmx4eGl2MUZZVW5EdHpxUFpqNzZFNlJVa2NidDJ6UTZOV2RCRHBY?=
 =?utf-8?B?eUd5dWlXUFd6VkRyVU1yckRIYXVMWkNBQ1RoZXQyZW9VVEtzOExtYWt5RnBO?=
 =?utf-8?B?aktubldNQ2FBdmNqa3pSNHg2eFpSWmFienl1UE8vd1dlSjZRUE41b1pyTmhQ?=
 =?utf-8?B?aWZ0eUtIM2lzSzFHdUhUMHZUZXJ2U3M3WExFMHFBY0UvbThDWWEwNzU2N2dZ?=
 =?utf-8?B?TDM2ZHgvWXkxVVd3OG9Da0IrS2RuenA4SU9hNDI5MDVBMVpySXFzNVdyWnRs?=
 =?utf-8?B?Wlh2MlhpekhMUkhrTmViZjV1OWJNOERKbFR4L1dSZWtldjF1dk9KZXhiOTVU?=
 =?utf-8?B?a21PVkdSeDhjUm0xcisyNnBBT2JlN1dKanFveEIwUDBWU05XRnI2VXczcHI2?=
 =?utf-8?B?K3VtKzJpM2pXaFZ6b21tbVBXNHFOT3dqNHVZSHBtTGFLcnlCSHNubHdHV3lN?=
 =?utf-8?B?Y3lFMDZIQXpsVGdBRzRhdi9LYXVPNlNjSFlNZDR3SklHeWs0M3RraDZSZUZ5?=
 =?utf-8?B?c1kwZnhMdkFCQ2drdkF5MlJHQzBXZVljazg5Rll1cW9WbXVIekJyRXErYnhq?=
 =?utf-8?B?cHIrbi9FaFdHQldFNDdJaWV2aG1BbDZPU3lKZWhPZDU1VjlEM09NTi9rSXln?=
 =?utf-8?B?NGwxQVZEc0llZGdNRTdmcm1OK0pwd0dMYmw1VXl2MjlUZWk0R0ZrdERFTjVQ?=
 =?utf-8?B?Z3JFSk5nbGtqWnZHOS9XWHRFQmJhbGo4NmtOM0JPR2dDTzlLOFdGQTRWSTRa?=
 =?utf-8?B?VjZ3RENBNzg2NFYwTHFVR2Yxc0o0aUpySk9UbVRoMmFhWTh6bjdiZEF1dzZs?=
 =?utf-8?B?Sk4yUU1XVGlldTFkNGhyQmRpMjViUzNDbzROVmFnMXRhZmJrZFhsb01Zc1Yw?=
 =?utf-8?B?a1hhWjlzNHU3MDdCTkM5UjgzQ0NjT3VNOFRsWnB5Mm5mQ0dESTV6TFBxdkJ6?=
 =?utf-8?B?VVJMYVcrcXhHN1JiK3djZ1dzc0VCUlF4VUZGSDlpcUYwS21Md3l0TG5MQVFp?=
 =?utf-8?B?b2Y5SzRrYzBrRW1Qb3M3MU04Y0NuN3BFYjJ4cUZNeTc2dGJqanU5bldCbGVN?=
 =?utf-8?B?cm5pSlNPU2xlSVd3ZVhaZlhqUVUrdTdhdHRJMmtKOFhSTytWNGFCQm1DNHZz?=
 =?utf-8?B?RXVBdFhPdmM3UU5IWUI0d05BOTI4ZDB5SUFGK3F3em0waU5YUThNK21raUhQ?=
 =?utf-8?B?YTNFbzQvaWo4MlhLU1BGZHhRWVJkY3Z4WlBLNmd5d1I3NUNLTXcrUDhGR2tT?=
 =?utf-8?B?N1hDVzFMQW9zTnpnL2c5QUczVnN1YU1qNjNhYWR5cXRZL2VxQ0ZaMlMvUjJK?=
 =?utf-8?B?a0doRXpjanJFTnJjQ3Y1bkRyVGpmbkdDeW9COTlZUE5LR2JTdXNZdGlRNkNa?=
 =?utf-8?B?cGdESzhndlM4RG1uNWZUdkxkZStDd24rZ3hWRE5DZ25rL3p1aEtPZktpQVY3?=
 =?utf-8?B?YmQ1eVJKNTJEVDR4V2lVY2JVOEJLajRXU3hJQ0RTRmpYa3NjRTdVTGF1ZlVK?=
 =?utf-8?B?a3lTeWU0cTJ5czZzK053M3UrUGRvOXZWN215bVo4em5zZGs2SFZEcU5yTTIw?=
 =?utf-8?B?NUd2eWZUVHJBSktQTTF5YnBmdWpGRXlvdDNQZm11NUt4YitQTDBhV0YvQTFZ?=
 =?utf-8?B?L05XZ1JPbVZ0eEwvR0taOExxM2pobnJBVEpFd09UL0xuQ2pNMEhMUjBCZGI2?=
 =?utf-8?Q?kDuI7/ZkWkr8HyEhV18eAPKPMcVhbG+RPf8Zg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0NwaXpvUFRSSW5tZjF4NU8vc1lndjNYVHFqTDcyWDUrOVo2RW1jb0V1M1Vl?=
 =?utf-8?B?bjdBbTN6MzZoNUdGbFRTQitwSzlrcjhMcWpCL25pRFgvRklvL1ZlVWRKODZF?=
 =?utf-8?B?NlBSZ2NTRnlnYUpQZ0hQWUtnK3NRVk1kdkhkem8vRFB1anhzUHYyUXF2dW0z?=
 =?utf-8?B?dHZ0QUh0UXdQUjFZTTNzMTc5YWZKWThJdkxodXhMek54SmNQWlpWVmw5dU16?=
 =?utf-8?B?TUw4M0FQUWFWQzExZnpmVXdsUXZjQUdjVkpTcGllZFozMVQ0U3V4REpPd1VP?=
 =?utf-8?B?emVqdy9La29pQ2wrUkRNQk5URGN3RG0vZzZTa2FzL29SUDcvaUZybG5QSFdZ?=
 =?utf-8?B?U083cytxVUVSS2VnYWt6QmpCV2x1bzRDd2tDN09LZVQ4MmkrZVJsemZWbGM1?=
 =?utf-8?B?MGJ6bCsyWHRtVm84cVNYYnlyYnRQamlzWkFGenhmbVVwcy9HNGhyUVVTaXFj?=
 =?utf-8?B?NGlYcjJMN3p6cHBKTWFONExQb1N5SXlzaWhaNjBsVTF6bUJsMStCeWR6Rnp1?=
 =?utf-8?B?N2hCeXhNUlpBUXBIUGVrWmxpMW9BanVyK0I5Q1paOEJVeGVDRWZsTFZlVHVj?=
 =?utf-8?B?REJEd3FRNVhFVFhIdWVzSG1yVnpBOFhLM01qdGdTb0ZUTGRIQUFWZG93dXlB?=
 =?utf-8?B?L1g3NlBNUGF0dXhQY0FUcVhYcjhYRlNYYTJTaW5YV1FVMHVWQU56SjNTSUhE?=
 =?utf-8?B?ejlXb01HSmlCL3ExMzA4Z2F3a0xJWllDY2VyK2FyUk83RWlhRTY1ZmZvcU5R?=
 =?utf-8?B?UVgxTC9FdDZ4dk9pY2hTQXlMRVZjZ3NUVVA1YWh2cmM3cnFCQTBCUkhab2hY?=
 =?utf-8?B?TmVteEk5ZXZ5RFNibXNkbUt2Z2VLU0hhaUQ3bEhsVzJuU0ZQd1c2SjJBc0Jy?=
 =?utf-8?B?N2k5cG4xalVwcit1SFlncWFxWFNMK0o4aG11OVl3NGxpaFU3YkdJZENlRzFY?=
 =?utf-8?B?NnVBZnhTd3lQRjhnWHZWOXovdVpMUEFKUVoyOUJRcEtBdUhmRUhoR0x5WVBr?=
 =?utf-8?B?S0pEVklVYWZBa1NXcVlHaVoyZTI0b1pnc3B4SHMrZ08wazVCVWp6cUhreGNa?=
 =?utf-8?B?dTR1UXlHSGZ2MStpS294VlpXbUduNUlJTXFpY1o1MXNsQ1BIcnVpWFVIeUh2?=
 =?utf-8?B?TVYxVU1kWHZGU29uMmUzcTh3VzFKWXkzZjRMaCtwYUtaWS9TU1g4d210RjJO?=
 =?utf-8?B?TmxuN2podWFGQ2RRS1lQbnhLRjgrVFFYU3VxT01YNjhFd0krbGhkMXFxNWQ4?=
 =?utf-8?B?VloxdVZDd0dkODRob3JGOGNoSTFydk1GTlV2dXR6YlM2WkVqSTREZ09mT1V5?=
 =?utf-8?B?b0V2eElOalN3cTRFWmRaYzg0eWJnaDBKdDd4OGc5OFU0N1gwUVVUQWxvRTU5?=
 =?utf-8?B?MnJ5cTZjbXpkcGs3eXE4b0VOTkw1R2pMc3BhQXhwak40NldzUTNMU1B2UkVG?=
 =?utf-8?B?d0RKcDY4WHo0MUZPT0VtcnRsK1RTMkxMZXU5cytqWlArN1F5d1pIRit3Nm1J?=
 =?utf-8?B?aW53VnRUUW4xOHpDR05JUHlMcjJFRTBBWnF3Y1ZPNG1TK0JMNzh3WU54T1Uw?=
 =?utf-8?B?MUIvM3pLcWhoUTA3N2ZySXh6VmlBTnlVNFJWeVJTMFJkMFFtQ1hsS1ZqVEth?=
 =?utf-8?B?WlNmeEFXMzR2RGo1dXlxZlVmZi82OG1nTEh3NmFPb0QvVTBHWWt3cjNNWlNY?=
 =?utf-8?B?ZUc4eXA3VXA0emlNbTJDZGM1R2tqVXBIc25OVUZwRkpwK1IyQzV1UG9OV1RU?=
 =?utf-8?B?SkRDdmQwb3ZRcHIxZE5OZGhQaDcxVWhlL2cxejVwMklBY0E3dmRLWVBFZlhS?=
 =?utf-8?B?K3NtdkJHYVpXc1I5cGxxVzZqY3g3Z1Q3cWVsWHlVMU8rdjloY3hicFlLQ0Fa?=
 =?utf-8?B?Wm1teVROYW1hcng0R2kyV0drb1BpZGgxcDVuNHlIVFdEaVVmK2pSaHIwdzRz?=
 =?utf-8?B?dXg0SG8xeWdROTBYa0paSS9kTjVJZ3hCbUpFNk9CTkJEcjQ2SU1MSGRrTnNz?=
 =?utf-8?B?MHVOTUtoOXNzSTg1cDYxeGdDUzBubnBkWUhESW5qZGpSSFppWmxRVGZLS0Nk?=
 =?utf-8?B?T0owcExzc1ZpNDJzUktna2RDM0IzT0ZnRkg5WmNMb3FDMzFSUXdmalpOdkk0?=
 =?utf-8?Q?FzsY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf0b179-85aa-47e3-23bb-08dcfee8a31a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 04:57:10.1912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fgzj1fQjZboIYVaYeKz6W885TeOx7Odvbmie5TuLolhdLzYUUZo6XPWy7St4gFqYM/hI2WBQsI6dYpN3YjPlxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE5vdmVt
YmVyIDYsIDIwMjQgNToxNyBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNo
LmFiYmFyYXB1QGFtZC5jb20+OyB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogamFnYW5AYW1h
cnVsYXNvbHV0aW9ucy5jb207IHZpZ25lc2hyQHRpLmNvbTsgdS1rdW1hcjFAdGkuY29tOw0KPiB0
cmluaUBrb25zdWxrby5jb207IHNlYW5nYTJAZ21haWwuY29tOyBjYWxlYi5jb25ub2xseUBsaW5h
cm8ub3JnOw0KPiBzamdAY2hyb21pdW0ub3JnOyB3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTsg
c3RlZmFuX2JAcG9zdGVvLm5ldDsgZ2l0IChBTUQtDQo+IFhpbGlueCkgPGdpdEBhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjYWRlbmNlX3FzcGk6IFJlZmFjdG9yIHRoZSBmbGFzaCBy
ZXNldCBmdW5jdGlvbmFsaXR5DQo+IA0KPiANCj4gDQo+IE9uIDEwLzI4LzI0IDEwOjI0LCBWZW5r
YXRlc2ggWWFkYXYgQWJiYXJhcHUgd3JvdGU6DQo+ID4gQXMgdGhlIGZsYXNoIHJlc2V0IGlzIGhh
bmRsZWQgaW4gc3BpIG5vciBjb3JlLCByZW1vdmluZyB0aGUgZmxhc2gNCj4gPiByZXNldCBmdW5j
dGlvbmFsaXR5LiBBcyB0aGUgY29uZmlndXJhdGlvbiBsaWtlIHRyaXN0YXRlIGFuZCBoeXN0ZXJp
c2lzDQo+ID4gbmVlZCB0byBiZSBlbmFibGVkIGJ5IHRoZSBjZG8uIEhhbmRsZSB0aGUgZmxhc2gg
cmVzZXQgb25seSBmb3IgbWluaQ0KPiA+IHUtYm9vdCBjYXNlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1kLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc3BpL2NhZGVuY2Vfb3NwaV92ZXJzYWwuYyB8IDQz
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIGRyaXZlcnMvc3BpL2NhZGVu
Y2VfcXNwaS5jICAgICAgICB8ICA3ICsrKy0tDQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zcGkvY2FkZW5jZV9vc3BpX3ZlcnNhbC5jDQo+ID4gYi9kcml2ZXJzL3NwaS9jYWRlbmNlX29z
cGlfdmVyc2FsLmMNCj4gPiBpbmRleCAyMjJmODI4ZjU0Li5kZTUxZTRjMzdmIDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvc3BpL2NhZGVuY2Vfb3NwaV92ZXJzYWwuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvc3BpL2NhZGVuY2Vfb3NwaV92ZXJzYWwuYw0KPiA+IEBAIC0xMjUsNDggKzEyNSw2IEBAIGlu
dCBjYWRlbmNlX3FzcGlfYXBiX3dhaXRfZm9yX2RtYV9jbXBsdChzdHJ1Y3QNCj4gY2FkZW5jZV9z
cGlfcHJpdiAqcHJpdikNCj4gPiAgIAlyZXR1cm4gMDsNCj4gPiAgIH0NCj4gPg0KPiA+IC0jaWYg
ZGVmaW5lZChDT05GSUdfRE1fR1BJTykNCj4gPiAtaW50IGNhZGVuY2VfcXNwaV92ZXJzYWxfZmxh
c2hfcmVzZXQoc3RydWN0IHVkZXZpY2UgKmRldikgLXsNCj4gPiAtCXN0cnVjdCBncGlvX2Rlc2Mg
Z3BpbzsNCj4gPiAtCXUzMiByZXNldF9ncGlvOw0KPiA+IC0JaW50IHJldDsNCj4gPiAtDQo+ID4g
LQkvKiByZXF1ZXN0IGdwaW8gYW5kIHNldCBkaXJlY3Rpb24gYXMgb3V0cHV0IHNldCB0byAxICov
DQo+ID4gLQlyZXQgPSBncGlvX3JlcXVlc3RfYnlfbmFtZShkZXYsICJyZXNldC1ncGlvcyIsIDAs
ICZncGlvLA0KPiA+IC0JCQkJICAgR1BJT0RfSVNfT1VUIHwgR1BJT0RfSVNfT1VUX0FDVElWRSk7
DQo+ID4gLQlpZiAocmV0KSB7DQo+ID4gLQkJcHJpbnRmKCIlczogdW5hYmxlIHRvIHJlc2V0IG9z
cGkgZmxhc2ggZGV2aWNlIiwgX19mdW5jX18pOw0KPiA+IC0JCXJldHVybiByZXQ7DQo+ID4gLQl9
DQo+ID4gLQ0KPiA+IC0JcmVzZXRfZ3BpbyA9IFBNSU9fTk9ERV9JRF9CQVNFICsgZ3Bpby5vZmZz
ZXQ7DQo+ID4gLQ0KPiA+IC0JLyogUmVxdWVzdCBmb3IgcGluICovDQo+ID4gLQl4aWxpbnhfcG1f
cmVxdWVzdChQTV9QSU5DVFJMX1JFUVVFU1QsIHJlc2V0X2dwaW8sIDAsIDAsIDAsIE5VTEwpOw0K
PiA+IC0NCj4gPiAtCS8qIEVuYWJsZSBoeXN0ZXJlc2lzIGluIGNtb3MgcmVjZWl2ZXIgKi8NCj4g
PiAtCXhpbGlueF9wbV9yZXF1ZXN0KFBNX1BJTkNUUkxfQ09ORklHX1BBUkFNX1NFVCwgcmVzZXRf
Z3BpbywNCj4gPiAtCQkJICBQTV9QSU5DVFJMX0NPTkZJR19TQ0hNSVRUX0NNT1MsDQo+ID4gLQkJ
CSAgUE1fUElOQ1RSTF9JTlBVVF9UWVBFX1NDSE1JVFQsIDAsIE5VTEwpOw0KPiA+IC0NCj4gPiAt
CS8qIERpc2FibGUgVHJpLXN0YXRlICovDQo+ID4gLQl4aWxpbnhfcG1fcmVxdWVzdChQTV9QSU5D
VFJMX0NPTkZJR19QQVJBTV9TRVQsIHJlc2V0X2dwaW8sDQo+ID4gLQkJCSAgUE1fUElOQ1RSTF9D
T05GSUdfVFJJX1NUQVRFLA0KPiA+IC0JCQkgIFBNX1BJTkNUUkxfVFJJX1NUQVRFX0RJU0FCTEUs
IDAsIE5VTEwpOw0KPiA+IC0JdWRlbGF5KDEpOw0KPiA+IC0NCj4gPiAtCS8qIFNldCB2YWx1ZSAw
IHRvIHBpbiAqLw0KPiA+IC0JZG1fZ3Bpb19zZXRfdmFsdWUoJmdwaW8sIDApOw0KPiA+IC0JdWRl
bGF5KDEpOw0KPiA+IC0NCj4gPiAtCS8qIFNldCB2YWx1ZSAxIHRvIHBpbiAqLw0KPiA+IC0JZG1f
Z3Bpb19zZXRfdmFsdWUoJmdwaW8sIDEpOw0KPiA+IC0JdWRlbGF5KDEpOw0KPiA+IC0NCj4gPiAt
CXJldHVybiAwOw0KPiA+IC19DQo+ID4gLSNlbHNlDQo+ID4gICBpbnQgY2FkZW5jZV9xc3BpX3Zl
cnNhbF9mbGFzaF9yZXNldChzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPiA+ICAgew0KPiA+ICAgCS8q
IENSUCBXUFJPVCAqLw0KPiA+IEBAIC0yMDksNyArMTY3LDYgQEAgaW50IGNhZGVuY2VfcXNwaV92
ZXJzYWxfZmxhc2hfcmVzZXQoc3RydWN0IHVkZXZpY2UNCj4gPiAqZGV2KQ0KPiA+DQo+ID4gICAJ
cmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gLSNlbmRpZg0KPiA+DQo+ID4gICB2b2lkIGNhZGVuY2Vf
cXNwaV9hcGJfZW5hYmxlX2xpbmVhcl9tb2RlKGJvb2wgZW5hYmxlKQ0KPiA+ICAgew0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9jYWRlbmNlX3FzcGkuYyBiL2RyaXZlcnMvc3BpL2NhZGVu
Y2VfcXNwaS5jDQo+ID4gaW5kZXggOWM0NjZmODY5NS4uZjhjM2ZlODQyOCAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3NwaS9jYWRlbmNlX3FzcGkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc3BpL2Nh
ZGVuY2VfcXNwaS5jDQo+ID4gQEAgLTI1OCw4ICsyNTgsMTEgQEAgc3RhdGljIGludCBjYWRlbmNl
X3NwaV9wcm9iZShzdHJ1Y3QgdWRldmljZSAqYnVzKQ0KPiA+ICAgCQlpZiAocHJpdi0+cmVhZF9k
ZWxheSA+PSAwKQ0KPiA+ICAgCQkJcHJpdi0+cmVhZF9kZWxheSA9IC0xOw0KPiA+DQo+ID4gLQkv
KiBSZXNldCBvc3BpIGZsYXNoIGRldmljZSAqLw0KPiA+IC0JcmV0dXJuIGNhZGVuY2VfcXNwaV92
ZXJzYWxfZmxhc2hfcmVzZXQoYnVzKTsNCj4gPiArCWlmICghQ09ORklHX0lTX0VOQUJMRUQoRE1f
R1BJTykpDQo+IA0KPiBJIHRoaW5rIHRoaXMgaXMgbm90IHRoZSByaWdodCB0aGluZyB0byBkbyBo
ZXJlLg0KPiBCZWNhdXNlIHRoZXJlIGNvdWxkIGJlIGJvYXJkcyB3aGljaCByZXF1aXJlcyB0byBk
byBzb21lIG90aGVyIEdQSU8gaGFuZGxpbmcgb3V0DQo+IG9mIHNwaSBjb3JlLiBJIHRoaW5rIHRo
aXMgcGF0Y2ggaXMgaW50cm9kdWNpbmcgbGltaXRhdGlvbiBmb3Igbm90aGluZy4NCj4gDQo+IEkg
d291bGQga2VlcCBvcmlnaW4gY29kZSBhbmQganVzdCBtb3ZlIHRoaXMgY29uZGl0aW9uIHRvDQo+
IGRyaXZlcnMvc3BpL2NhZGVuY2Vfb3NwaV92ZXJzYWwuYw0KDQpUaGlzIGZ1bmN0aW9uIGNhZGVu
Y2VfcXNwaV92ZXJzYWxfZmxhc2hfcmVzZXQoKSBpcyBzcGVjaWZpYyB0byBBTUQgb25seS4NCg0K
VGhhbmtzDQpWZW5rYXRlc2gNCg0KPiANCj4gTQ0K
