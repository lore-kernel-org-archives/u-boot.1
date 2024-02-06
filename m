Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF672C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7931B87C93;
	Tue,  6 Feb 2024 12:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YVuJ+4w8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C21C987CAC; Tue,  6 Feb 2024 12:37:30 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F95C87968
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqh6OgdKQEKOPzyQN8Kd4MvUcLpCo4dkFKi7FjVU1JDumcgsYL615zBOMWICe3at4+nmZJqQ80snN040olS6xcyC0wyIvwpaGL4S5YKpiVdinyfOMCu7SoZ1C87Bk6N/co/XoP4fZ9+N3BCXk/71ug1Msa46Yd4dxvoOP+m92/OHaleDasqI0TwANJbmbNIay8Kc7w3sXsx33FqPD82wl1NhuXMIPPE1Sf2Ug/0kIH14gUdmgdBACfwjKOCuZfd9YNQjbpFUpeNU5xVezTQHMYCQiRDxwnbC3Tdo2W5pK3QgeotG9x6M7Hf0VjDzqDsLgqCcg8iMXIdKw/LEhH/Dhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBjXdTVz61WCmsZMlh4OcC6uwiU8EdX4RHDsvKM0qbg=;
 b=kWJqx1cy/7ANIjRqONNvJ5+etQnicTGnE4DORdh4+1GdYGSrF1wQPylBeiCnl4yDV5ZaLNID5VNfLF6oUCuHxXX6v3YcpqJDWb1X6kbYsdDc+UaEcYPghbAd277q/XwXIfV+ruOO2p9A9REgI9KvsuGk8OIqwi3UaRLc/NuriweF2/ahJUbNpBIoYhbecNUoYCRQThMdHJEFKJqGr5THbC29z6AI0zJMyeEYiubrRoxS7YoAw2YaIW0sSq5s14+Ho70rtUPSlavMlfR2CpZ2ycrfkScSBi1vnmoBYtU5ADZgqJsXK08lzorTkGMmQp8wQDBwf15NVo/lsOEOZzp9dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBjXdTVz61WCmsZMlh4OcC6uwiU8EdX4RHDsvKM0qbg=;
 b=YVuJ+4w8/L62dLVjyGZkzzt5FLZFeJB9qhTZVcSnAFPCYNC3rPPLUPdNgrVF1NMqzMGveflXpQXtQFcST27FWiAZzDy5McVLq+DxH5fq14XTLHfkVpslY82mF3wP+h2lKx2uGBly58hONJZmPAH/1xqx0QvoKYtfX/jSpPngCk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 11:37:25 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:37:25 +0000
Message-ID: <e8af65a3-4866-48bc-89d1-ffec5a9b3445@amd.com>
Date: Tue, 6 Feb 2024 12:37:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] xilinx: Fix fpga region DT nodes name
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Simon Glass <sjg@chromium.org>, Tanmay Shah <tanmay.shah@amd.com>,
 Tom Rini <trini@konsulko.com>, Varalaxmi Bingi <varalaxmi.bingi@amd.com>
References: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <78e6e3f287f79917eb92c6c74accbaf955526aad.1706791116.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: ef544ceb-5e56-4f49-9a25-08dc2707fdb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6bJ+TU1D3K1xnSBOn9WpJbYuXvNx2cGz6v/1AvRbneo/aallXC59pttb1hv265a8aeyYIAyAw09Nfz6dx79UP64e6Djso1Pf/hYwCo9z7azj16bxyRQFYa/sELIWCGssgJfRew0q+1GZ318GphCpMWZaSrf8GamNOSxXi5CqqurEdi72U3n5sx3zfLyVJqJA8FHArHZgMxWeCDcOx+JvOP5MaqUUK1g1DOPOsiXjMysI8bd76JeWWVY7d2JFDj9MCl6dQXPGZovBV7Rq0IrTtJTB8Xh+DpN3BGJBxgTN+usahjW/+gs6cgCfZgy5VijCgqu4fg+GvHhlWZmiVjmfrDN80Lcqu/8KAoiyQCl7iG1zvu9vXBuhDpIMQ4bsjjAjX2Q+g/wGi5y9N7O4UYttDfHr80CP2rzczwHl8fttizGhjSRQDtW/GS26Ab5DjGi19DGKr6E+cb7U7CngU3OAsOQQedYbj7YrzleQeJY05L2cmNLtTfXVMEaUt/SG97uD+kxAy810cHuPNw19WZbnM5EU+LiPiPsagbrL+TdYqNIUo01oRIKxQ0o9nv/+VKV1/oWVePUx1QFLbVRNrCatxalSoM+GSdcWIHjptxx5yoyAXQT7FfNaqoG8ZtHldK2/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(966005)(26005)(83380400001)(2616005)(478600001)(38100700002)(6666004)(4326008)(8936002)(66556008)(66476007)(54906003)(8676002)(5660300002)(2906002)(66946007)(316002)(6506007)(44832011)(6512007)(53546011)(6486002)(31696002)(36756003)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjBxZXVFNStyVUhrck83dmgrSkp2Y0RaMEQ0VXBJR3NlVVdPOTBrSzByU2Zm?=
 =?utf-8?B?VzdrWHV5bGhVOCtpUnI3cHV4VHQzUTVUakFkNHJhOHNMZThyT2FqcjA4QmlF?=
 =?utf-8?B?a2txMUtLczEzSHY3VEhoS0QrZDA4emlCWVpJSm42UXlQZ0grSzk5UmttN2ZD?=
 =?utf-8?B?aUhLYWtCd05sTEl2VUN2b3FJd0ljaytadkM5R1pxZDFtenRjbExtZ2oyMytt?=
 =?utf-8?B?dStNMSs2RDhoUGZrWGlsMHVhUXZJanNkNmV5WWEwdko4RUtjNmFNWmNqalVp?=
 =?utf-8?B?MnBMWWtON1RYRks2a0xITjRDTWl5RUU0RUtXWHpMc3I1Y1NURVpIUUR0c3BG?=
 =?utf-8?B?ZVBoUVBQNDhJc0IzSkJlUXVGb0JmUXpiYjMxLzNsVHcyREtuSkZoUXFxL2tu?=
 =?utf-8?B?WW1tQ2Jyd2lPNjRjbFFLSEJKRE5LcWNGLzAvRzB3cGx2b2NLZ3duaWFIb3lS?=
 =?utf-8?B?UXdpZmtMVUxNUWQ2ZENrUGNTdENsZ3VJWDh4S2Rtb2prWC9GakJsTmNtVEVi?=
 =?utf-8?B?MGcrbTREVnRiVDBPWGY4MlNMbFdHQ3hGY2tiV0hpOVA1emdwU21SWE9WbERj?=
 =?utf-8?B?QnpvQWQraEhDeGlzVWwrbFpqSU1FdFp5SWhXZ1FlNjFWYkptUXpZNkdEMjFK?=
 =?utf-8?B?Y2ZYMUtWZVdTdEtXS2l1NmFGU3RuSnkxaVV2MjFtQXAxTGVLZXBldUhCM3FZ?=
 =?utf-8?B?YUhDdEQzNWdJelJFUkNkaVpBald0ZlVPV0syYURIQTVoRkRZRFNQTjlIWjA2?=
 =?utf-8?B?MjNTM1ViSnFKU2xGSm1NWTJhbHdhNUo3b1ArK2lwenlkWHNVZmJDVXdNTkdh?=
 =?utf-8?B?NWNIRkx2em9uRVlrS3VqMlVWRmNkWnZxMndiSlJ3UUNDaTVFdkJ2bjJYWGpZ?=
 =?utf-8?B?UnByZkN5UVora203dlNZSmRCQlBFSlVlQXlkY0tCTGN5bmJIU2NTcnRBNlZ5?=
 =?utf-8?B?RUZaOUxydjVESnZIeGNXaGpzb3o0cTYydzRmMzd0eU1FN3A3Ty9mK3oyYjNo?=
 =?utf-8?B?YzBrZm1zSXJGSnEyalFXT0J3NncrclJFcVdjcUtLczF2eEFBcHVPZUZqNEdi?=
 =?utf-8?B?cGtPblFNM1lrS045ZHlTVXFnR0oxaGFvd1NrRjUzcW5MZmhNRUhzaTJPMFVL?=
 =?utf-8?B?RnhVcmRBQVAvUG5UanhwZUhvWm05TkxoT212NjhJL0ViVFRPVTdmbUxCNjZy?=
 =?utf-8?B?a2w1cjZHOG9FS285TjdzeUlnZTUzUWxDTnZRYVYxQkRLQzU0bTU4Y0t4UG9w?=
 =?utf-8?B?cThTOEFJUU95ckR0ZlV5emtkaWZXRmE3alRnc1d5V0RZTGRMV0RTSzQ2SGpw?=
 =?utf-8?B?M3plblVWVis2ZmN0bjA3cERHWm9vU0hmSTlUZFFLaEFvMzAxUFhacTRRcGk2?=
 =?utf-8?B?S001eXh1K3lhUEZaZUcrUkl3OEZPbUo2Y1hOQm5sRkhGTW1wUDdWdGxJZGdJ?=
 =?utf-8?B?a3Vyc3p5VUtEdHlUQlBiNk9XM2ZhYnV2ek42K3QzVTVWc29UQk82TWpUSHor?=
 =?utf-8?B?QVhQOVBBZ3J3WjZKWnhQTlgzY3NQUk9NU3laeUMxWVBGTkZRUVU0bUhqc3BY?=
 =?utf-8?B?NGI0Y214cDBnUE9PL0NYby8rUXUyb0lMTTVSUDZXR0JHVGowSUtXUHFZRFVE?=
 =?utf-8?B?ZnhxMkhYZ1NsZjdxdCtoLzUvYnFldk53bGVFN3Z3TkZSdlVpQzcwVkVGSnd1?=
 =?utf-8?B?OE1sUnFEZzYvdDJLOVk3bTBWWUpIOWJhOTAwT2ExcXZFejBqMVQzSjI3Qysy?=
 =?utf-8?B?YmlOWGkvaTd1NHpydU4raG93dGh4NGhReU1TQmxOTkNZSFlwdzZYR1Y0RjRk?=
 =?utf-8?B?UlNmUTlqSHZLcTdtNmdDcUMxQkdwTjEvamhPSzczT0xWUUN1akNCL3hSWnRG?=
 =?utf-8?B?L2hZcG1Pd0VSTXR0bkxna2ozZVFTQWNPVXVwWTVMWWg1UENGcXlMR1Z6SlUz?=
 =?utf-8?B?SkgxQm80aDBTZmlCMnBSMm1pc0VSR1ZvY2lveVJyeVFZcWhFdWlSTUt6VVgy?=
 =?utf-8?B?cjNwOUIzbnh5TTN2V3cyY01yVTNQcU16NW16WlI3dFBVNWNYTmlIVU5SeHJT?=
 =?utf-8?B?eEF4d0NnclBaZHMxTGY0Tm85VkluZVBDWVFsdlZGRldKQSt6TGp3WTE5a1JE?=
 =?utf-8?Q?n6i4E9j+j6UH3Eet4+YVhWgt4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef544ceb-5e56-4f49-9a25-08dc2707fdb9
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:37:25.5649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjATk48AoE6F35dq6Xfy6PasMAHgMvncrZ3ibLh9a/qL6AlKyyXlPcV0vh9TN0wH
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



On 2/1/24 13:38, Michal Simek wrote:
> fpga-full is not aligned with the latest dt-schema. Generic name
> fpga-region should be used.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Aligned with fpga-region dt schema
> https://lore.kernel.org/all/37b107d86b39ef4bc9c482b57b27de8b92c3fa43.1706530726.git.michal.simek@amd.com/
> 
> ---
>   arch/arm/dts/zynq-7000.dtsi | 2 +-
>   arch/arm/dts/zynqmp.dtsi    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/zynq-7000.dtsi b/arch/arm/dts/zynq-7000.dtsi
> index f8c786ab0b7b..75dfd2f069da 100644
> --- a/arch/arm/dts/zynq-7000.dtsi
> +++ b/arch/arm/dts/zynq-7000.dtsi
> @@ -44,7 +44,7 @@
>   		};
>   	};
>   
> -	fpga_full: fpga-full {
> +	fpga_full: fpga-region {
>   		compatible = "fpga-region";
>   		fpga-mgr = <&devcfg>;
>   		#address-cells = <1>;
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 63238c08780d..ee2fbcaedc52 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -307,7 +307,7 @@
>   		compatible = "arm,cortex-a53-edac";
>   	};
>   
> -	fpga_full: fpga-full {
> +	fpga_full: fpga-region {
>   		compatible = "fpga-region";
>   		fpga-mgr = <&zynqmp_pcap>;
>   		#address-cells = <2>;

Applied all.
M
