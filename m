Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D97C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96C0B88A37;
	Tue,  6 Aug 2024 15:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MmmD5Hh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73AC1882EF; Tue,  6 Aug 2024 15:19:12 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B6C88A3A
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 15:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHi7VfLhDZhR5lrf1Ia82f6O8lnUSITU6S8lKaDlTqn+AQeWpnMlpMKSJKz8jztFcvkxXhntk2ZxRQnFnqbeAFGJKVCsEH525pyh+UwziWFi7Gmzgi0m82qI9wAryPqtOkxR863WJbHp/3qx150SlTk8OYyR3BskCpT73YQX8g+KAc1zGNfkHOgEPlacHB+toiYdq/UDo/qxIKC8lq7SFSbhuWPida0efimop+fZZ7W6SrSdCzZX6MxAWrDQcIqV4lQXvKKZqTrBRwAzlz8RYka09GG+B6xG0sgZwIklq5MdBHqvIsmFmY55MHqZ9jXUt0U8D6oBvEZEaFwTayLsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzlNdHAuf8bh46Kso2ZI6/F7PC2DvEwlGhVzFNd/v6U=;
 b=D4LOYuzCjlExcK9WIJaTjPdUzetQzh37wsTPEbykut/70UfAGLihc+Dwh5AtTtxg0RUzaXLVmP9EKLc5SYHTQaITME8vJCV5nW0O8pSYliA9BGPXVZltDYghcOWNVcum4Ht6+KzQvvF7wmqt6tR+8Ghv5vDYZYBuluBaXOzGpx+s96K8SxagbT1N+aqDq5djks90EyfyVFHfePmZJ9Hk54H5Q1tADhLEqO0tbYTIj7egpE9u3krxlWWrVka1GUNNAp/JS20DzNL0Lg1b+p33HGxcb44oPOXU3yOvsQHgQ95hgpzoYDIL8p5z1AwAR5Hms2TsX4J7NaumWYJHcxFARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzlNdHAuf8bh46Kso2ZI6/F7PC2DvEwlGhVzFNd/v6U=;
 b=MmmD5Hh429thQMACfkrZFr3mA0uXN8OYuvLChqwtU36thNzvyLe6lkQYGUB+zuwuifk+LT1DdgR9yu8QqGmyW2+Sck+x2BWjC/qY0enjdkdwxsmb2WReb40khJSqKMXBPCBYeObkIoZg1CgGC9OhZz53n0qfp70vTfVzNOB/UHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9008.eurprd04.prod.outlook.com (2603:10a6:102:20d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:19:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 13:19:06 +0000
Message-ID: <1eef182e-6c51-486c-9c73-9af445232c1a@cherry.de>
Date: Tue, 6 Aug 2024 15:19:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/14] spl: Remove some #ifdefs in
 spl_parse_image_header()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-4-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-4-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0215.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::36) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: b15df98e-151c-4983-238e-08dcb61a5946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rnh3RjZNZWU0c1JZdXE0bGpSMlJhUzF5SDZwakd1bGpJc0M4Y0Y0RHNmSnNm?=
 =?utf-8?B?YWNpUTlBV2lyWGcycHlyK25QQUtnL2tOQUVtVjBBMHZ4ZG5BYVo0NStkVzB6?=
 =?utf-8?B?TkFPK2FTRFRXaUR2aFF2UjNOd2JRdkNiU0xvS2VhYXNKZ3V6M1RxcDhRckQv?=
 =?utf-8?B?dWpVSlRuYUdLN1Z2YVkrVjRYMEllSmJGWWhSSVozWW15VlhndGEyOTlhQlNC?=
 =?utf-8?B?ajgyUG9FQlBxU0ZvMGdiNlJud2Y1N2lnUXo3azduWjJnZXZSdjJOVm0yZEFz?=
 =?utf-8?B?bWZjcmZJU0FiaGVwWWxES1VmMWV5NndtTTNYMUJ3Z2tCRG1CRHo0cVo1bGJC?=
 =?utf-8?B?alZrbkpWRlFRQnlJZUViSWZoNDNzbUlJc0gzS25zenUzMmk3TUFZT2RjdXZM?=
 =?utf-8?B?UjZteVpGclk4a0JqaEZzakFsTWg0QmpaYXVxS1YzdlVZL0lKVVBlaGFHL3Vr?=
 =?utf-8?B?S21EaFNRendzRkw1NUZlaTNnK28wQXBWSDhBYmMwRm5GYW5FMU9ZU1RlTU1T?=
 =?utf-8?B?bUlTSTg4bGU0VmVNUWNrTTRsbmlLbnd0TUJvdEJLUU1VeFRKbEdoNDl6T09C?=
 =?utf-8?B?eVZ2YnJsZUVScCtYM3R1eitHVUJlMGZUdVk0c29EVFFsOThvSkR1VTVpMHh6?=
 =?utf-8?B?dWRXV2J6TCtOZFpTWG9NbkhUNzFqdHlsajJlc2tUL05haS9VSGFTRjJPQzMy?=
 =?utf-8?B?bjdNWlBqY0x1RE55SU5sY0d6b3prVFZFc2l4dVo3ZHFtNm9FblV1NFFCSTBS?=
 =?utf-8?B?RFJYaE9oRmVyZVJNb25qRS93N2c2enh5QUdWeFdlRE4wQVhWbEhnVEovUEZU?=
 =?utf-8?B?ZzBXb0FFM0hyTnpwZ1pibC9CdE83emlKVWRZV1YxOWVLRWQ4eFYyblZBRVE5?=
 =?utf-8?B?R3NMZFkranFnbUpkTVhaYlozVUZGRUhzMlUwdUJhVEVXNStVWWRHZS9oOVRP?=
 =?utf-8?B?eGxlN2U1ZTl1Nit1Q0hLd29Id2dha1FxbHRURGdkL3dzUTRzNkZLbUFWclEx?=
 =?utf-8?B?M2JkTDg3VndiNi9Cck4yNkZrZXNyTURsN3JBSE51eTlteHZlNUlBWWFmZ1cx?=
 =?utf-8?B?djdBYWNPZldVaWpVV3VNOFBsUlhaNTRJK1M4NWljbzJqWnY1Vnd5Q2xSdVAv?=
 =?utf-8?B?RW9YYWswaldhUDg5dnJuTE0wVUF5eVZrenBBRTYzVkREdEpWWHBoZXEzMHk3?=
 =?utf-8?B?NjJ2MExpVVhZZEY2TGpsQUFpeFVZM2VSYjdMd3lhdnFjNFdpeklEVGk3YXQ2?=
 =?utf-8?B?ekdnZnlFNmdLN0VHeUIvQzhXeXd5OWh3ZnRMQmQ5S051d3VBcmRDQlFpMElj?=
 =?utf-8?B?M0hVeU12YmIybXNjRmRlZlI5K215UVppVEhOSEpWY2ZEbU5ZRXh2cTZqcmFB?=
 =?utf-8?B?MnZBQzRvcVVtMlQyZHM5OXV3aHVkR2VlRGRlc1ZML0FKNG95bWpUMnRBR0FN?=
 =?utf-8?B?THYyVHM4R25IM0FxNDRGUklZaklPTEI5MUtIK1pESmhGR3p1ZDhPZDZ0bHRY?=
 =?utf-8?B?SVlJQXFpdGwxaTcrUE16Wks4Y2NwN2VNV0QwUGFQcis2d0wvVG5tTkRZUEFh?=
 =?utf-8?B?R04xY1RDWEE5azRuZTVQV2lobUVzZjg4OGNjQTcwS0F4bS9IYkpZUVN2S2Ur?=
 =?utf-8?B?eEdRZHp2dDU1YS8zalpkdnNoKzc2Sncxa1Y3S0VNTEtycFcyTEoyRTdJSDFR?=
 =?utf-8?B?SmpMaXQwRmJVei8vT0pBQmxwU1g4OE5lUVBGeDdMV09OamJBWFVpd1lSQUQ1?=
 =?utf-8?B?UjVYT3F3N05CR1pKWGlGcjBBQVRRb1I1M0o2V0plNG13K0ZSTmtUQUdjNVNn?=
 =?utf-8?B?NS9nR3RzRlIzRlNRUUZNdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdSY1YybTdVN3o0ckpUVUNQY2tkV252d0VlU3JKTCt3dHhtT1dzYlFjSFZn?=
 =?utf-8?B?Mi9nQ1Q4bGN4WHpqUzZ4dnFtQU0xZlNuVzhJa3VBTDBJTSt6YzAyK3p2VGRB?=
 =?utf-8?B?ZktjWUROTnBneVFKdVpjdGQ4dEJ0Y0FGaXMwMlR2aE1zRkxzVkdoWHMzak9y?=
 =?utf-8?B?ZUdpWlpjbHBJR2lON005WXdSVnFPbUxhYjZpNXVCWnQ2dDlCUGErSWdoc0Q5?=
 =?utf-8?B?VVRHTUpsOVdFMFVCUCtYWnFKdUVyRzROT28rVWxjamJpSXlWWlNxR0JYekxa?=
 =?utf-8?B?dWU4S1JnUk5zRjhUSXVXaU90ZDcza1hRNEU1NjNhVU54RndwMDYwTFpkM29w?=
 =?utf-8?B?RUhoZ0pEMGxjSFp6eXc3M1hQZ3o1bm0zUlZyR2E4SDY5Z2RjbFg4SXNIMS9P?=
 =?utf-8?B?VlpTS1d0NWlwTlRxRzlrYnVLeFdYb21WU0xiU3NkellRMUY1cE9WVzl3YlhJ?=
 =?utf-8?B?OTFjMjlzaHNFeWxwcDkvcXNvZzdmZG85MEl5djZlZDJCQmlCYmlWelQvZlBs?=
 =?utf-8?B?NDZscldRVEtXRU4wb3pFQnNNZ01kcDZ2WFRCcGxGWkg0R28zVnh6UGMxU25p?=
 =?utf-8?B?dWxrV3ltejg3OGVwSHRPbStua29NRUNDRjVBYWo5b1Y2YWYxYVNlSjdOd3Zv?=
 =?utf-8?B?RXlaLzBKNlB4aXhwZmJua09pcktZK2NqK09ZRVFZUklTWXhlUWY0ZU5kMXdn?=
 =?utf-8?B?YldhRWFnaWtrUXFIeFZwcjdNYUV3Q0pFWHlxeXdsV0ZKamxUMlhQWWVia3NC?=
 =?utf-8?B?VFJqS2daaUY2K05GbVc5YStYMjJNTjV4cThkakhOOGt4clJVT0k2YnBkTVl0?=
 =?utf-8?B?bkFESDFncFR0MEdYbjRDU1ZhTjc3dmlFT3JTNlpDcHVTdDlnY1hKMDVETnlj?=
 =?utf-8?B?SUVWZlh1dWdHaFRDUW5nZ21WQXRvbVRuSXVGMkIvVmdIQndMamFWVkUwajJh?=
 =?utf-8?B?OU1QZ25kcVJUZnlnaXVVQ056clRZbFNCaFdpUGdaWk92NjZGOE1QQ3BiQlph?=
 =?utf-8?B?Q2MwR3dIRnpIdDNjOHN3Q1JrQWNBZzh5YTlEWU9QS1kzRHJoQ2FrNHhOSzNL?=
 =?utf-8?B?d3VLR3RlS0VIcTZhbitkNlR4Z2dRQW9mWXh4aWl5N0ZBc0p4UUxndDR0VVhH?=
 =?utf-8?B?L3hEM0l4ZEE4a0pQSmd2cVcxQkovVS9CaElHbXkwZ1RiY2ZqdVRON0V0YUo4?=
 =?utf-8?B?dGlYYXlPWWtuMmlUTVhWWU9pMTZLdFVYbzBMMmVoZ29yY3VJTkNUUWhXN3k2?=
 =?utf-8?B?QnlGZ25pQXhRUS81d21NaG9DNXFLWFBXMC92d2NicFdYUXNlWjY3Njh0Ykhq?=
 =?utf-8?B?Qmk1eGhla2E4eEdXRUpHKyswNXpzS1B4djRzcmVSdEY5MUNoT281OGd1LzQz?=
 =?utf-8?B?N3JMVlZjd2JNcmg3Ry9NaTRCOTRxZGVhOEJka1hJSTBrNXJweEh4cjhaN1h0?=
 =?utf-8?B?Wmx0UVppZXI2MmRHRjhiMkNwTnhaRlh3OHNvUnlaUzIveWxRY0xzam5NMFhO?=
 =?utf-8?B?MkhwQ1VmK1RxRTRydEVQNnQrRjk2S2dJRU9hSGR6eWh3eXhyYzhFUGpmYmJV?=
 =?utf-8?B?UUpCamgybGlZT2VHd25NSE5KQmhKS1pjcXZERDluYjQzQ1hZTDNDUzFXTThz?=
 =?utf-8?B?cWNZMUN3TUl5TU5ZdDJUSXJ5cDA5NGFXdmUva3BDVEFCSGt0S2g0SllWT1V4?=
 =?utf-8?B?RmgvdzEvMWdEdDNWOTlJZENQZlFIaVdnY3ZVTml2MXpTU2Z3Y0g4dmwzM2hj?=
 =?utf-8?B?cnJMTTBZaWdYK3JIdjFFenN0OGYxMEh3YkJrZGYvVlQ0T3ZuVlBSL0Y5MDl3?=
 =?utf-8?B?dmhvUnp3UC9JdzFXZHg3VDY4eGJEREhjTk9mbEFjMFFiUE5UWnhEalczeElK?=
 =?utf-8?B?cW44bS9LSnRVaGZCeG4rQmdXbFdFQ1c1emhmRmpuUGEwR0NrZVI5cGZkeFdE?=
 =?utf-8?B?blhNc3ZnenlSSFRySDRGR0lya0tlZEJvL2ZienVHbytXSkZqWllVQmcyOElP?=
 =?utf-8?B?MHYzeklvRHBWZk5iL3VHQy9ESnZOdFpFRkJJYldkRjhBT1F0d1RqcEYwRGlZ?=
 =?utf-8?B?Vjh1Ri96VUNyL2tZNTFGeTRLUGFxLzhKV3dBQ1RzaWxMckhPc0dJc3U1VjJH?=
 =?utf-8?B?MEVzWkw1ZzdXc0hzL3RjZnZ3bnZxcXZHZWNJTVJPZURWWUs3akJ0b09wMlNl?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b15df98e-151c-4983-238e-08dcb61a5946
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:19:06.4007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DiS7EnTftGQT0z8Pu7ivW1N24dScqv5XBurWXJHawYeD3YJStbxdQKY+KaC7rwxfKJfkaysdcCzu5gS9dTZhamECqGHHJ65e5pCjEDyWCa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9008
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

Hi Simon,

On 7/21/24 5:25 PM, Simon Glass wrote:
> This function has a number of unnecessary #ifdefs so remove them.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
> (no changes since v1)
> 
>   common/spl/spl.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 6f4a8bfb3f4..02567e766f1 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -308,8 +308,10 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   		ret = spl_parse_legacy_header(spl_image, header);
>   		if (ret)
>   			return ret;
> -	} else {
> -#ifdef CONFIG_SPL_PANIC_ON_RAW_IMAGE
> +		return 0;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_SPL_PANIC_ON_RAW_IMAGE)) {
>   		/*
>   		 * CONFIG_SPL_PANIC_ON_RAW_IMAGE is defined when the
>   		 * code which loads images in SPL cannot guarantee that
> @@ -319,10 +321,9 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   		 * is bad, and thus should be skipped silently.
>   		 */
>   		panic("** no mkimage signature but raw image not supported");
> -#endif
> +	}
>   
> -#if CONFIG_IS_ENABLED(OS_BOOT)
> -#if defined(CONFIG_CMD_BOOTI)
> +	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {

Ah, I see. Done in this commit :) Ignore comment on patch 2 then :)

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
