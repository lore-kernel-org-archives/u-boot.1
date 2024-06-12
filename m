Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C31C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 15:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BAB883CF;
	Wed, 12 Jun 2024 17:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5qA0ls3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6591A8839D; Wed, 12 Jun 2024 17:32:26 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C32883CF
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 17:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnvhyEnw4I032ZUzS9JMBZ3hzIDdyioVOBtKZIIXXrWYCkQqw1OYhRB0ctuifgSLKrkWmOmVJk5vTbeX06K5VCWUhv1M+0oybBu61Z75sTJ81SgYcVvGBrTX++Vp+34H4FtLiNOZdx0cv/Sg3uQ7tEMgeD9C3nvRyxhfygXC0cqzpQsIZkmn55l78BEiViZYgx5qu0Lp8iutxnAhs/nKSZhsWH1UYeaORg/TQPb1MgiZLfD5DC8cvo7NhXIzIdHXioSmze1h7pctUN4tKOx4EvTwn2jAJu5k0R7puaBjsvQ+7qbgDthLb0TNPcDk1o4Fti6whUHXAkhXwqLUfF4AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMRDmMJ8CqibAO9764OHNxHiXDwk1PtuWqnVtBJW394=;
 b=PhDzWQ/fGPlrKyig3lHACEcknpbFsbVxbvdj/Thquymzq6WAnOezqUpcyPYcjl2boaXdgk1SUckol/fqLoUoVoZbKw+WvJBxEcVlIi+emRm3HsvVATQQHXJzQaWtEHGJLsbo1evQ/xqaw2tSLrY5vk3+vvTnm4wn/B2MHbvcnAAlkwQw4oULoHIpq+4aqC9ZQx72hVNVlLrm08DODLvxL/MmUAnkPWJ74e+Y4sEyHqWFQw8qr0U2gZ55j1hbVfw81R2TGdJMXAX4N8e0pN94rLdwVSGNQPok3El6Zip2Dz60RpqgjplAaD9Yh7dzCA/ZryyIcu7BpF9zMDfqlz7KLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMRDmMJ8CqibAO9764OHNxHiXDwk1PtuWqnVtBJW394=;
 b=5qA0ls3rsu0Af0KofIbSni6pbw2h67SRC5vOnnRpgqCEyaOj36kCM2NuOuHwbObDpsSOAz4PD2A/zAKRtC8yNOkGk+48X7oiWWvkNRQc2B9776r11cXmVXGxKt+4+T9s1RnmYy922uxmSmnfxhc0qa0w2vquE8JxdspJlk5fGq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 15:32:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 15:32:19 +0000
Message-ID: <b0954805-8e3c-4594-956c-9e011f858522@amd.com>
Date: Wed, 12 Jun 2024 17:32:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
To: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>,
 "vassilisamir@gmail.com" <vassilisamir@gmail.com>,
 "monstr@monstr.eu" <monstr@monstr.eu>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "santoshsagar.algapally@amd.com" <santoshsagar.algapally@amd.com>,
 "LPolak@arri.de" <LPolak@arri.de>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>,
 "sr@denx.de" <sr@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20240603164738.437834-1-vassilisamir@gmail.com>
 <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
 <482398653f2b41292c056eb67077ca29f0b9a7ae.camel@cern.ch>
 <48dc217d-f5ca-4ba0-b174-18b4ba6ac0d8@monstr.eu>
 <a1567b35ac623cfcbcc28ba12f43813f6e3d8887.camel@cern.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <a1567b35ac623cfcbcc28ba12f43813f6e3d8887.camel@cern.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0109.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 36215cc7-9e20-4921-2889-08dc8af4d88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|366010|376008|1800799018;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzhoS3NBbFNneU9hdWVkMUNoYXFYcE1TU0xYMjl6dzUvSWZSM0lMSHNSOVhW?=
 =?utf-8?B?WEYyZUlrOWV1MGRKVncydDBHQnhWQVA4REUvZG1pcFIvZGJvNVE5SWdtYVk5?=
 =?utf-8?B?eVRxb3h1UzBVWW5STjVzdDZyb1pNKzZsZXp6elVzNWFrTExmQ3BmNm9ZemxC?=
 =?utf-8?B?aUhQZ1ZCbEVMc2t0Zms2UldJQ2dxVjJDa1QzSkpwYTJscGZxM2lwYlNCSmIv?=
 =?utf-8?B?K3poUHJVL1pEQ2JRZUx2ZDMyTWcrU3RBWEFiTlcvdEJVZHYxdldDeDN1RHIx?=
 =?utf-8?B?SDFBTjFkTzNxMmhqWGdobEdjM1hXTmg3Ty9wYkE1UEk2ZlpQZ0l1RjBPMHRE?=
 =?utf-8?B?TStHSHZaQysrZ3B6cVF5Q2JsTlNhRTVOOFhmcFZteFhWSUcxZHc5L2lNNEU4?=
 =?utf-8?B?NjIrSS9McHFPZlJTWlpOV0pyNnlFU1UvQzF3dVk5WFZ6Q1VuRHpvWm9Cd0Zo?=
 =?utf-8?B?a2pXTG10U3dTY3UxK090VitYSnlXSVM5dlM4NjIrdnhCbjJ0NERPdUxCZDdj?=
 =?utf-8?B?eitwYjIxSWNKOUU3OXZTN254RVpqYVl6Nk5tRzdNakEwWnkya1NaOXF0Q0E5?=
 =?utf-8?B?ZmcxLzduMS9hM1Y3TnNKSEdZdjBXS01tYWFKYVJzNU5MWU1FbmxsYWpjZDhY?=
 =?utf-8?B?eUU5b3ZWbW1OY0lvUjhQdVpoNFNmVi82WnhtUUV2UWs4MzBwQlFURGh2emNL?=
 =?utf-8?B?ZVdMQzBlZm54Z2dUbFRDMEN0WmswQ01GSEZQZWEzcVJ4QVhZZHF2a1RhczMv?=
 =?utf-8?B?NDhDUDFmWHVjbUtXV1EwcytLZmJzNlRUT3Q0ZkxtOWNMNkpVbmxrT2RvUW9W?=
 =?utf-8?B?OG16NUwzbFY4MGZFVWpIaGR2SDRQZ1BTRHBnQ0Jram9za05yQnRZQmcwL05V?=
 =?utf-8?B?YlZERGd2azBwOG5aRER1Qmd5Z3ZOKzRFNUtHM1crSU1wT0h4RzZGSEVtOTJ3?=
 =?utf-8?B?czN4TEQvbHZ5Q2lLRFp1RFNJbVQ2M09McGlBNis1RFQ2Y0dBeS90THJUYzJS?=
 =?utf-8?B?eSsway9obFlyTTRaTmhOb0tQU0U2M2IybCtZN3QrckJka3JQZ0xNQU5xOWMw?=
 =?utf-8?B?Wlg1eUZkbDd1SzZLbFhBVzQrSWFwajZyZ1RBQXBPT3N0dlBPWUhOZjREcFd0?=
 =?utf-8?B?aXpIaHo2RWR3eW1KNTlRZllCV0NSNHRjSFVsNkRRVDNYY1lGU09ZQ3VVUVFU?=
 =?utf-8?B?cEFJN09QUmpZN0dTTFlHcmZ3dGdYYWFneStJdFk1dlgrY04vUldSVTdtRVd1?=
 =?utf-8?B?RG5DT2l5ekN5cytHcEoxeERadi82NjJiNlA4UjM0QjgwZWJRTUNkV3dyWkIw?=
 =?utf-8?B?VzZCNkN3aFA5Q2p6d0V4UUVGdEl0VVA5VHJaNkNyNTllUUxwMzlobWpEdmpk?=
 =?utf-8?B?VEdzaEpJejNyYk9mSFQ0WnNyY1NIcUdUNkRZSUppUkd5eVM0VDBBTjhWRlRE?=
 =?utf-8?B?WXFjOHlxQ1JoR28wZ2VVSjZqaGhVU1RoT1RreFBHRHpWS1lFMUc0THRpTmRO?=
 =?utf-8?B?UHJ4ZFJ6MC9hWFlmV3N2aWdoQUhhSnJ2YkxUODI4UTZoN0pmK2RxcEhNaDM5?=
 =?utf-8?B?RkJ4RVRBYVF0S00vTmdaNi83dzd4cDQwQXNRTnA1bm5CaGIzNFU5eFhCM0JK?=
 =?utf-8?B?WE5wbmdKUVpmdmVTR0Q2TG1ZbHg2UDQ3NlROS0kxclc2UnRETzg3eFRHanpk?=
 =?utf-8?B?TmpCOEN1Y0lVM0tOcENtc2E1VlJXa1k2T1p1NU1EbUpDazR6WG1wcVJpRzNS?=
 =?utf-8?Q?gyW3bKc1yiQYTwpV+wujYIeWqDeldFyn6JU9EsX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(366010)(376008)(1800799018); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZHNXhtejByU3d2dFRodUQ4dUFVWG1ESnpsa0xYMkoyd2JiMTc3b2d2Vm1L?=
 =?utf-8?B?eUhlRFJJMnphQkVoNllheWxaUSthOEM4b2tVaWhrempCcTVZbWpEcEtxSnlX?=
 =?utf-8?B?R255UllBMTBiUWNUY3BERnN0UHN4SzUvcGRUT1VBS003SnUxVnczMThaczRu?=
 =?utf-8?B?TFo4elhpL0lpQjJUcGNZQlhtd3AzY3NscUNWVitSZDRZSXpsdXl1aHI2U0Qr?=
 =?utf-8?B?ZFhvWEpVU3FJQkViSzVYZjBsdjREZU1hL3VwTnVrcFZOT2xjQk9YcnhGai9o?=
 =?utf-8?B?a2pJMlozajF3WEp3aExlU2hVRzZud1d1N2pBZWM4SnVIaytXMzRvL2l3T1RS?=
 =?utf-8?B?UUZaVGg3Ykp1L2lOTkZ1dnoxQy92ZGhwVXRmK01MNzBxSllsekpSTlVkUk9C?=
 =?utf-8?B?Nkp4ZUVXYzgvbEF1UEtvMGlkdU8yK3RiTllMK3VvdS9tYU5SaXJEZDlxaXZF?=
 =?utf-8?B?VnV6UjdCUnJDWVJZQ1g2QVlFODVmRzhOZVZub1crTzZKQkxtTElJTHNJV2ZB?=
 =?utf-8?B?YlpNWFArVFV3Znlxako0VFpRdnFuaHRoVWdFN2FRQmJKckRPU3ZycUxGeTNO?=
 =?utf-8?B?NzlwekswYTI4ZWFDZ1g0WFhFSVlJNHFWRTlqYTlERVRUd3drWEVQSTNVSG9s?=
 =?utf-8?B?Ukdxd1hyMFJYTjkzSEplUmQrcE9QYXZEUk1KQWN0MVhNemVZTmJLeWxHN0Fk?=
 =?utf-8?B?aFlwK2RpVGdGUng5TGY4Y2JEa041dTJ0ckRkMGJJNXhSUHNHdG5yVTBJd2lQ?=
 =?utf-8?B?Wnl5NVZXRmN4enZ3bHBhVjh3UVFGUlBabHJwcVJEV3VEQ2U5NDVJbmMvREla?=
 =?utf-8?B?OS83Q3RNYWdmMkZjZWhBaUJNenlrRjk0a2Z6LzlNY1ZjWno2NitmOGVFK2g1?=
 =?utf-8?B?V1RtbWdZL2k2T1ExV2EvV3NJTXZ3VFZMUG10NmpCYVBITzQvZG5aNENOc2Yx?=
 =?utf-8?B?UnhGZjhCeFJEM3lEM2Z1VDVaci9qY01xRWFMODh5b3BtRmdKbG9rRnNnWndm?=
 =?utf-8?B?czhhNlBVY3QwOHBUVVRxZEpyRkxWT3Bic0xxdWtqd1hDaGd0bVhvd1NMNE1Z?=
 =?utf-8?B?Rmk4ZTNmV0QzY29NNUoyazFBSlQ2b2t2VXpOOTR4UElCbWFYbmFuQlRxeU1q?=
 =?utf-8?B?QkQxM1NtUHNWWG8vODVuRzlDa1FnTW95a0lnOE1YbFVRbXJBTDlZbzU4NXk1?=
 =?utf-8?B?OXJlTzVsT2xTNE1GTEdsTWdZbWZSTnlLdjdjdy9oUStoSzl6cXRVc1J2QmRs?=
 =?utf-8?B?UHY1cXZqeGZYREViZjExckIzcjdQekF2YzZTVm96bFc1US9lS2FHN3lHQmM1?=
 =?utf-8?B?cFJ5YXdZZER6K2o2QUxVbWxPWmVIV0YvYXFvSkVyVDVWZGxWek5oQVRmQmlX?=
 =?utf-8?B?VUNXU2locTNrcVhxMUN2akd6R0dMZTZRSWhqNjN1VllzcHJEdWFycnh1ZXBK?=
 =?utf-8?B?dXhZYWhwM2ZOQmhNMmhTUWpSMGp3VmtiZFJPSWFjZWVuSXJEWXkxaVBMTlNC?=
 =?utf-8?B?bXR4TGgvL3o4STZJUWJ2eVlrUThLQWIxSmIzRnNiYWh4MkdrM0pOQnBCeUlB?=
 =?utf-8?B?c3M1ajFyU1ZwSzdzbG9nY3BUc2syTHZKZHNueWVST1hQS1kxdXVCZG56LzYz?=
 =?utf-8?B?TThBWWFML1lTK2lMdmtGK1M3blRGdnVCM0tiampWT284aWlmQU1ieVAwWW1y?=
 =?utf-8?B?RWJLcUtLc2ZJZm9MZzJZcWY1MjVpUUYyMFVEaUtpeXB6d1ZBMlhXRHUweENW?=
 =?utf-8?B?WHNlOXBEaEJvNThWOXcwNzBBbWYxRTV5aElMWDU3VUEwNEVHcytNaHBEalMx?=
 =?utf-8?B?TlI3WXEwZHhkVEV1c09sS3ZnVzdlNXJRL21WNWduZzUrUlBzVUVlTm9VVkZo?=
 =?utf-8?B?OXZVNFNmMGd0MDNmRmhLU3NZTjgxZ0VhR2lYbUdIeWhyeGFnYVo2QnhnMHRu?=
 =?utf-8?B?SzdtNkNnNko0ZVFUWThvMTdjUFpvQ0xxd2dpMHlHbzlhNjlzdE9DTVZBbVBa?=
 =?utf-8?B?RlA2RE94NVRjQVFiMFFISjdyQ2NubWQvOVBQSVFTTVdkK210YkMrbzJQeTA4?=
 =?utf-8?B?OEd0N3Qyc2lUTWJFSFFsVUhUUGo4ek5WWGlWQXNENlloNXlXQjRSUmh5bExE?=
 =?utf-8?Q?Ih/qz3bbFUbIbNHbnf88UVfk2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36215cc7-9e20-4921-2889-08dc8af4d88c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 15:32:19.0481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN6MSeO/9MqIRyyW3A4qmSZSt4zMOZPCQIRpwqHvVOALkY/hH9LBSU2BV1VeEtWR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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



On 6/12/24 17:11, Vasileios Amoiridis wrote:
> On Wed, 2024-06-12 at 16:47 +0200, Michal Simek wrote:
>>
>>
>> On 6/12/24 15:57, Vasileios Amoiridis wrote:
>>> On Wed, 2024-06-12 at 15:42 +0200, Michal Simek wrote:
>>>> Hi Vasileios,
>>>>
>>>> út 4. 6. 2024 v 15:21 odesílatel Vasileios Amoiridis
>>>> <vassilisamir@gmail.com> napsal:
>>>>>
>>>>> From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
>>>>>
>>>>> Changes in v2:
>>>>>           - Remove duplication of custom hardcoded
>>>>> env_locations[]
>>>>> code.
>>>>>           - Add implementation with general
>>>>> arch_env_get_location(op,
>>>>> prio)
>>>>>
>>>>> v1:
>>>>> https://lore.kernel.org/u-boot/20240522174738.73522-1-vassilisamir@gmail.com/
>>>>>
>>>>> Vasileios Amoiridis (1):
>>>>>     xilinx: Add option to load environment from outside of boot
>>>>> media
>>>>>
>>>>>    board/xilinx/versal-net/board.c | 47 ++++++++++++++----------
>>>>> ----
>>>>>    board/xilinx/versal/board.c     | 47 ++++++++++++++----------
>>>>> ----
>>>>>    board/xilinx/zynq/board.c       | 49 +++++++++++++++---------
>>>>> -----
>>>>>    board/xilinx/zynqmp/zynqmp.c    | 55 +++++++++++++++++-------
>>>>> -----
>>>>> ----
>>>>>    4 files changed, 101 insertions(+), 97 deletions(-)
>>>>>
>>>>> --
>>>>> 2.34.1
>>>>>
>>>>
>>>> I have to remove this patch from my queue because it is actually
>>>> breaking current behavior.
>>>> CI is reporting an issue with it and I did a closer look and what
>>>> is
>>>> happening is that if one location has no valid
>>>> data it goes and looks at another location from the list.
>>>>
>>>
>>> But that is the desired behavior, if the environment is not in one
>>> location to check to the others.
>>
>> That's how u-boot is written but if device doesn't exist or not
>> accessible by
>> u-boot it is clear that it shouldn't be used and then behavior is
>> correct.
>>
> 
> Hmmm, how can a device be not-accessible by u-boot but u-boot still
> tries to use it? How could that happen?

That Xilinx virtual defconfig are setup in a way that all drivers are enabled 
via Kconfig but they are not present on all boards.
If you look below in defconfig we are have that variables can be in NAND but 
there is no NAND device on zc702 but still u-boot tries to reach nand and read 
variables from it.

> 
> Also, I think that this is a problem of the user, no? If for example
> you have configure ENV_IS_IN_NAND but there is no NAND device, then
> with the patch you get a visible error that U-Boot tries to access
> NAND which is not there.

For our platforms where you can burn boot.bin to any boot medium we had no 
choice that's why code was written like that that variables are saved all the 
time to boot medium.
Also that I don't want to maintain other defconfigs for slightly different 
configurations.
On products customers should look at our all in one defconfig and disable things 
which are not needed. And where variables are saved is definitely one of them.

> 
>> If device exists and simple varibles are not yet saved there going to
>> different
>> device is IMHO problematic.
>>
> 
> Maybe I am still a bit confused, but I think that if you have defined
> ENV_IS_IN_QSPI and ENV_IS_IN_NAND but the environment is not there then
> the behavior that we see is actually correct. U-Boot tries:
> 
> a) Get env from QSPI but fails because env is not there,
> b) Get env from NAND but fails because NAND is not there,
> c) Get env from nowhere.
> 
> To me, this looks like the correct behavior. Isn't it?

This sequence is correct but what it is not correct is when you reach nowhere 
and you run saveenv you can't really save variables even they can be saved to 
QSPI. They can't be saved to NAND because it is not present on the board.

The issue is that none write initial variable to QSPI that's why there will be 
all the time bad CRC but location is correct.


>>>
>>>> On Zynq it behaves like this.
>>>>
>>>> MMC:   mmc@e0100000: 0
>>>> prio 0
>>>> Loading Environment from SPIFlash... SF: Detected n25q128a13 with
>>>> page
>>>> size 256 Bytes, erase size 64 KiB, total 16 MiB
>>>> *** Warning - bad CRC, using default environment
>>>>
>>>> prio 1
>>>> Loading Environment from NAND... *** Error - No Valid Environment
>>>> Area found
>>>> *** Warning - bad env area, using default environment
>>>>
>>>> prio 2
>>>> Loading Environment from SPIFlash... *** Warning - bad CRC, using
>>>> default environment
>>>>
>>>> prio 3
>>>> Loading Environment from nowhere... OK
>>>>
>>>>
>>>
>>> This is the message that we get as well when this patch is not
>>> added.
>>
>> It means you are booting out of QSPI but qspi is not accessible by u-
>> boot. Correct?
>>
>>
> 
> Well, we are booting from QSPI but environment is in eMMC. In our
> config, we have defined ENV_IS_IN_FAT and ENV_IS_NOWHERE but we have
> not defined ENV_IS_IN_QSPI.

ok.


>>>> prio is my print to show where code is. Qemu boots out in QSPI
>>>> boot
>>>> mode and SPI is tried first and because
>>>> this is xilinx_zynq_virt defconfig drivers/env locations for
>>>> other
>>>> devices are present too. That's why it goes over the list
>>>> and it always ends in nowhere which never fails.
>>>>
>>>> If this runs on real HW then the same behavior is visible and I
>>>> don't
>>>> think it is right.
>>>> I think this solution should be rethought.
>>>> In product current behavior from our code is not the best and
>>>> current
>>>> U-Boot implementation is not allowing
>>>> flexibility too. We are enabling redundant variables which can be
>>>> only
>>>> on the same device but not that you have
>>>> one copy in QSPI and second in EMMC.
>>>> That's why I think location should be pretty much read from DT.
>>>> There is options/u-boot node where location of variables should
>>>> be
>>>> described and this should replace
>>>> env_get_location().
>>>
>>> You mean that there should be some type of new U-Boot node that
>>> describes where the environment should be located and go and
>>> search in this device?
>>
>> Not sure if node or just dt property which points where that
>> variables are stored.
>>
>>
> 
> This doesn't sound too difficult to do. Still, even if this was done,
> what would the priority be for looking for the environment? For now,
> the code is written in a way to check for the environment only in the
> bootmedia. My patch added a functionality that if the environment is
> not in the bootmedia to check somewhere else. This should be the order
> also if we had this u-boot node? Check first in the bootmedia and then
> check if there is a dt property?

I don't think this is going to be that simple. Especially to support redundant 
variables saved to two different devices.


>>>> It is a lot of work that's why I think second solution is more
>>>> reasonable for you which is simply create new Kconfig symbol
>>>> to disable board env_get_location() implementation.
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>
>>> You mean to basically disable the board env_get_location() that
>>> exists in board/xilinx/zynqmp/zynqmp.c for example?
>>
>> yes. Something like this.
>>
>> config BOARD_ENV_LOCATION
>>          bool "Use board defined ENV location"
>>          default y
>>          ...
>>
>> if defined (BOARD_ENV_SETUP/LOCATION)
>> enum env_location env_get_location(enum env_operation op, int prio)
>> {
>> ...
>> }
>> endif
>>
>> M
>>
>>
> 
> This will be accepted by you in upstream?

I think it is reasonable compromise to pretty much disable bootmode media 
selection for storing variables.

Thanks,
Michal
