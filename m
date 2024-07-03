Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6168FC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 04:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2CB887DB;
	Wed,  3 Jul 2024 06:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="GDWDLWKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52E8D88738; Wed,  3 Jul 2024 04:07:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::70d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C461887BA
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 04:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFK7hliXEYgSBX3HQ8qabKuCmDWgcoxEuNHIiqHfOPsCf85lMEGPPp4sb5/finGhf0NXj3akUkefSgEda3Pj/j+irnAvw/YePqRQdaIqCP+LVFcd59t8SLHz46jjp7kLhmTPtIEiXz4PsUzgwjbkwmPdmKwwIIDCMOG2JBUqALpT9BvNtnmpKcw3wgWqqy9KVTFa1HdpJziyn51GhfjpU8tlDRvyp1tbPIEx57nHFF6MBzLE7a+yYUzj5+PXzwDqehzuglB62QoJ32UHP1dvNCOxyrj4+unSNvkdkSvA9cJRdik441Ur8t57CR9J0mSuFtSC2z61QCutxvj7Wed5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6rWuMJrcejCfmHG+s3L2+amVb0Bfo3duD7QRz+piR4=;
 b=P+1NT8ceRrUGJp7+v5XCTX509v4k0PWW2bkkWASzDSZk/Udgj4+Xa+R6kH+TflBU9Kae03eWcAxSi2idatGA+LeuDPrvOFO7eq8pYMCDwCIYIVJxvgVtJrJvW608227Feow8+whPkQS+5x13a/64/wqHh8MfEN13+O7DvKAH85wN+gLo3jcwwVScylAaOGh1Qq7v/zpI3RvtHDlluKveHNpkYB7qGwX3SScMTXp/amlu+JJk1LZCANYGjXekkYesnNKmk5BBmmdSwOVOiTk8r6xgWzIH6+5aKPTsbc3W+7gLyVif4tw6oBhWV8l71bKIdmxKtYT9Kx4phgVX37ga1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6rWuMJrcejCfmHG+s3L2+amVb0Bfo3duD7QRz+piR4=;
 b=GDWDLWKk6Ep2+uyXVLq3bO0gUgIdyclfQRgttX83R1xZdsNNgENfEq89CmFpLaMYICwVbBLOlHLH9D6CgvibynCDRFQ5dik4YIJjDsK7DfeU9ZuiFCkfFOTBUEuCh4JW50bHwEKTIxB6+A3KVwZX+tJvzv8611TrRYW3EV+CawQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7450.eurprd08.prod.outlook.com (2603:10a6:20b:4de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 02:06:58 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 02:06:57 +0000
Message-ID: <9228e420-86fb-45e8-baf7-8e19e9b0cbe6@genexis.eu>
Date: Wed, 3 Jul 2024 06:06:52 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] net/httpd: add httpd common code
To: Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
References: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
 <20240627113939.100620-8-mikhail.kshevetskiy@iopsys.eu>
 <CALeDE9NZFy_XFaWj=LOFw6BvqhcC=hs8QCwKg3VRfbCzcJFZkQ@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CALeDE9NZFy_XFaWj=LOFw6BvqhcC=hs8QCwKg3VRfbCzcJFZkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0477.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8e003d-4ee8-44c1-cc91-08dc9b04d117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWV5Q2huWXlNTW9GRi92cTFXR3ZSRmE5QXUwMlRQVTE4OW5IcVpGNzIxdjN3?=
 =?utf-8?B?Y2FjTS9tYkxpUzhpai9KMnViZUFBRi9nc0VYNjVqemIxVHBVazRsaUREbUZS?=
 =?utf-8?B?Rytubms0dXNyMkdjSkZSdlJrZ3VybHVOQ0RISnlySFBTTE1VcVVoQ2NpbHp2?=
 =?utf-8?B?RnVITk5UNVd3blNYQnl4L2piNWFLWmdJTnM1MXE0UjErSHpNYVhJQVJiZVY0?=
 =?utf-8?B?ZWZyM2t3eU95S0piaWlpMm1FQVI4WlZJYmhDSWFMakNqU2g5c2pZOGRsMSt3?=
 =?utf-8?B?ZHZ1YlRiQnU3dU9TcisxWVJNSy9JU2tjK1N5cTBIY2JSNlJvdHlEN2RjVXBX?=
 =?utf-8?B?dW1vaXpTeS85aTRXWEJERFR6cW1UdXRJMjZ6cnRCbFRSTVZBcGpiRUFJT1dm?=
 =?utf-8?B?eTVwajROb3FuMXdpTjV1MnlISERLWVc4amFlNXQvdU5VRGxMS1BZOU9FVDRi?=
 =?utf-8?B?VllWZWtiWVo4aWF4VjdhUVRVckhnMHd1NzNPYXFvUVNDTzRaaklkYnNzcGlT?=
 =?utf-8?B?WDd4MXVmU3Rsa2VsUWxQazUzRjdhVUhsVVNwdGdFSWhwVkVEUGhEdW1uTllE?=
 =?utf-8?B?bFpLbzJxVlFReEVhOXNxbkVwS1kxY0dCbnBRcWhNdkdHUUJJemdOOUQ5S2dF?=
 =?utf-8?B?OTVYbnk5T1J0am4wVzU3QTlkenp4UWMzZ0FZS2FaNStXMmJDRW9EdlRucCt2?=
 =?utf-8?B?VEhzb2FwNkk0TU00clRQMmdjeGRkWWJxNDQ0WFM0dmtVMWhmak5KQlRUUHBw?=
 =?utf-8?B?TlAvOXloNDh4RHQ2YlJyR1hRR0dKcFlGK2MvTmM5c1hwVlpQeW9xNE5kQ1dC?=
 =?utf-8?B?bWZqb3RrZHRIdktYYS9rUFZzQmpRd0c5d2xYZ2hHRUdpc2hpdWV4VDR0Z3Fu?=
 =?utf-8?B?Y21MUGVNOXo4MlBUWXBmU2NMcGV6eUthZlhnaFlQZjNVYjBDSVZSZm1nOWdr?=
 =?utf-8?B?ZitaSWFJYVNidHpUZnkzeG5YbWRwRURSQS91MWt1dVVQNzFUek1rL3lGYzVu?=
 =?utf-8?B?MkVwTHZuQjFjQjdYYXdMNi9yNXhMVXR1Sk5HNWYwQkk0aFlHc2I3R09TdWsx?=
 =?utf-8?B?SlVmdnd2RnNhTTR5Q2cvK2w5bi9QR20yVFZaY1NXWE0zU0ZJRVl1US91aVNx?=
 =?utf-8?B?U1IxUzVQaHQ3RHVMdFNOSU9JeDQ1UzBDdnMxRFFpNEl3eTZjYlV0dnMvcThM?=
 =?utf-8?B?blRNc0hIYzJXc3doUTlVbTM4VlhpWE1iZ2JsUnhYY3NZTGlERUgrMjk5Y2tY?=
 =?utf-8?B?OUlURWg0eEZyVWFmSUMwbFJMRDFqdi96WTRHdUl6cEc4YzRvS3RYdjg2VFJQ?=
 =?utf-8?B?WUlZRExWWWt1WmJQdXFWWDVrZDdvKyt0YzUvNnU1YzI2bDFVWUVrNzdzQjFh?=
 =?utf-8?B?azJMQ1Z5dnlBeU51ZVY3SWhIWGx4Y2tEbjhkMlhpeHhFOEplcVBRcUxoa1hG?=
 =?utf-8?B?T2RZenhIUzBxKzNxTzBRQ0hwRDhBNVEzL3ZmVTkwWkRkWlU0TUtBb0k1V0pj?=
 =?utf-8?B?UTcxZ3NpVkVObnNKSjNPN1E4VWl2QUZQbGp6d1N5MzFWSUluMnk4K2Eyd1hG?=
 =?utf-8?B?cGRCUXZYdGRFdHNWUjJTZUV1anM2b3VDMjlXTEFRUXZDUVBIWHYwWktKVnJN?=
 =?utf-8?B?VFJlMXgrRkFENzNKZjg3U0Q4K1RhNW1HZ05YdXRGY1loK1FRS2JsdXNPbFBh?=
 =?utf-8?B?UitCVVlGcjZRU0pkRXdONmtmMmEyeGxvd0R4bEZsam1iSUw1U0VFT2JOTUdN?=
 =?utf-8?Q?DT+/vltGsGyorNxww4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzF6ZW1JYmNTZTNqWUVZR3FJQlh2bUZCeEcwQzVNRlF4ZGY5eDdlcVNiSExO?=
 =?utf-8?B?RFRsYWYza201TmdZUzRTay9temsvTFdhV1g4aXRPUUFEVkxhblRncmx5blpx?=
 =?utf-8?B?WDdaTnVzTitORG1ITmE4aklwRW0zWWFuem12WFNETU0vR1RtNFZncWtmWnZ5?=
 =?utf-8?B?bUowMkxDQURIRGNLMDVLbUhlZkxubXNjeFJCem9TVnA5T1pxcjFvb25UaUpy?=
 =?utf-8?B?SWlmTERFR0l4cXlGczk2QUFSSFc2bndRemdUV2FVYktzT3B2Z0VLcDJEZzZM?=
 =?utf-8?B?bjR1WmRrVWtVRnBiYVZrdEdDRVBQWTM1TGpsWmM3L25KWDFwVjV5YU1neTZy?=
 =?utf-8?B?Ry9xOXVybktJNjFiQ09HR3dBeEhid3VYSnNOTXJXa2pUMzBpZFB4VWg4S2d1?=
 =?utf-8?B?QkU4bTE4SHlLQ3dQUWZ0eUVzMGVnTWMzaUhXOXFva2VqRnh1SFJxQ3NyZ1NN?=
 =?utf-8?B?TFRzYmd1UjV3MkRwcDNMa2szU2NHUnppTGtHb2oxV2ZPV2JkNTFhVFJaTERx?=
 =?utf-8?B?S1FPZ245RXRZajE1TXNNRW1VdEdzOUloMzQ2djZTVGE0ZFZwMHFjZWh4K3Ey?=
 =?utf-8?B?N1VNSWVwejJUc1oyeW5EUExCSFNod2RnVE5KTE1QenkrSDZsRldWL1AzcFNU?=
 =?utf-8?B?Z05IbzZjSW9FdUkxUEw5NGhod2h1dytTSmxRWUM5RGUxbGNUdittRmsxeFdR?=
 =?utf-8?B?R1N1VkFHVnI0dXlLZDh1bWhRdXptK0FvcnVsdk1pWHRhQ2w0VFdacS9QSUNP?=
 =?utf-8?B?ZmtjUnl4bEJZcUVnZGhFNVNrYTh6dFZXZ0RnTnNHN1V3emFJQ1pBcEtiT0RE?=
 =?utf-8?B?bXlkZ0JHYlRpTmhZaDZxSnRWajZCSVZjMCswUG9sTkQwZzNSL3NGNXQ1eFFJ?=
 =?utf-8?B?d2dQM2wrYzQ0TWJlMFQ5bFlLR0J4N2dodUhMTXVJUVF6cGJJb3FteE5qWnpu?=
 =?utf-8?B?dzdaUlEybU5WSVA3VXpyTHd5OVY1bmZVR04rQzFCVDB6RHZNdnBpaG12cG1V?=
 =?utf-8?B?ZGwvdFZIOTRXUHVQOVVCUHhZTEEzenNidjNhL0RrL2tXV2tHQUpLR1piTjNm?=
 =?utf-8?B?bEsrZGV1NXQ5ZnNYWEU5VndPTExMZ0FVS0tqblJ6cmxHMXVBWUZTOW01R2FF?=
 =?utf-8?B?UlJ6RzBTZGFDZWtGRnd0aUZ5ek9DVVFoZU5WVFRIZ2IyQzdWNlVLRStKSVBP?=
 =?utf-8?B?b2tFNDNHaGRrYUxOb1dzY2JSUjhBWGYzQ3BueElPT2FGRXpJSXRySGVKUWlj?=
 =?utf-8?B?bjg3TnBnU3RuWDFVOWxBZlhPUFBnbExsREdmb1FwS3VkdDVXNndORi9Td1lK?=
 =?utf-8?B?NXJSeld0ZVVwcXk5UEx6aTBCMjNPTzdLYUMrN1hYSzVSZnJybjRjdVMyV2xo?=
 =?utf-8?B?d1Rrc1c4VUtSbGYzUUZNa0gvcDdQcUhaWTRYSm4xMWhvcVNXRnVFTXBzTGdk?=
 =?utf-8?B?cW5aSjZURjRVUGFwSWZhUmhhQW5TTGdBSStTMDdoNFk2S0dJNjVQN1FjTUtI?=
 =?utf-8?B?ZFhZUTZqQ0JRQmhlUlJFUys0QXN6b0lZeitRdVlOWk9OWnpjOWo5UUxFOGhr?=
 =?utf-8?B?WFJNNHFCRWd6RURIUndNWSt3dHc0Z3RFRFZ3WWdpalVUZ3JFczRDYkVWdW5X?=
 =?utf-8?B?OEFzVFZZSkt2OXdEbW1ZT0gvSld3UkM2UnQzaWhvZnR6aEZ3YU9GZURBSFFp?=
 =?utf-8?B?MlowQXViRnVOMXlYdzZSZnFkR3BWQ1FoYW5YbTN2bkM1YU1SNWhjRGJoVGdP?=
 =?utf-8?B?NStTTHd2QVJkUml4UzdFSzR6VDNPRlM2Q2NtQkFKVzdXZkdjOE9JNnFHeVZ2?=
 =?utf-8?B?a2FOcHRWNWRhR2VpUzVvdU5YSzBGN1dUTmw5MHdaejRzVjZpOTJtS1RVZHA2?=
 =?utf-8?B?UEwzUVdreWZVT3dycFFiZjRlUW5uOUNCOUU3WW5oWFVycFVQWllYU1lOYzB3?=
 =?utf-8?B?aHV1Rkg2YXJkbE80Ni9XaUJBbG9BdTE3NVFJVi9WY3pRTmNib0NrdHoxbnRH?=
 =?utf-8?B?RDl6VlFFcCtJVVRHd0ZKMVVBUWQxaUpRMnpmbzdsQUdKMWkrWWx4NEU0cjRC?=
 =?utf-8?B?L2I2ZWVRMDBGN1lGR0Y0OUhsUURQUHJXK2Y2dFkxaEZHajNRNDN5YWk2VjVJ?=
 =?utf-8?B?clhKODFMbG1HVjN0V1hMQTVCemJxRitPQUlOZUovS2dtVmdqcGNYMGRkOE1J?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8e003d-4ee8-44c1-cc91-08dc9b04d117
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 02:06:57.2001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HFPQMzpy9/8DS99XLiScChEAQPpLmbmeVgIG7NpxSbTz5+Hag5OjeyyvhFjMa5PvT4G1XrLbWEniJ4Yi2lEm6DoP2SACstwV5YdL+dlYKQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7450
X-Mailman-Approved-At: Wed, 03 Jul 2024 06:25:51 +0200
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


On 7/1/24 19:54, Peter Robinson wrote:
> Hi Mikhail,
>
>> This patch adds HTTP/1.1 compatible web-server that can be used
>> by other. Server supports GET, POST, and HEAD requests. On client
>> request it will call user specified GET/POST callback. Then results
>> will be transmitted to client.
> Why are we adding a HTTP server? I don't see a cover letter explaining
> overall what you're attempting to achieve with this patch set so
> please add that. Also I suggest you look at the LWIP patch set [1] as
> that may make what you wish to achieve more straight forward.
>
> Peter
>
> [1] https://lists.denx.de/pipermail/u-boot/2024-June/556526.html

This patch series consist of
* TCP fixes. Current U-Boot implementation of TCP is bad. It is
especially bad for uploading. This patch series fixes TCP support. I
know about attempts to add LWIP to u-Boot, but it's not in U-Boot yet.

* Rewrite of existing TCP clients (wget, fastboot_tcp)  on the base of
new code

* netcat client/server. It was written to test data downloading and
uploading using TCP.

* HTTPD support. It consist of 2 parts: common code and sample
web-server. Sample web-server can be used as a reference httpd
implementation. We use this HTTPD support for our firmware upgrade
web-server. It is similar to the sample web-server.

PS: Will resend patches with a cover letter tomorrow.

>> The following restrictions exist on the POST request
>> at the moment:
>>   * only multipart/form-data with a single file object
>>   * object will be stored to a memory area specified in
>>     image_load_addr variable
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  include/net.h       |   2 +-
>>  include/net/httpd.h |  64 ++++
>>  net/Kconfig         |  14 +
>>  net/Makefile        |   1 +
>>  net/httpd.c         | 695 ++++++++++++++++++++++++++++++++++++++++++++
>>  net/net.c           |   6 +
>>  6 files changed, 781 insertions(+), 1 deletion(-)
>>  create mode 100644 include/net/httpd.h
>>  create mode 100644 net/httpd.c
>>
>> diff --git a/include/net.h b/include/net.h
>> index 235396a171b..6debbf8ed2a 100644
>> --- a/include/net.h
>> +++ b/include/net.h
>> @@ -516,7 +516,7 @@ extern int          net_restart_wrap;       /* Tried all network devices */
>>  enum proto_t {
>>         BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
>> -       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, RS
>> +       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_STORE, HTTPD, RS
>>  };
>>
>>  extern char    net_boot_file_name[1024];/* Boot File name */
>> diff --git a/include/net/httpd.h b/include/net/httpd.h
>> new file mode 100644
>> index 00000000000..ff0dc93ecf5
>> --- /dev/null
>> +++ b/include/net/httpd.h
>> @@ -0,0 +1,64 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * httpd support header file
>> + * Copyright (C) 2024 IOPSYS Software Solutions AB
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + *
>> + */
>> +#ifndef __NET_HTTPD_COMMON_H__
>> +#define __NET_HTTPD_COMMON_H__
>> +
>> +struct http_reply {
>> +       int             code;
>> +       const char      *code_msg;
>> +       const char      *data_type;
>> +       void            *data;
>> +       u32             len;
>> +};
>> +
>> +struct httpd_post_data {
>> +       const char      *name;
>> +       const char      *filename;
>> +       void            *addr;
>> +       u32             size;
>> +};
>> +
>> +enum httpd_req_check {
>> +       HTTPD_REQ_OK,
>> +       HTTPD_BAD_URL,
>> +       HTTPD_BAD_REQ,
>> +       HTTPD_CLNT_RST
>> +};
>> +
>> +struct httpd_config {
>> +       enum net_loop_state     (*on_stop)(void);
>> +       void                    (*on_req_end)(void *req_id);
>> +
>> +       enum httpd_req_check    (*pre_get)(void *req_id, const char *url);
>> +       enum httpd_req_check    (*pre_post)(void *req_id, const char *url,
>> +                                           struct httpd_post_data *post);
>> +
>> +       struct http_reply *     (*get)(void *req_id, const char *url);
>> +       struct http_reply *     (*post)(void *req_id, const char *url,
>> +                                       struct httpd_post_data *post);
>> +
>> +       struct http_reply       *error_400;
>> +       struct http_reply       *error_404;
>> +};
>> +
>> +/**
>> + * httpd_setup() - configure the webserver
>> + */
>> +void httpd_setup(struct httpd_config *config);
>> +
>> +/**
>> + * httpd_stop() - start stopping of the webserver
>> + */
>> +void httpd_stop(void);
>> +
>> +/**
>> + * httpd_start() - start the webserver
>> + */
>> +void httpd_start(void);
>> +
>> +#endif /* __NET_HTTPD_COMMON_H__ */
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 5dff6336293..424c5f0dae8 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -243,6 +243,20 @@ config PROT_TCP_SACK
>>           This option should be turn on if you want to achieve the fastest
>>           file transfer possible.
>>
>> +config HTTPD_COMMON
>> +       bool "HTTP server common code"
>> +       depends on PROT_TCP
>> +       help
>> +         HTTP/1.1 compatible web-server common code. It supports standard
>> +         GET/POST requests. User MUST provide a configuration to the
>> +         web-server. On client request web-server will call user specified
>> +         GET/POST callback. Then results will be transmitted to the client.
>> +         The following restricions on the POST request are present at the
>> +         moment:
>> +           * only mulipart/form-data with a single binary object
>> +           * object will be stored to a memory area specified in
>> +             image_load_addr variable
>> +
>>  config IPV6
>>         bool "IPv6 support"
>>         help
>> diff --git a/net/Makefile b/net/Makefile
>> index dac7b4859fb..c1f491fad02 100644
>> --- a/net/Makefile
>> +++ b/net/Makefile
>> @@ -34,6 +34,7 @@ obj-$(CONFIG_PROT_UDP) += udp.o
>>  obj-$(CONFIG_PROT_TCP) += tcp.o
>>  obj-$(CONFIG_CMD_WGET) += wget.o
>>  obj-$(CONFIG_CMD_NETCAT) += netcat.o
>> +obj-$(CONFIG_HTTPD_COMMON) += httpd.o
>>
>>  # Disable this warning as it is triggered by:
>>  # sprintf(buf, index ? "foo%d" : "foo", index)
>> diff --git a/net/httpd.c b/net/httpd.c
>> new file mode 100644
>> index 00000000000..31c10843a44
>> --- /dev/null
>> +++ b/net/httpd.c
>> @@ -0,0 +1,695 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * httpd support driver
>> + * Copyright (C) 2024 IOPSYS Software Solutions AB
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + */
>> +
>> +#include <command.h>
>> +#include <version.h>
>> +#include <display_options.h>
>> +#include <env.h>
>> +#include <image.h>
>> +#include <mapmem.h>
>> +#include <malloc.h>
>> +#include <net.h>
>> +#include <net/tcp.h>
>> +#include <net/httpd.h>
>> +
>> +#define HTTP_PORT              80
>> +
>> +#define MAX_URL_LEN            128
>> +#define MAX_BOUNDARY_LEN       80
>> +#define MAX_MPART_NAME_LEN     80
>> +#define MAX_FILENAME_LEN       256
>> +#define BUFFER_LEN             2048
>> +
>> +enum http_req_state {
>> +       ST_REQ_LINE = 0,
>> +       ST_REQ_HDR,
>> +       ST_REQ_MPBOUNDARY,
>> +       ST_REQ_MPART,
>> +       ST_REQ_MPFILE,
>> +       ST_REQ_MPEND,
>> +       ST_REQ_DONE,
>> +};
>> +
>> +enum http_reply_state {
>> +       ST_REPLY_ERR = 0,
>> +       ST_REPLY_HDR,
>> +       ST_REPLY_BODY
>> +};
>> +
>> +enum http_method {
>> +       HTTP_UNKNOWN = -1,
>> +       HTTP_GET,
>> +       HTTP_POST,
>> +       HTTP_HEAD,
>> +       HTTP_OPTIONS,
>> +};
>> +
>> +struct httpd_priv {
>> +       enum http_req_state     req_state;
>> +       enum http_reply_state   reply_state;
>> +
>> +       struct tcp_stream       *tcp;
>> +
>> +       enum http_method        method;
>> +       char                    url[MAX_URL_LEN];
>> +       u32                     version_major;
>> +       u32                     version_minor;
>> +       u32                     hdr_len;
>> +
>> +       u32                     post_fstart;
>> +       u32                     post_flen;
>> +       char                    post_fname[MAX_FILENAME_LEN];
>> +       char                    post_name[MAX_MPART_NAME_LEN];
>> +       char                    post_boundary[MAX_BOUNDARY_LEN];
>> +
>> +       int                     reply_code;
>> +       u32                     reply_fstart;
>> +       u32                     reply_flen;
>> +       void                    *reply_fdata;
>> +
>> +       u32                     rx_processed;
>> +       char                    buf[BUFFER_LEN];
>> +};
>> +
>> +static struct http_reply options_reply = {
>> +       .code      = 200,
>> +       .code_msg  = "OK",
>> +       .data_type = "text/plain",
>> +       .data      = NULL,
>> +       .len       = 0
>> +};
>> +
>> +static int stop_server;
>> +static int tsize_num_hash;
>> +
>> +static struct httpd_config *cfg;
>> +
>> +static void show_block_marker(u32 offs, u32 size)
>> +{
>> +       int cnt;
>> +
>> +       if (offs > size)
>> +               offs = size;
>> +
>> +       cnt = offs * 50 / size;
>> +       while (tsize_num_hash < cnt) {
>> +               putc('#');
>> +               tsize_num_hash++;
>> +       }
>> +
>> +       if (cnt == 50)
>> +               putc('\n');
>> +}
>> +
>> +static void tcp_stream_on_closed(struct tcp_stream *tcp)
>> +{
>> +       struct httpd_priv *priv = tcp->priv;
>> +
>> +       if ((priv->req_state != ST_REQ_DONE) &&
>> +           (priv->req_state >= ST_REQ_MPFILE)) {
>> +               printf("\nHTTPD: transfer was terminated\n");
>> +       }
>> +
>> +       if (cfg->on_req_end != NULL)
>> +               cfg->on_req_end(tcp->priv);
>> +
>> +       free(tcp->priv);
>> +
>> +       if (stop_server)
>> +               net_set_state(cfg->on_stop != NULL ?
>> +                             cfg->on_stop() :
>> +                             NETLOOP_SUCCESS);
>> +}
>> +
>> +static void http_make_reply(struct httpd_priv *priv, struct http_reply *reply,
>> +                           int head_only)
>> +{
>> +       int offs = 0;
>> +
>> +       if (priv->version_major >= 1) {
>> +               offs = snprintf(priv->buf, sizeof(priv->buf),
>> +                               "HTTP/%d.%d %d %s\r\n"
>> +                               "Server: %s\r\n"
>> +                               "Connection: close\r\n"
>> +                               "Cache-Control: no-store\r\n"
>> +                               "Content-Type: %s\r\n"
>> +                               "Content-Length: %d\r\n",
>> +                               priv->version_major, priv->version_minor,
>> +                               reply->code, reply->code_msg, U_BOOT_VERSION,
>> +                               reply->data_type,
>> +                               head_only ? 0 : reply->len);
>> +               if (priv->method == HTTP_OPTIONS)
>> +                       offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
>> +                                       "Access-Control-Allow-Methods: GET, HEAD, OPTIONS, POST\r\n");
>> +               offs += snprintf(priv->buf + offs, sizeof(priv->buf) - offs,
>> +                               "\r\n");
>> +       }
>> +
>> +       priv->reply_code = reply->code;
>> +       priv->reply_fstart = offs;
>> +       if (!head_only) {
>> +               priv->reply_flen = reply->len;
>> +               priv->reply_fdata = reply->data;
>> +       }
>> +}
>> +
>> +static enum httpd_req_check http_parse_line(struct httpd_priv *priv, char *line)
>> +{
>> +       char                    *url, *version, *data, *end;
>> +       u32                     len, tmp;
>> +       enum httpd_req_check    ret;
>> +       struct httpd_post_data  post;
>> +
>> +       switch (priv->req_state) {
>> +       case ST_REQ_LINE:
>> +               if (strncasecmp(line, "GET ", 4) == 0) {
>> +                       priv->method = HTTP_GET;
>> +                       url = line + 4;
>> +               } else if (strncasecmp(line, "POST ", 5) == 0) {
>> +                       priv->method = HTTP_POST;
>> +                       url = line + 5;
>> +               } else if (strncasecmp(line, "HEAD ", 5) == 0) {
>> +                       priv->method = HTTP_HEAD;
>> +                       url = line + 5;
>> +               } else if (strncasecmp(line, "OPTIONS ", 8) == 0) {
>> +                       priv->method = HTTP_OPTIONS;
>> +                       url = line + 8;
>> +               } else {
>> +                       /* unknown request */
>> +                       return HTTPD_CLNT_RST;
>> +               }
>> +
>> +               version = strstr(url, " ");
>> +               if (version == NULL) {
>> +                       /* check for HTTP 0.9 */
>> +                       if ((*url != '/') || (priv->method != HTTP_GET))
>> +                               return HTTPD_CLNT_RST;
>> +
>> +                       if (strlen(url) >= MAX_URL_LEN)
>> +                               return HTTPD_CLNT_RST;
>> +
>> +                       if (cfg->pre_get != NULL) {
>> +                               ret = cfg->pre_get(priv, url);
>> +                               if (ret != HTTPD_REQ_OK)
>> +                                       return ret;
>> +                       }
>> +
>> +                       priv->req_state = ST_REQ_DONE;
>> +                       priv->hdr_len = strlen(line) + 2;
>> +                       priv->version_major = 0;
>> +                       priv->version_minor = 9;
>> +                       strcpy(priv->url, url);
>> +                       return HTTPD_REQ_OK;
>> +               }
>> +
>> +               if (strncasecmp(version + 1, "HTTP/", 5) != 0) {
>> +                       /* version is required for HTTP >= 1.0 */
>> +                       return HTTPD_CLNT_RST;
>> +               }
>> +
>> +               *version++ = '\0';
>> +               version += strlen("HTTP/");
>> +
>> +               priv->version_major = dectoul(version, &end);
>> +               switch (*end) {
>> +               case '\0':
>> +                       priv->version_minor = 0;
>> +                       break;
>> +               case '.':
>> +                       priv->version_minor = dectoul(end + 1, &end);
>> +                       if (*end == '\0')
>> +                               break;
>> +                       fallthrough;
>> +               default:
>> +                       /* bad version format */
>> +                       return HTTPD_CLNT_RST;
>> +               }
>> +
>> +               if (priv->version_major < 1) {
>> +                       /* bad version */
>> +                       return HTTPD_CLNT_RST;
>> +               }
>> +
>> +               if ((priv->version_major > 1) || (priv->version_minor > 1)) {
>> +                       /* We support HTTP/1.1 or early standards only */
>> +                       priv->version_major = 1;
>> +                       priv->version_minor = 1;
>> +               }
>> +
>> +               if (*url != '/')
>> +                       return HTTPD_CLNT_RST;
>> +
>> +               if (strlen(url) >= MAX_URL_LEN)
>> +                       return HTTPD_CLNT_RST;
>> +
>> +               priv->req_state = ST_REQ_HDR;
>> +               strcpy(priv->url, url);
>> +               return HTTPD_REQ_OK;
>> +
>> +       case ST_REQ_HDR:
>> +               if (*line == '\0') {
>> +                       priv->hdr_len = priv->rx_processed + 2;
>> +                       switch (priv->method) {
>> +                       case HTTP_GET:
>> +                       case HTTP_HEAD:
>> +                               if (cfg->pre_get != NULL) {
>> +                                       ret = cfg->pre_get(priv, priv->url);
>> +                                       if (ret != HTTPD_REQ_OK)
>> +                                               return ret;
>> +                               }
>> +                               fallthrough;
>> +
>> +                       case HTTP_OPTIONS:
>> +                               priv->req_state = ST_REQ_DONE;
>> +                               return HTTPD_REQ_OK;
>> +
>> +                       default:
>> +                               break;
>> +                       }
>> +
>> +                       if (*priv->post_boundary != '\0') {
>> +                               priv->req_state = ST_REQ_MPBOUNDARY;
>> +                               return HTTPD_REQ_OK;
>> +                       }
>> +                       /* NOT multipart/form-data POST request */
>> +                       return HTTPD_BAD_REQ;
>> +               }
>> +
>> +               if (priv->method != HTTP_POST)
>> +                       return HTTPD_REQ_OK;
>> +
>> +               len = strlen("Content-Length: ");
>> +               if (strncasecmp(line, "Content-Length: ", len) == 0) {
>> +                       data = line + len;
>> +                       priv->post_flen = simple_strtol(data, &end, 10);
>> +                       if (*end != '\0') {
>> +                               /* bad Content-Length string */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +                       return HTTPD_REQ_OK;
>> +               }
>> +
>> +               len = strlen("Content-Type: ");
>> +               if (strncasecmp(line, "Content-Type: ", len) == 0) {
>> +                       data = strstr(line + len, " boundary=");
>> +                       if (data == NULL) {
>> +                               /* expect multipart/form-data format */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +
>> +                       data += strlen(" boundary=");
>> +                       if (strlen(data) >= sizeof(priv->post_boundary)) {
>> +                               /* no space to keep boundary */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +
>> +                       strcpy(priv->post_boundary, data);
>> +                       return HTTPD_REQ_OK;
>> +               }
>> +
>> +               return HTTPD_REQ_OK;
>> +
>> +       case ST_REQ_MPBOUNDARY:
>> +               if (*line == '\0')
>> +                       return HTTPD_REQ_OK;
>> +               if ((line[0] != '-') || (line[1] != '-') ||
>> +                   (strcmp(line + 2, priv->post_boundary) != 0)) {
>> +                       /* expect boundary line */
>> +                       return HTTPD_BAD_REQ;
>> +               }
>> +               priv->req_state = ST_REQ_MPART;
>> +               return HTTPD_REQ_OK;
>> +
>> +       case ST_REQ_MPART:
>> +               if (*line == '\0') {
>> +                       if (*priv->post_name == '\0')
>> +                               return HTTPD_BAD_REQ;
>> +
>> +                       priv->post_fstart = priv->rx_processed + 2;
>> +                       priv->post_flen -= priv->post_fstart - priv->hdr_len;
>> +                       /* expect: "\r\n--${boundary}--\r\n", so strlen() + 8 */
>> +                       priv->post_flen -= strlen(priv->post_boundary) + 8;
>> +
>> +                       if (cfg->pre_post != NULL) {
>> +                               post.addr     = NULL;
>> +                               post.name     = priv->post_name;
>> +                               post.filename = priv->post_fname;
>> +                               post.size     = priv->post_flen;
>> +
>> +                               ret = cfg->pre_post(priv, priv->url, &post);
>> +                               if (ret != HTTPD_REQ_OK)
>> +                                       return ret;
>> +                       }
>> +
>> +                       tsize_num_hash = 0;
>> +                       printf("File: %s, %u bytes\n", priv->post_fname, priv->post_flen);
>> +                       printf("Loading: ");
>> +
>> +                       priv->req_state = ST_REQ_MPFILE;
>> +                       return HTTPD_REQ_OK;
>> +               }
>> +
>> +               len = strlen("Content-Disposition: ");
>> +               if (strncasecmp(line, "Content-Disposition: ", len) == 0) {
>> +                       data = strstr(line + len, " name=\"");
>> +                       if (data == NULL) {
>> +                               /* name attribute not found */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +
>> +                       data += strlen(" name=\"");
>> +                       end = strstr(data, "\"");
>> +                       if (end == NULL) {
>> +                               /* bad name attribute format */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +
>> +                       tmp = end - data;
>> +                       if (tmp >= sizeof(priv->post_name)) {
>> +                               /* multipart name is too long */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +                       strncpy(priv->post_name, data, tmp);
>> +                       priv->post_name[tmp] = '\0';
>> +
>> +                       data = strstr(line + len, " filename=\"");
>> +                       if (data == NULL) {
>> +                               /* filename attribute not found */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +
>> +                       data += strlen(" filename=\"");
>> +                       end = strstr(data, "\"");
>> +                       if (end == NULL) {
>> +                               /* bad filename attribute format */
>> +                               return HTTPD_BAD_REQ;
>> +                       }
>> +
>> +                       tmp = end - data;
>> +                       if (tmp >= sizeof(priv->post_fname))
>> +                               tmp = sizeof(priv->post_fname) - 1;
>> +                       strncpy(priv->post_fname, data, tmp);
>> +                       priv->post_fname[tmp] = '\0';
>> +                       return HTTPD_REQ_OK;
>> +               }
>> +
>> +               return HTTPD_REQ_OK;
>> +
>> +       case ST_REQ_MPEND:
>> +               if (*line == '\0')
>> +                       return HTTPD_REQ_OK;
>> +
>> +               len = strlen(priv->post_boundary);
>> +               if ((line[0] != '-') || (line[1] != '-') ||
>> +                   (strncmp(line + 2, priv->post_boundary, len) != 0) ||
>> +                   (line[len + 2] != '-') || (line[len + 3] != '-') ||
>> +                   (line[len + 4] != '\0')) {
>> +                       /* expect final boundary line */
>> +                       return HTTPD_BAD_REQ;
>> +               }
>> +               priv->req_state = ST_REQ_DONE;
>> +               return HTTPD_REQ_OK;
>> +
>> +       default:
>> +               return HTTPD_BAD_REQ;
>> +       }
>> +}
>> +
>> +static enum httpd_req_check http_parse_buf(struct httpd_priv *priv,
>> +                                          char *buf, u32 size)
>> +{
>> +       char                    *eol_pos;
>> +       u32                     len;
>> +       enum httpd_req_check    ret;
>> +
>> +       buf[size] = '\0';
>> +       while (size > 0) {
>> +               eol_pos = strstr(buf, "\r\n");
>> +               if (eol_pos == NULL)
>> +                       break;
>> +
>> +               *eol_pos = '\0';
>> +               len = eol_pos + 2 - buf;
>> +
>> +               ret = http_parse_line(priv, buf);
>> +               if (ret != HTTPD_REQ_OK) {
>> +                       /* request processing error */
>> +                       return ret;
>> +               }
>> +
>> +               priv->rx_processed += len;
>> +               buf += len;
>> +               size -= len;
>> +
>> +               if ((priv->req_state == ST_REQ_MPFILE) ||
>> +                   (priv->req_state == ST_REQ_DONE))
>> +                       return HTTPD_REQ_OK;
>> +       }
>> +       /* continue when more data becomes available */
>> +       return HTTPD_REQ_OK;
>> +}
>> +
>> +static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
>> +{
>> +       struct httpd_priv       *priv;
>> +       void                    *ptr;
>> +       u32                     shift, size;
>> +       enum httpd_req_check    ret;
>> +       struct http_reply       *reply;
>> +       struct httpd_post_data  post;
>> +
>> +       priv = tcp->priv;
>> +
>> +       switch (priv->req_state) {
>> +       case ST_REQ_DONE:
>> +               return;
>> +
>> +       case ST_REQ_MPFILE:
>> +               show_block_marker(rx_bytes - priv->post_fstart,
>> +                                 priv->post_flen);
>> +               if (rx_bytes < priv->post_fstart + priv->post_flen) {
>> +                       priv->rx_processed = rx_bytes;
>> +                       return;
>> +               }
>> +               priv->req_state = ST_REQ_MPEND;
>> +               priv->rx_processed = priv->post_fstart + priv->post_flen;
>> +               fallthrough;
>> +
>> +       case ST_REQ_MPEND:
>> +               shift = priv->rx_processed - priv->post_fstart;
>> +               ptr = map_sysmem(image_load_addr + shift,
>> +                                rx_bytes - priv->rx_processed);
>> +               ret = http_parse_buf(priv, ptr,
>> +                                    rx_bytes - priv->rx_processed);
>> +               unmap_sysmem(ptr);
>> +
>> +               if (ret != HTTPD_REQ_OK)
>> +                       goto error;
>> +               if (priv->req_state != ST_REQ_DONE)
>> +                       return;
>> +               break;
>> +
>> +       default:
>> +               ret = http_parse_buf(priv, priv->buf + priv->rx_processed,
>> +                                    rx_bytes - priv->rx_processed);
>> +               if (ret != HTTPD_REQ_OK)
>> +                       goto error;
>> +
>> +               if (priv->req_state == ST_REQ_MPFILE) {
>> +                       /*
>> +                        * We just switched from parsing of HTTP request
>> +                        * headers to binary data reading. Our tcp->rx
>> +                        * handler may put some binary data to priv->buf.
>> +                        * It's time to copy these data to a proper place.
>> +                        * It's required to copy whole buffer data starting
>> +                        * from priv->rx_processed position. Otherwise we
>> +                        * may miss data placed after the first hole.
>> +                        */
>> +                       size = sizeof(priv->buf) - priv->rx_processed;
>> +                       if (size > 0) {
>> +                               ptr = map_sysmem(image_load_addr, size);
>> +                               memcpy(ptr, priv->buf + priv->rx_processed, size);
>> +                               unmap_sysmem(ptr);
>> +                       }
>> +
>> +                       show_block_marker(rx_bytes - priv->post_fstart,
>> +                                         priv->post_flen);
>> +               }
>> +
>> +               if (priv->req_state != ST_REQ_DONE)
>> +                       return;
>> +               break;
>> +       }
>> +
>> +       switch (priv->method) {
>> +       case HTTP_OPTIONS:
>> +               reply = &options_reply;
>> +               break;
>> +
>> +       case HTTP_GET:
>> +       case HTTP_HEAD:
>> +               if (cfg->get == NULL) {
>> +                       ret = HTTPD_BAD_REQ;
>> +                       goto error;
>> +               }
>> +               reply = cfg->get(priv, priv->url);
>> +               break;
>> +
>> +       case HTTP_POST:
>> +               if (cfg->post == NULL) {
>> +                       ret = HTTPD_BAD_REQ;
>> +                       goto error;
>> +               }
>> +               post.name     = priv->post_name;
>> +               post.filename = priv->post_fname;
>> +               post.size     = priv->post_flen;
>> +               post.addr     = map_sysmem(image_load_addr, post.size);
>> +               reply = cfg->post(priv, priv->url, &post);
>> +               unmap_sysmem(post.addr);
>> +               break;
>> +
>> +       default:
>> +               ret = HTTPD_BAD_REQ;
>> +               goto error;
>> +       }
>> +
>> +       http_make_reply(priv, reply, priv->method == HTTP_HEAD);
>> +       return;
>> +
>> +error:
>> +       priv->req_state = ST_REQ_DONE;
>> +       switch (ret) {
>> +       case HTTPD_BAD_URL:
>> +               http_make_reply(priv, cfg->error_404, 0);
>> +               break;
>> +       case HTTPD_BAD_REQ:
>> +               http_make_reply(priv, cfg->error_400, 0);
>> +               break;
>> +       default:
>> +               tcp_stream_reset(tcp);
>> +               break;
>> +       }
>> +}
>> +
>> +static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
>> +{
>> +       void                    *ptr;
>> +       struct httpd_priv       *priv;
>> +       u32                     shift;
>> +
>> +       priv = tcp->priv;
>> +       switch (priv->req_state) {
>> +       case ST_REQ_DONE:
>> +               return len;
>> +       case ST_REQ_MPFILE:
>> +       case ST_REQ_MPEND:
>> +               shift = rx_offs - priv->post_fstart;
>> +               ptr = map_sysmem(image_load_addr + shift, len);
>> +               memcpy(ptr, buf, len);
>> +               unmap_sysmem(ptr);
>> +               return len;
>> +       default:
>> +               /*
>> +                * accept data that fits to buffer,
>> +                * reserve space for end of line symbol
>> +                */
>> +               if (rx_offs + len > sizeof(priv->buf) - 1)
>> +                       len = sizeof(priv->buf) - rx_offs - 1;
>> +               memcpy(priv->buf + rx_offs, buf, len);
>> +               return len;
>> +       }
>> +}
>> +
>> +static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
>> +{
>> +       struct httpd_priv *priv;
>> +
>> +       priv = tcp->priv;
>> +       if ((priv->req_state == ST_REQ_DONE) &&
>> +           (tx_bytes == priv->reply_fstart + priv->reply_flen))
>> +               tcp_stream_close(tcp);
>> +}
>> +
>> +static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
>> +{
>> +       struct httpd_priv       *priv;
>> +       u32                     len, bytes = 0;
>> +       char                    *ptr;
>> +
>> +       priv = tcp->priv;
>> +       if (priv->req_state != ST_REQ_DONE)
>> +               return 0;
>> +
>> +       if (tx_offs < priv->reply_fstart) {
>> +               len = maxlen;
>> +               if (len > priv->reply_fstart - tx_offs)
>> +                       len = priv->reply_fstart - tx_offs;
>> +               memcpy(buf, priv->buf + tx_offs, len);
>> +               buf += len;
>> +               tx_offs += len;
>> +               bytes += len;
>> +               maxlen -= len;
>> +       }
>> +
>> +       if (tx_offs >= priv->reply_fstart) {
>> +               if (tx_offs + maxlen > priv->reply_fstart + priv->reply_flen)
>> +                       maxlen = priv->reply_fstart + priv->reply_flen - tx_offs;
>> +               if (maxlen > 0) {
>> +                       ptr = priv->reply_fdata + tx_offs - priv->reply_fstart;
>> +                       memcpy(buf, ptr, maxlen);
>> +                       bytes += maxlen;
>> +               }
>> +       }
>> +
>> +       return bytes;
>> +}
>> +
>> +static int tcp_stream_on_create(struct tcp_stream *tcp)
>> +{
>> +       struct httpd_priv       *priv;
>> +
>> +       if ((cfg == NULL) || stop_server ||
>> +           (tcp->lport != HTTP_PORT))
>> +               return 0;
>> +
>> +       priv = malloc(sizeof(struct httpd_priv));
>> +       if (priv == NULL)
>> +               return 0;
>> +
>> +       memset(priv, 0, sizeof(struct httpd_priv));
>> +       priv->tcp = tcp;
>> +
>> +       tcp->priv = priv;
>> +       tcp->on_closed = tcp_stream_on_closed;
>> +       tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
>> +       tcp->rx = tcp_stream_rx;
>> +       tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
>> +       tcp->tx = tcp_stream_tx;
>> +       return 1;
>> +}
>> +
>> +void httpd_setup(struct httpd_config *config)
>> +{
>> +       cfg = config;
>> +}
>> +
>> +void httpd_stop(void)
>> +{
>> +       stop_server = 1;
>> +}
>> +
>> +void httpd_start(void)
>> +{
>> +       if (cfg == NULL) {
>> +               net_set_state(NETLOOP_FAIL);
>> +               return;
>> +       }
>> +       stop_server = 0;
>> +       memset(net_server_ethaddr, 0, 6);
>> +       tcp_stream_set_on_create_handler(tcp_stream_on_create);
>> +       printf("HTTPD listening on port %d...\n", HTTP_PORT);
>> +}
>> diff --git a/net/net.c b/net/net.c
>> index 809fe5c4792..ca761c57372 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -111,6 +111,7 @@
>>  #include <net/tcp.h>
>>  #include <net/wget.h>
>>  #include <net/netcat.h>
>> +#include <net/httpd.h>
>>  #include "arp.h"
>>  #include "bootp.h"
>>  #include "cdp.h"
>> @@ -575,6 +576,11 @@ restart:
>>                         netcat_store_start();
>>                         break;
>>  #endif
>> +#if defined(CONFIG_HTTPD_COMMON)
>> +               case HTTPD:
>> +                       httpd_start();
>> +                       break;
>> +#endif
>>  #if defined(CONFIG_CMD_CDP)
>>                 case CDP:
>>                         cdp_start();
>> --
>> 2.43.0
>>
