Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA7FC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 18:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F55E847C8;
	Thu,  2 Jul 2026 20:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SNZost2o";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EcpWAzaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94DD6848DC; Thu,  2 Jul 2026 20:12:20 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC6784119
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 20:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662E1ZbR2616589; Thu, 2 Jul 2026 13:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Df7Wkcxz7/JcPUu81wWwUD/qPZHns3243zf5eg5/4
 5I=; b=SNZost2ouJu4Ra8bghaLW5Kk+2YCoT5NIp1ltRAyuxyS4iry8Ab4YffC0
 B2d6+GNxTIPmRZXTMLmqad7qaz6GLCEE3S/iJ5Igt9+EZvlnqTsV4SvnEnz6OZ4D
 xqGgEXrboF/juyfNn2145TTTox+IQQj57JwC58tHcwlVLeGSBkMUIqoDD5yntXU7
 zbXod3QOgEw9WFy9p0vUEky/IQQYnMBWs0nAnPZEbak6jDocz6cNwyRA3rNs4pMR
 9twlKsAZeTLftMoLIQFDctraYGY+z+5cd1+tZ3mYrRTyLRmi24Xy4LNh+YguSN8+
 Xsqs1ucHeF4IVrxvqViNEmwaxAW8g==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f5n23k1b7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 13:12:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsJSL+rlaugvHd3QBMtz8tbMMZhWRJRXTAECw1NGWoxARfNiBfZdVsjtmm6nEdrGWzVS6DSbYna+NS6wqhgvkJ/j4n3mCeCqCQuSnqekrwfndMJeW56Ocf2KUVrh85o5nJqfl3g3dn0xgeViod9fB8t5VtRD+4HsPigMxscNiXH43H/jz9GGd2id8laGgQFN4aZl6nysxG3ofroFaxgzGAdC2gr7JPeo/SOrTayKA1xp74OedsmerUCZ3HjXDtX4P6/VsuaMdDoNvywbxQOeuhcUN3m8ks71s6kUBjXK/UN47wUqMLib4NnqAYckitagmSttis3bIZXzYeGFmXTDOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df7Wkcxz7/JcPUu81wWwUD/qPZHns3243zf5eg5/45I=;
 b=n7MhZUWmMgc1iMtTmrZZggLxEMCZbgY+4YAHva5uot0RmQjCTd50IyfnVmhC5bblcw5p2sSAPCkiCKEEeHtqbCo1+NUz5p3KE4BKtgmbnKxrYC8D6m25f4LUrOeCQJdck3hTAWHywh4qCnCl7lDOY1UZb76qcNnd72kBqK6gQNw+hF2hdDvmM2MXdqBaDlFH23/IFhS5qy5i9qTGovNcimmOEpVsVZ6lWVpfp5YsyVBEkU6AHlM+bs/Fvmmr3Q7Tr5f7Mrn8n7FYiwn0suyKKmU3TZlF/emqQJBWNiPo9+0FgjXLVssxKaY3sxO2xyxHCkxVAvr+43bgdAdGOmCB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df7Wkcxz7/JcPUu81wWwUD/qPZHns3243zf5eg5/45I=;
 b=EcpWAzawyPMLnLm+EeLheD7KtXSrQXxKv2QJjAqo3QMF7mReAn6qLYt4ajqBfTAxKucinD+S6sRmYJ7N0cpaU2HLA6lvUWpe+dxqFCnQAnDsDGd+Os0izaHxkGJ7R3xtN5tA4YXVCDHu1s8HDo0sGyK1dqVHiqUmHekPwveW7F4=
Received: from BN8PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:d4::37)
 by EAYPR10MB997903.namprd10.prod.outlook.com (2603:10b6:303:2d9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 18:12:11 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::3e) by BN8PR04CA0063.outlook.office365.com
 (2603:10b6:408:d4::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Thu, 2
 Jul 2026 18:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 18:12:09 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 13:12:08 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 13:12:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 13:12:08 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 662IC7oQ428041;
 Thu, 2 Jul 2026 13:12:07 -0500
Message-ID: <7794bc90-b69c-48bc-a2a8-2ecdf8ae1459@ti.com>
Date: Thu, 2 Jul 2026 13:12:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm: mack-k3: Kconfig: Add DM firmware reserved
 memory configs
To: Paresh Bhagat <p-bhagat@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
 <20260701075021.3626094-4-p-bhagat@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260701075021.3626094-4-p-bhagat@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|EAYPR10MB997903:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc3be55-b113-4e67-35a5-08ded8656eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: yxg0fEpyvuW6OeCdRXCU/criZn++QUXsWIultcIQeNc/KU13SMuHq8hJZTQ2cH7T9r6viB/qXey2kKN8fmm7mxHIwz8MX77R+p1r7RpQ0SdnuzJLjENjh3BhC35TQKE4UjS8UDRBHYUT5iGE15t8TxsBsjfVXCM+NZA9JNYdk6oABRetwZUAyCOGSwPMHQQAAZ29sj3IMpLg7NxatD0NKFiLHKo1zVfbiJPhhnWsuSCkflOKCcbaLC9KsF+aqTM6Jv4MGZbfhNs7Tig+210GNWeDRj8YkUd/71/9dQMthmSqQK9opGS3eWjBON3brbyr0gNCkpXJ6L+LnD7aFS0m/CXtAD3L3Ylc0yU643xFTWP1rc6DHFj5rE7F5leCb9NmwrIt/9Nnu4pbP+/DL3+pn/e6IuZZHU0lzo7dyC3k53XTkDp5V2g2SodpBsHq5sSLh537uoMi+pYj+bSYxniqMUcECIXozhnQZTvF3uhJNRS5NZFpM9HkPudDPf1XxOarpG6wKSEA7ZWbsGgYt4NhXAUhJbBnO1KqEe7wW+3fPg1J1GTKTDJK+9iB/nvhTv52ckbizGaVUagobSx2EnEbkFfE3y3z9fxN97yqlapac7rEaVvHtBUDgP5mFztc7BvvU5bID95QFzZ2S9bKtTMxY4An8q+374mKJ6fDAA0/aMd8Kh39Wyt+PAW2jKYUA//KBaY0WBkqQYn4xyjOsVxGpw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zpshcSKvLhqDVHDbDR44XqK/VrSXwoCSyiC7irr/pp5mNQfbX6HYVyoroaKKIiEfl7me/om2zhXjRvyx8nY89kwxeslD8GlrEV/ZSEcnUrtwcskrj5Qr4bTUulhj5oMyhd4dE/hY+hGMnnNFpcEZt1OXdQjGe4+CzT9V67So+eEmeZO6K/+nDzIpFmZk9lnvGeEtDcdmn2+t4z7MwUxJ+fGvdfWGSgtjGV1chS3jGVlUFdj2murn+xc/GwWcH1zFmCD8r3LgucwmYk+XceuwiZZKrJNeAT/Pv2kuoSNSmxig6VWszWGyQu53hOpux5tPP/az+FoGQI2cLO+hfi+olz4rGzsRzOLfXvghkxHdvZOmlKAH+LrnzJ+a1sHqn9qzEgCc1QXDqABu0Ze+SYn6cLPwLxxfoDTLiguGyFjIqDyXMspMbT5OQZ4op3/q+j9N
X-Exchange-RoutingPolicyChecked: MrPtwywX815gog3/3x/TylGZP8piCu2L3mj9j078iGEOkM59NQmu9ka0EblVfhtmjuIvbqw7Q870sDXcQVXBDQGabjxPsPpkINidZkaMZ5StAF+OonWGyUxMKSyiEHIzalp31CqZwiRT3MSAXT4+AKss0mcXYG+P7VPifALB7Ew56fBmeXhfWRihpQhrE/jQL7jG/CIPiFX7cEsWO9olK7WdVdfaICLRGOFX5B9Ckl6s7ktSTRZMAS/t2gkhFfZ+x7dCY73jFQaDw+PYfEAWbFn8dUSarTD2hdAn8m8ueX5Vn6pXrgFH3kGzPcvR3B8DLmgPhL1ZfqaHIw5jgkOxKA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 18:12:09.2364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc3be55-b113-4e67-35a5-08ded8656eb0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997903
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfX8KkGf6CXtHoz
 yna6bsAQ2l3GTw5/KndPejhmYEse9KVsDuaABZ1jT6NjT0UakXvfgTR3s0d+211SH41yDsSSG1D
 oHnSjOcEJNdz+1oYeyFlzcONtSjZ/Gk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE5MSBTYWx0ZWRfXxpLo6V42SPK9
 X+rNtCp2kRFeVaLO9Brounmvg5yLVZxeynsOXbtxkr4klRIIen9OJHlaTh+KJKyn+XjOKKBR11f
 lqkhalItiT+BjMv3pTV38xF+X4hwtRdgsE4bJERJTLXMawTHiUSsLx+RIpJYNror+o7ITLW1QG7
 imzkVNbZvIGpor1R2sBllkoUyTRWZ08erGE3GduyGIwYv60C72lu76Gw7VhGpZppHtWNLrX10dZ
 Rl1gq+ElqLZ+cmnPf3M0m6fMscQ0tLzSB1j8Cd/tsFPX46SVNYTgY3evY5FOtM4OKDTyhIKxBYN
 ILLDu71kpSsNz381ZJIaj51tJx3zfqzcKenjI0YHpxarkCSNmgPKfAmuLdVedSc55Dd0Wfp9zst
 Zv1eqYM2c72zGaCMu6gypFNbdJbKK97tRDVCZvnkgCdxG3/SNTEda7EhkaUplatAgNfC7xDPirY
 PUqZYZCNHuboyKkrapw==
X-Authority-Analysis: v=2.4 cv=DN+/JSNb c=1 sm=1 tr=0 ts=6a46a9fe cx=c_pps
 a=TO2QspbEOyvqwnNCDF3LgQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=VhMiTxj5-9LbvGCAB2QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 4m1vcXGPNjbidfSHmyAMLlsATdynm91Y
X-Proofpoint-ORIG-GUID: 4m1vcXGPNjbidfSHmyAMLlsATdynm91Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020191
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
> Add Kconfig options for DM firmware reserved memory for K3 SOCs that
> support DM firmware (K3_DM_FW enabled)
> - K3_DM_FW_RESERVED_ADDR: DM firmware address
> - K3_DM_FW_RESERVED_SIZE: DM firmware reserved size
> 
> These configs will be used to fixup the kernel device tree's reserved
> memory node for DM. Currently the fixup is only done for AM62A7 SoC, as
> K3_DM_FW_RESERVED_SIZE is being used to update DM reserved memory from
> 0xf0000 to 0x1f0000 as the current reserved carveout is insufficient to
> accommodate the binary.
> 
> For other platforms, the addresses and sizes are based on the existing
> device tree reserved memory. If needed for other SoCs, address and size
> could be modified in Kconfig.
> 
> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> ---
>   arch/arm/mach-k3/Kconfig | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index a32ed3a9683..1b6678e72b7 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -165,6 +165,27 @@ config K3_DM_FW
>   	  bootloader, it makes RM and PM services not being available
>   	  during R5 SPL execution time.
>   
> +config K3_DM_FW_RESERVED_ADDR
> +	hex "Start address of DM firmware reserved memory region"
> +	depends on !SOC_K3_AM642 && !SOC_K3_AM654
> +	default 0x9c900000 if SOC_K3_AM62A7 || SOC_K3_AM62P5
> +	default 0x9db00000 if SOC_K3_AM625
> +	default 0xa0100000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_J784S4
> +	help
> +	  Start address of the DDR region reserved for DM firmware at runtime.
> +	  Used only to fixup the kernel device-tree reserved-memory node.
> +
> +config K3_DM_FW_RESERVED_SIZE
> +	hex "Reserved memory size for DM firmware"
> +	depends on !SOC_K3_AM642 && !SOC_K3_AM654
> +	default 0x1f00000 if SOC_K3_AM62A7
> +	default 0xc00000 if SOC_K3_AM625
> +	default 0x1e00000 if TARGET_VERDIN_AM62P_A53 || TARGET_VERDIN_AM62P_R5

Why is this one board different from the rest of the AM62P boards? I doubt
the folks at Toradex have make a custom DM firmware, guessing they are just
the first to notice our default DM firmware goes outside the current reserved
memory size. This size likely needs to be made common for all AM62P.

Andrew

> +	default 0xf00000 if SOC_K3_AM62P5 || SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_J784S4
> +	help
> +	  The runtime memory size reserved for DM firmware. This is the total
> +	  DDR span needed for the DM firmware binary.
> +
>   config K3_X509_SWRV
>   	int "SWRV for X509 certificate used for boot images"
>   	default 1

