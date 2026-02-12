Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DB4EB48F8
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E636383A47;
	Thu, 12 Feb 2026 11:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EXgpKQQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC5E83C4B; Thu, 12 Feb 2026 11:56:30 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3341583015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYmYjEstakbdRfdFvxtHBGoi1yvjSNEWuCHxeRantCbpjEUeSC6a51bo/Tb0A7E92EZOKzHNYFZk/SnXmA1q1LnwXeYdSk64u1aCAYe5SIntubzu4yyM6711bptj/i0EeZH/zu9ZuwU3aYjxRRzyBBeEveKfzkeVRFhCk24HEtIfGxtJQ3s6Au74V/sbAg3RI05S1rXm7Gko3LKi8t5Oh8eL8jPesQMgyL99sllkZM2Fi8ayCz/J9NIfdDlxu+S9Y/Atzh1AmF5YbktWXuV3BbcOcgcP4TxIa8Aywp1XkLbdUwOk0Xfx6yJdHp+zGWlEdr6lg6AG4VJB4RQflYOtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9gkNrSNmReYmISvHtGQXDgYMSL9M8KKaF9Y+DgGBNo=;
 b=ZgMxM76B7Mqy2nsNf9t+xqCd49xtFnPn/ERsEADLz14MVJRmY6W6ZYhotqsPLdRPfWPrUFwauvMkITAl8N6wzH3cRveTqUEFjs/RYuKBOp9fdzs1DgI2ZMXFBFBG9sjGiW5U5KVGx5Tup/c/1E030pxCB5x3RX50aj97YOqwYdJhAVLCMbR/DgmIVncM0nbkgtAcIZ8Mi/2MhM9TB6axUrwPQ7XgV+QtJeZcajFdicW4uivnJaOiRuG0UYUE/X54QrvhMPF8coOxay2GcaJ+LoaEnZ7+5QFUnxcUqMJagxWSxqHgUOhNF/6Sl7X3tHikjZsz86sn+lUhrlqaqFt4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9gkNrSNmReYmISvHtGQXDgYMSL9M8KKaF9Y+DgGBNo=;
 b=EXgpKQQR3RCax+p6qodFuxgzfzNwFEybpa9xaF32T696OO41oW5KUjL757b1Ys7vjjXu1PJV4mKqAMGhLkr+/TZMxPTd9LVcR5EKIPGmK5AKfPwuy80059NGWhpFDCnWHugEhXxdeeePeP4AAlMlpRHDnYDRTDFPWQi0iF8PRNI=
Received: from SA9P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::19)
 by CH3PR10MB7780.namprd10.prod.outlook.com (2603:10b6:610:1b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:56:23 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::b5) by SA9P223CA0014.outlook.office365.com
 (2603:10b6:806:26::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 10:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:56:21 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:56:21 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 04:56:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Feb 2026 04:56:20 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61CAuIb93377123;
 Thu, 12 Feb 2026 04:56:19 -0600
Message-ID: <6cc176bdb82e12a3894d6025188c73b30aeec632.camel@ti.com>
Subject: Re: [PATCH] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Date: Thu, 12 Feb 2026 16:27:45 +0530
In-Reply-To: <26f52e6f-d936-4180-8405-d30de803fc09@ti.com>
References: <20260204121245.2105523-1-s-vadapalli@ti.com>
 <4267b260-9479-44b4-bbeb-521738845be1@mailbox.org>
 <26f52e6f-d936-4180-8405-d30de803fc09@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CH3PR10MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5d52b-600f-459e-3726-08de6a255b86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R3hQZTRwWDkyaGhFTC9SK1dYNlFkYkN6T0E2V0tSOThkVjFTWlRCZ045UWQr?=
 =?utf-8?B?SXRmWGo3MUhlS1pXa0tBWTNJMWVMTlgvSDVlN2d4RlIwZ1NBRDQxNGN5enhD?=
 =?utf-8?B?UDhsbHhFY2Jjd3ZrclRCb0txeGlnMlMzcWR1RENKd3ljM29IVUZoaUN0S0pk?=
 =?utf-8?B?RFJueEhycDhSckNZTXBZZlVZNzcwR0J6ZU5BbGpwK0FKK21qZE96NlJCUksy?=
 =?utf-8?B?VENpcjFoa1JzN2pUSkx2TCttblA1d200R3RPeERsN0NJV3liRldKZmVwdXRy?=
 =?utf-8?B?K2did0h1VjR0TTRBV0lFOWdSbW9kV3Y5MXlZbDkvRTc0S3NtWWY4YUhySHhX?=
 =?utf-8?B?aFlrN2NObC9EMm9EMFJCMytqN1FFQXk3Vm4rV3VwT1B5cE5XbWx3TjVmRDlu?=
 =?utf-8?B?a2pCL3A0UWYzaXorRnNtbHY0TzZvZDJlU3FjcWhrOHZoL2RCOEpDZmFNMTVN?=
 =?utf-8?B?OERqUWYxaTQ3T3ZtRldRT2ZKYXp2UWs3NmxWejd1MzVVTXNLZU9GTUNSOUMw?=
 =?utf-8?B?Qi92dU9oNXZqdGgzMFprSGU0YmVyME9NZUpYTGdBcUZ1ckcvVDEwY3hOY0FU?=
 =?utf-8?B?S1o0Z1hLTUhVK3Y1UkgyZkQyaFRGcG9MdzB2dHVJZ0JQc2IxeGJSM0tyTmZl?=
 =?utf-8?B?UWxBRHhLdGRMT1ZNWFlIN0VzWktYS2tvdTlnQ2djZlcyOXBwYzN1VVBwdmU4?=
 =?utf-8?B?VjRjdE5Fd1Bkb3U2Qll3OU5uaGwyb21QbzZ4a0hKTU9qd2pXaTNobGVhNmha?=
 =?utf-8?B?UFRDZEVIOCsySGNkWDhxc0JqTGhpNHh3WUh5MUo1SkN2NTJ2eSsvVzBRZmUv?=
 =?utf-8?B?Mk5CQjVkVTVzWHpzcStDUHg4M0pIZ2RxRmhkYm5xazloenBoejJyUjdrZHdQ?=
 =?utf-8?B?S2tPMGI4S1dzbnB4Z3dXaUx6cDdtaElnazVYMjM3TnJSZW1NTVJLRWY1clhE?=
 =?utf-8?B?bSs2V1c4eFhYN2VDM053Ym5JRkdoOFRXUFlNRDh3citpNXAxcjNzaE1mS3NS?=
 =?utf-8?B?NkRoa0g3N2dnTWM3NkNkM2hjL3N4ZVhkKy9HbXpOeWZiK3FyU3A4Z1R6Um5B?=
 =?utf-8?B?S0d6UzJCL0ZuU3J3VHZPcnNCNHhSazIyQVQzNWpkUlM2anlyQVA2VXpBMEJG?=
 =?utf-8?B?N2FwS1dOVGhQTHNtRFhlNjRmQUVVblNRSnlpdVNEWlhZZVJNT2FiUjRUSlBS?=
 =?utf-8?B?aHAvczhYa0xJVDltaGo5ajVSc3ZVbW9iUW82WmhRUFhFQk53M2hoR0duOVo5?=
 =?utf-8?B?Zm5SNXNVK1FEanA2ZDhFVmUvRnhzbE5aeXo4N2dwcUNMd1JEZUd4VjJzU1Bt?=
 =?utf-8?B?WklSMk5VYmdwOXlIbG8wc3ErbzQ3d0RIOFA0L0lKSUVLTFFYTFNsMVZ0NmQx?=
 =?utf-8?B?SldBS1FYRUZnRDQzN2J0bnQ1ZmZYZkZXc3RoTm52ZkFJYUpkM3liNUVJZXJH?=
 =?utf-8?B?Q2w4YTRVTXlmSk9BVkszR3VKVXhzOWlSNFFNek02UlZEcXpOVHhaeGVmMVFG?=
 =?utf-8?B?M1d3MEpZcEQwTEJaZlg0ZDIrditONnh1Wk8wUTlBZmU3ZERXaSt0T2lHb2M3?=
 =?utf-8?B?WWNsV2hNbWU4WlZOWmN4NHV1RGdDMjRLSjNHWkhMNnoxU2VUOCtqVXViNTVt?=
 =?utf-8?B?T2t2b1RJbDBrc2VmelJOUGlSZktMNlVOTU9Ic3V2QTlqRDBlMjZuTkFGUFBw?=
 =?utf-8?B?ZncvN1E2aXhad2tLaHJTYnlFVG90V3BEcHVscWRMMjFSUzAvY1N1djZ2KzJi?=
 =?utf-8?B?TkszZXJoaDRxdnpJTlAzNld5SW8wYXFCbmdWeGdYbnRQeVFDYUdLTFlkaDZm?=
 =?utf-8?B?elBoNTRQd1FlN2FGQzh5eGwrbXAvTEk0ZDQvNnA1ZUJtNG1JaFgydk9mQkRZ?=
 =?utf-8?B?NjBUY0ZhY1E4L3kwd1NaTmM5MFpDWjIzbDFiQmZia1NDeFBWU0MwR29KbGJP?=
 =?utf-8?B?MUNseWZ6bjdtZTZ3bVVSN1h5Vi9jcHRaNEZwSVptM1lJTk5IZGRuck83akxZ?=
 =?utf-8?B?Ny9BN0pHNkNGNDRWb1VsNU5qMnJ1K0lXamZaaUZnRXZqV1hzTFBNTm1rdDY2?=
 =?utf-8?B?MjhTZDFSWXhUbHV1aVNJalQzbDFWZkVQaWNRV0s2OThsU0ttVi9yZkdDeWQ3?=
 =?utf-8?B?RWY0RXJ1WkJ6cHpNVktjZVE0OXpSUFRwQWxnL1RpOHExaXkzRnNoelV0KytR?=
 =?utf-8?Q?LG/9cc0fJIQ7Q56Q7Lms7qQ=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tUo3BG+o6Ly9RJXZtYKmI4ZKdyLXKdPxDjKanjiz8O5kJjycImt81OlzK/dRilOhFrGe1k0ueWNUmE8vDuFC1nYVe++4FjOb4RNbQBuemluT2GZzp5pvZy7cVTntDErrtSxKHAMBxOJ/J8Bxuikg2IGfsOlE8okNDR1n84cGXM/m5LWJym7IvBADKvVDU2Gl29mCJo9tF8U061EL0m2Bw98skkoGXeiMYxed323F7tbdZuAxne9vjsQ6Bwv+l5M3nSxgMpw77BxVVZK4LRKNJu6XiLio0GdPuJjv3EcrnT1Jltp1BqqJgHEVcqYEQ+KoBd+5wYfW8UilYcaH4IeZz6lFvd7SL24vXwH77MFQkYFFT1JeV+mijGDVlJ71JeMQdl4XdO+6M8kXwbTe+O+cIgq2BBSAGf2FBnQ8mDnzetgY+dY+ThsjnGHqV1M0R6ii
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:56:21.4322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5d52b-600f-459e-3726-08de6a255b86
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7780
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

Hello Marek,

On Thu, 2026-02-05 at 06:41 +0530, Siddharth Vadapalli wrote:
> On 04/02/26 7:39 PM, Marek Vasut wrote:
> > On 2/4/26 1:12 PM, Siddharth Vadapalli wrote:
> > > The cdns3_bind() function is responsible for identifying the appropri=
ate
> > > driver to bind to the USB Controller's device-tree node. If the=20
> > > device-tree
> > > node has the 'dr_mode' property set to 'otg', the existing approach f=
ails
> > > to bind a driver, leading to loss of functionality.
> > >=20
> > > To address this, use the VBUS Valid field of the OTG Status register =
to
> > > determine the role as follows:
> > > - If VBUS Valid field is set, it indicates that a USB Host is supplyi=
ng
> > > =C2=A0=C2=A0 power and the Controller should assume the Peripheral ro=
le.
> > > - If VBUS Valid field is clear, it indicates the absence of a USB Hos=
t=20
> > > and
> > > =C2=A0=C2=A0 the Controller should assume the Host role.
> > >=20
> > > Additionally, when 'dr_mode' happens to be 'otg' and the STRAP settin=
gs
> > > are not specified, use VBUS Valid to determine the role in=20
> > > cdns3_drd_init()
> > > and assign it to cdns->dr_mode.
> > >=20
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > >=20
> > > Hello,
> > >=20
> > > This patch is based on commit
> > > a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
> > > of the master branch of U-Boot.
> > >=20
> > > Patch has been tested in the context of USB DFU boot on the J784S4 So=
C
> > > with a Cadence USB 3.0 Controller. Since the Linux device-tree for th=
e
> > > J784S4-EVM specifies the 'dr_mode' as OTG, due to reuse of Linux
> > > device-tree by U-Boot, the 'dr_mode' of 'otg' causes USB DFU Boot to=
=20
> > > fail.
> > > While one approach to fix it is to update 'dr_mode' to 'peripheral' i=
n
> > > the 'k3-j784s4-u-boot.dtsi' file as a HACK, it doesn't scale to other
> > > SoCs and all of their 'u-boot.dtsi' files will have to be udpated as=
=20
> > > well.
> > > While I am providing Texas Instruments SoCs as an example, I presume =
that
> > > SoCs from other vendors are also affected by the 'dr_mode' being 'otg=
'.
> > > This patch addresses the issue by using the VBUS Valid bit of the OTG
> > > status register to override 'dr_mode' from 'otg' to a deterministic r=
ole
> > > to enable functionality.
> > >=20
> > > The USB DFU Boot Logs for the R5 SPL stage on J784S4 SoC with the cur=
rent
> > > U-Boot master as of commit
> > > a8d982e1f17 x86: cpu: Fix crash on FTRACE enabled builds
> > > are:
> > > https://gist.github.com/Siddharth-Vadapalli-at-TI/=20
> > > b910f326b6c9fad760190bd299ae3ff3
> > > and the logs indicate that USB DFU Boot fails. The failure is=20
> > > specifically
> > > due to 'dr_mode' being 'otg' and the cdns3_bind() function failing to=
=20
> > > bind
> > > the device-tree node to the peripheral driver required for DFU Boot.
> > >=20
> > > The USB DFU Boot Logs for the R5 SPL stage with just this patch appli=
ed
> > > while leaving 'dr_mode' at its existing value of 'otg' are:
> > > https://gist.github.com/Siddharth-Vadapalli-at-=20
> > > TI/033b9772b6ab105b96806adf890848fe
> > >=20
> > > Regards,
> > > Siddharth.
> > >=20
> > > =C2=A0 drivers/usb/cdns3/core.c | 53 ++++++++++++++++++++++++++++++++=
++++++++
> > > =C2=A0 drivers/usb/cdns3/drd.c=C2=A0 | 11 +++++++++
> > > =C2=A0 2 files changed, 64 insertions(+)
> > >=20
> > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > > index 4434dc15bec..b7be5c48fc9 100644
> > > --- a/drivers/usb/cdns3/core.c
> > > +++ b/drivers/usb/cdns3/core.c
> > > @@ -392,6 +392,55 @@ static const struct udevice_id cdns3_ids[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { },
> > > =C2=A0 };
> > > +/*
> > > + * The VBUS Valid Bit in the OTG Status register can be used to=20
> > > determine
> > > + * the role. When VBUS Valid is set, it indicates that a USB Host is=
=20
> > > supplying
> > > + * power, so the Controller should assume the PERIPHERAL role. If it=
=20
> > > isn't set,
> > > + * it indicates the absence of a USB Host, so the Controller should=
=20
> > > assume the
> > > + * HOST role. If the OTG Status register is inaccessible, return OTG=
=20
> > > role.
> > > + */
> > > +static enum usb_dr_mode cdns3_get_otg_mode(ofnode node)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 struct cdns3 cdns, *cdnsp;
> > > +=C2=A0=C2=A0=C2=A0 void __iomem *otg_regs;
> > > +=C2=A0=C2=A0=C2=A0 fdt_addr_t otg_addr;
> > > +=C2=A0=C2=A0=C2=A0 int otg_reg_index;
> > > +=C2=A0=C2=A0=C2=A0 int vbus;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 otg_reg_index =3D ofnode_stringlist_search(node, =
"reg-names", "otg");
> > > +=C2=A0=C2=A0=C2=A0 if (otg_reg_index < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return USB_DR_MODE_OTG;
> > This is wrong, the function should return error and possibly mode via=
=20
> > function parameter , do not conflate return value and mode please .
>=20
> Regarding returning an error, the patch maintains status quo for the=20
> case where we are unable to read the USB OTG Status register. Please=20
> refer to the following diff in the patch:
>=20
>=20
> 	@@ -413,6 +462,10 @@ int cdns3_bind(struct udevice *parent)
>   		if (dr_mode =3D=3D USB_DR_MODE_UNKNOWN)
>   			dr_mode =3D usb_get_dr_mode(dev_ofnode(parent));
>=20
> 	+	/* Use VBUS Valid to determine role */
> 	+	if (dr_mode =3D=3D USB_DR_MODE_OTG)
> 	+		dr_mode =3D cdns3_get_otg_mode(node);
> 	+
>   		switch (dr_mode) {
> 	 #if defined(CONFIG_SPL_USB_HOST) || \
>   		(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
>=20
> Only if the 'dr_mode' is already 'OTG', the newly added function=20
> cdns3_get_otg_mode() is invoked. In case cdns3_get_otg_mode() cannot=20
> determine the mode (otg status register cannot be read), we return otg=
=20
> mode to maintain existing behavior, following which, the code will use=
=20
> the CONFIGS to determine the role.
>=20
> Returning an error will alter existing behavior rather than extending it=
=20
> for enhancing functionality.
>=20
> Regarding passing the mode via a function parameter, I could do so, but=
=20
> I followed the implementation of other functions such as
> 	usb_get_dr_mode()
> which 'returns' the mode rather than using a function parameter to fill=
=20
> in the mode.
>=20
> Please let me know what you think.

Gentle reminder that I am waiting on your feedback. This patch has been
marked with the 'Changes Requested' state on patchworks:
https://patchwork.ozlabs.org/project/uboot/patch/20260204121245.2105523-1-s=
-vadapalli@ti.com/
although the discussion is still open.

Regards,
Siddharth.
