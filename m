Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B543CD4F5B
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 07:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEC588B1F;
	Thu,  5 Sep 2024 09:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0dF1aZHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D79C88B88; Thu,  5 Sep 2024 09:33:52 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0AF488AE7
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 09:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEQTxGmEZ/sVlcQ/sSuwzDKdJWKWuc2Pss8QFj/iVU9UPJ4eAWwndZnHhjx4CmDY0+01N1uiEyqLFLFzdXRzUX9d5ZSP92I9uV06sujTI7RYwWn3sJSOi10CzDa3PiF1zidFEXsR4JpzSOEBGtp6Q5J1op1hzY5r1JLuawKOicIIFlk86m63CoFTGxLoUvlNr88QoW7qw7BqXiVDIgr/kG+R1b9xPXBgHrZB2BaCbRCp9c+G67rY2BJ+0r50DRPX1Gcw/EyO+iXFsM1Ze5qtFdP09rTKYS4jQBA2LtF3GTmQZtPuFYfgOwlhh/a+HhW7RpgS4ThQw6o/l5ZAw1fT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJs9QFV0fYTtW9NQDbmyzoHXKhYrxPL7mzzK+M1jBLg=;
 b=eARBwwC+7m8PQyM2WelL5qLTT9DHyLfX7+AKatuKkhmBodjCPqyofIYzye3Ev9HJmxCNn3+3F7QkPqJUEk2TIizFp3rlCBnLyxOWHR4uphgDfTLxigpkLlUw6RDpa7mOHPIzUeVwZ7f+ySiiSfm7yAazxudr6YR4/cwjS0BsURg7PcJmiWCkq3kN6WJUAyIcbSrUyXH/rgc7AFlj9tTqEF/UCkEos1ZL1w2gY5OlglW6IF071sXi3EnykJWQ9WsU1dA/rmKy+r5Beqm8CR0pgs2/WJ/MRFYOd5L95MrLREiwn+1T4rBVwzjsSzgWviUZkmuaUc5dvwMoRAJ9JivJYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJs9QFV0fYTtW9NQDbmyzoHXKhYrxPL7mzzK+M1jBLg=;
 b=0dF1aZHMStMc9ZYNOtPituUK3mXK4DuXbR1Od/+Hto4dcGmDUEmOIa1SOJyC44xar9Ctq6HZVig+YfToJKwRNgMTjff0AxPmXbPJAwYlQCiokaf4vKV4PSGMSeOD0MooInw3eM+GSkh937FiqV90nNRpMICOT1n/AjNXcWbShF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 07:33:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:33:46 +0000
Message-ID: <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
Date: Thu, 5 Sep 2024 09:33:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 2571eb33-639e-4cf8-beee-08dccd7d1383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzE2ejcxQjJ1cFNWb2ZkOS9IbFhjL2pYL2JtbDMzTjVLMnhlRGdZWHprWlpW?=
 =?utf-8?B?eEVENU1UMlcvS0JZNnY1QmJaVWowaklPdklCV3RSaUVVUFlrRGdyV3BQbXgy?=
 =?utf-8?B?M3VYWXBJV2VndHphMmFvNXVxa0VBTSs2RjlJUnZFN2x1ZGtHMldjdlFZeU55?=
 =?utf-8?B?T3J3SzBVdTNNY0JvTTA2emdBR2k3R05jMDV3RHcvNkg3VWRBQU8xenNybFZw?=
 =?utf-8?B?cjNZamt3dmRGOUcxMEtIVEVXcThvbldRdW8rODBoelpCWEphVFhBOFdiYnRZ?=
 =?utf-8?B?b25sekgzdWpGS0N2YXZWb09NSFVyUGlkbDZLVnB0bjIzN25XL2RSTEJTQURK?=
 =?utf-8?B?aWJFMTVmbkxTTEdSak8wenFLdXJVa3g0Y1NsaGpQQTlIdTIxL09hbWxtd1Mw?=
 =?utf-8?B?SDFFLy9VN1hNNlQ3TkhVNTE3eC90QnNFWGM0bXliOWo0Sk5LOVVVZVU3SDFs?=
 =?utf-8?B?VU1GdjZKSFlwcHpYQmJ0WVVCekwydUZYTFdDbFJUOXN3UmtXZnM3TnBlVDVl?=
 =?utf-8?B?VmZoK1pZMHJ4NUx3bHNHcGRQUE5sNkI1Y2JFdnJMUGhLaEtGTGVOV1AwM2h6?=
 =?utf-8?B?VzZ1YXFkUEV1Qm1mcnpSWFJ2UUlHNXRxQlZ5amRZTFlqWXJYblhyUEJLdGNB?=
 =?utf-8?B?MDBqM05rTm1mQ0d2TWc0Nng5TUlBRkhPL2dxLzJkWnhTZmJQSlBkclR6TTV6?=
 =?utf-8?B?Q0tQUzdETEgxV0liSlhpQ1pPUlZIUmxWek1yeXhyNVRuZFdOM1FkTCt2cTBC?=
 =?utf-8?B?WlpjUGRmZjRaTWRHSk9UdFFHNmJPOFovaHE5Vm93TzIzVjlKanNyTmsvdDN4?=
 =?utf-8?B?aE4yTkZPUisyMGNON1hSdS9nYmJXdGhyWm1lZHA0Smsya2EzaDd0V0plcFZH?=
 =?utf-8?B?Y3VFMUZRM29JU1A5Ykx3QTNiMU1WMFNjbzltOG0wNWFLNWgrVkd3ZUMvbkhO?=
 =?utf-8?B?OEZLU09ndWpLeGRrMFhRK1JXMzlZVWFML1pRaGZRWWtUMU5vVEt6SnVzcTRJ?=
 =?utf-8?B?NHd4NUJ5ZGk5TWZ6REF2bFQwZU1HVnRCYTF4WVJWNDJUdVU1QlFHM3h4Mnkx?=
 =?utf-8?B?NzRXemJKLzB1MkNpcDJHbjdUNzhOMXdya083Sk1jYVpqcmlzTzl4Uk51a1dl?=
 =?utf-8?B?VVdIZnNLMTJMRWJKbS9YV3VqSWV2b05IQ1ltanNrbW5VL0lkaTlvQlNqUmFG?=
 =?utf-8?B?Mml3dXpkTUxySHhHVUV1N2hsSk1kdUpRWG1jSDVPa1hZb09XbVAxOWhkTHBP?=
 =?utf-8?B?SDh5ZzhYMXI1UGVjVzJTV1ZoRURIdVpiUU9lcHpFOHRnWHhxKzAraCtIUk9u?=
 =?utf-8?B?NXdOeExTWWRsa1dwcktpRU1kQmFWUXdkWnhxdkZ3Uit3akZBWnpzRlFwcEFN?=
 =?utf-8?B?RnhhWDRNTkIvWmo5OWFWVUk3ZXhDSVdhZmFmRk9sWnVOQjFGblpIYkU3T01r?=
 =?utf-8?B?T1hRNEdnSGtXVnhPVWdOR1NLWjlXR3JvQUhOdkZsVVVGMGk5d1VUTUwzT1Z2?=
 =?utf-8?B?MnVFeU8vTDVtYUUwZ3VNRHJBNGRYM0VPenFpRDJVbkRmUFk5c3VQYnY3dzRa?=
 =?utf-8?B?aU9xeGNwMlAyNU9DRW9jM3ozTk1Wam9BN3NMY3hVeTQ5QUVYMkNkanpzV3RU?=
 =?utf-8?B?ZlRuQWVpVElSdDdVRXJTd2VvWmFuMWdRN1dNQWVoUzJBN0FEU0dBQ0Z3VlpX?=
 =?utf-8?B?MXFzRjFpK3diaVFOamc0aTVuVkkwNlY1U2tHV1Z5cWx1U0RhczNYeWI3dTJq?=
 =?utf-8?B?VlFwWmhja1NSaDRYdmxoK002MWxOa3hsS0EvYVFxQnd2c09SYVkwU0V0NEhD?=
 =?utf-8?B?VXFyT1AyRWM3Wm5KQVY2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OExLRDh3Vy9NamFDVGp6V3VaQUhxaklYVEIraExsUGRkNjZQVlJ5Y3ROWDJn?=
 =?utf-8?B?by9XWEwzdVNJQ1d6VEZwQVJKbVc1aWlUUWlrSHRaV1RUbnFPajFkV04rR1B3?=
 =?utf-8?B?WkpnckRBMmZNRlFzU24xTTVtdjJOKzdBUmltTkJSOXpmRThEdDF4Z2NtOFJp?=
 =?utf-8?B?TkNDVEo1ckZKeXloMjJ3Rm1KUmYyb2trMkQxN1JsdmhpQm9IMzZ3djRUTTRJ?=
 =?utf-8?B?bjlQZitsZ09BeWlKT015YXpKcnlQa1haTm9ndG4wS1pxdEZiZFU4VjNWbXI2?=
 =?utf-8?B?S2tCUXBGYWFkN1ljNGFVZ0FBamhLd2lVTG5tM3c1NUFZZEk4QnI2dFh2K0Fm?=
 =?utf-8?B?Zm12emdIWjl4TDROZEs1YVdtczR2OEY4cjlRR0JPMnRCRFdkbUF6ZjBoTjdn?=
 =?utf-8?B?a3NiVlNDNzhheDZjSzgrRXdCK0VhVDNSbW5yK1NmNTVpb3B5VG1tU1dpYkxn?=
 =?utf-8?B?T3RHYy9TL3ZydjhkLzlLNXZEZFlXQXRPR3dhRzZQQVFGUlhHQXhZL3VGaXdR?=
 =?utf-8?B?eGxLdWF5UUU3bkFQOVNYNTI0TWtmZ05HYklmV0xKWUlBZnNMZ2d5cllwQk4v?=
 =?utf-8?B?dUtRYitzdjlLQTJScDNQU043ejMwTnVGTmJJeDVvY1R0cytqb1NnV3FjUSt5?=
 =?utf-8?B?TTFCTC9xNXI5SjlieHNvb3NQdUpua1kxczluWndNWFc3K1M3eVNjL0I3akJq?=
 =?utf-8?B?SFJDKzhMUDVkWlVGU1FpbXRDU3FyNDRDNEpGYmZGMWxMdUo1SWY5ZS81WXNY?=
 =?utf-8?B?ckdzN1lrRFROYmRHNXR3b1NnMlFRd0U2djhvQXpTRnlRRVM2ZFhFZUxYTnJv?=
 =?utf-8?B?ZFRvV3JSZGVTVmxsZjdmNDlxbmU2a051c2Y5elVMWUZDUElDUGMvQndhbGN1?=
 =?utf-8?B?Z0o3R2JRT0hkY1haUWNGeWZvTXZDSGJBaTZKSC9VMlJUNWNiLzlIcUozdTg1?=
 =?utf-8?B?ZlhaV2JkT0NtOXV1WnhlZ3FUaUtBQmY1aUpOMGRNSmdWVU9VVEFVN25TcitL?=
 =?utf-8?B?UVZwdEhkOEhvcExuVGpnVXRsWGtNUTBWbUlRb0ZUbnRjRkVBdiswcU41aGQ3?=
 =?utf-8?B?ZVFzWURUeUJGUFpyUmlvYUlEYkdYUmszSGc0UldPcjFDVHpIZmNlYk5pQndN?=
 =?utf-8?B?SDZJcFNJcXBkWHlPMldBL2RMUlROVHc5cGdnTVZrUWw0S1JySWwycVRUSUIy?=
 =?utf-8?B?S1R0MVB6Sm9BZ09YY2NwWjVHTGZabWxLcWhLcS9HQm1LVVJtMXV1dDdFbkpH?=
 =?utf-8?B?THRSQW9DT3djZkJtUDBRTk1jUDZrd3h2QVJLbVJYOGZOQTNOWTlqS2pJaEcv?=
 =?utf-8?B?d3I5cWd5TGt0TzFoRUpkTDVlWjU4TTMyeDh0aHRYdTdyeFVMYjlGUXd3OFpM?=
 =?utf-8?B?S2FFaW5DRFJ2WjRPdmN3dDZPUzhVSklVdWJrejgxZlowUVR0UXcyem4xNnQx?=
 =?utf-8?B?dTdkN2V5eGpJRE1wdVArYXNDSENPODBpdkZ2Q3NGMTlQeStxMlV2bVR2Uytl?=
 =?utf-8?B?M1Y4RHpzdE1ub04zd2I0Q0VodldVYlBUNXhmd1ptc1VMQlpUNXFJM1dva2d0?=
 =?utf-8?B?RWxpV1BaclZMRDQ2c1pncWNXSWo3eHNlOGYwN3dqandVZDdMRlFBK3A0MWVm?=
 =?utf-8?B?RUxTUDZPKzI5SlZEVWFsM3l4bjZkTWV6dWYvSWc5cGljMUY2d3pOam5lT3Iy?=
 =?utf-8?B?RDNrYi9xQmNlNUxpdTFmK0d4NG5tSkRoNEFBeXdkcmh5OE5SUXBKUEpkeWdu?=
 =?utf-8?B?YnUyS1N3bXllOFpza0lFWWxnR040cW1QTldXenFmUURpZnhheGhLY0VBcy9C?=
 =?utf-8?B?T0V2bGZSeTJET3BZVEdKMDhOTXQzUmF4aDFXeVZDRmJiVzV5Mks5cGZDUndV?=
 =?utf-8?B?NHZMMGlTaW1qY1Niem9sVkNjSzc1RGkxTHFzTHdROGlwZ2wzRlh1TzdnbVhl?=
 =?utf-8?B?dEx6dnAyaG1vSGNFYmVFT3FLZWRhRnFtVHpuaUtHV3FQTy9vNHY2b3d2THBs?=
 =?utf-8?B?Zm5uWUZEZXJuVG90UWpkTFBsbHphcG1qNm9BQm9DNGVHUUloVDlqcTFZZVNv?=
 =?utf-8?B?N2hYcmk0ZXZCcWJVc1VIWlI1ZXpmc1V4dFhJRkN5Z3VwR3F5c3ZiRWhkMGlV?=
 =?utf-8?Q?eSllNDb1/TFxfBW4oyTcKi78u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2571eb33-639e-4cf8-beee-08dccd7d1383
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:33:46.4041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjP+BMNyHj5xRhbd34IxTFAfPCPJLXVjOCM5JMgH2B8EN6Z6TePPd4Gil5/jlgUa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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



On 9/5/24 08:24, Sughosh Ganu wrote:
> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 8/30/24 13:40, Sughosh Ganu wrote:
>>>
>>> The following set of patches are miscellaneous fixes and some
>>> hardening of the FWU update logic.
>>>
>>> Sughosh Ganu (6):
>>>     fwu: v2: perform some checks before reading metadata
>>>     fwu: v2: try reading both copies of metadata
>>>     fwu: v1: do a version check for the metadata
>>>     fwu: check all images for transitioning out of Trial State
>>>     fwu: add dependency checks for selecting FWU metadata version
>>>     fwu: do not allow capsule processing on exceeding Trial Counter
>>>       threshold
>>>
>>>    include/fwu.h            | 11 ++++++
>>>    lib/fwu_updates/Kconfig  |  1 +
>>>    lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>>>    lib/fwu_updates/fwu_v1.c | 18 +++++++--
>>>    lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>>>    5 files changed, 99 insertions(+), 42 deletions(-)
>>>
>>
>> I found one more thing.
>>
>> I did this change
>>
>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
>> index fbc2067bc12d..dab9530e499c 100644
>> --- a/tools/mkfwumdata.c
>> +++ b/tools/mkfwumdata.c
>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
>> fwu_mdata_object *mobj)
>>           struct fwu_mdata *mdata = mobj->mdata;
>>
>>           mdata->metadata_size = mobj->size;
>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>>
>>           for (i = 0; i < MAX_BANKS_V2; i++)
>>                   mdata->bank_state[i] = i < mobj->banks ?
>>
>>
>> to break desc_offset location. I generated mdata structure and write it to
>> primary mdata partition.
>>
>> This has been spotted by (my debug) which is the reason why I did it.
>>
>>          if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>>                  printf("mdata offset is not 0x20\n");
>>                  return false;
>>          }
>>
>> But I got one more message below which
>>
>> mdata offset is not 0x20
>> Both FWU metadata copies are valid but do not match. Restoring the secondary
>> partition from the primary
> 
> The reason why this logic is in place is to handle the scenario
> whereby, during the metadata update, the primary copy gets updated
> correctly, but due to some reason (like a power cut), the secondary
> copy does not -- this is because the primary copy gets updated first.
> In such a scenario, the secondary copy of metadata can be then
> restored from the primary copy. In the scenario where the primary copy
> is corrupted, it will show up in the crc check, and will get restored
> from the secondary copy.

But in this case - CRC of primary is correct but data inside is wrong because 
offset is at 0x21 not at 0x20.
That likely means that U-Boot is not actually using this field to find where 
data is but I think that's fine to say not supported mdata structure but u-boot 
should never copy this "primary broken" description to secondary one as syncup.

M

