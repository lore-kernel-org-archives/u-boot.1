Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24169CD484E
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 05:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22CD781E18;
	Tue, 12 May 2026 07:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="va3uuSAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C8D83EEF; Tue, 12 May 2026 07:53:47 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED416803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:53:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNM1Oe9OUIDJ+mBrRBFTtKnfpmwREy+/ZlnBEMex7BSk+svM2IjnvN4B4dkbuoEza32kKj2ZRmAK0gNjy+ZFO8qE/TrIBYvJznprXWIkSlhK9EtJwNZfObKqMKbrxSisMVEN+toVKjG3GgUPrcF8pssALL5USZvOd2Q5iBND2KzMD77uF5qimSKamJvjz2RXq9K7Nvgi1pQU2Fbve6S/FtK/3VRRqCcDTYcezcEYZdekMRGcGyFJBfD2Nuk2oMTPPOc62wGY4lLwdxlKUWpclUmgnwZyRLuvWfcK3DvdhCOeU8AUVMJEKL41FUv6R5+5x0mm2F8lY20wcBlXCUNaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhgmOmzcZFNHu1tNEc0QFi5jnCqHn+rI1rkjAt69H08=;
 b=ft3TKXfuuVmftH++SkZsURp5RodX+j8iCYHygN37SOhroov35aqwAPUdT/5qjDuEN790KlywT9TvQ4+LS1UuBDJpG+WiA4eiVvoN61WusOcKLrjVorUItW6VJ9oeh7tT39w4cWjAgjhh28stD0dgpBq7eVE9b4LrRWFHFyeCZwhjb6x8xV0055db+Dn7v1qU3JAUVypRcIL4q0xFEf3aFmx6UB28oGo6cx1rW8vXnsonWGCrHO5/ni61EsZzhEUGcyRawBxbJcPSt2EjzwlJlacWaxIKgFEmwcsWGvCEBiVTM/c5l1m0VHYLICwJYyNYTpHnxvUmWMQjk1kKK7dStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhgmOmzcZFNHu1tNEc0QFi5jnCqHn+rI1rkjAt69H08=;
 b=va3uuSAR9Qv2dZLPvQ+JCYZgtshg++wvJUOaBFHGrgyzginMtT1woWEuTgkIRLd+HAMKvv7B0aIh7SrUaZyUlKONlLAipFP8DXp5zOAwKNmqWmFmnJw/jMg6uZMoZBJZURL81oUL0f5iORIAfMPDtOTJ4uluvNTI8wEAcFox2Uw=
Received: from BN0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:408:e7::17)
 by DS4PPFB033C1B5C.namprd10.prod.outlook.com (2603:10b6:f:fc00::d42)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 05:53:42 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::64) by BN0PR03CA0042.outlook.office365.com
 (2603:10b6:408:e7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Tue,
 12 May 2026 05:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 05:53:40 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:40 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 00:53:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 00:53:39 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64C5rcWB1157842;
 Tue, 12 May 2026 00:53:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/4] nxp: imx9: rename get_reset_reason() ->
 print_reset_reason()
From: Anshul Dalal <anshuld@ti.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
CC: <u-boot@lists.denx.de>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, Ye Li
 <ye.li@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Bryan Brattlof <bb@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Dhruva Gole <d-gole@ti.com>, Devarsh Thakkar
 <devarsht@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Moteen Shah
 <m-shah@ti.com>, Chintan Vankar <c-vankar@ti.com>, Ji Luo <ji.luo@nxp.com>,
 Richard Weinberger <richard@nod.at>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260511201235.1066697-3-alexander.sverdlin@siemens.com>
References: <20260511201235.1066697-1-alexander.sverdlin@siemens.com>
 <20260511201235.1066697-3-alexander.sverdlin@siemens.com>
Date: Tue, 12 May 2026 11:23:29 +0530
Message-ID: <177856520967.106112.12025390377838488880.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778565214; l=420;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=EtO+0ljPxrlhTjtkHpMLjmVi1fHRIJhoTHjTbs5VjXs=;
 b=G0TfFAbJY4syT5IRgsBByUIfglOwNkx5e035WU+vVKYdpl5LvWHDxqzqMYiJ9lHdIzlwNPOWc
 nRYbHczcT6iC8qOk8KjoAaZzWZMRIRffpwusDuOlLW9PJ8meShzBSKo
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS4PPFB033C1B5C:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a51b18-1e47-43ef-f801-08deafead194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 36YkrdPmV8PYaD7QyBXG+MV+SAGxEaAD565WVAXf2eGkLwMD6UcrKppQFJO/SszfwS0l+17FYwgNPo8p6dstX7QNqdrlLtahckXROE4bKvGO1s1eU8VlM/tMiQWUGDOHldH263XGAqkO8j1C0QRRN06J6fw4D/B79K01P/L5F9onXy+GUQfxP0SYAYTKCy3JaTLCIMQeX9JAwLO0HMnAzveLy3ZWxVcO3xDYgNr+KBV0HcazdvV6fJsSlq893uzcEYNA51IbupFk9ojVcI5IOFO7X2aOP8m90UiS/RJLU+n5tyMIYZCOGcO7uiuTc+gEx9GXOPeUYo/DPO73Z6X34Q6ZbSKEKrgT4uu/LRenQ3DhAOwrhyuGFMn9BTXhz0a8Y60QHxUmK+pU3+wZZcuKEDXte3vd3YiPe2Fus8pwWzQQmrLgRY/TllgjmD9nSfUH+1uW9OCsDlDTg2ASa3F0reQcNg5IszRrG2/WRfefKAASwwMNIafSW9bPvNH7cnJ/zYJOwcab8OogKF2VAsoK+fV48th/dAUOPsjJxm1s/4RMw4e6TB0X+kixSz1szMdduZ9P9faChuuQj6pGj2AHWJeOlsgMFyr3IHSYLgSkiFJ14fQbC7ndMSkdpeeeIfE8gANDO+rxrvRi6Rva3H8Zrhb0OSFZdKpWrJkZ1yzRBDHR2zvQ3iy2M8x4D9RteesmGl1IB85h+4eW6ps+Vjqld5Jlkg11GJCoFQey7BgG92A=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zNGctEYEfa2Jx41dbtbQHbzQvrgbtLG6dRtUNLG7Ga3DfZfUjTB5ah73Bbj0dfBXFnTJSZawYc8svqzISbHq4Kc2FNWSQ7ZLrJkwoQsRN5K8fnYDk2krGBexKcfG81U/JzvaoY9QaGnjfO2sUs8nx/bWzGjwIux9DxnWfytXktAzJOnO2GLBdxqPySYly5k+5IKDDG/P3EPPXqlVmmfAKw+H84UDiT73SbOcSahe8r+lQz3bA1aPFe96EFuS/IkqWTJjo0uNPuB7fEq3PuiZpgJ6uVDATe2TvtWv432l3/nfylVdKXgfAG8dKyj2RzGgU7S4EH+bgryRQyZJ0hXvDrR3u31vxATiL1fmh/UxE0FpYOiQ23+c6GtQ+IbAvBqYmoSa6TnbwIGQkp/bJYpXSH5VakaJUI4dQJ5XarBnOc8xGsiGkhN/YVaVk7kM5yUv
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 05:53:40.5486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a51b18-1e47-43ef-f801-08deafead194
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFB033C1B5C
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

On Mon, 11 May 2026 22:12:31 +0200, A. Sverdlin <alexander.sverdlin@siemens.com> wrote:
> Rename get_reset_reason() into print_reset_reason() as the latter better
> describes the functionality. get_reset_reason() can now be a global symbol
> providing a reset reason as string.
> 
> No change in behaviour expected.
> 
> 
> [...]

Acked-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
