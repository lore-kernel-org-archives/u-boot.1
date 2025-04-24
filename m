Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988C0C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E21E81FDE;
	Thu, 24 Apr 2025 08:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FCXUZWqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1474809A5; Thu, 24 Apr 2025 08:34:36 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19AFD82103
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xF6iK6iDJFkCA257hJmc59q2dP1Lz+u/VKz0ta87d30HHawqv+60Dv7jDAhNd7TktUaAodlB9vPBn6qDlZ9gTm8PNQZtbFmcwP5E/7CvPJ9lG5FZY62rVwZBjayTtpbNuqjeA3bHe0wPJxKZjm4EoUTpKnGsWdpZBGnw7AG2NG6TRSCZkAWnYceKpimHSBzSBJ2O6LuFWx6z/HRDyYGcVeHOU7ps88KsIwZL8q9VskPXVBV6qq6pgq8w9Lh4kRRuCdbqw6ScAbl+N79Tz2VlCFHEX08BKPdHve9gLeICMqyWPOIbcHXkvsMaD7oA26S/axT+CPCypO9vW/GddxjM7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrNMcOdptZ5Nuu1ifypOWmMmnNMbSm+EviEjxYdTmzM=;
 b=jsGCv8iuvweBy1k26/fSMHc0cNnCiUbjY2oHeeoI8T7nUUScqTvT/PuBTnIBqsHzLfl1KsSQVpvvQNxaSMVMuOQLJeIhq+6lQWElxigqqsV2UfK6V+551otQde30L3F+B2nFYvZOLVfAmdueaZ5Ged1B6zfMuDyyC9U9TEj7QbOTJKEwrsIsvxiIN6sRhLiZFwglhrsrex8YoufY9ZzX4MSeF9r5ZTARJK2qvo4CzjMFNZLGhl2KLlW7cWNE7a7Kisrhm4PxRcyShghpfAAqSv094gzJUym2owURLiTthiaYqRF68tuU/Mnihf2qvR5JvF45ZfWZF0korW+fSGq9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrNMcOdptZ5Nuu1ifypOWmMmnNMbSm+EviEjxYdTmzM=;
 b=FCXUZWqQcZdzGwuJkZfJl0S8GwcT1M9vuZHRLFDuYdFLVCM2z2afYf4KMiu9GbYlhfuE9l8wFA0bYzm6pZi3w+u2PSOOC+deoIEGQ7S0jpZ5Giz/fE7OKkFqW2JDCUl/NwM5ofETHodm8ED+U4IYGqOSO8CbPSCxyWbqdyZ1wd3tH8oiyfpDTqWkUa4RkR+SlTAOSofDZnnGugK2DXZpc0BRisfeqbaAv/qcq9ywP7LyLAoCN1QgK6dN4RwfcmHY2tNcitVb9B7bnzkefmJqlrYQDRRJ8BCZPtdM5B0ULAAT9JeFf+VfeLyGT9ov6Js4MSJzjaLwYzlla7qIw0Cn5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:30 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:30 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:06 +0800
Subject: [PATCH v10 10/21] scmi_protocols: update struct
 scmi_base_discover_list_protocols_out
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-10-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: ec32b721-ff13-4c90-3bab-08dd82fa11ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzlUaEYyUGtWbEc2d1hZNExHaDVHdm1TL3RoRW5aVDMzSGpBZVZab2F1eE8v?=
 =?utf-8?B?TkRGQWgrM0t3cEFmOWpFS1NQZUZuNGcyTlFBWFkxS1RJdUdZMGpZSU9xczVE?=
 =?utf-8?B?cXF3UjJJc0lpZCtYRVpaV3l5T3RHa3I4R2N2VDdIMHYvc3VSczZlK0FlOGZI?=
 =?utf-8?B?VU1acDZWRlZseGFRUS9lRFYraTlJR0VaRERPQkpMUGJGN1krb01HRkx0Ulpj?=
 =?utf-8?B?cXhnbGk3RGd4ak1qNEJPSk5RMHJHWmJ1ZzNlbEg3WitXMk1oTk9COHJDeFM2?=
 =?utf-8?B?d0kwaEREQk52WVJ4eHRaRnF4Z1R4SjVmZ0tkd3hlQUdBZjJEWGYxZnZ1cVk3?=
 =?utf-8?B?Z05zY20xNHJLUW9RdzMrUUtuRldvMWdPKzBNSVErbVdRUlRQczlmdkhKbW4v?=
 =?utf-8?B?aXBuVi9MUUdiTTBwa3pSUHJ6OW5rbE1WYUJINW0zUUxTYkpqNkpKMzJHSmRP?=
 =?utf-8?B?amZYMGU2TVg2UnYwZ2RyWEVBQUhKaGlSSklnS3g0SEoycnpmUk1uaTRoMnQ3?=
 =?utf-8?B?d1ZrWmRpN1kyVHVOTlRYVDgzWDE4ckJQdlcvSHJwMFVIbmE5NnFBZkx5UHVH?=
 =?utf-8?B?aFQwK0doOGFYS0hNNkFtQkJHbFVXU0ZIQWdMZmhNOG9ldHNQUjNEREJ6aHFt?=
 =?utf-8?B?UmpJci9wNkg5M2pqZTZqNkx6UEd6alJyUDZrVlJCamh3SXMyWTdvQjY4N0FK?=
 =?utf-8?B?MGduOStsLzh6V0lqeGhMTWdORW81RmFQMTJobThsWjdmejFPNTZFRlRtcWJ1?=
 =?utf-8?B?L01HdXRuaHFCNDgyTmh0MFdYbHVabTVGYVhZcWVqeTA2WDdCZGtkelEwd2VW?=
 =?utf-8?B?cGRpTi9UN0w4Uk5BRGhTRVFEQWVKVjU5SjVJM1h1VHR4emRHdTRmdWtJTllm?=
 =?utf-8?B?aSt4SFA2ZlBmZnR0S0U3VlF1OHpCOG5qYUdnNEhNUUFPSjdtT3RyelhrUXZT?=
 =?utf-8?B?emhYWTQydUZtL01NcVVPMld2NUhIS2tpUVNXc0hHd2Q0S1FBQkpXdUdkNFpx?=
 =?utf-8?B?ZVBVaHp2ak4renIraHYrZkM2K25LNVhZY3A5S04zZGY5ZTA0QXVMZHNUNlpt?=
 =?utf-8?B?ZStMWnY0K1psR0lHSzFYV1ZMbjIySDBmb0diNzZFa01WUTlHM2ljcmx6R3ht?=
 =?utf-8?B?aWhoMUEzNERlNk9tUzEzN25aTkhnd3NmYWZmSndsMm81aW1nR1c4Snp2YXQr?=
 =?utf-8?B?clFjcjlHWS8vMkJHU0NWb3pqQXBwa2NxSmxOa1pVaE9UOFlUQUdhWmQvNi8y?=
 =?utf-8?B?VmczMTRrc1g4aUFmaUZTWWRwdnNiQmp3Nk81QkNRbXdRNXlWRFp4SzFNMUFx?=
 =?utf-8?B?bUFQYVV4RzIzYTVLeGdibXFITVV3UWxlbFhFc2V4cEJ3a1FObWdlVFFFcEsv?=
 =?utf-8?B?SlpyajhxTkpMVm5vUElJNzZycDdoOW9BT2JFTGFWTEdnYVBoUlpUcDhONG4x?=
 =?utf-8?B?MWxzUWhRVE96Zmg1Z2FMV1Z5NVdzNVZjekIydTg5Z1hJOUZXUndTOWo1Y3Ez?=
 =?utf-8?B?WWtGOTl0UTFUY01ERlJyNnk1ZVVhV0FXbTBvUk1uOUQ0ZEpLK1RscGkzVVhk?=
 =?utf-8?B?d004OUlxdmtGYnZUYTVQYVhrWUEwUkVIOGVNU1NnUGZtNVhJYlhFQ0xzTTYw?=
 =?utf-8?B?dGtwUzFFbVExbHFoVmRwQWVhYmJZWTIxVVJTdlNSak9FU0ZWMHMweGdjUmJa?=
 =?utf-8?B?ZkZKYXJFTG1CSzdjVHhEc2kxVUZqWnl6a1pVMHV1aC9wR2tJNnVPYmI5cWNk?=
 =?utf-8?B?ZFE2bnhIZDhjaDNSV1pPMCszN0JtTkhHTHZmdVFpZmF4c3RvYVFsNUh1Mkd5?=
 =?utf-8?B?RHFRYmdFUzVhdnZOUFBGcHlyQ29LQWpLTS9UUW9ldjJ1Wjc0K1RESTYwWEZC?=
 =?utf-8?B?QlRkOFJiSGxacWk3N3FxT1VERjdWUStnbXdiNlF3QXdkcU5XQTFJR3ozNGlO?=
 =?utf-8?B?eUIxMm5YekxhNTQ2WG9DL21hMGIzTDlwVDg5YldrVHY0WFdBRGdVa3llT1RE?=
 =?utf-8?B?UHNmTUhYUzNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVaWWtCb3hyei9sUGg3SmVDdUNDYnJaRkRkaEVWQ2wvYXczbDFEZzJyL0tr?=
 =?utf-8?B?alhXZ2hVTi95YlV1czhsZ2tRU0VkYkd1U1FBTWFZZzcrV2hJMVJzTGdxZGQz?=
 =?utf-8?B?eStkKzRRUVExTzN6MlJTelF1MzFXbVNybEFoalBzbnYwR1Jpbk84WWdMbEd1?=
 =?utf-8?B?bG43OGUyYm4xME9acXE4ZkVzYjRUNE44bGdKN2d2T3gwelQwQTJKeFFJa2Iv?=
 =?utf-8?B?ank2Z090bTlBYW9KOElHWWptdHNjakthdVlMUytUdXRmYnBZYy8wM284QnFl?=
 =?utf-8?B?SGtjRnNQNGFiMFUxZUo0Uml4MFVhMUdveXc2d2VGaEpFaW5yTGo0c0JQYUpz?=
 =?utf-8?B?OWZ3NUFSaHpRdnhTU1k5dXV6QXZKd2JYYjFodWVBblFUN0s2Y1grbGttcTQ4?=
 =?utf-8?B?ZkxXa1UyYVd2cFEwL28xcVhTS1RTTGl4bHNnMVhSb3I1UyttMUZrRlpuMTAx?=
 =?utf-8?B?MTgyRVBlNU5hMlZGQWwrazhoTGNIZjlBMEdKakdJUHg2czB1RU1yWGUwbkVu?=
 =?utf-8?B?ZWVWQW9icFRaTG5zYUJoWVB2RnpJVE93Q3ZQd0U2ZG9mREtKVjFvQjU2b2F2?=
 =?utf-8?B?UGM5bjhDcC9XUjFNbmVZOForUUNUbHllWHRRbldoWks2elRoS2tYOTNJNFBU?=
 =?utf-8?B?VDNwUGtiU21iUjZhZ25nOXlXeWUwaG5sejdrMzVtUHVLUTcxRFVwS2lDVnEz?=
 =?utf-8?B?NFd5WXpIVDNFd1RNK2xpSTNyc09nd3o1RmlIQmJBZnhteWZhQm9NeEZTUkVr?=
 =?utf-8?B?SjNWTGpwVS9oeDlhM05CclljN3loYk1jTUQydFFoUWZPcmsyZ1FJdTBNUno3?=
 =?utf-8?B?V0J6cnpTTHF4RzVMVXJXQ0IxNXFyMkh3V2RxRGt1QWIvY0VsZFpwMmdvSVlZ?=
 =?utf-8?B?b0pYTFhxUG9ERWlrYWp5ajEyMis4VTBRZ1EzZ0NjcUxjTGMyemp0L3Y0Sngx?=
 =?utf-8?B?Z3ZIZktCd0lkSVhmcWNYR3IvSFdsVndtTFZwRCtDbG9vQjBucDhJMUc4NWVD?=
 =?utf-8?B?Ty84eHJSV01Id2pIUWorSHhDR3A1K3NuUWV5WnBYOEdwVHpmVVJucERGSHk4?=
 =?utf-8?B?SngzQTNDTXBDUGRka0lORFJSWUpjcXpBbllCMkNrN2F1YWFsZzkwTG5scFdP?=
 =?utf-8?B?SUVaZ2pFdDZOemJqNjhESklSWmRMQnQrWTcvUWpKNXE5WmpraDZrcmxZUENQ?=
 =?utf-8?B?bFlCVGdGcmZzTjRleWZWRmxUTUVBQnIxK2ZoRkRybmg5TjVrcVd4cnJHVGNB?=
 =?utf-8?B?ZVpvV09iaFIzZTZ0YldVYUxDR3JEc2EweVhncFZwMkZtbmlHTWNpR3MxcnpR?=
 =?utf-8?B?U2ttUWJWK0lvN3lVTGwyRC9ITjlLaXQycVd2bnBMRkpPYUpJanMvYU0yeEt5?=
 =?utf-8?B?RE5MK0ZpNnJFWUNFZUNOSDRRZ2phT3pHTGliem9najBtOHVxSjZ5YXdhMHA4?=
 =?utf-8?B?NzkyTm1XeTBNY3dMbEZZNkVkTUZ4S3Q1dm5CZUtUV3FlVk1iYWdJYmNibTRP?=
 =?utf-8?B?SnozMEJYUEpGUkRJRWtmV0xuU2dGRThwWFA5YnB4NGFaZ2ZxVllncXJ5UjRJ?=
 =?utf-8?B?MEowKzdmZkROOC9GS3dHTlF5QWFqbTVTT0JUVWRROUhsNkozV2lpNkt3R1VW?=
 =?utf-8?B?eHNITzZKT1hoMzN5VjRSTkgrL1U4MkIyVUFHa0VmZ0x1R29JMS9yeEhwSVdq?=
 =?utf-8?B?cGNxMHA5T1pqbDVSUHRZQWtTVFVJRHpxektkeld3SE1ZdTRxdHpDYWE3UzJm?=
 =?utf-8?B?UFNqY0ZuQTAyRkNyMlBxSWllVWJFOTBaNThEMUpjWFZoekJ4cGRzWWloZ2cv?=
 =?utf-8?B?V2RXYW5xM0F0ZVNwTlMyYmZ5Z0JOdWROWnljYXM5MllSU0FzbXZ0Ly82VlAy?=
 =?utf-8?B?QTBScXVzWWRhYVRJMjFnYWxpc21RTzI1U3Z2QmdXNWdMNXdETmFoSG1BS2gy?=
 =?utf-8?B?MzJhdHNwRjdvaE12ZHIwOXNqUG5uUCtWNnc1bkFFeE5uOEcvaGdmR3V3b1pI?=
 =?utf-8?B?cVJZenlXR1VmUFgvdU5xTTFKZlBWaWNHZE8rcUFOTndUT2FML1ZtdnRvOWxj?=
 =?utf-8?B?N1BxUS8zanBwUWxLV2twVGVHTXh0TGRYZ2xHeWJuSU1OYjZRZ3M0Slg5UTJO?=
 =?utf-8?Q?2BT6PD0PRjWhX3UKHj3n58ZVn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec32b721-ff13-4c90-3bab-08dd82fa11ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:30.7730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdXFbeGxsuN62MBManXZcBGZPrhHCmQPQwspg5bGhsUD3pCTg+uc9QpDyQFeBeUSE2+ip22uAksndZ44wdyeJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

From: Ye Li <ye.li@nxp.com>

@protocols is an array of protocol identifiers that are implemented,
excluding the Base protocol. Four protocol identifiers are packed into
each array element. The number of elements of @protocols is specified by
callee-side.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/base.c | 24 +++++++++++++++++-------
 include/scmi_protocols.h     |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index f4e3974ff5b..78ee2ffd2da 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -258,7 +258,7 @@ static int scmi_base_discover_impl_version_int(struct udevice *dev,
 static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 						 u8 **protocols)
 {
-	struct scmi_base_discover_list_protocols_out out;
+	struct scmi_base_discover_list_protocols_out *out;
 	int cur;
 	struct scmi_msg msg = {
 		.protocol_id = SCMI_PROTOCOL_ID_BASE,
@@ -268,7 +268,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 		.out_msg = (u8 *)&out,
 		.out_msg_sz = sizeof(out),
 	};
-	u32 num_agents, num_protocols;
+	u32 num_agents, num_protocols, out_size;
 	u8 *buf;
 	int i, ret;
 
@@ -276,22 +276,31 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	if (ret)
 		return ret;
 
+	out_size = sizeof(*out) + sizeof(u32) * (1 + num_protocols / 4);
+	out = calloc(1, out_size);
+	if (!out)
+		return -ENOMEM;
+	msg.out_msg = (u8 *)out;
+	msg.out_msg_sz = out_size;
+
 	buf = calloc(sizeof(u8), num_protocols);
-	if (!buf)
+	if (!buf) {
+		free(out);
 		return -ENOMEM;
+	}
 
 	cur = 0;
 	do {
 		ret = devm_scmi_process_msg(dev, &msg);
 		if (ret)
 			goto err;
-		if (out.status) {
-			ret = scmi_to_linux_errno(out.status);
+		if (out->status) {
+			ret = scmi_to_linux_errno(out->status);
 			goto err;
 		}
 
-		for (i = 0; i < out.num_protocols; i++, cur++)
-			buf[cur] = out.protocols[i / 4] >> ((i % 4) * 8);
+		for (i = 0; i < out->num_protocols; i++, cur++)
+			buf[cur] = out->protocols[i / 4] >> ((i % 4) * 8);
 	} while (cur < num_protocols);
 
 	*protocols = buf;
@@ -299,6 +308,7 @@ static int scmi_base_discover_list_protocols_int(struct udevice *dev,
 	return num_protocols;
 err:
 	free(buf);
+	free(out);
 
 	return ret;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 519b906b4ce..9046de7e3e7 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -145,7 +145,7 @@ struct scmi_base_discover_impl_version_out {
 struct scmi_base_discover_list_protocols_out {
 	s32 status;
 	u32 num_protocols;
-	u32 protocols[3];
+	u32 protocols[];
 };
 
 /**

-- 
2.43.0

