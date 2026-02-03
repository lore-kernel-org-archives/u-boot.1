Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47610E87836
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5845484262;
	Tue,  3 Feb 2026 15:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ved9UnWk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB6484297; Tue,  3 Feb 2026 15:13:33 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB3058423E
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UdPJciogbtl1WDBrkwnESDY+L/TPg9BLfHQHr9wb5MpnGpa6kkay9jOUBU1eFI8Dl+ty1OHseLgvTYUX2dDZa2hO85qL5Wg4kePTkYXjImuh7fSZ0thBpudwD5I/FsZV5+bsG4uDriD55GIb++CUKb5w3JF7Yj88w/bmh6IhJMvXWqTIDJvdjK6iZbfuBDtttBDtqHI3pajIXDR0i8A0eewZ1QJoarxSh1DGNrour2t/faaGvvmQQukxjGyH+Q5JZxGsZylvqrQgmeVTL8Cs/NYIG5iznOcS+1KG9GOcEWf+aLdrmNKQLXa5flMhZOwG2HNoWj+LpazxZ+WnPLLFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NV0unC1/Iec6scFvD84sdaIZCDhs7IN4VWNrUFm+DNw=;
 b=dwzNdsciDvVgkBrQEA/HqUjrnUfN3tkk9/MnTLdYsWcUMhNusnyX4J2XF3fvqbP0g5nNZ8qLvIn3vJltiDxgH8P1bCXXDZSGtc880Ef9iXvFXKcIMuxuAf3Ldg8FtNWuKIqtUREAHOisFvfvVJe0Pggs07S2z/PZQVz8OAE7nIoYWqv4n6bMTEkavF/vfm/DKLqOZ/133v0eFE1Obzmsnx+NxOO3Zn7IDGRtpC3tDHUyt8leQmoESGkiBDB56nnR3Nlu5srGpoz5x87yX5wK+lgdIma+Lzv2JjaXDbqLHOVCwF9u/9a3KZ2ncKw8ss83ipnWLe6qs2z9z0HufZ9OvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NV0unC1/Iec6scFvD84sdaIZCDhs7IN4VWNrUFm+DNw=;
 b=Ved9UnWkoTdvJ6fhMgbDQVt/w2ZTpGMVgxvxP4J4PGMyNjtfwoEp6tDby0y83E/5aX0n49KmN2ggeTCpK2dY7ttsz6XiCljTT71tEvD0xSiDOQFFB48+nYRYjUNfZjxVe71/otY4bLFRr61Sxes6bQd+e2FHUhxoI3rPvsVQ7tM=
Received: from BY5PR16CA0026.namprd16.prod.outlook.com (2603:10b6:a03:1a0::39)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Tue, 3 Feb
 2026 14:13:27 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::37) by BY5PR16CA0026.outlook.office365.com
 (2603:10b6:a03:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 14:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:13:26 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 08:13:22 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 08:13:22 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Feb 2026 08:13:22 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 613EDMjG4059962;
 Tue, 3 Feb 2026 08:13:22 -0600
Date: Tue, 3 Feb 2026 08:13:22 -0600
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Mattijs
 Korpershoek" <mkorpershoek@kernel.org>, "Guillaume La Roque (TI.com)"
 <glaroque@baylibre.com>, Jonathan Humphreys <j-humphreys@ti.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Martyn Welch <martyn.welch@collabora.com>,
 Dhruva Gole <d-gole@ti.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] board: ti: am64,j721*: use correct fdt if eeprom
 detection fails
Message-ID: <20260203141322.kkqgyp4jtdfomz3e@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260203-eeprom_fdt_detection_refactor-v1-1-276eecbbe398@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260203-eeprom_fdt_detection_refactor-v1-1-276eecbbe398@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BY5PR10MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 837f35dd-e1d1-4341-e3d3-08de632e65e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VTl3cFA1NVVndU5hUUNzeUxvdUk1S3JMYjl5ZElTcGtWMFQzSWdROVNBSi9L?=
 =?utf-8?B?aWVCQ2szVVYwSGxPRDFzQUlKVjNaazVTcmFXa2FXUjRyVjZkM3dGZkp2NnJD?=
 =?utf-8?B?blc3bm5BNm5wUS9TRnhqMnMrUnRuTThwZStTSlFYSUlaNjVNK0xrbm85QnZu?=
 =?utf-8?B?L1FRY1RXUHBLSHBkNWlPVWU1OTZ1ZW9jdVdjL21sb2pZM01wVUl0TE10aWkr?=
 =?utf-8?B?ODQ4YWVjNnVkQm9TTEI5USs2MUdRTjR1dzFZc3J1R0RXVWJlZTI0OXNrK0VQ?=
 =?utf-8?B?QVdRdjNzdGVIN3FMbUlyOHZxSE1IR0lFVkZSQ0txRWg3N2NGVm96N2xFNVpu?=
 =?utf-8?B?VXh0OXlUQ2ZUU2piMnhnS0RTQlZOVW5iNGh3cXBoLzg2QytuY1J0VUlGenFE?=
 =?utf-8?B?S2ZuamRLdDNlNE9uVVRPYmhWRVk2TEdUblNOTjBqRzlTQ3BvZFBoZTdwOUtH?=
 =?utf-8?B?eG40R09zQ1NTTHZFc1BzTUlaSjhiZWdyeVBacmt3M3BINGsyaUtSQmNUSTF4?=
 =?utf-8?B?YlNyRzNUOE52UkI0QUVEYzMzMjROZ283czg1WjBNMzVpMGJxNDUzcmFoY2s4?=
 =?utf-8?B?eVdHbDZXYkp6SUdEVFFvWEorcHZNMHQyREowQlZHWWdCTStQQzBLWTFoYmdM?=
 =?utf-8?B?K1pxNDBpN0oybVErMHYxSXJXd1dFVHZsUDVzRzhRdG9RTUVSamR4QnlSenUv?=
 =?utf-8?B?YzU3TU5ZZTFtQnkwbUJRSEd6Ykt1MEpDU3ZjSE9KSE16a2RVVVYzV214UGEw?=
 =?utf-8?B?OGVTYWVuSlV3QWIrZzFibUVWWkxEb0xvaWVKQVpvQmZISmpNYXk5OEFMaTVn?=
 =?utf-8?B?citURXVjbTYyZGxkY0FCd0Zabnd3U2w5YmlRS2FRZmJzdWNGcy9pZlRka3RK?=
 =?utf-8?B?VU1OWjBzOU1RbjBVWlpGUUtGZktkekNscU1iRVgySHVTZERDTzgxeGVXclY3?=
 =?utf-8?B?dSs0S3Racy9qZHVzN1psTEI2amVhTmtaQlhPdHprcDg3dHNLcHhmTWliK2pG?=
 =?utf-8?B?ZWw2NWJhTm5ZdXBKaWZPTlF6NmNiQ3ZGMWlGVnU2ekw0Mm1oTkxwUVVTbUMy?=
 =?utf-8?B?WVV6TVRhWnF4R3kzcVo2VTV6RG94RmZMbEx3WmlRS2JIRjJJRjRYbUFmRlhn?=
 =?utf-8?B?bGlCakcwbjgwS3RoTWJ6KzJ0a1VRRFcrY3dxcXFKdDhMYVNDUTB2V3k1TnUw?=
 =?utf-8?B?QmpsK3orVFRDdFNVb2MyQ2thZk9YUmVFeGhmTm9Ma1ZrQlRxVWFLNHJ0NWFS?=
 =?utf-8?B?Rk0vb3lIci9DeXVpY3orSnU1cjlQc1FJelVYT3pPS3lvZ0hjS3E3UjRqS1Bl?=
 =?utf-8?B?MkJCU2J5TVd6YWtHb2R2eUZNbGtJUG9tNkllNHdpQ3FHUzVIL0R5cW5VL1A0?=
 =?utf-8?B?bTlpQ2ttMVdWRHF6QTd1bm1rdStPeTgzSHM2Y3FyQUcwTGVsSGZ3cTEwMDN0?=
 =?utf-8?B?bVY1Y05LV3VHZVdhTjhOSHRGRVlyRmZFS2xrU0dFTUx1VG56c1RMVTZzOHU4?=
 =?utf-8?B?a2krVGNSWEd2QXlVc1gxcm42ZmNWaWhFYVF1SGVmS1FpUURsSUNOQXJYTzBR?=
 =?utf-8?B?U0k3U0UyRmZ5T1RjNTIvdnNlcmtjN3Q4czlYZFZmUjUvUjNwYXJKcjlGMnpQ?=
 =?utf-8?B?U1Z5MEtFc3dXZDVMZThaS2xJcUpVeGx6NkVoaWlkaW80cE9LQXBjM3NGSnk1?=
 =?utf-8?B?bHFqazROMlBNb0E5ZXUzcXR0VVRSWW9LcWl6OWwySHJVSk4wOXVvazd2dDR3?=
 =?utf-8?B?T2hPaTN2aURQcyt1RWppTVFhbzUxakZhUTdXM3htQTJKNUNueUx6YVE0NUxy?=
 =?utf-8?B?dHF4QVphOGRiSVNJTExqT1F2K1hpQmM0dkcxK1o3ZWpUNk9QRDM0d0ZhN3kw?=
 =?utf-8?B?U0crKzVwT2Y3Qi9RZ2ZUSk9OUFduVW9OakU5UTJseFpYaFNNWnVISXcvSEt6?=
 =?utf-8?B?UW1kcGtHbUdmdXJhcXd2TG9xVmUyZE4wU01NMk12azV0WVlpYk0yR1pXVk55?=
 =?utf-8?B?MTNCK2Z4d2UzYmpyK2k3VFhTeGVjUDJ3VHM2Y0lad1VwVFZ2ZTJYTXJWODdh?=
 =?utf-8?B?NEF0VmVNTkRzR1Z6RWpCR3BrRUt6d0svOFBId2hCQXZ3K0prQUgvTHdaMG1J?=
 =?utf-8?B?ZERIeWMvcHF1Nm9NajBUa3oveDJBRzhSenh3VjI3WGdMNFhFNWFRNU5GL25p?=
 =?utf-8?B?azVEcXhiTnV6V1hPWkc1Y2p4YlhCQXc5RzFpK29GV3pVb3dudk5ZNkZKNUdQ?=
 =?utf-8?B?RWpUVkhiZ2pvOVQvT3lMcUxjWVBRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LBkzrUvvzx5sAEdjkF+nRLNt+oxWNXC68MrIFCZrO+hOBsSuozXB7y6zhIrqVjF0j5RrIbSPqMCtAcQ3o7iN1VFfnlt2db0GUw4QMLYVIvQ63nYl1g3rQLPKpV6asujEoc/5hH01eU2tI+gROgxe/a/AnOTgV2vkhF4AnHC41aeYhMCAhSp5KZPwP9v4LQn3S2RMjBB3YakqJvtmUw+Th+xlGyNgypkOhmE3a9iUmxGCpAjtI6JBalfgwk9hlJDFq/9COYJppsP4JzRMF2uZa9zccrRx6nRziyM/I3zTc4HvAU26pPj0R/JZtwVUBnuziIv6T43Z7us1T9/IqvkFGgvolPpdXrSdtyBLsfe2uU8NIragwI8c+u7XaKyOSTTB7JS5PsNuMsGvuCqWnbaFJFP1je9AJX8PhQksXr0YBpJ5VgBf5n5XtzZ1UOMIQQA8
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:13:26.1268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837f35dd-e1d1-4341-e3d3-08de632e65e9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
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

On February  3, 2026 thus sayeth Anshul Dalal:
> We currently provide default board names for each board in their
> respective evm.c file. However for custom boards, this behaviour
> overwrites the default DT as set in the defconfig
> (CONFIG_DEFAULT_FDT_FILE or CONFIG_DEFAULT_DEVICE_TREE).

Are people using the TI_I2C_BOARD_DETECT logic on their custom boards?

> 
> This patch changes the default name to be NULL which prevents this
> overwrite and allows ti_set_fdt_env to instead fallback to the correct
> DT as set in Kconfig.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  board/ti/am64x/evm.c  | 2 +-
>  board/ti/j721e/evm.c  | 2 +-
>  board/ti/j721s2/evm.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index 25076a8a588..c6ddc44d14c 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -138,7 +138,7 @@ static struct ti_fdt_map ti_am64_evm_fdt_map[] = {
>  
>  static void setup_board_eeprom_env(void)
>  {
> -	char *name = "am64x_gpevm";
> +	char *name = NULL;

Would it make sense to add this default to the else case?

If I understand the problem correctly we still get the benefit of the 
default for boards we don't have a match for in eeprom but if 
do_board_detect() fails we pass the NULL to ti_set_fdt_env()?

~Bryan
