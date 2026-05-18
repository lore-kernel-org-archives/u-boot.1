Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC50CD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 16:07:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5966983FEE;
	Mon, 18 May 2026 18:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="WJFUF89h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4443184664; Mon, 18 May 2026 18:07:18 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D3E83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 18:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yziZiFehfq5UeV9VyBlzl/sakvhQLWlYZh3AhW2OJoiS1QMuDJX5kALjPCWZVATXhWrV8KfWBzXFKkXre0Y9Up8TwE0a2BXsxfH/oChXBcC2dE6d7jWyllQNBbKCq9hJDHn5nKzPWEFky2aek0rIsOcQ712yH+H58QUUlVJh17NhwB6S7hblZtj+bPM0NNuG7o2syX9uCae4R6NnUR3jtbkMTjZGnkKeq/siwt5RSldnL2cCtkA5O1i7KFOpW6gpVikyAja2lq9wKkbVobVKpeSUnrvDiJ1Scdd+myet6S2kMhktHtN2vp1mFlTwhbt2jqjuXaGQ8v4pysBn0LiI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeyhyt1lxiVcvVClhOdtxVfa8gGsTfssK/Z6rVLXgSU=;
 b=Zr40QIniGf3H/3+2bCxbYl1gjvi+5TQaLKkVjF+XM8adeDgvbwPtBeqw1lUj/84JFe6H7Za43jKvNZsqxC7On9YGFjkWGsuxlij+c3dRWAvQHUtBjdq6onYq3sKVNhmHDKPOXTkv6A8KcbPf3VmqtTMnnPBIZuBaXGVoGKiZtzs8zYHvcexjrMna7llL+FFidw7/kg2tSS8dJ9WkJuu0MjxalYorBHnzAKVm1sik07mjIeJ0yUOYnBuSv9wbNuUlqorv1duAweuAc4moFdB/8yrkZ2rEzfMPnTR/kozjvZ5n7Fugo/DP3NpzaCNk05AGeYLvy8HSx/bZI1LQstDCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeyhyt1lxiVcvVClhOdtxVfa8gGsTfssK/Z6rVLXgSU=;
 b=WJFUF89htPMwjoDQPfJSC+if5rk8WjajFdIbNioXUK4wQadE8CK1eDqhCJ5VVJQGEyaL3YVlj3U4EAAWrs3KMJn7HR0I/H/YmbTnWmLvj1qpR6rPQl7LCCr9HHhNQKJJUkUS7C/kN3N6G/NDcnqZZx0R9Y8WqDlNlun4JWuKk/WJdwCU+Rd04cnzqDTId2bsedZF6U0O+z5KShKsuf3k55sbiVtex8FUBvM2DRIEBwEnUEo6yHCS2l0Ascf1r7MWXYNeyAZxmjKxMixWiHJF35pXiQKv8OP400ioiqqls+572SaCFWdZ0/q4acNCMjXMMp0To9okC09TuwpDSmhw3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by GVUPR10MB9725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:35a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:07:14 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:07:14 +0000
Message-ID: <58360478-3c15-4c1f-ad4c-c5ce25ea2b82@siemens.com>
Date: Mon, 18 May 2026 18:07:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v4,0/6] Improve FIT signature handling
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
 <CAFLszTifT1G2XwBvvTZPtrsBM47Y-DD1GFn8rx=ieRcTFHaN4g@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTifT1G2XwBvvTZPtrsBM47Y-DD1GFn8rx=ieRcTFHaN4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0108.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::23) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|GVUPR10MB9725:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e338ec-3d13-4644-b09c-08deb4f78693
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|11063799003|3023799003|4143699003|55112099003;
X-Microsoft-Antispam-Message-Info: VUifRKMxbgnxKCUhfMw1U/CBjbm2w86GS675tf42VoUunGnJSUd0wXs88qhzZxCumcJ4L4hjO5UWrDcsZlbaFifW6gXvfYdJ9j7FhwaH4rOdfwhW1r2+tT9FQ1ybru2dxlSPjHPG2AF1WZhy0TBhD+N/AOtma5g3/nsKX29+i++hXDz0bbsHNCw0XkZh6bWIfJfWZrXysq+Imw+VOuIbBe4CMH/73hlLJXLyvkXPhPiFkvj5y/7NI50EWN2wq0r1SGwyUGq14EyEB0YfGm0WdwgBSGS4WCItIIzoWeZv0UT1y91MjvrmthZG/nbSd0ss7iVd46Vid/hnhmHufqBrEIeWPOtQAvS+vBOSud5a3lbapbt5LbLFEjhNVaeYS/YpIUKyJ1fCy/OtadPJ1AbUBv8GZXdD/45o7c9w20crslLGI7JGqfURiAkMbvZoiMumAREZzdHIWwmxz6usRWF+/a66g/7i70jEwY3QPDAsqn07qsuA+4QckfMJpbutHa/YJ/vw+z2L3zaWlv3jFXgDmccAgK15MzzIJUKk6SyyD0jZvCWrsKx0acysbZzsQovDWqEvgjQDe+MYmjI1oPRyqjI9Ewa/06xIvyDSj4l0sPET7sdOv9Syk2cYv96iTsZpF/N7wjmhiE5AhUFuABI8zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(11063799003)(3023799003)(4143699003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkh2aWVTMnA2R09oQXRsWXliWmRyVHlYSWViczQvRTJVRDEzQXR3aVFyR3Rn?=
 =?utf-8?B?ZDg4ZTRyNzFNMDRRZlVjZERjYmp4TGhYWHlxUjU2TEdhSFFXS0hacU1GMk1r?=
 =?utf-8?B?T0hqTjdnS3NpU3R0VWd6Nys2SXR0dE5KT3dKaVRLbkdwdUJTamp3Zy9icFRS?=
 =?utf-8?B?YkRvN0xwdS95bGlsSldoSnFqZlZraGN6VXF0Vm42eVRSTmxWVFdManN1SzJK?=
 =?utf-8?B?cnpQNllnZkFaWkVGVjhhemJsVG1KaVBzRk9BNElGa2JDZVRZU2NWYmFzNjVt?=
 =?utf-8?B?SHpKNjZYTlhSOWxGcllLcW9vdThXeTlsTldSRDNtdGJ2RnFlaDNHOVRuWWdR?=
 =?utf-8?B?dUxWUGs2UDBGOXQ0RVNrd0hENlpQQTNVSTlFalZsUjFTV1Rza3pXUkdNTEtq?=
 =?utf-8?B?UHNSOWRBSVNjYVlhdmRWVHpVdWxQdHVIcDIvZjlEQ0JQemp1aUM1VXVoT3ZC?=
 =?utf-8?B?STRYKzROUXpBeWhlSDRpZHNzYVRhcmo5bkFNZ1lxanZrS1ZyU2VEbER0c1Ir?=
 =?utf-8?B?QU5tT2VGR2hjT0Q2ZHY1QlhPMDBXT2hqTjFNOVlFUWdwRTgwUUNCalhVS2dL?=
 =?utf-8?B?cVlicFNUbVhQbTYrK2c2bE8za2F1WlloRDV0NkdOSTlMWGZPSkZsaW5qS2pk?=
 =?utf-8?B?NXlkVFVqTXFMNGhsRmw3WkJDRUNpOW9TTUlBMk1KTVJMUU5JdHlNZ2FyYUFh?=
 =?utf-8?B?YkFYNzBTdnNnbzV2S01hempzd2VQd0I2bWovazVZN2tqNSt1T2JoeUhzYnRT?=
 =?utf-8?B?UTU2dlFtdHRnY1Qwa0NKTVdpUGNSV2x0Mk04alRIZFQxTTF0VlJuTlpkZXpk?=
 =?utf-8?B?bEh1MUVsU1A4cXBnSG0zbGJ1OTlJRlhvRjZSbkZsVUNrMnpsN0FHRjY3dHVF?=
 =?utf-8?B?RWFTWFhVRWVVZXVybzU0cTZmdFlNRWlJTjZtT3lld1VIZ3ZuQW8zTXFOU3lF?=
 =?utf-8?B?YWFuQllNc3JRY2NJdjROUTFXOU9ZZkN1U0Flb0lseDZwb1RPTWlYQ0VjRGF2?=
 =?utf-8?B?SjlwcXQxMVhuSzRsbis3ZlBMUm1QMXRkU0VwV3pxdjBMR3dHZGJqNHZMRzJu?=
 =?utf-8?B?YUNmZ1FCMUhhVGtmTHpoUUtCNDUraURIYXVMUEdOKyt3Q0h0WC9mVGl5VzVl?=
 =?utf-8?B?WkNKWGwzSlBHL0d0MmlWalVCRXYwdFhubHNHbnlMWUNZcnZqWW9MZDEwTUdT?=
 =?utf-8?B?NlEwSDRVSU5PN1N4aTN4NzJjQXNEUVN2WUpPOHJMR21DaENzelJldjJmTmwy?=
 =?utf-8?B?SFJwOHlyMEIyQ09vVm9EQUdydnU0ZXp3U2oyc08xQVBrYjlDcVBUa0hqRWNT?=
 =?utf-8?B?L2JkNnQvTnRVS2l1MHYxUE5saFN5U3hjc1oySzlpYmFpekRlVWRLMVJCcktq?=
 =?utf-8?B?SnZ5WnpwN3J6QjhtamxMRUZaVnhGMzdVK2ttb1l6RHJWL0k1VGhSbTdwMzhV?=
 =?utf-8?B?cnBIS2hRcVJkVnNaK2pzeW1BR3BESlhDWEdHWEh1SWRIR3F2RUJsOG9mZXhY?=
 =?utf-8?B?V1ZEaEVZakNGSDJGNVZzUkR1aTA2RVI2Z1JqSzI2Q0hUbFJXOTVIUEQ4b1FT?=
 =?utf-8?B?eHlUSnpiL3owOUUyZWdiRDE1dFl1Vk9hY3JZZG0xOHRrUFl4WWxMZ0xwSS91?=
 =?utf-8?B?aUdVZ2RBVWVEN05OM2lDd3AwUDlraHh3emdWT3Jac1R6QWFGZkNPdThpWHN0?=
 =?utf-8?B?c0FGSk1adjZlc3pYVjloalBRUTN2bjFQTy9TdFFWTzNzVHFKZW1LbGpnM1Za?=
 =?utf-8?B?UlA3dElhMFFUc2RaMkQ3SHlNRDRxTTVZQ0VzQlZNYzhtVmxYN2c2M2ZjaVBF?=
 =?utf-8?B?N1dHb1JhZXl3QVBzYzR1amlLRDlDUnhZVzZpdnFiVzBIYmV1bzgyTW93TDNr?=
 =?utf-8?B?ZVZidC8weDN2N3hJUTZZT0x6SytkeXUrOW9zUmR1Vk05dmtPRUxQcUtIRjhM?=
 =?utf-8?B?WEJ1R0JsVXZiTExtV2dicHZjUnJwUEwzcENtZzhhblJMZ2k2Nmd5VU1LenlF?=
 =?utf-8?B?MHZnOHN6Skd2NXJOR3JZTngvdVQ0Q2RLMFd2RDdoUHBrUUVuV2p6TFhWWlBR?=
 =?utf-8?B?ZnFPWkI3T1hTMVVYVlYxZDU4bjJ5NkdEZ1NiWEpMbGFLZE1sZEszWkFST3Vl?=
 =?utf-8?B?ZlBUdkdjRmpjYUsyWHBTVFN0RDBuaUUyckxLaVFvaGVQNWlBSlFObTFyV09B?=
 =?utf-8?B?NWlCVUs3VDJ4R3BFOE94L1NWb2pqZTRQZG51cW9aSEhHN0RZaDBvNFprcnFP?=
 =?utf-8?B?c3Q1aCthQm9PMXViZ082bm4xUWdScGNmSlhwTUdyUm55VXNUWEtKVFpncTNO?=
 =?utf-8?B?b2JUMnpnNGxHTnYzeW0xSUN3VG9IY3lUVEJmRnZlRWp6MmFZZW9id1o3NUVF?=
 =?utf-8?Q?/QtDskPJ71MKW8to=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e338ec-3d13-4644-b09c-08deb4f78693
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 16:07:14.2397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZLCyMQdoz02kbqqg/o2+p7quWzy8TslA5zIU81BdzWifVFz4WCFRjb9/BgZjgAD6vxfFbruH2SFmUgDt9A5eXCCe4eyDJrPpPGfR1rbUWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR10MB9725
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

On 5/15/26 15:41, Simon Glass wrote:
> Hi Ludwig,
> 
> On 2026-05-13T14:08:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> 
>> The tests were created with the help of copilot and manual fixups. I
>> have to admit that the log output of those tests is not something I can
>> grok. I've left the tags copilot added in the commits even though
>> checkpatch complains. Not sure what the policy is.
> 
> Thanks for being upfront. For my work I have adjusted patman to drop these tags.
> 
> The "log output I can't grok" part worries me more than the tag. If
> you can't follow what the test is exercising, neither can the next
> person debugging a failure :-)

Meanwhile I got it. The AI helped me to get started.
Anyway, here is what confused me. Suppose we introduce a small typo:
-                      'No signature node found', False)
+                      'No signature node fond', False)

Then run
$ test/py/test.py --bd sandbox "$@" -k 'test_vboot -vvx

You'll get a dump of all kinds of irrelevant things like openssl key 
generation or u-boot startup. Then finally:

FAILED 
test/py/tests/test_vboot.py::test_vboot[sha1-basic-sha1--None-False-True-False-False] 
- assert 'No signature node fond' in "1769 bytes read in 0 msWorking FDT 
set to 100image_pre_load_sig_setup() INFO: no info for image pre-load 
sig check\r\r\n## Loading kernel (any) from FIT Image at 00000100 
...\r\r\n   Using 'conf-1' configuration\r\r\n   Verifying Hash 
Integrity ... fit_config_verify_required_keys() No signature node found: 
FDT_ERR_NOTFOUND\r\r\nBad Data Hash\r\r\nERROR -2: No such file or 
directory: can't get kernel image!"
  +  where "1769 bytes read in 0 msWorking FDT set to 
100image_pre_load_sig_setup() INFO: no info for image pre-load sig 
check\r\r\n## Loading kernel (any) from FIT Image at 00000100 ...\r\r\n 
  Using 'conf-1' configuration\r\r\n   Verifying Hash Integrity ... 
fit_config_verify_required_keys() No signature node found: 
FDT_ERR_NOTFOUND\r\r\nBad Data Hash\r\r\nERROR -2: No such file or 
directory: can't get kernel image!" = <built-in method join of str 
object at 0xa46de8>(['1769 bytes read in 0 ms', 'Working FDT set to 
100', "image_pre_load_sig_setup() INFO: no info for image pre-load sig 
check\r\r\n## Loading kernel (any) from FIT Image at 00000100 ...\r\r\n 
  Using 'conf-1' configuration\r\r\n   Verifying Hash Integrity ... 
fit_config_verify_required_keys() No signature node found: 
FDT_ERR_NOTFOUND\r\r\nBad Data Hash\r\r\nERROR -2: No such file or 
directory: can't get kernel image!"])
  +    where <built-in method join of str object at 0xa46de8> = ''.join

To my untrained eyes that just looks like a lot of garbage :-)
To find the failing line of code you have to scroll back to the actual 
backtrace. Now in this example it's kind of easy as we know what we 
broke. If u-boot produces different output for some reason (like my 
patches) I found it really hard to spot what's wrong in all the noise.

The parametrized test_vboot function doesn't make it easier either, esp 
since some of the parameters select an entirely different set of tests 
(test_global_sign/test_required_key/test_with_algo).

The ubman.log.* calls would explain some context and progress but are 
not in the console, only in the html. The HTML could be more useful due 
to the structuring but isn't as the distracting stuff is on the same 
level as the actual tests. All output leading up to the failure gets 
displayed by the js but the relevant output that is actually looked at 
by assert() is in just one line.

Last but not least even if the presentation of all this information was 
improved, there's still some information about the good case missing. Ie 
what did the output look like when the test was written?

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
