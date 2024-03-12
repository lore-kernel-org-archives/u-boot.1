Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD460C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 15:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FBB787D3C;
	Tue, 12 Mar 2024 16:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T1kyMUTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A533387DFF; Tue, 12 Mar 2024 16:05:15 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2884875B9
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbJcbSGD9JUhLSB6n6ArhGXnyNwZ5ea+vA5dzQGt+jDzd3QvL9rU5vR/V+cr511C6TDLsniAi12A0lBJ9Zq3Rrbf6NZo6/sl9XtNKKv+Nm/j6hZx2gjwwe0tBKhVcQQ+kbnztvQSNsHQz2nseEaKy5hf/tZ/ZF0lz/YTicL/AzvO9tiE5QO++H/wFLfQB6Ci/5o+E3L86hrS1eukKdYstjMx3zwH6L/WoczB9BkTLAJdNnBLZIC1TPtT57Zv5K6X/e9b6YmYwSj+7+2063AJvUQwvk7UU/H24AL14W+csjgOjB2VXoXo3TrWKmRkbKbdDZJwroU2Gcjt3/wwSgH0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h63lu/bonWH0liH+GlRrIxp4c692GvdhJHOKo/l6tak=;
 b=Fgu+29uQWmSADkSZ6ex4bOzkYDHZgbUex9/AdkkjIn5jaapYVAx/bsk339UyLSbfKWYfA6dmitS4U+FnxDLoU+dxPuXmRjscDnXCd/yhdBmXspW3zG63bbn88fvJVM0KJp1RFEDKEmOoZQtS6BPBnBzh5Kpbh4nOfu3aL0lbnD1PZYX+B7NIMYhN2wsQT8B34hrP/2K1CFykkVZB3l6TYIgCdF3qeiBFN3AKmhDjfFOO2xjs08Z7doZ8eAPUAjbeynhtyqRfik2vuRLe2B+cIFOqI1fHWeXVymK0WgBZdbcmAWBz5pdWQxzbNseyLFrpaUL99ktg6r6RJ7jsiLsEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h63lu/bonWH0liH+GlRrIxp4c692GvdhJHOKo/l6tak=;
 b=T1kyMUTtJfJ7mWdt/VtBfCu53we8uSsEZQspAMsihajS/AJKBSQ/gHVWnaOHPmR9GWeuVcQpcODX2OOQVftK0vM1AajBo3K/aAPv8sDYvGHqFfwYRX7k3MaIJAjONcbzsFN56kD0jmP9O+RMinxCNACKSVZpcrMw+2XmWhh9fi0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 15:05:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 15:05:04 +0000
Message-ID: <23e22e87-42f4-4039-8611-27f72bda73af@amd.com>
Date: Tue, 12 Mar 2024 16:05:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add usb4 to the boot targets
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>
References: <20240305110256.153308-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240305110256.153308-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: 73129d03-9f1b-4a6b-d08c-08dc42a5cc75
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIXowdaXkMm3dg/wVh2sRuriAAZ81+Ek5kQIYY+Uq5kjUNCkKG+xftF1LAY9WrMq/fmy1SlseCqhzp8171G4k2ilau3G2itzEeVBr5y716S99EwsYnfVOlVrhZPG2O6+bxljK9PCqeTWGk4LNptNJPRqMZW5WE7hIcL36WpZKRY0Si4r4QcG1CFrlqNLFJdZKXS2wHHDUSGE75j6j0cJQPPLQ2w2euiQtMjKxXDHqG3XzK5WtBmiW1QCZ5nW1cSAwFmnuSr70aAt7ng3gg0LuxBQIXsA8lCNiU8tB8gSoRc1wrmn71pCdqaPxqh5/OTMnOGI13hhKLrcFrxXXsP2WQLSBmkM/1UglyEz4+NhaG60nMEb1v1Vx8OQ+mTtaZszFQ90TTS9lt15r+DW1zDTFDXMYvUfGgRhKGcGkdBmEQDLtgTGf+tsnbG9+eoIe9XRSv8kppfcDZ5bGNKV8YN79qOpQuzgpzEC4kU0RAD9gAKrAhfKmcxa6AtC/yplaipHzxf5PnNoX2cPQUurFLHxcBg3R7PSUcmAG0MFmDYnhmG0qMYlHL4Eq3GzWk/hGX/ra2jSW8lI93hNCTyhuuFGSdi41J8+8tEZdF7xIf1+e30uSWFS+zR1JV2hDWZapnU8cXNDe3YYkwZjaNgaScgrgiKjD/AMR/eH6/cWG/rCg9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3JqYVNGemFMbC83TzFZTWwvL1dYK1ptUDZ6MzRIVHp3SjV6WC9FMWlvWlBM?=
 =?utf-8?B?TXJlYWZGaUdyUi9obmQ0YllyWHNMV0YwemJRK1N6bFZJdEZXVFF2WVRxUHdB?=
 =?utf-8?B?dWZtVGZUS3lnS1h2amZyUU01aGpCSWhCZkJaVzR5dzhxZlMxR2hUQUNYS1lQ?=
 =?utf-8?B?dldoSU92Z2ZEWDlQK09yV1NyY1ArUVBkN0RJTDdDNzNhQStjOUFjdVNlbTBk?=
 =?utf-8?B?NEljWi9xY3FHbERMdXhlaFFZWlBWY1AxTjZkbklta2lUNnlmb1M1R1h0VDdj?=
 =?utf-8?B?TjNFMFQ0VENxU0RYLy8xMEZCWUJ6cHYrM0t2YWZ2djZLNytYS2d5RlhhZWYx?=
 =?utf-8?B?WWF0OXJXbjdLRDFrWkN4NzBzV3NDOFpwYkJtb3FvT2prV2pVSHR5Zy9jSm1j?=
 =?utf-8?B?bVo2ekdqRVVaVnNFbDBYampzYXNHVGQ3VElGUzZ4MGhSUDlpSFBRNWdvL2ZM?=
 =?utf-8?B?cUt5cUZIOHJ2VnpXR2JPSnJBazl0S01pQUp2eEVrSkVHL1NDOEErek1lUVlD?=
 =?utf-8?B?UC9PM3JYQmdXeXVkemx3RlpQQ1JodFUwMFlwS0J4bGRJRnlDTGJGWFJZYVAy?=
 =?utf-8?B?a0VaRzA1RXdBUldCODJiTFRwVVg0QUpybU1sVzdPZm1pUUxLZWc2VTN1ZUk2?=
 =?utf-8?B?RnA1Q2lYdjNQaG4wT1J4SC9WbTViRmxZdHlvcVJrc29ETnFzTWRtMG0xRURn?=
 =?utf-8?B?OUg3L3Y0UHpPMmVnUWJHS0lDS0oyOWxpNGdQVE1UbisweStKM2lhWUl6dy9j?=
 =?utf-8?B?ejNYem1nS3lzK1dvaWFheEU2NStYTzYzUGxQZXd1Vm9tbWlKVHd2UGd5YzN3?=
 =?utf-8?B?YVd4OHgyQndqSEZLWXJvNmNwd0NuYlM0NmxtOHcyMGJLNWRweHR1SnpJRWJV?=
 =?utf-8?B?RWxVUEtoeitwVkxuZ1dxNkJLeWFoamJFOVZBTkxmSllIclhiNlhBRU83TUVo?=
 =?utf-8?B?SFEyeElFdURYSUxSMFBGdC8vS2duMEJ0bXpEa2NUd1Jmb0N2M1EwMEpTU0cy?=
 =?utf-8?B?bjVRRmQrd3lMZS9qME9iM1FUaTAyTC91M0F5dHBIOHIvelMrR3pPeEZHVjRW?=
 =?utf-8?B?THNwSEVtelR4ZnRLeEFIUEtCK0crOHhKeEgzSDRxbk91cytnQ3MvRVIzWjF5?=
 =?utf-8?B?cVNsbFFvTkRZdWVhRGl6dmc1YlV5Y1Zxbk9nWkJhRjRyVVZ5UEljeXk2YVAy?=
 =?utf-8?B?dmN2a3lqWitmelRmL1NVWWdKVVN5ZFpNOGkvM0ZKV3czNUg2WG5HNDkzSnlJ?=
 =?utf-8?B?R0hBWXR6b01LWjY2ODhnY2xSang0VHhGUDY2UzZOelBoRmxWYmJ5WnZSMUlh?=
 =?utf-8?B?NG5mRUhlNlY3SWx6TEErZU1QaFN6SWQ0NE1BeURXeGpxMysvdUFsZklXZXJk?=
 =?utf-8?B?MFZYY3hqamdjSmZzKytCdnVYQkVpbGFtNlFZa01IbjF1S1RVSlM3b2NnVEtx?=
 =?utf-8?B?UFo4MlpKVnc4VVRaVDNDaUc1TEVhMUs4QWU0V1EvQ2NYaVRlSDk1eU1Ma0lz?=
 =?utf-8?B?NXdSYWJjaVJRZUhtS0tJTmVJdklTSGpZYlpQOTdyTFM4dHpjUi9jVEJCQkdh?=
 =?utf-8?B?TnA5QnNHL2ZENEdSc09TcE5wek1NMWZzSlU1WjJ0RkY0TGJDeU91ZzlWc0lw?=
 =?utf-8?B?WHBkOHkzREhENUt5ZzhMaE9xZnUrVHo3N0dNTGF1MjhReWtJbTFINS9UMTNV?=
 =?utf-8?B?Tm95Zm5ZMmtKWjdTTFdNOGZPZzhWdlAyQ2cwbXFoanl5L1V1UzErZnBvMVor?=
 =?utf-8?B?cnVFdkJjbkpDYitmeHhSNVNLZS9Ed3NweW1NRTZud2xrR3ArOVdnZVlvZ1pk?=
 =?utf-8?B?cnZZNGsvdXBvMHRObWh4RGUwcVhJRjdQRDBrTS8xalQ1ZUtWU1B2cDN2N3Z2?=
 =?utf-8?B?REZLckNDN1pzNm9HOGNDbGtIVHNnamZ4VU9zZTMva2JzNm9qQVRiSW5IV1RY?=
 =?utf-8?B?Wi9hVFRsUnpsYnREL1A2UnM4MTh4ZDBPUWNQcHFwTFFGcDl6aGFUOXp4YVA1?=
 =?utf-8?B?UkpoS2xVa2NYdEpTYzlNczREWDdRSEVucmZJalVIZm1rck5RQjYraGgyZ3g1?=
 =?utf-8?B?VDRiSVpQcWtyellEWnBsV1lTVURTZWlGaFRKVHRIS1ZTZkQvSEs0cHNiVDhY?=
 =?utf-8?Q?KnZCR+5QWCfRTPGWcs48xlkwN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73129d03-9f1b-4a6b-d08c-08dc42a5cc75
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:05:04.8562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwr0IOlgKKC4DqH6g/7EaYPksn8XP+XVpDa8nGS9Fls5q70UdP+JSgXCg7JrOtJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186
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



On 3/5/24 12:02, Venkatesh Yadav Abbarapu wrote:
> USB4 has been added to the boot targets and
> also add support to enable JTAG.
> 
> Signed-off-by: Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/xilinx/zynqmp/zynqmp_kria.env | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 0f940bd68f..7d3ad31226 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -44,7 +44,8 @@ usb_boot=usb start; if usb dev ${devnum}; then devtype=usb; run scan_dev_for_boo
>   preboot=setenv boot_targets; setenv modeboot; run board_setup
>   
>   # SOM specific boot methods
> -som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets usb0 usb1 usb2 usb3 pxe dhcp && run distro_bootcmd; fi;"
> +usb_boot_devices='usb0 usb1 usb2 usb3 usb4'
> +som_cc_boot=if test ${card1_name} = SCK-KV-G; then setenv boot_targets mmc1 ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; elif test ${card1_name} = SCK-KR-G; then setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; else test ${card1_name} = SCK-KD-G; setenv boot_targets ${usb_boot_devices} pxe dhcp jtag && run distro_bootcmd; fi;"
>   som_mmc_boot=setenv boot_targets mmc0 && run distro_bootcmd
>   
>   k26_starter=SMK-K26-XCL2G

Applied.
M
