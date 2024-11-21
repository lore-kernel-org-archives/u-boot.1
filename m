Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA3BD75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 06:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD697895FA;
	Thu, 21 Nov 2024 07:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="JS45673M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10A2895EB; Thu, 21 Nov 2024 07:16:37 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897FA895FA
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 07:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/HdvXAmyv6HRKiY6CEl1SkSlojyFML8m6Y2tDg8YiBQGIqbMy2tNuEgMJkOoBssmedXbQB39EwgasVJwyKfSwRB1AQFNH+2SHDyNULxDv850faIUwBFbF4tAhtxGCsOECGGEOHWb4WMTi02wxHwoqZqnEd9Bqz8iVW2blTnezzwJMlbEahEM665O9nZ6owaTIKrTKCzwt4c1Y2S4cH5YTImGwTAXUWnqeWsxgadC1GgHdOdK5TPgF2n67mI+csIWVYeysZNHaZXAqG55gFi1ktwBo26jBbMMhSeCFJhTaFbHEbgpnNuoBCmtqqv3KsYlgdJcjvJmKDAqbKn4RoZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J3aWuHbuW2Ye42rTeCvFkYOOKf4uJWn0guwWxZBA30=;
 b=dn1gYgxugafH23QPLYuYV2VFXIr8POequ/qfJ7UM+6rQypryMn2r0uzy4E1Oya5k6Vxxp5JzCkEKR388j1ku4UgeNbcI/HRPmxIbj8mYMpQTdHnApl7/MRDoJB5XT9xvUyIjjBoTnuyNzxpkVEuTsTXG4+hhNEPKdxUrPyxNTc/NdbusGKjCOBmWjPRAWvWW7kA8WExU4ry5kuZOuuIVBaJdlcQezftBrT/Am8gzcKV1DyMP3OuXGjQVB82GeiGS/eQjwx9S+f1XveybmsXwua/gp9mFbUNNIdl47VP++B8mNowPkMKfcm/wSL971Or+Kx5kH0Nxmzn4cwzoxwz5TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J3aWuHbuW2Ye42rTeCvFkYOOKf4uJWn0guwWxZBA30=;
 b=JS45673MCeM87VhHju6ySqg+ctNvkl1ikWXOhNcWMhhWmZnQHkAHIlEWRnk5v1gpcJSIuz+DJx1Sk4n08m5SvjzlOr6+UcOYJFdGp1NT6++Rysr9DPApi4DI9FxdoWa0gW+1pDZj7xMA9f/dKWND5Ud9aUIwfaR0gWQi7uALO4wYMuFHM7RDlVHR4ek7cyy/tLLJXszk7Ox2/Ka9UsG6ZMZmCJ3VpgZee0IVBGQF+YXLRK3l5tXVAMahGS5WX7H63S9tFTJjJORhULlbs+rmYOdyis+x5E0YKLgDr1gSZ6RI3X1r0kAuevBr2Rn1Juh5EnxUzkKEr2ITborKq7qMbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7435.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Thu, 21 Nov
 2024 06:16:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 06:16:33 +0000
Message-ID: <9cdf32bb-d76a-42e5-8f81-7cafa753f14c@siemens.com>
Date: Thu, 21 Nov 2024 07:16:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: rti: drop hack manipulating WDT clock rate
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>, u-boot@lists.denx.de,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>,
 "Li, Hua Qian (DI FA CTR IPC CN PRC4)" <huaqian.li@siemens.com>
Cc: Stefan Roese <sr@denx.de>
References: <20241120222412.1873381-1-alexander.sverdlin@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241120222412.1873381-1-alexander.sverdlin@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0091.eurprd02.prod.outlook.com
 (2603:10a6:208:154::32) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 280f6fd2-c383-4d07-1500-08dd09f40c22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXBzWVg0alEwL09QWEQxV2w2VjVvOXh2cFJvOTlIQ2REbmFGNEdhR2Iyd2lM?=
 =?utf-8?B?cnhBaERSRW5BM04vL1N5UHJQS0w0WGpyM3ZoaFppaDR5cTZWMENvMGRLaXpX?=
 =?utf-8?B?djBJdXpUY1pEMmQvYWVLQmRrZlRwMW02cGtSL0lTYkx3WEc0VG5QMnJYeTAz?=
 =?utf-8?B?eG1DR3BTblV0dzU5WE1ESy9lUVlUOTlqNFRGdTZXcUcyZ2ZqSStiaHVTVDBs?=
 =?utf-8?B?cmdBYzZOL1QvUk11ZUZXQzZoWS9kTlN1RWFtV21KN2tQQVBxd2grMHE3VVBq?=
 =?utf-8?B?UTZjUW1FclJlc05pQitVSW8yekJVRnBkVVN1c2R3ODhCUVdRa1ROWjFVTlNF?=
 =?utf-8?B?RU10OXo4NTlTY2FvbnVGQ25GWHNGNUR4a0lZdmlUSXlBOFpVZk9lQ3JkNDNY?=
 =?utf-8?B?RWtYRXdtWjBZblNhUGpMdWxHU2dBalNqcmU4WGhTeDBhUzU3SWlKKzBLK3Np?=
 =?utf-8?B?WGZnbTJqK3AvL2c1RFYvK3NNaUVWdmh0MFNDQWF6TTZQblNNNmVsczRYRk1q?=
 =?utf-8?B?aVExaEljaEpYN3BncUc4UmVpOFNJS2RPb1ZKMXVuZkQxUmdXSUp4c3oveVNs?=
 =?utf-8?B?d2twNlUzZjBMNkRGT0dWN2pBSStYV1o5amN3T1ZlUWx0dEhaQ05pdFVIOGps?=
 =?utf-8?B?dHBsTjFJT0xWbzVSODN2VGNaR3RwQlpnVzJIbVV0Rk5kOUhybFlMU0Y0N0Yz?=
 =?utf-8?B?NFZGeURhcmI1SDFzSVZSTXBjYUJ3MFEyaUhwWWcwb0Fjdit4Z0R4WkdHZlJv?=
 =?utf-8?B?aUtrV2RrYnVlYTZKc3p2cHJidFlhV0pGS1VNTjNZV2pxWUVKUHN3b3VKL3BI?=
 =?utf-8?B?Y1lWVWR3ZzNFV0ozbmdCTmVYZjZrTWYxUGU2NHNsM3dJcVN3WkkwWFZaYUpQ?=
 =?utf-8?B?L3Q0bytPWXJacnZQQm5yODBFTmtseVFhbEN3ZzlPZmZMOW5oWUJXRHRiSE9Y?=
 =?utf-8?B?a1EvZ0F2QzNIS1dMWWZaUTd3RUVRajVFUTZwa01BK0duTVFJNGNEVDR0MUJG?=
 =?utf-8?B?RjQvR3AzOENJbzRFcERWdmNjVjhVeGhTci9Bbmh6KzVYTllZTGMycjY1NHlR?=
 =?utf-8?B?M29SNkwxWnVmTzRrRlY5dytRZ3JrMUYrMHdKZTZyQU1mRjN4cW5UdUlPSFpW?=
 =?utf-8?B?L1E4NUpWR0ZiU1V2dmVEMTd5bmZRaHl0MmVqMlJlVW05SWpBQ0UveXZnNjl0?=
 =?utf-8?B?Zk82VzhkZHJCbjBzRFhpbW1PNFgzWGxBc1VqWVc4Qjd2QnRhbUhEQ2JnSWNY?=
 =?utf-8?B?VUlVL0dpZFQ0Y1NsQXZFQmtTMTJJeDlickVNbUlHTlpyTUZFRE1YWjVZWjRB?=
 =?utf-8?B?M00wdWJkRzlHbncwOWpDNzVuZkVGTnppTHIwUkZHN3JwcVgySjNtaTBIbnFL?=
 =?utf-8?B?ZWNhRzVoWUxtVGpuMWhVb3o5UDR4QjlsNk1WTVROVE1VYWlzMjhCY1RxNENQ?=
 =?utf-8?B?akJSbnVPSnFwTVJCM1FNejNrQlorWFBlS0JGY0NJRXI3dVFFK1hLd0I4bW84?=
 =?utf-8?B?Z3p4TlBwMUQ3THV3RnFKZ3NBb3lsNEdtbHpTMzYvT1JtU2t4MXdBQ1hDRThR?=
 =?utf-8?B?NzFkMEw2ajFLWEkyZEdxMWFyWmw2L0xzR09EV2FXVXVGNmlSbVV1L1lFN0lS?=
 =?utf-8?B?bUFKeVVhaUdRY2RDam43cHhOY0REK0lQNXpOc0RTR21HaG1QZGxZVDNyVnBs?=
 =?utf-8?B?MEpCdnA0YVBZQzBnemZwZ1hhanNyVlNBd3hQbC82UUtpMTNCay9ZTHhVbUNJ?=
 =?utf-8?Q?BqXcXY83x0yznBrcuMvqsJJhE8sOB/nLqG4MuBW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElQVGVJSUY1ODI2THpTZndzMGpzM0JzYWpYTFpWZ0g3a25kWlBESTY5dkM0?=
 =?utf-8?B?VlYwcE12eHlZcDNJQVR4L3JOdzJ2eTMzWGxRcFBoZExxUWQyeFE2L3BvUTB4?=
 =?utf-8?B?dDdROHNtdGUzRm56T2tBQ2xQblhjMCttQTJJcitlUXVQV0l4SlJRZ1VLU0ZH?=
 =?utf-8?B?ZFFjbUtZaGs1K1A0WFBNbDljcThrY1F4NXNUa3hKRkNmUmpPRFhUMTFlUGZB?=
 =?utf-8?B?eU1HYVZuL1A0TUwxNVJONGpqNGt4M1IzVStJelFUcnRROFNLSUo2dlQ4SXhv?=
 =?utf-8?B?QVYrVjBXUlA1VDdadFlQNStaaXhsOXRUQldCQlRGQ1hiNVVPK2xxalJkMW5M?=
 =?utf-8?B?bXkwOTA3NUJkY1FtYkJNUmpxK01Tb3FHOGw5VVlZR283RlFZeHl3Z0t4Q3p5?=
 =?utf-8?B?RXRRTkNJbnp6OUVxZ0grdU5uZ3BlK1M0ZzduUXFMZ2pOV2FHU3NsV0s1SDR1?=
 =?utf-8?B?dU1zTUJJWFlhaWtRWUdtWmlzQjdEVGhDMDJzYzBrdkFjdlo2TU1FQnBPUnIz?=
 =?utf-8?B?TGJqc2ovU2ZFRzRIZ0xzZTgvOThRdFZqYVRiN0JZc3RFZ256M2twK0dJSnc3?=
 =?utf-8?B?SGJLZUdEYXlqNW56eGl0emxaR21JR0RiTVBCV09Wd0pIOE1oNHlRcGEzdlFI?=
 =?utf-8?B?ZW5XNmU3OWgzY1N0OC9UdU4wbmZFMWg1aDFyOUgwZksrL2R3ajlQTHJEcjhX?=
 =?utf-8?B?V3J1VWEyWmQ1cml3aUc1RmljNEllSjlLUHVBMzRBY0dac21zQVVXdllNUUVT?=
 =?utf-8?B?TS9OMDdHNmhrVEY4QURqZFZsRjVneFJFSzQwd0JSU1BHaElJUnBWY0FGdTA4?=
 =?utf-8?B?dlN0aTNhSlVuVkdhclJrQmEzamxGRHlmeDR2Tkl5U1NPTHZxWmx6RnU4d2x3?=
 =?utf-8?B?Skw1VTBFRnhVeEVmUFllMHdkOEg5cnBpZHNVWHc3Y0dFZ3VwVERsajZxc2Y4?=
 =?utf-8?B?QlNrZHhIMHA0VzcrMzhDM0s5WXh6UEJiTXB3MEJwQk0zNmlkTkIyNXJZRVFH?=
 =?utf-8?B?RWRqQk9JdU4yRno1T2JxVnJSNVhMSzN1NGpNcGh4QVFsb1p3TytQa1hJbjll?=
 =?utf-8?B?RENaeTRxUWRJOUtjRDM2bzc5cFJZa0Jwbzd4Vy9OY09QV05kUDBrNEVoQmw4?=
 =?utf-8?B?SVNFM2c0RWhVSUpRUjRkN1Z4UW91dzFna1NTa3VyREtzOUt4NDA4aHB3ejF2?=
 =?utf-8?B?YzBtOUc5RWhTc0tIM01iL1BQRExxdzZ6bXFHM2ZvWDFyVzBXdmt1OVhpWSs1?=
 =?utf-8?B?azI0TExaak1MR0gzb3JsM2lHcjgyMCtkeXBxOGFhN3RkRUpHbGpxd0FXaGNa?=
 =?utf-8?B?MHY3RExZTUwxMUJBNHExL1BjYm1DaitDbXVQem1lcEMvaUFsYkVaYU91NHdF?=
 =?utf-8?B?S3k2bGFESDQ4ajEwYUVRVTEwdmhha2ZGUHZyRXEzRFBsN1g0NkNMNHd4dTF6?=
 =?utf-8?B?L2Y1eHRUbXMxUFRNY25GTTl3WjNUWlYxMEJhTXUwSnRGam1TQXQyakRBd3Z4?=
 =?utf-8?B?UjBsT0JnTTB2bHcySlVGSkhCMkNWRlg2aGd6NlVpem1ZaHBmMTlKVHJhNzZM?=
 =?utf-8?B?VTJmZG5McUFweTY0d0NoTEduanFBWFk1Qm1wREpaNHAySmlBV05BTUdqbnJB?=
 =?utf-8?B?V2NuWTg0Nmp6dFFMZEVsY2JEVmhkQnh0enowNGhka0pCQ3VFMlpkUVNxSmJn?=
 =?utf-8?B?WEVGU09YeWM4V0RVZFViSTJaS0ZaUlFDV0hnMXJTNEprVGVXbDZ1dzdkK3hC?=
 =?utf-8?B?M2dGbHpXTFh6V1BzTkNXMmtaMEp0UjREUkZ6TFJIVDhUbGxveVc0VjFYdnM4?=
 =?utf-8?B?bDJrbGtBelFvenkxTWtUWXp0WDBlRlZuV25KTHE2a1pCWU5wVGRpc2lRSFdB?=
 =?utf-8?B?Ni8yckNYNUpISWhhZHBiKzQ4dmNLYW9KVnIwWXBoOVY2YlhaVnQ0d015eFhn?=
 =?utf-8?B?a0ZkYzZoeEVRWlRvVmZzVFE2T3UzaHhlUlRscEFic3RKS1RRZThSdldsa0Rl?=
 =?utf-8?B?dW1NY3diQ2ZDRGE3dGJTYlQ0U3lTMTN2NHV0TEJBMzNBa1FxN2NudnVHTjdX?=
 =?utf-8?B?ZWVSWXhTVGs3TURYQzYxN2pEVisrcVZ6eitxdG5keG05Y1lOUExJZ2lkTXhD?=
 =?utf-8?Q?cH10q+3tDn6Mcu9BbO+2Q8i9K?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280f6fd2-c383-4d07-1500-08dd09f40c22
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 06:16:33.8188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CVvphonh7ncL+BWmNfCMfQuTbAfYjPRv1QU+fAzgw3nmIEnfzRMnKJ/2zAT2Dp4ns/yG86UepIANyMQqZb0DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7435
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

On 20.11.24 23:24, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The hack itself seems to be copied from Linux rti_wdt.c, but the WDT reset
> principle is different in U-Boot. While Linux relies on correct frequencies
> and timers and doesn't check the actual WDT counter value U-Boot driver
> seems to be more rubust: it does compare RTIDWDCNTR vs RTIDWDPRLD.

robust

> 
> Now the root cause of the original motivation to manipulate the clock rate
> is said to be understood and fixed in Linux commit cae58516534e
> ("watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin")
> which simultaneously removed the hack itself.
> 
> While is fix part of the mentioned patch is neither applicable nor requied

required

> for the U-Boot driver just drop the hack setting WDT clock rate to 90% of
> the real rate. This has a nice effect that the WDT timeout is now as
> requested and not 10% shorter.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/watchdog/rti_wdt.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index 99168d0cad03..f806e24e53da 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -186,14 +186,6 @@ static int rti_wdt_probe(struct udevice *dev)
>  
>  	priv->clk_hz = clk_get_rate(&clk);
>  
> -	/*
> -	 * If watchdog is running at 32k clock, it is not accurate.
> -	 * Adjust frequency down in this case so that it does not expire
> -	 * earlier than expected.
> -	 */
> -	if (priv->clk_hz < 32768)
> -		priv->clk_hz = priv->clk_hz * 9 / 10;
> -
>  	return 0;
>  }
>  

Makes sense when the kernel is updated to a stable version that contains
"watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety
margin" because the intention of this change was "to have comparable
preset values for both drivers".

Heads up for my colleagues (you already use such a kernel) and a

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

for this here.

Jan

-- 
Siemens AG, Technology
Linux Expert Center
