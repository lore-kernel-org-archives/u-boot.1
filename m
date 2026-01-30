Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E1D73E86
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E14584131;
	Fri, 30 Jan 2026 03:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BI4vLlLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BF584158; Fri, 30 Jan 2026 03:00:25 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 004CD840BE
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9gAqJ6fpWQoDa3b61aoFD5cMqVYL/+5gdcq5WUDZjcepWP2LZ0hpLyVf7EUIhaQTfvpnnfjF+pFl6bcnWi7uUwSgcPjoOLwR7nAjuCUET/w5kZF4Jz35oNZMdy06WECaeQkF+TbSqhaZ+LXrNm4zuEBqHuV9Nl1rFsUAXtsbxKoAEMfBBx0laYCwtZ2ZJJ2zzqp6oVekcfYVUtywLmRBCbJdN6I2MTiQkgOcJhxihY9Ha8Bu8O4UgAbx08JZbNvlojeOa4ARuajbfVgvrSonqKa7wIFsQMcTfnINZIb3sm3rkF0Mapd4zvWZ+ktfnvWpuMeGVM5TRoVvSYp18dxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzry6Wn1hjH5RMCk/ORUNfYRmvY4EF1NKpkNNtnUVkI=;
 b=mbMtheRQKhBC6YEIm8elIfsdR8WvCI5vmgh/1zQt2LlOA1Yb+//UvEmrGnIuhJpDrwAQlcUPMUlc6EgktSL1bitPOsNbOlQrusPo6/fLDD3VB3BsJD4jQ9cDT0aWPob1+rPlTYU4vw9K+GeMST120MJVMFEO3FWXwP/u1Bnb4oSF5Dj7y+DSVMWyBM7xkZhcPQ+8/+oIYqhjtS17y2Te9aCV1KXjyO+cxUDH6Od9bFIbqz7e4QVHZOofIMRbdrOGXDKnqz122bZJhgIX4CsfMghuIZFmm/5MICWtzy9ExbCE7Y9Rq8RVNGP3/acLKJtYLr2dVFBNpWvMQmJWAUyYig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzry6Wn1hjH5RMCk/ORUNfYRmvY4EF1NKpkNNtnUVkI=;
 b=BI4vLlLTId9G/O3+u/PetNOFUe3RusaQrMKonLvoFESQ871p3qbp7xfoQoxkFaiUqDbTcaNkw4F9E0gM4plrg2aLRYtbC1Q4u6ZcgfaAyQtRxGlshJ/quDnDtzCHu6MEb+wwXLDEnkK50NoOQcDAmRN6OvhWW4dXJUxBrI7Z744SR0Zt6b6IViTgITQKqrwk0YI+VPP+1h1C+jKAyU/LCAYPN5XyNdn/2lCEcittEcDei1IaJof2vw6l76pfy2R67QOU1OEy6nSv3GjBS5iU++qSfa6xO/68/i4lly2eGxVyv5EfjGGju/q0T8fUUFhOta0EFT8yXpT9EMw3kyq5rQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB12125.eurprd04.prod.outlook.com (2603:10a6:150:316::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 02:00:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 02:00:20 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Ye Li
 <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: RE: [PATCH 3/4] arm: dts: imx95: Add cm7 node
Thread-Topic: [PATCH 3/4] arm: dts: imx95: Add cm7 node
Thread-Index: AQHckP8ehhMOmryJAUSUYbjm0KHUc7Vo7FqAgAEJFYA=
Date: Fri, 30 Jan 2026 02:00:20 +0000
Message-ID: <PAXPR04MB845906524AE6EC3CD1F8298A889FA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
 <20260129-imx95-rproc-v1-3-035b2dbf3e57@nxp.com>
 <CAOMZO5A0WEQTwCFOUS=Q7Re5=CPYgNMdX2LcJxM7D9NbOdB_Rw@mail.gmail.com>
In-Reply-To: <CAOMZO5A0WEQTwCFOUS=Q7Re5=CPYgNMdX2LcJxM7D9NbOdB_Rw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB12125:EE_
x-ms-office365-filtering-correlation-id: 33b9a8d5-f2e7-4618-6f1f-08de5fa35297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NG5qbkJRTEdreklTb1FlaVFzcDFBeVYvZ0l5U2E2T1FBdllVWXA2eTJHdnRR?=
 =?utf-8?B?SVZodlh0WHBhOURiN3lWY25pUy9FOEUrdjV6eGpWQnJyMjJIMmkxL1V1ZE5Q?=
 =?utf-8?B?emRiWDVaYnlHbjBBRkxoaTFkZ3lVa2tKdStjUHc1am1RRG1RalN5d25kRmlm?=
 =?utf-8?B?a2pjOEg3ZjNrMkJad2cwWUwzQ0EzOCtWcy9FZWo0eC9GN3lRcWhlVE9BTXNy?=
 =?utf-8?B?Zm9RbGhQWHkyZHVYUkNDcEFtYk4vSXFHcTQwYVpKVHdSZW5BNGZSMVZSVVlY?=
 =?utf-8?B?d1V5WERJRFBVeXo0cUo3czRJSHVkditsR0p5NW96TnRLYlk4R0wwTCtsNERi?=
 =?utf-8?B?RStpalNvY1h6b2JZUUVNMGFCL1EzQm5nSjRPMlRBV296QUdoYXh3Y0NwQ2VZ?=
 =?utf-8?B?eCtCUjVsTUNQM3VIRHl5NmtTRXdEWkI5ZXFPM1dzZHhReTlKTThMdmhsMXRp?=
 =?utf-8?B?UG9CamJoTGUvbXNLVHljcXlqdWo4ZTcrNFJacEhIdnhPa2VNbzhQVVhqZWtq?=
 =?utf-8?B?UUh1NzR6Y3d5N00wczN4UDNpMGtJUEhZT3pnS3d1dHFOZWpjYll3cVR2dlhp?=
 =?utf-8?B?ZGp2RnloMGVwVlQ3eUc3bXRFMzF3OW5qcTVpamtFb0xJc1pDeXB3Rlo1UnhT?=
 =?utf-8?B?L0crWDZpQjZqWk55QlJuais2OGhKWjErSmZHME41OUU2K09yT0dlcmZzSWxs?=
 =?utf-8?B?QVdvTTd5WVpoSnV3TGxUUTB5WVF2R2ZqWjdFWWxQem93Z3NwL3U2OTNVNkV6?=
 =?utf-8?B?ZFFvK2tRdm5EZ1FTek5WZnhrWUNMc0dXZ25xUSt0UWpmRFFmYS9VMVpSSGx5?=
 =?utf-8?B?QnozSU0vVWRpS0drVzI3QnlKbVVxT2RNN2xZWklLU2pRMGFKUmJrRlRkZHdZ?=
 =?utf-8?B?bUlCb2o2RG4rU0JydXowZk0xZ2xxQSttc3BsaFZQRzhRTm1hNkpiNnhOM3RE?=
 =?utf-8?B?UUgvSlVTakgvR0VuanYvSmI1YWRWRHpObVIweFFLRzd2S25VaUtMcHdGUmdt?=
 =?utf-8?B?ZTJJdFk0S080MXRFTlZGOVU1TjdSTGdxVUtBZUh6UnZRV253OXVWM1A4VnNa?=
 =?utf-8?B?WEJmWUErMnhjM240b3Y0QkNsOGhDUitJZWFXbUtIalYrL29BaEhBUWlRQ25M?=
 =?utf-8?B?QUd2QkhkUkJLRFluc3RESUtGUzVnaWMxbmQ2Nnp0ejdNMXo0d1hoV1BKSTFC?=
 =?utf-8?B?UmowbXpPc2NHcFF0YW1lR294NTZFUVc5UDMyYjNra1ZUdDJHYWdtZVdPUU1L?=
 =?utf-8?B?WjF5dURnZnNBdVVGb3hUV3pYV2dXZ3BvNWQ5T1I1NVpOQ3ZBeVRLRkdSVDZo?=
 =?utf-8?B?V3FxQW9PQk9yQWpkL3R1N3h5K0h6allwYXNjQkdIcFcxMGp2ZlRYQUptVU4y?=
 =?utf-8?B?WlU1NWpLSG1QNGpUc3ZybE1ONUtFMS9ML21JUkl2MWdlaHpZakRwVUFCYnA2?=
 =?utf-8?B?Z3Y4TkYxYzI1VEVVbDNsMGpISklEM1BlMmg3bWYveGN5TEJHSWlXWnBlSExE?=
 =?utf-8?B?UWpyVFh2NGhybWRmOVNXQ1U3R2R2OWY5N0hveFFwdVFsdkpHVXE3VjNnVm9t?=
 =?utf-8?B?amtZUjhUVzhKWEhhS2YxZ1l3MFgzY0tDL1NmTGkvNnJNOFFqSFRQSVhKYXg5?=
 =?utf-8?B?UVlaajRXekN4UnNReWRpSHJSbERZelo3b1hvRkNrWUs1cEVRaEppcHdTaHVJ?=
 =?utf-8?B?SFdvemtaMENLRjQ4Z2Njem8vWHh4V3R0dFFHTnhZWUlHOGRmaGNCR21QVmQ3?=
 =?utf-8?B?MkFTUERBL1krNEtMNzFDTXZqSGxGTmlTUmpzclJ6WCtLSllBTTFNTlBHSThv?=
 =?utf-8?B?MU5EdDlwVFN0VUEzRml1WUFVZXArdlJRMzRPN1J3YW5rMThFODlTSmF6d3F5?=
 =?utf-8?B?Z2pBZEpaNXduNVN6YTJ2UTNrNG44YVFSMFNZbzZYVHdGejMreWd3TWhBVFk5?=
 =?utf-8?B?VGI2ejZiRWhxZnBWUUNybEdoSkFvNGEwQmJ2QmxIK28vditZTzRpbm9xU2V3?=
 =?utf-8?B?MnBFdWJpQUx0alBHZUsxMXRablpjQWxFdXNUa2g2WnpZdDNxbm5XUExDWHVv?=
 =?utf-8?B?QnlRZGErMzFXY3l5R3dHOFJ4WHo2ZjZ2NHNYZVpFR1NVdDV4OWU1anBGMDlI?=
 =?utf-8?B?YnB2NnNpYVV2ZENOQU0vLzZPUm91alY1OEJyYUdpdHE1dkk2TWtmM1RjVUdz?=
 =?utf-8?Q?OehcvtxnjEEYs74OFuXvHfk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zmo3Y0JjQXQ2Q3VDS3VINXM5MndqdlRnNDIzcXVJZUV6RjlXTzVKZzVyNVh4?=
 =?utf-8?B?Tk1aYXZ5am1vZXpSc243bnJYQ01yZFVOR2FXTU9RcHNZNjZ3SzdpeGhKUzVu?=
 =?utf-8?B?TE1GcjdmT0NtaUgvdmsvci9EV0paeWZqMnJ5eXRxTmdFSjNQYUFWM3RFRGtW?=
 =?utf-8?B?Y3l1dnFKTm14TytDbzhvVkRDMFBoZjFlM0M1dUpJdnk4N2lkSGFySWNicTVO?=
 =?utf-8?B?aGlkcTdyREx0aERIMW81MFdwN2FzOUE2bTJJWitjM2oxemZSSEJvZDJmRWdR?=
 =?utf-8?B?VmtsUTFqVG8zRzFwdmJpdmlHOCszNXJ5TFJiZlY4ZDhDdE8wU3V0c1BzVDVl?=
 =?utf-8?B?TE5KbkdDMVdReE5PRDlBQW5TV2FHaGw2OUc5MEdOcUt1TE5ucXRON25zdnox?=
 =?utf-8?B?cUtRT1RlQmZOYlJIMlFNWHhDYzdlSU9yZ2NPV0xycGZqa2E1R2MveGFicDVY?=
 =?utf-8?B?RDBiRVR2K0FKeTNUdjd2VjNCRXlodWE0V1ZiRUhHK3hMVndtRk1adWJ2NmlS?=
 =?utf-8?B?L1FQdFI0NEdnNE04OTVFOHI4MVkySC9YR0lRbzErNks5bU82MXVlMGVLUEZU?=
 =?utf-8?B?N2V6cXZRNVNabGdVZGZST2w0RkEzOFpQcE9EbzA2VkJlMmFqNWY2a1ltWmI2?=
 =?utf-8?B?MlRveG5vVFY4aytad3pVS3puQ1hEbjVXbkdOOTRhYWhreWNFbVZralJVWHpK?=
 =?utf-8?B?SWJiSWpqM1NCRzJuYmloNjlUZUpFSHIrSVdzdUEvRHpwZWFTd3ZzUmtsb25E?=
 =?utf-8?B?Y0hmc3BWRVNkT05xQmM3RWJPT05PRzZWSWliY29yRGpLbzQwWHhoQzQ4aDRF?=
 =?utf-8?B?dU1BNXR5dnRKQm51N2dKL3cxMUxrSFhnSVNpcEk5ajh4OVpuNzF4NUt0UE5C?=
 =?utf-8?B?ZmdWN0pZR2QyTXhpcUJtakFGdEVMUmxKYVczMXdSNjBzRmRWUVFZT2JoOHNn?=
 =?utf-8?B?Nm9nSHBnOEU1OGM5VW5XVTZTbFdLZ045V2g1TlZxdUVibzN1N2hXWFhpUUF5?=
 =?utf-8?B?MS9OWHdkNUpTTnJsSGNRdUp0SDFiVFhCc25JN1BZcE5iTmhMaEJsQXlocUVz?=
 =?utf-8?B?YmR5alY2dTZQNUNNbk5zSmlTTzFnV3dLYU9PYUtMLzl4Und3UmczYVhXUDNl?=
 =?utf-8?B?VTJqakUwYWxuWUJOa1kzaS9Va0VJZTR4ejdnRHNkKzYrOUhnd2h0ZVpTR0hI?=
 =?utf-8?B?ZCt5RHY4eCtTbkhrU1BhSDZ2OW1tK1RMZ3M0TC9kenVTdGN2dkZKUkY5NGt1?=
 =?utf-8?B?OGdNTHBmV2FRRUJRakk5aTA0a2xEYnVYRmtRN0xyWjl4MFFhazFKRkwyN2Fo?=
 =?utf-8?B?U1V0Sm16TUJvYWZFaThaZlRwMjIvcTIrbEVWYU1VMzBHdkhFS3RkVG9jRXlM?=
 =?utf-8?B?T3BCeG0ra3IzM2M2Q3A5T0t2WWlCWDVhcXcvdnUzOWxnRSsyYXNlUWdUeWNJ?=
 =?utf-8?B?UklsMmZZelA4MnNTUEJlNHpRelF1T201TTIzZEVjMzVRVkpRamhISXJIS1FC?=
 =?utf-8?B?RXMzZU0vVEpRR2FvMTZRbzZQcG16eEttODJ4dldrZDkzdFgya3hjUWdxeDYw?=
 =?utf-8?B?UXJ3N1A0YUJBNFE5TnpRVXlwMFpmeFRDeG9IRUx0QnpPemxxS1M5R0pubDZG?=
 =?utf-8?B?YklzUlJpV25NUWhLU05aVTRYZE5sZENyZytjTUsxNDNMQnNBZWNpNjkzand4?=
 =?utf-8?B?cWNqVDJUNTRTS0Y4bGUrNEJUYytrWmtxUURzZGZOREwveUNsb3VkVWVUMGZv?=
 =?utf-8?B?TmdyMHpoTmZpRzVpUEZRczRmV01Ua25sSU13NHlDK0kwZXZDU3g3ZHk1alhD?=
 =?utf-8?B?REkrdFIrQlAzSkFreFBDL1BrTlg3bXZNU0xPaDBWczJJV3VrZDFHTEoya0lM?=
 =?utf-8?B?UkxVQXgyWVhjMllCUndHdE1Xbm9pSldqeWRsVkhGTGpDekEzMmFURHZ4TEE0?=
 =?utf-8?B?ckRkb09hTWY2b0ZsNjdDQlJxc3RVNVFVKzZYcVc5ZHdHcFp6aWJqY2QxTmhB?=
 =?utf-8?B?d0NjVHhYajZyL0xVQ3Vabkc1cURDRitVK0VleVF6Vlhlb1pHdC90dE05Yitm?=
 =?utf-8?B?WVUzZFd2RWtmdFJUR3BINnNZakwzNGZLZWQ2endNUTVibEcxZzR4MGJWc1hS?=
 =?utf-8?B?UG5BSXlwbGU2QlFSems5ZEh4TzZuZnJ5SmNEOGlJd1JYVnUrdGprUnlTWEwr?=
 =?utf-8?B?OE9TYysxa3VQQnVkRG1XbWlYYTVoSjUvYUJIK0ZJMEJxbU5ENDhyUlBMN3BO?=
 =?utf-8?B?ZHUydmxjTExPTk40WnFaQ3JnOTNJTk92N082UFdKaWU0cTd6SFcvWDRGMHF3?=
 =?utf-8?Q?CDM8gx3a+DsTBjAGTv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b9a8d5-f2e7-4618-6f1f-08de5fa35297
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 02:00:20.2189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0PWz7Pa2ZOQfPYLyZkNC0cKcB8gGg4zq8vmk/RMkvOChjBnlwbS5H+IMDMfs+ifIDRFa62JeVkFu18TtYY8jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12125
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAzLzRdIGFybTogZHRzOiBpbXg5NTog
QWRkIGNtNyBub2RlDQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gVGh1LCBKYW4gMjksIDIwMjYg
YXQgNjoxMOKAr0FNIFBlbmcgRmFuIChPU1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+
IEFkZCBpLk1YOTUgQ003IG5vZGUgZm9yIHJlbW90ZXByb2MgdXNhZ2UuDQo+IA0KPiBQbGVhc2Ug
ZXhwbGFpbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2h5IHRoaXMgaXMgYmVpbmcgYWRkZWQgdG8g
dS0NCj4gYm9vdC5kdHNpIGZvciBub3cuDQoNCkkgbmVlZCB0byB1cHN0cmVhbSB0aGlzIHRvIGxp
bnV4LCBpbmRlZWQuDQpTYW1lIGFzIGkuTVg4TSBzZXJpZXMsIGJ1dCBJIGhhdmUgbm90IHB1dCBl
ZmZvcnRzIHRvIGRvIHRoYXQuDQoNCkFmdGVyIDYuMjAgbWVyZ2Ugd2luZG93IGNsb3NlLCBJIHdp
bGwgcHJlcGFyZSB0byBhZGQgdGhlIENNW1hdDQpub2RlcyBpbiB1cHN0cmVhbSBsaW51eC4NCg0K
QWRkaW5nIGhlcmUgaW4gVS1Cb290IGR0c2kgaXMganVzdCB0byBsZXQgZHJpdmVyIHByb2JlLiBJ
dCBzaG91bGQNCmJlIHJlbW92ZWQgYWZ0ZXIgbGludXggdXBzdHJlYW0gZHRzIGhhcyB0aGlzIG5v
ZGUuDQoNCj4gDQo+IEFsc28sIGFzIHBhcnQgb2YgdGhpcyBzZXJpZXMsIHBsZWFzZSBhZGQgYSBu
ZXcgcGF0Y2ggdGhhdCBhZGRzIGFuDQo+IGkuTVg5NSBlbnRyeSB0byBkb2MvYm9hcmQvbnhwL3Jw
cm9jLnJzdC4NCg0KVGhhbmtzIGZvciByZW1pbmRpbmcsIEkgbWlzc2VkIHRvIGFkZCB0aGlzLiBW
MiB3aWxsIGluY2x1ZGUgdGhlIGRvYw0KdXBkYXRlLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0K
PiBUaGFua3MNCg==
