Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C739FED2EF
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 08:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19CB83F6D;
	Thu, 12 Mar 2026 09:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NkJLTpzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 765EA83FEC; Thu, 12 Mar 2026 09:30:25 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C18483F53
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 09:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+XPqZH9KIc+Wn2L+7a49jOc+N0AIvm6zU3mfpce+H/JWOguaCYkoixprvB4hh+H7IXDIUrUBe9Ucplh+aA1L/BUi2i3bExnVCPJCIdOAgzAk+ad9RadMWdSXpyZfuDbEsoIHutrUWg3IB5676sPwBb3Xna14R39E8u/sHS7LKLQ+haRUUaTrdYv29jwEzmFoaQG1Hli4Iy0Qy6ydmP2oZ+QSMQz065e7chWLNJDHZcqITvUuPXN30OrZuwzjAvT/NDI6CmbBcIMxKd/rE6cmGK3sTRkHWzOqPhzuXZ7GwceGfES7h/5+opixWCwcCR+FIia3mKi0dg0mbCLMdj4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0juMxudnOton/OzIfk++DbNL/ybcZZIXefm/lbChx7Q=;
 b=q/9IY6Q781O7wqweV1KyPdkfLQpfkpkSawD0R3DPTL66oToDeb7ULbLkTEj3eTV5oOGtpAK3qx8u3Ava3wuwQj215iZiLU4plEzA2yUgCtC1j2MEYAw/H1ayXUuGVVe+x2bLZiNAmrRFfMbxm6bwpdFs9YHQxMaF4Rn32FWBjjEXbPwbEUc0hF1TkUrhkh1JMuMhs+oytAw3VYbyP6v7qbXUxt0e5vcNwjelp4BJK+0gS1Ag6znaVGwq6qpTVLqT1pkz+u+2F8mA1cHrDB8zGUGjvDOzbqPEo8JYiR8Egs/T4xUGB3tNQgbgT0G4KfPs7zpybsmpBHP3QWQrkdxFLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0juMxudnOton/OzIfk++DbNL/ybcZZIXefm/lbChx7Q=;
 b=NkJLTpzA8EY+Ng+hv/a56nTPZGKCAoT3QITWirvt1GMc5h27uqg+tuWYEMZLEUUNLmhgz467wdHZLUOe2Ckz7Yqs4UqoMdsBDI2jFpDU2PJa6LiWIc3uTKRPY5RNFJ9HSV1eFEFK4JCWZWXj6qu9VC/zWDvfaXfRClev6LDufbY=
Received: from PH7PR02CA0025.namprd02.prod.outlook.com (2603:10b6:510:33d::14)
 by DM6PR10MB4220.namprd10.prod.outlook.com (2603:10b6:5:221::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 08:30:18 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:33d:cafe::2c) by PH7PR02CA0025.outlook.office365.com
 (2603:10b6:510:33d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Thu,
 12 Mar 2026 08:30:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 08:30:18 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 03:30:12 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 03:30:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 03:30:12 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62C8UB0Y2487483;
 Thu, 12 Mar 2026 03:30:12 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Mar 2026 14:00:11 +0530
Message-ID: <DH0NVO92OX1Q.36ZN1UAD5D2M2@ti.com>
CC: Tom Rini <trini@konsulko.com>, Dhruva Gole <d-gole@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Bryan Brattlof
 <bb@ti.com>, Devarsh Thakkar <devarsht@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mach-k3: common: init gd->bd before dram_init_banksize
From: Anshul Dalal <anshuld@ti.com>
To: "Francis, Neha" <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260310-init_bd_before_dram_init-v1-1-4486dacbe0e7@ti.com>
 <1ce56172-4de9-48d4-9ec0-21a49f69b603@ti.com>
In-Reply-To: <1ce56172-4de9-48d4-9ec0-21a49f69b603@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|DM6PR10MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0769ab-0c14-48ce-38c2-08de801197d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: W91nvtfDnHoM1181lJuVOkid1VR2Jr0dn3ENIpdZ0r06ShAaNnl+yrjWsktBcZNfrA0PZyLQoqde7vCopWCooTKW0V2qpcK7H7R+Eczb8x0VM/T3t8RNUXGxC1enYUffn9k8vDkU4zGup+AfTJcQQs494XJy0CkNk2CghqDabYb8rera1Stk1CQu3VirSHuNmuBli0tNR9Xeushnpv+PoEqVep/1uhYFnVifxCVgw2GIHpNEBFpScXQtpDYJh0CfVhcnnraJCMhXRkxhlZsg1HDuUg+oFFIPgDdPvINk2Wq0t2ZDN7X8F1+FXres5WY7iOoxEOvmgBgAAHcC00hgl1g+kaG6ONc4xMoMNE2tA10R0MFRD1i5hRtUHwLuenw/lASQ8fM6oamToLaWdivX/PLeD2i9mqqXESLp6atH9xN090/igKv5Z6UvWuLmeXjwvqyPgWoXSG5qgYfjiYQUrNl17VdGtE0Q1pTfcwBbWK3k5VivE5msxIBzSbx6Y8LUHF1SIOl6HUQX4ddfxpHMWlUHP37roO9JBxSIK5ReM9ROhFaigyfEB2oqi9j3hgsltzvD1vZ/VhBsijCW7GH9yE6NFHNxeZ9IbXafZkXN7lDAWw5y0q1rpiSTVWN3i2wdPqhl01soIYgaQLvOSYzoNaNb3FxZa/OyVEW3a+iQGsoVpMTdzG8riFjdO+YR7XRQ34beto9gvN+11FvJJNNu5SNi2uzXcwBzM9de+DRD08YLq8I5vu58P2BVNZvy8ELFGmUJA7GgAKQbgSNpj2PXsw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SpUwN+wTHHtXYBcTESpRTitWGADi2xUdYc+KLeOrM8/Un/mekTgRoeZfCPqqv+bIXAUZWmhtIilFa+d1o3RTcY3/9ky5VeXf39xqcfE8Lcp9SuiOxa00R6MBvvG+pBdsZXeriKE89De1OMa+BuCjqtYxUqJkOWpPQ0e3fq0/l3WSAwiv/Nzsv+G5RAUxV9wQjHBsFUv7oHwTtwHPA4/BH6WE9IJRoIrTmM2irQCwPIomahkXCP+Ld6IKY2EpMaEuhcUdZ8Y0tGkBPagyR7zvAiYdwi3g3rZMyY7kHlA/HnxBkpjmdsNc2tYH+D0Davda/Dut1UzFWfy/cs5DcPD7hA9cAmUehx1WQ8Sb2xDrL6+rvC7grHXcHOCLIDcSYb8YdAfb1C2ikqEXgSH9+JMB2ipBex4i+wwpGhvqM7lDkpc6V50pCFQLTRdFyWzDdTVN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:30:18.2142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0769ab-0c14-48ce-38c2-08de801197d6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4220
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

On Tue Mar 10, 2026 at 4:40 PM IST, Neha Francis wrote:
> Hi Anshul
>
> On 3/10/2026 2:46 PM, Anshul Dalal wrote:
>> The dram_init_banksize API configures the dram banks inside gd->bd, so
>> ensure bd is initialized by calling spl_set_bd as part of
>> spl_enable_cache.
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/mach-k3/common.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index 2f3df5519c5..39467c21679 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -418,6 +418,9 @@ void spl_enable_cache(void)
>>  	gd->ram_top =3D CFG_SYS_SDRAM_BASE;
>>  	int ret =3D 0;
>> =20
>> +	/* dram_init_banksize populates bd, so init it first */
>> +	spl_set_bd();
>> +
>
> I think we really need to evaluate where all we are calling dram_init_ban=
ksize,
> else we keep finding related debugs confusing [0]
>
> We have to stick as closely as possible to the common SPL flow: board_ini=
t_r -->
> spl_set_bd .. dram_init_banksize

spl_set_bd should not re-init bd if it has been initialized already so
the second call to spl_set_bd as part of board_init_r shouldn't effect
anything.

>
> Problem is we need dram_init_banksize calls even before relocation becaus=
e of
> spl_enable_cache. For my knowledge, do we have a specific reason why we a=
re
> calling spl_enable_cache before relocation? I am guessing some MMU setup
> happening before we relocate partly to DDR as being the reason?
>

SPL does not relocate to my knowledge, we largely need spl_enable_cache
to speed up boot especially in A-Core falcon mode where the large kernel
image needs to be authenticated and uncompressed by the SPL.

> I think it's better you move calling spl_set_bd() up a level into board_i=
nit_f
> for now (similar to what arch/arm/cpu/armv8/fsl-layerscape/spl.c does). W=
e

We could do that too but it'd have to be change in every SoC's init file
and the dependency between spl_set_bd and dram_init_banksize would not
be enforced (i.e someone can call spl_enable_cache while not calling
spl_set_bd first).

> should be calling this before we call dram_init (or in our case k3_mem_in=
it) so
> that we are sure it is setup prior to any dram_init_banksize calls.
>
>>  	dram_init();
>>  	dram_init_banksize();
>> =20
>>=20
>> ---
>> base-commit: 1e240f7206fccde4ec73ea432ab8360d321c5fe5
>> change-id: 20260310-init_bd_before_dram_init-7a9c3ad0b311
>>=20
>> Best regards,
>
>
> [0] https://lore.kernel.org/u-boot/20250314100734.23777-1-eichest@gmail.c=
om/

