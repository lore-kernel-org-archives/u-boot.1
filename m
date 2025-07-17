Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C9C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 04:09:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7009283278;
	Thu, 17 Jul 2025 06:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Cv9yqJcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B113E831E1; Thu, 17 Jul 2025 06:09:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C38A831E1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 06:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1jWSw4zHwZ/9q6vIlGQwdqcvdKkOzFI41MK89ebWC1QhC0GnTwM5YQenJj/9S3i//x4CQSn8c2UkVbvnco0stDghRvVJxvF+EKwlP2Mfz0qtbqxdV5ECXI70LpVpWftIzvJigQ98wwhlHcrlEN+YtRZp1k9dvC59LpvxrgtAz4AlaFgO2y7zs9Eu/IcBKYvoq8JQoj4B3nq2uyCnVmDQU5XCAHTSkB7Iw0dqUJ/W26vkJGpkipBaMNaWJ/Bp5jl3VHIMCZkr3Z5x5O3fKMtRNxjQjCGy3sGM7pkQxVvOAJeX7wbPyilwvRLAywxCI+eFYYOaN5RimQ2pOa9ZE22Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPGm2oeZPMiHl6MzVAz9zQwuQH/YCFC+6aebvunKM5M=;
 b=rXbKxe7kQtc+qgAkhhz/SKzSILShUp3lBSO/EUC8xLAIT/xecN+Zp2XIxK0x01DA0fnVw8qK0gJCvJBLNZAsfNLMSzaCRGsKSFbDEK41xsWom9JRYQJf1uTYu0rThI1oFL0BqBhop+/srjIBRXK9ue7H0guj++vHVZ/2C+6H7h4bXTyokzj+y0QBzBwCfTzlLUfKyAUMW692NNw6U3gyZp0QEyhWxOamOl4QRn40IW/W/fNfZrymdnI/iul0+KSjQjBxt6Vmo70KOhBFKvrC4n2tb5McqfvsQSnVON39zkIWDz2r8fdYw3XwMxfsuLOOP3RB2TjRwYt/UBKK1q1zfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPGm2oeZPMiHl6MzVAz9zQwuQH/YCFC+6aebvunKM5M=;
 b=Cv9yqJcqE6Fqtqdp91ltic4i346Du+wSlWg5Edzi+XTcRmaUFE82qOsmHRepepzX7XM4r2IIdTbgXn3t6tmuUcLw8Yk2gvVZStqBo0jcpa2eczhaHCoKdQovFr/Odl4y9l/hevSGf2JfKypJ44n3LG7gqmL9Lc+vTQHvBtL+mwDIZ1ZWFAWmLKSMc8U5Qmeij2eDAfeQyq50WuStD46TDBY9fgkv9XUn+bBpCF+vUMT35dRcECShkPSzAan68pp9Lbwsoh2qaH3Sg9sUX9MGlbri49yLPUtgQsUGenwdDM1pXut77oWUxn1vCI5w3yP2KNwPdEM2MrshgaJZU++kpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10838.eurprd04.prod.outlook.com (2603:10a6:10:581::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 04:09:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 04:09:24 +0000
Date: Thu, 17 Jul 2025 13:19:49 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: =?utf-8?B?0KDQvtC80LDQvQ==?= <rour@inbox.ru>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: Set write protect for eMMC user area
Message-ID: <20250717051838.GA29110@nxa18884-linux>
References: <1752591846.189000915@f463.i.mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1752591846.189000915@f463.i.mail.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10838:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eea1703-6b7c-4a9d-e6b2-08ddc4e7b6df
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y01rVDBTRDcya2lWYUlYbFM4STJHd0h2THVJS1pGVysyb0V3RjgvRXdkTGkr?=
 =?utf-8?B?UW5OUWRqSWJuRWtzR0M4a0VkVWM1SjhIcW84Vm04Zkd3L1RBdEJUbzRMcHFK?=
 =?utf-8?B?MnNmaTlhL1oxcmU5eE1GUDlXMnd4aUpTMmJQRFI2RnFrYVBVYlNvVHBJNXAr?=
 =?utf-8?B?ZUlhcGVEa3lrNWJNeDljWlNiakJRbERNRGRXQzBJSlYxMUJtcCtMT0FBVnZO?=
 =?utf-8?B?NmNvWDZUOXRKdkptRzNkR2hlY3lkM01qSmlZdjd2Sm1jMmlYL0RPV2NkcU5V?=
 =?utf-8?B?VFpvWmRrb25MSmpKbnN4YiszYXdEQThNS2ZDYktLYTZXREFIZGhqK2tIWlVi?=
 =?utf-8?B?M01CaWd6THNKRm9yNFlibDR4YTVGVGFldUlwUnRvaGg3cDhIay9EYi9wV2dT?=
 =?utf-8?B?QVN1emxELzNNS2R6Rkx3NHMvYjVHZ1FlcGFXZEFsY2FUOGRYZXhxRkZFUzh6?=
 =?utf-8?B?RnhUZEhIME9yaFdONHJTVnEyWkluNkJvM291REsraTlkVUtMR3ZndjdzYzZu?=
 =?utf-8?B?YlFRNHFySytrVnN0MHhDM1RKdUd6Mlc0UEFVR2UyMjBOeWltMXU0Mi9UTVpP?=
 =?utf-8?B?dStkamJSZFZWMTZNNTBPYUErQXZQWk1vM0FpdUJ5TDJsK0p6MzhoV2Rid3ph?=
 =?utf-8?B?Z3I3KzUyMGVjUVd3c0dSWjdZdXZFL0NTOTBZUXkvRm05OFBoL2g2cHN6aVk5?=
 =?utf-8?B?TWxuODlDTTlOZEdzSFUzZHc1TldicVYyNG4yK2g2dThlQVErcVB6UGM2K01P?=
 =?utf-8?B?L21SRE44NmxOVmV5S25BRUdZbm05b0psT2E3LzdIOC9PSkM3eVI1bVR6L1Vh?=
 =?utf-8?B?TitjemFoZGZBZDVRdXcwbEFuWWNFVSt3cjhlN2xhMERqSWZNcFBPb2Uwb0RY?=
 =?utf-8?B?bmxnc1hjNUdhdEVCV3VIMXBlRUdnK3FJbEREcHBCWEZJczY2Y1piYUZJNnI1?=
 =?utf-8?B?Z20yMGh6Q1pISjBaWHhnZ3JhaE8wQlNzenBNZ1NvdEFjRlN5NmRnMXFPZ0gz?=
 =?utf-8?B?U2cwNzdPWk9jU2JHNk1ZaTE3eFdXb3BDR1JLK2pnd09wMG1OcFJDM2l6MDBW?=
 =?utf-8?B?WE8vT1h2YjUzZDJOUHl2U3R1SmsrVzNlOU16aUo0UHZiWVJQbTBqY2M1KzZo?=
 =?utf-8?B?M2V4Y2VRNHhSbHNLL1FYWE1URHZqUTZ6eFZJaVhmNlVHemRWRFJNMllub2VI?=
 =?utf-8?B?Z29hMkVmMnBNRVhvMDBQYmhKSGhlZE5SejF4cVRpVkpWeWFDMVp1aW1FcmFM?=
 =?utf-8?B?N2paREt0Q3pxTDYxbDhTVldYazN0ZTQ3SElTV1cwMFBZVW1ydUE2VTNDRWRN?=
 =?utf-8?B?aGZlcXhTeXlrdktyWVBXTkZraVpxQldQYWY2YmJWMlRlcnZjZURwaXJTT0do?=
 =?utf-8?B?dzg1ejVwVDYvMTdzSXhSeDYxS1ZQbnA1d055K0l1NTNSemtEZWdVcHhaL2R1?=
 =?utf-8?B?Ky9iQzAzSWJPbTlUMGI2Q0xTSVdWRy9DSWhXa0VwcFVkQkxqempSWCt3SEl4?=
 =?utf-8?B?Z0pVWlJiK09yQmkxT2RZckgvZ3hFTWI3ZXkvejllYjA0bjRTQzJKRXFCclJI?=
 =?utf-8?B?ak5qTFB6QmJob1hJa1pqVnJqbjBBNGppSk9ITk5XdEZ0bEtJbU1BVFo5ZU1z?=
 =?utf-8?B?UTYxc0RuN2N6aGdXN1dLUk8vYytnUEhEV0RtMmN0aW13VFNZZFkyMENaQ3lo?=
 =?utf-8?B?VXhSeHdoc0NITVlRMmRpRWthY25lcGZzYnNjRDZSRWd0cnJEdGZaTTh2d2hw?=
 =?utf-8?B?R3JFMC92bjU2MlZERm9QWURmM1VUL0FQa3pqelI5RGZvMSswRWp5bHZtTis5?=
 =?utf-8?B?NlBld1RaWEtKNUFURjhUVGxJSm1KMDBhM1ZZUXBWQ3FWMFBRRUg3UjNVWTJx?=
 =?utf-8?B?T2ZKSFJ2K1BlaUdQT0F0TzltMW1xdUlidmZpczd4dmVQTW9wOEUycFFBOXRq?=
 =?utf-8?B?YUdYNU1HMlYxYTc4T2s5RmNjUFJBamVvcUtOS05rQlJmNG5nczlkRjhmUFRn?=
 =?utf-8?B?NTlFU2krTktBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJoVkFLMVFKUHdIRVUwbFg1djRnU0paY3c0ek1RRUFUbHVMamtWTUtPems3?=
 =?utf-8?B?WUNtbVBMc2podDVHUmk3WVJYd202dHM4SFVHaGJyQ2pHZGdsZ2RaK2VTZ0U3?=
 =?utf-8?B?TkhjZDRmNkFnZVhSZFd5YWFiUFdvWkh4MnBtdDNNdUNrTHpiSTk4UEZNQXUv?=
 =?utf-8?B?YnZud2Q3ZHZjRDBDK2IwcTVLR0xRNEhvNklKSEJSSFJWV0VaK3FRN05WeTNr?=
 =?utf-8?B?bXhzaGpZck94QjhyQ0V4cEhtclBkcE5tQ2NLQVhCWkhaY1BlQnZGbnhLdk5o?=
 =?utf-8?B?cGNHSkU3MXozenQ3REg2eXBkdXI1bXB3WVNmSDFTTGhueVdnNCsza1A0aHBo?=
 =?utf-8?B?dVdLYTVkaDVtbVpJcjNCUkZYM1Z3SzNQNFBjU1BpTllnOVFpNVlkNjBjcFl5?=
 =?utf-8?B?RFNQbTE4MytncmJLNUZOeVY0QUh3QUJ6ZFUxSmtOTStmR21QVmNVZkc4bW9m?=
 =?utf-8?B?emdwNEVVT1QxR2w1Vm52QUI4Z3kweWttbXRvb2Npc0MzU1VsVVprMXczVGFU?=
 =?utf-8?B?TTBnT0ZwZEZJcU0vTnRjOEJQbFNLS21nTTl2Mk0yYzN0MTVHUDBnbmhQQ1g5?=
 =?utf-8?B?bWlWUGRjS1hOL2FpMCt2RWdrbHNibzhSYmxHY2pXa0ZLVVBTRWVUMXNRalpX?=
 =?utf-8?B?YlBtb0xZaERTN2Ntd1hJMUlIT241eCs1YTBOQk4rcUMwN1BWZllHTUY5aTFJ?=
 =?utf-8?B?c2ZVMGZaRUdtaE9uS1lnYUZ3WDhGem0wY1NJVFhRVTJnQmZESnNmQkxSNERY?=
 =?utf-8?B?dnVkU29YeERXNHJEbWJ2Z0NYWDJjNDYxTi9EQ083d0JSYVBMVUxINnd5ZHNt?=
 =?utf-8?B?UjJ1eGxacHRKWmQ2ekpjcFNaU1p5R1I2WXFFelRrdFU4cUF2d2lvUUI0SGtN?=
 =?utf-8?B?eC82cHVYUGJFV1RiWEc1RUR5bnJ4WVBQb0FPVnhaeEx6aDF4L2hJRkxIOWJy?=
 =?utf-8?B?RE1nSnZpL1JNOS9Rb1JGN2szWlJkbDB1ZUtyZTlBOUNsS0lWdUVwYzR1KzNl?=
 =?utf-8?B?M3E4OUEvWlB6bEVobGl4djFlcC9QdTQzMWJpbXlwa2x5WmV2R1d3OWF4OWc5?=
 =?utf-8?B?K3J1UDdxTld3NmM5WVpQSUpWcDA3Q3JLVTFqWU1KdHM4eGR0TS9weWh1MDZZ?=
 =?utf-8?B?Z3A0S1UxWDZ4WTQweTBvMDZwK2t6S1p6dHRwbmdPYjdxSUl1enNwNmRBd1R0?=
 =?utf-8?B?aUp1VDlBdVEvUVNGUUZWVEV4S0Fpd1hxcDI3M1AxRDJWK0c5MEQ5OUhwb1VW?=
 =?utf-8?B?TmhXUnZCOEQ0MXZRdWVyS2ZPZGhHN2hpYzRvaFMvZkxoUFZyTWhXYktISXRC?=
 =?utf-8?B?Y1lwTDZzd2RpL2ZtU0JNUCtoQ3hQcit4RFdDQ2tlNmxHV2FOQ3plQXozeTB1?=
 =?utf-8?B?V3lIRjU3R0ZhUVcyZW9qaXBBa3JYbDhpcC9JOHNoeHpCaGxYZEs1cnRzeGdF?=
 =?utf-8?B?S0hzQ3EydGdCbk00aGFTMDBBVEtROC9ETS95RWNSMjdtejY4OTNRNEpTU3RV?=
 =?utf-8?B?L1ZBVXNJaGRoSWFUeXNTb0NHTjZ1cTc3Q2M1SlNWMHBmOG1PY0J2b0xOZkN2?=
 =?utf-8?B?c2pUbkoxQ2x5Zzk4VnoreW1DbWI2eWhQcFV1cGQ2YkNYbU5KVXVNWDhEWGZY?=
 =?utf-8?B?SjlEKytOYTRrK001QUN3M1VKY1doQWEzeFdZVFZKL1dDZk14WktyZlRTdHRS?=
 =?utf-8?B?NlNtNC9QNTR3MUVDSko2QXpuTkUxTEpaZDkxYkF4OUd1bWNsSk0zQ3I4Zkd5?=
 =?utf-8?B?SjV0MXlVblVXL2ZZWUdPYmgzTUkrOUJoTG5CRm5qci9OWlU0K0h0bGRTTDBj?=
 =?utf-8?B?aDVVVjF5YWtQTXdOaExKNFQ5ci9WcjQwazQ1dmFjN2pQZ3hTUG1jNXZOcnZt?=
 =?utf-8?B?dVk4c3ZobHNMc3BxbDJrUVRkUWdydzEvVkFPcGtReDdDU0VDLzdGbFNtdFMr?=
 =?utf-8?B?Q2tpVngreklBT3FEMkZ6SCtOVitNNjVIOUFCN3BOR1NIU2dXaUZUTVdwRWpS?=
 =?utf-8?B?b1I1ZXNnekZaSmVZQTlQTktrQ0R3WnhyRmdOUzJYQ3JKSUJQRitmd3lqM2ZD?=
 =?utf-8?B?SWNIZ2ZBWm1QOWNWeVZFQllHNkxxbWh2aG4yVTZBbW9XeU9pSkNqck5HekI2?=
 =?utf-8?Q?NatzvEJdhuCaA7PP+VksAaSkx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eea1703-6b7c-4a9d-e6b2-08ddc4e7b6df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 04:09:24.4394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jtOBh5pFJjyM0v+DrN4DSifQOBXTH1CNJTJUaMgR2UxEQWAziGEzwHJTDDpnbTbAgfkJ8LXkP2b2GywGV+XJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10838
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

On Tue, Jul 15, 2025 at 06:04:07PM +0300, Роман wrote:
>
>From 29246e776674a73e4dd93ee15f7c94cb5d99a797 Mon Sep 17 00:00:00 2001
>From: Urovsky R <urovsky@swemel.ru>
>Date: Sat, 12 Jul 2025 19:29:53 +0300
>Subject: [PATCH] mmc: Set write protect for eMMC user area
> 
>Set write protect configuration for the specified region of the user area for the device.
>Available modes for region are: 'none', 'temp', 'poweron'.
>'perm' mode not realized. You better use mmc-utils from Linux for that mode.
>The idea and most of the source code take from project "mmc-utils"

Please explain a bit here why you wanna introduce this in U-Boot and
the benefit.

> 
>Signed-off-by: Urovsky Roman <rour@inbox.ru>
>---
> cmd/mmc.c         | 373 ++++++++++++++++++++++++++++++++++++++++++++++
> drivers/mmc/mmc.c |   2 +-
> include/mmc.h     |  16 ++

Please also update doc/usage/cmd/mmc.rst

> 3 files changed, 390 insertions(+), 1 deletion(-)
> 
>diff --git a/cmd/mmc.c b/cmd/mmc.c
>index 5340a58be8e..d8c6def4a1a 100644
>--- a/cmd/mmc.c
>+++ b/cmd/mmc.c
>@@ -18,6 +18,26 @@
> #include <vsprintf.h>
> #include <linux/ctype.h>
> 
>+extern int mmc_poll_for_busy(struct mmc *mmc, int timeout_ms);
>+extern int mmc_send_cmd_retry(struct mmc *mmc, struct mmc_cmd *cmd, struct mmc_data *data, uint retries);

This is in mmc_private.h, please not use extern and run checkpatch.pl for your
patch.

To add write protect, need put code under drivers/mmc/ and export API to
cmd/mmc.c

>+
>+#define WP_BLKS_PER_QUERY 32
>+
>+#define WPTYPE_NONE 0
>+#define WPTYPE_TEMP 1
>+#define WPTYPE_PWRON 2
>+#define WPTYPE_PERM 3
>+
>+static int do_writeprotect_user_get(void);
>+static int do_writeprotect_user_set(int argc, char *const argv[]);
>+
>+static char *prot_desc[] = {
>+        "No",
>+        "Temporary",
>+        "Power-on",
>+        "Permanent"
>+};
>+
> static int curr_device = -1;
> 
> static void print_mmcinfo(struct mmc *mmc)
>@@ -1228,10 +1248,33 @@ static int do_mmc_reg(struct cmd_tbl *cmdtp, int flag,
> }
> #endif
> 
>+int do_mmc_user_wp(struct cmd_tbl *cmdtp, int flag,
>+                   int argc, char * const argv[])
>+{
>+    int err;
>+/*
>+    printf("argc = %d\n", argc);
>+    for (int i = 0; i < argc; i++) {
>+        printf("argv[%d] = %s\n", i, argv[i]);
>+    }
>+*/

Drop this.

>+    if ( argc >= 2 ) {
>+        err = do_writeprotect_user_set(argc, argv);
>+
>+        if (err)
>+            return CMD_RET_FAILURE;
>+    }
>+
>+    do_writeprotect_user_get();

check return value?

>+
>+    return CMD_RET_SUCCESS;
>+}
>+
> static struct cmd_tbl cmd_mmc[] = {
>     U_BOOT_CMD_MKENT(info, 1, 0, do_mmcinfo, "", ""),
>     U_BOOT_CMD_MKENT(read, 4, 1, do_mmc_read, "", ""),
>     U_BOOT_CMD_MKENT(wp, 2, 0, do_mmc_boot_wp, "", ""),
>+    U_BOOT_CMD_MKENT(user-wp, 4, 0, do_mmc_user_wp, "", ""),
> #if CONFIG_IS_ENABLED(MMC_WRITE)
>     U_BOOT_CMD_MKENT(write, 4, 0, do_mmc_write, "", ""),
>     U_BOOT_CMD_MKENT(erase, 3, 0, do_mmc_erase, "", ""),
>@@ -1315,6 +1358,15 @@ U_BOOT_CMD(
>     "   PART - [0|1]\n"
>     "       : 0 - first boot partition, 1 - second boot partition\n"
>     "         if not assigned, write protect all boot partitions\n"
>+    "mmc user-wp - Get the write protect info for user area\n"
>+    "mmc user-wp [type] all - Set the write protect for the full region of the user area\n"
>+    "mmc user-wp [type] [start-block] [blocks] - Set the write protect for the specified region of the user area\n"
>+    "   type: \n"
>+    "      none  - Clear temporary write protection\n"
>+    "      temp  - Set temporary write protection\n"
>+    "      pwron - Set write protection until the next power on\n"
>+    "   start-block - specifies the first block of the protected area. 'all' - to protect all user area\n"
>+    "   blocks      - specifies the size of the protected area in blocks \n"
> #if CONFIG_IS_ENABLED(MMC_HW_PARTITIONING)
>     "mmc hwpartition <USER> <GP> <MODE> - does hardware partitioning\n"
>     "  arguments (sizes in 512-byte blocks):\n"
>@@ -1366,3 +1418,324 @@ U_BOOT_CMD(
>     "display MMC info",
>     "- display info of the current MMC device"
> );
>+
>+
>+static int get_wp_group_size_in_blks(u8 *ext_csd, u32 *size)
>+{
>+    u8 ext_csd_rev = ext_csd[EXT_CSD_REV];
>+
>+    if ((ext_csd_rev < 5) || (ext_csd[EXT_CSD_ERASE_GROUP_DEF] == 0)) {
>+        printf("EXT_CSD_REV = %d\n", ext_csd[EXT_CSD_REV]);
>+        printf("EXT_CSD_ERASE_GROUP_DEF = %d\n", ext_csd[EXT_CSD_ERASE_GROUP_DEF]);
>+        return 1;
>+    }
>+
>+    *size = ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] *
>+            ext_csd[EXT_CSD_HC_WP_GRP_SIZE] * 1024;

Add blank line.

>+    return 0;
>+}
>+
>+
>+static int send_write_protect_type(struct mmc *mmc, u32 blk_addr, u64 *group_bits)
>+{
>+    int ret = 0;
>+
>+    struct mmc_cmd cmd;
>+    struct mmc_data data;
>+
>+    u8 buf[8] = {0};
>+    u64 bits = 0;
>+    int x;
>+
>+

Extra blank line.

>+    /* Get the Card Status Register */
>+    cmd.cmdidx = MMC_SEND_WRITE_PROT_TYPE;
>+    cmd.resp_type = MMC_RSP_R1 | MMC_CMD_ADTC;
>+    cmd.cmdarg = blk_addr;
>+
>+    data.dest = (char *)buf;
>+    data.blocks = 1;
>+    data.blocksize = 8;
>+    data.flags = MMC_DATA_READ;
>+
>+    ret = mmc_send_cmd(mmc, &cmd, &data);
>+    if ( ret != 0 ) {
>+        printf("Error: mmc_send_cmd()\n");
>+        return 1;
>+    }
>+
>+
>+    for (x = 0; x < sizeof(buf); x++)
>+        bits |= (u64)(buf[7 - x]) << (x * 8);
>+    *group_bits = bits;
>+
>+    return 0;
>+}
>+
>+

Extra blank line.

Please cleanup your patch first and run checkpatch,
I will look into details on V2.

Thanks,
Peng
