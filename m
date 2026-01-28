Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91037D25B4E
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 12:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC7AD83CEA;
	Wed, 28 Jan 2026 13:27:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iO3RIZ7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892AF83D6C; Wed, 28 Jan 2026 13:27:09 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7611583C65
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 13:27:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgXyXK4rNXPC0YnM8HkyUi2pv/2xeEh/IzPFKQmBQW56pTK9nvreCgmye1C2HzptpEDrcneeUednoCsDAPFTVs6ADBOGxTSPceLUMcvTaZ3YrasSzgoxsjVJ51lpV/M4CGFkWECxJDIKSUOAsMlDpYz4mLS4xCgGRyha187Z9is5vxFoX06/NvNsRWiwN3p2ezDZ1hCgEfdJsi/8aKSVpbcdBQtw6KbMiDifsZOqsCJ9zv7hl9/Mz8YnNMjtu3o2D/DawLITzl/4lhhZGpRMmj8Rvx/NLc6i2fDc02MiVw6brmgt1HGg4r3nBarc9O6R3PeEMMnLC2c6Pq69TM1J9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws3tVTeHBCFEbfkm0KuUX4Kgpfoxr0V8ROQO0nY1rTQ=;
 b=rXvFvyeXRD/y4AMVm5vzs3n2tnHzplx9tCZ9PkCG4LYUu01sonYh8q9xni4f+zwzZ/pc1C3AwrUIvj0dUHJrc1Dc22zSONlW2UqL/cENMEATtpaAR1yQAlYfY/n9Fm1t03A3thOODFACLwTUZHoGPn9mBpg+maNXZMI8kPY313QJ9Tlk9vjAescemdonpzz/SaSpXA6AEfuCX9y0jvjc407q2xnROISk8ISTwzz2a+NAROz3QDPZRcM/S6WcZ2K3+R+ok6DJW37QCpuKZYjXhSUODwgCEJkAd6W5GzwRX7SXDkUnbiM/uEAAZuG500X5FUc1M7B+pYX/lhHs9PJC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws3tVTeHBCFEbfkm0KuUX4Kgpfoxr0V8ROQO0nY1rTQ=;
 b=iO3RIZ7olFEAAkEP9VH+VgJrRhffvXZsVv7nEJpc7bsRuvZQZmwzCqyf17aImnEQQKhAA7d/rg2sMIOln/4FKc2EsPtw6W5/jEAP8sqonbHTTXP05QiII1ywGXnGD7d0/eAfXMxHz83WkFgHjb5hlxOPh9IFCVxA1FlsQOJCQXA=
Received: from BL1PR13CA0426.namprd13.prod.outlook.com (2603:10b6:208:2c3::11)
 by CO6PR10MB5556.namprd10.prod.outlook.com (2603:10b6:303:143::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 12:27:03 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::ba) by BL1PR13CA0426.outlook.office365.com
 (2603:10b6:208:2c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 12:27:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 12:27:03 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 06:27:00 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 06:27:00 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 06:27:00 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SCQwii1952253;
 Wed, 28 Jan 2026 06:26:59 -0600
Message-ID: <d2a8da4535de0e262c3e8a2280a911f1700f2622.camel@ti.com>
Subject: Re: [PATCH] PENDING: arm: mach-k3: manually set the main_pll3
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
Date: Wed, 28 Jan 2026 17:58:20 +0530
In-Reply-To: <20260128122604.2735602-1-s-vadapalli@ti.com>
References: <20260128122604.2735602-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|CO6PR10MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a80b29-4d17-4964-3e0f-08de5e688acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVZpUmFnUFQzZkpMTzhEQ1VmOExmT2dac2pjV3loMDJTR2RERmxybE5kdDVE?=
 =?utf-8?B?TlBucHh5NXgzVUJLYnlzR29GR3I5VmVIRVUwbjRySEtldi82KzkzeWZPOXV3?=
 =?utf-8?B?ekdCZjF5Z2dxWTY1L1JWeTBTaEVlOWJKVytpSnYxeUlhaVBBM1VGQ1c3VU43?=
 =?utf-8?B?YUZyYnlzVEQ2aWJaYndVekpuTFpPTVVuQjZiUlk4c3o5dWpvemw5eEtMdVhL?=
 =?utf-8?B?WTZ5UExxWmNTNWN0M2lUVWRkaFZnSlgrV1pGb0o4d0hrZnhpZ3B1VkI4OXdI?=
 =?utf-8?B?clR3WE9KUGsvRkNqVVhoWEY5eTBqTnhyVWo3dExXS3hOc1JFSThzcVBVaGE3?=
 =?utf-8?B?bHpvNmNMcWVJRHNncWNwZ1lKNS90UmVYQlJmYklwYWhSYVByR1pna2Q5WkZJ?=
 =?utf-8?B?QlFiV29tK2Z2Q1EzUGsvdjUwSmdDc3Z2K0ZqZFYySXpQR1JyNmlEUWF1S2Zu?=
 =?utf-8?B?SkJuZnExTmdzMWZsenQya3lXVlBjbjF2RnB5cituTmtDbVAxbHY3aTBXQ0tN?=
 =?utf-8?B?Vk1mK1RNaDE4d1pacFo5U040ZTlISUxnMFlhcHNVbzhNZHpYSldUKzFLOFkw?=
 =?utf-8?B?YU5DYkVvTUlSMXpNNWdWd242bjZsNzFqTWtwazNGMmRLT2dNVXJnaWkxNElx?=
 =?utf-8?B?WnE5R204NVFqV1hBbG81MDBrcUFjeCs4bjFZYTROR1BrZHpGK0JjRG5iWjF1?=
 =?utf-8?B?OEJQNGdaNVd1c0ViQjUwN0hMR0kvNmpKSXdHQXV5MmtHRjUyeG9mMGFEOVZx?=
 =?utf-8?B?b0hCUDd5WDZTOWxQOEZXNmtyZFMyOHJRMUJTNlI3dXMrZHVVZDBQcHVtbVhv?=
 =?utf-8?B?cEZFak1yOEpOcXkybS9rVE1lQ0xYR0dKaFpsanByUzJMVWQ0dkRGRWhSd2Yv?=
 =?utf-8?B?U0w0QXQ5czFYQU03dHFUV0dmSWloQTFqeUtNNGFFWlBhNjNyRmdCb1ZmRkd2?=
 =?utf-8?B?WFhSdloxMUUxTldmb1J6QVZoSWtuLzdFMUtCT1VyckxCcUloeG00Z1FOWVVh?=
 =?utf-8?B?T05zajl5SXlZaGx4U2JTeWU2MUZsVFpuaHNYSVpYWXdiT2t5NDJwQW1OZlVI?=
 =?utf-8?B?RG1ZWHZ1M0V3L2RyMUNJQmtISHJBRFRaUm9WelVNdmpNVnZyb3FXYU91WkU4?=
 =?utf-8?B?VU1lYnhpTmF0dWo4TUQxeFIzYVY3V3lOR1dYZzRjc0NGSUZicTVwRFk0Qzdn?=
 =?utf-8?B?WXJYNGwrY09mNHVPZlRJUUNUdjFMYTkrR1lreHUxY3ZseGVYK0ZIajZjUXBO?=
 =?utf-8?B?aXBWRlVGNHpYQnZjTW94N3pHUDRBbk5JZHh1SkZNTzN2M3o1ZEozbDdnSkhq?=
 =?utf-8?B?bGRXNm5PSkFrendVQWMwSllJTXRqdXJkMWpMVUhTREYwWHFvUENlS0MrUGR2?=
 =?utf-8?B?Ymg5S3l5VllSRmtvMFB1QlMwZEkrYnBJRGFlWjRHZU1xN2dSb0Iya2JIMUJp?=
 =?utf-8?B?QVBFd1F6NnRGQ3hDKzNENjBSeGxYMWxmZmk1TlNna2w1OVFiT1dTL1YzY1Vw?=
 =?utf-8?B?VjJKQ1MvMmI5TzlYOUpONkpKU2V2SjVuaXhwTjdSU2Z0OGlXZHIzRzNPQWRZ?=
 =?utf-8?B?LzdLOGNOVm1xV1lhcVJCd3pkdFYvbkFYNlZSVktCRW9KcE9Qck90Y3FGd0g4?=
 =?utf-8?B?ck42Y3RrUy96V2FLUUNoYVRIRmpaQlVkaXpqeXVObFdiT3IzZDF2SVRLV004?=
 =?utf-8?B?ZnM2K1ZiaTZTSGtFOTVhYjZ4OXhOU0pSMitDVGVjbFVQTWpob2pRM3RGYWpL?=
 =?utf-8?B?ZHlDTU9vSGpncllnWU8wZllieW41T3h3TkZIdDNTdG9wV1RqallST0FZSTNm?=
 =?utf-8?B?NHZNRTVPL2QyNFJOT2tvLytGUWJzbFhQRlBIQ3JtcVhud2N1SDdXYWNBemp6?=
 =?utf-8?B?cEhMMlRDQUdGcld5Z2FRYzBrbjlGMXBBU2VUNmRtOVFzVFhRRW82NTJBNytJ?=
 =?utf-8?B?bHBGRWV1eFVmbEt2aWhOdE4yYkNDYjE3ZkFvQXYwZ0NzL3FpMXE5L1JrSWl0?=
 =?utf-8?B?SUZDU3FqUEFsQVFsRDhmUkc3VUZZYjNpZzE1S1FWOWE4cUJFZ3NFOFBuYXIy?=
 =?utf-8?B?dTAxaWNsVzB0RXp1eFY0SWpEOTduUWVnS25CVDVPNGsxNHZLeWpwUTUxUzZr?=
 =?utf-8?B?RnRYUHFENmVZNEFCb1d0NzJ1QkZvWFkzbWttZG9nbnRCMU5jUjhVZ2RtNjln?=
 =?utf-8?B?QmZDTDhHNmhaeWJSZEtDZjNRVEg3Qm5FMU1qVjVoQ0hkVU1oYkdNL3YxRXlQ?=
 =?utf-8?B?OE8wRHJCMjRKZ1B4R0NmUWRqNGRRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 12:27:03.0183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a80b29-4d17-4964-3e0f-08de5e688acc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5556
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

On Wed, 2026-01-28 at 17:56 +0530, Siddharth Vadapalli wrote:

The $subject needs to be fixed. Sorry for accidentally sending the patch
before fixing it.

I will post the v2 patch with the $subject fixed.

Regards,
Siddharth.

> From: Bryan Brattlof <bb@ti.com>
>=20
> Moving forward, DM firmware will no longer mess with the MAIN_PLL3.
> This means MAIN_PLL3 will need to be manually set to 2GHz in order for
> the CPSW9G HSDIV to have the correct 250MHz output for RGMII.
>=20
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>=20
> Hello,
>=20
> This patch is based on commit
> 431f1ce46bb Revert a number of incorrect commits
> of the master branch of U-Boot.
>=20
> Regards,
> Siddharth.
>=20
>  arch/arm/mach-k3/r5/j721e/clk-data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-k3/r5/j721e/clk-data.c b/arch/arm/mach-k3/r5/j=
721e/clk-data.c
> index e4511092c86..bb7f61901b4 100644
> --- a/arch/arm/mach-k3/r5/j721e/clk-data.c
> +++ b/arch/arm/mach-k3/r5/j721e/clk-data.c
> @@ -539,7 +539,7 @@ static const struct clk_data clk_list[] =3D {
>  	CLK_PLL("pllfrac2_ssmod_16fft_main_2_foutvcop_clk", "main_pll_hfosc_sel=
_out2", 0x682000, 0),
>  	CLK_PLL("pllfrac2_ssmod_16fft_main_23_foutvcop_clk", "main_pll_hfosc_se=
l_out23", 0x697000, 0),
>  	CLK_PLL("pllfrac2_ssmod_16fft_main_25_foutvcop_clk", "main_pll25_hfosc_=
sel_out0", 0x699000, 0),
> -	CLK_PLL("pllfrac2_ssmod_16fft_main_3_foutvcop_clk", "main_pll_hfosc_sel=
_out3", 0x683000, 0),
> +	CLK_PLL_DEFFREQ("pllfrac2_ssmod_16fft_main_3_foutvcop_clk", "main_pll_h=
fosc_sel_out3", 0x683000, 0, 2000000000),
>  	CLK_PLL("pllfrac2_ssmod_16fft_main_5_foutvcop_clk", "main_pll_hfosc_sel=
_out5", 0x685000, 0),
>  	CLK_PLL("pllfrac2_ssmod_16fft_main_6_foutvcop_clk", "main_pll_hfosc_sel=
_out6", 0x686000, 0),
>  	CLK_PLL("pllfrac2_ssmod_16fft_main_7_foutvcop_clk", "main_pll_hfosc_sel=
_out7", 0x687000, 0),
