Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190ABCA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8C1A4066A;
	Mon, 12 Oct 2026 16:03:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHssJa7LsdoZ; Mon, 12 Oct 2026 16:03:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EEAFE40665
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791821015;
	b=OtWxHTjc8f+EnpoEXl1k6zeDRqGwlQw65KXrO70cqbI+m9cjwlBXfTs4f9e00HoIqsV+
	 493UuitQPIP18jJG/e/tVqpjrPbHj1A2xEH3+HevK/RB0M/CyPqKBrgdp0TLW7lp9POpM
	 dXQteb75wZ/MrJzAlfOcX4XNIoF8/pyp6qGspNwSWPXk7nQDNFGEFLPpLdG3egmZ0HX6/
	 kBxtrwqd8utvGpMUzgSokGXYygMEE5CwXt4KJhkFk46bD9oNMKGFVW/+eOnCnEYZLJ//G
	 vadihkpXiHXPiGsDfNEQb1S6yMRK+EXyV4se1Jq+grOluUI9nICknAKbQFjGmXDr4fA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791821015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L3kQEzuBihS1VU5XP2AboDQFgKET2123pMwcFN4pdlk=;
	b=mfhp9XtvAasU+S9Vp/cUBg0U3QVZqWTMKZZ4q5zpmrxxtGkfd8FENIO/8jGsNeCi0eSp
	 E+uTzFTvPU/G6uJ80PDGP/RPdSnqIVX8vQjkr2ebn/F1OZr2Lo38y6wPFty18hhCJt3Cn
	 FygxSfpY1siJQNXRZVaoBfonr62zrpyy0zEu9VEo291Vh3POz71EfW32jKoCog0AItsgZ
	 VJ5n9WClmIYRJKU8oGE/W7pdRsitpG02u2G6VikGrWAQNk4ypDUje/RodqYPzSDg1sHNt
	 kJ9IcYLAj220cFdKMgPMOvsyL9mFvmoNAEzIEL7zbAfzmKCdjbz8zjD91lP3BYsc6HQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b="BywfSY/Z";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791821015;
	bh=L3kQEzuBihS1VU5XP2AboDQFgKET2123pMwcFN4pdlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VHoaDK7AeD6+AdG+Vlt88M3kuB/s70lck//uNLvCin2DlIrpV1v8g2ql2K8hKnziL
	 SsWqEdj5d6seMS0K0R8Mu9OXSQrRazTYDLk+B1S/PEmuk4oIihrGAwvbKsvGm5OUK0
	 iTqh5gogffjx0b7nrLq3K9XrdMKsCjrk4wRKFGwQHqK20/k4mpNxn7QPo8Y9zFZDSp
	 yqeFgq66Hk8G5gbjRVtnGqcn90VuAWnf904ik1a/sUR6TqYGqMP44sBQSpQ6QXqzbj
	 RqtfW92Y5jnsi+ZYGt4QNuqbVYg6RHM55U4oe/SpvwlD09D6b1+uREp9AwOnIoP9i1
	 lh1XX8iCK6tHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EEAFE40665;
	Mon, 12 Oct 2026 16:03:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BCEE105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D31B40519
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s36Jvdk9fkVv for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 677F240515
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821012;
 b=l9k3EDimeDjWPq1m0Uwy7rTKA+lugT/xB9eQT25eKHR0E+g59uXuoq1MDYom4oWNgMsB
 0qIBnd2xfOH69KYmPPJjGjmmTqn+RRtXQ12K4scpRxlkAp1SEDK6cK5eq8Pqcf7Ft1Dq2
 zNLjaIgW2yN7iJHUJtbIwzU9RACVzoeB8UrYoBcSVKrOuXmiXZiFWT45kfNIbJ6NJlgmu
 5kO83eJZFjalcou2zi1mh7Zd3KvSoKmiV4kv8b3leGg++94ccJ1j28Xn066ZuHrWyVO51
 H7QxxVxHb4MNPdNFtP54CXdPPtEosAW+vSbcSje+5m//YFBHUWLyOznDLkOUjtVuWyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821012;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=L3kQEzuBihS1VU5XP2AboDQFgKET2123pMwcFN4pdlk=;
 b=Itu60YIs8r2wNc60bUlXQ6a1LoZJWqZEj8Pm7FA/ehwnsB78wmQ7U3NBTvERONy1NEMz
 q446QX4V25x0656TffPwz6bSFSynFv4WKrHOaqQnKIIfIxjfQjiEJP0kVwzNfKGsgy61Z
 AWrXTJP1KHkrli3bORAVmoFk1oOkd4oNski9RvQlACc+PpfiE+u1ZKKqHG/8kTh0zHju/
 a6cc3NSsyHz517/SmczfgfzemithG6XvZUPPH24+FpHMHSofKlMCotoRb9cofBgdRd1tt
 x+gSxfP22RCh25jQixg+J+pINcWIVZOXse21BXKgHrDA4JhAxbBk8Hg+VRqnRTKUpRg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b="BywfSY/Z"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=BywfSY/Z
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 677F240515
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:03:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP5h0jVyL6Bd5yDXqTnfZOThgrwlqHoEA8BNSSnesQuCLjPpVJD2FaHWFO7JzgakilnGukZudDUHN69m+XffGqR6Y58FWWIM1tntptUxwl3iPyGpoud+KAZr+reVn/eLUDTl3kx4SIolQu9y365VNqPZPlfGXCiZ4OkNLsMTRyqzUxUv3ZLmls2Dko0U1XWaaGId3VVXdwonL4Jtr39BpPECZxOpbG6LMHHLSbnkFr5n8NZ2+OJjSY43TZQKaTkfEtRj4CAkfAhq9oLC1n3i2SFsE4K5GaKnX+n33ZSKc9ekeeFicJ2KQs9YX66DXvHEObTWB4PD2bhzAh4K4nwXBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3kQEzuBihS1VU5XP2AboDQFgKET2123pMwcFN4pdlk=;
 b=lFnaUlRoOSKxmXeRLfoURUVl27/Dn6S7I7du0bDU7PXSYVIJD/sOgvwdUUbqY24UwAE6f1Lnb7QHWpjxrd4TkHqW2pIitL2Fea9TTPTOjP5zqR0Td0tKSeAtnUxb7Vtq+aOCp1WgNmvuFnL9PbGPw+Egj84y84HxrZDdluCNWsFWZiqduycKYWJ7rhW1Tl7YN0+Ius3lafwSwIK6GUcl/UWZ0jZrVCS0Ci7FlWnzfctCb5J2sQTz/yniFq9/zfI47q8jnG9JRnehXQ82zd8X3elfq6zBnYpD7lrhSyR+QNdzl3dOmoVL9tvCC+712eTqZ/B5rpNYB4Xb04O009IIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3kQEzuBihS1VU5XP2AboDQFgKET2123pMwcFN4pdlk=;
 b=BywfSY/ZLYILHT2ebvSe+52peWJHR6mVD0nwfoyBAp9JmUSuyTGeEaEbi9Ho+6n0r6iIiSQerOM4yJa25R/5in01mKs4FV1EClNcrlJQpTpcdfDyb9STJGKupNKXTL/KOvI1/pocbKp7EYcovL+rCAPuTJMuzcu5e9NZRl7ExCc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GVXPR04MB10110.eurprd04.prod.outlook.com (2603:10a6:150:1b2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 16:03:21 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 16:03:21 +0000
Message-ID: <73ab5b85-804e-4b5b-afe2-e871d8cf8b2b@cherry.de>
Date: Mon, 12 Oct 2026 18:03:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] clk: rockchip: rk3588: Always initialize clocks in
 SPL
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Lukasz Majewski <lukma@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Heiko Stuebner <heiko@sntech.de>
References: <20261012111552.1173161-1-jonas@kwiboo.se>
 <20261012111552.1173161-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261012111552.1173161-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0121.eurprd09.prod.outlook.com
 (2603:10a6:803:78::44) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GVXPR04MB10110:EE_
X-MS-Office365-Filtering-Correlation-Id: eb040b17-b7af-4823-3f14-08df287a567a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: emrpNeIYDqc+Nyoe7xf30vXMll4tUxRbOnCAFJk0yN9gsJok7EVTFOMjLg6pbiY4VIA9IA6UBYhjYeXXs/4XfyMJbkyvn6broJaDfzG4jbn+0ePyHTwEw2iFJii5ALi3AGiG1V6rKtc/b63Sx3g9VQXPhJ43Pfkk6+z3v4HyERWMQ+tse5HI3VejRptzwEqxU3P4xmIu0+cFoF93tAHaM5+TavpL4zZC9ti2VhIRmxlBEXN4pupNz09xxfFf2x2bmhYM2tXPv8uUyzmAX1+CaTEzGw9soBeeLSOPhmSZ+2zl2+MEpMmOxQ1UKirySqR3/5SUOZTHcv+Kzcqx5XMLcSs/Cm4l2PBbjapZBX0SMSWdwfyIyOMvByk0bUb/h+c4CAMc+WfJdZ7hZnUZlt9QzSkgCgxea9W8iLB50Ck/mn4JIeu/JlfgihJZn9Bjxx2kNPaR/GMYEZyiLDUJwFP6t98QfNmbUTN8GIYJE+D9d+d+/SMY/WctAHoWJU/A5MDwoUqBXe0bAVWCSjJT1i8JNPmy/ERnQUFp2zEvoFwpB5NhcnAbl6gjGHQoWOFWPLNN0nVIyyhoJ9eUkWDZ7wgYCGEH/nyheKwKszQETzmeYXy/mrEz7yXzuC4kDx2HWt7bpIudBwf9uE1kdHpOf92iLajrrNaJmas3gGLTVGVG/Tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnpQZVFVRUZ5UkdqRE1MYXF0R1BCVENhYVlOWVVvWUM3V20wcEFoRFlPRXJS?=
 =?utf-8?B?bzlpQXNyNkJZWkx4Mk0vL3FkUENvSUNOenZWMEZ5WFI3Mm5Mb2ZPMXJ2am5V?=
 =?utf-8?B?K3NZNktlWkdYT0FuOTh4a2J3R29rNktFMXBzTE40c1dhcGVRMnFicjJPcGFz?=
 =?utf-8?B?UTlTT25WV1R3a3pCbEl6WXdCQmlSZ2hZTjlhQ2taanFFcXFOMzE1NUJ6QUdL?=
 =?utf-8?B?dHJYUTF2alhFUFlkNnMrVDVkaFZkbFpqK1I3SlA3dlRlMk1yY0dNeFdWUnA2?=
 =?utf-8?B?cEJud213a2d6S1BIN1NTM0Qzd1Y4ekM4Vlh0T01iSy9YTmUvYi9uZFhSczVM?=
 =?utf-8?B?a25IWFI4UlVWNUNuRGY0SVNCMWVjeWV2VTRONlF3a0ZSTWR1K3R0VS8zM1ow?=
 =?utf-8?B?dEdEb2luOGJUaitoTVB3WTVoV0hoU0ZEOVJBa0N1cWRFWFhocE0wRkt0UFRZ?=
 =?utf-8?B?VG11NkhoaHE1Yy9kSjU4R0gvaFRySWtEdEwxeTFWQzFRUG1Lb0dLN1VVcDNk?=
 =?utf-8?B?MzVpT2lXRWpBZWJNR2V1VmpQcjVjYnBncTRDZ2xudDg0U0tLTklaTG54WkR1?=
 =?utf-8?B?VWxjSjdJaGFIUldITzVBcHpmY3NmdDlLT0loM3Q5MHRjTTFuaWgxSTlHemFa?=
 =?utf-8?B?eVNZQjUzVXVCL3M4WFI3MkttTEhzUUJyL3Z4bEVsRHZvdEF4a25VVUl3aG1I?=
 =?utf-8?B?bmNPaDlhQ1ZNcmY5MVptTlN6Rm5aWWJDYnRFNDVtWnBPRFFINEIxV3p6L0F6?=
 =?utf-8?B?eHhwWDZjUVBIc1FRRFVXczk2VUpJNEwxUUh3c0FyRlQ3dnBYSFFpYjJBVGxo?=
 =?utf-8?B?TFBpR0NxQ2R2OWZuN2hTQm55Sksxa21FRWhZczI0U3VxT2VPTDd6MkFNWFNF?=
 =?utf-8?B?OWtabEw4THNnWFRqblp1OXdGUU1FZ3drNC9lM1pTRDFBdytHSVJ5RmQwL1lF?=
 =?utf-8?B?UjNtNlR3N2MrS0JseWxTa3p1b2tQcmFtNWUzNThKeDhZS0pLMlI5djFDRkFC?=
 =?utf-8?B?V0hQQmxrN2Q0UEdxWGxQdTc1K2RUWHJiQWhOQzliUjF6cldUNXFjZ05GdW9P?=
 =?utf-8?B?TmVyTzUrbHhDUmZHeWJpL3pvbS94YStaUnl5MlhBK3ZxK2FEZW1hdm4xSjAx?=
 =?utf-8?B?azBmU0EvSWxPMmR0eTdTSDduRzVnQXMyUEFvVWxqZFo2eXpSOVNzT1JXT2x5?=
 =?utf-8?B?bG5ESEhMRnlvSURhSWV0Q3MvUnMvR1VWckgvNHJrL0hrTjEyQTBjNGRvT2p1?=
 =?utf-8?B?NFZjM0FzU1J5RzVFdTdrVkdWY0VuN0krRm1ieU9iekZOc3dWVkxmSHRJVGVV?=
 =?utf-8?B?Y1lsM1Z2Mm5LSWY2RXdVL1pGSHAzb1d1ZkhNZEVrR0FBZ3ZFUkJneWdFdWNL?=
 =?utf-8?B?RmxkdHBwRU5USXBBVjdyWHlhVFdGT3VFYWNmV3JjNUVWcExoa0ROWExWR3ZV?=
 =?utf-8?B?dXJESkwwNEp4RWhEbzV5bEpFYUNBSnZMOERMMFpFL0lFV24zL2tDL2I4dGcv?=
 =?utf-8?B?cmZyQmJUaUhOQVl3RkpNTmsvdDFoWmUvN2I0V2Fzbk1wYnYwT3N2VTVDSTJi?=
 =?utf-8?B?ZGpxMUFSTWJJL3RMQzgyOERTdlBOVlZnSnFzSFhyVFVEUFpSQmlDS1krWXpj?=
 =?utf-8?B?aUFiN20zWWt3cGFwTlpoNnQvQ01XNjdoSkhkUnNVbWhSbTVNbm5yTFh2RExK?=
 =?utf-8?B?LzY0dUxDUEJwZkRyaUF6QWlOREJHMVowME1HNXp1SzJVcUhiN1hIV3RBTkZy?=
 =?utf-8?B?YmdEbU9IQnVUMGppbWs2RDk0Q2ovV1hrM2RYVTB0TDJaMVc1WERweHlwbVhN?=
 =?utf-8?B?L3VKSktBb05KWmcxT3dOK055cloxL0pVeS9SeVFsdU9PbzVtaXdxZElCMmd6?=
 =?utf-8?B?NUVsT0hWQnJ6alBMZjh5bmNWRElmMEJwQnoxMWZkMGFuOHgyYlFobWZCMDdy?=
 =?utf-8?B?S24xQU1mYVVyaUlVTVRHSUxUSlhrQWpUY0Q2MWE1dkQwU0E5SXhvd2dqaHl6?=
 =?utf-8?B?VHZ1WW53dWg5cmdzcnkyM1h2TFlFaGRNNW1mL1hSSTNYQ0NwY2xvWEc0Rnlh?=
 =?utf-8?B?QzhpQnhYeEVybVhrV2dSSkw4UE9VSjIxSFNiNlNocWkwYXVKZ2hieGlTR0dl?=
 =?utf-8?B?OGhBdzFzR2w3NVFBYjNlT1RHOExCd0dnaFgzTGl6aFdJZDNqOGFUeEJ6dGxG?=
 =?utf-8?B?dFBRLzFVYk9pUnBiZEdnaHRqSitZVlV6L3hsbmUzRnlwWVU0SEZ0V0l0QTJP?=
 =?utf-8?B?dkgvTEoyWk43ckRDeFF6dU11UUFMV0FXcWFweVQwZVhhc0s0bG5vRnVwZzZj?=
 =?utf-8?B?aE9VdElUcjVqMDBNVVZmM0RKS1hPb1FrUHlEODlBZ1ZGUGpDMzNmUGhNT2Q5?=
 =?utf-8?Q?nG26gp0bt+BMgpVPln6BSh6Vol6tNI+kuk+wNfA/vPJp+?=
X-MS-Exchange-AntiSpam-MessageData-1: F4V1UScVWdPK7A==
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb040b17-b7af-4823-3f14-08df287a567a
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 16:03:21.4120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkMn9VCA5fLVoiatsY9h06nuEVGk0vzQDgd8CdvzxdSB7XV9rJg033fyVFkrsqKLIGA+OVIIElxMyDqruZdDdd13WHnXD/deFCnRihMlXnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10110
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

Hi Jonas,

On 10/12/26 1:15 PM, Jonas Karlman wrote:
> The RK3588 clock driver configures the CPU PLLs and SPLL when probed in
> SPL. However, the driver is only probed on demand, so this
> configuration is skipped when no SPL consumer requests a clock, e.g.
> when booting from RAM/USB.
> 
> Prior to the commit c6bba31dbdd4 ("rockchip: spl-boot-order: Defer probe
> of boot device") all boot devices where typically probed, with a side
> effect that clock driver likely also where probed, prior to the
> boot_from_devices() call.
> 
> Flag the clock driver to be probed after bind in SPL to help ensure a
> deterministic probe and clock configuration behavior prior to booting
> from devices.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
