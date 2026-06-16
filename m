Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1789CD98E6
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 12:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58855848D8;
	Tue, 16 Jun 2026 14:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oEtsH/TT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ACE7848E2; Tue, 16 Jun 2026 14:27:14 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3C2848A2
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 14:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKYCibvWhAquo2z68tjiN2pgvsFu6LXL7+Zu9Se+/O0niYjHyiHzO80PTUnp06ICTLBg21tc8Tr1QAkkBT6+DfxtAT9DkB+nTKFoZWO/8MORwhCh9Fzk7tWtx7p8Bp1Vtzh0VnwZDEDnTB/J0BtivhN/W8IFZF2IMqIJkmJgtoZP2IlTpfA4eOZ0PMl5OQURNldHRiwlpa57se2vbAHPalvcARuZuJdphFqmZGLNBADpXI0VaTT73to0QwDZyIXFD2Ck4cKO4/UhNnCQCbbL/i2xG8ONdFDd+4jLZS4dmbZqSlc8lFy5eLbL1lWG6qrfP92p0RsG1bxdBYTolE1GXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XoSNquK5RklJWmuUbblR8Z1gUpsP4HIrYTaBur/Qbg=;
 b=MMpnYZZ2M6Sd2hEkO67hhdBRbCQSVWGTzWknBzn5Wt2jWSsY/GIgD0SCJjK3I4aRwDkx/TujeQKL7B4bM5oXKPZQqwdHuGZD0vnIGqf93jWsBYzLd41klcdS0pKp/bG/KtB0gMqWgsfyHdOSHymu7ysNzmj4rmRCPi6v5cmeQuCsqftt7tWv6r572CthiWUcArUMDQ6QoE2zwZwL/nt+uVhQAWvr0kIvx9o5Z8IyNOqV0+blPwDdwCAgU2Gf97qwJ6+1z0KN3A3alCpo7FmNFHj7xZKSk9VM12QofQBQfvVAIQmQdAFcfSYBEqpofXydCwWSIXYrO1E6K3jZUyGQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XoSNquK5RklJWmuUbblR8Z1gUpsP4HIrYTaBur/Qbg=;
 b=oEtsH/TT0DWf1iLkxVo7Go23l8fH/QZmH4Gbe4BX1uAUnxk5HaIrlNu0IfngJE87WGWbCyes2A70Hi3hjE0GSHKaEHaRQRj+8BH+hx1Yvkcwayr6/eqjwcT97xv+vkL6EoA2Sz01xIkB8eZNrOQLVG6M3Eo3bTpS4r/0EH+UhE4=
Received: from SJ0PR13CA0157.namprd13.prod.outlook.com (2603:10b6:a03:2c7::12)
 by PH0PR10MB5564.namprd10.prod.outlook.com (2603:10b6:510:f3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:27:08 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::62) by SJ0PR13CA0157.outlook.office365.com
 (2603:10b6:a03:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 12:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:27:07 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:27:07 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 16 Jun
 2026 07:27:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 16 Jun 2026 07:27:06 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65GCR6pT3591989;
 Tue, 16 Jun 2026 07:27:06 -0500
Date: Tue, 16 Jun 2026 07:27:06 -0500
From: Bryan Brattlof <bb@ti.com>
To: Vishal Mahaveer <vishalm@ti.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Anshul Dalal
 <anshuld@ti.com>
Subject: Re: [PATCH 0/2] TI: AM64-EVM/SK: Enable MAIN UART1 for SYSFW tracing
Message-ID: <20260616122706.uotiq3cyqdzzmen6@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260605193829.395161-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260605193829.395161-1-vishalm@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH0PR10MB5564:EE_
X-MS-Office365-Filtering-Correlation-Id: cb84bcad-7e11-46b8-229f-08decba294f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i5IHukLFLi6HcxnGaj+hrJ6wQWsxPzKpjNw+Oe/ntyr4ozQMeE+2zPzVCMawGIxo3XEeT78fRTCI1+f3vTwGBqN/WWUf3EvD9TxnIR4os4gTH6SDBlZRrAWvR15+25V+cp18X6nHFhn+d6mxdGHYa8pHlmgEdtF3n6bvaQIdFXUFXQE1Z82oIVii4+F5DfCxQudupsGyHPTR2XRxj2G91n2NJNdd6U5pvIhOc15NwQIjlc6nyRdQHY2nuulNlVw5kr/HufAKHsXeuS6QsPC4OPhm/zmx4EjXRilsi6y7dAhza5WNY0GvDCggC2B7tAHU3qpSIPC/Sa7CRZ3qAqU3NMe5j9uwIMPc48RBfIAsss0Zafb3mq6Q+OwBItnrF96w8wrYSO6qdp5qXMZNh5tmHHEsj4hG8rZFBzSSWZtZ249VEPSVa7ckH6vf+bMPkrFrDw3TBsMChK6rkydiAx0z/MP9dWEx93DaxoSh8gqwUz9oolxP/RtUtbFLR+HhUhg32jQ+iC6+iV6WdrdHOLCRa6o8p4qfgRubGfUX/hI/R3Qequ8G3uvdKMCw9OaG+XXL6o1bTba9L/F5Ss9XncA8z422hFcWGx2Ph6g1fmX98WhAiicqxT3cD41V+meNNh4lH/OUk5q0vFdc3/Af5PESzkJaPSv1cWKNRPbX69yLshwJ9b0CvL8zxPt2dnbSnGI9DcS6v5wz6ah3pMYmmIWgua/aUYjUkZErTuWyGsjaG0k=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PKzRHENmBjp3zl0+STfSWxAwVzk8VCMnkwp+b81UxH6J4b9khMeMqA5YbCTviBGbOamCuP/U+wwqFELz/hAz/Grx2Gamf/fdILY2neA4wEQ9bAKZf/PsCgNj1uS6tnYbf1OM8X+qttGzmt+NM3NNI2bp/OEZ1SfWfOm/lH9bws3hxN1RZBLaVkY+4iJ0djHVs7g/FvA1tzT4loSELLXaGbkNdjqFWWwwj7gGF6UGwC4/vHm+8rE6Htv2rB/r+vmHsB7fpnetlkXisr5GSpTKLZ7OSjmMu1NuYibEL8mHvwwHQU7Qk2/j83Day3llMN6rzT1sB1egtQxJuJIffxHyVoceBsFqn1ZbFfmCO/huXKhSZYaDhIslw5voJPdmAxjll2EW8dzuovYQyEswqDP9Dj2p38sFHkRFxvh7pjH0GtYyYLy099Rof6j1DhMNi3A2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:27:07.5910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb84bcad-7e11-46b8-229f-08decba294f4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5564
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

On June  5, 2026 thus sayeth Vishal Mahaveer:
> Collecting SYSFW traces from DMSC firmware is broken on the current
> codebase. These changes enables MAIN_UART1 for collecting SYSFW traces
> when the trace option is enabled in the boardcfg.
>=20
> Vishal Mahaveer (2):
>   arm: mach-k3: am642: Update MAIN UART1 serial alias from 3 to 1
>   arm: dts: k3-am642-evm/sk: enable MAIN UART1 for SYSFW logs
>=20
>  arch/arm/dts/k3-am642-r5-evm.dts    | 10 ++++++++++
>  arch/arm/dts/k3-am642-r5-sk.dts     | 10 ++++++++++
>  arch/arm/mach-k3/am64x/am642_init.c |  4 ++--
>  3 files changed, 22 insertions(+), 2 deletions(-)

We'll probably want to include a fixes tag to get this in -master but I=20
can now see traces. Thanks Vishal :)=20

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
