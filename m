Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16127D6407A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7704B83AA0;
	Wed, 17 Dec 2025 13:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Z2cSirfT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B637839FA; Wed, 17 Dec 2025 07:59:58 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD71A83623
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 07:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwvNBDJ0wr008RZQFIFnrKarSIojzeWjlMHnQDsUM+8hrP9pMXKLsWBT8FebeqBcRuiMv7ZqpIM3MthePJSxAjcBgwmzdZOtZkmlFin4acDxB954zcIvsxYhQdFXQbmHq/zESWhX2VsUJr4TVkj+uPbUW720ZmLBDKLHfuYmIcy25cp7AhabnyckfpqniHG02AyIqlvoNKrOy6Q8dGIvf71lN7pDf/iveMi0qhb4ewUwXONP1wNT2RDn03dKhdCPvGmve2Xsef206/oFYuzAW334fP9S4j4i71Z6b+q+4fKktZaUP+WaodfjosKF+zS2dY3sI/plcaa38sVXx7oxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6b+G4sL4dCXPFAWtaTubcODWSl7sLJRSiQLkUZFpcY=;
 b=qFC3DSpsBE+4sqgnd+876LGU9EXhCXu9cWT+tSZ2IHjjh13GI176256zmdEuFimH3QEYXeX48uY/MR76FQulsIOGul+Qj1PIQY7QtM6DdzYRE78h9AVAVfQYb+XrQ7xJ5rwQZAULt7lB3FOoaS11n/ESLcn64oQ3/ey6MwenVUrZY/bS+3lsMPUec6OJ4fD8aPNOXLXbxqTUDKT0zREuYVB5F2ib6QZGdpKOJylTc+KDMGV2XDUHk+eugraCYXtw+j7R3i1JMI65u2M2s5EQjeyGg1nNwuJgfV0Pd7HPUcmzr1dIuuHgqP/Lb5Q58zgEjFQgl1JdoDgftzrCdHCy/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6b+G4sL4dCXPFAWtaTubcODWSl7sLJRSiQLkUZFpcY=;
 b=Z2cSirfTMpS6Y5YRDqMkzp/oPFQgiqjkdsF4jHq+vfhA8EYPZRua+dTfyqRZi6qeNmmSqqeJXUqSb4HO8gc2u3t4ien6oDIzAwGCxnAyMh2R96EoR7DAmxHb5Wm9L1NB1xsexPLy68UW4ILJNCm2Csj4Ui+0vAS1m17RvJJajqc9XnUBKpDZpr5pr7Kn81k8Cwr45e3ZyondkKLeRclom4qs27oISl/8bPpIxps0PY3aMwILDjavX6ei4slaZ9WogRvsmsl+/yHGXl8kAc3c4Ag/jpExiqvEf2C2FiK8u+tsPWARi1hslvhZnDm2tgi+lI3qblApngXWk9H8THdOmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9495.eurprd04.prod.outlook.com (2603:10a6:10:32f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 06:59:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 06:59:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 17 Dec 2025 16:13:23 +0800
Subject: [PATCH v2] firmware: scmi: sandbox: Use scmi_clk_state_in_v2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-scmi-v2-v2-1-5555f8b6e0ac@nxp.com>
X-B4-Tracking: v=1; b=H4sIACJmQmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Nz3eLk3EzdMiPd1CTjtKTUFEML40RTJaDqgqLUtMwKsEnRsbW1AGC
 XCyhZAAAA
X-Change-ID: 20251217-scmi-v2-eb3fbed183a5
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Alice Guo <alice.guo@nxp.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9495:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c21639-d8c6-4a72-8b09-08de3d39e1bc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0hsZS9Cb3JXRE1mMHNYMHZOMGlsaDFmbG9EYStiZjRDeXpqRzhvNjVqNmlW?=
 =?utf-8?B?ZEpuczJzOG1MUkREd2ZDajRML200c3VlMFBhSzZDZUxWTFZvMW9LS01uRWla?=
 =?utf-8?B?RGlmZW9pUS9ubncvODJJUTd3TGlmTENKdVdISVdmai9IKzNQSFp6TENWNFJP?=
 =?utf-8?B?YlpENExVaGllNFZ5Q2FtTHo1dFlXdUJCV2plNXNhRFNsMFBzeGY0RlNmYzIz?=
 =?utf-8?B?SXdNQTdocGM5VFRHNGx5VWN3OFljcVg1MlZHRHVBWXBwcE1mVjI2aXBML2x6?=
 =?utf-8?B?VlVzZktUcWFQTStnWUNkdjY5cE5lSHQvV0dXcEZTM1lZYjVFVDJmeHdKWjR1?=
 =?utf-8?B?cGZKV3JUU2prQVpCaHhxZVZrRUFpN1h4UUlKL2lVdnNJUHhvSGt0eWNHT0c3?=
 =?utf-8?B?Mm12TDRNTDdJTkUydXRIVnBYZWFaUlh4Z0FuVnlUYmpqMGNMQUtIZGY3dFh1?=
 =?utf-8?B?N1RKNnZOWEJQMnlpcEFtbkdhYXN4UjJlZlFzSVBCaHk0alFmR2s0WHpLcm16?=
 =?utf-8?B?OUFFK05oYTVEMWp1Q3dqZlhHTS9TdDJCTmxoaG5BSmhxMk8rQkxIVlJzY2x0?=
 =?utf-8?B?TDlCeFpqaUxXcFRSd210U0RSVDlQT3dweXRmeHhORXlRVExXa3pobmR0d0lQ?=
 =?utf-8?B?WXIyS21qVE1jVzVxaUc2Z0pqeXZwRnlnYlVpendkSjdPayswUS84Qk9BQU55?=
 =?utf-8?B?T3VNdFVQcG9rYyt0cVBqQWpEd1FyS2ZNT0tGOWxCc3JncWl2RE1TelBFd0JB?=
 =?utf-8?B?VjErbjE4RVlDa2d4WFY1UTZvaWhKaVFDbEFKZXo3c1JzeGI0S2ltQmd2QSs0?=
 =?utf-8?B?d3B2SzRsUlRKaHBaTVgwM08zMlp1SjJJeXp5YTBtOVBLK3JsM2pMV2pCc2Z0?=
 =?utf-8?B?TW53R0lORVBTSDBlWTlRZUFVdWlzblZVc0pYeVVRR3Q1Q3ZQSmM3bnp0ajV5?=
 =?utf-8?B?WEZRK1dwblFkalR2RlBKUktWNW9tMlkrVXAvb0E1YW9Fay9BZ2ZEK3BrNWZH?=
 =?utf-8?B?RjF6TkdWWmE5eG53TDRma3lReUpwdVYyaDhxQ0xNaUloVXhaUDkvREg3d0dD?=
 =?utf-8?B?OWQ3R2x6VnhQK3dtVnp5TUhNQTF0VVprcTdXdW9yNFM1VDFjVk1hd0Zmbmx3?=
 =?utf-8?B?QS9XNWJaU0NzelZtN1Zud011UEFIcVNENTM5QlJFRXdwK0hGaDNoUmh0R3p5?=
 =?utf-8?B?cTdNRUpKMjRCQ2YvSk1NaWt6c3h1QkpaT25lUmNkN1FSSDZ3Um5NeG9ESHg3?=
 =?utf-8?B?NTZuQVpNZDZVZnVIZHFaQlVEUUJKbVZ4VFFSMk9FVTN4clppYVBLWUdPWCtZ?=
 =?utf-8?B?dFM4YjVLZHlQNVN5TXhva0dLOTAzeEpCUXF6NUlwRURQK2xNT0FTblUrcUVB?=
 =?utf-8?B?aXlnVWNoS0I4ajBXRkY2NFdGMjVRRFBZekZtUGgvUHM5ZU43K2RieVp4Y201?=
 =?utf-8?B?NTRrNVQ3c0IxZ1hBWDEzNHhFSmtlVVZ2RktkR1ZGSkNNempkTHpyczkxa245?=
 =?utf-8?B?TTJEZ0g0TUhud2VZSzkxaUsvQmRKSk5BMzduc1BVMmY5Wm14V1RET3pGYldz?=
 =?utf-8?B?cEN3SVEwbmpmMUJZdHptTWV3T0RidlZIOEN5UUljS0lhNmV5Rnp3ODBsMDFC?=
 =?utf-8?B?dUFEM21Ld1VhdFoyRHRXM1RMSk1QajNnNTVJM2toRmtJeWxjM0IxOXNiY3pW?=
 =?utf-8?B?aXd2SGVOVlZlaDBnZWxHNXlOWmNrUGl1RXhialI5QnBQcFBWOHpXN2dIeDMz?=
 =?utf-8?B?MGczTFNzQnV3cXZjY2llNVc5eFprWStVYkwxbzQ2UlJxSmdheUtlaEF0NE0z?=
 =?utf-8?B?WTljUk1SODZHZVM2S3RQQ3dWN3lqK0pkWGtjTU10bDE4ejZvdzM4MElZeXBD?=
 =?utf-8?B?TzNHdWtkUTgvUUdlWU1IbDhxRGJvYmxZYjFLQUR3bkN2b2xDM01hZ3BPaC95?=
 =?utf-8?B?dTJZMXVQMXJ4a2dtbGIrZ1FnUm9XRTFWVG1qQWw0Y0p1aFpzeEhIMVRsMVk1?=
 =?utf-8?B?NFZCVmRhMkdENTB5bzd3VnpYZFJHMEpLRGM3RHpOVHY2TVA1MjlvVGNRQnRk?=
 =?utf-8?Q?Fhp+Tk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(1800799024)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0VzUmdLWXEzWEN2N2NaYlYyeWFiM04xOG5sWWtYaWoyb1dubWY2V0l6NURY?=
 =?utf-8?B?UDcyMWMzVVhjYVR3SnllWTdFZm43V1pxTkd0ZkFLR3RCb0hNbUZ2OXFWcisx?=
 =?utf-8?B?WjhzRzJ4NERDTzZPWUJGU04wQSsxT2VZMGJIZE5RSHZMQ0F3cWZKaElNUVR1?=
 =?utf-8?B?R3pSbWFtek5xVG5QbXYzeVFKY3loL1ByR25jcjRWbmYyZ293TWNYZzA5UVc3?=
 =?utf-8?B?U1p3ZDdoZHhwbU9yTnRucUVBTjU3YUZPVkhnaExpV0NJdXV1WHJOTXd3TUJu?=
 =?utf-8?B?UVpVK0ZUVThINk0zT3UyeW84Tjg0djA5bXpwV3JjMDBwUHg4aXkwUTljM01W?=
 =?utf-8?B?NzAzcGJ3VXpyemFOYUZlM3pLVTZoUUlNejZ5aVVQY2I4MnNxOE80RlpvTDlI?=
 =?utf-8?B?MUhLQjNsSGhORDBoODJ3cmtKV2RQMWVMWU9ZRFNmUkx4bVdjajNoaGxOL3Jj?=
 =?utf-8?B?WlFubEZLT0R2a1NEd09EaG1GeTUxQlhiaUZYSk9oVFFtRFE3QmdCTnpGbTdv?=
 =?utf-8?B?M0Y5OTV0MnVJbXNNbGpXWnhhYVhHMUF4WWFPUmx6Y3R1bktnRzhqQXY3Zytk?=
 =?utf-8?B?ZW1DQ25rZlBOOW5CWHRvY2tTM1dVVkNQczVGOTQwRzBnK21jQjVOYWcrTGZ6?=
 =?utf-8?B?L29ScEtlVEF2WXVQYlFianZ0dWxMN3hkWkJYdE5ucFFYZXNndE04QU1hWTI0?=
 =?utf-8?B?Y2oycWYxalpVeFAreEVrYzhiWkx3RVlmMUVjVUkxaWRoK3F0bWhTS3lteGdi?=
 =?utf-8?B?d25JS0EwN01DVUpiZXhOdkcrcERER0cwdEl5RllwSHJScUl5aDV3ZExNZDM4?=
 =?utf-8?B?d2lzM3VsYmpwcjF3RFF3SVROQ2xEOG5FSjR3Rzd2UzU1VHVleFdMbmtiNy9E?=
 =?utf-8?B?ZTNKMzdBSFM3UFBtL0Q0eTZUSnVPSmc4S2pPTEZUZVdmZjc2RUgvQ3RpMklk?=
 =?utf-8?B?SEc0S3ZLWkZMSGppcnhacTNINTVCeENKUS9EV0YrcUVPVzdlWk5TODZkYllY?=
 =?utf-8?B?Q3J3a1R3bENoWTRuRVhSSmY4U01WbmxDVDNMdUF3QURPd20wTWJWckxyUEw3?=
 =?utf-8?B?bUthaVhjMFhFOUdIOHhLeEZER1VQM2VZcnlKU2tkbjJ4Tk9QbTNFbkVrR1ph?=
 =?utf-8?B?T1ZjWHRMb05oMVIxaHoyOEFITjNha2FmMDdlWEFqZklrbnlCVXVUQk9UL25J?=
 =?utf-8?B?LzBjekIzVGlEWkNYZmlYeXhPODZCWXBBLzI1cmlrOUFRenAwd3NHcTBzdFp6?=
 =?utf-8?B?Y0dGMFhpUGNHN1hncXBXOS9tMkFiVjBkaGJFYWpZdCsvSW5YclJhc3pwUHcy?=
 =?utf-8?B?YXV2WWh4RFdRTUVGc3NvdW56QnltSTFIaUQxTzc3MEFBV1A2Y1hmYjZ1Ukgz?=
 =?utf-8?B?eE10RHpRajQ3NWp4TzlidThUbytaV0dXT1U5d2NKVHpCb3pCeUxYQjV4ZUFo?=
 =?utf-8?B?bEtFSjZ0ZnpEemNDNzB0a1A4QURlaXJTYkxsN24zalFVVHZsTkpMMUVsMEMx?=
 =?utf-8?B?TmUvemo3WmVIek1sNGpIZ3Vlek11OTBYY3JKc1hLTjYrMDZKbm5FVHJQNk5Z?=
 =?utf-8?B?QitMY3FpZklQbnBqcXVOVjBLbEVaUHhmanh2bHlZTXRqMHZ5RFJJSEdUZ1Fq?=
 =?utf-8?B?M0g2eGRKTzM0bGgrQ1ZudFRUYnhnZkFyeVFwWGI5QmQ2YnRQakZmSVdud3RJ?=
 =?utf-8?B?VXljc2VmRDA1QmFWVFBuMnZxbWFHZGRjSjd2QVlPb0FpRk05TGR0ZFFnVXJz?=
 =?utf-8?B?RlU0dWNPcExKT2FMQVZpc085TWdQbks3MUZmeCt4L3ZWbVV3ckNMS0c1RjU3?=
 =?utf-8?B?bklhVTFUU096NWpPeWpLZ2dNb3hjQS9jVmdZeGI0ZjZvT1FONms2NTR0OEU1?=
 =?utf-8?B?V3RFYlYwanVvTnVEbmlqSlhXcEJwYndPSDRrOE14NkxJNitobW90bXJLazgy?=
 =?utf-8?B?enV1TGtTS0FjQVFZcDJDNFVuZjdjeDQ2OXQ3aUlHUElxakRuV3RSN1A3czV1?=
 =?utf-8?B?RlFqeWNxZW42R2VaMGJ2dG1uRW01VDZrV1lIVEFsMTNTUE80aE5FcW11b2gw?=
 =?utf-8?B?Q1ZWQ1BYcWtHQ0JUM295V21SaVliNU93aittaXVlaUYzSGg4eUFRM3lBdnY0?=
 =?utf-8?Q?OL8ajoQKTRodfuXb9BkX2IIod?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c21639-d8c6-4a72-8b09-08de3d39e1bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 06:59:54.4676 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QubwCg+avZa8Ga0oGAd6ohOdvHbsgxGZ3U47Pln6+e+omsjzjCBcGTpizvzgKv/7iIQqd4HIyuhr5wvZbyJ/Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9495
X-Mailman-Approved-At: Wed, 17 Dec 2025 13:57:17 +0100
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

The sandbox scmi clock protocol use version 3.0, so need to use
scmi_clk_state_in_v2.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
 Drop fixes tag.
---
 drivers/firmware/scmi/sandbox-scmi_agent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 5b242a039c2..010bf99fbc6 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -828,7 +828,7 @@ static int sandbox_scmi_clock_rate_get(struct udevice *dev,
 
 static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 {
-	struct scmi_clk_state_in_v1 *in = NULL;
+	struct scmi_clk_state_in_v2 *in = NULL;
 	struct scmi_clk_state_out *out = NULL;
 	struct sandbox_scmi_clk *clk_state = NULL;
 
@@ -836,7 +836,7 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
 		return -EINVAL;
 
-	in = (struct scmi_clk_state_in_v1 *)msg->in_msg;
+	in = (struct scmi_clk_state_in_v2 *)msg->in_msg;
 	out = (struct scmi_clk_state_out *)msg->out_msg;
 
 	clk_state = get_scmi_clk_state(in->clock_id);

---
base-commit: a333d9e59f6675c9541c34643f334dbf50898647
change-id: 20251217-scmi-v2-eb3fbed183a5

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

