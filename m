Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBE6C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 08:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B880C883DE;
	Wed, 19 Jun 2024 10:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="kITiMc6R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B1888415; Wed, 19 Jun 2024 10:21:59 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A8C883DE
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 10:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9SbimvAHdFtfmuQvQrQ1Ktgruf9fyEF6vpWU64reduymdGdEPqwEUjjxJBHB03+YcUDZ21EMXY2jMIKQBPki6+DKjpf7O9y8d62URbDVqMz76cRjfgS/dFdY4bSUabfR1pOPZryb6ICYkEUEJVAZKdD7DIMLsB0S6QluUZKvcg6BQITe7Qv7IXYI59QdysEsJajosYtIhMoEr9bzP5/weiQ4k8H2pUEbC2qwduFHQSfAD0X7IiZoPrMiGInfQkMGCyHPcOh05dRQRXhYAOs5hRH6CwV56hf0uCkHKIY2hLIt8aps8mN2tUQdEhmM4WHyx8ECgrqDuqPgyuBOuYroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KmyncX4kH0PVmFTAXJiaV2n7BQF/BvpVaPtPO4M3tM=;
 b=gLK1fwAPc5urUQOe4PFjbRUWUcGFE5fD2bNM0to5wxf1JInWzhXktNhdVSw5F62FX/prvc2GUK96RII/CvF+nrdvzIIr8Lbs+dN0QNgSj3fbM3MDC88fj6UjV5aK0lRRNCxley6rLAhFBtVcDV3Bfy9K7iUD+Anu+Do8rnuTk1wGVBO/RhphFEzo9RivPnBPosFI59vK1lrOZo94JyPO5Bbuv7wEQHAUXkH8wOGD7t9Xf/ZFowFnhz7QSQqXmnNWF40tGD0+8/54+2MJUfBZ6MlXKTU2R7wMx3YL6JTQHR+vrntjjZtnN9tc42otI53pMf/1DoeTIp+kAoET1HTJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KmyncX4kH0PVmFTAXJiaV2n7BQF/BvpVaPtPO4M3tM=;
 b=kITiMc6RCyB1MDmG5MN9FychyiZifsdhEQJZ/7ucUWVdgUdvGaB2eW1k6f+ylcmtJoB9weXugIzkMaRFcs3e9nzmEqCwee0EqEbGWuVg4WkOr5BNf55R4T8kwdCUL06nChV98VwOyWLbi6D+BrdkcF9inGlJE/yfzPxksi+gThE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS8PR10MB6625.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 08:21:55 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:21:54 +0000
Message-ID: <8eed077e-5855-4b32-8198-62b4f13c376a@prevas.dk>
Date: Wed, 19 Jun 2024 10:21:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/20] cyclic: Rise default CYCLIC_MAX_CPU_TIME_US to 5000
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Stefan Roese <sr@denx.de>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-12-51472eb70357@flygoat.com>
 <20240612160053.GS68077@bill-the-cat>
 <49522625-8663-4102-82aa-cabc0f239afa@app.fastmail.com>
 <20240612165048.GD68077@bill-the-cat>
 <e94995af-f9dd-4262-8dfb-2c47ab817e61@denx.de>
 <20240617232904.GL68077@bill-the-cat>
 <c50b3dc0-0385-4548-80ed-ffdc8623bfcc@app.fastmail.com>
 <20240618143159.GR68077@bill-the-cat>
 <CAJ+vNU1fifv8gi3MLV+qBk2-Q4aiZNG4Vwr=MgbfjZzMOAbvHA@mail.gmail.com>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAJ+vNU1fifv8gi3MLV+qBk2-Q4aiZNG4Vwr=MgbfjZzMOAbvHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::6)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS8PR10MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab47c99-c4d1-414c-9039-08dc9038e104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230037|366013|7416011|1800799021|41320700010;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUwvSG9VV3VxMzZMZFhUOTFYbWR2UTF0Qk5ySzZzdzUyZ1A4RTJFa1BEdkhW?=
 =?utf-8?B?elVkUHRmTVFkSzc2b3QvSUlKalMxSjVJTUhwa29YdEtGVy83NEFxc3hQMXQz?=
 =?utf-8?B?Rnp3VEI0K0xjQVJqZXBiWHplaXByR2N6dzZZU21QVm5Kd1ArOXdQMlJKTnVx?=
 =?utf-8?B?ZzdZeU52S25VdUlIRExsZVNJaTQ1SW10RVU1REk3SzhQVzV0MzBOOWs1QUJW?=
 =?utf-8?B?RERNdDlGK2xsdGRVYmZLR1Q1UEpTbW5wbE5UbHhhelQ1OE0raGg4b1oyMG44?=
 =?utf-8?B?QmJIc24wa01YTVhKdWhqcHVRSzZTeElZMU1yV1JMMlZkU09LVmFoMVFZVENX?=
 =?utf-8?B?Wi9OSElacTQzYmltRTgwZWFTZGNsYWwrWGRpRW1QQ2JNdkZLVTUzRVFsOHhI?=
 =?utf-8?B?QlhWWlkrQVJhR2c5bXhmT1JjUFJaQXFYWndJeTdZWDZoYW0yVmdzUUdreXNx?=
 =?utf-8?B?Wk9HUDlNL0UzdW5jVUJDeFF1YkYxbWdsalhoZUh0b1BXMnBvKzBLd1d1RE9j?=
 =?utf-8?B?akhaTmNCRzRGQ05kd3EvanF2bXY1eEZjQ3ZyeGZON1ArRG10ZEljNG9WM241?=
 =?utf-8?B?SGhTc2ZzQ05EYWdNTVl4SDFHZjVVZSsvdDJ0WnIzbkxwMWtkV21vTk03WE44?=
 =?utf-8?B?SlJnMzRoYjBiNG5ObWphRjE3NlZOOHB3eDFwNzBzRXRsOThZRWM2emtKazg4?=
 =?utf-8?B?UjlrWElFSDN4YnFMWUNiNGErOUMvdnd4M2VSdkVvQVY5aTBoRFJVOGJMaUUz?=
 =?utf-8?B?RHZFbGZDWUxSRjVQd0NBMStYYU1JTUVUUmdOVFpYQ2lNZjVrR0RRVG04V0h0?=
 =?utf-8?B?MW1KcGtvQVgzOU15QzJ4MHRaRS9sdVowMmtmR1RLTmJheFAzUGJKdmNBZS94?=
 =?utf-8?B?S3ZMVUo1SC9qSk5MUG00L3BDYlN5K0g5V2dTUGFQcXFCeSsxZ0JDY2FnOHQy?=
 =?utf-8?B?Y2xjQUk2cW5ubWtaR1VWN1kxUExVdjlBcWRXRjY3dGhMeFZKTjIrVVhJWmtJ?=
 =?utf-8?B?WDVwdlFJeSt1cVVDNjBWZlB0aldXYWtXZ3BuU21MbzdmWlhoV1Y5YmxEYU5R?=
 =?utf-8?B?R1dwY2hEeGQwaWtPakRwcDNPeTF3QUdEOEhnZ2p0dzhTVWtyblZvOG1EL1pr?=
 =?utf-8?B?RTVYZEdWL2tRZWNNbTJVYyttMGRyeklhT0R0TUFrS0dKR3U1bHllN0hlR2ZJ?=
 =?utf-8?B?TThuSCt0ZG5nNTNrUG9Gd2pFRmcxU1Z3ZG1CMHlPbTNEcnkyMXYwc3BkRmxZ?=
 =?utf-8?B?QXJtTVlZT0JldmRVZmhZUWhlNGptVHJzWUg0TDNiaFlaelVYdjlnQVVONUJU?=
 =?utf-8?B?cURXZDc3NmpQdU54V1RhcFdIRE4zSUI5eUxOSjdhVSt4NkZDWGlpM2VoSGtW?=
 =?utf-8?B?UXFPS2VuRWZWRWhkSmtjNXFxdXR3bzZsUi9pdkh0K1FyMlNORTRhQlhrTEFB?=
 =?utf-8?B?WEE4S2I2L2c5OWpGNEJvbzRGV09EWTNjNDJUbk5Bd2ZpQjdtWnVzbFhxdUdo?=
 =?utf-8?B?eXpDNi8zejZHcjB1WmhrbVQ1MjhkblhBcnV1ekdGaUhNdmE1V1AreVRBY3NX?=
 =?utf-8?B?Ry9SUWNRRmpoMTB1YXdjelNHNVg0ZS9pL0h4T1R6b3czblF3czdJT2VMZE42?=
 =?utf-8?B?WnJWNHRhMUdIS2ZPaVBneHR6dTBkK2k0cklEWXlzY1hRdGo4T2h2NWRPM1pr?=
 =?utf-8?Q?soEeE75+lRnLbNEmTn4i?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(7416011)(1800799021)(41320700010); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDZmYkRXOGtzUysrOGUydk1oWmpGb0h6QmJpdmszaU9rOUZLYXZib0pySTE3?=
 =?utf-8?B?K0pOT2xvbWNVZEdXRU16SU42SUcyUFUya2lZYlFiZ25MYkQ5d2ZRK1lPcG5W?=
 =?utf-8?B?cml4U2Joc0JLODNiMnBFNmNDWVRjMHl4MkptWXBYWTk2eTY4YXBXcGYrRkdt?=
 =?utf-8?B?ZG1NbnFNWUJqRC9TNHZDUGViUDFUdGgyR0NwVHhJZnRCYzFja3M3amgzT3gr?=
 =?utf-8?B?aVQ5SGFkZUVhZG4wN1JITHJ2bDNsdFBXT2w0amJqY2MxSEVxcVczQ2FZUlBW?=
 =?utf-8?B?YmF2TVJLbnd4RjFkcHJQOHQ5Nk5xSDMxUENYdkVGaVppb1hUT21jcFpkZkNZ?=
 =?utf-8?B?eFdBUHpsYnNYT0dqejJ1cUwrQkN0ZGRNdWVkU3NQa2UvTWczSFlFeWI2azY0?=
 =?utf-8?B?TFZoNm9sMXZsVzFIZXlUZklYdWQrWlovamlDNkNJSXdEcG5RbEQ0dG8zTVJO?=
 =?utf-8?B?bE5VZVpKMGZ1WWZkWGdqMmJ4TURPekJrTkpqODF5b1hLdUpXaHBsU2I1ZGFS?=
 =?utf-8?B?UnhQSXh4RFByUGxHZWRGNzdRRmRHYWRJdVFXeVFHSG9LRXoxUGJTVlViT3ZP?=
 =?utf-8?B?bjZxOUMyQjY1YVdJemxIcHJ6YjQ2VWVOMDE5ZGFZVDdoWU81MXNCYU1hdy9F?=
 =?utf-8?B?MkhZeFpXenZkcVlOcFdLWFB0bzErekNXVnZWUFJONzhKRHhyTnc2aWt3cERD?=
 =?utf-8?B?VDlOdDZ3WE55dld6NU14QjR0R0g2SENpVklHT3NPMkZzbmg3Q1JqcHpRb3I1?=
 =?utf-8?B?V2MvR09DelhFbVZ3aXEwemxLaTIxR0lmSmd3aFpEWERUTUZNbHZuTUd6VjZm?=
 =?utf-8?B?QTVIQXFxMGx2Ny9KbHU1QzhUVnJUdmlCQXhRN1NPa2paUDY5enpXWEFqVTJo?=
 =?utf-8?B?WjhmRW9xQTk0ZTRRbWNEMkkzZHB0QllpUk13RnhiVERab2txWUVVRiszdlM0?=
 =?utf-8?B?RlBuZTBZdXp5dGowUnJPMHVFdlFsQXFMcDJURkFBSzlsU0ttcUhqSUg3ZVBk?=
 =?utf-8?B?UXBhLzVMZGFnTWhaTlB5eWN5bDBQbGZQS3pXVWFiNi84MWxTR3hyM3BBM1BT?=
 =?utf-8?B?Z0xQNXhjSGo0ZjFhWmpjMXU5SzJURDlqSEE0Zy9kTkhQZHlBZzhvbDMxdFp3?=
 =?utf-8?B?WWs5SXg0SFczVHN1Q2VWTm5DUjlCRjY2VXcyOVlNaXVTVWQrNWRRM3FZT2R5?=
 =?utf-8?B?djJ1V0xzMXF5S055UUJpRVcxYU41NTNSc29VV1pRelpqQmU0NFFVUkdUMUQ5?=
 =?utf-8?B?aThWYlZ6WnBkUXhBWFNzckFSVWk3MWE5ejJhTlZpSldCN0g0ZElmQUpUY3Z6?=
 =?utf-8?B?aGFGeVVYWThEdEg3T3E0Q2hZZUZFS0oxTFRyRDNMR3VwUDdzMHhlUHkrRUNa?=
 =?utf-8?B?MStIT1J0bGt5UEYvRW14VlY3VkNWYTl2REhCSHVlWTNlajBZTW9RZVB2OTVR?=
 =?utf-8?B?S0l1QkpDVDREMFBVODl5RVQ3QUhsUEtjSkNIcTBSWnBMZGZBL25jbXBSNFNZ?=
 =?utf-8?B?VGkrdUc2M0JhbkUxQUhsTlBkQzg2Z05admF2T1psRmFFY09jbkFVb2lvbVFS?=
 =?utf-8?B?ZTR0VVdKUmZ2WnRtcGx1LzdYTlFXSGY5UW5KZU52R3QvcytseVk2RisxOTNX?=
 =?utf-8?B?Q2k4Vm1jNzdUQUxHSjZYSVdvaFhWNXM0c1NrWElMRU1Zb3lScDRxVFBUZm5W?=
 =?utf-8?B?MDdPbUxJTnNqZ2gyMnAvTW1PWmpVYnN2ellkckNvakZQYjdHRmE0YnNDQ2Fy?=
 =?utf-8?B?OTJQNUlqVHdrMGlGMTk1RVdvUEdwV3l5KzBVVmNBalNrb3c3ZFN2ZlZ3SGNO?=
 =?utf-8?B?Yk43MzhJVGFHczJ4d0g3YysvVkhaT0pMazB5NWtoUk5LSkVmSmdpbmRJc3A2?=
 =?utf-8?B?OE9kdEthL2M2Z0tEL2F0QjIrdHFMUWx6bnZNS3JyNGdHT1NIZFU4TGM2UkNz?=
 =?utf-8?B?VEJwZ3E0UFEvQ2VrbzR4MjZ1T3hVdHd1VjlhQUZmSWk4MzhXRGZ3elB5T0lN?=
 =?utf-8?B?SzV2NzkrNGsyalZnUWJFYWthdGVKKzJWMGlUam5Qb0N6RXA2SWo4TTBLZUN2?=
 =?utf-8?B?bStDYjQyTlRuTWFNbXE1SDVhUjI1b3JGNFc5QkFWOURKT3FJZ3hISk1SS3hx?=
 =?utf-8?B?b2oxMXJCMm9JYVpmM2xkRXBORjlxSGdEMnF1RTEwZjhnSHBLNHk4cU9hY2xF?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab47c99-c4d1-414c-9039-08dc9038e104
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 08:21:54.8705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G06ptjENq8dsxSE1AdCvomqZAfvJnrRHL3tN7FTNgTkwD15B5Uce8GtEm6Y+oVoNtc64WN3rA9Vt6pI23oY9/wUsEGCcS30lWjlBD0yjANQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6625
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

On 18/06/2024 23.03, Tim Harvey wrote:
> On Tue, Jun 18, 2024 at 7:32 AM Tom Rini <trini@konsulko.com> wrote:
>>

> Stefan and Tom,
> 
> I'm seeing CI issues here even with 5000us [1]:
> host bind 0 /tmp/sandbox/persistent-cyclic function wdt-gpio-level
> took too long: 5368us vs 5000us max

Yes, 5ms is way too little when you're not the only thing running on the
cpu, which is why I went with 100ms.

Random thoughts and questions:

(1) Do we have any way to programmatically grab all the logs from azure
CI, so we can get some kind of objective statistics on the number after
"took too long:". Clicking through the web interface and randomly
searching is too painful.

It would also be helpful to know what percentage of CI runs have failed
due to that, versus due to some genuine error.

(2) I considered a patch that just added a

  default $something big if SANDBOX

to config CYCLIC_MAX_CPU_TIME_US, but since the problem also hit qemu, I
dropped that. But, if my patch is too ugly (and I might tend to think
that myself...), perhaps at least this would be an added improvement
over the generic bump to 5000us.

(3) I also thought that perhaps for sandbox, we should simply measure
the time using clock_gettime(CLOCK_PROCESS_CPUTIME_ID), instead of
wallclock time. But it's a little ugly to implement since the "now"
variable is both used to decide if its time to run the callback, and as
a starting point for measuring cpu time, and we probably still want the
"is it time" to be measured on wallclock and not however much cpu-time
the u-boot process has been given. Or maybe we don't, and
CLOCK_PROCESS_CPUTIME_ID would simply be a better backend for
os_get_nsec(). Sure, time in the sandbox would progress slower than on
the host, but does that actually matter?

(4) Btw., what kind of clock tick do we even get when run under qemu? I
don't have much experience with qemu, but from quick googling it seems
that -icount would be interesting. Also see
https://github.com/zephyrproject-rtos/zephyr/issues/14173 . From quick
reading it seems there were some issues back in 2019, but that today it
mostly works for them, except some SMP issues (that are certainly not
relevant to U-Boot).

The current situation is a frustrating waste of developer and maintainer
time and CI resources.

Rasmus

