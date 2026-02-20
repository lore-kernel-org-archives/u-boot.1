Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD5FC531EA
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 01:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A3783946;
	Fri, 20 Feb 2026 02:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mP82HJJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F4DC83AA9; Fri, 20 Feb 2026 02:07:00 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44B998366F
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 02:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pY+jwfBFh+u3f7pW8Cki2IximjXB+B5sxtGULyDSXeXW5yXXem4HViltsfpKcJTU673C2wEtd+EyxkowoXwi31VfQLMQ69Oadak9R/jHqOKUlyNKOfz8Io3/YFU5Ff2t53Zqe9yvX991dn8qV6DLfs4y354WabgHFdczgBi8Obis1pQTrT31/51SNHawH2yxsuvkbKsVgRNRFK8F3oCCcWQpv/spMt0+BzjPalvL55Kx72nuDx4oYTcafS3yGbnR1PTjO+b/D3Eykk+iKxmaxPjlMcD8uSiEL4OLJHTN1hmPrDdt2c8qq1yEd46U7VAvunHKGY94mDmjbDvv4N41WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OF2rxcfpTXdfE1PZRFz7lXRMBffl02HGYBtmg69IIe0=;
 b=WB3jc8HIZyz9iCg9HSPy0rSO6zVGemyh/X0GwEM8NYhS+7YcB+DCQ54utw8jwkyYrL8Jr6vyvwMbUanqbX7JkTvnBAefcz9qqDu0PwQDLSkxtkpp/T0D9Jt9yZYJyiIbfgCeuR7BFuK9FrSMaVH7ftxV8YDU6hOPI8aU+cwaekGA+x+iqqdpIp0XAMCpBT6qicgvW+5UK6PMiK0h8sCKH4Hiy7l0SjAngxek76iVsIuvW8FEm2+IcAU4PkE4ifQrf/pDYepyPR4zRofjE+mO12Bp1WGyEtXV8i53NYH6zllKNvjuCJGwfipJejEURGEhoW/xOd/QcC/u0PDc06ildA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OF2rxcfpTXdfE1PZRFz7lXRMBffl02HGYBtmg69IIe0=;
 b=mP82HJJCGyCcMWuRNEvkUX23yawnzr7D0UJ+ME1vqlbMxowFFeiZKBc5jyvHWM7L/+Mi0k7iR8tMMpLCm4KB7dIIvCvH4SXBi7eG8+4xjvcyQp+VHUG3eib3ITo8IGG1a1FV4DH/cvFTc3HhvVK0wZUt8bRqzn1FaStqUzQSEvw=
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 01:05:29 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::46) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Fri,
 20 Feb 2026 01:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 01:05:28 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 19:05:28 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Feb
 2026 19:05:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Feb 2026 19:05:27 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61K15R1W3012603;
 Thu, 19 Feb 2026 19:05:27 -0600
Date: Thu, 19 Feb 2026 19:05:27 -0600
From: Bryan Brattlof <bb@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260220010527.mpji63idcn7vj74w@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260210105014.GB214446@francesco-nb>
 <20260211101113.GA176369@francesco-nb>
 <20260211112109.56e27kyy4coqpcbb@ula0507357>
 <20260213102015.GA10715@francesco-nb>
 <20260217132150.of5l5qirxkeizsne@ula0507357>
 <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
 <20260218145241.GA179991@francesco-nb>
 <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
 <20260219104020.4gzvbit3b7qqcoqk@ula0507357>
 <20260219193044.GA203975@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260219193044.GA203975@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 450cdcc6-c7e0-4ef3-56cb-08de701c238a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzZuNloxUUZwcFN5aVNXSGxneVVLOEo2Zm40USsrRXAzMFFWbTdFL3Q2UXZw?=
 =?utf-8?B?ejBqRGV2a202VENwYzdXaE1adzNpZ3FpVW9OdFRBdFV2UGRuTm1TSEdsZTM3?=
 =?utf-8?B?UkJPMzNTWHkreUtFbWp3WG1yTVN0VlVJdnREMEE2dHZiNHJyeUFrVE03T2xy?=
 =?utf-8?B?NnJ2UGRKalU0WFNRMm16OUlucVNJTC9RQzBkb2pJa3dOTkdLT3grOThzbkJ4?=
 =?utf-8?B?ZUtOcWhoS1JDa3VIazhPQkRnOE8zcWNvYStjNVp6MDYwWWt6dVZFTURiV1pk?=
 =?utf-8?B?VWdBVkJwVEw3TGlFTHNFbGIzcUh6eW9HQ3JtZXVRdGUrZ0RPVElYMjBhNldF?=
 =?utf-8?B?c1l0ZVJGellUWUk0Z2ZoMTA0Wlo4RjN5T01LeGZCb0ZNRUs1WW16SXRTRVZ0?=
 =?utf-8?B?SlFJUlhNNGVzYVVZMFJ3VEdWZFVBeHVYbExEVnZPU3RkSkg2Ris5L1pRVmRi?=
 =?utf-8?B?WmErUDZ0Wld5dW5yc1pPNDRZZDBwcG5lMGw4YTE2S3FwanlxUEZhMjZEcFo3?=
 =?utf-8?B?OUpod2YwQ2IwME5JNHg0VzlGb3dUQjhTNU96R1diWXFlZVlvTEF3SG1aRXNz?=
 =?utf-8?B?cmxQYVhpam9waFpmanFnditzMGVzdys2SWhCWSsvcW9UMVZzbW85amNBMWww?=
 =?utf-8?B?Y2Y4V05GeWpZRndxbmQ3NUo1Y3dJVmdPK1U4RTlYNUpFakNQT2dtMXFNaG0v?=
 =?utf-8?B?UklmUGhjMUpLNUY0aTVWbUxQK285N3NDMUZMWCtkOEZMay9WVTV2TW94b2g1?=
 =?utf-8?B?OG5qSVloS25wOXkvYjJmK09zbkVETHBLb3d1Y0QvaEwxYzJNRnE1UE1oSEFU?=
 =?utf-8?B?RTZ4TXUzVERZWlQ5T1oxK0JwNEY0UjdaWWJyMWxZVFp0ZVJHTzAxUk1jVkQr?=
 =?utf-8?B?TmlGTVRwVkRLZXNPN0YyWE1ZdUlTVnRBZStBMVdQVWdSek52NlpoZ0NRRFhG?=
 =?utf-8?B?ajBCM1UzSXYvRWpMdTJrOXpJMmpYcHpLVU1sUEttajVYQXVPSXdrZjl5K2NG?=
 =?utf-8?B?bDN0aDNTWGpZK0k3MndxVDR2Zm9HQXdRczVVOHphTGVsWVgzNkFEa0VKYXNu?=
 =?utf-8?B?NEhyYXBNK0J6UXoxTlZOVVpxVFpWZk5FNWJ1bnU1LzBQK3JuZktHZUxxT3or?=
 =?utf-8?B?WTN3bWxHdkNNOUkrVnJnUHpBSFdrbHgyVXdrMWNwbllSVGFTTGN3QkhNRk9i?=
 =?utf-8?B?UzBSMitrS29JQ1E0bE4zSFZVbzdqYlVoWHE3M0ZrZjl1cGxmWEZBZFBHRGp6?=
 =?utf-8?B?c3NhbXdiYTdtaTQrejI2NXJ0NGFreURubk03R2VXWGI1dzhPejM5cGRtc1F2?=
 =?utf-8?B?VHVaR3d3dVJBMUg1K1YraEYyb0kxaVFEdUpieFpSOFJ3MXhJc2hwL1EvVzdi?=
 =?utf-8?B?aWwyY2hFQ3NlMy9vRWF4SmdPZ2ZGVk1scDVENUdNcG94OWN6a1RiZFNaOEVJ?=
 =?utf-8?B?RXpYRjI4QjhPWTdmNTF5ZWpjeldlajN1UnoxTDZranN1dDVzWmpVMmZJdFlh?=
 =?utf-8?B?MVZrdzdhY1dtdDNGTDNQMVlvVXVnWVhwRDRvMFRlYUQ5cXcxVW9nYWhmLzVU?=
 =?utf-8?B?YmdhalJGNWsrcjJzZEpTMlJZS0RSTTdYRWxjWUZOeVpFWldDTmZCS1VZTEc5?=
 =?utf-8?B?cjAzMW9IT0FwenIzSkFZaGxpdVROeitMSGhwQWxKdmc2cThJM1B4Y2lnYzFw?=
 =?utf-8?B?bFNES2hiT0Nxd3U1YmRPSkJveDQ1akgrYjJRTXJGZHZpeEk1R3NScC8vbXk1?=
 =?utf-8?B?S09rWlhZVE9hLzhVQWZYSmxyRFFHcVJXMXdpbTdLUERJOXluYVJsMVdYMSs1?=
 =?utf-8?B?UjJFNkR5djUza0VTZC9ZU1M0d0RFSW9oeHhNSjlib3h0b0dtWHA4U3V2N1JM?=
 =?utf-8?B?Z1NVaXVXSkViL3NyQ1pMRFBBNXdKSWlWWTZTSVZranBCb0lBdjVqWElaSEdJ?=
 =?utf-8?B?MHFHQzFjOXkzeHZ2ZDdKWWozZklqVTIxcXBoOWdaNm8yb3ZhNGtHb25iQXBW?=
 =?utf-8?B?SnJScHY5VEJQcFd1WVJ5d0NhU2xZQmROcmhSbmEvd092VGdSa09JRU1Ob2dm?=
 =?utf-8?B?QlZXSUIzdzMxdktzUURsQ2NmV3dzeFE2OS9WQkJoWkE1VitodUVwOUU4ejZO?=
 =?utf-8?B?NlpDdVZBSUdRRUVMQ0ZJNTRnZ2NqczRlR1FIdXJ4aCtSYitzeU85MVMwUnZt?=
 =?utf-8?B?SGc9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +mgRHJsWYT14buHTjeT/Kv5oQlZhtdbXqDQXiq+81yq/Ky3yTe3oyQaXHhVYhi+fB329ro2SCZdMz4//pzJqQhpxKQWT14fLhiGsQJFdmD2tzjT7+7aAOKwfLeGmAShc1WNAYH78GyyOLxce5nLa+yD6ap6k1Fp/nzDeiXoo04xkQUBaCx1Gn/XwZJDhNf6WvtN4cVk3lbtmTVoBS/rksWVO1CFNgNIRi4dwTTmnU8mIgd0ZOJQBaalPolmswFXU2nfbuo2xBi1CUNDKNLDVnxRaLqXbPNhXcnpia3Va/6AZnMzfPSXRU+HT8CqKoDpKMbgWCs/bPSk1oT24vpsDmhdzugs2R+dkQ2Vwd2cxhW++lIl+hFAYxsyXJV3vKZKwxnxOu+XNAD7hWvUn7XX26w9k0Nl3kg7nijrEAj+Fgjdk1P3AHgxMI3GgCzDJ2Vuq
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 01:05:28.9549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450cdcc6-c7e0-4ef3-56cb-08de701c238a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
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

On February 19, 2026 thus sayeth Francesco Dolcini:
> On Thu, Feb 19, 2026 at 04:10:20PM +0530, Suhaas Joshi wrote:
> > On 19:46-20260218, Bryan Brattlof wrote:
> > > On February 18, 2026 thus sayeth Francesco Dolcini:
> > > > Hello Suhaas,
> > > > 
> > > > On Wed, Feb 18, 2026 at 07:59:20AM +0100, Francesco Dolcini wrote:
> > > > > On Tue, Feb 17, 2026 at 06:51:50PM +0530, Suhaas Joshi wrote:
> > > > > > On 11:20-20260213, Francesco Dolcini wrote:
> > > > > > > On Wed, Feb 11, 2026 at 04:51:09PM +0530, Suhaas Joshi wrote:
> > > > > > > > On 11:11-20260211, Francesco Dolcini wrote:
> > > > > > > > > On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
> > > > > > > > > > On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> > > > > > > > > > > Do you mind copying a boot log to a pastebin for me? I thought I had one 
> > > > > > > > > > > of these boards but I'm still digging around for it. 0x80000000 should 
> > > > > > > > > > > be where we load TFA now days unless some boards have opted out of 
> > > > > > > > > > > letting U-Boot move it to the bottom of DRAM
> > > > > > > > > > 
> > > > > > > > > > Here some more logs
> > > > > > > > > > 
> > > > > > > > > > https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
> > > > > > > > > > 
> > > > > > > > > > The files are named with the commit sha that is tested.
> > > > > > > > > > 
> > > > > > > > > > On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> > > > > > > > > > > Verdin boards are the only ones that are reporting this issue. Is it
> > > > > > > > > > > alright if we revert only the two Verdin-specific commits, and let the
> > > > > > > > > > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > > > > > > > > > un-connected to each other.
> > > > > > > > > > 
> > > > > > > > > > Verdin AM62 should not have anything special, the code is all there for
> > > > > > > > > > everyone to see, including the defconfig, the DT and so on, and the changes
> > > > > > > > > > we are talking about to me are self contained withing the SoC. Something
> > > > > > > > > > is wrong, and we are not understanding what yet.
> > > > > > > > > > 
> > > > > > > > > > I just retested once more 42b3ee7fa524 and it just hung, you never know
> > > > > > > > > > if I did something wrong. And for what matter this was spotted by our
> > > > > > > > > > CI.
> > > > > > > > > > 
> > > > > > > > > > > We are working on figuring out why Verdin is seeing these issues, in the
> > > > > > > > > > > meantime.
> > > > > > > > > > 
> > > > > > > > > > Anything I can do let me know.
> > > > > > > > > > 
> > > > > > > > > > If it matter the board that I am currently testing has 1GiB DDR RAM, and
> > > > > > > > > > the SoC is a AM6252ATCGHAALW. 
> > > > > > > > > 
> > > > > > > > > I was able to trace the issue to the get_ram_size() in
> > > > > > > > > verdin-am62.c:dram_init().
> > > > > > > > > 
> > > > > > > > > That function walks the addressable memory range to dynamically detect
> > > > > > > > > how much memory is available.
> > > > > > > > > 
> > > > > > > > > Not sure on the proper way to fix it however, Bryan? Suhaas?
> > > > > > > > 
> > > > > > > > Yes, this does seem to be the issue, even in my digging. I have sent a
> > > > > > > > patch to fix this. But since I don't have boards, I have not tested
> > > > > > > > this. Could you please test this and let us know if it works, or if
> > > > > > > > there are any other issues that pop up?
> > > > > > > 
> > > > > > > With commit f9ffeec4bdcf ("board: toradex: Make A53 get RAM size from DT
> > > > > > > in K3 boards") merged we had our CI running on our whole board farm
> > > > > > > last night.
> > > > > > > 
> > > > > > > Good news: the issue is confirmed to be fixed on Verdin AM62P and Verdin
> > > > > > > AM62 [Quad|Dual] with [1|2]GB RAM.
> > > > > > 
> > > > > > That's great!
> > > > > > > 
> > > > > > > Bad news: we we do still have a boot failure regression on Verdin AM62
> > > > > > > single core with 512MB RAM. I have no idea if this is the same issue or
> > > > > > > a different one, but from the logs it look different (despite that I
> > > > > > > decided to keep using this email thread and not start a new one).
> > > > > > > 
> > > > > > > The failing board from the logs uses a AM6231ASGGHAALW SoC, maximum
> > > > > > > frequency 1GHz, we also have another device failing, single core again,
> > > > > > > with maximum frequency 800MHz, the working one have 1.4GHz max
> > > > > > > frequency.
> > > > > > > 
> > > > > > > Worth noticing the errors
> > > > > > >   Failed to set clock rates
> > > > > > > 
> > > > > > > These are new compared to the previous U-Boot release, it affects also
> > > > > > > other boards, and I have no idea if this is related to this issue or not.
> > > > > > > 
> > > > > > > Logs of the failing device (U-Boot is commit f9ffeec4bdcf1da655a0ffea482062adde78fee8)
> > > > > > > 
> > > > > > > U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
> > > > > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
> > > > > > > Failed to set clock rates for '/a53@0': -22
> > > > > > > SPL initial stack usage: 13456 bytes
> > > > > > > Trying to boot from MMC1
> > > > > > > Authentication passed
> > > > > > > Authentication passed
> > > > > > > Authentication passed
> > > > > > > Loading Environment from nowhere... OK
> > > > > > > init_env from device 9 not supported!
> > > > > > > Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
> > > > > > > 
> > > > > > 
> > > > > > I don't think this one is related to the firewall series. Not really
> > > > > > sure what the issue is. Just to rule this series out -- could you drop
> > > > > > my patch(es) and check if this specific device boots?
> > > > > > 
> > > > > > Was this device booting earlier? Could it be a build misconfig, since it
> > > > > > says that it can't detect an image signing certificate?
> > > > > 
> > > > > This is a regression with 2026.04. 2026.04-rc never booted on this device, and
> > > > > before commit f9ffeec4bdcf1da655a0ffea482062adde78fee8 none of the verdin
> > > > > am62[p] variants were booting for multiple bugs that were present in the
> > > > > release.
> > > > > 
> > > > > 2026.01 is booting fine on this device, with plain vanilla U-Boot.
> > > > 
> > > > The issue is still there, and it seems again related with your changes.
> > > > 
> > > > Can you help? Any test that I should do?
> > > > 
> > > > 
> > > > 
> > > > v2026.01 booting fine
> > > > =====================
> > > > 
> > > > U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:15 +0100)
> > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > Changed A53 CPU frequency to 800000000Hz (K grade) in DT
> > > > SPL initial stack usage: 13512 bytes
> > > > Trying to boot from MMC1
> > > > Authentication passed
> > > > Authentication passed
> > > > Authentication passed
> > > > Loading Environment from nowhere... OK
> > > > init_env from device 9 not supported!
> > > > Authentication passed
> > > > Authentication passed
> > > > Starting ATF on ARM64 core...
> > > > 
> > > > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > > > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > > > 
> > > > U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > SPL initial stack usage: 2048 bytes
> > > > Trying to boot from MMC1
> > > > Authentication passed
> > > > Authentication passed
> > > > 
> > > > 
> > > > U-Boot 2026.01 (Feb 18 2026 - 12:12:38 +0100)
> > > > 
> > > > SoC:   AM62X SR1.0 HS-FS
> > > > Reset reason: POR
> > > > DRAM:  512 MiB
> > > > optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> > > > Core:  159 devices, 34 uclasses, devicetree: separate
> > > > MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> > > > Loading Environment from MMC... Reading from MMC(0)... OK
> > > > In:    serial@2800000
> > > > Out:   serial@2800000
> > > > 
> > > > 2026.04, commit 3243a73102c3 ("Merge branch 'master' of
> > > > https://source.denx.de/u-boot/custodians/u-boot-sh"), booting fine
> > > > =================================================================
> > > > 
> > > > 
> > > > U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:33 +0100)
> > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > Failed to set clock rates for '/a53@0': -22
> > > > SPL initial stack usage: 13512 bytes
> > > > Trying to boot from MMC1
> > > > Authentication passed
> > > > Authentication passed
> > > > Authentication passed
> > > > Loading Environment from nowhere... OK
> > > > init_env from device 9 not supported!
> > > > Authentication passed
> > > > Authentication passed
> > > > Starting ATF on ARM64 core...
> > > > 
> > > > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > > > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > > > 
> > > > U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > SPL initial stack usage: 2048 bytes
> > > > Trying to boot from MMC1
> > > > Authentication passed
> > > > Authentication passed
> > > > 
> > > > 
> > > > U-Boot 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
> > > > 
> > > > SoC:   AM62X SR1.0 HS-FS
> > > > Reset reason: POR
> > > > DRAM:  512 MiB
> > > > optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
> > > > Core:  160 devices, 35 uclasses, devicetree: separate
> > > > MMC:   mmc@fa10000: 0, mmc@fa00000: 1
> > > > Loading Environment from MMC... Reading from MMC(0)... OK
> > > > In:    serial@2800000
> > > > Out:   serial@2800000
> > > > Err:   serial@2800000
> > > > Model: Toradex 0071 Verdin AM62 Solo 512MB V1.2A
> > > > 
> > > > 
> > > > 2026.04, current master, commit 8666b16015d4, NOT working
> > > > =========================================================
> > > > 
> > > > 
> > > > U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:31 +0100)
> > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > Failed to set clock rates for '/a53@0': -22
> > > 
> > > Hmm It's interesting to see this start to fail. 
> 
> This is fixed with another patch, and I would confirm that this is
> unrelated to the issue we are debugging here
> 
> > > > SPL initial stack usage: 13464 bytes
> > > > Trying to boot from MMC1
> > > > Authentication passed
> > > > Authentication passed
> > > > Authentication passed
> > > > Loading Environment from nowhere... OK
> > > > init_env from device 9 not supported!
> > > > Authentication passed
> > > > Authentication passed
> > > > Starting ATF on ARM64 core...
> > > > 
> > > > NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> > > > NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> > > > 
> > > > U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:54 +0100)
> > > > SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> > > > 
> > > 
> > > I'm suspicious of the spl_enable_cache(). I've witnessed issues if we 
> > > add MMU entries that are not backed by DRAM which can cause the MMU to 
> > > crash the CPU.
> > > 
> > 
> > I looked into that function.
> > 
> > This is my current theory:
> > 
> > The end address of 512MB RAM is 0x9FFFFFFF. This is the same as OPTEE's
> > end address.
> > 
> > If you look into the `spl_enable_cache()` function, you'll see that it
> > is subtracting the size of page tables from the top of RAM, i.e. it is
> > placing the page table at the end of RAM, i.e. it is placing the page
> > table in OPTEE's memory region. Since this region wasn't protected by
> > firewalls earlier, everything worked. But now the firewall disallows
> > U-Boot's access to the page table.
> > 
> > On 1GB and 2GB devices, there's a great deal of distance between the
> > end addresses of RAM (0xBFFFFFFF and 0xFFFFFFFF respectively) and the
> > end address of OPTEE. So we don't run into this issue.
> > 
> > Francesco -- Just to confirm if this indeed is the case, could you
> > change CONFIG_K3_OPTEE_LOAD_ADDR to any other free location, and check
> > if the device boots?
> 
> Any suggestion on a good address to use?
> 
> I tried 0x83800000, and the result is not booting in different ways,
> failing in different ways

Ah so for our am62 SiP package (which also has 512MB of DDR) we ended up 
moving OP-TEE down to 0x80080000[0] to let U-Boot relocate itself 
without crashing into OPTEE or TFA

Because tiboot3.bin starts off the main domain by sending the A53 to  
TFA -> OPTEE -> SPL there isn't a great way to pass along the info to 
TFA on where to go next at run-time.

So for this to work we will need to adjust the jump defaults in both 
TF-A and OP-TEE as well as modify the K3_OPTEE_LOAD_ADDR here.

We're doing this in yocto here[1][2]

[0] https://git.yoctoproject.org/meta-ti/tree/meta-ti-bsp/conf/machine/am62xxsip-evm.conf#n7
[1] https://git.yoctoproject.org/meta-ti/tree/meta-ti-bsp/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti.inc#n29
[2] https://git.yoctoproject.org/meta-ti/tree/meta-ti-bsp/recipes-security/optee/optee-os-ti-overrides.inc#n9

With that updated it should allow us to get past the TFA init

~Bryan

> 
> Sometime
> 
> U-Boot SPL 2026.04-rc2-00035-g94764e8c861f-dirty (Feb 19 2026 - 19:21:39 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> Set clock rates for '/a53@0', CPU: 800MHz at Speed Grade 'K'
> SPL initial stack usage: 13464 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Authentication passed
> Authentication passed
> Starting ATF on ARM64 core...
> 
> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
> 
> 
> and sometime

Though this all assumes we're expecting OP-TEE init prints here and the 
board reset's itself after sometime because a watchdog went off.

~Bryan

> 
> U-Boot SPL 2026.04-rc2-00035-g94764e8c861f-dirty (Feb 19 2026 - 19:21:39 +0100)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
> Set clock rates for '/a53@0', CPU: 800MHz at Speed Grade 'K'
> SPL initial stack usage: 13464 bytes
> Trying to boot from MMC1
> Authentication passed
> Authentication passed
> Authentication passed
> Loading Environment from nowhere... OK
> init_env from device 9 not supported!
> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-
> SE) devices
> Authentication passed
> Starting ATF on ARM64 core...
> 
> Francesco
> 
