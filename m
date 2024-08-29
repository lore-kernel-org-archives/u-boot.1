Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150DAC7EE2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 06:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4929188A7F;
	Thu, 29 Aug 2024 08:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pJyRXgpr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 132B688B0B; Thu, 29 Aug 2024 08:53:37 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24E28891E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbpeuIpOaUfGtIJF18IeRnfhEqzVbbm5nWbfg/RLTg2n56DrNZV12GBRWD/MswTeYxGT1ALsNTrqZfHHZA+cQsPhocwqpfYYfUZcTBqcZGgCv4Nv08HyCs+enlPUBctez/8lytOXpnemWUE9hQk5DjCRJWewoy2PseeTqchualo/JviNl5p6leYJg7SYOoE8Jevp00h/NBYeDwng2SnnbPNQtCDvHH4lAZA/mlryF05P7ptv6yYmh0jfmr2WZiFp8jRR2saWrlK1LTC8qL64/ZHf8DRjQwTouXjVKJc5TQ3ZK6ApG6rWhgFCR5ttln7t3SMyqBSwjdxV6h5ZA6a3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKy8N3F44LoHmlBDKTRIRt0d1CY3xrpUvMRiv4N7SQc=;
 b=ykStoYJ84i/2lp3C2sP+eAh1oJBqoeDAOpVb6O+PfcqqkAvTztP4m6tfppk0S8XQLqQVW4mRkQmaShrO9vyTt4IWS9wIDGo7uoxPqEOOBUubZ4xGXl5i2mkW4zPmTTDNMR3W05cOIWOW9r2nYkA8jTrknqFD1wr1k+q5kyuRh7ctzbA/6KYTcGv0dIo+qqXc8gC8vDtX8CR40lWyCvjOnWp3POuAUeEPVVVU+ljFBFsteY9w68pPyBYhI875TSwhA+CcCp4UTug0xVR3MjKlkXv5GO1Qzk+EOaPkcrfZf0+PY5eBmXl9lIfsF8YyVzvgM+KOIwOPiuI/f7WQ9Nj1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKy8N3F44LoHmlBDKTRIRt0d1CY3xrpUvMRiv4N7SQc=;
 b=pJyRXgpru50MHNv9mMcBhzqWird+N/r5bKWZUAVhPHrUa0ppqALlXAAm6O4ydPOMLj2nYi4S4MMeapMqig3JxFpfp/AAmwliuc/31GMcF0o1NCblzSEnUVnOW+Gv6HMd8Jl3lp+fhqmpc/3vQeV7d7O0pcpXlGf5wuBvYj16oGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 by IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 06:53:31 +0000
Received: from SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::f1f4:ef3a:f565:c5a5]) by SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::f1f4:ef3a:f565:c5a5%6]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 06:53:31 +0000
Message-ID: <7f8594fb-3cf9-43de-b9a7-d919d68a961a@amd.com>
Date: Thu, 29 Aug 2024 12:23:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py/tests/test_bootstage.py: Combine stash/unstash
 tests
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
References: <20240828225610.3081635-1-trini@konsulko.com>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20240828225610.3081635-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2f) To SA0PR12MB4461.namprd12.prod.outlook.com
 (2603:10b6:806:9c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: cb84d801-45c7-437d-99b3-08dcc7f74b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MC9KMTRwMnN2dXVaZTN5Mll0c3dHZTZFakxQV2g5cmFNaVVjVnZDbVEyMHBD?=
 =?utf-8?B?RkpyVUdOY3ZxZWJuNDRTeTgxRlh3eGg1S1ozUWdmSklRRjNxTHhFYzEvanBK?=
 =?utf-8?B?N25SRmVkU281UWUrK08ycU5RRXFaejByRWkrYnhUSjdBaXB2SldRVmwwNnZ4?=
 =?utf-8?B?bDN4bXRDLytQTWdRT3FVV3VRTmJmQWlGM3NnL3AzN3R2TURSQS84TkhmeDR3?=
 =?utf-8?B?b0tYYnlqOERCenZjY2dLc054aG93V0JHU0V4eUl6eGtLR1JlcENaRGZUWms4?=
 =?utf-8?B?NDR3aE5KM3RQeFROTERXMi9lMWFqY2VVMmtnWkJwKzg3dVFFcDQwS2JWSFVi?=
 =?utf-8?B?VnRmUWFySWVmRENtcDlHWk5adG16bzlKZGdpZzBrUThuZE5jeThxcStXSFgz?=
 =?utf-8?B?Z3FtMFAvNnNmcWdXNlRkWDhaYll6YTZqcHBnSFI4RndrTUh3WmIrUXR5NVFQ?=
 =?utf-8?B?R3JxMHJ1ZDBzRkFlaEg3cDRTVjdNRWNMWnZqejdZWlV5STZWaWcxWVBWUUk2?=
 =?utf-8?B?TmNDNkVyckU2MXY3cklIaHZsbUI2ZjdqNGxwYzNBZVZVRzJJdU9xVklBWTVk?=
 =?utf-8?B?QWtGdy9TK0tqQjdvSGtLN0JJbVNzNjI3VkNmTUcyWWRnK3ZaWmpuVGpSR3lK?=
 =?utf-8?B?SGhWZGlyMmJ3M3I0aGgxYUV3QUJzNmFPRjhFcFlMWXB1V3luMDZCN1lXdDVu?=
 =?utf-8?B?aCtPMjZNbDFUbjZib1AxUm5ka040d3N4MDVwWHFmSHk2YktLb2hLaHZmZ3lO?=
 =?utf-8?B?WFRDeFhsR0UrSkFtSXA4d2c3YTN4SjJtMFZhRTBwTFpJM3Q1dTducCtJUlRV?=
 =?utf-8?B?MjI3MnBuY0V0c0NyWVlzMldXV0NBc1BCL1hrL2pFUS9HQ0xRY2d5eFN3dk9E?=
 =?utf-8?B?S1BXNHVSV2NUS296MUNvdmdFSE9LYzRFd2FnV0l0Z1JQVFEyUE1ZblJEZlFw?=
 =?utf-8?B?TGducjJDZjBpcktLL2I1WmxTdUZkYnNvN3FySCtYUUtxUVB5ejBIeEppc2dL?=
 =?utf-8?B?eXhRL2Q1Zm5CMXRiWlFGaENtNnZ1Wmx3L0hkV01VS0VmcDFQNTZlWndTVXhz?=
 =?utf-8?B?cWwyV2dDWnJSUjR3S0Qvam11TCs4cFNJb1B4NTROb1dNV3dqNU90N3hORDRw?=
 =?utf-8?B?VFJKdEJHNkdNR28zSkpiekZmZ3JTMUNjTURjWm13eWZGeFBSbTQ4SlE2ZnpZ?=
 =?utf-8?B?bEthNlIzUWdNUG5YYllHZS9QZDVTMjBLZlVoUmtOTWo1a0N2K1ZDQndFT0Nz?=
 =?utf-8?B?R2NtSlRwWFZQdndxS0pKSVlXYVI3NkNNVXVSdFJqZ2t5YUZFK2ZUem9JbVBK?=
 =?utf-8?B?YzRyRzl4ZElhR1BsaGVGV0NIL2hlWFhlRWxzNnR4OUN3MmJrZmZnTjJjQVAy?=
 =?utf-8?B?cjF0b0NRMENUMVhvK1dJcEx2UWJrWjEycjBiUzJ5Y1AwK3FwSDRWWW8rSkty?=
 =?utf-8?B?NVhnazR1V3p3em9yMmNxWmk2Q2JDK3lyRGFaTXZuRjVFNzVXMGRKdnZ4UzFj?=
 =?utf-8?B?V1RiMGl0b0EyelFvWW1rSWxPbWg4QlBzdDdDT2FjTVN0VzB5L0pTZ2ZHSGhU?=
 =?utf-8?B?M3R0OUxEN0FpNUZiUzJDUU8waVNsZEFMc2ZPSk9FUHBTek9QdUptMzV6V08x?=
 =?utf-8?B?RjRPYWY2NFBnd1NOMUNkajk0WEdoa1ZLTFFvWXhqdytrYWJnajkrNnpDWHFS?=
 =?utf-8?B?RDhLSHo2ZElJd2ZTVjl3bWI1Z3diRG41ZmlWZkJibURHS2U2Y1dKYklKMmd2?=
 =?utf-8?B?UlhicW84L3VzLzI1S3B2cit5c2RPcDZmR3BuVUNLaEZVVXhuUUJtWVliNlBK?=
 =?utf-8?B?ZktNa2Q3bkR4V2Y4QWhjQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFVqUFVFTzNuWnAxMndFRE9ZZEJRbmE4UGxweEFXYUZ3YlJYeWgrT000RHZF?=
 =?utf-8?B?MW1MRHdLblE0N2ZBWnhTQmIzbEZLR3NyRENXb1M4ZGlqcW9tUlFPQnI5SWZU?=
 =?utf-8?B?ai9zR0VDSVIwYzEyNlhEZ0dra2JqS0lSWjJ0SHFRQkNCY1hmY29VU0I2dXFG?=
 =?utf-8?B?T3NFMGtBMUpaWkZZZmorQnhNM0hZT05PeWR1R2NMY1lCdU1FZWZSdUd0UmVs?=
 =?utf-8?B?WFlNTDFOZUNGNlJFS0dkdzZ1d1JacXNkSG11ajdUMHB6M2EvK0dodEZkZ2Nv?=
 =?utf-8?B?b0pBSmNQeHQ1YnFvQkwwYkxUb1AzcGNxeW1kS21oQ2lLbmtMTWxpNHFVeGQ3?=
 =?utf-8?B?Z0EwbVlRV0dLSWRLcE1kV2FHY3VFMWFaZWhPOW1HTHVWN09yVWd1L0VwNkVD?=
 =?utf-8?B?UkRVaVQzeXVKeDRrWmpQdXkvRDJ6Y2pvSERGM3dZcERuN0VybUdTdENyY2lo?=
 =?utf-8?B?Z2xjK1VzZ01TOU9SWFBpNitjcnp3SmJSTTNvbzh0VkV2U29weE5SNHNRUEd0?=
 =?utf-8?B?T2RwZHJzb3ZWVFBDR3crMmprVWtKQkloWks5ejErbjBMWmVlY25oQ1FHbm5F?=
 =?utf-8?B?d0tTS0hQWkVxSUJQd1hLYlp4VnlHdG1EMkRpWS9uNUtWSVhOVUZtQW9qclBN?=
 =?utf-8?B?VUlSdkdrS1FzcUdGVDNJZEZ3YkpMMFgzS0xSM3lTdXBZZDI5L0s1RC9PbWN0?=
 =?utf-8?B?bXZoaDUxYmp4bktZWklFSXF5N2l3WU96ZldNODdJWFBNZjMrRXZPRUxyTm5i?=
 =?utf-8?B?Wm9IajJkOENEblhDNE1wMlVDN3k1TFoxOERLSDRSanhNR0xSandya2I3QkdF?=
 =?utf-8?B?TFJac2N2aEFRYnBFTmxRZjlXRXIyR29MS3FaakxtZnZLUWdETHQ4elJVMy8w?=
 =?utf-8?B?YkJtODFaVUpDR3k2MGNyTDNibkpVRFJqWU5Dbzc2QzNmWnNCMFp5N01kc0d5?=
 =?utf-8?B?cG5YMDNyem82TVc5N1pEcnRVTENpZ0ZubzJxYkk5QnBtWGlmSlJQa2JtVzJG?=
 =?utf-8?B?N0hHb2h2Rmk5TG9CQUQvU1lWbU8yb1Y5M01Sa3lGeUZVL0N1MUFVVEpyaE9k?=
 =?utf-8?B?MWNWeGNuMnQwNjVCN3hxUjVxVzZiK0tJakxPS256SG1BY2RJckwrelNTUHQ2?=
 =?utf-8?B?RnkyZ3BxazlaUXlndEV3YUpCM2U3WE1oM1VNbktudGdRMWw4RjYycWYxd1M1?=
 =?utf-8?B?TW9HV21oaHNtR2k3M2o3cUVMVm9WcWVhNm5GaXFJWG9GdTdCdVNFbzJuNDJk?=
 =?utf-8?B?VS9FQXVoNkV1YmdUeTdQZm95cW50VEZ4dGNvSWxjajdTalgzMjhsZW9malk0?=
 =?utf-8?B?TnEzdjV2WWxnZWUzZFl5TndmMCt5TWlMZlVXUmJGaDJzc3p1YjJTajB2YmlQ?=
 =?utf-8?B?SjVDWWpIM2VoWnlMb2pJRFpUVlE2ZTdycWVPV0FLY3JuYTNIczNQTmR0VjlH?=
 =?utf-8?B?L1lJa1ZkN3lER2xCV3M4TU9JbEUwbzNKeWI0Rk9QY0tmTll2OTI1elNDQ0Jz?=
 =?utf-8?B?WFVNVDdJaC83RHkrdkY5S3NZNXp2SXZWZUM4Mkx0RjNKSFhMbDdQWGNyTWEr?=
 =?utf-8?B?YUxUc2l3ZlMxNTNJYVdXMElHK0k2MHptUTZ3VU5PZWVnbVorRlNqSVZxMllF?=
 =?utf-8?B?ZjEzZUhrQWIrdEl3YWNWczhrTmVtVktWa2x1RkNvTFlueUpZeGplMXB4VXRy?=
 =?utf-8?B?aXlqUVJNT0JXRmxHQUNRWlNvUzJwMjk2aThRc0VoazY2UGxoeVcxMXV0WlJ2?=
 =?utf-8?B?ZUQ0dmF4ZXhBWFNwUHF6ZDkyOWhJUjdFMjNwSDk2d2ZHalZ5TWM0eHM2Z2Fl?=
 =?utf-8?B?a0RlUlQ0ZlZXQ1dkK3ltMEE4cnliWEpoL0haR2RWMzFhNUZrVjBTRzFhNmFO?=
 =?utf-8?B?MU5tYVNjUmJzWDR4SzN5ZEFTZnV4VjNkdy9seDc2anNCQnBFczdDSkdsbHR5?=
 =?utf-8?B?RVM2c2xmdFh4aERrK3NMd0I3N04rYWUvSmNXenNISG1WSGg1Q3NwSGtKWnVT?=
 =?utf-8?B?eWVFODhPeXYvOThSYnFoVS9aYVFmakxoc0FySmUxZFUrRXhqZGhadksvWmUy?=
 =?utf-8?B?cHduRzlnVzlMUmcwZTdIeERRZFhTamY4QWRQM1BoWjZoaVlnTEN3SUpRaHY1?=
 =?utf-8?Q?DjUY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb84d801-45c7-437d-99b3-08dcc7f74b33
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 06:53:31.5723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CeGUhRTH+yk84kP0xMzx5jdeUlwajDFEvc8ck4VnDG48ojtBERIQOr6k/Z/337+v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164
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



On 29/08/24 4:26 am, Tom Rini wrote:
> When running the bootstage tests currently we get a warning like:
> tests/test_bootstage.py::test_bootstage_stash
> ...PytestReturnNotNoneWarning: Expected None, but tests/test_bootstage.py::test_bootstage_stash returned (37748736, 4096), which will be an error in a future version of pytest.  Did you mean to use `assert` in stead of `return`?
> 
> This is because the unstash test will run the stash test and fetch the
> addr / size from that. Rework the test to be stash and unstash and then
> run the unstash command at the end of the current stash test.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> It's possible we could solve this instead by getting addr / size again
> from our environment file, and then also noting that order-wise the
> unstash test follows the stash test. However, this felt more clean to
> me.

Agree with this approach.

Reviewed-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar
