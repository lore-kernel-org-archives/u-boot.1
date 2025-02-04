Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB773C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 11:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D34EB800C1;
	Tue,  4 Feb 2025 12:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="osXUOj8D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DF02800CF; Tue,  4 Feb 2025 12:53:04 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72B1E800B3
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 12:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZZbU4+5O97qbABoa5b68QwlbY6IGOMXvtRK9l0yK7XXftWfLhkcnAGM/WL3WuKJECPBpwfzRoyeT+s0NiVg66dsAwi16rqeJtgmeV7oJjaQMLkHiTO0TxLyIOgUwt4hB+ljqco8qbZqP9qiIPFgmuvyreSFI5R9pKYLeBbb25iLFzBdTYLIE/zqQRpb9ZHdOLHjr5FJ3e2zhs2Kjn/9WP2eJ1DJpfOk3wfWaSQpy4kqOuDZo2bBqhoAnGcobTLfcQcYRdlKRFBfLc3SOEpQFCddVYPwcwOE7HPkiU4VUADzwiHCWe722m47m34Iys4H6O139eHceYjfD0nFoOWpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUN6xWOAMSCk5UYv+mgE9HptT0+fMlICiXCyIjz2dv0=;
 b=QI2O4nLKHB+vaSf/THsFnCnitDUKO8rTEvJf6/34EDterfVRM6IA8DPZAYV/iFSfOns2VpMrjRoz0KS/bUhH2eZmzc0g5RRZJZOMdsNdXM2ZPwiXzfuoTRrlxldPjZwovT4r++M61BvcqnarTM3cHc9RQMFrIxsWI073xBUiZl4BT7P9wVdDB5qmIULW3vxwhz6NHZ8kd7y4VxVkT34OFAzMKM15G36H7jlV5d+0VREoOlS3/eZCRfLLIkjmBmRzIuyWBAPPye7Wfa2WniPy9gOZJMrgQomXuoOZXMPD0L1PUC2oz5abtoXS4g6owpBEEFcw5YUojXGXVTqAx2uwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUN6xWOAMSCk5UYv+mgE9HptT0+fMlICiXCyIjz2dv0=;
 b=osXUOj8DCXHVQDcuLURPcOngAMbRkR+KgkRtfIyJNsVQAV7XvgfxONX8gLls4qfWWfq7yNu3jPd7H7SSwUIacEi8cRsxZHHUybJZOxHLh5vHDfWzsKkIUfesN4zkIGu1guindu501K17ynMCBJt8mcCDJgjZa88f4PMlsmSZ20o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 11:52:57 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 11:52:57 +0000
Message-ID: <b0c9dc17-4229-49db-beab-7a825270be8f@amd.com>
Date: Tue, 4 Feb 2025 17:22:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Fix page permission on arm64 architectures
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, maz@kernel.org,
 trini@konsulko.com, CFSworks@gmail.com
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::28) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc941d2-7e00-4d78-7560-08dd45127731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjM4TjB2ZTIrclloM1dwVVZ2Zi80TkVnR2VMRlg1N052MTJtM0JlRDJkVXlX?=
 =?utf-8?B?RWlMUXd0STlBczZIR0ZMeWIybzE2UlZoVCs2dFFZQWU3aTlxTllvQ1Y4ZUFm?=
 =?utf-8?B?Vk9yRERLR3dkeWkvNmx5WisrVjZYYjVXNWsyRmxkZTA0U3dNNTByUFlqdm9N?=
 =?utf-8?B?bGJrSGhJSzFrSXRYc2pCYUZ3a3lseVphWnRxS0dXVUNMWURndVlQRXA1OU1p?=
 =?utf-8?B?VFIrakpua2oyeUszcFRMeVBHbkRjMHFJWDl4WXp3V1pkV3p3cnVsbWFKdjlX?=
 =?utf-8?B?SlVMZzF1dmZzSXdCZUJ0aklwbjlwT01yL2IraFI0U28wZklCYlpBZmNENTl4?=
 =?utf-8?B?S0ZiVDh0ZzRVNWR6OTRkSnR1N1dLL05KL1puMkR0aUpiQXR6MEJPYU5kUldX?=
 =?utf-8?B?VEFYM3dDYkRiTWpuS2dLMEZtQXdIV05xYjMreHQzenZvblMvMWhETlJsLzJH?=
 =?utf-8?B?SzZ5VCtiaTJ0amVqZUVLVU5VOW1DWUNEdXQ5YVVkZXQyRHYzb3NvVFE1c3JQ?=
 =?utf-8?B?UXNZQ1NZaXZnZk94ZERHTmgrYjF4Mm9GOWd4TGY1V3Z1eTB4VTk3WS9RRHlM?=
 =?utf-8?B?NlFWT0oyK1RNNXhOWmxRM0d3czQwQ2NrZnZueHRYZEtqMUUwazJ0bUdWVDhh?=
 =?utf-8?B?N0RnaUtBOWw1SWJWOE9wMytKbE1UOVU3QURaQUJrNkNmaUJoZ0tIZ21oTWRL?=
 =?utf-8?B?RUZpTDVnTTVvQ1RJcnRkY2JPSVViSlRSZk9LZDdXTU0vV1JQUEFzNDBqalB3?=
 =?utf-8?B?emZhclNWcTZlMFVTck1iSnlVTlo5dTd1QUpkZHkvc3YvVlZMbHFpcmtsand2?=
 =?utf-8?B?L0ZRY3VUaHE5QS9LOWovcmRxQUNYcUZIMmwvb0VudlJzVjQwU21wSUhMTlp2?=
 =?utf-8?B?a3FYK2Y1MUZiKzNXUWpkL0VIMmc5N25hVjRvSTdZektPSmZwTktRUnBKUGht?=
 =?utf-8?B?bXN4b1QrUGh0YlpmQUN6YTM5a3FON1puekMwMVZvMXNKaVBkZm1tZ3U1ZEt3?=
 =?utf-8?B?bXRsMEsya0xxOE5lQzBBSW5HZXM1WExCSlM5V1lqRXNHWGtOMlFVWHBZbHdT?=
 =?utf-8?B?VmJpYytsOVV0UWIrT2g4OEJ6M3hVZktETjdMRSt6RjYvMGxmOGRvUGMxd3Ju?=
 =?utf-8?B?Smt0ODdEMTNtK0M2V2x4WXlzZHNiVTNBTlY5WXB3bU5ETUcyT2ZkY0d5ZXpQ?=
 =?utf-8?B?QXZhRlVScWgyY0JydlQwa1hhaHRwVmpwSmp2d0ZkL0RicGpaT1FnU2NuRm5B?=
 =?utf-8?B?S25HYTlyVURyc2dMdjdIaFdTMTFyOG9qQVA4VkZMVU9NNXJ5V0JQbWhQTjN3?=
 =?utf-8?B?dWQyRmNHUXQ3RmNwQWwzRUxtbzZES01JU0QwMDhodGJkdGd3YzEzRTVZQ2xl?=
 =?utf-8?B?cW4rSEVuK2lEMWhMSENsYWc5RC9qZVJkclhRTkEya3RraTJCQ0dxTjRORUt1?=
 =?utf-8?B?anpoYVN0K0pzNHJGR3pZaHRwUis2aGVmUkcycHNEeTVhd1dWTTVKOWFFZXRy?=
 =?utf-8?B?NDE5WDdCV1J6ZVBVNmVVTytsMnhJYUhnb0VJTzhHcmhkd0NKcVZWYmNlOXpI?=
 =?utf-8?B?emNDZ1NZdnhFVjkzT3U3VnVTMUw5TDFodjFYT0JrK2xQTFlJck52ZFgwVjUy?=
 =?utf-8?B?TFlWWmRyQlova1BsNmdoY3NyZzhza1J4c0pCaWZMakt1L1hOQXI4M0VYOG4x?=
 =?utf-8?B?V0ZOOE9FRkRyWXUrRDhVenA3N3k4aVF6NkwrL09aV3I0TVJmZGxaYkZFMDhE?=
 =?utf-8?B?cXJSaGo3aGxtUWRwNnJQSkdjYm93czhMb2oySXZQSUtNOW14Qk1QQjNqQytr?=
 =?utf-8?B?YXpTYUswYXpid2UzR2o5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW1ocStxVmhQVFZZVm0wT0dFVjVTcFRqUEZwckpFc05IaThuMUlaNGd4MGR4?=
 =?utf-8?B?aUJCbEVTaEFEcTIxOXBBMHZaTUwzYkpTRzUvNjRGeVNiY3JuZW1TVDJvc1BW?=
 =?utf-8?B?OUJ4WkdhQk50NitiVldjaFFQMVVTbjFtMUo5RkRHKzJlSzJBdTFOMUljbHNK?=
 =?utf-8?B?Y0s4aFZjbERDb1J3ekV5RjlvRjJmVVNVRW1teUg1QVh6ODhlNnN2UmJzV2NC?=
 =?utf-8?B?U1U1RTloOERtTUlwNmtoMGNoc2xsSEUyb3Rxdy9NRWJwbUMxaThEOVFOQlA1?=
 =?utf-8?B?RGxWelZwK0JzT3VhazRVeVVqU2FXUGlCbktsMi9ZaTNyK3JBWUkzUHBsZS94?=
 =?utf-8?B?aVNGRkxTUmo0aVZzYmxLa09kNXFLT3R5Yk9sdmx3eFdKbS9YSG55Q2c1TFRa?=
 =?utf-8?B?dzNrNGlFY1JTM1FqaVcwMjRwa29CU0ZBdFFYeE4wTzMrd2pqa3ZyM0xhK012?=
 =?utf-8?B?dzRZcnBTOG9MSlAyRzB6aWR4QjlpbU0rblVYSkFxbDlKVXIrYVRiVHpQWXZZ?=
 =?utf-8?B?Ui91R0YvV0xaUzdmbTFuejRvQUFLNzIya1lTTFdyTGFvVjBYd0xER3NrYTNM?=
 =?utf-8?B?SUJnSjBENEhBelRpMWZXaVJ0Ymh2K1VEclhQYnBQejJuR0M4WHR5STRTY1hG?=
 =?utf-8?B?QStwY29NRlhYVkVjWEFzeU5VOHZkcmhSTk02OUhLZVpRelV2bzkvMXB1SjB5?=
 =?utf-8?B?eDByM2tZQ0JaY3d3UXkxclhOeDlSOWVuNzgxcVRRVElsR096QWcrU1A2VXZH?=
 =?utf-8?B?R2tGQjVzd0dLenJmcVBjRjR1a253SzgxR1hkamlnTEFIbnB4ZGNEVmlRRnc4?=
 =?utf-8?B?MUJRbi91SmdqaHdOWnZWbVBvZmxiUndCNmVvZE1kdnVBTExTSHhGTnM4TDZm?=
 =?utf-8?B?YzlXMTVLRXJMQ2NaZFFNUzFVTnRsZHJFeHlkVmFjYUJEbFlZemh5bCtzQlJY?=
 =?utf-8?B?Y251QWxmZGZvY09WTEFmRHpjV0dDRlZ6OHVjZTMzZXh6c0tSbTBPYmlLNDha?=
 =?utf-8?B?Qm83QlpocE9QTCtPNzllV2RIbE5VUVFpQ2ZYRGtZR3d0bE1mMGJZQ1lyNEJq?=
 =?utf-8?B?Z0JseHNQdDJuMVdZNDBFamxvQUdhYmpnc3R4SnJJLzIra3hZTkIzaVFHc1Bz?=
 =?utf-8?B?QXcvOG81ZkJZTUV3NG92aElxMnlXY1VGenBMOFFKbG1Zc0p4Z0tNTXVBN0Fy?=
 =?utf-8?B?R0V1T2FuY3EvWkZYTjloVVRsUldxYWYvTUhsdVpKSTY4RzNkUGxDbVQ5OE91?=
 =?utf-8?B?T3hBTnFqaFFoL0xybHBtN3J5Y3RiWVNFM3Nzb1J2OU1WakE2UW1teFd6aUI4?=
 =?utf-8?B?bzdWUXlncG1vM1FRbmp1ZWNJS2VXU3NzUDNaK3VHdGpQSkpYT1E1ZFc1Nklu?=
 =?utf-8?B?RGlJSGtpMWdQZ3RESE9MVG1IRGNUdjY3Z1ZEZlFFZlNkb0NWTHN4d1hLVW9H?=
 =?utf-8?B?dG5vRzFvQzFrK2tPUVVWN05tZmsrTElKT05kWjAySVc5Zk5jWlJsK0djMmto?=
 =?utf-8?B?U1VSZThxZU1zZUI2MDNpMml2MmRkVTI4WTVRR2ttcS9QVGI0cG52aE5jdDNO?=
 =?utf-8?B?bUlxSVMzYy9CdkpvQmtWV1lZMUhhS1pJcm5iWXJPSU5vM1RsTmZBdUsyYTRP?=
 =?utf-8?B?SUI2MWdUb3lvSFk3ZTBlbndqSDN4SzBJUndRaE1sYVpzaTROVFNTWVJzUVFW?=
 =?utf-8?B?ajVUeE53VTAvU21JTVEybDJLUURkUUJzWXQxZ0Z5U1B1SUR1bk5QNGV0K0JV?=
 =?utf-8?B?OGhMRm1Wd2hibDI1WEFpalF1M2JoZFR4OEdLSitEbjM3dERjK3ZuVHhEYzFp?=
 =?utf-8?B?cVpsYXp5YWw5UzVmckJBYUNkYkpkSjQxb3JhcHNvTXM3NTcvVW40Qlk2UGpj?=
 =?utf-8?B?RW1uT3FreGQ5S205TTJPSEJJS0QzUzA0RFROWVpHck0zVWhWci9YZmFSL3du?=
 =?utf-8?B?VHRmd3JnTGxrT3AwaUduSHV5ZXR3SE9vNFd5NjMzOFE1WmJ6Q3dBSkx0R0hS?=
 =?utf-8?B?MU1vazVPbWZWS3FPdDhpcWIxSnFRNGNQK0xBOVJSajNLUVhzeWlkZ3BlOHZ6?=
 =?utf-8?B?Y1RoUjB0OE5sNzl6Nm5Md1RsVmQvcGhlaXFZUHJyMUtJTnpRK2VIVTNJelcy?=
 =?utf-8?Q?iMUw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc941d2-7e00-4d78-7560-08dd45127731
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 11:52:57.2162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNfW4AUarhTf8uQgiBrSz0lm8VmBcVIHSCZwxpTfJo6CMjJkHkzTELCz+LJHTXKJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219
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

Hi Ilias,


On 30/01/25 12:50 pm, Ilias Apalodimas wrote:
> U-Boot maps all pages as RWX. Sadly it's not not 1990 anymore and we are
> better off mapping binaries with proper permissions.
> 
> This is an attempt to map the U-Boot binary properly, but leave the
> area we load binaries unaffected and RWX.
> 
> patch #1 adds printing capabilities for page permissions in meminfo
> patch #2 prepares our linker scripts, aligns sections in page boundaries etc
> patch #3 is adding a function to change page tables
> patch #4 sets the permissions for .rodata, .text and .data
> 
> There's a few problems problem in this RFC ...
> - U-Boot has no MMU APIs in place. As a result I just wired up the function
>    changing the page permissions in board_r.c but only for arm64. In the long
>    term we should add an API that other archs can use if they wish/can
> - meminfo doesn't align all results properly (Caleb?)
> - I am not setting the permissions of EFI runtime services section on purpose.
>    Since the OS is allowed to call SetVirtualAddressMap, we need to reset the
>    pages to RWX just before ExitBootServices, so the OS can relocate that code.
>    In arm64 this isn't a huge problem, because we explicitly disable SVAM if
>    if VA_BITS > 39, but other OSes/archs will have a problem.
> 
> # TODO:
> - Long term. Add an MMU API and use that instead of exporting arch specific
>    functions
> - Add an enum in mmu_set_attrs() instead of 1,2,3 arguments
> - Set the permissions of EFI runtime services anbd reset them before EBS()
> - Fix alignment when printing pages & information
> - Add a Kconfig option so the feature can be turned off.
>    The reason is that QEMU CI and some boards, fail because they are trying to
>    write RO pages. This usually happens due to variables being wrongly defined as
>    const, but with the updated page permissions this leads to a crash [0] [1].
>    In both cases the reported ESR is 0x9600004f which translates to
>    "Abort caused by writing to memory" "Permission fault, level 3.". On top of
>    that not setting pages as RO (and only setting .data and .text sections) works
>    fine. So until we find and fix the bugs above we can't turn this on
>    unconditionally.
> 
> # Open questions
> - Is initr_reloc_global_data() the right place to change permissions? Or is there
>    a better/safer place to do that?
> 
> # How to test patches
> - Aplly them an enable
>    CONFIG_CMD_MEMINFO=y
>    CONFIG_CMD_MEMINFO_MAP=y
>    'meminfo' should print something along the lines of
> => meminfo
> DRAM:  8 GiB
> Walking pagetable at 000000023ffe0000, va_bits: 40. Using 4 levels
> [0x23ffe1000]                     |  Table |               |
>    [0x23ffe2000]                   |  Table |               |
>      [0x000000000 - 0x008000000]   |  Block | RWX | Normal        | Inner-shareable
>      [0x008000000 - 0x040000000]   |  Block | RW | Device-nGnRnE | Non-shareable
>    [0x040000000 - 0x200000000]     |  Block | RWX | Normal        | Inner-shareable
>    [0x23ffea000]                   |  Table |               |
>      [0x200000000 - 0x23f600000]   |  Block | RWX | Normal        | Inner-shareable
>      [0x23ffeb000]                 |  Table |               |
>        [0x23f600000 - 0x23f68b000] |  Pages | RWX | Normal        | Inner-shareable
>        [0x23f68b000 - 0x23f74e000] |  Pages | RX | Normal        | Inner-shareable
>        [0x23f74e000 - 0x23f793000] |  Pages | RO | Normal        | Inner-shareable
>        [0x23f793000 - 0x23f794000] |  Pages | RWX | Normal        | Inner-shareable
>        [0x23f794000 - 0x23f79d000] |  Pages | RW | Normal        | Inner-shareable
>        [0x23f79d000 - 0x23f800000] |  Pages | RWX | Normal        | Inner-shareable
>      [0x23f800000 - 0x240000000]   |  Block | RWX | Normal        | Inner-shareable
>    [0x240000000 - 0x4000000000]     |  Block | RWX | Normal        | Inner-shareable
>    [0x23ffe3000]                   |  Table |               |
>      [0x4010000000 - 0x4020000000]   |  Block | RW | Device-nGnRnE | Non-shareable
> [0x23ffe4000]                     |  Table |               |
>    [0x8000000000 - 0x10000000000]     |  Block | RW | Device-nGnRnE | Non-shareable
> 
> [0] https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
> [1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/jobs/1008714
> 
> Ilias Apalodimas (4):
>    meminfo: add memory details for armv8
>    arm: Prepare linker scripts for memory permissions
>    arm64: mmu_change_region_attr() add an option not to break PTEs
>    arm64: Change mapping for data/rodata/text
> 
>   Makefile                                | 15 +++++----
>   arch/arm/cpu/armv8/cache_v8.c           | 45 +++++++++++++++++++++++--
>   arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 +++---
>   arch/arm/cpu/armv8/u-boot.lds           | 32 +++++++++++-------
>   arch/arm/include/asm/armv8/mmu.h        |  2 ++
>   arch/arm/include/asm/system.h           |  3 +-
>   arch/arm/mach-snapdragon/board.c        |  2 +-
>   cmd/meminfo.c                           |  5 +++
>   common/board_r.c                        |  7 ++++
>   include/asm-generic/sections.h          |  2 ++
>   lib/efi_loader/efi_runtime.c            |  2 ++
>   11 files changed, 97 insertions(+), 28 deletions(-)

This patch series is increasing u-boot size by 13kB which is breaking 
our mini u-boot configurations.

Without patch:
text	   data	    bss	    dec	    hex	filename
0	 115632	      0	 115632	  1c3b0 u-boot.elf

With patch:
text	   data	    bss	    dec	    hex	filename
0	 128688	      0	 128688	  1f6b0 u-boot.elf

Regards,
Love Kumar

> 
> --
> 2.43.0
> 
