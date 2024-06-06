Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9D0C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C02A88335;
	Thu,  6 Jun 2024 16:13:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fote4Mii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10246883CE; Thu,  6 Jun 2024 16:13:40 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD8D88335
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A57O30zLawWRZwJor+MX58G5yz43wRkSkC2981F0E3tMZgWppgsNZGJFoqW7rWJOr7X+129B1C++TjthUr8zP7wc+lBAl+dTDZ3TJlXEgK0I4bBCQ/cBGn/+8JGEvkES1FrxIVaV1bTj0ErleJl3IDxEQFyIAICQiVm9VqJm2MDIhgOto0xyyJENOObysOTRYGoL8/AST3qlkD8M1IIjAD01EHMZIMKZtRw7epP6xyayHM0QfjAZDYVMMZkeCTfUfh3Y/COKXy+cBAMTlHpJEpW411QB6ekrurfzRLYwMRyVeuABm2U/L29yfRDSKd7SR7L/m36b7yT+eytCBjMyJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAnwkK8o7zz574nWJgdcStKXxguXsM13cyqS0+zEzjY=;
 b=Q4jixl61+oSFxJsP+CFnKvzDH7ldUVL7+AdnyoiqCSeb0iDp4zZ7ENyxh5mEK+cboQJ10Vot2nxbsMqPt+h6wuKXRdTVeEFAbejPrdZM7lz+pbYss2NMau3ppxxc21tgkhVKBSQYzbieViB7HcYCXFLih8bCyaZRAIrUVhtzoh2kOIFNY9ITklm8h9txIXfVKBoherQ7u8sbZD8iwzNiMLLoT2U6bks8k2ENqhRqtt6f7gVvmZdzJh48VyB3oybzE3SYuR+FvUkyWnQYLEfzx9HYEc0gMhw+JvTcdB97AMHU05OemGhwZ6uvpgFeQQ9p11C861o+jLUbqFBR45YqeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAnwkK8o7zz574nWJgdcStKXxguXsM13cyqS0+zEzjY=;
 b=fote4MiilV1w8kpnLU+pVNGQFlxU3p6MkZF9NZJqBK5JzHFFn+klYXvYhyBCJ1ftLI9B8SfCi9yyNgaIdIMPPq1eToLazO0nbrCuo4dtiE+acJTEHdFjNeDBxBIpsQLZTF8+ws88aFh5LsUL6uRcAbeb1gsi/jseSce8xsSw6cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:13:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:13:30 +0000
Message-ID: <d2eb69b7-099e-4df7-802a-b63f7bb43dbc@amd.com>
Date: Thu, 6 Jun 2024 16:13:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] firmware: zynqmp: Add support to access efuses
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
 <20240604142741.425307-7-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604142741.425307-7-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 480f042b-21ae-4962-bcbd-08dc8632d779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnZQYkJLcmxwbzEzR3BCazdaN3lFcklmY25lakFtazhZdkVBb2VZdklLcTdE?=
 =?utf-8?B?bmdNclQ5ZnV0bFZHNkx0eGgwejN2dHYyQjIzcUF1aFVJU0RhaVpmb0NNOW5l?=
 =?utf-8?B?dy9meng2S2FVT1pnQkNVWDNDcElnOTdwZS9JRGFud1dHT0VMcVVlM3JrNGVq?=
 =?utf-8?B?RTRhMkZrOHp0eDJxWGFZb2ZyWXJNMWJTQlRWcTUwa1Q3eWRncU42ZENQb1BN?=
 =?utf-8?B?N1lUODc3aDJ0VjBnajdvdnQ4ZFJBZTV6Yi9JbzJqUStGOC9rOGVPWXZ3YmVN?=
 =?utf-8?B?dlpBNE5uaE44ZTRqV3dldDAwZU5GQUZ3T1Y4bURtcDhibnl3eHJycmxkS0sy?=
 =?utf-8?B?R21CeUZSRmw0SE1uK05FQ1JNTmQySG0xTkZvb0dlc2J4TDl0ODJVbUhmdGpv?=
 =?utf-8?B?TFNPRTRRN0Nic3lSQjV6L1RxS0tEZ1dCT0YwSzRiY0ZKbm56UExHdml2bk0r?=
 =?utf-8?B?Rjl0TDBSc3FTM3NMTVJqN0dLUGg1Q3hJMmlPK0xsNSsxbDlubEd1RGtUcElO?=
 =?utf-8?B?cENmcFd6RXpQeGVtU09oNWJqcEMzS3lkb3I2TEszUUhUVndldDFuUTZLMDlm?=
 =?utf-8?B?UW9yY3Fsc2xYSnFaUUxRMmtNVzZsZ3dWZEc1YndES1RzSDkwVnZHZHdpTmw2?=
 =?utf-8?B?TWptcUN2UU5LbThtQVNIUTJmZDBERkIrcmFYM01hSkZ4SVZudklOZXc3Yzl4?=
 =?utf-8?B?dkNsVElIanJEN1pMbHFma1o4ME5HbUk2cUdTaXpTOWdvSTlNRUFFU1ZVaDM5?=
 =?utf-8?B?dkRqM3d2Lzd5RWRnRlNudSticFpaUktuOENpVW1WYTNDZk0zbzhLS2dvTms2?=
 =?utf-8?B?b3BuTEdicSsyVVY2Y2NmM0VQOW14bm83dkFmblFDYlJPL0hiTG9YVFppb1ZG?=
 =?utf-8?B?enBXbVpxMU1CTkxTRlZ4anRMN0dSU3YrVVM0SnFCMTI1M3NDVWU2Mk9HSVlu?=
 =?utf-8?B?djAwazBYNHRMRGtvV3F0anhIN0tIWGNpdnlrUjZKNHJiYlpESU1xbkpHQjI2?=
 =?utf-8?B?NnNMOGlKS2k1Y3I2b2RTTXZpTVNxOFFBZGViTFUwWHRLclBwQjA4Rm5lSENu?=
 =?utf-8?B?ZlRhMFJJOWY5b0NucHBiaGthc0dQWVZTNHBRUVBKaXRRcmFGbXdCNWU0UDdz?=
 =?utf-8?B?eVNyQzFPVjhmQ3BOcG92UEYwRWFGQ29BRDZsM0lpMW1kTnN4Sm0veGZRUFNW?=
 =?utf-8?B?OVphWXY3aXBDTmptelo0d0FUc2hDVU92Qm1zc3k2aGhHeUVpdUpSdDlHeVZt?=
 =?utf-8?B?OHpDUERtMEQ0czlhYUM5b096elRIKzdjWkpMNFJSRDJ1SHMxdzFZS0ZnSUpF?=
 =?utf-8?B?UnZpWVJONnVUblQ5UkZmWldPblg0ZlBmZys0ZWgyMlY2TXQzRTc3T2Z5c0ZJ?=
 =?utf-8?B?K2dNVzluL1RYUzJva3JQaGwzL3VQemRkUlpja1luZVFBMmQwNldScGc0U3lO?=
 =?utf-8?B?NHlKQXFQUjRqUy9WYlgrcjBNQmFRRjcwbUwwVlVLQ0hTeTJoU1hPQ01VUVFC?=
 =?utf-8?B?TW5XcVJBYUxyRlpSVzlyRkUrVGdoelNRUEVNY25tSlZqVVYxVm9FTjFnOFdh?=
 =?utf-8?B?aXVLTHh4cTd1SEI5UlRBV2RjR3M5N0RVc3prMXR6ZlErTStuK0F6cG05aU81?=
 =?utf-8?B?eUJZS3d0RzJUT2dxNDlQQWdwZWEzNmtHTnJ1V3RCR3V6ejBoK3FTb2xWZHM4?=
 =?utf-8?B?MkU0UGVqc1MyU0l1cWE3bnVNdUdDdkpsZVJvNHQyNVhQM0svVFNRSk45YTE4?=
 =?utf-8?Q?0BFDD5J4c/gezlZNlScxH46ZNTTY2veAQbV/Ht1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejFEY3cyZUM0aVhrbmg5RmRENTZtTmJtTFIweHd4eUIzUHpyTWUvSnloU0ht?=
 =?utf-8?B?a2VvTXhkU0lhZ2xLaktCeDd6ekwwL2w0b3JrSzlWczkzcGpZTEdHZk45NHgx?=
 =?utf-8?B?MVpjaUdJRThJU0I5N0FlSEFHWmM3dCt3V0ZzVmxmL3R5MTdaRFAvS3A3azV3?=
 =?utf-8?B?OXc2YmVXbE1wUC9URVFjSnlNc05FTHZHOWtQZDRra0E5YXlCcmhrZkV1RmJn?=
 =?utf-8?B?eS9XdDh4VEFXeG5TNnA2RWJPVTdIdG4vK0g0aXIvSE02S0trcnY0dTE1UlBy?=
 =?utf-8?B?OG1rWXkzSzd3alEzaHlhajUzMnhqTm9Dc1hHR1pUbGx0VVNkT1dEK2ZKUEx2?=
 =?utf-8?B?Vi83MTBlUEZldkZZVWFWQVdkSS9adlBEaUkvaE5jZWV5cUVaZStmWXlqWkJi?=
 =?utf-8?B?dXd1NTRFTkEvSXo2a09YOG5vNmNlalVzVFlmaCtlbXA2cWsrRGd2LzJxbUZG?=
 =?utf-8?B?UWZIZitKcHYwQXl4bDA4dEs5TU8zbHJuZi9ueGV6emkrbGhyRC9vQU00SVVm?=
 =?utf-8?B?ZGFzVFEzY0tQY1JxUkdlYkNyNUJpc0ZoMDlhWUFncGNiekhJNFdGTXRERjg1?=
 =?utf-8?B?YWNaMS9wMmNWd2xTbE56eDlCQ285WTNBTXdQMmlUcWRJd0x3OUN0dFBLSVVC?=
 =?utf-8?B?VmNRNitleVJTMFQwVHZ4ZWZiWlZOYytWVDBBN045eldHTmlJLzRQK283VHVB?=
 =?utf-8?B?OCs3QnJ3TGR2cUI5Q1hPQ1QySzBlSFAxWjRUWjN4TUM2WW9kRndxT0hOekVo?=
 =?utf-8?B?WEJTaTFnbHNPaWplOG1XZWl6WlQ3ZFZrbWNzbk8xZnJuUzRhN3RzRE5uY1ZT?=
 =?utf-8?B?bGRTbUNRVFJmOER1RjZYbzJJTTVVVUZaWlo2MWtFTGd0REtkaFhGUHBnSnhJ?=
 =?utf-8?B?NlFXSWtWY3BmNzYwQ1lWL0tKam9WZHk2emNvdHQ3VWRwR0tsVTBPLzM5MDNw?=
 =?utf-8?B?L25USElLam5LTkw0UEdNdFlXc0JCSituM01tQVZqOC9nMTRRNTcweC9EREMy?=
 =?utf-8?B?ME1WVnN6U1JsSVZFUis5R2dyUkxIc1RtNllRRWh1R0tkdWtaT09GZngrQURV?=
 =?utf-8?B?WjJpaGdFanFaRzFqdlRiWnJqbTRQOUVraThsNDlUMlNTZnNpanJvcVgxeWRs?=
 =?utf-8?B?OTdqTXFMV2xCZDhtdjd1WVpqQjN2dEFvSHBCK1FYbUNBQ2k5NTk0MWhTQ3hF?=
 =?utf-8?B?OWR0dDlQeTR6ZXBudkh2NGd6NGtXNTBmL2JvdU1VQUlkaFlCaEJMWDhSdktL?=
 =?utf-8?B?RDR5eHM1UGdneWRQa1FqUUppa3V0SmlndGY5SVZSNDAySjlkU1RwME50UU5P?=
 =?utf-8?B?T25QbDNWTzZ2a05EM09rRmptbE5jbEx6aFZEUG15RTA2OHd0ZUZzbzU5QjVL?=
 =?utf-8?B?VERmM1VGWlJxOHN4RW9oWlRQTERWRWpwZXhKcHdBUXhSbmVVMk5MNUR5cnJx?=
 =?utf-8?B?SVdyeGZ6Wm5MWDZVcW5YRWdTREpPcllxanBvTTc2NVhXa1BQZDIrVG5wMGtt?=
 =?utf-8?B?RXRiaXY5b00raitFb0thWVJ5d05ydzFyekFKTG5TN0FTNi9qV1BsNzg3aVhu?=
 =?utf-8?B?UEVRelJISnZkOURKSXhFWTdIY0VZcDVVOGR1ckNlclZPZmx1bDA2eTczc3VO?=
 =?utf-8?B?S1VOZEw4MEdMdXRzQ3dUVGVGTXdacTM5bUdadGdIUVVxK1ROeXU1UFhxZGdP?=
 =?utf-8?B?ZVRUa0ZXQUQzWEZJOTUvUzgrMjI0QWZCYjY2UXdrRzVoQmdteG1LaHdoUXUw?=
 =?utf-8?B?dkxoVFRzdXZzRkZZaGRrN3JmVW1tZFhWOVJ5M1Y2UkJQSkt3ZU1nZnR5Zk1I?=
 =?utf-8?B?bGoxK0ZEdjRCMjR0TVZtRmVOQ0lxdlNPL1FUVnRxUmVvNnJEY3V5Tk9SRWZs?=
 =?utf-8?B?V0lyaGt5ZXRvbzI0dFhlSUJrU2ppU2wyRWZEdG5sTW93WHdrb1VYS3kyTnBY?=
 =?utf-8?B?SzNsYlpMUzhrSkVUeit6T2tENVg1dUZRdG9vY21MRndCbm9oWkN5Yk1nbm41?=
 =?utf-8?B?T1l5NUgvMCtvQStDQWhsYU1BTlAxSkJPTGpoWElaSXBvTTNTejJqYlpleHdW?=
 =?utf-8?B?aFk0TWhNSlB0TWpCT3M1TWlSaWFqendtNHEyeC84YmNheDNaamtqL3BBVUkv?=
 =?utf-8?Q?0bd88bK+s23P4qpp0JTlRcdzo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480f042b-21ae-4962-bcbd-08dc8632d779
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:13:30.3783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ho8OshrCC1UGSLxQYyf3b5RX7nmwEuYXMvfm+662otazD3asRxQhx5/ibKLzRpZx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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



On 6/4/24 16:27, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Add functions to access efuses through PMU firmware
> interface.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/firmware/firmware-zynqmp.c | 31 ++++++++++++++++++++++++++++++
>   include/zynqmp_firmware.h          |  2 ++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index dfad798a2e7..8e9687693dd 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -211,6 +211,37 @@ int zynqmp_pm_feature(const u32 api_id)
>   	return ret_payload[1] & FIRMWARE_VERSION_MASK;
>   }
>   
> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!idcode || !version)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0, ret_payload);
> +	*idcode = ret_payload[1];
> +	*version = ret_payload[2];
> +
> +	return ret;
> +}
> +
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!out)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_EFUSE_ACCESS, upper_32_bits(address),
> +				lower_32_bits(address), 0, 0, ret_payload);
> +
> +	*out = ret_payload[1];
> +
> +	return ret;
> +}
> +
>   int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
>   {
>   	int ret;
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 73198a6a6ea..7f18b4d59bf 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -453,6 +453,8 @@ int xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>   int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
>   int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>   			     u32 value);
> +int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
> +int zynqmp_pm_efuse_access(const u64 address, u32 *out);
>   int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_mmio_read(const u32 address, u32 *value);
>   int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
