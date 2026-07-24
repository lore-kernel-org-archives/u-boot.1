Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F1FC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:24:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1580E40B11;
	Fri, 24 Jul 2026 12:24:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hZ0SJvAGBY7C; Fri, 24 Jul 2026 12:24:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD08940A90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784895874;
	bh=xTENy1AJl/+CBizYaf5ouvz9IXNSfxbc3onxu5LWqUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=olIJ1XP66kCe4VR08sFCGBRIcmcvjC8C8hSfOmji5T75LuVpydOmQ06MeCvbAttmN
	 lbHa+IZbY4d6tABkqSeATOHXofi0x7SywznEHfN3pY+fBVvtrcJ93U6o9zd9YPKFpS
	 8eJfQaXfWS2S5fdst3NhlhMbYIXlZPqLarRoHX4zP+wE6BM5TWZ9s2bWLwXx9QNLrB
	 kwpqiDgTKaaTUZQO10uWEYynu9R0L6IKGQ2JVsWb3cb8nA/t7N/BvJ2kI86JxEWQKh
	 QB/Xl5kl017MEdOajhQ+EI3HDrAkL6xK5/zdd2W5UOr4Eo7Pen8PXcMorCKBNtd4Qv
	 J9mwSL0xI1uVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD08940A90;
	Fri, 24 Jul 2026 12:24:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 71DE3347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:24:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6362B40A90
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QysnXLw5x6iv for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:24:31 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=love.kumar@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A148E40A72
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A148E40A72
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A148E40A72
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:24:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 508F283E76; Fri, 24 Jul 2026 14:24:24 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0F32800AE
 for <u-boot@lists.denx.de>; Fri, 24 Jul 2026 14:24:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PisF3QKeRtK4qHQVmtNUoUSCRQMtZ4BJHw8xBpCp9n+Or3iPbEGjbv5YGGHru0iV6kMucV7EcXsrMeXbm5JNQA1JGoSs/6dE1Z3n4j2Zp2Fkv6MugcvS8bKDbB6Y5OAoQlyh3FnoMMAFDjC+JzDYsSme+FKLfxYEjq2gcA8fHgcSaktQBwbPnTi7ZMHkHnQ48NYcg6f9Q6g3XjtOklhxEHyGaCs+kgH+v5xkftpfajLXEYBgjz7J/8TN6qS3/0Z1Yi5QOaZDxChkssy8y2KyVoMkW4tQw7so99lhiHbcotkx2gr23wnX6xTOvdPixMQg4YMVYPXMbdoykZ1eQpI0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTENy1AJl/+CBizYaf5ouvz9IXNSfxbc3onxu5LWqUs=;
 b=xqUj7kADdXiCYp/cAaNo0/j0dGvFl21Cazt9XmfG+4frFFyLTwr+F6fx0h9Ir/F7K20iraruKAeyrmDp/C2rEQQOM5ZVJbE1XfQVJdr4vbJpuXj8rA2jGUqFKxU1LW1EP8TjvRoiot+oeS+z0nhRL3yP9x9OMCg4V04jpJlRHqi3OtBOTibhRmThBCc30VkVwpqyEZPWqB6jhOPbxbbkqLAWwt9mOaBPo9MjLYtyETN/9ZiHnL8O9WkiuX0QnaJDYvYpmYQUsKwVErNTRm78IcHimTf+Jt1CLFQYJfwoXqUWyT3bR61AV2UJCUfEcnrkMW+zBETYmcB8sxmUn+DDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from BN9PR12MB5367.namprd12.prod.outlook.com (2603:10b6:408:104::11)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 12:24:15 +0000
Received: from BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24]) by BN9PR12MB5367.namprd12.prod.outlook.com
 ([fe80::68ac:2185:bb07:ae24%4]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 12:24:15 +0000
Message-ID: <6c62ff2c-3050-4101-a7c4-06e9e9067fb1@amd.com>
Date: Fri, 24 Jul 2026 17:54:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] mtd: rawnand: zynq: Fixes and software ECC support
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>
References: <20260702-dave-upstream-nand-fixes-v3-0-3814352982ad@bootlin.com>
 <af5b229e-0466-45cf-9562-434dc0fa383f@amd.com>
 <6a9f0530-ea41-491b-b4f4-f7d03ee2fd3a@amd.com>
 <b22d644a-6d11-4ac8-9a38-82fd8ce5d5fb@bootlin.com>
 <6051fd86-9f84-4a43-9788-1fa07510c4c0@amd.com>
 <1002cb3a-5f11-4d25-93de-f7965256903f@bootlin.com>
 <1d8f89c2-3247-4897-a5a9-76fb4fd7c421@amd.com>
 <a3ca27b1-9100-4de1-864e-4928ea6c601d@bootlin.com>
Content-Language: en-US
From: "Kumar, Love" <love.kumar@amd.com>
In-Reply-To: <a3ca27b1-9100-4de1-864e-4928ea6c601d@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::13) To BN9PR12MB5367.namprd12.prod.outlook.com
 (2603:10b6:408:104::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5367:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: aed41f94-079e-47d4-9045-08dee97e79d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: JdAXfnYJXUOGi7dVvmowJtV91y1FI5tDogNZenTg3g2fER0NE/zLFjYO/qOsFzh531cWQtMq1sI/ZHnuBJD3EqypiT2OxSfz8UaT/j4NaCClNuTKs+3CjwSg9Qf9gNpIjOh4r0/x0RgMD4iagt3vVH5AH7ApVQQK0NwiLRpKNwwh/40B7jGq2pBul31cfhdCE+BuIcfjSfbIJP08a6d2BHtzuco5dRIfDAZ1dnBp3lgmmVUDl/jVCGOnutM7ohwKbk5yMWj11xILE5FzoAKKUS0MB3/UeAil9gTvQinSA0YoEcGOPuXbQJSZdL41Ic5VZSKq+9y/HQ1EBcB0cCUERgVW17wmTURbR577V9oWejS2lY6vtJPG/58sW++JO+DkDMLWZRi6wVUL+KwxVaCx1fv7gGPdc/JjcJ4SwAK+Z18zC5XxbIuRllDjeee6AZjOOckNoPn0TLkPUTi4RQ1SAO3utwU1m79tXlmREtjegcwLqD2V66H0OEaJNg3ty5I1Xz7J0ko3HnWe2UMIW02QM8xeSbatcmunj4Ys4T6Y8qDa9gVUSp6krf2UKtFJj2RctzRJ8mWYvxLE7w6LdyH+3bgIn+LxaxCEKhg4Q9wJ42xZU8u/LhLPXzXweadiBvTLF4HVUBAQyoKolYAQNsq54i5bFlQ6Y+DmFy7N8aTgLhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5367.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEVGdkRKSnRZVG0xVkRac2xVRllCU2M4ZGVJQk9uaTdzOUNkUkhWU2VNQmZt?=
 =?utf-8?B?NHhndHRvWUJVaXBMN2RySG5DMGxsUUloQ2xWN1JVb01wL0l0RDdDRVQ5N3lE?=
 =?utf-8?B?WnVKUGhGbXlTb1RLYVFKbkVXbFkzaXZHQWJXQlNQa2NmUkdMNXU1SDhTMkZ6?=
 =?utf-8?B?eGhuV2xIL2QvdGF2c2NsY2UvKzU3aGpDUVYyZ0JWR1prYk1NY0pzTFdqSWNr?=
 =?utf-8?B?WFEyazBQa1dMNmtPYmlVQWlRaHhtdHBid1pCWTFxS1oxTmF5ajZKblRPcXpX?=
 =?utf-8?B?TnpEdnFkYVlacjRPWTUwdnhFc29ZL3pUaUUybE5MbGxFdUhDb1p0dTErL0tX?=
 =?utf-8?B?ZzhDZzBWV3UwWUxmdXNkU2tRMXp5dVJreTAzSEcvTkV4dUQ0QWl5SWp1WVJ5?=
 =?utf-8?B?enNIRndqdGZJK2hrUUtxMDZKcWo4MTZpbURLSys0QXdqNFpWa2VENW9yWkE2?=
 =?utf-8?B?M0s3SU5lSlBpczFEeHpLeS84OGt3Q3dyRnpCbWtOZWJQa2VmNkdIcm9JNDJX?=
 =?utf-8?B?dUVRS0JkalBEam1JcGlyYnFoZXRiOVc5anVJRDZIVitkWXJxZmlxQUdMWnpU?=
 =?utf-8?B?amdYSUpJUk12YjZCejB5NHkyNDU4TE83VVd3MTlpMnVUR1BiRG9Xc1VSZGNw?=
 =?utf-8?B?c3VuVTRwOTBiL3hrdHhTZ0ZteXArL2JPWUM3Q29LbE9rajg1QkgwZzRkcmxs?=
 =?utf-8?B?QUxWMVJQYnE5U1N6WFFMUEErc214ZmIyRzV4SHNoZGFENUU2b3ZsSzBIbW5m?=
 =?utf-8?B?TjVXcENTeFphSlhpSlZ5dGJhREJFeFl3SUJmR0tub2VCeEZzNGtUVkJRZTNq?=
 =?utf-8?B?VzZVUi9NZmZBdldFYmg1YTNLSlBJVUxIbEVRbGpvYmdrT2ErSzh4WkF4K0ZX?=
 =?utf-8?B?NjdVdnlsdXQ0dzJzVWU1b2I3TS9OMjJTNC9IZ1AwU0JyekFEUW5HWVMwSEsy?=
 =?utf-8?B?YmRESTFpNlFNUGtBT3REL2E5a1Vya3EwRTA3a1oyK0U2K1hmMGxkbkt0T2lH?=
 =?utf-8?B?VHBya2I3RDlwakkwVjRYalVOQTBZVjA3dFl0Vmgwa3dOYWtudjNuTVZmaGpr?=
 =?utf-8?B?YkxjcHl2VWRLZTFsR3VTdFdyMXM0L0puUjE0ZUdWVnVncm5ENDVWcElXMFdy?=
 =?utf-8?B?eVg2ZDRXRU5QakdnbmtqdjYvZ2VhT08xM1h3ZlRudGZyR3g4WHdxQVFmRW81?=
 =?utf-8?B?ZmR5b3VXcXNiZy9FbjhpME9SMExkMisrY1BwekZGRkVObXc2VEs0bFJjaWZx?=
 =?utf-8?B?b1Vvcjdra3pJTE5SM1pna3UrMDY1STlUOGlSK0p0MktHNUZrL3NzcEQySDRn?=
 =?utf-8?B?NCsrMElhaFp0SFBydTNJNVpaNXlONkQ3Q1YxMWpwNTZoNXg4WjJreGFLb1ly?=
 =?utf-8?B?ZWpqdXZjM3JpaHZkaTRacldwOGh2QTN1b2tueHZ5NXNjcTl5STRKNk8zUXhq?=
 =?utf-8?B?N3ZJL2NxZlJ2Qk5sYlgxUXE2R1BwbFpBK1lZM3puYzd5WTVmZXdqd25tNHRx?=
 =?utf-8?B?NTFydFNjSklhVU50bUp6WlB1cjZmSmFZcXhOVWk4VEZiZWs1TjRrRzJaYWY0?=
 =?utf-8?B?ZTRPVWtnZDQ1S1c3b3krcnZBNXRPcEthdm43OFh2cUpQdmFkMGl3My9GZnJq?=
 =?utf-8?B?dlkwbFVTTk9iVVQ2N3BLTi8yREtraS8xd2JPRHJzSGJWbWRmdDR1R2dZUmdO?=
 =?utf-8?B?aHpuUEQ1NXc3aGNuSVpaZzV3MlpHeU83a2luSmJOa2RGb3pHUG9USTFwM0xC?=
 =?utf-8?B?Y1d3c3pLVkErWmU2UTA5QUhzTTJtTUpIZU5KOWxpM0lNNU1STHJYVm9mVnVH?=
 =?utf-8?B?NkdIM0xIc3ZWM01uTW9CRVZ4eFVORDBNSkV3V0FvckdEdUk0YVRGMTVOcDF4?=
 =?utf-8?B?bmtxWUlmUDRCN3NmVmpxZHJuMjY0WmdFenZvRnQvZVd0NG1YSU5nYzJURzZV?=
 =?utf-8?B?UG9UQmN5N3FiakQ1bzh0YzhBUGpSWW5NMURFanllODRiUWtRYVBodmFqNDdW?=
 =?utf-8?B?bFhMcytHUWxFeGJYeS9Ea1A5d1o0bDJKYmhheUZZV3pGdWRVK0NlZUVWSVd6?=
 =?utf-8?B?NzdxMjBlaWVXUFRJbjIxY2ZVcXMrS3NRczY2VXlGVHgxRzAzc2lxdHVHL1h5?=
 =?utf-8?B?NlR3VGVNZEo3Kzl3RldTTmRYYUtNQmMrZWtseFlZcnQ4NUZuMEdFci9ZazNN?=
 =?utf-8?B?VzM3eFNrWklMZW0rdk4wOTF1SG9BeWtXRHloRlZidHRtb0NPTUhkSktsTm1m?=
 =?utf-8?B?M1RTQkpUL3BXbitLL1lwSUhzSmFXc3dyOFRia3JKMjRiNC9DRm14YmxBTDEr?=
 =?utf-8?Q?2DIBtENcwDWo6h30lO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed41f94-079e-47d4-9045-08dee97e79d4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5367.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 12:24:15.6186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6kjcqZExJkNkeLP40+/wOGf/ECAo7kL6xYY9MHY2mwD8lanqGyH9OGKVuDiNxGi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTENy1AJl/+CBizYaf5ouvz9IXNSfxbc3onxu5LWqUs=;
 b=2CPliDxNokHLl7x9fyF3NL12Kz4xviK7oJCsl2K3QoFkopdBzvHuk3RLY2d5y2LQrIhfejkx2Cqu1SgBFXC29LlXWGzm9QVFeHiOl0uk3sCxEQwp9U+VYPX4wh+zd4X3cgWl2S/BvfDNt3pEjuF3HRAdZAbi3IAJWLHWXtOPs1U=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2CPliDxN
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=love.kumar@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="2CPliDxN"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Bastien,

On 7/23/2026 1:09 PM, Bastien Curutchet wrote:
> Hi Love,
> 
> On 7/22/26 2:32 PM, Kumar, Love wrote:
>> Hi Bastien,
>>
>> On 7/17/2026 8:21 PM, Bastien Curutchet wrote:
>>> Hi Love
>>>
>>> On 7/13/26 3:52 PM, Kumar, Love wrote:
>>>> Hi Bastien,
>>>>
>>>> On 7/13/2026 3:18 PM, Bastien Curutchet wrote:
>>>>> Hi Love,
>>>>>
>>>>> On 7/11/26 8:36 AM, Kumar, Love wrote:
>>>>>> Hi Michal,
>>>>>>
>>>>>> On 7/9/2026 11:23 AM, Michal Simek wrote:
>>>>>>> Hi Love,
>>>>>>>
>>>>>>> On 7/2/26 15:08, Bastien Curutchet wrote:
>>>>>>>> This driver is deeply broken in many ways. Miquèl has cleaned it up by:
>>>>>>>> - flagging the most hideous parts (where Micron on-die ECC support is
>>>>>>>>       hardcoded)
>>>>>>>> - enabling DT support, eg. for reading the ECC configuration
>>>>>>>> - fixing software ECC support
>>>>>>>> - aligning the software ECC OOB layout to the rest of the world and
>>>>>>>>       allow a working interoperability in Linux.
>>>>>>>>
>>>>>>>> I then added a patch to fix writes when soft ECC is on.
>>>>>>>>
>>>>>>>> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
>>>>>>>> Signed-off-by: Bastien Curutchet (DAVE.eu) <bastien.curutchet@bootlin.com>
>>>>>>>> ---
>>>>>>>> Changes in v3:
>>>>>>>> - Add patch 6 to fix write issues in soft ECC.
>>>>>>>> - Link to v2: https://lore.kernel.org/r/20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com
>>>>>>>>
>>>>>>>> Changes in v2:
>>>>>>>> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
>>>>>>>> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
>>>>>>>>
>>>>>>>> ---
>>>>>>>> Bastien Curutchet (DAVE.eu) (1):
>>>>>>>>           mtd: rawnand: nand_base: Don't overwrite read/write_page_raw() for soft ECC
>>>>>>>>
>>>>>>>> Miquel Raynal (DAVE.eu) (5):
>>>>>>>>           mtd: rawnand: zynq: Align the layout structures with the driver namespace
>>>>>>>>           mtd: rawnand: zynq: Add comments about very bad practices
>>>>>>>>           mtd: rawnand: zynq: Make sure an of node is attached
>>>>>>>>           mtd: rawnand: zynq: Do not fail the probe for no reason
>>>>>>>>           mtd: rawnand: zynq: Fix Software ECC engine support
>>>>>>>>
>>>>>>>>      drivers/mtd/nand/raw/nand_base.c |   6 +-
>>>>>>>>      drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>>>>>>>>      2 files changed, 32 insertions(+), 89 deletions(-)
>>>>>>>> ---
>>>>>>>> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
>>>>>>>> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
>>>>>>>>
>>>>>>>> Best regards,
>>>>>>>
>>>>>>> Please test this series.
>>>>>>
>>>>>> We are again seeing the NAND write issue with zynq-zc770-xm011 board.
>>>>>>
>>>>>> Below is the log snippet:
>>>>>>
>>>>>> Zynq> nand write 0x80000 0x0 0x126f80
>>>>>> nand write 0x80000 0x0 0x126f80
>>>>>> NAND write: device 0 offset 0x0, size 0x126f80
>>>>>> NAND write to offset 0 failed -5
>>>>>>
>>>>> The exact same command works in my setup:
>>>>>
>>>>> ```
>>>>> Zynq> nand write 0x80000 0x0 0x126f80
>>>>>
>>>>> NAND write: device 0 offset 0x0, size 0x126f80
>>>>>    1208192 bytes written: OK
>>>>> ```
>>>>>
>>>>> Can you please share your device-tree / defconfig ? I'd like to dig into this a bit.
>>>>>
>>>>> I'd also be interested in seeing the output of 'mtd list' and 'nand info' on your side.
>>>>
>>>> I have used the xilinx_zynq_virt_defconfig with zynq-zc770-xm011 DT.
>>>> Below are the log snippets for 'nand info' and 'mtd list' commands:
>>>>    Zynq> nand info
>>>>    Device 0: nand0, sector size 128 KiB
>>>>     Page size         2048 b
>>>>     OOB size            64 b
>>>>     Erase size      131072 b
>>>>     ecc strength         0 bits
>>>>     ecc step size     2048 b
>>>>     subpagesize       2048 b
>>>>     options       0x40000000
>>>>     bbt options   0x00028000
>>>>    Zynq> mtd list
>>>> List of MTD devices:
>>>> * nand0
>>>>     - type: NAND flash
>>>>     - block size: 0x20000 bytes
>>>>     - min I/O: 0x800 bytes
>>>>     - OOB size: 64 bytes
>>>>     - OOB available: 38 bytes
>>>>     - 0x000000000000-0x000008000000 : "nand0"
>>>>        - 0x000000000000-0x000001000000 : "nand-fsbl-uboot"
>>>>        - 0x000001000000-0x000003000000 : "nand-linux"
>>>>        - 0x000003000000-0x000003200000 : "nand-rootfs"
>>>> Zynq>
>>>>
>>>
>>> Thank for these information.
>>>
>>> Have you explicitly enabled the soft ECC ? I don't find the nand-ecc-mode property in the upstream zynq-zc770-xm011 DT.
>>>
>>
>> Yes, tested it by explicitly enabling it with `nand-ecc-mode = "soft";` in zynq-zc770-xm011 DT, observed the same behavior - NAND write fails. Same issue was observed without enabling ecc mode as well.
>>
>> ```
>> Zynq> nand write 0x80000 0x0 0x80000
>>
>> NAND write: device 0 offset 0x0, size 0x80000
>> NAND write to offset 0 failed -5
>> 0 bytes written: ERROR
>> Zynq>
>> ```
>>
>> Am I missing any other configurations?
>>
> I don't see any other configuration you'd be missing.
> 
> I had this error once with ECC-soft enabled but that was because I had forgotten to do a prior erase
> 

I do the erase before writing and getting the same nand write issue.

Regards,
Love Kumar

