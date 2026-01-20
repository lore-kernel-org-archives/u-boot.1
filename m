Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3220AD2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 13:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B84583B49;
	Tue, 20 Jan 2026 14:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="blOIOKBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3983F83B0B; Tue, 20 Jan 2026 14:36:58 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6E9383B07
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 14:36:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWK4fU7OYRvsu+OcaCyOr45joVrZ6qhYLyeCwrFSGRDjlh7DQfGFDkcNhqyXuTDBIKmzkKnrhdM+7+CIqi3RjyNzNgX9bcfqrsPvA81uAscH3YuBMATZlTlGQO1wvLV00QKRyswUBLbYSSumIDU6uyZ8IiJzh6mVVeF63W1u++GzoRyNq65osEZwOqrmyrdBaU1eSknfeMclS/mQv3pKTLOqaVCYTe8wzKMu+/tkPkGrpuP4I5JYwVM0MSWjSFCMf8/cJw5SPJe3FEWg2RspgLoUu8WDZS6hyHfdX83meoqiFMmXlvyW2801P6GJDGd1h7yYo8l2gIl5gd4Z6IfZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKE8w9nRHbqNiTOGrBd6VXZvlLAAvzloz1ENB9srUJM=;
 b=rvK0zWOCNSVd++etoqvR7hnOCZdKVTVXOKe8aVWeYCvLUXbKNdzDINKSh+eoLSw/fYVGNl6PtWMArQGFwqzrQGKxXczwmmgG9EWVA4v7XpmYAj1qsFWYTKT5dzaKnDPsWLk/+xITQNqTk1SzPtzg1omJyAWtMTUxnQme/nJxxWMgxpD7oSgNOAtS5fLJtQgBS4mqrzIrJkQMD2UXgiFWhW1z8XkKpXEu+W9FG3u+IjJjGZHWUGqXcwqXjhFX4VhfAajIR7zIpDSHfjnr+ATIl4I5ewcm5p8HWqb3KHTRrfryzcq9X6xLGiZNb8IzxmOokYIRU5tZ9WNqWdDn9YdwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKE8w9nRHbqNiTOGrBd6VXZvlLAAvzloz1ENB9srUJM=;
 b=blOIOKBorMpchrggdfdRU0NMYo/IIV/CM9uVukFhuf973bshvsTEg+wh2gbVjf00J9C5lUX7XoC7tWRImK4//sPgLtdDEHRARxWjMFONsOIXA2BydzxKZna9zWegxnZ08r7YLxzHieaTek4Vui1HPasFtd++dxggwMTs39H8Qxw=
Received: from BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40)
 by BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 13:36:51 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:f4:cafe::be) by BYAPR11CA0099.outlook.office365.com
 (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 13:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 13:36:50 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 07:36:49 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 07:36:49 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 07:36:49 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60KDanWH1281706;
 Tue, 20 Jan 2026 07:36:49 -0600
Date: Tue, 20 Jan 2026 07:36:49 -0600
From: Bryan Brattlof <bb@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <khasim@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <v-singh1@ti.com>, <anshuld@ti.com>
Subject: Re: [PATCH v2] doc: board: ti: Add AM62D documentation
Message-ID: <20260120133649.r2juaw5yxvggfga4@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260117033328.837487-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260117033328.837487-1-p-bhagat@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|BY5PR10MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b349c7-4626-4749-5fb3-08de5828f75e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T0N5ZkJOZXhUdU5UUGUyNkxWYmNkSGNsZlR3cFp6emp4YVdnL1hUU2ZtZEV0?=
 =?utf-8?B?V2FnbSsxcFdRbFNpVkkwaVdMUUJqQkhHQ3prL0J5blVpWU1xeFo3UUovc2tZ?=
 =?utf-8?B?UUVoY3k0emkrQTFmUThXRE5YdkRKQW9PRmtMc3lLd1VLdVZCK1NkYW83Z1Z6?=
 =?utf-8?B?VkdKbEppblB3ZWZZS2N3Mi9RUm1NZWFlMEJmdGp4ZHVZcUkxU3I4V2FLN0t4?=
 =?utf-8?B?QVRwV2szNXdtNEIxUi9yOTBWd2tWS0c5bXpQVzdVRmxHRHFYZDYvY0M0Uktz?=
 =?utf-8?B?T2tXckVkQzJUMEtCaDFNcWw4cWorMjFKdkpzOUl6dm1EMzd3NnRGYkUrTGw3?=
 =?utf-8?B?TkFBSm9oc015R05IcVdYT0hHMlFkc0tYK1VzL0pTV3N5R1l5cmNCUHpkWWkx?=
 =?utf-8?B?WkNNbWEyYWlJYlFhVndQbk1ueGVyYU5GQUo4M2RObW0xMFYxVEFmSHFVZ3ky?=
 =?utf-8?B?T2I5TitsYUE2aWpmc245dE4vWER1NkpPbkVTM0RBNU5SNTFvNFp6Ym9CSCta?=
 =?utf-8?B?TWNhWEJxTjhCV0hYR3BhTXkydU16ZTZSanJKZ1VuT004ZzR6ME5zU3JBSFFY?=
 =?utf-8?B?YVhQcGpISHU0RHdsVW1JZzFlTUgwSkJ2bGlPNTB3Y0ZMQWhraVpYbGpoS2lV?=
 =?utf-8?B?ZHh3MEhkbHgyZXh5LzVXNFBWWlI0WXZCK28waHFWSFhucjlJWEw5WnpBV2lu?=
 =?utf-8?B?SWFXbUM3UDVxcitTNWhUTUJqUzRyaXo3cFBwK3VRcEZhWlVzMWlQc0RCOSs3?=
 =?utf-8?B?MW1URTdQN3NsWmt1R0ZjMVhvT1V3cUljd3hSbFJ3aTJnV05vZUl1dHN3cy9j?=
 =?utf-8?B?aTYyODZjcmpGME5KQW9GUGh4Z3BYN0p1ZWsxMjdrYmpNRFNrTHJINVNHV3ZN?=
 =?utf-8?B?VjlRMEpiRkNkTTdERXNqZDdPRzBSVGt0cXJIMDQ5ajFTQittWkh6dmprMVpt?=
 =?utf-8?B?NC9IZ2R3cnlrNlRVR1I3aHBUc1VHVTE1clowRFJPS3NIMEdlUEtiQ3VTenhJ?=
 =?utf-8?B?Q0pjdHJjWmlxSC8vSURVaWU1OUI2cW9wdTlwdGlIRnBheVRoMWNIdSs2Wngr?=
 =?utf-8?B?eUlsS1QrRVQ5ckdXRDR2MzNkRTZWUDA4bnJ4MUZVSzlXa2JBODVvaFlXRFZD?=
 =?utf-8?B?c3RqbUVGYjJEekVHRXNBN3JYZDJlcWNZa2E2STN2Q3J5SE9pSURRbTNzYnpD?=
 =?utf-8?B?QzNuT0lLaWtsNzZLNVViQlMvRDVicTV4L0diTHBrbE9xQ2pmclhoMGRhb0xV?=
 =?utf-8?B?dlRZWGcwekc3ODV1Z1VuSnBUNSs1VWlCc0V1dDJ4V0JqckNZRVdkcncrMkZ1?=
 =?utf-8?B?Skl5dFcwZWJLanZUcWdOMVRQSlRMeXdTTmV3U0lxK1dOY1BKaThwMVZYYVc0?=
 =?utf-8?B?R1kycm1FWk5DT3RmSmNBaUF1S1llckRBOUE1eFVBTkx1U1g0ZUFSMG5mWE8x?=
 =?utf-8?B?d0VlTUk1VlR2U25RYmpEMkFhT1Y0b2FIeVdtbFZUSy8rQ3hRS3orL0JZSTFB?=
 =?utf-8?B?UFF6eXZ3VHM5ZGVJVDF3YXFRb05sNU1VNFhpTVN3bW0vVnBIeEN6R3h0a3R2?=
 =?utf-8?B?RFhsWUlJa2hCWEhqa0MxTmJ0SWdIVzVMMGI1cjhFN0dJVDAxY2puSEJyTTRN?=
 =?utf-8?B?cGhJMmJ2SS9RTG42V0lUL25rTGtKbkcwRWZHbmVDbkhHaDZZMHM3K3BHek5P?=
 =?utf-8?B?NVFOeHEvTWhpM1AzOS9FWHZBdDZETUd5TTV3WnRaeW9rN1o4eC9jM082bFJr?=
 =?utf-8?B?MzBCSXBQYisyS1ZNa1JicXdZaEQyeVJmYkZXVTI5aUdsQnpCb1h1ZCtxUWQ5?=
 =?utf-8?B?VWRIK0t0bWNuUVl0ZGVpMU95cFBzd01jL2IvYml1aU94RktEWUsycUxKRU5G?=
 =?utf-8?B?L0t1RThOc0FKMFRyT2ZqcFRtbXFEUEtLMVVNWFY5ZFpzWDBWWDdTTTFwSUx6?=
 =?utf-8?B?TjJ1dXlDT2paMG0rdDZyQ2lBSE96M2ZOdnZVa0JxTjdwNXhNR0JZeFhKN045?=
 =?utf-8?B?YndLN29qdEVkZmpnOWxSUmJvTFUxMjRTS1BZc3FKTXVpaS96M3dVNTcwbTh5?=
 =?utf-8?B?aWd1TG1oOHErNVluZkEySDV3M0syaEpBUmN0UEF5ZzhTRzJsenl6RnhHdDE3?=
 =?utf-8?B?L0wwQXVUcWQxZzRIYVVhcGRuYmtGTlBsQ1pjdU1uSlRHbnM3djBBQVJENkpV?=
 =?utf-8?B?WXFnczk5MU9QSDdvVXMxRnhnekZWdXp6UzZhMTdtME50NkVYUHloT2NJRjJW?=
 =?utf-8?Q?M/UDPUkSVHjIs3IU4fn9tj4Bsq+OD81fjYA39tcFfA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:36:50.3990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b349c7-4626-4749-5fb3-08de5828f75e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4306
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

On January 17, 2026 thus sayeth Paresh Bhagat:
> Add info of boot flow and build steps for AM62Dx EVM.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

Thanks for adding docs for the reference board Paresh.

> ---
> Change log:
> 	v1->v2: Updated openocd cfg file path, usage note and TRM link.
> 
> v1:https://lore.kernel.org/all/20260105183545.4108567-1-p-bhagat@ti.com/
> 
>  doc/board/ti/am62dx_evm.rst | 256 ++++++++++++++++++++++++++++++++++++
>  doc/board/ti/k3.rst         |   1 +
>  2 files changed, 257 insertions(+)
>  create mode 100644 doc/board/ti/am62dx_evm.rst
> 
> diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
> new file mode 100644
> index 00000000000..2d66241ce68
> --- /dev/null
> +++ b/doc/board/ti/am62dx_evm.rst
> @@ -0,0 +1,256 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Paresh Bhagat <p-bhagat@ti.com>
> +
> +AM62D Platforms
> +===============
> +
> +Introduction:
> +-------------
> +The AM62D2 SoC belongs to the K3 Multicore SoC architecture with DSP core
> +targeted for applications needing high-performance Digital Signal
> +Processing. It is used in applications like automotive audio systems,
> +professional sound equipment, radar and radio for aerospace, sonar in
> +marine devices, and ultrasound in medical imaging. It also supports
> +precise signal analysis in test and measurement tools.
> +
> +Some highlights of AM62D2 SoC are:
> +
> +* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster. Dual/Single
> +  core variants are provided in the same package to allow HW compatible
> +  designs.
> +* One Device manager Cortex-R5F for system power and resource management,
> +  and one Cortex-R5F for Functional Safety or general-purpose usage.
> +* DSP with Matrix Multiplication Accelerator(MMA) (up to 2 TOPS) based on
> +  single core C7x.
> +* 3x Multichannel Audio Serial Ports (McASP) Up to 4/6/16 Serial Data Pins
> +  which can Transmit and Receive Clocks up to 50MHz, with multi-channel I2S
> +  and TDM Audio inputs and outputs.
> +* Integrated Giga-bit Ethernet switch supporting up to a total of two
> +  external ports with TSN capable to enable audio networking features such
> +  as, Ethernet Audio Video Bridging (eAVB) and Dante.
> +* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, OSPI memory
> +  controller, 1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other
> +  peripherals.
> +* Dedicated Centralized Hardware Security Module with support for secure
> +  boot, debug security and crypto acceleration and trusted execution
> +  environment.
> +* One 32 bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
> +* Low power mode support: Partial IO support for CAN/GPIO/UART wakeup.
> +
> +This SoC is of part K3 AM62x family, which includes the AM62A and AM62P
> +variants. While the AM62A and AM62D are largely similar, the AM62D is
> +specifically targeted for general-purpose DSP applications, whereas the
> +AM62A focuses on edge AI workloads. A key distinction is that the AM62D
> +does not include multimedia components such as the video encoder/decoder,
> +MJPEG encoder, Vision Processing Accelerator (VPAC) for image signal
> +processing, or the display subsystem. Additionally, the AM62D has a
> +different pin configuration compared to the AM62A, which impacts
> +embedded software development.
> +
> +More details can be found in the Technical Reference Manual:
> +https://www.ti.com/lit/pdf/sprujd4

If you have to make another spin of this, one small nitpick is to have 
this link be consistent with the 'Platform information' section below.

> +
> +Platform information:
> +
> +* https://www.ti.com/tool/AUDIO-AM62D-EVM
> +

~Bryan

