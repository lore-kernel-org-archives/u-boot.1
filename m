Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1B8E64A8A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8975588875;
	Tue,  3 Dec 2024 14:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Uiq2HtTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BE358939E; Tue,  3 Dec 2024 14:16:45 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CDC885F7
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAS9nq/MoCJFxRlJytJWAD2lgehlKJaAvD01MUxf3vZmQH22t5/grKhyl+Mnmmj4FqvfULVe8nGe/NhqWeUUpUHaF4fAQybPXGPs3JQPZNN2/MxTlu6eOrgWnKxSfS4SaG5OEYvHoTkIil8uvyEAtf50LnJr9UtOMIP42vrlG4yVE9Keb7EKTyGjygNiLkS9gHkQzKTo5l6t4JvJkpv4zvQgwnCdHwJHgKlYFBs34OYqhC1tR1uqAYQxgJSNxd1y7Mimnh8RqTxcOrbt4nbC/DZSQckZ7eiIwqrJFCgV0i5JmikQ4C/hSqAq/+PTrHkG2l7UwEa389wxfATcpLD2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rqbnAR5qCZHTnFdlxCSWFrfIIrwlrO/f3MfKGNfAOtw=;
 b=JkIgQR1u9UztIsXquBgE4ZHafjpNupvmwau9558vmd5ZBTWyHyVs9JmtY1FatIxbn6PBg4FucdDRJt+0eFFSROLvYvE7Y7+ZJfjV6RnHEe4ifIuS86ciObLvRoIl4W4jkG5IVRaCFUQ3veOJGZo5wN0wdwAf84bpXmEqYekp7zAhp+ZKcf0r3r848SDr29RKym3pqBTgj1+5H4ILlS5atWw1opCvE3re2j7DnLv5J1LpR0gJx8D+CP7uC3aaIcheMYJSzPpEfHhcu21NopP0YFINOJNBXB0dhbjYBjM2V14mSFS8A4TtZv90Fr1RO823Wxb3ICTTDGGqCMIl1z4eRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqbnAR5qCZHTnFdlxCSWFrfIIrwlrO/f3MfKGNfAOtw=;
 b=Uiq2HtTURfQoM7PTTh30OQ1s74sfTx3IEvqs7KNs0NOLSNbcAZFsT4WCMmFAL3mtJTl4svVgCKJZO/jVvsuURgxM8wh2E8+Vfye6yzXOyBEC1XMg5ROy1pHZ6Pm1m8ROyrz6dkEOe3qo6AtFxwZb95j7LrT6fW0BfawP9+IDeup3NqdsgG2OGskDUIOioELG4cDVzVdGRashPrQUGXtMbLqeJlNTB6WJ7+BhaeYYRY+I7R1N+TCE0e+F5YKyn7/kcUlgxWk3Z8FRjgpUC4IVOK1Ce8Jg8tdJ3PnMW9jhUXBl753hgOifU9nxW/soSwVv/89ZJHWk6zYWQhyrcHZEXQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8193.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 13:16:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 13:16:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, Michal Simek
 <michal.simek@amd.com>
Subject: RE: [PATCH] smbios: address build warning
Thread-Topic: [PATCH] smbios: address build warning
Thread-Index: AQHbRYA/15qNKfd4Lk2r3JPyq1rkF7LUetiAgAAEuQA=
Date: Tue, 3 Dec 2024 13:16:36 +0000
Message-ID: <PAXPR04MB8459658B4CAE851F480965DD88362@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241203134257.5067-1-peng.fan@oss.nxp.com>
 <9211f24f-d406-4d57-820f-f5814fcd061b@gmx.de>
In-Reply-To: <9211f24f-d406-4d57-820f-f5814fcd061b@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8193:EE_
x-ms-office365-filtering-correlation-id: c633a738-b94a-45fb-b4e7-08dd139cb734
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eHYrcmtiYThrakttVkwrbzI3Yy82bXJQL0NyU2Faa1dETjhud1VVcldnd1F0?=
 =?utf-8?B?eE9IdDlOcTgvcDNPSFAzZ3RHQUF3VkRKZENmbXQ1RTllaGR1Nm1jMHQzOGRa?=
 =?utf-8?B?WE5kWkV3d2hDMGpoSzlEb0t1N1l3M1A1SU83K2g1STZGYW1sT1VPbUdvS2NH?=
 =?utf-8?B?d3FHNTlLaGg3Nm9zaWFGUUJLY0RobEpuN0FpNHd1VFNQcmVsNGtydGhubTdq?=
 =?utf-8?B?Y0NWMGtZNVBmTFNLR3lTWDltTXFib2VzS21IRjJRRy8wRGVGOVlySVVSbktX?=
 =?utf-8?B?L2hVNVAvMW94bGpxTFRzM2E2VGRMd1lBWnpjd29PaEZGTXByK00yVVoxdkNW?=
 =?utf-8?B?R1J2Tit5Z0FQTG81bXBBUFZPRFB5bDl1WGtRUXppNFpSZ29mV3NGS2xHUjk2?=
 =?utf-8?B?SzFjVmlCWTNZVk9zSDNBNnNQU1Z6Y1p6dGo1K2pzd2lSb0xsS1ljRmxNZSs4?=
 =?utf-8?B?SGJrcUI5b0xmbWZEUkUrdjNwb1V0aFBwZy9BS0gwT2lSeDB4TUI1L1FiTUJx?=
 =?utf-8?B?ODhMTXRYcWp3ZTcySHBhWlZCSzZHc0JGLzNvTFR3Q25MNmVvdGp5TWY1S3dH?=
 =?utf-8?B?U0taR0pDZUdWR2JrNnRnZ2VWWld5UzUwaTU0NUtBNWkzOGkyN0FwWUIwRVFT?=
 =?utf-8?B?eEVMMEFsRU80cWNzTmtmc2tVVFNUWWZvZlJyNFVNTDVjczRGRkpCWDdqeFJo?=
 =?utf-8?B?cG5ONjVWMnhsTU5pQW45OUkrRS81bFdXelRZejRPTTRsT1oxL3ZHb29ISXll?=
 =?utf-8?B?ZktIRXp0dVJvejJPN05ucEV3TDU1aTFMRkhRM0wxYnpGbFVBWnBSTW9uVkUz?=
 =?utf-8?B?TXVJV0dDSUNodHJHU2FUMFRNR3JEZmJUa2M2MFVkZGZKV0NJRUVFZVB2NG41?=
 =?utf-8?B?WjE0UHBGQ3hmS28wZnpURkVJVy9pOVM4NXpyKzR0eHZ3b0lFb2k0b3FmR2Rr?=
 =?utf-8?B?Sm9mdTdBSE42UXF5alQrdjFFdEJzdnhMVWJ4SEN1QUZZTzY0SE1FMWxyVE9j?=
 =?utf-8?B?OG5qTmtLenI1cXhYNDFwdkVPbVRXOS9rMFNqY1M3U1lyZzhsUzhGZDZqVWVq?=
 =?utf-8?B?WFpCYy9od1puWnpENndPdWp6QWF4cmF5T0J0QlZKWkVCc3pRcTFwdkVWN2ln?=
 =?utf-8?B?dWFWVEpYVUhZZnBDS09QbXFMSGp5Q3MwUWdQR0tlbFJpZEVzQStyamo1K2hH?=
 =?utf-8?B?T21PWlU1QU9BbEhnbUI2aVFIZUpKekExbTNWYmFxYjBaM012ZTYrdDIxTjVq?=
 =?utf-8?B?ckl0eFhrcG9pbnE0VFBqWkxzY0dUTng2bE13Z3p0cTBvUUxZRytUb1N2dVFw?=
 =?utf-8?B?L2pKMmZ6UVg4SGFxcHR4S0RMOUlIWk9GUjRqakh1d29weHkwdVlQcE5wME5B?=
 =?utf-8?B?b21kUVV4ZE5DMmNkZHpZRDhiNnZ0L01hYjIwTzUvN3ZkYjFzUFgyaUtrQ3l1?=
 =?utf-8?B?MnkyQ3kyZzFJOUk3QUx2dDU0YjRwNG90K3Rma2wwNVR2bXdUZWxYcjhJVEdV?=
 =?utf-8?B?ai9GRVFyTFBxVCtVdXJ0KzY0RHVXaW84MnNCZlRray9wOCtyTVZ1THhjZThQ?=
 =?utf-8?B?STNxNXg2eVRFOUVXSTQwbXVCZGRlR05ORGhKTDd4ekowRmw5OXk1QmtzWGxV?=
 =?utf-8?B?NU1uTEp6L08yUnhyVHhaaG1YNERMUEJYR1BnMXp6NFdWeFg0cHRjTldiQ3lQ?=
 =?utf-8?B?M0lGTEJqUTl6c3U1dlNSa05zRVdGQXNvbVB6YTQxaDdjNTJFYk5qRURIN2lW?=
 =?utf-8?B?anY5WENrSjRUeHIzWEJJeHFrOW9YSDBPNmc4aGk1eU1EY1BZSDlBSDZ1TW9k?=
 =?utf-8?B?NXp0WHJCMTZiYURjTXF1eUhFa2tWVWRWNkFzakg0TW80Nm5OYXlwQUxla0U3?=
 =?utf-8?B?bENZUjUzdFlVRFEwc25WOUpMUkFWWkRCNXBTVFRjWVgxbHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VqL1JUS1ZocVVHbEdESDBHRXVJc0ZhNExwNHd5WTFCdHBhMnRDL0hJWEsx?=
 =?utf-8?B?SE52d21tR3ZKYUFzekRUOC9IckFSb0VNckZOQnhYMit6L2NFSmVub2ZEZk9T?=
 =?utf-8?B?NExid0FRRlhnakZEL1ZhajY2alYrMU00VTdqSmlQMnU3YkI5RkdXQUQrU05N?=
 =?utf-8?B?Sitrenh4T3FoT3JWYUJIcFlwUmN6R3hYYmg0TlAwckV3OUo5djh4K0lSSjlj?=
 =?utf-8?B?RW9DTlZOWmNoUGlWOHJKcmpOY1BPV1BjbjhiZVd3VkRIUkUyT2tncUp2Uy9w?=
 =?utf-8?B?dURURkthNTNhNUpNNkxuN091dGI2eTdTOGdaOFo4R3J4ZzBYUnRnK1lDdW1Y?=
 =?utf-8?B?RjZjQkg3MmtVSnFDZ24rK0RWS2FYL2wvdG8xaXRpa3RrOWRlUi95dEZDeUxC?=
 =?utf-8?B?YmdoN1lESzVGVVRZd2ZvTWNuanVDN29xOVM0OTQzRmY2ZzdmZkk0TXRvNTR6?=
 =?utf-8?B?ZjdnRklyUjh6NlZBclFOMXpTVDhpZkpwSDlDWHUyZ0xCSjlGM3NiVTFHREcx?=
 =?utf-8?B?dWUyZlJOeW9CYkhWR2JWZ2NjaDhLaHBEb0U0NUUxVFRwYy9DVmJ6c2x3WU4y?=
 =?utf-8?B?M0NXM1RnWVFmK1ZvS1JjYW52WnJ6YUdMeVFXemFScVJ1Q0lUeVJKMDVhUkF1?=
 =?utf-8?B?ZjM2a29NNTV0WUF2bWZJUExhcEhJblNFaXJDWkhTOU1OZ21ObHZiU0ludGFt?=
 =?utf-8?B?d2EzbzV2L2JNUnlNN2lqUWJBRytGYi9ndFVLRHFXOXRVcHUvZGFkQ1B5Q1F3?=
 =?utf-8?B?eXZDcmNPcW5HRXhhd05aRlVGdkRwWnc1aFQ1TUM2SlB1NmljT3F5NFpISis5?=
 =?utf-8?B?ZWhtalo5c0hVMkFGNHlEQXc0b25TOUdXL1JMSTFnSFB3a2hSWlNTeWdtc29V?=
 =?utf-8?B?N0Erd3ZmMWxpT1p4Wm96UVFzakt2SDVRVWowdjg1aEEyVldwekN0WWpNTzdj?=
 =?utf-8?B?dlp0SlphRElsT2lSb2tpdnJ6ZnppNk5mNDdzQXczVlFudzd2OXZHVWcyWTU4?=
 =?utf-8?B?Sjd4ZGRDNGNkMTlYZ3pjM0pnMHlaM09MQ3ZXY1lQcGRCZEkybUNZbXBDWFdH?=
 =?utf-8?B?bmpZNkM0TjZrQ2JRQXJLZDA1UzFJUVk4aWxFOC85enVWdzdIWWtDMUhydWJV?=
 =?utf-8?B?Z0xHVmJ4NHpJYW1ReGdHUTJOd1owSm5IV1NpakNFZmhFaDZhUTlESkFmT0lX?=
 =?utf-8?B?RGZZdDNWQTMybmhWTnFyc3dyS0ZVWU51ZGhkcGR3SXJtL2t2RExGUVdkanhN?=
 =?utf-8?B?TUFZVWhCTExmYzgySUxIa2piZ2pXZ3R6YmRjSUdpZ1BlOHQ1NGhCOEdKZGtK?=
 =?utf-8?B?TUw2NGo3Nk5tWjhGbllucnZqdWFhbnM1K1JsOFlOMjV5bFJTVCtKU0x3bG1F?=
 =?utf-8?B?ellKdXl3d2FxcGp2bThJVWtQaEduZ1hnVStPc0lHYThFQU4vOVRMd2VqdzlT?=
 =?utf-8?B?b29OWElERmQwSEZiRUxXM25TZCtYVWJhcUhqYmg1dTNGMUJUYlJLKzNldCs0?=
 =?utf-8?B?bzI1Ums4SjRJRGthQWE2elVJclVuVUNBMG5JTkZCNDhmN05IR1ZlR2hFQnRN?=
 =?utf-8?B?aFVSN3FqdGRlQXFleXZxOUZ4cG1USG9FT2cyUFNHVzQ5d283VnNVV3o1NS9n?=
 =?utf-8?B?YTZXZ0lPTjY2T2M3SUl1eTc2YjI1ZlRHbXQ5RWNsSHh4RFkrcDJaUHREcWF2?=
 =?utf-8?B?WGhuc1ljSXcybWYzLyt4ck1JV1RqMFRTMHAydmtUNDdoc0JhUzlqTzQ0R0s1?=
 =?utf-8?B?anJpZWphTFl2NlcrTkNObW9VRktoSkRpV0wzSmJrdmIxdFdIaDYwZTlaRTA2?=
 =?utf-8?B?MDRVK08rNTVNMHFsMm5HU0didUQvd29NTzROTzVmMXhqMlhVM001ais5NzlT?=
 =?utf-8?B?eDZaazZXeHE0bFNYMmJSZWxCbU1xejUrQlI1RlU3ZU9CWWlFQlE2NnFNT2g5?=
 =?utf-8?B?RExsMStKSlZIZWpTeHN1K1BCelk1TFd5dzRraDhMQnhrZFFQcFJYd09tbkEz?=
 =?utf-8?B?RnByVWNQSTFIdkc3OTVzR1dRTHkxVFJzREZhcGVjL2FpNkl3cEw0ellDbHBi?=
 =?utf-8?B?L3l4eVdOSGN6NkZCN1QralowWVZtTkRPWERWY0pBRFQ0M0xnbEY3UlZ2WVZv?=
 =?utf-8?Q?Znx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c633a738-b94a-45fb-b4e7-08dd139cb734
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 13:16:36.5408 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCBgfTepUcFFop3+GottQ9Kwbw6cyRdtrjDml73YYzMbDhwPWQ3ObqbK46Zj4Zfv/cHClyXewFnp9oaPAz6+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8193
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBzbWJpb3M6IGFkZHJlc3MgYnVpbGQgd2FybmluZw0KPiAN
Cj4gT24gMDMuMTIuMjQgMTQ6NDIsIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gaW5jbHVkZSBkaXNwbGF5X29wdGlv
bnMuaCB0byBhZGRyZXNzIGJ1aWxkIHdhcm5pbmc6DQo+IA0KPiBidWlsZCB3YXJuaW5nIG9jY3Vy
cmluZyB3aXRoIENPTkZJR19MT0c9eQ0KPiANCj4gPiBsaWIvc21iaW9zLmM6IEluIGZ1bmN0aW9u
IOKAmHNtYmlvc191cGRhdGVfdmVyc2lvbuKAmToNCj4gPiBsaWIvc21iaW9zLmM6MzA1Ojk6IHdh
cm5pbmc6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uDQo+IOKAmHByaW50X2J1ZmZl
cuKAmQ0KPiA+IFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiA+ICAgICAgICAg
ICBwcmludF9idWZmZXIoKHVsb25nKXB0ciwgcHRyLCAxLCBvbGRfbGVuICsgMSwgMCk7DQo+ID4g
ICAgICAgICAgIF5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogSGVpbnJpY2ggU2NodWNoYXJk
dCA8eHlwcm9uLmdscGtAZ214LmRlPg0KPiANCg0KVGhhbmtzLCBwbGVhc2UgbGV0IG1lIGtub3cg
d2hldGhlciBJIG5lZWQgdG8gcG9zdCBWMg0KdG8gdXBkYXRlIGNvbW1pdCBsb2cgdG8gaW5jbHVk
ZSANCiJidWlsZCB3YXJuaW5nIG9jY3VycmluZyB3aXRoIENPTkZJR19MT0c9eSIsIG9yDQpNYWlu
dGFpbmVycyBjb3VsZCBoZWxwIHVwZGF0ZSB3aGVuIGFwcGx5IHRoZSBwYXRjaC4NCg0KVGhhbmtz
LA0KUGVuZy4NCg0KPiA+IC0tLQ0KPiA+ICAgbGliL3NtYmlvcy5jIHwgMSArDQo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIvc21i
aW9zLmMgYi9saWIvc21iaW9zLmMgaW5kZXgNCj4gPiBhMzZkNGI0ZTU0YS4uZGVmYjZiNDJmNDUg
MTAwNjQ0DQo+ID4gLS0tIGEvbGliL3NtYmlvcy5jDQo+ID4gKysrIGIvbGliL3NtYmlvcy5jDQo+
ID4gQEAgLTcsNiArNyw3IEBADQo+ID4NCj4gPiAgICNkZWZpbmUgTE9HX0NBVEVHT1JZCUxPR0Nf
Qk9BUkQNCj4gPg0KPiA+ICsjaW5jbHVkZSA8ZGlzcGxheV9vcHRpb25zLmg+DQo+ID4gICAjaW5j
bHVkZSA8ZG0uaD4NCj4gPiAgICNpbmNsdWRlIDxlbnYuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51
eC9zdHJpbmdpZnkuaD4NCg0K
