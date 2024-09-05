Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5F6CD5BA7
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 10:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A063288C47;
	Thu,  5 Sep 2024 12:49:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nb01fzqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9FA088C7E; Thu,  5 Sep 2024 12:49:42 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1C5F88C39
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 12:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqt9t0q3SxwUMTqvShZrulq6Q8B16I8endN0xGaRA7gldBRG5RTh1uD9dryXCWsXxC3YCZ07ituN0XGmrwagUU7HiGAdEKZye8I6V+BfAqZN6xTEyNOFipWLkwAG9RfFXFmB7qUtRubyGyxYfaNVydA2bfNMLAscYj7Ob7OzBIito/UvVnGMTCxgSRJhvBsbPVckYSAKeXzVGoKRKO/pJg2f9TxtPRnQPS69yW5GYrVk8KURd5ta/n6hOBUwPQGqMTqOPw5bB9+k3uCi1UIsQllMDZvTN9swp01VdsuyTutsKzwCPhzvHlx3kIPrik21Ir3/L28a0x4Kd454PcfV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTB/bwavJr6w5HrcWR/YaHuBbsp3vPA7j0kYpVu505s=;
 b=EdPYEWyKe9X7Ugj/cZbo8V4f4jUITrDoP8haODJbjc8Z85MPFsxxcY+maOK1Ka/b9VKhp7vZ9HN3pxCCrriAXTFR9QakZAda02sHYzaPdQz1AYa0SOA1pV1ujyMro73aqao+HRHBPptPkJczrtzgA1P6D/E6GubwXIbUd5s0L+/yzPkw2xSgfuXcSeI3amgp0K+CD+o9oAtSZPmRc6evyIy2VCf00cEUQFbTTbq8qF5Q69iLj2BSJIldKSRYvwazhzCUNwTk4csTVOwy1BF1cZqpt9OFxrYwpGSR7yYpFH7XShU5eAfL4GeMoqB1OAzpUTBeOb/dBvvkgRU2iTsXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTB/bwavJr6w5HrcWR/YaHuBbsp3vPA7j0kYpVu505s=;
 b=nb01fzqIGgDb6fFVBfDfIPl0z8v/yiKhpCDNnykyftbHklY4oV3Qzba6xPuAA/xaDgaP4r7Li+A1jHBsO2aH3LxNjp/Jhp6CSPlGlKGuimRxXKpS7Monh2Qs7EAiDne080Y4/6F1mbmDBMNWYS75uoTIUPOkoZxCmdzPgFO4N3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM8PR04MB7347.eurprd04.prod.outlook.com (2603:10a6:20b:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 10:49:39 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 10:49:39 +0000
Message-ID: <36a3c339-5fba-4740-9df2-880eeb326b20@cherry.de>
Date: Thu, 5 Sep 2024 12:49:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cmd: mmc: Allow using partition name in mmc erase
 command
To: Tomas Paukrt <tomaspaukrt@email.cz>
Cc: trini@konsulko.com, festevam@gmail.com, u-boot@lists.denx.de
References: <3hD.ZbWV.1{t85GxWb7T.1crWYj@seznam.cz>
 <63f3d458-e6c1-4995-b766-b0d04a69a837@cherry.de>
 <40q.ZbXp.GudlP{nFVV.1crk5v@seznam.cz>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <40q.ZbXp.GudlP{nFVV.1crk5v@seznam.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::8) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM8PR04MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d10d094-740f-4a73-ca70-08dccd9870a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlNpekhVMWNLRTMzblNTdXloVWE3NE9GVUNZSkxGMHVIaDlwM29HOEZCME54?=
 =?utf-8?B?YzJwUGs3UkxobmEwRG9aUm1LR3RXSnNyeVk4ZjdBK2tBN3hMbisyTkVTb2Jh?=
 =?utf-8?B?VnV5U2JLbUZJQnpPU3lKZnMxSWtJU0E1M0hreTN2ZkpJc2RjZkk4ekUra1Uw?=
 =?utf-8?B?WWoyK2JjOEwvQnFBd1NaMzVkTUFnaE82SndSQXZqUnQ5eDBFc1dJNFh3UTdK?=
 =?utf-8?B?SjlKSkVaNEJWSTI4Tng4bGFSMEExaTU3L2JNWUZFS3cwNzVLQkNwUHdrSys0?=
 =?utf-8?B?bnMreTlMQVRTSHZVN2x5aFdYMjE0aFg3SHFuQm9LWHEwaDRrbEVLZTJTMExX?=
 =?utf-8?B?L2hrUjJPeG1sWWNaM1lxWENrbDI1U3IxdVNCdFdkSEdmYU11WUVsU243UHFl?=
 =?utf-8?B?K3BQNTVrekMxdmc0M3V6YXBwYVlqbG1XQjBPYTVaVG1tNEhyLzVyK2xuK3hl?=
 =?utf-8?B?eDF4bE8vZzRwbkNPNjVXMHMzNDNrV3hIbE9NVDA1YWc4RlE4eVEyMk5LbjdV?=
 =?utf-8?B?dDlUbk1xRHVNOVp5ekpVWFF2RWxWMzE3TTREbmMyMWMrNHYzS1BWTldqR0xj?=
 =?utf-8?B?QXFLQWk0Yk1SYjdJREE4NlV0dDdiSEdIQkorbFlMcW9vU1BSWXFZZGUzMWZF?=
 =?utf-8?B?SU9vM3NQZDY2R25kQW1ETERZV0V2aVMvN0RPSGRXVi9aOHJxaHhrSnZ6TFN3?=
 =?utf-8?B?NEdBRU1QanZQQ09UNC81Y09ETllaMFUzN0ZUckRNaDVMQTZYVUhuc1RKRWQy?=
 =?utf-8?B?dzF3TTF4S0JFTDk4VXBTMGRSdGVnZmMyTnlKSnBqVWhFak8zYWQ1YytGV3lU?=
 =?utf-8?B?NG5iOVZSR1hRYXFJOGtVVGdTazh2STE0TkZtUmdnRGJFT1N6UElKQ0ZQU3hQ?=
 =?utf-8?B?dUNGU3h4MGlBOVdvanB0NjY4R3h0ZzBObUlPUE5XNGhuaXgvTkVQdkU1b2NF?=
 =?utf-8?B?M1NCTWNFZU0yYlRkSTg5bkJSQVRNQmduTElTTU1vQmZBTng5WDYvb1JBdDJ1?=
 =?utf-8?B?RFBNeHgybE5hRUl0cW1iOXo4Qm8ydXF6WWdlWWxmWWxPOUVITEx0SitvQXRL?=
 =?utf-8?B?eVJneVZtMWcvZFlTaXQvTDhuUnJXeHF3a2hQcVVXRmFOODNoQk5PVUh6RmxO?=
 =?utf-8?B?ZG5DWXVaVGZOSXE2V0s4ZTc1RmZZZUh2aTEzNmFRSWwxN1VuWHB0blA2RW50?=
 =?utf-8?B?SVo5VGNacFBIR0NyT3dxbFVQQXI5SUphV2NEV3dHTklRUVlhbm5acS9Kb1c4?=
 =?utf-8?B?a3JLQndLcW9mRjJqQjhWdDQxdTFPSGNQdHQwZWhyV3d0S3Bkb3FJcUV1Y21R?=
 =?utf-8?B?TDZ4SVZpVjUyR1pXSnhPUWVwOW1iWHRTR1ZsbTlTOXlaenFEaStIVjhFTDJK?=
 =?utf-8?B?L25kY0txUVFkR0lqdGg3MHhZQVllaTFMdW9PQ0xXVm9ZbEV0Nm1meDI3bS81?=
 =?utf-8?B?cVYyMkVldk0rZXhEN0preHlyMjVzdjdkVlVSVDBlYmdZTFdIcytLTHpYWGFu?=
 =?utf-8?B?WHUzZnQ4L09UV0ZlbEs3OFkvQ2Fwemt4R0kwdWpqQ1RpOFpkUEYwc2JEREpy?=
 =?utf-8?B?T1dSSklYSnZTZVZBMW1PWUc3d2h3TnFnNHNGVlJFZGtwbUhIdGphVDgvVTd3?=
 =?utf-8?B?MEx3ZEtCcFN6cTlURDBhQmhncEhTKzNzR21ZTDZuZFJHamVTWVB0QVpsQXYw?=
 =?utf-8?B?eWJBTXlYbnRSMndNd2g3R2pxYXZHbmRhdWt0VzMvSFphOVZEVzQzMnoweTlw?=
 =?utf-8?B?eFRXUzY2clhvbTR3c0hhdkkxWHNUUGtHNm41dXZTNkFXV3ZYQXU0MlluZm94?=
 =?utf-8?B?ZzlNc1ZJdjRLcUFXRk1MQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzYreFV4UGRrVFVDdmxjRnVDVlJHVDRkcXVETy8rYU01M2hxcDl2VUY4Z1kz?=
 =?utf-8?B?SGRjNnB3UmVRb0Z4Y1k2Y0diUHRUYlJaZWtpWUVnVDI3dzR3RU9LeE5FUFhO?=
 =?utf-8?B?NGNocFFiR1RWdmVrenFZNUI3YVFXU0FOb2ZVaEFrWEhHTHNGdnNxRTk0K2xQ?=
 =?utf-8?B?Q29UT1BYNEdqbTMwZ0FCVk5BdmlURWE4VG5SOFYwTnk3Q2RuWWxrNDd1V2tS?=
 =?utf-8?B?bTFkcFhrYXB4Mnl4eUtPTTZ4YXZhTW9na3BvbmVQNTFWK0FrbGtpVnNOMWNw?=
 =?utf-8?B?Umc5VVYyUXZYeThlSEdtRHRFMEVsMkZoY0dxNCsxSi9HaW9BOUZxUkw2dDFM?=
 =?utf-8?B?V0hkOFJocTF5dFpmZVJJYmJadG10TDBtUjd3dGRacENxV24xY0FVeGdnVXNS?=
 =?utf-8?B?UWQ1TUNkc01BUjJWSlEza1RVdDVmTHEveDFCcFEvaWxEcmZSVTVUd0orak1l?=
 =?utf-8?B?M2dVbEtqNzZ0N0hwQ0dLZlBVM3FUeDQ0TEYwUDd2SjQxQ2JvbFNCQ0VjalYx?=
 =?utf-8?B?M2w1bHdKa21WUHFQeFhMS1dhK2Z2Wi8xMXR1RUgvVDJYcnBVWXRyTHBJUVh3?=
 =?utf-8?B?dGQyTFJBWWVnZ3RuYTlPdGtUWSsvVUFGTHNQTUYrWmc1aitsZjY4Ry8yYVY0?=
 =?utf-8?B?UU5jZ3VQdDhUUFlMSWQwVkFNOTMzOHdoK2djekNhbUwzZExSTzhaVG1YWDhj?=
 =?utf-8?B?QkU1SmkxcHFFZHVEZWFKbTcvdWp5ZFRQeFR3Qjc2UFZFblkvNHpDeFNDbDJx?=
 =?utf-8?B?aXZ2ZmZjNW1zWG9Id1N3S2xKVzhRckpVY04wYzNaWWcwNTcvUSs1OTFCbTM4?=
 =?utf-8?B?TkhMYTZzMFZWTWhlN2NXRkJvUjBqYStzemp1U3VPRVVEcmZtcXF0YmJaNkw0?=
 =?utf-8?B?c20vU2wxcnFaa1JXcTRsb3JMbHpJdm9Fbkd3UnVJS0FLcExwbzFjWVpQQk4w?=
 =?utf-8?B?YXJzS1ZyUDc0dGRDdGRvU3lLYTliUVFsSTdHOWh1OStma29HdGxpcVhCc01Q?=
 =?utf-8?B?M2ZtbGE3ZU5uek1QNzArdXFCTHNwZWdQVWN1WWlFV2FiOTh2a3NLMXZ3Z1dS?=
 =?utf-8?B?RkVKQmN0ZnpmeHZsQmxNT0REdjZmVi9oTUppSTl6amsrTzJ1WjdKQ3VMQnZU?=
 =?utf-8?B?SlFwM3N1YTlBc0U4L1RBS3F6bEF3d0JobHBnRGt1Rmhsc2pVeGdwRDd3OVNv?=
 =?utf-8?B?TVNuNjZCQVJ3aU5VdjVVUEFud0dxTkw0cXEydmdnZzIxaGF6MUFMcU53M1hO?=
 =?utf-8?B?cGxEUjFHSFZqbEVIWWdtOWJOMURWNWZuamd2czJiQ0ZLQ25qeWhUdUJNcmpB?=
 =?utf-8?B?dlF3NTIvSVExN0NuMzNKMldWMmpMUy92UHFNY2FRRHpCc1JEN0lCbHNCK0xP?=
 =?utf-8?B?VjdGYlJpV1E2UGxPa1MyMkp5a2NjWE9PNWlmWFZ6dCtibmtKcFNnTGJZWnRT?=
 =?utf-8?B?OXdiTkRkMTdPOWdaSG1tbnRBNHRjVjBtejl0RVFqWlR3UTJCQXEvME1Gbkhq?=
 =?utf-8?B?OGJ6YU1VS2s5enFYd0NNZ2QvNW5MNUJtUkVVQkQvcHFid1l6R3VOejlnNXBI?=
 =?utf-8?B?YWUxd1pwUDRRZSs3WVV6eHdndGoxWmMzZ0M2Y1JDK0FsVnBqVHlRSzNVQ3J3?=
 =?utf-8?B?WkR4dmVKTXRKakk3VUc5NlFjbjZhZUhRVzlDSVVWRlRNZ2hLMjkyWkJQNmR1?=
 =?utf-8?B?UEdtUmlTNGtMZEp2aTF0QkxCVGN5NzlHcy9GOWkvMW9EZG9NTzBFV0JmdGlr?=
 =?utf-8?B?TTBGTlF4RHpEMGc3bnhHWDk2b29peWRSSGxkeTFyNytGMFhaU0dpSDB3MmQ2?=
 =?utf-8?B?YWN4dllnTlcyOG9US0VTTEwrR3pQVUMzNkdCMHAwbzUyYlhBTkhmUWx5d0lL?=
 =?utf-8?B?UEsxTmdUbHZYNHByTDBmZHZKZDBCNjE1MG9YcUpWVTJDVkNoRW5OSFVxYlF6?=
 =?utf-8?B?OS80cVJObWltaUNsVXNTYitlZVJzcHd0dWJiUHljSlI0TXhwTkdvTWNUQ24r?=
 =?utf-8?B?akpWT04wVHZEVVFlL0VQMkhvbWJNUDJlVmE3SUlBUjdDb1Z0dE10NHlnNXhS?=
 =?utf-8?B?VC9meVFqNm9OblhqOGJFaFZxWkRLVGhxMDQxcDZ0R2ZyWElLaFNsOXd5RkJp?=
 =?utf-8?B?SFQrNU00RUJmcFRNYkJwMkMwYVd2NVhmOWYwcEw5S3lXakdrdFk0QnlzSWJx?=
 =?utf-8?Q?b8gUkoGdKroDsSBGaKZD/ZI=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d10d094-740f-4a73-ca70-08dccd9870a9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 10:49:39.0430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0rOKw7TE6Og2iMv9j7gaff86YBEGmtNUIcvZDSc1mm9hfbUlr4YwareA6FGIFo4o8puIkAcL5YFbeEQO2Tp+uBY4vO2msAvFRKu7N2aBRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7347
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

Hi Tomas,

On 9/3/24 12:14 PM, Tomas Paukrt wrote:
>> Same question as for v1, are we sure that the partition block size is
>> the same as the MMC erase block size? Is this guaranteed by all
>> standards (all MMC standards, and all partition table standards)?
>> Otherwise I assume we should do some maths here to figure out the MMC
>> start block AND block size based on the partition start block AND block
>> size and to pass the correct information to blk_derase(). I hope they
>> also are guaranteed to be aligned somehow and that a partition block
>> size is a multiple of an MMC erase block size? This maths seems to be
>> done in mmc_berase() (at a quick glance, not sure it's appropriate).
> 
> Hi Quentin,
> 
> I'm no expert on U-Boot internals, but if you look e.g. to part_get_info_whole_disk()
> then you can see that blksz is directly copied from struct blk_desc to struct disk_partition.
> Both the start block and block size in struct disk_partition are multiples of blksz, so I think that
> they can be passed directly to blk_derase(), which later calls mmc_berase().
> 

Makes sense, thanks for the pointers.

Looks good to me,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
