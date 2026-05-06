Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65750CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 11:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 840A584897;
	Wed,  6 May 2026 13:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="cUT8nf9X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E52F3848A1; Wed,  6 May 2026 13:47:37 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10E048488B
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 13:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AF+ZtQ6g1Xig+6Rnfi9g+GKi/SYC1SbkuJUePGEfSJ6rW4IVdjeE9KVk0uVjsBiRxWB4jHJTsENhVU5BUVR1TiAeDDrofmMyyNV9tMdz1I/I8pybTd/7G89U0q22b3Jn3f8Exm06l2whOwrqDKe8Tm6fLqPjZGWCiQOqhjtnTBeupfRnzjj5dRZr4DeQ1l/L3oPw3DStr/SUDBgzMSsOduN011P92WdSa5jUcSTH73D7u1GvC2SnOU9gTOM8it5uJ1SVVjWygiFZC549VpvWiVXFjobbXifmUg3ieeTWGNTd2Ed9tGDBrrE8QMvMGCRi2kcYneN9YdQpU+d0Nk69Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRC5c2TNUehKm/6jCGZCZ4d/BDXyBfROjb+iJCjVMD4=;
 b=PPrtRQyp8jRfa5fPCSmFJ6oyl7INRxjvvHMQ1bd7RFEzM0eLgamvT3fdbO3TBKf9XJfI+IJfC/Ao99f+Xin7qvfBMBDZQeRCO3d8a6uoSvYUM+TbidVjmutiGTwBbMYi/RtyNeAeZYIqKgevmI0vrqInLbuYWopM7qFShytbZmhrmjhpKPz2CkOTq1V4ON1t+DqNX6xOs0Vn5YuhGtriYS5zTXgPmr7XnBqOGVUoqjndRlKaRrL3BojNFkH49+piZlV5q+Ce4qM4NJelHFVW1XaJ791pmDcCJcnM3XuIf+y1kCBecT0TMnAPwumFhrxxYUwhsh8rJ0PKhEcMM5phHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRC5c2TNUehKm/6jCGZCZ4d/BDXyBfROjb+iJCjVMD4=;
 b=cUT8nf9XgOMSGjWPGZo2R+3QZjM/Yoiq3w7ZX6QbliCFbUiv+VrZLvEU+/hnVp2QmLxUa7+EATAZTMkG519hKj9Jh1/RGNvmK+Wc9GM8xfWeyblc79XSD1mmoPzxmaOZXdgqtIZtISeBg2wFCugU/sFqSb+dm5Kms91c9fvt40bsbvc0eZ287zGB/NDatTUJmgok/Spo+PyAFHC66fr0TUT9IWAcn4vqn1ow8xQh/4ixyEmyxlIf4igZwxDx9hgMxYV+dghb+1JNx3rxwb9IGoO6zOONB/QMiL5HpK6tVJhQMk5nqgeeso+wo3UGtaMqMO0uu8Banu0oU8TRHn5spg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by DB9PR10MB7929.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:300::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 11:47:32 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%7]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 11:47:31 +0000
Message-ID: <dd5dc055-dd57-4d1e-b155-5c254f2d20a5@siemens.com>
Date: Wed, 6 May 2026 13:47:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] patman: fix use in worktree
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260429141850.1.6f48ecca7f833b4f4b90ba78432475de1461e838@changeid>
 <CAFLszThHeODorsKtPCqFYmfSPuCJNGMTvdtUQ10yiHRhJnuCPA@mail.gmail.com>
 <449bbab5-3451-4034-a643-771d9ddb0567@siemens.com>
 <CAFLszTif8nRi8MGVmgj0hwbkCm+P3YV1trfvuVU7XxwiDAOeLw@mail.gmail.com>
Content-Language: en-US
From: Ludwig Nussel <ludwig.nussel@siemens.com>
In-Reply-To: <CAFLszTif8nRi8MGVmgj0hwbkCm+P3YV1trfvuVU7XxwiDAOeLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0084.eurprd05.prod.outlook.com
 (2603:10a6:20b:499::24) To DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB5019:EE_|DB9PR10MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d0d91d-afd8-41dc-e18d-08deab6541b0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cq9p24T2owfwv6lByXreYUJ4u0e7Dyl8MmBbIegjdFkU+yHPJIYvZgEyVPNdaoAOTtRvvxAjHwRIbpMJiRJSXy4rHzahPkNbuZHMup7dVB+5FZS+vedqFE3PvzdUU6FI49OUttTHuMxkJBOt1dCF0vulS13whjkcolVf0SKPbhg9E2eGK2x0ef2/820aGLUTQmXaN9aGv2QrMWsSDF+0Gp3/ewTsxmyu7z7w0FNYU0BATecANHjluEuVoVVLBG2TVIMDaNgDnWfd47yWKKUhxXsuh3W3AMRp+dTPxJnRM8v4CrzfyH+iTVT4mf7c0Y/g/rE9tHou2vYBUcywQqvYvhc3ApBdKC5Dr+bQrYn/5Ho3+chhEypuLlHv8ZVPKjalgr/FmV+r2NzlsmcKGCxfoQ5Qe/6F2mD1kTmrvx0azOxwvLCV+h+84uyZtgVfs1bTV9CXqBmZWIr9iorYrqzK6hijYbOyiITvVm9VcSjjh8aiCE5K9zobUkb5V9cHSDBQtPZNDma8UhEPjyb4gdZ/qcsOUFl+C1ov7qS+ccFnqU5AbVVAiTVfah380Zxc5Ya4It5mYfE4UkuIHKKUZOuFLnkzzzqYhSsbUhLt8FQw3UqH+Ylbqrzr9nRIsP2aAdr/lm3D9XtRpfuAmKCDhFk47A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdKNng4ZEszSDVYRGZXeGttS000VnRyL1RSb1BkWG1OWHpLS3N4UTR0Y1hw?=
 =?utf-8?B?c3V4UWF0SHYzZWsxMzlzU0ZKVG92enRCZEIyejVtak5tR1N3RnRUUkdxdGN2?=
 =?utf-8?B?WnZXY3BwSkVuTmdTLytrdGEycG9kcTBVL0pwbzhJUnFvZ1RnQzNvbmZ0N2pl?=
 =?utf-8?B?bExRMzYyQjhEbGN6eHY2ZTMrZjg4T0NVL1QrRmFNRy9iOTNIbm5ZVVgrWU5E?=
 =?utf-8?B?d0VvVnY2bXpueXJjUHlPK3ppZ2ppYnlONVo5bXBuT3g1dWNWZjU2R3ZHenpK?=
 =?utf-8?B?cmZrazhPUWpvcDUxYXFZSEFvQTlhUDVzZXp3WVBFTldxNDNzRnRFTlhsdUlY?=
 =?utf-8?B?dkg0bnlhMHhpZHdxcUsxK0lHWmgvME9VWmppQmZaWjdaeWFYTC9lZ1ZmdzBr?=
 =?utf-8?B?Q0Fja2hNSG9Za3dWajZXb3UvN1VTYVcvOTdxMWhjRlFHVVdpVUM3TWhkcHE3?=
 =?utf-8?B?SmlGeVBOU09WWCsxMWJKYUFrMmpyM1VyRjZBWFIxdS8yUG05aFFXTnlxWmh0?=
 =?utf-8?B?RlRjekJQckNqcWE0QUtJMmFINzhjY0VtcHREQnJqR1hKeFkyVURsTE1MTmxm?=
 =?utf-8?B?aE5Galh2K1RqSzA2cWRRUkNOYzVhUGdzeU0rRFNFOGZ5VDN6clh1YlhXdU1z?=
 =?utf-8?B?YldXWDc2YzlSZ1hMWG55c0gxKzBXcjE4Rk83RGt1ZCswMzNhNnlyNEFxRWVr?=
 =?utf-8?B?aVYyQ0RxYVVzdXhzQlB3bnBOVTVEQ3E1STBlREY0QmVKK3RVTzVjUDFkbUJs?=
 =?utf-8?B?bzBtNG81c0lDZjdFQmtjZ2lxckRycHZob0hNZHFqcTBNQ3BNRjNWSHhGbnBK?=
 =?utf-8?B?OFJtMmFKS3NtUUhlQnhkY1lXRnBmRGpGdlhDNXk4dTkvZ0lkVDZrUjhKTTRH?=
 =?utf-8?B?b3l6d1Q1Wk1sWUJaNDRhRzFqblMyRXdabEIvVUZNK2NOc0YvblBoL2pwblp4?=
 =?utf-8?B?MDNLTWg1VEZYMjVOSlpwbVgxKzZjZ0g3MWRKa3dwOVUzWWIxNDZSckhuUEty?=
 =?utf-8?B?dzJrQWpENVhYc1hPWFhkS3V2NE1xODN5cHByM1lKUnFvSzhGWXQ5Qkxhamlz?=
 =?utf-8?B?V0ZLakFqWUxQMmlBTUJzOHNtc3NIbm1IOHltZ01KUUl6OStsOERxRHA4REJN?=
 =?utf-8?B?VEtBdEw2dk5ibEtJdHV5Qi9zWlNQUGlDZ0l5Vk9uYjF1Snlobit5QjFGVU5r?=
 =?utf-8?B?aDU0UFRSb2VMM2lqTjNvbHVYVDZVNzRMa2N2Mms4b0NtWnVQblJzVStFbE9T?=
 =?utf-8?B?ZFM4QWN0N0dPbGwyc1NLSENDMUhxcXdTU2pOM09pdGJ6am1LSDhqUlF3QjVn?=
 =?utf-8?B?ZWhBZmdpWWtsMXViK1dmWUE1aDBWdGpsRWNRbHd0K09QZkJNSXJXNitPRUhM?=
 =?utf-8?B?TExvOHJRc01jbFVZNjZad0NkTXViTndzTmxZWXJkTVVyOGUxd1dWMVZEc0Fu?=
 =?utf-8?B?OUN5d0hUTC9xU3hjZE9VelhzdWlpWlkzaVEweUVoUjNsTytJWFNOT01ySUF4?=
 =?utf-8?B?d25hRTRWamZvamlkOUZkc1FyaWdTdkV4OFI1Z3RyaXNVcVQwNmRaTTdQaXI4?=
 =?utf-8?B?aUxXNU5sWVhZNm8xYjhwVUgwTTJ5c3NpbytqVngwaFBFbkNmeFhvSE5PYVJM?=
 =?utf-8?B?MmVlVXlyQkRQSnBLbXFEYkNCRWJBOFhHQ2F3NUh2UER1d1BrZHVpMEFtV1dP?=
 =?utf-8?B?dmR3eVZ6QjdxejVDbytxTmtENHhqeWxySFRsR042Nk92Qm1FaGtmMTF5TGxW?=
 =?utf-8?B?eXJBb1RFV3dkeDhlc25mSWhMK1VIYXh3emlnazQ2NDdsWTU2aW5sbkkycnJB?=
 =?utf-8?B?Y1RpOXcrbGNVVU5RQXNqcjRrQ1IwWUJZR2lDcWtOUXVsbkxubENHdEE0cENW?=
 =?utf-8?B?dU5OTDVaeG9wN1gweHVUSHhqbStBbVkrcVRjYjdhdGZwQlVRYXdrZkxaMWt3?=
 =?utf-8?B?c3hoVzcwNCtxMFVoaHNUMDBaNzI0bE93VDBqeXUybVUzWVcyeHR5UGRVOEEy?=
 =?utf-8?B?L1BVVTJHTXhKYTQva08ya05xclBUMzJDMkxjcmFtSTdWTERJa1JkREVnN2h5?=
 =?utf-8?B?SXBWcldHWS9SQVorS3RVZXJHTkk0dFl0aU9FSEdHbWJnZkFleno5N2ZOQTVV?=
 =?utf-8?B?RmoyN0ZVTW80VkY0Y3dpaFV1YW5kb2ZHdStNK0FFUGZpNFo4WFo5ZlVPcGhu?=
 =?utf-8?B?Yndtc2FqRjdEWjZJb2RJb1ZXbFE0TVhYVVdybnM5R2tZaW9ZdGZwQjhjRnYy?=
 =?utf-8?B?V3U3OWFrZEVnbUNUSUUvckJDQVl6REF1d01PRnh5M3pDWWV5S1ZSUmEvanhZ?=
 =?utf-8?B?cEw4SGx5emtCdkc0U2tTTmlSKzQxVUxhdUg5czhPK1dTZkM3cHVlZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d0d91d-afd8-41dc-e18d-08deab6541b0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 11:47:31.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0pKNd/1sqDEp9G+6sWAU2SAfDYJ73uAgwX1N6pnXeXap0WerEjWL3wufcg068nL8P/Or2VSRiGv1LF6a7ebwlb8R0rXmK/y+BlX60AK1CU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7929
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

On 5/5/26 16:01, Simon Glass wrote:
> Hi Ludwig,
> 
> On Tue, 5 May 2026 at 02:25, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>
>> On 5/4/26 14:31, Simon Glass wrote:
>>> On 2026-04-29T12:18:51, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>>>> patman: fix use in worktree
>>>>
>>>> When using a worktree '.git' actually is a file and pygit2
>>>> init_repository() does not like that. The intention is not to create
>>>> a new git repo anyway so use normal constructor instead of
>>>> init_repository().
>>>>
>>>> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>>>>
>>>> tools/patman/cser_helper.py | 4 ++--
>>>>    tools/patman/cseries.py     | 6 +++---
>>>>    2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>>> diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
>>>> @@ -309,7 +309,7 @@ class CseriesHelper:
>>>>            self._copy_db_fields_to(series, ser)
>>>>            msg = None
>>>>            if end:
>>>> -            repo = pygit2.init_repository(self.gitdir)
>>>> +            repo = pygit2.Repository(self.gitdir)
>>>
>>> Thanks for tracking this down.
>>>
>>> There are more init_repository(self.gitdir) call sites have landed in
>>> cser_helper.py and cseries.py - please can you convert those too,
>>> otherwise the worktree case will still be broken on those paths.
>>
>> In which branch? In master I can only see init_repository() references
>> in tests.
> 
> This is in the master branch at http:...
> 
> $ git grep init_repos
> tools/patman/cser_helper.py:            repo =
> pygit2.init_repository(self.gitdir)
> tools/patman/cser_helper.py:        repo = pygit2.init_repository(self.gitdir)
> tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)
> tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)
> tools/patman/cseries.py:        repo = pygit2.init_repository(self.gitdir)

The patch covers exactly those :-)

cu
Ludwig

-- 
Ludwig Nussel
Siemens AG
www.siemens.com
