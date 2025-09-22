Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A415CAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B9983211;
	Mon, 22 Sep 2025 16:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NAe0JZwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92EAE833ED; Mon, 22 Sep 2025 16:02:59 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBC1782CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:02:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LVaJyU9v/QkvQ/s4yCjh+i11HADuEao14pL71vtP8OwQYZiIHAWpmMLYrxo9ideAsml6FzqS9F28Jr59LG/3v91ypvnie+TIXlQYIrMQ013MJLNUlzmy/O6Za8z3WE2Cev1qAkrX5p5YIllJzjJZ9fhXD5OR48o8K1VnrixILzyKqe6QZBfPOaWHvdMPbcRsdM98msLSaXMB/LLLoYNEQClCgTiW4KzJ/s+wiZWz3omdBK3WRcnPLGQOhSTCmypGyZBV0ZLiomzAVgpvwhA7u6MyKQrww7xcKMPutQr+5u09QBUAuoofceW4jfQBr/oSqVJtRnSVOoMMoffLt3Y7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsaCU9iYkY6rOASiB+wTP1bmlhvbXPR7vZjYI5r4NEY=;
 b=BE92bwlPuDp8NUaTIU8n+9/i79Kc9qe0/YxzIPdVJe/xb5FWzVl3uItNEdLvV/LG26sEjluP7CMlZYJzfSbYXk9GBZe+RPou7+Nkc9h2pI48xuQh9lTBODRRrheyQrr8G0aWQ1ygISdX1wxaYZgNl9r8i05SjEmanH4c3gz600VhdDMhRJNdO+yjNHSO2Wf+kV8GXklxkraoX2dZIZ/H0wguwnOc4WiAEZuuxG1trayLOGuQQfyLnSdhgPgfS2FuTjY9RRFAfrs604pcYaePMsc9QgzIt697K16rYTnPgpFoRLoY77cBrcXXucrZXONZTnML7NnGSuChXucuPwf1FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsaCU9iYkY6rOASiB+wTP1bmlhvbXPR7vZjYI5r4NEY=;
 b=NAe0JZwzht000uWNN4oJXmDnAvItD3uWek4wh2euhIAus15RJj0ejdio4FOKCdjO+A8WR9z5mhRIBxqsrDZ5Zyv805BYdaPk4r8Pl0EOG3TDwI8RxAxiWi6iPgH1YqEPQaX3PG0PCgsNk8Nubv5a2YgmuN46mSPD+RI7RVqZy4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 14:02:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 14:02:50 +0000
Message-ID: <48de987c-1255-4c90-8477-964d153809d3@amd.com>
Date: Mon, 22 Sep 2025 16:02:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
From: Michal Simek <michal.simek@amd.com>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 git@xilinx.com, Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
 <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
 <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: e3d58572-6fb4-4485-f2da-08ddf9e0b73f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjI1eTUrOXcySjZ3L2dhOHhJWjFkR3lGTlJmMEFUTGQvbzVka3JKK0tMd2NB?=
 =?utf-8?B?VzJtYnFONG5lV2xnbzlvNXNENFdNQWVxRDJUK2lzWmpDMFNUUkVKMmhTL2dW?=
 =?utf-8?B?WmV2VHNRTHZMWlV4cC9PVnJoK1ErZnBoRDcwT1ROUEMrSUkwb0dXN0J4dlU0?=
 =?utf-8?B?aEN4ZnVFb0xtZXR5ek1zWis4WEp4b0t1OGlmc3FYNTd6a3JWVEpQOHY5YWM0?=
 =?utf-8?B?SndPM0FhMlVNbk1MclROYnMyTmNQaVJDSFU4cGVuRW9ERkQ4OExNY2VIeENB?=
 =?utf-8?B?YjRtUUM0U2NPbzFiK0xrR2Ntc1pVaXpGclZGR1lMbEJMT0xVMldSckM2bTNn?=
 =?utf-8?B?amtpOFhNNDREZkVYQzhPZGxsZ2REeVJLNE1sM1E2aWZQZ25taFEwN1lFQnI3?=
 =?utf-8?B?N2cvcjQ0UXdtM05ubG1yMDJiUHBseEhQdHdUeG9nRitOcHV2bkduTVFIM1Bq?=
 =?utf-8?B?WVlrd3RZRzlFZUF0WVZkV1ptUC9NUjFRc1RMQU1sOHErRnBuMXBsV09EaUJF?=
 =?utf-8?B?QWkwZW9HYjh4V2ZHL3BJcVFDWHFhUk5HYkk1RWdjaDI4N2RGSWdEVVFJZk1E?=
 =?utf-8?B?UnZJd3dZV29iSEhESVFMRkZXbnVCTFpqMmU5WXNEQ25JNEZzM2ZsSnJENnpi?=
 =?utf-8?B?ZUk1Z013SFJ2eFBQQXM0eFd0MkJ3MEcrUTc5bzMwS1k3K2pkQUsyaTdaQUpt?=
 =?utf-8?B?am5aTUJseEJ3TkQ1SkZCQzl2U1hwWVM5NWRGUjNvOGFCd242dUxsNWZOVDVr?=
 =?utf-8?B?MXArRUVURDhuOWFNazkxajh5aFhiUzF2aGJaVG1vQmx1ZllSTWMzWDlkdzlv?=
 =?utf-8?B?NTQvUzErbjBnSlY2d09BdGVmN05LRzN0bkpSNUF1SERYOVlMZTZXS2N1OENP?=
 =?utf-8?B?OWtzaXlZc1ZBYU43QXNQcFpaeVBGTlFkWjY1U2VLMmt6SGN5ZSs4VWJGSXhJ?=
 =?utf-8?B?dzZSdlh4aGRONkpocnJoZ29XU2htQUpqUENVMU1JVllJSENDY0kzWWZqbWhl?=
 =?utf-8?B?d1JNZVpERjJPWmdhWUZQeW5UY3NsMUFJWkVHRjA3QmdwRk5SWGF4R29vbW52?=
 =?utf-8?B?Z2g1a0c3V2JpYSsvUWI2anRZWDJzSHNZTmpPTWJrRDYzK0wzZ2lQaTA3aGt6?=
 =?utf-8?B?a3NBbEJwNmVPUHNkQW1uSFU2dlVLZUs4VjN4eVZTRGxHVWhqZTdxeVA5SkNR?=
 =?utf-8?B?Vy93WnZGeTMxUG9xQWlqd3ErS2pFREJxdVAzNjdpbUowYjIwN1F0b1UwV0Rq?=
 =?utf-8?B?eDNhKytEdGVqNlpXb01BZm9FZ20vSnU0c3M3NkxpMmduUEVYYW9CN3RmL09N?=
 =?utf-8?B?Z2JJM01NdUNUZnRTMW1KNEZCTmVycnFmdGZXMDVtczRrcGxTWC9xV3NIempW?=
 =?utf-8?B?bk5ld3Jhb2YxNkUwSGdvVGh5QVhYV3JNOWoyZkppc2w1dmJiRkl6TlFpRldq?=
 =?utf-8?B?SEsza1B3eUdlQ1VtTkhkUlBYbDFUTDhlTjZTSWY2UVNZSFFkVUF6U2FuNTJR?=
 =?utf-8?B?MGlXUi9GRjh5MVl6UHNoQkFGRzFUK3U1Zm4wVGVoaERWSElrdi9mcExTb3B2?=
 =?utf-8?B?ZVJuMEJjNDAzdEtubjR1TEpTaWhzVjVkUWg4K1A1R3Blem56MW4wWmdIdkhM?=
 =?utf-8?B?cThSekVXUjNTckVvSDU3Z0E5NEhkNmFWRmIvd3k4ZFB5WE81bVl1S0s4TExM?=
 =?utf-8?B?Y1NBWUtCVC8wTzZDWlFJWGlxU0U4S0UxaE0ya2xpZTE0YUFoUDluMXNMbVA1?=
 =?utf-8?B?OWFrVjVJMkplSTNTRnRDclVwZWduWDJBQWVtTThtYzZsRVd2V3lMLzJkeTNs?=
 =?utf-8?Q?FawtfBIbcHKoriFQsho1LnUJeuNcj+eZ8bdUo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmtiK05TWWZRMWtZM1JWTjFaNlJWa3Z2ZFNtMmxLNXFVSnRRK1F6WTR1cDJy?=
 =?utf-8?B?M3RHSmh6Vi82STRDQ2FBd0NLUWZNUzg3OGNVbDRVWmVmYnNvS3EwYWFQNUdu?=
 =?utf-8?B?b2dxRGc3NkV4dlFFOFg2d2F5ZndHT2FEZzY2aWZTTlNnMkU2WVN5Qzd6UGVm?=
 =?utf-8?B?eWdDMWNSdGJEOHZMdkc1OEpjT01kT2luaE4vUHZUTFY1VnJrMGc0UTFUUllz?=
 =?utf-8?B?a3dHLzA4d3UvMmFOblA4d3VYWEhKRERvU1pLM1VaTjhWQlBpZW01eHNmNkhy?=
 =?utf-8?B?T2lUZkxjOFJWZzE1STB5STFUSHZkRlliSEhoSEhTa2NtbmQ4WXRPV3ZvYXdu?=
 =?utf-8?B?MUxjenJmQndVZ3B1am1vdU9BRnFZYTM5dk9rYndmMmxmaGhDL0dXQmVoVE41?=
 =?utf-8?B?aXREYlprZmJ3Q25CUGxwRXlxbWlhNkl1WE92WVlwYjBabTlYNjJ3a0lrT0d6?=
 =?utf-8?B?cTMvanZRT3ZTdzdaa3ZOZmFZVFRId3Bya20rbUtwdENDSzZtL09RVDBGRlhS?=
 =?utf-8?B?bUdaS0FTd3ZSbmlUaXRNQmV3M010SXpZYUQwaUJHTFBseGcrUUtRd05yUHl5?=
 =?utf-8?B?WEtuZ2svL3ZNaElpYjlXOTNqdnp1aXcxbGpNL1A5R0FUajluVldyYittR0sx?=
 =?utf-8?B?M2t4ZEtVNjNoR0kxWlllSk1RNWJBNDZNeWg0K1lnaFBkNUpxU0oyM3NHR1gv?=
 =?utf-8?B?anAyajJxUUR5K2ZGZFh6ZFk2NEVGbHd3QkFJdkxvbFBSUE03ZXowQW1aMmhP?=
 =?utf-8?B?MURGOWk5aEVmSzllNEY2UnhLYW50WmVncDVjczlEa1dxS1Vxc1VqcVRoS3Fl?=
 =?utf-8?B?S016UnhJN1lrNmZtL3NGei9vT3dZdjlUeHNUYUVNQlVhZkNnOXYvRkI2NGp3?=
 =?utf-8?B?Z241R2pQa0d2NFpTVW81NENCK1M5SUw5T2ptNVZUTDZSbXN4S2N1N2Z5Q3F4?=
 =?utf-8?B?a1FUcHVtZ2F5YThmVEZ0cWNsZVdvb0dkVVVHN3o5WE5HU1g5bUpxOFpaTUhV?=
 =?utf-8?B?UGIxemVscmVKU20yOE5wWXhhL0k3MjIrcU1OZDNpTVdvbVBMNkNycUMzdnJG?=
 =?utf-8?B?SDFrWm1tdHhEci94SHdqZGV5TzBVai9qaUNUQXdCZ09KamhnTDBzbXVLR2Fm?=
 =?utf-8?B?MEN0RW53ZzJSa0lHcTVpQTFNejJCaXkvbnJ0ci9nNHlmaDVFOXpva3NncWxw?=
 =?utf-8?B?bTdHNTlLbnZ3dnkxRjBQbWtteGxGWStiMTBDaTBjYWVldWdVNlZwV0hMT0M2?=
 =?utf-8?B?RTBJVGpKZGUzYTIyUkpKaGgxS2JRVlBWUVNqM0ttTVI1WDZqZ250UWI0MFBr?=
 =?utf-8?B?cGJUVy9sU2NMWFYwSmhwcVVheld2K1pCdk12YXNERmd6Zm52Y0hicUZUK0pB?=
 =?utf-8?B?RlRsYjN1UHRBYysrSFVLamFRMDJEcjlBSmFoV0tOZzVrRS9iQkxZaHNuWlZR?=
 =?utf-8?B?QjVzdzJhRlpLMTFRVWhPaGtoREVMMDRhNERCcDFKdnpLc0lrTEM3RnFielA1?=
 =?utf-8?B?NEluUUtzcXJaSlJxTHJTQ0IvV1ZHdzlXeWh0dDdWUjBiUUdMdUEvTC8yUmgz?=
 =?utf-8?B?eEtHYXZucWc4c0FRU0M0RU92OUhnOVR6cUVGMWkvT1JXNXQzc2MyY0puazJS?=
 =?utf-8?B?dDROR2hnUHVOS3VwVWlxcTRtVE1ZUjdTcFlFUkdYVjd6SitGMEp3c0s5dUZ5?=
 =?utf-8?B?bmg0NEFtRXJyZmlUV0tjcm40ZUpIL3gxanNMaXJML0lMQmQyQ0llbFY4dVVy?=
 =?utf-8?B?N2pkdnUzaDhBbUtZbCtLMTVsSDBwRC9ZWmlmbmF6ei9MQmVySmVsRmRRaHVJ?=
 =?utf-8?B?VGJMTS8va0R0NW5OMG1QVCt5eVRMaEk0TjdMUFY2dmozVHd3VGg4VWlCa0Vr?=
 =?utf-8?B?dzMrWER3SEpYWjI5Z0lNYmUraTZFSGRkQUFYdWk5T1hidGNjMEJyM1RNaGdN?=
 =?utf-8?B?OHJWTEozUmNmcXp1L0dwd2lHaERyd29Id3ZEM1JBSkorZWg3NWdKamZublZi?=
 =?utf-8?B?bzFWWDZtRmlZYWwyQ3BMNTBlMUM1bEZMR282Tk1HeWpnWXJGNlJjWkc5eklv?=
 =?utf-8?B?N01GZlZLS2huanBOTFZwbFVZb2RZaUh1VmMyNEZkYlVOMnJITE5LYlVRVXJK?=
 =?utf-8?Q?FJ34dOiQUU9Ax1YruslyHMWEx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d58572-6fb4-4485-f2da-08ddf9e0b73f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:02:50.0841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxZdLcD4xOxMw/VhNyZhO8ouzTXRWrJZgQbAWptZQ00ON4gVdk2xZmBn9BgbZ651
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
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



On 9/11/25 07:40, Michal Simek wrote:
> 
> 
> On 9/11/25 05:28, Marek Vasut wrote:
>> On 9/10/25 9:26 AM, Michal Simek wrote:
>>> In case of ENV_INVALID (uninitialized variables) the first env location
>>> should be used for storing variables.
>>> That's why change the logic how env_valid is setup to be aligned with
>>> offset calculation.
>>> This will also fix the print about Valid environment is showing proper
>>> location where variables are saved for the first time.
>>> And also fixes behavior where the first two writes were going to the
>>> first location instead of the first to the first location and second to
>>> second location.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>> Changes in v2:
>>> - Simplify commit message
>>>
>>> Origin commit message with more technical details.
>>>
>>> When both location for variables are not valid (or empty) gd->env_valid is
>>> 0 (ENV_INVALID) which is setup by
>>> env_sf_load()/env_import_redund()/env_check_redund() calls.
>>>
>>> When saveenv is called in case of SPI env_sf_save() is called which
>>> contains logic which describes new/old variable locations.
>>>
>>> if (gd->env_valid == ENV_VALID) {
>>>          env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>>>          env_offset = CONFIG_ENV_OFFSET;
>>> } else {
>>>          env_new_offset = CONFIG_ENV_OFFSET;
>>>          env_offset = CONFIG_ENV_OFFSET_REDUND;
>>> }
>>>
>>> In case of ENV_INVALID option the first location is used (else part)
>>> and variables are saved with ENV_REDUND_ACTIVE flag.
>>> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
>>>
>>> And
>>> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID : ENV_REDUND;
>>> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
>>> but that's not correct because the first location has been written and not
>>> the second one.
>>> That is confirmed by
>>> printf("Valid environment: %d\n", (int)gd->env_valid);
>>> which is showing number 2 (ENV_REDUND).
>>>
>>> That's why change the logic how env_valid is setup to be aligned with
>>> offset calculation which also cover the case where initial state is
>>> ENV_INVALID.
>>> Then print about Valid environment is showing proper location where
>>> variables are saved for the first time.
>>> But also it is fixing behavior where the first two writes are going to the
>>> first location instead of the first to the first location and second to
>>> second location. Alternation is happening after it.
>>>
>>> v1: https://lore.kernel.org/ 
>>> r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
>> Sorry for not being clear, the original commit message structure and technical 
>> details were fine, it only needed slight rephrasing, in the original form it 
>> was very hard to understand. Can you please reinstate the original commit 
>> message and only clean it up slightly ?
> 
> Can you exactly point me to part which wasn't clear? It has a lot of details 
> about flow and obviously it makes sense to me that's why I would like you to 
> point me to exact part which should be improved.

What about this?

When both SPI environment locations are invalid (gd->env_valid == ENV_INVALID), 
the first call to saveenv writes to the primary location and sets the active 
flag. However, the logic for updating gd->env_valid incorrectly sets it to 
ENV_REDUND, which does not match the actual location written. This causes the 
first two writes to target the same location, and alternation only begins after 
the second write.

Update the logic to alternate gd->env_valid based on whether the last write was 
to the primary or redundant location, ensuring the first write sets ENV_VALID 
and subsequent writes alternate as expected. This aligns env_valid with the 
actual storage location and fixes the alternation sequence from the first write.

With this change, the "Valid environment" printout correctly reflects the active 
location after each save, and the alternation between primary and redundant 
locations works as intended from the start.

Thanks,
Michal
