Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CF9F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:45:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7956C83FC0;
	Fri, 17 Apr 2026 14:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NVXwsvHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6BF84222; Thu, 16 Apr 2026 21:55:16 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA3C83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKY7K5usZ/vI503E3TLV0SSiiY/jOnq5SZDxppyU7FAxQEzRQM/WXVXZAYX/b20HXNDwDuUMHHSYbGlV/eV0LySeEBw+JGpUr1pDOKajc1NtrVdgI31eZ2jvO9rybvUQ+GyeyNNAFlsZJQtRAxaNAkFwiTRNoMOGKv6dV893OUn301WHkpC8QxlloM/hW8fUXJMhRN816BiiZFt6EfH2IKSQ+IYybwAtOdxOoH2KO18IHpo2dL54EJORyLop/yqiCilayNvamTg/8kFB0O0prnCeUU0dYYPSCO3wA5vmU4sz37Wa69Ib+o6ahOzr6eCi/lhijmk1M1oJuzRTlxuo5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM9JOXjnpBo/V3L1Bh2X7AL6FVmxCTsf4c/7oOf/O7U=;
 b=fMubWtEh9K6BC5hOpWTfb7L8Y8e2GH/19a6nVg5cHK1NLsb5D1aURSplyQpj526swPVWBk5XACE78aav3AhyYVP1sEhmJZBCjnBxMnRm7dc7ylH1CuhuzCfhavj9Hvbgw6Bp5Qq/L/Qb56NPgVQb9kD1ARw868n2BqX8D14kI0osmrlM+Qk2AD0xw4iPj5ic+AfIZJr540GO7tbDuY+3SuZQy3V83lVj2EzWhfzQrQMfjWfNeEVjtDxFKBXLQ0AzsdriwN6tyv1s2ZB7mgxTkXFgWkggidSiFycplVAmLvHVzds83rxSOv6KJz4ZV+eHyNOAEO1m/zrh1CKt7SYq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=paulk.fr smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM9JOXjnpBo/V3L1Bh2X7AL6FVmxCTsf4c/7oOf/O7U=;
 b=NVXwsvHIoY68GXKY5i0wmqNCzCf+RtsbCPcEGUhYNcitxx1O8cdbtq1GkfqI/MIp9K0EjruwgWwzGXPUWxVGx5zQfHHIHCA9Nyu/yeAab0FQ0Dtsb72cI6cVde9jcwz4CyAM+W1++GtLOI+gJEgewJ6l6N61UR48yeyZmYHHgwg=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by CY5PR10MB5938.namprd10.prod.outlook.com (2603:10b6:930:2d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 19:55:07 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::e1) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Thu,
 16 Apr 2026 19:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 19:55:06 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 14:55:02 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 14:55:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Apr 2026 14:55:02 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63GJt2sP614199;
 Thu, 16 Apr 2026 14:55:02 -0500
Message-ID: <39c2f5f1-ba0d-45ec-92f8-2e87ddff1aae@ti.com>
Date: Thu, 16 Apr 2026 14:55:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>,
 <u-boot@lists.denx.de>, Marc Murphy <marc.murphy@sancloud.com>
CC: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, "Kory
 Maincent" <kory.maincent@bootlin.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 "Basharath Hussain Khaja" <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Tien
 Fong Chee" <tien.fong.chee@altera.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Johan Jonker <jbx6244@gmail.com>, Brian Sune
 <briansune@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, "Bernhard
 Messerklinger" <bernhard.messerklinger@at.abb.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi <parth.pancholi@toradex.com>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, Paul Kocialkowski
 <contact@paulk.fr>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|CY5PR10MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 772c85f8-74a4-4776-4777-08de9bf20e86
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: vAYDjEpVwIXLmiY9oo5U47Yyw85eKaa42zhaU1EDNfsrpzytfxDi0eyKgXIGQwLlmyBtkQFVZZ3gsrWE+9rVntofDByJsq2wor2VALle2SxVgzuWyBV8deLbD9+87IyuQ+GZZkUSMODCKk+OsFQmeLzd0JnsuLGX2nrGMIIKDBvRFoxm989vH2GA17HOl8CQog00JH7X5uLgHWs5DgCOwgi/Ur+wo0DHKSP533K9L+TFe1Tc8VsSf86tB0LfzdkXRvmWT+vpyjckqiRCjAMuSVtnBvHTPfbwuM/6KfFITgC2yNG6v1+sb16CkmHDM6wn5KGUA47ksTKBzqYRf7SapLeZTWYYa4gl97MYTDUDY5wWx0ScXsuzSapiU9Kd9KkrprzW8PqLPmwKCOV0jMhJUu+KmYKyABcASs5aIoLR/E6nq5Oz9AvWkk2aWJUFdjUe3SdNNWs9NNsytKFsEhlGDxOVBamv0Qj4XFNbVZbKJDBCxNrlpCtQPHDOBLQ2mPKk4+vQzQeq1YCA9kbw7j/bg+y1ltJa+rvMjRLa8REYCVqU6tfxquz+/vFAXkYa0AvupqXop3W3ujRie7ogCWf196RJFqFJc6iYFQJb42SrqXdjdC3md6Olb8ZjIrL2vnlk10JIowlwNFnXpkXATYWlQwn+nn8pVYWB2j9D6wNqz3mnLktiC06zyIj+laYGzCkwpRc1xWFlxThegSMun/PimfXpFCrhFIrhPJwLFHmO5OAPHqPd2UrRw4GDMn1vBZ3KPtOon4NGuB0TuIRs6iRsfEgD8SU8Xsq6mgl5+ZBATBs=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wdQToaFvOkIHY0CyfLua7mXYsRvThYjTmhKvOpT675TAQujLYJHZGX1O6c+Os8xWdqnMRde4xd9NnPx68PNiOSzfu/9BAyyfeh+Dc2Ox00XqUTu2a7/MFtP0ZV3RIBVkmxsZ05nNjUGsyKNfZCrUy8G9rg8yRNpGegmlcf837DVQSoACFKtVt3gK/eTANy+Qx06qUj6x3WKrez/rQAHEm9O7LVNpblAR8QgPQ/Tef9Or76CAszX7/5gsvsC+W9VIS9AJOZDJ3WKpyIUMXwhbS6a11zBWIWn4WsqtqBgA/KabDVtGBHw7wq5NBkz5QEDrzuTLBSZgBL0NsVlfkZe4zSF7qz71PVfo0JGX5JS+WRLGdwH86Rxs50F2dQkRR1x18k3u47XPrHXblZCixBjrOSdP9pHCiHlUOAAFNHVix0ycZ5ZWrnKN3p2eGPjVJS/t
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 19:55:06.0060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 772c85f8-74a4-4776-4777-08de9bf20e86
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5938
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

Hi Markus,

On 4/15/26 11:02 AM, Markus Schneider-Pargmann (TI) wrote:
> The series is split into two logical groups:
> 
> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>    with the current u-boot devicetree.
> - Patches 4-14: Make upstream devicetree working with uboot. This
>    adds tick-timer, adds compatibility of the board code for different
>    USB probing, makes SPL smaller and updates the defconfig.
> 
> The series has been tested on am335x-evm. Note that I don't have all
> other boards built with the am335x_*evm_*defconfig, so tests are
> appreciated. buildman reports builds are working.
> 
> Dependencies:
>    - net: cpsw: Add cpsw-switch DT binding support
>        https://lore.kernel.org/r/20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com
> 

I have been planning to test this series on a couple of AM335 boards,
So far :

- am335 EVM: Pass
- am335 SK: Fail (at least SD boot regression)

Pending to test:
- beaglebone black and am335 ice boards.


am335 sk:
without of_upstream: 
https://gist.github.com/jmenti/e51e1fc1b25c19f94786ad39a38737b7
with of_upstream: 
https://gist.github.com/jmenti/fc17347eff33991a78ce365c42a76a25

Is this expected?

~ Judith
