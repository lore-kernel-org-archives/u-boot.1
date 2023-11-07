Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A53DC4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 577F786823;
	Tue,  7 Nov 2023 13:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YJOdWea2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5928586823; Tue,  7 Nov 2023 13:38:41 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 370E186F64
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMcl+felJAaJefhOjOXkiPYBOD7wke1968+HPtk+aa2/TGkU71+kMtt3KteS/+a1unslQOau+JX8JGorta6B9UjorjOxXUsa6DtHgLfPg3NI43/jKyDm3DBdy96JnclF2jWj5vx7YHmBzJN9wyoiWz60KNc2ub4hZW8TKLPpIibgcdDv16aKQc2ruoC2r7W7VvYhSrpohCFiRlmMGy95k5PW5BYUVfxGZp/JUorWC6wg1cIMMDC3YfA7T92lN03PBVcXDdNAm2jiBcFbGD9o/+qsHDzrqq62+dlsl18gFHdYcbsbY5uO0lV+hyY9WIxm8QWw9ffRQycYxeR+nkYi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8bTHAnbewF3/8kbAV8OgDLDiiAWEQGu9r075Qyj3vs=;
 b=Z610Qt+/LLRIukya9EkP19cxTzmi+tkq2KvdtVFWIl6rPS0Be545V3Zwjk0CgIqAoaBVqyqOKfjd0/7hmygZYPFpS5ORXAAkOXfCU1wq+YmPtpaHOLG5rz/eBafAFgwe0wUn6S/AtM36r9BHZhQ10Ln5ZTU+TuXCrY0dpEse8u4PBeLEF6mlWq37rvmwOhzZECv16N5mtrghCft13mX3P0G0C2H3j7cEYTeb1Ue1IzhoORbs4mG0MC1kmNwrOCKZcaLLiVgQl1qa1BgQVnQQQBCoqjKldIkvc/RC7xJeWKAdihZj5cAOkABbAf57rDD4WXt+gUIL8oYR1HxT8tcWgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8bTHAnbewF3/8kbAV8OgDLDiiAWEQGu9r075Qyj3vs=;
 b=YJOdWea23aik5nCwUhHVf+lBHlK9gsw601sLv3dZCftbei0T41Y5GAA9MzgqbVTulu3oq9fNZIJyX1WBaYz3eh0KcwbnzN+QjfP4cwNtURzmfsfVH4Ri7D49sjUamMfTQGlh64s1S7cqoScxBt4awDQK+vpCKEZRLMO0gMOmw7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 12:38:29 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 12:38:29 +0000
Message-ID: <1aa1d376-cc2b-422a-829c-baf8ad6e7ac8@amd.com>
Date: Tue, 7 Nov 2023 13:38:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: zynqmp: Comment all smmu entries
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <e868c27c52ded5d8ef25f75ba394b1ab3b31b80a.1698825657.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <e868c27c52ded5d8ef25f75ba394b1ab3b31b80a.1698825657.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6f36b2-3134-4a3a-7933-08dbdf8e71ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzd3nf3h8t0fshcYSixlhezqRSNRR5bBQo5TPbAgaVzXlA7za4bO0NVqL3VUWvsWTajhCEp2SF1yI2lLeGfg+Qo4taB4rNmtkSxfiuNSfC1H5+tUL1PaP8CnYtrHkxLnkZmpHE525eOk/T700U9TYvjZFqkwQgn8q0+PMB9f720MZlM0cIiA9XD1Tm0yAU04O7NCcR6XvRVBeZ3mziirgWv4kMuqg9QzqWHJjK8oqvEvcnKrcMA+UfzCiXOfrqRi0PyGI/DjLFAraaiPvoKy/NvCS0nCRr/AcSAkGPAKdiUS7qNkWl5to9qikyfs+7bK8pO08bBaiUi+zBMB0dBbo0C5ZeD4yjXalCmPL+ODqADkkuxmKZ5z70urPJ/9Ksjla9YYLLjfEgmblrTMCldNL3P7UfQdGyNB4MppVH9s64ImCmhpjeQU9YdBGZfM0/b0CGrH8miXmYiwjRJiKybtk9wzbJ4p3tiaj7QJKd2r4fvUJsOSRqjis3TfbxaeqyqUCCh5vRnaU0r8HdKKpocNStIMwPSxM3XeVk80+sLjLwZ3vVbdpJRQKCws0JQGYLoUX4durLVMzQsPYZUoLAB87rH/fQ1uE1uAgtCynk0vr7uA6yjpd2CoHblvYQdzLu4qgTi4wEo2HP6FXrrPWcKz7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(41300700001)(316002)(478600001)(66946007)(66476007)(54906003)(38100700002)(8936002)(4326008)(8676002)(66556008)(36756003)(6486002)(31686004)(5660300002)(86362001)(31696002)(44832011)(83380400001)(2616005)(6666004)(6506007)(26005)(53546011)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUhJNEFPTVpybzZOdXVlcFZDMkNxNmRmZzU4bUFMOVV0R1VuREZ2ak5LK3Zq?=
 =?utf-8?B?dkg0ZTBFQmtkWkZoeDRpMGVVYnMzYWtDc2FRNTVwMGxmQ1NIMHZVOTlmWldP?=
 =?utf-8?B?SHppYWpLYndCb2ZhT1Y4U1RZajVSb3MrUTRPM1phSXh2MTdpbUlYeFVCMnBC?=
 =?utf-8?B?c00yczJBTGdrL0NUUmRiRktoeUh3TG1vWWVBRzRyZHpDbEpmbXIvSE01NkZR?=
 =?utf-8?B?KzFFMXhVMnhIaklyZmJ6YUVlemhrakdwajNSL3locHRaSVdQVGlpK1JkRVF3?=
 =?utf-8?B?SGRnMThJdUs0TzF2YmZuUXI0Q0ZnR3lpV2QrQVIzMDF0MWxaSkNiUnl6bDBB?=
 =?utf-8?B?aHRCTUVlZzBzNmZTSWZrckhaZm5LYnMrZkdraDBvcU92Y2JwYmwyRThCL1ov?=
 =?utf-8?B?QTVuUXdiWVF5bUdjQUt1WUpwRU5nY3hoUlRQNUNTR1hGUjZqMmZySTNqT1pM?=
 =?utf-8?B?U2hkOTBFTHlVcEdvNTFKaDdKY24zbjN1Skx3a0UrSkg4VGZ4UFQ1Qjh4N2Rv?=
 =?utf-8?B?Q0pYTVZtUXQ4dVBXVU84U2t2NFN1aUVPenRaTFhFcW1pMkJYWmFKTWNEYUY0?=
 =?utf-8?B?eEpZRnpmMDlWbUVkMjdqMHJQb0xHUFVVWUEydXhBUWZjNit4eTJncUpyZlJn?=
 =?utf-8?B?OXlBOVVZV29xUHhrMnAzRHpMc3BleUV1U0FwbFU5U2I4a05obDcvMlgzQk81?=
 =?utf-8?B?SUg0Y2FmcW85TUZlYkwrSHM1VlpyckJHN3FZdUJtbjRQdC96dFhsQ2YwY1cv?=
 =?utf-8?B?Q0s2NWlJdlNVVDA4QkFkMVB0eEo3TWJpaEdiZnlYM3d5VzF5akkzTjVyVDEz?=
 =?utf-8?B?ZHRRQ29sdEh2ekNiY1pXYndaYmxKa1ZLN2hJVG5HR05xNUR5NjBxSTdHMnNk?=
 =?utf-8?B?eEdDWHl5UFpDWUM5QU5HZGhOSDBNVFNzak1ETnBWeUtnQXJsT3NnRmV5cjJ3?=
 =?utf-8?B?N0wraUVvbEhGY2R6TTNiVjFZZ0Y5ckl3WUxUK3dCdmEvQTZmZTE2K0ROd0xs?=
 =?utf-8?B?Z3gzUVVDQzdMcy83UXQvU2VJSnFSR3E1VXBpdUpjNHJaSVYxTkZBcXRhN05k?=
 =?utf-8?B?YzR6bmFuN0dIMEh2OXhnREN2MGtKVnRvZy9nMStyRm10T1k3YytodDNWQjZG?=
 =?utf-8?B?clgrZHdIRDhvNGVHeVp5R1VIa1pjMVNCOENOdXp4MDlsc1BhbDRWZ0dkSzFS?=
 =?utf-8?B?VVFqMyszdkM4ZG5UeXl4M2h2YmpFN2JwM0dBWDdLSWxRMEF0bzZVREdhRk1n?=
 =?utf-8?B?OU41amZzY1l1YzdJOUlDS20xVjBOQmNGRnM2bDh2TitsOXpOcXMrTEJoVnoy?=
 =?utf-8?B?RFRnY3lLK0N0bTA2ZkNuWW10UWNSSnpLeitjUXRMcXk1dm1BdXJHRzVXZS9W?=
 =?utf-8?B?K2RaTTVlTmVlSUZzZldxWWFoUzhZcWhIV1pzQllnUzJpdGNJWVdDdWcxSXE5?=
 =?utf-8?B?dVBQVk9EOS9vV0phdkdZUUNKS0w1Y1NpaEtPOVRaYUIyOG1WdnlZSXJzS1pL?=
 =?utf-8?B?OHZUMk9TVEhtL2hrNGZFejAreHBhbGYvT3NKN2x3MEJiaXRQbENML0hPdXJa?=
 =?utf-8?B?OHZSd2RXcHhOajd5R0pIUGtVZU1OUTdKY25Ja2RtZHVkUnYxbm9qVmJNMnpL?=
 =?utf-8?B?NXhoZk84Mlp0Z1ZKREJuMDVhSnF3SkNrSUhpeGxucHg1bW1keDMwMVZ4T2VU?=
 =?utf-8?B?WU5rUkhPSytHWWZsL29WVWNzVW1pZmc5ZzlPd2U0dS9ZQ3Rwdzh6RGMwK2Fl?=
 =?utf-8?B?UlZla3hLM1pLSDFZNU52Sm1LdW0zUEhtQ1BTWktQR09CMndSbHlxNDlkM2kz?=
 =?utf-8?B?UVJvQlFQOU5BMXpwWFNTRlVMYnZrWDcxcXdyVE50bzJQR0JQVUlyTVE2OTBo?=
 =?utf-8?B?a1FJME1BUjZNRFU2NU1KMjhyNlp5V1Q1U2hybVlTbmpiYzJBYTFUS21mUVZw?=
 =?utf-8?B?YWRmSTRKMUlPZGNiUVFET2JuWmw0aFlYM2FTWnZKZzdnR0ZGVmxFaVdoRWI4?=
 =?utf-8?B?Qnhhc0UxSE41LzNHNVZFNEdHV214R3JQQStadktmY2lGSUx3THFJRnhmTXpS?=
 =?utf-8?B?Q3pHNmlNZk9XL0RESWVyWVd5b1lMOTM4bUdyWGdYMGw3aXhTc1Z3em00ek9k?=
 =?utf-8?Q?xLpD8IjqTkVBRrfq2TkxLMLxs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6f36b2-3134-4a3a-7933-08dbdf8e71ea
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:38:29.3813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qaOe8dPBKn48B8VSOZ54iwmgcevxrrJV4geWrVnD+3uG2hRQc9Od+qYSj42W4NI2
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



On 11/1/23 09:01, Michal Simek wrote:
> SMMU is disabled by default and not all masters can be enabled at the same
> time because of limited number of entries. That's why comment all iommu
> properties but keep them for reference in DT. In XEN case they should be
> added back and Xen should have SMMU enabled by default.
> Also add IDs for DP and DPDMA.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - add missing one for DPDMA
> - update commit message to cover DP and DPDMA
> 
>   arch/arm/dts/zynqmp.dtsi | 59 ++++++++++++++++++++--------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 2253e773d386..66d53359d83d 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -339,7 +339,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14e8>;
> +			/* iommus = <&smmu 0x14e8>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -352,7 +352,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14e9>;
> +			/* iommus = <&smmu 0x14e9>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -365,7 +365,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14ea>;
> +			/* iommus = <&smmu 0x14ea>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -378,7 +378,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14eb>;
> +			/* iommus = <&smmu 0x14eb>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -391,7 +391,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14ec>;
> +			/* iommus = <&smmu 0x14ec>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -404,7 +404,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14ed>;
> +			/* iommus = <&smmu 0x14ed>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -417,7 +417,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14ee>;
> +			/* iommus = <&smmu 0x14ee>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -430,7 +430,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <128>;
> -			iommus = <&smmu 0x14ef>;
> +			/* iommus = <&smmu 0x14ef>; */
>   			power-domains = <&zynqmp_firmware PD_GDMA>;
>   		};
>   
> @@ -475,7 +475,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x868>;
> +			/* iommus = <&smmu 0x868>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -488,7 +488,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x869>;
> +			/* iommus = <&smmu 0x869>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -501,7 +501,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x86a>;
> +			/* iommus = <&smmu 0x86a>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -514,7 +514,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x86b>;
> +			/* iommus = <&smmu 0x86b>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -527,7 +527,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x86c>;
> +			/* iommus = <&smmu 0x86c>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -540,7 +540,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x86d>;
> +			/* iommus = <&smmu 0x86d>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -553,7 +553,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x86e>;
> +			/* iommus = <&smmu 0x86e>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -566,7 +566,7 @@
>   			clock-names = "clk_main", "clk_apb";
>   			#dma-cells = <1>;
>   			xlnx,bus-width = <64>;
> -			iommus = <&smmu 0x86f>;
> +			/* iommus = <&smmu 0x86f>; */
>   			power-domains = <&zynqmp_firmware PD_ADMA>;
>   		};
>   
> @@ -586,7 +586,7 @@
>   			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			iommus = <&smmu 0x872>;
> +			/* iommus = <&smmu 0x872>; */
>   			power-domains = <&zynqmp_firmware PD_NAND>;
>   		};
>   
> @@ -598,7 +598,7 @@
>   				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0b0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> -			iommus = <&smmu 0x874>;
> +			/* iommus = <&smmu 0x874>; */
>   			power-domains = <&zynqmp_firmware PD_ETH_0>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
>   			reset-names = "gem0_rst";
> @@ -612,7 +612,7 @@
>   				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0c0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> -			iommus = <&smmu 0x875>;
> +			/* iommus = <&smmu 0x875>; */
>   			power-domains = <&zynqmp_firmware PD_ETH_1>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
>   			reset-names = "gem1_rst";
> @@ -626,7 +626,7 @@
>   				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0d0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> -			iommus = <&smmu 0x876>;
> +			/* iommus = <&smmu 0x876>; */
>   			power-domains = <&zynqmp_firmware PD_ETH_2>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
>   			reset-names = "gem2_rst";
> @@ -640,7 +640,7 @@
>   				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff0e0000 0x0 0x1000>;
>   			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
> -			iommus = <&smmu 0x877>;
> +			/* iommus = <&smmu 0x877>; */
>   			power-domains = <&zynqmp_firmware PD_ETH_3>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
>   			reset-names = "gem3_rst";
> @@ -719,7 +719,7 @@
>   					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
>   					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
>   					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
> -			iommus = <&smmu 0x4d0>;
> +			/* iommus = <&smmu 0x4d0>; */
>   			power-domains = <&zynqmp_firmware PD_PCIE>;
>   			pcie_intc: legacy-interrupt-controller {
>   				interrupt-controller;
> @@ -740,7 +740,7 @@
>   			      <0x0 0xc0000000 0x0 0x8000000>;
>   			#address-cells = <1>;
>   			#size-cells = <0>;
> -			iommus = <&smmu 0x873>;
> +			/* iommus = <&smmu 0x873>; */
>   			power-domains = <&zynqmp_firmware PD_QSPI>;
>   		};
>   
> @@ -772,8 +772,7 @@
>   			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
>   			power-domains = <&zynqmp_firmware PD_SATA>;
>   			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
> -			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
> -				 <&smmu 0x4c2>, <&smmu 0x4c3>;
> +			/* iommus = <&smmu 0x4c0>, <&smmu 0x4c1>, <&smmu 0x4c2>, <&smmu 0x4c3>; */
>   			/* dma-coherent; */
>   		};
>   
> @@ -785,7 +784,7 @@
>   			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff160000 0x0 0x1000>;
>   			clock-names = "clk_xin", "clk_ahb";
> -			iommus = <&smmu 0x870>;
> +			/* iommus = <&smmu 0x870>; */
>   			#clock-cells = <1>;
>   			clock-output-names = "clk_out_sd0", "clk_in_sd0";
>   			power-domains = <&zynqmp_firmware PD_SD_0>;
> @@ -800,7 +799,7 @@
>   			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>   			reg = <0x0 0xff170000 0x0 0x1000>;
>   			clock-names = "clk_xin", "clk_ahb";
> -			iommus = <&smmu 0x871>;
> +			/* iommus = <&smmu 0x871>; */
>   			#clock-cells = <1>;
>   			clock-output-names = "clk_out_sd1", "clk_in_sd1";
>   			power-domains = <&zynqmp_firmware PD_SD_1>;
> @@ -951,7 +950,7 @@
>   				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> -				iommus = <&smmu 0x860>;
> +				/* iommus = <&smmu 0x860>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				clock-names = "ref";
>   				snps,enable_guctl1_ipd_quirk;
> @@ -983,7 +982,7 @@
>   				interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
>   					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> -				iommus = <&smmu 0x861>;
> +				/* iommus = <&smmu 0x861>; */
>   				snps,quirk-frame-length-adjustment = <0x20>;
>   				clock-names = "ref";
>   				snps,enable_guctl1_ipd_quirk;
> @@ -1043,6 +1042,7 @@
>   			interrupt-parent = <&gic>;
>   			clock-names = "axi_clk";
>   			power-domains = <&zynqmp_firmware PD_DP>;
> +			/* iommus = <&smmu 0xce4>; */
>   			#dma-cells = <1>;
>   		};
>   
> @@ -1057,6 +1057,7 @@
>   			reg-names = "dp", "blend", "av_buf", "aud";
>   			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-parent = <&gic>;
> +			/* iommus = <&smmu 0xce3>; */
>   			clock-names = "dp_apb_clk", "dp_aud_clk",
>   				      "dp_vtc_pixel_clk_in";
>   			power-domains = <&zynqmp_firmware PD_DP>;

applied.
M
