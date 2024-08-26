Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE2AC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 09:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A9EB884CA;
	Mon, 26 Aug 2024 11:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vAGkTTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DE958895B; Mon, 26 Aug 2024 11:34:25 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB41884CA
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zz/tGaYjf6uudTi2HlrHJo6dviE/DTLBPkSqvjnbI3Aod3MZdtSzwyF6XT4RzlhMZiHIkPBSqOjlQDGu6P0QVSOE/9V7O+ALki+dbUF5Z2q4Tg1g6h/UAZz5okHr19D533UBjiNtHmC9dKaia67djtaeVI6M5Yzq7MNj5eiBw5rFSm1Ytdnq+oUH5vg2mAh5ov3hSki5tPaSgIkuX/i9SA5JMxAtmYNbtyk4bmD6G59tV3JJCNoGiTE+rbIPHDMLCiwtZJEl9xoaTBjwu2529vFgbePfT/RUXDUba0OPjdcawU0DgMnU6ekWje0fnXPhFT18wADY9t5YwyyHdjh9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTAuEZz2a1nQEATd2h5mNrGTJSxAcOvdFiF4cKSVThw=;
 b=YMibZfV5lBrFGJhuXNwlnkC8b8kydzORJpMvasLDzwF6t10IudlitJBFaDHpAFRfFgu4UM/2Ql/3bM34gH1S6uwWSwtMEQlMxTw9pLgZ6i+Nws7AkRoh7Gm/0B+4Euu1oLDz9j33Q2QAVGaBKkYC9TY8LbkH837eYmoOcYPgi5bQcWbtbe3ddyTA/dNhLg2lexbeh4KwdgKiVQmP7kallHgHqIgIVn9gSB2Vx6WieOJXP1Q8P5xadLmpDR+Q4ial97Tk30PEoz0pL5juTEZMVI+eoy1Jkzu39T0+Q/LNMGfsaE57IqQhmRD6mslkJcDp2EAoL7NnVQnMt2cLS9Mzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTAuEZz2a1nQEATd2h5mNrGTJSxAcOvdFiF4cKSVThw=;
 b=0vAGkTTMCC6O6wsNBPdZqkoxLW+yqpBz+kFIXjzw01viGP9XDEpK9BJ47VsrmMMqDdHtMBcFiTne5viorXpbgoozXKx+QQAMPl80ZmFU9duhUQcFmSTVdGQNRe8lw1hADqJtGJSA6oNrL5PHLEKs3c0yElu7kbrldxqgg0YdCqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Mon, 26 Aug
 2024 09:34:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:34:19 +0000
Message-ID: <8902ac79-9aa2-4363-8f9c-486c9ff52356@amd.com>
Date: Mon, 26 Aug 2024 11:34:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] smbios: Refactor SMBIOS library
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Jonas Karlman
 <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Alexander Gendin <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-4-raymond.mao@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240816154658.1866186-4-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0224.eurprd08.prod.outlook.com
 (2603:10a6:802:15::33) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b95c7a1-3bf5-4b98-9bd2-08dcc5b242ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1o0Z0NlWkUrSXZLMEtRc3I2ckJZUVhySFROWE1CdmlYQVRCblFtejM4WFAz?=
 =?utf-8?B?Y2pTd2dVVGhhOUMzcUNyakN1VkEwRkxQbldIREd1NzVyR3FvZ1QvbmFnZUs2?=
 =?utf-8?B?Yld5eW1hMTJBTHRZVGwweUdwU3RvTURidjNwaTZVU0dQaDBnL0FveU5Ja0hz?=
 =?utf-8?B?dnBzeWY5eFZRYUJ0UDBheEVkTXU2d1Q1M2d5TmhPSC9uVXYvektadlBtMXN4?=
 =?utf-8?B?cDRyYWNoMWpTZ2FBOEFrNnBrYlo4T0lreE1BelVDcFNzaVBtbVluczlISWRC?=
 =?utf-8?B?czJ0dnFQSTl6YzVzekwzQmlYaVU1RTl5KzE4cjhvSHZnMVM2TjR4NVMvSGdt?=
 =?utf-8?B?RUp3R2Zxb3p5NjdwTk1tVEdOcHpBdW84SEU2MWdjbjJucUJzU0Nic093NjA4?=
 =?utf-8?B?WkZ2T0p0dFdrSVlFcVlvL3A1YzJRamRtNFFzREl3ZUFCdjQ4V1pIcWY2ZXpa?=
 =?utf-8?B?WG9RMllvOExkTE5LWi93YjNyNk5rd2poZ0U1RFV5RGRJUmVRTS9wdGlJWDB4?=
 =?utf-8?B?SXpiSlRxWDhtbzhRS1R5elBvUlliUjhqZys1dXlPcVR4WXZJVTF0M08rSnpm?=
 =?utf-8?B?anUzZ29DRWZoTXk5Tm8xZWM3a1hKK3VTZmMrMnRMbDNCQzNpMU9kVDRWU25J?=
 =?utf-8?B?SjZmNnoyNzBXK1VyL0krM2ZkS01MUXNyQndrQWxXcXZjL0M5QzBPdFBpOXJ1?=
 =?utf-8?B?Z0k5UzRSbGluR3BRcnZQRjVsNXB5cFlYaFRuWmhQWU1xL3puMVdNVkFHbUNk?=
 =?utf-8?B?VXlYZ0t1Ti9KUWNadGlWYmxkSS9LMmZLV0tWM2loaG8rY04vNGlRVHdIK0ZQ?=
 =?utf-8?B?MUIrODhhUlRvRExiSklJZ2s4SnJHY3B1MTA1MEJZZ09haENlTi95aXVOSUsy?=
 =?utf-8?B?c1Rua20yZjkyV3lpQW12dUd0UlF4T2FYbUNLb2NXcThCNWNlUVRuZFlvbDEx?=
 =?utf-8?B?TFRHN3hUWDA5Z2dpcnNHTllYMjMvQmk3cEx1TVo3Zi9MZXg4d0lhS0M1dDlk?=
 =?utf-8?B?TDZGSGJqSlRKVDJMY2RSUGlxTm1yeWRJMGZJY0dIamdJN2ljb3M4ZUJlRHg5?=
 =?utf-8?B?bUNsRkxKanRBQ3NNdkpuWFkvM2l5cktFY1lZRmhHWGZiQVJ0MG05eHN4QzQ4?=
 =?utf-8?B?RERNalp3d2F0d0pQclcxeG9mc1RabmorL1dIQUVMY3pzV1RXVFpjd056ajZV?=
 =?utf-8?B?Z2dYeVBQbndoUFNDZE1veTBhUDk0aGhkRUVlV2cwK1V3THVsVXJubVR0K0I1?=
 =?utf-8?B?VVJETUtqUm90QUF3RzdLNUpScEEyV2dvMDdrVWV6TXd2T3IvVDRqdTNkVEdE?=
 =?utf-8?B?WXR4STZheXBvMVVmRXZVRllzM0M5c1BzVTl4blNFeGttTmltYnpnNHpoT01h?=
 =?utf-8?B?ajZ3S1ZJUGNrSkVEMTZRVUVyV0dkTjFQUXYvNGJWRURFZlRuZWxtakpTVFBY?=
 =?utf-8?B?QkkzOE4rTW8zblh5RFk4RldJVk9abWU4ZjJFcS9nazRXZlZvQ3J1WUpaR3E5?=
 =?utf-8?B?OGpkczFFT091a1pMUzltVFBKazBrbTVkQTFKdHgrRHdFbW1qWSsvYlJkUXdW?=
 =?utf-8?B?QzFXUkdYMGRjQjlyWDNINWRrTkk3UnlZQzJ4NTRUdnZRWlhnSkxNL1hJVzIr?=
 =?utf-8?B?NmRVUmhGcFhnT2h0QzEwc2Qzd0dCdS9STnlZdmVWb0J2VkdYWTZ0Mzg2c3Zj?=
 =?utf-8?B?enZ0UjNmbmswT0JvYURpQWcxU0ErbFpGNjUycXBQZEZHU2k0Si8wWU5zckJR?=
 =?utf-8?B?eFRLVE9yTFgvTmNJS3ZJMExNMGo3Wld4VC9JOXR6bTNCY0hKM2VCbHg5OVIy?=
 =?utf-8?B?OVhlRitHLzBzT0hQY2htQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STdHeUhleGNaOXRPK2k0eS9paGY4aW5pSm9tZERZem9RR3c1azh3R2djT25J?=
 =?utf-8?B?NmM0SGF6N1lrcGhyeEpSaTFjaUczQTJQSTFEL29KQjhISjhmb0RRVW8zR3Rq?=
 =?utf-8?B?bDl3MG9iZHk5TFlHb0NEYUM0VXhCcEJRa3o3cWJFcmNFY21OTnF4bmc2WVY0?=
 =?utf-8?B?RlNpZUhkZmhXVWZmQ0lVT25GcDN5SXRPMTFhVENPWGN3SzRweG1kQU5NSGUz?=
 =?utf-8?B?YTBzWXVHUnBuQUJKcHJiNDh2Mll4bXlRUGxQZm5nZlh6NHJibGpSU0cvaEtX?=
 =?utf-8?B?aDVlUnF2YmIzYWsyRzcyQjdFOFhOQTZDQXZEWFZYUkptREwyZVlGaVpZaG53?=
 =?utf-8?B?V3RWeXEzQzNhclRSNFhaL1Fwc0RwajBDL3pCd21sem9ET3k5QVVXSWVKcVRI?=
 =?utf-8?B?NUsyeW5GR0hibGNybXp0L1Q0WjJuMjJBWW85cER1M3hHNllTanovNGRRd09S?=
 =?utf-8?B?cG9aR3FyZ3dXOERDN1RweEFaVU5NUGZMcmFRNmZxY0ZmK0dxcnNCRGtSa244?=
 =?utf-8?B?RUJLNWxNdktyNDVOdkRiMDM5RFRYdXUrR1hBa2NzOUU0c0tLTUVhbTdQd2ZS?=
 =?utf-8?B?U3ZFekZNUWJBYmJSRHhqS0svSUN1WTdaZnphMXJPdjhsak5GbFRyeUNvWkI2?=
 =?utf-8?B?SktITmlwczZhYmFvSk02U3RTQnRtY1ZBNERUL1B2MUt6Y3hNRHNIOEg2RGF5?=
 =?utf-8?B?S2tVbk9aNncwT1o5V0sxWEsxT2J4RmQrOVpQV3BNZXMvY3FUbk5Cc3hvZDJy?=
 =?utf-8?B?UE1DbXh1ZDFJVE5DSWV5bFE4cUxIcERMTDFCbTUvdnl1R0J3TSt6MkxDWVVN?=
 =?utf-8?B?YUxHUmk3bDZTL0ZtSGRWd2xRRkF5dUQxaWJ0VVI0Uno4OUVaYTJEdGNidTBN?=
 =?utf-8?B?UWpaOGlseXh2eUJpa25zZ1ZGWnFpOTFrK0hwR0YxL1d4czI5UVVwbTd1ZWJv?=
 =?utf-8?B?SkU1alhUNlFlbVdOMmY5OGNPNlFBTXJRMmZ0ZCtGSXpJLzVZaElJdkVSOEV0?=
 =?utf-8?B?UEVwc1NWZkwrL2NlaXVtbkdJaTJaT2RyYlNqM0NxYjNTY1RCQ251RUl3SzBY?=
 =?utf-8?B?NDNiYVllTCtiajNXdWdlYnhlQWI4RklYaU5JVVdHK0MrcWgza1ZZVFFtVzRB?=
 =?utf-8?B?K0JSWWZQZjc1czhLZTVML01kRkVqOWwwMzZSNDF0NGpTWEg2U1E5VVl6WElm?=
 =?utf-8?B?c0J2UnZYTDVIOGZSdkYrZ1c5YmI5V0lnWVFXUE85TzhFTXB1VG10b09DUmxy?=
 =?utf-8?B?YzB0THVyZDNSY3ZHUFZtVjJwVElJUHRMYzIrTG5BYzRCY2JGM3NudUhBaGMw?=
 =?utf-8?B?dS91M0xBY3BJMnNxZDRhT1Q2MjRRTE5SdHNCeCtEMXNOeW5OSVlIdEdTa0hl?=
 =?utf-8?B?WXBUREdsZHZNWkNYNklEWXpLZ3F1U1lNUVIxSUZST1gzY2RxYjgyUENMcGpK?=
 =?utf-8?B?SkpIN3Y0dUJ5WWgxK1ZMQmlPaFV1eExIMFNKdFNKRkpUdFhRa0t4aytvVFlZ?=
 =?utf-8?B?Wko4MjRNNlo5ZGg4dUpZeG9neTY2WW13NE1GOXg4MXIvVStBcnJ2RTBLdnh3?=
 =?utf-8?B?ZDN4V1dFL3NRdTI4WVJwWjdHVk1wc1c0aHZyVk1YK0RmTFVZRjN3Vy9sN2x1?=
 =?utf-8?B?MFQ4SHFZZXk2SmtJc3pLR21QdFN6NnhwMzFxM21jOHg0VG9OczRTNG9JMFBt?=
 =?utf-8?B?MTI1UTA0ZFRpZG9EbzRqMENEaURVcFVpTlA1QmsxbzlVRVRYbzNmQmFUQlIx?=
 =?utf-8?B?eXI5VXQzNkpwSmFvZ0J1d2txRTZ2REoza3BNbDBZdytOdDcxSjlDMUN6K0RD?=
 =?utf-8?B?Z05rYU1lbDJTcGhlc0ZoZEVQbFRFS1NpVVREZDNybkZYNDg1VGU1RjdRcFV5?=
 =?utf-8?B?RHVDam01OHEwNjBHM010U2luN0k2RFkzdzYvdTMyb0F5VDE0ckhnV2FmOWl4?=
 =?utf-8?B?emJJZFU0NnVtcXMyNk5FbnlkQzNRazg2aVN6Q3ZlSkMzM2tBUGZVeE5vZG04?=
 =?utf-8?B?TmNaR1UzV0orOHRZQklwOFRsSTZpSlMzcmd6bk9aa0IyNmRDRDI3RUlndWlT?=
 =?utf-8?B?dmVHdnRlNlNRcEJtaWxtbUIxOGZVaVVUY0NodUpVRFlXM0ZnWkVoajV4Yi9G?=
 =?utf-8?Q?jRWNrEzxjHm/uGaS9EJPsCyIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b95c7a1-3bf5-4b98-9bd2-08dcc5b242ae
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:34:19.4121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L67PrnoZR5Tpl9OKNzGdshO2X344ikvxkKKcIUn9m+vXPuQYRToIw1n/RIm+02BB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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



On 8/16/24 17:46, Raymond Mao wrote:
> Current SMBIOS library does not fully match to the specification.
> It hardcodes values instead of exposing values from the device.
> It does not support dynamic length for contained object handles
> or elements and misses the handling of a few fields.
> 
> The refactoring of this patch includes:
> 1. Expose values from device via sysinfo interface.
> 2. Replace smbios_add_prop with smbios_add_prop_si to allow getting
>     string values from sysinfo.
> 3. Add smbios_get_val_si to get int values from sysinfo.
> 4. Use sysinfo_get_data to get data area like contained object
>     handles, elements or processor id.
> 5. Refactor SMBIOS cmd print functions to match the command output
>     with the specification
> 6. Add new print functions for Type 0, 3 and 4.
> 7. Miscellaneous fixes in SMBIOS.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   cmd/smbios.c     | 268 +++++++++++++++++++++++++++++++++--
>   include/smbios.h | 116 +++++++++++----
>   lib/smbios.c     | 358 ++++++++++++++++++++++++++++++++++++++---------
>   3 files changed, 632 insertions(+), 110 deletions(-)
> 
> diff --git a/cmd/smbios.c b/cmd/smbios.c
> index d3bd8b12a67..8e2bf46a09c 100644
> --- a/cmd/smbios.c
> +++ b/cmd/smbios.c
> @@ -26,6 +26,71 @@ static const char * const wakeup_type_strings[] = {
>   	"AC Power Restored",	/* 0x08 */
>   };
>   
> +static const char * const boardtype_strings[] = {
> +	"Reserved",			/* 0x00 */
> +	"Unknown",			/* 0x01 */
> +	"Other",			/* 0x02 */
> +	"Server Blade",			/* 0x03 */
> +	"Connectivity Switch",		/* 0x04 */
> +	"System Management Module",	/* 0x05 */
> +	"Processor Module",		/* 0x06 */
> +	"I/O Module",			/* 0x07 */
> +	"Memory Module",		/* 0x08 */
> +	"Daughter board",		/* 0x09 */
> +	"Motherboard",			/* 0x0a */
> +	"Processor/Memory Module",	/* 0x0b */
> +	"Processor/IO Module",		/* 0x0c */
> +	"Interconnect board",		/* 0x0d */
> +};
> +
> +static const char * const chassis_state_strings[] = {
> +	"Reserved",			/* 0x00 */
> +	"Other",			/* 0x01 */
> +	"Unknown",			/* 0x02 */
> +	"Safe",				/* 0x03 */
> +	"Warning",			/* 0x04 */
> +	"Critical",			/* 0x05 */
> +	"Non-recoverable",		/* 0x06 */
> +};
> +
> +static const char * const chassis_security_strings[] = {
> +	"Reserved",			/* 0x00 */
> +	"Other",			/* 0x01 */
> +	"Unknown",			/* 0x02 */
> +	"None",				/* 0x03 */
> +	"External interface locked out",/* 0x04 */
> +	"External interface enabled",	/* 0x05 */
> +};
> +
> +static const char * const processor_type_strings[] = {
> +	"Reserved",			/* 0x00 */
> +	"Other",			/* 0x01 */
> +	"Unknown",			/* 0x02 */
> +	"Central Processor",		/* 0x03 */
> +	"Math Processor",		/* 0x04 */
> +	"DSP Processor",		/* 0x05 */
> +	"Video Processor",		/* 0x06 */
> +};
> +
> +static const char * const processor_family_strings[] = {
> +	[0] = "Other",
> +	[1] = "Unknown",
> +	[2 ... 253] = "Other", /* skip these definitions from now */
> +	[254] = "Refer to 'Processor Family 2'",
> +	[255] = "Reserved",
> +	[256] = "ARMv7",
> +	[257] = "ARMv8",
> +};
> +
> +static const char * const processor_upgrade_strings[] = {
> +	[0] = "Reserved",
> +	[1] = "Other",
> +	[2] = "Unknown",
> +	[3 ... 5] = "Other", /* skip these definitions from now */
> +	[6] = "None",
> +	[7 ... 80] = "Other", /* skip these definitions from now */
> +};
> +
>   /**
>    * smbios_get_string() - get SMBIOS string from table
>    *
> @@ -92,6 +157,32 @@ const char *smbios_wakeup_type_str(u8 wakeup_type)
>   	return wakeup_type_strings[wakeup_type];
>   }
>   
> +static void smbios_print_type0(struct smbios_type0 *table)
> +{
> +	printf("BIOS Information\n");
> +	smbios_print_str("Vendor", table, table->vendor);
> +	smbios_print_str("BIOS Version", table, table->bios_ver);
> +	/* Keep table->bios_start_segment as 0 for UEFI-based systems */
> +	smbios_print_str("BIOS Release Date", table, table->bios_release_date);
> +	printf("\tBIOS ROM Size: 0x%02x\n", table->bios_rom_size);
> +	printf("\tBIOS Characteristics: 0x%016llx\n",
> +	       table->bios_characteristics);
> +	printf("\tBIOS Characteristics Extension Byte 1: 0x%02x\n",
> +	       table->bios_characteristics_ext1);
> +	printf("\tBIOS Characteristics Extension Byte 2: 0x%02x\n",
> +	       table->bios_characteristics_ext2);
> +	printf("\tSystem BIOS Major Release: 0x%02x\n",
> +	       table->bios_major_release);
> +	printf("\tSystem BIOS Minor Release: 0x%02x\n",
> +	       table->bios_minor_release);
> +	printf("\tEmbedded Controller Firmware Major Release: 0x%02x\n",
> +	       table->ec_major_release);
> +	printf("\tEmbedded Controller Firmware Minor Release: 0x%02x\n",
> +	       table->ec_minor_release);
> +	printf("\tExtended BIOS ROM Size: 0x%04x\n",
> +	       table->extended_bios_rom_size);
> +}
> +
>   static void smbios_print_type1(struct smbios_type1 *table)
>   {
>   	printf("System Information\n");
> @@ -99,38 +190,180 @@ static void smbios_print_type1(struct smbios_type1 *table)
>   	smbios_print_str("Product Name", table, table->product_name);
>   	smbios_print_str("Version", table, table->version);
>   	smbios_print_str("Serial Number", table, table->serial_number);
> -	if (table->length >= 0x19) {
> +	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V21) {
>   		printf("\tUUID: %pUl\n", table->uuid);
>   		printf("\tWake-up Type: %s\n",
>   		       smbios_wakeup_type_str(table->wakeup_type));
>   	}
> -	if (table->length >= 0x1b) {
> +	if (table->hdr.length >= SMBIOS_TYPE1_LENGTH_V24) {
>   		smbios_print_str("SKU Number", table, table->sku_number);
>   		smbios_print_str("Family", table, table->family);
>   	}
>   }
>   
> +const char *smbios_baseboard_type_str(u8 borad_type)

typo board_type


> +{
> +	if (borad_type >= ARRAY_SIZE(boardtype_strings))
> +		borad_type = 0;

newline but is 0 proper here? It means Reserved. Shouldn't be Unknown?


> +	return boardtype_strings[borad_type];
> +}
> +
>   static void smbios_print_type2(struct smbios_type2 *table)
>   {
> -	u16 *handle;
> +	int i;
> +	u8 *addr = (u8 *)table + offsetof(struct smbios_type2, eos);
>   
> -	printf("Base Board Information\n");
> +	printf("Baseboard Information\n");
>   	smbios_print_str("Manufacturer", table, table->manufacturer);
>   	smbios_print_str("Product Name", table, table->product_name);
>   	smbios_print_str("Version", table, table->version);
>   	smbios_print_str("Serial Number", table, table->serial_number);
>   	smbios_print_str("Asset Tag", table, table->asset_tag_number);
> -	printf("\tFeature Flags: 0x%04x\n", table->feature_flags);
> +	printf("\tFeature Flags: 0x%02x\n", table->feature_flags);
>   	smbios_print_str("Chassis Location", table, table->chassis_location);
>   	printf("\tChassis Handle: 0x%04x\n", table->chassis_handle);
> -	smbios_print_str("Board Type", table, table->board_type);
> -	printf("\tContained Object Handles: ");
> -	handle = (void *)table->eos;
> -	for (int i = 0; i < table->number_contained_objects; ++i)
> -		printf("0x%04x ", handle[i]);
> +	printf("\tBoard Type: %s\n",
> +	       smbios_baseboard_type_str(table->board_type));
> +	printf("\tNumber of Contained Object Handles: 0x%02x\n",
> +	       table->number_contained_objects);
> +	if (!table->number_contained_objects)
> +		return;
> +
> +	printf("\tContained Object Handles:\n");
> +	for (i = 0; i < table->number_contained_objects; i++) {
> +		printf("\t\tObject[%03d]:\n", i);
> +		if (CONFIG_IS_ENABLED(HEXDUMP))
> +			print_hex_dump("\t\t", DUMP_PREFIX_OFFSET, 16, 1, addr,
> +				       sizeof(u16), false);
> +		addr += sizeof(u16);
> +	}
>   	printf("\n");
>   }
>   
> +const char *smbios_chassis_state_str(u8 state)
> +{
> +	if (state >= ARRAY_SIZE(chassis_state_strings))
> +		state = 0;

newline and same as above.

> +	return chassis_state_strings[state];
> +}
> +
> +const char *smbios_chassis_security_str(u8 status)
> +{
> +	if (status >= ARRAY_SIZE(chassis_security_strings))
> +		status = 0;

ditto.

M
