Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCCEC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 12:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC4EB8096D;
	Thu,  6 Feb 2025 13:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JqUIbYal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6791F809A8; Thu,  6 Feb 2025 13:36:44 +0100 (CET)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DAD807FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 13:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an4qaknYJDsg6Q+4oUn/1sgwfKM4WMGcqKRLrd+4ZtUolRZavs20zlI3Yz/QvDOUoPQFldNCoTq2g7cA8T0oPaEuMnE2YgPrV+JDPxxLouXKzYDsNIqnmxtY1gSzCdMYJ2vrrYEUXztf4ZCIlQNm7KarT1Z9r1l4jB/o1w5O59DiiLHFUNi9FJPaPvHSY3uRZvOdTfOU7tnl32n8fzg6EUT/N6uiiQuIVNiE0nq0usAsxYdAHa4bzn20iDDvUNkgm3vKgi6T2iZwURAkKtBs7aV6uDQirQg80fMuLDYyRvVmSu1R5iDWvoi4l3hMvwZmtSoSkVE5Sr9VhjhR2DahBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qlV8xK9dbIOpSyI3RXqax7Uhdb3jV8aQBRJX4d41oM=;
 b=IZmMnvbgSVr0EE55yJuKdd80mbHho7OP4hgKGKsA4yu/lvdT44BS3328NIYce+d84zyGNY5II3AYWLJ4wpQzojnW/SabybCfz5T7xA49g33UFm0zdcid/lLJrMxz48Nfp/Tr5Xg6meVEQs37FYItHYCyoYhXs7eVKhksLf4miJO9kedpKmzJiBJ5iLoOwveNqAWKSwkrTVI3lFqrJ9Nk920rfZo8N+w+f2IIzUX+m7lc4waktWYKhlq5fnpPms6QD278b/KjPXB2SZIX6wmUExB7qyhF5v5ryFqYNrXMPJ6Oc2vSYmJ8UwXkz1DLhRCT4Lli6HjFJQiAvIsmzLhv0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qlV8xK9dbIOpSyI3RXqax7Uhdb3jV8aQBRJX4d41oM=;
 b=JqUIbYalE3qoy2bJT/RLIrEKxbo6/YQTa1UjWmULLlaCKa6ocEsZEbDiFNwi/Dus5czFW85f8iHiVZdFdtQNQsdxAgvjFvsoWQTn05jtNj3ta//lJRvc3gSZW7/BcHAYCxzOOIi3SX5Bo0+r+rTowI1RGF66C2RCGYeCqL4fiIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 12:36:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 12:36:39 +0000
Message-ID: <bc424b60-7f3f-41f2-b357-f86c55579de0@amd.com>
Date: Thu, 6 Feb 2025 13:36:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zynqmp: Save "bootseq" environment variable in decimal
 format
To: Simon Glass <sjg@chromium.org>, egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, love.kumar@amd.com
References: <20250204205617.1238-1-egyszeregy@freemail.hu>
 <CAFLszThdhXWbKtaptExYEVm4Y_FaBPjx=LGHidGazX0-+0MH3w@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszThdhXWbKtaptExYEVm4Y_FaBPjx=LGHidGazX0-+0MH3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:118::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 5183f89c-4c16-4f46-7862-08dd46aae6f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0xxQ2tKeUpJUWdaUFBBb01vL3dYVVlvWUJYUGJGeG1UUCtGQ0VMYUdtZ3hT?=
 =?utf-8?B?d3dvMldlc1JNVk5IV1E4WDM5aVZQczU2Tm5XQlJZMzZSU25tbzNONHBFV014?=
 =?utf-8?B?QlRrdDZnOU5GbHVsWEZSOUZBZkp3cjFnMXU4MHJaek9FZ0R0WEFqbjh6Myt0?=
 =?utf-8?B?anNxSlVzdlRiZVVKQWR0UFppaTl6ZFNpZVBRWXVTdlVycFptMjhOcGRXdElW?=
 =?utf-8?B?MzJYY0hxcWRtSHJuNEFLa3dpdXp6ZS9WazRSZDRmMkdxdjYzVzNUMWp0MXZi?=
 =?utf-8?B?U2k4akNXYlltckh0bVF2SEFQM0o4K2hoM2ZoL1NNcEJ1aENJb0lxbk15V0pa?=
 =?utf-8?B?VHVZb3MrUGxpWS9UUU9aZ0xrSzNMTjBKRUJDTzlZNVEwNFFIRHBCbFpQWmd6?=
 =?utf-8?B?ZnV2UmowZzh4eGd2TnpvQm5VaWRtV3NROVYxcU9EZmN0K2d2SUxLdkkvMzhm?=
 =?utf-8?B?QnBEMThmOHdmUkl1T0paTXhJU1psb1RQR2Y5R2hQTE9lcEViMyt4OWNQM3U5?=
 =?utf-8?B?ZUE0c1ZiaEIzNTdNWjFXZVZpS281Z3JncWprc0trdWpHaUgyMS81elRtamlJ?=
 =?utf-8?B?T1N6Y25uOHowUjJyQXBSRjgxVXNtMThURFlLajlvTnZpU0dPUjJEWXpGK0JH?=
 =?utf-8?B?VENyYlpsOVNjV014a2h4WXFQMEVVd2tyYllkdmFKTm9HblVndllKTk1CbGVa?=
 =?utf-8?B?VDUxYklWVTlHaDJXakJxaFJXNkY4L0l4L3MrMEVNMzFjcHdNM1FJN0RPaTJE?=
 =?utf-8?B?Rk96ZE54cnVwWHVJdkhndEJ3RjZUUXVGWEYrMXZJNU13R0duRm5aclNFNkF0?=
 =?utf-8?B?T3A0S3J4anNPNWZnSERPNzZUdWl0MHdvVTF1eXFaaGI0ejRSdHhJVVk3b1p6?=
 =?utf-8?B?U1MxUWNCOGdoUUVTK3F3MlQrK0JFamNLK0EyMC9mS3FUV2RObnpVem95NWU1?=
 =?utf-8?B?MUhRTnNCa2JRZEc5NkFnd25nVHdWdkhsOXp6VlVHQXBjR1dGdm8vb1MxUkk2?=
 =?utf-8?B?YTRPQUFZRlRsNTlFT0NLT01Jb3NST2Q5OFVRUVBCNUk5SUZITjBPdFcxdzZX?=
 =?utf-8?B?Y2Yyb05DNXorMk1LKy8yVVMxMGtTcVd1Wll2QmJXVTVIaUJxam5LTUp3RHFr?=
 =?utf-8?B?bDhWQ2pITjBJNEloVGViN3Z0NVoxeU9jcEkzNGI3b3B5dDhEWXg2bXM2djli?=
 =?utf-8?B?RlUzNGM2M0piWTRnQzlRaTFFY0QvcmJtRVVvZWR2VThOK3JDV05lbm1Hdm5X?=
 =?utf-8?B?bjFrdUc4YUNheDVaaWYzTDhlcGkxclRzaXV6NUc5alg4UWIvRDZickZLbFhx?=
 =?utf-8?B?Y1ZnT1hNRXhucDRDdHo0b1JETk1Iajlja3dqR3EwZC85QjNuOVBwamxIZzFF?=
 =?utf-8?B?RDdHaUswOEdweUdSaTdmTUZ5eHZlQUlwd3QyTUlUTjkyU3NJUTFYNm8xRmFx?=
 =?utf-8?B?dGlmdTNkM0xpUklPamRxUjVrUFhqczZBNUFDS3BRSms4WU8vL1BLc24zY3pt?=
 =?utf-8?B?UGZVdmRVYXlLQkZuWHFHQUNjd2JpVCsxWGFEYzVNQyswQ1hOWml3RXE1RzFH?=
 =?utf-8?B?WkxxN1gvVTdWMGVsUGs4Vi8xaXJWY1NzOURYdk15Z2tjVzNGQnZ3NmdIWEVJ?=
 =?utf-8?B?QUF2b0FIbXF0WG5VUXRSZkpJZVFOSUxFajJ1L0dkNFh6RXducm44ZjZaRkxa?=
 =?utf-8?B?cjlaeTExNUxmMHRudW5namlJT0dQS3dRV3Z0M28zWTRMVHpreGZBY3ZVVGFY?=
 =?utf-8?B?cHp3Z1pXRkIxYk8zVy9sR21JeGRSd3NQanBTSUQwMm9EMm5KOTc0d1d0OGxw?=
 =?utf-8?B?ZHlHRVJTbDMxNEpGL2N0UDV1QnJVd0pieG9tUGszY21rVzRuUS9RaXk1aU5B?=
 =?utf-8?Q?HzcihipZdkHwn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXRmV2FJcWQrMnZZNE9jbTc4aDhwdVFEck5ZNWZCN3RJa1M2citlaGVkVGM4?=
 =?utf-8?B?bENKT2xhRWYvd3J6SklSY0NkS1NpL09jTDVwLzZYZ0lYbnFrM0dPQ0hYU3Ra?=
 =?utf-8?B?bFkxWW9iQllLaFcvRDZEZGxCU3c5cnVvL0lBV1E2Ym9Ea1BacURhUFpvbXNi?=
 =?utf-8?B?eXh4Z0o5dlhkOFdFR2U1U2RwYysvcXNpN3hJd0ovRWpENzY1QTE5ejJFRGgy?=
 =?utf-8?B?UXJqRnVWelAya2pRbnNmbWo4bUpNR2hQdWpQQW9HSTFyd2RoelR4K093c2Ry?=
 =?utf-8?B?a1BKUWhUcGJsRms2MmdoYVRacG5BL2plZFh2NXJQRmk3TDlCR1RxS3k2RmF3?=
 =?utf-8?B?MzVGbS8vRHNiMG04TDFYVHF6Z0kxT2RuTnZZLzN4TGs2RDFuTnpkbDZvV1JG?=
 =?utf-8?B?b0lMcEN2anNjenhhSGhzVTFVQXRmdU85QTdmVE8yWUNjN01sMFJmNG15dHpM?=
 =?utf-8?B?Si9Kc081Q1FsNm5NcGE5YXZ6aTJlTFZudDllUXI3UGJOdVFoVW1kNXZydWJZ?=
 =?utf-8?B?SmsxMHVwNXhhUW0waS91TVl5MFFQdjh6aUMyM05qK3dmOTlmY2dTaHB5ck1G?=
 =?utf-8?B?eGVEc0xtM3ZaNDhreUNOUHk5R1lSS2J1cVA5S0NuZGZzT0N1UGVRSmlqemd1?=
 =?utf-8?B?K0svdkdJaWFoaVZ6U09IT3pHaTBhS2lIeUVmaUE1ZVRFa2ZqTEtKTjgzUTRV?=
 =?utf-8?B?M0dmRUxadGJ4OWljUEJwWGx5cUM4MXNQVnpyQnBjQWQ4cXh1bnZBZ3A4b3FB?=
 =?utf-8?B?MzI3SHdSb3k0NzhIdFIzTVd3cVdnYzRVdzBmTWZIdXNCUG9DdVd2bGhrWmcx?=
 =?utf-8?B?ZnFPQzMvM1ZwUVROcFJBNkxGNm0zNFI5TDd2d09Bc05xVVFZdTY5bWVYem5k?=
 =?utf-8?B?anA5MGZoMi9ZdlVFRWxvWmo3azh2cktHN1c3U1pOeUpueGNlV2ErWVV1clZZ?=
 =?utf-8?B?ZXAwVjBlMkFyQXA3d2tOTW4xcTlSLy96OWxncXg0eDZDMGx0a2hwMFhTbno1?=
 =?utf-8?B?MGEzQjBNUE93MVg3clJpdHRKM3JmSmk5di82VnIrNktBSzd5NTVkQVBDRmFW?=
 =?utf-8?B?bE5jVjhXZEZKeXVjQjdTWG5GTUNPL0htTDZ3R3ZqSkYxU2x6QlFTM0hGNTJH?=
 =?utf-8?B?NTVvSC9PVWZXekRFbVNhMTNXVmZSTFM1VEo1QUJtY2wzcTBWa3pKMklyaTZp?=
 =?utf-8?B?a0lPazJCYkp5SG1SVmE0cDZTU1FoY1FDRnZtSEFnQWtEdm5GYUcxbVhndURU?=
 =?utf-8?B?SHl2YUhYY2xnTzBqZDRHcCs0MVExVUt1TG1aakw0d1E0emNHR0ZVZWRqWXVn?=
 =?utf-8?B?RUlsVU16V0hreXd1WEI3bjBzQkw2MnJFN3FXMzJzUmxMWWhveXZEUWN5dXov?=
 =?utf-8?B?bktxK0ZCUjliQzNxR3lITWtWOXlEMjVLYk5lNTBxa0dwRXRLdGl6LzBwVDJv?=
 =?utf-8?B?SUpMaEVPZFJzR0RJcDcwdGZKVnZEcXR0MTFKSHZsOVYxN3VUZnIyNkJ4UklS?=
 =?utf-8?B?NTREZkhmdFBYNGdrZGJTdkp2eStpaWhac2FwMWNQRms0bENmMzBWeTBpVWxE?=
 =?utf-8?B?ZS9NQVB4K3RtSzBzN2ZkMWwvU1hsc3Ivb2pTRUsyc2prbHNvWXJaandiMjNB?=
 =?utf-8?B?ZmZqTG14czZiRk5HMTVneWVtWVd4Sm9qNEN0OE1RVWdnanFPbDh2c2dYTWJI?=
 =?utf-8?B?TS95VENtZUoyb0VaQ1RaWGZTZjU3VTRQME1xbVFTNTl2MHNEbjJNcjRJTlMy?=
 =?utf-8?B?OU1BZlpJdlRTTGliSkViZWtmN0NGUXN4alNFajVQRDcrMjlKWkRjUmVXUllL?=
 =?utf-8?B?RnJHYWh0TEc5ZXVtYU45L0NXb0VyOTZld3hua2NzYlEvcHdhRXVTTnlEakxi?=
 =?utf-8?B?SjlMMTAyNENUQUtBNDdBbWl4TDIvOEs3OC81bkJrMzRFMks5ZnREUlBmTlA1?=
 =?utf-8?B?bm13VWR5ZXlLT1gzblhOQjFJQ1JCa2JHS2RCOHR2czlJZFBVVFZBVzdtL01G?=
 =?utf-8?B?aHRBbEZaMi9qd1hsZGVhcVViMnRkMEt2NENMWTBmOU9DYVpUcW54UDlka3Rt?=
 =?utf-8?B?M0RzM0YwdmJyZW5yWWwxc2tGLzErTjlqT2lCRER6MExRbzhtbXZITjB5c3F2?=
 =?utf-8?Q?T7eA6WtIjCFBD80g5tf6LWJ6l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5183f89c-4c16-4f46-7862-08dd46aae6f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 12:36:39.1882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTMYy/j/PbZ3Dj5AwTQNG7zQVWy69VyuUGsdWnCGxLidNemoSIcwGx3cBOA6raLl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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



On 2/6/25 13:30, Simon Glass wrote:
> Hi Benjamin,
> 
> On Tue, 4 Feb 2025 at 13:56, <egyszeregy@freemail.hu> wrote:
>>
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> In U-Boot, most of mmc releated commands uses decimal value in arguments, like
>> "mmc dev ${bootseq}" or "bootargs=root=/dev/mmcblk${bootseq}p2". In order to
>> improve compatibilities, export "bootseq" number to environment variable in
>> decimal format instead of hex.
>>
>> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
>> ---
>>   board/xilinx/zynqmp/zynqmp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>> index 8cdd9d8600..820fb252a3 100644
>> --- a/board/xilinx/zynqmp/zynqmp.c
>> +++ b/board/xilinx/zynqmp/zynqmp.c
>> @@ -488,7 +488,7 @@ static int boot_targets_setup(void)
>>                  if (bootseq >= 0) {
>>                          bootseq_len = snprintf(NULL, 0, "%i", bootseq);
>>                          debug("Bootseq len: %x\n", bootseq_len);
>> -                       env_set_hex("bootseq", bootseq);
>> +                       env_set_ulong("bootseq", (unsigned long)bootseq);
>>                  }
>>
>>                  /*
>> --
>> 2.47.1.windows.2
>>
> 
> Actually I think the 'mmc dev' command is the one that needs fixing,
> as U-Boot uses hex. 

Not everywhere which is the issue.

> Probably there are seldom that many devices so the
> issue doesn't arise. Anyway, I see that this is a zynq thing so I will
> leave this to Michal.

Issue is not coming up because none is wiring more then 10 sdhci controllers on 
our boards. That's why transition from hex to dec is correct thing to do here.

Thanks,
Michal


