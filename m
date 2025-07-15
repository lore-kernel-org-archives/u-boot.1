Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F5CC83F22
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 12:41:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84CF82BF6;
	Tue, 15 Jul 2025 14:41:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UfjLHf/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E16882F8F; Tue, 15 Jul 2025 13:27:46 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FEE82BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 13:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhZ7HF5X++ujgrOkLtV7/Zf1fjvgmHs/862SzS1P2cilkfk+TdR0+OaZsC4eeQiepiVGolevjrfifHhdIHbBZqSN4YMzSb6lndoM/i1FbOxV6NrPBfIiZFoWCAmUntn01LRR3t97Lo9E7adoc4cY2tG+q+e1RCQwNvDZmM2UcXWm2jmO7PDif/a3ZJ/dwxd0OwZjzbGyzrt5/NPVDY8imvtu5uBAv3xLevZtaNf4BxNanv7Xt9DhdqyZ7SvEwDrGWkSji1/C4dJc7FNsfjC6mKAiARVzcAqllzkaSTLqCnhURc+ib1myDDo1fygJPhFN9ZMDYyZgKGQYv3wAgvgu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlwFTkkh10jOq6b8UKbquXu9vdS9OzcWAAwVAib00aM=;
 b=NjKhp9l2+7fMUhO9gq+oFdtqxjEPC+zZqGq3SMDioss/MSG2/6GFfcyp2XjZ1c1TjPkFRVWxfM4d3OG0PXowK1lMjNMa2at/pUQti7W+iT1vSjpX6Ly6ExYbjYhORpJdfAG9BbTCVYP+s6jUclVgqWxpzIQyx9yvGbhGtOa+benWJfnJ6Q0G/0E0MjTvVOl0MMfjHf7c4SgRr8viWMkIgl7Rib3PVgq5NI3SfbyMKIlpxA5zTF2Jxq+k99rYIolcI4Z36DMOLqWD0ydK3oyveyHbBWP758M+YCpf1OHbrzWDR0Iit8J26Tz00Lo5E5QtMNlRGDAVYJ1ai+vzEV05eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlwFTkkh10jOq6b8UKbquXu9vdS9OzcWAAwVAib00aM=;
 b=UfjLHf/UyAyZil0U1BKQJandcxjh3GpyBWudnwRiQ+0tkY4D+2lYEBILpxfK55WOh/TGlV3Jub8AkjX8RGv/RI5YiIu0PcRkr92MdR5AsGvw41jZX75E5vn3T0ht9Nga+CW3bEsDF63BOfgwmoBXSTbqaE5Qwz0MeCybDoaAEHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 11:27:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 11:27:39 +0000
Message-ID: <9529db2f-ff07-448e-99b4-65dde605b0ec@amd.com>
Date: Tue, 15 Jul 2025 13:27:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly
 used value.
To: Martin Herren <sputnik@on-the-web.ch>, u-boot@lists.denx.de
Cc: Andreas Schwab <schwab@suse.de>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Bin Meng <bmeng.cn@gmail.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, E Shattow <e@freeshell.de>,
 Green Wan <green.wan@sifive.com>, Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rick Chen <rick@andestech.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250714133345.128853-1-sputnik@on-the-web.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: a67070d7-effd-4e24-d94a-08ddc3929b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkJVQWFHQXFkZGE2ZDVTamI3dmRWNCs0Tmpzd1BrN0UxYm5MT2JKd2ZpSWlM?=
 =?utf-8?B?TFh6dW1MUnRVdDY4UHJHZ3lYZGZZYmwwVVgyYzFhTzhwcXpoU1VLRlhEOGVm?=
 =?utf-8?B?dmJHYWUzVTB3Z1hIU2d0MFpxMGloSE1jKytTcnhjeW1YRjZsaitjaEhEbzFG?=
 =?utf-8?B?UFppTTJmOGQwZkorTEpoUG9WNnROWGV4bUVlejE4VzZLZkRBcUxnc0h4VFVk?=
 =?utf-8?B?UUhlbWg4R3RpNWcvSklLckltYml1Y3EyQ3FPRVl3L1NXd1Z3UEVPc0dibGx6?=
 =?utf-8?B?OURBSE5QRCtzZDNtRXI0SFdMTlVwQ3dlWGJTMFFxcUtEZTZGRWNKa3VYN3c3?=
 =?utf-8?B?d3hqRFBKRG1waU9SdTFWeEVFeGE0RlJOSDBGZ0tqdkZoZmFpUXB3YkNYMzJr?=
 =?utf-8?B?UWd0SDRxRTVBM3BWM1F4djUxTVJRb3hUZWVKVlovZjZuOGtzVWdvQ2hZYytk?=
 =?utf-8?B?UkRiMWNUY0JTeHVVNllxWXV5bjZZT3E2ek5wZktPWXVHSHhEbllsSi8ydmw3?=
 =?utf-8?B?dExoWnNUN0FGSURCTkdNcnVJSTNpTjF1ZnYrU0o5ZzF3Y1hlbzMxMldGc2d2?=
 =?utf-8?B?QVdNaE1uNTFQNVJQMktCekw3bkk4b00yRGN1NXR2dVkyUlQ3N3hZMCs4UHE0?=
 =?utf-8?B?QmtpeXplZ3I1REhBcEZLRVNhVmlza0JXZCsvWXpyUkZBNTJkUCs0UmNSSW9C?=
 =?utf-8?B?SzRCL0hvUEc0M2dnK0hjTTRYeVF0Nmh4VjRMRWhKcnp0SUxMV0lLdm5qNUYy?=
 =?utf-8?B?cS9Hb01VWCtla3k1UHQ3RCttVzA3M0ZMNUpmZWVYd3R3MVgwcXg5Rlgvdkkv?=
 =?utf-8?B?Q1Z1emxuUk5RVXlnSHhOTFFIOEpTTVVidSszTkpqT0swd0FuVDZiMHJMOGJP?=
 =?utf-8?B?b2xuUkFhOTltV09Rb2JCYnF0QnhmYzdISCtoM1NzdVNsSlEvVHV2SVFFTXpi?=
 =?utf-8?B?ZFZDeHlJSG1kcVV3T2M1NElrcmFHUjRibTBwbTk3NXRPeFlJV29DNStpMCtI?=
 =?utf-8?B?M1lISWlQLzN2UzlkZHlEcndIWnk2SkNaU0NRSFhRSlBnZnhyblhqZ283bjNK?=
 =?utf-8?B?WE9rZTdBTmdDZklYQytpcmNqRG9iY3JXQmoyMHpWNUlnK3JJKzZGdEs5R1Rn?=
 =?utf-8?B?UXhzemdxQTJjSFZDT3hiUUk1R0ljTmowZzlWOC9Wd3VpYnYzTkh6QVpKSzZw?=
 =?utf-8?B?a0cwWUlCa2o1M0ZrYm5OUGZEYXpDemFRMDBqd3JnTHc5N3g0d256WnBIN1hu?=
 =?utf-8?B?NmJScFBpWFg4RXNQZnhPMEJuR2JLYTBFMlhMVzYvZlNjL0taR081UE9yQ1hp?=
 =?utf-8?B?QS93by9VOGYxUTdid1ZxSkZYTXNCQjVZdXg0d3g5dTI3ZjdmcWdIaFFGUndF?=
 =?utf-8?B?N0g2VU9WZ2FudEZtcjY1dURkV0p4WVM1djBseWhzckxEendVcFA3MFUwd0g4?=
 =?utf-8?B?TzlqT2ZhZlVKV0MrUTRvQUdnclN3RHJ0UXdiNmpCMVFzdUc0UmdIemZOeCtB?=
 =?utf-8?B?d0dZVm9MVkgzd3F1ek93RnoxbW1LWGRrSWl2aWp5ZVBGQ1BEd0h3MWF3UG9K?=
 =?utf-8?B?UVNUbTlaWnY1Uk9qM28zbXRGRG8ydUJDTkRvd094dXlmT2l2ZnpHYVZvSng3?=
 =?utf-8?B?ZGZjNmZZREZVaWFYZTNlbzdic3p4cG1MTkh6ZkRKUWczNE5WS2JPVHVTUTl6?=
 =?utf-8?B?NzdKTWw1VUpGRHFaZGxDNzYwNzVoVWhZbWtyNW1SbEV6eU1tVjFJdGpZZGRH?=
 =?utf-8?B?OWVCQjRzRHhDRzJLd2hLWkpNWEFkQ1VUbUpPakRTdGFzM0xiSThDSzVtQXc5?=
 =?utf-8?B?aUtsbk1tRW9FQU8rTGJGZVhsazdSR3Z0eExEL1djUUJwbjI1d09kbnkxMVBS?=
 =?utf-8?B?ZXA2ZVcyeWViYW9kU3dPaXdlZG9ESG55d0hQSUtNZ3o2bE5rWFQ0ZGsrWU5P?=
 =?utf-8?Q?QcHj++vNGnE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEJZZzFSdDZ3UDdZQXI0U2tvVmt3QzcwYXpndGJTWktjTmRkMDFyKzJwdW4z?=
 =?utf-8?B?eDFadlgweEp5dTNEYzEvNnZUem11QmlZZFlQTTB3S2g4R1d0MStOVEo2SWtF?=
 =?utf-8?B?OW9xM3hMN20wdzhtdjkxRUNEMzB2V1l0UmxQTGc3MTNtTGs4Zk1vWVY5QmdS?=
 =?utf-8?B?Q2o3OFNNZ0V4b1V4eHVXWFJFbm90NXlBOFpkTzJQWmZySUFxcXZ1ajc1cXBm?=
 =?utf-8?B?Mi9GV1o5bEpJeE10Rk1kREgxTFlUNkdDVkxVUVFOU3Z2UWZjUDZsVlJ4Qld5?=
 =?utf-8?B?VnI5T1R1TVZ4c3lzVGpkS0ZSMXhYVTdhaWpoYVFCM05mdm45RzJkbG5ISWt1?=
 =?utf-8?B?RXIvc0JGOFN5MGE4ZFV6Z3d0ZzhveCt6aVRMbGNBUkcyYTNsclI2cHlxd1lX?=
 =?utf-8?B?WUdUcStvelY4TjdOTG1QNGREcXM4Y2llQjhSMk9DajR3ZXVPbXU1RG82dTdv?=
 =?utf-8?B?ZXA3ZEh4YWRtY1p2UHI2N3JXcHJhTmVUY1M0aWIrY3hWdDJVZkIwVzJZWWNS?=
 =?utf-8?B?Z2RBVC9RTFFzZXp2d0tUTGVUNDJPbnJrc3ZOcUlESHpCRmxWLzNrWDY4SU1C?=
 =?utf-8?B?TXJhcUp4dDlQMXpRY042SEtTek15ZWRyekRra1o0b2l3eE9nWU9lMFRmZ0RS?=
 =?utf-8?B?OG5jVk1tNUxUZ0pOaU81NDJycFBGMWZCWFJwcFpuVGxDeTl4YnNHdm45WlRs?=
 =?utf-8?B?MGdrajlTUnlKV0FDR0lqLzR0dmlEMytXUkpoOGNHQWFPZnh2aVNBZk50TTJx?=
 =?utf-8?B?L0c5UWk0NS9hUGVMWHUzamdlY3NMaU9ZYXZCTGZuY1l3bWl6VzllTld4R2Vl?=
 =?utf-8?B?bktyWlllQWtsR3NtVWZpZkRJMy9RenF6Q0NnSm5SRVIxb2FOSml3em11TE1Q?=
 =?utf-8?B?RnU0YlZrVWtEWjBLc0VpbDZNaTFUUGtnOHFLb2hRU04relZjOFNFQjNjaGFS?=
 =?utf-8?B?OWV4UER2ZDJiZG11L2FwakNZeVVjMkFFZkQzN3prMFFsQ3Q3KzZsUm5XRTFF?=
 =?utf-8?B?Q2ZBMUJ0QTVwb0tnTEEvZlEyMFNzSzR2SzhzTUJ6NzhURjV0VFRwR0F0M1FL?=
 =?utf-8?B?WjhNaDdVSkNGUXQ1VG03bmFhZ2dpNHZyMFV5K0ZKeXl4TnRocUE0SUx6cWtF?=
 =?utf-8?B?RVdDR2ZWNWxQaFFHZFNrS1l5UXhuUm11NEFrSkZ0Z1c3WW51QXVYRURWakRN?=
 =?utf-8?B?dXJDQnViNC9TYzFMZlRLOWRwS1RISVo5b0VvODVTaFhocjQ0QnpFQkRhdEZI?=
 =?utf-8?B?WTRKV1ZrRUVmSVlBdUFJRkNpVml3NlY4dnJta2U4RFM0SThSV3dOSzJGU2Rq?=
 =?utf-8?B?UzJlM1lSU1VBWUluWTQ0MHRIQzBlbTZ0SVU2YXk4TFFEY2t6L2prbndyaHAx?=
 =?utf-8?B?dFZxL1BnOERubm0rSDhFbHVWUDdadjU5Ri8yWlordHJ5eUlUSmo3a0lUS1gr?=
 =?utf-8?B?R3FOZmREaXpLS002TzlRQSt3cWxoMzVIOUxzK1lXaWdtcnphYUd4U3dYSTZa?=
 =?utf-8?B?cWxJQjRKY0tnVXJubkdWVzNJejZtejE2TXdpK0pRWGJsbVBhRUtZNDM5b3FX?=
 =?utf-8?B?SXhZcXVKRkNwVU9uaWNMQ0k1YTRsUlZ3SmpuTE9uYW0zV0lTMnQ1L0srQXpP?=
 =?utf-8?B?dTQzL2prck9RNkxCT0pyRUhlRm5CTFlBK0prZGNVVmFWMEhMSHFFZVdmWnYw?=
 =?utf-8?B?TFg2UW4yT3hxdkJlelZEWk5JUGFSRzErYzBWQU9RNEVyOXB5Z0J5bjhDQlpk?=
 =?utf-8?B?cmhkck04REVhdS9jS0wxMURVWlRCRFpaMUtlcVpDOTJQZ2c5YkR4TmJSalho?=
 =?utf-8?B?eWYyNlVsUXU1YVU0Wnd0ZTA3K3NQcVFvVFBmeVVPWUc4WnFxWkxSdVBWblVQ?=
 =?utf-8?B?bzZBbk5Wb0FRRFFaS3JQNTNQMStsdXV3a1FTMDQxV0xWZmwzQTVabnN5ck82?=
 =?utf-8?B?Q3M1c0R3ZHRqeXBRNFNuNjZnejlGUDl5YW13VEswc3A0eE5LbHhxdTNqQVpY?=
 =?utf-8?B?WHR3b3p1NlVSVXZkTDl6bWlpMmp3NFB4cmQzeXJiQ051UEQwZ3QxbkY3OE9D?=
 =?utf-8?B?a3NKaHhsQjNEbWZDMGNhM0I3SDNBMkZSWHc0eVFuWW9XNGl3a1dUUUVRUlFG?=
 =?utf-8?Q?njAZqYC2vXE9EutU9G5e3APbl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67070d7-effd-4e24-d94a-08ddc3929b51
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:27:39.8067 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kyM2PcFverSrkZwSJ7YoMS/EGAaFI/XwgybOMy7e7hnKBRuCNbSEJ5HZj29irkI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
X-Mailman-Approved-At: Tue, 15 Jul 2025 14:41:22 +0200
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



On 7/14/25 15:33, Martin Herren wrote:
> 
> The most commonly used SYS_BOOTM_LEN for riscv is 0x4000000 which is
> used in 25 of the current defconfigs.
> 
> The previous default config value of 0x800000 was only used in 8
> defconfigs.
> 
> This patch sets the default to this value.
> 
> Command used to get the stats of the used values on RISCV defconfigs:
> 
> ```
> grep -l "CONFIG_RISCV=y" configs/* | \
>   xargs -I {} sh -c "grep -H CONFIG_SYS_BOOTM_LEN {} || echo {}:DEFAULT" | \
>   cut -d ':' -f 2 | sort | uniq -c
> ```
> 
> Changes in v2:
> - Resubmit using another mail provider to prevent mangling and signature
>    attachement.
> 
> Martin Herren (3):
>    riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
>    riscv: Set SYS_BOOTM_LEN default to 0x4000000
>    riscv: Remove default SYS_BOOTM_LEN from defconfig
> 
>   boot/Kconfig                            | 2 +-
>   configs/ae350_rv32_defconfig            | 1 -
>   configs/ae350_rv32_falcon_defconfig     | 1 -
>   configs/ae350_rv32_falcon_xip_defconfig | 1 -
>   configs/ae350_rv32_spl_defconfig        | 1 -
>   configs/ae350_rv32_spl_xip_defconfig    | 1 -
>   configs/ae350_rv32_xip_defconfig        | 1 -
>   configs/ae350_rv64_defconfig            | 1 -
>   configs/ae350_rv64_falcon_defconfig     | 1 -
>   configs/ae350_rv64_falcon_xip_defconfig | 1 -
>   configs/ae350_rv64_spl_defconfig        | 1 -
>   configs/ae350_rv64_spl_xip_defconfig    | 1 -
>   configs/ae350_rv64_xip_defconfig        | 1 -
>   configs/ibex-ast2700_defconfig          | 1 -
>   configs/k230_canmv_defconfig            | 1 +
>   configs/microchip_mpfs_icicle_defconfig | 1 +
>   configs/milkv_duo_defconfig             | 1 -
>   configs/qemu-riscv32_defconfig          | 1 -
>   configs/qemu-riscv32_smode_defconfig    | 1 -
>   configs/qemu-riscv32_spl_defconfig      | 1 -
>   configs/qemu-riscv64_defconfig          | 1 -
>   configs/qemu-riscv64_smode_defconfig    | 1 -
>   configs/qemu-riscv64_spl_defconfig      | 1 -
>   configs/sifive_unleashed_defconfig      | 1 -
>   configs/sifive_unmatched_defconfig      | 1 -
>   configs/sipeed_licheerv_nano_defconfig  | 1 -
>   configs/sipeed_maix_bitm_defconfig      | 1 +
>   configs/sipeed_maix_smode_defconfig     | 1 +
>   configs/starfive_visionfive2_defconfig  | 1 -
>   configs/th1520_lpi4a_defconfig          | 1 -
>   configs/xilinx_mbv32_defconfig          | 1 +
>   configs/xilinx_mbv32_smode_defconfig    | 1 +
>   configs/xilinx_mbv64_defconfig          | 1 +
>   configs/xilinx_mbv64_smode_defconfig    | 1 +
>   34 files changed, 9 insertions(+), 26 deletions(-)
> 

I don't mind with these changes. It is just value which can be changed.

Acked-by; Michal Simek <michal.simek@amd.com> # xilinx_mbv

Thanks
Michal


