Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F0AF459E5
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 21:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09B784099;
	Fri, 10 Apr 2026 23:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pVJ6NUD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDB3084118; Fri, 10 Apr 2026 23:53:10 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3166D83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 23:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJcWk9yAzP/4eutYroqjSbifqLTMnpueg+7ExfPd+wRaBEgaENrtT2X24ezdIFSblTn4savFrZRlXUDVXsUXL+U2jyJLmRRsBOdXqzlMQJGedLOkKZh37o9Wiv/H4a8NK/6tEtazZxehsmJ9OWv2FCVBUEsz5XCrec8+vqLam3TqxhWIANW++QSL/cW0sHGGJBnD1c5s+nuDoItto6CDxgk/zk6pmzxchYwZ261LxrF/c3C4+qWXz0yxva4CcZobCiKqGkaAG5NqkDV7tEUESnVW+djHADH2Y7QcP5vdjTaLG54MPIhtALbDVNld2KjSY8SQO/c4V/rykjBSHSBU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyOfUfWLB00sHWELqUwZcMuAvkqk0q8P/H1ugK6rb3Y=;
 b=Vm8GdPWjwvP7N8L8CMb2AgFZB9U0eTdoiBpgSXK3adwdzY7cGP1mb21v97dNE6hPkxo8X0LxE8hL8z2R4VV/1JG+hVVYB8poOnuTfiqRAttaLlwAynOKU3At6FlzfDcVFf7PmiCujy0cGq31KOxoPSjUN88CA0Cvs2LA/RPJNGqCJKsRRS0d39ro2DFJnR4UAxUxrh0jvdaA5L2dpLe2Y2Mc2s4JUyv+mRgC7lPeCkIXG39V7VeD2zFCuYXsBF7D/hUJXt9j4KVUTHawB+MhN3qB+DjtZV/5IS14xI+q8LhXEuF6rF2e/+axFDB+XGETXYTG235QMhmGivxzo6W5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyOfUfWLB00sHWELqUwZcMuAvkqk0q8P/H1ugK6rb3Y=;
 b=pVJ6NUD4tdCix+1JSwgtjToaVzKM+ec7hUV8j9MfFWjGuhsJDM5daORQBc3R+SPhOKPp9GKAqkYaoikcscBux+rgjgnI8jOQ2Tjfk5hMa/AOCO/UWVhDHvG3bQ0vmg5YjgglqyOIEB4wWbh9IQ8yhS/jFKNmH+slUgSQXjrn/fY=
Received: from IA4P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::15)
 by SJ5PPF2BE4E177D.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::798) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 10 Apr
 2026 21:53:01 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::b) by IA4P221CA0012.outlook.office365.com
 (2603:10b6:208:559::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.44 via Frontend Transport; Fri,
 10 Apr 2026 21:53:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 21:53:00 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 16:52:58 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Apr
 2026 16:52:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Apr 2026 16:52:57 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63ALqvTE2073505;
 Fri, 10 Apr 2026 16:52:57 -0500
Message-ID: <2aec366c-ccf1-41e1-9fcc-242a9b525ce1@ti.com>
Date: Fri, 10 Apr 2026 16:52:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
To: Fabio Estevam <festevam@gmail.com>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>
CC: <u-boot@lists.denx.de>, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Kory Maincent
 <kory.maincent@bootlin.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>, Parvathi Pudi
 <parvathi@couthit.com>, Basharath Hussain Khaja <basharath@couthit.com>,
 "Paul Barker" <paul.barker@sancloud.com>, Simon Glass <sjg@chromium.org>,
 "Anshul Dalal" <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
 <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
 <CAOMZO5A7EG1KUV3jebrX0jQ8CvJ_QJxS4dTk5KQH0vLHk0_3VQ@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAOMZO5A7EG1KUV3jebrX0jQ8CvJ_QJxS4dTk5KQH0vLHk0_3VQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SJ5PPF2BE4E177D:EE_
X-MS-Office365-Filtering-Correlation-Id: 6300b5b4-95eb-410d-79f6-08de974b8894
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: gPMNM8ePxXF3wefrp9jKhRqEIaEdrQumcOpGw/bUn64POaYoZDBt4nSi73UVYrFH3KyHGiZVDyel0KhncqCvqjW5tPrbLa/LNVsTV14P2ySgksqFVBsHWNvEfGe7RvNfz0+D0dLhsUzKgzQtHgdIerJfcreBRySLFzt3j9usP8VaISomjt0kGPgzcSwuWmE81TDtnDVLx8e5mhyP/qsjLQHQ8lNi3hZFk+Cuu73JZS6fZDg3m5spsSJRGhHsxrjP4p83eWtddZujPQslJ9ygLB9hyV7xB2DPx7AYxEaWfunc2KcD1aAw0Tpg8u/hs0W9aX9Ne2FNm/SSkiKRSQo7SafYuGkLejcgoLn9r9Wma5wnwKCmOhGZOHi6nV9C6TrNj0IrOfxiFMzDzbuVZ/9a+gM29QT3R1GtO1mwBaiYtXq5uez88wdHgesUOBtTYKoUeJS0rn0WRHDWlMygy8Ake2KaAl7bxujMawktOAHVNBzXuLlXEjXwbjGXd5HzCneCVBdg3KoKmRYm85CZgfpZSpD/Ht5gU98an6ke+nnO7CaI99nOdO7fqIUOMXehVlKMc2PAWS4+WgHiQFWbWIg2eZei9pjUdqGiA5k9sGglDI8z1mQJay3z5ynFMEaemlbOrm1n1w+Raa0dnDxQnVF/WhDRq9rQiYThlPQHY+xJ7kqS0f0vYdOkiCLcGTZpwjmniuAvxXVGHckYV1B1+l1Wq5WDEU15fbO7hpXpfA7PmsaOVbBiaHAv3eNbJMpoRTYOuvNzJKn7A7OXTG2pyOqXbQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gab9Eum1FfP6oRDs5PUz5dgTGn1vHzsebRmfXheZ+TFA0StIgGJcAdmq9yEkOw2pGIGcZoa4UzLs032l3UF+etoPfiTmilpew9cSh5IgForKxG1nBBGychSgypgENlhoJS+VKtMdxVonOFQ6fY3h574myK+z/AuvBs3IdcXAlsAwqZlISqfN+GPGASAH5+kmhjnq1HEkI5l7Iqj59QYX8Zet0XHFBGkgi7Y9t9rk2d3DC57L26LjdEPvpYW9rqaneaig1iBSV516nLsCpLIR5CPKvHtPTzplFZBZ9kfqjxF0DinLupOfj8bjQUbG/xrw3BHJ0V6L0u2rJ9GRzqL4TQzCJTRzFTlNjz6CP3qgoBgKv/tL0bYzCJuc7+LhOvXmh+ZQ8Jv5O1kWZgLtOaZMEL3UOobLgXR5V1MBVGyKa9tSmItQ8EpHUKEgf+KdSIWH
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 21:53:00.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6300b5b4-95eb-410d-79f6-08de974b8894
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BE4E177D
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

On 4/10/26 2:57 PM, Fabio Estevam wrote:
> On Fri, Apr 10, 2026 at 10:34 AM Markus Schneider-Pargmann (TI)
> <msp@baylibre.com> wrote:
> 
>> -CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
>> +CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am335x-evm"
> 
> You should also remove arch/arm/dts/am335x-evm.dts as it is no longer
> needed after this change.

Same for all the other DTS files:

CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-sancloud-bbe ti/omap/am335x-sancloud-bbe-lite ti/omap/am335x-sancloud-bbe-extended-wifi ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
