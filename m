Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043DEE7E0AF
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 10:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4648083BDD;
	Mon,  9 Feb 2026 11:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RQz7tb6d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE8383BC9; Mon,  9 Feb 2026 11:09:01 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A23FC8397D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 11:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEd4VwvmmWAu5ijmPTiQOznjznckYBr3prJtXWuQmSFGFdjSs0EUVEQqV/4w3hQsm5YEt5FPGwerehM/TEncRKTFuQRzuNHX8jRtCSSYtlyIETmM1wRaM/luF1N7KzfPCnfXNb+rhz+vsuU7FNy8Ic0OCirl5h0QiX99B2brWeSYr6lEHN8Cv+gnLdcHLoDHQg+9RUgGP2d6PZDzMB/GUPQtqQ0tzKMhx4/q19YQfysdOX+vREwYIC8AduenSTuomPZWShGc9uw08nVT4DH6wOkp8B0Zf67LhDNyXG98WonhRLnn59gsk5m+4jlgLHYrk+pwdxTO8IyxRpN7QFjAPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gUvOqWxBfVgmhfgFuWQgNBao0BgzdZGQDimCvubssE=;
 b=Q0iZHVU3eTSnqig8JNRH/zn5pI3Eh6nvQqbSO06vIHc80J8ISjFg3LrAVCKihYJ6vkcYycAhIylXq4Tt6umXmePzaZQgp6zaxiDsnX4FYyKxSZ3kweVVC8CB/B2fOvnV0Ss06hmYUJTlGfy4EDqFVNDoOj1DTWzj7HFiJUKGUEqyYwLD9ze0UI4av4dbKH/ZKk+sYUEzGJPzDYylAPtL0CxRr/yUflZjNeJn56VUPQli5FX0cj2j+WzOXMnqrbvr32Qrl8Cu5Svz0aUnKZHWaaTs76VicaENQO2dlk9xoLjWXcbFrCprxM3GunYg30AxNge0qaxX/HmSv2QCGHLkzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gUvOqWxBfVgmhfgFuWQgNBao0BgzdZGQDimCvubssE=;
 b=RQz7tb6dKV5dQbRtSl33mDHUW9PP1C1hNaeaC6yrNPmi7x3trLKvkTOENB+le2zgLj8/Hn8QGjvde4cMtMwaYhhSobFVc/dOIoVzuQcaG7UYdcc+cNKFbWddWJmKtUfZpPiOQKma+9hWjEitNPNqM0NZeRGN55LpIXbCAcqndwU=
Received: from DM6PR02CA0061.namprd02.prod.outlook.com (2603:10b6:5:177::38)
 by IA1PR10MB6880.namprd10.prod.outlook.com (2603:10b6:208:420::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 10:08:54 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:177:cafe::d0) by DM6PR02CA0061.outlook.office365.com
 (2603:10b6:5:177::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 10:08:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 10:08:53 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 04:08:53 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 04:08:53 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 04:08:53 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 619A8qtG1372267;
 Mon, 9 Feb 2026 04:08:52 -0600
Date: Mon, 9 Feb 2026 15:38:51 +0530
From: Suhaas Joshi <s-joshi@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>, <trini@konsulko.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <d.schultz@phytec.de>,
 <w.egorov@phytec.de>, <ggiordano@phytec.com>
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260209100851.abaf46pr77uq46zi@ula0507357>
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260209084529.GA12200@francesco-nb>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA1PR10MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: aada06bf-2c3c-4810-abc2-08de67c33b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DmgB4ciU7GAEyhVoAbxj1Z1bnyxhCHACvAojNUHKtVgB4pPgR00l5dW23iyZ?=
 =?us-ascii?Q?toCcYCgpPPkzjrAkM1bqZUJG6hK0PuKR5KI6bxfcnStNt9t9bJyP4S7GfyTG?=
 =?us-ascii?Q?omyUrOJSo199ibXB8rwEleAh3JziXE0jqr4zMTwQI+ZP68aQE5OkG80dWjai?=
 =?us-ascii?Q?gaY4zAw3ZRRKV/1inyhy3dogE1o1bhc9CkSQY9OgBE1Nx6B1wFvYr7H5VXzC?=
 =?us-ascii?Q?gP5K0D7xa0o2+z+pwbB2v3spUM/lTa6oVs4butb3FStwSllboWX6yZLz24lU?=
 =?us-ascii?Q?ELCANk/tbJQgXnCu5usnZmyvk4oCRj1V6yFa0cg8HVwUYetGKGnRJDmDmVhg?=
 =?us-ascii?Q?JDfPZkHaSOkOKYcujKFKkrLi3GKWwuRbo9oD1Tsv4rhtND5yBgP3HFQqb1vx?=
 =?us-ascii?Q?10GlS6lySQ4aGTakGaj2O2J99RQIRhADn4HCgxZ6EdYHuirvDHI+oq6hEy8B?=
 =?us-ascii?Q?2qubFQAjibmfw1M2Ah1PM1nsPh6N7JzW+eCtV2uEWheXGaEW1uvRv5nHttUN?=
 =?us-ascii?Q?Jcm6KXGnjvt8TdTxd4+yYBO5S015d+QeAcVji3wCRo4o7FJoX8ky2fzBM4ZP?=
 =?us-ascii?Q?0hc8TRwNeR2va4mRKK5aHSM5JEX0b7rAaQHeX9igEn1xZ32PF5r9cBoZ3C84?=
 =?us-ascii?Q?t89w5Z5wdkoUltaIY1Pkf9hZf2fXVmcTwmkUzfivu2ccngu/DJrg638/8f4/?=
 =?us-ascii?Q?AgN4KiD2jk+8ZTqjop4XMDCOwb/rFhamtxwSsCmzPvTEuwzJ8/P5G4cVFZP2?=
 =?us-ascii?Q?ueQEJiJ+zyLkA1hcbZkeN8o9dmUB/cMgqCeC3YY+OrnGDKfSZqpkmpb0UyEd?=
 =?us-ascii?Q?IVrUd+G4SUfRl6iZKn8VunyAJSoXpdAptuMSR2g8J3J7XrMyI/HpuGNKBYoq?=
 =?us-ascii?Q?w3yjXQy4EFy/ev0eN9X0gJxk6ekr0ubRxuzJ4MyH60WrDPlj4RvhD+SkSzsj?=
 =?us-ascii?Q?OMYsFTWmTCr3jwmuL2L+wk7JYsRTXNqrUrOO56xhGTI1eskqdgjk0siCP9+Q?=
 =?us-ascii?Q?BtEUhGdE0RFb4dGSsUrm77Yu8Ynlz5+GIkoRrYHwm4zrmZHl/9C6tmAufLLV?=
 =?us-ascii?Q?BsqkPNVXivIeS9CHZuA+EECFb2tI4x5Osj0wmg4rWDjmVKZBt86yi0UYqq01?=
 =?us-ascii?Q?dUlIhNSZo/WFvtlhPDotoIazhg6BHUensMm1cc2A/710gYD23J3rlqMUpPTN?=
 =?us-ascii?Q?3O3lG6Vt0X3d6nnjghkMwt0fYa61s+81NNsS0cpilfIbbTFaYa4m/O/UlNP5?=
 =?us-ascii?Q?utspROw3NobjUZyPws4ATHYuWZFoKtYhfiVIezriO2yXdLlyPcu3U5EljRh7?=
 =?us-ascii?Q?pYzOukS0hyg6nFQenoSGXD0YSdrZbx1grVnF1YImZ9bUN8aLd/qCwQtO61E2?=
 =?us-ascii?Q?/DI9cjJYJSJnwAdtjHFeYcypdBM7CcM+jNYpjH8V2M4EFl/T+dGhWxTiehWx?=
 =?us-ascii?Q?vU8WAXY2S2S7NrAv9OaMvlSa5O8reicvm4Rui6ZuThakkZqJ2V2Rfn3loqu6?=
 =?us-ascii?Q?7vsxl4H7f/zaplmW9xisRwuSP0rHrhQOVH4deij4wnglxHlGokMTDG5sRyl8?=
 =?us-ascii?Q?uNE1qR5LvzuBUJTcArhV9nctLFTiuf+kDGE/PwMvLsCi048/yOY5tQPDUJ77?=
 =?us-ascii?Q?XQTfOXvvYH4XNo3Q8pmxbClGoFb6CWFan9R75uwYebF4z6DuSwlWYcEXinW6?=
 =?us-ascii?Q?cFDMnQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mJIGhtHV0EOuq/2Kg+ArFpOnc3gDw4weFlHJjgGlH2LDgEDkR6fLRkK+3vcmNiR+v21QqexCNngD3H8GdJjJFF78HnF2h/n+1KvYF8Cb/PMpbhax6zR3BJ3iVU268MwZvfdHRazPhl42Z8yhKxsAqn7E7JJ9WsqU9RoYvr/AjPpSrvnbm8X5aXy0WlmnE6T7T2qdiSZsjmJ+w03oKXPB/6v5/GlU28qR5P9XaoFy8iVtDRdv9dj3U6d0ooP8zZg4e4yl9dsus/ySkqtrHjy3dZRk79kWzszxBGTsuQAR2OcXesdI+flXyWvwu//rmoGiqvKuD5zs53eWr0/KZg7IspyuDU9yNvGEyGjUd3xHweMwxq9ntANuIUHthbT1Gh2jRjFsN3Wj1UBKdTsBFQbMn3CVWFOU9iguXtGX/w9CGVlvciylQEZVJxvMCdXy2ZxE
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:08:53.9054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aada06bf-2c3c-4810-abc2-08de67c33b0a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6880
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

On 09:45-20260209, Francesco Dolcini wrote:
> + Bryan, Anshul
> 
> On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
> > Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7fa524,
> > everything was fine with b5213bbfdcb1.
> > 
> > Looking at the commits between the two revision, I would say that the
> > issue is with this series https://lore.kernel.org/all/20260127081652.506357-1-s-joshi@ti.com/
> 
> We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor common
> nodes to k3-*-r5.dtsi") that might be the root cause for this issue.
> 

Hi Francesco. Unfortunately, I don't have Verdin line of boards with me,
so I cannot reproduce this issue. This is also why I wasn't able to test
my series on my end and had requested board-specific maintainers do the
same.

Since I don't have the boards, could you run the following test to help
us ascertain which of the 2 suspected commits actually broke the boot?

* First drop my AM625 Verdin patch, and compile and copy the binaries,
  and boot.
* Then let my patch remain in the tree, and remove Anshul's refactor
  patch, and try the same thing again.

This could help us ascertain which commit broke boot, and we can try
fixing from that commit.

Thanks
Suhaas

> 
> Francesco
> 
