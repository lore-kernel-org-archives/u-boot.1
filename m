Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FDFC83F21
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1CD82F00;
	Tue, 15 Jul 2025 11:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N8H0dfdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9102482F14; Tue, 15 Jul 2025 11:07:21 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA6682BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0bmDjLjY87uZXDFYhByYM/zF3sDFbPn+2lA13PUY8N0SDY5z2CwRJc3nKACp4tnx9H+h8UEqdOH4V2T+0qNivB2gUlyDrY055bOMeRy5vyQmBdoj4jXmsf3NJUs1vEtbMJ2XiQW5fce2OSaD5qQjdcg46STI3RO16BIXK8E1+4ggi2dOvYpWf80IEE00wJTVlu9sy4XUHwT6skPcoG87kPZYhBtnmYqFpaWr3hs0TV+amTn21t3QjEsB8/ernGtZnWWSSob5i09auKs6gbFuD0AGeuZto31YziclPA10ozbs5p3KCMLzmApgU5SnAW1m+9FsxnVHbVGcZLShzRWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPfxq09a1K+hN4cevqTmfovVLZU4cMbQN4h2kteQBDA=;
 b=iUxljgZRATGpXuvcbVugydF8fwdj06qVb6Bff9Q0H0Z998N6SLFXjR4p8zJG4A0zYBuv/UlQVHQAKK+xywOADDN8VEdMx9Gu2d8vgnLc2m1Go5//9kI0xv3PPqVNoeXAu/dnBEGYOJJ9rvJrFFHQasAojLcXtMmlawxeXJCL97aWu1OM3VdXJGp7TlzvHWaCYdDUeqsNHnbZ6LJfhngaELMHzj0YUpmsW8pRR3mCMKPOvwIqeSRcANkIcNe8wjmx4jK2paWVVEQ1rsSaRNCTHnMm0GJJH05n8ApbmycSYrICpHDoGSOvEdXrY8CHTFOAUJipe1Mcq+pE/XUHHc77yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPfxq09a1K+hN4cevqTmfovVLZU4cMbQN4h2kteQBDA=;
 b=N8H0dfdVqcIzVtV5Bgg8LSDMDzdAzuJ4/daKQQWWS4ckcARGtrRRnj3VBSTtUMGrieiVGkVvByGcr+dYg5MxEu3LJE8t/ZmxFhlFKrA/PcNK0V46WkpVcQDEo/dJIhEOl9zhX7a2Wq2bvQNhrhWRWxj4wTSKCmtnfzBp/cskYXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS5PR04MB9921.eurprd04.prod.outlook.com (2603:10a6:20b:678::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:07:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:07:17 +0000
Message-ID: <0df75337-a0e0-4076-93db-aa8632e23c8e@cherry.de>
Date: Tue, 15 Jul 2025 11:07:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl-boot-order: Defer probe of boot device
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20250712211232.680047-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250712211232.680047-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0238.eurprd07.prod.outlook.com
 (2603:10a6:802:58::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS5PR04MB9921:EE_
X-MS-Office365-Filtering-Correlation-Id: 1801e72f-c73d-4ecd-f4d3-08ddc37eff0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHpSYk54cTZjcUxyNUxoY0JPZWl1c2Q1b0kvUWx5M082NGgzaEV2ZUdoN2J2?=
 =?utf-8?B?UWU4MllXQU9haXJUOEdJRDBHMktxYzQ3cXV4UVliNHBRazBZamY0bGFRZnR3?=
 =?utf-8?B?R2NKYzdnRG5sQlZlWE9iR1A5QTJ4dElxUExHMXlzUEFJWFZrZEVEMjF2elV2?=
 =?utf-8?B?QTN0Q3Z5Z0l4ZktlVi9vNnZNM3hvZ25ZWlpqdE5qYUM5eFpPNC95MVIzYXhp?=
 =?utf-8?B?K2hVak9KOG5JdEN1c3UyQnVSYnBOaDVxOE9ITWZlYkVXc3pVR3N4bnIxZEVy?=
 =?utf-8?B?R2dPRDN6M0JBMzFaMzdOVnFIVWZZMS9GbHpRbVRNV3loNHZlaUJwRkhuazJU?=
 =?utf-8?B?M0FRdFdGTXRReFRHZ2plY3hndmZUSFB4Qm1YR2NwM2FCZnhWcnZtWXcxNkUx?=
 =?utf-8?B?T1huSUh6VWUxMWR5Z3RGRHA4R0VWRFdXYWRaWGRFQWIzMWdpNW93M2paeGZQ?=
 =?utf-8?B?K0tsaVNQaWhZaDdiSkp0cXVjNEk1b29XWU9zM1ZGNnJ2bGV0N2szUHVQRnlV?=
 =?utf-8?B?eGFqVzlDU1hacENKaERGdEh5YWFHRU5ySUwyaDI1NlZMVGFrNnRwMEJib2I1?=
 =?utf-8?B?aDB1emNXSUlUdVF5UkZIZjBQTnpTN2Y5SVZwUTRBc3VCVHFFdGppbzFxR3FP?=
 =?utf-8?B?MEtjVGZTQVhQb0w1cDlNTXR6bjV1VmVqZGxvcVk0b2piQ0FLYzl3b1ZLMHpD?=
 =?utf-8?B?VFgrMFlocksxcWlsS2hGTTF6bWNoTEtlQ016d3NLS3VnbVZ6eXRRS1VBalhw?=
 =?utf-8?B?R1c3UzJNY0dsRnpTVGlOVXVxT01jTW01WEFnSWU5dXRkcWpDM2Q4aHNvMkg5?=
 =?utf-8?B?M3lRMmhSbXRHa3lTTUozY3l2TmdGT1owc1hCUm1yMTZPZ2ZXUGVFUnllUmE3?=
 =?utf-8?B?MWVxV2ZJVnJtaExRb3h2K1FOcFY3VWV1WjdxbW84cDhvc0ZBTk5YcmsvalRT?=
 =?utf-8?B?bjR0QXJrMS80UmlYUTdiaDNTVXl2YU8vSXFERmdMZHZ0OG5WWUUvZi82Smkv?=
 =?utf-8?B?cTRJSDAxSlAwSERETW5hSURvM0ZGbGc0bm9keWFuc0l5Zml6c1I3WVZ2SEJk?=
 =?utf-8?B?VWRzQlBZL2RKTzVrb2dEamZPUkl4ZUxQTXQ1UHBlU3VyeE9BNjJSVHBTTFVl?=
 =?utf-8?B?aVBmclBYS1pPYjE1bjFSbnVCYUM4c1hLZ2VuSlpMeFc5MXRJcWliWjcrc0tk?=
 =?utf-8?B?OFdzZlFPRElScEdzaFNpanNRK2N0eFBaZDNMc0w5aFhvd3ZleU1BMXBQS2ZS?=
 =?utf-8?B?L1dpbzE0WnlHWFdYdVBmZi9MaDh4anQxR3YvdUVWN3JhVzJBSTFzYk9nQkZ2?=
 =?utf-8?B?L01Nd2k1MjFxeU9OVjhneEJhZEswN21rTmVUVTZxUHNyWCtXRG1DTEE2cTJ1?=
 =?utf-8?B?Q1cyeDNsazhSdlhCTVB1cWJGY0I1SmwxV21ibnJnbXRhblNaZVVOakFQRUNG?=
 =?utf-8?B?WWYzRTZSS3FVNnM3Qy83RnZGWUlwWU1tV3U3bm1CSzdwb1NDR1NKMzNqaHp4?=
 =?utf-8?B?bGQ3NFlPT0huczNNTmRUa0xVdXFGSW0xNFBjWEVjaFFhOWtwc1dyNkVSMTcw?=
 =?utf-8?B?QUlqeEIya0tuU1ZVVVhwdEFCMGVrSnJGNll6MW1zK1o5Z0cybGw5MGgzTURY?=
 =?utf-8?B?aXpIczBzTFdHUUVLVmkydmZDek9jaDljUHJHTXVnRWhySmZKTVlWSEQrWWtJ?=
 =?utf-8?B?THo2dFR1bkR6T1BFUHgrcythUzBzOTZBUDdOYUJITmFkVkdnNXZzN2dhMXpU?=
 =?utf-8?B?UklXRXpmUys4WG9IbWRzS1BkVkpuMWlMTEE2QVRYcGlJdmxZZjJHcGFwWWNB?=
 =?utf-8?B?OVpueEpMby95YWcwdmZDcmphOXFhdjlWN3Rvb1RSQ0U1dERkWU9mYWh2UU9S?=
 =?utf-8?B?QUlqM2xiVXFUNHBZV0U2N2pjbHpTRWtaVGxvR3FXMWNOWEJrU0h3YnUzZjJt?=
 =?utf-8?Q?W94ni8YC8WQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d25yVzA5RldUWW83TVlqSlY5dmljdXpIbERFNEV1YU90VTBrTWs2aWwvRFMr?=
 =?utf-8?B?b1czQml6S0t0MVZiT0o3OGtSQW5pSDArd0xTRzI0eW5IMDFWUFY1UzlnUm1V?=
 =?utf-8?B?b1VCVHN5dDFvaXpuS2pnVWJyeThCRDBsblNGZ0ZtMW9yZk5KN1dlcHVTZFdV?=
 =?utf-8?B?OWMvRENENVp4QzU4N1hEdk12dm9NTWhMYkNDcCt5SmROaWhZOUtuellXdW11?=
 =?utf-8?B?Vi95UGJMQjcrY2JTT0JtS1BCamhYMHMrUG1MVm5XUXRBQUhkODJNUk1HU0pv?=
 =?utf-8?B?WG9mcDlGNEc2SmNXdjdBUlNMa2xycjIxeFk1QXRTQnVQQnA2M1REUXZYQnFU?=
 =?utf-8?B?YjFnenBMeFA5bWZ0dnEzSkZVMEp5ajJqWCtVV2hYZ2xRNnE5TmJUN1hCSGd6?=
 =?utf-8?B?OFExN1RES3puSGd3WktVaGpHS0MzS0xCa2h5RTZzVk12SnMraENUbkoydzUw?=
 =?utf-8?B?bzRpbkhOdUJVUU1oZFhUSzY3TVAxV0hEekhFTnR2czRtNTM5N1FDYTYvU0Fx?=
 =?utf-8?B?VHplblp3NkhYY1B6M3BhZG8xR0dwd0tWT3k2YVV6YnBKTEdKNHl3eW5aRHpV?=
 =?utf-8?B?bVg0M29TY1BIUEZrSWg1cE1saFl4WWVCejhRRnBxeGtndGVmVkJQRjA3SW1v?=
 =?utf-8?B?YjhuVkxCUCtpRExEckV0YWpVRHV1VXNTNHlFSUNYNi9mZ1kvS3JBTzh2UFJH?=
 =?utf-8?B?TlNiMG9Fb2RvUXpob1lOaDByWklQcnVIWnV0Znd2MGt0SlRabnBsQ280azA5?=
 =?utf-8?B?dEdadnJ4MzhIRDJrL0ZtZEQya3diRzhIQXlLM1c2L3pweFVVVlBoNHdqVjVL?=
 =?utf-8?B?QWpYcERGMVlVcnA3OS9oVituZENpc1JSSGpGWmpzZnIvTEo0N0RXVzYvSkhW?=
 =?utf-8?B?UEpLSnZRNXJ4Q3gvcVU0WEd3Qm5Dczc0Nm5yWUpBOUdQdHRPaVZ0OUVGNFcw?=
 =?utf-8?B?dURJYjJyYm9heWQ4V0tyckxWRUp2MzRkOTdtSXVQeWNqZTFyQW55RGczNktr?=
 =?utf-8?B?TFlPTU9DZ3B1NjNFek02WUtqRVJTbmUxcmtnVWFTZ1BCZDhFS29LejdGZURw?=
 =?utf-8?B?WWtyZ3dpZTJXYXJURjJoS1E2RzV4c296UHFLYkwvZU5MR2VPWG8rT1l4OWVR?=
 =?utf-8?B?R0lETmdXN2RBdXZDTERlWTdHaGZjNmtOWVVDYTRuQUpTbnFvYm1IN01zdktx?=
 =?utf-8?B?NkxReW9xQm5hbXhaNlVXSDFDU1NMa0lMQUZYRzB3QSs0UE9kWk5HZWpWRUgy?=
 =?utf-8?B?cjR6dm9Jc3BOajlGOWFvWWpSM0VRLzNVamhmdENJYVVveFZxK3ZxTkZKR0pq?=
 =?utf-8?B?U1ZjclM5cE1FNlk2ZGQwWWR4bTdaVGtGUG9iTEFsRFZ1TStJZll5cWxBZDls?=
 =?utf-8?B?aFllUTYzOExncVFONjVLZ1g0TWhNeWVLUU9GaFBsSGdsbXN0ZG5nMys5eUta?=
 =?utf-8?B?a3JrRkJINkhTTGNETVJVSTVCSndXZ25MWWs2cndiN2k4MGdMK3lxNDZ6MVpF?=
 =?utf-8?B?SjJVTUpoRzNxY1RZUEhFRWpZSENQZ3R1SC9Idm80cmQ2MUtPcmNKQkNzRU5j?=
 =?utf-8?B?N2JLNnIxNUw5K0ZYTTl4TjFLOEE5cGxFYk8xUW9sMmd0akdDcGZCaEYxaEpE?=
 =?utf-8?B?Z2RLbWF2NEFyL3ZHb1ZkdVVhUjVrMk1YaXcreks0Q0VoREt3MmQ1RGhvWW9F?=
 =?utf-8?B?TkdwNGdkQWZhWm5OdzhaUXdDbVB0cFZveDZXS3hlb2tvMFFYN1lXcW1ETENU?=
 =?utf-8?B?V3duU2JOZEZCejJ1blZoZnUrc2lQSHg3OWtVc2ZQUlN6OG91OWxYVWJRYnQ1?=
 =?utf-8?B?aS9LWEFhSGU0TEplVDZuRkFneU5qeStnOVhWR2lxaTdGalU1cnNibTRMS3J1?=
 =?utf-8?B?ZzJCUWtIL1ZYRnZDSzg4VjFYd1hDWDNBSkI2YzFVSDZGVVRkcW44YUtLb2tk?=
 =?utf-8?B?ZzhNTTFRcmtTeVRWV3dJbFhKK1k1MlpqU1NlSG13ZS9zUVVhUE5pNzhNNVdX?=
 =?utf-8?B?bHc2QTJ0RzlQSXhYTUFjdm5kdVg0L0lxS2VpekF5bHJ5bVJIRDRXbEpwUXNB?=
 =?utf-8?B?bWdrTkE5N2xNVXdrZTJxNG1zdW5aQ25ZQjBDcFRTbllXczNqL01Eam12eE9O?=
 =?utf-8?B?eDJ2dHRVclhZQ0JLTXd0aVBLVERFM0R0RDlZNUdnK21WeGh6NG9zSDR0dS9h?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1801e72f-c73d-4ecd-f4d3-08ddc37eff0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:07:17.2519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFrTobOMq/xO0TSbkievt6O/whJ9fJJWL6FFNjcWiq8swTI/uQ2qIRxsCMPBCT9YFczknP+C2Gfc723kkn3RsIyyDFcl1pTAPfLL9KlHrUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9921
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

Hi Jonas,

On 7/12/25 11:12 PM, Jonas Karlman wrote:
> Boot devices are being probed when SPL boot order is determined. This
> may delay boot slightly and can prevent booting from SPI Flash on boards
> that use same pins for SPI Flash and eMMC due to pinctrl being applied
> prior to booting.
> 

How would that be possible? One cannot have the same pins used for SPI 
flash and eMMC at the same time? So that would be an issue in the DT or 
a misconfigured DT for the board?

On paper otherwise, it makes sense to me not to probe the device until 
it's used.

Is it guaranteed the devices are actually probed before being used from 
the SPL loader code? (common/spl/*) I guess if it's not it would be an 
issue in the SPL loader code making assumptions it shouldn't.

Cheers,
Quentin
