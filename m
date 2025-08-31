Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D1CA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 20:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C1A283447;
	Sun, 31 Aug 2025 22:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Igsf/NqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E9C838AA; Sun, 31 Aug 2025 22:11:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0063983443
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 22:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2fmnSxIEHIaQnynNlMpLA8xl/cnlcuvz9vPbQokPAbsa4IHyF2T6W16bGOheWP/7bdJQET1iuHhptoJEbbcdzSu2gkwt6HnWOmSgVAEBMb4oMKQ6g7f5JSXguygosyzYZLpkvxlrOW2RckX2RjP2lzcb7ZiMP8n4LYmxCcOK44NnC2ja7fVuaFsNHVcVOq/Qr4UmbJF2+0Mqa18NJg3mWBK4dFW8LuV/wbNxXxhhqY6ulyrZ8Vajlzcpy64zi7aN2gR4uoPLjBeyunXrnERtOWtzRXgYTZ3MZ4cyA00LMDFZr57RKH3r0DfH3UQ70dmoiyIZ+D70oIY0zW8PexvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA0jJ6CT4429RKF7kWtT0GMP6KGxtoLdlGMMwIbhkmE=;
 b=EChLyfWtMOuVdEXgDQ9jp4FUCOFuNKAq1KuObtWaOR53ls58uLMGLHys6/GD3DLtUtk0clBhOiUeTU8Pam0D4LDKyTPvRMYjZ6UCctwJnqYGg7qIxYYo4KK6SNQFNpvcMgM1xxrFVxttIkgTD+ge+O3Ohpip1vNFKEdKbVKDF7zUajg/kR0I+eehKwhtgGNbIozm4JjCkuTunF0HSQ25Q9UYt7nnSRC4Jxniy8j3s4hsLSWIOQNAWPEgyAti7n6MRw2kx1j6XIRPsHkakIzjcv/H3225N0E5zdElInTxCrJMaDu/jL7D3g5VPsLo9qUz/y8Avc19xPt/FpZk9QfzBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zA0jJ6CT4429RKF7kWtT0GMP6KGxtoLdlGMMwIbhkmE=;
 b=Igsf/NqMYjLnnLjRQRz1vE/3j8U8/1wcyXD5kLS7t2d1x1MO9Pa+CWK7+J6WL62O9U/FtCxC986kaZ5NBnjJo2ZkT98m5nLUv012FvypASLcYhT3q4/MKEVNI4vgpuzrJ4RJtFGN9aw9pqFS3XNT5Js1KMsMgaYBWhWcJITh0nRzIcoc16RSs9F5lpalR+YwVZJANPclD2oy+dyk0jEKXOk3CvHeMHVl2ioaJzmH6B/dXtmela0lurmiapLSXkoiavJHW5WcrvqvfuBIBgwRx8zQz448oeO7D/b2L7JwXMKd4fFzW/8gJ7yE0MVMSWmGOCoAarB0NKC2T+al3Sjepw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10409.eurprd08.prod.outlook.com (2603:10a6:10:52c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Sun, 31 Aug
 2025 20:11:22 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sun, 31 Aug 2025
 20:11:22 +0000
Message-ID: <329a2055-3dc4-45a3-9d24-0ded3d4b8527@iopsys.eu>
Date: Sun, 31 Aug 2025 23:11:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] airoha: rework RAM size handling to support multiple RAM
 size
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
References: <20250722184426.6964-1-ansuelsmth@gmail.com>
 <a374f7d9-b658-456c-bcce-30fa501f505e@iopsys.eu>
 <68861451.050a0220.a546a.2ace@mx.google.com>
 <2c6a55c7-e4b0-4af9-ba66-ff5cada14de0@iopsys.eu>
 <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <68a9c171.5d0a0220.2720d2.b8b7@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d41903a-34b1-4f20-cbee-08dde8ca8e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGN5RVloekxYVFV4V1dyOHNsbUMzTjdCTFlYcGF0YTFvVGI5YitiZUVLSEJM?=
 =?utf-8?B?WTNQYkY2OVNmS2Q4SU1IQjlXdUMzQlp6RnUrVlA3MS94bWF6TXJpQ2pTRXdk?=
 =?utf-8?B?ZzVYSlB4c2x4c0RDTldjRTZwcjdqNHltcmoreDRtbU5PWEg1cS9sTFpJaWow?=
 =?utf-8?B?Vm4wUUdmcHRYYU51N0tkU2NLbzFvMnhWSWZKMW9FV2RQNHhGdWJiRUsxOXNL?=
 =?utf-8?B?YnQwenV4SUtEWDlkR1FZVjBRNXVZbktyNEtkUHdxRm5KaW12NmFpU09heDZs?=
 =?utf-8?B?bjYzNmdtWWVEYjNXaWxjMUFzRXQyVEsra3M5ZHFLdlhOOHVxOTY0c2lMZkVp?=
 =?utf-8?B?OTNFYkp6VUQ0ZHBBQ3RMMXB3SmxPNjJBTHVkTkRDOFpZS1M5ckM3YzNMNHFa?=
 =?utf-8?B?WGVyUkRhWUpZNUJCM1R0dzZ2N0FvVkNNWkdqeWJGWXlxa0VXbXhKOGxzVDlZ?=
 =?utf-8?B?M1pYRWJLdXNlTVVPUjc0bnV1bTJ6Q1BEdkRpaFVscms5VzJzdjlKbHJkTkJE?=
 =?utf-8?B?Yi83VEpYdURtWERmSkNSMHRzSVpOTGV5Yk92R0ZlVXdqUjkwVkFSZjZIbGN5?=
 =?utf-8?B?VWNMYkRxU0N4ei8zMko0alEyWGFaUWY4QUJrTjR1Y1BFYjN0K2NWWnBoUCtu?=
 =?utf-8?B?ajVOVW4zMWNlU0FkdzNnREtRbUFtSmFRaEpuYUhZRmt0cER4dGxLSE5SVEdt?=
 =?utf-8?B?Y1hkdFdzWDJrRkNBeDF4SFhzZVUvUVB5U2ZGZjdDeDNvbkdaK3BlaXNoQ2Vs?=
 =?utf-8?B?VVFabnZib3h0UW1IWFdvcHk3M2lGeWh2MmFjQzBzT2pYWXpWUEttY29YTjU4?=
 =?utf-8?B?WVFMMXR5MEgvWnJCc1JwZllOMkV5ajZJKzhvVldLVUZrSzRZWElyVXE4QU5Q?=
 =?utf-8?B?WXVjM0F0N05zbCtsWWFqQWUyT0hldTJNTktaWEdJa05MU3FSZUd3d1NIUUZs?=
 =?utf-8?B?QlU0TnVCYllHOG9UOUp4REk5Nzlpd1hBMGdqMHowMzhOcU5nN0lHOWhZOVFh?=
 =?utf-8?B?dnEveUozdmhpcUlCZmsyN3RsSWN2M290a2hBT2lVcU0wR0xHOXlrT1FFekQz?=
 =?utf-8?B?bm1RbC9FWW9tMUlSZjdLUGg0dVloZzlCSnFOT0hudHBwOU4yeGNScVQvd2tX?=
 =?utf-8?B?dHl2SmUvdUlyQzdNb3Y3R1Y4cHBEYklUTkd3MmZpNUN2TlU3MEZ0Tm1VZEJl?=
 =?utf-8?B?SkpJdnBwcFNKQTdyNUgzMmdZVHBDa3FxNTVPMlB0eU1LeWpOR2JqdVRlU1c3?=
 =?utf-8?B?a3piY0NYdzRvbU5Oc3k1WmNUZ0hNaTdQWHhRcXdwV0lSWWYrRmh4TE54OVNq?=
 =?utf-8?B?VUhRTnQvM3FQTWw2ckhmRGxtVnpHZzJ2dXJHRGV1WnFhb0FQNFdjeWpPaWNC?=
 =?utf-8?B?RDMxZkRrT252QkpySTl2S1pBVVRtL1VMR2pwblF1N3VFK1lzNU1LME9LVlQ0?=
 =?utf-8?B?SzZLU0FJYXUxRnpqa1ZWZGxNbXlQWEtySWdRTWpjdHpIZGE3dG1FTDI3Q3px?=
 =?utf-8?B?bTdGZzdRYXZSRDV5WXhZMVdSd2pvWi9HTXQ5cllGcUhaUE80OTd6WDB3Ull5?=
 =?utf-8?B?ZTh5ZGxudllYWnZ5OXp0VHBkS29Nd3k2bEpYTnJSQUlWK2Y0K1NNdlBHZ0Vu?=
 =?utf-8?B?azRtWFhFT0VBMVBPYXZ1TzVUNnVzajNBM21KTEFUK1NMeUxUc2JkOU9PYXNt?=
 =?utf-8?B?YlN5VkxWUEs0QlNwZjBtK0IzMi9uOWlvc0tpTjJ3QUJ3V2puNVkvRVdBZ3RU?=
 =?utf-8?B?eEozV0p6SCtZb0FoOHczOG5KQmhlamtUc3dHMDFQdnZCZi93OXQ1dHlONnhT?=
 =?utf-8?Q?00+9TpLxpt9+Rd2xi9fgBj23wutdtLS+nhb6A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2VvQTlKckFsS1ZtVE9nK1djZzZEOSsrVWR3NEJqcWtvUUM1L2hOZ3U2WlNj?=
 =?utf-8?B?Z1Zzcnozb3ltTHZGbWU1ZGxwY3pkOXBQZldmbTZKSnllZVM4VEtuQ2NkK0Ji?=
 =?utf-8?B?NEVSeklCcWlhQS8vbUVIdDR4QXdrTHhXWWVXbFQ1dlBZR0pzVUJNNm9PY2Za?=
 =?utf-8?B?d1RCMzBRN2ZHTGcwbEhHVEJUbWU4ZHptc0hhd2JPb0d6NnNQZXdEUDROMGo2?=
 =?utf-8?B?YUY5K0U4QnR0OGZQQXZiRXlPUkp0cDlvVmk0TUF0QlNjbTZnSElMOHJreGh1?=
 =?utf-8?B?Q0VKVjdRamtOdEJROWl5M0t0cFlvQjVzVW9rSTFJQldhRlhnS200ODJ1TFN6?=
 =?utf-8?B?T2pUZVJCMFBSWUs5YjRRRGJkV1VnNm5RZXBhRFFzQlY1eURnUk93bnU5d1pK?=
 =?utf-8?B?cHF4UFdFU0lYZ3p0SjhJMzYvekVpVkZJa0w2ZitFWWx4aVR1QWFCL2hkaFVL?=
 =?utf-8?B?UFNCREpJT0xEQnhmM0F5bnpxeWc4VjJDcHhMNC9EcklzcGl3aE0wc0QxY2VY?=
 =?utf-8?B?UVpDN2daTDBRY2dnNHYrQTlrcGNhQUd5MDUzQzNWWnVzTGFxWmV6MHVDNU9B?=
 =?utf-8?B?Qm0zMUZMb2FsY3l4Zm9TSTkxZXNYMkF3OUVsa0t5Q21vMUpuWkJzbnhvTWVu?=
 =?utf-8?B?SVNvRzVwVWZKeXMybHZUT1hlUDUrcExLRjZIK3hDV1MwN21lUFcvcmpIRW9t?=
 =?utf-8?B?ZWZmNjJXREpOL1ZNMjBUemMvZVV3VDA5eE9QQ1BGUjluZS9Hd3ZsMDhvTUJG?=
 =?utf-8?B?U3VoWm5RVno4RG1PS3kvQnRUS2NXTnJJaFoyMEtMemdENlZmVXBMRTZlQ0Ir?=
 =?utf-8?B?MFNFdmtxamR2SUM3N3BMM0k3b29IYnRMWDFkUHliM0lrV010QkpnYkxBdXhk?=
 =?utf-8?B?Nk14THJpTkJQcVpmMTBEZ2J4bExXczBTUjhUbnZRaWplNjZyVlBtYUM0MEox?=
 =?utf-8?B?a2dVdFFCRkV4alJXWWpReDI4VDlFamIxWjJUU2lPMnByYmhtemE0RzQ1VnJO?=
 =?utf-8?B?MHVyZ3pCNDQ0a0FPcmtTRlVqRVdHK3c3RjloZ0pSaDF4THNkTWtKZmplbnh4?=
 =?utf-8?B?ZGd2QVJPaHdSd3Nmd25tZS8zODJ5ajRFendSa0E0dmJGUkZnMDNTSkVtODIz?=
 =?utf-8?B?bTVpcU83ckRVQktQU3FOK2tDcUNQMDd0aTBVL0h0Q3k0SUg3Nyt0ODNVY0ZN?=
 =?utf-8?B?TGt2NHBPR3VoUUJBblA1a1pKWFhCVGVpR2JtMjJLV09KT1B6TEJlQ3RkU0hN?=
 =?utf-8?B?UnI0UTFKWVFLd1p6eEV5dytMM3Z1ZkUzWGtabHhYblpVV0VPZVlyMFU4SUpN?=
 =?utf-8?B?L3o4Mnp0b3hjenFFaVJjRFN6WlFlQml4NVd6WlBUYTgybEVIOEdlM0YvUG5G?=
 =?utf-8?B?L3NUM2NhcUYxWGtEZlp5dXQzeDRpUW16NUVBNkNQT0Z5L2h0cDhWanAwRFBE?=
 =?utf-8?B?Tnl6VG84dDdiWTB4MEYwUnRsNEZsVXpzL29wRCtpVkV0WnJSSVVacTc4MXRV?=
 =?utf-8?B?NXE3OGt0dnhXdXBaODR1RHE0NFY5MllvY05zNVNTSVF1THNLcC8wazB6am8z?=
 =?utf-8?B?QTZkaEJEeHZOUVJ1L3hxWW03WUxtaXBYWk9lK1AvQUZwMERuSEpkbGNWU3hT?=
 =?utf-8?B?U2xNelRTNnkxQlhvSXhMZTNKNGFPb1ZCdFNxbHd4d3lRanJuai9DUmxrUGM4?=
 =?utf-8?B?aEswUUxPR1NkSms0bEtMaGYzNlZJdkJDR3AvV2tUekJJK1d2d2grZVMvek9N?=
 =?utf-8?B?UmFnQ1c5UDhSeWxSU1c0WURreUJydG52Nzh2NnlGczQ3bERXcGExcU5kUHRQ?=
 =?utf-8?B?cVo5S05PZjdyUmdKV1FOem40eTI3Rll2UDBNVmVvRitRSEdldENLb0xXSS9s?=
 =?utf-8?B?UU96UHJWSnV2NzNJSjJ2ZkJERVNFM2FqblR1c01xS0pieEMrNEpveThndVFB?=
 =?utf-8?B?Y0NRN01xSGFDb1JBS2xHd2d6dk9lYnlBVGN4UDlXZjFQUkdDSzZUVjE3YS9F?=
 =?utf-8?B?Q1FJay9aM2ptRjhtVGtFdTljdTJjMng4TjNLODFPbUxOUituQ0pmTUg5MUF6?=
 =?utf-8?B?bmdWWWlSK0pVSUp2MXloNE1KSzNpR3d4QUhLUk56V1ZIc0NTcGxnUWd6UEh3?=
 =?utf-8?B?NkJVL0tRRTN4NlJTRmthMllMbjJuRndYUWhnZTN1ZldEREVxZXJxMVg1Qi8z?=
 =?utf-8?Q?VlN3L1Z08zz6T/KmdS/wP1c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d41903a-34b1-4f20-cbee-08dde8ca8e1b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 20:11:22.4133 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2HBQN/xWSUIu4DeCQX6M+ZdMgwGOqyDYypn6qB83sBk9G7lBHfUa+/Q6OxE12qUxz3gv/Vq9aya2Mflp47j0nKos8DanpkQ1UW9zWDs4HM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10409
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

please see 0x00_8000_0000 -- 0x00_FFFF_FFFF region of memory from
https://developer.arm.com/documentation/100961/1100-00/Programming-Reference/ARMv8-A-Foundation-Platform-memory-map

According to it we will have only 2 Gb of memory started from
0x00_8000_0000.

Mikhail

On 23.08.2025 16:26, Christian Marangi wrote:
> On Sun, Jul 27, 2025 at 03:03:30PM +0300, Mikhail Kshevetskiy wrote:
>> On 27.07.2025 14:58, Christian Marangi wrote:
>>> On Thu, Jul 24, 2025 at 01:30:45PM +0300, Mikhail Kshevetskiy wrote:
>>>> On 22.07.2025 21:44, Christian Marangi wrote:
>>>>> There are multiple version of the same reference board with different
>>>>> RAM size and it's not enough to base the RAM size entirely from DT. To
>>>>> better support it use the get_ram_size way to scan for the actual RAM
>>>>> size of Airoha SoC and increase the size of the memory map.
>>>>>
>>>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>>>> ---
>>>>>  arch/arm/mach-airoha/an7581/init.c | 23 +++++++++++++++++++----
>>>>>  1 file changed, 19 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
>>>>> index d149e0ee3c8..0f72365c4ab 100644
>>>>> --- a/arch/arm/mach-airoha/an7581/init.c
>>>>> +++ b/arch/arm/mach-airoha/an7581/init.c
>>>>> @@ -2,10 +2,14 @@
>>>>>  
>>>>>  #include <fdtdec.h>
>>>>>  #include <init.h>
>>>>> +#include <linux/sizes.h>
>>>>>  #include <sysreset.h>
>>>>>  #include <asm/armv8/mmu.h>
>>>>> +#include <asm/global_data.h>
>>>>>  #include <asm/system.h>
>>>>>  
>>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>>> +
>>>>>  int print_cpuinfo(void)
>>>>>  {
>>>>>  	printf("CPU:   Airoha AN7581\n");
>>>>> @@ -14,12 +18,23 @@ int print_cpuinfo(void)
>>>>>  
>>>>>  int dram_init(void)
>>>>>  {
>>>>> -	return fdtdec_setup_mem_size_base();
>>>>> +	int ret;
>>>>> +
>>>>> +	ret = fdtdec_setup_mem_size_base();
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	gd->ram_size = get_ram_size((void *)gd->ram_base, SZ_8G);
>>>> Can we use a memory size passed by airoha trusted firmware instead of
>>>> playing with  get_ram_size()?
>>>>
>>> Hi I received some feedback from Airoha about this and sadly it's not
>>> possible. There are too much version of ATF and only some of them
>>> provide RAM size in some way or another. Also there isn't an exact HW
>>> trap to read to know the RAM size hence raw testing the ram and not
>>> depending externally is the only solution :(
>>>
>>> I will address all the other comments.
>> great.
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  int dram_init_banksize(void)
>>>>>  {
>>>>> -	return fdtdec_setup_memory_banksize();
>>>>> +	gd->bd->bi_dram[0].start = gd->ram_base;
>>>>> +	gd->bd->bi_dram[0].size = gd->ram_size;
>>>> as I know u-boot can safely use only 2Gb of memory, thus it's better
>>>>
>>>>         #define CFG_MAX_MEM_MAPPED  SZ_2G
>>>>
> Sorry for coming back on this but by declaring CFG_MAX_MEM_MAPPED 
> aren't we limiting the memory to 2gb? Also these info are passed to the
> kernel so we are limiting the RAM also there. Am I wrong?
>
> Also I notice the weak function dram_init_banksize is exactly the
> current one with the usage of effective ram so I guess I can drop it
> entirely?
>
> Can you help me understand the usage of MAX_MEM_MAPPED and confirm this
> doesn't limit the total RAM when loading the kernel? (we don't use ATAGS
> as we use FDT)
>
>>>> and replace above line with
>>>>
>>>>         gd->bd->bi_dram[0].size = get_effective_memsize();
>>>>
>>>>> +
>>>>> +	return 0;
>>>>>  }
>>>>>  
>>>>>  void reset_cpu(void)
>>>>> @@ -32,12 +47,12 @@ static struct mm_region an7581_mem_map[] = {
>>>>>  		/* DDR */
>>>>>  		.virt = 0x80000000UL,
>>>>>  		.phys = 0x80000000UL,
>>>>> -		.size = 0x80000000UL,
>>>>> +		.size = 0x200000000ULL,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
>>>>>  	}, {
>>>>>  		.virt = 0x00000000UL,
>>>>>  		.phys = 0x00000000UL,
>>>>> -		.size = 0x20000000UL,
>>>>> +		.size = 0x40000000UL,
>>>>>  		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>>>>>  			 PTE_BLOCK_NON_SHARE |
>>>>>  			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
