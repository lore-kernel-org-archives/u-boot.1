Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2136C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 05:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 191E788755;
	Fri,  9 Aug 2024 07:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E0JmhoSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DB1188BA6; Fri,  9 Aug 2024 07:54:17 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE51488702
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 07:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNQHi/gGXWFrZHhBaBPGqOSHK9O2fK0OgP6oXizUg4qo94SknZPAQODwQDflOw1xYoOEeTYnkROYMJddgtx0qohQDURm5qdeH2k8U/prl0Xi0uUFVRdHc9tUM1+owpnHwpZpac3d4t774derebhhTA4cElyb8TOraNz3OnBXfKF2uR0rxCl7P6NxADxtahkuzf7HJJiuv3gEDE2uyMZvxRp66mRumGWDkJ5BCrRw7cW7a3XBUphFGmj/Z0kZLfWRX5tKkBBROl+v63LkmTg3yaL+5TD6Cw3UqJvExUFHc+hRcERLrnABb9jzZgPbZ58+ZMmo4goAB8UW4hZHyX5xFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USDfaTB1wLdZUIomIZvViO0quDen00G7thKLFLP0QvQ=;
 b=d7gX1Ti1sCx8uk9riU22Kl5n+3IMqJdZbq9Eb6c7J0W56ijpjcbm31ChSJXlY4AD2jbPTQQVueG8Q9YRYN/J71cPlgU6N/hD0JZZwdplCB700VEWeNVO4Wzk3ogkfNJQaaC/u/IwrueLZYX7Z3UB9iN/SmqLAg0ejXTheQRSxp/iPGlyLNvzN1laoqoPwf1KxF6fUU/tzxW5lElyf8xSor+n3xKSmzRYgJg5eHNBNCxDgbgPie7ZGFH2GenNzBBFS0FVvd9OPBK0G099Be4Pgl5UURWKYxGdsd5cWE6YWUt861o9MUxgsTR+6tNepsoO6pL/q2lJORIUMxQ6MPD0Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USDfaTB1wLdZUIomIZvViO0quDen00G7thKLFLP0QvQ=;
 b=E0JmhoStvI+7dkuiGTFt+GzQJDfTcojtViYLmvED+L3ViouBmTafANg5hJQfJllT/E0vc/OvIDOZ5rxftB7DyrVepOBTMYTB/dtn4B+C+l9HuSnEv25ZAEgMcrMFQbcc3ESQKgdXdiS+dyYx6fARQczTuEHGOeGQdPq0PvUcfGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 05:39:18 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 05:39:18 +0000
Message-ID: <59d3c644-350a-4325-8e64-c14f6649a60f@amd.com>
Date: Fri, 9 Aug 2024 07:39:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Simon Glass <sjg@chromium.org>
Cc: "Kummari, Prasad" <Prasad.Kummari@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <CAFLszTgAiRBih1JOtqvBEi8QbVc4-yV7Mq3kam=_FRgw58mtjg@mail.gmail.com>
 <SJ0PR12MB66851EC7FDDD9A61A63E4DE982B82@SJ0PR12MB6685.namprd12.prod.outlook.com>
 <CAFLszTg9VemEeiHkOzh+jnQ84y34V3A+EPU2_YaOJgZwhn=7GQ@mail.gmail.com>
 <9aaf2326-2339-4d9a-b5b8-c5115e844599@amd.com>
 <CAFLszTgHsgJ6hP3FjLicHoiMAh--OCFLJtSUCVWiCukDBczoCw@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTgHsgJ6hP3FjLicHoiMAh--OCFLJtSUCVWiCukDBczoCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: cb94fe58-8650-4545-8ed0-08dcb8359cd5
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1ZoWFRTZ1NHWlV2Ty9DMEcybEVSN3M3Q2V4ZXNsQThGR1VzWmliRU5iaUx1?=
 =?utf-8?B?K2p1YTdIc3ZVUGhkcHZpTERKbHhSZXhxbFVIVndhNnFJSCtoVDBwZ0Q0ckJM?=
 =?utf-8?B?MnlNaHorTUI4UEpYSEFzS2ZMOG9JY1QrdjdRdnEwSkMwOGg0akIvNGVEZncz?=
 =?utf-8?B?TlZVS0FJaFo4UWVBRDd4MGlrRWVGQ3B3c1IxdStjWVp3Nm1iM0hBeTFoMDRG?=
 =?utf-8?B?bTRrK1VWVkZoVktIVllMd2tLT0VyNU1ENTdRbzdNay9xaEp0OVpnZFRyNGVD?=
 =?utf-8?B?TXQ1dWVGL3dWSTFPYTd5VEtPWlFGNlQ3dS9pdnZSaWxKZ0Q2SElqRnhFNEo3?=
 =?utf-8?B?TzZWa20zZVcvblR2aTBMQkYrT1lMM3VJcFFYclBtS1oxYWt4K2xxQkROWjhE?=
 =?utf-8?B?UnhtRUxSWTFEa3JkRzBiTVJmMnVGZy9Tb2xBUXh3czh0THNGMDhhUmFna1hK?=
 =?utf-8?B?blNzWDlCc3ZEZFRPREkwcW44ODFWU0I2UlRjZ0Y4UW42UWlUUXBablpKUzRh?=
 =?utf-8?B?QnFQaUhrVFEybzRMRFltcWszNjFSblVkVlNxUUdaMjhLdEZTVjQrOWhZNWYv?=
 =?utf-8?B?UHFuMFhTaGxETlVrMG5RT3RLWjFXNC9qV0ZuQTh0WHNrNXg3Q3h6V3lFN0Rt?=
 =?utf-8?B?Kytwekxwc1I0UE1BRHVXYmZvSlpzVVZ3Sk0xRmFmZGFmVmtFY2I3UjZ1TklD?=
 =?utf-8?B?WllxS09POHhabDZZQkRzS25OZU5vbTRtL1RpRmNuL0dOQXZIaE9rYkhFcjJt?=
 =?utf-8?B?K0g4bGl3dlFDakNGMGFYYmNOV2x2czYzZ05OMW43UkZGenVJVUVtVWswaFVM?=
 =?utf-8?B?T0dmQ3ZibjFHUnBwS2RUTmh2RkRXaXlDeFNsdzFJSEtqZ3hMbStwZUtQd2ZL?=
 =?utf-8?B?anVaM0M3K0gwWitJSU9JL0FDZ3lIRjdBZmc1eVQwWEZoWkhadmQ5ZWNRMm5t?=
 =?utf-8?B?SldqeEhjM2p3Vk84VnF1RkJ5K3pZVzkwSDZYYitaZTBYRUxScXFTUm1qcllX?=
 =?utf-8?B?NVFGUkFiVFdqMTFPcGpDSTBBTVg0V0tPM1VhQUJCT3QrOWVlNDM5dU5xSHVp?=
 =?utf-8?B?a2wya0lEUHhiZmhrejdMUGtxMEtudmtDdERIRzgwQ1RUZ0o3cm1DZC8vQ20r?=
 =?utf-8?B?TGNMMHlZVW1aME5ycC90T3UrdTNOaGpDQ1FVZlFYNEJaai9Wa0IvZmVKV2U3?=
 =?utf-8?B?SjNMWXFMZ1ZiU2VObGFtK2hrVDRldEdqUnpsWEFCK0gwemFoc3hXYk5KYTVF?=
 =?utf-8?B?MW8zdkRVcXY3Ym9nRG1FQmUzRkhLaWNaWEJ2YkFiQVV2SkxaWUs1THpLVkdZ?=
 =?utf-8?B?eXowZjAxWXgwYXh4NTBRZGMxWitabW8zNmRIRkpCVWNsSU1VOXRoYUd2NDM1?=
 =?utf-8?B?V0pZOFd5eVNNeGxtR1F1U09Ybzl6dEViWm1OUzBYRkVDU2lJb1hGQVZPc1BP?=
 =?utf-8?B?OUE5N1d2TVM5UmJDMC9mdlVyMTlSN1R4dllIeG5hb2JzOXgxRzhvcmMrNVh5?=
 =?utf-8?B?RUNGbnlHZlhGeDh5YTIrZmVuOSsxNGsyNnptRTZDL3FZVmhFSSthZGE3eFJL?=
 =?utf-8?B?NzVnZ2V3d2JEQUhxeXRUWXFuSk9TOFIwZnZnYkNPMllHL0kveThyZnRoVkph?=
 =?utf-8?B?bk9zYlJGVkFsOVRhUWdzcmprZzlKSGZVUFZOWTJ6ZHc5N005Mlcwbnl0NnFu?=
 =?utf-8?B?QTJrNndzeXZ5VkFPVFRzbU5vZXg5T2RTNmRiQ0dRT21GV0VqR0lkcnFOcllC?=
 =?utf-8?B?R1BpbmNsQkFZODR3SzAzbzF1ZzFRRXE2TXFLTUkxb1BOZzk2MnhFSWtKRjRS?=
 =?utf-8?B?YnhpVUUxRkFSeU9PMlJ4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXF5ZXkyczN4YVpJelBSWlhvNXE4VFNqR2g3cVdEWU9YY2xFVXRXMVZCWnFi?=
 =?utf-8?B?K2RiZWZER2VCdm14TkErMnUvQkVuSGlUZG02Nmp4dGJtbWxhWFlwYUdWQWEv?=
 =?utf-8?B?OEZKMEtVN3RWRVluOG5GQmFiZjNzUllYeTJScjIvaWlOV205TTVtMzdIeWxt?=
 =?utf-8?B?MVBrNlRqQldsaDJFYkJHeStkODh2WXRtMHY1SGsxUGNpYlZnNGFhaTFSSWQr?=
 =?utf-8?B?YUpsVHJEaUNicmR0K3dCSVFBRHpkTUVsSS9GTUx0SjZHN1FKOGx1YjZjcTVN?=
 =?utf-8?B?UmJ4ZEdPQ3FrWENIRFhiSHFNSmo0dWp6VlRUWkVJb3dBM2pvWVhUaldEcFJU?=
 =?utf-8?B?amlFdlo4aFhrMjEyZ29VUHd1OW9tdVhDNDFvM3h3NE9CR05qbjUxUVVzOHpL?=
 =?utf-8?B?QnlNSU9BWE9MU1gyVHAyaWNKR0JKYUphMFBwQWZVUHZNcklYNVpzazZLSXk1?=
 =?utf-8?B?Z01CcGZQYUZBdEFIUDI3QmpDVHY2WVVVQ2xkQVBnRmxKYWNMdGtjQTZJNUlP?=
 =?utf-8?B?blZVV2ZtYUsrSHJyRldZT1hxVisrQUE1UWx1RzlwSjBZT2grcWRvUmFPVVhC?=
 =?utf-8?B?UXZjNUtRQTNmRW9ZRFY5RDhwc3JuSXpFdjlwNzRsVXBtRmw1UUIvWmp2QUxv?=
 =?utf-8?B?MkhVeGN6Qm92cUs3MUVoOElmRE1YRTB6TklvalJEcUhQZ0JTRk44d1hUVU1x?=
 =?utf-8?B?NFFBc1owSE15NzVMaU1FM1pzejhhK2krdEs0cThPWWtnUWoybDhlL1BkendC?=
 =?utf-8?B?VG5xVjVBZmNIaGI3d0loSEx6Qk5jQnVqY0lvTEF4WTZ5N0dhdERzL0xhL3Vh?=
 =?utf-8?B?bVRQemZGLzRETGV6STBVaWNmd0ZZbmZ3WExwRUI2VzIzRkNaQzhPM21wM2lU?=
 =?utf-8?B?NFV0clpSb3VBUXRlY1Yyck9PcHFhYi8zWXVDaGlNZmg2a2pxekswc1JsN0gr?=
 =?utf-8?B?U2UyczNJNzUzSjd0MFNUc2hlTTIyQjN6T0h4Nmk4dlp5UTRrYjdvWUxqK1lv?=
 =?utf-8?B?aEZGSWtGNmh5Ylp3d2VFTXJMWFZVQUZGZ0h3dnVHTXVkbjVnRGN3TGV0cW5l?=
 =?utf-8?B?UDkvbFZ0dkxPbTBqbVVsTHFheGhEMEtRa29IN29IOWpocWtlbWdJWnhnODNw?=
 =?utf-8?B?YVZ5blByY1k3TG5vQ2NmVGpBbllSQmhybUxkQlFmZnliZjlhRmxtbktQem4w?=
 =?utf-8?B?NWt6NzM3VTJmR000ZDdLVVZlZGdJMTZvVlY4c2grK0FGSVNCaE4vNWFJUjNo?=
 =?utf-8?B?aktBZnMyeVY0VlFCV3dldnhrTDgrUkRHTEFVb2xva2JCNDBxQkFkWEFHb0tk?=
 =?utf-8?B?QWE1V2l5aVNiQTBYbTg5OHQzSWxmVHpCeVpzMWVxUktGbHVLL21NUS9PcGxv?=
 =?utf-8?B?WlkrWGVGT09yRHloemxiRDMzdEtUbVhIN3RqbllUK2NsVDVOUmhsTXY1R042?=
 =?utf-8?B?SXhHUXcrT0lTWTMzRVNRMEVkN0R5RmZpNTFCbGNzZm5ML0F1SFVYL255aFFN?=
 =?utf-8?B?NW1HWG9QYkgyMHBPdGdSVUZTSzg0aTZJejZ2bjRYd2FBb01JazhmN1RSZ0d1?=
 =?utf-8?B?RHlLRExNbHBXSzZYZE5YdXR0ejJnMk1UbXJUT0s5cTRsQWpETnlvQXk0RTha?=
 =?utf-8?B?cmFsZ3hMRUtVdEhvSGdKVGkzaVlMdC9NYVBvT2NhSEQ0VzY4MnZUVzFTR0hV?=
 =?utf-8?B?blFWRlRXWlN2QXF1eHVXdDZ6UXptWGRXVjM2V2xHVzdkNDZOZXF0QzBvZXlp?=
 =?utf-8?B?cUlIY0dXYnkzbnRMSzNLVEJ5UDNaa2xOUlVhdDZxSzRpcnVMTytNS1pNd0lN?=
 =?utf-8?B?M3FTS2NmSm1FOHZpeENMSjBzNW5mYkVmblA3YWYrb295MDJWQmJkVFByaFJJ?=
 =?utf-8?B?akZlYitKVG5iZmNWYUNXNG80cFJNK1J5MDhZa3hNcXpPbEV5Y3VvcS9rTVhT?=
 =?utf-8?B?U2tqcmoreXZQbWU3aXl1cGplMW9oSDUyWDFRTHBQV1RyQ1owK0h5MloxUUtu?=
 =?utf-8?B?SjRsZXc3RVFWQnIzbkUvUC9YSU1GVWdTUUxic1A4cnRReVZYUjg4bGxWREdp?=
 =?utf-8?B?bUxPcUw0MVJ4WHBtQkF1c0Z0aFF2cjgwVHlVYlFoR0l2andhTU93c0tYRm1y?=
 =?utf-8?Q?8VTR9KpGxhIX+6k9Rt3RNFFoe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb94fe58-8650-4545-8ed0-08dcb8359cd5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 05:39:18.6152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/7CeKFFngC9VaEIrBnC6YPtgVqYoeIRLcB+5aa+i8iEnfu/xgHEFj0mVif0PHPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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

Hi Simon,

On 8/8/24 16:28, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 7 Aug 2024 at 23:31, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 8/7/24 16:36, Simon Glass wrote:
>>> Hi Prasad,
>>>
>>> On Tue, 6 Aug 2024 at 23:05, Kummari, Prasad <Prasad.Kummari@amd.com> wrote:
>>>>
>>>> Hi Glass,
>>>>
>>>>> -----Original Message-----
>>>>> From: Simon Glass <sjg@chromium.org>
>>>>> Sent: Wednesday, August 7, 2024 3:21 AM
>>>>> To: Kummari, Prasad <Prasad.Kummari@amd.com>
>>>>> Cc: u-boot@lists.denx.de; git (AMD-Xilinx) <git@amd.com>; Simek, Michal
>>>>> <michal.simek@amd.com>; Abbarapu, Venkatesh
>>>>> <venkatesh.abbarapu@amd.com>; git@xilinx.com;
>>>>> jagan@amarulasolutions.com; n-francis@ti.com; d-gole@ti.com
>>>>> Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
>>>>>
>>>>> Caution: This message originated from an External Source. Use proper
>>>>> caution when opening attachments, clicking links, or responding.
>>>>>
>>>>>
>>>>> Hi Prasad,
>>>>>
>>>>> On Tue, 6 Aug 2024 at 06:08, Prasad Kummari <prasad.kummari@amd.com> wrote:
>>>>>>
>>>>>> Added LMB API to prevent SF command from overwriting reserved memory
>>>>>> areas. The current SPI code does not use LMB APIs for loading data
>>>>>> into memory addresses. To resolve this, LMB APIs were added to check
>>>>>> the load address of an SF command and ensure it does not overwrite
>>>>>> reserved memory addresses. Similar checks are used in TFTP, serial
>>>>>> load, and boot code to prevent overwriting reserved memory.
>>>>>
>>>>> The SPI flash may be used to load other things, not just an OS. What is your
>>>>> use case or problem here?
>>>>
>>>> [Prasad]:  We have observed that SF command can overwrite the reserved area without throwing any errors or warnings.
>>>>    This issue was noticed when the TF-A area is reserved in the Device Tree at address 0xf000000. The sf command is
>>>>    corrupting the reserved area,  and U-Boot relocation address too.
>>>>
>>>> EX: TF-A reserved at ddr address 0xf000000
>>>>
>>>>         Versal NET> sf read 0x0f000000 0x0 0x100     ----> Overwriting reserved area.
>>>>         device 0 offset 0x0, size 0x100
>>>>         SF: 256 bytes @ 0x0 Read: OK
>>>>
>>>>        U-boot relocation address relocaddr   = 0x000000007fec2000
>>>>
>>>>         Versal NET> sf write 0x0000000077ec2000 0x0 0x100   --> Overwriting reserved area.
>>>>         device 0 offset 0x0, size 0x100
>>>>         SF: 256 bytes @ 0x0 Written: OK
>>>
>>> Yes. There are many things which can overwrite memory, e.g. the mw
>>> command. It is a boot loader so this is normal.
>>>
>>> What image are you loading here?
>>
>> In spi boot it can be Kernel/rootfs but at the end of day it doesn't really matter.
> 
> OK, in that case yes it should use lmb. That was the question I was
> trying to understand.
> 
>>
>> We have protection for srec, fs load, tftp and wget already.
>>
>> c6855195e4b4 ("loads: Block writes into LMB reserved areas of U-Boot")
>> aa3c609e2be5 ("fs: prevent overwriting reserved memory")
>> a156c47e39ad ("tftp: prevent overwriting reserved memory")
>> 04592adbdb99 ("net: wget: prevent overwriting reserved memory")
>>
>> And this is just +1 patch to protect sf command that it doesn't touch reserved
>> location.
>> The same code should be used for other commands(nand, usb, etc) which loading
>> block of data to memory because all of them shouldn't rewrite reserved memory.
>>
>> In connection to mw/mtest/etc command protection can be also done but not sure
>> if this is useful because you normally not using them for booting.
> 
> Exactly.
> 
> I am hoping that we can pull SPI flash into bootstd...has anyone
> looked at that? Are you using scripts or is there a special bootmeth?

We didn't find this issue in connection to boot. As I wrote in another reply we 
found it via spi testcases where TF-A was placed lower in DDR and test overwrite 
it without any other evidence. Part of the reason is that protection units are 
not enabled to protect secure FW.

Thanks,
Michal
