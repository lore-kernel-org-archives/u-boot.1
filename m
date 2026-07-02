Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253AFC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 15:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A36E6841F2;
	Thu,  2 Jul 2026 17:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jYyqaWN8";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="T8XbODOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44E2C84867; Thu,  2 Jul 2026 17:13:34 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85848407E
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 17:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 662E1Q2B2612341;
 Thu, 2 Jul 2026 10:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8j9s8ILqDhrCAkBywwdsTVDHpXzIn53ql2E/5WLgA
 as=; b=jYyqaWN8nKRPZlru1ah8lV4kYDr861Agq/GEcZmXBfY/YDUfitH45GhKI
 HPQdUQhkRPqK1IDkiiHIQOZBuEbfiHrUIsY3RiVviJ/XcVmFfY4/NLpthK2U8i5w
 yn3hGczHyd7Us3yG8neobC9G0PYeRvYvx0XeyXYxkWqbsGW3kT/EbI0QkdO4G6IN
 FL56o5qiOO+os3Z+pU3UN1P173v2ogxHCwUVaBKWJByWzynlpf+BgaStp3Q/qNpJ
 zL66T+ORf9enUbfnhgT41wHOSYOjPw4/XcDtyZ6EVvWjbAy2KNXUnlR9qHPNDlHq
 tHC7o1MXFsbJ0xEC9bTapyVhcFb3A==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010023.outbound.protection.outlook.com
 [52.101.193.23])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f5mn5a4db-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 10:13:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvOJkki3R4bgXxAnPcCqgj3My866yl18aCFOmM1RVn+9RAPRA2oZlnizAtwRirEdBJat7dAM6kvpOIPfnn0IY3vfOeUTpa2sxZdO8ntlMDa6jRDUfED27ktcB2PfzXmec2VbfGwnSYumPOS3HawEVPTJzXK584BlTR6sPlfa3EmKKUdy1Oj1F7JpabUt6KyBNQxMBD0MjV78MvCM56rcGTSwmkQcrVjsyXQZK5MPCTZYgIJNDDos3patzumIMyEeYMWW8pC0Y08kfOgAxAJMAWA6rsEE6jFkbHBUW1jBqkvf8dRBIACVmt8HFVSZybgiQWDXYuNmt8KsambLdxmfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j9s8ILqDhrCAkBywwdsTVDHpXzIn53ql2E/5WLgAas=;
 b=AmXoiQMspWj+ITnGV5QF6Vg2NLpX0mi15KeiLR1CcQUmmqTI1aSKdeUnUajNv1l+MPY1+9A729LDwpc2xQ025XoJ1JxjmL91ushu18vIEIL738Jn6kbRA2gvA47jFuLeqQ5gdsp7zfyMsXJ2dak7sYLheg4HvhBbiiZhjCQsh3DN6k4AeMxfILJp6DhRbtaYnDfigoX8C+OJd8flmUmW+TlDgnwM81B1hqC/iH43SyyO/1K7ampkCqjqJqu9Rx0cMCjZNTKetmpOs/vUVXulBYwJnztmtT2NxkBjzVcmFcAk6l2gqRFfFB1WEJ6HXCzKrnTNMvf0a30gjEd/JEXuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j9s8ILqDhrCAkBywwdsTVDHpXzIn53ql2E/5WLgAas=;
 b=T8XbODOhfJ12n63XcoXvRRvuC9tEZf0jBBWHSuBwVAW1RL4gcCKfh//qi/ulkko+BkSQdTVR/bSYRXEoij4nBRV4SuCWySRiJiSEcFRxLGFd/ZYxAlk5coR4EBAzTt93IU/Zjn8MqntrU685PJA2LQ5hPmN9HoaZFxGZUoJijSk=
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by IA1PR10MB7336.namprd10.prod.outlook.com (2603:10b6:208:3ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 15:13:23 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::1b) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 2
 Jul 2026 15:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 15:13:22 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 10:13:19 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 10:13:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 10:13:19 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 662FDIKp3663234;
 Thu, 2 Jul 2026 10:13:18 -0500
Message-ID: <8c45ccd2-f32b-45cc-951c-edf1a7827d0a@ti.com>
Date: Thu, 2 Jul 2026 10:13:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm: mach-k3: Fix phandle corruption in fdt fixup
To: Paresh Bhagat <p-bhagat@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
 <20260701075021.3626094-2-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260701075021.3626094-2-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|IA1PR10MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: cec91505-7855-4ab6-39f3-08ded84c752c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CiTw8hAI5tj0Fzd/+DF2bo2xTanzBi6YfAcidytypucRU/UKBTdzzMLqZrVt3ZkD4KZkUC6X8E1fi6eOU4bChu10p4pTwPdRPrOPQmm1TQX++tEAow6NolEj3t+laBuuTeFXdDFV4TDmKaAQ3X3q6uev4WZHMje1QqWQygdSZ4ft4F8PCtQpQbJ2XA13Idnwk45vgUlCAT8zgyRm08mjmcVu4uL1vEhdNcO2nRewZcQ0/wDo65RUBnf+OM12JrHeu7Kn2mTmKWoe7GTbd0YrFVuRE/0tvEA3OZPM7AnIyL3GNb9T+Xv4pHAxHTLYgErzndX/tT+dfZfJxS1TqoVDmQgHyS2XXXVhcLWwFD62l/OP7hNitIlEsAs7JlrTdag9zrNbG/M9EMZQEQmofF/yEok7CI/x2bbS3Ihx/1JtTLvLozN3J6jrFCOPhov9OhyrjpYfZVYNjzByhFsOLeO6hmtaXP6t48THKQXfDU6d5yeWlj2/xkomx8miokVCg5QNwzPr5m7yAEG6RhF6uzTaZ780HE7jEeDC2AK1QM9UZf7QMCW2B1OcBjebNHgLyEhPERVUn1ybAOVvMFL91NxHmGwExwXJDbEh3dKeeE450+RC5tbsh4eb8R791aSucphPVVWr/lDy251dSmQTPWeqRnjU3/gQMaKo5NuuTSN4EguhFuJgfL8vkL/9fHTbkoEja29rI89cK5zUudJcD/DhPg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dvAA8YRovwKQ8hXA1T8zdqoKGqRjIFfrKI4aR4hVs7uYdCBiKAi7uQBZdY4TXazGSLPZgn5DInmQ+GAuQxPqrvn1m7uoGp0m5WKAafMRiqN/ImHQwRUVq9fI3QWz3hFpIQhAq+mfdYUtDBWktiO9OZXFid/vUSuQJg0Up9ciN11ap3e0ZIlpIAb8447elpmvm4t0QkNbFvOfxHKh4bpboD8FO4PvVl2pyweYC5fd/p1n66oYnHI9Er8t1JiZgKs4cnM2TvrQaNGToDQ6BeiVmxmfIXaQQgw5M2vFWlrdq4YmWexkh2bjAauiV/4e5xJbh0TRnSB57oln4IbrTPyO0ouJ0+3pQBgvoZ0I6AtypUzJfVV81Fb/INMTYWNadRRmPtPsL5mUzasxbHgsfE+OW3a9qiBCORLqxqHzKXue+fKeMCfV5OzwEvLNBEXAQIgs
X-Exchange-RoutingPolicyChecked: Bzy3YYmZQ86eEhmNqwBHRkG0RePB6pTuGzmLN7/4nWzuYJOHMdXlbbh82SgBFodvnPT+QUI8auOxyvPDoSGidts/zbUXsgEq07vk2nTVOqeNQPp/E6y3hP+FZyoD2rvnO39HajssOwn1GMsdutllxtUeHC73HDlgKrb7quUX8QL9+NKeXqjTQeUSiI41/ZqAuPjmrdYTkSMqel+aa+UDgnGKuW2+fwz3frlFesa3FMF27HmDbYjhnOS54bjMLOb3OsESusQHMdVzgn+NchtkMcZBaiIxrwZ35AHCSlFGhstNVinILmkX0zntjRbSHF7VIUngSYFIeinCN/uRlbskTg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 15:13:22.7471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec91505-7855-4ab6-39f3-08ded84c752c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7336
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE1OSBTYWx0ZWRfX45F29K3ol44+
 csen/QLXA9usDTxWgAbZmf592tWplVdvLlIyOkTYNvwsKd7PMlHYYYURkL5FD+Xb+5L98HhBLFl
 ZdEqtMNCPu+vxg4hsxI6YM1U9MH6Y/rBDZ516v7SbJfryxyg9c5ZradbtbpBCRf2uSLCEYs0R9P
 /+/7N2jgPj3egXVNRsnIhQiS/jWkJPiaLheml4PofxckkZzHVz/j6f9cqwa773iFteQPeI1JP8U
 RvkeH5nat6HbaDB84JlFJFROZYtQZntA5IWknBrnhdHYXz5H5wk7dpeoen498+FZixIOeY65qDE
 Oozkv/R2V3i5V9Bd2QpiYH2is9b7Z2Jz0KL5IKG/QgfxLKlAouhmgfvBeKJedKqGQFeJWQp4fpM
 by1y9F2uhbjN62MEBSz9byVscgGP+yWq588d5xna0uu/Q2o2D/hh+1Lzvq1d/2v1DCstOFP0QMh
 gmLHBTUUGFC6vSL6fSw==
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a468017 cx=c_pps
 a=ubRrNrA1i3DLWGMHTGxaeQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=tl4KMOLoBlq8R2gxGJYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE1OSBTYWx0ZWRfX65fNS7z6mKcA
 ZMqZTSd1FJxpCFJ1Frd45/7UNCgDo0zjjYz9i/1ftONUMbNvKd269up7eh38Tj+5yDq4/qNyp0Y
 zvbB+bppz9isQ7wIavbzp4Nmyr2oRXQ=
X-Proofpoint-GUID: dqvC0VdLGj_iNFfUfdXsNNjc1WctXnUn
X-Proofpoint-ORIG-GUID: dqvC0VdLGj_iNFfUfdXsNNjc1WctXnUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020159
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

On 7/1/26 2:50 AM, Paresh Bhagat wrote:
> Fix phandle corruption in fdt_fixup_reserved_memory()
> 
> The original implementation used a delete/recreate approach:
> - Find existing reserved memory node (e.g. tfa@80000000)
> - Delete the entire node with fdt_del_node()
> - Create new node with fdtdec_add_reserved_memory()
> 
> This worked fine for ATF and OPTEE nodes because no other device tree
> nodes reference them via phandles but other nodes example DM are
> referenced by R5 nodes.
> 
> If these nodes are deleted and recreated, it will not have any phandle
> property but the nodes referencing it will still contain the old
> phandle, causing initialization to fail.
> 
> Update nodes in-place instead of delete/recreate to update only the
> "reg" property using fdt_setprop().
> 
> Fixes: 8b0fc29de0e3 ("arm: mach-k3: am62: Fixup TF-A/OP-TEE reserved-memory node in FDT")
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>   arch/arm/mach-k3/common_fdt.c | 31 +++++++------------------------
>   1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index 39cb00c3f43..4b833f5fabe 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -119,7 +119,6 @@ static int fdt_fixup_reserved_memory(void *blob, const char *name,
>   				     unsigned int new_size)
>   {
>   	int nodeoffset, subnode;
> -	int ret;
>   	struct fdt_memory carveout = {
>   		.start = new_address,
>   	};
> @@ -129,43 +128,27 @@ static int fdt_fixup_reserved_memory(void *blob, const char *name,
>   	if (nodeoffset < 0)
>   		goto add_carveout;
>   
> -	/* Find existing matching subnode and remove it */
> +	/* Find existing matching subnode and update it in place */
>   	fdt_for_each_subnode(subnode, blob, nodeoffset) {
>   		const char *node_name;
> -		fdt_addr_t addr;
> -		fdt_size_t size;
> +		u64 reg[2];
>   
>   		/* Name matching */
>   		node_name = fdt_get_name(blob, subnode, NULL);
>   		if (!name)
>   			return -EINVAL;
>   		if (!strncmp(node_name, name, strlen(name))) {
> -			/* Read out old size first */
> -			addr = fdtdec_get_addr_size_auto_parent(
> -				blob, nodeoffset, subnode, "reg", 0, &size,
> -				false);
> -			if (addr == FDT_ADDR_T_NONE)
> -				return -EINVAL;
> -			new_size = size;
> -
> -			/* Delete node */
> -			ret = fdt_del_node(blob, subnode);
> -			if (ret < 0)
> -				return ret;
> -
> -			/* Only one matching node */
> -			break;
> +			/* Update the reg property in place */
> +			reg[0] = cpu_to_fdt64(new_address);
> +			reg[1] = cpu_to_fdt64(new_size);
> +			return fdt_setprop(blob, subnode, "reg", reg, sizeof(reg));

Note that this only updates the `reg` property, not the node name itself
which will still include the old @address. Not that it really matters though,
I'm just trying to remember why I used a delete/recreate approach here in
the first place.

This also assumes address and size cells are always 64bit (which should
always be the case, but might be good to check).

Acked-by: Andrew Davis <afd@ti.com>

>   		}
>   	}
>   
>   add_carveout:
>   	carveout.end = new_address + new_size - 1;
> -	ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
> +	return fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
>   					 FDTDEC_RESERVED_MEMORY_NO_MAP);
> -	if (ret < 0)
> -		return ret;
> -
> -	return 0;
>   }
>   
>   int fdt_fixup_reserved(void *blob)

