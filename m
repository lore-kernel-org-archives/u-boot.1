Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556C1D13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 10:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7A089068;
	Mon, 28 Oct 2024 11:18:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="haEWIz1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 181AA89068; Mon, 28 Oct 2024 11:18:48 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA9889058
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 11:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsp01/jQAnEDY/+kn4AR021tmY7doaOlxhQ50VnkNZhT6ewi4kA4hEshhyOWw0KGPtfwvH1BGDd4mn6+jeTdc3v2DREDBo6UTR9Qq2XdhvmhOITOWkqMxcnUkmfIuJNS1XUZG9feQG+QtsuoXU0XrCNgvV64YEan6s2DwElqMrvnofB/vOs3OubzBlvdqJbSdhAbE+dHRAfTQzC+2l8CyVswJ9bnKqC1qw099l3elCvZqQsGsMaIdnFGNYe5FTiUH0PqG4l4ZtQ7S1/+0i2qTDYPcXdbdmUc2vm68AP45rgkjTIMnI7yYmcGqvm2ZWYh+nVTQ1Y2U8l/geOZw2r+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EhDM5UjDHd6k5mTFl8/Myf19UUhrj4lGCSnvUr0xs0=;
 b=GuHkDlePTpKyW0klDa37lK8EOU3L0uz5w0c3r/8VwzQQkOkLZUB1kAAAiuZf62E/M+L1kUk/1WWIEj6xftpWbjkMD9JnAzUsa4zSMOcPiH7310xi8JbbPvtclSRe+dpp4KqgwSmKPmoWtHCz6ULpQ2Lw+u0aKK6MmYEl+bTp6KiS2b/pPDhSa38p0wfmUfAHQ875Kbetw2Cy+pOraAgzzmH2BdPiCbPcIWfgoWM5Tckm9vq8GVN2WSMUozUACfZoEQNGOpViGeUZnJXMJc4K2FqjhL/B5swsxXyxPvE/otZOuqtUoFKOEQD8MZM8mFciPiTNB89KE5BIfVM1/NGY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EhDM5UjDHd6k5mTFl8/Myf19UUhrj4lGCSnvUr0xs0=;
 b=haEWIz1aZ5pDDF+N65aGXOXIRnEziBCQs0wvGKJhu1m0U/tsTJtsSafvrwaRts+0gqRJmhGf072vJ03k5IBsc5/AWbw17UcOKmz2/OMULcmsnl5SyL+cuhe7FliAR2XqIBKXp3Lp7+U0Skvh/OYPRLawWwBZ59J1JPhsdS2zIq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 10:18:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 10:18:30 +0000
Message-ID: <d8b75d2e-ab52-4237-82ad-fb0c75e557c4@cherry.de>
Date: Mon, 28 Oct 2024 11:18:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Add support for flash reset
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 p.yadav@ti.com, trini@konsulko.com, tudor.ambarus@linaro.org, marex@denx.de,
 sjg@chromium.org, git@amd.com
References: <20241028070325.17666-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241028070325.17666-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdcd991-52bc-4508-fef5-08dcf739deab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzJpVkloeWkrZGNRdXFzWDhXS1RxNXZrc0lkQVNsV0ltMG5uUjErSjdTL28y?=
 =?utf-8?B?NzF0Q3BVcVFzV05wZVV0NUJhVHNjd3pkd0Z0RmVqU3pUanpXS1F6SnNzeVBl?=
 =?utf-8?B?ZmJkamhDTktiR2tjcGVndVZNMGtCMDErb0tUaGI0Y1RyTzZ4NFdmTkloTUEr?=
 =?utf-8?B?Q0Q5R0w4dEZRV2lvcU1wS05tc0xpTzhodFFkZnZNSmJWS2VoL0xPNGtLNUNL?=
 =?utf-8?B?VHAxcmVIdVlUbnlUc08wUllSVnVOdXlSOURPZ2dKWStYTVI3YmpVUE8rWGMz?=
 =?utf-8?B?QTF1WjZsRDd2QzQ5d3pMck5Vazl1SUM4MWl4TFhnUGNjTERkOS9oTEh6Y0lH?=
 =?utf-8?B?UE5iT1BHU2g5OEFPTi9NaElod0I0RjZEQ3RIU090QStSSlRsS0JESkx5Y2Vq?=
 =?utf-8?B?bnlmWXNhSGhPRWJkRUdNMkI2cllqOWVsUXVPMjZRM2crZkJJYjBpdWlrK2dh?=
 =?utf-8?B?WExIS2JYd1dnYVA2L1NSekR6a0MzN2F4aUgrZ2JFcDZOeEdNR0VENGw0bG5t?=
 =?utf-8?B?OEt5NThxREI3RTF2VkZOSTN5OHJ0NFQzMU84SHl4UElFMXRZcVZzLzZ5Yita?=
 =?utf-8?B?WWFSNldTVnJJRjlQaldURlVpNGJKZHZoeHNWSndFZjBxOFZrd2xaaTl4TDFZ?=
 =?utf-8?B?VjBJR1NPZnBKZlMrU0pRZzMxQmxEVzlKYkIrd09HRFdQVzhmaFhsQTVhYlR5?=
 =?utf-8?B?NzMzcjhvWHhkSW05Q1pWQjFvZTlVWHFWWmxHdjJNbWF2VnNTQW1qVWdoZVUr?=
 =?utf-8?B?NENPdy85Nk9yYXZxeU1vZkhnSXBvNC9sTlM1aHBFZXhhSllLTVYyQ2tnUTNV?=
 =?utf-8?B?Q1JmcXFBeEhEY3hQdkpFY1doWXdyNTVQd1BSa2NqZTE2U29UV1hPZm1JSzVx?=
 =?utf-8?B?ZFZiaXVhKzVzRDRvekJrOEUrU21SSjdpMnlqU1loaEQ0WHpHTHREVDQ3bTdL?=
 =?utf-8?B?ZitNL0xOU2JLc05UYm9ZSlVQelJDVUdkZWgzT1gvQzFZU0JmVFlHMUVLTEY5?=
 =?utf-8?B?RDZ5SVAvQThpNk0xbmZPdnB5MjJYQThvZmZCWlEyM05HNTFubTZQU29tVWtB?=
 =?utf-8?B?Y1R1Wm1LVjFab1JDZVF0R2NESlhaVW01bEN3QlNRSjBSVUIvVERBRlZVRkMr?=
 =?utf-8?B?bXYrTjFhVnU1K2VBOUM3NE9ldlZibDJTUlVVQ2JjZ3lKaHhsS1V6OHJTS1ZI?=
 =?utf-8?B?c2hpVHJxMjFkNGNiWC9WNDE3UzE0QVdWVDEzOW1oMlVWK0tBWnd5MW9UaXcv?=
 =?utf-8?B?RmE5RXRSZWhHWnhOcEd2Z0ZBdkNoZjZwbzNkR0NJTWNtT1l3VzVrazk5ZDdw?=
 =?utf-8?B?aSsrcUowb0RhUWlaYnJDTFM2MXRyYkF1eFNBTFhzNGhvUEZVWG5qMHhXdSsx?=
 =?utf-8?B?dzRwdmx3WVV5cVhVMkZRdHREdldISmw1b1M0aFVaZzhCK1FhMnV1NmJGRVdY?=
 =?utf-8?B?b21KSmJ3dkJFU0JTN2NEYkIzdGxXVEpMU3U2QTZZbkQrZ0d0aGx5ejVJTkFR?=
 =?utf-8?B?NmFvRjJJNFRieTFrazNRcEMzWlZxME15cmNzUmtqSmdXUi9qRXRjN1dXWTdU?=
 =?utf-8?B?UGppdDNZcEtWbEVtV0lyRlpSRnhGMlRkYWNyZnVOR0R4c0xHamFCU3VKb0VR?=
 =?utf-8?B?YXdzbnhQOUpQR0lpdlNDb1ZmdjdaTUhyemVrcW9zSjJQcndPT0gzQm5LcHZO?=
 =?utf-8?B?aTZDRGhSYXd5TlZTZlYzcU1KTDBWVXBzYTRoN0xsTDVxMlN6aWVHSkN5NklY?=
 =?utf-8?Q?fengiu/Lkf7FEQOltB0xl9vqo8Qf/2+SA1MJlKH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFWVnR2RVlvSUFEWFJ4SXVJQVJrM3VQYnorcUtvWDZDTE9ISjlneGhSZUtT?=
 =?utf-8?B?SmdROGdRWHFMTWpqM1Fwc0h1bnhCbnZscUdEajRVSXg3T3BtemxvVUF5d3dS?=
 =?utf-8?B?M3FSNkpxMExCSkFvMDJJYnBiKzBFUEpUTEVOU0NoZWhHY3Jhc3BKN0xJaHlw?=
 =?utf-8?B?cnZod2tudUJqQVMyMDZjNG9USmp4WTM1VmhUTFdieWYxd1R3bCtvRVk3ZXdx?=
 =?utf-8?B?d3JBVVpRU1k4dlZBQkF5NC9yUVNiODAxVlFNK0lqK3hKc3hPYmU4YThXNUI2?=
 =?utf-8?B?SzFzSlRNMG5ELzVUSU5BT2FUdUhBMDdYaVNuZ0RneENHZmp6cUdQVTIvZWx4?=
 =?utf-8?B?bzBRcGRGK2JYZGZoUTU0eGRJdGpBazFJcGZUMVh6WkdWN1lrVGFxZC9tYmhu?=
 =?utf-8?B?RjZtUGhXTVFKTzYwMzMwNmc4VU1TUUgwK0NRR1BhU05MRStqVEtUdlg4aUZw?=
 =?utf-8?B?dGtNdzV3emNDYjFBZnF0ZklneFNhYkRYbHVBUG5aakVHSnNWbjJJTUR3RzZ3?=
 =?utf-8?B?aExHRU1oTVdudURpWWZYVHhxNEtsME1BQ0F3aThOc0drTFIzcnNaaEdOalBK?=
 =?utf-8?B?L3h2WCtHV1Vnd0dHWngxVkRac2x1eU9RdkQxQ1ZheGl1NUg1dzhLMVd6VEQv?=
 =?utf-8?B?RndSdmlyR1lVK25BRTJTdnNyVEVLWDJwZXJPZitZY2VFcTFYbGdZS0EyMEMv?=
 =?utf-8?B?U0h5NVhEVkVRVXZiKy8rV2c0RGtGdWxTMXFOekVoRXQ4Q1dXenN0S3Z2Y1VE?=
 =?utf-8?B?S2tSSEJhbHdGOFRESlJTRk5McElhc2dCam1HNmNkRE9SdS85cnhXYTZhdlJz?=
 =?utf-8?B?V2dYeDhRbklPU0dCUU83QXQyY2pMMnEwQUhZcXJWTmkwVmVXZDBnVE5NQWww?=
 =?utf-8?B?Y1RLN0FVRTRCWXhIVm95K3k1NkdSdTkrMURESkVHTzVUUVNhelBPek00bDlu?=
 =?utf-8?B?a25CcEZEODNHMzV2UW5QUm5MWlFCYUNKbU95RXNoc2t2bndNYU0yVDhmMGF6?=
 =?utf-8?B?Wm1weitHTnRRTGhwUGVmWXRKeW81NXJZZlROT0htZmFNTSs4OHNxY0Y4OVhL?=
 =?utf-8?B?YWxDVHUza3JWbW1jQ2llakYzenQvSVlQNnRaOUVuTUxrbStGRjRMcld2a1NF?=
 =?utf-8?B?UytkY25Gd21PMTBQMUR6N1k2bzloUFpjV0FGMndFbzlmWndFajlnRnNMZksz?=
 =?utf-8?B?bjg4eGV2ZTVUVnNHVzlaN2xJMUFua0djTUMvc093endqTWhvZ2JYdHpsTFFo?=
 =?utf-8?B?cGhaVkNaT2ZNMlorbmRFSlZ1QlBpZzBxa3V3OFhmYUd1dG5QNU53eGhPVGlq?=
 =?utf-8?B?aG9DWU9qTTE0bmp1OUNEcmhQR1VIOExmeERtQ004c050TmRmVnpwaE1EMnpR?=
 =?utf-8?B?d2JhaUZEYVpxT21LS29rQkVORHhGOFdmMWRwNWhkU3N4SE5MdUhMK2JvV3h2?=
 =?utf-8?B?M3RhZUhJVkE2YkZIMU4wVzd0bzBQTjV4TmIvd1Mrck1tM0p2TlhDYTBVc054?=
 =?utf-8?B?S1hFMEFoVVlZdDZjdnlsTFA5UUpvZzY2U1I4UzZwaUtFMUMwbUU1eWswRzdR?=
 =?utf-8?B?bHNUNUNmR2Y1VEJna2NxZndaOFlxa2IzY2hpbzhlb3ZYMEhnd21LQmdWcEVB?=
 =?utf-8?B?WjQxcElWVVFsWkdmdmtzSng2R3orNWo0SFdwcHhWQ0Y5em5qSHE5MitlZ29N?=
 =?utf-8?B?NWdrRGIzYVJkSlk2MEpESUIxTXE1alBWWUM2ZGl1NkJ6QjJBTEduRElmM3Jr?=
 =?utf-8?B?MjB0RXlEOEFOUm9KNUpWakRHTGdIQmZlVFlYNGNZN21HSHhReGxJamlQRU01?=
 =?utf-8?B?YVJybVB5bWFyOVZnYVpQbUdYZ2VaOXRMSUgrbXI1amsrMUNuNmwxMlNYUTZs?=
 =?utf-8?B?Y2ovRXhqUjRmNU9CNzFsUlFOSldkclhKdjRiczRsMklKQytQS2xBVE1JbHdX?=
 =?utf-8?B?bjFFbGVHcmE3RXdyN2pvK1lQWDR2UW54Y1ZxQkJ2aUg1VjFBektSeUJnSVFn?=
 =?utf-8?B?by9FNUFrK0hPV3RZUDhNLzRsR3VPVSt3aUFpRHAxRlNOOFBPZHd4SmlEQU9y?=
 =?utf-8?B?NFZzbHZSbjdRMlovTnM0L0dLQlIvY0d1ZENMTzh6Zk9RNDFtWmphQk9kZ1cx?=
 =?utf-8?B?amlhYmdiTFJ2ZXpWUk84bWYyaWg3YnR3T0tzRXNCY3VTZnk2V0FZNTMxL2F0?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdcd991-52bc-4508-fef5-08dcf739deab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 10:18:30.2159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ug5zF6O03nLG22dUEpZzQvvTttRBKrbY9CWQkXZMOaJun/XVUvqy5aVvZvBl9ers6ap2Fj+pzoCvy6WKBPA7pyxUVnEt6Q1By//ylU3g8ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819
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

Hi Venkatesh Yadav Abbarapu,

On 10/28/24 8:03 AM, Venkatesh Yadav Abbarapu wrote:
> Add support for spi-nor flash reset via GPIO controller
> by reading the reset-gpios property.
> 
> [Ported from Linux kernel commit
> 8f1ee9ef71d0 ("mtd: spi-nor: Add support for flash reset") ]
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/mtd/spi/spi-nor-core.c | 44 ++++++++++++++++++++++++++++++++++
>   include/linux/mtd/spi-nor.h    |  1 +
>   2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index f5c9868bbc..900f66b0e8 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -12,6 +12,7 @@
>   #include <display_options.h>
>   #include <log.h>
>   #include <watchdog.h>
> +#include <asm/gpio.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dm/devres.h>
> @@ -4401,7 +4402,13 @@ int spi_nor_remove(struct spi_nor *nor)
>   	    nor->flags & SNOR_F_SOFT_RESET)
>   		return spi_nor_soft_reset(nor);
>   #endif
> +	if (CONFIG_IS_ENABLED(DM_GPIO)) {
> +		if (nor->flash_gpio_reset) {
> +			struct gpio_desc *flash_gpio_reset = nor->flash_gpio_reset;
>   
> +			dm_gpio_free(flash_gpio_reset->dev, flash_gpio_reset);

Since we get the gpio descriptor with a devres-managed function, I think 
this is unnecessary as the core should do it by itself when removing

> +		}
> +	}
>   	return 0;
>   }
>   
> @@ -4448,6 +4455,37 @@ void spi_nor_set_fixups(struct spi_nor *nor)
>   #endif /* SPI_FLASH_MACRONIX */
>   }
>   
> +static int spi_nor_hw_reset(struct spi_nor *nor)
> +{
> +	struct udevice *dev = nor->spi->dev;
> +	int rc;
> +
> +	nor->flash_gpio_reset = devm_gpiod_get_optional(dev, "reset",
> +							GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
> +
> +	if (nor->flash_gpio_reset) {
> +		/*
> +		 * Experimental delay values by looking at different flash device
> +		 * vendors datasheets.
> +		 */
> +		udelay(5);
> +
> +		/* Toggle gpio to reset the flash device. */
> +		rc = dm_gpio_set_value(nor->flash_gpio_reset, 1);
> +		if (rc)
> +			return rc;
> +
> +		udelay(150);
> +
> +		rc = dm_gpio_set_value(nor->flash_gpio_reset, 0);
> +		if (rc)
> +			return rc;
> +
> +		udelay(1200);

This is a bit odd, I would have assumed a proper reset like 
mmc-pwrseq-emmc or mmc-pwrseq-simple but for nor would have been more 
appropriate than just guessing which timing would cover all NORs?

> +	}
> +	return 0;
> +}
> +
>   int spi_nor_scan(struct spi_nor *nor)
>   {
>   	struct spi_nor_flash_parameter params;
> @@ -4473,6 +4511,12 @@ int spi_nor_scan(struct spi_nor *nor)

This function also exists in spi-nor-tiny, should we add support for the 
hw-reset there as well?

Cheers,
Quentin
