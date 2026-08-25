Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C87C61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 14:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D852E80CC5;
	Tue, 25 Aug 2026 14:26:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iHt-8AixF5BV; Tue, 25 Aug 2026 14:26:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787667981;
	bh=xSfL7Pz8uie1XdWpryDqw6ZHwfqQ7eoQWcG0xDzP/g0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R/E7xECj8dw1jh74Pb/Ovuue4x/KpNG8OG93GHEgdA1tgSA74hgOMhtQElNL8i6z8
	 M3XnExtXKCaUdBdjfnAwYSbxJWo/G2A+7deE1EdOba+pGgus3+8w0LKMNK7QK1BA5V
	 UgXpj/ErmuuZ1AuWoNQ6S2kEsLGcdMFRMgsHrrTuEOHqGUqQjz35yYtTNEzcbah54b
	 Pzjhsvpi3VUWs9q9dnP6F9cY97Y1HRdC2LSP7w+y5E81AnAs/58dk29C6m5wnTH7QS
	 YN6mrRPOZPTwTazT76iTw3cCJU5UhfWC6RkolYqJWJk0TVXR91mSDcwQb8Go/BSrkW
	 kFErwrFpqAftQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C47D580CA6;
	Tue, 25 Aug 2026 14:26:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BDD931465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B036B400F9
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIoyp8uAXLNH for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 14:26:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=B0e0fZ/5
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D82840092
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 14:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEvLXNqWzJDV71DXD2OfMpTsztQA3faXGYmPZQN6RyuRSy0NWtDb76WBTAfmm83WQErIVhup0BG449EgsKmpabCkGiJd8IJjwYa0wAH+nBK1pKmMvLjf3s0VhDE57x5DnQ09Lev5MwaQTu2GuP7rJ9f6PdQMFgHm/Nn5kJAXt0WTyb78Q5KIKKynIusEnfaS3jXYsKI9E8CUAyIKpkJddNLr5/oRckLPoKPj+PzvDbcgbBrSfvCRKjmU307o8yY7tkzHjsYWHDzO10mmu66zbwkutIOOBEo5Hyraww3iEG0H78lLw+bdMdbCczPlxRkcAbNjpSzM0CUP0MtD6so2Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSfL7Pz8uie1XdWpryDqw6ZHwfqQ7eoQWcG0xDzP/g0=;
 b=lCPKpMyw5hL1dq+S+dSCX+Ss6ASgte2tmZCWTLMs2MPehTTJE4Qx24wjI/fOw60XvvVUzM3wIPvH2g7zqzuIAHtLn6HRV4I6dBtGhzDn1sGBtOtM4ckLqpWGpa0mwhibvgdojdbclveNuYnyYL1qyaXzmiiO+1tZKhmP79BbcQBBA8vIXxMICNq+9Wz5RH5LEBJJJLJaB+5AfWxq7MF6dGSQhrsOSYYWdcJ/AiVAL3Jh2JwS+LGrlr39Wm5tZdNHH4sxF+bjemhXdNg/ewrVyrMfweB0xNdtOMWjNq7VhXodKWRoN63JoxhRQ+Mk4JP/flTTA9bMfZ7LQS7Ph1q3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSfL7Pz8uie1XdWpryDqw6ZHwfqQ7eoQWcG0xDzP/g0=;
 b=B0e0fZ/5/9OWIv1h6kP9YdG2p+Ki0Wxhvta3icik1gYMaURQct85fIUgcwYxnrqRv1rI9UFdqe+5al0RNzSEVoNNXnExaLcqygJiZSob9uGUr0A+kArtAGFCI2WscDrkiox48b1fdj48eR+oj7K1lT9UrdywBUbZbrTLzUBUBz/lxlho77YvVnK2vcNTuw985xdSshrVtzjcKwdFG0im+W0+dPtAdYwbul2CWvjBv0kjg6cBRdvQfszhe7nZzCiDXm16EvVBDkbcBHVYJ+oB1iQCEdSEqBiralJZopnd7orW/I5W453xyyoqBYenx+XTaDCNVVO16qo4x1Lh3YrIbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GVXPR10MB8632.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 14:26:09 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:26:09 +0000
Message-ID: <d27975a2-e287-4701-a695-881fa3c9a3c1@kontron.de>
Date: Tue, 25 Aug 2026 16:26:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] arm: mach-k3: introduce basic support for the
 AM62L
To: Bryan Brattlof <bb@ti.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aristo Chen <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::14) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GVXPR10MB8632:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d28d088-7678-484c-4ee7-08df02b4ce63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: DSA/uadbEzkTSl8oCjN9UnBe+CLKw+s16LXYGtI8lydrv8hHiltS3/pP8xOe4cO6abMlKjbzEeQmcIPi4RlJC9iwDjsPTryJo266YdVRqmI5FQbotPz0gH7i4xJDH/Haq1Prk+5vvW2gh06CwUoNvKRnfPBjZ0XvvAe9ij5uUQTqtRM7uc55PAfbjEyztUIWQOK0V8Gndz9znLExZfRqrF/LKroC0LlB3OX61Ja0CKsHHC8SrznEnqN+nU8pESZuure9VgOK/63toB7mY9Y4LudxQ2d0WZ/8mpPgTFurHX26TLFU82hx0VIaWZ9/YaxZ6Rsg+92uoMYGeFpte0/QW+4AUXrZyQZ+Z12eO7NOr/hOKf+ryCj4ziXn1JC6VL/WCHW53vE7FRqVYFwtuKMqh3BCbT1pMZAeS8NhANf2qP4RQuxnEiP60RtvcKQpT9iWp/CN+X9XsdtdU+64Y4uZXkz3NjxdIA0ZItnB0ieS6cCbl/1Rdj9dkjGdcarJPl5R/4ANxblQNVNlkk2IrbImy/2BOHoUwQXkcbTW+mhK1FeMnBKku4OXL8KPI3V+WF7v8q5ZIumhPc7rYl2lVJeHJRTclSHFDGp0Cn4R9gEUcE1z+4N9ytgu9bLuWMQair5o
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0RvaWpiMEgrYlV2aFRzT2FLanlKd1lNOEorWVNKZHFmVGdSOTkrU0pQZEhX?=
 =?utf-8?B?ZlFJRTQweHZnc1R2N0pIQklBK1NPVlhBOFBDb1gxUmwxdWI3Y2ptcElaWE9H?=
 =?utf-8?B?cytiSGZ2RUNGRUpNUW4rTklrcWM1bzlNMjNORnk5MnNFanhGaFNybHpRbWNB?=
 =?utf-8?B?Vkx4VmsxV05PUEk0ODN3d1ZIWW9DdW5PaTlBVUdvRHkxQzRJQ1lyVkN4WFZI?=
 =?utf-8?B?QXI3d2Y3YlVsdHk4eER1djQ2VUR0cWx3VFJncWJiSzlYUTBwRGpaeGJBMVpG?=
 =?utf-8?B?YlpVc3h0aEtIRFRwdlhqZkJaRHBsK1lrNHRtQUVLb25wOCtuQ3kyRXdKMzgr?=
 =?utf-8?B?bEpUSk4zOGV3eWxHeEo2T0hrb2tLQytsMVplWjJmZ2tNaFRQQzkzcjBBTGZo?=
 =?utf-8?B?NFN6ZHVXRlUxYXhWTjRaRnZySkdqZ3JFYmlGRCs5WFpxQm12TzYxeEc3a2t0?=
 =?utf-8?B?dUFqd0F0TmttM2xkRzgxUWlhMG92ZUZTK0FQRTVVcm1WS2Y0cUhBbEZhbUhl?=
 =?utf-8?B?UURpMHA3cHdrVFFRUFBvNm1jZERocUFDRWF3VFBiTDI5RnZOYThUZVFqaHRn?=
 =?utf-8?B?aDkvekxONEtWK0JaUTZEOFA1NFBRa0JoMHFrV3ZId0lFNC81czhxaVN6dUlr?=
 =?utf-8?B?cW1OeGtrcG9VTmtOMlZYaldBeVNXUnZGQTJxT2kycFRYSXBETmtEVE04NkRF?=
 =?utf-8?B?UkM0T3lkUDltYlJGZEp0ZlJxYmQ5RDdKYURQK1FLSnlYNVZhSG9lTkdYNHpY?=
 =?utf-8?B?cHVuQnFpMm8rNVJKSzVqWjJPaHpOUHh4V0N4OGN6ZlpaaU9Fbml4cjQ3a3VM?=
 =?utf-8?B?QXM1OXRlbEFJMExlR0VuVTArTG9PTlcvcnJ1aEpFMTh1UUttU1NmZHhxaG1L?=
 =?utf-8?B?YzVJSHRGN3FVSWI5eCs1OVdzdGppUENZeTlGQ1dDdGtneXhpdzk0Q21udi9E?=
 =?utf-8?B?d25mNlo2M3NVcmErYStjV1h5WFNITG1pK0lnbFVtQmI3SWp5YW5XQkxPMTVM?=
 =?utf-8?B?aGpjWU1jRkFPZ29jTWp5Rm95d0JYbXdGaHpGUzUrNnA1QXB2dERIcTRYdU9j?=
 =?utf-8?B?UE5aTTBML3BaTTlHNFZWQ3NGVjc1MmRaUDVKQVI0YzRha2FTQ2pLei9leWV3?=
 =?utf-8?B?RXZKSU5Zclh0c1ZQbjA2OGord3JoVDdGVGR4TlMwcHZ3WUNYRDlNajF3Ym5M?=
 =?utf-8?B?cnBIL21TaFFPSytIQVduWGZUZmc4d2FPOEUvUWhtOVM2TnF2aURVbTBGMnJK?=
 =?utf-8?B?aHliOGhTc0xRQW5NNkJXTGZSTmdzTHVCZ05IR1RSRmR1MURQTFBxZGQ0Zmd0?=
 =?utf-8?B?NDM3clZDN0xMNS9uZlJBZ216czV6MWQ2MDI4UG0xbFVlSVIxR1MzRzhxd2g2?=
 =?utf-8?B?TldlUEFEaVVFRVpOa1A4d3ZwZ3RrNXpxbi83dVVPdkcrRWxLSlZRUTgzdk9G?=
 =?utf-8?B?ZnVwRVpIcExnNURXKytqY05OZWFzMTR0UEJPdkFpYmdMVWZTTUFMcVUxc2pN?=
 =?utf-8?B?UjFQVWthZUtYWnFKL0ZISEs2Y2NRM0FlMEl2cW9MdlVQM21KLzlUUHltZmhC?=
 =?utf-8?B?djlhTElLT0hLV0t2cTRqckVvVVBjU05CVVJGb2pRcGFjcFNlT3oyOXR1Y2pt?=
 =?utf-8?B?emZPWUpxdlFuU1pqUnB2UUduZkdtcFFXTHFsd1BxU1orbkhpRkRJWjRFU0k2?=
 =?utf-8?B?QXN4K0IvQTU5SkU0cUhGUEVVcXIvK3BSaCtNejRrSGsvSVlwa1pWWDZEdGJa?=
 =?utf-8?B?Rm5neEVVQTRmL2l4QXVCMGp2K3BVeXJXTkVhYmhWMmVEVnJJVk53clcvQUhW?=
 =?utf-8?B?M3pCNzBtNXN5MVN2NVF2bjdRTnhXWC9JNDgwZnRyTkE0dlNOZ3h6aUQwQUtG?=
 =?utf-8?B?cElISjJBWU9RVW8rSW9CbFp5SFREbVJybU5mc2o2MTBoT0RJL2pRbTlqZlhr?=
 =?utf-8?B?SnI4ZC9wMzYzc2oyUlN1S2xGeGpZREZWTDlmUHRjWjVWZEgrc3Z1K3p3ckRK?=
 =?utf-8?B?ejFlS01VZnY3TzYrSlNVandJWTJCWS9SQ0lXWnFjdkJKeE45cGdUYTBNMmFj?=
 =?utf-8?B?OEw0NC8xbW9aRUI4Y2UzdFEvNzlVcndmeU9GL1A0MjFydzhSTmVsQUFiRUJr?=
 =?utf-8?B?MTRaWDVKOEJmSkNlZmpzeHN2NDVHS1ltanZXM0ZVUTlOa3lCWjZVMm1DS1Zl?=
 =?utf-8?B?WVdkdVhLODlQS2RaeHh2YmV4SEpEYi9tdDQ2SEpWdUpKS0JJckZXajk5WlA4?=
 =?utf-8?B?NkhtdVVqakZpVEtqeHdpZ1NRUTNzS2lPV1B0MTlUOTJwVUU0MVREbjJWdHA0?=
 =?utf-8?B?dE1samRRN1ZNZ0J0VFZzUXBDVVZuWFlWaTcxaUVFanloMG5lbUpINlRmZkVz?=
 =?utf-8?Q?i3wghSAKsV7hLHEM=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d28d088-7678-484c-4ee7-08df02b4ce63
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:26:09.1710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R+0y89gqNB0wA5AWgmNkhu18omoahjpSKQF+Y3EOrocZ+ceMbBxqfg0O3cu6mtTe+kfC9ukT4HxPxZRWspOysNCtUdXBq/pQ9MluQUA/qMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8632
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

On 04.08.26 23:54, Bryan Brattlof wrote:
> Hello Everyone,
> 
> This series adds the initial support TI's AM62L SoC family along with
> the AM62L-EVM reference board.
> 
> The AM62L is a lite, low power and performance optimized family of
> application processors that are built for Linux application development.
> AM62L is well suited for a wide range of general-purpose applications
> with scalable ARM Cortex-A53 core performance and embedded features such
> as: Multimedia DSI/DPI support, integrated ADC on chip, advanced lower
> power management modes, and extensive security options for IP protection
> with the built-in security features.
> 
> Additionally, the AM62Lx devices includes an extensive set of
> peripherals that make it a well-suited for a broad range of industrial
> applications while offering intelligent features and optimized power
> architecture as well. In addition, the extensive set of peripherals
> included in AM62Lx enables system-level connectivity, such as: USB,
> MMC/SD, OSPI, CAN-FD and an ADC.
> 
> AM62L is a general purpose processor, however some of the applications
> well suited for it include: Human Machine Interfaces (HMI), Medical
> patient monitoring , Building automation, Smart secure gateways, Smart
> Thermostats, EV charging stations, Smart Metering, Solar energy and
> more.
> 
> Some highlights of AM62L SoC are:
> 
> - Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
>   1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
>   of two external
> 
> - 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
> 
> - Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
>   DPI (24-bit RGB LVCMOS)
> 
> - Multiple low power modes support, ex: Deep sleep and Standby
> 
> - Support for secure boot, Trusted Execution Environment (TEE) &
>   Cryptographic Acceleration
> 
> For more information check out our Technical Reference Manual (TRM)
> which is located here:
> 
>     https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> 
> Happy Hacking
> ~Bryan

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de> # Kontron
OSM-S AM62L
