Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427E606A322
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tSQ8Pmkt;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TiCu8Wit
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 118C76080A;
	Mon, 16 Nov 2026 18:45:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iPtqdCqa14Eg; Mon, 16 Nov 2026 18:45:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B033860793
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794854726;
	b=V9f8kAXngyHEUn7DkpZhhlWcvQxC7UVAiwbJeBUGiWc3GXOAHhdbIBOzBKo4BnCIS2aW
	 GJ0rlrN+a05dxwODI4F0FHdObJkO7QuIOvK3vcTtrwI73PBxbBVzyfykbqgn3Rqeski82
	 uS6G3WX5Io1Un315wRmLtJV1L00xYvvV5MHbjQuyCqZX+8ePtKdqfJ2ubmQaIHkpemDJl
	 IWmyW0I3Pn63HPX0zdwS21LDPwqXjr/NhPUTTwmw4tau/MTnjcT+Bvii+vI3lpPw9tZK1
	 cMZ1seBGRmbMeoDeNYC0fU7leTHLXX4N5jmn0oR7TK9OzNM6XTtAmaNQKvhUaRhs7vA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794854726;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9nH171d6LLx/vi1OHofp772X/8Y37JOEry6yYMdK3+g=;
	b=iG6APwSOYufrPKonviVeQU8Iay/GZd3qJabCKfHGe6OmHzROiHBzbYxgJGRebo3c6NIj
	 /HqAPGxY0RGRue/3W/EYC2PjreSs5etRWbBcmT/Rx5z0mxNdQyh1gcMDYKTiSoqfar1Hu
	 ofmUHauLOPVncBCmjPTeTkAygY+FnjkFtktqyD2LHFwSrA/a6RyaTzbhRu+wzyHNz1vS0
	 f9P1XkFT6R/px0URRFEGVeahlUR3aO7nK8srJdQdHsTnL8v44YFr38CWmDAHLS/75EZyU
	 mhIlBk7VE6XYPKK3b2G98f5W9nzk8/CZ0ybonOdQG8dvkjYyS/aa/HwLPhkJXvrx5Lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=TiCu8Wit;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794854726;
	bh=9nH171d6LLx/vi1OHofp772X/8Y37JOEry6yYMdK3+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSQ8PmktMcTdTHpj7450BBB0RqFu3LaHNREUVzwA2gZIN9n+B4HjPb1kckQNUeNIK
	 EJB4iKbdv8OclbCLXTiVg2nbBNv5mm8deU5SvDM6rLlEhZ0aWEKRpx5jZJcv9+YJL9
	 vBGS3pNl23o6j53KkzpsoW6EcZM+o0wBvojb69qLkqy5pz+xCl2T2KTtxgzn/uBsc5
	 j09LAuInV0dso20N5b6ccYJJ7d5gTv6T6pqm4ycl8WIdcqFFWqMBWdkBAa3LYkxjR1
	 AJw3YGIGDi5Nr7vTW0NR/GA2ttAlvaB9o9pnAnoN+BWG9KYvLBbK0HiToXvCi6cCwg
	 wlN/l+LfanpuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B033860793;
	Mon, 16 Nov 2026 18:45:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F78F70B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3CECE60793
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:45:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UDWvxD60CBfG for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:45:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4D8260601
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=TiCu8Wit
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4D8260601
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nH171d6LLx/vi1OHofp772X/8Y37JOEry6yYMdK3+g=;
 b=TiCu8WitEwviQphPMFqPn4Rb6CmpPR/pgXKKop6MeRlbaNfGOb6hSGZm+kDtZBr/92WHw20mpqEOD5XBJFJ5pxV9gnLFDqaZl45uWMUrXTLgyKjibgw0qtjZU4H4xuumbCaai8Oj2LO9dmifUnIIs+Uoa/0xKap5sLmtmBNJAO0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI1PR04MB9834.eurprd04.prod.outlook.com (2603:10a6:800:1d8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:45:16 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 18:45:16 +0000
Message-ID: <01408c47-2928-48e3-ba37-34b835a3b98e@cherry.de>
Date: Mon, 16 Nov 2026 19:45:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: David Lechner <dlechner@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
 <CALeDE9PvZgwiAUxdX=-tN1fgDveNOkeM__xCCJeZrK3Di0WxjA@mail.gmail.com>
 <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1b9f2a45-4ceb-48d0-afdb-b406404d98bb@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR2P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::10) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI1PR04MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: f29f4a76-4c12-491c-e34f-08df4411c174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|23010399003|10067099003|4143699003|11063799006|56012099006|261021135927099003|261022115727099003|261022113327099003|261021123027099003|261021121427099003|261026140227099003|261026130827099003|261026135527099003|261026121527099003|261022105027099003|261021130227099003|261022075727099003|261021133027099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003|6133799003|13003099007|3023799007|4133799003;
X-Microsoft-Antispam-Message-Info: khOgH2V0x73hhw/c77qak2cPK4fcXO/l2k6pYfRKmzg2dveE5lKU1XABef4t7gmbhhkQ1r/w/bU/RpxP4J/HoRBPFfGmqb2MvwZTERMtDTWUo0+QAG6Q0S9jsE7iz79Za7//Fzf60iVrXA8GhxTsDfX1sKhGyuMGqWNyFtnDfGZsm7GaEoKaDPex1Out7Ac9epFT5LK0b7ocr8J3v6tikjk5PgXIb3+llld6C3wiUCNsTtpCmiYzMzR943/acZ66kdKFuZw9j91GFOgDzL+xxih5dPl+pEyZ5HJ7BIWMGmdx04x0DLmroLiZLpsdN4FL/ulqgLAp4VsXWyBe7y2z/h0ceenC6mXxgCztUX2DD4ghp3YPabZycYF8/z7QV13kjGaaH4oZ+CEEv4O9k2b7AY7PuBIcryS1agA7jkkB/EuuPtjkX5qy0TnfzZGqmzt8S8TzebExkv6uA2KcQtKEKJdKW0RGkyv8PCKguUCwp1dj1A8rkn2aioNiJpFsmP2LC/6zG1er5bhxsE6UoRRp2rsekrCpIRVc6SALVb1Xsn59Cg6xIrHSshGGLiD8Wistp34Rj6nkuS63PpvuDWVsycoKXqEvaiOj4htY5fadTHpeX+hR/AvkEdEqjN8T/eKi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261021135927099003)(261022115727099003)(261022113327099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026130827099003)(261026135527099003)(261026121527099003)(261022105027099003)(261021130227099003)(261022075727099003)(261021133027099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFp6bCtnMlM1Sm9GZmNDd2M5cDNZanZiL255RnlUOXh4WFJYbHd5am03WjBN?=
 =?utf-8?B?R1BQVWl2OXNTUFprRnNWT2NIOXREejZielMrazF4OTFnMEdxTmNHZzU4dEF6?=
 =?utf-8?B?RThraXF3aFMwK25aOEVTbmlSc2VsS3JPTmVxSHdrdnowdWJNTzJyYUNZV1My?=
 =?utf-8?B?QkFNaUMrS05zbVlzSVlFaVN0emQvRWJ4VmxxVVNQQUNSSG5iSzVlTHVFWjcy?=
 =?utf-8?B?cXNxVms1MTgzbU1FdmNJWXNQZDArQUxnblRIKzJEODRLbHJVOG90TFh4Y0xO?=
 =?utf-8?B?YTNZNUxDc0t2RU1DS21FUmVoRW1HTG9lcDI4aWtRdWhLTlJrMkE3QXNwbGFa?=
 =?utf-8?B?NVpScGlsY3lJUjZUdTFNZFUxZzlNYnFzQXVteWg5ZmUyMWRXSTdJYUFJM3dk?=
 =?utf-8?B?OTg4UFNwY25CQUYwRjRENmNpVWw1djRFU3p2MUNLQ0pGZXRTVmU2Z1RwVEpp?=
 =?utf-8?B?UmdBdmxoMCtncUpzMmpETElUMmVjK1QyRTJ6eVpMZGlMcnd1b1pBK0RRc0th?=
 =?utf-8?B?TWQ2WE1TZk4vUFNtOGNLeG91dm5Lc3ZjZUJVdXgzLzhCSlluZFh3eThsTFRY?=
 =?utf-8?B?MXJ5R0VLOGVVTlJJSC81Rjc2ZHJHRVIwQk9TSG1oWWNJZlJlTUdFR2tXRzlI?=
 =?utf-8?B?ekt1VlFyUEd1SmVpZlBGM1lneHdDMXNZNmRtNENMNG9xdmJaUkdhTXdVQXlD?=
 =?utf-8?B?dTQvUlB2S1prVVRmdUFTSDVPT1IwcW5BR1FFU2RUcWMzYXNseDk1eVV1QXhO?=
 =?utf-8?B?TFJuQlRXWXJCR3lkQzdjR2w1em5WWkRQUDIrQ054ZUFZeTJ4RTY1QjdGcG4x?=
 =?utf-8?B?Q2hVM1dzYmt5UlZjaFYrNEhpaVgxSmNZSkZCeFJjT3IvbGxXNGYzRXkweTkz?=
 =?utf-8?B?YkVDM2VqVk83cnNmRXNSemI4Y2YwOVl5bEsxNDh5ZmZNRHRucWRwc2ZzdGxD?=
 =?utf-8?B?ZVVoYkl4M2hYbFVGZ29aeHNjTUJJT1k5amhaVExFK2RRVytUNzZzYzNpVGlO?=
 =?utf-8?B?TFlXekZ6SG5iWFQ1bUQxTFowWjVXNWl6Sm9LQXNLUk0zNndRdlFRZVRkVXc4?=
 =?utf-8?B?ODFCM2ZUcUI3aFFiY0FGRkpwMDJtRDI3T25IU1Bpa2VZbXNsQ1BNS29yTmFF?=
 =?utf-8?B?ckYyZ1Y3T2pUN1hlQVBYd2owcnRmMWY0bkV2YU81TWx5cW9FUHZsMzg5V2ZL?=
 =?utf-8?B?NDh5RFVhVU9lWTZSZVNTU092RWFSajNiMjRWYnRnU2JKTW9DNVZSQVlSZnlk?=
 =?utf-8?B?TDcxZCtjTHY0TnhYcWVaV0c0b2R2VkhCdE5NMDNQamY2dzNMTld3K25lL0g2?=
 =?utf-8?B?aDhJOVdwU01sdzh3dnNXOGs1SnVGZ2JKYTlRVEo4WEhJWThhQTRLRHVoazM3?=
 =?utf-8?B?bjJ4ckdrYUxLWEdLa0UvcXlVcnRYM1NMU2JFV0IwWEhBTWl1aFNaRjNtSnV0?=
 =?utf-8?B?Ny9saFQ5SGI3VnhlbmxoQTA4ZTdtZjhGWU5kcnNOdXFUL2pPc3Q4dm1FZUt1?=
 =?utf-8?B?LytjajdIOFljMkwxU1l6V2JDcWwyUzlwK3NYUEV0bXFZcHhtbFNnNWJEQmZt?=
 =?utf-8?B?SUVKaVExOHY4STJQcWJjK3lxWm5wbGgwOWxMNWt3K2oxVndvOFBCMXI1dVdT?=
 =?utf-8?B?c2pGYk5HalEwQmQ4NkoxNXU0N3pqbnFSUDBtb1dzMHdyZTNkMWFLL0wvQzVM?=
 =?utf-8?B?QUE3d044WFdOb3ZoQ1RPZDFPcjRhdWxpN2gzZXNLV24rUlJMMHM1akFSK1hV?=
 =?utf-8?B?Yi8zblFPZXpmNjFiWnYwbWx0Zzh3Z29JbUJWRkVZZERXRTJRVkw4L01EM2ZH?=
 =?utf-8?B?czhLYjNnalZiVysxVWlvQTJTZjB5WlZJQ0dNM3VYaDVDYUdvVU15czJFbjJV?=
 =?utf-8?B?RlZXOUxNUFM5ZThmQmhuNlRnUHd3OHovamJTZ2dKdFJVL2Z4OXYyZkZEb1JW?=
 =?utf-8?B?OXZhNDJ6ZkVXQ0p1dkhVeU9yc3lHOFZ5UWRMZEtFN1hpVy9hTHBRK2QvaDMx?=
 =?utf-8?B?WUNpaTAwNkI3Ry9zbDYwNUFSdjlQNmxWTlAyZFNnQkJQWGpwYnRuNG1Fc3Ft?=
 =?utf-8?B?alhaZEtlWU90aThRMVc1dXdzVGVFNmZEdm5xeU5JUHVXclNqeUg3R2VnWTFh?=
 =?utf-8?B?eGl2UXppV05sR0UvVUM5bmtBenNSK0dOWWIyeVJYczVJcEF6aE5vRUpSVnlo?=
 =?utf-8?B?OXMwUVdvZWJmQ2E0U01FYThZTHMyOGV6eVlhNU1iMWw1dkwzbjgzZ2pmaWps?=
 =?utf-8?B?TkNmRjVRK3FQUzFsNWJHTklleXVhNmYrSy9UcDgwZWgxeFIxSGlVZWJCVk9x?=
 =?utf-8?B?SjExZk1uVkRuTGpVTHBENDZxVWJiQ0QreUE4bWoxRDhyMEJTVzZIQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f29f4a76-4c12-491c-e34f-08df4411c174
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:45:16.2357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtdYZrTFrFxuNez6TAUtHCrZukcJV5h0h76OBUL2u+hynsozH4fWQDJcPgUqvsfBEK/XyCCHtgp9g1zKHAuaE3O8latjnwybSkj/qAFAfIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9834
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgRGF2aWQsDQoNCk9uIDExLzE2LzI2IDY6MTcgUE0sIERhdmlkIExlY2huZXIgd3JvdGU6DQo+
IE9uIDExLzE0LzI2IDM6MTYgQU0sIFBldGVyIFJvYmluc29uIHdyb3RlOg0KPj4gSGkgRGF2aWQs
DQo+Pg0KPj4gICAgICA+IEFueW9uZSB3aG8gaGFzIHdvcmtlZCBvbiBoYXJkd2FyZSB0aGF0IHVz
ZXMgYSBkZXZpY2V0cmVlIGZvciB0aGUNCj4+ICAgICAgPiBoYXJkd2FyZSBkZXNjcmlwdGlvbiBz
aG91bGQga25vdyB0aGUgbWFudHJhICJ0aGUgZGV2aWNldHJlZSBkZXNjcmliZXMNCj4+ICAgICAg
PiB0aGUgaGFyZHdhcmUsIG5vdCB0aGUgY29uZmlndXJhdGlvbiINCj4+DQo+Pg0KPj4gVGhhbmsg
eW91IGZvciB0aGlzLCBJIG5ldmVyIGFncmVlZCB3aXRoIGRlc2NyaWJpbmcgdGhlc2UgaW4gdGhl
IERUIGF0IGFsbC4NCg0KV2UgcHJvYmFibHkgc2hvdWxkIGRvIHNvbWUgZGlnZ2luZyBvbiB0aGUg
bWFpbGluZyBsaXN0IGJlY2F1c2UgSSBiZWxpZXZlIA0KdGhpcyB3YXMgYnJvdWdodCB1cCBiYWNr
IHRoZW4uIEkgYWxzbyBkaXNhZ3JlZSAobWFpbmx5IGJlY2F1c2UgdGhlIExpbnV4IA0Ka2VybmVs
IHdpbGwgbmV2ZXIgYWdyZWUgdG8gdGhpcyBpbiB1cHN0cmVhbSBEVCwgc28gdGhpcyBwcmV2ZW50
cyB1cyBmcm9tIA0KdGhlIGRyZWFtIG9mIHJ1bm5pbmcgcHJpc3RpbmUgRFQgZnJvbSB1cHN0cmVh
bSkuIEkgdmFndWVseSByZWNhbGwgdGhlcmUgDQphcmUgYSBmZXcgdGhpbmdzIHRoYXQgYXJlIGJp
bm1hbi1zcGVjaWZpYyBhbmQgYXZhaWxhYmxlIGF0IHJ1bnRpbWUgYnkgDQpwYXJzaW5nIHNvbWUg
c3R1ZmYuIEl0J3MgdmVyeSB2YWd1ZSwgYmVjYXVzZSBJIGRvbid0IHJlbWVtYmVyLiBCdXQgSSAN
CndvdWxkbid0IGRpc21pc3MgYmlubWFuIHVzZSBvZiB0aGUgRFQgYXMgc2ltcGx5IGJlaW5nIGEg
Y29uZmlndXJhdGlvbiANCmZvcm1hdCwgSSBiZWxpZXZlIHdlIHVzZSBzb21lIG9mIGl0cyB0aGlu
Z3MgYXQgcnVudGltZSB0b28uDQoNCkVESVQ6IGFoIEkgc2VlIG5vdyByZWFkaW5nIHBhdGNoIDYv
MTAgdGhhdCB5b3UncmUgYXdhcmUgb2YgdGhhdC4gQnV0IA0KcGhldywgaXMgaXQgcmVhbGx5IHdv
cnRoIGl0IHRvIGRvIHRoaXMgaW5jb21wbGV0ZSBzcGxpdD8gSSBmZWFyIHdlJ2xsIA0Kc3BsaXQg
dGhlIGVjb3N5c3RlbSBvbmNlIG1vcmUuDQoNCj4+ICAgDQo+Pg0KPj4gICAgICA+IEJpbm1hbiBp
cyBkZXNjcmliaW5nIGNvbmZpZ3VyYXRpb24gYW5kIG5vdCB0aGUgaGFyZHdhcmUgaXRzZWxmLA0K
Pj4gICAgICA+IHRoZXJlZm9yZSBpdCBkb2Vzbid0IGJlbG9uZyBpbiB0aGUgY29udHJvbCBkZXZp
Y2V0cmVlIHRoYXQgZGVzY3JpYmVzDQo+PiAgICAgID4gdGhlIGhhcmR3YXJlLiBTbyB3ZSBwcm9w
b3NlIGVuY291cmFnaW5nIHRoZSBzZXBhcmF0aW9uIG9mIHRoZXNlIHR3bw0KPj4gICAgICA+IGRl
c2NyaXB0aW9ucyBpbnRvIHNlcGFyYXRlIGRldmljZXRyZWUgZmlsZXMuIEluIG1vc3QgY2FzZXMs
IGJpbm1hbg0KPj4gICAgICA+IGluZm8gaXMgbm90IG5lZWRlZCBhdCBydW50aW1lIGFueXdheSwg
c28gY29tYmluaW5nIGl0IHdpdGggdGhlIGNvbnRyb2wNCj4+ICAgICAgPiBkZXZpY2V0cmVlIGlz
IHVubmVjZXNzYXJ5LCB0YWtlcyB1cCBzcGFjZSwgYW5kIGNhdXNlcyBEVFMgdmFsaWRhdGlvbg0K
Pj4gICAgICA+IHRvIGZhaWwgYmVjYXVzZSBiaW5tYW4gaXMgbm90IHBhcnQgb2YgYW55IHN0YW5k
YXJkIGRldmljZXRyZWUgc2NoZW1hLg0KPj4NCj4+DQo+PiBUaGlzIGlzIGdyZWF0LCBhbmQgSSBs
b29rIGZvcndhcmQgdG8gdGhpcyBsYW5kaW5nLg0KPj4NCj4+IEZvcndhcmQgbG9va2luZyBhbmQg
anVzdCBhIGxpdHRsZSB0aGlua2luZyBvdXQgbG91ZCBoZXJlLCBmb3J3YXJkIGxvb2tpbmcgaXMg
dGhlIGRldmljZSB0cmVlIGZvcm1hdCB0aGUgbW9zdCBzdHJhaWdodCBmb3J3YXJkIHdheSB0byBk
ZXNjcmliZSB0aGUgcmVxdWlyZW1lbnRzIGZvciB0aGlzPyBJIHdvbmRlciB3aGV0aGVyIHNvbWV0
aGluZyBsaWtlIHRvbWwgb3IgZXZlbiB0aGUgaW4gdHJlZSBlbnYgZm9ybWF0IFsxXSBtaWdodCBi
ZSBiZXR0ZXIgc3VpdGVkPw0KPiANCj4gSSB3YXMgaGF2aW5nIHRoZXNlIHNhbWUgdGhvdWdodHMu
IEFuZCBpZiB3ZSB3ZXJlIHN0YXJ0aW5nIGZyb20gc2NyYXRjaCwgeWVzDQo+IEkgd291bGQgaGF2
ZSBhZHZvY2F0ZWQgZm9yIGEgZGlmZmVyZW50IHNvdXJjZSBmaWxlIGZvcm1hdCBhcyB3ZWxsLiBD
aGFuZ2luZw0KPiBpdCBub3cgdGhvdWdoIHdvdWxkIGJlIHF1aXRlIGRpc3J1cHRpdmUgdG8gdGhv
c2UgZGVwZW5kaW5nIG9uIGl0LiBJIHRoaW5rIHdlDQo+IHdvdWxkIG5lZWQgc29tZSBtb3RpdmF0
aW9uIG1vcmUgdGhhbiAiZGV2aWNldHJlZSBpcyBub3QgdGhlIGJlc3QgY2hvaWNlIiB0bw0KPiBq
dXN0aWZ5IGNoYW5naW5nIGl0IGF0IHRoaXMgcG9pbnQuIEFuZCBldmVuIHRoZW4gdGhlIGRldmlj
ZXRyZWUgZm9ybWF0IHdvdWxkDQo+IG5lZWQgYSBsb25nIHBoYXNlLW91dCBwZXJpb2QgdG8gZ2l2
ZSBwZW9wbGUgdGltZSB0byBhZGFwdC4NCj4gDQoNCllvdSBjYW4gYWx3YXlzIGhhdmUgYSBjb252
ZXJzaW9uIHRvb2wgZnJvbSBEVCB0byB3aGF0ZXZlciBmb3JtYXQgeW91IA0Kd2FudCBhcyBhIHdh
eSBvdXQuDQoNCj4gQXQgdGhlIHZlcnkgbGVhc3QgdGhvdWdoLCBpdCBjb3VsZCBiZSBuaWNlIHRv
IGV2ZW50dWFsbHkgbW92ZSB0aGUgYmlubWFuIGR0cw0KPiBzb3VyY2UgZmlsZXMgb3V0IG9mIHRo
ZSBhcmNoIGR0cyBmb2xkZXJzIHRvIG1ha2UgdGhlIHNlcGFyYXRpb24gbW9yZSBjbGVhci4NCj4g
DQoNCkkgbG9hdGhlIG1hZ2ljIHN0dWZmIGFuZCBpdCdzIGFscmVhZHkgY29uZnVzaW5nIHRoYXQg
LXUtYm9vdC5kdHNpIGZpbGVzIA0KYXJlIGF1dG9tYXRpY2FsbHkgYWRkZWQgYmFzZWQgb24gc29t
ZSBwYXR0ZXJucyAodGhhdCBtb3N0IHBlb3BsZSBhcmUgDQp1bmF3YXJlIG9mLCBoZW5jZSB0aGUg
YnVuY2ggb2YgLXUtYm9vdC5kdHNpIGZpbGVzIHRoYXQgb25seSBpbmNsdWRlIA0KYW5vdGhlciAt
dS1ib290LmR0c2kgZmlsZSkuIFNvLCBmcm9tIHlldCBhbm90aGVyIGxvY2F0aW9uPyBEb24ndCBr
bm93IGlmIA0KaXQncyBhIGNsZWFyIHdpbiBmb3IgdXNlciBleHBlcmllbmNlLg0KDQo+Pg0KPj4g
VG8gYmUgYWJzb2x1dGVseSBjbGVhciBoZXJlLCBJIHRoaW5rIHRoaXMgc2VyaWVzIHNob3VsZCBw
cm9jZWVkIGFuZCBJJ20gbm90IG5lY2Vzc2FyaWx5IGFza2luZyB5b3UgdG8gZG8gaXQsIG1vcmUg
anVzdCBnYXRoZXJpbmcgaWRlYXMvb3BpbmlvbnMuDQo+Pg0KPj4gUGV0ZXINCj4+DQo+PiBbMV3C
oGh0dHBzOi8vZ2l0LnUtYm9vdC1wcm9qZWN0Lm9yZy91LWJvb3QvdS1ib290Ly0vYmxvYi9tYWlu
L2JvYXJkL3Jhc3BiZXJyeXBpL3JwaS9ycGkuZW52P3JlZl90eXBlPWhlYWRzIDxodHRwczovL2dp
dC51LWJvb3QtcHJvamVjdC5vcmcvdS1ib290L3UtYm9vdC8tL2Jsb2IvbWFpbi9ib2FyZC9yYXNw
YmVycnlwaS9ycGkvcnBpLmVudj9yZWZfdHlwZT1oZWFkcz4NCj4+ICAgDQo+Pg0KPj4gICAgICA+
IEN1cnJlbnRseSwgb25seSBYaWxpbnggaXMgZG9pbmcgdGhpcyBraW5kIG9mIHNlcGFyYXRpb24u
IFRoaXMgc2VyaWVzDQo+PiAgICAgID4gbWFrZXMgaXQgcG9zc2libGUgZm9yIG1vcmUgcGxhdGZv
cm1zIHRvIGFkb3B0IHRoaXMgc2VwYXJhdGlvbi4gVGhlIGZpcnN0DQo+PiAgICAgID4gcGF0Y2hl
cyBmaXggYmlubWFuIHNvIHRoYXQgdGhlIGltYWdlIGdldHMgdGhlIFUtQm9vdCBjb250cm9sIGRl
dmljZXRyZWUNCj4+ICAgICAgPiByYXRoZXIgdGhhbiB0aGUgYmlubWFuIG9uZSB3aGVuIHRoZSB0
d28gYXJlIHNlcGFyYXRlIGJpbmFyaWVzLiBBbmQgdGhleQ0KPj4gICAgICA+IG1ha2UgQklOTUFO
X0RUQiB3b3JrIHdpdGggT0ZfVVBTVFJFQU0sIGFuZCBkb2N1bWVudCB0aGUgcmVjb21tZW5kYXRp
b24uDQo+PiAgICAgID4gVGhlIHJlbWFpbmluZyBwYXRjaGVzIHVwZGF0ZSB0aGUgTWVkaWFUZWsg
R2VuaW8gdGFyZ2V0cyB0byBtYWtlIHVzZSBvZg0KPj4gICAgICA+IGFsbCBvZiB0aGlzLg0KPj4g
ICAgICA+DQo+PiAgICAgID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJA
YmF5bGlicmUuY29tIDxtYWlsdG86ZGxlY2huZXJAYmF5bGlicmUuY29tPj4NCj4+DQo+PiAgICAg
IE15IG1vcmUgZGlyZWN0IGNvbmNlcm4gd2l0aCB0aGlzIHNlcmllcyBpcywgd2hvIGhhcyBzb21l
IHJldmlldyBjeWNsZXMNCj4+ICAgICAgdG8gc3RlcCB1cCBhbmQgY28tbWFpbnRhaW4gdGhpcyB0
b29sPyBJdCdzIGFscmVhZHkgYmVlbiBwcml2YXRlbHkNCj4+ICAgICAgc3VnZ2VzdGVkIHRvIG1l
IHRoYXQgd2UgY291bGQgZHJvcCB0aGUgbG9mdHkgIm9uZSB0b29sIGZvciBldmVyeSBwcm9qZWN0
DQo+PiAgICAgIHRvIHJlbHkgb24iIGdvYWwgc2luY2UgbW9zdCBwcm9qZWN0cyBjb250aW51ZWQg
dG8gZGV2ZWxvcCB0aGVpciBvd24gdG9vbA0KPj4gICAgICBmb3IgYXNzZW1ibGluZyBiaW5hcmll
cyBhbnlob3cuIEFuZCB0aGF0IGluIHR1cm4gcmVkdWNlcyB0aGUgc2NvcGUuIEJ1dA0KPj4gICAg
ICBpdCdzIHN0aWxsIGFuIGltcG9ydGFudCBwYXJ0IG9mIHRoZSBwcm9qZWN0IGFuZCBzbyBuZWVk
cyBzb21lIHBlb3BsZQ0KPj4gICAgICBsb29raW5nIGFmdGVyIGl0IHdpdGggYSBtb3JlIGdsb2Jh
bCBleWUuDQo+IA0KPiBJIG1pZ2h0IHJlZ3JldCB0aGlzIGFzIEkgYW0gYXMgb3ZlcndoZWxtZWQg
YXMgYW55b25lIGVsc2Ugd2l0aCByZXZpZXdzIHRoZXNlDQo+IGRheXMuIEFuZCB0aGlzIGlzIG15
IGZpcnN0IHRpbWUgdG91Y2hpbmcvdXNpbmcgdGhlIGJpbm1hbiBjb2RlIHNvIEkgZG9uJ3QNCj4g
a25vdyBtdWNoIGFib3V0IGl0IHlldC4gQnV0IGl0IHNlZW1zIGxpa2UgdGhpcyBpcyByZWxhdGl2
ZWx5IGxvdyB2b2x1bWUgYW5kDQo+IEkga25vdyBQeXRob24gdmVyeSB3ZWxsIGFuZCB0aGlzIHNl
ZW1zIGxpa2UgcHVyZSBzb2Z0d2FyZSBzbyBJIGRvbid0IG5lZWQNCj4gYW55IHNwZWNpZmljIGhh
cmR3YXJlIHRvIHZhbGlkYXRlIGl0LiBTbyBJIGNvdWxkIHRyeSB0byBoZWxwIGhlcmUgZm9yIHRo
ZQ0KPiB0aW1lIGJlaW5nLg0KPiANCj4gQXMgYSBmYWlyIHdhcm5pbmcsIEkgZG8gdGVuZCB0byB3
YW50IHRvIGJlIGEgYml0IGhlYXZ5LWhhbmRlZCB3aXRoIG15IG93bg0KPiBjaGFuZ2VzIHdoZW4g
SSBhbSB0aGUgbWFpbnRhaW5lci4gVGhlIGN1cnJlbnQgYmlubWFuIGNvZGUgbG9va3MgdG8gbWUg
bGlrZQ0KPiBKYXZhIHdyaXR0ZW4gaW4gUHl0aG9uIDIsIHdoaWNoIEkgZmluZCBhIGJpdCBwYWlu
ZnVsIHRvIHJlYWQuIEkgd291bGQgd2FudA0KPiB0byAiY2xlYW4gaXQgdXAiIHdpdGggbW9kZXJu
IGF1dG9tYXRpYyBjb2RlIGZvcm1hdHRlcnMgYW5kIGxpbnRlcnMgYXMgd2VsbA0KPiBhcyBhZGQg
dHlwZSBoaW50cyB0byBtYWtlIGl0IGVhc2llciBmb3IgbWUgdG8gcmVhZCBhbmQgdW5kZXJzdGFu
ZCBzbyB0aGF0IEkNCj4gY291bGQgbWFpbnRhaW4gaXQgd2l0aCBsZXNzIGVmZm9ydCBhbmQgYWxz
byB0byBmaW5kIGxhdGVudCBidWdzLg0KPiANCg0KUGxlYXNlIGJlIG1pbmRmdWwgb2YgdGhlIG1p
bmltdW0gUHl0aG9uIHZlcnNpb24gd2Ugc2hvdWxkIHN1cHBvcnQuIEkgDQp0aGluayB3ZSBzdGls
bCBzdXBwb3J0IE9wZW5TU0wgMS54IGZvciBleGFtcGxlIChhbHNvIGJ5IHRoZSBmYWN0IHRoYXQg
DQppdCdzIHRoZSBpbnRlcmZhY2UgdXNlZCBieSBMaWJyZVNTTCBJIHRoaW5rPykuIEkgaGF2ZSBu
byBjbHVlIHdoYXQgDQp2ZXJzaW9uIG9mIFB5dGhvbiB3ZSB3YW50IHRvIHN1cHBvcnQsIGJ1dCB3
ZSdyZSB0eXBpY2FsbHkgc3VwcG9ydGluZyANCnN0dWZmIHdlbGwgcGFzdCB0aGVpciBlbmQgb2Yg
c3VwcG9ydCBkYXRlLg0KDQpUaGUgY29kZSBpcyBleHRyZW1lbHkgY29udm9sdXRlZC4gRm9ydHVu
YXRlbHksIHRoZXJlJ3MgZ29vZCB0ZXN0IA0KY292ZXJhZ2UsIHNvIGRvaW5nIGluY3JlbWVudGFs
IGNoYW5nZXMgYW5kIHN0aWxsIGhhdmluZyB0aGUgdmFyaW91cyANCnRlc3RzIHBhc3Mgc2hvdWxk
IGhlbHAgcmVmYWN0b3Jpbmcgc3R1ZmYuDQoNClR5cGUgaGludHMgd2lsbCBiZSBhbiBpc3N1ZSBh
cyB0aGVyZSBhcmUgc29tZSAobm90YWJseSBsaXN0KSB0aGF0IHdlcmUgDQphZGRlZCBvbmx5IGlu
IHZlcnkgcmVjZW50IHZlcnNpb24gb2YgUHl0aG9uLg0KDQpXaGF0IEkgd291bGQgbGlrZSB5b3Ug
KG9yIGFueW9uZSkgdGFraW5nIG92ZXIgQmlubWFuIHRvIGRvIHdvdWxkIGJlIHRvIA0KYWN0dWFs
bHkgZG9jdW1lbnQgaG93IGJpbm1hbiB3b3JrcyBpbnRlcm5hbGx5LCBub3Qgb25seSB0aGUgdXNl
ciANCmludGVyZmFjZS4gSXQgY3VycmVudGx5IHRha2VzIHRvbyBsb25nIHRvIGV2ZW4ga25vdyBo
b3cgdG8gc3RhcnQgDQpwYXRjaGluZyBCaW5tYW4sIHdoaWNoIG1ha2VzIHBlb3BsZSB1bmFibGUg
b3Igbm90IHdhbnRpbmcgdG8gZ2V0IA0KaW52b2x2ZWQgd2l0aCBCaW5tYW4gYXQgYWxsLCBsZXQg
YWxvbmUgcmV2aWV3IG9yIG1haW50YWluIGl0LiBJIGZvciANCmV4YW1wbGUgZGlzY292ZXJlZCB0
aGF0IEJpbm1hbiBnZW5lcmF0ZXMgZm91ciB0aW1lcyB0aGUgc2FtZSBpbWFnZSwgYy5mLiANCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3UtYm9vdC8wNGZkMDBmNC0xYmI2LTRhMjktOGUxZS04M2Nk
YzFiMDNiNzRAY2hlcnJ5LmRlLyANCmFuZCBJIGNvdWxkbid0IGZpZ3VyZSBvdXQgcXVpY2tseSB3
aHkgc28uDQoNCj4gSSBhbHNvIHNlZSB0aGVyZSBpcyBhbiBhY3RpdmUgZm9yayBvZiBiaW5tYW4g
YXQgWzFdLiBTbyBJIHdvdWxkIGJlIGluIGZhdm9yDQo+IG9mIGxldHRpbmcgdGhhdCBiZSB0aGUg
YW1iaXRpb3VzIHByb2plY3QgYW5kIHRyaW1taW5nIGRvd24gdGhlIGluLXRyZWUgY29kZQ0KPiB0
byBvbmx5IHdoYXQgVS1Cb290IG5lZWRzLg0KPiANCj4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20v
ZGVpbmRlLWRldi9iaW5tYW4NCj4gDQoNCkZZSSwgZGVpbmRlLWRldiBpcyBtYW5hZ2VkIGJ5IFNp
bW9uLg0KDQpDaGVlcnMsDQpRdWVudGluDQo=
