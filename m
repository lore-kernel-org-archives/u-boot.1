Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F888FD8FD6
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 16:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE76583EF5;
	Thu, 26 Feb 2026 17:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PePWXwHy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB3983F14; Thu, 26 Feb 2026 17:33:06 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F26583E8E
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 17:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLthenYQs8H5zprSA48urtlN1cBa6HDg/5nBaVJYtKgAx3m5L98YxnY0l7FqYfFV/zqrWVKZO+PSdrQBt8FvD5Dk9XWI2EdjIQYkrzz3hjpEGObd1qHJAeEUiEwTnApyGhRwm2CEF6pxm2hlkkK6IbokRogsFYiAE7xDQuL0UUTe0UjVoZte6M0EoL4D7t0YBnRqh3Az6hgdFNwnRC5PtvU5ZeKorG3NtKX8Nhps0pTz5j2mG8dLN5TeOClU9cHwSiXzf3owjJN86j1OLgIdyDUg7a8KIAqp3DYHzpMLGJOAbOGWm5jK1CdZm0BZut4oLFbeyXNGAsEcvAppYZP7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1THT5s+gmGcV4c6wpUclZqDe7M8vGdJkyEr5obb+aNU=;
 b=ZOqtuKyaZNrJPSmfVWAOO4AEqbFOGkXLyFQbaYCsQB8CWpThjlBM8NLvXivfpkoVZHzeIaTZPxMeAzMrB3GGbSUbhFXeqduOZ88dnJtL/kNFlAgTjKdD6+wcEw67sy7ElutNuadHGO8Wp+o2q0kvi+JUAPMxaH+QqRuc70xh52LuAONGYiKswB/baw3avXL+FDS0cW5DeclrP3h9O6m6/SNOFv/QPDbH6hKpJQ/aY8KJFEx1dSJH+GJr54LC2bahb7WN6R/1dywTf4QhoQM+uFrgVGOvJrAZccvY0iTZGftz2WT0VCiLe5hzk+zHWM2C6AuWrYz7dyrJhlrN56qfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1THT5s+gmGcV4c6wpUclZqDe7M8vGdJkyEr5obb+aNU=;
 b=PePWXwHyd0uw4wgseHe3NHE3C35qiKAcx5oemM6EwZYaUNI2dGT9SO2VeXrdkB1/SwQs9m02Y9pJnM97X6Cs9M+OECJbyiKaG885lKwtjNJ47N5J7UnvQxsJtbERUEsA5cQNyt9v+7p7aRE+Bkz4qpoLU42MO72mJGrfYqdk0YI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Thu, 26 Feb
 2026 16:33:02 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 16:33:02 +0000
Message-ID: <911baca6-2a28-4162-995d-46e47da33efc@cherry.de>
Date: Thu, 26 Feb 2026 17:32:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] binman: test: Drop the number prefix from non-dts
 test files
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Yannic Moog <y.moog@phytec.de>
References: <20260225225040.2568118-1-sjg@chromium.org>
 <20260225225040.2568118-3-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225225040.2568118-3-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cf4d9d-f2e7-4c0a-bf1e-08de7554b5ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: S7fZcDqINx0GK4vT9EBWstrBTKUrPvzIOA2NMUydBqYRH3QbCAbqz4Ci0OnFtrtcMAAjeoUUtyLPRYyAkLnf3nGAAVG99CR+BUO6Ssvk/uHLBJFSw+Lrxi5Aw19HxnIuPyysIWXDjsfcwYj5LcJB2xhsYBaqw6YYV2RKbKiIZre7eB9NInhyZrdWSrIilugLWmGQxkRJbdnGud2wjj8GNSIKnKqmN0SIxugFD9V0Wbsd6P8v4GTcVyZ7+FT18bXIJu8RB5DFeL2P2fVXSBi8UBcdFGQrjqK4HK8fCr8lTUVLlJHFe2KCB9hNSXDk85Sf6yO2T+YivN6oHf+u9Sa2ZzZTv3fT4EJjLTagLdgab+XewwNN1UZVt7F99Z5NgiDfMfzzSJpm3/hLfUTKPl0B/bSxQSOL2irYVYrqjDGTL3kAWwbwahAh3H6GbUU/+gcKUL5RcK0VwoixQ1sQ55cGbfQb+yJHGswVjD2xA354hctbvTJHJ+rb2S5PU9eNhjJPFpGDUsMchrDtc6OfFJQyt05+RHPO3eGbxBl0rUsLjVbvMvpNH7sXTSYrWqdCYHXq9WGWMjpEd8uPieTo565NtEeTTI6iuu6Z4HogKyLZGdjXzKZf5CKx96KGyprK+1dkL6NmQMidkaXmactr5xwylbdvkmqdGyy50C3Kmy0ZSJmRhm/qNkv4xMR3J15FOS/Ve9RZ9NmMzCa4rhbU+vonfLKxV57KlxbKlvTrGLxXRJo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tjl3Z1dKVTdabnBJQ1gwRTBOQ1hsc0s4S0pLdWpRSW9kRS9DaytmWGJmZ3JD?=
 =?utf-8?B?VGNZVGtOVzJlNzB6RTlYYmRjb0lZRG5zMmJLeVUzZllEVVI2SkkxcDB5b0dp?=
 =?utf-8?B?aEFKWjRaRjVMdDNJMVg2SHZtRHlVc3Fpd2hkR3dqMytDUFE4a2JKeGJpZFNj?=
 =?utf-8?B?ckhSNmsyeWlGc1FpdlRFelFUWkRhcnowbERzUzdFTGZMQVR3QWxFaWdrbml6?=
 =?utf-8?B?bk1LU0gzUWpSVWE4OEkxc3B1eVVUSXhaSURhazlWM1Flc3hibUhLZjFZaWMz?=
 =?utf-8?B?L3NEN01FNm41Y3orUlpuOVdMWUZvWFRUSXIyYmQvcEVWQ2MxOG1oZEwydjRY?=
 =?utf-8?B?bUM3UkJxVzAwejRrWW5aYkxveTdId1RMUThTZDQ0d1MvMTQ4OU4ySWxMODVu?=
 =?utf-8?B?NStlSTdtQTVUM0ZpeCtXQTk1NmVsS0JmZ0VuaHJDR2Z6NElvc2dGNHVLOHRZ?=
 =?utf-8?B?U29VM0lQQWxWUHR5Y3ZhNVpaYVdBRk1lSGZoTVNGMlhSSlN3elRVbWpRZmdy?=
 =?utf-8?B?THFVeHVyQmgyTncrSDVnWjF6cThuaWJURjZ5cEw1WkVJaFFSVmZFR1ozU0ZD?=
 =?utf-8?B?OTlIc1c2a29McCs4bXpPbUtnd2dzSWFnY3QrTTRLZlp6UkN4cFhKQ3kzL3M2?=
 =?utf-8?B?eGs3aEZENGFkTnN0L0N3U0Zxd0VGSVhXK05CSnB0VzVnR3BjZDFmaWoyalE1?=
 =?utf-8?B?ZmxKZzVMM3JkWmdHRHg5VHo3ZzJXa2ZmSjZyZStaRkpjK1pIaE1BYVF1YS9O?=
 =?utf-8?B?clVqSE9uSW53bkdnczNiMVJnTjU5dGp6M3NvQmFDOGRXa1BkT3BIYzZaVHJL?=
 =?utf-8?B?NG1LWDZhRHN5d3VCa2pxd3BVaUFKMXZsbWZMZFgrZ1YrMVJYaFNpb1pBZE5T?=
 =?utf-8?B?NS9uZlVxc0VDcW5BaFNjTFo5aFVrcmdOeGRoSzRYR29oeHhwNGI5V0NRZ3J2?=
 =?utf-8?B?U2o5czVudnlmUHlCZExYWjJkeDZDOWdIZFJxckFUcU53ODNmOG1yQkVod1BB?=
 =?utf-8?B?OWZtRmNSMDQxQzQ3Zit4a1dTQ0tvczhEbFdieEhEWHJjdTQrd1JBY3NyQ2Nu?=
 =?utf-8?B?VHBzOFc5a09LUU9heVduNXVJRHJqZHNzSlVVMDcvMkpPelFkakExYW05Zndn?=
 =?utf-8?B?SC9nRElSQ3hhSnAwTXJaN3JGS0VFRTBIdmNtS1RrM0VDSnRKaVgzbHVzYnda?=
 =?utf-8?B?NVkwQVJwOFRZcUJFeTlFcGZibjVKTjZkRmhQZ3VsdUwwcTYrL1FpNGd2Rkla?=
 =?utf-8?B?UlpQTmJFUUo1WEVrbkRKaTdNV3hhTUpESmlnanV2WVJkc2pLV2ZvOWhndzEv?=
 =?utf-8?B?QUhDVENtcTNVOU9lTEkwUmhZSXRNaUQ5bkladzZkVDMwZXpNR2J4T0xTVkFr?=
 =?utf-8?B?RXVMSXB3NGlPdCs3aFkvYUNScGRQZUU4dld6L3pldWo4Y1E4ZmozUm5lVGdN?=
 =?utf-8?B?UFdRMEt0NCtESjI1QVdrWm1WSHhSeFVZSTZibGVGU0J2bjVlMmVnYlczb3Nh?=
 =?utf-8?B?TSsxKzV1bWYvWEZmTUZGNzZ5a2pVY3pUcUpmajZnamdJay90UzlrTmYzZldI?=
 =?utf-8?B?Vm9TY3hEVUdVL2h5NTZ2QVphN1BURjRYYUFEL2E4NDVwRWdreHpVUzJ0SEw1?=
 =?utf-8?B?Wk1PbG9uNXM0MnMvKzREOHlGR0lDN3VqUFFBdEEzck5zeTA5QXBDVDlJVW5L?=
 =?utf-8?B?WTArQ2JweHhGb081MVk2a3BVdTRGdlNJMVRvZGhxNytaQW1acEE4clQ1WlRQ?=
 =?utf-8?B?VXdETnJkSk1aRnJUWWR2Z2lTbGJQdGVIR0U3aWdWY08ySjNXVmNwMHBHUTVq?=
 =?utf-8?B?aFR5ZjZuT1A2aitLMzYxM1lYTWV1MWVEc1hDZTVKbHlOUkttMGd4MUVIWXdz?=
 =?utf-8?B?UVl1QXk0RE9kS0pRb2hXWCt4VkRZa0RwaStiSG9SNWw2aENzakR2dGk3N3dL?=
 =?utf-8?B?MmN6QXNzcjExYkRodkNHMmNLMmt6WHkwc0dPUk9SaEkzTVY0UWxLSGpMZkZ3?=
 =?utf-8?B?YytrQmxFMDUya2k5dE9KeWM4T3BYb0JJbWxZWjJjR21DbXVDNHAyamJOeDRn?=
 =?utf-8?B?dzBwR3h0WnRJSys4M0I0Rit1MnVZRmVxNHh4bXcwWnFJdnVHREEzUDhMb25Z?=
 =?utf-8?B?ZG9mbkZHazVsQjFCdW1qNEt0VGcvcWM1b1JvYTkvRURzeWdBcGpyd2dIbEpR?=
 =?utf-8?B?UXZPL1pTVWRrQWg0L1ZuTmpRUmdGWHRTZTRoTTkxeGlkRGhwNDZDTGgyMlFa?=
 =?utf-8?B?YndKQmowSDJmUlhDQjJCQkc4ZUthNVhhK3hjQXg3UkdaZjhFUVdtQnpnejRJ?=
 =?utf-8?B?aWE0a1FvVmcvZkM4Ynl3RmZJS0NmVXljVzRRbUswUlJERDEvcytOdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cf4d9d-f2e7-4c0a-bf1e-08de7554b5ca
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:33:02.1953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCabVbPkCcfVI9Jp1mjl/2jByFrI86BMxcPkSZkMBy9jk/74aH2gszbaaf7iYj0zH3vgdoCMcGc0iPDBymcwUpbf/ziHUBDmxFJaxcrqV48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249
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

On 2/25/26 11:50 PM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> The non-dts files should not be numbered. Remove the 340_ prefix from

Why not? Now it's more difficult for me to know which files are supposed 
to be used with which dts/test.

What do we do once we have a name collision? Start another numbering scheme?

Honestly, I'm wondering if we shouldn't improve ftest to better split 
tests. Or maybe split ftest.py into multiple files. I very much dislike 
how we handle input files also. They are set at the class level and any 
test can modify them. I *guess* it could be fine to have a shared input 
directory among all tests, but it must be read-only so we don't have 
side effects (we can then have a per-test rw input directory if necessary).

I guess we could have a subdir per new ftest split which contains all 
files that pertain to this test. We can group them by theme for example 
to not have to have a subdir per test and overwhelm the user (though 
that makes it very explicit what's to be used with what).

The change seems fine so I won't fight against merging it but I don't 
see a clear benefit for it so I'll refrain from giving this a reviewer tag.

Cheers,
Quentin
