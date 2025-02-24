Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5077CC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 10:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E097B8081A;
	Mon, 24 Feb 2025 11:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PaqDtkCa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA1CE80F3F; Mon, 24 Feb 2025 11:01:31 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAE580017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 11:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpNyeEZeX9nh4uCgENY1qs5zMBwpepBGC8ozv2O5MFFTCtcDP23mchRkj4JxTLdvmAlcUMyH2N4EWFiatdiJElt6WHAXqj/RFfxAOgZReNUqnNt0t4Prbqlzx0TvgwzQBIdQ+1FT2KDtXMezUzFIOkyxJxW+loBKeZvzyKO6jh+EeCYXbNqJYARjhkJNyu92C1XHlZNbpoX8RFQEfyz6YcwtUCqss72R6L3EOb2wB+OpI6COyEPJfRMVdUPLbp7v1WS3EfV2/TnLDTkUF/3ofzqw7Pg7ALZA8X/Oo/gFkPYSD/YieVYlKVk049G41BQ03XjsG1AIkO3r7oDNnzWpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIRJRWbkEEkeu208zZCnYakN5SmDIjhnj8AfD1p2ENw=;
 b=pKrVSITAYbqBD54g3eZ1KOsFGi22bhUoc3ywEaF10YW4A5HxBEtIpYV5yO9pYGr+GWQjkO0QVoYU7bN93MnHAlrubccBkRkQqRwKwL/R/B7YrG6WL/8bVPCCcjvQNTrfkOLANkq1PFxoOFVWdwiAluOyZeluU7HahvundMZ25PnBW22VHy8hwtVHoy4uIF5310Byr4jyJQhI4NChqJ28/YQ+w/2vet8Tp+7pODlTE1m2lYFmamYShCuK9wg3X12dt4k873ykXwRzODj1gCNMI5mXk1Yfj4N5Z+dVmrZESaDP+yaX5GbYIHUDd0sZxKyYzM+1joCaqNgbiD4Zn1l3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIRJRWbkEEkeu208zZCnYakN5SmDIjhnj8AfD1p2ENw=;
 b=PaqDtkCaGoyQ9liWljInc72+9SoT/ERPYGdU0s2GaKpxhLIPNjiALnWNQbr9ZRpl3USxNPLuccceeQxsgIxw8wZSqxz29SpXJ+R0yvJLorE2eqr1xQx5MfYHk4MLo+Jd2fMb0P0uD3TjFRIdH4TC42URh4lAa/KcAd6qa7Ypu9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:01:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:01:26 +0000
Message-ID: <94cf226a-c217-4e5d-bc63-60f5b7c4cb3b@cherry.de>
Date: Mon, 24 Feb 2025 11:01:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250221184732.202336-1-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250221184732.202336-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0344.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 36326cf2-72ee-4e31-3757-08dd54ba337f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUlNNGtac1JWTktzdjREUnNiY3hraTRNZ0FEdXNoRFBFNWdGNjhJL1F5VkVl?=
 =?utf-8?B?c2NnVHBUSEFadzAxOWdvanVUVEpHK0NNcWYxcStHbFFVNHdmQk91TnhNS0l6?=
 =?utf-8?B?NlNJK1JPYlFqVUpYd05QditvZzJpMTY3dHQySTdGV3NmRG1qMWhjMkxYZ0k0?=
 =?utf-8?B?dzE4YzJNR2d5ZzFCd0NKQ1QvdWZHRjNrT29QZmlpeUdGMWl2NVJYdklVK0s4?=
 =?utf-8?B?ZGYrYWFZV1JqVU16aHFLVGNqRm5Obm81R0E3VU9Hd1pKME40TThJb3M1aFE0?=
 =?utf-8?B?NTVhNTlQdkNKMmNBeDhWNlp0anhqUmNjSlN2TDR4MTc0VVltNHYra1NPbHRG?=
 =?utf-8?B?bWNjUWRHWkkzRFV4bEY4dSs4YVZLVHIzalN3QVNwSWNpMXdYUW5MRG4ycmZ5?=
 =?utf-8?B?RTFXN1RYaDBra0IxZVczTElxOXkyKytnOUtEMmhvVEtmRzBDdENiSTlOT1o0?=
 =?utf-8?B?cWpHNDZaQUtqS3VjS21DZ0JpRnRuS3dQcUxOQmRyWjduVHJIR09WZ0lRNUZH?=
 =?utf-8?B?Q2NHTGg0WEcxazlnaUgzZFlNZi8vU0lralV0UzNIMS8xZHpGWWtJQUlVZGpr?=
 =?utf-8?B?OGQ0QzRRZmFIakFoQnMzb1hRZjgwbWFPaC90a2FZN25jYnJnczNqdjJicHcr?=
 =?utf-8?B?MlRFci8yT255SFBoeFl4RW9jRHRFaERWWE9XSi9Db2wzcXFkTXVrYVVBbmpY?=
 =?utf-8?B?UjlsL0NCaE1kdFlPYVR1ZFNvMngvZUhQMkJkQ0dxczFMN0wrLzJjTFNWZjhP?=
 =?utf-8?B?Y3NhR1hpdWtvb0Jzb2g3bGFEM096N2E5UjlWTVpxeDNxbFE0b3psbVp1Mm9S?=
 =?utf-8?B?d3RQcnMvMStvcUwya3E4Vk1PK056SWFXSDBYMklaRTN5RmlOSTBaTzZEeWd5?=
 =?utf-8?B?UUEyN3owYmIzMjgrVkxkWjhFelBqQmdOOExtRkxXYUJ6U21EQ0ZNMkc5OGVa?=
 =?utf-8?B?ekM3aytxUEx4ZDFKbitjUkM1ZEsva1JZTU5pSGQ1VkgxbElWdGwyVHB3a05P?=
 =?utf-8?B?aG8zcmltSTZqUGY1Smo0cm5nZTlXOGJjcXNrM2lrL1YyRkJvd2JSUS9GeVZt?=
 =?utf-8?B?akQ3eVFkTS90NWFVTWtwSUdxaHJvNXU2YkFBeE91eFpWUzBVa05SUlkyTWRW?=
 =?utf-8?B?dnlkR0twV1lHVnlnVVdzUnhYY2RLd0dGejhhUEJ0eFRxOHg4a2I0L2ZzK3pr?=
 =?utf-8?B?K0MxNGZ4a0dzczduZklzWHE1ZVpmbm1tY0JhS0NEQ0JqbVpyYVM0b3k4dFFW?=
 =?utf-8?B?NWJ2MTJ5YWtxbDNXbG1vcmdkaGxPeU5Pck9oQ05zK1psWXprdUxZclgyTUtF?=
 =?utf-8?B?aTJpVklPWCtrTWZkMk5GME5IVjFkdHM0TXdLNU4yNDJvR3QzdGI0VG55a0Fi?=
 =?utf-8?B?elh5THlBbFg0TXhJYUtOTkpGb3RLb21BdExFQkR4dnVMNmNKQnhXdDlCYllo?=
 =?utf-8?B?SHVmQkRVTGU5emlGM1hieS9Pb0NFaWpkVE1oeEFTNllDc25DYUl0bDYyR2tC?=
 =?utf-8?B?TmtWQXFadXVUSTdRc3lodjQvQjVCdWptQ1BrSjRxWFQ2dnI5MGs5bi9xME1i?=
 =?utf-8?B?SFlMQ0pVTnJhQ2lHeEx3TG13WlFaUUJwVElodkRWRWRzd1hybnNPM1A1enYx?=
 =?utf-8?B?cXFSRUthZVNETFE4UCtPM2VUbTg1MDlsWmExME9ZWEh6cGFwZWRHbHo3a25Y?=
 =?utf-8?B?MytZNzNKYzU5b3RSb2pNcTlmYXg4WVZZeVFyL1VwZ2JFVFNOclRzdUFsN2x1?=
 =?utf-8?B?S2FMNGVhVlNxSXg3RDEveGZZUktPYnA0ai91STl6em45Skk4dnhpYXV3RENj?=
 =?utf-8?B?bzRlYzB1dmlDWHozN2xzNWRSdjFJNThFT0phN1gxTmhXaEpQS3JPazNWWTFn?=
 =?utf-8?Q?UWww18ST02OiI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDEycGVFcjA1Nng4Zis1YUhBT0I2dVJKVjN3TGRjRFVXM3RoM2ZoKzFVM0lq?=
 =?utf-8?B?MUJGSVU3QjhRejAwR1F2bHkzT2ZmU2FOTFRLenJPcjgwcGdhZlZ6ZEdGOSs3?=
 =?utf-8?B?VFlyMmJnWXlQb1NCWEtYSmdacms4ZURlQlFUUTdMakIwdU1KOWVMeEJZZE9x?=
 =?utf-8?B?eXBJbmlXZUJLRkR3N05zOGlkejdRY1dTL1NGb1NkdVpaQ2RvcTVNMS8vSlVS?=
 =?utf-8?B?UCsrWFh3ZElsdTZHY3VxMmRnK2Z2YVhmelRQRDBvUTNnMFpHQS82SjVaMmU4?=
 =?utf-8?B?MUg2d1oyaEM5aWNBMnpNSzg5WlowNWlDL2JNajRINUZHQTZuL1M2V25YWHdS?=
 =?utf-8?B?WjJldVBFUENTT1FBMGl5VEpodnZoK1pyRDRtN2F3a1JLZGlwbUZkREJLb1Bm?=
 =?utf-8?B?LzB1L3hHdXhTU0w4d1hpL2w5R2JEZ0J4REVQZU5ESjZ1cVFhNzd1MGNQVjRB?=
 =?utf-8?B?M3VQZ2hUL2xxbDVFZS9ySHhMdnhjSFlka3dMNkUwNzBhL0F0QmM5WU1xdFQv?=
 =?utf-8?B?NzRXNmk1dkE5YlB5S1ZGS1dwVXcwQXRPNk03eE1RbU1EVkVGWDdmQU02Q3Z4?=
 =?utf-8?B?RTBoYU1mQXQ5Qkxxa3ZVS1JKbjA4T3lTTVkzYlNVRjlNVmlxdDFadFM0ZWpH?=
 =?utf-8?B?cFI4QVNmbk1VTW15ODlGZGJIRVhPTlJKcHhKR1NvZWF2VWRuVVdBblFENDVt?=
 =?utf-8?B?S2Z2amVudkg1Y1BqaXFhUms0TUZ1SGFKeitYZEYrOFI3REpPR3cvU2k5dFBS?=
 =?utf-8?B?REhVQkVRUllqUzkwdWJlVStFZ0MvdU8zWXV6dEEwZk4rK0FybndacVd0cFkz?=
 =?utf-8?B?YmQ4YUpETTFQb0EyajY2ZEVUL25LSFpqb3AyTWRDa0YxQW5wTCtTMllnZHhM?=
 =?utf-8?B?NCtXZCs3c2NwWHpkdDdqdEdIMnNnbTIrY25xU1F2dWZNa2puaHhmc2Z2RTZ1?=
 =?utf-8?B?VzZmL3VFdCtyb0Q0L2lWZFhqMWkwNE9YQ1pnVnlTUFpocnRQUHltYTRpc3dB?=
 =?utf-8?B?RTJzcXZINnFWK3E2NUp6MUVTWDdZdnFxWkFSbVY4WllQdU1PdWFBYkV4L1k1?=
 =?utf-8?B?MzE5ZWZlZVVmQW8yUUJOVnJDN0ZhV3k5T01ZQ1ZwVk9iaWh2T2ErYVJybWNM?=
 =?utf-8?B?QmJSM0p1UHNJaysrOE1BNHlrVUw2UkQvSkJqcWZqa3NIWW1FOHFIWktoMEJy?=
 =?utf-8?B?YkozdzREYVdDM0FQWTlHN1ZTaWVyd2pkRnlOV0FjbHVMNlczRTFhY1Zwa05r?=
 =?utf-8?B?dnhNaGFObzlxSHgzVFJ3eTJnTFQrK1FRSkd2OUNqeVRaWlJ5L3V3SmtaWUsw?=
 =?utf-8?B?bVc4bTc0Ry9EQk9NVVVoNFh6UGZlY1hoUzJwK0NoTTYyVEMxb2VkZ1hXN201?=
 =?utf-8?B?RHljcTFIQVlpbytwLzlmZ1FWQUo1Q3d3c3Y2RzI5amJCNkFHcENWekxidVVv?=
 =?utf-8?B?UXV6U1lPZ2RZK3E1eENMNGFOZ2duREc4cWRibVNGTkFNTm5GeE56U2NoMm1o?=
 =?utf-8?B?SUppVDRKeUV5Ty9YT2tGcFNIZDZldi9ZUnpnZnFHNGVKMlNrL21qSE9LRDVE?=
 =?utf-8?B?T0J4M0J0YVZuRjJlazBDT2JGMzZIa1pmV0pWV21vQzdtQjVYdXdwK3BTaTVE?=
 =?utf-8?B?c2JidWthVnpva0ovaGlUWUNUZkcrTW9penlMeHZqVUtCZlZNa3lDYUdaUTZW?=
 =?utf-8?B?TGc4V0lDeXYwbFhtVTJpRXNsN0tzRHlrTzdEbFp3M1ZQRWx6R3FSc2t1WUMw?=
 =?utf-8?B?ZnNHSXptU3IyL3BHVXZqVElkemlxcVg5dkVoT3pGL1VYWEpHaGk1eSt6U0JP?=
 =?utf-8?B?SkFrWGZnZG11blFWdnpreUV0a3NCUzArd09TTVJGSzVGejJvTk1wZ3ZaL282?=
 =?utf-8?B?cDBRV2RYVWZ5Y0ppbWVHT0RYcEticGlpdzc1Y1dXZkZaYnlJdVVrckVCQ3h3?=
 =?utf-8?B?b0VlQmtReGVTM3JSeWVzb0h4U3dtcGVYVGdtWExnWXNId2tsSmVxYTMrWjF3?=
 =?utf-8?B?QWVuRVVGVHM2RGlRWXgxMS84WDExWDh5WEF2akduaEVuTEJIeUh2K2lFdTFB?=
 =?utf-8?B?WVo5NnNqYVdNOEZ3QWVsbWtLeDNqUS9RTUJkNER2LzM4YXhGQkxxN0FkL1BN?=
 =?utf-8?B?Z2NmeCtzMS9UVmxKY3orczdsWWZUZDN5SWpjcVVCWUJRMVV5YUR2SnNPZHVH?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 36326cf2-72ee-4e31-3757-08dd54ba337f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:01:26.2711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5Lipm3Rt2Y6EnnkyKTYPO2oHrYeLgXgs7bf6mKRgIxA46XDHd1EoJYX242Zpu4OCXTPQCWd1E04Vlh+U0JNiPXZ8mlITngHRt3TUL+HXwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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

On 2/21/25 7:47 PM, Marek Vasut wrote:
> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
> 
> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
> in the last conditional, which does not do plain macro compare
> (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND), but instead does
> mmc_offset(mmc, 0) == mmc_offset(mmc, 1). If OF_CONTROL is not
> in use, this gets optimized back to original macro compare, but
> if OF_CONTROL is in use, this also takes into account the DT
> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Rename mmc_env_hwpart_redund() to mmc_env_is_redundant_in_both_boot_hwparts()
>      - Return bool
> V3: - Hide the mmc_env_is_redundant_in_both_boot_hwparts symbol behind __maybe_unused
>        as this symbol is called from code gated behind ifdef CONFIG_SYS_REDUNDAND_ENVIRONMENT
>        in env_mmc_load()
> ---
>   env/mmc.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index 379f5ec9be7..353a7ce72fb 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -40,18 +40,6 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -/*
> - * In case the environment is redundant, stored in eMMC hardware boot
> - * partition and the environment and redundant environment offsets are
> - * identical, store the environment and redundant environment in both
> - * eMMC boot partitions, one copy in each.
> - * */
> -#if (defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && \
> -     (CONFIG_SYS_MMC_ENV_PART == 1) && \
> -     (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND))
> -#define ENV_MMC_HWPART_REDUND	1
> -#endif
> -
>   #if CONFIG_IS_ENABLED(OF_CONTROL)
>   
>   static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
> @@ -217,6 +205,23 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
>   }
>   #endif
>   
> +static bool __maybe_unused mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
> +{
> +	/*
> +	 * In case the environment is redundant, stored in eMMC hardware boot
> +	 * partition and the environment and redundant environment offsets are
> +	 * identical, store the environment and redundant environment in both
> +	 * eMMC boot partitions, one copy in each.
> +	 */
> +	if (!IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
> +		return false;
> +
> +	if (CONFIG_SYS_MMC_ENV_PART != 1)
> +		return false;
> +
> +	return mmc_offset(mmc, 0) == mmc_offset(mmc, 1);

This is not always equivalent to the current test of

CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND

Indeed, it only is for when OF_CONTROL isn't set.

I would recommend to keep this check in patch 1, then add another patch 
that swaps CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND for 
mmc_offset(mmc, 0) == mmc_offset(mmc, 1)

This will allow to use DT properties like 
u-boot,mmc-env-offset-redundant and u-boot,mmc-env-offset, which isn't 
supported today.

What do you think?

The rest of the diff looks good to me.

Cheers,
Quentin
