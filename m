Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A160D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53A183C04;
	Mon,  1 Dec 2025 17:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b5zfY3l0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6E0E83C0B; Mon,  1 Dec 2025 17:47:51 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF4D83B8C
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:47:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+LS31FwbC9qBtZAODRqc/XIY0FKG8S6iPXQEiDEm1IlohroXJv00SIB8xafB8yH1mNJxNOZV1e5lpN23E+kW/d6mrRg4OoHLcQMlK/BcDGF1G1YYvbuW9LfkhqZRQpga1Ote0HFJ7kh9egYajJMnilxS0WIiX7hRZpBg8yUcxHwXvE0VnrFy9GiuF+GzDEdtlIsogcPH8Pdqk+Jb1Uon9DK30AYUXgVIFl+V0EHQ2n3/itJ1H2wDzYopHEO2NXmRz6er1cuvwhgi57TqYkbv90fvOFpIEY4udnN9ZvaIS0M87o86fLtRj/drEZEvcz4FK5OEJnf0bFMjd1KiQGweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lP3YkudnIIJbZYHFiA/virl5XkLkfSNGdpY0OT2wODk=;
 b=jhKRERoTTfIhfXHlptQiL1NixV36hrLOH2Rm4lkeOT3wSgL9FeUMT1uv54TpPii91sIaEQtQ7o6X3asOt2WuWEF8bQFCx9ZXBf4M8hdmVzXBFmYVJOIbPxm9VVJBASJJvvbnj80iZQQE8yQrGp7Mf3ENAefOXqyoRtG5dDo9E9qWT3OW7TMaZKglq0xgZkvGgbLQ1it7U1IKQCurVNWlTiCI+Ff5s3ElLH8VqY59DifAoGUJZEHby4qQQ34EkXcTqBTT943sX54ckw3l5cnL3ox1zabjOwoVG4stKq16s8zeDTC/r9aYjDBKr4uTfYgXiGArdE8rt4E5ZROp84TZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lP3YkudnIIJbZYHFiA/virl5XkLkfSNGdpY0OT2wODk=;
 b=b5zfY3l0OaIJw4QY3x2ZNfYT+KfgAJlkr2ZzD9ybjCYJhGvLDWAcBRTBICwER5OzM6gnDiT5sksEpDE0iLROnPDJAJrGapXpW/xeYpeHAYoW0ZHHQDIbgufDzvYNaR/z/Bgd+KYlLY8cWyh2YWGtD/I5dUfsc5M79xVVzn/pw1U=
Received: from MW4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:303:16d::23)
 by MN6PR10MB8045.namprd10.prod.outlook.com (2603:10b6:208:4fb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:47:44 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::15) by MW4PR02CA0019.outlook.office365.com
 (2603:10b6:303:16d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 16:47:44 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:47:41 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:47:40 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 10:47:40 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1GlZlQ764700;
 Mon, 1 Dec 2025 10:47:36 -0600
Message-ID: <90a2a3d6-e308-4507-9706-abc68c5ce2ee@ti.com>
Date: Mon, 1 Dec 2025 22:17:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] docs: board: ti: j784s4_evm: Add PCIe boot
 documentation
To: Hrushikesh Salunke <h-salunke@ti.com>, <trini@konsulko.com>,
 <a-nandan@ti.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <j-keerthy@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <jm@ti.com>, <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>, <u-kumar1@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
 <20251201110103.845413-11-h-salunke@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251201110103.845413-11-h-salunke@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|MN6PR10MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: f284eb5a-b9a1-4b59-a34b-08de30f959a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVJwWHB3cDMzTEVSVHpSYkNtUmhNeWUvYm1NS0JhOTE4R21INlZMaGJHZ0xT?=
 =?utf-8?B?NXE3WDhyOWFhaG90RVJGdkRTRGJQbFBJTTFvdXVBR3FxcTZIZFF0YWk4d0wr?=
 =?utf-8?B?V05Ga3JheWJ4alQzdnEwT3l3KzRkSkZNY3g2dDBhbVVJWWt5LzE3ZStxSlBr?=
 =?utf-8?B?TVNIR0Q0V0t3cklXZlgzZ3FNOFNtZ1dWMnJTWjlVa1VtVVV5MFlrNE8rTmxk?=
 =?utf-8?B?UFNRckdPNmtWRjVMTUhVdU1QMElxaTlLdlFXakxyZU9xS3I3RGh4SkhWSVBN?=
 =?utf-8?B?SjMzTDQ0a1gzcWcyRjZudjRLQ0ZIcEtPQ2JDT1JKdE84aFBSMEN4ckZIdlc3?=
 =?utf-8?B?bWZFdkk1WUJ3YXFUQzc2L3lyZld5dGNSMStuc21RODZqeFpXUmlDV3hQM2U3?=
 =?utf-8?B?MWRuNmdYVkpNcDZkcXBzaFRwaEhyUm5CNDNibFYzdXlienRjYmFTa0tZeVll?=
 =?utf-8?B?UmNEK3E3cnZoUlRRbkFuTEkvRmJOdTQzcUx3b2ZKdk5yMHhPV1FUVitQbk43?=
 =?utf-8?B?VG1wckFEK0RaZ3ptRnFLTlZtUzdFcjFNWVBCV0FvLytkM2hSNGFZUXBCWWtL?=
 =?utf-8?B?V3VIOW5tMXVKTGhQVWc2QXJQOWlRYVVWTkVBQXNHSWl4SVpEQ3U1UkRwTUFV?=
 =?utf-8?B?c0RQc1NGSkdsMWtGSkZyVnRhOS9iQUV1NXpRajZmaUtxQmk2TEhyeXZkY3ZV?=
 =?utf-8?B?K2xUbkxjK0tPODhWb0lCeURXZ2xtcWoxSTFYOFVWV1BQR2dkcFpLMVdBcC9m?=
 =?utf-8?B?cVBqVlNUYVlPM0hQQU9QZEJkOHo5cnJJa2c4MHlmRnJmN3hBN1M2Y0NHZnRk?=
 =?utf-8?B?cmhrSFBQdFVkRmVFTS9uTzArSEp2L3Z5Y2VJUEorNHBjclpHcGNUYTJTUEZ4?=
 =?utf-8?B?T3V2NGpmOWJNTklYMHJzeVBEMmowQ09neFdCM3JQMXBLVlA5NVc4QVB0YUlz?=
 =?utf-8?B?RHBjaG5ESmd2VGdMZEhxN3paM3QrU215TG9QK0IyaGhEdXJaYjdtek9rN1g5?=
 =?utf-8?B?bDRnQWFjZ3pldzdSNXE0dGJZeGxVUmJaNDJEdzRLcFZ0ZHVHSGYvRi9QNFFr?=
 =?utf-8?B?THc4aXczMjV1YUp2a09ta0oxbm1TY2EwQzdBK05kWEp4N3UzUWFhMkJxL1hR?=
 =?utf-8?B?WFBuT1p6dkdPNUV6QlMrVGVEUFFYaTFNS3NXaUpuL2JtR0t4WVNmWkZwSCtJ?=
 =?utf-8?B?NGRoVS9qT0t1RGdPSnVIUW5paFB6djZLNlNxY1U0dHU0Z3NZaU0yUXdacmM2?=
 =?utf-8?B?UEdzS2h6eE5malE0NlBLZm1NaU5CSVdHYmVaU1g5dU9URFpzUnVSRldkSlZ4?=
 =?utf-8?B?KzBNcFd5a3ZiMHZsMCtqeUd4MWptM1lZNStBelFwNFBqRmpqZE5iYkNFTFNw?=
 =?utf-8?B?K2VPKyswRUhVdnAzaTc4THVpMEJBSnBiUW9QUGFaaUxodjNwTmlPbU9zT3Vk?=
 =?utf-8?B?K28wSVEyV3k3U2NsYXlGcTdTUUZuNUdKaDN6ajQzdUFDTVB1WDQwdlppRGhX?=
 =?utf-8?B?aTVHYy8zUDRub2pHWlpSL1oxcUxjYlpJQUFzRzRsUjN0VXFEYUNnT0g4L2tm?=
 =?utf-8?B?UUJBQVM1Z3VWRkVGcE1ZekRvN3VHSjlBbm9EV24xVjBKbVJVdHZUUWtOdmJT?=
 =?utf-8?B?NDExQkEvQ3ZhS0RxVFVxWDJWRURNQ3ViNnJwT254bEI4Ymg2STBDeDFnKzQr?=
 =?utf-8?B?N2lpZCsvZ2t5Wmh4R3lyS1V6ZVFpclBlTUJ3MmZhNFdqQk9rUXFCSmhUNG1R?=
 =?utf-8?B?ZUUwSFd4cmxKaTYwTkxCRDJuVFZCZEFOVVArSlJIMkZNYXVQN0wzUC9uMmly?=
 =?utf-8?B?UVlCVld0Q3JEUFZ1UVpkYmpJTzhYSmUzVXgwM09KK3V3Q1pJQ2c1TXNwVy9l?=
 =?utf-8?B?STdPL2pidldRZ0ZneTdNR0cvc3dhQmV3d1JyTitNR203WDBJNTRWdE9zazBL?=
 =?utf-8?B?UE5VSlY1WUFEUjNkbUZoUzU3QjduaDBQbDFCV0FWYm0rQ1VMeWxqUExlOVRY?=
 =?utf-8?B?dFhZWmpPNjQ0TGdMU3JJbFMreTBiQlA2Q1hFdHVKNm5WblpveVdvRlpSTmRM?=
 =?utf-8?B?NDZCVGhxaDJuNy82Z0x5QVJDYnlyUHFNRFA4SG0wTGFyUFpVTUN1dnpHTWlH?=
 =?utf-8?Q?iBcz4FiV1bk+X/qXKOZokWEzh?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:47:44.0930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f284eb5a-b9a1-4b59-a34b-08de30f959a1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8045
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


On 12/1/2025 4:31 PM, Hrushikesh Salunke wrote:
> Add PCIe boot documentation for J784S4-EVM including boot mode switch
> settings, hardware setup requirements, endpoint configuration details
> and step-by-step boot procedure.
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>   doc/board/ti/j784s4_evm.rst | 267 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 267 insertions(+)
>
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index 22442874110..0c9dad122a7 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -280,6 +280,10 @@ http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
>        - 00000000
>        - 01110000
>   
> +   * - PCIe
> +     - 10001000
> +     - 01010000
> +
>   For SW7 and SW11, the switch state in the "ON" position = 1.
>   
>   Boot Mode Pins for AM69-SK
> @@ -311,6 +315,269 @@ section.
>   
>   For SW2, the switch state in the "ON" position = 1.
>   
> +PCIe Boot
> +---------
> +
> +The J784S4 SoC supports booting over PCIe, allowing the device to function
> +as a PCIe endpoint and receive boot loader images from a PCIe root complex.
> +
> +Hardware Setup
> +^^^^^^^^^^^^^^
> +
> +To boot J784S4 via PCIe, the following hardware setup is required:
> +
> +1. Configure the boot mode switches on J784S4-EVM for PCIe boot:
> +
> +   .. code-block:: text
> +
> +      SW7:  01010000
> +      SW11: 10001000
> +
> +2. Connect the J784S4-EVM (endpoint) to a PCIe root complex (e.g., x86 host)
> +   using a PCIe cable. Both boards should be powered off before making the
> +   connection.
> +
> +Endpoint Configuration
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following configuration options are enabled by default in
> +``j784s4_evm_r5_defconfig`` and ``j784s4_evm_a72_defconfig``:
> +
> +- ``CONFIG_SPL_PCI_DFU_BAR_SIZE``: Size of the PCIe BAR for DFU/boot image download
> +- ``CONFIG_SPL_PCI_DFU_VENDOR_ID``: PCIe vendor ID advertised by the endpoint
> +- ``CONFIG_SPL_PCI_DFU_DEVICE_ID``: PCIe device ID advertised by the endpoint
> +- ``CONFIG_SPL_PCI_DFU_MAGIC_WORD``: Magic word written by root complex to signal image transfer completion
> +- ``CONFIG_SPL_PCI_DFU_BOOT_PHASE``: Current boot phase indicator for root complex
> +
> +By default, PCIe root complex mode is enabled in the device tree. To enable
> +endpoint mode, build the boot loaders with the device tree overlay
> +``k3-j784s4-evm-pcie0-pcie1-ep.dtso``.

Do you think, you need bootph property in pcie_ep node ?


> +
> +PCIe Boot Procedure
> +^^^^^^^^^^^^^^^^^^^
> [..]+
> +The following steps describe how to boot J784S4 over PCIe:

> +
> [..]
