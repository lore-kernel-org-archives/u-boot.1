Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9990AC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 06:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9289807C4;
	Mon,  6 Jul 2026 08:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oLn5cTO3";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mx8dINF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B341684105; Mon,  6 Jul 2026 08:41:19 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09E4780398
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 08:41:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6663wEZY3181752;
 Mon, 6 Jul 2026 01:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aMl2RzwHutvXowvk1V2qN21QT4qPEw3t+0uhEa4oT
 Gg=; b=oLn5cTO39R/VIagxkXTyPMx+uI7h/unENg7sRlwdIGUHXpTangesvDLC5
 DhSyGbEDoomAPusOSg81QqhnQDGoBYjCvvQPzMI7MrWpbGac5prqyV+2r17FBLBE
 p3O5P4RCIzVRcuKhEiZS+K0tK2t48M8nDbr1Iln3PbsnO0cY/KiNn05FJdqI+aUn
 GfWcXvYOZN2U2q2rt6ypogrkMcqnnijx9mjsIU1M+k93TTTZUxBab7HJ792jXUQc
 PvykGQUpZAsVq+aCkZTPXx9Dj0YRtxXe9xgQarG+DSfZSz0qdD2NzCuWiTaf7i+/
 Iq4wECk3c1ZjZcMRv8NFGS0SSn4fg==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f7p70kyde-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 01:41:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIHx8txNPlj8xkzM4nKttT6B1TaAvkTE1UmJQAmh+gDcQJ3jDBp+raRzR4ca3OOynZYn2Edncvn9otE1YaJwwYO6XDH2+M9gksdcuacJWmanrMVAWQAMgbKw8cGRv1csfFCDbv4sDrkRjuj6vWl9HEMlLiSma6pKH1ZsS3oH8YOYyT5Ni0FkA+hwxI2EpcV9Pz9MqyzwReD7QPBw4lrfhTaapnUTHyNWRuXJCQWOfWdnyO+wCNOkZb11XLDPwX5Tlf9h28uOsEE+Q/bugrGTq6X/zGadQ3NbK7bNEYwVwvasugqlqtI/av3/IdAZEZjcDi5EglzKMPQ9TD7wC3ggtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMl2RzwHutvXowvk1V2qN21QT4qPEw3t+0uhEa4oTGg=;
 b=GitiwB0JWnK+kgxBAO+wVKBzX9fZUY1OaKa3DnYLQ4CTVpavBFubUQNrfgMpSGMsIYaIb9lCZLyi0u8YIjAUIw1PKT5Ylv+wiX1KuDn8SgD1O9I0ohwgriq99NwuyRBT1eS2zIHsfBXfRJPBMHXxPveu8efoFlrD6o0OyWBYtez9IX31lKd4mPFGQTktGuzdpgCsTH+T15OkpcrPTAZkJFm24OTvx3QAU/I1uAy8lMZMtos++M7EsPmUC+uhCXhR/FWcyFfTqIWs154LBPQH3da2fOiAPX8AM2brEN3RlhCyV61uLfsT4iilyWgI0JHdSPQ876epzDJOW/DmwDvm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=baylibre.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMl2RzwHutvXowvk1V2qN21QT4qPEw3t+0uhEa4oTGg=;
 b=mx8dINF61BUEfMIzQ8zNqOwEdo2d3nh++hYwevm/jMhxoWHm7y6T4NgamU1xL+PXrmzKcHeQ0hMDQ7dEdN6JbaRs9nhgxceu+NxjPalvSAWATaodiADyxDr+MMIHw68CBl2girqbZZOoAOpIg2ETqZxTf6DviRAtChrbs/J9iRc=
Received: from BN1PR14CA0017.namprd14.prod.outlook.com (2603:10b6:408:e3::22)
 by MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 06:41:07 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::2e) by BN1PR14CA0017.outlook.office365.com
 (2603:10b6:408:e3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 06:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 06:41:07 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 01:41:06 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 6 Jul
 2026 01:41:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 6 Jul 2026 01:41:06 -0500
Received: from localhost (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6666f5WF1239001;
 Mon, 6 Jul 2026 01:41:05 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <p-bhagat@ti.com>, <afd@ti.com>, <anshuld@ti.com>, <bb@ti.com>,
 <joao.goncalves@toradex.com>, <m-chawdhry@ti.com>, <msp@baylibre.com>,
 <n-francis@ti.com>, <praneeth@ti.com>, <sebin.francis@ti.com>,
 <u-kumar1@ti.com>, <v-singh1@ti.com>, <vigneshr@ti.com>
Subject: [PATCH v2 0/4] Add DM firmware reserved memory support
Date: Mon, 6 Jul 2026 12:11:04 +0530
Message-ID: <20260706064104.138000-1-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701075021.3626094-1-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: d97b5f01-2d2b-4485-67a2-08dedb298ef9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|13003099007|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FHXBqfGYTKaYxufa7nugAoF0CAAM+tTaHBv1VSZiyWht7MiooAzXJ4w2gxOZeVW/Ba9W+bHiMyszKX+B2mxKsrFXdP6bdVeer41KosX9zLtwW4j0c//Fu1hQCuEup8yfwZLU7CRfqdJKzf4eKhYouDmklctZFBi0NouPuBA48eOHd9EUAhxT3Hr/fcWJHLtJUTXZITdLP32OrmFYPcy4GtAfASn/ByYkWGsXRmDYCfq/4CCpIJnHpSxqERr04OM+RKDyjqeREEDD80sSUo0b04YX/GKvnYxEpGozPUIQ9nQ1inOwcxGmIKIs5lmW8of+bKAFww+sff2qoAEhmEYp/Rr4YIkRHFTcxJzourfLEcExWxogE/mnQtxle2FXYakjKOY0AlOOBvMcDtLz8igm8iJ8rZ53ws89ocBHLfuUKil9/gy1wCUUw9NUZIMtDfVTxiGHJm6nOFxfP0UfRJvU6gFFLqtWispT27RKp4MXQR2zrfUZVZ2a503pKYIVINUV0RDRxZcAYMbMPCqbAWSE96Ml5YlvG0ickg3+G5tnwzRjSZYx7Z/h5KMlCdc8ptZ2tQ0fmq2uI2xwwcf9//L24/2pb7Qn/GFYbJv7WaRLBVrdF0ojwOZQQB6G50Zm8OESnsZeAB9d4n814jfBlcbA99wL8XBrYD/H/6U1ghs6bTUUfsWzmz7FnjTuX7DPI1RSM8ZUwdk8xp8Ie/E/Pc/bYA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(13003099007)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iDtr5JF88I5vKxnD6M3PE0MKUhCiydcchJBIv1klgX4Ll92bY+gqDHNkWRYmMTdE0xggleScroIv0YeEjg9dmQINRpwoA3kvnPwPgajaLK/RZDl+WGCGS9tusPnVVPS+SQqI/eh0NsYY4s94yWbAasNHDIhR0Pi7JnLBWM2q360PTIcFue9bTax8SSZf8aiVPZRlKEodBy/tYoJAc+uvBM6Hr4SKfxuycBubAZ0lExUGeWaUrXVl8eXroQkeeDjCRIRGw2PFxP64ZYCFxe98f1f89YM771cRC5IhYJGgjnFeY5KmmTQu3KI3EOYip05z80gOR8ey6A04cELsIgkbjPpfx3kLdoQTvaXsc7rRbOP6slkSSOk3JOBuFt7MD11WgcxdNttW3Hlbvckoty2xtggHc6ILPlK42GhTIOFGMManJ1Azc+4JRCwZ1WbdMNvx
X-Exchange-RoutingPolicyChecked: ozLRLFbCnwmGfy4rtWhuh7JCnYGI7Q6tUZu7HadtO1fXKVx2zWFP70jRXsNaBQ69kBVFaKEpQJBCfORDuJpFgr4q+jjGhazDbnXAo8FThM1fSJpkmu6/+rDcY6IYhtMr1t9kvAo+g3CaAybnh87t1bVD1p7S62kfIQOBKC5zaCX8geIYJ/Z0bYIdGdy5/AR2LzAv4vKtDyAn/BmIJkePyNCB9Vuci0kZMemCViHJptiQjvep6/pTIQ4hRatsFpcQ9jBqKS68kBrpkOCnSyAUm1u3TiPlKyHUjMn3iKUT6XK1474g4/VTORte92L2q49NAKK66aAt/h2BTstrbhy4pw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 06:41:07.0877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d97b5f01-2d2b-4485-67a2-08dedb298ef9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2NSBTYWx0ZWRfX3yWh/W1AsyuD
 NrFZHffgjbatNHojokl/K9xRkWRoSijaNYKVuh+4iVU44ypx7PALfJjvXP508hfjCDD3OuPJDZo
 chwgB3WNrGmeuIwozO2eIYCrozAK4dVolrcl0u++2DbmZ1bUeAr48f/w0hqDYVX416Ny5Q7PSsK
 A8Ih7VLWdvlK2IJrJU54yalTEchxTZv2ja2pKpvq4Ilx+MTJlNujSUlKhL5Rxjkvv/OGoTwxP8V
 PU12mXWaXDZ1QuwjWjSbvHN/8iwOqb8cQ0GmffM/DIlBG/TPJBtORYhBH6URqpVw1//+GPeVDos
 vsqe3Gy0T6d/NTqbyuFEMchu+WGkKWqnhsH+xhM+jAEGRldjfa+iKasT5E5SraHO14J7Eaoch8z
 8MurQVLkJAd/2onslfMhnp1f5fIummyPGVTL5PvYcl1+46u0/CKYK2kywoW9x0BgJUjAb0A/VXh
 EXLiAOdOlhK8SSIjjDw==
X-Proofpoint-GUID: gbQcV3ZXVqoMDtNf9F1xRG4YWu02e2zo
X-Authority-Analysis: v=2.4 cv=Ksh9H2WN c=1 sm=1 tr=0 ts=6a4b4e07 cx=c_pps
 a=FzHw5hv2FvkecWl+Aalm1A==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=sozttTNsAAAA:8
 a=mHYEv6QFmMjDamXG3QIA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: gbQcV3ZXVqoMDtNf9F1xRG4YWu02e2zo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2NSBTYWx0ZWRfX9+5eNIXF7IOS
 gm+NWDlT3MoMUY2ITYHn7LZiYLjhgyaeT1ZAU+jXUPbxmDxaVO4IBEdenY1oArKELcsRUHcCpQS
 T/6jsOL2BwrkpvkU7VHgMjJYitvR14w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060065
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

Hi,

On 7/1/26 , Paresh Bhagat wrote:
> This series adds support for DM firmware reserved memory fixup in device
> tree for K3 SoCs that use separate DM firmware (K3_DM_FW enabled).
> 
> The series includes:
> 1. Fix for phandle corruption in FDT reserved memory fixup
> 2. Enable OF_SYSTEM_SETUP for AM62D2 to allow device tree fixups
> 3. Add Kconfig options for DM firmware reserved memory for other K3 SoCs
> 4. Add DM reserved memory fixup implementation
> 
> The main issue being addressed is that the current reserved DDR carveout
> for DM firmware in device tree is insufficient to accommodate the DM
> firmware binary on AM62A7, and potentially other K3 SoCs in the future.
> 
> Currently, the size is only modified for AM62A7 SoC. For rest of SocS
> existing values from device tree is taken.
> 
> For vendor boards, please verify boot and check for errors if any.
> 
> This series depends on dts update for effected devices. If "dm" node is
> not found then the existing mechanism creates a new node with same
> address, which cause memory overlap issue.
> 

This patch series conflicts with
https://lore.kernel.org/all/20260701-topic-am62a-ioddr-dt-v6-19-v7-0-e9db8b16821a@baylibre.com/
Above also includes fixes for incorrect reserved memory and new layout.
So do not merge this series. I will send a new version if required when above is merged.

Thanks,
Paresh

> https://lore.kernel.org/all/20260630150919.457160-1-p-bhagat@ti.com/
> 
> Change log v1->v2:
> - Extended DM firmware reserved memory Kconfig support from AM62A7 only
>   to other K3 SoCs.
> - Added memory configuration for all K3 SoCs
> - Update fdt_fixup_reserved_memory() to remove redundant code.
> 
> v1
> https://lore.kernel.org/all/178219072988.1099376.16053199642199625548.b4-review@b4/
> 
> Paresh Bhagat (4):
>   arm: mach-k3: Fix phandle corruption in fdt fixup
>   arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
>   arm: mack-k3: Kconfig: Add DM firmware reserved memory configs
>   arm: mach-k3: Add DM reserved memory fixup
> 
>  arch/arm/mach-k3/Kconfig        | 21 ++++++++++++++
>  arch/arm/mach-k3/am62ax/Kconfig |  1 +
>  arch/arm/mach-k3/common_fdt.c   | 51 ++++++++++++++++-----------------
>  3 files changed, 46 insertions(+), 27 deletions(-)
> 
> -- 
> 2.34.1
> 
> 
