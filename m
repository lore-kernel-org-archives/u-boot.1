Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F70CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 07:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24821847C7;
	Mon, 11 May 2026 09:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BYkZ1gY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCAB6847C7; Mon, 11 May 2026 09:18:43 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99AE8846C1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgET+ZncnGHW04nHgrwLLy+Pt3DEGiHq30WFli5RNJ/aITrNrF5XuNRZu/oEIPwe6yEM4+VA4cgYcqSwiXLLesxLxYApdIOKEqTGLxEXqGPKG4h08VeS2BfAVSapX0WjeXE3uVfmlilYX839mTC25fvTbNNo4LDF8Ye6nU9JVqFaIWeuuyXBstGXKobQa6Xb3Ro8uxgj0HeTl5HP/yXUkS4YG2TAkt0BiiS561YuYesuthBOUoz3JV76l3tbdXFIz/DhH5F/sP1im7oc56xcvP+K02wws8y2HOXH0H2xntydo0RYq3O6n86ofAwi3K8XSlGSOtNZnwBL2z2eGTkaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6kr05Cihl1oa4tZtntd4DPxRgdRuGLmUXVz+ARmHKo=;
 b=q40jkJhYHNL3FI9FrYS0ZYI6FwFs3oegV6Gn1SuZvz1hCNzPogvjPw7xGYL7eQo/PL0mT71jCWTcYuv/4k8jlGVaCgUgZcTd/IKTB+Zh/36+FDIkAEqWtsN+XeJ7wAPL+TmTK46vo0VgkwSeh3esPJUFbLovYuidDmI/2i/c9xJKqY3A7dnurNeN9CFml1zwQACvTPfvwmQCbV3JHYFRStvTLYcaVsHnjfLv3nsfsWj6lC4UZ24/MtAUrb2ZIslXJ1a0RSzWbxw0BAYuN2Dh/JoCAAOauwarx+O3R+k2XfFaHs+z4YevIZxWZGPAvcH2REA7E1tzNguxfmePG+3zOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6kr05Cihl1oa4tZtntd4DPxRgdRuGLmUXVz+ARmHKo=;
 b=BYkZ1gY68sM1vO7CuSukJpvy3MWI4xaFLgm9q2YtMTRQMRQgWHIM/IsAuddD5khGecysI6zFssG5Wd0EMl7WSS+jtDpZAWgHZiciBrAhpHKsTD7sSbC1u4Wmh5kgVdGBrUJTO3Z2kMscOij9O/Fc/EFIoBM0aSeB/W5VyhdQzRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 07:18:36 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:18:36 +0000
Message-ID: <1d3bc5bc-eea6-4a9c-9dd0-02e204577848@amd.com>
Date: Mon, 11 May 2026 09:18:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] xilinx: mbv: Disable AVAILABLE_HARTS
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
References: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:217::8) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ad37efe-597b-43e4-c020-08deaf2d84a0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: V3zV6rxwef+ykGHL6wWGtv7J4OpLkn/dkWD6FbkyJRClobniFMqiU3rAQfrbMma3R/wgjrwf9zWMhng1XfwOgXGq0QPQ3sOAn3KBvg8lySEiOZt58DphstWrKqB/Ytn39x33lFcwcjZqxRLtJSwPsne9L85RN3EHQ0SpJ5hsHUoPVRZkSrLPuzJMzyLMwXZZ7yaRMc2+xK0jRgy6AQuAkck9xgYZVV39QdfJav/fVcqbjsXlEE+84NpxLDc8oAAEA3dpi45K/Km0Hk+UNNHFyyLwoUXNthixMbTA1lSDTRxebbh4V/+8Di1L16T0aJXgxVNpKU/78KSj9Zl7z4B/f9+litnXRcDulardm76VneX2Miezb/M2rN0qyu46LWCCN2lQTapc3a7sE6raJNE7Lkkr7gqHEB4ftw6BXmeTOo3Ipdhtnrs9KyqN5imqoA46P2yT3zemh/btNAOWPaDRobTKyL31MqllA8MwS/WWBjWeVcN6caQgt4xAI2ZjXxaEV+gWp5Ptt12uWwvypd/i14q7zhKrYztD15RI5jvPIW7xFfynVjbc+tdcckOtZPmz+/1QoiLKyq/ZXZGgZxKNiaoLqWmsC5VG7Pv4ai0cbpgzg4t3o2HyN2jpXi+utiXePtYSKDvLH2+DHb1edFk61JueqmGtouLZgkSbleTW0sQ9te9ZheMDxmBdFllwbFa4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBCd2Q3K0s4Ykt1cVZSOTNmU0M2cDBaN0dwZHhPM2xGTUp3Qm9zQ3ZtR3dL?=
 =?utf-8?B?b1NSZlR1aU9FVUtpdzIrVUxaZzdoS0lKTFRBcnQ3QTRtRGxWRTRhUnFTUjdD?=
 =?utf-8?B?aVp2c0FLeTVEdkcvZGNsM00zSGx1Mmkrd3VLekFqai9iVjc4b3Y3WER4elZv?=
 =?utf-8?B?MVJXWmM2eHhWcEQ2bUJMZ3JhekJuSnNYVVdvY2FTWk1WcWRVajZ5S0pPREFQ?=
 =?utf-8?B?U1FuV2VqM2VtcE9JZEIyOVVDdDFuOVR1dEs3a2pXcW1FVTMvdEpMeFlBbWY4?=
 =?utf-8?B?OFk3QzV6cnp3Qi8ySjduWmFqVGRKU1h2dW9ML0xNNzZqQ2wwSU52MU5jbEpy?=
 =?utf-8?B?MDhlaXYxSGwvTVg3Vm91TUt1T2ttK09LUTFXUkxRVVAvdVdsbHpvRCtmY1dD?=
 =?utf-8?B?cFM0RjlVKzhiaFM3UnVRYjdMK0c2RklvcDlpUkVxY3ViVjRjN0dPbVZjbWgw?=
 =?utf-8?B?YVVMUEx2eUJKQWFBWFh0Y0JBb3hvVVlteW52NVYvYWZ2TUVZN0VuSU5SamxV?=
 =?utf-8?B?R3BYbDJ4ZzNtcG45NmtGS0k4eDgrWjBYdWlQckJYTU4rMkJDc29ySkMvb3BN?=
 =?utf-8?B?Um9LOXFvenp2dzI2NTdaZDROdWFLUEhHTG0yUjF1NjNxMTE1VnlIeHZ4ZjJG?=
 =?utf-8?B?TEdhWkliZzIyQUFZSG9TbGcvWnRwR3VSYWQ1MENtUjMzL1NTOFNGSEg1eWZO?=
 =?utf-8?B?ZzZscTFPWUxtVEFTSW92cXNNYk9lMnBnVFBGWXcxM0xSR0FBT3d2UGViN0RN?=
 =?utf-8?B?cGluV2MvR1lMdDllMUx4WFYwbDFhUm96VWtRMHMyeXZyMjZSWGtTNXhWTDRL?=
 =?utf-8?B?OG1CVjV1bXBUYUZIbWR4OVhJaFJ1bVR0aVljcWRsc29FaFlQTFZyZStzRzJn?=
 =?utf-8?B?Y2taOThSVm1xZ0FCcDd5clg4Q2orcE04WVlaRDIyZW9Pakx0clMwYi9HdWNB?=
 =?utf-8?B?d1hBaUpCZGtvR05TWStEeE91eGpNMnNFK3c3TGErakNYSWFhMUdiaUdSUFVq?=
 =?utf-8?B?MVpIZW1UU0MvbTErTnZDMlBibVY2elZjVXZKZWNwcVN5T210TXIzT05RdmhK?=
 =?utf-8?B?RHRjWkp2cU4zQW5TZVNTWnBNSWVBSk9zNGpVeWE3d1BJVExuU0pJZWYrRmtC?=
 =?utf-8?B?VEtobzd0R202QU1JVHM1Mmo2eGhybmxMZ1d4YlFvQktEMWVmcmFBcjIvQ0V1?=
 =?utf-8?B?U2xUMG83QktnWmVXazBESVRPd1R6UUF4dE9BSmtaYXRORHlWeGNPazVaNUFS?=
 =?utf-8?B?cm96ZG96RlVOTmVweEVlOVN2RDBtc3lVcGJBb0orYnZCSGhaZGpFa1NXb2p6?=
 =?utf-8?B?QnloRE1hdlQrZVZWVVQvSTQremc2K2FnR3EzNkNPOEt0alNEY0tnSU40RHZQ?=
 =?utf-8?B?SDNBN1VUNm0vSFhpby9Zb3QvZU5ZbEZSeE5SOXliUjMzNngzQVZOcDVtSlpF?=
 =?utf-8?B?WWkvTU4zOXRSNFBpWnN1REEwRnN1RzhRRWF3b2YzUWtzWUlocXI5T2E0Q1B1?=
 =?utf-8?B?aHp6NHhla043NVNtRjIwQmJRTTMwNGZLRmo3TUpPSFZjWVFhZGdnZStiQ2Z0?=
 =?utf-8?B?Um1yQU5ySjVldmhCQ1htRUI2clF2eXNoeHI5TXNQNkk5VEt1QkJXQ2hhU3dD?=
 =?utf-8?B?eitJK3d1d05YWWpyaloySlh4NWt3ZmZycDA1cFE2MXM1aFhqZU9HNTlEcE8z?=
 =?utf-8?B?dTMrS0YrY0MrQkRRa1UrTUFjUDA2cDQvOTgzd2lyM0FORHdnVXNid3ZKSzRn?=
 =?utf-8?B?UlphWloydVdnRlIxbEFmSmhSdTRCcjhlV0RSVC9GZFhMS0pHUjVKc0p5WGE0?=
 =?utf-8?B?WnhvNVVQYnpXQWFqWmlaVkMrYmdBZzRiZnZXTjFLWXpRVXpwK25IUU1nNWla?=
 =?utf-8?B?SnZBT1FwYjBMbjFiSEtvY05RWXNPaE80ajhyeDFCdjgza2Nya3ZMUFpEWGhB?=
 =?utf-8?B?ZGF6Nk4zUEkwZlZacURDOUpnQ1RweDF5eWQvRWRONjA5VXg4bjA3UHRzN0FH?=
 =?utf-8?B?clRTUkMvY2JOTFNwcFVKRXdjWHc0VE0xcnlSeGFHYUJYWm5GRC9xc1padWJB?=
 =?utf-8?B?UWY4TkxWaHAvYXRZUVJINnVoTzdIdW5NZDIxWEpKbkEyMW5OeEk2cXYvTnFu?=
 =?utf-8?B?bURwaG1sUmxjZjBwMXF1Y21vRlhLU2JBLzNJWUtmZXhTTk5NZDFTOWg1RzRO?=
 =?utf-8?B?K3MxV29xUkozYjU1amZYYUtIZzFtWnpObFBZWWNFRUEyclU3c0sxNXVwdnBi?=
 =?utf-8?B?eU91ZkpEUXdHLytTNWZyOHdBK2MzNTNDQ05lc2NWdHFici9YMEt0US84dzRx?=
 =?utf-8?B?YStOUGZYZkNxT29wTnJSbFRIN0Rja1Njb3paSm5NWXlNZzQzNXF1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad37efe-597b-43e4-c020-08deaf2d84a0
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:18:36.8096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gkyCG7eyROQwtjX7BSl+16iFsQ9gVdrnWiNzynIPVU0CsQAHc/ke9bK/6ugiIk28
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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



On 4/30/26 14:03, Michal Simek wrote:
> The MicroBlaze V platform has only a single hart, so multi-hart
> enumeration support is unnecessary. Disable CONFIG_AVAILABLE_HARTS
> to reduce code size.
> 
>     all -121 data -12 text -109
>     spl/u-boot-spl: all -68 data -4 text -64
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_mbv32_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
> index 4ff3bd6b6875..4a61c9eb5e3d 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -18,6 +18,7 @@ CONFIG_BOOT_SCRIPT_OFFSET=0x0
>   CONFIG_TARGET_XILINX_MBV=y
>   # CONFIG_RISCV_ISA_F is not set
>   # CONFIG_SPL_SMP is not set
> +# CONFIG_AVAILABLE_HARTS is not set
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_EFI_LOADER is not set
>   CONFIG_FIT=y

Applied.
M
