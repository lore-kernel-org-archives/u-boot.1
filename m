Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6722CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C36C871FD;
	Thu, 19 Oct 2023 12:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1UFLr5Qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C225587212; Thu, 19 Oct 2023 12:29:36 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A4087208
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2P60UmJYrNxGHM6ND5Gl0Ak7LZ1ucS9NKij52cGSeuWqMxUfmfdewPKOjtnko/koSKbE74XB3Xbxp5zhpj7bnWnMBbCdDW1Hx3GsYhAIojP7DNbZPcA8xifGmu9IeuNTjWmF8CBBLT4OalZN522UCXNuAMubkDZ9g7waC459hBa7AuA/liQiElQbpEFtHaLpXGWiuPzBW+nio+dt88sUCs7LRhjb9HL+I2Y9Tlk9aCGdUOohBG5kTsE1Ys97JtbKwJnEjdYGwEaJnQIGzJrzQDCqfuaelXK5Hn3Wo5Zd3LDb3r0BeAURXFX3MILdS+aVcobnZu355yKaPn9XCOOpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8uonstJ/GH47wjwGlzuuTxzoT7Ml8sf1LJ7ST+BBzg=;
 b=JkdvuJ1cxknIVJRwtLVT3TKG2HzRoA33/AZfKRIf4pN3sSib0yxRNFgFhiFHoxZWQCCmM870Baj31avlpYSPKjgCfDOHcjehEjYvW/SrlT/X6WSY5xL38RxR5uSy5btK0hw07qIG9pqtb9RWMSDbfaFvdEaMXqC8jCTA9PLPbuYEDqa63ThBnwx/+P8UXX2srpOZftep9lTXPhwj5C1F0pjVaKmdveGEufF0+0JqZ5h3q4D1uCw0kEYeD2zqMcHTobe/to6ulshhhAFzHz17PLi2MfhZs0eWXSULixNnpNzNp6MhbI3zEB/riVvhKptPGeKA2VEFeo8Ji7/o5UapCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8uonstJ/GH47wjwGlzuuTxzoT7Ml8sf1LJ7ST+BBzg=;
 b=1UFLr5QdmRsKdK3LrON3eQRHc8riW1N4au7z9yN61q5as6Lsxnl7evIxxNOflOltJ4Xx5hJD9lVn31b4asD6Gt302PgiNgqQ2SlPUozVLJO+XDESwvVfF60CzXgdnNkkaSoO9wbQdLCmfVuSm2vJizzqDw7Y19r0kyi7KT5/tu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by LV3PR12MB9166.namprd12.prod.outlook.com (2603:10b6:408:19c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 10:29:22 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:29:22 +0000
Message-ID: <d5e167e9-5af5-41e2-81ae-3103389040e5@amd.com>
Date: Thu, 19 Oct 2023 12:29:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Remove fclk driver
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <fbb8665b8a58dbe96349abfe5492a509939e165b.1697098930.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <fbb8665b8a58dbe96349abfe5492a509939e165b.1697098930.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:803:50::37) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|LV3PR12MB9166:EE_
X-MS-Office365-Filtering-Correlation-Id: 884a703c-ebe9-46b6-2e4d-08dbd08e4276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yeit7ON2YUyzh8QqEtVENsvlPrTI2Ci7jxgpfDWVZ3ZZ9XcuSJGa4ZJgWH8bxDKpxOlJF+VPMSwmPSVTBufXQHTNrn8ZvjdsaH+uQBw0/9dvv2JVkepcle4tKX+jisruN+fzNRilfcLD2ABud4aIIn83NXgDKT9Pv3EsvntDAy1LrzULcbHO6+xPGlXgImkAfZXy5FAr6md/DCWz70vs/IVuTflf8vS7HExTlrcDSU/e3k1HDysw2KZKwQ85RsNPd8Hq0XzwKWmRd+fdGL4e/8rDWF6Ip2snt0jr+UAOEbBnZKBykunz871ES/Cu7rMGB3H+XF3g2Bol5lnpnZAFMU02KgAIxWonVULDVuFA41j1covoKV/rIOQZj/RLdWlSYkofbnFOM9wy7/yVBaKAcDkUgHVXuBfkpUm3jxBNLBcFAcDCADkMYcpT3RclalQ7LDGJF10mwJ8gbuuw7CpAmGI4J+paBVwl3FeI5GH38unFfSxsIGDvw9CqyuE/xis8xTsWV/90lAyiXIfKv9KGdJexhFtwRWD4PDAX4EetdUmzOyaabQVKmBXwS9mNufU+oZ7y2o+zME1BZPEbea1HBaPlnG/sa9AKfsFVTSJJwX5tLfYzkLZmX8X/LkpKaF4Yg2pkxB4IdSmiHL3j/kOEwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4744005)(36756003)(44832011)(5660300002)(66476007)(66556008)(41300700001)(316002)(8936002)(2906002)(8676002)(31696002)(86362001)(66946007)(31686004)(83380400001)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(2616005)(26005)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVpiWXV2RGh4VGlIZUF0dFpyZjl6RG5zbURWY2VHeTdvQjdWVjJYVTRnNTlF?=
 =?utf-8?B?N204YzJTaU1yYXpIQ0R4RVRZMEFMdHlkcG1mdXRDR3BWWVlGMHV6TTFaelE2?=
 =?utf-8?B?WTFrRlJyckhJdmpxQy9GNEhPbmhkV294VXR0WnZhWUdJamU5eTlUUUJoU2ph?=
 =?utf-8?B?RGg2a1ViV3Y5VTdIZFZQNmV6TE4yYWJDaFFLN1kvRW1JZEpFaURhZ3RqRXVs?=
 =?utf-8?B?b2ZrMXJwWW83T3hCRTRmTkFlM1pWb2QveExvRy9kUmNFZ2JVSTNKQ04xNUNW?=
 =?utf-8?B?K1M4UUUxTG5lZFhuRzFBdkNYczNmbjAydUUzMmVSS1dHb3h1blp5ekVXTTE0?=
 =?utf-8?B?dUtkOTRhdXRpQW1Fdk8wWk9XbFYyeDg4MlJiSHJGa3lVWXMxd0xYS2FDa1pu?=
 =?utf-8?B?WUs4eHA5NGlUQjA2amw0dHdaZkRmdm52dTY0RG9EeEZMSks4SEM1MzRTK1JH?=
 =?utf-8?B?RGxITVpRR2JScHRYVGRYaTJRSTYvRnZ5aXAwQ3Z6ZUpHbVBpZjBYV0xjZ2xE?=
 =?utf-8?B?VjlKOVpqVjBNUGNTZTJyTnpMVSs1Skl2cmVTTlpPVWRDVmV0ZW0vcVBSNmJG?=
 =?utf-8?B?ZUJIM3FvUTVlcElUcnlpRGMyazlrajJ4anNYMlcxTTZQM2RVSkN4WVRWbWRz?=
 =?utf-8?B?aXBpZVo4YlNXWFl5ZmNCR0pNa1NERTE0Ky9GZTd3VVlZVEUrVmhiaGR6MFZP?=
 =?utf-8?B?ZG5jUi9ubkdpWkJCUmFQaHQ4NFl5cWFHbEhKQnBuVW8zNHlmdzA5WU1tUUUz?=
 =?utf-8?B?UWNIb05IbnUyempmSmpZaGtsbW9xZlpOcHgyZkF5M2tvb0laMkxIcGZSNUx3?=
 =?utf-8?B?OTRMQmNENjdkRks2a016eUpaMlF0ZWN0c0dHcFE5T2pRcVdVeXBLNnN5Z1A4?=
 =?utf-8?B?aTc2b1ZtUWJJVjVSTWd6WHFzTjhxY2NQb1ZBL2JRNFJSZlpuWDZIOGtpY3RR?=
 =?utf-8?B?ejVOTGlrSUpQc25naCs5SkhKODJ1NGJKNUVBejgreGlVOW11VnRneDF1MU56?=
 =?utf-8?B?MnBGWndGY29jRzNhTkxKWi9ZNnQrMjFYZjM0OS95T3hXQTJIeDVvNmduSmdM?=
 =?utf-8?B?T21HWHNLdGcxZHFodksraEpabm5iRURQZlhEaHY0QVg5MTZGNlhsb2pVWFhi?=
 =?utf-8?B?aDRiTEducUExZHU4M0QrWUtGeFlSMi90UE85RTMzRCtzRGNHWEN3MWdlQXVI?=
 =?utf-8?B?bXVsOVJCZzJHM2NKd1Mxdmh4U3JJSnlseEJSSWsweEV0bkZ4QlRXV2RKeWth?=
 =?utf-8?B?N0N0WHhyTXBYaVF1bHdqQVVBQWxZVmJVd01XckloRHlvZEYrZ0VHbXYrcUpu?=
 =?utf-8?B?MFAzMVNIZTlEMXRyZVJmNW1YR3BYKzBiVENla1hOYkp0U1hwdlEzcTJEZCtQ?=
 =?utf-8?B?SHN6TWJWYXlHNWN4cTVFb3g0bzVxWFBRUXBXbXR2dWFSS0gva2huVEt0OHI1?=
 =?utf-8?B?VDF2WTJZSTI4SUVaVzhWbDdxekVFSEVsNHUyVGtBcEVmY3ZoaEJvTUZEZExk?=
 =?utf-8?B?K0FaNnRKNlFHV2U3VzhVZXpwTDJaSklFaCs5WUFlcWJrcThxamxmWVhaMHFp?=
 =?utf-8?B?REJzMmV4Y2RXRGFEWEE5dXZGdWJDUmZtaU5aZm9QaTFxTXpOVFhqblptdjNm?=
 =?utf-8?B?UXFaYlB1cGJMSlZ5bXlucFRhU2FDZXJORXNoaEM3RWdDMFVIcVh5UUlIV3hK?=
 =?utf-8?B?Tm9RRzJFdXZPa3A2VDEwdms4Z0JaY3R0Y1dHaVVnZzB2eGs3UUwwcm1sZ1FL?=
 =?utf-8?B?Q2kzZVh6Z1dyMlpnZlJ2Rzl3d2dscUhrWFY3bmJVSndGREFWNnFQUGdQZldo?=
 =?utf-8?B?WXdBNUd0bmlvUUljQk1hVEVoUHJwVldlNnU4Ky8rdCtQTjF4bFI2SVBieDF0?=
 =?utf-8?B?ZVplblI2aFozTW5TWDFOeHg1Zm5KSyt5bUhydVRLSXYxV3hLWEN4UTJuRFFV?=
 =?utf-8?B?WTFrdms0eDMvQlE1VHJGSDZIMktUeEtwL3JOOUxFNXNyMUs5STV2aGgwaVRF?=
 =?utf-8?B?a2V2blpyY2wvN200NjhPVmR5U1BWamtlTzBpUkRiRWdCSnNQWXBLMWJRWmJh?=
 =?utf-8?B?d0t3bEtzT0VvU3lISWVBU0RzMW0wbS9NT1Nnd09hVjkvUlhKTDFwcW94UTFm?=
 =?utf-8?Q?Nb7Pr8EZsE6WxzC9pk+4tEOfX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884a703c-ebe9-46b6-2e4d-08dbd08e4276
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:29:22.4817 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: To3xb/94fmR7dajA5KCFkvAvnPWatlyZifY2HusqqDbaMveQOH/yjJ23a1L6WAhz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9166
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



On 10/12/23 10:22, Michal Simek wrote:
> fclk will never go upstream that's why removing this node from DT.
> All PL (programmable logic) based IPs should handle clocks self without
> using this workaround.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-clk-ccf.dtsi | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-clk-ccf.dtsi b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> index 5f1b0b23c124..dd4569e7bd95 100644
> --- a/arch/arm/dts/zynqmp-clk-ccf.dtsi
> +++ b/arch/arm/dts/zynqmp-clk-ccf.dtsi
> @@ -10,12 +10,6 @@
>   
>   #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>   / {
> -	fclk0: fclk0 {
> -		status = "okay";
> -		compatible = "xlnx,fclk";
> -		clocks = <&zynqmp_clk PL0_REF>;
> -	};
> -
>   	pss_ref_clk: pss_ref_clk {
>   		bootph-all;
>   		compatible = "fixed-clock";

Applied.
M
