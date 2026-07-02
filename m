Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80A6C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324E484A73;
	Thu,  2 Jul 2026 16:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Kzv7Mrue";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FU98plMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5503784A7B; Thu,  2 Jul 2026 16:57:34 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FA884A57
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662E1tFr2618134; Thu, 2 Jul 2026 09:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=7h6OwFXiTO9QFoKFINrdgFU4/cObdWuKiuCQoBgOf
 ys=; b=Kzv7MrueYGMl9O0xIPMo5f8tFeX5soGnBEEgX6nCa0uNFwuRYsI7bqjCc
 gmd1tak99Gz+Hv1qKQYb5KDeuS8oQsUIQMwcNyHBK7D3ARNAs8M9Smh0pe6Jo7CT
 icNjNlgbnzQS5ksDO4hTH1E67QHxe0rFZWEkf+eEA5G6IP/SLIcMZaaVZaVq/LuD
 JD2UloOspNYoodkhvJngAlFpYj/y4wqUu6z3Ld3+Pf5Ata5UHcPkkta2pE3vbQt4
 Ly1R/XJIej55NUNxiXt2g+4TLW6X++wVSiYIxSTI4YRoao29P2X+8sf3Ar3E9TuM
 QsLc1o7QGYf+GqfiDzhoU13cAn0+A==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f5fvykjph-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 09:57:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jlkgs8WdNTGSrmtAzNqTKcqUtsScz8rRJU4ksVfny0zJVgRf72FZ865Sk8/DWjly2UPyamzdbtcifNMH+yAuN1xQjXMUCJLX0OWMQaON2KvZXfYlaLeSIMNOQEEY6QTWfeCwW6zHyh26HqrA8PVTEeJPEgqwey5xntqTLC1E2KpVrKieuK/jsKUfIkkjAHH2U8+buN+4w006OLZPSZpntqrB1OaOTzXInNefjdOn/4s7xeVEXjQFxMzPTDhwnV5DWORwoVtUobnyKuoD8WzJQMEnLrpGRpaf1pQTd+cM9Kn1Kq7aGL78eeYs15F6GH3ZNx5jz0aLyKvv0WSkHPWeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7h6OwFXiTO9QFoKFINrdgFU4/cObdWuKiuCQoBgOfys=;
 b=M4iUAB26SqYoorGrnB7CHYbmHWeRQc4vUpeTjSdejcx8nbajLpMah8cuDp998YpGXyoU6EeK6mKb9Pp3wUFZmuTfTGx9SEeucTAbQLFaNmbhRU++sjtXPxDMBN8DYff+qF9jSmPNvrjrkZPqli9YO5tS06rk4i97butBA1y6dhXJ5YWqJ7aH99hXGdCzlaAQFGjnbz0iQ8tcr2DKzbdWSBn/iYRzr9DkK5520ODloJJOjBjMxotoxzqMybvj+ynvfenYDPDEmhK1pjQnKlyg4gyCB4fYpW/JoQPCtYdaNM559VXkpT7NtDbJzSYi9+X15fStD3/GVw8L4sDVlnKzsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h6OwFXiTO9QFoKFINrdgFU4/cObdWuKiuCQoBgOfys=;
 b=FU98plMz2vSpw1RAXS+bFNXoR0Cm3cPNPBJiXq/tGgtsy5fT8TTEbHZfEVkFqhcurbd8R6Ip7WXpp4mVstBNAuon68er3PcQwwYwYmQ4OBbCBAzmO2lDypzj6g9GXbDZi1M8yRL32AzSOEvocg2T3YfPERP62vo2tym1in4uUFY=
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by PH9PR10MB636474.namprd10.prod.outlook.com (2603:10b6:510:3eb::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Thu, 2 Jul
 2026 14:57:26 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::94) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 14:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 14:57:25 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 09:57:24 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 09:57:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 09:57:24 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 662EvOHo3635505;
 Thu, 2 Jul 2026 09:57:24 -0500
Message-ID: <c5aee6bb-7212-4751-874b-6d3f5e35cb76@ti.com>
Date: Thu, 2 Jul 2026 09:57:24 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] configs: am62ax_evm_r5_ethboot: Enable config options
 required for Ethernet boot
To: Chintan Vankar <c-vankar@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20260702081251.2691159-1-c-vankar@ti.com>
 <20260702081251.2691159-2-c-vankar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260702081251.2691159-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|PH9PR10MB636474:EE_
X-MS-Office365-Filtering-Correlation-Id: e55dc9bc-647c-4dbe-da0e-08ded84a3ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: GsMGMlQkCQkabzoujstYMt/VMZDC/0vb1YRzHcCiprCZFxXcLMJ+D+BXqBs57/PaGZkpK4FJr1R9GB+EbpgENVrF9TyO2Qxpl6fdyCCGv9fFVccmw3KbnAwEdlDpy56VXOmrsdFkYANYCeWFJ+3mnMGxLlUuf5yqajURO6+Eh/xrHwoRROk0Coo1OtWZbyC/UsTyGSCAuxlH1BECpELCL1UJi/e8YvN88YKEGbE4x+zgCXoQTkJJatMYrY4mpmr7fO/f/HY5PvpRoKjAiU1psQi4AGQYJwzZl56u26vYTtKoP+IqkHwdO3DoNF3+jDfgQPpxVj5WrBebEjXAKF6dQcOtBl/22rwxk2+prk9c4PxBThdaBJa0ijIFpLLzbea8c9NgMDKTtgSr1uA43eQ+mo7Ls0VsdH0JTXrL8kkzpY4edmx9S2NnHpneMSpDBW2sY3lfIpgvQnC4aXoGdhziynnz3yDkox4KGOqWSwhDbxZveQSoiWhowSNiOx8CXZWpiXHsF+N2KQKISl+/R0m9v2IsIrZfNjjBWbjN6uu2eLWE9BjFT0RjhwWajzNo/Yky76ePQIlQVNoxpXjPOZ4VRk7vbhpphmMdTGvANXZ0Tk35YhfW2B0sHQWLKI5XViJit81Eo2+m+byfdg8IvGjRGlUehwJ6eomi6/V/hDyfzBHEtK8x7hiKDLWVqjUUOINY
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uxr1wx1mnU6aY5a1ulYF6a4qJtG73xPGWkxBIL2/ZaqBSWfGGkEkDr+IvGImm2dFJGHW8lfvqRFZAL/RCwC9XK1oGM4wKoVoa95DjJLulKbD7F59s5R/PxxqZUlOQaDbDS+zf/rwigjLxjCIjOHbWMsWayL2GoCrV4yk37Ff/SX9jOlxYGZRjqNCVvcGPcsGTIQ4NFfU0IrYA2zzEztiQg/EahD9U0w5FDOxH/RhVJT9z8a9HDtMytoOwmlKyKvWUyGQ19OmbajflHV4hrzX23sDFt8U6eOP5nktvzDnZHmnc/GVgYX4AxgFRu605QSyTPAsqqLdoNl2XSERv2hXimjDRSfmQ0w2g6+YAfvAIsVsu8S1QcDR7j8gvf6A/vMxzrddhYrfp7PJE1O1EeiNdQT0CwDifOgVhXIfuVwmI7646FRa/tAyD/UvWGhmhYz7
X-Exchange-RoutingPolicyChecked: UqbsoSiFV9liW5He8NE517U9VLwo3tT7bv5mf/PmNYfO+D+qikodvGabpppCZRUrCvgiJcMT+TxPY2MrpRlXYV//pFbfsKI/8tNCT7DIEDvYl3GsQtzBh/RvnTulMGfF/2w/hYhYZ3VmkrCwvR/MQorAOlQv8lv2htWHbbCrJgqsI8LdzXOsqWZuDfSwUwZ/T1ABIr5kFMlbjJQRSGhVwoObCc3oY0hc4naPbJnEdjL+BVkIGQHGl7YB2Or7OeZ2NcezNzQnZBrTxlnfs0TbkAvkly184LapWl9bJtDR5mwpZmg4LzitrMziMPm2cGY5ZKC+vGN7E9zs/x8aPkGMHg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:57:25.9517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e55dc9bc-647c-4dbe-da0e-08ded84a3ae5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR10MB636474
X-Proofpoint-ORIG-GUID: 4tOuEcuqRbmPOMXy9Ml7Se9jo286QRTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE1NiBTYWx0ZWRfX1ts0NAbWJ61O
 8WX/8FxF9q0/guBLSUQV5tyKbqLjZCUvj+Q+ysMbUZRi4WqOFwpcF3Ore6q6BRhdC0awZLQgfie
 Wp2VmE3COCcJtU4k6511bKpvvONoW2+ATlO7QUng3oe8Vy2OA4wurQ0ii2nscpIkYniSpPgTNU8
 NU33YV8txSHO1Pdet4Tkq9TeP4e3RvtGhIJNW2rwWcAu1r/YEL1F3pDqrSQYDwfa+hWqmH7v9X5
 VPWWpxmnQCOXMHZnh8wqBaxOX+drJxPuSvEz+RZOPHE3FmxhrtrH03Jz9YsxIr7tCc5zekRe2r4
 J2KzH+XBw55jFYWqtGaXspixBjc6P+H3vLSivuW0MT4h9idVUp1brI9Ekeus+cAP+KuxtKKg94n
 5ApXm9v8ZoUt0oybylh92ZjP5npGONyAdxfb7KK8Z/5gkEqdrxqVsRDFwpo4tzpZ1QVlhYbzLJA
 xnptB636NnP18HJ58fw==
X-Proofpoint-GUID: 4tOuEcuqRbmPOMXy9Ml7Se9jo286QRTj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE1NiBTYWx0ZWRfX4VkT4aN2ZHxI
 A1m2sx52YusNVsOha2XjFGhpj3AAN8/Ssi5s5nfUE+gsBKyAq+JxOsMHi9HgexfIk0kIKDV7K4X
 i1oixqiMcR60VvZsHn+YMnEcxy2oi/0=
X-Authority-Analysis: v=2.4 cv=T+q8ifKQ c=1 sm=1 tr=0 ts=6a467c58 cx=c_pps
 a=aQYToRbhQZUme44wGBfxuw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=9Ele6bPX2t1uBE1qu1YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020156
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

On 7/2/26 3:12 AM, Chintan Vankar wrote:
> Enable config support to enable Ethernet boot on SK-AM62A-LP for R5 SPL
> stage.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>   configs/am62ax_evm_r5_ethboot_defconfig | 27 +++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
>   create mode 100644 configs/am62ax_evm_r5_ethboot_defconfig
> 
> diff --git a/configs/am62ax_evm_r5_ethboot_defconfig b/configs/am62ax_evm_r5_ethboot_defconfig
> new file mode 100644
> index 00000000000..215084d1490
> --- /dev/null
> +++ b/configs/am62ax_evm_r5_ethboot_defconfig
> @@ -0,0 +1,27 @@
> +#include <configs/am62ax_evm_r5_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_AM62A7=y
> +CONFIG_TARGET_AM62A7_R5_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62a7-r5-sk"

The above 5 config items are already set in the included defconfig,
they can be removed.

There used to be an issue with buildman that caused us to need to
repeat these items so it could detect the arch/board, but that has
been fixed for a while now. I know many other boards still have this
redundancy, and cleaning that up so others stop copying it has been
on my todo list for a while now.. If anyone else (hint Bryan/Anshul)
wants some easy patches feel free.

> +# CONFIG_NO_NET is not set
> +CONFIG_SPL_GPIO=y
> +CONFIG_SPL_MMC=n

So why can't Ethernet boot be supported by the base defconfig? I'm
guessing we don't have the SRAM space at the R5 stage and that is
why we disable MMC boot here. Would be good to put that info in the
commit message.

Andrew

> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x200000
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_ETH=y
> +CONFIG_SPL_I2C=y
> +CONFIG_NET=y
> +CONFIG_SPL_NET=y
> +CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot R5 SPL"
> +CONFIG_CMD_DHCP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_DMA_CHANNELS=y
> +CONFIG_TI_K3_NAVSS_UDMA=y
> +CONFIG_DM_I2C=y
> +CONFIG_PHY_TI_DP83867=y
> +CONFIG_TI_AM65_CPSW_NUSS=y

