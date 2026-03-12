Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4849106ACCA
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 16:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E86842CD;
	Thu, 12 Mar 2026 17:15:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="we0ErxbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B92F842CE; Thu, 12 Mar 2026 17:15:00 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B859C842CC
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 17:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGN9OHbo9AFs0mRNDnWTPsWfGydrEQ28IE2Q4aG7mnsRt7bBhgDF19ImZwbTJgtfP4+FYJ+2fExKA3o9zcB+CzmzEiqyNnMR2PA0Mhh9bM/K1ZpgRfkuOJ5QCzZsd+epg6idtoPk1qXDZbJeu3Qj0AsT9yL2YSBUwbu7h5Tx7lZ1Vr4u+medKO7tJQvbgcfctv18Y69GLxcQ+tKttpwGYfY9wrOla5r0kxKUi6flchEMV7mzbQWf1iIfy4D9uvFXsIMi71zAYbuNJA5yR5tJRBTnEgqL5oH3DOGBJiOY9+gId6pZJ9K8VHoySLTgIMU+GLSxhtjS2ISMW62Icm/0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZCIGmECu3MzBC+8483Z/vuhlFRbbLN27LteKiBOvZg=;
 b=FjCW3wbyvHZjrPjICWLD6t0HrcNbA/UL64L+6bJ4suqQSuIkQpj0ijQU1536J2hXby5YCFG3O87jwTy7E22P3kYpC0N67xNYDusAP/qISnRHKnPamNuK8TElRQHYlzphXxjVoH7jLi2pQkxXOhlFqYGc3e3zxsUbdcSy6/m9tS3CeL5JGUYFXEIWotqnIClQtcK/r0l9i0IrPqaMe4w2rL/LUpFJLIkZ+a6z8tR/TDnu6TYhjy+iE8wavzkbeqXJcwmzRjRo/8fp2Jo2cNckkpc52eQHJ89QjnWIG4mcmAKazcAGkInZTnU1cfDL3WJvXyyYTabhz4+/23GEhSBuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZCIGmECu3MzBC+8483Z/vuhlFRbbLN27LteKiBOvZg=;
 b=we0ErxbP30FRcZvbTDWFEsJr2RRFrmrpRGuJX9I+93aJAmctg/ewnVcWcziAnSiSJR5h/MrQWKJ7tAfjHdO6R1U2DJ5vw8I1Z3r3kfXGT7AGOswh+54YSg0somtZCB/kHQ2Ry4zdpT+1IyZAwNQAK8ajtpAo1ZpbSDu4GD+KYHw=
Received: from BL0PR02CA0122.namprd02.prod.outlook.com (2603:10b6:208:35::27)
 by PH0PR10MB4455.namprd10.prod.outlook.com (2603:10b6:510:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 16:14:53 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::5) by BL0PR02CA0122.outlook.office365.com
 (2603:10b6:208:35::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 16:14:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 12 Mar 2026 16:14:51 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 11:14:50 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 11:14:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 11:14:50 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62CGEoWa2608750;
 Thu, 12 Mar 2026 11:14:50 -0500
Date: Thu, 12 Mar 2026 11:14:50 -0500
From: Bryan Brattlof <bb@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Suhaas Joshi
 <s-joshi@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Dhruva Gole <d-gole@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH next v3] arm: mach-k3: use Kconfig options for ATF/OPTEE
 size
Message-ID: <20260312161450.25vb3gugnnr24bj6@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260312-tfa_tee_addr_kconfig_refactor-v3-1-86c92718e048@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260312-tfa_tee_addr_kconfig_refactor-v3-1-86c92718e048@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|PH0PR10MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: e8052b59-7624-4562-f829-08de80527d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1Ln7mC3WkveKVgdc4mCjAbNdpbj8nbtJFfsG+9ccWVHMX+6hAkown9GTkyF1AeY12WrzXAz+cCGS2JAD7drTItgaCAkpVDnCHby3EoZeJEOCvRVjHdxIYUjmFf4z3gG2eyfu6HaGeq6AAvohTeYZOgQLVUK29GF9iHcV/BYKLn4sE8KuAl7UFMij5jqxmz9o5qk+Pj/Pu2Ohy08I1bwqHhtevnmqbJcmdFzwW0l//cJcp/BYMOT/crYIN9H4jpL/8fI//43LaLHdTTykcjmYAKRWf/2/8L4C2/vQKiBsh8WCHxkGLMdwq4Fw1o7GBsdVyv/eQCEWTTWDPvHhndHq2+/hiTM9RHMrCozWFDYACnMxqv9iGL1JCvPNR05RfdI88wFuofX3zYMYwhvP4ohYQKLRkzfGkkSGxY0+9Sw4xGT50zekWwI5V6S0CnRAfPFOe6cyYuPGQxMlGuxnLLIUwGwW8TexP1ztrsWqxHrCw0WoJZkj7cE2Q1dytnffzgLH3bFnmZR5sJGWbmBhULuWp10KPb0BGQp0kIrFgCqB4whqf8FQBHqdERj6T9j+VXUS4r4KWI5tDKRODgEgr80+EorigW6m2XSBR96jw0iKT7R2k9n4vQKEiSZqNITkvp1EQjy8ynebuv1LL4bBg68xae1kvpD89dvO36AJoRgwSoqLxZ9IOCibdVUyxaUqPa58hZiVs1vRi/K0Iymh9+TzP+6/wMR0twyo9IwkZYoN/bzWBTYzobOo0tsKoygTkypgIzm1bQQ8I3KnPDcTmJ1W0Q==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fyl0nmgR+2Q73FvjRltnAbfD7orhTIynwrQrC+IZFwrjLJqUXAsht2kKm9sxHEoYNzY+cMKBkIPYho1aQac5Y6rFy9I/a2BEIlNSTUCLcnoUA+AgPjIQeWumfJf3UOJ1NFcoXwP+fBz76mBmsQJeROlop0ndKonMSt6Hf+6Me0mH6ZWF0iQFECFtJ881DYEtPU9UHf2LEgQgV5k3jGKZuD7UOrgdLMaKzTCojjLynW4qfCtm79MvuSmdPSaPCLMFNtX7MXuG4+rs2jhjG/235uH0qo7OZAJJgRmyV/fHjTmrXPcgtbTEoBcJvLiGofkGn/YtZbzeY513pS0R7TbsKIoRjf13D1pIzhAHh76mVQoT85dbWLVmtsQTtlk71Jb/v+4Wy4HvaFyRnuMpmxNq9W89njzqXXdOIOOIhdYHUA3OcBndMezoKMyFKkBpy7XF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 16:14:51.0977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8052b59-7624-4562-f829-08de80527d5c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4455
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

On March 12, 2026 thus sayeth Anshul Dalal:
> The reserved memory sizes for ATF and OPTEE were hard-coded for K3
> devices, this patch replaces them with a Kconfig option allowing for
> easier modifications.
> 
> Acked-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Changes in v3:
> - Pick R-by tag from Manorit
> - Change help and prompt text to use the generic 'memory' instead of DDR
> - Link to v2: https://lore.kernel.org/r/20260311-tfa_tee_addr_kconfig_refactor-v2-1-d66bbdb36a3e@ti.com

This is what I get for not sorting my mail newest first :/

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
