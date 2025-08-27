Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ABFC8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A17A183192;
	Wed, 27 Aug 2025 09:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="t17m5RiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A2818319C; Wed, 27 Aug 2025 09:43:47 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B08D83189
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5YQ/QdUcYYKxLEOcKENxQjB9ihC6ZlEAh5bYvo9wxPciXbw1iwsoMBMI3AoMOHK02GvSmapKNhbnC8VZASTOlg9kx4ZVWvVuzBbBH1B4Ca7vIryj1IlSo/HP2uoocRRQRj3pEn+fROeEI9KVUjbhtaYkBN4jVsZ/Oc5WUDUozZOJ3xuSwjfvSm1zYiQrK0s1yk1p/TfI3WC3oLSTnJiEkchqJmaO58NskDsPvkYMnVkOB+kojVoGUj/q9bEDobZ+Ei/PfjzVxKjoJx7miiJyA1rz+pLUOWDnngY95oekAs/UP8cSqNQyihcHHtdw7Lns90orne26eo0NQjtS/qgWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5C0c7kDVjhXeJyyHeIeU091XFHJ+XSGq3qnOEg1/6Q=;
 b=Ktn2O6rlkm3OyKIa+pBux2FZ6kZk9kFvwq+xPDil6rMdBCMDOBEObKQNB7rlgWff24w4l6ZLNWwUA7RIP93S4PnI/tGOEg03OAU4S3oVOdto9/EmIeZJr8mJT9P9E96y8UMDoYPgkxCa9g23gIGUe8vkDifG1NeM8yGxmAidby6ShA6EQ6Up4fYRuQs3W73RY81bzIphobExB/sO45a2xBX9FeeJ0e9gasrwlyaqnqFOmJorZfG551I1w/PFxDC+RrGtKweJx0lH95wt/9DIW78r0pOYFbg8ER1EtkfoJ0rr8SpNl9wvcdhz7eaX+AjWVgdK09Kr7z4bIdFSgmmRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5C0c7kDVjhXeJyyHeIeU091XFHJ+XSGq3qnOEg1/6Q=;
 b=t17m5RiGiph/nUxHn0qC8kZWJckzDzVNkX8PCcsZl4lZMbBOm3PpQHhfAoqO+Zd2WHkqkbGNBaQPiaPI8otFyQ0kfVLQE9foq1UQX1DB/30ipBYbHUcOLgZnKBbulBxl1f8wx0QtVJ7Y5lnXrbYW1WGuPaJATHv/qEGRSrVa9qUzjWA+3mC0It849Bydu6v503Yhitj+hpfAdpMegTj+H5Ki1jVPY6oRJYX/TbqU/QuED7/Kh0geJzch9XfpKVxAfzANcqO6U08lU6oPuPWQK+Z78ozCZkLIPUDIP+X9y6g8KwTaOR3z4hMaFAjf03FY6IyRZ7fplBazaX8g5e18Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB9PR10MB7578.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:43:43 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Wed, 27 Aug 2025
 07:43:42 +0000
Message-ID: <e888cd6f-37ad-4f04-b029-1f38c8162da2@kontron.de>
Date: Wed, 27 Aug 2025 09:43:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] power: regulator: lp87565: Cannot test unsigned for
 being negative
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Paul Barker
 <paul@pbarker.dev>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: u-boot@lists.denx.de
References: <20250807-pwr_regulator-v1-0-42a4105336ec@linaro.org>
 <20250807-pwr_regulator-v1-2-42a4105336ec@linaro.org>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250807-pwr_regulator-v1-2-42a4105336ec@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB9PR10MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: cb61b451-0f77-4cf8-9652-08dde53d71d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WjEzMmFuUWNHUklHcTB5VjhNVTN5cmZGS1M3bGhUVm5PSWNLZGFMcG5DL0RD?=
 =?utf-8?B?Q1dNVGIwc2NxZk5UK0tmM3Y2L1c3ZUNpdk9QYWxPNTUyV0dHNFduMUIrM2Jx?=
 =?utf-8?B?YlRGUkFwcWF6WStaYU9CcGlBQlM4T0VnZnpIRTJnNFM0TXFUdmtIcHlzZ1VD?=
 =?utf-8?B?S0xNQmlBMStobDhLbGhpd1NtcEZScmZzdzE4Skp0N0RKY1VycUxOUU1FenUx?=
 =?utf-8?B?ZW1LYkhMQjh5QmdLVkVOeDVId2tRRWtKeHBDR0VXNzMzRzFkc1NGekJLeldT?=
 =?utf-8?B?eklWT1NqRWN2ckM4M0MxRm9pOTBUTllzTnA4bUUwaDJBYjR2dFQ2TWQ5QTR2?=
 =?utf-8?B?cGtHZ3IwT0NtNU50VXJtRHhSWXd0UWY2c0JWUDUweUNrcDdONmVNcENqN2Nr?=
 =?utf-8?B?MS9rWWEzanZKK0xQRGg4MkdWL1VWKzM3Yk9YaFloQkRocnJ1Y1ljUmxjckdP?=
 =?utf-8?B?aGllWno5QXhNV2xQM2VvY1p2cGpXdUxFNVo5MmUzazgzWW13N2t1YzJROU1V?=
 =?utf-8?B?MmlKTWRQb2I4WXhvc0d5elR2aDlmZzFxOHBJRW03OGNnQ2pwKy96UmNmQmJ2?=
 =?utf-8?B?cEVDd21YazdsbUlybFpBMDFEMjdUcEJPUlRGSTRIVXNvemRicXhlTjRUQTRB?=
 =?utf-8?B?N1BOZm5WWFdodWRvVXM3cVhJZ3p0R1dscTVUWDc3SDZTdVE1TURrY1RkTFlX?=
 =?utf-8?B?QWZJNkVCUDFCNFhFZjJZQXA1eUZwcjdEWjh3TTh1MnFNaGFZOFVBMHhEdTF1?=
 =?utf-8?B?YjhqUWk1TlQzeE5nZlIxOEFyYmtwWFVsSTh5OERJQ2FXR0w2S1dydnN1VDlT?=
 =?utf-8?B?RmQ4VThLd00rOEc4NWZKd0NOSkxCMTZEdzI2M0hmRWFLUHo5cEFDc0VIUUxU?=
 =?utf-8?B?ZUhNemFWQnlKbHl1ZHV0NE9RMmJKUW5BT0ZxYkZ1eU44K25TNnhqdlRjUDFp?=
 =?utf-8?B?NkdOZ3U1dlJlK3IxUk9NQWUzc3N2Y0krUFg4UFB3cGxQem5xM3BPTW9RTEho?=
 =?utf-8?B?eFFsWDByRmpOaHJYWmx4WjN3WDhYMjRJTUtzR2crcmRnRWVCOFJtcUNxN1E3?=
 =?utf-8?B?YjlibnpRRkFiaDZPWEtvYy8rRENwTks4OEFFeFJtM2ZiRXlNK0JmTHZzU1pn?=
 =?utf-8?B?ZldDWnNzSUlkSVg5R3plS3pTR2sxeERSd3RYYXVyR0JlRmpyNUEybnVKc01y?=
 =?utf-8?B?d0FJNXhLQXR5OXFuUHJrTTNndW9DK2p5blNZd1Rtb09KU2M3M3YyN0tDUUth?=
 =?utf-8?B?cm9ySExkc1U3Zk54Q3hxZVJrdHRtYThzWVFid3ZnQzhOa245N0ptMXdvdGh0?=
 =?utf-8?B?RGtyd2FUQVlyS2ppZlFhOTl5dTNOY2lCdTdqbnF6ZkY0VHEyRC9kb3FPRDFh?=
 =?utf-8?B?MEsxakkwekZDd0M5WktiSXZBYmV1ajJCbDJwRkU3MlNHM2tWZEdHUHBQbUo5?=
 =?utf-8?B?Mkp2YkJmUUNnUC9iY3lUSndpeVlPSG8xeTlqQkZuK3hQdUNHRTRzRmxUenha?=
 =?utf-8?B?bDNCSHhrallBRkkzcUlhM1RqZXc2VHlsT3dKbWtidkQ0dmxack1IMU1hOEVN?=
 =?utf-8?B?M1c0SDlOek5RR3V6ODU5cEFCdjJZR3dWdEtLZnR5TDhTWVBlOGo3N3dCQXZv?=
 =?utf-8?B?QXErTkdLdW9uVUFteWU3VlJaUlFncTY1cUwvdytsaDR4Kzd6TktjM3ZTWWtj?=
 =?utf-8?B?WWx2WnZXYnVTaEtFemVtS2RSN1ZTRFVzQndNOTdJNlFzZGVET2piOUxpekN0?=
 =?utf-8?B?eGl6L0xKVlhlYS91bksrUWphc2hDd1BBOGxTNURkOWxtODZBei8wcVI0NHlT?=
 =?utf-8?B?R0NDTVhWbktyYUpVbkZrWkI1MlN0c1prTXhBRE4wMndaWHlNVlNxVVJoc0Vs?=
 =?utf-8?B?WU9VbjRKejI1Sk5iSFpSYjYzc0ZRanBVZ1V0dTByYmRlcVFCRUEzeG5MZnA0?=
 =?utf-8?Q?giRk4VdmXq8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STdBMWJiY1J1Uk16ZHF4aytTYk1DcG5McTlrbWw5b2ZqM3U4ekY5RWhGaEtB?=
 =?utf-8?B?cVBTbVVGdHZzNEJXQmJSdjhyMmdzRmxCUWV2cytnVWZheCtkdTA4YzV6NTlB?=
 =?utf-8?B?ZzdHMUdXMXlnQ2RxTWVuZkZHSjYwTnpveVpKSzI0cElLYUxUWUJ1L0QvbTZD?=
 =?utf-8?B?NVZ1dlVFRWgwSWVOVDNaMHRpU2UxNmd6T2MrUUR6Vll1NmFDelJxbFhXdG92?=
 =?utf-8?B?dDNKU2gxZ1dnQklEaUtZd3ZXOFVhbWdwSkxoVjdtRWZNTHgybGc5MDVmVzBE?=
 =?utf-8?B?SDJSdThRTmN2aEhRdkZjL1Z2enJCa2JCWFFJVEl4MDIrYlQrc1JPbUdQQ3p3?=
 =?utf-8?B?MXBKWWladW0zeDRHSjk3S2hMRFMxQ1lza0w2R1ZmakhwK2FjSllmS0xZUjVM?=
 =?utf-8?B?ajhja0Q3N0dTS0UxUHNZYzMzUnFaTldDYXRXVktDUTVTSE5aeWp4RWJOMFkz?=
 =?utf-8?B?YWxmNUkyYkFqTjhEcFFMc085L3pwelcwVU43OXduNlVCQys2cGwvYkVDTEEz?=
 =?utf-8?B?TTdiMjY4eFdWNmNZTnpsZzhmdzJSVFFtZmhjUnVTcEo1WWU2eEVJU29vaXJm?=
 =?utf-8?B?Nml6a05pNENsdHoxNDYvK3AvclorUE9jNzdDaVEwQzRjdmNmL3FuMFpkR3FF?=
 =?utf-8?B?ZzBQZ0VlRGtNdndpa0F4SkxwQWpRUzRYVEY5eWUyUUVob21EZnY2M3RpcTdV?=
 =?utf-8?B?eWJYMUV0UmlLVWlsOUtOTS9jYTFQd2lXWlluY2xMdmxFbVBKaFhWajQzT0lr?=
 =?utf-8?B?YWgrcG9uV3Rtbk5BVlhlTlFlWUtPUm5EWHo5SXlaeVJFOTRob1BtYlcwN09X?=
 =?utf-8?B?SWYwTmhoRVFBTmZjYm5vOU9naHhOcklGOWlqS1psaCtVZkZKQ2k1VUp6V0tD?=
 =?utf-8?B?ZU94T2k5MEJRVnNabWVKdFE0TG8wMUJGbWRySlFQMGVKOEpSZXdabW14YlRV?=
 =?utf-8?B?WkRLMHh0dDFoZEI2UmFDbk1NUlE4TVhoMFhzQmVMcVRMTEdsWkR5UjF6Z05m?=
 =?utf-8?B?V2lGb2NUSDJZbzdablEvdCttaTJLODIrUmNJUFpiMy9Bc0ZQam01TFFDNjVE?=
 =?utf-8?B?MFhnckZxU293VDdjWjQyN0hveEtMNW9rM2J6cTB5dTJ6RnBjc3ptbXZEMlhj?=
 =?utf-8?B?ckIwakozZERkQ0tmTU1zT1VhaUsxek1tMlJabC8vU3NXbVVQaTZDbnNtUGUr?=
 =?utf-8?B?Tnd3VzFaa3hSdWd0aVprM0U3ZWlKVlo3VW1HQ3dTU1BXemRYL091T2I3NVlX?=
 =?utf-8?B?QktrY2kwQ1lLYlZHR1VHVFBrTk1TK2psY29oVlVrZ1dsY1haT1V5SEdMZDNK?=
 =?utf-8?B?NnNrUDd3eThlczdEb01FOWR0ZWhRZU5yZUF0a212STZlUnZOYWx6ejBxRnpl?=
 =?utf-8?B?ZjIwR0FPLzRFY1dIa1haR1owVWVqRGpxYnh1RGNEbzVUYXFZb3BWWWJEK2tC?=
 =?utf-8?B?ZVFqRVdlSGNUdjQvdE84NHZxMkw3RllmazJ2MEZacVd0anVKbWkvK3Rzak11?=
 =?utf-8?B?YlU1bU1qQzE2blg4STFTaUM4czNwUmYrOGtyMGx3Qm4xMWtjWjdjWUxJUTNE?=
 =?utf-8?B?VkFTM3NId2tjRnE2WEZuRnhyUkNJbzJXNVRRc2I3YURXaituVTRvWDZCdnNR?=
 =?utf-8?B?WEY0clRoRmsyM1pMVHo3R09UNmF5ZVg2NUNOYXdhcCtHQ0RnZmxUS01wa24w?=
 =?utf-8?B?M2RXVHZxaXN6L0ROR05lNG5XejQ5TUd3aTZ5VmswNlpIRHhzYm9kU3RPSkFW?=
 =?utf-8?B?bHVjVXdpWWN2UkRkNlB3b2xaMklhTmJ1eTdYTmJZekZKTXY4Mi9LNkx4bU9a?=
 =?utf-8?B?RGkzZTcxb2p0ZVYvUEIwS0VSUjJYNXRJSllXNGdLSDFGQkRuNmhibGFZTmQy?=
 =?utf-8?B?VGFrSzlqS3dQb3BnckVBWHdSdVVOcmJDWmQ2aHFDd3ZRYVc0N2F1K1lWWlpC?=
 =?utf-8?B?NlRRR0svdmpqbGJwRE9INDdWb1hrazBFRXN2WjNycEs4V1FsZHBpa2JubW5X?=
 =?utf-8?B?aEdFUkgwSk0xZnJFVyt3dXpFdHJ0RmZNS2ZON1RwaHBRcjAwMnluV2J5WXdP?=
 =?utf-8?B?OHRIUHdzWWZNOE40VVFoeDBBWGdEaHZkTWV6VFk1MGt0bmgwYmRFQnhiK3BU?=
 =?utf-8?B?OHJJMldDbUxFVGJkSUV3WElGOTB6bm5zbUV4YlBjSGxWWjhIZzFGdWRpN3Ft?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb61b451-0f77-4cf8-9652-08dde53d71d6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:43:42.4189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sL0tRJlVlOEQEu7U/gpNcgs7wk3m1gSOjsSn/rULkmv2Sm6Dlc0rwlkkpS5Vc+H53ISkdeO88M/7Km44/0Cc1HjippYb9IOi7cLwHedKYRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7578
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

Am 07.08.25 um 18:35 schrieb Andrew Goodbody:
> In lp87565_buck_val hex is an unsigned variable being assigned the return
> value from a function that returns int. Change hex to be an int so that
> the following test for an error as a negative value will work as expected.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
