Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A31C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 10:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEA68144A;
	Mon, 31 Mar 2025 12:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="DFEB/74b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C135C81703; Mon, 31 Mar 2025 12:16:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F8A8006D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi+9LFlQ3vz+tybXvm1HUFNjOXNwObdBzUnF5DNZKLfN/Em/z9YFKsBT7UZbi4KyIc4qD7ruYDnV7SXDTR97lH3hdC574j6SqclfHs8li+KEBCnxxpG/Iblen8D5gnMcLGCDRx2uTF9yG0naozYiQ/qpXx5QbPgXbmzdNQOpyQltZbkI3Pur5f2JqgDC4AFAn8rmtLpJ06oNwhWg/J2WXpSQtOEMyZmkjgFVlWf/MFNrkAo4E59hzxOpxcoma/OjoGUJUNXWvDn0rUXESSfwZHGrOhfM18eJSMn11tNs65/jFTht8gZA5Yy6qLdeRi3MxvPvM0pnuWQltI8MKBj0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DECXqZRwcSRR0jk82w2iJMpUaECTZ6kUJnJfSO9pUJQ=;
 b=ePFB4cLlfbOV97hS4ae96UZpMIcr3vlZ62oRh/0bqDmYRWNZlu8STY3+InxlAKocFoH3zeuN5LamJ7zdxrD1dLfQ6VNm59BqxF9CmjIPi2nkLmeQdn5RkRphsqogKrnkc/IHQ5cv4PDStPhRLvlPUJhCQICY03ow30XaxKtwqlObj1CT/J9OvcyDqda8rZYcHGbMvUW9pJmiHB1rLq/6DVqQ0o7zJhWfJKXSqfRUh2npwR541N/a/QPoTGUcPtmfO0ufwubib7MWBG+OD6GCJ4p7lmutX6i4YorC75N4ZYMD4lR1e99ewLGsJsTxISbKfP6PfVBX+6EMP+h99M8PIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DECXqZRwcSRR0jk82w2iJMpUaECTZ6kUJnJfSO9pUJQ=;
 b=DFEB/74bcddh5/gJjN9iyEncD8O/d32ykYv9OKxbu8wPMwZAWgZ4JLQGErFPK4/sbGU1Gco9aG/dpFIP9kg6hbYCVBXW0hi7nMDFFnMwH6oexkNR1dp8hqPx2tduxBiFS3TeG7sTj7NjKcireoIb7Kc+KelwCMDShYanLPW7yXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Mon, 31 Mar
 2025 10:16:01 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.052; Mon, 31 Mar 2025
 10:16:01 +0000
Message-ID: <aac2609c-c079-44a9-92ba-8517af78350e@cherry.de>
Date: Mon, 31 Mar 2025 12:16:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] sysreset: add PHASE_ to GPIO reset and poweroff
 configs
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>, Simon Glass <sjg@chromium.org>,
 Robert Marko <robert.marko@sartura.hr>
Cc: u-boot@lists.denx.de
References: <20250330092815.10350-1-clamor95@gmail.com>
 <20250330092815.10350-2-clamor95@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250330092815.10350-2-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0345.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a1454d6-409b-46b0-6ebc-08dd703d0951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVArOEZmUUt4clJSYmRzWk5EYmI3TzBBejFMa1JBZGRSUWdXRTRLRW9wQXQ4?=
 =?utf-8?B?SEVoZTlaZWtXWnorQzVSZHYwM3BrNXQyWWF5QWF3TVI0R3dTQjE0Q25zMjRl?=
 =?utf-8?B?cmNzbndFSXBLVWRCUndhL0JPNTlXU0ZBOUt3ei9Bd2FBdkpHaVJGbXdWSHl1?=
 =?utf-8?B?Z1RNZ3JIdm45VmFaek92UnFIVTlXTHViWUVtdzZXNE0vK3RqdVNVUStVWG5Y?=
 =?utf-8?B?RTJMbDY2N0l4WnlmWk4yQlFQaWN3MU9NM2pkbkhmY3Z2WEVnb1dtVy9ISGlq?=
 =?utf-8?B?dk9EdkRCOXo3dG9MY2JpbldxWnlieDRUZjh4UzlmampPbGpmQmowQjNZNndH?=
 =?utf-8?B?S1J5aWplUFpUMTlGUXpySmFxN1NCMDRKSkZYRlVvdldUaHV3Y29HQlV6RlpM?=
 =?utf-8?B?OG5LUDYwd0JBZ3hub2J0Ym82WkIyQ2tBcjQ1NFVIZlBTQ0hnTFVkSURJcWRz?=
 =?utf-8?B?YjVNWk9aSHY3UzQ0L0h2SnhBaVlZYllwUGFMQ3o0aTU5YkhPV1lGV2RRcVFy?=
 =?utf-8?B?TUpuRlpWMGpoMC9zSDRPbUN6VmQ0eVQvdi9VZXZ5dS92Z3hWVUE4eWhGRi9C?=
 =?utf-8?B?R0hmT0poUnIwRU1uajlaRVBzYXJqWTMyYlphSk9ZeE16MzBha1lPUE1yZEhO?=
 =?utf-8?B?ajhhc2xEZ0hmYndCVElZa2d2emgxd2RDR0lLSWFUVC93WTU1YjdERy90SFpX?=
 =?utf-8?B?M3JOZlJHSTNTQ3lPV1dTbHNvd2ZVUm83RFNsNmFqM3JTWVA2TDdxblFzN3Zm?=
 =?utf-8?B?a3ZRNjh4cVFKay8yV2VsTS9nU3JQMDRLUkNxN2JZeG0vMFhYR3hyVWdYV1hq?=
 =?utf-8?B?MG1URWVOU3hZNmkyZGdMSlprdjI0dEp5NjFpQlRBellKdU1oeXRIMThvSmh2?=
 =?utf-8?B?UDd4UlpkZEpHZDZvNitKQnIrcHVLcUhJUjFDM2YwNEhUL0drVUl2UENWZU9a?=
 =?utf-8?B?NVBQL0FjVFl5a0IzNVUvUUhGVExJQ2hEeE9ja3RtdzMxTmtrdTdyOGZHS0RO?=
 =?utf-8?B?b0xHWERIRmt1bXRpNDBnS3RuSWhCZ0NWU2FPSXdKdHlvOS9OKzRsUTR2bVh2?=
 =?utf-8?B?dmlQcnNJYzA4Wmw1U3pqUGc4QUwvYmNxN1ExM1duWTRJamI4dU4vdnEwcHRl?=
 =?utf-8?B?WExqYVdqV2RDRmFFWk43N1c2OHNnaUdCSXBRN29jdWxhZnc2WnJoL3cvcC9I?=
 =?utf-8?B?Wk1GZHNiL2RyMUR6Nk9ERTlRS01wWENMUG83OVdxOFhWWE1vU25VZGpxQkpP?=
 =?utf-8?B?UGx6TlQ4WkJtdXpjZER6Z0FkVzZrMnVrd1BnZjF3WURtdGc5UUpiUzd0RUZn?=
 =?utf-8?B?SXhmZDM0UXhENmZVMHNtUlpIaDRvaEVUQTZISGhQMitwTmx5YnNEeXdBMHFl?=
 =?utf-8?B?eHpSdzZpZnNxT283SW93bTZzWEN1eFlzQUVYSE5VYm1TdEFEbDFIVkJzSmkr?=
 =?utf-8?B?MXNMY2VyRXcxRGRqMUl5UGRwU1hqZWNkQ0FMUEdma2kwVExZOEt0TG9qSXhL?=
 =?utf-8?B?TnRWRFhvcGY4WllKVERIbitPeWI5Nno4cGUvTHYvcGM1cHdwaHFybWdNcVh2?=
 =?utf-8?B?M2VJQmI5aGZRbUViZm1uTU5qV0V2Vm5wOW5Ic3ZUUFJha2w0ZVFRZDF3MWZR?=
 =?utf-8?B?UnhpbDFscS8yUWVRU2JNdjRIYjZ4Zk0yb1g0ci9xMEJ3dzM5WnZ1RVc3N0Z6?=
 =?utf-8?B?eFU2NlRGTk5SalcyYmcwWUt3YXhNL2NiQjd2YmtScUZoa3BEeVFDWXFDMk9t?=
 =?utf-8?B?V200MHVhU0Q2T3FyQ3ZyaXBTdTUzMjdqekpDVHE3WEVhTi9QZTRLYWl5am1H?=
 =?utf-8?B?ZGZpc2dWSEdxd3BGL1NKdHpIYTRmTEFWS0grdWZLK3pzMFd1d2xkcmtOYU9R?=
 =?utf-8?Q?aXPbxGWqtjeTi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1l6SkVTVndDaThyWjhOZFZaZjhuR0RNejJQU0RjVmFFTGF4cW0yNzJzNzEz?=
 =?utf-8?B?aW9LV3VnR2p2WnhLOElWRzZsNHh2NmFUTWdaWDUza2YzaW9KS1gvcktJWXoz?=
 =?utf-8?B?UHNQOGlacEcxYytHVFNBZzEwWDM5OVI0aHcvcUdjNnFBSmlaQVNtMkVNVVdm?=
 =?utf-8?B?YVV0MmQvclFUSjdGbUEydUYweEZxZm01V04zU1dMYnRxanF3TFV0Zm41azQw?=
 =?utf-8?B?S09SNGtkV29CQ0hEeEJNcmZlSGVvOEZuWUViajVzd0hROUJIL0RJUjVERVFz?=
 =?utf-8?B?dVltTVdzaHBEcS9DSE5sMUF5RUFRS3JlL3p5UjRUejhpYnhHbktTU2EybTdH?=
 =?utf-8?B?YTlnYU55YjFVd3dDTTBiT3VReGl4Q2pYKzhtaW02U0Q5eEVRUmZYVUhiTFpa?=
 =?utf-8?B?bXdPVDhnbWZwMDVvbkExSHl0S0M1cU9yWVY5VnNHdEdFbTErb3pMUHdYUmpy?=
 =?utf-8?B?bFpjdG1QTHp5Q0h3dy9nd1FhUHlnd2haZFhkdnI0YUdLaFdtb1dTVHhJcElF?=
 =?utf-8?B?aGpmUHN0ejNvQmc5VVVDS1MzWFZGV2tldzYzM0dkWERJNWNoeElzM1pKT3Fu?=
 =?utf-8?B?YVIwUGZnRm5mSER1K3NNY250SEh3ek1iVTBsOXRYZ0Z5eGRvWDJ4S1IyTmZy?=
 =?utf-8?B?S1NKWERoNHIwZHpKMS8zQmFuTmNjUTBzUHNlQ2pjRS9TS3dKSHh1UkVyUGVL?=
 =?utf-8?B?d2JhaXJMK3VvSmoycUpmMTlMd0xINVJJN3R1dzlnK1oxSmJZNE94VDFESERz?=
 =?utf-8?B?b2luYVEyQ1ZTMDZ0eXFKMk9hVmZnTlhObEhjWGt5UVc5YzRXSStkUWxPYnRj?=
 =?utf-8?B?Q09WNXVQeU9CdUFIK3hPbzZleUFETyt0Y0tLVjVaVzZvVXhpeFFQN1NjQlhH?=
 =?utf-8?B?RXVCQS9PYmFSMHpIOGxXY0c0WVFGdFpKTExxRVZLNEc0NWRGUzVIV1pnN1da?=
 =?utf-8?B?NEhUK0s5czZVMjFQc0xkUVFSeDJGU3hEYzBTckdTZHB5a2ErRHkwTXQ4dHY4?=
 =?utf-8?B?NWFWZFk5U2pmRzlBbjVjcHVFWXo0YlNFeVhsK1R2Rnh6NXJlZkJJajhLc3ll?=
 =?utf-8?B?TnlTa3BoTGwxeVRoMzZuMDNkQUJHNEN1U2lVelNDTzl4bWpkeHB4M0JYRFZZ?=
 =?utf-8?B?T21mNXRqOWpURXI1WU9IV0w3MHhFYXBrcVZpbldJRTc0bnFocE5OZGdmYXNN?=
 =?utf-8?B?QllPME1ldXFkbC94Q3RQb25lR3Z2a0RMRnBmWHFnYWNFNWJHOEI4UHhnSkU5?=
 =?utf-8?B?eHFzNUk0dDBFVkRLdDNZa1FhYzYveDl3SWlBMzB1RzRuSUtYdFp1OUgwblVB?=
 =?utf-8?B?dTZ0UGpVSFZlZktQOUpwSnRTeUV2RVdScjkzUWFKTG9VTSs0N0d0bXlpT3h5?=
 =?utf-8?B?bmdXVHp5dmxWV0h1TkNleDZPM2R1YzJUNUtwSHRONGZJUVpGbjM0WXpWdXRT?=
 =?utf-8?B?SVQzTkFqT1BjSkJ6MllnN2hxUHFVVGNhajhXU0JXV0didzA4WCtuK2FRb0VK?=
 =?utf-8?B?NTh4NlN5UUo4Yi9Samo4aXNra3JkNE92d2E0RWhBOFAxQ2VnL3c2NTZCcm01?=
 =?utf-8?B?MW1uZVU1NzRzZVE2ZjVPbkVVRHpSYmdRbWp3L0JkSVprTTRSRFJhY1dZUnky?=
 =?utf-8?B?T1FJaWJjWlRWdzNNQjhlOGJnNFNWRGZjUXNONkhZL0hDaXNDQm9WZzZ1WFl6?=
 =?utf-8?B?REh5UWV2Zy9DTU80eVlRQTJvQnlFYjc3TmFjbUpzWE9iMTZNakxKa1J4ZUtL?=
 =?utf-8?B?MXArSEJSQ29Tcmt6ZXljQjQwS0VNTjk4aytjM0IzaGRDRVlRMHVBWEUyVVdJ?=
 =?utf-8?B?eDNvVDNmODRqVVJuSXhsQmptQWRmTytXd09GenNtL2JPSHRMZjNyM0IrZG1q?=
 =?utf-8?B?MVdlSENaa0wwR3ZYbU01ZS9wUFJWSTNFK2lvRVVBVGhrOC9KWmwreHVubVlK?=
 =?utf-8?B?VW96QUFtWTRiQ0xnUTFpR083K0RzeVVmOUEyQ1JIcy9Ec2V6d0xDblRxUXp6?=
 =?utf-8?B?VDF2TUVwOGcvL0tRVElrMlI1UmsxRmpJTVYwQ3JBeXFwTGcrTnE2SzRYcVdy?=
 =?utf-8?B?KzFkTnhjU3UrcWFuTmNYNHY3WTh1TkdNbmgyWkxZYTRZOStjazdaRzJiYXJn?=
 =?utf-8?B?dmFWSGhwdWJNVXZKdldKWmttK3VBQmcwWEZCZWpxeHF1NFlQMlgxYjlsc2M3?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a1454d6-409b-46b0-6ebc-08dd703d0951
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:16:00.9728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tUhrpiZao9WGXbphp4+SF4lCbkOUBMcSmda5XlqlSZ7b9HFSAenf3B+HgS9PRwRPUuCagrpevxlvQRzNH2qJf7fIN/Fdmc5Ue1IJLwWZltk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036
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

Hi Svyatoslav,

On 3/30/25 11:28 AM, Svyatoslav Ryhel wrote:
> GPIO reset and power-off functionality depends on device tree data, which
> is often absent in SPL or TPL. To address this, incorporate PHASE_ into the
> config option.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>   drivers/sysreset/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
> index 796fc9effa5..ded91a4d325 100644
> --- a/drivers/sysreset/Makefile
> +++ b/drivers/sysreset/Makefile
> @@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_ROCKCHIP) += sysreset_rockchip.o
>   obj-$(CONFIG_ARCH_STI) += sysreset_sti.o
>   obj-$(CONFIG_SANDBOX) += sysreset_sandbox.o
>   obj-$(CONFIG_SYSRESET_CV1800B) += sysreset_cv1800b.o
> -obj-$(CONFIG_POWEROFF_GPIO) += poweroff_gpio.o
> -obj-$(CONFIG_SYSRESET_GPIO) += sysreset_gpio.o
> +obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) += poweroff_gpio.o
> +obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) += sysreset_gpio.o

Are you sure this is safe for all boards?

Essentially, right now POWEROFF_GPIO/SYSRESET_GPIO would be built for 
devices with TPL/SPL_SYSRESET symbol enabled, but with this change it 
would be disabled, possibly breaking their setup.

I'm not against this change, it's just that there may be additional 
changes made to defconfigs to transition to this new symbol...

... which you haven't added here. I don't know what's the policy, but I 
think it makes sense to add the VPL/TPL/SPL symbols here so that people 
can simply enable the symbols whenever they need it enabled in the phase 
instead of needing to send another patch before doing that.

Cheers,
Quentin
