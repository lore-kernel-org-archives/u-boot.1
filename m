Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CADC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5FB867F6;
	Tue,  7 Nov 2023 13:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3C7a5ov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C44C87185; Tue,  7 Nov 2023 13:39:11 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 211F18715E
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzvP0T8CkkgijLOz1qEOIwk+kGNd7ZZnOJ/jPb4urqesx9Rz3jl2tEYiZLhOC9YZpou54XjNATceZQN1+GkcoBS7S9SnOq/hr8iyd3XFd8NuJEeXnghGGKyOhhCtEmnK1ZFXkwvRvYBsCBght/JApPSf2N5HoqAR4yiWvTbjiUrdua4A8P3TcAlVW49OvwT2Zr6R8LcjL8sfEBKTgYjpEhXwvkqlxbnFjs5x97jbBNKQ7HcyXtPbRYh5+BQY/OnOWbOWyKoa5o2VSNCXvjS/N0zaZU6V6iq19ZH9BQyO2Vngdrqi2CSrOJr4yNLBO/inqjalRFAMn3quqrNfPzTN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0HeNvwOGkbP4j8NIAuJNIUxx+NyYNQLTZpsxkjPpvM=;
 b=ltDX/Gwg1ZEADNzeO41VtlqZk8pv1NshGfnbdiVvZD+mk94ssi9YVz/HXD0rSD1C/9TLD3GNVQL1SFi1rVs/vNpWWJ3Sz+12HDnJo3e8JSNXVWkj9zkxDEeMFxIACXwGJR2B9No5DSD9oZPtlt69Pd92h+jwK3vw7PtQF3CyGO8T9IaU4j2ifs8iAfAzirdnK9PMjM6fmkZa6QtCesj1slyvIuszcIWkj+bqKrEf1uK6NppmuLrLgpxANWsYkVYTKBcal+LsjDesd3WLFhikrCgncNZ4fyxV9XtZpCrQP2cIetGEHeIB9MvwvS4m4XUvB2ejQdiCOs9ci7SYly0vBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0HeNvwOGkbP4j8NIAuJNIUxx+NyYNQLTZpsxkjPpvM=;
 b=V3C7a5ovtMOO7fhfus3aDnBtprIGfGYDdwOiJCnsDMaiI2HfSi1dr2giIekhO+hzOWjpbRpV+HXEf+RGF97qLQD3Iu/6fGOnc9lIeRkDuCs7+qELG1qBk+mru6fTYz6BUDe7Ve+6Ju9Xob4yfsruoOncaMc0jDK0m5rVBR4pkbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 12:38:59 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 12:38:58 +0000
Message-ID: <f87da956-e0a2-4d14-886a-47a3bb0b88f1@amd.com>
Date: Tue, 7 Nov 2023 13:38:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: zynq: Add partition description
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Simon Glass <sjg@chromium.org>
References: <b3c4a3eddb71aab9535b034380d0dbae770828d4.1698837725.git.michal.simek@amd.com>
 <4c3348981bba32d3892194420d78fe8621c47534.1698837725.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <4c3348981bba32d3892194420d78fe8621c47534.1698837725.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d1b08c4-0b5f-4254-2d68-08dbdf8e8382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 751oewPwIAzJiIAbMu9HuJ7mJV6G2xWzGVipon89EIby+4LzfT6ieAIJYfGDdTvm3maS4S5dL3EU6QXJizq9SjMnh8rR74EGqxEP0OlDPDmFeyV2vZfwSilEqMEbO1M926q51im/ahdINBkHrnka6pWlW6UJVMAzLQgDq6S+YhnQY0f6LLTxWKqMxBwSw6mguWyZA73KOxIyWfHhQMXycRuI85qxdOIyPgEm9kN3wkztOnrWHYDhFBYh7OVJZzaeTL9wxVUt0Wv9KNM/Elyts6VMuoRDnkEd6DMhKnGoCIR18J+Y+gSXWXQmb+RfhsAIKJwonyKpDDNgiZnbltpvUTUiKsL/x1kx4utusMN711Rlpoa8UvEuaN9n7RBxR7xPTNyS0R5pmDK+K7CV9w0N65yHF7lL2rg3iEk0peegOw6y6qHe2xBdtu6PbSffz5z2Iab4cVyiCB1ZazX2rZ5FWLJnewIMIDdWau6d8uhEUWIS7An/3E3+e8edYMqlw6A4W/GXVhw282dOmcjbTmB1bSyn+1ufhttv2DLT4YFjUkO8x2czIGCwD5YSxjZh7aoI00NDZDIVel3Zc13jhuI1iS/aKNmjZ0bUjtBOTWa1TLrP62DiQvhXdEn11t11lVSHbyEjGDsIkrMld1uixZilSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(41300700001)(316002)(478600001)(66946007)(66476007)(38100700002)(8936002)(4326008)(8676002)(66556008)(36756003)(6486002)(31686004)(5660300002)(86362001)(31696002)(44832011)(83380400001)(2616005)(6666004)(6506007)(26005)(53546011)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cks0STFyQXF5MGNXeSszV2thNEJYdGt5NUhnUWY5cDFaQVo0SUk3OWE3U081?=
 =?utf-8?B?NTJ5VGpEK0s1dUhIVWRZN2xHOFFwQ0ZJWVBVQTNmU3RIWFJNYmE3c0VLOHV0?=
 =?utf-8?B?bEh2WHBGMGo2TENEY0pENUtHd2s2VmxHQXJ6NWt2Q0dqdmYxcCtBdmx0QTJo?=
 =?utf-8?B?RVVsUFY2dzdHWXppelF1alV2cFc5QkRaWkhCLzNmRnVEUVU4QWQ4Y2I4enVE?=
 =?utf-8?B?b2IzaXZNOE9wTTE4RjNlbnZoS25CdzVSTWNWK1pMVHFxdExkbWx4REw5N0Fn?=
 =?utf-8?B?MTJqcFQwOXVxMUNGZnRCVlRKNjN4MFFiMGNyME4ybjdHR29ENUphLzVOYjI4?=
 =?utf-8?B?dzZQT2s1Smh6NWYvM1A4QU9IOEJjdjltc2lJN2tDYkd5cGpMQ2k4OCtqS0Zn?=
 =?utf-8?B?aTZrUmoraExyQkFITFl6VVhGWGZVUDV4bDc3Qkg3cGtySFFMTjRyU0dFbWgv?=
 =?utf-8?B?c2U5bEVxNklWY2s3RjNQd2JpcWFPYWRpd3F4K1ZETzJvTWNUR2RPdGZDd056?=
 =?utf-8?B?ME9FbG9MdG92T2Fpck1YWGR4amVSdmpHRVZtbE9SeUNUOG5ObDQ3ZllndDBW?=
 =?utf-8?B?Z0lSM2NjaExsUFR5WGxpTThMQVRldDBlYjBhdUJJR2srbkV2YVB2andITHlD?=
 =?utf-8?B?MEFxMERSbXN5SndDRjh2TUlCMnBoUklXYit4Z0FhWkxkczhGWVpKbE9kNC9w?=
 =?utf-8?B?TmVhd0N3TjFoL3B6WDNwRm5oV2VlaHFKQXBlZHZJVEx3ZDlTMlFSMkRlcnhI?=
 =?utf-8?B?dzkwQ0w1R0ZTd1VnUVdrSjB5V09QdWhwV0JmNnczd3NHbU9pS3g0cjNnOUZL?=
 =?utf-8?B?Q3J4Mi9pU3hQSllJVG1UZVZBYjU2QVQrNE9PSDZ4d0NtaHlGckMvenJFcjRl?=
 =?utf-8?B?ZDN1Nm13Tm82R3ZJM2FyeW1oS1lsbjZDeElEVkxIS2ZmdXBuZ24xL2V1OVhG?=
 =?utf-8?B?WkJtTVhVQnhVODQ5WUFOQjdvQlExUERpTzQ3cEtGYngvZVlaZWd3WnlRTUpv?=
 =?utf-8?B?dlgrSGUzQTlWcm55THpWSXhwbUhEZ2JwVkowdHkxNUpkb3NzdXZGMGRPZENJ?=
 =?utf-8?B?VERZTTlKYWRUakhXTlBxQ3FjYzFTOC9Ob1dxejNvRS9OcDNIZTdJczVyenBq?=
 =?utf-8?B?ZHU0ZDUrRUt3VU5oc3Z4bGYrR0hPZ1BXZUtDWXlneEhoVUZmaWZZTmFpcmNi?=
 =?utf-8?B?R3hTR1oyN1c5cTJ2WG1sV0pKSVRScGFwckR1VkZMUnhRdTlUaUNVc2kvamR3?=
 =?utf-8?B?VUdPYlV4SHBRMU1GV09Rem9zaTJ1THdjWFdTM0VqSjF0aW1lbGdQODQvL2Mr?=
 =?utf-8?B?WFJHRW14b0JnOEpzOXA2RHhkMXhHRHhoQ2VqelpadHJUUitscElBRUpSelJX?=
 =?utf-8?B?QXZpak1FOWtvUlhXQmJha0R4bE5SV2J2SGJQckRMbW1SMThaaE9nTmk2VnNK?=
 =?utf-8?B?OXliNFF2YTMycG43ZHl0TWJLSTBKZm8yTVdscDJWbi94OFhtc29XeVVFMUVY?=
 =?utf-8?B?VUUyMUNRSGlOaVZOL2lleUp6VEZhZWZYRzhtWlYxaDZVR01QcHZDSzdiRERX?=
 =?utf-8?B?T3BKWS9wZEd1MlhkdHFJS0JoejNoUHBGV21mR3lsTE03SHgrakNmSml3Nitw?=
 =?utf-8?B?czV0dXRjVU9EUGg2SDFmWkRSYVVBbnNOR3ZyRVVoNGN1emlKUlZXMzFGL0hB?=
 =?utf-8?B?NU1pSUJzejBtRk93cHJRMGM1YnIyTU5jcVYrbk1WeU9HeXozbVR5eU5kbHZy?=
 =?utf-8?B?M015aFdxanA3azJ4bXYrak5rclB1SnIzUGFqZGZDdHFGWjA1alVxNkVZM3hQ?=
 =?utf-8?B?bmh5TFhCWCtYQUNwYTV2dUsyRmhyYjQwNFZxT0dNZVdHTzd5YUw2TGg0bmVm?=
 =?utf-8?B?bGNHRDA0L3lrbWRwbnpBSGN6M21CV0tzeG1ZcWk4NUxhay9zUU5DTHN5MUxM?=
 =?utf-8?B?VVMzbXp2aGFRdWZZeVNTaDA1ZU0yaitaNlk4b3RFd3V4QzVTbFplRjI2OWZB?=
 =?utf-8?B?dUlaNU4yMlYwREVtdG9tcllrWlpVRHFKdDRlOE9CWGcvcS9jKytTMXpwQ0xO?=
 =?utf-8?B?QUs1dWkxUjJHcVNGYklEdlRvTSt6WDNQak9Qb1hSL2d6dGNBUVJ3bTVEeklk?=
 =?utf-8?Q?BH6RgHnTAKbH8wi9DkFTPPS2l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1b08c4-0b5f-4254-2d68-08dbdf8e8382
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:38:58.8912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dR+65Xyum17+IYp7rssmFlVvm4GyMkv0tvxbB3CDN4YXqNTh1ICCgtBaIezGu07y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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



On 11/1/23 12:22, Michal Simek wrote:
> Xilinx is using standard mtd partition layout for quite a long time. It is
> used for testing purpose on evaluation boards.
> Also #address/size-cells shouldn't be present without nodes which should
> use them that's why move them from zynq-7000.dtsi to nand/nor nodes
> directly.
> 
> The patch was tested on zc706 and zedboard(with also increasing max
> frequency and rx bus width).
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/bitmain-antminer-s9.dts |  2 ++
>   arch/arm/dts/zynq-7000.dtsi          |  4 ----
>   arch/arm/dts/zynq-zc702.dts          | 25 ++++++++++++++++++++++++
>   arch/arm/dts/zynq-zc706.dts          | 25 ++++++++++++++++++++++++
>   arch/arm/dts/zynq-zc770-xm010.dts    | 25 ++++++++++++++++++++++++
>   arch/arm/dts/zynq-zc770-xm011.dts    | 19 ++++++++++++++++++
>   arch/arm/dts/zynq-zc770-xm012.dts    | 25 ++++++++++++++++++++++++
>   arch/arm/dts/zynq-zc770-xm013.dts    | 25 ++++++++++++++++++++++++
>   arch/arm/dts/zynq-zed.dts            | 29 +++++++++++++++++++++++++++-
>   9 files changed, 174 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/bitmain-antminer-s9.dts b/arch/arm/dts/bitmain-antminer-s9.dts
> index 0228b4b30e5b..f5ad95a276b6 100644
> --- a/arch/arm/dts/bitmain-antminer-s9.dts
> +++ b/arch/arm/dts/bitmain-antminer-s9.dts
> @@ -52,6 +52,8 @@
>   
>   &nfc0 {
>   	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>   	nand@0 {
>   		reg = <0>;
>   	};
> diff --git a/arch/arm/dts/zynq-7000.dtsi b/arch/arm/dts/zynq-7000.dtsi
> index fb61fe98e3de..f8c786ab0b7b 100644
> --- a/arch/arm/dts/zynq-7000.dtsi
> +++ b/arch/arm/dts/zynq-7000.dtsi
> @@ -306,15 +306,11 @@
>   				compatible = "arm,pl353-nand-r2p1";
>   				reg = <0 0 0x1000000>;
>   				status = "disabled";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>   			};
>   			nor0: flash@1,0 {
>   				status = "disabled";
>   				compatible = "cfi-flash";
>   				reg = <1 0 0x2000000>;
> -				#address-cells = <1>;
> -				#size-cells = <1>;
>   			};
>   		};
>   
> diff --git a/arch/arm/dts/zynq-zc702.dts b/arch/arm/dts/zynq-zc702.dts
> index 8d47f24b757b..0106d7bb1778 100644
> --- a/arch/arm/dts/zynq-zc702.dts
> +++ b/arch/arm/dts/zynq-zc702.dts
> @@ -406,6 +406,31 @@
>   		spi-tx-bus-width = <1>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <50000000>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "qspi-fsbl-uboot";
> +				reg = <0x0 0x100000>;
> +			};
> +			partition@100000 {
> +				label = "qspi-linux";
> +				reg = <0x100000 0x500000>;
> +			};
> +			partition@600000 {
> +				label = "qspi-device-tree";
> +				reg = <0x600000 0x20000>;
> +			};
> +			partition@620000 {
> +				label = "qspi-rootfs";
> +				reg = <0x620000 0x5e0000>;
> +			};
> +			partition@c00000 {
> +				label = "qspi-bitstream";
> +				reg = <0xc00000 0x400000>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc706.dts b/arch/arm/dts/zynq-zc706.dts
> index 18963a395156..ceea982546e8 100644
> --- a/arch/arm/dts/zynq-zc706.dts
> +++ b/arch/arm/dts/zynq-zc706.dts
> @@ -317,6 +317,31 @@
>   		spi-tx-bus-width = <1>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <50000000>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "qspi-fsbl-uboot";
> +				reg = <0x0 0x100000>;
> +			};
> +			partition@100000 {
> +				label = "qspi-linux";
> +				reg = <0x100000 0x500000>;
> +			};
> +			partition@600000 {
> +				label = "qspi-device-tree";
> +				reg = <0x600000 0x20000>;
> +			};
> +			partition@620000 {
> +				label = "qspi-rootfs";
> +				reg = <0x620000 0x5e0000>;
> +			};
> +			partition@c00000 {
> +				label = "qspi-bitstream";
> +				reg = <0xc00000 0x400000>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc770-xm010.dts b/arch/arm/dts/zynq-zc770-xm010.dts
> index 17680d7f8ec8..199384bec967 100644
> --- a/arch/arm/dts/zynq-zc770-xm010.dts
> +++ b/arch/arm/dts/zynq-zc770-xm010.dts
> @@ -69,6 +69,31 @@
>   		spi-tx-bus-width = <1>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <50000000>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "qspi-fsbl-uboot";
> +				reg = <0x0 0x100000>;
> +			};
> +			partition@100000 {
> +				label = "qspi-linux";
> +				reg = <0x100000 0x500000>;
> +			};
> +			partition@600000 {
> +				label = "qspi-device-tree";
> +				reg = <0x600000 0x20000>;
> +			};
> +			partition@620000 {
> +				label = "qspi-rootfs";
> +				reg = <0x620000 0x5e0000>;
> +			};
> +			partition@c00000 {
> +				label = "qspi-bitstream";
> +				reg = <0xc00000 0x400000>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc770-xm011.dts b/arch/arm/dts/zynq-zc770-xm011.dts
> index d1e971254e51..f9a086fe66d3 100644
> --- a/arch/arm/dts/zynq-zc770-xm011.dts
> +++ b/arch/arm/dts/zynq-zc770-xm011.dts
> @@ -49,8 +49,27 @@
>   
>   &nfc0 {
>   	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
>   	nand@0 {
>   		reg = <0>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "nand-fsbl-uboot";
> +				reg = <0x0 0x1000000>;
> +			};
> +			partition@1000000 {
> +				label = "nand-linux";
> +				reg = <0x1000000 0x2000000>;
> +			};
> +			partition@3000000 {
> +				label = "nand-rootfs";
> +				reg = <0x3000000 0x200000>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zc770-xm012.dts b/arch/arm/dts/zynq-zc770-xm012.dts
> index 6e36634e3d4e..24520e7d3965 100644
> --- a/arch/arm/dts/zynq-zc770-xm012.dts
> +++ b/arch/arm/dts/zynq-zc770-xm012.dts
> @@ -56,6 +56,31 @@
>   &nor0 {
>   	status = "okay";
>   	bank-width = <1>;
> +	partitions {
> +		compatible = "fixed-partitions";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		partition@0 {
> +			label = "nor-fsbl-uboot";
> +			reg = <0x0 0x100000>;
> +		};
> +		partition@100000 {
> +			label = "nor-linux";
> +			reg = <0x100000 0x500000>;
> +		};
> +		partition@600000 {
> +			label = "nor-device-tree";
> +			reg = <0x600000 0x20000>;
> +		};
> +		partition@620000 {
> +			label = "nor-rootfs";
> +			reg = <0x620000 0x5e0000>;
> +		};
> +		partition@c00000 {
> +			label = "nor-bitstream";
> +			reg = <0xc00000 0x400000>;
> +		};
> +	};
>   };
>   
>   &smcc {
> diff --git a/arch/arm/dts/zynq-zc770-xm013.dts b/arch/arm/dts/zynq-zc770-xm013.dts
> index 582aa1f1b873..add75999f47a 100644
> --- a/arch/arm/dts/zynq-zc770-xm013.dts
> +++ b/arch/arm/dts/zynq-zc770-xm013.dts
> @@ -69,6 +69,31 @@
>   		spi-tx-bus-width = <1>;
>   		spi-rx-bus-width = <4>;
>   		spi-max-frequency = <50000000>;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "qspi-fsbl-uboot";
> +				reg = <0x0 0x100000>;
> +			};
> +			partition@100000 {
> +				label = "qspi-linux";
> +				reg = <0x100000 0x500000>;
> +			};
> +			partition@600000 {
> +				label = "qspi-device-tree";
> +				reg = <0x600000 0x20000>;
> +			};
> +			partition@620000 {
> +				label = "qspi-rootfs";
> +				reg = <0x620000 0x5e0000>;
> +			};
> +			partition@c00000 {
> +				label = "qspi-bitstream";
> +				reg = <0xc00000 0x400000>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynq-zed.dts b/arch/arm/dts/zynq-zed.dts
> index 5320b4b233ae..70bc41822e36 100644
> --- a/arch/arm/dts/zynq-zed.dts
> +++ b/arch/arm/dts/zynq-zed.dts
> @@ -55,8 +55,35 @@
>   	flash@0 {
>   		compatible = "spansion,s25fl256s1", "jedec,spi-nor";
>   		reg = <0>;
> -		spi-max-frequency = <30000000>;
> +		spi-tx-bus-width = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-max-frequency = <50000000>;
>   		m25p,fast-read;
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition@0 {
> +				label = "qspi-fsbl-uboot";
> +				reg = <0x0 0x100000>;
> +			};
> +			partition@100000 {
> +				label = "qspi-linux";
> +				reg = <0x100000 0x500000>;
> +			};
> +			partition@600000 {
> +				label = "qspi-device-tree";
> +				reg = <0x600000 0x20000>;
> +			};
> +			partition@620000 {
> +				label = "qspi-rootfs";
> +				reg = <0x620000 0x5e0000>;
> +			};
> +			partition@c00000 {
> +				label = "qspi-bitstream";
> +				reg = <0xc00000 0x400000>;
> +			};
> +		};
>   	};
>   };
>   

Applied.
M
