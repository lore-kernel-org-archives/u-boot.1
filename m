Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CF8C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F29F080C93;
	Wed, 30 Jul 2025 14:33:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Qw6kGDMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B5A180FA1; Wed, 30 Jul 2025 14:33:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B4C80C83
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsIk4i/ZcFfv1qIU+31giLMgRbMyf8kNV30mVtis2D+q5TM0BxaoMRiEqR2ExUQCULacyfkqBQguY0RiVU7v4JgKkPUkS38V1NKi6eZh/Q6NM/ZCs9GY3s6SmYJIr2lPvDMzSyGZ2q85/Vn/RYWI1xKGzBZS0HTDREDkQ1csGbDPX/08GpFjcoLkrla17hEN6Xb7G7DMhANGb+CMQ+FvQkyYAcHCKjLZkhnAwu3DivQA2BPKVfIjZAce+7fWBXazIlzu0OPd0NUupIGmKs6K2hWIsHTPOufcIaa721URdVxFOG9YLKPcTq3tcjQA1Wn0x89AE7uSaOCONdJAOTdqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QPS68P5DaLAURqVQOVjzJnGWgFSTzaYDQPf9rWQg4Y=;
 b=fPTfaZTJn9gqZlXB6dXRvCEM0/X+vHWjgxVS55JoxnqJ/LUK8NxQjD/ISl3X+tz/0SsTUUFtxIWkba+LGg9g3fFaDZonOfIgfNTg+bYeRyCl3RZhB3iAbo1LiLQNBxacZ59wAnRIAC05APJZURguFU8SpX+E8imivYgUAmK4kfyTpgYsaU8eZgIaGV0dmRc/9O5lHh7pjyynQYrFKYiUz/hk+vFIL543ZAOJ1RASujPUDs5YvX6PxmupI/2vjzGmte1nHFO9Aza9L3XH1GQHm9LfR6QL7HKbV+j0Hbi0R6ZElV23eTFKInAnp68d+NDAYJePkaCG2OK3tN47NCIQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QPS68P5DaLAURqVQOVjzJnGWgFSTzaYDQPf9rWQg4Y=;
 b=Qw6kGDMbfoh5s6FBW6wYxxEBuDEUlOb6Ctsuo/Rdh98gnRePbeJfTb/keWXTwNh22bJdSKvQPa7lAVqP5jdE68w3qk7WYl2spi+sLvc12VhPr0TcbZzNA85Rc4h/BIttEHFKcSWwknKQQyrocYw71dIRnmBgLsA7INOL5DgGgWefP8OmU0ZgddnqucK9kgMsWbGQ50pQN5fUgRPFXbUbftSQG4ElVZ5FSSxBT6zZU7YDebaVXoGGFqsp2BehcZUIblwiLKmxs/Wj45+ZJlb1tZaWW63WE0WaYIX0Bt4RqykEq6VnyTuK1ANfZy1SI+VnJuOmlmXxcPL4miM7Mcjw/g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8620.eurprd04.prod.outlook.com (2603:10a6:20b:43b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 12:33:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 12:33:50 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Viorel Suman
 <viorel.suman@nxp.com>
Subject: RE: [PATCH 8/9] ddr: imx9: Implement Synopsys LPDDR PHY QuickBoot flow
Thread-Topic: [PATCH 8/9] ddr: imx9: Implement Synopsys LPDDR PHY QuickBoot
 flow
Thread-Index: AQHb/2VlL9YsbXG4T029wtkB7SVINbRKh0AAgAATpNA=
Date: Wed, 30 Jul 2025 12:33:50 +0000
Message-ID: <PAXPR04MB84595C1559CF7B32D6631B7E8824A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250728-ddr-imx-v1-0-73da75bb33d3@nxp.com>
 <20250728-ddr-imx-v1-8-73da75bb33d3@nxp.com>
 <CAOMZO5D=p-BHD6KTLVWo_A-Gp+rn0k19Z-WFmtbS9o-x6stxzg@mail.gmail.com>
In-Reply-To: <CAOMZO5D=p-BHD6KTLVWo_A-Gp+rn0k19Z-WFmtbS9o-x6stxzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8620:EE_
x-ms-office365-filtering-correlation-id: e8251dcf-d09e-449d-cbc3-08ddcf655645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bDJweXhjK2w0YXdPVEtzYXJldFB6L0d4b296a0gvR0JIL3lXTXJ6cTgwWmJx?=
 =?utf-8?B?ZldodVR1VlR6STZ4Q3VxUDFhWldGVTVPV3M2MThUV1pqODI0aVdKR05sK1dO?=
 =?utf-8?B?Qkl5RXhMREw5MThWeXFKNUFCZ0FoYU8vVWFPdmlRQ2kxR2pBcyt2MEttRVd5?=
 =?utf-8?B?dGVUb0xyb2M0TTF0OGt3WFdKNEVZcmVvT24wYWVpWHE3WkpXcGNVZXVnaEww?=
 =?utf-8?B?NlpxWlM1aHFlUWNKMmJtRzFtWWVrRDMyWnlVR2RSM0g0OTl0dithMlBVR0g4?=
 =?utf-8?B?cm1LbjRDSWVhaldESUNLQzA3ZEE1OFlmNEZaTDNTcXBtamdEQkI2QUdWV1ZG?=
 =?utf-8?B?WHpQMmhDTmJzWjJoeEhGSVJaYXo0aUlEbWJZWkdVRElnbWxZR2cvcU9NZmNx?=
 =?utf-8?B?dmZ6d1dqVVVMTFBTeXM4STJUblZVT2Y2eHRtUUh4NVlQemVnWDNyb21oNzhG?=
 =?utf-8?B?dzBUc2sxdDlDSjhvV25WQmZZbHpRaytrTjMwZThrejJDSENQTDY2emtWZnZu?=
 =?utf-8?B?UEJnYXg4MmVrbUxOVm0xMDhTU200MjNFbERGNEYvWkNPTWM4VzlBWmo0dVd2?=
 =?utf-8?B?SWZZdkp3djZ5OUVMcFRFYjlCSkJxdTZsV1RNUWhXbjVQRjJtZEFwUHVGVmtG?=
 =?utf-8?B?ZHhFUUVjMkRIeUdWMzVsQzFPWkV2ZlV2ZU5tekY4aTdWME03QTl3NWw1aXQ5?=
 =?utf-8?B?a1hOdkpDNTVZMU5jSU9UOUNBTEJKUXMzUS8rVHhCeVk3RzY0YnBaMTBQRk5X?=
 =?utf-8?B?U3pLN2pEdnN1RzZuMUFBbXpwR0c0NURVNUJzM1Z6RURMSzNUUDdGRVFhRm9E?=
 =?utf-8?B?dDFnMVdGL2pkcWxSYVBEUVo5d1BKWnQwdjQ1SXRkMmhtR2NKYzVIMjJhMDhW?=
 =?utf-8?B?cmoxMW91MTFtUGpzRE8wYTRES1c5QVFBMkxpU2I1bFVxSEFaNllRSDBVVDh1?=
 =?utf-8?B?cG9tS0ZjWWZVMkd5ckJ0Qy92d3l3YkR1Z0VwUVlRaHVZQTJTMkVhbWRsenpI?=
 =?utf-8?B?K2hOSTRBUXlHVWVwNXY3SjVIMDYyOURla3RvMUJuOWpMMm9Xd1RhS2YrTms1?=
 =?utf-8?B?NERjL2dIekMxc0N4bk9pK2ZHdmVDRXJWVm4xSkJmTUZGK1NMYklwNndPYXRN?=
 =?utf-8?B?QnFkZjJkUjBXZEh6UmR5UXhLOVdNTkJnNWJuNVB6NzQ0dkRNOTBTNEtYdGhT?=
 =?utf-8?B?V082YVRUSjczVnlDTVBhcUlPclhRVHoyc3N2UW5GdmVtWmVNaWlXWWo5Vkpn?=
 =?utf-8?B?RE54VjlLZ3ZyamVMWVNyWEVXdnc5QlJsdEQ0Y01zT0dDOGFDd0F4aTlDdUVC?=
 =?utf-8?B?S3NsSzgvRk5oc3BBVlpTVVljNjlvRTRWb2hKczczYlk4WHNuT0VyeittZ3FQ?=
 =?utf-8?B?U2dRSjg5eFJrR2FVWTBzaGxzUStPUiswK1hMa0prV2IzWU1nSUFxSS9pY1do?=
 =?utf-8?B?dFJkQ0Y2Z1o3MFBtd3lIMUVleW1PYVE2QVkrb1psTW02WDJ2L1RNOVYvSC9V?=
 =?utf-8?B?UjBJUU1mZ3YxYzZ0b1M2SW5tZXRsNGtBUWd2ZjdYdXF5ckc5d1ZSWmxMVEJG?=
 =?utf-8?B?MEoya0xkVUpSRlNhRlJHc05RbUpHRjZBcGhSajZDdVRvcHBmNXdhUTVPWUxV?=
 =?utf-8?B?Z0JWYS9ZTnlwSkExbm82MnJJQmdzaWc0QUFDTVk2K3lkdzVhTXYwRDZUb1Zv?=
 =?utf-8?B?RXovd01JTDY4end5Z2pUUDRNd0Z4VmxQb3VPWGhnYmZDMy9DaDlaMFh6SDZu?=
 =?utf-8?B?QlROQnhqLzlSVWlxYTRkL2RXZmFFTlVWQksvdGFlZ2t4bEdCYnBiMHF0L1lm?=
 =?utf-8?B?dTNhaSt4Qmx1a3IvR2NORDdSZUYyVE14anhBcHkwVlJHcCs0UitnTThJMUJo?=
 =?utf-8?B?WlZwSDVEcVVGZXB6ald2TEh2bXpkY1psVXJ2S1BMTDZQSng2Z2tFd0dVbTJa?=
 =?utf-8?B?enlibVE4ejZOdnJjRmFua2piSDhSL2w2aXcrcHYrVGZHVklrVVBsVE82QVFo?=
 =?utf-8?B?Tjh6cFVHdHdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkFCY2wwYUhjWWhlUEFaR3FLbGx2cTJGakM3Mm1HMkxBcXM4VW9tMVlEUkhp?=
 =?utf-8?B?VFVvajVIMnpQREZCbTZLUkg4Y3RUdEY3NGFOWmJ0ZG10dlNicW5GU1BNYzQy?=
 =?utf-8?B?bkkvWnNBRTA2MXV0cjZReHo1VStrYTZERFhybExtaENVbkI5NU1lNlFhbmVs?=
 =?utf-8?B?WGorTkFod2VDdGhtMWlEbXlra3dPemdjdngrZ3JsTzlDdk13WjFxRDh1ak14?=
 =?utf-8?B?Nkhqc2c1R0I2Y2NkSWJTdXFxNFcreGtHamhsaFpCc0FHc3BXT0dkUHd1U2VK?=
 =?utf-8?B?UE15akxqOE1adnZBWlNZb1hpVjU4UXdGcWtvYzBYWlEwVmJUbU5oZzRJU09t?=
 =?utf-8?B?MzAzdjBjL0RtTXJicngvQ2VHYk1zMWFlcUJBQWhwU0YrSTV2VWltMjJmdE1Q?=
 =?utf-8?B?Z2FDU2J3NDJKdFpzajZOV2VBQ0pvK2ZOb21XelBMZWQ0dDFVK0FaYzc0Y2xL?=
 =?utf-8?B?TEwyT2NmaEJQbWt5QVFyQ3g4eXVtb3BzZmtQKytyMDF2dTZXc2QwWW1pWEhG?=
 =?utf-8?B?TWJjdDFpdUJmN05FSjlNSnE3S21EUVdRKzd5U3hKWkN1S3FHS1RRRDYrc2JU?=
 =?utf-8?B?Q1NTNERTWEI3Q3lTSVFaTzloK1Y0ak9KZG9UR205RXI1Zmg3Y0g5YjNHR0ZR?=
 =?utf-8?B?eDVXUlhrL3dBZXpEemJuTTVwRUtJY0Y2STBNbFY3cW1MWlhvU2gxWGdtODVm?=
 =?utf-8?B?VFJ2U1dSTENCWFZEbGlJb1NNQ0FPcHFnUTlsUGI5akxaSTBNcU5lSUVXNldM?=
 =?utf-8?B?cnBXazU1cmhTQkxPSHpPNElCQjhlQ1I0RXNORm5odlJEVkM1UWk2dzUxbGpX?=
 =?utf-8?B?QmVCYVlmSHE1MWpHM09SaTRLRkxiclBpeDYrcGZjcUtKbDhlaHpSYkV6d3pW?=
 =?utf-8?B?UmtnamxDRzVHMGpUL2loeFFmaDI5QkErSEd6STMvM3BQL1RpTzBSSzR5clRO?=
 =?utf-8?B?ekltVk1TeTRrUzZWVlBSSmlCNkJ1ajl2UitOK3l3cWpvaVVnOXZaR3RqNDkv?=
 =?utf-8?B?ZE9aeDlJQ0lacE5oTzZHZFcwNWxmQW11bFZNMjMxK3dObDc4NThZK1lIRkkz?=
 =?utf-8?B?ZXljRFAybFE4bmJoK0RPUlZtcmNpditRTWNJbThhaFAyK3d2cE1jcFhmZmpa?=
 =?utf-8?B?c2VLdmk4eG5xcW5CWE8rOVNYRlRIbGxhcllmdlNuUjMwNjRScFVGNFNmT2xX?=
 =?utf-8?B?SStDRzlYYW5TWG1TcFpGVVpLbU5adDJ2MVhhcW1rMVBadUNSdHFzSzVwTEcx?=
 =?utf-8?B?VThRaThHN0NkUnFEMVlFRFpVSkEyWkZrbCs0c0YzVTJpczRpR3ZmYmFGZUZm?=
 =?utf-8?B?enJFN3NEaVd0SzJDNVhUTkEzUk9WcmdST1ZtRWFyT1V0VDVoQjJBZENjVGhz?=
 =?utf-8?B?bGRMMVRrSzJ3ckVWQUxlaXJFZlVpTTI3VlZGcElXOEdyT3ppWEtORlllSGRX?=
 =?utf-8?B?a04wSktIMEhLY1dGMjRrS2pjMEYrYVI2ZHowRjhBZjc4dmQ0VWFFMmhjNnhs?=
 =?utf-8?B?OFBDYVNOZzJ6eUVTVytVSDA1SWRkMlBMdlIyWE5EOW5CcVFYVVVuOFd6UnVT?=
 =?utf-8?B?KytYSzlGM28wZUhYd2V6eDJNWWUzWm13MjliVSt3bHlmR3NxQzVBNEppdk1N?=
 =?utf-8?B?MnRVRjlyNk55cU4ycGJ6TGFPOHBkS3Q1YXBMb0c3M3RveWRVTXZ1bDNodmJ2?=
 =?utf-8?B?aU5BK000Z1RUSjRnUGRaSTdWQXZDeTQxeWMybXRkKzZjNzcwU01BUitYeGJP?=
 =?utf-8?B?QXB4WmRkZFQvUzh2c2dMRE8wVWpNUExXVlNDU1VkNGJIYk9ZczdUbWF5aUVa?=
 =?utf-8?B?cm9mNTRQaGlPNmszK3RxNFlBMm1aSVhJUzYzTk9GTEJmNWJlWE1wcFpPbkdx?=
 =?utf-8?B?a0dYWklWVXdWUjduMkVyQm52UzhhMmkxKys0Yk5kcWx0NWZ0cEVtOFc3S2Fz?=
 =?utf-8?B?Q2dhdzIxOWRmRG4rcWVkVjZVby9HOUtWeWRBb213ejVpcnZCdTlSTkVvekt6?=
 =?utf-8?B?a0RPUVhIWHVnQXRESVd0enl0ekY3Q0loN3ZQMjlBV0d0L3lULzdMQlZodHlu?=
 =?utf-8?B?eUpCVjMrYmNVNlJaMnlqa2t3eXkvOG9TQlIzb1NCQ01JZC9KYVpxazdJTzhv?=
 =?utf-8?Q?CUIE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8251dcf-d09e-449d-cbc3-08ddcf655645
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 12:33:50.1937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAeE17ItfpW4cg9O6jVY9vPeNkT3eir7L+HWdHtTzeG1esZ82nCXfurdBqpk9K1/UxRFZTGjt5BsrjKlLx4eDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8620
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDgvOV0gZGRyOiBpbXg5OiBJbXBsZW1lbnQgU3lub3BzeXMg
TFBERFIgUEhZDQo+IFF1aWNrQm9vdCBmbG93DQo+IA0KPiBPbiBTdW4sIEp1bCAyNywgMjAyNSBh
dCAxMToxNOKAr1BNIFBlbmcgRmFuIChPU1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBGcm9tOiBWaW9yZWwgU3VtYW4gPHZpb3JlbC5zdW1hbkBueHAuY29tPg0K
PiA+DQo+ID4gSW1wbGVtZW50IFN5bm9wc3lzIExQRERSIFBIWSBRdWlja0Jvb3QgZmxvdy4NCj4g
DQo+IFdoYXQgZG9lcyAiUXVpY2tCb290IGZsb3ciIG1lYW4/IFdoYXQgYXJlIHRoZQ0KPiBtb3Rp
dmF0aW9ucy9hZHZhbnRhZ2VzIG9mIGFkZGluZyBzdXBwb3J0IGZvciBpdD8NCg0KU2F2ZSB0aGUg
dHJhaW5pbmcgZGF0YSwgdGhlbiBuZXh0IHRpbWUsIHRoZSBib290DQp3aWxsIGJlIHF1aWNrIGFu
ZCBubyBuZWVkIGRkciBwaHkgdHJhaW5pbmcgc3RlcA0Kd2hpY2ggd291bGQgY29uc3VtZSA0fjUg
c2Vjb25kcy4NCg0KPiANCj4gUGxlYXNlIGV4cGFuZCB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gZXhw
bGFpbiB3aHkgeW91IGFyZSBkb2luZyB0aGlzLg0KPiANCj4gPiArY29uZmlnIElNWF9TTlBTX0RE
Ul9QSFlfUUINCj4gPiArICAgICAgIGJvb2wgImkuTVggU3lub3BzeXMgRERSIFBIWSBRdWlja0Jv
b3QgbW9kZSINCj4gPiArICAgICAgIGRlcGVuZHMgb24gSU1YX1NOUFNfRERSX1BIWQ0KPiAmJiAh
SU1YX1NOUFNfRERSX1BIWV9RQl9HRU4NCj4gPiArICAgICAgIGhlbHANCj4gPiArICAgICAgICAg
U2VsZWN0IHRoZSBERFIgUEhZIFF1aWNrQm9vdCBtb2RlIG9uIGkuTVg5IFNPQy4NCj4gDQo+IE5v
dGhpbmcgc2VsZWN0cyBJTVhfU05QU19ERFJfUEhZX1FCIGluIHRoaXMgc2VyaWVzLCBzbyB0aGlz
IHBhdGNoIGlzDQo+IG9ubHkgYWRkaW5nIGRlYWQgY29kZS4NCg0KSSBjb3VsZCBhZGQgdXNlciBp
biBWMi4NCg0KPiANCj4gPiArc3RhdGljIGludCBkZHJwaHlfcWJfcmVzdG9yZShzdHJ1Y3QgZHJh
bV90aW1pbmdfaW5mbyAqaW5mbywgaW50DQo+ID4gK2ZzcF9pZCkgew0KPiA+ICsgICAgICAgaW50
IGk7DQo+ID4gKyAgICAgICB1MzIgdG9fYWRkcjsNCj4gPiArICAgICAgIHN0cnVjdCBkcmFtX2Zz
cF9tc2cgKmZzcF9tc2c7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZHJhbV9jZmdfcGFyYW0gKmRyYW1f
Y2ZnOw0KPiA+ICsNCj4gPiArICAgICAgIGZzcF9tc2cgPSAmaW5mby0+ZnNwX21zZ1tmc3BfaWRd
Ow0KPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8IGZzcF9tc2ctPmZzcF9jZmdfbnVtOyBpKysp
IHsNCj4gPiArICAgICAgICAgICAgICAgZHJhbV9jZmcgPSAmZnNwX21zZy0+ZnNwX2NmZ1tpXTsN
Cj4gPiArICAgICAgICAgICAgICAgZHdjX2RkcnBoeV9hcGJfd3IoZHJhbV9jZmctPnJlZywgZHJh
bV9jZmctPnZhbCk7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgLyogZW5hYmxl
IHRoZSBkZHJwaHkgYXBiICovDQo+ID4gKyAgICAgICBkd2NfZGRycGh5X2FwYl93cigweGQwMDAw
LCAweDAwKTsNCj4gPiArICAgICAgIGR3Y19kZHJwaHlfYXBiX3dyKDB4NTQwMDgsIDB4MDEpOyAv
KiBTZXF1ZW5jZUN0cmwgPSAweDENCj4gKERldkluaXQgT25seSkqLw0KPiA+ICsgICAgICAgZGRy
cGh5X3coMHg1NDAwYywgMHgxOSwgMHgxKTsgICAgIC8qIExwNFF1aWNrYm9vdCA9IDB4MSAqLw0K
PiA+ICsNCj4gPiArICAgICAgIC8qIEFkanVzdCBNUjE0X3h5IGlmIHBzdGF0ZT0wIGFuZCAyRCB0
cmFpbmluZyBkYXRhIGNvbGxlY3RlZA0KPiBkdXJpbmcgdHJhaW5pbmcgcGhhc2UgKi8NCj4gPiAr
ICAgICAgIGlmIChmc3BfaWQgPT0gMCAmJiAocWJfc3RhdGUuZmxhZ3MgJiBERFJQSFlfUUJfRkxB
R18yRCkpIHsNCj4gPiArICAgICAgICAgICAgICAgZGRycGh5X3coMHg1NDAxYywgMHgzOSwgcWJf
c3RhdGUuZnNwWzBdID4+IDgpOyAgIC8qDQo+IFRyYWluZWRWUkVGRFFfQTAgLT4gTVIxNF9BMCAq
Lw0KPiA+ICsgICAgICAgICAgICAgICBkZHJwaHlfdygweDU0MDIyLCAweDQ1LCBxYl9zdGF0ZS5m
c3BbMV0gJiAweEZGKTsgLyoNCj4gVHJhaW5lZFZSRUZEUV9BMSAtPiBNUjE0X0ExICovDQo+ID4g
KyAgICAgICAgICAgICAgIGRkcnBoeV93KDB4NTQwMzYsIDB4NmMsIHFiX3N0YXRlLmZzcFsyXSAm
IDB4RkYpOyAvKg0KPiBUcmFpbmVkVlJFRkRRX0IwIC0+IE1SMTRfQjAgKi8NCj4gPiArICAgICAg
ICAgICAgICAgZGRycGh5X3coMHg1NDAzYywgMHg3OCwgcWJfc3RhdGUuZnNwWzJdID4+IDgpOyAg
IC8qDQo+IFRyYWluZWRWUkVGRFFfQjEgLT4gTVIxNF9CMSAqLw0KPiA+ICsgICAgICAgfQ0KPiA+
ICsNCj4gPiArICAgICAgIC8qIHNhdmUgQ1NScyB0byBhZGRyZXNzIHN0YXJ0aW5nIHdpdGggMHg1
NDgwMCAqLw0KPiA+ICsgICAgICAgZm9yIChpID0gMCwgdG9fYWRkciA9IDB4NTQ4MDA7IGkgPCBE
RFJQSFlfUUJfQ1NSX1NJWkU7IGkrKywNCj4gdG9fYWRkcisrKQ0KPiA+ICsgICAgICAgICAgICAg
ICBkd2NfZGRycGh5X2FwYl93cih0b19hZGRyLCBxYl9zdGF0ZS5jc3JbaV0pOw0KPiA+ICsNCj4g
PiArICAgICAgIC8qIGRpc2FibGUgdGhlIGRkcnBoeSBhcGIgKi8NCj4gPiArICAgICAgIGR3Y19k
ZHJwaHlfYXBiX3dyKDB4ZDAwMDAsIDB4MDEpOw0KPiANCj4gTG90cyBvZiBtYWdpYyBudW1iZXJz
IGluIHRoaXMgZnVuY3Rpb24uDQoNCldlIGNvdWxkIG5vdCBkbyBtdWNoIG9uIHRoaXMuIFN5bm9w
c3lzIHJlbGVhc2UNCnJlZmVyZW5jZSBjb2RlIHRvIE5YUC4gVXNpbmcgbWFjcm9zIHRvIHJlcGxh
Y2UNCnRoZSBudW1iZXJzIHdpbGwgbWFrZSB1cGdyYWRpbmcgbXVjaCBoYXJkZXIuDQoNCj4gDQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBObyBuZWVkIHRvIHJldHVybiAwLiBN
YWtlIHRoZSBmdW5jdGlvbiAndm9pZCcuDQoNCm9rLg0KDQo+IA0KPiA+ICtpbnQgZGRyX2NmZ19w
aHlfcWIoc3RydWN0IGRyYW1fdGltaW5nX2luZm8gKmRyYW1fdGltaW5nLCBpbnQNCj4gZnNwX2lk
KQ0KPiA+ICt7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgICAgIC8qIE1l
bVJlc2V0IFRvZ2dsZSAqLw0KPiA+ICsgICAgICAgZHdjX2RkcnBoeV9hcGJfd3IoMHhkMDAwMCwg
MHgwKTsNCj4gPiArICAgICAgIGR3Y19kZHJwaHlfYXBiX3dyKDB4MjAwNjAsIDB4Myk7DQo+ID4g
KyAgICAgICBkd2NfZGRycGh5X2FwYl93cigweDIwMDhGLCAweDEpOw0KPiA+ICsNCj4gPiArICAg
ICAgIC8qIGxvYWQgdGhlIGRyYW0gcXVpY2sgYm9vdCBmaXJtd2FyZSBpbWFnZSAqLw0KPiA+ICsg
ICAgICAgZHdjX2RkcnBoeV9hcGJfd3IoMHhkMDAwMCwgMHgwKTsNCj4gPiArICAgICAgIGRkcl9s
b2FkX3RyYWluX2Zpcm13YXJlKEZXXzFEX0lNQUdFKTsNCj4gPiArICAgICAgIGRkcnBoeV9xYl9y
ZXN0b3JlKGRyYW1fdGltaW5nLCBmc3BfaWQpOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIGV4Y3V0
ZSB0aGUgZmlybXdhcmUgKi8NCj4gPiArICAgICAgIGR3Y19kZHJwaHlfYXBiX3dyKDB4ZDAwMDAs
IDB4MCk7DQo+ID4gKyAgICAgICBkd2NfZGRycGh5X2FwYl93cigweGMwMDgwLCAweDMpOw0KPiA+
ICsgICAgICAgZHdjX2RkcnBoeV9hcGJfd3IoMHhkMDAzMSwgMHgxKTsNCj4gPiArICAgICAgIGR3
Y19kZHJwaHlfYXBiX3dyKDB4ZDAwMDAsIDB4MSk7DQo+ID4gKyAgICAgICBkd2NfZGRycGh5X2Fw
Yl93cigweGQwMDk5LCAweDkpOw0KPiA+ICsgICAgICAgZHdjX2RkcnBoeV9hcGJfd3IoMHhkMDA5
OSwgMHgxKTsNCj4gPiArICAgICAgIGR3Y19kZHJwaHlfYXBiX3dyKDB4ZDAwOTksIDB4MCk7DQo+
ID4gKw0KPiA+ICsgICAgICAgLyogV2FpdCBmb3IgdGhlIHF1aWNrIGJvb3QgZmlybXdhcmUgdG8g
Y29tcGxldGUgKi8NCj4gDQo+IElzIHRoZXJlIGEgc3BlY2lhbCBmaXJtd2FyZSBmb3IgdGhpcyBx
dWljayBib290IGZpcm13YXJlPw0KDQpZZXMuDQoNCj4gDQo+IFBsZWFzZSBleHBsYWluIHRoZSBk
ZXRhaWxzLiBJdCBpcyBub3QgY2xlYXIgd2h5IG9yIGhvdyBzb21lb25lIHNob3VsZA0KPiBlbmFi
bGUgdGhpcyBRdWlja0Jvb3QgZmVhdHVyZS4NCg0KSSB0aGluayBuZWVkcyB0byB1c2UgQjAgY2hp
cCB0byB1c2UgdGhpcyBmZWF0dXJlLiBJIGNvdWxkDQphZGQgbW9yZSBpbmZvcm1hdGlvbiBpbiBW
Mi4NCg0KUmVnYXJkcw0KUGVuZy4gDQo=
