Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0C5E9E2E2
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EEB283DBF;
	Wed, 11 Feb 2026 12:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C81ORo8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 660F283D5D; Wed, 11 Feb 2026 12:21:25 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19A7883CE3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4KVVstrtwWA3vbPcEHdFjpaNalJWjnyUGJTDY3kdrsE95EdwLKcYMzn+184tG5o/FmMNNj+0m95xtTQAA4mwkNYPDBPmBZ1/VVi1EEylKJgUvOsOXq/PbzAVlW5+L3u7/QcmpF0WZONwznHdLhNPfeWsFW4U7Dm/tiQtvI8NYMgmJeNik5sKTpVhh+epc/rJ5XLtMA1ZaBGEa0EBL7qhmNuVBS7jRulI+xhjrCLRvA/DAtwYM+vXsxf3lOoPIDZJzxRFRl/dsVhQwvzvdzml+WoRQxpD6YsqPChgNVHWAbq43xuef7RfXbV1Oz7dGo+ODHXx49OcHBfTWYqy72Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srL5/MkSz3pKI+Y/S2KGQI3m/GjR7rBXpcK2aseMuXg=;
 b=tqAozyVOO9p4XTOnclSgUxbH9OEYtX7ohYBVj3/T+fZYVKzE+RYhszGrlQ0o6j3cF0W3fs2Fs4W/9yjtDySc+GCe2oAtb/ogOal8W2M4gdEpwx6hOD4tTM+iYjWmVIZAXFgct4ST7SBpw5gglvDTvrYQCr9qLVHCCHJt16LMXPdmC7UnmtMX7CzpprBbE1HJHlgLVm9wcdxsglRG/F5ltyQKqZk7LX9PjY5fHlDlR4Bp23wSzX/1ndodLTlPHaphxwM6BcR5GS6Vbtt4+0Ketz1PVYY1VJYQNc3RNtUVknQHLihtyY1M4VSXhg/TVXZ+vZ+EfpzyZdCkUIldIsMxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srL5/MkSz3pKI+Y/S2KGQI3m/GjR7rBXpcK2aseMuXg=;
 b=C81ORo8OPx2e3sc7sHlo2cs6lCzYQ+TI544FdfqWkQT61p5NvgYSej+iRiGYxjLPQ0yauBx8qE7muCT+o9hsCkExXln/AApHnSYy0fRWNIA4VlvIaqQy3qrxay0bdzZ9yRJUCQQ0gLoAMKAM4qLDsjSSG4wFBtVyn98iaLT/88M=
Received: from MN2PR15CA0042.namprd15.prod.outlook.com (2603:10b6:208:237::11)
 by PH7PR10MB6985.namprd10.prod.outlook.com (2603:10b6:510:27a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 11:21:18 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::da) by MN2PR15CA0042.outlook.office365.com
 (2603:10b6:208:237::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 11:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 11:21:17 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 05:21:11 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 05:21:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 05:21:10 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61BBL91t1111671;
 Wed, 11 Feb 2026 05:21:10 -0600
Date: Wed, 11 Feb 2026 16:51:09 +0530
From: Suhaas Joshi <s-joshi@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Bryan Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260211112109.56e27kyy4coqpcbb@ula0507357>
References: <20260210092646.w5bugrscifmsh5px@ula0507357>
 <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
 <20260210105014.GB214446@francesco-nb>
 <20260211101113.GA176369@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260211101113.GA176369@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|PH7PR10MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: a5622a05-8eff-4e57-7e00-08de695face7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YYe3pJZzrcDlLHtlh/WR+m9yuentKkb2+mAQDXV39xm1wa+V7YqFzwjq6wFI?=
 =?us-ascii?Q?4zvUn37NWRmaW5H9WDC5dV9vR7EJlcnp2ITg2LNenlG/tPaNw+lSTBNcgBGH?=
 =?us-ascii?Q?9GxQS8O2FZlG4DeAoJHhwGzMBhA07smu7V+8T3NzXaM4rv83OwufO71MDenz?=
 =?us-ascii?Q?L9A92DpexUoHHDvsF8ic0m8NWUn5rw1Yn12vdan67cA0OiS1FRRB1Ae0CoKg?=
 =?us-ascii?Q?1zhyAOV0/2Toqi36mZ4hrIdfIVEHem3PsAqPLaRJsjJjqJrJBdsLU2YyKh2f?=
 =?us-ascii?Q?pJqJjpiDSdJG1SDNK8o8V9umbKvtMJaVHmfj8VVRl8lgZx4+T+A3zW+v0vzI?=
 =?us-ascii?Q?zBbeB4x7hr+kDtxfWJvM85MRH3R4nTlwuyzmwT33pC2rlIYHqRJ03CZe+jLF?=
 =?us-ascii?Q?3PCrK54uyOTMWA25pSPHKXLtOwQ3LxQYAVq0CdOt7GOBr4Oa0ukQOoWc4a6K?=
 =?us-ascii?Q?B0SvQkKB12wEAwFQnvoWK76lWacwMdnG2W2pczIckSjXYRc+1cono5b81d0i?=
 =?us-ascii?Q?okM+cOEIdAAkUUtADxDprV2DqMFebc9LvJ8RPxCWWgrMj2tx1pAIcgDDhJ1p?=
 =?us-ascii?Q?DSIRHYFuPnquT115+CPCOhZvvL3of/wS8P5vtNxIDa9TxB07bPtbJF5v9SFk?=
 =?us-ascii?Q?b2929yliNOxrke5BAXoDD1PbAIYfjYWuc9v20rQpJlE1aCSc+ob8tqem9Iwl?=
 =?us-ascii?Q?qYInATDQSOABQ/vY1m/awRh/jD6ZWggKuT/wZn7fd2+UYAl2fUfNxpHdTrrk?=
 =?us-ascii?Q?daBwmY7rPx/oIY7CKbWMU1ft4DtMlSpvWDoHFfHexINt0az7i2/Kz3BVmyOR?=
 =?us-ascii?Q?wLt2j4nQgC7WzmOZ0pp+8lLJUpfqVuBjyAty5XFK8aJm3w8dX2MmL2GMuoyi?=
 =?us-ascii?Q?0jlgbmDhcEUp5HlwRfvbv4Jr5EqpKoFolTgXihrgLSfH9KFx7Ah+2V9DvB6i?=
 =?us-ascii?Q?p1epIFUmyaZnM+7eqODWVyINwgnLZgYZ4zX/WWEjfNSI1emfUqcvHpQj8Mrq?=
 =?us-ascii?Q?LKbLRVgg9W0MHZRcgcxmv9VH7gS4+W5b/T8cB+XAbo9PkI+7FjqLy5tu10oN?=
 =?us-ascii?Q?IClOWtPTnn6BeCVpkv5uIdLiHwxnBGH+4j+STAaW0/BE+nKzdVe9S7cOsrq+?=
 =?us-ascii?Q?hzSNNmf1P1yKaCJJB3wKgVgtENTOCN6MZ7hg8/IjARp0aysa4d5knWW21ts0?=
 =?us-ascii?Q?nsIWY2E7dbFiK30NWdaXyfiy0f8V0kjSeT6mHSGFFlkNJUv+bbvaZlxRxCEp?=
 =?us-ascii?Q?twSch2oXx/IO6kGGlbUiOroPfsUzu0r96P7IV47qhSoFvbxkyi58IGMw3n15?=
 =?us-ascii?Q?0hzd+Jtr9vsn/7SHXx2OUf+2ErsUlpcr2hI2OiJcAHgNrPLtL0rtALWOxkAp?=
 =?us-ascii?Q?6mnP2GKsT9mPSsUOs7KHcp5XXsc5twJNy9CZDARjMzGHj65N64+uXGQD9joP?=
 =?us-ascii?Q?YmpqknTyoxRgPvHge9WKoP3Q9kvBapKDZKinhciCwcFku/HBIq75tcb4mAzc?=
 =?us-ascii?Q?jX9IbVlCBJPV6W2SgcBqN4O1ma+duNVQOfljCiA4lZ9KXMBp0Y0Gp07MaayV?=
 =?us-ascii?Q?+wUZkUqG/BjG4bqs9GgdVYTRRTZdolQz0Tn3xiSf0Y+slC4LWSMnhs1IaMXO?=
 =?us-ascii?Q?i4qUHmh+A8P/IJt5oX2L6Ls=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3leo9I3APhjvaIXJxKyKgcfg4eolwlut1I24OCPCAmL+QrPDl6J/y7Yq93aFYQtHrmpiiYweOYG3+1Mf1FYGqF3DV1ge+5Ji8iqzqKuurX3ZsBbCFANhMjISotLLzlbUjNKX1yF7+sTtojNR6C6RLv/Od+5vFikdbvH2yIpC6QNOSqsQCY/oYa70J0skY4qmBXvTgQMPcnllujw0loXHuxL4UYn/4orZnkk4P0pnwNffjD1HJpj2Q30Z2d7pU+2l7F5NMca2bEwT/ARn0k7B4rtJS+xx8z2T/pxhbKsYhs5oN4nt21JL64ZKZICcMmLoA1qKxLShoxi10b1D2K9Xds27AYNwjQAdxll4+hcjflC7Y9t+5MYwbhT84yzFrp1NtomLr16c8FQhCJRX1GNfBJ5zjvSMTJg9FyW7ngJBRUjqaEWNtNwnInHPOhQEesHB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 11:21:17.5712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5622a05-8eff-4e57-7e00-08de695face7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6985
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

On 11:11-20260211, Francesco Dolcini wrote:
> On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
> > On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
> > > Do you mind copying a boot log to a pastebin for me? I thought I had one 
> > > of these boards but I'm still digging around for it. 0x80000000 should 
> > > be where we load TFA now days unless some boards have opted out of 
> > > letting U-Boot move it to the bottom of DRAM
> > 
> > Here some more logs
> > 
> > https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
> > 
> > The files are named with the commit sha that is tested.
> > 
> > On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
> > > Verdin boards are the only ones that are reporting this issue. Is it
> > > alright if we revert only the two Verdin-specific commits, and let the
> > > rest (TI and PhyCore ones) stay as they are? The patches are pretty
> > > un-connected to each other.
> > 
> > Verdin AM62 should not have anything special, the code is all there for
> > everyone to see, including the defconfig, the DT and so on, and the changes
> > we are talking about to me are self contained withing the SoC. Something
> > is wrong, and we are not understanding what yet.
> > 
> > I just retested once more 42b3ee7fa524 and it just hung, you never know
> > if I did something wrong. And for what matter this was spotted by our
> > CI.
> > 
> > > We are working on figuring out why Verdin is seeing these issues, in the
> > > meantime.
> > 
> > Anything I can do let me know.
> > 
> > If it matter the board that I am currently testing has 1GiB DDR RAM, and
> > the SoC is a AM6252ATCGHAALW. 
> 
> I was able to trace the issue to the get_ram_size() in
> verdin-am62.c:dram_init().
> 
> That function walks the addressable memory range to dynamically detect
> how much memory is available.
> 
> Not sure on the proper way to fix it however, Bryan? Suhaas?

Yes, this does seem to be the issue, even in my digging. I have sent a
patch to fix this. But since I don't have boards, I have not tested
this. Could you please test this and let us know if it works, or if
there are any other issues that pop up?

Thanks
Suhaas

[0] https://lore.kernel.org/u-boot/20260211111328.1481562-1-s-joshi@ti.com/
> 
> Francesco
> 
