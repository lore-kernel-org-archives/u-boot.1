Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FEDC4829A
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 11:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D745D87C45;
	Tue,  6 Feb 2024 12:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ecuxCymL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE7387CB0; Tue,  6 Feb 2024 12:35:28 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A81687968
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 12:35:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4Cp9Ug1f9VSrIRK1mzKP6Smw1HWJsnkijZKYxmG4RfidkHkZqBr8korRLagIL5jyAiW2BWRt0MFzIRuZXLN0NfqVGEWNOG8vT3fCf4f2kzVXW7cwvs/a+XMW3EEmWIzXUAfDi3nucPZY5PaooNp4WaoVRqjn4heT+O5ayYGjniPvFfY8eN3XwE4DkzpkjpBJSeNPkyTakKWB56Wsi1zMb9paTg4UKZwb0KMcjMhz1rSFTAY5NFN2MvLKKv1NRMr48WcNPNvxMP+iKVkGi8uT6WJ3Faya/dqdp6X+IpW6Fa3x2GCzppSQXbGsgdOPK6gBlA6gJrtbaKwShRkXSdSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBt5bgojacbDiRpMldrdL0bbt+vW6PbZedO12HzRG44=;
 b=cYhov0QkAnHz0yqCc8/KighL8uOXtU137Y/lAnXzanZzaX2L12J5ALfWYWMxFLJ4UV9mNXvwNBJmSg7zdx6dGg0HNMx3gu92fX8kvgnGDeurUVzo3O0WFlJWACdHfUzb9xDULciCwh7qgA5zE2ij9MizUb3DhIgMXRzwPHEgqNgQYY7fx0Gwqe9p1hkr1EVCdz/B87fiCUYGp3JP0EanF+/bhjRCPaPs9Y51xRDtCA4SCEVSpZ7U7fC5Tt3KP2KYdtmKm+zcqgwTm+HAdM1bWmMKw3dolzD7s4zNu9gi2aUFnaCrw82uMgcADBdUXV1pmA+1hHwJT/WCkV9I0VfQXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBt5bgojacbDiRpMldrdL0bbt+vW6PbZedO12HzRG44=;
 b=ecuxCymLRCrbsy56Rz4Rq/vkonzFrtCAorB+hwTrcz9LA+BBBLYjJ/WcqiI0vSDcJNU8e5VvtqGkNeIHcc5uPB1BxBUoGIybMlu3h/RlypLN/gZjDG+0g1eygSzuZq5/kPginNFybpcwHY6oFiJ7atpS1WTbwxTTyQO/VyI/oBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 11:35:23 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 11:35:23 +0000
Message-ID: <73a0822e-504f-4f52-b912-8dae1465de41@amd.com>
Date: Tue, 6 Feb 2024 12:35:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Describe 25MHz fixed clock for PL GEMs
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Harini Katakam <harini.katakam@amd.com>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
 Neal Frager <neal.frager@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Tom Rini <trini@konsulko.com>
References: <c430aeacaa76d9f61ed3f874f721a33049f45eb9.1706514396.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <c430aeacaa76d9f61ed3f874f721a33049f45eb9.1706514396.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0073.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::26) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: a04decaa-0ff6-4d8f-dd14-08dc2707b501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lObRhAyVHPZOyBHk6v0gH9ZGRA15Sz8/tkw2BS4Q7vwDAGiYGtkV7NERlgm2vY1aQ2DFCHAZgHhr/wiEhUGPBEAv/EStUAxdxLZIzrgVKKP78kp+9T3+oniO0hEqBch3xwjKrmEwcS7Z5B1jGojaaT0kvyliTT272mCMmZ99brJuJt+qT1W3YIYns2Sjrvh/jMxcYJoV4GfomPF+0vkpiph811p3wPCu19biCHuPZPDSZZlH0cVyomD2LjMzKgkbi5Vikas/JI+PRl6w95isEZRy17J0KU9qi85jJ0njDkV+gmy7IL2+mqxY6iNlC4iGpP/BPAOwUrdPqgDy1CnbeTuVIN3HCw9o2K05M7Btr14ZE3PBpctH39jVD9rmz3Jg7A3e8RbdMeMdSoKrnAmki/ea8xqFuoC5imLOj2uLWlGzes5oYA/EOucJlxFarD8MD81MVwKLUvSGv3N6dyKIVoWzGmy9zXNagqQ4cgdZLtqNfcXHYJI5XCZfh1lKllreK53aVegcswBMZ+3CfjeSvRE0XanFA1GVGW9zFuw6vYkEWlWLA/Gmtrv9YmeAURbVcxv1B735imC9yfqrdBsi/2RWjHjKImjaAzNgj3qwW834dQCvzdE5utr5l06p35c30Y7CBcJgHD/nNOO2xfaZfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(86362001)(26005)(83380400001)(2616005)(478600001)(38100700002)(6666004)(4326008)(8936002)(66556008)(66476007)(54906003)(8676002)(5660300002)(2906002)(66946007)(316002)(6506007)(44832011)(6512007)(53546011)(6486002)(31696002)(36756003)(31686004)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2Q1bHZsNUllU3E0UzQvRE1NK1ZZWUF3Rkl0QVlHSUE0MmhsK21Lc05OY3g1?=
 =?utf-8?B?SnU2NGtsNFEwYjJQOGNkdXhaWHRCTklFUmJodXZEZzFSM1J0NEFYTWs1UkVl?=
 =?utf-8?B?K3ZLR2pqaVdtRVY1djhUNUdKRFNNRkZKd3pXNTUxZVk3dlhSWkg2OEc0VjlG?=
 =?utf-8?B?RC84RFpzdjNNS0xHOTVCQ3gybzJtenRIVzBVUVkyL2hJN1FyUm82WHNubENj?=
 =?utf-8?B?Z0JlZ2RhRkJaN29GdFNDbUQ5T0VKOUFtbWsreFJPVE4xdGUzRktSZzZUckpV?=
 =?utf-8?B?NnRseWcvYnhOdzQrQzE1YmNVbWVFZ0ExZ1ZuUGJhODFBcmdSaDM0MnBoMWxh?=
 =?utf-8?B?ZmpTTEl6RGRqa2xpenFwWEhYcm85dmdTcUFDRisxeHpZVmZUMTErNVdxNTh3?=
 =?utf-8?B?TkwyY1hKb04wQkhjWldNWVFBbEsyNjR5UTRCN2hveVM0T2NkSkxVU3BZZGZ4?=
 =?utf-8?B?eGJhVW5MMCtNMlkvOEFMZXFjdHJLQXA0Umx0R1JBemRxb1FNWm1QYTFnd2ox?=
 =?utf-8?B?ZlRtanFsQVVOeDI0N29jMnRuUmVueGR6YXRmdXlMTjVsaC9MYmp0SGZQK2J0?=
 =?utf-8?B?K0pWbWdYaVltdWlKdC9GeVdvTHFtWG9nV3ZOR09qOGE3VDF2cWFhVko4SjU0?=
 =?utf-8?B?WHltRG1zL3JHM1JEbi8vSUU3Um5qaGxYd0pOdDY2RHE1Zjh0aFA2VmZ2M1pH?=
 =?utf-8?B?eCtiWnQyeThVekVHeWcvWXdMUEx5emJKU3p6WG1IVGQ4b0svdWlFdE4weU9t?=
 =?utf-8?B?aVhLNzZiNktidmJFelZRcFdpaWdTRjAwM1g2RGo4azExWHAxTWpnQkNNdzd0?=
 =?utf-8?B?RXZXdldwdWRzMmUxbFFneGFIVFZZYndQWXJ4UFIwZlZ5T3kvREhpazk2RkY5?=
 =?utf-8?B?TkU4aHBUcjRHcXpMMVJuMnVjQnM2SFVwTGxlS21PSGZjYUxnQzZPZUVIVG4w?=
 =?utf-8?B?ZEdkR2xIYW0ySVB6TUJzUWJTbjNoQmgrbnhoeGhXRHA0VVlvSXlvRGxiaE5O?=
 =?utf-8?B?bEw3ZkYzSWpSZ3BDZWV3enVyWVZGZnpNZFl0TWlEY1N1UStNZ0toRmdlR3Rh?=
 =?utf-8?B?dUtoeEpmNVlNWGR4SjlndnM3cjZMM1pRS1BuWk4yRXlhdE5KNFBWQWZQYUNX?=
 =?utf-8?B?QlJib1VoVURCY2QvSmxZRnNYSlRMNlllQkJnRGhkb2grdGpSMWVWZnZvUFNp?=
 =?utf-8?B?OG43eXdyUFk5WUNoZXQrM3lkYW9NNjIxSEtRcmEvRk1tY2ZyTVppMGRudHhW?=
 =?utf-8?B?WlZHdUZ6S0dCaXRQUEY4MUpkNXpXeDAyTitzK1N4cHR3dkk3ZVJxMmlXMzRX?=
 =?utf-8?B?UUg4Qm5sNm1KRTdoandId0hNUGR3TklRc3NMTzlmeDJGZ1JMMmZ4YkQ3RnRt?=
 =?utf-8?B?T2YzSVBUSmpRM3ZKdWVJdVlmbnVvRjZIdGxnUmgwcy9KanhEZ1ZLWFdsb2Z1?=
 =?utf-8?B?cWNoRVRJd0RRTEhJUFd2K3NoM1ZhbXJZSjlXZmJvU2h5Y01jbDl1RzZrbE43?=
 =?utf-8?B?UmttSHp3WXorSC83b3l4dWx5RWx5dXJGMjI3ZGsyYndhVHZEeXlYbUtpU2tT?=
 =?utf-8?B?NzQxV0crQzhVNExHK0pOMzJmQ2NuQ2NMMmdkS05BYzJIaGJmZDhvT2l3TXdI?=
 =?utf-8?B?dnpzWkdnTkpkZ2srVEhIL2F5aG9GcStnbmpNY3U1a0E4YjZkL1M1THJnczk0?=
 =?utf-8?B?QXlTWW1Yc0gwMVJSRFFuRlRKcXZFU1g4SkhXN09XRE1VRk9QaHg0OU11NWxP?=
 =?utf-8?B?N25pc0lNclIyZUozL01xelZTNnJORkExd2ljLzJiUkdlQUZ5bitZM1FNZ3F5?=
 =?utf-8?B?Ui9KQUo3RSsxbE8xOWJqMFhHZ2JGcklwMTB3VUJucVlhNnVSSDZGTk1GQ1RR?=
 =?utf-8?B?TnptbWRzczczRmE3MHlORzVsVVJFemhxTzFoeFY3b2praTJTSmFRYUkwZllW?=
 =?utf-8?B?b0pGSDYyVEZoakpUdlVsaW5WZXhIWUxKNElLaXphQk5Qdzk1QXpQOElwN05a?=
 =?utf-8?B?TkprcVNVb1dqREM4NCtFOVBJUnFlNEVXQWhIT0ZnUmJKTDdHQ3A5YXFuOENK?=
 =?utf-8?B?WWJaWHByL3lEOHRmUXJrSTRNSUtpNWc1QkRNTHRDRzhlUmFqRm5Vb05HdjFV?=
 =?utf-8?Q?405aJKfSiCGu1GB8TLBLTDA4B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04decaa-0ff6-4d8f-dd14-08dc2707b501
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 11:35:23.7096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PshqSQ1mLLyD8cC+IO8LrzgA04Y73y5ob8/hTu0tnZR6wyV9VW29b38uJtqtw4CQ
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



On 1/29/24 08:46, Michal Simek wrote:
> Describe 25Mhz fixed oscilator which is providing clock for PL based
> ethernet IPs. Physicially it is one chip but it is described as 2 fixed
> clock to be aligned with other SOM versions which were using integrated
> clock generators where clocks could be adjusted via i2c (si5332 chips).
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index 766f78303eee..b3fc17cbd577 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -32,6 +32,18 @@
>   		#clock-cells = <0>;
>   		clock-frequency = <26000000>;
>   	};
> +
> +	clk_25_0: clock4 { /* u92/u91 - GEM2 */
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	clk_25_1: clock5 { /* u92/u91 - GEM3 */
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <25000000>;
> +	};
>   };
>   
>   &can0 {

Applied.
M
