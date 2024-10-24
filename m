Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D8DCE8E75
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 13:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F85188F2C;
	Thu, 24 Oct 2024 15:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="ZMB4OVWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E98388F27; Thu, 24 Oct 2024 15:18:42 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B0088F2C
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 15:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H95c03JT6yi9Kz6ryj2jhZuRmmbRtc5pYcyM5CoTpPD8WpbclV/46L0qlxLxkQjrwhkWQm5TEYX6TC2eRFQCFTVaUnBcTix7O9AIxIhFK0LCMRiDccEEPkQbMA3dBDMu4qbLqvnk6SkzST2OIbIUHNYnoXSMaoSweT0kXT4R7pYk3s7/uEp8i2WVMtpQ5KYqY6SluW448+eGYO2wpqGIUnGBM4Ef+1P5mORkE+dGAB1Rnn7fa8ARvCxFl7NykPnaNNwY5+mmFbHjbIHVmwMQB9qS+Kjtp93+zTAjH0H+TrOo/rQ30Q7J3160BNVfik0/I83JD+3scWh+bbARqv7FcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yNuxyxBSZT1ABktS8n047sl5aIDVJi7U4pdc1SFRGE=;
 b=L385rpfMJ6AcZqsW42MEzvR8itPLEw7MERQ6M10+3lzbFfzL1m1BLIWjLRfFa+Cp4uAvAmxQqTGzQSs+/cS8yMulqekxoSfKrIChdLhlY6KGz8bzjSiQlTffRx3c6cUUy0Tw32cnDD2i/FSJZPa8oC98nabHEKfWBS3nonJ11mMVy5F4ufBy3Ea82/SyvCPGEKMAZjA/X1393mv7QAcLiYl3YhbeprPBt5RprVc75f5c/TxPkllS7DozIfvhZqH4QD9WYXuW7WwQqWLWQoOn5MVct7O6HN4ysIGBc+5vG9O3Y627GbaJ7U0ZVt/Xm6qR4P5rdVI2Ej29jJX3fLf31Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yNuxyxBSZT1ABktS8n047sl5aIDVJi7U4pdc1SFRGE=;
 b=ZMB4OVWs/1w4PEpAIHaZzKKKfTdaee2XZqOgsR53THeeShfi+GSm2HjKR3Hew71ICxgycjqjXSLBmWdVEnPIasoozcHKfRFRyOz9dnEDbXRUUiUA9J45b/4iClua5+dj9GreMOo8lRk8i/yc0GR0viC2sVUZpwG2iXIyfjjP4nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ea::10)
 by PAVPR10MB7282.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.7; Thu, 24 Oct
 2024 13:18:31 +0000
Received: from AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83c5:5c8d:5d3d:8b09]) by AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::83c5:5c8d:5d3d:8b09%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 13:18:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de,  Tim Harvey <tharvey@gateworks.com>,  Heiko
 Schocher <hs@denx.de>,  Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
In-Reply-To: <58754a24-eb1a-4306-a5de-e990539b1717@denx.de> (Marek Vasut's
 message of "Thu, 24 Oct 2024 13:51:16 +0200")
References: <20241024100145.841964-1-ravi@prevas.dk>
 <58754a24-eb1a-4306-a5de-e990539b1717@denx.de>
Date: Thu, 24 Oct 2024 15:18:35 +0200
Message-ID: <87seslprkk.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::28) To AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5ea::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB7082:EE_|PAVPR10MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: fbebc4ac-6e36-41d9-aee9-08dcf42e5afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v7eZVg6FFxPuuaCF/tzxc/NgPzhSlmMec0Sfio2WiG5K0UDEtE/8qiIcj5AB?=
 =?us-ascii?Q?MfdP+osKLVDuAk20m7Faaz8zMuyjJpYvr8EpuS64QmkVD7syxo6105Hxvxsx?=
 =?us-ascii?Q?T+OXeCtfxcC7WVBj+G43eaVdlBH4eBtAiHzsBlm6173d1RfqGv46jFZtk3JC?=
 =?us-ascii?Q?MhT00sD/1Y0YGBBR+lokwWCvuEAzDq1OLLHBytL3Gs+03KZ+firEV5zdzrhZ?=
 =?us-ascii?Q?/SXK1F24zbdiPAmdPN7/E0KPkD3DknMEtKvSh7k1Vur8lNdYfj4Ueq7Gf92J?=
 =?us-ascii?Q?SdjuOYxYxgZ0HDQ4GWxYOpcAf7VRl0zgudDsgtqjfoHnTohCUFAFSlsiTi7p?=
 =?us-ascii?Q?he51aFLPlVCy0/G6gNbMRWcNXVKGC3fG3MA7o7l/9tb2iKmpBfv8OZx4ZE2n?=
 =?us-ascii?Q?CW2O8SRm1QcDwcjxLxM4QAnz7yh1+2UU4X6fq0O/Zw+qJxEvU7Z3dWPt8rcf?=
 =?us-ascii?Q?rS/YiEjM7WfNA9JW+BneQa1+QyYp5HSL52F54JPSqJi4I6JqJT0mXOz3fc0M?=
 =?us-ascii?Q?PKNZ050N4qxkpscAiwBR17Epigf/4afSdDNsUpPqcYvrUbHH3j9VwWk05Ha7?=
 =?us-ascii?Q?V32dlV8D5K+kH4xvDJDD2YB+nfC8kaa5YFQhHweCgmuUTjgEInoC2olVYS1D?=
 =?us-ascii?Q?JNnRUIjLX3JVbhayVtXvTd9ro7pvzU1GsD1xkbJ8/GUpXaNSNsQAz1Yi5Cn6?=
 =?us-ascii?Q?qIWqa1dFO2ewS/6ZBPQuJHe9qlct3lgCPnFXgTY4jO887PFLi1E6PX9ZuGrH?=
 =?us-ascii?Q?Gj67SQFaH47K8gNqd2eS10eqSyBkoZzJm2qrphLkEKw61cVJmzUSSsW5r+HD?=
 =?us-ascii?Q?NkMquaa4F8pZ+BqMO/BUmWKisFI1XhwNIKD3h4gKazC33U3d6s8qj/DLKoLz?=
 =?us-ascii?Q?IOPaj+vRBIWZ30B6Rbxg7IUZZlC96W8cfLcSO+4/yRQlq6An0jFenkhcp3i4?=
 =?us-ascii?Q?xWqSRZvkRGM8t52U5Dq/Sd8Dxj8z+F8HOHpNIvGj38ktQ0dJs/YCZunG1SMH?=
 =?us-ascii?Q?ll4ybDabysShVgbqWWERh1T/4M03Ig1RkSzWIWceWgSn/o/ww2QRA4RDOc+R?=
 =?us-ascii?Q?WC8G/XuikW4VM4vM/h1IylWY0bChFrzr5Bs8SV3RyjMB5H+wzgVlDgeLdNAj?=
 =?us-ascii?Q?RMjPgTM7gpURGpPnFKglDVulJDlj0A59Xz0UTie9DLuCPXh3uYl5dAGcPPGu?=
 =?us-ascii?Q?Yqi1SvGQlTYTWu65iIJBM7oRWwxNRTrUKxtT7vaxJZmYrGplIekwivEOiLMU?=
 =?us-ascii?Q?tZPKDtbx58DZWRTRqNgHMI/O4lmiV9vyEdujAcfbiJLBRTZXOexjlMef5FTs?=
 =?us-ascii?Q?kgnn7OS+r7+Zt2Fkmm39yggh7qYqJUtz5Ptcj2SSdXIaVu4BQmWkvokhTEyP?=
 =?us-ascii?Q?4ibcyUQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mZIlYljPMEO5XuBAjrhLhF/lrFRhv24iS1GUBQCTscmxNZvDkHEuJHNUZS5?=
 =?us-ascii?Q?SkhiwI5Piejn/Wb64RuG7IIMAh0RVZmJZrEi0fsu58KJU/7OXnwu6WwAbVqs?=
 =?us-ascii?Q?3h5Sdt+DxTSpddmA80ZoV95lSFx6StOjo+37kSfh45kvUB+b37uxlXA9uYBW?=
 =?us-ascii?Q?bmK+2c+wTgi1eeDL6dCY5sDRfDvQZJS5m6u/jkzUBz3YbuDEg8wSWN8btOhN?=
 =?us-ascii?Q?rF/0i5NYTdDG+DiEtbiNs8kPvefFAL4MFZ4fmrn2zRkaDgGxvowF/KUcQzgi?=
 =?us-ascii?Q?t83ibbCQn7PKkNv3orQEGHzZl074fi4t9fCLINVFQgHvstRPbJ0ZAl9YRG9/?=
 =?us-ascii?Q?2CNCydQ6RMzqL+AEX9gb83u5gF1FS0z4EigHt+8FohFEVle8YH/ABuatFOTH?=
 =?us-ascii?Q?vpW3CrXrHeArmPsCVH72ZFQBalXGobsVu39LZnqbIfDnV/E68sFvdUKeMKs5?=
 =?us-ascii?Q?RGqlBJ3XXVEeasB9EgDr9FFIzFrAKL/RsmJpZOPgK78Kx5p6RkS3wzPr8wQE?=
 =?us-ascii?Q?aDJyZ7Cz6VvUuk7R0WSpNqXSvwbxnKiHZoFmJTtdsrJsTfpeWaY1yWEsKhhC?=
 =?us-ascii?Q?XIQlNaIXhcuooPa1aIaVnu1a7fRHw90z/2+hE8+jfoTGJq7qaWLKOQkRuwWK?=
 =?us-ascii?Q?1b/Iky0+eGzdoadzxmEtM4f1K9rKFHnK+VyFTR4+C1nFe3HGh5t7fm2PoX0l?=
 =?us-ascii?Q?5jBGJgdOBzjf9XKHQmwQDt13ocMMV34lSGziVeudAI2DckWvplJnWX1AHD7+?=
 =?us-ascii?Q?C+aBQs+VvBwUAOuBSx4gujUrq23F9PC7R+zT8SvPUuAkKsOI33pJQYLGGU/w?=
 =?us-ascii?Q?ynrGqb0wytDoD6DSofRblhIgN4NJzSTxk4XUobWdOs//ZK1wyhA2ckgQ779z?=
 =?us-ascii?Q?dwjaBac3pI9dX4kC4GPp20ZC3awj0ZY+u0jYv/kKyqJlX4LFCc62nn2A3Eb5?=
 =?us-ascii?Q?9qS2zf+QlpwoyUY7uDHlrUGGRFpoIuNQPbCdjT08aDXQ6xbjJZmbna+1mzD2?=
 =?us-ascii?Q?7AwyWroDvYfc1dY/VJVHCbU+imME1U5nEwgtfZq0bCajvkL330Er993gxgja?=
 =?us-ascii?Q?ufD9f0bhNAXvf0kYRWVyfEW0JivJOTZqOd0Zo2yDekjoOe8n2ihHblq1IKaI?=
 =?us-ascii?Q?SNWYIGwcC7/pDn47zYfN/iCUmQ8/g9uWvykYb7nHCmifNQgyB73YdpseSg5d?=
 =?us-ascii?Q?XGJwV/GkOu4ad5+DQp6m5yLK+TrSteCMWgavqoEkFmYfD7r2zGYBi1fCEdJH?=
 =?us-ascii?Q?dUz1L/zM9DtkKTdPF+fo85QlwtnGz2mD1ElSlMftAq78quDDeI+g0h+6hPZb?=
 =?us-ascii?Q?5n6FiuKptqN5guW6SB2XrE5EzoC0vP8K6mhDujx14xpKqgoNIb+tidRWXFlk?=
 =?us-ascii?Q?Eg0l2/G9cIUN3qXbQX1K2EWesfuScUu9K0VpCiNyNl/GyJRCYYbF23OV79Ym?=
 =?us-ascii?Q?QM2daI9800/Hqzt+V1vka5spR5dRTPr/6NUyF3hH8MYfXZfjh9XoTAdpgB5L?=
 =?us-ascii?Q?RhBQPTmmBuFxNRKhwbd0sVbSmTLEbgUI8WXinxgoPCHc30Yc5EQSbTzE3aFO?=
 =?us-ascii?Q?/c5MnSMF0mPuTBaTTger8qnGDfurZGHJmjPCY7kPkZvGa9rF0znyywVrLQnE?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fbebc4ac-6e36-41d9-aee9-08dcf42e5afb
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7082.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 13:18:31.3606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27Ok9EaQuEPFtWUWnmdOlSa45uSoNHdXmq1U3vRE+Yxdgyjqu4HdwaAmHC1tYDuIixBf6tkm4Th46lS1BnWiYARjnT68S6HLZTOq3uiAq48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7282
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

On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:

> On 10/24/24 12:01 PM, Rasmus Villemoes wrote:
>> I enabled IMX_HAB on an imx8mp board, but even though I knew about the
>> implementation, I forgot that I had to provide a sane value for
>> SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
>> implicit requirement, and there's no build-time warning; the default
>> 0x0 value just ends up being returned from
>> board_spl_fit_buffer_addr(), obviously resulting in a non-booting
>> board.
>> The existing imx8m* board configs that set a non-zero value
>> currently
>> all use 0x44000000. The actual value doesn't matter too much, but 0 is
>> always wrong for imx8m platforms. So just use 0x44000000 as default
>> for those platforms.
>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>> ---
>>   boot/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 940389d4882..72d1f69afcd 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -231,6 +231,7 @@ config SPL_LOAD_FIT
>>   config SPL_LOAD_FIT_ADDRESS
>>   	hex "load address of fit image"
>>   	depends on SPL_LOAD_FIT
>> +	default 0x44000000 if ARCH_IMX8M
> This only applies to HAB , for non-HAB the fitImage can be loaded at
> arbitrary location, do you need:
>
> default 0x44000000 if ARCH_IMX8M && IMX_HAB
>
> right ?

On IMX8 without HAB, the value is not used at all AFAICT (otherwise the
value of 0x0 would have caused trouble already). I don't see the harm of
setting some sane value that's actually within DRAM space independent of
HAB.

Making the default depend on IMX_HAB has the UX problem that if I do
"make imx8mp_evk_defconfig", then go about tweaking stuff, then do "make
menuconfig" and enable IMX_HAB, SPL_LOAD_FIT_ADDRESS already has the
bogus 0x0 value and nothing forces or asks that to be changed. Making the
default depend only on SOC (or SOC family or whatever IMX8M is in this
context) makes that problem go away.

Rasmus
