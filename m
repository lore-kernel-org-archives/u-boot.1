Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA35CDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E73A849BB;
	Tue, 23 Jun 2026 10:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nYG2awf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1FA849BF; Tue, 23 Jun 2026 10:01:08 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED3F800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0eKSynK5xzBewZKl69DPBG9YwwBuJgYHZUEj2Ghbc7eWTPjI4xwe4+lJp9KEXpnZyxvGWnYP1+XLMMBLH5o1zoQqJnsTuzQ+LKQKciMbucM0zl6oE+QmHB61lP1NU0d3vF/mQwYj7Dk0tpLhu+26ukT5Rbd8eKH2maNak1hMqSsxKPHh7EKsIu2rqOAQEJjBC8WJY4yTRQNodCozjEdqslBQX/yGGxqc/X0+TlFfmJl8CAk5u7/Y26R+AN6SScHKfjKx+DWP/mRkQ/bnQ0b7B134u1Sd5xYUjLV8Cs7y/DQuBoVDIr1yAcAqscTXQC4noMF3G0z2lvd77Bvl60JTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6xzD7iPmN5mopARMPpkNRZxOaKx4fDKwZguLosn/2E=;
 b=Hp8tEAj5pgRpKHW4ZXsDrKdjjD7e9rKbv7uxt5wyIGkUPQLBf3RZbk+OJmnjxNLKUTMMA6C7IfdqeSqc9lqHCp2F4qlgcXO6Y/pqiAJ9njBeyFHHvOeGyeuq9T8j4/faD/2omSG65ZAYctiuAzaxJRs85Yi45DlrOzSp6lhQAif23oiiIs9JRQSKaFpIUUTUOkxX3yJs+5dgGNcGVRoUrAZFSxal4keDbjuDamgLunW+0s3p9gL9J8WtxvhT7MRldC4TEo5NhN7LoCiOADEmRRoge2vMIrCwnjH2XSErkV2MOvUEClbXGcTsN4qFszj5yZloFsEjwT3Hb2zsHX1gvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6xzD7iPmN5mopARMPpkNRZxOaKx4fDKwZguLosn/2E=;
 b=2nYG2awf8U+anOX0C1RlBMNrEXd032P50barx8mfQSVrCK8xfDcp66uJdaeF50fxx9SW2Bbmn7LkmdFgqTPEUT8r3ICThCZ9sLVmCzUWdOmqwfnvIba0C+p4LZVglIYPLN+Eox6XmnuePty8uYfDb24iQiK3NJYnFVcfA8zRiJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:00:58 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:00:58 +0000
Message-ID: <3b91f882-50a9-4ccd-8944-590a5b3c9aee@amd.com>
Date: Tue, 23 Jun 2026 10:00:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] arm64: zynqmp: DT updates
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Rohit Visavalia <rohit.visavalia@amd.com>,
 Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>,
 Trapti Damodar Balgi <traptidamodar.balgi@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0096.eurprd04.prod.outlook.com
 (2603:10a6:803:64::31) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: aec85de0-1d5c-4b82-5adc-08ded0fd8f0f
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rS58r+f7TofmLd2fgapDhSPw6S3TKdIvkIGVPkifLULOsDYziLxuDm9n2Py/Ae3/rTV4CZpp7epeZsa4qEyTLdAyQVWPix4dlSUP9TUjJ5vGX8q435FjBMy1Cm/o3d73GwQeEOaa9z8l0uSBwnJYtA2DwtauHO7oNqVfR7I8rDh7rAEWcVWDlsOjRxfoES5mL8YGYoZ2Mtvraj3Z6tC+0SR3tC0XQsA82TpTyj2kkDjaj2r40ahISXhlqJXiHK31pU7AYE6+9If+WdOo6feAKtSl9h818vBdVxHX0WE30r/fpow2u+Sk95LBW539oFD1PBThmkhIYb2K7orQE8+ritJ6BSoV2L+i3PQom61xay+OD3ZSR27AwzCv3Hr6WnqSSUbJk10p9RY9LTv8bkI9K57HFR/UMKc+6/OiizRpHb+VQwtdc/bTjTq/8hLVTqiGOyrO9cO8K0RCTIMGW8RHvudPnoTFxBIZ3UUXfvcIJ0CUTPFdPXXNVOtqVehbMXzJhHjhJ7PGp6qQtPxYs1XX9E91QIhTXAZa2zrkTItbmoIISa1EI2VTT2XYNuasMmSd4fDheHLiV2kwoN224BarAldqY5bDJWpqr49bFxFVYijAECD/mOxu6jDk0Q5fOzbe9I4cFopjd0BhH3PdYk09sJPKgKrmqwlISIb87wi/vUg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHA4RWFuV1VlcG5EbzVwT1JWM3ppdENWN0k5VFNMdGY3am5jNFZONVpUUlEz?=
 =?utf-8?B?VHJUdEtpcVZBWStDaklWNUxFckJDa2dBTmxuTGE0OGlWQVNGd1YvUFpTeGFq?=
 =?utf-8?B?Uit0Q0RZRzFlWHFaYWQraFRuUmlYU0ZBMnQ4aEcveVBOVjVpcGd2TjY2dkhk?=
 =?utf-8?B?c285dG5oUTc0WUpSYS80ODVwMFdGRzU3ZitOOW9zS3RobkhvM1JQazR4REtr?=
 =?utf-8?B?NXI1VnRxNTN0cUVuZTJzU3M5d29zMTJid1hTSC84SW9wbjA4dHQvbnFhbUVU?=
 =?utf-8?B?WWZpa21KeWhvakFsSStCR0FOQmNRSHRMZ1JoWDljb2NaYjcyUXltWjIzZWph?=
 =?utf-8?B?UHpadkRNS1JFVzMxUkorMDdpNGprWFdQQ01aN2tlYUZOTW8vV2k0NTBrRko0?=
 =?utf-8?B?Y1B6WVR2ZHhVNGpobEZ3eWJUSmFWRTAvM2doMGFpLzEvMkpkTVc5OTU3U3pl?=
 =?utf-8?B?QlVTR3Z6QzFzTzJxd2ppWmNYYm9XYmdsYVM3eG9ka2FpRDQyTFNDdXNYQTky?=
 =?utf-8?B?R0t0SW5JWWtpNVpXS0xJalNqeEVZTVVYTjA5eWUwRE9tbmR0RHQyZi92YkZq?=
 =?utf-8?B?OVBMNGFVVjlWTVUvOVBpcVlQU1Q2UTIzazQrRUFHMk5CeXA2d1MwZ2srVjZ0?=
 =?utf-8?B?bG9mYnBrelVKZHNQVGF4Rm5hMVBlbXRRV1Y5bGZoSkhqTlJNdSs0NnJHcTk0?=
 =?utf-8?B?TUI1bVhGT1NmVDY4bUQrVXQ0WklTTU5ZZ1RXOUZQaXZKMGh4RUE3bG9jU01v?=
 =?utf-8?B?VE1ONjZ2ZEJ5aUJpV3hsOGJxbTNucEU3eEo0NTQ3Sy9wWDFwZGFjcS9kOHp3?=
 =?utf-8?B?SEZTWXpxbTdIOHFoTk5IVVRMR2w5dWFMYS8xUlZWVlNhNFg5OW5KOWVqSEVY?=
 =?utf-8?B?dWpmMTZsUWhxOEFwcVp0SFJPK1RGYlpLbUxZeXhlT3BVSlBCbHJpQUxTQjI3?=
 =?utf-8?B?WU5mbHJEZDZFcCtiK0FKRERSVW5ZVDZFNjFKYWVDcGlsNWhMQXhKQm9aNDhF?=
 =?utf-8?B?WXRPRkpWQXlTSWtiaXhZM3dhREJGSzJ6YVF0VHNlM0F0RUd5RWR0UmdoS2FX?=
 =?utf-8?B?WkVhMnNKL0tjZ1M4WlpIUzUvT0FyLzBJWHl5RDhKdXpuNWV3czNpTDNxSDQz?=
 =?utf-8?B?ODc4b1ovenJVMW9udWdncDdQYVRzYzA4aVkzRUV2VFhaSER0dllHbFBjWEtS?=
 =?utf-8?B?b25rZ2tNdjN0K0FEYVkzU2czWWRxa1lCN3hlSmxWazVRVUhkcHJCV2RYbXJq?=
 =?utf-8?B?azJNV1NJRzArb0JxdlYzNmZ5OEZZSzVWeXBVWVJ6bGNIODVRcjlZWFI5MHc1?=
 =?utf-8?B?ZVdvVlN0OFdYTHlKdlRZVEN0dXRVb2ZIbDNLVUticVU3czJoUVI3M0FCVHNP?=
 =?utf-8?B?bUlld2J0NjlicnpOcVdnN0J0MEFOeURPc05ObjJPV21NRCtjWlBtT3VQSEty?=
 =?utf-8?B?MkFQMkxSY2FUMEo1TWFkM0xJT2RaT1FLaThpL3lrOU0ycVB2bkE1L0xYTXlO?=
 =?utf-8?B?WWN0STVSVFVJQUQ2QndiV2JjRHBCV3RHRWlQU3ZjR2dPb1VmN2Fzb0FZancx?=
 =?utf-8?B?Q093a21FOU1EWlZQY21lRDM4SnpkTVlVWHFNejlGQTFJNzcwb0VkeUdKdHB6?=
 =?utf-8?B?VzNSV0M2NEN5NEUzb3J3a0JmZlpzUDJUSWN0aTVGcnRMM3RzT1dMQnVXTExV?=
 =?utf-8?B?YTZNcGF3M3BkOFFzRjFWRUE0MXZEOUJ0a0d3R3Y5TklPaThkSk5GODlNTjVw?=
 =?utf-8?B?SDJlSWpEVmdodUFpWE96TVZBNklhYVo3RVp4UHdwSVdvOXEzdFFXdHVhNnVu?=
 =?utf-8?B?R3UyVkF2UTdJZEtMRFhvRkJONy9ZbUJ0UGNpQzkxLzBSbHhTL3c4L1NabWFa?=
 =?utf-8?B?dWVKcXNKM0RMV0U1WkN2bk0vTE1peE1kT0dIZk10Z3hkWG9ZVDJqQXZ0dGVV?=
 =?utf-8?B?YnpMVWQzWU01RGk5RFZKOFZSdk9GTktCbFU0Sno3Z3JGYXFSaC9GUlVsdEVo?=
 =?utf-8?B?YjBLYXpqOEFOQUE2bkw4dXp0SS9xZDl4bkVZV3hiVTlaY3JvbndQdFBFakM5?=
 =?utf-8?B?UzdIb2llZWZ5ZnUyTzh2clJ4eklHZnlYTGFuRG1wRjdYa1c3VHFEQlY1MU5o?=
 =?utf-8?B?OFRReW9ZR0N6TjFOdHpGTUJjTnpwYStnL1YvNkMyRFdETDI5eXVqdjcvbndU?=
 =?utf-8?B?YmVkWFZ5aEpTRzFFQjBRSEhYS3NpR2FsUFlUQTB4S2hOeFh4UTB0VjhucThs?=
 =?utf-8?B?YmpOeWZRbEVLeWZYYlNsWUdlYWNINmtEWUhIMVlxY0JoWXFGRVltL0p6WC9a?=
 =?utf-8?B?Z01aWmVHb0t5UG5jZUxMcjBFblhqVUt4MFkrdEk3UkZCN09mY3k3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec85de0-1d5c-4b82-5adc-08ded0fd8f0f
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:00:58.0656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxD+1DhFzjoi3IsBMjLx12lJqmIygNON13P1Lyg0bhZi2fyKdRHTb5Td5o+m/t99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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



On 6/9/26 09:48, Michal Simek wrote:
> Hi,
> 
> sending multiple patches to update DTs for ZynqMP targets to reflect
> the latest findings and updates.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (5):
>    arm64: zynqmp: Drop incorrect #phy-cells from ethernet-phy nodes
>    arm64: zynqmp: Use fixed-partitions for MTD
>    arm64: zynqmp: Add CMA reserved-memory for runtime FPGA loading
>    arm64: zynqmp: dts: Fix file descriptions to match actual filenames
>    arm64: zynqmp: Sync compatible string format
> 
> Rob Herring (Arm) (1):
>    arm64: dts: xilinx: Drop "label" property on dlg,slg7xl45106
> 
> Shaikh Mohammed Suhan (1):
>    arm64: zynqmp: add USB hub supply regulators
> 
> Trapti Damodar Balgi (2):
>    arm64: zynqmp-dlc21-revA: Update GPIO line names mapping
>    arm64: zynqmp-dlc21-revA: add mac nvmem cell for gem0
> 
>   arch/arm/dts/zynqmp-dlc21-revA.dts            |  17 +-
>   arch/arm/dts/zynqmp-sc-revB.dts               | 171 +++++++++---------
>   arch/arm/dts/zynqmp-sc-revC.dts               |   1 -
>   arch/arm/dts/zynqmp-sc-vek280-revA.dtso       |   5 +-
>   arch/arm/dts/zynqmp-sc-vek280-revB.dtso       |   5 +-
>   arch/arm/dts/zynqmp-sc-vhk158-revA.dtso       |   5 +-
>   arch/arm/dts/zynqmp-sc-vpk120-revB.dtso       |   5 +-
>   arch/arm/dts/zynqmp-sc-vpk180-revA.dtso       |   5 +-
>   arch/arm/dts/zynqmp-sc-vpk180-revB.dtso       |   7 +-
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso        |  22 ++-
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        |  25 ++-
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso        |  25 ++-
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        |  21 ++-
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso        |  23 ++-
>   arch/arm/dts/zynqmp-sm-k24-revA.dts           |   7 +-
>   arch/arm/dts/zynqmp-sm-k26-revA.dts           |  11 +-
>   .../zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts  |  38 ++--
>   arch/arm/dts/zynqmp-vp-x-a2785-00-revA.dts    |  14 +-
>   arch/arm/dts/zynqmp-vpk120-revA.dts           |  14 +-
>   arch/arm/dts/zynqmp-zc1232-revA.dts           |  55 ++++--
>   arch/arm/dts/zynqmp-zc1254-revA.dts           |  53 ++++--
>   arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts      |  55 ++++--
>   arch/arm/dts/zynqmp-zc1751-xm016-dc2.dts      | 153 +++++++++-------
>   arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts      | 124 +++++++------
>   arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts      |  53 ++++--
>   arch/arm/dts/zynqmp-zc1751-xm019-dc5.dts      |  15 ++
>   arch/arm/dts/zynqmp-zcu100-revC.dts           |  17 +-
>   arch/arm/dts/zynqmp-zcu102-revA.dts           |  56 ++++--
>   arch/arm/dts/zynqmp-zcu102-revB.dts           |   1 -
>   arch/arm/dts/zynqmp-zcu104-revA.dts           |  56 ++++--
>   arch/arm/dts/zynqmp-zcu104-revC.dts           |  56 ++++--
>   arch/arm/dts/zynqmp-zcu106-revA.dts           |  56 ++++--
>   arch/arm/dts/zynqmp-zcu111-revA.dts           |  56 ++++--
>   arch/arm/dts/zynqmp-zcu1275-revA.dts          |  53 ++++--
>   arch/arm/dts/zynqmp-zcu1275-revB.dts          |  53 ++++--
>   arch/arm/dts/zynqmp-zcu1285-revA.dts          |  15 ++
>   arch/arm/dts/zynqmp-zcu208-revA.dts           |  16 +-
>   arch/arm/dts/zynqmp-zcu216-revA.dts           |  16 +-
>   arch/arm/dts/zynqmp-zcu670-revA.dts           |  18 +-
>   arch/arm/dts/zynqmp-zcu670-revB.dts           |  18 +-
>   40 files changed, 948 insertions(+), 468 deletions(-)
> 

Applied.
M
