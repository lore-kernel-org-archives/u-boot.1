Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B69D49203
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 09:41:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066BB89438;
	Mon, 18 Nov 2024 10:41:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="PYd1s8jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA41789433; Mon, 18 Nov 2024 10:41:34 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20706.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::706])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C3B489439
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 10:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6zJP0+l20ywdnfICJrWm/G0VX+GEfYa9INY8OkXIvo7REFBNIMR6Z6EnCDk99tESkPHJqJqkWrUjG0LSFBdRIZJkUZTqvujYqsoY8i587AIzsJkq+wZP+VSEU1i2lmz5pfxLT+oLrwnDfk1EPGaLVd59Kq/GHjlDaxlTMFpnCYLGIxVob0ihU8cMir4HAbXNaPUjpVX81CPEOtLnYOc90NJ2kulbJ2vpV+teiZyOlqjBXjuz6gCCdAVcG1eIp1ghYTPzE7bIKYbw41uSbuMn3Zi/ZSKauWoIjtxim92vrua8hBl9x/Txp0tmKuD4aPdBRKvk4dOgtKGp/nbTItjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ars57QcxUTJlzoeyWiIfmXF4gc9W7q5sdjcFbuh2rcc=;
 b=HSKMEfvDtBTyGZWSw29ufFNpLF3gXxEOjXZvWKxQNtTWI1LUQalXGa+2h2NmJ9loNp59/agDT/I2Pgzw/1STJBNps/mvWG1uO8XSuGR0ls0iTYx1Pk6REeVCMy33aUTREi3cm6FC2bMFr9nVtnvY1TtKbq+IqYQ+1Zb6MHLoJHaXVmr4uNs+5jayaf1xIumMS5maK7zxOqGIdCUPU+7nc/yIavQNJ3o1UJHNS8SqnQDFdv102wOq3uA13WXQ9u1yf0+Qk6aP8RcvSQP7WB8PkdOp7E4pXV4rblWKTi+sco5DsEUVsxNMiGku8EwyHRvQm8ijBgcUuv86zCClAkflVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=phytec.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ars57QcxUTJlzoeyWiIfmXF4gc9W7q5sdjcFbuh2rcc=;
 b=PYd1s8jhZVJELKdeGJqwJR0HSRzZSYi75Kt4+8/wh6rKi5+QP7dG/xWT/fQD76pUlanAcLpGuZuerEzevxDEXLUxIFGWsx/yzWC+LwwRcwyX61VwRSmcTN0iYxu2etZexwKJZLu/AOJlJsEgXOu2cKLNikkyWXcaFgkTQqlVrr4=
Received: from AM8P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::12)
 by PR3P195MB0815.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 09:41:29 +0000
Received: from AM4PEPF00027A68.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::6f) by AM8P190CA0007.outlook.office365.com
 (2603:10a6:20b:219::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 09:41:29 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A68.mail.protection.outlook.com (10.167.16.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 09:41:29 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 18 Nov
 2024 10:41:28 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 18 Nov
 2024 10:41:25 +0100
Message-ID: <2f7bc755-2df9-4432-9de5-388ab58ae0de@phytec.de>
Date: Mon, 18 Nov 2024 10:41:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] doc: board: phytec: Add phyCORE-AM62ax
To: Garrett Giordano <ggiordano@phytec.com>, <trini@konsulko.com>,
 <t.remmet@phytec.de>, <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>,
 <marex@denx.de>, <festevam@denx.de>, <jonas@kwiboo.se>,
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>, <n-francis@ti.com>,
 <d-gole@ti.com>, <afd@ti.com>, <sjg@chromium.org>, <bb@ti.com>, <nm@ti.com>,
 <d.schultz@phytec.de>, <nmorrisson@phytec.com>,
 <francesco.dolcini@toradex.com>, <vishalm@ti.com>, <vigneshr@ti.com>,
 <y.moog@phytec.de>, <othacehe@gnu.org>, <m-chawdhry@ti.com>,
 <j-humphreys@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
References: <20241115195055.3023365-1-ggiordano@phytec.com>
 <20241115195055.3023365-3-ggiordano@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241115195055.3023365-3-ggiordano@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A68:EE_|PR3P195MB0815:EE_
X-MS-Office365-Filtering-Correlation-Id: 736fce78-a63b-4777-1037-08dd07b52dae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2cxbzJiMkNJSWc4amNOcnp5b01jN3V0b3pscGlzbGRKNUduQTNGaEMzUUcw?=
 =?utf-8?B?V0gyQTkvTHV0ckFycmdlWnpmZFBSUmRSWXNkME84SzVIb1VYaWZLNG9iTStC?=
 =?utf-8?B?d3dDaFhLWWNDaWJhcG5TSFY1ei9Kcy91RmRvOWoyUGMrMm9PVjE5SlJnV2g0?=
 =?utf-8?B?UUZJVXBmcGx2TEcwcWFqQmpVWEk0NkV6WWY3SjRTYlNkYkpEbU5rTU9MbmZo?=
 =?utf-8?B?VDd3ejd5c3NBbktodGlJa3RHK05EbDJ1K09CZnphOTRtNHE5c0JoWUE3R0Zs?=
 =?utf-8?B?Q0N6NGtvVWEvbWJ4UnE4WXZmL293YmNQU25JemNGelpvNThmWEF3bkMwb3Mw?=
 =?utf-8?B?OFJqZDMxc3J3WXJoMUlXcHJEN1UyVGRjR3BIeko0WVl3TmFxVjFwdUVNWE82?=
 =?utf-8?B?TXdaYmYxUTVtZEhPMUVseUk3K1FaZ21JYWtYaVQxTm9BdGszQVpKajJOTlIz?=
 =?utf-8?B?M0lCQWhVSU12TXVWTVZDL1k4cVJLdmh5NjIxb0h3dEZJNzNVOUN1bXlCVk9o?=
 =?utf-8?B?WjM3d3hzR2hvdjg4eWZLdUxRQVhDTENsMDRjanY4SkZHUHcrZGxQbzlCK3Nk?=
 =?utf-8?B?clJvVXhsSW1YUUJnTzVlejZHK0FnK2dYV2ordkM2bWo1dmFIWDVSNVF1ZlRx?=
 =?utf-8?B?N1RRcThzYkxMZjFNYXNpVWtZMzVKTGlPMDRiYno1UGhZSjRId3VodmlEcmly?=
 =?utf-8?B?UTZKRjNuMHhHMUFPMlZ3bE03U0pEbkI3azNKMDZJeDBzcy9nSnhqbTc1ZlRx?=
 =?utf-8?B?aXdOcWVtNkhDNGhjbmFQa0FLa090SGtFUEwxeG5kUVVROFF6MCtWS2tyY2h3?=
 =?utf-8?B?ODRHcnpvWWRkcHlTM3BYanBFUDlQRzVieG52OVpaYmx0UU5tT0ozaVhEeU5k?=
 =?utf-8?B?SmErZEF5SmNRRXVxanE2QlVRYlVvYklKdUNnZXp4eHcrVzdSSUI4VlovSGFU?=
 =?utf-8?B?eXpIQjRpR2U2RDNBRkd6RC8ySzk2RUFFMUgwVjJJRkFOdVoxRkNCVXZ0ajRh?=
 =?utf-8?B?RjB0T3V4OFM3TEI3Wis1bFFqZEg5TjlHOUdjVlNHRitEMHVFYXhkaDczS1hO?=
 =?utf-8?B?YWx5NlhzaE9rQmM1bmJjekQ2c3MzRmgxcjZjU3dmcW1mdmhBU0M0Rk8zRHJq?=
 =?utf-8?B?WEhZVGxEVkpwMjRaWGVzYjNwN0pINHRDc3hiYXN6N0NXalNlMjgreVhOTHUy?=
 =?utf-8?B?LzZyU2pVRE5rWk5BOUNtN2JvUHVnSkx0cU9GQW8yVUlIanNtWXV5MUxYaUts?=
 =?utf-8?B?ZzE4VjY1dWVSdGNWcXVsS1ZSY0dWNTlHTGMwaEQzd3hHNFlXQkZSQkh0Sk1F?=
 =?utf-8?B?MURJcERzVkRKMnZ6N1VReVRzZ1ZVOHJ1V3kzVnZndENhNWtGVHU1dVFSbG5Q?=
 =?utf-8?B?VE9KKzgybTljaGJrT3BBaHpSVFFWZFZRODdpRmU5V3NyTHY5a1lnTVRrMkhJ?=
 =?utf-8?B?bGJuZTQxaUk0U2VQN3RFWncrVjIvQ1lMYzN3cW5veHVtUzBpemtZOVFrTkpB?=
 =?utf-8?B?WmVpcVM5TkN3d29NQzdVQk9TcHZiMmN4cElIdlphaUFLZlV5V1JQVXpXdGtO?=
 =?utf-8?B?ZS9tWExrTWpnYTVOcDFZcm9iL29CdXVKRHNhbWhzYXJSYTNIWnIvZXUrd2Vo?=
 =?utf-8?B?VEFpZVFpNGovTnphdVVLazI5YnQxbmVqQ1VMS0ZNOFRDenJ2N0RyT3Zhc2Nw?=
 =?utf-8?B?STFBRnByQUVxREJFUHdWd3RCSjZpbHp4Wmt5cDh2dmJzQ3dscmpxTDFwU3F0?=
 =?utf-8?B?SEZJSzJHMmNjRjhFaXVYQ3pad1lhNVpnZElCMkpqMDk1YmRyQTliVmdUYURC?=
 =?utf-8?B?NlVxOEh5djFVM3A1UFpYSlNQcjk2M2ZRRm9mRXZjeUdZT29ham5Nc1lWT1Aw?=
 =?utf-8?B?dEtsVms1Z1I4dTlRMnQrZEV5NHN6Vi8weVpZMFFwUHNXcmdaaUx2ZjlTNmpa?=
 =?utf-8?Q?vdk3pkcw2J0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 09:41:29.2866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736fce78-a63b-4777-1037-08dd07b52dae
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A68.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0815
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

Hi Garrett,

When building the docs, I get

   Warning, treated as error:
   doc/board/phytec/phycore-am62ax.rst:5:Title underline too short.

   Warning, treated as error:
   doc/board/phytec/phycore-am62ax.rst:66:Problem with "start-after" 
option of "include" directive:

Please make sure "make htmldocs" is working.


Am 15.11.24 um 20:50 schrieb Garrett Giordano:
> Add documentation for PHYTEC phyCORE-AM62ax SoM.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>

With that fixed,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   doc/board/phytec/index.rst          |   1 +
>   doc/board/phytec/phycore-am62ax.rst | 161 ++++++++++++++++++++++++++++
>   doc/board/ti/k3.rst                 |   1 +
>   3 files changed, 163 insertions(+)
>   create mode 100644 doc/board/phytec/phycore-am62ax.rst
> 
> diff --git a/doc/board/phytec/index.rst b/doc/board/phytec/index.rst
> index 99848a9e958..697aec30512 100644
> --- a/doc/board/phytec/index.rst
> +++ b/doc/board/phytec/index.rst
> @@ -9,6 +9,7 @@ PHYTEC
>      imx8mm-phygate-tauri-l
>      imx93-phyboard-segin
>      phycore-am62x
> +   phycore-am62ax
>      phycore-am64x
>      phycore-imx8mm
>      phycore-imx8mp
> diff --git a/doc/board/phytec/phycore-am62ax.rst b/doc/board/phytec/phycore-am62ax.rst
> new file mode 100644
> index 00000000000..baa26b5a7ce
> --- /dev/null
> +++ b/doc/board/phytec/phycore-am62ax.rst
> @@ -0,0 +1,161 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Garrett Giordano <ggiordano@phytec.com>
> +
> +phyCORE-AM62Ax
> +=============
> +
> +The `phyCORE-AM62Ax <https://www.phytec.com/product/phycore-am62a>`_ is a
> +SoM (System on Module) featuring TI's AM62Ax SoC. It can be used in combination
> +with different carrier boards. This module can come with different sizes and
> +models for DDR, eMMC, SPI NOR Flash and various SoCs from the AM62Ax family.
> +
> +A development Kit, called `phyBOARD-Lyra <https://www.phytec.com/product/phyboard-am62x>`_
> +is used as a carrier board reference design around the AM62Ax SoM.
> +
> +Quickstart
> +----------
> +
> +* Download sources and TI firmware blobs
> +* Build Trusted Firmware-A
> +* Build OP-TEE
> +* Build U-Boot for the R5
> +* Build U-Boot for the A53
> +* Create bootable uSD Card
> +* Boot
> +
> +Sources
> +-------
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_firmwares
> +    :end-before: .. k3_rst_include_end_tifsstub
> +
> +Build procedure
> +---------------
> +
> +Setup the environment variables:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> +
> +Set the variables corresponding to this platform:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR=phycore_am62ax_r5_defconfig
> + $ export UBOOT_CFG_CORTEXA=phycore_am62ax_a53_defconfig
> + $ export TFA_BOARD=lite
> + $ # we dont use any extra TFA parameters
> + $ unset TFA_EXTRA_ARGS
> + $ export OPTEE_PLATFORM=k3-am62ax
> + $ # we dont use any extra OPTEE parameters
> + $ unset OPTEE_EXTRA_ARGS
> +
> +.. include::  ../ti/am62ax_sk.rst
> +    :start-after: .. am62ax_evm_rst_include_start_build_steps
> +    :end-before: .. am62ax_evm_rst_include_end_build_steps
> +
> +uSD Card creation
> +-----------------
> +
> +Use fdisk to partition the uSD card. The layout should look similar to:
> +
> +.. code-block:: bash
> +
> + $ sudo fdisk -l /dev/mmcblk0
> + Disk /dev/mmcblk0: 15 GB, 15913189376 bytes, 31080448 sectors
> + 242816 cylinders, 4 heads, 32 sectors/track
> + Units: sectors of 1 * 512 = 512 bytes
> +
> + Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
> + /dev/mmcblk0p1 *  128,0,1     1023,3,32        16384     278527     262144  128M  c Win95 FAT32 (LBA)
> + /dev/mmcblk0p2    1023,3,32   1023,3,32       278528    1693883    1415356  691M 83 Linux
> +
> +
> +Once partitioned, the boot partition has to be formatted with a FAT filesystem.
> +Assuming the uSD card is `/dev/mmcblk0`:
> +
> +.. code-block:: bash
> +
> + $ mkfs.vfat /dev/mmcblk0p1
> +
> +To boot from a micro SD card on a HSFS device simply copy the following
> +artifacts to the FAT partition:
> +
> +* tiboot3.bin from R5 build
> +* tispl.bin from Cortex-A build
> +* u-boot.img from Cortex-A build
> +
> +Boot
> +----
> +
> +Put the uSD card in the slot on the board and apply power. Check the serial
> +console for output.
> +
> +UART based boot
> +---------------
> +
> +To boot the board via UART, set the switches to UART mode and connect to the
> +micro USB port labeled as "Debug UART". After power-on the build artifacts
> +needs to be uploaded one by one with a tool like sz.
> +
> +Example bash script sequence for running on a Linux host PC feeding all boot
> +artifacts needed to the device. Assuming the host uses /dev/ttyUSB0 as
> +the main domain serial port:
> +
> +.. prompt:: bash $
> +
> +  stty -F /dev/ttyUSB0 115200
> +  sb --xmodem tiboot3.bin > /dev/ttyUSB0 < /dev/ttyUSB0
> +  sb --ymodem tispl.bin > /dev/ttyUSB0 < /dev/ttyUSB0
> +  sb --ymodem u-boot.img > /dev/ttyUSB0 < /dev/ttyUSB0
> +
> +Boot Modes
> +----------
> +
> +The phyCORE-AM62x development kit supports booting from many different
> +interfaces. By default, the development kit is set to boot from the micro-SD
> +card. To change the boot device, DIP switches S5 and S6 can be used.
> +Boot switches should be changed with power off.
> +
> +.. list-table:: Boot Modes
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW5: 12345678
> +     - SW6: 12345678
> +
> +   * - uSD
> +     - 11000010
> +     - 01000000
> +
> +   * - eMMC
> +     - 11010010
> +     - 00000000
> +
> +   * - OSPI
> +     - 11010000
> +     - 10000000
> +
> +   * - UART
> +     - 11011100
> +     - 00000000
> +
> +Further Information
> +-------------------
> +
> +Please see :doc:`../ti/am62ax_sk` chapter for further AM62Ax SoC related documentation
> +and https://docs.phytec.com/projects/yocto-phycore-am62ax/en/latest/ for vendor documentation.
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 5d01f487622..0deb4d768f9 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -46,6 +46,7 @@ K3 SoC based boards in other sections
>   * :doc:`../beagle/am62x_beagleplay`
>   * :doc:`../beagle/j721e_beagleboneai64`
>   * :doc:`../phytec/phycore-am62x`
> +* :doc:`../phytec/phycore-am62ax`
>   * :doc:`../toradex/verdin-am62`
>   
>   Boot Flow Overview

