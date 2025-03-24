Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97595C3600C
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 09:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B346781F45;
	Mon, 24 Mar 2025 10:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="f4rfZyq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1885B81F66; Mon, 24 Mar 2025 10:55:45 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7648681EE5
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBFs+Ct0MNsspzvNq/pN2o8q9y3UYGz7glgy0enp4E47V+Zck8eQ5wGSE2CEQgZRczQElqMoXegSb4H5k3Aog8Hni7hJOFN5IF0ZQYkl9R5dnQhBV64BLvwK8oN9dDkBSjxzqfux1x25Wjp2s8+6CdM1GUPVIjoM19aMQg0NPaFKjcVyGC8dM5u25x860iDj9SYOkUKxvC/uMA6pO4VwxKqwM3K4954mAFd7OhzVLcw5stc/aaFUJUeRWYX2LcEA+le9nFvUSRRdaXRX+iXKd8z9ZovoB0Mbb6rGghApCrPPNHmRG2hMsp2ZLoHauEDLJ2BvIgcU1QJwniU6uWwvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMvCMVrQo35kQORRZYUBkXtriC+O5ZBe/b0A40ECAZ8=;
 b=DSE75ftaeWzWS5HVsryi6zTVBN4MjpTcolQMLC1e8b+vSqF002g1rMARZy1qJd6UHhjTqu6WBOAFUynrBGqn/EFRH5BeTZAgkHYz4qceEIgBXwSjiDB8aSIFQVvsm/sdFGEXElJ+XMwS77GK55smv+91hotsA5m5KgDMHodhfx7WcQIAsC4TsbyrZxVHKNuSqZ6SJxxOl9sufltWRPlOeyQn99qxMLpqdLTUdt3IBTfGNpLWoX99NekV4qf6C52qol9HiGkq6gclNRyVRGA+LtBcibLyB6bVe1fdZhepuyiu5BYHxC6rnJBK76iRuzPKj45aMiHstGzFRZJuNRcWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMvCMVrQo35kQORRZYUBkXtriC+O5ZBe/b0A40ECAZ8=;
 b=f4rfZyq+jel9iK7QrLN/PKhqNzD9nRo726B7jHuklXzfdG/NLR2M+rOEAzvhSOBhlME5fP5XuuRgXFiikSDHQimShf64icV7YLEzd86qe6sYrkShsfadYW6Tkfjl4sPJQjFS2GLENH/7o7Y6O2DulqFe8D2axM2/yxVPNrm3yd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8227.eurprd04.prod.outlook.com (2603:10a6:20b:3b4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 09:55:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 09:55:40 +0000
Message-ID: <c45358f6-e84f-4fc6-b5ae-44a3ff5985f1@cherry.de>
Date: Mon, 24 Mar 2025 10:55:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: fuse: add switch for quiet operation
To: Rogerio Guerra Borin <rogerio.borin@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rogerio Guerra Borin <rogerio.borin@toradex.com>
References: <20250317225336.2891974-1-rogerio.borin@toradex.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250317225336.2891974-1-rogerio.borin@toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0155.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d71304-232a-4312-91c3-08dd6aba0909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHVDaE5DeEhYMTFqd01McE1zREhQSzR3YktXUjZkVDM0VklIMEVrbGY0RThJ?=
 =?utf-8?B?a2s0c1cybncxMVJqMDUwanVxSTVlcDBpL3RnZHNjNmlxM1cra2Q2Z2trUlVN?=
 =?utf-8?B?emFqREhiSGU1VnRCMy9iRVdRdkllZWlaRVFhZDJUTUdiYWZ6a2lrSzhXc3FR?=
 =?utf-8?B?ckNnM2dxa2dqakQvVnVCNXRGVFJmVWVaNDYvVzFqZkNZT2laVmZSU1pZUnoz?=
 =?utf-8?B?NmdqWUd2ZDhuaVRDS2xqLzNDK0tiQUUzSXdrSFdVL0h4eHdRSjhCUnE0ZTFl?=
 =?utf-8?B?cjhtdDdEUnl5QlQ1dmkyV0syYjF6T0dMT1RjMVpxajI5czczQUs2OEk4dFBP?=
 =?utf-8?B?bEp5WGp4RHAva1k4WnRXWGN6Z3pvcUdpNHUxQ0g5Tlo5YWlPSDJLT3MvU3JN?=
 =?utf-8?B?Sm04c0loMVZzREV4bzZRU1gveXJzV2QwRzBhVk50eWtqKytYTmd0QVpLcFZz?=
 =?utf-8?B?OEtBQzZzR2FpbWYzZHplV3dGSVhNSFZnK04wUElKV21uYlJUSy8zWW5RMXNm?=
 =?utf-8?B?aFRYY1lnUWpJNU5Oc1NiSlkrc0MwTGlMdk1wZWZmUm10SVpXS1AxRXNaaisy?=
 =?utf-8?B?cEV1akh1eDM3TksvUzlRWDMzM0NSaXBNVG1kd3Z3NDBHUXJBZ2JDb2JBRzhj?=
 =?utf-8?B?SnRja0RKa05jRG5OemNPdE53eTVvU2tpcUIxMW54RWFHNWFXUXp0Wi9mNmNv?=
 =?utf-8?B?Vk81UWsyZm01TjZmcmtpSk1rbXI5ayt3N0pNc09Cbmh2Q2hucWFUdnluTmVD?=
 =?utf-8?B?T3NMejRXT0lDNDJSL0pTMnVuZUdCaEZFM0daMGdrL05OS1hBVFdWMXVoSXVO?=
 =?utf-8?B?Ni9lOWFVNmcxSUwzVjI0SW9rTkFGaTFobkVKTUJHQkFrQzhkdTBmWTVOeVFR?=
 =?utf-8?B?aXNLV3dTL1h3eVBOTy9sUVJNdUY4YVJ4SmN0d2Z1NlRYWFBCYjlrZ3dCMWZJ?=
 =?utf-8?B?K0t6NWJLeDRHSWgxN0tib1A2cGRUUDc5b1J1SVFkUjF1TzJBM0VlM2dld05l?=
 =?utf-8?B?VFVwWitjd253eWg2aDVWa1ZUbEVPR3RLNURYRWpSY3BaV3BJc0RHYjFvdWxE?=
 =?utf-8?B?WmZkamJyOHJ6NUlqRW9zWWhJOFhGMk9UTDFISXJPbXZQV0JVTzdGdkYxMU41?=
 =?utf-8?B?WFdrUGwyTVVrbFFqNUd4OHRLUXNpaDl2Q05KSkl2L3NhUXg2UVVuWUU0Q3ps?=
 =?utf-8?B?bDRiNkNKbnFWNWl5WWtjMFlKVjd0eFhPNno4SjJEOFJMMEErazJJRDFTRVYv?=
 =?utf-8?B?WHJzOVIyRmZRdlRTVFcxL1ZxVFJteUFyU3pvNi9kYWNRb1d1blFyRDJlWWtD?=
 =?utf-8?B?T3YySDVWamticGpicUFSaEpURTJ5aEpvSXh2UWR1ZU5QbVhKbDJjMmlEdkJs?=
 =?utf-8?B?aGhjOTNSK0dzU3BKck1xaW9tTUhxNHN2QUtNa203dW1nMlFXRkQ1L3dMK2Iy?=
 =?utf-8?B?Yk5KZk5sZW0xR0NpbVNNUUw3QkdvQkpyWDlnRVNDT1o5dk9uOHg0MTBxbzJM?=
 =?utf-8?B?ZjNSZUdSTTJybHl2TzRqcnVnREZKeHRDSXZVK2IyOFVFZmRBS0ZKR0Y4bWQx?=
 =?utf-8?B?UE9yYVRHa3RCNVRFNGdzTjZtZ2lwWXJSQ244cnVyQnFOTS9rRUFKWEo4a1RQ?=
 =?utf-8?B?WEIzaU5UQmU5S1FIQVlXUGpqMzJFcVlMOTZuelVocXFIV3ZTbnNlQXVkL3A4?=
 =?utf-8?B?SGZWK2ttRjBtbUlkVDMxTnZOQzdJc3J0UXpKbEhqMXlLM1VxZFM4V3doWkMw?=
 =?utf-8?Q?GxDCEwDJQ6xiImHS3p5k5cwzezOHOPvib3jRHzb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFFwbmtIdlhUcW5tUmpJNk1BdlUxTHJhZWhPT1lBaXl6Zm0ya2RXdzZnS094?=
 =?utf-8?B?WFNwa0ZyZEk2bW1XQlJHUWlSaGlaUTRESzROYTJXZmliZDd2OE04UUs1TlUz?=
 =?utf-8?B?Und0cDZRRktHVXZ6WllwU0FvUmVGQVJ5TVpHeklhUU9jcUQ4WjBVMnFsL1NN?=
 =?utf-8?B?cjZ2Tk9Bc1p5a0hnbVBhR1g2VG1QRThmQzEwMkYvQlJFOEdjRUlkQTRFT3V4?=
 =?utf-8?B?Q2EvYk9GblNhYVo2ZXQxWkZDWVIxbngwUkxTRnlDQm5LTWRpdGZ5S0wvcHRK?=
 =?utf-8?B?WDdoZkNWZnlBVEJWTkFOYStyYnA2OUovVkkyaEJVY0xOWGtJUG1MbWVsbFZW?=
 =?utf-8?B?MlEvalNQclhlOGI4Tko2R3hvUHEvbEhMaGgwaFl2S29WTXNjYmxoVzE3Tkd0?=
 =?utf-8?B?OG9IbzExMk5xeXl0YUdBNk1HWWgrK0Y1eEd1c0FSV3ZWTmsvczlnUVRJRDdy?=
 =?utf-8?B?SERNQWtPcnp4K3JYaUhiYUwwNkpYZjFaVTJmaWZIRTFCMVFaNFJzaWczTEww?=
 =?utf-8?B?OUxWV1k2ZlpteFJOaWZGcm1TcmNFdkxsekNGZ2NIa2YrTHlPRzA1MFZ5ZVZi?=
 =?utf-8?B?ek41cDR4d1RnWlhpUEF3bmVMU0FkZm5ROWV3SUhhNW9QSlpLdEpiOFR4aXMx?=
 =?utf-8?B?eW8zeTROOStZTjY0TnY1cTcreVNnWTltWlRtWHQ5QjZuVVJaeFZNMENuYVRF?=
 =?utf-8?B?cHd5OEowb3RtNTA1NVZIaWVid3BBdTY4Y00vS29PeEZ6SlQ3SHhkQkpMN1Js?=
 =?utf-8?B?R21lTXNSekYzUGZhZDhpYVY0eHVhZEhFcWJKdVlRWW9ZRHlwVU9jV2M2SEVn?=
 =?utf-8?B?bWFMa25Xd3hQTHgrVDlUSXB2bk5zUkY2d0pWN3hwK1YxUkpVQVQ2S0NWZFQx?=
 =?utf-8?B?TlRhbHhXWi9sU0ZVeDlVemw4ZnN4bUlSZ0RJd25NU3JURGZzRGtJaDIzZE5x?=
 =?utf-8?B?SmhtaTBLM2JibWQwSXNhRWFtaGF5MG1xUGtoazllZHlKWUxYZmkyb3dWelg3?=
 =?utf-8?B?MDJVTE1tZFhFTWZyQjIxbCtWc1pwcTFYekN1RzZWN01zUXB6Mkk3S3VQUytk?=
 =?utf-8?B?ZHJzQ3QwNFBlbVhXRFlTZ0lvTEY4ajllMWRDeXBvR0V2SVRTOUl3ZXc5N2RT?=
 =?utf-8?B?YkljUXVRSFBCaDlRQWhMYVZ6Nkx0QzRTT1ZvRml0YVpyK0tMaFFBZ3VQRDcy?=
 =?utf-8?B?U0xCVWpUcHlDVUlmcGMzYXdKMUR0eUpMMjE2cHJYV29pbzhIVXZNNGY5NkpY?=
 =?utf-8?B?Mk90Q3E1OEVyV2pYY09ZajZKQW5lVmpGRlZEZkMvUHRnTHpYd3BJOHhISm8w?=
 =?utf-8?B?b01wMlQwY3lteFBRcVVwNHVUd2t5UzFxUTNlclY5cGZNK0xVWUR0THRFbXpp?=
 =?utf-8?B?QlpadlZFTmpEZ2NuRjRDS29JeHNnRUZRakhHR29IbUpVU0VYeU9oR09XMG81?=
 =?utf-8?B?bW50Vml1b3FEZTJXSTlmWjNDOE83OVd3T2tEckhDbWE2UXBDMHFPWTJoQy9r?=
 =?utf-8?B?ZkNLMFRBNGpQazkwSnpxL2Y1ckJuUW56M2NwUi9mVUFQbW9WWDJNVkxsWEh5?=
 =?utf-8?B?OGJjTDFIUDNVcU9ScFZ0ai9QaS9lZCtFUEM1dHp1Q2greTE0SkRNS1E0WEdM?=
 =?utf-8?B?d1ZsYWhUMUlLdEhmNG9tTkNtK1B6bnh4QS9NQ25tWktPMTVjT29VemhPdit5?=
 =?utf-8?B?YnIvSXRlamlWSmt5ZFJxNExkUXpVZWF5RXMrYkZ4czBaenBtdXpMRElxOGFE?=
 =?utf-8?B?SXNhcnhreGlVcnNqWE4rK3c3ODZRUERybkIxWHViSm5teENXNWhJOE8xYkFU?=
 =?utf-8?B?VC95UnZ3OUYwaWpXb1oveU1FaUcyNnlEVFcxV1h1dXR5U0pDQ0psZCt5UGdk?=
 =?utf-8?B?ZU51MzNnQzFOeUFUK0dmVXRPbmNZOXErVnk4NDdSNWNBOStJMHo3YUkzcldp?=
 =?utf-8?B?V3dlNjNsc2tBcE5KbE56Q0xZbUlmeHlORDVmOUNjT1JJVEUxN2tqQWYxN2Rw?=
 =?utf-8?B?NXI0QUhVd1dVMHZFRDZJbHJEcWNmcVdNeXZOYjllSzhQdVlrRWJOcUMrTUpN?=
 =?utf-8?B?N1hpd0E3ZE5hMHpjTTN4T1J1R0RFbEtzaXNnckxWRko1R2RqNkRCYWpzKzlQ?=
 =?utf-8?B?MUZrbmVSYkxreW96Q2J1MGRkSVpEb0wxWUJ1QkpBNDlUc0Zmcm92Z3lNeXcr?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d71304-232a-4312-91c3-08dd6aba0909
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 09:55:40.6223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/60xfiuICIgLCVtOVsZI0vbhY96HgYPMZGLHxW+rUFStV3weDQAhfodedbQJD/FHhYCGnyXW3uIHpl9/eIUCu6uK7/wnvoeedwYWlZKsM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8227
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

Hi Rogerio,

On 3/17/25 11:53 PM, Rogerio Guerra Borin wrote:
> [You don't often get email from rogerio.borin@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add switch -q for quiet operation to all fuse subcommands. This helps
> avoid bloating the console with messages that can be distracting to
> users (particularly when the command is employed by scripts and multiple
> fuse values are read/compared/programmed). For example, the "fuse cmp"
> command normally produces five lines of output:
> 
>      U-Boot # fuse cmp 6 0 0x70af49db
>      Comparing bank 6:
> 
>      Word 0x00000000:
>      Value 0x70af49db:0x70af49db
>      passed
>      U-Boot # echo $?
>      0
> 
> But scripts issuing the command do not know or care about that output
> since the command exit code is the only relevant information visible to
> them. With the new switch one can avoid the unnecessary output:
> 
>      U-Boot # fuse cmp -q 6 0 0x70af49db
>      U-Boot # echo $?
>      0
> 

I think this is a reasonable expectation. I'm wondering if we shouldn't 
think about using the log architecture we have to have a generic 
solution rather than expecting each command driver to handle (possibly 
in their own way) a quiet flag.

https://docs.u-boot.org/en/latest/develop/logging.html

The idea I have in mind is that we could dynamically set the loglevel 
for a specific command driver (or at least for the command subsystem (by 
e.g. defining an LOG_CATEGORY LOGC_CMD) and use log_* functions in the 
command driver rather than IF_NOT_QUIET() below. This would also allow 
different log levels to be used. Maybe there's something to be done with 
filters, or something new needs to be added to set the log level for a 
category maybe? I don't know, not too verse in our log system.

Another option to have a generic logic would be to depend on an 
environment variable instead of needing to expand each command driver's 
logic.

Cheers,
Quentin
