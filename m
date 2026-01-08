Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D048D185F9
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB08684205;
	Thu,  8 Jan 2026 14:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wsLLURWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF92E8405C; Thu,  8 Jan 2026 10:53:18 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC02883A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+z6CmlBW//UyQmFB+iMUij1wEr1hd188Ym86+KuBIp7dP1YIjKKUwfCaXWbhfkZRt9OPbPGysjuNJQUI/XI4B2eZGOEciuoAW9DzJ9c0sPrID9Gq3XVV4qO8EsHP1cHKrVQfOz+CLLc4JOfv4NqFA47/bU3frzp4Pk3c0CgppQOKDde0VtUoDGM9fJHrCmdtbdNJ4AE9s+OpEdj+2awY9BBnbwwxQC1JvWJgwvrJlY/NVMW6wpVM6yIrk+bTMyWabdroGg/YhAA+Rc+LAoEsLDcjrZIZ6Lll07ZROTeWkCk/LXyPg8BlOgAbjwruCcD8Nlg7oE0tVcB3KgiIvNvdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km3YwKNTwMH7Wxb5VFih8ygGZ+c/ICVvVuysgr2N0OU=;
 b=H4RHEi16NoZr+KuQmfttEBUGX1559TOKinE+qqN6pjRo7SM1hl/SLikuB2QF+IDGxi5TKcOi+M1v3L8U9I5TcHXQxzoSaDJCZfMHywRPm5gmdIc5JOOXYnR7sd8BIHy7wHrVdajzgvrcBdKmen2EFXP9bsClsuNi80+MXJ/eiQ2oL9CkpQr+gIRYw1TC1gmDC2bshtWMjvOjlZOZVVNgm4nSnYAqBSnYmH/wZLwugrA+h48MMSU/pvwBCJmTjx1TNMOBSpM9Og9plIDKLpuxgWsbZGWbPwRFY+smWEPFxS9AccvmgdvgUSoTivG1dYmhTjN1q8mgMJo6bAzG9so2oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km3YwKNTwMH7Wxb5VFih8ygGZ+c/ICVvVuysgr2N0OU=;
 b=wsLLURWdloXDQtucKZBqZQwUCvw5b5BCHSiS2YMOaSbfMJQ/UA6mbl6T6iWj7JSNex1MPX64iUDR6YVl2IDsJqTdzOiJhPaTT+XBqVcTYtYbWfnN7qkul3MlQqc7uFGq+4whQp+pVoUDMawtcEELl2DhQ91Ab0RJq2fbl/BW5G1KEtXCzvws0ZI9arGq2JsAdeIhYPVkPK7fvHUma7+zHBROh1CcjObKcKsbuBV37mdXom9R9Vz9suXbAEkrZ5/RQ1DaTGsPNy8ddPOw/FEgS1GD53oWh7WjaVhK8nL70yJf15Tjz+0u3ABRKjq9reH5mXiIatZqxd3zeoiWXf1l8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PAWPR04MB9765.eurprd04.prod.outlook.com (2603:10a6:102:389::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 09:53:13 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:53:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:54 +0800
Subject: [PATCH 09/13] imx95_evk: Sort header files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-9-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|PAWPR04MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e95480a-b5c9-4665-95f3-08de4e9bbd00
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1AvY0pZQmRDc1JaZGZOS2EybWRIaUZxR3VJcmZDQnhKbXBES2NqQzBMYXJN?=
 =?utf-8?B?SFowMUZIbldwdFRna0NWTGhqTk9xR09LQ2RoSWdWa05KWExFWVlhRG5iVzRh?=
 =?utf-8?B?dExlbDRjWUsrbDJNTDYzNExvZzBLZytUd3ZPaExXTFZrUEF3czQ3RzJOWTlL?=
 =?utf-8?B?NmVucXlVR3ZoVEVCUzE3OCtleHkwMnVKdzYvR283MlBHcUJlOFVmdkRRaVhz?=
 =?utf-8?B?OUlIdVl6QVJSTFRXYUlFeGF6aDZFSjErRktDSW9iaGp0SDZrZE9MckZnRVJD?=
 =?utf-8?B?SHFEZDVUUHk5MmFlRWlxQzhacFdiUE50WlZmTXFZV0tJWnkrMXRPN2krc2ZJ?=
 =?utf-8?B?VDZVVytUdzFaeTJNSWpZMmE4Z280Sy8xNlFYdHFTZVFSbFdrZlA2cDRzSXFS?=
 =?utf-8?B?Q2VsaTFvTVJoTS9oR2RoaEl2V3l1d1JsZHlnME90WmlrR0ZMOHRORWFlU2tD?=
 =?utf-8?B?WWQyNVd5UzZ5Ylp3Y0pMcHdXSmpJWXZKd0NWbnVMYnJ4WlczR055bFZENSti?=
 =?utf-8?B?SXBvY05IUWZZdTEyL1pYaWt0ZVZRbXR2d0krWWNUMFIxcVhJREgyZWtURFor?=
 =?utf-8?B?NW9nNGhJZE1kYmsvdFZvaWNVMG5ndFh0a1ozWndXdVNCUjFPVTh2MFdjY09F?=
 =?utf-8?B?U1VOaTZHaXBKZ3ZBOHcrN0lDTGpUcU5Xd2VwTjlhYjZRZlk2RjQ4dkpjc3pO?=
 =?utf-8?B?cFUzbXl4Umx5MjViUEFOYitQZHBHNDFNdlR6c1BKMFhOaUFTVktTMGdDM2g5?=
 =?utf-8?B?enpxMGdSb2NHYlhjNjdsNVNDTXdNdkk0Q0FHQVM5T2Z2Q1VvOXpSV2wxejI5?=
 =?utf-8?B?OTVFSFdHY3pDOHJsS3VwOEhiWWFPbWhRNGo3MlY0TWx2ZmVMOVVjZUwzUURt?=
 =?utf-8?B?ZWlCOEVWYml5am1nYlpnWjNLZFNrUDVHYVcxZlJYQW1YM1ppS05xTW1BZkYy?=
 =?utf-8?B?Tm5idzdYcytabU9uTnNJcW8yYllaZ0JEOUptNmZIMW9iRURQaTVpUFg4cTZw?=
 =?utf-8?B?ejdEbVgyL2NwdkhtRi9IVXg3SiswTVZPOFhldU5wQmVjcnkyOU1BRG9yRDNi?=
 =?utf-8?B?dWFWR0ZGb2oreGlVOVV6TVdVc3VsRHhEbk5yME91T0hKejZDVGxCVnZ4Q0dP?=
 =?utf-8?B?SUw5MWJXNEVsNUQ4c1pydk1TZ241d0w1ek5yUks4TE04dCtpRldlRDdvYXl5?=
 =?utf-8?B?K3dtNzVyT0g4UUtUV2FpellzNDJ6M3JObHJoZFR6c3RvQXVFRDVrZktKdG9Z?=
 =?utf-8?B?SDBMSWJHQVU3anRxQ0RDTml1Ujc5VzR5NTRWczZxVnJqRWRGODcyTnZRVGhQ?=
 =?utf-8?B?N1dSYzdrMFAvTzBrTDFGWjRCU3BnVXZNTHpXOUYwRnN1RkZkUUVOcEZGWVRM?=
 =?utf-8?B?RGRUMmdwRDVxc280eHQydVI4aUo2WEFWWkFCcnhEUUp6NUlGWlA2b3JIa2FC?=
 =?utf-8?B?OVJDaTBrZHREMTJVZGNYWi9LbWM4eDdmK2o1U3NXYUlBQ3BlN3BPT2xGam9F?=
 =?utf-8?B?TEw3alZjVDQ2eitNUE44RzRaMHhjNHNSbEJDMlB6YWZnWnhaOWJqS2xvekVN?=
 =?utf-8?B?c0RrSUJHeHRId24zOGpKVlhnWTYzdFJlMUJOOHJFNG5NR3JFNnJsS1ZmVzhm?=
 =?utf-8?B?MFVna2hyRm4vN2diQXQ3U0xVVUJKNUh0dHorb1Nkays1YVphbS9sRS9tUFhH?=
 =?utf-8?B?UG1aMjc0a05pNm5rV3cySE01U3M3d2RnK3ZSM3h4Kzg5N0lCelFhWDVTUk54?=
 =?utf-8?B?VGV4czVnLytEbzkwckt4NTIyMmo1SjNYQkpIU3l1UVpkb1U0YlhYam10R1dH?=
 =?utf-8?B?M3BNZk01TEFWanQ2STAybVcrV290QVdFZ21IcDNjM0EyVnA3aStiNEx3ZHFE?=
 =?utf-8?B?L2h6ZytYY0Z4SHp2UlN1bG1PWUIwaGNBS3hHZHNiNHE5L3NOaTgvSFM2eTZF?=
 =?utf-8?B?WGVPc3BVNDByUFlINVFrVjVoaUgxRkhEU3o2VnpXWUV2NktmRStaam01QnQ3?=
 =?utf-8?B?S2cwMElUOWdQa2dEbjd2TGVmNzJiaTBnU0hndGJWbFRkOVFxTTVyUnhBWmpF?=
 =?utf-8?Q?Av3rkK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpIWlFQMVE2b2ZGd21uNzZRSUtFbVJWZVRWSy9Ub0hqTDQxM21JNW1BRkVI?=
 =?utf-8?B?a0tPaDRXb3lSMlpTek1EeGR5TDRsYktSQWlDV3pKOER1Y1doTjRCbGVUV0NV?=
 =?utf-8?B?NVB1VGFrbWtWRjM5dkRmVjRXd1Y5UTRsalhWU0E5OXJ1aXRTbE1mVEoxQkFo?=
 =?utf-8?B?R0h3MzE2a0xxTjRPWmNIS3JJWmFYZWN3WEFiVFVKL1JSS20vTHNqQmpmdWwz?=
 =?utf-8?B?TG9GTlZnS3hYUFY5RTRDU0czeGIxdlR2TkM5aWhEajFsVldZa1FkTlNrSlZr?=
 =?utf-8?B?Q1hjdmFqZ0s1N0hOWldjdzBSYVRmVVJCVkJ1eG9xZjlWVzBpQWR0R1ZXaExF?=
 =?utf-8?B?VnpLUk5xZTEzalpxcjJQRDIzVUdhQ3d4cVRzY2VNUWhoUW52a3k1bzg0OVg5?=
 =?utf-8?B?dU9WamNWWGFrSmErVWRXR2tZcXR0RzNUZkNwb05BakkwcjRRQzFxdXY5VUpP?=
 =?utf-8?B?eVhQSERCTlpxMWZDQnJ3UDBtakhzRzVhaFBnVnRrc3RnUnQ5dTVVV1drLzZj?=
 =?utf-8?B?NmNBYURPeG90ZFI3Q2paWEp6eEo4Tm1WTisvZGRzaXBnK3ZiUGNZOGMrTEF1?=
 =?utf-8?B?b3A0a0lwVnE3WW0vbHZwMm1NT2l6cE5zZnFuWnBUWWtOTzZ6MUk2T2Fqazdy?=
 =?utf-8?B?RERMSXMyL1pHM3IxRGNhMTBHSk8rbG40bStCOFFIb0lMZkNIOXg3aStHRUVG?=
 =?utf-8?B?bTFjL1g0UnJDczZtZ1NlMm1qQk5qdW9DSjhPcW4rZHhNVWprU2tSVTdNRzVI?=
 =?utf-8?B?OE5ZejBmK1o5R3NPUDNPQ2JxOUZqQytBbEw2QUJ3QmY1Z0JJVUVhRExRMlVT?=
 =?utf-8?B?MjVxY1pWTXlRT0k4TEdDL01ETnMvQWkxaUJMQ3Y1NmtJTnlhbHhGUnpiVkpm?=
 =?utf-8?B?ejNnalFMcHp3YmdRa1RnTkUxZmltN1JCMElsZmVPSFVNTzFRNUF4dVVKYkZS?=
 =?utf-8?B?dGExZzNIVGpCWlRDb1hXbENPQ1JUNkhHWlNuTDBDcXZMMWlndkM5SkVEeklF?=
 =?utf-8?B?eEk1bi9kd3ZHakFET3NrbHVBNGhzUW9LWkpkb2RkTThtcDk5N291MmxwN1VB?=
 =?utf-8?B?TS9OeW5Vc1B2ZDFYOTRKUndVeTZ3UnErcHhPT3luNU12TWZMdWhhdk50Y1Vm?=
 =?utf-8?B?MmhlVnV5elpZODArQWhrcHo2dVBKLzdsY3BxMDFtQ0c2ZTc3VDJvSHJJTWtZ?=
 =?utf-8?B?anhKLzBnR2NCMGdsK3JVRU51czZJZG9yZWZ6ckg0V25xZmZaOFIwNUlzL3NU?=
 =?utf-8?B?dUpYWFQ0a2Q3R2NEdThRSEhpM05nZWExZjVReU5rRFRmSTdxOFVCNmZESTdu?=
 =?utf-8?B?MEhQTDBrT0ZROGVZMnVrRUJxQXR5cCtFSytEdENiNmlOYmhNZDErQVdUbi9r?=
 =?utf-8?B?ckpoMkQ1c0JuWldYVmlPZDBZSTR4ZklpbWN6OFJCZGNLOWJRb1AxQjZoTEZT?=
 =?utf-8?B?ZThoaU1uMGhhMHJNV29HUkQwejd5T0xTY09EN2ZMMklCWklRamhXR0NzK1cy?=
 =?utf-8?B?RUN0YXZDMDAzbGlKSUk1ZlpSbTl6NlZTVStha3RvaEpkeWhaUXpONENxUkxB?=
 =?utf-8?B?a1RYbVlTYjhxV2tURXlBdGx4TG96bS8rRTZLUDMvOWdRMERlSlM2U2RBSHdj?=
 =?utf-8?B?aE0vVFpxN2ZSa2tjS3BOYzJHYUcxR3lZUUJsekJMOUpFVzRXVmNqV3diaUcy?=
 =?utf-8?B?cmVFQTVlUHExa0pqekVCcDNKQnhGRGVjWFhiQlFrTlluWVFUUFM3YU5BUUJy?=
 =?utf-8?B?Um1iVEdITFpXOVFSVGVxVlRYZnVmUDF6NFY2U0xHL2V0cUJaSlJNUzZpM1Z5?=
 =?utf-8?B?Mno1WVBkQ1liL2hrUHE3SnExWXZ6bU1iVGFyMURSQnRFbkNLZjluSm5JYmhX?=
 =?utf-8?B?QlEzaytTY3hvUHBFaUErbFRpNVRya1JkcjRjRHoxTi9GYkVBSVkvTnJ0S1dY?=
 =?utf-8?B?VVVPMXB4am03cUJFdnN4K3l6T0NGWVdQMDdBbTF6WkJuVFdIdG8vYnhXUFBr?=
 =?utf-8?B?NHBRMkZqQy83UlhVZXhRNjJVd29VdzdMOEVxVmV3RFBUZmhpeEF4RzltaENu?=
 =?utf-8?B?OEpJcDlnQVBOejZxdnBIRDlVTW5hblA0ZCtzQTJlbWJXSXF5azhKakw0R0hQ?=
 =?utf-8?B?M3JLaEduOEcxQW10ZHR1OWJJSkJkc0tCOXJFT0NTWkROMjAzN1p6d0YreFdv?=
 =?utf-8?B?SExxUWw2d2pSdjRXQ2lmb3lzNUR3RERZOWhXZzdBeFBiSFJ4Qm1NYnVGK1dt?=
 =?utf-8?B?Njg1cllvUEgrZ2dmSzluUEwwbHdhcXdBUHloVUhFb3NCb3JiZFU4dWk5VnZH?=
 =?utf-8?B?eG5WNGExc3dZeGJNMVBCTVk0VlBuMm91dzhIN1NybzhjWDhqVFlIUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e95480a-b5c9-4665-95f3-08de4e9bbd00
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:53:13.3398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W//vgBS8LhRPXJyKyXEmkWRPu4taR2DwLXj2Kti7JcxU6nGCzRCviGTR2S4efrsiM3jrrzLeiMspg/0Jy+k/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9765
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

From: Peng Fan <peng.fan@nxp.com>

Sort header files following the order:
- generic-header
- asm/generic-header
- asm/arch/
- asm/mach-imx/

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx95_evk/imx95_evk.c | 2 +-
 board/freescale/imx95_evk/spl.c       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
index fe0111be508..ca1d916deab 100644
--- a/board/freescale/imx95_evk/imx95_evk.c
+++ b/board/freescale/imx95_evk/imx95_evk.c
@@ -3,8 +3,8 @@
  * Copyright 2025 NXP
  */
 
-#include <asm/arch/clock.h>
 #include <asm/gpio.h>
+#include <asm/arch/clock.h>
 #include <asm/mach-imx/sys_proto.h>
 
 int board_early_init_f(void)
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
index 48b47d2aed9..90c7429272b 100644
--- a/board/freescale/imx95_evk/spl.c
+++ b/board/freescale/imx95_evk/spl.c
@@ -3,15 +3,15 @@
  * Copyright 2025 NXP
  */
 
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+#include <asm/sections.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/mu.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/ele_api.h>
-#include <asm/sections.h>
-#include <hang.h>
-#include <init.h>
-#include <spl.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 

-- 
2.51.0

