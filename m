Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3A4F4385A
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 17:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B408407E;
	Wed, 15 Apr 2026 19:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jD6simWu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F58784119; Wed, 15 Apr 2026 19:12:05 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3C3E8407D
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 19:12:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOaUTDEgGj3uINDu+ynAqfu1a+MKiv965hqgjkD0GlazlhmLzEDx2RU3E6LA2eP6a5SVKHwtkg7GIRLLECfL02mVtW0Bo5oMKHBymP18SZ5vy4/W4YEKJ/hLeE5eKalg5/PlSwkvusrYITftviNbapYeBvZ8aMXOIeJ7DYXq6CADXjX4G8eL/u1n+0sRkRiere/MXNRIgtxMaD/PdiHsc4IPqEPWCL+ROSL0HxfX5th+wp+yVZGv9tx7PFEne12BGkrQl/ElDKBOQ5n2VcfqE7YQuRJlJ8xmGPoV57h5ZlDxVAjWfAfU2byZlwsuI3tF2gthzt+QuuaQB8YtMt9tTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P348+GPZRPyyx59lRy5Y65n9cz/BdmzqOPvP5rRTUUo=;
 b=DJtF6pTcvVw6Q7Pi1j8wBn4mSaJIQIQsxPqn14CVDBtYUsTMNa2iKkTnqq72v/RHYhDNxm1WVUi6qqXNQTBXjKPSwUvpDT0FnyDOiZPD81eAhBKHP8Ub776UXyqUSyzA8F/b8buDXB79YqN/G0d6V+NK8Lz7UAZeE7a7prMsEz+ZHFAIcMtE3hGBzc0f1jMaAVa5ig4YqYY97mqpZdti35KIwHiIDK/DS99rtTV+Cxgbo+u+TwXJ/C+xTBQI9t3RbAjxN+9ZX5C5+n0PhRjekLhG6jPN6Wb1B3Bq2bm6paeZOuC/ly9Oy0VuKxGTFqcRa19PBxMRrXdTbdwuzbJknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=paulk.fr smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P348+GPZRPyyx59lRy5Y65n9cz/BdmzqOPvP5rRTUUo=;
 b=jD6simWubrOiJRzGExTgmXip9Zntjt2HUd9hTy87XUjFPiL5EeNFu34WyzVUNklMda1jMNLXGwsh0wbpjkDhCyqS3IW7WJs1ttDJmu/ib6jBWwyXOrJkVnB5hvpqAGp7EY3hAixLAMTf42UJXMTQ1x3Prl15RWwDdWguvwhchyk=
Received: from BN0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:e8::14)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 17:11:58 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::48) by BN0PR04CA0039.outlook.office365.com
 (2603:10b6:408:e8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.44 via Frontend Transport; Wed,
 15 Apr 2026 17:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 17:11:57 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 12:11:57 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 12:11:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Apr 2026 12:11:57 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63FHBuGF2400609;
 Wed, 15 Apr 2026 12:11:56 -0500
Message-ID: <b1b81d6c-384f-4623-bdcc-1c24c6d910ce@ti.com>
Date: Wed, 15 Apr 2026 12:11:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/14] arm: dts: am335x-bonegreen-eco-u-boot: Add
 include of bone-common
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 <u-boot@lists.denx.de>, Marc Murphy <marc.murphy@sancloud.com>
CC: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, Simon Glass <sjg@chromium.org>, Anshul Dalal
 <anshuld@ti.com>, Michael Trimarchi <michael@amarulasolutions.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Johan Jonker <jbx6244@gmail.com>, Brian Sune
 <briansune@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, "Bernhard
 Messerklinger" <bernhard.messerklinger@at.abb.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, Paul Kocialkowski
 <contact@paulk.fr>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <20260415-topic-am33-evm-oftree-v2026-01-v6-12-94cde349bb01@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-12-94cde349bb01@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7132a755-2278-4ca9-4ea5-08de9b1219d5
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +4TlpDlJp6/FeKIxpusKumcDG30kICCJAATvBZQC0jX6Dd4liEEztOrSq4S2kqSf0/24QVIGeIb1zCoUT0VIgR5aCi8r0NSgK/HQSXrUwh+7NinnaIDHncOcrsklyCGnHP/ZGxxwCEBIkj/lkCeGkqIV0j46zxGJ5b3c8jTZLWudCnFElTYenYgJZ2/84g1/YXgMQp2Ud9C+4jeSJiMJkxHbqjfK7NsJR0P8Qs6jzrG6OQmevUNG3d0VfVjXjZshg4nAvZIA4MTBrpvKcESSrlp+zRdFS9zUOVGsMYwbtZ1y9t8qPqdR9+6SYsPOngAIZO3SWbP8MyCUmTnbaqzM5ulq9Wfwqe5nIWIG8DMnxbxbB3k70yyfViccuxvVQ0Mt6hInfGHHXJUjr8JZThFrWEPCe0KLxqMVVbTMr+4jAkM8X7QQu2Gc3L3ruO/buBSQUD90yjAhycYygqk5FSmBntJyQHWAnKpoSwa+zdAg0B+EG1sS17H6/ZM8dDa8bW6i1ER1vfetYc4mT0s/nitLs96N3N2uZR9snoTLMjMTH+Kb2QUEZJud6PfSCz5kyF+FUOFCplJ3+7f1AevH39xL5iZ4JtJWgmIxxycKtZ13YytkYOoLpGTKoDlenZrMuMVGaOh53w0J/Lz8vQ2btM9jSHfxoIU+J9Clo37o2pBCNQLzhJ9Hs+k7B4pWT6pdYw9/hB3od47sKaM30gn2e1roeD60IfDU8rOMoc/F3zVP2etiJCgZVAvS4MVw86miLuwy5T9ZxhSI0bEKjwl/Dnf0Ug==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PmbtxqaVgScqXQm4syzTaPJZBj6GjoaRSm04eVr9hYB0Cvd1uyhu2LIKfh8h1jYzG98rRuuwGn7IE73r6pmg8WKyZexW/4zD+9//n7yzv0cWdYlw1PP3kRxOl+qc2cRBN6ql3LjAwd+IdHwBN875AfgGg2O66+30RzqF/8hN3VeGdWPIQBRFN7mtenXnxnmZ9e9nhcH1kfqRj4LGv2g30mN4C+ibLDL+ZAe2kql7HCkzyEO1p3HcWlPSup6Nal1FXM0UuVtwH36GfmEqE3eNtw5a/q6mlZJrle+08xCaDdHl9JpGuBO37pxEcO2EA3xd7xjNFWxd47buaTgbUkJWNb10Dn32+fXVqAvbqoT3Ti73+NtUBkyIupFmy3iaX4tccCxBx2sKsgJ4iosP+77ceCwpee8QnJKC7AZ/XdMiuRcgT907G/4b4Krgq8DD+XOM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 17:11:57.7054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7132a755-2278-4ca9-4ea5-08de9b1219d5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
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

On 4/15/26 11:02 AM, Markus Schneider-Pargmann (TI) wrote:
> am335x-bonegreen-eco is the only bone that does not have a -u-boot.dtsi
> file yet. The added include for am335x-bone-common-u-boot.dtsi adds the
> needed tick-timer definition.
> 
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---

This one could be squashed into patch [7/14] where you do the same
for all the others bone boards.

Andrew

>   arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi b/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..e348f84d9be9a858596d5f5e1a7127e7d8c1e7d3
> --- /dev/null
> +++ b/arch/arm/dts/am335x-bonegreen-eco-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * am335x-bonegreen-eco U-Boot Additions
> + */
> +
> +#include "am335x-bone-common-u-boot.dtsi"
> 

