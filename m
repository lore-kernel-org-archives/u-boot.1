Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AC9C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E6968043C;
	Tue, 18 Feb 2025 08:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gjp+CF/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41993809A4; Tue, 18 Feb 2025 08:26:33 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59013800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:26:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OktJH2td/iMpRn5v2IW5gxM6IqK1bOT4Yxl+VKiVMRYUAgbHFYvtW90XjDEdSOzFeowTciV5qKqZUdeeHlxocvAjQIHsjh5Ylv+g5P4FdBHzbC+pDQ73U/2S/1+MLSnMmDgq5CqIBV+R0sxxWoigodKuTiQUUhmD5LTLTm1ti8Nq7zsDQkOQMLb4qbkNaJVXvmIgVMwlCXA/g6IfBypEUSqN5Lkuqr5iNFR26hAXX2eJdTI/XSO2wAajargG4wnXLghAqT11mgp4pGSjmN2bMzeVirNVj0Io52Z/GQYV8YqdDzw9Nd7/mJt2ZZVIcaNZVrV6K+NOWrkc4m5cIa2cNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qxxqSwRje0VdcCtanf5U2NX4Tumsly3NmdgbV9WIiY=;
 b=HQEST47N+FNZ/fSdB/9gaiHQLBt89samtFsq5KdnbLeAwKJDPVjM9z8s69g0DZmkx5T15dw7kUAI3cj9SWB3a8sXd1Nu1qavVNlhADgAWjp0tyxOTLrfwb6XmOWJ6um0Ih00MPYsLqDFS7gju9CrNeRkEVsga4DtsS7ARWCaP3Ck7akBx6mlt+2V+98ICrJJeT3VTWfefstidQB6hgac9W11t+uJZ18SbfoIJaDAMvWkbSnNMhrF/IA38tJRHLYXls3sXUWa/B27WkfWjxDxrQCsxEz6Zk61VdqT9uKKv2ZanLRL5rDVmlOa8zjPXo+WeDyUlNgq0NDdewF4VacNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qxxqSwRje0VdcCtanf5U2NX4Tumsly3NmdgbV9WIiY=;
 b=gjp+CF/MryXiiILqF7GyAMxwYBq3zsrGLLU+MtE6/xyBg3Z0lNv7cRTq7xxbIIlf/AC1grZKTKAbefd4FRMMI3cWjLYtYytLCF2YIqmx+7pwW7UtWu4OQ5ubK3ZWuar639AhQhdZ+O3PsTbtygke1EOZHch+GnlMiJxI2aEB7s0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 07:26:27 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 07:26:27 +0000
Message-ID: <45c759d8-472c-4825-84ee-954fbd492a57@amd.com>
Date: Tue, 18 Feb 2025 08:26:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
To: dinesh.maniyam@intel.com, u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>, Tingting Meng
 <tingting.meng@intel.com>, Tien Fong <tien.fong.chee@intel.com>,
 Kok Kiang <kok.kiang.hea@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-2-dinesh.maniyam@intel.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250218025705.50051-2-dinesh.maniyam@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: e9450bd3-f8f1-4100-011c-08dd4fed8e74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWdxaHNTa0VxOFNiYlBkNDJjK0s1VTNMODlJM2h4NDJtY3Q2eVVhTzJGa3Nv?=
 =?utf-8?B?eXJXUGwzQ0p3dGk3bVZwSTdzWkpOS3hDUWRHcVppRlNHQ1M0NVdoUWdjTVdR?=
 =?utf-8?B?ZjNjSDV3bEFESWJ0ay9nWlM3M2VWUE1ObmQ5VUZ5bFJoMmxoQ3hSTnFhM2JM?=
 =?utf-8?B?OVQ1ZlZFc1l2Z1ROUENRTFhybm9WUjExTldjZkZPRVMySlhtQzNuMTQwR2JH?=
 =?utf-8?B?ZUx5SlVpQzFOYVhQQjYvT0YrTklPbjM4UmJzT1h0QmdLS2pKMDdBY2tNOW1I?=
 =?utf-8?B?eTYwMExMMWswN2lTMjl3NVV1cytsU2NZY1ZaQzJwd2tjbXg0UU5aZXJqMERC?=
 =?utf-8?B?ZWVOenRjY2RoV0JYcFE4ZjBaKzliVyt6TlFyalBNSFVFWnBwbWpLTWVKenFz?=
 =?utf-8?B?TkdLc281ZHdUalI0QWpNbFVnYXh5Q2xHYWJPeGJyL3ZLSWdram9idEp5bnVJ?=
 =?utf-8?B?M25qKzNZRzF1UStWNlltVHZ4WXd3eXRNdzlFcFF1MGdnajZrekptMHlwbmow?=
 =?utf-8?B?cXlXVThscVpkWHVMYmdGRzlHblh6VHprOFBMSHhKblJTdTFiNzNwaHJrLy8w?=
 =?utf-8?B?TzNZc3ExVVZDMjZFajBXaGRBakNEWlNWMWJqSnpocUJsOGpNejY4QituRnJi?=
 =?utf-8?B?MEZUWHdBbTJPVmdvZ0hDUkJkcE53RHVGRENnenlQaG1TTG9sNytwb2FUQksv?=
 =?utf-8?B?TExZRlFxZG5keEdYZU1kOGVOY1hhYnkrRU1SVXNJRlptdjk3UzBYRlQyQ0VK?=
 =?utf-8?B?SlpkTHNlWXFIUWMrRGJYclRVVVRFK1FyWVA5R0ZxR2hjV3pGVW43SlQzTEVm?=
 =?utf-8?B?OVhOTUJxYTdCbUdDenJVc1NNRk81MWJ4WDFnRW5BTEI3VHhtVENTZGJ0RjEx?=
 =?utf-8?B?VEJhSkUwOTZqMXhoRU1nTWpZOWttbWR4bU1mM3hhR0hQcEZoS3Q2ZkwrTDF6?=
 =?utf-8?B?MXpkRmdMSlRXRDVmZnp4cUlqM1NMQUMrZHkzeHVpZGtPbEQyc2lVb1pPVnhQ?=
 =?utf-8?B?TnZDYWNneittM1JsZzVVeFZSTmtiN3RHbE9rdDMra0I2cTlvSDNkZFBGZG9L?=
 =?utf-8?B?STBhSTZhWkFaQkhuTVdGRGg3bjZNTmlKRzRUdUdIdDVlMkZVN2RmOXplb2gw?=
 =?utf-8?B?NG9RRE5abThFRG1XMEMwcDU2REFVaUNrYmtBakpyM0EzSEFaMGZzaVpBT3U5?=
 =?utf-8?B?WU5qdFZ3TGRGcXR4OEJmV1hTS2NGcjhoQjluV3hRb2k4QitaRy9Gd1B6ODk0?=
 =?utf-8?B?THZibndjY3hvUndLQkVXNzlQNEhoYWozSTdHcm1nYklNMExaTzdmaWcreEMw?=
 =?utf-8?B?ODhJTFRCQStJVmV0bnlrMDJTQ0huaHo5c3A1QnJGSjEvOENrQ0tnVkJmclZt?=
 =?utf-8?B?OTI3T1liZ0hZZk00bHVndkxRNzc1cmJkdG5RSnpzYUptbnFMVlNoR0s5UXAv?=
 =?utf-8?B?RFlzamM4ZGpUZGNpbzFqcVQ1ZzBPVnVYTXNPTi9MQnlWQ0JQQXY3aWlBTFRX?=
 =?utf-8?B?Y0s0VHlxVUhNZTkwcWxIUC9qWFdySW8xbEFwd25iK1k3dU03N1NYYXNJMHdu?=
 =?utf-8?B?UHgzUEdTRHpjUmVpSE1vWWVtZkV6d25oYzMyQnNNbEMzajc0dU9FYjZQTlBx?=
 =?utf-8?B?QU1YdUoxaUxkVUFqKzF2bnJWcGM1UEltWGVPWkhFYTFpMU0rTU5NY2NlMjU1?=
 =?utf-8?B?QXVOYXNCNDZ6TW9MVnZvLzdFaEJ6VnhNc1BvVnhRTktiN0NSWHpGbExYZWNH?=
 =?utf-8?B?alRseHpQTkk3TXpmVkU2RDdBRU83Ni9FWlB1dlg4ejZFd0hhdzNvT05zdnBE?=
 =?utf-8?B?cDJwcHIzVW1qazV3SVpwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnM5VURzeGw1ZExFNUFna3ZNVzI1NUhHVklMVUs3bDQyaDRsQlY1SWxoSTN6?=
 =?utf-8?B?UWxDTmYwaHYzWUg5STVGSXcxSmkwc2F0NkdtUlJ2djNESzd3SDNZeHhBdUxS?=
 =?utf-8?B?QXlKd2JzclU2VWIyZmkwT1M0UlA4ZGJQRmE0OXJRazJ5eFM4bGxkQlZUZ2po?=
 =?utf-8?B?ZVkxVGhXejF4U2VNSDRkNXRIcXJWY3JDL2ExNVR5RlZaVDNCbnBjZXNUMWlk?=
 =?utf-8?B?ME00Y05DdFozNGwzTDZ2cnRFTEJTK0Faai9HOFJ2YW43SzlKZjFTbXl2N2Z6?=
 =?utf-8?B?WDhZQ3R5c2dxTzFmL21GZUQzV2ZhK2o1elZHRitoUVFEbjNqZmh2LzVxQ24x?=
 =?utf-8?B?eVRhWkZsNnVVZVdpMmxsbURoam40UTZIYWVPQ0RxakVtZnRZUEZ2R1FSSE95?=
 =?utf-8?B?TEkxT3BwZlp1KzBBRGduWVhBamxtL092MWxtVHAyc21ad0RRNDNPNXZQcldC?=
 =?utf-8?B?dWJldTNjL2dTLzZWOHlybDJneG8wWXNrOS8vMWJJQ1hsYmRUZm5Uc3VjbmZW?=
 =?utf-8?B?dVNjTGFoVmdIUHh6K1MwQXRucmlmeGZObitwVVRWTFR5UVRMUGNIQkVtWTZz?=
 =?utf-8?B?V1IrMkpTcm1lZlBHQ253R0duVUpLOXNEK01xWC9LczBxNzAxKzlFak9lMmtD?=
 =?utf-8?B?dkFKbllYZzZCYlBOZUhsM3FEUEVQQlJsbmx0am5RYlZDSGthQWlIcVR4ency?=
 =?utf-8?B?OHFGM1BXWisyVEZjcXBFL0xoQmpZZDd1R2F3SWFDQVRLQkFHbGplTUF2WGZ1?=
 =?utf-8?B?MUppcG92NXlSa0NlUXByQ1RicjQ3VkRHeTEvTk1yVEJaanJLQmdVc3pXVzI0?=
 =?utf-8?B?NHp1d0pJR21sdjNZdDdaSFdaTWNmNjlUOTNxSDROVXhsbjliNHFrcXdab0F4?=
 =?utf-8?B?OExYb0hZY09UWDVtU3ovdUlmQ3hGMkhHK3VyeEVlNzRDdHV3aVNPckRZaDBa?=
 =?utf-8?B?L3lQNTdMU0lib3E4S2lLSUdVK3dLMFhPU25HVWFGNFNRK2dNMXIyLzJSVGpl?=
 =?utf-8?B?R0gyV1hWTkVxQWMzcW42MCtsczB3Q0pISTFMMVNxRWZVcW9tL1F6dWdiaStZ?=
 =?utf-8?B?T0F1bytFZklPUGw0Q1FIblZaY2R4Vk55L3JVVHlPWFpxV2xUK1BIdXBVU0dD?=
 =?utf-8?B?b1dBUFppYklIRDNVdDBvR1ZXd0pBUGYybUVNaHA4akFrMXZ6eXJ6c3V6dlF4?=
 =?utf-8?B?VDYxTGZScVAyVE1xNXp6eEp6Q2JXYytrMVRmQURFUjFSeDZFU3EwZlBucjg0?=
 =?utf-8?B?RVp4Uy95V2VUL0FpaUZjaDN4eWpBcWFnazJnMWRxYlNiMGFxTDIrRG14dCsz?=
 =?utf-8?B?UWh1dUtaUHVnZ0JtY1lTSTVXNWdqdSs1NSs5dDlIUEVab29Rb3dDMVdHdVJP?=
 =?utf-8?B?MnIrRk9Jc2dYOU1obVNYRTN6eTBhM3ZEUFZHOTJDemR1d1FmaE95WEYreTlq?=
 =?utf-8?B?MVdKWFJiYjZuWS9mR2pwWE9aM1FFRHlBcjRsR3FoaXhzY0F5VGduYXNXVVdK?=
 =?utf-8?B?N0kwQVRFdGhZcmdaK2JZZ1BRRjUwYlBuV2RzeVZzVHlHc0ljT255aTZzQjg5?=
 =?utf-8?B?Um90UDJFRDhhRFhQa1hXRWVlMlpxZmowTlNRbEtFM1diYWtuTkUvZHZ6UnFC?=
 =?utf-8?B?RVNXNE5LN05CUWhtZnhOK0hqYWFRK2o5WEk4Ym5yUjY1bVdrOUdEOHdOTlRN?=
 =?utf-8?B?R2tNNGd3YUF4d3E2UEI4dk9tbGFqckp5c1p2Y2ZvcEczZktLTjI4L2hnMU51?=
 =?utf-8?B?UTNrWHpXc2lYTURNMVR1eEtvMjRnY3o4Zm8zNDJEUzVCT2prWkwzb011ZWU1?=
 =?utf-8?B?aGZVMmdFS3Izek5QNHJWbDZqNERhTWVoWThiTmJHWmZCTFpHMzZ6VmxRSU52?=
 =?utf-8?B?VzM5NXBuN3ErVXl0N2ZUbU55SmlLWEFyRUFpV1FuNldTbjM1REdsT3pQU2Jp?=
 =?utf-8?B?Ui81WWErbitKdHpTYndscXN0NzlmOFA0M2c5RTNyMytRVEEyTEVmbDFNSURi?=
 =?utf-8?B?OGZpdWZ0WDZuUWdjdEZPWEZJODN0OXJYUTg1TFB5VjR0MEVxSmprd3p5WHRh?=
 =?utf-8?B?dUR1YW9ydDdJemplelRuRW5tQ0dhdkVwUkpGelFsRjlLMEduM2hYQ2VRM29s?=
 =?utf-8?Q?iK+SV6mCGTLAu5YUBCsEYRrZM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9450bd3-f8f1-4100-011c-08dd4fed8e74
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 07:26:27.3549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51G6uLYO24JUp61S37amNceSNdkHWNCUOyiU2M6bQE/T3KMUDOE+RaBtRn8qUpUs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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



On 2/18/25 03:56, dinesh.maniyam@intel.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> 
> Add a YAML device tree binding schema for the Cadence I3C controller,
> defining required and optional properties for proper integration
> and validation with dt-schema.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>   .../i3c/cdns,i3c-master.yaml                  |  51 +++++
>   doc/device-tree-bindings/i3c/i3c.yaml         | 186 ++++++++++++++++++
>   2 files changed, 237 insertions(+)
>   create mode 100644 doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
>   create mode 100644 doc/device-tree-bindings/i3c/i3c.yaml
> 
> diff --git a/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> new file mode 100644
> index 0000000000..0eda16482e
> --- /dev/null
> +++ b/doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/cdns,i3c-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cadence I3C master block
> +
> +maintainers:
> +  - Dinesh Maniyam <dinesh.maniyam@intel.com>
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +properties:
> +  compatible:
> +    const: snps,dw-i3c-master-1.00a


Filename is not fitting with compatible string used here.
Anyway binding is already in the linux kernel that's why you don't need to put 
it here.
Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml

M
