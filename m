Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB3BCDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 09:37:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A368460E;
	Fri, 26 Jun 2026 11:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IElVmMZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECC484704; Fri, 26 Jun 2026 11:37:39 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF218404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 11:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1VXnkMX6QCihvDX5m8F8K5Dh9bDlfOParzs0GbVK+vpg2QuzA3LuzYkfXWjRSBnDxATzpO8zrdHBe3iolbtfVIOLauR6nU6NTqNN5nGF1WHEsTBK5yQDP01PFbDPq5xEmH4zCxa+/c7WDTbsLVVP7FL1GH4CDvGAG41/Az3trDicDLIP3TAyO3yYt/rBUU9DC260/+ULc+Ws6oGyOkrEB+msftA2snor34od+yAd9RYFTlk5G6ISfyVshzKs7p5i9eI2tyrkvNxRSRiFfemynT41YThT/gvmPmn472miRgbTr7aDB8csWllUSpwZ86vifZeTMmuaIVuOJq6i6KTwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H52rY0p2EtL2wLtcVUj5pQkYTJEAuXFQ6qV6u4Yl6KE=;
 b=zMRDQG0BREX63oARNznXjUFZRCnvcMJhqm7KuKP0fe+uzNpw09w8GqjxSFtkCsPppHpPWsqV31r5CKJ9ZDd81xNLKk8IKsISSdBP/avb/GCzjW9ERLCSzHCtCfk7vBI3WWUMUsTBcamFFOSLvBe63Quf3HuFjr9stQ4kO5KIF90KeZNThTi2se+0lJEZ9IovL+xASkK9aotqgaJBj7ejfxHnDivS1rvI7IayydgRCP/vLuLth3iTlqUFk+zJGi7dbEKqGC+JwrcumHltFPyzKa0OWCAuQQvhMpMKSWh41QSeJ+luamDMR9/fEv5Ozyvp7QWpza5P5R58oRTw5u8b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H52rY0p2EtL2wLtcVUj5pQkYTJEAuXFQ6qV6u4Yl6KE=;
 b=IElVmMZUO+Z2GD55olm3J5TFJTdGKTs86QRe7EfZMBJyYHYZo67ecRJZ0yJec+KEkhzo0Tyvi+FS9AW9dfWpewEWtIs9FfNpWj3HFL+zIHNQeiP52UzhYjQtbtLE3VFw6zLALvz94KELg3a+gFQUjzapMzHK5gPlFflrR9yLJnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8532.eurprd04.prod.outlook.com (2603:10a6:20b:423::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 09:37:33 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 09:37:32 +0000
Message-ID: <100d2db4-d05d-4b1c-9576-d83d5c225e38@cherry.de>
Date: Fri, 26 Jun 2026 11:37:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ufs: document the UFS command
To: raz.benyehuda@mobileye.com, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Julien Stephan <jstephan@baylibre.com>,
 Udit Kumar <u-kumar1@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shawn Lin <shawn.lin@rock-chips.com>, Jared McArthur <j-mcarthur@ti.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher
 <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 briansune <briansune@gmail.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>
References: <20260607-ufs_tool2-v2-0-f79ff26ab18c@mobileye.com>
 <20260607-ufs_tool2-v2-4-f79ff26ab18c@mobileye.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260607-ufs_tool2-v2-4-f79ff26ab18c@mobileye.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6f81f7-553c-4bef-1959-08ded3668c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|11063799006|3023799007|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nA0SEa2iNz8tlnlBAS5c3TeqmYYDAl2uvD7Vg1PHf9TSbh4CqRBr3EnfhNaFwVvIMD0UAvYKa/AIji6W4bd5DcxndsB2Es75FL2BbfFLaRcw1YMQIEMS0BFNoInJWUkBJRIu+naNUN2Uwz+F5U92QOTPb+PlFngpfdp3EpG48yyZ0MhMoI2bywAEygT9rV2fSvLHLIN9WLlQkVoGi9evgxj7xi0RUiQftlDqdl/yO1lI0VlxlVqUQFOOiaw+106AyFVPJoHwbXDHK9L+J3tXlwofmQt9Yub2WyGRs2xnTdf991Gs2zdRNX2OtGRg7EgLnmBQkS3xDHGFNQZeUVu8tM7mKNcBOzLn3upgkYLs8Yg2jS/pcsTQ/mtkbAVYY//sh5FlhqMwrqfeDDtFG3p8oC+rlez55byT+bHa7hkBehFIMd0JX9XFUAwktiz5xzOPRtJhFazEJKCnHlKJ4B2jf260iWDufhL9lbA8Nju87vSpW4G5/CyPhEq+jn2+5MdbLlDutVtHWL4GG4UCfxvvYORYVQKa4Lr9ZBWpgdBZXl1jS8uVrWEH9PuQWJjkwUrFrP7Lj05rk84eg9Q2TacTgWtFmkCpb1iq+hWzSueBaZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(11063799006)(3023799007)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFU2SjRGcUZPWUtDSFZXeFA3VU1OSmcwWHNzak1rVnhDclBzQzN0NEhTdTBP?=
 =?utf-8?B?V0tjeFRKN25nM2czaGJDMVZyNnEvSVJJOHBFV0tYWlBxSWhWQTRINWpJbmlH?=
 =?utf-8?B?elRrb0dHYi9QODl6YlgwUEg1Zk5pQ0grV01QM3dOZ2Vva3dhUWlCVjltQk5z?=
 =?utf-8?B?YTl4U0dlU0k4dDh4R3d0bXZOM2V0bFR4WFR3L2tDdGdpRmovZE1YMk4vUFd1?=
 =?utf-8?B?RERRaFJUbU1RbUh5bXB5b3lIQklnS25Pb0tFcWVqYjUvUk9xNG93RXg4MFp6?=
 =?utf-8?B?N2ZQUVlLM3M1WkpMc295U3REeDMrVkFNUzZrWTVGaG8zRkZaZEdwS052Szhy?=
 =?utf-8?B?YnN0NFBucThSMzg3KzI5S0NrOWRyWnVLSE16R0w5RzNvWGFua0QvU0U1Z2F0?=
 =?utf-8?B?czUydnp5V2pMKzROYy95SXllcWIxU0FEdjlGYUZaY3dZR3R0WTlVZVFndWJK?=
 =?utf-8?B?UzdJS28vaGNaZC9KTEZHak0vVGlEdExYMjJzUCtPMUxSVEF1eDREcVF5QnEz?=
 =?utf-8?B?UUdGSlJOeGtvdUloSUhtYXBDY2lOcFRROSs4eDl0dkQ5T3pPMnFnR1BXS2Ri?=
 =?utf-8?B?cUt4VmpyVThzc041OXZha0lMS3NHZnRHT1pqRzlKMlRzL0w1VTFZTnJId1Rl?=
 =?utf-8?B?RGlOUDk0VnVkNEp6WFFGRnR2TkdWbjlLeGtLcEdVY3VXc1pvSVhDOHlXWDRr?=
 =?utf-8?B?aFlHekJtZUEwd0tUWWI2ZFlDNllrVlNXY002dDBLVnFDd1ZjQW1TOFIwelpw?=
 =?utf-8?B?NUs1WmkzNTl3b1JSWHJ3WGpqeEJzd24zekd6clNEYUJKTGNSZzR2aWlZNUpO?=
 =?utf-8?B?Q0p6b0ZNcnZ1SWFENjJXRE5ncWkzWVkrQWViNXpZRkpXbTlNUjhGWXVONzBu?=
 =?utf-8?B?R3JjeU01R1lFT2I1bnBNNTU3bk9QaWt4UFJpaGdKbHZJWDlzV1JRZS92RGQr?=
 =?utf-8?B?a1ZwSnRKUUlmL2V1dDRaMHVuWWtab3V1Sk9qdnZkdDR1QmEydCtIMlVMOEh5?=
 =?utf-8?B?S3ZKTDhkVk5LZHNDTndUdXdhZXlpWGZWSkVnUWM0YmhoVVFjMkRPTUdBNEc3?=
 =?utf-8?B?MzZVcjV1Sy9zL1NLTGI3NDl3cGFXOVAyY2o4UUpidGVkZFdyZHUxWXl5WS92?=
 =?utf-8?B?V1l2OC9YVm5KRHpaN3RiWHBKY0RhOUdxV0ZNaFRxN0Mxb3VjSGVGTVRJYk1x?=
 =?utf-8?B?ZEZWa2lCa2Z4akdqaTUzQ0pBNkZoTE9STEJxV09iTnAvMlZjT1Z3Q3g1Y3Bk?=
 =?utf-8?B?MkM1VUwrN0Jpd28rT2luTTNBdGpUcnBKdllBai84U1VkUFNobXVLSWNIQXpl?=
 =?utf-8?B?dUlINzVYZUhkb3oyeFFZOEFCci9FU25aOUN5Si9YWHJST2R2bjFmZFNtZ0Fn?=
 =?utf-8?B?eTR0KzVLSEpOL05NYURQaDF5MnVyalJIcmlSeURXU3BFTnZtSFVJNTR0azZ4?=
 =?utf-8?B?WEFRRE03MFREc28vK05rbk1tcW1hbzBScnZwYjNoLzBZdy90SXpoWWVqalNp?=
 =?utf-8?B?Q2puVWpGcW5CelJSMFp4cWtvYW5hYUJFbUE1dW5zT2RhaEVkWm9scm1TOXVV?=
 =?utf-8?B?K1NWVjR0bGVIN3N6Vm1SUmNGSWJoV1dGRy9kN2dHQjNybXVPS0htN1dpbXdq?=
 =?utf-8?B?TldkQ0ppYjNocyt2Mk9ldGE0U3oxNkpwSDlOL0trK1laK3ZsU1ZlQVZONHBu?=
 =?utf-8?B?VkFCTmZXMGlldElvWWVKb1R2Mko4WWVXaTdIRG95UlhESEZiemVjdmFUa2I2?=
 =?utf-8?B?dy80SzhKN1lzQjBhZFNiZHRBbUJLTlF3SmZzZFRPdk9CZWNqS1ZLdDFQaUlJ?=
 =?utf-8?B?d0JwMFp0ekcveHFBQzVRbS9HYXRLTC9zMElsVTRpdlhDOVVzWWpLUG9IeXJo?=
 =?utf-8?B?YXlCWWdYSjRBLytrRGNMbzZPQkdsUzNWbTAzTjIyRzJtOFdkaldPR1o3Q3pC?=
 =?utf-8?B?UThJSE16aGwzdmZ0S21HR2N1RGN2YUhOMlQ3SjBUVlAyMFovTzI2ZHpOT0Ro?=
 =?utf-8?B?VEJOWFdpNGd3cmJPbWtkdkRvaFVYdUZtQzVMaVY5RnJIQTMyWE80b082Yzlr?=
 =?utf-8?B?Vnp2Sjg5aTVPaGFaM3FabW10WGtHTkNGZE5mRVhhY2JIUnRVSnFUN1hneVB1?=
 =?utf-8?B?czQyV3BqSmk4cGlwRStkQkkySkgyMmswc3FRSHM1a3BidCsxbHlHT29hckg4?=
 =?utf-8?B?eGpOVTNJR0NiODRURjJpQk5obnRPN2hLcWVqMEpZNkRVZVJVL29VSjFhbC9o?=
 =?utf-8?B?Y0xyTEhLSVVvL2RlV21iTW10aDlSWnRXejlJczA4dWRsVmFBbDlCWlRqSFdj?=
 =?utf-8?B?d3lRUVZsOEpRTkxKZUlLVjZtU3c5bFhRMW10WE93T3dZTk1raHZiQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6f81f7-553c-4bef-1959-08ded3668c3d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 09:37:32.7715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YLrsgbwxQlgKVd4Q/HfunwWWf3N/zYthCWmEua8DLilWk+VccVEpSreXl8cDBOiwocCwBBTNwXR3s+i/GD7bGKqjecBOhPYvNJnr1EHLgCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8532
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

Hi Raz Ben Yehuda,

On 6/7/26 5:45 PM, Raz Ben Yehuda via B4 Relay wrote:
> From: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
> Add documentation for the UFS command-line interface.
> 
> The document describes the available UFS subcommands and their usage,
> and provides a complete command-line reference for configuring and
> managing UFS devices.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   doc/usage/cmd/ufs.rst | 226 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 226 insertions(+)
> 
> diff --git a/doc/usage/cmd/ufs.rst b/doc/usage/cmd/ufs.rst
> new file mode 100644
> index 00000000000..1553bc28935
> --- /dev/null
> +++ b/doc/usage/cmd/ufs.rst
> @@ -0,0 +1,226 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +ufs Tool
> +========
> +
> +The ``ufs`` tool provides utilities for querying, displaying, and modifying
> +UFS device configuration and descriptor information.
> +

It's not a tool, it's a command.

Please follow the same template as other command documentation.

For example, doc/usage/cmd/sm3sum.rst was recently added.

So:

.. index::
    single: ufs (command)

ufs command
===========

Synopsis
--------

::

<output of `help ufs` from U-Boot and/or all supported ufs commands, 
similarly to SYNOPSIS section in manpage>

Description
-----------

<description of each command and their options, see the mmc.rst example 
for something that is likely closer to the ufs command>
<you *must* specify if parameters, functions, features, etc... are only 
available if a specific Kconfig symbol is enabled>

Examples
--------

<typical example usage of the ufs tool with the console output kept>

Configuration
-------------

<specify which Kconfig symbol is necessary to be able to use the ufs 
command at all>
<specify which Kconfig symbols are necessary for subcommands or features>

If the ufs command doesn't follow the general rules applicable to 
commands (see 
https://docs.u-boot-project.org/en/latest/usage/cmdline.html#general-rules) 
then you must make this clear as well. Specifically, are numbers parsed 
as hex values by default or not. Does it return something else than 0 on 
success?

This document is also missing

ufs init
ufs luns
ufs clearall

It documents `ufs sethba` which isn't implemented (at least not provided 
in the help text of the command).

> +Features
> +--------
> +
> +* Query and display Device, Geometry, Unit, Configuration, and Power
> +  Descriptors.
> +* Display LUN configuration and calculated capacities.
> +* Modify LUN, Configuration, and Device Descriptor fields.
> +* Configure WriteBooster-related parameters.
> +* Query common UFS runtime flags.
> +* Commit configuration changes or clear all LUN configurations.
> +* Decode and format descriptor contents for easier debugging.
> +* Provision UFS devices using exported Configuration Descriptors.
> +
> +The UFS tool header definitions are based on the JEDEC JESD220E
> +*Universal Flash Storage (UFS) Version 3.1* specification.
> +
> +Usage
> +-----
> +
> +Query descriptors::
> +
> +    ufs query [lun] [idn]
> +

This is wrong, lun and idn aren't optional.

> +Descriptor IDs
> +~~~~~~~~~~~~~~
> +
> +::
> +
> +    0x00  Device Descriptor
> +    0x01  Configuration Descriptor
> +    0x02  Unit Descriptor
> +    0x07  Geometry Descriptor
> +    0x08  Power Descriptor
> +

What do they do.

> +Configure a Logical Unit (LUN)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs set_lun <lun> <parameter> <value>
> +
> +Supported parameters::
> +
> +    lu_enable
> +    boot_lun_id
> +    lu_write_protect
> +    memory_type
> +    data_reliability
> +    num_allocunits
> +    logical_block_size
> +    provisioning_type
> +    context_capabilities
> +    lu_num_write_booster_buffer_allocunits
> +

What do they do, what are the allowed values.

> +Modify Device Descriptor fields
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs set_dev_desc <parameter> <value>
> +
> +Supported parameters::
> +
> +    descriptor_idn
> +    device
> +    device_class
> +    device_sub_class
> +    number_lu
> +    boot_enable
> +    descr_access_en
> +    init_power_mode
> +    high_priority_lun
> +    secure_removal_type
> +    initactive_icc_level
> +    queue_depth
> +    write_booster_buffer_preserve_user_space_en
> +    write_booster_buffer_type
> +    spec_version
> +    manufacturer_id
> +    periodic_rtc_update
> +    device_version
> +    psa_max_data_size
> +    extended_ufs_features_support
> +    num_shared_write_booster_buffer_allocunits
> +

What do they do, what are the allowed values.

> +Modify Configuration Descriptor fields
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs set_cfg_desc <parameter> <value>
> +
> +Supported parameters::
> +
> +    length
> +    descriptor_idn
> +    conf_desc_continue
> +    boot_enable
> +    descr_access_en
> +    initpower_mode
> +    high_priority_lun
> +    secure_removal_type
> +    init_active_icc_level
> +    periodic_rtc_update
> +    reserved_HPB
> +    rpmb_region_enable
> +    rpmb_region1_size
> +    rpmb_region2_size
> +    rpmb_region3_size
> +    write_booster_buffer_preserve_user_space_en
> +    write_booster_buffer_type
> +    num_shared_write_booster_buffer_allocunits
> +

What do they do, what are the allowed values.

> +Query UFS flags
> +~~~~~~~~~~~~~~~
> +
> +::
> +
> +    ufs getflag <flag_name>
> +
> +Supported flags::
> +
> +    deviceinit
> +    permanent_wpe
> +    pwr_on_wpe
> +    bkops_en
> +    life_span_mode
> +    purge_enable
> +    fphy_resource_removal
> +    busy_rtc
> +    permanently_disable_fw_update
> +    write_booster_en
> +    wb_buf_flush_en
> +    wb_buf_flush_h8
> +

What do they do, what are the allowed values.

Cheers,
Quentin
