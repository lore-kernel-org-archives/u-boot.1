Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CE3C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F1382C55;
	Mon,  7 Apr 2025 08:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDSQJIPi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF03D82C87; Mon,  7 Apr 2025 08:26:18 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F85282B9D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SnjFj5Ez9SLiW9SxDpLyRYul3pukrbToptctwGndjST0Sg6RNAJsHn8RQl+l0C4+YfI6pPaBnBuNEpLAGqWur84eihSPVf/i1lbD7rRBT3ePCP3IbXgePjK/wAepaTOtdtOna/CwRsilAJ7hBuQQnP85mR35oN/uT/NqGPRcALE3FrZHg5xGRJMSLwzpLnAOWW7cybZku9UFejEmIWDGHgPVyuC9N8uPstZD5FqXBLzJ95v5UJ0SKMdBqiQOwVFfAMntIVtSiqWOa9XAuNdyt3C49yux7IM6qthrwbIjDo2pIwH/YkkkaRLR3GWT8D34ykBfXGkXgi5v3JhXYHeabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tboDAyRqE548zbtJ+CeB9sDg/KE2cED7e//R4AbBtYE=;
 b=MWqXIXHH5DHZT/c//58ZM9oSTHWHc9Wl7+WgfUIh3YsAVjma9vk9sFh6HxljRyn7lJCUOdUeSwg22CEMJ3cAe1B6LJL7Cs/w25vWXJ4g6xlk4IF6j7p0NsZ2KE3XswUAEYYU1HJaal6j1mK/hdOh8XK9fNbyGmoSnHbo8WxEn80UyEm2IOS7AMagm6DMnfQEf03A/ynmQDIzQx+6339QEcRFyEOvw5nChiP5WggqXjSGbcPwHJJsqCqLRnAs5nBW0q87ckh4aiVg9+KG/LRXwclfrxedby6SVYfslPFhQbTx/wznEW1DLTpu3hTPfTXp6QdxXAhq0Yu4m9+Bhgycrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tboDAyRqE548zbtJ+CeB9sDg/KE2cED7e//R4AbBtYE=;
 b=kDSQJIPiFsovmLAy+4jPyNGewbetY8HBBSCg+ppVurgn2LbsuRGUNUBV7wkUIINhgNdwijmJKQuMG9OnqROKszqtsJjv5UIQlDP48dKiezdcEWt+TKV5agM8ZK9kt9tggHZmLVJky/vvUPs/ZIW4kAJPV+Xzv2IdWFHNIEKeRg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Mon, 7 Apr
 2025 06:26:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8606.033; Mon, 7 Apr 2025
 06:26:12 +0000
Message-ID: <cdf0abbf-38ce-4452-a58d-54da7549de73@amd.com>
Date: Mon, 7 Apr 2025 08:26:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] configs: qcs9100: Enable env in UFS
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 trini@konsulko.com, joe.hershberger@ni.com, marek.vasut+renesas@mailbox.org,
 cniedermaier@dh-electronics.com, xypron.glpk@gmx.de, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250401080015.1470999-1-quic_varada@quicinc.com>
 <20250401080015.1470999-4-quic_varada@quicinc.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
In-Reply-To: <20250401080015.1470999-4-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0858.namprd03.prod.outlook.com
 (2603:10b6:408:13d::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 22fd9c29-4fbb-4549-6292-08dd759d17ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFY0OGN1Nm1NUk5qT3JWSUdsSnlidVgzSDBKdWdLR01JOFozNEYveDVvL2dF?=
 =?utf-8?B?RjdwMVQvSnpDRElBaWpnVk5oTUVSc0diMUltKzc2RHpZZFFKT3d6R1NTMTNX?=
 =?utf-8?B?NU9DSDg0WDh4bWtHU3h4cDZKYTFLOTFVMFloT0swUkk3MmZSNUNsclJYQmNv?=
 =?utf-8?B?NVB6TEJUTHVoUmhZNEdxQTJNNGdjMVRtVFdhYW85U1JWcVY5NnZpQzNXL0cy?=
 =?utf-8?B?SVBCbWtWeVdaWGk0Vmptc1pOaEovS1VNQUpkRXpoUWZNaVVvWklXaC9EMXAz?=
 =?utf-8?B?a1JPZStOV25yNHRqSitzWXVWeS9rR2VHNnV5QjRGL1laYzZUbWk5QU9URU02?=
 =?utf-8?B?M2dLV044MjJBTC96RVZXQVh1NE1tUnowWjZhNzd5QnlVMlYwRi9TMXlLUjVH?=
 =?utf-8?B?K0I2OGtZcG0vOGJBZnlWSVVQZjF0VmtnM282MHZ2aTZNcjF2WWV4VUI3T3Fu?=
 =?utf-8?B?WEJMOXMvaGZXK0lueUY0NTJhamNLM2FkVVBMQSt4OVE4L2ovdmZhUFc5SEV1?=
 =?utf-8?B?eW5WTHJYeFJlb0tneWlWNXZIWXk4VXEvZ3FzL0dITXB3eUo5UmNveEw1T3Bp?=
 =?utf-8?B?ZFBZVUZPUzEvQmhhb2hrQXR0THJJMk1CVXAwVmJ6M3VoeWhMVGJDV3JpUjVW?=
 =?utf-8?B?QjN1N043U3JFS0hoQ0VRbEpmYkY3SzZMOXU1QXkwSnR5VGdJY3BqZlZzWXJk?=
 =?utf-8?B?dWlidXF0WksvbmZtQWI3STdmWU5NcWRVbjEzc24xOGRxUW4xM0JRV3YrUmFM?=
 =?utf-8?B?alYza0xxVkNMUnBsQWlEMmx1ZldESVJ0UmtZKzVSYjltOXU0S05mLy9lNVJQ?=
 =?utf-8?B?YmhGMDhad3NtNjkwT2V1cnR1cVhoaHNEV2ZXYnlMOWtrbjNYNW5QL2Q5azNS?=
 =?utf-8?B?Y3V2Sll3YnFrL2F2ZE5wczVLZ2RnZFhGSzMvZE1DU21wUFV3RjlIY2NoOGRS?=
 =?utf-8?B?cU1hOUszaEhFQndFRmdHMDJMMFBUT3lGZkpuWUV4ekF4SmFNaGsya0dmUVpo?=
 =?utf-8?B?RFNkOE5hT2NpNEZzWjBkemxyM1RXZHE4Tmh4TXhieFlFVGpXeVE3NDJDZFdh?=
 =?utf-8?B?eUZrOFNoWkhSN0lPS0NWaXhKNDAwRFdRdWNQTW5VZDVBZitJMUh4QWFiUDJi?=
 =?utf-8?B?eVVwdS9hZWI2eGtPTHlCeVE1MzNnQUJ2SnBBdVVQU1lsc3BKckduemZYVCtM?=
 =?utf-8?B?UTN2azhXUVc5c2tlWnhZME43YlVwcWx2bXBoWWVETlBNWTdMeTYyTzZ3SWhu?=
 =?utf-8?B?Um5GSmxFYVV2dmZBSE5DZU5jVldPb29DSHd4SUlpOXVOTVg2QnB2d2JDZGJ6?=
 =?utf-8?B?WmYzR0xwU0N2a05hdmpXbHhaSi9ZMmJjN2ZOQ3I3WmVFWUZMZlFGY1JNNFBy?=
 =?utf-8?B?elpVcXk2bzlQUXBvUlp5czZGV2RlUFB3RHNSUmNDRnEvbEtvbWVBNUlsT3hE?=
 =?utf-8?B?TlJuU2xiQnNxbVNBU09jZUYzanI5bkJpNUM0YU1FZ2dseDFHenBBMUV3MHZy?=
 =?utf-8?B?bFhDZ2RZU0NCNzRHT3NZZWE5cTR1STFTQjVaa29RME1xRFk1UEtobC9kbEZy?=
 =?utf-8?B?dTNTMGRLOXpRRUtsMDFSdkhJSnl1MzVtVjhoRGp0WHAyaE40U0dTcm83dHBW?=
 =?utf-8?B?NDRySXBCLzdLNDhRN2RobEVpMTRoYjMzMVR6dVNycUFPcTRoU3NiUXJPdjEz?=
 =?utf-8?B?R3NxR1hwTGpZaitKcGUzdk10Tmw5Qmw5Z2lEYjUwZDlLNS9paE0yWmRBb3h4?=
 =?utf-8?B?eFpoVzRHVVVOL0tURGtFUEJWOU4xZ1YzRHRVQldURXpDZWxZQVpzMk1laTVY?=
 =?utf-8?B?QldCQ2QvdERxWGlpeFZvOXp0dEE4Mmp3czc2ajJkcXJvMjFIMjhLMElWb1ZG?=
 =?utf-8?B?U2F3cVNaeW90T0d3VG1OZDFpQnoyUUVsa050QzFodURFdlc3WElsVHUrbUNt?=
 =?utf-8?Q?1Y9v0yzUA4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWYxbUgycGJZdUtWUkEwYWNETUovNTlUSWtpcnE5QTdGajJQK09SRGg3WS9o?=
 =?utf-8?B?WDZ2aGNUcU00eXkydU1PWTZWOFIrNE14OHJ3SVBwWG5TMWNlVGRMZFZlcWx3?=
 =?utf-8?B?dU9abUVNRkdEK0xOTm1SMzFGYlZqMDdFS2pZeG9XZnBIdUZLNXQ1NllEVm0x?=
 =?utf-8?B?SlJDemtnTXdBakd3ZEd6QU1zc1h1TjBpSExhb1V4L1ZHajNuS3Z1R0w4NEhX?=
 =?utf-8?B?SnhqMThBSVJ6TUl5Ykw1aVRiOExjWi9YWHE4aWo4dWxWU0lmSGhSNklvaGo3?=
 =?utf-8?B?MklSQmpSejREWXRvckQvRnpGcmU1VFVqcWlob0hGQ0t5T21rcElDclZYSTBw?=
 =?utf-8?B?Y2F5YUh1MDQzZEcyUWZjNmUrSDY0NzdSWnRhcU1tcko0YjhFOFZCZzVCS2xO?=
 =?utf-8?B?d0lQWlZmNVlXUlQ3SGxUZ1cyMzltS28xY0NEaG1Ua1NpL1B1bTJVMjdlUk5n?=
 =?utf-8?B?emIvcHdkeEV6WGJtQXd5cWRvdzJnQ3hqRmpOSW90MXJZc0xCQkZRQmYzSUhR?=
 =?utf-8?B?NHpjOFBoQW9XSTFDdzZCaUJxVDVNOG1ueENmUXBtcU1Td05SbjRDZ1FKQ0Uw?=
 =?utf-8?B?bndaeXByeVBVNWFwT3BlMWpsc2Fya2hpWVNzcU91NENTcGh2c2QwdG1zQWxD?=
 =?utf-8?B?VmR4WlNhUjZBTERVWWdxQWNnK0FiK3NiSlNRVm90OUttNkxwQVRRNGxybWVW?=
 =?utf-8?B?NGFwSnZ5ZFlhTXV1N0R1ZTFSVnU1MEM5bDNweVNxNmhITlRCWWZYYnAwdUR5?=
 =?utf-8?B?R0V0aGRRZkRZUnRTbTgzY0lnaFlYZkFkNy9zTG5hcjZNTFYrVkNDTzFlZlpy?=
 =?utf-8?B?cnZWNkxkL3U0cE04ajdhZUp2VTFEYlhhMVhjM05uNGFhVWFyQ0VRTUZRaWtG?=
 =?utf-8?B?ZE1HVm16b0NYUktZZ1kraUZTRHdMc1k5VnpYT3QzQktRTk11NmFmUnRqWVMx?=
 =?utf-8?B?cW5ROG1PSk8vT2RERm5GcG4wWlJDRld1dEFoQUZZWnNabEZBcDRoZzN0L0wv?=
 =?utf-8?B?dDhrR3FaUU9aS3ozMnR6NGVkTzVQcThJRWYyZEM4a0NZMVhCVGo4SURqc0NE?=
 =?utf-8?B?cXd2ZW5hV2hUeFYvSmdXZWtqMnJFYlo4TWZwdWx0b1NuTlNTdVFKUm1QeDI3?=
 =?utf-8?B?a1NyMFJuayt4THdybWlvNUszLzhFd0prTXkvRVFheGE4eWEvMUsyV2UzRG1J?=
 =?utf-8?B?ZklwbDVqT3dpempJT1ZxSGRFd1ZDM0RFQmlNL1d4RG9NdmJtRm9SM1FQdjFX?=
 =?utf-8?B?cXRDVHR6N1J4MlFiUkYwd1UvdDI2SE5FaTFST2JoQ3hFVE10QllHYnhqc1ZF?=
 =?utf-8?B?UVhhT01jRllWcnV6QnpmeG1qUnZvY2l3WWxnVXcvSzRQT3NReWlIVk1HaHpp?=
 =?utf-8?B?UGFQY1E4TEZ5VlVDYmVDMzdYYm5FQTFiUVBUYkxEbHBDbDNMWmtSa2d6VGpI?=
 =?utf-8?B?WThsZkh4M0x3S0VBdjdWZGtpTEoyczhRZnNoQTZqdUdJYlh4d3RnTDZQVXZW?=
 =?utf-8?B?enI2NFBTQ0tDOHBldDdsUFVCby9WV3lTVDVuTmNHQVFkMUJzRVpEeDFuREth?=
 =?utf-8?B?cm83YUxIbkxFSGtGRCtLTUd1cDNaWllJM1lGS2ZIWjROaEVieW8rTExzYm1m?=
 =?utf-8?B?QW1TR2Yzb1NhUE9GSTF2MUVTOFVWUE5TV3REVDdWL1lxMWQ3K2V2QXFqMkQv?=
 =?utf-8?B?Z1psZS93UUIwakJ1QnJqWmNvaXo5WmdGSmNPMHJNV3pDQ2g0OGp4ZTBQM0lE?=
 =?utf-8?B?aEkyd0RMbGo5YmdITmcxVEVTaHp1dERhaWRKNmxueGlZRWJFdW5CSU1ZTG5E?=
 =?utf-8?B?QnNxak53OGFyeWs5UVJqdUlmdFZBSlF0TTdTTkQyNzh3TFlJUnFEbHBoR1lv?=
 =?utf-8?B?emYwUkc0RFRSZUlvckVhcS9MMS9tbHFjTUcyTmpjbEFFS3ZTcERiSzlUMk1I?=
 =?utf-8?B?OGYwZW50T1NIb1czenpjZXdnTHltdTU3Qkt3MUx5UGhpeE1yQzlSZlJPNVVJ?=
 =?utf-8?B?N1Q5SnZwQTBVdEV3bzAwbEFZbHVRZjMraWVDTmlJWjZRV2FZQ0tDaWhYRWJm?=
 =?utf-8?B?QnRxZW4vUk9tdEFETXgyRkt5T0dvOUk1eG1RSzNFdEhFeU1zSjZjaU1QZ3k3?=
 =?utf-8?Q?SG4bDXmYFHe/ATak8emrjvh/X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22fd9c29-4fbb-4549-6292-08dd759d17ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 06:26:12.5431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGUT7yu2KiQMFeXsm5BPAk3H/z3lw9D2jqk4fCU8C0wqhW+a+mvbZx/QVk002HYL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626
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



On 4/1/25 10:00, Varadarajan Narayanan wrote:
> Enable CONFIG_ENV_IS_IN_UFS to store environment variables in UFS.
> Set env variables partition name as 'ubootenv'.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   configs/qcs9100_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> index 10ff4d25398..d56f08f0ad0 100644
> --- a/configs/qcs9100_defconfig
> +++ b/configs/qcs9100_defconfig
> @@ -14,5 +14,9 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>   # Address where U-Boot will be loaded
>   CONFIG_TEXT_BASE=0xaf000000
>   CONFIG_REMAKE_ELF=y
> +CONFIG_ENV_IS_IN_UFS=y
> +CONFIG_SYS_UFS_ENV_PART="ubootenv"
>   
>   CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +# CONFIG_ENV_IS_DEFAULT is not set
> +# CONFIG_ENV_IS_NOWHERE is not set


That newline in the middle is weird.
You should start to use
make savedefconfig
cp defconfig configs/qcs9100_defconfig

to have it aligned with Kconfig layout.

M
