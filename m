Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A847E8782E
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199DD841D7;
	Tue,  3 Feb 2026 14:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sO+B3Crt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 756768420D; Tue,  3 Feb 2026 14:41:22 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5768413A
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtVS9eXg7AQM9Ni+1NjyiyyT42wpbpTtQD/puqt+mcYWglkQNC2eL7IXwo1GRrloPq1mSmyCaGFinYqqsOcElVtEIHxbcFTKvSIHX+px+N/cyETucivX/XLa8VjTHnWK2SawtovTbvguzGv7z06grta7g1lp9tsg2ceVT1YqPEf/zE468tHwzYLXHmBd6qISdlOafB3FZOtu+cn8t/wDxIN6Ts6LZTyRfyhzkx4L+mPP58S5wRJ+ACKg3YeMho5H4Pr8COwsd4VYBAJKSJl9WQv0R5JyMrSbyt2HfSEgtW5ezhnOCPuE3ENXh8YC7IrNjyg5DvZKa069lD2cN5LSdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQgliZgIJvQSIZsmQK2JwU/jJAfHEp/WGxc5fKDWQZg=;
 b=N31Wyi+ZJjGwMhAcEQyrmBYBRoy9tTz1D0cDVJeBvfVhhU2HNiECHwVcFY4/ebNU37cUvJG9bc+F58utAXiW6A7wGgnAQ3vlng0xhsayT5y1UID4DAK1jglGhDh7axlsdheu/6ypPqDbIHfeCXISGJmkOyXYuphvtkhfHUMZSogh7bXfg03SXM38FHxwo618PfMoCVAl4lOGUWrqIyDENgmg5yZA47LrIf9RveZ3zv0ftBG3nicYGU9Vae36ROAQzQFKZ5lvUbt9AmiUeBXEHZF3C9dkXwKzf0v8Z3Mt9oKIfIWJY0VEFGh3vriXzGtTu1pwJ1NeD6Ywy5BN2WzAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQgliZgIJvQSIZsmQK2JwU/jJAfHEp/WGxc5fKDWQZg=;
 b=sO+B3Crt1LZutl7kvMI+comKqEjmBhFRPpLpyI6Ek8SYk6Gk+OhrA+UzXKPxkXLutAVEsZj90SjlzcXyinFJ6uwa/DTh1HyxK9iylDNYadeR7j2sMoYYckPWOXCBE26YJx9rDrlCoIKBHYDPVnGCZQON94pbpn4T9eFFlcNHiHM=
Received: from CH5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:1f4::11)
 by MW4PR10MB6560.namprd10.prod.outlook.com (2603:10b6:303:226::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 13:41:15 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::ac) by CH5PR04CA0006.outlook.office365.com
 (2603:10b6:610:1f4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 13:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 13:41:14 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 07:41:08 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 07:41:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 07:41:08 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 613Df8HQ3595689;
 Tue, 3 Feb 2026 07:41:08 -0600
Date: Tue, 3 Feb 2026 07:41:08 -0600
From: Bryan Brattlof <bb@ti.com>
To: Santhosh Kumar K <s-k6@ti.com>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>
Subject: Re: [PATCH 0/5] Update DDR Configurations
Message-ID: <20260203134108.ub26t3pnf3rxeocb@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260203063529.1551907-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MW4PR10MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: d2dd669f-25c3-42cd-7573-08de6329e6cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VElIWFVGNUxkM0YrblJSWkdSQVRWWnNNVHpDbVhnQ0oxQXdLNWluTFFuS2tq?=
 =?utf-8?B?dm5yRG5SSGRaaGJQRnFRdzBTN3NCSnVQS05KQnhFR3g2Um0rTm8xQ2lNT1RG?=
 =?utf-8?B?RlNUYW9wUXRuNTNQZE1PM2xUenBXVUs5Skh3a1FwdXNVZjRPSDZjYXJKTmNM?=
 =?utf-8?B?NlhXVkgxbU9sdnVHNXMwZUtnYlMwSU51UDZrVlREd0hvOWQ5c1c2N1dXeU1p?=
 =?utf-8?B?N3VrOWxJMU9zSk5HZ29ScDh0Q1EvbWJLUlMzcnBnYjc1VlFjVzBiWktnU2tY?=
 =?utf-8?B?bUFDNWY4TXJxcUN3WCs4cnFNMFhRL0RCM2xaMkswMldENS84ZzVEalUzNU9n?=
 =?utf-8?B?dWpLekFsc3lEUG9UT0xURDFvcjdJTTlKKzc3UnovRXNmL0JRd0l6bFliendM?=
 =?utf-8?B?TDZJVzkwNVhzNFBPZUx0OTdYazZ3N2xZcE1tUHlGLytnc00rVFUwVlpmRzRL?=
 =?utf-8?B?dTN4aTJ0c0RTYkhFNnRnQ2JyUnJaVmNTMDZUeS9POHN6UHVZZ2l2Z3RLS3p5?=
 =?utf-8?B?WjIvSkpqNUJqelEvUXlTU2w4b05UcTFKZlp1UlR6MkhvM0N5QXpxbjRKSGdU?=
 =?utf-8?B?ak9JWXVoUVExVlFJM3orNzloeTIyRi9CQ2lTMytjeS92aXpVM1laamgrMldN?=
 =?utf-8?B?eE9ZTnZ5TU5GUlRZSXlaZlZhbkg1dmlDSzlQYVYzVDNGTHdBK1JVQ0EvTElH?=
 =?utf-8?B?YUROekRaODNheTlyQXh3TEl5b3ZCOWlXWXllREZiRTQ3UkYyYlVwSy8wWnZo?=
 =?utf-8?B?Q2EyNjczbmVVNWxCNG82K1h4a0tIUTFNcmthazNOb1AwdXl6K3NoeW50SFJD?=
 =?utf-8?B?OUNpSXVhakczdUl1bGlqSGYrRDF3WGVQT0xxNnlSZWJTUG1nZkhGclBGdHZW?=
 =?utf-8?B?ekFzYWoyRTMwWTJHTWYrWHkzOUJOVG1PMUtLaE4vWVAvdFhMRnF3ZS9GS0hk?=
 =?utf-8?B?TlhFZzJBeUJQbEszRk42NHFtTVIvRUM5UEtTbkNQQlM4Wk9ZeThZSHlEaWRr?=
 =?utf-8?B?UElKQWV2RzAwemNLeDZVZHFVengyRWRnSks1ajFRYkg0RFNJbzBYSFdnN1Bq?=
 =?utf-8?B?ZjdSSmsyUnlkQm1Cek1iRC85ek5hLzJ4SzNrMnhQRUQxQXl3R3JVT1BRUkEz?=
 =?utf-8?B?RDkyN0NiZ0h2Rnd6eU85ZFkrMlpQOXlicTZsNWczUEtRbGlnN0M4am9uZmlH?=
 =?utf-8?B?c2EyNHRyZVNlOHBzblQ0SkJIMHBNUlBnanlsclJLWW1hZE0yOGY0SDlVV0pX?=
 =?utf-8?B?UDVObDBOZ0src1dvUkxtc2J0L2l0QUdZNFRweXFTM2VlRjZUZ2tuMnQ0eWJE?=
 =?utf-8?B?QWVKbVJLQWtLbnR0eGZaL1NSeUpPcG1nRXhyVVlTemFubGMyNmlvVlNmSUQx?=
 =?utf-8?B?U0d4aldBQko1aWwrMmJWanNDUlgvSWFsZENqVTA4a3l1dENIdUF6cEsvV1JR?=
 =?utf-8?B?d3JuTWFweTZCNDNYQlB0Zmo2TGJ5YUcxMitxcm9qZ28yd3dPcGJDVTd0VHpO?=
 =?utf-8?B?eDI3TTBraEx4b2hteG9uQm9iRTFNUTZ3QVUwZEE0WTVFaDZJYUR4bG1VQUd1?=
 =?utf-8?B?SHhzNDRBVGlhR2VkdUN6WWJGeFB2aWkzNVhmUjIyMERTOFozWUZnL3ZoVXJa?=
 =?utf-8?B?MWJXUjNSdTI0QVVJek5HczNua0ZYR0ZENWF0cEVsTGxBL0dhdENvU0VlZmoz?=
 =?utf-8?B?bERucEpGSi9laGsxanB5TDFGZTZLSzFXU2pNTytuRzAxOGQ5MEprNUZFTGdD?=
 =?utf-8?B?Q0YrcTVtK2NpMzB4dkpsclFlRlBpK25DSGFUMFh6UXJxaHJnZE5VMmNXU0Ra?=
 =?utf-8?B?THFBZzY2SnBsZ1JnaWFJb3ZFKy8zQzd0SytxdVFBZTlHQ1dYT3BueHZvaWYz?=
 =?utf-8?B?V1JsVHlqN0VRSlpnYTdpV05Wd24wMnVYRndVZnM4aGszdjVsaHdxOFEweXhi?=
 =?utf-8?B?eWJocFl6elNrbiswc2RicFFCSzlIbnRycjBTb1NiWGhpREpUQUZnMUpJZlFD?=
 =?utf-8?B?YU00eTZIakoyekN5Y09xcVJFWHhnWlE1bVdjT2JWTUFlL21uOHkzeW5uTVNk?=
 =?utf-8?B?OEZUKzZWL2didFhBdWl5RFhnREF5U0Q3ajdmZzFWV2pVbzhxcmNlR2dXZTdO?=
 =?utf-8?B?Nmg1Y0VRd1NRMnFrYWc2N3kyNVlHemJhVmxPOXVyK1N6L3B4TjVqcmVMWk5o?=
 =?utf-8?B?MUZ1MndvMDV4Nk9pK3VpUCtOUk0ySDFRbUpZK1pzWDR3aS8reGlDTDVXTU1W?=
 =?utf-8?B?UmhUZWRVdkJtSUtqUVVYVzNsazl3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZcYD9lCQc7nxv3sIvHAfpmMI0ch88I2ytOjiBu4fCuETMHeyj1chCi9QXjLz0fefm1h/cn+tCUzaoe0EuH5gAZrjnCBxYKyQAb46mEPxNhj3EYsJqTPl3dZAnFK8gisv09EBZo29uvcnL24j23wu3ZNQY5Q2xxnV1Y7kRPKCRwONcDhrdmP4Y/dFiiJ75YYfZ++CItNAJNmdneJXeI8ZN0Lz0wEpPw9UTvKlER/5x3BABqYo9KmSvZquQlDiWKJ2LTsaAGjuVaexbTKdLpWXMvbQJ/csZbxbJB/AwClI3dTGaP0pqyAMV4NWj1Z0FZeaf/CVk0NhwZgLiofoiZLzQD2RAE23zaKxHlZJeNO+RnXkv0gLwMZjbh3QEkZVxR6Piu6pTK19pTQDVRVBPs/8Sf0UCwgotRcoq5d8YpN2WQnxS7uMa9iTWUW2TZMCHPqt
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:41:14.9127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dd669f-25c3-42cd-7573-08de6329e6cb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6560
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

On February  3, 2026 thus sayeth Santhosh Kumar K:
> This series updates the DDR Configurations according to the SysConfig DDR
> Configuration tool v0.10.32 for the following devices [1]
>  - AM64x EVM
>  - AM62x SK
>  - AM62x LP SK
>  - AM62Ax SK
>  - AM62Px SK
> 
> Testing:
> memtester - 50% of memory for 10 loops - PASSED
> 
> [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> 
> Santhosh Kumar K (5):
>   arm: dts: k3-am64: Update DDR Configurations
>   arm: dts: k3-am62x: Update DDR Configurations
>   arm: dts: k3-am62-lp: Update DDR Configurations
>   arm: dts: k3-am62a: Update DDR Configurations
>   arm: dts: k3-am62p: Update DDR Configurations
> 
>  arch/arm/dts/k3-am62-lp4-50-800-800.dtsi     |  13 +-
>  arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi |  25 ++--
>  arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi   |  25 ++--
>  arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi   | 119 ++++++++++---------
>  arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi   | 117 +++++++++---------

Was there an issue with the DDR on the 62D board?

~Bryan
