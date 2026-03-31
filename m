Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27623109B477
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 14:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF28F83DA6;
	Tue, 31 Mar 2026 16:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1uxQ9lAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F5B83DA7; Tue, 31 Mar 2026 16:47:11 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D523C83A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 16:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svBme33/q6KxiQAGPdtLGg5WqHDiqIXp4TaJjwc2JtZLEO8PBQZDxFeGqw2Vq6WigQot2wdsGYWfwbZJtam1NRY26tGbbdKJ9fZmbXQrdRaUSsa60Y8X1MiycVc/2LVteKcEa4G1FeuItY4ilaZ6p9wyNlPAQWkh+2dSh3XLh+J9Gblg1ZBLVoGCx8hYjCk2GJgRM5BYPrPSszfwafqXis0glD3nOzoBNZfcVZgErG3niluXNKB5A/8UZlUXbz8rW6uVLlJLCkMwT59X2pQ6ddrp+r4NfjM/v6V0odtPtofjXUcirIKacdQtcy5jl9sY11hmJ1Vni0uGWB+a71i45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSFARlHh42rRs/7mqxGl6LMuSQUgpjEjvp5sKl1rYus=;
 b=wtHaH/NeuYMUoxFltTjGKdeBXTUpVSXthUwqma7mqpIaB4RW6fxsGQ+bV1f54GIUZKUNiiGCfmGBdwQPNUBENsGjw1RHnYhDI/AWgmHVQlZdiXRO8kUWIjHh3ksEx0cEEey6atO3HLSc+C+1rHFOuKEvf6b1FuKKMAyZ86o1ANP57w6k+fbiDuAagKW4zB4aK65RzsmedBL0WuUMB+9eYzFGqKiUirdHzJlujSasVItbjcHOAFS5nn+R40CIkfKkVKwEOSc4fNmda8IpNoyN+r+C0k8CWotq64LRCRjhzhElaIGPyC4WLC0DppR2KyC3zjZvAgxDPO61aImj0pb3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSFARlHh42rRs/7mqxGl6LMuSQUgpjEjvp5sKl1rYus=;
 b=1uxQ9lArsymegvprDmvRNUbthXaYJMlav6vZ9Z4nIWRdhepW/gI+y8mVVAZWknXOetBrPzH0dSuaG+LZq/9GDuZvinxTNleCNqVCagRqvnJzLOs4BwpBpqFsjlPl8eXNAaVlwvRhpU0g+Gw8Tr+MepYhFUp/v1SAFVXjj/8Id2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 14:47:01 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 14:47:01 +0000
Message-ID: <f82159b5-2e5d-4412-b946-e87d458e76fe@amd.com>
Date: Tue, 31 Mar 2026 16:46:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fwu: Call EFI stack initialization after preboot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@amd.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Yao Zi <me@ziyao.cc>
References: <cover.1773840306.git.michal.simek@amd.com>
 <20260331142806.GA1235458@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260331142806.GA1235458@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI5PEPF0000091E.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::92e) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bd3945-4731-4180-ebbb-08de8f345dcd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: T7uNoGSaK2JrvjmXM1vD+SeuDLG8Vf9AXOE2nJs4JCBSeClcC0WMKIfRfGfUbrfYUGrNXQ7WfEYETgN1vuheO4fJvyz8WDvbaTE8VxD53MBKBhuFxsBrhedVsOgTjfVGXab5E3hHU8Cg+JB625GDlVHUFmsGdUQqoCxomV3FVQCEKjsoBgDlgwkfPM3BzG8jgzMHSbGP0i26jydmoQFndx3QiMdPSC4f8g45OeJwWHtb5kXa3aibpUHOQRxvodQ3uz5zXyXYPwir+YssravrbSUrnoN+JOqLdMRmkYO8B4pHTqRjv4bakC9W489N4srHwFvotGLU4Pmx2ATk0b+QK7MLpMtFnYpUPkz+Nd2Rs8RzbotIybKXcvu889HmukNrQuHSNxdHL/RiLDFY9pX/o8taRY6LoHdIU/XzhBJU4dDEyBYTi2REIpGgH/VIdaKSzvME0wumsMBHOFYmRs/hp6KvHXwNL3YbPbJegt/BsSbnOMxtyp7wR251MFuBhKtL8NndMoWlyJz0byR0DH5zu8KyQWgZ8UhMFQRREN89UnCLk9FnxH6ljBocCBsx1eqN5Y0DtxH+VBWWNTOJtC13reCbevcmZw+dPximusBNpMdMtBJmYogmQNvLn+Mwdkgu2aIunAud+hBreu2mkQKfT4IiLHKPJke/M6gWu5a5mGXzLwGcAcJyBu9Qw8TM56nq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0xiSklTY2VxUHUvcFlmdGhBL0l6bnJkT0Qramx1cEZiU2R3eFp1R2wrZFZH?=
 =?utf-8?B?RVRkVHVTNU5RZkEyL2M0d1oyN0RnRDJZSnUyOEJyQU5kU3dkVEN4bVR3ZEpY?=
 =?utf-8?B?NE4rK3ZMa3FzZWk1a09WWHBGSFFhamtPUFZrbzJRN3B4VkppNWZ5dVBaODQ5?=
 =?utf-8?B?N3M0em5sakNkcXNCVXg5bTJDRzQxOUlhUzQrODBaT1YvclNROWpRZjlVeXU2?=
 =?utf-8?B?UXNtY1BRMXdFb25NUUFIaVI1RXdoa3UwakhVV2VUWHZLeFI4ZVZ0YWtDcno2?=
 =?utf-8?B?Ym5NYkZGL0x3dnZhWVZQNk14bmw5bXVnNjkwOXFNeWhURHpHSi9RNEYzNnJy?=
 =?utf-8?B?SmUzSk9wb2dTNHVOaG5GcjljZTlwTEdnVU5oMktwSDg5TitaS2lQMEJkMEhY?=
 =?utf-8?B?eGkwYzlQZXZoQVM0aS9RMURrSnpocm16QnEydGZ2SjB5MFV0ajVXbXZVdDJE?=
 =?utf-8?B?TmUyMlBLQ0treDRncndWeUtub21TaWdtMnJ4d2d3TkU3anRiWm1sNXJFUGVU?=
 =?utf-8?B?OU1NZ29sTjlHdFNJYjZLYTd6NmVLNGk4Y1FkdXlmdmczNTMveDVmSVJablBX?=
 =?utf-8?B?dHQ4NGZuSi9kV2R0djhudnJyOTFLcitXcHgyaWgvVVFNQ29wVlFZS0lLdFlt?=
 =?utf-8?B?QWtqUHBaY1FadHd1VTQ3N2lJK0p2ei8xaHR0OVh1TFY1a0wxQkI2ZUs3NnlS?=
 =?utf-8?B?d3ZZcXVFM1IvQ3RJMzJTeDdUUVBaVnlXUVl6aVhvdEJ2T2swZ0pLZXJsb0h1?=
 =?utf-8?B?L3ZCM0taejFRNkt3am8waHhkL0J2T3lQRXArQXFpUXBkbnh3T3FWSktoVVV3?=
 =?utf-8?B?V2I1c1h2a09pcDJwdWx2cHJoSVN5dExWWWhERHB3WENESDdMNVArL3lCWUU3?=
 =?utf-8?B?dDhFVTZSNWJvYS9tVEtweTFQVlhsNG9yUVVaWEdWU2Y4VUloZ2E1VFd3T2hz?=
 =?utf-8?B?cDVkL3IwbXloRnhaYUhzdXdJSHYxTnA5ZVUyVEQrR3dDTmtKRVpjYklreWFD?=
 =?utf-8?B?K3ZpVVhKVk9jSzJGc00wZW5JWHdFd2FDMERQaktTVlFMbm9xNkNKWTNYL1hM?=
 =?utf-8?B?Q21MekZ6K2dIM3RaNit4eGFtRTlmaWl4N2U3Sk51UmFzZDRRb1BZVWtoVEt4?=
 =?utf-8?B?Yk1vTjVmbHJzN25RdmYxNDdCdGozUmUrc0N3cDg1Q0MzbkdwZzBxUzcvajVK?=
 =?utf-8?B?emdaaHhUK1YzOUh0VktjaGVBNExLcHQ0MTNoRUo4NHhpYmc0K2pPeEtvQmgv?=
 =?utf-8?B?WnV3a0gyekV6a09kb1AwSEdEL041aDl4QWY1M3RTclo2cWc4TDkxUnZxRHhM?=
 =?utf-8?B?eEg2eTlUeEJaWi8xK3FGQnJ5aWttZG8xVU12ckNNOUZXYXJpbHFPS1hwRlJV?=
 =?utf-8?B?dk1sTWhUcVBuOURTYkJiR1FYRGU4eFdvR1RuODJEREZxT1k2a0xQZWU4RGJi?=
 =?utf-8?B?N3c2RFdWQzIvVm1PckJhbkFSMXJFa1dvNXZyY0pRRktkSFhNRk85c04yVEs1?=
 =?utf-8?B?Wk1vM0tRMHNHOXFkV1FxZmFwQ0R5Q2FWSzhQZnhWZklaMkJyMUN1TWIxaHJ6?=
 =?utf-8?B?dGw2a1A2L0t6S21Bb1Fib0xHVzM4UURBK0ZOczhmRFNqT1hPU2ZVdklKcVdy?=
 =?utf-8?B?TDcrWmdtcFNxUVJ6MWN6amRaZXpCQ1JWUUxNdWVSMnQyZy9taTVGTHpSbmZ3?=
 =?utf-8?B?US9YdUsyd0R4cVpjbHhSVHVNUWorV2IxR2lpa3hnM0xEdWIwTFdjRGg4VWVI?=
 =?utf-8?B?RmQzakFCNUwxTGM1SDZaUUg0STF4c295R09Pb0ZwMDZlSWZ4VXdDaHhpVC9Z?=
 =?utf-8?B?SFk3TU5MSVVjMEYrK3BySFpyOHA5WWdTNCtHeU55Zkh6QWZLZ2swbTNxZUMy?=
 =?utf-8?B?OWY1ZnpCdllrZGZLQUg5djc3SjF5ckhlRnNpQUpiWm9KN2pGRlIxL0Q5T04v?=
 =?utf-8?B?SytOemZYbjFSN0p5Qk1vbHVsZDJ0UTJJVXU1MmhHS2xOdTk5Rnk3SnJnK2Vx?=
 =?utf-8?B?bmNFeS8yMFlNZ3hrbEtpdkIzRm5iNHBpVTdtUGRBN2E0ckRwYnVwVkdmdzBw?=
 =?utf-8?B?aytqRDEwdDk4SEs4eVA2SHBycUxDbHM4R21GY1ZVeWIvL3dqalYzSnZSa1Q0?=
 =?utf-8?B?SU11T1FLT3pacUROVlViUlZJdC9WajFYNmFrOFRpd3dWNFZFR00xNWsraUxy?=
 =?utf-8?B?Y2hLQzVJbnhzdURJUGJJK2NKRVR6Slh1MDBzMFdaUmVraUpvdFJoT1hZUEdU?=
 =?utf-8?B?Zkp6SXhnNnF0TE5rNFhlS1dWenR2K3dWalFQRHNYZXo3UndHb216Y1V6SGl5?=
 =?utf-8?B?Sjk2WlNXSjFaTldPc3F0LzZVRVljMDM4Sk8wR0Z3UnZjaExaY0xXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bd3945-4731-4180-ebbb-08de8f345dcd
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:47:01.0318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: caNBGV8y+H8q5UDfJ3G6pe8a4k/JBpVOxs2E7Dkhta7CRwbqowsKIBa8FPT2a1FE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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



On 3/31/26 16:28, Tom Rini wrote:
> On Wed, Mar 18, 2026 at 02:25:08PM +0100, Michal Simek wrote:
> 
>> Hi,
>>
>> the whole series is trying to address issues we have on platforms where usb
>> and ufs init are not done before efi initialization. This is happenin on
>> platforms where A/B update is enabled. FWU code is called early and do EFI
>> initialization before usb and ufs started that's why they are not visible.
>>
>> We are workarounding it by starting usb/ufs from board file but this should
>> be more generic approach.
> 
> This doesn't build on current next:
> https://source.denx.de/u-boot/u-boot/-/jobs/1416493#L1001
> common/event.c:56:1: error: static assertion failed: "event type_name size"
>     56 | _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
>        | ^~~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:271: common/event.o] Error 1
> make[1]: *** [Makefile:2201: common] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 

I am able to replicate. Will send v3 with fixing this.

diff --git a/common/event.c b/common/event.c
index 8d7513eb10b6..936d5e36d691 100644
--- a/common/event.c
+++ b/common/event.c
@@ -49,6 +49,9 @@ const char *const type_name[] = {
         /* main loop events */
         "main_loop",

+       /* post preboot events */
+       "post preboot",
+
         /* livetree has been built */
         "of_live_init",
  };

Thanks,
Michal
