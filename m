Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDA7FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D9F084669;
	Tue, 28 Apr 2026 09:38:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vriwec8f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B87B8416F; Tue, 28 Apr 2026 09:00:38 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F33083A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xfji3RzFROaJISV8Kv+RPCF4PeTfeyVIdGmX0uJLEfQcS2EwYI2CDm39O2K2tthSDttqbtBe8SFLbfchTASvRSC5GV3M3zo23M8bKjKA0eD6GQ2fI4EXlCzGWuQ6Qr8fbS9o+nd6hhLzKSUpWG3OTwyx3+E8gpfpHLDy4XUn0ZQ4P5/dKYRy1i7Q/b/DvFr8/W2u3l4GwpuFywGh8ZXsQ0U2gbTdCaUhxsa+zQtRNR1jiQxlTyIAChEhbaxO3iWAIqFEOKEDn9/rk5Zn0BmxnAW2lm3c+igpo4d6AhoqUioBFZPfUhdIke7Rzch30xlbM93fMstMoY3IY9Z4Js+UFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7pd3PMGPKEjZj3Gz1MQdAfdgRcgkGybDdgusmDBtUs=;
 b=p7r8T1PjaqqMqr89lmNg3ZAFWCBnf28Ia6DPBc/ZkyQany3FQhsbEaFrowQ42X3IlV1pVchBA9fiQ3YW5OjdmvkuJJJqJhEh9KWQ/KLrLCq9kza3KWJJCvOZU/PpFEzzvvpDzUdKCBA6LqHQFmF8K6486aWjlLpcTF2zRfoJ+5rhAIW5s/stmF+wWN9WyNw31miCyy1ucUZOy20IkX+gBg/riFDI3PTP9oAKTjMe3s1CP3/gxtFNwOmykB13S4sK/9fDpqeR4NmbmFCnW2W2oCir5SEd8ojjOhqY1zViIRZnhfCC3U081eMgDwHav4LotleCvXNvdRzawiSxMQvnWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7pd3PMGPKEjZj3Gz1MQdAfdgRcgkGybDdgusmDBtUs=;
 b=vriwec8fH1a9O+ujypyL444mgTjH+0vsRS/IDab3yH9CrjveJsSS8wg5eywE4SvaelDiFo7NIt6n3N74NZfJthHwJF0/EMBCFq1UyOrKYuDjVOIS2I4KKsCb3OeP7DEJNS6gPsrTCG+4On4Wl3PWrNljZyyDPzxPWVm0oaHqVHddds5NoI3RWpyqtXjbYKcRdjfNQszkuL7eAgIAgiusQzzxFfWP25J7vo3f1PwxtLyQ2teS75JXCQmXVOCfFzq73jS/hWwfon+u5MLSyLFJhgINoZvA/3r8Cdr6frVlqxPIyfTIve2P5SQJ4MXR8TfRUnOTM9KWP0wagvj69joaFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:29 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:29 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 0/8] socfpga: n5x: Update Boot Support for N5X
Date: Tue, 28 Apr 2026 15:00:09 +0800
Message-ID: <20260428070017.16807-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 6610a33f-fb3c-4309-7e6a-08dea4f3d4eb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|55112099003; 
X-Microsoft-Antispam-Message-Info: ElEdAdFyCGmwubOeA+7iNdpVvimE4O9mX0Uk9Lp8NqN2tt2uKMxk5KOm60pkae0m4sfj5R3fmJuzWf+p8/AnsWXHRzpvr5q/SV2/++jtyCJrUfoqRr74bMe8C9k+sKfHoX6i6gRhKro4XJqNXpDuZJiL2of32grKc6KKIXy1C7Dqt+ZXkEGQI6ztiPZN1PkpZFbZcpVWHMcIYL815qpB5Pv6zd4XyReQnke2v3+LBgfLwakzJm5gDcVzIFAPFmvtjpt8tEiogDTDXJXPK4zKZepanIFlw16DLHO0aMl1S13AmIyh2Fhf/auCq2BYXYT1K7Dd6coQ0ZKlp7nRNIrV6awFM3V5GtIbCH+R41ebTokVAyCUZhh/4iP0rKUGMidrOspa/uOUBcwwQIPB1wkjLf52Ouks4jdQW5+gjrfjJya7Una1mYn0rN/Ezba2b8sXuRQcOSSc7dvccWcamSw43XSYGgxRvePeTcYQVpuscovBGQ3MHWLlRnyAX+ZBq54RMNuWky/FtCYFuTohVGygXmlUt63snVwFDjQ6NSYpJy8NQ4s8+pw6CsfRWFKFVAebVJZhBf5NSaDIB5GSCMmLXWYf9L/9V9HKI4xi3u+jChJaUjzxmShWf9QPS5f/DA2z4JoBr8QP+PRnRNrZpi/ssn4or1xecyyydSBXIfdLh0w3LH9Uu95Sota3Ddt2YaozexVf/o2A9aj1QgRamZk0ksb2pbMFZZeTM+nWwQ86H0E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrjbzqDzW0v+DtwbzWVGQwznxA8qFyx0uMt0tDtB0cBAqmeHt+FmhXjYZ3tD?=
 =?us-ascii?Q?k3IiduPJVuahbBrjmXQNo96tUBDAcFzZo2HTgg5sbzLXgOITupTzB94jVCu1?=
 =?us-ascii?Q?S1JNoXi0iv9/+Ba9gdRH2IbofnrH1/t82HydmnI7/zjf5VPmmr6WHVt0NVUH?=
 =?us-ascii?Q?SmeftE6BaksHuUh9GJl6IeuCum7ebQtEzLDHtDzbuKS1wID2FHSi2QkeaRZ8?=
 =?us-ascii?Q?sFbFM/9ErylIVg7Q0iks0L5hGyCFNslydd87MT4O344glgyfECnGX17iswX0?=
 =?us-ascii?Q?ySudDju5LewbMVn2ckh6qE5arXWvpnq9067FxqMMW8oofD/kyeXddFL2cCLA?=
 =?us-ascii?Q?k8BX0IrJ3jyrjnBF5i/BVGB6ee5UNqf8l+7jhV1PKYJ4C0JzjvN7xibwTgaM?=
 =?us-ascii?Q?fCiva1SXFhJoJGBVV67iYL71s4VUVd9GERmuAmGIfYR1n5jzov71DC1IGrgT?=
 =?us-ascii?Q?zfirzwgCGYPusaNgtm2sIKVV6rUoyvNFoBSF6jdPBESmXrtGR8twDanJyNQf?=
 =?us-ascii?Q?KgOSpn3iNZWqp7Fzq4h+BGvduu2ftpBPmZcqGVPTpkgbXLu+dCQv9wb+MYst?=
 =?us-ascii?Q?mMO+QLvzmLtxrnSMZJxt7wMC5P/uniRdFMalgfsFfMEzz10DycOY/VaaWM8l?=
 =?us-ascii?Q?tbv7Pm2q/fxghXge/RyBaGhmbfrpW+CgpYtnUYbDlw7cU/tgTgaVqwOaL8n5?=
 =?us-ascii?Q?RWenCOTAizUHmo6UGYTj/xQ2q8MR+WJNKv6m4e61dn+nGOfyhWaQvQpXj0WC?=
 =?us-ascii?Q?aqBai2IlFbInaekQPBarxg9XZ2xl04HLwEuhovBF88chvmQedj9aWZi1/TH+?=
 =?us-ascii?Q?o8i3fATDgm/CsNHoXo5cjMLjieixWbNq9uoeQOel9k7++pkO+L3oomWRp3QS?=
 =?us-ascii?Q?2SOBZRjOuLFukkfWrcjtIPSzFDaMexU+NHcIbacH8IybgzlqFTOpJu/ZJVTC?=
 =?us-ascii?Q?d4BooOFTL1BV3IKt/YwQmnJQGV1p4NCZi1w1fVg0AcRve5zzwKklwEWQxtry?=
 =?us-ascii?Q?Roz2E+UeqRvc6//ZuIbthijTKzRQoZh5XDNcQM3Cwk3GT4wLoeQ0ZbfBtFwB?=
 =?us-ascii?Q?A4BOlAtfsmUZq5kYm6TyL5W26Wy7LSwhR3cSIwl1nm+D3NY2yPcx2QQ0oZk+?=
 =?us-ascii?Q?DHZWZzjXlHbANJl25eVsMhvrt6CUvbfkF+c9O+vwXdZwVJpLtF5Bh4qHVUMd?=
 =?us-ascii?Q?4uIXCqMRINs6rDTSj+wxTd41pc87hfkq05uFi/Jz809DL4QqZ0m5UxC1QHxX?=
 =?us-ascii?Q?bZhkI5BE1nbkxqR9fBtOM5f7TioQ3efpfVKTqDkyy98LRQw1fhE/0CLD1z4p?=
 =?us-ascii?Q?92cW44CX3i5gnhJGPUkxiphkR6yFcCaHdE09UvHpnp4RGQUr65b80CgpPJ34?=
 =?us-ascii?Q?RRcJk7AopaUDkuyAD8oAxqsdeIYoRdQQjNREzSA58oAlgI9tEGdcxgcUTYF8?=
 =?us-ascii?Q?hnpB57TCZUuwHbMptZGut+Y2sI5xO0viaF+WMpTUdXFzVRgz1E9Hm0YkvMhU?=
 =?us-ascii?Q?PuLtZTx/vSgw8YG0RSCB757ypatvtO6myxgqylDKtJbaJ7KLP12HLI1XHq5v?=
 =?us-ascii?Q?r6Yl14hZtRUfRWKtD6kyg4S85x2oc7wrU9f+9db35Qp9AcHR3mTNebEfziVJ?=
 =?us-ascii?Q?V3BugDjybtSY+hZ/bBQjoaO06+XLPjPCJCpwiOACN7dp6MlO/4TRTr2Jmbod?=
 =?us-ascii?Q?MA0jenIGbUV7ufF0KxAvoGbJ3K0OQRVpgYM1eRL5wPu65SQNWMN2Pz6Y3BTi?=
 =?us-ascii?Q?3AkOjJAOUpX3DWa0iWuI4HXhYeun/aY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6610a33f-fb3c-4309-7e6a-08dea4f3d4eb
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:29.3911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/mC/eCBTQRrlSXGGUoRPvOodWHGI+pVp3IRQlaLyEd8uIZ5k28CPdotnY8XvminLaxaFm8Gv7CtaWp+jLpIqqPb1zmklhf+VsmHNJm26aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

This patch series updates the N5X platform support:
- Replace defconfig with ATF variant
- Switch to upstream Linux DT
- Convert firewall setup to driver model
- Add ISSI QSPI support
- Enable DDR retention and SPL SDRAM support
- Update SPL data save and restore implementation

Tested-on: Intel SoCFPGA N5X SoCDK hardware.

Detailed changelog can be found in the commit messages.

v1->v2:
--------
- Fix patch series submission.
- Clean up redundant DTS override.

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/cover/20260318030034.25889-1-chen.huei.lok@altera.com/

Chen Huei Lok (8):
  configs: socfpga: n5x: replace defconfig with ATF variant and simplify
    VAB
  arm: dts: socfpga: n5x: enable DT register settings and update GMAC
    nodes
  configs: socfpga: n5x: enable CMD_MTD and SPL SDRAM support
  configs: socfpga: n5x: enable required configs for DDR retention
  configs: socfpga: n5x: enable ISSI QSPI
  arm: socfpga: n5x: switch firewall setup to driver model
  arch: arm: dts: n5x: switch to using upstream Linux DT config
  arm: socfpga: n5x: update SPL data save and restore implementation

 arch/arm/dts/Makefile                      |  1 -
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 55 ++++++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 18 +++--
 arch/arm/mach-socfpga/spl_n5x.c            | 30 +++++++-
 configs/socfpga_n5x_atf_defconfig          | 89 ---------------------
 configs/socfpga_n5x_defconfig              | 31 +++++---
 configs/socfpga_n5x_vab_defconfig          | 90 +---------------------
 7 files changed, 116 insertions(+), 198 deletions(-)
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

-- 
2.43.7

