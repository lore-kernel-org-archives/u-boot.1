Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195D7C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 06:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 400D280F96;
	Tue,  4 Mar 2025 07:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TiVZhbQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702B280FB6; Tue,  4 Mar 2025 07:00:32 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3D980F92
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 07:00:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2e8XYJvVx1lnUnKf5Lz2+clXuHOsxZJAaUauN8t8ioeOH6w4iJLUhxvJtmjntPORZYfflWF1MIGkz2Zl6cky4ym5zpMe4w7IXapW5EukiuLmdo++jcLg0iCgdrcpGF/S/2G3jwfxURsQVwPTPQcFziLTeZa3vuRufUyltZLWf49dhQjOiTWBZFDE80QtiEPsNKkHUtBbKiumms4cyvOiMCaHN5L4w0WZdVWROqm0di2J6HpyUb/ouFE8dFvUv2GDUJ1xpLhbOl6Ng5fRgrlh+UD90wJOtMLqfGrBT865TOhvWIDzyEdL9Ebhr/3CUkL+qRf5vyG8DDS6rsaicK76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOJo2Q1uQn2pPas885qihv0OAWS5RhpObDf0kdCHE7E=;
 b=bNdooqgt92X3zFqNwSfTnQ5qYro9H2j/YIq5Z98NPRkezzCMA8r9sah2W21GuHBXcbBliwj6QKkhpgozJu54P0kbX/+LC3FOIXnyRmxCBODMCO3lt7np3IbFPle5YEpquQ9F/Ppk7+rQFtVJUecjiu14JizI/j5Hg4y0eJLn4KtzvvTXyBVM23A1up6KuoDk57r62ZNX4IEMPiNXWysu3AfHPef2gZX096Y36jMwCtF+mtKNwGHm+laHqB9tDo8OLnbKHNHmE6mxpLm7sslZ4X6dAaXfNwOjlVSngXD9q8dXkCiaU5E5r57TH2FgESd4xZVSz0f4+5/vp19KYFZILg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOJo2Q1uQn2pPas885qihv0OAWS5RhpObDf0kdCHE7E=;
 b=TiVZhbQuKzuD8FeT2LJbRzeGs4i4i4YEXP/HLp259PPGrZB1p05aDGqd9xIimK6G9fsjA51KPGcb+pyZylcZy4tdGbQCnAmhMVta9ZLIXqkxDySBDhQ+5tLugzIKqoIj7anvBSP7s1OD6rMvUKtynQEMe5T4nS1qjE2iMhkqN2VObPPAs9u2NoaNki5rUd8Oo1aoi9F/Zy5kR6hAhK5HMI1Ze/aDVhkn8xvYUach1B6DSnKvXg4Dfrw9drNksWxUl2c+ZC+naDCn+IYSrzl5/uMaE2C57METrRzWXG/VOamVuQluldpI5/W111+ZX5xi9ZaECxZGK4bWYg/RqpEpQQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10752.eurprd04.prod.outlook.com (2603:10a6:150:203::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 06:00:26 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Tue, 4 Mar 2025
 06:00:26 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "sbabic@denx.de" <sbabic@denx.de>, 
 "festevam@gmail.com" <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "alpernebiyasak@gmail.com"
 <alpernebiyasak@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan
 <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtQQVRDSCB2MV0gbWFpbGJveDogYWRkIGkuTVgg?=
 =?utf-8?Q?Messaging_Unit_(MU)_driver?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjFdIG1haWxib3g6IGFkZCBpLk1YIE1lc3NhZ2lu?=
 =?utf-8?Q?g_Unit_(MU)_driver?=
Thread-Index: AQHbi+/EHSBl4rFpxUeCNbOwfp0XDrNh12MAgABs9ICAAAZCgIAAJxbw
Date: Tue, 4 Mar 2025 06:00:25 +0000
Message-ID: <PAXPR04MB964472BBDAD65C0BE2271EC5E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250303035231.2680198-1-alice.guo@oss.nxp.com>
 <3f5b9ee6-0def-43c6-a312-6248db8c588b@denx.de>
 <PAXPR04MB96445643235AE5C18C2D8824E2C82@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <1081d31c-fd2d-4529-a651-5f5152d2b9ff@denx.de>
In-Reply-To: <1081d31c-fd2d-4529-a651-5f5152d2b9ff@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|GV1PR04MB10752:EE_
x-ms-office365-filtering-correlation-id: 5059a3d2-ff60-4115-397a-08dd5ae1dbec
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?M2RpWTgzYTlEb3FQYnZlclJGZ2RRSi9zbk5nbjdJc0lrZHg3c2ZtcUtSNDZl?=
 =?utf-8?B?bU5sZnJFUnlycGNuQVVqRjRQcFphaDRaRDQ0V05WajBJL2EvUGxHSjdoUVNa?=
 =?utf-8?B?bzBrbHlpbEMvTnZzc3VVZjgxMTlMQjFtMWlIVlc4cFhISk8yV2g5ai9UTk55?=
 =?utf-8?B?OUlwMEZxUHBPOUdSVWxPSnAwbk44MG0rYTM2Z1hIT3RZVXZqNkZoZGpNTjc3?=
 =?utf-8?B?Rm9odXdtelNURGh6d0hlSE4zcGtpSjE2T295TmREWkg5RVFOS0VheFFiZ2Fj?=
 =?utf-8?B?WGRnTkZNOUNpdEc4eTZoV2ZvbHpjTFgzaGNlUmFzQks4NVRzSVpKNlE0WXMx?=
 =?utf-8?B?TmNnb0MrV09nakRYSnJsMkdINFkrb2srS2xQNU9aTzZ6RnpWT0tJbTcrUmRM?=
 =?utf-8?B?c0tkOXgrQUdBc3NxWHFRaEhvNXQ2REdrNjdGRVFlUFNaZFdlOGYxdWlJTG13?=
 =?utf-8?B?dEdCaEJsUmY3bUZHUjB6QjBWL292NE5VdlRBR1FNcHJSbmRKWWVXV29kU25L?=
 =?utf-8?B?T0IyWHV4bmpJeXc0ejA5R0l3VnBsWlZRUCtCZGQ4R2RjVXRWWXZyQ2FPTmZx?=
 =?utf-8?B?Syt6WFE2UFJjMlJhT2N3WkNFSTM0OE1pZHBWdkhkaGl0WkNpUTBqR0ZuT1NM?=
 =?utf-8?B?S0tjSi9xUVZaZERnZXZ6ZXUvQ1NaWmY5N3lJbVV4SVVKdnllUU9XUlZ5UEFw?=
 =?utf-8?B?Sk80Y2thTWdSWkxVOC9TcHJVUGYxRjZjR2JwVm9lUTFLQTdrN2tYd1hFc0FN?=
 =?utf-8?B?SU9uMk8xUjN1WW5ZZUQyenpBdWpYVkJIZmFiVTdGSFFlTWRhSW1aNHNid28x?=
 =?utf-8?B?UDFDdCtIbGhzWDdOM2s0RGtVa2tEOWJULzBZeHJBYzZTaDFnOXJHMmhZUFJG?=
 =?utf-8?B?Rm9BbG9FaDNRbFNyWkNtY3ZzYjBST3FIR2lqS0FuVEt0eGw0R21yYmhLWlFs?=
 =?utf-8?B?SWx2M0gyQzdyZlNiSjVmNXVLOGdmT1VnYWVULzh0Ukg3M3ZscXc2aWNvcE1M?=
 =?utf-8?B?N3hiMHJZSzExOERMTmc2Q1U5cFcvL2JtVjg5QlZFdmhvYy9tWlF4N3UrWmFS?=
 =?utf-8?B?Y0J0cjZVVkIxTnhEVStxTjFoek9ZbmdFWXFrcjBmdEc4V2VaSUZ0U0ZuWWtv?=
 =?utf-8?B?cDVsZTEzSGxLaXVsamN4WjJCNDVtSlMxbDZVR0pxN2t6b2ZLVXFmQ3BhY1Js?=
 =?utf-8?B?QlhucWk5MTNQdUFjZU5aMkxwdXVaVVFkd2hEZXpvcnlhbnMrQTNYWE9pbXht?=
 =?utf-8?B?ZHByeW1IVHFnc2ZsNGtjU3p3b1JEQkZYeVZIdkw0UzNzWVF6aVBiNmFWU0J2?=
 =?utf-8?B?YXp3TzgvalhxOEhVMVBoVGkzdkhEdUxabUI0eE5vUWlhMmJzU0E0TlVONTV6?=
 =?utf-8?B?VU5LN2RBNWNzNzhNdC9SQ281LzhWV2NXeTBMWExmRDFubmZGMVJ0ZWJNZjNy?=
 =?utf-8?B?Mk53MXJIRm9lc0FSYmJPM2dHVHgybXFNSHRWMkVYM2tFWEUrRGd4ZUkyUmlX?=
 =?utf-8?B?aHd4R1F1ZklzM2tzc1VKeHVQMFlBK2xNbXozdTZjNDd4Ny9TVW9lcDlmcE9w?=
 =?utf-8?B?UmxoK0NlYzM5M0tZV0YrQTRlb0tNbjJ0RkordXROUWJSZGY2cER0Vk1VOW5a?=
 =?utf-8?B?NFdPZjhtbmxGQkZkS0g5S3NRMmhIWmRyQ3cvZjNycHVIdit6U1hTLzREdnM4?=
 =?utf-8?B?My83MDQ2VUNVcjBpQnFYZzFHK2FwZnI5dGEzMEtoSHhZb0VCY3MxUXY1OW9s?=
 =?utf-8?B?MDU2ZGtMejh5VTVvMWhQKy9MMXBmVmdCL2xjLzBlWWFRdlJsbW9mQ09GU0g1?=
 =?utf-8?B?ZzNuUlVVUjFER1l2c3kzNXBFRjBTMVRoVHp5cWp6RGwxdHREZXB1ZTcxQ1FS?=
 =?utf-8?B?UzZweTRGVHI4dWd6NVVKcjdGeXN1Z0dlNENROVVLeS9KaXgrRzB5MWd6Tzkv?=
 =?utf-8?B?Z0E1MHNHa3JWd29uM3VIcnJmeDkyRDVoVm8yeDN2UlFMOGxoOHpSa1lxdjNh?=
 =?utf-8?B?Uk5HeVpIVXZRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWhDWkJwR1dTVVA3MEhjbDB4TFFCRkw1RWlQSFFGUkFIbERyWC9kTEU1Zllm?=
 =?utf-8?B?SHM1S1ErVnV6NGQ5eGZLcmwvUUo1bnR3WEg5Qk5ocmVTY2lkWUxjc2Y1bE05?=
 =?utf-8?B?dStTUGlRYm1QR1RFUCs3ZUs1UWNoZEhvM1Y1WWVlOTdUYS9tME9KV1JHMVdC?=
 =?utf-8?B?Z1RqVXlSWElRUXNOTlp1ZHNkYXd5SzZTdVh0dUdCbklJY2NwNFllMUZVbm5q?=
 =?utf-8?B?UXRLOEZSNkFCc29tYjRYdkVRYmk3Y3B4bTREelF6TEVWempaQ3VGRDNtZm1O?=
 =?utf-8?B?cTF6STh1TERVZ2RKSUhTdWt1MithakZndWxhRjRkVnFZZVlnSGY5b1gyVkZV?=
 =?utf-8?B?VEtXVmlZNEFub3hJUUVyOUdpOUdWelZQKzgxQkFyK2xZRDVhVjFXUkU2endN?=
 =?utf-8?B?ejBnSFhMSFRSYXFXTW84Zy9JbGIwa3FlMkdGUE9qd2ZrM1I5UG53N0xVQ0h6?=
 =?utf-8?B?MWV1WkQ3RDlDejlkYUJHMlZNV2xwSlR1U1RNM05TMHJFczV2NVZ5azZ1NnBQ?=
 =?utf-8?B?MzRyMExqaGRpTDYwWk80dTErN25ocTUxNlJ1b215U2ZnYk9teFVLbVJnUk90?=
 =?utf-8?B?bTladTZwbzh4eVZmYUt6dWNDSTdNYi9jb0Izb0RRTC9GMUZCTExWV05IeFAy?=
 =?utf-8?B?bVJ4YTd2Z2VHTUFGYmRHbGZQVkF3azhsUXVhb0lyMTYyQlg2MEVzVTg5MDNC?=
 =?utf-8?B?Q09sNE8rMDltYlI4NWJmNjl3eTh0Y25OYjI2RG9PaENxVGUzTFZNZkJHSFNG?=
 =?utf-8?B?TlpzTWtWMTU5am40T2dsM05RQmlVaFVPSW9xT3VFS0F4Z0hVN256dUZkWUgx?=
 =?utf-8?B?S21NUGg0ejYxcXlIelBjdEtNMDdnVk1iQzFOSFN2elpTREhVMWwwQU54QzU1?=
 =?utf-8?B?UVBLSTZlQWpsc0JncUJyeTdDaEwzRWM3RTJXTzhKOTVWeXVTakw4ckdhRHk1?=
 =?utf-8?B?N01RQzFkOTlzaTJRM1l4UUxXc1EzTW9RZ0czUGZuMC9Cd0w0OFZaRkpMTWhJ?=
 =?utf-8?B?UUJoeHUwdUJjakNidXFZZ3JlQ0VTMUNNR0FBVHYzYTUzNlpBUU1PZ3REendW?=
 =?utf-8?B?cDdmTkFsL3I0andudFVnNGE1YjMwbGlYVkxPSVpyVkptWmxpMldVZnA5SXlI?=
 =?utf-8?B?VnpxQmM3UG1VMkJWN1AzSWpBOFVHR0pkOG01eHhkSEt1YjBjeThVYVZCTFlJ?=
 =?utf-8?B?TmR3dW4xanAvZGxJbDNLNld5SjRKQ2xCTDF0d2N1Y3NSUjlMRDZFakpLbVMy?=
 =?utf-8?B?RXpIWG05KzVYR1VIRVVZZlYrdkN1ckV3UTN4aE9NUWhsWGgzOGZPWmt1R3dw?=
 =?utf-8?B?dnM2TkNydDZZZStWTVB3cUtXQ3F0MGVrcGJ3c2Ywb1Q0OXY0dUVZaGlIbmdY?=
 =?utf-8?B?bEFSdlBXdWNBM0h5MTlUelkxcHFkbkhucXp1T1EyVml6RWhkcDlJQlNnVDNQ?=
 =?utf-8?B?amFZMWxVb2hwQ3hNaHRxSVM4TlBGQk1vZTBKQVdiQUJRZWJ0ZjVUUG0zKzRJ?=
 =?utf-8?B?MEdyS2I1R043d0lJNnBFNnVBVG1COFZYR05tbHhZUGMwZEpOOWRYS1ZRV1Jo?=
 =?utf-8?B?dWpRUWRFVEwzdUgvbXNQUkZZUzNWQVF5ek5KYTZPU3RVMk41cjJJbFJsTzJW?=
 =?utf-8?B?QnE4ajkrM0lVeVpMY2kvRGwvaFVrRHVIOEo2Tjg1WUNYY0pKb3dnMG9XQXRN?=
 =?utf-8?B?SHBVU0ZUWDg3amcyV01ZUzl5ZnpNTlJvTE1IUFJkNU5kRkRaa2tJSXBFZFJY?=
 =?utf-8?B?NVhSdjQvQVZQV1dxVEVQOVZnTWJvTStXbDlMMnRtK1JJU2VVVkkrcjJrT3Z5?=
 =?utf-8?B?TlVHOWtGbTlNVmRUY2M0QkhpVzZUWlAyZk50NldqellyR1hQMHlocEtPRzFp?=
 =?utf-8?B?Ryt2OWZwZ2VKMktqb0lhaHhuQmUxeFVhUW5Da0hWb3VuYnRCUnBFcW1IdTdP?=
 =?utf-8?B?YjJNNnhubW40eWhOdGdTb3dleTlwZDAvei94RlRhamRYaXlBSkdhdTFtSTM4?=
 =?utf-8?B?R3N1emVzL3A0TUdmV0JpZ2t5em5GRXdBZThGUC9SVzZad25iMTN0WHkvY3JN?=
 =?utf-8?B?OW1jb2M3K0ZDbXpMZ2RZbjBoNUZHUHordHk1bHJJZENRR1ZuUzZheE45ZlNv?=
 =?utf-8?Q?rAcU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5059a3d2-ff60-4115-397a-08dd5ae1dbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 06:00:26.0275 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUCRQ5HIfF9933mwULVShN1Ksa1uaw72oRaE++/3/u32SdaFPcxgowiVmanSAsKCxh89EF0a7u6bg6AMMERaXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10752
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QGRlbnguZGU+DQo+IOWPkemAgeaXtumXtDogMjAyNeW5tDPmnIg05pelIDEwOjU4DQo+IOaUtuS7
tuS6ujogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyB0cmluaUBrb25z
dWxrby5jb207DQo+IHNiYWJpY0BkZW54LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IGRsLXVib290
LWlteCA8dWJvb3QtaW14QG54cC5jb20+Ow0KPiBsdWttYUBkZW54LmRlOyBzZWFuZ2EyQGdtYWls
LmNvbTsgc2pnQGNocm9taXVtLm9yZzsNCj4gYWxwZXJuZWJpeWFzYWtAZ21haWwuY29tDQo+IOaK
hOmAgTogdS1ib290QGxpc3RzLmRlbnguZGU7IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPjsg
VmlvcmVsIFN1bWFuDQo+IDx2aW9yZWwuc3VtYW5AbnhwLmNvbT47IFllIExpIDx5ZS5saUBueHAu
Y29tPg0KPiDkuLvpopg6IFJlOiDlm57lpI06IFtQQVRDSCB2MV0gbWFpbGJveDogYWRkIGkuTVgg
TWVzc2FnaW5nIFVuaXQgKE1VKSBkcml2ZXINCj4gDQo+IE9uIDMvNC8yNSAzOjM1IEFNLCBBbGlj
ZSBHdW8gKE9TUykgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiANCj4gPj4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IHVkZXZpY2VfaWQgaWRzW10gPSB7DQo+ID4+PiArCXsgLmNvbXBhdGlibGUgPSAiZnNs
LGlteDZzeC1tdSIsIC5kYXRhID0NCj4gKHVsb25nKSZpbXhfbXVfY2ZnX2lteDZzeCB9LA0KPiA+
Pj4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg3dWxwLW11IiwgLmRhdGEgPQ0KPiAodWxvbmcp
JmlteF9tdV9jZmdfaW14N3VscCB9LA0KPiA+Pj4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg4
dWxwLW11IiwgLmRhdGEgPQ0KPiAodWxvbmcpJmlteF9tdV9jZmdfaW14OHVscCB9LA0KPiA+Pj4g
Kwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXg5NS1tdSIsIC5kYXRhID0gKHVsb25nKSZpbXhfbXVf
Y2ZnX2lteDk1DQo+ID4+PiArfSwNCj4gPj4gV291bGRuJ3QgaXQgYmUgdXNlZnVsIHRvIGluY2x1
ZGUgYWxzbyBmc2wsaW14OTUtbXUtZWxlIGFuZA0KPiA+PiBmc2wsaW14OTUtbXUtdjJ4IGZvcg0K
PiA+PiBpTVg5NSA/IEVzcC4gdGhlIEVMRSBpcyBzb21ldGhpbmcgd2hpY2ggc3VyZWx5IGlzIHBy
ZXNlbnQgZHVlIHRvIHRoZQ0KPiA+PiBBSEFCIGNvbnRhaW5lciwgcmlnaHQgPw0KPiA+DQo+ID4g
VGhlIGNvbXBhdGlibGUgIiBmc2wsaW14OHVscC1tdSIgdXNlZCBieSBpLk1YOFVMUCBNVSBpcyBp
bmNvcnJlY3QuIFdpbGwNCj4gbW9kaWZ5IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiBP
Sw0KPiANCj4gPiBUaGUgZHJpdmVyIG9mIGkuTVg5NSBFTEUgTVUgaXMgaW4gZHJpdmVycy9taXNj
L2lteF9lbGUvZWxlX211LmMuDQo+IA0KPiBXaHkgZG9lcyBMaW51eCB1c2UgTVUgZHJpdmVyIGZv
ciB0aGUgRUxFICwgd2hpbGUgVS1Cb290IGhhcyBzb21lIHNlcGFyYXRlDQo+IGRyaXZlciA/DQoN
CkluIGRyaXZlcnMvZmlybXdhcmUvc2NtaS9tYWlsYm94X2FnZW50LmMsIHNvbWUgQVBJcyBwcm92
aWRlZCBieSBjb21tb24gbWFpbGJveCBmcmFtZXdvcmsgYXJlIHVzZWQuIFNvLCB0aGUgZHJpdmVy
IG9mIGkuTVggOTUgTVUgZm9yIFNDTUkgZXhjaGFuZ2VzIG5lZWRzIHRvIHVzZSBjb21tb24gbWFp
bGJveCBmcmFtZXdvcmsuDQoNCkluIGRyaXZlcnMvbWlzYy9pbXhfZWxlL2VsZV9hcGkuYywgQVBJ
cyBwcm92aWRlZCBieSBkcml2ZXJzL21pc2MvbWlzYy11Y2xhc3MuYyBhcmUgdXNlZC4gU28sIHRo
ZSBkcml2ZXIgb2YgaS5NWCBNVSBmb3IgRUxFIG5lZWRzIHRvIHVzZSBVQ0xBU1NfTUlTQy4NCg0K
PiA+IE5vIG5lZWQgdG8gYWRkIHRoZSBkcml2ZXIgZm9yIGkuTVg5NSBNVSBWMlggaW4gVS1Cb290
Lg0KPiANCj4gSG93IHNvID8NCg0KQmVjYXVzZSB3ZSBkbyBub3QgdXNlIGkuTVg5NSBNVSBWMlgg
aW4gVS1Cb290Lg0K
