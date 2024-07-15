Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721CFC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB008881F;
	Mon, 15 Jul 2024 15:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="MFjxLhqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE8488837; Mon, 15 Jul 2024 15:03:21 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39EC08881F
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIAdIyXbEUMgDEP/0RZ/zjFAMtWmbu0KadW/s9C4sAGuGF9U/lK1NuogTBaF0vSYaY/KXDxFYKREo4Gmj+YQlLkDgb5ePbAIP5ZW1WavHws1DqpMFuUBOU6VCjoR38rc3wIuQOkZqHjCwzvUE7OurgVFLA2qQLTB2xBzyfQnKhy0NXxBPhdFLDSrFlzIwRG6lMt7WjScbwlav5fNXZ5acHA1ek49CVAdWkHuXDQhLA9fGnGH9Xjm/0yrOvxeXHF61A3xE9pTqCMbhAsshOFfwA/kDCF+p14ebQ7tCGopICey+1O/x2Wm6V//eGn5fP3JrIOuA6cScwHXYGfw21GPug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QrWVsM+Mpucr4H6m6VUOpohSkbhjWo6POHblkK8QHM=;
 b=m/7+LQJiwX40kbkz1gwlixFq/lQjKtJkS1EwT6aUF6Mqy/RcmfqkFcY9omjN6vwgT/FlqrLd1lqTDUeOR1/4jRIGBgDg9i8rqvbPnjNq7ZuPL4xQxbvSE/l9JdUCCN5tSTeJD0VBMOdIkCb5TjqFYbyYKEJ4cpPIriO+Q0qcWxA5EjfOQqa10WUIOMp151OMbZhhLhBtwVz9uOOJGAnaVzc2bpNViniBTwb1v/gpJ36j02EHAkhyD9QE/sWGvQBCR0WsrbTkmUVYH7/14MpABwlSOR0xTedOdhVs3qFWzXujVZBBh7UQ68g9K71G9u1WRyz+hH4PpmBszeQ2USK1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QrWVsM+Mpucr4H6m6VUOpohSkbhjWo6POHblkK8QHM=;
 b=MFjxLhqE5MCfYXr9MXgP8x0ce2/O6JuE1GyVAfU60NeSKV0cYrTkkc2tUBhz7Uy20IJZTFLfTAT+quwvbFgHpqh+cMwLIVJLjYqdSE4iJX5FhUHAJTQi6Q4bOTPtt+S1R7VmQ7e2ROTVkRe9qQPptEbos7yNTFrJYK+E8oYVXgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PR3PR10MB3769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:48::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:03:14 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:03:14 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,  Tom Rini <trini@konsulko.com>,  Matthias Brugger
 <mbrugger@suse.com>,  Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 0/2] a little RPi watchdog cleanup
In-Reply-To: <0586321e-b2b0-40f6-87cd-6da74b79fc40@denx.de> (Stefan Roese's
 message of "Mon, 15 Jul 2024 08:57:44 +0200")
References: <20240712090725.2093317-1-rasmus.villemoes@prevas.dk>
 <0586321e-b2b0-40f6-87cd-6da74b79fc40@denx.de>
Date: Mon, 15 Jul 2024 15:03:13 +0200
Message-ID: <87a5ii959q.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0002.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::27) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PR3PR10MB3769:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b82c7d-345e-4639-23ea-08dca4ce7d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dEGyhSOPOK72+2jW2Ta/rJXgWHVSJ5YCoQq+R5Q7UUHr3D3YyYv08hzVdDro?=
 =?us-ascii?Q?r2I2h7xdvYmNTOb9xlW8uVT8xcZkLXLzdJCMXLvzkv9gqhKHEPs565tC0/Hv?=
 =?us-ascii?Q?qrV37P56Y3FbFh/2Ij3vT1ff8LYkJ2rVg+KxLscrZldTv/CvNI0y456g4Q0a?=
 =?us-ascii?Q?c0CAUJWMnylUZXLcg6sht+LrKLYNdh5z8vK/hszsz06Ax5uzlJm8UXOMI8jW?=
 =?us-ascii?Q?K6pPSDvbvW5PIKG4nwcxDhRoUziStYT+JMUc8+vSQokl/SLEh91pWmKl65rY?=
 =?us-ascii?Q?/kCif/rfT4qHEy6zuZQZgmYs+4YSHUjuyXU1k/mBQMJqP/8vNQ+n6lK7b8Vp?=
 =?us-ascii?Q?urfdcnvHj2+Kh88Hz0LapKbTGDpoRm2iSx0zrE5pMlf6ETjnwhwndfQwaO0n?=
 =?us-ascii?Q?PHmejDQIk7mc4E28Xq6299xeiXn0e6OYtGXwdfLBEwTe0L4aiEpPhlYSBSlJ?=
 =?us-ascii?Q?aNNQYFypXcuNDiQDea8jhWARIDNwE0Sd9NKGcJWgziK0voWa9XAF/bYEMH1i?=
 =?us-ascii?Q?Zls7pT1yjl4khVs9UVieHSVEx2uAMt/enzvXNSVGFCQ5ehlwIIFUXFEo+cMZ?=
 =?us-ascii?Q?4camwGBW1KX81YbW/tuXQCvrQV50n7rM6GZ5PSeFAF3mZoWTojmBC3Id71c1?=
 =?us-ascii?Q?8LftK8BRTrd6k1oh7f266SPASf46r78dc3jb4yExVKVEPd3ih2I9qb/whyoy?=
 =?us-ascii?Q?RlPLTHCuOQrJLvohaWRF558Qpc76EQmQADFYmFp7DP8iomV5aT5aoIVLxWr/?=
 =?us-ascii?Q?JXoPDue5pK1mk506XfZBs/WTaSObuUAvsyUxztC6K3CX8f03A+bUsI3m27GS?=
 =?us-ascii?Q?GST99AtpIwFw/ROwwHDOrd6SlVdeBMGKvygYHNjVH6FRfjIhESM1Q8FFMyzG?=
 =?us-ascii?Q?HxvQHWg253ceuvzkuHbxoS3OU0Lhi+MGC3g9G4/B4Zk0Jt9p4tNoaBIgiNhB?=
 =?us-ascii?Q?oudh77IH9nkHVDtdJzcQX6jrqGNyoPLHuowPe+XQYk3sidTPIjMsNmaj6A+v?=
 =?us-ascii?Q?VvIvaZdF1MjA98OZE1iHTCszeenipi+48BWNDU8AQ4Xq2TUJTvGpn0UmzY7m?=
 =?us-ascii?Q?25/KpR7wL/PPVUILuCfiCB04W0VjstYY0uncJPky0DfbnT1KsYl9gUUUT4qE?=
 =?us-ascii?Q?qKNSyRzdkRWD7C/qVTmFms3m3dIWFG+9rvqr5pB/9FPCwfkYVcBsZlcLlavF?=
 =?us-ascii?Q?1ZNuiDkDFy7P/94Zcwljs5i5XjUnlRHAjtJuWJufv2fZockSm8f24kvw/0cN?=
 =?us-ascii?Q?dOTg5tnZE8mmt7DBXArzZGmMQAoTj5XbiSb+SND/aoSKX8tV8/Kg8un3XyTw?=
 =?us-ascii?Q?ET58FK0/+nmgSftSgf+f9PZdibZe35B20T4hnqfiQWdAfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xN/K/Atlta4EfnwAiG0P1OdReuI+dorojtuMUtS/VD14C8kUgmBhxDEwYsRw?=
 =?us-ascii?Q?NIM2xOlInTxdHyhkHLIdGIRjoeVuiBgarDpi4YrEQGIrN7THdNIkN3VxZPDB?=
 =?us-ascii?Q?m2qmEr/hWu402OrsbZ1CihFHzV8SP/zLDnSd23OywXc6UKyOfqSp6WdOISu9?=
 =?us-ascii?Q?bi+Cexsgx4E47TWqrp47WrFsN0/cnMbhDsO5FdYA2C1zANLmC+5ZIVBSUBCX?=
 =?us-ascii?Q?dUqGjx3t/xqYake8yuDfqTRj62u1teqMf+uO7J2gxJzZ6kZeTUHSIYmXB/vP?=
 =?us-ascii?Q?qhQq4PL3mFUQQAOnGy+hP2dGz2w2PDQYmeaucWIaqPoBntcJaucoGID6W5XG?=
 =?us-ascii?Q?yhTNx5iIIW3o8JwCTsV2n5oVG4H1FYIdWWGsynH28CT3C6HLD0F74mFvrMah?=
 =?us-ascii?Q?34djWbV/8m4lRGlsjdnBr6Zuz4epr54885ThriUr3UY7gkuUmCGr7CRVQ/rl?=
 =?us-ascii?Q?yO+F+DxZUEyA7wl2pG6TiMoxMV0htgKzNy4775GK+thE+ygQEEK2BF42f4Pf?=
 =?us-ascii?Q?e8DQUo97JyfEY0KRBW7g3t+XVIj4Kqh3/PHz65MwHGe8SJ2CZ2wzQUYJc5g5?=
 =?us-ascii?Q?hZXK8YDwEYvlpEdu34AiNP0HKC147fBS/HkCiWJJakgu0tI94yNc3F0tnSyn?=
 =?us-ascii?Q?wk9I+9hCvNG+fKzkfv9X9BvZQAAhzhKxIb5GffAlRMkZpVSVR0TY/c04zMNv?=
 =?us-ascii?Q?siuQIOnBIYRzusTdlozk85cCoQGa9vrpSzQMDFkUwQ1Sz+wb8o2SRYvj+esk?=
 =?us-ascii?Q?WLwvhKrDC4BpL00N3Mg4YLvNPhu/f7HyST0dM2hrO3243Oo9jRPt3YrpzjBS?=
 =?us-ascii?Q?zG81FwWflSCKTeVLk9+MQ6BSEmzlpO43F1gMnS17HRfQ20NYsG4zBQFLkpT6?=
 =?us-ascii?Q?ADZMcAnWoCooq6zucv6UxK7SLgsMA2is2A6GYtoCO9eCid+oaD5r2vgJ7ALl?=
 =?us-ascii?Q?/cY6fQshv6b3/Qq41eOaokAMkR0fO6CBgrEs2d33q4XatDBQc7pebrZ6ShGY?=
 =?us-ascii?Q?A885SvDf8DeYHbl7VPFGdsNbINAu0dhaLuzc/ED7wGT0mKPURaDWU+Ro5CZ7?=
 =?us-ascii?Q?rojDpa1f/CJMmg9yW3LJFmVvdrxgVaLyTNr8vK85XTfWPY5Fv40qmJ5qnax3?=
 =?us-ascii?Q?gloqXcV1/n3K4oCO7CiR3uLlxwC+dzgKAJK5KR3HuAru9g0AZZSCRuyXoBZk?=
 =?us-ascii?Q?O3IkSvf7LknS6cHhxxECcvvLvyC3H/yz9UPpuizUqUWG3Q9rH+fW6WmFuowJ?=
 =?us-ascii?Q?tOdes9rJWMtGeKYrvsy4yrDdL8jKPA994qv0vEdt49YwBpilRPpJmLkQof06?=
 =?us-ascii?Q?fLMrSnSrj7ioouVz0q9LB44PZL4quMkc1A9Q0j9F1EjlH+6cklUN0HNwsSI8?=
 =?us-ascii?Q?3dRXPAiZFvQRytZepSB97/KynM4e6GjHV0xB6O5rtFdUEDqtdnAL/SfbEcqE?=
 =?us-ascii?Q?mACNUHfgH4a0GUShXqLB7LQXPsrvxuD/MUp7zaCih3qjIftcykuBItvll2O9?=
 =?us-ascii?Q?NFh0o/OXqO+vpw+LMmg1DlvYj+o64Uw3h7aqxyeMNz2K++hLndtrCvXd0EOT?=
 =?us-ascii?Q?WhNkXMJZY+yLMkKYiyRedEtiPL1E+OQ/x4wll2BHTAnKdz5WdDoyHWU/YyC2?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b82c7d-345e-4639-23ea-08dca4ce7d10
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:03:14.9387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+xb1vv0ZHRVJw2Gq2gQ1bGMl0Zl+ZiCDCS6IWW5KhlFDds9Qtrxf3yZTgXCSNLH1Yi8P4oH+gmwc9krh10nRXU0zyZgXY6lqOJgEX/KIUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3769
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

Stefan Roese <sr@denx.de> writes:

> @Tom,
>
> I can't find these patches (and v1) in patchworks. Do you have an
> idea, why this is the case?
>

Perhaps because they (v2) have already been merged to master via a PR from
Peter?  commit 1ca216522d4.

So one has to change 'state' from 'action required' to see them:
https://patchwork.ozlabs.org/project/uboot/list/?series=&submitter=&state=*&q=hw_watchdog&archive=&delegate=

Rasmus
