Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A64C30653
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 08:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4E188675;
	Mon,  1 Jul 2024 10:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JyiGGqJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9145B8869A; Mon,  1 Jul 2024 10:42:54 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B5088675
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 10:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0aoz+WzBrSFooZNOFeH5y7LPCMHspnE6auk28QXRL1LZE7TplQdMrpl3mRHOb6+GGuOr+Cm5/+04odfNCCOHqNpdwAl3+J0J1M+qCw8Dwi0T+ibM7WEmwC1dRUs+LxmvdDksaudpuJaUnaE06DKGP+p32OzLw4x7qkrQndMGbqf/GObc+jgIWNlD8wMHI3Sn0HYv2GhUX7COmfxIjkQGr18eDRh5MrhFS9y4zpmwTVeFD5UFHTwEUH6wK1AKQ55B5Oxz1v2TlWmGV/yGED1ANI/eFdiGz7KTerusN+m8kHJN7MF8c5wfzjni9e55iaSwZvbgkbBpGc54fqpGFJhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyf4GlJMfdURX4tqw2uEyVlxFiReOr+/Z2ddwq/I0zc=;
 b=iGHZ2MICYinzDdchXsRk8zlILZSPixgpLgAj6WdayA7c595OvpRUfOoLol2/C4/DRmrSjL/nhQkcl7PKN9lRW0OI8JhSac41PLcepw1kePRBgfCx0jixkfr9ZXXtCO00qjARcQC4vMh910cAvVyI82AuWH1m0i7yC5UAMsJRQ3BBJtMctrDUHN2qtVGNDR33CtwfgG9v8zOswURo0UeWsxYtBFZJJXYpAmgfsUWhaCFAXkvGOiaNvqq11OIJ6pG7hZuKGlSewYa4dWq5dd3RY7bkXL3WyYIHR4rCJQWFO0efc62jKo6MsCJmX/mLjTyfRB+2c9gIe2thFv8erNCgZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyf4GlJMfdURX4tqw2uEyVlxFiReOr+/Z2ddwq/I0zc=;
 b=JyiGGqJdUHbDfxVuaMy/F9bKv3VkI/AAbWcgkajEsKw+G9jPh57gwC37Bm4WEmYyZtb/Lpp28Z0/tUJjeJCOEyk5UCo8bWN+PCnifjX1TS1D6IoY2GLRO2cnz92+tfKC4Xgy7rlhkXNXiCjViu4nGLXZdpo3/bfV4ldkYTWgR3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PA4PR04MB9392.eurprd04.prod.outlook.com (2603:10a6:102:2ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 08:42:49 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 08:42:49 +0000
Message-ID: <d8d6995c-a66b-45dc-8d1c-3debbb9e757e@cherry.de>
Date: Mon, 1 Jul 2024 10:42:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
 <d31b4e88-a59c-4ec7-aa05-1293ab8139d9@cherry.de>
 <7c53dff2-9703-4a59-9a90-ec2d64cdb3fa@denx.de>
 <274c876c-4d42-4af4-a68c-5b51c20bfdb8@cherry.de>
 <f873b919-a4de-4d06-9f6c-b964cf0699b7@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f873b919-a4de-4d06-9f6c-b964cf0699b7@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PA4PR04MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e4d638-c6da-4054-13c3-08dc99a9c9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2tWZTJTakpuYVk5NmthVlVONVN0T1FQbWhqV1FBemZXa1huNSs5eHprbEVO?=
 =?utf-8?B?bDJVZm9WZlNrR0JHRDVJaHgrUzYxU1dCdThya2lGNW1yNkhFbFI4djRXc2Z6?=
 =?utf-8?B?UzVnSkdjV3hCMGhSN245dmZ5TENmMlNKMmE2OFFCYXdFQUhYTUwyUm1JOWlR?=
 =?utf-8?B?NkZLQmRFVW02WVIyTTkza1B3TzVNSVlZYjcvYWFLcU5SMllEWHVUUzllS04w?=
 =?utf-8?B?cVJpUVpsR055UUZGRzE0aWxXOGM4ZFlIVGF1MXEvL0QxV0duY1AxTitocTNw?=
 =?utf-8?B?cHF6Y0J3Z285aUVnUnF3L0RzVDZqdzdnWTRRMWNEL040alozUnQ1OG9oeGxl?=
 =?utf-8?B?Z0ZKSTd0UnRJSWFzOXZVMzlaZkNGbmJUL093T0NBb25oRDFxM3FaY2Qyb0p4?=
 =?utf-8?B?TFpVdXZQZ1I4R3RZT2tYLzZTQlYxSXJVSmh1RldJMy9nWk5hb0pVbENBclpZ?=
 =?utf-8?B?MTYxTUNSMmZhbUo3NElNNVpYUTlUbG9LZ2Q0M3A5RFFVdUNnSjZ2SkJKMUJn?=
 =?utf-8?B?enFxOUFiNmdlWU9XOC9YNjJpMFd4ck1ma2ZzKzFSUG9hVXFUYldmaHFzemJB?=
 =?utf-8?B?UmNzT2dITS9neng1blNxQWRyR0RyeityaHJXajlnVUJzR2oxSForaFhOeVRj?=
 =?utf-8?B?SjljZkYyNjJucUhEb1lXQWpKTFFhUCtQVmI5TjYzZDZXQ016TFU1VnNmZWhl?=
 =?utf-8?B?OUxWRU9RTHlHdCttOCt1clJlakRCOWZRSGZPTGxPS0l4WTZGamRKMHMwWExE?=
 =?utf-8?B?MzlLOEs4d2l6c2VrL2orN0RiQU52L1AzNlBZa3ZyaWZVekd5ZFJ1VHFuU2c3?=
 =?utf-8?B?MU5Gd2VvaTI5OTVXNGRxY25CL1N0bnRXekt3emFJSXFUeGhRTzAwVTNMUjVO?=
 =?utf-8?B?M2xGdU1KTTlLaHhnNk1lMXFlVUp6WXV2aXdxQ2NvNWViR2RnUjRTRnJrWGRU?=
 =?utf-8?B?SEhwVklNZkxvaFdsYlhVRm5OaDArT1RrU1hnWFMyc252MWRLTjRKUmtvVTBS?=
 =?utf-8?B?TU1iWXR6VHNZYUFkSFJWWFFBVENVSENzZ2xCSkpUQm85Z3ZWcEFnRzl4MDRv?=
 =?utf-8?B?ci9ZblhIQ1dIU1NLQVREUExrcisvb3lKUTh0QnlkaCt3eHZnSkhJK0MraWNG?=
 =?utf-8?B?ekhlcU1UZE0rbktvM2ZjeXFOMVVwUjlBV0xEUmpFT1A4MkI5ekVDdk84ZTJG?=
 =?utf-8?B?MG9DcE5tNm5lSWFEOU9sSlVpUzk1SDlSR20yQTdHcGFjSytoQXk3VVJaa2lF?=
 =?utf-8?B?OU1MbmJvaVhLYlNPS2lGMzRPYTRWTUw2VHFPQlRIbXhVbTlOUURUVGwwUktw?=
 =?utf-8?B?YjMyc0tURWM0WE9oaFpBdzY3ZDJxTndnM3hRQkplZ0FaaS9MaUZNejlGMGZi?=
 =?utf-8?B?cFpFUmg4eVl0UXVlMUVJSTlZOUJWd3YzcEZrMmxiR2YwL0hQdUJ5QS9yNEhY?=
 =?utf-8?B?NUJlU2xydjhNblpTZHAvRGVzeVpucDZpanROME4vd2cwYmw2Uyt6Y00ra0Jp?=
 =?utf-8?B?SGlaVmtXeFZEK0loNytSRlBjMitBNXQwZ1EvWmxwT0cwa1hMNHhxelBEMlA5?=
 =?utf-8?B?R0UxSml3djN6bG1tc1pjNENmbi9XL25XcFplMFhTR3MvbXBtckx6aTZQZXhW?=
 =?utf-8?B?RE9PWlVyWUM0WU5sSGlOL2hGdHQ1WjRPTDFqUkxTUnVWUmdLUVBia0xTV2FL?=
 =?utf-8?B?OTVTTUlJWWJML0tKZ2dWbDJrdEN3bzZMNWpKaGY1eFBkR3JhTzRHQjNCR3cz?=
 =?utf-8?B?RUhMQ253ODUzM1l6T3hpaE4zR0IxOEhhMmxReFI1eTlLa3NaVW5nMFF5Tk5F?=
 =?utf-8?B?VlVnRWF4QlE1M0h3YjlRZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkMyc0hpbE9RWnowalZqV0pwZ3plN21uRGpDU3I4S1AvaTM2NkFEUWEvOUg1?=
 =?utf-8?B?Y1hsR0pZV2FpZlh0YTc4NitpQkpPY1RtZXJYemlwR3EwOGpRbmZGWVpHczNT?=
 =?utf-8?B?RlNVMVovMnRLTlczWTZVMEFHUW9CMG1kdS9TN05BWGc1VkZQQzVISEpkcWU2?=
 =?utf-8?B?dk5yNkg3MzVBS3dGeVJyamFmd2FvZWZWc3VkTWF5OFp5NG5VWVBGYVJOOEFG?=
 =?utf-8?B?SzhvcDZKTEdSRy9vNmhuYUxBdUpqZVVnK2hLRFAxUXE2dlh4cU1OdXNqd1cr?=
 =?utf-8?B?eXJLOGoySXZtNERFTXVHMDcrWlZMMEcya09zK3kzWUlqMjBTRXBkVmNFaWlj?=
 =?utf-8?B?ZHJRd1FVZUthKzc4cVZVZGlSZkpXWnllV3ZMT3FsVFlCd1kyQTNiSERVWGl4?=
 =?utf-8?B?MVlVTHFjQVh5NnN2ZTFCbTl4dU1wcXBaOFpsQXFKOWFtZ3BDZUdWa2p1c3cw?=
 =?utf-8?B?V2ZtdWVPRytsZkMxUVVHay9QdGxkNGxtYXE0ZXRxT1ZuNDRENFhmNGY0K0E3?=
 =?utf-8?B?Ryt4Z1liMDNTTkdJVVRvNks1MnVGd2dRYUMrSTFnYXFwdE82TnVUWEl6cEh1?=
 =?utf-8?B?cEFaS051cnZ6N3phQm15VnVuQlgyaDZGUi9BU0dyMjVDc1ptZkNndHVLTzl0?=
 =?utf-8?B?KzRGSllSbVJwQ1laYStMVWRXTjNLQXJOMFNjcDVjeEZQcXZRTEJhM2psYVcw?=
 =?utf-8?B?b01KVkZnNDJjMnRHN1VKNDJIS0tpY3VUbDUzYWZBVzFjeDNFT3dMWjlHY2VF?=
 =?utf-8?B?S201dzVhdnY2bVlOOUxYWEh1RDJMY2xLOFpZT1NiQWpybC90cW5DQTRpeXAw?=
 =?utf-8?B?Q3orZEo1QWpFWG03ZWw5dEZaTzhjYTAwOEpZZStvZ2hhU01KY1NnQ0tvY1pq?=
 =?utf-8?B?TUhqOVJpYk5hZUZPVGJqazJDR2plSW5VUlo5WjFWM09oTFRzbGU4UjUwaVZr?=
 =?utf-8?B?dzYyQWEwN3JOUEVTaUFsU2YyVkkvRG1NeitnNk5iNHhxNVBiQjIxV3VOZ3E1?=
 =?utf-8?B?RDNiMjNDdDA5YnFKUXNSVmgzVTh3QnRiRkRCWkFyMEM1Nk54dGplS2V2anpt?=
 =?utf-8?B?eU5NbjVtVDRGcCtnb1l1WWcrVnRVVXJyd01qNXUyVXBoaGVFWlFGK2FDVU80?=
 =?utf-8?B?b0tZTDE3RUY4MnZBNmR4bGdhNDU5anZrdEo1QnFBWG5DSmRyMVczeU5aeTZl?=
 =?utf-8?B?VEloUnVWbWhWbElZSFB6ci9jZytsUjJhZmFHa0ViRjR3N0tLYUFjb3gyaEhB?=
 =?utf-8?B?dmc5QmxvRlJRM3pRdWNjdHRYY3pTckZ4RWwyb3lNVXYxR0dEMjRiWlQ2ekhF?=
 =?utf-8?B?TW9UdFNvZXM1L211OVdYK1lDbGQ1NjRuNUUwaU82Mnhqc1plT3dkYVJRb2lU?=
 =?utf-8?B?WGRqUUhEZUMwaWpyWDA3QWs5OE9KVWlJVE9pdW03YUpXZkhmdytmTnBVOWtH?=
 =?utf-8?B?eXl2SCtIZXA5S1V2blh5ckgwTklQYTdweVhHN1owSzRlZkVoMWQ3T1IxaGpM?=
 =?utf-8?B?aDFpTWRiL2hDUC9LSWxXU2ZWYWF4b2kyb0Z0ZWpjajA0TXd3VlV3L0UybzJr?=
 =?utf-8?B?azlxS2NIVHNCYisvMk1tNndpODJ4OEVRMW1WREJtRm1oOEdqTFFyOGErVnlE?=
 =?utf-8?B?bEowL1RXeW5MbmxtaWdxc0U0U2Mxb3lVdlNBVjRCczJnM21tN0NPc0VBU212?=
 =?utf-8?B?ekVNU0RUd3A5OExTYUFpTUI4UzM0bEE1Mm9XSkF4RjhKZ1k3emNoRE1kL3lL?=
 =?utf-8?B?cjdPZmx5REYwdHltQUljS2xONnpXK0FkUmZOOUxYYlZWQ1dteC9hSFU4SUZJ?=
 =?utf-8?B?ekRmMUtWZ1VPMWFtNlNDSUhwbm1HMFN0ODZGQWpWS0NsUmZkRk5FTWZDd2V4?=
 =?utf-8?B?MnpBOWtCUWtmaG5JOXp6OU5USTVqK0dZb1FxODZ5M2o1Tm5IZjJCSWZZL1B3?=
 =?utf-8?B?eHRvcnkrTmVSOEkrYVozVVIxRklDQzVRdlNmNjRNT2xPYndvaWVuVGFmK2Jk?=
 =?utf-8?B?SWJ3NzNtVm04R3JMQjMzd2hiNmJuTFpzSnhNWEtzc2dTOWh1S0ZteHltWmVL?=
 =?utf-8?B?TUVzV3dtQXRDalZ5VElmcDE1Qjdid1l5VURJZUY0eXNFcmF1MkpCTllUZDQw?=
 =?utf-8?B?Tm9YeUtvL2Z4V2NhS0c3R0dud2JtQ0JBN1ZXYVFpRmxkc3poamhSZlBON2tF?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e4d638-c6da-4054-13c3-08dc99a9c9f4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 08:42:49.7670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp++d9B3JPJlKxMM7aTyTFqNNp8k7oEhs6lxyXoFh291/OdJY7AJf1DA7AwqSNWVkNoFsyiAhfRaHVZ6/AQf5EiLhQ3tRvojrVLvwfDapIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9392
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

Hi Marek,

On 6/30/24 4:33 AM, Marek Vasut wrote:
> On 6/28/24 10:27 AM, Quentin Schulz wrote:
> 
> Hi,
> 
>>>> Shouldn't this rather be in /config node?
>>>
>>> This is what I had there originally, but then I realized that some 
>>> DTs might not have the /config node in them (or am I mistaken?), so I 
>>> moved the new properties into the root node, which surely exists.
>>>
>>> It also keeps the code simpler, as it doesn't have to fiddle with 
>>> creation of the /config node if it doesn't exist.
>>>
>>
>> I don't think we should pollute the root node with this. If we want to 
>> be able to expose this in a proper binding to the upstream DT binding 
>> repo, I'm not sure this is going to fly :/
> 
> The other option is to add more code into SPL, that's not great.
> 
> I can check if /config node exists, and if so, add it there, otherwise 
> do nothing. That should be some sort of compromise between bloat and 
> config node. What do you think ?
> 
> [...]
> 

Considering that we're trying to have the same DT for U-Boot and Linux 
kernel in the long run and that `git grep "\s+config {"` returns nothing 
in dts/upstream/src, I'm not sure this amounts to anything but 
dead-code? We could also always insert this node as pre/post process of 
the DT compilation? But I think some people want to reuse the exact same 
DTB (like, the binary itself) between U-Boot and the Linux kernel.

I guess we can start with checking if the /config node exists and we can 
figure something smarter once we need it?

[...]

>> 2- Add info about which DTBOs were applied to the kernel DTB?
> 
> SPL DTOs or DTOs applied from kernel fitImage ? Or a merging of those ?

DTOs that U-Boot proper applies to the kernel DTB either via fitimage 
configs, maybe also via syslinux (via 
`fdtoverlays`/`devicetree-overlay`) and the like?

Cheers,
Quentin
