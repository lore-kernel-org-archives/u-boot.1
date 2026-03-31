Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339A5109B463
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 13:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C6C84035;
	Tue, 31 Mar 2026 15:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="igMd2f5/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFD6683A41; Tue, 31 Mar 2026 15:01:23 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7607083A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 15:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcG8g3aenXVhaCH08FbBvWxenmUt8KRnZUcfmxYDKcPMKTs4hCmuuJ2xO2xNx+mWUarQlPZWuamas48GM4hr92iU/M8+LCni59FxcO02Nv06v+RfQBZPwDiLZHqBJTjydqw/NWRYxrYAJMqhKHobkyojQJYnbhVKGnpKCogR1TeY1QMpTKHEbU4NhyjKjbyw7bh0f1YuuLHmhqEYflXc5xWsWbraRBOHBqGIaSmAeF2qIZIxHF9IC/FAPM4fD2fp2sYH1QBQKquV/LkGYqYYuvk77UlDpaYVCrdpgunguU8566djkgfN9dz59YHLcWWDy0MNXxh9WxxwEB6kwJuZGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot3qE6S+ffKFshHP5qJVNKHbH1HdH8kN4rTdwRlIsjA=;
 b=LKg9o9wCDyleoUmD+oxisCsJ0+tojeOZqAVJYJlwXiVb5eVRu8rxU9iVxxz1QBjJrCVSgfZ44YDvxOEd/BfTjq8pawXny2RkTzO66HjhxBYOdCVCy6kLLOFZ18OjaYzUK8SmmQ1Ti0+ZsoHglOEKVIQHhymRXWZP4TFuOeEPKqIHlbtlPxMC1E/kZ/4SkKoyDc7qPZUc6KaVis3pMF//JDCbrKajm+YoUTmzpTZqVmXc8kiNLvwQEailirBrkJNfef/sb+cEdtFpooX3QrXJ97CJXQB+hQCVP9PPa1bEGYflctUp+ow49A+EitZOJBX7LfHScyC8tUGvATjMuWK/Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot3qE6S+ffKFshHP5qJVNKHbH1HdH8kN4rTdwRlIsjA=;
 b=igMd2f5/XMbmAiaHQzcYSM0d7VsFDEtfBYKlX52utb1v2znOOPkuPdEiHYLc9me+dBxDtknt1fL0uY2SzTvmt5gTzwm7Oa6y+knBvyvuuMLCaMtm8XUhRh144KZzElizuu/yM2eM6oYQY46JtxvwHbmvEb3moeroMJJaa4YzkDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8657.eurprd04.prod.outlook.com (2603:10a6:20b:428::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 13:01:18 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 13:01:18 +0000
Message-ID: <3b2d940f-d615-4747-95ff-ad53a61a884d@cherry.de>
Date: Tue, 31 Mar 2026 15:01:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] dts: qcs615-ride-u-boot.dtsi: Add reboot-mode
 support
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 sjg@chromium.org, seanga2@gmail.com, sughosh.ganu@arm.com,
 ilias.apalodimas@linaro.org, gchan9527@gmail.com, mkorpershoek@kernel.org,
 hs@nabladev.com, marek.vasut+renesas@mailbox.org, msp@baylibre.com,
 dinesh.maniyam@altera.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 jamie.gibbons@microchip.com, justin@tidylabs.net, xypron.glpk@gmx.de,
 n-francis@ti.com, h-vm@ti.com, ycliang@andestech.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260330171419.1117817-1-aswin.murugan@oss.qualcomm.com>
 <20260330171419.1117817-5-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260330171419.1117817-5-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0118.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::16) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: a725dd51-fa49-4c8d-2606-08de8f259953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: ZBLrinFQOwtgi0vH909JGE9fBm+k/ChtuFFfA2XSDl532hVn9CVLGKVBWlwxLamcejaHaV+0Tjnq/B8tMRDveoKpoP3fD2Go3vdkRDf2D2Nw/kGm+yYcix39KbOdN3KfFzaez8D1ztQM7aTedUQ1plTyWIuvF+MbWgJruNjMJT8xoii5S3NmWT1IBasvXuHntgXWE1IzbcSjGLvw8hNL5Rsj/CiZK5oW31SMRZphHDr5e560ObTQNfy1nQ66MTofeVH/qtbRvY5XLZyto0uLThs4ma1tmu1xcP3++BLxErdZoE4WlvVlxtIL3CADxmH3Ct/fLGJxkSL3f0MiqPGxoVQCoDTo6JIt78Le7vpwb04G1HWdBBRjYzVAorlScRzTuJ7vASOeZrEqeXW3eeyTAGS71Nr1RsieDOFmnnkn6GQ3ZkEk2BoSLZA/PgUvYwq/svF7Q2iWaPtR31c48ZHVNnOWbttxmTZMz8jdv/FWeAa2HzWq8sNbeMokPCaGL4g3ufBTeTc22vsNNh3SvFe/OmqvGlg2KAURpwf4Kkxcia6YJTvkIDtVFf1zuUXcR0RtEhgUeOZVpdNLib86uIeLsUKyN/kGuIeRVlLTfvgv4/vlgtm9AAyL1x9saTomCbtSyuFapkjPCPGBblCvGuTjV4kzU68Ee/Xog9Znr6sqPCSRtSSCdrvjJMeFh1NHYgLXlz4PFw+Kig8+be2rc8CgnKJGzeuXEd8jha4jGku15EUzSF0t2ChSRa7bD2MMO9e8Z4fpXVMiYCBS4jPvbM9wJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjJUdXlVeHVLcDh6TUlra25OYk5rWUFweGwwVTFaTk1QUERhZzZta1MyUTh0?=
 =?utf-8?B?K1ZIOHNMZGtUbVc0S2l4eHErN0xLcGYyeGRlK09ldjJKaVRtQkw4eFd5RVEv?=
 =?utf-8?B?MDNWTWNVYjU3cUZvbXVKTWNKZDdaSytlMkNjTVVkNUFpUnp6QWUxRWw4T0pk?=
 =?utf-8?B?aVp6Q0lOMDR1QUlpVFNpOHNYU00ydHFuVEErZDE4QlRJK2hyZi8rYkZqeDJJ?=
 =?utf-8?B?OGtQdDlidmpLVTJxb1lyMlV0Zzhad2JIZlByc0c3ZVdsTXRndGRyMHJUU0hu?=
 =?utf-8?B?Y3ZpSmR4Tmp5OTYrMVc1N2J4V1lEVlRKYk5TaG5VN3pMMFhDMlcrN094ZGVz?=
 =?utf-8?B?TFo2dHJKeSs5YitwWExZRml6eFNVdmltL04yVmIxREZ3Umc1N1A4dEIzV1dM?=
 =?utf-8?B?ZENYakswN2lQNFQ4TCtqdFUxOTUzaHpLVEQ3cnlEcVZsV0RFM01oT3R0ZStI?=
 =?utf-8?B?OEI2cmsxUlBOL2RFUG5qdnBOcFZXZXdoRUVNejNtZGhQMUdicU82ejdqSlVv?=
 =?utf-8?B?N29uVEFJMlhneGkySmVXQ0N6eldvaS9aUzBaUEN2UlJTOTIvd0xaeTZUWGlr?=
 =?utf-8?B?OW5IaFpKcmpCR3RzRWpTUGM3Ry9iL00zckhNOGowQjBsUzg2dmh3T21vSFor?=
 =?utf-8?B?SCt1TVdUQURMd0VxWTZYUUZsVGtxai9WUzhOdWtySEVyWHZDRGFvVGxvTjFD?=
 =?utf-8?B?OGJIdUFDZGZYTVF3ZUFsOTBSTWpYWjRsZDQ1ZlZqR3luUE1iM09UaVRTTmNM?=
 =?utf-8?B?WEJpQ3ZBdWdMTGJ4SUNqSmoybU93Q2VZMzFsbDk4YU9PakpTblQ3RXBDRXRj?=
 =?utf-8?B?SDR5ZTlhVWtYVVEvNG5hekpnS0E1ZzJDR3Izc0pnckZtRXhUZGloenVTcjJI?=
 =?utf-8?B?Z1EvZ3U0WEE1RHNjOXkrTnA4N0E3aWdCbWlGT245Q1RPNndyay94d1pVaGZz?=
 =?utf-8?B?WHl5UTlWM0FOR1lVbWpHNDA2ZUU3cHVMM1N0Si9MZEpDd24wVXRvMEIrQkg3?=
 =?utf-8?B?N3RMVWlWTXR1MlVsV3ZtdTFaWmNPdk9PNlliWElTV3RxTTlWOHUzU094V205?=
 =?utf-8?B?d0dCZnBWMmI5YWFxSkduQmFXRmUvREpETS8wYmh2cDArNjNDTXNIWlNPUDVN?=
 =?utf-8?B?VTJxcDVGUjNOUDB5bDJZZHR1TmlWMmpESmNLb0Q4REJLNnh5T2VHeHYrTEV1?=
 =?utf-8?B?dnhyQkhmYkorcjlyTkFLcVBWR1Rrek4rVUgxWU5sb0ZCN2xrcmFMRnhDcW10?=
 =?utf-8?B?d3BMNjlXc3RKVkFOVysrak9NelA4TGhrY1YzN1VSSDlyKzZlWVlMV1REWDh0?=
 =?utf-8?B?QkFyOVZpdVduVXRMTHE1blp1eWdJd0h0dVRiS2pWZElsQzNlTUswU2lyZzU3?=
 =?utf-8?B?OUZzME1TZG1kVEIwMTRiMjVDdWYzaksyaTkzc0tPbmpXK2gxejZ1a2pzWG1x?=
 =?utf-8?B?Q3VvcXFSejJjOUF3VWl0amxRaXVGYVJUN3l0SUE3UXFHOGVWODBEZ3NDYjZB?=
 =?utf-8?B?QnRoVW15ZlNCdXE3Q1FPSW12YmF1WlNoZ2l0bnhrYkY0US96bDUzMy9WdEI5?=
 =?utf-8?B?T1IycHpKcFpZblo3VmN1R0h1SmdHZ1dyK1ZuWXBQQ3cyK2NVNGZiMjJvU09E?=
 =?utf-8?B?WFp2aGt2U2RYdVRtN0Zpa2VMUXduQVluNW4vVlBpRm42YzFadFBhSnR2R21M?=
 =?utf-8?B?OXhvMjBxbUI3RGxJc3dWSWRWb0lTQ0U2WHlka1cyQkswekNRbVdhWDJ5YlRo?=
 =?utf-8?B?VjBOV0wwOC95Skhnb2xETHRhTEtGcldhR0VrRk5tdWJwMFNLb0gvQ0tTTHYr?=
 =?utf-8?B?dzhzUVRWVkFQUnZpUHZQTEp6K3duVTY2SU9nNXg3d1hETGZQLzRmdHU0RXJO?=
 =?utf-8?B?QjhKczhneHdMZjQ4QnhwRW5BZW53V2dZd3J0RVdsZ1IvdS8yZ1NhS1VGZnBp?=
 =?utf-8?B?SVExbFRteDlBOWJLQkkrVmhKN2ZuNU9xYWdQaXFRaEQvL25wcTIvT1c5SkFG?=
 =?utf-8?B?ZkJqVllPeFI3ZnF3ZE1KUjV5Nk1rbGxWZWtZNm14cUZENGdjbkZhNmRIcDV2?=
 =?utf-8?B?cGN4aWlxTkd1SWN5RHVyL29GZWdKUkhtOWRhL2hMRkpQQTdNdFgzT2dNMWFR?=
 =?utf-8?B?Rk5Lb2JRaGlXNmxyMkM0Ymlmc2hDZlZOSXBZV0x1Wm01eExXeU1ZOENMbVhI?=
 =?utf-8?B?cTBUL1dxNVM1NVpFU0w1SjBNNkFKUitWeEgvdXdObG5ZVERYNElPY3M5Uk05?=
 =?utf-8?B?MnRNN3M4ZDRTR0VvbkV4S05RR0VjaGxpdlZnUUVGNFVtWWNIRjg0K0p3NkVB?=
 =?utf-8?B?S292WFZXQ3BsUmRlOVR6dnhuM3FRT0ZaOVlFeU9iTTFoYUh2SThwUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a725dd51-fa49-4c8d-2606-08de8f259953
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 13:01:18.3537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mNbFc2vl2zcXgHixM9buyUBTlLM0jFKCHXYe+NxhJ0LXBlXuuO9yxuX/pVkuiibziej0Dy5+O5rRP/sdlpAOk4bGWoLtzQl0kkAAP/mJN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8657
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

Hi Aswin,

On 3/30/26 7:14 PM, Aswin Murugan wrote:
> The PM8150 PMIC on this platform uses the older PON (Power On) register
> architecture rather than dedicated SDAM regions found in newer PMIC
> generations. To enable reboot-mode functionality with the unified
> NVMEM-based approach, add a compatibility wrapper that exposes PON
> registers through the SDAM NVMEM interface.
> 
> Add device tree configuration:
> - NVMEM node with compatible "qcom,spmi-sdam" wrapping PON registers
> - Uses 'ranges' property to map the PON register block at offset 0x800
> - NVMEM cell at offset 0x8F (PON_SOFT_RB_SPARE register)
> - 7-bit field (bits [7:1]) for reboot reason, preserving bit 0
> - Mode mappings: bootloader=0x02, recovery=0x01
> 
> This wrapper allows the SDAM NVMEM driver to access PON registers
> transparently, providing a unified interface for both PON-based (older)
> and SDAM-based (newer) PMIC generations.
> 
> The PON_SOFT_RB_SPARE register persists across warm resets and is
> automatically cleared on power cycle.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v3:
> 1. No change in v3
> ---
>   arch/arm/dts/qcs615-ride-u-boot.dtsi | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> index 68fffc70fcb..50784807cf4 100644
> --- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
> +++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> @@ -11,4 +11,30 @@
>   		      <0x0 0xc0000000 0x0 0xc0000000>,
>   		      <0x1 0x80000000 0x1 0x00000000>;
>   	};
> +
> +	reboot-mode {
> +		compatible = "nvmem-reboot-mode";
> +		nvmem-cells = <&reboot_reason>;
> +		nvmem-cell-names = "reboot-mode";
> +
> +		mode-bootloader = <0x02>;
> +		mode-recovery   = <0x01>;
> +	};
> +};
> +
> +&pm8150_0 {
> +	/* Virtual NVMEM node for PON-based reboot reason storage */
> +	nvram@800 {
> +		compatible = "qcom,spmi-sdam";
> +		reg = <0x800>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x00 0x800 0x100>;
> +
> +		/* Reboot reason cell at PON_SOFT_RB_SPARE (0x88F) */
> +		reboot_reason: reboot-reason@8f {
> +			reg = <0x8f 0x1>;
> +			bits = <0x01 0x07>;
> +		};
> +	};

How is that U-Boot-specific? We're trying to have as little as possible 
in U-Boot-specific Device Trees and there exists a DTS in upstream 
Linux. I see nvmem-reboot-mode has an upstream binding and driver and is 
defined in a few other Qcom DTSIs as well. Same for qcom,spmi-sdam node. 
So it'd be nice to motivate why this cannot be upstreamed to the Linux 
kernel.

Cheers,
Quentin
