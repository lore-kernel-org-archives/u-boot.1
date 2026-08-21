Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981B3C5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 18:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27BD46067E;
	Fri, 21 Aug 2026 18:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kh2BMOJNZDFk; Fri, 21 Aug 2026 18:49:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787338182;
	bh=DydTU/BY+C0iOECbu7f8374YdDbypoopT90FGWI4gY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0zy7lBqkpN3avFWI3jSduWuKvhwIPW4IBQaRokQDwn6gCrvf7LNUDqLTR0qFr11ft
	 grYFoyH9fBAp0O21T4dwjiHflitHgGLt4IK5AewdBrcdStgzTiiDYIdBBHSDL1MiZb
	 TjBW5xCYNm5hqTdGt8T3vC+EPIbNwDcxB1d5pnH5JRhqq3FHHbznavbNTKURxzMvI6
	 203bbltRLRik6G69ldUf3f/3adg5z1F1jC0WMevtQdl45zeiFSF6KWlXr6E625Li+X
	 WnEv4tzn6LnQkzh1582nVmMV34kjnfvKXeadCC3WkdCAUJaP9lJ0yoHgKsitBUsjrR
	 avm+8RfL85iYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F4B5606BD;
	Fri, 21 Aug 2026 18:49:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B0AA84C4
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2D2440960
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EqatOQnWGFln for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 18:49:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=YgrjJ9Ah
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7508406F6
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 18:49:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lxgJb7wbB8knLT+YmbObAWTY2/1japhnL4JdUORvelADWKJ74PWDKgsMkEzou7e8tTURhf081tamEKzyshvOFe1VTh0D02UHy9gwPuRNtpIpAmO2oIeG4qWJUKfLcxQIElNMJk8sCIkHl8xUAI6PmoRMUaCy/TtoI0FWtWZPVLN28hUFqN9VyMl5Kwb4oesOfxaYncsievNm5nR2+dEWVV4IWVXR5cCGniC0OPsKHYeYrvPcvysRg1UFCihJ/tOW5pYMjDd+6g5OutAcLdvTXRLhGDGX3oPIHpkXa34x0gC4x8GC8LMn/2NkfsLqKU6+DI+13HV0Rhyxk6hK/WI5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DydTU/BY+C0iOECbu7f8374YdDbypoopT90FGWI4gY4=;
 b=V9laYItziFC65qAe/nNGjzbkqXzVbWA0+oIcpIbDlQyM6y681sH9xn6VSDf2FSTp9991Jz/2LvUmUKGcsuNF9OheOvnPV3Ug+C3nhPumI87mA3sMBhUU82fBNEc4c4K+RwTkeDotE4dwbsR/TWE+nhn7mZvyopi6HaqspQd3EqGvY3zm6EXIuhYGo/sxnWO+iyoKKIXUpdhM42zeHD1704uIOU82/gCTAzGbgbHLelAGmzjWQCtxypGEFTnC2Gcpe4L0NUUu+vnzh0Z2qqf9mzlGoOxZASJj7J9OjCdNKsN6WsHQTx/Ts7OKkeK/xZCRzAYCEnXfBcSV8H57ab++Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DydTU/BY+C0iOECbu7f8374YdDbypoopT90FGWI4gY4=;
 b=YgrjJ9Ah5edYWmJD2FNZMaMXP52IxHrxus68r0rL72hOnadPtFGClkIA0YYnmxQdoInpDAT6kuMhTmttFp1REReoTLwoc28CWJj/zWqw4LOQ6CrQAdPfBJVFXXWoIwBr5rt18khIRoJpboiQ7yuXkYk4NAnvJAdjs61crW3tFuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA4PR04MB8062.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 18:49:33 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::c859:7e6d:9345:afe1%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 18:49:33 +0000
Message-ID: <ea79f87e-48d0-4f96-95bb-9a04fc82faf8@cherry.de>
Date: Fri, 21 Aug 2026 16:45:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
To: Cole Munz <Munzzyy1@proton.me>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
References: <cover.1787309754.git.Munzzyy1@proton.me>
 <3cf8dc75d461caf6076c35275021bbcdc0943de1.1787309754.git.Munzzyy1@proton.me>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3cf8dc75d461caf6076c35275021bbcdc0943de1.1787309754.git.Munzzyy1@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::35) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA4PR04MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4d405f-2b46-4fa8-02d4-08deffb4f0ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|23010399003|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: mNEORivXZg/YSaNpqP2lyjHhMmhYPVXgUKroO84vSM/+2zH7ZHlx1sLweIbKll7v8sUezLPw0bKzihHZmiI05TLwih6ggUmsT8EPeEWiITNaEFIs8qlv5Lp1+Uzw6YnBvfxMQR/BVMGCx7cQCsLTg9v3yLMou8EG+2Mafad7w46q+cyUFCAFmCcRAR4qEFCRd+2F/htof3mgm4uWhYws3bOC+DSN4uFE2niJ66r8uHm/A6AUY2ZqR/9CNy3mOv/ku/3Zuz7HU+FOeI6rPvRzlS74dtrrG1iZ+N/sFjDWgCVB7HvIBDYqtckm4dPc6HpNRezM/LNt+h3+mhT+fhvS7owJvD/BPCOm7fWvSP0Nsfudd1Ks+RUoTtq4oSENE16hI26mQa7T/wmPh80SHIJl4z6NdWgDJVaGmrS64XSnhYkFpb/Bko9al4kGNEsjlRGGZHvKjV0YgSBH+u2RL/biTr1O/ZZJPK0pdTohlfBRiBVTzD/3lQiTlkC66vb17c8aAGq/Jai/F8wBLLaFkuLtrYBOuBkgfGjPaqBmwqXrrQQnvOG6dT8b8MQqr8mZ+Q+1KMRgryFX3/OtZ7p2mCz5WMPpTdlEnANMzzhudJ9HerVtqeB97Y7C5WQBfynLJKh0z65rLck1kKnuGMPCW7itOxGvzp0hs4dN9tij/fujUwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2PR04MB11147.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWFWQW9Tb2Q4Yjd3UnlBQ0dmNFh2VUx5TXhLVXN4Nmcwd1hxaldSOXpVRitI?=
 =?utf-8?B?ZjRBOXVCUmkxV2JiT0VaeGxIWlJJc3VZSHNnSjZOVUNLb3pDQklyNTJrdEM3?=
 =?utf-8?B?VEw1ZjBuaGswQkpDUzUxR2NtelQ2K1paOUFQWjBCY0JsOEU2ckRHalJCRGhP?=
 =?utf-8?B?NTVaaDI0ZW1LL0Vvb1VxYm04VzNUNTh4MnhZL1Y3SVI1TEN0VXF5cDRJSldu?=
 =?utf-8?B?UGVBd3B6aUpWa1pvZmd4VWVxbHBXS21nek5NQnozQnZJVTY2M085MGRDclVw?=
 =?utf-8?B?QkVBeGltQnVUNzdrT2MrUEZTdVdhYVpBVlBoZk12NUJ5Z1lOMTdxK1ZlcSsz?=
 =?utf-8?B?WEJpRFpUSDhMcXhvT1Z0QWlERk1uMWFEVG9HY1VnaElEdFp0MVpMRWxDTVRy?=
 =?utf-8?B?V0FoQzJxbzlnYU1kNVpIK284Ry9mcXBUVkxyVnFES2JCRXAwYVhJVjNlNlNj?=
 =?utf-8?B?TFMwQjVvTGpFdHJ5WmlhQUVzbkVRTHJZMlNtbFFGZXlUd1BMTDAvNVF5cWxq?=
 =?utf-8?B?aEJwV2hRVFgra0Vyckgxc3dxZW0zQXZrRmpzcTViSURvSGVPUlZGWDFxdm0w?=
 =?utf-8?B?U21EVGwrY2NhMnBTOHh6OHJsbVYvUkFHa2JCaEs5U3dKcDU3bFRtMTlBRFlq?=
 =?utf-8?B?WnQwTGRCRVp5TGc5eDNtRjV4WVMzcytOamsza0EvMi9BVVkvYjlPMlJhWk5D?=
 =?utf-8?B?VFpBS1FTNEVOeUpBeU5McGo0aFRFY1VRaysvN2tpUExTSVlLOFRla2k2clJV?=
 =?utf-8?B?MGpiRU95cVRLMko3Slovc3pGLzI3Y25HdnJidXdkWTZnU1JKVDAzUzlXMmNS?=
 =?utf-8?B?V3p4VnZwbURGblh3YVlIR01tY1dCZTRibnIwamtxNWhYbGpxaklHVXE0VUZP?=
 =?utf-8?B?aHd5QUxjMTZESUxXOTRaU1Y4YnB5eGNnQ2h0dFdVem5jNW1ndU5rZ0poVWF1?=
 =?utf-8?B?R085Y2VmZktCMll3WWdnOEZUa2k5M1JhWE9tRUdYdFQ5Z01FUi9vQXJNTTc4?=
 =?utf-8?B?WkJWeUVNdG1YWkxyZlBnK1NFS0J3ekFEYm5xUXNkdTRTL3hXbjVCRDhpN2Zh?=
 =?utf-8?B?Wjh0RHhkUDRmR1RsdEIrcUoyZmptNis0R2VGV3VxR21TK2FTYUx6NWVpblFx?=
 =?utf-8?B?RGpFMzF0NWN0ZnY3NFh5Q0ZlQUpYY3hNak91bVlJM2RudE4vOGN2MWtJVzdX?=
 =?utf-8?B?RWRUSm5Ccm5lNUorblVNZzkvWXlJYzJuL2wzWlpNdHJwY2FBZWdPcVZ6dHM5?=
 =?utf-8?B?WHF2SU0vUkhoOFI5K1dHbmY2NkwwY3psWkdsQ3JyamFsOGdva0RzbnlPYUNQ?=
 =?utf-8?B?QXdMUkFxWkliaGZ4UUFFSGtoL0NhRC9nSzdMMDVQSzRvOFBBdDFRdGNRS09y?=
 =?utf-8?B?MnVZQUZKUVZmV3ZacG96QVZvRkRnUG8xU0hPb1B5T1lwa1dXS2FVbHJpb2pW?=
 =?utf-8?B?YW9CSnBxanhONjZTRjcvaHJ2bzJpVmh1WjdyNGJNampwSzVOUXVKL1NKWGpQ?=
 =?utf-8?B?S2o5UlRrMnBtSDlzaTJYay9KeHlSQmdHWlVROHI2RCtnUllHVHk0UTZ5b2E3?=
 =?utf-8?B?YWptbnZha3hQNDZMM2VzOFBxOUQ3VGpCa3NoSjh5WXQxYVFlQWU2SkNIbk5o?=
 =?utf-8?B?MnNoN0hEc3hrcGNwbXA1UEFJK2x3bHFVR3ZSSDFhbVBtUG42SmUzZDZQQmpB?=
 =?utf-8?B?bGJUeWJjK3RCVFZTUmxxVHI5TFlnam1rSW9LdVN0WFNudCtQOWlqNnByMGdG?=
 =?utf-8?B?V2tjbXFOck5NMW9jYnhveGtHNmVNMVd5WThTK2xaWGJibWE4emsrcEFWNUJM?=
 =?utf-8?B?MmhIQ2MvaEgyYUJmYTBnQzVTMVBzOVE4YzA0SzF4d1hpYXF6QXZEUXVPTjJI?=
 =?utf-8?B?SXlaUHdET1hrM05PSzh4c0hDOXpzTlV4bTFMZGxFWWNyTnlTNnh6alNxMzV3?=
 =?utf-8?B?RG9yUElQMHpFU0NQRG90bGp0bnNtQ0pmbUk5cFExV0dFQ2lVcy9GS1FnM1N3?=
 =?utf-8?B?S3dsbzBMRDJKK0hnUWFUekJVOExFS1JCaVZIYjJhYU5KU3RGRGxqSTJhUm1z?=
 =?utf-8?B?Y2Ftc1Z6TG9RcGV3OFc5b2NBclRnVzVCc3pSeXE1VWVEVlBFeGREK0YrZkpp?=
 =?utf-8?B?UHorVkpoSDZnRHZJQ0E2ZUoyZUdBSk5QR1B2ZHRFaVBBeHg1U3JkSmFHZklS?=
 =?utf-8?B?anUyaGU5d0hqWmYwRFNVOXNUR3FMMW9udXUxbkc3UjJpVk9qbzluVkJxVXhi?=
 =?utf-8?B?Tlh5LzRqWFNIeldQYURlamZzYWVrVnR0bk1TeFpnSDdCSnBZWmZTRTR1N0RM?=
 =?utf-8?B?LzdnSm02N3FkeVU4emw2YXRtV2tqdnVyRHY4YmpXUUVVa0xmMHovTE9xNmVJ?=
 =?utf-8?Q?L5dGWhmPJ2TAlQk27yNFZGe/xjH7ExWMQsjmWlRBTCOea?=
X-MS-Exchange-AntiSpam-MessageData-1: jyL5EY6lOOxjqE53PnjML6/lt0k0lj+LhRY=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4d405f-2b46-4fa8-02d4-08deffb4f0ee
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 18:49:33.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UD14zrpv+9W8kBjy04Nm4Bm4dMubIz7Wn+vX0KuWgEF9UALJXjtGfAkzQcA76DfrisFWNmMvBqr5pbyxo/I9vz0n3JTIHZbbU/Mr+KQx/n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8062
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

Hi Cole,

On 8/21/26 1:55 PM, Cole Munz wrote:
> The controller has a transfer-mode field that can run transmit-only or
> receive-only instead of both, which leaves the unused FIFO out of the
> transfer entirely. The driver never used it for that: claim_bus always
> programmed TMOD_TR, and the only other mode came from an opportunistic
> switch to TMOD_RO for read-only transfers.
> 
> A device described with spi-{tx,rx}-bus-width = <0> has no wire in that
> direction at all, so now that the width reaches plat->mode as
> SPI_NO_TX/SPI_NO_RX, pick the transfer mode from it. A write-only
> display stops clocking receive bytes nobody reads.
> 
> The transmit-only case needs one more change. The 8-bit loop paces
> itself on the receive FIFO and sets toread unconditionally, so with no
> receive path it would wait on a FIFO that stays empty forever. Leave
> toread at zero there and let the existing wait_till_not_busy() at the
> end of the chunk handle completion, which is the same thing that
> already covers a transmit component today.
> 
> The restore at the end of a read-only transfer went back to a hardcoded
> TMOD_TR, which would undo the device's own mode. Restore what the mode
> asks for instead.
> 
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> Tested-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I'm planning to take both patches for 2027.01 (next branch; end of next 
week) as this is not fixing a recent regression or a security issue.

Thanks!
Quentin
