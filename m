Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2358BCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9C084198;
	Mon, 11 May 2026 14:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5DTDmfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D28847C7; Mon, 11 May 2026 09:53:56 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0277846C1
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 09:53:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irvV5tr61U2AfkoEAwXqPlgSEWrmGGo0hgBG3IecKFGbyUqQmhD8YNSttlKCo5j2cwUJG8tVd1qGalp4NEY2+6X3irUSO+KBcT3Kd7bUUYKv4+FPRR64ixBfWBGSRm7dmLK0JlrWJbCZKuNpRue8LH6fxXffE3VeG3nqrpo48pxZPw1MRezwazPSGw+xBErTc/E3aj8RqZdSRhde7hvXhZKHXrFEhiSHbEYXyqi9Ly1k9aT+dV6GUFgcwDnjySAbtAVPQ4VxieahBodOCV1PpS6otU1eXgrtoae87DDvQgj8tS82bgBbe9x1C3fDHTzw7ZjRrSPx36l6w1Z3O2HtBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oy4r8HIBqUUHEByq7cy9wuiC6VlGNnz3uNid9JbMwCI=;
 b=NDiFk4Hnmn2cKS60TgQdy7U5hhQOv8qmU1HFKhPuCezjMLLtm8Xf69VM+a/mDMIWBRqvpXUKei5DV2cm3ZXynPrzdj0O4rh0v5mdNzh5CazMHW+aEsTkFPGYF7hsg8PDBrwq3CKpO1SZw2/ekcbbXorEG4XsDYl8AjRhwXsX3rdKnIl13/tNC0tgl0paWUzJ+kPYagjIhEbsnvLF5uRn4aaLEe08Fet1Z2KsVCJvY0etOHLA+wdFrpyWQyUTF2nM0tdz5PQmaXm2BeQVq3wAKQB2tQ7Uqyys4d2YyhowAd8iKNNKhdXcbBupvj9OphNIVxYkGClZSrQapmQ8FLkvVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oy4r8HIBqUUHEByq7cy9wuiC6VlGNnz3uNid9JbMwCI=;
 b=T5DTDmfZkEDB9PtCi8psnirTKw6LF3qiSNF4thpK2IKtgJF+GNE99fwzLTHkUVDL926dpP/XUP7HTGoE4maftTHP4Qu2KrHK3BCrQnOtauA+pUabuHLexqqPDK3ibBqJ8FHHlXjkNhD9RexM7ROoOLP5oLtACxn19bmQRuC+scs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Mon, 11 May
 2026 07:53:48 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 07:53:48 +0000
Message-ID: <974ec8a1-24ce-480b-a336-d3f1decd1b81@amd.com>
Date: Mon, 11 May 2026 09:53:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: michael.srba@seznam.cz, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-1-7d0e22aaaa8f@seznam.cz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260508-qcom_spl-v7-1-7d0e22aaaa8f@seznam.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::20)
 To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: 00191778-3747-4ffa-3823-08deaf3268a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /3Zza+LZ5aBEL1vdJIB8IaCUVoZzIJ7cxofOr8kD1KP/WqH0T5U/1PKhECbIecuVo5vYDlB2NTO9UJ1dj1Vxy8GIou/FXUt16PJRXM7LIEkRtPgs+rOOeEqeexuxmUcJ9nl2plFfXjlUldQ1NxR2fEDgq3VSBDDUMBCPvHeJZ/Qh1wWzQdTrSFLdupmrXOAtafICDWjlAOszKJeoDzNVX2Pvccr7hieM0GNBRETch4L94+JA2Ni2fqqHsmwr7rgnrrB4LY0P+MIH8dkPTfh5mHq04xzQzCQSJQOrhazkKGbQegqFHB+V1S5bt5L+hTjARRgzQ/PFxFTybvAuuWSFdwdzK5Qt716eKyRH1FxiGv0XkDVe+QYxnX7SQif9hwg4npC2TWH15d2ACfnTOJP8VtLnqKPdqtQ+F/wcZ01LtHaItrhZdo1xHh07/YlOvmCoZHtJ7hGnC8EVJWPLCtrQ/XQ8n5XbnE0fbnCtln1M8v3ANGkzU4BJS03A7mZFPrpgLnFhHrF6qNrXPobv8O24CvTp5KRHhK+M3wAb5rtFRfsfpUqEcS2t8+6LJ57iBuqYM7bqFLsfQQtNiQkNzq53GvHYimd/u0WIxWHgjaURjVl9iK+F3kQ1RHjcNlokTU/5qrTP4ZqTDxnLq4SsWSlEjOmeilmW1cqL7rRTQ01frrrGHYIFqRvLyHD4Pp71C8Du
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXIwU0N0ODlTNWo5VHFSV3hMS3NsdmIra1JRcnJ5Ri9sNTVrSlk4LzcxQ2Vt?=
 =?utf-8?B?bUZzQnZsZTJCcmd3eDFPVTRYZ2Y0OXFyby82WU93VlhUQVBMUnVxNFBCN25a?=
 =?utf-8?B?b3QzTFk1aUlNTDVyRVNHVHZCQWlzR1VBRVlOczc5K3NRS0x1S01EbDNMaHFv?=
 =?utf-8?B?TzlVNmJZcEt2Y0tySmRvbFNCUmFNaUVVTGZLVVJVc3dwUVBRUTBPWWFxTnhJ?=
 =?utf-8?B?SFVFT2daK2kvNEtoVjZUTkJRcmtkSFVwcHBqbm01bXduNzI3Z2FQQlhuOWla?=
 =?utf-8?B?SjZaOWxNRnhxajNkaSt2Z0JFem9mN1RBQjFBblZEOGdOc3JSNFdUbytPUklr?=
 =?utf-8?B?eUJsdm82bEt4enBuVXV1SHhJNXArV3E3VXJRdHIwMzNIdXMvaC9VNUJEWHFB?=
 =?utf-8?B?SStmWVRtdkdyN0hjL2NyMUdNM1BHdlJJamV1am9qN01tSDVWM3Y1bDFZVWNw?=
 =?utf-8?B?eFFrdnE4OGZVMHVSNTF2UkUzMXIvK0hMWGZGK3UyNURSRmRhMWZLMDV3SDJu?=
 =?utf-8?B?aWMzZWt2NXZqODNOUmxMWW5GQkdiMDFXSEo4NTR5T2RhRklBanVhSzBmZFNO?=
 =?utf-8?B?eEJQNC9HM1Q3dldxTXIzK2Q1cklpTnRCb0VFUjJQY2tKT0Uwd2l3dk0zcDRz?=
 =?utf-8?B?ckdJcThXQnBmNjJzY2ZKZWtPY3dFUEVXR3Z1anYyZVRUc2ZUTkNWblNTYklN?=
 =?utf-8?B?eGd4aTVKeG8rZU5WR0NUWEY1WHdnc0c1QlZNc3F1WmpQbXFHWVZQQy9USUFD?=
 =?utf-8?B?cG9tOWs3aGY0dFJxSStSM3dFeHZxQ2NOUlFTK2d5dXJnQXlmZUZGOGx0OVlE?=
 =?utf-8?B?MTFVdWMycUpwNFF3WnhrNjh1d3RMUkgxU0xQSnczNm5ld1A0TklFc1BNb0x4?=
 =?utf-8?B?QTJrOHRnR0l2ME4vVzVaZk9pT3dRMHk5NFROQ2hOMGxDcVVRc0VLSURqeWRL?=
 =?utf-8?B?aXZBSnRxdkplNTVtQzNjc3k4bGtNbHNqWENnbEt2OUV3djFhUDBZNnZWVzRi?=
 =?utf-8?B?QnBnUFAxNTd1cEJ3MDZSYnUyTUE0VlJndFdLVklTRFJ2TXRrZ3VPVEtvUTN6?=
 =?utf-8?B?OWZWMzdBN2ZLNmNraFYxRkxzQy9zMmw4SE9xdWg0SmVxdDJJdUw2cCsxMzdv?=
 =?utf-8?B?QXM1bldkTXV6bVhIc1NmY0N1V1c5di8vOC9iVXJ3R0pyQTR1SCt4ZEhadDZr?=
 =?utf-8?B?cjhiOUtuSmRPdHgwRjQra2FJTVlMWTdENjB3RTVBNXZURWI2eUNMTXgwMUhi?=
 =?utf-8?B?TmRiUHNRelBMSHdkSXRJY2NDN0hGanlwSnFwaFQ0TnYxRTZaem54cnN3cnFE?=
 =?utf-8?B?OTVMODVzQ016NDVodVMxT3BhdHJDLzE4MVp1bUl1NWh0cjFVRGxXVXN1b1dq?=
 =?utf-8?B?N3pmK09xR0F3TWlXc2F2cWM1Y1BYVG5ZWTRjbjlxLzVST281bDJJRmxKV25L?=
 =?utf-8?B?TldNZTR6UldPeWNKSmNLWW9sWlVkZllLa0RHWVovUlE5OHBLa3JQZW1IWUNa?=
 =?utf-8?B?cWprcUIzcEQwbm5tb3ZuTkI5bGhGVVlqV1QrbGc1MzArd2V4eDg2dk9zQnRl?=
 =?utf-8?B?VmU5Q3ZoSFprejNod0NlazRVSzk2S2VYWllYcWV3YXN6UFFLOG5obnQyeVFV?=
 =?utf-8?B?ZjJvQ3dVejJKaG5oTVBSaTVVeGsvRDRXOEJ4YldBQzR4cjVOYUtNKzZvQ2Er?=
 =?utf-8?B?Q25PeGN5ZnFJVEFHTFpOL3lVYWFVQlllTTBnRDYwUkx2TDRoTXUzNkZGMlMz?=
 =?utf-8?B?YitOZTZXeUVtR2ZRUTY3UE94ampPTWtIOGcrellTSWIwMUhYZ0JqaXZtK1NY?=
 =?utf-8?B?dmErZ3FpL000V0F1SitORXp3d0tLb3AyazFRRVhQSXF1REZTb2lKRWlXWmFo?=
 =?utf-8?B?T3pwMzMzUHZNMXFaQWllT0oyWnBsaFR2REtZVVMvTm5XbHZJN3FKdGVLbzdJ?=
 =?utf-8?B?K2FmcjFxdTFsc2g3Nm9qMW9jaklFQ1gzMjRaNFF0VkVyYytVNkluWlhmSDNh?=
 =?utf-8?B?a0VyV1NJKzZpSitwU1N6WXh2S21nKzFjNUhWL3BsaDFVbVRjM0IwTnFHVno5?=
 =?utf-8?B?Nm12U1ZWWVFpQzhBLytFVWkvTTliMzR1WVpKcFVSNHRDNFFDeDFjYTJIdjJs?=
 =?utf-8?B?cGlpK25LWm1xY2pPMWE0Q0RlWGttT3B0SW12TGMvNXZXdVlvQWVoRnpHZmJC?=
 =?utf-8?B?czZUYk40YlcxM1hjQ1dIU2RLT0UzeFRsK0l0RE52aVM4Y252OU0vNS9EcXpi?=
 =?utf-8?B?ajRRdGN3OGRuTkFQSDllNm5jcmNXQzZJdEVIQjZwcDM2SGtpbWNadThtZjVM?=
 =?utf-8?B?UHFtck9WakpuOE5FZThUODdNQitUQlJuNzY5SEpMSHBRVXR1dlJDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00191778-3747-4ffa-3823-08deaf3268a2
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 07:53:48.2413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSbipZOZpmq4iRcAyYXTj5YslDtOIba26baDEKnYNM53vOcidbR4dNQr+/ZMPf3y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264
X-Mailman-Approved-At: Mon, 11 May 2026 14:51:08 +0200
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



On 5/8/26 23:45, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> Some platforms (e.g. at least Qualcomm) use the ELF format in creative
> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
> as the default).
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   Makefile           |  9 +++++++--
>   common/spl/Kconfig | 12 ++++++++++++
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 49d9740327e..8fe722f6c0d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2008,12 +2008,17 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
>   quiet_cmd_u-boot-spl-elf ?= LD      $@
>   	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
>   	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> -	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
> +	-T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
>   	-Ttext=$(CONFIG_SPL_TEXT_BASE)
> -spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
> +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds


Here should be also FORCE to avoid warnings.
Actually that's a fault I did in my patch
60ef345b1a1 ("spl: Remake SPL elf from bin").

If you want me to fix it separately I have a patch ready.

Thanks,
Michal





