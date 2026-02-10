Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE15EA3F2B
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 09:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 574CF8341A;
	Tue, 10 Feb 2026 10:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iJyXdHMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE4E8388D; Tue, 10 Feb 2026 10:27:12 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FB958309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XcJIAU35ido0P/7WaSI+80U+bOaKQQg9+2U/uwbAgdclKZmV3YfllZtN4FVOwZNJixvAreMM1hVxfFrc+bz0JcBfed8zG+fsYa38xi5iTLqdvSs/84rJM5ZfiK3VbL9Xw0jvr4ijy817CwCyUrYGT40AiezyxJsz3pWYFBxQKXBASFevo8ptGEqaf1cZCRN4oNlV+8glnlxs5m8cBaXCpGZGdr3Rd39I5mrixPFnnjHDI46p/gcxbSdMKSOLWMsUCKjEToflG3J/ti/gkgv1uRak2Eo0N55BL8KGovmEjdIHSQcjqrQauyDPRfV1sqi/WjUxLxhCeVD5WwG1EBAOUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLmGatSL8XuEsYtFgSj43g/qJVLEN5bpfGNmXGcOkWM=;
 b=ocOSYlVXem0/xtJUdPtdjUqVe4AIwOBNSBwQVp5IbM5JHWIoykzT/7f9y+lekcnGHoOxzRXBrxsOrNvYCyjIadPycPh3F2qx0GB/PUkhUKMP1ZOvyip+MUSwfhMnjHLmJTBv91mqL3SRRP7vDujWYFydTCncuhZy0My36Qg93rSyrvaNvBCQbD7pmH6Vh/cArYcgQLw3dSBwwer9XWeyX410XbR8vHa7ove3YGCDPNG1iTP6vOqWYAxA7IoTKMs9080MJwb1aT4yNIY2mc3j0an2GxO5C9F6mLldhJ2DRPMspL/NtDR6H24lGEC00TMMiI7bYFUfhcDaY1wCvsRNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLmGatSL8XuEsYtFgSj43g/qJVLEN5bpfGNmXGcOkWM=;
 b=iJyXdHMZC3w6UCVoX/XAa3ra4DPpUQleyhsDYm4xZRY+4VQyATbBPouV7GfLNsgxNZvMd09WbkPfP5r4YZwBCr/QMRerON5GVlCWNt60ZWDJcqrDVEratMlN+5PGfjxhkkl9EBdgOtbCNl6hat1lmWudIlVsgDaaktRrl+AU5WU=
Received: from MN2PR19CA0067.namprd19.prod.outlook.com (2603:10b6:208:19b::44)
 by IA1PR10MB7446.namprd10.prod.outlook.com (2603:10b6:208:447::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:27:06 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::7f) by MN2PR19CA0067.outlook.office365.com
 (2603:10b6:208:19b::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Tue,
 10 Feb 2026 09:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:27:05 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 03:26:48 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 03:26:47 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 03:26:47 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61A9QkHI3235602;
 Tue, 10 Feb 2026 03:26:47 -0600
Date: Tue, 10 Feb 2026 14:56:46 +0530
From: Suhaas Joshi <s-joshi@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260210092646.w5bugrscifmsh5px@ula0507357>
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb>
 <20260209172546.GA281089@francesco-nb>
 <20260209174308.GG2603314@bill-the-cat>
 <20260209180726.GB281089@francesco-nb>
 <20260209181307.GH2603314@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209181307.GH2603314@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|IA1PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 70dd5188-b066-4bcd-75ec-08de68868e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h81Qk0KC118uMo568yY9e8zBOepy7I3YfW63gnSq6QSm3CwQlPMTJdxyl5X3?=
 =?us-ascii?Q?QA4kLBDzinv7y366utoY4awXPlE/+51RhVcm28iuGqRncvRLfSm8rn6oLFtS?=
 =?us-ascii?Q?KcDan1pjdKYYHJ6N78hGIazsjEchR8l6EMrYVBNwpNzS1wc40mFOig2kZmOc?=
 =?us-ascii?Q?ADOZo9u30U8HX1iU9l28b0aPpeNyLHY+d2TQ2qv1ub/Tht1/c7z9LvgdJuyF?=
 =?us-ascii?Q?5hsHCPNe6dc6fabxAyfFuADuM66YIlStf8WhU7IXPvreFAA31Xxfek363him?=
 =?us-ascii?Q?Jc4t3KiHYlGeTjSreWZuGHILw99mGJD+ZAwFH9f8Ix+TJGxRfzDPPO37yhTf?=
 =?us-ascii?Q?IEJ3hR85cqyG2OR3URs7uB5iXwCuqOrY3RbVoSPLEmeT1O6jr8qzuUcxR+pV?=
 =?us-ascii?Q?bXRXBB5ngJwm3vuze3FyEbrYv0j7KIoZOkrwAB0PElXfrzrFyUpzjrD7MUJT?=
 =?us-ascii?Q?zUZRlsFbrTsuUfPTJgogv1Chff3QvcSd3gTkEN/Fy9AC6ffK+Ep3KHQANUbj?=
 =?us-ascii?Q?cW/xCh1KppfniCa8ABISkm3y0DBVqYu6AFoqZn7/reBHI4fcNxeJ0U3pCjSV?=
 =?us-ascii?Q?VB6WMR8hEc7fP4B5WDzgoNvcA4Ro4mfxcSZhLGQ2xUCvkZcDtMWpSgLIde5W?=
 =?us-ascii?Q?Jt8mQi2R+inhs/KlZBLSCeG08P9ATr2j/oZkRqQiwtlmtRBbARzMzLCW3EZg?=
 =?us-ascii?Q?65kxXolRr6VT6qx4z7ERdxdcJhZbhCWPAZWMJn8idhT1uIQHUpMekYo1eCKp?=
 =?us-ascii?Q?jdu30eyBp6UYIFhEdeEwqFAv9JUNObGTNayHkLj4lErHQeEX9gAdvtxdnaO/?=
 =?us-ascii?Q?aTzqAfNZw+WQhOjx9/3RC4pY/7RzhPEhoTFuI3OIeJPrgxzO2B5bJooZkDMN?=
 =?us-ascii?Q?Sp/8z/ZQeecpdCDTiE5sTW9X/6xma0PsSJarsheBu01OGjVb4tjfx+fvoFGq?=
 =?us-ascii?Q?dfk88Sa0Lzj2XjDMPaMSJcQqzmSO4+dtaf1WjJk/ruRaVdil6Uf1NZ+mzc+p?=
 =?us-ascii?Q?6jBMyJ77np9soIzvPnoLcU+/mWlKB8+KmJE7nd82M31ohyXCIcCaEYDJnHMk?=
 =?us-ascii?Q?hYvVj8J52pya+GXe/yn+0boCVGoEWQJ29sjSd+1aPMTNqjldUyYnnpGBMEAo?=
 =?us-ascii?Q?aNR/En4pMVqYuzUZDVFckAfKaCgBZRW6JQCLmeAGMhz/mjliOZNc/zAAdWNn?=
 =?us-ascii?Q?6crT13bDlAZC8cxS8Q70C451Nb1788c+XTS0df4SzUVK00vnDaKxKwECq8Gw?=
 =?us-ascii?Q?WW2ih/NBGjvX8QgLOzAjUzboN/TSE4cGBpYNY8pwB7djBpBVJV2TOxoC+VBC?=
 =?us-ascii?Q?Y4ax2q++b2utNWdEvVIYGhCv+3PIQWYXycl8oC6/yDLQ9Y++skDqdM96zpjm?=
 =?us-ascii?Q?HmAc4eyFLuE5Bn6hTIGF8ZwSgP7fnosULi3UKr+anLIcFGBcztionYtC9bkV?=
 =?us-ascii?Q?BbrSeP8S6vzlQZm8I8WZM4igRATSwE1n1EEwqEmxAIjND+LWTZChekfmFbDk?=
 =?us-ascii?Q?7jPkhLdrF8TinQWI/IosnbtL/uQ/vVx5pkwQbr6LdCdwX4PbahSrqAcbZTkY?=
 =?us-ascii?Q?sLXdvCY4VUjeBB2LyDZnKLIZ862AIhCPjpQ2/6BS2LJKKSvFjp//p2hK89R4?=
 =?us-ascii?Q?31hgPKW6UH+ArTReHL96Oig=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d3lFTu5PeewErGZjZ5b7mYMK7/cdXwNayzsvva097iK2US+g8SJw12lZSMFoA0xAF7pmv+J5TBLdkEgiZUSaDSsYrpdhb7+u27K+VK/MpLV//nwWLVhq3/sxRk15+nG0PUz/RyUU+karioLFaXhv+UM7jKFUTCHCSQkv9bMREfdKm2QL0xlmA9qFaAMFGQIE2sDi0gHbpmtDNNow1pQV+CWCu5NMwCC5CUaA/jo3/oGn4BHS4qohhx1hsrUHQLAQbOyoFutt9JrMHT+vY4B9zya7XxpKmV4T8x29FPJv4xRWbYqAtayhSaXgJYAGhMPsMA6sz3u7t3CTLz/a+CvEHNqQGkPjUyiJ5Wd0h2c0OkEU89hMBfJqqzkVqinZoCkIe2wFikiOOiK9yjli63vmcZ+FU4opO96KKCnEtAzi1SBfcH/u6t6ZPJ4pMpKVijPj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:27:05.6966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dd5188-b066-4bcd-75ec-08de68868e75
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7446
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

On 12:13-20260209, Tom Rini wrote:
> On Mon, Feb 09, 2026 at 07:07:26PM +0100, Francesco Dolcini wrote:
> > On Mon, Feb 09, 2026 at 11:43:08AM -0600, Tom Rini wrote:
> > > On Mon, Feb 09, 2026 at 06:25:46PM +0100, Francesco Dolcini wrote:
> > > > On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
> > > > > On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
> > > > > > On 09:45-20260209, Francesco Dolcini wrote:
> > > > > > > + Bryan, Anshul
> > > > > > > 
> > > > > > > On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
> > > > > > > > Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7fa524,
> > > > > > > > everything was fine with b5213bbfdcb1.
> > > > > > > > 
> > > > > > > > Looking at the commits between the two revision, I would say that the
> > > > > > > > issue is with this series https://lore.kernel.org/all/20260127081652.506357-1-s-joshi@ti.com/
> > > > > > > 
> > > > > > > We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor common
> > > > > > > nodes to k3-*-r5.dtsi") that might be the root cause for this issue.
> > > > > > > 
> > > > > > 
> > > > > > Hi Francesco. Unfortunately, I don't have Verdin line of boards with me,
> > > > > > so I cannot reproduce this issue. This is also why I wasn't able to test
> > > > > > my series on my end and had requested board-specific maintainers do the
> > > > > > same.
> > > > > > 
> > > > > > Since I don't have the boards, could you run the following test to help
> > > > > > us ascertain which of the 2 suspected commits actually broke the boot?
> > > > > > 
> > > > > > * First drop my AM625 Verdin patch, and compile and copy the binaries,
> > > > > >   and boot.
> > > > > > * Then let my patch remain in the tree, and remove Anshul's refactor
> > > > > >   patch, and try the same thing again.
> > > > > > 
> > > > > > This could help us ascertain which commit broke boot, and we can try
> > > > > > fixing from that commit.
> > > > > 
> > > > > Sure, I can bisect it. 
> > > > > 
> > > > > Do this difference in the logs
> > > > > 
> > > > > Failed to set clock rates for '/a53@0': -22
> > > > > 
> > > > >   vs
> > > > > 
> > > > > Failed to set clock rates for '/a53@0': -61
> > > > > 
> > > > > ring any bell?
> > > > 
> > > > The boot failure start with commit 2ffab9da9142 ("Merge patch series
> > > > "Firewall ATF and OP-TEE memory regions in Sitara"").
> > > > 
> > > > With commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for
> > > > ATF/OPTEE addresses") the board still boots fine.
> > > > I have some concern that this commit is changing something, however
> > > > CONFIG_K3_ATF_LOAD_ADDR is 0x80000000, while before in the dtsi file it
> > > > was 0x70000000. I tried changing it back without any positive result,
> > > > I just got an EL3 exception.
> > > > 
> > > > Any more test I should do?
> > > 
> > > Should I revert that firewall series, at this point?
> > 
> > I did one more test.
> > 
> > It seems that the issue is some interaction between the firewall series
> > and commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for ATF/OPTEE
> > addresses").
> 
> That's the first part of the series, and to be clear I'd revert the
> whole series.

This series is confirmed to be working on TI boards. I just tested it
(again) on AM62 SK. See [0] for logs.
Verdin boards are the only ones that are reporting this issue. Is it
alright if we revert only the two Verdin-specific commits, and let the
rest (TI and PhyCore ones) stay as they are? The patches are pretty
un-connected to each other.

We are working on figuring out why Verdin is seeing these issues, in the
meantime.

[0] https://gist.github.com/jsuhaas22/b4d153eedf25e2269ddefc992c6020be

Thanks
Suhaas

> 
> > If I keep the firewall series in, and revert 24338c81ec2f, it boots.
> > 
> > IMO, unless we understand what is going on exactly, we should revert
> > both.
> > 
> > Suhaas: is current master working for you on the am62 SK or beagle play?
> 
> These changes boot and some pytests run on am64x_evm_a53, am62x_evm_a53
> and am62x_beagleplay_a53
> 
> -- 
> Tom


