Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805B8E94604
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 20:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA593805D7;
	Mon,  9 Feb 2026 21:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b1YzeV9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE7383BF4; Mon,  9 Feb 2026 21:20:13 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA44D80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 21:20:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMqMY+HI4o1N91Tu97uqn1G5bMGvmw5gxsLDPFEPSgZ1v699F52mm31Bs4KF9K8+Hi/2dB7nSQtpmKWxCJa9YOmrvlhXqDGUK4zR9ojm7vp2sSJylT77aShccOOj+kzt43twjPkf90wG0KmiM6yZAen8+/N13/4s8CCY5cvqJyYYlBeHhREr0KcVJu/kUy+iucekIX/NbhYGPnlR0z457Nu8cbcD4YuRxhIJw+juCjExVXLzurAY+DfomOhwTHkpOCgDpLXqke/cdYDsRLAnKqMc6iOJv6QcCEd8pCmVRihjvo/GHT/3lLngenmXTNZGMeOG1UhyA4txLdKSVuMWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT/JhNI/fN/sFb8nhwccM5Zu4T5IUjtwklzbdPYUg9w=;
 b=ty6E3s0EU8AHN/nNBcbMZutgMGh2j0u0dkCd8KI3CGwftul9UuzjYeGvribALRPiBiX+ilntYg4cPS7buuNPi/NbTB89C9Lnh1NLyXIA0LJEgExE+9xjWbPYyBwSSE3GTNZp/2Tnlmc69UgZhImBA9N8siIPrZAvzHFGPvKRrnEX7KUOA3H//TjEQpGlKXnnbFV8AmJLVpO8hOr+zvWM23CaHHL+38bn4QKju0+/MOi2C1AelRXfo5h0jxeL6mciAhcbuhAUn3vahU9jronOJlGKgpCsWOO75RH6pUkz95kHLxk3H6giW14jfCQuoi3EGOFRCfD0D6VjEIjPh+swbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT/JhNI/fN/sFb8nhwccM5Zu4T5IUjtwklzbdPYUg9w=;
 b=b1YzeV9GWI0LPgEZYxollyi4vdp/iCKm1upTWbwobmxP8OqfQuKI2Xh1gqsLWZ7LYhpvySi8g/CuIamMnyyWjgMu4sQEhxtuwF2Y2Ryc+SbDylb23ZSyl7avzHklu9UcQwYvgUsITjm6pY7DNYOl5AAgouGqTyzvwcgDdgYeQJk=
Received: from CH5PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:1f4::26)
 by BN0PR10MB4839.namprd10.prod.outlook.com (2603:10b6:408:126::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 20:20:03 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b9) by CH5PR04CA0014.outlook.office365.com
 (2603:10b6:610:1f4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 20:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Mon, 9 Feb 2026 20:20:02 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 14:20:02 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 14:20:01 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 14:20:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 619KK1812177823;
 Mon, 9 Feb 2026 14:20:01 -0600
Date: Mon, 9 Feb 2026 14:20:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb>
 <20260209172546.GA281089@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260209172546.GA281089@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|BN0PR10MB4839:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f5e95fd-085c-4d0c-edc2-08de68189b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZCsxZnA5MHJlZFlaRHNBelV3b1FVUm9XMWlBektsb0JCaXhLVFN1RGZsSGQ3?=
 =?utf-8?B?VnBjaHpoWms2WHRXNUticlJMa3pqYlNzZ0N2V1p4U2JvUXhBbEhhYzB0MS92?=
 =?utf-8?B?NEs2VWIvKy8wM3dpQ09EcGhPL2IxR1UyWS9pUExFZko1U3pPTlhZb0JlWHVH?=
 =?utf-8?B?aEZ6QlRscEFmaEJNaEd6SkpvZzI2NWJEVXkzdlJ2NkpSb3hZNlpZWVhBeVBH?=
 =?utf-8?B?REJWbVVmeU1nbm5ISWlvdmJ3SkR1RVRHUWJtTFFZSDloU2pnQVRidjBLQ1Vx?=
 =?utf-8?B?VmhrSUVDS0RzUjFQalhodjRBRFdLTkx5c2JhZUNZNzVxTkVha1QxY2JBOWJG?=
 =?utf-8?B?YmNuS0VGS3B1U1BxSXlmV2wwd0FjY2pnMmc1WUlmNEM5aEtSaXRVdHNKS1Bz?=
 =?utf-8?B?d284eVd5ZFVTZVdSdXhwWE1ENVBZN1JKWFdpYUc4cisrdUxEcUFSRmtyb2s0?=
 =?utf-8?B?WmRBVXg3dE5CVVVQMzJVY2FPNGF5bi81aW1RMU5tSWhLY0M1dXN0YWtTTVhm?=
 =?utf-8?B?YTJYamczQytZSm1PSldmQVFTZ2NGS240UXFSbHJHeW9TTEFRcmFiWGVBUlJX?=
 =?utf-8?B?WXc1N1lLa2VwcWxJTCtrR25FbEhYcmk3QkJDRVFLNW1mcHRzL2NkQUdNS2tF?=
 =?utf-8?B?V2JHWm0rSzFKRTRpNkN1NldGZSs5WlRKSUpYRThoWk1DMFA3YnRodUQ3MVE3?=
 =?utf-8?B?RWhkQUxnOU9lcHd0dWlvUkYxRGdRU2R2c2xBWitPdlg2WjI0eS9CVVIyczEz?=
 =?utf-8?B?c1h2N2U4SXpIL3lPQVZBWVl5SHN6UjN3c1FGL1RwSy9mWXdiYkNURlYvaTJ4?=
 =?utf-8?B?alU2V203bkpuRUxReXdZR2N1ZlNlSm1RRVBYY1dTa1NtTHlDc1g3dWxuVG1Q?=
 =?utf-8?B?K0xmTWpMbUZXZTBmQWlYWFlvU0ZEa2VGWnp1ZE9tVVowb0ZId0taekFDMkpE?=
 =?utf-8?B?UE1Eb2Z6WXc1RUMrTFpPWjFoUGh2N2VxTVFHQU00WmhMZ2xuSVozKzdTMWRo?=
 =?utf-8?B?aUs2SUQ0aGxvNDBianZvTkhhRzI4cjRES2dKbXNKUE9TN0U5QUhqWUxIYW5F?=
 =?utf-8?B?WU9ZcWl4aExEMWZLQjdjYkhhV3NHM05JSVk5S3BDTWN0Qm1IOFRsZ3JJL1Zr?=
 =?utf-8?B?eldyYUQ0M0VyWUhyNmRaSkVSYUg3SE16dXlJbW0weUFaQVdrOWJKajZieHli?=
 =?utf-8?B?SmdIQWkrdk1jYnpBb1luL3RJMFdWNThzN2xLNHRkanVUUDVUSlMybzJaRzVh?=
 =?utf-8?B?SlRySzFFdjhEZGNvamh0VjByTmdlSXRRZk5NbjJsQTUwNlZrMXBhaXZ5cE1p?=
 =?utf-8?B?RGUydzJ0WEhXRE1lRTBBcHZZVjVOUXcxYnBkUGo2UXVxZ2Noc2VEVUhXcldV?=
 =?utf-8?B?a1BlKzFVS1JhVXZJMWNCQU5QR3o1aU1GdThMSy9rOUs5dVVxR2wzd1NOcTB3?=
 =?utf-8?B?cUg1ejJWaVhjMC9vdU1IVkhUMTd6K0tmRDF6RG1LUy92RXRDUy96UVJzRkVD?=
 =?utf-8?B?SVNaeE1RK09idm5iVVc3RnNHUDdoTWc1bUM4YzlHNGxheXNVYnZXdy80ZHlJ?=
 =?utf-8?B?WDlXQkVrR09ZUFZmSDByT1hYd0FwSUNQRHRialNrTEZmVlFuK05jSGFVSVl5?=
 =?utf-8?B?WlpaNkpLUWJ6TXo4VGpNZUFFMXVCNnZuWUZyZkxzZGtwbDNXNk8wRmN1Rncx?=
 =?utf-8?B?UWFQU0ZxKzVuNEFWVjg4OGlXSHlYMjdOVjBTWC9FRGhqdTFjaEdmZUl4M0Mz?=
 =?utf-8?B?WitxN3pmYlhyelRhNG11SGtLYW83NCtaODVzTmpMNURFUXRiYU1SOGJhUFpj?=
 =?utf-8?B?QWxwVGxZQlVMOUFwaUdNellrUVJIREpOcWt4MjNzeUtYNzE3MzUzK2lzTGdM?=
 =?utf-8?B?dGo3STg0OFkyZ01UQmw0Wml2UUdYZWNSK1VrRFFkelU4YVFsUVl3YnZEcFpY?=
 =?utf-8?B?RUhHNmFNUnFiRUxtZStoazh1M2tLVnM4R3RiSVRNL2l3L2pCNFRqQ1lEcnds?=
 =?utf-8?B?TDZkMlcrZ1ZMNmxKL1FIVEtYclZUR3k5aTd0OUFwS2h6V3ZVcDBweFVpbFpU?=
 =?utf-8?B?R21mYUJCZHczaDNRa2RaSWNCZ3JxaVl0ZVR0dUN0NlkrV09CeTBDTUJNcFll?=
 =?utf-8?B?YUhReitOc1FOUGJYc0ZTL1ZzeXBwUGFpNllBWVlxMEd4eXFDeldHUDJRRkxn?=
 =?utf-8?B?clZEdzFnU0t2UmJ5STFtcnNVb2pta3BwMnVKOEdKd01MZ1VibWxXaGd2cnV6?=
 =?utf-8?B?d2FOSklXeWZJVG5XTDR4blFBV1pBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AkldS0VOGInZzn0UchjQxfs2sRLIAQ8kmysrVUF3IVmrRCZFn/2/Rjvxx8BuyEaw6tGZNz40SmM15OPi4+uQ14my2LDC89v5p3Y44mW7bXlIH2BJ5FIEnSVdf0xyZKRn9Xr2gyomW/UuUTyzyeWFlvAYMeVSpLVpAm5JD2ZDhiA07/8JMahBu4JKLwhjs4RbqS7xg3ufHAA8Z61lNx/8P6DDKURz//RWAC894TBGnfMSzn4kcvr9o/Oy3lVNfn+2SuX9ExBr36dt4EImFrtGW+Ykx9WkCCRy6By8P1TqOsYt5V0hk5Gsf1dv6smTE2lH1779unheAcmYSMoTqQhptsOt9IustWLNqMAmA0gfb0ao7RFSl/RWkyc2pwJtwxNhiTvZ6hba+Yke8pRuagYSQAxILF7UJi9fBsrymzmbb+bwVH04ds9Ptm1X8mTZ3sRk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 20:20:02.6326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e95fd-085c-4d0c-edc2-08de68189b4e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4839
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

On February  9, 2026 thus sayeth Francesco Dolcini:
> On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
> > On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
> > > On 09:45-20260209, Francesco Dolcini wrote:
> > > > + Bryan, Anshul
> > > > 
> > > > On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
> > > > > Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7fa524,
> > > > > everything was fine with b5213bbfdcb1.
> > > > > 
> > > > > Looking at the commits between the two revision, I would say that the
> > > > > issue is with this series https://lore.kernel.org/all/20260127081652.506357-1-s-joshi@ti.com/
> > > > 
> > > > We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor common
> > > > nodes to k3-*-r5.dtsi") that might be the root cause for this issue.
> > > > 
> > > 
> > > Hi Francesco. Unfortunately, I don't have Verdin line of boards with me,
> > > so I cannot reproduce this issue. This is also why I wasn't able to test
> > > my series on my end and had requested board-specific maintainers do the
> > > same.
> > > 
> > > Since I don't have the boards, could you run the following test to help
> > > us ascertain which of the 2 suspected commits actually broke the boot?
> > > 
> > > * First drop my AM625 Verdin patch, and compile and copy the binaries,
> > >   and boot.
> > > * Then let my patch remain in the tree, and remove Anshul's refactor
> > >   patch, and try the same thing again.
> > > 
> > > This could help us ascertain which commit broke boot, and we can try
> > > fixing from that commit.
> > 
> > Sure, I can bisect it. 
> > 
> > Do this difference in the logs
> > 
> > Failed to set clock rates for '/a53@0': -22
> > 
> >   vs
> > 
> > Failed to set clock rates for '/a53@0': -61
> > 
> > ring any bell?
> 
> The boot failure start with commit 2ffab9da9142 ("Merge patch series
> "Firewall ATF and OP-TEE memory regions in Sitara"").
> 
> With commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for
> ATF/OPTEE addresses") the board still boots fine.
> I have some concern that this commit is changing something, however
> CONFIG_K3_ATF_LOAD_ADDR is 0x80000000, while before in the dtsi file it
> was 0x70000000. I tried changing it back without any positive result,
> I just got an EL3 exception.
> 
> Any more test I should do?
> 

Do you mind copying a boot log to a pastebin for me? I thought I had one 
of these boards but I'm still digging around for it. 0x80000000 should 
be where we load TFA now days unless some boards have opted out of 
letting U-Boot move it to the bottom of DRAM

~Bryan
