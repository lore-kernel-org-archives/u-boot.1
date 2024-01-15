Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723BFC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 09:30:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7183984694;
	Mon, 15 Jan 2024 10:30:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rKeNiSpD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C45BC84694; Mon, 15 Jan 2024 10:30:00 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7197F807AE
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 10:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdrKgF0EGKHPY3j7hrXCbtl6Z6MYu/sS6G8rluBJT5C23r4glNun2/XgMmgDdM0R2Vb1SzMGFuorTM6iIm/jPnTDSrYVvk15nXmka0VmHsyJCvJgtBr/vH7ousBXT+rjTMCK9C1dw50WD2soRRrdLfDBvW0mp/wPWjiZvit5LYEASShRiqMjnHURmTEnYnU+EtECyiJlgFYPSctDsuuAE0nNoGRjc0PJ6yBHC6I0EC8IaVdthxsafkkZPHPQjl1/CoW5p7zyDWKuO3Q7qk7dLlKEadfGuH+dFNaTd4NmNjPYv96prI/eRuLU97wLBgnx1un5ULoC5/cLKE1Suw5Myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdlKPR0JfLsgHGrX2UwNlJ6yrC5npRrJTTResolKwVg=;
 b=Y/n7WtG02XtuARu3BZcIvxw7OUnkhCij0pZL0vQJcCSyLsaN8Q/L6JKNbxmk4SWFGoD/Pk4IpGCdl4iOi+eyfu3OJTsswKFHIBQsWz74U+9b6Y0cUerofSg0wuU8ouxUCxvnsUmHbcoEQPhCt/bQOG27Q2zUPM36F+W1cuXnOrVFjs068CqxKYiPUuxPlCiak3/SYoXMXICN7kPVybG2sIs/l3635/2tPsq7pWBsuEGjG01ZrsOIcStGbowUSPPFhqcyH2942hbLiUWiu71Svq2ytAlNCg0bXjZ+WHSH9haNdwm0U5ZF2gghpolJBepnnCbFPZ2g03NflykvHnRLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdlKPR0JfLsgHGrX2UwNlJ6yrC5npRrJTTResolKwVg=;
 b=rKeNiSpD0nIyASwgsSe8Ix+Or1u1b/ERWr+6SMKAesMLlLTBoGCTZFRwneGO8251x4ohOKKtfa7e6GbUJosMq1tCJVRsCHKmBnJjNn3tnn4gBL7XgSkS0WbOKmvOUnAt8+r5kn+df61NsXgaxGYSUC6C1AKJyOjXWI/r14fcADo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 09:29:55 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 09:29:55 +0000
Message-ID: <f47bca4c-e8bf-40f6-b3e0-961810ab1414@amd.com>
Date: Mon, 15 Jan 2024 10:29:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Describe interrupt by using macro (OCM)
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Piyush Mehta <piyush.mehta@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, Simon Glass <sjg@chromium.org>,
 Tanmay Shah <tanmay.shah@amd.com>
References: <6a51f47d239002679db03a787057fdc58610515d.1704709554.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <6a51f47d239002679db03a787057fdc58610515d.1704709554.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:803:104::32) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a832180-c6f8-4927-767d-08dc15ac88f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQFTPcSuv93Ne9kFvmzRzmPph36/L0XXhtil95gvXbD9vil7sB/tGpwryBkBHRs/sZBQE2F3Jq6JSyYLXZQ1z66WYsTromc3cowTBLXSykkfG9Ua9jqdbm/i8QEOYbvunwjYciTvZKpMkh+T09DTfzDSOqP/C2nAtyu0WD4kS3DHcSDSMHoH9LWGlSl6isGEqUV7g25g9uzc4Q7dStI77rqkUy1j3k2VDhYyELk8/AbZoisbAuFOppPAb2nowC6gF49Y8TvTwuuDQ7BbCZ3tUHs1PuG1CItSlbPPuqBDztyVeT4pzT9+AmseVe6D4tmwANNraa3cfIJwlcv3SxfYcX0kuczeEDAwsuzJ6ZzxvqveH9ZKoA9gn+s0LYqGZ0UNx4IqNV/yU1BQzwv8VEj1aAnjgxJvPQRb3eY0LCtyCc6SpJC0WEoDtlLYHfw+W6oCnXfmp9tFQm5EOAZTBtCbdM+gjY+cHYtB2ScRdQQRaesYm5iHzR7bV2tz5RL/CJElvTx9cV6nirlG0puEiEL4EVOkcmnr7PPLpBEWsm76drbVvs6mZiXt0v4zda0HLHaIjaViLIKMxR13wTSZM20K/GQOFo9I2iy9DKZsoxHWr9kvrqZihkH7DbZEr0a+2/14/wr8rVrqhNk6U1ZJky4EZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(2616005)(26005)(53546011)(31696002)(6506007)(6512007)(83380400001)(8676002)(41300700001)(86362001)(44832011)(4326008)(4744005)(316002)(5660300002)(2906002)(8936002)(6486002)(66556008)(54906003)(36756003)(66946007)(66476007)(478600001)(6666004)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVuTlZFWXY0blNON20rQ1daY3oxU2NLK1YxY0dZT21QUXVVMm44elNNTEs1?=
 =?utf-8?B?QmRMQ3hSaytpa2k4NGtiYVdWOVdtUkVVWkZINXgzZnUvMEUrR2VNci9XS3FH?=
 =?utf-8?B?NWdZcUNvem1Kem52Z1lsdHpuWlBaSmEvblVkYW1KWTlsK1FuMUdPYUpHTlFO?=
 =?utf-8?B?Q016U1hHczRicEZLRVdvVG1kNms3Q3NDL05FSS9YdTdXQ1hpbGF5cVR0OVNR?=
 =?utf-8?B?WEhNY1EvazdWKzZORk90RkVSbTVrUjlpb0JrNUpsdUw1cm41NE1jQjEraUg0?=
 =?utf-8?B?WUpuMDc2cjdDdnd1cTdvN0RUNHp4V0RKV3I1bmVlamg3Y0JtbDk5cER4Q2tN?=
 =?utf-8?B?azZsSlpEMWhmVTlYVGlvbUZVam1OejEvVU5pWFRRYkpYU0hFVDdiZTh3ejVW?=
 =?utf-8?B?QTA0VFM4c2VkbmJuSmdBNEpNaWJkZEM3TnhMd2gwUUpDYkdMWVp1aWNjN1RL?=
 =?utf-8?B?TWg2bGFDRTNCVkcxMmZNZmErK2Z3KzlSS1RlQ0NDTzlJVWluUjlZWW5IeGM0?=
 =?utf-8?B?dEJZRWVjQTBtcnFDV1Zyb3FtSWNqQ2liSDRxcVhBNnpQUzhQY3YycEhZRThm?=
 =?utf-8?B?K0lydjF1U3FKYW1hT1NRMjIvUy9vL0JieDJsNStjZS9KYlp5V2tPRlg4ZjQz?=
 =?utf-8?B?UkhuVWJRTjVqZXpGcG53ZjY2TFVRTGxET0dlai9TY3AzTjkzbU82MlU4bFVr?=
 =?utf-8?B?bzQrcGtUUVduTkVsNGdOM1Vpck5RV1V0dnBUTW83SUxmeGFtT216Qm5RcHo0?=
 =?utf-8?B?L3NmQnNGVmwwek9tVzEra29paEdrcG5rQlN5VWw3QlJ6UFVSanRNN1VQay9B?=
 =?utf-8?B?RjJrRHJoMmd4Z0xCZmd3T2dVc2NlZ3RVT2F4RVRzaDVCenBHNC9qbDRyV2hK?=
 =?utf-8?B?UmYyOVFwODdaVUhUUGlzcDQzRk1PbXBXYkdyVGhmUlhEQnJ0eUNwVWFhTzdz?=
 =?utf-8?B?T0FLMEtKb1hHVGVSZlVpRVVlbVkxV3d6WXAzc1lwaFA2VVNLUFYwb2lQUHls?=
 =?utf-8?B?TCtlZlcxMTZDR1lpUk5Ta3orRndEZldlaVlxcDBvOUVidm95b2cwWGlBU2JE?=
 =?utf-8?B?KzVJeGtCTXJvTVhVMUdxWjVZMjg0d0x4YTFvbk1NbCt4NDBvb01rVXBDM05N?=
 =?utf-8?B?RTZ4dmVNU1BLUGFmY01QczM5eVNEcTA2UDNneU9XTjBqaFRucG9QOC9LRDcy?=
 =?utf-8?B?QlgwYzBsVm5Qb3o0NDZLRHBLQWUzbEx0ZUtQb3EyR1FiZEE3OTdXR0VCYjQy?=
 =?utf-8?B?ZEFBRlBheUFmcFF5dzBNclhWaHFpcDVZU0p4OGtkUWxBY0YrYlZrcHV2bEJ2?=
 =?utf-8?B?RGR1Z2gzN1RSTEZLVGptVjZBU0NIblJDd2dhWFpxam1XM295cjZmeEZzeUE1?=
 =?utf-8?B?NzlOUzAzUG1NTVUvVTBjSnBhT1RtNW5RYytYdVB4L2RVMVNkT1p4REpqa3dP?=
 =?utf-8?B?Z2VUNDUzT2RuMmlrdzVKU29WUkh6aCttYlhqTm5LZEFLUlBMUGZxNFY4TlBo?=
 =?utf-8?B?TmU1Y1JuRjl2MW4yckZmSW1Qd0RNYkdpb2ZXaUFUbFFESnFGUGtDWjhBYmtx?=
 =?utf-8?B?MklYcXdHQ2UweVA5QkhLczBscU5sZytaVDBnQnY4d2lKNjdTVzloSDB1QUtm?=
 =?utf-8?B?Z2ErTHl3Mms2Y3dCOFRQOFhiR1ZDNUVDNUZjVk9Ia1JtTmxqdzNXbFZXN1py?=
 =?utf-8?B?WlBRSzhzOUpmZmZXcnZCeDZYYlpUQW9GSzlwTkUwejFjaC9iRjFIVWw1dk1k?=
 =?utf-8?B?T29mK0xGeDlmNE5lc1VsemNHbEVpdkFvdjlHUS8rT3VJZzhMeXlhcVFEOHUz?=
 =?utf-8?B?TkxFUnFWOGh6Y1RMY0Z5cUt1ZldNS2tnWVJQc2taTU9MMk9zRTBhZ1F0WkE0?=
 =?utf-8?B?WnEzOC9GZG96MW82ekFnOGM2cTBJY05LMVpOanpWRWpGNldpVEpjN1JIZ2Zp?=
 =?utf-8?B?U2M3QjJOYU1FUE5QdlIzUVVPS0V6dG9aUVp6RUVXUGF5QU9DcHdhU3pQK3Uy?=
 =?utf-8?B?YllxOUhveWxoVXVTdVlieDV1cllJTFYzQWg0TDFKRytNdnBsT21TWGF6V3Zj?=
 =?utf-8?B?bFpIMEtJa3p3UjNrTzJhdnE0RC9JMDFSRGVGcmJRdE8vTHVWOUpvdWpwbWJx?=
 =?utf-8?Q?QFIO5tJ+j7J7nYa0A6QNwCHri?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a832180-c6f8-4927-767d-08dc15ac88f8
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 09:29:55.8223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw2KwzOWffogCv7XSAAgVfyKsUY+GRPVNxEXlK/1ooF9VAHbATrb2wLeLlpUyy68
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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



On 1/8/24 11:25, Michal Simek wrote:
> OCM controller interrupt description hasn't been converted by using macros
> that's why fix it now.
> 
> Fixes: 6b049190c9c5 ("arm64: zynqmp: Describe interrupts by using macros")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
> index 21be909b1abe..9cfddb8d25eb 100644
> --- a/arch/arm/dts/zynqmp.dtsi
> +++ b/arch/arm/dts/zynqmp.dtsi
> @@ -737,7 +737,7 @@
>   			compatible = "xlnx,zynqmp-ocmc-1.0";
>   			reg = <0x0 0xff960000 0x0 0x1000>;
>   			interrupt-parent = <&gic>;
> -			interrupts = <0 10 4>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>   		};
>   
>   		pcie: pcie@fd0e0000 {

Applied.
M
