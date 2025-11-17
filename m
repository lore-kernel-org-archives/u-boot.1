Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97A4CEBF93
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 09:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00CCA83B0B;
	Mon, 17 Nov 2025 10:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LuU6m8yW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 176A083B4F; Mon, 17 Nov 2025 10:05:48 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E782683B0A
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtYPEF+kzpiK5YsyDkI/5HJ0gKmoMidw+86dYJClth6HjEF7fE29oIJxKeFgw/1SCDNKgS05r6IwzUwRaGWlBzbGACINFR1l/Udc+BM7gqiavvf+fiSM6YAed8yi9GYG2rSv2tBxgK6sb1Y2vi4oe9sBaMsvrK1WKlc1fxlwsIJUQqBpv5e+cPA7ngyBqswN81G7oysUZWJy3K4BWJ6R6h3mvOdSjj1L6sJ7XPoenTxPDUhYaRte8vaKL50O4aquh/gkxyjwhF65rtnbYWUpzBmZ+SCuH0h0ZXK46bHFkhUMC2+R3p0YwFmIDQt0kJfzhK3b516JKupqWcWLfKrfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjVChetLJ2p8YHjh/HUwaePuZESzc2JedJ+DWfTGgTE=;
 b=vXP1zwTwJppNpehxna8p/9JfX9gb+ecVWF0uBlZB4PQjBwnnGQH6BGbmqhz0RikdPYku88jCVy1lcA/p5JjHhZUWNxrLeWaMJtyyRNDxEkRbqjxMOMsaQXMneeYQeLQHmpF0bFjIHLl3n/g1PFAvpnc0B/chvovAMvoEwjQ/C2HAvEhrKDRb+wHt6fw9H/aigj1Oc11l9fLM7W9GwPusDHE8qoV3Nc2pUEEYxE7Xz78QVtEWj9KxNwhG4CxUVf5ceXArKwGBOtKuuvFywKLY+q6ms7AXv2XGRevNAb6mVgIy08z47ar4TZERWrOuwxUExqvhXPMsa1ryulIJvMkCGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjVChetLJ2p8YHjh/HUwaePuZESzc2JedJ+DWfTGgTE=;
 b=LuU6m8yWetNneiz90gtDbTjWgSMB5Tr7Mpb4jiMux8Pzt4JC6P+yvAwpxQ6DBWMJjOIRjK4YodQ5jjwq9IGFmgFkSGcODYmRS2uL01WAa0M5zF7+R7ifFkcf+XrTGuzv+L9g4jcMfhzKDBmU4DM9AnTwgD3GG4m/S2mhFSD2K/nAn0YKtjoYWYy2EH9ELbeSBbFINq9uVH8Smh1oTItYN/ISkP/ffNO8hgW8jOkePl7jDt53okjyz/xJaQkuUe88GV/zeW+6zwIglSsx6viltYmc1ZPG/z5OC2biPf70/v5GjeuY0Pr6w19J6KkJignFqQtsw2y+dQVtfvaqk/VJbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN6PR03MB8006.namprd03.prod.outlook.com (2603:10b6:208:4ee::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 09:05:42 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 09:05:42 +0000
Message-ID: <c38b9cf0-77c8-4d8e-a681-b53d7db79043@altera.com>
Date: Mon, 17 Nov 2025 17:05:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cyclone V Board handsoff script
To: Brian Sune <briansune@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251031180419.1235-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251031180419.1235-1-briansune@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:195::23) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN6PR03MB8006:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bc98a6-0c0e-4250-2e3a-08de25b87c2f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWE0NnhiZitlYmR2QVFWK0NueFlGRnAzc1hwKzBoYlIydFphMk83UmNFZFhX?=
 =?utf-8?B?d3BoSmlXbVJFU0h0WTQ1TkNRWlU0WFJyZForZG85NCtpMGZyVkw5cjhTRW9Y?=
 =?utf-8?B?M0VZRDI5S3pOeURvclAySDBFSmM5ZEdhNTZTQ2JTSXFIcCtvYkdibGxtWUR6?=
 =?utf-8?B?dElCYnJ6NVZwTWMwMWtoRmc3NGQyZjFpNEhTc0VBQ2FWdXhraXRGekdTTHll?=
 =?utf-8?B?K1phOXJWaUhPeHZqZ2RpMmdsUW5uVkhVamx5NDdmbHl0cVhYOGFHZ0xMYVov?=
 =?utf-8?B?YmtMMkhoOTFKMFQ4WE5Kb1JQZXBEQUU2Z1J5R3VCUXZKcUNjZlhYT3A4Nk1x?=
 =?utf-8?B?ZzJCNXpkUzAvUW0zQjA0RDBibjNLNXhGRlJIbEdpYmdOc2YxMXVwZDV5ekV2?=
 =?utf-8?B?NmV4Q3R1QVhoME96WEMzdVZJMTdIT3RHdTlzN2NyZU45UDR2bHIrOTduaW82?=
 =?utf-8?B?M2ordlkwdHArTjlldVBsZzVtZ0JFL25XRFNPbEJoYm9WTXhQZE10NWtCS0Ra?=
 =?utf-8?B?Z2FHd1pvelY1VzZwWHRUMmhxdmdDSjFlVDloTGdiLzczWEdZZVJjdThJU2pw?=
 =?utf-8?B?MWhQamlzaVZwMTlNM2JrbkdZL2lSUlpuR2d0TlFNMDlwMFhldmdFbjRlb2p2?=
 =?utf-8?B?N2VXK1k5Z2QvdVlzZFRQVzlmQmtrb2k4VGl3QUVhajFMYUdKNVV1aUdTMEVz?=
 =?utf-8?B?ZkpUaitsMGdwYXhIYW1jVUJoTzdsUjdVTDF5dUFtMlo4YTFnOWpHZHd3ZzB0?=
 =?utf-8?B?NTBWWjYrNmRCeDlrQ3FRelJ1RUpoa1cxaGlpTHUraUhXbEp4ak94V1FEUktr?=
 =?utf-8?B?Z245RUZscjZJMkxPRmZDWGI1R3hsTmlyT2oxSXUyQlh1Z3M0L3JjeWVmVjM0?=
 =?utf-8?B?WWQwK2htbnNlK1VHNzNhdkJrQTBKdUxiQnhqekMvcllXQ3h5MnBKZkM5bWlE?=
 =?utf-8?B?UDBPalJ3OHo4cFJWMjNHRGNnQ3dNakpYNUVqL09FRDE3MDZtV3hjaHlLMUdL?=
 =?utf-8?B?V1JvbG1vQWhsaGpXNHkvN1lZKzl5a3JrNU9xN2JPWiswUW4zM3diYWtLOWcz?=
 =?utf-8?B?Ukl0VjNMeVA1d2JTVzZ1cnY0QzFFVDViYUFHaktZVVd1V3VXTUt2Sm42TVFr?=
 =?utf-8?B?UWFtbjFlVzNBOGpYOHFpYkJ1Q2tkVml1YkdkMWhHT3ZEcU41Qng2WmNudGlr?=
 =?utf-8?B?Y3kwb2o1VEdET2RNUW1rVEJQQnpZbWM3L3pQY3BXcmw0aHNnd2FvTURrVkRK?=
 =?utf-8?B?dUhjc0JhbjExUDkvU1FUU3MzNkEzcXkyQURoQWlTSkJNYm80QjcwbDZpcFVV?=
 =?utf-8?B?OXA1NHZFRVFmakxFYkFCc1VqNHREdUpYVW5Ca1pqeWdoOHBXYmNUa1NNSDhR?=
 =?utf-8?B?NWVkcXhYWGZRMnBpSE1JZDhxR1FEWVVlelhNOTVzMWtlT053RExleUQ1aWQz?=
 =?utf-8?B?bFM3M3BLSXdiU3dzRmRRb1I3U1B4QitQc1J5SUJ0N1VubFdKdXBvSTB6WE83?=
 =?utf-8?B?UFZ4QWpzaGhqNkJXK1BuVDFPUkZPSHV5blJVODBOSHp5RjJIaWFqSWFqZGZK?=
 =?utf-8?B?SFY0Zm9GeC9tNnQ5QThYc1JCb2VJaER6eUFJV3ZLUlNxcUN5MFBFQ1J3M09C?=
 =?utf-8?B?V2tSaXc4bkpERzk2VUVjUzhFVlM0eEE3Q2FpUndHTlBNUUxwTENBQjhrcHJS?=
 =?utf-8?B?WDYrTVppQlhGV2UwZ2wrZmRGbGR6Y2lIZVZCcTN5aUVrQ2VRdnZ6bWRiSXJ2?=
 =?utf-8?B?cCtoN2tzcVBnUzZCbk5teWtya0EvWGVRZjc0Unl1UHNYZ3BsYndFaGFYMDRV?=
 =?utf-8?B?clRNcW5FY2dyNFN6bUR0WEZRU21Qc3ZVcEJSaTAwelRkb3BpL0J3Z2FPNnI2?=
 =?utf-8?B?K1UwSDBKRzVaT1FmTkV2aFhqSC9JNVk5ekg1ZGoyR1FDTnBGOXNSdUVLNmFt?=
 =?utf-8?Q?80t5BzIIl7KzJbU9+exs1jVOs+hE75om?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmwzUk15R2NWc096ZEo2NU9tM3RGcGV5c1hld1Fxc2NjZkIrQ25ENFlsNk9l?=
 =?utf-8?B?WEZqb0N5WERTVG5DR0hCRFQxdHl3eUdUUGw5eldTU3ZFL0pCQUl5VWFDM21a?=
 =?utf-8?B?b21Hbkpsb2NxeGxFWlNoN2JqSHJYYjl4T0lwdTlTTkdjUWRPQXVzTEo0TXFQ?=
 =?utf-8?B?Sk1IbnlHMVRlVFhCMkVpUmtLZnFGbUNKSUdQc1c2ZG1yb3M2UFc3ZUJNQjlS?=
 =?utf-8?B?NFB6NzhidHhWMlI3bWp6eFdZS2xxZWgycHdVdmhWRnJHZHhvWFFkR2RsajVS?=
 =?utf-8?B?RUhjU3dJVVJOYzBxV1hGY2ExTkptUmpsbUhGYXhhYWxlQWR6bEJ3cWpCQXFh?=
 =?utf-8?B?NlB3QzdlYUFnbC9PYTlRcitCV1B4dzRaVlpISjJtWDRXR0ZXdEtMWXhISDdQ?=
 =?utf-8?B?bzdjRmJreGl5dnRkbkhPU0RjVGt0YTVhL1FzN3VzTWNvWkQrRUJvTStUZ0ty?=
 =?utf-8?B?SWs2OHl4UkoyTEM5QmVXOXNJNDFHcmlJZ0Jsc0VPV1htcGExRnFVNWdnM0tw?=
 =?utf-8?B?ZG9WWEttMGwySjlVazh6eXBOazN6L1c2RlIwbTBXU1BvUjkwdlhkZnRscCtG?=
 =?utf-8?B?OVdLQ3FYblRralRhcUE2NGdKemRBV3g5UzBZcUlYT3VDU21LMlk2MFpwWnpM?=
 =?utf-8?B?c1ZqTDdjbE1NUEQ1Vi8vMnpDalJuQmhwaVUrTk0vMElZcXZRUEN2bFBuaFBq?=
 =?utf-8?B?UDhiZ1pVeHJMUVdNUkdubXhFbTVxajRxUzhlUkxMRmVSRkQyWFNxZklhRGhM?=
 =?utf-8?B?dGE2bmV3OTY5TTZURGcwcFozNU9yUWo4WnpGN1RlV0N2OFZYR0FoUlowbi9N?=
 =?utf-8?B?UzJUYUhEVkJNdjl1TCtaWklybFlOWndXNWlnREpURzZ3UjBTUjkwb3hpa2lQ?=
 =?utf-8?B?Uk9ZS0d1eGxxYU9zb2pnQzRJWTZoRkdXTDJBZGl3eStnL1didmNiZ2xtc0Z2?=
 =?utf-8?B?cUdVQ3FuNk5PNEhHbnJFWEt1RnBObjVkTzVDeVJndVF1K3g5RjNDcWFxMzN6?=
 =?utf-8?B?YU5CRk5XNFpBOGFYWjZ0WEdRdmY4dkgwWWZ3T2tvREtJYUxtZnBKYmkyTmFR?=
 =?utf-8?B?VEZxeDBNU1lVUFpMeENiZDJRTk5FN0J2NnZzL3ZWTXdPeFIyQ3UrN0Zwb05a?=
 =?utf-8?B?QmZwZVNrdDRidTBydkNaczFRbGRwMm9JN1ZpOHVUdkR2M3RCK0QyRmlwRWRH?=
 =?utf-8?B?cXc3cTJHTWkzUDkranJRekVxMXZmR0QxL0J5Y2ZxYUl1U0ZBcE1jdDFKWTIr?=
 =?utf-8?B?SHNpUVovemlHUjZNVno0am9zU3RIZTNyYTVkMGVLSmZWSWZxVHlVZG1HejU1?=
 =?utf-8?B?cDdTNTB1Zy9mTE1IODJzRXIvT2p4TmpzckN6bXJIYW84aUpWWjBLaGJDRC9i?=
 =?utf-8?B?SVRrOFdzTmsxOXU2RmU0Z0tEbmU3b3dndVFJMkNNTzhKcjJta2s4OXNLaUQ5?=
 =?utf-8?B?ZjN3TVVhdE9jL0VlSmtBZzgxYlg0NFQ4UGIyNURXY2RIKzBLZFY4SSt3aER5?=
 =?utf-8?B?eWJrckdqUHB0Y29uRmFJQTBUV3hFTXVpUnQ0ZGZvY1ZPR0s2cy9ZQjlTKzhM?=
 =?utf-8?B?UEEwaE5lK3FyTkM1bEJ3dEo5aUFVRjk2YkxWRnd6S095R2ljVSs5UmZLVUd3?=
 =?utf-8?B?TXpGZ2hDTWtBbldsZlZnWnVFaXNVTDVMdHEzQkNmZ1g3SzhQN0FBbkVBTC90?=
 =?utf-8?B?Q283TlQxVVVZaEcwWnBrMkNMUDBkc2E5THRia01Zcm1hSGptamY1WnRDVFlp?=
 =?utf-8?B?RmpSSEVESGJzRmpKelMzYnJnSTFCcmZjWHhQVHFHODdWakcrZG1kMnVDREdz?=
 =?utf-8?B?Tmhxd21lR245T2owc1JyYWpEYjlsQm50V0JObmxLNVFHdUtNY3lIcEZ5M1BH?=
 =?utf-8?B?ajFCTTBhTlhzNHJ3dVV2U3JMN0FkbDc5b3V3bGxyK1pzc0VnMmFCa2NpVUs5?=
 =?utf-8?B?TW52UkVoR0VlWXJwUTZHeFplS2gvNnZtVW9ac0RFci8yN3ZsSHI5M1BsaFJN?=
 =?utf-8?B?UFVuUWdkN21zSWMzeEtPeU5jOG1zMnpRL2hSTWEyU0FlbHRYS1phNVIyMlFG?=
 =?utf-8?B?Qjd6bnpzazhSbVQrT0FnUUdNK1dnSjArR0pNZE1neEI4cXVWd2xVcUJZdmVx?=
 =?utf-8?B?cEVQMDRPM25hMktRTlFNWWhqTndTQis3V1p0aGdlZU1zTkZpa1JWckh4VFVu?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bc98a6-0c0e-4250-2e3a-08de25b87c2f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 09:05:42.4542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AdTSsQdarxdWoPbbcwcWms55mWrZNtsbWnbdGNKqS8lNmn82ZszUNNpfMb5pf2TvcrMMi3SW/QFzdZ2ArmtGf3EgBC4eGep5SRLcXqT5Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB8006
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


On 1/11/2025 2:04 am, Brian Sune wrote:
> Since turning from old build flow.
> New Altera SoCFPGA requires converting handsoff
> conversion via the python script. This is from
> official provided, and now sync to U-Boot with
> better location at tools/cv_xxxx. Meantime,
> requirement.txt is also provided to further
> explain the libraries require for these scripts.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>   tools/cv_bsp_generator/cv_bsp_generator.py | 100 ++++
>   tools/cv_bsp_generator/doc.py              | 243 +++++++++
>   tools/cv_bsp_generator/emif.py             | 424 +++++++++++++++
>   tools/cv_bsp_generator/hps.py              | 571 +++++++++++++++++++++
>   tools/cv_bsp_generator/iocsr.py            | 203 ++++++++
>   tools/cv_bsp_generator/model.py            | 114 ++++
>   tools/cv_bsp_generator/renderer.py         | 196 +++++++
>   tools/cv_bsp_generator/requirements.txt    |   5 +
>   tools/cv_bsp_generator/streamer.py         | 102 ++++
>   tools/cv_bsp_generator/xmlgrok.py          |  32 ++
>   10 files changed, 1990 insertions(+)
>   create mode 100755 tools/cv_bsp_generator/cv_bsp_generator.py
>   create mode 100755 tools/cv_bsp_generator/doc.py
>   create mode 100755 tools/cv_bsp_generator/emif.py
>   create mode 100755 tools/cv_bsp_generator/hps.py
>   create mode 100755 tools/cv_bsp_generator/iocsr.py
>   create mode 100755 tools/cv_bsp_generator/model.py
>   create mode 100755 tools/cv_bsp_generator/renderer.py
>   create mode 100644 tools/cv_bsp_generator/requirements.txt
>   create mode 100755 tools/cv_bsp_generator/streamer.py
>   create mode 100755 tools/cv_bsp_generator/xmlgrok.py


[...]


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

