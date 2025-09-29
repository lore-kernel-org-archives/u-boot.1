Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFF1CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 12:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6895883071;
	Mon, 29 Sep 2025 14:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JaIWnXgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F116982A9E; Mon, 29 Sep 2025 14:54:45 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68E682A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+I7WFn/yxJh9hIvtthz6bkFgiKNpdnb3cFgfVlOgtOo0mEicXG24DXROb1uAHsr5wwaqnnxRM/EU/ZJL6apHTc0BGVhxJnabpupML3LyJbuKZQk4PlhdjufLuG4zEBBYRlJb9mxwdzgmwULcEH19cyEEtvm1tn70zJu8GMpm4Z2iCs3GLCbEGFcRIxriuZs4CuaW+RlRQcntdKP6tOpLvITK1BT1hUKJi+aL+I4WKhqtvBoIJK2u86voQHReNQBEHJLiW8vW6S8qSJCKunSxp8S+1cxfZXmFXPqXH1bOQ2fa3SYktVXtzEkPpxHXE8ffA3VCFJGr88Vl/RjhfIjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIVByXyY/Sf65SIia7nFCIkbDh35pa2k3DjrawdMEEc=;
 b=YNm3+sIVn9Oj5JQ0Sqb2rsnD1AizWUMWprSjku5cEJa7xpchbq2sxZp8b3dZnyJiElQDX2EweM2vqRek068kbgmAMnt5pRaUu9DQEwWAPJB/NBU85x/lXVjRVMPd2CGltz51OzGj9j5sizx5RrSvbHlfm+uh9ZK1SNWnoe/Nizhu4e0e2JWSpXF79grfVGGLbodv+9xndC0Aljsz3TkBRndg733jgaPE6xF6Ro1rJrlnWyI13gfUTd28o9IuP5EzIGg0m6sBztl471i/WrAM2KJSVfcMIK0jNJLry2s4TErBU40vOw4Vj0ManA+zuEHe8DhyNZhsX7/6lJtNpth26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIVByXyY/Sf65SIia7nFCIkbDh35pa2k3DjrawdMEEc=;
 b=JaIWnXgRtEAMXYgOdM5kKIrGf1H1w/mLxqcZwT+puSGuieZAD5ycawrnclNfsPmi6V/rSuPBdZpZF3mEB551AAje095Ea2fj7BVNYA4ufEmmqPGzooghP9l6N606jE45EC9JRfTaqEAgcqbJVAsk5cjpy/lv0QIiOCruEn6CTvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Mon, 29 Sep 2025 12:54:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 12:54:34 +0000
Message-ID: <cbf26fe2-1267-4965-807b-fa0805e61bea@amd.com>
Date: Mon, 29 Sep 2025 14:54:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable sntp command
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
 <7ab73b44-8efc-47d6-9e6e-5ffd9ab0e3d7@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <7ab73b44-8efc-47d6-9e6e-5ffd9ab0e3d7@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0048.eurprd03.prod.outlook.com
 (2603:10a6:803:118::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: a695d970-b350-41ae-52bc-08ddff575709
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KytIT1BUVFRTUXpMTXpEVTNuSzhpY0JKMTVoWnEwbDcxeEpPNHh6R1ZTNG1V?=
 =?utf-8?B?YUx4ZitSMmtCVkxnVUZIUVBHM203Q3lTbkNrS1lRWVVQK0NXV25PVXFBY0lK?=
 =?utf-8?B?ZHdqMzhNM2VnWnJqL3ZSZkV2RWtTaDE4aXY1V0twQzdWeUx6OWlCUW56UElF?=
 =?utf-8?B?R3hsMTR1djVMMm9XT2xmNmVYQ3dXeDFFSDBOWnYxNU16R29jZ3pURlU2em9Q?=
 =?utf-8?B?TWJpeHJhNlhIZzJNb0I3QytCdnNYalJXbDF6V3Zaa29paVZqckd4eXdtRFNs?=
 =?utf-8?B?M0QxK0VIa2tjcWtiNW1FY3N6RDc5czJnWEowYzlxMzl6clpzYjVKSW5LZUo5?=
 =?utf-8?B?U0YyTittNTBSaUQybFd0WThYTlpjZkxzL2Y5SC83OGFLN2Y4MERhaC9KK0w2?=
 =?utf-8?B?MUVYSko0S0VnN29FTlpORVhFb0xCQTFIa2JZcmJoZWg1N29GUlZFRTNNVTNr?=
 =?utf-8?B?VHMxbDZVdDV0cjAvVkpFMW5ENjZCd2h5RXFEU3R0dWQ5K3VXSzVxVjBOcTdq?=
 =?utf-8?B?NGdEVUZqS3ArdEtjQUphU0Z0MVZpV0c2NEJvMkJkTEJlSDhFTnZmOEREVExM?=
 =?utf-8?B?QllwTUFBQzhiTEpTblFMUUh3a1pLcEpIM3d4SFIrNUY2dSsvMFBoYnM3Zzky?=
 =?utf-8?B?MnBsRW9EY0NGcnRXZGkwZDRkZklvU055Z1plM2NFUnlkYWVtL3g2YVc0akQy?=
 =?utf-8?B?WG5GTVpGY3FxVXBrVEIrOFRtekVxdEFhbjlkUkZldy9PVlYrTU8vVFRrc2Yx?=
 =?utf-8?B?NndmOHlLeGlRTG5PbDM2bjRGbmsvcFdzTDlFRUxzcFBRMnVjWFFVNjRFRmFo?=
 =?utf-8?B?TmFGbGVLdkpwbGVSZ2YrWGtBRTFTWjNvRWpUN1VJdTNIYXJNOWtoU2tTK0Iy?=
 =?utf-8?B?L1dxdDhaTHA0blpKTjgyNy93Vkd0TVFvcXJ5aDRqMGViUkZUNWp4NjZuemR1?=
 =?utf-8?B?citVVld1WmQzTEtQbGxRcEoyMDRuekw5ZnlKWWY2QWxGajNxelQ5ZVlJclhQ?=
 =?utf-8?B?ZUdKSjROMXNHVlVHQStGWW1ZKzVFZkhvWmI0TWV3aHNoL0Q2QXFMWDQ1ZVRD?=
 =?utf-8?B?VjZFU24rUkR6aTFRSXlZSGJsZFhreTcxc3dxZHp5NjFPa2lMald1QUJEUkxi?=
 =?utf-8?B?TVM4aVlzUk5ZS0QyYmFZOGZ3VXl0TTdDcEV1K0E3WkJxM3pYdmdFWUREWGZr?=
 =?utf-8?B?aGxGekI5TlljcVBPV1VOMWFoZ0lTb0ttWFlBaE1mZlJtaDYzN01PY2d6OEVl?=
 =?utf-8?B?SDB3Qkh4RnU2Y0NMbE1BaFpweEZYUmVFNGJsQVJXVUpTcHR0QnViaUhQbFQz?=
 =?utf-8?B?QWFETWZqWTFlZHNjZzB2ZTJ5c1NDMzB0cGxaeno0TmZJYVg2cURPSEdOUTd0?=
 =?utf-8?B?UGgrQW9rTUo1VWFCa2xNWTlBT3BYd0xzbmhCMXZqUkpoRURaUXJienZmOS9t?=
 =?utf-8?B?U1lMRVFjMEF2SHJSVktaRS93Y1k1Vi9yT2Jvb1p6TXBGbGQrdllURTJyYTU1?=
 =?utf-8?B?TjFqdFhoZW91aVl1d1F2bElUaEVKckxZcG5McHVWOHAzZEZLR08zdFQ4Q0hp?=
 =?utf-8?B?aS9XV3pZUjhUZWorc2NTQVNobmhwcUhQaGdjU2FFVmdCNUgwTmpiKzJ4S3J6?=
 =?utf-8?B?aWtUM2tpRkIrbVRab0hVRGsydFNiU3pCZzQzYmtzMVNnSWppSWp0VHd6QlRG?=
 =?utf-8?B?MVVhb3A5SXdQRXVraDN6ZjlCQXdvMlQ4ODJRVUVnc2orUlBXZENnekVDUW1p?=
 =?utf-8?B?d2dpbnA2bzRjOFZXREx5VFF0RGJORGltZGxadFIxZlBmbncyclRqYWxQdmx4?=
 =?utf-8?B?YUFPSjNZcFNrZ0NOV3JiNVAweWczTkZYQStuRllOUlVMNVFrZndUNEo2OXYr?=
 =?utf-8?B?THdydC9GS0JWRGlKTGdjMWhZeGZTMEFkQkZZYTdiZDVMTW5zUUcwamFYMFNG?=
 =?utf-8?Q?LInYt9Hxxj8h2lIY2wWE5FTegOfiW/2a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REdSV0ZjUHpWbkUvTWpqMGtuNXZNSEpxODIyMHlTdm1TRFlNL1pZM3pOVllY?=
 =?utf-8?B?c0o1WlRPbGc5KzRkNHBWMmlSc3RhWDRRY0E0VTVnWnRZRVg3YWMwcXFEcjJH?=
 =?utf-8?B?dXFXMFBkM2QzZUpjdXhXeHBUV055RWxjM0VuSElPaytQYW5BZUxSZVpXc1Zp?=
 =?utf-8?B?eWVub1JpNzh6UFNyRGgyU29SWXR4b05sSE53NmRHbjZSa0N4Um1QYzB5bHJZ?=
 =?utf-8?B?NzZka3N0aDgybTVsZkZFblhyZmViOEUvT0pxOXJmM0U0c1RjdFNUT3FjMFZk?=
 =?utf-8?B?YW9ST0E1cWhndXB0SGR6WU9zSzZBRHV1dUprcXdNbEZ0YjEwYVZCOHU3TEJw?=
 =?utf-8?B?RncyRm1MRlFSa0ZwWHBGR0JLczNzUzl5Wk5rTHJwdjM2VFpsWHBocXRySkJ6?=
 =?utf-8?B?bC8xMUYrMzlyZU5UNUxNNlNXK0NlakIxZno1MnhuZklkcFlkaHJnNkJmNkVO?=
 =?utf-8?B?dDRsTUFaNVR5MTA2NzhUTGJEUml1MWx5SzdoNUdLUS9hSnBwVDAxWm5xdmRF?=
 =?utf-8?B?Y1lxS2NBVzlqVHg5K01hOXJpQ1FTZFp4UFZWS0dyTUVXQXhUcmo5cnhQQkQr?=
 =?utf-8?B?ZWRjVGUwbWYvb3JMaFhlb1E0WXhZbU9CSnhwUlZRbUhtWDVlaGtIcWxzVlZa?=
 =?utf-8?B?VXZTVlpFd1F6YlFZdG1EY0J4SjNqek8xWDAwY1R3M1J1MHJWWTJjK3YrRmU0?=
 =?utf-8?B?dURESnFsbi9FWVhDUHFucGpGOUVRN2psUVlPd1RDQTlMUFFmWi9aOWFWZTZI?=
 =?utf-8?B?dGEveXczWTBZSnRVNXp2ZmhhU29maEVKZkJGMm5ac1hOc3pKR3pEVmZHUmx4?=
 =?utf-8?B?L1Nkd1RGQ1RqR08xWmpvWWpTMm42Z3FlNWlWN3VyQUx3aE5SYS9pd1g3Q3Z0?=
 =?utf-8?B?eWxSeEdHVElHN3VuNEQwcGNiSVdsenpraW1sU2hod3N0TEtPM2VYU0ZQL0V2?=
 =?utf-8?B?dWZtcDJISnhIdnVvZCs2a1V5eUVDN1NqYmwxU1N5aXR6dFNORHJHYnBIT3ZF?=
 =?utf-8?B?UUxpVEJ3aVNvQlFtVW5NWmIwbVlnMWkvb3Z6UlZQMmI2dnRkZDVJYnhNM3I4?=
 =?utf-8?B?enZSQm92VUdpb3JGYmdmSTlpbjY1NnE5MFpxMU5tbGoyU0dMY0R3enhER1Bj?=
 =?utf-8?B?aFM0VnhlbEhjK2REL2FWS0JzSHFvSGVmNDI3aU1uRlRObzJ4ajNDTnNBaHdN?=
 =?utf-8?B?V3dGN3ZPWXB6NmhUeUhFK2YvYzVNUkVFcWE2NXM4SnlSckVFVnpqWi9BYVhE?=
 =?utf-8?B?V0poVElqL3dXd2NtTlpKTS9RMUFHSUVvOVpseGFKb0h4N1Aydk9rc1BDMjl3?=
 =?utf-8?B?YlltRHFtakFtbzl2WmFVOXpaUWtCU0Q2OStSajlFR0pWM3FZNkQ0Y3lqY24y?=
 =?utf-8?B?VC9PWE5SUzdCSkREZ2VQSmEvNCt4cjFDdng0QWgwVFh2N3lhVGZBcGh2cTBW?=
 =?utf-8?B?WEYzalRmeEtNRHgvMnVNNHJsNHVOMU9SMzlDWXpva2FOSFMvckovWHR2K3FH?=
 =?utf-8?B?RHFPQjBDcU9jM2tEZWZ2TFlydWxRZmVYQjV6eDhKUmlzMDJ5aVZrYUJOQjhU?=
 =?utf-8?B?MlV5c2tyWUZIKzhVWUY4blBQYWpNaXNJS0dYTnIweFVoODNiQk1GRFBmQzQ2?=
 =?utf-8?B?TXdPN2xGZXo1alVGYjAwTkFCR0tncTllNHJ6ZUtCZXAybXlwZ0dESS9wU0FW?=
 =?utf-8?B?WERoYjZ1WmUrNmhZbjhUSGFhTWo1NWttKzBDSzRycVlYNVo5V1MyNk5yeXhQ?=
 =?utf-8?B?dFRyaG9UVkhJQjlFS29yRW00UVU3Tnczc1hVVXc3ODhsYmZqVWpIcHQybUlR?=
 =?utf-8?B?OEdKbjJ2eWhsbVROVW5UdWdqbXQ3LzJVdmdNTzJBMzJQZ3YyMW1pUzhXMWJV?=
 =?utf-8?B?c0lKYmZrSm9ENjZSUGlXdmFQV3VUVUZHWkFDUGlBQndmL1RNbzVuN0ZFa1hJ?=
 =?utf-8?B?b3lsL050amVxWDUzeVQ2bE04T1B2K3d3c2xqanIrSGpyVlp2d3JWdWdGWjht?=
 =?utf-8?B?c3VoNElQSXpzdHNaSjlLT0xXY1pTcGJwYTI3VW1JSkRxc1NFMTlMRHhWT2Jw?=
 =?utf-8?B?MnU5aFBlNTY1d2xqSE5GVTN3WXpYLy9MZitXWURrV0x4RG9ndEpodXZ5Q2pD?=
 =?utf-8?Q?oEClAen5jTi0JkMTVVt02VR6Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a695d970-b350-41ae-52bc-08ddff575709
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:54:34.8436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67dBy66Il76Fl5EUVOiW4hA1BqnWtZ3ahtgEIZy76Mvy8+8o+zY8PJc/jRiZMcRC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936
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



On 9/29/25 14:13, Marek Vasut wrote:
> On 9/29/25 8:24 AM, Michal Simek wrote:
>> Enable SNTP commands on all Xilinx boards.
> Look at #include in configs/ , that should let you deduplicate xilinx configs.

Good suggestion. We have actually started to use it for mbv defconfig in our soc 
tree. It should be sent out soon.

The only problem is to keep that config options aligned with Kconfig layout.
Maybe you have any trick for it.

Thanks,
Michal

