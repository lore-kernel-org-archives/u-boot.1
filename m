Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F206FE83056
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 05:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4013F83FA4;
	Tue,  3 Feb 2026 06:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W9KbFgVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C07783FA4; Tue,  3 Feb 2026 06:33:01 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8882183F54
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 06:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ochpExzIkMw8zIsvAbiuZRK3MvzGJRHM+DCHNQA13sgm0FlDNO/mJVF5QlT8PAu1dS8CnhOmR9OQb6B8e90lMvGhLzy1QqPnfO1BWVodymc0Ungf8P0eqv0GJp03b9FoAnd3SopTaMBxOced7A/xsGUjsvkNa/8LmcYudlVbivOe0gql9sE9yNhhUvi+I5uCKdpY7Ge0qzElHdqGDw+MdXSv4zWQY4UIzJrHl6YRSEZu7v2ZqNGwV9MdAkneTVrknW0DhIgW8H9upFhbzJYE0B49C+GhRnbBOWjEJ9/Kowi2QekZZ6HOHzjm+HNUar8oNY/QKxoFwKvgaP/Gjc7heA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0KA4yt4P+hTdfpVXJBRvspt6YUq5mhySDxLY2MQiw4=;
 b=ta5g9iW0SpcDXFq3gUr9p8O+nvJtPq3FLXejVfkaSTENwnEiW/v3Iuw0kda8EcBnNElR5hntn1SCJmIIPsGt7SXO1+rv8V8tvV8OSiEmUiVEJW4J9IWJHATlz7ZR1mUTWAfvxqw4OSOVMlfwpFHDWbIRVXTGJZbMVzDas8F6+/ncqWgrtG9HA45fLb0KTu7F6zW3Taf4ikmDFT0gLokAfrONc1QtziBkFp0YOaa+RfLASOqvBMcS8PxqMV4s9CbzAKtKRyBj/r/Po8aiiAaqrQwTDkyMqiRTtBhD6soDPn2H2LkMImGqo7hKYgegSKWHdfpWHxjBTbs3d3lfsamuvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0KA4yt4P+hTdfpVXJBRvspt6YUq5mhySDxLY2MQiw4=;
 b=W9KbFgVeNX0aVpAbBEyBrUfz7i1RgsPpysToU+TBTrXR1Z7UkFkSe0kOCgpDB6ThLIK+MohB0TiballyuImYU3YO1Q7YIdntRY4E9tTZN6Qp2h1mvoi6E015czynqEK8i40blWX73iDRB/c/6kJYhTpa4QKpEu5TfsKHbLMhw/w=
Received: from BYAPR03CA0017.namprd03.prod.outlook.com (2603:10b6:a02:a8::30)
 by LV3PR10MB7748.namprd10.prod.outlook.com (2603:10b6:408:1b4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 05:32:45 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::1c) by BYAPR03CA0017.outlook.office365.com
 (2603:10b6:a02:a8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 05:32:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 05:32:44 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:32:43 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:32:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 23:32:42 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6135Wf2F3393708;
 Mon, 2 Feb 2026 23:32:42 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 3 Feb 2026 11:02:41 +0530
Message-ID: <DG52XM98AICT.O5PR7FP4G4BA@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: =?utf-8?q?Marko_M=C3=A4kel=C3=A4?= <marko.makela@iki.fi>, Anshul Dalal
 <anshuld@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: How to use ECDSA for signature verification?
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <aO1GvGrXUw-co84_@kehys.lan> <aQ98sHenb3G1MQDi@kehys.lan>
 <DE5KUDXKQ20P.86VFM203YPJS@ti.com> <aRNcq79cr08IN5HE@kehys.lan>
In-Reply-To: <aRNcq79cr08IN5HE@kehys.lan>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|LV3PR10MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e7600d1-5390-43f5-26e3-08de62e5a86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVhlMm1rUm94SjRjdSt3TkRzTXlaREpPYjBFdDdmeE1GZEZQU2ZxQzBiWHp3?=
 =?utf-8?B?UGhITTRla0VEakZ1N1VjQUZEMWJhUlF2alB6anhzTWowb1FDMFpnQm9kQU9G?=
 =?utf-8?B?aXd0NXdiaUpjdm5EWXFFSElFSUhKR1NtRGZJeWgvYmxweGs1TE91MzYvR09n?=
 =?utf-8?B?ck8xMXZDdUZXY1lWN2g5b0tYRG9BbFJqZHBnNFdBQnc5U3QweVhjVFZoc0dt?=
 =?utf-8?B?ZFRNY1NXeTJhZ0VYcVE5Q25VdnZ2MmRKMFQzQlhyZzVRVit5dFZZOE1hVThZ?=
 =?utf-8?B?Q1A0dWdIalREV3N1cnBXeEFIYWErME5JZHZyYzQzRTVYa2duK0tWT1k5Vktn?=
 =?utf-8?B?bWV1b1ZUa3QrL05jdCtrdXBUYWRFK01aSGJmakVxbFhwZXZBT25MZnVkVmdD?=
 =?utf-8?B?YVpPNnN4bVp6VWNuTldnckNrNHVRVHNIZm5WRnBYcHZRamovNjJFVXk1ZW1T?=
 =?utf-8?B?aUF6dVFxNy95VkFOTWFhL2NuREk0U2tWU1JNMUYvOTJYMlNUa28rSXdWUHlE?=
 =?utf-8?B?bUw4UkNkak0vejRYR1RtUUhKUWIweDJwNFU5R1RLMG9Ec0lUS1dycVZ2R1E5?=
 =?utf-8?B?empaY3ovNzdsTFo5K2JCa0hGdWp0NXJTdEgxMWVZamFZRTREZFVYQW5ZOUFm?=
 =?utf-8?B?Y0VvenpKeFcza0Rub2wrL0NhZ2loYi95TkxKNndiL1BpS1BwSU14a2VoRXFr?=
 =?utf-8?B?eVNpR3U3YklBQmpvMnJjNFRzSERncW5MeExpL0hYaWZEVk54Q2lyS1UrMnN0?=
 =?utf-8?B?bHRGWUQvcTl6SEV4dmNaK2FxTXpkOW4rQ2lCZHBtWG44ZCtmUXhGZXRWVU4w?=
 =?utf-8?B?QW1WT0MzVXZXN1FoYTVwSkkzUHpETjEzSS84UnlBTVhlUnlBejVpR25KUGNq?=
 =?utf-8?B?d3ZBbzFYZDZNbnRLVVlxQkQwa3p1NGFlbGRMcnhvcTlkZ3N1ZzFMTzFENHpu?=
 =?utf-8?B?TktSc09uSEg2bWg0RmZwWWNBUXVHb2FuZzdSbEswTVZEZU8xd2hwR2hkU0Zj?=
 =?utf-8?B?UWF1VG9mZUdta0pLSG0yVktJLzFoajJiV2R1UHo2Wnh4dm5Pak04Y3dUSlFs?=
 =?utf-8?B?OTRvUTF1UVBUOG1xZjI2dnIyRE9wbWJzeTBVK0ZLOHE5NzRGNG5EeVhUNE11?=
 =?utf-8?B?SlJVNlU1Qkt2enN5emsrQm91VWVxMUM3cmpmTlBZamdvRkhoMHlFa0ZrZ3U0?=
 =?utf-8?B?bU5kbDRueG1rbDhGblhxckNoeitPNWxGY2lYb2FkRXk4Ulh4TXpDYkE2UFpy?=
 =?utf-8?B?d2ExODA5L0EzZXpISCswb1hDOGk2Rk4yMmwzUEk5RVpLdm91M3FZZExoR3hB?=
 =?utf-8?B?Qzh4S1ZHcnI3eVVTSXFvMkFtOW4yaHovK3hpWTc0cnB3K0dsZFhaTFE4amJO?=
 =?utf-8?B?SUZLQmpZUUhKK1JScW5VR1hYdTFhU2d0d2kyVjIrRUxSMkx6OEV4WFR3d3l1?=
 =?utf-8?B?cU9JRlpWZ3k3U24zRVIvZ0JoZmFiUE8xNzlpT0ExbUJYVzI2cFN3ZUdBQXQ1?=
 =?utf-8?B?T1dqZ1MxOHhNWGF3VjlNZC9xMnB3Z3RRZS9XTE15bkgvU1phNSthVGZHYjhw?=
 =?utf-8?B?bk9CSG5HUmFJc05JRkdsV2k2TGRxQXo3TldTK0ZEbzRaTzJuKzVuS0hwbC8y?=
 =?utf-8?B?TFFMcTY3RlVpdXdiOWwxa0tFL3hvVXNTQXVLNDQwWkp2Ymw1RG5teDBndkFv?=
 =?utf-8?B?TEpPaWhLL2I3UHhNZzhqZzdjSnR0eEp4Qi9hY0RXdE1KUi80RndCYS83ajNE?=
 =?utf-8?B?bG0wbzNaYjI5YkpHMmZrZXl6OURSV3dBdVVPQTNIeGVZSmhyNGJpOTZoY3hj?=
 =?utf-8?B?eXhTbjhoOXRrdXE1ckhLSVF5bEJDWHQyMzZrOEIrYk9CczV0UUphcmRjZGhQ?=
 =?utf-8?B?SGsvUUphd3hKSDFtOXJGRWt0OXZJU0l2bUFram16ZFlZN3hJdjAwRTNmNEl0?=
 =?utf-8?B?dHFmR0ZRZlZJYUF3YTU4eS9pRmxGYk1raDRoRzkrU3VCVFo3UUJGMFEyNHhz?=
 =?utf-8?B?aWFaL2JFZTlIR09laGUxU2pVek5PY01UZFZZZS9MalFQMCtaSTd5VlpIazhr?=
 =?utf-8?B?K0Vta2F0cDJJc0d4SDdaNnVZVHJGYlpCU0NmcllqQVJoYytreTFjQXhQblZa?=
 =?utf-8?B?cmFsQ0RlSkw4TUJjR3FPM292MjFocGRkaHZhZjlpek1wVnBnVnUwQm0ycGRi?=
 =?utf-8?B?d3hiY0lhMXZrM0RudTZrVXRLb2FtM1RmZlBQS2d3d3U4RU1yL093UUJlYktr?=
 =?utf-8?B?ZlRHMEFIY0ZrRlF4Mjgxa0R1RDFRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y1JNDgzauUX758QXAZcnu7tBqoJyyeHO30hDXa3Oxdh8FJP2NUHtcpKXl8/YkVw36jkixN3kHJhxKbLbg4xILWWMckxcUPMJ+UkL8uBPYIhLacY/m2Neo9MDz+CK2UO2jIGUolIKstpf14tpFGoAZYCJrvYIRLm8AMI1uNScUbTsMri22Rx1ACoYzgPQSenMTISE7OVRq7txyXvi1KCYqaL3ugog+FUln+pkY8sQWLGWgiRC1d8AmyAGZ/fb3t5P3Cnssc1EKihgvOUFYM7N9pid3kJdJJo1d3yF2+D4JBo7zucnFnaPuLjS1oEqeLV/YtUvHhV5P4QJKWI9GXiPLSHZHIkTaGcn/WwP/lRxjpZaX9Q7B1Wh/oGcUDmxcogQlHtm+XzDa1+2OMpaCc4AaouPYkg4F7zAfn5H7KqNLnxaYzCTDoUpDyya3cdg30o4
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:32:44.4590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7600d1-5390-43f5-26e3-08de62e5a86d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7748
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

On Tue Nov 11, 2025 at 9:26 PM IST, Marko M=C3=A4kel=C3=A4 wrote:
> Hello Anshul,
>
> Tue, Nov 11, 2025 at 09:52:51AM +0530, Anshul Dalal wrote:
>>Hello Marko,
>>
>>On Sat Nov 8, 2025 at 10:54 PM IST, Marko M=C3=A4kel=C3=A4 wrote:
>>> Hi all,
>>>
>>> I am new to u-boot, please bear with me. I got CONFIG_FIT_SIGNATURE=3Dy=
 to
>>> work with the RSA algorithm, but not with ECDSA.
>>>
>>> My two main questions are:
>>>
>>> Is CONFIG_ECDSA_VERIFY only implemented for the two targets:
>>> rom_api_ops in arch/arm/mach-stm32mp/ecdsa_romapi.c
>>> cptra_ecdsa_ops in drivers/crypto/aspeed/cptra_ecdsa.c.
>>>
>>
>>Yes, those two seem to be the only one's implementing UCLASS_ECDSA.
>>
>>> Is it feasible to support something more modern than RSA signatures on =
a
>>> reasonably high-end target, such as ARMv8? Are there any suggestions or
>>> git commits that you would suggest as a reference?
>>>
>>
>>Should be possible, you can look at the current implementaitons of RSA
>>and lib/ecdsa/ecdsa-libcrypto.c for reference.

FYI Phillippe Reynes has posted an RFC for the same[1], you can provide
feedback there if interested :)

[1]: https://lore.kernel.org/u-boot/20260202170307.217200-1-philippe.reynes=
@softathome.com/

>
> Thank you. I will look at that.
>
> [snip]
>
>>> Rebuilding with CONFIG_ECDSA_VERIFY=3Dy changed the error message to=20
>>> the
>>> following:
>>>
>>> sha256,ecdsa256:dev-  error!
>>> Verification failed for '<NULL>' hash node in 'conf-1' config node
>>> Failed to verify required signature 'dev'
>>>
>>
>>This is probably due to U-Boot failing to find a driver with
>>UCLASS_ECDSA, you can verify by adding a "#define DEBUG" to the top of
>>lib/ecdsa/ecdsa-verify.c and check if the following error shows up:
>>
>>	ECDSA: Could not find ECDSA implementation: -19
>
> Thank you for the tip. So, the #define DEBUG would enable the debug()=20
> statements. This indeed confirms my hypothesis:
>
> ## Executing script at 90000000
> sha256,ecdsa256:devECDSA: Could not find ECDSA implementation: -19
> -  error!
> Verification failed for '<NULL>' hash node in 'conf-1' config node
> Failed to verify required signature 'dev'
> Boot failed (err=3D1)
>
> I'm working on this on a hobby basis for now, and it may take some time=
=20
> before I will submit any patches for review.
>
> Best regards,
>
> 	Marko

