Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5291CCCF2D9
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 10:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E5B80B98;
	Mon, 19 Jan 2026 11:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iLhT8F7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF4C883015; Mon, 19 Jan 2026 11:22:56 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1E8800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 11:22:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H240oNU2S0wccGh9EXcqk+OMZ4zfN3IG7P+rc2GAc+ig4GAri5IS/yrLOovENFIPWJtYaRVzBjD/YDzv+5Fq3a8CY/0eAZgThBGTqIbtRW4NaHxUMkXEa7JD3FnN5dTqmTdZtRWsEL8L4zQAicNtGMzdgiO05L/Z01zZt0ZKZ7giAoLyhU3GRYlDA6dwU9llsdDQMW+KRRgYX99kJn9ilEGLUt9B5PNlCPaalDteL0hsRcO2s4vWXmwYbtCfadrXfphITrp/bKN6puX3AqyUoOfMW1yXNx3M0awKZtDvuzZggtywaqITXPx95tyIgLB5WqKCkZzyGbBp7K928k99og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUw0as/45xXPL+viQNTcfA7EJuZA9r9Hz5GyBdMTP/A=;
 b=LBZwIqSUzUK4eHdPAYBsmc+T+bkvgsu1sG5/35e4Bs1MriL6DHyqTLUM4UQZKjvBVa46vFiqeYnrW+pHM5YJ15kTWCUhYSe86iCFcXbkNd+YqG0YuBUJzhI5nuCUr1sgHS1mh9XcSPW7SiWtxmGIazGJoHCl/u8RK6fABrsbrTKeGUkWdjTiJl4ueo0/Pcj3+eVZOtB2JCYO/FzUIgI9CYEEnu+3H4PyvCB184Gb6FWywm7S9OQkn+LOGhXPojMnJ3SUQSiw8zafetjyyfaVTUYj0CrZWiuB07RpO9K1MKCXSUslFiImBxpE852aqS+ASrGb85kvkDUnUOPgmfxOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUw0as/45xXPL+viQNTcfA7EJuZA9r9Hz5GyBdMTP/A=;
 b=iLhT8F7Kd3us2b2iu+g/eCNZb0QC8b5DdNJpcDxloag11A61VRKlVjWmSDd8zvtTQDSqJLVSN0r6mJelvJp4FjQnQ+Hi8mrpBPS68pacVdVohqI6cfj17l/8ZnAG1WNG29Lj/JjLimsG+1EoBQF/d811sQ39UDjYLL1nRpOeiq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by MRWPR04MB12072.eurprd04.prod.outlook.com (2603:10a6:501:98::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 10:22:52 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:22:52 +0000
Message-ID: <7906ae57-4700-48fd-8740-66b8626640f1@cherry.de>
Date: Mon, 19 Jan 2026 11:22:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cmd: mem: add function for getting ram size for use in
 scripts
To: Frank Wunderlich <linux@fw-web.de>, Tom Rini <trini@konsulko.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
References: <20260118105021.19760-1-linux@fw-web.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260118105021.19760-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|MRWPR04MB12072:EE_
X-MS-Office365-Filtering-Correlation-Id: afcfb253-abca-4da6-b256-08de5744b408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlBCbklmdWNyd29ZaUt4NWkrRFQrbDNGU1BkVnpiNmlNcmtUSTluREZ5TWdl?=
 =?utf-8?B?L0F0WFhSVU9HMVh0YmR2SGUwcmxPelNNTVJmRVBxRjJoKzNhMGJBNVdCZktV?=
 =?utf-8?B?Q04yTHpzY2lGZVdESi9RdDdiYm9KYmIzUndPeWxJK2dFL0tZWlBIUG5DaHBs?=
 =?utf-8?B?UUU3SWNTbzhrdW5aWG11eHhaakRSNlBOZiszQU94aDR1VmFaMk1UV3Bqak9N?=
 =?utf-8?B?VDNMdGRhaEZKM1RaM0FpRUNORjVmQW8yUm1JbUdROGNVTFNIRnF3aFFhMXRQ?=
 =?utf-8?B?a0JTK1Z5YjdoUGRIblpVRm1Qc0xmODh6eEp6d1A4NEFndGlvYU9Wek0xWStl?=
 =?utf-8?B?NFQrTjA3RlFObE1nR1hyTEdLeE5FQUd1Y0IzcUZoWUtOazhuZzcrNkRtaEo1?=
 =?utf-8?B?MWZPcEgwbmRUemR4UkROcFNpYU1IeVFHa0t6K1VmR3BWdGhJekg5UU8yT09L?=
 =?utf-8?B?QUtsRXlGTnE2WWhNVVdkMTBoTUY3K3A1QUlhTVBSSFVZWFU1QVhjQXRlR05L?=
 =?utf-8?B?TWZIVHBnVmV4M09QdTdEdDRodVJHTWJSanRPMUYvRUJsZkI3Q2lVY3dQOUVl?=
 =?utf-8?B?U0VVQVorWVdyblJTQXpYT3ZoZnpoLzA5eXRrSUh5Q0NZTjNHOTJBN3lVWC9h?=
 =?utf-8?B?cklFaVhRazIzQ1JXNmhTWEpxZmNXSDJvb01qSE9iQWtBR3l0ZTRrbVRTN291?=
 =?utf-8?B?YmEvTldibVhYUys1THdXc3pydVJIY3JWWmN2WkpEdlFUb1IyQnZnUG1teXVE?=
 =?utf-8?B?Vi9lYmcyMXZSODlhTkNrTUZwRDJBLzRyTE1wSzh3UTBDb2ZTdHV5QzYzbS9D?=
 =?utf-8?B?a3BDcFRFVmtkM2E0UFgweXQwL0lzWm9LREhuQ21zQWsrd0o3eHVuUVRiMEYr?=
 =?utf-8?B?NUZLWDlmbkFDNHo3NCtkV2MyN0RiaWZQN0hPQlQraTlMSHBHM2pYTVQ2ZXNa?=
 =?utf-8?B?T1FlRFh3dmhhR2pLVCtKUFpoT1Njc2k4aHpBRC9XcCs2QjRac0hDNEc4Y3NZ?=
 =?utf-8?B?MVNObm5iK01oeFBoQy8wdEcxbWtHQ2RST21qU2lqVENsNFNPQkFJbTM0bUJx?=
 =?utf-8?B?TXV1TDhzY2dna2JuYWpGQWpldjhaTXM3NEE4Ui96NldMSXR0UUVjTUxOeGxH?=
 =?utf-8?B?YXc5Q3p6RStQTGh3TlNlRThERlRRLzc4WGZlZ0hUcVF3VEZpM3lrZVpzaGNm?=
 =?utf-8?B?MTRBem54RXA4a3FoRGhUNm5hOWYxWk1hMFl4VjNBZ0xLQUpUNHhRalBCaGdO?=
 =?utf-8?B?SWJiYUZublVTNUMvNFk1b0Vuem03U3haV1FSTnl1YkdHRWlIU3B1TDJWU3d4?=
 =?utf-8?B?Sm92Yk5RNVJONmlaUFo4WXFwdW91NktSZUE4UlBaa0owQUhsRFpmNkQvS0dp?=
 =?utf-8?B?czJvKzJOVS9SYy9icFlKTTBvVXVZby9iUk9sVFZmc1dXTlI1V3ZNV1Q5dE5R?=
 =?utf-8?B?Y0ZuTWVCeFBqb0tSbHdUbnZ6a1hyTTgwYjBYVFk3V1hqdjBLTS9zajIyd3lG?=
 =?utf-8?B?WC9oTmlrMTBxa1FJanZLYmlYSzh5N2tJVGR6Mm9tTmJkMVFqTVZFMzZBSkRn?=
 =?utf-8?B?Y3g2emdHSjk2dVZwQkhVQ3pxZFdwWDBNbXVFcVNpTWFyRHhQc0JRSUwxRDF3?=
 =?utf-8?B?YVZDQVZMMDROT0hlMzFpazdYNmNrUE90cHI1R1NjNktHUTlFYkZZMzEyT1I4?=
 =?utf-8?B?bGNCbURrTzJlenoxT094MzNycnZoeU1LcE9pWmZiVXpJZkZ4dHdNUmxOVDc2?=
 =?utf-8?B?OVNpdzFYSTAzVm5OWlovNHdSRlQ2dW1QTW1JZnBrSC9PRGI5RUlxbUVxRzJM?=
 =?utf-8?B?clhLWndiNytxakpBbVRNanJCeTdVQnRQVHgzZWZlRG5mb3dWZGdTV2JScVFF?=
 =?utf-8?B?aHBSdHpZOW41YzVGL0c0ZXRnc2tPYmViT0R0Z1NRbUJaUUZRb1JHSU5uRllI?=
 =?utf-8?B?NTc1QjM4WmlPM3V3eVJod0U0V3U1T2phY0lZRDkvaFhBc0hMTzdKSzRxNmk5?=
 =?utf-8?B?VloxYTd3QWRIZnFGQ1NnS0pKS0V5OEFMUTlrWk1OWmtuNFBWSDVQa1VtWWY5?=
 =?utf-8?B?SUh3VHRDQWpra253RHNBVGpQL0dGWWxnUzVLYjFYQ3kzMUZqOFF2RnA2Znlq?=
 =?utf-8?Q?LsQY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hQcGU0NHk3WGpDcGxGRExKNkhkWEMxT2toVzJLY0lJdkhmaFhtWVZxeFhk?=
 =?utf-8?B?THVISW5YVjVmRG9tRkRXVnUrOXpiY2Q4SmhPL1ZRcENEa2cwZElMbVBLSFpV?=
 =?utf-8?B?MXkvQzhhR1c2STJkRk9FQXpVb0FUVWVkSUpkZVMwZWhibG8zaVJMMUs5bGNL?=
 =?utf-8?B?bktkam90RC8yYzkzRnRxdlBpV09XNjZ0d1NIaW5LNC95S1NkOXZzN1JpWXF4?=
 =?utf-8?B?KzdZN0t1ZGZhMFBtQ20xRXZlTFNZQzE0bzNMT1lRN3MxdTc5N1czTkk3MnV6?=
 =?utf-8?B?Ym00Z1VqNWxIQXI2NFNvYytkdDZDdGE2TWltcmc3S3A2ZmszbUh4bm5xVmFV?=
 =?utf-8?B?a1BhTE1LRVVzODJab0RGMWtEVktMUFVGUTVGREl3Wi9zamhscW4zeFprSC90?=
 =?utf-8?B?RzRrelZQbWRWQS9Na0Z6MHZYWERWdjR5UkVJb2R4NStLOVlqUU80Y1pkcXMy?=
 =?utf-8?B?VkZzZnFxL1Jxaml5SXg5VjBWbUcvWk8rZWt2RFVOUXdVVHNkM29wdFVPSFNa?=
 =?utf-8?B?Yk1pTExFK20yb3ovYjg3WlhDbTVGYUYyUmczbXFkdnUwWTh1dHc1VHNCZFFX?=
 =?utf-8?B?REhKeFE4Z2xKZDB0L1E0azhINjZHQkNLd2NXYkFDOTc2VkRZVXU1Ukt5dUxl?=
 =?utf-8?B?N25WVXkxYkNDcTl6ZG1ZQzFSak56TUR5QTE3aEkwS0hzUHdQNUVoanpQRVhQ?=
 =?utf-8?B?UXlWbHZ4SVZTZUptQThwUTl6VERvUDMzZFdRKzkwK2FzZ1pEWS8rQzZ6OGIw?=
 =?utf-8?B?d2IzVDdndTRZQkpSSytaSGYvYkRhRnU5Z0l0Y0dXaGdQWTNIUHhFNXBwTFJP?=
 =?utf-8?B?K1VBMXJMNmgvZlhJWnFWcnR5aExqdEw0d1FqWnE1YkNzYlUwVWNPS3AyeWNU?=
 =?utf-8?B?cW5RRlhvbFJMT1V3SFlDQXl3aUxXbXdEd0RiYU9JNkltVFdZRWFaV3Uza1I4?=
 =?utf-8?B?K1JuWUhjSm1NTVBob1BHZVJNc0Q1Wnd0cnZHdmNKVmpwRDM0V3FocENzNDBp?=
 =?utf-8?B?TzVORTdOTXpkVFRDSkE3RDhUcytkR253cUhWNGx4UVM1YUN2MGpxc0h6M3BC?=
 =?utf-8?B?bFp5Q2M0czJVbnFTZzlZSERVRW1nd2JoOFdwbHNzbkZnbHdGYkRRVk9jZ0dH?=
 =?utf-8?B?TTJxM3hoMnluYXpSR3VzZmRaMXhaYjdpckg3bkoxZnZVcHFCMG5ZMEhSdmw1?=
 =?utf-8?B?T0YzSlF3VUY4RStQakoyK1FjUXBOMURkaXQybGU5VkxPSnFoenRMdEFrYldQ?=
 =?utf-8?B?UlJFQmxDSGx5MjZFNnpPNm9nTEcrNUJTeGRzRWJBVS9aVHlQRXVLK0NsNitl?=
 =?utf-8?B?SVl1U1ZxKzdLNzAvZXovMlpyd0lCdHo2TS90dUpOMnhjLzZyWVBkSGpLTDNY?=
 =?utf-8?B?WjVqUXp0RENOSUNMRzJ5bFNNVk1TNUVWeXlhQ2NDd084UFExTnFwSi9rQUhx?=
 =?utf-8?B?TlRZMnAvb2VRQTJCM1ZmR2RtM3NxMXpmenFEL3c5V3JEL3ZSMkFmTHJib1Jo?=
 =?utf-8?B?djR6TEYyUG84M3BRQy82OWw5RmtLNTJtZlRkdTBzOW5OSWJsV0p6YWxoSU5V?=
 =?utf-8?B?Y2lSRnZXVWF1dVZmak5wRWVQcGpjeE0xbXhUeU0vK1hHdHF6SkYvMEpORVJk?=
 =?utf-8?B?VWxzT21aQmxzTUNXeC9iTmY4TWFRNnFsdUdLTVVyUHVjNm9Cayt2Snd1Ky9V?=
 =?utf-8?B?YVRNSnBDeE1LSnFMTWV5LytJZFBUY2NTY2gvRUQyTnJleGtTN3kyaldONWE1?=
 =?utf-8?B?V2gyMjVYaXJmckVuL0FMK3E5U0VqWC9rWnZjUFJxYVNRNThhN0tVSG9VSm9B?=
 =?utf-8?B?Q29aY0dyUElFSUE1QjVNdy95SVE1OXVXanl6dVVqT1F3bjJyMlVZcm5SUEJt?=
 =?utf-8?B?U1R2Vk1PVUtHaFpNT25POFZLOS9KaGdjaDZhTi9YVnh5dXNXclhYYkVXd2xC?=
 =?utf-8?B?TVIyaUtPeXpUeVlvUVE5cHluUzhoQVVGR3RsR2EwZytDU0xFWnZQS0tLeGlp?=
 =?utf-8?B?bVY4TTZRck9ENGJMSkhNMjFvYUlRZXQzWTRxQ0RxaUVBVzJ3Tmc0aHMzWUIy?=
 =?utf-8?B?QzhTY0U5cVp4MEFzblpoaUV1dHc3ZC93YmliRCtSRlk3aHF0VngxYVpsdHQx?=
 =?utf-8?B?TzZrRFpQQnAveFhMbmtuWG54UUVCS2xSUkdvcEU4R2wwR1c1QVpIMWh5a1VV?=
 =?utf-8?B?S2wxR0xuTkozdkJpcm1nUjcwSGdFd240VEJQUUx0aFhSY3NTakpWV1FPQ2lG?=
 =?utf-8?B?c0tnRTJoUUVORFB2VGpqaGRWRy9GUjZtaGdHb2xVbHpWMHBUZ0txTmlHcnNo?=
 =?utf-8?B?V1lPVnVLN1NNdnVETzVhVG9GYlB0Ym5JYklKWjE2aFBwWDE2blVDOFhQSm53?=
 =?utf-8?Q?VN2AjLeKY8DmE22vl4vD3ZhXj64pXQHzHDPf4?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: afcfb253-abca-4da6-b256-08de5744b408
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:22:52.4279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLKK6ujua4gxfqyVKaBdqMQcWWWFIW+kB8QMgl8zR/wJl8VhCFghTycs7osU4+eY5+fS9tTlXUkeZelRlYAI4AFMrO2X4HIcQ8BMj6xUJGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12072
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

Hi Frank,

On 1/18/26 11:50 AM, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add a command for getting detected ram size with possibility to write
> to environment variable.
> 
> example usage:
> 
> BPI-R4> msize
> 4294967296
> BPI-R4> msize m
> 4096m
> BPI-R4> msize g
> 4g
> BPI-R4> msize g ramsize
> BPI-R4> printenv ramsize
> ramsize=4
> BPI-R4>
> 
> board with 8GB ram:
> 
> BPI-R4> msize
> 8589934592
> BPI-R4> msize m
> 8192m
> BPI-R4> msize g
> 8g
> BPI-R4> msize g ramsize
> BPI-R4> printenv ramsize
> ramsize=8
> BPI-R4>
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4: drop rounding to full MB/GB as it leads to wrong display
> v3: add missing ifdefs
> v2: add Kconfig entry
> ---
>   cmd/Kconfig |  5 +++++
>   cmd/mem.c   | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 5c611fb3016e..b82b17195b7e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -974,6 +974,11 @@ config CMD_RANDOM
>   	help
>   	  random - fill memory with random data
>   
> +config CMD_MEMSIZE
> +	bool "memsize"
> +	help
> +	  Get RAM via command for use in scripts.
> +

Only available if CMD_MEMORY is set, so need a depends on.

I'm wondering if this new command isn't more suited in cmd/meminfo.c? 
Maybe even extend the meminfo command instead of creating a new one?

>   config CMD_MEMTEST
>   	bool "memtest"
>   	help
> diff --git a/cmd/mem.c b/cmd/mem.c
> index d5d7ca2790bd..9dcfeacbbcc5 100644
> --- a/cmd/mem.c
> +++ b/cmd/mem.c
> @@ -33,6 +33,7 @@
>   #include <linux/compiler.h>
>   #include <linux/ctype.h>
>   #include <linux/delay.h>
> +#include <linux/sizes.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> @@ -711,6 +712,29 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
>   }
>   #endif /* CONFIG_LOOPW */
>   
> +#ifdef CONFIG_CMD_MEMSIZE
> +static int do_mem_size(struct cmd_tbl *cmdtp, int flag, int argc,
> +		       char *const argv[])
> +{
> +	u64 memsize = gd->ram_size;
> +
> +	if (argc > 1) {
> +		if (!strcmp(argv[1], "m"))
> +			memsize = memsize / SZ_1M;
> +		else if (!strcmp(argv[1], "g"))
> +			memsize = memsize / SZ_1G;
> +		if (argc > 2)
> +			env_set_ulong(argv[2], memsize);
> +		else
> +			printf("%lld%s\n", memsize, argv[1]);
> +	} else {
> +		printf("%lld\n", memsize);
> +	}

Flatten this like so:

"""
if (argc <= 1) {
     printf("%lld\n", memsize);
     return 0;
}

if (!strcmp(argv[1], "m"))
     memsize = memsize / SZ_1M;
else if (!strcmp(argv[1], "g"))
     memsize = memsize / SZ_1G;
if (argc > 2)
     env_set_ulong(argv[2], memsize);
else
     printf("%lld%s\n", memsize, argv[1]);
return 0;
"""

Otherwise I see a few issues:
- rounding not made explicit, (also it's truncating and not rounding I 
believe here?). Why not print the actual value here as a float (of 
course, not using floats)? I vaguely remember some of my Rockchip board 
printing 1.5GiB when booting up (cannot verify because this happens due 
to a bug in the SDRAM init and isn't easily reproducible). We do have 
some boards with 256, 512MiB of RAM so we should be clear whether we are 
printing 0 or 0.25 since that will influence how to do math operations 
with the variable containing the value.
- what if I want to save the byte size in a variable? With the current 
implementation, only mebibyte or gibibyte sizes can be stored. I would 
suggest to argc-- if m or g is passed, and then compare against argc > 1 
in which case you'd use this third (in case m or g is passed) or second 
(if they aren't) argument to store the value.
- missing documentation on the base for the environment variable. We 
have some commands setting hex digits in variables, some others in 
decimal, so this needs to be made explicit so that people know if they 
need to translate stuff before using it (or how to compare two numbers 
against each other). Here it's decimal according to the code (maybe we 
should have it in hex instead? I am not sure what is the expected base 
for variables :/).

> +
> +	return 0;
> +}
> +#endif /* CONFIG_CMD_MEMSIZE */
> +
>   #ifdef CONFIG_CMD_MEMTEST
>   static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulong end_addr,
>   			  volatile ulong *dummy)
> @@ -1404,6 +1428,14 @@ U_BOOT_CMD(
>   );
>   #endif /* CONFIG_LOOPW */
>   
> +#ifdef CONFIG_CMD_MEMSIZE
> +U_BOOT_CMD(
> +	msize,	3,	1,	do_mem_size,
> +	"get detected ram size, optional set env variable with value",
> +	"[m, g] [envvar]"

Explain m and g so the user knows when typing help msize.

We need tests in test/cmd/ and a new entry in doc/usage/cmd/ for this 
new command.

Cheers,
Quentin
