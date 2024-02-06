Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230FBC4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:32:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6544087C45;
	Tue,  6 Feb 2024 12:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DbkyCtN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799E487C7D; Tue,  6 Feb 2024 12:32:11 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E00B87968
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALD+hQ9twCQUbeceQ5GRo/2fUBrD0Aqh6zdopdWy3SIz8QEPWm7Af64lhn0PC29c+NzWxaEQTNxkWgnI2Il4H0YD+pSJZzcWAEVZJUvhQAjtL47ES4vhEeYmCfoni9pnnxA6EPSpaAt+u9lkxM5qK/x2B6PGY7kLG30mMa0tgcAxQ+m9yJgSYykYEH3ftbQrJzHP9Mi3kFsRy9wCDwXHUzpd/cWJbfOePFE8FrOlrgCH9lU7KUtmzRZZZNBLu+BoTIFZj7IEmHXTIzHM38jDYApcuTs+SPRf6j7N2zIhXgdwDbRfwWci66FQbMchSDbfiTXls5tfcBIGhTBQBB3o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blud4suXClWz5HnuINAcKEqz3py3JAaBN3Xb8NqnEIo=;
 b=RsXlDV2LXOYIZFdTlJ1Fb3DUKKGUz+ZZmZ4WSE6SAGxP+EBs6gxmj+Fp+7avHX0dsswDpkGdD8NhS5wqjhkzXyPY/r7P/ZsScNCyWQrW8r09kpoUlKgBy9YylGDcHrX0FBKsUP4a48jLetgJIu2N9Epp0hnEYlI7mZLaCOHRvojlEX7dlj7seX87fC8URxfzk6l8kYBEUL51ASGIUWgz3KZrxEBq6fJjK1ODQLbs7spx3Je9ulOUHqy2wg7w0K1fv81XtkslQLnvgjQcPgJZK3XZ9eFBtmj6kxyzOSE/605IyLRPw25DO12DqwnKHVhzCLlQRYjWWSoNCQlEp3TI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blud4suXClWz5HnuINAcKEqz3py3JAaBN3Xb8NqnEIo=;
 b=DbkyCtN+2pqJmyRhcTsbWmICia4UCkxag2AyCD2TIGV1OxF0Yt3o9gFQlQ8zPtoK9KLmEI57CsUhRceyTZN+trKhgv2/8xuPwWG7MoI/BIlYN+BavxTRsWreBvizZ3q/Uo0nvSliN1EIKV3PqeSVbuGZvMIHM+y0YwC6EBGfhao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SJ0PR12MB6781.namprd12.prod.outlook.com (2603:10b6:a03:44b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 11:32:07 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:32:07 +0000
Message-ID: <a0960fca-371c-4d33-acd2-e795ebc1cb92@amd.com>
Date: Tue, 6 Feb 2024 12:32:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add 'silabs, skip-recall' to all si570 clk
 nodes
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Saeed Nowshadi <saeed.nowshadi@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <bbb2322c94503f0e6b369c60312b7546500fad95.1706170068.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <bbb2322c94503f0e6b369c60312b7546500fad95.1706170068.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0018.eurprd08.prod.outlook.com
 (2603:10a6:803:104::31) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SJ0PR12MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c82ed6-01ac-4e4e-af45-08dc27073fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I95nsI+/we3Y6s7V1C3EJnU8V8GLCrDSdZJ1UitxnJAJyPSEsal/uxlTtEMKpXZ0oM2+QTQCIb0R5nW6SGPmbVnsgvf4+QaSWrlVPhX2b3cwMwbxhqgW6FVS8dillQBDKKNJ1TAgsW7lfKs9L/l8aqJGC6PxTTnb5xzHkQsd8MOOfpXKXWxsxlha/m+XEusqMuKiVIhcDLBqa1Z9RuYV8fvc6+f0iB2y3yQO1Hr+M4knVg9EMPGuveVBqmTh8x7Tuk95cGLLm0A4MwCtP0nayBoPyVOWryMufiEAJvEy3RIHitoQVhTtJIs3PnMFl/bLpmPcjEuo7ikZZXDuKux22++/hB6uKhtNHnPETXePxVT6jHUW7f/7mtwV8p0suK0M3JbkYC5PFRNUc7N57e8AYS+YtM9qFoyeQ48TkE+H30/8Hl0wpl2dJbK3x/c8tKKCl5+01v2ZFlkwG1Q0dAKnjWqbGzccmzywlcA9QP/wFaSxqmrXeddtI8lyRZ8q1korLZhqkg6S2dr3t1QMRnx4OLg4yEMiG6eHhXCe8EGhLFJAEgOQUy/RXMtegIcJjY/1rT9i3lwRTlvBKvvcjWzZjhwh+1U0xMvzVxy12WpLbBiRMIepWaodtMuj+4r4/VOaAPxw/Yv79S5h+GuvThFFKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(316002)(66946007)(66556008)(8936002)(4326008)(44832011)(8676002)(5660300002)(66476007)(54906003)(86362001)(36756003)(41300700001)(6486002)(38100700002)(6506007)(53546011)(26005)(83380400001)(6512007)(6666004)(31696002)(478600001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2Mzb20rb3VyUjVXTHNoWi9Db25aWStscmJhTHJXKzAwdmQ3Q1lBWGlmZlpl?=
 =?utf-8?B?QjRrRTg3b1k3dGpIMkkwRlFaMTRMMVFUQi9zQ1FVMG93d0ZHdWQxQkRoTjZ5?=
 =?utf-8?B?Q0dvaWtiODJ3Nktyd0RhMDQyOXBJVC9TZDBMeE5FK0pnZE0xZGQ0dzJDTjE4?=
 =?utf-8?B?MDR5ZXVFNlFPWTlyMmdkYmV6ZEFhd1hkbWVWQ3N1UlZKb2VLazl0M1podWRt?=
 =?utf-8?B?aEZEWXREM1pvbTNEWmltdVY0NkRhSENINjREdmYxVmVORDlrSG5jZEJzOHJV?=
 =?utf-8?B?MXROUXFXdXNmWVBpZzNvRStpbE8xTmVDbjVOeWxiU0RQeEhOazhsYUZtbU03?=
 =?utf-8?B?aDE2eUo3alZWVTQ2OXl4SlBFWEpxQVRIVkhSVjZnTm9tRUFLYmpOK25EM1BB?=
 =?utf-8?B?czRLbCszQUJSV2ljZHFNdFRiWldwYk5Fcy91SEloeGFFdHR0OVM3RmZwOWxF?=
 =?utf-8?B?RnNiMTRTTGdGUmVEYTdodVR6L0ZkYTc1NVZraVdwZ3QrSEFoZy9Ka0ZrOTBL?=
 =?utf-8?B?N0lFODNBY0FzVWxJdzlCZy9ZdTdnZytWdjVOTS96TEpRYXhUZG8xa3FucUky?=
 =?utf-8?B?elQ0aVdSeHlMRFpMSWVFTEJNeHltVHhvanFWSGJWemxEYThXOTFqeUdMTm9q?=
 =?utf-8?B?dS90K3pjSHB5NGI0OXdqUDJzK2N6bS81V1FSdHYwMkFBVFF3aXBJL0tWM00z?=
 =?utf-8?B?bjBVVG1uRmJNRnJja2RZMHR1Y0grelJkdTRGQ0hxZ0VSa3pQNlZrRjN1b1Fs?=
 =?utf-8?B?bFVwcVkvdlFQRnpaeWVaV2tubUl6ajZXbHJzc1hUazVLSjhKRmZZbGV0MmxM?=
 =?utf-8?B?Ym41dUI3cFdTN2lOd21YMXRYanhSdkpvcnA2Vyt6dkd6YTY4L0JHVmlrZU9v?=
 =?utf-8?B?Y0tTMDVnTVRnZHREbXJHbGxYQXRqRlpVR3RjUC83Zm9pckFiZU9xa3l3MVNl?=
 =?utf-8?B?WFptZmFuczZvUnFRc01YR2dPYndHWC9ySTRBejRzNmhjQllzZkFrS0ZsZ05U?=
 =?utf-8?B?dDc4T3BPTnloQjhsRkN2RTI3SWFWRlRDcTJ2RXhLV3VzUGg5YVZuS1V1a1FB?=
 =?utf-8?B?NXRwUXZmVlR5U3V6UG9lZUZvelI0RVlBVWRudGZzZ0p5eGdWbm9kWVRzYWZa?=
 =?utf-8?B?NjZxeVByMWF1SXluNUI5VG5XejlFTVFXcnQ5YVQ5RlFjdnIzelRadDd0cFB6?=
 =?utf-8?B?Q3hwRGRpdmIwdGlGRHdkNHJ2M3NaRTY3Si9zWk11em8xTUI0TnBqS1NXNlJp?=
 =?utf-8?B?VDlJNTlRblFLaHdsT2ZMWWRUUkxZcmQrZk92aWtuNXJTMnIycGtNak4wZWc2?=
 =?utf-8?B?dHdFWFNVNHhGdW5NdHliS0gybWtjUWo3OWVQa2pwci9oQjA3NytzZHdvcGJE?=
 =?utf-8?B?SzNLUWVzZjQzWDdDRy9xOWZHSXdzMzJGRFFhZ09wNTFEYWpmQmxCQ29yQjVu?=
 =?utf-8?B?WEJQUnY4VDdObHdtUEkrSks4SU43b05VSnh4RDRuZUdCd0NoOG9Uak9NZzFH?=
 =?utf-8?B?S1d5K0ZJaVFhc2ZTODh2MXl4azA4UGduSEV5dkdmSmw2bHZhS3c0V1dZNita?=
 =?utf-8?B?N1QxNnU0Yi9ZNjA5MkRnWVVFdWk0emJ0N1Zlam9PMnRTbmdVU3Vhc1ZJd0hB?=
 =?utf-8?B?elQ0ZGxZK2JGYXN6R1lndTNMdFEwUXhNbkhzMG54ZWNFMlB1a0RRNVNMd1Zz?=
 =?utf-8?B?djR4bzdUWWxOSFVKVlRZSG0zS0ZSUGRXWWEvN2Y4UEtlQkhIaTYwVmxMbkc2?=
 =?utf-8?B?bGViUEhYam5zUUhmelp5aEN2eGtWbk9pYVZXalFTSStKUURWSzFTUUZOOVRi?=
 =?utf-8?B?MG95M0ZpaGlGZjdGNU1RVkk2dVdtamxxN2t0QlVrdCtWRkt1bWQvdCs0WnlH?=
 =?utf-8?B?dEtuOTdBMEZkNDI1SGhmdFRWR0FabFNHRHpKUzNxQzR3Q1ZSUFJydmdjWVA2?=
 =?utf-8?B?UVpqZG5tWGNUUGtqelJEdVd2NmwzMFlBVzJWQm1nRzRLcU9NYXJob0l0N2JS?=
 =?utf-8?B?NzRlT2Z0VWZqK2pJYU9sNVdoOWVjUXJ2NldaWnp1cXcrdnE1QnBLeFRTOHpG?=
 =?utf-8?B?NU80RGlHUW1DS3VOaDU4eG04N0NieEZIRTg2ZmM2dmhoVFdON1pxeGg5Nzdx?=
 =?utf-8?Q?y5LRPF/buJB03eYvQWUDUa2C3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c82ed6-01ac-4e4e-af45-08dc27073fc0
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:32:06.9748 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvG+KE8nJa830VauRhCRBEaBEX1No5zG5D1F1SOEoRrgOz2hNrqFAqt5lVXm3xHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6781
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



On 1/25/24 09:07, Michal Simek wrote:
> From: Saeed Nowshadi <saeed.nowshadi@amd.com>
> 
> Without 'silabs,skip-recall' property, the driver on System Controller
> re-calibrates the output clock frequency at probe() time based on the NVRAM
> setting.  This re-calibration causes a glitch on the output clock.  At
> power-on, Versal is also booting and expecting a glitch-free clock for
> its correct operation.  System Controller should skip the re-calibration
> step to prevent any clock instability for Versal.
> 
> Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> index f1b0a4aa65dd..0b97fa3f28ac 100644
> --- a/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> +++ b/arch/arm/dts/zynqmp-e-a2197-00-revA.dts
> @@ -449,6 +449,7 @@
>   				factory-fout = <156250000>;
>   				clock-frequency = <156250000>;
>   				clock-output-names = "si570_zsfp_clk";
> +				silabs,skip-recall;
>   			};
>   		};
>   		i2c@6 { /* USER_SI570_1 */
> @@ -463,6 +464,7 @@
>   				factory-fout = <100000000>;
>   				clock-frequency = <100000000>;
>   				clock-output-names = "si570_user1";
> +				silabs,skip-recall;
>   			};
>   
>   		};
> @@ -560,6 +562,7 @@
>   				factory-fout = <200000000>;
>   				clock-frequency = <200000000>;
>   				clock-output-names = "si570_lpddr4_clk2";
> +				silabs,skip-recall;
>   			};
>   		};
>   		i2c@5 { /* LPDDR4_SI570_CLK1 */
> @@ -574,6 +577,7 @@
>   				factory-fout = <200000000>;
>   				clock-frequency = <200000000>;
>   				clock-output-names = "si570_lpddr4_clk1";
> +				silabs,skip-recall;
>   			};
>   		};
>   		i2c@6 { /* HSDP_SI570 */
> @@ -588,6 +592,7 @@
>   				factory-fout = <156250000>;
>   				clock-frequency = <156250000>;
>   				clock-output-names = "si570_hsdp_clk";
> +				silabs,skip-recall;
>   			};
>   		};
>   		i2c@7 { /* 8A34001 - U219B and J310 connector */

Applied.
M
