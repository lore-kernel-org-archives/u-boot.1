Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77440E9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0CC183A47;
	Thu, 19 Feb 2026 11:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vz6maADd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930FB83AA9; Thu, 19 Feb 2026 11:40:29 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 904E683936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fh5e9zKPKxGuyiLZ5UQfhpTJa3oHHnUSrmQ4iwom85Wc8KED2Lx+UsmdRuDenpdMhEEyJywa7ul6BPrYZyXawsPs1rnN6Dm49YFM0jmBXx2+W5wI0GGmIqUjSjPz4fR2TvpA1OYSKoX/Xs+js91CG63YjnQTg6ElMOXagV1yk5/k3oCp0I7gWA/zgCu9FKiG0uV5oiLKs09GoPN9lBUvq0nuM95x5IjPfvh7zWV0h5pO1yfGGsbtGQhfuplJSo9BH+b0c17ZG8g832wtCS4JMXKCHghXAPeYGTO8G+m4Sn60rJnxRHP+/xyfchbT4+EgcUoEk0NB9pUg9oRm9KmknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FTM0YwJRlazW2j/Iun6A9gWQgAqoJpafhUKVnEWQng=;
 b=MvBdi75msCgXzVLj2EkkOz2/H91mAFoqLgxSSBJG84q6FOm/SQzqI6hReKm7EyZwY+6dK/euivhJio4Q1wKnG+5WpW5st6Sh7hDArWgWEbqY5qK8KR3nxZl7lMYEoHrNl7fph4g063h3udBw14QNz30YAgG8LLNVGDNfzukrP0bLEY3YBtpYvakmbdV6/0P7mhMyZPQicLJV5tmAHZHB8qSCLHWGzfCZh1Vpdnjn40hIBFVjqLja6DEX10r9meU6bUstzg5lt6hSRIkS6uTVQ4wXkKz6epVjnSA2scue2CuIzC5TxKogIzHEbAJX0ZadnMLrR8BSohXjrEMAwXNIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FTM0YwJRlazW2j/Iun6A9gWQgAqoJpafhUKVnEWQng=;
 b=vz6maADdu09UHzHmzHS/UtyuF6EX2mi1iI6nGn9SyFIaHLoSdkB4iofZoFNvzogv8jj5ntDeF5BVzgN6z6o4hEeVL+tl2CBv7SUUaiqcNqCEh4OPr6addiTRJsiQsNsSJ0DU2Vt4o1OoKzeImkfgPPU46/IliuRbevXU/9rgWkw=
Received: from SJ0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:a03:39f::15)
 by IA1PR10MB6832.namprd10.prod.outlook.com (2603:10b6:208:424::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 10:40:24 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::8e) by SJ0PR03CA0220.outlook.office365.com
 (2603:10b6:a03:39f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Thu,
 19 Feb 2026 10:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 10:40:22 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 04:40:22 -0600
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 04:40:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 04:40:22 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61JAeKXg1972063;
 Thu, 19 Feb 2026 04:40:21 -0600
Date: Thu, 19 Feb 2026 16:10:20 +0530
From: Suhaas Joshi <s-joshi@ti.com>
To: Bryan Brattlof <bb@ti.com>, <francesco@dolcini.it>
CC: Francesco Dolcini <francesco@dolcini.it>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260219104020.4gzvbit3b7qqcoqk@ula0507357>
References: <20260210092646.w5bugrscifmsh5px@ula0507357>
 <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
 <20260210105014.GB214446@francesco-nb>
 <20260211101113.GA176369@francesco-nb>
 <20260211112109.56e27kyy4coqpcbb@ula0507357>
 <20260213102015.GA10715@francesco-nb>
 <20260217132150.of5l5qirxkeizsne@ula0507357>
 <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
 <20260218145241.GA179991@francesco-nb>
 <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|IA1PR10MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9f6a6e-4087-4f42-b95a-08de6fa3491a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PJo9Y4OV5kiwMg2laSUc/VU+dgm0QILUyZ9VhgiTv3diwxU9BZ0tGpixtSyS?=
 =?us-ascii?Q?X+M66PskFmejD2D3NzeLw14f4KX73touQVdM/uOtIFU7VD/OAmX5g6GRucJ4?=
 =?us-ascii?Q?G4IEcEgDK2r1ua1VhNVxhbZ0o2vrtwvve6yU23g/SZHFrBeVLGaHmkbtHCCd?=
 =?us-ascii?Q?KUx02evPTw9RQttM3zwxUv4tSvB7f5/f9gfscps5yopneCIOpaQ1UDEk+xYU?=
 =?us-ascii?Q?7Uyv2Jc1mFYY/ilyEyoO/Dyf5dF+oSsBT2eh1wiXlfbeEIPEAnMYG+QIf6vg?=
 =?us-ascii?Q?vXV8Q2B9ndNbWttm6uXPL8LihFVocH7Qoe3LWQ76Ku9dzx5xadVci8D0xYvY?=
 =?us-ascii?Q?UTi9bAjJMkMun/6XjZJQj7SW921Rxd51hXMBsqVG/MDffTI4YKgVTzI2JuWH?=
 =?us-ascii?Q?FMb4ZwgXHudXKhc3AS/uKNUGk/1VyYP5nWlzG1AxoMidZ/GAvaf60/qWIZ1A?=
 =?us-ascii?Q?6YoBRnj9UxwgJ+5w70ZlghnHO/MiWA/D4NBkHXsxY6/9OP4ZmuPD3VEpnJ74?=
 =?us-ascii?Q?nzJiJT+WcQkqQjI2ebvBhUjq5ru4IDL+i5hHCN1Q474OMWTATxB6gkrwVNDf?=
 =?us-ascii?Q?+mObT9hLY3p/c1P/pM6d5zzF1CS2WdimIN8b8az1+9qr00gTKk+9FgIeEY1l?=
 =?us-ascii?Q?41oDUIoHoIO1GwxBb4zGqZkr3HcGdkBF1YHQV5kKNJLoNvI0mg0yeoS4Qp+z?=
 =?us-ascii?Q?8MX9Ba6mvDCq2TJMbesfO/jU3c7luSpk1i2+1UPQZ+LKEzdbm9BJx/UvwADT?=
 =?us-ascii?Q?EfHpibtabTJmq6dHjJ/XWptrR74xqA1bx9dsXNKrsLSN6TTyVvlZki5exldo?=
 =?us-ascii?Q?5CloyZ+oyhiC6SWeoZA74nCqLERntpysVWJeLsoZKyZv2FbpXWzPPJTxZIP7?=
 =?us-ascii?Q?lP0qmsPrzAkHEu6p+9gLUr8oDGlu2K4x+FY2CUjDGZFDTk0LNQpcSixehOGd?=
 =?us-ascii?Q?vkfLvpzGovvIhloU7zKYp1sEjkg+X9Nuc2+6yw8wgIyrRv+2WsU95dxR/yIT?=
 =?us-ascii?Q?SQpYd1Tn2rpoABtSfHdrZpb5i5pL1qCTPukGJ+DAX5yCufpcLmNoAXPT3C/s?=
 =?us-ascii?Q?O3qMQcreIQy+QADOmBBwaLXeGn4La6z9XxUeBB/9624ty6+AxQopKHU1qKQh?=
 =?us-ascii?Q?OzFS+pVwtP8jImgCtzfd6BGvRtoHbE0AQ1beveJSEK9YX8+iGffnA4vf2wtC?=
 =?us-ascii?Q?knxScJfwL3DvpH5p2DNoHsmrY+xaSKbA0ugANvVwXGkDprL5vwL7ak/zbI3a?=
 =?us-ascii?Q?JX0nuqpy3arECJglJC+BxQX9Vr6IJV+7lal9abVLZTxPFU3Q80bOtikMXSqB?=
 =?us-ascii?Q?MKgmUIagy4BsbVZORr5JjRP/hzGzKt7yu+hR4+77rzPEZZPtpMwU4+ql6YX+?=
 =?us-ascii?Q?c910NuSt6IjQFkZj6PQzMQ1oTRSLzwvuP/AaCkZM8OuuTQSNxnCLhAkf/o44?=
 =?us-ascii?Q?xPlAEOWJFrs0IlIJ9RWfcnAN6iIDb77i3WVLQjHQRtkJaEXT5yBIcYfOONzh?=
 =?us-ascii?Q?6kjbNNXAX1gcfYVYoQMulIzdTGsEKmPATmlESBs2jqTnF/qCJEbn3mMT6AXU?=
 =?us-ascii?Q?HTB177Xg33tHDuOxS/4tG/nZ9536eLJ1/MN0whEfcO0FL+JWie0UiOd6BldC?=
 =?us-ascii?Q?/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kOuAz5SbIN/PJbcxdMUBOW/VMcXJVkNVjYzojchpuRFotbJLyHeiDFLTlg5LeY2lk6HN0kWevj7oW6ZkRmhMb8qpkyZ/D4uI7zd5lg8lKvaeTr3goMZPQhz3wQQEx0Zli/bVeWQCO79dKiLHgH6xX6pDVUsQw70a+bWCQETCg6Y8daTQkj9+jMerOXyLL8+TkfTLDuuMDairaaV0/eXWlVH1OAf/hukvnS6fjHl8gwNB2/gbKLToucBcccVO5s8dP0ZW1CBdhL60cJ520771II/7wyd0HUFW9vawzg/XCG7u3ab5EHjbFQK9ZDRPNLbfYOnr2Ro8VGCSInPCv+J0anm5e927EWsjhyruJvdEEFGxaOFc/UdZNWl7NOLR/wjmrMrQ/bh31YTd6tg/l1fhGirE4TKb5P9QYRUl9+v/QizrLYOB2cWPjlFCeEw2+Pr2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:40:22.8715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f6a6e-4087-4f42-b95a-08de6fa3491a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6832
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

On 19:46-20260218, Bryan Brattlof wrote:
> On February 18, 2026 thus sayeth Francesco Dolcini:
> > Hello Suhaas,
> > 
> > On Wed, Feb 18, 2026 at 07:59:20AM +0100, Francesco Dolcini wrote:
> > > On Tue, Feb 17, 2026 at 06:51:50PM +0530, Suhaas Joshi wrote:
> > > > On 11:20-20260213, Francesco Dolcini wrote:
> > > > > On Wed, Feb 11, 2026 at 04:51:09PM +0530, Suhaas Joshi wrote:
> > > > > > On 11:11-20260211, Francesco Dolcini wrote:
> > > > > > > On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
> > > > > > > > On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> > > > > > > > > Do you mind copying a boot log to a pastebin for me? I thought I had one 
> > > > > > > > > of these boards but I'm still digging around for it. 0x80000000 should 
> > > > > > > > > be where we load TFA now days unless some boards have opted out of 
> > > > > > > > > letting U-Boot move it to the bottom of DRAM
> > > > > > > > 
> > > > > > > > Here some more logs
> > > > > > > > 
> > > > > > > > https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
> > > > > > > > 
> > > > > > > > The files are named with the commit sha that is tested.
> > > > > > > > 
> > > > > > > > On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> > > > > > > > > Verdin boards are the only ones that are reporting this issue. Is it
> > > > > > > > > alright if we revert only the two Verdin-specific commits, and let the
> > > > > > > > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > > > > > > > un-connected to each other.
> > > > > > > > 
> > > > > > > > Verdin AM62 should not have anything special, the code is all there for
> > > > > > > > everyone to see, including the defconfig, the DT and so on, and the changes
> > > > > > > > we are talking about to me are self contained withing the SoC. Something
> > > > > > > > is wrong, and we are not understanding what yet.
> > > > > > > > 
> > > > > > > > I just retested once more 42b3ee7fa524 and it just hung, you never know
> > > > > > > > if I did something wrong. And for what matter this was spotted by our
> > > > > > > > CI.
> > > > > > > > 
> > > > > > > > > We are working on figuring out why Verdin is seeing these issues, in the
> > > > > > > > > meantime.
> > > > > > > > 
> > > > > > > > Anything I can do let me know.
> > > > > > > > 
> > > > > > > > If it matter the board that I am currently testing has 1GiB DDR RAM, and
> > > > > > > > the SoC is a AM6252ATCGHAALW. 
> > > > > > > 
> > > > > > > I was able to trace the issue to the get_ram_size() in
> > > > > > > verdin-am62.c:dram_init().
> > > > > > > 
> > > > > > > That function walks the addressable memory range to dynamically detect
> > > > > > > how much memory is available.
> > > > > > > 
> > > > > > > Not sure on the proper way to fix it however, Bryan? Suhaas?
> > > > > > 
> > > > > > Yes, this does seem to be the issue, even in my digging. I have sent a
> > > > > > patch to fix this. But since I don't have boards, I have not tested
> > > > > > this. Could you please test this and let us know if it works, or if
> > > > > > there are any other issues that pop up?
> > > > > 
> > > > > With commit f9ffeec4bdcf ("board: toradex: Make A53 get RAM size from DT
> > > > > in K3 boards") merged we had our CI running on our whole board farm
> > > > > last night.
> > > > > 
> > > > > Good news: the issue is confirmed to be fixed on Verdin AM62P and Verdin
> > > > > AM62 [Quad|Dual] with [1|2]GB RAM.
> > > > 
> > > > That's great!
> > > > > 
> > > > > Bad news: we we do still have a boot failure regression on Verdin AM62
> > > > > single core with 512MB RAM. I have no idea if this is the same issue or
> > > > > a different one, but from the logs it look different (despite that I
> > > > > decided to keep using this email thread and not start a new one).
> > > > > 
> > > > > The failing board from the logs uses a AM6231ASGGHAALW SoC, maximum
> > > > > frequency 1GHz, we also have another device failing, single core again,
> > > > > with maximum frequency 800MHz, the working one have 1.4GHz max
> > > > > frequency.
> > > > > 
> > > > > Worth noticing the errors
> > > > >   Failed to set clock rates
> > > > > 
> > > > > These are new compared to the previous U-Boot release, it affects also
> > > > > other boards, and I have no idea if this is related to this issue or not.
> > > > > 
> > > > > Logs of the failing device (U-Boot is commit f9ffeec4bdcf1da655a0ffea482062adde78fee8)
> > > > > 
> > > > > U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> > > > > Failed to set clock rates for '/a53@0': -22
> > > > > SPL initial stack usage: 13456 bytes
> > > > > Trying to boot from MMC1
> > > > > Authentication passed
> > > > > Authentication passed
> > > > > Authentication passed
> > > > > Loading Environment from nowhere... OK
> > > > > init_env from device 9 not supported!
> > > > > Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> > > > > 
> > > > 
> > > > I don't think this one is related to the firewall series. Not really
> > > > sure what the issue is. Just to rule this series out -- could you drop
> > > > my patch(es) and check if this specific device boots?
> > > > 
> > > > Was this device booting earlier? Could it be a build misconfig, since it
> > > > says that it can't detect an image signing certificate?
> > > 
> > > This is a regression with 2026.04. 2026.04-rc never booted on this device, and
> > > before commit f9ffeec4bdcf1da655a0ffea482062adde78fee8 none of the verdin
> > > am62[p] variants were booting for multiple bugs that were present in the
> > > release.
> > > 
> > > 2026.01 is booting fine on this device, with plain vanilla U-Boot.
> > 
> > The issue is still there, and it seems again related with your changes.
> > 
> > Can you help? Any test that I should do?
> > 
> > 
> > 
> > v2026.01 booting fine
> > =====================
> > 
> > U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:15 +0100)
> > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > Changed A53 CPU frequency to 800000000Hz (K grade) in DT
> > SPL initial stack usage: 13512 bytes
> > Trying to boot from MMC1
> > Authentication passed
> > Authentication passed
> > Authentication passed
> > Loading Environment from nowhere... OK
> > init_env from device 9 not supported!
> > Authentication passed
> > Authentication passed
> > Starting ATF on ARM64 core...
> > 
> > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > 
> > U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > SPL initial stack usage: 2048 bytes
> > Trying to boot from MMC1
> > Authentication passed
> > Authentication passed
> > 
> > 
> > U-Boot 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> > 
> > SoC:   AM62X SR1.0 HS-FS
> > Reset reason: POR
> > DRAM:  512 MiB
> > optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> > Core:  159 devices, 34 uclasses, devicetree: separate
> > MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> > Loading Environment from MMC... Reading from MMC(0)... OK
> > In:    serial@2800000
> > Out:   serial@2800000
> > 
> > 2026.04, commit 3243a73102c3 ("Merge branch 'master' of
> > https://source.denx.de/u-boot/custodians/u-boot-sh"), booting fine
> > =================================================================
> > 
> > 
> > U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:33 +0100)
> > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > Failed to set clock rates for '/a53@0': -22
> > SPL initial stack usage: 13512 bytes
> > Trying to boot from MMC1
> > Authentication passed
> > Authentication passed
> > Authentication passed
> > Loading Environment from nowhere... OK
> > init_env from device 9 not supported!
> > Authentication passed
> > Authentication passed
> > Starting ATF on ARM64 core...
> > 
> > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > 
> > U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > SPL initial stack usage: 2048 bytes
> > Trying to boot from MMC1
> > Authentication passed
> > Authentication passed
> > 
> > 
> > U-Boot 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> > 
> > SoC:   AM62X SR1.0 HS-FS
> > Reset reason: POR
> > DRAM:  512 MiB
> > optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> > Core:  160 devices, 35 uclasses, devicetree: separate
> > MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> > Loading Environment from MMC... Reading from MMC(0)... OK
> > In:    serial@2800000
> > Out:   serial@2800000
> > Err:   serial@2800000
> > Model: Toradex 0071 Verdin AM62 Solo 512MB V1.2A
> > 
> > 
> > 2026.04, current master, commit 8666b16015d4, NOT working
> > =========================================================
> > 
> > 
> > U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:31 +0100)
> > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > Failed to set clock rates for '/a53@0': -22
> 
> Hmm It's interesting to see this start to fail. 
> 
> > SPL initial stack usage: 13464 bytes
> > Trying to boot from MMC1
> > Authentication passed
> > Authentication passed
> > Authentication passed
> > Loading Environment from nowhere... OK
> > init_env from device 9 not supported!
> > Authentication passed
> > Authentication passed
> > Starting ATF on ARM64 core...
> > 
> > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > 
> > U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:54 +0100)
> > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > 
> 
> I'm suspicious of the spl_enable_cache(). I've witnessed issues if we 
> add MMU entries that are not backed by DRAM which can cause the MMU to 
> crash the CPU.
> 

I looked into that function.

This is my current theory:

The end address of 512MB RAM is 0x9FFFFFFF. This is the same as OPTEE's
end address.

If you look into the `spl_enable_cache()` function, you'll see that it
is subtracting the size of page tables from the top of RAM, i.e. it is
placing the page table at the end of RAM, i.e. it is placing the page
table in OPTEE's memory region. Since this region wasn't protected by
firewalls earlier, everything worked. But now the firewall disallows
U-Boot's access to the page table.

On 1GB and 2GB devices, there's a great deal of distance between the
end addresses of RAM (0xBFFFFFFF and 0xFFFFFFFF respectively) and the
end address of OPTEE. So we don't run into this issue.

Francesco -- Just to confirm if this indeed is the case, could you
change CONFIG_K3_OPTEE_LOAD_ADDR to any other free location, and check
if the device boots?

Thanks
Suhaas

> I wonder (complete guess right now) if we're passing the correct DRAM 
> density to the A53 SPL?
> 
> ~Bryan
