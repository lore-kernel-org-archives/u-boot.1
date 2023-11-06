Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FFFC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F5986863;
	Mon,  6 Nov 2023 13:44:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+FQT1+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B80BF864E5; Mon,  6 Nov 2023 13:44:04 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE468706C
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGYIyLwraH9nFFLrY0CBDWRya1gkWFPCgQtAhL+FYhW07QHqEBBP0jyd+WeEZ2+4RnPIDvMUE5a4UCFxC6ud+XjM3wbAWZT+5wIUtMgMceNWDBTSPWB4opIERoEJcTzAIVbEXPtRpDTlfZuTlCk1MzET5uFk/caOZZ55/IPW/rt8mBqALMfc4+r8PbinMV9jUiQSjqWrE7mOIPD2hLGUo8rRcG+F6Jo7vw54cy8pZx1PVs0AcJh19Tr+5VXvo/cGd0MkpSchm4VcXocyMaNSK6d18bk7e0/0k2AdGeDQ1bblHn4K25P4BA2OD9R4rUu1uJ9ZpUJk/NHi+KyMSCyejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgG6FnZGCmBRm8c8dWcg9UpR+dpoTSvXGzj9FF6qGSQ=;
 b=aaFwmB12fNeqTCiy8p1a0KJkgBov/jpJgWR5K59ocf3/cZ+TBlufn+0M70AEnoW42eyU8sr2gjISlhx63cMSxQb0iIDx81MdJzm4F2T4o93a5u6G7T5FDf6WQFWFsL9eukAN7NWO0QR+nflV7vQ1ZYkhTNkKxJS0LWUQ8Mq+F4/6nO9q/xx3XhPsdVvCG+CYwSzV/vRZDzY76/Vx1hCGYJVZzR9BzrpnFa1M5FwqbCASkfznkB28AjI5OjayacHsT2H/4PR4FOdhNEdt5BVviI3CX6LWr0/2+P+cVEmNIj8kNmzT4A8jGFLaEDKsbRPHwlGVXhfLuQUzoLwD8rEbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgG6FnZGCmBRm8c8dWcg9UpR+dpoTSvXGzj9FF6qGSQ=;
 b=S+FQT1+xyzohwxhkQxqCM6Mwntm3Khp2a4gOp8xRue52U5PI79IOLtoceSZzgeA0P5MGUzI2i+N+4GBigNT0V/ueyb8JvtFW+P7Zot3tY2obioQX0R4HWt5GIZ+OlRV4QEl8qvSE03YXNH4A5Owvty+b1OHbCALbgVNyEUn3z3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 12:43:55 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:43:55 +0000
Message-ID: <d7393cdd-d580-4c5d-bb04-0c770e3e15a2@amd.com>
Date: Mon, 6 Nov 2023 13:43:54 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 0/4] xilinx: Add DTSes for mini qspi/ospi configuration
To: u-boot@lists.denx.de, git@xilinx.com
References: <cover.1698329087.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1698329087.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0020.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: dd45d424-c4c9-4533-5df6-08dbdec60993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7+l3hksS18zgscJNVIB/6r0YGKn7QuVLBTuoRk4L58z21PZRw+vY+6YOkZ/mbg5ALzv39U7B8/im5xVJLlq1CkE1OBJA7vkWPTd8HKEs261En9NKHdNNmsGSJYo13tOiIxjlD1dpJck4GuYA0GGVRNbDzAqjCne48UT8xQfYop2oYOpTTKo+R4sv4ZIUPzZ4E3JmiFmWkIwCO9zJb3ftRPH2cPcbS7D5Pyh2xIgXgwQDI9hhi6NXnuQg06OaCViZqMLGeAhdVq9ptT8cOFcimgTrN8FDWbZ37xbiv3ThQG1LzEeuTTo5nqKp6lV6Z+ss1ZJe78Z9SdGomiHlhajqDPCAQdFJAhigt5ns4idjpTHLRm692OLkuutxFl98eEguFKoPPtcczXgzW3RUOli3Sb5AxBv+GDRzrxSiKihQpguuuHQTNZODG6lYHeoODiDBs1R+xqaO0oBR/OgQoQLM0/UbgUGexH88JVPgFxUgFB2PjR8NmVZS2xE7nc88kgkt9hDezj2wzIpHNYvILYWbde3Gr/N3WOGdDMGIcxjF3qJggXEE1EOrhM6q/oVcn2o3BiEmeX9z1KvBqS4bBlYvkFj+/5eY7LdYgc71KrvfTvIL0ZqrUJVxquTQ3H72NEQ23jVba98DkhfRnw8UcZLJey27R7RKY1BGe+2WfeX2d75+M7Q5ntEWWCF6FQUj3X59LiIA+Dnre7mL+urCH+0wl/eHNAkm1g61b/VlUwg1gQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(8936002)(8676002)(36756003)(41300700001)(2906002)(5660300002)(38100700002)(31696002)(6486002)(53546011)(966005)(66556008)(6512007)(66476007)(31686004)(86362001)(44832011)(316002)(66946007)(26005)(2616005)(6506007)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVIxQ003aVhVS0QvRmZpaE1Ha1gwZU8wclU4bEwraXk1Z2FCNklONlVxaVZU?=
 =?utf-8?B?N0Z0dTM5T0hZTDFwMXFRaHlla1hRUkNnL2dNUWRwdlp3ZldIbnNBczJRR0xL?=
 =?utf-8?B?SHdZRjd5NFFuRVlEZW5GN3hNZmMwNE45UlhZcS8xS1hTdUdpSlZQaGFNNlJH?=
 =?utf-8?B?eEs0RFVRSlZtZkpkcmUrbDU0V3RHb21WOWJJUTJ1aGRlVUJidFpFUTBhd1FN?=
 =?utf-8?B?d0p3L1IrVWplczB4azZQVlZsNk8zdjV0eXJ2akd5dHphY0ZBblgrWGY1dzZy?=
 =?utf-8?B?RThNc3lFbmxkOFFYNVNXdEMySmNTZ2VrVGo2V3Rua1MwNW1BbkdvWUxPUXRL?=
 =?utf-8?B?ejdpVzRjSk9EY1NEYzRvNGgxMENBdE5ZVHJDMndZTklJM0tnNlFrcHlFb2x0?=
 =?utf-8?B?NS84ZmprMGhsNVE0YTc1aEx5b1gvZU1ra2lxWDBMR2JBdUhlZW5OeHFyWWph?=
 =?utf-8?B?a1dHbWsyNmp0QVJZOHc4dzBpRHlIVnl1Nkg1SUNGWjBkQUZpSlJjNS8zd1Zy?=
 =?utf-8?B?OXJjQmE4b2dzbzFNQmpza3l1YXlXQnFVVHF0NVZYc3lScHVkanY4bW5MYm1V?=
 =?utf-8?B?QzlkNTlRYnBNTFFidWlhV1UxQWhHdy9PeVJVU3h2eWdmZnN5a01JaCs4TUxr?=
 =?utf-8?B?eWVlaTczTUZGL2xNdXo1WXEyNUpRYm8wbGgrQzVjYVZjbVhOQTM5ZnZGcURk?=
 =?utf-8?B?bWtidFo4QXltV1ZwVzVpRkZXSmtGYkoyZm5RMGFMaFA0UTdGQ1hWUU5FaUg0?=
 =?utf-8?B?TFRBTlpmVW42Y3RhM0hRVGUxNU9lSitDVXhoZWRqLzAvZHZlS3BrWmhnd2py?=
 =?utf-8?B?dVlrZlNsUTkrUkl3d0htVm8yM0JuYi9Bc3hBKzhPWWl3WnFPcjREc0tnUElp?=
 =?utf-8?B?OVBxL2g0b01lSEpabGFERVdIUENxUlN2c09pRHVaek8zbmsrb3hSUWVvbEFY?=
 =?utf-8?B?U3lBWE54cTBWVDVUcHRiaXdLdzE1VXgzOHZzYXg5K3c1VGF5ckR6SUJielBp?=
 =?utf-8?B?dUZ1TVhXN0tRdkdFa3BVWit4MHpnWStvYWJoUG1QYzhFT0ErWis1OVVDcWhR?=
 =?utf-8?B?QmpRblFHbnVQVk5FckV6MnVkaldUOUhKQThxeWV3bk0xaGZhVGUyMUU4TU1t?=
 =?utf-8?B?c2VQdGFacTdCR3ZhWnRuNEdaTkIvK0FvQjNaQTJsVkxZdGNDMEhpSlBkNUVG?=
 =?utf-8?B?WTlSTzJqSnkwVmhEa2MwaDZhT2MwcVZITXkxZC9FYVorVjIwRUhEc0N0OExq?=
 =?utf-8?B?UzhHd0pqRTU5aXcvSVovRzdxQWdxWVJ0a2tiUkVBMlZJU1lQR3FYMnFySnI5?=
 =?utf-8?B?MU9wb0x6dDVOOExXN1ZUdnBnSjlOakNrTnpxZUVndGlDSmhqTjB6cFloT0Jy?=
 =?utf-8?B?RVJrOU9xcGNMQ2ZvNjcvelRNUG9yVkpRUkl4K2tBOVRjMnEvb1oyK2dVMjNV?=
 =?utf-8?B?YTBJQ3p6L2ZzV3BnTVpKK3hxSDhjYXhlZmhOZVA2dE9pT3FZNERRY1NiU3p5?=
 =?utf-8?B?OG1ybzY5VXRPQ3FsaFBTV3RTZDhJODBKTkJ1WktZcFdXc1NRK3A0dERsVXJw?=
 =?utf-8?B?eUhUdVZYZnBBUjBZaXFqM3JyUFh0U0VPTE5KNWpuUTdML3VWb0pLTDdCYkpx?=
 =?utf-8?B?bGhraWVtZ1JIQmhhL1ZsL3BYdU1OYzNhNXE3NVg3MERlNWNxYWJGbDEvZVEr?=
 =?utf-8?B?Y2d4UUZvZzdNVXpOaVJPMnBkeTNlZktqbFVkdnJhTkZLWitHeEJSN3dIa2hR?=
 =?utf-8?B?UzN3YVdMQWNFbm5OSHhpSEhuVkg0SXJXUzRCSVVqR09YM25Mb1I4cTA2b01G?=
 =?utf-8?B?UkVrZmY1RlpqYjR2THh5QkdjSDZGK3dsU3dLNjYxemZ1QkJEMkwvUkJ1MXhN?=
 =?utf-8?B?MmlnaEFrV3FPWVVPVFpyK01EWkRYNExWZlJ1N3lBSFBxWlVaNy9jSjVCMDdX?=
 =?utf-8?B?eExIYmpja2IzbStqbHlIa3E4b1hTL3RSR2lSR1FmZzJzVDlsQ1h4UWdRcDYz?=
 =?utf-8?B?OTJvWmZqU215TGErell3Vk1qODZaNndXNUhpTkJEWk9QTHgxTHZLVERLYlJ0?=
 =?utf-8?B?ejlwdGsyZ292cVVOUFUybFZScUdNNGhXUGd6V0FSWUxTenBzQUxURjlVVXdT?=
 =?utf-8?Q?ACIl8CKK6YowSjeFpTlXjvHco?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd45d424-c4c9-4533-5df6-08dbdec60993
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:43:55.0966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWGuP/z6OjGV5hKCYsSEqpTsqw+Q5AWKii+B7tUs2EacMz77l3j5UQVFWBbGinrA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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



On 10/26/23 16:04, Michal Simek wrote:
> Hi,
> 
> we are using U-Boot mini configurations for years. We already upstream
> configurations for mtest, single qspi/ospi or emmcs for all Xilinx SOCs.
> But we didn't push configuration for different qspi/ospi configurations
> which were missing upstream dt description. This has changed some time ago
> by:
> https://lore.kernel.org/all/20220126112608.955728-3-miquel.raynal@bootlin.com/
> 
> and we are also pushing support for it in core here:
> https://lore.kernel.org/all/20231020031817.267959-1-venkatesh.abbarapu@amd.com/
> 
> that's why it is good time to also upstream description for these
> configurations. Functionality depends on core changes but description
> itself is independent of it.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (4):
>    ARM: zynq: Add DTSes for mini qspi configurations
>    ARM: zynq: Add DTSes for mini qspi configurations
>    arm64: versal: Add DTSes for mini qspi/ospi configuration
>    arm64: versal-net: Add DTSes for mini qspi/ospi configuration
> 
>   arch/arm/dts/Makefile                         | 27 +++++++++++++++++++
>   arch/arm/dts/versal-mini-ospi-stacked.dts     | 22 +++++++++++++++
>   arch/arm/dts/versal-mini-qspi-parallel.dts    | 22 +++++++++++++++
>   arch/arm/dts/versal-mini-qspi-stacked.dts     | 22 +++++++++++++++
>   arch/arm/dts/versal-mini-qspi-x1-single.dts   | 17 ++++++++++++
>   arch/arm/dts/versal-mini-qspi-x1-stacked.dts  | 23 ++++++++++++++++
>   arch/arm/dts/versal-mini-qspi-x2-single.dts   | 17 ++++++++++++
>   arch/arm/dts/versal-mini-qspi-x2-stacked.dts  | 23 ++++++++++++++++
>   arch/arm/dts/versal-net-mini-ospi-stacked.dts | 22 +++++++++++++++
>   .../arm/dts/versal-net-mini-qspi-parallel.dts | 22 +++++++++++++++
>   arch/arm/dts/versal-net-mini-qspi-stacked.dts | 22 +++++++++++++++
>   .../dts/versal-net-mini-qspi-x1-single.dts    | 17 ++++++++++++
>   .../dts/versal-net-mini-qspi-x1-stacked.dts   | 23 ++++++++++++++++
>   .../dts/versal-net-mini-qspi-x2-single.dts    | 17 ++++++++++++
>   .../dts/versal-net-mini-qspi-x2-stacked.dts   | 23 ++++++++++++++++
>   arch/arm/dts/zynq-cse-qspi-parallel.dts       | 22 +++++++++++++++
>   arch/arm/dts/zynq-cse-qspi-stacked.dts        | 22 +++++++++++++++
>   arch/arm/dts/zynq-cse-qspi-x1-single.dts      | 16 +++++++++++
>   arch/arm/dts/zynq-cse-qspi-x1-stacked.dts     | 22 +++++++++++++++
>   arch/arm/dts/zynq-cse-qspi-x2-single.dts      | 16 +++++++++++
>   arch/arm/dts/zynq-cse-qspi-x2-stacked.dts     | 22 +++++++++++++++
>   arch/arm/dts/zynqmp-mini-qspi-parallel.dts    | 21 +++++++++++++++
>   arch/arm/dts/zynqmp-mini-qspi-single.dts      | 12 +++++++++
>   arch/arm/dts/zynqmp-mini-qspi-stacked.dts     | 21 +++++++++++++++
>   arch/arm/dts/zynqmp-mini-qspi-x1-single.dts   | 17 ++++++++++++
>   arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts  | 23 ++++++++++++++++
>   arch/arm/dts/zynqmp-mini-qspi-x2-single.dts   | 17 ++++++++++++
>   arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts  | 23 ++++++++++++++++
>   28 files changed, 573 insertions(+)
>   create mode 100644 arch/arm/dts/versal-mini-ospi-stacked.dts
>   create mode 100644 arch/arm/dts/versal-mini-qspi-parallel.dts
>   create mode 100644 arch/arm/dts/versal-mini-qspi-stacked.dts
>   create mode 100644 arch/arm/dts/versal-mini-qspi-x1-single.dts
>   create mode 100644 arch/arm/dts/versal-mini-qspi-x1-stacked.dts
>   create mode 100644 arch/arm/dts/versal-mini-qspi-x2-single.dts
>   create mode 100644 arch/arm/dts/versal-mini-qspi-x2-stacked.dts
>   create mode 100644 arch/arm/dts/versal-net-mini-ospi-stacked.dts
>   create mode 100644 arch/arm/dts/versal-net-mini-qspi-parallel.dts
>   create mode 100644 arch/arm/dts/versal-net-mini-qspi-stacked.dts
>   create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-single.dts
>   create mode 100644 arch/arm/dts/versal-net-mini-qspi-x1-stacked.dts
>   create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-single.dts
>   create mode 100644 arch/arm/dts/versal-net-mini-qspi-x2-stacked.dts
>   create mode 100644 arch/arm/dts/zynq-cse-qspi-parallel.dts
>   create mode 100644 arch/arm/dts/zynq-cse-qspi-stacked.dts
>   create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-single.dts
>   create mode 100644 arch/arm/dts/zynq-cse-qspi-x1-stacked.dts
>   create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-single.dts
>   create mode 100644 arch/arm/dts/zynq-cse-qspi-x2-stacked.dts
>   create mode 100644 arch/arm/dts/zynqmp-mini-qspi-parallel.dts
>   create mode 100644 arch/arm/dts/zynqmp-mini-qspi-single.dts
>   create mode 100644 arch/arm/dts/zynqmp-mini-qspi-stacked.dts
>   create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-single.dts
>   create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x1-stacked.dts
>   create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-single.dts
>   create mode 100644 arch/arm/dts/zynqmp-mini-qspi-x2-stacked.dts
> 

Applied.
M

