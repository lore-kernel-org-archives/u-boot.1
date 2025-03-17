Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1D8C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 10:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF1680107;
	Mon, 17 Mar 2025 11:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A3maHMAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E0080F4C; Mon, 17 Mar 2025 11:06:38 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F5FF800C2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 11:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvoQ1NdqCW5OuCPPpFkrzJ7tYSSNSkwmTnxXZVE+00m7kNUA18fL2x70jVLdSOGZkHv4GG3m0Ou3O04Ok3uUBy+E46SyqTZBNFsk5OLbUMDW2fyMs3G1KeXwmu2Lha64o+xQsf+8Gxl0RmrpvgkP8b35rPWNxLnMYLS3ArtgK91+kjduPGESDlErHkcZG728CfLzLcXUY7wLtzgNCriUAXVCQMKGeLQ3GaAJ3Le6a2F868G/BpBn696em8kG5b9QJ2ISILUyUCcoyexYiLhg/5PK5m/9AmIrczygDRotOgh6h+Zs+2FtTdr8KdXDkwyQtSElfEmAdItuV9aN1jUdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u5VXJIuHvCs06m6ALT4Z17oMoCf5csnE8NX514PAjs=;
 b=zP8xxNOISbYFRqyRfbW6gosnJdhhzTvDpT4S3aM+O/+zyaaGhsGe1w2BfJzDcY/vIGjrzULK4QZ4WDKba+wnHBnh/FEM62VpXYvyH9MbL9BLFHIeJvNVoDCGnZ12llhHVj9vq6lLJjrx1WE31lXyw/V5oNHYK2QhQInfU6zYJhSitle1La2tpBrwMg5LU6zsvso3JsE8zFHnnHMgnKwrqBIiMLhv2tZuAbG008NKEsjvy2Za8hSiwwaPGl7TFZE492Dh2NcgDzkJ0jHi8MpMRjQ5wGl7MrkIMPl+sJySgBkWSvnGs8PwG6wQ3QunK7VoDGqsSX3DfK8qx6grCtoaJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u5VXJIuHvCs06m6ALT4Z17oMoCf5csnE8NX514PAjs=;
 b=A3maHMAqIa9ySoxhqoSZhXEu3F2u1eIXiFoaeOJY5vNTG+EbYQ8erTknHnlm/S5T2H8Sfq+XAYuSlMefR0ivG6SjkMnIMl0DVszIF8fpjiBaYJXDpYCAGgeUZr2q0FkwaKp/bH3FFP/Ab/NuyIak375C9/O/U7oE52SnjbR88qM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 10:06:33 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 10:06:33 +0000
Message-ID: <72691528-b3cc-47be-a3ac-453710c6f906@amd.com>
Date: Mon, 17 Mar 2025 11:06:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cmd: fwu: Dump custom fields from mdata structure
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Etienne Carriere <etienne.carriere@linaro.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Tom Rini <trini@konsulko.com>
References: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <75c697a4f819bb5e8649ed658c5a559fb8cd1fd9.1717599342.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0214.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::35) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|BN5PR12MB9511:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0272df-53ac-4b30-d0ac-08dd653b64fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUdkVFMzclZPTVFNMXV5SFpFUy9OZ0ptaE15cXcrWkJxSFExSTd4T0c0bFB5?=
 =?utf-8?B?cDNGdUxBamlmeVJlWFBXUkNsd3lodTVPckt4TFhzbWNLTTlzRHMxTW84ZFl5?=
 =?utf-8?B?NlM0VXJmU0c5cWhUWG9LT2xBdkdKU1QyRDdMeEhaRzVoZTN4Qjh6M1lWL2Mr?=
 =?utf-8?B?dFJoNHJiU01DUHFJZ3BCZnFScmhHOXFUaGMvMnh5U1NpL0Y2N0xraDF5REg1?=
 =?utf-8?B?M3ZtdUVpY0xzc2dLdHR5QU1OMUhsODl1cWhvQjlnSEpSeFU4MGduaDNvN1cz?=
 =?utf-8?B?Y0xQUVdCK0svcnJKUFZxZmo1Rm5uQmxvNkRTaWNjMmk2UUNjZERCWFhwSHhy?=
 =?utf-8?B?Y09QVGlzdWZnVmlldUJ0K09sNDI2NDEyMHRoYk4yY3ZRTk1SbHpITk5kc2U4?=
 =?utf-8?B?UmYxYXJwSHRFMTQ1RlY0Ym9BRUNiV1dHS0VpM25FVnhNMzRibDhNVWRBMitr?=
 =?utf-8?B?QXJvSFRkMjNnMHZUT3NaMnRTZnRTYlVzeis1T1FWcjA4S1B5RWZtcW5oTm43?=
 =?utf-8?B?Unc2ZTMyalRsSXVFbzMxdS9rUUJYYlhpbTQwMDk0N1ZKSmlHWGVoMXl4REdD?=
 =?utf-8?B?QXBRdnlXU2ZtWGNxcmk1QjNLd0V1RnNEaTdtWStsY3NTd2NqaW9MQ2xUT3dw?=
 =?utf-8?B?ejA2VnFaUUNnWUlibWx3UnhWajBLdjJ6WXRsYmdIV3ZadXpTWlJzaUZTVFpR?=
 =?utf-8?B?QnBFOVBXcUp0a2laVFJZVEt1WGdLWWxaTjRLUEJ2K0VIM0JnQlgvSHhZSTVp?=
 =?utf-8?B?VFo4R1J1RWtrUFBtTVM4YWFzSDgxb05rUTFkSXZaTlFWVVlyZXN1Q2pMaFRM?=
 =?utf-8?B?QnlHZ3VlWG1SdW4zOE9xejJBZTFNRUR3Ly9ERDVFOGNsRHJHaWlxVU9GQStx?=
 =?utf-8?B?SEdIQUE0cXkvcUtOS01kd2VVYzBGemlDZmhjcHkxRzd3cFVrRE9USDI0Nk9F?=
 =?utf-8?B?cGQwK1o3NzNtSndsaUVvUlU3MEVrSmtpcFlZRzRhOTlTdVNyY3luaVB0TzNE?=
 =?utf-8?B?VFlWeWVwemg5NTh1Nzh2M0R6b1lTWGh4NGFTUWlvV1AyWEVGb1drS3oyeGU4?=
 =?utf-8?B?cFp3ZEN4S1N5SkdNTGZHUVRsWktjUFJjUGo2cHNTYm1PeGdxRDB6Q3Jxbm12?=
 =?utf-8?B?dThaUzN2UDlrelV6aTJxbVR2TTNLTWlZMDZ0UUxiTmZkTXBGb0hJbVp2TWpq?=
 =?utf-8?B?Tm9wOTJhMlg0QW10eHhMZlBwanhLMnYzanFlWVFFdWUxWHJzdjYzY01EWFk5?=
 =?utf-8?B?ZTVkSnJaTGFhNSthTzJWakc1T1Ivb2cyRGxVQU1vNEoyemw3K2F1emlZdk9S?=
 =?utf-8?B?OC9INVlja1FzR0ZFempzOXVNS0I0d1I5eU5YdjI2SnBxVmRHVFJPcWk1NTZv?=
 =?utf-8?B?akU4QU9sbFpzelpqZGEyUmMwTVZUektJTnZuN0RtbUV1OGw0d0o1RVpUV1dR?=
 =?utf-8?B?bjg3V3Q3R3RxNHNsWlk1bkhkSTB6cnFrR1VYNFFiWW9odG9Hdm1BbUc5N1Vy?=
 =?utf-8?B?WVZuSSt4YWpuRHdtdjZWekd2Qno3N2ZzWnNDL3lRNElpbWp5OWZuVm1ybCtC?=
 =?utf-8?B?bFNVWHlBMlVtM2dOMk1RTDkvMnFsSXFXWi90bFNiQjJ5MHRuSks5d2JpY2Nw?=
 =?utf-8?B?V1EwV2FvdzZvTWp6ZFRFd1JTMzhEclFwOUF0RUhCYWRyRDUxTDdqbXdIU1VY?=
 =?utf-8?B?V3JDQ2dabnpCbVZqNWJTM1dKVjExZUJiZVpnb2VUU0F0eGd1K3Z1OU8vc1pM?=
 =?utf-8?B?OUpJZnhuVW8wRzhhYWtUbnpZU3NnQ09ZMkdneHdIWTU3RFJVK2JoVkhwNE9O?=
 =?utf-8?B?YkFZMTAxUHh3OUc5RStmTWxMbzdNMWRNcm92MU13UnBmRHVIVk1CV2ExWlVh?=
 =?utf-8?Q?9XmDleW8ZR9Kk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRXMkdSckNPRUlSU2lSa3NuSnQ2bkJIak1FRlgvVWxTdmp2S215L3B0dnp4?=
 =?utf-8?B?UHhlR0x0c1pNdkwxU1RLemdkazRiVGpxWUhXdGU0N2M2QkpvR0Z2RjUwazRK?=
 =?utf-8?B?TXUvdmtDZXRqazEwZ0REQmZLTGlQY3prakxMQ3dzaU5rVS9VRW1yU1MrclFN?=
 =?utf-8?B?UFBBU3pIaTlJVFJJSjUyYk1aOEk3bGp5aWhnQkJlV2pOTkk4d044VXRKWnUv?=
 =?utf-8?B?SW1BZDRSbm5zYWJkNTZPOG1GNUdTaEZGMlBCMmhoZHBjMkZHUG83SVZyR0I5?=
 =?utf-8?B?L1FNdzlvZUpmZ2NQeUNLVkN4dUhFK1RmTFQwL3BZUVFBNVJFcVFjR2orVjB1?=
 =?utf-8?B?VTllZnRXUzlOaEFvbTZDdTdNeURSSjBEcUIzSW5VMW1kV3RRQmw3MkJJVzFQ?=
 =?utf-8?B?STJMSktGYUVyRHJRbkl0TDd4dGRkazE4d2JZbWo3QlVDTnU1N0xkZnVpSkg1?=
 =?utf-8?B?RzhJUW5HM25NVXVEYndLUnd1UE83WXE0VTN0akYyU2xBVEJoSG9obWg3VmdB?=
 =?utf-8?B?THFTRHZidkJaRGtGQWlhZGI3Vm1ROVlrMVVsMU0rK1B6TmVHSVk0RTlCTHJu?=
 =?utf-8?B?LzhMQjZvdUNudk9BZG5zM3grOSt2WXZ5L2Ftb1FGb0hSVVVUTmtEVjd0N0hH?=
 =?utf-8?B?RFdrdXEweDlwSDVSaWtXQ0Vvbjh1ZkxFVzFXc1JUM1NoRnVBU3VqK2hlSWNS?=
 =?utf-8?B?c3FuMFpUdWNzMVFDOHZLcm9aUzdRVVBpTkxxQWpHdTcwa0ZNT011TjkwcmZt?=
 =?utf-8?B?WFM3ZFFZeGo1bG80cDVod1llMCtvLzdhVVJlZ2RPZGpFOHhQYnhncnFDSURG?=
 =?utf-8?B?V1hIYitmRUxVZHd6ZTJQbjltWTc4S0RnUnVmdHJ2eS8wbmFSWVdkQU9tVVpm?=
 =?utf-8?B?RVZsUkNnK04xSG1pdHptTis1NWlxRFRCMU9XRmlKb0wxcThaVk9ZcWhCRWE2?=
 =?utf-8?B?YzlEbS9BdjBKcUZjY0lVdEYvSkxoM21CL3BVZ21Db2lVNTI3ekJzOXgwdThI?=
 =?utf-8?B?bVJQaGlwc0svMUFIWmRMTG02NnFTOUNZSzBCcDdwNzREcE5KZ1ZHL2FubDkx?=
 =?utf-8?B?TzYwQ1kxdk1CelhiL2VnbXBaenIyVGxqUDlTaFVYMmU2ZHlPcVR2OWNrdUk2?=
 =?utf-8?B?cVJycHRFZTdKUSswWnNSTUt5cWxqZHR1a3pIQ2dnZ2xGMUtZVEVrTFc3dnpy?=
 =?utf-8?B?QnBqVHBsY3NBUnRXVG1Lc3FrU1NtNy9JdmRpUHliL2UyamJsb2ZYRUNlaC9N?=
 =?utf-8?B?VkFDOW1IN3ZZMFRHQ0c0SFFwcjNRQ0hIdG1wSXozbGYzQkF0aEpiZkpFUDNN?=
 =?utf-8?B?eDFMMUpmbms4VktpSDZiM1ZUcEsxWVg3bWxIMGN5WUR0RWJYWnY2U05sUnQ4?=
 =?utf-8?B?RFZiRWljMURDa0tVMVVtNlVQc1dVR1R4aU5nRTB4OW9wU2tVamprYnNJTXQ4?=
 =?utf-8?B?akVKWUdQa0hMV3YvVlZ3T0ZkYWpRUG9BbzB2YW4vRndjSUVMSnZ0bXJDTGQ5?=
 =?utf-8?B?Q1lRNjMrd0VQRkZ0OWtVdklaVHliUmVNbDA3LzF4THZORFMzeFN1VmxFL2JV?=
 =?utf-8?B?MUJtaWtydzloWm1SZit2U2ozVkV6bmtJNnE0WjQyUzJyK2xFYTRVRzI4YTJq?=
 =?utf-8?B?ZWtFMzFEV0NHeFFSTFQ2NmgyRFdKSm05ZCtqcllpN0Y0aWpRM0kvZzcrWnVM?=
 =?utf-8?B?N2VLYzNWQkprVVpGclNDdTE0N2xvQ2lyd21BT012WFlPOUtmUWxub2pyYWN3?=
 =?utf-8?B?VG5vZHI4RnhLeE1CWDAxTm15YzFSY1N5TG9lenkzNit2R29mZWtwSFVjejVr?=
 =?utf-8?B?WkllVG5KWkJEMFhreHYxb1lRaVhnajZZK1lkNTduejBKNWw0UWJrQXJ2MFJX?=
 =?utf-8?B?N0Q5WGxWVmNvR1BYMHpIZVIxVEZNY1g3ZnVsUUJpcm90RGlFa1BBOCtSdlhT?=
 =?utf-8?B?ZjNObmxEbitWMFZBdzJ6M0xOOTVpQzRZRWZhL0I5d1NKci9ZaGZDa2xjWnl1?=
 =?utf-8?B?a2xzREU5RS83c3JTaHg5NnNLdGo5blB6QkYvcTkyR01vd3c3SDAxOXZYU0ZU?=
 =?utf-8?B?TGoxQng5bk1TdzJuY2cvUXRmaE1kSVlRVUlwS0hlZVdkWC9TSVUvcWhWVnk3?=
 =?utf-8?Q?pMqKcQUh5CJRep8tQ2hZ1w9wv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0272df-53ac-4b30-d0ac-08dd653b64fa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 10:06:33.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u32kK+MaYVIljUvcUfcdks1y5ze0gTKX7MTPnZRsjIGhU7fgzII8LjEliqlF/VE6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9511
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

Hi Sughosh and Ilias,

On 6/5/24 16:55, Michal Simek wrote:
> The commit cb9ae40a16f0 ("tools: mkfwumdata: add logic to append vendor
> data to the FWU metadata") added support for adding vendor data to mdata
> structure but it is not visible anywhere that's why extend fwu command to
> dump it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> I am using this for some time to check various configurations that's why it
> can be useful for others too.
> Sughosh: Maybe there is better way how to dump it.
> ---
>   cmd/fwu_mdata.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
> index 9c048d69a131..ff6435505167 100644
> --- a/cmd/fwu_mdata.c
> +++ b/cmd/fwu_mdata.c
> @@ -7,6 +7,7 @@
>   #include <dm.h>
>   #include <fwu.h>
>   #include <fwu_mdata.h>
> +#include <hexdump.h>
>   #include <log.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> @@ -45,6 +46,30 @@ static void print_mdata(struct fwu_data *data)
>   			       img_info->accepted == 0x1 ? "yes" : "no");
>   		}
>   	}
> +
> +	if (data->version == 2) {
> +		struct fwu_mdata *mdata = data->fwu_mdata;
> +		struct fwu_fw_store_desc *desc;
> +		void *end;
> +		u32 diff;
> +
> +		/*
> +		 * fwu_mdata defines only header that's why taking it as array
> +		 * which exactly point to image description location
> +		 */
> +		desc = (struct fwu_fw_store_desc *)&mdata[1];
> +
> +		/* Number of entries is taken from for loop - variable i */
> +		end = &desc->img_entry[i];
> +		debug("mdata %p, desc %p, end %p\n", mdata, desc, end);
> +
> +		diff = data->metadata_size - ((void *)end - (void *)mdata);
> +		if (diff) {
> +			printf("Custom fields covered by CRC 0x%x\n", diff);
> +			print_hex_dump_bytes("CUSTOM ", DUMP_PREFIX_OFFSET,
> +					     end, diff);
> +		}
> +	}
>   }
>   
>   int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,

Can you please take a look at this patch?

Thanks,
Michal
