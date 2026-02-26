Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0A6FD8FC6
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 15:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E662083EB3;
	Thu, 26 Feb 2026 16:15:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AF/vnFal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B4AE83EC9; Thu, 26 Feb 2026 16:15:17 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D718B83E83
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 16:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2HcSOmj/vtSF6SOe/Gh0Aaz7ibKc25ZX8M0EZiYwAZj7Gd69UfNmu5FHdvaKA9T4Gm94K3kmtttw+e+Gm8CpFzJ35DPb5a8+X0oiXi9guho4IB3JbH6QHq5i7pcRsWRYAdHQ9xjd2WKvhQKUqavsbVEH+Ww3Wutmnf+iK01d4cKzAjV5sCRawI2mX+BTt1Z43odhwajgebf7ac1iIJaCvD4yLEnStAZcOvCTZnHrZU6WBi4lXeIDLqXTJdodAQ87UeQQmSNrTXpyrl6a+VDyQNH96o9H93+zTEG9PYnyzPx3dgh1fmtWMWDjVo2hF6aFTnJsPVwDqTuLgvRQoj9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUTAU1Rj1Or01b5iX5I8RDGwTZY7wU4rZTB1ico+gtc=;
 b=V8XHD+peFs90zhvGOaSfczFbUwh/X9yTtYi1tq0Rjf77KtvHp346g7krkJNWi4q4t8xpAHlEqb1n+ApB8ffkI3PZ5EkgR1Incf30NrLIVqsaNCpIOI7K9Y4holNJ9ctX40BHgufUZQb4ZSFEOw70CD5H7r0TvBNRTrm/pCOQndlw8OI5CYOJQe03mJol5g41rSQTiix5G8yxrwnKBvGfosmgPb5KSzMAUhgW9KlAVS/px9LJ6yJM5XflQRvdGnbg6pc/70nsd16RXvjEo5fl6EBQNMgPUU9JCh5bUbyJPflBmtSH+M1Y4DnvB/BMeh+wn4uGoUVmf8Dpe2/HE2ogvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUTAU1Rj1Or01b5iX5I8RDGwTZY7wU4rZTB1ico+gtc=;
 b=AF/vnFalGLNDtmD+j1X6ZhdN6loyw77aceNmvQr1Khl2xDvBP8B7kHWTKLdVqjl+YBPzMZtjDCLtmKMg3835NfrQdSO9dajOmRRt7/JPPpCoOsBN9+5Wbriual8MWkLJg+Vg+M7JA1FJ94Nfb9n/7MPoZoFturFBDmRae+WYelY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by MRWPR04MB12096.eurprd04.prod.outlook.com (2603:10a6:501:98::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 15:15:12 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 15:15:11 +0000
Message-ID: <1279492c-5e93-4a89-8cfc-2d5e9c0e3ade@cherry.de>
Date: Thu, 26 Feb 2026 16:14:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scripts: add checkkconfigsymbols.py
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225131051.60535-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|MRWPR04MB12096:EE_
X-MS-Office365-Filtering-Correlation-Id: 736bd73c-b31e-41c9-af03-08de7549d616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: FcvIGsTgkV6CGscrP93Zcq85b8tM7CuA92qVUEuaP2vnM2XvXsGUrmH4nfJ3cZzDvwbvXOytt3p3CkvlDFl1sQfkJFpGRRA35dsKaflaUzqE7H3dq/d3QZw4fwNsIBO6Zu+d3ceHfGIXwHaWhj7BnVEUKo6Qy01p/brWN6tjdUyZtELb9fA4jXWZqVZdOjFihm8n269e5TwTLtnt8mAc6t/LDZsxTuAhZi6Qw2hExCNCeJP4kFsERM/wwW48orR6AQtDKMDe/fbTw9uZiwEVyCOKDxER/ZQhpHtQ03xNYej/4f3EEauwd1eHzRW3ILby3N3waOEKLLtk8oAvLmdDgtE2RkM/jnrl27e0iZMYECWo8EfBFJ4MVdVuWVxV/I3c6mkZ+qSC4CI3PQKT7MSala/DFkS/0B+fmrPb0an728FJrHvLLE30/LLXoZlhKqm3u1KeHWDizeEGAaPbAwBgXjoC+Lrwei2vVrU+m/GF9BKemBE274ubGpj1AQLLkn/WXBITeP6iI1dkCH86bvouiAry+VO9EyIjJIliWwjh9ndxVG4HTHQO2rlw67xqWqLvL/+4tJYw58XF/37qTsNra7KJj2ENr2VGz2JwdL7SqbqbR0KriisnR1GZa3wbsZsFOEPm4hO3yzmmv1Kb84VdgJkSw9ilzrLQaU6G1BOYJUseVmI2m0+fVYmkGbimSqAP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TSs5RzZmUlZxL1ZUVC9hTCszbkVEckp6K0hMbGpHOFJDWTZ4NkxYenZ6Y1lh?=
 =?utf-8?B?cGZEczI0Vlg5Tnh0cmtUS3NRQjNVSUZYa2ZtcGNScFdqcTNTdUF3MUJ1MUlE?=
 =?utf-8?B?Qm1DYjgzbGhONVhqTFpYbnc0bW5maHplcCtaUFBTVzVmWloxZ1o3VHhXY3pP?=
 =?utf-8?B?MXFtTHZ3bk9hMGpnREFPL3duTXo4OEVya3psOXdQVUVSQTYyZGxsV3BsMldZ?=
 =?utf-8?B?RzZ4TEp1Nm5hN0tQRVJveWdydnV6Z1JLODBMbDFkWENIV3VCcGFKblBHVXRI?=
 =?utf-8?B?dEZzaXB3MEwwaWR3eHV3MDduSkNMY04veGJYRHRjMS9JRW5keGJIek81RjZj?=
 =?utf-8?B?L25SVXpucUorUzVudVl1ZGxCUWUwREZhTzN2cFdWNzlpV0JKZ0Jlb3VmeFJC?=
 =?utf-8?B?S2o3QkJzN0wwS2NRMjlBeTIxSThYV0xybTVScTloWHIrd2w2UlYvcmd4QnJp?=
 =?utf-8?B?M292eXd2RjZPdHpZK2ZaSW9XeWZEWnQwdmxpTFRRMEJ4Z0hraG5rVWltZWMw?=
 =?utf-8?B?WHZaTjZzbmIwWnk3aTBKSVVzbkU2TFAzdUFMdFpxN1I5b2F6R2t0SHB4UWlC?=
 =?utf-8?B?dm9UN3dsbHpzMFNUOWJCWnYxTWlPVThNSjJadmdsbWI1UGlnSFVkdWdEUmNU?=
 =?utf-8?B?T1puOVZ4a3RuSlBqa2dkOE9VcFZVYnl4cjJBQ0Z5djJWbERLVFcwMTRuN2N2?=
 =?utf-8?B?Ui92ZjJjWVh3d29FT003ano2OUhsSUlqUDNzYzVIRy9ReW5mM0hsN0xZK1hV?=
 =?utf-8?B?QndzVFl1TjFHVElQc2ZUUnYzTEpndVVKR2UyeXRhUVlnaEx6RTBlcjlSQk5X?=
 =?utf-8?B?N2IxQ3R6Y04vLzd1Y0d0Wm5HZ1Rram5Id0l5ZDJweXdaTll0Q09JZjRQWi85?=
 =?utf-8?B?VVEzUkt5WHBlQTA0RGdHQmhvUlUwZU5ETDg4bEYrOWVrV1VFRHNMNzFiUHph?=
 =?utf-8?B?SXZmdEtLaXdyWUJ4dkhqOHhjYU1kM1FLd2hCM3IxN1gyQ2JONUx2RzhpSlFM?=
 =?utf-8?B?ZnNQbHIrQUhpd0g0SmlRbkhKYTArRzNjb2dHNTViZjk4bmQwV0kyczRQZnRm?=
 =?utf-8?B?MHRWU1NQMmhDaUtXMTY1MkdxanBGK0V2RkNuejNVaXJ2SzhubTNieHVHSG5M?=
 =?utf-8?B?NGhDcS8vWU5xcVRWYVlGQTBmVmYycDhDTERlaWVrNEhTOWxtaEtiMDdZSlly?=
 =?utf-8?B?Mk50NERlTnhtcW0xOGN6aHd3aWJtb2NScGNBK3FnQzd3dHdTZ1BxTXdDOUpi?=
 =?utf-8?B?ZkVuN0JlTVZCMDFoTDdlU2FyVmY3TlBmbGpRWTVFRDZuN1M2K1dGK3NBcVhG?=
 =?utf-8?B?dnVIa2NyL3piNWhhdFhxZU1wTndrSkt3QnhpbmFtWCtnVStnbEJjMXFDaDlo?=
 =?utf-8?B?SXlhakFERFNnQzdTWFY3MlFNbUNmZ0syR2c2NlBvek1zVFNDeitQd1R5QXYv?=
 =?utf-8?B?QmljeFdjV3BrQWJFSjUvbExLdk45U2R5YkhXbGxLN1hTNlEwVng0TEhWa1ZX?=
 =?utf-8?B?Z3RhTkFZcUM2SFlLNHV0eVB0VmVLeGY5U0pjRlRYOVNjZVVSb1lFenV2djRO?=
 =?utf-8?B?SlhvU1BvcEZFUjVXZEJadWplbUFQOHU3azZZVTZ4WGFmelFDNWxEZlpkTjhN?=
 =?utf-8?B?M0R1eWgzVWlSOFNHU2RDOUFtN0hvNUxrMlJoQnQ0ekZ0M1BPNzJEY2NPWEJl?=
 =?utf-8?B?M2NXUWVuR3hLRmsrTENJTk4wcjFUVW9la05hUjhNVC94UDRGTXM2WFFaa0Jl?=
 =?utf-8?B?WHlob1NmRC9tK3E5N3QxZlZZSEVMU3hFU3ByYndNOHgwMDRYWHpGV1ZKck14?=
 =?utf-8?B?QWpVcGMzd0phbGdKUHJXbmFqVlB6MTZQMEQyckJ6UG1vcm5SS1MyKzdDSGZh?=
 =?utf-8?B?N0haZHRkNjVYTlYyQXhmV3ovbXRkRnNLWm11NGJjNTE4Nys5V0tWOWtLZ21F?=
 =?utf-8?B?bmRuM0V5bFFOOWtRRGtTdUFQMTdKMnExYWV3aER2S1MzeUZZOVFXZEZVWlZQ?=
 =?utf-8?B?MGgyMHBSaDdsZUNvbXJPR1FqOWlBZW1PdXM1VmVWZWdTTzhLZDFCRlpCR2tS?=
 =?utf-8?B?b0VKdUhqcCtEcTFNWlBYVUtXRmNqZ3ZwY25lU3ZnUGNhTHNoMytJVjZtcGQr?=
 =?utf-8?B?WkZ6MXdadVVmMFBwZk03b21BbmJFSGdwcnBNUkdIaGpmNDNoek55ZTMvRFJn?=
 =?utf-8?B?eVFwZkk1MVhlT3RFMGZQalM5aFQvL0czQW5wcWlSSjRkYWJmOTkrUVZpQ3Ja?=
 =?utf-8?B?bjhjYnZxMzFJcFZvTEFFbjR1SHh5WitkMmg2M1lKOGVVQWVET0hncHpXVGJk?=
 =?utf-8?B?MVNuTWNNbndqYlpQdzhabWhYVmxLTmJVZFdiT1VkdTR2OC9ZT3Rtdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 736bd73c-b31e-41c9-af03-08de7549d616
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 15:15:11.8982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo6ykj6xC/ouPYj2+hFkKRFmeu8UImOVvOWWZDzH1tfnPhDhoJKkdIFhrerPBFdZ9ji9DuVeKfTZnTjOa4CPc2GEUZzbHPPNVVkZc+H36jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12096
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

Hi Heinrich,

On 2/25/26 2:10 PM, Heinrich Schuchardt wrote:
> Add checkkconfigsymbols.py from Linux 7.0-rc1 (unchanged since v6.2).
> This tool allows to identify the usage of symbols that are not defined
> in Kconfig.
> 

I'm wondering if a good next step wouldn't be to require users to run it 
as well as checkpatch before submitting patches?

We can take our time to fix the current codebase but making sure none 
gets introduced is necessary otherwise we'll be chasing a clean codebase 
forever. And I think this could also catch sneaky merge order issues, 
e.g. someone adds support for a new board before/while the symbol is 
removed/renamed.

We should be able to enforce both checkpatch and checkkconfigsymbols.py 
to be run with b4 prep --check (and b4 am/shazam --check), see 
https://b4.docs.kernel.org/en/latest/config.html#term-b4.prep-perpatch-check-cmd 
and 
https://b4.docs.kernel.org/en/latest/config.html#term-b4.am-perpatch-check-cmd

However, I don't think this script is ready to be used with b4. As far 
as I understood it, b4 sends the patch to the tool's stdin, so we'd need 
to add support for such a thing.

> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Imported the script from v7.0-rc1, same as the one in this patch, thus:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
