Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287ACCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2540838C5;
	Fri, 26 Sep 2025 18:06:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bn80FqGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9925F836AC; Fri, 26 Sep 2025 16:54:30 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB1D835B9
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdcjLt/UGEoZhIWgWlXfrzioUa91eHi0yUPcYb7KaQlFxb36eG4Bhr8pMF3UeZL9J61ruQ5iz3lVg7cG57kpXINQEmsiZ+SusSv3TXhUMZQjQ7rBPwp63lMwm/cZs6eDMsSahGpLAlzaJ3Y7ALdS2DBXji/JPP8wlCNgbK5M7te6hRUljEOcY6JfK9p9fOXh5tFztnBZBkQDXoWavMUPAVRbdsPRtxxbfaOBEGmtCfYtlPQBkvdT2oZ4p4ICTtclJpURYKDvpAIdRwkpRcV/Q4ay3op8V44ogPnT/UmHEcE7X1oCkti0itjFhkiAMvXHClmGKqmEQ09ZF1kxjssBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iswa4BCpnBmm3MSOJo1N1k++mf/PyTAlYe0ezK5xN9k=;
 b=NW3rIu942GQhG46BFccxNxb4BM2To0F5qvzArvwNjCHH8w5vnqtKobxbDLdju81kWMMsB+vSRv2R4BXoqbX4k5TGHnsQWlKEIuODicYKo7eh34FR4BZwsJ6QAURtlOWEUaDxzKVkV9rdCYjjX24lZT70eV2+LYpKFI8bQIawxTdUvlSYGm1D9+NeXJLpxZdjIB4UttJgQP7ENgjYXAl2JewxN9In2QblkWsnRLP2mlgyey/eQXaA/X4o2lJKSGR6WPYRXq7y8AUYI4pWj06QcPiEwB8/60Xycr5iyR0e08+OC8zMg56u3WZ9vQoMyjaEjsBt4puAR5Vychi6WyXhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iswa4BCpnBmm3MSOJo1N1k++mf/PyTAlYe0ezK5xN9k=;
 b=Bn80FqGfH7XjRbMiuaJiyhmtikiFaor5M2widHUlK8XYnlHaPXmocCbL9NAxp66V2vlFItLId/TyXnv7HzxUoEBGNtQj6JSe9GT/PB4HLTLAjSpvbSvepErLGVpmlELjZa5UuQUgZNvqmhtRsHvpXBVl299nBHtgIjC6UX/NUfXlsot1D1UO3CEe9mFAsybNLjI9K+boAoibmQmMMY8+bc4NSac4dlhuRd2BsBKkdzHpFkygE0UYUrTfkkyNZfT0i7T6nnHOSG2XNQB4SzaPnw6EoNjwZWMXrBmliApVSwSuhqxvcNHIBekEvRXbZW6HqsRoSLqEkIeWlCw2J6LWoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV2PR04MB11141.eurprd04.prod.outlook.com (2603:10a6:150:27c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:54:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/10] firmware: scmi: various update
Date: Sat, 27 Sep 2025 00:06:13 +0800
Message-Id: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPa51mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNT3eLk3ExdA/OkNLMUw0RjIzNzJaDSgqLUtMwKsDHRsbW1AOvQpnp
 WAAAA
X-Change-ID: 20250925-scmi-07bf6d1a3267
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV2PR04MB11141:EE_
X-MS-Office365-Filtering-Correlation-Id: b60fe251-2bf5-41ad-958c-08ddfd0c9563
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnZpNWR6c0t2MnZiLys4czFZK1h2SmtPOFVwbG9GRFpNRHVtTXI2UlEzMWx3?=
 =?utf-8?B?T2tGSHh1dzN1dXhWSHg0c3NCc3IwdTVLSFdJZVNnK08yaHdhdkkyMGRhY29Q?=
 =?utf-8?B?dStTc1grb1d0YnhWM2F3clZGNThMNytZY2ltMDFDQU13d3RhM0g3NE5JWlNo?=
 =?utf-8?B?VHZqOHB5U2RsQytCU2hHZmFXYjkvRUdtaUxoRk1aWlNhckd3eVo5eDIxTnBY?=
 =?utf-8?B?Y083YjF3WjY5LzE5SlFKNmlacS9SWW1FU0RMc0FpQlFqNk14WFhKSHpYZWk0?=
 =?utf-8?B?MC8xV05JRjVocUNoZ29SNGxDMjJwVm1sSlcwaTJaL2RSeHVpdE9sTWhRUzBh?=
 =?utf-8?B?TndUTTQwa2R6M2tQV2NxVUEwOG5QRjlzdEd1ZlJ6Q1VBUlM3bXVqNEgvcWZV?=
 =?utf-8?B?N041YU9FaFZOWVI0MkZQY0FNSXJ6cmhoNng4QTl3bXc4T21ScmUzd3pINGt2?=
 =?utf-8?B?Ymt3Vys0MWhVaU8wdjhlcjBTMWx2bzNFeWRlYVUyQk5OcVMwKy9OUFRBdVow?=
 =?utf-8?B?M1N5MHBTa01wY3d2VnBNSHlYTnlFNUkxVUxTdWFacVFSa3ZOV2N6aTN0KzlX?=
 =?utf-8?B?cEIxK0krWlMrUStqdXZVNzdSajcyZ0FMLzBBZnM1QUFPckF1MmVSUGl1N282?=
 =?utf-8?B?UCs5NmhlMkxkL3h4dTlLV3pDWVJFb3VmUmNiMDFUOXQyMEdXSFJkMWF4RzZk?=
 =?utf-8?B?aUJGNktXT2s3QnNoS1MrSFNkcXpHVU1kV3VDeWp1SmlDRWFDdEozU1ZEUTJq?=
 =?utf-8?B?RUF0YXRpRlRwaHYxd1ZCSitmRnNrcTBDa0hBbUJjMVJMSmh4ZjVLd3NJV2Qz?=
 =?utf-8?B?bUc4ZXoxVWNjU25CUUJHWDVjcnpFNW4yNUZBZWx2RGJCQjkvY1ByQm5wZ1do?=
 =?utf-8?B?bjQwN3RLejZkZWRmQXhMVHJ6bVM2TFJLaTk4Y0NYSlBjV1dkajFoOFJPTEx2?=
 =?utf-8?B?Ykx5MFV3cjdkRHV6QUllRFhvUWNoeGNmTkhSZk1GaDFVNG1LTlZuMHFPOU9D?=
 =?utf-8?B?Q2FZZFdoU2lBa2NWdVVVL3lmeUxIRFpTbmhJR0ppeWs1RFBEd012aEJyL1NB?=
 =?utf-8?B?YzJ3WFNvVnJLdVZqU1k2YUIyUkVzMDRkSTM2YStDUTVpb2VpeEF4bkowK0dH?=
 =?utf-8?B?RHR3cW8rTHN4OHJpNjVReWdYbGlIcFBaMmgxcE9qRThjODV4VEx3WDA2ZVAx?=
 =?utf-8?B?ckdFdFptWW9XS1A0YzVMYzhPcC9mbnZxTVU3LzFyTDdQMk9UQkVKNUNCd0hX?=
 =?utf-8?B?cVluZjVsUFNQVXJJeUtMNG95NEIvYU5HRVY4OUNxOGZvRm9aYllSWEI0YW8z?=
 =?utf-8?B?RzJHNmN2cHRqU2pCV2svNlV6YmVIeGJEWjdIcG05VkVOU21hTjhMeWxzWUFZ?=
 =?utf-8?B?M0NJY3puMGd5RVFONlhaUEVJY0ZtWXBDR3J6U2dsSVN3a3FXNDNqZTd4UXFr?=
 =?utf-8?B?eStZSzRBTldpeHFHaTRjQWREMWpSUCtpaU9IRU53UElUUU9PdnBVL1diTGZu?=
 =?utf-8?B?K1AzMXVYOUJoSlROaFAyNE9tUEFvem1KT0hmdlRYQ2pZV2pWMit3S3NsVkgv?=
 =?utf-8?B?Y3NaUzZ5RkNBZVlGQUZtS0pvWG9KKzFnVXpsTTA0STdINnVLN2xaUWVCRmd4?=
 =?utf-8?B?cjNEQ0IydGg0OXhoeWFQWklJemhFVHpWU0MwcFFZYjc2QytibW9WbGsvR1Jq?=
 =?utf-8?B?NzU0VVViRjFzUnVObmppSldWMmhLeU9QckduVXl1Vkk3ZmM1QU5WcVJVN3Vw?=
 =?utf-8?B?dDhma3hPM252VEZjR0FVVFlNSTZaTUpDVVQzL1J3TllzT0pTNHFhVEVQYTVE?=
 =?utf-8?B?MHM4SE53eDBEbHlIanljMDJsb3d1V01YQzgvb3pUQTBxMHJPN05jM2NiYVVt?=
 =?utf-8?B?SEh1TDFpekF5ajc3eWpWVWdvZGFxR3JweDU1NDcyS25mMGF6V05aUjA0aVVB?=
 =?utf-8?B?dkRNZ3BBVVZWaEF5OGN2NzhkTFg2VXRRUU8vSW1RUDRPZUU0ejNGWGh2V1Bz?=
 =?utf-8?B?azVDOWpQcDZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTJQQ3A2eFdWR0ZPZmREbGlRRGlHQlliVW1KeXBOcEx1RmlxVDc3R3ByVVQr?=
 =?utf-8?B?TkJuWENBNzQyR0YyL3ZnbnBWRTUvVjhaS2FWS0lGMmRCY2pNUlBmQ096QTVP?=
 =?utf-8?B?SFBxbkpsWC83bXpWREphTzMvRTlpNk5GUlhXSXh5WUlsRzZuay8wWkNDMnpm?=
 =?utf-8?B?eHR2QkxMeGpvNHhjV2dwOENiQzR0eWFLS2JYNTU2aVJETWsrQzd2L1JnL2J4?=
 =?utf-8?B?MjlUK0kxUEp2R2hwT2hWZFUzMFAwb0dYM2h0SlI0YUpuaFRPTHQ3TWM5YzBp?=
 =?utf-8?B?R1BJaWtwM1N1OWJrNUFlTnd2NjU5amkxOGNNZVBUK1ZBY25ZMXdRbGFRM1FI?=
 =?utf-8?B?M2g1OEFwYmUvc01GdWVwMHdTY1o4L3JsVXFqdFhVd0huM1hYU1o5MGlDR1hD?=
 =?utf-8?B?SktFVWNTVUwxbzA4c29DZmVNVWh6b1FxbXNwUE8zeERzYmdtd08vcXR6WEE4?=
 =?utf-8?B?MzBMdHlzc0taRzc4amw3MTVsdVdad1R6MWhadDgySjRvaW5Zc3BsL1hhMnZa?=
 =?utf-8?B?WHNScXc3Umt6KzlZZjNHZllMQUJHKzZWZnFRZ0R6S2k4Mk00QWlrdkxDN3lM?=
 =?utf-8?B?VlRVQ2thU1lVY3BYS2ZKNUJPSW4zeGVXTEpaaktXZkplcXlIeXdEZVFJMG5l?=
 =?utf-8?B?WXdVTnlzcUhGdjNYZFlqcUliMUZndEVNNTREem9kaVNhbTl2MjBtSVBUSHhv?=
 =?utf-8?B?SHZmM24yMXVJZWJKOC9od2psUG5nMklQR0F2VHVaU28zQUdMTC9XeGQvRlVa?=
 =?utf-8?B?OWEyYmFHU0JXV3VmRzVQNXIva2JCdXFSeWV3RVg1MDVDbWsxN1JZajY5WE5S?=
 =?utf-8?B?Unc3NDFMRS9JVWdKNFRqc2dDYm5tNmhPaVJmNG92WlN6bm1QejkxMkwzZGs1?=
 =?utf-8?B?VkVEdFBPKzYyR3F5MmJFS2tGcERodnFpZEpaamRhejE1dHJsODlxSXR4TGRM?=
 =?utf-8?B?aFd6L2cwZUwvYzdLMTRyWEdwUG95cDlsR1lKTUtFb2dibzdrWWZqYlEvTWhL?=
 =?utf-8?B?RVJLdzQrSzZoZ0ZKUnBuMlhReVhweGZsb290TlRJU095YUFlZlJ3aE94RElj?=
 =?utf-8?B?djVoZXZrOEtKM1dKNjYyajlIdERGTkljaFVteFNzZVBxV2hmRzhBQ0wvaTky?=
 =?utf-8?B?T3o4bUtxbjdxU09qazE2WHY4SVhLRUs4U0l3NDYvSmtpS09ybm5oM0Vhb3pv?=
 =?utf-8?B?cmtvdCtRNlFTRzRhcm91VlMrSytkaGszclNsOTFtaFNWZlc1OVVyZU9rNHZs?=
 =?utf-8?B?RThNTUhXZmk4dlhWNExEZXYyOXZBZCtUeEZ0SzFKcmFkSzFraWFHbWUvYnJ2?=
 =?utf-8?B?dGg3bGFwVG9uYU1pemRTWWk0VkM1YS9MbFkxc1hVRmRXOG9SRmZtTG5vdTJE?=
 =?utf-8?B?WXY1UkU1c0Z3OUdBd09qNFhKc2NvN3VaNVc1dXZyU0FqdnV6MnFTTHZoRnBR?=
 =?utf-8?B?U0MzRlZhWlhpcisxL212bzBvd3gzTmJDMktSL1JZOFJnSDQ1aWlCVGsyeklQ?=
 =?utf-8?B?Vis4ekxOYSs1VmV1REc2YkJ4Z09oeGhWRFA3cHZtQVFKb243VVVZVC9RaGlM?=
 =?utf-8?B?dzBhRHo5U3dvS0lSR3ZFeXNmSlF6OFFjSXU0TllLdk5wQWZUSE8vS3NyMU5J?=
 =?utf-8?B?SzBoYVM2VDcyaDNmRUZheWZMeXplRCsvc3hDRm1oS3drclNaaWxyeW56LzNC?=
 =?utf-8?B?aC9xTnlpVkJyOFlGKzNBY1NIbkpVTHRyVW1Vb1RZdy9zT0dsL3dEMFM4WUtp?=
 =?utf-8?B?MjFNdjBLRS9IcHByN2VBY2VVaHVBSFpraTBNZXhyd2ZJYjB0MzVuUnVGV1dr?=
 =?utf-8?B?M1J6eEs2YnNuSGNUWm9ySEJrMjZxSEN3bnVNZkxOOEFSTmYzVjc5ajRFWEVX?=
 =?utf-8?B?Qm1JUHN2a3RmVDFtbVlyeXQ5SGhBT3RPQXdvcGhmUjVRQVlhQzllMmh0NGw5?=
 =?utf-8?B?YUxpUnFDVjVDS2pNaUl5NU9pSFZna1UxOGNTRi93cW1YWE9RRldndDJSdmNB?=
 =?utf-8?B?Sk83Zm13SEgzSTNPRUpuUjZGKzFDOVFoc1RvUTF0aUV2MEh1VTJBZ0daQlBi?=
 =?utf-8?B?dnZGSi8wdG4vSGEvNTFzcm1KSkNYSFF4YnRYTm5sUlpaOXpBOVJHU1Y1aytZ?=
 =?utf-8?Q?5ZG6f4u2wjP9gx+MOBUjgShYy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60fe251-2bf5-41ad-958c-08ddfd0c9563
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:24.6402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoUTzdlCI98i108WddjQjTDjE4CpqWZDTx2v0d2K0VcRedDETwrl1YURBIRx/iOXvNJPaYCFaTlY2zMPoJ3sLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11141
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

Misc update on firmware scmi:
 - Typo fix
 - Use io helpers
 - Use PAGE_SIZE for arm64
 - Add IN_USE error code
 - Add more error info
 - Support scmi max rx timeout in mailbox
 - Add myself as scmi maintainer, AKASHI contributed most code, but
   seems he is not invovled in the developement anymore, I volunteer to
   help here.

Some items on list that I am thinking to add:
- align with linux kernel to use cpu_to_le32 and le32_to_cpu, but have not find
  a good way to use the helpers.
- Add SCMI version negotiation as Linux Kernel

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (10):
      firmware: scmi: Typo fix
      firmware: scmi: smt: Use io helpers
      firmware: scmi: smt: Dump more info
      firmware: scmi: Add error code IN_USE
      firmware: scmi: use PAGE_SIZE alignment for ARM64
      firmware: scmi: mailbox: Update timeout to 30ms
      firmware: scmi: mailbox: Support arm,max_rx_timeout_ms
      clk: scmi: Replace log_debug with dev_dbg
      cmd: scmi: Add pin control protocol name
      MAINTAINERS: Add an entry for SCMI

 MAINTAINERS                               |  7 ++++
 cmd/scmi.c                                |  1 +
 drivers/clk/clk_scmi.c                    | 22 ++++++----
 drivers/firmware/scmi/mailbox_agent.c     |  8 +++-
 drivers/firmware/scmi/scmi_agent-uclass.c |  1 +
 drivers/firmware/scmi/smt.c               | 69 ++++++++++++++++++-------------
 include/scmi_protocols.h                  |  1 +
 7 files changed, 71 insertions(+), 38 deletions(-)
---
base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
change-id: 20250925-scmi-07bf6d1a3267

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

