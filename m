Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B10EB104A
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 11:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B24583F2A;
	Tue, 10 Mar 2026 12:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yd4wBN2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDEDC83F2A; Tue, 10 Mar 2026 12:10:58 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C0AB83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWIKphMRvxtYf64MUaHNjHDNq+cOX0Cn8Xf0e38WH33gyEMX7Hm1M3iqwVS31yYze8XSJ5Z2QJ5mVJT7/a5H3PRVsmL5dEwGgK4Txc7ni0/QBXxKMBpZuDFRvjZ6w30MmGpj8JJaW3TDFtRorWqYXiatcyoSQUoPnsK+3OdF90QhDyYLHLoAYPgDHU2VtKUOzeF+8hBYYzpJDByFIYN065TWS0rbMka5H5S66SQsxOkVbXXLYo+cyCgxZbolBgw5KvOhTqZ4PTM3jbrwj62Lu6AbTpBtNwBoHYhHT1RPY7R6yXlbin/6H1YjVLHIlEBN6Y8Dv+ba8ouDGVcqndhQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RsBNWlfESlyxacmF9aHpU6o6CD7kLZWmgv+NiGp6jU=;
 b=rf5G1G4e3eoofh4UBipbtetT5vENASBrDwYMUfSd2vgpVD7yALwWJrfYmequVnmpFbOq96loL6j+rlYzBkzZ7m0j3MASnFDxbQzu/PxuzMrTiwJuBpgQUThOLZuk0KAQbGaZuRTh6N34H7XLayDM7aNCBHtgADm7sv2GSCxHRWKR80k0g8idv0ZT6o2Zv+pjh8ZsbAr7r8N1dhKY8SqEpzMpFhJhzOKDPnyVjduOUCytX8o2vA1FHLqVPlzS7KE/TqePgiXViO7pl4dTGJ0Np+Km6UtZvfQDbf9cU8e3YAy/IuRVVrRONuTqdK2cvLk6U8ZD+TmMcRk5Cx8GN+zJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RsBNWlfESlyxacmF9aHpU6o6CD7kLZWmgv+NiGp6jU=;
 b=Yd4wBN2ANZJRiq7qihaIosXWDWNjcJCoYZfK9QL5qlemoQ3z4S6QgqaG0e0I5g0C5EP1+ZX0ngJuOn3mH53lJRz/Typy5R2kH+1Llv+/z4BSg6x040Zs2BFdU8/RISee6XA0QV4IGLPFFNmNUSRTUNcWSqS0G0vKUI37sahI7R4=
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by CH3PR10MB7704.namprd10.prod.outlook.com (2603:10b6:610:1a9::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:10:50 +0000
Received: from MWH0EPF000C6193.namprd02.prod.outlook.com
 (2603:10b6:a03:339:cafe::39) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 11:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6193.mail.protection.outlook.com (10.167.249.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 11:10:48 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 06:10:47 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Mar
 2026 06:10:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Mar 2026 06:10:47 -0500
Received: from [172.24.17.120] (ltpw0g6znt.dhcp.ti.com [172.24.17.120])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62ABAhmp2951956;
 Tue, 10 Mar 2026 06:10:44 -0500
Message-ID: <1ce56172-4de9-48d4-9ec0-21a49f69b603@ti.com>
Date: Tue, 10 Mar 2026 16:40:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: common: init gd->bd before dram_init_banksize
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Bryan Brattlof
 <bb@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Vignesh R <vigneshr@ti.com>
References: <20260310-init_bd_before_dram_init-v1-1-4486dacbe0e7@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20260310-init_bd_before_dram_init-v1-1-4486dacbe0e7@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6193:EE_|CH3PR10MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a53a78a-3922-4a13-bd0c-08de7e95af68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: vCVhZr8AH/Sx5n/gZs/luqjYiUazi/0uOG7GDyFL5xwqWx1LzWGOuYb6ALiMzeIHPyxYGt/RO93J0jCBTAEhMAzlolwRDQ5hKjxHvRNF5B00oC/p29nSZd+0biems/IL5HmexiE9++5jzCJzWHi1lpCRz8LmX0e9xxM0PFc8oYW6dpK2WPFprMZ1sPx9E/ebYqDUsF7l9rCnsLgawOfsdjCHwi8sD1bG6zp7ScEr8EkL1m5o2WYFp7FRKbcMawWG0KrfElbkxIlVSyll4cI5Cf6aCTCu/vSde0eizaaUsbId+xYXO6LtgmuLuUvvFkNxbRGIkbV6Tll+SbQ8UUQnMSV9TPBvwfTowgPtTaqspoyK0/fBTGivs4clzMrlaktgxzfFrBYCwbYTDlmQlmTmjyDg2nNXbV2lEsuCw4tQEuPtdzhWCt0BPFYEw2lTEv+9qHgB9yVJnvt4hg1+rWebDEQ28qJFK0S99JUJyeV73gjmEQZgo+8wSQxyiNEmfwVszkfSqRkKm7ir6kcRtaavcu8MaY6kNpnaSaQsQvzBhw2F6FSy+imC47UD5udmIXQ61ZUN/UQuzyvbLGrspxJHnBVCIEgTIjZZtt2m79m3+sWUDws5rl2aAy3Nzmx+kQt/NBRmHVYySRSIAeNlcFp78LvhQ4IechMUeB8QsVLj/ctMAw3Gk42hfng8HeFclyDj8F3AxmkdpZ8in1ja/R+FU286mPMJoYd9rXSU2jIGMOLfsmPdS7roFvMWH+eTTF8mZ45CA8xod0gW6S9BUNXKHw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0/ZWV/hki12881Q8AY0JbXsF2TDL/FeCHJo7iSdQc2371R0DPoI4I2NqH3hYGrHYm6wCuQ0xT2nlW4q1hrUJppe1nvzxpXdyI7XRla+ZkY+kAW0aytrfNh1Cpq7s+RRQhjV3iDb8HAK7saSkczDVo1fHlB52PVi9ia4TJS3wZkkZ4y9DPKIOPwemYBpAhrX6R66Q9tM0Jz8/qq19fj4layqrCRaeyevp5w7FVzX3Xd3fcPWofyACd25oZPukjSifrWExx7/AjxCOeuqQIshfdtiO7cBJehIclVtgUzYFHLGhQsvvbibI1fOfUhQLp1Y+lzCEzKeo6Cm4F4f4RkkbuMxXaDHaEpz03vxhwaFJiTidzWv0gIt7V7wvpUQRRxf5ruUre5TF/BGyebyBTrvznJWQ6vXbDd59WTC2jDsQYmazn6mGTEOWGUPxFlyjVjL+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:10:48.9891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a53a78a-3922-4a13-bd0c-08de7e95af68
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6193.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7704
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

Hi Anshul

On 3/10/2026 2:46 PM, Anshul Dalal wrote:
> The dram_init_banksize API configures the dram banks inside gd->bd, so
> ensure bd is initialized by calling spl_set_bd as part of
> spl_enable_cache.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  arch/arm/mach-k3/common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
> index 2f3df5519c5..39467c21679 100644
> --- a/arch/arm/mach-k3/common.c
> +++ b/arch/arm/mach-k3/common.c
> @@ -418,6 +418,9 @@ void spl_enable_cache(void)
>  	gd->ram_top = CFG_SYS_SDRAM_BASE;
>  	int ret = 0;
>  
> +	/* dram_init_banksize populates bd, so init it first */
> +	spl_set_bd();
> +

I think we really need to evaluate where all we are calling dram_init_banksize,
else we keep finding related debugs confusing [0]

We have to stick as closely as possible to the common SPL flow: board_init_r -->
spl_set_bd .. dram_init_banksize

Problem is we need dram_init_banksize calls even before relocation because of
spl_enable_cache. For my knowledge, do we have a specific reason why we are
calling spl_enable_cache before relocation? I am guessing some MMU setup
happening before we relocate partly to DDR as being the reason?

I think it's better you move calling spl_set_bd() up a level into board_init_f
for now (similar to what arch/arm/cpu/armv8/fsl-layerscape/spl.c does). We
should be calling this before we call dram_init (or in our case k3_mem_init) so
that we are sure it is setup prior to any dram_init_banksize calls.

>  	dram_init();
>  	dram_init_banksize();
>  
> 
> ---
> base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
> change-id: 20260310-init_bd_before_dram_init-7a9c3ad0b311
> 
> Best regards,


[0] https://lore.kernel.org/u-boot/20250314100734.23777-1-eichest@gmail.com/

-- 
Thanking You
Neha Malcom Francis

