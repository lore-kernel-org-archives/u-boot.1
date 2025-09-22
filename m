Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8076ACAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 13:49:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096FC83211;
	Mon, 22 Sep 2025 15:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mQL4Gm74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085EF8341C; Mon, 22 Sep 2025 15:49:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA22382CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 15:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3B/N+XcxMro3cznkVcwdVn86W92jx9BZ955uPjGB28mFYradusVNFwoc7s4R00lbnCQMJvYnGcp1cYhaGy0pBwW/pQ9ue/3KExNBfyHtQpaw1Ye2GAGTNrOTrg44TUl0B3sGoGUeKYf8EY7wNWLgcMGmAD8/vZz8dPOoRlJron+3izhmfzPDSot5aqPgeech9nmEfL6YEb9chhYBvvv/R/EJWWM55IbNNw0tp2RdYI6csYcYLnEksaJCNCRdgjL8DjAnk1fzvXF0hXPcTodmqlQBwsu2q4Hgu7FEG6b9eduYZT8qyMM/JFKiUBhiqE0ytKsmV6Ziu9kxfwZo4Rf1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Abn0gNNEg1+Zo4bEent9nrOrH4xa/0JFWVflNpQ/uWE=;
 b=msRjpxGlDH+cikXAchbbuxLH+MSShfEAxWyC2pmJozcgRHZ1abft3mRkui9EteN/lw9l8tpgXjB+qV2S7xsLRP0Vj9OePgv6lqO+x1eiCaSiVaN+oeujrEA3VlIqT1HRgs6rdcV5zXNcA51AMKpKWxnXyUOWYeiqpbXYiTqqYbxvUiZ/ZQzLL8EdfU8BFPxHhwa4okB5o5n0iZi1RkEJ33gJ5qP9iBdYw/iLSrG5i2OPhQCh0pBkVzFQFth1yOLTZZZ+ngsju7KjG8q8Nc7bwCaATdGkR9PFuo0YbqhAMHcmOE3BmNAZKm7J/JTebrbF2uQpwwHw6NDKo/cjM+doGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Abn0gNNEg1+Zo4bEent9nrOrH4xa/0JFWVflNpQ/uWE=;
 b=mQL4Gm74rp7auRL/vRcpGTcAGmmWBNPt9Lump9Zn6nkpD+dzTb1mqX4jqIiETsd7Oz9wJO00UnPcTHhuhch8+Bp0LbH+fFrCYrKNDMALgCZSnz3fzKjzlnUwYcNm8yhqnQGFUokRVu05Ril9vMHlJz5AQInJnFTRBZQ64hYTg54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA4PR04MB7503.eurprd04.prod.outlook.com (2603:10a6:102:f2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.7; Mon, 22 Sep
 2025 13:49:04 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 13:49:04 +0000
Message-ID: <1f4cd9f1-653b-499b-ab9c-864fd434ceac@cherry.de>
Date: Mon, 22 Sep 2025 15:49:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: ti: fix K3 clock driver help texts
To: yegorslists@googlemail.com, u-boot@lists.denx.de
Cc: lukma@denx.de, seanga2@gmail.com
References: <20250922132700.4180174-1-yegorslists@googlemail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250922132700.4180174-1-yegorslists@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA4PR04MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa50a42-bc5f-4ea2-1195-08ddf9decadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDYxU3RmQnZkMXJ1bWgzcFBIT0JVaXRraXlnVjdOSksrd2tNS2dVdUg5R3Ny?=
 =?utf-8?B?ZWpXcUNSRkptZXVjbkhsTTlDaWdsWGR1K3FjcU11akhXcXJXdFVOWW9XckpL?=
 =?utf-8?B?WVh2TlpVSllZaHRGVW14YlZWTUVTbHZKZHhubTZNanhBOHJpQkxnVHJpSFpN?=
 =?utf-8?B?U0oxQWtrT3dtWEdzNGdMMVFYdkFhUWRCaVI1NG03aEEvVDZQQnJaRnJydDFp?=
 =?utf-8?B?QWVXNWN6dTlGOXZpd1N4bm00UzM1cEhQUDJEMFE4WVRZTUkzRzhTNlkwdGZl?=
 =?utf-8?B?R253QitOWnhHb1l2SjJxbkpZRDY5YWR4MHJiaDRlTUQ0Qi9NNVlIRFZPZW5Z?=
 =?utf-8?B?WnlvOFZ6UGdlZFRHZWMxc3Nkd0pwZFkxYjB6bytzbGVtdlBwYmpQbjBlUmxq?=
 =?utf-8?B?cFlzNUpuMzhiZEVHZWFVZUt5a09ERkt3c1V0dFU5QVV2dzUrSUY0LzlVRUQ4?=
 =?utf-8?B?dU5LRnhnVGsvQzJNYnlVak9Fei82R2JyUWJaZ1JtT3gxVkR2UkxlNndMemQ3?=
 =?utf-8?B?cTFQRWhnTStHYmFuN2JjUXZoTktHQ0J2bjNObWxlS280MEw4di9aRTRzWHpS?=
 =?utf-8?B?ZmE5RHR6WXVDSjVVeU5TdDg0QlVNY1pIWWpIQmh5SVhzV2k2NmVSRmdodXRa?=
 =?utf-8?B?ekN1YlR2bDFnbEJCa0lDSlk5TjZ3U0xyNGJtRzBDVkZVaGtVbytQenlkN1hG?=
 =?utf-8?B?allOemY2RVFDM0dHeGtjZU5ESGhkYWU4RGtQU1EzcFlMQnVRSS9EeDBHL0ww?=
 =?utf-8?B?Yzc0V2tPSTdTOEhVZ0FvTUR5My9tZTgwM2xCTWNScUJxam92Q2h2UzBQc0JB?=
 =?utf-8?B?ak9LWVIwcW1LYi80OXAveHJYUGZ5dEJaM3hXMzR6THlFZUdGYXRZRXdEQWVq?=
 =?utf-8?B?andzZi9JdlpyTERSVGVFNnNCOUM2RDFkUU1haTZSVGFBUG9HTHZQOVFLbk13?=
 =?utf-8?B?ZUFrWFJ0dUkwcDZDWmd3SWpKSTUyWE1GRERzUW4wa1dIK1ZKV2ZRbnlzVXpi?=
 =?utf-8?B?Z1EzZ1VkdnJLVjVmUVNtdm5OaVJCeStEajJUWlBTd2tZeUp4S3UxcDdnR3pY?=
 =?utf-8?B?KzAyelA2TDg1NUVnOWlKbVZubG9ya015QjVPdENMQU02Z3ljd1h4cFpHSHN6?=
 =?utf-8?B?MThuQWEzQzQ5bVRHSkQ4TDF4Q0w4b3pRa2hLRy9COTVEL2h3L3VNUU0zUEdu?=
 =?utf-8?B?RThTZ0M0VFl2WlJQSWpSZllFODNEZElXTVRJSytCT1RZUEhpRzk3cHhrWTJx?=
 =?utf-8?B?WlZ6aVpwU0c5S2xGcnd5cm1TSkNHUkx5SThGVE9MNTMrckg3WnhudWtHdU5K?=
 =?utf-8?B?aHh0T1VMTUhzZ3BtbUNBSER6VUNkVkdXTnl5UEZBTnJPYWdQRFlrTVRrdEdr?=
 =?utf-8?B?RTYyd2JPM0V1NkVZVDFxc3M1YlRPeGVnNWdJWVRlelF0MlRxK2x0OWlwL0w5?=
 =?utf-8?B?RFVlU3NTTk9EdlRUZm9Od0c2MEdINFZGcTdQVkJaS0RtNE5YeTRhMXVJRHIz?=
 =?utf-8?B?WUJtVHR1Yk5UQTFiYTg2NTlWY055QzRvMnhUVXlYUUFldjJlMGpXNmpSSllI?=
 =?utf-8?B?bjd5K1UvaXBNQWNhRDhUK2RmZnFtd2NoN3p6TGR2RE81RHp3U1dBYlQwaWo3?=
 =?utf-8?B?V2tma3c2TTZuYTQxTWlXLy82dGhLcmg2RENHcnFzMC80bFU4Wjl0NlpXSXVt?=
 =?utf-8?B?VGdGSzFYa01DM0p2NkI4Vm9rbFpudTN2ZU1aeHpTL2hsNE5KaFQ4SUlIcWZF?=
 =?utf-8?B?M0FJWXJrQlNjMk51QmNRU1FuTXJFeXZmSml0UE9QZUFYcUlpL2dGODBLM2t1?=
 =?utf-8?B?YUNqcGttRGNtTDdlZXhIbUxVdnhFelV6cDk4ZlYrRlJEZHp0NnVOdzFZU2lt?=
 =?utf-8?B?SjQ4S2ZlelZXSEhPZlJKN2ZxWVJJWTJteHBZcytSb3prNnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm1oMjJZbkF4c3F2VlBGRG16c3ZGckF3bC9HRUNCYWEwa1hMeFRZZHJjMFNK?=
 =?utf-8?B?czF1MlJWY25MN2o2ZnNDSkl0RmZtMjlja2VCRDlrQ2ZiUWxsOEx1ZW1pc0Z2?=
 =?utf-8?B?Q1AyRVdoQjhkUzYyZURjTnJNNUFjRXhNNVhBRGMweXBNL05IOU5UNDRPM2N1?=
 =?utf-8?B?MDBXNkZZRDZzcWZnUnRJNGxESHhBdmpyeTUzMnNLcWJjWUVLb2RHdlM2THAw?=
 =?utf-8?B?NFVHdXVINFZXTmtQcXFXU1BpN1dWQS91REI1NmdQOXl0c0lmdEpnTzN4eitY?=
 =?utf-8?B?L0VtZWhDWFZMWTNpTUdTVXJhSGFNYk9kUXUwSGhueFhHSld0U3pHKzBNakFG?=
 =?utf-8?B?SGJqMG1wNXkxbXhEaU1LYVg2c3RadTNsOWQrSWN4ZHJYekFYTS9wSnRpa0JB?=
 =?utf-8?B?TE9IUHpTSkl4ckxZRWg3eWhpNnp4ckxzcVFZeXdNZGU3ejd4Mk5Sb082UzUr?=
 =?utf-8?B?ck1sWmJ4czR5OTRiMGNnU0FwTnN2Q3RQRUhQcTBOWGtUTlhWK0ROdG9iMFo2?=
 =?utf-8?B?SGJLOG9kalhwUGRyaFA0S3VaWnFXZXMvTEkyODJXOUJUR1lNcytaeitLbCt2?=
 =?utf-8?B?VTFJNUFuaVVEOVFQTkxBdFpGeWVyeDNmMXM1T3RtdE95cmlwN21iWUFzcGY2?=
 =?utf-8?B?RVZ1SFo4aGZ1Y3MvZWFrNVphVjVaVkVXN0dDMGs5ZENiSUpCMDZHTGpsNXkr?=
 =?utf-8?B?VFpVL1VGTXNJWTlhY3JwaFZLclE0NEZCSVNGZkdsdlpmTHlZZU9zY1BxOUJ1?=
 =?utf-8?B?cHVuWnJTdGg2QkFwMCs2TVJMR2NudUdWKzVhcCtLSUdhUHhURVorMjQwejN5?=
 =?utf-8?B?ZUZyQVJYRnhDSzE1Y2g2TStGQlFaOFZheDlyN2o4MmRJYVFYaCtxNm5OQXlq?=
 =?utf-8?B?RW9KelB2ejRZMzIwQ0Q3QmRGWGc2TUR6NU8wbWdXb0Z6TVpxejNoVGx0MTRn?=
 =?utf-8?B?bDl1M3Y0bDdSTGp4aVhqTDhuY1h1bXZFc2pMcysvM0o4ZTh5MUpmWEd2VWx4?=
 =?utf-8?B?WURSampDQlFUUlF4aXBTVHloUXA1Z2ovM1creHVrNm9mRTVTbTZSdmd2eTMr?=
 =?utf-8?B?UFZVcHVNV0tXMndHTGQ1WmhHQ3cyeGc1dGs5UDFLdm1tbWJKdWhpYXlmUTQr?=
 =?utf-8?B?R25sbm9neG5BRTdwMGI4eVpHSy9ZU21XNkZEMHNodFcvU25lSzZiTWZyS1Fo?=
 =?utf-8?B?T09PaVBldVhjMG1PbVUxcTErRzJ5SGRsbVRyUDJiYXBVWVNuOU5YK3o0VWxs?=
 =?utf-8?B?ZDRaR1QwWEF3czFNYXlUemJpT1BKckZFbU9CRkxsb3U0dzVrdlpsV0dJVko5?=
 =?utf-8?B?a0svSWR1dG1nKzhkcHV6aE5pMWR5NmpCSGxkRjIrMldrVE5sS3hFUVVDLzZn?=
 =?utf-8?B?dnl3SkZ0QUNiY2wyZStCWHpZT083OHhJRmxqVDJtVUxHeUtHM0RKd2hIanI3?=
 =?utf-8?B?UlNyQkxuY0ZlOUcvQU11RVpOU3M2UElzSldZeFF1QUhQZmlTWlczUU1vRjd4?=
 =?utf-8?B?QnA0UngzS2pUQk4zN0F6WVNldmI5Y1NoQ0xpK2Z0MWtNNHd6V3hUNW9lUXMw?=
 =?utf-8?B?R3dXWDJGZGlxVHJOclgzL1VpQUcxeUhQOE9FTXpoTXJWU1g1WWd1MldRdW1u?=
 =?utf-8?B?a3NoRit1QTVKL0lNMlcwb3YyaCtFYXFnd0o3UWlqeC9zZG5xNDRHRTh2ZFJZ?=
 =?utf-8?B?eU5SZkhsdHVCSEV5TUdaMi9UUHBXTmJvSFU2RTF4Ykh4S3FGczNsZmt5WnZQ?=
 =?utf-8?B?NmFTUkpQOUZYc2xwdy9BUk1oMWxKYVR1aGRzWnpDSlFlK1Y0Ynhack1vZ1ZF?=
 =?utf-8?B?VWduYnFweHpXNGtkeXlOQU1rTnNyYnBSbzhpTGhCMm1ubW5UZjE2YUh6Lzdr?=
 =?utf-8?B?Tk8zU1pCVll0VVFOdld5UVBDRnM5K29pOWpidTJhZCthLzNOcVM2U2FvdFNG?=
 =?utf-8?B?di94M0FreTNndVhoMy9RNGpRVG5OWWpock9xc3p6dnZrL2xDc1R6a0pQYyto?=
 =?utf-8?B?KzIxYW9kZVlMZFBoak8zU0RoeDR3dXo1UGRaRjNMUE1Jd1ZUZmZTcXVnSjZ4?=
 =?utf-8?B?R2U4Mkc2Wm1zSExoR08rc3RZTExPa1dsOHRpU1lhNGVpR1hMQ1d6L2FUTXNo?=
 =?utf-8?B?T08renZFZGh5UlBKRytJOUdOUkc3eUQrK0dCRndLVkpvMHRISDB5eEQ2QU1K?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa50a42-bc5f-4ea2-1195-08ddf9decadd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:49:03.9795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HzPPF0VF6S5cDLmBpKZ+9bYSFUItm51DLcPHIZeuhteohvU7UQoZAuSshZoCWo3j3RAAi4ILRrtzW5Bz8cKrqiY/Jy46wErDiviJIa3hbOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7503
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

Hi Yegor,

On 9/22/25 3:27 PM, yegorslists@googlemail.com wrote:
> [You don't often get email from yegorslists@googlemail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Add "in SPL" to the SPL related driver help texts.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
