Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D418C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F89830B5;
	Tue, 12 Aug 2025 11:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="pxo3y1ko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419B08319C; Tue, 12 Aug 2025 11:41:08 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B36F83087
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:41:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjTfJN/bzpdMPVI63mp2ucWyazO/vp5kUq8ve/USz+TdWrJS0QJ8KEOLMbbJjMVDYCClqeTkZANpm5tNbu7zV1Wmzkv9N/EbOH8ZO7oZQBANA68JgVNGncpUmCpJ39zl3aVFzC8GHx/ncH1uMQIlgbt/mNi3+aRWc8A/vMDWnMQjx3SfURpDIiVROfawV3wiPduug/cwxblfR3nBFbq4mGiT8f3xO7IHGBgY9Ci1BECYsbhEhbOgZR24ZDrTfrZX8RzDTnGRxi946WUlelMEx0sUkSTxwQy1YbTkGOguWR2jhjiYgK09YBZEj7G+J0zYLkkOJVvMsjIc/pALFbeNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l20QCcM7QWu0Xd707mycKAYRwZom3iNbqJrOHzbm0rE=;
 b=LHEMjFr/5mtz9x4gTBa60yLAwrMW7EY0GddyYHBrf2gCDlDt5DH3zSV58PyS5FB0kWa+oLMRD7e4wtd23MPJB1RA96LX6VGPjSpirFUTCo7eDLvkHfPHxk+qx8vZiqOANn1G5GIb9zsuLCNb++pWtrCGVAfAndQLdovpy0ndRmqE7x+nRWWUquiXZSSYk00XCpQ/yq88NSVVQa7+k6Q6KbAb49nIuvQSO1UMKUvpCrDTj7LigkCCvbgKUm+wdT16t6/qCoWbM4RsPlVIIAPyYSl8W3j6mSjV13na5LDag+F/I+eiOgYUnZMaPOKqM3BPPQXJnHaBCFH8s6Srj8Um2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l20QCcM7QWu0Xd707mycKAYRwZom3iNbqJrOHzbm0rE=;
 b=pxo3y1koYc6SkfYcUqK7XAg8RY0hxXoLY2Jy3mB2toV++UyyG9t1+pdb/WoOW+2Zi7BrEwv43zRVHIrkrgzymwaeaJIETccToI8Hr9oFtmqA10+33thCCSWLA1z8kOMukJZwHx3qwxTpoZ8s7HgQu+ebXDrke32nuI35i52d0e5avtEO7+Ev/XBDMl7qFslFpzumJbKZpGXimXDQDbsC20XkUk7KxpaRCrz6NOfguN5plnksfddTFKmeEmpl64hrhp45Ca4CtECEiB6toal3Kh4IG7b5TlMqRWyCREKX5JXR4E7hPuFoTPfT4smEaemW7fdQ5Zep2Wx+vzSfORPHJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 09:41:03 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:41:03 +0000
Message-ID: <bd88e947-f29e-4d29-8c30-9673bfc504df@kontron.de>
Date: Tue, 12 Aug 2025 11:41:02 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 02/24] mtd: spinand: Use the spi-mem dirmap API
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-3-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-3-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 138d3ff2-a3b2-4eb8-e877-08ddd9845a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDlqNGZYenh4Z2VzdnR4ZEZSWVhCNHhMaUIzQUg5R1ExcXhWMHJVYWU3azc1?=
 =?utf-8?B?SmZEdy9LUm1UanNEeVBrTk82SG00WmdZT0g0Zk44eDFhaGxYNXh4Vml0eFRS?=
 =?utf-8?B?S3ZNUHZKRTV3NVpZTjYvN3hLUHRzdWtJdFJmOEtVMkJxQ3M4amRiQ0ZXWUlk?=
 =?utf-8?B?R2JzakdveG8zaHA2cnRzbG5vdnVhRGRqVmdrYUxqTFlFcGJDc21CZFFDb205?=
 =?utf-8?B?MmNGUVpIRlJQV21ZcUhObjUwT090UG5iVE45cXpSdGUxZ0ZmdnZnc2ladEpQ?=
 =?utf-8?B?T1VVeUdseTJSR2Fic1JCT0pseEkzN3BFMWdXeE5qK1JZb290SkRFaEpXT0hl?=
 =?utf-8?B?RkRacVlaNVBBaFRPMUlqV2lJWVUrZkVqWFlWdGVHT2IzRXA5NFM2RTdxZEk4?=
 =?utf-8?B?dGkvMEJmWndGZkl4SXlBUVR3SGd0clh6L1pnWFlvbGRwZUh3NFk4OWJHODFU?=
 =?utf-8?B?UFpWSTNSb1VXZ3pRSFRtd3hsZHJBUmlPQzRmTjV4VEluV3duN2U5ZitGbHZr?=
 =?utf-8?B?TjUvVFNVOVE3ano2MitWT0o4d20yVnc5czRKRVpZdkJoUXN4V0lVQkl4OGxH?=
 =?utf-8?B?T1hyQVhmV2VQb2F0dURKZGVpM3RBUzN5Y01nUHBWS1FTUXN3c2xWVVlBZWJa?=
 =?utf-8?B?MlhKY2ljZG5XK3VJR1VoZFFIQWFKQ3lHeGNpYVpaWnh6SzZlTFlHUGNoeDZ2?=
 =?utf-8?B?TmthYzJzKzdjTFNoK2E3ek4yL2xLRWgzZDFnazR3bDNMTjMwSk1lNW1ZOURt?=
 =?utf-8?B?L0p3eDlwOEkrcUxGNTVrbC9CQkNTRC93VGJySUZLV2VNQytibWhzMGtUQ1J1?=
 =?utf-8?B?WHliVmZNTVJFS1I4NG5lZ2FxMkNTRXdscUF0V3JGUGN5SGZXcmFuYUc5RGxT?=
 =?utf-8?B?c08vWTRSUWdUVU5aVjBuWUpxZG1teDFoTjNlbU9ra1N1MHNYQjlpaE1rNXho?=
 =?utf-8?B?V2d0NkVNb1k3V09Qd3RodzJKZDJJSlVudGgrWVlWY2pwNE1vVGNXb09heHhx?=
 =?utf-8?B?SE0zQW1KeENIdXlQSFZ1MGJ4bDVYQlVYVE9aTzlaOURDanlTRmtCcWJkWXFa?=
 =?utf-8?B?VldaTTBQM004YmEvTUorWDlWSFErRGpHQ0d2WlVKYjl6YVgyUGdlNnJiR1lF?=
 =?utf-8?B?RjdzalUzNkUzOU53MkZaS01raUx4Wkg4MHFqcmZyRXJhN3crUGhoS1UvanBI?=
 =?utf-8?B?L2NKUVFjK0tlc3U2UHVxN2xqdnhQREQ2RHJpQ1ZsNE1ZcTJoZ0laUUJxODlT?=
 =?utf-8?B?Q1JadkFIVCtwczFDVFRaUHZRdHFsT3JwTWRYOXZoTG1WMzNieUh1eWRrSVVo?=
 =?utf-8?B?VzB0NlRPMW1PazZyNmdzUnRIY0N4TmlQWmxvYmROMTNGN016RSs4UUdxR3pa?=
 =?utf-8?B?b0RhRy9xNUVYT1lhdEFGeGYwdURZdS90ekpUU21ReTd5TVVaV3dxQkFBbXUr?=
 =?utf-8?B?YjdyTG9TMzc2endwNm5jYUZaKy8yNEUrU1dzRmpSeEh3aWhuSnVWMW9EcEIr?=
 =?utf-8?B?K0RBR2R4aFRsbkI2WWx1UU1EN0NLYTRCaFdqU3UzVTNMejBpVU8wSUdBMjJS?=
 =?utf-8?B?dGtQTEJEa3dNOHRJSHBjRm1xemR4b1dZbk5jWlM1WkcwUWV2THBudlVVV29k?=
 =?utf-8?B?djN2MzFtUG9ONW11bGc0RTBHU1RFQWwrMGI4bW5sMnJvRUtzOVl6Q0p3Z3BI?=
 =?utf-8?B?ZXR1cUFFMUtuZTFjRjNPN1ZNQkZsZ0pvODk1ci9TTUkzaEVlUDRHejdLeW1P?=
 =?utf-8?B?eVJVcndkMWhOQ0l5c3ZNNkZVbk14OEJGYUIwSmlEa2tqdkNLbmxIMU1NeGRS?=
 =?utf-8?B?dmM4U2dpb0lBZklkcDVuVjRPdWs0eGNEa1R5QW1ML2MzN01CcHZOWDAyOXRr?=
 =?utf-8?B?VVFlQmd5K09iNFAvWWRvelo2VEFYMEg1UklaV0t3aFI1SGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVRnTGR3YWVYUUJxTEs1MitTbVEvVkZuVGZEUDQ2TE5CSDR5dlo4UWpIcjlB?=
 =?utf-8?B?azdFZTRzZ1BVNXRocHhSVXBySmtIMjFrUWo3ZjJPamNoRk1aS21waVk0cFdL?=
 =?utf-8?B?SHBUWnd5RzFUMkhOOWFwUDZhc3RsZlNvdHBtaVpmZzZBelNOdCtCZjFHc2Rx?=
 =?utf-8?B?ZEtienFNQ3l4YVJNaDFZSGFuNzJGSklLVzRCT1dGUG5VQ0VvajdqRjZRYjVR?=
 =?utf-8?B?R1ZVVDVpa09SVzR3bkY2V2VrOURSM3plZUR6Vk1SNGJaZkkvM2NiQmlpNEIy?=
 =?utf-8?B?aXNWU1NkWDNkWWlRcGJMMlN3NUlEeGZRRklPUDFDN1BiUENRMGN3a2pJV1Jo?=
 =?utf-8?B?bWtvdytuK1drVmY1ZjN4NXh5WFZONDhYRUtsaEVaWi95UlArSjgra2N3QSs1?=
 =?utf-8?B?ZVczRG0rMFZ6Q0JTMEl1eEJ0RXRsMlZXUUQ5S1VOaVVpdElxZElTNE9PdStB?=
 =?utf-8?B?V3NUc0s4KzBVR2NSbHN1WmVLWWh1S0dLbEtPQ3hTdGFYR0xZK2dzQ1FLVE9R?=
 =?utf-8?B?cngzUFhXYWtxRWNBbGpWMCtZb05udW5GTTR4OGJTMmEvZnBCTE42NEY1aWZv?=
 =?utf-8?B?MlluUzZrdFQ3d3Z1eGxPeHhhQThoeGpZLzNoNzljZ1M5OXVSMEdJeEliUThj?=
 =?utf-8?B?MmpoN0xzYmxrNWxsa0hWcDM4d3IveDE2UmxKbUdzOGM1S3pCZHRaRnNEa3da?=
 =?utf-8?B?TGJWN01WTDRQQWNjWEhyV2Z0VDVSUnFJWHN1TlhhSkFFbktUT29FYkVKc0w2?=
 =?utf-8?B?ZnRrRzRFczRoUDR5UWpCbnFWNHRHTXJ3dWlCcnRMQUROdkRGbWdZcG5WQjQ4?=
 =?utf-8?B?bVpENTkrN0ZBMDlYbGVjOTZKVE9wUlZEajZ6eFRNK0RWSVRNSGltVjVTT25F?=
 =?utf-8?B?NnpnY1BCaFM5dVE1OFhGTis0cVRKNGZGWTF4V0tCRXVCWXlFSUh4WnBMYXND?=
 =?utf-8?B?SjBITUhHQXNJTGhyYWZxdGVSR3BLL0N3NWVCSC90UWNmY0tpVVFHMElxMVNx?=
 =?utf-8?B?RWYyd05qKzFFNXZhMWE4M2g5TWpCNG1vVzFWOTYzc093UEE3S3UrSVRhZmI1?=
 =?utf-8?B?VEtKY2EwV0xTeDhvZmtFeTcrUnkzV2Fidjd0NVVqSExDZWpmT2J5SGlwY2l0?=
 =?utf-8?B?SWp3SklEUGx5WkhwOUhlRzVJTmRTcWNTOWhuQVY2ZGhtZTNWM0dxdU0yaCta?=
 =?utf-8?B?aEJUOWkwMkM1L2hMSWZwWDdOVHpJQWxaV01YR0tHMFRFVFc3QjJqUVhKYVlH?=
 =?utf-8?B?RXdFOThkZGw2WmlxR0N4MXFCUk1peWY2WFJKQUh0aWJNNk9tdTdaT1BZNU40?=
 =?utf-8?B?aGsrd01uNjlKa2N2ckE3T05tRkhTdmJjR1JheHpCUHYxS0lRNVZKKzFBZGpn?=
 =?utf-8?B?ZW5ZQUsrQ0djRWUreEhlVXBLVzZFTDNjN2pGU1U2TWsreTd1ZE1vbUFIaG5L?=
 =?utf-8?B?T3RncFJ2dVpJallXVldFZ0FVRm1pNHcrd29TeDljVkxBWGZkd2g3WnFtcmlL?=
 =?utf-8?B?SjR5TS94d0F3dG1keHJyT2gwUmhGV3p5NU4zaTlpWi9oS2h1akpoMU5xUTNq?=
 =?utf-8?B?ejJrM1J1RnNVNkxVZU5ndzVoZXBKb2tMckNubHZyVVpIa1lpUC9jRWU5ejh5?=
 =?utf-8?B?aXdTczZ3NCtNdUk4RmJ3SjY1R1Yzc09UQTIwWW1hZGtuNHhscTZTckFubDdh?=
 =?utf-8?B?MG1yRFozcUNiOUpoM05VNHd6MERsNkovTmhkZmF2UHFzNVFnZjhnSnNOYmFt?=
 =?utf-8?B?VDRaV1JCQkVoMEpGY3IwcjErRTQ5V0tQdzF5azNSeStBMzFMbG9hODBjemJ5?=
 =?utf-8?B?MzR0bEVqQVlMYVRYUVR6OFhVVzkxL1RWcU5CVXFJQUtVQmQ0Um5tL3J2ckdq?=
 =?utf-8?B?emh4a0NEL3ZOYVBYa3YwSWt3enhwVzQ2YjhycUxKYXZIZXcyMHg2UGxnUjUz?=
 =?utf-8?B?U0lTdTZwYS9hQ3p0SGlHa0xSdzMwY1h5WWxMMGMvUVF6aWtwSDFIeUJodEF1?=
 =?utf-8?B?VG5BYURwN2pEc0VnZUtGYk1qUVE1cllUNGJIbFpicmZ0eFVaVXZaZnkycEJP?=
 =?utf-8?B?STdLZnQreGxEcHBjVkY5ajZLSTZnTGNJTkFnZ3Vld1lJa1FBRFl0V29RcnBW?=
 =?utf-8?B?YmJQOE0vZ2plVUQ4UkpncFZwMHlwVjZzQ2RhREorbG1takJIcVc0S3F4WGpT?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 138d3ff2-a3b2-4eb8-e877-08ddd9845a58
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:41:03.2291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joz5XU/nuw1TkueXEgM+PyhCBi3+xlr4uX11CjEHRxE2WCBGDBfNNodXqMYS9svHIyKvFiZZObg94B/3vXLtSUr+UwEqxkVQWsJg1bcCXbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6950
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> Make use of the spi-mem direct mapping API to let advanced controllers
> optimize read/write operations when they support direct mapping.
> 
> Based on a linux commit 981d1aa0697ce1393e00933f154d181e965703d0

Please use the shortened SHA-1 as described in [1]. Same for the other
patches in this series. In this case:

$ git log --abbrev=12 --pretty="%h (\"%s\")" -1
981d1aa0697ce1393e00933f154d181e965703d0

981d1aa0697c ("mtd: spinand: Use the spi-mem dirmap API")

[1]
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> (mtd: spinand: Use the spi-mem dirmap API)
> created by Boris Brezillon <bbrezillon@kernel.org> with additional
> fixes taken from linux-6.10.

Nitpick: Linux 6.10

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 185 +++++++++++++++++-------------------
>  include/linux/mtd/spinand.h |   7 ++
>  2 files changed, 95 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 3a1e7e18736..c1b8b9627f2 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -41,21 +41,6 @@ struct spinand_plat {
>  /* SPI NAND index visible in MTD names */
>  static int spi_nand_idx;
>  
> -static void spinand_cache_op_adjust_colum(struct spinand_device *spinand,
> -					  const struct nand_page_io_req *req,
> -					  u16 *column)
> -{
> -	struct nand_device *nand = spinand_to_nand(spinand);
> -	unsigned int shift;
> -
> -	if (nand->memorg.planes_per_lun < 2)
> -		return;
> -
> -	/* The plane number is passed in MSB just above the column address */
> -	shift = fls(nand->memorg.pagesize);
> -	*column |= req->pos.plane << shift;
> -}
> -
>  static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, u8 *val)
>  {
>  	struct spi_mem_op op = SPINAND_GET_FEATURE_OP(reg,
> @@ -249,27 +234,21 @@ static int spinand_load_page_op(struct spinand_device *spinand,
>  static int spinand_read_from_cache_op(struct spinand_device *spinand,
>  				      const struct nand_page_io_req *req)
>  {
> -	struct spi_mem_op op = *spinand->op_templates.read_cache;
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	struct mtd_info *mtd = nanddev_to_mtd(nand);
> -	struct nand_page_io_req adjreq = *req;
> +	struct spi_mem_dirmap_desc *rdesc;
>  	unsigned int nbytes = 0;
>  	void *buf = NULL;
>  	u16 column = 0;
> -	int ret;
> +	ssize_t ret;
>  
>  	if (req->datalen) {
> -		adjreq.datalen = nanddev_page_size(nand);
> -		adjreq.dataoffs = 0;
> -		adjreq.databuf.in = spinand->databuf;
>  		buf = spinand->databuf;
> -		nbytes = adjreq.datalen;
> +		nbytes = nanddev_page_size(nand);
> +		column = 0;
>  	}
>  
>  	if (req->ooblen) {
> -		adjreq.ooblen = nanddev_per_page_oobsize(nand);
> -		adjreq.ooboffs = 0;
> -		adjreq.oobbuf.in = spinand->oobbuf;
>  		nbytes += nanddev_per_page_oobsize(nand);
>  		if (!buf) {
>  			buf = spinand->oobbuf;
> @@ -277,28 +256,19 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
>  		}
>  	}
>  
> -	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
> -	op.addr.val = column;
> +	rdesc = spinand->dirmaps[req->pos.plane].rdesc;
>  
> -	/*
> -	 * Some controllers are limited in term of max RX data size. In this
> -	 * case, just repeat the READ_CACHE operation after updating the
> -	 * column.
> -	 */
>  	while (nbytes) {
> -		op.data.buf.in = buf;
> -		op.data.nbytes = nbytes;
> -		ret = spi_mem_adjust_op_size(spinand->slave, &op);
> -		if (ret)
> +		ret = spi_mem_dirmap_read(rdesc, column, nbytes, buf);
> +		if (ret < 0)
>  			return ret;
>  
> -		ret = spi_mem_exec_op(spinand->slave, &op);
> -		if (ret)
> -			return ret;
> +		if (!ret || ret > nbytes)
> +			return -EIO;
>  
> -		buf += op.data.nbytes;
> -		nbytes -= op.data.nbytes;
> -		op.addr.val += op.data.nbytes;
> +		nbytes -= ret;
> +		column += ret;
> +		buf += ret;
>  	}
>  
>  	if (req->datalen)
> @@ -322,14 +292,12 @@ static int spinand_read_from_cache_op(struct spinand_device *spinand,
>  static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  				     const struct nand_page_io_req *req)
>  {
> -	struct spi_mem_op op = *spinand->op_templates.write_cache;
>  	struct nand_device *nand = spinand_to_nand(spinand);
>  	struct mtd_info *mtd = nanddev_to_mtd(nand);
> -	struct nand_page_io_req adjreq = *req;
> -	unsigned int nbytes = 0;
> -	void *buf = NULL;
> -	u16 column = 0;
> -	int ret;
> +	struct spi_mem_dirmap_desc *wdesc;
> +	unsigned int nbytes, column = 0;
> +	void *buf = spinand->databuf;
> +	ssize_t ret;
>  
>  	/*
>  	 * Looks like PROGRAM LOAD (AKA write cache) does not necessarily reset
> @@ -338,19 +306,12 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  	 * the data portion of the page, otherwise we might corrupt the BBM or
>  	 * user data previously programmed in OOB area.
>  	 */
> -	memset(spinand->databuf, 0xff,
> -	       nanddev_page_size(nand) +
> -	       nanddev_per_page_oobsize(nand));
> +	nbytes = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
> +	memset(spinand->databuf, 0xff, nbytes);
>  
> -	if (req->datalen) {
> +	if (req->datalen)
>  		memcpy(spinand->databuf + req->dataoffs, req->databuf.out,
>  		       req->datalen);
> -		adjreq.dataoffs = 0;
> -		adjreq.datalen = nanddev_page_size(nand);
> -		adjreq.databuf.out = spinand->databuf;
> -		nbytes = adjreq.datalen;
> -		buf = spinand->databuf;
> -	}
>  
>  	if (req->ooblen) {
>  		if (req->mode == MTD_OPS_AUTO_OOB)
> @@ -361,52 +322,21 @@ static int spinand_write_to_cache_op(struct spinand_device *spinand,
>  		else
>  			memcpy(spinand->oobbuf + req->ooboffs, req->oobbuf.out,
>  			       req->ooblen);
> -
> -		adjreq.ooblen = nanddev_per_page_oobsize(nand);
> -		adjreq.ooboffs = 0;
> -		nbytes += nanddev_per_page_oobsize(nand);
> -		if (!buf) {
> -			buf = spinand->oobbuf;
> -			column = nanddev_page_size(nand);
> -		}
>  	}
>  
> -	spinand_cache_op_adjust_colum(spinand, &adjreq, &column);
> -
> -	op = *spinand->op_templates.write_cache;
> -	op.addr.val = column;
> +	wdesc = spinand->dirmaps[req->pos.plane].wdesc;
>  
> -	/*
> -	 * Some controllers are limited in term of max TX data size. In this
> -	 * case, split the operation into one LOAD CACHE and one or more
> -	 * LOAD RANDOM CACHE.
> -	 */
>  	while (nbytes) {
> -		op.data.buf.out = buf;
> -		op.data.nbytes = nbytes;
> -
> -		ret = spi_mem_adjust_op_size(spinand->slave, &op);
> -		if (ret)
> -			return ret;
> -
> -		ret = spi_mem_exec_op(spinand->slave, &op);
> -		if (ret)
> +		ret = spi_mem_dirmap_write(wdesc, column, nbytes, buf);
> +		if (ret < 0)
>  			return ret;
>  
> -		buf += op.data.nbytes;
> -		nbytes -= op.data.nbytes;
> -		op.addr.val += op.data.nbytes;
> +		if (!ret || ret > nbytes)
> +			return -EIO;
>  
> -		/*
> -		 * We need to use the RANDOM LOAD CACHE operation if there's
> -		 * more than one iteration, because the LOAD operation resets
> -		 * the cache to 0xff.
> -		 */
> -		if (nbytes) {
> -			column = op.addr.val;
> -			op = *spinand->op_templates.update_cache;
> -			op.addr.val = column;
> -		}
> +		nbytes -= ret;
> +		column += ret;
> +		buf += ret;
>  	}
>  
>  	return 0;
> @@ -819,6 +749,59 @@ static int spinand_mtd_block_isreserved(struct mtd_info *mtd, loff_t offs)
>  	return ret;
>  }
>  
> +static int spinand_create_dirmap(struct spinand_device *spinand,
> +				 unsigned int plane)
> +{
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	struct spi_mem_dirmap_info info = {
> +		.length = nanddev_page_size(nand) +
> +			  nanddev_per_page_oobsize(nand),
> +	};
> +	struct spi_mem_dirmap_desc *desc;
> +
> +	/* The plane number is passed in MSB just above the column address */
> +	info.offset = plane << fls(nand->memorg.pagesize);
> +
> +	info.op_tmpl = *spinand->op_templates.update_cache;
> +	desc = spi_mem_dirmap_create(spinand->slave, &info);
> +	if (IS_ERR(desc))
> +		return PTR_ERR(desc);
> +
> +	spinand->dirmaps[plane].wdesc = desc;
> +
> +	info.op_tmpl = *spinand->op_templates.read_cache;
> +	desc = spi_mem_dirmap_create(spinand->slave, &info);
> +	if (IS_ERR(desc)) {
> +		spi_mem_dirmap_destroy(spinand->dirmaps[plane].wdesc);
> +		return PTR_ERR(desc);
> +	}
> +
> +	spinand->dirmaps[plane].rdesc = desc;
> +
> +	return 0;
> +}
> +
> +static int spinand_create_dirmaps(struct spinand_device *spinand)
> +{
> +	struct nand_device *nand = spinand_to_nand(spinand);
> +	int i, ret;
> +
> +	spinand->dirmaps = devm_kzalloc(spinand->slave->dev,
> +					sizeof(*spinand->dirmaps) *
> +					nand->memorg.planes_per_lun,
> +					GFP_KERNEL);
> +	if (!spinand->dirmaps)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nand->memorg.planes_per_lun; i++) {
> +		ret = spinand_create_dirmap(spinand, i);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct nand_ops spinand_ops = {
>  	.erase = spinand_erase,
>  	.markbad = spinand_markbad,
> @@ -1134,6 +1117,14 @@ static int spinand_init(struct spinand_device *spinand)
>  		goto err_free_bufs;
>  	}
>  
> +	ret = spinand_create_dirmaps(spinand);
> +	if (ret) {
> +		dev_err(spinand->slave->dev,
> +			"Failed to create direct mappings for read/write operations (err = %d)\n",
> +			ret);
> +		goto err_manuf_cleanup;
> +	}
> +
>  	/* After power up, all blocks are locked, so unlock them here. */
>  	for (i = 0; i < nand->memorg.ntargets; i++) {
>  		ret = spinand_select_target(spinand, i);
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6fe6fd520a4..163269313f6 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -363,6 +363,11 @@ struct spinand_info {
>  		__VA_ARGS__						\
>  	}
>  
> +struct spinand_dirmap {
> +	struct spi_mem_dirmap_desc *wdesc;
> +	struct spi_mem_dirmap_desc *rdesc;
> +};
> +
>  /**
>   * struct spinand_device - SPI NAND device instance
>   * @base: NAND device instance
> @@ -406,6 +411,8 @@ struct spinand_device {
>  		const struct spi_mem_op *update_cache;
>  	} op_templates;
>  
> +	struct spinand_dirmap *dirmaps;
> +
>  	int (*select_target)(struct spinand_device *spinand,
>  			     unsigned int target);
>  	unsigned int cur_target;

