Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D04C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 13:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04EA6805C3;
	Mon, 24 Mar 2025 14:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=topic.nl header.i=@topic.nl header.b="lCTRyoiK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE240805D7; Mon, 24 Mar 2025 14:58:11 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::70a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBB2080548
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 14:58:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mike.looijmans@topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6dBgSYwo68uJtZxEM0KzsyQD3GK/z+Rxmyl4XFsQoJVSNcaUs9zqnENLLOolJMi4jfiV1KQgyIYPIeJ3ClRUTE96blTcU8ehGXqPdIgm8iLNTGDvQpWjL0fOADiwiSHo0WDiqaz7lnrou5WCe75ZBHbnyemFaT1e7rns3j1EK8yQU55ItFj++X1SxzcRIGD0nZLPLkP9oSzkrupnwmREu0Qd0/9V+wzZqDpGISuA5Eb3fgp2wShqkS3jao/3jqFm8+uWP2v8UqBJOj9kZc6CE/NkcBUyxjhKCFqFe0jIj76tf4wzh0fSSJ+Hu5XBswzx97doY2jxFCIgMKx3hKjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl1T7VbB/VzROcYpsHT+/Hsv018EYjoP0y8XrZo5ijk=;
 b=W3PAh+iSlxyCbED3VduZ4JTfkRZPT6nRW4QiZDzigr+NZ7eKY/BjLzfGDJei56nYoJ26GrlzuvZeSj/N0Mq0YudEgz1klJcOBYmEpZcXPJwGRcP8+h/RyPQ1uexvwuMBA0boj3FMoEtcWj3BRnl5c4bSnmJ2a14DWaDo3ojWBBuu6617Q3rwBRtiwahZ0QDBAXu9nBkHRETOkyJwruyAoem7VD35FgdZS4NHdRmJY4QAFYgS6xsBQqvcQMS7vLYsYhrG8+BTYk/FWEQOOz1F+1atcqHsJX8epk4VX9M11IRSO0lnyTVfIZjaWeSaVWR1SZe64lJIZb+EAKIBtvuvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=denx.de smtp.mailfrom=topic.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=topic.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl1T7VbB/VzROcYpsHT+/Hsv018EYjoP0y8XrZo5ijk=;
 b=lCTRyoiKE/ZmprAOeg5CV7mJkQ8w0+e0YD2Wv26LnngTURDa7W8JVLXlST01COxjkKH0yWpX7264n5bhSz03uFlSzGhQ/45i5mgjhKQHs9g+sp2uajQOGPaNzchv0ROMJMc/z2HT62JKhuWua1RtGcCPgFarDtUwhfHNmI8HMBW+RDIGydF1B4uEC4WVOouglsk9spdnCIHNoQVmQHl8ZuWCWpLjE31xeAx4w5sKRBmgB47eD5mqReh1l4a0guycxZmfqyREJJeh5q3TGjVn0dg0dbq3c9d/6w0neVWhjKBjObMtTjZESOlWXXFqbMk3nZe0QIdGYtMyEw+CN6mj3g==
Received: from DUZPR01CA0235.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::19) by PA2PR04MB10214.eurprd04.prod.outlook.com
 (2603:10a6:102:404::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:58:06 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:4b5:cafe::a) by DUZPR01CA0235.outlook.office365.com
 (2603:10a6:10:4b5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 13:58:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 13:58:05 +0000
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (104.47.30.105)
 by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server
 (TLS12) via SMTP; Mon, 24 Mar 2025 13:58:04 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by AS8PR04MB8385.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 13:58:02 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 13:58:02 +0000
Message-ID: <994ae9e7-c428-4e5b-9251-75ebd75b7ff9@topic.nl>
Date: Mon, 24 Mar 2025 14:58:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: block devices on MTD and UBI
From: Mike Looijmans <mike.looijmans@topic.nl>
To: hs@denx.de
CC: Alexey Romanov <avromanov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <cd57ac47-02b6-458e-86a7-7c837a89b550@topic.nl>
 <78f39c8c-b0fd-915e-ba66-213f58464680@denx.de>
 <86ddc7c3-55c4-4994-8e48-a26f5d59589c@topic.nl>
Content-Language: en-US, nl
Organization: Topic
In-Reply-To: <86ddc7c3-55c4-4994-8e48-a26f5d59589c@topic.nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR03CA0026.eurprd03.prod.outlook.com
 (2603:10a6:208:14::39) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AS8PR04MB8644:EE_|AS8PR04MB8385:EE_|DU2PEPF00028D0E:EE_|PA2PR04MB10214:EE_
X-MS-Office365-Filtering-Correlation-Id: e30385f3-d0d7-4fe4-e40e-08dd6adbe6a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?dkpVc2Z0SHBReEdHMkpNSWhPZ2ZQc3IzelRhbjg5czJhaUc2Znlob2lSeEZE?=
 =?utf-8?B?MzZzLzZtSmVSdDhEb2FmalMycmpWSVVxUENJdmx5RTVsalAyNkdFeWs0MFFh?=
 =?utf-8?B?R2R3WmlyVkxsdW56cDB1Mm40dlp2c2dHM2FpRDM4NnQ3SUZtdWo4VUh6NTdL?=
 =?utf-8?B?UEJTYXRZeFZROGNqRk4rWG1sMlU1OEpRVVoydWhhcTZhbldpNDNweUtHYUFP?=
 =?utf-8?B?RlM5b3djM2k3RnU5b3hIUGJNQnJYbVMyd2szT3RlUWViM3V3QnJVbTBSSnE1?=
 =?utf-8?B?V3R5RE1XODM4THRJdFhEaG04MmZTcWk0N3E4Q0dsL0RLMi93VWZPa1l1TjBT?=
 =?utf-8?B?emRldDA2NmYydEJhVWMrckpMdksxZ2tPYXNEK2dVSUE5T3JxcUJSN2ZhemEx?=
 =?utf-8?B?T2VRSDUvaTBwMlhvSHRQYUxqOWpYM0pJWGkrU2xtelBIV2I0YTJNcVlOY1dC?=
 =?utf-8?B?VCtmb0lrbmZ0YUxoYW9qQldoS3ZwZVpJSWV0N2lOeEY4cTNjeUtTc3FwZDFQ?=
 =?utf-8?B?TjQ0SlNiNDJpd2J3ZUNvaHNiQmZaa3VaMzd1aXNYQlpHSFRrai9Id0dKcXgy?=
 =?utf-8?B?WU5ZbTk5Y0IvV210WjJHMHBqOTgyWGVRZVBZM2tROFMyZFYrckpZdlM3dmNq?=
 =?utf-8?B?R2pPNmZvQ1kyaDNQYzFaUkF5Vm1ud294SFZIVkZiL0VQb05xOXIvMytIMUE1?=
 =?utf-8?B?V0MwUmNwazloRGFOZTF3MzRGZmJZNjdRZW0wN0pCMjR5WTZmOGtEaHp1ZEt5?=
 =?utf-8?B?UkRoYy9iZlNmS2hRRGVrTkRtZXR3cjkzZ3lBcUNoU0lWV3ZIaVlucHFxSTBm?=
 =?utf-8?B?ZWlwRVJCUzJVUzZ3Q3UzUktHWDlQNG9lNEZpd1hlRklxMVhxOXV4d1phVzBW?=
 =?utf-8?B?aGhhSzY2SHY4ZWRrRlViN1pUdm1FRHhKWmRjR0JIY2F4aFo5cDcwai9nS0NH?=
 =?utf-8?B?NzdHNzlpNkdQSmpZL2pIWWM3TG1sT05zZXlIeVA5NFFDc29UL29NS0pkWndI?=
 =?utf-8?B?QUhiYXZzdk1WcmRIVk1BMkV1V0ovbXBCL3JTbEZrVFlhQXZEQTUxWmMxNXRH?=
 =?utf-8?B?N21DSDZDVGRUaEp1NWw1MTZqZDNhOHRxS1NMMHdybGpXTEhvNjdPZVlVWWhB?=
 =?utf-8?B?WHFqTG9JU3VoeHNEZS9keVVKUWRHNDN0OWp0Q1lYeUhhWXlnS28raXN4cG9M?=
 =?utf-8?B?SUQ3Zkg1OVIxRXF5V3VoQWxIaW5EUmUwNzJRdmd1emUwL1lTa3hkVmxMcDk0?=
 =?utf-8?B?RUxSZldnNDRwMUpzRzN1UW9RNkoxaVVZRHM5QXd2cFAvVHRINXJwbERMeXg4?=
 =?utf-8?B?UmpZYmdEZi9rMUdIeEtsSjFYQjRxOCtQU1lGRmpMTDM4Y2lSa3hzWjFGa1hU?=
 =?utf-8?B?UDFyVjQrWEtpZVlVMkgwZ2toNXNLOHJIK1FzNkRSN2dRK295dk9nSTBxeWNr?=
 =?utf-8?B?QmtES1U3R3N0Qi8xZUdOQXdadVpSOUo3Y29WVDMrblFXOVdkcGFiZjJ1ajFq?=
 =?utf-8?B?U1Ywb3FOc1Q4UHBjOXdZcFRiOW83UlZqR1hXbEJSUmJNNEhBR1IxL01PTEtx?=
 =?utf-8?B?dkRwbUY1TitiZElkWFZrRFp0ajZRelQyMkVSUEFWU1h2eHM3ejVadS9iUXdq?=
 =?utf-8?B?VkZvekdkbXByc25hUTNKbFpUYlpCZHZDL2Ruak9jelZLRE1XM3hCTUJrbVpi?=
 =?utf-8?B?SXovMkVkV0JxRGFUalRiQ2V4Ym9QQWRneW9CR05OZ083ZUhvWU96MDBSR09Y?=
 =?utf-8?B?cnZrbUtzQzhCZVFXSlJMeG02aEVsbDJiK21zangyVGh6MkZXUVFmVFJjS3h2?=
 =?utf-8?B?OHVoNTM5bUVvY3FkV1Fnc29aS3dQSS9aQW5YSXVUMFRuMTlIUVdTdG12Wlcx?=
 =?utf-8?Q?xOSdXwogelt3m?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8644.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8385
X-CodeTwo-MessageID: 5d90707c-e626-48a6-9902-fd479168a4d4.20250324135804@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6e96eb5a-9188-48b1-ff04-08dd6adbe4b4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|14060799003|82310400026|1800799024|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkRUazhQVDJjZm1WVG44VU93YW8yZWtmdnVtbDlWdWxZcEpjSk1NcG5JN2Va?=
 =?utf-8?B?QU5PQ2NhaVVRMUx0ZDNYQ3VUdnlaKzZGVVRDNENaQkE3NklSUVNkZWxRdng5?=
 =?utf-8?B?VDk5Qk1DTFVzcmVTZnRrTmMvTjM0Wm5sZnhDSFJhdC9IcmE5U2Fra2JZUmJM?=
 =?utf-8?B?OVBGU05lVUZZQm1jc2ZnN1YwR2N1aUpDQXhzTTZvWTI0NFF2SlczaG52djQw?=
 =?utf-8?B?cjdjZTc5T3c1QWhzeFlTS01VSXNpZlR1ZTBjdmRMS3VIaEJpMWxwd0tOaksy?=
 =?utf-8?B?MTR2WFlyOXNmdFFTV2xmZSt5YTJWZnZWV1VIanhXWG8yUmRQM3JEbC9OU2hs?=
 =?utf-8?B?d1BiTjNXRS9lbmd0L3FZWFNoMCtUYlNMNUVJdkw5d2ZOUXdTREF4OGczM1BJ?=
 =?utf-8?B?dElIVjNXZVhPRXdVQTd3QkVEMTJ0VG4vSmNQYXJZTE5GUExsOE1WK0JDMyta?=
 =?utf-8?B?YjBXNlQva1FEQndrVFlkcjRWVUZ6dFJIUzRhVFJCRFU3bnYvTE1nZmsraEk3?=
 =?utf-8?B?WTNVTTFrVGovMkMrSUpuci9vdzVxN0dIdlRMeG1zSy82VlAvdlhnM2wzaTVm?=
 =?utf-8?B?Sll4SU1KVTFhVEhYeDMwTXMwV3p5ZDBCd2p6aGp3elFBUk5MZTAwVm9tRFgv?=
 =?utf-8?B?RGhhaVFObHFUR0JyQis4RWNmeTM1WmltZGhScmd3SkE3c3IzMCtZNUpROUl2?=
 =?utf-8?B?eGNEdzBCQnhTR3JsaWpuSU5mb2JWTWJiYXFzTUZQMElmODB3YWxxNkRPYldY?=
 =?utf-8?B?emYyVUltYWZqNXJvMnYxbnB4bnp6Y1JQUUsrWlRjbjFyYjVqMDhyM3pDa1E3?=
 =?utf-8?B?NjNKQ3lEL05ycE5YWkJJUkdHZVV2cVU3OXhoYmpyYjhTOVdWeWZNNFNtVTcw?=
 =?utf-8?B?NWN5ZHBiQzZJYWtiUDlxUVNwQ3luS1dwd0dJMENBcHRQRzhsRTlKbDhodnM2?=
 =?utf-8?B?VHRRMkxKK0FIOVRIZzQ2NmtFZ2RPSVBrd0lQd1dqbEt4YmRXMUUxSmxGZWVv?=
 =?utf-8?B?Wmpjb2Z0bDdqTzZ6Z2JiSGZVbVg0OXF3RTdqOTN5eGREUDNYaWZuamRxeTFZ?=
 =?utf-8?B?V2UxNUR1ZFdFVkpSbk91RHNMbWVzaG1FZ0o4L2lzT081MmxoejBQVzVoTjhK?=
 =?utf-8?B?eWRLdW9yc0FncG9HOE4wM0hGdGN1ZU55THBNdHFHOS9RN1Z4RGFtQkJPMFk3?=
 =?utf-8?B?elRaMG5iaUlZeG15a0NLcE9kc0JLbWhrT2ZoWm5GU3JQWFNEMjRpa0hPNHVS?=
 =?utf-8?B?N084dzNEbUNMSWQ1YVBMcVhtbXlIUk81Yjh2cFhibDIyNkV0YVRBSGFlZ3l4?=
 =?utf-8?B?NVlaTGFXSzdxN29ZdW5TbVExanE5VTJ0bGdpbzB5SlZBdUtRZkRxeGx4MnJm?=
 =?utf-8?B?RE1Fa1BGV0kzVHcxKzNrclQ1bHFiVVVvTVE2L0trOGpsa0ZCTnJaWlQwcWkr?=
 =?utf-8?B?b3pjVHJBKzV1K1l2VXVoNWJnQStRYitlaFV6VHJBajVqT0xwckFPWGxtRmN0?=
 =?utf-8?B?NElOMjFiQ0o1bXdTTmJTUTBUSXFsUmUzWHoyaVVGSTlrVE5CdzV3QlorOWIz?=
 =?utf-8?B?YVZVdVZRM1hzSndDbjVMUHFhMlJLZVBYeXV3TGZzcWFWN0pXdkc1bW9udTd4?=
 =?utf-8?B?NDc0blc5bjROM0hqU0NsT3FIQnZJVWFKbjR1VlpCckRUd0xNM2JudEZjMDhs?=
 =?utf-8?B?eVpGTTAyRms5SW01SUgwL2paOVpwcnNxcEdqVWZ3ZEw5SUFpTVBkVmFhMzNq?=
 =?utf-8?B?MXFQYk4vYzRoOHRWaDRFK3F0ajVDanFOMWFsSlpQMVEvSXJmdzRTVE92WXZv?=
 =?utf-8?B?Q0NhMFVGM21ydWE0RnVJSmNBZnEwdHhvUDdNUlkyLzlQQnF4MXRzdEsxVkhT?=
 =?utf-8?B?TVp6T291akFGNXkvVjg1cm1lV0N0L3c1NnRnUFdZd0FFcjlIcmdFZG1sNEY5?=
 =?utf-8?Q?lFF6xHqULhE=3D?=
X-Forefront-Antispam-Report: CIP:13.93.42.39; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu12-emailsignatures-cloud.codetwo.com;
 PTR:westeu12-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(14060799003)(82310400026)(1800799024)(35042699022)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 13:58:05.5383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e30385f3-d0d7-4fe4-e40e-08dd6adbe6a0
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[13.93.42.39];
 Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10214
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

On 20-03-2025 17:03, Mike Looijmans wrote:
> On 19-03-2025 15:06, Heiko Schocher wrote:
>> Hello Mike,
>>
>> On 18.03.25 10:04, Mike Looijmans wrote:
>>> I think I have everything set up to access MTD (and UBI) devices as=20
>>> "block", however, lsblk always ignores them, and refuses to list=20
>>> anything but the mmc. I can read ubifs and boot from it though, and=20
>>> since UBI runs on top of MTD block devices, MTD block device should=20
>>> be working, right?
>>
>> Yes. I must admit, I have no device on which I have such a setup...
>>
>> added Alexey (who introduced ubi block support), may he can give some=20
>> hints.
>>
>>> I also have UBI_BLOCK enabled, so I would expect UBI volumes to=20
>>> appear in the "lsblk" as well.
>>
>> good, that would have been my first question, if you have enabled=20
>> "UBI_BLOCK"
>>
>>> Example U-boot session:
>>>
>>> Zynq> mtd list
>>> SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB,=20
>>> total 32 MiB
>>> List of MTD devices:
>>> * nor0
>>> =C2=A0=C2=A0 - device: flash@0
>>> =C2=A0=C2=A0 - parent: spi@e000d000
>>> =C2=A0=C2=A0 - driver: jedec_spi_nor
>>> =C2=A0=C2=A0 - path: /axi/spi@e000d000/flash@0
>>> =C2=A0=C2=A0 - type: NOR flash
>>> =C2=A0=C2=A0 - block size: 0x10000 bytes
>>> =C2=A0=C2=A0 - min I/O: 0x1 bytes
>>> =C2=A0=C2=A0 - 0x000000000000-0x000002000000 : "nor0"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 0x000000=
000000-0x000000100000 : "qspi-boot-bin"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 0x000000=
100000-0x000002000000 : "qspi-rootfs"
>>
>> Aha, SPI NOR. I fear this is not supported yet.
>>
>> Do you have somehow called ubi_part() ?
>>
>> Can you try "ubi part...." and look if this helps?
>
> See below I guess...
>
>
>>
>>>
>>> Zynq> lsblk
>>> Block Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devi=
ces
>>> -----------------------------
>>> efi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>>> mmc_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : mmc 0
>>> mtd_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>>> ubi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>>
>> Here (and for mtd) seems something missing!
>>
>>> usb_storage_blk=C2=A0=C2=A0=C2=A0=C2=A0 : <none>
>>>
>>> Zynq> ubi part qspi-rootfs
>>> Zynq> ubi list
>>> 0: qspi-rootfs
>>> Zynq> lsblk
>>> Block Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devi=
ces
>>> -----------------------------
>>> efi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>>> mmc_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : mmc 0
>>> mtd_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>>> ubi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 : <none>
>>> usb_storage_blk=C2=A0=C2=A0=C2=A0=C2=A0 : <none>
>>>
>>>
>>> I would have expected the SPI NOR flash to appear in the "mtd_blk"=20
>>> devices, and would expect the UBI volumes to appear in the "ubi_blk"=20
>>> list.
>>> What am I missing?
>>
>> It seems to me, that you have to implement this like it is done for=20
>> spi nand:
>>
>> drivers/mtd/nand/spi/core.c
>> 1180 static int spinand_bind(struct udevice *dev)
>> 1181 {
>> 1182=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (blk_enabled()) =
{
>> 1183=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spinand_plat *plat =3D dev_get_plat(d=
ev);
>> 1184=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> 1185
>> 1186=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(MTD_BLOCK)) {
>> 1187=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ret =3D mtd_bind(dev, &plat->mtd);
>> 1188=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (ret)
>> 1189=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> 1190=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> 1191
>> 1192=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (CONFIG_IS_ENABLED(UBI_BLOCK))
>> 1193=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return ubi_bind(dev);
>> 1194=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> 1195
>> 1196=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> 1197 }
>>
> I guess that shouldn't be to hard to implement... I'll send a patch if=20
> that fixes the MTD missing...

Not as simple as one would think. The spi flash struct has its own "mtd"=20
member which isn't a pointer but was already filled in. So I cannot=20
simply call mtd_bind().

I tried calling ubi_bind anyway, which had some effect:

Zynq> lsblk
Block Driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Devices
-----------------------------
efi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
mmc_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : mmc 0
mtd_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : <none>
ubi_blk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : mtd 0
usb_storage_blk=C2=A0=C2=A0=C2=A0=C2=A0 : <none>

But that didn't get me any further. I'm quite puzzled by UBI block=20
support...


I have a squashfs filesystem put into an ubi block on a static volume.=20
In Linux I can do this:

root@tdkz30:~# ubiattach -m 1
UBI device number 0, total 496 LEBs (32442368 bytes, 30.9 MiB),=20
available 0 LEBs (0 bytes), LEB size 65408 bytes (63.8 KiB)
root@tdkz30:~# ubiblock --create /dev/ubi0_0
root@tdkz30:~# mount /dev/ubiblock0_0=C2=A0 /run/s
root@tdkz30:~# ls -al /run/s
drwxr-xr-x=C2=A0=C2=A0 16 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 236 Mar=C2=A0 9=C2=A0 2018 .
drwxr-xr-x=C2=A0=C2=A0 13 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 380 Mar 24 13:21 ..
drwxr-xr-x=C2=A0=C2=A0=C2=A0 2 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1023 Mar=C2=A0 9=C2=A0 2018 b=
in
drwxr-xr-x=C2=A0=C2=A0=C2=A0 3 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 123 Mar=C2=A0 9=C2=A0 2=
018 boot
drwxr-xr-x=C2=A0=C2=A0=C2=A0 2 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3 Mar=C2=A0=
 9=C2=A0 2018 dev
drwxr-xr-x=C2=A0=C2=A0 19 root=C2=A0=C2=A0=C2=A0=C2=A0 root=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 959 Mar=C2=A0 9=C2=A0 2018 et=
c
...


I have no clue what the equivalent in U-boot would be. I can see that=20
the static volume is there:


zynq-uboot> ubi part qspi-rootfs
SF: Detected n25q256ax1 with page size 256 Bytes, erase size 64 KiB,=20
total 32 MiB
ubi0: attaching mtd2
ubi0: scanning is finished
ubi0: attached mtd2 (name "qspi-rootfs", size 31 MiB)
ubi0: PEB size: 65536 bytes (64 KiB), LEB size: 65408 bytes
ubi0: min./max. I/O unit sizes: 1/256, sub-page size 1
ubi0: VID header offset: 64 (aligned 64), data offset: 128
ubi0: good PEBs: 496, bad PEBs: 0, corrupted PEBs: 0
ubi0: user volume: 1, internal volumes: 1, max. volumes count: 128
ubi0: max/mean erase counter: 16/11, WL threshold: 4096, image sequence=20
number: 2011979467
ubi0: available PEBs: 0, total reserved PEBs: 496, PEBs reserved for bad=20
PEB handling: 0
zynq-uboot> ubi list
0: qspi-rootfs
zynq-uboot> ubi info
UBI: MTD device name:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "qspi-rootfs"
UBI: MTD device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 31 MiB
UBI: physical eraseblock size:=C2=A0=C2=A0 65536 bytes (64 KiB)
UBI: logical eraseblock size:=C2=A0=C2=A0=C2=A0 65408 bytes
UBI: number of good PEBs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 496
UBI: number of bad PEBs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
UBI: smallest flash I/O unit:=C2=A0=C2=A0=C2=A0 1
UBI: VID header offset:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 64 (aligned 64)
UBI: data offset:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 128
UBI: max. allowed volumes:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 128
UBI: wear-leveling threshold:=C2=A0=C2=A0=C2=A0 4096
UBI: number of internal volumes: 1
UBI: number of user volumes:=C2=A0=C2=A0=C2=A0=C2=A0 1
UBI: available PEBs:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0
UBI: total number of reserved PEBs: 496
UBI: number of PEBs reserved for bad PEB handling: 0
UBI: max/mean erase counter: 16/11


I tried a bunch of variations on "ls qspi-rootfs" and so, I can't seem=20
to guess the right invokation there ...


> ...
>

--=20
Mike Looijmans
System Expert

TOPIC Embedded Products B.V.
Materiaalweg 4, 5681 RJ Best
The Netherlands

T: +31 (0) 499 33 69 69
E: mike.looijmans@topic.nl
W: www.topic.nl



