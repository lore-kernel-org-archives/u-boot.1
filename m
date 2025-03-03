Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A3CC282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 08:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E939980F70;
	Mon,  3 Mar 2025 09:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="S5xNaZF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8883811C1; Mon,  3 Mar 2025 09:28:55 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06B6809A5
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 09:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TmFX9LzYs4Wnfmoi9AdAViuHrIeshk01uCNV2M7gBmDaTFA14VzrTCiSSVtWbcoa6PgI8h8X7ZdVkHf9murTrfYHRx8auZIRJ9DmBYi9sPSwdi+U8O7mlPskNaK3jeyQreHgh3ScyINw8ovE+2/p5vUv00Q+LB3GqGh/RiZAtOqVEUmq2fN0U6/kEKRxm0T6C3bR+x09ddPB6AfAF66sUkLrUth9KM0JLwjIX0Pw39GBo7FS1Zr26Qwz9CD4wJFSuhgP6O4tOR5Z23gCDkwXc7XFvTZtqu5lx4upElc32/Gebz4diSjw2jdDKXwCpMyb9d6AVmVMzbS3TZgas+W2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+4YWZbIg4cgLh7jeiSZvezLGtH7MiIy1xYr5rs7vJ0=;
 b=RJnpQv8do6ySWkyF5xvU1mAwjnj//4imDw0smFbGbiIZuxvMw2VgSNj+qAqQm8/yB9Gn/ReJeYjk7RSxOKu786lMcdbBLFF//Y8lsPNN1oHt6lZKVyPlk8Fu31nBUNerVWITFQc8KltuDsfFJNfSrnzwkrldzYdHZqPwCsLYBqJhPJB4W8f4UDbhUlvX5SxxNgHzir0dbYMeXELWmd7kf3o415LW65YBd9AJUNj/+BJlJfL/Fgj1TYbGh00G/35ACYG83eR7xc8LE7IC7Qosr1Poc873+4iBSsWGHapXcy8+bGYVci/UdZ8kJntCmbYVE99vHz7Z+f5RTgQOFWOAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+4YWZbIg4cgLh7jeiSZvezLGtH7MiIy1xYr5rs7vJ0=;
 b=S5xNaZF3bRXsmsU9wGtQLr3smRjLALi/7y1UZI8bD+sNXK/bqozsV7eGi5DulbPLBBnjf0VTrKd1erD8c/u6f2dXEcTo4a4xyXmKebVCioLFNebb2SjUE9BJ7748xxTCF0ANGPNOibX0Imeftb8QECt7Xt1Da59RL1DyvRTDXrW9Kh9GPnQ5xW5KDRSmvr7pmpWRc31Eg1azvRazK4Q6yt+lgEqcVqzMCCU5tkRlJjWhZLbusbS687oFjx98+f/8BO2QfSP2bvoovUT4B2sDUeGl8gSPtbvQ26oAfZs10enK/mDThEnyXt2SjKgJ5mcucEkdp3sroMO0Bh2WEUXEzA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8694.eurprd04.prod.outlook.com (2603:10a6:10:2dd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 3 Mar
 2025 08:28:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Mon, 3 Mar 2025
 08:28:51 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHY2IDA0LzIwXSBmaXJtd2FyZTogc2NtaTogYWRkIHBp?=
 =?gb2312?Q?n_control_protocol_support_to_SCMI_agent?=
Thread-Topic: [PATCH v6 04/20] firmware: scmi: add pin control protocol
 support to SCMI agent
Thread-Index: AQHbic8vjXHA6Kjwk0Ob7A3oA5hGqLNdF0IAgAP84tA=
Date: Mon, 3 Mar 2025 08:28:51 +0000
Message-ID: <PAXPR04MB964446FD2AC5A2A63FEE98A4E2C92@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-4-09594e93cc9b@oss.nxp.com>
 <3f6bb0fa-0526-411c-b519-5bf601cadd38@denx.de>
In-Reply-To: <3f6bb0fa-0526-411c-b519-5bf601cadd38@denx.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DU2PR04MB8694:EE_
x-ms-office365-filtering-correlation-id: 66741fb8-69f8-4b47-7656-08dd5a2d6d8f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?gb2312?B?N0RiTC9GdlJ5S2pOdExhRk1tR1JmMllZWWRiZzlIeU5XbGdneVc1Rm9ycG9H?=
 =?gb2312?B?NndvM3Y5cUJUSnlxMTQwRk5HM0VOMkw3aVFOclZoWnVPczF1RGl3QjB6Snhl?=
 =?gb2312?B?UDRpUlcvMnpoTEJQc2RUS1dZL213SmY5VVRJZXErUTN2Tk5SL280SnZrWUN1?=
 =?gb2312?B?ZXo4UjBzYlRnWE0yYU1sVUI2ZjNsdEYwcEdzM2ZsQjM5Snh5dlBpRnNlYkZT?=
 =?gb2312?B?cWhCQzVoQUd5NzBtOVZJM0ViN3B0bk1QQll5MjYxRzN1NHlwUlJFeFkxMFBV?=
 =?gb2312?B?QTZXL09EKzV4L09oT2ZHOTFkNXhrN3FsamVLRTlkY3RKODlwRldXTnBhQUIz?=
 =?gb2312?B?bENIMmtMZGdIVnRUd1NJQVJTcWtzWC9OS2k3MU4rSHpIVmF4S2duSG1DNjd5?=
 =?gb2312?B?M0hlUzNpcmh4UURJNlZ5UWtJRXprWWozNWFqeGZ4ZUxlaGdNOERUV2ZwZHoy?=
 =?gb2312?B?U25FaStFT1FQN1hta2piWHBaRElSYWFQSXBBZlo5MmQyNk4vMzYyQ3NvcDRC?=
 =?gb2312?B?Q1c0Tmh6dCtPWlhBekZtSTBucVRxZzErWHFTaFFjNHNGdXZ6UXp5eVAxQXNs?=
 =?gb2312?B?czJRSDNlWnEzaktNa3VndnRaMGhSbXNiWUtRazk1ai9rSVNHUWhZTy9yRVZE?=
 =?gb2312?B?Vkl1NDQ2Y3JFdGtYMHQ4OHE2KzRxb2xNYllXV2JWWmRaZWRqcWFEVmxjTTdI?=
 =?gb2312?B?bkRwMUR1eWU0TXVMR0x2Wi91Qys5WVFQeTR0M2wrUzFYY1o3VU5QYldXUHpZ?=
 =?gb2312?B?ZWh4bWNIVkdBb2Fsb1FOOUNjazd6T1l0MW5kZ1IrQTB6V3ZxeVBtaXRheGxB?=
 =?gb2312?B?LzZYa0VFQjZ5TllnbUFtV055VWthRWc3a1AwQTlaZzIvT21BNWEzUFl3cmlD?=
 =?gb2312?B?eGZNVkNmSlJoYXdJMFNwK2ErQkVGblpPMEZTT3Rwa0FuQ1l4ekEwSjNQQmY1?=
 =?gb2312?B?K0lZb0JRVlZlciszUGNQdUlyU2JwVXE3TVdOak5RWW0xekM2b24zU1h5NlNQ?=
 =?gb2312?B?NjRCdUVTV2VWUmpLQ1hRUkthNG5SNFI5YnFqb0xCais1RXdsTGJwYmo1MFBP?=
 =?gb2312?B?QTVUWWpTRHVFN2x6Zkh4R0Q4UnN3SnFnNHRuajA4ZjR0dnFRb2pEVWtvajVy?=
 =?gb2312?B?OGw2aVhBaTNVN29DQnljUCtMUC9rOHJTVitNQUhjam5xZ2dzbVZOVkdSdWp3?=
 =?gb2312?B?VThXUUw4SDR5ZmFiczBERU92WDZGMTVwNHd2MkdaOXhaS25HeWhoNGZ5WDll?=
 =?gb2312?B?UEZZeVptYUtoc1BmRlhXRUV2eEp3c1Y2MUp1WHpxNUt6UFZQVFhNNE9yQ05i?=
 =?gb2312?B?N2x4cGk1d2xBVldkOUdub0E0Vm5URHpFR1p4OTY4MWJWUXVmeVdLbi9zRlJ5?=
 =?gb2312?B?aG9ta0E5SGc0ZllXZXE2NFhSUXRZMmI4YkhEZnNwL1dGWVdJRnBpSDc3Yi96?=
 =?gb2312?B?WTg4RVFSL1krZXJReXRUZHJlYkdmTlNTUSt2VFBESnh0TFpWT2FRQlptK0lD?=
 =?gb2312?B?eHVKL3dDa0pNMC9yTklOamZnNURVTWZBUE9uVmkyRkRNOVZzV0hZUTRLa1RC?=
 =?gb2312?B?d0R3TkN0QTRTaWVXZ3RiRVVOekNnWFdsd2p5WUJlalZ6cW1Pck8yRkFrdjZG?=
 =?gb2312?B?UzRzZG1aZ0dMQ0Fad2d2Nlh5RFl3YU1oUVNqYVZKRlRLQml6Mi9BYnpOdXoz?=
 =?gb2312?B?QlltdDNvOEIvaHlIa2dpWWVHYjMzQjJWdGdQalcrY0I0RlZlQnQ2VzVqODZx?=
 =?gb2312?B?V3NHZVo4dWo4Yk9NN3JZWGxxZlJWbzErcFJjd3BJcnN1K3dvYjRMcGYrZ3ZJ?=
 =?gb2312?B?TVRPSU1sd3YxMVZYUitOdVVhS3hkZGJpZE1HNmRDb2doU09ocFdVcnhvNFo2?=
 =?gb2312?B?VUl6cjNxNFlhNTZlNGpPUUlWK05MT1VnbUg3NDFGM2VqdC91Qmtsd1hpZlRz?=
 =?gb2312?B?OXhiTHlMaWZOS1h3UlN5WGpBb1Nzak1lUEd2dGxvb2d0RmZmNjc2TkR4WTky?=
 =?gb2312?B?bG13cFdYOCt3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NGVCK0dKRHlsSEdWSGhEblMxNHhxV2hHaXIyVTlVQ3d2QVFtSTRqaEtvWUha?=
 =?gb2312?B?aCtGMFpOR0xQQUxZeGFicUZqRlhrb2kzQlBaNUJ6WDR5RDZwUmdlTzNQUnBs?=
 =?gb2312?B?RnRxb1NsR0ZiS04xRjhmVk55Q3pKZ2pnZ0U3NVNLZ1o1VXpLdEdEcTJMTFM4?=
 =?gb2312?B?amtoaDhPTEFOVGZLYlBVVndBWW1Wb3Y3eDY5TENrZzRuSDFyR1hrcTE3Q243?=
 =?gb2312?B?M1R5dDd0MmlaOTJpYlRYdFJQN1l6cFA1YlNWdG9JRTVUUmY2YkdwQzhxcUF4?=
 =?gb2312?B?ZjZ3MkxYVjBib2JGREhsb3lScjBmNXdhVHVnQmZnN3FER1FsYVRTaGxRdTY2?=
 =?gb2312?B?bjNwZkpZZnRPK1RpSHNPbWRJdll6bjBNN3d4c0pDdnI1eks2YjFPMFF4K1lx?=
 =?gb2312?B?Tkp5MzNxNHNoTFhBSWxXUjhMSi9JdUdpQlNiK0llRTNCWngySkhYY3l5RkpX?=
 =?gb2312?B?QkhtaGhLWFQwZCt2Zm12cDQzU0xIVTNOTzFIeUttb2lmK0xLeU9KK2ZjNE5I?=
 =?gb2312?B?VGp1ZHZ5WU95ZmEzb1YyTEhzMlh2WUt4bFBtNEV2aVVVSE9GdmZUcXNvb0xZ?=
 =?gb2312?B?c01ZY2NNTDliRG92SWtpUkFOcVNDWWR4RmlsbktoRjhsS2FpZlBESGZybVZO?=
 =?gb2312?B?Y2R6SXR3QU5mUnN1M2N4NkV1K3d0RStEZkpVc3p0UEVzSkFYaHF6Qk90NHQv?=
 =?gb2312?B?dzFUbXVuWXZTRlU5eHlDeER3SyszdldyWkNQVlh1RnBWT2cyUFNmUUpvU2Z1?=
 =?gb2312?B?TE9IeVN1NjdoQ0J0VDJkNFFKbWtMN1Rva1ZFbmpEOGxNWE0zVytmQXVEdzl6?=
 =?gb2312?B?Y1U5ejBGZTVXMzcwbStzN2tCUkdLSG51c2pYVnozK3ExdmNBOVllRVk2ZE05?=
 =?gb2312?B?QUFJRDF3REJPZkxUZVgyMUhCeWdDSFJsQ1VvOFhyQithMmtocS9ZMHFmVWFI?=
 =?gb2312?B?RnBOSXg4YkFKTjVzWXhCVG1JY0hydFExdmxRWHZmamxEKy9UR0hQbFcwTEVh?=
 =?gb2312?B?bnlUVWFRVmtSM0hvWEhlUkQva3VXcmE5bFNSZXRTaU51QWxMWi9VUG9nQWtu?=
 =?gb2312?B?Nm9VVVNuWWdadnJNRHZEWHNqMVVORkRZV0tnaFBrMWxxMlZkMCtIVklsUUZX?=
 =?gb2312?B?Q3VoQ3BLSFlnVDVOOENBdlliS294OTJoUHpxNHBmUFlVckY3ZUtaTUVrRGJ2?=
 =?gb2312?B?dHJybDRTOENSMkl2em1CU3RMSDBoQUthMTRURUVzdmNPWDRrYkcyd3h3eUpt?=
 =?gb2312?B?cjBXdWRnWWRObklOY2hiM0UyamVibXBjZGpHSnJhM2ljeDZ1MzdXUk9NQmdu?=
 =?gb2312?B?bFk3NTBiSHNuOFNjbUN2QzJ4OWptc3NvOFVmL0dTSmhYdTJQUklYZ0VDQlNL?=
 =?gb2312?B?ZHhDTy93S2RGZlVLNWpXOXlIRzVkRkFTMWhHRUpmRDRrQTNNWGNXVWx1VHJt?=
 =?gb2312?B?UG1LNjJwNUE0RlVXaWJUYXdSeFBqZjZsSVJhU0FWc0psUU1SOVVxaTVpUDMy?=
 =?gb2312?B?Y1NvUFBjc1hibmFMclB1dy9PNUNsaWhhUU8yZXVwWjNTem02OEFlbVhqQ0pu?=
 =?gb2312?B?SXJFMDR3d210VTdHdlAwejU1MUNDZEdWa0M2YnM5c0N5VlEvTFRsa3ZDVVk4?=
 =?gb2312?B?UWVmOGlMMnJBYUhzNUVYSDltSHNIUVFYNnF6N3ZRSVdxQmtNMGErOGlYdXVP?=
 =?gb2312?B?ekdmWHc2YVk1NXlSY3pNdDB2MjFqYVNoUWhuU1VCZWk2bURMcHo4a2hndXhn?=
 =?gb2312?B?VzlRMTEvL1lRRW84amtpWEdDaDZZQW1sUzRGMkFpRlNvaWxUU29sTlVJQTAv?=
 =?gb2312?B?aW1NMDhWSlBydXdacW9zSUIwdmhCNnU3QWtuWlU1RzJDNUhNY1ZWc2xIVG1T?=
 =?gb2312?B?Ukc5MjIzU2RHaG9vb1JOSERDcmNwN1YyUElId1VaY2hUQmlkOENSUVMvMmN6?=
 =?gb2312?B?RnR5VTlkak5vdDFLQm5kV2V3NVBnZDZGWkc4T2F3OVhQbk9VRnJTN3RhZ0th?=
 =?gb2312?B?WEhKQTdMUHJwYWFseXowV1E5MzJVUktRYjdpbXRwUWlOZmlhZHF3d3dHWkVG?=
 =?gb2312?B?KzFSYjRnKzhzYXVzS1FKUlZKS0pXRDIxaWt4dDAzZmwzVDUxWlFnQ0dObWxi?=
 =?gb2312?Q?Uj3ZJNHzCOiDgyqC+ltzFREE2?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66741fb8-69f8-4b47-7656-08dd5a2d6d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 08:28:51.4266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/MtG7Wh6OJQGPv6WFATXbxglN8LlvQvHK8W9VkbRlcwAAPtc3XE//XIPD+Ws7H3LVryt30V5HCl5X5/mkLL3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8694
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5k
ZT4NCj4gt6LLzcqxvOQ6IDIwMjXE6jPUwjHI1SAzOjE4DQo+IMrVvP7IyzogQWxpY2UgR3VvIChP
U1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBUb20gUmluaQ0KPiA8dHJpbmlAa29uc3Vsa28u
Y29tPjsgU3RlZmFubyBCYWJpYyA8c2JhYmljQGRlbnguZGU+OyBGYWJpbyBFc3RldmFtDQo+IDxm
ZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsgTHVr
YXN6DQo+IE1hamV3c2tpIDxsdWttYUBkZW54LmRlPjsgU2VhbiBBbmRlcnNvbiA8c2VhbmdhMkBn
bWFpbC5jb20+OyBTaW1vbg0KPiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz47IEFscGVyIE5lYmkg
WWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNvbT47DQo+IEFsaWNlIEd1byA8YWxpY2UuZ3Vv
QG54cC5jb20+DQo+ILOty806IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+INb3zOI6IFJlOiBbUEFU
Q0ggdjYgMDQvMjBdIGZpcm13YXJlOiBzY21pOiBhZGQgcGluIGNvbnRyb2wgcHJvdG9jb2wgc3Vw
cG9ydCB0bw0KPiBTQ01JIGFnZW50DQo+IA0KPiBPbiAyLzI4LzI1IDExOjUzIEFNLCBBbGljZSBH
dW8gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4N
Cj4gPg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBTQ01JIHBpbiBjb250cm9sIHByb3RvY29sIHN1cHBv
cnQgc28gdGhhdCB0aGUgcGluDQo+ID4gY29udHJvbGxlciBkcml2ZXIgYmFzZWQgb24gU0NNSSwg
c3VjaCBhcw0KPiA+IGRyaXZlcnMvcGluY3RybC9ueHAvcGluY3RybC1zY21pLmMsIGNhbiBiZSBi
b3VuZCB0byB0aGUgU0NNSSBhZ2VudA0KPiA+IGRldmljZSB3aG9zZSBwcm90b2NvbCBpZCBpcyAw
eDE5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZmlybXdhcmUvc2NtaS9zY21pX2FnZW50LXVjbGFz
cy5jIHwgMTEgKysrKysrKysrKysNCj4gPiAgIGluY2x1ZGUvc2NtaV9hZ2VudC11Y2xhc3MuaCAg
ICAgICAgICAgICAgIHwgIDIgKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvc2NtaS9zY21pX2Fn
ZW50LXVjbGFzcy5jDQo+ID4gYi9kcml2ZXJzL2Zpcm13YXJlL3NjbWkvc2NtaV9hZ2VudC11Y2xh
c3MuYw0KPiA+IGluZGV4IDhjOTA3YzNiMDMuLjVmMTAxZjRlZGUgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9maXJtd2FyZS9zY21pL3NjbWlfYWdlbnQtdWNsYXNzLmMNCj4gPiArKysgYi9kcml2
ZXJzL2Zpcm13YXJlL3NjbWkvc2NtaV9hZ2VudC11Y2xhc3MuYw0KPiA+IEBAIC05Nyw2ICs5Nyw5
IEBAIHN0cnVjdCB1ZGV2aWNlICpzY21pX2dldF9wcm90b2NvbChzdHJ1Y3QgdWRldmljZSAqZGV2
LA0KPiA+ICAgCWNhc2UgU0NNSV9QUk9UT0NPTF9JRF9WT0xUQUdFX0RPTUFJTjoNCj4gPiAgIAkJ
cHJvdG8gPSBwcml2LT52b2x0YWdlZG9tX2RldjsNCj4gPiAgIAkJYnJlYWs7DQo+ID4gKwljYXNl
IFNDTUlfUFJPVE9DT0xfSURfUElOQ1RSTDoNCj4gPiArCQlwcm90byA9IHByaXYtPnBpbmN0cmxf
ZGV2Ow0KPiA+ICsJCWJyZWFrOw0KPiA+ICAgCWRlZmF1bHQ6DQo+ID4gICAJCWRldl9lcnIoZGV2
LCAiUHJvdG9jb2wgbm90IHN1cHBvcnRlZFxuIik7DQo+ID4gICAJCXByb3RvID0gTlVMTDsNCj4g
PiBAQCAtMTQ3LDYgKzE1MCw5IEBAIHN0YXRpYyBpbnQgc2NtaV9hZGRfcHJvdG9jb2woc3RydWN0
IHVkZXZpY2UgKmRldiwNCj4gPiAgIAljYXNlIFNDTUlfUFJPVE9DT0xfSURfVk9MVEFHRV9ET01B
SU46DQo+ID4gICAJCXByaXYtPnZvbHRhZ2Vkb21fZGV2ID0gcHJvdG87DQo+ID4gICAJCWJyZWFr
Ow0KPiA+ICsJY2FzZSBTQ01JX1BST1RPQ09MX0lEX1BJTkNUUkw6DQo+ID4gKwkJcHJpdi0+cGlu
Y3RybF9kZXYgPSBwcm90bzsNCj4gPiArCQlicmVhazsNCj4gPiAgIAlkZWZhdWx0Og0KPiA+ICAg
CQlkZXZfZXJyKGRldiwgIlByb3RvY29sIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiA+ICAgCQlyZXR1
cm4gLUVQUk9UTzsNCj4gPiBAQCAtNDM2LDYgKzQ0MiwxMSBAQCBzdGF0aWMgaW50IHNjbWlfYmlu
ZF9wcm90b2NvbHMoc3RydWN0IHVkZXZpY2UgKmRldikNCj4gPiAgIAkJCQlkcnYgPSBETV9EUklW
RVJfR0VUKHNjbWlfdm9sdGFnZV9kb21haW4pOw0KPiA+ICAgCQkJfQ0KPiA+ICAgCQkJYnJlYWs7
DQo+ID4gKwkJY2FzZSBTQ01JX1BST1RPQ09MX0lEX1BJTkNUUkw6DQo+ID4gKwkJCWlmIChJU19F
TkFCTEVEKENPTkZJR19QSU5DVFJMX0lNWF9TQ01JKSAmJg0KPiBUaGlzIHJlYWxseSBzaG91bGRu
J3QgYmUgaW4gY29tbW9uIGNvZGUsIHNlZSBteSBwcmV2aW91cyBjb21tZW50IG9uIFY0IC4NCg0K
TW92ZSBkcml2ZXJzL3BpbmN0cmwvbnhwL3BpbmN0cmwtc2NtaS5jIHRvIGRyaXZlcnMvcGluY3Ry
bC9waW5jdHJsLXNjbWkuYy4gQ2hhbmdlIGl0cyBuYW1lIHRvICJzY21pX3BpbmN0cmwiLiBJZiB0
aGUgZ2VuZXJpYyBzY21pLXBpbmN0cmwgZHJpdmVyIGlzIG5lZWRlZCBpbiB0aGUgZnV0dXJlLCBp
dCBjYW4gYmUgbWVyZ2VkIHdpdGggbXkgZHJpdmVyLg0KDQpJcyB0aGlzIE9LPw0KDQpCZXN0IFJl
Z2FyZHMsDQpBbGljZSBHdW8NCg0K
