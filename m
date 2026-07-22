Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5B7C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 03:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3E0880BE0;
	Wed, 22 Jul 2026 03:55:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JwGG4T-DWpn; Wed, 22 Jul 2026 03:55:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E41BC80D49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784692513;
	bh=eYYkQopYztEPvh65KNnNxBtZPwv+buWIxc1wPJXIUyg=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=bXFhrqsOKvrjr159bFq8K/8y4KNvJLIFVr4GH2DxNrA3SyCc10w1f7uULchB10gHJ
	 p1veJ9KO08Jf0FLESdJLg4Wz4nYJuozTGrqee9g+GpA+s9GTvJJP3auz/JdQBbnNG9
	 O/b5I/4ERqd3Ifl8+K6LES1alf+8QmGR3uUcghEaHxx3IE0F88nLeeSYZaxdjMehIx
	 wSrM1uU7gU0HE3nbF38eUfgxQCy+1E79enVjAT0jeTVVZJDpBREj1CoCGGySI6kV7V
	 r1n9iAL5HvecQ0C2K2jH+DEQI/5LyfNw0gEvVQXMNuEbK/nj+YPESI912QMBEeDnXQ
	 G8l7MjePBn0Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E41BC80D49;
	Wed, 22 Jul 2026 03:55:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A08D6EB
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 925EB4004B
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vn-huRYa7EKw for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 03:55:10 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dinesh.maniyam@altera.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8996A40052
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8996A40052
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8996A40052
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:55:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FDC5846A4; Wed, 22 Jul 2026 05:55:07 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6989C803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 05:55:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFy6Tn+qMv6KKZGPAgNCnpMZ+kjWE9avi+IdIADTj/TWr3nyaoPrGhN4DAZeF+MoOIGlnl9PRxCPVh7ZGCRC2SKLyOmyX/2sR+sq1Ae4/W9i6HPSX6bfyTspgFxSO8J3JVrOYtlV2l6AVFmdqa7eygxbUasDcQ73es/nUjZGlKVXEGcyYEINTdkHQk2eHsh6HGo9UXstWGEXHLiaSO5uuI0ngpN+TesMq6JybYTSWr+yfwJU8QVSsgQx2Zm5RpBFhhksmg/LPMBlx6edFC7zFVh6a373lgXt3ZJmbPaVDM6iGHMrCq1YTZi/OXCOc+hxjtbEsmHPmQeIyxMdgWUxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYYkQopYztEPvh65KNnNxBtZPwv+buWIxc1wPJXIUyg=;
 b=UyVXrIIpl8nIXk4NOFS8b3D4C3+393cgT9PzVjYHe3TgOj1aqkNeqjdLtof16INjoIceO7jUiM69c33N7RYQePkEr/T+P1NWOlwHFg0b8cRgSEAOItEuk1adnvAJDHyfxG5sW/uVYVXVL80mfFzM+K83AV71lGE9eE3rQI7vY7JPKA5R7JIN+Rf+50LOnY4yza3iHV74zFddqyCCid27zaLU955QgfGa2bC0eXlY1vLYB+XtGdLKgNNUkXNkRN4rXksy97k0Woe3p8QtXqN6PoJY7TZdRmCeDnjaJnI1c0djQOZvrQb0WDP9YcjtplDfr0X92+ZVZBz3Z43oZmwOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB989364.namprd03.prod.outlook.com (2603:10b6:510:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:55:00 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:54:59 +0000
Message-ID: <63e12ae3-c214-4aa0-8634-a3df6c069660@altera.com>
Date: Wed, 22 Jul 2026 11:54:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] i3c: dw: fix slave device setup after DAA
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
 <20260709091357.1860417-5-pranav.vinaytilak@amd.com>
Content-Language: en-US
In-Reply-To: <20260709091357.1860417-5-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB989364:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5d0f7d-6712-43d0-d501-08dee7a5006c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: sf4Nt7yrov4gRpck5sgxjo8ddD3cIgOYWeIrvw+yL6oiXYbdP4ZIJX2QvvX1W3Qh7XnJiiBEauPo4UK28kVd5o+OeP5JV6AdoWMb3umBoPNgnyFlqz+ZdLvCd0gLC68OdmKOpx3VFsrthWCsvDNtBb1IitvaNeU4aOnxazo6i1m204TOtuqeF31QIwkI2MB61pf13AfnsIrIKU9FFCelCkqIOqe/Sij3LC+dv9W53thyPM0XKN+j8zImO+ZtvsD+S+YR0hf5yU89kpDXE34t/yLprga+nLphePABW8g87V1EKf/dQB9KYn5QeIIosPTPKohV8Y8vT61ihS0L5QonQkca93i5foliWY9aQ5qioYhwfJRC1x2O1W3PxKj8HIwd98rgIk/jG2b7/PAJ64k0Ir6CIhB56H/Jets7WA3lORPrhO7qFEHz9ZmQ7KPja5w8yGAFUFktITa543gLsfRHKQ7xb+w5xDCB+9S/4oDo8f15WJHbpYfIuv/43tZlNb2RdVUifUUOSnFIk6V8xxYv2se9se5M4ZTWmMKyk9V2f1iluwvbgrRN6U/8+eGNJ+FVi7F0W+ASfQwd0ENBZJZx5o2T6Ccx0DT/nhtNMnA4RrAk1zN8rFpD6R9SXfVOWu0vrEZUylnapqraqvA2IqNfGmsIzAJsRlw5b07tJk88x7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkVDZzJ5ejBJYzAxVGxwZWovVXFERDJvWUVNNHozSVJWa2lhQWUrd0tDS1d0?=
 =?utf-8?B?TjZuekd4VkYwNCtHYnY2cXdLRE5YcnArQ1A2SjBNYlpPRmRkZHorMUUwUHZD?=
 =?utf-8?B?MUxZdXNRVmJqU21oN2c5c2hVdWFLRW1HdTRKZy9wZS9ibWJDSG9ld1NIM0w3?=
 =?utf-8?B?cUNlOENDa1lzcmJUL0hJalEzZndNN1UzeEhqNHVkeEs0RTdjcFB5YTBKTlBP?=
 =?utf-8?B?RWRDVk5ReVBGbmNicE91Wm4wSVluK1ByaFlOMzV2VSthVm5YaHE2YXhlZ1lX?=
 =?utf-8?B?Zm0reUY1QlcweEhIVTZBcVo1NHlUSytlQVlTeTIwUlhNZ0hVenMxZlRubjVk?=
 =?utf-8?B?VVhvTnRCdzJLVVJ5Z1h5alZkWS92Nk1PcGc1aGdob3d3YUhuaDFKOUUrVHY4?=
 =?utf-8?B?U0l6VGN5SFF3SnBlZkNrQWhmZ1R6UkdmYmswWGF5ZlRpd3E1KzRpV2pZODBJ?=
 =?utf-8?B?eWc1bENVZUhzb3FyZ3RDTmlvajNwdGJGSE1IVUxlVG1iOFdmYnhiQVg3QzZB?=
 =?utf-8?B?cGpBa2FDUmwySHNQaWhEZXluS2dXQUM2M0psZHBTWTN0SVBaT2VpVXRYQ3c1?=
 =?utf-8?B?NmR0a0ZPVmFBV3U0alFacTh3TkVleFl2T3NocE5CaW1zODhQTUhqaWNlbk9B?=
 =?utf-8?B?SW0zTkRVSkhYNUx3UG9tTmdrS1YxbVFZZ01pVUExT3VsOTF6akMxSjV0dTBY?=
 =?utf-8?B?VEJmK3RFSjI4UG1VRG5JTDZPclF6LytHMmxkRHJ0a3IvSUFLRnpNSkZGYkJl?=
 =?utf-8?B?aE9OemxSb000a0Q0L2NyOUFZZ3BGOEt0dlFRYXFnazF4T1ZPT3FBUDJyQ1dD?=
 =?utf-8?B?NVN4ZGlDN1gxVURsa2JSRFF0ZnJJcFgvMzhSa1R2UmxicTVMRnlFc2lZRnVU?=
 =?utf-8?B?TTZLcHRDckZVZm9sN1d3MCtrK1NPWnk2TVhSSGFCQTZzZWtuNlV2THl1aGgx?=
 =?utf-8?B?cDBhVElsT3dyK0NQc3ltRGtMcEUrOTk4cjN4dnZHSDFiMHZTUjh3dlkxU3h6?=
 =?utf-8?B?emI5UXRvSitJUTZ6b3FBUUFJQXorajFKenZEMVhLaGcwRE1heGNzaTlQOUNT?=
 =?utf-8?B?ZjlkNEhJNFhLSlpUWkNpaU80MDJFMjhhblllelJCUThnR1VzaS9sUjhGUk5z?=
 =?utf-8?B?SFFqNDdRbThNZlVLSHZMSnN3U0Z4cGlpdE5JSjdLc0dRTGFUWG5NUndUWFFj?=
 =?utf-8?B?ckRqQUR5cGJXQlJ0KytvUm0rUDdpMThHeWtWZmV6MThKRlFlSXRna3lkRHpH?=
 =?utf-8?B?dnRrK2FDNDFuU1RjWmhIcFk3cEFQSENzSWJ2Z2x5eVgvbGJUVFVENHBlZjQz?=
 =?utf-8?B?V2hvWWdmZk9qZTJPZXpLbUNqWmhhNnNsWnhMOVBZdm5oSDVrcWpJQitKMTFX?=
 =?utf-8?B?SVpVbmI4VU5hYVF4TjBtYjRWbktvUnZQTWFmZytKZ2FYc0VOdXF0VUd3Zjhn?=
 =?utf-8?B?N2hBZnlmZGhiV1NEVmRTdXIrRjNUR056enV0eTUxbm51ZHNhMTZlVittK0ZY?=
 =?utf-8?B?K0dqSWduRjl0aUtEZUZOTmtrWUdhcjBaVW9nd0VJN0JTWHkzcE1UNHEvcitU?=
 =?utf-8?B?Ym5Yd3pNRS9oV1QwSFFPZHI0aEtENVZDa2tQZmVnbjNXZHI2bllqMjRBdHF4?=
 =?utf-8?B?MVBlMkh3akxHUlNsdHpoaUREdE5TL3laak5tMjhJZDRNdXVNZFJsSE03Q2xH?=
 =?utf-8?B?MjIyWE45UThxRE1GdnYwclZwYXVhRG54SWw3amF4WGVZRGgzT25NYWZQNHEz?=
 =?utf-8?B?M2h1Tm1zVU9VSVhVS3BidHlFSy9CVzVxMVZjWnZtMzBmWXBFUmtaOEdpSHRU?=
 =?utf-8?B?eHdyaDNObVNMNmdmSnVZZkx1WWh0S2FPeG95SHdJaWtiWHc5NVM3K0VRQlZZ?=
 =?utf-8?B?ZkFwTDVHMmdqMjZhNHNRTGNick9BNE5yUXdyNE1uUVJrVHUrMWczbjVneWht?=
 =?utf-8?B?b3JwOVB1azRYVE5BMHY4ZHFBYWk0YjFjU2dKZWlmWVJYSkJkcUlRWHNkRHo2?=
 =?utf-8?B?RTk2K0FTNVZSTlZkSG10ZmU5Q25SS0pRS01rNHpBQ0NYeWVoZzlZV3Qzdmxq?=
 =?utf-8?B?TC9ydzhuRzBPZnYzVi9Qd2ozMHM1K3hXaXp0NTJwTnpzZW5iSXJQM0pXT1Vi?=
 =?utf-8?B?WnJsYzA5dmVSVFlyUHJPNFdCWitnMW5hU0s5NGV0UkY3Wno5NmFESEd6dnpu?=
 =?utf-8?B?V0pnd2tDZUkxVkkrL3dDVUd5RWk0blphTWVHZFZva1JYTWpHR3FQaUFzN2hC?=
 =?utf-8?B?NVZzL3gvajJKQmM4cnRDUGIwWWYyMnRzSUdZemtaQ25qNnVnM3JJKzNNcVhy?=
 =?utf-8?B?M1g2QkpqT3daa3k4NnpndlltTUFHRWRmdkQ2UzhFL1BYNW1TeW53WHBwVmJn?=
 =?utf-8?Q?kyWd9IW8Y3AI8zvQ=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5d0f7d-6712-43d0-d501-08dee7a5006c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:54:59.9255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L3n3xhJAoLzvO9wSelZOVNjQuy3afm+LYk/6yBz+zd1gTfLKdk+bXtx6PBeO0oCAvuixk8xg7yPQkBKPtDEi7kcwqMj/K/YatoaejkqgmXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989364
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYYkQopYztEPvh65KNnNxBtZPwv+buWIxc1wPJXIUyg=;
 b=rxGebW0etGfEoDFaViFwMt80ixNpW4WiiOjswwO87qyolPNSfpfUBCkDMMPYvXsnP1eNH3aFvRoFH1+f6L928nyxZHWkCy+q8sO+vMVFpgKRY22Vb9Qj+PothyRxlHrqUJuYKC+iM7VzgLjrFn0byLp8TDFGAyefFZhCbZKnK/pRIGpAHSdq20u4CqfDWbvKqb8uT9G7O5FBFBLPOECGLZHk6PjV+R0A+LTyhJjfDYjBzDjtU3QxE1vKTcoUs/xPO0npIUAg76cKA/zviy4qbtYNoTTRtWRAicgKZmqEaDKMZwyjAkHJE+Augsg1VV6T/IZbbl91ahSyfwqZz+DBWQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=rxGebW0e
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="rxGebW0e"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Pranav — thanks.

On 9/7/2026 5:12 pm, Pranav Tilak wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> i3c_master_add_i3c_dev_locked() incorrectly set master->this to the
> newly discovered slave device, causing i3c_master_attach_i3c_dev()
> to skip the attach_i3c_dev() callback. As a result the slave device
> never got its master_priv (DAT slot index) allocated, free_pos was
> never updated, and the DAT entry was never written.
> 
> Fix by removing the incorrect master->this assignment. Store the
> slave descriptor directly in master->i3cdev[pos] inside
> dw_i3c_master_attach_i3c_dev() where the DAT slot index is already
> known. Also check the return value of i3c_master_add_i3c_dev_locked()
> and skip num_i3cdevs increment on failure, fixing dummy devices shown
> when no slaves are present on the bus.
> 
> Fixes: 1009c96f1590 ("drivers: i3c: Add driver for MIPI DWI3C")
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>  drivers/i3c/master.c               | 1 -
>  drivers/i3c/master/dw-i3c-master.c | 5 +++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 019167a2dc5..1cf1ffd99cc 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1443,7 +1443,6 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
>         if (IS_ERR(newdev))
>                 return PTR_ERR(newdev);
> 
> -       master->this = newdev;
>         ret = i3c_master_attach_i3c_dev(master, newdev);
>         if (ret)
>                 goto err_free_dev;
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index c6ce54a1d3b..25933adf010 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -671,8 +671,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
> 
>         for (pos = 0; pos < master->maxdevs; pos++) {
>                 if (newdevs & BIT(pos)) {
> -                       i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
> -                       master->i3cdev[pos] = m->this;
> +                       if (i3c_master_add_i3c_dev_locked(m, master->addrs[pos]))
> +                               continue;
>                         master->num_i3cdevs++;
>                 }
>         }
> @@ -806,6 +806,7 @@ static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
>         master->addrs[pos] = dev->info.dyn_addr ? : dev->info.static_addr;
>         master->free_pos &= ~BIT(pos);
>         i3c_dev_set_master_data(dev, data);
> +       master->i3cdev[pos] = dev;
> 
>         writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(master->addrs[pos]),
>                master->regs +
> --
> 2.34.1
> 

The master->this misuse before attach is a real bug (skips attach_i3c_dev for every slave).
Removing that assignment and recording i3cdev[] inside dw_i3c_master_attach_i3c_dev() looks correct to me.

Reviewed-by: Dinesh Maniyam dinesh.maniyam@altera.com

