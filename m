Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDEECCD191
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 09:03:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EBDC88CFB;
	Wed, 18 Sep 2024 11:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NTQEn1zc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D8388D45; Wed, 18 Sep 2024 11:03:48 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2BD688CAF
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 11:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weUrXTtr1n2sU/kcTQR9smWgjk/GS5yzI0LPf0Ezr9qq9jqrj4pKUVZLkSBRSSmmV0oX9N3mDtvNiYsrL/Tb/IyIetKVJn4QyUvpNnQf34+ms8UJAufGq5DHXjFXQtK0K7x8vVZgSAD7xBHjHhS0ZSzCY9ahF92X5fLPTT4HW/IRef6Iq/9XpDRSLFRSG58yR4M1JIthfxJi9dmSTwmAmPIbK0y7VA7mA2GqRGcF/7RQoy0mMnyo+IxPI1/dTVorcyOmFIOHGLHJoetl1PL6O9Xztsd3cH5tv5y5t1SMj8612BT9wDVD0S/XipN9VcoNSfyXT7hQtuZn3R7Lc11TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/bNKtMHxCDfM265qExqflkJmFm5LeaQeqnsQqSrVEI=;
 b=qb59o82gkwYGgEhLxESiH8wFN2ScuxftxFMvyd6xGF6bYRmhFpihxy4yymeRvk2cceNcHpiKtR4lBO4nXeu4JDTqGNbXBJmIRBGK232YUGWJiKoZim7SY0FIWI8DlUqRiHVgPgRXAAzh1qsyigYUldy9mUbpQq42/SSm4EoOGk4j+q0TzqyrnbJ9xfstVRQL8uNXbEx3V+TytWxBG6aWnRnK6q4i5zrC1Uu/aa6rhItWN4dUQ6qOxGZzpkX+EdmLYdKevcfkNOFlxjsQY43aXcZA0KJGie9QGqwjmYka+96IJsPvwSasDQMl7xPK0ctUnf13LWf9CWC7cq6tjmMdzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/bNKtMHxCDfM265qExqflkJmFm5LeaQeqnsQqSrVEI=;
 b=NTQEn1zcrpniqYLzM82XKZ3LlDL3shWNHnls22zt6PM59UBUaX6KUqMu7M1PZT5GayvZzJo34LTvEoUvEAgpuJyB/RxQxC/96ZiGq2RQXQjQE47eOqF5jkFvXWjPl9curB1H5GogcjTFfJhfPgMITOMR3tm3SvZhxbsvIk1ZDGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Wed, 18 Sep
 2024 09:03:42 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 09:03:42 +0000
Message-ID: <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
Date: Wed, 18 Sep 2024 11:03:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: neil.armstrong@linaro.org, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>, bmeng.cn@gmail.com,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::46) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fb0e71-82c5-4860-5097-08dcd7c0caf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2trYjlmaHJTNy9JL2JFQ3dha25VN2UrK0xON2JGL0xoUTg4eTkrKzBnUEo3?=
 =?utf-8?B?ZitjTlNUV0RwMUUvN1hET1dvdmJhQUllMGppYzhQQjN2WEFSTGo0ZG1ZY2pZ?=
 =?utf-8?B?N05pREpSQTI4ejVJKzJ2ckZ3K25rVFVocGRGT3ZnS0VyVWlhTGt4SEZtZ1pJ?=
 =?utf-8?B?S2NYNE1jQytQQkFxTmpDZkRtTHRKQU5EcjJ0RnlNdVZncGM2R0lyRFdNTlJH?=
 =?utf-8?B?bm1ML3lGSGltODY3U0cxUWVEUEp2bHFiRXRNNTNjL05pc3Y4OFQyQXBnY3l5?=
 =?utf-8?B?VDRQZURwZmpTMTl3clBtbnVTYWZyY3JBdHZYK0xsM2NCRXdkY3NMenhvVllR?=
 =?utf-8?B?bGExbkN2Y0h0aURpZXltVFZFN0RaY1ZlMytaaTVHT2RKcWM1OFV1cWlKVVRJ?=
 =?utf-8?B?M3NnL08zNzBiV3NHckp0UzBSTTYrVHFOZWJxd1Bpb1JCSEtLbjg2MVoyQTFv?=
 =?utf-8?B?dWRHekc3cXZjNWZmNWJ2RFZZdUhLSlBlaWp3VzRMd0xtQ2wySWZhRlVMNWNF?=
 =?utf-8?B?TTJrZDF5K0dYNHJnbkc5R1pweXdYL2kzN3NFeTRxRFRHcmRVeVkvayt4aDNJ?=
 =?utf-8?B?S3dKQitTd0pML1JRS25Ga3NsOUZscVFka2Rmd25YRTJ5YXcvU1NJU2Q1NWV1?=
 =?utf-8?B?N3ladWE5c0F1akZZMEErUWl0VGc5S3RJSklIb3RNaUdoWCtTSWFxUGxkNXBi?=
 =?utf-8?B?MWM0UWxQbmh2NmVqQS9zOVIrZzY2UWtRaTdTck1lc25Cb2NwZm9BQnVOZEw3?=
 =?utf-8?B?VitMeEMybHAxclRDRnRwMjRtdlFUUkFEVHpXRDhiVmJibHczanI1TnZ4bFlm?=
 =?utf-8?B?TVJsU2VCWmNFQXhEeUJ6ZXB5aXdjZ2lOQnF4UE1DbjRlYXpTSlJsT0JZUk01?=
 =?utf-8?B?eE1lMTh0K2lsQzY1YzhEOXU1MjlodmlkV2hZMzRZYUNaS3NpMTR4NjMvK1pT?=
 =?utf-8?B?Z2N6SHkzS3FlZm9TU0IrVjJWN29RK0pYVitKTzQwR3pncDAwY2QySDFLTG5J?=
 =?utf-8?B?c09ldjQ1WHFseGRneDZvNDhpZ1MvY21Wb01zVlZGZUFTUW96Vk1RQVlHTXBm?=
 =?utf-8?B?RXFmdDE1QVdhVTZTVER4aGRjRVd6Wm1xN0dqc1l6d2VySEFPend2U1ZpYmNj?=
 =?utf-8?B?akpsVHR3MGpmU25aZUZUcnhXTDVzS1dqZzdWVzZQMjRGRU9tZ2h6OWRwYnpk?=
 =?utf-8?B?cE1nU054eThWa1dNRmpXeHRlSDBsN2o1ZDRJVzl5aWVhdnF0SWpTSWxMSU5l?=
 =?utf-8?B?YW5PNkZPd2UxYlhRL0ErSW45aEhsSWtQcVpaWTNOMm9iTCttUFFjV2JUMWR1?=
 =?utf-8?B?dHo5OVZORTFJSWFzOFRYZzdjdGRIbU9GMEk3U3hlQkZQTnlIQlpNNFBGQWpw?=
 =?utf-8?B?MEVtR3VhMXZrSWxQOThHS1ZDNUl1WDVTdWRpbURBbUpncUxESEhhaGFEdHNj?=
 =?utf-8?B?SE5hWTY1N0RHeC9kbU5HazFjKzZHS3JQRWkrc0orZXhsU1crb1ZsdDlBQUdF?=
 =?utf-8?B?eVo4ZjEyeWREWUNGQklWWTVzc1djY3FaVXhENktFMlYwSDJ4WEoxTm8rMVBy?=
 =?utf-8?B?WVBmOFloSXhSbmZ5Vi92TTlhY1Z1UFlWOXlQSVhtam9yOXdxVEdQSWk4TTZt?=
 =?utf-8?B?MzFIR2UwM3lKYURCajluOWRNdC9QVnVOUk8rcDlLRnl2TkhBbVQ4STJNN3VC?=
 =?utf-8?B?N2F1VkxQa3ZCZjBiMFQ0UFloRTZXMEFKa3BQMUJScUZVSUdSN3FEWWYvTExl?=
 =?utf-8?B?dWU5VXpXdHVWTWh2M3hKbDJPdmlMdTJPclBTRzFPWFV2MUYvSnptbCtoQkxW?=
 =?utf-8?B?NENHU01RaStabGZ4Tllidz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Znpld0s2U3ZSZDJzZTNLdFBrTFErc3lTVUZvVnQzWGxXaU1pVnRmS2xGc0ZV?=
 =?utf-8?B?eVR0TUxEVkpVeVMyMmRHeDJGZ1JYYmhXN2FIbGxpTXF1RDM2bGpjbnBITlNo?=
 =?utf-8?B?QnloUEdmbHp1dnl2KzFrZVdxd3MxT1hMVG5JY3luK1JGWGFEODl6bGpRQTV1?=
 =?utf-8?B?NkVLeFNwYW5jSmtIcSsydjR4UXcrdkdpU0NlaVRnZmdVYU1scWh5WElxVVBv?=
 =?utf-8?B?cnFkV1VtaVAzZmJ1ZWZLUHlId0ttVkFNNko0Z0pNOW9JSkllUEl0QnBIVnl0?=
 =?utf-8?B?dzd5cWZhU09xRTVPQmkvSWlxOHFia1BlNVI1K3RYVERwVVNLbVROMy9SZEVJ?=
 =?utf-8?B?dkpsSXBzb1BnODFYVjVmV3hsTEVGczJ5aVRWRi9aUzRQaWc1di91ZVNIU1Q5?=
 =?utf-8?B?RXJ1cVFvZzFrSlQ1N0lwZzRUd1EvN3ZIamUvVzFnNllZTk10dFNlSEJBTGMx?=
 =?utf-8?B?VmRHY3hHUjhqN3g5V1lHWEdidmJXSFQ3WTczVDJPb2QvTkJpb2dmZS9SR0Zy?=
 =?utf-8?B?WUdsb00rQTRxcEI3bkhoS1A0YnN6R0FSdnJLdGw1M2k2S3NIQlNTK0FoVkhM?=
 =?utf-8?B?QUhwbWhKTXZwaW1PVXM5V1M0UDFLU2twNmRaWUFyVjhrYlFxSU9idDZTS3kw?=
 =?utf-8?B?ZVBSaFVVSUlDTWFod0pXNzZRM0RxeXByUktLL3JZVERhcDJpTFdRN3BXUFZK?=
 =?utf-8?B?VDRQd2xxSXNpcStnMmQ3K1FNenp0TUhpNk13NEoxOFJCZmNBUVhmNEs4Z3hp?=
 =?utf-8?B?ZlVpQktTbHRrZ2lnWEZCVHhoZWUvTVpjeXA0a3lwM1RFT1hpZGIzdDJyL1g1?=
 =?utf-8?B?WGFmZ2hTVzhoVGlNR1JvSithaU5BczZMZEVnUzJDMmFFY3RZQ05FS2xTZ3U1?=
 =?utf-8?B?clhWUjVvbU9uTTBPU1l5QVY3c1FKTlhzeWJVbVBMRzB1blM4ck9VL1dtVkJq?=
 =?utf-8?B?VDFpTTA5UklMbENGWk51SmlrTzBuMVdMc1JUbHJrQ1lpRFNCckVZQ3Zmc0tG?=
 =?utf-8?B?bWVNdC90WFpqWlZ4M283N3h1RnFNWkpyQTd5YmRRQTBFWGh3VkttNDJ6QktZ?=
 =?utf-8?B?SXBzc2dDNEFCU0FZOWJwQk1kY3Y0dk5KQk1vYzFWa3hIRk1HSFFqend6VkYw?=
 =?utf-8?B?bkoxL0IvbWJMd2Y0UzhaWkhQeXJNeHdPajBLVDY1Y0pReGREZUVzdGRTLy85?=
 =?utf-8?B?OGl3dnpZazdqbXZUK2F1NS9oMTQ2cUJmZDBoMStqQmhQMVJobWFRVHlqTE42?=
 =?utf-8?B?a08zN1I4Z051R0Y0QzlCMHQyaFEycWdWdFJxWURWTjFNeFhlQmNFWFZHRGZS?=
 =?utf-8?B?VVNkMU00OVZsVXgzTUU3b2U1V3ZGN2xoeHN2WXF1ME52Y0prYUdJaG9NRDVa?=
 =?utf-8?B?MGxKT1ZPK05xb0gxUjZJVnpoSzJ6R3F5R3hiWi9DQlhwRWpuQWJraWM1ZURk?=
 =?utf-8?B?QTRWQU1va0RoTktJSWJ3ZUV5ZkhTZFY5dC9EbXJMNzlTdFdnVXpnSi80L285?=
 =?utf-8?B?b0hkTjRzbDJDMlFCOW8zZzljYkx1eEMzMlpyZXE5MjczVldiejl4RjFRU1Zh?=
 =?utf-8?B?aThxZlc0T0pXengxdW5GSU40d0FzM0IvYlVDV1pObUlHZ0J3MkNUYTFuY2hN?=
 =?utf-8?B?VnNVZFh3eEZPM2FuRGE1T0o3eTY2UWpOcUY1YTJoWmVrUkVsaTlZelROTVZi?=
 =?utf-8?B?SXFqK3M4K2hYYk1LcERrQkZ3TTh5ckdzdEVMY0hoVVZTSXVBdWpoaGxnVUI1?=
 =?utf-8?B?dmN6dWJnbXZFR3NlbCtDYjhJUllqc2lGYm9TOE0zbDE2d08vRyswMHVvakhZ?=
 =?utf-8?B?cHkvMnNSZ1Q5dzJ1SVdYcVB4bG5abVRBeEdCWkY1NWhwVWNwQ0NVbWdWRGJx?=
 =?utf-8?B?ZUUwZ0FBQlFnV3BCcENkeHcwT1FtVEY1REN3SkFZL1hiTVZUV1dyZ0dnSDZO?=
 =?utf-8?B?SXRIM25abXRoTVBRSzEzM0hmNUZuWjVqYzB1ZXEyUndveTZYWVNUMGIwVkJx?=
 =?utf-8?B?cmVTVnRqQWZHbXNRZG9vTVEzYWxpMTZScWJJVWkxSUNSSzhUUk5GMmt6WUpY?=
 =?utf-8?B?S05sUEpXaXlBYlNzdTJxZ3FPZ1lkYUxTK1lTZmNTbEVmOTdUa053cU84QVps?=
 =?utf-8?Q?ATYvP0XQ4Pe4+nf0T3xfiDR6Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fb0e71-82c5-4860-5097-08dcd7c0caf4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 09:03:42.1040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U33LYwMAIXk7DszHoO2c31govWG6P4Ronv7yIKzs1kYnADmdj58uOiuT5HaE4d0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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

Hi Neil,

On 9/18/24 10:06, Neil Armstrong wrote:
> Hi Marek, Manorit, Tom, Michal,
> 
> On 10/09/2024 11:20, Neil Armstrong wrote:
>> This serie regroups all the fixes and base enhancements required to
>> support the Qualcomm UFS controllers in U-Boot.
>>
>> This syncs headers & defines from Linux, and includes 2 set of
>> fixes that were sent separately:
>> - ufs: core: remove link_startup_again logic
>> - ufs: properly fix cache operations
>>
>> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
>> since v5, and a numerous of Cache issues makes any UFS controller
>> fail to initialize.
>>
>> Since UFS core hasn't changed for a while, and since UFS is core
>> technology for the Qualcomm SoCs, I volunteer maintaininig the
>> UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.
> 
> Could you run this serie on the r8a779f0_spider, j721s2_evm_a72, j721e_evm_a72,
> j7200_evm_a72, amd_versal2_virt and qemu-riscv and check for possible regressions ?
> 
> It seems the only user of UFS_PCI is qemu-riscv, is there other users ?


Good timing. We are close to send some updates to UFS which we require to get 
DWC version to work inside U-Boot.

How far are that core changes from Linux? I see 9/13 is sync with Linux but when 
this is done you should also say which Linux version was used for sync.

I see that there are definitely some kernel-doc issues

Also s/U-boot/U-Boot/g

Venkatesh: Can you please look at this patch series and validate it on our 
platform? Also make sense to send our changes to make sure that they won't break 
others.

Thanks,
Michal
