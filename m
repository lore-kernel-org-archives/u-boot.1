Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF7FFCE077
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 12:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6941883AA9;
	Thu, 26 Feb 2026 13:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NoGloiok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8DC83E61; Thu, 26 Feb 2026 13:54:28 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25D183642
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 13:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+ZnhLxT22ZhPbQcAnXNclw441+WcMbBaBuetoROJn+ioTrDkHpITVEYJ+SMIdQMlohxxsi41OkfaA2j+hfbdp55aFoPXRPB6V1E6VjJ+H3Uf+H+EmlYgwYsDI+M1CKb/bKMOthwwNxD9rwxy2CmOGQ/e0PVOinDMBLx2IyPK3Qu6G7qOhRBbsw9arvCdq7yxQwgP/YCyBBvcA5ASI7Ddfh9UxwSLFY48Vx75biLilrSAOv4+nKAQBr/SMJmeNYDm/R43/caliQPxndZ1ujNYRgvfopUkX+y1g0fHsXwvBpoDVAEvtl5AZjDBHOR9nq0zMd1A8zcRCNrGdGNyOv/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+WNkTHoVpPgDtdNn9L1895zpOXGHveoGmM3V4XsPS4=;
 b=pnmMq8iVmiX0kP1+7teIXvlge4yh441qhAGRiBbv569YUxMTz8oTwfADbfhf/F4Mm021vb+Zej7nIztx5ot/W7lheYVA6QWKkhT4SRbKMj7iHGvxbXAWU0frCvownTdA2HH22BW+rnVyuw/Hdy2h9gZE9HcC2w5IODHlyxto73oakFXnajFqZEJv3/kQ+pDteghwBz4n5szLBmnbHNweHwQMrAH66geS0qbDnfStK03BYVEAZvEAW8KXTZpIuRaaLVBciLOVllwwEaJ5aFqldxGXcCyB9VFqdhk9fHJEyiGsqC0YWZHnorxZCVZnNtOmqa4m7A/JFGn0CPgIxU3R0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+WNkTHoVpPgDtdNn9L1895zpOXGHveoGmM3V4XsPS4=;
 b=NoGloiokdYX3m4tFvq8NqSvGIV/Xs7U4VjqDxaWURmdhClwJJSTY4CpPItp5HgylUzdOj4YzKCyw//cjT7LZ+kBdUlAc/WLXwbO1PZ7RrHLxrSTug+PWK8XZBS73zqViH0+A1QGU6SljuNBpx+HssH9dB/ywzeE3x2gzNDdVUVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS5PR04MB11345.eurprd04.prod.outlook.com (2603:10a6:20b:6c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 12:54:24 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 12:54:24 +0000
Message-ID: <a1a57943-efcd-456d-a6c5-cf3d1d87b385@cherry.de>
Date: Thu, 26 Feb 2026 13:52:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] board/BuR/zynq: don't select non-existent
 SPL_BINMAN_FDT
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 u-boot@lists.denx.de
References: <20260225063559.47481-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260225063559.47481-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS5PR04MB11345:EE_
X-MS-Office365-Filtering-Correlation-Id: b0dfb5b5-8ab4-439f-7953-08de75362af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 0WOFTAEC7g692lsQZcTxO+F88DRC2YxUwui4ICUfr7wfBE/qa87ICyVNBcWwu+zEJNumVaY3eRBVVnhWwyg0oCJDmdi+CytsfLssQ8y/VbDq3ywFRMMBSHU4PfiNDH2F4sRgSkyaVYFokY8aU/Hu5SafRhOjwOuK9SHfRlo6Fy5uXjh9C+6jTrGXPwXex2tIF7h5ftI7SCCZOwbYM4tUyr6Ot4Y2tB6IcCWb62HSKgaT9qJSDzXHydxDDi+tQoxzlb81jWWr1sJ6HVQnntSczkEyPstiU8U1E1Fv4FEnTYPTe9xxj0J7TTf+hyxu6E+71nq8Babm+5oNUWJXxtuLMZlo9Gu/oq+JrDJvszOVK1PP8Hfa2Vat9XuQb1L0XtTaOeKAcGMszzaNoK33irznW057fXXD8ySdtam3Sih/ZsFduvFMISSxOcxj0TtPkaLhzveiA15GU8vtj0/3PIJQ4lGgMT9WVCUNVRIqGZ4VdDreVj84CTYHsZtQWy8HPuqVPDiP3vSrMQLjlhMqFYDbgmWLWdaAmFfVmiwy1MQQgTodcZOvkm6w0v5ZMe6yUqqUklGTt7v+Noj6n/6ElYtXznGKsxSvh+wOWtePmVpq/xUlzNTLwm//GEDWkOczaJVS723R44c1iIqGwuuauRTQqV6eh94JoC3Q4gX1SVY5npbkztbsVPFnUpKWjkaA/8yAMJ6wgRoFWEqGXSC+3DM8XX0s54Awr/kt/87YsWZWp5E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE1KRXFFUnBOeVVjbnE2SDhWUVBHS2YxWitVbXZqWVhaNXI5eEZ0UzZTUTd4?=
 =?utf-8?B?b2lWOXp0SHh2emZtc1BsTTRPWWJDQnh5enpQVzFnVUMzbThCeFFTMTRCSlpK?=
 =?utf-8?B?MXU2bUM3eVh5UERMTHlFTVloVjhRNm1CU3BVVmI3RmU3dFprZDY1NElUSmxG?=
 =?utf-8?B?WjZRdXNCRDBxcm9VVFMzZEFoTTBsZWpKSjc4NVNnRk04OVM0dFZ3VnNwbzJv?=
 =?utf-8?B?TTJqSGY3b1hEckdjZlE0dm1NV0RUUkhLQytGT2ZMd1k5ZmVTVlBGVlpoVUJ0?=
 =?utf-8?B?TWY0ZGkzNDc3VE8rM3NEeWZIb3FrL2lNTVdrNjY0ZVFLZGFCUCs0U3drTnJ1?=
 =?utf-8?B?SHh5bWNhdHRLeDV1SkswcnhHZ3F1d1E1dWt5TFZFZnhXSjhqVHIyemlkVGs2?=
 =?utf-8?B?bzNOVE5Yblo1TjBkQ0oxODVHTmxqb3NGd2hEaS9RZ2ZkZGZDUzBDeXBnc2Y2?=
 =?utf-8?B?QjV1clBYTEZrNGRvTGJpTyttalViMGV1QjdOYzU2REVhZlA4NnhqMVJYdlpB?=
 =?utf-8?B?bGlLVFlDbkhxOFBLcHRaMmRNR0NnQXJsOVVReFhjdUJub01YaXpxNU1mNSsw?=
 =?utf-8?B?dUY2TFhYWTRtT2tTRlp4VzBjczJ2VmNhM21uVHkrdU85S0hmWmVRSlFpd0Nr?=
 =?utf-8?B?cVkvcXl2cW5yb2VyN2xWUHkyY1hKZE5NK1B4cFFJUXd5ejlpTUpkUXBhTGR0?=
 =?utf-8?B?ZVJCU200bWFpcXp3RjZ3ZW9GZysyVGxxeHVaQ3NJdUxBR2ZjZUtOV3l3dWFw?=
 =?utf-8?B?WEZVQ3IvZVo4ODZKMjJmcCs0eWNtaFc3cy9YS1diOStKemNMSW1rcVE5WmRp?=
 =?utf-8?B?ek96N3lGTUYyaW5YQlZWWXl2Z2JHWkUwRkFleFMyS0ttblVJU045alNybGZ3?=
 =?utf-8?B?ei9ORy9lUHQra1M2UWdoV0l1RVN1Tjh1Z0ZVSjl3REc1NW9JQ0Y2RmV0cnNY?=
 =?utf-8?B?Nm9mYy9mbUVHVStrZVpEV21CZDJKb0ovQTl1UHBwaUl1emtKZE5ORXFTNEs1?=
 =?utf-8?B?N0RXOE5BRzUwUHNlYklIQUJGd1d4NFJzS3Z0cVFtOTJWalBlT1N5RE9ML2ND?=
 =?utf-8?B?ZFZQY2M2Ni9xNllYbkdzWitQOG45M0pPNEY5bkVZbjd2ZnFEbW5CdlQ1UEho?=
 =?utf-8?B?UzgzTURsTE9XWHl1a0NJYUpCdGliK2pDUGFuQitraURwY3dGVnZLcnZjSnI4?=
 =?utf-8?B?MUJGSDl1c1lSRkNyV0JzNlRibUwyWWVoU3FjR0hiaW91UWdqKzdKRkxzc2RG?=
 =?utf-8?B?ZU9PTlVNRTlmQ2E2RzArNWhGQ0ZKY3lFOFNIQnBBYmYyd0hranRKUWw2T1Ni?=
 =?utf-8?B?NDk4QVhhOGZXTGE2Q1BzakVqcHBVV2IrQjhLOXVxM0krM3FCMEs0OXE4MFBU?=
 =?utf-8?B?UERydjQ1MHlvdmlPeXNLQlVyZDlIS01kaTlldGJuZEtNTWthdmRjdmY4TXEv?=
 =?utf-8?B?RHdQSTZnNDVROWhvQk5rOEhuMTRVQmNwWEdHanNuTklPY1dVZFVPTXJjTFhS?=
 =?utf-8?B?TyswdWp5bDRNM3JNMWJ5UTJRWGROMjNjNTVjeW9ZeFh6azRQTW8rbkk5dWR5?=
 =?utf-8?B?MU1KQlpuOVBnK1EzY0E4NUdEZ2ZtZVZLVGtmaG4ya1dhOUNNTFJSODZXc1ZP?=
 =?utf-8?B?MHJXMEdPOFh4N21mbjR2TmE1b1YweUN4UUEwclEwTGZQVzBDN3YvMGtOK04v?=
 =?utf-8?B?aTYrNHFQa1pBVUs2aS9hS2hveTJWSHVMQ2NwQ1JPQ0tUejJKY1d6MHd3aEdY?=
 =?utf-8?B?QnZiNldsTVZjYXpENHprN1ZrUzhiaVdyelN4SzVjWmZyRDZjK2FZMnp3WXJ0?=
 =?utf-8?B?WEdoNWJDUWxvaFZZWUlEblhRVXorc2NPbk5IOGd4d3JaMW1uYnN0d3krVTRh?=
 =?utf-8?B?ZkJ6VUhTVitYYi9kREJVWWUwcC9XQzkxQWY4VkNvSjF3L0l6NU80STZwempI?=
 =?utf-8?B?NlVJcnVUT3h6Qzg5L1dPN2JUWk1lY0pqZkp5QzhJZ1lVT25FNGQ0TTE1R3R1?=
 =?utf-8?B?QnZRa24vVWdnUFZIeXhFZDJ0eGFqV1RRRkhPb24xVGtiR2lDN29DdzEydktF?=
 =?utf-8?B?SG9wdDNjYUtHcnNrSlhrNFRzN0FDTVhjY2tZVlhRWjRhTGJKejJ1S2k5eDIr?=
 =?utf-8?B?SDN5YTZaSC9iRHFLMUNvNWI4RXFSbmpCVW9JZE1pdHZYQnFuY0IvbnJybkZQ?=
 =?utf-8?B?ZzVKZUhZVi90TjlONXhiRWhnRjRuZkJVeUl4M08xTGxVZTBlSjNFTUl5Mm1l?=
 =?utf-8?B?eEZ5Zk1EWEFqZW9nQktVVXFvcXIvSmFnM1hpWGJId0lsWSs5Z1JFU0QrVzJG?=
 =?utf-8?B?dEdUWkpGdG91Qjh6ZjIrdDB3MjhhdjM0bmhjTms0YncwOE1mVUg3Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0dfb5b5-8ab4-439f-7953-08de75362af3
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 12:54:24.3331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkElWZM79kwlsyzJK8spfDzbRQUuOW+XsoUzSUZ+IcYhMARpCHpHIlBjtc2vy3CfeDsYs7CFXNiYfYJa1ipTW9cX42VS98AUpNot0MpBu14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11345
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

On 2/25/26 7:35 AM, Heinrich Schuchardt wrote:
> Symbol CONFIG_SPL_BINMAN_FDT does not exist.
> Don't select it.
> 

Maybe they wanted BINMAN_FDT here, but for brcp150_defconfig it's 
already enabled.

While there's

obj-$(CONFIG_$(PHASE_)BINMAN_FDT) += binman.o

in lib/Makefile, it's guarded by ifndef CONFIG_XPL_BUILD, which means 
it's the same as CONFIG_BINMAN_FDT above.

Also, there's a CONFIG_IS_ENABLED(BINMAN_FDT) in common/board_r.c but my 
understanding is that this is for post-reloc, meaning U-Boot proper, so 
SPL_BINMAN_FDT won't do anything even if defined in Kconfig, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Cheers,
Quentin
