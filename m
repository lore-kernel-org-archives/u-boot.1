Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19461C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381AD8309D;
	Tue, 15 Jul 2025 08:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kJbefYI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4F4830B3; Tue, 15 Jul 2025 08:41:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934C08307F
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGQg5sfx83xbxFAwIXoQicovuC7oNYxfBlY1WOZGv3cMoK0eJfJfJlU0XkOSQDKOEQF7epAxWuDzBC+FwCUFVs+cTa7slegkNi/6NIypNguJkKEtOfebJUH7KFTp66Gxy0Ya+bqPSm/nenaUjKMFNG29RmiTl5m51j9MnXuhnIG/xjAO3Wn2CxT2F8nbl8wlBOaeLwhSiVfxsOSt2VP4fXiL6c8R/994FLpJH2iGL4IRBv5QIcnK8jcSPlxO6n7B4nbCdKn6SBCq0pV7CsgeDmN51H31s6e1UvQO1Uj7IO49nPlaoVnUfR7H68ltiWOnY9dxPiP0/eeyhLHF50LTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvVoTm3wSNecXFDfHqcowIscPVATqHo89LcQ/6oa7uE=;
 b=ABMa+3izUEbQBb6ETRrvpo5czY7eYfA+v7fuWuFvlKugTMBNDB5AoBm1pU27WrgGvIvnjZ1YLvAKSwolKU6EzpY/2iI5+jgkHyOVr3GljXPM19q3f3PXixXvIGDnpL56ngZJHsqoG5M384VEt+eTg7ca5IK0ZLJnqO1rzXvJkZIpuCpQetHWZfZvYJZsR121EvVFZbfOvzjWryzQthdhi3fys0MwoUDbMCuFBNgiFOHEpRr+zIz0JgzK94pZABnwUJLEXDkkUS6t4rirhuwqVW3/Kq5aDmnBS9HYBTxO29o5RKWOFpiYQxTmY9mr9z9856GfAwWDeaRWa22L4Ww2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvVoTm3wSNecXFDfHqcowIscPVATqHo89LcQ/6oa7uE=;
 b=kJbefYI4LMV1FHumOxnIuo3q8VyUwnvKpN8jhmxHqye2wzczFrhNEjGHvYWdbmwdXtBuCtH1KLVKH0R15IVY9QVW7xD+dTlsDMd9wkKETH/GrBc0bxcV3lnsL4aCOXH2KupoqNRTQYE+IS8F0CLKob5TFJVEf4JcgM1f6oGsb3a4ue+luzW7rfKpHun+QtSODaByztAYNwv+ZuQbQn9HuYHQtn0Gh+a4OATPWHxn/a43jFFzeYC4cKw8PaK9Z1y2n0kAy6/KgQ5iaNxFmIhddEQkS3XOsggNnsSkDHG3mPZib7ZwFyqdmx48FOHvGOKD4HST4jz3D5v862oU92Ijcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 06:41:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:41:02 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 08 Jul 2025 04:42:55 +0800
Subject: [PATCH v2 3/4] spl: imx: Add support for new PQC container
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imx95b0-v1-3-01759e9c855f@oss.nxp.com>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
In-Reply-To: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: MA0PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::13) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6c2b75-689f-4ebe-0d7d-08ddc36a90b4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHlKZnY2K2RZYnJoZTQ1eU4xRE9JUDc0QS9CK3ZwTFFwQ2xqdHFzdEswZGJl?=
 =?utf-8?B?UEtxc3d6U3BZRHZaSmxGcjk4NFV6bEMxQ2hvOEx5a0RGU3JuNHZBUFFzTTBy?=
 =?utf-8?B?VFhjOHVhUWRzbFhmQ25sdDA3bnZ2dURWekd4ckxKYjNRSitUMmxmdjFoSUpj?=
 =?utf-8?B?UzZXd3V1K3J2b3NkVmdrV2crQVRsM1RUUUIySlI1VGF3WW5lRmkzUVBjSVRK?=
 =?utf-8?B?elQrZjYvRGRHdUR0Z1pQdjFQZ2U3ZEhnaXovWTVPaHdqSjlwbi8vZGo4OUVT?=
 =?utf-8?B?ZThwaDlwWjlVSERscnpHOGRHQjF6UmZ1Wnl1UmcyamxwRThzL0JNdjNjTXRJ?=
 =?utf-8?B?MysyZmlqSklGVk55TVJNWmJubzNBZFFXUU5vNk1KM25Gb2R3Q0pzT2JpSS9t?=
 =?utf-8?B?S1FERWtNN0c0VC82SW9FMjFPbjNpcjZZZ2tmK2J0LzRsOUs4bVlGVTVYSG1L?=
 =?utf-8?B?cmNmNlgwUDlSMlBoQ1JVTWY2d0JOVUdvUVNCUFlLRVhOV1hUaFRPL3Bndmdo?=
 =?utf-8?B?aWJXUDFoZmF4SjFVTWZIUDRORk5xRHArZyttTHE5ZnlUQkJwbTlIbGZDa0kv?=
 =?utf-8?B?ZG90K05TTWtXMy9xUEI0ZnR3U094UTl2VExBRFRDUEx2SGZidzQyckJWUkNa?=
 =?utf-8?B?NUgyT1JtRUk5KzVyRlJtSXdDa0VtL0ExNG5vY1NGTElDRVJaeEEwaFIzYmJU?=
 =?utf-8?B?ZlhPZHpyamZDRVAvandkUndLUGtXSFhPSUNEU0xBdjlweEdIQmxoNWJxMTdp?=
 =?utf-8?B?VFdpamd5UlZaU3p5alhTekV4VVBjOElhZFVsUUMvUW1oRkpJMkgvUUQ1dmM0?=
 =?utf-8?B?VWJvU2xjTkd2WjQ3aUNNeDducEJZeVI0SXREWjVXb2c0R3dJSTM5SmNIRTdQ?=
 =?utf-8?B?T2FldjdvYnpaS3ZlZ2tHK2lUbEJwNzFjMDF6TlVVeTh0QWh1TWpXWHMvMVRC?=
 =?utf-8?B?RTdwWjFUNmJNOVVNZTNZZXVWdDlkSWt1Zm5MbmdBdG4zRld3Vmp2UVJrTklp?=
 =?utf-8?B?Zkg1aTFFVWpKM1FXaEtTMUp0RFVPMGVkSDkwek9SMGdrbHB4N1RZZ0xMRnVX?=
 =?utf-8?B?N2FqOE0xZmVTZmVaek1VR2hVTXUvZURWNEp0Zk5MeFdzcGtNZXBOanZWUVVL?=
 =?utf-8?B?TE52cG56RW1SaUUyaWcweU9FWWh5RGZXUWo3ZkJkeDI0WG5oNi9paTFzVmpq?=
 =?utf-8?B?bUQrRHhpWDF6RWtPY1VNc3VXcEhHODNzREh2TUluSGhJV09tampZV0twWlZJ?=
 =?utf-8?B?c3BuUDREUlRvZFpKQlo4eG5BaG5UNHVBancveFJvcTlYeEVHcUhHckxkWGNk?=
 =?utf-8?B?UkMwMEdQWkY5MStRT0VTN0xBUEpWY0U2dlJDWGJNSUlnOHc1MWkvU2FpMzhF?=
 =?utf-8?B?N3pvOFYrL2NZZm81b2NxcHpXUnNNU09DenV1VjRlWWFVTmpPOG8wU00vdlVu?=
 =?utf-8?B?OUltN2YvZWN2aUZZSFJuS2pKQTZmdlFIZWdBeUp0Vm4wSWxGMEFJbXFPaUdk?=
 =?utf-8?B?RFdvL2dTWWNxQlA5S2dQMmNXMnJHZ1A4c01rSy9qamJYRzhubzdpK3VDUnhU?=
 =?utf-8?B?L0ZHcU5UeU5lYjUyTm1HMnRpOEVPQy9hY01lOWgxUXNwbEVBRVRrVkZNazZS?=
 =?utf-8?B?ZU5LY01tYktlT294Sm1rS2tpbyt2QjRJSmE4QjRUUFRNbElyVnN6a2JlelRh?=
 =?utf-8?B?anFvUzRrd0lnWkJubWVHczlFQ0NlbWFlVnQwbkY2VFhkZlNxcFJOREtjb2dQ?=
 =?utf-8?B?NnJXQTIvTUJYRjRGUHpDSGNHcHZFTkZ6RzFsNEZ0V3c3eWNLc2JTeUYxWXRm?=
 =?utf-8?B?bzVMRUNNdUE2ajRxaWs4ZCtER1pwVkxXRUQrWVQwaGh3bWdyR201aFJ0Z0ph?=
 =?utf-8?B?dFppcmEvdG1BUDNoSncrZWhFbCtoQXVqNGVOVk9KMlg3NG10QXVYYjJKcDd5?=
 =?utf-8?B?K2wzZWthWm93MlpqM3phSnQ5Z3pwZ0N1bmtoMnBJV3dudUNtY1NxT0t5c1kv?=
 =?utf-8?B?VmlCbVVacE1RPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXNleUF1c0pNSHFpakV3MmxZcm5pZ3d1bHlGaXpGUnJyUTh5WUV4M2R3dGZr?=
 =?utf-8?B?K3RhR0gwMGExMUt1UWw4UW9VVXJSZWwwTjVEdkJMeWhia0hGTFVJZjAzVmNS?=
 =?utf-8?B?T1lQRHpWVEhVQjBpeTRoeHJDMU92cDV1dTVQR0RmcERXU3MyYWlBeXpSZXJi?=
 =?utf-8?B?UzJjb1YySC9xNXkxS1R4d0VvbGVYWlNKdTNsejV5N3Q1UVh4c0pUaFRXbVJT?=
 =?utf-8?B?TmpBSVJaNVhodHE2ekJOUFhXV2ZKN2tyaEE1c0J6NlQvamNDSGttQ2NZNUNH?=
 =?utf-8?B?eVRlbXdIeDFlWlYxYUN0R29UaC9QMTVzUUkzcXRTRUJZMERQWEJsRUQrTGI3?=
 =?utf-8?B?R2MwUVkyTTBSSmI1NVczSDdkRUtQVDJsZUpobDRGVTZNcS9TdTRQQitxdDAv?=
 =?utf-8?B?Yjg3T2lwSWxNNm03ajBmdm5WemRhL1pwdmp3TU9ucjM1TkFCT2xtSnZGQjZo?=
 =?utf-8?B?ODR5RVh6citTQU1xYzhWaW1RcEFqUk5KZERCT2ZGOGFCRUpZcEtqWkZaSHZU?=
 =?utf-8?B?ZkIxTXZyZG9GUE5wRlgrdXByZkhZdDlCVS83WFZRZGl5cURPTUEyampoOHFC?=
 =?utf-8?B?aVNjVUE2R2NCbHNicDJHdnVUbFdjbXZFUlkvRENIOVhMeGNieXNYMUVVSjBj?=
 =?utf-8?B?VG1lS0lKN2dpTnZ1bEhXdFVRcnJia0xzSG4yMVRYL1B6QlU3QS9zU0llRmRl?=
 =?utf-8?B?YzZVVkJXM1l4S1ZIeUkxTDYrVjJsTHhsZlZtL1IyN0hLMlcyL2NlUmI2ODFD?=
 =?utf-8?B?eFA3UjBUK0VKaENYYjJBUWxKcVZMbFNneVFvVWFXQXp1VTVJWWgvcE1BOHV5?=
 =?utf-8?B?T0JEeDZibERjZ1VFME1BNGppdzhsZFlFbG5FbVpORmtodk9OMWttdWRVWWVI?=
 =?utf-8?B?TUF0bkExeitBZDZnZVk3c3Z4NXBCbDVhTlNHVDU2WnduU2ZBMm5EMGhnVU1y?=
 =?utf-8?B?eUVOTlRKOGM0OCt5QUgwb1JZaDVIclN4VDhhOWdtUFZmbVlFc0lZQ1FTeGxl?=
 =?utf-8?B?bzBqLzFMTzYya0I0NTROQ0U0YUxOOHVJOGRrQmJ1dW1HS0htVnpaNmx0VXlk?=
 =?utf-8?B?MlpRdFdXSllodldMZUlNekI5RzRpWWNvSU5BZ1BxRCs4WklqOWFEbnBEeHc0?=
 =?utf-8?B?N3VpSWtIVVNaVXBnbTRpNlh1bWRVODR5TWhaelREYkh6T0pGZGpJa3BFN1k2?=
 =?utf-8?B?aXF4MlIyYnZjRWtPb3g3SzQyZDlwbzNLN0ZwRU1DaXhpM2VnZENnVW5ZamtV?=
 =?utf-8?B?dmtyOGI3SzR6YkVYcEhXOVVZMUE4cEQ1UGk5UTk2TTFTMUVGQ1lwNVgwMzZO?=
 =?utf-8?B?YnEwUVkvUm1XcHY4VUR1QjIyNWlaVGFUYTRVaVQyNVB3OFBaNG9wc3ZicWY5?=
 =?utf-8?B?aG16eU9vczRhdVBrZUdHS1VZbUZtZ0o1SHpNTThvbjlINzVPT092bUw4bjVQ?=
 =?utf-8?B?Sk01bTNVL01lb3ZDOGtpenlINHJWRjFLNS90WmtWbnROcjJsRjIzWENZZHF3?=
 =?utf-8?B?UWlURVBsQnFycUNNeUpaQ3JmcXBVdzFiYjB6L2Y1RU5QNDQ3WkhsMnlUY285?=
 =?utf-8?B?YjdCWXNIak9meGdsMFhhVTFuMExkUXh4Y3ZVb203WE13Q0lPYVJtWnhiOWtK?=
 =?utf-8?B?UVNCZnBPRXdPWFplVmorVVAySktnL0VQdzVlVkpwbmhyK1NpdnRlRnVCM3Js?=
 =?utf-8?B?dkxDY2ZKMzVyR0U2Ym1rZ3k0U3hHV2hMVTZ4cXdrNEVwQ1FOTjVJYVlUZVU4?=
 =?utf-8?B?a0RDUzNwNHhkZ3hJaUxZZ0ZrTzRXUmNDaG4zN2RiWmdnTjdPY21MQlU4T0hO?=
 =?utf-8?B?c3FiQmxydXJLZmoycytWcllzOVNmaE1COXBjQkE3N2tybGpvazh5VXUyRlda?=
 =?utf-8?B?SThxN01lNzd1U2tnVitTNHVLWDZVN0FiWEVNWEg3bnhmUXJOZGZXMzh1LzdM?=
 =?utf-8?B?ZlNtbVhCN2FjWDlleStNL1N3c1ptRDRZcWlGUTZwV3UvZ0lNRjBmNDk5VHJ5?=
 =?utf-8?B?VjErTGVoZy9oNXp4UXhYMGNWeXYvc0ZmN3YrWnVrS2lORU1Qb3kvZStZRmk0?=
 =?utf-8?B?UGVyUlJBT1NEVTJTbWhPd2tFcVFKSEVKZDRnWkhsTVR4cDUxNzg3K1hmY0pH?=
 =?utf-8?Q?+F29oXuNaeA2wHUPrVWdzJxlW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6c2b75-689f-4ebe-0d7d-08ddc36a90b4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 06:41:01.9717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4WvS9Yh9F1LzDUfAc7lMPipzIn4Ydb6e7WOemgz2cvIpAX4Nxe03i6Y9DC1qzThaK1YqdwqhV8lrlxU07pqkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370
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

From: Ye Li <ye.li@nxp.com>

To support PQC container format which is used for post quantum
authentication on new i.MX parts like i.MX94

The major changes compared to legacy container format is in
signature block, new container tag and version, and new alignment
of container header.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c |  2 +-
 common/spl/Kconfig                  |  7 +++++++
 include/imx_container.h             | 11 +++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index f84e23f4b2a..3a9e6dcf225 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -66,7 +66,7 @@ static bool is_v2x_fw_container(ulong addr)
 	struct boot_img_t *img_entry;
 
 	phdr = (struct container_hdr *)addr;
-	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+	if ((phdr->tag != 0x87 && phdr->tag != 0x82) || phdr->version != 0x0) {
 		debug("Wrong container header\n");
 		return false;
 	}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f69eff21107..ac25fcea21d 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -371,6 +371,13 @@ config SPL_IMX_CONTAINER_USE_TRAMPOLINE
 	help
 	  Enable SPL load reader to load data to a trampoline buffer.
 
+config IMX_PQC_SUPPORT
+	bool "Enable to support i.MX ROM PQC Container"
+	depends on SPL && SPL_LOAD_IMX_CONTAINER
+	help
+	  Support i.MX ROM new PQC container format. If your chip does not use
+	  PQC container, say 'n'.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/include/imx_container.h b/include/imx_container.h
index 691c764b3e5..684fc3bc988 100644
--- a/include/imx_container.h
+++ b/include/imx_container.h
@@ -12,7 +12,11 @@
 #define IV_MAX_LEN			32
 #define HASH_MAX_LEN			64
 
+#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
+#define CONTAINER_HDR_ALIGNMENT 0x4000
+#else
 #define CONTAINER_HDR_ALIGNMENT 0x400
+#endif
 #define CONTAINER_HDR_EMMC_OFFSET 0
 #define CONTAINER_HDR_MMCSD_OFFSET SZ_32K
 #define CONTAINER_HDR_QSPI_OFFSET SZ_4K
@@ -72,7 +76,14 @@ int get_container_size(ulong addr, u16 *header_length);
 
 static inline bool valid_container_hdr(struct container_hdr *container)
 {
+#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
+	return (container->tag == CONTAINER_HDR_TAG ||
+		container->tag == 0x82) &&
+		(container->version == CONTAINER_HDR_VERSION ||
+		 container->version == 0x2);
+#else
 	return container->tag == CONTAINER_HDR_TAG &&
 	       container->version == CONTAINER_HDR_VERSION;
+#endif
 }
 #endif

-- 
2.43.0

